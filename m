Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1F1C433F5
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 06:41:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A37494011C;
	Tue, 12 Apr 2022 06:41:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T62g3jNCo1dO; Tue, 12 Apr 2022 06:41:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1D32B400EF;
	Tue, 12 Apr 2022 06:41:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9B3EC0082;
	Tue, 12 Apr 2022 06:41:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D744C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:41:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6509C60F28
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:41:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dt-wolVfd-tP
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:41:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 91B5360F04
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649745696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q0hJ1ezC0n70T2nueon8V1dFA7gdJyx9ipWOKSYhKjA=;
 b=UA9Y55jBqNBzd7K/zV6sVt9rXoPjFG/fIRaZDAv5KPKhFYLLKCp9l1F9/7/Gk8HAUfZNBx
 kNQcOC1UnjCdhSUZtyBlJwUUYGAWh4GEhWQO4buLvhiyvgeOGlKk9061im1v7lGFA7Z/NR
 38hNtPCdEzbxL0NYRZ0HHtYBG13JuyQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-JdgUBt64NWK96FRte8ohSg-1; Tue, 12 Apr 2022 02:41:35 -0400
X-MC-Unique: JdgUBt64NWK96FRte8ohSg-1
Received: by mail-pl1-f198.google.com with SMTP id
 m11-20020a170902f64b00b0015820f8038fso3773064plg.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 23:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Q0hJ1ezC0n70T2nueon8V1dFA7gdJyx9ipWOKSYhKjA=;
 b=KR0Azehhthen8wh/1YCzy0lIjScZNQJvtlE6bo2CD8kMFmdpTD69IbPPrw5FnVzRke
 Vv8S3xRTejwybcBgDOx1IdxsVRaKC4hTmiCsf66mpCIFcluihscsGWnlH7TCNrWo8k/8
 sTWAFq4K+Xpk3hMZEPtNT9GlJ18x0cTWQU0c/PQLOWdrAOOgodVfn6yr3RF/J0aCX+k2
 PhBUnwt13wxartoU5bHnIclrm2wVOy1B6IzfdhY4BUhojpBldW1aTWvsy53Sc7AQ6E2N
 8gVxoLlRqPesauDnmHozjYvO12ePQeVF7iV95cwI8XzEPWSh5plaMwnCqPS3HlNe/HS5
 K87w==
X-Gm-Message-State: AOAM533E2ZAIPO9hU5fomBsSVZaiZKCBEMr43tmc4AxMcqSorkm0hi5o
 ZF1MkR5wDeCBQxZ5Cn+4NZPSsf/OmqwGI/vxtY9sJtAXmdsnVpNeM/gfRPDGUjpZnl+Xrzyl47d
 VFKNpRvPSiFe4BFRjZjwSAoLYKtLXmBR5l+A8AVTuhA==
X-Received: by 2002:aa7:9041:0:b0:4fe:3d6c:1739 with SMTP id
 n1-20020aa79041000000b004fe3d6c1739mr3123255pfo.13.1649745693942; 
 Mon, 11 Apr 2022 23:41:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcN4j4exOoT+eN9+MrdAypldpi+vnmAZMQ+PJ/c+O0wbKWe6GyXiWgL61SrqAdNRlxVdSHkg==
X-Received: by 2002:aa7:9041:0:b0:4fe:3d6c:1739 with SMTP id
 n1-20020aa79041000000b004fe3d6c1739mr3123226pfo.13.1649745693656; 
 Mon, 11 Apr 2022 23:41:33 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 y192-20020a6264c9000000b00505fa595c5asm1265152pfb.129.2022.04.11.23.41.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Apr 2022 23:41:33 -0700 (PDT)
