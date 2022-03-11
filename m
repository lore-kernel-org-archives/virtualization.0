Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141C7C433F5
	for <virtualization@archiver.kernel.org>; Fri, 11 Mar 2022 05:09:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5CEE60A9C;
	Fri, 11 Mar 2022 05:09:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X92M1porrrqS; Fri, 11 Mar 2022 05:09:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 23234600CA;
	Fri, 11 Mar 2022 05:09:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6D8FC001D;
	Fri, 11 Mar 2022 05:09:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F41B7C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 05:09:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D138E4199F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 05:09:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8XiKuAuV-YjG
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 05:09:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9E828403CC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 05:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646975391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9nBenv8s0AYm2+pJMUm/jGEPBjH6r3BWfbAB/qp2ZZE=;
 b=FCn4qYknp3cjGIw0wb7CorFRtNSVXhsFKgAOQYT7TKamIBSO2eps9DDVAFvFLuyAgLxm+n
 bPDDpJFPopeushBc+0oQ0beeI1vNBEoHG9eG8qhOwIoSDv3O2rHO9zEaLWi13wkd0HfkNt
 9G4GKh4xaumR7mJqBzb1Phw7fb+K6HU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-381-FnB78lbYMDyMZPIKwjP9ig-1; Fri, 11 Mar 2022 00:09:49 -0500
X-MC-Unique: FnB78lbYMDyMZPIKwjP9ig-1
Received: by mail-pj1-f70.google.com with SMTP id
 cl16-20020a17090af69000b001beea61ada4so4648910pjb.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 21:09:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=9nBenv8s0AYm2+pJMUm/jGEPBjH6r3BWfbAB/qp2ZZE=;
 b=dTOERZ4aVnBi3PIJyXQ9DxKmbjvmGbKOqvaRl3KGFH0WhuAXD3oJytuRyUIzclkyRF
 /MllmAjxkaJ0xDtufyorjgAdIbZDutOowOKPmD+zekNWH8iv75FW9DNLPAMnHE2ej83E
 IM4CdVJ1G5x7pcmavVJ8+hCubOAs2YZlFoTEohoa9H9SirSWNKZBAiMqyOtagVP2NCsH
 oluuvq8eGYM/Mi4vGLfFOHyHJbZE088Qcf44zQy+0wqhC6ziLVmm95++Z1rnjb9v01rZ
 hSb46Wn7WYe48/UmbrivbOVhn2PoCcEZOH8DA7Xw7iC0OhUK4zxjMqBHbguffgHVbb9S
 LP+A==
X-Gm-Message-State: AOAM531+g+mFs7LC6UxqCsB5m0ZWc17QE5xpKGXAGhk9mkcvITT/eUOP
 XDmn24KA0Pr7RifPbnUrJKTcbaHb3T1w0yYavMYmmnVQg+2zIPJjS/rW/gTIvk1TRlGsXDM8J9E
 8pjsAiEaVhulsYf2Iyo/0rRvKlSJmB9J3lo1pq5o9+g==
X-Received: by 2002:a17:90a:d3d0:b0:1bb:f5b3:2fbf with SMTP id
 d16-20020a17090ad3d000b001bbf5b32fbfmr8820739pjw.87.1646975387557; 
 Thu, 10 Mar 2022 21:09:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx8JKZXffEodSfmEHpMRgYWBvpIlhcshqGZgVYLA+ugGNosDsbJfihtdbxn5vtUMGsfzlzXdw==
X-Received: by 2002:a17:90a:d3d0:b0:1bb:f5b3:2fbf with SMTP id
 d16-20020a17090ad3d000b001bbf5b32fbfmr8820693pjw.87.1646975387226; 
 Thu, 10 Mar 2022 21:09:47 -0800 (PST)
