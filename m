Return-Path: <SRS0=jkwN=O7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A62C433EF
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 03:10:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB4C460F38
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 03:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CB4C460F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84D93606CF;
	Mon, 11 Oct 2021 03:10:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qMHbFNZKeC_O; Mon, 11 Oct 2021 03:10:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2BAE5605C9;
	Mon, 11 Oct 2021 03:10:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6B1CC0011;
	Mon, 11 Oct 2021 03:10:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAA72C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 03:10:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8D8B280F63
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 03:10:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id klUly60nFj2H
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 03:10:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E79C480F61
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 03:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633921831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yd9mqmA+XqBl+2Vl/PPmxVFviKbrjRNGIbGC653bycI=;
 b=bGzSLENSl39swyWJdFJtZSKcKfRlCfIP57cXWnmMNgUHBk0tzAoMmeSGe2o+3vjCScUcb5
 R07n0KGrES0dGLEPG0D4m3K0fcb4+5qGsrwUZsekVQSIbbJslgWy308+bux7dVRxlQn/XS
 UD+rCGBqydrYXozwTnhnFis7B6brP2s=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-mq_0iRH0MKmiW0cHpRn5ig-1; Sun, 10 Oct 2021 23:10:30 -0400
X-MC-Unique: mq_0iRH0MKmiW0cHpRn5ig-1
Received: by mail-pf1-f200.google.com with SMTP id
 t79-20020a627852000000b0044d0ecd9f7aso711728pfc.13
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Oct 2021 20:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=yd9mqmA+XqBl+2Vl/PPmxVFviKbrjRNGIbGC653bycI=;
 b=2rfxx7u2cqUlXXeWN4Olef8UDBOk8ej5kxUmmbT+WqzOTI/5NMCDlYJAQR+7dMmozS
 DZv/C58TNaK/+RbWA08+G4Zt0ie/YF/EpKNbWpru334fkj9J3Wfkn7/lPxxSs1kD3o2O
 e5JKOuJvrXV8AiGvdYO9IJR5s3xXPKMkOLwjTBQrBNFzpBCMTWmoM45GKnSssJoChc2H
 juS3x3/YIxisV0OehFZwSkzlamHiwXXjrKidFHRhUTqnjVm0r1BghWrU0wCA4amQnxfk
 87fBMnl70uTSy895/NzTs1FUOV5fnKE42oZgMhFb9kiKroKjwzKM8OEbOAFWc9XbJnDN
 Txtw==
X-Gm-Message-State: AOAM532yV7ToqLSxyn9ZMqzY0AytPcNm6emcWsqnGRpIS3ApA3yISNDV
 SENQ+/p5PhXezjqF04w1SDy/4VQA+YDUbDuQMYUqGO2ObgwIoIV5hf/mTqKTYsugPPOCE8FZR0o
 exObzShELbGTTtsd8ULvpxO4uJn3hGjq9ggw6HPP9eQ==
X-Received: by 2002:a62:5101:0:b0:44c:5cc3:e088 with SMTP id
 f1-20020a625101000000b0044c5cc3e088mr23412400pfb.72.1633921829259; 
 Sun, 10 Oct 2021 20:10:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEzsnGNdIaAxv7GONPx2NpCt1Gtj9JzY56rJd0EHZgWk1YGd3Hvq1eCMjR+UJz648D//GagA==
X-Received: by 2002:a62:5101:0:b0:44c:5cc3:e088 with SMTP id
 f1-20020a625101000000b0044c5cc3e088mr23412382pfb.72.1633921828963; 
 Sun, 10 Oct 2021 20:10:28 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id x23sm5943140pfq.146.2021.10.10.20.10.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Oct 2021 20:10:28 -0700 (PDT)
Subject: Re: [PATCH v4 6/7] vdpa: add new attribute VDPA_ATTR_DEV_MIN_VQ_SIZE
To: Wu Zongyong <wuzongyong@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
References: <cover.1632313398.git.wuzongyong@linux.alibaba.com>
 <cover.1632882380.git.wuzongyong@linux.alibaba.com>
 <ab430c611c3d8074fddc6c4e0f747852678d6b3f.1632882380.git.wuzongyong@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ba47edba-3438-a2b6-1783-7a42c633df2a@redhat.com>
