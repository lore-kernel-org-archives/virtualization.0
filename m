From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [patch 11/11] x66/vdso: Add CLOCK_TAI support
Date: Fri, 14 Sep 2018 07:59:42 -0700
Message-ID: <FAE37798-8CCE-44A5-9EF0-F69C2199BE60__11140.9453013495$1536937067$gmane$org@amacapital.net>
References: <20180914125006.349747096@linutronix.de>
	<20180914125119.081037164@linutronix.de>
	<ABB53D42-2A06-41B9-8A8C-40B39CD0289D@amacapital.net>
	<alpine.DEB.2.21.1809141625040.10480@nanos.tec.linutronix.de>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.1809141625040.10480@nanos.tec.linutronix.de>
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
Cc: Florian Weimer <fweimer@redhat.com>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, devel@linuxdriverproject.org, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

Cgo+IE9uIFNlcCAxNCwgMjAxOCwgYXQgNzoyNyBBTSwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxp
bnV0cm9uaXguZGU+IHdyb3RlOgo+IAo+IE9uIEZyaSwgMTQgU2VwIDIwMTgsIEFuZHkgTHV0b21p
cnNraSB3cm90ZToKPj4+IE9uIFNlcCAxNCwgMjAxOCwgYXQgNTo1MCBBTSwgVGhvbWFzIEdsZWl4
bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+IHdyb3RlOgo+Pj4gCj4+PiBXaXRoIHRoZSBzdG9yYWdl
IGFycmF5IGluIHBsYWNlIGl0J3Mgbm93IHRyaXZpYWwgdG8gc3VwcG9ydCBDTE9DS19UQUkgaW4K
Pj4+IHRoZSB2ZHNvLiBJbnN0ZWFkIG9mIGV4dGVuZGluZyB0aGUgYXJyYXkgdG8gYWNjb21vZGF0
ZSBDTE9DS19UQUksIG1ha2UgdXNlCj4+PiBvZiB0aGUgZmFjdCB0aGF0Ogo+Pj4gCj4+PiAtIENM
T0NLIGlkcyBhcmUgc2V0IGluIHN0b25lCj4+PiAtIENMT0NLX1RIUkVBRF9DUFVUSU1FIGlzIG5l
dmVyIGdvaW5nIHRvIGJlIHN1cHBvcnRlZCBpbiB0aGUgVkRTTyBzbwo+Pj4gIHRoZSBhcnJheSBz
bG90IDMgaXMgdW51c2VkCj4+PiAtIENMT0NLX1RBSSBpcyBpZCAxMSB3aGljaCByZXN1bHRzIGlu
IDMgd2hlbiBtYXNrZWQgd2l0aCAweDMKPj4+IAo+Pj4gQWRkIHRoZSBtYXNrIHRvIHRoZSBiYXNl
dGltZSBhcnJheSBsb29rdXAgYW5kIHNldCB1cCB0aGUgQ0xPQ0tfVEFJIGJhc2UKPj4+IHRpbWUg
aW4gdXBkYXRlX3ZzeXNjYWxsKCkuCj4+IAo+PiBUaGF04oCZcy4uLiBob3JyaWJsZS4gSW4gYW4g
YW1hemluZyB3YXkuIENhbiB5b3UgYWRkIEJVSUxEX0JVR19PTiBzb21ld2hlcmUKPj4gdG8gYXNz
ZXJ0IHRoYXQgdGhpcyBhY3R1YWxseSB3b3Jrcz8KPiAKPiBTdXJlLCBidXQgY2hhbmdpbmcgYW55
IG9mIHRoZSBjbG9jayBpZHMgd2lsbCBjYXVzZSBtb3JlIHdyZWNrYWdlIHRoYW4gdGhhdC4KPiAK
CknigJltIG1vcmUgY29uY2VybmVkIHRoYXQgd2UgYWRkIGEgbmV3IG9uZSBhbmQgYnJlYWsgdGhl
IG1hZ2ljIG1hc2tpbmcuIE1heWJlIHR3byBzdGFydCBzaGFyaW5nIHRoZSBzYW1lIHNsb3QuIAoK
PiBUaGFua3MsCj4gCj4gICAgdGdseApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
