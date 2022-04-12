Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C240C433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 07:18:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A908C4011C;
	Tue, 12 Apr 2022 07:18:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oJ5CuHK0kwJ0; Tue, 12 Apr 2022 07:18:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3782740141;
	Tue, 12 Apr 2022 07:18:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AB36C0033;
	Tue, 12 Apr 2022 07:18:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4680BC002C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:18:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 239AA60F41
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:18:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G8xAT_pjhzX4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:18:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5BAD260F3B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649747901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XqKnz8pGmfktt7oGYuukRZYK9Mv+h4jERKVTHEdiSyE=;
 b=e5Hjk98E6ZnBLlfH/A18rTtx++Oi3/5n/5BCO9BXhInmd1GB2Dyc5mqbkyX6Oer89t5qG0
 ecYMgK50TRNwUe3y+Kyd8F+lYG8h6CCuk7eFlbpYXnvYMxjCGYWplfKBZWla6gMllxcxcz
 zzgKksGDrklDYmbHz5yVvO3tGPtlYdk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-VGpcBfG2OOGAgKD_T8sWJA-1; Tue, 12 Apr 2022 03:18:19 -0400
X-MC-Unique: VGpcBfG2OOGAgKD_T8sWJA-1
Received: by mail-pl1-f197.google.com with SMTP id
 a5-20020a170902ecc500b00156762be487so7403178plh.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 00:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=XqKnz8pGmfktt7oGYuukRZYK9Mv+h4jERKVTHEdiSyE=;
 b=7ymTqu5CLqJSMP/+w6890ZgSjD8c/YXENXGBx9H0e5FSvmRP8xnO1Q/kIJXYw1dx1X
 HoUg9WYtgEO0Nnms3txYxmDHWvmxhUIGe+l6J84zE3OXQTooCDDMQVKEuFVDfnvaLNIL
 a+zOiuZUyhAKvYZb3CjVFtKPxWQ84+T6xWrgqfetP5Pg/awZ0lVief83pKuFb5A90BWn
 +dbBM1ga2aQAs1LrtwP51GjGboCmIUY+nwpYYAzr0SMHpR8ANGYkNIgHC4BzB9QG8neA
 5rBsWiJ83nGRM0Mpv2fIANbQE0/HazYsdgcfjB+PewZpo2fJRNDYOBMHkc0RnHHiRQYZ
 DSvg==
X-Gm-Message-State: AOAM531EIu8rEQel2M3izYWz8FPmId4/p3HXS6l/5duLzyKKMzVTuBvc
 EZ0Sa8V2peMQsV5yEFqAkxtKy5CBiMBot+sn0UcRFc0bB6vGPRsqyNSA6Tg3Uq65JZC2rTaYD6e
 9RoE7e3MKbVJCJTlXlwg0NDdPepUg5kvapL++1HM1MQ==
X-Received: by 2002:a17:90a:dd45:b0:1bc:9466:9b64 with SMTP id
 u5-20020a17090add4500b001bc94669b64mr3438591pjv.23.1649747898742; 
 Tue, 12 Apr 2022 00:18:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzICssTBKSRQgY3N4GxeG15GespIylagYZlURonRDEwf7ie2ERjdgg/5bb3D2p7nXDQN3bpIg==
X-Received: by 2002:a17:90a:dd45:b0:1bc:9466:9b64 with SMTP id
 u5-20020a17090add4500b001bc94669b64mr3438556pjv.23.1649747898477; 
 Tue, 12 Apr 2022 00:18:18 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 r76-20020a632b4f000000b003820643e1c2sm1827442pgr.59.2022.04.12.00.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Apr 2022 00:18:17 -0700 (PDT)
Message-ID: <bd6bec0d-00db-93ae-4d86-daa10f5d8e88@redhat.com>
Date: Tue, 12 Apr 2022 15:18:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 28/32] virtio_net: set the default max ring size by
 find_vqs()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-29-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-29-xuanzhuo@linux.alibaba.com>
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
 Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 kvm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBVc2UgdmlydGlv
