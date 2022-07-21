Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6D5CCA479
	for <virtualization@archiver.kernel.org>; Thu, 21 Jul 2022 09:14:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26B85418CE;
	Thu, 21 Jul 2022 09:14:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 26B85418CE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YuY6hov1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K5E4FoPPoLpl; Thu, 21 Jul 2022 09:14:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5E3214192C;
	Thu, 21 Jul 2022 09:14:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5E3214192C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0ACABC0033;
	Thu, 21 Jul 2022 09:14:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A310C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7BC3E40194
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:14:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7BC3E40194
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YuY6hov1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0CaLWuKZCOaS
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:14:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 77CF54018F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 77CF54018F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658394847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=evkly4mzwl0OWnSDguyVCSXP+iuc3cHesZCTCuELO9c=;
 b=YuY6hov1brzRJK0PFq0RvULidQ7v0N9DQqq6GR2j3jfvCETpbK5z1pLIyjRKAPtrPYbTor
 rBw538Fa+VZFBV6S+NB7jrNj8dvwSdjagNio8BKxeWdgSQMak6f5Gok4Jgcn9G1tybtkI0
 MlIWaofp+84W1dCl+f9p8eZQSfFLaOs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-DFN8zuRQPhyWRrY_P2zQVA-1; Thu, 21 Jul 2022 05:14:03 -0400
X-MC-Unique: DFN8zuRQPhyWRrY_P2zQVA-1
Received: by mail-pj1-f70.google.com with SMTP id
 r6-20020a17090a2e8600b001f0768a1af1so2546284pjd.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 02:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=evkly4mzwl0OWnSDguyVCSXP+iuc3cHesZCTCuELO9c=;
 b=y2ejj01CXGpmRaiE/hF9dzDloloN3ATb/yHFtnvBS/9FWQjRQtGMnbbocyAN9HC7QQ
 XYfUHoqIsi4770RW00OfJbncyNTsaXAh+MjBPR70XTCrtemGj42cfjvOvhb7JUFtcfJK
 2bGinwQSnSIeNIqRlqJxCbteoNbDkQM+5YH0I/wOF7VUMiz3dd4nmy8LMP7iIhD/Ya3v
 n7mgoiuwqrU9Jri18U1NbyfpEwj8hg9P7QoX4c+J9vbS06YbGJB5GHRrOI+jze41Gv5g
 wvS/sDvxGUK5eTrdE3T5R1J6cFhnzhGfMoZO7gnbxABk3p/7BIez2fuUPS8V7rMdnyVz
 CVLw==
X-Gm-Message-State: AJIora/TdzxV9/0vqLo3KXwu/pQawkFn/g8fEzqCjXnxob8H7uzMgMvi
 RCgZ5d5dZoU6N+TL3IJL4A+qoBO602QIyXVDBqhXccx1JCNaB5pwDmNNihegSviEzINekzsXBsG
 izPmobjFaYi0m04YTYBWGKTBwbfaxdmJ2cnw03uN1jA==
X-Received: by 2002:a17:90b:681:b0:1f2:147a:5e55 with SMTP id
 m1-20020a17090b068100b001f2147a5e55mr10137466pjz.159.1658394841816; 
 Thu, 21 Jul 2022 02:14:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vZd1H6ktLLHxg0oQu5yg8T5pv3EpQ1CpRpfXswCqn2eqimIJKu3rbioASMftx5YraJgvSUnw==
X-Received: by 2002:a17:90b:681:b0:1f2:147a:5e55 with SMTP id
 m1-20020a17090b068100b001f2147a5e55mr10137436pjz.159.1658394841532; 
 Thu, 21 Jul 2022 02:14:01 -0700 (PDT)
