Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5758C433EF
	for <virtualization@archiver.kernel.org>; Mon, 17 Jan 2022 06:16:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64E0E40133;
	Mon, 17 Jan 2022 06:16:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id grTfOSVIcfyw; Mon, 17 Jan 2022 06:16:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 156C94011D;
	Mon, 17 Jan 2022 06:16:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB338C0039;
	Mon, 17 Jan 2022 06:16:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D283C002F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 06:16:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4156C401A2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 06:16:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AVuMpbtQYZle
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 06:16:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5312A400C1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 06:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642400212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ngjqbhd+I2RAGqYA3unyWdhIXjaBf9jaTXyUpAmiTbU=;
 b=F6JrHBsPzvrUXz1vjQQK5AOqQpKPkbN3cVHp101O4DNAsxCB3dvd8VcjgYF7ugkK1mJ+EB
 r82tOqUztqVEW7jeHCDTF6JgmskzrSVbrwtaD5B0gFJWacI87pWKgQ9ypXwSNBV51vItVn
 oxOL73hEfGYhUctN0SUYSvz+yxYoNzA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-FPKytMTrOjut0wJWW17H1g-1; Mon, 17 Jan 2022 01:16:51 -0500
X-MC-Unique: FPKytMTrOjut0wJWW17H1g-1
Received: by mail-pl1-f200.google.com with SMTP id
 p5-20020a170902bd0500b00148cb2d29ecso8525110pls.4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Jan 2022 22:16:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Ngjqbhd+I2RAGqYA3unyWdhIXjaBf9jaTXyUpAmiTbU=;
 b=Aeryap0El3WUoG52XqYoXg/YD04y9TA5OQx30ltDYGi578IhhND/wa1+uLlCS56AkR
 HYSENC40/lT8YdWdrfhNunpaVP50q6qJuvPqCCpzO7c/hWj74RdypTUluRha2bXiwVJi
 gPx4OM5OmOWDTPRF5Di44/Dvt1AQX3tXrh/aFN0lXSjgdHB5Pk/lntF3No2/ezmWySoC
 WoD8lazyIm0et5QcZnN/DkqblVLtGfh43l5PXUG26gXrWWLKfQ8qBXHsHUxlVrlsBwvr
 Eb5Ib32Se+aNJfacokobtp6NG0WAPjVAuA7suIYVbiZvTkXnyIzxyWRJ9MkM24az48kH
 M11Q==
X-Gm-Message-State: AOAM533c6sotBLpqVbz0eqSZnMCIdgySoUME+KjyFInMsm7YLbMvmakc
 Xzfp6+FNC8CWwHd+JnkjGgRX/urcx8g76zLBMD64GtVRg9VLMQeCqDDoNkQjexwJwDtsBaUu0jA
 +2uiM+28C1MRqACMVx06PebCA45ngiB9c+0leDX82Ng==
X-Received: by 2002:a05:6a00:b55:b0:4c1:3512:d20b with SMTP id
 p21-20020a056a000b5500b004c13512d20bmr19592224pfo.12.1642400210228; 
 Sun, 16 Jan 2022 22:16:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9G9qBf4rYS6kgY8uT90Aj62EDgIo/NWwD9KxTg6NfDLQx/bIGbYRqAoyJm5TbKzMGA/QZdQ==
X-Received: by 2002:a05:6a00:b55:b0:4c1:3512:d20b with SMTP id
 p21-20020a056a000b5500b004c13512d20bmr19592208pfo.12.1642400209949; 
 Sun, 16 Jan 2022 22:16:49 -0800 (PST)
