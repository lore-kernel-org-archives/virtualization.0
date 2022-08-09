Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253A8C19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 07:44:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97A9E60BD0;
	Tue,  9 Aug 2022 07:44:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 97A9E60BD0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b4kMhl4a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mcHJn9X9StnV; Tue,  9 Aug 2022 07:44:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B7800600C7;
	Tue,  9 Aug 2022 07:44:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B7800600C7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75786C0033;
	Tue,  9 Aug 2022 07:44:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EABFC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 07:44:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 050844093F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 07:44:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 050844093F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=b4kMhl4a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dGqbVETA2YG6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 07:44:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 902C640884
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 902C640884
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 07:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660031079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z4Bz55qFTwr3OKFqiSce1kJLs6AwCJOx1r+Qik6rDKQ=;
 b=b4kMhl4aDroK1ys5zhVQIgAGHUzaeXdMklcKOPScBrxaiKDlv5OxSgyLBnZLWWXtkHMLAt
 srymooABfwuH/e4ADRMAIrshnH2mF4ZNMMcSN6M0fU/TvGENBM2emjZQhrY5Y4kHgH0zVQ
 dNU1D4cwPSMvQrV6+1gumhh9382K+To=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-n6SrlialM5eywnRceem_cw-1; Tue, 09 Aug 2022 03:44:35 -0400
X-MC-Unique: n6SrlialM5eywnRceem_cw-1
Received: by mail-lf1-f72.google.com with SMTP id
 w18-20020ac25d52000000b0048af13b6ef6so2570076lfd.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 00:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=z4Bz55qFTwr3OKFqiSce1kJLs6AwCJOx1r+Qik6rDKQ=;
 b=OFf8QXzVja2GzxEG/890jqLzYlLjayxLIPECYgN6m2fz9Hh3uCDdy5ZNGHj7bhWn6x
 9DNM7pmH9+bQqvP/WENUiQQAVjVwkupQAswiJPlNarB8uxczcZtNlpAnCzt/KrwnLcjT
 GLAqfSJ8sm3CCUWtxkPnDUt1yP353N1wN0QprCQexVRt7Lh4YDfkSu/fw9SDLBsA/QiS
 eXOLV9wCv3ILHa5BUAemNV0/xOuEO2x7/anpbxNv1eXwlBPoygNxfPWwo0v8KNZ4swwC
 BykVAvxXjSc+UYXxLsqEcJ52Jn3Y2g+U30CwUhKmuC1IUoNHedlnbCM4fXU9j0TqxTiq
 alMQ==
X-Gm-Message-State: ACgBeo3jjVrF0+XRwl0Cd1RUXQE65AK+6f3YX2wwCKaHhK7988Atzdbl
 No2gqS2HRG9Jyi2FslvhoH0MZGQCffTYHSeXtbwzFEcG6hXytt/T3gkqLAg27qZPJB8EIHG369l
 mTeqHUr5o93OrGse6kZoOLfZtgkAWPc8IGVhCbJzv3cCE51W1TzO5iASKXA==
X-Received: by 2002:ac2:43b0:0:b0:48b:1eb:d1e5 with SMTP id
 t16-20020ac243b0000000b0048b01ebd1e5mr8116455lfl.641.1660031074057; 
 Tue, 09 Aug 2022 00:44:34 -0700 (PDT)
X-Google-Smtp-Source: AA6agR67eh6JZqsznuuA47emFUSxlcn0YPxCT5Z0apTA+Q5cM8xhv7RsODGHk9gIaSIcn1ktE5Cx3+NeMvsvA34EoXs=
X-Received: by 2002:ac2:43b0:0:b0:48b:1eb:d1e5 with SMTP id
 t16-20020ac243b0000000b0048b01ebd1e5mr8116443lfl.641.1660031073826; Tue, 09
 Aug 2022 00:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
In-Reply-To: <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Aug 2022 15:44:22 +0800
Message-ID: <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
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

