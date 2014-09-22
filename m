From: Christopher Covington <cov@codeaurora.org>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Mon, 22 Sep 2014 09:31:55 -0400
Message-ID: <542024CB.2070704@codeaurora.org>
References: <CALCETrX66iDM+eG56hpMN4TcuXtzbEr5nB_f6JE-2XETSMWV5w@mail.gmail.com>
	<541C765B.5050705@codeaurora.org>
	<CALCETrU_r90=ve4v6xKfZHR_2O5+f05URqD5fzkbSpcuV4tb8A@mail.gmail.com>
	<15C8041A-3488-4693-B329-3A9FE77A0CB9@gmail.com>
	<CALCETrXq2FJ4c6MeEHCVeY7muV6C1NpuKpmtr+PcnHV2DpF3Zg@mail.gmail.com>
	<541CA440.8080909@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <541CA440.8080909@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Theodore Ts'o <tytso@mit.edu>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Nadav Amit <nadav.amit@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gMDkvMTkvMjAxNCAwNTo0NiBQTSwgSC4gUGV0ZXIgQW52aW4gd3JvdGU6Cj4gT24gMDkvMTkv
MjAxNCAwMTo0NiBQTSwgQW5keSBMdXRvbWlyc2tpIHdyb3RlOgo+Pj4KPj4+IEhvd2V2ZXIsIGl0
IHNvdW5kcyB0byBtZSB0aGF0IGF0IGxlYXN0IGZvciBLVk0sIGl0IGlzIHZlcnkgZWFzeSBqdXN0
IHRvIGVtdWxhdGUgdGhlIFJEUkFORCBpbnN0cnVjdGlvbi4gVGhlIGh5cGVydmlzb3Igd291bGQg
cmVwb3J0IHRvIHRoZSBndWVzdCB0aGF0IFJEUkFORCBpcyBzdXBwb3J0ZWQgaW4gQ1BVSUQgYW5k
IHRoZSBlbXVsYXRlIHRoZSBpbnN0cnVjdGlvbiB3aGVuIGd1ZXN0IGV4ZWN1dGVzIGl0LiBLVk0g
YWxyZWFkeSB0cmFwcyBndWVzdCAjVUQgKHdoaWNoIHdvdWxkIG9jY3VyIGlmIFJEUkFORCBleGVj
dXRlZCB3aGlsZSBpdCBpcyBub3Qgc3VwcG9ydGVkKSAtIHNvIHRoaXMgc2NoZW1lIHdvdWxkbuKA
mXQgaW50cm9kdWNlIGFkZGl0aW9uYWwgb3ZlcmhlYWQgb3ZlciBSRE1TUi4KPj4KPj4gQmVjYXVz
ZSB0aGVuIGd1ZXN0IHVzZXIgY29kZSB3aWxsIHRoaW5rIHRoYXQgcmRyYW5kIGlzIHRoZXJlIGFu
ZCB3aWxsCj4+IHRyeSB0byB1c2UgaXQsIHJlc3VsdGluZyBpbiBhYnlzbWFsIHBlcmZvcm1hbmNl
Lgo+Pgo+IAo+IFllcywgdGhlIHByZXNlbmNlIG9mIFJEUkFORCBpbXBsaWVzIGEgY2hlYXAgYW5k
IGluZXhoYXVzdGlibGUgZW50cm9weQo+IHNvdXJjZS4KCkEgZ3Vlc3Qga2VybmVsIGNvdWxkbid0
IG1ha2UgaXQgbG9vayBsaWtlIFJEUkFORCBpcyBub3QgcHJlc2VudCB0byBndWVzdAp1c2Vyc3Bh
Y2U/CgpDaHJpc3RvcGhlcgoKLS0gCkVtcGxveWVlIG9mIFF1YWxjb21tIElubm92YXRpb24gQ2Vu
dGVyLCBJbmMuClF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIGlzIGEgbWVtYmVyIG9m
IENvZGUgQXVyb3JhIEZvcnVtLApob3N0ZWQgYnkgdGhlIExpbnV4IEZvdW5kYXRpb24uCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
