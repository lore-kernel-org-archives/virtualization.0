Return-Path: <SRS0=TOd4=GZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B08C433E6
	for <virtualization@archiver.kernel.org>; Fri, 22 Jan 2021 13:35:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7238122D50
	for <virtualization@archiver.kernel.org>; Fri, 22 Jan 2021 13:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7238122D50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0693A87382;
	Fri, 22 Jan 2021 13:35:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lUn6oFy+-ngX; Fri, 22 Jan 2021 13:35:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 24E6887366;
	Fri, 22 Jan 2021 13:35:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C470C08A1;
	Fri, 22 Jan 2021 13:35:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AB50C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 13:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 74D3E86ACA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 13:35:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j6FxUN7Fj8Gi
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 13:35:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 95C9286AC9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 13:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611322551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LQpKuSu/XZms0h2vrZRdE58y8K/XKXt6RJB9+QvBgLg=;
 b=DS9MG6YJO0b9Z4crPSqts+qxpek0pnsfDFu/3YQQUNrX/QvWK+mrRejXOgm7Np1/MlzI1F
 4K4pnfcofQiMra3fWiB/TucHmy5TKImJo0kYF/NbnTKVNQLeIaZOhBwRLfoIFtDC8A+EdC
 STOWMadF1uKEnplqnB5+mXZmEIubLfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-OP9_3mXzPNOM-cxgZQGzZA-1; Fri, 22 Jan 2021 08:35:48 -0500
X-MC-Unique: OP9_3mXzPNOM-cxgZQGzZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03C76107ACE3;
 Fri, 22 Jan 2021 13:35:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5DC810023BD;
 Fri, 22 Jan 2021 13:35:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0BE5F18000AB; Fri, 22 Jan 2021 14:35:45 +0100 (CET)
Date: Fri, 22 Jan 2021 14:35:45 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 2/4] drm/qxl: unpin release objects
Message-ID: <20210122133545.acloe4ytgp6r4iql@sirius.home.kraxel.org>
References: <20210120111240.2509679-1-kraxel@redhat.com>
 <20210120111240.2509679-3-kraxel@redhat.com>
 <a4187459-1dbd-e799-fba4-bf7021de831b@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a4187459-1dbd-e799-fba4-bf7021de831b@suse.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

On Fri, Jan 22, 2021 at 09:13:42AM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 20.01.21 um 12:12 schrieb Gerd Hoffmann:
> > Balances the qxl_create_bo(..., pinned=true, ...);
> > call in qxl_release_bo_alloc().
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >   drivers/gpu/drm/qxl/qxl_release.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
> > index 0fcfc952d5e9..add979cba11b 100644
> > --- a/drivers/gpu/drm/qxl/qxl_release.c
> > +++ b/drivers/gpu/drm/qxl/qxl_release.c
> > @@ -166,6 +166,7 @@ qxl_release_free_list(struct qxl_release *release)
> >   		entry = container_of(release->bos.next,
> >   				     struct qxl_bo_list, tv.head);
> >   		bo = to_qxl_bo(entry->tv.bo);
> > +		bo->tbo.pin_count = 0; /* ttm_bo_unpin(&bo->tbo); */
> 
> This code looks like a workaround or a bug.
> 
> AFAICT the only place with pre-pinned BO is qdev->dumb_shadow_bo. Can you
> remove the pinned flag entirely and handle pinning as part of
> dumb_shadow_bo's code.

No, the release objects are pinned too, and they must be
pinned (qxl commands are in there, and references are
placed in the qxl rings, so allowing them to roam is
a non-starter).

> if (pin_count)
>     ttm_bo_unpin();
> WARN_ON(pin_count); /* should always be 0 now */

Well, the pin_count is 1 at this point.
No need for the if().

Just calling ttm_bo_unpin() here makes lockdep unhappy.

Not calling ttm_bo_unpin() makes ttm_bo_release() throw
a WARN() because of the pin.

Clearing pin_count (which is how ttm fixes things up
in the error path) works.

I'm open to better ideas.

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
