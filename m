Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B88C47096
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 22:18:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FDD161404
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 22:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FDD161404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D79B3405FF;
	Thu,  3 Jun 2021 22:18:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NokJG6-5mf2Q; Thu,  3 Jun 2021 22:18:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42C4F4060A;
	Thu,  3 Jun 2021 22:18:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9CA7C0022;
	Thu,  3 Jun 2021 22:18:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBB50C0001;
 Thu,  3 Jun 2021 22:18:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C46AC40152;
 Thu,  3 Jun 2021 22:18:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CQniW2LOeA3q; Thu,  3 Jun 2021 22:18:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 83836400D4;
 Thu,  3 Jun 2021 22:18:00 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16EAB613DA;
 Thu,  3 Jun 2021 22:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622758680;
 bh=iBpJa3hzL2XnQctU7nWWRQdmYnS2ODgfQmpUYL+CSCM=;
 h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
 b=goelUiYeT6Jd2Jmn9BB/fItRWSNuABe7n2yK6Y+YJPyGwSX01/AthAUxdUNw+ZBdH
 SuI8LPItlruF68n+9wr3nEQOW+uYYfMZUBYrszZFMo2SmLpAk8GsqKT6u9BCvL11Bx
 uZRMvXJkNTJy06TL1KjRejiWcrQTNBFDUfs9Zi/gTSEIUsYx/6eh4Ij5+RUQIixemD
 8jHtfO2OfqpJi80x/AB6iHrf1XMwdrpN45cVP45y32uyXpkv1FDCf/r1uQ6I/oKpzI
 JJzK1yHiXw0s9MbQP0YbtwS4NlzJGdQzA5XkVHJkSGL/5RlC9hrb7xq8AbMJeGvGFG
 NLxrgQsCUFDhQ==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailauth.nyi.internal (Postfix) with ESMTP id 1243527C005B;
 Thu,  3 Jun 2021 18:17:58 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute2.internal (MEProxy); Thu, 03 Jun 2021 18:17:58 -0400
X-ME-Sender: <xms:FVW5YLRT78JmV-bHZ9AoDryQjuJpR4-ypqJw1C0C-16TJxC2oFmriQ>
 <xme:FVW5YMx3AI9fPNWvmQAADBmyIDRWJL7yTyuHGXL28y9SAPgQq7VzirqRGx0xVpkia
 IsFuAxUtvKzFe502yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedttddgtddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
 ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
 ftrfgrthhtvghrnhepvdelheejjeevhfdutdeggefftdejtdffgeevteehvdfgjeeiveei
 ueefveeuvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
 heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
 igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:FVW5YA2iRJ4l6-6aEvi8DGy-dOXy17TT6tfVLK03N4Hb0RZn4VKu8g>
 <xmx:FVW5YLAZsPvtN18ZwPhBUul2PsMO1NgC1Ex4mVj-HhEuYLXza_GjtQ>
 <xmx:FVW5YEjUkutjA5TYGDJ6a-6t_a3_9zu1FdRmxDgB735q-gZm4hkPBQ>
 <xmx:FlW5YHMGvwhS2Xfc4aFRCXzjJLsEN6zIXvE9D9II2fdsqgvYRnWx5j0x4FjxAr4r>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id F0C3351C0060; Thu,  3 Jun 2021 18:17:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <b8b39b76-8d07-4e4a-804a-746269787b61@www.fastmail.com>
In-Reply-To: <3159e1f4-77cd-e071-b6f2-a2bb83cfc69a@linux.intel.com>
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
 <a0e66b4c-cec5-2a26-9431-d5a21e22c8f2@linux.intel.com>
 <2b2dec75-a0c1-4013-ac49-a49f30d5ac3c@www.fastmail.com>
 <3159e1f4-77cd-e071-b6f2-a2bb83cfc69a@linux.intel.com>
