Return-Path: <SRS0=qiqk=DQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01439C43457
	for <virtualization@archiver.kernel.org>; Fri,  9 Oct 2020 03:53:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E3F22240
	for <virtualization@archiver.kernel.org>; Fri,  9 Oct 2020 03:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJ0SAcFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E3F22240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B8B4886E7A;
	Fri,  9 Oct 2020 03:53:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h94svBFCRsCD; Fri,  9 Oct 2020 03:53:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 56EF486E73;
	Fri,  9 Oct 2020 03:53:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DA09C016F;
	Fri,  9 Oct 2020 03:53:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7FCBFC0051
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 03:53:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6E67786E73
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 03:53:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PGuGArKMy2g5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 03:53:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BAB2386D5C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 03:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602215588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FU45aSUQ8dscwhSeXeB5RZOeAkKlMDXRAbcGeFJTPSY=;
 b=hJ0SAcFU7L4PL5D09PEG3KlBSdQeLvpbQQ4ZqUMchiTLOYnLiE18tErojLQ1R9GxTb/6Cz
 ULujzMpZPVXVfzmSv+ocR1I+qrPVLJWBDIIUbHuERd/OYKRoqFV4hFeIXFhG/x3yAKT5n4
 RBoShbaP0cdyDRpUo1KsHZ3dWf+3ff0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-ZXpxE5hfMKO49E23RlPavw-1; Thu, 08 Oct 2020 23:53:06 -0400
X-MC-Unique: ZXpxE5hfMKO49E23RlPavw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19B5F87950B;
 Fri,  9 Oct 2020 03:53:05 +0000 (UTC)
Received: from [10.72.13.133] (ovpn-13-133.pek2.redhat.com [10.72.13.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 42A3D6EF58;
 Fri,  9 Oct 2020 03:52:40 +0000 (UTC)
Subject: Re: [RFC PATCH 09/24] vdpa: multiple address spaces support
To: Eli Cohen <elic@nvidia.com>
References: <20200924032125.18619-1-jasowang@redhat.com>
 <20200924032125.18619-10-jasowang@redhat.com>
 <20201001132331.GB32363@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <671aa6b3-c26c-d94a-82a7-0d203ef5b409@redhat.com>
Date: Fri, 9 Oct 2020 11:52:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201001132331.GB32363@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: lulu@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, mhabets@solarflare.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 hanand@xilinx.com, stefanha@redhat.com, eli@mellanox.com,
 maxime.coquelin@redhat.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
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

Ck9uIDIwMjAvMTAvMSDkuIvljYg5OjIzLCBFbGkgQ29oZW4gd3JvdGU6Cj4+ICAgCj4+ICsJLyog
T25seSBzdXBwb3J0IDEgYWRkcmVzcyBzcGFjZSAqLwo+PiArCWlmICh2ZHBhLT5uZ3JvdXBzICE9
IDEpCj4+ICsJCXJldHVybiAtRU5PVFNVUFA7Cj4gQ2hlY2twYXRjaCB3YXJuaW5nOiAgcHJlZmVy
IEVPUE5PVFNVUFAKPgoKV2lsbCBmaXguCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
