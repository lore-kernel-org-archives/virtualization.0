Return-Path: <SRS0=F+q/=ND=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0B1C432BE
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 06:18:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7739360F91
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 06:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7739360F91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2448E402B5;
	Thu, 12 Aug 2021 06:18:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XHGY3Tc2o0II; Thu, 12 Aug 2021 06:18:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B04D44002B;
	Thu, 12 Aug 2021 06:18:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 835ACC0010;
	Thu, 12 Aug 2021 06:18:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7DB9C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 06:18:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C12C9402B5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 06:18:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6aw8HOl1LhGn
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 06:18:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 23B6D4002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 06:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628749124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BvZhZuJyvKoGArMGtcu0Yd/1tL7iWCU66WqR2CvGmE8=;
 b=HlOxd6IO2Ics2rDn/PB8DwTbDbB/RvevIfqL/pyRaBl22yf2WJMfK1QOcU9+XF6d3Djr2Q
 rOY3B0a6W8vM8BORWaevOu5CrLksxuDmF91/3i4KJKp9GP8ZO+OoWRmDXYrmk27v+01qcS
 XdqSiIoBx1jIZk1iepDjqY5ftQvgeSE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-TFESNWzuPRO_bceckz7TWA-1; Thu, 12 Aug 2021 02:18:43 -0400
X-MC-Unique: TFESNWzuPRO_bceckz7TWA-1
Received: by mail-pl1-f197.google.com with SMTP id
 l16-20020a170902f690b029012cb82f15afso3073465plg.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 23:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=BvZhZuJyvKoGArMGtcu0Yd/1tL7iWCU66WqR2CvGmE8=;
 b=Ugyh+DHnNpixjOep8rClKXJ3XsztsMFiCv1B5mSJDkwvH7TmJLyk74Q63YRM7eUD8F
 VpVGVVUuzTapnaPfHBVmAa093lyI9X6q2Jhu0IcyRvCDEgBxYKjUeiTicfyV4hY9JgAJ
 phNk9QBqh0kE1lsyjs7kPgw6nBu1t9GVnNgc8UI7tK4j6U83NIXmW1k1pLEcxHLKuI9n
 2oDjvOWTUkUyEXTaMxIptDwrMWBcpzKR4DB/gAl64gwO3KdCXMBYn7M4HO9xyKYFIeZ9
 nVMqThFoClxdTxG8h6pKOPH3U4g+Fv5ZWmmlE+zwMfk70Mlj1TQlx5g7aogTn28Uo9EE
 o9hQ==
X-Gm-Message-State: AOAM532iZIfhr+XoKKFy+s+ApmjpIT9g4w1+gixh2Iuk8V7IRAw2+YII
 a6+4D8YrvcxWicW7PxVruwPSF8neN269H+3VDHjhX0qKjsmllgexWdtRASdVvbN1TV9lAB720s3
 TiID6S6c7H3Pib6fa5RiF5I+c/vvXGTRyua2CpHQQ0w==
X-Received: by 2002:a17:90a:2fc2:: with SMTP id
 n2mr2598326pjm.112.1628749122468; 
 Wed, 11 Aug 2021 23:18:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFrm3POic9qEvhrnkuWwMOSiimTrdgBhs9p0B+QoI0fTv1CL6z2bwTKU2r5umFD60vtgGQAA==
X-Received: by 2002:a17:90a:2fc2:: with SMTP id
 n2mr2598308pjm.112.1628749122202; 
 Wed, 11 Aug 2021 23:18:42 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id g19sm8881371pjl.25.2021.08.11.23.18.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Aug 2021 23:18:41 -0700 (PDT)
Subject: Re: [RFC PATCH] virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210811081623.9832-1-jasowang@redhat.com>
 <20210811151754.030a22a7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <aa3e2aca-05a9-aed7-59ec-eb4bd32d8f76@redhat.com>
 <20210812004655-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <da7f6d50-2144-2c84-74c8-fbeb5c10b8b0@redhat.com>
Date: Thu, 12 Aug 2021 14:18:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210812004655-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: willemb@google.com, netdev@vger.kernel.org, ivan@prestigetransportation.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
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

