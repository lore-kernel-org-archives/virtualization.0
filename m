Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAACC433FE
	for <virtualization@archiver.kernel.org>; Wed, 13 Apr 2022 08:07:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35200827FB;
	Wed, 13 Apr 2022 08:07:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 90VsV3QSW00U; Wed, 13 Apr 2022 08:06:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B1B158246F;
	Wed, 13 Apr 2022 08:06:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9219FC0083;
	Wed, 13 Apr 2022 08:06:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77297C002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 08:06:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 55E3E8246F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 08:06:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ep2FNB0zZDBJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 08:06:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0FA14827FB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 08:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649837214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3oVDDbPJyK3HgpM5oKcpbE9J9tBIr9ChlAXnnhFjPGo=;
 b=VJekOwGbLy7d1Uvdnd974Z1VOkxCkal8E4PikuOfzh54STCpjdgSs3prB2WhIbccHCZ9c3
 TfdsvZG54Elk6DqOXHJKUcpdYGFLFIy3Wc5W4PYCBxpS8rh71rSMB4UoM2fnGmMOwMfIby
 ZhNkoxIvSYLJmfjrZDZ+iYrNg0NAJuI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-9dveI33WPCuKx-96qIlZIw-1; Wed, 13 Apr 2022 04:06:50 -0400
X-MC-Unique: 9dveI33WPCuKx-96qIlZIw-1
Received: by mail-pg1-f199.google.com with SMTP id
 w3-20020a639343000000b003821fb4a367so706031pgm.21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 01:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=3oVDDbPJyK3HgpM5oKcpbE9J9tBIr9ChlAXnnhFjPGo=;
 b=1BTMBgNkx2RBmMP8Sf2T4Gla/aep26YXnq43EGG2F3fbocAJ8Im7B/uWaAs3xSBVHS
 DW7xsfS/sxz10AYx1qmYkmQ9p7knYLa0Ulk0/CIYE4G3NnZipODFQmMwYugrSW610izb
 H1tyBP4SxqrQh21SfKpsx6JqyhipIkAj0doWrDnnELrzfcfETCmfalAA2NKquvCG2HWu
 v9sLLM83MdB0tuuMEC9Rw8WC7HEZqD41oEqS29SK190xjBVSYTD5ExcWKy8FIYawFmMy
 ovrPJIv21j5Yvw3Vq7GRr/LECqX/I7hYtjuPm4ibiEuZLJllDRDBdTxb5O557gx0q0Y1
 CpIQ==
X-Gm-Message-State: AOAM5321V9RcbABZh7hhvLITj3Z3I9vsrsmZz7S/9fDQ/pRcIIJDdEQL
 VNyyx3ZqKt4Oi/opHHX7sn9+l8aIxiWQXH//X5PilJ5KTXEe9s+Ic/HjfXUvv/orSHr43ZL8NO5
 J4mxQHqOzIANsNT4rfgYozIPbzFRZmjs8aaEU3q/0HQ==
X-Received: by 2002:a17:90b:1e06:b0:1cb:b742:ba0d with SMTP id
 pg6-20020a17090b1e0600b001cbb742ba0dmr9526933pjb.24.1649837209917; 
 Wed, 13 Apr 2022 01:06:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxA8440BQVqz6KdwXBOHrMtT4WnGyMxsQffyGtbEDMm0ObQF/C2qu9IScvqE/FloA/61fylAQ==
X-Received: by 2002:a17:90b:1e06:b0:1cb:b742:ba0d with SMTP id
 pg6-20020a17090b1e0600b001cbb742ba0dmr9526892pjb.24.1649837209610; 
 Wed, 13 Apr 2022 01:06:49 -0700 (PDT)
