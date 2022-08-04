Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52281C00144
	for <virtualization@archiver.kernel.org>; Thu,  4 Aug 2022 07:25:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8B4381C6F;
	Thu,  4 Aug 2022 07:25:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E8B4381C6F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZcxK6tZq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7MU1nvMGrwDD; Thu,  4 Aug 2022 07:25:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 36106823AA;
	Thu,  4 Aug 2022 07:25:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 36106823AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F18DBC0032;
	Thu,  4 Aug 2022 07:25:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E9D1C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 07:25:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6823A40245
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 07:25:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6823A40245
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZcxK6tZq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sTfwLOxnEih1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 07:25:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B69640207
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B69640207
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 07:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659597912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jl7cu2tlinN1jxw+nowSRtzAtczgRlJi4hSq/sBU7oo=;
 b=ZcxK6tZq1+ItyuE8c/kn26SCYiOgBjy3cbWj1LFMpUXAYi9/JnYKdB9Sn2IWJ7Miw/ozBg
 U4oFxp1zIjcW6vMLDjTuKKUvQrycVKC2IsG385G+UODKFXIGCNzKBZJ3rKOq8/RBNBUm5F
 0u2hc7W3yGr/dV8hxFL9zynGAzYR3xs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-Gp7M0GsWP12mVuAqM0Nriw-1; Thu, 04 Aug 2022 03:25:09 -0400
X-MC-Unique: Gp7M0GsWP12mVuAqM0Nriw-1
Received: by mail-lj1-f197.google.com with SMTP id
 d4-20020a2e9284000000b0025e0f56d216so4598164ljh.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 04 Aug 2022 00:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Jl7cu2tlinN1jxw+nowSRtzAtczgRlJi4hSq/sBU7oo=;
 b=sJGJ5+dLc4AaiX+5d2JNqkU7XN63D4jdWGapJcf7X8XUFQ/tEuAwVZyDC+5AAsZpW6
 RhUq4lVRlGy229F3H29my7oUoZ+rqp/umczvpCLQ6bkaaVRgEx7+ZZgIDs7+/zjtpQRc
 2Vz6MToHJjtC1oogzafm+ZDMHt13/h1a7HduFqAZQ4/wSUGVfGWwkNFiiIkymGTT3VdZ
 1SAYHybuKPg5h9CFqO+XGM9CN/zKCuxHjg7vhY5oUfG8Hq+slSC0Q/VOZwlmTuAU9JkH
 Q6kSvX44RJeOCwqlqWughuHv/QjFq+7Iv35/S6eqx5GN4CS8eBHOgdcrlDY9bHC5TFOM
 P7vA==
X-Gm-Message-State: ACgBeo2F8Khe9Sq/hFaM8lPHcWCQ9BeasQ9Cfnb3lnuCLyX5B/Ior6kS
 cpfPJGaUdDEgpgYPU5bqBRz7QGiQVSSkM56JFqJe+g7Z6kWZZjfyAT1+8wVy7IeUJ9r7k+V3ZYc
 BtYc2JLitwa/j2bpk//t0XkYnJf5xVJtxyK3cV8fGlXRem0wjMbUfEkm40g==
X-Received: by 2002:a05:651c:2103:b0:25d:6478:2a57 with SMTP id
 a3-20020a05651c210300b0025d64782a57mr157400ljq.496.1659597908042; 
 Thu, 04 Aug 2022 00:25:08 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6m5y6mxIKuJksEn5IfZNZ7tfGJL1c1FaFZ/QtOAjUExgYBqIHsEBgGpMVTLPsrpRSR6YK+dPqCL/qOhsLhXRU=
X-Received: by 2002:a05:651c:2103:b0:25d:6478:2a57 with SMTP id
 a3-20020a05651c210300b0025d64782a57mr157386ljq.496.1659597907831; Thu, 04 Aug
 2022 00:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <CACGkMEvKVHNxMuU6ksZ7Apbbi0-cnHpY5DDwCenXXmbN_mEDPA@mail.gmail.com>
 <20220804030419-mutt-send-email-mst@kernel.org>
 <CACGkMEsxzDMFCPn2XRe+M=xai+Rouk9dHGnBXkymHUcvW5kr+Q@mail.gmail.com>
In-Reply-To: <CACGkMEsxzDMFCPn2XRe+M=xai+Rouk9dHGnBXkymHUcvW5kr+Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 4 Aug 2022 15:24:56 +0800
Message-ID: <CACGkMEs-EyNwue8jpieFAEdu+mrNsUdvxRUZ+POQgSt0zPkQ5Q@mail.gmail.com>
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

