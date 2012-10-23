From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv7 3/4] virtio_console: Merge struct buffer_token into
	struct port_buffer
Date: Tue, 23 Oct 2012 10:49:24 +1030
Message-ID: <87fw56hwfn.fsf@rustcorp.com.au>
References: <1350287856-5284-1-git-send-email-sjur.brandeland@stericsson.com>
	<1350287856-5284-4-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1350287856-5284-4-git-send-email-sjur.brandeland@stericsson.com>
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

c2p1ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29tIHdyaXRlczoKPiBGcm9tOiBTanVyIEJyw6Zu
ZGVsYW5kIDxzanVyLmJyYW5kZWxhbmRAc3Rlcmljc3Nvbi5jb20+Cj4KPiBSZWZhY3RvcmluZyB0
aGUgc3BsaWNlIGZ1bmN0aW9uYWxpdHkgYnkgdW5pZnlpbmcgdGhlIGFwcHJvYWNoIGZvcgo+IHNl
bmRpbmcgc2NhdHRlci1saXN0cyBhbmQgcmVndWxhciBidWZmZXJzLiBUaGlzIHNpbXBsaWZpZXMK
PiBidWZmZXIgaGFuZGxpbmcgYW5kIHJlZHVjZXMgY29kZSBzaXplLiBTcGxpY2Ugd2lsbCBub3cg
YWxsb2NhdGUKPiBhIHBvcnRfYnVmZmVyIGFuZCBzZW5kX2J1ZigpIGFuZCBmcmVlX2J1ZigpIGNh
biBhbHdheXMgYmUgdXNlZAo+IGZvciBhbnkgYnVmZmVyLgo+Cj4gU2lnbmVkLW9mZi1ieTogU2p1
ciBCcsOmbmRlbGFuZCA8c2p1ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29tPgoKVGhpcyBsb29r
cyBzZW5zaWJsZTsgYSBjb3VwbGUgb2YgZXh0cmEgYmxhbmsgbGluZXMgaW5zZXJ0ZWQgdGhvdWdo
LgoKQW1pdD8KCj4gQEAgLTEwMzMsNiArMTAwOCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmls
ZV9vcGVyYXRpb25zIHBvcnRfZm9wcyA9IHsKPiAgc3RhdGljIGludCBwdXRfY2hhcnModTMyIHZ0
ZXJtbm8sIGNvbnN0IGNoYXIgKmJ1ZiwgaW50IGNvdW50KQo+ICB7Cj4gIAlzdHJ1Y3QgcG9ydCAq
cG9ydDsKPiArCXN0cnVjdCBzY2F0dGVybGlzdCBzZ1sxXTsKPiArCj4gIAo+ICAJaWYgKHVubGlr
ZWx5KGVhcmx5X3B1dF9jaGFycykpCj4gIAkJcmV0dXJuIGVhcmx5X3B1dF9jaGFycyh2dGVybW5v
LCBidWYsIGNvdW50KTsKPiBAQCAtMTA0MSw3ICsxMDE4LDkgQEAgc3RhdGljIGludCBwdXRfY2hh
cnModTMyIHZ0ZXJtbm8sIGNvbnN0IGNoYXIgKmJ1ZiwgaW50IGNvdW50KQo+ICAJaWYgKCFwb3J0
KQo+ICAJCXJldHVybiAtRVBJUEU7Cj4gIAo+IC0JcmV0dXJuIHNlbmRfYnVmKHBvcnQsICh2b2lk
ICopYnVmLCBjb3VudCwgZmFsc2UpOwo+ICsJc2dfaW5pdF9vbmUoc2csIGJ1ZiwgY291bnQpOwo+
ICsJcmV0dXJuIF9fc2VuZF90b19wb3J0KHBvcnQsIHNnLCAxLCBjb3VudCwgKHZvaWQgKilidWYs
IGZhbHNlKTsKPiArCj4gIH0KPiAgCj4gIC8qCgpDaGVlcnMsClJ1c3R5LgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
