Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33763C77B7D
	for <virtualization@archiver.kernel.org>; Tue, 16 May 2023 02:45:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9C4F740A15;
	Tue, 16 May 2023 02:45:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9C4F740A15
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=StAe0AYu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ze08Jg-Ja1AO; Tue, 16 May 2023 02:45:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0E84B400EC;
	Tue, 16 May 2023 02:45:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0E84B400EC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8F21C0037;
	Tue, 16 May 2023 02:45:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15D66C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 02:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DCA7460BAC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 02:45:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DCA7460BAC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=StAe0AYu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C693CM4fYiyb
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 02:45:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6921F60B48
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6921F60B48
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 02:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684205099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOtiAl8xEr+yF4q9V8Mv37+Ez0ZSu8GNo6YwcqTW6us=;
 b=StAe0AYuQxd+BqvTQdlkvBnbw5NlMYR0v/O3d4kXZC08tXgnsHdb1ezYR+ET3yqW6ebdEW
 cjLW9Are44cvA5PxgcKpHlQoqRvrM5jHQ0ypgm0BshxPBMDjqLsTT5YPmbEZQuys8tn50W
 /Z2o9HXTOoVii2Obahce12yrJmk6BIo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-YB3n52cmPviseJFjnwzANg-1; Mon, 15 May 2023 22:44:58 -0400
X-MC-Unique: YB3n52cmPviseJFjnwzANg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f225b6dbbbso6233309e87.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 19:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684205097; x=1686797097;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XOtiAl8xEr+yF4q9V8Mv37+Ez0ZSu8GNo6YwcqTW6us=;
 b=jwPiv2BwImGJKhTx8VH6c3i6lTLQFKtAQeHg8VuPEA+yKC4Sgs6JGFI80bA9ybJ1BF
 HPdUuNgVJDI9/XQ8lI5leVv+tdMxzfMjEjYt1CQMQn6+/rJL9tWNxpR/IuU9RpLAoieD
 oaAEPlflTkGRORK6Ts08FoGcn7lAKe82lpncXFpaYQUqYukZMUdOy+7mAyzbAQ8tuqOV
 UliZj38tUIzqGpIXVvgUpWy6UXQCC/m/OTLUzCx+jEDT+qb9RM/8SWE4tA/044GnYREY
 PVWog7L4wlVUPX15QHW8znp/0aHdZKT1nK6+872wnn88EbLGQRBB6snjkE/7NUfsdsEO
 L3oQ==
X-Gm-Message-State: AC+VfDxpvPpVSU1+RfoIf+FzdQFbns1PI0TeU/x7Nlg5VgCqDlAGmG6J
 jUiS5bvM1sMJt6p0ahOJYbhUuf36SXE1nB/boX7RMyOCf2ZIU9bSHZaXQ/M8VvyEnI8eJeDy7fH
 rWYDOoXsYosDkZlxnt7Ds6xos+lsKmDVAnnxbxs6IvrdD4w30ra+m+aIfWQ==
X-Received: by 2002:a05:6512:4ce:b0:4f1:4d8c:1d21 with SMTP id
 w14-20020a05651204ce00b004f14d8c1d21mr7882537lfq.61.1684205096827; 
 Mon, 15 May 2023 19:44:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6SX3NNInS5JM11CnSdd/RQUe4EjlvNV3aF41mBtFpvesjIsE4L2Uy2YEav+fOPTOaHB91hUPwXs99PQU4gbws=
X-Received: by 2002:a05:6512:4ce:b0:4f1:4d8c:1d21 with SMTP id
 w14-20020a05651204ce00b004f14d8c1d21mr7882521lfq.61.1684205096498; Mon, 15
 May 2023 19:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230413064027.13267-1-jasowang@redhat.com>
 <20230413064027.13267-2-jasowang@redhat.com>
 <20230413121525-mutt-send-email-mst@kernel.org>
 <CACGkMEunn1Z3n8yjVaWLqdV502yjaCBSAb_LO4KsB0nuxXmV8A@mail.gmail.com>
 <20230414031947-mutt-send-email-mst@kernel.org>
 <CACGkMEtutGn0CoJhoPHbzPuqoCLb4OCT6a_vB_WPV=MhwY0DXg@mail.gmail.com>
 <20230510012951-mutt-send-email-mst@kernel.org>
 <CACGkMEszPydzw_MOUOVJKBBW_8iYn66i_9OFvLDoZMH34hMx=w@mail.gmail.com>
 <20230515004422-mutt-send-email-mst@kernel.org>
 <CACGkMEv+Q2UoBarNOzKSrc3O=Wb2_73O2j9cZXFdAiLBm1qY-Q@mail.gmail.com>
 <20230515061455-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230515061455-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 May 2023 10:44:45 +0800
