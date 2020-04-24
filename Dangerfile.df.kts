import org.w3c.dom.Document
import org.w3c.dom.Element
import org.w3c.dom.Node
import org.w3c.dom.NodeList
import systems.danger.kotlin.Danger
import systems.danger.kotlin.warn
import java.io.File
import javax.xml.parsers.DocumentBuilderFactory


val danger = Danger(args)

val allSourceFiles = danger.git.modifiedFiles + danger.git.createdFiles

val changelogChanged = allSourceFiles.contains("CHANGELOG.md")
val sourceChanges = allSourceFiles.firstOrNull { it.contains("src") }
val isTrivial = danger.github.pullRequest.title.contains("#trivial")

warn("This is a test")

val warningsReport = allSourceFiles.find { it.contains("detekt-hint-report.xml") }

val xlmFile: File = File(warningsReport)
println(xlmFile.toString())
val xmlDoc: Document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(xlmFile)
xmlDoc.documentElement.normalize()

println("Root Node:" + xmlDoc.documentElement.nodeName)

val fileList: NodeList = xmlDoc.getElementsByTagName("file")

for (i in 0 until fileList.length) {
    var fileNode: Node = fileList.item(i)

    if (fileNode.nodeType === Node.ELEMENT_NODE) {

        val elem = fileNode as Element

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
}