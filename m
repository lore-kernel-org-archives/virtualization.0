Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C662AC433EF
	for <virtualization@archiver.kernel.org>; Thu, 21 Jul 2022 09:30:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 51CFD405F8;
	Thu, 21 Jul 2022 09:30:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 51CFD405F8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zw0BD8PQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VDbviYAN25ye; Thu, 21 Jul 2022 09:30:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B114040194;
	Thu, 21 Jul 2022 09:30:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B114040194
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91803C0033;
	Thu, 21 Jul 2022 09:30:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70CAFC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 363058476C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:30:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 363058476C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zw0BD8PQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yfpSGaFnDbYV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:30:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4786A8474C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4786A8474C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658395837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cE2msxk6QPw86zAV3haYmpL0Ot9f5ZCy5ykRLxOKnec=;
 b=Zw0BD8PQzt8eDR7Z4yYzkv4nA/cdODimNqZo+i6Y18D1Ln025B5XuXcGpAS4ZiEACgkyi6
 /rQyIt3la/EWaSMLzSWCm++wwhkVc6tsDfYG33p0CYWTGkH5doB6YerLQ+Ju8Eh8sEePvR
 X33pXOlqPzg98knCrUtRn/lHpJZLyj4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-J-jSCH4oNOifARRY1pjqhQ-1; Thu, 21 Jul 2022 05:30:31 -0400
X-MC-Unique: J-jSCH4oNOifARRY1pjqhQ-1
Received: by mail-pl1-f198.google.com with SMTP id
 p10-20020a170902e74a00b0016c3f3acb51so869752plf.16
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 02:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=cE2msxk6QPw86zAV3haYmpL0Ot9f5ZCy5ykRLxOKnec=;
 b=20HwacSRctS4el+wfkkchzzKfw/O5emgBXo++Q7BgAfoRpCZPkpl0zQZRdPtu9CAv5
 ec9DUhdSPNdojE/LhdqUQio/Z0mj2+iuWt8yXCHQdBXh9dufjpYzY4S3BsO4UBql9qLz
 iI0zBxu5+kR2BqOQ3rEMgvDmaCnEr2xP7yhvplhqKQ2/Tt8T78VLzkve9q3cLgzAZZP8
 j1Irs2cbwTx5i1bunqXWACuTt1ja2p/DXcjh84Siwv+V3hDyMJcUEdfnbuBvfHRI9SbQ
 pwGABzETML0am/wxIaBUkjL2CHKaKu17ABHk+ArThcpbbD0bNOgmdeETruNql8nGelu5
 p5SA==
X-Gm-Message-State: AJIora/OyK0DcL9Mr6wv+K29c+UO+mHk7PpVn7q/+ImDQ9tVaTa38IfE
 TwbRjqqp2d1JgWqd8t5WhzrC/nhTdHXLO9DwyH/hFt1J5LJRk0vON2wZgHdr15bq/1W4qG8vKdz
 HwyLITLqOj/7EsmHJKcJmCCPFwKRS/svph6cwM9vETg==
X-Received: by 2002:a05:6a00:1308:b0:528:2ed8:7e3d with SMTP id
 j8-20020a056a00130800b005282ed87e3dmr44101349pfu.82.1658395830231; 
 Thu, 21 Jul 2022 02:30:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sZJ2tQPOK504th0WDmmE1eCdXGAgBe+DPqkW4Ch1xqd/jvYFMXQX10YnFglctjFz+BMq1srg==
X-Received: by 2002:a05:6a00:1308:b0:528:2ed8:7e3d with SMTP id
 j8-20020a056a00130800b005282ed87e3dmr44101301pfu.82.1658395829765; 
 Thu, 21 Jul 2022 02:30:29 -0700 (PDT)
