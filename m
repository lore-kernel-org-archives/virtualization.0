From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v3 18/23] drm/qxl: remove dead qxl fbdev emulation code
Date: Fri, 25 Jan 2019 19:44:21 +0100
Message-ID: <076761d5-f4d7-bf06-45ae-06361b284076__37150.6024080858$1548442456$gmane$org@tronnes.org>
References: <20190118122020.27596-1-kraxel@redhat.com>
	<20190118122020.27596-19-kraxel@redhat.com>
	<e5a15f7e-b3f1-b609-4a0f-bd66ea711951@tronnes.org>
	<20190125181009.GA8230@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190125181009.GA8230@ravnborg.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@redhat.com>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>
List-Id: virtualization@lists.linuxfoundation.org

CgpEZW4gMjUuMDEuMjAxOSAxOS4xMCwgc2tyZXYgU2FtIFJhdm5ib3JnOgo+IEhpIE5vcmFsZi4K
PiAKPj4+IExvdmVseSBkaWZmc3RhdCwgdGhhbmtzIHRvIHRoZSBuZXcgZ2VuZXJpYyBmYmRldiBl
bXVsYXRpb24uCj4+Pgo+Pj4gIGRybS9xeGwvTWFrZWZpbGUgICB8ICAgIDIKPj4+ICBkcm0vcXhs
L3F4bF9kcmF3LmMgfCAgMjMyIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KPj4+ICBkcm0vcXhsL3F4bF9kcnYuaCAgfCAgIDIxIC0tLQo+Pj4gIGRybS9xeGwvcXhsX2Zi
LmMgICB8ICAzMDAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBHZXJkIEhvZmZtYW5uIDxrcmF4ZWxAcmVk
aGF0LmNvbT4KPj4+IC0tLQo+Pj4gIGRyaXZlcnMvZ3B1L2RybS9xeGwvcXhsX2Rydi5oICB8ICAy
MSAtLS0KPj4+ICBkcml2ZXJzL2dwdS9kcm0vcXhsL3F4bF9kcmF3LmMgfCAyMzIgLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+Pj4gIGRyaXZlcnMvZ3B1L2RybS9xeGwvcXhsX2ZiLmMg
ICB8IDMwMCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+Pj4gIGRy
aXZlcnMvZ3B1L2RybS9xeGwvTWFrZWZpbGUgICB8ICAgMiArLQo+Pj4gIDQgZmlsZXMgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDU1NCBkZWxldGlvbnMoLSkKPj4+ICBkZWxldGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9ncHUvZHJtL3F4bC9xeGxfZmIuYwo+Pj4KPj4KPj4gTmljZSEKPj4KPj4gQWNr
ZWQtYnk6IE5vcmFsZiBUcsO4bm5lcyA8bm9yYWxmQHRyb25uZXMub3JnPgo+IEl0IG11c3QgYmUg
YSB2ZXJ5IHNhdGlzZnlpbmcgZXhwZXJpZW5jZSB0byBzZWUgc3VjaCBiZW5lZml0cwo+IG9mIHRo
ZSBtYW55IGhvdXJzIG9mIHdvcmtzIHlvdSBoYXZlIHB1dCBpbnRvIHRoZSBnZW5yaWMKPiBmYmRl
diBlbXVsYXRpb24gY29kZS4KCkluZGVlZCBhbmQgaGF2aW5nIG1vcmUgdXNlcnMgb2YgdGhlIGNv
ZGUgaW5jcmVhc2VzIHRoZSBjaGFuY2Ugb2YKZGV0ZWN0aW5nIGFueSBidWdzIGx1cmtpbmcgdW5k
ZXJuZWF0aCB0aGUgc3VyZmFjZS4KCj4gV2VsbCBkb25lLCBhbmQgaW5kZWVkIGEgbmljZSBwYXRj
aCBmcm9tIEdlcmQuCj4gCj4gCVNhbQo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
