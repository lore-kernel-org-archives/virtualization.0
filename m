Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7ACAC433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 06:28:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5BD1140141;
	Tue, 12 Apr 2022 06:28:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Mfi8IuOxr4g; Tue, 12 Apr 2022 06:28:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D87AD400EF;
	Tue, 12 Apr 2022 06:28:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B84CBC0082;
	Tue, 12 Apr 2022 06:28:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE0E0C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:28:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A55EE81D5C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:28:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OySbMdeFiudJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:28:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E34B481D47
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649744925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=96mvZW2N60Bc/yiEAvufsCeVXhKGkkUOXQ1a79/ykgI=;
 b=QQ3Uk7i50uiyGM+v/UCdvwtzazxkWrT97LhkLDIkGjmc7j1Vl5IkPT72uN8MuV95Tnd7Yq
 56p6ISD61iV1UWu3vB5ioS8ta7pnnpGLhjIcMidgXgXBZeerFMmVJz5aoo8XDxdxLPwvWN
 LQpni3Yw/ELtveuJ5Ghp+w7J0JtKbwk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-m3V5COtLMfuZ1YmAk1mdfg-1; Tue, 12 Apr 2022 02:28:42 -0400
X-MC-Unique: m3V5COtLMfuZ1YmAk1mdfg-1
Received: by mail-pf1-f200.google.com with SMTP id
 z20-20020a62d114000000b0050567b73da5so6567168pfg.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 23:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=96mvZW2N60Bc/yiEAvufsCeVXhKGkkUOXQ1a79/ykgI=;
 b=EWvVaDGujeECtBVHAdcqF8/yX3eHnol5u5onofS1OwT4K6xUqavSR3ocDmDpOV49xX
 9RSrmq/vlLPTKEsYWddmG7X2h1WR7yJ7PUjswfOpwfoE43S2UITVxYB8AFB8ATVu8+XH
 9WtnodFWP+jenEQOX2EL42Jqsvc6hx+O8lPYFTNksWLOqUL1e6We0FrfJrWvLdkrGhC6
 Mag1x+5X2QzZylC/CvfNcq7gwg1njOXFNHLE3kztz/UrJX/otJDocP9bJaQ97H+9HdsD
 VUJQOX/OkSOZ5kMRY5bLP8QMq9WnOBJK/zkDlMMD005AjXUFZTLjaUxq7SVLRCDs1teN
 LM3Q==
X-Gm-Message-State: AOAM530TzOGus5sKnbYew5tizpJA9kOiPzrT4vAN0+ahNXDhgzD72iYD
 IUtAIsSJAxUuGxO7KEIvYvQkshNwwagrhpd6ihFFiibVupHhoRmLhPtkWKZqLPNvNVf1t0qnckb
 QKlVeVZZsenjrCddVoXMt8ZyO8yVHqLZltqqTfxZ/xg==
X-Received: by 2002:a17:90a:600b:b0:1cb:8ba5:d3bc with SMTP id
 y11-20020a17090a600b00b001cb8ba5d3bcmr3322149pji.42.1649744921376; 
 Mon, 11 Apr 2022 23:28:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsTZb815vqxK0EhXJcoHB9RSXY3UmD7WoV1CP0Y3EhajIsat86IZWa2d15JEEcfRFMnydtCQ==
X-Received: by 2002:a17:90a:600b:b0:1cb:8ba5:d3bc with SMTP id
 y11-20020a17090a600b00b001cb8ba5d3bcmr3322121pji.42.1649744921156; 
 Mon, 11 Apr 2022 23:28:41 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 md4-20020a17090b23c400b001cb66e3e1f8sm1483400pjb.0.2022.04.11.23.28.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Apr 2022 23:28:40 -0700 (PDT)
