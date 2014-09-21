From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Sun, 21 Sep 2014 14:39:01 +0200
Message-ID: <541EC6E5.2020705@redhat.com>
References: <CALCETrX66iDM+eG56hpMN4TcuXtzbEr5nB_f6JE-2XETSMWV5w@mail.gmail.com>	<541C765B.5050705@codeaurora.org>	<CALCETrU_r90=ve4v6xKfZHR_2O5+f05URqD5fzkbSpcuV4tb8A@mail.gmail.com>	<15C8041A-3488-4693-B329-3A9FE77A0CB9@gmail.com>
	<CALCETrXq2FJ4c6MeEHCVeY7muV6C1NpuKpmtr+PcnHV2DpF3Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrXq2FJ4c6MeEHCVeY7muV6C1NpuKpmtr+PcnHV2DpF3Zg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@amacapital.net>, Nadav Amit <nadav.amit@gmail.com>
Cc: Gleb Natapov <gleb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

SWwgMTkvMDkvMjAxNCAyMjo0NiwgQW5keSBMdXRvbWlyc2tpIGhhIHNjcml0dG86Cj4+ID4KPj4g
PiBIb3dldmVyLCBpdCBzb3VuZHMgdG8gbWUgdGhhdCBhdCBsZWFzdCBmb3IgS1ZNLCBpdCBpcyB2
ZXJ5IGVhc3kganVzdCB0byBlbXVsYXRlIHRoZSBSRFJBTkQgaW5zdHJ1Y3Rpb24uIFRoZSBoeXBl
cnZpc29yIHdvdWxkIHJlcG9ydCB0byB0aGUgZ3Vlc3QgdGhhdCBSRFJBTkQgaXMgc3VwcG9ydGVk
IGluIENQVUlEIGFuZCB0aGUgZW11bGF0ZSB0aGUgaW5zdHJ1Y3Rpb24gd2hlbiBndWVzdCBleGVj
dXRlcyBpdC4gS1ZNIGFscmVhZHkgdHJhcHMgZ3Vlc3QgI1VEICh3aGljaCB3b3VsZCBvY2N1ciBp
ZiBSRFJBTkQgZXhlY3V0ZWQgd2hpbGUgaXQgaXMgbm90IHN1cHBvcnRlZCkgLSBzbyB0aGlzIHNj
aGVtZSB3b3VsZG7igJl0IGludHJvZHVjZSBhZGRpdGlvbmFsIG92ZXJoZWFkIG92ZXIgUkRNU1Iu
Cj4gQmVjYXVzZSB0aGVuIGd1ZXN0IHVzZXIgY29kZSB3aWxsIHRoaW5rIHRoYXQgcmRyYW5kIGlz
IHRoZXJlIGFuZCB3aWxsCj4gdHJ5IHRvIHVzZSBpdCwgcmVzdWx0aW5nIGluIGFieXNtYWwgcGVy
Zm9ybWFuY2UuCgpLVk0gY291bGQgZXhwb3NlIGEgQ1BVSUQgbGVhZiB0aGF0IHNheXMgIlJEUkFO
RCBpcyBub3QgdGhlcmUsIGJ1dCBpZiB5b3UKZXhlY3V0ZSBpdCB0aGUgaHlwZXJ2aXNvciB3aWxs
IHRyeSB0byBkbyBzb21ldGhpbmcgc2xvdyBidXQgc2FuZSIuCgpQYW9sbwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
