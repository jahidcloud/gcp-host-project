# Beware when using tf format command, it edits template file.

data "template_file" "userdata" {
  template = "${file("./template/userdata.tpl")}"
}
