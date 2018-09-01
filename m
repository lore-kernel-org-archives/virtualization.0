From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 03/13] fbdev: add kerneldoc do
	remove_conflicting_framebuffers()
Date: Sat, 01 Sep 2018 16:08:45 +0200
Message-ID: <283fef19815b991700b56119d8d5874a2a8da44e.1535810304.git.mirq-linux__15691.0726488151$1535810859$gmane$org@rere.qmqm.pl>
References: <cover.1535810304.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1535810304.git.mirq-linux@rere.qmqm.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, linux-tegra@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, Jonathan Hunter <jonathanh@nvidia.com>, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>, Maxime Ripard <maxime.ripard@bootlin.com>, virtualization@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

RG9jdW1lbnQgcmVtb3ZlX2NvbmZsaWN0aW5nX2ZyYW1lYnVmZmVycygpIGJlaGF2aW91ci4KClNp
Z25lZC1vZmYtYnk6IE1pY2hhxYIgTWlyb3PFgmF3IDxtaXJxLWxpbnV4QHJlcmUucW1xbS5wbD4K
LS0tCiBkcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJtZW0uYyB8IDEwICsrKysrKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRl
by9mYmRldi9jb3JlL2ZibWVtLmMgYi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJtZW0uYwpp
bmRleCAwZGYxNDhlYjQ2OTkuLjJkZTkzYjUwMTRlMyAxMDA2NDQKLS0tIGEvZHJpdmVycy92aWRl
by9mYmRldi9jb3JlL2ZibWVtLmMKKysrIGIvZHJpdmVycy92aWRlby9mYmRldi9jb3JlL2ZibWVt
LmMKQEAgLTE3NzUsNiArMTc3NSwxNiBAQCBpbnQgdW5saW5rX2ZyYW1lYnVmZmVyKHN0cnVjdCBm
Yl9pbmZvICpmYl9pbmZvKQogfQogRVhQT1JUX1NZTUJPTCh1bmxpbmtfZnJhbWVidWZmZXIpOwog
CisvKioKKyAqIHJlbW92ZV9jb25mbGljdGluZ19mcmFtZWJ1ZmZlcnMgLSByZW1vdmUgZmlybXdh
cmUtY29uZmlndXJlZCBmcmFtZWJ1ZmZlcnMKKyAqIEBhOiBtZW1vcnkgcmFuZ2UsIHVzZXJzIG9m
IHdoaWNoIGFyZSB0byBiZSByZW1vdmVkCisgKiBAbmFtZTogcmVxdWVzdGluZyBkcml2ZXIgbmFt
ZQorICogQHByaW1hcnk6IGFsc28ga2ljayB2Z2ExNmZiIGlmIHByZXNlbnQKKyAqCisgKiBUaGlz
IGZ1bmN0aW9uIHJlbW92ZXMgZnJhbWVidWZmZXIgZGV2aWNlcyAoaW5pdGlhbGl6ZWQgYnkgZmly
bXdhcmUvYm9vdGxvYWRlcikKKyAqIHdoaWNoIHVzZSBtZW1vcnkgcmFuZ2UgZGVzY3JpYmVkIGJ5
IEBhLiBJZiBAYSBpcyBOVUxMIGFsbCBzdWNoIGRldmljZXMgYXJlCisgKiByZW1vdmVkLgorICov
CiBpbnQgcmVtb3ZlX2NvbmZsaWN0aW5nX2ZyYW1lYnVmZmVycyhzdHJ1Y3QgYXBlcnR1cmVzX3N0
cnVjdCAqYSwKIAkJCQkgICAgY29uc3QgY2hhciAqbmFtZSwgYm9vbCBwcmltYXJ5KQogewotLSAK
Mi4xOC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
