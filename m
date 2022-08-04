Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FA3C00144
	for <virtualization@archiver.kernel.org>; Thu,  4 Aug 2022 07:11:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07D358134E;
	Thu,  4 Aug 2022 07:11:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 07D358134E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PItUsTDj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gROerjkzpmRN; Thu,  4 Aug 2022 07:11:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5A43881329;
	Thu,  4 Aug 2022 07:11:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5A43881329
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38DD6C0032;
	Thu,  4 Aug 2022 07:11:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 175B3C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 07:11:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E56C98132F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 07:11:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E56C98132F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y2umyf0y7RWj
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 07:11:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A251E81329
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A251E81329
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 07:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659597061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A63TanYP4Hw/TTzzo+hSgrjyyY8cOnY4/yDU0xKoYQM=;
 b=PItUsTDjBZUGbA7E66Uvits28bTOWCz0Y8lgC+jX2Z0PrxKKMgsCwg/d8z0jRN+LGHDBF9
 CaFP/qORz2kLK4tXLPZVMIzwUqsXebC/gMzh2au5PHbQeqOEfdtj3h3nNevtdmVdiviJCN
 J4Ub737RdepUC+lc2FBCdaYIJulYnq4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-pdlf0N17NLqEig4t3gTAPA-1; Thu, 04 Aug 2022 03:10:55 -0400
X-MC-Unique: pdlf0N17NLqEig4t3gTAPA-1
Received: by mail-wm1-f70.google.com with SMTP id
 n19-20020a05600c3b9300b003a314062cf4so2459689wms.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 04 Aug 2022 00:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=A63TanYP4Hw/TTzzo+hSgrjyyY8cOnY4/yDU0xKoYQM=;
 b=vrReIBqjp6Sxp5WqOkRH6cNU1Y2DdgUfV9GopPRSwb3J0cypyhp8xxzCHiSS5oOOD0
 sKZ2nIIsCk2O/LTOU5yweq10D6csNhfqnI5pr9l4Lln/N3DTFDxyqaJBLpbIBLWXIrl/
 oZklgWteUspWLiNCtNexib6iEsjlbTDqA4RGisZrOogYHKhkrhhxD5cLHgm8poNy7oVd
 h2qPwb2qiamH+Ad0yEfwPDsARm9rig2IfOzMZ2hj05lfAa00ASCoyZLzugQ7GgscEtmH
 fn4lMNsJdIGSNwry5XXGOzqSIxUkIn9dxuboaYQ/ZVbkwXTyv1bK/VFrd3/VDEMLZRxv
 UFLg==
X-Gm-Message-State: ACgBeo00QdvfEmNs3hLyS8PWdps8RQ/i/aPIjXXHSX3XiuxeYWGb9E8/
 8OLl2zcNKnBGmppN7zfZiMcg84B69oRpNS8LtW5UNSoDRIZof30f5uiaBW7H+kUxSI0vFOw4mB/
 Tn5zfqpOSx11O2/s4on8B4SP4XkzaulbqlqllEK9nJw==
X-Received: by 2002:adf:da42:0:b0:21d:aa7e:b1da with SMTP id
 r2-20020adfda42000000b0021daa7eb1damr412329wrl.330.1659597054432; 
 Thu, 04 Aug 2022 00:10:54 -0700 (PDT)
X-Google-Smtp-Source: AA6agR493z5gffA5FvHNldqAwWL2KIw0yW4QyDNfTDa6Rx6k/L7FHo/bn8wRH7IVq8vnwDzChfCeyg==
X-Received: by 2002:adf:da42:0:b0:21d:aa7e:b1da with SMTP id
 r2-20020adfda42000000b0021daa7eb1damr412310wrl.330.1659597054145; 
 Thu, 04 Aug 2022 00:10:54 -0700 (PDT)
Received: from redhat.com ([2.54.191.86]) by smtp.gmail.com with ESMTPSA id
 n66-20020a1ca445000000b003a513ee7830sm56218wme.27.2022.08.04.00.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Aug 2022 00:10:53 -0700 (PDT)
