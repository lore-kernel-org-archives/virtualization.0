Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F54E81817
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 04:38:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74BE8821D5;
	Tue, 26 Sep 2023 04:38:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 74BE8821D5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UzaNVTsO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z-enh5ETWR8E; Tue, 26 Sep 2023 04:38:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DF023821B4;
	Tue, 26 Sep 2023 04:38:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF023821B4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB00DC0071;
	Tue, 26 Sep 2023 04:38:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB208C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 04:38:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A7D27821C8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 04:38:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A7D27821C8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zkkujPIzOhSG
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 04:38:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D9956821B4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 04:38:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D9956821B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695703082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jIXu104+alAzcIDHfWvNLkJCYvCCr7ayQGmGcfYWdz0=;
 b=UzaNVTsOLcGZG/MzcQitzlK3BPg3rK0h/LhfIE4+eepBo6mJszuMsgPGQREppWhcO9qZU6
 oFNIqvDEMcFRBjMcITCcEZgKukrBAX1PLwvspw4wV+2xvul7IBkz1r2OrGSq0DCtzUmJWQ
 uvgw3Po6DFbH53viYNsxCDr6VwXOeBU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-rkA49tp0MCSMqYyQ1xbTAQ-1; Tue, 26 Sep 2023 00:37:59 -0400
X-MC-Unique: rkA49tp0MCSMqYyQ1xbTAQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-50433ca6d81so9813242e87.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 21:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695703077; x=1696307877;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jIXu104+alAzcIDHfWvNLkJCYvCCr7ayQGmGcfYWdz0=;
 b=pS8VWWFoCWgvN0yuF9NA4JkputrOqpS8egKmqnHRSO+y3Q1Glg1EaystP/SN5HHJoP
 So38GjfljQLgKsVMufAWHfW7vShahn2VtJhpHFW+i9AQeJMQofmmSG+J+1qJDZIEz00U
 kq/GH374dBg5BZZckxDWkcvZ8sj3pJ/tsabiYuYlNlVHNr/4++2/qrFDGLXGmUz9ZHuJ
 HKB4O2YnOyqfCxd8acxG4crrc7Pxf/o8ggSpSbHVTWK8acHeXw5rF9DdUBk03cqZ2dfd
 mg+dRQ/PUjahKuWbMx/j6ulTmUws5cTFa8/yHxZT8RKScHZZieVuRgKlylMhHLQgLHaO
 fN8w==
X-Gm-Message-State: AOJu0YywSRwfio7vYk1pW1b+SEWnS7PzoCuNGirgAwgr0GZ19VN5rqry
 hYLDJHtLvveQIAOX5iVUIzIdBbSYgcfkW5DBFYTx2eeWsQ499pdAWXSQ0eYkU14/5aMGwMQSICw
 WMjmerWuxhwDZKax50MXYQbq3VKpENaP+0Z+rL4nuYQKyi/4Kuu+YPfvu1Q==
X-Received: by 2002:a05:6512:a94:b0:501:bd6f:7c1e with SMTP id
 m20-20020a0565120a9400b00501bd6f7c1emr9556493lfu.33.1695703077773; 
 Mon, 25 Sep 2023 21:37:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6fg22JDRfkI0jhFU9MmEF3Bwe3Da7PTw70+uY/H4x2Cbgvk9Z6LgoHNmSUWBAU+OAEnEVz9UzAJRrF9IwIBo=
X-Received: by 2002:a05:6512:a94:b0:501:bd6f:7c1e with SMTP id
 m20-20020a0565120a9400b00501bd6f7c1emr9556484lfu.33.1695703077534; Mon, 25
 Sep 2023 21:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230921141125.GM13733@nvidia.com>
 <20230921101509-mutt-send-email-mst@kernel.org>
 <20230921164139.GP13733@nvidia.com>
 <20230921124331-mutt-send-email-mst@kernel.org>
 <20230921183926.GV13733@nvidia.com>
 <20230921150448-mutt-send-email-mst@kernel.org>
 <20230921194946.GX13733@nvidia.com>
 <CACGkMEvMP05yTNGE5dBA2-M0qX-GXFcdGho7_T5NR6kAEq9FNg@mail.gmail.com>
 <20230922121132.GK13733@nvidia.com>
 <CACGkMEsxgYERbyOPU33jTQuPDLUur5jv033CQgK9oJLW+ueG8w@mail.gmail.com>
 <20230925122607.GW13733@nvidia.com>
In-Reply-To: <20230925122607.GW13733@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Sep 2023 12:37:46 +0800
Message-ID: <CACGkMEv9xaMi_Hxex02QUkLD95+1nWBRJz9g8sfQGzN8gkxt=w@mail.gmail.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
To: Jason Gunthorpe <jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 maorg@nvidia.com, virtualization@lists.linux-foundation.org, jiri@nvidia.com,
 leonro@nvidia.com
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

