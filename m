From: Quan Xu <quan.xu0@gmail.com>
Subject: Re: [PATCH RFC v3 3/6] sched/idle: Add a generic poll before enter
	real idle path
Date: Thu, 16 Nov 2017 17:29:58 +0800
Message-ID: <13a3a5c5-ec14-131f-fe6a-01700783de81__28585.7426621535$1511414921$gmane$org@gmail.com>
References: <1510567565-5118-1-git-send-email-quan.xu0@gmail.com>
	<1510567565-5118-4-git-send-email-quan.xu0@gmail.com>
	<20171115121152.gqug5wzerlo3eimd@hirez.programming.kicks-ass.net>
	<alpine.DEB.2.20.1711152240010.2146@nanos>
	<20171116084555.it2hqajxxd6ld5tq@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171116084555.it2hqajxxd6ld5tq@hirez.programming.kicks-ass.net>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Yang Zhang <yang.zhang.wz@gmail.com>, Len Brown <len.brown@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Kyle Huey <me@kylehuey.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Quan Xu <quan.xu03@gmail.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel@vger.kernel.org, xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, Tobias Klauser <tklauser@distanz.ch>
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE3LTExLTE2IDE2OjQ1LCBQZXRlciBaaWpsc3RyYSB3cm90ZToKPiBPbiBXZWQsIE5v
diAxNSwgMjAxNyBhdCAxMTowMzowOFBNICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6Cj4+
IElmIEkgdW5kZXJzdGFuZCB0aGUgcHJvYmxlbSBjb3JyZWN0bHkgdGhlbiBoZSB3YW50cyB0byBh
dm9pZCB0aGUgaGVhdnkKPj4gbGlmdGluZyBpbiB0aWNrX25vaHpfaWRsZV9lbnRlcigpIGluIHRo
ZSBmaXJzdCBwbGFjZSwgYnV0IHRoZXJlIGlzIGFscmVhZHkKPj4gYW4gaW50ZXJlc3RpbmcgcXVp
cmsgdGhlcmUgd2hpY2ggbWFrZXMgaXQgZXhpdCBlYXJseS4KPiBTdXJlLiBBbmQgdGhlcmUgYXJl
IHBlb3BsZSB3aG8gd2FudCB0byBkbyB0aGUgc2FtZSBmb3IgbmF0aXZlLgo+Cj4gQWRkaW5nIG1v
cmUgdWdseSBhbmQgc3BlY2lhbCBjYXNlcyBqdXN0IGlzbid0IHRoZSB3YXkgdG8gZ28gYWJvdXQg
ZG9pbmcKPiB0aGF0Lgo+Cj4gSSdtIGZhaXJseSBzdXJlIEkndmUgdG9sZCB0aGUgdmFyaW91cyBn
cm91cHMgdGhhdCB3YW50IHRvIHRpbmtlciB3aXRoCj4gdGhpcyB0byB3b3JrIHRvZ2V0aGVyIG9u
IHRoaXMuIEkndmUgYWxzbyBpbiBmYWlybHkgc2lnbmlmaWNhbnQgZGV0YWlsCj4gc2tldGNoZWQg
aG93IHRvIHJld29yayB0aGUgaWRsZSBjb2RlIGFuZCBpZGxlIHByZWRpY3RvcnMuCj4KPiBBdCB0
aGlzIHBvaW50IEknbSB0b28gdGlyZWQgdG8gZGlnIGFueSBvZiB0aGF0IHVwLCBzbyBJJ2xsIGp1
c3Qga2VlcAo+IHNheWluZyBubyB0byBwYXRjaGVzIHRoYXQgZG9uJ3QgZXZlbiBhdHRlbXB0IHRv
IGdvIGluIHRoZSByaWdodAo+IGRpcmVjdGlvbi4KUGV0ZXIsIHRha2UgY2FyZS4KCkkgcmVhbGx5
IGhhdmUgY29uc2lkZXJlZCB0aGlzIGZhY3RvciwgYW5kIHRyeSBteSBiZXN0IG5vdCB0byBpbnRl
cmZlcmUgCndpdGggc2NoZWR1bGVyL2lkbGUgY29kZS4KaWYgaXJxX3RpbWluZ3MgY29kZSBpcyBy
ZWFkeSwgSSBjYW4gdXNlIGl0IGRpcmVjdGx5LiBJIHRoaW5rIGlycV90aW1pbmdzIAppcyBub3Qg
YW4gZWFzeSB0YXNrLCBJJ2QKbGlrZSB0byBoZWxwIGFzIG11Y2ggYXMgSSBjYW4uwqAgQWxzbyBk
b24ndCB0cnkgdG8gdG91Y2ggdGlja19ub2h6KiBjb2RlIAphZ2Fpbi4KCmFzIHRnbHggc3VnZ2Vz
dGVkLCB0aGlzIGNhbiBiZSBoYW5kbGVkIGVpdGhlciBpbiBhIEhWIHNwZWNpZmljIGlkbGUgZHJp
dmVyIG9yIGV2ZW4gaW4gdGhlIGdlbmVyaWMgY29yZSBjb2RlLgoKSSBob3BlIHRoaXMgaXMgaW4g
dGhlIHJpZ2h0IGRpcmVjdGlvbi4KClF1YW4KQWxpYmFiYSBDbG91ZAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
