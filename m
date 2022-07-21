Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BB0CCA488
	for <virtualization@archiver.kernel.org>; Thu, 21 Jul 2022 09:14:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E50F60EDA;
	Thu, 21 Jul 2022 09:14:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3E50F60EDA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VEsIW9UG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JSPEHUjISICd; Thu, 21 Jul 2022 09:14:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A6CD160D70;
	Thu, 21 Jul 2022 09:14:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A6CD160D70
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A26FC0033;
	Thu, 21 Jul 2022 09:14:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BB0CC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:14:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 34BCC405AC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:14:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 34BCC405AC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VEsIW9UG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BtuFyobaNU8T
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:14:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6483B4018F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6483B4018F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658394864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ppSpnW8bYqIzLlwJTJe7LMpqbChLBLEyuLzj0jwDOCg=;
 b=VEsIW9UG0RAFm0+Cpb6g4Up5yJk2fw5OXClI+Qq38VR8kXTeZtDqWJnab2lnGYSQJl/xMb
 NLXpSHIL3G28Z9+j7GCpjkaAKj0+ZhQ9wZYAQU3xijqLG6mUR48Ya3WQLV3cTwlD/nRjzf
 owSAS0web1ILpP11FEs0eTtH4uZCCpQ=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-SGHSyLM-Ox639tPEiIN8Sg-1; Thu, 21 Jul 2022 05:14:22 -0400
X-MC-Unique: SGHSyLM-Ox639tPEiIN8Sg-1
Received: by mail-pf1-f198.google.com with SMTP id
 a16-20020a056a001d1000b0052b39ee38c4so614245pfx.15
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 02:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ppSpnW8bYqIzLlwJTJe7LMpqbChLBLEyuLzj0jwDOCg=;
 b=DhHRhhNjEbOUJH+8XdgOckGyK37VSZAy2urnaYwASUz2rgZwxoFa0lQgX2ilP7nPjk
 GxD51Q00y4fQSkzcZmEihT4LSZCepBHEVxtI9rG1CdV2PSAKNK5unSdhjsiEpLM+vfC/
 8F/rkx3HNsZ1QcUfBPd3hK4ZNEkeLULE9BptAM8cD9GpI3ZHap6cZ+DLcsXcs/MUT7av
 IrC4Otagp2FiR87WeJLEakPllsTgiYXw/SYHfTnceYm9612dNC60Y+rFQt5tWnoY13Pr
 X3bCt+iAUlgbJCXHsurk5q1hffv6I8xtfHi6yTaxv5GW1x4MtAlzuoCyqXeiBv8MBKDT
 nSCg==
X-Gm-Message-State: AJIora8JNft1n5haKVvrhrMJPL99sC3a3OU07wEq2+BZwCvU3rN1CkCm
 /AlhjiqbqKpJQ8jpdHxqIrY1i7h/LGDSQy7BZfLU8sHPCO1nh3Houg8TAxf6xMB8khDR/kkgPY4
 ya/dN2udnOL6ga0Fy2RcINjQBfYcjAGdvfUHSouk4kA==
X-Received: by 2002:a17:902:ab0e:b0:16d:e87:ce8d with SMTP id
 ik14-20020a170902ab0e00b0016d0e87ce8dmr12288663plb.53.1658394861561; 
 Thu, 21 Jul 2022 02:14:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tdQQvXxoAsILo5kGUhAyFtFd7+hyXAVcy5eO+xsnDpHiLynC44NTrLJew4cMcMMUejlOtfhg==
X-Received: by 2002:a17:902:ab0e:b0:16d:e87:ce8d with SMTP id
 ik14-20020a170902ab0e00b0016d0e87ce8dmr12288621plb.53.1658394861264; 
 Thu, 21 Jul 2022 02:14:21 -0700 (PDT)
