From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [Intel-gfx] [PATCH libdrm] drm: Remove create_handle()
	drm_framebuffer "virtual".
Date: Fri, 11 Aug 2017 00:52:13 +0100
Message-ID: <CACvgo53_Xfyaqhqe=+LMKOwJUbBnnoLuJu+gi0P+4AfJmH7Fmg__47672.5433989943$1502409156$gmane$org@mail.gmail.com>
References: <20170808234237.62051-1-djmk@google.com>
	<8a7bf59a-0f58-21ba-8b82-78e6ba873065@tronnes.org>
	<CAOvnNvbEt=Uyve3cu_+6BB0EepvO=OKC6gpV3isRef+UdVoX-g@mail.gmail.com>
	<CAOvnNvbNNtuLFy+7-beF=kGB0qYJckT_MEef3_=t-eWi-NFGXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAOvnNvbNNtuLFy+7-beF=kGB0qYJckT_MEef3_=t-eWi-NFGXA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joe Kniss <djmk@google.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Edward O'Callaghan <funfunctor@folklore1984.net>, Dave Airlie <airlied@linux.ie>, nouveau <nouveau@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "Vetter,
	Daniel" <daniel.vetter@intel.com>, Baoyou Xie <baoyou.xie@linaro.org>, Alex Xie <AlexBin.Xie@amd.com>, "StDenis,
	Tom" <tom.stdenis@amd.com>, zhoucm1 <David1.Zhou@amd.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Joonyoung Shim <jy0922.shim@samsung.com>, Russell King <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk@kernel.org>, jonathanh@nvidia.com, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Tomi
List-Id: virtualization@lists.linuxfoundation.org

