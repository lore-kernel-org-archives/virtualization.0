Return-Path: <SRS0=ITlz=HH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB050C433E0
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 03:18:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BEB964F87
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 03:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BEB964F87
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9879686CC4;
	Fri,  5 Feb 2021 03:18:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9MGTBog4v6mN; Fri,  5 Feb 2021 03:18:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B88AA86C92;
	Fri,  5 Feb 2021 03:18:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9789AC07FD;
	Fri,  5 Feb 2021 03:18:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75C40C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 03:18:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1A5BA2E0F7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 03:18:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6-jfCFhuKitk
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 03:18:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id B4DE32E0F4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 03:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612495102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8f5YNAREUXRNKxTFWHdq8ACl9JhrFD9o9V+DNNSV58o=;
 b=gOwI6/K7Lzb82sSLrwkb9pGrZ44AFsDGhpL6CrhVS2isqYr1c6Slir/2J/yf65SGus3Mw+
 5klcFXA5XOUL0zS5jT4pSx/XkQboxeSwyWyhIoXoUqdsH2oRKl538cPdfZ7440yzxnpXAm
 6sNhAmjlE8YXM7sxPt7qvAPITYW5k7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-JOAVM-QBOKGtssQ-ddjj_Q-1; Thu, 04 Feb 2021 22:18:20 -0500
X-MC-Unique: JOAVM-QBOKGtssQ-ddjj_Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B0CC91271;
 Fri,  5 Feb 2021 03:18:19 +0000 (UTC)
Received: from [10.72.12.112] (ovpn-12-112.pek2.redhat.com [10.72.12.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2AB4972F81;
 Fri,  5 Feb 2021 03:18:08 +0000 (UTC)
Subject: Re: [PATCH v3 03/13] vringh: reset kiov 'consumed' field in
 __vringh_iov()
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20210204172230.85853-1-sgarzare@redhat.com>
 <20210204172230.85853-4-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1a8f925a-13ea-a04e-1130-690fb0886bcd@redhat.com>
Date: Fri, 5 Feb 2021 11:18:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210204172230.85853-4-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Ck9uIDIwMjEvMi81IOS4iuWNiDE6MjIsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiBfX3Zy
aW5naF9pb3YoKSBvdmVyd3JpdGVzIHRoZSBjb250ZW50cyBvZiByaW92IGFuZCB3aW92LCBpbiBm
YWN0IGl0Cj4gcmVzZXRzIHRoZSAnaScgYW5kICd1c2VkJyBmaWVsZHMsIGJ1dCBhbHNvIHRoZSAn
Y29uc3VtZWQnIGZpZWxkIHNob3VsZAo+IGJlIHJlc2V0IHRvIGF2b2lkIGFuIGluY29uc2lzdGVu
dCBzdGF0ZS4KPgo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVA
cmVkaGF0LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmhvc3QvdnJpbmdoLmMgfCA0ICsrLS0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgoKQWNrZWQt
Ynk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3Zob3N0L3ZyaW5naC5jIGIvZHJpdmVycy92aG9zdC92cmluZ2guYwo+IGluZGV4IGY2
ODEyMjcwNTcxOS4uYmVlNjNkNjgyMDFhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdnJp
bmdoLmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jCj4gQEAgLTI5MCw5ICsyOTAsOSBA
QCBfX3ZyaW5naF9pb3Yoc3RydWN0IHZyaW5naCAqdnJoLCB1MTYgaSwKPiAgIAkJcmV0dXJuIC1F
SU5WQUw7Cj4gICAKPiAgIAlpZiAocmlvdikKPiAtCQlyaW92LT5pID0gcmlvdi0+dXNlZCA9IDA7
Cj4gKwkJcmlvdi0+aSA9IHJpb3YtPnVzZWQgPSByaW92LT5jb25zdW1lZCA9IDA7Cj4gICAJaWYg
KHdpb3YpCj4gLQkJd2lvdi0+aSA9IHdpb3YtPnVzZWQgPSAwOwo+ICsJCXdpb3YtPmkgPSB3aW92
LT51c2VkID0gd2lvdi0+Y29uc3VtZWQgPSAwOwo+ICAgCj4gICAJZm9yICg7Oykgewo+ICAgCQl2
b2lkICphZGRyOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
