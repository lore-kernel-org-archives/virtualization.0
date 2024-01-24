Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2909817CD
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 02:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706061908; cv=none; b=TU9WLik/pUVLPVsQPrVBT6tpmd1YKnd35jHNsMyucfOkZzaAFjEZtoguZe70wuOMjofi4cVrkvgtpsbi8DEB+HI25ooEKiFDPztI7tINk6UXftRXAbOlG+XZh0pqUWC21iZuzG6UeAc1IYHtJMh4stdCyG/Ax02gvCbxBwoz1GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706061908; c=relaxed/simple;
	bh=r1PJI/1kQSGO0bzUHL8vHtByzkwdMZSWVNQZCiZTVgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcbKGxrP9/sLk+rFt1bvWBtikO8kvGlKNhNdxZ1nxc1F8xvv+RYjxANeOm/V7JNf9LRzJnwQPZ29P7BvXAybinakNBlz7rOXGLWdb1zOv6vyRvszv8REUiBm9Ul6d3aSn/5Pkxd+JFTXlZfdEaxWOVSI7IPzjz4rkWF/xW2hd4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjq9/1C0; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjq9/1C0"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 984C260FA4
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 02:05:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 984C260FA4
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bjq9/1C0
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yK4IVBN9Xf6W
	for <virtualization@lists.linux-foundation.org>;
	Wed, 24 Jan 2024 02:05:06 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ABE6C614D1
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 02:05:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ABE6C614D1
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so4368295a12.1
        for <virtualization@lists.linux-foundation.org>; Tue, 23 Jan 2024 18:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706061903; x=1706666703; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mz18PLpP6eIAAHQsjlKzV2SEMfvKNheWYiqzzwRjC/4=;
        b=bjq9/1C0ghqDZ2WKTwdvbfEQkcsx7BqLBuVLONJ2tRVqjm6HvwpjXhOLvTmyxAjhXg
         ewRMugtrXrjMLH2Y0WZ/+Yl0bcVgp09dapyuRQgt1n6MSgsEzrOE3iTnUJkOM/5qHobM
         zlvVrwknDnlU1REodzpfPMGVHVaeuDRb2F7d3JOpBvfN51PEhJrxl+zV0zqZQpisCCmk
         gpAMg4CG1McqO71GotDP/c1tjWuY/2/TZEG4aqyz9L4YzFtYf9ZMCJY204R0RQYBE1xA
         dYzYiWKDNASzqhQK2V6c9Wol+pvhmztQJJKmM9ACEnp7YQmnLj2UD3e0I8lSUUUYsDDu
         twOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706061903; x=1706666703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mz18PLpP6eIAAHQsjlKzV2SEMfvKNheWYiqzzwRjC/4=;
        b=aCI9PlErQIOdag7/TyNeFtncCem6CSHaKmi5IpDCcUpzBvcEZvB/IfW0ddupvvyUm/
         EERhi9QENYVVEThuIq0lQbsk4VNhKfMd++ghWWmy0/GetlD1l6raq44JW5i6mV4NOmUB
         tB/KZzgrmbNJyrPQr1QvkXuwFiYAijwxQJfM07ue96QZbOCAQY2KYFv44YBWtsQ1xtn8
         V2uZ7hb3pQKoq/ePzbculZWTfCf4OA5teG1a/oVHhC5tyTO3cV+tvAnsiiZITg6X5AUI
         R/gz6c2kmb+mx9UPFzA18HHGDrqot4ydF6HHs8BVTvZ1y5SvLFTb1k2/PB9mp48U/okL
         M1xg==
X-Gm-Message-State: AOJu0Yw0eJ1xOtZ7Yam5/eOCax/5K6NzKVI5OiOqw4G9TeEWiwJqOGwa
	gWz0ob7knb3jUgZ2TckAvyDazvKX1tVcET5rpNDWLHAvVbgj9VYGQeA0vRxkZl31MygplIbel7h
	Stx4t6+GYU3oaAMOiLutkckcW2YI=
X-Google-Smtp-Source: AGHT+IEC/iEHtF88l+XDyVk0+7TQNGzjDlH8ORcmDLo/Kp6VakT3Mpq6n1fu1GQ233zIm6C5vEBrmGtEYeUcZmiRLBw=
X-Received: by 2002:a17:906:c182:b0:a30:d64c:b718 with SMTP id
 g2-20020a170906c18200b00a30d64cb718mr366577ejz.12.1706061903232; Tue, 23 Jan
 2024 18:05:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240122102256.261374-1-liangchen.linux@gmail.com> <4ada64aa-87ec-4340-9892-be52c1f27a97@linux.alibaba.com>
