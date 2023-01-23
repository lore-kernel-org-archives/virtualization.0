Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE5FC25B50
	for <virtualization@archiver.kernel.org>; Mon, 23 Jan 2023 09:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A76A181F0D;
	Mon, 23 Jan 2023 09:53:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A76A181F0D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c7U7OZ+j
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0yIxG568bRwn; Mon, 23 Jan 2023 09:53:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3D06A81F07;
	Mon, 23 Jan 2023 09:53:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D06A81F07
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14201C0033;
	Mon, 23 Jan 2023 09:53:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5600AC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 09:53:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 35D8781F0D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 09:53:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35D8781F0D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ab0Ueu1BTHrm
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 09:53:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C32A381F07
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C32A381F07
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 09:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674467582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XGBr/F0XFzE0vVYozw1/BKRP3jPgyxC9gUjhQB9Xc7E=;
 b=c7U7OZ+jrczNzreyjnvOkM8sMgpFeX6jNteXxCfp7KlwTy1izzKtSQPunhtGn4NS5fWLKj
 3van3cy18e686LiQMDttW5LgkCEFXL+Dsq0DEgWC9VcYRu+933qe4p3CJ4q4nF4bYRbJfa
 e5+WfW32OIN2I/6h4t2gd5wfzXkxJog=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-653-T5mw1YMDNOOh8zyRbxSZPg-1; Mon, 23 Jan 2023 04:53:01 -0500
X-MC-Unique: T5mw1YMDNOOh8zyRbxSZPg-1
Received: by mail-qv1-f72.google.com with SMTP id
 ob12-20020a0562142f8c00b004c6c72bf1d0so5662686qvb.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 01:53:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XGBr/F0XFzE0vVYozw1/BKRP3jPgyxC9gUjhQB9Xc7E=;
 b=LY2K8Tf95Q2AmcqAZk7YScRHXOqC2rXC+UWicq0YSQELaxV+qaDvcrb4lF/kE9+9Kn
 sFNpBl3En5nxr9+xKeZ+TLkEdcCG0ceJFVNCi9Kl3lwE8CvgkmmfsjhAlACZfPaN63SQ
 TOST3PcCQwS/jC15DQdTOZatIWl+q188Xle9i2f6/9rtQIWpDV4a4Vq6r+UwMdaD4BR/
 +pGLrAN2wARvVVTlZdd5YpbfhXRh2Mp8uy9ppxfMdbbaqF8gsLOzeh4+xaf0z1vZNuPG
 SNVccykd6q2+ez9YciNYcKr2OzsCb8y9xIz1Xqx3GUPx2kGAHSJOdmkDdZ0DcxoDtQeS
 jT9g==
X-Gm-Message-State: AFqh2krpMLzoRI3DMEJP7JcBVogdOHYExEWDWueK+LoFPBTX4ZsWlPfL
 K8o7vB3Bpa+AhC8OPK5ji83L4G1BPYVKwxyBw8CwxO5aidlHJhwB6BiJ95zXUCE1oKnSgJsG209
 OUs+gQWmRsE8HBgDprJ4fVI2jlvAInNDSBdv64z0QXQ==
X-Received: by 2002:a05:6214:37c6:b0:532:35a1:af91 with SMTP id
 nj6-20020a05621437c600b0053235a1af91mr36780675qvb.27.1674467580910; 
 Mon, 23 Jan 2023 01:53:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtGVUKKbQfXcHL30rqUuIDlvGIgB5ckTck/POv0Vt/uPjVDeonGJ8IteOq2bZBAnoCEGaxYYg==
X-Received: by 2002:a05:6214:37c6:b0:532:35a1:af91 with SMTP id
 nj6-20020a05621437c600b0053235a1af91mr36780656qvb.27.1674467580648; 
 Mon, 23 Jan 2023 01:53:00 -0800 (PST)
Received: from [192.168.100.30] ([82.142.8.70])
 by smtp.gmail.com with ESMTPSA id
 g8-20020ae9e108000000b006b5cc25535fsm5651738qkm.99.2023.01.23.01.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jan 2023 01:53:00 -0800 (PST)
Message-ID: <8b80ac91-cf60-f5ff-a5dd-c5247c9c8f64@redhat.com>
Date: Mon, 23 Jan 2023 10:52:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/4] virtio_net: notify MAC address change on device
 initialization
To: Eli Cohen <elic@nvidia.com>, linux-kernel@vger.kernel.org
References: <20230122100526.2302556-1-lvivier@redhat.com>
 <20230122100526.2302556-2-lvivier@redhat.com>
 <07a24753-767b-4e1e-2bcf-21ec04bc044a@nvidia.com>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <07a24753-767b-4e1e-2bcf-21ec04bc044a@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Gautam Dawar <gautam.dawar@xilinx.com>,
 "David S. Miller" <davem@davemloft.net>
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

