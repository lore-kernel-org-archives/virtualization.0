From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 02/13] fbdev: allow apertures == NULL in
	remove_conflicting_framebuffers()
Date: Sat, 01 Sep 2018 16:08:44 +0200
Message-ID: <b5fed539fe569035139c8594c23effd8c39f12ca.1535810304.git.mirq-linux@rere.qmqm.pl>
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

SW50ZXJwcmV0IChvdGhlcndpc2UtaW52YWxpZCkgTlVMTCBhcGVydHVyZXMgYXJndW1lbnQgdG8g
bWVhbiBhbGwtbWVtb3J5CnJhbmdlLiBUaGlzIHdpbGwgYWxsb3cgdG8gcmVtb3ZlIHNldmVyYWwg
ZHVwbGljYXRlcyBvZiB0aGlzIGNvZGUKZnJvbSBkcml2ZXJzIGluIGZvbGxvd2luZyBwYXRjaGVz
LgoKU2lnbmVkLW9mZi1ieTogTWljaGHFgiBNaXJvc8WCYXcgPG1pcnEtbGludXhAcmVyZS5xbXFt
LnBsPgpBY2tlZC1ieTogQmFydGxvbWllaiBab2xuaWVya2lld2ljeiA8Yi56b2xuaWVya2llQHNh
bXN1bmcuY29tPgoKLS0tCnYyOiBhZGRlZCBrZXJuZWxkb2MgdG8gY29ycmVzcG9uZGluZyBEUk0g
aGVscGVyCnYzOiBzcGxpdCBrZXJuZWxkb2MgdG8gYW5vdGhlciBwYXRjaAotLS0KIGRyaXZlcnMv
dmlkZW8vZmJkZXYvY29yZS9mYm1lbS5jIHwgMTQgKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFu
Z2VkLCAxNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9mYmRldi9j
b3JlL2ZibWVtLmMgYi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJtZW0uYwppbmRleCAzMGEx
OGQ0YzlkZTQuLjBkZjE0OGViNDY5OSAxMDA2NDQKLS0tIGEvZHJpdmVycy92aWRlby9mYmRldi9j
b3JlL2ZibWVtLmMKKysrIGIvZHJpdmVycy92aWRlby9mYmRldi9jb3JlL2ZibWVtLmMKQEAgLTE3
NzksMTEgKzE3NzksMjUgQEAgaW50IHJlbW92ZV9jb25mbGljdGluZ19mcmFtZWJ1ZmZlcnMoc3Ry
dWN0IGFwZXJ0dXJlc19zdHJ1Y3QgKmEsCiAJCQkJICAgIGNvbnN0IGNoYXIgKm5hbWUsIGJvb2wg
cHJpbWFyeSkKIHsKIAlpbnQgcmV0OworCWJvb2wgZG9fZnJlZSA9IGZhbHNlOworCisJaWYgKCFh
KSB7CisJCWEgPSBhbGxvY19hcGVydHVyZXMoMSk7CisJCWlmICghYSkKKwkJCXJldHVybiAtRU5P
TUVNOworCisJCWEtPnJhbmdlc1swXS5iYXNlID0gMDsKKwkJYS0+cmFuZ2VzWzBdLnNpemUgPSB+
MDsKKwkJZG9fZnJlZSA9IHRydWU7CisJfQogCiAJbXV0ZXhfbG9jaygmcmVnaXN0cmF0aW9uX2xv
Y2spOwogCXJldCA9IGRvX3JlbW92ZV9jb25mbGljdGluZ19mcmFtZWJ1ZmZlcnMoYSwgbmFtZSwg
cHJpbWFyeSk7CiAJbXV0ZXhfdW5sb2NrKCZyZWdpc3RyYXRpb25fbG9jayk7CiAKKwlpZiAoZG9f
ZnJlZSkKKwkJa2ZyZWUoYSk7CisKIAlyZXR1cm4gcmV0OwogfQogRVhQT1JUX1NZTUJPTChyZW1v
dmVfY29uZmxpY3RpbmdfZnJhbWVidWZmZXJzKTsKLS0gCjIuMTguMAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
