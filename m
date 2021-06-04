Return-Path: <SRS0=Cwtm=K6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22708C47096
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 02:36:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCCE361406
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 02:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCE361406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99F076F94B;
	Fri,  4 Jun 2021 02:36:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S_8ewwLeoppv; Fri,  4 Jun 2021 02:36:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F75D6F945;
	Fri,  4 Jun 2021 02:36:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0686DC000D;
	Fri,  4 Jun 2021 02:36:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 019D7C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D6D4C40697
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:36:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U-NtPY0ojlCw
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:36:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0AEAA4061E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622774166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n6UjoDdlJiC6Yn9pHe8qyqTWIaVoNYoyg0T0P15ZZCk=;
 b=B9T7QQaEEZu6ag51U2Y7ycqtRGhNTef8hvw9r6FOo5O7aPtrTVG8w25pH2W26RSv84ec2L
 VnX03UePi823h0JAxA8jUR2A7XHIBGkDYdemdUoua7TPmFWxqB2LL4R+eWjFWEWHiG6CKF
 6Aw9K/QrA5XwBI9e5222fGbGpqY0tzk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-T39o6pdFN_qDaWPeJEvnbw-1; Thu, 03 Jun 2021 22:36:04 -0400
X-MC-Unique: T39o6pdFN_qDaWPeJEvnbw-1
Received: by mail-pl1-f198.google.com with SMTP id
 o12-20020a170902778cb02900ff01bc1ddbso3486228pll.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Jun 2021 19:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=n6UjoDdlJiC6Yn9pHe8qyqTWIaVoNYoyg0T0P15ZZCk=;
 b=lgzkvsyZgsxK4Q2in0iv2h0Ul/cl0efimOECq5XpFLZ2wgkPRe3CyetweJ0ALsbn/O
 3LIzwe/8CN4BG4FWwQgo5PogpMlu/ecKVoxMEDCGSaDSwW4qgZ8DU0syzO7EOugmv/ra
 Yj4lvVPBols82S2e1qFH7NI4VuWKU5p3MBr7wRFX0iFTAVn/n6UOaezSKRVLPCW55cpX
 iCWMR6DJ9celyYxlTAA+HXlgAdxWCyvEmclazD7EAI3OedkvX8wfSsKNUXTeKpTmZQ/Q
 HoW4wYYy3dKIgrBvsIB8ABA7Dj7+Evk1d1VoOgWRbAabIkBeX7dPWG2PBYis3pIwBbvy
 2sgw==
X-Gm-Message-State: AOAM530ifhHpH2EqjGwXsAP98wFdxb58rzmE+T8Lf6UIj+wGQCX0D6ej
 6AH+A9/nG2UUCGoAF7YxuVKeala9bekBxWBdGqZNXiXQJWmzdXZMvbnpaWclDC0qj6tqNXvFw2m
 NyrPtZXsGMV0fdFGhMa89VfTs01tVNFEOuHB7nDrlsg==
X-Received: by 2002:a17:90b:4d86:: with SMTP id
 oj6mr14439094pjb.41.1622774163499; 
 Thu, 03 Jun 2021 19:36:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOvO94kC9a5yxmAdnPqn6EgGnSeSnL9Vn9YzNj8RL5DzWTWWDt9P02tNGSg/9icFWwvCQ9fA==
X-Received: by 2002:a17:90b:4d86:: with SMTP id
 oj6mr14439081pjb.41.1622774163299; 
 Thu, 03 Jun 2021 19:36:03 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id y205sm322100pfb.53.2021.06.03.19.36.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 19:36:02 -0700 (PDT)
Subject: Re: [PATCH] vdp/mlx5: Fix setting the correct dma_device
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210603112215.69259-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <864e8d21-22d4-7735-817b-f88ec0126f87@redhat.com>
Date: Fri, 4 Jun 2021 10:35:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603112215.69259-1-elic@nvidia.com>
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

CtTaIDIwMjEvNi8zIM/Czuc3OjIyLCBFbGkgQ29oZW4g0LS1wDoKPiBCZWZvcmUgU0Ygc3VwcG9y
dCB3YXMgaW50cm9kdWNlZCwgdGhlIERNQSBkZXZpY2Ugd2FzIGVxdWFsIHRvCj4gbWRldi0+ZGV2
aWNlIHdoaWNoIHdhcyBpbiBlc3NlbmNlIGVxdWFsIHRvIHBkZXYtPmRldjsKPiBXaXRoIFNGIGlu
dHJvZHVjdGlvbiB0aGlzIGlzIG5vIGxvbmdlciB0cnVlLiBJdCBoYXMgYWxyZWFkeSBiZWVuCj4g
aGFuZGxlZCBmb3Igdmhvc3RfdmRwYSBzaW5jZSB0aGUgcmVmZXJlbmNlIHRvIHRoZSBkbWEgZGV2
aWNlIGNhbiBmcm9tCj4gd2l0aGluIG1seDVfdmRwYS4gV2l0aCB2aXJ0aW9fdmRwYSB0aGlzIGJy
b2tlLiBUbyBmaXggdGhpcyB3ZSBzZXQgdGhlCj4gcmVhbCBkbWEgZGV2aWNlIHdoZW4gaW5pdGlh
bGl6aW5nIHRoZSBkZXZpY2UuCj4KPiBGaXhlczogMWE4NmIzNzdhYTIxICgidmRwYS9tbHg1OiBB
ZGQgVkRQQSBkcml2ZXIgZm9yIHN1cHBvcnRlZCBtbHg1IGRldmljZXMiKQoKCk5vdGUgc3VyZSB0
aGlzIGlzIGNvcnJlY3QsIGFjY29yZGluZyB0byB0aGUgY29tbWl0IGxvZyBpdCBzaG91bGQgYmUg
dGhlIApwYXRjaCB0aGF0IGludHJvZHVjZXMgdGhlIFNGIG9yIGF1eCBidXMgc3VwcG9ydCBmb3Ig
dkRQQS4KCgo+IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPgoKClBh
dGNoIGxvb2tzIGNvcnJlY3QuCgpUaGFua3MKCgo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21s
eDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gaW5kZXggYmMz
M2YyYzUyM2QzLi5hNGZmMTU4MTgxZTAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jCj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5j
Cj4gQEAgLTIwNDYsNyArMjA0Niw3IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX2Rldl9hZGQoc3Ry
dWN0IHZkcGFfbWdtdF9kZXYgKnZfbWRldiwgY29uc3QgY2hhciAqbmFtZSkKPiAgIAlpZiAoZXJy
KQo+ICAgCQlnb3RvIGVycl9tdHU7Cj4gICAKPiAtCW12ZGV2LT52ZGV2LmRtYV9kZXYgPSBtZGV2
LT5kZXZpY2U7Cj4gKwltdmRldi0+dmRldi5kbWFfZGV2ID0gJm1kZXYtPnBkZXYtPmRldjsKPiAg
IAllcnIgPSBtbHg1X3ZkcGFfYWxsb2NfcmVzb3VyY2VzKCZuZGV2LT5tdmRldik7Cj4gICAJaWYg
KGVycikKPiAgIAkJZ290byBlcnJfbXR1OwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
