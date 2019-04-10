From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v2 1/3] drm: switch drm_fb_memcpy_dstclip to accept
	__iomem dst
Date: Wed, 10 Apr 2019 11:42:33 +0200
Message-ID: <f73b4d2e-1767-3512-0a8a-d447a2f22639__36804.5873286732$1554889390$gmane$org@tronnes.org>
References: <20190410063815.17062-1-kraxel@redhat.com>
	<20190410063815.17062-2-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190410063815.17062-2-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>
List-Id: virtualization@lists.linuxfoundation.org

CgpEZW4gMTAuMDQuMjAxOSAwOC4zOCwgc2tyZXYgR2VyZCBIb2ZmbWFubjoKPiBOb3QgYWxsIGFy
Y2hzIGhhdmUgdGhlIF9faW9fdmlydCgpIG1hY3JvLCBzbyBjaXJydXMgY2FuJ3Qgc2ltcGx5IGNv
bnZlcnQKPiBwb2ludGVycyB0aGF0IHdheS4gIFRoZSBkcm0gZm9ybWF0IGhlbHBlcnMgaGF2ZSB0
byB1c2UgbWVtY3B5X3RvaW8oKQo+IGluc3RlYWQuCj4gCj4gVGhpcyBwYXRjaCBtYWtlcyBkcm1f
ZmJfbWVtY3B5X2RzdGNsaXAoKSBhY2NlcHQgYSBfX2lvbWVtIGRzdCBwb2ludGVyCj4gYW5kIHVz
ZSBtZW1jcHlfdG9pbygpIGluc3RlYWQgb2YgbWVtY3B5KCkuICBXaXRoIHRoYXQgc2VwYXJhdGlu
ZyBvdXQgdGhlCj4gbWVtY3B5IGxvb3AgaW50byB0aGUgZHJtX2ZiX21lbWNweV9saW5lcygpIGhl
bHBlciBpc24ndCB1c2VmdWwgYW55IG1vcmUsCj4gc28gbW92ZSB0aGUgY29kZSBiYWNrIGludG8g
dGhlIGNhbGxpbmcgZnVuY3RpbnMuCj4gCj4gU2lnbmVkLW9mZi1ieTogR2VyZCBIb2ZmbWFubiA8
a3JheGVsQHJlZGhhdC5jb20+Cj4gLS0tCgpSZXZpZXdlZC1ieTogTm9yYWxmIFRyw7hubmVzIDxu
b3JhbGZAdHJvbm5lcy5vcmc+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
