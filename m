Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AEECDB474
	for <virtualization@archiver.kernel.org>; Fri, 13 Oct 2023 02:50:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84D2C61502;
	Fri, 13 Oct 2023 02:50:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 84D2C61502
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KQuPwFGh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AF42sgfU7-Ie; Fri, 13 Oct 2023 02:50:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9E6E660FE4;
	Fri, 13 Oct 2023 02:50:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E6E660FE4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E3F5C0039;
	Fri, 13 Oct 2023 02:50:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 308E1C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 02:50:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0271A40146
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 02:50:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0271A40146
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KQuPwFGh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qtzkGfvFxofK
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 02:50:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A41A2400DA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 02:50:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A41A2400DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697165401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+5FuoAUO1vZjh0QIJ7411fph+3bIJecTmF2BuvxTUhQ=;
 b=KQuPwFGhd0Kju8LmDocDtvcKjEsM7C9czs/vVKjHBfT1R5T7DZdx6StZLYDOHvh0RvNIR+
 oUBfLfrBYN6HBr5fh972Lku41K01SBJ7QdnHk6ThaPqL6yOZEDpraT4dJCjmZ91AO2nFwQ
 j07r5NVykk9uxBJTS9vBYDNaMPPbl0Q=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-uIKBQCNeOyCTrIxptKsTWQ-1; Thu, 12 Oct 2023 22:49:59 -0400
X-MC-Unique: uIKBQCNeOyCTrIxptKsTWQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5041a779c75so1476201e87.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 19:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697165398; x=1697770198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+5FuoAUO1vZjh0QIJ7411fph+3bIJecTmF2BuvxTUhQ=;
 b=rNnoKX/3tKJcVK/Z1AD19SFcOr9DYkq3/aBxC/0dET7MUMGOOX/2r3C29mQla3LNXv
 p5V4O9uFA6TqL5iAHleu83gT8jF0wlpT29OFijnXoz4LbHscUx7QVhiBh17UK8gjHw48
 PivxOOQNb1GkuS3GY2a+xmnxF2F+M6isua/ynRdBoVXJodPf08PxFpN2FqvMWKwqBSqg
 g1sgZfeiju9acMoUg9QJZvHQ+cWS0EpP6B4RX/WnQb+g5WLsdmTB+eEwiMNKj4Km2Q23
 Ds98BpsOXBNNbGOPOgpSZgEmXVPp5/sVfDftlqdVRbnqz2jf64HpEXRQCQ4YhlqLNcml
 xiWQ==
X-Gm-Message-State: AOJu0YztA4tDMwwziFM4y664zwTcGUKuBiuOxcnRrQNGe69BfVTPMlGE
 GTkkOJG/PwgD1lraMq+DC4wXEOmDpKJUf6SpMXXCzQDzQIEwG+k29CpHl8USR6bsvM3KXFNX4Ty
 If4CaVfBXpwg+1GLxS+j9FwrOs2hJ+xKZN5dVCCugryesPg7p4GJP+0fQUg==
X-Received: by 2002:ac2:4a65:0:b0:500:c2d7:3ab4 with SMTP id
 q5-20020ac24a65000000b00500c2d73ab4mr19306003lfp.8.1697165398559; 
 Thu, 12 Oct 2023 19:49:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuyWlud6dJUVf6eUQGkFXb/2X27fcpZPK132CMGlMD3rfYyKfUG3wuXKXdFaK8jTXPnDawEZkCiisbaVSKO7A=
X-Received: by 2002:ac2:4a65:0:b0:500:c2d7:3ab4 with SMTP id
 q5-20020ac24a65000000b00500c2d73ab4mr19305996lfp.8.1697165398235; Thu, 12 Oct
 2023 19:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-2-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1696928580-7520-2-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Oct 2023 10:49:45 +0800
Message-ID: <CACGkMEt2vohDVG=BOpvn=7QgPiADgB93KoZ6xWwrO4T=Wgj6Pw@mail.gmail.com>
Subject: Re: [PATCH 1/4] vdpa: introduce .reset_map operation callback
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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

