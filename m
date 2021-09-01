Return-Path: <SRS0=XZyc=NX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47E3C432BE
	for <virtualization@archiver.kernel.org>; Wed,  1 Sep 2021 02:52:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E0260F90
	for <virtualization@archiver.kernel.org>; Wed,  1 Sep 2021 02:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 85E0260F90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BA064031D;
	Wed,  1 Sep 2021 02:52:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4gdPr3-57Zvn; Wed,  1 Sep 2021 02:52:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EBA2F403FD;
	Wed,  1 Sep 2021 02:52:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3F4BC001A;
	Wed,  1 Sep 2021 02:52:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8038FC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 02:52:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6F90660664
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 02:52:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y3P8m-dYV222
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 02:52:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF522606D4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 02:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630464723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=22daRUQV9U4yr6Wt0e3afK9IF5RqMvZ3yQMarWKzKaw=;
 b=JxkWfQ7EGfdRby2Hd9j56rPsXil9S4cm2C3FAZXX5OO7cUDSxFTYinqBbb3iSpD6TdXSJT
 6PrikPnEDTcBMAOb1V26OPOx1bsNDR+/Rg4qYR1bHBBiYO3xsUrVrBd9lpGTuUWxbipX6o
 bPgZ3hpHWHlyTA3A+VvZuKPecQT/dm4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-wuTeYTlcPturVj9360xOlA-1; Tue, 31 Aug 2021 22:52:02 -0400
X-MC-Unique: wuTeYTlcPturVj9360xOlA-1
Received: by mail-pf1-f197.google.com with SMTP id
 a24-20020a62e218000000b003fdd5bdf6baso662847pfi.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 19:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=22daRUQV9U4yr6Wt0e3afK9IF5RqMvZ3yQMarWKzKaw=;
 b=UxO9KCK1dUBzIiBaRO4SS2lAUDvehNJay5bfYjnEKRPMBOGtVUehOl2Wggrfh1PUT9
 Y6kQzm2QyWWwVzdxsKdSQe6+c83GC2dIYysHoVc6zvesaq+L+wVWK0zr7kJOUq/PG9i1
 4R/CYPgwfUlZ+8Xwu5bOKvz0LHGHp1tchJ3i6tZrDNNc7wN24+SD4gnCND6FwsTrSfR5
 Wn+qcrp0swrjCdntx9VtCDnb3IMAaelv/W6NQZyePwDIKqXXlYezxAAVV9vcxFxFvcI8
 69V31cHnmtdsl+JNOF3IGBewbvzxcuUAoKn2b8QUQKB49tfxVzubzRFeOKzFD71SO+ec
 1tOg==
X-Gm-Message-State: AOAM532bxtpVxaZwUymDf+Bcj6IjF7EkF5aFu1kbU4tKO1gW5F9xTqMF
 cWx4yHwMbMsPvn4CZ/4IIrbY0MdzflKSR2ATAE6xNxuTxfHDHdcUE5/O2N2NSBv/t6B3ZWHskKq
 7bKyiDE6rPh89FbMAHD+dGECiuOTVClYjT4yqUUKp1g==
X-Received: by 2002:a17:902:ea89:b0:134:7eb7:b4d7 with SMTP id
 x9-20020a170902ea8900b001347eb7b4d7mr7633976plb.43.1630464721016; 
 Tue, 31 Aug 2021 19:52:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTWS6gU6vtbRqrdbv/Yqpra3725hn41k3JbwUi9Z5AqTrEe2L3d1WI2eNmIrtm6tnQdkeYWQ==
X-Received: by 2002:a17:902:ea89:b0:134:7eb7:b4d7 with SMTP id
 x9-20020a170902ea8900b001347eb7b4d7mr7633932plb.43.1630464720692; 
 Tue, 31 Aug 2021 19:52:00 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b7sm19703920pgs.64.2021.08.31.19.51.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Aug 2021 19:51:59 -0700 (PDT)
Subject: Re: [PATCH v13 02/13] eventfd: Export eventfd_wake_count to modules
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 hch@infradead.org, christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com,
 robin.murphy@arm.com, will@kernel.org, john.garry@huawei.com