Message-ID: <CACGkMEt8QkK1PnTrRUjDbyJheBurdibr4--Es8P0Y9NZM659pQ@mail.gmail.com>
Subject: Re: [PATCH net-next V2 1/2] virtio-net: convert rx mode setting to
 use workqueue
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, edumazet@google.com, maxime.coquelin@redhat.com,
 kuba@kernel.org, pabeni@redhat.com, david.marchand@redhat.com,
 davem@davemloft.net
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

T24gTW9uLCBNYXkgMTUsIDIwMjMgYXQgNjoxN+KAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gTW9uLCBNYXkgMTUsIDIwMjMgYXQgMDE6MTM6MzNQ
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IE9uIE1vbiwgTWF5IDE1LCAyMDIzIGF0IDEy
OjQ14oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+
Cj4gPiA+IE9uIE1vbiwgTWF5IDE1LCAyMDIzIGF0IDA5OjA1OjU0QU0gKzA4MDAsIEphc29uIFdh
bmcgd3JvdGU6Cj4gPiA+ID4gT24gV2VkLCBNYXkgMTAsIDIwMjMgYXQgMTozM+KAr1BNIE1pY2hh
ZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4gPiA+
IE9uIE1vbiwgQXByIDE3LCAyMDIzIGF0IDExOjQwOjU4QU0gKzA4MDAsIEphc29uIFdhbmcgd3Jv
dGU6Cj4gPiA+ID4gPiA+IE9uIEZyaSwgQXByIDE0LCAyMDIzIGF0IDM6MjHigK9QTSBNaWNoYWVs
IFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+IE9uIEZyaSwgQXByIDE0LCAyMDIzIGF0IDAxOjA0OjE1UE0gKzA4MDAsIEphc29uIFdh
bmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiBGb3JnZXQgdG8gY2MgbmV0ZGV2LCBhZGRpbmcuCj4g
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gT24gRnJpLCBBcHIgMTQsIDIwMjMgYXQgMTI6
MjXigK9BTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gT24gVGh1LCBBcHIgMTMsIDIwMjMgYXQgMDI6
NDA6MjZQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGlz
IHBhdGNoIGNvbnZlcnQgcnggbW9kZSBzZXR0aW5nIHRvIGJlIGRvbmUgaW4gYSB3b3JrcXVldWUs
IHRoaXMgaXMKPiA+ID4gPiA+ID4gPiA+ID4gPiBhIG11c3QgZm9yIGFsbG93IHRvIHNsZWVwIHdo
ZW4gd2FpdGluZyBmb3IgdGhlIGN2cSBjb21tYW5kIHRvCj4gPiA+ID4gPiA+ID4gPiA+ID4gcmVz
cG9uc2Ugc2luY2UgY3VycmVudCBjb2RlIGlzIGV4ZWN1dGVkIHVuZGVyIGFkZHIgc3BpbiBsb2Nr
Lgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiA+ID4gSSBkb24ndCBsaWtlIHRoaXMgZnJhbmtseS4gVGhpcyBtZWFucyB0aGF0IHNl
dHRpbmcgUlggbW9kZSB3aGljaCB3b3VsZAo+ID4gPiA+ID4gPiA+ID4gPiBwcmV2aW91c2x5IGJl
IHJlbGlhYmxlLCBub3cgYmVjb21lcyB1bnJlbGlhYmxlLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiA+IEl0IGlzICJ1bnJlbGlhYmxlIiBieSBkZXNpZ246Cj4gPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+ID4gICAgICAgdm9pZCAgICAgICAgICAgICAgICAgICAgKCpuZG9fc2V0X3J4
X21vZGUpKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpOwo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+ID4gLSBmaXJzdCBvZiBhbGwgY29uZmlndXJhdGlvbiBpcyBubyBsb25nZXIgaW1tZWRp
YXRlCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gSXMgaW1tZWRpYXRlIGEgaGFyZCBy
ZXF1aXJlbWVudD8gSSBjYW4gc2VlIGEgd29ya3F1ZXVlIGlzIHVzZWQgYXQgbGVhc3Q6Cj4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gbWx4NWUsIGlwb2liLCBlZngsIC4uLgo+ID4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gICBhbmQgdGhlcmUgaXMgbm8gd2F5IGZvciBkcml2
ZXIgdG8gZmluZCBvdXQgd2hlbgo+ID4gPiA+ID4gPiA+ID4gPiAgIGl0IGFjdHVhbGx5IHRvb2sg
ZWZmZWN0Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gQnV0IHdlIGtub3cgcnggbW9k
ZSBpcyBiZXN0IGVmZm9ydCBlLmcgaXQgZG9lc24ndCBzdXBwb3J0IHZob3N0IGFuZCB3ZQo+ID4g
PiA+ID4gPiA+ID4gc3Vydml2ZSBmcm9tIHRoaXMgZm9yIHllYXJzLgo+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+ID4gLSBzZWNvbmQsIGlmIGRldmljZSBmYWlscyBjb21tYW5kLCB0aGlz
IGlzIGFsc28gbm90Cj4gPiA+ID4gPiA+ID4gPiA+ICAgcHJvcGFnYXRlZCB0byBkcml2ZXIsIGFn
YWluIG5vIHdheSBmb3IgZHJpdmVyIHRvIGZpbmQgb3V0Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gPiA+IFZEVVNFIG5lZWRzIHRvIGJlIGZpeGVkIHRvIGRvIHRyaWNrcyB0byBmaXgg
dGhpcwo+ID4gPiA+ID4gPiA+ID4gPiB3aXRob3V0IGJyZWFraW5nIG5vcm1hbCBkcml2ZXJzLgo+
ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IEl0J3Mgbm90IHNwZWNpZmljIHRvIFZEVVNF
LiBGb3IgZXhhbXBsZSwgd2hlbiB1c2luZyB2aXJ0aW8tbmV0IGluIHRoZQo+ID4gPiA+ID4gPiA+
ID4gVVAgZW52aXJvbm1lbnQgd2l0aCBhbnkgc29mdHdhcmUgY3ZxIChsaWtlIG1seDUgdmlhIHZE
UEEgb3IgY21hCj4gPiA+ID4gPiA+ID4gPiB0cmFuc3BvcnQpLgo+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gSG1tLiBDYW4g
d2UgZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIHRoZXNlIHVzZS1jYXNlcz8KPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gSXQgZG9lc24ndCBsb29rIGVhc3kgc2luY2Ugd2UgYXJlIGRyaXZlcnMgZm9yIHZp
cnRpbyBidXMuIFVuZGVybGF5ZXIKPiA+ID4gPiA+ID4gZGV0YWlscyB3ZXJlIGhpZGRlbiBmcm9t
IHZpcnRpby1uZXQuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IE9yIGRvIHlvdSBoYXZlIGFueSBp
ZGVhcyBvbiB0aGlzPwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+Cj4g
PiA+ID4gPiBJIGRvbid0IGtub3csIHBhc3Mgc29tZSBraW5kIG9mIGZsYWcgaW4gc3RydWN0IHZp
cnRxdWV1ZT8KPiA+ID4gPiA+ICAgICAgICAgImJvb2wgc2xvdzsgLyogVGhpcyB2cSBjYW4gYmUg
dmVyeSBzbG93IHNvbWV0aW1lcy4gRG9uJ3Qgd2FpdCBmb3IgaXQhICovIgo+ID4gPiA+ID4KPiA+
ID4gPiA+ID8KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBTbyBpZiBpdCdzIHNsb3csIHNsZWVw
LCBvdGhlcndpc2UgcG9sbD8KPiA+ID4gPgo+ID4gPiA+IEkgZmVlbCBzZXR0aW5nIHRoaXMgZmxh
ZyBtaWdodCBiZSB0cmlja3ksIHNpbmNlIHRoZSBkcml2ZXIgZG9lc24ndAo+ID4gPiA+IGtub3cg
d2hldGhlciBvciBub3QgaXQncyByZWFsbHkgc2xvdy4gRS5nIHNtYXJ0TklDIHZlbmRvciBtYXkg
YWxsb3cKPiA+ID4gPiB2aXJ0aW8tbmV0IGVtdWxhdGlvbiBvdmVyIFBDSS4KPiA+ID4gPgo+ID4g
PiA+IFRoYW5rcwo+ID4gPgo+ID4gPiBkcml2ZXIgd2lsbCBoYXZlIHRoZSBjaG9pY2UsIGRlcGVu
ZGluZyBvbiB3aGV0aGVyCj4gPiA+IHZxIGlzIGRldGVybWluaXN0aWMgb3Igbm90Lgo+ID4KPiA+
IE9rLCBidXQgdGhlIHByb2JsZW0gaXMsIHN1Y2ggYm9vbGVhbnMgYXJlIG9ubHkgdXNlZnVsIGZv
ciB2aXJ0aW8gcmluZwo+ID4gY29kZXMuIEJ1dCBpbiB0aGlzIGNhc2UsIHZpcnRpby1uZXQga25v
d3Mgd2hhdCB0byBkbyBmb3IgY3ZxLiBTbyBJJ20KPiA+IG5vdCBzdXJlIHdobyB0aGUgdXNlciBp
cy4KPiA+Cj4gPiBUaGFua3MKPgo+IENpcmNsaW5nIGJhY2ssIHdoYXQgZXhhY3RseSBkb2VzIHRo
ZSBhcmNoaXRlY3R1cmUgeW91IGFyZSB0cnlpbmcKPiB0byBmaXggbG9vayBsaWtlPyBXaG8gaXMg
Z29pbmcgdG8gaW50cm9kdWNlIHVuYm91bmRlZCBsYXRlbmN5Pwo+IFRoZSBoeXBlcnZpc29yPwoK
SHlwZXJ2aXNvciBpcyBvbmUgb2YgdGhlIHBvc3NpYmxlIHJlYXNvbiwgd2UgaGF2ZSBtYW55IG1v
cmU6CgpIYXJkd2FyZSBkZXZpY2UgdGhhdCBwcm92aWRlcyB2aXJ0aW8tcGNpIGVtdWxhdGlvbi4K
VXNlcnNwYWNlIGRldmljZXMgbGlrZSBWRFVTRS4KCj4gSWYgc28gZG8gd2Ugbm90IG1heWJlIHdh
bnQgYSBuZXcgZmVhdHVyZSBiaXQKPiB0aGF0IGRvY3VtZW50cyB0aGlzPyBIeXBlcnZpc29yIHRo
ZW4gY2FuIGRldGVjdCBvbGQgZ3Vlc3RzCj4gdGhhdCBzcGluIGFuZCBkZWNpZGUgd2hhdCB0byBk
bywgZS5nLiBwcmlvcml0aXNlIGN2cSBtb3JlLAo+IG9yIGZhaWwgRkVBVFVSRVNfT0suCgpXZSBz
dWZmZXIgZnJvbSB0aGlzIGZvciBiYXJlIG1ldGFsIGFzIHdlbGwuCgpCdXQgYSBxdWVzdGlvbiBp
cyB3aGF0J3Mgd3Jvbmcgd2l0aCB0aGUgYXBwcm9hY2ggdGhhdCBpcyB1c2VkIGluIHRoaXMKcGF0
Y2g/IEkndmUgYW5zd2VyZWQgdGhhdCBzZXRfcnhfbW9kZSBpcyBub3QgcmVsaWFibGUsIHNvIGl0
IHNob3VsZCBiZQpmaW5lIHRvIHVzZSB3b3JrcXVldWUuIEV4Y2VwdCBmb3IgdGhpcywgYW55IG90
aGVyIHRoaW5nIHRoYXQgd29ycmllcwp5b3U/CgpUaGFua3MKCj4KPiA+ID4KPiA+ID4KPiA+ID4g
PiA+IC0tCj4gPiA+ID4gPiBNU1QKPiA+ID4gPiA+Cj4gPiA+Cj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
