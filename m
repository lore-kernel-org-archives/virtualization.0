Return-Path: <SRS0=ROIW=NA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6E2C4338F
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 03:08:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1028560FD8
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 03:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1028560FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6E76402FE;
	Mon,  9 Aug 2021 03:08:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8DLKKluGgAGg; Mon,  9 Aug 2021 03:08:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1E0F8402FA;
	Mon,  9 Aug 2021 03:08:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D36C4C001A;
	Mon,  9 Aug 2021 03:08:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4C4AC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 03:08:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ADCB6400F5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 03:08:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wYI1S-g8rpch
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 03:08:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 01D7D400C7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 03:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628478479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0XtGDeltIU6qBMtj7zKLon+nXFELS/CoxkXod0/3nFs=;
 b=WlQj8HasiYeD1yx+6G1BoiVswfAItuYvVrFfcCmR4x4fw734sB+yEsuhI7b9hYLEqjAY6g
 rxHJi7UOtPXoudSNWs+38+m13fAZafy/+Pa6LWEMrYnuNoVWcDbwIW0alLixAWIaNQNcLa
 8LATjQP95WvJ8swxT73airaIcGsC+u8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-ssPkxja3MLKmavIf2D5QTg-1; Sun, 08 Aug 2021 23:07:56 -0400
X-MC-Unique: ssPkxja3MLKmavIf2D5QTg-1
Received: by mail-pl1-f197.google.com with SMTP id
 u4-20020a170902e804b029012c4b467095so7731519plg.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 08 Aug 2021 20:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=0XtGDeltIU6qBMtj7zKLon+nXFELS/CoxkXod0/3nFs=;
 b=Z1g5UuR2r7Xz4NBKgxZZYAlZsNLmAqcTvVrGBqLvMVzQfnOJya5730ncnXrBEeG2yF
 gLw6utZO1uiona8bz7khaQ93DCjLiuhOr03Qhkg+uAIEGfN6MHAAKg5heVQGVH4SODrn
 be6T+SirX8+cPl6wghXBKeKbe2H7zRNp4+5MuY3rno3szUr9DML/z+abU+9lFBlgO66Y
 shEJo38YJIkN3gjyPFah6bZ+74c+0ElE7fPw7fElMGPoU7uMBer+HGwlOLfS329Bnf5R
 +zUddleOTmdLkzsMRkCizvYumh5bRzwS6N3sk1M2SBV65PbAiA5TvSLZsKa/CCn9uLDU
 Jnrg==
X-Gm-Message-State: AOAM5335BTpETb/4VfdOmsTS2biUDpu/QsfIzLRhpDXIAOAqBk96CMY9
 2wV/SUMDThuuzoQDszvcau/P1a9U2lcnr8jp65jOk9YSVdG7ixOxmFttOgTYzIsb5eiwiFKlryo
 PHGz3dcPg2SSaWczoV39Jcl+vQFALWbqBtCDuVCIFjw==
X-Received: by 2002:a62:ee16:0:b029:2fe:ffcf:775a with SMTP id
 e22-20020a62ee160000b02902feffcf775amr15944026pfi.59.1628478474951; 
 Sun, 08 Aug 2021 20:07:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZP8P7DNDP4sj+CkKh8GPqUN83v+GXcMkQZK6WYn7ZOVddDKoxcz5EN0QOXSQ0mYQjFl3EYQ==
X-Received: by 2002:a62:ee16:0:b029:2fe:ffcf:775a with SMTP id
 e22-20020a62ee160000b02902feffcf775amr15944020pfi.59.1628478474736; 
 Sun, 08 Aug 2021 20:07:54 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id o127sm18485077pfb.48.2021.08.08.20.07.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Aug 2021 20:07:54 -0700 (PDT)
Subject: Re: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210805055623-mutt-send-email-mst@kernel.org>
 <e3b31032-222a-e1bc-f452-a965b456f48b@redhat.com>
 <20210806034817-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812C49AAA468E1E6A871A9DCF39@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <be8a0173-b7fb-eabf-bc4a-9492133674ef@redhat.com>
