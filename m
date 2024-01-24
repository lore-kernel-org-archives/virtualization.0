Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514217555
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706083504; cv=none; b=OdX/AbAkZ0mql3nYIMuSXW1hGZpC9i6H+Ei6jnrDqNYy9IQOJy/KrL2GuQDoVNDGshUWfZmat0J9q7CeAJ0BFOJfKgBoYIDaIl9cGTgQep7sRF+QyTEK6gQm9RnRU/C1nw138UrHgUu5vwxd2tQnOFYresgiF14sTzc4jg9SJsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706083504; c=relaxed/simple;
	bh=C27R85hLJ8jFsYGbXum67ur9M7OUX1bmDQYugmrCWJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TEAKMqBqB+Sl213ddvQr7hgrPStwVvJ3trl0TkxsREhoPXcXpHJ1Ms1JNhNAdi+N+HRyEJbzluCv0O0XpYMT/4zTBYILSfCGl36zLB6P2Lo+cBHNVqCU68qa1TmoN9uYzl7PLSNMiRzDm1Ku5S71LmA1IhEIrCRI9ZQzdsCBrUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRx8KBJb; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRx8KBJb"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 313E5408C5
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 08:05:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 313E5408C5
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VRx8KBJb
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XnG4Q_Kcc-4Q
	for <virtualization@lists.linux-foundation.org>;
	Wed, 24 Jan 2024 08:05:02 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CB5974034A
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 08:05:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CB5974034A
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40e80046264so65076785e9.0
        for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 00:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706083500; x=1706688300; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xp97wlBUwLOHv0unR+8poeipmd+dQbI6tLKDmEwT28=;
        b=VRx8KBJbTLBfThXhPIbaMVbhNVkLJg4ui68KH7zW3d1gZsfYzkJ2EkLJe92qs9lGvd
         1HTPlMZpACpDp7DKNtFFRLOzWUcPSwW6FjfRR15dwWv6Pz7bfWq+gsaNe9qcngfSsl9W
         woJAVzRvXCeu/Gxye4npXV7GjUzxc9+48iU8DYfDC3l+fiBOZacl0p+cPJcLraMsDYC+
         g3kNhubRdvRVLi7WF98FbtsXq6mqamSA0tfbdcEKK70kjY8bXn3G7RTelX/r7yNefBf7
         pKwt3STXzl9B1sk7au/vCKkw/8CGPe/rEKw6hE3L49VG97O57YnFxRhhtFEDTc4XdJyl
         fOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706083500; x=1706688300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xp97wlBUwLOHv0unR+8poeipmd+dQbI6tLKDmEwT28=;
        b=ALnJrOXuEOXvypFIj1sJe07t3PU6QvEPdJ1dlWiIDJ9OxVCxHzusyhXUdynNd649K0
         U7ncgLQ1WMRlleUx6N4RPYdQO9vbtcdhQoiXOXVKnSfxQTpiiCI1T4kXXipTBzR554A+
         u61MPdLk/e+ZaBAmdkkCVxmnOdKc2S8VO36Qb9EgmmVVYtjbVF7qtC0/bjA4BD9kpK7Z
         3E1mQR093hJNgvzopYoBN3V1LBJSZGj1jbuVDFkcqoczsL1Vf+s+yOtv+11aVpLgW1HW
         Y8Y8V+YKArodW0+fhr42aGi8J8MJTTasWb5gG5riw7Pq3pipCQ9qAJI4O2RGIaKOEZfG
         TQyw==
X-Gm-Message-State: AOJu0YwKTPaPR40dO541keLGOfhzC1cG7DNmDq4TcEF2x8TEgTOrUiwO
	665+/CONifdg94l05JEOpzr83WXlZ7fjlIUgWquFpMsP5lEtTOx5ZSCh9eWsjXp7IUb43VJUY0n
	mdCJQpi8653FDkOgEYB6Nl7kPbxI=
X-Google-Smtp-Source: AGHT+IG4NY9I5TCetk3gUnL4NU+vsphLH3oFDGaUv0e3ZkncOPiy2ll2/Oaz5taVnXjiY0IGUM+OzahfiTGhnc1r8uU=
X-Received: by 2002:a05:600c:2802:b0:40e:6c4e:56b1 with SMTP id
 m2-20020a05600c280200b0040e6c4e56b1mr889440wmb.143.1706083499607; Wed, 24 Jan
 2024 00:04:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240122102256.261374-1-liangchen.linux@gmail.com>
 <4ada64aa-87ec-4340-9892-be52c1f27a97@linux.alibaba.com> <CAKhg4t+ayD-MPK8FwZFURZyX32d8gk26GdytwRiRjJBwBbaR6w@mail.gmail.com>
 <1706076301.4647658-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706076301.4647658-1-xuanzhuo@linux.alibaba.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Wed, 24 Jan 2024 16:04:47 +0800
