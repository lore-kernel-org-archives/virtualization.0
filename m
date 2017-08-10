From: Joe Kniss via Virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH libdrm] drm: Remove create_handle() drm_framebuffer
	"virtual".
Date: Thu, 10 Aug 2017 12:29:30 -0700
Message-ID: <CAOvnNvbNNtuLFy+7-beF=kGB0qYJckT_MEef3_=t-eWi-NFGXA__48888.8689120815$1509079073$gmane$org@mail.gmail.com>
References: <20170808234237.62051-1-djmk@google.com>
	<8a7bf59a-0f58-21ba-8b82-78e6ba873065@tronnes.org>
	<CAOvnNvbEt=Uyve3cu_+6BB0EepvO=OKC6gpV3isRef+UdVoX-g@mail.gmail.com>
Reply-To: Joe Kniss <djmk@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAOvnNvbEt=Uyve3cu_+6BB0EepvO=OKC6gpV3isRef+UdVoX-g@mail.gmail.com>
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
	Daniel" <daniel.vetter@intel.com>, baoyou.xie@linaro.org, ville.syrjala@linux.intel.com, Alex Xie <AlexBin.Xie@amd.com>, "StDenis, Tom" <tom.stdenis@amd.com>, zhoucm1 <David1.Zhou@amd.com>, Mario Kleiner <mario.kleiner.de@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, joe@perches.com, Joonyoung Shim <jy0922.shim@samsung.com>, linux-mediatek@lists.infradead.org, Russell King <linux@armlinux.org.uk>, krzk@kernel.org, jonathanh@nvidia.com"open list:ARM/Rockchip SoC..." <lin>
List-Id: virtualization@lists.linuxfoundation.org