Date: Thu, 03 Jun 2021 15:17:34 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Andi Kleen" <ak@linux.intel.com>, mst@redhat.com
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiBUaHUsIEp1biAzLCAyMDIxLCBhdCAxMjo1MyBQTSwgQW5kaSBLbGVlbiB3cm90ZToKPiAK
PiA+IFRlbGwgdGhhdCB0byBldmVyeSBjcnlwdG8gZG93bmdyYWRlIGF0dGFjayBldmVyLgo+IAo+
IFRoYXQncyBleGFjdGx5IHdoYXQgdGhpcyBwYXRjaCBhZGRyZXNzZXMuCj4gCj4gPgo+ID4gSSBz
ZWUgdHdvIGNyZWRpYmxlIHNvbHV0aW9uczoKPiA+Cj4gPiAxLiBBY3R1YWxseSBoYXJkZW4gdGhl
IHZpcnRpbyBkcml2ZXIuCj4gVGhhdCdzIGV4YWN0bHkgd2hhdCB0aGlzIHBhdGNoa2l0LCBhbmQg
dGhlIGFsdGVybmF0aXZlIGFwcHJvYWNoZXMsIGxpa2UgCj4gSmFzb24ncywgYXJlIGRvaW5nLgo+
ID4KPiA+IDIuIEhhdmUgYSBuZXcgdmlydGlvLW1vZGVybiBkcml2ZXIgYW5kIHVzZSBpdCBmb3Ig
bW9kZXJuIHVzZSBjYXNlcy4gTWF5YmUgcmVuYW1lIHRoZSBvbGQgZHJpdmVyIHZpcnRpby1sZWdh
Y3kgb3IgdmlydGlvLWluc2VjdXJlLiAgVGhleSBjYW4gc2hhcmUgY29kZS4KPiAKPiBJbiBtb3N0
IHVzZSBjYXNlcyB0aGUgbGVnYWN5IGRyaXZlciBpcyBub3QgaW5zZWN1cmUgYmVjYXVzZSB0aGVy
ZSBpcyBubyAKPiBtZW1vcnkgcHJvdGVjdGlvbiBhbnl3YXlzLgo+IAo+IFllcyBtYXliZSBzdWNo
IGEgc3BsaXQgd291bGQgYmUgYSBnb29kIGlkZWEgZm9yIG1haW50ZW5hbmNlIGFuZCBtYXliZSAK
PiBwZXJmb3JtYW5jZSByZWFzb25zLCBidXQgYXQgbGVhc3QgZnJvbSB0aGUgc2VjdXJpdHkgcGVy
c3BlY3RpdmUgSSBkb24ndCAKPiBzZWUgYW55IG5lZWQgZm9yIGl0LgoKClBsZWFzZSByZXJlYWQg
bXkgZW1haWwuCgpXZSBkbyBub3QgbmVlZCBhbiBpbmNyZWFzaW5nIHBpbGUgb2Yga2x1ZGdlcyB0
byBtYWtlIFREWCBhbmQgU0VWIOKAnHNlY3VyZeKAnS4gIFdlIG5lZWQgdGhlIGFjdHVhbCBsb2Fk
ZWQgZHJpdmVyIHRvIGJlIHNlY3VyZS4gIFRoZSB2aXJ0aW8gYXJjaGl0ZWN0dXJlIGlzIGZ1bGwg
b2YgbGVnYWN5IG5vbnNlbnNlLCBhbmQgdGhlcmUgaXMgbm8gZ29vZCByZWFzb24gZm9yIFNFViBh
bmQgVERYIHRvIGJlIGEgZ2lhbnQgc3BlY2lhbCBjYXNlLgoKQXMgSSBzYWlkIGJlZm9yZSwgcmVh
bCBQQ0llIChUaHVuZGVyYm9sdC9VU0ItQyBvciBhbnl0aGluZyBlbHNlKSBoYXMgdGhlIGV4YWN0
IHNhbWUgcHJvYmxlbS4gIFRoZSBmYWN0IHRoYXQgVERYIGhhcyBlbmNyeXB0ZWQgbWVtb3J5IGlz
LCBhdCBiZXN0LCBhIHBvb3IgcHJveHkgZm9yIHRoZSBhY3R1YWwgY29uZGl0aW9uLiAgVGhlIGFj
dHVhbCBjb25kaXRpb24gaXMgdGhhdCB0aGUgaG9zdCBkb2VzIG5vdCB0cnVzdCB0aGUgZGV2aWNl
IHRvIGltcGxlbWVudCB0aGUgdmlydGlvIHByb3RvY29sIGNvcnJlY3RseS4KCj4gCj4gPgo+ID4g
QW5vdGhlciBzbmFnIHlvdSBtYXkgaGl0OiB2aXJ0aW/igJlzIGhldXJpc3RpYyBmb3Igd2hldGhl
ciB0byB1c2UgcHJvcGVyIERNQSBvcHMgb3IgdG8gYnlwYXNzIHRoZW0gaXMgYSBnaWFudCBrbHVk
Z2UuIEnigJltIHZlcnkgc2xpZ2h0bHkgb3B0aW1pc3RpYyB0aGF0IGdldHRpbmcgdGhlIGhldXJp
c3RpYyB3cm9uZyB3aWxsIG1ha2UgdGhlIGRyaXZlciBmYWlsIHRvIG9wZXJhdGUgYnV0IHdvbuKA
mXQgYWxsb3cgdGhlIGhvc3QgdG8gdGFrZSBvdmVyIHRoZSBndWVzdCwgYnV0IEnigJltIG5vdCBy
ZWFsbHkgY29udmluY2VkLiBBbmQgSSB3cm90ZSB0aGF0IGNvZGUhICBBIHZpcnRpby1tb2Rlcm4g
bW9kZSBwcm9iYWJseSBzaG91bGQgbm90IGhhdmUgYSBoZXVyaXN0aWMsIGFuZCB0aGUgdmFyaW91
cyBpb21tdS1ieXBhc3NpbmcgbW9kZXMgc2hvdWxkIGJlIGZpeGVkIHRvIHdvcmsgYXQgdGhlIGJ1
cyBsZXZlbCwgbm90IHRoZSBkZXZpY2UgbGV2ZWwKPiAKPiBURFggYW5kIFNFViB1c2UgdGhlIGFy
Y2ggaG9vayB0byBlbmZvcmNlIERNQSBBUEksIHNvIHRoYXQgcGFydCBpcyBhbHNvIAo+IHNvbHZl
ZC4KPiAKCkNhbiB5b3UgcG9pbnQgbWUgdG8gdGhlIGNvZGUgeW914oCZcmUgcmVmZXJyaW5nIHRv
PwoKPiAKPiAtQW5kaQo+IAo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
