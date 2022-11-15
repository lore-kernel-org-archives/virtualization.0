Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F55AC4332F
	for <virtualization@archiver.kernel.org>; Tue, 15 Nov 2022 11:20:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C24740951;
	Tue, 15 Nov 2022 11:20:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1C24740951
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NM3Ev33Wkv50; Tue, 15 Nov 2022 11:20:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 556E640947;
	Tue, 15 Nov 2022 11:20:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 556E640947
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35391C0033;
	Tue, 15 Nov 2022 11:20:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B59CAC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 11:20:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A6574094B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 11:20:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A6574094B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hGstIiYXWfOx
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 11:20:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 35D9940947
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35D9940947
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 11:20:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CB7A13D5;
 Tue, 15 Nov 2022 03:20:33 -0800 (PST)
Received: from [10.57.70.90] (unknown [10.57.70.90])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8016E3F73B;
 Tue, 15 Nov 2022 03:20:26 -0800 (PST)
Message-ID: <9031b28f-0431-22eb-5dd3-01ae0589b940@arm.com>
Date: Tue, 15 Nov 2022 11:20:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: The arm smmu driver for Linux does not support debugfs
Content-Language: en-GB
To: "leo-hou@hotmail.com" <leo-hou@hotmail.com>, iommu <iommu@lists.linux.dev>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 virtualization <virtualization@lists.linux-foundation.org>
References: <202211141141302410923@hotmail.com>
 <MA0PR01MB5784354703A7B446A6D85CADF6049@MA0PR01MB5784.INDPRD01.PROD.OUTLOOK.COM>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <MA0PR01MB5784354703A7B446A6D85CADF6049@MA0PR01MB5784.INDPRD01.PROD.OUTLOOK.COM>
Cc: will <will@kernel.org>
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

T24gMjAyMi0xMS0xNSAwMjoyOCwgbGVvLWhvdUBob3RtYWlsLmNvbSB3cm90ZToKPiAKPiAKPiBI
aSwKPiAKPiAgwqDCoMKgwqAgV2h5IGRvZXNuJ3QgdGhlIGFybSBzbW11IGRyaXZlciBmb3IgTGlu
dXggc3VwcG9ydCBkZWJ1Z2ZzID8KCkJlY2F1c2Ugbm9ib2R5J3MgZXZlciB3cml0dGVuIGFueSBk
ZWJ1Z2ZzIGNvZGUgZm9yIGl0LgoKPiBBcmUgdGhlcmUgYW55IGhpc3RvcmljYWwgcmVhc29ucz8K
Ck9ubHkgdGhhdCBzbyBmYXIgbm9ib2R5J3MgbmVlZGVkIHRvLgoKVEJILCBhcm0tc21tdSBpcyBh
Y3R1YWxseSBxdWl0ZSBzdHJhaWdodGZvcndhcmQsIGFuZCBub25lIG9mIHRoZSAKaW50ZXJuYWwg
ZHJpdmVyIHN0YXRlIGlzIHJlYWxseSBhbGwgdGhhdCBpbnRlcmVzdGluZyAob3RoZXIgdGhhbiB0
aGUgCnNwZWNpYWwgcHJpdmF0ZSBBZHJlbm8gc3R1ZmYsIGJ1dCB3ZSBsZWF2ZSBpdCB1cCB0byBS
b2IgdG8gaW1wbGVtZW50IAp3aGF0ZXZlciBoZSBuZWVkcyB0aGVyZSkuIEdpdmVuIHRoZSBrZXJu
ZWwgY29uZmlnLCBtb2R1bGUgcGFyYW1ldGVycywgCmFuZCB0aGUgZmVhdHVyZXMgbG9nZ2VkIGF0
IHByb2JlLCB5b3UgY2FuIGFscmVhZHkgaW5mZXIgaG93IGl0IHdpbGwgc2V0IAp1cCBjb250ZXh0
IGJhbmtzIGV0Yy4gZm9yIHJlZ3VsYXIgSU9NTVUgQVBJIHdvcms7IHRoZXJlIHdvbid0IGJlIGFu
eSAKc3VycHJpc2VzLiBBdCB0aGlzIHBvaW50IHRoZXJlIHNob3VsZG4ndCBiZSBhbnkgbmVlZCB0
byBkZWJ1ZyB0aGUgZHJpdmVyIAppdHNlbGYsIGl0J3MgbWF0dXJlIGFuZCBzdGFibGUuIEZvciBk
ZWJ1Z2dpbmcgKnVzZXJzKiBvZiB0aGUgZHJpdmVyLCAKSSd2ZSBvbmx5IGRlYWx0IHdpdGggdGhl
IERNQSBsYXllciwgd2hlcmUgYSBjb21iaW5hdGlvbiBvZiB0aGUgSU9NTVUgQVBJIAp0cmFjZXBv
aW50cywgQ09ORklHX0RNQV9BUElfREVCVUcsIGFuZCBteSBvd24gaGFja3MgdG8gaW9tbXUtZG1h
IGhhdmUgCmFsd2F5cyBwcm92ZWQgc3VmZmljaWVudCB0byBnZXQgZW5vdWdoIGluc2lnaHQgaW50
byB3aGF0J3MgYmVpbmcgbWFwcGVkIAp3aGVyZS4KCkkgdGhpbmsgYSBjb3VwbGUgb2YgcGVvcGxl
IGhhdmUgcHJldmlvdXNseSByYWlzZWQgdGhlIGlkZWEgb2YgCmltcGxlbWVudGluZyBzb21lIGtp
bmQgb2YgZGVidWdmcyBkdW1waW5nIGZvciBpby1wZ3RhYmxlLCBidXQgbm90aGluZydzIApldmVy
IGNvbWUgb2YgaXQuIEFzIGFib3ZlLCBpdCBvZnRlbiB0dXJucyBvdXQgdGhhdCB5b3UgY2FuIGZp
bmQgdGhlIAppbmZvcm1hdGlvbiB5b3UgbmVlZCBmcm9tIG90aGVyIGV4aXN0aW5nIHNvdXJjZXMs
IHRodXMgdGhlIGVmZm9ydCBvZiAKaW1wbGVtZW50aW5nIGFuZCBtYWludGFpbmluZyBhIGxvYWQg
b2Ygc3BlY2lhbC1wdXJwb3NlIGRlYnVnIGNvZGUgY2FuIGJlIApzYXZlZC4gSW4gcGFydGljdWxh
ciBpdCB3b3VsZCBub3QgYmUgd29ydGggaGF2aW5nIGRyaXZlci1zcGVjaWZpYyBjb2RlIAp0aGF0
IG9ubHkgaGVscHMgZGVidWcgZ2VuZXJpYyBJT01NVSBBUEkgdXNhZ2UgLSB0aGF0IHdvdWxkIGJl
IG11Y2ggCmJldHRlciBpbXBsZW1lbnRlZCBhdCB0aGUgZ2VuZXJpYyBJT01NVSBBUEkgbGV2ZWwu
CgpUaGFua3MsClJvYmluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
