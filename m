From: =?UTF-8?q?Sjur=20Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: [PATCH virtio-next 1/2] caif_virtio: Use vringh_notify_enable
	correctly
Date: Fri, 22 Mar 2013 16:24:41 +0100
Message-ID: <1363965883-23091-1-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: sjur@brendeland.net, Linus Walleij <linus.walleij@linaro.org>, erwan.yvin@stericsson.com, virtualization@lists.linux-foundation.org, davem@davemloft.net, =?UTF-8?q?Sjur=20Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

Q2hlY2sgb24gdGhlIGNvcnJlY3QgcmV0dXJuIHZhbHVlIGZyb20KdnJpbmdoX25vdGlmeV9lbmFi
bGVfa2VybigpLiBJdCByZXR1cm5zIGZhbHNlIGlmCm1vcmUgcGFja2V0cyBhcmUgYXZhaWxhYmxl
LCBub3QgdHJ1ZS4KClNpZ25lZC1vZmYtYnk6IFNqdXIgQnLDpm5kZWxhbmQgPHNqdXIuYnJhbmRl
bGFuZEBzdGVyaWNzc29uLmNvbT4KLS0tCkhpLAoKVGhpcyBwYXRjaCBhcHBsaWVzIHRvIFJ1c3R5
J3MgdmlydGlvLW5leHQgYnJhbmNoLgoKVGhhbmtzLApTanVyCiBkcml2ZXJzL25ldC9jYWlmL2Nh
aWZfdmlydGlvLmMgfCAgICAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9jYWlmL2NhaWZfdmlydGlvLmMg
Yi9kcml2ZXJzL25ldC9jYWlmL2NhaWZfdmlydGlvLmMKaW5kZXggZjZjYWExZS4uZmI4MDc2NSAx
MDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvY2FpZi9jYWlmX3ZpcnRpby5jCisrKyBiL2RyaXZlcnMv
bmV0L2NhaWYvY2FpZl92aXJ0aW8uYwpAQCAtMzE4LDcgKzMxOCw3IEBAIGV4aXQ6CiAKIAkJLyog
UmVhbGx5IG91dCBvZiBwYXRja2V0cz8gKHN0b2xlbiBmcm9tIHZpcnRpb19uZXQpKi8KIAkJbmFw
aV9jb21wbGV0ZShuYXBpKTsKLQkJaWYgKHVubGlrZWx5KHZyaW5naF9ub3RpZnlfZW5hYmxlX2tl
cm4oY2Z2LT52cl9yeCkpICYmCisJCWlmICh1bmxpa2VseSghdnJpbmdoX25vdGlmeV9lbmFibGVf
a2VybihjZnYtPnZyX3J4KSkgJiYKIAkJICAgIG5hcGlfc2NoZWR1bGVfcHJlcChuYXBpKSkgewog
CQkJdnJpbmdoX25vdGlmeV9kaXNhYmxlX2tlcm4oY2Z2LT52cl9yeCk7CiAJCQlfX25hcGlfc2No
ZWR1bGUobmFwaSk7Ci0tIAoxLjcuOS41CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