Date: Thu, 4 Aug 2022 03:10:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Message-ID: <20220804030419-mutt-send-email-mst@kernel.org>
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <CACGkMEvKVHNxMuU6ksZ7Apbbi0-cnHpY5DDwCenXXmbN_mEDPA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvKVHNxMuU6ksZ7Apbbi0-cnHpY5DDwCenXXmbN_mEDPA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Thu, Aug 04, 2022 at 01:00:46PM +0800, Jason Wang wrote:
> On Tue, Aug 2, 2022 at 12:47 PM Gavin Li <gavinl@nvidia.com> wrote:
> >
> > Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
> > packets even when GUEST_* offloads are not present on the device.
> > However, if GSO is not supported, it would be sufficient to allocate
> > segments to cover just up the MTU size and no further. Allocating the
> > maximum amount of segments results in a large waste of buffer space in
> > the queue, which limits the number of packets that can be buffered and
> > can result in reduced performance.
> >
> > Therefore, if GSO is not supported, use the MTU to calculate the
> > optimal amount of segments required.
> >
> > Below is the iperf TCP test results over a Mellanox NIC, using vDPA for
> > 1 VQ, queue size 1024, before and after the change, with the iperf
> > server running over the virtio-net interface.
> >
> > MTU(Bytes)/Bandwidth (Gbit/s)
> >              Before   After
> >   1500        22.5     22.4
> >   9000        12.8     25.9
> >
> > Signed-off-by: Gavin Li <gavinl@nvidia.com>
> > Reviewed-by: Gavi Teitz <gavi@nvidia.com>
> > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > ---
> >  drivers/net/virtio_net.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index ec8e1b3108c3..d36918c1809d 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -222,6 +222,9 @@ struct virtnet_info {
> >         /* I like... big packets and I cannot lie! */
> >         bool big_packets;
> >
> > +       /* Indicates GSO support */
> > +       bool gso_is_supported;
> > +
> >         /* Host will merge rx buffers for big packets (shake it! shake it!) */
> >         bool mergeable_rx_bufs;
> >
> > @@ -1312,14 +1315,21 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
> >  static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
> >                            gfp_t gfp)
> >  {
> > +       unsigned int sg_num = MAX_SKB_FRAGS;
> >         struct page *first, *list = NULL;
> >         char *p;
> >         int i, err, offset;
> >
> > -       sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
> > +       if (!vi->gso_is_supported) {
> > +               unsigned int mtu = vi->dev->mtu;
> > +
> > +               sg_num = (mtu % PAGE_SIZE) ? mtu / PAGE_SIZE + 1 : mtu / PAGE_SIZE;
> > +       }
> > +
> > +       sg_init_table(rq->sg, sg_num + 2);
> >
> >         /* page in rq->sg[MAX_SKB_FRAGS + 1] is list tail */
> > -       for (i = MAX_SKB_FRAGS + 1; i > 1; --i) {
> > +       for (i = sg_num + 1; i > 1; --i) {
> >                 first = get_a_page(rq, gfp);
> >                 if (!first) {
> >                         if (list)
> > @@ -1350,7 +1360,7 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
> >
> >         /* chain first in list head */
> >         first->private = (unsigned long)list;
> > -       err = virtqueue_add_inbuf(rq->vq, rq->sg, MAX_SKB_FRAGS + 2,
> > +       err = virtqueue_add_inbuf(rq->vq, rq->sg, sg_num + 2,
> >                                   first, gfp);
> >         if (err < 0)
> >                 give_pages(rq, first);
> > @@ -3571,8 +3581,10 @@ static int virtnet_probe(struct virtio_device *vdev)
> >         if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> >             virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
> >             virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
> > -           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
> > +           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO)) {
> >                 vi->big_packets = true;
> > +               vi->gso_is_supported = true;
> 
> Why not simply re-use big_packets here?
> 
> Thanks

I don't get this question. The patch does use big_packets, it wants
to figure out guest GSO is off so MTU limits the size. 
The name "gso_is_supported" is confusing, should be e.g. guest_gso.


> > +       }
> >
> >         if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
> >                 vi->mergeable_rx_bufs = true;
> > --
> > 2.31.1
> >
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
