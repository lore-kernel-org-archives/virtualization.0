Return-Path: <SRS0=N1kl=G6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656E3C433DB
	for <virtualization@archiver.kernel.org>; Wed, 27 Jan 2021 08:57:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8E6620754
	for <virtualization@archiver.kernel.org>; Wed, 27 Jan 2021 08:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E6620754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E205C20794;
	Wed, 27 Jan 2021 08:57:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kBDfU6znWsac; Wed, 27 Jan 2021 08:57:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C51F32049C;
	Wed, 27 Jan 2021 08:57:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6FC5C0FA7;
	Wed, 27 Jan 2021 08:57:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38E51C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 08:57:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CC99987071
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 08:57:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vj9XvHUy9E4a
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 08:57:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DB3E78701A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 08:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611737855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZPgcywD0j5awyWVQ+snyVyf/6e4yZ9nFi++5lgI6S2I=;
 b=fC+l0q8tkyRLyjAdW4JReu+Fgd5zy/gJriszLUafNNh+Sg8UJLMyMGJQEEmH6vHkSg6EPJ
 tKP+T6lTfi/do7o95gr+4h1AzjBMhZaAvl2akPYtRGsduKxsnjkoT4iEWxCGFhQW+agR9D
 3n4LHfC0W7smAgy2pRh3m+xl9yDJhUQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-jC48-JDkMVuFVEL96Huq3w-1; Wed, 27 Jan 2021 03:57:33 -0500
X-MC-Unique: jC48-JDkMVuFVEL96Huq3w-1
Received: by mail-wm1-f71.google.com with SMTP id l21so559645wmj.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 00:57:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ZPgcywD0j5awyWVQ+snyVyf/6e4yZ9nFi++5lgI6S2I=;
 b=CjLaqH8jFtXjliXpI/gATnbDmPnfwjXhj6Vhrcilaw+Z7m+N2LgCVUKfFmSvD0QZzL
 vlD4CaDAdT0N99HdULkOikaccbmj3D7XEPX8afxWVymFkmpttAmVShMB4sFs/IVPWvwZ
 Ni7n6yAmZXD9zXrAJ+CWBQebmt1MW65sp2IR5PwsChe7u6eZ1Xn3CWCe0Ryhbcfd4p55
 kf1XotlE8nNBW+epriIJD0xJig2YYz+j/o/r1HyDE86tCPE/K0jcS+t61SxefgJr9fTQ
 PiNr6eD0PXT2s3f76FeHYjPcAjMYpqCqgnTq39SCuUEa04gtaWAxBug6VUIzYvzXBKKY
 AFhw==
X-Gm-Message-State: AOAM531kEo5TPoIAq0XyT0E/o713Kc4J+qlLgaIGArcmquguJBoHSabV
 verME6ShNMojZzsJUtlQohM4ksW24PK7BP7D50CzRaWq97X0kaU4hTSIC+bEOGIbeAPUwuMULIP
 5QV/RTJaBwzxpaFfttdQtQSnWmGERiRJDONe/yhdiEQ==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr3232756wmh.47.1611737852672; 
 Wed, 27 Jan 2021 00:57:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwW8VjlyEjOrzyTn/DAveR4W/k8WYqN3LUc8WsqpWp1qpUrs5jsivjNxY6wkqg60gGYjfDUZg==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr3232732wmh.47.1611737852463; 
 Wed, 27 Jan 2021 00:57:32 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id d2sm2259357wre.39.2021.01.27.00.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Jan 2021 00:57:31 -0800 (PST)
Date: Wed, 27 Jan 2021 09:57:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC v3 03/11] vdpa: Remove the restriction that only supports
 virtio-net devices
Message-ID: <20210127085728.j6x5yzrldp2wp55c@steredhat>
References: <20210119045920.447-1-xieyongji@bytedance.com>
 <20210119045920.447-4-xieyongji@bytedance.com>
 <310d7793-e4ff-fba3-f358-418cb64c7988@redhat.com>
 <20210120110832.oijcmywq7pf7psg3@steredhat>
 <1979cffc-240e-a9f9-b0ab-84a1f82ac81e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1979cffc-240e-a9f9-b0ab-84a1f82ac81e@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, corbet@lwn.net, kvm@vger.kernel.org, mst@redhat.com,
 linux-aio@kvack.org, netdev@vger.kernel.org, rdunlap@infradead.org,
 willy@infradead.org, virtualization@lists.linux-foundation.org,
 hch@infradead.org, Xie Yongji <xieyongji@bytedance.com>, bob.liu@oracle.com,
 bcrl@kvack.org, viro@zeniv.linux.org.uk, stefanha@redhat.com,
 linux-fsdevel@vger.kernel.org
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