Received: from [10.72.12.47] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 l4-20020a170903244400b0016c454598b5sm1116942pls.167.2022.07.21.02.14.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Jul 2022 02:14:20 -0700 (PDT)
Message-ID: <da5ddf3b-3db7-7f25-a0f6-63a39e6af2a2@redhat.com>
Date: Thu, 21 Jul 2022 17:14:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v12 24/40] virtio: allow to unbreak/break virtqueue
 individually
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-25-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220720030436.79520-25-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjAgMTE6MDQsIFh1YW4gWmh1byDlhpnpgZM6Cj4gVGhpcyBwYXRjaCBhbGxv
d3MgdGhlIG5ldyBpbnRyb2R1Y2VkCj4gX192aXJ0cXVldWVfYnJlYWsoKS9fX3ZpcnRxdWV1ZV91
bmJyZWFrKCkgdG8gYnJlYWsvdW5icmVhayB0aGUKPiB2aXJ0cXVldWUuCj4KPiBTaWduZWQtb2Zm
LWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgoKCkFja2VkLWJ5OiBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKysrCj4gICBpbmNsdWRl
L2xpbnV4L3ZpcnRpby5oICAgICAgIHwgIDMgKysrCj4gICAyIGZpbGVzIGNoYW5nZWQsIDI3IGlu
c2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5j
IGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IGNmNDM3OTE3NTE2My4uYmY2
NjZkYWQ5OTA0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiAr
KysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTI3MzAsNiArMjczMCwzMCBA
QCB1bnNpZ25lZCBpbnQgdmlydHF1ZXVlX2dldF92cmluZ19zaXplKHN0cnVjdCB2aXJ0cXVldWUg
Kl92cSkKPiAgIH0KPiAgIEVYUE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9nZXRfdnJpbmdfc2l6
ZSk7Cj4gICAKPiArLyoKPiArICogVGhpcyBmdW5jdGlvbiBzaG91bGQgb25seSBiZSBjYWxsZWQg
YnkgdGhlIGNvcmUsIG5vdCBkaXJlY3RseSBieSB0aGUgZHJpdmVyLgo+ICsgKi8KPiArdm9pZCBf
X3ZpcnRxdWV1ZV9icmVhayhzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4gK3sKPiArCXN0cnVjdCB2
cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4gKwo+ICsJLyogUGFpcnMgd2l0aCBS
RUFEX09OQ0UoKSBpbiB2aXJ0cXVldWVfaXNfYnJva2VuKCkuICovCj4gKwlXUklURV9PTkNFKHZx
LT5icm9rZW4sIHRydWUpOwo+ICt9Cj4gK0VYUE9SVF9TWU1CT0xfR1BMKF9fdmlydHF1ZXVlX2Jy
ZWFrKTsKPiArCj4gKy8qCj4gKyAqIFRoaXMgZnVuY3Rpb24gc2hvdWxkIG9ubHkgYmUgY2FsbGVk
IGJ5IHRoZSBjb3JlLCBub3QgZGlyZWN0bHkgYnkgdGhlIGRyaXZlci4KPiArICovCj4gK3ZvaWQg
X192aXJ0cXVldWVfdW5icmVhayhzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4gK3sKPiArCXN0cnVj
dCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4gKwo+ICsJLyogUGFpcnMgd2l0
aCBSRUFEX09OQ0UoKSBpbiB2aXJ0cXVldWVfaXNfYnJva2VuKCkuICovCj4gKwlXUklURV9PTkNF
KHZxLT5icm9rZW4sIGZhbHNlKTsKPiArfQo+ICtFWFBPUlRfU1lNQk9MX0dQTChfX3ZpcnRxdWV1
ZV91bmJyZWFrKTsKPiArCj4gICBib29sIHZpcnRxdWV1ZV9pc19icm9rZW4oc3RydWN0IHZpcnRx
dWV1ZSAqX3ZxKQo+ICAgewo+ICAgCXN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZx
KF92cSk7Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvLmggYi9pbmNsdWRlL2xp
bnV4L3ZpcnRpby5oCj4gaW5kZXggNjJlMzFiY2E1NjAyLi5kNDVlZTgyYTQ0NzAgMTAwNjQ0Cj4g
LS0tIGEvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlv
LmgKPiBAQCAtMTM4LDYgKzEzOCw5IEBAIGJvb2wgaXNfdmlydGlvX2RldmljZShzdHJ1Y3QgZGV2
aWNlICpkZXYpOwo+ICAgdm9pZCB2aXJ0aW9fYnJlYWtfZGV2aWNlKHN0cnVjdCB2aXJ0aW9fZGV2
aWNlICpkZXYpOwo+ICAgdm9pZCBfX3ZpcnRpb191bmJyZWFrX2RldmljZShzdHJ1Y3QgdmlydGlv
X2RldmljZSAqZGV2KTsKPiAgIAo+ICt2b2lkIF9fdmlydHF1ZXVlX2JyZWFrKHN0cnVjdCB2aXJ0
cXVldWUgKl92cSk7Cj4gK3ZvaWQgX192aXJ0cXVldWVfdW5icmVhayhzdHJ1Y3QgdmlydHF1ZXVl
ICpfdnEpOwo+ICsKPiAgIHZvaWQgdmlydGlvX2NvbmZpZ19jaGFuZ2VkKHN0cnVjdCB2aXJ0aW9f
ZGV2aWNlICpkZXYpOwo+ICAgI2lmZGVmIENPTkZJR19QTV9TTEVFUAo+ICAgaW50IHZpcnRpb19k
ZXZpY2VfZnJlZXplKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpkZXYpOwoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
