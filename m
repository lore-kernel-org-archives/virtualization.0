Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60BBC433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 07:13:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F433402B1;
	Tue, 12 Apr 2022 07:13:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AuCgsDl2O-yU; Tue, 12 Apr 2022 07:13:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 86EA440263;
	Tue, 12 Apr 2022 07:13:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 587ABC0082;
	Tue, 12 Apr 2022 07:13:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 456C6C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:13:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2BD6D4015D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:13:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SI0Ct-8haiVd
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:13:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DE2CD40309
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649747579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mRq1WN/7xC1cXSlUswWcAEZrziB8GVLK8yncCszg3n4=;
 b=RWGKXpslYoCFbDax933OaxzdwgxwcTEIfIy5psv5yxoCkN2eXTzCP2zInIqZ59YzR89XON
 lYETEBinE2KRorDnv3/H11wxhg89sTwAHrHNtOHErrAzBo41FUpsspKwQN/QpbWiLVmvBK
 pl/4qh5V9OzAVUANhW2chfdtnxPTMTg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-GGk8S7TLPtyGHS8s5soWpg-1; Tue, 12 Apr 2022 03:12:58 -0400
X-MC-Unique: GGk8S7TLPtyGHS8s5soWpg-1
Received: by mail-pj1-f71.google.com with SMTP id
 u4-20020a17090a5e4400b001cba059a4fbso1076307pji.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 00:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=mRq1WN/7xC1cXSlUswWcAEZrziB8GVLK8yncCszg3n4=;
 b=V5WsTri3bmpPpo9NfmQcWVlr9ufsSHbwF3tegqRYTeH8QF/uwErAvG6We+Z70h3Q/s
 2Bdp4pj4MSQqhKaeHGvM15Dxeqzi/fPvYFkP+weQ2T8u42UtOzideRJk0vEdRi1jgEnn
 3Z8kpvbA6MITmIsJAekJVAeRG3tEfqwvS3kB7dt+NR6RB0ObsDmFuQ4lGtUcFxfGqqjy
 F4ofyEcL636jtvAVzVIsJkIl1f2VUdM/fGL/y8RG0Yrb/PnNitejtLL0Lkhf4rOxhi2o
 8kNnRM7FTGmMQAIiAPHaxHPjqtBi0uLtOj2TxPCBgi6HfcRry58uy0we9X+24qYbQLpq
 3qmg==
X-Gm-Message-State: AOAM532kvJuMz0MckQI3noMOmAk1EFy8GHVOR8KUjeL1XMFSAlXewyDJ
 lhrM4jz3fXg50e4/QF3ECtlMuBHkW5/i/hKPTWC7JsYz44YdGOTHfH/n1yRRc5i85x+IVpq09+S
 3sCZ2T3o+hPvaT2fUWetv3PGpHSJzckMU1joLd4yFPg==
X-Received: by 2002:a63:b55d:0:b0:398:5eeb:e637 with SMTP id
 u29-20020a63b55d000000b003985eebe637mr28844777pgo.314.1649747577725; 
 Tue, 12 Apr 2022 00:12:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzcjF+z5aN8qIIJojhgLD6Ajm0j4nHXpFBPakfSKEyLfv8FWNaht+5QkKkqPRUpFlILOqb8Q==
X-Received: by 2002:a63:b55d:0:b0:398:5eeb:e637 with SMTP id
 u29-20020a63b55d000000b003985eebe637mr28844743pgo.314.1649747577325; 
 Tue, 12 Apr 2022 00:12:57 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 a38-20020a056a001d2600b004f70d5e92basm37773293pfx.34.2022.04.12.00.12.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Apr 2022 00:12:56 -0700 (PDT)
