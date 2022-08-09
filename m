Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7103AC19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 21:34:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E78C0404F0;
	Tue,  9 Aug 2022 21:34:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E78C0404F0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ibKcv4l8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bK-s67MXaZbA; Tue,  9 Aug 2022 21:34:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6841D404CF;
	Tue,  9 Aug 2022 21:34:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6841D404CF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35772C0032;
	Tue,  9 Aug 2022 21:34:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D51DFC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:34:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AB23E81355
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:34:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB23E81355
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ibKcv4l8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3DzvlbQWxsL4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:34:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C18A81352
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3C18A81352
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660080850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p62J3cuVW7uUQWD5Y0bsnExlFrgsja8f+ApHEHxDtSM=;
 b=ibKcv4l8LcAOiLlxcwlRI8+swBzNro36jCiSbvBWpG61u7yKeN9Yg7gsA14vlJbSEhQJwt
 oXEI5PQFZuR97G6kYyaAipY1nhfLTRqZCN/ER4i0592cDlKmwoknFEqDQBjBjT9KclNEcD
 qgIKgFkshgUOMKTGngbmwqXDeIR4Fmc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-LYJsqEV7PyOqw8ZY2wte0Q-1; Tue, 09 Aug 2022 17:34:09 -0400
X-MC-Unique: LYJsqEV7PyOqw8ZY2wte0Q-1
Received: by mail-ed1-f69.google.com with SMTP id
 x20-20020a05640226d400b0043d50aadf3fso8059759edd.23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 14:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=p62J3cuVW7uUQWD5Y0bsnExlFrgsja8f+ApHEHxDtSM=;
 b=fxJ2+Xli4OYc6hUDgOSCIj+08s+u7KjLQtZhSxcPjmXS8U7HpQTA8oaQla9fFmbaVC
 uDVwLJFCaxvw4Vi+Js/HHvqlcje37cafnJvta+PloaqPhQ1E8gsZoPUYRGeYnJwHlm3x
 pKVVKYcfeKQ9LhQtrf/CRqMzgN97bkDS1jM31rgRksiivvEKDiHzOOybaiWjfgxCdlQz
 XXYcWTBFqE1PbKRKaParRCEyvOMGUZKlBA3FUFyvZ0Cl+nu9H+GDv8in1c2w56mPwICk
 +Xe2tFg449S0JfrINrPuercUaN+gMJnRf2epfiUvUUH7ksccumslayibf4gcXdqCkG+E
 89FA==
X-Gm-Message-State: ACgBeo2p596ERjKRpX1Tnlis0LkZPPGZVymikyeTG808EX3HfSaSWR0q
 KU46ZJ21TVaygGpsvb7fxeA3KOlFd2h0H/i6T2KnetpnShSafmNDAYHMS8IAO5oAzQjnlkOsvvQ
 Tu4iJaXU25py9bFKorMrUVxUeN9kQG6IsVdMyN7qIZg==
X-Received: by 2002:a17:907:6e17:b0:731:2426:f606 with SMTP id
 sd23-20020a1709076e1700b007312426f606mr12311011ejc.162.1660080848266; 
 Tue, 09 Aug 2022 14:34:08 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Xz74o/689HIk5ixg+EHK446e7FYelqZazKGzDzO6OMt+s2ausAfdz4n72iJcU3j11Hw5jYw==
X-Received: by 2002:a17:907:6e17:b0:731:2426:f606 with SMTP id
 sd23-20020a1709076e1700b007312426f606mr12311004ejc.162.1660080847992; 
 Tue, 09 Aug 2022 14:34:07 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 kz21-20020a17090777d500b007315c723ac8sm1535345ejc.224.2022.08.09.14.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Aug 2022 14:34:07 -0700 (PDT)
Date: Tue, 9 Aug 2022 17:34:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Message-ID: <20220809173305-mutt-send-email-mst@kernel.org>
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
MIME-Version: 1.0
In-Reply-To: <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
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

