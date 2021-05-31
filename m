Return-Path: <SRS0=j1Zo=K2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D37C47082
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 07:59:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5125B610A8
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 07:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5125B610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16E5C605C4;
	Mon, 31 May 2021 07:59:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lkc8XlMMuKOz; Mon, 31 May 2021 07:59:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F6A7605B3;
	Mon, 31 May 2021 07:59:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 607CEC000D;
	Mon, 31 May 2021 07:59:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09400C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 07:59:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EC9D183B80
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 07:59:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xSYP7vMwf9Fd
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 07:59:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4897482E29
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 07:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622447950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JcjnvAEV/WokSDAC3vU2MZce29x+fSn0lTKuolUmQWk=;
 b=WAJZ+kgeo4aKXC7jU3H5CQV7XJR8UmW4WzUWQnmpnU9sp6aWmso8nNMQq/iTQ3CgODdkFi
 iAh7UBddjA63h1vuQTKrlbvVJ/51UXm4/QQ4LxQ7f9HmuNR34FsdJZjJg+RylmnU7WYEUo
 pGQ9sADgrfUkbYCQOD2dxDPvXmZWac4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-naUZ4HnGOzC9iACyVG0NQw-1; Mon, 31 May 2021 03:59:06 -0400
X-MC-Unique: naUZ4HnGOzC9iACyVG0NQw-1
Received: by mail-pg1-f198.google.com with SMTP id
 g19-20020a63e6130000b029021f61637110so4251444pgh.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 00:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=JcjnvAEV/WokSDAC3vU2MZce29x+fSn0lTKuolUmQWk=;
 b=Tw5ozXaauTRJD9X3a+CO580/Qy6AEV0qlEXkjP9ELxOPkWfEhFj4fCTWz2G9idBh9z
 8MLsHp1zx0d1w8OBNFQFJfEOGk8wDmueWIjhI20HjGUk7TLtNQokBuep/s8EUcobCsUs
 cNCOwD4KJNOq8nc0QJC576TT+bOqVUv611A7oGU3u2yNwID3fbrV4s5f2j2n6dFAlSfq
 yZInCDlyEh/U9M5w+Ta27i6YraumgoeBGLVcT5uEh6PIRTnAFs45r3Mtswx9UPjo56fd
 75GFFUwRG4zQqbsirGbTYhuvOWfsyEWeFosZWY9PepB5QOU4cxNaHR0G+9qjAlOQMsWL
 EWMw==
X-Gm-Message-State: AOAM530Cw0o3eZr9D9M8eWNINH19Znk9ozXPpQQ8pCHJS1VKefi1hCm7
 LpRhFv3kpvpD6YGSnrR1+H/Tq8Z3oM+y1GbL/H8XUUb+uyao4gpGnSfMkwa9q7cXTWyBQDLSnA1
 Ar6BkTQ8CGfvitZNGzNfDxuOZC02t4uMoNTXfDM+9rA==
X-Received: by 2002:a63:5641:: with SMTP id g1mr21567108pgm.351.1622447945549; 
 Mon, 31 May 2021 00:59:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMx8B/T1/OnnAi1V0HSgbPjxa3+DCXtOfsmzA4DAuI8EMfFrGhnkzCQyirBKQrwzJ+jZTLLg==
X-Received: by 2002:a63:5641:: with SMTP id g1mr21567093pgm.351.1622447945379; 
 Mon, 31 May 2021 00:59:05 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 13sm1042820pfn.33.2021.05.31.00.59.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 May 2021 00:59:04 -0700 (PDT)
