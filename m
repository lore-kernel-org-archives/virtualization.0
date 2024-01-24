Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3A163A8
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 06:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706076369; cv=none; b=tMMGHuRraw7xRpHCquq0X80gnRxA1MkW5jMhUPED6Z8/O6f/0OQgQYonxz4hUHOLW/3Nxy4ARnwLgtgPXD/eOj4T06NsmKcNPNceJW52THOhiNdma7FghotDzWnUrpNyAfvXi4xWsy+Vs6Dy39sTrvhP64NfafvcdUnTEP5IWI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706076369; c=relaxed/simple;
	bh=yVInM+tXrY5OJzT0NyfKM7ozZ8TrMZhVwmPsJ7bUilI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=REzg6+qw/o3J6b34INKjkeTHof9RkzzdjT/q34IyNvNzHEnltMq10IElNWRGWjb+cIL+H3HgvNgyr16HHbOo2o+hJQEpBIqvSAFDvn5IV1SgJfaU1Y1ZBFSUiGbmRHWYMvdN6qX8U7cjXkBUIRCJSY0S2/dXfRTrcs1iTsvU4mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8DEB613B0
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 06:06:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8DEB613B0
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZY1YUJX9T64d
	for <virtualization@lists.linux-foundation.org>;
	Wed, 24 Jan 2024 06:06:04 +0000 (UTC)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 12C2F61194
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 06:06:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 12C2F61194
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.FDuvi_1706076358;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.FDuvi_1706076358)
          by smtp.aliyun-inc.com;
          Wed, 24 Jan 2024 14:05:58 +0800
Message-ID: <1706076301.4647658-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: Support RX hash XDP hint
Date: Wed, 24 Jan 2024 14:05:01 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: mst@redhat.com,
 jasowang@redhat.com,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org,
 Heng Qi <hengqi@linux.alibaba.com>
References: <20240122102256.261374-1-liangchen.linux@gmail.com>
 <4ada64aa-87ec-4340-9892-be52c1f27a97@linux.alibaba.com>
 <CAKhg4t+ayD-MPK8FwZFURZyX32d8gk26GdytwRiRjJBwBbaR6w@mail.gmail.com>
In-Reply-To: <CAKhg4t+ayD-MPK8FwZFURZyX32d8gk26GdytwRiRjJBwBbaR6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 24 Jan 2024 10:04:51 +0800, Liang Chen <liangchen.linux@gmail.com> =
wrote:
> On Mon, Jan 22, 2024 at 7:10=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com=
> wrote:
> >
> > Hi Liang Chen,
> >
> > =E5=9C=A8 2024/1/22 =E4=B8=8B=E5=8D=886:22, Liang Chen =E5=86=99=E9=81=
=93:
> > > The RSS hash report is a feature that's part of the virtio specificat=
ion.
> > > Currently, virtio backends like qemu, vdpa (mlx5), and potentially vh=
ost
> > > (still a work in progress as per [1]) support this feature. While the
> > > capability to obtain the RSS hash has been enabled in the normal path,
> > > it's currently missing in the XDP path. Therefore, we are introducing=
 XDP
> > > hints through kfuncs to allow XDP programs to access the RSS hash.
> > >
> > > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > > ---
> > >   drivers/net/virtio_net.c | 56 +++++++++++++++++++++++++++++++++++++=
+++
> > >   1 file changed, 56 insertions(+)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index d7ce4a1011ea..1463a4709e3c 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -4579,6 +4579,60 @@ static void virtnet_set_big_packets(struct vir=
tnet_info *vi, const int mtu)
> > >       }
> > >   }
> > >
> > > +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> > > +                        enum xdp_rss_hash_type *rss_type)
> > > +{
> > > +     const struct xdp_buff *xdp =3D (void *)_ctx;
> > > +     struct virtio_net_hdr_v1_hash *hdr_hash;
> > > +     struct virtnet_info *vi;
> > > +
> > > +     if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
> >
> > I think 'vi->has_rss_hash_report' should be used here.
> > NETIF_F_RXHASH cannot guarantee that the hash report feature is negotia=
ted,
> > and accessing hash_report and hash_value is unsafe at this time.
> >
>
> My understanding is that rxhash in dev->features is turned on only if
> the corresponding hw feature is set. We will double check on this.
>
> > > +             return -ENODATA;
> > > +
> > > +     vi =3D netdev_priv(xdp->rxq->dev);
> > > +     hdr_hash =3D (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->=
hdr_len);
> >
> > If the virtio-net-hdr is overrided by the XDP prog, how can this be done
> > correctly and as expected?
> >
>
> Yeah, thanks for bringing up this concern. We are actively working on
> a fix of this issue(possibly with a wrapper structure of xdp_buff).

Are there some places to save the hash before run xdp?

Thanks.


>
> Thanks,
> Liang
>
> > Thanks,
> > Heng
> >
> > > +
> > > +     switch (__le16_to_cpu(hdr_hash->hash_report)) {
> > > +             case VIRTIO_NET_HASH_REPORT_TCPv4:
> > > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV4_TCP;
> > > +                     break;
> > > +             case VIRTIO_NET_HASH_REPORT_UDPv4:
> > > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV4_UDP;
> > > +                     break;
> > > +             case VIRTIO_NET_HASH_REPORT_TCPv6:
> > > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_TCP;
> > > +                     break;
> > > +             case VIRTIO_NET_HASH_REPORT_UDPv6:
> > > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_UDP;
> > > +                     break;
> > > +             case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
> > > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_TCP_EX;
> > > +                     break;
> > > +             case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
> > > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_UDP_EX;
> > > +                     break;
> > > +             case VIRTIO_NET_HASH_REPORT_IPv4:
> > > +                     *rss_type =3D XDP_RSS_TYPE_L3_IPV4;
> > > +                     break;
> > > +             case VIRTIO_NET_HASH_REPORT_IPv6:
> > > +                     *rss_type =3D XDP_RSS_TYPE_L3_IPV6;
> > > +                     break;
> > > +             case VIRTIO_NET_HASH_REPORT_IPv6_EX:
> > > +                     *rss_type =3D XDP_RSS_TYPE_L3_IPV6_EX;
> > > +                     break;
> > > +             case VIRTIO_NET_HASH_REPORT_NONE:
> > > +             default:
> > > +                     *rss_type =3D XDP_RSS_TYPE_NONE;
> > > +     }
> > > +
> > > +     *hash =3D __le32_to_cpu(hdr_hash->hash_value);
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct xdp_metadata_ops virtnet_xdp_metadata_ops =3D {
> > > +     .xmo_rx_hash                    =3D virtnet_xdp_rx_hash,
> > > +};
> > > +
> > >   static int virtnet_probe(struct virtio_device *vdev)
> > >   {
> > >       int i, err =3D -ENOMEM;
> > > @@ -4613,6 +4667,8 @@ static int virtnet_probe(struct virtio_device *=
vdev)
> > >       dev->ethtool_ops =3D &virtnet_ethtool_ops;
> > >       SET_NETDEV_DEV(dev, &vdev->dev);
> > >
> > > +     dev->xdp_metadata_ops =3D &virtnet_xdp_metadata_ops;
> > > +
> > >       /* Do we support "hardware" checksums? */
> > >       if (virtio_has_feature(vdev, VIRTIO_NET_F_CSUM)) {
> > >               /* This opens up the world of extra features. */
> >
>
