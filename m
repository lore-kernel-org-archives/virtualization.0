Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A872C4708F
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 02:32:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14BBB613EB
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 02:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BBB613EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D57CE4057D;
	Thu,  3 Jun 2021 02:32:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qUFJciE2OwnL; Thu,  3 Jun 2021 02:32:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B3BE4057E;
	Thu,  3 Jun 2021 02:32:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29048C000E;
	Thu,  3 Jun 2021 02:32:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7382BC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 02:32:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4D24D4057D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 02:32:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dRsPkSWVMZ7Z
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 02:32:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1C43F4057B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 02:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622687568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=taNtlOtsZUjAi05snNFgxAJ5niVmm5tsHS8sJiSNlCE=;
 b=G0HUITQFch1hYcKWOf0w1ElnqFdMgV5+vgODmyzY4yvFNOL9Ez8FoMd74j02CCHXTOrhim
 CMycSY99FxXexjt3x9tbUFjTD3Q2f6qLly+zJj6ZpP33M5T9OudBjTU2+NLEyKXB0GaIg4
 EIu6pL/7pxP6LGWPaDaXEouNsJVmdQo=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-uEUDtEx_OlGyk8KkRI_17g-1; Wed, 02 Jun 2021 22:32:47 -0400
X-MC-Unique: uEUDtEx_OlGyk8KkRI_17g-1
Received: by mail-pg1-f199.google.com with SMTP id
 17-20020a630b110000b029022064e7cdcfso3039384pgl.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Jun 2021 19:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=taNtlOtsZUjAi05snNFgxAJ5niVmm5tsHS8sJiSNlCE=;
 b=g6bziz3KFgqua5tGwLFelXMqs9UlUELAmeQDnJawDldPIa+bWQDGRTaNCjNFG7BViS
 iI3kkcbn0P2Dx4HydZsk6xodBYPUkB+bslKzDRESqsRX4RdIA58f+AfJgLiB1Bd5hliY
 mEjdiuJ1qSNWmmq0/zNLnQpsX/6TYkBqif8NlqzOeNzf7txBnE7ipHcLHSPtoLqeBrTG
 ekofI5o/tuGFMoOnpqL7K6OsrvuJ2SqtFfOp1jvWrXx11FTPVvl60YucKpZxBkccdgoR
 sVgjfhwBmPSR5Y/tNJdYml6LaVb7GXckejydZJxD6wP0ZMd+PSfoS0hk5dztgA0sQdrm
 QdoQ==
X-Gm-Message-State: AOAM531iSiNQmuofn8HVoB7My/2wde/uFcg/K522AYWxWuroD50Z0/b0
 FmPUPUbEsa3R8INlLY2ZW73hNnVL3/opgBmltF08LsNlCdg6gFxY5hZGiXphcGrAvDuUQCb8y7h
 aIosupXVlqvW4wg5eN8IMHZbzQXFm9kKs6JAP6A9+ng==
X-Received: by 2002:a62:7b50:0:b029:2ea:9298:1dcb with SMTP id
 w77-20020a627b500000b02902ea92981dcbmr2002614pfc.1.1622687566504; 
 Wed, 02 Jun 2021 19:32:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwz6ep2t7jrZdGAehf8toVNlmui74UZ7cIZFq7uL7XUXGUiUUq0olnaswJvxVuevvgOPn0mCw==
X-Received: by 2002:a62:7b50:0:b029:2ea:9298:1dcb with SMTP id
 w77-20020a627b500000b02902ea92981dcbmr2002593pfc.1.1622687566256; 
 Wed, 02 Jun 2021 19:32:46 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id ip7sm520736pjb.39.2021.06.02.19.32.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 19:32:45 -0700 (PDT)
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To: Andi Kleen <ak@linux.intel.com>, mst@redhat.com
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <28c8302b-6833-10b4-c0eb-67456e7c4069@redhat.com>
 <09e17c7f-ce51-1a46-72c4-12223bee4e3a@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1c08bc42-7448-351e-78bf-fcf68d2b2561@redhat.com>
Date: Thu, 3 Jun 2021 10:32:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <09e17c7f-ce51-1a46-72c4-12223bee4e3a@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, jpoimboe@redhat.com, robin.murphy@arm.com,
 hch@lst.de, m.szyprowski@samsung.com
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

CuWcqCAyMDIxLzYvMyDkuIrljYg5OjQ4LCBBbmRpIEtsZWVuIOWGmemBkzoKPgo+PiBTbyB3ZSB3
aWxsIHNlZSBodWdlIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24gd2l0aG91dCBpbmRpcmVjdCAKPj4g
ZGVzY3JpcHRvci4gV2UgbmVlZCB0byBjb25zaWRlciB0byBhZGRyZXNzIHRoaXMuCj4KPiBBIHJl
Z3Jlc3Npb24gd291bGQgYmUgd2hlbiBzb21lIGV4aXN0aW5nIGNhc2Ugd291bGQgYmUgc2xvd2Vy
Lgo+Cj4gVGhhdCdzIG5vdCB0aGUgY2FzZSBiZWNhdXNlIHRoZSBiZWhhdmlvciBmb3IgdGhlIGV4
aXN0aW5nIGNhc2VzIGRvZXMgCj4gbm90IGNoYW5nZS4KPgo+IEFueXdheXMgd2hlbiB0aGVyZSBh
cmUgcGVyZm9ybWFuY2UgcHJvYmxlbXMgdGhleSBjYW4gYmUgYWRkcmVzc2VkLCBidXQgCj4gZmly
c3QgaXMgdG8gbWFrZSBpdCBzZWN1cmUuCgoKSSBhZ3JlZSwgYnV0IEkgd2FudCB0byBrbm93IHdo
eSBpbmRpcmVjdCBkZXNjcmlwdG9yIG5lZWRzIHRvIGJlIApkaXNhYmxlZC4gVGhlIHRhYmxlIGNh
bid0IGJlIHdyb3RlIGJ5IHRoZSBkZXZpY2Ugc2luY2UgaXQncyBub3QgY29oZXJlbnQgCnN3aW90
bGIgbWFwcGluZy4KClRoYW5rcwoKCj4KPiAtQW5kaQo+Cj4KPj4KPj4gVGhhbmtzCj4+Cj4+Cj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBjYXNlIFZJUlRJT19SSU5HX0ZfRVZFTlRfSURYOgo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgYnJlYWs7Cj4+PiBAQCAtMjIzMSw5ICsyMjQwLDEyIEBAIHZvaWQgdnJpbmdfdHJhbnNw
b3J0X2ZlYXR1cmVzKHN0cnVjdCAKPj4+IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgY2FzZSBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk06Cj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIFZJUlRJ
T19GX1JJTkdfUEFDS0VEOgo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHByb3RlY3Rl
ZF9ndWVzdF9oYXMoVk1fTUVNX0VOQ1JZUFQpKQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBnb3RvIGNsZWFyOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBWSVJUSU9fRl9PUkRFUl9QTEFURk9STToKPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGNs
ZWFyOgo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGRlZmF1bHQ6Cj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAvKiBXZSBkb24ndCB1bmRlcnN0YW5kIHRoaXMgYml0LiAqLwo+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgX192aXJ0aW9fY2xlYXJfYml0KHZkZXYsIGkpOwo+Pgo+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
