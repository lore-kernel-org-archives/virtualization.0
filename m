Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4ACFC433F5
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 07:37:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41728417A6;
	Wed,  9 Mar 2022 07:37:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l3_1Ak5T3Jvv; Wed,  9 Mar 2022 07:37:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BFFF54177E;
	Wed,  9 Mar 2022 07:37:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FA62C001D;
	Wed,  9 Mar 2022 07:37:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6343C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:37:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB39A40159
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:37:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GGwlt2fIxc0f
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:37:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7098E4002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646811441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sMEcmKvWTfkwOGTY0mg2j6/A06z9bpywHvH//xyyNqc=;
 b=RMXETMzu3U+HQVp+lxvRtNRL0NA9JjjswU8T09LWEAhIbptx75r5iE/srYNb4QhXaJ0cBB
 52g8kDZXCRus98GfokU4ceSltG6XQn+U4jc/+3+7QDrLkEqzXiUqZ9I8q0JsuezbUSYU4t
 jyPGhprcetI5XrbrWb2yUjY5hhA7mwQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-GUAggV9tNQijP7d8E3PZuA-1; Wed, 09 Mar 2022 02:37:19 -0500
X-MC-Unique: GUAggV9tNQijP7d8E3PZuA-1
Received: by mail-pl1-f198.google.com with SMTP id
 b1-20020a170902bd4100b00151f3f97b0cso748621plx.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 23:37:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=sMEcmKvWTfkwOGTY0mg2j6/A06z9bpywHvH//xyyNqc=;
 b=gojusATPyVbMb8rkzKATMqJdgeGN8tmXZ8zceYyJ07jbU9gpiU12A9jeI09qg0+lg5
 mL2kOaiLmXBTphvjbQq4ni5RTACOedDnP4U7r5m3wpsefjhb9nryk1IKnGEDrdIOI+Ga
 KclsU20CmewELhYMkIg0YQWW4NkNdtCBhzsFCcIPzW+xFJe0QkdOGINSgSAJ7+PRg/6g
 6+44O//fmTllaRxo14eQt8REpjcO3S591KpUmJqXD6p3tl8QcHTIwwnrVwjz9qiJfSV5
 WUU46vZgL2xWdvZVZn1g5lFMm+Wp03//hXQ50PSgEIVq9e6InQmG1HkVP/TO43nw69kQ
 c4yw==
X-Gm-Message-State: AOAM530nsAAYoQN5BqyfjEPU+J2GzvnP5JEtmF1D6NnIt4F+3esSf3t3
 Nlj+GnHK7KqWxzMO9kvUYNPTnJrfsNOXcMXjppku+c6xRsXWbrlUW1Bj+IqftB9T3qQe482kiWR
 HNh3GFwV+vkk//OO4JhTiL7yvMaS33JJ2lPyaQOneeg==
X-Received: by 2002:a05:6a00:140f:b0:4e0:6995:9c48 with SMTP id
 l15-20020a056a00140f00b004e069959c48mr22031562pfu.59.1646811438365; 
 Tue, 08 Mar 2022 23:37:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzeSQCV1x95spvXZKCf44swYuLOm7pVeGy+nzLvzOes3JlsRDFZ7LGk7k7ZLhK2Jc/KIlUJGw==
X-Received: by 2002:a05:6a00:140f:b0:4e0:6995:9c48 with SMTP id
 l15-20020a056a00140f00b004e069959c48mr22031523pfu.59.1646811437956; 
 Tue, 08 Mar 2022 23:37:17 -0800 (PST)
