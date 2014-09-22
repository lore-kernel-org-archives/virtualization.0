From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Mon, 22 Sep 2014 16:01:28 -0700
Message-ID: <4A3BC619-679D-4FEF-B25A-D6D733498C18@zytor.com>
References: <CALCETrX66iDM+eG56hpMN4TcuXtzbEr5nB_f6JE-2XETSMWV5w@mail.gmail.com>
	<541C765B.5050705@codeaurora.org>
	<CALCETrU_r90=ve4v6xKfZHR_2O5+f05URqD5fzkbSpcuV4tb8A@mail.gmail.com>
	<15C8041A-3488-4693-B329-3A9FE77A0CB9@gmail.com>
	<CALCETrXq2FJ4c6MeEHCVeY7muV6C1NpuKpmtr+PcnHV2DpF3Zg@mail.gmail.com>
	<541CA440.8080909@zytor.com> <542024CB.2070704@codeaurora.org>
Mime-Version: 1.0 (1.0)
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

Tm90IHJlYWxseSwgbm8uCgpTZW50IGZyb20gbXkgdGFibGV0LCBwYXJkb24gYW55IGZvcm1hdHRp
bmcgcHJvYmxlbXMuCgo+IE9uIFNlcCAyMiwgMjAxNCwgYXQgMDY6MzEsIENocmlzdG9waGVyIENv
dmluZ3RvbiA8Y292QGNvZGVhdXJvcmEub3JnPiB3cm90ZToKPiAKPj4gT24gMDkvMTkvMjAxNCAw
NTo0NiBQTSwgSC4gUGV0ZXIgQW52aW4gd3JvdGU6Cj4+IE9uIDA5LzE5LzIwMTQgMDE6NDYgUE0s
IEFuZHkgTHV0b21pcnNraSB3cm90ZToKPj4+PiAKPj4+PiBIb3dldmVyLCBpdCBzb3VuZHMgdG8g
bWUgdGhhdCBhdCBsZWFzdCBmb3IgS1ZNLCBpdCBpcyB2ZXJ5IGVhc3kganVzdCB0byBlbXVsYXRl
IHRoZSBSRFJBTkQgaW5zdHJ1Y3Rpb24uIFRoZSBoeXBlcnZpc29yIHdvdWxkIHJlcG9ydCB0byB0
aGUgZ3Vlc3QgdGhhdCBSRFJBTkQgaXMgc3VwcG9ydGVkIGluIENQVUlEIGFuZCB0aGUgZW11bGF0
ZSB0aGUgaW5zdHJ1Y3Rpb24gd2hlbiBndWVzdCBleGVjdXRlcyBpdC4gS1ZNIGFscmVhZHkgdHJh
cHMgZ3Vlc3QgI1VEICh3aGljaCB3b3VsZCBvY2N1ciBpZiBSRFJBTkQgZXhlY3V0ZWQgd2hpbGUg
aXQgaXMgbm90IHN1cHBvcnRlZCkgLSBzbyB0aGlzIHNjaGVtZSB3b3VsZG7igJl0IGludHJvZHVj
ZSBhZGRpdGlvbmFsIG92ZXJoZWFkIG92ZXIgUkRNU1IuCj4+PiAKPj4+IEJlY2F1c2UgdGhlbiBn
dWVzdCB1c2VyIGNvZGUgd2lsbCB0aGluayB0aGF0IHJkcmFuZCBpcyB0aGVyZSBhbmQgd2lsbAo+
Pj4gdHJ5IHRvIHVzZSBpdCwgcmVzdWx0aW5nIGluIGFieXNtYWwgcGVyZm9ybWFuY2UuCj4+IAo+
PiBZZXMsIHRoZSBwcmVzZW5jZSBvZiBSRFJBTkQgaW1wbGllcyBhIGNoZWFwIGFuZCBpbmV4aGF1
c3RpYmxlIGVudHJvcHkKPj4gc291cmNlLgo+IAo+IEEgZ3Vlc3Qga2VybmVsIGNvdWxkbid0IG1h
a2UgaXQgbG9vayBsaWtlIFJEUkFORCBpcyBub3QgcHJlc2VudCB0byBndWVzdAo+IHVzZXJzcGFj
ZT8KPiAKPiBDaHJpc3RvcGhlcgo+IAo+IC0tIAo+IEVtcGxveWVlIG9mIFF1YWxjb21tIElubm92
YXRpb24gQ2VudGVyLCBJbmMuCj4gUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gaXMg
YSBtZW1iZXIgb2YgQ29kZSBBdXJvcmEgRm9ydW0sCj4gaG9zdGVkIGJ5IHRoZSBMaW51eCBGb3Vu
ZGF0aW9uLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
