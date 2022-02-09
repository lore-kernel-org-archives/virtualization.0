Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A120C433F5
	for <virtualization@archiver.kernel.org>; Wed,  9 Feb 2022 05:41:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BF1104090A;
	Wed,  9 Feb 2022 05:41:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ds8i5Ahbe1NT; Wed,  9 Feb 2022 05:41:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 01146400CD;
	Wed,  9 Feb 2022 05:41:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA2B7C0011;
	Wed,  9 Feb 2022 05:41:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9652C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 05:41:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 98FFF60EC1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 05:41:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nXOZ6Es3g2fu
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 05:41:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AB48C60EC0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 05:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644385311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKphUtpJBcvwT3GQrOXUSizk13uf7SY936QiEWqygaM=;
 b=dxjfoErB0+exuXGjjXbYa7ei/HVs/Fe2O/Y0hjfvLE8Sg8C4eEmJHd0s6kzAsFclA/fBau
 vdZ7jDpy+pNhuxcs8uawpLScJv2AfSDByQFPpKvv65gNXW55mkHtOsajxKnDN5IoK8G16c
 fHItlghAaDD9p6Zebvd3sEXmp0wYE3Q=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45-s43l3Gx2NCaG6uJ7L8TXpQ-1; Wed, 09 Feb 2022 00:41:45 -0500
X-MC-Unique: s43l3Gx2NCaG6uJ7L8TXpQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 l9-20020a170903120900b0014a4205ebe3so1040553plh.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Feb 2022 21:41:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=dKphUtpJBcvwT3GQrOXUSizk13uf7SY936QiEWqygaM=;
 b=Gkmfnq4muoZZsLs2EKLRMTjUkl1k0CUtd0GtItX3TP/WThkICdlV/3Lk3bTvRUKO2f
 SQQu94X9KeW97tCGRzwR8jHSIgxp1+SnB9nPshXrBaKQC0S4zgjxyjLgLUocEpjLM7hw
 RWTP3QytLnvQgvzGkAZhZvdxz9DMa6hf6nvALVrdmyYVIAU08G0pVS+HyAl50z4t+P1V
 41Z46F1r1xbvUzcPltnlMJBDcL9gc2S1HtqX+MQdCU1qqRUG4Deh8KduY6Py32PVzY1u
 Zf4yrRSlsJG7RL8UArbys4qiCpZWfJ2P8BlEC7400bHZU/XMJ4GfxDH6d8AwFFMwbGQe
 287w==
X-Gm-Message-State: AOAM532TfCqrQtACKWZzh0itdsJk9kRzc+inqHqyiDlbdfrl8ehb5txX
 Z9JpmNWjxGxYc3mjq4BTlM4mL/RetTkA1jUD/Jz5nDLAKY7PbrosqLj2hIu2DLhATTkpheU6/Z9
 dd3uLo5ixKHXpppMISZdJY834NDbPgotYPeVzngmb3A==
X-Received: by 2002:a17:90b:3850:: with SMTP id
 nl16mr1622600pjb.131.1644385304513; 
 Tue, 08 Feb 2022 21:41:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzay6oWtdjb4LB2F6BtE6XSszk1Azb7VpPnr9e4Xq6zAtP7GUe68A2SMWO42AYmL05pn3TfJw==
X-Received: by 2002:a17:90b:3850:: with SMTP id
 nl16mr1622583pjb.131.1644385304257; 
 Tue, 08 Feb 2022 21:41:44 -0800 (PST)
Received: from [10.72.12.214] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z13sm18336691pfj.23.2022.02.08.21.41.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Feb 2022 21:41:43 -0800 (PST)
Message-ID: <3ab523ac-0ab5-5011-5328-e119840e1c07@redhat.com>
Date: Wed, 9 Feb 2022 13:41:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [RFC PATCH 0/5] TUN/VirtioNet USO features support.
To: Andrew Melnichenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>
References: <20220125084702.3636253-1-andrew@daynix.com>
 <1643183537.4001389-1-xuanzhuo@linux.alibaba.com>
 <CAOEp5OcwLiLZuVOAxx+pt6uztP-cGTgqsUSQj7N7HKTZgmyN3w@mail.gmail.com>
 <CABcq3pE43rYojwUCAmpW-FKv5=ABcS47B944Y-3kDqr-PeqLwQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CABcq3pE43rYojwUCAmpW-FKv5=ABcS47B944Y-3kDqr-PeqLwQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yan Vugenfirer <yan@daynix.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

