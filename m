Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F223C77B7C
	for <virtualization@archiver.kernel.org>; Sun, 28 May 2023 11:39:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8752C41BC3;
	Sun, 28 May 2023 11:39:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8752C41BC3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WwdH+Lyc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iq5CRgEim_5f; Sun, 28 May 2023 11:39:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7483441BA5;
	Sun, 28 May 2023 11:39:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7483441BA5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45FAFC0035;
	Sun, 28 May 2023 11:39:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE403C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 11:39:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AB7B0837D3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 11:39:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB7B0837D3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WwdH+Lyc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6YU5-p1KzNW7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 11:39:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A37ED837C9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A37ED837C9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 11:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685273987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pdnj1pt/Ew4vLKQkc9gKCuhrb53B3dG9FTP2qOaE8pc=;
 b=WwdH+Lyco1Qz57Y20r7fWKhFm4DfYpGAvhTLoyhHRsb2CXVG2OikA2nqvE/llrSC/m8G/S
 aG+pfHigm561ricXn13fdQz1lZR4orbHyn4VsuZaP4j0JC4Pgd2wED49Vc3FtRj3lWSTb0
 nXFM0cOdmGQ4td8aTibTApOAZoF3M60=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-pTmG7RaQNIC2RDlrD2fu8A-1; Sun, 28 May 2023 07:39:45 -0400
X-MC-Unique: pTmG7RaQNIC2RDlrD2fu8A-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30a88ed463eso784365f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 04:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685273984; x=1687865984;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pdnj1pt/Ew4vLKQkc9gKCuhrb53B3dG9FTP2qOaE8pc=;
 b=krybJrofzZH759MnyK847RsJNB+wnImevpyAgviS0USNnZwpAm7XZ3hh/w4eJ8aAM+
 qPYryzNC+p4HAKk0mN5JNbX8tu+AVRxrHnivd1mY7A86dqOBX8bNV5uMKHhPczMeE7sr
 tFGZkUGt5jAv7OM43OvDPZzvWLpWk5k1UbRlyEpvXiZDruZtS+t5IsIyulma6uJHdcfJ
 WIGyJHudsDD7Rkio0Yu0UDbARoBpbUrlhGYwWXsq8aQMkpQzPTePBKh1FDAd06SZ3SKY
 Qw17TZ2crcV2DK/d6DCF2THnk1VkdwZp8gYCRCjHRMfszKZM21WiyHyD0Wu/fA883ggp
 TNaw==
X-Gm-Message-State: AC+VfDz5SHsz32OOWfnyrioGqwZ3csGMYspZVwSkcBLGx2CksKy1G5Fd
 uOrwgMTLU94j/exnU5IvB4W82BWAcOWMSqu0rxH5cZmGCR8qHMheeLQQ0itaywD6wQRRcJkDRL4
 CQBHFWKvR942aJJkQWUM6oPbhSP5wSOJo23aD146KMw==
X-Received: by 2002:adf:ee0d:0:b0:306:489b:3c6 with SMTP id
 y13-20020adfee0d000000b00306489b03c6mr6431092wrn.58.1685273984240; 
 Sun, 28 May 2023 04:39:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5VgKcQPiVNapMX5SlDKqYUbpW2HWC/oPtrwQ5B7c8EOYbkHxWsebF0EAVyZtuzn9rB2KM41w==
X-Received: by 2002:adf:ee0d:0:b0:306:489b:3c6 with SMTP id
 y13-20020adfee0d000000b00306489b03c6mr6431074wrn.58.1685273983900; 
 Sun, 28 May 2023 04:39:43 -0700 (PDT)
Received: from redhat.com ([2.52.146.27]) by smtp.gmail.com with ESMTPSA id
 o9-20020a5d6849000000b003078c535277sm10539200wrw.91.2023.05.28.04.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 May 2023 04:39:43 -0700 (PDT)
