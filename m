Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246A5C4332F
	for <virtualization@archiver.kernel.org>; Wed, 23 Nov 2022 10:36:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9A6AB40BB9;
	Wed, 23 Nov 2022 10:36:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9A6AB40BB9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=F36by0QJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rCla6l2jPaRZ; Wed, 23 Nov 2022 10:36:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 178F5405BA;
	Wed, 23 Nov 2022 10:36:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 178F5405BA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E035EC0033;
	Wed, 23 Nov 2022 10:36:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D743CC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 10:36:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B2550405D9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 10:36:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B2550405D9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QFVNutJg6DZb
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 10:36:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5BA57405BA
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5BA57405BA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 10:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=/tHbzbSasw+hImnptkkp3nuEh8k6WTnyh4/3rgiCqtg=; b=F36by0QJC/hGNAId6GNID4dp3a
 cWDdL40++hOniXPaks3p3FXQRsROBS+Y7MrYxwAIOC0BZjIJmhKXdCliu7mHxlr30R3cOtYghPsRc
 cWX60BX99nR6sqks/FbNNEl2/6SztwhkEjU8d+8pGOAT2vEDUvzSjgvZ9UDUIWbSBqJM1Rs/XHqMv
 FN40HDSsDZAR+kF9CBnu61IEqmbXayjkdTZY5WgdYewZ6mRE0SojCRJHAsw81ubSJ2vIyBrEDryR6
 NTOoLkGVV7VekuLbhpeNFVaKZuu/IfqWZ/BQX03iDkLnIIvBG0hN9e/S9KWWKAC/RuL3dQ9+QRWWo
 9UMtjcEA==;
Received: from [54.239.6.187] (helo=[192.168.3.58])
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1oxn7D-007RIP-51; Wed, 23 Nov 2022 10:36:27 +0000
Message-ID: <76dabea8f5a305870933bab27fa99a5fb6be3f6d.camel@infradead.org>
Subject: Re: [PATCH v2] virtio_console: Introduce an ID allocator for
 virtual console numbers
From: Amit Shah <amit@infradead.org>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Amit Shah
 <amit@kernel.org>
Date: Wed, 23 Nov 2022 11:36:19 +0100
In-Reply-To: <62cfdcff-9323-5007-67e2-54178e43b21e@kaod.org>
References: <20221114173811.1977367-1-clg@kaod.org>
 <6293fd7d415950979c55c3f09254a6f52eba708b.camel@infradead.org>
 <62cfdcff-9323-5007-67e2-54178e43b21e@kaod.org>
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
Cc: Thomas Huth <thuth@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "Michael S.
 Tsirkin" <mst@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gV2VkLCAyMDIyLTExLTIzIGF0IDExOjE3ICswMTAwLCBDw6lkcmljIExlIEdvYXRlciB3cm90
