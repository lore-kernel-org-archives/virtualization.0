Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE84C433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 02:53:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DA384071E;
	Tue, 12 Apr 2022 02:53:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gUneYFV1POdw; Tue, 12 Apr 2022 02:53:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 833B140611;
	Tue, 12 Apr 2022 02:53:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 352D8C0082;
	Tue, 12 Apr 2022 02:53:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54A5FC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:53:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2BA96607CE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:53:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MPjz6_iTGoBa
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:53:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 69E436059F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649732019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I6Gk+PoKhwefvMstrrWueNlGg+EH3BPUAhekn6Cxf1E=;
 b=MqbtELB8txoGce7zNydutrAgVuoIcgASPLdgQeyAMIh6FINqlxJZ9HcXPNQBUZVmMcBZKT
 wh9XVdDbhuJu9Grd9CQ3W/wfwB+m5n0hO856iySDvjRNQJaRnS+vI3xA5waROBXG9p7k8w
 4iTTIzL6gH8xZw9mFK5P8p8N99vlCHY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-ivr8ZahwNrO-6TT-NiDu_g-1; Mon, 11 Apr 2022 22:53:37 -0400
X-MC-Unique: ivr8ZahwNrO-6TT-NiDu_g-1
Received: by mail-pf1-f198.google.com with SMTP id
 p189-20020a62d0c6000000b005059cf0cb42so4869636pfg.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 19:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=I6Gk+PoKhwefvMstrrWueNlGg+EH3BPUAhekn6Cxf1E=;
 b=M94ayQG89pV2vOl2TtHT4tPsfh2MhoXqQ4rANaNCVvgjLoxzhcOvheYSz4wPmOQtu4
 em3uPW8eEUnrgycxSa24l9yfP4ceCDEE9O6JTUtf1HzCG47cWrTo5Ix3I2gPT/OXxBQI
 ApmBvdJpnC8mg9kPGkTtzXpeKLXir8XkE7q8mOVvZDFkBq7COJYFLx0vHbRC8CFio/r7
 +s9eq0KhWpsFPnAfhweB+sGMONTqX8xYyrKzJ71KldK3mJ9C36KhJBLDB6QvqtjBmABw
 6uPQmvAILkcEAhO4Nr5rV4ACuPzWS49n62+Gf4CvMlgS5wg/y+Qz0dNwDTv55j0ey0eL
 PHoA==
X-Gm-Message-State: AOAM5324zzLt9AGyJk/mIgBG318i3XU0HKSWjlqTOtZfioWFRmOsNN4e
 588NxfzSBIHPFr6u8pTxAHchQ53do6ym566JlDCtmxdlHaRm6asjEs6bPghhekToRGWqsmJYQ/6
 mxmyngJwOk+2Ljd1gOqNHw6hVYRkhJWnqOzcGvV9ZNw==
X-Received: by 2002:a63:6286:0:b0:39d:94b2:fbc0 with SMTP id
 w128-20020a636286000000b0039d94b2fbc0mr996908pgb.439.1649732016631; 
 Mon, 11 Apr 2022 19:53:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzj9451Dz8Id3VkVV78O8W6jxJ5RgF2YxbCU8kZmbBeEtMyuWRJome1nhMw4/Xpk0k7lbQNPw==
X-Received: by 2002:a63:6286:0:b0:39d:94b2:fbc0 with SMTP id
 w128-20020a636286000000b0039d94b2fbc0mr996881pgb.439.1649732016356; 
 Mon, 11 Apr 2022 19:53:36 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 np8-20020a17090b4c4800b001c70aeab380sm812652pjb.41.2022.04.11.19.53.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Apr 2022 19:53:35 -0700 (PDT)
Message-ID: <e9f76bff-c842-3dae-644e-0b7005d3f1fd@redhat.com>
Date: Tue, 12 Apr 2022 10:53:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 04/32] virtio_ring: remove the arg vq of
 vring_alloc_desc_extra()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-5-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBUaGUgcGFyYW1l