T24gTW9uLCBTZXAgMjUsIDIwMjMgYXQgODoyNuKAr1BNIEphc29uIEd1bnRob3JwZSA8amdnQG52
aWRpYS5jb20+IHdyb3RlOgo+Cj4gT24gTW9uLCBTZXAgMjUsIDIwMjMgYXQgMTA6MzQ6NTRBTSAr
MDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPgo+ID4gPiBDbG91ZCB2ZW5kb3JzIHdpbGwgc2ltaWxh
cmx5IHVzZSBEUFVzIHRvIGNyZWF0ZSBhIFBDSSBmdW5jdGlvbnMgdGhhdAo+ID4gPiBtZWV0IHRo
ZSBjbG91ZCB2ZW5kb3IncyBpbnRlcm5hbCBzcGVjaWZpY2F0aW9uLgo+ID4KPiA+IFRoaXMgY2Fu
IG9ubHkgd29yayBpZjoKPiA+Cj4gPiAxKSB0aGUgaW50ZXJuYWwgc3BlY2lmaWNhdGlvbiBoYXMg
ZmluZXIgZ2FyaW4gdGhhbiB2aXJ0aW8gc3BlYwo+ID4gMikgc28gaXQgY2FuIGRlZmluZSB3aGF0
IGlzIG5vdCBpbXBsZW1lbnRlZCBpbiB0aGUgdmlydGlvIHNwZWMgKGxpa2UKPiA+IG1pZ3JhdGlv
biBhbmQgY29tcGF0aWJpbGl0eSkKPgo+IFllcywgYW5kIHRoYXQgaXMgd2hhdCBpcyBoYXBwZW5p
bmcuIFJlYWxpc3RpY2FsbHkgdGhlICJzcGVjIiBpc2p1c3QgYQo+IHBpZWNlIG9mIHNvZnR3YXJl
IHRoYXQgdGhlIENsb3VkIHZlbmRvciBvd25zIHdoaWNoIGlzIHNpbXBseSBwb3J0ZWQgdG8KPiBt
dWx0aXBsZSBEUFUgdmVuZG9ycy4KPgo+IEl0IGlzIHRoZSBzYW1lIGFzIFZEUEEuIElmIFZEUEEg
Y2FuIG1ha2UgbXVsdGlwbGUgTklDIHZlbmRvcnMKPiBjb25zaXN0ZW50IHRoZW4gd2h5IGRvIHlv
dSBoYXZlIGEgaGFyZCB0aW1lIGJlbGlldmluZyB3ZSBjYW4gZG8gdGhlCj4gc2FtZSB0aGluZyBq
dXN0IG9uIHRoZSBBUk0gc2lkZSBvZiBhIERQVT8KCkkgZG9uJ3QuIFdlIGFsbCBrbm93IHZEUEEg
Y2FuIGRvIG1vcmUgdGhhbiB2aXJ0aW8uCgo+Cj4gPiBBbGwgb2YgdGhlIGFib3ZlIGRvZXNuJ3Qg
c2VlbSB0byBiZSBwb3NzaWJsZSBvciByZWFsaXN0aWMgbm93LCBhbmQgaXQKPiA+IGFjdHVhbGx5
IGhhcyBhIHJpc2sgdG8gYmUgbm90IGNvbXBhdGlibGUgd2l0aCB2aXJ0aW8gc3BlYy4gSW4gdGhl
Cj4gPiBmdXR1cmUgd2hlbiB2aXJ0aW8gaGFzIGxpdmUgbWlncmF0aW9uIHN1cHBvcnRlZCwgdGhl
eSB3YW50IHRvIGJlIGFibGUKPiA+IHRvIG1pZ3JhdGUgYmV0d2VlbiB2aXJ0aW8gYW5kIHZEUEEu
Cj4KPiBXZWxsLCB0aGF0IGlzIGZvciB0aGUgc3BlYyB0byBkZXNpZ24uCgpSaWdodCwgc28gaWYg
d2UnZCBjb25zaWRlciBtaWdyYXRpb24gZnJvbSB2aXJ0aW8gdG8gdkRQQSwgaXQgbmVlZHMgdG8K
YmUgZGVzaWduZWQgaW4gYSB3YXkgdGhhdCBhbGxvd3MgbW9yZSBpbnZvbHZlbWVudCBmcm9tIGh5
cGVydmlzb3IKb3RoZXIgdGhhbiBjb3VwbGluZyBpdCB3aXRoIGEgc3BlY2lmaWMgaW50ZXJmYWNl
IChsaWtlIGFkbWluCnZpcnRxdWV1ZXMpLgoKPgo+ID4gPiBTbywgYXMgSSBrZWVwIHNheWluZywg
aW4gdGhpcyBzY2VuYXJpbyB0aGUgZ29hbCBpcyBubyBtZWRpYXRpb24gaW4gdGhlCj4gPiA+IGh5
cGVydmlzb3IuCj4gPgo+ID4gVGhhdCdzIHByZXR0eSBmaW5lLCBidXQgSSBkb24ndCB0aGluayB0
cmFwcGluZyArIHJlbHlpbmcgaXMgbm90Cj4gPiBtZWRpYXRpb24uIERvZXMgaXQgcmVhbGx5IG1h
dHRlciB3aGF0IGhhcHBlbnMgYWZ0ZXIgdHJhcHBpbmc/Cj4KPiBJdCBpcyBub3QgbWVkaWF0aW9u
IGluIHRoZSBzZW5zZSB0aGF0IHRoZSBrZXJuZWwgZHJpdmVyIGRvZXMgbm90IGluCj4gYW55IHdh
eSBtYWtlIGRlY2lzaW9ucyBvbiB0aGUgYmVoYXZpb3Igb2YgdGhlIGRldmljZS4gSXQgc2ltcGx5
Cj4gdHJhbnNmb3JtcyBhbiBJTyBvcGVyYXRpb24gaW50byBhIGRldmljZSBjb21tYW5kIGFuZCBy
ZWxheXMgaXQgdG8gdGhlCj4gZGV2aWNlLiBUaGUgZGV2aWNlIHN0aWxsIGZ1bGx5IGNvbnRyb2xz
IGl0cyBvd24gYmVoYXZpb3IuCj4KPiBWRFBBIGlzIHZlcnkgZGlmZmVyZW50IGZyb20gdGhpcy4g
WW91IG1pZ2h0IGNhbGwgdGhlbSBib3RoIG1lZGlhdGlvbiwKPiBzdXJlLCBidXQgdGhlbiB5b3Ug
bmVlZCBhbm90aGVyIHdvcmQgdG8gZGVzY3JpYmUgdGhlIGFkZGl0aW9uYWwKPiBjaGFuZ2VzIFZQ
REEgaXMgZG9pbmcuCj4KPiA+ID4gSXQgaXMgcG9pbnRsZXNzLCBldmVyeXRoaW5nIHlvdSB0aGlu
ayB5b3UgbmVlZCB0byBkbyB0aGVyZQo+ID4gPiBpcyBhY3R1YWxseSBhbHJlYWR5IGJlaW5nIGRv
bmUgaW4gdGhlIERQVS4KPiA+Cj4gPiBXZWxsLCBtaWdyYXRpb24gb3IgZXZlbiBRZW11IGNvdWxk
IGJlIG9mZmxvYWRlZCB0byBEUFUgYXMgd2VsbC4gSWYKPiA+IHRoYXQncyB0aGUgZGlyZWN0aW9u
IHRoYXQncyBwcmV0dHkgZmluZS4KPgo+IFRoYXQncyBzaWxseSwgb2YgY291cnNlIHFlbXUva3Zt
IGNhbid0IHJ1biBpbiB0aGUgRFBVLgoKS1ZNIGNhbid0IGZvciBzdXJlIGJ1dCBwYXJ0IG9mIFFl
bXUgY291bGQuIFRoaXMgbW9kZWwgaGFzIGJlZW4gdXNlZC4KCj4KPiBIb3dldmVyLCB3ZSBjYW4g
ZW1wdHkgcWVtdSBhbmQgdGhlIGh5cGVydmlzb3Igb3V0IHNvIGFsbCBpdCBkb2VzIGlzCj4gcnVu
IGt2bSBhbmQgcnVuIHZmaW8uIEluIHRoaXMgbW9kZWwgdGhlIERQVSBkb2VzIGFsbCB0aGUgT1ZT
LCBzdG9yYWdlLAo+ICJWUERBIiwgZXRjLiBxZW11IGlzIGp1c3QgYSBwYXNzaXZlIHJlbGF5IG9m
IHRoZSBEUFUgUENJIGZ1bmN0aW9ucwo+IGludG8gVk0ncyB2UENJIGZ1bmN0aW9ucy4KPgo+IFNv
LCBldmVyeXRoaW5nIFZEUEEgd2FzIGRvaW5nIGluIHRoZSBlbnZpcm9ubWVudCBpcyBtaWdyYXRl
ZCBpbnRvIHRoZQo+IERQVS4KCkl0IHJlYWxseSBkZXBlbmRzIG9uIHRoZSB1c2UgY2FzZXMuIEZv
ciBleGFtcGxlLCBpbiB0aGUgY2FzZSBvZiBEUFUKd2hhdCBpZiB3ZSB3YW50IHRvIHByb3ZpZGUg
bXVsdGlwbGUgdmlydGlvIGRldmljZXMgdGhyb3VnaCBhIHNpbmdsZQpWRj8KCj4KPiBJbiB0aGlz
IG1vZGVsIHRoZSBEUFUgaXMgYW4gZXh0ZW5zaW9uIG9mIHRoZSBoeXBlcnZpc29yL3FlbXUKPiBl
bnZpcm9ubWVudCBhbmQgd2Ugc2hpZnQgY29kZSBmcm9tIHg4NiBzaWRlIHRvIGFybSBzaWRlIHRv
IGluY3JlYXNlCj4gc2VjdXJpdHksIHNhdmUgcG93ZXIgYW5kIGluY3JlYXNlIHRvdGFsIHN5c3Rl
bSBwZXJmb3JtYW5jZS4KClRoYXQncyBwcmV0dHkgZmluZS4KClRoYW5rcwoKPgo+IEphc29uCj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