Received: from [10.72.12.47] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 z28-20020aa7949c000000b0052516db7123sm1181543pfk.35.2022.07.21.02.13.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Jul 2022 02:14:00 -0700 (PDT)
Message-ID: <0b3c985d-d479-a554-4fe2-bfe94fc74070@redhat.com>
Date: Thu, 21 Jul 2022 17:13:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v12 08/40] virtio_ring: split: extract the logic of alloc
 queue
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220720030436.79520-9-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjAgMTE6MDQsIFh1YW4gWmh1byDlhpnpgZM6Cj4gU2VwYXJhdGUgdGhlIGxv
Z2ljIG9mIHNwbGl0IHRvIGNyZWF0ZSB2cmluZyBxdWV1ZS4KPgo+IFRoaXMgZmVhdHVyZSBpcyBy
ZXF1aXJlZCBmb3Igc3Vic2VxdWVudCB2aXJ0dXF1ZXVlIHJlc2V0IHZyaW5nLgo+Cj4gU2lnbmVk
LW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAg
IGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCA2OCArKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCAyNiBk
ZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5j
IGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IGM5NGM1NDYxZTcwMi4uYzc5
NzE0MzhiYjJjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiAr
KysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTk1MCwyOCArOTUwLDE5IEBA
IHN0YXRpYyB2b2lkIHZyaW5nX2ZyZWVfc3BsaXQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZV9zcGxp
dCAqdnJpbmdfc3BsaXQsCj4gICAJa2ZyZWUodnJpbmdfc3BsaXQtPmRlc2NfZXh0cmEpOwo+ICAg
fQo+ICAgCj4gLXN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVl
X3NwbGl0KAo+IC0JdW5zaWduZWQgaW50IGluZGV4LAo+IC0JdW5zaWduZWQgaW50IG51bSwKPiAt
CXVuc2lnbmVkIGludCB2cmluZ19hbGlnbiwKPiAtCXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2
LAo+IC0JYm9vbCB3ZWFrX2JhcnJpZXJzLAo+IC0JYm9vbCBtYXlfcmVkdWNlX251bSwKPiAtCWJv
b2wgY29udGV4dCwKPiAtCWJvb2wgKCpub3RpZnkpKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4gLQl2
b2lkICgqY2FsbGJhY2spKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4gLQljb25zdCBjaGFyICpuYW1l
KQo+ICtzdGF0aWMgaW50IHZyaW5nX2FsbG9jX3F1ZXVlX3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0
cXVldWVfc3BsaXQgKnZyaW5nX3NwbGl0LAo+ICsJCQkJICAgc3RydWN0IHZpcnRpb19kZXZpY2Ug
KnZkZXYsCj4gKwkJCQkgICB1MzIgbnVtLAo+ICsJCQkJICAgdW5zaWduZWQgaW50IHZyaW5nX2Fs
aWduLAo+ICsJCQkJICAgYm9vbCBtYXlfcmVkdWNlX251bSkKPiAgIHsKPiAtCXN0cnVjdCB2aXJ0
cXVldWUgKnZxOwo+ICAgCXZvaWQgKnF1ZXVlID0gTlVMTDsKPiAgIAlkbWFfYWRkcl90IGRtYV9h
ZGRyOwo+IC0Jc2l6ZV90IHF1ZXVlX3NpemVfaW5fYnl0ZXM7Cj4gLQlzdHJ1Y3QgdnJpbmcgdnJp
bmc7Cj4gICAKPiAgIAkvKiBXZSBhc3N1bWUgbnVtIGlzIGEgcG93ZXIgb2YgMi4gKi8KPiAgIAlp
ZiAobnVtICYgKG51bSAtIDEpKSB7Cj4gICAJCWRldl93YXJuKCZ2ZGV2LT5kZXYsICJCYWQgdmly
dHF1ZXVlIGxlbmd0aCAldVxuIiwgbnVtKTsKPiAtCQlyZXR1cm4gTlVMTDsKPiArCQlyZXR1cm4g
LUVJTlZBTDsKPiAgIAl9Cj4gICAKPiAgIAkvKiBUT0RPOiBhbGxvY2F0ZSBlYWNoIHF1ZXVlIGNo
dW5rIGluZGl2aWR1YWxseSAqLwo+IEBAIC05ODIsMTEgKzk3MywxMSBAQCBzdGF0aWMgc3RydWN0
IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9zcGxpdCgKPiAgIAkJaWYgKHF1ZXVl
KQo+ICAgCQkJYnJlYWs7Cj4gICAJCWlmICghbWF5X3JlZHVjZV9udW0pCj4gLQkJCXJldHVybiBO
VUxMOwo+ICsJCQlyZXR1cm4gLUVOT01FTTsKPiAgIAl9Cj4gICAKPiAgIAlpZiAoIW51bSkKPiAt
CQlyZXR1cm4gTlVMTDsKPiArCQlyZXR1cm4gLUVOT01FTTsKPiAgIAo+ICAgCWlmICghcXVldWUp
IHsKPiAgIAkJLyogVHJ5IHRvIGdldCBhIHNpbmdsZSBwYWdlLiBZb3UgYXJlIG15IG9ubHkgaG9w
ZSEgKi8KPiBAQCAtOTk0LDIxICs5ODUsNDYgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZy
aW5nX2NyZWF0ZV92aXJ0cXVldWVfc3BsaXQoCj4gICAJCQkJCSAgJmRtYV9hZGRyLCBHRlBfS0VS
TkVMfF9fR0ZQX1pFUk8pOwo+ICAgCX0KPiAgIAlpZiAoIXF1ZXVlKQo+IC0JCXJldHVybiBOVUxM
Owo+ICsJCXJldHVybiAtRU5PTUVNOwo+ICsKPiArCXZyaW5nX2luaXQoJnZyaW5nX3NwbGl0LT52
cmluZywgbnVtLCBxdWV1ZSwgdnJpbmdfYWxpZ24pOwo+ICAgCj4gLQlxdWV1ZV9zaXplX2luX2J5
dGVzID0gdnJpbmdfc2l6ZShudW0sIHZyaW5nX2FsaWduKTsKPiAtCXZyaW5nX2luaXQoJnZyaW5n
LCBudW0sIHF1ZXVlLCB2cmluZ19hbGlnbik7Cj4gKwl2cmluZ19zcGxpdC0+cXVldWVfZG1hX2Fk
ZHIgPSBkbWFfYWRkcjsKPiArCXZyaW5nX3NwbGl0LT5xdWV1ZV9zaXplX2luX2J5dGVzID0gdnJp
bmdfc2l6ZShudW0sIHZyaW5nX2FsaWduKTsKPiArCj4gKwlyZXR1cm4gMDsKPiArfQo+ICsKPiAr
c3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfc3BsaXQoCj4g
Kwl1bnNpZ25lZCBpbnQgaW5kZXgsCj4gKwl1bnNpZ25lZCBpbnQgbnVtLAo+ICsJdW5zaWduZWQg
aW50IHZyaW5nX2FsaWduLAo+ICsJc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gKwlib29s
IHdlYWtfYmFycmllcnMsCj4gKwlib29sIG1heV9yZWR1Y2VfbnVtLAo+ICsJYm9vbCBjb250ZXh0
LAo+ICsJYm9vbCAoKm5vdGlmeSkoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiArCXZvaWQgKCpjYWxs
YmFjaykoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiArCWNvbnN0IGNoYXIgKm5hbWUpCj4gK3sKPiAr
CXN0cnVjdCB2cmluZ192aXJ0cXVldWVfc3BsaXQgdnJpbmdfc3BsaXQgPSB7fTsKPiArCXN0cnVj
dCB2aXJ0cXVldWUgKnZxOwo+ICsJaW50IGVycjsKPiArCj4gKwllcnIgPSB2cmluZ19hbGxvY19x
dWV1ZV9zcGxpdCgmdnJpbmdfc3BsaXQsIHZkZXYsIG51bSwgdnJpbmdfYWxpZ24sCj4gKwkJCQkg
ICAgICBtYXlfcmVkdWNlX251bSk7Cj4gKwlpZiAoZXJyKQo+ICsJCXJldHVybiBOVUxMOwo+ICAg
Cj4gLQl2cSA9IF9fdnJpbmdfbmV3X3ZpcnRxdWV1ZShpbmRleCwgdnJpbmcsIHZkZXYsIHdlYWtf
YmFycmllcnMsIGNvbnRleHQsCj4gLQkJCQkgICBub3RpZnksIGNhbGxiYWNrLCBuYW1lKTsKPiAr
CXZxID0gX192cmluZ19uZXdfdmlydHF1ZXVlKGluZGV4LCB2cmluZ19zcGxpdC52cmluZywgdmRl
diwgd2Vha19iYXJyaWVycywKPiArCQkJCSAgIGNvbnRleHQsIG5vdGlmeSwgY2FsbGJhY2ssIG5h
bWUpOwo+ICAgCWlmICghdnEpIHsKPiAtCQl2cmluZ19mcmVlX3F1ZXVlKHZkZXYsIHF1ZXVlX3Np
emVfaW5fYnl0ZXMsIHF1ZXVlLAo+IC0JCQkJIGRtYV9hZGRyKTsKPiArCQl2cmluZ19mcmVlX3Nw
bGl0KCZ2cmluZ19zcGxpdCwgdmRldik7Cj4gICAJCXJldHVybiBOVUxMOwo+ICAgCX0KPiAgIAo+
IC0JdG9fdnZxKHZxKS0+c3BsaXQucXVldWVfZG1hX2FkZHIgPSBkbWFfYWRkcjsKPiAtCXRvX3Z2
cSh2cSktPnNwbGl0LnF1ZXVlX3NpemVfaW5fYnl0ZXMgPSBxdWV1ZV9zaXplX2luX2J5dGVzOwo+
ICsJdG9fdnZxKHZxKS0+c3BsaXQucXVldWVfZG1hX2FkZHIgPSB2cmluZ19zcGxpdC5xdWV1ZV9k
bWFfYWRkcjsKPiArCXRvX3Z2cSh2cSktPnNwbGl0LnF1ZXVlX3NpemVfaW5fYnl0ZXMgPSB2cmlu
Z19zcGxpdC5xdWV1ZV9zaXplX2luX2J5dGVzOwoKClRoaXMgc3RpbGwgc2VlbXMgYSBsaXR0bGUg
Yml0IHJlZHVuZGFudCBzaW5jZSB0aGUgY3VycmVudCBsb2dpYyBpcyBhIApsaXR0bGUgYml0IGNv
bXBsaWNhdGVkIHNpbmNlIHRoZSB2cS0+c3BsaXQgaXMgbm90IGluaXRpYWxpemVkIGluIGEgCnNp
bmdsZSBwbGFjZS4KCkkgd29uZGVyIGlmIGl0J3MgYmV0dGVyIHRvOgoKdnJpbmdfYWxsb2NfcXVl
dWVfc3BsaXQoKQp2cmluZ19hbGxvY19kZXNjX2V4dHJhKCkgKHJlb3JkZXIgdG8gbWFrZSBwYXRj
aCA5IGNvbWUgZmlyc3QpCgp0aGVuIHdlIGNhbiBzaW1wbHkgYXNzaWduIHZyaW5nX3NwbGl0IHRv
IHZxLT5zcGxpdCBpbiAKX192cmluZ19uZXdfdmlydHF1ZXVlKCkgc2luY2UgaXQgaGFzOgoKIMKg
wqDCoCB2cS0+c3BsaXQucXVldWVfZG1hX2FkZHIgPSAwOwogwqDCoCDCoHZxLT5zcGxpdC5xdWV1
ZV9zaXplX2luX2J5dGVzID0gMDsKCiDCoMKgwqAgdnEtPnNwbGl0LnZyaW5nID0gdnJpbmc7CiDC
oMKgwqAgdnEtPnNwbGl0LmF2YWlsX2ZsYWdzX3NoYWRvdyA9IDA7CiDCoMKgwqAgdnEtPnNwbGl0
LmF2YWlsX2lkeF9zaGFkb3cgPSAwOwoKVGhpcyBzZWVtcyB0byBzaW1wbGlmeSB0aGUgbG9naWMg
YW5kIHRhc2sgb2YgZS5nIAp2aXJ0cXVldWVfdnJpbmdfYXR0YWNoX3NwbGl0KCkgdG8gYSBzaW1w
bGU6Cgp2cS0+c3BsaXQ9IHZyaW5nX3NwbGl0OwoKQW5kIGlmIHRoaXMgbWFrZXMgc2Vuc2UsIHdl
IGNhbiBkbyBzb21ldGhpbmcgc2ltaWxhciB0byBwYWNrZWQgcmluZy4KClRoYW5rcwoKCj4gICAJ
dG9fdnZxKHZxKS0+d2Vfb3duX3JpbmcgPSB0cnVlOwo+ICAgCj4gICAJcmV0dXJuIHZxOwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
