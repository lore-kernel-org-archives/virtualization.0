Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715D7C433EF
	for <virtualization@archiver.kernel.org>; Wed, 29 Jun 2022 08:36:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0350140600;
	Wed, 29 Jun 2022 08:36:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0350140600
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bfFc/nRG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3pRnENAHY38h; Wed, 29 Jun 2022 08:36:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4A975401A3;
	Wed, 29 Jun 2022 08:36:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4A975401A3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AF9AC0032;
	Wed, 29 Jun 2022 08:36:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 300FBC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 08:36:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F0F3A83F57
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 08:36:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F0F3A83F57
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bfFc/nRG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8Nn9W-bi7lPu
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 08:36:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 984BA83F53
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 984BA83F53
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 08:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656491789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bet7RPOPoI6qEqFJfuyVXTSgqEPE876J831j55LAYEI=;
 b=bfFc/nRG8xxYNgBQDk4ejxP0El0LwlCg0Ddeq5s7TFWxBBA5dLi8wsO3PRhj/lUH1Tnrs7
 e/RZ6PCNVRRQt5NIsn6Vw47/6+nVqURp9UA71B3xaeQdAXZ5L0gQ7II9/VLjBMZKPVx/b+
 rAbKnk6LvGkbL5MHBJOSj0iLyDJ6UU4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-374-0fwjcyJ8NU-n51RD3ARogA-1; Wed, 29 Jun 2022 04:36:26 -0400
X-MC-Unique: 0fwjcyJ8NU-n51RD3ARogA-1
Received: by mail-lj1-f198.google.com with SMTP id
 x7-20020a05651c024700b002594efe50f0so2141069ljn.21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 01:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Bet7RPOPoI6qEqFJfuyVXTSgqEPE876J831j55LAYEI=;
 b=KkoqzjCES3yWFh7tl/RFO1lTCZ9k+EyQ0FzxsXLtaBSZPSuEfDpxoLq/XLMPkNbDO3
 nuBWrTH9dmKVPy+eiaW5dss9d8FthyzweNVMWTBAECv2rWQUiq1o646RvlZigda89Cia
 gHba+O3yHz3IVSBOnoOqse9Rl/EmdxVXiiyLwwVhnw9iZCG5aUJ8IoZcpbay4cxtGotH
 vAr0/OTuVmulxY5UuhSHNUOpGJquVYiCKK5vARZFdqLNCg0VT5eWm2yxaO7OYxeYUTM3
 S40ia0fIR8dSs40dM/NpYe2GeUihRFmJdDjhx5NVGVGP4s1R5ai1o9XItBWkxkuRJsop
 LeFg==
X-Gm-Message-State: AJIora+61bH25mPdnzOehQt8antjfwQqW7zWeQ4YPYGCEDePqopE8AI+
 5TiBC+5dBZU6g53n5jZ6WCZsKki8joB+8LF5CUQctDlqILVw8gP/IOIt+eUsxXLLG75MB2nkv2j
 z95aNmCeHZSfNVizImOHYLkjBObIo7Wq+ntq77BcLrh5vn5+PDbDZqi9kVA==
X-Received: by 2002:a05:651c:895:b0:250:c5ec:bc89 with SMTP id
 d21-20020a05651c089500b00250c5ecbc89mr1000415ljq.251.1656491784164; 
 Wed, 29 Jun 2022 01:36:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vBelXp7oblduZwmkq8dd6rRu3tkscsPBwJaVedQQ56Gmdo+PJ5Ijy22sPBo/8FbgLCMMKyAjmHBfc3NkfgJ8g=
X-Received: by 2002:a05:651c:895:b0:250:c5ec:bc89 with SMTP id
 d21-20020a05651c089500b00250c5ecbc89mr1000402ljq.251.1656491783902; Wed, 29
 Jun 2022 01:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220628090324.62219-1-jasowang@redhat.com>
 <20220629032106-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220629032106-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 29 Jun 2022 16:36:12 +0800
Message-ID: <CACGkMEutEYHf8kO_6gpk5BrMAndJPd8wDAPG2_Z9pxSiXXNDCw@mail.gmail.com>
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

On Wed, Jun 29, 2022 at 3:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jun 28, 2022 at 05:03:24PM +0800, Jason Wang wrote:
> > We try using cancel_delayed_work_sync() to prevent the work from
> > enabling NAPI. This is insufficient since we don't disable the the
> > source the scheduling
>
> can't parse this sentence

I actually meant "we don't disable the source of the refill work scheduling".

>
> > of the refill work. This means an NAPI
>
> what do you mean "an NAPI"? a NAPI poll callback?

Yes.

