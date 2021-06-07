Return-Path: <SRS0=jANb=LB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0160C4743E
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 02:12:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 236BB6115B
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 02:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236BB6115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E556F605DC;
	Mon,  7 Jun 2021 02:12:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rjGeaIjT0AiA; Mon,  7 Jun 2021 02:12:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99BA1605BC;
	Mon,  7 Jun 2021 02:12:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 821EDC000E;
	Mon,  7 Jun 2021 02:12:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C85EAC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:12:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A8A0040329
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:12:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V6XwVMDjYPCH
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:12:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B52434033E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623031932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1GHvZi0Hu8bvsfMDpX0vr7h/j/v59gu9iThhVOJvcjU=;
 b=dHwqgLtKVkn8/R3i08iGd4/MCMkzcR1EgyaOdDqc1cPSIHL54fxwXoGLxkRjBL6Pbg9q+r
 qWPa4HzhHVMR/uyLc6C9Ul/ytwwAS6VSUjVlL4+XDsR/9tWFLHHuLKxU1TGpoVI+PaxwJC
 X9ihPD5fKRujyu4aoGd1jjyjMt1XzKQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-Qhn62yFTOY6Za5iL0i33GA-1; Sun, 06 Jun 2021 22:12:10 -0400
X-MC-Unique: Qhn62yFTOY6Za5iL0i33GA-1
Received: by mail-pj1-f70.google.com with SMTP id
 f15-20020a17090aa78fb029015c411f061bso11467840pjq.4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 06 Jun 2021 19:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=1GHvZi0Hu8bvsfMDpX0vr7h/j/v59gu9iThhVOJvcjU=;
 b=V0Y1oHnNXtRdovXDwzufrCecVkx8PBOo+4iXRiRTJHVCZNSH4KkqWhjaI/w0l20SQC
 SIPGJf6HtxmdO/5wA5MyjxE/vAzCoxuW26POvcBFLUQ8facd84gKEonlKI/4zzL0hLyF
 bBBV62rUSseAX7F/R6D6NMmsqOzqifAJsWSo31naXxAtmMYPnn94ZKffQmqCkX2xMCcU
 E0FzFKBALmvcF/o6SX/d8pho07HGfK800ROOk0rqJnzGXF2aPKGgPVL533A2gpNbtA1c
 jxbf5zDAt/0eTEp4eQw3hxHAClXFF/NirSAdIu0abeu0no7OnsHR/gwZ0tRq4FHWKOj0
 Xw1g==
X-Gm-Message-State: AOAM530g8Sk/6K/+OSB84nVgrG5I4Eb6ld8MjAL/UH1fTTMLG3aVsiM+
 Nz08BDZl7ulXtHtAQQ2xFowJ0jpE5VRkA4lJfSv16YLDgPygh3cZuQYMWSu47/CBg/F+ba60tqM
 /rykgwkL3ij9FsQfSPoK2xwDOopU4gQA1QxOGvJNt+w==
X-Received: by 2002:aa7:9491:0:b029:2ed:2787:be36 with SMTP id
 z17-20020aa794910000b02902ed2787be36mr8154616pfk.43.1623031929855; 
 Sun, 06 Jun 2021 19:12:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxk8i6NVq+YGcz1/Ru/wEpcsxv/kHrMFUEev1UCldIKwxQ4GZDyPeEjNVZOTCVY349/iC9K/Q==
X-Received: by 2002:aa7:9491:0:b029:2ed:2787:be36 with SMTP id
 z17-20020aa794910000b02902ed2787be36mr8154609pfk.43.1623031929662; 
 Sun, 06 Jun 2021 19:12:09 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id y138sm6935458pfc.11.2021.06.06.19.12.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Jun 2021 19:12:09 -0700 (PDT)
Subject: Re: [PATCH v2] vdpa/mlx5: Clear vq ready indication upon device reset
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210606053128.170399-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6f257eb1-c3ff-c17c-c937-7cc7f945f22d@redhat.com>
Date: Mon, 7 Jun 2021 10:12:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210606053128.170399-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

