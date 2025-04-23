#include "xmlreader.h"

XmlReader::XmlReader(QString filePath, ApplicationsModel &model)
{
    ReadXmlFile(filePath);
    PaserXml(model);
}

bool XmlReader::ReadXmlFile(QString filePath)
{
    // Load xml file as raw data
    QFile f(filePath);
    if (!f.open(QIODevice::ReadOnly ))
    {
        // Error while loading file
        return false;
    }
    // Set data into the QDomDocument before processing
    m_xmlDoc.setContent(&f);
    f.close();
    return true;
}

void XmlReader::PaserXml(ApplicationsModel &model)
{
    // Extract the root markup
    QDomElement root=m_xmlDoc.documentElement();

    // Get the first child of the root (Markup COMPONENT is expected)
    QDomElement Component=root.firstChild().toElement();

    // Loop while there is a child
    while(!Component.isNull())
    {
        // Check if the child tag name is COMPONENT
        if (Component.tagName()=="APP")
        {

            // Read and display the component ID
            QString ID=Component.attribute("ID","No ID");

            // Get the first child of the component
            QDomElement Child=Component.firstChild().toElement();

            QString title;
            QString url;
            QString iconPath;

            // Read each child of the component node
            while (!Child.isNull())
            {
                // Read Name and value
                if (Child.tagName()=="TITLE") title = Child.firstChild().toText().data();
                if (Child.tagName()=="URL") url = Child.firstChild().toText().data();
                if (Child.tagName()=="ICON_PATH") iconPath = Child.firstChild().toText().data();

                // Next child
                Child = Child.nextSibling().toElement();
            }
            ApplicationItem item(title,url,iconPath);
            model.addApplication(item);
        }

        // Next component
        Component = Component.nextSibling().toElement();
    }
}
