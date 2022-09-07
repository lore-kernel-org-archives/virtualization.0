Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0872C38145
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 09:26:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F1FE81469;
	Wed,  7 Sep 2022 09:26:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3F1FE81469
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S2P/8BIu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WmmdzAmsHHk9; Wed,  7 Sep 2022 09:26:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9257581405;
	Wed,  7 Sep 2022 09:26:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9257581405
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 648ACC0032;
	Wed,  7 Sep 2022 09:26:46 +0000 (UTC)
Received: from smtp1.osuosl.org (unknown
 [IPv6:2605:bc80:3010:0:a800:ff:fe97:d076])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27347C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 09:26:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EDF4A81469
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 09:26:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDF4A81469
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lbvD4f0YYS8G
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 09:26:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AFB7981405
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AFB7981405
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 09:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662542800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0YqY98OOdpwJPpqkeTlOBIKos4yfiX6vJ0r50FwcjCY=;
 b=S2P/8BIuuwVbFZDVUQaJzf4NzMzGrZPyaQFkijXoLHrHqD8R13esjQ6QsEF0RbFuHiE2YO
 N5KuZG/D0TpprBOhVJQ0KTrf2/E0G7oqIol+L4ZKc2WHJ2D2uq2awgPWqSGN8hqVyruGlE
 f4pCs+T4TqXCBI5CrCfPi3iDlQtYen4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-314-euAVb_7SOOSH53oGES8j0w-1; Wed, 07 Sep 2022 05:26:39 -0400
X-MC-Unique: euAVb_7SOOSH53oGES8j0w-1
Received: by mail-ej1-f69.google.com with SMTP id
 ga33-20020a1709070c2100b0074084f48b12so4598686ejc.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Sep 2022 02:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date;
 bh=0YqY98OOdpwJPpqkeTlOBIKos4yfiX6vJ0r50FwcjCY=;
 b=RRslNN6mtmDnb99+Wcyo21wtuBX4yOeDxfZZcWsEgzuGBl4SgRTuIvmkz8X0KHjyCY
 /Lvq6x/uy0xidyXNRFTCnJ+SbMD9wF5bMkMuDX8QRfKCTkPzAzJsRgfxPCz33okGb6sE
 d9nmBq0yFxwp4V9wJfjymO8HvrQ3UeZ+WVwrwN9comRNR++FQ21mg4APSZnJNJSwdBJv
 QPP04u00SM9QNXLXzgAmysiufbao2mGFfxa0MqHUJJoeQDm7IpkfFhKTe0+8tkgbdpea
 Y7xkQViW6dsKK4t+zTcgKPXC7IxOvQXIQgHci4Xh9v9wYq4SD1wj3cQWhxdvMFD59/Po
 Q5YA==
X-Gm-Message-State: ACgBeo3ez7uN3J28mfNlPK64MYIpK4nZQqLQHkE16PGLz3vw7ExUPcnb
 yQkIR6aZnIihoZtF1av6qpfJNk/jCte8kU/CABiKuIwtg83wUSasyI5sdwDmduxCZL9+//I2g/w
 wMs8UhGhv0qNNWa9N/cU/hz+3TB1CHW+hYaNBEMjCBg==
X-Received: by 2002:a17:906:8a70:b0:730:9c9e:edb2 with SMTP id
 hy16-20020a1709068a7000b007309c9eedb2mr1728848ejc.41.1662542798033; 
 Wed, 07 Sep 2022 02:26:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4L/fSV1pEM10gy1elhCNdmY3LbDKgfX0Th9sVFkt5011rnXIzUPG7wLtJ0VCFBv1rbM1LCJw==
X-Received: by 2002:a17:906:8a70:b0:730:9c9e:edb2 with SMTP id
 hy16-20020a1709068a7000b007309c9eedb2mr1728828ejc.41.1662542797748; 
 Wed, 07 Sep 2022 02:26:37 -0700 (PDT)
Received: from redhat.com ([2.52.135.118]) by smtp.gmail.com with ESMTPSA id
 w21-20020aa7dcd5000000b0044f0a2b9363sm1351048edu.41.2022.09.07.02.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 02:26:37 -0700 (PDT)
Date: Wed, 7 Sep 2022 05:26:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Li <gavinl@nvidia.com>
Subject: Re: [PATCH v5 2/2] virtio-net: use mtu size as buffer length for big
 packets
