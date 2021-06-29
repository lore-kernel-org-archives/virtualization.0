Return-Path: <SRS0=tbjA=LX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CC3C11F68
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 04:03:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D7B61D52
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 04:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D7B61D52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B6772403A7;
	Tue, 29 Jun 2021 04:03:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jvttoEtbHSog; Tue, 29 Jun 2021 04:03:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0140F403B1;
	Tue, 29 Jun 2021 04:03:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B041C0010;
	Tue, 29 Jun 2021 04:03:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60B94C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 04:03:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4D76F60820
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 04:03:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gP30hJHQIWlH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 04:03:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A9856081D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 04:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624939421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v+g48Xk6aSFcuGIkt+/DaIL+8u6+RW2FB0ohInQkXMo=;
 b=HakUBONhNHm6IC+59YeTj095UOc7S7n+V53lzuwQVxEN7MVQlnuV/bHUT3a53z4oa65k2n
 rZkY6Kaeb5ucQGLq7xELr0ZDB6TVeGGhCoMW/RyA7NCuPvO2KRz57FR+785SyVT1+7JZ9a
 SaC4Hpvv3e9IaiTLkGVXuQPJ07UjWnk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-2vJ60o4VMQmAKBUzxy1JuA-1; Tue, 29 Jun 2021 00:03:39 -0400
X-MC-Unique: 2vJ60o4VMQmAKBUzxy1JuA-1
Received: by mail-pl1-f197.google.com with SMTP id
 g16-20020a1709028690b029011e9e164a59so6682795plo.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 21:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=v+g48Xk6aSFcuGIkt+/DaIL+8u6+RW2FB0ohInQkXMo=;
 b=NVnPfGj7Vxhv2ftUUprQzlc1byulZZZAR2q93a8CKGi75ZAOpgu/JeUCcYr9MMWoUY
 QwLS/kFdSGy+ePhoTJagneS3xGtGKYCSdNJKQZquftyqU2HFxOYd2PDRS1IHkf4rwb4h
 YIWI/eySthO3bFynPJf5ENiyJyT5uTeql9dmYbnyEg3PGwCD72dDknZXRBL5JBs6LEp3
 5AW5hDrZ4fAEpoMCjPBNe6Q/AWuVhjkYbaCFpLZBT/FDYfYWtnRRtxRQ1rkadMQ4hPa8
 2s2vH+oVUz+7RRGZ6I73h2dFop+XZdGSLLAFG02Pe2CasyPE+D6rTRHoOImg/FELnBN+
 rJMQ==
X-Gm-Message-State: AOAM533C/oZOa9GZlQ3BxsqlCPXwTWI7CGO79b3fTWmv+hixInA7VIfl
 o5n6JrTE7lxnsV/6X0ohtK9g4JvZGrGAcAQGLgMdizaOkgpDsfs7blIxKwKuPKGnRc0bOKfOquK
 DkBxOMGcasXNVNTpOXJsbBqUq8TFGtYTOjuDGhQYTow==
X-Received: by 2002:a17:90a:3d47:: with SMTP id
 o7mr41873352pjf.68.1624939418457; 
 Mon, 28 Jun 2021 21:03:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKtTxOUZyWPHTglSm78/VChBvM+Z/ZClGizEzsTPbjS/HVYSHDloQPPNl7gVZByIo2yALsfw==
X-Received: by 2002:a17:90a:3d47:: with SMTP id
 o7mr41873326pjf.68.1624939418245; 
 Mon, 28 Jun 2021 21:03:38 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id e2sm16252405pgh.5.2021.06.28.21.03.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jun 2021 21:03:37 -0700 (PDT)
