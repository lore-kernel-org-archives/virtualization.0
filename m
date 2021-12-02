Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761DDC433F5
	for <virtualization@archiver.kernel.org>; Thu,  2 Dec 2021 03:40:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 09366400DE;
	Thu,  2 Dec 2021 03:40:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bIKMlCr7HlKJ; Thu,  2 Dec 2021 03:40:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6663F4039C;
	Thu,  2 Dec 2021 03:40:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A9D3C0012;
	Thu,  2 Dec 2021 03:40:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75EF3C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 03:40:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 61B7F403BD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 03:40:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PU-_e6po-Y2y
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 03:40:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6EF62400DE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 03:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638416448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oz99foPyey/M5tlxh3J0U4HF1mRmEiyqetVNL8Yc2zA=;
 b=Oo7v6bsL+fq8r0nkPvnSnE0xxmhhvIaIh5LSrVxXwjVUrRqbLMQou/2D13KjqHDTNCKYYr
 eOoUGnYax6msq/zpwHgUYaSvLkdJUMQIw7DgXea/dB4onEVSq7VpHWNHGkoJEg4kTE2pbp
 5INs6jQI3qszyDEcdiRQQDcUUCVllRM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-yoyz4L0WNZqU-4VISMuHvg-1; Wed, 01 Dec 2021 22:40:46 -0500
X-MC-Unique: yoyz4L0WNZqU-4VISMuHvg-1
Received: by mail-pl1-f198.google.com with SMTP id
 4-20020a170902c20400b0014381f710d5so11207886pll.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Dec 2021 19:40:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=oz99foPyey/M5tlxh3J0U4HF1mRmEiyqetVNL8Yc2zA=;
 b=roiUcCTJIWiHOR1eKiD8tc4aXnTSnKWrJuP06M0M7DQ7ELFNcC2O8kkR7xH60aGk9G
 K/ncO7irlyIF6ep6br4yZNiqAb45a7DqSTlgsOcMBzx2z+qJ4Wg5LpHGp1lKeI0PmJU2
 W64r6lRhDn1xm2W+yeVS8A7Ye/lm33an3iUTIbkTqYGUnUKxFd/kYcyz0c3JbnI/BnTt
 itUc1K6Q1wA/8sQubUG7kRfQhqmKTJGs0kKmrlyLUpANvDQD0R5ZsGQn3XFExfMluFUN
 7KWPFupTY4R60Mr+LBdRCVQJYylnj0ozIZUhU6ETpMvmI/IMM1xmKu/9MomIc0jxJphd
 pjKA==
X-Gm-Message-State: AOAM532OXBq30sFPXDIpNVmgD7/WMfCu61CTViuK+uwqyUZndSuT+RoV
 QaTdgHvbEp4HWc1g9zoNUDe7pDXov0/xWh2wT1xSMeFXHNiWN7XMuvJuap8c+V/mhOcsN2nXMUx
 hgxcCSrrzSvaW5wCR6oHaf5Ci8kNk4ILEDsWk6VSPiw==
X-Received: by 2002:a17:90b:4ad1:: with SMTP id
 mh17mr2948194pjb.33.1638416445836; 
 Wed, 01 Dec 2021 19:40:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx8HBrCaqdWsqhC3tHwpcY7mZPCH8Oc6fpl404kX2DFiMYiS669TtzMMDfoux0kO9xHd2hL3w==
X-Received: by 2002:a17:90b:4ad1:: with SMTP id
 mh17mr2948165pjb.33.1638416445612; 
 Wed, 01 Dec 2021 19:40:45 -0800 (PST)
Received: from [10.72.13.235] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id ms15sm695815pjb.26.2021.12.01.19.40.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Dec 2021 19:40:45 -0800 (PST)
Message-ID: <1b588960-dd30-3a22-2793-846d55ff5d56@redhat.com>
Date: Thu, 2 Dec 2021 11:40:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 1/2] vdpa: Allow to configure max data virtqueues
To: Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
 Si-Wei Liu <si-wei.liu@oracle.com>
References: <20211130094838.15489-1-elic@nvidia.com>
 <20211130094838.15489-2-elic@nvidia.com>
 <ab454062-da69-a72e-1953-716257bb464c@oracle.com>
 <20211201100307.GA239524@mtl-vdi-166.wap.labs.mlnx>
 <DM8PR12MB54808D3B8AE095A6EF145E36DC689@DM8PR12MB5480.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <DM8PR12MB54808D3B8AE095A6EF145E36DC689@DM8PR12MB5480.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "mst@redhat.com" <mst@redhat.com>
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

