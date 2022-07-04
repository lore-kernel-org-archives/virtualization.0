Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D384C433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 03:46:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 716B34013D;
	Mon,  4 Jul 2022 03:46:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 716B34013D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QpIFeTRD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fixyfYffdpQA; Mon,  4 Jul 2022 03:46:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 84CFF40114;
	Mon,  4 Jul 2022 03:46:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 84CFF40114
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FFFDC0032;
	Mon,  4 Jul 2022 03:46:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8335C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 03:46:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C227D409A1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 03:46:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C227D409A1
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QpIFeTRD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VOaEti7sq1ms
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 03:46:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9992D4099C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9992D4099C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 03:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656906368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k1fqdfPA46kNXwMkn+hgf7CVCtyPIFPh7p9ueCijmgk=;
 b=QpIFeTRDbwD2e2OIQaO1J7XiDtNxpQ4gR1KsMZEHXJ7DvWkQKbEwMLX4uOJPoUUmzQBQYE
 H8vTNanROKKAUR4cM/Hz8YCnJSmqKS8k9a5Vk+BFTnkiUnWr2keXhqPddCfB11ZpafIfWh
 pifM19KsXCR0Jf7icri1Qv9o3RKZ7os=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-CgZajexwMTybbLCr9aNZoA-1; Sun, 03 Jul 2022 23:46:07 -0400
X-MC-Unique: CgZajexwMTybbLCr9aNZoA-1
Received: by mail-pl1-f200.google.com with SMTP id
 m5-20020a170902768500b0016a1c410f6cso4446366pll.13
 for <virtualization@lists.linux-foundation.org>;
 Sun, 03 Jul 2022 20:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=k1fqdfPA46kNXwMkn+hgf7CVCtyPIFPh7p9ueCijmgk=;
 b=j4NEpK1ZUfq2p3I7nziQ4NYrTjdKppJVP1/VQYw4doGIj8q7UV3y6k0hiWsAidvNzi
 X92Ri10HY/Oefblavn3X2YRhStjbto2KPE8Uc3GxMp6EZdtNNDM4G9x5rhRJbXXLbm2P
 XjFA6SvsCIbO19sWy8TYU0Vu7Ooc8OHcsld33V18ajxi5+tSBTrJX1JSuk6k8Dk1RDql
 zXYOlmXm5cpTyBMd/7ycz7z93wPlChUevYzMb+bRCbM/eelODQ1vUm5bPYvEuZUefrZ3
 tIkCjjs0rG6l/715WHJiK5UoB1ba6O7+Zq7munoDiy6PeWRQnRhykKBT3q3sA9+ExXrh
 qsZg==
X-Gm-Message-State: AJIora89U0nUIS6UX8ekGvchAfJDKntfH4nj4p+5F5O6OU4f6MSJFFp5
 qXuf/1rn5ctYdNDqOGVstqoFabrqrTfFtJ7/65zmPIY8uf9IOvjdiX7G1o7q/oCvWqBVfWEnipE
 /Nf3aD3YOvTUtRXiBn12744LLjzL59cVV2vcqBmJUPQ==
X-Received: by 2002:a63:2c90:0:b0:40c:fe76:59ef with SMTP id
 s138-20020a632c90000000b0040cfe7659efmr22961176pgs.288.1656906366269; 
 Sun, 03 Jul 2022 20:46:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tMM6o7yalxZeXP62Xa+gMhpFFiuGy1AJFimSP7XmVuOI3Uo0EjGkGdnl1vLBLRphpJaPg+Zw==
X-Received: by 2002:a63:2c90:0:b0:40c:fe76:59ef with SMTP id
 s138-20020a632c90000000b0040cfe7659efmr22961130pgs.288.1656906366010; 
 Sun, 03 Jul 2022 20:46:06 -0700 (PDT)
