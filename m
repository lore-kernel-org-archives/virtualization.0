Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA27C77B7A
	for <virtualization@archiver.kernel.org>; Thu, 25 May 2023 03:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECD7B4247F;
	Thu, 25 May 2023 03:43:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ECD7B4247F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ijr8GYZO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EqnDVciZHnDK; Thu, 25 May 2023 03:43:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D84BC40304;
	Thu, 25 May 2023 03:43:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D84BC40304
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A00DCC0035;
	Thu, 25 May 2023 03:43:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57559C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 03:43:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B4B660C03
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 03:43:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B4B660C03
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ijr8GYZO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ba1uEmCG_bQY
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 03:43:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 33BB460BEB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 33BB460BEB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 03:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684986231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s4m2p+lm6+1Dh1af/W/L1B6pO/Ymz2+CVF2VL5CW0fg=;
 b=ijr8GYZO5q0GEqYPoC5GGGnWl03KgADT4xOD9CpRp6y20aOdQtjic4tS1DU8D261iWVaU6
 aFNtVD5Bh+HMqtVuc8K6Xb2rxntPrMqLJu+9IlDXceUJjP0qK2Jiape/lYxFweRRHcl9r4
 u9VMT5YVbCJidF4tItKqMKr5rzR1L1I=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-V1RPuvc4NQ2gX8Nnm9xMAw-1; Wed, 24 May 2023 23:43:48 -0400
X-MC-Unique: V1RPuvc4NQ2gX8Nnm9xMAw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2af1ed9514bso485491fa.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 May 2023 20:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684986226; x=1687578226;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s4m2p+lm6+1Dh1af/W/L1B6pO/Ymz2+CVF2VL5CW0fg=;
 b=O3O0rLArTuLVgvr9q6/D1VbZFdnjTVranPt0L0ZoMEuw+uyiXwOkNHf67EevoCAVBN
 HZXUFYAku4ZUs8YFmuwFDN9GBJgK3/3rZhxNmWej02FV5CIkt24NW1herTrwXDUYtoF3
 m3IOE3J1LBbqkDtBX/Qp/S61CDAoAlJJcXSp3X1D3qaIvXRc2YptsIjunXmVTkJ9j98d
 yOm4dXcBwOCnddnyu69gV+pRD5hao8Km3VrPZx+G3YDoKgr3DzMSGATOAQna20sV0vRT
 ohvF/P4L6LKL/WMoCM32RgevIbbliq/rt5IYBt4eLvcKNPGVHZql350dQxX6IWt5nF/j
 ysag==
X-Gm-Message-State: AC+VfDxr/+d/oxQEYCZkbNboISR5nO82+xAjesZXbJI6TXb3RScMOVql
 5x0Oc1wFzioYeCiqK0aE/SoO3WAOxJPSibT7tCccCsV/47qeTBIQaRCv+nwQNFp03cwLEDSDMiK
 ystAxoQ2mHBv8a0qMEwxT0j33gLqf2BLqDAA7x2KZLzdId6tSCVX+/UlHdg==
X-Received: by 2002:a2e:b1c7:0:b0:2af:1fd4:9011 with SMTP id
 e7-20020a2eb1c7000000b002af1fd49011mr549056lja.34.1684986226507; 
 Wed, 24 May 2023 20:43:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Nxno0CpX0KxVDu2aSi+nZY7wvCAw+00hD9PbzdyW/N6KVXC3Z9EBcXiECbwBPrWDt6zuPtKluPlPeL66TBWs=
X-Received: by 2002:a2e:b1c7:0:b0:2af:1fd4:9011 with SMTP id
 e7-20020a2eb1c7000000b002af1fd49011mr549044lja.34.1684986226178; Wed, 24 May
 2023 20:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230524081842.3060-1-jasowang@redhat.com>
 <20230524081842.3060-2-jasowang@redhat.com>
 <20230524050604-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230524050604-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 May 2023 11:43:34 +0800
Message-ID: <CACGkMEvm=MJz5e2C_7U=yjrvoo7pxsr=tRAL29OdxJDWhvtiSQ@mail.gmail.com>
Subject: Re: [PATCH V3 net-next 1/2] virtio-net: convert rx mode setting to
 use workqueue
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

