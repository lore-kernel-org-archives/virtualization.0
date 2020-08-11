Return-Path: <SRS0=ofWe=BV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F66C433E1
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 08:38:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B41B206B5
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 08:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B41B206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0F5BB85516;
	Tue, 11 Aug 2020 08:38:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wh1SKl6bldkK; Tue, 11 Aug 2020 08:38:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 53B6B8535D;
	Tue, 11 Aug 2020 08:38:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38C4CC013C;
	Tue, 11 Aug 2020 08:38:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4028C004D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 08:38:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BDB4520435
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 08:38:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xTW899VoHn8B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 08:38:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id 74CA12001C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 08:38:52 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9C3F0B1ED;
 Tue, 11 Aug 2020 08:39:11 +0000 (UTC)
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*() helpers
To: Peter Zijlstra <peterz@infradead.org>
References: <CANpmjNO860SHpNve+vaoAOgarU1SWy8o--tUWCqNhn82OLCiew@mail.gmail.com>
 <fe2bfa7f-132f-7581-a967-d01d58be1588@suse.com>
 <20200807095032.GA3528289@elver.google.com>
 <16671cf3-3885-eb06-79ff-4cbfaeeaea79@suse.com>
 <20200807113838.GA3547125@elver.google.com>
 <e5bf3e6a-efff-7170-5ee6-1798008393a2@suse.com>
 <CANpmjNPau_DEYadey9OL+iFZKEaUTqnFnyFs1dU12o00mg7ofA@mail.gmail.com>
 <20200807151903.GA1263469@elver.google.com>
 <20200811074127.GR3982@worktop.programming.kicks-ass.net>
 <a2dffeeb-04f0-8042-b39a-b839c4800d6f@suse.com>
 <20200811081205.GV3982@worktop.programming.kicks-ass.net>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <07f61573-fef1-e07c-03f2-a415c88dec6f@suse.com>
Date: Tue, 11 Aug 2020 10:38:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811081205.GV3982@worktop.programming.kicks-ass.net>
Content-Language: en-US
Cc: syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>,
 fenghua.yu@intel.com, Marco Elver <elver@google.com>, "Luck,
 Tony" <tony.luck@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 yu-cheng.yu@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
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