Message-ID: <CAKhg4tJd7=xpj895RzEQSADfH_eVhDYesCOk_iXz_8RMRWzjHA@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Support RX hash XDP hint
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: mst@redhat.com, jasowang@redhat.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Heng Qi <hengqi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 2:06=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 24 Jan 2024 10:04:51 +0800, Liang Chen <liangchen.linux@gmail.com=
> wrote:
> > On Mon, Jan 22, 2024 at 7:10=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> > >
> > > Hi Liang Chen,
> > >
> > > =E5=9C=A8 2024/1/22 =E4=B8=8B=E5=8D=886:22, Liang Chen =E5=86=99=E9=
=81=93:
> > > > The RSS hash report is a feature that's part of the virtio specific=
ation.
> > > > Currently, virtio backends like qemu, vdpa (mlx5), and potentially =
vhost
> > > > (still a work in progress as per [1]) support this feature. While t=
he
> > > > capability to obtain the RSS hash has been enabled in the normal pa=
th,
> > > > it's currently missing in the XDP path. Therefore, we are introduci=
ng XDP
> > > > hints through kfuncs to allow XDP programs to access the RSS hash.
> > > >
> > > > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > > > ---
> > > >   drivers/net/virtio_net.c | 56 +++++++++++++++++++++++++++++++++++=
+++++
> > > >   1 file changed, 56 insertions(+)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index d7ce4a1011ea..1463a4709e3c 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -4579,6 +4579,60 @@ static void virtnet_set_big_packets(struct v=
irtnet_info *vi, const int mtu)
> > > >       }
> > > >   }
> > > >
> > > > +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *has=
h,
> > > > +                        enum xdp_rss_hash_type *rss_type)
> > > > +{
> > > > +     const struct xdp_buff *xdp =3D (void *)_ctx;
> > > > +     struct virtio_net_hdr_v1_hash *hdr_hash;
> > > > +     struct virtnet_info *vi;
> > > > +
> > > > +     if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
> > >
> > > I think 'vi->has_rss_hash_report' should be used here.
> > > NETIF_F_RXHASH cannot guarantee that the hash report feature is negot=
iated,
> > > and accessing hash_report and hash_value is unsafe at this time.
> > >
> >
> > My understanding is that rxhash in dev->features is turned on only if
> > the corresponding hw feature is set. We will double check on this.
> >
> > > > +             return -ENODATA;
> > > > +
> > > > +     vi =3D netdev_priv(xdp->rxq->dev);
> > > > +     hdr_hash =3D (struct virtio_net_hdr_v1_hash *)(xdp->data - vi=
->hdr_len);
> > >
> > > If the virtio-net-hdr is overrided by the XDP prog, how can this be d=
one
> > > correctly and as expected?
> > >
> >
> > Yeah, thanks for bringing up this concern. We are actively working on
> > a fix of this issue(possibly with a wrapper structure of xdp_buff).
>
> Are there some places to save the hash before run xdp?
>

Yeah, it will be saved in a wrapper structure. Thanks.

> Thanks.
>
>
> >
> > Thanks,
> > Liang
> >
> > > Thanks,
> > > Heng
> > >
> > > > +
> > > > +     switch (__le16_to_cpu(hdr_hash->hash_report)) {
> > > > +             case VIRTIO_NET_HASH_REPORT_TCPv4:
> > > > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV4_TCP;
> > > > +                     break;
> > > > +             case VIRTIO_NET_HASH_REPORT_UDPv4:
> > > > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV4_UDP;
> > > > +                     break;
> > > > +             case VIRTIO_NET_HASH_REPORT_TCPv6:
> > > > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_TCP;
> > > > +                     break;
> > > > +             case VIRTIO_NET_HASH_REPORT_UDPv6:
> > > > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_UDP;
> > > > +                     break;
> > > > +             case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
> > > > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_TCP_EX;
> > > > +                     break;
> > > > +             case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
> > > > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_UDP_EX;
> > > > +                     break;
> > > > +             case VIRTIO_NET_HASH_REPORT_IPv4:
> > > > +                     *rss_type =3D XDP_RSS_TYPE_L3_IPV4;
> > > > +                     break;
> > > > +             case VIRTIO_NET_HASH_REPORT_IPv6:
> > > > +                     *rss_type =3D XDP_RSS_TYPE_L3_IPV6;
> > > > +                     break;
> > > > +             case VIRTIO_NET_HASH_REPORT_IPv6_EX:
> > > > +                     *rss_type =3D XDP_RSS_TYPE_L3_IPV6_EX;
> > > > +                     break;
> > > > +             case VIRTIO_NET_HASH_REPORT_NONE:
> > > > +             default:
> > > > +                     *rss_type =3D XDP_RSS_TYPE_NONE;
> > > > +     }
> > > > +
> > > > +     *hash =3D __le32_to_cpu(hdr_hash->hash_value);
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static const struct xdp_metadata_ops virtnet_xdp_metadata_ops =3D =
{
> > > > +     .xmo_rx_hash                    =3D virtnet_xdp_rx_hash,
> > > > +};
> > > > +
> > > >   static int virtnet_probe(struct virtio_device *vdev)
> > > >   {
> > > >       int i, err =3D -ENOMEM;
> > > > @@ -4613,6 +4667,8 @@ static int virtnet_probe(struct virtio_device=
 *vdev)
> > > >       dev->ethtool_ops =3D &virtnet_ethtool_ops;
> > > >       SET_NETDEV_DEV(dev, &vdev->dev);
> > > >
> > > > +     dev->xdp_metadata_ops =3D &virtnet_xdp_metadata_ops;
> > > > +
> > > >       /* Do we support "hardware" checksums? */
> > > >       if (virtio_has_feature(vdev, VIRTIO_NET_F_CSUM)) {
> > > >               /* This opens up the world of extra features. */
> > >
> >
