Return-Path: <SRS0=bZ0l=OF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F036AC433FE
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 06:38:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA0260F11
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 06:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8FA0260F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4727440198;
	Wed, 15 Sep 2021 06:38:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b92qTq2Ufr6v; Wed, 15 Sep 2021 06:38:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B17F840445;
	Wed, 15 Sep 2021 06:38:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A7C8C0011;
	Wed, 15 Sep 2021 06:38:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEA4CC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 06:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B55C240186
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 06:38:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VSX73ahanJKv
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 06:38:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2088340174
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 06:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631687927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2jrv4qpH+SsfqVOrOyTWjCAMipmK09EdyvQxDfD9z+o=;
 b=HP8qQNtJDYIe2chVF4/DFELENVOlB/wZOFnaCvsAsHYWHSUo6TeZnx2mLAovNxpBHIRte1
 C3UqHVEFnhjZ/EhnwqCR/Y8vYxRfIH4xUz1NuX/TE+A14NQ5EWtTVRSlN+YBIC73Hy1zNe
 sgj6wc1H7wwxK6RPlNAQXTYdp/TJKJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-7qemqFm_PtCHmUhwK6aNNQ-1; Wed, 15 Sep 2021 02:38:41 -0400
X-MC-Unique: 7qemqFm_PtCHmUhwK6aNNQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A72684A5E0;
 Wed, 15 Sep 2021 06:38:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A210C5D9D3;
 Wed, 15 Sep 2021 06:38:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 290BE18003BF; Wed, 15 Sep 2021 08:38:35 +0200 (CEST)
Date: Wed, 15 Sep 2021 08:38:35 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: bibo mao <maobibo@loongson.cn>
Subject: Re: [PATCH 2/2] drm/qxl: Add qxl dma fence release function
Message-ID: <20210915063835.36bhpadzbzuj7shw@sirius.home.kraxel.org>
References: <20210914062352.6102-1-maobibo@loongson.cn>
 <20210914062352.6102-2-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210914062352.6102-2-maobibo@loongson.cn>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Dave Airlie <airlied@redhat.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
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

On Tue, Sep 14, 2021 at 02:23:52AM -0400, bibo mao wrote:
> Add qxl dma fence release function, previously default dma fence
> release function is used, and fence pointer is used to free 
> the memory. With this patch, actual qxl release pointer is used
> to free memory, so that dma fence can put at any place of 
> struct qxl_release.

Why?  Is there a problem with struct dma_fence being the first
element of struct qxl_release?

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
