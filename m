Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB7AC4332F
	for <virtualization@archiver.kernel.org>; Wed, 23 Nov 2022 04:01:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 842D2400EA;
	Wed, 23 Nov 2022 04:01:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 842D2400EA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zr2oBVpG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0gMrxaoyvE5g; Wed, 23 Nov 2022 04:01:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0AD8540158;
	Wed, 23 Nov 2022 04:01:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0AD8540158
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1FB4C0033;
	Wed, 23 Nov 2022 04:01:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D2BFC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 04:00:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6217640158
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 04:00:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6217640158
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bKVnEKopgTnV
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 04:00:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 992DC400EA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 992DC400EA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 04:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669176057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uXOKfRkpUg9wQy6d1ZJLStbRoAr5ZPbv5XDNywZlwGg=;
 b=Zr2oBVpGwKxitdIO8wbKUcp7t45iOwhHHcbJSYfyW0SS2ZtwAUTocDSMN4fWFvnxhPZ0cT
 GAw10To/jFKrzOxW4cKTBLrOnCprTn3ALF2GMC2a68u8vWKTCQphp38opHeKHTxX89bhq+
 TFbNAd/O8dnRE9d/1CtgeWzFxBjnfxk=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-653-JB6xSCyWPYiiadDmZuLxHw-1; Tue, 22 Nov 2022 23:00:53 -0500
X-MC-Unique: JB6xSCyWPYiiadDmZuLxHw-1
Received: by mail-oo1-f69.google.com with SMTP id
 j2-20020a4a7502000000b0049bdd099de9so7241292ooc.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 20:00:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uXOKfRkpUg9wQy6d1ZJLStbRoAr5ZPbv5XDNywZlwGg=;
 b=O2Ilfm1Mct61w8hKFuZ8WAZJVn7caIXYkbvxel69hmDTOyzrZ1LF/Dye43AB/vDN8y
 6y7Xrp9Bpveq7YP4M0biF8dYANRTZPgRUJRdLCDHjAbGQ/ao2Cl3mTikPX0F5WZiZQdC
 NRL5r6AbuZ/gnNRydyLC9jyBLAkDqvPgxmQcYmcsFFdGBHoBKcc28af1+AtBdL+THkBF
 UtmdX7Y1H+aoeRVpcSLqQjw/KDmZc3cQCV5oTYSv1zCK2re9xRaM47975VEwAUC8zAFe
 7zwX+DYmULJtZGqRz7J75EHBU7jtDvRsGytZ+AE3kiFehhdGZkn54Lhtb/ffifypvsU3
 QN7g==
X-Gm-Message-State: ANoB5pl/BrRCg7KcjPuQPfRxKStZHBSEgM0UW2xExbVzpFJGPGHTHejz
 IwUpJzFe8t7TWLEf3aBh6wfvP1WnusArVHpDVBrWn1rZEkiDSMEE691aRIuZyxH7XAfjsnj7UUF
 Qzafn1860snDq4uyQLfg0joHrMlgg6L51S/181jd9RPe3ZQ2UD/NBBqJaAg==
X-Received: by 2002:a05:6808:220b:b0:359:f5eb:82ec with SMTP id
 bd11-20020a056808220b00b00359f5eb82ecmr3167000oib.280.1669176053306; 
 Tue, 22 Nov 2022 20:00:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7eJuUQ/K76xaujepZp28qM7Mu71/h/M1uaahfTypXG5ZBtyDoZHYYpgC4AjliCNmigSkjPNTz6fBYpDHh9RHY=
X-Received: by 2002:a05:6808:220b:b0:359:f5eb:82ec with SMTP id
 bd11-20020a056808220b00b00359f5eb82ecmr3166993oib.280.1669176053107; Tue, 22
 Nov 2022 20:00:53 -0800 (PST)
MIME-Version: 1.0
References: <20221113134442.152695-1-elic@nvidia.com>
 <20221113134442.152695-7-elic@nvidia.com>
 <CACGkMEt+7kKD8_q_OFKURbFR1W=YbJpcuwZq5bf5jC4qzE8PEA@mail.gmail.com>
 <DM8PR12MB54008F8D33409AFCA5878AAAAB059@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB54008F8D33409AFCA5878AAAAB059@DM8PR12MB5400.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Nov 2022 12:00:42 +0800
