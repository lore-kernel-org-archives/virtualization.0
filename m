Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C187C6379F
	for <virtualization@archiver.kernel.org>; Tue, 17 Jan 2023 03:48:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E254540305;
	Tue, 17 Jan 2023 03:48:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E254540305
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MdVx44Yg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TDRAljOVAYxH; Tue, 17 Jan 2023 03:48:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BAB0D402B2;
	Tue, 17 Jan 2023 03:48:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BAB0D402B2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2864C0033;
	Tue, 17 Jan 2023 03:48:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0E65C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 03:48:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CBC796102A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 03:48:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CBC796102A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MdVx44Yg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DgQTtHQqvA7l
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 03:48:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B0F460FC8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B0F460FC8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 03:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673927306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ox4Ah9tt80v/yWVYXdwLmBislsr/xQeepIzjgpV54dk=;
 b=MdVx44YgHP3dGuUkrI5yXTS05toYp3M/fY3Nis0H5M1QqEa6F5oyyn6STXB8c5uOAqp7al
 /dX8AZYffdOzNfjUSaiXYoVNuVtI1jwbU+NnuPG+iNgMV9lP1mGtufu9pQvFECxmK3wCPy
 SFmJMxo9VVww8pY9xRTEYWNHm1yAAu8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-629-w9GlqWcnNyi5Vw7I4mrbcA-1; Mon, 16 Jan 2023 22:48:25 -0500
X-MC-Unique: w9GlqWcnNyi5Vw7I4mrbcA-1
Received: by mail-oi1-f200.google.com with SMTP id
 f2-20020a05680814c200b0036470a5606fso3803074oiw.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 19:48:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ox4Ah9tt80v/yWVYXdwLmBislsr/xQeepIzjgpV54dk=;
 b=TLuTTUZSPlEqB2Hx1vH3qEM5jY1gRVZYOkLta+CN0u9b2k/qGts22ESKcvYvX7vKzZ
 D9CySjmwFzsJnIuC7j3uJpyYBwgKKMmKNNWskrXuvhfQz35SqOAd6COZ/FdNkwZVzp9z
 2XDnzyPga9E1ke1OPkrwQUd8h1Lr42Z2yqg7yeuviaOOXbWnPCpAdbb+lYr1uHwVKmgY
 q4+RpnpeEXtNpAfiVjpmj5zO7fUdX05VJ5ebq5A1mmzXlsUGjJ2p3gdY2CFTzKfu8Mtu
 rA+V0G470qsaFx3jdn/jp6oZGLLVRU4YQA2f3rUWgfOwJoCvtKQCia2CnuU1wgCbSaGl
 /quA==
X-Gm-Message-State: AFqh2kpUwvEfC5OhmQHKbuZlXCiqB7D7silmBUAm4FmY0HRkD/14wPnZ
 zeiGqoWUJV002xsWkt5qaWNOSSN2GQYsbd9PxeZlv7P8dYb5CRTxXapOt1LvjXdIKLmjUz8wzfA
 UmwDASlPZJYHmFpknNR3Tk8Uy6wGmtyvl0c2Gt4pCnqEheoAbnCWnPuLMqw==
X-Received: by 2002:a05:6830:334d:b0:684:9f72:3fe3 with SMTP id
 l13-20020a056830334d00b006849f723fe3mr77553ott.201.1673927304630; 
 Mon, 16 Jan 2023 19:48:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsvPWHgmiuIC6ubfdkBMLXNoYQC3qKGVcUwBpPUbVPA4QslvV9B3BCnOvNItJrvKcEq//61NUmiljeMR3EA8k8=
X-Received: by 2002:a05:6830:334d:b0:684:9f72:3fe3 with SMTP id
 l13-20020a056830334d00b006849f723fe3mr77542ott.201.1673927304388; Mon, 16 Jan
 2023 19:48:24 -0800 (PST)
MIME-Version: 1.0
References: <20210526082423.47837-1-mst@redhat.com>
 <20210526082423.47837-5-mst@redhat.com>
 <a5990064-df57-f991-832d-56d1156dc3f8@redhat.com>
In-Reply-To: <a5990064-df57-f991-832d-56d1156dc3f8@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Jan 2023 11:48:13 +0800
Message-ID: <CACGkMEuq3YOpQaZLD_dFsHsA=qpT=N22ZyLdtE83VNHjS6iVbQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] virtio_net: disable cb aggressively
To: Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Willem de Bruijn <willemb@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefano Brivio <sbrivio@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Wei Wang <weiwan@google.com>, David Miller <davem@davemloft.net>
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

