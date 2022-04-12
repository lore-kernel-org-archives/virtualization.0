Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE4FC35294
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 07:19:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 089DB83E43;
	Tue, 12 Apr 2022 07:19:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z1ArdnowqA6I; Tue, 12 Apr 2022 07:19:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8EF57813E9;
	Tue, 12 Apr 2022 07:19:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DCC2C0033;
	Tue, 12 Apr 2022 07:19:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A22CC002C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:19:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EBF85404A1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:19:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oWf-QE3EEk3f
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:19:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3F88F40141
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649747962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yuz95x1G3zlqb83uNRLz/nX1y2Nb6heM9sreLygHM+8=;
 b=e1xsGA0u6k5ZzQuDGpM/i83UMVxauBVEGYneTs/iMGaPzymbSZYNASxECQTqIKj+fMymyn
 hQVGp5+O8G68QuBNZ2IKDKLnn8meKQ8Xwv60fugrUt09YGE7lpcolO319+B2y3ZIPBxr1i
 eEyc4XLRXjoG3nAHVQQ5E5bxdLYlQ9c=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-kI1BGrgvNUGwl9T1327NRw-1; Tue, 12 Apr 2022 03:19:21 -0400
X-MC-Unique: kI1BGrgvNUGwl9T1327NRw-1
Received: by mail-pf1-f198.google.com with SMTP id
 j17-20020a62b611000000b004fa6338bd77so10995709pff.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 00:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Yuz95x1G3zlqb83uNRLz/nX1y2Nb6heM9sreLygHM+8=;
 b=cOwnW50JtcCvOX3ZdWS28ZYr/S9/nExis0hE85YPHhrpcdA6dI2Wm5FJ4QTb61/Y91
 iLTva2jGQIQ7kS5Qrf9IFLOm5DN95TjwZUxRBxyIl6XqL3AqBHoK5IQkPu2P9kdOO0kL
 UOD1jZ9m9TT+dH7UFTsdXZ0j2xw2eTFtyitX4XIvIzc7gclJxepKEMPVw/KqTpCpUvwp
 ZC9fT2hLt8FuSXh/LrmHSMwZpQ6uBQhPhkkhlXAAJWUjTwNrPFO4cDhiedBHaeeO5p+P
 ElFyswEG5jsThj9S/giCmJ7NOIxk9C7KVOVIUiIwZNAF79qupWHwN8q4YsS1BUBp4gK7
 r15Q==
X-Gm-Message-State: AOAM530StIHXOzdepmoZRgjkGxh+IXLaT3NxipUcbfbHRnDNKLYVfcGr
 JwMRaPRYN4S5Zhv8hHH6tWEBMHDK0R/5MbMnLus3AEMaVeGXoz4xAM13fYAbCia9621VmcxaJ/s
 yvuWRTYsM/kuYzHWUJZm5SiBBI5lNX/98KMIMTjYPCA==
X-Received: by 2002:a63:ce45:0:b0:399:1124:fbfe with SMTP id
 r5-20020a63ce45000000b003991124fbfemr30142594pgi.542.1649747959984; 
 Tue, 12 Apr 2022 00:19:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybC3H9odgtD5WvWO3Wfz5iznlcc/pnW1u61iazVEqAlovz3OVbp6nLoj0UKzRc5hYeHz5xRQ==
X-Received: by 2002:a63:ce45:0:b0:399:1124:fbfe with SMTP id
 r5-20020a63ce45000000b003991124fbfemr30142555pgi.542.1649747959749; 
 Tue, 12 Apr 2022 00:19:19 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 oo16-20020a17090b1c9000b001b89e05e2b2sm1791569pjb.34.2022.04.12.00.19.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Apr 2022 00:19:19 -0700 (PDT)
Message-ID: <2776b925-1989-40b2-44ed-6964105e22cb@redhat.com>
Date: Tue, 12 Apr 2022 15:19:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 29/32] virtio_net: get ringparam by
 virtqueue_get_vring_max_size()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-30-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-30-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBVc2UgdmlydHF1
ZXVlX2dldF92cmluZ19tYXhfc2l6ZSgpIGluIHZpcnRuZXRfZ2V0X3JpbmdwYXJhbSgpIHRvIHNl
dAo+IHR4LHJ4X21heF9wZW5kaW5nLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFu
emh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4KCgo+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgOCArKysr
LS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMKPiBpbmRleCBkYWQ0OTdhNDdiM2EuLjk2ZDk2YzY2NmM4YyAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMKPiBAQCAtMjE3NywxMCArMjE3NywxMCBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X2dldF9y
aW5ncGFyYW0oc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgIHsKPiAgIAlzdHJ1Y3QgdmlydG5l
dF9pbmZvICp2aSA9IG5ldGRldl9wcml2KGRldik7Cj4gICAKPiAtCXJpbmctPnJ4X21heF9wZW5k
aW5nID0gdmlydHF1ZXVlX2dldF92cmluZ19zaXplKHZpLT5ycVswXS52cSk7Cj4gLQlyaW5nLT50
eF9tYXhfcGVuZGluZyA9IHZpcnRxdWV1ZV9nZXRfdnJpbmdfc2l6ZSh2aS0+c3FbMF0udnEpOwo+
IC0JcmluZy0+cnhfcGVuZGluZyA9IHJpbmctPnJ4X21heF9wZW5kaW5nOwo+IC0JcmluZy0+dHhf
cGVuZGluZyA9IHJpbmctPnR4X21heF9wZW5kaW5nOwo+ICsJcmluZy0+cnhfbWF4X3BlbmRpbmcg
PSB2aXJ0cXVldWVfZ2V0X3ZyaW5nX21heF9zaXplKHZpLT5ycVswXS52cSk7Cj4gKwlyaW5nLT50
eF9tYXhfcGVuZGluZyA9IHZpcnRxdWV1ZV9nZXRfdnJpbmdfbWF4X3NpemUodmktPnNxWzBdLnZx
KTsKPiArCXJpbmctPnJ4X3BlbmRpbmcgPSB2aXJ0cXVldWVfZ2V0X3ZyaW5nX3NpemUodmktPnJx
WzBdLnZxKTsKPiArCXJpbmctPnR4X3BlbmRpbmcgPSB2aXJ0cXVldWVfZ2V0X3ZyaW5nX3NpemUo
dmktPnNxWzBdLnZxKTsKPiAgIH0KPiAgIAo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
