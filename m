From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v3 18/23] drm/qxl: remove dead qxl fbdev emulation code
Date: Fri, 25 Jan 2019 18:25:49 +0100
Message-ID: <e5a15f7e-b3f1-b609-4a0f-bd66ea711951__9599.89218260802$1548442183$gmane$org@tronnes.org>
References: <20190118122020.27596-1-kraxel@redhat.com>
	<20190118122020.27596-19-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190118122020.27596-19-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

CgpEZW4gMTguMDEuMjAxOSAxMy4yMCwgc2tyZXYgR2VyZCBIb2ZmbWFubjoKPiBMb3ZlbHkgZGlm
ZnN0YXQsIHRoYW5rcyB0byB0aGUgbmV3IGdlbmVyaWMgZmJkZXYgZW11bGF0aW9uLgo+IAo+ICBk
cm0vcXhsL01ha2VmaWxlICAgfCAgICAyCj4gIGRybS9xeGwvcXhsX2RyYXcuYyB8ICAyMzIgLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICBkcm0vcXhsL3F4bF9kcnYu
aCAgfCAgIDIxIC0tLQo+ICBkcm0vcXhsL3F4bF9mYi5jICAgfCAgMzAwIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gCj4gU2lnbmVkLW9mZi1i
eTogR2VyZCBIb2ZmbWFubiA8a3JheGVsQHJlZGhhdC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1
L2RybS9xeGwvcXhsX2Rydi5oICB8ICAyMSAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL3F4bC9xeGxf
ZHJhdy5jIHwgMjMyIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgZHJpdmVycy9n
cHUvZHJtL3F4bC9xeGxfZmIuYyAgIHwgMzAwIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9xeGwvTWFrZWZpbGUgICB8ICAgMiArLQo+
ICA0IGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA1NTQgZGVsZXRpb25zKC0pCj4gIGRl
bGV0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vcXhsL3F4bF9mYi5jCj4gCgpOaWNlIQoK
QWNrZWQtYnk6IE5vcmFsZiBUcsO4bm5lcyA8bm9yYWxmQHRyb25uZXMub3JnPgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
