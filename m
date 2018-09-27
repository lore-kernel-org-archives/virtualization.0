From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [patch 09/11] x86/vdso: Simplify the invalid vclock case
Date: Thu, 27 Sep 2018 07:39:06 -0700
Message-ID: <ABD3F880-C028-431B-A70D-E94D7F73154D__18395.0216895484$1538059028$gmane$org@amacapital.net>
References: <20180914125006.349747096@linutronix.de>
	<20180914125118.909646643@linutronix.de>
	<CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com>
	<CALAqxLUv9Rd_eA7u9gZNFvTNrT1Z67RpHLozdeNC0W2yZm=Heg@mail.gmail.com>
	<alpine.DEB.2.21.1809180948570.3558@nanos.tec.linutronix.de>
	<863331ED-B04A-4B94-91A2-D34002C9CCDC@amacapital.net>
	<alpine.DEB.2.21.1809190037570.1468@nanos.tec.linutronix.de>
	<439A3E73-E4FF-4D66-800E-5BEE58EDE8F6@amacapital.net>
	<alpine.DEB.2.21.1809190112020.1468@nanos.tec.linutronix.de>
	<alpine.DEB.2.21.1809271630470.8118@nanos.tec.linutronix.de>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.1809271630470.8118@nanos.tec.linutronix.de>
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

Cgo+IE9uIFNlcCAyNywgMjAxOCwgYXQgNzozNiBBTSwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxp
bnV0cm9uaXguZGU+IHdyb3RlOgo+IAo+PiBPbiBXZWQsIDE5IFNlcCAyMDE4LCBUaG9tYXMgR2xl
aXhuZXIgd3JvdGU6Cj4+IE9uIFR1ZSwgMTggU2VwIDIwMTgsIEFuZHkgTHV0b21pcnNraSB3cm90
ZToKPj4+PiBPbiBTZXAgMTgsIDIwMTgsIGF0IDM6NDYgUE0sIFRob21hcyBHbGVpeG5lciA8dGds
eEBsaW51dHJvbml4LmRlPiB3cm90ZToKPj4+Pj4gT24gVHVlLCAxOCBTZXAgMjAxOCwgQW5keSBM
dXRvbWlyc2tpIHdyb3RlOgo+Pj4+PiBEbyB3ZSBkbyBiZXR0ZXIgaWYgd2UgdXNlIHNpZ25lZCBh
cml0aG1ldGljIGZvciB0aGUgd2hvbGUgY2FsY3VsYXRpb24/Cj4+Pj4+IFRoZW4gYSBzbWFsbCBi
YWNrd2FyZHMgbW92ZW1lbnQgd291bGQgcmVzdWx0IGluIGEgc21hbGwgYmFja3dhcmRzIHJlc3Vs
dC4KPj4+Pj4gT3Igd2UgY291bGQgb2Zmc2V0IGV2ZXJ5dGhpbmcgc28gdGhhdCB3ZeKAmWQgaGF2
ZSB0byBnbyBiYWNrIHNldmVyYWwKPj4+Pj4gaHVuZHJlZCBtcyBiZWZvcmUgd2UgY3Jvc3MgemVy
by4KPj4+PiAKPj4+PiBUaGF0IHdvdWxkIGJlIHByb2JhYmx5IHRoZSBiZXR0ZXIgc29sdXRpb24g
YXMgc2lnbmVkIG1hdGggd291bGQgYmUKPj4+PiBwcm9ibGVtYXRpYyB3aGVuIHRoZSByZXN1bHRp
bmcgbnMgdmFsdWUgYmVjb21lcyBuZWdhdGl2ZS4gQXMgdGhlIGRlbHRhIGlzCj4+Pj4gcmVhbGx5
IHNtYWxsLCBvdGhlcndpc2UgdGhlIFRTQyBzeW5jIGNoZWNrIHdvdWxkIGhhdmUgY2F1Z2h0IGl0
LCB0aGUgY2FsbGVyCj4+Pj4gc2hvdWxkIG5ldmVyIGJlIGFibGUgdG8gb2JzZXJ2ZSB0aW1lIGdv
aW5nIGJhY2t3YXJkcy4KPj4+PiAKPj4+PiBJJ2xsIGhhdmUgYSBsb29rIGludG8gdGhhdC4gSXQg
bmVlZHMgc29tZSB0aG91Z2h0IHZzLiB0aGUgZnJhY3Rpb25hbCBwYXJ0Cj4+Pj4gb2YgdGhlIGJh
c2UgdGltZSwgYnV0IGl0IHNob3VsZCBiZSBub3Qgcm9ja2V0IHNjaWVuY2UgdG8gZ2V0IHRoYXQK
Pj4+PiBjb3JyZWN0LiBGYW1vdXMgbGFzdCB3b3Jkcy4uLgo+Pj4+IAo+Pj4gCj4+PiBJdOKAmXMg
YWxzbyBmaWRkbHkgdG8gdHVuZS4gSWYgeW91IG9mZnNldCBpdCB0b28gbXVjaCwgdGhlbiB0aGUg
ZmFuY3kKPj4+IGRpdmlkZS1ieS1yZXBlYXRlZC1zdWJ0cmFjdGlvbiBsb29wIHdpbGwgaHVydCBt
b3JlIHRoYW4gdGhlIGNvbXBhcmlzb24gdG8KPj4+IGxhc3QuCj4+IAo+PiBOb3QgcmVhbGx5LiBJ
dCdzIHN1ZmZpY2llbnQgdG8gb2Zmc2V0IGl0IGJ5IGF0IG1heC4gMTAwMCBjeWNsZXMgb3Igc28u
IFRoYXQKPj4gd29uJ3QgaHVydCB0aGUgbWFnaWMgbG9vcCwgYnV0IGl0IHdpbGwgZGVmaW5pdGVs
eSBjb3ZlciB0aGF0IHNsaWdodCBvZmZzZXQKPj4gY2FzZS4KPiAKPiBJIGdvdCBpdCB3b3JraW5n
LCBidXQgZmlyc3Qgb2YgYWxsIHRoZSBnYWluIGlzIGNsb3NlIHRvIDAuCj4gCj4gVGhlcmUgaXMg
dGhpcyBvdGhlciBzdWJ0bGUgaXNzdWUgdGhhdCB3ZSd2ZSBzZWVuIFRTQ3Mgc2xvd2x5IGRyaWZ0
aW5nIGFwYXJ0Cj4gd2hpY2ggaXMgY2F1Z2h0IGJ5IHRoZSBUU0Mgd2F0Y2hkb2cgZXZlbnR1YWxs
eSwgYnV0IGlmIGl0IGV4ZWVkcyB0aGUgb2Zmc2V0Cj4gX2JlZm9yZV8gdGhlIHdhdGNoZG9nIHRy
aWdnZXJzLCB3ZSdyZSBiYWNrIHRvIHNxdWFyZSBvbmUuCj4gCj4gU28gSSByYXRoZXIgc3RheSBv
biB0aGUgc2FmZSBzaWRlIGFuZCBqdXN0IGFjY2VwdCB0aGF0IHdlIGhhdmUgdG8gZGVhbCB3aXRo
Cj4gdGhhdC4gU2lnaC4KPiAKPiAKClNlZW1zIG9rYXkgdG8gbWUuIE9oIHdlbGwuIApfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
