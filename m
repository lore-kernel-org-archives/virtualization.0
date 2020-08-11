Return-Path: <SRS0=ofWe=BV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C60C433E0
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 07:04:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C52AF2078E
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 07:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52AF2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 968CC85EF3;
	Tue, 11 Aug 2020 07:04:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2hv3F2TjkszV; Tue, 11 Aug 2020 07:04:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DAAF585EC1;
	Tue, 11 Aug 2020 07:04:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF7F1C013C;
	Tue, 11 Aug 2020 07:04:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17F59C004D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 07:04:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0E0F985EC6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 07:04:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AQagoTb6EibD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 07:04:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 14DBD85EC1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 07:04:51 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 588C8AC7D;
 Tue, 11 Aug 2020 07:05:10 +0000 (UTC)
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*() helpers
To: Marco Elver <elver@google.com>
References: <20200806113236.GZ2674@hirez.programming.kicks-ass.net>
 <20200806131702.GA3029162@elver.google.com>
 <CANpmjNNqt8YrCad4WqgCoXvH47pRXtSLpnTKhD8W8+UpoYJ+jQ@mail.gmail.com>
 <CANpmjNO860SHpNve+vaoAOgarU1SWy8o--tUWCqNhn82OLCiew@mail.gmail.com>
 <fe2bfa7f-132f-7581-a967-d01d58be1588@suse.com>
 <20200807095032.GA3528289@elver.google.com>
 <16671cf3-3885-eb06-79ff-4cbfaeeaea79@suse.com>
 <20200807113838.GA3547125@elver.google.com>
 <e5bf3e6a-efff-7170-5ee6-1798008393a2@suse.com>
 <CANpmjNPau_DEYadey9OL+iFZKEaUTqnFnyFs1dU12o00mg7ofA@mail.gmail.com>
 <20200807151903.GA1263469@elver.google.com>
 <CANpmjNM1jASqCFYZpteVrZCa2V2D_DbXaqvoCV_Ac2boYfDXnQ@mail.gmail.com>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <26c3214f-7d8a-7b1f-22fc-e864291f50ce@suse.com>
Date: Tue, 11 Aug 2020 09:04:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANpmjNM1jASqCFYZpteVrZCa2V2D_DbXaqvoCV_Ac2boYfDXnQ@mail.gmail.com>
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
 Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>,
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

