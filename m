Return-Path: <SRS0=fqYQ=LL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B876C49361
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 03:24:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0FC5613EA
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 03:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FC5613EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7CE960B5B;
	Thu, 17 Jun 2021 03:24:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hti6CvVOXS1p; Thu, 17 Jun 2021 03:24:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6D19760B52;
	Thu, 17 Jun 2021 03:24:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D2BBC000D;
	Thu, 17 Jun 2021 03:24:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D420CC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 03:24:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C1E5641480
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 03:24:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1kI8-GNOjm0A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 03:24:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 621CA4059F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 03:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623900248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P2YA3pPwX5KufYHZusNwV1Ms/tC5NgvQ2lY4eCYE9qw=;
 b=QSqNCHuEAtA3FhSjsUuZj94XJnk4KnbwRAPGKQ84qqNZoMwrn1TdOmaEdxTzKsnECcwXnT
 0xC2vipfpwaLKmcFNpJXTgpsvQZhHqbqBVidEgRxFJaG07iaKx7M8yCWEfZe40AyqYEZ/p
 VysM077xLk+2o2xODLN7m28bRZUz568=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-p1-mwnDJO6qPnRh0lZko2A-1; Wed, 16 Jun 2021 23:24:05 -0400
X-MC-Unique: p1-mwnDJO6qPnRh0lZko2A-1
Received: by mail-pf1-f197.google.com with SMTP id
 r15-20020a62e40f0000b02902ec871096d3so2887024pfh.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 20:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=P2YA3pPwX5KufYHZusNwV1Ms/tC5NgvQ2lY4eCYE9qw=;
 b=srwJ4moezeoA50rbrvO0viRG4IK9O0q2+aHj8A9WUuP3Xt412zZ7azo7wbY2F1ilMb
 QpPpNHgo9ju3WIA9/xTndqNDQsF/onhBQKutYFXddyYTrobOvSEXp8SWj3HMfJSYCAZA
 J5Ck4WiPdjyhVow7KzRBnhU9HMhlMGoflKpr0vwkIrTowxYh3h2vwojMy2OPYfZMXl1B
 r+jN81dCHEm8qCmr1HAc8v449IqFLs801DisUvxIsAM0fz+bVsSBwLYZ0AcxRYnsyAhm
 etK4GwGtea/LcH8yxve1OWtWeUYlicGqnYkJi4wQCBaQ9Bu6/0kSKN47Zr/rba+gLK8a
 /pLQ==
X-Gm-Message-State: AOAM531Vex/tRABxk3/WbiSjXelTjQCyxlNfYP6smxwqJZXmiKGzfjHA
 v27FyXW3qp5wDK9YE/ZigwKdRg/QmzHiqUWTZaKGmfNn5K0cUqymlbjnFkaYXXfAdAeEXiGN6wF
 Om6gGtUzGhnI3VW3Hn2En+pLIKo2HWYJvbIgNBZhKuQ==
X-Received: by 2002:a62:800d:0:b029:2f0:fe27:2935 with SMTP id
 j13-20020a62800d0000b02902f0fe272935mr3108407pfd.15.1623900244010; 
 Wed, 16 Jun 2021 20:24:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLsgZLhkeGRgsw9sNEy2BSQC7XLsAdd6KI8S9BIqhLUelD+ESONzXLb6Bkzo6ZqDFo4Y+zFQ==
X-Received: by 2002:a62:800d:0:b029:2f0:fe27:2935 with SMTP id
 j13-20020a62800d0000b02902f0fe272935mr3108370pfd.15.1623900243689; 
 Wed, 16 Jun 2021 20:24:03 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id y20sm3880550pfb.207.2021.06.16.20.23.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 20:24:03 -0700 (PDT)
Subject: Re: [PATCH net-next v5 13/15] virtio-net: support AF_XDP zc rx
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20210610082209.91487-1-xuanzhuo@linux.alibaba.com>
 <20210610082209.91487-14-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d036be55-6d85-f64c-21c5-926403e18ff4@redhat.com>
Date: Thu, 17 Jun 2021 11:23:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610082209.91487-14-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "dust . li" <dust.li@linux.alibaba.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

