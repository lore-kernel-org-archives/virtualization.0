Return-Path: <SRS0=SJT6=GA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732CCC433E0
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 08:43:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A5A2208B6
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 08:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5A2208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AB82A86A37;
	Mon, 28 Dec 2020 08:43:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XAL0rXAEKdf9; Mon, 28 Dec 2020 08:43:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5DDA8869C7;
	Mon, 28 Dec 2020 08:43:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3ADB4C1787;
	Mon, 28 Dec 2020 08:43:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4C3AC0891
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 08:43:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B0BC686A37
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 08:43:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H96674qk68Xx
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 08:43:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E832A869C7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 08:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609145024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b/mQcN8HBMjEvpA5cui1zWJDGM1GYmpavHlrRlsXqE4=;
 b=BHjOHyXqPdygAdIgXCxlEtCC4AfmlPs2v4wJqaDYdJJ/mAo0fyRDeaDFk2m5jBnHpaycWk
 L3UZtQg4BfxWTMWakupEPKpJ/LLniAhiRYMC+18wyRHCJ61MBEMf77OJnENHqBzY29EF3c
 pOpWKaHdmm1PfeeyjniWES9vXcSf/Eg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-fgpg1Q3MMjmXbi0k5uLn9w-1; Mon, 28 Dec 2020 03:43:40 -0500
X-MC-Unique: fgpg1Q3MMjmXbi0k5uLn9w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D532A800D53;
 Mon, 28 Dec 2020 08:43:37 +0000 (UTC)
Received: from [10.72.13.159] (ovpn-13-159.pek2.redhat.com [10.72.13.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEDAC704DA;
 Mon, 28 Dec 2020 08:43:19 +0000 (UTC)
Subject: Re: [RFC v2 09/13] vduse: Add support for processing vhost iotlb
 message
To: Yongji Xie <xieyongji@bytedance.com>
References: <20201222145221.711-1-xieyongji@bytedance.com>
 <20201222145221.711-10-xieyongji@bytedance.com>
 <6818a214-d587-4f0b-7de6-13c4e7e94ab6@redhat.com>
 <CACycT3vVU9vg6R6UujSnSdk8cwxWPVgeJJs0JaBH_Zg4xC-epQ@mail.gmail.com>
 <595fe7d6-7876-26e4-0b7c-1d63ca6d7a97@redhat.com>
 <CACycT3s=m=PQb5WFoMGhz8TNGme4+=rmbbBTtrugF9ZmNnWxEw@mail.gmail.com>
 <0e6faf9c-117a-e23c-8d6d-488d0ec37412@redhat.com>
 <CACycT3uwXBYvRbKDWdN3oCekv+o6_Lc=-KTrxejD=fr-zgibGw@mail.gmail.com>
 <2b24398c-e6d9-14ec-2c0d-c303d528e377@redhat.com>
 <CACycT3uDV43ecScrMh1QVpStuwDETHykJzzY=pkmZjP2Dd2kvg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e77c97c5-6bdc-cdd0-62c0-6ff75f6dbdff@redhat.com>
Date: Mon, 28 Dec 2020 16:43:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACycT3uDV43ecScrMh1QVpStuwDETHykJzzY=pkmZjP2Dd2kvg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: axboe@kernel.dk, corbet@lwn.net, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-aio@kvack.org,
 netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org, bcrl@kvack.org,
 viro@zeniv.linux.org.uk, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org
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

Ck9uIDIwMjAvMTIvMjgg5LiL5Y2INDoxNCwgWW9uZ2ppIFhpZSB3cm90ZToKPj4gSSBzZWUuIFNv
IGFsbCB0aGUgYWJvdmUgdHdvIHF1ZXN0aW9ucyBhcmUgYmVjYXVzZSBWSE9TVF9JT1RMQl9JTlZB
TElEQVRFCj4+IGlzIGV4cGVjdGVkIHRvIGJlIHN5bmNocm9ub3VzLiBUaGlzIG5lZWQgdG8gYmUg
c29sdmVkIGJ5IHR3ZWFraW5nIHRoZQo+PiBjdXJyZW50IFZEVVNFIEFQSSBvciB3ZSBjYW4gcmUt
dmlzaXQgdG8gZ28gd2l0aCBkZXNjcmlwdG9ycyByZWxheWluZyBmaXJzdC4KPj4KPiBBY3R1YWxs
eSBhbGwgdmRwYSByZWxhdGVkIG9wZXJhdGlvbnMgYXJlIHN5bmNocm9ub3VzIGluIGN1cnJlbnQK
PiBpbXBsZW1lbnRhdGlvbi4gVGhlIG9wcy5zZXRfbWFwL2RtYV9tYXAvZG1hX3VubWFwIHNob3Vs
ZCBub3QgcmV0dXJuCj4gdW50aWwgdGhlIFZEVVNFX1VQREFURV9JT1RMQi9WRFVTRV9JTlZBTElE
QVRFX0lPVExCIG1lc3NhZ2UgaXMgcmVwbGllZAo+IGJ5IHVzZXJzcGFjZS4gQ291bGQgaXQgc29s
dmUgdGhpcyBwcm9ibGVtPwoKCiDCoEkgd2FzIHRoaW5raW5nIHdoZXRoZXIgb3Igbm90IHdlIG5l
ZWQgdG8gZ2VuZXJhdGUgSU9UTEJfSU5WQUxJREFURSAKbWVzc2FnZSB0byBWRFVTRSBkdXJpbmcg
ZG1hX3VubWFwICh2ZHVzZV9kZXZfdW5tYXBfcGFnZSkuCgpJZiB3ZSBkb24ndCwgd2UncmUgcHJv
YmFibHkgZmluZS4KClRoYW5rcwoKCj4KPiBUaGFua3MsCj4gWW9uZ2ppCj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