Message-ID: <92622553-e02d-47bd-06f9-0ce24c22650c@redhat.com>
Date: Tue, 12 Apr 2022 14:41:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 18/32] virtio_ring: introduce virtqueue_resize()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-19-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-19-xuanzhuo@linux.alibaba.com>
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
dmlydHF1ZXVlX3Jlc2l6ZSgpIHRvIGltcGxlbWVudCB0aGUgcmVzaXplIG9mIHZyaW5nLgo+IEJh
c2VkIG9uIHRoZXNlLCB0aGUgZHJpdmVyIGNhbiBkeW5hbWljYWxseSBhZGp1c3QgdGhlIHNpemUg
b2YgdGhlIHZyaW5nLgo+IEZvciBleGFtcGxlOiBldGh0b29sIC1HLgo+Cj4gdmlydHF1ZXVlX3Jl
c2l6ZSgpIGltcGxlbWVudHMgcmVzaXplIGJhc2VkIG9uIHRoZSB2cSByZXNldCBmdW5jdGlvbi4g
SW4KPiBjYXNlIG9mIGZhaWx1cmUgdG8gYWxsb2NhdGUgYSBuZXcgdnJpbmcsIGl0IHdpbGwgZ2l2
ZSB1cCByZXNpemUgYW5kIHVzZQo+IHRoZSBvcmlnaW5hbCB2cmluZy4KPgo+IER1cmluZyB0aGlz
IHByb2Nlc3MsIGlmIHRoZSByZS1lbmFibGUgcmVzZXQgdnEgZmFpbHMsIHRoZSB2cSBjYW4gbm8K
PiBsb25nZXIgYmUgdXNlZC4gQWx0aG91Z2ggdGhlIHByb2JhYmlsaXR5IG9mIHRoaXMgc2l0dWF0
aW9uIGlzIG5vdCBoaWdoLgo+Cj4gVGhlIHBhcmFtZXRlciByZWN5Y2xlIGlzIHVzZWQgdG8gcmVj
eWNsZSB0aGUgYnVmZmVyIHRoYXQgaXMgbm8gbG9uZ2VyCj4gdXNlZC4KPgo+IFNpZ25lZC1vZmYt
Ynk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gLS0tCj4gICBkcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgNjkgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrCj4gICBpbmNsdWRlL2xpbnV4L3ZpcnRpby5oICAgICAgIHwgIDMgKysKPiAgIDIg
ZmlsZXMgY2hhbmdlZCwgNzIgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5k
ZXggMDZmNjZiMTVjODZjLi42MjUwZTE5ZmM1YmYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBA
QCAtMjU1NCw2ICsyNTU0LDc1IEBAIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0
cXVldWUoCj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MX0dQTCh2cmluZ19jcmVhdGVfdmlydHF1ZXVl
KTsKPiAgIAo+ICsvKioKPiArICogdmlydHF1ZXVlX3Jlc2l6ZSAtIHJlc2l6ZSB0aGUgdnJpbmcg
b2YgdnEKPiArICogQF92cTogdGhlIHN0cnVjdCB2aXJ0cXVldWUgd2UncmUgdGFsa2luZyBhYm91
dC4KPiArICogQG51bTogbmV3IHJpbmcgbnVtCj4gKyAqIEByZWN5Y2xlOiBjYWxsYmFjayBmb3Ig
cmVjeWNsZSB0aGUgdXNlbGVzcyBidWZmZXIKPiArICoKPiArICogV2hlbiBpdCBpcyByZWFsbHkg
bmVjZXNzYXJ5IHRvIGNyZWF0ZSBhIG5ldyB2cmluZywgaXQgd2lsbCBzZXQgdGhlIGN1cnJlbnQg
dnEKPiArICogaW50byB0aGUgcmVzZXQgc3RhdGUuIFRoZW4gY2FsbCB0aGUgcGFzc2VkIGNhbGxi
YWNrIHRvIHJlY3ljbGUgdGhlIGJ1ZmZlcgo+ICsgKiB0aGF0IGlzIG5vIGxvbmdlciB1c2VkLiBP
bmx5IGFmdGVyIHRoZSBuZXcgdnJpbmcgaXMgc3VjY2Vzc2Z1bGx5IGNyZWF0ZWQsIHRoZQo+ICsg
KiBvbGQgdnJpbmcgd2lsbCBiZSByZWxlYXNlZC4KPiArICoKPiArICogQ2FsbGVyIG11c3QgZW5z
dXJlIHdlIGRvbid0IGNhbGwgdGhpcyB3aXRoIG90aGVyIHZpcnRxdWV1ZSBvcGVyYXRpb25zCj4g
KyAqIGF0IHRoZSBzYW1lIHRpbWUgKGV4Y2VwdCB3aGVyZSBub3RlZCkuCj4gKyAqCj4gKyAqIFJl
dHVybnMgemVybyBvciBhIG5lZ2F0aXZlIGVycm9yLgoKClNob3VsZCB3ZSBkb2N1bWVudCB0aGF0
IHRoZSB2aXJ0cXVldWUgaXMga2VwdCB1bmNoYW5nZWQgKHN0aWxsIAphdmFpbGFibGUpIG9uIChz
cGVjaWZpYykgZmFpbHVyZT8KCgo+ICsgKi8KPiAraW50IHZpcnRxdWV1ZV9yZXNpemUoc3RydWN0
IHZpcnRxdWV1ZSAqX3ZxLCB1MzIgbnVtLAo+ICsJCSAgICAgdm9pZCAoKnJlY3ljbGUpKHN0cnVj
dCB2aXJ0cXVldWUgKnZxLCB2b2lkICpidWYpKQo+ICt7Cj4gKwlzdHJ1Y3QgdnJpbmdfdmlydHF1
ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ICsJc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYgPSB2
cS0+dnEudmRldjsKPiArCWJvb2wgcGFja2VkOwo+ICsJdm9pZCAqYnVmOwo+ICsJaW50IGVycjsK
PiArCj4gKwlpZiAoIXZxLT53ZV9vd25fcmluZykKPiArCQlyZXR1cm4gLUVJTlZBTDsKPiArCj4g
KwlpZiAobnVtID4gdnEtPnZxLm51bV9tYXgpCj4gKwkJcmV0dXJuIC1FMkJJRzsKPiArCj4gKwlp
ZiAoIW51bSkKPiArCQlyZXR1cm4gLUVJTlZBTDsKPiArCj4gKwlwYWNrZWQgPSB2aXJ0aW9faGFz
X2ZlYXR1cmUodmRldiwgVklSVElPX0ZfUklOR19QQUNLRUQpID8gdHJ1ZSA6IGZhbHNlOwo+ICsK
PiArCWlmICgocGFja2VkID8gdnEtPnBhY2tlZC52cmluZy5udW0gOiB2cS0+c3BsaXQudnJpbmcu
bnVtKSA9PSBudW0pCj4gKwkJcmV0dXJuIDA7Cj4gKwo+ICsJaWYgKCF2ZGV2LT5jb25maWctPnJl
c2V0X3ZxKQo+ICsJCXJldHVybiAtRU5PRU5UOwo+ICsKPiArCWlmICghdmRldi0+Y29uZmlnLT5l
bmFibGVfcmVzZXRfdnEpCj4gKwkJcmV0dXJuIC1FTk9FTlQ7Cj4gKwo+ICsJZXJyID0gdmRldi0+
Y29uZmlnLT5yZXNldF92cShfdnEpOwo+ICsJaWYgKGVycikKPiArCQlyZXR1cm4gZXJyOwo+ICsK
PiArCXdoaWxlICgoYnVmID0gdmlydHF1ZXVlX2RldGFjaF91bnVzZWRfYnVmKF92cSkpICE9IE5V
TEwpCj4gKwkJcmVjeWNsZShfdnEsIGJ1Zik7Cj4gKwo+ICsJaWYgKHBhY2tlZCkgewo+ICsJCWVy
ciA9IHZpcnRxdWV1ZV9yZXNpemVfcGFja2VkKF92cSwgbnVtKTsKPiArCQlpZiAoZXJyKQo+ICsJ
CQl2aXJ0cXVldWVfcmVpbml0X3BhY2tlZCh2cSk7CgoKQ2FsbGluZyByZWluaXQgaGVyZSBzZWVt
cyBhIGxpdHRsZSBiaXQgb2RkLCBpdCBsb29rcyBtb3JlIGxpa2UgYSByZXNldCAKb2YgdGhlIHZp
cnRxdWV1ZS4gQ29uc2lkZXIgd2UgbWF5IHJlLXVzZSB2aXJ0cXVldWUgcmVzZXQgZm9yIG1vcmUg
CnB1cnBvc2UsIEkgd29uZGVyIGlmIHdlIG5lZWQgYSBoZWxwZXIgbGlrZToKCnZpcnRxdWV1ZV9y
ZXNpemUoKSB7CiDCoMKgwqAgdmRldi0+Y29uZmlnLT5yZXNldF92cShfdnEpOwogwqDCoMKgIGlm
IChwYWNrZWQpCiDCoMKgwqAgwqDCoMKgIHZpcnRxdWV1ZV9yZWluaXRfcGFja2VkKF92cSkKIMKg
wqDCoCBlbHNlCiDCoMKgwqDCoMKgwqDCoCB2aXJ0cXVldWVfcmVpbml0X3NwbGl0KF92cSkKfQoK
VGhhbmtzCgoKPiArCX0gZWxzZSB7Cj4gKwkJZXJyID0gdmlydHF1ZXVlX3Jlc2l6ZV9zcGxpdChf
dnEsIG51bSk7Cj4gKwkJaWYgKGVycikKPiArCQkJdmlydHF1ZXVlX3JlaW5pdF9zcGxpdCh2cSk7
Cj4gKwl9Cj4gKwo+ICsJaWYgKHZkZXYtPmNvbmZpZy0+ZW5hYmxlX3Jlc2V0X3ZxKF92cSkpCj4g
KwkJcmV0dXJuIC1FQlVTWTsKPiArCj4gKwlyZXR1cm4gZXJyOwo+ICt9Cj4gK0VYUE9SVF9TWU1C
T0xfR1BMKHZpcnRxdWV1ZV9yZXNpemUpOwo+ICsKPiAgIC8qIE9ubHkgYXZhaWxhYmxlIGZvciBz
cGxpdCByaW5nICovCj4gICBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19uZXdfdmlydHF1ZXVlKHVu
c2lnbmVkIGludCBpbmRleCwKPiAgIAkJCQkgICAgICB1bnNpZ25lZCBpbnQgbnVtLAo+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+
IGluZGV4IGQ1OWFkYzRiZTA2OC4uYzg2ZmYwMmUwY2EwIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUv
bGludXgvdmlydGlvLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gQEAgLTkxLDYg
KzkxLDkgQEAgZG1hX2FkZHJfdCB2aXJ0cXVldWVfZ2V0X2Rlc2NfYWRkcihzdHJ1Y3QgdmlydHF1
ZXVlICp2cSk7Cj4gICBkbWFfYWRkcl90IHZpcnRxdWV1ZV9nZXRfYXZhaWxfYWRkcihzdHJ1Y3Qg
dmlydHF1ZXVlICp2cSk7Cj4gICBkbWFfYWRkcl90IHZpcnRxdWV1ZV9nZXRfdXNlZF9hZGRyKHN0
cnVjdCB2aXJ0cXVldWUgKnZxKTsKPiAgIAo+ICtpbnQgdmlydHF1ZXVlX3Jlc2l6ZShzdHJ1Y3Qg
dmlydHF1ZXVlICp2cSwgdTMyIG51bSwKPiArCQkgICAgIHZvaWQgKCpyZWN5Y2xlKShzdHJ1Y3Qg
dmlydHF1ZXVlICp2cSwgdm9pZCAqYnVmKSk7Cj4gKwo+ICAgLyoqCj4gICAgKiB2aXJ0aW9fZGV2
aWNlIC0gcmVwcmVzZW50YXRpb24gb2YgYSBkZXZpY2UgdXNpbmcgdmlydGlvCj4gICAgKiBAaW5k
ZXg6IHVuaXF1ZSBwb3NpdGlvbiBvbiB0aGUgdmlydGlvIGJ1cwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
