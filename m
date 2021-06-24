Return-Path: <SRS0=YcCX=LS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7463C48BDF
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 05:43:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97787613E8
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 05:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97787613E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 63212400FF;
	Thu, 24 Jun 2021 05:43:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bwarBoVrdDZU; Thu, 24 Jun 2021 05:43:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 02B9E403E3;
	Thu, 24 Jun 2021 05:43:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDFBFC0010;
	Thu, 24 Jun 2021 05:43:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58144C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 05:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 534F340279
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 05:43:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1XE8TFrQaOeF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 05:43:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 342794025F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 05:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624513410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3jCMbkBXKujA8mimMxuTKI8C/1Lj5gmiUfyY2kGpWPY=;
 b=RJDmVDsUwn0nFlSFhaZJOeGpstiRB9Udr7LWx5EwgQYRRBLQBCvIsfbzr2or9wAA5DsSbZ
 8ITFzkIdtAMsA3CfEYTynNHrNXBMUbhl5Ff+8k7XPa5hgFeHBn30zfxxqjhFDEF5FwY6Hh
 /Jr3cSwC7VMTQG6R0FwXtCP/nh6Aw4E=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442--66YS9fZNtGfkpKlIAJgVg-1; Thu, 24 Jun 2021 01:43:28 -0400
X-MC-Unique: -66YS9fZNtGfkpKlIAJgVg-1
Received: by mail-pl1-f198.google.com with SMTP id
 q12-20020a170902a3ccb0290124d72c3413so1754966plb.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 22:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=3jCMbkBXKujA8mimMxuTKI8C/1Lj5gmiUfyY2kGpWPY=;
 b=emveD/VUXAuH6pimsgsIgODFgfbjsZ0X3lyUbfiTRFeLpS6SBVhcclK+AyuDneEwo9
 GLovtLBvf5Ben2zUnS/4TipXAYICyrtPlRsqmvWeszIvpL9ykbPomg27oNSPopv8Z4wl
 SIPtIPrSygYZ24T9qgVumMOpy10EIkqlXij2hbna7MvQCUzyT4gkg+kO86XJCFqYPJwP
 wA4tt74IyB8Lv8701nOnpGVtgg7Bl8KDtLher7q71b7aEfCSZc/okS1FYJZIVG5g+VhI
 dsnNMlJZXrF1tegBoi2VyUKnpCtB82WiRl5y8tqapn2pLCeoiaDSyMLOzZXGwGWWCGkG
 cn7g==
X-Gm-Message-State: AOAM533FS209Dh748YA+c5cJszcpisDeHaUQ3CtrL2nEGhsm8qczRjFB
 M/dTWU4RV86gB6T3XkjnuE/yc/BFmPY5O5Tgy9ylKhHXZCqN+q2YWWlGYYadZu+DwyeuNpnovyi
 OcGSpotrrBO35D9Zivl9gWSDgdO8d0alSIELkflxZEA==
X-Received: by 2002:a17:902:728d:b029:113:23:c65f with SMTP id
 d13-20020a170902728db02901130023c65fmr2982519pll.23.1624513407568; 
 Wed, 23 Jun 2021 22:43:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQtHdzrGE+iRJkJp8KFY/0X6QQOP+VvDBiFfrdumFCRK0ZU4O6iaxMDHgpHEIzu+x6QIpbFg==
X-Received: by 2002:a17:902:728d:b029:113:23:c65f with SMTP id
 d13-20020a170902728db02901130023c65fmr2982503pll.23.1624513407338; 
 Wed, 23 Jun 2021 22:43:27 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id m21sm6901266pjz.57.2021.06.23.22.43.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jun 2021 22:43:26 -0700 (PDT)
Subject: Re: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
To: Parav Pandit <parav@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210616191155.102303-3-parav@nvidia.com>
 <aa7899c0-4b6b-dee3-a175-91e0394bc999@redhat.com>
 <PH0PR12MB5481AE651E0E9BFA6A1839EEDC099@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0434617e-f960-eb1a-a682-49b6a754413f@redhat.com>
 <PH0PR12MB548147BE1B95CB294785470CDC089@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d361bd10-3967-8844-1457-48e7e9422fb2@redhat.com>
Date: Thu, 24 Jun 2021 13:43:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548147BE1B95CB294785470CDC089@PH0PR12MB5481.namprd12.prod.outlook.com>
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

