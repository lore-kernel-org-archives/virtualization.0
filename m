From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv8 0/3]virtio_console: Add rproc_serial driver
Date: Tue, 06 Nov 2012 12:23:31 +1030
Message-ID: <874nl35wf8.fsf@rustcorp.com.au>
References: <1351587113-2566-1-git-send-email-sjur@brendeland.net>
	<877gq1yora.fsf@rustcorp.com.au>
	<20121105103124.GA12402@amit.redhat.com>
	<20121105103144.GB12402@amit.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121105103144.GB12402@amit.redhat.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjur@brendeland.net>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

QW1pdCBTaGFoIDxhbWl0LnNoYWhAcmVkaGF0LmNvbT4gd3JpdGVzOgo+IE9uIChNb24pIDA1IE5v
diAyMDEyIFsxMTozMToyNF0sIEFtaXQgU2hhaCB3cm90ZToKPj4gT24gKE1vbikgMDUgTm92IDIw
MTIgWzA5OjExOjQ1XSwgUnVzdHkgUnVzc2VsbCB3cm90ZToKPj4gPiBTanVyIEJyw6ZuZGVsYW5k
IDxzanVyQGJyZW5kZWxhbmQubmV0PiB3cml0ZXM6Cj4+ID4gCj4+ID4gPiBGcm9tOiBTanVyIEJy
w6ZuZGVsYW5kIDxzanVyLmJyYW5kZWxhbmRAc3Rlcmljc3Nvbi5jb20+Cj4+ID4gPgo+PiA+ID4g
VGhpcyBwYXRjaC1zZXQgaW50cm9kdWNlcyBhIG5ldyB2aXJ0aW8gdHlwZSAicnByb2Nfc2VyaWFs
IiBmb3IgY29tbXVuaWNhdGluZwo+PiA+ID4gd2l0aCByZW1vdGUgcHJvY2Vzc29ycyBvdmVyIHNo
YXJlZCBtZW1vcnkuIFRoZSBkcml2ZXIgZGVwZW5kcyBvbiB0aGUKPj4gPiA+IHRoZSByZW1vdGVw
cm9jIGZyYW1ld29yay4gQXMgcHJlcGFyYXRpb24gZm9yIGludHJvZHVjaW5nICJycHJvY19zZXJp
YWwiCj4+ID4gPiBJJ3ZlIGRvbmUgYSByZWZhY3RvcmluZyBvZiB0aGUgdHJhbnNtaXQgYnVmZmVy
IGhhbmRsaW5nLgo+PiA+ID4KPj4gPiA+IENoYW5nZXMgc2luY2Ugdjc6Cj4+ID4gPiAtIFJlYmFz
ZWQgdG8gdmlydGlvLW5leHQgYnJhbmNoLgo+PiA+ID4gLSBSZW1vdmVkIGV4dHJhIGFkZGVkIGxp
bmVzLgo+PiA+ID4gLSBSZW1vdmVkIHN1cGVyZmx1b3VzIGNoZWNrcyBiZWZvcmUgY2FsbGluZyBy
ZWNsYWltX2RtYV9idWZzKCkuCj4+ID4gPiAtIFJ1c3R5IHJhaXNlZCBzb21lIHF1ZXN0aW9uIHJl
Z2FyZGluZyBnYXJiYWdlIGNvbGxlY3Rpb24gb2YgdGhlCj4+ID4gPiAgIG91dC12cSwgc28gSSBt
b3ZlZCB0aGlzIGludG8gYSBzZXBhcmF0ZSBwYXRjaC4KPj4gPiAKPj4gPiBPSywgSSdtIG5vdCBz
dXJlIHRoYXQgV0FSTl9PTiB3b24ndCBmaXJlLCBidXQgdGhhdCdzIG5vdCBhbGwgdGhhdAo+PiA+
IGhhcm1mdWwuCj4+IAo+PiBTanVyIHNhaWQgaGUnbGwgc2VuZCBvdXQgYSByZXNwaW4gZm9yIHRo
aXM7IGNhbiB5b3Ugd2FpdCBmb3IgaGlzIHY4Pwo+Cj4gRXIsIHY5Lgo+Cj4gCQlBbWl0CgpZZXAs
IHRoZXkncmUgaW4gbXkgcGVuZGluZy1yZWJhc2VzIHRyZWUgbm93LgoKVGhvdWdoIG5vIG5lZWQg
dG8gcmVwb3N0IHRoZSB3aG9sZSBzZXJpZXM7IGp1c3QgdGhlIGNoYW5nZXMgcGxlYXNlLgoKQ2hl
ZXJzLApSdXN0eS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