T24gMTAgQXVndXN0IDIwMTcgYXQgMjA6MjksIEpvZSBLbmlzcyA8ZGpta0Bnb29nbGUuY29tPiB3
cm90ZToKPiBPbiBXZWQsIEF1ZyA5LCAyMDE3IGF0IDQ6MTMgUE0sIEpvZSBLbmlzcyA8ZGpta0Bn
b29nbGUuY29tPiB3cm90ZToKPj4gT24gV2VkLCBBdWcgOSwgMjAxNyBhdCAxMjoxNCBQTSwgTm9y
YWxmIFRyw7hubmVzIDxub3JhbGZAdHJvbm5lcy5vcmc+IHdyb3RlOgo+Pj4KPj4+IERlbiAwOS4w
OC4yMDE3IDAxLjQyLCBza3JldiBKb2UgS25pc3M6Cj4+Pj4KPj4+PiBCZWNhdXNlIGFsbCBkcml2
ZXJzIGN1cnJlbnRseSB1c2UgZ2VtIG9iamVjdHMgZm9yIGZyYW1lYnVmZmVyIHBsYW5lcywKPj4+
PiB0aGUgdmlydHVhbCBjcmVhdGVfaGFuZGxlKCkgaXMgbm90IHJlcXVpcmVkLiAgVGhpcyBjaGFu
Z2UgYWRkcyBhCj4+Pj4gc3RydWN0IGRybV9nZW1fb2JqZWN0ICpnZW1zWzRdIGZpZWxkIHRvIGRy
bV9mcmFtZWJ1ZmZlciBhbmQgcmVtb3Zlcwo+Pj4+IGNyZWF0ZV9oYW5kbGUoKSBmdW5jdGlvbiBw
b2ludGVyIGZyb20gZHJtX2ZyYW1lYnVmZmVyX2Z1bmNzLiAgVGhlCj4+Pj4gY29ycmVzcG9uZGlu
ZyAqX2NyZWF0ZV9oYW5kbGUoKSBmdW5jdGlvbiBpcyByZW1vdmVkIGZyb20gZWFjaCBkcml2ZXIu
Cj4+Pj4KPj4+PiBJbiBtYW55IGNhc2VzIHRoaXMgY2hhbmdlIGVsaW1pbmF0ZXMgYSBzdHJ1Y3Qg
Kl9mcmFtZWJ1ZmZlciBvYmplY3QsCj4+Pj4gYXMgdGhlIG9ubHkgbmVlZCBmb3IgdGhlIGRlcml2
ZWQgc3RydWN0IGlzIHRoZSBhZGRpdGlvbiBvZiB0aGUgZ2VtCj4+Pj4gb2JqZWN0IHBvaW50ZXIu
Cj4+Pj4KPj4+PiBURVNURUQ6IGNvbXBpbGVkOiBhbGx5ZXNjb25maWcgQVJDSD14ODYsYXJtIHBs
YXRmb3JtczppOTE1LCByb2NrY2hpcAo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogSm9lIEtuaXNz
IDxkam1rQGdvb2dsZS5jb20+Cj4+Pj4gLS0tCj4+Pgo+Pj4KPj4+IEhpIEpvZSwKPj4+Cj4+PiBJ
J20gYWxzbyBsb29raW5nIGludG8gYWRkaW5nIGdlbSBvYmpzIHRvIGRybV9mcmFtZWJ1ZmZlciBp
biB0aGlzIHBhdGNoOgo+Pj4gW1BBVENIIHYyIDAxLzIyXSBkcm06IEFkZCBHRU0gYmFja2VkIGZy
YW1lYnVmZmVyIGxpYnJhcnkKPj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL2FyY2hp
dmVzL2RyaS1kZXZlbC8yMDE3LUF1Z3VzdC8xNDk3ODIuaHRtbAo+Pj4KPj4KPj4gR3JlYXQuICBU
aGVyZSdzIG9ubHkgbWluaW1hbCBvdmVybGFwIGhlcmUuICBJJ2xsIHJlYmFzZSB0aGlzIGNoYW5n
ZSBvbiB5b3Vycwo+PiBvbmNlIGl0J3MgaW4uCj4+Cj4+PiBbLi4uXQo+Pj4KPj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV9mYl9jbWFfaGVscGVyLmMKPj4+PiBiL2RyaXZlcnMv
Z3B1L2RybS9kcm1fZmJfY21hX2hlbHBlci5jCj4+Pj4gaW5kZXggYWRlMzE5ZDEwZTcwLi5mNWYw
MTFiOTEwYjEgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9mYl9jbWFfaGVs
cGVyLmMKPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2ZiX2NtYV9oZWxwZXIuYwo+Pj4+
IEBAIC0zMSwxNCArMzEsOSBAQAo+Pj4+ICAgICAjZGVmaW5lIERFRkFVTFRfRkJERUZJT19ERUxB
WV9NUyA1MAo+Pj4+ICAgLXN0cnVjdCBkcm1fZmJfY21hIHsKPj4+PiAtICAgICAgIHN0cnVjdCBk
cm1fZnJhbWVidWZmZXIgICAgICAgICAgZmI7Cj4+Pj4gLSAgICAgICBzdHJ1Y3QgZHJtX2dlbV9j
bWFfb2JqZWN0ICAgICAgICpvYmpbNF07Cj4+Pj4gLX07Cj4+Pj4gLQo+Pj4+ICAgc3RydWN0IGRy
bV9mYmRldl9jbWEgewo+Pj4+ICAgICAgICAgc3RydWN0IGRybV9mYl9oZWxwZXIgICAgZmJfaGVs
cGVyOwo+Pj4+IC0gICAgICAgc3RydWN0IGRybV9mYl9jbWEgICAgICAgKmZiOwo+Pj4+ICsgICAg
ICAgc3RydWN0IGRybV9mcmFtZWJ1ZmZlciAgKmZiOwo+Pj4KPj4+Cj4+PiBUaGlzIGZiIHBvaW50
ZXIgaXNuJ3QgbmVjZXNzYXJ5LCBzaW5jZSBmYl9oZWxwZXIgYWxyZWFkeSBoYXMgb25lLgo+Pj4K
Pgo+IFNvLCBsb29raW5nIGRlZXBlciBpbnRvIHRoaXMsIGl0IHNlZW1zIHRoYXQgdGhlIHN0cnVj
dAo+IGRybV9mcmFtZWJ1ZmZlcl9mdW5jcyAqZmJfZnVuY3MgaXMgYWxzbyByZWR1bmRhbnQgaGVy
ZT8gIEluIHdoaWNoIGNhc2UKPiB0aGlzIHdob2xlIHN0cnVjdCBjYW4gZ28uLi4KPgpJIHRoaW5r
IHlvdSdyZSBzcG90IG9uLgoKUGVyaGFwcyB0aGUgZ29hbCB3YXMgdG8gYWxsb3cgZHJpdmVycyB0
byB1c2Ugc2VwYXJhdGUgZnVuY3MgZm9yIGZiIHZzIGZiZGV2PwpOb3Qgc3VyZSBob3cgd2VsbCB0
aGF0IHdpbGwgZmFpciwgeWV0IGFnYWluLCBhbGwgY3VycmVudCB1c2VycyB1c2UgdGhlCnNhbWUg
ZnVuY3MgZm9yIGJvdGguCgotRW1pbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