CuWcqCAyMDIxLzEyLzEg5LiL5Y2INjowOSwgUGFyYXYgUGFuZGl0IOWGmemBkzoKPgo+PiBGcm9t
OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPj4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJl
ciAxLCAyMDIxIDM6MzMgUE0KPj4KPj4gT24gVHVlLCBOb3YgMzAsIDIwMjEgYXQgMDU6MjQ6MDNQ
TSAtMDgwMCwgU2ktV2VpIExpdSB3cm90ZToKPj4+Cj4+PiBPbiAxMS8zMC8yMDIxIDE6NDggQU0s
IEVsaSBDb2hlbiB3cm90ZToKPj4+PiBBbGxvdyB0byBjb25maWd1cmUgdGhlIG1heCB2aXJ0cXVl
dWVzIGZvciBhIGRldmljZS4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxp
Y0BudmlkaWEuY29tPgo+Pj4+IC0tLQo+Pj4+ICAgIGRyaXZlcnMvdmRwYS92ZHBhLmMgIHwgMTYg
KysrKysrKysrKysrKysrLQo+Pj4+ICAgIGluY2x1ZGUvbGludXgvdmRwYS5oIHwgIDEgKwo+Pj4+
ICAgIDIgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4+
Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhLmMgYi9kcml2ZXJzL3ZkcGEvdmRw
YS5jIGluZGV4Cj4+Pj4gNzMzMmE3NGE0YjAwLi5lMTg1ZWMyZWU4NTEgMTAwNjQ0Cj4+Pj4gLS0t
IGEvZHJpdmVycy92ZHBhL3ZkcGEuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMKPj4+
PiBAQCAtNDgwLDcgKzQ4MCw4IEBAIHZkcGFfbmxfY21kX21nbXRkZXZfZ2V0X2R1bXBpdChzdHJ1
Y3Qgc2tfYnVmZgo+PiAqbXNnLCBzdHJ1Y3QgbmV0bGlua19jYWxsYmFjayAqY2IpCj4+Pj4gICAg
fQo+Pj4+ICAgICNkZWZpbmUgVkRQQV9ERVZfTkVUX0FUVFJTX01BU0sgKCgxIDw8Cj4+IFZEUEFf
QVRUUl9ERVZfTkVUX0NGR19NQUNBRERSKSB8IFwKPj4+PiAtCQkJCSAoMSA8PCBWRFBBX0FUVFJf
REVWX05FVF9DRkdfTVRVKSkKPj4+PiArCQkJCSAoMSA8PCBWRFBBX0FUVFJfREVWX05FVF9DRkdf
TVRVKSB8IFwKPj4+PiArCQkJCSAoMSA8PCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFYX1ZRUCkp
Cj4+PiBJdCBzZWVtcyBWRFBBX0FUVFJfREVWX01BWF9WUVMgKHUzMikgaXMgd2hhdCB5b3Ugd2Fu
dCAoIyBvZiBkYXRhCj4+PiB2aXJ0cXVldWVzIGluc3RlYWQgb2YgIyBvZiBkYXRhIHZpcnRxdWV1
ZSBwYWlycyk/IE5vdCBzdXJlIHdoYXQncwo+Pj4gcG9zc2libGUgdXNlIG9mIFZEUEFfQVRUUl9E
RVZfTkVUX0NGR19NQVhfVlFQLCB3YXMgaXQgdG8KPj4gZHVtcC9kaXNwbGF5Cj4+PiB0aGUgY29u
ZmlnIHNwYWNlIG1heF92aXJ0cXVldWVfcGFpcnMgdmFsdWUgKHUxNiwgMS0zMjc2OCkgZm9yCj4+
PiB2aXJ0aW8tbmV0PyBXaHkgdGhlcmUncyBzdWNoIHF1YXNpLWR1cGxpY2F0ZSBhdHRyaWJ1dGUg
aW50cm9kdWNlZCBpbiB0aGUgZmlyc3QKPj4gcGxhY2U/Cj4+IFZEUEFfQVRUUl9ERVZfTUFYX1ZR
UyBjdXJyZW50bHkgcmV0dXJucyB2ZGV2LT5udnFzIHdoaWNoIGVxdWFscwo+PiB3aGF0ZXZlciBw
YXNzZWQgdG8gX3ZkcGFfcmVnaXN0ZXJfZGV2aWNlKCkuIFRoZSBsYXR0ZXIgZGVwZW5kcyBvbiB0
aGUgdmFsdWUKPj4gcHJvdmlkZWQgYnkgKHN0cnVjdCB2ZHBhX2Rldl9zZXRfY29uZmlnKS5tYXhf
dmlydHF1ZXVlcy4KPj4KPiBNYXggVlFzIGNvbmZpZ3VyYXRpb24gc2hvdWxkIHJldXNlIFZEUEFf
QVRUUl9ERVZfTUFYX1ZRUy4KPiBpdCBpbmRpY2F0ZXMgd2hhdCBpcyB0aGUgbWF4IHZxcyBhIGdp
dmVuIHZkcGEgZGV2aWNlIGlzIHVzaW5nLiBVbnRpbCBub3cgaXQgd2FzIGRyaXZlcidzIGNob2lj
ZSwgbm93IGl0cyB1c2VycyBjaG9pY2UgaWYgcHJvdmlkZWQuCj4gU28gbm8gbmVlZCBmb3IgYWRk
aXRpb25hbCBhdHRyaWJ1dGUuCgoKSSB0aGluayBhIGRldmljZSBzcGVjaWZpYyBhdHRyaWJ1dGUg
bWlnaHQgYmUgYmV0dGVyOgoKMSkgbWF4X3ZpcnRfcXVldWVfcGFpcnMgaXMgcGFydCBvZiBjb25m
aWcgc3BhY2Ugc28gaXQgc2hvdWxkIHdvcmsgYXMgbXR1IAphbmQgbWFjCgoyKSBpdCdzIG1vcmUg
Y29udmVuaWVudCBmb3IgdGhlIHVzZXIgdG8gc3BlY2lmYyBxcHMgaW5zdGVhZCBvZiBkb2luZyAK
MipOKzEgY2FsY3VsYXRpb24KClRoYW5rcwoKCj4KPj4gTWF5YmUgd2Ugc2hvdWxkIGFkZCBhdHRy
aWJ1dGVzIHRvIGFkZCBhZGl0aW9uYWwgdmlydHF1ZXVlcyBsaWtlIGNvbnRyb2wKPj4gdmlydHF1
ZXVlIGFuZCB0aGVpciBpbmRleC4gVGhleSBjb3VsZCBiZSByZXR1cm5lZCBieQo+PiB2ZHBhX2Rl
dl9uZXRfY29uZmlnX2ZpbGwoKS4KPiBZZXMuCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
