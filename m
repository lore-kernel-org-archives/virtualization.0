From: sjur.brandeland@stericsson.com
Subject: [PATCHv2 vringh 2/3] virtio: Add module driver macro for virtio
	drivers.
Date: Tue, 12 Feb 2013 12:49:52 +0100
Message-ID: <1360669793-6921-3-git-send-email-sjur.brandeland__29164.1586497009$1360669883$gmane$org@stericsson.com>
References: <1360669793-6921-1-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1360669793-6921-1-git-send-email-sjur.brandeland@stericsson.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, "David S. Miller" <davem@davemloft.net>, Ohad Ben-Cohen <ohad@wizery.com>
Cc: Dmitry Tarnyagin <dmitry.tarnyagin@stericsson.com>, sjur@brendeland.net, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Erwan Yvin <erwan.yvin@stericsson.com>, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, =?UTF-8?q?Sjur=20Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

RnJvbTogU2p1ciBCcsOmbmRlbGFuZCA8c2p1ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29tPgoK
QWRkIGhlbHBlciBtYWNybyBmb3IgZHJpdmVycyB0aGF0IGRvbid0IGRvIGFueXRoaW5nCnNwZWNp
YWwgaW4gbW9kdWxlIGluaXQvZXhpdC4KClNpZ25lZC1vZmYtYnk6IFNqdXIgQnLDpm5kZWxhbmQg
PHNqdXIuYnJhbmRlbGFuZEBzdGVyaWNzc29uLmNvbT4KLS0tCiBpbmNsdWRlL2xpbnV4L3ZpcnRp
by5oIHwgICAgOSArKysrKysrKysKIDEgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAw
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvLmggYi9pbmNs
dWRlL2xpbnV4L3ZpcnRpby5oCmluZGV4IGNmOGFkYjEuLjAwY2NjNDAgMTAwNjQ0Ci0tLSBhL2lu
Y2x1ZGUvbGludXgvdmlydGlvLmgKKysrIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaApAQCAtMTI2
LDQgKzEyNiwxMyBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCB2aXJ0aW9fZHJpdmVyICpkcnZfdG9f
dmlydGlvKHN0cnVjdCBkZXZpY2VfZHJpdmVyICpkcnYpCiAKIGludCByZWdpc3Rlcl92aXJ0aW9f
ZHJpdmVyKHN0cnVjdCB2aXJ0aW9fZHJpdmVyICpkcnYpOwogdm9pZCB1bnJlZ2lzdGVyX3ZpcnRp
b19kcml2ZXIoc3RydWN0IHZpcnRpb19kcml2ZXIgKmRydik7CisKKy8qIG1vZHVsZV92aXJ0aW9f
ZHJpdmVyKCkgLSBIZWxwZXIgbWFjcm8gZm9yIGRyaXZlcnMgdGhhdCBkb24ndCBkbworICogYW55
dGhpbmcgc3BlY2lhbCBpbiBtb2R1bGUgaW5pdC9leGl0LiAgVGhpcyBlbGltaW5hdGVzIGEgbG90
IG9mCisgKiBib2lsZXJwbGF0ZS4gIEVhY2ggbW9kdWxlIG1heSBvbmx5IHVzZSB0aGlzIG1hY3Jv
IG9uY2UsIGFuZAorICogY2FsbGluZyBpdCByZXBsYWNlcyBtb2R1bGVfaW5pdCgpIGFuZCBtb2R1
bGVfZXhpdCgpCisgKi8KKyNkZWZpbmUgbW9kdWxlX3ZpcnRpb19kcml2ZXIoX192aXJ0aW9fZHJp
dmVyKSBcCisJbW9kdWxlX2RyaXZlcihfX3ZpcnRpb19kcml2ZXIsIHJlZ2lzdGVyX3ZpcnRpb19k
cml2ZXIsIFwKKwkJCXVucmVnaXN0ZXJfdmlydGlvX2RyaXZlcikKICNlbmRpZiAvKiBfTElOVVhf
VklSVElPX0ggKi8KLS0gCjEuNy41LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
