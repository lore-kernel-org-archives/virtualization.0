Return-Path: <SRS0=QXZB=GC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566D7C433E0
	for <virtualization@archiver.kernel.org>; Wed, 30 Dec 2020 06:23:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B852A20769
	for <virtualization@archiver.kernel.org>; Wed, 30 Dec 2020 06:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B852A20769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4E69F85F33;
	Wed, 30 Dec 2020 06:23:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xo4oXaWNsmZU; Wed, 30 Dec 2020 06:23:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8E0F28577F;
	Wed, 30 Dec 2020 06:23:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E31DC0893;
	Wed, 30 Dec 2020 06:23:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC0EBC0174
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 06:23:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CDF4B85F2B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 06:23:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DiO0ev_4fvcU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 06:23:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 11AF18577F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 06:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609309397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zMOHRQRlmmzuXmXJwYwsntjIgSSrZq/XW9h6GVg/eWI=;
 b=bNxiez54pDzDEXZtFvmDlrL8+SijXP5Oi89Xw/IbrsnbBsASwV3DE3X+7NEp8awblFtUYX
 72nd1aZG1FXCcyIYrf0x5BnmRYQxN291Kbt4P2altPAZrX78Rgl5T3q/2xmpAOETq3XS17
 Nq3cn5pFZrCqFFQCNl8wrIounRXEfUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-EQtmwsDoOMSTdZvFTvX8SQ-1; Wed, 30 Dec 2020 01:23:15 -0500
X-MC-Unique: EQtmwsDoOMSTdZvFTvX8SQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CF0015720;
 Wed, 30 Dec 2020 06:23:14 +0000 (UTC)
Received: from [10.72.13.30] (ovpn-13-30.pek2.redhat.com [10.72.13.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50A6271C8B;
 Wed, 30 Dec 2020 06:23:03 +0000 (UTC)
Subject: Re: [PATCH 11/21] vhost-vdpa: introduce asid based IOTLB
To: Eli Cohen <elic@nvidia.com>
References: <20201216064818.48239-1-jasowang@redhat.com>
 <20201216064818.48239-12-jasowang@redhat.com>
 <20201229114110.GC195479@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <02c7a7ea-3765-3ff8-0742-0520d6cc4ca5@redhat.com>
Date: Wed, 30 Dec 2020 14:23:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201229114110.GC195479@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: lulu@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 stefanha@redhat.com, eli@mellanox.com, lingshan.zhu@intel.com,
 rob.miller@broadcom.com
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

Ck9uIDIwMjAvMTIvMjkg5LiL5Y2INzo0MSwgRWxpIENvaGVuIHdyb3RlOgo+IE9uIFdlZCwgRGVj
IDE2LCAyMDIwIGF0IDAyOjQ4OjA4UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+IFRoaXMg
cGF0Y2ggY29udmVydHMgdGhlIHZob3N0LXZEUEEgZGV2aWNlIHRvIHN1cHBvcnQgbXVsdGlwbGUg
SU9UTEJzCj4+IHRhZ2dlZCB2aWEgQVNJRCB2aWEgaGxpc3QuIFRoaXMgd2lsbCBiZSB1c2VkIGZv
ciBzdXBwb3J0aW5nIG11bHRpcGxlCj4+IGFkZHJlc3Mgc3BhY2VzIGluIHRoZSBmb2xsb3dpbmcg
cGF0Y2hlcy4KPj4KPj4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVycy92aG9zdC92ZHBhLmMgfCAxMDYgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA4MCBp
bnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4gaW5kZXggZmViNmE1OGRmMjJk
Li4wNjBkNWI1YjdlNjQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+ICsr
KyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+IEBAIC0zMywxMyArMzMsMjEgQEAgZW51bSB7Cj4+
ICAgCj4+ICAgI2RlZmluZSBWSE9TVF9WRFBBX0RFVl9NQVggKDFVIDw8IE1JTk9SQklUUykKPj4g
ICAKPj4gKyNkZWZpbmUgVkhPU1RfVkRQQV9JT1RMQl9CVUNLRVRTIDE2Cj4+ICsKPj4gK3N0cnVj
dCB2aG9zdF92ZHBhX2FzIHsKPj4gKwlzdHJ1Y3QgaGxpc3Rfbm9kZSBoYXNoX2xpbms7Cj4+ICsJ
c3RydWN0IHZob3N0X2lvdGxiIGlvdGxiOwo+PiArCXUzMiBpZDsKPj4gK307Cj4+ICsKPj4gICBz
dHJ1Y3Qgdmhvc3RfdmRwYSB7Cj4+ICAgCXN0cnVjdCB2aG9zdF9kZXYgdmRldjsKPj4gICAJc3Ry
dWN0IGlvbW11X2RvbWFpbiAqZG9tYWluOwo+PiAgIAlzdHJ1Y3Qgdmhvc3RfdmlydHF1ZXVlICp2
cXM7Cj4+ICAgCXN0cnVjdCBjb21wbGV0aW9uIGNvbXBsZXRpb247Cj4+ICAgCXN0cnVjdCB2ZHBh
X2RldmljZSAqdmRwYTsKPj4gLQlzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiOwo+PiArCXN0cnVj
dCBobGlzdF9oZWFkIGFzW1ZIT1NUX1ZEUEFfSU9UTEJfQlVDS0VUU107Cj4+ICAgCXN0cnVjdCBk
ZXZpY2UgZGV2Owo+PiAgIAlzdHJ1Y3QgY2RldiBjZGV2Owo+PiAgIAlhdG9taWNfdCBvcGVuZWQ7
Cj4+IEBAIC00OSwxMiArNTcsNjQgQEAgc3RydWN0IHZob3N0X3ZkcGEgewo+PiAgIAlzdHJ1Y3Qg
ZXZlbnRmZF9jdHggKmNvbmZpZ19jdHg7Cj4+ICAgCWludCBpbl9iYXRjaDsKPj4gICAJc3RydWN0
IHZkcGFfaW92YV9yYW5nZSByYW5nZTsKPj4gKwlpbnQgdXNlZF9hczsKPiBUaGlzIGlzIG5vdCBy
ZWFsbHkgdXNlZC4gTm90IGluIHRoaXMgcGF0Y2ggYW5kIGxhdGVyIHJlbW92ZWQuCgoKUmlnaHQs
IHdpbGwgcmVtb3ZlIHRoaXMuCgpUaGFua3MKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
