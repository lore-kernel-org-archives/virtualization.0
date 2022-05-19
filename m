Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EF1C433F5
	for <virtualization@archiver.kernel.org>; Thu, 19 May 2022 11:16:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECF2141BA3;
	Thu, 19 May 2022 11:16:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iRnHWV33DfgB; Thu, 19 May 2022 11:16:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5315B41741;
	Thu, 19 May 2022 11:16:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23245C0032;
	Thu, 19 May 2022 11:16:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E09D3C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 11:16:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BFD9B60C23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 11:16:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QOozN6qBRv6R
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 11:16:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 47B2560AD0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 11:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=fwaHgMGpyKxUjfrphlTtFfZFCA36vjc6kx8Yyplbjpk=; b=RYDCMXNpjIlJnbpR6ajxa55hj9
 BLxgLS+TW0KAVxKV4JaOWIwnjIdnLelGBL0amhS5m4Bj6RzVX88ZYv4ZnTYLQU2D2AXrBEXNbTXmE
 5UPxBttFRv++AX6J1pfNJpVRGkFI41IgVezP8l3BQ65qAPDRGY3AZChhhVCtt/FZYt8FN/YmI5mcE
 9UktynESLujWWXkmY4qq4fRUo+xa5bkKIefFafuZGBa7CHAxFJpl6jkuGN6nW7Rgs/GQ7d+UBzTFE
 aSXTOimSk22J98oidhup2X9gksk6VIYTjwwM0wx5BlnZzA93g8H6XrtmdIIBJwIA09gPKh0FyI3/P
 YS2nOp9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=worktop.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nre8Y-0020tX-GR; Thu, 19 May 2022 11:16:11 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
 id CBE9F980E0B; Thu, 19 May 2022 13:16:08 +0200 (CEST)
Date: Thu, 19 May 2022 13:16:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christophe de Dinechin <christophe@dinechin.org>
Subject: Re: [PATCH 1/3] sched/headers: Fix compilation error with GCC 12
Message-ID: <20220519111608.GF2578@worktop.programming.kicks-ass.net>
References: <20220414150855.2407137-1-dinechin@redhat.com>
 <20220414150855.2407137-2-dinechin@redhat.com>
 <Ylg73c83AJGwz9UN@hirez.programming.kicks-ass.net>
 <5AEAD35F-10E2-41A3-8269-E8358160D33B@dinechin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5AEAD35F-10E2-41A3-8269-E8358160D33B@dinechin.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, trivial@kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhen Lei <thunder.leizhen@huawei.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux-foundation.org, Ben Segall <bsegall@google.com>,
 Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCBBcHIgMjUsIDIwMjIgYXQgMDQ6MDc6NDNQTSArMDIwMCwgQ2hyaXN0b3BoZSBkZSBE