Received: from [10.72.13.251] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 s6-20020a170902ea0600b0016bdb5a3e37sm2067372plg.250.2022.07.03.20.45.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Jul 2022 20:46:05 -0700 (PDT)
Message-ID: <102d3b83-1ae9-a59a-16ce-251c22b7afb0@redhat.com>
Date: Mon, 4 Jul 2022 11:45:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 39/40] virtio_net: support tx queue resize
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-40-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-40-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gVGhpcyBwYXRjaCBpbXBs
ZW1lbnRzIHRoZSByZXNpemUgZnVuY3Rpb24gb2YgdGhlIHR4IHF1ZXVlcy4KPiBCYXNlZCBvbiB0
aGlzIGZ1bmN0aW9uLCBpdCBpcyBwb3NzaWJsZSB0byBtb2RpZnkgdGhlIHJpbmcgbnVtIG9mIHRo
ZQo+IHF1ZXVlLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5h
bGliYWJhLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDQ4ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCA0
OCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
IGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gaW5kZXggNmFiMTZmZDE5M2U1Li5mZDM1ODQ2
MmY4MDIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jCj4gQEAgLTEzNSw2ICsxMzUsOSBAQCBzdHJ1Y3Qgc2VuZF9x
dWV1ZSB7Cj4gICAJc3RydWN0IHZpcnRuZXRfc3Ffc3RhdHMgc3RhdHM7Cj4gICAKPiAgIAlzdHJ1
Y3QgbmFwaV9zdHJ1Y3QgbmFwaTsKPiArCj4gKwkvKiBSZWNvcmQgd2hldGhlciBzcSBpcyBpbiBy
ZXNldCBzdGF0ZS4gKi8KPiArCWJvb2wgcmVzZXQ7Cj4gICB9Owo+ICAgCj4gICAvKiBJbnRlcm5h
bCByZXByZXNlbnRhdGlvbiBvZiBhIHJlY2VpdmUgdmlydHF1ZXVlICovCj4gQEAgLTI3OSw2ICsy
ODIsNyBAQCBzdHJ1Y3QgcGFkZGVkX3ZuZXRfaGRyIHsKPiAgIH07Cj4gICAKPiAgIHN0YXRpYyB2
b2lkIHZpcnRuZXRfcnFfZnJlZV91bnVzZWRfYnVmKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCB2b2lk
ICpidWYpOwo+ICtzdGF0aWMgdm9pZCB2aXJ0bmV0X3NxX2ZyZWVfdW51c2VkX2J1ZihzdHJ1Y3Qg
dmlydHF1ZXVlICp2cSwgdm9pZCAqYnVmKTsKPiAgIAo+ICAgc3RhdGljIGJvb2wgaXNfeGRwX2Zy
YW1lKHZvaWQgKnB0cikKPiAgIHsKPiBAQCAtMTYwMyw2ICsxNjA3LDExIEBAIHN0YXRpYyB2b2lk
IHZpcnRuZXRfcG9sbF9jbGVhbnR4KHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSkKPiAgIAkJcmV0
dXJuOwo+ICAgCj4gICAJaWYgKF9fbmV0aWZfdHhfdHJ5bG9jayh0eHEpKSB7Cj4gKwkJaWYgKFJF
QURfT05DRShzcS0+cmVzZXQpKSB7Cj4gKwkJCV9fbmV0aWZfdHhfdW5sb2NrKHR4cSk7Cj4gKwkJ
CXJldHVybjsKPiArCQl9Cj4gKwo+ICAgCQlkbyB7Cj4gICAJCQl2aXJ0cXVldWVfZGlzYWJsZV9j
YihzcS0+dnEpOwo+ICAgCQkJZnJlZV9vbGRfeG1pdF9za2JzKHNxLCB0cnVlKTsKPiBAQCAtMTg2
OCw2ICsxODc3LDQ1IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9yeF9yZXNpemUoc3RydWN0IHZpcnRu
ZXRfaW5mbyAqdmksCj4gICAJcmV0dXJuIGVycjsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgaW50IHZp
cnRuZXRfdHhfcmVzaXplKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ICsJCQkgICAgIHN0cnVj
dCBzZW5kX3F1ZXVlICpzcSwgdTMyIHJpbmdfbnVtKQo+ICt7Cj4gKwlzdHJ1Y3QgbmV0ZGV2X3F1
ZXVlICp0eHE7Cj4gKwlpbnQgZXJyLCBxaW5kZXg7Cj4gKwo+ICsJcWluZGV4ID0gc3EgLSB2aS0+
c3E7Cj4gKwo+ICsJdmlydG5ldF9uYXBpX3R4X2Rpc2FibGUoJnNxLT5uYXBpKTsKPiArCj4gKwl0
eHEgPSBuZXRkZXZfZ2V0X3R4X3F1ZXVlKHZpLT5kZXYsIHFpbmRleCk7Cj4gKwo+ICsJLyogMS4g
d2FpdCBhbGwgeGltdCBjb21wbGV0ZQo+ICsJICogMi4gZml4IHRoZSByYWNlIG9mIG5ldGlmX3N0
b3Bfc3VicXVldWUoKSB2cyBuZXRpZl9zdGFydF9zdWJxdWV1ZSgpCj4gKwkgKi8KPiArCV9fbmV0
aWZfdHhfbG9ja19iaCh0eHEpOwo+ICsKPiArCS8qIFByZXZlbnQgcnggcG9sbCBmcm9tIGFjY2Vz
c2luZyBzcS4gKi8KPiArCVdSSVRFX09OQ0Uoc3EtPnJlc2V0LCB0cnVlKTsKCgpDYW4gd2Ugc2lt
cGx5IGRpc2FibGUgUlggTkFQSSBoZXJlPwoKVGhhbmtzCgoKPiArCj4gKwkvKiBQcmV2ZW50IHRo
ZSB1cHBlciBsYXllciBmcm9tIHRyeWluZyB0byBzZW5kIHBhY2tldHMuICovCj4gKwluZXRpZl9z
dG9wX3N1YnF1ZXVlKHZpLT5kZXYsIHFpbmRleCk7Cj4gKwo+ICsJX19uZXRpZl90eF91bmxvY2tf
YmgodHhxKTsKPiArCj4gKwllcnIgPSB2aXJ0cXVldWVfcmVzaXplKHNxLT52cSwgcmluZ19udW0s
IHZpcnRuZXRfc3FfZnJlZV91bnVzZWRfYnVmKTsKPiArCWlmIChlcnIpCj4gKwkJbmV0ZGV2X2Vy
cih2aS0+ZGV2LCAicmVzaXplIHR4IGZhaWw6IHR4IHF1ZXVlIGluZGV4OiAlZCBlcnI6ICVkXG4i
LCBxaW5kZXgsIGVycik7Cj4gKwo+ICsJLyogTWVtb3J5IGJhcnJpZXIgYmVmb3JlIHNldCByZXNl
dCBhbmQgc3RhcnQgc3VicXVldWUuICovCj4gKwlzbXBfbWIoKTsKPiArCj4gKwlXUklURV9PTkNF
KHNxLT5yZXNldCwgZmFsc2UpOwo+ICsJbmV0aWZfdHhfd2FrZV9xdWV1ZSh0eHEpOwo+ICsKPiAr
CXZpcnRuZXRfbmFwaV90eF9lbmFibGUodmksIHNxLT52cSwgJnNxLT5uYXBpKTsKPiArCXJldHVy
biBlcnI7Cj4gK30KPiArCj4gICAvKgo+ICAgICogU2VuZCBjb21tYW5kIHZpYSB0aGUgY29udHJv
bCB2aXJ0cXVldWUgYW5kIGNoZWNrIHN0YXR1cy4gIENvbW1hbmRzCj4gICAgKiBzdXBwb3J0ZWQg
YnkgdGhlIGh5cGVydmlzb3IsIGFzIGluZGljYXRlZCBieSBmZWF0dXJlIGJpdHMsIHNob3VsZAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