Received: from [10.72.13.223] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a17090a680a00b001c7bf7d32f9sm1982517pjj.55.2022.04.13.01.06.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Apr 2022 01:06:49 -0700 (PDT)
Message-ID: <96d1fe97-2e8a-ae8a-a35f-bba2ce0f44b4@redhat.com>
Date: Wed, 13 Apr 2022 16:06:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 32/32] virtio_net: support set_ringparam
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-33-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-33-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBTdXBwb3J0IHNl
dF9yaW5ncGFyYW0gYmFzZWQgb24gdmlydGlvIHF1ZXVlIHJlc2V0Lgo+Cj4gVXNlcnMgY2FuIHVz
ZSBldGh0b29sIC1HIGV0aDAgPHJpbmdfbnVtPiB0byBtb2RpZnkgdGhlIHJpbmcgc2l6ZSBvZgo+
IHZpcnRpby1uZXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PgoKKE9uZSB0aGluZyB0aGF0IEkgc2VlIGlzIHRoYXQsIHdoZW4gcmVzaXplIGZhaWxzLCB0aGUg
cGFyYW0gcmVwb3J0ZWQgdmlhIApnZXRfcmluZ3BhcmFtIG1pZ2h0IGJlIHdyb25nLCB0aGlzIGlz
IGEgY29ybmVyIGNhc2UgYnV0IG1pZ2h0IHdvcnRoIHRvIApmaXggaW4gdGhlIGZ1dHVyZSkuCgoK
PiAtLS0KPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDQ3ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCA0NyBpbnNlcnRpb25z
KCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jCj4gaW5kZXggYmE2ODU5ZjMwNWY3Li4zN2U0ZTI3ZjFlNGUgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jCj4gQEAgLTIyNjQsNiArMjI2NCw1MiBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X2dl
dF9yaW5ncGFyYW0oc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgIAlyaW5nLT50eF9wZW5kaW5n
ID0gdmlydHF1ZXVlX2dldF92cmluZ19zaXplKHZpLT5zcVswXS52cSk7Cj4gICB9Cj4gICAKPiAr
c3RhdGljIGludCB2aXJ0bmV0X3NldF9yaW5ncGFyYW0oc3RydWN0IG5ldF9kZXZpY2UgKmRldiwK
PiArCQkJCSBzdHJ1Y3QgZXRodG9vbF9yaW5ncGFyYW0gKnJpbmcsCj4gKwkJCQkgc3RydWN0IGtl
cm5lbF9ldGh0b29sX3JpbmdwYXJhbSAqa2VybmVsX3JpbmcsCj4gKwkJCQkgc3RydWN0IG5ldGxp
bmtfZXh0X2FjayAqZXh0YWNrKQo+ICt7Cj4gKwlzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9IG5l
dGRldl9wcml2KGRldik7Cj4gKwl1MzIgcnhfcGVuZGluZywgdHhfcGVuZGluZzsKPiArCXN0cnVj
dCByZWNlaXZlX3F1ZXVlICpycTsKPiArCXN0cnVjdCBzZW5kX3F1ZXVlICpzcTsKPiArCWludCBp
LCBlcnI7Cj4gKwo+ICsJaWYgKHJpbmctPnJ4X21pbmlfcGVuZGluZyB8fCByaW5nLT5yeF9qdW1i
b19wZW5kaW5nKQo+ICsJCXJldHVybiAtRUlOVkFMOwo+ICsKPiArCXJ4X3BlbmRpbmcgPSB2aXJ0
cXVldWVfZ2V0X3ZyaW5nX3NpemUodmktPnJxWzBdLnZxKTsKPiArCXR4X3BlbmRpbmcgPSB2aXJ0
cXVldWVfZ2V0X3ZyaW5nX3NpemUodmktPnNxWzBdLnZxKTsKPiArCj4gKwlpZiAocmluZy0+cnhf
cGVuZGluZyA9PSByeF9wZW5kaW5nICYmCj4gKwkgICAgcmluZy0+dHhfcGVuZGluZyA9PSB0eF9w
ZW5kaW5nKQo+ICsJCXJldHVybiAwOwo+ICsKPiArCWlmIChyaW5nLT5yeF9wZW5kaW5nID4gdmly
dHF1ZXVlX2dldF92cmluZ19tYXhfc2l6ZSh2aS0+cnFbMF0udnEpKQo+ICsJCXJldHVybiAtRUlO
VkFMOwo+ICsKPiArCWlmIChyaW5nLT50eF9wZW5kaW5nID4gdmlydHF1ZXVlX2dldF92cmluZ19t
YXhfc2l6ZSh2aS0+c3FbMF0udnEpKQo+ICsJCXJldHVybiAtRUlOVkFMOwo+ICsKPiArCWZvciAo
aSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJzOyBpKyspIHsKPiArCQlycSA9IHZpLT5ycSAr
IGk7Cj4gKwkJc3EgPSB2aS0+c3EgKyBpOwo+ICsKPiArCQlpZiAocmluZy0+dHhfcGVuZGluZyAh
PSB0eF9wZW5kaW5nKSB7Cj4gKwkJCWVyciA9IHZpcnRuZXRfdHhfcmVzaXplKHZpLCBzcSwgcmlu
Zy0+dHhfcGVuZGluZyk7Cj4gKwkJCWlmIChlcnIpCj4gKwkJCQlyZXR1cm4gZXJyOwo+ICsJCX0K
PiArCj4gKwkJaWYgKHJpbmctPnJ4X3BlbmRpbmcgIT0gcnhfcGVuZGluZykgewo+ICsJCQllcnIg
PSB2aXJ0bmV0X3J4X3Jlc2l6ZSh2aSwgcnEsIHJpbmctPnJ4X3BlbmRpbmcpOwo+ICsJCQlpZiAo
ZXJyKQo+ICsJCQkJcmV0dXJuIGVycjsKPiArCQl9Cj4gKwl9Cj4gKwo+ICsJcmV0dXJuIDA7Cj4g
K30KPiAgIAo+ICAgc3RhdGljIHZvaWQgdmlydG5ldF9nZXRfZHJ2aW5mbyhzdHJ1Y3QgbmV0X2Rl
dmljZSAqZGV2LAo+ICAgCQkJCXN0cnVjdCBldGh0b29sX2RydmluZm8gKmluZm8pCj4gQEAgLTI0
OTcsNiArMjU0Myw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZXRodG9vbF9vcHMgdmlydG5ldF9l
dGh0b29sX29wcyA9IHsKPiAgIAkuZ2V0X2RydmluZm8gPSB2aXJ0bmV0X2dldF9kcnZpbmZvLAo+
ICAgCS5nZXRfbGluayA9IGV0aHRvb2xfb3BfZ2V0X2xpbmssCj4gICAJLmdldF9yaW5ncGFyYW0g
PSB2aXJ0bmV0X2dldF9yaW5ncGFyYW0sCj4gKwkuc2V0X3JpbmdwYXJhbSA9IHZpcnRuZXRfc2V0
X3JpbmdwYXJhbSwKPiAgIAkuZ2V0X3N0cmluZ3MgPSB2aXJ0bmV0X2dldF9zdHJpbmdzLAo+ICAg
CS5nZXRfc3NldF9jb3VudCA9IHZpcnRuZXRfZ2V0X3NzZXRfY291bnQsCj4gICAJLmdldF9ldGh0
b29sX3N0YXRzID0gdmlydG5ldF9nZXRfZXRodG9vbF9zdGF0cywKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