Received: from [10.72.13.226] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a056a00240700b004e1cde37bc1sm8792099pfh.84.2022.03.10.21.09.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Mar 2022 21:09:46 -0800 (PST)
Message-ID: <06b3adbb-6777-7022-00d2-beca2b166e10@redhat.com>
Date: Fri, 11 Mar 2022 13:09:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH v7 17/26] virtio_pci: queue_reset: support
 VIRTIO_F_RING_RESET
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-18-xuanzhuo@linux.alibaba.com>
 <8b9d337d-71c2-07b4-8e65-6f83cf09bf7a@redhat.com>
 <1646900411.6481435-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <1646900411.6481435-2-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzMvMTAg5LiL5Y2INDoyMCwgWHVhbiBaaHVvIOWGmemBkzoKPiBPbiBXZWQsIDkg
TWFyIDIwMjIgMTY6NTQ6MTAgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
IHdyb3RlOgo+PiDlnKggMjAyMi8zLzgg5LiL5Y2IODozNSwgWHVhbiBaaHVvIOWGmemBkzoKPj4+
IFRoaXMgcGF0Y2ggaW1wbGVtZW50cyB2aXJ0aW8gcGNpIHN1cHBvcnQgZm9yIFFVRVVFIFJFU0VU
Lgo+Pj4KPj4+IFBlcmZvcm1pbmcgcmVzZXQgb24gYSBxdWV1ZSBpcyBkaXZpZGVkIGludG8gdGhl
c2Ugc3RlcHM6Cj4+Pgo+Pj4gICAgMS4gdmlydGlvX3Jlc2V0X3ZxKCkgICAgICAgICAgICAgIC0g
bm90aWZ5IHRoZSBkZXZpY2UgdG8gcmVzZXQgdGhlIHF1ZXVlCj4+PiAgICAyLiB2aXJ0cXVldWVf
ZGV0YWNoX3VudXNlZF9idWYoKSAgLSByZWN5Y2xlIHRoZSBidWZmZXIgc3VibWl0dGVkCj4+PiAg
ICAzLiB2aXJ0cXVldWVfcmVzZXRfdnJpbmcoKSAgICAgICAgLSByZXNldCB0aGUgdnJpbmcgKG1h
eSByZS1hbGxvYykKPj4+ICAgIDQuIHZpcnRpb19lbmFibGVfcmVzZXRxKCkgICAgICAgICAtIG1t
YXAgdnJpbmcgdG8gZGV2aWNlLCBhbmQgZW5hYmxlIHRoZSBxdWV1ZQo+Pj4KPj4+IFRoaXMgcGF0
Y2ggaW1wbGVtZW50cyB2aXJ0aW9fcmVzZXRfdnEoKSwgdmlydGlvX2VuYWJsZV9yZXNldHEoKSBp
biB0aGUKPj4+IHBjaSBzY2VuYXJpby4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8g
PHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+Pj4gLS0tCj4+PiAgICBkcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcGNpX2NvbW1vbi5jIHwgIDggKy0tCj4+PiAgICBkcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcGNpX21vZGVybi5jIHwgODMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4+PiAg
ICAyIGZpbGVzIGNoYW5nZWQsIDg4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+Pgo+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMgYi9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jCj4+PiBpbmRleCBmZGJkZTFkYjVlYzUuLjg2
M2QzYThhMDk1NiAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29t
bW9uLmMKPj4+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPj4+IEBA
IC0yNDgsOSArMjQ4LDExIEBAIHN0YXRpYyB2b2lkIHZwX2RlbF92cShzdHJ1Y3QgdmlydHF1ZXVl
ICp2cSkKPj4+ICAgIAlzdHJ1Y3QgdmlydGlvX3BjaV92cV9pbmZvICppbmZvID0gdnBfZGV2LT52
cXNbdnEtPmluZGV4XTsKPj4+ICAgIAl1bnNpZ25lZCBsb25nIGZsYWdzOwo+Pj4KPj4+IC0Jc3Bp
bl9sb2NrX2lycXNhdmUoJnZwX2Rldi0+bG9jaywgZmxhZ3MpOwo+Pj4gLQlsaXN0X2RlbCgmaW5m
by0+bm9kZSk7Cj4+PiAtCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnZwX2Rldi0+bG9jaywgZmxh
Z3MpOwo+Pj4gKwlpZiAoIXZxLT5yZXNldCkgewo+Pj4gKwkJc3Bpbl9sb2NrX2lycXNhdmUoJnZw
X2Rldi0+bG9jaywgZmxhZ3MpOwo+Pj4gKwkJbGlzdF9kZWwoJmluZm8tPm5vZGUpOwo+Pj4gKwkJ
c3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmdnBfZGV2LT5sb2NrLCBmbGFncyk7Cj4+PiArCX0KPj4+
Cj4+PiAgICAJdnBfZGV2LT5kZWxfdnEoaW5mbyk7Cj4+PiAgICAJa2ZyZWUoaW5mbyk7Cj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYyBiL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMKPj4+IGluZGV4IDQ5YTQ0OTM3MzJjZi4uM2M2N2Qz
NjA3ODAyIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4u
Ywo+Pj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYwo+Pj4gQEAgLTM0
LDYgKzM0LDkgQEAgc3RhdGljIHZvaWQgdnBfdHJhbnNwb3J0X2ZlYXR1cmVzKHN0cnVjdCB2aXJ0
aW9fZGV2aWNlICp2ZGV2LCB1NjQgZmVhdHVyZXMpCj4+PiAgICAJaWYgKChmZWF0dXJlcyAmIEJJ
VF9VTEwoVklSVElPX0ZfU1JfSU9WKSkgJiYKPj4+ICAgIAkJCXBjaV9maW5kX2V4dF9jYXBhYmls
aXR5KHBjaV9kZXYsIFBDSV9FWFRfQ0FQX0lEX1NSSU9WKSkKPj4+ICAgIAkJX192aXJ0aW9fc2V0
X2JpdCh2ZGV2LCBWSVJUSU9fRl9TUl9JT1YpOwo+Pj4gKwo+Pj4gKwlpZiAoZmVhdHVyZXMgJiBC
SVRfVUxMKFZJUlRJT19GX1JJTkdfUkVTRVQpKQo+Pj4gKwkJX192aXJ0aW9fc2V0X2JpdCh2ZGV2
LCBWSVJUSU9fRl9SSU5HX1JFU0VUKTsKPj4+ICAgIH0KPj4+Cj4+PiAgICAvKiB2aXJ0aW8gY29u
ZmlnLT5maW5hbGl6ZV9mZWF0dXJlcygpIGltcGxlbWVudGF0aW9uICovCj4+PiBAQCAtMTk5LDYg
KzIwMiw4MiBAQCBzdGF0aWMgaW50IHZwX2FjdGl2ZV92cShzdHJ1Y3QgdmlydHF1ZXVlICp2cSwg
dTE2IG1zaXhfdmVjKQo+Pj4gICAgCXJldHVybiAwOwo+Pj4gICAgfQo+Pj4KPj4+ICtzdGF0aWMg
aW50IHZwX21vZGVybl9yZXNldF92cShzdHJ1Y3QgdmlydHF1ZXVlICp2cSkKPj4+ICt7Cj4+PiAr
CXN0cnVjdCB2aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2ID0gdG9fdnBfZGV2aWNlKHZxLT52ZGV2
KTsKPj4+ICsJc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSAqbWRldiA9ICZ2cF9kZXYt
Pm1kZXY7Cj4+PiArCXN0cnVjdCB2aXJ0aW9fcGNpX3ZxX2luZm8gKmluZm87Cj4+PiArCXVuc2ln
bmVkIGxvbmcgZmxhZ3M7Cj4+PiArCXVuc2lnbmVkIGludCBpcnE7Cj4+PiArCj4+PiArCWlmICgh
dmlydGlvX2hhc19mZWF0dXJlKHZxLT52ZGV2LCBWSVJUSU9fRl9SSU5HX1JFU0VUKSkKPj4+ICsJ
CXJldHVybiAtRU5PRU5UOwo+Pj4gKwo+Pj4gKwl2cF9tb2Rlcm5fc2V0X3F1ZXVlX3Jlc2V0KG1k
ZXYsIHZxLT5pbmRleCk7Cj4+PiArCj4+PiArCWluZm8gPSB2cF9kZXYtPnZxc1t2cS0+aW5kZXhd
Owo+Pj4gKwo+Pj4gKwkvKiBkZWxldGUgdnEgZnJvbSBpcnEgaGFuZGxlciAqLwo+Pj4gKwlzcGlu
X2xvY2tfaXJxc2F2ZSgmdnBfZGV2LT5sb2NrLCBmbGFncyk7Cj4+PiArCWxpc3RfZGVsKCZpbmZv
LT5ub2RlKTsKPj4+ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmdnBfZGV2LT5sb2NrLCBmbGFn
cyk7Cj4+PiArCj4+PiArCUlOSVRfTElTVF9IRUFEKCZpbmZvLT5ub2RlKTsKPj4+ICsKPj4+ICsJ
dnEtPnJlc2V0ID0gVklSVElPX1ZRX1JFU0VUX1NURVBfREVWSUNFOwo+Pj4gKwo+Pj4gKwkvKiBz
eW5jIGlycSBjYWxsYmFjay4gKi8KPj4+ICsJaWYgKHZwX2Rldi0+aW50eF9lbmFibGVkKSB7Cj4+
PiArCQlpcnEgPSB2cF9kZXYtPnBjaV9kZXYtPmlycTsKPj4+ICsKPj4+ICsJfSBlbHNlIHsKPj4+
ICsJCWlmIChpbmZvLT5tc2l4X3ZlY3RvciA9PSBWSVJUSU9fTVNJX05PX1ZFQ1RPUikKPj4+ICsJ
CQlyZXR1cm4gMDsKPj4+ICsKPj4+ICsJCWlycSA9IHBjaV9pcnFfdmVjdG9yKHZwX2Rldi0+cGNp
X2RldiwgaW5mby0+bXNpeF92ZWN0b3IpOwo+Pj4gKwl9Cj4+PiArCj4+PiArCXN5bmNocm9uaXpl
X2lycShpcnEpOwo+Pgo+PiBTeW5jaHJvbml6ZV9pcnEoKSBpcyBub3Qgc3VmZmljaWVudCBoZXJl
IHNpbmNlIGl0IGJyZWFrcyB0aGUgZWZmb3J0IG9mCj4+IHRoZSBpbnRlcnJ1cHQgaGFyZGVuaW5n
IHdoaWNoIGlzIGRvbmUgYnkgY29tbWl0czoKPj4KPj4gMDgwY2Q3YzNhYzg3IHZpcnRpby1wY2k6
IGhhcmRlbiBJTlRYIGludGVycnVwdHMKPj4gOWUzNTI3NmE1MzQ0IHZpcnRpb19wY2k6IGhhcmRl
biBNU0ktWCBpbnRlcnJ1cHRzCj4+Cj4+IFVuZm9ydHVuYXRlbHnCoCAwODBjZDdjM2FjODcgaW50
cm9kdWNlcyBhbiBpc3N1ZSB0aGF0IGRpc2FibGVfaXJxKCkgd2VyZQo+PiB1c2VkIGZvciB0aGUg
YWZmaW5pdHkgbWFuYWdlZCBpcnEgYnV0IHdlJ3JlIGRpc2N1c3NpbmcgYSBmaXguCj4+Cj4KPiBv
aywgSSB0aGluayBkaXNhYmxlX2lycSgpIGlzIHN0aWxsIHVzZWQgaGVyZS4KPgo+IEkgd2FudCB0
byBkZXRlcm1pbmUgdGhlIHNvbHV0aW9uIGZvciB0aGlzIGRldGFpbCBmaXJzdC4gU28gSSBwb3N0
ZWQgdGhlIGNvZGUsIEkKPiBob3BlIEphc29uIGNhbiBoZWxwIGNvbmZpcm0gdGhpcyBwb2ludCBm
aXJzdC4KPgo+IFRoZXJlIGFyZSB0aHJlZSBzaXR1YXRpb25zIGluIHdoaWNoIHZxIGNvcnJlc3Bv
bmRzIHRvIGFuIGludGVycnVwdAo+Cj4gMS4gaW50eAo+IDIuIG1zaXg6IHBlciB2cSB2ZWN0b3Jz
Cj4gMi4gbXNpeDogc2hhcmUgaXJxCj4KPiBFc3NlbnRpYWxseSBjYW4gYmUgZGl2aWRlZCBpbnRv
IHR3byBjYXRlZ29yaWVzOiBwZXIgdnEgdmVjdG9ycyBhbmQgc2hhcmUgaXJxLgo+Cj4gRm9yIHNo
YXJlIGlycSBpcyBiYXNlZCBvbiB2aXJ0cXVldWVzIHRvIGZpbmQgdnEsIHNvIEkgdGhpbmsgaXQg
aXMgc2FmZSBhcyBsb25nCj4gYXMgbGlzdF9kZWwoKSBpcyBleGVjdXRlZCB1bmRlciB0aGUgcHJv
dGVjdGlvbiBvZiB0aGUgbG9jay4KPgo+IEluIHRoZSBjYXNlIG9mIHBlciB2cSB2ZWN0b3JzLCBk
aXNhYmxlX2lycSgpIGlzIHVzZWQuCgoKU2VlIHRoZSBkaXNjdXNzaW9uIGhlcmVbMV0sIGRpc2Fi
bGVfaXJxKCkgY291bGQgYmUgcHJvYmxlbWF0aWMgZm9yIHRoZSAKYmxvY2sgYW5kIHNjc2kgZGV2
aWNlIHRoYXQgdXNpbmcgYWZmaW5pdHkgbWFuYWdlZCBpcnEuIFdlJ3JlIHdhaXRpbmcgZm9yIAp0
aGUgSVJRIG1haW50YWluZXIgdG8gY29tbWVudCBvbiBhIHNvbHV0aW9uLiBPdGhlciBsb29rcyBz
YW5lLgoKVGhhbmtzCgpbMV0gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjIvMy84Lzc0MwoKCj4K
PiBUaGFua3MuCj4KPiArc3RhdGljIGludCB2cF9tb2Rlcm5fcmVzZXRfdnEoc3RydWN0IHZpcnRx
dWV1ZSAqdnEpCj4gK3sKPiArICAgICAgIHN0cnVjdCB2aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2
ID0gdG9fdnBfZGV2aWNlKHZxLT52ZGV2KTsKPiArICAgICAgIHN0cnVjdCB2aXJ0aW9fcGNpX21v
ZGVybl9kZXZpY2UgKm1kZXYgPSAmdnBfZGV2LT5tZGV2Owo+ICsgICAgICAgc3RydWN0IHZpcnRp
b19wY2lfdnFfaW5mbyAqaW5mbzsKPiArICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7Cj4gKyAg
ICAgICB1bnNpZ25lZCBpbnQgaXJxOwo+ICsKPiArICAgICAgIGlmICghdmlydGlvX2hhc19mZWF0
dXJlKHZxLT52ZGV2LCBWSVJUSU9fRl9SSU5HX1JFU0VUKSkKPiArICAgICAgICAgICAgICAgcmV0
dXJuIC1FTk9FTlQ7Cj4gKwo+ICsgICAgICAgdnBfbW9kZXJuX3NldF9xdWV1ZV9yZXNldChtZGV2
LCB2cS0+aW5kZXgpOwo+ICsKPiArICAgICAgIGluZm8gPSB2cF9kZXYtPnZxc1t2cS0+aW5kZXhd
Owo+ICsKPiArICAgICAgIC8qIGRlbGV0ZSB2cSBmcm9tIGlycSBoYW5kbGVyICovCj4gKyAgICAg
ICBzcGluX2xvY2tfaXJxc2F2ZSgmdnBfZGV2LT5sb2NrLCBmbGFncyk7Cj4gKyAgICAgICBsaXN0
X2RlbCgmaW5mby0+bm9kZSk7Cj4gKyAgICAgICB2cF9tb2Rlcm5fc2V0X3F1ZXVlX3Jlc2V0KG1k
ZXYsIHZxLT5pbmRleCk7Cj4gKwo+ICsgICAgICAgaW5mbyA9IHZwX2Rldi0+dnFzW3ZxLT5pbmRl
eF07Cj4gKwo+ICsgICAgICAgLyogZGVsZXRlIHZxIGZyb20gaXJxIGhhbmRsZXIgKi8KPiArICAg
ICAgIHNwaW5fbG9ja19pcnFzYXZlKCZ2cF9kZXYtPmxvY2ssIGZsYWdzKTsKPiArICAgICAgIGxp
c3RfZGVsKCZpbmZvLT5ub2RlKTsKPiArICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnZw
X2Rldi0+bG9jaywgZmxhZ3MpOwo+ICsKPiArICAgICAgIElOSVRfTElTVF9IRUFEKCZpbmZvLT5u
b2RlKTsKPiArCj4gKyAgICAgICAvKiBGb3IgdGhlIGNhc2Ugd2hlcmUgdnEgaGFzIGFuIGV4Y2x1
c2l2ZSBpcnEsIHRvIHByZXZlbnQgdGhlIGlycSBmcm9tCj4gKyAgICAgICAgKiBiZWluZyByZWNl
aXZlZCBhZ2FpbiBhbmQgdGhlIHBlbmRpbmcgaXJxLCBjYWxsIGRpc2FibGVfaXJxKCkuCj4gKyAg
ICAgICAgKgo+ICsgICAgICAgICogSW4gdGhlIHNjZW5hcmlvIGJhc2VkIG9uIHNoYXJlZCBpbnRl
cnJ1cHRzLCB2cSB3aWxsIGJlIHNlYXJjaGVkIGZyb20KPiArICAgICAgICAqIHRoZSBxdWV1ZSB2
aXJ0cXVldWVzLiBTaW5jZSB0aGUgcHJldmlvdXMgbGlzdF9kZWwoKSBoYXMgYmVlbiBkZWxldGVk
Cj4gKyAgICAgICAgKiBmcm9tIHRoZSBxdWV1ZSwgaXQgaXMgaW1wb3NzaWJsZSBmb3IgdnEgdG8g
YmUgY2FsbGVkIGluIHRoaXMgY2FzZS4KPiArICAgICAgICAqIFRoZXJlIGlzIG5vIG5lZWQgdG8g
Y2xvc2UgdGhlIGNvcnJlc3BvbmRpbmcgaW50ZXJydXB0Lgo+ICsgICAgICAgICovCj4gKyAgICAg
ICBpZiAodnBfZGV2LT5wZXJfdnFfdmVjdG9ycyAmJiBtc2l4X3ZlYyAhPSBWSVJUSU9fTVNJX05P
X1ZFQ1RPUikKPiArICAgICAgICAgICAgICAgZGlzYWJsZV9pcnEocGNpX2lycV92ZWN0b3IodnBf
ZGV2LT5wY2lfZGV2LCBpbmZvLT5tc2l4X3ZlY3RvcikpOwo+ICsKPiArICAgICAgIHZxLT5yZXNl
dCA9IHRydWU7Cj4gKwo+ICsgICAgICAgcmV0dXJuIDA7Cj4gK30KPiArCj4gK3N0YXRpYyBpbnQg
dnBfbW9kZXJuX2VuYWJsZV9yZXNldF92cShzdHJ1Y3QgdmlydHF1ZXVlICp2cSkKPiArewo+ICsg
ICAgICAgc3RydWN0IHZpcnRpb19wY2lfZGV2aWNlICp2cF9kZXYgPSB0b192cF9kZXZpY2UodnEt
PnZkZXYpOwo+ICsgICAgICAgc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSAqbWRldiA9
ICZ2cF9kZXYtPm1kZXY7Cj4gKyAgICAgICBzdHJ1Y3QgdmlydGlvX3BjaV92cV9pbmZvICppbmZv
Owo+ICsgICAgICAgdW5zaWduZWQgbG9uZyBmbGFncywgaW5kZXg7Cj4gKyAgICAgICBpbnQgZXJy
Owo+ICsKPiArICAgICAgIGlmICghdnEtPnJlc2V0KQo+ICsgICAgICAgICAgICAgICByZXR1cm4g
LUVCVVNZOwo+ICsKPiArICAgICAgIGluZGV4ID0gdnEtPmluZGV4Owo+ICsgICAgICAgaW5mbyA9
IHZwX2Rldi0+dnFzW2luZGV4XTsKPiArCj4gKyAgICAgICAvKiBjaGVjayBxdWV1ZSByZXNldCBz
dGF0dXMgKi8KPiArICAgICAgIGlmICh2cF9tb2Rlcm5fZ2V0X3F1ZXVlX3Jlc2V0KG1kZXYsIGlu
ZGV4KSAhPSAxKQo+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVCVVNZOwo+ICsKPiArICAgICAg
IGVyciA9IHZwX2FjdGl2ZV92cSh2cSwgaW5mby0+bXNpeF92ZWN0b3IpOwo+ICsgICAgICAgaWYg
KGVycikKPiArICAgICAgICAgICAgICAgcmV0dXJuIGVycjsKPiArCj4gKyAgICAgICBpZiAodnEt
PmNhbGxiYWNrKSB7Cj4gKyAgICAgICAgICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZ2cF9kZXYt
PmxvY2ssIGZsYWdzKTsKPiArICAgICAgICAgICAgICAgbGlzdF9hZGQoJmluZm8tPm5vZGUsICZ2
cF9kZXYtPnZpcnRxdWV1ZXMpOwo+ICsgICAgICAgICAgICAgICBzcGluX3VubG9ja19pcnFyZXN0
b3JlKCZ2cF9kZXYtPmxvY2ssIGZsYWdzKTsKPiArICAgICAgIH0gZWxzZSB7Cj4gKyAgICAgICAg
ICAgICAgIElOSVRfTElTVF9IRUFEKCZpbmZvLT5ub2RlKTsKPiArICAgICAgIH0KPiArCj4gKyAg
ICAgICB2cF9tb2Rlcm5fc2V0X3F1ZXVlX2VuYWJsZSgmdnBfZGV2LT5tZGV2LCBpbmRleCwgdHJ1
ZSk7Cj4gKyAgICAgICB2cS0+cmVzZXQgPSBmYWxzZTsKPiArCj4gKyAgICAgICBpZiAodnBfZGV2
LT5wZXJfdnFfdmVjdG9ycyAmJiBtc2l4X3ZlYyAhPSBWSVJUSU9fTVNJX05PX1ZFQ1RPUikKPiAr
ICAgICAgICAgICAgICAgZW5hYmxlX2lycShwY2lfaXJxX3ZlY3Rvcih2cF9kZXYtPnBjaV9kZXYs
IGluZm8tPm1zaXhfdmVjdG9yKSk7Cj4gKwo+ICsgICAgICAgcmV0dXJuIDA7Cj4gK30KPgo+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
