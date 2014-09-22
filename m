From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Mon, 22 Sep 2014 07:17:11 -0700
Message-ID: <54202F67.2010606@zytor.com>
References: <CALCETrX66iDM+eG56hpMN4TcuXtzbEr5nB_f6JE-2XETSMWV5w@mail.gmail.com>
	<541C765B.5050705@codeaurora.org>
	<CALCETrU_r90=ve4v6xKfZHR_2O5+f05URqD5fzkbSpcuV4tb8A@mail.gmail.com>
	<15C8041A-3488-4693-B329-3A9FE77A0CB9@gmail.com>
	<CALCETrXq2FJ4c6MeEHCVeY7muV6C1NpuKpmtr+PcnHV2DpF3Zg@mail.gmail.com>
	<541CA440.8080909@zytor.com> <542024CB.2070704@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <542024CB.2070704@codeaurora.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christopher Covington <cov@codeaurora.org>
Cc: Theodore Ts'o <tytso@mit.edu>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Nadav Amit <nadav.amit@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gMDkvMjIvMjAxNCAwNjozMSBBTSwgQ2hyaXN0b3BoZXIgQ292aW5ndG9uIHdyb3RlOgo+IE9u
IDA5LzE5LzIwMTQgMDU6NDYgUE0sIEguIFBldGVyIEFudmluIHdyb3RlOgo+PiBPbiAwOS8xOS8y
MDE0IDAxOjQ2IFBNLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6Cj4+Pj4KPj4+PiBIb3dldmVyLCBp
dCBzb3VuZHMgdG8gbWUgdGhhdCBhdCBsZWFzdCBmb3IgS1ZNLCBpdCBpcyB2ZXJ5IGVhc3kganVz
dCB0byBlbXVsYXRlIHRoZSBSRFJBTkQgaW5zdHJ1Y3Rpb24uIFRoZSBoeXBlcnZpc29yIHdvdWxk
IHJlcG9ydCB0byB0aGUgZ3Vlc3QgdGhhdCBSRFJBTkQgaXMgc3VwcG9ydGVkIGluIENQVUlEIGFu
ZCB0aGUgZW11bGF0ZSB0aGUgaW5zdHJ1Y3Rpb24gd2hlbiBndWVzdCBleGVjdXRlcyBpdC4gS1ZN
IGFscmVhZHkgdHJhcHMgZ3Vlc3QgI1VEICh3aGljaCB3b3VsZCBvY2N1ciBpZiBSRFJBTkQgZXhl
Y3V0ZWQgd2hpbGUgaXQgaXMgbm90IHN1cHBvcnRlZCkgLSBzbyB0aGlzIHNjaGVtZSB3b3VsZG7i
gJl0IGludHJvZHVjZSBhZGRpdGlvbmFsIG92ZXJoZWFkIG92ZXIgUkRNU1IuCj4+Pgo+Pj4gQmVj
YXVzZSB0aGVuIGd1ZXN0IHVzZXIgY29kZSB3aWxsIHRoaW5rIHRoYXQgcmRyYW5kIGlzIHRoZXJl
IGFuZCB3aWxsCj4+PiB0cnkgdG8gdXNlIGl0LCByZXN1bHRpbmcgaW4gYWJ5c21hbCBwZXJmb3Jt
YW5jZS4KPj4+Cj4+Cj4+IFllcywgdGhlIHByZXNlbmNlIG9mIFJEUkFORCBpbXBsaWVzIGEgY2hl
YXAgYW5kIGluZXhoYXVzdGlibGUgZW50cm9weQo+PiBzb3VyY2UuCj4gCj4gQSBndWVzdCBrZXJu
ZWwgY291bGRuJ3QgbWFrZSBpdCBsb29rIGxpa2UgUkRSQU5EIGlzIG5vdCBwcmVzZW50IHRvIGd1
ZXN0Cj4gdXNlcnNwYWNlPwo+IAoKSXQgY291bGQsIGJ1dCBob3cgd291bGQgeW91IGVudW1lcmF0
ZSB0aGF0PyAgQSBuZXcgIlJEUkFORC1DUEwtMCIgQ1BVSUQKYml0IHByZXR0eSBtdWNoIHdvdWxk
IGJlIHJlcXVpcmVkLgoKCS1ocGEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
