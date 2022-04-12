Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5827DC43217
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 03:22:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03FE260EE0;
	Tue, 12 Apr 2022 03:22:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mZiTgJhpW4Mj; Tue, 12 Apr 2022 03:22:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 79EE860ECD;
	Tue, 12 Apr 2022 03:22:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41444C0033;
	Tue, 12 Apr 2022 03:22:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E317C002C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 03:22:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3AB3683E11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 03:22:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7xEk7yq-Jhvl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 03:22:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 59E48823C6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 03:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649733771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ii42iiWj0aR10COD6FOozUEgdafmCDFIdui5B2E6yYA=;
 b=RB+wQBUo/8AMqSxTxHPdMQtaAfau/pOKHyMvTRNlV06adbNhEdhYa8g96YXUBOK67LtTx6
 O4iMIGbsgamEeU37dzn/f13wbPgKggAKQMzLKBgxp68lUk+09WPFm8KC+NCb2jryI15gvI
 U9kFN4OcZnxm8iCaqlHzprNJXR9xdN4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-HnQhL8nOOQmbMBXlqBOFaA-1; Mon, 11 Apr 2022 23:22:50 -0400
X-MC-Unique: HnQhL8nOOQmbMBXlqBOFaA-1
Received: by mail-pl1-f200.google.com with SMTP id
 s18-20020a170902ea1200b001570031e832so5711562plg.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 20:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ii42iiWj0aR10COD6FOozUEgdafmCDFIdui5B2E6yYA=;
 b=QhIosK0gqxjlj0Vcaw7+znIvZmyI7LXcEDHmyisYXJr+0v0eRGk99Imq/wciZfmXEd
 vRf0WduXPoYB3WTeoP54idL/9d6Lo9x6JuIX5CPVgenA2JIW4l0DZFwEctUbj6TaFuy4
 7uFG7HrWovgPfAi6hVnBjQjwvja3hWHq+oQiLx8aOi6WOuWTuljmnx8w08gYvu+HQumT
 tlFoy3480X1B1ChnLkduHtDrwkP05G0zW0nBf0k5L4nUQkskB3VZS6t0Ptcy6SmiVa9i
 4by1/yp/7759xqktNWe63PMxfmnBQ9XjCIV+6clk35pAivmcY7atYsfNOaMxF/hjVpvq
 2XgQ==
X-Gm-Message-State: AOAM5322hg3CvAYV0XfA4u71pbMq8oGOedLHHtApC4XBegTtpkE1Aiu+
 T2fJNOIBNW0hW/whI5HmtEYejTuZ6T1YMLClyF96D6FblrsRwAQ4kPAF8gLVY5FAA0MD9XOUDmN
 eepZpxDCAf5U6ewU3ql8Tf6xpwxgDA51QdQ5HpMY1eA==
X-Received: by 2002:a05:6a00:2286:b0:505:d881:d71 with SMTP id
 f6-20020a056a00228600b00505d8810d71mr4497632pfe.16.1649733768744; 
 Mon, 11 Apr 2022 20:22:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1snN7U3V3KsQoNYi1CdXRBDYgI2RR0ieFCnowUK1U29yxtigZtWYXVv0HXiJRKmxp91rKBw==
X-Received: by 2002:a05:6a00:2286:b0:505:d881:d71 with SMTP id
 f6-20020a056a00228600b00505d8810d71mr4497609pfe.16.1649733768442; 
 Mon, 11 Apr 2022 20:22:48 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 x2-20020a63aa42000000b0038265eb2495sm995405pgo.88.2022.04.11.20.22.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Apr 2022 20:22:47 -0700 (PDT)
