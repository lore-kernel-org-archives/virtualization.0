From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [patch 00/11] x86/vdso: Cleanups,
	simmplifications and CLOCK_TAI support
Date: Thu, 4 Oct 2018 07:04:38 -0700
Message-ID: <6FC84115-1FB9-4386-86EE-71A8A53EA0F7@amacapital.net>
References: <20180914125006.349747096@linutronix.de>
	<CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com>
	<87sh1ne64t.fsf@vitty.brq.redhat.com>
	<20181003190617.GC21381@amt.cnet>
	<87k1mycfju.fsf@vitty.brq.redhat.com>
	<1832e2af-3189-cb50-f4b6-45e74cdcf4b4@redhat.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1832e2af-3189-cb50-f4b6-45e74cdcf4b4@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Wanpeng Li <kernellwp@gmail.com>, Florian Weimer <fweimer@redhat.com>, X86 ML <x86@kernel.org>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Radim Krcmar <rkrcmar@redhat.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, Andy Lutomirski <luto@kernel.org>, devel@linuxdriverproject.org, Thomas Gleixner <tglx@linutronix.de>, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

Cj4gT24gT2N0IDQsIDIwMTgsIGF0IDU6MDAgQU0sIFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJl
ZGhhdC5jb20+IHdyb3RlOgo+IAo+PiBPbiAwNC8xMC8yMDE4IDA5OjU0LCBWaXRhbHkgS3V6bmV0
c292IHdyb3RlOgo+PiAtIENoZWNrIGlmIHB1cmUgVFNDIGNhbiBiZSB1c2VkIG9uIFNreUxha2Ur
IHN5c3RlbXMgKHdoZXJlIFRTQyBzY2FsaW5nCj4+IGlzIHN1cHBvcnRlZCkuCj4gCj4gTm90IGlm
IHlvdSB3YW50IHRvIG1pZ3JhdGUgdG8gcHJlLVNreWxha2Ugc3lzdGVtcy4KPiAKPj4gLSBDaGVj
ayBpZiBub24tbWFzdGVyY2xvY2sgbW9kZSBpcyBzdGlsbCBuZWVkZWQuIEUuZy4gSHlwZXJWJ3Mg
VFNDIHBhZ2UKPj4gY2xvY2tzb3VyY2UgaXMgYSBzaW5nbGUgcGFnZSBmb3IgdGhlIHdob2xlIFZN
LCBub3QgYSBwZXItY3B1IHRoaW5nLiBDYW4KPj4gd2UgdGhpbmsgdGhhdCBhbGwgdGhlIGJ1Z2d5
IGhhcmR3YXJlIGlzIGFscmVhZHkgZ29uZT8KPiAKPiBOby4gOiggIFdlIHN0aWxsIGdldCByZXBv
cnRzIHdoZW5ldmVyIHdlIGJyZWFrIDIwMDctMjAwOCBoYXJkd2FyZS4KPiAKPiAKCkRvZXMgdGhl
IEtWTSBub24tbWFzdGVyY2xvY2sgbW9kZSBhY3R1YWxseSBoZWxwPyAgSXTigJlzIG5vdCBjbGVh
ciB0byBtZSBleGFjdGx5IGhvdyBpdOKAmXMgc3VwcG9zZWQgdG8gd29yaywgYnV0IGl0IHNlZW1z
IGxpa2UgaXTigJlzIHRyeWluZyB0byBleHBvc2UgcGVyLXZDUFUgYWRqdXN0bWVudHMgdG8gdGhl
IGd1ZXN0LiBXaGljaCBpcyBkdWJpb3VzIGF0IGJlc3QsIHNpbmNlIHRoZSBndWVzdCBjYW7igJl0
IHZhbGlkbHkgdXNlIHRoZW0gZm9yIGFueXRoaW5nIG90aGVyIHRoYW4gc2NoZWRfY2xvY2ssIHNp
bmNlIHRoZXkgYXJlbuKAmXQgZnVsbHkgY29ycmVjdGVkIGJ5IGFueXRoaW5nIEtWTSBjYW4gZG8u
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