On Tue, Aug 09, 2022 at 11:38:52AM -0700, Si-Wei Liu wrote:
> 
> 
> On 8/9/2022 12:44 AM, Jason Wang wrote:
> > On Tue, Aug 9, 2022 at 3:07 PM Gavin Li <gavinl@nvidia.com> wrote:
> > > 
> > > On 8/9/2022 7:56 AM, Si-Wei Liu wrote:
> > > 
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > On 8/8/2022 12:31 AM, Gavin Li wrote:
> > > 
> > > 
> > > On 8/6/2022 6:11 AM, Si-Wei Liu wrote:
> > > 
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > On 8/1/2022 9:45 PM, Gavin Li wrote:
> > > 
> > > Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
> > > packets even when GUEST_* offloads are not present on the device.
> > > However, if GSO is not supported,
> > > 
> > > GUEST GSO (virtio term), or GRO HW (netdev core term) it should have
> > > been be called.
> > > 
> > > ACK
> > > 
> > > 
> > >    it would be sufficient to allocate
> > > segments to cover just up the MTU size and no further. Allocating the
> > > maximum amount of segments results in a large waste of buffer space in
> > > the queue, which limits the number of packets that can be buffered and
> > > can result in reduced performance.
> > > 
> > > Therefore, if GSO is not supported,
> > > 
> > > Ditto.
> > > 
> > > ACK
> > > 
> > > 
> > > use the MTU to calculate the
> > > optimal amount of segments required.
> > > 
> > > Below is the iperf TCP test results over a Mellanox NIC, using vDPA for
> > > 1 VQ, queue size 1024, before and after the change, with the iperf
> > > server running over the virtio-net interface.
> > > 
> > > MTU(Bytes)/Bandwidth (Gbit/s)
> > >                Before   After
> > >     1500        22.5     22.4
> > >     9000        12.8     25.9
> > > 
> > > Signed-off-by: Gavin Li <gavinl@nvidia.com>
> > > Reviewed-by: Gavi Teitz <gavi@nvidia.com>
> > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > ---
> > >    drivers/net/virtio_net.c | 20 ++++++++++++++++----
> > >    1 file changed, 16 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index ec8e1b3108c3..d36918c1809d 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -222,6 +222,9 @@ struct virtnet_info {
> > >        /* I like... big packets and I cannot lie! */
> > >        bool big_packets;
> > > 
> > > +     /* Indicates GSO support */
> > > +     bool gso_is_supported;
> > > +
> > >        /* Host will merge rx buffers for big packets (shake it! shake
> > > it!) */
> > >        bool mergeable_rx_bufs;
> > > 
> > > @@ -1312,14 +1315,21 @@ static int add_recvbuf_small(struct
> > > virtnet_info *vi, struct receive_queue *rq,
> > >    static int add_recvbuf_big(struct virtnet_info *vi, struct
> > > receive_queue *rq,
> > >                           gfp_t gfp)
> > >    {
> > > +     unsigned int sg_num = MAX_SKB_FRAGS;
> > >        struct page *first, *list = NULL;
> > >        char *p;
> > >        int i, err, offset;
> > > 
> > > -     sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
> > > +     if (!vi->gso_is_supported) {
> > > +             unsigned int mtu = vi->dev->mtu;
> > > +
> > > +             sg_num = (mtu % PAGE_SIZE) ? mtu / PAGE_SIZE + 1 : mtu
> > > / PAGE_SIZE;
> > > 
> > > DIV_ROUND_UP() can be used?
> > > 
> > > ACK
> > > 
> > > 
> > > Since this branch slightly adds up cost to the datapath, I wonder if
> > > this sg_num can be saved and set only once (generally in virtnet_probe
> > > time) in struct virtnet_info?
> > > 
> > > Not sure how to do it and align it with align with new mtu during
> > > .ndo_change_mtu()---as you mentioned in the following mail. Any idea?
> > > ndo_change_mtu might be in vendor specific code and unmanageable. In
> > > my case, the mtu can only be changed in the xml of the guest vm.
> > > 
> > > Nope, for e.g. "ip link dev eth0 set mtu 1500" can be done from guest on
> > > a virtio-net device with 9000 MTU (as defined in guest xml). Basically
> > > guest user can set MTU to any valid value lower than the original
> > > HOST_MTU. In the vendor defined .ndo_change_mtu() op, dev_validate_mtu()
> > > should have validated the MTU value before coming down to it. And I
> > > suspect you might want to do virtnet_close() and virtnet_open()
> > > before/after changing the buffer size on the fly (the netif_running()
> > > case), implementing .ndo_change_mtu() will be needed anyway.
> > > 
> > > a guest VM driver changing mtu to smaller one is valid use case. However, current optimization suggested in the patch doesn't degrade any performance. Performing close() and open() sequence is good idea, that I would like to take up next after this patch as its going to be more than one patch to achieve it.
> > Right, it could be done on top.
> > 
> > But another note is that, it would still be better to support GUEST GSO feature:
> > 
> > 1) can work for the case for path MTU
> > 2) (migration)compatibility with software backends
> > 
> > > 
> > > +     }
> > > +
> > > +     sg_init_table(rq->sg, sg_num + 2);
> > > 
> > >        /* page in rq->sg[MAX_SKB_FRAGS + 1] is list tail */
> > > 
> > > Comment doesn't match code.
> > > 
> > > ACK
> > > 
> > > -     for (i = MAX_SKB_FRAGS + 1; i > 1; --i) {
> > > +     for (i = sg_num + 1; i > 1; --i) {
> > >                first = get_a_page(rq, gfp);
> > >                if (!first) {
> > >                        if (list)
> > > @@ -1350,7 +1360,7 @@ static int add_recvbuf_big(struct virtnet_info
> > > *vi, struct receive_queue *rq,
> > > 
> > >        /* chain first in list head */
> > >        first->private = (unsigned long)list;
> > > -     err = virtqueue_add_inbuf(rq->vq, rq->sg, MAX_SKB_FRAGS + 2,
> > > +     err = virtqueue_add_inbuf(rq->vq, rq->sg, sg_num + 2,
> > >                                  first, gfp);
> > >        if (err < 0)
> > >                give_pages(rq, first);
> > > @@ -3571,8 +3581,10 @@ static int virtnet_probe(struct virtio_device
> > > *vdev)
> > >        if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > >            virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
> > >            virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
> > > -         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
> > > +         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO)) {
> > >                vi->big_packets = true;
> > > +             vi->gso_is_supported = true;
> > > 
> > > Please do the same for virtnet_clear_guest_offloads(), and
> > > correspondingly virtnet_restore_guest_offloads() as well. Not sure why
> > > virtnet_clear_guest_offloads() or the caller doesn't unset big_packet on
> > > successful return, seems like a bug to me.
> > It is fine as long as
> > 
> > 1) we don't implement ethtool API for changing guest offloads
> Not sure if I missed something, but it looks the current
> virtnet_set_features() already supports toggling on/off GRO HW through
> commit a02e8964eaf9271a8a5fcc0c55bd13f933bafc56 (formerly misnamed as LRO).
> Sorry, I realized I had a typo in email: "virtnet_set_guest_offloads() or
> the caller doesn't unset big_packet ...".

"we" here is the device, not the driver.

> > 2) big mode XDP is not enabled
> Currently it is not. Not a single patch nor this patch, but the context for
> the eventual goal is to allow XDP on a MTU=9000 link when guest users
> intentionally lower down MTU to 1500.
> 
> Regards,
> -Siwei
> > 
> > So that code works only for XDP but we forbid big packets in the case
> > of XDP right now.
> > 
> > Thanks
> > 
> > > ACK. The two calls virtnet_set_guest_offloads and
> > > virtnet_set_guest_offloads is also called by virtnet_set_features. Do
> > > you think if I can do this in virtnet_set_guest_offloads?
> > > 
> > > I think that it should be fine, though you may want to deal with the XDP
> > > path not to regress it.
> > > 
> > > -Siwei
> > > 
> > > 
> > > 
> > > Thanks,
> > > -Siwei
> > > 
> > > +     }
> > > 
> > >        if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
> > >                vi->mergeable_rx_bufs = true;
> > > 
> > > 
> > > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
