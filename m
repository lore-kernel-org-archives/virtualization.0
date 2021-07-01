Return-Path: <SRS0=M3O5=LZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A71C11F64
	for <virtualization@archiver.kernel.org>; Thu,  1 Jul 2021 03:34:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4763B61461
	for <virtualization@archiver.kernel.org>; Thu,  1 Jul 2021 03:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4763B61461
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0F3FD40025;
	Thu,  1 Jul 2021 03:34:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K0vrFpr4Hyo9; Thu,  1 Jul 2021 03:34:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9E6FD40012;
	Thu,  1 Jul 2021 03:34:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7316AC0010;
	Thu,  1 Jul 2021 03:34:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C62AAC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 03:34:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C1304415C6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 03:34:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dy8t3pH35Y1W
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 03:34:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A22A24159D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 03:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625110455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MkUsES25dbuDX5u3B9n+9dUV7Hju/VDgWhYCYiZDmCw=;
 b=b+WFeY7R2U5G2a4kzPgD+Aq+X57vuEVaYYHrDKKJ1UsYmpJqv1Mt+4jiMdvWdtnlLKSqS8
 JnWdFG0g3wBkXEmzTQTkSxnXzpD2xnRxvfx9u6s2rnQPjPVTE/Rhlz+VJY9m6S5QFwYtDS
 47mvSASjWMeJ6w16gUnn9+sceOZfcok=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-LKx_GAlGPC-t_YMheFWFdQ-1; Wed, 30 Jun 2021 23:34:12 -0400
X-MC-Unique: LKx_GAlGPC-t_YMheFWFdQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 c10-20020a17090a558ab029017019f7ec8fso2540994pji.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 20:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=MkUsES25dbuDX5u3B9n+9dUV7Hju/VDgWhYCYiZDmCw=;
 b=r6odolKPqqxx35zOyuGRCLCOB5+mi3DSG5vJVhYqGNMLEPwAKvf/sHX1rFL8ZZXoOv
 8gLENYuZ5B2dmtnLXq7NfEFPAPzjnqpsrqY2s9mHniZJEjx7BftL39Y0alKn4qrHT3qb
 ZWNZRicihhlDyGbk84sso1Qx6mtwzYmTONiRsYlb6S9FMzw6teRFJ7Z7FdSrHmsiYIwC
 dUhsAPHOyqMvzIFNgBPp6lFo1+zX8/paht/JaXGb63+kelu2Exx+MzCqnaamWcw9IBRv
 CaqFi2aDWThQk+PqcLPZ7Qh6gJ1oew9wFuNGEYor/VFRR6hPqlwl7g748AT2fbI0PZjw
 joew==
X-Gm-Message-State: AOAM531fu7DaNmVOVUKFya0DFVXJH/2GVigAbadlx27zar0OIuHgXWTr
 3bE50LNRSOxOuEJl8tsWEfLYaI6EzJlFJPHYBkEd9aj5R5MR0IM0XK5icZSLkqJBPqx+yDjOXf4
 Ym5p8n71VwCLqfEIdclKnAHfsOgxTndTtETe12RkSnA==
X-Received: by 2002:a63:e948:: with SMTP id q8mr37845749pgj.52.1625110450967; 
 Wed, 30 Jun 2021 20:34:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtl6Wr2rYv81LVa6XztOepYryJkIA+Q4yl6ut52GJEWG0awMR/prna8D5gM5wdNElcPYa5uQ==
X-Received: by 2002:a63:e948:: with SMTP id q8mr37845726pgj.52.1625110450710; 
 Wed, 30 Jun 2021 20:34:10 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j17sm22544932pfc.139.2021.06.30.20.34.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jun 2021 20:34:10 -0700 (PDT)
Subject: Re: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
To: Parav Pandit <parav@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20210616191155.102303-1-parav@nvidia.com>
 <0434617e-f960-eb1a-a682-49b6a754413f@redhat.com>
 <PH0PR12MB548147BE1B95CB294785470CDC089@PH0PR12MB5481.namprd12.prod.outlook.com>
 <d361bd10-3967-8844-1457-48e7e9422fb2@redhat.com>
 <PH0PR12MB54812DD2DADAD0897E24CFA7DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4e0708fb-34e3-471d-ca98-44c75f693b32@redhat.com>
 <PH0PR12MB54811C39B86AC8D6BECA9E05DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
 <7a0a8bdf-4cd2-2fc2-73a5-53fb2ab432b6@redhat.com>
 <PH0PR12MB54819F782D5D7E6F9DCDF5FEDC069@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5350f5c0-c707-c3ec-8ed8-16c884467ffa@redhat.com>
 <PH0PR12MB5481030671D848D951477571DC039@PH0PR12MB5481.namprd12.prod.outlook.com>
 <bf6ec662-b53d-174f-53e2-735589f83d3d@redhat.com>
 <PH0PR12MB548115ACBDA9D76526C370B3DC029@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8c78b8ed-e16c-31dd-7c1c-abd2bef6bb12@redhat.com>
 <PH0PR12MB5481737F058FDE9B947C1ECFDC019@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a23cdc3a-80cb-f5aa-e77c-4b897c8456af@redhat.com>
