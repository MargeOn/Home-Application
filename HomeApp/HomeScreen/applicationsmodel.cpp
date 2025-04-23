#include "applicationsmodel.h"

ApplicationItem::ApplicationItem(QString title, QString url, QString iconPath)
{
    m_title = title;
    m_url = url;
    m_iconPath = iconPath;
}

QString ApplicationItem::title() const
{
    return m_title;
}

QString ApplicationItem::url() const
{
    return m_url;
}

QString ApplicationItem::iconPath() const
{
    return m_iconPath;
}

ApplicationsModel::ApplicationsModel(QObject *parent)
{
    Q_UNUSED(parent)
}

int ApplicationsModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_data.count();
}

QVariant ApplicationsModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= m_data.count())
        return QVariant();

    const ApplicationItem &item = m_data[index.row()];
    if (role == TitleRole)
        return item.title();
    else if (role == UrlRole)
        return item.url();
    else if (role == IconPathRole)
        return item.iconPath();
    return QVariant();
}

void ApplicationsModel::addApplication(ApplicationItem &item)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_data << item;
    endInsertRows();
}

void ApplicationsModel::moveItem(int from, int to)
{
    if(from < 0 || from >= m_data.size() || to < 0 || to >= m_data.size() || from == to){
        return;
    }
    beginMoveRows(QModelIndex(), from, from, QModelIndex(),(from < to) ? to + 1 : to);
    m_data.move(from, to);
    endMoveRows();
    saveModeltoXML();
}

void ApplicationsModel::saveModeltoXML()
{
    QDomDocument doc;
    QDomElement root = doc.createElement("APPLICATIONS");
    doc.appendChild(root);
    for(int i = 0; i < rowCount(); i++){
        QDomElement appElem = doc.createElement("APP");
        QString id;
        if(i >= 9){
            id = "0" + QString::number(i + 1);
        }
        else
            id = "00" + QString::number(i + 1);
        appElem.setAttribute("ID", id);

        QDomElement titleElem = doc.createElement("TITLE");
        titleElem.appendChild(doc.createTextNode(m_data.at(i).title()));
        appElem.appendChild(titleElem);

        QDomElement urlElem = doc.createElement("URL");
        urlElem.appendChild(doc.createTextNode(m_data.at(i).url()));
        appElem.appendChild(urlElem);

        QDomElement iconElem = doc.createElement("ICON_PATH");
        iconElem.appendChild(doc.createTextNode(m_data.at(i).iconPath()));
        appElem.appendChild(iconElem);

        root.appendChild(appElem);

        QString path = QString(PROJECT_PATH) + "applications.xml";
        QFile file(path);
        if(file.open(QIODevice::WriteOnly | QIODevice::Text)){
            QTextStream stream(&file);
            stream.setCodec("UTF-8");
            stream << doc.toString(8);
            file.close();
            qDebug() << "Ghi file thanh cong";
        }
        else{
            qDebug() << "Khong the ghi file";
        }
    }
}

QHash<int, QByteArray> ApplicationsModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[TitleRole] = "title";
    roles[UrlRole] = "url";
    roles[IconPathRole] = "iconPath";
    return roles;
}