Message-ID: <b1f14156-a0b0-4933-072e-1ca33921fc8b@redhat.com>
Date: Tue, 12 Apr 2022 15:12:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 25/32] virtio_pci: support the arg sizes of find_vqs()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-26-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-26-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBWaXJ0aW8gUENJ
IHN1cHBvcnRzIG5ldyBwYXJhbWV0ZXIgc2l6ZXMgb2YgZmluZF92cXMoKS4KPgo+IFNpZ25lZC1v
ZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+CgoKQWNrZWQtYnk6
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmly
dGlvL3ZpcnRpb19wY2lfY29tbW9uLmMgfCAxOCArKysrKysrKysrLS0tLS0tLS0KPiAgIGRyaXZl
cnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmggfCAgMSArCj4gICBkcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcGNpX2xlZ2FjeS5jIHwgIDYgKysrKystCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cGNpX21vZGVybi5jIHwgMTAgKysrKysrKy0tLQo+ICAgNCBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNl
cnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcGNpX2NvbW1vbi5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24u
Ywo+IGluZGV4IDgyNmVhMmUzNWQ1NC4uMjM5NzZjNjE1ODNmIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcGNpX2NvbW1vbi5jCj4gQEAgLTIwOCw2ICsyMDgsNyBAQCBzdGF0aWMgaW50IHZwX3JlcXVl
c3RfbXNpeF92ZWN0b3JzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCBpbnQgbnZlY3RvcnMs
Cj4gICBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnBfc2V0dXBfdnEoc3RydWN0IHZpcnRpb19k
ZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGluZGV4LAo+ICAgCQkJCSAgICAgdm9pZCAoKmNhbGxiYWNr
KShzdHJ1Y3QgdmlydHF1ZXVlICp2cSksCj4gICAJCQkJICAgICBjb25zdCBjaGFyICpuYW1lLAo+
ICsJCQkJICAgICB1MzIgc2l6ZSwKPiAgIAkJCQkgICAgIGJvb2wgY3R4LAo+ICAgCQkJCSAgICAg
dTE2IG1zaXhfdmVjKQo+ICAgewo+IEBAIC0yMjAsNyArMjIxLDcgQEAgc3RhdGljIHN0cnVjdCB2
aXJ0cXVldWUgKnZwX3NldHVwX3ZxKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1bnNpZ25l
ZCBpbmRleCwKPiAgIAlpZiAoIWluZm8pCj4gICAJCXJldHVybiBFUlJfUFRSKC1FTk9NRU0pOwo+
ICAgCj4gLQl2cSA9IHZwX2Rldi0+c2V0dXBfdnEodnBfZGV2LCBpbmZvLCBpbmRleCwgY2FsbGJh
Y2ssIG5hbWUsIGN0eCwKPiArCXZxID0gdnBfZGV2LT5zZXR1cF92cSh2cF9kZXYsIGluZm8sIGlu
ZGV4LCBjYWxsYmFjaywgbmFtZSwgc2l6ZSwgY3R4LAo+ICAgCQkJICAgICAgbXNpeF92ZWMpOwo+
ICAgCWlmIChJU19FUlIodnEpKQo+ICAgCQlnb3RvIG91dF9pbmZvOwo+IEBAIC0zMTQsNyArMzE1
LDcgQEAgdm9pZCB2cF9kZWxfdnFzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ICAgCj4g
ICBzdGF0aWMgaW50IHZwX2ZpbmRfdnFzX21zaXgoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYs
IHVuc2lnbmVkIG52cXMsCj4gICAJCXN0cnVjdCB2aXJ0cXVldWUgKnZxc1tdLCB2cV9jYWxsYmFj
a190ICpjYWxsYmFja3NbXSwKPiAtCQljb25zdCBjaGFyICogY29uc3QgbmFtZXNbXSwgYm9vbCBw
ZXJfdnFfdmVjdG9ycywKPiArCQljb25zdCBjaGFyICogY29uc3QgbmFtZXNbXSwgdTMyIHNpemVz
W10sIGJvb2wgcGVyX3ZxX3ZlY3RvcnMsCj4gICAJCWNvbnN0IGJvb2wgKmN0eCwKPiAgIAkJc3Ry
dWN0IGlycV9hZmZpbml0eSAqZGVzYykKPiAgIHsKPiBAQCAtMzU3LDggKzM1OCw4IEBAIHN0YXRp
YyBpbnQgdnBfZmluZF92cXNfbXNpeChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgdW5zaWdu
ZWQgbnZxcywKPiAgIAkJZWxzZQo+ICAgCQkJbXNpeF92ZWMgPSBWUF9NU0lYX1ZRX1ZFQ1RPUjsK
PiAgIAkJdnFzW2ldID0gdnBfc2V0dXBfdnEodmRldiwgcXVldWVfaWR4KyssIGNhbGxiYWNrc1tp
XSwgbmFtZXNbaV0sCj4gLQkJCQkgICAgIGN0eCA/IGN0eFtpXSA6IGZhbHNlLAo+IC0JCQkJICAg
ICBtc2l4X3ZlYyk7Cj4gKwkJCQkgICAgIHNpemVzID8gc2l6ZXNbaV0gOiAwLAo+ICsJCQkJICAg
ICBjdHggPyBjdHhbaV0gOiBmYWxzZSwgbXNpeF92ZWMpOwo+ICAgCQlpZiAoSVNfRVJSKHZxc1tp
XSkpIHsKPiAgIAkJCWVyciA9IFBUUl9FUlIodnFzW2ldKTsKPiAgIAkJCWdvdG8gZXJyb3JfZmlu
ZDsKPiBAQCAtMzg4LDcgKzM4OSw3IEBAIHN0YXRpYyBpbnQgdnBfZmluZF92cXNfbXNpeChzdHJ1
Y3QgdmlydGlvX2RldmljZSAqdmRldiwgdW5zaWduZWQgbnZxcywKPiAgIAo+ICAgc3RhdGljIGlu
dCB2cF9maW5kX3Zxc19pbnR4KHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBu
dnFzLAo+ICAgCQlzdHJ1Y3QgdmlydHF1ZXVlICp2cXNbXSwgdnFfY2FsbGJhY2tfdCAqY2FsbGJh
Y2tzW10sCj4gLQkJY29uc3QgY2hhciAqIGNvbnN0IG5hbWVzW10sIGNvbnN0IGJvb2wgKmN0eCkK
PiArCQljb25zdCBjaGFyICogY29uc3QgbmFtZXNbXSwgdTMyIHNpemVzW10sIGNvbnN0IGJvb2wg
KmN0eCkKPiAgIHsKPiAgIAlzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2UgKnZwX2RldiA9IHRvX3Zw
X2RldmljZSh2ZGV2KTsKPiAgIAlpbnQgaSwgZXJyLCBxdWV1ZV9pZHggPSAwOwo+IEBAIC00MTAs
NiArNDExLDcgQEAgc3RhdGljIGludCB2cF9maW5kX3Zxc19pbnR4KHN0cnVjdCB2aXJ0aW9fZGV2
aWNlICp2ZGV2LCB1bnNpZ25lZCBudnFzLAo+ICAgCQkJY29udGludWU7Cj4gICAJCX0KPiAgIAkJ
dnFzW2ldID0gdnBfc2V0dXBfdnEodmRldiwgcXVldWVfaWR4KyssIGNhbGxiYWNrc1tpXSwgbmFt
ZXNbaV0sCj4gKwkJCQkgICAgIHNpemVzID8gc2l6ZXNbaV0gOiAwLAo+ICAgCQkJCSAgICAgY3R4
ID8gY3R4W2ldIDogZmFsc2UsCj4gICAJCQkJICAgICBWSVJUSU9fTVNJX05PX1ZFQ1RPUik7Cj4g
ICAJCWlmIChJU19FUlIodnFzW2ldKSkgewo+IEBAIC00MzMsMTUgKzQzNSwxNSBAQCBpbnQgdnBf
ZmluZF92cXMoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIG52cXMsCj4gICAJ
aW50IGVycjsKPiAgIAo+ICAgCS8qIFRyeSBNU0ktWCB3aXRoIG9uZSB2ZWN0b3IgcGVyIHF1ZXVl
LiAqLwo+IC0JZXJyID0gdnBfZmluZF92cXNfbXNpeCh2ZGV2LCBudnFzLCB2cXMsIGNhbGxiYWNr
cywgbmFtZXMsIHRydWUsIGN0eCwgZGVzYyk7Cj4gKwllcnIgPSB2cF9maW5kX3Zxc19tc2l4KHZk
ZXYsIG52cXMsIHZxcywgY2FsbGJhY2tzLCBuYW1lcywgc2l6ZXMsIHRydWUsIGN0eCwgZGVzYyk7
Cj4gICAJaWYgKCFlcnIpCj4gICAJCXJldHVybiAwOwo+ICAgCS8qIEZhbGxiYWNrOiBNU0ktWCB3
aXRoIG9uZSB2ZWN0b3IgZm9yIGNvbmZpZywgb25lIHNoYXJlZCBmb3IgcXVldWVzLiAqLwo+IC0J
ZXJyID0gdnBfZmluZF92cXNfbXNpeCh2ZGV2LCBudnFzLCB2cXMsIGNhbGxiYWNrcywgbmFtZXMs
IGZhbHNlLCBjdHgsIGRlc2MpOwo+ICsJZXJyID0gdnBfZmluZF92cXNfbXNpeCh2ZGV2LCBudnFz
LCB2cXMsIGNhbGxiYWNrcywgbmFtZXMsIHNpemVzLCBmYWxzZSwgY3R4LCBkZXNjKTsKPiAgIAlp
ZiAoIWVycikKPiAgIAkJcmV0dXJuIDA7Cj4gICAJLyogRmluYWxseSBmYWxsIGJhY2sgdG8gcmVn
dWxhciBpbnRlcnJ1cHRzLiAqLwo+IC0JcmV0dXJuIHZwX2ZpbmRfdnFzX2ludHgodmRldiwgbnZx
cywgdnFzLCBjYWxsYmFja3MsIG5hbWVzLCBjdHgpOwo+ICsJcmV0dXJuIHZwX2ZpbmRfdnFzX2lu
dHgodmRldiwgbnZxcywgdnFzLCBjYWxsYmFja3MsIG5hbWVzLCBzaXplcywgY3R4KTsKPiAgIH0K
PiAgIAo+ICAgY29uc3QgY2hhciAqdnBfYnVzX25hbWUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZk
ZXYpCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmggYi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5oCj4gaW5kZXggODU5ZWVkNTU5ZTEwLi5m
YmY1YTZkNGIxNjQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21t
b24uaAo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmgKPiBAQCAtODEs
NiArODEsNyBAQCBzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2Ugewo+ICAgCQkJCSAgICAgIHVuc2ln
bmVkIGlkeCwKPiAgIAkJCQkgICAgICB2b2lkICgqY2FsbGJhY2spKHN0cnVjdCB2aXJ0cXVldWUg
KnZxKSwKPiAgIAkJCQkgICAgICBjb25zdCBjaGFyICpuYW1lLAo+ICsJCQkJICAgICAgdTMyIHNp
emUsCj4gICAJCQkJICAgICAgYm9vbCBjdHgsCj4gICAJCQkJICAgICAgdTE2IG1zaXhfdmVjKTsK
PiAgIAl2b2lkICgqZGVsX3ZxKShzdHJ1Y3QgdmlydGlvX3BjaV92cV9pbmZvICppbmZvKTsKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYyBiL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMKPiBpbmRleCBiNjg5MzRmZTZiNWQuLjJjNGFkZTVm
YjQyMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jCj4g
KysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYwo+IEBAIC0xMTIsNiArMTEy
LDcgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnNldHVwX3ZxKHN0cnVjdCB2aXJ0aW9fcGNp
X2RldmljZSAqdnBfZGV2LAo+ICAgCQkJCSAgdW5zaWduZWQgaW5kZXgsCj4gICAJCQkJICB2b2lk
ICgqY2FsbGJhY2spKHN0cnVjdCB2aXJ0cXVldWUgKnZxKSwKPiAgIAkJCQkgIGNvbnN0IGNoYXIg
Km5hbWUsCj4gKwkJCQkgIHUzMiBzaXplLAo+ICAgCQkJCSAgYm9vbCBjdHgsCj4gICAJCQkJICB1
MTYgbXNpeF92ZWMpCj4gICB7Cj4gQEAgLTEyNSwxMCArMTI2LDEzIEBAIHN0YXRpYyBzdHJ1Y3Qg
dmlydHF1ZXVlICpzZXR1cF92cShzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2UgKnZwX2RldiwKPiAg
IAlpZiAoIW51bSB8fCB2cF9sZWdhY3lfZ2V0X3F1ZXVlX2VuYWJsZSgmdnBfZGV2LT5sZGV2LCBp
bmRleCkpCj4gICAJCXJldHVybiBFUlJfUFRSKC1FTk9FTlQpOwo+ICAgCj4gKwlpZiAoIXNpemUg
fHwgc2l6ZSA+IG51bSkKPiArCQlzaXplID0gbnVtOwo+ICsKPiAgIAlpbmZvLT5tc2l4X3ZlY3Rv
ciA9IG1zaXhfdmVjOwo+ICAgCj4gICAJLyogY3JlYXRlIHRoZSB2cmluZyAqLwo+IC0JdnEgPSB2
cmluZ19jcmVhdGVfdmlydHF1ZXVlKGluZGV4LCBudW0sCj4gKwl2cSA9IHZyaW5nX2NyZWF0ZV92
aXJ0cXVldWUoaW5kZXgsIHNpemUsCj4gICAJCQkJICAgIFZJUlRJT19QQ0lfVlJJTkdfQUxJR04s
ICZ2cF9kZXYtPnZkZXYsCj4gICAJCQkJICAgIHRydWUsIGZhbHNlLCBjdHgsCj4gICAJCQkJICAg
IHZwX25vdGlmeSwgY2FsbGJhY2ssIG5hbWUpOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcGNpX21vZGVybi5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4u
Ywo+IGluZGV4IDNiMzVlNTA1NjE2NS4uYTE3YzQ3ZDQ0MzVhIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcGNpX21vZGVybi5jCj4gQEAgLTI4OSw2ICsyODksNyBAQCBzdGF0aWMgc3RydWN0IHZpcnRx
dWV1ZSAqc2V0dXBfdnEoc3RydWN0IHZpcnRpb19wY2lfZGV2aWNlICp2cF9kZXYsCj4gICAJCQkJ
ICB1bnNpZ25lZCBpbmRleCwKPiAgIAkJCQkgIHZvaWQgKCpjYWxsYmFjaykoc3RydWN0IHZpcnRx
dWV1ZSAqdnEpLAo+ICAgCQkJCSAgY29uc3QgY2hhciAqbmFtZSwKPiArCQkJCSAgdTMyIHNpemUs
Cj4gICAJCQkJICBib29sIGN0eCwKPiAgIAkJCQkgIHUxNiBtc2l4X3ZlYykKPiAgIHsKPiBAQCAt
MzA2LDE1ICszMDcsMTggQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnNldHVwX3ZxKHN0cnVj
dCB2aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2LAo+ICAgCWlmICghbnVtIHx8IHZwX21vZGVybl9n
ZXRfcXVldWVfZW5hYmxlKG1kZXYsIGluZGV4KSkKPiAgIAkJcmV0dXJuIEVSUl9QVFIoLUVOT0VO
VCk7Cj4gICAKPiAtCWlmIChudW0gJiAobnVtIC0gMSkpIHsKPiAtCQlkZXZfd2FybigmdnBfZGV2
LT5wY2lfZGV2LT5kZXYsICJiYWQgcXVldWUgc2l6ZSAldSIsIG51bSk7Cj4gKwlpZiAoIXNpemUg
fHwgc2l6ZSA+IG51bSkKPiArCQlzaXplID0gbnVtOwo+ICsKPiArCWlmIChzaXplICYgKHNpemUg
LSAxKSkgewo+ICsJCWRldl93YXJuKCZ2cF9kZXYtPnBjaV9kZXYtPmRldiwgImJhZCBxdWV1ZSBz
aXplICV1Iiwgc2l6ZSk7Cj4gICAJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOwo+ICAgCX0KPiAg
IAo+ICAgCWluZm8tPm1zaXhfdmVjdG9yID0gbXNpeF92ZWM7Cj4gICAKPiAgIAkvKiBjcmVhdGUg
dGhlIHZyaW5nICovCj4gLQl2cSA9IHZyaW5nX2NyZWF0ZV92aXJ0cXVldWUoaW5kZXgsIG51bSwK
PiArCXZxID0gdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZShpbmRleCwgc2l6ZSwKPiAgIAkJCQkgICAg
U01QX0NBQ0hFX0JZVEVTLCAmdnBfZGV2LT52ZGV2LAo+ICAgCQkJCSAgICB0cnVlLCB0cnVlLCBj
dHgsCj4gICAJCQkJICAgIHZwX25vdGlmeSwgY2FsbGJhY2ssIG5hbWUpOwoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
