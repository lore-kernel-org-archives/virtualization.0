From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/bochs: Replace ttm_bo_unref with ttm_bo_put
Date: Thu, 9 Aug 2018 17:27:50 +0200
Message-ID: <20180809152750.w6pirxqqwdajfhwz@sirius.home.kraxel.org>
References: <20180731062851.10812-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180731062851.10812-1-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2JvY2hzL2JvY2hzX21tLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYm9jaHMvYm9jaHNfbW0uYwo+IGluZGV4IDM5Y2QwODQxNjc3My4uYzljNzA5NzAz
MGNhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9ib2Nocy9ib2Noc19tbS5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2JvY2hzL2JvY2hzX21tLmMKPiBAQCAtNDMwLDcgKzQzMCw3IEBA
IHN0YXRpYyB2b2lkIGJvY2hzX2JvX3VucmVmKHN0cnVjdCBib2Noc19ibyAqKmJvKQo+ICAJCXJl
dHVybjsKPiAgCj4gIAl0Ym8gPSAmKCgqYm8pLT5ibyk7Cj4gLQl0dG1fYm9fdW5yZWYoJnRibyk7
Cj4gKwl0dG1fYm9fcHV0KHRibyk7CgpmYWlscyB0byBidWlsZDoKCiAgQ0MgW01dICBkcml2ZXJz
L2dwdS9kcm0vYm9jaHMvYm9jaHNfbW0ubwovaG9tZS9rcmF4ZWwvcHJvamVjdHMvbGludXgvZHJp
dmVycy9ncHUvZHJtL2JvY2hzL2JvY2hzX21tLmM6IEluIGZ1bmN0aW9uIOKAmGJvY2hzX2JvX3Vu
cmVm4oCZOgovaG9tZS9rcmF4ZWwvcHJvamVjdHMvbGludXgvZHJpdmVycy9ncHUvZHJtL2JvY2hz
L2JvY2hzX21tLmM6NDMzOjI6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlv
biDigJh0dG1fYm9fcHV04oCZIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9u
XQogIHR0bV9ib19wdXQodGJvKTsKICBeCmNjMTogc29tZSB3YXJuaW5ncyBiZWluZyB0cmVhdGVk
IGFzIGVycm9ycwoKY2hlZXJzLAogIEdlcmQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
