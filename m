Return-Path: <SRS0=fSpH=EL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12736C4741F
	for <virtualization@archiver.kernel.org>; Thu,  5 Nov 2020 06:52:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A0052087D
	for <virtualization@archiver.kernel.org>; Thu,  5 Nov 2020 06:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZ9kYKJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0052087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8BDFF87071;
	Thu,  5 Nov 2020 06:52:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yafDTzP-94Lj; Thu,  5 Nov 2020 06:52:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CC2A887072;
	Thu,  5 Nov 2020 06:52:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3493C088B;
	Thu,  5 Nov 2020 06:52:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B53FAC0889
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 06:52:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9708387072
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 06:52:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZXaJ8mxRZra5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 06:52:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C635087071
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 06:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604559162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K5R6JGiYe4/u2K6/yJ14UH2NO+ZUGFzIOqRPQLmETsU=;
 b=BZ9kYKJCYBqa3kerMr/hC7IXA5AkjQUBoYh1742a3PFVRDGCpJIk0g8bmkPmCqlb0qCQG+
 6qsCraPDw/vCpdJ1QQvZMltzfTh/PVe9Ratr3D35/E2XjForMsVys5Hs87b/qL2L8j/Xuc
 Dq7ih6MkAqZqPXjXXzUmM364cUuwAzk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-s43WvTDkOEyEdii-a-OWkw-1; Thu, 05 Nov 2020 01:52:38 -0500
X-MC-Unique: s43WvTDkOEyEdii-a-OWkw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4254E8015AD;
 Thu,  5 Nov 2020 06:52:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB1095D9D5;
 Thu,  5 Nov 2020 06:52:34 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DC06D16E18; Thu,  5 Nov 2020 07:52:33 +0100 (CET)
Date: Thu, 5 Nov 2020 07:52:33 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] drm/virtio: use kvmalloc for large allocations
Message-ID: <20201105065233.3td3zuyfmbypjtvq@sirius.home.kraxel.org>
References: <20201105014744.1662226-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201105014744.1662226-1-senozhatsky@chromium.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Daniel Vetter <daniel@ffwll.ch>, Suleiman Souhlal <suleiman@google.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

  Hi,

> -	*ents = kmalloc_array(*nents, sizeof(struct virtio_gpu_mem_entry),
> -			      GFP_KERNEL);
> +	*ents = kvmalloc_array(*nents,
> +			       sizeof(struct virtio_gpu_mem_entry),
> +			       GFP_KERNEL);

Shouldn't that be balanced with a kvfree() elsewhere?

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
