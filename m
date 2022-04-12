Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DC9C433F5
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 07:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 478CD60F28;
	Tue, 12 Apr 2022 07:14:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xyA5f7AJbqR2; Tue, 12 Apr 2022 07:14:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EC72C60F35;
	Tue, 12 Apr 2022 07:14:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8A5BC0033;
	Tue, 12 Apr 2022 07:14:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C085C002C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 797DA83089
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:14:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4nt01cMndm99
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:14:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BC76082ED1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649747647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+KfEewUd/P7rD+GfgzNOJ3/+yQH5JQRsFMgr1fgMrBA=;
 b=A62lYQTDhEBXiTg+SU6TpShWICa63RxWihLUKu4+tcfHEMEQRDaNRGvgrMSzCtAfHcW8ut
 j3hp+xRhQluSlgZS4R1A+BY0hPnWx84I4D0qaFki90viglFLQcG6VAwdZfiQ+0WCR1537J
 FJiryChlXTCwaedRb4VVpcAZvE6qbLQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-k1KyR5RXOmGUDufMVZ4RLg-1; Tue, 12 Apr 2022 03:14:06 -0400
X-MC-Unique: k1KyR5RXOmGUDufMVZ4RLg-1
Received: by mail-pj1-f69.google.com with SMTP id
 s13-20020a17090a764d00b001cb896b75ffso3055870pjl.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 00:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=+KfEewUd/P7rD+GfgzNOJ3/+yQH5JQRsFMgr1fgMrBA=;
 b=hhuHX1S3PgW3RdvMFHdR7q/PCIYyNMMXeHaF7IWSZBM8868cXBY7PznMgRPq+HgCX3
 Agul1hT55GKSHLsOkOe7fP2iF35eIOZoGpgnbyRKZA8Kig6yArcz8sqIC1SC6LoJGryz
 AOQuM3HykOEktjaonUJNzy9O/hCTrA+IrE0N4bVqdqerTOfiGgks7k0P3lDecIt+yWAr
 dYqzhEwED7U04zH/10CaH0Pky3LSWI0pDpP7U4wJRZ4Ws2PsEcvi32lnKcYNMiPwRir9
 wzhdOSNEf4Deep06AJXL1ihm4ra+9vRjQPnGDvA6rNB7H9zxxNOzV8pSNLPhRGZCk7lv
 q1aQ==
X-Gm-Message-State: AOAM533a63UCpmB6ip8VOpKqcQd+9BEEo6Y/TU7p659lVRw7OQrOfO5+
 0qeHVQLByt9S6frae8kXc4hxF4Cnr+cEzNCUCgtcRjcg/HZy9LheoECyEvk4rho8k5tVU9wRrfm
 82DbVcyvo0i/2i2groSiIeW8vCuozm4uYQsDW8ymHcQ==
X-Received: by 2002:a63:9203:0:b0:386:3b37:76b5 with SMTP id
 o3-20020a639203000000b003863b3776b5mr30232823pgd.234.1649747645358; 
 Tue, 12 Apr 2022 00:14:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxz8tuQLUzxBTFiELPnVmPwK4HkOQmo42dCUGoCnnoQX1nf1+7XyvUkjmkIVepPIYWlERR4oQ==
X-Received: by 2002:a63:9203:0:b0:386:3b37:76b5 with SMTP id
 o3-20020a639203000000b003863b3776b5mr30232780pgd.234.1649747645115; 
 Tue, 12 Apr 2022 00:14:05 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 q10-20020a056a00088a00b004f7ceff389esm39492179pfj.152.2022.04.12.00.13.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Apr 2022 00:14:04 -0700 (PDT)
Message-ID: <e8298f3d-dd58-8031-606f-f0fb061a7c95@redhat.com>
Date: Tue, 12 Apr 2022 15:13:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 26/32] virtio_mmio: support the arg sizes of find_vqs()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-27-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-27-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBWaXJ0aW8gTU1J
TyBzdXBwb3J0IHRoZSBuZXcgcGFyYW1ldGVyIHNpemVzIG9mIGZpbmRfdnFzKCkuCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IC0tLQoK
CkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gICBkcml2ZXJz
L3ZpcnRpby92aXJ0aW9fbW1pby5jIHwgOCArKysrKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fbW1pby5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX21taW8uYwo+IGluZGV4
IDlkNWE2NzRiZGVlYy4uNTFjZjUxNzY0YTkyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19tbWlvLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fbW1pby5jCj4gQEAg
LTM0Nyw3ICszNDcsNyBAQCBzdGF0aWMgdm9pZCB2bV9kZWxfdnFzKHN0cnVjdCB2aXJ0aW9fZGV2
aWNlICp2ZGV2KQo+ICAgCj4gICBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdm1fc2V0dXBfdnEo
c3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGluZGV4LAo+ICAgCQkJCSAgdm9p
ZCAoKmNhbGxiYWNrKShzdHJ1Y3QgdmlydHF1ZXVlICp2cSksCj4gLQkJCQkgIGNvbnN0IGNoYXIg
Km5hbWUsIGJvb2wgY3R4KQo+ICsJCQkJICBjb25zdCBjaGFyICpuYW1lLCB1MzIgc2l6ZSwgYm9v
bCBjdHgpCj4gICB7Cj4gICAJc3RydWN0IHZpcnRpb19tbWlvX2RldmljZSAqdm1fZGV2ID0gdG9f
dmlydGlvX21taW9fZGV2aWNlKHZkZXYpOwo+ICAgCXN0cnVjdCB2aXJ0aW9fbW1pb192cV9pbmZv
ICppbmZvOwo+IEBAIC0zODIsOCArMzgyLDExIEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2
bV9zZXR1cF92cShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgdW5zaWduZWQgaW5kZXgsCj4g
ICAJCWdvdG8gZXJyb3JfbmV3X3ZpcnRxdWV1ZTsKPiAgIAl9Cj4gICAKPiArCWlmICghc2l6ZSB8
fCBzaXplID4gbnVtKQo+ICsJCXNpemUgPSBudW07Cj4gKwo+ICAgCS8qIENyZWF0ZSB0aGUgdnJp
bmcgKi8KPiAtCXZxID0gdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZShpbmRleCwgbnVtLCBWSVJUSU9f
TU1JT19WUklOR19BTElHTiwgdmRldiwKPiArCXZxID0gdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZShp
bmRleCwgc2l6ZSwgVklSVElPX01NSU9fVlJJTkdfQUxJR04sIHZkZXYsCj4gICAJCQkJIHRydWUs
IHRydWUsIGN0eCwgdm1fbm90aWZ5LCBjYWxsYmFjaywgbmFtZSk7Cj4gICAJaWYgKCF2cSkgewo+
ICAgCQllcnIgPSAtRU5PTUVNOwo+IEBAIC00ODQsNiArNDg3LDcgQEAgc3RhdGljIGludCB2bV9m
aW5kX3ZxcyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgdW5zaWduZWQgbnZxcywKPiAgIAkJ
fQo+ICAgCj4gICAJCXZxc1tpXSA9IHZtX3NldHVwX3ZxKHZkZXYsIHF1ZXVlX2lkeCsrLCBjYWxs
YmFja3NbaV0sIG5hbWVzW2ldLAo+ICsJCQkJICAgICBzaXplcyA/IHNpemVzW2ldIDogMCwKPiAg
IAkJCQkgICAgIGN0eCA/IGN0eFtpXSA6IGZhbHNlKTsKPiAgIAkJaWYgKElTX0VSUih2cXNbaV0p
KSB7Cj4gICAJCQl2bV9kZWxfdnFzKHZkZXYpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
