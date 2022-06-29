Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C10FC433EF
	for <virtualization@archiver.kernel.org>; Wed, 29 Jun 2022 08:45:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E84B583F90;
	Wed, 29 Jun 2022 08:45:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E84B583F90
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yj6WGTfI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jNJGDGP7NqIc; Wed, 29 Jun 2022 08:45:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 43E7A83F64;
	Wed, 29 Jun 2022 08:45:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 43E7A83F64
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA1D5C0032;
	Wed, 29 Jun 2022 08:45:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95075C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 08:45:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A7D141978
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 08:45:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A7D141978
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yj6WGTfI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BskmxUCe59dR
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 08:45:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B57B40195
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B57B40195
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 08:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656492302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ce8LCIJWlyU+gKAFW1266Y8Jb/qLrB5BB1Xt2Vb9bMA=;
 b=Yj6WGTfIOhd/LaUklETH0qnz61VlocKi9OWXnH+GCNUWL+F86ciEJ+6KBaP8AHR85k77nx
 bPvXcvsqqTy6gh1jFhVor6QGexoNPIFUCpdP3UTnGit0dg0wIsX08L0D4aGBu4P4Wj0gHk
 JxWTa/znwgyL15/e4nKJAHBSxr9++Vw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-WqKtX7IJNYOHBWbhTGnenA-1; Wed, 29 Jun 2022 04:45:01 -0400
X-MC-Unique: WqKtX7IJNYOHBWbhTGnenA-1
Received: by mail-wr1-f70.google.com with SMTP id
 r20-20020adfb1d4000000b0021b8507563eso2208479wra.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 01:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ce8LCIJWlyU+gKAFW1266Y8Jb/qLrB5BB1Xt2Vb9bMA=;
 b=KCdwVK6AkIE4Mnc2pYS4K3mv/guXjAnJcM3VDHucA1Wz+hB4/hTl/soMzFQ8MQDst+
 EYhYEJ4nDE2tvZK2P2ni+PIaor6+6R2mpaMuM3ucefd/fUuHLyKwsNITzbxea+I8m3vG
 sD0nsgv1cyuKNq9/SndkKhnxC91yOIElur3qydT2qzdc+MSyXVatM0Qukqn86f5r7IdU
 4FGlxEY6y0AUU07R4yfl+uDHpR8BQq7W4vPLvqRLfacuv4+i4iRBjebDZKTA9KP2tGC0
 1wew75rf2AhHaTIb2KeBUHYq/M/MSP4J/OPex6oMzZp54OxH7ZWgHiHAaiVoHpGBENxf
 yxRg==
X-Gm-Message-State: AJIora9TIE6FzBykiY7tunfRN7vy44JBGapY89sgj4MtWWlkRcj6imrP
 g86nGOUWFQBJJ3YmwebDy4ySi/Nq2RlMCYOdXVW/LLmOdMuuCtkX1YTN79r9FNIm5yJ9gpup+GF
 8setVAKPic2d2UFEXpqXgQiSkUDMvU23e8BaNTtRPRA==
X-Received: by 2002:a05:600c:41d1:b0:3a0:301d:f75f with SMTP id
 t17-20020a05600c41d100b003a0301df75fmr4234830wmh.31.1656492300135; 
 Wed, 29 Jun 2022 01:45:00 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vq81KZkWHPP6HoDbBvjIka45K9E4a+OATXJO8gsMLATGBlbrgfVU1VS4agrmPdzgbyKsGUnQ==
X-Received: by 2002:a05:600c:41d1:b0:3a0:301d:f75f with SMTP id
 t17-20020a05600c41d100b003a0301df75fmr4234805wmh.31.1656492299865; 
 Wed, 29 Jun 2022 01:44:59 -0700 (PDT)
Received: from redhat.com ([2.52.23.204]) by smtp.gmail.com with ESMTPSA id
 t11-20020adff60b000000b0021b962f4256sm15540856wrp.80.2022.06.29.01.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jun 2022 01:44:59 -0700 (PDT)
Date: Wed, 29 Jun 2022 04:44:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio-net: fix the race between refill work and close
Message-ID: <20220629044316-mutt-send-email-mst@kernel.org>
References: <20220628090324.62219-1-jasowang@redhat.com>
 <20220629032106-mutt-send-email-mst@kernel.org>
 <CACGkMEutEYHf8kO_6gpk5BrMAndJPd8wDAPG2_Z9pxSiXXNDCw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEutEYHf8kO_6gpk5BrMAndJPd8wDAPG2_Z9pxSiXXNDCw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>,
 davem <davem@davemloft.net>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Wed, Jun 29, 2022 at 04:36:12PM +0800, Jason Wang wrote:
> On Wed, Jun 29, 2022 at 3:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jun 28, 2022 at 05:03:24PM +0800, Jason Wang wrote:
> > > We try using cancel_delayed_work_sync() to prevent the work from
> > > enabling NAPI. This is insufficient since we don't disable the the
> > > source the scheduling
> >
> > can't parse this sentence
> 
> I actually meant "we don't disable the source of the refill work scheduling".
> 
> >
> > > of the refill work. This means an NAPI
> >
> > what do you mean "an NAPI"? a NAPI poll callback?
> 
> Yes.

pls post with a fixed log then.

