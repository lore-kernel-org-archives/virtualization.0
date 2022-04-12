Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CF1C433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 06:58:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C8E1813F3;
	Tue, 12 Apr 2022 06:58:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gIhXe-AXV4fx; Tue, 12 Apr 2022 06:58:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 94BD58139C;
	Tue, 12 Apr 2022 06:58:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57230C0082;
	Tue, 12 Apr 2022 06:58:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10107C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E47D78139C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:58:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gZc1idVSaGzH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:58:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A08538133F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649746717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4c8Vusl4oEKcTcKekpVxwLN012dQSzoK0Qxc5GtiyU0=;
 b=A9gJvFY1JqzYiOwZFtp/7B//saknIIuaw/Za+8F8ePQ/5cVc0maFqs9X/hc9mah9GfOJOH
 r+5gTmiYUpba6xJn8+ioR6/eI/hSyF3VpOYdzPbcbpVQUFThzz0qGn5qQCmQY2YeapiDgg
 H4+pEXnksTcRGcZOAa7w8gCHziiznCM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-Me_2AqHEM8K8Ju-nOOScLQ-1; Tue, 12 Apr 2022 02:58:33 -0400
X-MC-Unique: Me_2AqHEM8K8Ju-nOOScLQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 u1-20020a17090a2b8100b001cba1905e25so1065909pjd.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 23:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=4c8Vusl4oEKcTcKekpVxwLN012dQSzoK0Qxc5GtiyU0=;
 b=aQ8C+sAyg5wldwvnpvTxr8d+q5APb7+5J2cnif7VhBPgFQk8b+3yAR8UnbzYdxlx2S
 qE9EXrpgXurWO8BArDzC8gOYXCbj1/RStk+gYHEJbJ8IeRgtHSZuvWc9x0fwlqO2YUey
 AKwBxmA4mxkum6KZafXGjsyJn/Dx6zoB4K5wAy+YbmWwA3msiwLfqe1xUd7OGg+Uni4U
 lqFDw6S1RDUGlKIN/Kn5d5CUWVWvs170+/tV1aafq6mbUA62byvsXQBt5HDJK1Wxd1Lf
 d4hhw8UufCaAfy3nHFe5M3tcw1DogvpAqdqxIAgZohfXi/E4z7VldggXjaHYWks/TgyF
 0kEg==
X-Gm-Message-State: AOAM533zI/BZH8DnX1G2uPGSUN9UXMEuU6ozEXhbEGSP4FzEDKkeImbm
 phfITGxCImVwloAkOpm23fz8V/z8UQPrNcetitNet1vv4lT8e3y2kInXRJ1lsPXmuu0YAXDbDio
 R4i2yWQokaBb6U/TUsqrSpbeSJW3FZ6veOINJYIy+7g==
X-Received: by 2002:a17:902:ce0a:b0:156:72e2:f191 with SMTP id
 k10-20020a170902ce0a00b0015672e2f191mr35096121plg.76.1649746712094; 
 Mon, 11 Apr 2022 23:58:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuJbdOoWZZRPEbzGsC4VuDhXJvgnJjxW0TEadVGxwoEvQb6fSAp5kYQnQ/9zpsf7VqHx4Bsg==
X-Received: by 2002:a17:902:ce0a:b0:156:72e2:f191 with SMTP id
 k10-20020a170902ce0a00b0015672e2f191mr35096092plg.76.1649746711844; 
 Mon, 11 Apr 2022 23:58:31 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 b25-20020a637159000000b00381fda49d15sm1765570pgn.39.2022.04.11.23.58.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Apr 2022 23:58:31 -0700 (PDT)
