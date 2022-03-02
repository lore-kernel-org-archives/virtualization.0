Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6C4C433FE
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 16:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F73160ACF;
	Wed,  2 Mar 2022 16:30:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p_b26bH7GS5q; Wed,  2 Mar 2022 16:30:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C92C660B4E;
	Wed,  2 Mar 2022 16:30:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DD0CC0012;
	Wed,  2 Mar 2022 16:30:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 380F3C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 16:30:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 25BF68143F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 16:30:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x6_zEU5g9zLF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 16:30:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C20E8143C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 16:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646238638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kMa9v1xtxt05GLfYOo70TOSVE9rMZc+g01ANVJtihbg=;
 b=MaacKvHkNsLjWoCPZa8mLq/AT11yQo0qyhd/KFR1apt1uZiQCf77Hi1ARS/Pf7+X2nU3/0
 yU3554Y6sr4y7ldl4qnc4P84HE+6tpA+WMLLfxBmpwrNDddrcIvbihjYvDW6Y3zadPJoea
 vfZNGZY0/UC446Wh8hm8oXEEMsqu7ac=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-tr0cd7A2Nw6eBooXC8XLKg-1; Wed, 02 Mar 2022 11:30:36 -0500
X-MC-Unique: tr0cd7A2Nw6eBooXC8XLKg-1
Received: by mail-wm1-f71.google.com with SMTP id
 h206-20020a1c21d7000000b003552c13626cso2116116wmh.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 08:30:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kMa9v1xtxt05GLfYOo70TOSVE9rMZc+g01ANVJtihbg=;
 b=XNpyoXg1kz6LwzF0uQ8Mh4dlx8HL+hjr/bbgrsxQUOx94ZWV3L3XBm53/0a7YlCBam
 aUCzWVotS5T5tf0W5PTrez+o6eqmZLKho74dFMkZhoVKH0gR62htIKFryVkNsWuNPOwV
 9XZYnxXvbIS3IDR9GdO+aKr1UkGeoAOltV0fD3wFbTJD6WOFh1JrhCw+R9er1icxdkH5
 v/kqvS7KcwMLorBAC8s5Li9DqYBQ6Aid1q022iaJz6W9/7bF47QpWcgREf9ryQ8BwvpN
 thxhZHUdF5UnUI+WK316za0gmAZCM1Qcoc8t0eFaYTfNm9U5IzyWe+Lwq5iAB4ebKggZ
 43uA==
X-Gm-Message-State: AOAM531CFKja7KrkG+qkX74SYgqKHKYKTD/nmW2mkU3bR7Kk8UpLLuTD
 5HUnSYv7IiAamPy9sEbVm3vi5PiGETsrQUpe0g+G9HS0dRnwqvxP7jx2fRtbXkRRR+1E2l4a6/N
 e6y9AGipX1kYDq+eldqbV6Hb6gUDFQjwbY0GePXYumA==
X-Received: by 2002:a7b:c14c:0:b0:381:32fb:a128 with SMTP id
 z12-20020a7bc14c000000b0038132fba128mr489125wmi.116.1646238634138; 
 Wed, 02 Mar 2022 08:30:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPFSyJJ3cuBRpkY9KOm5MVNCqPvFnh7F/Ims38I9cMHs0dlB6ZbjMEGiiJX+VRcZzNYFLg0w==
X-Received: by 2002:a7b:c14c:0:b0:381:32fb:a128 with SMTP id
 z12-20020a7bc14c000000b0038132fba128mr489104wmi.116.1646238633941; 
 Wed, 02 Mar 2022 08:30:33 -0800 (PST)
Received: from redhat.com ([2a10:8006:355c:0:48d6:b937:2fb9:b7de])
 by smtp.gmail.com with ESMTPSA id
 o11-20020adf9d4b000000b001f0077ea337sm5972902wre.22.2022.03.02.08.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 08:30:33 -0800 (PST)