Subject: Re: [PATCH v8 09/10] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <CACycT3uzMJS7vw6MVMOgY4rb=SPfT2srV+8DPdwUVeELEiJgbA@mail.gmail.com>
 <0aeb7cb7-58e5-1a95-d830-68edd7e8ec2e@redhat.com>
 <CACycT3uuooKLNnpPHewGZ=q46Fap2P4XCFirdxxn=FxK+X1ECg@mail.gmail.com>
 <e4cdee72-b6b4-d055-9aac-3beae0e5e3e1@redhat.com>
 <CACycT3u8=_D3hCtJR+d5BgeUQMce6S7c_6P3CVfvWfYhCQeXFA@mail.gmail.com>
 <d2334f66-907c-2e9c-ea4f-f912008e9be8@redhat.com>
 <CACycT3uCSLUDVpQHdrmuxSuoBDg-4n22t+N-Jm2GoNNp9JYB2w@mail.gmail.com>
 <48cab125-093b-2299-ff9c-3de8c7c5ed3d@redhat.com>
 <CACycT3tS=10kcUCNGYm=dUZsK+vrHzDvB3FSwAzuJCu3t+QuUQ@mail.gmail.com>
 <b10b3916-74d4-3171-db92-be0afb479a1c@redhat.com>
 <CACycT3vpMFbc9Fzuo9oksMaA-pVb1dEVTEgjNoft16voryPSWQ@mail.gmail.com>
 <d7e42109-0ba6-3e1a-c42a-898b6f33c089@redhat.com>
 <CACycT3u9-id2DxPpuVLtyg4tzrUF9xCAGr7nBm=21HfUJJasaQ@mail.gmail.com>
 <e82766ff-dc6b-2cbb-3504-0ef618d538e2@redhat.com>
 <CACycT3ucVz3D4Tcr1C6uzWyApZy7Xk4o17VH2gvLO3w1Ra+skg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d30e391f-a900-5182-f732-e7c0089b7cbd@redhat.com>
Date: Tue, 29 Jun 2021 12:03:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACycT3ucVz3D4Tcr1C6uzWyApZy7Xk4o17VH2gvLO3w1Ra+skg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, joro@8bytes.org,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>, songmuchun@bytedance.com,
 Jens Axboe <axboe@kernel.dk>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
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

