Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA85CC433DB
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 03:01:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A442310D
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 03:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A442310D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A2B70204F7;
	Wed, 20 Jan 2021 03:01:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6TjRWH7oGpRH; Wed, 20 Jan 2021 03:01:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5ED6020472;
	Wed, 20 Jan 2021 03:01:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46BF0C08A1;
	Wed, 20 Jan 2021 03:01:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 889A9C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:01:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 474D320472
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:01:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RVbnbfqmM5yn
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:01:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 7A29D204F7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611111700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZodmnXn4xAMstumzC/OBLSYq3RcxDLukButfIEIAT2Y=;
 b=dDs6wQ1ffFiPU+1MhVwtVQWOH8d0cWBK7QZE7qkDM601YfCV5YJCejOFNJ+NlEem4QFwFR
 NEEYP3eaIf2XywOI7cwR2aDQCFt+eSXJEnrBvCrno2w0uynEQTgC/AWa+WoOYSJxBFeYej
 vMisZaIR21KxBl80/azjmQgUdrkMWLE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-RfqNDkrNMjyVLRuQG31F_g-1; Tue, 19 Jan 2021 22:01:37 -0500
X-MC-Unique: RfqNDkrNMjyVLRuQG31F_g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 105C0E743;
 Wed, 20 Jan 2021 03:01:35 +0000 (UTC)
Received: from [10.72.13.124] (ovpn-13-124.pek2.redhat.com [10.72.13.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02EC172171;
 Wed, 20 Jan 2021 03:01:25 +0000 (UTC)
Subject: Re: [PATCH bpf-next v2 1/3] net: add priv_flags for allow tx skb
 without linear
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <cover.1611048724.git.xuanzhuo@linux.alibaba.com>
 <30ae1c94b5c26919bd90bb251761c526edfbaf56.1611048724.git.xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <13d2ceda-16d1-488c-d131-55cca813b224@redhat.com>
Date: Wed, 20 Jan 2021 11:01:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <30ae1c94b5c26919bd90bb251761c526edfbaf56.1611048724.git.xuanzhuo@linux.alibaba.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

Ck9uIDIwMjEvMS8xOSDkuIvljYg1OjQ1LCBYdWFuIFpodW8gd3JvdGU6Cj4gSW4gc29tZSBjYXNl
cywgd2UgaG9wZSB0byBjb25zdHJ1Y3Qgc2tiIGRpcmVjdGx5IGJhc2VkIG9uIHRoZSBleGlzdGlu
Zwo+IG1lbW9yeSB3aXRob3V0IGNvcHlpbmcgZGF0YS4gSW4gdGhpcyBjYXNlLCB0aGUgcGFnZSB3
aWxsIGJlIHBsYWNlZAo+IGRpcmVjdGx5IGluIHRoZSBza2IsIGFuZCB0aGUgbGluZWFyIHNwYWNl
IG9mIHNrYiBpcyBlbXB0eS4gQnV0Cj4gdW5mb3J0dW5hdGVseSwgbWFueSB0aGUgbmV0d29yayBj
YXJkIGRvZXMgbm90IHN1cHBvcnQgdGhpcyBvcGVyYXRpb24uCj4gRm9yIGV4YW1wbGUgTWVsbGFu
b3ggVGVjaG5vbG9naWVzIE1UMjc3MTAgRmFtaWx5IFtDb25uZWN0WC00IEx4XSB3aWxsCj4gZ2V0
IHRoZSBmb2xsb3dpbmcgZXJyb3IgbWVzc2FnZToKPgo+ICAgICAgbWx4NV9jb3JlIDAwMDA6M2I6
MDAuMSBldGgxOiBFcnJvciBjcWUgb24gY3FuIDB4ODE3LCBjaSAweDgsIHFuIDB4MWRiYiwgb3Bj
b2RlIDB4ZCwgc3luZHJvbWUgMHgxLCB2ZW5kb3Igc3luZHJvbWUgMHg2OAo+ICAgICAgMDAwMDAw
MDA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCj4g
ICAgICAwMDAwMDAxMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAKPiAgICAgIDAwMDAwMDIwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMAo+ICAgICAgMDAwMDAwMzA6IDAwIDAwIDAwIDAwIDYwIDEwIDY4
IDAxIDBhIDAwIDFkIGJiIDAwIDBmIDlmIGQyCj4gICAgICBXUUUgRFVNUDogV1Egc2l6ZSAxMDI0
IFdRIGN1ciBzaXplIDAsIFdRRSBpbmRleCAweGYsIGxlbjogNjQKPiAgICAgIDAwMDAwMDAwOiAw
MCAwMCAwZiAwYSAwMCAxZCBiYiAwMyAwMCAwMCAwMCAwOCAwMCAwMCAwMCAwMAo+ICAgICAgMDAw
MDAwMTA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
Cj4gICAgICAwMDAwMDAyMDogMDAgMDAgMDAgMmIgMDAgMDggMDAgMDAgMDAgMDAgMDAgMDUgOWUg
ZTMgMDggMDAKPiAgICAgIDAwMDAwMDMwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMAo+ICAgICAgbWx4NV9jb3JlIDAwMDA6M2I6MDAuMSBldGgxOiBF
UlIgQ1FFIG9uIFNROiAweDFkYmIKPgo+IFNvIGEgcHJpdl9mbGFnIGlzIGFkZGVkIGhlcmUgdG8g
aW5kaWNhdGUgd2hldGhlciB0aGUgbmV0d29yayBjYXJkCj4gc3VwcG9ydHMgdGhpcyBmZWF0dXJl
LgoKCkkgZG9uJ3Qgc2VlIE1lbGxhbm94IGVuZ2luZWVycyBhcmUgY29waWVkLiBJIHdvbmRlciBp
ZiB3ZSBuZWVkIHRoZWlyIApjb25maXJtYXRpb24gb24gd2hldGhlciBpdCdzIGEgYnVnIG9yIGhh
cmR3YXJlIGxpbWl0YXRpb24uCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
