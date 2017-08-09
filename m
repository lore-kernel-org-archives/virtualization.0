From: Joe Kniss via Virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH libdrm] drm: Remove create_handle() drm_framebuffer
	"virtual".
Date: Wed, 9 Aug 2017 16:13:05 -0700
Message-ID: <CAOvnNvbEt=Uyve3cu_+6BB0EepvO=OKC6gpV3isRef+UdVoX-g__32433.3811332055$1509079007$gmane$org@mail.gmail.com>
References: <20170808234237.62051-1-djmk@google.com>
	<8a7bf59a-0f58-21ba-8b82-78e6ba873065@tronnes.org>
Reply-To: Joe Kniss <djmk@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <8a7bf59a-0f58-21ba-8b82-78e6ba873065@tronnes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Dave Airlie <airlied@linux.ie>, Michel Daenzer <michel.daenzer@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, "Zhang,
	Jerry" <Jerry.Zhang@amd.com>, Thierry Reding <thierry.reding@gmail.com>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, "Vetter,
	Daniel" <daniel.vetter@intel.com>, baoyou.xie@linaro.org, ville.syrjala@linux.intel.com, Alex Xie <AlexBin.Xie@amd.com>, "StDenis, Tom" <tom.stdenis@amd.com>, zhoucm1 <David1.Zhou@amd.com>, mario.kleiner.de@gmail.com, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, joe@perches.com, Joonyoung Shim <jy0922.shim@samsung.com>, linux-mediatek@lists.infradead.org, Russell King <linux@armlinux.org.uk>, krzk@kernel.org, jonathanh@nvidia.com, "open list:ARM/Rockchip SoC..." <linux-rockchip@list>
List-Id: virtualization@lists.linuxfoundation.org

T24gV2VkLCBBdWcgOSwgMjAxNyBhdCAxMjoxNCBQTSwgTm9yYWxmIFRyw7hubmVzIDxub3JhbGZA
dHJvbm5lcy5vcmc+IHdyb3RlOgo+Cj4gRGVuIDA5LjA4LjIwMTcgMDEuNDIsIHNrcmV2IEpvZSBL
bmlzczoKPj4KPj4gQmVjYXVzZSBhbGwgZHJpdmVycyBjdXJyZW50bHkgdXNlIGdlbSBvYmplY3Rz
IGZvciBmcmFtZWJ1ZmZlciBwbGFuZXMsCj4+IHRoZSB2aXJ0dWFsIGNyZWF0ZV9oYW5kbGUoKSBp
cyBub3QgcmVxdWlyZWQuICBUaGlzIGNoYW5nZSBhZGRzIGEKPj4gc3RydWN0IGRybV9nZW1fb2Jq
ZWN0ICpnZW1zWzRdIGZpZWxkIHRvIGRybV9mcmFtZWJ1ZmZlciBhbmQgcmVtb3Zlcwo+PiBjcmVh
dGVfaGFuZGxlKCkgZnVuY3Rpb24gcG9pbnRlciBmcm9tIGRybV9mcmFtZWJ1ZmZlcl9mdW5jcy4g
IFRoZQo+PiBjb3JyZXNwb25kaW5nICpfY3JlYXRlX2hhbmRsZSgpIGZ1bmN0aW9uIGlzIHJlbW92
ZWQgZnJvbSBlYWNoIGRyaXZlci4KPj4KPj4gSW4gbWFueSBjYXNlcyB0aGlzIGNoYW5nZSBlbGlt
aW5hdGVzIGEgc3RydWN0ICpfZnJhbWVidWZmZXIgb2JqZWN0LAo+PiBhcyB0aGUgb25seSBuZWVk
IGZvciB0aGUgZGVyaXZlZCBzdHJ1Y3QgaXMgdGhlIGFkZGl0aW9uIG9mIHRoZSBnZW0KPj4gb2Jq
ZWN0IHBvaW50ZXIuCj4+Cj4+IFRFU1RFRDogY29tcGlsZWQ6IGFsbHllc2NvbmZpZyBBUkNIPXg4
Nixhcm0gcGxhdGZvcm1zOmk5MTUsIHJvY2tjaGlwCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEpvZSBL
bmlzcyA8ZGpta0Bnb29nbGUuY29tPgo+PiAtLS0KPgo+Cj4gSGkgSm9lLAo+Cj4gSSdtIGFsc28g
bG9va2luZyBpbnRvIGFkZGluZyBnZW0gb2JqcyB0byBkcm1fZnJhbWVidWZmZXIgaW4gdGhpcyBw
YXRjaDoKPiBbUEFUQ0ggdjIgMDEvMjJdIGRybTogQWRkIEdFTSBiYWNrZWQgZnJhbWVidWZmZXIg
bGlicmFyeQo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL2FyY2hpdmVzL2RyaS1kZXZl
bC8yMDE3LUF1Z3VzdC8xNDk3ODIuaHRtbAo+CgpHcmVhdC4gIFRoZXJlJ3Mgb25seSBtaW5pbWFs
IG92ZXJsYXAgaGVyZS4gIEknbGwgcmViYXNlIHRoaXMgY2hhbmdlIG9uIHlvdXJzCm9uY2UgaXQn
cyBpbi4KCj4gWy4uLl0KPgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV9mYl9j
bWFfaGVscGVyLmMKPj4gYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2ZiX2NtYV9oZWxwZXIuYwo+PiBp
bmRleCBhZGUzMTlkMTBlNzAuLmY1ZjAxMWI5MTBiMSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2RybV9mYl9jbWFfaGVscGVyLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV9m
Yl9jbWFfaGVscGVyLmMKPj4gQEAgLTMxLDE0ICszMSw5IEBACj4+ICAgICAjZGVmaW5lIERFRkFV
TFRfRkJERUZJT19ERUxBWV9NUyA1MAo+PiAgIC1zdHJ1Y3QgZHJtX2ZiX2NtYSB7Cj4+IC0gICAg
ICAgc3RydWN0IGRybV9mcmFtZWJ1ZmZlciAgICAgICAgICBmYjsKPj4gLSAgICAgICBzdHJ1Y3Qg
ZHJtX2dlbV9jbWFfb2JqZWN0ICAgICAgICpvYmpbNF07Cj4+IC19Owo+PiAtCj4+ICAgc3RydWN0
IGRybV9mYmRldl9jbWEgewo+PiAgICAgICAgIHN0cnVjdCBkcm1fZmJfaGVscGVyICAgIGZiX2hl
bHBlcjsKPj4gLSAgICAgICBzdHJ1Y3QgZHJtX2ZiX2NtYSAgICAgICAqZmI7Cj4+ICsgICAgICAg
c3RydWN0IGRybV9mcmFtZWJ1ZmZlciAgKmZiOwo+Cj4KPiBUaGlzIGZiIHBvaW50ZXIgaXNuJ3Qg
bmVjZXNzYXJ5LCBzaW5jZSBmYl9oZWxwZXIgYWxyZWFkeSBoYXMgb25lLgo+CgpJJ2xsIHJlbW92
ZSBpdC4uLiBidXQgSSBhbSBzdXJlIHdoZW4gSSBsb29rIGRlZXBlciB0aGVyZSB3aWxsIGJlIG1v
cmUKb2YgdGhlc2UgaW4gdGhlIHZhcmlvdXMgZHJpdmVycyB0b28uCgo+IE5vcmFsZi4KPgo+Cgot
am9lCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
