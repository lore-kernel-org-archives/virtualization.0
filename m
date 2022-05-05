Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4EEC433F5
	for <virtualization@archiver.kernel.org>; Thu,  5 May 2022 08:14:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74BB24194D;
	Thu,  5 May 2022 08:14:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3OGoUcqR-eak; Thu,  5 May 2022 08:14:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C278341906;
	Thu,  5 May 2022 08:14:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92A7DC0032;
	Thu,  5 May 2022 08:14:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AF84C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:14:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 868E160E48
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:14:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B4eLenpEhOfg
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:14:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [170.10.129.74])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 40C3F60D71
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651738475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GqkF1KE8HpAmQB4r+M2R5O0GOtheHQHEI+M7f5J9eiQ=;
 b=B0U0E7NK0QLVutyq0Lw3GgP4sMVP0lxNm1/ySKQsf4rsodkPt+ytF5wC0pZK7ETtkoFBsf
 0py75C1Wp++TJtTJ6Fuhuw22IlGNNnsV2+GrL1tl1+SB0ycs65VG6I/ARLlsLIqw8cPz1R
 bZl7Arsku9zKWZuApgUBy8hL/5+zT5s=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-vEjIu5wwNDOaTBnuSgNqJg-1; Thu, 05 May 2022 04:14:34 -0400
X-MC-Unique: vEjIu5wwNDOaTBnuSgNqJg-1
Received: by mail-pg1-f198.google.com with SMTP id
 q143-20020a632a95000000b003c1c3490dfbso1848860pgq.20
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 May 2022 01:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=GqkF1KE8HpAmQB4r+M2R5O0GOtheHQHEI+M7f5J9eiQ=;
 b=52fLr4H+r4CwOBpGQFISyuKhNQTNRoKa8fRyMD9/pKuVt7UFm/GAVPtj/rzhPx0vyw
 nP35jAh6VvMqQyiaAeEvH9jWzpA86QF/XQzA+1oZowz93DC9kJ3QIpsk/lMX2SeG7/W8
 Rq7/q1j1NHxWMc6G0eBY3s0njfKykNnXVQcUTn6kFbV0qd/CLVV5XTuEemJPj3O5RvLs
 UElPGvfQZMESTo/XNYaRGx05cnPZx8J/LYGuZCual9XKyV3JMXG4IAqdBmaqdU46K1Io
 ySTJFeygSuBFawTOC4DaMwtA2d7XCd8hQAdoY/zt7Z3leM3dT1VZM3/fgW67b+AfYNNC
 P4Zw==
X-Gm-Message-State: AOAM530k8yIGu3ZjsPCrmU/g8Di/6a9pXdH7xnOHSj0cipzQd0pc0mWH
 FCuYkNmihuXO+fQOmSxE7B0MP1iiWzz7VMGOBseu18/BIFEWImnyku6D8V43IjjGr5tLIrvsh/A
 HkMimV9KW71ysw9jYWXzdrTxpWPTj0jtv0YJBATkFpA==
X-Received: by 2002:a17:902:f60c:b0:156:82c9:e44b with SMTP id
 n12-20020a170902f60c00b0015682c9e44bmr26008996plg.106.1651738472926; 
 Thu, 05 May 2022 01:14:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKcqfKIUUPplDvbeDmjS+7tfF7ZK8ifv0ssT8p8bQdwz6KKEmOnlHoAb/8OBDNJIL2fD47Dg==
X-Received: by 2002:a17:902:f60c:b0:156:82c9:e44b with SMTP id
 n12-20020a170902f60c00b0015682c9e44bmr26008973plg.106.1651738472663; 
 Thu, 05 May 2022 01:14:32 -0700 (PDT)
Received: from [10.72.13.116] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 d15-20020aa7868f000000b0050dc76281aesm742906pfo.136.2022.05.05.01.14.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 May 2022 01:14:32 -0700 (PDT)
Message-ID: <ad4c0688-6e4b-bc66-55c3-8d33493f7c8c@redhat.com>
Date: Thu, 5 May 2022 16:14:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 3/3] vdpa/mlx5: Add RX MAC VLAN filter support
To: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>
References: <20220411122942.225717-1-elic@nvidia.com>
 <20220411122942.225717-4-elic@nvidia.com>
 <eb381955-0a64-011f-2732-943c60541b18@redhat.com>
 <DM8PR12MB540032F367E9DB4C277AB946ABC19@DM8PR12MB5400.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <DM8PR12MB540032F367E9DB4C277AB946ABC19@DM8PR12MB5400.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

