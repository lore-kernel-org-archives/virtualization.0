Return-Path: <SRS0=+NJr=LY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68840C11F65
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 03:47:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C66161D1B
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 03:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C66161D1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE67D83A6C;
	Wed, 30 Jun 2021 03:47:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KP2uGlE3kCCs; Wed, 30 Jun 2021 03:47:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 62A5483A6F;
	Wed, 30 Jun 2021 03:47:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27313C001A;
	Wed, 30 Jun 2021 03:47:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EC98C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 03:47:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 25D2383A6C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 03:47:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4AFhdvkjPNY8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 03:47:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 62D2D83A6B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 03:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625024826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bjXZkQmWiaXAkEawBIGhlMlliakQ+FXh8c9hw0iJSC4=;
 b=PLKgwlWNYfrsb+c5FEgwS843iu/EGWkYYJZJwQ3kC78HDeBJIWyFS2rtz1UhZ99OZvzWvb
 /GzCa2DwcyE2XggutoPM54xtF1Tkvj8hpKbmgiUwDk7lu7ai+UUotOSzfo986fDXxxZeej
 6nM4eRWFPWHEPhojCbpsOztJbvCdPGU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-rMMkbxnWN3ay5gGqXIzvUA-1; Tue, 29 Jun 2021 23:47:04 -0400
X-MC-Unique: rMMkbxnWN3ay5gGqXIzvUA-1
Received: by mail-pj1-f71.google.com with SMTP id
 cp14-20020a17090afb8eb029017094b4d856so454038pjb.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 20:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=bjXZkQmWiaXAkEawBIGhlMlliakQ+FXh8c9hw0iJSC4=;
 b=HxYO3ycQtZscav42B7TGmP92XkUVLvdrtM1zwr+O2ZhDyZJC7xF76HjIVLFL8lunn3
 5/EjESKq8Yim1sWMMf9XQvGwl++3FrV2qBw4gDi2GuaqtcKxyhI0T/rJ//wn2RJ373sr
 9qLq0ThfmDuEKK+ETeSWrGB73W34Bk71GGCMmVlXPLGkoiXx4LBtc3kDzCoD3UFE87sK
 2MhGDM3V7p8caKoLzmSJc3fKpSqikF7kFwHi/ZmqZkQHBVJskhvv95Rzn+gpWnvFh5ag
 3fBL+KgBBHi1++gIYix2pk1NY6lGKNcvjF5ziMKquR/4BfJ5Nql0DzIRM1peug9Xho3I
 ZAvg==
X-Gm-Message-State: AOAM532RN9j4IB7hrj4ORr3vlHkeOSGutEZe8QUa84ySqnPTXa+NXiyU
 gjq87D2VoLqRxkne9CkVsCSzG50U7NVHr2kFYTMf+VtW2vcG2QIL2H5chxE6LCctNYfiBSx6FsI
 lVO3qs8t8+VgXKu/CDdppIwytgexFZVx0FbWZ5UZSkw==
X-Received: by 2002:a65:67c9:: with SMTP id b9mr24618734pgs.264.1625024823304; 
 Tue, 29 Jun 2021 20:47:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1yRAKlzmA0fOTcvTgX+54vavWbnb61ysmwIzXO3StkyYR4FtgSNZFlwsOnAgK4sbXPRdUrw==
X-Received: by 2002:a65:67c9:: with SMTP id b9mr24618721pgs.264.1625024823111; 
 Tue, 29 Jun 2021 20:47:03 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 11sm2386887pfl.41.2021.06.29.20.47.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jun 2021 20:47:02 -0700 (PDT)