ZToKPiBIZWxsbyBBbWl0LAo+IAo+IE9uIDExLzIyLzIyIDE4OjAzLCBBbWl0IFNoYWggd3JvdGU6
Cj4gPiBPbiBNb24sIDIwMjItMTEtMTQgYXQgMTg6MzggKzAxMDAsIEPDqWRyaWMgTGUgR29hdGVy
IHdyb3RlOgo+ID4gPiBXaGVuIGEgdmlydGlvIGNvbnNvbGUgcG9ydCBpcyBpbml0aWFsaXplZCwg
aXQgaXMgcmVnaXN0ZXJlZCBhcyBhbiBodmMKPiA+ID4gY29uc29sZSB1c2luZyBhIHZpcnR1YWwg
Y29uc29sZSBudW1iZXIuIElmIGEgS1ZNIGd1ZXN0IGlzIHN0YXJ0ZWQgd2l0aAo+ID4gPiBtdWx0
aXBsZSB2aXJ0aW8gY29uc29sZSBkZXZpY2VzLCB0aGUgc2FtZSB2dGVybW5vIChvciB2aXJ0dWFs
IGNvbnNvbGUKPiA+ID4gbnVtYmVyKSBjYW4gYmUgdXNlZCB0byBhbGxvY2F0ZSBkaWZmZXJlbnQg
aHZjIGNvbnNvbGVzLCB3aGljaCBsZWFkcyB0bwo+ID4gPiB2YXJpb3VzIGNvbW11bmljYXRpb24g
cHJvYmxlbXMgbGF0ZXIgb24uCj4gPiA+IAo+ID4gPiBUaGlzIGlzIGFsc28gcmVwb3J0ZWQgaW4g
ZGVidWdmcyA6Cj4gPiA+IAo+ID4gPiAgICAjIGdyZXAgdnRlcm1ubyAvc3lzL2tlcm5lbC9kZWJ1
Zy92aXJ0aW8tcG9ydHMvKgo+ID4gPiAgICAvc3lzL2tlcm5lbC9kZWJ1Zy92aXJ0aW8tcG9ydHMv
dnBvcnQxcDE6Y29uc29sZV92dGVybW5vOiAxCj4gPiA+ICAgIC9zeXMva2VybmVsL2RlYnVnL3Zp
cnRpby1wb3J0cy92cG9ydDJwMTpjb25zb2xlX3Z0ZXJtbm86IDEKPiA+ID4gICAgL3N5cy9rZXJu
ZWwvZGVidWcvdmlydGlvLXBvcnRzL3Zwb3J0M3AxOmNvbnNvbGVfdnRlcm1ubzogMgo+ID4gPiAg
ICAvc3lzL2tlcm5lbC9kZWJ1Zy92aXJ0aW8tcG9ydHMvdnBvcnQ0cDE6Y29uc29sZV92dGVybW5v
OiAzCj4gPiA+IAo+ID4gPiBSZXBsYWNlIHRoZSBuZXh0X3Z0ZXJtbm8gZ2xvYmFsIHdpdGggYW4g
SUQgYWxsb2NhdG9yIGFuZCBzdGFydCB0aGUKPiA+ID4gYWxsb2NhdGlvbiBhdCAxIGFzIGl0IGlz
IHRvZGF5LiBBbHNvIHJlY3ljbGUgSURzIHdoZW4gYSBjb25zb2xlIHBvcnQKPiA+ID4gaXMgcmVt
b3ZlZC4KPiA+IAo+ID4gV2hlbiB0aGUgb3JpZ2luYWwgdmlydGlvX2NvbnNvbGUgbW9kdWxlIHdh
cyB3cml0dGVuLCBpdCBkaWRuJ3QgaGF2ZQo+ID4gc3VwcG9ydCBmb3IgbXVsdGlwbGUgcG9ydHMg
dG8gYmUgdXNlZCB0aGlzIHdheS4gIFNvIHRoZSBvZGRpdHkgeW91J3JlCj4gPiBzZWVpbmcgaXMg
bGVmdCB0aGVyZSBkZWxpYmVyYXRlbHk6IFZNTXMgc2hvdWxkIG5vdCBiZSBpbnN0YW50aWF0aW5n
Cj4gPiBjb25zb2xlIHBvcnRzIHRoaXMgd2F5Lgo+ID4gCj4gPiBJIGRvbid0IGtub3cgaWYgd2Ug
c2hvdWxkIHRha2UgaW4gdGhpcyBjaGFuZ2UsIGJ1dCBjYW4geW91IHdhbGsgdGhyb3VnaAo+ID4g
YWxsIGNvbWJpbmF0aW9ucyBvZiBuZXcvb2xkIGd1ZXN0IGFuZCBuZXcvb2xkIGh5cGVydmlzb3Ig
YW5kIGVuc3VyZQo+ID4gbm90aGluZydzIGdvaW5nIHRvIGJyZWFrIC0tIGFuZCBjb25maXJtIHdp
dGggdGhlIHNwZWMgdGhpcyBpcyBzdGlsbCBPSwo+ID4gdG8gZG8/ICBJdCBtYXkgbm90IGJlIGEg
Z29hbCB0byBzdGlsbCBlbnN1cmUgbGF1bmNoZXMgb2YgYSBuZXcgZ3Vlc3Qgb24KPiA+IGEgdmVy
eSBvbGQgKHNheSkgQ2VudG9zNSBndWVzdCBzdGlsbCB3b3JrcyAtLSBidXQgdGhhdCB3YXMgdGhl
IHBvaW50IG9mCj4gPiBtYWludGFpbmluZyBiYWNrd2FyZCBjb21wYXQuLi4KPiAKPiAnbmV4dF92
dGVybW5vJyB3YXMgaW50cm9kdWNlZCBieSBkOGEwMmJkNThhYjYgKCJ2aXJ0aW86IGNvbnNvbGU6
Cj4gcmVtb3ZlIGdsb2JhbCB2YXIiKSB0byBkaWZmZXJlbnRpYXRlIHRoZSB1bmRlcmx5aW5nIGtl
cm5lbCBodmMgY29uc29sZQo+IGFzc29jaWF0ZWQgd2l0aCBlYWNoIHZpcnRpbyBjb25zb2xlIHBv
cnQuIFNvbWUgZHJpdmVycywgbGlrZSBYRU4sCj4gc2ltcGx5IHVzZSBhIG1hZ2ljL2Nvb2tpZSBu
dW1iZXIgZm9yIGluc3RhbmNlLgo+IAo+IFRoaXMgbnVtYmVyIGlzIG5vdCByZWxhdGVkIHRvIHRo
ZSB2aXJ0aW8gc3BlY3MuIEl0IGlzIG5vdCBleHBvc2VkIHRvCj4gUUVNVSBub3IgdGhlIGd1ZXN0
IChhIHBhcnQgZnJvbSBkZWJ1Z2ZzKS4gSXQncyBhbiBpbnRlcm5hbCBpZGVudGlmaWVyCj4gcmVs
YXRlZCB0byB0aGUgaW1wbGVtZW50YXRpb24gaW4gdGhlIGtlcm5lbC4gSSBkb24ndCB1bmRlcnN0
YW5kIGhvdwo+IHRoaXMgY291bGQgYnJlYWsgY29tcGF0aWJpbGl0eS4gVGhlIGNoYW5nZSBldmVu
IGtlZXBzIHRoZSBhbGxvY2F0ZWQKPiByYW5nZSB0aGUgc2FtZSBpbiBjYXNlIHNvbWUgYXNzdW1w
dGlvbiBpcyBtYWRlIG9uIHZ0ZXJtbm8gMC4gQW0gSQo+IG1pc3Npbmcgc29tZXRoaW5nID8KCk5v
LCB5b3UncmUgcmlnaHQgYWJvdXQgdGhpcyBiZWluZyBrZXJuZWwtaW50ZXJuYWwgLS0ganVzdCB0
aGF0IGl0J3MKdXNlZCB3aXRoIGh2YyBpbnN0ZWFkIG9mIHFlbXUgbGlrZSBJIG1lbnRpb25lZC4K
CkkgdGhpbmsgdGhpcyBpcyB0aGUgcmlnaHQgY2hhbmdlOyBqdXN0IHdhbnQgdG8gY29uZmlybSBo
dmMgZGlkbid0IGdldApjb25mdXNlZC4KCj4gCj4gSW4gdGhlIHZpcnRpbyBjb25zb2xlIGRyaXZl
ciBjYXNlLCB3ZSBjb3VsZCBhbHNvIGdlbmVyYXRlIGEgdW5pcXVlCj4gbnVtYmVyIGZyb20gdGhl
IHR1cGxlIHsgdmlydGlvIGRldmljZSBpbmRleCwgdmlydGlvIGNvbnNvbGUgcG9ydCB9Lgo+IFRo
ZSBJRCBhbGxvY2F0b3IgYXBwcm9hY2ggaXMgc2ltcGxlci4KCkkgdGhpbmsgdGhlIGJ1ZyBpcyB0
aGF0IHdlIGRvbid0IGluY3JlbWVudCB0aGUgdnRlcm1ubyB0b2RheSBpbiBhbGwKcGxhY2VzIHRo
YXQgd2Ugc2hvdWxkOyBidXQgdGhpcyBwYXRjaCBzb2x2ZXMgaXQgdG9vIC0gSSBkb24ndCBtaW5k
CmFkZGluZyB0aGUgZXh0cmEgaWRhIGJpdHMuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
