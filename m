Return-Path: <SRS0=TOd4=GZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C65C433E6
	for <virtualization@archiver.kernel.org>; Fri, 22 Jan 2021 13:55:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4A122D57
	for <virtualization@archiver.kernel.org>; Fri, 22 Jan 2021 13:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4A122D57
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C8CE68739B;
	Fri, 22 Jan 2021 13:55:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zt4t81PsO+7n; Fri, 22 Jan 2021 13:55:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6178087390;
	Fri, 22 Jan 2021 13:55:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C2C5C08A1;
	Fri, 22 Jan 2021 13:55:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A65EEC013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 13:55:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 89F1C870C4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 13:55:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pxmaBx-tYtjF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 13:55:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2F68D870A8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 13:55:02 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id q205so5974105oig.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 05:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VXLHixBiJpq4dDQEs6Gtzm6NcpCMBkU8X2Af5+47SP8=;
 b=fRMpTwPjIHUaiFQn3JWCshKMbvL/9jw9UTg2r5aLKcTL6wI8i5Aeh+fcc5fL/Qw2dr
 5mbSk7k9MXRDR/3PFkmwZsS9bakHodMpF6ufpYOGwwr3Kkxpe7KZY5pWhLhMuKeqOhYu
 Jj0Eb+R39koAF7xKwpPGpp19H95FqvvjmmP2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VXLHixBiJpq4dDQEs6Gtzm6NcpCMBkU8X2Af5+47SP8=;
 b=ahXZe61h0f0DPStafQiT4RDFt9bZN+Djv7U064nmhdqej6SX0MtJ15kW+cREHUzkQk
 TbLsigf2fMQZQy997AjS9UV7Ks8uT+DnT4FtdUXAqvMBmYoeFbEFtUh5b+ZL+57Xhrrz
 eR+Chn5morkct+xCdK1b7tJlrquS43gLEVGAaAN7YlnLtop8s0DNF2JfO+RfPeuaqFYR
 iZNYZlBflU8GZnG/h46yflnyhQsMcF9RqctNXJtN7iSy+zenD6ZCOiefHebJcnpXfvLr
 CcgMwFYOdKhjxAHzO5buKF+r/AJMBPhLat7TADo+57jlwwETiW9LYv/ItdzTIZxJdzLh
 CVPw==
X-Gm-Message-State: AOAM532B/W69NuvmR0UC0iL+CyEnffNn8ZI4wiVGEqbMMhPb5LcS+rar
 bEcczJdtYOwvmXzDq7Xj+8yppziD5dAbInacMxqUbg==
X-Google-Smtp-Source: ABdhPJwW4KEp6S+mGGfS/0Lx+8OAYX5f6OO9aCFkx+hayuV7D2MQb1meuWL+LmKrJUAXW2513f7/HixYeilJ9rFPIxk=
X-Received: by 2002:aca:1906:: with SMTP id l6mr3220663oii.101.1611323702207; 
 Fri, 22 Jan 2021 05:55:02 -0800 (PST)
MIME-Version: 1.0
References: <20210120111240.2509679-1-kraxel@redhat.com>
 <20210120111240.2509679-3-kraxel@redhat.com>
 <a4187459-1dbd-e799-fba4-bf7021de831b@suse.de>
 <20210122133545.acloe4ytgp6r4iql@sirius.home.kraxel.org>
In-Reply-To: <20210122133545.acloe4ytgp6r4iql@sirius.home.kraxel.org>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 22 Jan 2021 14:54:51 +0100
Message-ID: <CAKMK7uHeQt6VPkm0ufuVVxdGQkmq3+1vrDERzZS54rtcVhJRAw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] drm/qxl: unpin release objects
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
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

On Fri, Jan 22, 2021 at 2:35 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Fri, Jan 22, 2021 at 09:13:42AM +0100, Thomas Zimmermann wrote:
> > Hi
> >
> > Am 20.01.21 um 12:12 schrieb Gerd Hoffmann:
> > > Balances the qxl_create_bo(..., pinned=true, ...);
> > > call in qxl_release_bo_alloc().
> > >
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > ---
> > >   drivers/gpu/drm/qxl/qxl_release.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
> > > index 0fcfc952d5e9..add979cba11b 100644
> > > --- a/drivers/gpu/drm/qxl/qxl_release.c
> > > +++ b/drivers/gpu/drm/qxl/qxl_release.c
> > > @@ -166,6 +166,7 @@ qxl_release_free_list(struct qxl_release *release)
> > >             entry = container_of(release->bos.next,
> > >                                  struct qxl_bo_list, tv.head);
> > >             bo = to_qxl_bo(entry->tv.bo);
> > > +           bo->tbo.pin_count = 0; /* ttm_bo_unpin(&bo->tbo); */
> >
> > This code looks like a workaround or a bug.
> >
> > AFAICT the only place with pre-pinned BO is qdev->dumb_shadow_bo. Can you
> > remove the pinned flag entirely and handle pinning as part of
> > dumb_shadow_bo's code.
>
> No, the release objects are pinned too, and they must be
> pinned (qxl commands are in there, and references are
> placed in the qxl rings, so allowing them to roam is
> a non-starter).
>
> > if (pin_count)
> >     ttm_bo_unpin();
> > WARN_ON(pin_count); /* should always be 0 now */
>
> Well, the pin_count is 1 at this point.
> No need for the if().
>
> Just calling ttm_bo_unpin() here makes lockdep unhappy.

How does that one splat? But yeah if that's a problem should be
explained in the comment. I'd then also only do a pin_count--; to make
sure you can still catch other pin leaks if you have them. Setting it
to 0 kinda defeats the warning.
-Daniel

>
> Not calling ttm_bo_unpin() makes ttm_bo_release() throw
> a WARN() because of the pin.
>
> Clearing pin_count (which is how ttm fixes things up
> in the error path) works.
>
> I'm open to better ideas.
>
> take care,
>   Gerd
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