On Mon, Jan 16, 2023 at 9:41 PM Laurent Vivier <lvivier@redhat.com> wrote:
>
> Hi Michael,
>
> On 5/26/21 10:24, Michael S. Tsirkin wrote:
> > There are currently two cases where we poll TX vq not in response to a
> > callback: start xmit and rx napi.  We currently do this with callbacks
> > enabled which can cause extra interrupts from the card.  Used not to be
> > a big issue as we run with interrupts disabled but that is no longer the
> > case, and in some cases the rate of spurious interrupts is so high
> > linux detects this and actually kills the interrupt.
> >
> > Fix up by disabling the callbacks before polling the tx vq.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   drivers/net/virtio_net.c | 16 ++++++++++++----
> >   1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index c29f42d1e04f..a83dc038d8af 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1433,7 +1433,10 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
> >               return;
> >
> >       if (__netif_tx_trylock(txq)) {
> > -             free_old_xmit_skbs(sq, true);
> > +             do {
> > +                     virtqueue_disable_cb(sq->vq);
> > +                     free_old_xmit_skbs(sq, true);
> > +             } while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> >
> >               if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> >                       netif_tx_wake_queue(txq);
> > @@ -1605,12 +1608,17 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> >       struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
> >       bool kick = !netdev_xmit_more();
> >       bool use_napi = sq->napi.weight;
> > +     unsigned int bytes = skb->len;
> >
> >       /* Free up any pending old buffers before queueing new ones. */
> > -     free_old_xmit_skbs(sq, false);
> > +     do {
> > +             if (use_napi)
> > +                     virtqueue_disable_cb(sq->vq);
> >
> > -     if (use_napi && kick)
> > -             virtqueue_enable_cb_delayed(sq->vq);
> > +             free_old_xmit_skbs(sq, false);
> > +
> > +     } while (use_napi && kick &&
> > +            unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> >
> >       /* timestamp packet in software */
> >       skb_tx_timestamp(skb);
>
> This patch seems to introduce a problem with QEMU connected to passt using netdev stream
> backend.
>
> When I run an iperf3 test I get after 1 or 2 seconds of test:
>
> [  254.035559] NETDEV WATCHDOG: ens3 (virtio_net): transmit queue 0 timed out
> ...
> [  254.060962] virtio_net virtio1 ens3: TX timeout on queue: 0, sq: output.0, vq: 0x1,
> name: output.0, 8856000 usecs ago
> [  259.155150] virtio_net virtio1 ens3: TX timeout on queue: 0, sq: output.0, vq: 0x1,
> name: output.0, 13951000 usecs ago
>
> In QEMU, I can see in virtio_net_tx_bh() the function virtio_net_flush_tx() has flushed
> all the queue entries and re-enabled the queue notification with
> virtio_queue_set_notification() and tries to flush again the queue and as it is empty it
> does nothing more and then rely on a kernel notification to re-enable the bottom half
> function. As this notification never comes the queue is stuck and kernel add entries but
> QEMU doesn't remove them:
>
> 2812 static void virtio_net_tx_bh(void *opaque)
> 2813 {
> ...
> 2833     ret = virtio_net_flush_tx(q);
>
> -> flush the queue and ret is not an error and not n->tx_burst (that would re-schedule the
> function)
>
> ...
> 2850     virtio_queue_set_notification(q->tx_vq, 1);
>
> -> re-enable the queue notification
>
> 2851     ret = virtio_net_flush_tx(q);
> 2852     if (ret == -EINVAL) {
> 2853         return;
> 2854     } else if (ret > 0) {
> 2855         virtio_queue_set_notification(q->tx_vq, 0);
> 2856         qemu_bh_schedule(q->tx_bh);
> 2857         q->tx_waiting = 1;
> 2858     }
>
> -> ret is 0, exit the function without re-scheduling the function.
> ...
> 2859 }
>
> If I revert this patch in the kernel (a7766ef18b33 ("virtio_net: disable cb
> aggressively")), it works fine.
>
> How to reproduce it:
>
> I start passt (https://passt.top/passt):
>
> passt -f
>
> and then QEMU
>
> qemu-system-x86_64 ... --netdev
> stream,id=netdev0,server=off,addr.type=unix,addr.path=/tmp/passt_1.socket -device
> virtio-net,mac=9a:2b:2c:2d:2e:2f,netdev=netdev0
>
> Host side:
>
> sysctl -w net.core.rmem_max=134217728
> sysctl -w net.core.wmem_max=134217728
> iperf3 -s
>
> Guest side:
>
> sysctl -w net.core.rmem_max=536870912
> sysctl -w net.core.wmem_max=536870912
>
> ip link set dev $DEV mtu 256
> iperf3 -c $HOST -t10 -i0 -Z -P 8 -l 1M --pacing-timer 1000000 -w 4M
>
> Any idea of what is the problem?

This looks similar to what I spot and try to fix in:

[PATCH net V3] virtio-net: correctly enable callback during start_xmit

(I've cced you in this version).

Thanks

>
> Thanks,
> Laurent
>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
