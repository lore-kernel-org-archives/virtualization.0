Return-Path: <SRS0=Ra46=BR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABA9C433E0
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 12:04:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B619D2075D
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 12:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B619D2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7F863889B5;
	Fri,  7 Aug 2020 12:04:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hi0X-s7v-2Dv; Fri,  7 Aug 2020 12:04:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B270388934;
	Fri,  7 Aug 2020 12:04:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DA67C0051;
	Fri,  7 Aug 2020 12:04:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C028CC004C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 12:04:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AF15488934
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 12:04:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0iKVACmW8O5J
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 12:04:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 26F66877E6
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 12:04:25 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2B4E4AF4E;
 Fri,  7 Aug 2020 12:04:41 +0000 (UTC)
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*() helpers
To: Marco Elver <elver@google.com>
References: <CANpmjNN6FWZ+MsAn3Pj+WEez97diHzqF8hjONtHG15C2gSpSgw@mail.gmail.com>
 <CANpmjNNy3XKQqgrjGPPKKvXhAoF=mae7dk8hmoS4k4oNnnB=KA@mail.gmail.com>
 <20200806074723.GA2364872@elver.google.com>
 <20200806113236.GZ2674@hirez.programming.kicks-ass.net>
 <20200806131702.GA3029162@elver.google.com>
 <CANpmjNNqt8YrCad4WqgCoXvH47pRXtSLpnTKhD8W8+UpoYJ+jQ@mail.gmail.com>
 <CANpmjNO860SHpNve+vaoAOgarU1SWy8o--tUWCqNhn82OLCiew@mail.gmail.com>
 <fe2bfa7f-132f-7581-a967-d01d58be1588@suse.com>
 <20200807095032.GA3528289@elver.google.com>
 <16671cf3-3885-eb06-79ff-4cbfaeeaea79@suse.com>
 <20200807113838.GA3547125@elver.google.com>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <e5bf3e6a-efff-7170-5ee6-1798008393a2@suse.com>
Date: Fri, 7 Aug 2020 14:04:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807113838.GA3547125@elver.google.com>
Content-Language: en-US
Cc: syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>,
 fenghua.yu@intel.com, yu-cheng.yu@intel.com, "Luck,
 Tony" <tony.luck@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>,
 virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 the arch/x86 maintainers <x86@kernel.org>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gMDcuMDguMjAgMTM6MzgsIE1hcmNvIEVsdmVyIHdyb3RlOgo+IE9uIEZyaSwgQXVnIDA3LCAy
