Return-Path: <SRS0=QXZB=GC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D6BC433E0
	for <virtualization@archiver.kernel.org>; Wed, 30 Dec 2020 04:04:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D885B207B3
	for <virtualization@archiver.kernel.org>; Wed, 30 Dec 2020 04:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D885B207B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8288F85EBB;
	Wed, 30 Dec 2020 04:04:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4sxoDlTVMdox; Wed, 30 Dec 2020 04:04:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5DB2D85E25;
	Wed, 30 Dec 2020 04:04:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D374C088B;
	Wed, 30 Dec 2020 04:04:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB0ADC0174
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 04:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8F9468712C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 04:04:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u5iKKmeVup7T
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 04:04:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1BCD787126
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 04:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609301086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=87Z6ci1v2zuVojOQC2txx0MeUSow10QAvJKJUecJndQ=;
 b=GNrcHHKe987kQVZhFDw0VTIZMl5baf6QB56Lzx26+vhqXeBgJpF6KzeSTYrIhL4wLoZZog
 Yt0eo0R5v1Y/O23IoWHECCaJ+1AweHfbGOk6g7+lsZCeNOnR4wmywX2kH0K2vhRLGxnjVu
 TKEe8gFxNKHAIfgo8gvQL1o8E5TtXvw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-JamB0Jt2P9y1nW7cSEysxg-1; Tue, 29 Dec 2020 23:04:45 -0500
X-MC-Unique: JamB0Jt2P9y1nW7cSEysxg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CCAD107ACE3;
 Wed, 30 Dec 2020 04:04:43 +0000 (UTC)
Received: from [10.72.13.30] (ovpn-13-30.pek2.redhat.com [10.72.13.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1B565C8AA;
 Wed, 30 Dec 2020 04:04:31 +0000 (UTC)
Subject: Re: [PATCH 07/21] vdpa: multiple address spaces support
To: Eli Cohen <elic@nvidia.com>
References: <20201216064818.48239-1-jasowang@redhat.com>
 <20201216064818.48239-8-jasowang@redhat.com>
 <20201229072832.GA195479@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e8b9dabb-ae78-1c84-b5f3-409bec3e8255@redhat.com>
Date: Wed, 30 Dec 2020 12:04:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201229072832.GA195479@mtl-vdi-166.wap.labs.mlnx>
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

Ck9uIDIwMjAvMTIvMjkg5LiL5Y2IMzoyOCwgRWxpIENvaGVuIHdyb3RlOgo+PiBAQCAtNDMsNiAr
NDMsOCBAQCBzdHJ1Y3QgdmRwYV92cV9zdGF0ZSB7Cj4+ICAgICogQGluZGV4OiBkZXZpY2UgaW5k
ZXgKPj4gICAgKiBAZmVhdHVyZXNfdmFsaWQ6IHdlcmUgZmVhdHVyZXMgaW5pdGlhbGl6ZWQ/IGZv
ciBsZWdhY3kgZ3Vlc3RzCj4+ICAgICogQG52cXM6IHRoZSBudW1iZXIgb2YgdmlydHF1ZXVlcwo+
PiArICogQG5ncm91cHM6IHRoZSBudW1iZXIgb2YgdmlydHF1ZXVlIGdyb3Vwcwo+PiArICogQG5h
czogdGhlIG51bWJlciBvZiBhZGRyZXNzIHNwYWNlcwo+IEkgYW0gbm90IHN1cmUgdGhlc2UgY2Fu
IGJlIGNhdGVnb3Jpc2VkIGFzIHBhcnQgb2YgdGhlIHN0YXRlIG9mIHRoZSBWUS4KPiBJdCdzIG1v
cmUgb2YgYSBwcm9wZXJ0eSBzbyBtYXliZSB3ZSBjYW4gaGF2ZSBhIGNhbGxiYWNrIHRvIGdldCB0
aGUKPiBwcm9wZXJ0aWVzIG9mIHRoZSBWUT8KCgpPciBtYXliZSB0aGVyZSdzIGEgbWlzdW5kZXJz
dGFuZGluZyBvZiB0aGUgcGF0Y2guCgpUaG9zZSB0d28gYXR0cmlidXRlcyBiZWxvbmdzIHRvIHZk
cGFfZGV2aWNlIGluc3RlYWQgb2YgdmRwYV92cV9zdGF0ZSAKYWN0dWFsbHkuCgpUaGFua3MKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
