Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6E3C7618E
	for <virtualization@archiver.kernel.org>; Mon, 24 Apr 2023 03:50:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3F8C040586;
	Mon, 24 Apr 2023 03:50:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F8C040586
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bEnsfWsg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FmEszRKecAhd; Mon, 24 Apr 2023 03:50:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B9D4340133;
	Mon, 24 Apr 2023 03:50:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B9D4340133
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8859EC0037;
	Mon, 24 Apr 2023 03:50:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB4C5C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 03:50:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BCA8881A92
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 03:50:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BCA8881A92
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bEnsfWsg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pQE8mhTb3gFb
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 03:50:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 765C881A58
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 765C881A58
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 03:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682308234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jMETu2P8kRuIRQZtn8GfwhSKhpik+uD1nQI1zloF+7M=;
 b=bEnsfWsgmKr59pIiG8bffja9b+9b6YVgQXKbUIyxHHtxr59EG+DE9zaxeSS6Llv7ZEYUxa
 Ff6yafkOFpSetGqgQCSM08YW/d+a1o8QRuOId69IWCcw7EsJrY34fBO61bQa4DDdpfu6Sm
 gZWstqndZ7DLC4FV2PuYDM7mQ1CG2Fg=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-X6K_VouJNWWafSnAvPaeDA-1; Sun, 23 Apr 2023 23:50:32 -0400
X-MC-Unique: X6K_VouJNWWafSnAvPaeDA-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-38e1091707eso3672480b6e.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 20:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682308232; x=1684900232;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jMETu2P8kRuIRQZtn8GfwhSKhpik+uD1nQI1zloF+7M=;
 b=J3sbGSXUTyXnQ9RA/D56BOp5xLA7PGV4eJN1GOVkmDlq5h/V2Y1QJQWumP+NEq1qBy
 UlJXknT1UJqWRXqoamnZo9RhsVkKUdbjB3V4mlGpDLLbMAkJRqRCdiYFqrnm6rDx19O/
 NYub69JClWin9bwxAgyX1gGyh6HhKoTuLc94kKkncb1IIykqeCLQHDeuOWP2+DVRcD2s
 ymxdI/fGvval9zmhC6Lp4GqqJY8E0nX5rVRkMCH6QFzDa88iMKYLzGKRk5P61XH0PyoQ
 ZP8lPyr5SPneY2yZ4k6SLjRpHDDMo1U52prWGfJVIXcx7p5Rt7vg+9aItgzBQ0NkCGfe
 aAoQ==
X-Gm-Message-State: AAQBX9dUcUQ+q8izejI8j6Klmk+6W1dSQ0DCtBwKoIUqRf2fkdy/w7cI
 xoUnVMmTcwyeauCtMYuse6j8RGlv9lwDM7tcZiCW4qzRNw5C4zxR8frvOz72cuZfjchPOXm6UD1
 1EF4S9a2x17M2uXUEzEDJaXhUNp2Q8XXijYWfhyYgsym13xRZbdk63U+Z+Q==
X-Received: by 2002:a05:6808:b22:b0:38d:ee6e:236b with SMTP id
 t2-20020a0568080b2200b0038dee6e236bmr5978738oij.25.1682308232033; 
 Sun, 23 Apr 2023 20:50:32 -0700 (PDT)
X-Google-Smtp-Source: AKy350YhoblJsX6VGS203X+qKcauRI2i+QcYoZHhhMvk19Q5D5T3EYsSCJp5rKxF6etP4QgSc3gMe2cCCygqXPuFb4w=
X-Received: by 2002:a05:6808:b22:b0:38d:ee6e:236b with SMTP id
 t2-20020a0568080b2200b0038dee6e236bmr5978730oij.25.1682308231747; Sun, 23 Apr
 2023 20:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230331204854.20082-1-lingshan.zhu@intel.com>
 <CACGkMEstNJ1TJtTApniJLyN872gF9ZpAbj3hEKUw6yX3ZpPiFg@mail.gmail.com>
 <cf384aed-7ac4-02af-c2b5-b66c03a86aa9@intel.com>
 <c939205a-adc3-75eb-de16-617d6d001e18@intel.com>