T24gV2VkLCBNYXkgMjQsIDIwMjMgYXQgNToxNeKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gV2VkLCBNYXkgMjQsIDIwMjMgYXQgMDQ6MTg6NDFQ
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IFRoaXMgcGF0Y2ggY29udmVydCByeCBtb2Rl
IHNldHRpbmcgdG8gYmUgZG9uZSBpbiBhIHdvcmtxdWV1ZSwgdGhpcyBpcwo+ID4gYSBtdXN0IGZv
ciBhbGxvdyB0byBzbGVlcCB3aGVuIHdhaXRpbmcgZm9yIHRoZSBjdnEgY29tbWFuZCB0bwo+ID4g
cmVzcG9uc2Ugc2luY2UgY3VycmVudCBjb2RlIGlzIGV4ZWN1dGVkIHVuZGVyIGFkZHIgc3BpbiBs
b2NrLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+Cj4gPiAtLS0KPiA+IENoYW5nZXMgc2luY2UgVjE6Cj4gPiAtIHVzZSBSVE5MIHRvIHN5bmNo
cm9uaXplIHJ4IG1vZGUgd29ya2VyCj4gPiAtLS0KPiA+ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMgfCA1NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDUyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYwo+ID4gaW5kZXggNTZjYTFkMjcwMzA0Li41ZDJmMWRhNGVhYTAgMTAwNjQ0Cj4gPiAtLS0g
YS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYwo+ID4gQEAgLTI2NSw2ICsyNjUsMTIgQEAgc3RydWN0IHZpcnRuZXRfaW5mbyB7Cj4gPiAg
ICAgICAvKiBXb3JrIHN0cnVjdCBmb3IgY29uZmlnIHNwYWNlIHVwZGF0ZXMgKi8KPiA+ICAgICAg
IHN0cnVjdCB3b3JrX3N0cnVjdCBjb25maWdfd29yazsKPiA+Cj4gPiArICAgICAvKiBXb3JrIHN0
cnVjdCBmb3IgY29uZmlnIHJ4IG1vZGUgKi8KPgo+IFdpdGggYSBiaXQgbGVzcyBhYmJyZXZpYXRp
b24gbWF5YmU/IHNldHRpbmcgcnggbW9kZT8KClRoYXQncyBmaW5lLgoKPgo+ID4gKyAgICAgc3Ry
dWN0IHdvcmtfc3RydWN0IHJ4X21vZGVfd29yazsKPiA+ICsKPiA+ICsgICAgIC8qIElzIHJ4IG1v
ZGUgd29yayBlbmFibGVkPyAqLwo+Cj4gVWdoIG5vdCBhIGdyZWF0IGNvbW1lbnQuCgpBbnkgc3Vn
Z2VzdGlvbnMgZm9yIHRoaXMuIEUuZyB3ZSBoYWQ6CgogICAgICAgIC8qIElzIGRlbGF5ZWQgcmVm
aWxsIGVuYWJsZWQ/ICovCgo+Cj4gPiArICAgICBib29sIHJ4X21vZGVfd29ya19lbmFibGVkOwo+
ID4gKwo+Cj4KPgo+ID4gICAgICAgLyogRG9lcyB0aGUgYWZmaW5pdHkgaGludCBpcyBzZXQgZm9y
IHZpcnRxdWV1ZXM/ICovCj4gPiAgICAgICBib29sIGFmZmluaXR5X2hpbnRfc2V0Owo+ID4KPiA+
IEBAIC0zODgsNiArMzk0LDIwIEBAIHN0YXRpYyB2b2lkIGRpc2FibGVfZGVsYXllZF9yZWZpbGwo
c3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gPiAgICAgICBzcGluX3VubG9ja19iaCgmdmktPnJl
ZmlsbF9sb2NrKTsKPiA+ICB9Cj4gPgo+ID4gK3N0YXRpYyB2b2lkIGVuYWJsZV9yeF9tb2RlX3dv
cmsoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gPiArewo+ID4gKyAgICAgcnRubF9sb2NrKCk7
Cj4gPiArICAgICB2aS0+cnhfbW9kZV93b3JrX2VuYWJsZWQgPSB0cnVlOwo+ID4gKyAgICAgcnRu
bF91bmxvY2soKTsKPiA+ICt9Cj4gPiArCj4gPiArc3RhdGljIHZvaWQgZGlzYWJsZV9yeF9tb2Rl
X3dvcmsoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gPiArewo+ID4gKyAgICAgcnRubF9sb2Nr
KCk7Cj4gPiArICAgICB2aS0+cnhfbW9kZV93b3JrX2VuYWJsZWQgPSBmYWxzZTsKPiA+ICsgICAg
IHJ0bmxfdW5sb2NrKCk7Cj4gPiArfQo+ID4gKwo+ID4gIHN0YXRpYyB2b2lkIHZpcnRxdWV1ZV9u
YXBpX3NjaGVkdWxlKHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwKPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmlydHF1ZXVlICp2cSkKPiA+ICB7Cj4gPiBAQCAt
MjM0MSw5ICsyMzYxLDExIEBAIHN0YXRpYyBpbnQgdmlydG5ldF9jbG9zZShzdHJ1Y3QgbmV0X2Rl
dmljZSAqZGV2KQo+ID4gICAgICAgcmV0dXJuIDA7Cj4gPiAgfQo+ID4KPiA+IC1zdGF0aWMgdm9p
ZCB2aXJ0bmV0X3NldF9yeF9tb2RlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4gPiArc3RhdGlj
IHZvaWQgdmlydG5ldF9yeF9tb2RlX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+ID4g
IHsKPiA+IC0gICAgIHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpID0gbmV0ZGV2X3ByaXYoZGV2KTsK
PiA+ICsgICAgIHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpID0KPiA+ICsgICAgICAgICAgICAgY29u
dGFpbmVyX29mKHdvcmssIHN0cnVjdCB2aXJ0bmV0X2luZm8sIHJ4X21vZGVfd29yayk7Cj4gPiAr
ICAgICBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2ID0gdmktPmRldjsKPiA+ICAgICAgIHN0cnVjdCBz
Y2F0dGVybGlzdCBzZ1syXTsKPiA+ICAgICAgIHN0cnVjdCB2aXJ0aW9fbmV0X2N0cmxfbWFjICpt
YWNfZGF0YTsKPiA+ICAgICAgIHN0cnVjdCBuZXRkZXZfaHdfYWRkciAqaGE7Cj4gPiBAQCAtMjM1
Niw2ICsyMzc4LDggQEAgc3RhdGljIHZvaWQgdmlydG5ldF9zZXRfcnhfbW9kZShzdHJ1Y3QgbmV0
X2RldmljZSAqZGV2KQo+ID4gICAgICAgaWYgKCF2aXJ0aW9faGFzX2ZlYXR1cmUodmktPnZkZXYs
IFZJUlRJT19ORVRfRl9DVFJMX1JYKSkKPiA+ICAgICAgICAgICAgICAgcmV0dXJuOwo+ID4KPiA+
ICsgICAgIHJ0bmxfbG9jaygpOwo+ID4gKwo+ID4gICAgICAgdmktPmN0cmwtPnByb21pc2MgPSAo
KGRldi0+ZmxhZ3MgJiBJRkZfUFJPTUlTQykgIT0gMCk7Cj4gPiAgICAgICB2aS0+Y3RybC0+YWxs
bXVsdGkgPSAoKGRldi0+ZmxhZ3MgJiBJRkZfQUxMTVVMVEkpICE9IDApOwo+ID4KPiA+IEBAIC0y
MzczLDE0ICsyMzk3LDE5IEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfc2V0X3J4X21vZGUoc3RydWN0
IG5ldF9kZXZpY2UgKmRldikKPiA+ICAgICAgICAgICAgICAgZGV2X3dhcm4oJmRldi0+ZGV2LCAi
RmFpbGVkIHRvICVzYWJsZSBhbGxtdWx0aSBtb2RlLlxuIiwKPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgdmktPmN0cmwtPmFsbG11bHRpID8gImVuIiA6ICJkaXMiKTsKPiA+Cj4gPiArICAgICBu
ZXRpZl9hZGRyX2xvY2tfYmgoZGV2KTsKPiA+ICsKPiA+ICAgICAgIHVjX2NvdW50ID0gbmV0ZGV2
X3VjX2NvdW50KGRldik7Cj4gPiAgICAgICBtY19jb3VudCA9IG5ldGRldl9tY19jb3VudChkZXYp
Owo+ID4gICAgICAgLyogTUFDIGZpbHRlciAtIHVzZSBvbmUgYnVmZmVyIGZvciBib3RoIGxpc3Rz
ICovCj4gPiAgICAgICBidWYgPSBremFsbG9jKCgodWNfY291bnQgKyBtY19jb3VudCkgKiBFVEhf
QUxFTikgKwo+ID4gICAgICAgICAgICAgICAgICAgICAoMiAqIHNpemVvZihtYWNfZGF0YS0+ZW50
cmllcykpLCBHRlBfQVRPTUlDKTsKPiA+ICAgICAgIG1hY19kYXRhID0gYnVmOwo+ID4gLSAgICAg
aWYgKCFidWYpCj4gPiArICAgICBpZiAoIWJ1Zikgewo+ID4gKyAgICAgICAgICAgICBuZXRpZl9h
ZGRyX3VubG9ja19iaChkZXYpOwo+ID4gKyAgICAgICAgICAgICBydG5sX3VubG9jaygpOwo+ID4g
ICAgICAgICAgICAgICByZXR1cm47Cj4gPiArICAgICB9Cj4gPgo+ID4gICAgICAgc2dfaW5pdF90
YWJsZShzZywgMik7Cj4gPgo+ID4gQEAgLTI0MDEsNiArMjQzMCw4IEBAIHN0YXRpYyB2b2lkIHZp
cnRuZXRfc2V0X3J4X21vZGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiA+ICAgICAgIG5ldGRl
dl9mb3JfZWFjaF9tY19hZGRyKGhhLCBkZXYpCj4gPiAgICAgICAgICAgICAgIG1lbWNweSgmbWFj
X2RhdGEtPm1hY3NbaSsrXVswXSwgaGEtPmFkZHIsIEVUSF9BTEVOKTsKPiA+Cj4gPiArICAgICBu
ZXRpZl9hZGRyX3VubG9ja19iaChkZXYpOwo+ID4gKwo+ID4gICAgICAgc2dfc2V0X2J1Zigmc2db
MV0sIG1hY19kYXRhLAo+ID4gICAgICAgICAgICAgICAgICBzaXplb2YobWFjX2RhdGEtPmVudHJp
ZXMpICsgKG1jX2NvdW50ICogRVRIX0FMRU4pKTsKPiA+Cj4gPiBAQCAtMjQwOCw5ICsyNDM5LDE5
IEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfc2V0X3J4X21vZGUoc3RydWN0IG5ldF9kZXZpY2UgKmRl
dikKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVklSVElPX05FVF9DVFJMX01B
Q19UQUJMRV9TRVQsIHNnKSkKPiA+ICAgICAgICAgICAgICAgZGV2X3dhcm4oJmRldi0+ZGV2LCAi
RmFpbGVkIHRvIHNldCBNQUMgZmlsdGVyIHRhYmxlLlxuIik7Cj4gPgo+ID4gKyAgICAgcnRubF91
bmxvY2soKTsKPiA+ICsKPiA+ICAgICAgIGtmcmVlKGJ1Zik7Cj4gPiAgfQo+ID4KPiA+ICtzdGF0
aWMgdm9pZCB2aXJ0bmV0X3NldF9yeF9tb2RlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4gPiAr
ewo+ID4gKyAgICAgc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBuZXRkZXZfcHJpdihkZXYpOwo+
ID4gKwo+ID4gKyAgICAgaWYgKHZpLT5yeF9tb2RlX3dvcmtfZW5hYmxlZCkKPiA+ICsgICAgICAg
ICAgICAgc2NoZWR1bGVfd29yaygmdmktPnJ4X21vZGVfd29yayk7Cj4gPiArfQo+ID4gKwo+Cj4g
PiAgc3RhdGljIGludCB2aXJ0bmV0X3ZsYW5fcnhfYWRkX3ZpZChzdHJ1Y3QgbmV0X2RldmljZSAq
ZGV2LAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19iZTE2IHByb3RvLCB1
MTYgdmlkKQo+ID4gIHsKPiA+IEBAIC0zMTgxLDYgKzMyMjIsOCBAQCBzdGF0aWMgdm9pZCB2aXJ0
bmV0X2ZyZWV6ZV9kb3duKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4KPiA+ICAgICAg
IC8qIE1ha2Ugc3VyZSBubyB3b3JrIGhhbmRsZXIgaXMgYWNjZXNzaW5nIHRoZSBkZXZpY2UgKi8K
PiA+ICAgICAgIGZsdXNoX3dvcmsoJnZpLT5jb25maWdfd29yayk7Cj4gPiArICAgICBkaXNhYmxl
X3J4X21vZGVfd29yayh2aSk7Cj4gPiArICAgICBmbHVzaF93b3JrKCZ2aS0+cnhfbW9kZV93b3Jr
KTsKPiA+Cj4gPiAgICAgICBuZXRpZl90eF9sb2NrX2JoKHZpLT5kZXYpOwo+ID4gICAgICAgbmV0
aWZfZGV2aWNlX2RldGFjaCh2aS0+ZGV2KTsKPgo+IEhtbSBzbyBxdWV1ZWQgcnggbW9kZSB3b3Jr
IHdpbGwganVzdCBnZXQgc2tpcHBlZAo+IGFuZCBvbiByZXN0b3JlIHdlIGdldCBhIHdyb25nIHJ4
IG1vZGUuCj4gQW55IHdheSB0byBtYWtlIHRoaXMgbW9yZSByb2J1c3Q/CgpJdCBjb3VsZCBiZSBk
b25lIGJ5IHNjaGVkdWxpbmcgYSB3b3JrIG9uIHJlc3RvcmUuCgpUaGFua3MKCj4KPgo+ID4gQEAg
LTMyMDMsNiArMzI0Niw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9yZXN0b3JlX3VwKHN0cnVjdCB2
aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gICAgICAgdmlydGlvX2RldmljZV9yZWFkeSh2ZGV2KTsK
PiA+Cj4gPiAgICAgICBlbmFibGVfZGVsYXllZF9yZWZpbGwodmkpOwo+ID4gKyAgICAgZW5hYmxl
X3J4X21vZGVfd29yayh2aSk7Cj4gPgo+ID4gICAgICAgaWYgKG5ldGlmX3J1bm5pbmcodmktPmRl
dikpIHsKPiA+ICAgICAgICAgICAgICAgZXJyID0gdmlydG5ldF9vcGVuKHZpLT5kZXYpOwo+ID4g
QEAgLTQwMDIsNiArNDA0Niw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9wcm9iZShzdHJ1Y3Qgdmly
dGlvX2RldmljZSAqdmRldikKPiA+ICAgICAgIHZkZXYtPnByaXYgPSB2aTsKPiA+Cj4gPiAgICAg
ICBJTklUX1dPUksoJnZpLT5jb25maWdfd29yaywgdmlydG5ldF9jb25maWdfY2hhbmdlZF93b3Jr
KTsKPiA+ICsgICAgIElOSVRfV09SSygmdmktPnJ4X21vZGVfd29yaywgdmlydG5ldF9yeF9tb2Rl
X3dvcmspOwo+ID4gICAgICAgc3Bpbl9sb2NrX2luaXQoJnZpLT5yZWZpbGxfbG9jayk7Cj4gPgo+
ID4gICAgICAgaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfTVJHX1JY
QlVGKSkgewo+ID4gQEAgLTQxMTAsNiArNDE1NSw4IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9wcm9i
ZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiA+ICAgICAgIGlmICh2aS0+aGFzX3JzcyB8
fCB2aS0+aGFzX3Jzc19oYXNoX3JlcG9ydCkKPiA+ICAgICAgICAgICAgICAgdmlydG5ldF9pbml0
X2RlZmF1bHRfcnNzKHZpKTsKPiA+Cj4gPiArICAgICBlbmFibGVfcnhfbW9kZV93b3JrKHZpKTsK
PiA+ICsKPiA+ICAgICAgIC8qIHNlcmlhbGl6ZSBuZXRkZXYgcmVnaXN0ZXIgKyB2aXJ0aW9fZGV2
aWNlX3JlYWR5KCkgd2l0aCBuZG9fb3BlbigpICovCj4gPiAgICAgICBydG5sX2xvY2soKTsKPiA+
Cj4gPiBAQCAtNDIwNyw2ICs0MjU0LDggQEAgc3RhdGljIHZvaWQgdmlydG5ldF9yZW1vdmUoc3Ry
dWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gPgo+ID4gICAgICAgLyogTWFrZSBzdXJlIG5vIHdv
cmsgaGFuZGxlciBpcyBhY2Nlc3NpbmcgdGhlIGRldmljZS4gKi8KPiA+ICAgICAgIGZsdXNoX3dv
cmsoJnZpLT5jb25maWdfd29yayk7Cj4gPiArICAgICBkaXNhYmxlX3J4X21vZGVfd29yayh2aSk7
Cj4gPiArICAgICBmbHVzaF93b3JrKCZ2aS0+cnhfbW9kZV93b3JrKTsKPiA+Cj4gPiAgICAgICB1
bnJlZ2lzdGVyX25ldGRldih2aS0+ZGV2KTsKPiA+Cj4gPiAtLQo+ID4gMi4yNS4xCj4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
