#include "player.h"
#include "playlistmodel.h"
#include <QMediaService>
#include <QMediaMetaData>
#include <QObject>
#include <QFileInfo>
#include <QTime>
#include <QDir>
#include <QStandardPaths>
#include <QDebug>
#include <cstdlib>
#include <ctime>

Player::Player(QObject *parent)
    : QObject(parent), m_shuffle(false), m_loop(false),m_volumeLevel(0)
{
    m_player = new QMediaPlayer(this);
    m_playlist = new QMediaPlaylist(this);
    m_player->setPlaylist(m_playlist);
    m_playlistModel = new PlaylistModel(this);
    connect(m_playlist, &QMediaPlaylist::currentIndexChanged, this, &Player::currentIndexChanged);
    // Khi bài hát được chơi xong, signal này sẽ được phát ra. Connect signal này với hàm xử lí handleStoppedState
    // để quyết định bài hát tiếp theo được chơi hoặc lặp lại bài hát đó.
    connect(m_player, &QMediaPlayer::mediaStatusChanged, this, &Player::handleStoppedState);
    open();
    if (!m_playlist->isEmpty()) {
        m_playlist->setCurrentIndex(0);
        m_player->pause();
        m_isPlay = false;
        m_isOpenApp = false;
    }
    m_playlist->setPlaybackMode(QMediaPlaylist::Sequential);
    // Đặt seed - bộ sinh số ngẫu nhiên theo thời gian thực.
    std::srand(std::time(nullptr));
    m_player->setVolume(30);
}

void Player::open()
{
    QDir directory(QStandardPaths::standardLocations(QStandardPaths::MusicLocation)[0]);
    QFileInfoList musics = directory.entryInfoList(QStringList() << "*.mp3",QDir::Files);
    QList<QUrl> urls;
    for (int i = 0; i < musics.length(); i++){
        urls.append(QUrl::fromLocalFile(musics[i].absoluteFilePath()));
    }
    addToPlaylist(urls);
}

void Player::addToPlaylist(const QList<QUrl> &urls)
{
    // Dùng bên window
    #ifdef Q_OS_WIN
    QStringList sourceAlbumList;
    for (auto &url: urls) {
        QUrl url1(url.toLocalFile());
        QString filePath = url.path();
        // Loại bỏ dấu / đầu tiên nếu có
        if (filePath.startsWith("/C")) {
            filePath = filePath.mid(2);
        }
        TagLib::FileRef f(filePath.toStdString().c_str());
        sourceAlbumList.append(getAlbumArt(url1));
    }

    for (int i = 0; i < urls.size(); i++) {
        m_playlist->addMedia(urls[i]);
        QString filePath = urls[i].toLocalFile();
        // Loại bỏ dấu / đầu tiên nếu có
        if (filePath.startsWith("/")) {
            filePath = filePath.mid(1);
        }
        FileRef f(filePath.toStdString().c_str());
        Tag *tag = f.tag();
        Song song(QString::fromWCharArray(tag->title().toCWString()),
                QString::fromWCharArray(tag->artist().toCWString()),urls[i].toDisplayString(),sourceAlbumList.at(i));
        m_playlistModel->addSong(song);
    }

    // Dùng bên linux
    #elif defined(Q_OS_LINUX)
    for (auto &url: urls) {
        m_playlist->addMedia(url);
        FileRef f(url.path().toStdString().c_str());
        Tag *tag = f.tag();
        Song song(QString::fromWCharArray(tag->title().toCWString()),
                QString::fromWCharArray(tag->artist().toCWString()),url.toDisplayString(),getAlbumArt(url));
        m_playlistModel->addSong(song);
    }
    #endif
}

void Player::setshuffle(bool shuffle)
{
    if (m_shuffle == shuffle)
        return;

    m_shuffle = shuffle;
    emit shuffleChanged(shuffle);
}

bool Player::shuffle() const
{
    return m_shuffle;
}

void Player::setLoop(bool loop)
{
    if (m_loop == loop)
        return;

    m_loop = loop;
    emit loopChanged(loop);
}

bool Player::loop() const
{
    return m_loop;
}

// Hàm trả về index ngẫu nhiên
int Player::randomIndex()
{
    int currentIndex = m_playlist->currentIndex();
    int nextIndex;
    do {
        // Tạo số ngẫu nhiên trong phạm vi 0 đến mediaCount - 1.
        nextIndex = std::rand() % m_playlist->mediaCount();
    // Nếu index ngẫu nhiên trùng với index bài hát hiện tại thì tìm một số ngẫu nhiên khác
    } while (nextIndex == currentIndex);
    qDebug() << "Index Random: " << nextIndex;
    return nextIndex;
}

int Player::volumeLevel() const
{
    return m_volumeLevel;
}

QMediaPlaylist *Player::mediaPlaylist() const
{
    return m_playlist;
}

int Player::currentIndex() const
{
    return m_playlist->currentIndex();
}

bool Player::isPlay() const
{
    return m_isPlay;
}

bool Player::isOpenApp() const
{
    return m_isOpenApp;
}

QString Player::getTimeInfo(qint64 currentInfo)
{
    QString tStr = "00:00";
    currentInfo = currentInfo/1000;
    qint64 durarion = m_player->duration()/1000;
    if (currentInfo || durarion) {
        QTime currentTime((currentInfo / 3600) % 60, (currentInfo / 60) % 60,
                          currentInfo % 60, (currentInfo * 1000) % 1000);
        QTime totalTime((durarion / 3600) % 60, (m_player->duration() / 60) % 60,
                        durarion % 60, (m_player->duration() * 1000) % 1000);
        QString format = "mm:ss";
        if (durarion > 3600)
            format = "hh::mm:ss";
        tStr = currentTime.toString(format);
    }
    return tStr;
}

