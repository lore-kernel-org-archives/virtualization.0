Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7070FEB64DA
	for <virtualization@archiver.kernel.org>; Wed, 28 Jun 2023 13:34:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C64A7417F7;
	Wed, 28 Jun 2023 13:34:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C64A7417F7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=STKDixlV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FIOhJWLWibme; Wed, 28 Jun 2023 13:34:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E72734180F;
	Wed, 28 Jun 2023 13:34:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E72734180F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BECDFC0072;
	Wed, 28 Jun 2023 13:34:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAC55C0037
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 13:34:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C37FC41831
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 13:34:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C37FC41831
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xKXMSB6e8NDT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 13:34:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A44C4180F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8A44C4180F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 13:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687959243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UH+6DzHmT9BOK6i8ZFFx7ObF6dyBrHM2rZAy+FrcXEQ=;
 b=STKDixlVrtFL9W1j1tlsasTGuVFdjyzqhfyxZAKvCWj81hKdIboIlzyU0EjC0gih1F5L7Y
 EDMuxGteZt9t7usX0xr82WEMLV8Fq/n0sFZTa9w3JCHeh36brQumNjE84PtmJ4rUg0Q22N
 I8CyJ1V/yDj5yWrW7+xk6mrl1NMio7g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-JoFbd2wLMfC2sUm9PpCfVw-1; Wed, 28 Jun 2023 09:33:51 -0400
X-MC-Unique: JoFbd2wLMfC2sUm9PpCfVw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f9b8c230f5so25709545e9.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 06:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687959230; x=1690551230;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UH+6DzHmT9BOK6i8ZFFx7ObF6dyBrHM2rZAy+FrcXEQ=;
 b=b10vtsSgYya97h/1MlIO3wa9Qcvwp5DxQsKwhBnvV3XXD0jV0GIgUkIQA4ovgI2VPG
 +PEuvMZ84nezWvRDoW+8H82oDbu8m1hi5CyDWfKBh402aGYJJWMEJYjESWJFIQqw9hYC
 djT0aImdWKfiV8ZYB1wKYVHw74KtQ8sC+JW3Ml0+eJAaKkg0LEreM602wfneRL3vH25l
 kGrMTBNZQ7mX/z9KdBEqWfkSYyaiC8lmdAWQsCXXpagOXVEwqYCPg3P9jciBMt6Sy+Va
 r4Xn6JcC0jCKExttu85Glf0oL/Wyk7sq6MQmiiEOVCyOG45EIlYkhvyoSwfgTQOGOmlw
 aLKg==
X-Gm-Message-State: AC+VfDw2PVVq3ZS2RpAG+adrGfDXRYzdq5ADYvhIcLG8oszUL+A00+Cx
 X4V5fWTA0U97ugVigK8wly4LCVlqYeXYMcsHSTVSrr5pXH5yO3JrYGqht3jONKW8D774Ot9bAJy
 GXO7V0kVkIFHWNr0MNbwn7A5fdQY4wtxeF0Uo76BQcA==
X-Received: by 2002:a7b:c38b:0:b0:3fa:93b0:a69c with SMTP id
 s11-20020a7bc38b000000b003fa93b0a69cmr6934350wmj.24.1687959230340; 
 Wed, 28 Jun 2023 06:33:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/tm490XfeHRJ5iUVZLicoUhEVOSF0007FXe0J1iKzXE2Icpx2jHf5tOV3kAL+rQUIgP4h9g==
X-Received: by 2002:a7b:c38b:0:b0:3fa:93b0:a69c with SMTP id
 s11-20020a7bc38b000000b003fa93b0a69cmr6934327wmj.24.1687959229902; 
 Wed, 28 Jun 2023 06:33:49 -0700 (PDT)
Received: from redhat.com ([2.52.153.110]) by smtp.gmail.com with ESMTPSA id
 z7-20020a05600c220700b003fa999cefc0sm8076525wml.36.2023.06.28.06.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 06:33:49 -0700 (PDT)
Date: Wed, 28 Jun 2023 09:33:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 net-next 1/2] virtio-net: convert rx mode setting to
 use workqueue