In-Reply-To: <c939205a-adc3-75eb-de16-617d6d001e18@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Apr 2023 11:50:20 +0800
Message-ID: <CACGkMEsHDZAiOHi31gOV=OLF4sbQGY3sRLDkReQMmRAP322gBw@mail.gmail.com>
Subject: Re: [PATCH 0/5] vDPA/ifcvf: implement immediate initialization
 mechanism
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gVGh1LCBBcHIgMjAsIDIwMjMgYXQgNToxN+KAr1BNIFpodSwgTGluZ3NoYW4gPGxpbmdzaGFu
LnpodUBpbnRlbC5jb20+IHdyb3RlOgo+Cj4KPgo+IE9uIDQvMy8yMDIzIDY6MTAgUE0sIFpodSwg
TGluZ3NoYW4gd3JvdGU6Cj4gPgo+ID4KPiA+IE9uIDQvMy8yMDIzIDE6MjggUE0sIEphc29uIFdh
bmcgd3JvdGU6Cj4gPj4gT24gRnJpLCBNYXIgMzEsIDIwMjMgYXQgODo0OeKAr1BNIFpodSBMaW5n
c2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPiA+PiB3cm90ZToKPiA+Pj4gRm9ybWVybHks
IGlmY3ZmIGRyaXZlciBoYXMgaW1wbGVtZW50ZWQgYSBsYXp5LWluaXRpYWxpemF0aW9uIG1lY2hh
bmlzbQo+ID4+PiBmb3IgdGhlIHZpcnRxdWV1ZXMgYW5kIG90aGVyIGNvbmZpZyBzcGFjZSBjb250
ZW50cywKPiA+Pj4gaXQgd291bGQgc3RvcmUgYWxsIGNvbmZpZ3VyYXRpb25zIHRoYXQgcGFzc2Vk
IGRvd24gZnJvbSB0aGUgdXNlcnNwYWNlLAo+ID4+PiB0aGVuIGxvYWQgdGhlbSB0byB0aGUgZGV2
aWNlIGNvbmZpZyBzcGFjZSB1cG9uIERSSVZFUl9PSy4KPiA+Pj4KPiA+Pj4gVGhpcyBjYW4gbm90
IHNlcnZlIGxpdmUgbWlncmF0aW9uLCBzbyB0aGlzIHNlcmllcyBpbXBsZW1lbnQgYW4KPiA+Pj4g
aW1tZWRpYXRlIGluaXRpYWxpemF0aW9uIG1lY2hhbmlzbSwgd2hpY2ggbWVhbnMgcmF0aGVyIHRo
YW4gdGhlCj4gPj4+IGZvcm1lciBzdG9yZS1sb2FkIHByb2Nlc3MsIHRoZSB2aXJ0aW8gb3BlcmF0
aW9ucyBsaWtlIHZxIG9wcwo+ID4+PiB3b3VsZCB0YWtlIGltbWVkaWF0ZSBhY3Rpb25zIGJ5IGFj
Y2VzcyB0aGUgdmlydGlvIHJlZ2lzdGVycy4KPiA+PiBJcyB0aGVyZSBhbnkgY2hhbmNlIHRoYXQg
aWZjdmYgY2FuIHVzZSB2aXJ0aW9fcGNpX21vZGVybl9kZXYgbGlicmFyeT8KPiA+Pgo+ID4+IFRo
ZW4gd2UgZG9uJ3QgbmVlZCB0byBkdXBsaWNhdGUgdGhlIGNvZGVzLgo+ID4+Cj4gPj4gTm90ZSB0
aGF0IHBkc192ZHBhIHdpbGwgYmUgdGhlIHNlY29uZCB1c2VyIGZvciB2aXJ0aW9fcGNpX21vZGVy
bl9kZXYKPiA+PiBsaWJyYXJ5IChhbmQgdGhlIGZpcnN0IHZEUEEgcGFyZW50IHRvIHVzZSB0aGF0
IGxpYnJhcnkpLgo+ID4gWWVzIEkgYWdyZWUgdGhpcyBsaWJyYXJ5IGNhbiBoZWxwIGEgbG90IGZv
ciBhIHN0YW5kYXJkIHZpcnRpbyBwY2kgZGV2aWNlLgo+ID4gQnV0IHRoaXMgY2hhbmdlIHdvdWxk
IGJlIGh1Z2UsIGl0cyBsaWtlIHJlcXVpcmUgdG8gY2hhbmdlIGV2ZXJ5IGxpbmUgb2YKPiA+IHRo
ZSBkcml2ZXIuIEZvciBleGFtcGxlIGN1cnJlbnQgZHJpdmVyIGZ1bmN0aW9ucyB3b3JrIG9uIHRo
ZSBhZGFwdGVyIGFuZAo+ID4gaWZjdmZfaHcsIGlmIHdlIHdhbnRzIHRvIHJldXNlIHRoZSBsaWIs
IHdlIG5lZWQgdGhlIGRyaXZlciB3b3JrIG9uCj4gPiBzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5f
ZGV2aWNlLgo+ID4gQWxtb3N0IG5lZWQgdG8gcmUtd3JpdGUgdGhlIGRyaXZlci4KPiA+Cj4gPiBD
YW4gd2UgcGxhbiB0aGlzIGh1Z2UgY2hhbmdlIGluIGZvbGxvd2luZyBzZXJpZXM/Cj4gcGluZwoK
V2lsbCBnbyB0aHJvdWdoIHRoaXMgdGhpcyB3ZWVrLgoKVGhhbmtzCgo+ID4KPiA+IFRoYW5rcywK
PiA+IFpodSBMaW5nc2hhbgo+ID4+Cj4gPj4gVGhhbmtzCj4gPj4KPiA+Pj4gVGhpcyBzZXJpZXMg
YWxzbyBpbXBsZW1lbnQgaXJxIHN5bmNocm9uaXphdGlvbiBpbiB0aGUgcmVzZXQKPiA+Pj4gcm91
dGluZQo+ID4+Pgo+ID4+PiBaaHUgTGluZ3NoYW4gKDUpOgo+ID4+PiAgICB2aXJ0IHF1ZXVlIG9w
cyB0YWtlIGltbWVkaWF0ZSBhY3Rpb25zCj4gPj4+ICAgIGdldF9kcml2ZXJfZmVhdHVyZXMgZnJv
bSB2aXJpdG8gcmVnaXN0ZXJzCj4gPj4+ICAgIHJldGlyZSBpZmN2Zl9zdGFydF9kYXRhcGF0aCBh
bmQgaWZjdmZfYWRkX3N0YXR1cwo+ID4+PiAgICBzeW5jaHJvbml6ZSBpcnFzIGluIHRoZSByZXNl
dCByb3V0aW5lCj4gPj4+ICAgIGEgdmVuZG9yIGRyaXZlciBzaG91bGQgbm90IHNldCBfQ09ORklH
X1NfRkFJTEVECj4gPj4+Cj4gPj4+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYyB8
IDE2Mgo+ID4+PiArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQo+ID4+PiAgIGRyaXZl
cnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggfCAgMTYgKystLQo+ID4+PiAgIGRyaXZlcnMvdmRw
YS9pZmN2Zi9pZmN2Zl9tYWluLmMgfCAgOTcgKysrKy0tLS0tLS0tLS0tLS0tLQo+ID4+PiAgIDMg
ZmlsZXMgY2hhbmdlZCwgMTIyIGluc2VydGlvbnMoKyksIDE1MyBkZWxldGlvbnMoLSkKPiA+Pj4K
PiA+Pj4gLS0KPiA+Pj4gMi4zOS4xCj4gPj4+Cj4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