// Hàm dừng hoặc chơi nhạc
void Player::playMedia()
{
    if(m_player->state() == QMediaPlayer::PausedState || m_player->state() == QMediaPlayer::StoppedState){
        m_player->play();
    }
    else if(m_player->state() == QMediaPlayer::PlayingState){
        m_player->pause();
    }
}

void Player::setNextMedia()
{
    m_playlist->next();
}

void Player::setPreviousMedia()
{
    m_playlist->previous();
}

void Player::setCurrentIndex(int index)
{
    m_playlist->setCurrentIndex(index);
}

void Player::seek(int position)
{
    m_player->setPosition(position);
}

// Hàm thực hiện khi Next Button (hoặc Previous Button) được click (Tức là bài hát hiện tại đang phát có thể chưa chơi hết bài nhưng muốn chuyển sang bài mới). Hàm này sẽ chuyển tiếp bài hát ngẫu nhiên khi Shuffle Button được bật và Next Button (hoặc Previous Button) được nhấn mà không cần xét trạng thái của Repeat Button.
void Player::nextShuffleMedia()
{
    // Gán một index ngẫu nhiên cho biến nextIndex
    int nextIndex = randomIndex();
    // Trình phát nhạc sẽ phát bài hát ngẫu nhiên tiếp theo.
    m_playlist->setCurrentIndex(nextIndex);
    qDebug() << "Next Button: Shuffle. Current: " << m_playlist->currentIndex();
}

// Hàm thực hiện phát bài hát tiếp theo dựa trên trạng thái khi bài hát kết thúc và trạng thái của Shuffle và Repeat Button.
void Player::handleStoppedState(QMediaPlayer::MediaStatus status)
{
    // Nếu bài hát đang phát đã chơi xong.
    if(status == QMediaPlayer::EndOfMedia){
        // Nếu Shuffle Button được bật và Repeat Button tắt
        if(m_shuffle && !m_loop){
            int nextIndex = randomIndex();
            // Trình phát nhạc sẽ phát bài hát ngẫu nhiên tiếp theo.
            m_playlist->setCurrentIndex(nextIndex);
            qDebug() << "End of Media: Shufle. Current: " << m_playlist->currentIndex();
        }
        // Nếu Repeat Button được bật và bất kể Shuffle Button bật hoặc tắt.
        else if(m_loop){
            qDebug() << "End of Media: Loop ";
            // Trình phát nhạc sẽ lặp lại bài hát hiện tại.
            m_playlist->setCurrentIndex(m_playlist->currentIndex());
        }
        else{
            qDebug() << "End of Media. No shuffle and no loop";
        }
    }
}

void Player::setVolumeLevel(int volumeLevel)
{
    if (m_volumeLevel == volumeLevel)
        return;

    m_volumeLevel = volumeLevel;
    emit volumeLevelChanged(m_volumeLevel);
}

void Player::setIsPlay(bool isPlay)
{
    if (m_isPlay == isPlay)
        return;

    m_isPlay = isPlay;
    emit isPlayChanged();
}

void Player::setIsOpenApp(bool isOpenApp)
{
    if (m_isOpenApp == isOpenApp)
        return;

    m_isOpenApp = isOpenApp;
    emit isOpenAppChanged();
}

QString Player::getAlbumArt(QUrl url)
{
    static const char *IdPicture = "APIC" ;
    TagLib::MPEG::File mpegFile(url.path().toStdString().c_str());
    TagLib::ID3v2::Tag *id3v2tag = mpegFile.ID3v2Tag();
    TagLib::ID3v2::FrameList Frame ;
    TagLib::ID3v2::AttachedPictureFrame *PicFrame ;
    void *SrcImage ;
    unsigned long Size ;

    FILE *jpegFile;
    jpegFile = fopen(QString(url.fileName()+".jpg").toStdString().c_str(),"wb");

    if ( id3v2tag )
    {
        // picture frame
        Frame = id3v2tag->frameListMap()[IdPicture] ;
        if (!Frame.isEmpty() )
        {
            for(TagLib::ID3v2::FrameList::ConstIterator it = Frame.begin(); it != Frame.end(); ++it)
            {
                PicFrame = static_cast<TagLib::ID3v2::AttachedPictureFrame*>(*it) ;
                //  if ( PicFrame->type() ==
                //TagLib::ID3v2::AttachedPictureFrame::FrontCover)
                {
                    // extract image (in it’s compressed form)
                    Size = PicFrame->picture().size() ;
                    SrcImage = malloc ( Size ) ;
                    if ( SrcImage )
                    {
                        memcpy ( SrcImage, PicFrame->picture().data(), Size ) ;
                        fwrite(SrcImage,Size,1, jpegFile);
                        fclose(jpegFile);
                        free( SrcImage ) ;
                        // "file:NangTho-HoangDung.mp3.jpg"
                        return QUrl::fromLocalFile(url.fileName()+".jpg").toDisplayString();
                    }

                }
            }
        }
    }
    else
    {
        qDebug() <<"id3v2 not present";
        return "qrc:/App/Media/Image/album_art.png";
    }
    return "qrc:/App/Media/Image/album_art.png";
}