References: <20210831103634.33-1-xieyongji@bytedance.com>
 <20210831103634.33-3-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0e486c0a-0055-e698-ffd2-31c4b75dae5d@redhat.com>
Date: Wed, 1 Sep 2021 10:50:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210831103634.33-3-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 songmuchun@bytedance.com, linux-fsdevel@vger.kernel.org
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

CuWcqCAyMDIxLzgvMzEg5LiL5Y2INjozNiwgWGllIFlvbmdqaSDlhpnpgZM6Cj4gRXhwb3J0IGV2
ZW50ZmRfd2FrZV9jb3VudCBzbyB0aGF0IHNvbWUgbW9kdWxlcyBjYW4gdXNlCj4gdGhlIGV2ZW50
ZmRfc2lnbmFsX2NvdW50KCkgdG8gY2hlY2sgd2hldGhlciB0aGUKPiBldmVudGZkX3NpZ25hbCgp
IGNhbGwgc2hvdWxkIGJlIGRlZmVycmVkIHRvIGEgc2FmZSBjb250ZXh0Lgo+Cj4gU2lnbmVkLW9m
Zi1ieTogWGllIFlvbmdqaSA8eGlleW9uZ2ppQGJ5dGVkYW5jZS5jb20+CgoKQW5kIHRoaXMgbWF0
Y2hlcyB0aGUgY29tbWVudCBpbnNpZGUgZXZlbnRmZF9zaWduYWwoKToKCiDCoMKgwqDCoMKgwqDC
oCAvKgogwqDCoMKgwqDCoMKgwqDCoCAqIERlYWRsb2NrIG9yIHN0YWNrIG92ZXJmbG93IGlzc3Vl
cyBjYW4gaGFwcGVuIGlmIHdlIHJlY3Vyc2UgaGVyZQogwqDCoMKgwqDCoMKgwqDCoCAqIHRocm91
Z2ggd2FpdHF1ZXVlIHdha2V1cCBoYW5kbGVycy4gSWYgdGhlIGNhbGxlciB1c2VycyAKcG90ZW50
aWFsbHkKIMKgwqDCoMKgwqDCoMKgwqAgKiBuZXN0ZWQgd2FpdHF1ZXVlcyB3aXRoIGN1c3RvbSB3
YWtldXAgaGFuZGxlcnMsIHRoZW4gaXQgc2hvdWxkCiDCoMKgwqDCoMKgwqDCoMKgICogY2hlY2sg
ZXZlbnRmZF9zaWduYWxfY291bnQoKSBiZWZvcmUgY2FsbGluZyB0aGlzIGZ1bmN0aW9uLiBJZgog
wqDCoMKgwqDCoMKgwqDCoCAqIGl0IHJldHVybnMgdHJ1ZSwgdGhlIGV2ZW50ZmRfc2lnbmFsKCkg
Y2FsbCBzaG91bGQgYmUgCmRlZmVycmVkIHRvIGEKIMKgwqDCoMKgwqDCoMKgwqAgKiBzYWZlIGNv
bnRleHQuCiDCoMKgwqDCoMKgwqDCoMKgICovCgoKU286CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZnMvZXZlbnRmZC5jIHwgMSArCj4gICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+IGRpZmYgLS1naXQgYS9mcy9ldmVudGZk
LmMgYi9mcy9ldmVudGZkLmMKPiBpbmRleCBlMjY1YjZkZDRmMzQuLjFiMzEzMGI4ZDZjMSAxMDA2
NDQKPiAtLS0gYS9mcy9ldmVudGZkLmMKPiArKysgYi9mcy9ldmVudGZkLmMKPiBAQCAtMjYsNiAr
MjYsNyBAQAo+ICAgI2luY2x1ZGUgPGxpbnV4L3Vpby5oPgo+ICAgCj4gICBERUZJTkVfUEVSX0NQ
VShpbnQsIGV2ZW50ZmRfd2FrZV9jb3VudCk7Cj4gK0VYUE9SVF9QRVJfQ1BVX1NZTUJPTF9HUEwo
ZXZlbnRmZF93YWtlX2NvdW50KTsKPiAgIAo+ICAgc3RhdGljIERFRklORV9JREEoZXZlbnRmZF9p
ZGEpOwo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
