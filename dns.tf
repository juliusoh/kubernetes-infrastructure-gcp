/***************************************
* GCP Cloud DNS
***************************************/

resource "google_dns_managed_zone" "zone" {
  name        = replace(var.domain, ".", "-")
  dns_name    = "${var.domain}."
  description = var.description
}

/***************************************
* Root Domain
***************************************/

resource "google_dns_record_set" "root" {
  managed_zone = google_dns_managed_zone.zone.name
  name         = google_dns_managed_zone.zone.dns_name
  rrdatas      = ["35.224.45.205"]
  ttl          = 300
  type         = "A"
}


resource "google_dns_record_set" "www" {
  managed_zone = google_dns_managed_zone.zone.name
  name         = "www.${google_dns_managed_zone.zone.dns_name}"
  rrdatas      = [google_dns_managed_zone.zone.dns_name]
  ttl          = 300
  type         = "CNAME"
}

/***************************************
* Subdomains
***************************************/

resource "google_dns_record_set" "dev" {
  managed_zone = google_dns_managed_zone.zone.name
  name         = "dev.${google_dns_managed_zone.zone.dns_name}"
  rrdatas      = ["35.224.45.205"]
  ttl          = 300
  type         = "A"
}
