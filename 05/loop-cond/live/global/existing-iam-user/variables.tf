variable "hero_thousand_faces" {
  description = "map"
  type        = map(string)
  default     = {
    neo      = "hero"             # -> neo is the here
    trinity  = "love interest"    # -> trinity is the love interest
    morpheus = "mentor"           # -> morpheus is the mentor
  }
}

output "bios" {
  value = [for name, role in var.var.hero_thousand_faces: "${name} is the ${role}"]
}