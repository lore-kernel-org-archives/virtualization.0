From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv7 2/4] virtio_console: Use kmalloc instead of kzalloc
Date: Tue, 23 Oct 2012 12:06:34 +1030
Message-ID: <87d30ahsv1.fsf@rustcorp.com.au>
References: <1350287856-5284-1-git-send-email-sjur.brandeland@stericsson.com>
	<1350287856-5284-3-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1350287856-5284-3-git-send-email-sjur.brandeland@stericsson.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

c2p1ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29tIHdyaXRlczoKCj4gRnJvbTogU2p1ciBCcsOm
bmRlbGFuZCA8c2p1ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29tPgo+Cj4gQXZvaWQgdGhlIG1v
cmUgY3B1IGV4cGVuc2l2ZSBremFsbG9jIHdoZW4gYWxsb2NhdGluZyBidWZmZXJzLgo+IE9yaWdp
bmFsbHkga3phbGxvYyB3YXMgaW50ZW5kZWQgZm9yIGlzb2xhdGluZyB0aGUgZ3Vlc3QgZnJvbQo+
IHRoZSBob3N0IGJ5IG5vdCBzZW5kaW5nIHJhbmRvbSBndWVzdCBkYXRhIHRvIHRoZSBob3N0LiBC
dXQgZGV2aWNlCj4gaXNvbGF0aW9uIGlzIG5vdCB5ZXQgaW4gcGxhY2Ugc28ga3phbGxvYyBpcyBu
b3QgcmVhbGx5IG5lZWRlZC4KPgo+IFNpZ25lZC1vZmYtYnk6IFNqdXIgQnLDpm5kZWxhbmQgPHNq
dXIuYnJhbmRlbGFuZEBzdGVyaWNzc29uLmNvbT4KClRoaXMgbG9va3MgZmluZSB0byBtZS4gIFRo
aXMgaXMgKndoeSogdGhlIGRldmljZSBnaXZlcyB1cyB0aGUgbGVuZ3RoCndoaWNoIHdhcyB3cml0
dGVuOyB3ZSBjYW4gdHJ1c3QgdGhhdCwgZXZlbiBpZiB3ZSBjYW4ndCB0cnVzdCB0aGUKd3JpdGVy
IG9mIGRhdGEuCgooSW4gdGhlb3J5OiBub29uZSBoYXMgaW1wbGVtZW50ZWQgc3VjaCBhIHN5c3Rl
bSwgeWV0KS4KCkFwcGxpZWQuClJ1c3R5LgoKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL3Zp
cnRpb19jb25zb2xlLmMgYi9kcml2ZXJzL2NoYXIvdmlydGlvX2NvbnNvbGUuYwo+IGluZGV4IGMz
NmIyZjYuLjMwMWQxN2UgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9jaGFyL3ZpcnRpb19jb25zb2xl
LmMKPiArKysgYi9kcml2ZXJzL2NoYXIvdmlydGlvX2NvbnNvbGUuYwo+IEBAIC0zNDksNyArMzQ5
LDcgQEAgc3RhdGljIHN0cnVjdCBwb3J0X2J1ZmZlciAqYWxsb2NfYnVmKHNpemVfdCBidWZfc2l6
ZSkKPiAgCWJ1ZiA9IGttYWxsb2Moc2l6ZW9mKCpidWYpLCBHRlBfS0VSTkVMKTsKPiAgCWlmICgh
YnVmKQo+ICAJCWdvdG8gZmFpbDsKPiAtCWJ1Zi0+YnVmID0ga3phbGxvYyhidWZfc2l6ZSwgR0ZQ
X0tFUk5FTCk7Cj4gKwlidWYtPmJ1ZiA9IGttYWxsb2MoYnVmX3NpemUsIEdGUF9LRVJORUwpOwo+
ICAJaWYgKCFidWYtPmJ1ZikKPiAgCQlnb3RvIGZyZWVfYnVmOwo+ICAJYnVmLT5sZW4gPSAwOwo+
IC0tIAo+IDEuNy41LjQKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