> >
> > > after
> > > cancel_delayed_work_sync() can schedule the refill work then can
> > > re-enable the NAPI that leads to use-after-free [1].
> > >
> > > Since the work can enable NAPI, we can't simply disable NAPI before
> > > calling cancel_delayed_work_sync(). So fix this by introducing a
> > > dedicated boolean to control whether or not the work could be
> > > scheduled from NAPI.
> > >
> > > [1]
> > > ==================================================================
> > > BUG: KASAN: use-after-free in refill_work+0x43/0xd4
> > > Read of size 2 at addr ffff88810562c92e by task kworker/2:1/42
> > >
> > > CPU: 2 PID: 42 Comm: kworker/2:1 Not tainted 5.19.0-rc1+ #480
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > > Workqueue: events refill_work
> > > Call Trace:
> > >  <TASK>
> > >  dump_stack_lvl+0x34/0x44
> > >  print_report.cold+0xbb/0x6ac
> > >  ? _printk+0xad/0xde
> > >  ? refill_work+0x43/0xd4
> > >  kasan_report+0xa8/0x130
> > >  ? refill_work+0x43/0xd4
> > >  refill_work+0x43/0xd4
> > >  process_one_work+0x43d/0x780
> > >  worker_thread+0x2a0/0x6f0
> > >  ? process_one_work+0x780/0x780
> > >  kthread+0x167/0x1a0
> > >  ? kthread_exit+0x50/0x50
> > >  ret_from_fork+0x22/0x30
> > >  </TASK>
> > > ...
> > >
> > > Fixes: b2baed69e605c ("virtio_net: set/cancel work on ndo_open/ndo_stop")
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/net/virtio_net.c | 38 ++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 36 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index db05b5e930be..21bf1e5c81ef 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -251,6 +251,12 @@ struct virtnet_info {
> > >       /* Does the affinity hint is set for virtqueues? */
> > >       bool affinity_hint_set;
> > >
> > > +     /* Is refill work enabled? */
> > > +     bool refill_work_enabled;
> > > +
> > > +     /* The lock to synchronize the access to refill_work_enabled */
> > > +     spinlock_t refill_lock;
> > > +
> > >       /* CPU hotplug instances for online & dead */
> > >       struct hlist_node node;
> > >       struct hlist_node node_dead;
> > > @@ -348,6 +354,20 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
> > >       return p;
> > >  }
> > >
> > > +static void enable_refill_work(struct virtnet_info *vi)
> > > +{
> > > +     spin_lock(&vi->refill_lock);
> > > +     vi->refill_work_enabled = true;
> > > +     spin_unlock(&vi->refill_lock);
> > > +}
> > > +
> > > +static void disable_refill_work(struct virtnet_info *vi)
> > > +{
> > > +     spin_lock(&vi->refill_lock);
> > > +     vi->refill_work_enabled = false;
> > > +     spin_unlock(&vi->refill_lock);
> > > +}
> > > +
> > >  static void virtqueue_napi_schedule(struct napi_struct *napi,
> > >                                   struct virtqueue *vq)
> > >  {
> > > @@ -1527,8 +1547,12 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
> > >       }
> > >
> > >       if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> > > -             if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> > > -                     schedule_delayed_work(&vi->refill, 0);
> > > +             if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> > > +                     spin_lock(&vi->refill_lock);
> > > +                     if (vi->refill_work_enabled)
> > > +                             schedule_delayed_work(&vi->refill, 0);
> > > +                     spin_unlock(&vi->refill_lock);
> > > +             }
> > >       }
> > >
> > >       u64_stats_update_begin(&rq->stats.syncp);
> > > @@ -1651,6 +1675,8 @@ static int virtnet_open(struct net_device *dev)
> > >       struct virtnet_info *vi = netdev_priv(dev);
> > >       int i, err;
> > >
> > > +     enable_refill_work(vi);
> > > +
> > >       for (i = 0; i < vi->max_queue_pairs; i++) {
> > >               if (i < vi->curr_queue_pairs)
> > >                       /* Make sure we have some buffers: if oom use wq. */
> > > @@ -2033,6 +2059,8 @@ static int virtnet_close(struct net_device *dev)
> > >       struct virtnet_info *vi = netdev_priv(dev);
> > >       int i;
> > >
> > > +     /* Make sure NAPI doesn't schedule refill work */
> > > +     disable_refill_work(vi);
> > >       /* Make sure refill_work doesn't re-enable napi! */
> > >       cancel_delayed_work_sync(&vi->refill);
> > >
> > > @@ -2776,6 +2804,9 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
> > >       netif_tx_lock_bh(vi->dev);
> > >       netif_device_detach(vi->dev);
> > >       netif_tx_unlock_bh(vi->dev);
> > > +     /* Make sure NAPI doesn't schedule refill work */
> > > +     disable_refill_work(vi);
> > > +     /* Make sure refill_work doesn't re-enable napi! */
> > >       cancel_delayed_work_sync(&vi->refill);
> > >
> > >       if (netif_running(vi->dev)) {
> > > @@ -2799,6 +2830,8 @@ static int virtnet_restore_up(struct virtio_device *vdev)
> > >
> > >       virtio_device_ready(vdev);
> > >
> > > +     enable_refill_work(vi);
> > > +
> > >       if (netif_running(vi->dev)) {
> > >               for (i = 0; i < vi->curr_queue_pairs; i++)
> > >                       if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> > > @@ -3548,6 +3581,7 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >       vdev->priv = vi;
> > >
> > >       INIT_WORK(&vi->config_work, virtnet_config_changed_work);
> > > +     spin_lock_init(&vi->refill_lock);
> > >
> > >       /* If we can receive ANY GSO packets, we must allocate large ones. */
> > >       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> >
> >
> > Can't say I love all the extra state but oh well.
> 
> I couldn't find a better way. The tricky part is that NAPI and refill
> can schedule each other so we need a third state.
> 
> Thanks


I wonder whether we can add a napi flag that says going away
do not schedule, and have napi_enable/napi_disable fail then.

> >
> > > --
> > > 2.25.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
