Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED22C43219
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 02:41:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 199FB83478;
	Tue, 12 Apr 2022 02:41:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TxfT81V0XxmI; Tue, 12 Apr 2022 02:41:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 672828343B;
	Tue, 12 Apr 2022 02:41:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 394EDC0082;
	Tue, 12 Apr 2022 02:41:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFBE9C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:41:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CC28F41577
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:41:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HZxqHZNm_kFz
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:41:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9256741560
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649731281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n9AHGuoWN5DEsfFR6+n4EfGTHU/AybM73SzeXCbd8ow=;
 b=B2qNnOmckoOtSZnnUdwPDH084+eS9clSyfmUW+THbTSgBgqp4rGpqT8yKryalWH9NTndje
 G7Z47ywOQymk03EUqH1H8bNAvwmitE021uOuQI8TuBHo3flk0hy50r/AlCJzxJlfvTg5RS
 HgkLYIOvbA3EoL8pMyPltFPaZd0hOpk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-45RnjOcyOIGuZopbLkbvHA-1; Mon, 11 Apr 2022 22:41:20 -0400
X-MC-Unique: 45RnjOcyOIGuZopbLkbvHA-1
Received: by mail-pf1-f198.google.com with SMTP id
 p189-20020a62d0c6000000b005059cf0cb42so4852827pfg.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 19:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=n9AHGuoWN5DEsfFR6+n4EfGTHU/AybM73SzeXCbd8ow=;
 b=tuV0F3wzLXszJJ9B0R5ZqeljvmW9DZ3yxiJzAnc8kG4Prp8xCw35F0glTjLVQNF0AG
 x7WCrgqN8vZFoBt+m2zvAUnMnBZItDML/DfDrWPYV/TcAINLnsfUuuNJCPAPXJgPssdA
 J8HtP3iEXFLx2aMqt3ayDhzRCjW7VflmAa+UNVdRi/PVh6OXiVwMudu41QnYpyldK9qT
 WxTpEfXcPHeisvdj0tQUjHo3CEQqxNw/Y8MIi0kWqSs6JHl6jQAZk0Drr5nHTVY9tFsQ
 M4bblUF5GTFMCC1RR1TWV4PJTotgI5OIMCr04OQiHsAhWtIzL+4KQEnofKoWMbmWhORc
 j9JQ==
X-Gm-Message-State: AOAM530NlGSXGzNVdAspWXtGXkSYRMuzy21aPjq2rbSZSjgaEBCBTUcc
 pwCP6V7bPhSB/jsOuWvRqeBEGojhezbg2hcywx5Rs4Qf8sWvuFvAWIMYUB3Lo9VmSRSg/ebp/rm
 8BVgHteipw7/xgJp9do7qOga8FPcUNa9nYRRBsRNnOA==
X-Received: by 2002:a62:6c6:0:b0:505:6713:d584 with SMTP id
 189-20020a6206c6000000b005056713d584mr24781206pfg.24.1649731278349; 
 Mon, 11 Apr 2022 19:41:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyu8dJKKRcfWvkZcrPOwXnT9oC6pEqkxORnHFmtqyXX3kWAnTX/n0o1+l48eCQVygLz/+MBtA==
X-Received: by 2002:a62:6c6:0:b0:505:6713:d584 with SMTP id
 189-20020a6206c6000000b005056713d584mr24781195pfg.24.1649731278023; 
 Mon, 11 Apr 2022 19:41:18 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 oa16-20020a17090b1bd000b001c72b632222sm795721pjb.32.2022.04.11.19.41.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Apr 2022 19:41:17 -0700 (PDT)
