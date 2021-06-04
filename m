Return-Path: <SRS0=Cwtm=K6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1366C47096
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 01:22:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517AA613E3
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 01:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517AA613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 201BC84376;
	Fri,  4 Jun 2021 01:22:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8BGwmQndYFqA; Fri,  4 Jun 2021 01:22:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id AEC9884373;
	Fri,  4 Jun 2021 01:22:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 395EDC000E;
	Fri,  4 Jun 2021 01:22:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C155C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 01:22:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 008A940691
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 01:22:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VWp5S_jI1iEE
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 01:22:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 019CF40609
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 01:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622769773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AiiEtVElMgCs593JVIVumZLvj+RIl3xZvMt3+bseh5s=;
 b=UZGEFjujhD+8cDGF19bMTsF/waadFYiEjwgtsGSKPtckBOOpbrYkHGHFoCfn6S1efBEcs0
 icscgBcfccfQZsTL3MZ4+TcFZNwSh8Jsc8DNZew4QF0qbgUflUkHKan7Co/ifJ5gDqPuiP
 QzcpsIU/yGKZLNbVVjyeMZkF3CJYJY4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-p0I_PoRZMOuiJyT-0xi1zQ-1; Thu, 03 Jun 2021 21:22:52 -0400
X-MC-Unique: p0I_PoRZMOuiJyT-0xi1zQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 mw15-20020a17090b4d0fb0290157199aadbaso6564601pjb.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Jun 2021 18:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=AiiEtVElMgCs593JVIVumZLvj+RIl3xZvMt3+bseh5s=;
 b=TPCgKwBlYvm44V2cUyJxv471wzzWHP5FuVdOjz+PnSCQH2Iom64JdI2oIgaJDX+Vv1
 RWMf/iBiAU3+aYKu11JqhZmhjpuap631hcIKhrp++PFYdfzKj/V1PXh9OxWounKgJVyb
 I6NATYwSfnapVbsT4Jt75G9IwIN0Q2ZZebDx8UQ9Lf6HeGvl3ZCJ5oc3cDc2OchiU5jz
 ZPtRx6ShRJB1b1Wk6XXlLioF15gX4l5HzURXzAO4UFtYplOLkpO6Kh8JL+bq0TQeWXSH
 HtpPikk3dWTyQUcjkKVtB4WW7J3N9NAEAqFRpWov/FNsp4j+eKZK1P9FrYnRMyjU5B+o
 +Chg==
X-Gm-Message-State: AOAM530EU6vVveaEoYuejxVSxlPo5LspNwLl/zbk4ZoH3Cru2Oc/W4qL
 vEjaq1rXW7Wd8M+gntP/QrfUxzWXbMEc7wEQmgiJ3F3MiTB6YXN1rcLqfHupTlyr1yc8yvOnjK1
 U5pBdczFCIC1AD2ElgE/UUuYoYiZnt7vK9g/E4h9Osg==
X-Received: by 2002:aa7:8a5a:0:b029:2ec:7134:7540 with SMTP id
 n26-20020aa78a5a0000b02902ec71347540mr2069643pfa.66.1622769771346; 
 Thu, 03 Jun 2021 18:22:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8I13DZmKGfIc2huzbd5KLYaSyAe/mhYmV3rOnMwUy40nEmTkBCn9htxKDX0fkN/UX8S97Dg==
X-Received: by 2002:aa7:8a5a:0:b029:2ec:7134:7540 with SMTP id
 n26-20020aa78a5a0000b02902ec71347540mr2069623pfa.66.1622769771073; 
 Thu, 03 Jun 2021 18:22:51 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id k17sm232575pff.66.2021.06.03.18.22.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 18:22:50 -0700 (PDT)
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To: Andy Lutomirski <luto@kernel.org>, Andi Kleen <ak@linux.intel.com>,
 mst@redhat.com
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
 <a0e66b4c-cec5-2a26-9431-d5a21e22c8f2@linux.intel.com>
 <2b2dec75-a0c1-4013-ac49-a49f30d5ac3c@www.fastmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9e842353-fec7-667e-8b76-61dbb092f0d8@redhat.com>
Date: Fri, 4 Jun 2021 09:22:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <2b2dec75-a0c1-4013-ac49-a49f30d5ac3c@www.fastmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