Date: Sun, 28 May 2023 07:39:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 net-next 1/2] virtio-net: convert rx mode setting to
 use workqueue
Message-ID: <20230528073139-mutt-send-email-mst@kernel.org>
References: <20230524081842.3060-1-jasowang@redhat.com>
 <20230524081842.3060-2-jasowang@redhat.com>
 <20230524050604-mutt-send-email-mst@kernel.org>
 <CACGkMEvm=MJz5e2C_7U=yjrvoo7pxsr=tRAL29OdxJDWhvtiSQ@mail.gmail.com>
 <20230525033750-mutt-send-email-mst@kernel.org>
 <CACGkMEtCA0-NY=qq_FnGzoY+VXmixGmBV3y80nZWO=NmxdRWmw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtCA0-NY=qq_FnGzoY+VXmixGmBV3y80nZWO=NmxdRWmw@mail.gmail.com>
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

T24gRnJpLCBNYXkgMjYsIDIwMjMgYXQgMDk6MzE6MzRBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUaHUsIE1heSAyNSwgMjAyMyBhdCAzOjQx4oCvUE0gTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gVGh1LCBNYXkgMjUsIDIwMjMgYXQg
MTE6NDM6MzRBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gT24gV2VkLCBNYXkgMjQs
IDIwMjMgYXQgNToxNeKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdy
b3RlOgo+ID4gPiA+Cj4gPiA+ID4gT24gV2VkLCBNYXkgMjQsIDIwMjMgYXQgMDQ6MTg6NDFQTSAr
MDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+IFRoaXMgcGF0Y2ggY29udmVydCByeCBt
b2RlIHNldHRpbmcgdG8gYmUgZG9uZSBpbiBhIHdvcmtxdWV1ZSwgdGhpcyBpcwo+ID4gPiA+ID4g
YSBtdXN0IGZvciBhbGxvdyB0byBzbGVlcCB3aGVuIHdhaXRpbmcgZm9yIHRoZSBjdnEgY29tbWFu
ZCB0bwo+ID4gPiA+ID4gcmVzcG9uc2Ugc2luY2UgY3VycmVudCBjb2RlIGlzIGV4ZWN1dGVkIHVu
ZGVyIGFkZHIgc3BpbiBsb2NrLgo+ID4gPiA+ID4KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+IENo
YW5nZXMgc2luY2UgVjE6Cj4gPiA+ID4gPiAtIHVzZSBSVE5MIHRvIHN5bmNocm9uaXplIHJ4IG1v
ZGUgd29ya2VyCj4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMgfCA1NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tCj4gPiA+ID4g
PiAgMSBmaWxlIGNoYW5nZWQsIDUyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gPiA+
ID4gPgo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+ID4gaW5kZXggNTZjYTFkMjcwMzA0Li41ZDJm
MWRhNGVhYTAgMTAwNjQ0Cj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMK
PiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+ID4gQEAgLTI2
NSw2ICsyNjUsMTIgQEAgc3RydWN0IHZpcnRuZXRfaW5mbyB7Cj4gPiA+ID4gPiAgICAgICAvKiBX
b3JrIHN0cnVjdCBmb3IgY29uZmlnIHNwYWNlIHVwZGF0ZXMgKi8KPiA+ID4gPiA+ICAgICAgIHN0
cnVjdCB3b3JrX3N0cnVjdCBjb25maWdfd29yazsKPiA+ID4gPiA+Cj4gPiA+ID4gPiArICAgICAv
KiBXb3JrIHN0cnVjdCBmb3IgY29uZmlnIHJ4IG1vZGUgKi8KPiA+ID4gPgo+ID4gPiA+IFdpdGgg
YSBiaXQgbGVzcyBhYmJyZXZpYXRpb24gbWF5YmU/IHNldHRpbmcgcnggbW9kZT8KPiA+ID4KPiA+
ID4gVGhhdCdzIGZpbmUuCj4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+ICsgICAgIHN0cnVjdCB3b3Jr
X3N0cnVjdCByeF9tb2RlX3dvcms7Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiArICAgICAvKiBJcyBy
eCBtb2RlIHdvcmsgZW5hYmxlZD8gKi8KPiA+ID4gPgo+ID4gPiA+IFVnaCBub3QgYSBncmVhdCBj
b21tZW50Lgo+ID4gPgo+ID4gPiBBbnkgc3VnZ2VzdGlvbnMgZm9yIHRoaXMuIEUuZyB3ZSBoYWQ6
Cj4gPiA+Cj4gPiA+ICAgICAgICAgLyogSXMgZGVsYXllZCByZWZpbGwgZW5hYmxlZD8gKi8KPiA+
Cj4gPiAvKiBPSyB0byBxdWV1ZSB3b3JrIHNldHRpbmcgUlggbW9kZT8gKi8KPiAKPiBPay4KPiAK
PiA+Cj4gPgo+ID4gPiA+Cj4gPiA+ID4gPiArICAgICBib29sIHJ4X21vZGVfd29ya19lbmFibGVk
Owo+ID4gPiA+ID4gKwo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gICAgICAgLyog
RG9lcyB0aGUgYWZmaW5pdHkgaGludCBpcyBzZXQgZm9yIHZpcnRxdWV1ZXM/ICovCj4gPiA+ID4g
PiAgICAgICBib29sIGFmZmluaXR5X2hpbnRfc2V0Owo+ID4gPiA+ID4KPiA+ID4gPiA+IEBAIC0z
ODgsNiArMzk0LDIwIEBAIHN0YXRpYyB2b2lkIGRpc2FibGVfZGVsYXllZF9yZWZpbGwoc3RydWN0
IHZpcnRuZXRfaW5mbyAqdmkpCj4gPiA+ID4gPiAgICAgICBzcGluX3VubG9ja19iaCgmdmktPnJl
ZmlsbF9sb2NrKTsKPiA+ID4gPiA+ICB9Cj4gPiA+ID4gPgo+ID4gPiA+ID4gK3N0YXRpYyB2b2lk
IGVuYWJsZV9yeF9tb2RlX3dvcmsoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gPiA+ID4gPiAr
ewo+ID4gPiA+ID4gKyAgICAgcnRubF9sb2NrKCk7Cj4gPiA+ID4gPiArICAgICB2aS0+cnhfbW9k
ZV93b3JrX2VuYWJsZWQgPSB0cnVlOwo+ID4gPiA+ID4gKyAgICAgcnRubF91bmxvY2soKTsKPiA+
ID4gPiA+ICt9Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiArc3RhdGljIHZvaWQgZGlzYWJsZV9yeF9t
b2RlX3dvcmsoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gPiA+ID4gPiArewo+ID4gPiA+ID4g
KyAgICAgcnRubF9sb2NrKCk7Cj4gPiA+ID4gPiArICAgICB2aS0+cnhfbW9kZV93b3JrX2VuYWJs
ZWQgPSBmYWxzZTsKPiA+ID4gPiA+ICsgICAgIHJ0bmxfdW5sb2NrKCk7Cj4gPiA+ID4gPiArfQo+
ID4gPiA+ID4gKwo+ID4gPiA+ID4gIHN0YXRpYyB2b2lkIHZpcnRxdWV1ZV9uYXBpX3NjaGVkdWxl
KHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3QgdmlydHF1ZXVlICp2cSkKPiA+ID4gPiA+ICB7Cj4gPiA+ID4g
PiBAQCAtMjM0MSw5ICsyMzYxLDExIEBAIHN0YXRpYyBpbnQgdmlydG5ldF9jbG9zZShzdHJ1Y3Qg
bmV0X2RldmljZSAqZGV2KQo+ID4gPiA+ID4gICAgICAgcmV0dXJuIDA7Cj4gPiA+ID4gPiAgfQo+
ID4gPiA+ID4KPiA+ID4gPiA+IC1zdGF0aWMgdm9pZCB2aXJ0bmV0X3NldF9yeF9tb2RlKHN0cnVj
dCBuZXRfZGV2aWNlICpkZXYpCj4gPiA+ID4gPiArc3RhdGljIHZvaWQgdmlydG5ldF9yeF9tb2Rl
X3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+ID4gPiA+ID4gIHsKPiA+ID4gPiA+IC0g
ICAgIHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpID0gbmV0ZGV2X3ByaXYoZGV2KTsKPiA+ID4gPiA+
ICsgICAgIHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpID0KPiA+ID4gPiA+ICsgICAgICAgICAgICAg
Y29udGFpbmVyX29mKHdvcmssIHN0cnVjdCB2aXJ0bmV0X2luZm8sIHJ4X21vZGVfd29yayk7Cj4g
PiA+ID4gPiArICAgICBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2ID0gdmktPmRldjsKPiA+ID4gPiA+
ICAgICAgIHN0cnVjdCBzY2F0dGVybGlzdCBzZ1syXTsKPiA+ID4gPiA+ICAgICAgIHN0cnVjdCB2
aXJ0aW9fbmV0X2N0cmxfbWFjICptYWNfZGF0YTsKPiA+ID4gPiA+ICAgICAgIHN0cnVjdCBuZXRk
ZXZfaHdfYWRkciAqaGE7Cj4gPiA+ID4gPiBAQCAtMjM1Niw2ICsyMzc4LDggQEAgc3RhdGljIHZv
aWQgdmlydG5ldF9zZXRfcnhfbW9kZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+ID4gPiA+ID4g
ICAgICAgaWYgKCF2aXJ0aW9faGFzX2ZlYXR1cmUodmktPnZkZXYsIFZJUlRJT19ORVRfRl9DVFJM
X1JYKSkKPiA+ID4gPiA+ICAgICAgICAgICAgICAgcmV0dXJuOwo+ID4gPiA+ID4KPiA+ID4gPiA+
ICsgICAgIHJ0bmxfbG9jaygpOwo+ID4gPiA+ID4gKwo+ID4gPiA+ID4gICAgICAgdmktPmN0cmwt
PnByb21pc2MgPSAoKGRldi0+ZmxhZ3MgJiBJRkZfUFJPTUlTQykgIT0gMCk7Cj4gPiA+ID4gPiAg
ICAgICB2aS0+Y3RybC0+YWxsbXVsdGkgPSAoKGRldi0+ZmxhZ3MgJiBJRkZfQUxMTVVMVEkpICE9
IDApOwo+ID4gPiA+ID4KPiA+ID4gPiA+IEBAIC0yMzczLDE0ICsyMzk3LDE5IEBAIHN0YXRpYyB2
b2lkIHZpcnRuZXRfc2V0X3J4X21vZGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiA+ID4gPiA+
ICAgICAgICAgICAgICAgZGV2X3dhcm4oJmRldi0+ZGV2LCAiRmFpbGVkIHRvICVzYWJsZSBhbGxt
dWx0aSBtb2RlLlxuIiwKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgdmktPmN0cmwt
PmFsbG11bHRpID8gImVuIiA6ICJkaXMiKTsKPiA+ID4gPiA+Cj4gPiA+ID4gPiArICAgICBuZXRp
Zl9hZGRyX2xvY2tfYmgoZGV2KTsKPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICAgICAgIHVjX2NvdW50
ID0gbmV0ZGV2X3VjX2NvdW50KGRldik7Cj4gPiA+ID4gPiAgICAgICBtY19jb3VudCA9IG5ldGRl
dl9tY19jb3VudChkZXYpOwo+ID4gPiA+ID4gICAgICAgLyogTUFDIGZpbHRlciAtIHVzZSBvbmUg
YnVmZmVyIGZvciBib3RoIGxpc3RzICovCj4gPiA+ID4gPiAgICAgICBidWYgPSBremFsbG9jKCgo
dWNfY291bnQgKyBtY19jb3VudCkgKiBFVEhfQUxFTikgKwo+ID4gPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAoMiAqIHNpemVvZihtYWNfZGF0YS0+ZW50cmllcykpLCBHRlBfQVRPTUlDKTsKPiA+
ID4gPiA+ICAgICAgIG1hY19kYXRhID0gYnVmOwo+ID4gPiA+ID4gLSAgICAgaWYgKCFidWYpCj4g
PiA+ID4gPiArICAgICBpZiAoIWJ1Zikgewo+ID4gPiA+ID4gKyAgICAgICAgICAgICBuZXRpZl9h
ZGRyX3VubG9ja19iaChkZXYpOwo+ID4gPiA+ID4gKyAgICAgICAgICAgICBydG5sX3VubG9jaygp
Owo+ID4gPiA+ID4gICAgICAgICAgICAgICByZXR1cm47Cj4gPiA+ID4gPiArICAgICB9Cj4gPiA+
ID4gPgo+ID4gPiA+ID4gICAgICAgc2dfaW5pdF90YWJsZShzZywgMik7Cj4gPiA+ID4gPgo+ID4g
PiA+ID4gQEAgLTI0MDEsNiArMjQzMCw4IEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfc2V0X3J4X21v
ZGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiA+ID4gPiA+ICAgICAgIG5ldGRldl9mb3JfZWFj
aF9tY19hZGRyKGhhLCBkZXYpCj4gPiA+ID4gPiAgICAgICAgICAgICAgIG1lbWNweSgmbWFjX2Rh
dGEtPm1hY3NbaSsrXVswXSwgaGEtPmFkZHIsIEVUSF9BTEVOKTsKPiA+ID4gPiA+Cj4gPiA+ID4g
PiArICAgICBuZXRpZl9hZGRyX3VubG9ja19iaChkZXYpOwo+ID4gPiA+ID4gKwo+ID4gPiA+ID4g
ICAgICAgc2dfc2V0X2J1Zigmc2dbMV0sIG1hY19kYXRhLAo+ID4gPiA+ID4gICAgICAgICAgICAg
ICAgICBzaXplb2YobWFjX2RhdGEtPmVudHJpZXMpICsgKG1jX2NvdW50ICogRVRIX0FMRU4pKTsK
PiA+ID4gPiA+Cj4gPiA+ID4gPiBAQCAtMjQwOCw5ICsyNDM5LDE5IEBAIHN0YXRpYyB2b2lkIHZp
cnRuZXRfc2V0X3J4X21vZGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiA+ID4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgVklSVElPX05FVF9DVFJMX01BQ19UQUJMRV9TRVQs
IHNnKSkKPiA+ID4gPiA+ICAgICAgICAgICAgICAgZGV2X3dhcm4oJmRldi0+ZGV2LCAiRmFpbGVk
IHRvIHNldCBNQUMgZmlsdGVyIHRhYmxlLlxuIik7Cj4gPiA+ID4gPgo+ID4gPiA+ID4gKyAgICAg
cnRubF91bmxvY2soKTsKPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICAgICAgIGtmcmVlKGJ1Zik7Cj4g
PiA+ID4gPiAgfQo+ID4gPiA+ID4KPiA+ID4gPiA+ICtzdGF0aWMgdm9pZCB2aXJ0bmV0X3NldF9y
eF9tb2RlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4gPiA+ID4gPiArewo+ID4gPiA+ID4gKyAg
ICAgc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBuZXRkZXZfcHJpdihkZXYpOwo+ID4gPiA+ID4g
Kwo+ID4gPiA+ID4gKyAgICAgaWYgKHZpLT5yeF9tb2RlX3dvcmtfZW5hYmxlZCkKPiA+ID4gPiA+
ICsgICAgICAgICAgICAgc2NoZWR1bGVfd29yaygmdmktPnJ4X21vZGVfd29yayk7Cj4gPiA+ID4g
PiArfQo+ID4gPiA+ID4gKwo+ID4gPiA+Cj4gPiA+ID4gPiAgc3RhdGljIGludCB2aXJ0bmV0X3Zs
YW5fcnhfYWRkX3ZpZChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4gPiA+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgX19iZTE2IHByb3RvLCB1MTYgdmlkKQo+ID4gPiA+ID4g
IHsKPiA+ID4gPiA+IEBAIC0zMTgxLDYgKzMyMjIsOCBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X2Zy
ZWV6ZV9kb3duKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiA+ID4KPiA+ID4gPiA+
ICAgICAgIC8qIE1ha2Ugc3VyZSBubyB3b3JrIGhhbmRsZXIgaXMgYWNjZXNzaW5nIHRoZSBkZXZp
Y2UgKi8KPiA+ID4gPiA+ICAgICAgIGZsdXNoX3dvcmsoJnZpLT5jb25maWdfd29yayk7Cj4gPiA+
ID4gPiArICAgICBkaXNhYmxlX3J4X21vZGVfd29yayh2aSk7Cj4gPiA+ID4gPiArICAgICBmbHVz
aF93b3JrKCZ2aS0+cnhfbW9kZV93b3JrKTsKPiA+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICBuZXRp
Zl90eF9sb2NrX2JoKHZpLT5kZXYpOwo+ID4gPiA+ID4gICAgICAgbmV0aWZfZGV2aWNlX2RldGFj
aCh2aS0+ZGV2KTsKPiA+ID4gPgo+ID4gPiA+IEhtbSBzbyBxdWV1ZWQgcnggbW9kZSB3b3JrIHdp
bGwganVzdCBnZXQgc2tpcHBlZAo+ID4gPiA+IGFuZCBvbiByZXN0b3JlIHdlIGdldCBhIHdyb25n
IHJ4IG1vZGUuCj4gPiA+ID4gQW55IHdheSB0byBtYWtlIHRoaXMgbW9yZSByb2J1c3Q/Cj4gPiA+
Cj4gPiA+IEl0IGNvdWxkIGJlIGRvbmUgYnkgc2NoZWR1bGluZyBhIHdvcmsgb24gcmVzdG9yZS4K
PiAKPiBSZXRoaW5rIHRoaXMsIEkgdGhpbmsgd2UgZG9uJ3QgbmVlZCB0byBjYXJlIGFib3V0IHRo
aXMgY2FzZSBzaW5jZSB0aGUKPiB1c2VyIHByb2Nlc3NlcyBzaG91bGQgaGF2ZSBiZWVuIGZyb3pl
bmVkLgoKWWVzIGJ1dCBub3QgdGhlIHdvcmtxdWV1ZS4gV2FudCB0byBzd2l0Y2ggdG8gc3lzdGVt
X2ZyZWV6YWJsZV93cT8KCj4gQW5kIHRoYXQgdGhlIHJlYXNvbiB3ZSBkb24ndAo+IGV2ZW4gbmVl
ZCB0byBob2xkIFJUTkwgaGVyZS4KPiAKPiBUaGFua3MKPiAKPiA+ID4KPiA+ID4gVGhhbmtzCj4g
Pgo+ID4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBAQCAtMzIwMyw2ICszMjQ2LDcgQEAgc3Rh
dGljIGludCB2aXJ0bmV0X3Jlc3RvcmVfdXAoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4g
PiA+ID4gPiAgICAgICB2aXJ0aW9fZGV2aWNlX3JlYWR5KHZkZXYpOwo+ID4gPiA+ID4KPiA+ID4g
PiA+ICAgICAgIGVuYWJsZV9kZWxheWVkX3JlZmlsbCh2aSk7Cj4gPiA+ID4gPiArICAgICBlbmFi
bGVfcnhfbW9kZV93b3JrKHZpKTsKPiA+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICBpZiAobmV0aWZf
cnVubmluZyh2aS0+ZGV2KSkgewo+ID4gPiA+ID4gICAgICAgICAgICAgICBlcnIgPSB2aXJ0bmV0
X29wZW4odmktPmRldik7Cj4gPiA+ID4gPiBAQCAtNDAwMiw2ICs0MDQ2LDcgQEAgc3RhdGljIGlu
dCB2aXJ0bmV0X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiA+ID4gICAg
ICAgdmRldi0+cHJpdiA9IHZpOwo+ID4gPiA+ID4KPiA+ID4gPiA+ICAgICAgIElOSVRfV09SSygm
dmktPmNvbmZpZ193b3JrLCB2aXJ0bmV0X2NvbmZpZ19jaGFuZ2VkX3dvcmspOwo+ID4gPiA+ID4g
KyAgICAgSU5JVF9XT1JLKCZ2aS0+cnhfbW9kZV93b3JrLCB2aXJ0bmV0X3J4X21vZGVfd29yayk7
Cj4gPiA+ID4gPiAgICAgICBzcGluX2xvY2tfaW5pdCgmdmktPnJlZmlsbF9sb2NrKTsKPiA+ID4g
PiA+Cj4gPiA+ID4gPiAgICAgICBpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19O
RVRfRl9NUkdfUlhCVUYpKSB7Cj4gPiA+ID4gPiBAQCAtNDExMCw2ICs0MTU1LDggQEAgc3RhdGlj
IGludCB2aXJ0bmV0X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiA+ID4g
ICAgICAgaWYgKHZpLT5oYXNfcnNzIHx8IHZpLT5oYXNfcnNzX2hhc2hfcmVwb3J0KQo+ID4gPiA+
ID4gICAgICAgICAgICAgICB2aXJ0bmV0X2luaXRfZGVmYXVsdF9yc3ModmkpOwo+ID4gPiA+ID4K
PiA+ID4gPiA+ICsgICAgIGVuYWJsZV9yeF9tb2RlX3dvcmsodmkpOwo+ID4gPiA+ID4gKwo+ID4g
PiA+ID4gICAgICAgLyogc2VyaWFsaXplIG5ldGRldiByZWdpc3RlciArIHZpcnRpb19kZXZpY2Vf
cmVhZHkoKSB3aXRoIG5kb19vcGVuKCkgKi8KPiA+ID4gPiA+ICAgICAgIHJ0bmxfbG9jaygpOwo+
ID4gPiA+ID4KPiA+ID4gPiA+IEBAIC00MjA3LDYgKzQyNTQsOCBAQCBzdGF0aWMgdm9pZCB2aXJ0
bmV0X3JlbW92ZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiA+ID4gPiA+Cj4gPiA+ID4g
PiAgICAgICAvKiBNYWtlIHN1cmUgbm8gd29yayBoYW5kbGVyIGlzIGFjY2Vzc2luZyB0aGUgZGV2
aWNlLiAqLwo+ID4gPiA+ID4gICAgICAgZmx1c2hfd29yaygmdmktPmNvbmZpZ193b3JrKTsKPiA+
ID4gPiA+ICsgICAgIGRpc2FibGVfcnhfbW9kZV93b3JrKHZpKTsKPiA+ID4gPiA+ICsgICAgIGZs
dXNoX3dvcmsoJnZpLT5yeF9tb2RlX3dvcmspOwo+ID4gPiA+ID4KPiA+ID4gPiA+ICAgICAgIHVu
cmVnaXN0ZXJfbmV0ZGV2KHZpLT5kZXYpOwo+ID4gPiA+ID4KPiA+ID4gPiA+IC0tCj4gPiA+ID4g
PiAyLjI1LjEKPiA+ID4gPgo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