Subject: Re: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <PH0PR12MB548147BE1B95CB294785470CDC089@PH0PR12MB5481.namprd12.prod.outlook.com>
 <d361bd10-3967-8844-1457-48e7e9422fb2@redhat.com>
 <PH0PR12MB54812DD2DADAD0897E24CFA7DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4e0708fb-34e3-471d-ca98-44c75f693b32@redhat.com>
 <PH0PR12MB54811C39B86AC8D6BECA9E05DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
 <7a0a8bdf-4cd2-2fc2-73a5-53fb2ab432b6@redhat.com>
 <PH0PR12MB54819F782D5D7E6F9DCDF5FEDC069@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5350f5c0-c707-c3ec-8ed8-16c884467ffa@redhat.com>
 <20210628183831-mutt-send-email-mst@kernel.org>
 <80b42ef6-b8ba-c0f6-3a6f-30f9125ebd35@redhat.com>
 <20210629153540-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bfa8915f-d119-91be-bfab-07856947f918@redhat.com>
Date: Wed, 30 Jun 2021 11:46:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629153540-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

CuWcqCAyMDIxLzYvMzAg5LiK5Y2INDowMSwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiBP
biBUdWUsIEp1biAyOSwgMjAyMSBhdCAxMTo0MTo1NEFNICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+PiDlnKggMjAyMS82LzI5IOS4iuWNiDY6MzksIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6
Cj4+PiBPbiBNb24sIEp1biAyOCwgMjAyMSBhdCAwMTowMzoyMFBNICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+Pj4+IFNvIEkgdGhpbmsgd2UgbmVlZCBzb2x2ZSB0aGVtIGFsbCwgYnV0IG5ldGxp
bmsgaXMgcHJvYmFibHkgdGhlIHdyb25nIGxheWVyLAo+Pj4+IHdlIG5lZWQgdG8gc29sdmUgdGhl
bSBhdCB2aXJ0aW8gbGV2ZWwgYW5kIGxldCBuZXRsaW5rIGEgdHJhbnNwb3J0IGZvciB0aGVtCj4+
Pj4gdmlydGlvIHVBUEkvQUJJLgo+Pj4gSSdtIG5vdCBzdXJlIEkgZm9sbG93LiB2aXJ0aW8gZGVm
aW5lcyBWRiB0byBkcml2ZXIgY29tbXVuaWNhdGlvbi4KPj4+IFRoaXMgaXMgUEYgdG8gaHlwZXJ2
aXNvci4gdmlydGlvIHNpbXBseSBkb2VzIG5vdCBjb3ZlciBpdCBBVE0uCj4+Cj4+IE5vdGUgdGhh
dCB0aGlzIGlzIG5vdCBQRiB0byBoeXBlcnZpc29yIGJ1dCB0aGUgdUFQSSBmcm9tIHVzZXJzcGFj
ZSAodkRQQQo+PiB0b29sKSB0byB2RFBBIGNvcmUuCj4+Cj4+IFdlIGhhZCB0d28gY2hvaWNlcy4K
Pj4KPj4gMSkgdHdlYWsgdmlydGlvIHVBUElzCj4+IDIpIGludmVudCB2aXJ0aW8gc3BlY2lmaWMg
dUFQSSBpbiBuZXRsaW5rCj4+Cj4+IDEpIHNlZW1zIGJldHRlci4KPj4KPj4gVGhhbmtzCj4+Cj4g
V2VsbCB0aGluZ3MgbGlrZSBzZXR0aW5nIG1hYyBhcmVuJ3QgdmlydGlvIHNwZWNpZmljLgo+IFdo
YXQgYXJlIHRoZSB2aXJ0aW8gc3BlY2lmaWMgdGhpbmdzIHlvdSBoYXZlIGluIG1pbmQ/CgoKRS5n
IG1heF92aXJ0cXVldWVfcGFpcnM/IEV2ZW4gaWYgbWFjIGFyZW4ndCB2aXJ0aW8gc3BlY2lmaWMs
IHRoZSBpZGVhIGlzIAp0byBidWlsZCB0aGUgZGV2aWNlIGNvbmZpZyB3aGljaCBpcyB2aXJ0aW8g
c3BlY2lmaWMuCgpBbmQgd2UgbWF5IGhhdmUgb3RoZXIgZGV2aWNlcyBsaWtlIHZpcnRpby1ibGsu
CgpUaGFua3MKCgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
