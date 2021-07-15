Return-Path: <SRS0=ciji=MH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A536C07E96
	for <virtualization@archiver.kernel.org>; Thu, 15 Jul 2021 08:09:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BABA860200
	for <virtualization@archiver.kernel.org>; Thu, 15 Jul 2021 08:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABA860200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9038C60773;
	Thu, 15 Jul 2021 08:09:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zkp_YuWWEbCo; Thu, 15 Jul 2021 08:09:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BF1746070A;
	Thu, 15 Jul 2021 08:09:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 998C9C0010;
	Thu, 15 Jul 2021 08:09:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1534C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 08:09:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E0CA640617
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 08:09:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YdmnqhKsMfB7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 08:09:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 05CD0400CC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 08:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626336572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tTv2CcseCDxm+mEU26speVoVdaOl+FWh69D3e5ssflE=;
 b=QcGSRcHt3/irL4cZ5l7WlP40ih/8Z6QMMKmcN/W2Dee/JNASgcSZHN3P2j0r83VAdcr1HN
 Dlzu7Bwn2SGyDs6FZTLA0qdPg43lkUq70J0XiHTWqwJiTR9ux7FGHNBvU9Hv8m+H3jbrvI
 QoB6jFRg9EywjW+rcegE217jXFKHebY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-9UYYqsrZNPeE80K2ftvdrw-1; Thu, 15 Jul 2021 04:09:31 -0400
X-MC-Unique: 9UYYqsrZNPeE80K2ftvdrw-1
Received: by mail-pf1-f198.google.com with SMTP id
 b10-20020a056a000ccab029032dc5f71f6aso3683024pfv.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 01:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=tTv2CcseCDxm+mEU26speVoVdaOl+FWh69D3e5ssflE=;
 b=IhFCX3GOXD87WMctgjo8GDS6+p7w8EwE6kxUn8X+8twaMaPuzcxd9tGXmytWVDS/PM
 KzyEuFyRSM8ba2Cmo2Q6UXrODSFWIifQy6mTHRWmG0dTI+uwlZu1kMpoJoN0DBedD73A
 Og4mJuB9Be8/nv5bka9bteKX3UqkzPwBd7BxsGEbbH0vJmPW6JkRlM9dtwBpF4M+R/nz
 89J/KNpu//IIHLMQ3ChKjNH5Hk//x6CFUD3yV7++/oLCFuo5mOJWbTHIK3+7gsrKvUI/
 V8YQf1ZsAmd43I10hJSI6Z2sgJt2BqfpDs4SPnzVLaAJ0Dxk3CMbFWQKSJd9wtHY+oNC
 NnEg==
X-Gm-Message-State: AOAM530oLHn3hvmjD3BgW6gn2Er9cIJhpqay7ITlBqUhv1JLD2ptvtfG
 38cxactrFsN1j+xxLpxuwPGFoBlE2FiJWkPxZHQAi62aaO9RBP7TKFyrshe7fAq+5AXV+7ugsFu
 mMDWJ+w5+oX4qt3Jjs3TuVE/OohGty3Wvgw0dQ+d69w==
X-Received: by 2002:aa7:8812:0:b029:32d:8252:fd0 with SMTP id
 c18-20020aa788120000b029032d82520fd0mr3420211pfo.48.1626336570744; 
 Thu, 15 Jul 2021 01:09:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy21oKk9puljREtI9aX+P7Nz+KeImlG5GM7dAEFtmMf3aeiR7RdthHXdo9KCW7otJEMQOSdww==
X-Received: by 2002:aa7:8812:0:b029:32d:8252:fd0 with SMTP id
 c18-20020aa788120000b029032d82520fd0mr3420184pfo.48.1626336570575; 
 Thu, 15 Jul 2021 01:09:30 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j20sm5350601pfc.203.2021.07.15.01.09.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jul 2021 01:09:30 -0700 (PDT)
Subject: Re: [PATCH 3/4] vDPA/ifcvf: Fix return value check for
 vdpa_alloc_device()
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 dan.carpenter@oracle.com
References: <20210715080026.242-1-xieyongji@bytedance.com>
 <20210715080026.242-3-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3f3f9594-6a79-1ddb-4c45-fd1304c7d398@redhat.com>
Date: Thu, 15 Jul 2021 16:09:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715080026.242-3-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

CtTaIDIwMjEvNy8xNSDPws7nNDowMCwgWGllIFlvbmdqaSDQtLXAOgo+IFRoZSB2ZHBhX2FsbG9j
X2RldmljZSgpIHJldHVybnMgYW4gZXJyb3IgcG9pbnRlciB1cG9uCj4gZmFpbHVyZSwgbm90IE5V
TEwuIFRvIGhhbmRsZSB0aGUgZmFpbHVyZSBjb3JyZWN0bHksIHRoaXMKPiByZXBsYWNlcyBOVUxM
IGNoZWNrIHdpdGggSVNfRVJSKCkgY2hlY2sgYW5kIHByb3BhZ2F0ZSB0aGUKPiBlcnJvciB1cHdh
cmRzLgo+Cj4gRml4ZXM6IDVhMjQxNGJjNDU0ZSAoInZpcnRpbzogSW50ZWwgSUZDIFZGIGRyaXZl
ciBmb3IgVkRQQSIpCj4gUmVwb3J0ZWQtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJA
b3JhY2xlLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRh
bmNlLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+
IC0tLQo+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8IDQgKystLQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIGIvZHJpdmVycy92ZHBhL2lmY3Zm
L2lmY3ZmX21haW4uYwo+IGluZGV4IDIxYjc4ZjFjZDUyMS4uMzUxYzZjZmIyNGMzIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPiArKysgYi9kcml2ZXJzL3Zk
cGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gQEAgLTQ5Myw5ICs0OTMsOSBAQCBzdGF0aWMgaW50IGlm
Y3ZmX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9p
ZCAqaWQpCj4gICAKPiAgIAlhZGFwdGVyID0gdmRwYV9hbGxvY19kZXZpY2Uoc3RydWN0IGlmY3Zm
X2FkYXB0ZXIsIHZkcGEsCj4gICAJCQkJICAgIGRldiwgJmlmY192ZHBhX29wcywgTlVMTCk7Cj4g
LQlpZiAoYWRhcHRlciA9PSBOVUxMKSB7Cj4gKwlpZiAoSVNfRVJSKGFkYXB0ZXIpKSB7Cj4gICAJ
CUlGQ1ZGX0VSUihwZGV2LCAiRmFpbGVkIHRvIGFsbG9jYXRlIHZEUEEgc3RydWN0dXJlIik7Cj4g
LQkJcmV0dXJuIC1FTk9NRU07Cj4gKwkJcmV0dXJuIFBUUl9FUlIoYWRhcHRlcik7Cj4gICAJfQo+
ICAgCj4gICAJcGNpX3NldF9tYXN0ZXIocGRldik7CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
