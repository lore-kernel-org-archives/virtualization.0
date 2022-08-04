Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A986C00144
	for <virtualization@archiver.kernel.org>; Thu,  4 Aug 2022 05:01:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0069C40527;
	Thu,  4 Aug 2022 05:01:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0069C40527
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f9QDXRjc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0nwPOghXqXTa; Thu,  4 Aug 2022 05:01:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 65C77400F8;
	Thu,  4 Aug 2022 05:01:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 65C77400F8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B9A9C0032;
	Thu,  4 Aug 2022 05:01:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 113B2C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 05:01:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C7EBF4174C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 05:01:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C7EBF4174C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=f9QDXRjc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rw8yCzHN4aNl
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 05:01:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 351ED416F5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 351ED416F5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 05:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659589262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AyKLgSQD62ObViQQvA5kc3yUB4WuZZ46K9qqGfSrgPE=;
 b=f9QDXRjcLP8dyDdlv0I1QIKoWE9XYKlyWeioa90QriiGGUjChPx/Kxm/3hN59A88tbw+J6
 UXmRzyFPqAfpv7Kw9D2FGOihdDrsxRAwRj2KTtKWWP19IrlFNzWXmV7OJQu8helLGfWhUG
 sOU58BwwrcZmNZwm4V68zaXnXxoW0+k=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-TgydCWZKOOyVxEh-H7uAhQ-1; Thu, 04 Aug 2022 01:00:59 -0400
X-MC-Unique: TgydCWZKOOyVxEh-H7uAhQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 by17-20020a05651c1a1100b0025e54bda6c7so2716713ljb.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Aug 2022 22:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AyKLgSQD62ObViQQvA5kc3yUB4WuZZ46K9qqGfSrgPE=;
 b=VyHuuQ442dGnAS2hOU6kRYzUIn6IXAaiYioJIGfVC/EcKlMHXfX+vMJXNV23RL5YBl
 5WwIonIqkLyrF/f9kbO4NiiM5cdpiJA8NKyBN2PVfGHfoDiqgPQGpzGKQw77rDXaH+OQ
 0zDSOAlayF1ME0hFtHp2BlSymLI23YHqnqJNQeSrTDu3LcI3tDeJuOZwuX9CYvdcgK/8
 Xq5e9WK+oU/sio/bG57fGvqAG5RaRymrft7h0mTeI4IVZFCKzuc7/oyg0cFmUxZlf/6x
 vgVE6vkTxam8KP0z9pKbbB+P3K5GaAlp2pKpfhVRLc4tKAYfcLcwnz77+ztbZ+pbakNd
 jLXQ==
X-Gm-Message-State: ACgBeo0csHPnRY4zSbO30HsBvA6G8VHCczW1fysDEaoQn4Zehtdrpuh6
 PIPEoHWJiUFAUc8Gizs2m2ZtzpqG7v4SykzXuUvK92bvXIfGcwVYmRtaOI3t0YlCCcDMJixhXrH
 YHYkPzBeGxnW5gAaX0BJg22ADq2KeLUOx7QvrPojH1HAZJRG5kKyWO3Ll+A==
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id
 y14-20020a0565123f0e00b0048a5edd99b2mr91493lfa.124.1659589257620; 
 Wed, 03 Aug 2022 22:00:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4yzWvNQux4mbQOwTQL5/nciSMoA6vrusapjuyD2sBYjpIOrmC+2m9Tj81Z4tHhGJLsYsfLDqGHb7KASZL+NBg=
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id
 y14-20020a0565123f0e00b0048a5edd99b2mr91481lfa.124.1659589257411; Wed, 03 Aug
 2022 22:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220802044548.9031-1-gavinl@nvidia.com>
In-Reply-To: <20220802044548.9031-1-gavinl@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 4 Aug 2022 13:00:46 +0800
Message-ID: <CACGkMEvKVHNxMuU6ksZ7Apbbi0-cnHpY5DDwCenXXmbN_mEDPA@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
To: Gavin Li <gavinl@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: alexander.h.duyck@intel.com, Virtio-Dev <virtio-dev@lists.oasis-open.org>,
 mst <mst@redhat.com>, kubakici@wp.pl, sridhar.samudrala@intel.com,
 jesse.brandeburg@intel.com, gavi@nvidia.com,
 virtualization <virtualization@lists.linux-foundation.org>, "Hemminger,
 Stephen" <stephen@networkplumber.org>, loseweigh@gmail.com,
 davem <davem@davemloft.net>
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

On Tue, Aug 2, 2022 at 12:47 PM Gavin Li <gavinl@nvidia.com> wrote:
>
> Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
> packets even when GUEST_* offloads are not present on the device.
> However, if GSO is not supported, it would be sufficient to allocate
> segments to cover just up the MTU size and no further. Allocating the
> maximum amount of segments results in a large waste of buffer space in
> the queue, which limits the number of packets that can be buffered and
> can result in reduced performance.
>
> Therefore, if GSO is not supported, use the MTU to calculate the
> optimal amount of segments required.
>
> Below is the iperf TCP test results over a Mellanox NIC, using vDPA for
> 1 VQ, queue size 1024, before and after the change, with the iperf
> server running over the virtio-net interface.
>
> MTU(Bytes)/Bandwidth (Gbit/s)
>              Before   After
>   1500        22.5     22.4
>   9000        12.8     25.9
>
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Gavi Teitz <gavi@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ec8e1b3108c3..d36918c1809d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -222,6 +222,9 @@ struct virtnet_info {
>         /* I like... big packets and I cannot lie! */
>         bool big_packets;
>
> +       /* Indicates GSO support */
> +       bool gso_is_supported;
> +
>         /* Host will merge rx buffers for big packets (shake it! shake it!) */
>         bool mergeable_rx_bufs;
>
> @@ -1312,14 +1315,21 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>  static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
>                            gfp_t gfp)
>  {
> +       unsigned int sg_num = MAX_SKB_FRAGS;
>         struct page *first, *list = NULL;
>         char *p;
>         int i, err, offset;
>
> -       sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
> +       if (!vi->gso_is_supported) {
> +               unsigned int mtu = vi->dev->mtu;
> +
> +               sg_num = (mtu % PAGE_SIZE) ? mtu / PAGE_SIZE + 1 : mtu / PAGE_SIZE;
> +       }
> +
> +       sg_init_table(rq->sg, sg_num + 2);
>
>         /* page in rq->sg[MAX_SKB_FRAGS + 1] is list tail */
> -       for (i = MAX_SKB_FRAGS + 1; i > 1; --i) {
> +       for (i = sg_num + 1; i > 1; --i) {
>                 first = get_a_page(rq, gfp);
>                 if (!first) {
>                         if (list)
> @@ -1350,7 +1360,7 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
>
>         /* chain first in list head */
>         first->private = (unsigned long)list;
> -       err = virtqueue_add_inbuf(rq->vq, rq->sg, MAX_SKB_FRAGS + 2,
> +       err = virtqueue_add_inbuf(rq->vq, rq->sg, sg_num + 2,
>                                   first, gfp);
>         if (err < 0)
>                 give_pages(rq, first);
> @@ -3571,8 +3581,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>         if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>             virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
>             virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
> -           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
> +           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO)) {
>                 vi->big_packets = true;
> +               vi->gso_is_supported = true;

Why not simply re-use big_packets here?

Thanks

> +       }
>
>         if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
>                 vi->mergeable_rx_bufs = true;
> --
> 2.31.1
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
