From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH 7/8] drm: Nuke drm_atomic_helper_connector_dpms
Date: Wed, 26 Jul 2017 21:00:53 +0200
Message-ID: <96fd05d9-6cab-4a40-6a63-d0b9a5872434__37548.2897078202$1509078829$gmane$org@tronnes.org>
References: <20170725080122.20548-1-daniel.vetter@ffwll.ch>
	<20170725080122.20548-8-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170725080122.20548-8-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc: Martyn Welch <martyn.welch@collabora.co.uk>, Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Andrzej Hajda <a.hajda@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Romain Perier <romain.perier@collabora.com>, Daniel Vetter <daniel.vetter@intel.com>, Jyri Sarha <jsarha@ti.com>, Heiko Stuebner <heiko@sntech.de>, Marek Vasut <marex@denx.de>, linux-renesas-soc@vger.kernel.org, Archit Taneja <architt@codeaurora.org>, Lars-Peter Clausen <lars@metafoo.de>, Joonyoung Shim <jy0922.shim@samsung.com>, Kevin Hilman <khilman@baylibre.com>, Alexey Brodkin <abrodkin@synopsys.com>, Russell King <linux@armlinux.org.uk>, Krzy
List-Id: virtualization@lists.linuxfoundation.org

CkRlbiAyNS4wNy4yMDE3IDEwLjAxLCBza3JldiBEYW5pZWwgVmV0dGVyOgo+IEl0J3MgZGVhZCBj
b2RlLCB0aGUgY29yZSBoYW5kbGVzIGFsbCB0aGlzIGRpcmVjdGx5IG5vdy4KPgo+IFRoZSBvbmx5
IHNwZWNpYWwgY2FzZSBpcyBub3V2ZWF1IGFuZCB0ZGE5ODh4IHdoaWNoIHVzZWQgb25lIGZ1bmN0
aW9uCj4gZm9yIGJvdGggbGVnYWN5IG1vZGVzZXQgY29kZSBhbmQgLW52NTAgYXRvbWljIHdvcmxk
IGluc3RlYWQgb2YgMgo+IHZ0YWJsZXMuIEJ1dCBhbW91bnRzIHRvIGV4YWN0bHkgdGhlIHNhbWUu
Cj4KPiB2MjogUmViYXNlIG92ZXIgdGhlIHBhbmVsL2JyaWRlZyByZWZhY3RvcmluZ3MgaW4gc3Rt
L2x0ZGMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgVmV0dGVyIDxkYW5pZWwudmV0dGVyQGlu
dGVsLmNvbT4KLi4uCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90aW55ZHJtL2NvcmUv
dGlueWRybS1waXBlLmMgYi9kcml2ZXJzL2dwdS9kcm0vdGlueWRybS9jb3JlL3Rpbnlkcm0tcGlw
ZS5jCj4gaW5kZXggZWM0M2ZiN2FkOWU0Li43OWI2Njg3OTc3ZDMgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL3Rpbnlkcm0vY29yZS90aW55ZHJtLXBpcGUuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS90aW55ZHJtL2NvcmUvdGlueWRybS1waXBlLmMKPiBAQCAtNzEsNyArNzEsNiBAQCBz
dGF0aWMgdm9pZCB0aW55ZHJtX2Nvbm5lY3Rvcl9kZXN0cm95KHN0cnVjdCBkcm1fY29ubmVjdG9y
ICpjb25uZWN0b3IpCj4gICB9Cj4gICAKPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2Nvbm5l
Y3Rvcl9mdW5jcyB0aW55ZHJtX2Nvbm5lY3Rvcl9mdW5jcyA9IHsKPiAtCS5kcG1zID0gZHJtX2F0
b21pY19oZWxwZXJfY29ubmVjdG9yX2RwbXMsCj4gICAJLnJlc2V0ID0gZHJtX2F0b21pY19oZWxw
ZXJfY29ubmVjdG9yX3Jlc2V0LAo+ICAgCS5kZXRlY3QgPSB0aW55ZHJtX2Nvbm5lY3Rvcl9kZXRl
Y3QsCj4gICAJLmZpbGxfbW9kZXMgPSBkcm1faGVscGVyX3Byb2JlX3NpbmdsZV9jb25uZWN0b3Jf
bW9kZXMsCgpBY2tlZC1ieTogTm9yYWxmIFRyw7hubmVzIDxub3JhbGZAdHJvbm5lcy5vcmc+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