CuWcqCAyMDIyLzUvMiAxMzozOCwgRWxpIENvaGVuIOWGmemBkzoKPj4+ICtzdGF0aWMgdmlydGlv
X25ldF9jdHJsX2FjayBoYW5kbGVfY3RybF92bGFuKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRl
diwgdTggY21kKQo+Pj4gK3sKPj4+ICsJc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYgPSB0b19t
bHg1X3ZkcGFfbmRldihtdmRldik7Cj4+PiArCXZpcnRpb19uZXRfY3RybF9hY2sgc3RhdHVzID0g
VklSVElPX05FVF9FUlI7Cj4+PiArCXN0cnVjdCBtbHg1X2NvbnRyb2xfdnEgKmN2cSA9ICZtdmRl
di0+Y3ZxOwo+Pj4gKwlzdHJ1Y3QgdmlydGlvX25ldF9jdHJsX3ZsYW4gdmxhbjsKPj4+ICsJc2l6
ZV90IHJlYWQ7Cj4+PiArCXUxNiBpZDsKPj4+ICsKPj4+ICsJc3dpdGNoIChjbWQpIHsKPj4+ICsJ
Y2FzZSBWSVJUSU9fTkVUX0NUUkxfVkxBTl9BREQ6Cj4+PiArCQlyZWFkID0gdnJpbmdoX2lvdl9w
dWxsX2lvdGxiKCZjdnEtPnZyaW5nLCAmY3ZxLT5yaW92LCAodm9pZCAqKSZ2bGFuLCBzaXplb2Yo
dmxhbikpOwo+Pj4gKwkJaWYgKHJlYWQgIT0gc2l6ZW9mKHZsYW4pKQo+Pj4gKwkJCWJyZWFrOwo+
Pj4gKwo+Pj4gKwkJaWQgPSBtbHg1dmRwYTE2X3RvX2NwdShtdmRldiwgdmxhbi5pZCk7Cj4+PiAr
CQlpZiAobWFjX3ZsYW5fYWRkKG5kZXYsIG5kZXYtPmNvbmZpZy5tYWMsIGlkLCB0cnVlKSkKPj4+
ICsJCQlicmVhazsKPj4gVGhpcyBtYXkgd29yayBub3cgYnV0IEkgd29uZGVyIGlmIHdlIGhhZCB0
aGUgcGxhbiB0byBzdXBwb3J0Cj4+IFZJUlRJT19ORVRfRl9DVFJMX1JYPwo+Pgo+PiBpZiAkbWFj
IGlzIG5vdCBpbiAkbWFjX3RhYmxlCj4+ICAgwqDCoMKgIGRyb3A7Cj4+IGlmICR2bGFuIGlzIG5v
dCBpbiAkdmxhbl90YWJsZQo+PiAgIMKgwqDCoCBkcm9wOwo+Pgo+PiBXaXRoIHRoYXQgZmVhdHVy
ZXMgd2UgcHJvYmFibHkgcmVxdWlyZXMgdGhlIGRlZGljYXRlZCB2bGFuIGZpbHRlcnMKPj4gd2l0
aG91dCBhIG1hYz8gT3IgZG8gd2Ugd2FudCB0byBhICRtYWMgKiAkdmxhbnMgcnVsZXM/Cj4+Cj4+
IElmIHllcywgbWF5YmUgaXQncyBiZXR0ZXIgdG8gZGVjb3VwbGUgdmxhbiBmaWx0ZXJzIGZyb20g
bWFjIG5vdy4KPj4KPiBJZiB3ZSB1c2UgZGVkaWNhdGVkIGZpbHRlciB0YWJsZXMgZm9yIFZMQU4g
YW5kIE1BQyB3b3JraW5nIGluIHNlcmllcywKPiB3ZSBtYXkgbm90IGhhdmUgZnVsbCBjb250cm9s
IG92ZXIgaW5jb21pbmcgdHJhZmZpYyBmaWx0ZXJpbmcuCj4gRm9yIGV4YW1wbGUsIHN1cHBvc2Ug
d2UgaGF2ZSBWTEFOIHRhYmxlIGFsbG93aW5nIHYxIGFuZCB2MiB0byBnbyB0aHJvdWdoLAo+IGFu
ZCBhIE1BQyB0YWJsZSBhbGxvd2luZyBtMSBhbmQgbTIgdG8gZ28gdGhyb3VnaC4KPgo+IElmIHdl
IHdhbnQgb25seSAodjEsIG0xKSBhbmQgKHYyLCBtMikgdG8gZ28gdGhyb3VnaCBidXQgbm90ICh2
MSwgbTIpIG9yICh2MiwgbTEpCj4gdGhlbiBpdCB3b3VsZCBub3QgYmUgcG9zc2libGUgdG8gYmxv
Y2sgdGhlIGxhdHRlci4KCgpZZXMsIGJ1dCB0aGlzIGlzIGN1cnJlbnRseSBob3cgdmlydGlvLW5l
dCB3b3JrIGluIHRoZSBzcGVjLgoKCj4KPiBBcyBJIGNhbiBzZWUsIHRoZSBzcGVjIGRvZXMgbm90
IHJlcXVpcmUgdGhhdCBmaW5lc3NlCgoKWWVzLgoKCj4gICBidXQgSSB3b25kZXIgaWYgdGhpcyBu
b3QKPiB3aGF0IHJlYWwgbGlmZSByZXF1aXJlcy4KCgpUaGVuIHdlIG5lZWQgdG8gZXh0ZW5kIHRo
ZSBzcGVjLgoKCj4gSWYgeW91IHRoaW5rIHdlIHNob3VsZCBmb2xsb3cgdGhlIHNwZWMgbGV0IG1l
IGtub3cgYW5kIHdpbGwgcHJlcGFyZSBhIG5ldyB2ZXJzaW9uLgoKCkl0IHNob3VsZCBiZSBmaW5l
IG5vdy4gKEJ1dCBpZiB3ZSB3YW50IHRvbyBzdXBwb3J0IENUUkxfUlggd2UgbmVlZCBzb21lIApy
ZWZhY3RvcmluZyBvbiB0aGUgY29kZXMpLgoKU286CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