CtTaIDIwMjEvNi8xMCDPws7nNDoyMiwgWHVhbiBaaHVvINC0tcA6Cj4gQ29tcGFyZWQgdG8gdGhl
IGNhc2Ugb2YgeHNrIHR4LCB0aGUgY2FzZSBvZiB4c2sgemMgcnggaXMgbW9yZQo+IGNvbXBsaWNh
dGVkLgo+Cj4gV2hlbiB3ZSBwcm9jZXNzIHRoZSBidWYgcmVjZWl2ZWQgYnkgdnEsIHdlIG1heSBl
bmNvdW50ZXIgb3JkaW5hcnkKPiBidWZmZXJzLCBvciB4c2sgYnVmZmVycy4gV2hhdCBtYWtlcyB0
aGUgc2l0dWF0aW9uIG1vcmUgY29tcGxpY2F0ZWQgaXMKPiB0aGF0IGluIHRoZSBjYXNlIG9mIG1l
cmdlYWJsZSwgd2hlbiBudW1fYnVmZmVyID4gMSwgd2UgbWF5IHN0aWxsCj4gZW5jb3VudGVyIHRo
ZSBjYXNlIHdoZXJlIHhzayBidWZmZXIgaXMgbWl4ZWQgd2l0aCBvcmRpbmFyeSBidWZmZXIuCj4K
PiBBbm90aGVyIHRoaW5nIHRoYXQgbWFrZXMgdGhlIHNpdHVhdGlvbiBtb3JlIGNvbXBsaWNhdGVk
IGlzIHRoYXQgd2hlbiB3ZQo+IGdldCBhbiB4c2sgYnVmZmVyIGZyb20gdnEsIHRoZSB4c2sgYm91
bmQgdG8gdGhpcyB4c2sgYnVmZmVyIG1heSBoYXZlCj4gYmVlbiB1bmJvdW5kLgo+Cj4gU2lnbmVk
LW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KCgpUaGlzIGlz
IHNvbWVob3cgc2ltaWxhciB0byB0aGUgY2FzZSBvZiB0eCB3aGVyZSB3ZSBkb24ndCBoYXZlIHBl
ciB2cSByZXNldC4KClsuLi5dCgo+ICAgCj4gLQlpZiAodmktPm1lcmdlYWJsZV9yeF9idWZzKQo+
ICsJaWYgKGlzX3hza19jdHgoY3R4KSkKPiArCQlza2IgPSByZWNlaXZlX3hzayhkZXYsIHZpLCBy
cSwgYnVmLCBsZW4sIHhkcF94bWl0LCBzdGF0cyk7Cj4gKwllbHNlIGlmICh2aS0+bWVyZ2VhYmxl
X3J4X2J1ZnMpCj4gICAJCXNrYiA9IHJlY2VpdmVfbWVyZ2VhYmxlKGRldiwgdmksIHJxLCBidWYs
IGN0eCwgbGVuLCB4ZHBfeG1pdCwKPiAgIAkJCQkJc3RhdHMpOwo+ICAgCWVsc2UgaWYgKHZpLT5i
aWdfcGFja2V0cykKPiBAQCAtMTE3NSw2ICsxMjk2LDE0IEBAIHN0YXRpYyBib29sIHRyeV9maWxs
X3JlY3Yoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksIHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSwK
PiAgIAlpbnQgZXJyOwo+ICAgCWJvb2wgb29tOwo+ICAgCj4gKwkvKiBCZWNhdXNlIHZpcnRpby1u
ZXQgZG9lcyBub3QgeWV0IHN1cHBvcnQgZmxvdyBkaXJlY3QsCgoKTm90ZSB0aGF0IHRoaXMgaXMg
bm90IHRoZSBjYXNlIGFueSBtb3JlLiBSU1MgaGFzIGJlZW4gc3VwcG9ydGVkIGJ5IAp2aXJ0aW8g
c3BlYyBhbmQgcWVtdS92aG9zdC90YXAgbm93LiBXZSBqdXN0IG5lZWQgc29tZSB3b3JrIG9uIHRo
ZSAKdmlydGlvLW5ldCBkcml2ZXIgcGFydCAoZS5nIHRoZSBldGhvb2wgaW50ZXJmYWNlKS4KClRo
YW5rcwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