Subject: Re: [PATCH v2] vdpa/mlx5: Fix umem sizes assignments on VQ create
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210530090317.8284-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a373e852-6b8a-322d-06a3-546b30194081@redhat.com>
Date: Mon, 31 May 2021 15:58:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210530090317.8284-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNS8zMCDPws7nNTowMywgRWxpIENvaGVuINC0tcA6Cj4gRml4IGNvcHkgcGFzdGUg
YnVnIGFzc2lnbmluZyB1bWVtMSBzaXplIHRvIHVtZW0yIGFuZCB1bWVtMy4gVGhlIGlzc3VlCj4g
d2FzIGRpc2NvdmVyZWQgd2hlbiB0cnlpbmcgdG8gdXNlIGEgMToxIE1SIHRoYXQgY292ZXJzIHRo
ZSBlbnRpcmUKPiBhZGRyZXNzIHNwYWNlIHdoZXJlIGZpcm13YXJlIGNvbXBsYWluZWQgdGhhdCBw
cm92aWRlZCBzaXplcyBhcmUgbm90Cj4gbGFyZ2UgZW5vdWdoLiAxOjEgTVJzIGFyZSByZXF1aXJl
ZCB0byBzdXBwb3J0IHZpcnRpb192ZHBhLgo+Cj4gRml4ZXM6IDFhODZiMzc3YWEyMSAoInZkcGEv
bWx4NTogQWRkIFZEUEEgZHJpdmVyIGZvciBzdXBwb3J0ZWQgbWx4NSBkZXZpY2VzIikKPiBTaWdu
ZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPiAtLS0KPiBWMCAtLT4gVjE6
Cj4gQWRkIG1vcmUgaW5mb3JtYXRpb24gaW4gY2hhbmdlbG9nCj4KPiBWMSAtLT4gVjI6Cj4gRml4
IHR5cG8gaW4gY2hhbmdlbG9nCgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+CgoKPgo+ICAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgNCArKy0t
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMv
dmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IGluZGV4IDE4OWU0Mzg1ZGY0MC4uNTMzMTJmMDQ2
MGFkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ICsr
KyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IEBAIC04MjgsOSArODI4LDkg
QEAgc3RhdGljIGludCBjcmVhdGVfdmlydHF1ZXVlKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2
LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWUKPiAgIAlNTFg1X1NFVCh2aXJ0aW9fcSwgdnFfY3R4
LCB1bWVtXzFfaWQsIG12cS0+dW1lbTEuaWQpOwo+ICAgCU1MWDVfU0VUKHZpcnRpb19xLCB2cV9j
dHgsIHVtZW1fMV9zaXplLCBtdnEtPnVtZW0xLnNpemUpOwo+ICAgCU1MWDVfU0VUKHZpcnRpb19x
LCB2cV9jdHgsIHVtZW1fMl9pZCwgbXZxLT51bWVtMi5pZCk7Cj4gLQlNTFg1X1NFVCh2aXJ0aW9f
cSwgdnFfY3R4LCB1bWVtXzJfc2l6ZSwgbXZxLT51bWVtMS5zaXplKTsKPiArCU1MWDVfU0VUKHZp
cnRpb19xLCB2cV9jdHgsIHVtZW1fMl9zaXplLCBtdnEtPnVtZW0yLnNpemUpOwo+ICAgCU1MWDVf
U0VUKHZpcnRpb19xLCB2cV9jdHgsIHVtZW1fM19pZCwgbXZxLT51bWVtMy5pZCk7Cj4gLQlNTFg1
X1NFVCh2aXJ0aW9fcSwgdnFfY3R4LCB1bWVtXzNfc2l6ZSwgbXZxLT51bWVtMS5zaXplKTsKPiAr
CU1MWDVfU0VUKHZpcnRpb19xLCB2cV9jdHgsIHVtZW1fM19zaXplLCBtdnEtPnVtZW0zLnNpemUp
Owo+ICAgCU1MWDVfU0VUKHZpcnRpb19xLCB2cV9jdHgsIHBkLCBuZGV2LT5tdmRldi5yZXMucGRu
KTsKPiAgIAlpZiAoTUxYNV9DQVBfREVWX1ZEUEFfRU1VTEFUSU9OKG5kZXYtPm12ZGV2Lm1kZXYs
IGV0aF9mcmFtZV9vZmZsb2FkX3R5cGUpKQo+ICAgCQlNTFg1X1NFVCh2aXJ0aW9fcSwgdnFfY3R4
LCB2aXJ0aW9fdmVyc2lvbl8xXzAsIDEpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