CuWcqCAyMDIxLzgvMTIg5LiL5Y2IMTI6NTAsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4g
T24gVGh1LCBBdWcgMTIsIDIwMjEgYXQgMTE6MjM6MDRBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPj4g5ZyoIDIwMjEvOC8xMiDkuIrljYg2OjE3LCBKYWt1YiBLaWNpbnNraSDlhpnpgZM6Cj4+
PiBPbiBXZWQsIDExIEF1ZyAyMDIxIDE2OjE2OjIzICswODAwIEphc29uIFdhbmcgd3JvdGU6Cj4+
Pj4gVHJ5IHRvIGZpeCB0aGlzIGJ5IHVzaW5nIE5FVElGX0ZfR1JPX0hXIGluc3RlYWQgc28gd2Un
cmUgbm90Cj4+Pj4gZ3VhcmFudGVlZCB0byBiZSByZS1zZWdtZW50ZWQgYXMgb3JpZ2luYWwuCj4+
PiBUaGlzIHNlbnRlbmNlIG1heSBuZWVkIHJlcGhyYXNpbmcuCj4+Cj4+IFJpZ2h0LCBhY3R1YWxs
eSwgSSBtZWFudDoKPj4KPj4KPj4gVHJ5IHRvIGZpeCB0aGlzIGJ5IHVzaW5nIE5FVElGX0ZfR1JP
X0hXIGluc3RlYWQuIEJ1dCB3ZSdyZSBub3Qgc3VyZSB0aGUKPj4gcGFja2V0IGNvdWxkIGJlIHJl
LXNlZ21lbnRlZCB0byB0aGUgZXhhY3Qgb3JpZ2luYWwgcGFja2V0IHN0cmVhbS4gU2luY2UgaXQn
cwo+PiByZWFsbHkgZGVwZW5kcyBvbiB0aGUgYmFrY2VuZCBpbXBsZW1lbnRhdGlvbi4KPj4KPj4K
Pj4+PiBPciB3ZSBtYXkgd2FudCBhIG5ldyBuZXRkZXYKPj4+PiBmZWF0dXJlIGxpa2UgUlhfR1NP
IHNpbmNlIHRoZSBndWVzdCBvZmZsb2FkcyBmb3IgdmlydGlvLW5ldCBpcwo+Pj4+IGFjdHVhbGx5
IHRvIHJlY2VpdmUgR1NPIHBhY2tldC4KPj4+Pgo+Pj4+IE9yIHdlIGNhbiB0cnkgbm90IGFkdmVy
dGlzZSBMUk8gaXMgY29udHJvbCBndWVzdCBvZmZsb2FkcyBpcyBub3QKPj4+PiBlbmFibGVkLiBU
aGlzIHNvbHZlcyB0aGUgd2FybmluZyBidXQgd2lsbCBzdGlsbCBzbG93IGRvd24gdGhlIHRyYWZm
aWMuCj4+PiBJTU8gZ3JvLWh3IGZpdHMgcHJldHR5IHdlbGwsIHBhdGNoIGxvb2tzIGdvb2QuCj4+
Cj4+IElmIHRoZSByZS1zZWdtZW50YXRpb24gaXMgbm90IGEgaXNzdWUuIEkgd2lsbCBwb3N0IGEg
Zm9ybWFsIHBhdGNoLgo+Pgo+PiBUaGFua3MKPgo+IEl0IGlzIGJ1dCB0aGUgcG9pbnQgaXMgZXZl
biB0aG91Z2ggc3BlYyBkaWQgbm90IHJlcXVpcmUgdGhpcwo+IHdlIGFsd2F5cyBhbGxvd2VkIHRo
ZXNlIGNvbmZpZ3VyYXRpb25zCj4gaW4gdGhlIHBhc3Qgc28gaG9wZWZ1bGx5IG1vc3Qgb2YgdGhl
bSBhcmUgbm90IGJyb2tlbiBhbmQgY29tYmluZQo+IHBhY2tldHMgaW4gdGhlIHNhbWUgd2F5IGFz
IEdSTy4gTGV0J3Mgbm90IGJyZWFrIHRoZW0gYWxsCj4gaW4gYW4gYXR0ZW1wdCB0byBjYXRjaCBi
YWQgY29uZmlncywgYW5kIG1lYW53aGlsZSBhbWVuZAo+IHRoZSBzcGVjIHRvIHJlY29tbWVuZCBk
b2luZyBHVyBHUk8uCgoKT2ssIGxldCBtZSBhZGQgdGhpcyBpbiB0aGUgY29tbWl0IGxvZyBhbmQg
c2VuZCBhIGZvcm1hbCBwYXRjaC4KClRoYW5rcwoKCj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