Message-ID: <b435b86d-26af-2e39-8859-6746830769d5@redhat.com>
Date: Tue, 12 Apr 2022 11:22:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 06/32] virtio_ring: split: extract the logic of alloc
 queue
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-7-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBTZXBhcmF0ZSB0
aGUgbG9naWMgb2Ygc3BsaXQgdG8gY3JlYXRlIHZyaW5nIHF1ZXVlLgo+Cj4gVGhpcyBmZWF0dXJl
IGlzIHJlcXVpcmVkIGZvciBzdWJzZXF1ZW50IHZpcnR1cXVldWUgcmVzZXQgdnJpbmcuCj4KPiBT
aWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IC0t
LQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDUzICsrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyks
IDE3IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19y
aW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggMzNmZGRmYjkwN2E2
Li43MmQ1YWUwNjNmYTAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
Ywo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtOTE1LDIzICs5MTUs
MTUgQEAgc3RhdGljIHZvaWQgKnZpcnRxdWV1ZV9kZXRhY2hfdW51c2VkX2J1Zl9zcGxpdChzdHJ1
Y3QgdmlydHF1ZXVlICpfdnEpCj4gICAJcmV0dXJuIE5VTEw7Cj4gICB9Cj4gICAKPiAtc3RhdGlj
IHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfc3BsaXQoCj4gLQl1bnNp
Z25lZCBpbnQgaW5kZXgsCj4gLQl1bnNpZ25lZCBpbnQgbnVtLAo+IC0JdW5zaWduZWQgaW50IHZy
aW5nX2FsaWduLAo+IC0Jc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gLQlib29sIHdlYWtf
YmFycmllcnMsCj4gLQlib29sIG1heV9yZWR1Y2VfbnVtLAo+IC0JYm9vbCBjb250ZXh0LAo+IC0J
Ym9vbCAoKm5vdGlmeSkoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiAtCXZvaWQgKCpjYWxsYmFjayko
c3RydWN0IHZpcnRxdWV1ZSAqKSwKPiAtCWNvbnN0IGNoYXIgKm5hbWUpCj4gK3N0YXRpYyB2b2lk
ICp2cmluZ19hbGxvY19xdWV1ZV9zcGxpdChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwKPiAr
CQkJCSAgICAgZG1hX2FkZHJfdCAqZG1hX2FkZHIsCj4gKwkJCQkgICAgIHUzMiAqbiwKPiArCQkJ
CSAgICAgdW5zaWduZWQgaW50IHZyaW5nX2FsaWduLAo+ICsJCQkJICAgICBib29sIHdlYWtfYmFy
cmllcnMsCgoKVGhpcyBpcyBub3QgdXNlZCBpbiB0aGlzIGZ1bmN0aW9uLgoKVGhhbmtzCgoKPiAr
CQkJCSAgICAgYm9vbCBtYXlfcmVkdWNlX251bSkKPiAgIHsKPiAtCXN0cnVjdCB2aXJ0cXVldWUg
KnZxOwo+ICAgCXZvaWQgKnF1ZXVlID0gTlVMTDsKPiAtCWRtYV9hZGRyX3QgZG1hX2FkZHI7Cj4g
LQlzaXplX3QgcXVldWVfc2l6ZV9pbl9ieXRlczsKPiAtCXN0cnVjdCB2cmluZyB2cmluZzsKPiAr
CXUzMiBudW0gPSAqbjsKPiAgIAo+ICAgCS8qIFdlIGFzc3VtZSBudW0gaXMgYSBwb3dlciBvZiAy
LiAqLwo+ICAgCWlmIChudW0gJiAobnVtIC0gMSkpIHsKPiBAQCAtOTQyLDcgKzkzNCw3IEBAIHN0
YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3NwbGl0KAo+ICAg
CS8qIFRPRE86IGFsbG9jYXRlIGVhY2ggcXVldWUgY2h1bmsgaW5kaXZpZHVhbGx5ICovCj4gICAJ
Zm9yICg7IG51bSAmJiB2cmluZ19zaXplKG51bSwgdnJpbmdfYWxpZ24pID4gUEFHRV9TSVpFOyBu
dW0gLz0gMikgewo+ICAgCQlxdWV1ZSA9IHZyaW5nX2FsbG9jX3F1ZXVlKHZkZXYsIHZyaW5nX3Np
emUobnVtLCB2cmluZ19hbGlnbiksCj4gLQkJCQkJICAmZG1hX2FkZHIsCj4gKwkJCQkJICBkbWFf
YWRkciwKPiAgIAkJCQkJICBHRlBfS0VSTkVMfF9fR0ZQX05PV0FSTnxfX0dGUF9aRVJPKTsKPiAg
IAkJaWYgKHF1ZXVlKQo+ICAgCQkJYnJlYWs7Cj4gQEAgLTk1NiwxMSArOTQ4LDM4IEBAIHN0YXRp
YyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3NwbGl0KAo+ICAgCWlm
ICghcXVldWUpIHsKPiAgIAkJLyogVHJ5IHRvIGdldCBhIHNpbmdsZSBwYWdlLiBZb3UgYXJlIG15
IG9ubHkgaG9wZSEgKi8KPiAgIAkJcXVldWUgPSB2cmluZ19hbGxvY19xdWV1ZSh2ZGV2LCB2cmlu
Z19zaXplKG51bSwgdnJpbmdfYWxpZ24pLAo+IC0JCQkJCSAgJmRtYV9hZGRyLCBHRlBfS0VSTkVM
fF9fR0ZQX1pFUk8pOwo+ICsJCQkJCSAgZG1hX2FkZHIsIEdGUF9LRVJORUx8X19HRlBfWkVSTyk7
Cj4gICAJfQo+ICAgCWlmICghcXVldWUpCj4gICAJCXJldHVybiBOVUxMOwo+ICAgCj4gKwkqbiA9
IG51bTsKPiArCXJldHVybiBxdWV1ZTsKPiArfQo+ICsKPiArc3RhdGljIHN0cnVjdCB2aXJ0cXVl
dWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfc3BsaXQoCj4gKwl1bnNpZ25lZCBpbnQgaW5kZXgs
Cj4gKwl1bnNpZ25lZCBpbnQgbnVtLAo+ICsJdW5zaWduZWQgaW50IHZyaW5nX2FsaWduLAo+ICsJ
c3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gKwlib29sIHdlYWtfYmFycmllcnMsCj4gKwli
b29sIG1heV9yZWR1Y2VfbnVtLAo+ICsJYm9vbCBjb250ZXh0LAo+ICsJYm9vbCAoKm5vdGlmeSko
c3RydWN0IHZpcnRxdWV1ZSAqKSwKPiArCXZvaWQgKCpjYWxsYmFjaykoc3RydWN0IHZpcnRxdWV1
ZSAqKSwKPiArCWNvbnN0IGNoYXIgKm5hbWUpCj4gK3sKPiArCXNpemVfdCBxdWV1ZV9zaXplX2lu
X2J5dGVzOwo+ICsJc3RydWN0IHZpcnRxdWV1ZSAqdnE7Cj4gKwlkbWFfYWRkcl90IGRtYV9hZGRy
Owo+ICsJc3RydWN0IHZyaW5nIHZyaW5nOwo+ICsJdm9pZCAqcXVldWU7Cj4gKwo+ICsJcXVldWUg
PSB2cmluZ19hbGxvY19xdWV1ZV9zcGxpdCh2ZGV2LCAmZG1hX2FkZHIsICZudW0sIHZyaW5nX2Fs
aWduLAo+ICsJCQkJCXdlYWtfYmFycmllcnMsIG1heV9yZWR1Y2VfbnVtKTsKPiArCWlmICghcXVl
dWUpCj4gKwkJcmV0dXJuIE5VTEw7Cj4gKwo+ICAgCXF1ZXVlX3NpemVfaW5fYnl0ZXMgPSB2cmlu
Z19zaXplKG51bSwgdnJpbmdfYWxpZ24pOwo+ICAgCXZyaW5nX2luaXQoJnZyaW5nLCBudW0sIHF1
ZXVlLCB2cmluZ19hbGlnbik7Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