CuWcqCAyMDIxLzYvMjMg5LiL5Y2IMTI6MjIsIFBhcmF2IFBhbmRpdCDlhpnpgZM6Cj4KPj4gRnJv
bTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPj4gU2VudDogV2VkbmVzZGF5LCBK
dW5lIDIzLCAyMDIxIDk6MzkgQU0KPj4KPj4g5ZyoIDIwMjEvNi8yMiDkuIvljYgxMDowMywgUGFy
YXYgUGFuZGl0IOWGmemBkzoKPj4+PiBJcyBpdCBiZXR0ZXIgdG8gdXNlIGEgc2VwYXJhdGUgZW51
bSBmb3IgbmV0IHNwZWNpZmljIGF0dHJpYnV0ZXM/Cj4+Pj4KPj4+IFllcywgYmVjYXVzZSB0aGV5
IGFyZSBvbmx5IG5ldCBzcGVjaWZpYy4KPj4+IEkgZ3Vlc3MgaXQgaXMgcmVsYXRlZCB0byB5b3Vy
IGJlbG93IHF1ZXN0aW9uLgo+Pj4KPj4+PiBBbm90aGVyIHF1ZXN0aW9uIChzb3JyeSBpZiBpdCBo
YXMgYmVlbiBhc2tlZCBiZWZvcmUpLiBDYW4gd2Ugc2ltcGx5Cj4+Pj4gcmV0dXJuIHRoZSBjb25m
aWcgKGJpbmFyeSkgdG8gdGhlIHVzZXJzcGFjZSwgdGhlbiB1c2VzcGFjZSBjYW4gdXNlCj4+Pj4g
dGhlIGV4aXN0aW5nIHVBUEkgbGlrZSB2aXJ0aW9fbmV0X2NvbmZpZyBwbHVzIHRoZSBmZWF0dXJl
IHRvIGV4cGxhaW4gdGhlCj4+IGNvbmZpZz8KPj4+IFdlIGRpZCBkaXNjdXNzIGluIHYyLgo+Pj4g
VXN1YWxseSByZXR1cm5pbmcgdGhlIHdob2xlIGJsb2IgYW5kIHBhcnNpbmcgaXMgbm90IGRlc2ly
ZWQgdmlhIG5ldGxpbmsuCj4+PiBSZXR1cm5pbmcgaW5kaXZpZHVhbCBmaWVsZHMgZ2l2ZSB0aGUg
ZnVsbCBmbGV4aWJpbGl0eSB0byByZXR1cm4gb25seSB0aGUgdmFsaWQKPj4gZmllbGRzLgo+Pj4g
T3RoZXJ3aXNlIHdlIG5lZWQgdG8gaW1wbGVtZW50IGFub3RoZXIgYml0bWFzayB0b28gdG8gdGVs
bCB3aGljaCBmaWVsZHMKPj4gZnJvbSB0aGUgc3RydWN0IGFyZSB2YWxpZCBhbmQgc2hhcmUgd2l0
aCB1c2VyIHNwYWNlLgo+Pj4gUmV0dXJuaW5nIGluZGl2aWR1YWwgZmllbGRzIGlzIHRoZSB3aWRl
bHkgdXNlZCBhcHByb2FjaC4KPj4KPj4gVGhlIG1haW4gY29uY2VybnMgYXJlOgo+Pgo+PiAxKSBU
aGUgYmxvYiB3aWxsIGJlIHNlbGYgY29udGFpbmVkIGlmIGl0IHdhcyBwYXNzZWQgd2l0aCB0aGUg
bmVnb3RpYXRlZAo+PiBmZWF0dXJlcywgc28gd2UgZG9uJ3QgbmVlZCBiaXRtYXNrLgo+IFdoaWNo
IGZpZWxkcyBvZiB0aGUgc3RydWN0IGFyZSB2YWxpZCBpcyB0b2xkIGJ5IGFkZGl0aW9uYWwgZmll
bGRzLgo+PiAyKSBVc2luZyBpbmRpdmlkdWFsIGZpZWxkcyBtZWFucyBpdCBtdXN0IGR1cGxpY2F0
ZSB0aGUgY29uZmlnIGZpZWxkcyBvZiBldmVyeQo+PiB2aXJ0aW8gZGV2aWNlcwo+Pgo+IE1vc3Rs
eSBuby4gaWYgdGhlcmUgYXJlIGNvbW1vbiBjb25maWcgZmllbGRzIGFjcm9zcyB0d28gZGV2aWNl
IHR5cGVzLCB0aGV5IHdvdWxkIGJlIG5hbWVkIGFzCj4gVkRQQV9BVFRSX0RFVl9DRkdfKgo+IE5l
dCBzcGVjaWZpYyB3aWxsIGJlLAo+IFZEUEFfQVRUUl9ERVZfTkVUX0NGR18qCj4gQmxvY2sgc3Bl
Y2lmaWMsIHdpbGwgYmUsCj4gVkRQQV9BVFRSX0RFVl9CTEtfQ0ZHXyoKCgpJIG1lYW50IGl0IGxv
b2tzIGxpa2UgVkRQQV9BVFRSX0RFVl9ORVQgd2lsbCBkdXBsaWNhdGUgYWxsIHRoZSBmaWVsZHMg
b2Y6CgpzdHJ1Y3QgdmlydGlvX25ldF9jb25maWc7CgpBbmQgVkRQQV9BVFRSX0RFVl9CTE9DSyB3
aWxsIGR1cGxpY2F0ZSBhbGwgdGhlIGZpZWxkcyBvZgoKc3RydWN0IHZpcnRpb19ibGtfY29uZmln
OyB3aGljaCBoYXMgfjIxIGZpZWxkcy4KCkFuZCB3ZSBoYWQgYSBwbGVudHkgb2Ygb3RoZXIgdHlw
ZXMgb2YgdmlydGlvIGRldmljZXMuCgpDb25zaWRlciB3ZSBoYWQgYSBtYXR1cmUgc2V0IG9mIHZp
cnRpbyBzcGVjaWZpYyB1QVBJIGZvciBjb25maWcgc3BhY2UuIApJdCB3b3VsZCBiZSBhIGJ1cmRl
biBpZiB3ZSBuZWVkIGFuIHVubmVjZXNzYXJ5IHRyYW5zbGF0aW9uIGxheWVyIG9mIApuZXRsaW5r
IGluIHRoZSBtaWRkbGU6CgpbdkRQQSBwYXJlbnQgKHZpcnRpb19uZXRfY29uZmlnKV0gPC0+IFtu
ZXRsaW5rIChWRFBBX0FUVFJfREVWX05FVF9YWCldIAo8LT4gW3VzZXJzcGFjZSAoVkRQQV9BVFRS
X0RFVl9ORVRfWFgpXSA8LT4gWyB1c2VyICh2aXJ0aW9fbmV0X2NvbmZpZyldCgpJZiB3ZSBtYWtl
IG5ldGxpbmsgc2ltcGx5IGEgdHJhbnNwb3J0LCBpdCB3b3VsZCBiZSBtdWNoIGVhc2llci4gQW5k
IHdlIApoYWQgdGhlIGNoYW5jZSB0byB1bmlmeSB0aGUgbG9naWMgb2YgYnVpbGRfY29uZmlnKCkg
YW5kIHNldF9jb25maWcoKSBpbiAKdGhlIGRyaXZlci4KCgo+Cj4+IEFuZCBhY3R1YWxseSwgaXQn
cyBub3QgdGhlIGJpbmFyeSBibG9iIHNpbmNlIHVhcGkgY2xlYXJseSBkZWZpbmUgdGhlIGZvcm1h
dCAoZS5nCj4+IHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyksIGNhbiB3ZSBmaW5kIGEgd2F5IHRv
IHVzZSB0aGF0PyBFLmcgaW50cm9kdWNlCj4+IGRldmljZS9uZXQgc3BlY2lmaWMgY29tbWFuZCBh
bmQgcGFzc2luZyB0aGUgYmxvYiB3aXRoIGxlbmd0aCBhbmQKPj4gbmVnb3RpYXRlZCBmZWF0dXJl
cy4KPiBMZW5ndGggbWF5IGNoYW5nZSBpbiBmdXR1cmUsIG1vc3RseSBleHBhbmQuIEFuZCBwYXJz
aW5nIGJhc2VkIG9uIGxlbmd0aCBpcyBub3Qgc3VjaCBhIGNsZWFuIHdheS4KCgpMZW5ndGggaXMg
b25seSBmb3IgbGVnYWwgY2hlY2tpbmcuIFRoZSBjb25maWcgaXMgc2VsZiBjb250YWluZWQgd2l0
aDoKCjEpIGRldmljZSBpZAoyKSBmZWF0dXJlcwoKCj4gUGFyc2luZyBmaWVsZHMgcmVxdWlyZSBr
bm93bGVkZ2Ugb2YgZmVhdHVyZXMgYXMgd2VsbCBhbmQgYXBwbGljYXRpb24gbmVlZHMgdG8gbWFr
ZSBtdWx0aXBsZSBuZXRsaW5rIGNhbGxzIHRvIHBhcnNlIHRoZSBjb25maWcgc3BhY2UuCgoKSSB0
aGluayB3ZSBkb24ndCBjYXJlIGFib3V0IHRoZSBwZXJmb3JtYW5jZSBpbiB0aGlzIGNhc2UuIEl0
J3MgYWJvdXQgCnRocmVlIG5ldGxpbmsgY2FsbHM6CgoxKSBnZXQgY29uZmlnCjIpIGdldCBkZXZp
Y2UgaWQKMykgZ2V0IGZlYXR1cmVzCgpGb3IgYnVpbGQgY29uZmlnLCBpdCdzIG9ubHkgb25lCgox
KSBidWlsZCBjb25maWcKCgo+IEkgcHJlZmVyIHRvIGZvbGxvdyByZXN0IG9mIHRoZSBrZXJuZWwg
c3R5bGUgdG8gcmV0dXJuIHNlbGYgY29udGFpbmVkIGludmlkaXZpZHVhbCBmaWVsZHMuCgoKQnV0
IEkgc2F3IGEgbG90IG9mIGtlcm5lbCBjb2RlcyBjaG9vc2UgdG8gdXNlIGUuZyBubGFfcHV0KCkg
ZGlyZWN0bHkgCndpdGggbW9kdWxlIHNwZWNpZmljIHN0cnVjdHVyZS4KClRoYW5rcwoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
