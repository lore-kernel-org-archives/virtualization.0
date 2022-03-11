Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78BBC433EF
	for <virtualization@archiver.kernel.org>; Fri, 11 Mar 2022 05:06:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3AFC4405AE;
	Fri, 11 Mar 2022 05:06:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vswjoW9r77Zz; Fri, 11 Mar 2022 05:06:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5E4DF40138;
	Fri, 11 Mar 2022 05:06:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BF72C0012;
	Fri, 11 Mar 2022 05:06:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF811C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 05:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B82E360671
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 05:06:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PNRzNEF8uR_7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 05:06:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DF6CA60601
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 05:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646975164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fv0x+1VoYiMUKdKtNJKiJ1SoB5j1+sfzfwwiDTV8v0U=;
 b=goI1wucyfhrRjb2LqdhjZG9vbdQLBH5/8UG7Mgl8m46EbR14NS03hpZOOJB0dIXb6TFL0Y
 b3HYZNFovqx/dixROdco0UQiuTDuL4OdY6XCreGOvRghfl0x26Wvsqs56Z71EjoZb/dzm/
 SAKEKRgB/2jbHhMMiC/G/mXzVbWPj6Q=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-OJnG3UhQPjSzkwzjcch_Kg-1; Fri, 11 Mar 2022 00:06:03 -0500
X-MC-Unique: OJnG3UhQPjSzkwzjcch_Kg-1
Received: by mail-pf1-f197.google.com with SMTP id
 z194-20020a627ecb000000b004f6db380a59so4535896pfc.19
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 21:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Fv0x+1VoYiMUKdKtNJKiJ1SoB5j1+sfzfwwiDTV8v0U=;
 b=aJnVltzxylEq1nRX/vH/gvHtgAIBz+o0mX4Llph1K2fi6uplLsb9g9RQstD+XBFiMz
 HiNbNM5Gvq/neV6CAnDaMOxrDfKhSAriED7ZgO+zuS62AOWvTD9hTf4iAm0s2lRCY2Zq
 E/KpwtaLPK8fQwb2daWYe++DkMFVIOEp8+U/TtTNvoNR1i2IihIn+3uiDJPgjs3FmSZy
 VcAQ0eNi9rY+G15x18HO3b+WXPPzNeOjuEOxvxSF/gqx5TLbBqLhmdzGQWmJhX59szhb
 mowgiAmiikSVpzNsqjGsXAXYED6WrZiIJiaoxkZnqKI38DMiJ1d0e/v7jMc+QvrWRNuK
 D4rQ==
X-Gm-Message-State: AOAM530WbRUfUB3uGWDZtyi1cPgZ28cdBNUmavQ1Y3hVgvn+oRjXt8JB
 1RjlP9sOf7zQo7UpgPYCOKxB5MBXO4nQLcGoQWAH1nHnll4RemsQhTkci0VKTiWrRGoC0DYinPW
 S95GWntLr/RE7Q9H7Q4LyW2LiHnAgohUnt49rkvNcoQ==
X-Received: by 2002:a65:6943:0:b0:376:333b:1025 with SMTP id
 w3-20020a656943000000b00376333b1025mr6951043pgq.164.1646975162475; 
 Thu, 10 Mar 2022 21:06:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxD3Bx61otH/mEyxC9XMtKu0q2dVWdhVfXlDv+iqZjtIoCxQvw239yb0wy+o8Y5dbByJp1/ng==
X-Received: by 2002:a65:6943:0:b0:376:333b:1025 with SMTP id
 w3-20020a656943000000b00376333b1025mr6951009pgq.164.1646975162136; 
 Thu, 10 Mar 2022 21:06:02 -0800 (PST)
Received: from [10.72.13.226] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 g15-20020a056a0023cf00b004e17e11cb17sm9537352pfc.111.2022.03.10.21.05.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Mar 2022 21:06:01 -0800 (PST)
Message-ID: <55348e9d-2b8f-4e32-682f-2218c2fb517a@redhat.com>
Date: Fri, 11 Mar 2022 13:05:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH v7 17/26] virtio_pci: queue_reset: support
 VIRTIO_F_RING_RESET
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-18-xuanzhuo@linux.alibaba.com>
 <8b9d337d-71c2-07b4-8e65-6f83cf09bf7a@redhat.com>
 <1646818328.2590482-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <1646818328.2590482-9-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 Heiko Carstens <hca@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, kvm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzMvOSDkuIvljYg1OjMyLCBYdWFuIFpodW8g5YaZ6YGTOgo+IE9uIFdlZCwgOSBN
