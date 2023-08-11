Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A4AEB64DD
	for <virtualization@archiver.kernel.org>; Fri, 11 Aug 2023 05:42:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98A5E83BA7;
	Fri, 11 Aug 2023 05:42:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 98A5E83BA7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dXux5zX1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VkRBAhMeCR7b; Fri, 11 Aug 2023 05:42:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C51F6820CF;
	Fri, 11 Aug 2023 05:42:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C51F6820CF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D191C0072;
	Fri, 11 Aug 2023 05:42:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8603C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 05:42:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D49641E06
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 05:42:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D49641E06
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dXux5zX1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iCrO0zqNNOZU
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 05:42:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4696541BBC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 05:42:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4696541BBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691732531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FeOvN75tWxQhwMQjRUNg3DV6YRE1tdWFw7PsggN2KNo=;
 b=dXux5zX1BRBHG4u7IHxTKtEL8Cay8sHgbeWEWJ/vBBgMqtzsXqcpphh+0A+XvLcgC200kN
 5EU/eCrkm4WTMdiyLvlbDCMmSzOfStS+E3iCmAWR56JrG3lTT8mB1/mjlt9SfRIpnUTC1/
 fvDZu6q6vlPyyF7cT8BEq3EwozXebzc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-Y4cXk8m5MdKvKmwh4PEj-w-1; Fri, 11 Aug 2023 01:42:09 -0400
X-MC-Unique: Y4cXk8m5MdKvKmwh4PEj-w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe182913c5so10161315e9.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 22:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691732528; x=1692337328;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FeOvN75tWxQhwMQjRUNg3DV6YRE1tdWFw7PsggN2KNo=;
 b=DuGGHpIHWjGC/ytRibj035tqg0iWU2hXUUo2BJAKO6PoRgHa0GsOCj2V57Rc3IVUtH
 JwXENB+b7JDctWUobyR9idM1Q8njjjyaZpv9g59r8/TNur8ej80Gf4/WtVmM4fcsC4Tq
 p9X9pT3LR30AGOMfRTGE+6b4OwBM5DL8WCy5mCBYdHv22tbWHZ4r1xPRZgZFLz5HupeP
 20lLSEvq4OhwFnJYDcPmGG7R972yQBtQvDFWBEIcSE/9DJwbItHyvGTtO49Y7UhgfJAv
 /8zqPKd2ClgZthsTpjLsepi7gyuWOYgU+PCzHRlBD0jG4GkwBTADzoRaFovRa+RR1a5B
 NL1Q==
X-Gm-Message-State: AOJu0YxN/tfQOMCnyKZ7SLx5ZhZ8+Fb4FBd4M+mu8IYUthlAlj2sJzNQ
 42IagjSLeHAiMxky/yDO6AXPHkynP1FBY9oG7atmJjkv6p/y5APIUAtxEMouTaPxM+cAie4hiQu
 f4XmeqbhbGUJbotXf2FHHPw04NKZWnT9B8rROpucfig==
X-Received: by 2002:a5d:4dce:0:b0:315:ad1a:5abc with SMTP id
 f14-20020a5d4dce000000b00315ad1a5abcmr560347wru.5.1691732528059; 
 Thu, 10 Aug 2023 22:42:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGChBTfjXHd170xzQjiykK6EKOoZmHX+FMr/7ZWK7WQpPsGbiHHN5KVtW18EcCe7s909p9kg==
X-Received: by 2002:a5d:4dce:0:b0:315:ad1a:5abc with SMTP id
 f14-20020a5d4dce000000b00315ad1a5abcmr560328wru.5.1691732527474; 
 Thu, 10 Aug 2023 22:42:07 -0700 (PDT)
Received: from redhat.com ([2.55.42.146]) by smtp.gmail.com with ESMTPSA id
 r10-20020a5d52ca000000b003140fff4f75sm4279428wrv.17.2023.08.10.22.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 22:42:06 -0700 (PDT)
Date: Fri, 11 Aug 2023 01:42:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230811012147-mutt-send-email-mst@kernel.org>
References: <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
 <20230726073453-mutt-send-email-mst@kernel.org>
 <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
 <20230727020930-mutt-send-email-mst@kernel.org>
 <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
 <20230727054300-mutt-send-email-mst@kernel.org>
 <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
 <CACGkMEs6ambtfdS+X_9LF7yCKqmwL73yjtD_UabTcdQDFiF3XA@mail.gmail.com>
 <20230810153744-mutt-send-email-mst@kernel.org>
 <CACGkMEvVg0KFMcYoKx0ZCCEABsP4TrQCJOUqTn6oHO4Q3aEJ4w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvVg0KFMcYoKx0ZCCEABsP4TrQCJOUqTn6oHO4Q3aEJ4w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, edumazet@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