MDIwIGF0IDEyOjM1UE0gKzAyMDAsIErDvHJnZW4gR3Jvw58gd3JvdGU6Cj4+IE9uIDA3LjA4LjIw
IDExOjUwLCBNYXJjbyBFbHZlciB3cm90ZToKPj4+IE9uIEZyaSwgQXVnIDA3LCAyMDIwIGF0IDEx
OjI0QU0gKzAyMDAsIErDvHJnZW4gR3Jvw58gd3JvdGU6Cj4+Pj4gT24gMDcuMDguMjAgMTE6MDEs
IE1hcmNvIEVsdmVyIHdyb3RlOgo+Pj4+PiBPbiBUaHUsIDYgQXVnIDIwMjAgYXQgMTg6MDYsIE1h
cmNvIEVsdmVyIDxlbHZlckBnb29nbGUuY29tPiB3cm90ZToKPj4+Pj4+IE9uIFRodSwgNiBBdWcg
MjAyMCBhdCAxNToxNywgTWFyY28gRWx2ZXIgPGVsdmVyQGdvb2dsZS5jb20+IHdyb3RlOgo+Pj4+
Pj4+IE9uIFRodSwgQXVnIDA2LCAyMDIwIGF0IDAxOjMyUE0gKzAyMDAsIHBldGVyekBpbmZyYWRl
YWQub3JnIHdyb3RlOgo+Pj4+Pj4+PiBPbiBUaHUsIEF1ZyAwNiwgMjAyMCBhdCAwOTo0NzoyM0FN
ICswMjAwLCBNYXJjbyBFbHZlciB3cm90ZToKPj4+Pj4+Pj4+IFRlc3RpbmcgbXkgaHlwb3RoZXNp
cyB0aGF0IHJhdyB0aGVuIG5lc3RlZCBub24tcmF3Cj4+Pj4+Pj4+PiBsb2NhbF9pcnFfc2F2ZS9y
ZXN0b3JlKCkgYnJlYWtzIElSUSBzdGF0ZSB0cmFja2luZyAtLSBzZWUgdGhlIHJlcHJvZHVjZXIK
Pj4+Pj4+Pj4+IGJlbG93LiBUaGlzIGlzIGF0IGxlYXN0IDEgY2FzZSBJIGNhbiB0aGluayBvZiB0
aGF0IHdlJ3JlIGJvdW5kIHRvIGhpdC4KPj4+Pj4+PiAuLi4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gL21l
IGdvZXMgcG9uZGVyIHRoaW5ncy4uLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBIb3cncyBzb21ldGhpbmcg
bGlrZSB0aGlzIHRoZW4/Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IC0tLQo+Pj4+Pj4+PiAgICAgaW5jbHVk
ZS9saW51eC9zY2hlZC5oIHwgIDMgLS0tCj4+Pj4+Pj4+ICAgICBrZXJuZWwva2NzYW4vY29yZS5j
ICAgfCA2MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0KPj4+Pj4+Pj4gICAgIDIgZmlsZXMgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKSwgMjEgZGVs
ZXRpb25zKC0pCj4+Pj4+Pj4KPj4+Pj4+PiBUaGFuayB5b3UhIFRoYXQgYXBwcm9hY2ggc2VlbXMg
dG8gcGFzcyBzeXpib3QgKGFsc28gd2l0aAo+Pj4+Pj4+IENPTkZJR19QQVJBVklSVCkgYW5kIGtj
c2FuLXRlc3QgdGVzdHMuCj4+Pj4+Pj4KPj4+Pj4+PiBJIGhhZCB0byBtb2RpZnkgaXQgc29tZSwg
c28gdGhhdCByZXBvcnQuYydzIHVzZSBvZiB0aGUgcmVzdG9yZSBsb2dpYwo+Pj4+Pj4+IHdvcmtz
IGFuZCBub3QgbWVzcyB1cCB0aGUgSVJRIHRyYWNlIHByaW50ZWQgb24gS0NTQU4gcmVwb3J0cyAo
d2l0aAo+Pj4+Pj4+IENPTkZJR19LQ1NBTl9WRVJCT1NFKS4KPj4+Pj4+Pgo+Pj4+Pj4+IEkgc3Rp
bGwgbmVlZCB0byBmdWxseSBjb252aW5jZSBteXNlbGYgYWxsIGlzIHdlbGwgbm93IGFuZCB3ZSBk
b24ndCBlbmQKPj4+Pj4+PiB1cCB3aXRoIG1vcmUgZml4ZXMuIDotKSBJZiBpdCBwYXNzZXMgZnVy
dGhlciB0ZXN0aW5nLCBJJ2xsIHNlbmQgaXQgYXMgYQo+Pj4+Pj4+IHJlYWwgcGF0Y2ggKEkgd2Fu
dCB0byBhZGQgeW91IGFzIENvLWRldmVsb3BlZC1ieSwgYnV0IHdvdWxkIG5lZWQgeW91cgo+Pj4+
Pj4+IFNpZ25lZC1vZmYtYnkgZm9yIHRoZSBjb2RlIHlvdSBwYXN0ZWQsIEkgdGhpbmsuKQo+Pj4+
Pgo+Pj4+PiBJIGxldCBpdCBydW4gb24gc3l6Ym90IHRocm91Z2ggdGhlIG5pZ2h0LCBhbmQgaXQn
cyBmaW5lIHdpdGhvdXQKPj4+Pj4gUEFSQVZJUlQgKHNlZSBiZWxvdykuIEkgaGF2ZSBzZW50IHRo
ZSBwYXRjaCAobmVlZCB5b3VyIFNpZ25lZC1vZmYtYnkKPj4+Pj4gYXMgaXQncyBiYXNlZCBvbiB5
b3VyIGNvZGUsIHRoYW5rIHlvdSEpOgo+Pj4+PiBodHRwczovL2xrbWwua2VybmVsLm9yZy9yLzIw
MjAwODA3MDkwMDMxLjM1MDY1NTUtMS1lbHZlckBnb29nbGUuY29tCj4+Pj4+Cj4+Pj4+PiBXaXRo
IENPTkZJR19QQVJBVklSVD15ICh3aXRob3V0IHRoZSBub3RyYWNlLT5ub2luc3RyIHBhdGNoKSwg
SSBzdGlsbAo+Pj4+Pj4gZ2V0IGxvY2tkZXAgREVCVUdfTE9DS1NfV0FSTl9PTighbG9ja2RlcF9o
YXJkaXJxc19lbmFibGVkKCkpLCBhbHRob3VnaAo+Pj4+Pj4gaXQgdGFrZXMgbG9uZ2VyIGZvciBz
eXpib3QgdG8gaGl0IHRoZW0uIEJ1dCBJIHRoaW5rIHRoYXQncyBleHBlY3RlZAo+Pj4+Pj4gYmVj
YXVzZSB3ZSBjYW4gc3RpbGwgZ2V0IHRoZSByZWN1cnNpb24gdGhhdCBJIHBvaW50ZWQgb3V0LCBh
bmQgd2lsbAo+Pj4+Pj4gbmVlZCB0aGF0IHBhdGNoLgo+Pj4+Pgo+Pj4+PiBOZXZlciBtaW5kLCBJ
IGdldCB0aGVzZSB3YXJuaW5ncyBldmVuIGlmIEkgZG9uJ3QgdHVybiBvbiBLQ1NBTgo+Pj4+PiAo
Q09ORklHX0tDU0FOPW4pLiBTb21ldGhpbmcgZWxzZSBpcyBnb2luZyBvbiB3aXRoIFBBUkFWSVJU
PXkgdGhhdAo+Pj4+PiB0aHJvd3Mgb2ZmIElSUSBzdGF0ZSB0cmFja2luZy4gOi0vCj4+Pj4KPj4+
PiBXaGF0IGFyZSB0aGUgc2V0dGluZ3Mgb2YgQ09ORklHX1BBUkFWSVJUX1hYTCBhbmQKPj4+PiBD
T05GSUdfUEFSQVZJUlRfU1BJTkxPQ0tTIGluIHRoaXMgY2FzZT8KPj4+Cj4+PiBJIGF0dGFjaGVk
IGEgY29uZmlnLgo+Pj4KPj4+IAkkPiBncmVwIFBBUkFWSVJUIC5jb25maWcKPj4+IAlDT05GSUdf
UEFSQVZJUlQ9eQo+Pj4gCUNPTkZJR19QQVJBVklSVF9YWEw9eQo+Pj4gCSMgQ09ORklHX1BBUkFW
SVJUX0RFQlVHIGlzIG5vdCBzZXQKPj4+IAlDT05GSUdfUEFSQVZJUlRfU1BJTkxPQ0tTPXkKPj4+
IAkjIENPTkZJR19QQVJBVklSVF9USU1FX0FDQ09VTlRJTkcgaXMgbm90IHNldAo+Pj4gCUNPTkZJ
R19QQVJBVklSVF9DTE9DSz15Cj4+Cj4+IEFueXRoaW5nIHNwZWNpYWwgSSBuZWVkIHRvIGRvIHRv
IHJlcHJvZHVjZSB0aGUgcHJvYmxlbT8gT3Igd291bGQgeW91IGJlCj4+IHdpbGxpbmcgdG8gZG8g
c29tZSBtb3JlIHJvdW5kcyB3aXRoIGRpZmZlcmVudCBjb25maWcgc2V0dGluZ3M/Cj4gCj4gSSBj
YW4gb25seSB0ZXN0IGl0IHdpdGggc3l6a2FsbGVyLCBidXQgdGhhdCBwcm9iYWJseSBkb2Vzbid0
IGhlbHAgaWYgeW91Cj4gZG9uJ3QgYWxyZWFkeSBoYXZlIGl0IHNldCB1cC4gSXQgY2FuJ3Qgc2Vl
bSB0byBmaW5kIGEgQyByZXByb2R1Y2VyLgo+IAo+IEkgZGlkIHNvbWUgbW9yZSByb3VuZHMgd2l0
aCBkaWZmZXJlbnQgY29uZmlncy4KPiAKPj4gSSB0aGluayBDT05GSUdfUEFSQVZJUlRfWFhMIHNo
b3VsZG4ndCBtYXR0ZXIsIGJ1dCBJJ20gbm90IGNvbXBsZXRlbHkKPj4gc3VyZSBhYm91dCB0aGF0
LiBDT05GSUdfUEFSQVZJUlRfU1BJTkxPQ0tTIHdvdWxkIGJlIG15IHByaW1hcnkgc3VzcGVjdC4K
PiAKPiBZZXMsIFBBUkFWSVJUX1hYTCBkb2Vzbid0IG1ha2UgYSBkaWZmZXJlbnQuIFdoZW4gZGlz
YWJsaW5nCj4gUEFSQVZJUlRfU1BJTkxPQ0tTLCBob3dldmVyLCB0aGUgd2FybmluZ3MgZ28gYXdh
eS4KClRoYW5rcyBmb3IgdGVzdGluZyEKCkkgdGFrZSBpdCB5b3UgYXJlIGRvaW5nIHRoZSB0ZXN0
cyBpbiBhIEtWTSBndWVzdD8KCklmIHNvIEkgaGF2ZSBhIGd1dCBmZWVsaW5nIHRoYXQgdGhlIHVz
ZSBvZiBsb2NhbF9pcnFfc2F2ZSgpIGFuZApsb2NhbF9pcnFfcmVzdG9yZSgpIGluIGt2bV93YWl0
KCkgbWlnaHQgYmUgZmlzaHkuIEkgbWlnaHQgYmUgY29tcGxldGVseQp3cm9uZyBoZXJlLCB0aG91
Z2guCgpCVFcsIEkgdGhpbmsgWGVuJ3MgdmFyaWFudCBvZiBwdiBzcGlubG9ja3MgaXMgZmluZSAo
bm8gcGxheWluZyB3aXRoIElSUQpvbi9vZmYpLgoKSHlwZXItViBzZWVtcyB0byBkbyB0aGUgc2Ft
ZSBhcyBLVk0sIGFuZCBraWNraW5nIGFub3RoZXIgdmNwdSBjb3VsZCBiZQpwcm9ibGVtYXRpYyBh
cyB3ZWxsLCBhcyBpdCBpcyBqdXN0IHVzaW5nIElQSS4KCgpKdWVyZ2VuCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