>
> > after
> > cancel_delayed_work_sync() can schedule the refill work then can
> > re-enable the NAPI that leads to use-after-free [1].
> >
> > Since the work can enable NAPI, we can't simply disable NAPI before
> > calling cancel_delayed_work_sync(). So fix this by introducing a
> > dedicated boolean to control whether or not the work could be
> > scheduled from NAPI.
> >
> > [1]
> > ==================================================================
> > BUG: KASAN: use-after-free in refill_work+0x43/0xd4
> > Read of size 2 at addr ffff88810562c92e by task kworker/2:1/42
> >
> > CPU: 2 PID: 42 Comm: kworker/2:1 Not tainted 5.19.0-rc1+ #480
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > Workqueue: events refill_work
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x34/0x44
> >  print_report.cold+0xbb/0x6ac
> >  ? _printk+0xad/0xde
> >  ? refill_work+0x43/0xd4
> >  kasan_report+0xa8/0x130
> >  ? refill_work+0x43/0xd4
> >  refill_work+0x43/0xd4
> >  process_one_work+0x43d/0x780
> >  worker_thread+0x2a0/0x6f0
> >  ? process_one_work+0x780/0x780
> >  kthread+0x167/0x1a0
> >  ? kthread_exit+0x50/0x50
> >  ret_from_fork+0x22/0x30
> >  </TASK>
> > ...
> >
> > Fixes: b2baed69e605c ("virtio_net: set/cancel work on ndo_open/ndo_stop")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 38 ++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 36 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index db05b5e930be..21bf1e5c81ef 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -251,6 +251,12 @@ struct virtnet_info {
> >       /* Does the affinity hint is set for virtqueues? */
> >       bool affinity_hint_set;
> >
> > +     /* Is refill work enabled? */
> > +     bool refill_work_enabled;
> > +
> > +     /* The lock to synchronize the access to refill_work_enabled */
> > +     spinlock_t refill_lock;
> > +
> >       /* CPU hotplug instances for online & dead */
> >       struct hlist_node node;
> >       struct hlist_node node_dead;
> > @@ -348,6 +354,20 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
> >       return p;
> >  }
> >
> > +static void enable_refill_work(struct virtnet_info *vi)
> > +{
> > +     spin_lock(&vi->refill_lock);
> > +     vi->refill_work_enabled = true;
> > +     spin_unlock(&vi->refill_lock);
> > +}
> > +
> > +static void disable_refill_work(struct virtnet_info *vi)
> > +{
> > +     spin_lock(&vi->refill_lock);
> > +     vi->refill_work_enabled = false;
> > +     spin_unlock(&vi->refill_lock);
> > +}
> > +
> >  static void virtqueue_napi_schedule(struct napi_struct *napi,
> >                                   struct virtqueue *vq)
> >  {
> > @@ -1527,8 +1547,12 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
> >       }
> >
> >       if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> > -             if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> > -                     schedule_delayed_work(&vi->refill, 0);
> > +             if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> > +                     spin_lock(&vi->refill_lock);
> > +                     if (vi->refill_work_enabled)
> > +                             schedule_delayed_work(&vi->refill, 0);
> > +                     spin_unlock(&vi->refill_lock);
> > +             }
> >       }
> >
> >       u64_stats_update_begin(&rq->stats.syncp);
> > @@ -1651,6 +1675,8 @@ static int virtnet_open(struct net_device *dev)
> >       struct virtnet_info *vi = netdev_priv(dev);
> >       int i, err;
> >
> > +     enable_refill_work(vi);
> > +
> >       for (i = 0; i < vi->max_queue_pairs; i++) {
> >               if (i < vi->curr_queue_pairs)
> >                       /* Make sure we have some buffers: if oom use wq. */
> > @@ -2033,6 +2059,8 @@ static int virtnet_close(struct net_device *dev)
> >       struct virtnet_info *vi = netdev_priv(dev);
> >       int i;
> >
> > +     /* Make sure NAPI doesn't schedule refill work */
> > +     disable_refill_work(vi);
> >       /* Make sure refill_work doesn't re-enable napi! */
> >       cancel_delayed_work_sync(&vi->refill);
> >
> > @@ -2776,6 +2804,9 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
> >       netif_tx_lock_bh(vi->dev);
> >       netif_device_detach(vi->dev);
> >       netif_tx_unlock_bh(vi->dev);
> > +     /* Make sure NAPI doesn't schedule refill work */
> > +     disable_refill_work(vi);
> > +     /* Make sure refill_work doesn't re-enable napi! */
> >       cancel_delayed_work_sync(&vi->refill);
> >
> >       if (netif_running(vi->dev)) {
> > @@ -2799,6 +2830,8 @@ static int virtnet_restore_up(struct virtio_device *vdev)
> >
> >       virtio_device_ready(vdev);
> >
> > +     enable_refill_work(vi);
> > +
> >       if (netif_running(vi->dev)) {
> >               for (i = 0; i < vi->curr_queue_pairs; i++)
> >                       if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> > @@ -3548,6 +3581,7 @@ static int virtnet_probe(struct virtio_device *vdev)
> >       vdev->priv = vi;
> >
> >       INIT_WORK(&vi->config_work, virtnet_config_changed_work);
> > +     spin_lock_init(&vi->refill_lock);
> >
> >       /* If we can receive ANY GSO packets, we must allocate large ones. */
> >       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>
>
> Can't say I love all the extra state but oh well.

I couldn't find a better way. The tricky part is that NAPI and refill
can schedule each other so we need a third state.

Thanks

>
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