T24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgNTowNeKAr1BNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVA
b3JhY2xlLmNvbT4gd3JvdGU6Cj4KPiBEZXZpY2Ugc3BlY2lmaWMgSU9NTVUgcGFyZW50IGRyaXZl
ciB3aG8gd2lzaGVzIHRvIHNlZSBtYXBwaW5nIHRvIGJlCj4gZGVjb3VwbGVkIGZyb20gdmlydGlv
IG9yIHZkcGEgZGV2aWNlIGxpZmUgY3ljbGUgKGRldmljZSByZXNldCkgY2FuIHVzZQo+IGl0IHRv
IHJlc3RvcmUgbWVtb3J5IG1hcHBpbmcgaW4gdGhlIGRldmljZSBJT01NVSB0byB0aGUgaW5pdGlh
bCBvcgo+IGRlZmF1bHQgc3RhdGUuIFRoZSByZXNldCBvZiBtYXBwaW5nIGlzIGRvbmUgcGVyIGFk
ZHJlc3Mgc3BhY2UgYmFzaXMuCj4KPiBUaGUgcmVhc29uIHdoeSBhIHNlcGFyYXRlIC5yZXNldF9t
YXAgb3AgaXMgaW50cm9kdWNlZCBpcyBiZWNhdXNlIHRoaXMKPiBhbGxvd3MgYSBzaW1wbGUgb24t
Y2hpcCBJT01NVSBtb2RlbCB3aXRob3V0IGV4cG9zaW5nIHRvbyBtdWNoIGRldmljZQo+IGltcGxl
bWVudGF0aW9uIGRldGFpbHMgdG8gdGhlIHVwcGVyIHZkcGEgbGF5ZXIuIFRoZSAuZG1hX21hcC91
bm1hcCBvcgo+IC5zZXRfbWFwIGRyaXZlciBBUEkgaXMgbWVhbnQgdG8gYmUgdXNlZCB0byBtYW5p
cHVsYXRlIHRoZSBJT1RMQiBtYXBwaW5ncywKPiBhbmQgaGFzIGJlZW4gYWJzdHJhY3RlZCBpbiBh
IHdheSBzaW1pbGFyIHRvIGhvdyBhIHJlYWwgSU9NTVUgZGV2aWNlIG1hcHMKPiBvciB1bm1hcHMg
cGFnZXMgZm9yIGNlcnRhaW4gbWVtb3J5IHJhbmdlcy4gSG93ZXZlciwgYXBhcnQgZnJvbSB0aGlz
IHRoZXJlCj4gYWxzbyBleGlzdHMgb3RoZXIgbWFwcGluZyBuZWVkcywgaW4gd2hpY2ggY2FzZSAx
OjEgcGFzc3Rocm91Z2ggbWFwcGluZwo+IGhhcyB0byBiZSB1c2VkIGJ5IG90aGVyIHVzZXJzIChy
ZWFkIHZpcnRpby12ZHBhKS4gVG8gZWFzZSBwYXJlbnQvdmVuZG9yCj4gZHJpdmVyIGltcGxlbWVu
dGF0aW9uIGFuZCB0byBhdm9pZCBhYnVzaW5nIERNQSBvcHMgaW4gYW4gdW5leHBhY3RlZCB3YXks
Cj4gdGhlc2Ugb24tY2hpcCBJT01NVSBkZXZpY2VzIGNhbiBzdGFydCB3aXRoIDE6MSBwYXNzdGhy
b3VnaCBtYXBwaW5nIG1vZGUKPiBpbml0aWFsbHkgYXQgdGhlIGhlIHRpbWUgb2YgY3JlYXRpb24u
IFRoZW4gdGhlIC5yZXNldF9tYXAgb3AgY2FuIGJlIHVzZWQKPiB0byBzd2l0Y2ggaW90bGIgYmFj
ayB0byB0aGlzIGluaXRpYWwgc3RhdGUgd2l0aG91dCBoYXZpbmcgdG8gZXhwb3NlIGEKPiBjb21w
bGV4IHR3by1kaW1lbnNpb25hbCBJT01NVSBkZXZpY2UgbW9kZWwuCj4KPiBTaWduZWQtb2ZmLWJ5
OiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4gLS0tCj4gIGluY2x1ZGUvbGlu
dXgvdmRwYS5oIHwgMTAgKysrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9u
cygrKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVkZS9saW51
eC92ZHBhLmgKPiBpbmRleCBkMzc2MzA5Li4yNmFlNmFlIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUv
bGludXgvdmRwYS5oCj4gKysrIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiBAQCAtMzI3LDYgKzMy
NywxNSBAQCBzdHJ1Y3QgdmRwYV9tYXBfZmlsZSB7Cj4gICAqICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBAaW92YTogaW92YSB0byBiZSB1bm1hcHBlZAo+ICAgKiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgQHNpemU6IHNpemUgb2YgdGhlIGFyZWEKPiAgICogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFJldHVybnMgaW50ZWdlcjogc3VjY2VzcyAoMCkgb3IgZXJyb3IgKDwgMCkK
PiArICogQHJlc2V0X21hcDogICAgICAgICAgICAgICAgIFJlc2V0IGRldmljZSBtZW1vcnkgbWFw
cGluZyB0byB0aGUgZGVmYXVsdAo+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Rh
dGUgKG9wdGlvbmFsKQoKSSB0aGluayB3ZSBuZWVkIHRvIG1lbnRpb24gdGhhdCB0aGlzIGlzIGEg
bXVzdCBmb3IgcGFyZW50cyB0aGF0IHVzZSBzZXRfbWFwKCk/CgpPdGhlciB0aGFuIHRoaXM6CgpB
Y2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKPiArICog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5lZWRlZCBmb3IgZGV2aWNlcyB0aGF0IGFyZSB1
c2luZyBkZXZpY2UKPiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNwZWNpZmljIERN
QSB0cmFuc2xhdGlvbiBhbmQgcHJlZmVyIG1hcHBpbmcKPiArICogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHRvIGJlIGRlY291cGxlZCBmcm9tIHRoZSB2aXJ0aW8gbGlmZSBjeWNsZSwKPiAr
ICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIGkuZS4gZGV2aWNlIC5yZXNldCBvcCBkb2Vz
IG5vdCByZXNldCBtYXBwaW5nCj4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBAdmRl
djogdmRwYSBkZXZpY2UKPiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIEBhc2lkOiBh
ZGRyZXNzIHNwYWNlIGlkZW50aWZpZXIKPiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFJldHVybnMgaW50ZWdlcjogc3VjY2VzcyAoMCkgb3IgZXJyb3IgKDwgMCkKPiAgICogQGdldF92
cV9kbWFfZGV2OiAgICAgICAgICAgIEdldCB0aGUgZG1hIGRldmljZSBmb3IgYSBzcGVjaWZpYwo+
ICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmlydHF1ZXVlIChvcHRpb25hbCkKPiAg
ICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIEB2ZGV2OiB2ZHBhIGRldmljZQo+IEBAIC00
MDUsNiArNDE0LDcgQEAgc3RydWN0IHZkcGFfY29uZmlnX29wcyB7Cj4gICAgICAgICAgICAgICAg
ICAgICAgICB1NjQgaW92YSwgdTY0IHNpemUsIHU2NCBwYSwgdTMyIHBlcm0sIHZvaWQgKm9wYXF1
ZSk7Cj4gICAgICAgICBpbnQgKCpkbWFfdW5tYXApKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwg
dW5zaWduZWQgaW50IGFzaWQsCj4gICAgICAgICAgICAgICAgICAgICAgICAgIHU2NCBpb3ZhLCB1
NjQgc2l6ZSk7Cj4gKyAgICAgICBpbnQgKCpyZXNldF9tYXApKHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRldiwgdW5zaWduZWQgaW50IGFzaWQpOwo+ICAgICAgICAgaW50ICgqc2V0X2dyb3VwX2FzaWQp
KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdW5zaWduZWQgaW50IGdyb3VwLAo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBhc2lkKTsKPiAgICAgICAgIHN0cnVj
dCBkZXZpY2UgKigqZ2V0X3ZxX2RtYV9kZXYpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2
IGlkeCk7Cj4gLS0KPiAxLjguMy4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
