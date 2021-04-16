Return-Path: <SRS0=5KLU=JN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A52C43460
	for <virtualization@archiver.kernel.org>; Fri, 16 Apr 2021 03:24:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79B1D6113D
	for <virtualization@archiver.kernel.org>; Fri, 16 Apr 2021 03:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B1D6113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2884F8479B;
	Fri, 16 Apr 2021 03:24:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FK1FQC2t9SdO; Fri, 16 Apr 2021 03:24:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id E46B284798;
	Fri, 16 Apr 2021 03:24:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7851C000B;
	Fri, 16 Apr 2021 03:24:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 308E6C000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 03:24:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1267F8433B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 03:24:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pnoygrcfoeyg
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 03:24:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 487D984798
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 03:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618543480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y2eoMDNZ7KhFTHyXgnjh9cYB2las6pMgIII6CMe3Tt4=;
 b=OupOO/Z5hbgQJeJe9mLQ2xdWHk5kxtO0u/YLb0xxbl+sgM6Fm/8PH5wQtqCfIzhWmQ5n8H
 IjakGIbKwE+mfCNDzHpK7RkDK2PpDBTqNL+Co6VFFLvoolWzv/T6fy5oHHdBCmbqqvc1SK
 qae1rpZk2j9/KTmJIB8Tq52DdWb+O5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-aChSZ2eYPcWkYTo_ixynCg-1; Thu, 15 Apr 2021 23:24:38 -0400
X-MC-Unique: aChSZ2eYPcWkYTo_ixynCg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9916501FB;
 Fri, 16 Apr 2021 03:24:35 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-140.pek2.redhat.com
 [10.72.13.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2EA1518B42;
 Fri, 16 Apr 2021 03:24:20 +0000 (UTC)
Subject: Re: [PATCH v6 09/10] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 hch@infradead.org, christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com
References: <20210331080519.172-1-xieyongji@bytedance.com>
 <20210331080519.172-10-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <87a54b5e-626d-7e04-93f4-f59eddff9947@redhat.com>
Date: Fri, 16 Apr 2021 11:24:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210331080519.172-10-xieyongji@bytedance.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvMy8zMSDPws7nNDowNSwgWGllIFlvbmdqaSDQtLXAOgo+ICsJfQo+ICsJY2FzZSBW
RFVTRV9JTkpFQ1RfVlFfSVJROgo+ICsJCXJldCA9IC1FSU5WQUw7Cj4gKwkJaWYgKGFyZyA+PSBk
ZXYtPnZxX251bSkKPiArCQkJYnJlYWs7Cj4gKwo+ICsJCXJldCA9IDA7Cj4gKwkJcXVldWVfd29y
ayh2ZHVzZV9pcnFfd3EsICZkZXYtPnZxc1thcmddLmluamVjdCk7Cj4gKwkJYnJlYWs7CgoKT25l
IGFkZGl0aW9uYWwgbm90ZToKClBsZWFzZSB1c2UgYXJyYXlfaW5kZXhfbm9zcGVjKCkgZm9yIGFs
bCB2cXNbaWR4XSBhY2Nlc3Mgd2hlcmUgaWR4IGlzIAp1bmRlciB0aGUgY29udHJvbCBvZiB1c2Vy
c3BhY2UgdG8gYXZvaWQgcG90ZW50aWFsIHNwZWN0cmUgZXhwbG9pdGF0aW9uLgoKVGhhbmtzCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