Received: from [10.72.12.47] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 b14-20020a17090a6ace00b001f061359023sm988456pjm.21.2022.07.21.02.30.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Jul 2022 02:30:29 -0700 (PDT)
Message-ID: <cbc59d60-f3b3-465d-185b-5b83f893be63@redhat.com>
Date: Thu, 21 Jul 2022 17:30:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v12 39/40] virtio_net: support tx queue resize
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-40-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220720030436.79520-40-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Farman <farman@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 kangjie.xu@linux.alibaba.com, Heiko Carstens <hca@linux.ibm.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>
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

CuWcqCAyMDIyLzcvMjAgMTE6MDQsIFh1YW4gWmh1byDlhpnpgZM6Cj4gVGhpcyBwYXRjaCBpbXBs
ZW1lbnRzIHRoZSByZXNpemUgZnVuY3Rpb24gb2YgdGhlIHR4IHF1ZXVlcy4KPiBCYXNlZCBvbiB0
aGlzIGZ1bmN0aW9uLCBpdCBpcyBwb3NzaWJsZSB0byBtb2RpZnkgdGhlIHJpbmcgbnVtIG9mIHRo
ZQo+IHF1ZXVlLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5h
bGliYWJhLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4K
Cgo+IC0tLQo+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgNDcgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDQ3IGluc2VydGlv
bnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMKPiBpbmRleCAxMTE1YThiNTlhMDguLmQxZTY5NDBiNDZkOCAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMKPiBAQCAtMTM1LDYgKzEzNSw5IEBAIHN0cnVjdCBzZW5kX3F1ZXVlIHsKPiAg
IAlzdHJ1Y3QgdmlydG5ldF9zcV9zdGF0cyBzdGF0czsKPiAgIAo+ICAgCXN0cnVjdCBuYXBpX3N0
cnVjdCBuYXBpOwo+ICsKPiArCS8qIFJlY29yZCB3aGV0aGVyIHNxIGlzIGluIHJlc2V0IHN0YXRl
LiAqLwo+ICsJYm9vbCByZXNldDsKPiAgIH07Cj4gICAKPiAgIC8qIEludGVybmFsIHJlcHJlc2Vu
dGF0aW9uIG9mIGEgcmVjZWl2ZSB2aXJ0cXVldWUgKi8KPiBAQCAtMjc5LDYgKzI4Miw3IEBAIHN0
cnVjdCBwYWRkZWRfdm5ldF9oZHIgewo+ICAgfTsKPiAgIAo+ICAgc3RhdGljIHZvaWQgdmlydG5l
dF9ycV9mcmVlX3VudXNlZF9idWYoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQgKmJ1Zik7Cj4g
K3N0YXRpYyB2b2lkIHZpcnRuZXRfc3FfZnJlZV91bnVzZWRfYnVmKHN0cnVjdCB2aXJ0cXVldWUg
KnZxLCB2b2lkICpidWYpOwo+ICAgCj4gICBzdGF0aWMgYm9vbCBpc194ZHBfZnJhbWUodm9pZCAq
cHRyKQo+ICAgewo+IEBAIC0xNjAzLDYgKzE2MDcsMTEgQEAgc3RhdGljIHZvaWQgdmlydG5ldF9w
b2xsX2NsZWFudHgoc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxKQo+ICAgCQlyZXR1cm47Cj4gICAK
PiAgIAlpZiAoX19uZXRpZl90eF90cnlsb2NrKHR4cSkpIHsKPiArCQlpZiAoc3EtPnJlc2V0KSB7
Cj4gKwkJCV9fbmV0aWZfdHhfdW5sb2NrKHR4cSk7Cj4gKwkJCXJldHVybjsKPiArCQl9Cj4gKwo+
ICAgCQlkbyB7Cj4gICAJCQl2aXJ0cXVldWVfZGlzYWJsZV9jYihzcS0+dnEpOwo+ICAgCQkJZnJl
ZV9vbGRfeG1pdF9za2JzKHNxLCB0cnVlKTsKPiBAQCAtMTg2OCw2ICsxODc3LDQ0IEBAIHN0YXRp
YyBpbnQgdmlydG5ldF9yeF9yZXNpemUoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gICAJcmV0
dXJuIGVycjsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgaW50IHZpcnRuZXRfdHhfcmVzaXplKHN0cnVj
dCB2aXJ0bmV0X2luZm8gKnZpLAo+ICsJCQkgICAgIHN0cnVjdCBzZW5kX3F1ZXVlICpzcSwgdTMy
IHJpbmdfbnVtKQo+ICt7Cj4gKwlzdHJ1Y3QgbmV0ZGV2X3F1ZXVlICp0eHE7Cj4gKwlpbnQgZXJy
LCBxaW5kZXg7Cj4gKwo+ICsJcWluZGV4ID0gc3EgLSB2aS0+c3E7Cj4gKwo+ICsJdmlydG5ldF9u
YXBpX3R4X2Rpc2FibGUoJnNxLT5uYXBpKTsKPiArCj4gKwl0eHEgPSBuZXRkZXZfZ2V0X3R4X3F1
ZXVlKHZpLT5kZXYsIHFpbmRleCk7Cj4gKwo+ICsJLyogMS4gd2FpdCBhbGwgeGltdCBjb21wbGV0
ZQo+ICsJICogMi4gZml4IHRoZSByYWNlIG9mIG5ldGlmX3N0b3Bfc3VicXVldWUoKSB2cyBuZXRp
Zl9zdGFydF9zdWJxdWV1ZSgpCj4gKwkgKi8KPiArCV9fbmV0aWZfdHhfbG9ja19iaCh0eHEpOwo+
ICsKPiArCS8qIFByZXZlbnQgcnggcG9sbCBmcm9tIGFjY2Vzc2luZyBzcS4gKi8KPiArCXNxLT5y
ZXNldCA9IHRydWU7Cj4gKwo+ICsJLyogUHJldmVudCB0aGUgdXBwZXIgbGF5ZXIgZnJvbSB0cnlp
bmcgdG8gc2VuZCBwYWNrZXRzLiAqLwo+ICsJbmV0aWZfc3RvcF9zdWJxdWV1ZSh2aS0+ZGV2LCBx
aW5kZXgpOwo+ICsKPiArCV9fbmV0aWZfdHhfdW5sb2NrX2JoKHR4cSk7Cj4gKwo+ICsJZXJyID0g
dmlydHF1ZXVlX3Jlc2l6ZShzcS0+dnEsIHJpbmdfbnVtLCB2aXJ0bmV0X3NxX2ZyZWVfdW51c2Vk
X2J1Zik7Cj4gKwlpZiAoZXJyKQo+ICsJCW5ldGRldl9lcnIodmktPmRldiwgInJlc2l6ZSB0eCBm
YWlsOiB0eCBxdWV1ZSBpbmRleDogJWQgZXJyOiAlZFxuIiwgcWluZGV4LCBlcnIpOwo+ICsKPiAr
CV9fbmV0aWZfdHhfbG9ja19iaCh0eHEpOwo+ICsJc3EtPnJlc2V0ID0gZmFsc2U7Cj4gKwluZXRp
Zl90eF93YWtlX3F1ZXVlKHR4cSk7Cj4gKwlfX25ldGlmX3R4X3VubG9ja19iaCh0eHEpOwo+ICsK
PiArCXZpcnRuZXRfbmFwaV90eF9lbmFibGUodmksIHNxLT52cSwgJnNxLT5uYXBpKTsKPiArCXJl
dHVybiBlcnI7Cj4gK30KPiArCj4gICAvKgo+ICAgICogU2VuZCBjb21tYW5kIHZpYSB0aGUgY29u
dHJvbCB2aXJ0cXVldWUgYW5kIGNoZWNrIHN0YXR1cy4gIENvbW1hbmRzCj4gICAgKiBzdXBwb3J0
ZWQgYnkgdGhlIGh5cGVydmlzb3IsIGFzIGluZGljYXRlZCBieSBmZWF0dXJlIGJpdHMsIHNob3Vs
ZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
