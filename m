Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21102CCA47C
	for <virtualization@archiver.kernel.org>; Thu, 30 Jun 2022 02:02:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9383081438;
	Thu, 30 Jun 2022 02:02:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9383081438
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iuP7n8wI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H9JszXwHmZaC; Thu, 30 Jun 2022 02:02:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D5CE281442;
	Thu, 30 Jun 2022 02:02:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D5CE281442
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8F60C0021;
	Thu, 30 Jun 2022 02:02:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9BE7C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 02:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D60861186
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 02:02:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D60861186
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iuP7n8wI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XvyLazpBl2LI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 02:02:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7293C6117A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7293C6117A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 02:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656554573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J/UlDUYLqcigwLE0YX1GEgm9aBSIjsFv7Xe/qygcons=;
 b=iuP7n8wI4pManZONehuWxadCWt/II13GXnoJ0GKHtXdq5wtUZxRW1QaeE4kaH2n3PLBrCq
 /wTgfpXCBfwsii2quZKi6jdJBFLNfLnRI8QwaaqxhDWbxyfn4VfFzyPJlirDin8AIYSl6n
 SX+f1khr3hgbzqcufLXXzcV+gPCFdAQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-kHnLrAq_M-Gan6aNnApX8Q-1; Wed, 29 Jun 2022 22:02:51 -0400
X-MC-Unique: kHnLrAq_M-Gan6aNnApX8Q-1
Received: by mail-lj1-f198.google.com with SMTP id
 k6-20020a2e9206000000b0025a8ce1a22eso2673268ljg.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 19:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J/UlDUYLqcigwLE0YX1GEgm9aBSIjsFv7Xe/qygcons=;
 b=3oMYNpa848BMBSTrQMT8bDiQVJZ8WYBa+4t8fEulB2zWigJ558ZqI3dVjPLZfxoOGc
 fuCeV6siDSFPSTVpI+7+ucPLQdqFKKNMg+Me10g09VPGF3MemOPFkV4MJXyahA7OKGOf
 n0IJrnTMRhezFuiI5ir75IzA60wWsFWgB5JWWMV083GcN7aS6mlkebuDUhx+2T0qGqmi
 xpzQUgaFyY6DGrvEXawJ/W8K0OceCCrZl1ZrYDQ9D6q5cQEguApH+X8oQJIxNgO7PBbO
 HvXNCWcz4A6i4TaYEA964i3qzS6t3aCege1hECkN5Z7u7DTLzEOQSncfjEwb+sHgGbkR
 zQtw==
X-Gm-Message-State: AJIora8URR2V4hG1X/uy2FnQoR6fZG3kgqfQRP24/uO1aIQb1nQ2dtIx
 QJFftmW1U/3TfuE8qFY7+ZpUU8HGs5ntJuMtjBvoqinMZEqBbxpnmC3y/hBwGcZjXZw4CUN1nXt
 bzBnZoO3nFIQDvRHsIlC/4W0UBxznHHkb1+GUjWCWAktvDXSpHACFrHBUHQ==
X-Received: by 2002:a05:6512:ba1:b0:47f:c0bd:7105 with SMTP id
 b33-20020a0565120ba100b0047fc0bd7105mr4189910lfv.641.1656554570229; 
 Wed, 29 Jun 2022 19:02:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vNWTkihH6pkvrKBypqbOdBygONDjZHT10055+uG0wsOWlT9KEnhkOxnH/nAVszCO8LguXU0b09dd97g9Blvrs=
X-Received: by 2002:a05:6512:ba1:b0:47f:c0bd:7105 with SMTP id
 b33-20020a0565120ba100b0047fc0bd7105mr4189900lfv.641.1656554569999; Wed, 29
 Jun 2022 19:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220628090324.62219-1-jasowang@redhat.com>
 <20220629032106-mutt-send-email-mst@kernel.org>
 <CACGkMEutEYHf8kO_6gpk5BrMAndJPd8wDAPG2_Z9pxSiXXNDCw@mail.gmail.com>
 <20220629044316-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220629044316-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 Jun 2022 10:02:38 +0800