CuWcqCAyMDIxLzYvNCDkuIrljYgzOjMxLCBBbmR5IEx1dG9taXJza2kg5YaZ6YGTOgo+Cj4gT24g
VGh1LCBKdW4gMywgMjAyMSwgYXQgMTE6MDAgQU0sIEFuZGkgS2xlZW4gd3JvdGU6Cj4+IE9uIDYv
My8yMDIxIDEwOjMzIEFNLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6Cj4+PiBPbiA2LzIvMjEgNTo0
MSBQTSwgQW5kaSBLbGVlbiB3cm90ZToKPj4+PiBPbmx5IGFsbG93IHNwbGl0IG1vZGUgd2hlbiBp
biBhIHByb3RlY3RlZCBndWVzdC4gRm9sbG93b24KPj4+PiBwYXRjaGVzIGhhcmRlbiB0aGUgc3Bs
aXQgbW9kZSBjb2RlIHBhdGhzLCBhbmQgd2UgZG9uJ3Qgd2FudAo+Pj4+IGFuIG1hbGljaW91cyBo
b3N0IHRvIGZvcmNlIGFueXRoaW5nIGVsc2UuIEFsc28gZGlzYWxsb3cKPj4+PiBpbmRpcmVjdCBt
b2RlIGZvciBzaW1pbGFyIHJlYXNvbnMuCj4+PiBJIHJlYWQgdGhpcyBhcyAidGhlIHZpcnRpbyBk
cml2ZXIgaXMgYnVnZ3kuICBMZXQncyBkaXNhYmxlIG1vc3Qgb2YgdGhlCj4+PiBidWdneSBjb2Rl
IGluIG9uZSBzcGVjaWFsIGNhc2UgaW4gd2hpY2ggd2UgbmVlZCBhIGRyaXZlciB3aXRob3V0IGJ1
Z3MuCj4+PiBJbiBhbGwgdGhlIG90aGVyIGNhc2VzIChlLmcuIGhhcmR3YXJlIHZpcnRpbyBkZXZp
Y2UgY29ubmVjdGVkIG92ZXIKPj4+IFVTQi1DKSwgZHJpdmVyIGJ1Z3MgYXJlIHN0aWxsIGFsbG93
ZWQuIgo+PiBNeSB1bmRlcnN0YW5kaW5nIGlzIG1vc3Qgb2YgdGhlIG90aGVyIG1vZGVzIChleGNl
cHQgZm9yIHNwbGl0IHdpdGgKPj4gc2VwYXJhdGUgZGVzY3JpcHRvcnMpIGFyZSBvYnNvbGV0ZSBh
bmQganVzdCB0aGVyZSBmb3IgY29tcGF0aWJpbGl0eS4gQXMKPj4gbG9uZyBhcyB0aGV5J3JlIGRl
cHJlY2F0ZWQgdGhleSB3b24ndCBoYXJtIGFueW9uZS4KPj4KPj4KPiBUZWxsIHRoYXQgdG8gZXZl
cnkgY3J5cHRvIGRvd25ncmFkZSBhdHRhY2sgZXZlci4KPgo+IEkgc2VlIHR3byBjcmVkaWJsZSBz
b2x1dGlvbnM6Cj4KPiAxLiBBY3R1YWxseSBoYXJkZW4gdGhlIHZpcnRpbyBkcml2ZXIuCj4KPiAy
LiBIYXZlIGEgbmV3IHZpcnRpby1tb2Rlcm4gZHJpdmVyIGFuZCB1c2UgaXQgZm9yIG1vZGVybiB1
c2UgY2FzZXMuIE1heWJlIHJlbmFtZSB0aGUgb2xkIGRyaXZlciB2aXJ0aW8tbGVnYWN5IG9yIHZp
cnRpby1pbnNlY3VyZS4gIFRoZXkgY2FuIHNoYXJlIGNvZGUuCgoKTm90ZSB0aGF0IHdlIGhhZCBh
bHJlYWR5IHNwbGl0IGxlZ2FjeSBkcml2ZXIgb3V0IHdoaWNoIGNhbiBiZSB0dXJuZWQgb2ZmIAp2
aWEgS2NvbmZpZy4KCgo+Cj4gQW5vdGhlciBzbmFnIHlvdSBtYXkgaGl0OiB2aXJ0aW/igJlzIGhl
dXJpc3RpYyBmb3Igd2hldGhlciB0byB1c2UgcHJvcGVyIERNQSBvcHMgb3IgdG8gYnlwYXNzIHRo
ZW0gaXMgYSBnaWFudCBrbHVkZ2UuIEnigJltIHZlcnkgc2xpZ2h0bHkgb3B0aW1pc3RpYyB0aGF0
IGdldHRpbmcgdGhlIGhldXJpc3RpYyB3cm9uZyB3aWxsIG1ha2UgdGhlIGRyaXZlciBmYWlsIHRv
IG9wZXJhdGUgYnV0IHdvbuKAmXQgYWxsb3cgdGhlIGhvc3QgdG8gdGFrZSBvdmVyIHRoZSBndWVz
dCwgYnV0IEnigJltIG5vdCByZWFsbHkgY29udmluY2VkLiBBbmQgSSB3cm90ZSB0aGF0IGNvZGUh
ICBBIHZpcnRpby1tb2Rlcm4gbW9kZSBwcm9iYWJseSBzaG91bGQgbm90IGhhdmUgYSBoZXVyaXN0
aWMsIGFuZCB0aGUgdmFyaW91cyBpb21tdS1ieXBhc3NpbmcgbW9kZXMgc2hvdWxkIGJlIGZpeGVk
IHRvIHdvcmsgYXQgdGhlIGJ1cyBsZXZlbCwgbm90IHRoZSBkZXZpY2UgbGV2ZWwuCgoKSSByZW1l
bWJlciB0aGVyZSdzIGEgdmVyeSBsb25nIGRpc2N1c3Npb24gYWJvdXQgdGhpcyBhbmQgcHJvYmFi
bHkgCndpdGhvdXQgYW55IGNvbmNsdXNpb24uIEZvcnR1bmF0ZWx5LCB0aGUgbWFuYWdlbWVudCBs
YXllciBoYXMgYmVlbiAKdGF1Z2h0IHRvIGVuZm9yY2UgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JN
IGZvciBlbmNyeXB0ZWQgZ3Vlc3RzLgoKQSBwb3NzaWJsZSB3YXkgdG8gZml4IHRoaXMgaXMgd2l0
aG91dCBhbnkgY29uZmxpY3RzIGlzIHRvIG1hbmRhdGUgdGhlIApWSVJUSU9fRl9BQ0NFU1NfUExB
VEZPUk0gaW4gdmVyc2lvbiAxLjIuCgpUaGFua3MKCgo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
