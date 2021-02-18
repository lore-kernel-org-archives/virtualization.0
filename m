Return-Path: <SRS0=I+ly=HU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B95BC433DB
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 14:23:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93CDD64EB4
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 14:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93CDD64EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DBCC0864F4;
	Thu, 18 Feb 2021 14:23:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lrw0DJCAhAg6; Thu, 18 Feb 2021 14:23:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BDBCC8638F;
	Thu, 18 Feb 2021 14:23:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA71CC000F;
	Thu, 18 Feb 2021 14:23:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E279C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 14:23:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 13908605EF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 14:23:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lS-VI92iWQ9P
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 14:23:15 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id CC5C8605FE; Thu, 18 Feb 2021 14:23:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 56144605EF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 14:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613658193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B0Np6RmIQw2V0BL+Pl69+jda/IWr90txxGD9/gHBjqQ=;
 b=IMc1o8MaUhF0sbdADfGfpNSDQF5Dd7OeABoAci4CBNSmysHWIHxa/fONJcic23uUpG2UrT
 SgFKXGXgveSkES6A+np1Vzi/9ubbRON1dua9quMGHMPnt595w99YYUdg7iYgQzeyJBREPl
 7B5hA6TgKuXRnR/GlDyHELiANXrlyfU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-MrPlxZAFN1-CBrxEqE7XnQ-1; Thu, 18 Feb 2021 09:23:10 -0500
X-MC-Unique: MrPlxZAFN1-CBrxEqE7XnQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D26980197C;
 Thu, 18 Feb 2021 14:23:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-184.ams2.redhat.com
 [10.36.114.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCD0019D9F;
 Thu, 18 Feb 2021 14:23:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9A48118000B7; Thu, 18 Feb 2021 15:23:06 +0100 (CET)
Date: Thu, 18 Feb 2021 15:23:06 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 10/11] drm/qxl: rework cursor plane
Message-ID: <20210218142306.zlogw344is46q3yl@sirius.home.kraxel.org>
References: <20210217123213.2199186-1-kraxel@redhat.com>
 <20210217123213.2199186-11-kraxel@redhat.com>
 <6a5581b2-8e62-1310-d42e-abfa301edc88@suse.de>
 <20210218115044.7tsi2szbdlw6lvdi@sirius.home.kraxel.org>
 <2d7a649c-bf1d-aa41-8d3c-af9746b94bc0@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2d7a649c-bf1d-aa41-8d3c-af9746b94bc0@suse.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@redhat.com>
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

> > Well.  I suspect I could easily spend a month cleaning up and party
> > redesign the qxl driver (specifically qxl_draw.c + qxl_image.c).
> > 
> > I'm not sure I'll find the time to actually do that anytime soon.
> > I have plenty of other stuff on my TODO list, and given that the
> > world is transitioning to virtio-gpu the priority for qxl isn't
> > that high.
> 
> Well, in that case:
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> for patches 9 and 10. Having the vmap calls fixed is at least worth it.

Thanks.  Any chance you can ack 8/11 too (only patch missing an ack).

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