Date: Thu, 1 Jul 2021 11:34:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481737F058FDE9B947C1ECFDC019@PH0PR12MB5481.namprd12.prod.outlook.com>
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

CuWcqCAyMDIxLzYvMzAg5LiL5Y2IMjowMywgUGFyYXYgUGFuZGl0IOWGmemBkzoKPiBIaSBKYXNv
biwKPgo+PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+PiBTZW50OiBX
ZWRuZXNkYXksIEp1bmUgMzAsIDIwMjEgMTA6MDIgQU0KPj4+PiBJdCBsb29rcyB0byB3ZSBkb24n
dCBuZWVkIHRoZSByZXN0IG9mIGZpZWxkcyBpbiB0aGUgdmlydGlvX25ldF9jb25maWcKPj4+PiB0
byBidWlsZCB0aGUgY29uZmlnIHNpbmNlIHRoZXkgYXJlIGFsbCBoYXJkd2FyZSBhdHRyaWJ1dGVz
Lgo+Pj4gVG9kYXkgaXQgaXMgb25seSBtYWMgYW5kIG1heCBxdWV1ZXMuIExhdGVyIG9uIHdlIG1h
eSBuZWVkIHRvIGRlZmluZSByc3MKPj4gaGFzaGluZyBhcyBody9kZXZpY2UgYWR2YW5jZXMuCj4+
PiBBbmQgc3RydWN0dXJlIHNpemUgd2lsbCBjaGFuZ2UuCj4+PiBIZW5jZSwgSSBwcm9wb3NlIHRv
IGhhdmUgZWFjaCBhcyBpbmRpdmlkdWFsIGF0dHJpYnV0ZSB0aGF0IGRvZXNu4oCZdCBuZWVkIHRv
Cj4+IGNhc3QgaW4gc3RydWN0Lgo+Pgo+Pgo+PiBPaywgdGhhdCBzaG91bGQgd29yay4gSWYgTWlj
aGFlbCBhcmUgZmluZSB3aXRoIHRoaXMsIEknbSBhbHNvIGZpbmUuCj4+Cj4+IEp1c3QgdG8gY2xh
cmlmeSwgaWYgSSB1bmRlcnN0YW5kIHRoaXMgY29ycmVjdGx5LCB3aXRoIHRoZSBpbmRpdmlkdWFs
IGF0dHJpYnV0ZSwKPj4gdGhlcmUncyBubyBuZWVkIGZvciB0aGUgYml0IGxpa2UgeHh4X2lzX3Zh
bGlkPwo+IHh4eF9pc192YWxpZCBpcyBub3QgcHJlc2VudCBpbiB0aGUgZ2V0IGNhbGxzLgo+IEl0
IGlzIGFsc28gbm90IHByZXNlbnQgaW4gVUFQSSBzZXQgY2FsbHMuCj4gSXQgaXMgbm90IGEgVUFQ
SS4KPiBJdCBpcyBhbiBpbnRlcm5hbCBiZXR3ZWVuIHZkcGEuYyBhbmQgdmVuZG9yIGRyaXZlciB0
byB0ZWxsIHdoaWNoIGZpZWxkcyB0byB1c2UgYXMgdGhlcmUgYXJlIG9wdGlvbmFsLgo+IElmIHdl
IHdhbnQgdG8gZ2V0IHJpZCBvZiB0aG9zZSB2YWxpZCBmbGFncyBiZWxvdyBjb2RlIHdpbGwgbW92
ZSB0byB2ZW5kb3IgZHJpdmVyIHdoZXJlIHdlIHBhc3MgbmxfYXR0ciwgZHVyaW5nIGRldmljZSBh
ZGQgY2FsbGJhY2suCj4KPgo+ICsJaWYgKG5sX2F0dHJzW1ZEUEFfQVRUUl9ERVZfTkVUX0NGR19N
QUNBRERSXSkgewo+ICsJCW1hY2FkZHIgPSBubGFfZGF0YShubF9hdHRyc1tWRFBBX0FUVFJfREVW
X05FVF9DRkdfTUFDQUREUl0pOwo+ICsJCW1lbWNweShjb25maWcubmV0Lm1hYywgbWFjYWRkciwg
c2l6ZW9mKGNvbmZpZy5uZXQubWFjKSk7Cj4gKwkJY29uZmlnLm5ldF9tYXNrLm1hY192YWxpZCA9
IHRydWU7Cj4gKwl9Cj4gKwlpZiAobmxfYXR0cnNbVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01UVV0p
IHsKPiArCQljb25maWcubmV0Lm10dSA9Cj4gKwkJCW5sYV9nZXRfdTE2KG5sX2F0dHJzW1ZEUEFf
QVRUUl9ERVZfTkVUX0NGR19NVFVdKTsKPiArCQljb25maWcubmV0X21hc2subXR1X3ZhbGlkID0g
dHJ1ZTsKPiArCX0KCgpIYXZlIGEgaGFyZCB0aG91Z2h0IG9uIHRoaXMuIEkgc3RpbGwgdGhpbmsg
cmUtaW52ZW50IChkdXBsaWNhdGUpIHRoZSAKdmlydGlvLW5ldCBjb25maWcgZmlsZWQgaXMgbm90
IGEgZ29vZCBjaG9pY2UgKGUuZyBmb3IgYmxvY2sgd2UgbmVlZCB0byAKZHVwbGljYXRlIG1vcmUg
dGhhbiAyMCBhdHRyaWJ1dGVzKS4KCldlIG1heSBtZWV0IHNpbWlsYXIgaXNzdWUgd2hlbiBwcm92
aXNpb24gVkYvU0YgaW5zdGFuY2UgYXQgdGhlIGhhcmR3YXJlIApsZXZlbC4gU28gSSB0aGluayB3
ZSBtYXkgbmVlZCBzb21ldGhpbmcgaW4gdGhlIHZpcnRpbyBzcGVjIGluIHRoZSBuZWFyIApmdXR1
cmUuCgpTbyBhc3N1bWluZyB3ZSBkb24ndCB3YW50IGEgc2luZ2xlIGF0dHJpYnV0ZXMgdG8gYmUg
bW9kaWZpZWQgYW5kIHdlIHdhbnQgCnRvIGxldCB1c2VyIHRvIHNwZWNpZnkgYWxsIHRoZSBhdHRy
aWJ1dGVzIGF0IG9uZSB0aW1lIGR1cmluZyBjcmVhdGlvbi4KCk1heWJlIHdlIGNhbiB0d2VhayB2
aXJ0aW9fbmV0X2NvbmZpZ19zZXQgYSBsaXR0bGUgYml0OgoKc3RydWN0IHZpcnRpb19uZXRfY29u
ZmlnX3NldCB7CiDCoMKgwqAgwqDCoMKgIF9fdmlydGlvNjQgZmVhdHVyZXM7CiDCoMKgwqDCoMKg
wqDCoCBfX3U4IG1hY1tFVEhfQUxFTl07CiDCoMKgwqDCoMKgwqDCoCBfX3ZpcnRpbzE2IG1heF92
aXJ0cXVldWVfcGFpcnM7CiDCoMKgwqAgwqDCoMKgIF9fdmlydGlvMTYgbXR1OwogwqDCoMKgIMKg
wqDCoCBfX3ZpcnRpbzE2IHJlc2VydmVkWzYyXTsKfQoKU28gd2UgaGF2ZToKCi0gYm90aCBmZWF0
dXJlcyBhbmQgY29uZmlnIGZpZWxkcywgd2UncmUgc2VsZiBjb250YWluZWQKLSByZXNlcnZlZCBm
aWVsZHMgd2hpY2ggc2hvdWxkIGJlIHN1ZmZpY2llbnQgZm9yIHRoZSBuZXh0IDEwIHllYXJzLCBz
byAKd2UgZG9uJ3QgbmVlZCB0byBjYXJlIGFib3V0IHRoZSBncm93aW5nLgoKT3IgYWN0dWFsbHkg
aXQgYWxzbyBhbGxvd3MgcGVyIGZpZWxkIG1vZGlmaWNhdGlvbi4KCkUuZyBpZiB3ZSBkb24ndCBz
cGVjaWZ5IFZJUlRJT19ORVRfRl9NQUMsIGl0IG1lYW5zIG1hYyBmaWVsZCBpcyBpbnZhbGlkLiAK
U28gZGlkIGZvciBxcHMgYW5kIG10dS4KClRoZSBhZHZhbnRhZ2UgaXMgdGhhdCB3ZSBjYW4gc3Rh
bmRhcmRpemUgdGhpcyBpbiB0aGUgdmlydGlvIHNwZWMgd2hpY2ggCmNvdWxkIGJlIHVzZWQgZm9y
IFNGL1ZGIHByb3Zpc2lvbmluZy4KCkZvciBnZXQsIHdlIHByb2JhYmx5IG5lZWQgbW9yZSB3b3Jr
OgoKc3RydWN0IHZpcnRpb19uZXRfY29uZmlnX2dldCB7CiDCoMKgwqAgwqDCoMKgIF9fdmlydGlv
NjQgZmVhdHVyZXM7CiDCoMKgwqAgwqDCoMKgIHVuaW9uIHsKIMKgwqDCoCDCoMKgwqAgwqDCoMKg
IMKgwqDCoCBzdHJ1Y3QgdmlydGlvX25ldF9jb25maWc7CiDCoMKgwqAgwqDCoMKgIMKgwqDCoCDC
oMKgwqAgX192aXJ0aW82NCByZXNlcnZlZFsxNl07CiDCoMKgwqAgwqDCoMKgIH0KfQoKT3IganVz
dCBmb2xsb3cgaG93IGl0IGlzIHdvcmsgdG9kYXksIHNpbXBseSBwYXNzIHRoZSBjb25maWcgcGx1
cyB0aGUgCmRldmljZV9mZWF0dXJlcy4KClRoYW5rcwoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
