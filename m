Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3142FC433F5
	for <virtualization@archiver.kernel.org>; Mon, 16 May 2022 09:54:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC5814179D;
	Mon, 16 May 2022 09:54:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NYRPUcTab-Dn; Mon, 16 May 2022 09:54:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0E1F74177D;
	Mon, 16 May 2022 09:54:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE58EC0039;
	Mon, 16 May 2022 09:54:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF17BC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 09:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B7E9E8271A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 09:54:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TUOi-WKERXyh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 09:54:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C29382718
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 09:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652694871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ld6mQdfwnW4NQ/CCT9KrrgJoSZFj78t+Nv9HU2xhI2I=;
 b=SlbAW2LTaJFfGjbe9LmKtXc0aJadi6/ptqjCF/Vc1gLlDVEt5GrH4v8prWa2KE0jpNmIG+
 aiwhzjv5wR2K8VJtPGIXAk5PVJOqNO3Yxv85Y8lBs0/ZYzgWQnEkpVAunCPWz5+pAdlNRp
 n/cKasO7wB/j029yN7RJSfOKE1RMo+w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-114-cwS79kmlNnCoCxmXyiCVdA-1; Mon, 16 May 2022 05:54:30 -0400
X-MC-Unique: cwS79kmlNnCoCxmXyiCVdA-1
Received: by mail-wm1-f71.google.com with SMTP id
 q128-20020a1c4386000000b003942fe15835so6518883wma.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 02:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ld6mQdfwnW4NQ/CCT9KrrgJoSZFj78t+Nv9HU2xhI2I=;
 b=s4gw3KFlVPWByFXCPb6HQdMfswEi7YMac8XsyZ9IiqYKiaxuHb0baV6BSRNnFKcpLP
 liPbSO4WXXKreLueGX72MQ7SVcHDbgpQjXflnQ1quR1KToe0Ebu6eqNCq/Jx9kLDz3fv
 84rDK/PKa7S3NWMiRCYBCyPEUSmiaCdmvjP1uf/Xg05jP/X7OgofAK2cx8TqGnksiUV8
 5Rh34T8izGE++u8EznfvD7m9eDo7S7Kz5nv06qjl5GUqR4W7C4bobjrKpMc26C7lvU7Y
 HuvMmFGS6q0xPS9F3iY8QQfFLeufQM6b1HgwjuPT3V706N75NGIZPhkhGhCz9MBLb3RH
 nt2g==
X-Gm-Message-State: AOAM531sYCJ6CGqFiTwwQT31pPEk7Qwr9/St0PrFRMHKSKoziXZMjxvD
 EcqvXObDITUzCp4J0D1afVOm2WZp2Oifi78ovK6Kw/j91qGXEOUG2lshQGHEoe790alf9mGvAK3
 K4W8vy2xE2VEh3poQDGn3NPSuY4J0es8FmLpxPeHIqw==
X-Received: by 2002:a05:600c:15c6:b0:394:2cc6:6b with SMTP id
 v6-20020a05600c15c600b003942cc6006bmr15861045wmf.106.1652694869507; 
 Mon, 16 May 2022 02:54:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHUep3kZVQnQ0pEbHQndJ6wiJWBSXSuP4OlKw8uSGmSeF6WrRqSplNhF0tmCve9DlHRF0flA==
X-Received: by 2002:a05:600c:15c6:b0:394:2cc6:6b with SMTP id
 v6-20020a05600c15c600b003942cc6006bmr15861030wmf.106.1652694869306; 
 Mon, 16 May 2022 02:54:29 -0700 (PDT)
Received: from redhat.com ([2.55.141.66]) by smtp.gmail.com with ESMTPSA id
 j10-20020a05600c42ca00b003942a244ec9sm11138841wme.14.2022.05.16.02.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 02:54:28 -0700 (PDT)
Date: Mon, 16 May 2022 05:54:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v2 2/3] vdpa: Add a device object for vdpa management
 device
Message-ID: <20220516055356-mutt-send-email-mst@kernel.org>
References: <20220516060342.106-1-xieyongji@bytedance.com>
 <20220516060342.106-2-xieyongji@bytedance.com>
 <51811045-548c-1241-0a25-d23e8f7c9d1d@redhat.com>
 <CACycT3uoWjYjogi0H4yrA7GuKnY=djt6BmafoRB-rbmz+8Y4BA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3uoWjYjogi0H4yrA7GuKnY=djt6BmafoRB-rbmz+8Y4BA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Greg KH <gregkh@linuxfoundation.org>,
 virtualization <virtualization@lists.linux-foundation.org>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>, Eli Cohen <elic@nvidia.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCBNYXkgMTYsIDIwMjIgYXQgMDU6MzE6MjdQTSArMDgwMCwgWW9uZ2ppIFhpZSB3cm90
