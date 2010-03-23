From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 7/8] virtio: console: Fix early_put_chars usage
Date: Tue, 23 Mar 2010 18:23:15 +0530
Message-ID: <1269348796-8660-8-git-send-email-amit.shah@redhat.com>
References: <1269348796-8660-1-git-send-email-amit.shah@redhat.com>
	<1269348796-8660-2-git-send-email-amit.shah@redhat.com>
	<1269348796-8660-3-git-send-email-amit.shah@redhat.com>
	<1269348796-8660-4-git-send-email-amit.shah@redhat.com>
	<1269348796-8660-5-git-send-email-amit.shah@redhat.com>
	<1269348796-8660-6-git-send-email-amit.shah@redhat.com>
	<1269348796-8660-7-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1269348796-8660-7-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>, =?utf-8?q?Fran=C3=A7ois=20Diakhat=C3=A9?= <fdiakh@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

RnJvbTogRnJhbsOnb2lzIERpYWtoYXTDqSA8ZmRpYWtoQGdtYWlsLmNvbT4KCkN1cnJlbnRseSBl
YXJseV9wdXRfY2hhcnMgaXMgbm90IHVzZWQgYnkgdmlydGlvX2NvbnNvbGUgYmVjYXVzZSBpdCBj
YW4Kb25seSBiZSB1c2VkIG9uY2UgYSBwb3J0IGhhcyBiZWVuIGZvdW5kLCBhdCB3aGljaCBwb2lu
dCBpdCdzIHRvbyBsYXRlCmJlY2F1c2UgaXQgaXMgbm8gbG9uZ2VyIG5lZWRlZC4gVGhpcyBwYXRj
aCBzaG91bGQgZml4IGl0LgoKQWNrZWQtYnk6IENocmlzdGlhbiBCb3JudHJhZWdlciA8Ym9ybnRy
YWVnZXJAZGUuaWJtLmNvbT4KU2lnbmVkLW9mZi1ieTogQW1pdCBTaGFoIDxhbWl0LnNoYWhAcmVk
aGF0LmNvbT4KLS0tCiBkcml2ZXJzL2NoYXIvdmlydGlvX2NvbnNvbGUuYyB8ICAgIDYgKysrLS0t
CiAxIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2NoYXIvdmlydGlvX2NvbnNvbGUuYyBiL2RyaXZlcnMvY2hhci92aXJ0
aW9fY29uc29sZS5jCmluZGV4IDE4YjFiMDYuLmYzM2NlYWEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Y2hhci92aXJ0aW9fY29uc29sZS5jCisrKyBiL2RyaXZlcnMvY2hhci92aXJ0aW9fY29uc29sZS5j
CkBAIC02NTAsMTMgKzY1MCwxMyBAQCBzdGF0aWMgaW50IHB1dF9jaGFycyh1MzIgdnRlcm1ubywg
Y29uc3QgY2hhciAqYnVmLCBpbnQgY291bnQpCiB7CiAJc3RydWN0IHBvcnQgKnBvcnQ7CiAKKwlp
ZiAodW5saWtlbHkoZWFybHlfcHV0X2NoYXJzKSkKKwkJcmV0dXJuIGVhcmx5X3B1dF9jaGFycyh2
dGVybW5vLCBidWYsIGNvdW50KTsKKwogCXBvcnQgPSBmaW5kX3BvcnRfYnlfdnRlcm1ubyh2dGVy
bW5vKTsKIAlpZiAoIXBvcnQpCiAJCXJldHVybiAwOwogCi0JaWYgKHVubGlrZWx5KGVhcmx5X3B1
dF9jaGFycykpCi0JCXJldHVybiBlYXJseV9wdXRfY2hhcnModnRlcm1ubywgYnVmLCBjb3VudCk7
Ci0KIAlyZXR1cm4gc2VuZF9idWYocG9ydCwgKHZvaWQgKilidWYsIGNvdW50KTsKIH0KIAotLSAK
MS42LjIuNQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