Message-ID: <d228a41f-a3a1-029d-f259-d4fbab822e78@redhat.com>
Date: Tue, 12 Apr 2022 14:58:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 22/32] virtio_pci: queue_reset: extract the logic of
 active vq for modern pci
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-23-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-23-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBJbnRyb2R1Y2Ug
dnBfYWN0aXZlX3ZxKCkgdG8gY29uZmlndXJlIHZyaW5nIHRvIGJhY2tlbmQgYWZ0ZXIgdnEgYXR0
YWNoCj4gdnJpbmcuIEFuZCBjb25maWd1cmUgdnEgdmVjdG9yIGlmIG5lY2Vzc2FyeS4KPgo+IFNp
Z25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gLS0t
Cj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5jIHwgNDYgKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwg
MTggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Bj
aV9tb2Rlcm4uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMKPiBpbmRleCA4
NmQzMDFmMjcyYjguLjQ5YTQ0OTM3MzJjZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcGNpX21vZGVybi5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rl
cm4uYwo+IEBAIC0xNzYsNiArMTc2LDI5IEBAIHN0YXRpYyB2b2lkIHZwX3Jlc2V0KHN0cnVjdCB2
aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ICAgCXZwX2Rpc2FibGVfY2JzKHZkZXYpOwo+ICAgfQo+ICAg
Cj4gK3N0YXRpYyBpbnQgdnBfYWN0aXZlX3ZxKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCB1MTYgbXNp
eF92ZWMpCj4gK3sKPiArCXN0cnVjdCB2aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2ID0gdG9fdnBf
ZGV2aWNlKHZxLT52ZGV2KTsKPiArCXN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZpY2UgKm1k
ZXYgPSAmdnBfZGV2LT5tZGV2Owo+ICsJdW5zaWduZWQgbG9uZyBpbmRleDsKPiArCj4gKwlpbmRl
eCA9IHZxLT5pbmRleDsKPiArCj4gKwkvKiBhY3RpdmF0ZSB0aGUgcXVldWUgKi8KPiArCXZwX21v
ZGVybl9zZXRfcXVldWVfc2l6ZShtZGV2LCBpbmRleCwgdmlydHF1ZXVlX2dldF92cmluZ19zaXpl
KHZxKSk7Cj4gKwl2cF9tb2Rlcm5fcXVldWVfYWRkcmVzcyhtZGV2LCBpbmRleCwgdmlydHF1ZXVl
X2dldF9kZXNjX2FkZHIodnEpLAo+ICsJCQkJdmlydHF1ZXVlX2dldF9hdmFpbF9hZGRyKHZxKSwK
PiArCQkJCXZpcnRxdWV1ZV9nZXRfdXNlZF9hZGRyKHZxKSk7Cj4gKwo+ICsJaWYgKG1zaXhfdmVj
ICE9IFZJUlRJT19NU0lfTk9fVkVDVE9SKSB7Cj4gKwkJbXNpeF92ZWMgPSB2cF9tb2Rlcm5fcXVl
dWVfdmVjdG9yKG1kZXYsIGluZGV4LCBtc2l4X3ZlYyk7Cj4gKwkJaWYgKG1zaXhfdmVjID09IFZJ
UlRJT19NU0lfTk9fVkVDVE9SKQo+ICsJCQlyZXR1cm4gLUVCVVNZOwo+ICsJfQo+ICsKPiArCXJl
dHVybiAwOwo+ICt9Cj4gKwo+ICAgc3RhdGljIHUxNiB2cF9jb25maWdfdmVjdG9yKHN0cnVjdCB2
aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2LCB1MTYgdmVjdG9yKQo+ICAgewo+ICAgCXJldHVybiB2
cF9tb2Rlcm5fY29uZmlnX3ZlY3RvcigmdnBfZGV2LT5tZGV2LCB2ZWN0b3IpOwo+IEBAIC0yMjAs
MzIgKzI0MywxOSBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqc2V0dXBfdnEoc3RydWN0IHZp
cnRpb19wY2lfZGV2aWNlICp2cF9kZXYsCj4gICAKPiAgIAl2cS0+bnVtX21heCA9IG51bTsKPiAg
IAo+IC0JLyogYWN0aXZhdGUgdGhlIHF1ZXVlICovCj4gLQl2cF9tb2Rlcm5fc2V0X3F1ZXVlX3Np
emUobWRldiwgaW5kZXgsIHZpcnRxdWV1ZV9nZXRfdnJpbmdfc2l6ZSh2cSkpOwo+IC0JdnBfbW9k
ZXJuX3F1ZXVlX2FkZHJlc3MobWRldiwgaW5kZXgsIHZpcnRxdWV1ZV9nZXRfZGVzY19hZGRyKHZx
KSwKPiAtCQkJCXZpcnRxdWV1ZV9nZXRfYXZhaWxfYWRkcih2cSksCj4gLQkJCQl2aXJ0cXVldWVf
Z2V0X3VzZWRfYWRkcih2cSkpOwo+ICsJZXJyID0gdnBfYWN0aXZlX3ZxKHZxLCBtc2l4X3ZlYyk7
Cj4gKwlpZiAoZXJyKQo+ICsJCWdvdG8gZXJyOwo+ICAgCj4gICAJdnEtPnByaXYgPSAodm9pZCBf
X2ZvcmNlICopdnBfbW9kZXJuX21hcF92cV9ub3RpZnkobWRldiwgaW5kZXgsIE5VTEwpOwo+ICAg
CWlmICghdnEtPnByaXYpIHsKPiAgIAkJZXJyID0gLUVOT01FTTsKPiAtCQlnb3RvIGVycl9tYXBf
bm90aWZ5Owo+IC0JfQo+IC0KPiAtCWlmIChtc2l4X3ZlYyAhPSBWSVJUSU9fTVNJX05PX1ZFQ1RP
Uikgewo+IC0JCW1zaXhfdmVjID0gdnBfbW9kZXJuX3F1ZXVlX3ZlY3RvcihtZGV2LCBpbmRleCwg
bXNpeF92ZWMpOwo+IC0JCWlmIChtc2l4X3ZlYyA9PSBWSVJUSU9fTVNJX05PX1ZFQ1RPUikgewo+
IC0JCQllcnIgPSAtRUJVU1k7Cj4gLQkJCWdvdG8gZXJyX2Fzc2lnbl92ZWN0b3I7Cj4gLQkJfQo+
ICsJCWdvdG8gZXJyOwo+ICAgCX0KPiAgIAo+ICAgCXJldHVybiB2cTsKPiAgIAo+IC1lcnJfYXNz
aWduX3ZlY3RvcjoKPiAtCWlmICghbWRldi0+bm90aWZ5X2Jhc2UpCj4gLQkJcGNpX2lvdW5tYXAo
bWRldi0+cGNpX2RldiwgKHZvaWQgX19pb21lbSBfX2ZvcmNlICopdnEtPnByaXYpOwoKCldlIG5l
ZWQga2VlcCB0aGlzIG9yIGFueXRoaW5nIEkgbWlzc2VkPwoKVGhhbmtzCgoKPiAtZXJyX21hcF9u
b3RpZnk6Cj4gK2VycjoKPiAgIAl2cmluZ19kZWxfdmlydHF1ZXVlKHZxKTsKPiAgIAlyZXR1cm4g
RVJSX1BUUihlcnIpOwo+ICAgfQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
