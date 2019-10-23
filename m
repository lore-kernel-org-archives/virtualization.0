From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] drm/simple-kms: Standardize arguments for callbacks
Date: Wed, 23 Oct 2019 17:40:32 +0200
Message-ID: <CACRpkdYfh=9oextiC1rtQ2UQ72OW_0TqjCe4AmvRtXKVv_ZazQ@mail.gmail.com>
References: <20191023101256.20509-1-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191023101256.20509-1-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Eric Anholt <eric@anholt.net>, =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>, Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter <daniel.vetter@intel.com>, Emil Velikov <emil.velikov@collabora.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gV2VkLCBPY3QgMjMsIDIwMTkgYXQgMTI6MTMgUE0gRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZl
dHRlckBmZndsbC5jaD4gd3JvdGU6Cgo+IFBhc3NpbmcgdGhlIHdyb25nIHR5cGUgZmVlbHMgaWNr
eSwgZXZlcnl3aGVyZSBlbHNlIHdlIHVzZSB0aGUgcGlwZSBhcwo+IHRoZSBmaXJzdCBwYXJhbWV0
ZXIuIFNwb3R0ZWQgd2hpbGUgZGlzY3Vzc2luZyBwYXRjaGVzIHdpdGggVGhvbWFzCj4gWmltbWVy
bWFubi4KPgo+IHYyOiBNYWtlIHhlbiBjb21waWxlIGNvcnJlY3RseQo+Cj4gQWNrZWQtQnk6IFRo
b21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPiAodjEpCj4gQ2M6IFRob21hcyBa
aW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPgo+IENjOiBOb3JhbGYgVHLDuG5uZXMgPG5v
cmFsZkB0cm9ubmVzLm9yZz4KPiBDYzogR2VyZCBIb2ZmbWFubiA8a3JheGVsQHJlZGhhdC5jb20+
Cj4gQ2M6IEVyaWMgQW5ob2x0IDxlcmljQGFuaG9sdC5uZXQ+Cj4gQ2M6IEVtaWwgVmVsaWtvdiA8
ZW1pbC52ZWxpa292QGNvbGxhYm9yYS5jb20+Cj4gQ2M6IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCj4gQ2M6IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGlu
YXJvLm9yZz4KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgVmV0dGVyIDxkYW5pZWwudmV0dGVyQGlu
dGVsLmNvbT4KCk1ha2VzIHBlcmZlY3Qgc2Vuc2UuClJldmlld2VkLWJ5OiBMaW51cyBXYWxsZWlq
IDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+CgpZb3VycywKTGludXMgV2FsbGVpagpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
