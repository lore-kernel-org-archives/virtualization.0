From: sjur.brandeland@stericsson.com
Subject: [PATCHv7 2/4] virtio_console: Use kmalloc instead of kzalloc
Date: Mon, 15 Oct 2012 09:57:34 +0200
Message-ID: <1350287856-5284-3-git-send-email-sjur.brandeland@stericsson.com>
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
QXZvaWQgdGhlIG1vcmUgY3B1IGV4cGVuc2l2ZSBremFsbG9jIHdoZW4gYWxsb2NhdGluZyBidWZm
ZXJzLgpPcmlnaW5hbGx5IGt6YWxsb2Mgd2FzIGludGVuZGVkIGZvciBpc29sYXRpbmcgdGhlIGd1
ZXN0IGZyb20KdGhlIGhvc3QgYnkgbm90IHNlbmRpbmcgcmFuZG9tIGd1ZXN0IGRhdGEgdG8gdGhl
IGhvc3QuIEJ1dCBkZXZpY2UKaXNvbGF0aW9uIGlzIG5vdCB5ZXQgaW4gcGxhY2Ugc28ga3phbGxv
YyBpcyBub3QgcmVhbGx5IG5lZWRlZC4KClNpZ25lZC1vZmYtYnk6IFNqdXIgQnLDpm5kZWxhbmQg
PHNqdXIuYnJhbmRlbGFuZEBzdGVyaWNzc29uLmNvbT4KLS0tCiBkcml2ZXJzL2NoYXIvdmlydGlv
X2NvbnNvbGUuYyB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci92aXJ0aW9fY29uc29sZS5j
IGIvZHJpdmVycy9jaGFyL3ZpcnRpb19jb25zb2xlLmMKaW5kZXggYzM2YjJmNi4uMzAxZDE3ZSAx
MDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3ZpcnRpb19jb25zb2xlLmMKKysrIGIvZHJpdmVycy9j
aGFyL3ZpcnRpb19jb25zb2xlLmMKQEAgLTM0OSw3ICszNDksNyBAQCBzdGF0aWMgc3RydWN0IHBv
cnRfYnVmZmVyICphbGxvY19idWYoc2l6ZV90IGJ1Zl9zaXplKQogCWJ1ZiA9IGttYWxsb2Moc2l6
ZW9mKCpidWYpLCBHRlBfS0VSTkVMKTsKIAlpZiAoIWJ1ZikKIAkJZ290byBmYWlsOwotCWJ1Zi0+
YnVmID0ga3phbGxvYyhidWZfc2l6ZSwgR0ZQX0tFUk5FTCk7CisJYnVmLT5idWYgPSBrbWFsbG9j
KGJ1Zl9zaXplLCBHRlBfS0VSTkVMKTsKIAlpZiAoIWJ1Zi0+YnVmKQogCQlnb3RvIGZyZWVfYnVm
OwogCWJ1Zi0+bGVuID0gMDsKLS0gCjEuNy41LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
