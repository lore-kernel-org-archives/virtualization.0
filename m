From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [patch 00/11] x86/vdso: Cleanups,
	simmplifications and CLOCK_TAI support
Date: Thu, 4 Oct 2018 07:00:45 -0700
Message-ID: <B8C05946-43BB-40A4-A564-53904FAF8CC0__39253.3010490753$1538661529$gmane$org@amacapital.net>
References: <20180914125006.349747096@linutronix.de>
	<CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com>
	<87sh1ne64t.fsf@vitty.brq.redhat.com>
	<20181003190617.GC21381@amt.cnet>
	<87k1mycfju.fsf@vitty.brq.redhat.com>
	<20181004081100.GI19272@hirez.programming.kicks-ass.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181004081100.GI19272@hirez.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <kernellwp@gmail.com>, Florian Weimer <fweimer@redhat.com>, X86 ML <x86@kernel.org>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Radim Krcmar <rkrcmar@redhat.com>, Stephen Boyd <sboyd@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, John Stultz <john.stultz@linaro.org>, Andy Lutomirski <luto@kernel.org>, devel@linuxdriverproject.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

Cgo+IE9uIE9jdCA0LCAyMDE4LCBhdCAxOjExIEFNLCBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOgo+IAo+PiBPbiBUaHUsIE9jdCAwNCwgMjAxOCBhdCAwOTo1NDo0
NUFNICswMjAwLCBWaXRhbHkgS3V6bmV0c292IHdyb3RlOgo+PiBJIHdhcyBob3BpbmcgdG8gaGVh
ciB0aGlzIGZyb20geW91IDotKSBJZiBJIGFtIHRvIHN1Z2dlc3QgaG93IHdlIGNhbgo+PiBtb3Zl
IGZvcndhcmQgSSdkIHByb3Bvc2U6Cj4+IC0gQ2hlY2sgaWYgcHVyZSBUU0MgY2FuIGJlIHVzZWQg
b24gU2t5TGFrZSsgc3lzdGVtcyAod2hlcmUgVFNDIHNjYWxpbmcKPj4gaXMgc3VwcG9ydGVkKS4K
Pj4gLSBDaGVjayBpZiBub24tbWFzdGVyY2xvY2sgbW9kZSBpcyBzdGlsbCBuZWVkZWQuIEUuZy4g
SHlwZXJWJ3MgVFNDIHBhZ2UKPj4gY2xvY2tzb3VyY2UgaXMgYSBzaW5nbGUgcGFnZSBmb3IgdGhl
IHdob2xlIFZNLCBub3QgYSBwZXItY3B1IHRoaW5nLiBDYW4KPj4gd2UgdGhpbmsgdGhhdCBhbGwg
dGhlIGJ1Z2d5IGhhcmR3YXJlIGlzIGFscmVhZHkgZ29uZT8KPiAKPiBObywgYW5kIGl0IGlzIG5v
dCB0aGUgaGFyZHdhcmUgeW91IGhhdmUgdG8gd29ycnkgYWJvdXQgKG1vc3RseSksIGl0IGlzCj4g
dGhlIGZyaWdnaW5nIFBvUyBmaXJtd2FyZSBwZW9wbGUgcHV0IG9uIGl0Lgo+IAo+IEV2ZXIgc2lu
Y2UgTmVoYWxlbSBUU0MgaXMgc3RhYmxlICh1bmxlc3MgeW91IGdldCB0byA+NCBzb2NrZXQgc3lz
dGVtcywKPiBhZnRlciB3aGljaCBpdCBzdGlsbCBjYW4gYmUsIGJ1dCBiZXRzIGFyZSBvZmYpLiBC
dXQgZXZlbiByZWxhdGl2ZWx5Cj4gcmVjZW50IHN5c3RlbXMgZmFpbCB0aGUgVFNDIHN5bmMgdGVz
dCBiZWNhdXNlIGZpcm13YXJlIG1lc3NlcyBpdCB1cCBieQo+IHdyaXRpbmcgdG8gZWl0aGVyIE1T
Ul9UU0Mgb3IgTVNSX1RTQ19BREpVU1QuCj4gCj4gQnV0IHRoZSB0aGluZyBpcywgaWYgdGhlIFRT
QyBpcyBub3Qgc3luY2VkLCB5b3UgY2Fubm90IHVzZSBpdCBmb3IKPiB0aW1la2VlcGluZywgZnVs
bCBzdG9wLiBTbyBoYXZpbmcgYSBzaW5nbGUgcGFnZSBpcyBmaW5lLCBpdCBlaXRoZXIKPiBjb250
YWlucyBhIG11bHQvc2hpZnQgdGhhdCBpcyB2YWxpZCwgb3IgaXQgaW5kaWNhdGVzIFRTQyBpcyBt
ZXNzZWQgdXAKPiBhbmQgeW91IGZhbGwgYmFjayB0byBzb21ldGhpbmcgZWxzZS4KPiAKPiBUaGVy
ZSBpcyBubyBpbmJldHdlZW4gdGhlcmUuCj4gCj4gRm9yIHNjaGVkX2Nsb2NrIHdlIGNhbiBzdGls
bCB1c2UgdGhlIGdsb2JhbCBwYWdlLCBiZWNhdXNlIHRoZSByYXRlIHdpbGwKPiBzdGlsbCBiZSB0
aGUgc2FtZSBmb3IgZWFjaCBjcHUsIGl0J3MganVzdCBvZmZzZXQgYmV0d2VlbiBDUFVzIGFuZCB0
aGUKPiBjb2RlIGNvbXBlbnNhdGVzIGZvciB0aGF0LgoKQnV0IGlmIHdl4oCZcmUgaW4gYSBLVk0g
Z3Vlc3QsIHRoZW4gdGhlIGNsb2NrIHdpbGwganVtcCBhcm91bmQgb24gdGhlIHNhbWUgKnZDUFUq
IHdoZW4gdGhlIHZDUFUgbWlncmF0ZXMuCgpCdXQgSSBkb27igJl0IHNlZSBob3cga3ZtY2xvY2sg
aGVscHMgaGVyZSwgc2luY2UgSSBkb27igJl0IHRoaW5rIGl04oCZcyB1c2VkIGZvciBzY2hlZF9j
bG9jay4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
