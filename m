Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F26CC433EF
	for <virtualization@archiver.kernel.org>; Thu, 30 Jun 2022 06:32:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 847CB61314;
	Thu, 30 Jun 2022 06:32:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 847CB61314
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W5+fGtS6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QMSJpiwPlz3H; Thu, 30 Jun 2022 06:32:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E519F61316;
	Thu, 30 Jun 2022 06:32:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E519F61316
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3AADC002D;
	Thu, 30 Jun 2022 06:32:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D61CC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 06:32:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6067140966
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 06:32:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6067140966
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=W5+fGtS6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CY3-RcAt1RNI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 06:32:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 454AE40A65
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 454AE40A65
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 06:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656570725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JCFLB3gZtfT5O37DFv5kX6RHaI4wR9lTgo57exxBmSc=;
 b=W5+fGtS6FlGDxqxEaZBliOhFWiEwvXXg1CdL5xCSsZ/QF2uzufHCBfQV/eBAOny1dleUCi
 W/Jqua3fPAlEUbCqr9YO23HnzjPg3mhPOGPN0IE56DqkLJfqvrMUA8TmvS3Q6nIVheTzE2
 DR2CDPLmJEjrEf9Sd2oweidF1CQXkkY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-TZVqs6IAOGGFwa6lmB4HYA-1; Thu, 30 Jun 2022 02:32:03 -0400
X-MC-Unique: TZVqs6IAOGGFwa6lmB4HYA-1
Received: by mail-lj1-f198.google.com with SMTP id
 k3-20020a2ea283000000b0025bcd580d43so1906722lja.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 23:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JCFLB3gZtfT5O37DFv5kX6RHaI4wR9lTgo57exxBmSc=;
 b=RMYYgn9qlIkR0c4Bli36PYp7kB2XOEQeY0YrmEUMbPwGFruZTTUlgOXzFdbw3Is6pb
 zJTJfQ5dy81FMej6IRTDzTDUYU7PAmVBiCOGx4oInN2lJ7X2TlnPscW0CzhGbEbT4bF6
 gAxMNnteU9QINyK68OS20Q0ohtuew5bqULO8IdlUz+PtGxNdQzKoCCz99aAKtVSWNm+i
 uAYCEgccFUFJNYBNp2TGPG7mkNBLFTWxfFAGh/Luipf8toIgqmLNl4BlCkoRwY7zLFya
 +eJV5dZsA9MGr5LAHLZTnb0iYYajHcgCeXk92Q+W+IG3jObO9cbSGjs48Htn0Ym1GgG/
 3x+g==
X-Gm-Message-State: AJIora9Dn6wwCOArkwP/aNAsO063ibiUal3lx7DDkBwKcMQYRzfDVDuz
 7FW8538hibKWhEbvSF5fmgl13Y2iA6L0/9a5QHBnCuwJtQHptqmTiRrG470ax8TYKe+ywHyXLix
 EEdJnOsdNMg6TNPgyZUHVN0/Msfad2+o9iE8o9N+3ASsrFbw/JBrTxnk6tA==
X-Received: by 2002:a05:6512:13a5:b0:47d:c1d9:dea8 with SMTP id
 p37-20020a05651213a500b0047dc1d9dea8mr4362246lfa.442.1656570721725; 
 Wed, 29 Jun 2022 23:32:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tce7yU1sJnXz77ARVxInNfPquob/R63ZeXhVpWoKTGT/+yZHlqbZssYwg4b69Y4LOXiaqvhMzHYERN/zHh6lE=
X-Received: by 2002:a05:6512:13a5:b0:47d:c1d9:dea8 with SMTP id
 p37-20020a05651213a500b0047dc1d9dea8mr4362230lfa.442.1656570721449; Wed, 29
 Jun 2022 23:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220630020805.74658-1-jasowang@redhat.com>
 <1656555045.7370687-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEvMrxWRNY_NbujLsWff4zMVELr7C9CJ77k_m5OTFEe0dA@mail.gmail.com>
 <1656569481.3897407-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1656569481.3897407-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 Jun 2022 14:31:50 +0800
Message-ID: <CACGkMEtYnAEJv3BQd9DEeTAqyOTU166mu8d8_uzrJLs9qj6Edw@mail.gmail.com>
Subject: Re: [PATCH V2] virtio-net: fix the race between refill work and close
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, davem <davem@davemloft.net>
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

On Thu, Jun 30, 2022 at 2:26 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Thu, 30 Jun 2022 14:07:52 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Thu, Jun 30, 2022 at 10:22 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > On Thu, 30 Jun 2022 10:08:04 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > We try using cancel_delayed_work_sync() to prevent the work from
> > > > enabling NAPI. This is insufficient since we don't disable the source
> > > > of the refill work scheduling. This means an NAPI poll callback after
> > > > cancel_delayed_work_sync() can schedule the refill work then can
> > > > re-enable the NAPI that leads to use-after-free [1].
> > >
> > >
> > > Can you explain in more detail how this happened?
> > >
> > > napi_disable() is normally called after cancel_delayed_work_sync(). This ensures
> > > that all napi callbacks will end, and the new napi_disable() will wait.
> > > There will be no re-enable napi.
> >
> > An rx interrupt that may come between after the cancel_delayed_work()
> > but before the napi_disable(). It schedules a refill_work that may run
> > after the napi_disable() in virtnet_close().
>
> Yes
>
>
> >
> > >
> > > So I guess the use-after-free is caused by refill_work being called after
> > > dev/vi/napi is released. In this way, we can just call
> > > cancel_delayed_work_sync() after napi_disalbe().
> >
> > So the refill_work can re-enable the NAPI when it is run after
> > napi_disable() in this case.
>
>
> Since napi_disable() has been called in virtnet_close(), it will get stuck when
> napi_disable() in refill_work().

Right because e.g NAPIF_STATE_SCHED has been set by napi_disable() before.

> I think use-after-free is because vi/napi etc.
> have been released, refill_work() going to access again causes an exception.

Yes, this is the use-after-free I mentioned above.

>
> napi will not be re-enable.
>
> I would like to call cancel_delayed_work_sync() after napi_disable()
> to solve this problem. But this also has a problem, refill_work() can get stuck
> on napi_disable() and cannot exit. In this way, we want napi_disable() to check
> that the current state is disabled and exit directly.

Not sure this is a good design and it doesn't fit for -stable.

I think the design of NAPI is to pair napi_enable() and napi_disable()
instead of allowing napi_disable() to be called twice.

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
> >
> > >
> > > Thanks.
> > >
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
> > > > --
> > > > 2.25.1
> > > >
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
