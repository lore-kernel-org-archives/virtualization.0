From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Re: Re: [RFC PATCH 0/6] virtio-trace: Support virtio-trace
Date: Thu, 26 Jul 2012 11:52:09 +0100
Message-ID: <CAJSP0QUJkZrMMU6_OZsX7jCCnikvYmmPKkQui=qsdYxWTz1xCw@mail.gmail.com>
References: <20120724023657.6600.52706.stgit@ltc189.sdl.hitachi.co.jp>
	<CAJSP0QW_2JJ0nf=NW0y30VSid2HSxaqb=mRGV8CTtAKj0ujDWw@mail.gmail.com>
	<500E810A.4030309@hitachi.com> <500E84D7.7060103@hitachi.com>
	<CAJSP0QVuQnE68n=jyW+AE=WF3yDHjgdn7tdiz7rPTbtqGYFL4w@mail.gmail.com>
	<500FB8A4.6060503@hitachi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <500FB8A4.6060503@hitachi.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frederic Weisbecker <fweisbec@gmail.com>, Dhaval Giani <dhaval.giani@gmail.com>, linux-kernel@vger.kernel.org, Borislav Petkov <bp@amd64.org>, qemu-devel@nongnu.org, Amit Shah <amit.shah@redhat.com>, "Franch Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, Anthony Liguori <anthony@codemonkey.ws>, yrl.pp-manager.tt@hitachi.com, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, virtualization@lists.linux-foundation.org, Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gV2VkLCBKdWwgMjUsIDIwMTIgYXQgMTA6MTMgQU0sIFlvc2hpaGlybyBZVU5PTUFFCjx5b3No
aWhpcm8ueXVub21hZS5lekBoaXRhY2hpLmNvbT4gd3JvdGU6Cj4gSGkgU3RlZmFuLAo+Cj4KPiAo
MjAxMi8wNy8yNCAyMjo0MSksIFN0ZWZhbiBIYWpub2N6aSB3cm90ZToKPj4KPj4gT24gVHVlLCBK
dWwgMjQsIDIwMTIgYXQgMTI6MTkgUE0sIFlvc2hpaGlybyBZVU5PTUFFCj4+IDx5b3NoaWhpcm8u
eXVub21hZS5lekBoaXRhY2hpLmNvbT4gd3JvdGU6Cj4+Pj4+Cj4+Pj4+IEFyZSB5b3UgdXNpbmcg
dGV4dCBmb3JtYXR0ZWQgZnRyYWNlPwo+Pj4KPj4+IE5vLCBjdXJyZW50bHkgdXNpbmcgcmF3IGZv
cm1hdCwgYnV044CAd2UnZCBsaWtlIHRvIHJlZm9ybWF0IGl0IGluIHRleHQuCj4+Cj4+Cj4+IENh
cHR1cmluZyB0aGUgaW5mbyBuZWNlc3NhcnkgdG8gdHJhbnNsYXRlIG51bWJlcnMgaW50byBzeW1i
b2xzIGlzIG9uZQo+PiBvZiB0aGUgcHJvYmxlbXMgb2YgaG9zdDwtPmd1ZXN0IHRyYWNpbmcgc28g
SSdtIGN1cmlvdXMgaG93IHlvdSBoYW5kbGUKPj4gdGhpcyA6KS4KPgo+Cj4gUmlnaHQsIHlvdXIg
Y29uc2lkZXJhdGlvbiBpcyB0cnVlLgo+Cj4KPj4gQXBvbG9naWVzIGZvciBteSBsYWNrIG9mIGZ0
cmFjZSBrbm93bGVkZ2UgYnV0IGhvdyB1c2VmdWwgaXMgdGhlIHJhdwo+PiB0cmFjaW5nIGRhdGEg
b24gdGhlIGhvc3Q/ICBIb3cgZG8geW91IHByZXR0eS1wcmludCBpdCBpbgo+PiBodW1hbi1yZWFk
YWJsZSBmb3JtPwo+Cj4KPiBwZXJmIGFuZCB0cmFjZS1jbWQgY2FuIGFjdHVhbGx5IHRyYW5zbGF0
ZSByYXctZm9ybWF0dGVkIHRyYWNlIGRhdGEgdG8KPiB0ZXh0LWZvcm1hdHRlZCB0cmFjZSBkYXRh
IGJ5IHVzaW5nIGluZm9ybWF0aW9uIG9mIGtlcm5lbCBvciB0cmFjZQo+IGZvcm1hdCB1bmRlciB0
cmFjaW5nL2V2ZW50cyBkaXJlY3RvcnkgaW4gZGVidWdmcy4gSW4gdGhlIHNhbWUgd2F5LCBpZgo+
IHRoZSBpbmZvcm1hdGlvbiBvZiBhIGd1ZXN0IGlzIGV4cG9ydGVkIHRvIGEgaG9zdCwgd2UgY2Fu
IHRyYW5zbGF0ZQo+IHJhdyB0cmFjZSBkYXRhIG9mIGEgZ3Vlc3QgdG8gdGV4dCB0cmFjZSBkYXRh
IG9uIGEgaG9zdC4gV2Ugd2lsbCB1c2UKPiA5cGZzIHRvIGV4cG9ydCB0aGF0LgoKVGhhbmtzLCBp
dCdzIGNsZWFyIG5vdyA6KS4KClN0ZWZhbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
