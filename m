From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Fri, 19 Sep 2014 14:46:40 -0700
Message-ID: <541CA440.8080909@zytor.com>
References: <CALCETrX66iDM+eG56hpMN4TcuXtzbEr5nB_f6JE-2XETSMWV5w@mail.gmail.com>
	<541C765B.5050705@codeaurora.org>
	<CALCETrU_r90=ve4v6xKfZHR_2O5+f05URqD5fzkbSpcuV4tb8A@mail.gmail.com>
	<15C8041A-3488-4693-B329-3A9FE77A0CB9@gmail.com>
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
Cc: Theodore Ts'o <tytso@mit.edu>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gMDkvMTkvMjAxNCAwMTo0NiBQTSwgQW5keSBMdXRvbWlyc2tpIHdyb3RlOgo+Pgo+PiBIb3dl
dmVyLCBpdCBzb3VuZHMgdG8gbWUgdGhhdCBhdCBsZWFzdCBmb3IgS1ZNLCBpdCBpcyB2ZXJ5IGVh
c3kganVzdCB0byBlbXVsYXRlIHRoZSBSRFJBTkQgaW5zdHJ1Y3Rpb24uIFRoZSBoeXBlcnZpc29y
IHdvdWxkIHJlcG9ydCB0byB0aGUgZ3Vlc3QgdGhhdCBSRFJBTkQgaXMgc3VwcG9ydGVkIGluIENQ
VUlEIGFuZCB0aGUgZW11bGF0ZSB0aGUgaW5zdHJ1Y3Rpb24gd2hlbiBndWVzdCBleGVjdXRlcyBp
dC4gS1ZNIGFscmVhZHkgdHJhcHMgZ3Vlc3QgI1VEICh3aGljaCB3b3VsZCBvY2N1ciBpZiBSRFJB
TkQgZXhlY3V0ZWQgd2hpbGUgaXQgaXMgbm90IHN1cHBvcnRlZCkgLSBzbyB0aGlzIHNjaGVtZSB3
b3VsZG7igJl0IGludHJvZHVjZSBhZGRpdGlvbmFsIG92ZXJoZWFkIG92ZXIgUkRNU1IuCj4gCj4g
QmVjYXVzZSB0aGVuIGd1ZXN0IHVzZXIgY29kZSB3aWxsIHRoaW5rIHRoYXQgcmRyYW5kIGlzIHRo
ZXJlIGFuZCB3aWxsCj4gdHJ5IHRvIHVzZSBpdCwgcmVzdWx0aW5nIGluIGFieXNtYWwgcGVyZm9y
bWFuY2UuCj4gCgpZZXMsIHRoZSBwcmVzZW5jZSBvZiBSRFJBTkQgaW1wbGllcyBhIGNoZWFwIGFu
ZCBpbmV4aGF1c3RpYmxlIGVudHJvcHkKc291cmNlLgoKCS1ocGEKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
