Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69D5C6FD1F
	for <virtualization@archiver.kernel.org>; Wed, 15 Mar 2023 02:57:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2DAF581256;
	Wed, 15 Mar 2023 02:57:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2DAF581256
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TR15cx3D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YmWncqTo1kie; Wed, 15 Mar 2023 02:57:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3F51C81234;
	Wed, 15 Mar 2023 02:57:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3F51C81234
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FFDEC0071;
	Wed, 15 Mar 2023 02:57:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34FD4C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 02:57:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EFABB4088D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 02:57:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EFABB4088D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TR15cx3D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v1MPK2tlzYrB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 02:57:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B7C440888
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8B7C440888
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 02:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678849042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tGd7YEBxDPFa7UUFd+tiIotcx7IbA7J2cNC9Fqwezs0=;
 b=TR15cx3D6hvMyB5pncsWHk4t58cLgwAXZVTO07EF/8kOeF2YW2el4ew/ZPiA5FTljEU+mi
 I5xBRd7TwNZ3RalcqGbzWdVUaIHtLf7ARmZixhKQI+SQgYA0hriOYi6vRWX0Tr1NxkEZYb
 f8w4QxPgN9ylouU9FNpu5R8BGAymkac=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-VqRVMrZ4M-W2PiC2kRtPLQ-1; Tue, 14 Mar 2023 22:57:20 -0400
X-MC-Unique: VqRVMrZ4M-W2PiC2kRtPLQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 b8-20020aa78708000000b005eaa50faa35so9516853pfo.20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 19:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678849040;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tGd7YEBxDPFa7UUFd+tiIotcx7IbA7J2cNC9Fqwezs0=;
 b=exK3RAktt/FItK78BBbvv6fak66ZAZVw/l9g6/6C1SJ3qvp6KLgUaipOtWf4y+WAB3
 4CkdhjkPsbhALnoXP94c23KODpWjOl0uaSMqpfyi3R36jfD0UnW6JHdRC6Q9f8gi2TTN
 jHyPFKY6EQLY8bAKVnIXgxVYrsPj+dwm8PzAPpdNN0wRnGJtLJ9rqF5s4Y2glSXHIAUA
 6IPRCPA6G8TqqJFt/EIPnWzLX3SNkMeZ35cVqaZcAl6XBhbE0o9Hp0A/2D2FUMSdTdQa
 UCbjcclDklM3n8JdzEsS9Sh9Yeo4dqIZExv1H6j6fZaAAJ+WpcPl7EwtwYG26bMWq0Gl
 TcaQ==
X-Gm-Message-State: AO0yUKVItHMtx90MaQeO+02AkBqhp5FBXjHIa0VkWBUwO5RCBzepQEax
 LZqYZNGpApK3qC89bvrk+eKGmKsVqhXmRWe/Aj2htDEBFefrDDlQltf3/ac4JyvmN0s7jjppEWM
 tcserKfOijzYk7BzmI6syRcxjBeym5zUVMRhBzHkvyQ==
X-Received: by 2002:a05:6a21:6d9f:b0:cd:a334:a531 with SMTP id
 wl31-20020a056a216d9f00b000cda334a531mr49585661pzb.62.1678849039783; 
 Tue, 14 Mar 2023 19:57:19 -0700 (PDT)
X-Google-Smtp-Source: AK7set+eI1RkbSt4V7DkOgqQFxyi4/GgPTJMed7OB/sSprhV1srIQO4G7nTQt5zeb90UMUhnXKgK3A==
X-Received: by 2002:a05:6a21:6d9f:b0:cd:a334:a531 with SMTP id
 wl31-20020a056a216d9f00b000cda334a531mr49585643pzb.62.1678849039475; 
 Tue, 14 Mar 2023 19:57:19 -0700 (PDT)
