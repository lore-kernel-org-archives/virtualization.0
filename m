From: Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: Should SEV-ES #VC use IST? (Re: [PATCH] Allow RDTSC and RDTSCP
 from userspace)
Date: Tue, 23 Jun 2020 14:57:20 +0100
Message-ID: <4113e368-6bc8-51b7-9412-3b4df2633ad6@citrix.com>
References: <20200425191032.GK21900@8bytes.org>
 <910AE5B4-4522-4133-99F7-64850181FBF9@amacapital.net>
 <20200425202316.GL21900@8bytes.org>
 <CALCETrW2Y6UFC=zvGbXEYqpsDyBh0DSEM4NQ+L=_pp4aOd6Fuw@mail.gmail.com>
 <CALCETrXGr+o1_bKbnre8cVY14c_76m8pEf3iB_i7h+zfgE5_jA@mail.gmail.com>
 <20200428075512.GP30814@suse.de>
 <20200623110706.GB4817@hirez.programming.kicks-ass.net>
 <20200623113007.GH31822@suse.de>
 <8413fe52-04ee-f4e1-873c-17595110856a@citrix.com>
 <20200623124712.GF4817@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200623124712.GF4817@hirez.programming.kicks-ass.net>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juergen Gross <JGross@suse.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, Joerg Roedel <jroedel@suse.de>, Mike Stunes <mstunes@vmware.com>, Kees Cook <keescook@chromium.org>, kvm list <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>, "H.
 Peter Anvin" <hpa@zytor.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>, X86 ML <x86@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

T24gMjMvMDYvMjAyMCAxMzo0NywgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6Cj4gT24gVHVlLCBKdW4g
MjMsIDIwMjAgYXQgMTI6NTE6MDNQTSArMDEwMCwgQW5kcmV3IENvb3BlciB3cm90ZToKPgo+PiBU
aGVyZSBhcmUgY2FzZXMgd2hpY2ggYXJlIGRlZmluaXRlbHkgbm9uLXJlY292ZXJhYmxlLgo+Pgo+
PiBGb3IgYm90aCBFUyBhbmQgU05QLCBhIG1hbGljaW91cyBoeXBlcnZpc29yIGNhbiBtZXNzIHdp
dGggdGhlIGd1ZXN0Cj4+IHBoeXNtYXAgdG8gbWFrZSB0aGUgdGhlIE5NSSwgI1ZDIGFuZCAjREYg
c3RhY2tzIGFsbCBhbGlhcy4KPj4KPj4gRm9yIEVTLCB0aGlzIGhhZCBiZXR0ZXIgcmVzdWx0IGlu
IHRoZSAjREYgaGFuZGxlciBkZWNpZGluZyB0aGF0IGNyYXNoaW5nCj4+IGlzIHRoZSB3YXkgb3V0
LCB3aGVyZWFzIGZvciBTTlAsIHRoaXMgaGFkIGJldHRlciBlc2NhbGF0ZSB0byBTaHV0ZG93bi4K
Pj4gQ3Jhc2hpbmcgb3V0IGhhcmQgaWYgdGhlIGh5cGVydmlzb3IgaXMgbWlzYmVoYXZpbmcgaXMg
YWNjZXB0YWJsZS4KPiBUaGVuIEknbSB0aGlua2luZyB0aGUgb25seSBzZW5zaWJsZSBvcHRpb24g
aXMgdG8gY3Jhc2ggaGFyZCBmb3IgYW55IFNOUAo+ICNWQyBmcm9tIGtlcm5lbCBtb2RlLgo+Cj4g
U2FkbHkgdGhhdCBkb2Vzbid0IGhlbHAgd2l0aCAjVkMgbmVlZGluZyB0byBiZSBJU1QgOi0oIElT
VCBpcyBzdWNoIGEKPiBmcmlnZ2luZyBuaWdodG1hcmUuCgpJIHByZXN1bWUgeW91IG1lYW4gYW55
ICNWQyBjYXVzZWQgYnkgUk1QIGZhdWx0cyAoaS5lLiBzb21ldGhpbmcgd2VudAp3cm9uZyB3aXRo
IHRoZSBtZW1vcnkgb3duZXIvZXRjIG1ldGFkYXRhKSA/CgpJZiBzbywgdGhlbiB5ZXMuwqAgQW55
IGZhaWx1cmUgaGVyZSBpcyBhIGJ1ZyBpbiB0aGUga2VybmVsIG9yIGh5cGVydmlzb3IKKGFuZCBu
ZWVkcyBmaXhpbmcpIG9yIGEgbWFsaWNpb3VzIGh5cGVydmlzb3IgYW5kIHRoZSBndWVzdCBzaG91
bGQKdGVybWluYXRlIGZvciBpdHMgb3duIHNhZmV0eS4KCn5BbmRyZXcKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