dGVyIHZxIG9mIHZyaW5nX2FsbG9jX2Rlc2NfZXh0cmEoKSBpcyB1c2VsZXNzLiBUaGlzIHBhdGNo
Cj4gcmVtb3ZlcyB0aGlzIHBhcmFtZXRlci4KPgo+IFN1YnNlcXVlbnQgcGF0Y2hlcyB3aWxsIGNh
bGwgdGhpcyBmdW5jdGlvbiB0byBhdm9pZCBwYXNzaW5nIHVzZWxlc3MKPiBhcmd1bWVudHMuCj4K
PiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgoK
CkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gICBk
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgNyArKystLS0tCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4g
aW5kZXggZjE4MDdmNmIwNmE1Li5jYjYwMTA3NTBhOTQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMK
PiBAQCAtMTYzNiw4ICsxNjM2LDcgQEAgc3RhdGljIHZvaWQgKnZpcnRxdWV1ZV9kZXRhY2hfdW51
c2VkX2J1Zl9wYWNrZWQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+ICAgCXJldHVybiBOVUxMOwo+
ICAgfQo+ICAgCj4gLXN0YXRpYyBzdHJ1Y3QgdnJpbmdfZGVzY19leHRyYSAqdnJpbmdfYWxsb2Nf
ZGVzY19leHRyYShzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiAtCQkJCQkJICAgICAgIHVu
c2lnbmVkIGludCBudW0pCj4gK3N0YXRpYyBzdHJ1Y3QgdnJpbmdfZGVzY19leHRyYSAqdnJpbmdf
YWxsb2NfZGVzY19leHRyYSh1bnNpZ25lZCBpbnQgbnVtKQo+ICAgewo+ICAgCXN0cnVjdCB2cmlu
Z19kZXNjX2V4dHJhICpkZXNjX2V4dHJhOwo+ICAgCXVuc2lnbmVkIGludCBpOwo+IEBAIC0xNzU1
LDcgKzE3NTQsNyBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRx
dWV1ZV9wYWNrZWQoCj4gICAJLyogUHV0IGV2ZXJ5dGhpbmcgaW4gZnJlZSBsaXN0cy4gKi8KPiAg
IAl2cS0+ZnJlZV9oZWFkID0gMDsKPiAgIAo+IC0JdnEtPnBhY2tlZC5kZXNjX2V4dHJhID0gdnJp
bmdfYWxsb2NfZGVzY19leHRyYSh2cSwgbnVtKTsKPiArCXZxLT5wYWNrZWQuZGVzY19leHRyYSA9
IHZyaW5nX2FsbG9jX2Rlc2NfZXh0cmEobnVtKTsKPiAgIAlpZiAoIXZxLT5wYWNrZWQuZGVzY19l
eHRyYSkKPiAgIAkJZ290byBlcnJfZGVzY19leHRyYTsKPiAgIAo+IEBAIC0yMjMzLDcgKzIyMzIs
NyBAQCBzdHJ1Y3QgdmlydHF1ZXVlICpfX3ZyaW5nX25ld192aXJ0cXVldWUodW5zaWduZWQgaW50
IGluZGV4LAo+ICAgCWlmICghdnEtPnNwbGl0LmRlc2Nfc3RhdGUpCj4gICAJCWdvdG8gZXJyX3N0
YXRlOwo+ICAgCj4gLQl2cS0+c3BsaXQuZGVzY19leHRyYSA9IHZyaW5nX2FsbG9jX2Rlc2NfZXh0
cmEodnEsIHZyaW5nLm51bSk7Cj4gKwl2cS0+c3BsaXQuZGVzY19leHRyYSA9IHZyaW5nX2FsbG9j
X2Rlc2NfZXh0cmEodnJpbmcubnVtKTsKPiAgIAlpZiAoIXZxLT5zcGxpdC5kZXNjX2V4dHJhKQo+
ICAgCQlnb3RvIGVycl9leHRyYTsKPiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
