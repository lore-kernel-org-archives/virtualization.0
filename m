Return-Path: <SRS0=jkwN=O7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE47C433EF
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 03:06:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7599D6054F
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 03:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7599D6054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 108B8606E0;
	Mon, 11 Oct 2021 03:06:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u34RrRq0n_do; Mon, 11 Oct 2021 03:06:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8EB16605FD;
	Mon, 11 Oct 2021 03:06:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A43EC000F;
	Mon, 11 Oct 2021 03:06:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F659C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 03:06:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 117A14023C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 03:06:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SXTgENZGTW1Q
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 03:06:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1F63240124
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 03:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633921611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UQlWWNm8nIIxCQWMb6EGZQHK9gk6FB/0D1OfhEh8hqw=;
 b=KwJjzMoxfsXlrJq9kuxo3B4ujAtB5t+THvoQj95sVbuY0/B3HAXfNudBj69Dnze7yV5I73
 2vYfMd3Tbh/wMu/5Dj0mYcPK45ljwCaE0uMPF5TuuTFLOJhzPVsFXJjCjMKQQxAaTZTDBi
 KnjMZvXgIPpQ5ZmfGB3cZfEMS/HZveo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-XdWpwzxrNj-5d9flIkZN_w-1; Sun, 10 Oct 2021 23:06:49 -0400
X-MC-Unique: XdWpwzxrNj-5d9flIkZN_w-1
Received: by mail-pg1-f198.google.com with SMTP id
 n22-20020a6563d6000000b0029261ffde9bso6174169pgv.22
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Oct 2021 20:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=UQlWWNm8nIIxCQWMb6EGZQHK9gk6FB/0D1OfhEh8hqw=;
 b=NpwpaOkUxhooAId1bdX2fWRMp4STSTrMW/sWjJB1oIt736kl+B6rZ+THqmhx5Bkjvw
 S0f711B4JxntirMamwE/zzG5MKsM6zeW8+seLDezu5BRpE2szG4YIT7t23H6keY0mfDy
 Ob2I5LuxWUf+zHRvtUOVDYpO+Ci6iQrUFlvd7W1KcB4LMbE1A6KxJ3/46bv54UZdhWY3
 IryUZu4ig3Q8vr4Ajp5/H4FNmmkXCLVrDV2EyHjCX0hIfU+Vr5AW5yWfvYmMtATzMlpZ
 6XnE1jIlODjea09zL8wKH8IQ1rrxu4YS0ctc0Lw/H/v8hbsMqI4o8OpZrwpZsTfi8HPh
 l2xg==
X-Gm-Message-State: AOAM532xDFROWQLa3u1nTgepqicQkU8EcmTSNBIMgpaJfGZnwA4JxyYy
 C5oKQs7Jvj6wWXNJpSCR2FvzbU5HlTakV6GkmITmx+bRMNSvbE3RwS3KVJocgTMOcibuU4awJTH
 hbjeTfYALsl/d1evSYnHLUA0nyv1bmnxFp6SYk09MVA==
X-Received: by 2002:a17:903:2451:b0:13f:297b:829e with SMTP id
 l17-20020a170903245100b0013f297b829emr8976530pls.45.1633921608800; 
 Sun, 10 Oct 2021 20:06:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz522aC78Wz+FanCjWbLjzHnHSGJZv8uq5qq+u1k0QNh4wUny/4WSnXaCkLiou5iG+lw3yODA==
X-Received: by 2002:a17:903:2451:b0:13f:297b:829e with SMTP id
 l17-20020a170903245100b0013f297b829emr8976514pls.45.1633921608552; 
 Sun, 10 Oct 2021 20:06:48 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id a67sm5739308pfa.128.2021.10.10.20.06.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Oct 2021 20:06:48 -0700 (PDT)
Subject: Re: [PATCH v4 5/7] virtio_vdpa: setup correct vq size with callbacks
 get_vq_num_{max,min}
To: Wu Zongyong <wuzongyong@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
References: <cover.1632313398.git.wuzongyong@linux.alibaba.com>
 <cover.1632882380.git.wuzongyong@linux.alibaba.com>
 <e971b011b9224a4da4fcab6e904fcee0b7393ac6.1632882380.git.wuzongyong@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <514a4a6e-89d5-3200-bb31-3660389f5315@redhat.com>
Date: Mon, 11 Oct 2021 11:06:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e971b011b9224a4da4fcab6e904fcee0b7393ac6.1632882380.git.wuzongyong@linux.alibaba.com>
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

