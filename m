From: sjur.brandeland@stericsson.com
Subject: [PATCH 3/3] virtio_console: Don't initialize buffers to zero
Date: Tue, 25 Sep 2012 15:47:17 +0200
Message-ID: <1348580837-10919-4-git-send-email-sjur.brandeland@stericsson.com>
References: <1348580837-10919-1-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1348580837-10919-1-git-send-email-sjur.brandeland@stericsson.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: sjurbren@stericsson.com, =?UTF-8?q?Sjur=20Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

RnJvbTogU2p1ciBCcsOmbmRlbGFuZCA8c2p1ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29tPgoK
U2tpcCBpbml0aWFsaXppbmcgdGhlIHJlY2VpdmUgYnVmZmVycy4KClNpZ25lZC1vZmYtYnk6IFNq
dXIgQnLDpm5kZWxhbmQgPHNqdXIuYnJhbmRlbGFuZEBzdGVyaWNzc29uLmNvbT4KLS0tCiBkcml2
ZXJzL2NoYXIvdmlydGlvX2NvbnNvbGUuYyB8ICAgIDEgLQogMSBmaWxlcyBjaGFuZ2VkLCAwIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL3Zp
cnRpb19jb25zb2xlLmMgYi9kcml2ZXJzL2NoYXIvdmlydGlvX2NvbnNvbGUuYwppbmRleCBmYWVk
ZDJjLi5lN2Q4Nzg3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdmlydGlvX2NvbnNvbGUuYwor
KysgYi9kcml2ZXJzL2NoYXIvdmlydGlvX2NvbnNvbGUuYwpAQCAtMTM0NCw3ICsxMzQ0LDYgQEAg
c3RhdGljIHVuc2lnbmVkIGludCBmaWxsX3F1ZXVlKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCBzcGlu
bG9ja190ICpsb2NrKQogCQlpZiAoIWJ1ZikKIAkJCWJyZWFrOwogCi0JCW1lbXNldChidWYtPmJ1
ZiwgMCwgUEFHRV9TSVpFKTsKIAkJc3Bpbl9sb2NrX2lycShsb2NrKTsKIAkJcmV0ID0gYWRkX2lu
YnVmKHZxLCBidWYpOwogCQlpZiAocmV0IDwgMCkgewotLSAKMS43LjUuNAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
