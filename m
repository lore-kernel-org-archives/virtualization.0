Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C74EC433F5
	for <virtualization@archiver.kernel.org>; Fri,  4 Mar 2022 16:46:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1AE8841B2;
	Fri,  4 Mar 2022 16:46:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wnbeoa0pYGH1; Fri,  4 Mar 2022 16:46:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3FCA583147;
	Fri,  4 Mar 2022 16:46:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA947C0012;
	Fri,  4 Mar 2022 16:46:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 134A0C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 16:46:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E09FE40232
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 16:46:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WLRmcnDBCq8o
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 16:46:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B1F9340160
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 16:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646412411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=22jch4CQh+pTPL1FoGU31HpsJfvYTb0PvwQSeG+1PCc=;
 b=Dl+xbleIsyq9NZ0edgh3u0AeG69bMuvgTNPGxd2V+3SxnN7+MRHFpE6PEOSqoIykTIlRMw
 +Hec5c8Bvl6vDchWXw7Xa/R2hzhJrPa0+1T/SeQLtyQSIJWuXI1cIk73nKO148Fc61UGOv
 HXk8RRZ9sFVbRaXHoc5fMRHYohSvTA8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-VPA7AYbjN6meSuoOe-gDHA-1; Fri, 04 Mar 2022 11:46:48 -0500
X-MC-Unique: VPA7AYbjN6meSuoOe-gDHA-1
Received: by mail-wm1-f72.google.com with SMTP id
 7-20020a1c1907000000b003471d9bbe8dso2872504wmz.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 04 Mar 2022 08:46:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=22jch4CQh+pTPL1FoGU31HpsJfvYTb0PvwQSeG+1PCc=;
 b=cSxiADCnp3Nwq4+yr32xF/2kze9ZgjdMBDGCx/6VhyG6lEK72taYzmn/SAYYBuzk/T
 ujSxhlF2BGy1vj9UYKHzQ/1EbQH+qohh8W8NRc3GP+1LBm/FAPNFqIuAirUtU2VmG7Ad
 wCMsyRKrhNcH0GvozOS15DF/XT+e+smYS98Kbk+cg04u/+HDRg2U/4oGqr0g9egNXais
 ZNCXyTmrFI1FGVPts/hOThvftMK8F9CbfXflG/OceXuuZLpubXhwHqJGnkhpy+w1DuVx
 EYISW78ZGsFej3QHERw0hJMbj8MDjEe00vGqb4SH9MbOKCUH4MaMBbE2i3Uhcg5HO+89
 750A==
X-Gm-Message-State: AOAM531As9F4FI2Mtj9G1jFfM0S7rqpGF05YsPs+Mqsfb27Zh/2eq5SB
 HzxhkZPCh0YpAEA3oNJ69+5fY5+IbtgpHUvoUrDe2OoSqlQvZfbyLo80RNOCT7JEaM7ubVnNCEF
 NLsgN8ZPVsLfEte1d5HglQXH8VdBfwlBQdAs/A+kIzQ==
X-Received: by 2002:a1c:2544:0:b0:381:18a:a46d with SMTP id
 l65-20020a1c2544000000b00381018aa46dmr8406745wml.26.1646412407388; 
 Fri, 04 Mar 2022 08:46:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFF5fKg+gUWYVS+WLhpkqM4ArBwfkdD8eN2+pKg3LaCYfmdFOoWkfdheE2gdrSD+91b0K/VA==
X-Received: by 2002:a1c:2544:0:b0:381:18a:a46d with SMTP id
 l65-20020a1c2544000000b00381018aa46dmr8406732wml.26.1646412407138; 
 Fri, 04 Mar 2022 08:46:47 -0800 (PST)
Received: from redhat.com ([2.52.16.157]) by smtp.gmail.com with ESMTPSA id
 l26-20020a05600c1d1a00b00380def7d3desm5711411wms.17.2022.03.04.08.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 08:46:46 -0800 (PST)