CtTaIDIwMjEvOS8yOSDPws7nMjoxMSwgV3UgWm9uZ3lvbmcg0LS1wDoKCj4gU2lnbmVkLW9mZi1i
eTogV3UgWm9uZ3lvbmcgPHd1em9uZ3lvbmdAbGludXguYWxpYmFiYS5jb20+CgoKQ29tbWl0IGxv
ZyBwbGVhc2UuCgoKPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgfCAyNSAr
KysrKysrKysrKysrKysrKysrKy0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fdmRwYS5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+IGluZGV4IDcyZWFlZjJj
YWViMS4uOGFhNGViZTJhMmEyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192
ZHBhLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4gQEAgLTE0NSw3ICsx
NDUsOCBAQCB2aXJ0aW9fdmRwYV9zZXR1cF92cShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwg
dW5zaWduZWQgaW50IGluZGV4LAo+ICAgCS8qIEFzc3VtZSBzcGxpdCB2aXJ0cXVldWUsIHN3aXRj
aCB0byBwYWNrZWQgaWYgbmVjZXNzYXJ5ICovCj4gICAJc3RydWN0IHZkcGFfdnFfc3RhdGUgc3Rh
dGUgPSB7MH07Cj4gICAJdW5zaWduZWQgbG9uZyBmbGFnczsKPiAtCXUzMiBhbGlnbiwgbnVtOwo+
ICsJdTMyIGFsaWduLCBtYXhfbnVtLCBtaW5fbnVtID0gMDsKPiArCWJvb2wgbWF5X3JlZHVjZV9u
dW0gPSB0cnVlOwo+ICAgCWludCBlcnI7Cj4gICAKPiAgIAlpZiAoIW5hbWUpCj4gQEAgLTE2Mywy
MiArMTY0LDM2IEBAIHZpcnRpb192ZHBhX3NldHVwX3ZxKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2
ZGV2LCB1bnNpZ25lZCBpbnQgaW5kZXgsCj4gICAJaWYgKCFpbmZvKQo+ICAgCQlyZXR1cm4gRVJS
X1BUUigtRU5PTUVNKTsKPiAgIAo+IC0JbnVtID0gb3BzLT5nZXRfdnFfbnVtX21heCh2ZHBhKTsK
PiAtCWlmIChudW0gPT0gMCkgewo+ICsJbWF4X251bSA9IG9wcy0+Z2V0X3ZxX251bV9tYXgodmRw
YSk7Cj4gKwlpZiAobWF4X251bSA9PSAwKSB7Cj4gICAJCWVyciA9IC1FTk9FTlQ7Cj4gICAJCWdv
dG8gZXJyb3JfbmV3X3ZpcnRxdWV1ZTsKPiAgIAl9Cj4gICAKPiArCWlmIChvcHMtPmdldF92cV9u
dW1fbWluKQo+ICsJCW1pbl9udW0gPSBvcHMtPmdldF92cV9udW1fbWluKHZkcGEpOwo+ICsJaWYg
KG1pbl9udW0gPiBtYXhfbnVtKSB7Cj4gKwkJZXJyID0gLUVOT0VOVDsKPiArCQlnb3RvIGVycm9y
X25ld192aXJ0cXVldWU7Cj4gKwl9CgoKSWYgd2UgcmVhbGx5IHdhbnQgdG8gZG8gdGhpcywgbGV0
J3MgbW92ZSB0aGlzIHRvIHZkcGEgY29yZSBkdXJpbmcgZGV2aWNlIApwcm9iaW5nLgoKT3IganVz
dCBsZWF2ZSBpdCBhcyBpcyAoZGV2aWNlIHJpc2sgaXRzZWxmKS4KClRoYW5rcwoKCj4gKwo+ICsJ
bWF5X3JlZHVjZV9udW0gPSAobWF4X251bSA9PSBtaW5fbnVtKSA/IGZhbHNlIDogdHJ1ZTsKPiAr
Cj4gICAJLyogQ3JlYXRlIHRoZSB2cmluZyAqLwo+ICAgCWFsaWduID0gb3BzLT5nZXRfdnFfYWxp
Z24odmRwYSk7Cj4gLQl2cSA9IHZyaW5nX2NyZWF0ZV92aXJ0cXVldWUoaW5kZXgsIG51bSwgYWxp
Z24sIHZkZXYsCj4gLQkJCQkgICAgdHJ1ZSwgdHJ1ZSwgY3R4LAo+ICsJdnEgPSB2cmluZ19jcmVh
dGVfdmlydHF1ZXVlKGluZGV4LCBtYXhfbnVtLCBhbGlnbiwgdmRldiwKPiArCQkJCSAgICB0cnVl
LCBtYXlfcmVkdWNlX251bSwgY3R4LAo+ICAgCQkJCSAgICB2aXJ0aW9fdmRwYV9ub3RpZnksIGNh
bGxiYWNrLCBuYW1lKTsKPiAgIAlpZiAoIXZxKSB7Cj4gICAJCWVyciA9IC1FTk9NRU07Cj4gICAJ
CWdvdG8gZXJyb3JfbmV3X3ZpcnRxdWV1ZTsKPiAgIAl9Cj4gICAKPiArCWlmICh2aXJ0cXVldWVf
Z2V0X3ZyaW5nX3NpemUodnEpIDwgbWluX251bSkgewo+ICsJCWVyciA9IC1FSU5WQUw7Cj4gKwkJ
Z290byBlcnJfdnE7Cj4gKwl9Cj4gKwo+ICAgCS8qIFNldHVwIHZpcnRxdWV1ZSBjYWxsYmFjayAq
Lwo+ICAgCWNiLmNhbGxiYWNrID0gdmlydGlvX3ZkcGFfdmlydHF1ZXVlX2NiOwo+ICAgCWNiLnBy
aXZhdGUgPSBpbmZvOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
