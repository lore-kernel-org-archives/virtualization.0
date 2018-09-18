From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [patch 09/11] x86/vdso: Simplify the invalid vclock case
Date: Tue, 18 Sep 2018 07:01:12 -0700
Message-ID: <863331ED-B04A-4B94-91A2-D34002C9CCDC__9823.56521203673$1537279156$gmane$org@amacapital.net>
References: <20180914125006.349747096@linutronix.de>
	<20180914125118.909646643@linutronix.de>
	<CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com>
	<CALAqxLUv9Rd_eA7u9gZNFvTNrT1Z67RpHLozdeNC0W2yZm=Heg@mail.gmail.com>
	<alpine.DEB.2.21.1809180948570.3558@nanos.tec.linutronix.de>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.1809180948570.3558@nanos.tec.linutronix.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Florian Weimer <fweimer@redhat.com>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, devel@linuxdriverproject.org, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

Cj4gT24gU2VwIDE4LCAyMDE4LCBhdCAxMjo1MiBBTSwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxp
bnV0cm9uaXguZGU+IHdyb3RlOgo+IAo+PiBPbiBNb24sIDE3IFNlcCAyMDE4LCBKb2huIFN0dWx0
eiB3cm90ZToKPj4+IE9uIE1vbiwgU2VwIDE3LCAyMDE4IGF0IDEyOjI1IFBNLCBBbmR5IEx1dG9t
aXJza2kgPGx1dG9Aa2VybmVsLm9yZz4gd3JvdGU6Cj4+PiBBbHNvLCBJJ20gbm90IGVudGlyZWx5
IGNvbnZpbmNlZCB0aGF0IHRoaXMgImxhc3QiIHRoaW5nIGlzIG5lZWRlZCBhdAo+Pj4gYWxsLiAg
Sm9obiwgd2hhdCdzIHRoZSBzY2VuYXJpbyB1bmRlciB3aGljaCB3ZSBuZWVkIGl0Pwo+PiAKPj4g
U28gbXkgbWVtb3J5IGlzIHByb2JhYmx5IGEgYml0IGZvZ2d5LCBidXQgSSByZWNhbGwgdGhhdCBh
cyB3ZQo+PiBhY2NlbGVyYXRlZCBnZXR0aW1lb2ZkYXksIHdlIGZvdW5kIHRoYXQgZXZlbiBvbiBz
eXN0ZW1zIHRoYXQgY2xhaW1lZAo+PiB0byBoYXZlIHN5bmNlZCBUU0NzLCB0aGV5IHdlcmUgYWN0
dWFsbHkganVzdCBzbGlnaHRseSBvdXQgb2Ygc3luYy4KPj4gRW5vdWdoIHRoYXQgcmlnaHQgYWZ0
ZXIgY3ljbGVzX2xhc3QgaGFkIGJlZW4gdXBkYXRlZCwgYSByZWFkIG9uCj4+IGFub3RoZXIgY3B1
IGNvdWxkIGNvbWUgaW4ganVzdCBiZWhpbmQgY3ljbGVzX2xhc3QsIHJlc3VsdGluZyBpbiBhCj4+
IG5lZ2F0aXZlIGludGVydmFsIGNhdXNpbmcgbG90cyBvZiBoYXZvYy4KPj4gCj4+IFNvIHRoZSBz
YW5pdHkgY2hlY2sgaXMgbmVlZGVkIHRvIGF2b2lkIHRoYXQgY2FzZS4KPiAKPiBZb3VyIG1lbW9y
eSBzZXJ2ZXMgeW91IHJpZ2h0LiBUaGF0J3MgaW5kZWVkIG9ic2VydmFibGUgb24gQ1BVcyB3aGlj
aAo+IGxhY2sgVFNDX0FESlVTVC4KPiAKPiBAQW5keTogV2VsY29tZSB0byB0aGUgd29uZGVyZnVs
IHdvcmxkIG9mIFRTQy4KPiAKCkRvIHdlIGRvIGJldHRlciBpZiB3ZSB1c2Ugc2lnbmVkIGFyaXRo
bWV0aWMgZm9yIHRoZSB3aG9sZSBjYWxjdWxhdGlvbj8gVGhlbiBhIHNtYWxsIGJhY2t3YXJkcyBt
b3ZlbWVudCB3b3VsZCByZXN1bHQgaW4gYSBzbWFsbCBiYWNrd2FyZHMgcmVzdWx0LiAgT3Igd2Ug
Y291bGQgb2Zmc2V0IGV2ZXJ5dGhpbmcgc28gdGhhdCB3ZeKAmWQgaGF2ZSB0byBnbyBiYWNrIHNl
dmVyYWwgaHVuZHJlZCBtcyBiZWZvcmUgd2UgY3Jvc3MgemVyby4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