aW5lY2hpbiB3cm90ZToKCj4gPj4gZXh0ZXJuIHN0cnVjdCBzY2hlZF9jbGFzcyBfX2JlZ2luX3Nj
aGVkX2NsYXNzZXNbXTsKPiA+PiBleHRlcm4gc3RydWN0IHNjaGVkX2NsYXNzIF9fZW5kX3NjaGVk
X2NsYXNzZXNbXTsKPiA+PiAKPiA+PiAtI2RlZmluZSBzY2hlZF9jbGFzc19oaWdoZXN0IChfX2Vu
ZF9zY2hlZF9jbGFzc2VzIC0gMSkKPiA+PiArLyoKPiA+PiArICogc2NoZWRfY2xhc3NfaGlnaGVz
dHMgaXMgcmVhbGx5IF9fZW5kX3NjaGVkX2NsYXNzZXMgLSAxLCBidXQgd3JpdHRlbiBpbiBhIHdh
eQo+ID4+ICsgKiB0aGF0IG1ha2VzIGl0IGNsZWFyIHRoYXQgaXQgaXMgd2l0aGluIF9fYmVnaW5f
c2NoZWRfY2xhc3Nlc1tdIGFuZCBub3Qgb3V0c2lkZQo+ID4+ICsgKiBvZiBfX2VuZF9zY2hlZF9j
bGFzc2VzW10uCj4gPj4gKyAqLwo+ID4+ICsjZGVmaW5lIHNjaGVkX2NsYXNzX2hpZ2hlc3QgKF9f
YmVnaW5fc2NoZWRfY2xhc3NlcyArIFwKPiA+PiArCQkJICAgICAoX19lbmRfc2NoZWRfY2xhc3Nl
cyAtIF9fYmVnaW5fc2NoZWRfY2xhc3NlcyAtIDEpKQo+ID4+ICNkZWZpbmUgc2NoZWRfY2xhc3Nf
bG93ZXN0ICAoX19iZWdpbl9zY2hlZF9jbGFzc2VzIC0gMSkKPiA+PiAKPiA+PiArLyogVGhlICsg
MSBiZWxvdyBwbGFjZXMgdGhlIHBvaW50ZXJzIHdpdGhpbiB0aGUgcmFuZ2Ugb2YgdGhlaXIgYXJy
YXkgKi8KPiA+PiAjZGVmaW5lIGZvcl9jbGFzc19yYW5nZShjbGFzcywgX2Zyb20sIF90bykgXAo+
ID4+IC0JZm9yIChjbGFzcyA9IChfZnJvbSk7IGNsYXNzICE9IChfdG8pOyBjbGFzcy0tKQo+ID4+
ICsJZm9yIChjbGFzcyA9IChfZnJvbSk7IGNsYXNzICsgMSAhPSAoX3RvKSArIDE7IGNsYXNzLS0p
Cj4gPiAKPiA+IFVyZ2gsIHNvIG5vdyB3ZSBnZXQgbGVzcyByZWFkYWJsZSBjb2RlLAo+IAo+IFlv
dSBjb25zaWRlciB0aGUgb3JpZ2luYWwgY29kZSByZWFkYWJsZT8gCgpZZWFoLCBiZWNhdXNlOiB4
ICsgeSAtIHggLSAxID09IHkgLSAxLCBzbyB3dGggd291bGQgeW91IHdhbnQgdG8gd3JpdGUgaXQK
d2l0aCB0aGUgeCBvbi4gVGhhdCdzIGp1c3Qgc2lsbHkuCgo+IEl0IGFjdHVhbGx5IHJlbGllcyBv
biBhCj4gcHJlY2lzZSBsYXlvdXQgdGhhdCBpcyBub3QgZW5mb3JjZWQgaW4gdGhpcyBjb2RlLCBu
b3QgZXZlbiBkb2N1bWVudGVkLAo+IGJ1dCBhY3R1YWxseSBlbmZvcmNlZCBieSB0aGUgbGlua2Vy
IHNjcmlwdC4KCkl0IGhhcyBhIGNvbW1lbnQgcG9pbnRpbmcgYXQgdGhlIGxpbmtlciBzY3JpcHQs
IGFuZCB3ZSBoYXZlOgoKCS8qIE1ha2Ugc3VyZSB0aGUgbGlua2VyIGRpZG4ndCBzY3JldyB1cCAq
LwoJQlVHX09OKCZpZGxlX3NjaGVkX2NsYXNzICsgMSAhPSAmZmFpcl9zY2hlZF9jbGFzcyB8fAoJ
ICAgICAgICZmYWlyX3NjaGVkX2NsYXNzICsgMSAhPSAmcnRfc2NoZWRfY2xhc3MgfHwKCSAgICAg
ICAmcnRfc2NoZWRfY2xhc3MgKyAxICAgIT0gJmRsX3NjaGVkX2NsYXNzKTsKI2lmZGVmIENPTkZJ
R19TTVAKCUJVR19PTigmZGxfc2NoZWRfY2xhc3MgKyAxICE9ICZzdG9wX3NjaGVkX2NsYXNzKTsK
I2VuZGlmCgpPbiBib290IHRvIHZlcmlmeSB0aGUgbGF5b3V0IGlzIGFzIHdlIGV4cGVjdC4KCj4g
PiBqdXN0IGJlY2F1c2UgR0NDIGlzIGJlaW5nCj4gPiBzdHVwaWQ/Cj4gCj4gSSB0aGluayB0aGF0
IEdDQyBpcyBhY3R1YWxseSByZW1hcmthYmx5IHNtYXJ0IHRoZXJlLiBJdCB0ZWxscyB5b3UKPiB0
aGF0IHlvdSBhcmUgYnVpbGRpbmcgcG9pbnRlcnMgdG8gQVtdIGZyb20gQltdLCB3aGVuIHRoZXJl
IGlzIGEgbGVnaXQKPiB3YXkgdG8gc2F5IHRoYXQgdGhlIHBvaW50ZXIgaXMgaW4gQVtdICh3aGlj
aCBpcyB3aGF0IG15IHBhdGNoIGRvZXMpCgpXZSBidWlsZCB3aXRoIC1mbm8tc3RyaWN0LWFsaWFz
aW5nLCBpdCBtdXN0IG5vdCBhc3N1bWUgYW55dGhpbmcgbGlrZQp0aGF0LCB1bmxlc3MgcmVzdHJp
Y3QgaXMgdXNlZC4KCkluIHRoaXMgY2FzZSwgdGhleSdyZSBub3QgdHdvIG9iamVjdHMgYnV0IHRo
ZSBzYW1lIG9uZS4gSnVzdCBiZWNhdXNlCmxpbmtlciBzY3JpcHQgY2FuJ3QgcmVhbGx5IGdldCB1
cyBhIHNlbnNpYmxlIGFycmF5IGRlZmluaXRpb24uCgo+ID4gV2hhdCdzIHdyb25nIHdpdGggbmVn
YXRpdmUgYXJyYXkgaW5kZXhlcz8gbWVtb3J5IGlzIG1lbW9yeSwgc3R1ZmYgd29ya3MuCj4gCj4g
V2hhdOKAmXMgd3JvbmcgaXMgdGhhdCB0aGUgY29tcGlsZXIgY2Fubm90IHByb3ZlIHRoZW9yZW1z
IGFueW1vcmUuCj4gVGhlc2UgdGhlb3JlbXMgYXJlIHVzZWQgdG8gb3B0aW1pc2UgY29kZS4gV2hl
biB5b3Ugd3JpdGUgLTFbQl0sIHRoZQo+IGNvbXBpbGVyIGNhbm5vdCBvcHRpbWlzZSBiYXNlZCBv
biBrbm93aW5nIHRoaXMgcmVmZXJzIHRvIEFbQi1BLTFdLgo+IAo+IFdoaWxlIGF0IGZpcnN0LCB5
b3UgbWlnaHQgdGhpbmsgdGhhdCBkaXNhYmxpbmcgYSB3YXJuaW5nIGlzIGEgd2luLAo+IHdoYXQg
Y29tZXMgbmV4dCBpcyB0aGUgY29tcGlsZXIgb3B0aW1pemluZyBpbiBhIHdheSB5b3UgZGlkIG5v
dAo+IGFudGljaXBhdGUsIG15c3RlcmlvdXMgYnVncyBzaG93aW5nIHVwLCBhbmQvb3IgaGF2aW5n
IHRvIHR1cm4gb2ZmIHNvbWUKPiBwb3RlbnRpYWxseSB1c2VmdWwgb3B0aW1pc2F0aW9uLgoKV2Un
cmUgdXN1YWxseSBmYWlybHkgcXVpY2sgdG8gY2FsbCBhIGNvbXBpbGVyIGJyb2tlbiBpZiBkb2Vz
bid0IGRvIHdoYXQKd2Ugd2FudCBpdCB0by4gRG9kZ3kgb3B0aW1pemF0aW9ucyBnbyBvdXQgdGhl
IHdpbmRvdyByZWFsIGZhc3QuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