Message-ID: <4da7b8dc-74ca-fc1b-fbdb-21f9943e8d45@redhat.com>
Date: Tue, 12 Apr 2022 14:28:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 12/32] virtio_ring: packed: extract the logic of alloc
 queue
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-13-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-13-xuanzhuo@linux.alibaba.com>
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
aGUgbG9naWMgb2YgcGFja2VkIHRvIGNyZWF0ZSB2cmluZyBxdWV1ZS4KPgo+IEZvciB0aGUgY29u
dmVuaWVuY2Ugb2YgcGFzc2luZyBwYXJhbWV0ZXJzLCBhZGQgYSBzdHJ1Y3R1cmUKPiB2cmluZ19w
YWNrZWQuCj4KPiBUaGlzIGZlYXR1cmUgaXMgcmVxdWlyZWQgZm9yIHN1YnNlcXVlbnQgdmlydHVx
dWV1ZSByZXNldCB2cmluZy4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9A
bGludXguYWxpYmFiYS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5j
IHwgNzAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tCj4gICAxIGZpbGUgY2hh
bmdlZCwgNTYgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5n
LmMKPiBpbmRleCAzMzg2NDEzNGE3NDQuLmVhNDUxYWUyYWFlZiAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYwo+IEBAIC0xODE3LDE5ICsxODE3LDE3IEBAIHN0YXRpYyBzdHJ1Y3QgdnJpbmdfZGVzY19l
eHRyYSAqdnJpbmdfYWxsb2NfZGVzY19leHRyYSh1bnNpZ25lZCBpbnQgbnVtKQo+ICAgCXJldHVy
biBkZXNjX2V4dHJhOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmlu
Z19jcmVhdGVfdmlydHF1ZXVlX3BhY2tlZCgKPiAtCXVuc2lnbmVkIGludCBpbmRleCwKPiAtCXVu
c2lnbmVkIGludCBudW0sCj4gLQl1bnNpZ25lZCBpbnQgdnJpbmdfYWxpZ24sCj4gLQlzdHJ1Y3Qg
dmlydGlvX2RldmljZSAqdmRldiwKPiAtCWJvb2wgd2Vha19iYXJyaWVycywKPiAtCWJvb2wgbWF5
X3JlZHVjZV9udW0sCj4gLQlib29sIGNvbnRleHQsCj4gLQlib29sICgqbm90aWZ5KShzdHJ1Y3Qg
dmlydHF1ZXVlICopLAo+IC0Jdm9pZCAoKmNhbGxiYWNrKShzdHJ1Y3QgdmlydHF1ZXVlICopLAo+
IC0JY29uc3QgY2hhciAqbmFtZSkKPiArc3RhdGljIGludCB2cmluZ19hbGxvY19xdWV1ZV9wYWNr
ZWQoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gKwkJCQkgICAgdTMyIG51bSwKPiArCQkJ
CSAgICBzdHJ1Y3QgdnJpbmdfcGFja2VkX2Rlc2MgKipfcmluZywKPiArCQkJCSAgICBzdHJ1Y3Qg
dnJpbmdfcGFja2VkX2Rlc2NfZXZlbnQgKipfZHJpdmVyLAo+ICsJCQkJICAgIHN0cnVjdCB2cmlu
Z19wYWNrZWRfZGVzY19ldmVudCAqKl9kZXZpY2UsCj4gKwkJCQkgICAgZG1hX2FkZHJfdCAqX3Jp
bmdfZG1hX2FkZHIsCj4gKwkJCQkgICAgZG1hX2FkZHJfdCAqX2RyaXZlcl9ldmVudF9kbWFfYWRk
ciwKPiArCQkJCSAgICBkbWFfYWRkcl90ICpfZGV2aWNlX2V2ZW50X2RtYV9hZGRyLAo+ICsJCQkJ
ICAgIHNpemVfdCAqX3Jpbmdfc2l6ZV9pbl9ieXRlcywKPiArCQkJCSAgICBzaXplX3QgKl9ldmVu
dF9zaXplX2luX2J5dGVzKQo+ICAgewo+IC0Jc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnE7Cj4g
ICAJc3RydWN0IHZyaW5nX3BhY2tlZF9kZXNjICpyaW5nOwo+ICAgCXN0cnVjdCB2cmluZ19wYWNr
ZWRfZGVzY19ldmVudCAqZHJpdmVyLCAqZGV2aWNlOwo+ICAgCWRtYV9hZGRyX3QgcmluZ19kbWFf
YWRkciwgZHJpdmVyX2V2ZW50X2RtYV9hZGRyLCBkZXZpY2VfZXZlbnRfZG1hX2FkZHI7Cj4gQEAg
LTE4NTcsNiArMTg1NSw1MiBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRl
X3ZpcnRxdWV1ZV9wYWNrZWQoCj4gICAJaWYgKCFkZXZpY2UpCj4gICAJCWdvdG8gZXJyX2Rldmlj
ZTsKPiAgIAo+ICsJKl9yaW5nICAgICAgICAgICAgICAgICAgID0gcmluZzsKPiArCSpfZHJpdmVy
ICAgICAgICAgICAgICAgICA9IGRyaXZlcjsKPiArCSpfZGV2aWNlICAgICAgICAgICAgICAgICA9
IGRldmljZTsKPiArCSpfcmluZ19kbWFfYWRkciAgICAgICAgICA9IHJpbmdfZG1hX2FkZHI7Cj4g
KwkqX2RyaXZlcl9ldmVudF9kbWFfYWRkciAgPSBkcml2ZXJfZXZlbnRfZG1hX2FkZHI7Cj4gKwkq
X2RldmljZV9ldmVudF9kbWFfYWRkciAgPSBkZXZpY2VfZXZlbnRfZG1hX2FkZHI7Cj4gKwkqX3Jp
bmdfc2l6ZV9pbl9ieXRlcyAgICAgPSByaW5nX3NpemVfaW5fYnl0ZXM7Cj4gKwkqX2V2ZW50X3Np
emVfaW5fYnl0ZXMgICAgPSBldmVudF9zaXplX2luX2J5dGVzOwoKCkkgd29uZGVyIGlmIHdlIGNh
biBzaW1wbHkgZmFjdG9yIG91dCBzcGxpdCBhbmQgcGFja2VkIGZyb20gc3RydWN0IAp2cmluZ192
aXJ0cXVldWU6CgpzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlIHsKIMKgwqDCoCB1bmlvbiB7CiDCoMKg
wqAgwqDCoMKgIHN0cnVjdCB7fSBzcGxpdDsKIMKgwqDCoCDCoMKgwqAgc3RydWN0IHt9IHBhY2tl
ZDsKIMKgwqDCoCB9Owp9OwoKdG8KCnN0cnVjdCB2cmluZ192aXJ0cXVldWVfc3BsaXQge307CnN0
cnVjdCB2cmluZ192aXJ0cXVldWVfcGFja2VkIHt9OwoKVGhlbiB3ZSBjYW4gZG8gdGhpbmdzIGxp
a2U6Cgp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3BhY2tlZChzdHJ1Y3QgdmlydGlvX2RldmljZSAq
dmRldiwgdTMyIG51bSwgCnN0cnVjdCB2cmluZ192aXJ0cXVldWVfcGFja2VkICpwYWNrZWQpOwoK
YW5kCgp2cmluZ192cml0cXVldWVfYXR0YWNoX3BhY2tlZChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVl
ICp2cSwgc3RydWN0IAp2cmluZ192aXJ0cXVldWVfcGFja2VkIHBhY2tlZCk7CgpUaGFua3MKCgo+
ICsKPiArCXJldHVybiAwOwo+ICsKPiArZXJyX2RldmljZToKPiArCXZyaW5nX2ZyZWVfcXVldWUo
dmRldiwgZXZlbnRfc2l6ZV9pbl9ieXRlcywgZHJpdmVyLCBkcml2ZXJfZXZlbnRfZG1hX2FkZHIp
Owo+ICsKPiArZXJyX2RyaXZlcjoKPiArCXZyaW5nX2ZyZWVfcXVldWUodmRldiwgcmluZ19zaXpl
X2luX2J5dGVzLCByaW5nLCByaW5nX2RtYV9hZGRyKTsKPiArCj4gK2Vycl9yaW5nOgo+ICsJcmV0
dXJuIC1FTk9NRU07Cj4gK30KPiArCj4gK3N0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19j
cmVhdGVfdmlydHF1ZXVlX3BhY2tlZCgKPiArCXVuc2lnbmVkIGludCBpbmRleCwKPiArCXVuc2ln
bmVkIGludCBudW0sCj4gKwl1bnNpZ25lZCBpbnQgdnJpbmdfYWxpZ24sCj4gKwlzdHJ1Y3Qgdmly
dGlvX2RldmljZSAqdmRldiwKPiArCWJvb2wgd2Vha19iYXJyaWVycywKPiArCWJvb2wgbWF5X3Jl
ZHVjZV9udW0sCj4gKwlib29sIGNvbnRleHQsCj4gKwlib29sICgqbm90aWZ5KShzdHJ1Y3Qgdmly
dHF1ZXVlICopLAo+ICsJdm9pZCAoKmNhbGxiYWNrKShzdHJ1Y3QgdmlydHF1ZXVlICopLAo+ICsJ
Y29uc3QgY2hhciAqbmFtZSkKPiArewo+ICsJZG1hX2FkZHJfdCByaW5nX2RtYV9hZGRyLCBkcml2
ZXJfZXZlbnRfZG1hX2FkZHIsIGRldmljZV9ldmVudF9kbWFfYWRkcjsKPiArCXN0cnVjdCB2cmlu
Z19wYWNrZWRfZGVzY19ldmVudCAqZHJpdmVyLCAqZGV2aWNlOwo+ICsJc2l6ZV90IHJpbmdfc2l6
ZV9pbl9ieXRlcywgZXZlbnRfc2l6ZV9pbl9ieXRlczsKPiArCXN0cnVjdCB2cmluZ19wYWNrZWRf
ZGVzYyAqcmluZzsKPiArCXN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxOwo+ICsKPiArCWlmICh2
cmluZ19hbGxvY19xdWV1ZV9wYWNrZWQodmRldiwgbnVtLCAmcmluZywgJmRyaXZlciwgJmRldmlj
ZSwKPiArCQkJCSAgICAgJnJpbmdfZG1hX2FkZHIsICZkcml2ZXJfZXZlbnRfZG1hX2FkZHIsCj4g
KwkJCQkgICAgICZkZXZpY2VfZXZlbnRfZG1hX2FkZHIsCj4gKwkJCQkgICAgICZyaW5nX3NpemVf
aW5fYnl0ZXMsCj4gKwkJCQkgICAgICZldmVudF9zaXplX2luX2J5dGVzKSkKPiArCQlnb3RvIGVy
cl9yaW5nOwo+ICsKPiAgIAl2cSA9IGttYWxsb2Moc2l6ZW9mKCp2cSksIEdGUF9LRVJORUwpOwo+
ICAgCWlmICghdnEpCj4gICAJCWdvdG8gZXJyX3ZxOwo+IEBAIC0xOTM5LDkgKzE5ODMsNyBAQCBz
dGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9wYWNrZWQoCj4g
ICAJa2ZyZWUodnEpOwo+ICAgZXJyX3ZxOgo+ICAgCXZyaW5nX2ZyZWVfcXVldWUodmRldiwgZXZl
bnRfc2l6ZV9pbl9ieXRlcywgZGV2aWNlLCBkZXZpY2VfZXZlbnRfZG1hX2FkZHIpOwo+IC1lcnJf
ZGV2aWNlOgo+ICAgCXZyaW5nX2ZyZWVfcXVldWUodmRldiwgZXZlbnRfc2l6ZV9pbl9ieXRlcywg
ZHJpdmVyLCBkcml2ZXJfZXZlbnRfZG1hX2FkZHIpOwo+IC1lcnJfZHJpdmVyOgo+ICAgCXZyaW5n
X2ZyZWVfcXVldWUodmRldiwgcmluZ19zaXplX2luX2J5dGVzLCByaW5nLCByaW5nX2RtYV9hZGRy
KTsKPiAgIGVycl9yaW5nOgo+ICAgCXJldHVybiBOVUxMOwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