On Thu, Aug 4, 2022 at 3:23 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Aug 4, 2022 at 3:10 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Aug 04, 2022 at 01:00:46PM +0800, Jason Wang wrote:
> > > On Tue, Aug 2, 2022 at 12:47 PM Gavin Li <gavinl@nvidia.com> wrote:
> > > >
> > > > Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
> > > > packets even when GUEST_* offloads are not present on the device.
> > > > However, if GSO is not supported, it would be sufficient to allocate
> > > > segments to cover just up the MTU size and no further. Allocating the
> > > > maximum amount of segments results in a large waste of buffer space in
> > > > the queue, which limits the number of packets that can be buffered and
> > > > can result in reduced performance.
> > > >
> > > > Therefore, if GSO is not supported, use the MTU to calculate the
> > > > optimal amount of segments required.
> > > >
> > > > Below is the iperf TCP test results over a Mellanox NIC, using vDPA for
> > > > 1 VQ, queue size 1024, before and after the change, with the iperf
> > > > server running over the virtio-net interface.
> > > >
> > > > MTU(Bytes)/Bandwidth (Gbit/s)
> > > >              Before   After
> > > >   1500        22.5     22.4
> > > >   9000        12.8     25.9
> > > >
> > > > Signed-off-by: Gavin Li <gavinl@nvidia.com>
> > > > Reviewed-by: Gavi Teitz <gavi@nvidia.com>
> > > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 20 ++++++++++++++++----
> > > >  1 file changed, 16 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index ec8e1b3108c3..d36918c1809d 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -222,6 +222,9 @@ struct virtnet_info {
> > > >         /* I like... big packets and I cannot lie! */
> > > >         bool big_packets;
> > > >
> > > > +       /* Indicates GSO support */
> > > > +       bool gso_is_supported;
> > > > +
> > > >         /* Host will merge rx buffers for big packets (shake it! shake it!) */
> > > >         bool mergeable_rx_bufs;
> > > >
> > > > @@ -1312,14 +1315,21 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
> > > >  static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
> > > >                            gfp_t gfp)
> > > >  {
> > > > +       unsigned int sg_num = MAX_SKB_FRAGS;
> > > >         struct page *first, *list = NULL;
> > > >         char *p;
> > > >         int i, err, offset;
> > > >
> > > > -       sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
> > > > +       if (!vi->gso_is_supported) {
> > > > +               unsigned int mtu = vi->dev->mtu;
> > > > +
> > > > +               sg_num = (mtu % PAGE_SIZE) ? mtu / PAGE_SIZE + 1 : mtu / PAGE_SIZE;
> > > > +       }
> > > > +
> > > > +       sg_init_table(rq->sg, sg_num + 2);
> > > >
> > > >         /* page in rq->sg[MAX_SKB_FRAGS + 1] is list tail */
> > > > -       for (i = MAX_SKB_FRAGS + 1; i > 1; --i) {
> > > > +       for (i = sg_num + 1; i > 1; --i) {
> > > >                 first = get_a_page(rq, gfp);
> > > >                 if (!first) {
> > > >                         if (list)
> > > > @@ -1350,7 +1360,7 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
> > > >
> > > >         /* chain first in list head */
> > > >         first->private = (unsigned long)list;
> > > > -       err = virtqueue_add_inbuf(rq->vq, rq->sg, MAX_SKB_FRAGS + 2,
> > > > +       err = virtqueue_add_inbuf(rq->vq, rq->sg, sg_num + 2,
> > > >                                   first, gfp);
> > > >         if (err < 0)
> > > >                 give_pages(rq, first);
> > > > @@ -3571,8 +3581,10 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > >         if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > > >             virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
> > > >             virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
> > > > -           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
> > > > +           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO)) {
> > > >                 vi->big_packets = true;
> > > > +               vi->gso_is_supported = true;
> > >
> > > Why not simply re-use big_packets here?
> > >
> > > Thanks
> >
> > I don't get this question. The patch does use big_packets, it wants
> > to figure out guest GSO is off so MTU limits the size.
>
> Yes.
>
> Thanks

I wonder if it's better to introduce the boolean here:

        /* TODO: size buffers correctly in this case. */
                if (dev->mtu > ETH_DATA_LEN)
                        vi->big_packets = true;

Thanks

>
> > The name "gso_is_supported" is confusing, should be e.g. guest_gso.
> >
> >
> > > > +       }
> > > >
> > > >         if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
> > > >                 vi->mergeable_rx_bufs = true;
> > > > --
> > > > 2.31.1
> > > >
> > > >
> > > > ---------------------------------------------------------------------
> > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
