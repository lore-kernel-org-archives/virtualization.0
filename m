Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4CBC433F5
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 09:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA4CA84118;
	Wed,  9 Mar 2022 09:29:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oT0yQeF_rDET; Wed,  9 Mar 2022 09:29:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 54BB3840B8;
	Wed,  9 Mar 2022 09:29:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29984C0012;
	Wed,  9 Mar 2022 09:29:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C080C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:29:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A49584118
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:29:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S5sPBQnhIPeD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:29:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D4C41840B8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646818181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W9ocX7htY9ba2tFChckZrvAN3geRIS+/uGpDxNIPVbs=;
 b=ajS20yniFZTHJKnEU1MpIx1UmHmw2GlEn9Se+44YNoCUPOm1EOjcv2TGszJ1BoTEOQlOJc
 2eh7WNrqKqouTZmAJiiThUIuXL9pDwCOdypBuDBY+hKs/w7c6GI3XPJRpJdUpfMtjlg7BU
 BKtgWaAUOXXtU7pBAGRG8tZGZyw1gSk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-WzQCDeJYMKOk8OG2FfGvaw-1; Wed, 09 Mar 2022 04:29:40 -0500
X-MC-Unique: WzQCDeJYMKOk8OG2FfGvaw-1
Received: by mail-pj1-f69.google.com with SMTP id
 b9-20020a17090aa58900b001b8b14b4aabso1229870pjq.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Mar 2022 01:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=W9ocX7htY9ba2tFChckZrvAN3geRIS+/uGpDxNIPVbs=;
 b=UABsPMGMLSz5+mXZbMoqDvizi0azfltjO5Ef9KAe1/CKXQOUWTfFcxzTKYS404RUgF
 Zo5UKZf2vuTS8tD7NYeTiXUSOZIFS7JvzUCmAP1ZCOX5eTUxn+JSgnoTAFrVpvPCCAP/
 3ua2kw1fivEf5Yav06NIRaZO0b19behuBJTmMlbXM4x+PLKFRW8T2fq4mmMRHeFnu1pe
 3FQSXtnMQQt0bnSTKniQYPQE7AbaOy0VqV8Spjbxr3G6fsfwOHgoDo3TsMomCbZIIaPZ
 g1oP779AS4DiGwLo4O8w5IPdP5yWBYZfYZuAip0gNpsgyEUIu1CHw6kMIcq5X4hTN9Eb
 cfpw==
X-Gm-Message-State: AOAM533TXuXNVRvQT8Vhp3sj2ZPZ1VjkhsCqWEoOZFkjezwibL3rcbWk
 DizzhiJeEu9I+UA3VtQpgLEk6m7zpi4jVJPZOoYrOkXj8hBvzFPGjByhG7FXtTeomZkZuf0b135
 qVUuCHcT6rrQJ3XJVD1OKJ9SK6Z2z7Y/XGDwAMurPBw==
X-Received: by 2002:a05:6a00:3011:b0:4f6:dca6:ece1 with SMTP id
 ay17-20020a056a00301100b004f6dca6ece1mr20189446pfb.75.1646818179718; 
 Wed, 09 Mar 2022 01:29:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxL+3sp7OJuCEahtHTbhOxVlCpFQIqW2Pb0J6gPCFuY6dSoVpGjvXAebQz9lHsTjjuvBf4aOg==
X-Received: by 2002:a05:6a00:3011:b0:4f6:dca6:ece1 with SMTP id
 ay17-20020a056a00301100b004f6dca6ece1mr20189408pfb.75.1646818179436; 
 Wed, 09 Mar 2022 01:29:39 -0800 (PST)
