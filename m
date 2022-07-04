Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB5DCCA479
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 07:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A92D3404D8;
	Mon,  4 Jul 2022 07:14:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A92D3404D8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e0cRCsd3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A63Ze-TkaKxw; Mon,  4 Jul 2022 07:14:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BF1B04018A;
	Mon,  4 Jul 2022 07:14:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF1B04018A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88DB7C0032;
	Mon,  4 Jul 2022 07:14:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFD74C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 07:14:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ABF6360B2B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 07:14:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ABF6360B2B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=e0cRCsd3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jm-2A0puLwxl
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 07:14:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B29EF60B0E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B29EF60B0E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 07:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656918864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PVTHS1ZmH+V40UZeEp3beBk5LSH440YhC3MlV0TsXgg=;
 b=e0cRCsd3XQxG05E4bnp8dHS5h57sa/nLUwaJLWe5/bUTdPBBUyPSrXe2MZMK8nikGxaB/x
 x2mIbnP5rlVyhKW7aUbl1EvP5FcDRCce1weKQGReIwEHoNMe8tmVjJuf8H2QRt4ZTiPRCE
 xCXNaKbX/WiYLjDeHmcpgBFotkKA8m4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-7aaQxqOpO9CIUdcfnm5EsQ-1; Mon, 04 Jul 2022 03:14:23 -0400
X-MC-Unique: 7aaQxqOpO9CIUdcfnm5EsQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 o7-20020a056512230700b004810a865709so2722811lfu.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Jul 2022 00:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PVTHS1ZmH+V40UZeEp3beBk5LSH440YhC3MlV0TsXgg=;
 b=qTmCPUkjYlLSd8/bU76eXQycEs3U6/LDKnr1G8l6rmirZOBYC3sObrMb44zUCveeD2
 YCYk2XmAwos5ZmBdcNp4j0E7f/K3mJ3tU61jJLe5WRJX6XwJ/2NBY4YWPjhUDoKzK9md
 3RPZqqSIzUkQ0rN/eHUpDIxbzY+CfRUn+lBGHnkCNUBiIN6DnOeMDXCO1J6fnvhAvH4K
 UfNHiafm2CJwVS+lkK7Z9oLzEE6lZ6wvWBzlH5kYvAP8wZQZFyjp8FEVqCc9NuEFwrU7
 1spk+2E4Zl5QXhpPF2VT+a5XUuiXtNObhcZ6dfmeg4C8vUlw2T2oZ0PdyBE2RuiFqTpD
 PinQ==
X-Gm-Message-State: AJIora/Hi0Yx7y6PbgB6KVm2vIhmhR+jCoWD56XIgYAG24zB7YuJ0YiQ
 Nt9oQU6ye7WRrC9nzAFuAPP+e1NfkNpX2LTaLQCKOf1TagnZDcfKgPs+oxdSvtwkznZXUrRFDNN
 RJ96UFqJS/gcXIh0lhdnp3sSs8gpfZ722pv7ZDdyM2qQYJ3syWjFE95zd3Q==
X-Received: by 2002:ac2:51a5:0:b0:47f:79a1:5c02 with SMTP id
 f5-20020ac251a5000000b0047f79a15c02mr17575379lfk.575.1656918859906; 
 Mon, 04 Jul 2022 00:14:19 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1st9OtbMb2bdAIcQAsqbqDqoOOn+3D0TXfeZJarxhdYFG9SQaOWqqLQRjRU/lhGsZfI6R5iZYM6ZVes5RTMDn8=
X-Received: by 2002:ac2:51a5:0:b0:47f:79a1:5c02 with SMTP id
 f5-20020ac251a5000000b0047f79a15c02mr17575344lfk.575.1656918859025; Mon, 04
 Jul 2022 00:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220704041948.13212-1-jasowang@redhat.com>
 <20220704021656-mutt-send-email-mst@kernel.org>
 <CACGkMEsOy6kgaj+Q0vYxDBy7JEd=DUm7KLKo7AjGCi2ay5ciKQ@mail.gmail.com>
 <20220704030124-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220704030124-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 4 Jul 2022 15:14:07 +0800
Message-ID: <CACGkMEvi-CT6c7qqTPh7-Vqr-2gGdX6G1FP52hqQFL3q0r=tOg@mail.gmail.com>
Subject: Re: [PATCH net V4] virtio-net: fix the race between refill work and
 close
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, davem <davem@davemloft.net>
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

On Mon, Jul 4, 2022 at 3:03 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jul 04, 2022 at 02:32:45PM +0800, Jason Wang wrote:
> > On Mon, Jul 4, 2022 at 2:19 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Jul 04, 2022 at 12:19:48PM +0800, Jason Wang wrote:
> > > > We try using cancel_delayed_work_sync() to prevent the work from
> > > > enabling NAPI. This is insufficient since we don't disable the source
> > > > of the refill work scheduling. This means an NAPI poll callback after
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
> > > > Changes since V3:
> > > > - rebase to -net
> > > > Changes since V2:
> > > > - use spin_unlock()/lock_bh() in open/stop to synchronize with bh
> > > > Changes since V1:
> > > > - Tweak the changelog
> > > > ---
> > > >  drivers/net/virtio_net.c | 35 +++++++++++++++++++++++++++++++++--
> > > >  1 file changed, 33 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 356cf8dd4164..68430d7923ac 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -251,6 +251,12 @@ struct virtnet_info {
> > > >       /* Does the affinity hint is set for virtqueues? */
> > > >       bool affinity_hint_set;
> > > >
> > > > +     /* Is refill work enabled? */
> > >
> > > refilling enabled
> >
> > I think it should be reill work, we try refill first, if fail we
> > schedule the work:
> >
> >                 if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> >                         schedule_delayed_work(&vi->refill, 0);
> >
> > Thanks
>
> maybe "delayed refill"? It's not "work" it's a work struct.
> I'm trying to be consistent with:
>         /* Work struct for refilling if we run low on memory. */
>         struct delayed_work refill;

Ok, that's fine.

Will post a new version.

Thanks

>
>
> > >
> > > > +     bool refill_work_enabled;
> > >
> > >
> > > refill_work -> refill?
> > >
> > > > +
> > > > +     /* The lock to synchronize the access to refill_work_enabled */
> > >
> > > .. and refill
> > >
> > > And maybe put these field near the refill field.
> > >
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
> > > > +     spin_lock_bh(&vi->refill_lock);
> > > > +     vi->refill_work_enabled = true;
> > > > +     spin_unlock_bh(&vi->refill_lock);
> > > > +}
> > > > +
> > > > +static void disable_refill_work(struct virtnet_info *vi)
> > > > +{
> > > > +     spin_lock_bh(&vi->refill_lock);
> > > > +     vi->refill_work_enabled = false;
> > > > +     spin_unlock_bh(&vi->refill_lock);
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
> > > > @@ -2792,6 +2820,8 @@ static int virtnet_restore_up(struct virtio_device *vdev)
> > > >
> > > >       virtio_device_ready(vdev);
> > > >
> > > > +     enable_refill_work(vi);
> > > > +
> > > >       if (netif_running(vi->dev)) {
> > > >               err = virtnet_open(vi->dev);
> > > >               if (err)
> > > > @@ -3535,6 +3565,7 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > >       vdev->priv = vi;
> > > >
> > > >       INIT_WORK(&vi->config_work, virtnet_config_changed_work);
> > > > +     spin_lock_init(&vi->refill_lock);
> > > >
> > > >       /* If we can receive ANY GSO packets, we must allocate large ones. */
> > > >       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > > > --
> > > > 2.25.1
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
