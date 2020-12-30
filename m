Return-Path: <SRS0=QXZB=GC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADEFC433DB
	for <virtualization@archiver.kernel.org>; Wed, 30 Dec 2020 06:35:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 633F1207B0
	for <virtualization@archiver.kernel.org>; Wed, 30 Dec 2020 06:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633F1207B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CF84D85F75;
	Wed, 30 Dec 2020 06:35:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gwDsUNTR7V-X; Wed, 30 Dec 2020 06:35:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 57B1485F7F;
	Wed, 30 Dec 2020 06:35:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49647C0893;
	Wed, 30 Dec 2020 06:35:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 662A0C0174
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 06:35:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 50CCA87170
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 06:35:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7+D+1IegkXfL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 06:35:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AF8A08716D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 06:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609310114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V3lC15jls6IaJqaREYiEoSGla45iKl4vF8Trns9tYY8=;
 b=R3a5sjTaYS+3yvvvAgGSCpytZmRKwvJePyJbs1Kq8e07hSmWvF5FUJkrmQ39XM3qMQYpzo
 ixngzIB3zOW0asVd8KovMIzSwMjTmRMftYzbVNKf7oEnBNyoaVRlH6mU4x4gExEtBUgzQF
 rBzknVY+AxeIMdPA8a+tkLYMFw/v1n4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-u9IGufgONymH5MxSpEGGwQ-1; Wed, 30 Dec 2020 01:35:12 -0500
X-MC-Unique: u9IGufgONymH5MxSpEGGwQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B2D010054FF;
 Wed, 30 Dec 2020 06:35:10 +0000 (UTC)
Received: from [10.72.13.30] (ovpn-13-30.pek2.redhat.com [10.72.13.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B77922C166;
 Wed, 30 Dec 2020 06:35:00 +0000 (UTC)
Subject: Re: [PATCH 11/21] vhost-vdpa: introduce asid based IOTLB
To: Eli Cohen <elic@nvidia.com>
References: <20201216064818.48239-1-jasowang@redhat.com>
 <20201216064818.48239-12-jasowang@redhat.com>
 <20201229115340.GD195479@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5df825a2-b794-9374-4ebf-83c5cc14584a@redhat.com>
Date: Wed, 30 Dec 2020 14:34:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201229115340.GD195479@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Ck9uIDIwMjAvMTIvMjkg5LiL5Y2INzo1MywgRWxpIENvaGVuIHdyb3RlOgo+PiArCj4+ICtzdGF0
aWMgc3RydWN0IHZob3N0X3ZkcGFfYXMgKnZob3N0X3ZkcGFfYWxsb2NfYXMoc3RydWN0IHZob3N0
X3ZkcGEgKnYsIHUzMiBhc2lkKQo+PiArewo+PiArCXN0cnVjdCBobGlzdF9oZWFkICpoZWFkID0g
JnYtPmFzW2FzaWQgJSBWSE9TVF9WRFBBX0lPVExCX0JVQ0tFVFNdOwo+PiArCXN0cnVjdCB2aG9z
dF92ZHBhX2FzICphczsKPj4gKwo+PiArCWlmIChhc2lkX3RvX2FzKHYsIGFzaWQpKQo+PiArCQly
ZXR1cm4gTlVMTDsKPj4gKwo+PiArCWFzID0ga21hbGxvYyhzaXplb2YoKmFzKSwgR0ZQX0tFUk5F
TCk7Cj4ga3phbGxvYygpPyBTZWUgY29tbWVudCBiZWxvdy4KPgo+PiArCWlmICghYXMpCj4+ICsJ
CXJldHVybiBOVUxMOwo+PiArCj4+ICsJdmhvc3RfaW90bGJfaW5pdCgmYXMtPmlvdGxiLCAwLCAw
KTsKPj4gKwlhcy0+aWQgPSBhc2lkOwo+PiArCWhsaXN0X2FkZF9oZWFkKCZhcy0+aGFzaF9saW5r
LCBoZWFkKTsKPj4gKwkrK3YtPnVzZWRfYXM7Cj4gQWx0aG91Z2ggeW91IGV2ZW50dWFsbHkgZW5k
ZWQgdXAgcmVtb3ZpbmcgdXNlZF9hcywgdGhpcyBpcyBhIGJ1ZyBzaW5jZQo+IHlvdSdyZSBpbmNy
ZW1lbnRpbmcgYSByYW5kb20gdmFsdWUuIE1heWJlIGl0J3MgYmV0dGVyIHRvIGJlIG9uIHRoZSBz
YWZlCj4gc2lkZSBhbmQgdXNlIGt6YWxsb2MoKSBmb3IgYXMgYWJvdmUuCgoKWWVzIGFuZCB1c2Vk
X2FzIG5lZWRzIHRvIGJlIHJlbW92ZWQuCgpUaGFua3MKCgoKPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
