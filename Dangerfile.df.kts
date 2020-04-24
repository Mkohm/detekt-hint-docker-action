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

val warningsReport = allSourceFiles
val xlmFile: File = File(warningsReport.toString())
val xmlDoc: Document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(xlmFile)
xmlDoc.documentElement.normalize()

println("Root Node:" + xmlDoc.documentElement.nodeName)

val fileList: NodeList = xmlDoc.getElementsByTagName("file")

for (i in 0 until fileList.length) {
    var fileNode: Node = fileList.item(i)

    if (fileNode.getNodeType() === Node.ELEMENT_NODE) {

        val elem = fileNode as Element

        val mMap = mutableMapOf<String, String>()

        for (j in 0..elem.attributes.length - 1) {
            mMap.putIfAbsent(elem.attributes.item(j).nodeName, elem.attributes.item(j).nodeValue)
        }
        println("Current Book : ${fileNode.nodeName} - $mMap")

        println("Author: ${elem.getElementsByTagName("author").item(0).textContent}")
    }
}














if (!isTrivial && !changelogChanged && sourceChanges != null) {
    warn("Any changes to library code should be reflected in the Changelog.\n\nPlease consider adding a note there and adhere to the [Changelog Guidelines](https://github.com/Moya/contributors/blob/master/Changelog%20Guidelines.md).")
}

if (danger.git.createdFiles.size + danger.git.modifiedFiles.size - danger.git.deletedFiles.size > 10) {
    warn("Big PR, try to keep changes smaller if you can")
}

if (danger.github.pullRequest.title.contains("WIP", false)) {
    warn("PR is classed as Work in Progress")
}