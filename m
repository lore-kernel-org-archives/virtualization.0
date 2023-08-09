Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84611EB64DD
	for <virtualization@archiver.kernel.org>; Wed,  9 Aug 2023 06:45:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3621821BB;
	Wed,  9 Aug 2023 06:45:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D3621821BB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C6/+gwc5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VNOeqaNqUXfK; Wed,  9 Aug 2023 06:45:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7491E821AA;
	Wed,  9 Aug 2023 06:45:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7491E821AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C848C0072;
	Wed,  9 Aug 2023 06:45:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEF25C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 06:45:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6BB0821BB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 06:45:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A6BB0821BB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B_Crca2M48yb
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 06:45:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 33773821AA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 06:45:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 33773821AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691563531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0jIXkVLB4rrGO+avob3qbzgF9vUBthDptdSLeSwUlj4=;
 b=C6/+gwc5sBvB6OYmFhzAivQDwdZmnQ/Z+QOJMhnjJcPQt1j1MWe6CPNKfMe5RQNHL6TApz
 teQ1GD9o374n4xCspEfLBxatuyFiMCt/rBTozrTuwFvBckrwiOYUb0+tRSZOe96tvVStdk
 2vja0+R0rwgavU9vAx1zIGbzl1TItlA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-GVn2zSCZOjWBR5UKuqDkRQ-1; Wed, 09 Aug 2023 02:45:30 -0400
X-MC-Unique: GVn2zSCZOjWBR5UKuqDkRQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b9dc1bfdd2so68696561fa.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Aug 2023 23:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691563528; x=1692168328;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0jIXkVLB4rrGO+avob3qbzgF9vUBthDptdSLeSwUlj4=;
 b=f966ZY060tzQnG/i/Qddf6gMVf7CO5ul9w4/EPNb+WZ6sbNNBuQ2pXgXZbBEIBGldr
 4h8c0HBO4pZNtSFfRigXrDq6E8BytZ8TRrZlJyUiIcorbSb0eEIGSweXymqMD7DqFBom
 YPAXsQBSP4NwxJ79v9Dgw0AT6BM9/SUumHCJRDyvc1Sow7qUjDbkhgTExsLm/UIYaZ2s
 I9AZJXTZV4oIq2ZItevYjjHpagmrlzWP6nVWfO9ZQUBRSa/eLKHFm84+W0v63jWRVB5+
 Pt2Ii3CmoZzk0WmG7lCdSMnKMULOTcxJJPOp5rRqLl2dLLPK7kkMIRHr17PRmxqg+Rbp
 3AwA==
X-Gm-Message-State: AOJu0Yyedsdq30nAArc6X/yQoDMHjQbQKjitTw5QDRaAZxyX+a8qtZx2
 2E4qHHalIcv/HMuRZKH6ay/YzwC3d6vDcmMq4DSAf+PLiyean43muUEfqh6zDlBGeAvd8LXxAB4
 J7UVxVwC2t03nfXIg3egYMS+9U6234WDvojDFMjsK8jAvD/ihWZG4t3B1Gg==
X-Received: by 2002:a2e:b0cd:0:b0:2b6:af60:6342 with SMTP id
 g13-20020a2eb0cd000000b002b6af606342mr1219918ljl.40.1691563528705; 
 Tue, 08 Aug 2023 23:45:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvXeU+hxOVRt+CjlcsX7U6pemirFfRHkIQ9j8Slm/Egwbs4YChsWclSdSyBCMCtLu2v2IyFxkKcM6l2BwBwMU=
X-Received: by 2002:a2e:b0cd:0:b0:2b6:af60:6342 with SMTP id
 g13-20020a2eb0cd000000b002b6af606342mr1219907ljl.40.1691563528358; Tue, 08
 Aug 2023 23:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230809031329.251362-1-jasowang@redhat.com>
 <66687029c1235e56d9279800ceb026dca029c966.camel@nvidia.com>