Message-ID: <CACGkMEu5cHnPn737UCzEtuNh8WA8kjMn2irfowpRacGTWu8SXw@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: fix the race between refill work and close
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Wed, Jun 29, 2022 at 4:45 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jun 29, 2022 at 04:36:12PM +0800, Jason Wang wrote:
> > On Wed, Jun 29, 2022 at 3:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Jun 28, 2022 at 05:03:24PM +0800, Jason Wang wrote:
> > > > We try using cancel_delayed_work_sync() to prevent the work from
> > > > enabling NAPI. This is insufficient since we don't disable the the
> > > > source the scheduling
> > >
> > > can't parse this sentence
> >
> > I actually meant "we don't disable the source of the refill work scheduling".
> >
> > >
> > > > of the refill work. This means an NAPI
> > >
> > > what do you mean "an NAPI"? a NAPI poll callback?
> >
> > Yes.
>
> pls post with a fixed log then.

Yes.

>
> > >
> > > > after
> > > > cancel_delayed_work_sync() can schedule the refill work then can
> > > > re-enable the NAPI that leads to use-after-free [1].
> > > >
> > > > Since the work can enable NAPI, we can't simply disable NAPI before
> > > > calling cancel_delayed_work_sync(). So fix this by introducing a
> > > > dedicated boolean to control whether or not the work could be
> > > > scheduled from NAPI.
> > > >
> > > > [1]
> > > > ==================================================================
> > > > BUG: KASAN: use-after-free in refill_work+0x43/0xd4
> > > > Read of size 2 at addr ffff88810562c92e by task kworker/2:1/42
> > > >
> > > > CPU: 2 PID: 42 Comm: kworker/2:1 Not tainted 5.19.0-rc1+ #480
> > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > > > Workqueue: events refill_work
> > > > Call Trace:
> > > >  <TASK>
> > > >  dump_stack_lvl+0x34/0x44
> > > >  print_report.cold+0xbb/0x6ac
> > > >  ? _printk+0xad/0xde
> > > >  ? refill_work+0x43/0xd4
> > > >  kasan_report+0xa8/0x130
> > > >  ? refill_work+0x43/0xd4
> > > >  refill_work+0x43/0xd4
> > > >  process_one_work+0x43d/0x780
> > > >  worker_thread+0x2a0/0x6f0
> > > >  ? process_one_work+0x780/0x780
> > > >  kthread+0x167/0x1a0
> > > >  ? kthread_exit+0x50/0x50
> > > >  ret_from_fork+0x22/0x30
> > > >  </TASK>
> > > > ...
> > > >
> > > > Fixes: b2baed69e605c ("virtio_net: set/cancel work on ndo_open/ndo_stop")
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 38 ++++++++++++++++++++++++++++++++++++--
> > > >  1 file changed, 36 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index db05b5e930be..21bf1e5c81ef 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -251,6 +251,12 @@ struct virtnet_info {
> > > >       /* Does the affinity hint is set for virtqueues? */
> > > >       bool affinity_hint_set;
> > > >
> > > > +     /* Is refill work enabled? */
> > > > +     bool refill_work_enabled;
> > > > +
> > > > +     /* The lock to synchronize the access to refill_work_enabled */
> > > > +     spinlock_t refill_lock;
> > > > +
> > > >       /* CPU hotplug instances for online & dead */
> > > >       struct hlist_node node;
> > > >       struct hlist_node node_dead;
> > > > @@ -348,6 +354,20 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
> > > >       return p;
> > > >  }
> > > >
> > > > +static void enable_refill_work(struct virtnet_info *vi)
> > > > +{
> > > > +     spin_lock(&vi->refill_lock);
> > > > +     vi->refill_work_enabled = true;
> > > > +     spin_unlock(&vi->refill_lock);
> > > > +}
> > > > +
> > > > +static void disable_refill_work(struct virtnet_info *vi)
> > > > +{
> > > > +     spin_lock(&vi->refill_lock);
> > > > +     vi->refill_work_enabled = false;
> > > > +     spin_unlock(&vi->refill_lock);
> > > > +}
> > > > +
> > > >  static void virtqueue_napi_schedule(struct napi_struct *napi,
> > > >                                   struct virtqueue *vq)
> > > >  {
> > > > @@ -1527,8 +1547,12 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
> > > >       }
> > > >
> > > >       if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> > > > -             if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> > > > -                     schedule_delayed_work(&vi->refill, 0);
> > > > +             if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> > > > +                     spin_lock(&vi->refill_lock);
> > > > +                     if (vi->refill_work_enabled)
> > > > +                             schedule_delayed_work(&vi->refill, 0);
> > > > +                     spin_unlock(&vi->refill_lock);
> > > > +             }
> > > >       }
> > > >
> > > >       u64_stats_update_begin(&rq->stats.syncp);
> > > > @@ -1651,6 +1675,8 @@ static int virtnet_open(struct net_device *dev)
> > > >       struct virtnet_info *vi = netdev_priv(dev);
> > > >       int i, err;
> > > >
> > > > +     enable_refill_work(vi);
> > > > +
> > > >       for (i = 0; i < vi->max_queue_pairs; i++) {
> > > >               if (i < vi->curr_queue_pairs)
> > > >                       /* Make sure we have some buffers: if oom use wq. */
> > > > @@ -2033,6 +2059,8 @@ static int virtnet_close(struct net_device *dev)
> > > >       struct virtnet_info *vi = netdev_priv(dev);
> > > >       int i;
> > > >
> > > > +     /* Make sure NAPI doesn't schedule refill work */
> > > > +     disable_refill_work(vi);
> > > >       /* Make sure refill_work doesn't re-enable napi! */
> > > >       cancel_delayed_work_sync(&vi->refill);
> > > >
> > > > @@ -2776,6 +2804,9 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
> > > >       netif_tx_lock_bh(vi->dev);
> > > >       netif_device_detach(vi->dev);
> > > >       netif_tx_unlock_bh(vi->dev);
> > > > +     /* Make sure NAPI doesn't schedule refill work */
> > > > +     disable_refill_work(vi);
> > > > +     /* Make sure refill_work doesn't re-enable napi! */
> > > >       cancel_delayed_work_sync(&vi->refill);
> > > >
> > > >       if (netif_running(vi->dev)) {
> > > > @@ -2799,6 +2830,8 @@ static int virtnet_restore_up(struct virtio_device *vdev)
> > > >
> > > >       virtio_device_ready(vdev);
> > > >
> > > > +     enable_refill_work(vi);
> > > > +
> > > >       if (netif_running(vi->dev)) {
> > > >               for (i = 0; i < vi->curr_queue_pairs; i++)
> > > >                       if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> > > > @@ -3548,6 +3581,7 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > >       vdev->priv = vi;
> > > >
> > > >       INIT_WORK(&vi->config_work, virtnet_config_changed_work);
> > > > +     spin_lock_init(&vi->refill_lock);
> > > >
> > > >       /* If we can receive ANY GSO packets, we must allocate large ones. */
> > > >       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > >
> > >
> > > Can't say I love all the extra state but oh well.
> >
> > I couldn't find a better way. The tricky part is that NAPI and refill
> > can schedule each other so we need a third state.
> >
> > Thanks
>
>
> I wonder whether we can add a napi flag that says going away
> do not schedule, and have napi_enable/napi_disable fail then.

Probably, but not for -stable at least.

We can try it in the future.

Thanks

>
> > >
> > > > --
> > > > 2.25.1
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