CuWcqCAyMDIyLzIvOCDkuIvljYg5OjA5LCBBbmRyZXcgTWVsbmljaGVua28g5YaZ6YGTOgo+IEhp
IHBlb3BsZSwKPiBDYW4geW91IHBsZWFzZSByZXZpZXcgdGhpcyBzZXJpZXM/CgoKQXJlIHRoZXJl
IGFueSBwZXJmb3JtYW5jZSBudW1iZXIgdG8gZGVtb25zdHJhdGUgdGhlIGRpZmZlcmVuY2U/CgpU
aGFua3MKCgo+Cj4gT24gV2VkLCBKYW4gMjYsIDIwMjIgYXQgMTA6MzIgQU0gWXVyaSBCZW5kaXRv
dmljaAo+IDx5dXJpLmJlbmRpdG92aWNoQGRheW5peC5jb20+IHdyb3RlOgo+PiBPbiBXZWQsIEph
biAyNiwgMjAyMiBhdCA5OjU0IEFNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5j
b20+IHdyb3RlOgo+Pj4gT24gVHVlLCAyNSBKYW4gMjAyMiAxMDo0Njo1NyArMDIwMCwgQW5kcmV3
IE1lbG55Y2hlbmtvIDxhbmRyZXdAZGF5bml4LmNvbT4gd3JvdGU6Cj4+Pj4gQWRkZWQgbmV3IG9m
ZmxvYWRzIGZvciBUVU4gZGV2aWNlcyBUVU5fRl9VU080IGFuZCBUVU5fRl9VU082Lgo+Pj4+IFRl
Y2huaWNhbGx5IHRoZXkgZW5hYmxlIE5FVElGX0ZfR1NPX1VEUF9MNAo+Pj4+IChhbmQgb25seSBp
ZiBVU080ICYgVVNPNiBhcmUgc2V0IHNpbXVsdGFuZW91c2x5KS4KPj4+PiBJdCBhbGxvd3MgdG8g
dHJhbnNtaXNzaW9uIG9mIGxhcmdlIFVEUCBwYWNrZXRzLgo+Pj4+Cj4+Pj4gRGlmZmVyZW50IGZl
YXR1cmVzIFVTTzQgYW5kIFVTTzYgYXJlIHJlcXVpcmVkIGZvciBxZW11IHdoZXJlIFdpbmRvd3Mg
Z3Vlc3RzIGNhbgo+Pj4+IGVuYWJsZSBkaXNhYmxlIFVTTyByZWNlaXZlcyBmb3IgSVB2NCBhbmQg
SVB2NiBzZXBhcmF0ZWx5Lgo+Pj4+IE9uIHRoZSBvdGhlciBzaWRlLCBMaW51eCBjYW4ndCByZWFs
bHkgZGlmZmVyZW50aWF0ZSBVU080IGFuZCBVU082LCBmb3Igbm93Lgo+Pj4+IEZvciBub3csIHRv
IGVuYWJsZSBVU08gZm9yIFRVTiBpdCByZXF1aXJlcyBlbmFibGluZyBVU080IGFuZCBVU082IHRv
Z2V0aGVyLgo+Pj4+IEluIHRoZSBmdXR1cmUsIHRoZXJlIHdvdWxkIGJlIGEgbWVjaGFuaXNtIHRv
IGNvbnRyb2wgVURQX0w0IEdTTyBzZXBhcmF0ZWx5Lgo+Pj4+Cj4+Pj4gVGVzdCBpdCBXSVAgUWVt
dSBodHRwczovL2dpdGh1Yi5jb20vZGF5bml4L3FlbXUvdHJlZS9EZXZfVVNPdjIKPj4+Pgo+Pj4+
IE5ldyB0eXBlcyBmb3IgVmlydGlvTmV0IGFscmVhZHkgb24gbWFpbGluZzoKPj4+PiBodHRwczov
L2xpc3RzLm9hc2lzLW9wZW4ub3JnL2FyY2hpdmVzL3ZpcnRpby1jb21tZW50LzIwMjExMC9tc2cw
MDAxMC5odG1sCj4+PiBTZWVtcyBsaWtlIHRoaXMgaGFzbid0IGJlZW4gdXB2b3RlZCB5ZXQuCj4+
Pgo+Pj4gICAgICAgICAgaHR0cHM6Ly9naXRodWIuY29tL29hc2lzLXRjcy92aXJ0aW8tc3BlYyN1
c2Utb2YtZ2l0aHViLWlzc3Vlcwo+PiBZZXMsIGNvcnJlY3QuIFRoaXMgaXMgYSByZWFzb24gd2h5
IHRoaXMgc2VyaWVzIG9mIHBhdGNoZXMgaXMgUkZDLgo+Pgo+Pj4gVGhhbmtzLgo+Pj4KPj4+PiBB
bHNvLCB0aGVyZSBpcyBhIGtub3duIGlzc3VlIHdpdGggdHJhbnNtaXR0aW5nIHBhY2thZ2VzIGJl
dHdlZW4gdHdvIGd1ZXN0cy4KPj4+PiBXaXRob3V0IGhhY2tzIHdpdGggc2tiJ3MgR1NPIC0gcGFj
a2FnZXMgYXJlIHN0aWxsIHNlZ21lbnRlZCBvbiB0aGUgaG9zdCdzIHBvc3Ryb3V0aW5nLgo+Pj4+
Cj4+Pj4gQW5kcmV3IE1lbG55Y2hlbmtvICg1KToKPj4+PiAgICB1YXBpL2xpbnV4L2lmX3R1bi5o
OiBBZGRlZCBuZXcgaW9jdGwgZm9yIHR1bi90YXAuCj4+Pj4gICAgZHJpdmVyL25ldC90dW46IEFk
ZGVkIGZlYXR1cmVzIGZvciBVU08uCj4+Pj4gICAgdWFwaS9saW51eC92aXJ0aW9fbmV0Lmg6IEFk
ZGVkIFVTTyB0eXBlcy4KPj4+PiAgICBsaW51eC92aXJ0aW9fbmV0Lmg6IEFkZGVkIFN1cHBvcnQg
Zm9yIEdTT19VRFBfTDQgb2ZmbG9hZC4KPj4+PiAgICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmM6
IEFkZGVkIFVTTyBzdXBwb3J0Lgo+Pj4+Cj4+Pj4gICBkcml2ZXJzL25ldC90YXAuYyAgICAgICAg
ICAgICAgIHwgMTggKysrKysrKysrKysrKysrKy0tCj4+Pj4gICBkcml2ZXJzL25ldC90dW4uYyAg
ICAgICAgICAgICAgIHwgMTUgKysrKysrKysrKysrKystCj4+Pj4gICBkcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMgICAgICAgIHwgMjIgKysrKysrKysrKysrKysrKysrLS0tLQo+Pj4+ICAgaW5jbHVk
ZS9saW51eC92aXJ0aW9fbmV0LmggICAgICB8IDExICsrKysrKysrKysrCj4+Pj4gICBpbmNsdWRl
L3VhcGkvbGludXgvaWZfdHVuLmggICAgIHwgIDMgKysrCj4+Pj4gICBpbmNsdWRlL3VhcGkvbGlu
dXgvdmlydGlvX25ldC5oIHwgIDQgKysrKwo+Pj4+ICAgNiBmaWxlcyBjaGFuZ2VkLCA2NiBpbnNl
cnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+Pj4+Cj4+Pj4gLS0KPj4+PiAyLjM0LjEKPj4+Pgo+
Pj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+Pj4g
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0Cj4+Pj4gVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKPj4+PiBodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