Date: Mon, 9 Aug 2021 11:07:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54812C49AAA468E1E6A871A9DCF39@PH0PR12MB5481.namprd12.prod.outlook.com>
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

CuWcqCAyMDIxLzgvNiDkuIvljYg0OjU1LCBQYXJhdiBQYW5kaXQg5YaZ6YGTOgo+Cj4+IEZyb206
IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+Cj4+IFNlbnQ6IEZyaWRheSwgQXVn
dXN0IDYsIDIwMjEgMjoxMiBQTQo+Cj4+PiAgIGVudW0gdmRwYV9hdHRyIHsKPj4+IEBAIC0zMyw2
ICszNCwxNiBAQCBlbnVtIHZkcGFfYXR0ciB7Cj4+PiAgIAlWRFBBX0FUVFJfREVWX01BWF9WUVMs
CQkJLyogdTMyICovCj4+PiAgIAlWRFBBX0FUVFJfREVWX01BWF9WUV9TSVpFLAkJLyogdTE2ICov
Cj4+PiArCVZEUEFfQVRUUl9ERVZfTkVUX0NGR19NQUNBRERSLAkJLyogYmluYXJ5ICovCj4+PiAr
CVZEUEFfQVRUUl9ERVZfTkVUX1NUQVRVUywJCS8qIHU4ICovCj4+PiArCVZEUEFfQVRUUl9ERVZf
TkVUX0NGR19NQVhfVlFQLAkJLyogdTE2ICovCj4+PiArCVZEUEFfQVRUUl9ERVZfTkVUX0NGR19N
VFUsCQkvKiB1MTYgKi8KPj4+ICsJVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX1NQRUVELAkJLyogdTE2
ICovCj4+PiArCVZEUEFfQVRUUl9ERVZfTkVUX0NGR19EVVBMRVgsCQkvKiB1MTYgKi8KPj4+ICsJ
VkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX1JTU19NQVhfS0VZX0xFTiwJLyogdTggKi8KPj4+ICsJVkRQ
QV9BVFRSX0RFVl9ORVRfQ0ZHX1JTU19NQVhfSVRfTEVOLAkvKiB1MTYgKi8KPj4+ICsJVkRQQV9B
VFRSX0RFVl9ORVRfQ0ZHX1JTU19IQVNIX1RZUEVTLAkvKiB1MzIgKi8KPj4+ICsKPj4+ICAgCS8q
IG5ldyBhdHRyaWJ1dGVzIG11c3QgYmUgYWRkZWQgYWJvdmUgaGVyZSAqLwo+Pj4gICAJVkRQQV9B
VFRSX01BWCwKPj4+ICAgfTsKPj4gVGhlIHBvaW50IGlzIHRvIHRyeSBhbmQgbm90IHJlaW52ZW50
IGEgZGVkaWNhdGVkIHZwZGEgaW50ZXJmYWNlIHdoZXJlIGEKPj4gZ2VuZXJpYyBvbmUgZXhpdHMu
Cj4+IEUuZy4gZm9yIHBoeSB0aGluZ3Mgc3VjaCBhcyBtYWMgc3BlZWQgZXRjLCBJIHRoaW5rIG1v
c3QgcGVvcGxlIGFyZSB1c2luZwo+PiBldGh0b29sIHRoaW5ncyByaWdodD8KPiBBcyB5b3Uga25v
dyB2ZHBhIGlzIHRoZSBiYWNrZW5kIGRldmljZSBmb3IgdGhlIGZyb250LWVuZCBuZXRkZXZpY2Ug
YWNjZXNzZWQgYnkgdGhlIGV0aHRvb2wuCj4gdmRwYSBtYW5hZ2VtZW50IHRvb2wgaGVyZSBpcyBj
b21wb3NpbmcgdGhlIHZkcGEgZGV2aWNlLgo+Cj4gRm9yIGV4YW1wbGUgY3JlYXRvciAoaHlwZXJ2
aXNvcikgb2YgdGhlIHZkcGEgZGV2aWNlcyBrbm93cyB0aGF0IGEgZ3Vlc3QgVk0gaXMgZ2l2ZW4g
NCB2Y3B1cywKPiBTbyBoeXBlcnZpc29yIGNyZWF0ZXMgYSB2ZHBhIGRldmljZXMgd2l0aCBjb25m
aWcgc3BhY2UgbGF5b3V0IGFzLAo+IG1heF92aXJ0cXVldWVfcGFpcnMgPSA0Lgo+IEFuZCB0aGUg
TUFDIGFkZHJlc3MgY2hvc2VuIGJ5IGh5cGVydmlzb3IgaW4gbWFjWzZdLgo+Cj4gR3Vlc3QgVk0g
ZXRodG9vbCBjYW4gc3RpbGwgY2hvc2UgdG8gdXNlIGxlc3MgbnVtYmVyIG9mIGNoYW5uZWxzLgo+
Cj4gVHlwaWNhbGx5LAo+IGV0aHRvb2wgaXMgZm9yIGd1ZXN0IFZNLgo+IHZkcGEgZGV2aWNlIGlz
IGluIGh5cGV2aXNvci4KPgo+IEhvdyBjYW4gaHlwZXJ2aXNvciBjb21wb3NlIGEgdmRwYSBkZXZp
Y2Ugd2l0aG91dCBhbnkgdG9vbD8KPiBIb3cgY2FuIGl0IHRlbGwgZXRodG9vbCwgd2hhdCBpcyBz
dXBwb3J0ZWQgYW5kIHdoYXQgYXJlIHRoZSBkZWZhdWx0cz8KCgpSZXJlYWQgdGhlIGNvdmVyIGxl
dHRlcjoKCiIKClRoaXMgcGF0Y2hzZXQgZW5hYmxlcyB1c2VycyB0byBzZXQgdGhlIG1hYyBhZGRy
ZXNzIGFuZCBtdHUgb2YgdGhlIHZkcGEKZGV2aWNlIG9uY2UgdGhlIGRldmljZSBpcyBjcmVhdGVk
LgoKIgoKSXQgbG9va3MgdG8gbWUgdGhlIG1lY2hhbmlzbSB0aGF0IGludHJvZHVjZWQgaW4gdGhl
IHNlcmllcyBpcyBub3QgZm9yIApwcm92aXNpb25pbmcgYnV0IGZvciBwb3N0LWNyZWF0aW9uIGNv
bmZpZ3VyYXRpb24/CgoKPgo+IEkgbXVzdCBiZSBtaXN1bmRlcnN0YW5kaW5nIHlvdXIgY29tbWVu
dCBhYm91dCBldGh0b29sLgo+IENhbiB5b3UgcGxlYXNlIGV4cGxhaW4/CgoKSSBndWVzcyB0aGUg
bWVhbmluZyBpcyB0aGF0LCBpZiB0aGUgdkRQQSBpcyBhc3NpZ25lZCB0byBndWVzdCwgaXQncyB0
aGUgCmNoYXJnZSBvZiBndWVzdCB0byBjb25maWd1cmUgdGhlIE1UVS9NQUMvUlNTIHZpYSB0aGUg
ZXhpc3RpbmcgbWFuYWdlbWVudCAKaW50ZXJmYWNlIGxpa2UgZXRodG9vbC9pcHJvdXRlMiBuZXRs
aW5rIHByb3RvY29sLiBUaGUgY29udHJvbCB2aXJ0cXVldWUgCmlzIGRlc2lnbmVkIGZvciB0aGlz
LgoKQnV0IGlmIGl0IHdhcyB1c2VkIGZvciBwcm92aXNpb25pbmcsIGl0IGxvb2tzIGxpa2UgYW5v
dGhlciB0b3BpYyB3aGljaCAKc2hvdWxkIGJlIGRvbmUgZHVyaW5nIHRoZSBkZXZpY2UgY3JlYXRp
b24uCgpUaGFua3MKCgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
