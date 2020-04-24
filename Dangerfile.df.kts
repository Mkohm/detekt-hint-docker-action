import org.w3c.dom.Document
import org.w3c.dom.Element
import org.w3c.dom.NodeList
import systems.danger.kotlin.warn
import java.io.File
import javax.xml.parsers.DocumentBuilderFactory


val xmlFile: File = File("build/reports/detekt-hint-report.xml")
val xmlDoc: Document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(xmlFile)
xmlDoc.documentElement.normalize()

val fileList: NodeList = xmlDoc.getElementsByTagName("file")

for (i in 0 until fileList.length) {
    var fileNode = fileList.item(i) as Element


    val fileName = fileNode.getAttribute("name")
    println("Filename: $fileName")

    for (k in 0 until fileNode.getElementsByTagName("error").length) {
        val error = fileNode.getElementsByTagName("error").item(k) as Element
        println("Error")

        val line = error.getAttribute("line")
        println("Line: $line")
        val message = error.getAttribute("message")
        println("Message: $message")


        warn(message, fileName, line.toInt())
    }
}