T24gMS8yMi8yMyAxNDo0NywgRWxpIENvaGVuIHdyb3RlOgo+IAo+IE9uIDIyLzAxLzIwMjMgMTI6
MDUsIExhdXJlbnQgVml2aWVyIHdyb3RlOgo+PiBJbiB2aXJ0bmV0X3Byb2JlKCksIGlmIHRoZSBk
ZXZpY2UgZG9lc24ndCBwcm92aWRlIGEgTUFDIGFkZHJlc3MgdGhlCj4+IGRyaXZlciBhc3NpZ25z
IGEgcmFuZG9tIG9uZS4KPj4gQXMgd2UgbW9kaWZ5IHRoZSBNQUMgYWRkcmVzcyB3ZSBuZWVkIHRv
IG5vdGlmeSB0aGUgZGV2aWNlIHRvIGFsbG93IGl0Cj4+IHRvIHVwZGF0ZSBhbGwgdGhlIHJlbGF0
ZWQgaW5mb3JtYXRpb24uCj4+Cj4+IFRoZSBwcm9ibGVtIGNhbiBiZSBzZWVuIHdpdGggdkRQQSBh
bmQgbWx4NV92ZHBhIGRyaXZlciBhcyBpdCBkb2Vzbid0Cj4+IGFzc2lnbiBhIE1BQyBhZGRyZXNz
IGJ5IGRlZmF1bHQuIFRoZSB2aXJ0aW9fbmV0IGRldmljZSB1c2VzIGEgcmFuZG9tCj4+IE1BQyBh
ZGRyZXNzICh3ZSBjYW4gc2VlIGl0IHdpdGggImlwIGxpbmsiKSwgYnV0IHdlIGNhbid0IHBpbmcg
YSBuZXQKPj4gbmFtZXNwYWNlIGZyb20gYW5vdGhlciBvbmUgdXNpbmcgdGhlIHZpcnRpby12ZHBh
IGRldmljZSBiZWNhdXNlIHRoZQo+PiBuZXcgTUFDIGFkZHJlc3MgaGFzIG5vdCBiZWVuIHByb3Zp
ZGVkIHRvIHRoZSBoYXJkd2FyZS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTGF1cmVudCBWaXZpZXIg
PGx2aXZpZXJAcmVkaGF0LmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
YyB8IDE0ICsrKysrKysrKysrKysrCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25z
KCspCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMKPj4gaW5kZXggNzcyM2IyYTQ5ZDhlLi4yNTUxMWE4NjU5MGUgMTAw
NjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+PiArKysgYi9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMKPj4gQEAgLTM4MDAsNiArMzgwMCw4IEBAIHN0YXRpYyBpbnQgdmlydG5l
dF9wcm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IGV0aF9od19hZGRyX3NldChkZXYsIGFkZHIpOwo+PiDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBldGhfaHdfYWRkcl9yYW5kb20oZGV2KTsKPj4gK8KgwqDCoMKgwqDC
oMKgIGRldl9pbmZvKCZ2ZGV2LT5kZXYsICJBc3NpZ25lZCByYW5kb20gTUFDIGFkZHJlc3MgJXBN
XG4iLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldi0+ZGV2X2FkZHIpOwo+PiDCoMKg
wqDCoMKgIH0KPj4gwqDCoMKgwqDCoCAvKiBTZXQgdXAgb3VyIGRldmljZS1zcGVjaWZpYyBpbmZv
cm1hdGlvbiAqLwo+PiBAQCAtMzk1Niw2ICszOTU4LDE4IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9w
cm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPj4gwqDCoMKgwqDCoCBwcl9kZWJ1Zygi
dmlydG5ldDogcmVnaXN0ZXJlZCBkZXZpY2UgJXMgd2l0aCAlZCBSWCBhbmQgVFggdnEnc1xuIiwK
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2LT5uYW1lLCBtYXhfcXVldWVfcGFpcnMpOwo+PiAr
wqDCoMKgIC8qIGEgcmFuZG9tIE1BQyBhZGRyZXNzIGhhcyBiZWVuIGFzc2lnbmVkLCBub3RpZnkg
dGhlIGRldmljZSAqLwo+PiArwqDCoMKgIGlmIChkZXYtPmFkZHJfYXNzaWduX3R5cGUgPT0gTkVU
X0FERFJfUkFORE9NICYmCj4gTWF5YmUgaXQncyBiZXR0ZXIgdG8gbm90IGNvdW50IG9uIGFkZHJf
YXNzaWduX3R5cGUgYW5kIHVzZSBhIGxvY2FsIHZhcmlhYmxlIHRvIGluZGljYXRlIAo+IHRoYXQg
dmlydG5ldF9wcm9iZSBhc3NpZ25lZCByYW5kb20gTUFDLiBUaGUgcmVhc29uIGlzIHRoYXQgdGhl
IGhhcmR3YXJlIGRyaXZlciBtaWdodCBoYXZlIAo+IGRvbmUgdGhhdCBhcyB3ZWxsIGFuZCBkb2Vz
IG5vdCBuZWVkIG5vdGlmaWNhdGlvbi4KCmV0aF9od19hZGRyX3JhbmRvbSgpIHNldHMgZXhwbGlj
aXRseSBORVRfQUREUl9SQU5ET00sIHdoaWxlIGV0aF9od19hZGRyX3NldCgpIGRvZXNuJ3QgCmNo
YW5nZSBhZGRyX2Fzc2lnbl90eXBlIHNvIGl0IGRvZXNuJ3Qgc2VlbSB0aGlzIHZhbHVlIGlzIHNl
dCBieSB0aGUgaGFyZHdhcmUgZHJpdmVyLgoKU28gSSBndWVzcyBpdCdzIHRoZSBkZWZhdWx0IHZh
bHVlIChORVRfQUREUl9QRVJNKSBpbiB0aGlzIGNhc2UgKGV2ZW4gaWYgaXQncyBhIHJhbmRvbSAK
YWRkcmVzcyBmcm9tIHRoZSBwb2ludCBvZiB2aWV3IG9mIHRoZSBoYXJkd2FyZSkuCgpJZiB5b3Ug
cHJlZmVyIEkgY2FuIHJlcGxhY2UgaXQgYnkgIiF2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklS
VElPX05FVF9GX01BQykiPwoKVGhhbmtzLApMYXVyZW50CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