ZToKPiBPbiBNb24sIE1heSAxNiwgMjAyMiBhdCA1OjE0IFBNIEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+Cj4gPiDlnKggMjAyMi81LzE2IDE0OjAzLCBYaWUg
WW9uZ2ppIOWGmemBkzoKPiA+ID4gSW50cm9kdWNlIGEgZGV2aWNlIG9iamVjdCBmb3IgdmRwYSBt
YW5hZ2VtZW50IGRldmljZSB0byBjb250cm9sCj4gPiA+IGl0cyBsaWZlY3ljbGUuIEFuZCB0aGUg
ZGV2aWNlIG5hbWUgd2lsbCBiZSB1c2VkIHRvIG1hdGNoCj4gPiA+IFZEUEFfQVRUUl9NR01UREVW
X0RFVl9OQU1FIGZpZWxkIG9mIG5ldGxpbmsgbWVzc2FnZSByYXRoZXIgdGhhbgo+ID4gPiB1c2lu
ZyBwYXJlbnQgZGV2aWNlIG5hbWUuCj4gPiA+Cj4gPiA+IFdpdGggdGhpcyBwYXRjaCBhcHBsaWVk
LCBkcml2ZXJzIHNob3VsZCB1c2UgdmRwYV9tZ210ZGV2X2FsbG9jKCkKPiA+ID4gb3IgX3ZkcGFf
bWdtdGRldl9hbGxvYygpIHRvIGFsbG9jYXRlIGEgdkRQQSBtYW5hZ2VtZW50IGRldmljZQo+ID4g
PiBiZWZvcmUgY2FsbGluZyB2ZHBhX21nbXRkZXZfcmVnaXN0ZXIoKS4gQW5kIHNvbWUgYnVnZ3kg
ZW1wdHkKPiA+ID4gcmVsZWFzZSBmdW5jdGlvbiBjYW4gYWxzbyBiZSByZW1vdmVkIGZyb20gdGhl
IGRyaXZlciBjb2Rlcy4KPiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogWGllIFlvbmdqaSA8eGll
eW9uZ2ppQGJ5dGVkYW5jZS5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgIGRyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9tYWluLmMgICAgICB8IDExICsrLS0KPiA+ID4gICBkcml2ZXJzL3ZkcGEvbWx4NS9u
ZXQvbWx4NV92bmV0LmMgICAgfCAxMSArKy0tCj4gPiA+ICAgZHJpdmVycy92ZHBhL3ZkcGEuYyAg
ICAgICAgICAgICAgICAgIHwgOTIgKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQo+ID4gPiAg
IGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYyB8IDM5ICsrKystLS0tLS0tLQo+
ID4gPiAgIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9uZXQuYyB8IDQ2ICsrKysrLS0t
LS0tLS0tCj4gPiA+ICAgZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYyAgIHwgMzgg
KysrKy0tLS0tLS0tCj4gPiA+ICAgaW5jbHVkZS9saW51eC92ZHBhLmggICAgICAgICAgICAgICAg
IHwgMzggKysrKysrKysrKystCj4gPiA+ICAgNyBmaWxlcyBjaGFuZ2VkLCAxNjggaW5zZXJ0aW9u
cygrKSwgMTA3IGRlbGV0aW9ucygtKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMK
PiA+ID4gaW5kZXggNDM2NjMyMGZiNjhkLi5kNDA4N2MzN2NmZGYgMTAwNjQ0Cj4gPiA+IC0tLSBh
L2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPiA+ID4gKysrIGIvZHJpdmVycy92ZHBh
L2lmY3ZmL2lmY3ZmX21haW4uYwo+ID4gPiBAQCAtODIxLDEwICs4MjEsMTEgQEAgc3RhdGljIGlu
dCBpZmN2Zl9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwgY29uc3Qgc3RydWN0IHBjaV9kZXZp
Y2VfaWQgKmlkKQo+ID4gPiAgICAgICB1MzIgZGV2X3R5cGU7Cj4gPiA+ICAgICAgIGludCByZXQ7
Cj4gPiA+Cj4gPiA+IC0gICAgIGlmY3ZmX21nbXRfZGV2ID0ga3phbGxvYyhzaXplb2Yoc3RydWN0
IGlmY3ZmX3ZkcGFfbWdtdF9kZXYpLCBHRlBfS0VSTkVMKTsKPiA+ID4gLSAgICAgaWYgKCFpZmN2
Zl9tZ210X2Rldikgewo+ID4gPiArICAgICBpZmN2Zl9tZ210X2RldiA9IHZkcGFfbWdtdGRldl9h
bGxvYyhzdHJ1Y3QgaWZjdmZfdmRwYV9tZ210X2RldiwKPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgbWRldiwgZGV2X25hbWUoZGV2KSwgZGV2KTsKPiA+Cj4g
Pgo+ID4gSnVzdCB3b25kZXIgaWYgaXQncyBiZXR0ZXIgdG8gbWFrZSB2RFBBIGRldmljZSBhIGNo
aWxkIG9mIHRoZSBtZ210Cj4gPiBkZXZpY2UgaW5zdGVhZCBvZiB0aGUgUENJIGRldmljZT8KPiA+
Cj4gPiAoQ3VycmVudGx5IHdlIHVzZSBQQ0kgZGV2aWNlIGFzIHRoZSBwYXJlbnQgb2YgdGhlIHZE
UEEgZGV2aWNlLCBvciBhdAo+ID4gbGVhc3Qgd2UgY2FuIGRvIHRoaXMgZm9yIHRoZSBzaW11bGF0
b3Igd2hpY2ggZG9lc24ndCBoYXZlIGEgcGFyZW50PykKPiA+Cj4gCj4gTWFrZSBzZW5zZS4gSSB0
aGluayB3ZSBjYW4gZG8gaXQgZm9yIGFsbCB2RFBBIGRyaXZlcnMuIE1ha2Ugc3VyZSB0aGUKPiBw
YXJlbnQgb2YgdGhlIHZEUEEgZGV2aWNlIGlzIHRoZSB2RFBBIG1hbmFnZW1lbnQgZGV2aWNlLgo+
IAo+IFRoYW5rcywKPiBZb25namkKCgp0aGF0J3MgYW4gQUJJIGNoYW5nZSB0aG91Z2ggaXNuJ3Qg
aXQ/IHBhcmVudCBpcyBleHBvc2VkIGluIHN5c2ZzLApyaWdodD8KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
