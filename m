Return-Path: <SRS0=ow7J=HD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822DBC433DB
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 05:40:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DA5664E15
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 05:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA5664E15
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C60AA85FB2;
	Mon,  1 Feb 2021 05:40:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qTYvKFQ84pLq; Mon,  1 Feb 2021 05:40:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 44D2185FB6;
	Mon,  1 Feb 2021 05:40:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CB31C0FA7;
	Mon,  1 Feb 2021 05:40:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FC7EC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 05:40:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8E1D385FB2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 05:40:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QmVyGrWIOPJY
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 05:40:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BEDB285FB6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 05:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612158016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5mQIIlM5CFm8xeXBVRv4nhYcFaur8L2TXYtvPPpQAxw=;
 b=dhKJrP/xoCyPJVF3+19azybF6bXigf5S1QqUbP0OcLRkomGIkEA3LySWzpHkifxUuXWbSz
 rBSsQD3V/+pwLc0faEQwEoL9/26syyuQeVsDNbzTjzXQandpt9gPgc9Aa0cfsJV1Bq2qAX
 ZiE2kpegDo8REL30KL8gSu1fDwLa3PU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-vKvb8gjeOfq7lZK4FcopZQ-1; Mon, 01 Feb 2021 00:40:15 -0500
X-MC-Unique: vKvb8gjeOfq7lZK4FcopZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD98FCC620;
 Mon,  1 Feb 2021 05:40:13 +0000 (UTC)
Received: from [10.72.13.120] (ovpn-13-120.pek2.redhat.com [10.72.13.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 476F627CA9;
 Mon,  1 Feb 2021 05:40:03 +0000 (UTC)
Subject: Re: [PATCH RFC v2 03/10] vringh: reset kiov 'consumed' field in
 __vringh_iov()
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20210128144127.113245-1-sgarzare@redhat.com>
 <20210128144127.113245-4-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <62bb2e93-4ac3-edf5-2baa-4c2be8257cf0@redhat.com>
Date: Mon, 1 Feb 2021 13:40:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210128144127.113245-4-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

Ck9uIDIwMjEvMS8yOCDkuIvljYgxMDo0MSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IF9f
dnJpbmdoX2lvdigpIG92ZXJ3cml0ZXMgdGhlIGNvbnRlbnRzIG9mIHJpb3YgYW5kIHdpb3YsIGlu
IGZhY3QgaXQKPiByZXNldHMgdGhlICdpJyBhbmQgJ3VzZWQnIGZpZWxkcywgYnV0IGFsc28gdGhl
IGNvbnN1bWVkIGZpZWxkIHNob3VsZAo+IGJlIHJlc2V0IHRvIGF2b2lkIGFuIGluY29uc2lzdGVu
dCBzdGF0ZS4KPgo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVA
cmVkaGF0LmNvbT4KCgpJIGhhZCBhIHF1ZXN0aW9uKEkgcmVtZW1iZXIgd2UgaGFkIHNvbWUgZGlz
Y3Vzc2lvbiBsaWtlIHRoaXMgYnV0IEkgCmZvcmdldCB0aGUgY29uY2x1c2lvbik6CgpJIHNlZSBl
LmcgaW4gdnJpbmdoX2dldGRlc2Nfa2VybigpIGl0IGhhcyB0aGUgZm9sbG93aW5nIGNvbW1lbnQ6
CgovKgogwqAqIE5vdGUgdGhhdCB5b3UgbWF5IG5lZWQgdG8gY2xlYW4gdXAgcmlvdiBhbmQgd2lv
diwgZXZlbiBvbiBlcnJvciEKIMKgKi8KClNvIGl0IGxvb2tzIHRvIG1lIHRoZSBjb3JyZWN0IHdh
eSBpcyB0byBjYWxsIHZyaW5naF9raW92X2NsZWFudXAoKSBiZWZvcmU/CgpUaGFua3MKCgo+IC0t
LQo+ICAgZHJpdmVycy92aG9zdC92cmluZ2guYyB8IDQgKystLQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3Zob3N0L3ZyaW5naC5jIGIvZHJpdmVycy92aG9zdC92cmluZ2guYwo+IGluZGV4IGY2ODEyMjcw
NTcxOS4uYmVlNjNkNjgyMDFhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMK
PiArKysgYi9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jCj4gQEAgLTI5MCw5ICsyOTAsOSBAQCBfX3Zy
aW5naF9pb3Yoc3RydWN0IHZyaW5naCAqdnJoLCB1MTYgaSwKPiAgIAkJcmV0dXJuIC1FSU5WQUw7
Cj4gICAKPiAgIAlpZiAocmlvdikKPiAtCQlyaW92LT5pID0gcmlvdi0+dXNlZCA9IDA7Cj4gKwkJ
cmlvdi0+aSA9IHJpb3YtPnVzZWQgPSByaW92LT5jb25zdW1lZCA9IDA7Cj4gICAJaWYgKHdpb3Yp
Cj4gLQkJd2lvdi0+aSA9IHdpb3YtPnVzZWQgPSAwOwo+ICsJCXdpb3YtPmkgPSB3aW92LT51c2Vk
ID0gd2lvdi0+Y29uc3VtZWQgPSAwOwo+ICAgCj4gICAJZm9yICg7Oykgewo+ICAgCQl2b2lkICph
ZGRyOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