In-Reply-To: <66687029c1235e56d9279800ceb026dca029c966.camel@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Aug 2023 14:45:17 +0800
Message-ID: <CACGkMEvETiKpx3-EsVejLe9EkSroaoFjJkLBEMmh71YU+1GjGA@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: set queues after driver_ok
To: Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gV2VkLCBBdWcgOSwgMjAyMyBhdCAyOjIz4oCvUE0gRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVh
QG52aWRpYS5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCAyMDIzLTA4LTA4IGF0IDIzOjEzIC0wNDAw
LCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gQ29tbWl0IDI1MjY2MTI4ZmUxNiAoInZpcnRpby1uZXQ6
IGZpeCByYWNlIGJldHdlZW4gc2V0IHF1ZXVlcyBhbmQKPiA+IHByb2JlIikgdHJpZXMgdG8gZml4
IHRoZSByYWNlIGJldHdlZW4gc2V0IHF1ZXVlcyBhbmQgcHJvYmUgYnkgY2FsbGluZwo+ID4gX3Zp
cnRuZXRfc2V0X3F1ZXVlcygpIGJlZm9yZSBEUklWRVJfT0sgaXMgc2V0LiBUaGlzIHZpb2xhdGVz
IHZpcnRpbwo+ID4gc3BlYy4gRml4aW5nIHRoaXMgYnkgc2V0dGluZyBxdWV1ZXMgYWZ0ZXIgdmly
dGlvX2RldmljZV9yZWFkeSgpLgo+ID4KPiA+IEZpeGVzOiAyNTI2NjEyOGZlMTYgKCJ2aXJ0aW8t
bmV0OiBmaXggcmFjZSBiZXR3ZWVuIHNldCBxdWV1ZXMgYW5kIHByb2JlIikKPiA+IFJlcG9ydGVk
LWJ5OiBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVsZWFAbnZpZGlhLmNvbT4KPiA+IFNpZ25lZC1vZmYt
Ynk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gPiAtLS0KPiA+IFRoZSBwYXRj
aCBpcyBuZWVkZWQgZm9yIC1zdGFibGUuCj4gPiAtLS0KPiA+ICBkcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMgfCA0ICsrLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMg
Yi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+IGluZGV4IDEyNzBjOGQyMzQ2My4uZmYwMzky
MWU0NmRmIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiArKysg
Yi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+IEBAIC00MjE5LDggKzQyMTksNiBAQCBzdGF0
aWMgaW50IHZpcnRuZXRfcHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gPiAgICAg
ICAgIGlmICh2aS0+aGFzX3JzcyB8fCB2aS0+aGFzX3Jzc19oYXNoX3JlcG9ydCkKPiA+ICAgICAg
ICAgICAgICAgICB2aXJ0bmV0X2luaXRfZGVmYXVsdF9yc3ModmkpOwo+ID4KPiA+IC0gICAgICAg
X3ZpcnRuZXRfc2V0X3F1ZXVlcyh2aSwgdmktPmN1cnJfcXVldWVfcGFpcnMpOwo+ID4gLQo+ID4g
ICAgICAgICAvKiBzZXJpYWxpemUgbmV0ZGV2IHJlZ2lzdGVyICsgdmlydGlvX2RldmljZV9yZWFk
eSgpIHdpdGggbmRvX29wZW4oKQo+ID4gKi8KPiA+ICAgICAgICAgcnRubF9sb2NrKCk7Cj4gPgo+
ID4gQEAgLTQyMzMsNiArNDIzMSw4IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9wcm9iZShzdHJ1Y3Qg
dmlydGlvX2RldmljZSAqdmRldikKPiA+Cj4gPiAgICAgICAgIHZpcnRpb19kZXZpY2VfcmVhZHko
dmRldik7Cj4gPgo+ID4gKyAgICAgICBfdmlydG5ldF9zZXRfcXVldWVzKHZpLCB2aS0+Y3Vycl9x
dWV1ZV9wYWlycyk7Cj4gPiArCj4gPiAgICAgICAgIC8qIGEgcmFuZG9tIE1BQyBhZGRyZXNzIGhh
cyBiZWVuIGFzc2lnbmVkLCBub3RpZnkgdGhlIGRldmljZS4KPiA+ICAgICAgICAgICogV2UgZG9u
J3QgZmFpbCBwcm9iZSBpZiBWSVJUSU9fTkVUX0ZfQ1RSTF9NQUNfQUREUiBpcyBub3QgdGhlcmUK
PiA+ICAgICAgICAgICogYmVjYXVzZSBtYW55IGRldmljZXMgd29yayBmaW5lIHdpdGhvdXQgZ2V0
dGluZyBNQUMgZXhwbGljaXRseQo+Cj4gVGhhbmtzIGZvciB0aGUgcXVpY2sgZml4LiBEb2Vzbid0
IHRoaXMgZml4IHRob3VnaCBicmluZyBiYWNrIHRoZSBvcmlnaW5hbCByYWNlCj4gdGhhdCB3YXMg
Zml4ZWQgaW4gY29tbWl0IDI1MjY2MTI4ZmUxNiAoInZpcnRpby1uZXQ6IGZpeCByYWNlIGJldHdl
ZW4gc2V0IHF1ZXVlcwo+IGFuZCBwcm9iZSIpPyBPciBpcyBiZWluZyB1bmRlciB0aGUgc2FtZSBy
bnRsX2xvY2sgc2Vzc2lvbiBhcyByZWdpc3Rlcl9uZXRkZXYKPiBlbm91Z2ggdG8gYXZvaWQgdGhl
IHJhY2U/CgpZZXMsIHJ0bmwgbmVlZHMgdG8gYmUgaGVsZCBmb3IgdXNlcnNwYWNlIHJlcXVlc3Rz
IHRvIGNoYW5nZSB0aGUgbnVtYmVyCm9mIHF1ZXVlcy4gU28gd2UgYXJlIHNlcmlhbGl6ZWQgaW4g
dGhpcyB3YXkuCgpUaGFua3MKCj4KPiBUaGFua3MsCj4gRHJhZ29zCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