Received: from [10.72.13.131] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 h17-20020aa786d1000000b005a9cb8edee3sm2286285pfo.85.2023.03.14.19.57.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Mar 2023 19:57:19 -0700 (PDT)
Message-ID: <15e30bb7-4744-d481-c7f1-b69749f062ac@redhat.com>
Date: Wed, 15 Mar 2023 10:56:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH vhost v2 11/12] virtio_ring: separate the logic of
 reset/enable from virtqueue_resize
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20230308064443.50639-1-xuanzhuo@linux.alibaba.com>
 <20230308064443.50639-12-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230308064443.50639-12-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

CuWcqCAyMDIzLzMvOCAxNDo0NCwgWHVhbiBaaHVvIOWGmemBkzoKPiBUaGUgc3Vic2VxdWVudCBy
ZXNldCBmdW5jdGlvbiB3aWxsIHJldXNlIHRoZXNlIGxvZ2ljLgo+Cj4gU2lnbmVkLW9mZi1ieTog
WHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KCgpBY2tlZC1ieTogSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKCj4gLS0tCj4gICBkcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jIHwgNTggKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRleCBhNzA1NDg1ZmVhNDcuLmYyNmJkN2JiZmY1ZSAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gKysrIGIvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBAIC0yMTU2LDYgKzIxNTYsNDMgQEAgc3RhdGljIGlu
dCB2aXJ0cXVldWVfcmVzaXplX3BhY2tlZChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsIHUzMiBudW0p
Cj4gICAJcmV0dXJuIC1FTk9NRU07Cj4gICB9Cj4gICAKPiArc3RhdGljIGludCB2aXJ0cXVldWVf
ZGlzYWJsZV9hbmRfcmVjeWNsZShzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gKwkJCQkJIHZvaWQg
KCpyZWN5Y2xlKShzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdm9pZCAqYnVmKSkKPiArewo+ICsJc3Ry
dWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsKPiArCXN0cnVjdCB2aXJ0aW9f
ZGV2aWNlICp2ZGV2ID0gdnEtPnZxLnZkZXY7Cj4gKwl2b2lkICpidWY7Cj4gKwlpbnQgZXJyOwo+
ICsKPiArCWlmICghdnEtPndlX293bl9yaW5nKQo+ICsJCXJldHVybiAtRVBFUk07Cj4gKwo+ICsJ
aWYgKCF2ZGV2LT5jb25maWctPmRpc2FibGVfdnFfYW5kX3Jlc2V0KQo+ICsJCXJldHVybiAtRU5P
RU5UOwo+ICsKPiArCWlmICghdmRldi0+Y29uZmlnLT5lbmFibGVfdnFfYWZ0ZXJfcmVzZXQpCj4g
KwkJcmV0dXJuIC1FTk9FTlQ7Cj4gKwo+ICsJZXJyID0gdmRldi0+Y29uZmlnLT5kaXNhYmxlX3Zx
X2FuZF9yZXNldChfdnEpOwo+ICsJaWYgKGVycikKPiArCQlyZXR1cm4gZXJyOwo+ICsKPiArCXdo
aWxlICgoYnVmID0gdmlydHF1ZXVlX2RldGFjaF91bnVzZWRfYnVmKF92cSkpICE9IE5VTEwpCj4g
KwkJcmVjeWNsZShfdnEsIGJ1Zik7Cj4gKwo+ICsJcmV0dXJuIDA7Cj4gK30KPiArCj4gK3N0YXRp
YyBpbnQgdmlydHF1ZXVlX2VuYWJsZV9hZnRlcl9yZXNldChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEp
Cj4gK3sKPiArCXN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4gKwlz
dHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiA9IHZxLT52cS52ZGV2Owo+ICsKPiArCWlmICh2ZGV2
LT5jb25maWctPmVuYWJsZV92cV9hZnRlcl9yZXNldChfdnEpKQo+ICsJCXJldHVybiAtRUJVU1k7
Cj4gKwo+ICsJcmV0dXJuIDA7Cj4gK30KPiAgIAo+ICAgLyoKPiAgICAqIEdlbmVyaWMgZnVuY3Rp
b25zIGFuZCBleHBvcnRlZCBzeW1ib2xzLgo+IEBAIC0yNzI2LDEzICsyNzYzLDggQEAgaW50IHZp
cnRxdWV1ZV9yZXNpemUoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLCB1MzIgbnVtLAo+ICAgCQkgICAg
IHZvaWQgKCpyZWN5Y2xlKShzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdm9pZCAqYnVmKSkKPiAgIHsK
PiAgIAlzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+IC0Jc3RydWN0
IHZpcnRpb19kZXZpY2UgKnZkZXYgPSB2cS0+dnEudmRldjsKPiAtCXZvaWQgKmJ1ZjsKPiAgIAlp
bnQgZXJyOwo+ICAgCj4gLQlpZiAoIXZxLT53ZV9vd25fcmluZykKPiAtCQlyZXR1cm4gLUVQRVJN
Owo+IC0KPiAgIAlpZiAobnVtID4gdnEtPnZxLm51bV9tYXgpCj4gICAJCXJldHVybiAtRTJCSUc7
Cj4gICAKPiBAQCAtMjc0MiwyOCArMjc3NCwxNiBAQCBpbnQgdmlydHF1ZXVlX3Jlc2l6ZShzdHJ1
Y3QgdmlydHF1ZXVlICpfdnEsIHUzMiBudW0sCj4gICAJaWYgKCh2cS0+cGFja2VkX3JpbmcgPyB2
cS0+cGFja2VkLnZyaW5nLm51bSA6IHZxLT5zcGxpdC52cmluZy5udW0pID09IG51bSkKPiAgIAkJ
cmV0dXJuIDA7Cj4gICAKPiAtCWlmICghdmRldi0+Y29uZmlnLT5kaXNhYmxlX3ZxX2FuZF9yZXNl
dCkKPiAtCQlyZXR1cm4gLUVOT0VOVDsKPiAtCj4gLQlpZiAoIXZkZXYtPmNvbmZpZy0+ZW5hYmxl
X3ZxX2FmdGVyX3Jlc2V0KQo+IC0JCXJldHVybiAtRU5PRU5UOwo+IC0KPiAtCWVyciA9IHZkZXYt
PmNvbmZpZy0+ZGlzYWJsZV92cV9hbmRfcmVzZXQoX3ZxKTsKPiArCWVyciA9IHZpcnRxdWV1ZV9k
aXNhYmxlX2FuZF9yZWN5Y2xlKF92cSwgcmVjeWNsZSk7Cj4gICAJaWYgKGVycikKPiAgIAkJcmV0
dXJuIGVycjsKPiAgIAo+IC0Jd2hpbGUgKChidWYgPSB2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9i
dWYoX3ZxKSkgIT0gTlVMTCkKPiAtCQlyZWN5Y2xlKF92cSwgYnVmKTsKPiAtCj4gICAJaWYgKHZx
LT5wYWNrZWRfcmluZykKPiAgIAkJZXJyID0gdmlydHF1ZXVlX3Jlc2l6ZV9wYWNrZWQoX3ZxLCBu
dW0pOwo+ICAgCWVsc2UKPiAgIAkJZXJyID0gdmlydHF1ZXVlX3Jlc2l6ZV9zcGxpdChfdnEsIG51
bSk7Cj4gICAKPiAtCWlmICh2ZGV2LT5jb25maWctPmVuYWJsZV92cV9hZnRlcl9yZXNldChfdnEp
KQo+IC0JCXJldHVybiAtRUJVU1k7Cj4gLQo+IC0JcmV0dXJuIGVycjsKPiArCXJldHVybiB2aXJ0
cXVldWVfZW5hYmxlX2FmdGVyX3Jlc2V0KF92cSk7Cj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MX0dQ
TCh2aXJ0cXVldWVfcmVzaXplKTsKPiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