T24gMTEuMDguMjAgMDk6MDAsIE1hcmNvIEVsdmVyIHdyb3RlOgo+IE9uIEZyaSwgNyBBdWcgMjAy
MCBhdCAxNzoxOSwgTWFyY28gRWx2ZXIgPGVsdmVyQGdvb2dsZS5jb20+IHdyb3RlOgo+PiBPbiBG
cmksIEF1ZyAwNywgMjAyMCBhdCAwMjowOFBNICswMjAwLCBNYXJjbyBFbHZlciB3cm90ZToKPj4+
IE9uIEZyaSwgNyBBdWcgMjAyMCBhdCAxNDowNCwgSsO8cmdlbiBHcm/DnyA8amdyb3NzQHN1c2Uu
Y29tPiB3cm90ZToKPj4+Pgo+Pj4+IE9uIDA3LjA4LjIwIDEzOjM4LCBNYXJjbyBFbHZlciB3cm90
ZToKPj4+Pj4gT24gRnJpLCBBdWcgMDcsIDIwMjAgYXQgMTI6MzVQTSArMDIwMCwgSsO8cmdlbiBH
cm/DnyB3cm90ZToKPiAuLi4KPj4+Pj4+IEkgdGhpbmsgQ09ORklHX1BBUkFWSVJUX1hYTCBzaG91
bGRuJ3QgbWF0dGVyLCBidXQgSSdtIG5vdCBjb21wbGV0ZWx5Cj4+Pj4+PiBzdXJlIGFib3V0IHRo
YXQuIENPTkZJR19QQVJBVklSVF9TUElOTE9DS1Mgd291bGQgYmUgbXkgcHJpbWFyeSBzdXNwZWN0
Lgo+Pj4+Pgo+Pj4+PiBZZXMsIFBBUkFWSVJUX1hYTCBkb2Vzbid0IG1ha2UgYSBkaWZmZXJlbnQu
IFdoZW4gZGlzYWJsaW5nCj4+Pj4+IFBBUkFWSVJUX1NQSU5MT0NLUywgaG93ZXZlciwgdGhlIHdh
cm5pbmdzIGdvIGF3YXkuCj4+Pj4KPj4+PiBUaGFua3MgZm9yIHRlc3RpbmchCj4+Pj4KPj4+PiBJ
IHRha2UgaXQgeW91IGFyZSBkb2luZyB0aGUgdGVzdHMgaW4gYSBLVk0gZ3Vlc3Q/Cj4+Pgo+Pj4g
WWVzLCBjb3JyZWN0Lgo+Pj4KPj4+PiBJZiBzbyBJIGhhdmUgYSBndXQgZmVlbGluZyB0aGF0IHRo
ZSB1c2Ugb2YgbG9jYWxfaXJxX3NhdmUoKSBhbmQKPj4+PiBsb2NhbF9pcnFfcmVzdG9yZSgpIGlu
IGt2bV93YWl0KCkgbWlnaHQgYmUgZmlzaHkuIEkgbWlnaHQgYmUgY29tcGxldGVseQo+Pj4+IHdy
b25nIGhlcmUsIHRob3VnaC4KPj4+Cj4+PiBIYXBweSB0byBoZWxwIGRlYnVnIG1vcmUsIGFsdGhv
dWdoIEkgbWlnaHQgbmVlZCBwYXRjaGVzIG9yIHBvaW50ZXJzCj4+PiB3aGF0IHRvIHBsYXkgd2l0
aC4KPj4+Cj4+Pj4gQlRXLCBJIHRoaW5rIFhlbidzIHZhcmlhbnQgb2YgcHYgc3BpbmxvY2tzIGlz
IGZpbmUgKG5vIHBsYXlpbmcgd2l0aCBJUlEKPj4+PiBvbi9vZmYpLgo+Pj4+Cj4+Pj4gSHlwZXIt
ViBzZWVtcyB0byBkbyB0aGUgc2FtZSBhcyBLVk0sIGFuZCBraWNraW5nIGFub3RoZXIgdmNwdSBj
b3VsZCBiZQo+Pj4+IHByb2JsZW1hdGljIGFzIHdlbGwsIGFzIGl0IGlzIGp1c3QgdXNpbmcgSVBJ
Lgo+Pgo+PiBJIGV4cGVyaW1lbnRlZCBhIGJpdCBtb3JlLCBhbmQgdGhlIGJlbG93IHBhdGNoIHNl
ZW1zIHRvIHNvbHZlIHRoZQo+PiB3YXJuaW5ncy4gSG93ZXZlciwgdGhhdCB3YXMgYmFzZWQgb24g
eW91ciBwb2ludGVyIGFib3V0IGt2bV93YWl0KCksIGFuZAo+PiBJIGNhbid0IHF1aXRlIHRlbGwg
aWYgaXQgaXMgdGhlIHJpZ2h0IHNvbHV0aW9uLgo+Pgo+PiBNeSBoeXBvdGhlc2lzIGhlcmUgaXMg
c2ltcGx5IHRoYXQga3ZtX3dhaXQoKSBtYXkgYmUgY2FsbGVkIGluIGEgcGxhY2UKPj4gd2hlcmUg
d2UgZ2V0IHRoZSBzYW1lIGNhc2UgSSBtZW50aW9uZWQgdG8gUGV0ZXIsCj4+Cj4+ICAgICAgICAg
IHJhd19sb2NhbF9pcnFfc2F2ZSgpOyAvKiBvciBvdGhlciBJUlFzIG9mZiB3aXRob3V0IHRyYWNp
bmcgKi8KPj4gICAgICAgICAgLi4uCj4+ICAgICAgICAgIGt2bV93YWl0KCkgLyogSVJRIHN0YXRl
IHRyYWNpbmcgZ2V0cyBjb25mdXNlZCAqLwo+PiAgICAgICAgICAuLi4KPj4gICAgICAgICAgcmF3
X2xvY2FsX2lycV9yZXN0b3JlKCk7Cj4+Cj4+IGFuZCB0aGVyZWZvcmUsIHVzaW5nIHJhdyB2YXJp
YW50cyBpbiBrdm1fd2FpdCgpIHdvcmtzLiBJdCdzIGFsc28gc2FmZQo+PiBiZWNhdXNlIGl0IGRv
ZXNuJ3QgY2FsbCBhbnkgb3RoZXIgbGlicmFyaWVzIHRoYXQgd291bGQgcmVzdWx0IGluIGNvcnJ1
cHQKPj4gSVJRIHN0YXRlIEFGQUlLLgo+IAo+IEp1c3QgdG8gZm9sbG93LXVwLCBpdCdkIHN0aWxs
IGJlIG5pY2UgdG8gZml4IHRoaXMuIFN1Z2dlc3Rpb25zPwo+IAo+IEkgY291bGQgc2VuZCB0aGUg
YmVsb3cgYXMgYSBwYXRjaCwgYnV0IGNhbiBvbmx5IGdvIG9mZiBteSBhYm92ZQo+IGh5cG90aGVz
aXMgYW5kIHRoZSBmYWN0IHRoYXQgc3l6Ym90IGlzIGhhcHBpZXIsIHNvIG5vdCBlbnRpcmVseQo+
IGNvbnZpbmNpbmcuCgpQZXRlciBoYXMgdG9sZCBtZSB2aWEgSVJDIGhlIHdpbGwgbG9vayBzb29u
IGZ1cnRoZXIgaW50byB0aGlzLgoKWW91ciBmaW5kaW5nIHN1Z2dlc3RzIHRoYXQgdGhlIHB2LWxv
Y2sgaW1wbGVtZW50YXRpb24gZm9yIEh5cGVyLVYKbmVlZHMgc29tZSB0d2Vha2luZywgdG9vLiBG
b3IgdGhhdCBwdXJwb3NlIEknbSBhZGRpbmcgV2VpIHRvIENjLgoKCkp1ZXJnZW4KCj4gCj4gVGhh
bmtzLAo+IC0tIE1hcmNvCj4gCj4+IC0tLS0tLSA+OCAtLS0tLS0KPj4KPj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2tlcm5lbC9rdm0uYyBiL2FyY2gveDg2L2tlcm5lbC9rdm0uYwo+PiBpbmRleCAy
MzNjNzdkMDU2YzkuLjFkNDEyZDE0NjZmMCAxMDA2NDQKPj4gLS0tIGEvYXJjaC94ODYva2VybmVs
L2t2bS5jCj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9rdm0uYwo+PiBAQCAtNzk3LDcgKzc5Nyw3
IEBAIHN0YXRpYyB2b2lkIGt2bV93YWl0KHU4ICpwdHIsIHU4IHZhbCkKPj4gICAgICAgICAgaWYg
KGluX25taSgpKQo+PiAgICAgICAgICAgICAgICAgIHJldHVybjsKPj4KPj4gLSAgICAgICBsb2Nh
bF9pcnFfc2F2ZShmbGFncyk7Cj4+ICsgICAgICAgcmF3X2xvY2FsX2lycV9zYXZlKGZsYWdzKTsK
Pj4KPj4gICAgICAgICAgaWYgKFJFQURfT05DRSgqcHRyKSAhPSB2YWwpCj4+ICAgICAgICAgICAg
ICAgICAgZ290byBvdXQ7Cj4+IEBAIC04MTAsMTAgKzgxMCwxMCBAQCBzdGF0aWMgdm9pZCBrdm1f
d2FpdCh1OCAqcHRyLCB1OCB2YWwpCj4+ICAgICAgICAgIGlmIChhcmNoX2lycXNfZGlzYWJsZWRf
ZmxhZ3MoZmxhZ3MpKQo+PiAgICAgICAgICAgICAgICAgIGhhbHQoKTsKPj4gICAgICAgICAgZWxz
ZQo+PiAtICAgICAgICAgICAgICAgc2FmZV9oYWx0KCk7Cj4+ICsgICAgICAgICAgICAgICByYXdf
c2FmZV9oYWx0KCk7Cj4+Cj4+ICAgb3V0Ogo+PiAtICAgICAgIGxvY2FsX2lycV9yZXN0b3JlKGZs
YWdzKTsKPj4gKyAgICAgICByYXdfbG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOwo+PiAgIH0KPj4K
Pj4gICAjaWZkZWYgQ09ORklHX1g4Nl8zMgo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