CtTaIDIwMjEvNi82IM/CzucxOjMxLCBFbGkgQ29oZW4g0LS1wDoKPiBBZnRlciBkZXZpY2UgcmVz
ZXQsIHRoZSB2aXJ0cXVldWVzIGFyZSBub3QgcmVhZHkgc28gY2xlYXIgdGhlIHJlYWR5Cj4gZmll
bGQuCj4KPiBGYWlsaW5nIHRvIGRvIHNvIGNhbiByZXN1bHQgaW4gdmlydGlvX3ZkcGEgZmFpbGlu
ZyB0byBsb2FkIGlmIHRoZSBkZXZpY2UKPiB3YXMgcHJldmlvdXNseSB1c2VkIGJ5IHZob3N0X3Zk
cGEgYW5kIHRoZSBvbGQgdmFsdWVzIGFyZSByZWFkeS4KPiB2aXJ0aW9fdmRwYSBleHBlY3RzIHRv
IGZpbmQgVlFzIGluICJub3QgcmVhZHkiIHN0YXRlLgo+Cj4gRml4ZXM6IDFhODZiMzc3YWEyMSAo
InZkcGEvbWx4NTogQWRkIFZEUEEgZHJpdmVyIGZvciBzdXBwb3J0ZWQgbWx4NSBkZXZpY2VzIikK
PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KCgpBY2tlZC1ieTog
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+IHYwIC0tPiB2MToKPiAg
ICAgTWFrZSBzdXJlIGNsZWFyIG9mIHJlYWR5IGlzIGRvbmUgb25seSBpbiByZXNldCBmbG93Cj4g
djEgLS0+IHYyOgo+ICAgICB1c2UgYXNjZW5kaW5nIGxvb3AgaXRlcmF0b3IgdG8gYXZvaWQgY29u
ZnVzaW9uCj4KPiAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDkgKysrKysr
KysrCj4gICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0
L21seDVfdm5ldC5jCj4gaW5kZXggMDJhMDU0OTIyMDRjLi5hNDJkYjU5MmU3YmIgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gKysrIGIvZHJpdmVycy92
ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gQEAgLTE3NjYsNiArMTc2NiwxNCBAQCBzdGF0aWMg
dm9pZCB0ZWFyZG93bl9kcml2ZXIoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4gICAJbXV0
ZXhfdW5sb2NrKCZuZGV2LT5yZXNsb2NrKTsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgdm9pZCBjbGVh
cl92cXNfcmVhZHkoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4gK3sKPiArCWludCBpOwo+
ICsKPiArCWZvciAoaSA9IDA7IGkgPCBuZGV2LT5tdmRldi5tYXhfdnFzOyBpKyspCj4gKwkJbmRl
di0+dnFzW2ldLnJlYWR5ID0gZmFsc2U7Cj4gK30KPiArCj4gICBzdGF0aWMgdm9pZCBtbHg1X3Zk
cGFfc2V0X3N0YXR1cyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU4IHN0YXR1cykKPiAgIHsK
PiAgIAlzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYgPSB0b19tdmRldih2ZGV2KTsKPiBAQCAt
MTc3Niw2ICsxNzg0LDcgQEAgc3RhdGljIHZvaWQgbWx4NV92ZHBhX3NldF9zdGF0dXMoc3RydWN0
IHZkcGFfZGV2aWNlICp2ZGV2LCB1OCBzdGF0dXMpCj4gICAJaWYgKCFzdGF0dXMpIHsKPiAgIAkJ
bWx4NV92ZHBhX2luZm8obXZkZXYsICJwZXJmb3JtaW5nIGRldmljZSByZXNldFxuIik7Cj4gICAJ
CXRlYXJkb3duX2RyaXZlcihuZGV2KTsKPiArCQljbGVhcl92cXNfcmVhZHkobmRldik7Cj4gICAJ
CW1seDVfdmRwYV9kZXN0cm95X21yKCZuZGV2LT5tdmRldik7Cj4gICAJCW5kZXYtPm12ZGV2LnN0
YXR1cyA9IDA7Cj4gICAJCW5kZXYtPm12ZGV2Lm1seF9mZWF0dXJlcyA9IDA7CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