T24gMTEuMDguMjAgMTA6MTIsIFBldGVyIFppamxzdHJhIHdyb3RlOgo+IE9uIFR1ZSwgQXVnIDEx
LCAyMDIwIGF0IDA5OjU3OjU1QU0gKzAyMDAsIErDvHJnZW4gR3Jvw58gd3JvdGU6Cj4+IE9uIDEx
LjA4LjIwIDA5OjQxLCBQZXRlciBaaWpsc3RyYSB3cm90ZToKPj4+IE9uIEZyaSwgQXVnIDA3LCAy
MDIwIGF0IDA1OjE5OjAzUE0gKzAyMDAsIE1hcmNvIEVsdmVyIHdyb3RlOgo+Pj4KPj4+PiBNeSBo
eXBvdGhlc2lzIGhlcmUgaXMgc2ltcGx5IHRoYXQga3ZtX3dhaXQoKSBtYXkgYmUgY2FsbGVkIGlu
IGEgcGxhY2UKPj4+PiB3aGVyZSB3ZSBnZXQgdGhlIHNhbWUgY2FzZSBJIG1lbnRpb25lZCB0byBQ
ZXRlciwKPj4+Pgo+Pj4+IAlyYXdfbG9jYWxfaXJxX3NhdmUoKTsgLyogb3Igb3RoZXIgSVJRcyBv
ZmYgd2l0aG91dCB0cmFjaW5nICovCj4+Pj4gCS4uLgo+Pj4+IAlrdm1fd2FpdCgpIC8qIElSUSBz
dGF0ZSB0cmFjaW5nIGdldHMgY29uZnVzZWQgKi8KPj4+PiAJLi4uCj4+Pj4gCXJhd19sb2NhbF9p
cnFfcmVzdG9yZSgpOwo+Pj4+Cj4+Pj4gYW5kIHRoZXJlZm9yZSwgdXNpbmcgcmF3IHZhcmlhbnRz
IGluIGt2bV93YWl0KCkgd29ya3MuIEl0J3MgYWxzbyBzYWZlCj4+Pj4gYmVjYXVzZSBpdCBkb2Vz
bid0IGNhbGwgYW55IG90aGVyIGxpYnJhcmllcyB0aGF0IHdvdWxkIHJlc3VsdCBpbiBjb3JydXB0
Cj4+Pgo+Pj4gWWVzLCB0aGlzIGlzIGRlZmluaXRlbHkgYW4gaXNzdWUuCj4+Pgo+Pj4gVHJhY2lu
Zywgd2UgYWxzbyBtdXNuJ3QgY2FsbCBpbnRvIHRyYWNpbmcgd2hlbiB1c2luZyByYXdfbG9jYWxf
aXJxXyooKS4KPj4+IEJlY2F1c2UgdGhlbiB3ZSByZS1pbnRvZHVjZSB0aGlzIHNhbWUgaXNzdWUg
YWxsIG92ZXIgYWdhaW4uCj4+Pgo+Pj4gQm90aCBoYWx0KCkgYW5kIHNhZmVfaGFsdCgpIGFyZSBt
b3JlIHBhcmF2aXJ0IGNhbGxzLCBidXQgZ2l2ZW4gd2UncmUgaW4KPj4+IGEgS1ZNIHBhcmF2aXJ0
IGNhbGwgYWxyZWFkeSwgSSBzdXBwb3NlIHdlIGNhbiBkaXJlY3RseSB1c2UgbmF0aXZlXyooKQo+
Pj4gaGVyZS4KPj4+Cj4+PiBTb21ldGhpbmcgbGlrZSBzbyB0aGVuLi4uIEkgc3VwcG9zZSwgYnV0
IHRoZW4gdGhlIFhlbiB2YXJpYW50cyBuZWVkIFRMQwo+Pj4gdG9vLgo+Pgo+PiBKdXN0IHRvIGJl
IHN1cmUgSSB1bmRlcnN0YW5kIHlvdSBjb3JyZWN0Ogo+Pgo+PiBZb3UgbWVhbiB0aGF0IHhlbl9x
bG9ja19raWNrKCkgYW5kIHhlbl9xbG9ja193YWl0KCkgYW5kIGFsbCBmdW5jdGlvbnMKPj4gY2Fs
bGVkIGJ5IHRob3NlIHNob3VsZCBnYWluIHRoZSAibm90cmFjZSIgYXR0cmlidXRlLCByaWdodD8K
Pj4KPj4gSSBhbSBub3Qgc3VyZSB3aHkgdGhlIGtpY2sgdmFyaWFudHMgbmVlZCBpdCwgdGhvdWdo
LiBJTU8gdGhvc2UgYXJlCj4+IGNhbGxlZCBvbmx5IGFmdGVyIHRoZSBsb2NrIGhhcyBiZWVuIHJl
bGVhc2VkLCBzbyB0aGV5IHNob3VsZCBiZSBmaW5lCj4+IHdpdGhvdXQgbm90cmFjZS4KPiAKPiBU
aGUgaXNzdWUgaGFwcGVucyB3aGVuIHNvbWVvbmUgdXNlcyBhcmNoX3NwaW5sb2NrX3QgdW5kZXIK
PiByYXdfbG9jYWxfaXJxXyooKS4KPiAKPj4gQW5kIGFnYWluOiB3ZSBzaG91bGRuJ3QgZm9yZ2V0
IHRoZSBIeXBlci1WIHZhcmlhbnRzLgo+IAo+IEJhaCwgbXkgZ3JlcCBmYWlsZWQgOi8gQWxzbyAq
Z3JvYW4qLCB0aGF0J3MgY2FsbGluZyBhcGljLT5zZW5kX0lQSSgpLgoKSW4gY2FzZSB5b3UgZG9u
J3Qgd2FudCB0byBkbyBpdCBJIGNhbiBzZW5kIHRoZSBwYXRjaCBmb3IgdGhlIFhlbgp2YXJpYW50
cy4KCgpKdWVyZ2VuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