T24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgMTA6MjM6MTVBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBGcmksIEF1ZyAxMSwgMjAyMyBhdCAzOjQx4oCvQU0gTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gVHVlLCBBdWcgMDgsIDIwMjMgYXQg
MTA6MzA6NTZBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gT24gTW9uLCBKdWwgMzEs
IDIwMjMgYXQgMjozMOKAr1BNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3Rl
Ogo+ID4gPiA+Cj4gPiA+ID4gT24gVGh1LCBKdWwgMjcsIDIwMjMgYXQgNTo0NuKAr1BNIE1pY2hh
ZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4gPiA+
IE9uIFRodSwgSnVsIDI3LCAyMDIzIGF0IDA0OjU5OjMzUE0gKzA4MDAsIEphc29uIFdhbmcgd3Jv
dGU6Cj4gPiA+ID4gPiA+ID4gVGhleSByZWFsbHkgc2hvdWxkbid0IC0gYW55IE5JQyB0aGF0IHRh
a2VzIGZvcmV2ZXIgdG8KPiA+ID4gPiA+ID4gPiBwcm9ncmFtIHdpbGwgY3JlYXRlIGlzc3VlcyBp
biB0aGUgbmV0d29ya2luZyBzdGFjay4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVW5mb3J0dW5h
dGVseSwgaXQncyBub3QgcmFyZSBhcyB0aGUgZGV2aWNlL2N2cSBjb3VsZCBiZSBpbXBsZW1lbnRl
ZAo+ID4gPiA+ID4gPiB2aWEgZmlybXdhcmUgb3Igc29mdHdhcmUuCj4gPiA+ID4gPgo+ID4gPiA+
ID4gQ3VycmVudGx5IHRoYXQgbWVhbiBvbmUgZWl0aGVyIGhhcyBzYW5lIGZpcm13YXJlIHdpdGgg
YSBzY2hlZHVsZXIgdGhhdAo+ID4gPiA+ID4gY2FuIG1lZXQgZGVhZGxpbmVzLCBvciBsb3NlcyBh
YmlsaXR5IHRvIHJlcG9ydCBlcnJvcnMgYmFjay4KPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gQnV0
IGlmIHRoZXkgZG8gdGhleSBjYW4gYWx3YXlzIHNldCB0aGlzIGZsYWcgdG9vLgo+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiBUaGlzIG1heSBoYXZlIGZhbHNlIG5lZ2F0aXZlcyBhbmQgbWF5IGNvbmZ1
c2UgdGhlIG1hbmFnZW1lbnQuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IE1heWJlIHdlIGNhbiBl
eHRlbmQgdGhlIG5ldHdvcmtpbmcgY29yZSB0byBhbGxvdyBzb21lIGRldmljZSBzcGVjaWZpYwo+
ID4gPiA+ID4gPiBjb25maWd1cmF0aW9ucyB0byBiZSBkb25lIHdpdGggZGV2aWNlIHNwZWNpZmlj
IGxvY2sgd2l0aG91dCBydG5sLiBGb3IKPiA+ID4gPiA+ID4gZXhhbXBsZSwgc3BsaXQgdGhlIHNl
dF9jaGFubmVscyB0bwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBwcmVfc2V0X2NoYW5uZWxzCj4g
PiA+ID4gPiA+IHNldF9jaGFubmVscwo+ID4gPiA+ID4gPiBwb3N0X3NldF9jaGFubmVscwo+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiBUaGUgZGV2aWNlIHNwZWNpZmljIHBhcnQgY291bGQgYmUgZG9u
ZSBpbiBwcmUgYW5kIHBvc3Qgd2l0aG91dCBhIHJ0bmwgbG9jaz8KPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gVGhhbmtzCj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IFdvdWxkIHRoZSBiZW5l
Zml0IGJlIHRoYXQgZXJyb3JzIGNhbiBiZSByZXBvcnRlZCB0byB1c2Vyc3BhY2UgdGhlbj8KPiA+
ID4gPiA+IFRoZW4gbWF5YmUuICBJIHRoaW5rIHlvdSB3aWxsIGhhdmUgdG8gc2hvdyBob3cgdGhp
cyB3b3JrcyBmb3IgYXQgbGVhc3QKPiA+ID4gPiA+IG9uZSBjYXJkIGJlc2lkZXMgdmlydGlvLgo+
ID4gPiA+Cj4gPiA+ID4gRXZlbiBmb3IgdmlydGlvLCB0aGlzIHNlZW1zIG5vdCBlYXN5LCBhcyBl
LmcgdGhlCj4gPiA+ID4gdmlydG5ldF9zZW5kX2NvbW1hbmQoKSBhbmQgbmV0aWZfc2V0X3JlYWxf
bnVtX3R4X3F1ZXVlcygpIG5lZWQgdG8KPiA+ID4gPiBhcHBlYXIgdG8gYmUgYXRvbWljIHRvIHRo
ZSBuZXR3b3JraW5nIGNvcmUuCj4gPiA+ID4KPiA+ID4gPiBJIHdvbmRlciBpZiB3ZSBjYW4gcmUt
Y29uc2lkZXIgdGhlIHdheSBvZiBhIHRpbWVvdXQgaGVyZSBhbmQgY2hvb3NlIGEKPiA+ID4gPiBz
YW5lIHZhbHVlIGFzIGEgc3RhcnQuCj4gPiA+Cj4gPiA+IE1pY2hhZWwsIGFueSBtb3JlIGlucHV0
IG9uIHRoaXM/Cj4gPiA+Cj4gPiA+IFRoYW5rcwo+ID4KPiA+IEkgdGhpbmsgdGhpcyBpcyBqdXN0
IG1pc3Npb24gY3JlZXAuIFdlIGFyZSB0cnlpbmcgdG8gZml4Cj4gPiB2ZHVzZSAtIGxldCdzIGRv
IHRoYXQgZm9yIHN0YXJ0ZXJzLgo+ID4KPiA+IFJlY292ZXJpbmcgZnJvbSBmaXJtd2FyZSB0aW1l
b3V0cyBpcyBmYXIgZnJvbSB0cml2aWFsIGFuZAo+ID4ganVzdCBhc3N1bWluZyB0aGF0IGp1c3Qg
YmVjYXVzZSBpdCB0aW1lZCBvdXQgaXQgd2lsbCBub3QKPiA+IGFjY2VzcyBtZW1vcnkgaXMganVz
dCBhcyBsaWtlbHkgdG8gY2F1c2UgbWVtb3J5IGNvcnJ1cHRpb24KPiA+IHdpdGggd29yc2UgcmVz
dWx0cyB0aGFuIGFuIGluZmluaXRlIHNwaW4uCj4gCj4gWWVzLCB0aGlzIG1pZ2h0IHJlcXVpcmUg
c3VwcG9ydCBub3Qgb25seSBpbiB0aGUgZHJpdmVyCj4gCj4gPgo+ID4gSSBwcm9wb3NlIHdlIGZp
eCB0aGlzIGZvciB2ZHVzZSBhbmQgYXNzdW1lIGhhcmR3YXJlL2Zpcm13YXJlCj4gPiBpcyB3ZWxs
IGJlaGF2ZWQuCj4gCj4gT25lIG1ham9yIGNhc2UgaXMgdGhlIHJlLWNvbm5lY3Rpb24sIGluIHRo
YXQgY2FzZSBpdCBtaWdodCB0YWtlCj4gd2hhdGV2ZXIgbG9uZ2VyIHRoYXQgdGhlIGtlcm5lbCB2
aXJpdG8tbmV0IGRyaXZlciBleHBlY3RzLgo+IFNvIHdlIGNhbiBoYXZlIGEgdGltZW91dCBpbiBW
RFVTRSBhbmQgdHJhcCBDVlEgdGhlbiBWRFVTRSBjYW4gcmV0dXJuCj4gYW5kIGZhaWwgZWFybHk/
CgpVZ2ggbW9yZSBtaXNzaW9uIGNyZWVwLiBub3QgYXQgYWxsIG15IHBvaW50LiB2ZHVzZSBzaG91
bGQgY2FjaGUKdmFsdWVzIGluIHRoZSBkcml2ZXIsIHVudGlsIHNvbWVvbmUgbWFuYWdlcyB0byBj
aGFuZ2UKbmV0IGNvcmUgdG8gYmUgbW9yZSBmcmllbmRseSB0byB1c2Vyc3BhY2UgZGV2aWNlcy4K
Cj4gCj4gPiBPciBtYXliZSBub3Qgd2VsbCBiZWhhdmVkIGZpcm13YXJlIHdpbGwKPiA+IHNldCB0
aGUgZmxhZyBsb3NpbmcgZXJyb3IgcmVwb3J0aW5nIGFiaWxpdHkuCj4gCj4gVGhpcyBtaWdodCBi
ZSBoYXJkIHNpbmNlIGl0IG1lYW5zIG5vdCBvbmx5IHRoZSBzZXQgYnV0IGFsc28gdGhlIGdldCBp
cwo+IHVucmVsaWFibGUuCj4gCj4gVGhhbmtzCgovbWUgc2hydWdzCgoKCj4gPgo+ID4KPiA+Cj4g
PiA+ID4KPiA+ID4gPiBUaGFua3MKPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4g
PiAtLQo+ID4gPiA+ID4gTVNUCj4gPiA+ID4gPgo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
