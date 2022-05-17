Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093DFC433F5
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 03:22:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9669483466;
	Tue, 17 May 2022 03:22:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2QSBEtZvY2rl; Tue, 17 May 2022 03:22:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4BAB583381;
	Tue, 17 May 2022 03:22:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 295ACC0039;
	Tue, 17 May 2022 03:22:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 606C2C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:22:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4EDDA83466
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:22:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2R1py9UJiEdw
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:22:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 20C4C83381
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652757747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SN6U8eA4JXm76PNC6vm/Oqr6vBoIj2+LxtHWOYBHyVk=;
 b=dYk09iufQLs1GzDhl5VJdzDyslpCxKIdh/qcYLRRKOF+n/8pfPo1sKVlnsnDwCgMd9pMOM
 RddF59i6MdnsgyFUyf9t+QscPwwseBLh71PMirtds5JTGv8YqpogSu9s/hK4/t7u8e5WY/
 W0GoXGXByqg2uO2d95hR1Mm9iftX7WI=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-BN7Q7VbUMieTZPS8geqOHw-1; Mon, 16 May 2022 23:22:26 -0400
X-MC-Unique: BN7Q7VbUMieTZPS8geqOHw-1
Received: by mail-pf1-f198.google.com with SMTP id
 z19-20020a62d113000000b0050d183adf6fso7038691pfg.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 20:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=SN6U8eA4JXm76PNC6vm/Oqr6vBoIj2+LxtHWOYBHyVk=;
 b=JvA1iA0zpRt2h1NoPBogY47EwKG5nJIi8WTPIfW9wcfjTjI87eyZOu4ufTnv7eqT4L
 3aPhSPHuRu60halfGmE289mph5j6p+yidGYQ0w/+OH/l7h5WA5dQmBU0CHc1ysIPn/hK
 N7xDT0YD7N/X27EmKnkkckN5ZjnHQMI53D6Lq4n2dAE28JQ4W1idqgFq7kSghGHapXAd
 TbO9ZkarykRKR4hoI/UTkL4FC8sWZR8kPvE0vNFvtNWw9ET68v90SRcLA0r40MJ8CwUe
 dN9gMz1AYHliCcS78bKn3Q3gbnB9rvydJvS50I4owTbMgU3Ns/mCEZB2ZBT4nKCnEDMa
 3j6g==
X-Gm-Message-State: AOAM532e6O2Q3CIl6kRtETa+2op6fLVGu/iHqqsea0x1nV0SOazMZNMC
 YgKQ/1U2RdaimVq83Sclajr9q/Y6WlIF/HLHlClb6yTLjeQlZTC4CY1vaRhKQ+ikkU7H0uhSrF1
 RJ/6xEPappGnmkZIQbiHRdymIwBWm3ESeP8Qv0YdwMg==
X-Received: by 2002:a17:90b:3e8b:b0:1df:47cf:cb69 with SMTP id
 rj11-20020a17090b3e8b00b001df47cfcb69mr10172937pjb.47.1652757745630; 
 Mon, 16 May 2022 20:22:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYDudDmfMNR1xSUGJ/nO781gYAKdUbTWKMLYnpE+YEvHYlj6JxntlFHysnsukG9M+X5zm9Bg==
X-Received: by 2002:a17:90b:3e8b:b0:1df:47cf:cb69 with SMTP id
 rj11-20020a17090b3e8b00b001df47cfcb69mr10172914pjb.47.1652757745368; 
 Mon, 16 May 2022 20:22:25 -0700 (PDT)
Received: from [10.72.12.227] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 jg10-20020a17090326ca00b0015eb6d49679sm5019051plb.62.2022.05.16.20.22.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 May 2022 20:22:24 -0700 (PDT)
Message-ID: <2de0a0e2-eff0-c364-d5a4-998cacd41491@redhat.com>
Date: Tue, 17 May 2022 11:22:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH V2 3/8] vhost_net: get rid of vhost_net_flush_vq() and
 extra flush calls
