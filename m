Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0787AC00144
	for <virtualization@archiver.kernel.org>; Thu,  4 Aug 2022 07:23:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6CAA54058E;
	Thu,  4 Aug 2022 07:23:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6CAA54058E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cF6zL4Ld
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D-pGlVSvN7qK; Thu,  4 Aug 2022 07:23:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B515B40525;
	Thu,  4 Aug 2022 07:23:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B515B40525
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D25EC0032;
	Thu,  4 Aug 2022 07:23:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D74C1C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 07:23:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 98CEC40525
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 07:23:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 98CEC40525
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NK51scdRHGTs
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 07:23:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 69EFF4017E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 69EFF4017E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 07:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659597817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1pvXxE7nmu5+xjX5/wqm+WJK/IeQ12wY6yYJlCcv2WU=;
 b=cF6zL4LdfBaxEnRDXPJ+dx1Fedu5xwmFYyYHShms4TEzcelAvTv7t9yNGfZ2+Avv1F/b0K
 k32+StnzZICa3tWNSIHjHkccz+6eZTqUbofdYlvENwNSU8LbvXOIN544d+OE5lYO8vis/e
 pgJ1wGX7NXxkJtx4e1irPph3xspi3DM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-CgJ9H9uxNfG9ap1YQ6MHBg-1; Thu, 04 Aug 2022 03:23:35 -0400
X-MC-Unique: CgJ9H9uxNfG9ap1YQ6MHBg-1
Received: by mail-lf1-f71.google.com with SMTP id
 m5-20020ac24245000000b0048a7c6bf079so5744690lfl.15
 for <virtualization@lists.linux-foundation.org>;
 Thu, 04 Aug 2022 00:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1pvXxE7nmu5+xjX5/wqm+WJK/IeQ12wY6yYJlCcv2WU=;
 b=ZJndarcgSpw4+YE/KdZKK5VhcnRxDn9In/1892qx/HtAAQwXl+kX0hbd0kMXdl8Rvd
 K++prw+fZIgwflyLfl227qG41GEg7ZK6DGymmvukUln2qHVWClhzwGddApT2xprMGtQ6
 bMb7H2M6nL1Cjv0GKrWlubPhNVxH+YTCZWqCGm5YZGQqOt8EqYuZYLIwQG4QoKaMFgq0
 /COOO8LmslVxWjzr/HWoNPBBmwaWsyM4cPyETisf3E9GN8XWLswslkC6ERxNQQ5Q4ZyH
 SQnD7jyo0i4w57PWIKBfcZYum+Dy73Lf2f9LtweKkHbkF+lQFnbHHxpYcRjQpRQPOmNm
 iyyQ==
X-Gm-Message-State: ACgBeo3Kf1qM5xMYRzURgdM+bNUSZeGxn45CQbo8kEX6xmZeJHbcT/Ek
 MVG0FWyO4RSyTi708Zih8frTTuHDVUL4vZWsPlGM2gf3MK2V417QNP1ZKWU0Rs3RkPajLZMfuwj
 5Fj8aRXogdgwd15Qv4PIEZx+mImXgqSHoWxApFMG3rX8ZV/P4un4qE2thow==
X-Received: by 2002:a05:6512:b0d:b0:481:5cb4:cf1e with SMTP id
 w13-20020a0565120b0d00b004815cb4cf1emr249344lfu.442.1659597814298; 
 Thu, 04 Aug 2022 00:23:34 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5xGf4B11Nw8NMLykNJUGCARx78xRyGO9qure3vlfpaTekoPGtxfZ6usVtoCmrKOqF+SGDFr7ee+YfbPecdvwY=
X-Received: by 2002:a05:6512:b0d:b0:481:5cb4:cf1e with SMTP id
 w13-20020a0565120b0d00b004815cb4cf1emr249328lfu.442.1659597814070; Thu, 04
 Aug 2022 00:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <CACGkMEvKVHNxMuU6ksZ7Apbbi0-cnHpY5DDwCenXXmbN_mEDPA@mail.gmail.com>
 <20220804030419-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220804030419-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 4 Aug 2022 15:23:22 +0800
Message-ID: <CACGkMEsxzDMFCPn2XRe+M=xai+Rouk9dHGnBXkymHUcvW5kr+Q@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: alexander.h.duyck@intel.com, Virtio-Dev <virtio-dev@lists.oasis-open.org>,
 kubakici@wp.pl, sridhar.samudrala@intel.com, jesse.brandeburg@intel.com,
 gavi@nvidia.com, virtualization <virtualization@lists.linux-foundation.org>,
 "Hemminger, Stephen" <stephen@networkplumber.org>, loseweigh@gmail.com,
 davem <davem@davemloft.net>, Gavin Li <gavinl@nvidia.com>
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