Received: from [10.72.12.183] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 s30-20020a056a001c5e00b004f73f27aa40sm1631425pfw.161.2022.03.08.23.37.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Mar 2022 23:37:17 -0800 (PST)
Message-ID: <85dde6ed-cdf1-61e4-6f05-d3e2477b9e35@redhat.com>
Date: Wed, 9 Mar 2022 15:36:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 05/26] virtio_ring: split: extract the logic of init vq
 and attach vring
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-6-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjM0LCBYdWFuIFpodW8g5YaZ6YGTOgo+IFNwbGl0IHRoZSBs
b2dpYyBvZiBzcGxpdCBhc3NpZ25tZW50IHZxIGludG8gdGhyZWUgcGFydHMuCj4KPiAxLiBUaGUg
YXNzaWdubWVudCBwYXNzZWQgZnJvbSB0aGUgZnVuY3Rpb24gcGFyYW1ldGVyCj4gMi4gVGhlIHBh
cnQgdGhhdCBhdHRhY2hlcyB2cmluZyB0byB2cS4gLS0gX192cmluZ192aXJ0cXVldWVfYXR0YWNo
X3NwbGl0KCkKPiAzLiBUaGUgcGFydCB0aGF0IGluaXRpYWxpemVzIHZxIHRvIGEgZml4ZWQgdmFs
dWUgLS0KPiAgICAgX192cmluZ192aXJ0cXVldWVfaW5pdF9zcGxpdCgpCj4KPiBUaGlzIGZlYXR1
cmUgaXMgcmVxdWlyZWQgZm9yIHN1YnNlcXVlbnQgdmlydHVxdWV1ZSByZXNldCB2cmluZwo+Cj4g
U2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAt
LS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAxMTEgKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2NyBpbnNlcnRpb25zKCsp
LCA0NCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IGQzMjc5MzYxNTQ1
MS4uZGM2MzEzYjc5MzA1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5n
LmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTIxOTYsMzQgKzIx
OTYsNDAgQEAgaXJxcmV0dXJuX3QgdnJpbmdfaW50ZXJydXB0KGludCBpcnEsIHZvaWQgKl92cSkK
PiAgIH0KPiAgIEVYUE9SVF9TWU1CT0xfR1BMKHZyaW5nX2ludGVycnVwdCk7Cj4gICAKPiAtLyog
T25seSBhdmFpbGFibGUgZm9yIHNwbGl0IHJpbmcgKi8KPiAtc3RydWN0IHZpcnRxdWV1ZSAqX192
cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiAtCQkJCQlzdHJ1Y3QgdnJp
bmcgdnJpbmcsCj4gLQkJCQkJc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gLQkJCQkJYm9v
bCB3ZWFrX2JhcnJpZXJzLAo+IC0JCQkJCWJvb2wgY29udGV4dCwKPiAtCQkJCQlib29sICgqbm90
aWZ5KShzdHJ1Y3QgdmlydHF1ZXVlICopLAo+IC0JCQkJCXZvaWQgKCpjYWxsYmFjaykoc3RydWN0
IHZpcnRxdWV1ZSAqKSwKPiAtCQkJCQljb25zdCBjaGFyICpuYW1lKQo+ICtzdGF0aWMgaW50IF9f
dnJpbmdfdmlydHF1ZXVlX2F0dGFjaF9zcGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwK
PiArCQkJCQkgIHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LAo+ICsJCQkJCSAgc3RydWN0IHZy
aW5nIHZyaW5nKQo+ICAgewo+IC0Jc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnE7Cj4gKwl2cS0+
dnEubnVtX2ZyZWUgPSB2cmluZy5udW07Cj4gICAKPiAtCWlmICh2aXJ0aW9faGFzX2ZlYXR1cmUo
dmRldiwgVklSVElPX0ZfUklOR19QQUNLRUQpKQo+IC0JCXJldHVybiBOVUxMOwo+ICsJdnEtPnNw
bGl0LnZyaW5nID0gdnJpbmc7Cj4gKwl2cS0+c3BsaXQucXVldWVfZG1hX2FkZHIgPSAwOwo+ICsJ
dnEtPnNwbGl0LnF1ZXVlX3NpemVfaW5fYnl0ZXMgPSAwOwo+ICAgCj4gLQl2cSA9IGttYWxsb2Mo
c2l6ZW9mKCp2cSksIEdGUF9LRVJORUwpOwo+IC0JaWYgKCF2cSkKPiAtCQlyZXR1cm4gTlVMTDsK
PiArCXZxLT5zcGxpdC5kZXNjX3N0YXRlID0ga21hbGxvY19hcnJheSh2cmluZy5udW0sCj4gKwkJ
CQkJICAgICBzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfc3BsaXQpLCBHRlBfS0VSTkVM
KTsKPiArCWlmICghdnEtPnNwbGl0LmRlc2Nfc3RhdGUpCj4gKwkJZ290byBlcnJfc3RhdGU7Cj4g
ICAKPiArCXZxLT5zcGxpdC5kZXNjX2V4dHJhID0gdnJpbmdfYWxsb2NfZGVzY19leHRyYSh2cSwg
dnJpbmcubnVtKTsKPiArCWlmICghdnEtPnNwbGl0LmRlc2NfZXh0cmEpCj4gKwkJZ290byBlcnJf
ZXh0cmE7CgoKU28gdGhpcyBjb250YWlucyBzdHVmZnMgbW9yZSB0aGFuIGp1c3QgYXR0YWNoLiBJ
IHdvbmRlciBpZiBpdCdzIGJldHRlciAKdG8gc3BsaXQgdGhlIGFsbG9jYXRpb24gb3V0IHRvIGFu
IGRlZGljYXRlZCBoZWxwZXIgKHdlIGhhdmUgZGVkaWNhdGVkIApoZWxwZXIgdG8gYWxsb2NhdGUg
dnJpbmcpLgoKVGhhbmtzCgoKPiArCj4gKwltZW1zZXQodnEtPnNwbGl0LmRlc2Nfc3RhdGUsIDAs
IHZyaW5nLm51bSAqCj4gKwkgICAgICAgc2l6ZW9mKHN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3Nw
bGl0KSk7Cj4gKwlyZXR1cm4gMDsKPiArCj4gK2Vycl9leHRyYToKPiArCWtmcmVlKHZxLT5zcGxp
dC5kZXNjX3N0YXRlKTsKPiArZXJyX3N0YXRlOgo+ICsJcmV0dXJuIC1FTk9NRU07Cj4gK30KPiAr
Cj4gK3N0YXRpYyB2b2lkIF9fdnJpbmdfdmlydHF1ZXVlX2luaXRfc3BsaXQoc3RydWN0IHZyaW5n
X3ZpcnRxdWV1ZSAqdnEsCj4gKwkJCQkJIHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ICt7
Cj4gICAJdnEtPnBhY2tlZF9yaW5nID0gZmFsc2U7Cj4gLQl2cS0+dnEuY2FsbGJhY2sgPSBjYWxs
YmFjazsKPiAtCXZxLT52cS52ZGV2ID0gdmRldjsKPiAtCXZxLT52cS5uYW1lID0gbmFtZTsKPiAt
CXZxLT52cS5udW1fZnJlZSA9IHZyaW5nLm51bTsKPiAtCXZxLT52cS5pbmRleCA9IGluZGV4Owo+
ICAgCXZxLT53ZV9vd25fcmluZyA9IGZhbHNlOwo+IC0JdnEtPm5vdGlmeSA9IG5vdGlmeTsKPiAt
CXZxLT53ZWFrX2JhcnJpZXJzID0gd2Vha19iYXJyaWVyczsKPiAgIAl2cS0+YnJva2VuID0gZmFs
c2U7Cj4gICAJdnEtPmxhc3RfdXNlZF9pZHggPSAwOwo+ICAgCXZxLT5ldmVudF90cmlnZ2VyZWQg
PSBmYWxzZTsKPiBAQCAtMjIzNCw1MCArMjI0MCw2NyBAQCBzdHJ1Y3QgdmlydHF1ZXVlICpfX3Zy
aW5nX25ld192aXJ0cXVldWUodW5zaWduZWQgaW50IGluZGV4LAo+ICAgCXZxLT5sYXN0X2FkZF90
aW1lX3ZhbGlkID0gZmFsc2U7Cj4gICAjZW5kaWYKPiAgIAo+IC0JdnEtPmluZGlyZWN0ID0gdmly
dGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19SSU5HX0ZfSU5ESVJFQ1RfREVTQykgJiYKPiAt
CQkhY29udGV4dDsKPiAgIAl2cS0+ZXZlbnQgPSB2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklS
VElPX1JJTkdfRl9FVkVOVF9JRFgpOwo+ICAgCj4gICAJaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2
ZGV2LCBWSVJUSU9fRl9PUkRFUl9QTEFURk9STSkpCj4gICAJCXZxLT53ZWFrX2JhcnJpZXJzID0g
ZmFsc2U7Cj4gICAKPiAtCXZxLT5zcGxpdC5xdWV1ZV9kbWFfYWRkciA9IDA7Cj4gLQl2cS0+c3Bs
aXQucXVldWVfc2l6ZV9pbl9ieXRlcyA9IDA7Cj4gLQo+IC0JdnEtPnNwbGl0LnZyaW5nID0gdnJp
bmc7Cj4gICAJdnEtPnNwbGl0LmF2YWlsX2ZsYWdzX3NoYWRvdyA9IDA7Cj4gICAJdnEtPnNwbGl0
LmF2YWlsX2lkeF9zaGFkb3cgPSAwOwo+ICAgCj4gICAJLyogTm8gY2FsbGJhY2s/ICBUZWxsIG90
aGVyIHNpZGUgbm90IHRvIGJvdGhlciB1cy4gKi8KPiAtCWlmICghY2FsbGJhY2spIHsKPiArCWlm
ICghdnEtPnZxLmNhbGxiYWNrKSB7Cj4gICAJCXZxLT5zcGxpdC5hdmFpbF9mbGFnc19zaGFkb3cg
fD0gVlJJTkdfQVZBSUxfRl9OT19JTlRFUlJVUFQ7Cj4gICAJCWlmICghdnEtPmV2ZW50KQo+ICAg
CQkJdnEtPnNwbGl0LnZyaW5nLmF2YWlsLT5mbGFncyA9IGNwdV90b192aXJ0aW8xNih2ZGV2LAo+
ICAgCQkJCQl2cS0+c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93KTsKPiAgIAl9Cj4gICAKPiAtCXZx
LT5zcGxpdC5kZXNjX3N0YXRlID0ga21hbGxvY19hcnJheSh2cmluZy5udW0sCj4gLQkJCXNpemVv
ZihzdHJ1Y3QgdnJpbmdfZGVzY19zdGF0ZV9zcGxpdCksIEdGUF9LRVJORUwpOwo+IC0JaWYgKCF2
cS0+c3BsaXQuZGVzY19zdGF0ZSkKPiAtCQlnb3RvIGVycl9zdGF0ZTsKPiAtCj4gLQl2cS0+c3Bs
aXQuZGVzY19leHRyYSA9IHZyaW5nX2FsbG9jX2Rlc2NfZXh0cmEodnEsIHZyaW5nLm51bSk7Cj4g
LQlpZiAoIXZxLT5zcGxpdC5kZXNjX2V4dHJhKQo+IC0JCWdvdG8gZXJyX2V4dHJhOwo+IC0KPiAg
IAkvKiBQdXQgZXZlcnl0aGluZyBpbiBmcmVlIGxpc3RzLiAqLwo+ICAgCXZxLT5mcmVlX2hlYWQg
PSAwOwo+IC0JbWVtc2V0KHZxLT5zcGxpdC5kZXNjX3N0YXRlLCAwLCB2cmluZy5udW0gKgo+IC0J
CQlzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfc3BsaXQpKTsKPiArfQo+ICsKPiArLyog
T25seSBhdmFpbGFibGUgZm9yIHNwbGl0IHJpbmcgKi8KPiArc3RydWN0IHZpcnRxdWV1ZSAqX192
cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiArCQkJCQlzdHJ1Y3QgdnJp
bmcgdnJpbmcsCj4gKwkJCQkJc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gKwkJCQkJYm9v
bCB3ZWFrX2JhcnJpZXJzLAo+ICsJCQkJCWJvb2wgY29udGV4dCwKPiArCQkJCQlib29sICgqbm90
aWZ5KShzdHJ1Y3QgdmlydHF1ZXVlICopLAo+ICsJCQkJCXZvaWQgKCpjYWxsYmFjaykoc3RydWN0
IHZpcnRxdWV1ZSAqKSwKPiArCQkJCQljb25zdCBjaGFyICpuYW1lKQo+ICt7Cj4gKwlzdHJ1Y3Qg
dnJpbmdfdmlydHF1ZXVlICp2cTsKPiArCWludCBlcnI7Cj4gKwo+ICsJaWYgKHZpcnRpb19oYXNf
ZmVhdHVyZSh2ZGV2LCBWSVJUSU9fRl9SSU5HX1BBQ0tFRCkpCj4gKwkJcmV0dXJuIE5VTEw7Cj4g
Kwo+ICsJdnEgPSBrbWFsbG9jKHNpemVvZigqdnEpLCBHRlBfS0VSTkVMKTsKPiArCWlmICghdnEp
Cj4gKwkJcmV0dXJuIE5VTEw7Cj4gKwo+ICsJdnEtPnZxLmNhbGxiYWNrID0gY2FsbGJhY2s7Cj4g
Kwl2cS0+dnEudmRldiA9IHZkZXY7Cj4gKwl2cS0+dnEubmFtZSA9IG5hbWU7Cj4gKwl2cS0+dnEu
aW5kZXggPSBpbmRleDsKPiArCXZxLT5ub3RpZnkgPSBub3RpZnk7Cj4gKwl2cS0+d2Vha19iYXJy
aWVycyA9IHdlYWtfYmFycmllcnM7Cj4gKwl2cS0+aW5kaXJlY3QgPSB2aXJ0aW9faGFzX2ZlYXR1
cmUodmRldiwgVklSVElPX1JJTkdfRl9JTkRJUkVDVF9ERVNDKSAmJgo+ICsJCSFjb250ZXh0Owo+
ICsKPiArCWVyciA9IF9fdnJpbmdfdmlydHF1ZXVlX2F0dGFjaF9zcGxpdCh2cSwgdmRldiwgdnJp
bmcpOwo+ICsJaWYgKGVycikKPiArCQlnb3RvIGVycjsKPiArCj4gKwlfX3ZyaW5nX3ZpcnRxdWV1
ZV9pbml0X3NwbGl0KHZxLCB2ZGV2KTsKPiAgIAo+ICAgCXNwaW5fbG9jaygmdmRldi0+dnFzX2xp
c3RfbG9jayk7Cj4gICAJbGlzdF9hZGRfdGFpbCgmdnEtPnZxLmxpc3QsICZ2ZGV2LT52cXMpOwo+
ICAgCXNwaW5fdW5sb2NrKCZ2ZGV2LT52cXNfbGlzdF9sb2NrKTsKPiAtCXJldHVybiAmdnEtPnZx
Owo+ICAgCj4gLWVycl9leHRyYToKPiAtCWtmcmVlKHZxLT5zcGxpdC5kZXNjX3N0YXRlKTsKPiAt
ZXJyX3N0YXRlOgo+ICsJcmV0dXJuICZ2cS0+dnE7Cj4gK2VycjoKPiAgIAlrZnJlZSh2cSk7Cj4g
ICAJcmV0dXJuIE5VTEw7Cj4gICB9CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
