Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC94EE6422
	for <virtualization@archiver.kernel.org>; Fri, 15 Sep 2023 06:55:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 938674208B;
	Fri, 15 Sep 2023 06:55:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 938674208B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gX5VR43G
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CAkff4wOremz; Fri, 15 Sep 2023 06:55:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 953AB4207F;
	Fri, 15 Sep 2023 06:55:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 953AB4207F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 657B0C0039;
	Fri, 15 Sep 2023 06:55:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D807C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 06:55:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1779C83896
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 06:55:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1779C83896
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gX5VR43G
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0tR-iL8mA20h
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 06:55:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0379D8375B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 06:55:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0379D8375B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694760912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0HShZr8WZAcOFv96ZYRXyE10lt4rZkRojb7JS1wDFwg=;
 b=gX5VR43G1GAG9ZCMVTBIMSNO+ytvnE7ViXSZs+DRH/Pc55b+D6961r3EMKltCAIjOQ5Iip
 AQfEDEuITQII1vg4/K0joRUuXz35wTpaBxA9sglkPWW6A/De3/gq5t+bzhcheGgCp3kzf4
 poJcbfQDv6Rt3fRotuXTX6/7V+FD5wE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-rxMoi6bzNbScbxPlhMgjZg-1; Fri, 15 Sep 2023 02:55:10 -0400
X-MC-Unique: rxMoi6bzNbScbxPlhMgjZg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50091accc8eso2123197e87.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Sep 2023 23:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694760909; x=1695365709;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0HShZr8WZAcOFv96ZYRXyE10lt4rZkRojb7JS1wDFwg=;
 b=vf4NiSMaIFb+aCGVlouCEbA50VV3wSfc8jepx/rRshaMZBFQRwZGEULjSH9Gr/F0oZ
 6ycNXWI+An04n3/ZD1CVEH1podjRnvF0LonHOxlA6OLnRtSTGEhehvnmO6lxri5xlyww
 ij784sOjd+P4cqGDYb30ZySNb+pNY4YMinXqhEY421h8u6x9rizci5RJPZN7yQM1YRu8
 4OVBFkyTssmCOY4JB9rEAfNHRYb7nIQknfSrEh74CFqgZRxBQ14Y5/V1aL2yhOmIwibB
 zx/NYfZys3ukRhj/BpK2OFyy5genD71JCQoBDv/WBn0TXbUA3otvz/HNv7jBNOOpHrvD
 vYig==
X-Gm-Message-State: AOJu0YwhwjCbn8DxrV6yTl47bWMjqMgnonkxNmHGSXGQ335ZMV6aEbdp
 vV2MYQ/7vseFxHbTkDRFxJmqAAsdGl2mkJgNqjVShqkKMUzTZ6+SLRDLm7Oy80y1sI5D2TbZz9f
 MOHtk5aZaMVEV5X8UdQVLY/fyOCp2wBlxjOtwkw4mPgxHjq5CxGNMEgEYJg==
X-Received: by 2002:a05:6512:539:b0:4ff:a25b:bca1 with SMTP id
 o25-20020a056512053900b004ffa25bbca1mr644175lfc.33.1694760908894; 
 Thu, 14 Sep 2023 23:55:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeELldMxnOhRlb4+WRmIeNCxjyPnSW1K3CuLG2wJF+pe+C7IWcZIM+xDb7X7fDmVIC/VIS638CajnbteLXSh0=
X-Received: by 2002:a05:6512:539:b0:4ff:a25b:bca1 with SMTP id
 o25-20020a056512053900b004ffa25bbca1mr644163lfc.33.1694760908532; Thu, 14 Sep
 2023 23:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230831155702.1080754-1-dtatulea@nvidia.com>
In-Reply-To: <20230831155702.1080754-1-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Sep 2023 14:54:57 +0800
Message-ID: <CACGkMEsgZig_Ek+ZsEr3hhBznZb_d733QK+0BVoe_WMLsKd+Pg@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa/mlx5: Fix firmware error on creation of 1k VQs
To: Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, Parav Pandit <parav@mellanox.com>,
 linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

