Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981F3C433F5
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 06:46:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 252EA40103;
	Wed,  9 Mar 2022 06:46:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c1WW3qHRizi5; Wed,  9 Mar 2022 06:46:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5C072400BF;
	Wed,  9 Mar 2022 06:46:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37B68C001D;
	Wed,  9 Mar 2022 06:46:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB3ADC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 06:46:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A5E4E4173C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 06:46:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M4MtB02QmWH3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 06:46:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C747E4171C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 06:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646808380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZRVRzg4ndvIzPu33NbzHcBz6mikHjCXmzmHbidN+vIU=;
 b=gG4Ou3ZDeEnzRhqGUSkpbAyxYkw1Kgf1RMgnIAxeGkKoFqc5Bt1NDHgE0ZoLT+vEJ3IT3M
 RkYwRAIb3zY+pJ66aweie/v4GvYxD7WjYMRSqD4zPVG4oAgTGtqphzCI9t8gxEDTXVYQeu
 o6/0lYMabgHp7MEOftiandMx0TJUa0M=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-pGThgY8FPamVK1SqgqzLHw-1; Wed, 09 Mar 2022 01:46:19 -0500
X-MC-Unique: pGThgY8FPamVK1SqgqzLHw-1
Received: by mail-pl1-f199.google.com with SMTP id
 i7-20020a170902cf0700b0015163eb319eso668270plg.18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 22:46:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ZRVRzg4ndvIzPu33NbzHcBz6mikHjCXmzmHbidN+vIU=;
 b=74rgjubeLOxu2LY6FXonOGvU4q/22zncsi3UhUR5W4DtMq8WaXJYdfzezjogfmBD1/
 ktJ5SfZ3FNek1SoKvd2C0Ll1NrxfkQjB7ozaBiMCtMspZslqz4BgbvTZXZRBVoqpZnLm
 3ndVnk2tkeSfv/wBbxCnShFd+8a2ZmrM9kqrHZlsLkhL1zg4fPlJtVVsPgrJ6qMcoMGp
 +tLMxkaeZZ+mQWrAlmASX0JjoUZ1KOQzAbuODIGVM7yGWlD4IBesDFTLmjDa/rDIg9mw
 ZNs4YDGey+PL5gCZmVO51CBBVgRSiQzUOL4FEs6VuVB17Hxf2FPlgV38xU8n6D5glN18
 /D/Q==
X-Gm-Message-State: AOAM5326bG1EPKGPJahevSf85EKXtlRuEchuVsbrh3kDHebMMIZakui5
 LUEewr5EyJE8p/VGo7BwoY05aIgVMC8FnK32RBrAvIPgQIa70tPWoNFo23+hR2tkJxRkuouUfEG
 xV0fIAEa6vXpmzCaTGBuCdYGGJHqaAy5d207pSQmMFg==
X-Received: by 2002:a17:90a:c252:b0:1bc:52a8:cac8 with SMTP id
 d18-20020a17090ac25200b001bc52a8cac8mr8770701pjx.61.1646808378309; 
 Tue, 08 Mar 2022 22:46:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCn5oXYtQPYpNPdMU9Bvo1WQfVx7qdQtm4/+iiiL6XGVmBAI7JHTUBwTId/vpyk0ZnEZggTw==
X-Received: by 2002:a17:90a:c252:b0:1bc:52a8:cac8 with SMTP id
 d18-20020a17090ac25200b001bc52a8cac8mr8770665pjx.61.1646808378008; 
 Tue, 08 Mar 2022 22:46:18 -0800 (PST)