Received: from [10.72.13.251] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id k13sm13113600pfc.60.2022.01.16.22.16.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jan 2022 22:16:49 -0800 (PST)
Message-ID: <7b292868-f875-f225-ab56-b6f140a6373a@redhat.com>
Date: Mon, 17 Jan 2022 14:16:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH] virtio: unexport virtio_finalize_features
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20220114195710.149933-1-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220114195710.149933-1-mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIyLzEvMTUg5LiK5Y2IMzo1NywgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiB2
aXJ0aW9fZmluYWxpemVfZmVhdHVyZXMgaXMgb25seSB1c2VkIGludGVybmFsbHkgd2l0aGluIHZp
cnRpby4KPiBObyByZWFzb24gdG8gZXhwb3J0IGl0Lgo+Cj4gU2lnbmVkLW9mZi1ieTogTWljaGFl
bCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvLmMgfCAz
ICstLQo+ICAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgfCAxIC0KPiAgIDIgZmlsZXMgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92aXJ0aW8vdmlydGlvLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW8uYwo+IGluZGV4IDAwYWM5
ZGI3OTJhNC4uZDg5MWIwYTM1NGIwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRp
by5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvLmMKPiBAQCAtMTY2LDcgKzE2Niw3IEBA
IHZvaWQgdmlydGlvX2FkZF9zdGF0dXMoc3RydWN0IHZpcnRpb19kZXZpY2UgKmRldiwgdW5zaWdu
ZWQgaW50IHN0YXR1cykKPiAgIH0KPiAgIEVYUE9SVF9TWU1CT0xfR1BMKHZpcnRpb19hZGRfc3Rh
dHVzKTsKPiAgIAo+IC1pbnQgdmlydGlvX2ZpbmFsaXplX2ZlYXR1cmVzKHN0cnVjdCB2aXJ0aW9f
ZGV2aWNlICpkZXYpCj4gK3N0YXRpYyBpbnQgdmlydGlvX2ZpbmFsaXplX2ZlYXR1cmVzKHN0cnVj
dCB2aXJ0aW9fZGV2aWNlICpkZXYpCj4gICB7Cj4gICAJaW50IHJldCA9IGRldi0+Y29uZmlnLT5m
aW5hbGl6ZV9mZWF0dXJlcyhkZXYpOwo+ICAgCXVuc2lnbmVkIHN0YXR1czsKPiBAQCAtMjAyLDcg
KzIwMiw2IEBAIGludCB2aXJ0aW9fZmluYWxpemVfZmVhdHVyZXMoc3RydWN0IHZpcnRpb19kZXZp
Y2UgKmRldikKPiAgIAl9Cj4gICAJcmV0dXJuIDA7Cj4gICB9Cj4gLUVYUE9SVF9TWU1CT0xfR1BM
KHZpcnRpb19maW5hbGl6ZV9mZWF0dXJlcyk7Cj4gICAKPiAgIHZvaWQgdmlydGlvX3Jlc2V0X2Rl
dmljZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2KQo+ICAgewo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L3ZpcnRpby5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+IGluZGV4IDcyMjky
YTYyY2Q5MC4uNTQ2NGYzOTg5MTJhIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlv
LmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gQEAgLTEzMyw3ICsxMzMsNiBAQCBi
b29sIGlzX3ZpcnRpb19kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2KTsKPiAgIHZvaWQgdmlydGlv
X2JyZWFrX2RldmljZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2KTsKPiAgIAo+ICAgdm9pZCB2
aXJ0aW9fY29uZmlnX2NoYW5nZWQoc3RydWN0IHZpcnRpb19kZXZpY2UgKmRldik7Cj4gLWludCB2
aXJ0aW9fZmluYWxpemVfZmVhdHVyZXMoc3RydWN0IHZpcnRpb19kZXZpY2UgKmRldik7Cj4gICAj
aWZkZWYgQ09ORklHX1BNX1NMRUVQCj4gICBpbnQgdmlydGlvX2RldmljZV9mcmVlemUoc3RydWN0
IHZpcnRpb19kZXZpY2UgKmRldik7Cj4gICBpbnQgdmlydGlvX2RldmljZV9yZXN0b3JlKHN0cnVj
dCB2aXJ0aW9fZGV2aWNlICpkZXYpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