On Thu, Aug 4, 2022 at 3:10 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Aug 04, 2022 at 01:00:46PM +0800, Jason Wang wrote:
> > On Tue, Aug 2, 2022 at 12:47 PM Gavin Li <gavinl@nvidia.com> wrote:
> > >
> > > Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
> > > packets even when GUEST_* offloads are not present on the device.
> > > However, if GSO is not supported, it would be sufficient to allocate
> > > segments to cover just up the MTU size and no further. Allocating the
> > > maximum amount of segments results in a large waste of buffer space in
> > > the queue, which limits the number of packets that can be buffered and
> > > can result in reduced performance.
> > >
> > > Therefore, if GSO is not supported, use the MTU to calculate the
> > > optimal amount of segments required.
> > >
> > > Below is the iperf TCP test results over a Mellanox NIC, using vDPA for
> > > 1 VQ, queue size 1024, before and after the change, with the iperf
> > > server running over the virtio-net interface.
> > >
> > > MTU(Bytes)/Bandwidth (Gbit/s)
> > >              Before   After
> > >   1500        22.5     22.4
> > >   9000        12.8     25.9
> > >
> > > Signed-off-by: Gavin Li <gavinl@nvidia.com>
> > > Reviewed-by: Gavi Teitz <gavi@nvidia.com>
> > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > ---
> > >  drivers/net/virtio_net.c | 20 ++++++++++++++++----
> > >  1 file changed, 16 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index ec8e1b3108c3..d36918c1809d 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -222,6 +222,9 @@ struct virtnet_info {
> > >         /* I like... big packets and I cannot lie! */
> > >         bool big_packets;
> > >
> > > +       /* Indicates GSO support */
> > > +       bool gso_is_supported;
> > > +
> > >         /* Host will merge rx buffers for big packets (shake it! shake it!) */
> > >         bool mergeable_rx_bufs;
> > >
> > > @@ -1312,14 +1315,21 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
> > >  static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
> > >                            gfp_t gfp)
> > >  {
> > > +       unsigned int sg_num = MAX_SKB_FRAGS;
> > >         struct page *first, *list = NULL;
> > >         char *p;
> > >         int i, err, offset;
> > >
> > > -       sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
> > > +       if (!vi->gso_is_supported) {
> > > +               unsigned int mtu = vi->dev->mtu;
> > > +
> > > +               sg_num = (mtu % PAGE_SIZE) ? mtu / PAGE_SIZE + 1 : mtu / PAGE_SIZE;
> > > +       }
> > > +
> > > +       sg_init_table(rq->sg, sg_num + 2);
> > >
> > >         /* page in rq->sg[MAX_SKB_FRAGS + 1] is list tail */
> > > -       for (i = MAX_SKB_FRAGS + 1; i > 1; --i) {
> > > +       for (i = sg_num + 1; i > 1; --i) {
> > >                 first = get_a_page(rq, gfp);
> > >                 if (!first) {
> > >                         if (list)
> > > @@ -1350,7 +1360,7 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
> > >
> > >         /* chain first in list head */
> > >         first->private = (unsigned long)list;
> > > -       err = virtqueue_add_inbuf(rq->vq, rq->sg, MAX_SKB_FRAGS + 2,
> > > +       err = virtqueue_add_inbuf(rq->vq, rq->sg, sg_num + 2,
> > >                                   first, gfp);
> > >         if (err < 0)
> > >                 give_pages(rq, first);
> > > @@ -3571,8 +3581,10 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >         if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > >             virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
> > >             virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
> > > -           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
> > > +           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO)) {
> > >                 vi->big_packets = true;
> > > +               vi->gso_is_supported = true;
> >
> > Why not simply re-use big_packets here?
> >
> > Thanks
>
> I don't get this question. The patch does use big_packets, it wants
> to figure out guest GSO is off so MTU limits the size.

Yes.

Thanks

> The name "gso_is_supported" is confusing, should be e.g. guest_gso.
>
>
> > > +       }
> > >
> > >         if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
> > >                 vi->mergeable_rx_bufs = true;
> > > --
> > > 2.31.1
> > >
> > >
> > > ---------------------------------------------------------------------
> > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
