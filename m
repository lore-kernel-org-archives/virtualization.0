Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC60C47082
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 19:53:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 249F5613F8
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 19:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249F5613F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3559401CF;
	Thu,  3 Jun 2021 19:53:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Arc0Ioj74J13; Thu,  3 Jun 2021 19:53:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82088402E8;
	Thu,  3 Jun 2021 19:53:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17650C0022;
	Thu,  3 Jun 2021 19:53:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF905C0001;
 Thu,  3 Jun 2021 19:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C0AE2401EA;
 Thu,  3 Jun 2021 19:53:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n47D5G2RcLnz; Thu,  3 Jun 2021 19:53:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6DF2C401CF;
 Thu,  3 Jun 2021 19:53:52 +0000 (UTC)
IronPort-SDR: Ha4/aNhUjh9dLGHEqhpx5hq3ORFhUTngZoFbL6fk37c8VKQ+9MG+DaioNHmTj67K8xCeFIGqnR
 sEQSqFfTsHxA==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="191474598"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; d="scan'208";a="191474598"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2021 12:53:45 -0700
IronPort-SDR: j796NHDs2Zozxq/wBHEuvMXvyPgtLyCvrhm5igEiL3IiR3qXnYzpqEuyF5uad7fplBhS/dqAsL
 5gvTbni69t6A==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; d="scan'208";a="550819682"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.7.237])
 ([10.209.7.237])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2021 12:53:44 -0700
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To: Andy Lutomirski <luto@kernel.org>, mst@redhat.com
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
 <a0e66b4c-cec5-2a26-9431-d5a21e22c8f2@linux.intel.com>
 <2b2dec75-a0c1-4013-ac49-a49f30d5ac3c@www.fastmail.com>
From: Andi Kleen <ak@linux.intel.com>
Message-ID: <3159e1f4-77cd-e071-b6f2-a2bb83cfc69a@linux.intel.com>
Date: Thu, 3 Jun 2021 12:53:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <2b2dec75-a0c1-4013-ac49-a49f30d5ac3c@www.fastmail.com>
Content-Language: en-US
Cc: sathyanarayanan.kuppuswamy@linux.intel.com,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Josh Poimboeuf <jpoimboe@redhat.com>, robin.murphy@arm.com, hch@lst.de,
 m.szyprowski@samsung.com
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

Cj4gVGVsbCB0aGF0IHRvIGV2ZXJ5IGNyeXB0byBkb3duZ3JhZGUgYXR0YWNrIGV2ZXIuCgpUaGF0
J3MgZXhhY3RseSB3aGF0IHRoaXMgcGF0Y2ggYWRkcmVzc2VzLgoKPgo+IEkgc2VlIHR3byBjcmVk
aWJsZSBzb2x1dGlvbnM6Cj4KPiAxLiBBY3R1YWxseSBoYXJkZW4gdGhlIHZpcnRpbyBkcml2ZXIu
ClRoYXQncyBleGFjdGx5IHdoYXQgdGhpcyBwYXRjaGtpdCwgYW5kIHRoZSBhbHRlcm5hdGl2ZSBh
cHByb2FjaGVzLCBsaWtlIApKYXNvbidzLCBhcmUgZG9pbmcuCj4KPiAyLiBIYXZlIGEgbmV3IHZp
cnRpby1tb2Rlcm4gZHJpdmVyIGFuZCB1c2UgaXQgZm9yIG1vZGVybiB1c2UgY2FzZXMuIE1heWJl
IHJlbmFtZSB0aGUgb2xkIGRyaXZlciB2aXJ0aW8tbGVnYWN5IG9yIHZpcnRpby1pbnNlY3VyZS4g
IFRoZXkgY2FuIHNoYXJlIGNvZGUuCgpJbiBtb3N0IHVzZSBjYXNlcyB0aGUgbGVnYWN5IGRyaXZl
ciBpcyBub3QgaW5zZWN1cmUgYmVjYXVzZSB0aGVyZSBpcyBubyAKbWVtb3J5IHByb3RlY3Rpb24g
YW55d2F5cy4KClllcyBtYXliZSBzdWNoIGEgc3BsaXQgd291bGQgYmUgYSBnb29kIGlkZWEgZm9y
IG1haW50ZW5hbmNlIGFuZCBtYXliZSAKcGVyZm9ybWFuY2UgcmVhc29ucywgYnV0IGF0IGxlYXN0
IGZyb20gdGhlIHNlY3VyaXR5IHBlcnNwZWN0aXZlIEkgZG9uJ3QgCnNlZSBhbnkgbmVlZCBmb3Ig
aXQuCgo+Cj4gQW5vdGhlciBzbmFnIHlvdSBtYXkgaGl0OiB2aXJ0aW/igJlzIGhldXJpc3RpYyBm
b3Igd2hldGhlciB0byB1c2UgcHJvcGVyIERNQSBvcHMgb3IgdG8gYnlwYXNzIHRoZW0gaXMgYSBn
aWFudCBrbHVkZ2UuIEnigJltIHZlcnkgc2xpZ2h0bHkgb3B0aW1pc3RpYyB0aGF0IGdldHRpbmcg
dGhlIGhldXJpc3RpYyB3cm9uZyB3aWxsIG1ha2UgdGhlIGRyaXZlciBmYWlsIHRvIG9wZXJhdGUg
YnV0IHdvbuKAmXQgYWxsb3cgdGhlIGhvc3QgdG8gdGFrZSBvdmVyIHRoZSBndWVzdCwgYnV0IEni
gJltIG5vdCByZWFsbHkgY29udmluY2VkLiBBbmQgSSB3cm90ZSB0aGF0IGNvZGUhICBBIHZpcnRp
by1tb2Rlcm4gbW9kZSBwcm9iYWJseSBzaG91bGQgbm90IGhhdmUgYSBoZXVyaXN0aWMsIGFuZCB0
aGUgdmFyaW91cyBpb21tdS1ieXBhc3NpbmcgbW9kZXMgc2hvdWxkIGJlIGZpeGVkIHRvIHdvcmsg
YXQgdGhlIGJ1cyBsZXZlbCwgbm90IHRoZSBkZXZpY2UgbGV2ZWwKClREWCBhbmQgU0VWIHVzZSB0
aGUgYXJjaCBob29rIHRvIGVuZm9yY2UgRE1BIEFQSSwgc28gdGhhdCBwYXJ0IGlzIGFsc28gCnNv
bHZlZC4KCgotQW5kaQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