CuWcqCAyMDIxLzYvMjkg5LiK5Y2IMTE6NTYsIFlvbmdqaSBYaWUg5YaZ6YGTOgo+IE9uIFR1ZSwg
SnVuIDI5LCAyMDIxIGF0IDExOjI5IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
IHdyb3RlOgo+Pgo+PiDlnKggMjAyMS82LzI5IOS4iuWNiDEwOjI2LCBZb25namkgWGllIOWGmemB
kzoKPj4+IE9uIE1vbiwgSnVuIDI4LCAyMDIxIGF0IDEyOjQwIFBNIEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+IOWcqCAyMDIxLzYvMjUg5LiL5Y2IMTI6MTksIFlv
bmdqaSBYaWUg5YaZ6YGTOgo+Pj4+Pj4gMmIpIGZvciBzZXRfc3RhdHVzKCk6IHNpbXBseSByZWxh
eSB0aGUgbWVzc2FnZSB0byB1c2Vyc3BhY2UsIHJlcGx5IGlzIG5vCj4+Pj4+PiBuZWVkZWQuIFVz
ZXJzcGFjZSB3aWxsIHVzZSBhIGNvbW1hbmQgdG8gdXBkYXRlIHRoZSBzdGF0dXMgd2hlbiB0aGUK
Pj4+Pj4+IGRhdGFwYXRoIGlzIHN0b3AuIFRoZSB0aGUgc3RhdHVzIGNvdWxkIGJlIGZldGNoZWQg
dmlhIGdldF9zdGF0cygpLgo+Pj4+Pj4KPj4+Pj4+IDJiIGxvb2tzIG1vcmUgc3BlYyBjb21wbGFp
bnQuCj4+Pj4+Pgo+Pj4+PiBMb29rcyBnb29kIHRvIG1lLiBBbmQgSSB0aGluayB3ZSBjYW4gdXNl
IHRoZSByZXBseSBvZiB0aGUgbWVzc2FnZSB0bwo+Pj4+PiB1cGRhdGUgdGhlIHN0YXR1cyBpbnN0
ZWFkIG9mIGludHJvZHVjaW5nIGEgbmV3IGNvbW1hbmQuCj4+Pj4+Cj4+Pj4gSnVzdCBub3RpY2Ug
dGhpcyBwYXJ0IGluIHZpcnRpb19maW5hbGl6ZV9mZWF0dXJlcygpOgo+Pj4+Cj4+Pj4gICAgICAg
ICAgICB2aXJ0aW9fYWRkX3N0YXR1cyhkZXYsIFZJUlRJT19DT05GSUdfU19GRUFUVVJFU19PSyk7
Cj4+Pj4gICAgICAgICAgICBzdGF0dXMgPSBkZXYtPmNvbmZpZy0+Z2V0X3N0YXR1cyhkZXYpOwo+
Pj4+ICAgICAgICAgICAgaWYgKCEoc3RhdHVzICYgVklSVElPX0NPTkZJR19TX0ZFQVRVUkVTX09L
KSkgewo+Pj4+Cj4+Pj4gU28gd2Ugbm8gcmVwbHkgZG9lc24ndCB3b3JrIGZvciBGRUFUVVJFU19P
Sy4KPj4+Pgo+Pj4+IFNvIG15IHVuZGVyc3RhbmRpbmcgaXM6Cj4+Pj4KPj4+PiAxKSBXZSBtdXN0
IG5vdCB1c2Ugbm9yZXBseSBmb3Igc2V0X3N0YXR1cygpCj4+Pj4gMikgV2UgY2FuIHVzZSBub3Jl
cGx5IGZvciBnZXRfc3RhdHVzKCksIGJ1dCBpdCByZXF1aXJlcyBhIG5ldyBpb2N0bCB0bwo+Pj4+
IHVwZGF0ZSB0aGUgc3RhdHVzLgo+Pj4+Cj4+Pj4gU28gaXQgbG9va3MgdG8gbWUgd2UgbmVlZCBz
eW5jaHJvbml6ZSBmb3IgYm90aCBnZXRfc3RhdHVzKCkgYW5kCj4+Pj4gc2V0X3N0YXR1cygpLgo+
Pj4+Cj4+PiBXZSBzaG91bGQgbm90IHNlbmQgbWVzc2FnZXMgdG8gdXNlcnNwYWNlIGluIHRoZSBG
RUFUVVJFU19PSyBjYXNlLiBTbwo+Pj4gdGhlIHN5bmNocm9uaXphdGlvbiBpcyBub3QgbmVjZXNz
YXJ5Lgo+Pgo+PiBBcyBkaXNjdXNzZWQgcHJldmlvdXNseSwgdGhlcmUgY291bGQgYmUgYSBkZXZp
Y2UgdGhhdCBtYW5kYXRlcyBzb21lCj4+IGZlYXR1cmVzIChWSVJUSU9fRl9SSU5HX1BBQ0tFRCku
IFNvIGl0IGNhbiBjaG9vc2UgdG8gbm90IGFjY2VwdAo+PiBGRUFUVVJFU19PSyBpcyBwYWNrZWQg
dmlydHF1ZXVlIGlzIG5vdCBuZWdvdGlhdGVkLgo+Pgo+PiBJbiB0aGlzIGNhc2Ugd2UgbmVlZCB0
byByZWxheSB0aGUgbWVzc2FnZSB0byB1c2Vyc3BhY2UuCj4+Cj4gT0ssIEkgc2VlLiBJZiBzbywg
SSBwcmVmZXIgdG8gb25seSB1c2Ugbm9yZXBseSBmb3Igc2V0X3N0YXR1cygpLiBXZSBkbwo+IG5v
dCBzZXQgdGhlIHN0YXR1cyBiaXQgaWYgdGhlIG1lc3NhZ2UgaXMgZmFpbGVkLiBJbiB0aGlzIHdh
eSwgd2UgZG9uJ3QKPiBuZWVkIHRvIGNoYW5nZSBsb3RzIG9mIHZpcnRpbyBjb3JlIGNvZGVzIHRv
IGhhbmRsZSB0aGUgZmFpbHVyZSBvZgo+IHNldF9zdGF0dXMoKS9nZXRfc3RhdHVzKCkuCgoKSXQg
c2hvdWxkIHdvcmsuCgpUaGFua3MKCgo+Cj4gVGhhbmtzLAo+IFlvbmdqaQo+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
