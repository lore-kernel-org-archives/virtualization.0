Return-Path: <SRS0=2EET=LR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDF4C4743C
	for <virtualization@archiver.kernel.org>; Wed, 23 Jun 2021 04:09:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5231760C41
	for <virtualization@archiver.kernel.org>; Wed, 23 Jun 2021 04:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5231760C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCF234060C;
	Wed, 23 Jun 2021 04:09:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tdJ-hZ2qPBha; Wed, 23 Jun 2021 04:09:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5FA014060B;
	Wed, 23 Jun 2021 04:09:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FCC0C001A;
	Wed, 23 Jun 2021 04:09:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20F62C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 04:09:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EF28983BFA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 04:09:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IJtgjqxI7YCE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 04:09:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 36EBE83BF8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 04:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624421355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4f7bV9ZblohGjuj62rD0ZyIfAgNZj5xtieBA/ZY0oo0=;
 b=TfB6EKWjO6yJBxCECwwxLCh0CulsDu5Upo9ZjXstyHJ+2s+NCDCGhfNtsup5nSbaAZ6BEh
 yMw4Z4T8QrhxwJ2QOd3VXpqVIxC8xKAfF17PLSGdnhfuNra8RyA1ZhIBMtNLKXbpRgo8Nw
 YGZ9eXEeDtxYbxdK3WWlScFJH51ecE8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-6ZkWmxwCOz6dLoUwk4uLZg-1; Wed, 23 Jun 2021 00:09:13 -0400
X-MC-Unique: 6ZkWmxwCOz6dLoUwk4uLZg-1
Received: by mail-pj1-f72.google.com with SMTP id
 h8-20020a17090ac388b029016f602f0758so3067120pjt.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 21:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=4f7bV9ZblohGjuj62rD0ZyIfAgNZj5xtieBA/ZY0oo0=;
 b=inqD9tyX1GW2MEUP2Wt3HiqQxMCBruLl6wQel+TyifUZtJaOAJwpeINUtIP4IvJzUs
 O6coDGrDR0Gf85PjLhnD96QS7P8GlgsgPoqEHShhGjgfFJZAN4xw6GBAxjrxshmCQNZ6
 Hap70rTVnto7defxp3Wp1Ifn+Lz2+si8FopfnW+uyHJ49WDoAwqrxG411cwHsxBjvE50
 uXXkyVD2ulir0vZlDObcsYm79ADu3/AA82x5e5WbTLaUWsibA79twrVJm/M9iJcovH0R
 u/muESYdOdoPVaDORLuJ00BHB1j4pNJ7z70SD6/67oSOIMbRNpYyzTFwpAa2vAZNh2gY
 UszQ==
X-Gm-Message-State: AOAM530IECDswcRfG7LG4z27f+eX0yQgilsLH5NSry2+cgl9eljklehQ
 qAO2/nI1wrgmK6oGm6Bo6mfhG0Bein7xHfmV0amrLVxWTQEAp0gdMqdIOoHIwlSFIVJzCCOyxMW
 tHn+AK6iemlRMYy8XtDhPf+mF1zWYcTQAeY0l5Yt2ew==
X-Received: by 2002:a63:1e55:: with SMTP id p21mr1880642pgm.412.1624421352336; 
 Tue, 22 Jun 2021 21:09:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRQQN9p784Q3FD53PEDLM6yc8yZ7S1AdO/X2/Ki23C14vsX68ESgVvCMdjJsRvMtk59iCgwQ==
X-Received: by 2002:a63:1e55:: with SMTP id p21mr1880624pgm.412.1624421352125; 
 Tue, 22 Jun 2021 21:09:12 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b3sm3928037pjz.49.2021.06.22.21.09.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jun 2021 21:09:11 -0700 (PDT)
Subject: Re: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
To: Parav Pandit <parav@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210616191155.102303-3-parav@nvidia.com>
 <aa7899c0-4b6b-dee3-a175-91e0394bc999@redhat.com>
 <PH0PR12MB5481AE651E0E9BFA6A1839EEDC099@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0434617e-f960-eb1a-a682-49b6a754413f@redhat.com>
Date: Wed, 23 Jun 2021 12:08:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481AE651E0E9BFA6A1839EEDC099@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>
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