Received: from [10.72.12.183] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a056a00248300b004f6f729e485sm1396753pfv.127.2022.03.08.22.46.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Mar 2022 22:46:17 -0800 (PST)
Message-ID: <4b32d0b4-b794-cc1c-25f7-50b5ea6ac25e@redhat.com>
Date: Wed, 9 Mar 2022 14:46:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 04/26] virtio_ring: split: extract the logic of
 creating vring
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-5-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjM0LCBYdWFuIFpodW8g5YaZ6YGTOgo+IFNlcGFyYXRlIHRo
ZSBsb2dpYyBvZiBzcGxpdCB0byBjcmVhdGUgdnJpbmcgcXVldWUuCj4KPiBGb3IgdGhlIGNvbnZl
bmllbmNlIG9mIHBhc3NpbmcgcGFyYW1ldGVycywgYWRkIGEgc3RydWN0dXJlCj4gdnJpbmdfc3Bs
aXQuCj4KPiBUaGlzIGZlYXR1cmUgaXMgcmVxdWlyZWQgZm9yIHN1YnNlcXVlbnQgdmlydHVxdWV1
ZSByZXNldCB2cmluZy4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwg
NzQgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdl
ZCwgNTEgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMK
PiBpbmRleCBiODcxMzBjOGYzMTIuLmQzMjc5MzYxNTQ1MSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
Ywo+IEBAIC04NSw2ICs4NSwxMyBAQCBzdHJ1Y3QgdnJpbmdfZGVzY19leHRyYSB7Cj4gICAJdTE2
IG5leHQ7CQkJLyogVGhlIG5leHQgZGVzYyBzdGF0ZSBpbiBhIGxpc3QuICovCj4gICB9Owo+ICAg
Cj4gK3N0cnVjdCB2cmluZ19zcGxpdCB7Cj4gKwl2b2lkICpxdWV1ZTsKPiArCWRtYV9hZGRyX3Qg
ZG1hX2FkZHI7Cj4gKwlzaXplX3QgcXVldWVfc2l6ZV9pbl9ieXRlczsKPiArCXN0cnVjdCB2cmlu
ZyB2cmluZzsKPiArfTsKCgpTbyB0aGlzIHN0cnVjdHVyZSB3aWxsIGJlIG9ubHkgdXNlZCBpbiB2
cmluZ19jcmVhdGVfdnJpbmdfc3BsaXQoKSB3aGljaCAKc2VlbXMgbm90IHRoYXQgdXNlZnVsLgoK
TW9yZSBzZWUgYmVsb3cuCgoKPiArCj4gICBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlIHsKPiAgIAlz
dHJ1Y3QgdmlydHF1ZXVlIHZxOwo+ICAgCj4gQEAgLTkxNSwyOCArOTIyLDIxIEBAIHN0YXRpYyB2
b2lkICp2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWZfc3BsaXQoc3RydWN0IHZpcnRxdWV1ZSAq
X3ZxKQo+ICAgCXJldHVybiBOVUxMOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyBzdHJ1Y3QgdmlydHF1
ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3NwbGl0KAo+IC0JdW5zaWduZWQgaW50IGluZGV4
LAo+IC0JdW5zaWduZWQgaW50IG51bSwKPiAtCXVuc2lnbmVkIGludCB2cmluZ19hbGlnbiwKPiAt
CXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LAo+IC0JYm9vbCB3ZWFrX2JhcnJpZXJzLAo+IC0J
Ym9vbCBtYXlfcmVkdWNlX251bSwKPiAtCWJvb2wgY29udGV4dCwKPiAtCWJvb2wgKCpub3RpZnkp
KHN0cnVjdCB2aXJ0cXVldWUgKiksCj4gLQl2b2lkICgqY2FsbGJhY2spKHN0cnVjdCB2aXJ0cXVl
dWUgKiksCj4gLQljb25zdCBjaGFyICpuYW1lKQo+ICtzdGF0aWMgaW50IHZyaW5nX2NyZWF0ZV92
cmluZ19zcGxpdChzdHJ1Y3QgdnJpbmdfc3BsaXQgKnZyaW5nLAo+ICsJCQkJICAgIHN0cnVjdCB2
aXJ0aW9fZGV2aWNlICp2ZGV2LAo+ICsJCQkJICAgIHVuc2lnbmVkIGludCB2cmluZ19hbGlnbiwK
PiArCQkJCSAgICBib29sIHdlYWtfYmFycmllcnMsCj4gKwkJCQkgICAgYm9vbCBtYXlfcmVkdWNl
X251bSwKPiArCQkJCSAgICB1MzIgbnVtKQoKCkknZCByZW5hbWUgdGhpcyBhcyB2cmluZ19hbGxv
Y19xdWV1ZV9zcGxpdCgpIGFuZCBsZXQgaXQgc2ltcGx5IHJldHVybiAKdGhlIGFkZHJlc3Mgb2Yg
cXVldWUgbGlrZSB2cmluZ19hbGxvY19xdWV1ZSgpLgoKQW5kIGxldCBpdCBzaW1wbGUgYWNjZXB0
IGRtYV9hZGRyX3QgKmRtYV9hZGRlciBpbnN0ZWFkIG9mIHZyaW5nX3NwbGl0LgoKCj4gICB7Cj4g
LQlzdHJ1Y3QgdmlydHF1ZXVlICp2cTsKPiAgIAl2b2lkICpxdWV1ZSA9IE5VTEw7Cj4gICAJZG1h
X2FkZHJfdCBkbWFfYWRkcjsKPiAgIAlzaXplX3QgcXVldWVfc2l6ZV9pbl9ieXRlczsKPiAtCXN0
cnVjdCB2cmluZyB2cmluZzsKPiAgIAo+ICAgCS8qIFdlIGFzc3VtZSBudW0gaXMgYSBwb3dlciBv
ZiAyLiAqLwo+ICAgCWlmIChudW0gJiAobnVtIC0gMSkpIHsKPiAgIAkJZGV2X3dhcm4oJnZkZXYt
PmRldiwgIkJhZCB2aXJ0cXVldWUgbGVuZ3RoICV1XG4iLCBudW0pOwo+IC0JCXJldHVybiBOVUxM
Owo+ICsJCXJldHVybiAtRUlOVkFMOwo+ICAgCX0KPiAgIAo+ICAgCS8qIFRPRE86IGFsbG9jYXRl
IGVhY2ggcXVldWUgY2h1bmsgaW5kaXZpZHVhbGx5ICovCj4gQEAgLTk0NywxMSArOTQ3LDExIEBA
IHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3NwbGl0KAo+
ICAgCQlpZiAocXVldWUpCj4gICAJCQlicmVhazsKPiAgIAkJaWYgKCFtYXlfcmVkdWNlX251bSkK
PiAtCQkJcmV0dXJuIE5VTEw7Cj4gKwkJCXJldHVybiAtRU5PTUVNOwo+ICAgCX0KPiAgIAo+ICAg
CWlmICghbnVtKQo+IC0JCXJldHVybiBOVUxMOwo+ICsJCXJldHVybiAtRU5PTUVNOwo+ICAgCj4g
ICAJaWYgKCFxdWV1ZSkgewo+ICAgCQkvKiBUcnkgdG8gZ2V0IGEgc2luZ2xlIHBhZ2UuIFlvdSBh
cmUgbXkgb25seSBob3BlISAqLwo+IEBAIC05NTksMjEgKzk1OSw0OSBAQCBzdGF0aWMgc3RydWN0
IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9zcGxpdCgKPiAgIAkJCQkJICAmZG1h
X2FkZHIsIEdGUF9LRVJORUx8X19HRlBfWkVSTyk7Cj4gICAJfQo+ICAgCWlmICghcXVldWUpCj4g
LQkJcmV0dXJuIE5VTEw7Cj4gKwkJcmV0dXJuIC1FTk9NRU07Cj4gICAKPiAgIAlxdWV1ZV9zaXpl
X2luX2J5dGVzID0gdnJpbmdfc2l6ZShudW0sIHZyaW5nX2FsaWduKTsKPiAtCXZyaW5nX2luaXQo
JnZyaW5nLCBudW0sIHF1ZXVlLCB2cmluZ19hbGlnbik7Cj4gKwl2cmluZ19pbml0KCZ2cmluZy0+
dnJpbmcsIG51bSwgcXVldWUsIHZyaW5nX2FsaWduKTsKCgpJdCdzIGJldHRlciB0byBtb3ZlIHRo
aXMgdG8gaXRzIGNhbGxlciAodnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9zcGxpdCksIApzbyB3ZSBo
YXZlIHJhdGhlciBzaW1wbGUgbG9naWMgYmVsb3c6CgoKCj4gKwo+ICsJdnJpbmctPmRtYV9hZGRy
ID0gZG1hX2FkZHI7Cj4gKwl2cmluZy0+cXVldWUgPSBxdWV1ZTsKPiArCXZyaW5nLT5xdWV1ZV9z
aXplX2luX2J5dGVzID0gcXVldWVfc2l6ZV9pbl9ieXRlczsKPiArCj4gKwlyZXR1cm4gMDsKPiAr
fQo+ICsKPiArc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVf
c3BsaXQoCj4gKwl1bnNpZ25lZCBpbnQgaW5kZXgsCj4gKwl1bnNpZ25lZCBpbnQgbnVtLAo+ICsJ
dW5zaWduZWQgaW50IHZyaW5nX2FsaWduLAo+ICsJc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYs
Cj4gKwlib29sIHdlYWtfYmFycmllcnMsCj4gKwlib29sIG1heV9yZWR1Y2VfbnVtLAo+ICsJYm9v
bCBjb250ZXh0LAo+ICsJYm9vbCAoKm5vdGlmeSkoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiArCXZv
aWQgKCpjYWxsYmFjaykoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiArCWNvbnN0IGNoYXIgKm5hbWUp
Cj4gK3sKPiArCXN0cnVjdCB2cmluZ19zcGxpdCB2cmluZzsKPiArCXN0cnVjdCB2aXJ0cXVldWUg
KnZxOwo+ICsJaW50IGVycjsKPiArCj4gKwllcnIgPSB2cmluZ19jcmVhdGVfdnJpbmdfc3BsaXQo
JnZyaW5nLCB2ZGV2LCB2cmluZ19hbGlnbiwgd2Vha19iYXJyaWVycywKPiArCQkJCSAgICAgICBt
YXlfcmVkdWNlX251bSwgbnVtKTsKPiArCWlmIChlcnIpCj4gKwkJcmV0dXJuIE5VTEw7CgoKcXVl
dWUgPSB2cmluZ19hbGxvY19xdWV1ZV9zcGxpdCh2ZGV2LCAmZG1hX2FkZHIsIC4uLik7CgppZiAo
IXF1ZXVlKQoKIMKgwqDCoCByZXR1cm4gLUVOT01FTTsKCnZyaW5nX2luaXQoKTsKCi4uLgoKVGhh
bmtzCgoKPiAgIAo+IC0JdnEgPSBfX3ZyaW5nX25ld192aXJ0cXVldWUoaW5kZXgsIHZyaW5nLCB2
ZGV2LCB3ZWFrX2JhcnJpZXJzLCBjb250ZXh0LAo+ICsJdnEgPSBfX3ZyaW5nX25ld192aXJ0cXVl
dWUoaW5kZXgsIHZyaW5nLnZyaW5nLCB2ZGV2LCB3ZWFrX2JhcnJpZXJzLCBjb250ZXh0LAo+ICAg
CQkJCSAgIG5vdGlmeSwgY2FsbGJhY2ssIG5hbWUpOwo+ICAgCWlmICghdnEpIHsKPiAtCQl2cmlu
Z19mcmVlX3F1ZXVlKHZkZXYsIHF1ZXVlX3NpemVfaW5fYnl0ZXMsIHF1ZXVlLAo+IC0JCQkJIGRt
YV9hZGRyKTsKPiArCQl2cmluZ19mcmVlX3F1ZXVlKHZkZXYsIHZyaW5nLnF1ZXVlX3NpemVfaW5f
Ynl0ZXMsIHZyaW5nLnF1ZXVlLAo+ICsJCQkJIHZyaW5nLmRtYV9hZGRyKTsKPiAgIAkJcmV0dXJu
IE5VTEw7Cj4gICAJfQo+ICAgCj4gLQl0b192dnEodnEpLT5zcGxpdC5xdWV1ZV9kbWFfYWRkciA9
IGRtYV9hZGRyOwo+IC0JdG9fdnZxKHZxKS0+c3BsaXQucXVldWVfc2l6ZV9pbl9ieXRlcyA9IHF1
ZXVlX3NpemVfaW5fYnl0ZXM7Cj4gKwl0b192dnEodnEpLT5zcGxpdC5xdWV1ZV9kbWFfYWRkciA9
IHZyaW5nLmRtYV9hZGRyOwo+ICsJdG9fdnZxKHZxKS0+c3BsaXQucXVldWVfc2l6ZV9pbl9ieXRl
cyA9IHZyaW5nLnF1ZXVlX3NpemVfaW5fYnl0ZXM7Cj4gICAJdG9fdnZxKHZxKS0+d2Vfb3duX3Jp
bmcgPSB0cnVlOwo+ICAgCj4gICAJcmV0dXJuIHZxOwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