To: Mike Christie <michael.christie@oracle.com>, stefanha@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org, arbn@yandex-team.com
References: <20220515202922.174066-1-michael.christie@oracle.com>
 <20220515202922.174066-4-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220515202922.174066-4-michael.christie@oracle.com>
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzUvMTYgMDQ6MjksIE1pa2UgQ2hyaXN0aWUg5YaZ6YGTOgo+IEZyb206IEFuZHJl
eSBSeWFiaW5pbiA8YXJibkB5YW5kZXgtdGVhbS5jb20+Cj4KPiB2aG9zdF9uZXRfZmx1c2hfdnEo
KSBjYWxscyB2aG9zdF93b3JrX2Rldl9mbHVzaCgpIHR3aWNlIHBhc3NpbmcKPiB2aG9zdF9kZXYg
cG9pbnRlciBvYnRhaW5lZCB2aWEgJ24tPnBvbGxbaW5kZXhdLmRldicgYW5kCj4gJ24tPnZxc1tp
bmRleF0udnEucG9sbC5kZXYnLiBUaGlzIGlzIGFjdHVhbGx5IHRoZSBzYW1lIHBvaW50ZXIsCj4g
aW5pdGlhbGl6ZWQgaW4gdmhvc3RfbmV0X29wZW4oKS92aG9zdF9kZXZfaW5pdCgpL3Zob3N0X3Bv
bGxfaW5pdCgpCj4KPiBSZW1vdmUgdmhvc3RfbmV0X2ZsdXNoX3ZxKCkgYW5kIGNhbGwgdmhvc3Rf
d29ya19kZXZfZmx1c2goKSBkaXJlY3RseS4KPiBEbyB0aGUgZmx1c2hlcyBvbmx5IG9uY2UgaW5z
dGVhZCBvZiBzZXZlcmFsIGZsdXNoIGNhbGxzIGluIGEgcm93Cj4gd2hpY2ggc2VlbXMgcmF0aGVy
IHVzZWxlc3MuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgUnlhYmluaW4gPGFyYm5AeWFuZGV4
LXRlYW0uY29tPgo+IFtkcm9wIHZob3N0X2RldiBmb3J3YXJkIGRlY2xhcmF0aW9uIGluIHZob3N0
LmhdCj4gU2lnbmVkLW9mZi1ieTogTWlrZSBDaHJpc3RpZSA8bWljaGFlbC5jaHJpc3RpZUBvcmFj
bGUuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4g
LS0tCj4gICBkcml2ZXJzL3Zob3N0L25ldC5jIHwgMTEgKystLS0tLS0tLS0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92aG9zdC9uZXQuYyBiL2RyaXZlcnMvdmhvc3QvbmV0LmMKPiBpbmRleCA0ZTU1YWQ4
Yzk0MmEuLjA0N2I3YjA1MTA5YSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L25ldC5jCj4g
KysrIGIvZHJpdmVycy92aG9zdC9uZXQuYwo+IEBAIC0xMzc0LDE2ICsxMzc0LDkgQEAgc3RhdGlj
IHZvaWQgdmhvc3RfbmV0X3N0b3Aoc3RydWN0IHZob3N0X25ldCAqbiwgc3RydWN0IHNvY2tldCAq
KnR4X3NvY2ssCj4gICAJKnJ4X3NvY2sgPSB2aG9zdF9uZXRfc3RvcF92cShuLCAmbi0+dnFzW1ZI
T1NUX05FVF9WUV9SWF0udnEpOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyB2b2lkIHZob3N0X25ldF9m
bHVzaF92cShzdHJ1Y3Qgdmhvc3RfbmV0ICpuLCBpbnQgaW5kZXgpCj4gLXsKPiAtCXZob3N0X3dv
cmtfZGV2X2ZsdXNoKG4tPnBvbGxbaW5kZXhdLmRldik7Cj4gLQl2aG9zdF93b3JrX2Rldl9mbHVz
aChuLT52cXNbaW5kZXhdLnZxLnBvbGwuZGV2KTsKPiAtfQo+IC0KPiAgIHN0YXRpYyB2b2lkIHZo
b3N0X25ldF9mbHVzaChzdHJ1Y3Qgdmhvc3RfbmV0ICpuKQo+ICAgewo+IC0Jdmhvc3RfbmV0X2Zs
dXNoX3ZxKG4sIFZIT1NUX05FVF9WUV9UWCk7Cj4gLQl2aG9zdF9uZXRfZmx1c2hfdnEobiwgVkhP
U1RfTkVUX1ZRX1JYKTsKPiArCXZob3N0X3dvcmtfZGV2X2ZsdXNoKCZuLT5kZXYpOwo+ICAgCWlm
IChuLT52cXNbVkhPU1RfTkVUX1ZRX1RYXS51YnVmcykgewo+ICAgCQltdXRleF9sb2NrKCZuLT52
cXNbVkhPU1RfTkVUX1ZRX1RYXS52cS5tdXRleCk7Cj4gICAJCW4tPnR4X2ZsdXNoID0gdHJ1ZTsK
PiBAQCAtMTU3Myw3ICsxNTY2LDcgQEAgc3RhdGljIGxvbmcgdmhvc3RfbmV0X3NldF9iYWNrZW5k
KHN0cnVjdCB2aG9zdF9uZXQgKm4sIHVuc2lnbmVkIGluZGV4LCBpbnQgZmQpCj4gICAJfQo+ICAg
Cj4gICAJaWYgKG9sZHNvY2spIHsKPiAtCQl2aG9zdF9uZXRfZmx1c2hfdnEobiwgaW5kZXgpOwo+
ICsJCXZob3N0X3dvcmtfZGV2X2ZsdXNoKCZuLT5kZXYpOwo+ICAgCQlzb2NrZmRfcHV0KG9sZHNv
Y2spOwo+ICAgCX0KPiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
