Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4406C433EF
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 09:28:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90B1C415EA;
	Wed,  9 Mar 2022 09:28:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0y6iF1B3MrIz; Wed,  9 Mar 2022 09:28:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 165D7415EB;
	Wed,  9 Mar 2022 09:28:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBBD7C0012;
	Wed,  9 Mar 2022 09:28:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A73A4C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:28:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 96C2D415EB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:28:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b79YJNjYDaya
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:28:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C71F8415EA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646818125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hWn8/vrpqWZiMgWnWn1Y0AikbZvs5gY1FZ1FP2CFNp8=;
 b=X1zOWw5UgQrZ/81C7XZY7uPFeZhpHfL0LbWlc5PWF4rNDy0yD28IPQt5L8ryQvnseHYywD
 K0Ss+RMZIoU0DCHbf4w9kR1/IAPoZKBrB81nP51lloXs5z5WqPefI+K+qDItPJMIkc4sgj
 wEykA2deZjHRT+TsebWqDRA1zDYxg/U=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112--xsaXjy_P3Kgq9NlTHvI7g-1; Wed, 09 Mar 2022 04:28:42 -0500
X-MC-Unique: -xsaXjy_P3Kgq9NlTHvI7g-1
Received: by mail-pj1-f71.google.com with SMTP id
 p15-20020a17090a748f00b001bf3ba2ae95so1223617pjk.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Mar 2022 01:28:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=hWn8/vrpqWZiMgWnWn1Y0AikbZvs5gY1FZ1FP2CFNp8=;
 b=Owt+WBTUrMC2LAgVuXzdM8mu5t0Rx4d8DXPFNVzcp0W9pxLBuAb3lm2EoG/q1yGizJ
 xaL0KYCUDMnhlLafZ5pczQDIlNOP6MGLHxB1LBZAKyIEsmp7aCI725Kh3+9NjqM+Mc6X
 f+jp4cZ4UHZkAXc4HEYA5iArnWKtJQ8QSSku7Ctj8P3zzCfhrk528mA1E4uX3wV2z8k/
 w/5TMHwB1WFuIb+tn6KHdJKicdUXwysVMTRLAtgz0ESQJ5mvaZISMXGUKP4uPGOReDNQ
 LHDSBqOqo8Ik2P8cZ7J9e8q4UPh8R7RaE8UT6PTxSYd0WmNxbZR23I3YNrwAUQTAw5nm
 7u5g==
X-Gm-Message-State: AOAM532mS8s8OPmzUdSg13a7nP85AZgsVtzi50kDaQy0D2mx3rQR13RM
 ID0bIAyRVMjppcy7Te6oN6PyH1ka9/vJqQeWSxLNxgNey2oJL40kNaYGeFkc+DSdnCWc8Q0NVJW
 9OfqyFTOsx9nO0wjTTc6UrqDmd5u4NM32k9O79gkRCw==
X-Received: by 2002:a17:902:8f83:b0:151:5c71:a6e6 with SMTP id
 z3-20020a1709028f8300b001515c71a6e6mr22071870plo.126.1646818121763; 
 Wed, 09 Mar 2022 01:28:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKLZVIwZDJNnQ8YaxGrbHS5lO7yIdkUUhfXnPrMYsGuclXTOzQNdeuiPknSERt+cv2yMNnwA==
X-Received: by 2002:a17:902:8f83:b0:151:5c71:a6e6 with SMTP id
 z3-20020a1709028f8300b001515c71a6e6mr22071834plo.126.1646818121459; 
 Wed, 09 Mar 2022 01:28:41 -0800 (PST)
Received: from [10.72.12.183] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 f21-20020a056a00239500b004f754dd3d4csm2116960pfc.3.2022.03.09.01.28.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Mar 2022 01:28:40 -0800 (PST)
Message-ID: <d7ec6eed-d692-091b-a438-1ae1cc5ee614@redhat.com>
Date: Wed, 9 Mar 2022 17:28:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 25/26] virtio_net: set the default max ring size by
 find_vqs()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-26-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-26-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g5YaZ6YGTOgo+IFVzZSB2aXJ0aW9f
