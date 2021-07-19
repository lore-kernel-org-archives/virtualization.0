Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA57C12002
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 03:30:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21320610A2
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 03:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21320610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C984E400E0;
	Mon, 19 Jul 2021 03:30:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XzIEHjhzKd3l; Mon, 19 Jul 2021 03:30:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 343D0400D8;
	Mon, 19 Jul 2021 03:30:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4C98C0010;
	Mon, 19 Jul 2021 03:30:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA343C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 03:30:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9C1B56060F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 03:30:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u1y0RIxz0Uj5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 03:30:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 297B660608
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 03:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626665420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/8AXAqR0AohBpEbwcmGVsNxBi5Kp7RTSu2ilJlIpwRU=;
 b=KwbDYVgiE4QcbZ74wwzoy94+mnY5JGwJ00giQ1JLtZEJl/xtpBckEPenD5SirZ8p7RYu6h
 FrJxbUIZ2SLr8PgIi93b1uNr7lxuy4zPAcH2TtGntKHRucT969gA2miHm3FRba1qFX1LDs
 0GZHDiK9Bx0458HT+MyHwig6ZXP+/v0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-KE8U4n9kN8i7NfGACjSQxg-1; Sun, 18 Jul 2021 23:30:19 -0400
X-MC-Unique: KE8U4n9kN8i7NfGACjSQxg-1
Received: by mail-pg1-f198.google.com with SMTP id
 u190-20020a6379c70000b029022ceb8c8831so12249056pgc.22
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Jul 2021 20:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=/8AXAqR0AohBpEbwcmGVsNxBi5Kp7RTSu2ilJlIpwRU=;
 b=NAsHIRS+JCrjavImssgI7bFsxdI+qinYau6uL0fCFNlZsPIQyuwnqNVtErzySA2Slk
 +0ftD/HL4EqjPbb256HgVuYxXWk1PaGF2iOyQea2xfHoNDRtjsq31c7rshlYqWJebaY7
 TEsE80PqmntO623+1Hmu8EpbwxX0JnQLi2673y4Cy9m5QjEOLND+qDI1pTRIj/EO8c3u
 a1oGOYeXYhD1PfZGNf3e1x+up/N0omBLZjkozYS3C6wM8JbVn9Qw4g6AAwIigXz00X5A
 ymL6Hmbf4YxknVHTWXFSTINn7RPkwYjxT42LQmctyGcAj+KkjbGsFXeSxcCHNIbQOjei
 /3ug==
X-Gm-Message-State: AOAM530KNMucBEBwkH2FVMkeW8QavHT8cwLs9Y6O6XRqAws6MRQFxM8K
 LMzImFAkjp6ByQwsQ3hVPomJZ7cP+g3b1ZHW/R/bSg+43zQ9Oi5nImz4BTq5acKHIe3ybgC0HAV
 CvcTJQttcAAHTVaGZ8/SMk4CbEyME80eLtB0j4u7nzg==
X-Received: by 2002:aa7:8749:0:b029:2f1:3dd0:674 with SMTP id
 g9-20020aa787490000b02902f13dd00674mr23860563pfo.65.1626665417990; 
 Sun, 18 Jul 2021 20:30:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzD4b232b49HdYW9qUVvO5iv20zE2ujVm/gOCoi/jEoPMtqfZc0iUMGhKioUYZZPFxG721zzg==
X-Received: by 2002:aa7:8749:0:b029:2f1:3dd0:674 with SMTP id
 g9-20020aa787490000b02902f13dd00674mr23860547pfo.65.1626665417809; 
 Sun, 18 Jul 2021 20:30:17 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id u20sm4356864pjx.31.2021.07.18.20.30.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jul 2021 20:30:17 -0700 (PDT)
Subject: Re: [PATCH 1/2] vhost-vdpa: Fix integer overflow in
 vhost_vdpa_process_iotlb_update()
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 dan.carpenter@oracle.com
References: <20210716102239.96-1-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b6c93e88-0ba2-d07e-2597-e6935ab8de18@redhat.com>
Date: Mon, 19 Jul 2021 11:30:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716102239.96-1-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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

CtTaIDIwMjEvNy8xNiDPws7nNjoyMiwgWGllIFlvbmdqaSDQtLXAOgo+IFRoZSAibXNnLT5pb3Zh
ICsgbXNnLT5zaXplIiBhZGRpdGlvbiBjYW4gaGF2ZSBhbiBpbnRlZ2VyIG92ZXJmbG93Cj4gaWYg
dGhlIGlvdGxiIG1lc3NhZ2UgaXMgZnJvbSBhIG1hbGljaW91cyB1c2VyIHNwYWNlIGFwcGxpY2F0
aW9uLgo+IFNvIGxldCdzIGZpeCBpdC4KPgo+IEZpeGVzOiAxYjQ4ZGMwM2U1NzUgKCJ2aG9zdDog
dmRwYTogcmVwb3J0IGlvdmEgcmFuZ2UiKQo+IFJlcG9ydGVkLWJ5OiBEYW4gQ2FycGVudGVyIDxk
YW4uY2FycGVudGVyQG9yYWNsZS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogWGllIFlvbmdqaSA8eGll
eW9uZ2ppQGJ5dGVkYW5jZS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgMSArCj4gICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0
L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gaW5kZXggMjEwYWIzNWE3ZWJmLi44ZTNj
ODc5MGQ0OTMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPiArKysgYi9kcml2
ZXJzL3Zob3N0L3ZkcGEuYwo+IEBAIC02MTUsNiArNjE1LDcgQEAgc3RhdGljIGludCB2aG9zdF92
ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRlKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+ICAgCWludCBy
ZXQgPSAwOwo+ICAgCj4gICAJaWYgKG1zZy0+aW92YSA8IHYtPnJhbmdlLmZpcnN0IHx8Cj4gKwkg
ICAgbXNnLT5pb3ZhIC0gMSA+IFU2NF9NQVggLSBtc2ctPnNpemUgfHwKPiAgIAkgICAgbXNnLT5p
b3ZhICsgbXNnLT5zaXplIC0gMSA+IHYtPnJhbmdlLmxhc3QpCj4gICAJCXJldHVybiAtRUlOVkFM
Owo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