Message-ID: <20230628093334-mutt-send-email-mst@kernel.org>
References: <20230524081842.3060-1-jasowang@redhat.com>
 <20230524081842.3060-2-jasowang@redhat.com>
 <20230524050604-mutt-send-email-mst@kernel.org>
 <CACGkMEvm=MJz5e2C_7U=yjrvoo7pxsr=tRAL29OdxJDWhvtiSQ@mail.gmail.com>
 <20230525033750-mutt-send-email-mst@kernel.org>
 <CACGkMEtCA0-NY=qq_FnGzoY+VXmixGmBV3y80nZWO=NmxdRWmw@mail.gmail.com>
 <20230528073139-mutt-send-email-mst@kernel.org>
 <CACGkMEvcjjGRfNYeZaG0hS8R2fnpve62QFv_ReRTXxCUKwf36w@mail.gmail.com>
 <CACGkMEtgZ_=L2noqdADgNTr_E7s3adw=etvcFt3G7ZERQq43_g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtgZ_=L2noqdADgNTr_E7s3adw=etvcFt3G7ZERQq43_g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

T24gV2VkLCBNYXkgMzEsIDIwMjMgYXQgMDk6MDc6MjVBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBNb24sIE1heSAyOSwgMjAyMyBhdCA5OjIx4oCvQU0gSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gU3VuLCBNYXkgMjgsIDIwMjMgYXQgNzoz
OeKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+
ID4gPiBPbiBGcmksIE1heSAyNiwgMjAyMyBhdCAwOTozMTozNEFNICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+ID4gPiA+IE9uIFRodSwgTWF5IDI1LCAyMDIzIGF0IDM6NDHigK9QTSBNaWNoYWVs
IFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+ID4gPiBP
biBUaHUsIE1heSAyNSwgMjAyMyBhdCAxMTo0MzozNEFNICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+ID4gPiA+ID4gPiBPbiBXZWQsIE1heSAyNCwgMjAyMyBhdCA1OjE14oCvUE0gTWljaGFlbCBT
LiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiBPbiBXZWQsIE1heSAyNCwgMjAyMyBhdCAwNDoxODo0MVBNICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gVGhpcyBwYXRjaCBjb252ZXJ0IHJ4IG1vZGUgc2V0dGlu
ZyB0byBiZSBkb25lIGluIGEgd29ya3F1ZXVlLCB0aGlzIGlzCj4gPiA+ID4gPiA+ID4gPiBhIG11
c3QgZm9yIGFsbG93IHRvIHNsZWVwIHdoZW4gd2FpdGluZyBmb3IgdGhlIGN2cSBjb21tYW5kIHRv
Cj4gPiA+ID4gPiA+ID4gPiByZXNwb25zZSBzaW5jZSBjdXJyZW50IGNvZGUgaXMgZXhlY3V0ZWQg
dW5kZXIgYWRkciBzcGluIGxvY2suCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiA+ID4gPiA+ID4g
PiA+IC0tLQo+ID4gPiA+ID4gPiA+ID4gQ2hhbmdlcyBzaW5jZSBWMToKPiA+ID4gPiA+ID4gPiA+
IC0gdXNlIFJUTkwgdG8gc3luY2hyb25pemUgcnggbW9kZSB3b3JrZXIKPiA+ID4gPiA+ID4gPiA+
IC0tLQo+ID4gPiA+ID4gPiA+ID4gIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDU1ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0KPiA+ID4gPiA+ID4gPiA+ICAxIGZp
bGUgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
IGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gPiA+ID4gPiBpbmRleCA1NmNhMWQy
NzAzMDQuLjVkMmYxZGE0ZWFhMCAxMDA2NDQKPiA+ID4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4gPiA+ID4gPiA+ID4gPiBAQCAtMjY1LDYgKzI2NSwxMiBAQCBzdHJ1Y3QgdmlydG5l
dF9pbmZvIHsKPiA+ID4gPiA+ID4gPiA+ICAgICAgIC8qIFdvcmsgc3RydWN0IGZvciBjb25maWcg
c3BhY2UgdXBkYXRlcyAqLwo+ID4gPiA+ID4gPiA+ID4gICAgICAgc3RydWN0IHdvcmtfc3RydWN0
IGNvbmZpZ193b3JrOwo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ICsgICAgIC8qIFdv
cmsgc3RydWN0IGZvciBjb25maWcgcnggbW9kZSAqLwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gV2l0aCBhIGJpdCBsZXNzIGFiYnJldmlhdGlvbiBtYXliZT8gc2V0dGluZyByeCBtb2RlPwo+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBUaGF0J3MgZmluZS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gKyAgICAgc3RydWN0IHdvcmtfc3RydWN0IHJ4X21vZGVfd29y
azsKPiA+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gPiA+ICsgICAgIC8qIElzIHJ4IG1vZGUg
d29yayBlbmFibGVkPyAqLwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gVWdoIG5vdCBhIGdy
ZWF0IGNvbW1lbnQuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEFueSBzdWdnZXN0aW9ucyBmb3Ig
dGhpcy4gRS5nIHdlIGhhZDoKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gICAgICAgICAvKiBJcyBk
ZWxheWVkIHJlZmlsbCBlbmFibGVkPyAqLwo+ID4gPiA+ID4KPiA+ID4gPiA+IC8qIE9LIHRvIHF1
ZXVlIHdvcmsgc2V0dGluZyBSWCBtb2RlPyAqLwo+ID4gPiA+Cj4gPiA+ID4gT2suCj4gPiA+ID4K
PiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiArICAgICBi
b29sIHJ4X21vZGVfd29ya19lbmFibGVkOwo+ID4gPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gICAgICAgLyogRG9l
cyB0aGUgYWZmaW5pdHkgaGludCBpcyBzZXQgZm9yIHZpcnRxdWV1ZXM/ICovCj4gPiA+ID4gPiA+
ID4gPiAgICAgICBib29sIGFmZmluaXR5X2hpbnRfc2V0Owo+ID4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiA+IEBAIC0zODgsNiArMzk0LDIwIEBAIHN0YXRpYyB2b2lkIGRpc2FibGVfZGVsYXll
ZF9yZWZpbGwoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gPiA+ID4gPiA+ID4gPiAgICAgICBz
cGluX3VubG9ja19iaCgmdmktPnJlZmlsbF9sb2NrKTsKPiA+ID4gPiA+ID4gPiA+ICB9Cj4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gK3N0YXRpYyB2b2lkIGVuYWJsZV9yeF9tb2RlX3dv
cmsoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gPiA+ID4gPiA+ID4gPiArewo+ID4gPiA+ID4g
PiA+ID4gKyAgICAgcnRubF9sb2NrKCk7Cj4gPiA+ID4gPiA+ID4gPiArICAgICB2aS0+cnhfbW9k
ZV93b3JrX2VuYWJsZWQgPSB0cnVlOwo+ID4gPiA+ID4gPiA+ID4gKyAgICAgcnRubF91bmxvY2so
KTsKPiA+ID4gPiA+ID4gPiA+ICt9Cj4gPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gPiAr
c3RhdGljIHZvaWQgZGlzYWJsZV9yeF9tb2RlX3dvcmsoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkp
Cj4gPiA+ID4gPiA+ID4gPiArewo+ID4gPiA+ID4gPiA+ID4gKyAgICAgcnRubF9sb2NrKCk7Cj4g
PiA+ID4gPiA+ID4gPiArICAgICB2aS0+cnhfbW9kZV93b3JrX2VuYWJsZWQgPSBmYWxzZTsKPiA+
ID4gPiA+ID4gPiA+ICsgICAgIHJ0bmxfdW5sb2NrKCk7Cj4gPiA+ID4gPiA+ID4gPiArfQo+ID4g
PiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ID4gIHN0YXRpYyB2b2lkIHZpcnRxdWV1ZV9uYXBp
X3NjaGVkdWxlKHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwKPiA+ID4gPiA+ID4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmlydHF1ZXVlICp2cSkKPiA+ID4g
PiA+ID4gPiA+ICB7Cj4gPiA+ID4gPiA+ID4gPiBAQCAtMjM0MSw5ICsyMzYxLDExIEBAIHN0YXRp
YyBpbnQgdmlydG5ldF9jbG9zZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+ID4gPiA+ID4gPiA+
ID4gICAgICAgcmV0dXJuIDA7Cj4gPiA+ID4gPiA+ID4gPiAgfQo+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+IC1zdGF0aWMgdm9pZCB2aXJ0bmV0X3NldF9yeF9tb2RlKHN0cnVjdCBuZXRf
ZGV2aWNlICpkZXYpCj4gPiA+ID4gPiA+ID4gPiArc3RhdGljIHZvaWQgdmlydG5ldF9yeF9tb2Rl
X3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+ID4gPiA+ID4gPiA+ID4gIHsKPiA+ID4g
PiA+ID4gPiA+IC0gICAgIHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpID0gbmV0ZGV2X3ByaXYoZGV2
KTsKPiA+ID4gPiA+ID4gPiA+ICsgICAgIHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpID0KPiA+ID4g
PiA+ID4gPiA+ICsgICAgICAgICAgICAgY29udGFpbmVyX29mKHdvcmssIHN0cnVjdCB2aXJ0bmV0
X2luZm8sIHJ4X21vZGVfd29yayk7Cj4gPiA+ID4gPiA+ID4gPiArICAgICBzdHJ1Y3QgbmV0X2Rl
dmljZSAqZGV2ID0gdmktPmRldjsKPiA+ID4gPiA+ID4gPiA+ICAgICAgIHN0cnVjdCBzY2F0dGVy
bGlzdCBzZ1syXTsKPiA+ID4gPiA+ID4gPiA+ICAgICAgIHN0cnVjdCB2aXJ0aW9fbmV0X2N0cmxf
bWFjICptYWNfZGF0YTsKPiA+ID4gPiA+ID4gPiA+ICAgICAgIHN0cnVjdCBuZXRkZXZfaHdfYWRk
ciAqaGE7Cj4gPiA+ID4gPiA+ID4gPiBAQCAtMjM1Niw2ICsyMzc4LDggQEAgc3RhdGljIHZvaWQg
dmlydG5ldF9zZXRfcnhfbW9kZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+ID4gPiA+ID4gPiA+
ID4gICAgICAgaWYgKCF2aXJ0aW9faGFzX2ZlYXR1cmUodmktPnZkZXYsIFZJUlRJT19ORVRfRl9D
VFJMX1JYKSkKPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgcmV0dXJuOwo+ID4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+ICsgICAgIHJ0bmxfbG9jaygpOwo+ID4gPiA+ID4gPiA+ID4g
Kwo+ID4gPiA+ID4gPiA+ID4gICAgICAgdmktPmN0cmwtPnByb21pc2MgPSAoKGRldi0+ZmxhZ3Mg
JiBJRkZfUFJPTUlTQykgIT0gMCk7Cj4gPiA+ID4gPiA+ID4gPiAgICAgICB2aS0+Y3RybC0+YWxs
bXVsdGkgPSAoKGRldi0+ZmxhZ3MgJiBJRkZfQUxMTVVMVEkpICE9IDApOwo+ID4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPiA+IEBAIC0yMzczLDE0ICsyMzk3LDE5IEBAIHN0YXRpYyB2b2lkIHZp
cnRuZXRfc2V0X3J4X21vZGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiA+ID4gPiA+ID4gPiA+
ICAgICAgICAgICAgICAgZGV2X3dhcm4oJmRldi0+ZGV2LCAiRmFpbGVkIHRvICVzYWJsZSBhbGxt
dWx0aSBtb2RlLlxuIiwKPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgdmkt
PmN0cmwtPmFsbG11bHRpID8gImVuIiA6ICJkaXMiKTsKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gPiArICAgICBuZXRpZl9hZGRyX2xvY2tfYmgoZGV2KTsKPiA+ID4gPiA+ID4gPiA+ICsK
PiA+ID4gPiA+ID4gPiA+ICAgICAgIHVjX2NvdW50ID0gbmV0ZGV2X3VjX2NvdW50KGRldik7Cj4g
PiA+ID4gPiA+ID4gPiAgICAgICBtY19jb3VudCA9IG5ldGRldl9tY19jb3VudChkZXYpOwo+ID4g
PiA+ID4gPiA+ID4gICAgICAgLyogTUFDIGZpbHRlciAtIHVzZSBvbmUgYnVmZmVyIGZvciBib3Ro
IGxpc3RzICovCj4gPiA+ID4gPiA+ID4gPiAgICAgICBidWYgPSBremFsbG9jKCgodWNfY291bnQg
KyBtY19jb3VudCkgKiBFVEhfQUxFTikgKwo+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAoMiAqIHNpemVvZihtYWNfZGF0YS0+ZW50cmllcykpLCBHRlBfQVRPTUlDKTsKPiA+ID4g
PiA+ID4gPiA+ICAgICAgIG1hY19kYXRhID0gYnVmOwo+ID4gPiA+ID4gPiA+ID4gLSAgICAgaWYg
KCFidWYpCj4gPiA+ID4gPiA+ID4gPiArICAgICBpZiAoIWJ1Zikgewo+ID4gPiA+ID4gPiA+ID4g
KyAgICAgICAgICAgICBuZXRpZl9hZGRyX3VubG9ja19iaChkZXYpOwo+ID4gPiA+ID4gPiA+ID4g
KyAgICAgICAgICAgICBydG5sX3VubG9jaygpOwo+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAg
ICByZXR1cm47Cj4gPiA+ID4gPiA+ID4gPiArICAgICB9Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+ID4gICAgICAgc2dfaW5pdF90YWJsZShzZywgMik7Cj4gPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+ID4gQEAgLTI0MDEsNiArMjQzMCw4IEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfc2V0
X3J4X21vZGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiA+ID4gPiA+ID4gPiA+ICAgICAgIG5l
dGRldl9mb3JfZWFjaF9tY19hZGRyKGhhLCBkZXYpCj4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAg
ICAgIG1lbWNweSgmbWFjX2RhdGEtPm1hY3NbaSsrXVswXSwgaGEtPmFkZHIsIEVUSF9BTEVOKTsK
PiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiArICAgICBuZXRpZl9hZGRyX3VubG9ja19i
aChkZXYpOwo+ID4gPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ID4gICAgICAgc2dfc2V0X2J1
Zigmc2dbMV0sIG1hY19kYXRhLAo+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICBzaXpl
b2YobWFjX2RhdGEtPmVudHJpZXMpICsgKG1jX2NvdW50ICogRVRIX0FMRU4pKTsKPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBAQCAtMjQwOCw5ICsyNDM5LDE5IEBAIHN0YXRpYyB2b2lk
IHZpcnRuZXRfc2V0X3J4X21vZGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiA+ID4gPiA+ID4g
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVklSVElPX05FVF9DVFJMX01BQ19U
QUJMRV9TRVQsIHNnKSkKPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgZGV2X3dhcm4oJmRl
di0+ZGV2LCAiRmFpbGVkIHRvIHNldCBNQUMgZmlsdGVyIHRhYmxlLlxuIik7Cj4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gKyAgICAgcnRubF91bmxvY2soKTsKPiA+ID4gPiA+ID4gPiA+
ICsKPiA+ID4gPiA+ID4gPiA+ICAgICAgIGtmcmVlKGJ1Zik7Cj4gPiA+ID4gPiA+ID4gPiAgfQo+
ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ICtzdGF0aWMgdm9pZCB2aXJ0bmV0X3NldF9y
eF9tb2RlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4gPiA+ID4gPiA+ID4gPiArewo+ID4gPiA+
ID4gPiA+ID4gKyAgICAgc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBuZXRkZXZfcHJpdihkZXYp
Owo+ID4gPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ID4gKyAgICAgaWYgKHZpLT5yeF9tb2Rl
X3dvcmtfZW5hYmxlZCkKPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgc2NoZWR1bGVfd29y
aygmdmktPnJ4X21vZGVfd29yayk7Cj4gPiA+ID4gPiA+ID4gPiArfQo+ID4gPiA+ID4gPiA+ID4g
Kwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiAgc3RhdGljIGludCB2aXJ0bmV0X3ZsYW5f
cnhfYWRkX3ZpZChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4gPiA+ID4gPiA+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgX19iZTE2IHByb3RvLCB1MTYgdmlkKQo+ID4gPiA+
ID4gPiA+ID4gIHsKPiA+ID4gPiA+ID4gPiA+IEBAIC0zMTgxLDYgKzMyMjIsOCBAQCBzdGF0aWMg
dm9pZCB2aXJ0bmV0X2ZyZWV6ZV9kb3duKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ICAgICAgIC8qIE1ha2Ugc3VyZSBubyB3b3JrIGhh
bmRsZXIgaXMgYWNjZXNzaW5nIHRoZSBkZXZpY2UgKi8KPiA+ID4gPiA+ID4gPiA+ICAgICAgIGZs
dXNoX3dvcmsoJnZpLT5jb25maWdfd29yayk7Cj4gPiA+ID4gPiA+ID4gPiArICAgICBkaXNhYmxl
X3J4X21vZGVfd29yayh2aSk7Cj4gPiA+ID4gPiA+ID4gPiArICAgICBmbHVzaF93b3JrKCZ2aS0+
cnhfbW9kZV93b3JrKTsKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiAgICAgICBuZXRp
Zl90eF9sb2NrX2JoKHZpLT5kZXYpOwo+ID4gPiA+ID4gPiA+ID4gICAgICAgbmV0aWZfZGV2aWNl
X2RldGFjaCh2aS0+ZGV2KTsKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEhtbSBzbyBxdWV1
ZWQgcnggbW9kZSB3b3JrIHdpbGwganVzdCBnZXQgc2tpcHBlZAo+ID4gPiA+ID4gPiA+IGFuZCBv
biByZXN0b3JlIHdlIGdldCBhIHdyb25nIHJ4IG1vZGUuCj4gPiA+ID4gPiA+ID4gQW55IHdheSB0
byBtYWtlIHRoaXMgbW9yZSByb2J1c3Q/Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEl0IGNvdWxk
IGJlIGRvbmUgYnkgc2NoZWR1bGluZyBhIHdvcmsgb24gcmVzdG9yZS4KPiA+ID4gPgo+ID4gPiA+
IFJldGhpbmsgdGhpcywgSSB0aGluayB3ZSBkb24ndCBuZWVkIHRvIGNhcmUgYWJvdXQgdGhpcyBj
YXNlIHNpbmNlIHRoZQo+ID4gPiA+IHVzZXIgcHJvY2Vzc2VzIHNob3VsZCBoYXZlIGJlZW4gZnJv
emVuZWQuCj4gPiA+Cj4gPiA+IFllcyBidXQgbm90IHRoZSB3b3JrcXVldWUuIFdhbnQgdG8gc3dp
dGNoIHRvIHN5c3RlbV9mcmVlemFibGVfd3E/Cj4gPgo+ID4gWWVzLCBJIHdpbGwgZG8gaXQgaW4g
djIuCj4gCj4gQWN0dWFsbHksIHRoaXMgZG9lc24ndCB3b3JrLiBGcmVlemFibGUgd29ya3F1ZXVl
IGNhbiBvbmx5IGd1YXJhbnRlZQo+IHdoZW4gYmVpbmcgZnJlZXplZCB0aGUgbmV3IHdvcmsgd2ls
bCBiZSBxdWV1ZWQgYW5kIG5vdCBzY2hlZHVsZWQgdW50aWwKPiB0aGF3LiBTbyB0aGUga3RyaGVh
ZCB0aGF0IGlzIGV4ZWN1dGluZyB0aGUgd29ya3F1ZXVlIGlzIG5vdCBmcmVlemFibGUuCj4gVGhl
IGJ1c3kgbG9vcCAoZXZlbiB3aXRoIGNvbmRfcmVzY2hlZCgpKSB3aWxsIGZvcmNlIHN1c3BlbmQg
aW4gdGhpcwo+IGNhc2UuCj4gCj4gSSB3b25kZXIgaWYgd2Ugc2hvdWxkIHN3aXRjaCB0byB1c2lu
ZyBhIGRlZGljYXRlZCBrdGhyZWFkIGZvcgo+IHZpcnRpby1uZXQgdGhlbiB3ZSBjYW4gYWxsb3cg
aXQgdG8gYmUgZnJvemVuLgo+IAo+IFRoYW5rcwo+IAoKU28gd2hhdCdzIHRoZSBwbGFuIHRoZW4/
Cgo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+ID4KPiA+ID4gPiBBbmQgdGhhdCB0aGUgcmVhc29uIHdl
IGRvbid0Cj4gPiA+ID4gZXZlbiBuZWVkIHRvIGhvbGQgUlROTCBoZXJlLgo+ID4gPiA+Cj4gPiA+
ID4gVGhhbmtzCj4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4g
Pgo+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBA
QCAtMzIwMyw2ICszMjQ2LDcgQEAgc3RhdGljIGludCB2aXJ0bmV0X3Jlc3RvcmVfdXAoc3RydWN0
IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gPiA+ID4gPiA+ID4gPiAgICAgICB2aXJ0aW9fZGV2aWNl
X3JlYWR5KHZkZXYpOwo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ICAgICAgIGVuYWJs
ZV9kZWxheWVkX3JlZmlsbCh2aSk7Cj4gPiA+ID4gPiA+ID4gPiArICAgICBlbmFibGVfcnhfbW9k
ZV93b3JrKHZpKTsKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiAgICAgICBpZiAobmV0
aWZfcnVubmluZyh2aS0+ZGV2KSkgewo+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICBlcnIg
PSB2aXJ0bmV0X29wZW4odmktPmRldik7Cj4gPiA+ID4gPiA+ID4gPiBAQCAtNDAwMiw2ICs0MDQ2
LDcgQEAgc3RhdGljIGludCB2aXJ0bmV0X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2
KQo+ID4gPiA+ID4gPiA+ID4gICAgICAgdmRldi0+cHJpdiA9IHZpOwo+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+ICAgICAgIElOSVRfV09SSygmdmktPmNvbmZpZ193b3JrLCB2aXJ0bmV0
X2NvbmZpZ19jaGFuZ2VkX3dvcmspOwo+ID4gPiA+ID4gPiA+ID4gKyAgICAgSU5JVF9XT1JLKCZ2
aS0+cnhfbW9kZV93b3JrLCB2aXJ0bmV0X3J4X21vZGVfd29yayk7Cj4gPiA+ID4gPiA+ID4gPiAg
ICAgICBzcGluX2xvY2tfaW5pdCgmdmktPnJlZmlsbF9sb2NrKTsKPiA+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gPiAgICAgICBpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19O
RVRfRl9NUkdfUlhCVUYpKSB7Cj4gPiA+ID4gPiA+ID4gPiBAQCAtNDExMCw2ICs0MTU1LDggQEAg
c3RhdGljIGludCB2aXJ0bmV0X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4g
PiA+ID4gPiA+ID4gICAgICAgaWYgKHZpLT5oYXNfcnNzIHx8IHZpLT5oYXNfcnNzX2hhc2hfcmVw
b3J0KQo+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICB2aXJ0bmV0X2luaXRfZGVmYXVsdF9y
c3ModmkpOwo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ICsgICAgIGVuYWJsZV9yeF9t
b2RlX3dvcmsodmkpOwo+ID4gPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ID4gICAgICAgLyog
c2VyaWFsaXplIG5ldGRldiByZWdpc3RlciArIHZpcnRpb19kZXZpY2VfcmVhZHkoKSB3aXRoIG5k
b19vcGVuKCkgKi8KPiA+ID4gPiA+ID4gPiA+ICAgICAgIHJ0bmxfbG9jaygpOwo+ID4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+IEBAIC00MjA3LDYgKzQyNTQsOCBAQCBzdGF0aWMgdm9pZCB2
aXJ0bmV0X3JlbW92ZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiA+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4gPiAgICAgICAvKiBNYWtlIHN1cmUgbm8gd29yayBoYW5kbGVyIGlzIGFj
Y2Vzc2luZyB0aGUgZGV2aWNlLiAqLwo+ID4gPiA+ID4gPiA+ID4gICAgICAgZmx1c2hfd29yaygm
dmktPmNvbmZpZ193b3JrKTsKPiA+ID4gPiA+ID4gPiA+ICsgICAgIGRpc2FibGVfcnhfbW9kZV93
b3JrKHZpKTsKPiA+ID4gPiA+ID4gPiA+ICsgICAgIGZsdXNoX3dvcmsoJnZpLT5yeF9tb2RlX3dv
cmspOwo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ICAgICAgIHVucmVnaXN0ZXJfbmV0
ZGV2KHZpLT5kZXYpOwo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IC0tCj4gPiA+ID4g
PiA+ID4gPiAyLjI1LjEKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