CuWcqCAyMDIxLzYvMjIg5LiL5Y2IMTA6MDMsIFBhcmF2IFBhbmRpdCDlhpnpgZM6Cj4+IElzIGl0
IGJldHRlciB0byB1c2UgYSBzZXBhcmF0ZSBlbnVtIGZvciBuZXQgc3BlY2lmaWMgYXR0cmlidXRl
cz8KPj4KPiBZZXMsIGJlY2F1c2UgdGhleSBhcmUgb25seSBuZXQgc3BlY2lmaWMuCj4gSSBndWVz
cyBpdCBpcyByZWxhdGVkIHRvIHlvdXIgYmVsb3cgcXVlc3Rpb24uCj4KPj4gQW5vdGhlciBxdWVz
dGlvbiAoc29ycnkgaWYgaXQgaGFzIGJlZW4gYXNrZWQgYmVmb3JlKS4gQ2FuIHdlIHNpbXBseQo+
PiByZXR1cm4gdGhlIGNvbmZpZyAoYmluYXJ5KSB0byB0aGUgdXNlcnNwYWNlLCB0aGVuIHVzZXNw
YWNlIGNhbiB1c2UgdGhlCj4+IGV4aXN0aW5nIHVBUEkgbGlrZSB2aXJ0aW9fbmV0X2NvbmZpZyBw
bHVzIHRoZSBmZWF0dXJlIHRvIGV4cGxhaW4gdGhlIGNvbmZpZz8KPj4KPiBXZSBkaWQgZGlzY3Vz
cyBpbiB2Mi4KPiBVc3VhbGx5IHJldHVybmluZyB0aGUgd2hvbGUgYmxvYiBhbmQgcGFyc2luZyBp
cyBub3QgZGVzaXJlZCB2aWEgbmV0bGluay4KPiBSZXR1cm5pbmcgaW5kaXZpZHVhbCBmaWVsZHMg
Z2l2ZSB0aGUgZnVsbCBmbGV4aWJpbGl0eSB0byByZXR1cm4gb25seSB0aGUgdmFsaWQgZmllbGRz
Lgo+IE90aGVyd2lzZSB3ZSBuZWVkIHRvIGltcGxlbWVudCBhbm90aGVyIGJpdG1hc2sgdG9vIHRv
IHRlbGwgd2hpY2ggZmllbGRzIGZyb20gdGhlIHN0cnVjdCBhcmUgdmFsaWQgYW5kIHNoYXJlIHdp
dGggdXNlciBzcGFjZS4KPiBSZXR1cm5pbmcgaW5kaXZpZHVhbCBmaWVsZHMgaXMgdGhlIHdpZGVs
eSB1c2VkIGFwcHJvYWNoLgoKClRoZSBtYWluIGNvbmNlcm5zIGFyZToKCjEpIFRoZSBibG9iIHdp
bGwgYmUgc2VsZiBjb250YWluZWQgaWYgaXQgd2FzIHBhc3NlZCB3aXRoIHRoZSBuZWdvdGlhdGVk
IApmZWF0dXJlcywgc28gd2UgZG9uJ3QgbmVlZCBiaXRtYXNrLgoyKSBVc2luZyBpbmRpdmlkdWFs
IGZpZWxkcyBtZWFucyBpdCBtdXN0IGR1cGxpY2F0ZSB0aGUgY29uZmlnIGZpZWxkcyBvZiAKZXZl
cnkgdmlydGlvIGRldmljZXMKCkFuZCBhY3R1YWxseSwgaXQncyBub3QgdGhlIGJpbmFyeSBibG9i
IHNpbmNlIHVhcGkgY2xlYXJseSBkZWZpbmUgdGhlIApmb3JtYXQgKGUuZyBzdHJ1Y3QgdmlydGlv
X25ldF9jb25maWcpLCBjYW4gd2UgZmluZCBhIHdheSB0byB1c2UgdGhhdD/CoCAKRS5nIGludHJv
ZHVjZSBkZXZpY2UvbmV0IHNwZWNpZmljIGNvbW1hbmQgYW5kIHBhc3NpbmcgdGhlIGJsb2Igd2l0
aCAKbGVuZ3RoIGFuZCBuZWdvdGlhdGVkIGZlYXR1cmVzLgoKVGhhbmtzCgoKPgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
