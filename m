Return-Path: <SRS0=2EET=LR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB48C4743C
	for <virtualization@archiver.kernel.org>; Wed, 23 Jun 2021 03:21:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A26560FDC
	for <virtualization@archiver.kernel.org>; Wed, 23 Jun 2021 03:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A26560FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 141C040604;
	Wed, 23 Jun 2021 03:21:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HGhnaYszoow6; Wed, 23 Jun 2021 03:21:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8ECAE405EC;
	Wed, 23 Jun 2021 03:21:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C2BEC0010;
	Wed, 23 Jun 2021 03:21:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57D5FC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 03:21:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D7B540602
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 03:21:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id apU3a-iG1Rta
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 03:21:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 47736405EC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 03:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624418505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zWlbc40C50LijiHCCJzyep6SiSEpW0rDy9NGBjdyYbA=;
 b=Rlat2dbE94UCODkowTP9Bx1Vr8TzaGKUmPxZSYQ0kdSAtUCIbIPHaNlIYJfHrwmBioszgF
 a7In0CQqH/DeIPy1aiaKs3k/PZPSeSTTNBr/bnzgazkYEo669f8kqU8xbldf+xNT/OHNaz
 IpLfzHQfelzmb10Sky2+xzq9PxokFoo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-YEMsZrmgO2GPIQ5gMIChTg-1; Tue, 22 Jun 2021 23:21:41 -0400
X-MC-Unique: YEMsZrmgO2GPIQ5gMIChTg-1
Received: by mail-pl1-f197.google.com with SMTP id
 z7-20020a1709028f87b02901204079e8d7so311983plo.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 20:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=zWlbc40C50LijiHCCJzyep6SiSEpW0rDy9NGBjdyYbA=;
 b=h8Uph3rVXWmZU4a/e2gMjaeRr6AJTZnkbvhQHQI5DXDzOaUdvudxummHKGZ2e2aGX7
 qEFC4x+BAdigcigQVydeSox09amT4CI7JqeXAAn+Y+rVZ8a6aEqCkMMe/px22wxQe7Qy
 OjCQTSdWzfeXNqAa1p3jodkPxAElFjREfb4z4afPA+T/CAkXbnhkC/wDOuh46kT+QkE5
 6vkhLpyyT9W+cUqt/VMugKKm0VpXDZ692Z5yg3HYbJBrtL1mTXCsAkPNZEuWdcjtdh9Q
 dX4LJZM3nbzERSzhsYobuQbQ2I+uDnqtn0844T3HYblEBj9zBru+cAGlHeRP1c9tHWqF
 XhEg==
X-Gm-Message-State: AOAM530+azNXxf+phVOr5tccZniByQg4PfhGJziDCjc6+0jV69Y/B9qv
 7f81lWIYGZjUEtniYJ8VOBbWKtmOgSgm1q0xP9zLQ3NTL38UjNvUa+73xlhP+KiPRp9u+QaW9Jy
 /ugxAF1/kF/QR4aeaP8aYcwFT3kCMtDFlTlxQ1UczSw==
X-Received: by 2002:a17:902:b7c9:b029:122:ee2d:25f1 with SMTP id
 v9-20020a170902b7c9b0290122ee2d25f1mr18442845plz.14.1624418500584; 
 Tue, 22 Jun 2021 20:21:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVf/8m6UPTzEYOWFv8UWW41KD4RglcuNWJjez0EQY1P5pso7Arv0qpZ5oVROBdBY5Sey953g==
X-Received: by 2002:a17:902:b7c9:b029:122:ee2d:25f1 with SMTP id
 v9-20020a170902b7c9b0290122ee2d25f1mr18442829plz.14.1624418500227; 
 Tue, 22 Jun 2021 20:21:40 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id y190sm656547pfc.85.2021.06.22.20.21.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jun 2021 20:21:39 -0700 (PDT)
Subject: Re: [PATCH] vringh: Use wiov->used to check for read/write desc order
To: Neeraj Upadhyay <neeraju@codeaurora.org>, mst@redhat.com
References: <1624361873-6097-1-git-send-email-neeraju@codeaurora.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1d7f1fb3-b22c-1ca9-0635-be3f14b97c4a@redhat.com>
Date: Wed, 23 Jun 2021 11:21:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1624361873-6097-1-git-send-email-neeraju@codeaurora.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

CtTaIDIwMjEvNi8yMiDPws7nNzozNywgTmVlcmFqIFVwYWRoeWF5INC0tcA6Cj4gQXMgaW92LT51
c2VkIGlzIGluY3JlbWVudGVkIHdoZW4gZGVzY3JpcHRvcnMgYXJlIHByb2Nlc3NlZAo+IGluIF9f
dnJpbmdoX2lvdigpLCB1c2UgaXQgdG8gY2hlY2sgZm9yIGluY29ycmVjdCByZWFkCj4gYW5kIHdy
aXRlIGRlc2NyaXB0b3Igb3JkZXIuCj4KPiBTaWduZWQtb2ZmLWJ5OiBOZWVyYWogVXBhZGh5YXkg
PG5lZXJhanVAY29kZWF1cm9yYS5vcmc+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmhvc3QvdnJpbmdoLmMgfCAyICstCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jIGIvZHJpdmVycy92aG9zdC92cmluZ2guYwo+
IGluZGV4IDRhZjhmYTIuLjE0ZTIwNDMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC92cmlu
Z2guYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMKPiBAQCAtMzU5LDcgKzM1OSw3IEBA
IF9fdnJpbmdoX2lvdihzdHJ1Y3QgdnJpbmdoICp2cmgsIHUxNiBpLAo+ICAgCQkJaW92ID0gd2lv
djsKPiAgIAkJZWxzZSB7Cj4gICAJCQlpb3YgPSByaW92Owo+IC0JCQlpZiAodW5saWtlbHkod2lv
diAmJiB3aW92LT5pKSkgewo+ICsJCQlpZiAodW5saWtlbHkod2lvdiAmJiB3aW92LT51c2VkKSkg
ewo+ICAgCQkJCXZyaW5naF9iYWQoIlJlYWRhYmxlIGRlc2MgJXAgYWZ0ZXIgd3JpdGFibGUiLAo+
ICAgCQkJCQkgICAmZGVzY3NbaV0pOwo+ICAgCQkJCWVyciA9IC1FSU5WQUw7CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
