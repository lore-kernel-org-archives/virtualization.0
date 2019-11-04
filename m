From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V6 3/6] mdev: introduce device specific ops
Date: Mon, 4 Nov 2019 10:51:53 +0800
Message-ID: <495efacd-4898-fb89-2599-dce3a5a277f0__13744.78680534$1572835966$gmane$org@redhat.com>
References: <20191030064444.21166-1-jasowang@redhat.com>
	<20191030064444.21166-4-jasowang@redhat.com>
	<AM0PR05MB4866E91139617C9F2380BBAFD1620@AM0PR05MB4866.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <AM0PR05MB4866E91139617C9F2380BBAFD1620@AM0PR05MB4866.eurprd05.prod.outlook.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Parav Pandit <parav@mellanox.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "tiwei.bie@intel.com" <tiwei.bie@intel.com>
Cc: "christophe.de.dinechin@gmail.com" <christophe.de.dinechin@gmail.com>, "sebott@linux.ibm.com" <sebott@linux.ibm.com>, "airlied@linux.ie" <airlied@linux.ie>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "lulu@redhat.com" <lulu@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "zhi.a.wang@intel.com" <zhi.a.wang@intel.com>, "farman@linux.ibm.com" <farman@linux.ibm.com>, Ido Shamay <idos@mellanox.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>ro
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMTEvMiDkuIrljYg0OjExLCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4KPj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4KPj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDMwLCAyMDE5IDE6NDUgQU0KPj4gVG86
IGt2bUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXMzOTBAdmdlci5rZXJuZWwub3JnOyBsaW51eC0K
Pj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZzsgaW50ZWwtCj4+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGludGVsLWd2dC1kZXZAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnOwo+PiBrd2Fua2hlZGVAbnZpZGlhLmNvbTsgYWxleC53aWxsaWFt
c29uQHJlZGhhdC5jb207IG1zdEByZWRoYXQuY29tOwo+PiB0aXdlaS5iaWVAaW50ZWwuY29tCj4+
IENjOiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZzsKPj4gY29odWNrQHJlZGhhdC5jb207IG1heGltZS5jb3F1ZWxpbkByZWRo
YXQuY29tOwo+PiBjdW5taW5nLmxpYW5nQGludGVsLmNvbTsgemhpaG9uZy53YW5nQGludGVsLmNv
bTsKPj4gcm9iLm1pbGxlckBicm9hZGNvbS5jb207IHhpYW8udy53YW5nQGludGVsLmNvbTsKPj4g
aGFvdGlhbi53YW5nQHNpZml2ZS5jb207IHpoZW55dXdAbGludXguaW50ZWwuY29tOyB6aGkuYS53
YW5nQGludGVsLmNvbTsKPj4gamFuaS5uaWt1bGFAbGludXguaW50ZWwuY29tOyBqb29uYXMubGFo
dGluZW5AbGludXguaW50ZWwuY29tOwo+PiByb2RyaWdvLnZpdmlAaW50ZWwuY29tOyBhaXJsaWVk
QGxpbnV4LmllOyBkYW5pZWxAZmZ3bGwuY2g7Cj4+IGZhcm1hbkBsaW51eC5pYm0uY29tOyBwYXNp
Y0BsaW51eC5pYm0uY29tOyBzZWJvdHRAbGludXguaWJtLmNvbTsKPj4gb2JlcnBhckBsaW51eC5p
Ym0uY29tOyBoZWlrby5jYXJzdGVuc0BkZS5pYm0uY29tOyBnb3JAbGludXguaWJtLmNvbTsKPj4g
Ym9ybnRyYWVnZXJAZGUuaWJtLmNvbTsgYWtyb3dpYWtAbGludXguaWJtLmNvbTsgZnJldWRlQGxp
bnV4LmlibS5jb207Cj4+IGxpbmdzaGFuLnpodUBpbnRlbC5jb207IElkbyBTaGFtYXkgPGlkb3NA
bWVsbGFub3guY29tPjsKPj4gZXBlcmV6bWFAcmVkaGF0LmNvbTsgbHVsdUByZWRoYXQuY29tOyBQ
YXJhdiBQYW5kaXQKPj4gPHBhcmF2QG1lbGxhbm94LmNvbT47IGNocmlzdG9waGUuZGUuZGluZWNo
aW5AZ21haWwuY29tOwo+PiBrZXZpbi50aWFuQGludGVsLmNvbTsgc3RlZmFuaGFAcmVkaGF0LmNv
bTsgSmFzb24gV2FuZwo+PiA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPj4gU3ViamVjdDogW1BBVENI
IFY2IDMvNl0gbWRldjogaW50cm9kdWNlIGRldmljZSBzcGVjaWZpYyBvcHMKPj4KPj4gQ3VycmVu
dGx5LCBleGNlcHQgZm9yIHRoZSBjcmVhdGUgYW5kIHJlbW92ZSwgdGhlIHJlc3Qgb2YgbWRldl9w
YXJlbnRfb3BzIGlzCj4+IGRlc2lnbmVkIGZvciB2ZmlvLW1kZXYgZHJpdmVyIG9ubHkgYW5kIG1h
eSBub3QgaGVscCBmb3Iga2VybmVsIG1kZXYgZHJpdmVyLgo+PiBXaXRoIHRoZSBoZWxwIG9mIGNs
YXNzIGlkLCB0aGlzIHBhdGNoIGludHJvZHVjZXMgZGV2aWNlIHNwZWNpZmljIGNhbGxiYWNrcyBp
bnNpZGUKPj4gbWRldl9kZXZpY2Ugc3RydWN0dXJlLiBUaGlzIGFsbG93cyBkaWZmZXJlbnQgc2V0
IG9mIGNhbGxiYWNrIHRvIGJlIHVzZWQgYnkgdmZpby0KPj4gbWRldiBhbmQgdmlydGlvLW1kZXYu
Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+
IC0tLQo+IFsgLi5dCj4KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmZpb19tZGV2X29w
cy5oIGIvaW5jbHVkZS9saW51eC92ZmlvX21kZXZfb3BzLmgKPj4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQgaW5kZXggMDAwMDAwMDAwMDAwLi4zOTA3YzUzNzFjMmIKPj4gLS0tIC9kZXYvbnVsbAo+PiAr
KysgYi9pbmNsdWRlL2xpbnV4L3ZmaW9fbWRldl9vcHMuaAo+PiBAQCAtMCwwICsxLDUyIEBACj4+
ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5ICovCj4+ICsvKgo+PiAr
ICogVkZJTyBNZWRpYXRlZCBkZXZpY2UgZGVmaW5pdGlvbgo+PiArICovCj4+ICsKPj4gKyNpZm5k
ZWYgVkZJT19NREVWX0gKPj4gKyNkZWZpbmUgVkZJT19NREVWX0gKPj4gKwo+IEkgc2hvdWxkIGhh
dmUgbm90aWNlZCB0aGlzIGJlZm9yZS4gOi0oCj4gQVBJcyBleHBvc2VkIGFyZSBieSB0aGUgbWRl
diBtb2R1bGUgYW5kIG5hbWVkIHdpdGggbWRldl8gcHJlZml4Lgo+IEFuZCBmaWxlIG5hbWUgaXMg
X29wcy5oLAo+Cj4gV2Ugc2hvdWxkIG5hbWUgdGhpcyBmaWxlIGFzIG1kZXZfdmZpb19vcHMuaAo+
Cj4gQW5kICNkZWZpbmUgc2hvdWxkIGJlIE1ERVZfVkZJT19PUFNfSAo+Cj4+ICsjaW5jbHVkZSA8
bGludXgvbWRldi5oPgo+PiArCj4+ICsvKioKPj4gKyAqIHN0cnVjdCB2ZmlvX21kZXZfZGV2aWNl
X29wcyAtIFN0cnVjdHVyZSB0byBiZSByZWdpc3RlcmVkIGZvciBlYWNoCj4gcy92ZmlvX21kZXZf
ZGV2aWNlX29wcy9tZGV2X3ZmaW9fZGV2aWNlX29wcy8KPgo+IFNpbWlsYXJseSBmb3IgdmlydGlv
IGluIGZ1dHVyZSBwYXRjaGVzLgo+CgpXaWxsIGZpeCBpbiBWNy4KCgo+ICAgc3RhdGljIHZvaWQg
bXR0eV9kZXZpY2VfcmVsZWFzZShzdHJ1Y3QgZGV2aWNlICpkZXYpCj4gLS0KPiAyLjE5LjEKPiBX
aXRoIGFib3ZlIHNtYWxsIG5pdCBjaGFuZ2VzIHRvIHJlbmFtZSB0aGUgZmllbGRzIGFuZCBmaWxl
LAo+Cj4gUmV2aWV3ZWQtYnk6IFBhcmF2IFBhbmRpdCA8cGFyYXZAbWVsbGFub3guY29tPgoKCkFw
cHJlY2lhdGUgdGhhdCwgdGhhbmtzLgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