YXIgMjAyMiAxNjo1NDoxMCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4+IOWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g5YaZ6YGTOgo+Pj4g
VGhpcyBwYXRjaCBpbXBsZW1lbnRzIHZpcnRpbyBwY2kgc3VwcG9ydCBmb3IgUVVFVUUgUkVTRVQu
Cj4+Pgo+Pj4gUGVyZm9ybWluZyByZXNldCBvbiBhIHF1ZXVlIGlzIGRpdmlkZWQgaW50byB0aGVz
ZSBzdGVwczoKPj4+Cj4+PiAgICAxLiB2aXJ0aW9fcmVzZXRfdnEoKSAgICAgICAgICAgICAgLSBu
b3RpZnkgdGhlIGRldmljZSB0byByZXNldCB0aGUgcXVldWUKPj4+ICAgIDIuIHZpcnRxdWV1ZV9k
ZXRhY2hfdW51c2VkX2J1ZigpICAtIHJlY3ljbGUgdGhlIGJ1ZmZlciBzdWJtaXR0ZWQKPj4+ICAg
IDMuIHZpcnRxdWV1ZV9yZXNldF92cmluZygpICAgICAgICAtIHJlc2V0IHRoZSB2cmluZyAobWF5
IHJlLWFsbG9jKQo+Pj4gICAgNC4gdmlydGlvX2VuYWJsZV9yZXNldHEoKSAgICAgICAgIC0gbW1h
cCB2cmluZyB0byBkZXZpY2UsIGFuZCBlbmFibGUgdGhlIHF1ZXVlCj4+Pgo+Pj4gVGhpcyBwYXRj
aCBpbXBsZW1lbnRzIHZpcnRpb19yZXNldF92cSgpLCB2aXJ0aW9fZW5hYmxlX3Jlc2V0cSgpIGlu
IHRoZQo+Pj4gcGNpIHNjZW5hcmlvLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8
eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4+PiAtLS0KPj4+ICAgIGRyaXZlcnMvdmlydGlv
L3ZpcnRpb19wY2lfY29tbW9uLmMgfCAgOCArLS0KPj4+ICAgIGRyaXZlcnMvdmlydGlvL3ZpcnRp
b19wY2lfbW9kZXJuLmMgfCA4MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPj4+ICAg
IDIgZmlsZXMgY2hhbmdlZCwgODggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPj4+Cj4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYyBiL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPj4+IGluZGV4IGZkYmRlMWRiNWVjNS4uODYz
ZDNhOGEwOTU2IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21t
b24uYwo+Pj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYwo+Pj4gQEAg
LTI0OCw5ICsyNDgsMTEgQEAgc3RhdGljIHZvaWQgdnBfZGVsX3ZxKHN0cnVjdCB2aXJ0cXVldWUg
KnZxKQo+Pj4gICAgCXN0cnVjdCB2aXJ0aW9fcGNpX3ZxX2luZm8gKmluZm8gPSB2cF9kZXYtPnZx
c1t2cS0+aW5kZXhdOwo+Pj4gICAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7Cj4+Pgo+Pj4gLQlzcGlu
X2xvY2tfaXJxc2F2ZSgmdnBfZGV2LT5sb2NrLCBmbGFncyk7Cj4+PiAtCWxpc3RfZGVsKCZpbmZv
LT5ub2RlKTsKPj4+IC0Jc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmdnBfZGV2LT5sb2NrLCBmbGFn
cyk7Cj4+PiArCWlmICghdnEtPnJlc2V0KSB7Cj4+PiArCQlzcGluX2xvY2tfaXJxc2F2ZSgmdnBf
ZGV2LT5sb2NrLCBmbGFncyk7Cj4+PiArCQlsaXN0X2RlbCgmaW5mby0+bm9kZSk7Cj4+PiArCQlz
cGluX3VubG9ja19pcnFyZXN0b3JlKCZ2cF9kZXYtPmxvY2ssIGZsYWdzKTsKPj4+ICsJfQo+Pj4K
Pj4+ICAgIAl2cF9kZXYtPmRlbF92cShpbmZvKTsKPj4+ICAgIAlrZnJlZShpbmZvKTsKPj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5jIGIvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYwo+Pj4gaW5kZXggNDlhNDQ5MzczMmNmLi4zYzY3ZDM2
MDc4MDIgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5j
Cj4+PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5jCj4+PiBAQCAtMzQs
NiArMzQsOSBAQCBzdGF0aWMgdm9pZCB2cF90cmFuc3BvcnRfZmVhdHVyZXMoc3RydWN0IHZpcnRp
b19kZXZpY2UgKnZkZXYsIHU2NCBmZWF0dXJlcykKPj4+ICAgIAlpZiAoKGZlYXR1cmVzICYgQklU
X1VMTChWSVJUSU9fRl9TUl9JT1YpKSAmJgo+Pj4gICAgCQkJcGNpX2ZpbmRfZXh0X2NhcGFiaWxp
dHkocGNpX2RldiwgUENJX0VYVF9DQVBfSURfU1JJT1YpKQo+Pj4gICAgCQlfX3ZpcnRpb19zZXRf
Yml0KHZkZXYsIFZJUlRJT19GX1NSX0lPVik7Cj4+PiArCj4+PiArCWlmIChmZWF0dXJlcyAmIEJJ
VF9VTEwoVklSVElPX0ZfUklOR19SRVNFVCkpCj4+PiArCQlfX3ZpcnRpb19zZXRfYml0KHZkZXYs
IFZJUlRJT19GX1JJTkdfUkVTRVQpOwo+Pj4gICAgfQo+Pj4KPj4+ICAgIC8qIHZpcnRpbyBjb25m
aWctPmZpbmFsaXplX2ZlYXR1cmVzKCkgaW1wbGVtZW50YXRpb24gKi8KPj4+IEBAIC0xOTksNiAr
MjAyLDgyIEBAIHN0YXRpYyBpbnQgdnBfYWN0aXZlX3ZxKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCB1
MTYgbXNpeF92ZWMpCj4+PiAgICAJcmV0dXJuIDA7Cj4+PiAgICB9Cj4+Pgo+Pj4gK3N0YXRpYyBp
bnQgdnBfbW9kZXJuX3Jlc2V0X3ZxKHN0cnVjdCB2aXJ0cXVldWUgKnZxKQo+Pj4gK3sKPj4+ICsJ
c3RydWN0IHZpcnRpb19wY2lfZGV2aWNlICp2cF9kZXYgPSB0b192cF9kZXZpY2UodnEtPnZkZXYp
Owo+Pj4gKwlzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlICptZGV2ID0gJnZwX2Rldi0+
bWRldjsKPj4+ICsJc3RydWN0IHZpcnRpb19wY2lfdnFfaW5mbyAqaW5mbzsKPj4+ICsJdW5zaWdu
ZWQgbG9uZyBmbGFnczsKPj4+ICsJdW5zaWduZWQgaW50IGlycTsKPj4+ICsKPj4+ICsJaWYgKCF2
aXJ0aW9faGFzX2ZlYXR1cmUodnEtPnZkZXYsIFZJUlRJT19GX1JJTkdfUkVTRVQpKQo+Pj4gKwkJ
cmV0dXJuIC1FTk9FTlQ7Cj4+PiArCj4+PiArCXZwX21vZGVybl9zZXRfcXVldWVfcmVzZXQobWRl
diwgdnEtPmluZGV4KTsKPj4+ICsKPj4+ICsJaW5mbyA9IHZwX2Rldi0+dnFzW3ZxLT5pbmRleF07
Cj4+PiArCj4+PiArCS8qIGRlbGV0ZSB2cSBmcm9tIGlycSBoYW5kbGVyICovCj4+PiArCXNwaW5f
bG9ja19pcnFzYXZlKCZ2cF9kZXYtPmxvY2ssIGZsYWdzKTsKPj4+ICsJbGlzdF9kZWwoJmluZm8t
Pm5vZGUpOwo+Pj4gKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ2cF9kZXYtPmxvY2ssIGZsYWdz
KTsKPj4+ICsKPj4+ICsJSU5JVF9MSVNUX0hFQUQoJmluZm8tPm5vZGUpOwo+Pj4gKwo+Pj4gKwl2
cS0+cmVzZXQgPSBWSVJUSU9fVlFfUkVTRVRfU1RFUF9ERVZJQ0U7Cj4+PiArCj4+PiArCS8qIHN5
bmMgaXJxIGNhbGxiYWNrLiAqLwo+Pj4gKwlpZiAodnBfZGV2LT5pbnR4X2VuYWJsZWQpIHsKPj4+
ICsJCWlycSA9IHZwX2Rldi0+cGNpX2Rldi0+aXJxOwo+Pj4gKwo+Pj4gKwl9IGVsc2Ugewo+Pj4g
KwkJaWYgKGluZm8tPm1zaXhfdmVjdG9yID09IFZJUlRJT19NU0lfTk9fVkVDVE9SKQo+Pj4gKwkJ
CXJldHVybiAwOwo+Pj4gKwo+Pj4gKwkJaXJxID0gcGNpX2lycV92ZWN0b3IodnBfZGV2LT5wY2lf
ZGV2LCBpbmZvLT5tc2l4X3ZlY3Rvcik7Cj4+PiArCX0KPj4+ICsKPj4+ICsJc3luY2hyb25pemVf
aXJxKGlycSk7Cj4+Cj4+IFN5bmNocm9uaXplX2lycSgpIGlzIG5vdCBzdWZmaWNpZW50IGhlcmUg
c2luY2UgaXQgYnJlYWtzIHRoZSBlZmZvcnQgb2YKPj4gdGhlIGludGVycnVwdCBoYXJkZW5pbmcg
d2hpY2ggaXMgZG9uZSBieSBjb21taXRzOgo+Pgo+PiAwODBjZDdjM2FjODcgdmlydGlvLXBjaTog
aGFyZGVuIElOVFggaW50ZXJydXB0cwo+PiA5ZTM1Mjc2YTUzNDQgdmlydGlvX3BjaTogaGFyZGVu
IE1TSS1YIGludGVycnVwdHMKPj4KPj4gVW5mb3J0dW5hdGVsecKgIDA4MGNkN2MzYWM4NyBpbnRy
b2R1Y2VzIGFuIGlzc3VlIHRoYXQgZGlzYWJsZV9pcnEoKSB3ZXJlCj4+IHVzZWQgZm9yIHRoZSBh
ZmZpbml0eSBtYW5hZ2VkIGlycSBidXQgd2UncmUgZGlzY3Vzc2luZyBhIGZpeC4KPiBJIG5lZWQg
dG8gdW5kZXJzdGFuZCBpdCBmaXJzdC4KPgo+Pgo+Pj4gKwo+Pj4gKwlyZXR1cm4gMDsKPj4+ICt9
Cj4+PiArCj4+PiArc3RhdGljIGludCB2cF9tb2Rlcm5fZW5hYmxlX3Jlc2V0X3ZxKHN0cnVjdCB2
aXJ0cXVldWUgKnZxKQo+Pj4gK3sKPj4+ICsJc3RydWN0IHZpcnRpb19wY2lfZGV2aWNlICp2cF9k
ZXYgPSB0b192cF9kZXZpY2UodnEtPnZkZXYpOwo+Pj4gKwlzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rl
cm5fZGV2aWNlICptZGV2ID0gJnZwX2Rldi0+bWRldjsKPj4+ICsJc3RydWN0IHZpcnRpb19wY2lf
dnFfaW5mbyAqaW5mbzsKPj4+ICsJdW5zaWduZWQgbG9uZyBmbGFncywgaW5kZXg7Cj4+PiArCWlu
dCBlcnI7Cj4+PiArCj4+PiArCWlmICh2cS0+cmVzZXQgIT0gVklSVElPX1ZRX1JFU0VUX1NURVBf
VlJJTkdfQVRUQUNIKQo+Pj4gKwkJcmV0dXJuIC1FQlVTWTsKPj4+ICsKPj4+ICsJaW5kZXggPSB2
cS0+aW5kZXg7Cj4+PiArCWluZm8gPSB2cF9kZXYtPnZxc1tpbmRleF07Cj4+PiArCj4+PiArCS8q
IGNoZWNrIHF1ZXVlIHJlc2V0IHN0YXR1cyAqLwo+Pj4gKwlpZiAodnBfbW9kZXJuX2dldF9xdWV1
ZV9yZXNldChtZGV2LCBpbmRleCkgIT0gMSkKPj4+ICsJCXJldHVybiAtRUJVU1k7Cj4+PiArCj4+
PiArCWVyciA9IHZwX2FjdGl2ZV92cSh2cSwgaW5mby0+bXNpeF92ZWN0b3IpOwo+Pj4gKwlpZiAo
ZXJyKQo+Pj4gKwkJcmV0dXJuIGVycjsKPj4+ICsKPj4+ICsJaWYgKHZxLT5jYWxsYmFjaykgewo+
Pj4gKwkJc3Bpbl9sb2NrX2lycXNhdmUoJnZwX2Rldi0+bG9jaywgZmxhZ3MpOwo+Pj4gKwkJbGlz
dF9hZGQoJmluZm8tPm5vZGUsICZ2cF9kZXYtPnZpcnRxdWV1ZXMpOwo+Pj4gKwkJc3Bpbl91bmxv
Y2tfaXJxcmVzdG9yZSgmdnBfZGV2LT5sb2NrLCBmbGFncyk7Cj4+PiArCX0gZWxzZSB7Cj4+PiAr
CQlJTklUX0xJU1RfSEVBRCgmaW5mby0+bm9kZSk7Cj4+PiArCX0KPj4+ICsKPj4+ICsJdnBfbW9k
ZXJuX3NldF9xdWV1ZV9lbmFibGUoJnZwX2Rldi0+bWRldiwgaW5kZXgsIHRydWUpOwo+Pgo+PiBB
bnkgcmVhc29uIHdlIG5lZWQgdG8gY2hlY2sgcXVldWVfZW5hYmxlKCkgaGVyZT8KPiBUaGUgcHVy
cG9zZSBvZiB0aGlzIGZ1bmN0aW9uIGlzIHRvIGVuYWJsZSBhIHJlc2V0IHZxLCBzbyBjYWxsIHF1
ZXVlX2VuYWJsZSgpIHRvCj4gYWN0aXZhdGUgaXQuCgoKT2ssIHRoaXMgaXMgd2hhdCBzcGVjIG1h
bmRhdGUuCgpUaGFua3MKCgo+Cj4gVGhhbmtzLgo+Cj4+IFRoYW5rcwo+Pgo+Pgo+Pj4gKwl2cS0+
cmVzZXQgPSBWSVJUSU9fVlFfUkVTRVRfU1RFUF9OT05FOwo+Pj4gKwo+Pj4gKwlyZXR1cm4gMDsK
Pj4+ICt9Cj4+PiArCj4+PiAgICBzdGF0aWMgdTE2IHZwX2NvbmZpZ192ZWN0b3Ioc3RydWN0IHZp
cnRpb19wY2lfZGV2aWNlICp2cF9kZXYsIHUxNiB2ZWN0b3IpCj4+PiAgICB7Cj4+PiAgICAJcmV0
dXJuIHZwX21vZGVybl9jb25maWdfdmVjdG9yKCZ2cF9kZXYtPm1kZXYsIHZlY3Rvcik7Cj4+PiBA
QCAtNDA3LDYgKzQ4Niw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmlydGlvX2NvbmZpZ19vcHMg
dmlydGlvX3BjaV9jb25maWdfbm9kZXZfb3BzID0gewo+Pj4gICAgCS5zZXRfdnFfYWZmaW5pdHkg
PSB2cF9zZXRfdnFfYWZmaW5pdHksCj4+PiAgICAJLmdldF92cV9hZmZpbml0eSA9IHZwX2dldF92
cV9hZmZpbml0eSwKPj4+ICAgIAkuZ2V0X3NobV9yZWdpb24gID0gdnBfZ2V0X3NobV9yZWdpb24s
Cj4+PiArCS5yZXNldF92cQkgPSB2cF9tb2Rlcm5fcmVzZXRfdnEsCj4+PiArCS5lbmFibGVfcmVz
ZXRfdnEgPSB2cF9tb2Rlcm5fZW5hYmxlX3Jlc2V0X3ZxLAo+Pj4gICAgfTsKPj4+Cj4+PiAgICBz
dGF0aWMgY29uc3Qgc3RydWN0IHZpcnRpb19jb25maWdfb3BzIHZpcnRpb19wY2lfY29uZmlnX29w
cyA9IHsKPj4+IEBAIC00MjUsNiArNTA2LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2aXJ0aW9f
Y29uZmlnX29wcyB2aXJ0aW9fcGNpX2NvbmZpZ19vcHMgPSB7Cj4+PiAgICAJLnNldF92cV9hZmZp
bml0eSA9IHZwX3NldF92cV9hZmZpbml0eSwKPj4+ICAgIAkuZ2V0X3ZxX2FmZmluaXR5ID0gdnBf
Z2V0X3ZxX2FmZmluaXR5LAo+Pj4gICAgCS5nZXRfc2htX3JlZ2lvbiAgPSB2cF9nZXRfc2htX3Jl
Z2lvbiwKPj4+ICsJLnJlc2V0X3ZxCSA9IHZwX21vZGVybl9yZXNldF92cSwKPj4+ICsJLmVuYWJs
ZV9yZXNldF92cSA9IHZwX21vZGVybl9lbmFibGVfcmVzZXRfdnEsCj4+PiAgICB9Owo+Pj4KPj4+
ICAgIC8qIHRoZSBQQ0kgcHJvYmluZyBmdW5jdGlvbiAqLwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
