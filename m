From: sjur.brandeland@stericsson.com
Subject: [PATCHv7 1/4] virtio_console: Free buffer if splice fails
Date: Mon, 15 Oct 2012 09:57:33 +0200
Message-ID: <1350287856-5284-2-git-send-email-sjur.brandeland__15141.7652763941$1350287901$gmane$org@stericsson.com>
References: <1350287856-5284-1-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1350287856-5284-1-git-send-email-sjur.brandeland@stericsson.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, =?UTF-8?q?Sjur=20Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

RnJvbTogU2p1ciBCcsOmbmRlbGFuZCA8c2p1ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29tPgoK
RnJlZSB0aGUgYWxsb2NhdGVkIHNjYXR0ZXIgbGlzdCBpZiBzZW5kX3BhZ2VzIGZhaWxzIGluIGZ1
bmN0aW9uCnBvcnRfc3BsaWNlX3dyaXRlLgoKU2lnbmVkLW9mZi1ieTogU2p1ciBCcsOmbmRlbGFu
ZCA8c2p1ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29tPgotLS0KIGRyaXZlcnMvY2hhci92aXJ0
aW9fY29uc29sZS5jIHwgICAgMiArKwogMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL3ZpcnRpb19jb25zb2xl
LmMgYi9kcml2ZXJzL2NoYXIvdmlydGlvX2NvbnNvbGUuYwppbmRleCA4YWI5YzNkLi5jMzZiMmY2
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdmlydGlvX2NvbnNvbGUuYworKysgYi9kcml2ZXJz
L2NoYXIvdmlydGlvX2NvbnNvbGUuYwpAQCAtODc5LDYgKzg3OSw4IEBAIHN0YXRpYyBzc2l6ZV90
IHBvcnRfZm9wc19zcGxpY2Vfd3JpdGUoc3RydWN0IHBpcGVfaW5vZGVfaW5mbyAqcGlwZSwKIAlp
ZiAobGlrZWx5KHJldCA+IDApKQogCQlyZXQgPSBzZW5kX3BhZ2VzKHBvcnQsIHNnbC5zZywgc2ds
Lm4sIHNnbC5sZW4sIHRydWUpOwogCisJaWYgKHVubGlrZWx5KHJldCA8PSAwKSkKKwkJa2ZyZWUo
c2dsLnNnKTsKIAlyZXR1cm4gcmV0OwogfQogCi0tIAoxLjcuNS40CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