T24gV2VkLCBKYW4gMjcsIDIwMjEgYXQgMTE6MzM6MDNBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMS8xLzIwIOS4i+WNiDc6MDgsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToK
Pj5PbiBXZWQsIEphbiAyMCwgMjAyMSBhdCAxMTo0NjozOEFNICswODAwLCBKYXNvbiBXYW5nIHdy
b3RlOgo+Pj4KPj4+T24gMjAyMS8xLzE5IOS4i+WNiDEyOjU5LCBYaWUgWW9uZ2ppIHdyb3RlOgo+
Pj4+V2l0aCBWRFVTRSwgd2Ugc2hvdWxkIGJlIGFibGUgdG8gc3VwcG9ydCBhbGwga2luZHMgb2Yg
dmlydGlvIGRldmljZXMuCj4+Pj4KPj4+PlNpZ25lZC1vZmYtYnk6IFhpZSBZb25namkgPHhpZXlv
bmdqaUBieXRlZGFuY2UuY29tPgo+Pj4+LS0tCj4+Pj7CoGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwg
MjkgKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4+PsKgMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pCj4+Pj4KPj4+PmRpZmYgLS1naXQgYS9kcml2
ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+Pj5pbmRleCAyOWVkNDE3
M2YwNGUuLjQ0OGJlNzg3NWI2ZCAxMDA2NDQKPj4+Pi0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5j
Cj4+Pj4rKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4+QEAgLTIyLDYgKzIyLDcgQEAKPj4+
PsKgI2luY2x1ZGUgPGxpbnV4L25vc3BlYy5oPgo+Pj4+wqAjaW5jbHVkZSA8bGludXgvdmhvc3Qu
aD4KPj4+PsKgI2luY2x1ZGUgPGxpbnV4L3ZpcnRpb19uZXQuaD4KPj4+PisjaW5jbHVkZSA8bGlu
dXgvdmlydGlvX2Jsay5oPgo+Pj4+wqAjaW5jbHVkZSAidmhvc3QuaCIKPj4+PkBAIC0xODUsMjYg
KzE4Niw2IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfc2V0X3N0YXR1cyhzdHJ1Y3QgCj4+Pj52
aG9zdF92ZHBhICp2LCB1OCBfX3VzZXIgKnN0YXR1c3ApCj4+Pj7CoMKgwqDCoCByZXR1cm4gMDsK
Pj4+PsKgfQo+Pj4+LXN0YXRpYyBpbnQgdmhvc3RfdmRwYV9jb25maWdfdmFsaWRhdGUoc3RydWN0
IHZob3N0X3ZkcGEgKnYsCj4+Pj4twqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHN0cnVjdCB2aG9zdF92ZHBhX2NvbmZpZyAqYykKPj4+Pi17Cj4+Pj4twqDCoMKgIGxv
bmcgc2l6ZSA9IDA7Cj4+Pj4tCj4+Pj4twqDCoMKgIHN3aXRjaCAodi0+dmlydGlvX2lkKSB7Cj4+
Pj4twqDCoMKgIGNhc2UgVklSVElPX0lEX05FVDoKPj4+Pi3CoMKgwqDCoMKgwqDCoCBzaXplID0g
c2l6ZW9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyk7Cj4+Pj4twqDCoMKgwqDCoMKgwqAgYnJl
YWs7Cj4+Pj4twqDCoMKgIH0KPj4+Pi0KPj4+Pi3CoMKgwqAgaWYgKGMtPmxlbiA9PSAwKQo+Pj4+
LcKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+Pj4+LQo+Pj4+LcKgwqDCoCBpZiAoYy0+
bGVuID4gc2l6ZSAtIGMtPm9mZikKPj4+Pi3CoMKgwqDCoMKgwqDCoCByZXR1cm4gLUUyQklHOwo+
Pj4+LQo+Pj4+LcKgwqDCoCByZXR1cm4gMDsKPj4+Pi19Cj4+Pgo+Pj4KPj4+SSB0aGluayB3ZSBz
aG91bGQgdXNlIGEgc2VwYXJhdGUgcGF0Y2ggZm9yIHRoaXMuCj4+Cj4+Rm9yIHRoZSB2ZHBhLWJs
ayBzaW11bGF0b3IgSSBoYWQgdGhlIHNhbWUgaXNzdWVzIGFuZCBJJ20gYWRkaW5nIGEgCj4+Lmdl
dF9jb25maWdfc2l6ZSgpIGNhbGxiYWNrIHRvIHZkcGEgZGV2aWNlcy4KPj4KPj5EbyB5b3UgdGhp
bmsgbWFrZSBzZW5zZSBvciBpcyBiZXR0ZXIgdG8gcmVtb3ZlIHRoaXMgY2hlY2sgaW4gCj4+dmhv
c3QvdmRwYSwgZGVsZWdhdGluZyB0aGUgYm91bmRhcmllcyBjaGVja3MgdG8gCj4+Z2V0X2NvbmZp
Zy9zZXRfY29uZmlnIGNhbGxiYWNrcy4KPgo+Cj5BIHF1ZXN0aW9uIGhlcmUuIEhvdyBtdWNoIHZh
bHVlIGNvdWxkIHdlIGdhaW4gZnJvbSBnZXRfY29uZmlnX3NpemUoKSAKPmNvbnNpZGVyIHdlIGNh
biBsZXQgdkRQQSBwYXJlbnQgdG8gdmFsaWRhdGUgdGhlIGxlbmd0aCBpbiBpdHMgCj5nZXRfY29u
ZmlnKCkuCj4KCkkgYWdyZWUsIG1vc3Qgb2YgdGhlIGltcGxlbWVudGF0aW9ucyBhbHJlYWR5IHZh
bGlkYXRlIHRoZSBsZW5ndGgsIHRoZSAKb25seSBnYWluIGlzIGFuIGVycm9yIHJldHVybmVkIHNp
bmNlIGdldF9jb25maWcoKSBpcyB2b2lkLCBidXQgCmV2ZW50dWFsbHkgd2UgY2FuIGFkZCBhIHJl
dHVybiB2YWx1ZSB0byBpdC4KClRoYW5rcywKU3RlZmFubwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