Received: from [10.72.12.183] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 j13-20020a056a00130d00b004f1025a4361sm2297184pfu.202.2022.03.09.01.29.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Mar 2022 01:29:38 -0800 (PST)
Message-ID: <bd27898f-59bc-215b-bb84-14582b12cb16@redhat.com>
Date: Wed, 9 Mar 2022 17:29:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 26/26] virtio_net: support set_ringparam
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-27-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-27-xuanzhuo@linux.alibaba.com>
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
 Mathieu Poirier <mathieu.poirier@linaro.org>,
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

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g5YaZ6YGTOgo+IFN1cHBvcnQgc2V0
X3JpbmdwYXJhbSBiYXNlZCBvbiB2aXJ0aW8gcXVldWUgcmVzZXQuCj4KPiBUaGUgcngsdHhfcGVu
ZGluZyByZXF1aXJlZCB0byBiZSBwYXNzZWQgbXVzdCBiZSBwb3dlciBvZiAyLgo+Cj4gU2lnbmVk
LW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAg
IGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDQ3ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4gaW5kZXggZjFiZGM2Y2UyMWMzLi4xZmEyZDYzMmE5OTQgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
Cj4gQEAgLTIyOTAsNiArMjI5MCw1MiBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X2dldF9yaW5ncGFy
YW0oc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgIAlyaW5nLT50eF9wZW5kaW5nID0gdmlydHF1
ZXVlX2dldF92cmluZ19zaXplKHZpLT5zcVswXS52cSk7Cj4gICB9Cj4gICAKPiArc3RhdGljIGlu
dCB2aXJ0bmV0X3NldF9yaW5ncGFyYW0oc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiArCQkJCSBz
dHJ1Y3QgZXRodG9vbF9yaW5ncGFyYW0gKnJpbmcsCj4gKwkJCQkgc3RydWN0IGtlcm5lbF9ldGh0
b29sX3JpbmdwYXJhbSAqa2VybmVsX3JpbmcsCj4gKwkJCQkgc3RydWN0IG5ldGxpbmtfZXh0X2Fj
ayAqZXh0YWNrKQo+ICt7Cj4gKwlzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9IG5ldGRldl9wcml2
KGRldik7Cj4gKwl1MzIgcnhfcGVuZGluZywgdHhfcGVuZGluZzsKPiArCXN0cnVjdCByZWNlaXZl
X3F1ZXVlICpycTsKPiArCXN0cnVjdCBzZW5kX3F1ZXVlICpzcTsKPiArCWludCBpLCBlcnI7Cj4g
Kwo+ICsJaWYgKHJpbmctPnJ4X21pbmlfcGVuZGluZyB8fCByaW5nLT5yeF9qdW1ib19wZW5kaW5n
KQo+ICsJCXJldHVybiAtRUlOVkFMOwoKCkFueSBjaGFuY2UgdGhhdCB3ZSBtYXkgaGl0IHRoaXMg
RUlOVkFMPwoKVGhhbmtzCgoKPiArCj4gKwlyeF9wZW5kaW5nID0gdmlydHF1ZXVlX2dldF92cmlu
Z19zaXplKHZpLT5ycVswXS52cSk7Cj4gKwl0eF9wZW5kaW5nID0gdmlydHF1ZXVlX2dldF92cmlu
Z19zaXplKHZpLT5zcVswXS52cSk7Cj4gKwo+ICsJaWYgKHJpbmctPnJ4X3BlbmRpbmcgPT0gcnhf
cGVuZGluZyAmJgo+ICsJICAgIHJpbmctPnR4X3BlbmRpbmcgPT0gdHhfcGVuZGluZykKPiArCQly
ZXR1cm4gMDsKPiArCj4gKwlpZiAocmluZy0+cnhfcGVuZGluZyA+IHZpcnRxdWV1ZV9nZXRfdnJp
bmdfbWF4X3NpemUodmktPnJxWzBdLnZxKSkKPiArCQlyZXR1cm4gLUVJTlZBTDsKPiArCj4gKwlp
ZiAocmluZy0+dHhfcGVuZGluZyA+IHZpcnRxdWV1ZV9nZXRfdnJpbmdfbWF4X3NpemUodmktPnNx
WzBdLnZxKSkKPiArCQlyZXR1cm4gLUVJTlZBTDsKPiArCj4gKwlmb3IgKGkgPSAwOyBpIDwgdmkt
Pm1heF9xdWV1ZV9wYWlyczsgaSsrKSB7Cj4gKwkJcnEgPSB2aS0+cnEgKyBpOwo+ICsJCXNxID0g
dmktPnNxICsgaTsKPiArCj4gKwkJaWYgKHJpbmctPnR4X3BlbmRpbmcgIT0gdHhfcGVuZGluZykg
ewo+ICsJCQllcnIgPSB2aXJ0bmV0X3R4X3ZxX3Jlc2V0KHZpLCBzcSwgcmluZy0+dHhfcGVuZGlu
Zyk7Cj4gKwkJCWlmIChlcnIpCj4gKwkJCQlyZXR1cm4gZXJyOwo+ICsJCX0KPiArCj4gKwkJaWYg
KHJpbmctPnJ4X3BlbmRpbmcgIT0gcnhfcGVuZGluZykgewo+ICsJCQllcnIgPSB2aXJ0bmV0X3J4
X3ZxX3Jlc2V0KHZpLCBycSwgcmluZy0+cnhfcGVuZGluZyk7Cj4gKwkJCWlmIChlcnIpCj4gKwkJ
CQlyZXR1cm4gZXJyOwo+ICsJCX0KPiArCX0KPiArCj4gKwlyZXR1cm4gMDsKPiArfQo+ICAgCj4g
ICBzdGF0aWMgdm9pZCB2aXJ0bmV0X2dldF9kcnZpbmZvKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYs
Cj4gICAJCQkJc3RydWN0IGV0aHRvb2xfZHJ2aW5mbyAqaW5mbykKPiBAQCAtMjUyMyw2ICsyNTY5
LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBldGh0b29sX29wcyB2aXJ0bmV0X2V0aHRvb2xfb3Bz
ID0gewo+ICAgCS5nZXRfZHJ2aW5mbyA9IHZpcnRuZXRfZ2V0X2RydmluZm8sCj4gICAJLmdldF9s
aW5rID0gZXRodG9vbF9vcF9nZXRfbGluaywKPiAgIAkuZ2V0X3JpbmdwYXJhbSA9IHZpcnRuZXRf
Z2V0X3JpbmdwYXJhbSwKPiArCS5zZXRfcmluZ3BhcmFtID0gdmlydG5ldF9zZXRfcmluZ3BhcmFt
LAo+ICAgCS5nZXRfc3RyaW5ncyA9IHZpcnRuZXRfZ2V0X3N0cmluZ3MsCj4gICAJLmdldF9zc2V0
X2NvdW50ID0gdmlydG5ldF9nZXRfc3NldF9jb3VudCwKPiAgIAkuZ2V0X2V0aHRvb2xfc3RhdHMg
PSB2aXJ0bmV0X2dldF9ldGh0b29sX3N0YXRzLAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