X2ZpbmRfdnFzX2N0eF9zaXplKCkgdG8gc3BlY2lmeSB0aGUgbWF4aW11bSByaW5nIHNpemUgb2Yg
dHgsCj4gcnggYXQgdGhlIHNhbWUgdGltZS4KPgo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCByeC90eCByaW5nIHNpemUKPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCj4gc3BlZWQgPT0gVU5LTk9XTiBvciA8IDEwR3wgMTAyNAo+IHNwZWVkIDwgNDBHICAg
ICAgICAgICAgICB8IDQwOTYKPiBzcGVlZCA+PSA0MEcgICAgICAgICAgICAgfCA4MTkyCj4KPiBD
YWxsIHZpcnRuZXRfdXBkYXRlX3NldHRpbmdzKCkgb25jZSBiZWZvcmUgY2FsbGluZyBpbml0X3Zx
cygpIHRvIHVwZGF0ZQo+IHNwZWVkLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFu
emh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4KCgo+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgNDIgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDM4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gaW5kZXggYTgw
MWVhNDA5MDhmLi5kYWQ0OTdhNDdiM2EgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gQEAgLTI4NjEsNiArMjg2
MSwyOSBAQCBzdGF0aWMgdW5zaWduZWQgaW50IG1lcmdlYWJsZV9taW5fYnVmX2xlbihzdHJ1Y3Qg
dmlydG5ldF9pbmZvICp2aSwgc3RydWN0IHZpcnRxdQo+ICAgCQkgICAodW5zaWduZWQgaW50KUdP
T0RfUEFDS0VUX0xFTik7Cj4gICB9Cj4gICAKPiArc3RhdGljIHZvaWQgdmlydG5ldF9jb25maWdf
c2l6ZXMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksIHUzMiAqc2l6ZXMpCj4gK3sKPiArCXUzMiBp
LCByeF9zaXplLCB0eF9zaXplOwo+ICsKPiArCWlmICh2aS0+c3BlZWQgPT0gU1BFRURfVU5LTk9X
TiB8fCB2aS0+c3BlZWQgPCBTUEVFRF8xMDAwMCkgewo+ICsJCXJ4X3NpemUgPSAxMDI0Owo+ICsJ
CXR4X3NpemUgPSAxMDI0Owo+ICsKPiArCX0gZWxzZSBpZiAodmktPnNwZWVkIDwgU1BFRURfNDAw
MDApIHsKPiArCQlyeF9zaXplID0gMTAyNCAqIDQ7Cj4gKwkJdHhfc2l6ZSA9IDEwMjQgKiA0Owo+
ICsKPiArCX0gZWxzZSB7Cj4gKwkJcnhfc2l6ZSA9IDEwMjQgKiA4Owo+ICsJCXR4X3NpemUgPSAx
MDI0ICogODsKPiArCX0KPiArCj4gKwlmb3IgKGkgPSAwOyBpIDwgdmktPm1heF9xdWV1ZV9wYWly
czsgaSsrKSB7Cj4gKwkJc2l6ZXNbcnhxMnZxKGkpXSA9IHJ4X3NpemU7Cj4gKwkJc2l6ZXNbdHhx
MnZxKGkpXSA9IHR4X3NpemU7Cj4gKwl9Cj4gK30KPiArCj4gICBzdGF0aWMgaW50IHZpcnRuZXRf
ZmluZF92cXMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gICB7Cj4gICAJdnFfY2FsbGJhY2tf
dCAqKmNhbGxiYWNrczsKPiBAQCAtMjg2OCw2ICsyODkxLDcgQEAgc3RhdGljIGludCB2aXJ0bmV0
X2ZpbmRfdnFzKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpKQo+ICAgCWludCByZXQgPSAtRU5PTUVN
Owo+ICAgCWludCBpLCB0b3RhbF92cXM7Cj4gICAJY29uc3QgY2hhciAqKm5hbWVzOwo+ICsJdTMy
ICpzaXplczsKPiAgIAlib29sICpjdHg7Cj4gICAKPiAgIAkvKiBXZSBleHBlY3QgMSBSWCB2aXJ0
cXVldWUgZm9sbG93ZWQgYnkgMSBUWCB2aXJ0cXVldWUsIGZvbGxvd2VkIGJ5Cj4gQEAgLTI4OTUs
MTAgKzI5MTksMTUgQEAgc3RhdGljIGludCB2aXJ0bmV0X2ZpbmRfdnFzKHN0cnVjdCB2aXJ0bmV0
X2luZm8gKnZpKQo+ICAgCQljdHggPSBOVUxMOwo+ICAgCX0KPiAgIAo+ICsJc2l6ZXMgPSBrbWFs
bG9jX2FycmF5KHRvdGFsX3Zxcywgc2l6ZW9mKCpzaXplcyksIEdGUF9LRVJORUwpOwo+ICsJaWYg
KCFzaXplcykKPiArCQlnb3RvIGVycl9zaXplczsKPiArCj4gICAJLyogUGFyYW1ldGVycyBmb3Ig
Y29udHJvbCB2aXJ0cXVldWUsIGlmIGFueSAqLwo+ICAgCWlmICh2aS0+aGFzX2N2cSkgewo+ICAg
CQljYWxsYmFja3NbdG90YWxfdnFzIC0gMV0gPSBOVUxMOwo+ICAgCQluYW1lc1t0b3RhbF92cXMg
LSAxXSA9ICJjb250cm9sIjsKPiArCQlzaXplc1t0b3RhbF92cXMgLSAxXSA9IDY0Owo+ICAgCX0K
PiAgIAo+ICAgCS8qIEFsbG9jYXRlL2luaXRpYWxpemUgcGFyYW1ldGVycyBmb3Igc2VuZC9yZWNl
aXZlIHZpcnRxdWV1ZXMgKi8KPiBAQCAtMjkxMyw4ICsyOTQyLDEwIEBAIHN0YXRpYyBpbnQgdmly
dG5ldF9maW5kX3ZxcyhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSkKPiAgIAkJCWN0eFtyeHEydnEo
aSldID0gdHJ1ZTsKPiAgIAl9Cj4gICAKPiAtCXJldCA9IHZpcnRpb19maW5kX3Zxc19jdHgodmkt
PnZkZXYsIHRvdGFsX3ZxcywgdnFzLCBjYWxsYmFja3MsCj4gLQkJCQkgIG5hbWVzLCBjdHgsIE5V
TEwpOwo+ICsJdmlydG5ldF9jb25maWdfc2l6ZXModmksIHNpemVzKTsKPiArCj4gKwlyZXQgPSB2
aXJ0aW9fZmluZF92cXNfY3R4X3NpemUodmktPnZkZXYsIHRvdGFsX3ZxcywgdnFzLCBjYWxsYmFj
a3MsCj4gKwkJCQkgICAgICAgbmFtZXMsIHNpemVzLCBjdHgsIE5VTEwpOwo+ICAgCWlmIChyZXQp
Cj4gICAJCWdvdG8gZXJyX2ZpbmQ7Cj4gICAKPiBAQCAtMjkzNCw2ICsyOTY1LDggQEAgc3RhdGlj
IGludCB2aXJ0bmV0X2ZpbmRfdnFzKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpKQo+ICAgCj4gICAK
PiAgIGVycl9maW5kOgo+ICsJa2ZyZWUoc2l6ZXMpOwo+ICtlcnJfc2l6ZXM6Cj4gICAJa2ZyZWUo
Y3R4KTsKPiAgIGVycl9jdHg6Cj4gICAJa2ZyZWUobmFtZXMpOwo+IEBAIC0zMjUyLDYgKzMyODUs
OSBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYp
Cj4gICAJCXZpLT5jdXJyX3F1ZXVlX3BhaXJzID0gbnVtX29ubGluZV9jcHVzKCk7Cj4gICAJdmkt
Pm1heF9xdWV1ZV9wYWlycyA9IG1heF9xdWV1ZV9wYWlyczsKPiAgIAo+ICsJdmlydG5ldF9pbml0
X3NldHRpbmdzKGRldik7Cj4gKwl2aXJ0bmV0X3VwZGF0ZV9zZXR0aW5ncyh2aSk7Cj4gKwo+ICAg
CS8qIEFsbG9jYXRlL2luaXRpYWxpemUgdGhlIHJ4L3R4IHF1ZXVlcywgYW5kIGludm9rZSBmaW5k
X3ZxcyAqLwo+ICAgCWVyciA9IGluaXRfdnFzKHZpKTsKPiAgIAlpZiAoZXJyKQo+IEBAIC0zMjY0
LDggKzMzMDAsNiBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcHJvYmUoc3RydWN0IHZpcnRpb19kZXZp
Y2UgKnZkZXYpCj4gICAJbmV0aWZfc2V0X3JlYWxfbnVtX3R4X3F1ZXVlcyhkZXYsIHZpLT5jdXJy
X3F1ZXVlX3BhaXJzKTsKPiAgIAluZXRpZl9zZXRfcmVhbF9udW1fcnhfcXVldWVzKGRldiwgdmkt
PmN1cnJfcXVldWVfcGFpcnMpOwo+ICAgCj4gLQl2aXJ0bmV0X2luaXRfc2V0dGluZ3MoZGV2KTsK
PiAtCj4gICAJaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfU1RBTkRC
WSkpIHsKPiAgIAkJdmktPmZhaWxvdmVyID0gbmV0X2ZhaWxvdmVyX2NyZWF0ZSh2aS0+ZGV2KTsK
PiAgIAkJaWYgKElTX0VSUih2aS0+ZmFpbG92ZXIpKSB7CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
