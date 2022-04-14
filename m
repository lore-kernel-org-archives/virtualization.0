Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11976C433F5
	for <virtualization@archiver.kernel.org>; Thu, 14 Apr 2022 09:38:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 87204401DD;
	Thu, 14 Apr 2022 09:38:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2LeTByZXpdTu; Thu, 14 Apr 2022 09:38:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AAA3F401A2;
	Thu, 14 Apr 2022 09:38:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53209C002F;
	Thu, 14 Apr 2022 09:38:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B381C002C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 09:38:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 16DE383FA8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 09:38:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cdu47XI7YlVe
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 09:38:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 46FEC83F8A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 09:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649929084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kAYBz4doVQTzyQ+XbmAkl9XBH5XLaB98KdCbNRQGiq4=;
 b=LntbUP7SFJH/zQ7kPTF5x42lw1+Texq4xdKoj+NynhWV1I9l3HcsIL4vZmtOv5kAyd2jqD
 wkKdhoWL05KrTeZU7WFcQ1iG6u317x638eRxxQXEJlAY/7x9G4v+1JDm1kCYwyKooC8ySS
 9mwcdsMYL1h4iLZibbm3k4ml8ipfujs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-e7H7X6jbNtWypzEZ2TI6oA-1; Thu, 14 Apr 2022 05:38:03 -0400
X-MC-Unique: e7H7X6jbNtWypzEZ2TI6oA-1
Received: by mail-lf1-f70.google.com with SMTP id
 g6-20020a19ac06000000b00464f8022af9so2103612lfc.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 02:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kAYBz4doVQTzyQ+XbmAkl9XBH5XLaB98KdCbNRQGiq4=;
 b=sJGMfXanmIH0dGPpDZzxV3nP2HUwQklfnnJH5KtxuscSPiaEewF0UTbJ2ltY4j5lkh
 nHkj0Fi8JUeN0U9dMZk0mfq+p2A27Gc1GUXlmMfnRBw3g2Z/CGMJ/yd4eHe+r29MdDe1
 Wny1UOefmBs4MXBvLodyZj+iuBMCFPr7WrIA2sKScb2V1b5fvo0jNkzc6/vFLpozegWM
 K4NvJVSEMCQlCMwkswaRkJV0rR5iC6TmQuI2BI0UVAFIpZlYeccYCnwzs6rXXPBUyVfZ
 h8hf7J+g/vJMa8jjikLz/+gC4nXJQuJ5lj7IzdQsHT2ZKsTUXYZ4R8pjHkWDSxsywwj3
 RvBQ==
X-Gm-Message-State: AOAM530HbW4xG15iGOAyCfNSHuJG+bYD5/TlPFKLh2fjzoD90M5pFu0W
 sHl/W0BhVZthdvtSH9IIfzL/s5nuFWu/FGl3tgqQn99H+WkZ97noS414jgfGZWgfkIZLKDUBtNy
 olUm6pAE/Qz5dO14LQIEkS2x3Pvsfh8d8ixA1byMEUwJZ1OqjhrzjzRuF5g==
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr1374403lfv.257.1649929081555; 
 Thu, 14 Apr 2022 02:38:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyT+hQL3ayUr4yHsMFIRrMraYLhBZ1J0Bf6UbhSWT+Hf8Hn8S4DOLDQKv3/usDOYYaKjPbe8DoFTVvjkWCTmg0=
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr1374387lfv.257.1649929081317; Thu, 14
 Apr 2022 02:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-23-xuanzhuo@linux.alibaba.com>
 <d228a41f-a3a1-029d-f259-d4fbab822e78@redhat.com>
 <1649917349.6242197-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1649917349.6242197-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Apr 2022 17:37:50 +0800
Message-ID: <CACGkMEuk24R8Y-H2=cuG4VkQhTNf6CSEMJbxe7jvHFEusa815g@mail.gmail.com>
Subject: Re: [PATCH v9 22/32] virtio_pci: queue_reset: extract the logic of
 active vq for modern pci
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Heiko Carstens <hca@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, kvm <kvm@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev <netdev@vger.kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 "open list:XDP \(eXpress Data Path\)" <bpf@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