Date: Wed, 2 Mar 2022 11:30:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <20220302112945-mutt-send-email-mst@kernel.org>
References: <20220302075421.2131221-1-lee.jones@linaro.org>
 <20220302082021-mutt-send-email-mst@kernel.org>
 <Yh93k2ZKJBIYQJjp@google.com>
 <20220302095045-mutt-send-email-mst@kernel.org>
 <Yh+F1gkCGoYF2lMV@google.com>
 <CAGxU2F4cUDrMzoHH1NT5_ivxBPgEE8HOzP5s_Bt5JURRaSsLdQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGxU2F4cUDrMzoHH1NT5_ivxBPgEE8HOzP5s_Bt5JURRaSsLdQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com,
 kvm <kvm@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Lee Jones <lee.jones@linaro.org>
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

On Wed, Mar 02, 2022 at 05:28:31PM +0100, Stefano Garzarella wrote:
> On Wed, Mar 2, 2022 at 3:57 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Wed, 02 Mar 2022, Michael S. Tsirkin wrote:
> >
> > > On Wed, Mar 02, 2022 at 01:56:35PM +0000, Lee Jones wrote:
> > > > On Wed, 02 Mar 2022, Michael S. Tsirkin wrote:
> > > >
> > > > > On Wed, Mar 02, 2022 at 07:54:21AM +0000, Lee Jones wrote:
> > > > > > vhost_vsock_handle_tx_kick() already holds the mutex during its call
> > > > > > to vhost_get_vq_desc().  All we have to do is take the same lock
> > > > > > during virtqueue clean-up and we mitigate the reported issues.
> > > > > >
> > > > > > Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00
> > > > > >
> > > > > > Cc: <stable@vger.kernel.org>
> > > > > > Reported-by: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
> > > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > > ---
> > > > > >  drivers/vhost/vhost.c | 2 ++
> > > > > >  1 file changed, 2 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > > > index 59edb5a1ffe28..bbaff6a5e21b8 100644
> > > > > > --- a/drivers/vhost/vhost.c
> > > > > > +++ b/drivers/vhost/vhost.c
> > > > > > @@ -693,6 +693,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> > > > > >         int i;
> > > > > >
> > > > > >         for (i = 0; i < dev->nvqs; ++i) {
> > > > > > +               mutex_lock(&dev->vqs[i]->mutex);
> > > > > >                 if (dev->vqs[i]->error_ctx)
> > > > > >                         eventfd_ctx_put(dev->vqs[i]->error_ctx);
> > > > > >                 if (dev->vqs[i]->kick)
> > > > > > @@ -700,6 +701,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> > > > > >                 if (dev->vqs[i]->call_ctx.ctx)
> > > > > >                         eventfd_ctx_put(dev->vqs[i]->call_ctx.ctx);
> > > > > >                 vhost_vq_reset(dev, dev->vqs[i]);
> > > > > > +               mutex_unlock(&dev->vqs[i]->mutex);
> > > > > >         }
> > > > >
> > > > > So this is a mitigation plan but the bug is still there though
> > > > > we don't know exactly what it is.  I would prefer adding something like
> > > > > WARN_ON(mutex_is_locked(vqs[i]->mutex) here - does this make sense?
> > > >
> > > > As a rework to this, or as a subsequent patch?
> > >
> > > Can be a separate patch.
> > >
> > > > Just before the first lock I assume?
> > >
> > > I guess so, yes.
> >
> > No problem.  Patch to follow.
> >
> > I'm also going to attempt to debug the root cause, but I'm new to this
> > subsystem to it might take a while for me to get my head around.
> 
> IIUC the root cause should be the same as the one we solved here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a58da53ffd70294ebea8ecd0eb45fd0d74add9f9
> 
> The worker was not stopped before calling vhost_dev_cleanup(). So while 
> the worker was still running we were going to free memory or initialize 
> fields while it was still using virtqueue.
> 
> Cheers,
> Stefano

Right, and I agree but it's not the root though, we do attempt to stop all workers.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
