Return-Path: <SRS0=I+ly=HU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ECDC433E6
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 11:50:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3283964E4B
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 11:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3283964E4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C9A2D8730E;
	Thu, 18 Feb 2021 11:50:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fplVL6pwODCn; Thu, 18 Feb 2021 11:50:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EDF2F872F9;
	Thu, 18 Feb 2021 11:50:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C88CAC000F;
	Thu, 18 Feb 2021 11:50:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5552CC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 11:50:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3A7FD605EF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 11:50:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G7W2wEaq8C44
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 11:50:55 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 42703605F3; Thu, 18 Feb 2021 11:50:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 757D4605EF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 11:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613649051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BZgRuDjJn+XJlmluwHnTnZxFl0mplVCMFhoWOz62X0g=;
 b=gEm+cEDB01FqUigDZk7+gjMDpGPeMe7Z5qdxbHP6PQvqEnRwqp1+Qf2NFoUjdU8/WvgyQU
 9Bo44vfSfTUiUsgZsy7uKMxIPZS70U+AHYRAiswL0qAHO7CUcJk60JXiJfjT2ERB9Rvgo9
 7tAQXl1rsCjd4oD6ahcN4RJxlHfY5Ys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-vQKdb8bWO8mrdebz26uNYQ-1; Thu, 18 Feb 2021 06:50:48 -0500
X-MC-Unique: vQKdb8bWO8mrdebz26uNYQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FFF9100CCD0;
 Thu, 18 Feb 2021 11:50:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-184.ams2.redhat.com
 [10.36.114.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B8B05D6A1;
 Thu, 18 Feb 2021 11:50:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AC76618000BB; Thu, 18 Feb 2021 12:50:44 +0100 (CET)
Date: Thu, 18 Feb 2021 12:50:44 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 10/11] drm/qxl: rework cursor plane
Message-ID: <20210218115044.7tsi2szbdlw6lvdi@sirius.home.kraxel.org>
References: <20210217123213.2199186-1-kraxel@redhat.com>
 <20210217123213.2199186-11-kraxel@redhat.com>
 <6a5581b2-8e62-1310-d42e-abfa301edc88@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a5581b2-8e62-1310-d42e-abfa301edc88@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@redhat.com>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>
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

> I'm still trying to wrap my head around the qxl cursor code.
> 
> Getting vmap out of the commit tail is good, but I feel like this isn't
> going in the right direction overall.
> 
> In ast, these helper functions were only good when converting the drvier to
> atomic modesetting. So I removed them in the latst patchset and did all the
> updates in the plane helpers directly.

I see the helper functions more as a way to get some structure into the
code flow.  The callbacks are easier to read if they just call helper
functions for stuff which needs more than a handful lines of code
(patch 9/11 exists for the same reason).

The helpers also make it easier move work from one callback to another,
but that is just a useful side-effect.

I had considered making that two separate patches, one factor out code
into functions and one moving the calls.  Turned out to not be that easy
though, because the old qxl_cursor_atomic_update() code was a rather
hairy mix of qxl_create_cursor() + qxl_primary_apply_cursor() +
qxl_primary_move_cursor().

> For cursor_bo itself, it seems to be transitional state that is only used
> during the plane update and crtc update . It should probably be stored in a
> plane-state structure.
> 
> Some of the primary plane's functions seem to deal with cursor handling.
> What's the role of the primary plane in cursor handling?

It's a quirk.  The qxl device will forget the cursor state on
qxl_io_create_primary(), so I have to remember the cursor state
and re-establish it by calling qxl_primary_apply_cursor() again.

So I'm not sure sticking this into plane state would work.  Because of
the quirk this is more than just a handover from prepare to commit.

> For now, I suggest to merge patch 1 to 8 and 11; and move the cursor patches
> into a new patchset.

I can merge 1-8, but 11 has to wait until the cursor is sorted.
There is a reason why 11 is last in the series ;)

> I'd like ot hear Daniel's opinion on this. Do you have
> further plans here?

Well.  I suspect I could easily spend a month cleaning up and party
redesign the qxl driver (specifically qxl_draw.c + qxl_image.c).

I'm not sure I'll find the time to actually do that anytime soon.
I have plenty of other stuff on my TODO list, and given that the
world is transitioning to virtio-gpu the priority for qxl isn't
that high.

So, no, I have no short-term plans for qxl beyond fixing pins +
reservations + lockdep.

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
