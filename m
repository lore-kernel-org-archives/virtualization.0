From: =?UTF-8?q?Sjur=20Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: [PATCH virtio-next 2/2] caif_virtio: Check that vringh_config is not
	null
Date: Fri, 22 Mar 2013 16:24:42 +0100
Message-ID: <1363965883-23091-2-git-send-email-sjur.brandeland@stericsson.com>
References: <1363965883-23091-1-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363965883-23091-1-git-send-email-sjur.brandeland@stericsson.com>
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

Q2hlY2sgdGhhdCB2cmluZ2hfY29uZmlnIGlzIG5vdCBOVUxMIGJlZm9yZSB1c2luZyBpdC4KClNp
Z25lZC1vZmYtYnk6IFNqdXIgQnLDpm5kZWxhbmQgPHNqdXIuYnJhbmRlbGFuZEBzdGVyaWNzc29u
LmNvbT4KLS0tCgpIaSwKClRoaXMgcGF0Y2ggYXBwbGllcyB0byBSdXN0eSdzIHZpcnRpby1uZXh0
IGJyYW5jaC4KClRoYW5rcywKU2p1cgoKIGRyaXZlcnMvbmV0L2NhaWYvY2FpZl92aXJ0aW8uYyB8
ICAgIDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L2NhaWYvY2FpZl92aXJ0aW8uYyBiL2RyaXZlcnMvbmV0L2NhaWYvY2FpZl92
aXJ0aW8uYwppbmRleCBmYjgwNzY1Li4zMTZiMTg0IDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC9j
YWlmL2NhaWZfdmlydGlvLmMKKysrIGIvZHJpdmVycy9uZXQvY2FpZi9jYWlmX3ZpcnRpby5jCkBA
IC02NzAsNiArNjcwLDEwIEBAIHN0YXRpYyBpbnQgY2Z2X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2
aWNlICp2ZGV2KQogCXNwaW5fbG9ja19pbml0KCZjZnYtPnR4X2xvY2spOwogCiAJLyogR2V0IHRo
ZSBSWCB2aXJ0aW8gcmluZy4gVGhpcyBpcyBhICJob3N0IHNpZGUgdnJpbmciLiAqLworCWVyciA9
IC1FTk9ERVY7CisJaWYgKCF2ZGV2LT52cmluZ2hfY29uZmlnIHx8ICF2ZGV2LT52cmluZ2hfY29u
ZmlnLT5maW5kX3ZyaHMpCisJCWdvdG8gZXJyOworCiAJZXJyID0gdmRldi0+dnJpbmdoX2NvbmZp
Zy0+ZmluZF92cmhzKHZkZXYsIDEsICZjZnYtPnZyX3J4LCAmdnJoX2Nicyk7CiAJaWYgKGVycikK
IAkJZ290byBlcnI7Ci0tIAoxLjcuOS41CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