T24gVGh1LCBBdWcgMzEsIDIwMjMgYXQgMTE6NTjigK9QTSBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVs
ZWFAbnZpZGlhLmNvbT4gd3JvdGU6Cj4KPiBBIGZpcm13YXJlIGVycm9yIGlzIHRyaWdnZXJlZCB3
aGVuIGNvbmZpZ3VyaW5nIGEgOWsgTVRVIG9uIHRoZSBQRiBhZnRlcgo+IHN3aXRjaGluZyB0byBz
d2l0Y2hkZXYgbW9kZSBhbmQgdGhlbiB1c2luZyBhIHZkcGEgZGV2aWNlIHdpdGggbGFyZ2VyCj4g
KDFrKSByaW5nczoKPiBtbHg1X2NtZF9vdXRfZXJyOiBDUkVBVEVfR0VORVJBTF9PQkpFQ1QoMHhh
MDApIG9wX21vZCgweGQpIGZhaWxlZCwgc3RhdHVzIGJhZCByZXNvdXJjZSgweDUpLCBzeW5kcm9t
ZSAoMHhmNmRiOTApLCBlcnIoLTIyKQo+Cj4gVGhpcyBpcyBkdWUgdG8gdGhlIGZhY3QgdGhhdCB0
aGUgaHcgVlEgc2l6ZSBwYXJhbWV0ZXJzIGFyZSBjb21wdXRlZAo+IGJhc2VkIG9uIHRoZSB1bWVt
XzEvMi8zX2J1ZmZlcl9wYXJhbV9hL2IgY2FwYWJpbGl0aWVzIGFuZCBhbGwKPiBkZXZpY2UgY2Fw
YWJpbGl0aWVzIGFyZSByZWFkIG9ubHkgd2hlbiB0aGUgZHJpdmVyIGlzIG1vdmVkIHRvIHN3aXRj
aGRldiBtb2RlLgo+Cj4gVGhlIHByb2JsZW1hdGljIGNvbmZpZ3VyYXRpb24gZmxvdyBsb29rcyBs
aWtlIHRoaXM6Cj4gMSkgQ3JlYXRlIFZGCj4gMikgVW5iaW5kIFZGCj4gMykgU3dpdGNoIFBGIHRv
IHN3aXRjaGRldiBtb2RlLgo+IDQpIEJpbmQgVkYKPiA1KSBTZXQgUEYgTVRVIHRvIDlrCj4gNikg
Y3JlYXRlIHZEUEEgZGV2aWNlCj4gNykgU3RhcnQgVk0gd2l0aCB2RFBBIGRldmljZSBhbmQgMUsg
cXVldWUgc2l6ZQo+Cj4gTm90ZSB0aGF0IHNldHRpbmcgdGhlIE1UVSBiZWZvcmUgc3RlcCAzKSBk
b2Vzbid0IHRyaWdnZXIgdGhpcyBpc3N1ZS4KPgo+IFRoaXMgcGF0Y2ggcmVhZHMgdGhlIGZvcmVt
ZW50aW9uZWQgdW1lbSBwYXJhbWV0ZXJzIGF0IHRoZSBsYXRlc3QgcG9pbnQKPiBwb3NzaWJsZSBi
ZWZvcmUgdGhlIFZRcyBvZiB0aGUgZGV2aWNlIGFyZSBjcmVhdGVkLgo+Cj4gdjI6Cj4gLSBBbGxv
Y2F0ZSBvdXRwdXQgd2l0aCBrbWFsbG9jIHRvIHJlZHVjZSBzdGFjayBmcmFtZSBzaXplLgo+IC0g
UmVtb3ZlZCBzdGFibGUgZnJvbSBjYy4KPgo+IEZpeGVzOiAxYTg2YjM3N2FhMjEgKCJ2ZHBhL21s
eDU6IEFkZCBWRFBBIGRyaXZlciBmb3Igc3VwcG9ydGVkIG1seDUgZGV2aWNlcyIpCj4gU2lnbmVk
LW9mZi1ieTogRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+CgpBY2tlZC1ieTog
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKPiAtLS0KPiAgZHJpdmVy
cy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgNjMgKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLQo+ICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmggfCAgOSArKysrKwo+
ICAyIGZpbGVzIGNoYW5nZWQsIDYzIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJpdmVycy92
ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gaW5kZXggNDBhMDNiMDhkN2NmLi5lZjU5MDdiMWQ1
MTMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gKysr
IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gQEAgLTYyNSwzMCArNjI1LDcw
IEBAIHN0YXRpYyB2b2lkIGNxX2Rlc3Ryb3koc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYsIHUx
NiBpZHgpCj4gICAgICAgICBtbHg1X2RiX2ZyZWUobmRldi0+bXZkZXYubWRldiwgJnZjcS0+ZGIp
Owo+ICB9Cj4KPiArc3RhdGljIGludCByZWFkX3VtZW1fcGFyYW1zKHN0cnVjdCBtbHg1X3ZkcGFf
bmV0ICpuZGV2KQo+ICt7Cj4gKyAgICAgICB1MzIgaW5bTUxYNV9TVF9TWl9EVyhxdWVyeV9oY2Ff
Y2FwX2luKV0gPSB7fTsKPiArICAgICAgIHUxNiBvcG1vZCA9IChNTFg1X0NBUF9WRFBBX0VNVUxB
VElPTiA8PCAxKSB8IChIQ0FfQ0FQX09QTU9EX0dFVF9DVVIgJiAweDAxKTsKPiArICAgICAgIHN0
cnVjdCBtbHg1X2NvcmVfZGV2ICptZGV2ID0gbmRldi0+bXZkZXYubWRldjsKPiArICAgICAgIGlu
dCBvdXRfc2l6ZTsKPiArICAgICAgIHZvaWQgKmNhcHM7Cj4gKyAgICAgICB2b2lkICpvdXQ7Cj4g
KyAgICAgICBpbnQgZXJyOwo+ICsKPiArICAgICAgIG91dF9zaXplID0gTUxYNV9TVF9TWl9CWVRF
UyhxdWVyeV9oY2FfY2FwX291dCk7Cj4gKyAgICAgICBvdXQgPSBremFsbG9jKG91dF9zaXplLCBH
RlBfS0VSTkVMKTsKPiArICAgICAgIGlmICghb3V0KQo+ICsgICAgICAgICAgICAgICByZXR1cm4g
LUVOT01FTTsKPiArCj4gKyAgICAgICBNTFg1X1NFVChxdWVyeV9oY2FfY2FwX2luLCBpbiwgb3Bj
b2RlLCBNTFg1X0NNRF9PUF9RVUVSWV9IQ0FfQ0FQKTsKPiArICAgICAgIE1MWDVfU0VUKHF1ZXJ5
X2hjYV9jYXBfaW4sIGluLCBvcF9tb2QsIG9wbW9kKTsKPiArICAgICAgIGVyciA9IG1seDVfY21k
X2V4ZWNfaW5vdXQobWRldiwgcXVlcnlfaGNhX2NhcCwgaW4sIG91dCk7Cj4gKyAgICAgICBpZiAo
ZXJyKSB7Cj4gKyAgICAgICAgICAgICAgIG1seDVfdmRwYV93YXJuKCZuZGV2LT5tdmRldiwKPiAr
ICAgICAgICAgICAgICAgICAgICAgICAiRmFpbGVkIHJlYWRpbmcgdmRwYSB1bWVtIGNhcGFiaWxp
dGllcyB3aXRoIGVyciAlZFxuIiwgZXJyKTsKPiArICAgICAgICAgICAgICAgZ290byBvdXQ7Cj4g
KyAgICAgICB9Cj4gKwo+ICsgICAgICAgY2FwcyA9ICBNTFg1X0FERFJfT0YocXVlcnlfaGNhX2Nh
cF9vdXQsIG91dCwgY2FwYWJpbGl0eSk7Cj4gKwo+ICsgICAgICAgbmRldi0+dW1lbV8xX2J1ZmZl
cl9wYXJhbV9hID0gTUxYNV9HRVQodmlydGlvX2VtdWxhdGlvbl9jYXAsIGNhcHMsIHVtZW1fMV9i
dWZmZXJfcGFyYW1fYSk7Cj4gKyAgICAgICBuZGV2LT51bWVtXzFfYnVmZmVyX3BhcmFtX2IgPSBN
TFg1X0dFVCh2aXJ0aW9fZW11bGF0aW9uX2NhcCwgY2FwcywgdW1lbV8xX2J1ZmZlcl9wYXJhbV9i
KTsKPiArCj4gKyAgICAgICBuZGV2LT51bWVtXzJfYnVmZmVyX3BhcmFtX2EgPSBNTFg1X0dFVCh2
aXJ0aW9fZW11bGF0aW9uX2NhcCwgY2FwcywgdW1lbV8yX2J1ZmZlcl9wYXJhbV9hKTsKPiArICAg
ICAgIG5kZXYtPnVtZW1fMl9idWZmZXJfcGFyYW1fYiA9IE1MWDVfR0VUKHZpcnRpb19lbXVsYXRp
b25fY2FwLCBjYXBzLCB1bWVtXzJfYnVmZmVyX3BhcmFtX2IpOwo+ICsKPiArICAgICAgIG5kZXYt
PnVtZW1fM19idWZmZXJfcGFyYW1fYSA9IE1MWDVfR0VUKHZpcnRpb19lbXVsYXRpb25fY2FwLCBj
YXBzLCB1bWVtXzNfYnVmZmVyX3BhcmFtX2EpOwo+ICsgICAgICAgbmRldi0+dW1lbV8zX2J1ZmZl
cl9wYXJhbV9iID0gTUxYNV9HRVQodmlydGlvX2VtdWxhdGlvbl9jYXAsIGNhcHMsIHVtZW1fM19i
dWZmZXJfcGFyYW1fYik7Cj4gKwo+ICtvdXQ6Cj4gKyAgICAgICBrZnJlZShvdXQpOwo+ICsgICAg
ICAgcmV0dXJuIDA7Cj4gK30KPiArCj4gIHN0YXRpYyB2b2lkIHNldF91bWVtX3NpemUoc3RydWN0
IG1seDVfdmRwYV9uZXQgKm5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVlICptdnEsIGlu
dCBudW0sCj4gICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgbWx4NV92ZHBhX3VtZW0g
Kip1bWVtcCkKPiAgewo+IC0gICAgICAgc3RydWN0IG1seDVfY29yZV9kZXYgKm1kZXYgPSBuZGV2
LT5tdmRldi5tZGV2Owo+IC0gICAgICAgaW50IHBfYTsKPiAtICAgICAgIGludCBwX2I7Cj4gKyAg
ICAgICB1MzIgcF9hOwo+ICsgICAgICAgdTMyIHBfYjsKPgo+ICAgICAgICAgc3dpdGNoIChudW0p
IHsKPiAgICAgICAgIGNhc2UgMToKPiAtICAgICAgICAgICAgICAgcF9hID0gTUxYNV9DQVBfREVW
X1ZEUEFfRU1VTEFUSU9OKG1kZXYsIHVtZW1fMV9idWZmZXJfcGFyYW1fYSk7Cj4gLSAgICAgICAg
ICAgICAgIHBfYiA9IE1MWDVfQ0FQX0RFVl9WRFBBX0VNVUxBVElPTihtZGV2LCB1bWVtXzFfYnVm
ZmVyX3BhcmFtX2IpOwo+ICsgICAgICAgICAgICAgICBwX2EgPSBuZGV2LT51bWVtXzFfYnVmZmVy
X3BhcmFtX2E7Cj4gKyAgICAgICAgICAgICAgIHBfYiA9IG5kZXYtPnVtZW1fMV9idWZmZXJfcGFy
YW1fYjsKPiAgICAgICAgICAgICAgICAgKnVtZW1wID0gJm12cS0+dW1lbTE7Cj4gICAgICAgICAg
ICAgICAgIGJyZWFrOwo+ICAgICAgICAgY2FzZSAyOgo+IC0gICAgICAgICAgICAgICBwX2EgPSBN
TFg1X0NBUF9ERVZfVkRQQV9FTVVMQVRJT04obWRldiwgdW1lbV8yX2J1ZmZlcl9wYXJhbV9hKTsK
PiAtICAgICAgICAgICAgICAgcF9iID0gTUxYNV9DQVBfREVWX1ZEUEFfRU1VTEFUSU9OKG1kZXYs
IHVtZW1fMl9idWZmZXJfcGFyYW1fYik7Cj4gKyAgICAgICAgICAgICAgIHBfYSA9IG5kZXYtPnVt
ZW1fMl9idWZmZXJfcGFyYW1fYTsKPiArICAgICAgICAgICAgICAgcF9iID0gbmRldi0+dW1lbV8y
X2J1ZmZlcl9wYXJhbV9iOwo+ICAgICAgICAgICAgICAgICAqdW1lbXAgPSAmbXZxLT51bWVtMjsK
PiAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gICAgICAgICBjYXNlIDM6Cj4gLSAgICAgICAgICAg
ICAgIHBfYSA9IE1MWDVfQ0FQX0RFVl9WRFBBX0VNVUxBVElPTihtZGV2LCB1bWVtXzNfYnVmZmVy
X3BhcmFtX2EpOwo+IC0gICAgICAgICAgICAgICBwX2IgPSBNTFg1X0NBUF9ERVZfVkRQQV9FTVVM
QVRJT04obWRldiwgdW1lbV8zX2J1ZmZlcl9wYXJhbV9iKTsKPiArICAgICAgICAgICAgICAgcF9h
ID0gbmRldi0+dW1lbV8zX2J1ZmZlcl9wYXJhbV9hOwo+ICsgICAgICAgICAgICAgICBwX2IgPSBu
ZGV2LT51bWVtXzNfYnVmZmVyX3BhcmFtX2I7Cj4gICAgICAgICAgICAgICAgICp1bWVtcCA9ICZt
dnEtPnVtZW0zOwo+ICAgICAgICAgICAgICAgICBicmVhazsKPiAgICAgICAgIH0KPiArCj4gICAg
ICAgICAoKnVtZW1wKS0+c2l6ZSA9IHBfYSAqIG12cS0+bnVtX2VudCArIHBfYjsKPiAgfQo+Cj4g
QEAgLTI2NzksNiArMjcxOSwxMSBAQCBzdGF0aWMgaW50IHNldHVwX2RyaXZlcihzdHJ1Y3QgbWx4
NV92ZHBhX2RldiAqbXZkZXYpCj4gICAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+ICAgICAgICAg
fQo+ICAgICAgICAgbWx4NV92ZHBhX2FkZF9kZWJ1Z2ZzKG5kZXYpOwo+ICsKPiArICAgICAgIGVy
ciA9IHJlYWRfdW1lbV9wYXJhbXMobmRldik7Cj4gKyAgICAgICBpZiAoZXJyKQo+ICsgICAgICAg
ICAgICAgICBnb3RvIGVycl9zZXR1cDsKPiArCj4gICAgICAgICBlcnIgPSBzZXR1cF92aXJ0cXVl
dWVzKG12ZGV2KTsKPiAgICAgICAgIGlmIChlcnIpIHsKPiAgICAgICAgICAgICAgICAgbWx4NV92
ZHBhX3dhcm4obXZkZXYsICJzZXR1cF92aXJ0cXVldWVzXG4iKTsKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5oIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21s
eDVfdm5ldC5oCj4gaW5kZXggMzZjNDRkOWZkZDE2Li42NWViYmJhMjA2NjIgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5oCj4gKysrIGIvZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5oCj4gQEAgLTY1LDYgKzY1LDE1IEBAIHN0cnVjdCBtbHg1X3Zk
cGFfbmV0IHsKPiAgICAgICAgIHN0cnVjdCBobGlzdF9oZWFkIG1hY3ZsYW5faGFzaFtNTFg1Vl9N
QUNWTEFOX1NJWkVdOwo+ICAgICAgICAgc3RydWN0IG1seDVfdmRwYV9pcnFfcG9vbCBpcnFwOwo+
ICAgICAgICAgc3RydWN0IGRlbnRyeSAqZGVidWdmczsKPiArCj4gKyAgICAgICB1MzIgdW1lbV8x
X2J1ZmZlcl9wYXJhbV9hOwo+ICsgICAgICAgdTMyIHVtZW1fMV9idWZmZXJfcGFyYW1fYjsKPiAr
Cj4gKyAgICAgICB1MzIgdW1lbV8yX2J1ZmZlcl9wYXJhbV9hOwo+ICsgICAgICAgdTMyIHVtZW1f
Ml9idWZmZXJfcGFyYW1fYjsKPiArCj4gKyAgICAgICB1MzIgdW1lbV8zX2J1ZmZlcl9wYXJhbV9h
Owo+ICsgICAgICAgdTMyIHVtZW1fM19idWZmZXJfcGFyYW1fYjsKPiAgfTsKPgo+ICBzdHJ1Y3Qg
bWx4NV92ZHBhX2NvdW50ZXIgewo+IC0tCj4gMi40MS4wCj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