T24gVGh1LCBBcHIgMTQsIDIwMjIgYXQgMjoyNSBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgMTIgQXByIDIwMjIgMTQ6NTg6MTkgKzA4
MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IOWcqCAy
MDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiA+ID4gSW50cm9kdWNlIHZw
X2FjdGl2ZV92cSgpIHRvIGNvbmZpZ3VyZSB2cmluZyB0byBiYWNrZW5kIGFmdGVyIHZxIGF0dGFj
aAo+ID4gPiB2cmluZy4gQW5kIGNvbmZpZ3VyZSB2cSB2ZWN0b3IgaWYgbmVjZXNzYXJ5Lgo+ID4g
Pgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEu
Y29tPgo+ID4gPiAtLS0KPiA+ID4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5j
IHwgNDYgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCj4gPiA+ICAgMSBmaWxlIGNoYW5n
ZWQsIDI4IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQo+ID4gPgo+ID4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYyBiL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19wY2lfbW9kZXJuLmMKPiA+ID4gaW5kZXggODZkMzAxZjI3MmI4Li40OWE0NDkzNzMy
Y2YgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMK
PiA+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYwo+ID4gPiBAQCAt
MTc2LDYgKzE3NiwyOSBAQCBzdGF0aWMgdm9pZCB2cF9yZXNldChzdHJ1Y3QgdmlydGlvX2Rldmlj
ZSAqdmRldikKPiA+ID4gICAgIHZwX2Rpc2FibGVfY2JzKHZkZXYpOwo+ID4gPiAgIH0KPiA+ID4K
PiA+ID4gK3N0YXRpYyBpbnQgdnBfYWN0aXZlX3ZxKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCB1MTYg
bXNpeF92ZWMpCj4gPiA+ICt7Cj4gPiA+ICsgICBzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2UgKnZw
X2RldiA9IHRvX3ZwX2RldmljZSh2cS0+dmRldik7Cj4gPiA+ICsgICBzdHJ1Y3QgdmlydGlvX3Bj
aV9tb2Rlcm5fZGV2aWNlICptZGV2ID0gJnZwX2Rldi0+bWRldjsKPiA+ID4gKyAgIHVuc2lnbmVk
IGxvbmcgaW5kZXg7Cj4gPiA+ICsKPiA+ID4gKyAgIGluZGV4ID0gdnEtPmluZGV4Owo+ID4gPiAr
Cj4gPiA+ICsgICAvKiBhY3RpdmF0ZSB0aGUgcXVldWUgKi8KPiA+ID4gKyAgIHZwX21vZGVybl9z
ZXRfcXVldWVfc2l6ZShtZGV2LCBpbmRleCwgdmlydHF1ZXVlX2dldF92cmluZ19zaXplKHZxKSk7
Cj4gPiA+ICsgICB2cF9tb2Rlcm5fcXVldWVfYWRkcmVzcyhtZGV2LCBpbmRleCwgdmlydHF1ZXVl
X2dldF9kZXNjX2FkZHIodnEpLAo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgdmly
dHF1ZXVlX2dldF9hdmFpbF9hZGRyKHZxKSwKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHZpcnRxdWV1ZV9nZXRfdXNlZF9hZGRyKHZxKSk7Cj4gPiA+ICsKPiA+ID4gKyAgIGlmICht
c2l4X3ZlYyAhPSBWSVJUSU9fTVNJX05PX1ZFQ1RPUikgewo+ID4gPiArICAgICAgICAgICBtc2l4
X3ZlYyA9IHZwX21vZGVybl9xdWV1ZV92ZWN0b3IobWRldiwgaW5kZXgsIG1zaXhfdmVjKTsKPiA+
ID4gKyAgICAgICAgICAgaWYgKG1zaXhfdmVjID09IFZJUlRJT19NU0lfTk9fVkVDVE9SKQo+ID4g
PiArICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUJVU1k7Cj4gPiA+ICsgICB9Cj4gPiA+ICsK
PiA+ID4gKyAgIHJldHVybiAwOwo+ID4gPiArfQo+ID4gPiArCj4gPiA+ICAgc3RhdGljIHUxNiB2
cF9jb25maWdfdmVjdG9yKHN0cnVjdCB2aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2LCB1MTYgdmVj
dG9yKQo+ID4gPiAgIHsKPiA+ID4gICAgIHJldHVybiB2cF9tb2Rlcm5fY29uZmlnX3ZlY3Rvcigm
dnBfZGV2LT5tZGV2LCB2ZWN0b3IpOwo+ID4gPiBAQCAtMjIwLDMyICsyNDMsMTkgQEAgc3RhdGlj
IHN0cnVjdCB2aXJ0cXVldWUgKnNldHVwX3ZxKHN0cnVjdCB2aXJ0aW9fcGNpX2RldmljZSAqdnBf
ZGV2LAo+ID4gPgo+ID4gPiAgICAgdnEtPm51bV9tYXggPSBudW07Cj4gPiA+Cj4gPiA+IC0gICAv
KiBhY3RpdmF0ZSB0aGUgcXVldWUgKi8KPiA+ID4gLSAgIHZwX21vZGVybl9zZXRfcXVldWVfc2l6
ZShtZGV2LCBpbmRleCwgdmlydHF1ZXVlX2dldF92cmluZ19zaXplKHZxKSk7Cj4gPiA+IC0gICB2
cF9tb2Rlcm5fcXVldWVfYWRkcmVzcyhtZGV2LCBpbmRleCwgdmlydHF1ZXVlX2dldF9kZXNjX2Fk
ZHIodnEpLAo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgdmlydHF1ZXVlX2dldF9h
dmFpbF9hZGRyKHZxKSwKPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgIHZpcnRxdWV1
ZV9nZXRfdXNlZF9hZGRyKHZxKSk7Cj4gPiA+ICsgICBlcnIgPSB2cF9hY3RpdmVfdnEodnEsIG1z
aXhfdmVjKTsKPiA+ID4gKyAgIGlmIChlcnIpCj4gPiA+ICsgICAgICAgICAgIGdvdG8gZXJyOwo+
ID4gPgo+ID4gPiAgICAgdnEtPnByaXYgPSAodm9pZCBfX2ZvcmNlICopdnBfbW9kZXJuX21hcF92
cV9ub3RpZnkobWRldiwgaW5kZXgsIE5VTEwpOwo+ID4gPiAgICAgaWYgKCF2cS0+cHJpdikgewo+
ID4gPiAgICAgICAgICAgICBlcnIgPSAtRU5PTUVNOwo+ID4gPiAtICAgICAgICAgICBnb3RvIGVy
cl9tYXBfbm90aWZ5Owo+ID4gPiAtICAgfQo+ID4gPiAtCj4gPiA+IC0gICBpZiAobXNpeF92ZWMg
IT0gVklSVElPX01TSV9OT19WRUNUT1IpIHsKPiA+ID4gLSAgICAgICAgICAgbXNpeF92ZWMgPSB2
cF9tb2Rlcm5fcXVldWVfdmVjdG9yKG1kZXYsIGluZGV4LCBtc2l4X3ZlYyk7Cj4gPiA+IC0gICAg
ICAgICAgIGlmIChtc2l4X3ZlYyA9PSBWSVJUSU9fTVNJX05PX1ZFQ1RPUikgewo+ID4gPiAtICAg
ICAgICAgICAgICAgICAgIGVyciA9IC1FQlVTWTsKPiA+ID4gLSAgICAgICAgICAgICAgICAgICBn
b3RvIGVycl9hc3NpZ25fdmVjdG9yOwo+ID4gPiAtICAgICAgICAgICB9Cj4gPiA+ICsgICAgICAg
ICAgIGdvdG8gZXJyOwo+ID4gPiAgICAgfQo+ID4gPgo+ID4gPiAgICAgcmV0dXJuIHZxOwo+ID4g
Pgo+ID4gPiAtZXJyX2Fzc2lnbl92ZWN0b3I6Cj4gPiA+IC0gICBpZiAoIW1kZXYtPm5vdGlmeV9i
YXNlKQo+ID4gPiAtICAgICAgICAgICBwY2lfaW91bm1hcChtZGV2LT5wY2lfZGV2LCAodm9pZCBf
X2lvbWVtIF9fZm9yY2UgKil2cS0+cHJpdik7Cj4gPgo+ID4KPiA+IFdlIG5lZWQga2VlcCB0aGlz
IG9yIGFueXRoaW5nIEkgbWlzc2VkPwo+Cj4gSSB0aGluayBzbywgYWZ0ZXIgbW9kaWZpY2F0aW9u
LCB2cF9tb2Rlcm5fbWFwX3ZxX25vdGlmeSBpcyB0aGUgbGFzdCBzdGVwIGJlZm9yZQo+IHJldHVy
bmluZyB2cS4gSWYgaXQgZmFpbHMsIHRoZW4gdnEtPnByaXYgaXMgZXF1YWwgdG8gTlVMTCwgc28g
dGhlcmUgaXMgbm8gbmVlZAo+IHRvIGV4ZWN1dGUgcGNpX2lvdW5tYXAuCj4KPiBEaWQgSSBtaXNz
IHNvbWV0aGluZz8KCk5vcGUgSSBtaXNzIHRoYXQgdGhlIHZlY3RvciBpcyBjb25maWd1cmVkIGJl
Zm9yZSB0aGUgbWFwcGluZy4KClNvCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4KClRoYW5rcwoKPgo+IFRoYW5rcy4KPgo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+Cj4g
PiA+IC1lcnJfbWFwX25vdGlmeToKPiA+ID4gK2VycjoKPiA+ID4gICAgIHZyaW5nX2RlbF92aXJ0
cXVldWUodnEpOwo+ID4gPiAgICAgcmV0dXJuIEVSUl9QVFIoZXJyKTsKPiA+ID4gICB9Cj4gPgo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
