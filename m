From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [patch 00/11] x86/vdso: Cleanups,
	simmplifications and CLOCK_TAI support
Date: Wed, 03 Oct 2018 14:01:38 +0200
Message-ID: <87murvdysd.fsf__1082.77449985525$1538567989$gmane$org@vitty.brq.redhat.com>
References: <20180914125006.349747096@linutronix.de>
	<CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com>
	<87sh1ne64t.fsf@vitty.brq.redhat.com>
	<4B6A97E1-17E6-40F2-A7A0-87731668A07C@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4B6A97E1-17E6-40F2-A7A0-87731668A07C@amacapital.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Wanpeng Li <kernellwp@gmail.com>, Florian Weimer <fweimer@redhat.com>, X86 ML <x86@kernel.org>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Radim Krcmar <rkrcmar@redhat.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, Andy Lutomirski <luto@kernel.org>, devel@linuxdriverproject.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

QW5keSBMdXRvbWlyc2tpIDxsdXRvQGFtYWNhcGl0YWwubmV0PiB3cml0ZXM6Cgo+PiBPbiBPY3Qg
MywgMjAxOCwgYXQgMjoyMiBBTSwgVml0YWx5IEt1em5ldHNvdiA8dmt1em5ldHNAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4+IAo+PiBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4gd3JpdGVz
Ogo+PiAKPj4+IEhpIFZpdGFseSwgUGFvbG8sIFJhZGltLCBldGMuLAo+Pj4gCj4+IFRoZSBub3Rp
ZmljYXRpb24geW91J3JlIHRhbGtpbmcgYWJvdXQgZXhpc3RzLCBpdCBpcyBjYWxsZWQKPj4gUmVl
bmxpZ250ZW5tZW50LCBzZWUgMDA5MmU0MzQ2ZjQ5ICJ4ODYva3ZtOiBTdXBwb3J0IEh5cGVyLVYK
Pj4gcmVlbmxpZ2h0ZW5tZW50IikuIFdoZW4gVFNDIHBhZ2UgY2hhbmdlcyAoYW5kIHRoaXMgb25s
eSBoYXBwZW5zIHdoZW4gTDEKPj4gaXMgbWlncmF0ZWQgdG8gYSBkaWZmZXJlbnQgaG9zdCB3aXRo
IGEgZGlmZmVyZW50IFRTQyBmcmVxdWVuY3kgYW5kIFRTQwo+PiBzY2FsaW5nIGlzIG5vdCBzdXBw
b3J0ZWQgYnkgdGhlIENQVSkgd2UgcmVjZWl2ZSBhbiBpbnRlcnJ1cHQgaW4gTDEgKGF0Cj4+IHRo
aXMgbW9tZW50IGFsbCBUU0MgYWNjZXNzZXMgYXJlIGVtdWxhdGVkIHdoaWNoIGd1YXJhbnRlZXMg
dGhlCj4+IGNvcnJlY3RuZXNzIG9mIHRoZSByZWFkaW5ncyksIHBhdXNlIGFsbCBMMiBndWVzdHMs
IHVwZGF0ZSB0aGVpciBrdm1jbG9jawo+PiBzdHJ1Y3R1cmVzIHdpdGggbmV3IGRhdGEgKHdlIGFs
cmVhZHkga25vdyB0aGUgbmV3IFRTQyBmcmVxdWVuY3kpIGFuZAo+PiB0aGVuIHRlbGwgTDAgdGhh
dCB3ZSdyZSBkb25lIGFuZCBpdCBjYW4gc3RvcCBlbXVsYXRpbmcgVFNDIGFjY2Vzc2VzLgo+Cj4g
VGhhdOKAmXMgZGVsaWdodGZ1bCEgIERvZXMgdGhlIGVtdWxhdGlvbiBtYWdpYyBhbHNvIHdvcmsg
Zm9yIEwxIHVzZXIKPiBtb2RlPwoKQXMgZmFyIGFzIEkgdW5kZXJzdGFuZCAtIHllcywgYWxsIHJk
dHNjKiBjYWxscyB3aWxsIHRyYXAgaW50byBMMC4KCj4gIElmIHNvLCBjb3VsZG7igJl0IHdlIGRy
b3AgdGhlIEh5cGVyViB2Y2xvY2sgZW50aXJlbHkgYW5kIGp1c3QKPiBmb2xkIHRoZSBhZGp1c3Rt
ZW50IGludG8gdGhlIGNvcmUgdGltZWtlZXBpbmcgZGF0YT8gIChQcmVmZXJhYmx5IHRoZQo+IGFj
dHVhbCBjb3JlIGRhdGEsIHdoaWNoIHdvdWxkIHJlcXVpcmUgY29yZSBjaGFuZ2VzLCBidXQgaXQg
Y291bGQKPiBwbGF1c2libHkgYmUgZG9uZSBpbiBhcmNoIGNvZGUsIHRvby4pCgpOb3QgYWxsIEh5
cGVyLVYgaG9zdHMgc3VwcG9ydCByZWVubGlnaHRlbm1lbnQgbm90aWZpY2F0aW9ucyAoYW5kLCBp
ZiBJJ20Kbm90IG1pc3Rha2VuLCB5b3UgbmVlZCB0byBlbmFibGUgbmVzdGluZyBmb3IgdGhlIFZN
IHRvIGdldCB0aGUgZmVhdHVyZSAtCmFuZCBtb3N0IFZNcyBkb24ndCBoYXZlIHRoaXMpIHNvIEkg
dGhpbmsgd2UnbGwgaGF2ZSB0byBrZWVwIEh5cGVyLVYKdmNsb2NrIGZvciB0aGUgdGltZSBiZWlu
Zy4KCi0tIApWaXRhbHkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
