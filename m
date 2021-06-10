Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C21EC48BCD
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 03:13:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6ABD61418
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 03:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6ABD61418
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A57566063C;
	Thu, 10 Jun 2021 03:13:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vtbs3uZaZTEY; Thu, 10 Jun 2021 03:13:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6593C60624;
	Thu, 10 Jun 2021 03:13:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42B6FC000E;
	Thu, 10 Jun 2021 03:13:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F974C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 03:13:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F3D1F40381
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 03:13:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jEykj4xkxG0p
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 03:13:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC5564017C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 03:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623294785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AaHF8TleW9y2yJFtUkdVSK3jH8Hx5NwN6hAUVAUFzZY=;
 b=HafUCfxIZRhMpbyiKxaQGp+nzGk+XR6MEeQPAJv12rXxm7/Cw0k2zGPBVitqht5qdx1Sy5
 b7i/CWD7O3GXrPVPAU9QNQmtr2/BiIxn8bxZ6gICWiULPxeQrW38F2FYIXfxQBmJS9t9Ol
 1X1OMbmYGg2B1dOPf4DxmgUoPrAnG/o=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-Ew_J0jE-OpSPMvYd5CxThg-1; Wed, 09 Jun 2021 23:13:04 -0400
X-MC-Unique: Ew_J0jE-OpSPMvYd5CxThg-1
Received: by mail-pl1-f200.google.com with SMTP id
 w6-20020a1709029a86b0290114becad42fso305546plp.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Jun 2021 20:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=AaHF8TleW9y2yJFtUkdVSK3jH8Hx5NwN6hAUVAUFzZY=;
 b=EBIvsFVa7Rg0Y5Iez5l1pWHSvsC2Mlkb9jhDLSK1wq2RG77yRn3jhS7pam2OOY/EF0
 cxiU12faSLBWspmq69UkT7HTM/GIUdY70BmpA/o1zuGDrJRO8ANrDfbFQKgg3TYA3Pqb
 ENwmSUpZPzzGJ+9R4NNftt5+kJ0syoNIoe0446n0bIyidRpxvzQ3FFkklvXeW8FAARFT
 jbQfKP8huYKeU3Y/tVxyDV0r0tKGAbk8gLfP1vVUEoq7+SUbJNo+I7WoFIH19H4WSDI9
 mj/jZMH2vaiaQSr0/77K/Z0Y05kA+l3SuPq2OQa2glCaxlumhatFSpHFY87v4asuDLQo
 wc7g==
X-Gm-Message-State: AOAM5333IlWqYd0q6Z2sNqswAcEL+40Rzb/dqyrZOhgvITfMyaOfHQTn
 1jUE5bxftz+Dq5C+M3wAOwKT3WL2vClgvnAZyB/fPjTiRDfUHDofXDZQOUH67Fi+YfMpPNEYUpq
 CrKm3tcnTvoRREExbBaO5nxYPgxXOb1iS3SmE5x37vg==
X-Received: by 2002:a05:6a00:ac9:b029:2de:a06d:a52f with SMTP id
 c9-20020a056a000ac9b02902dea06da52fmr921574pfl.4.1623294783019; 
 Wed, 09 Jun 2021 20:13:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/pAIMyn/a062PTQnxMgMFen4R6oZntNzUJIuTOG/VZwhA+MB6v0irLu8mJOnFgruZrZj5dw==
X-Received: by 2002:a05:6a00:ac9:b029:2de:a06d:a52f with SMTP id
 c9-20020a056a000ac9b02902dea06da52fmr921554pfl.4.1623294782797; 
 Wed, 09 Jun 2021 20:13:02 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id o16sm767460pfu.75.2021.06.09.20.12.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jun 2021 20:13:02 -0700 (PDT)
Subject: Re: [PATCH 0/7] Do not read from descriptor ring
To: Andy Lutomirski <luto@kernel.org>, mst@redhat.com
References: <20210604055350.58753-1-jasowang@redhat.com>
 <1c079daa-f73d-cb1a-15ef-d8f57f9813b8@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <633377e3-98d2-2917-3111-2c9c08b5da4f@redhat.com>
Date: Thu, 10 Jun 2021 11:12:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1c079daa-f73d-cb1a-15ef-d8f57f9813b8@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: ashish.kalra@amd.com, ak@linux.intel.com, file@sect.tu-berlin.de,
 kvm@vger.kernel.org, konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 xieyongji@bytedance.com, stefanha@redhat.com
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

CuWcqCAyMDIxLzYvOSDkuIrljYgxMjoyNCwgQW5keSBMdXRvbWlyc2tpIOWGmemBkzoKPiBPbiA2
LzMvMjEgMTA6NTMgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+IEhpOgo+Pgo+PiBUaGUgdmlydGlv
IGRyaXZlciBzaG91bGQgbm90IHRydXN0IHRoZSBkZXZpY2UuIFRoaXMgYmVhbWUgbW9yZSB1cmdl
bnQKPj4gZm9yIHRoZSBjYXNlIG9mIGVuY3J0cHllZCBWTSBvciBWRFVTRVsxXS4gSW4gYm90aCBj
YXNlcywgdGVjaG5vbG9neQo+PiBsaWtlIHN3aW90bGIvSU9NTVUgaXMgdXNlZCB0byBwcmV2ZW50
IHRoZSBwb2tpbmcvbWFuZ2xpbmcgb2YgbWVtb3J5Cj4+IGZyb20gdGhlIGRldmljZS4gQnV0IHRo
aXMgaXMgbm90IHN1ZmZpY2llbnQgc2luY2UgY3VycmVudCB2aXJ0aW8KPj4gZHJpdmVyIG1heSB0
cnVzdCB3aGF0IGlzIHN0b3JlZCBpbiB0aGUgZGVzY3JpcHRvciB0YWJsZSAoY29oZXJlbnQKPj4g
bWFwcGluZykgZm9yIHBlcmZvcm1pbmcgdGhlIERNQSBvcGVyYXRpb25zIGxpa2UgdW5tYXAgYW5k
IGJvdW5jZSBzbwo+PiB0aGUgZGV2aWNlIG1heSBjaG9vc2UgdG8gdXRpbGl6ZSB0aGUgYmVoYXZp
b3VyIG9mIHN3aW90bGIgdG8gcGVyZm9ybQo+PiBhdHRhY2tzWzJdLgo+IEJhc2VkIG9uIGEgcXVp
Y2sgc2tpbSwgdGhpcyBsb29rcyBlbnRpcmVseSByZWFzb25hYmxlIHRvIG1lLgo+Cj4gKEknbSBu
b3QgYSB2aXJ0aW8gbWFpbnRhaW5lciBvciBleHBlcnQuICBJIGdvdCBteSBoYW5kcyB2ZXJ5IGRp
cnR5IHdpdGgKPiB2aXJ0aW8gb25jZSBkZWFsaW5nIHdpdGggdGhlIERNQSBtZXNzLCBidXQgdGhh
dCdzIGFib3V0IGl0LikKPgo+IC0tQW5keQoKCkdvb2QgdG8ga25vdyB0aGF0IDopCgpUaGFua3MK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