On Tue, Aug 9, 2022 at 3:07 PM Gavin Li <gavinl@nvidia.com> wrote:
>
>
> On 8/9/2022 7:56 AM, Si-Wei Liu wrote:
>
> External email: Use caution opening links or attachments
>
>
> On 8/8/2022 12:31 AM, Gavin Li wrote:
>
>
> On 8/6/2022 6:11 AM, Si-Wei Liu wrote:
>
> External email: Use caution opening links or attachments
>
>
> On 8/1/2022 9:45 PM, Gavin Li wrote:
>
> Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
> packets even when GUEST_* offloads are not present on the device.
> However, if GSO is not supported,
>
> GUEST GSO (virtio term), or GRO HW (netdev core term) it should have
> been be called.
>
> ACK
>
>
>   it would be sufficient to allocate
> segments to cover just up the MTU size and no further. Allocating the
> maximum amount of segments results in a large waste of buffer space in
> the queue, which limits the number of packets that can be buffered and
> can result in reduced performance.
>
> Therefore, if GSO is not supported,
>
> Ditto.
>
> ACK
>
>
> use the MTU to calculate the
> optimal amount of segments required.
>
> Below is the iperf TCP test results over a Mellanox NIC, using vDPA for
> 1 VQ, queue size 1024, before and after the change, with the iperf
> server running over the virtio-net interface.
>
> MTU(Bytes)/Bandwidth (Gbit/s)
>               Before   After
>    1500        22.5     22.4
>    9000        12.8     25.9
>
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Gavi Teitz <gavi@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> ---
>   drivers/net/virtio_net.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ec8e1b3108c3..d36918c1809d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -222,6 +222,9 @@ struct virtnet_info {
>       /* I like... big packets and I cannot lie! */
>       bool big_packets;
>
> +     /* Indicates GSO support */
> +     bool gso_is_supported;
> +
>       /* Host will merge rx buffers for big packets (shake it! shake
> it!) */
>       bool mergeable_rx_bufs;
>
> @@ -1312,14 +1315,21 @@ static int add_recvbuf_small(struct
> virtnet_info *vi, struct receive_queue *rq,
>   static int add_recvbuf_big(struct virtnet_info *vi, struct
> receive_queue *rq,
>                          gfp_t gfp)
>   {
> +     unsigned int sg_num = MAX_SKB_FRAGS;
>       struct page *first, *list = NULL;
>       char *p;
>       int i, err, offset;
>
> -     sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
> +     if (!vi->gso_is_supported) {
> +             unsigned int mtu = vi->dev->mtu;
> +
> +             sg_num = (mtu % PAGE_SIZE) ? mtu / PAGE_SIZE + 1 : mtu
> / PAGE_SIZE;
>
> DIV_ROUND_UP() can be used?
>
> ACK
>
>
> Since this branch slightly adds up cost to the datapath, I wonder if
> this sg_num can be saved and set only once (generally in virtnet_probe
> time) in struct virtnet_info?
>
> Not sure how to do it and align it with align with new mtu during
> .ndo_change_mtu()---as you mentioned in the following mail. Any idea?
> ndo_change_mtu might be in vendor specific code and unmanageable. In
> my case, the mtu can only be changed in the xml of the guest vm.
>
> Nope, for e.g. "ip link dev eth0 set mtu 1500" can be done from guest on
> a virtio-net device with 9000 MTU (as defined in guest xml). Basically
> guest user can set MTU to any valid value lower than the original
> HOST_MTU. In the vendor defined .ndo_change_mtu() op, dev_validate_mtu()
> should have validated the MTU value before coming down to it. And I
> suspect you might want to do virtnet_close() and virtnet_open()
> before/after changing the buffer size on the fly (the netif_running()
> case), implementing .ndo_change_mtu() will be needed anyway.
>
> a guest VM driver changing mtu to smaller one is valid use case. However, current optimization suggested in the patch doesn't degrade any performance. Performing close() and open() sequence is good idea, that I would like to take up next after this patch as its going to be more than one patch to achieve it.

Right, it could be done on top.

But another note is that, it would still be better to support GUEST GSO feature:

1) can work for the case for path MTU
2) (migration)compatibility with software backends

>
>
> +     }
> +
> +     sg_init_table(rq->sg, sg_num + 2);
>
>       /* page in rq->sg[MAX_SKB_FRAGS + 1] is list tail */
>
> Comment doesn't match code.
>
> ACK
>
> -     for (i = MAX_SKB_FRAGS + 1; i > 1; --i) {
> +     for (i = sg_num + 1; i > 1; --i) {
>               first = get_a_page(rq, gfp);
>               if (!first) {
>                       if (list)
> @@ -1350,7 +1360,7 @@ static int add_recvbuf_big(struct virtnet_info
> *vi, struct receive_queue *rq,
>
>       /* chain first in list head */
>       first->private = (unsigned long)list;
> -     err = virtqueue_add_inbuf(rq->vq, rq->sg, MAX_SKB_FRAGS + 2,
> +     err = virtqueue_add_inbuf(rq->vq, rq->sg, sg_num + 2,
>                                 first, gfp);
>       if (err < 0)
>               give_pages(rq, first);
> @@ -3571,8 +3581,10 @@ static int virtnet_probe(struct virtio_device
> *vdev)
>       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
>           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
> -         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
> +         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO)) {
>               vi->big_packets = true;
> +             vi->gso_is_supported = true;
>
> Please do the same for virtnet_clear_guest_offloads(), and
> correspondingly virtnet_restore_guest_offloads() as well. Not sure why
> virtnet_clear_guest_offloads() or the caller doesn't unset big_packet on
> successful return, seems like a bug to me.

It is fine as long as

1) we don't implement ethtool API for changing guest offloads
2) big mode XDP is not enabled

So that code works only for XDP but we forbid big packets in the case
of XDP right now.

Thanks

>
> ACK. The two calls virtnet_set_guest_offloads and
> virtnet_set_guest_offloads is also called by virtnet_set_features. Do
> you think if I can do this in virtnet_set_guest_offloads?
>
> I think that it should be fine, though you may want to deal with the XDP
> path not to regress it.
>
> -Siwei
>
>
>
> Thanks,
> -Siwei
>
> +     }
>
>       if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
>               vi->mergeable_rx_bufs = true;
>
>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