Message-ID: <71fbd7fc-20db-024b-ec66-b875216be4bd@redhat.com>
Date: Tue, 12 Apr 2022 10:41:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 01/32] virtio: add helper virtqueue_get_vring_max_size()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-2-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBSZWNvcmQgdGhl
IG1heGltdW0gcXVldWUgbnVtIHN1cHBvcnRlZCBieSB0aGUgZGV2aWNlLgo+Cj4gdmlydGlvLW5l
dCBjYW4gZGlzcGxheSB0aGUgbWF4aW11bSAoc3VwcG9ydGVkIGJ5IGhhcmR3YXJlKSByaW5nIHNp
emUgaW4KPiBldGh0b29sIC1nIGV0aDAuCj4KPiBXaGVuIHRoZSBzdWJzZXF1ZW50IHBhdGNoIGlt
cGxlbWVudHMgdnJpbmcgcmVzZXQsIGl0IGNhbiBqdWRnZSB3aGV0aGVyCj4gdGhlIHJpbmcgc2l6
ZSBwYXNzZWQgYnkgdGhlIGRyaXZlciBpcyBsZWdhbCBiYXNlZCBvbiB0aGlzLgo+Cj4gU2lnbmVk
LW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAg
IGFyY2gvdW0vZHJpdmVycy92aXJ0aW9fdW1sLmMgICAgICAgICAgICAgfCAgMSArCj4gICBkcml2
ZXJzL3BsYXRmb3JtL21lbGxhbm94L21seGJmLXRtZmlmby5jIHwgIDIgKysKPiAgIGRyaXZlcnMv
cmVtb3RlcHJvYy9yZW1vdGVwcm9jX3ZpcnRpby5jICAgfCAgMiArKwo+ICAgZHJpdmVycy9zMzkw
L3ZpcnRpby92aXJ0aW9fY2N3LmMgICAgICAgICB8ICAzICsrKwo+ICAgZHJpdmVycy92aXJ0aW8v
dmlydGlvX21taW8uYyAgICAgICAgICAgICB8ICAyICsrCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcGNpX2xlZ2FjeS5jICAgICAgIHwgIDIgKysKPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19w
Y2lfbW9kZXJuLmMgICAgICAgfCAgMiArKwo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
YyAgICAgICAgICAgICB8IDE0ICsrKysrKysrKysrKysrCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0
aW9fdmRwYS5jICAgICAgICAgICAgIHwgIDIgKysKPiAgIGluY2x1ZGUvbGludXgvdmlydGlvLmgg
ICAgICAgICAgICAgICAgICAgfCAgMiArKwo+ICAgMTAgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0
aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2FyY2gvdW0vZHJpdmVycy92aXJ0aW9fdW1sLmMgYi9h
cmNoL3VtL2RyaXZlcnMvdmlydGlvX3VtbC5jCj4gaW5kZXggYmE1NjJkNjhkYzA0Li45MDQ5OTNk
MTVhODUgMTAwNjQ0Cj4gLS0tIGEvYXJjaC91bS9kcml2ZXJzL3ZpcnRpb191bWwuYwo+ICsrKyBi
L2FyY2gvdW0vZHJpdmVycy92aXJ0aW9fdW1sLmMKPiBAQCAtOTQ1LDYgKzk0NSw3IEBAIHN0YXRp
YyBzdHJ1Y3QgdmlydHF1ZXVlICp2dV9zZXR1cF92cShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRl
diwKPiAgIAkJZ290byBlcnJvcl9jcmVhdGU7Cj4gICAJfQo+ICAgCXZxLT5wcml2ID0gaW5mbzsK
PiArCXZxLT5udW1fbWF4ID0gbnVtOwo+ICAgCW51bSA9IHZpcnRxdWV1ZV9nZXRfdnJpbmdfc2l6
ZSh2cSk7Cj4gICAKPiAgIAlpZiAodnVfZGV2LT5wcm90b2NvbF9mZWF0dXJlcyAmCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0vbWVsbGFub3gvbWx4YmYtdG1maWZvLmMgYi9kcml2ZXJz
L3BsYXRmb3JtL21lbGxhbm94L21seGJmLXRtZmlmby5jCj4gaW5kZXggMzg4MDBlODZlZDhhLi4x
YWUzYzU2YjY2YjAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9tbHhi
Zi10bWZpZm8uYwo+ICsrKyBiL2RyaXZlcnMvcGxhdGZvcm0vbWVsbGFub3gvbWx4YmYtdG1maWZv
LmMKPiBAQCAtOTU5LDYgKzk1OSw4IEBAIHN0YXRpYyBpbnQgbWx4YmZfdG1maWZvX3ZpcnRpb19m
aW5kX3ZxcyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwKPiAgIAkJCWdvdG8gZXJyb3I7Cj4g
ICAJCX0KPiAgIAo+ICsJCXZxLT5udW1fbWF4ID0gdnJpbmctPm51bTsKPiArCj4gICAJCXZxc1tp
XSA9IHZxOwo+ICAgCQl2cmluZy0+dnEgPSB2cTsKPiAgIAkJdnEtPnByaXYgPSB2cmluZzsKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2NfdmlydGlvLmMgYi9kcml2
ZXJzL3JlbW90ZXByb2MvcmVtb3RlcHJvY192aXJ0aW8uYwo+IGluZGV4IDcwYWI0OTZkMDQzMS4u
NzYxMTc1NWQwYWUyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9j
X3ZpcnRpby5jCj4gKysrIGIvZHJpdmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2NfdmlydGlvLmMK
PiBAQCAtMTI1LDYgKzEyNSw4IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICpycF9maW5kX3Zx
KHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LAo+ICAgCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVN
KTsKPiAgIAl9Cj4gICAKPiArCXZxLT5udW1fbWF4ID0gbGVuOwoKCkkgd29uZGVyIGlmIHRoaXMg
aXMgY29ycmVjdC4KCkl0IGxvb2tzIHRvIG1lIGxlbiBpcyBjb3VudGVkIGluIGJ5dGVzOgoKLyoq
CiDCoCogc3RydWN0IHJwcm9jX3ZyaW5nIC0gcmVtb3RlcHJvYyB2cmluZyBzdGF0ZQogwqAqIEB2
YTogdmlydHVhbCBhZGRyZXNzCiDCoCogQGxlbjogbGVuZ3RoLCBpbiBieXRlcwogwqAqIEBkYTog
ZGV2aWNlIGFkZHJlc3MKIMKgKiBAYWxpZ246IHZyaW5nIGFsaWdubWVudAogwqAqIEBub3RpZnlp
ZDogcnByb2Mtc3BlY2lmaWMgdW5pcXVlIHZyaW5nIGluZGV4CiDCoCogQHJ2ZGV2OiByZW1vdGUg
dmRldgogwqAqIEB2cTogdGhlIHZpcnRxdWV1ZSBvZiB0aGlzIHZyaW5nCiDCoCovCnN0cnVjdCBy
cHJvY192cmluZyB7CiDCoMKgwqDCoMKgwqDCoCB2b2lkICp2YTsKIMKgwqDCoMKgwqDCoMKgIGlu
dCBsZW47CiDCoMKgwqDCoMKgwqDCoCB1MzIgZGE7CiDCoMKgwqDCoMKgwqDCoCB1MzIgYWxpZ247
CiDCoMKgwqDCoMKgwqDCoCBpbnQgbm90aWZ5aWQ7CiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcnBy
b2NfdmRldiAqcnZkZXY7CiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdmlydHF1ZXVlICp2cTsKfTsK
CgpPdGhlciBsb29rcyBnb29kLgoKVGhhbmtzCgoKPiArCj4gICAJcnZyaW5nLT52cSA9IHZxOwo+
ICAgCXZxLT5wcml2ID0gcnZyaW5nOwo+ICAgCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvczM5MC92
aXJ0aW8vdmlydGlvX2Njdy5jIGIvZHJpdmVycy9zMzkwL3ZpcnRpby92aXJ0aW9fY2N3LmMKPiBp
bmRleCBkMzVlN2EzZjcwNjcuLjQ2OGRhNjBiNTZjNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Mz
OTAvdmlydGlvL3ZpcnRpb19jY3cuYwo+ICsrKyBiL2RyaXZlcnMvczM5MC92aXJ0aW8vdmlydGlv
X2Njdy5jCj4gQEAgLTUyOSw2ICs1MjksOSBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdmly
dGlvX2Njd19zZXR1cF92cShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwKPiAgIAkJZXJyID0g
LUVOT01FTTsKPiAgIAkJZ290byBvdXRfZXJyOwo+ICAgCX0KPiArCj4gKwl2cS0+bnVtX21heCA9
IGluZm8tPm51bTsKPiArCj4gICAJLyogaXQgbWF5IGhhdmUgYmVlbiByZWR1Y2VkICovCj4gICAJ
aW5mby0+bnVtID0gdmlydHF1ZXVlX2dldF92cmluZ19zaXplKHZxKTsKPiAgIAo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fbW1pby5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlv
X21taW8uYwo+IGluZGV4IDU2MTI4YjljNDZlYi4uYTQxYWJjODA1MWI5IDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19tbWlvLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fbW1pby5jCj4gQEAgLTM5MCw2ICszOTAsOCBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAq
dm1fc2V0dXBfdnEoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGluZGV4LAo+
ICAgCQlnb3RvIGVycm9yX25ld192aXJ0cXVldWU7Cj4gICAJfQo+ICAgCj4gKwl2cS0+bnVtX21h
eCA9IG51bTsKPiArCj4gICAJLyogQWN0aXZhdGUgdGhlIHF1ZXVlICovCj4gICAJd3JpdGVsKHZp
cnRxdWV1ZV9nZXRfdnJpbmdfc2l6ZSh2cSksIHZtX2Rldi0+YmFzZSArIFZJUlRJT19NTUlPX1FV
RVVFX05VTSk7Cj4gICAJaWYgKHZtX2Rldi0+dmVyc2lvbiA9PSAxKSB7Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcGNpX2xlZ2FjeS5jCj4gaW5kZXggMzQxNDFiOWFiZTI3Li5iNjg5MzRmZTZiNWQgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYwo+ICsrKyBiL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMKPiBAQCAtMTM1LDYgKzEzNSw4IEBAIHN0YXRp
YyBzdHJ1Y3QgdmlydHF1ZXVlICpzZXR1cF92cShzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2UgKnZw
X2RldiwKPiAgIAlpZiAoIXZxKQo+ICAgCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKPiAgIAo+
ICsJdnEtPm51bV9tYXggPSBudW07Cj4gKwo+ICAgCXFfcGZuID0gdmlydHF1ZXVlX2dldF9kZXNj
X2FkZHIodnEpID4+IFZJUlRJT19QQ0lfUVVFVUVfQUREUl9TSElGVDsKPiAgIAlpZiAocV9wZm4g
Pj4gMzIpIHsKPiAgIAkJZGV2X2VycigmdnBfZGV2LT5wY2lfZGV2LT5kZXYsCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMgYi9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcGNpX21vZGVybi5jCj4gaW5kZXggNTQ1NWJjMDQxZmI2Li44NmQzMDFmMjcyYjggMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYwo+ICsrKyBiL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMKPiBAQCAtMjE4LDYgKzIxOCw4IEBAIHN0
YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICpzZXR1cF92cShzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2Ug
KnZwX2RldiwKPiAgIAlpZiAoIXZxKQo+ICAgCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKPiAg
IAo+ICsJdnEtPm51bV9tYXggPSBudW07Cj4gKwo+ICAgCS8qIGFjdGl2YXRlIHRoZSBxdWV1ZSAq
Lwo+ICAgCXZwX21vZGVybl9zZXRfcXVldWVfc2l6ZShtZGV2LCBpbmRleCwgdmlydHF1ZXVlX2dl
dF92cmluZ19zaXplKHZxKSk7Cj4gICAJdnBfbW9kZXJuX3F1ZXVlX2FkZHJlc3MobWRldiwgaW5k
ZXgsIHZpcnRxdWV1ZV9nZXRfZGVzY19hZGRyKHZxKSwKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRl
eCA5NjJmMTQ3N2IxZmEuLmI4NzEzMGM4ZjMxMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBA
IC0yMzcxLDYgKzIzNzEsMjAgQEAgdm9pZCB2cmluZ190cmFuc3BvcnRfZmVhdHVyZXMoc3RydWN0
IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MX0dQTCh2cmluZ190
cmFuc3BvcnRfZmVhdHVyZXMpOwo+ICAgCj4gKy8qKgo+ICsgKiB2aXJ0cXVldWVfZ2V0X3ZyaW5n
X21heF9zaXplIC0gcmV0dXJuIHRoZSBtYXggc2l6ZSBvZiB0aGUgdmlydHF1ZXVlJ3MgdnJpbmcK
PiArICogQF92cTogdGhlIHN0cnVjdCB2aXJ0cXVldWUgY29udGFpbmluZyB0aGUgdnJpbmcgb2Yg
aW50ZXJlc3QuCj4gKyAqCj4gKyAqIFJldHVybnMgdGhlIG1heCBzaXplIG9mIHRoZSB2cmluZy4K
PiArICoKPiArICogVW5saWtlIG90aGVyIG9wZXJhdGlvbnMsIHRoaXMgbmVlZCBub3QgYmUgc2Vy
aWFsaXplZC4KPiArICovCj4gK3Vuc2lnbmVkIGludCB2aXJ0cXVldWVfZ2V0X3ZyaW5nX21heF9z
aXplKHN0cnVjdCB2aXJ0cXVldWUgKl92cSkKPiArewo+ICsJcmV0dXJuIF92cS0+bnVtX21heDsK
PiArfQo+ICtFWFBPUlRfU1lNQk9MX0dQTCh2aXJ0cXVldWVfZ2V0X3ZyaW5nX21heF9zaXplKTsK
PiArCj4gICAvKioKPiAgICAqIHZpcnRxdWV1ZV9nZXRfdnJpbmdfc2l6ZSAtIHJldHVybiB0aGUg
c2l6ZSBvZiB0aGUgdmlydHF1ZXVlJ3MgdnJpbmcKPiAgICAqIEBfdnE6IHRoZSBzdHJ1Y3Qgdmly
dHF1ZXVlIGNvbnRhaW5pbmcgdGhlIHZyaW5nIG9mIGludGVyZXN0Lgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEu
Ywo+IGluZGV4IDc3NjdhN2YwMTE5Yi4uMzllNGMwOGViMGYyIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRw
YS5jCj4gQEAgLTE4Myw2ICsxODMsOCBAQCB2aXJ0aW9fdmRwYV9zZXR1cF92cShzdHJ1Y3Qgdmly
dGlvX2RldmljZSAqdmRldiwgdW5zaWduZWQgaW50IGluZGV4LAo+ICAgCQlnb3RvIGVycm9yX25l
d192aXJ0cXVldWU7Cj4gICAJfQo+ICAgCj4gKwl2cS0+bnVtX21heCA9IG1heF9udW07Cj4gKwo+
ICAgCS8qIFNldHVwIHZpcnRxdWV1ZSBjYWxsYmFjayAqLwo+ICAgCWNiLmNhbGxiYWNrID0gdmly
dGlvX3ZkcGFfdmlydHF1ZXVlX2NiOwo+ICAgCWNiLnByaXZhdGUgPSBpbmZvOwo+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+IGlu
ZGV4IDcyMjkyYTYyY2Q5MC4uZDU5YWRjNGJlMDY4IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGlu
dXgvdmlydGlvLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gQEAgLTMxLDYgKzMx
LDcgQEAgc3RydWN0IHZpcnRxdWV1ZSB7Cj4gICAJc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXY7
Cj4gICAJdW5zaWduZWQgaW50IGluZGV4Owo+ICAgCXVuc2lnbmVkIGludCBudW1fZnJlZTsKPiAr
CXVuc2lnbmVkIGludCBudW1fbWF4Owo+ICAgCXZvaWQgKnByaXY7Cj4gICB9Owo+ICAgCj4gQEAg
LTgwLDYgKzgxLDcgQEAgYm9vbCB2aXJ0cXVldWVfZW5hYmxlX2NiX2RlbGF5ZWQoc3RydWN0IHZp
cnRxdWV1ZSAqdnEpOwo+ICAgCj4gICB2b2lkICp2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWYo
c3RydWN0IHZpcnRxdWV1ZSAqdnEpOwo+ICAgCj4gK3Vuc2lnbmVkIGludCB2aXJ0cXVldWVfZ2V0
X3ZyaW5nX21heF9zaXplKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPiAgIHVuc2lnbmVkIGludCB2
aXJ0cXVldWVfZ2V0X3ZyaW5nX3NpemUoc3RydWN0IHZpcnRxdWV1ZSAqdnEpOwo+ICAgCj4gICBi
b29sIHZpcnRxdWV1ZV9pc19icm9rZW4oc3RydWN0IHZpcnRxdWV1ZSAqdnEpOwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