Date: Fri, 4 Mar 2022 11:46:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <20220304114606-mutt-send-email-mst@kernel.org>
References: <20220302075421.2131221-1-lee.jones@linaro.org>
 <20220302093446.pjq3djoqi434ehz4@sgarzare-redhat>
 <20220302083413-mutt-send-email-mst@kernel.org>
 <20220302141121.sohhkhtiiaydlv47@sgarzare-redhat>
 <20220302094946-mutt-send-email-mst@kernel.org>
 <20220302153643.glkmvnn2czrgpoyl@sgarzare-redhat>
MIME-Version: 1.0
In-Reply-To: <20220302153643.glkmvnn2czrgpoyl@sgarzare-redhat>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Lee Jones <lee.jones@linaro.org>
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

On Wed, Mar 02, 2022 at 04:36:43PM +0100, Stefano Garzarella wrote:
> On Wed, Mar 02, 2022 at 09:50:38AM -0500, Michael S. Tsirkin wrote:
> > On Wed, Mar 02, 2022 at 03:11:21PM +0100, Stefano Garzarella wrote:
> > > On Wed, Mar 02, 2022 at 08:35:08AM -0500, Michael S. Tsirkin wrote:
> > > > On Wed, Mar 02, 2022 at 10:34:46AM +0100, Stefano Garzarella wrote:
> > > > > On Wed, Mar 02, 2022 at 07:54:21AM +0000, Lee Jones wrote:
> > > > > > vhost_vsock_handle_tx_kick() already holds the mutex during its call
> > > > > > to vhost_get_vq_desc().  All we have to do is take the same lock
> > > > > > during virtqueue clean-up and we mitigate the reported issues.
> > > > > >
> > > > > > Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00
> > > > >
> > > > > This issue is similar to [1] that should be already fixed upstream by [2].
> > > > >
> > > > > However I think this patch would have prevented some issues, because
> > > > > vhost_vq_reset() sets vq->private to NULL, preventing the worker from
> > > > > running.
> > > > >
> > > > > Anyway I think that when we enter in vhost_dev_cleanup() the worker should
> > > > > be already stopped, so it shouldn't be necessary to take the mutex. But in
> > > > > order to prevent future issues maybe it's better to take them, so:
> > > > >
> > > > > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > >
> > > > > [1]
> > > > > https://syzkaller.appspot.com/bug?id=993d8b5e64393ed9e6a70f9ae4de0119c605a822
> > > > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a58da53ffd70294ebea8ecd0eb45fd0d74add9f9
> > > >
> > > >
> > > > Right. I want to queue this but I would like to get a warning
> > > > so we can detect issues like [2] before they cause more issues.
> > > 
> > > I agree, what about moving the warning that we already have higher up, right
> > > at the beginning of the function?
> > > 
> > > I mean something like this:
> > > 
> > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > index 59edb5a1ffe2..1721ff3f18c0 100644
> > > --- a/drivers/vhost/vhost.c
> > > +++ b/drivers/vhost/vhost.c
> > > @@ -692,6 +692,8 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> > >  {
> > >         int i;
> > > +       WARN_ON(!llist_empty(&dev->work_list));
> > > +
> > >         for (i = 0; i < dev->nvqs; ++i) {
> > >                 if (dev->vqs[i]->error_ctx)
> > >                         eventfd_ctx_put(dev->vqs[i]->error_ctx);
> > > @@ -712,7 +714,6 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> > >         dev->iotlb = NULL;
> > >         vhost_clear_msg(dev);
> > >         wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
> > > -       WARN_ON(!llist_empty(&dev->work_list));
> > >         if (dev->worker) {
> > >                 kthread_stop(dev->worker);
> > >                 dev->worker = NULL;
> > > 
> > 
> > Hmm I'm not sure why it matters.
> 
> Because after this new patch, putting locks in the while loop, when we
> finish the loop the workers should be stopped, because vhost_vq_reset() sets
> vq->private to NULL.
> 
> But the best thing IMHO is to check that there is no backend set for each
> vq, so the workers have been stopped correctly at this point.
> 
> Thanks,
> Stefano

It's the list of workers waiting to run though. That is not affected by
vq lock at all.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