Date: Mon, 11 Oct 2021 11:10:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ab430c611c3d8074fddc6c4e0f747852678d6b3f.1632882380.git.wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: wei.yang1@linux.alibaba.com
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvOS8yOSDPws7nMjoxMSwgV3UgWm9uZ3lvbmcg0LS1wDoKPiBUaGlzIGF0dHJpYnV0
ZSBhZHZlcnRpc2VzIHRoZSBtaW4gdmFsdWUgb2YgdmlydHF1ZXVlIHNpemUuIFRoZSB2YWx1ZSBp
cwo+IDAgYnkgZGVmYXVsdC4KCgpJIHRoaW5rIDAgaXMgbm90IGEgY29ycmVjdCB2YWx1ZS4gSWYg
SSB1bmRlcnN0YW5kIHRoZSBzcGVjIGNvcnJlY3RseSwgaXQgCnNob3VsZCBiZSAxLgoKVGhhbmtz
CgoKPgo+IFNpZ25lZC1vZmYtYnk6IFd1IFpvbmd5b25nIDx3dXpvbmd5b25nQGxpbnV4LmFsaWJh
YmEuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL3ZkcGEuYyAgICAgICB8IDUgKysrKysKPiAg
IGluY2x1ZGUvdWFwaS9saW51eC92ZHBhLmggfCAxICsKPiAgIDIgZmlsZXMgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGEuYyBiL2RyaXZl
cnMvdmRwYS92ZHBhLmMKPiBpbmRleCAxZGMxMjFhMDdhOTMuLjZlZDc5ZmJhMzNlNCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYS5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGEuYwo+
IEBAIC00OTIsNiArNDkyLDcgQEAgdmRwYV9kZXZfZmlsbChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZk
ZXYsIHN0cnVjdCBza19idWZmICptc2csIHUzMiBwb3J0aWQsIHUzMiBzZXEKPiAgIAkgICAgICBp
bnQgZmxhZ3MsIHN0cnVjdCBuZXRsaW5rX2V4dF9hY2sgKmV4dGFjaykKPiAgIHsKPiAgIAl1MTYg
bWF4X3ZxX3NpemU7Cj4gKwl1MTYgbWluX3ZxX3NpemUgPSAwOwo+ICAgCXUzMiBkZXZpY2VfaWQ7
Cj4gICAJdTMyIHZlbmRvcl9pZDsKPiAgIAl2b2lkICpoZHI7Cj4gQEAgLTUwOCw2ICs1MDksOCBA
QCB2ZHBhX2Rldl9maWxsKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgc3RydWN0IHNrX2J1ZmYg
Km1zZywgdTMyIHBvcnRpZCwgdTMyIHNlcQo+ICAgCWRldmljZV9pZCA9IHZkZXYtPmNvbmZpZy0+
Z2V0X2RldmljZV9pZCh2ZGV2KTsKPiAgIAl2ZW5kb3JfaWQgPSB2ZGV2LT5jb25maWctPmdldF92
ZW5kb3JfaWQodmRldik7Cj4gICAJbWF4X3ZxX3NpemUgPSB2ZGV2LT5jb25maWctPmdldF92cV9u
dW1fbWF4KHZkZXYpOwo+ICsJaWYgKHZkZXYtPmNvbmZpZy0+Z2V0X3ZxX251bV9taW4pCj4gKwkJ
bWluX3ZxX3NpemUgPSB2ZGV2LT5jb25maWctPmdldF92cV9udW1fbWluKHZkZXYpOwo+ICAgCj4g
ICAJZXJyID0gLUVNU0dTSVpFOwo+ICAgCWlmIChubGFfcHV0X3N0cmluZyhtc2csIFZEUEFfQVRU
Ul9ERVZfTkFNRSwgZGV2X25hbWUoJnZkZXYtPmRldikpKQo+IEBAIC01MjAsNiArNTIzLDggQEAg
dmRwYV9kZXZfZmlsbChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHN0cnVjdCBza19idWZmICpt
c2csIHUzMiBwb3J0aWQsIHUzMiBzZXEKPiAgIAkJZ290byBtc2dfZXJyOwo+ICAgCWlmIChubGFf
cHV0X3UxNihtc2csIFZEUEFfQVRUUl9ERVZfTUFYX1ZRX1NJWkUsIG1heF92cV9zaXplKSkKPiAg
IAkJZ290byBtc2dfZXJyOwo+ICsJaWYgKG5sYV9wdXRfdTE2KG1zZywgVkRQQV9BVFRSX0RFVl9N
SU5fVlFfU0laRSwgbWluX3ZxX3NpemUpKQo+ICsJCWdvdG8gbXNnX2VycjsKPiAgIAo+ICAgCWdl
bmxtc2dfZW5kKG1zZywgaGRyKTsKPiAgIAlyZXR1cm4gMDsKPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS91YXBpL2xpbnV4L3ZkcGEuaCBiL2luY2x1ZGUvdWFwaS9saW51eC92ZHBhLmgKPiBpbmRleCA2
NmE0MWU0ZWMxNjMuLmUzYjg3ODc5NTE0YyAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGlu
dXgvdmRwYS5oCj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZkcGEuaAo+IEBAIC0zMiw2ICsz
Miw3IEBAIGVudW0gdmRwYV9hdHRyIHsKPiAgIAlWRFBBX0FUVFJfREVWX1ZFTkRPUl9JRCwJCS8q
IHUzMiAqLwo+ICAgCVZEUEFfQVRUUl9ERVZfTUFYX1ZRUywJCQkvKiB1MzIgKi8KPiAgIAlWRFBB
X0FUVFJfREVWX01BWF9WUV9TSVpFLAkJLyogdTE2ICovCj4gKwlWRFBBX0FUVFJfREVWX01JTl9W
UV9TSVpFLAkJLyogdTE2ICovCj4gICAKPiAgIAkvKiBuZXcgYXR0cmlidXRlcyBtdXN0IGJlIGFk
ZGVkIGFib3ZlIGhlcmUgKi8KPiAgIAlWRFBBX0FUVFJfTUFYLAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