ZmluZF92cXNfY3R4X3NpemUoKSB0byBzcGVjaWZ5IHRoZSBtYXhpbXVtIHJpbmcgc2l6ZSBvZiB0
eCwKPiByeCBhdCB0aGUgc2FtZSB0aW1lLgo+Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICB8
IHJ4L3R4IHJpbmcgc2l6ZQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KPiBzcGVlZCA9PSBVTktOT1dOIG9yIDwgMTBHfCAxMDI0Cj4gc3BlZWQgPCA0MEcgICAg
ICAgICAgICAgIHwgNDA5Ngo+IHNwZWVkID49IDQwRyAgICAgICAgICAgICB8IDgxOTIKPgo+IENh
bGwgdmlydG5ldF91cGRhdGVfc2V0dGluZ3MoKSBvbmNlIGJlZm9yZSBjYWxsaW5nIGluaXRfdnFz
KCkgdG8gdXBkYXRlCj4gc3BlZWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56
aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
IHwgNDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4g
aW5kZXggZmZmZjMyM2RjZWYwLi5mMWJkYzZjZTIxYzMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gQEAgLTI5
NzcsNiArMjk3NywyOSBAQCBzdGF0aWMgdW5zaWduZWQgaW50IG1lcmdlYWJsZV9taW5fYnVmX2xl
bihzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwgc3RydWN0IHZpcnRxdQo+ICAgCQkgICAodW5zaWdu
ZWQgaW50KUdPT0RfUEFDS0VUX0xFTik7Cj4gICB9Cj4gICAKPiArc3RhdGljIHZvaWQgdmlydG5l
dF9jb25maWdfc2l6ZXMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksIHUzMiAqc2l6ZXMpCj4gK3sK
PiArCXUzMiBpLCByeF9zaXplLCB0eF9zaXplOwo+ICsKPiArCWlmICh2aS0+c3BlZWQgPT0gU1BF
RURfVU5LTk9XTiB8fCB2aS0+c3BlZWQgPCBTUEVFRF8xMDAwMCkgewo+ICsJCXJ4X3NpemUgPSAx
MDI0Owo+ICsJCXR4X3NpemUgPSAxMDI0Owo+ICsKPiArCX0gZWxzZSBpZiAodmktPnNwZWVkIDwg
U1BFRURfNDAwMDApIHsKPiArCQlyeF9zaXplID0gMTAyNCAqIDQ7Cj4gKwkJdHhfc2l6ZSA9IDEw
MjQgKiA0Owo+ICsKPiArCX0gZWxzZSB7Cj4gKwkJcnhfc2l6ZSA9IDEwMjQgKiA4Owo+ICsJCXR4
X3NpemUgPSAxMDI0ICogODsKPiArCX0KPiArCj4gKwlmb3IgKGkgPSAwOyBpIDwgdmktPm1heF9x
dWV1ZV9wYWlyczsgaSsrKSB7Cj4gKwkJc2l6ZXNbcnhxMnZxKGkpXSA9IHJ4X3NpemU7Cj4gKwkJ
c2l6ZXNbdHhxMnZxKGkpXSA9IHR4X3NpemU7Cj4gKwl9Cj4gK30KPiArCj4gICBzdGF0aWMgaW50
IHZpcnRuZXRfZmluZF92cXMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gICB7Cj4gICAJdnFf
Y2FsbGJhY2tfdCAqKmNhbGxiYWNrczsKPiBAQCAtMjk4NCw2ICszMDA3LDcgQEAgc3RhdGljIGlu
dCB2aXJ0bmV0X2ZpbmRfdnFzKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpKQo+ICAgCWludCByZXQg
PSAtRU5PTUVNOwo+ICAgCWludCBpLCB0b3RhbF92cXM7Cj4gICAJY29uc3QgY2hhciAqKm5hbWVz
Owo+ICsJdTMyICpzaXplczsKPiAgIAlib29sICpjdHg7Cj4gICAKPiAgIAkvKiBXZSBleHBlY3Qg
MSBSWCB2aXJ0cXVldWUgZm9sbG93ZWQgYnkgMSBUWCB2aXJ0cXVldWUsIGZvbGxvd2VkIGJ5Cj4g
QEAgLTMwMTEsMTAgKzMwMzUsMTUgQEAgc3RhdGljIGludCB2aXJ0bmV0X2ZpbmRfdnFzKHN0cnVj
dCB2aXJ0bmV0X2luZm8gKnZpKQo+ICAgCQljdHggPSBOVUxMOwo+ICAgCX0KPiAgIAo+ICsJc2l6
ZXMgPSBrbWFsbG9jX2FycmF5KHRvdGFsX3Zxcywgc2l6ZW9mKCpzaXplcyksIEdGUF9LRVJORUwp
Owo+ICsJaWYgKCFzaXplcykKPiArCQlnb3RvIGVycl9zaXplczsKPiArCj4gICAJLyogUGFyYW1l
dGVycyBmb3IgY29udHJvbCB2aXJ0cXVldWUsIGlmIGFueSAqLwo+ICAgCWlmICh2aS0+aGFzX2N2
cSkgewo+ICAgCQljYWxsYmFja3NbdG90YWxfdnFzIC0gMV0gPSBOVUxMOwo+ICAgCQluYW1lc1t0
b3RhbF92cXMgLSAxXSA9ICJjb250cm9sIjsKPiArCQlzaXplc1t0b3RhbF92cXMgLSAxXSA9IDA7
CgoKTml0OiBEbyB3ZSBuZWVkIGEgc2FuZSB2YWx1ZSBmb3IgdGhlIGNvbnRyb2wgdnE/IChlLmcg
NjQpCgpUaGFua3MKCgo+ICAgCX0KPiAgIAo+ICAgCS8qIEFsbG9jYXRlL2luaXRpYWxpemUgcGFy
YW1ldGVycyBmb3Igc2VuZC9yZWNlaXZlIHZpcnRxdWV1ZXMgKi8KPiBAQCAtMzAyOSw4ICszMDU4
LDEwIEBAIHN0YXRpYyBpbnQgdmlydG5ldF9maW5kX3ZxcyhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2
aSkKPiAgIAkJCWN0eFtyeHEydnEoaSldID0gdHJ1ZTsKPiAgIAl9Cj4gICAKPiAtCXJldCA9IHZp
cnRpb19maW5kX3Zxc19jdHgodmktPnZkZXYsIHRvdGFsX3ZxcywgdnFzLCBjYWxsYmFja3MsCj4g
LQkJCQkgIG5hbWVzLCBjdHgsIE5VTEwpOwo+ICsJdmlydG5ldF9jb25maWdfc2l6ZXModmksIHNp
emVzKTsKPiArCj4gKwlyZXQgPSB2aXJ0aW9fZmluZF92cXNfY3R4X3NpemUodmktPnZkZXYsIHRv
dGFsX3ZxcywgdnFzLCBjYWxsYmFja3MsCj4gKwkJCQkgICAgICAgbmFtZXMsIGN0eCwgTlVMTCwg
c2l6ZXMpOwo+ICAgCWlmIChyZXQpCj4gICAJCWdvdG8gZXJyX2ZpbmQ7Cj4gICAKPiBAQCAtMzA1
MCw2ICszMDgxLDggQEAgc3RhdGljIGludCB2aXJ0bmV0X2ZpbmRfdnFzKHN0cnVjdCB2aXJ0bmV0
X2luZm8gKnZpKQo+ICAgCj4gICAKPiAgIGVycl9maW5kOgo+ICsJa2ZyZWUoc2l6ZXMpOwo+ICtl
cnJfc2l6ZXM6Cj4gICAJa2ZyZWUoY3R4KTsKPiAgIGVycl9jdHg6Cj4gICAJa2ZyZWUobmFtZXMp
Owo+IEBAIC0zMzY4LDYgKzM0MDEsOSBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcHJvYmUoc3RydWN0
IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gICAJCXZpLT5jdXJyX3F1ZXVlX3BhaXJzID0gbnVtX29u
bGluZV9jcHVzKCk7Cj4gICAJdmktPm1heF9xdWV1ZV9wYWlycyA9IG1heF9xdWV1ZV9wYWlyczsK
PiAgIAo+ICsJdmlydG5ldF9pbml0X3NldHRpbmdzKGRldik7Cj4gKwl2aXJ0bmV0X3VwZGF0ZV9z
ZXR0aW5ncyh2aSk7Cj4gKwo+ICAgCS8qIEFsbG9jYXRlL2luaXRpYWxpemUgdGhlIHJ4L3R4IHF1
ZXVlcywgYW5kIGludm9rZSBmaW5kX3ZxcyAqLwo+ICAgCWVyciA9IGluaXRfdnFzKHZpKTsKPiAg
IAlpZiAoZXJyKQo+IEBAIC0zMzgwLDggKzM0MTYsNiBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcHJv
YmUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gICAJbmV0aWZfc2V0X3JlYWxfbnVtX3R4
X3F1ZXVlcyhkZXYsIHZpLT5jdXJyX3F1ZXVlX3BhaXJzKTsKPiAgIAluZXRpZl9zZXRfcmVhbF9u
dW1fcnhfcXVldWVzKGRldiwgdmktPmN1cnJfcXVldWVfcGFpcnMpOwo+ICAgCj4gLQl2aXJ0bmV0
X2luaXRfc2V0dGluZ3MoZGV2KTsKPiAtCj4gICAJaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2
LCBWSVJUSU9fTkVUX0ZfU1RBTkRCWSkpIHsKPiAgIAkJdmktPmZhaWxvdmVyID0gbmV0X2ZhaWxv
dmVyX2NyZWF0ZSh2aS0+ZGV2KTsKPiAgIAkJaWYgKElTX0VSUih2aS0+ZmFpbG92ZXIpKSB7Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