Message-ID: <20220907052317-mutt-send-email-mst@kernel.org>
References: <20220901021038.84751-1-gavinl@nvidia.com>
 <20220901021038.84751-3-gavinl@nvidia.com>
 <20220907012608-mutt-send-email-mst@kernel.org>
 <0355d1e4-a3cf-5b16-8c7f-b39b1ec14ade@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <0355d1e4-a3cf-5b16-8c7f-b39b1ec14ade@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org,
 sridhar.samudrala@intel.com, jesse.brandeburg@intel.com, gavi@nvidia.com,
 virtualization@lists.linux-foundation.org, stephen@networkplumber.org,
 loseweigh@gmail.com, netdev@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Sep 07, 2022 at 04:08:54PM +0800, Gavin Li wrote:
> =

> On 9/7/2022 1:31 PM, Michael S. Tsirkin wrote:
> > External email: Use caution opening links or attachments
> > =

> > =

> > On Thu, Sep 01, 2022 at 05:10:38AM +0300, Gavin Li wrote:
> > > Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
> > > packets even when GUEST_* offloads are not present on the device.
> > > However, if guest GSO is not supported, it would be sufficient to
> > > allocate segments to cover just up the MTU size and no further.
> > > Allocating the maximum amount of segments results in a large waste of
> > > buffer space in the queue, which limits the number of packets that can
> > > be buffered and can result in reduced performance.

actually how does this waste space? Is this because your
device does not have INDIRECT?

> > > =

> > > Therefore, if guest GSO is not supported, use the MTU to calculate the
> > > optimal amount of segments required.
> > > =

> > > When guest offload is enabled at runtime, RQ already has packets of b=
ytes
> > > less than 64K. So when packet of 64KB arrives, all the packets of such
> > > size will be dropped. and RQ is now not usable.
> > > =

> > > So this means that during set_guest_offloads() phase, RQs have to be
> > > destroyed and recreated, which requires almost driver reload.
> > > =

> > > If VIRTIO_NET_F_CTRL_GUEST_OFFLOADS has been negotiated, then it shou=
ld
> > > always treat them as GSO enabled.
> > > =

> > > Accordingly, for now the assumption is that if guest GSO has been
> > > negotiated then it has been enabled, even if it's actually been disab=
led
> > > at runtime through VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.
> > > =

> > > Below is the iperf TCP test results over a Mellanox NIC, using vDPA f=
or
> > > 1 VQ, queue size 1024, before and after the change, with the iperf
> > > server running over the virtio-net interface.
> > > =

> > > MTU(Bytes)/Bandwidth (Gbit/s)
> > >               Before   After
> > >    1500        22.5     22.4
> > >    9000        12.8     25.9


is this buffer space?
just the overhead of allocating/freeing the buffers?
of using INDIRECT?


> > > =

> > > Signed-off-by: Gavin Li <gavinl@nvidia.com>
> > > Reviewed-by: Gavi Teitz <gavi@nvidia.com>
> > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > =

> > Which configurations were tested?
> I tested it with DPDK vDPA + qemu vhost. Do you mean the feature set of t=
he
> VM?

yes

> > Did you test devices without VIRTIO_NET_F_MTU ?
> No.=A0 It will need code changes.


Testing to make sure nothing broke should not require changes.

> > =

> > > ---
> > > changelog:
> > > v4->v5
> > > - Addressed comments from Michael S. Tsirkin
> > > - Improve commit message
> > > v3->v4
> > > - Addressed comments from Si-Wei
> > > - Rename big_packets_sg_num with big_packets_num_skbfrags
> > > v2->v3
> > > - Addressed comments from Si-Wei
> > > - Simplify the condition check to enable the optimization
> > > v1->v2
> > > - Addressed comments from Jason, Michael, Si-Wei.
> > > - Remove the flag of guest GSO support, set sg_num for big packets and
> > >    use it directly
> > > - Recalculate sg_num for big packets in virtnet_set_guest_offloads
> > > - Replace the round up algorithm with DIV_ROUND_UP
> > > ---
> > >   drivers/net/virtio_net.c | 37 ++++++++++++++++++++++++-------------
> > >   1 file changed, 24 insertions(+), 13 deletions(-)
> > > =

> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index f831a0290998..dbffd5f56fb8 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -225,6 +225,9 @@ struct virtnet_info {
> > >        /* I like... big packets and I cannot lie! */
> > >        bool big_packets;
> > > =

> > > +     /* number of sg entries allocated for big packets */
> > > +     unsigned int big_packets_num_skbfrags;
> > > +
> > >        /* Host will merge rx buffers for big packets (shake it! shake=
 it!) */
> > >        bool mergeable_rx_bufs;
> > > =

> > > @@ -1331,10 +1334,10 @@ static int add_recvbuf_big(struct virtnet_inf=
o *vi, struct receive_queue *rq,
> > >        char *p;
> > >        int i, err, offset;
> > > =

> > > -     sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
> > > +     sg_init_table(rq->sg, vi->big_packets_num_skbfrags + 2);
> > > =

> > > -     /* page in rq->sg[MAX_SKB_FRAGS + 1] is list tail */
> > > -     for (i =3D MAX_SKB_FRAGS + 1; i > 1; --i) {
> > > +     /* page in rq->sg[vi->big_packets_num_skbfrags + 1] is list tai=
l */
> > > +     for (i =3D vi->big_packets_num_skbfrags + 1; i > 1; --i) {
> > >                first =3D get_a_page(rq, gfp);
> > >                if (!first) {
> > >                        if (list)
> > > @@ -1365,7 +1368,7 @@ static int add_recvbuf_big(struct virtnet_info =
*vi, struct receive_queue *rq,
> > > =

> > >        /* chain first in list head */
> > >        first->private =3D (unsigned long)list;
> > > -     err =3D virtqueue_add_inbuf(rq->vq, rq->sg, MAX_SKB_FRAGS + 2,
> > > +     err =3D virtqueue_add_inbuf(rq->vq, rq->sg, vi->big_packets_num=
_skbfrags + 2,
> > >                                  first, gfp);
> > >        if (err < 0)
> > >                give_pages(rq, first);
> > > @@ -3690,13 +3693,27 @@ static bool virtnet_check_guest_gso(const str=
uct virtnet_info *vi)
> > >                virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO);
> > >   }
> > > =

> > > +static void virtnet_set_big_packets_fields(struct virtnet_info *vi, =
const int mtu)
> > =

> > I'd rename this to just virtnet_set_big_packets.
> ACK
> > =

> > =

> > > +{
> > > +     bool guest_gso =3D virtnet_check_guest_gso(vi);
> > > +
> > > +     /* If device can receive ANY guest GSO packets, regardless of m=
tu,
> > > +      * allocate packets of maximum size, otherwise limit it to only
> > > +      * mtu size worth only.
> > > +      */
> > > +     if (mtu > ETH_DATA_LEN || guest_gso) {
> > > +             vi->big_packets =3D true;
> > > +             vi->big_packets_num_skbfrags =3D guest_gso ? MAX_SKB_FR=
AGS : DIV_ROUND_UP(mtu, PAGE_SIZE);
> > > +     }
> > > +}
> > > +
> > >   static int virtnet_probe(struct virtio_device *vdev)
> > >   {
> > >        int i, err =3D -ENOMEM;
> > >        struct net_device *dev;
> > >        struct virtnet_info *vi;
> > >        u16 max_queue_pairs;
> > > -     int mtu;
> > > +     int mtu =3D 0;
> > > =

> > >        /* Find if host supports multiqueue/rss virtio_net device */
> > >        max_queue_pairs =3D 1;
> > > @@ -3784,10 +3801,6 @@ static int virtnet_probe(struct virtio_device =
*vdev)
> > >        INIT_WORK(&vi->config_work, virtnet_config_changed_work);
> > >        spin_lock_init(&vi->refill_lock);
> > > =

> > > -     /* If we can receive ANY GSO packets, we must allocate large on=
es. */
> > > -     if (virtnet_check_guest_gso(vi))
> > > -             vi->big_packets =3D true;
> > > -
> > >        if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
> > >                vi->mergeable_rx_bufs =3D true;
> > > =

> > > @@ -3853,12 +3866,10 @@ static int virtnet_probe(struct virtio_device=
 *vdev)
> > > =

> > >                dev->mtu =3D mtu;
> > >                dev->max_mtu =3D mtu;
> > > -
> > > -             /* TODO: size buffers correctly in this case. */
> > > -             if (dev->mtu > ETH_DATA_LEN)
> > > -                     vi->big_packets =3D true;
> > >        }
> > > =

> > > +     virtnet_set_big_packets_fields(vi, mtu);
> > > +
> > If VIRTIO_NET_F_MTU is off, then mtu is uninitialized.
> > You should move it to within if () above to fix.
> mtu was initialized to 0 at the beginning of probe if VIRTIO_NET_F_MTU is
> off.
> =

> In this case,=A0 big_packets_num_skbfrags will be set according to guest =
gso.
> =

> If guest gso is supported, it will be set to MAX_SKB_FRAGS else zero---- =
do
> you
> =

> think this is a bug to be fixed?


yes I think with no mtu this should behave as it did
historically.

> > =

> > >        if (vi->any_header_sg)
> > >                dev->needed_headroom =3D vi->hdr_len;
> > > =

> > > --
> > > 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