In-Reply-To: <4ada64aa-87ec-4340-9892-be52c1f27a97@linux.alibaba.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Wed, 24 Jan 2024 10:04:51 +0800
Message-ID: <CAKhg4t+ayD-MPK8FwZFURZyX32d8gk26GdytwRiRjJBwBbaR6w@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Support RX hash XDP hint
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: mst@redhat.com, jasowang@redhat.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 7:10=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> Hi Liang Chen,
>
> =E5=9C=A8 2024/1/22 =E4=B8=8B=E5=8D=886:22, Liang Chen =E5=86=99=E9=81=93=
:
> > The RSS hash report is a feature that's part of the virtio specificatio=
n.
> > Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhos=
t
> > (still a work in progress as per [1]) support this feature. While the
> > capability to obtain the RSS hash has been enabled in the normal path,
> > it's currently missing in the XDP path. Therefore, we are introducing X=
DP
> > hints through kfuncs to allow XDP programs to access the RSS hash.
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > ---
> >   drivers/net/virtio_net.c | 56 +++++++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 56 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index d7ce4a1011ea..1463a4709e3c 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -4579,6 +4579,60 @@ static void virtnet_set_big_packets(struct virtn=
et_info *vi, const int mtu)
> >       }
> >   }
> >
> > +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> > +                        enum xdp_rss_hash_type *rss_type)
> > +{
> > +     const struct xdp_buff *xdp =3D (void *)_ctx;
> > +     struct virtio_net_hdr_v1_hash *hdr_hash;
> > +     struct virtnet_info *vi;
> > +
> > +     if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
>
> I think 'vi->has_rss_hash_report' should be used here.
> NETIF_F_RXHASH cannot guarantee that the hash report feature is negotiate=
d,
> and accessing hash_report and hash_value is unsafe at this time.
>

My understanding is that rxhash in dev->features is turned on only if
the corresponding hw feature is set. We will double check on this.

> > +             return -ENODATA;
> > +
> > +     vi =3D netdev_priv(xdp->rxq->dev);
> > +     hdr_hash =3D (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->hd=
r_len);
>
> If the virtio-net-hdr is overrided by the XDP prog, how can this be done
> correctly and as expected?
>

Yeah, thanks for bringing up this concern. We are actively working on
a fix of this issue(possibly with a wrapper structure of xdp_buff).

Thanks,
Liang

> Thanks,
> Heng
>
> > +
> > +     switch (__le16_to_cpu(hdr_hash->hash_report)) {
> > +             case VIRTIO_NET_HASH_REPORT_TCPv4:
> > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV4_TCP;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_UDPv4:
> > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV4_UDP;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_TCPv6:
> > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_TCP;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_UDPv6:
> > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_UDP;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
> > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_TCP_EX;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
> > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_UDP_EX;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_IPv4:
> > +                     *rss_type =3D XDP_RSS_TYPE_L3_IPV4;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_IPv6:
> > +                     *rss_type =3D XDP_RSS_TYPE_L3_IPV6;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_IPv6_EX:
> > +                     *rss_type =3D XDP_RSS_TYPE_L3_IPV6_EX;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_NONE:
> > +             default:
> > +                     *rss_type =3D XDP_RSS_TYPE_NONE;
> > +     }
> > +
> > +     *hash =3D __le32_to_cpu(hdr_hash->hash_value);
> > +     return 0;
> > +}
> > +
> > +static const struct xdp_metadata_ops virtnet_xdp_metadata_ops =3D {
> > +     .xmo_rx_hash                    =3D virtnet_xdp_rx_hash,
> > +};
> > +
> >   static int virtnet_probe(struct virtio_device *vdev)
> >   {
> >       int i, err =3D -ENOMEM;
> > @@ -4613,6 +4667,8 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >       dev->ethtool_ops =3D &virtnet_ethtool_ops;
> >       SET_NETDEV_DEV(dev, &vdev->dev);
> >
> > +     dev->xdp_metadata_ops =3D &virtnet_xdp_metadata_ops;
> > +
> >       /* Do we support "hardware" checksums? */
> >       if (virtio_has_feature(vdev, VIRTIO_NET_F_CSUM)) {
> >               /* This opens up the world of extra features. */
>