Message-ID: <CACGkMEuoMx2WbUh7KHQXLHuDxQHqhp5xEL8aW3s2wOmBZdv5cA@mail.gmail.com>
Subject: Re: [PATCH 6/7] vdpa/mlx5: Avoid using reslock in event_handler
To: Eli Cohen <elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "lulu@redhat.com" <lulu@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>
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

On Mon, Nov 14, 2022 at 4:58 PM Eli Cohen <elic@nvidia.com> wrote:
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Monday, 14 November 2022 9:53
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: mst@redhat.com; linux-kernel@vger.kernel.org; virtualization@lists.linux-
> > foundation.org; si-wei.liu@oracle.com; eperezma@redhat.com;
> > lulu@redhat.com
> > Subject: Re: [PATCH 6/7] vdpa/mlx5: Avoid using reslock in event_handler
> >
> > On Sun, Nov 13, 2022 at 9:45 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > event_handler runs under atomic context and may not acquire reslock. We
> > > can still guarantee that the handler won't be called after suspend by
> > > clearing nb_registered, unregistering the handler and flushing the
> > > workqueue.
> > >
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 14 +++-----------
> > >  1 file changed, 3 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 6e6490c85be2..bebfba530247 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -2872,8 +2872,8 @@ static int mlx5_vdpa_suspend(struct vdpa_device
> > *vdev)
> > >         int i;
> > >
> > >         down_write(&ndev->reslock);
> > > -       mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> > >         ndev->nb_registered = false;
> > > +       mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> >
> > I wonder why this can help anything.
> I think you were concerned that async events will come when the device was suspended. Since we can't take reslock, I think this guarantees that we won't get any events after suspension.
>

Ok, I see.

> > And if it does, we have simliar
> > logic in mlx5_vdpa_dev_del() do we need to fix that as well?
> >
> We have the same construct there only that I set nb_registered = false after unregistering the notifier. So I probably need to move it before mlx5_notifier_unregister().

Right.

Thanks

>
> > Thanks
> >
> > >         flush_workqueue(ndev->mvdev.wq);
> > >         for (i = 0; i < ndev->cur_num_vqs; i++) {
> > >                 mvq = &ndev->vqs[i];
> > > @@ -3051,7 +3051,7 @@ static void update_carrier(struct work_struct
> > *work)
> > >         else
> > >                 ndev->config.status &= cpu_to_mlx5vdpa16(mvdev,
> > ~VIRTIO_NET_S_LINK_UP);
> > >
> > > -       if (ndev->config_cb.callback)
> > > +       if (ndev->nb_registered && ndev->config_cb.callback)
> > >                 ndev->config_cb.callback(ndev->config_cb.private);
> > >
> > >         kfree(wqent);
> > > @@ -3068,21 +3068,13 @@ static int event_handler(struct notifier_block
> > *nb, unsigned long event, void *p
> > >                 switch (eqe->sub_type) {
> > >                 case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
> > >                 case MLX5_PORT_CHANGE_SUBTYPE_ACTIVE:
> > > -                       down_read(&ndev->reslock);
> > > -                       if (!ndev->nb_registered) {
> > > -                               up_read(&ndev->reslock);
> > > -                               return NOTIFY_DONE;
> > > -                       }
> > >                         wqent = kzalloc(sizeof(*wqent), GFP_ATOMIC);
> > > -                       if (!wqent) {
> > > -                               up_read(&ndev->reslock);
> > > +                       if (!wqent)
> > >                                 return NOTIFY_DONE;
> > > -                       }
> > >
> > >                         wqent->mvdev = &ndev->mvdev;
> > >                         INIT_WORK(&wqent->work, update_carrier);
> > >                         queue_work(ndev->mvdev.wq, &wqent->work);
> > > -                       up_read(&ndev->reslock);
> > >                         ret = NOTIFY_OK;
> > >                         break;
> > >                 default:
> > > --
> > > 2.38.1
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