T24gV2VkLCBBdWcgOSwgMjAxNyBhdCA0OjEzIFBNLCBKb2UgS25pc3MgPGRqbWtAZ29vZ2xlLmNv
bT4gd3JvdGU6Cj4gT24gV2VkLCBBdWcgOSwgMjAxNyBhdCAxMjoxNCBQTSwgTm9yYWxmIFRyw7hu
bmVzIDxub3JhbGZAdHJvbm5lcy5vcmc+IHdyb3RlOgo+Pgo+PiBEZW4gMDkuMDguMjAxNyAwMS40
Miwgc2tyZXYgSm9lIEtuaXNzOgo+Pj4KPj4+IEJlY2F1c2UgYWxsIGRyaXZlcnMgY3VycmVudGx5
IHVzZSBnZW0gb2JqZWN0cyBmb3IgZnJhbWVidWZmZXIgcGxhbmVzLAo+Pj4gdGhlIHZpcnR1YWwg
Y3JlYXRlX2hhbmRsZSgpIGlzIG5vdCByZXF1aXJlZC4gIFRoaXMgY2hhbmdlIGFkZHMgYQo+Pj4g
c3RydWN0IGRybV9nZW1fb2JqZWN0ICpnZW1zWzRdIGZpZWxkIHRvIGRybV9mcmFtZWJ1ZmZlciBh
bmQgcmVtb3Zlcwo+Pj4gY3JlYXRlX2hhbmRsZSgpIGZ1bmN0aW9uIHBvaW50ZXIgZnJvbSBkcm1f
ZnJhbWVidWZmZXJfZnVuY3MuICBUaGUKPj4+IGNvcnJlc3BvbmRpbmcgKl9jcmVhdGVfaGFuZGxl
KCkgZnVuY3Rpb24gaXMgcmVtb3ZlZCBmcm9tIGVhY2ggZHJpdmVyLgo+Pj4KPj4+IEluIG1hbnkg
Y2FzZXMgdGhpcyBjaGFuZ2UgZWxpbWluYXRlcyBhIHN0cnVjdCAqX2ZyYW1lYnVmZmVyIG9iamVj
dCwKPj4+IGFzIHRoZSBvbmx5IG5lZWQgZm9yIHRoZSBkZXJpdmVkIHN0cnVjdCBpcyB0aGUgYWRk
aXRpb24gb2YgdGhlIGdlbQo+Pj4gb2JqZWN0IHBvaW50ZXIuCj4+Pgo+Pj4gVEVTVEVEOiBjb21w
aWxlZDogYWxseWVzY29uZmlnIEFSQ0g9eDg2LGFybSBwbGF0Zm9ybXM6aTkxNSwgcm9ja2NoaXAK
Pj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBKb2UgS25pc3MgPGRqbWtAZ29vZ2xlLmNvbT4KPj4+IC0t
LQo+Pgo+Pgo+PiBIaSBKb2UsCj4+Cj4+IEknbSBhbHNvIGxvb2tpbmcgaW50byBhZGRpbmcgZ2Vt
IG9ianMgdG8gZHJtX2ZyYW1lYnVmZmVyIGluIHRoaXMgcGF0Y2g6Cj4+IFtQQVRDSCB2MiAwMS8y
Ml0gZHJtOiBBZGQgR0VNIGJhY2tlZCBmcmFtZWJ1ZmZlciBsaWJyYXJ5Cj4+IGh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL2FyY2hpdmVzL2RyaS1kZXZlbC8yMDE3LUF1Z3VzdC8xNDk3ODIu
aHRtbAo+Pgo+Cj4gR3JlYXQuICBUaGVyZSdzIG9ubHkgbWluaW1hbCBvdmVybGFwIGhlcmUuICBJ
J2xsIHJlYmFzZSB0aGlzIGNoYW5nZSBvbiB5b3Vycwo+IG9uY2UgaXQncyBpbi4KPgo+PiBbLi4u
XQo+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZmJfY21hX2hlbHBlci5j
Cj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZmJfY21hX2hlbHBlci5jCj4+PiBpbmRleCBhZGUz
MTlkMTBlNzAuLmY1ZjAxMWI5MTBiMSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9k
cm1fZmJfY21hX2hlbHBlci5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2ZiX2NtYV9o
ZWxwZXIuYwo+Pj4gQEAgLTMxLDE0ICszMSw5IEBACj4+PiAgICAgI2RlZmluZSBERUZBVUxUX0ZC
REVGSU9fREVMQVlfTVMgNTAKPj4+ICAgLXN0cnVjdCBkcm1fZmJfY21hIHsKPj4+IC0gICAgICAg
c3RydWN0IGRybV9mcmFtZWJ1ZmZlciAgICAgICAgICBmYjsKPj4+IC0gICAgICAgc3RydWN0IGRy
bV9nZW1fY21hX29iamVjdCAgICAgICAqb2JqWzRdOwo+Pj4gLX07Cj4+PiAtCj4+PiAgIHN0cnVj
dCBkcm1fZmJkZXZfY21hIHsKPj4+ICAgICAgICAgc3RydWN0IGRybV9mYl9oZWxwZXIgICAgZmJf
aGVscGVyOwo+Pj4gLSAgICAgICBzdHJ1Y3QgZHJtX2ZiX2NtYSAgICAgICAqZmI7Cj4+PiArICAg
ICAgIHN0cnVjdCBkcm1fZnJhbWVidWZmZXIgICpmYjsKPj4KPj4KPj4gVGhpcyBmYiBwb2ludGVy
IGlzbid0IG5lY2Vzc2FyeSwgc2luY2UgZmJfaGVscGVyIGFscmVhZHkgaGFzIG9uZS4KPj4KClNv
LCBsb29raW5nIGRlZXBlciBpbnRvIHRoaXMsIGl0IHNlZW1zIHRoYXQgdGhlIHN0cnVjdApkcm1f
ZnJhbWVidWZmZXJfZnVuY3MgKmZiX2Z1bmNzIGlzIGFsc28gcmVkdW5kYW50IGhlcmU/ICBJbiB3
aGljaCBjYXNlCnRoaXMgd2hvbGUgc3RydWN0IGNhbiBnby4uLgoKPgo+IEknbGwgcmVtb3ZlIGl0
Li4uIGJ1dCBJIGFtIHN1cmUgd2hlbiBJIGxvb2sgZGVlcGVyIHRoZXJlIHdpbGwgYmUgbW9yZQo+
IG9mIHRoZXNlIGluIHRoZSB2YXJpb3VzIGRyaXZlcnMgdG9vLgo+Cj4+IE5vcmFsZi4KPj4KPj4K
Pgo+IC1qb2UKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
