Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54617C433F5
	for <virtualization@archiver.kernel.org>; Fri, 26 Nov 2021 04:25:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C15C840414;
	Fri, 26 Nov 2021 04:25:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9DDa9sMvtmkZ; Fri, 26 Nov 2021 04:25:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6103D40341;
	Fri, 26 Nov 2021 04:25:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47437C0012;
	Fri, 26 Nov 2021 04:25:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 665C1C000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 04:25:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4058B4032E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 04:25:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Js5JG0l7_gn0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 04:25:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE57E40012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 04:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637900705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RNyuinrYUjIorS5sJXtfKE+e43f6x0bqwB/NNxQqv9U=;
 b=B7zm8paUWXNMiW6gSsWKuofqhmXtQCtLpqC5lihCL0b6cvOxPKXj6jhj+MqsyW4HScxRz0
 EOapy+GwjusxEAnyVTyBMP95DWEl/Z/x/ee5mUALY6TK4ukc5hRpsbak6rnGMs3ele23g1
 vlkLOUT5xsFfHyeQWfKPhk2YXMYTuI4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45--ovoRVKIPJarFVbhOWsFZw-1; Thu, 25 Nov 2021 23:25:04 -0500
X-MC-Unique: -ovoRVKIPJarFVbhOWsFZw-1
Received: by mail-lf1-f71.google.com with SMTP id
 h40-20020a0565123ca800b00402514d959fso3709995lfv.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 20:25:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RNyuinrYUjIorS5sJXtfKE+e43f6x0bqwB/NNxQqv9U=;
 b=r7sRtIke4sz15Zk6zRWHdspJIIiXmt/G2C7RGkXYXMhj7dbJHbBnoKO880FC9uf8pH
 wigINmVF2swonQY3zThj5LG7VVomuwn3YG4C8Xl8AUP7uTYVEw6pvqT5succByyq1IlR
 JH/w9Xe9qQR12oZGQOGlQzkqewTDg4E78gJtQ9DRgdtsZeTC/8+48oW9YqZ5VKwtDsBd
 0UFsVVbqa5vQGEhIYOhhB9LE8kFRq7OPONC0JhAe7SQFK19AR6+80fwxGGiDc4nWwlLe
 ib0uM0Kk5FKFOu4Zlx3FvZ5UArtsajsk+6p3DmVdcrhAeErkNRcpe4k2gQETcSpKBZCn
 YtEQ==
X-Gm-Message-State: AOAM531Itsie1x5HnJmOaZTidmmt7XFgqPHyPP9GFag/LqRJkQOby2N0
 dHwhtLJaVxRTeP1WSrgeFbBevkG7g6EPgrFinm97EhlO/gywYtv3HEkQHwrhrYY+DLJnLx538Wc
 paz6urNfUDOVG5YTaLIbWEJMPuNr30Mp9dN46cc2RJFBs113TmR1US7PBVQ==
X-Received: by 2002:ac2:5310:: with SMTP id c16mr28677998lfh.580.1637900702520; 
 Thu, 25 Nov 2021 20:25:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPvsPfKHM+Rj6M/Egod2BvWo2JOYYIT5RYrJwBYC0E255AFEf4eG8G9hqk8wQxs1w0Xj8ksAFRnHUjUiOiZYc=
X-Received: by 2002:ac2:5310:: with SMTP id c16mr28677971lfh.580.1637900702275; 
 Thu, 25 Nov 2021 20:25:02 -0800 (PST)
MIME-Version: 1.0
References: <20211124165531.42624-1-elic@nvidia.com>
 <20211124165531.42624-3-elic@nvidia.com>
 <CACGkMEtzoTaXKtNB9+53FboD9XC=O77pDeiGq6ZCbZkXuBZi5Q@mail.gmail.com>
 <20211125075923.GD214101@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211125075923.GD214101@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Nov 2021 12:24:51 +0800
Message-ID: <CACGkMEtmBjGPFogVSfnCv_cxG+==2WkpP867vZStsgvHFSv07g@mail.gmail.com>
Subject: Re: [PATH v1 2/2] vdpa/mlx5: Add support for reading descriptor
 statistics
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, si-wei.liu@oracle.com
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

On Thu, Nov 25, 2021 at 3:59 PM Eli Cohen <elic@nvidia.com> wrote:
>
> On Thu, Nov 25, 2021 at 12:57:53PM +0800, Jason Wang wrote:
> > On Thu, Nov 25, 2021 at 12:56 AM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > Implement the get_vq_stats calback of vdpa_config_ops to return the
> > > statistics for a virtqueue.
> > >
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > ---
> > > V0 -> V1:
> > > Use mutex to sync stats query with change of number of queues
> > >
> >
> > [...]
> >
> > > +static int mlx5_get_vq_stats(struct vdpa_device *vdev, u16 *idx,
> > > +                            struct vdpa_vq_stats *stats)
> > > +{
> > > +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > > +       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > +       struct mlx5_vdpa_virtqueue *mvq = &ndev->vqs[*idx];
> > > +       struct mlx5_control_vq *cvq;
> > > +       int err;
> > > +
> > > +       mutex_lock(&ndev->numq_lock);
> > > +       if ((!ctrl_vq_active(mvdev) && *idx >= ndev->cur_num_vqs) ||
> > > +           (*idx != ctrl_vq_idx(mvdev) && *idx >= ndev->cur_num_vqs)) {
> > > +               err = -EINVAL;
> > > +               goto out;
> >
> > Interesting, I wonder if it's simpler that we just allow stats up to
> > the max vqs. It's sometimes useful to dump the stats of all the vqs so
> > we can let that policy to userspace. Then we can get rid of the mutex.
> >
> If a VQ is not active then I don't have stats for it. The hardware
> object is not available to be queried.

I wonder if it's ok that we just return 0 in this case?

Btw, the cvq counters:

+
+ if (*idx == ctrl_vq_idx(mvdev)) {
+ cvq = &mvdev->cvq;
+ stats->received_desc = cvq->head;
+ stats->completed_desc = cvq->head;
+ stats->ctrl_vq = true;
+ *idx = VDPA_INVAL_QUEUE_INDEX;
+ err = 0;
+ goto out;
+ }

Seems not to consider the case that the head can wrap around.

Thanks


>
> > Thanks
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
