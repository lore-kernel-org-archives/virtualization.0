Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0F5168A3
	for <virtualization@lists.linux-foundation.org>; Wed, 31 Jan 2024 02:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706669650; cv=none; b=sDzoZB5mucW1mR09bIdbaDSJkQX8lYiSCLMbOUWrqUfwd2pMqQTfMfCseNigv658ag5bD6fNpRn+5IHXTNlMuOe22BGTlhIiliS3AaHP7ch1f6T+D04DGVrIE4wmWK1pND0r0Ot68C63WpWrgjpgffFQ3Ez5aDzN9Rv1pEOxOpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706669650; c=relaxed/simple;
	bh=DhqZ1Xes7Q5fSjGBvJ9VR5dGs+7Fh29piGCLBO/86+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBb6d/tDGZFjlDxfPz9oQIZuqi+qdaK6bNtY5dp6qaS/yGU+nDkMrTkVkNjhAbnNmMv+HnM38nWXa10guv5Pw9obQ9ptwz5m8QktaPtnsq4aYcitF9AALiEeWerDy3CPbZLA+DHkhrTgPWgVsGYtYnUHHtRBJnJ1Se2yPa7PKWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOU49LR6; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOU49LR6"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF7226138C
	for <virtualization@lists.linux-foundation.org>; Wed, 31 Jan 2024 02:54:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EF7226138C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mOU49LR6
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QFRzQAEVC4fW
	for <virtualization@lists.linux-foundation.org>;
	Wed, 31 Jan 2024 02:54:07 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BF07360B4C
	for <virtualization@lists.linux-foundation.org>; Wed, 31 Jan 2024 02:54:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BF07360B4C
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a35c0ed672cso373948866b.1
        for <virtualization@lists.linux-foundation.org>; Tue, 30 Jan 2024 18:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706669644; x=1707274444; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNtJ0I6nkJv70Hy+MuZAp8tu3eHcGUGD/9KdwK5zAgw=;
        b=mOU49LR6Q+lV9fPWtD6JUZfCGLcXN1FJGKUEB4m7+9zVd84hCTIQZHPgurchIbKq1f
         Tki7DLHfFbQoCEWdvohyKWdJ6cz3rUngm2jStaMsMfMWx7FyKFqsNrKb7duagGKll2xZ
         7PaLHz+QIme5cBCtTnxANJwTkO3kzEBAwyvtHtBXHHUWQmEwd1fYHT13dhuAmoN7bs9H
         0G9ront65jKjLFqOBK6lNnOZ839F9Gxl3+zQMLNRxcqOuzop+n/EQLezlBShkQR1oHYW
         ueO1izb5to4PG7CJua51XAvfhLFAJ6zUwfXh6wWL/YngLUxIRIqHhLm2MQy94RAh6cPH
         xBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706669644; x=1707274444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNtJ0I6nkJv70Hy+MuZAp8tu3eHcGUGD/9KdwK5zAgw=;
        b=Y/nPkhGWx4DtUeYBJ2o+kqxrA8/yyPMlstdyTIVajCYRcJwc3jTT1mmMLmqi0AHxxP
         7Hp8nEcaJtfChCa7AsHl7vF0vzRiy3Vyk2n6kRBh/0qd4nGwOs53I0B4eaJ14WH3DUJn
         MILUNM7cNYwTHRU8+Bs/HabcK+GzKPqv4VfSoGHExWL0WJFSpvAUYU5hPJJWMFcs/1F/
         c4GUAEbcfQy8vCra4RrZCdxqpEVHAjSX/6+0FU4K+YmOIBxt5c8QU4CVQIvJdM6mNjil
         KXEscDolkxBbbCp7fwkK/GiihIfcyuETwh68uqe6+qMtbuV9qWKKd2hYxzHMJAJKJw8e
         nihQ==
X-Gm-Message-State: AOJu0Yxq0sOrnxZZfr6J+TYc0d03PGlXhCYtwfRz56X4f1JimrDCDVwT
	Tc0XAHLF5Zci+xj++9CXe+819RC3qfSSHdrgxNsHcAmiGyAHs7G/eyAOy4KK4HCtx79tR26YBWx
	S27iNlnPqzrcsf5HRnrWJJTQ2H6jtvcISjeU=
X-Google-Smtp-Source: AGHT+IGrEhF7e7B2Lf/SYC7AOe8MwhO00CYHW2lTbWD6KaT8xzJJP3qLKGGCI9k5IoIGf3fsjGdxkRh84Xa++tYFppk=
X-Received: by 2002:a17:906:379a:b0:a35:9616:492b with SMTP id
 n26-20020a170906379a00b00a359616492bmr138820ejc.76.1706669644300; Tue, 30 Jan
 2024 18:54:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240125101912.60346-1-liangchen.linux@gmail.com> <1706615528.9879212-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706615528.9879212-2-xuanzhuo@linux.alibaba.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Wed, 31 Jan 2024 10:53:52 +0800
Message-ID: <CAKhg4tL6O5c_MGbKx5u+V6MGgW+odTnLvwx=sLOv2b5S5Wy9WQ@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_net: Support RX hash XDP hint
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	mst@redhat.com, jasowang@redhat.com, hengqi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:53=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 25 Jan 2024 18:19:12 +0800, Liang Chen <liangchen.linux@gmail.com=
> wrote:
> > The RSS hash report is a feature that's part of the virtio specificatio=
n.
> > Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhos=
t
> > (still a work in progress as per [1]) support this feature. While the
> > capability to obtain the RSS hash has been enabled in the normal path,
> > it's currently missing in the XDP path. Therefore, we are introducing
> > XDP hints through kfuncs to allow XDP programs to access the RSS hash.
> >
> > 1.
> > https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@dayni=
x.com/#r
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > ---
> >  drivers/net/virtio_net.c | 98 +++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 86 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index d7ce4a1011ea..0c845f2223da 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -349,6 +349,12 @@ struct virtio_net_common_hdr {
> >       };
> >  };
> >
> > +struct virtnet_xdp_buff {
> > +     struct xdp_buff xdp;
> > +     u32 hash_value;
> > +     u16 hash_report;
> > +};
> > +
> >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf=
);
> >
> >  static bool is_xdp_frame(void *ptr)
> > @@ -1033,6 +1039,16 @@ static void put_xdp_frags(struct xdp_buff *xdp)
> >       }
> >  }
> >
> > +static void virtnet_xdp_save_rx_hash(struct virtnet_xdp_buff *virtnet_=
xdp,
> > +                                  struct net_device *dev,
> > +                                  struct virtio_net_hdr_v1_hash *hdr_h=
ash)
> > +{
> > +     if (dev->features & NETIF_F_RXHASH) {
> > +             virtnet_xdp->hash_value =3D __le32_to_cpu(hdr_hash->hash_=
value);
> > +             virtnet_xdp->hash_report =3D __le16_to_cpu(hdr_hash->hash=
_report);
>
> Could we put the __leXX_to_cpu to virtnet_xdp_rx_hash?

Sure. Thanks!

>
> Other looks good to me.
>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> Thanks.
>
>
> > +     }
> > +}
> > +
> >  static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_b=
uff *xdp,
> >                              struct net_device *dev,
> >                              unsigned int *xdp_xmit,
> > @@ -1199,9 +1215,10 @@ static struct sk_buff *receive_small_xdp(struct =
net_device *dev,
> >       unsigned int headroom =3D vi->hdr_len + header_offset;
> >       struct virtio_net_hdr_mrg_rxbuf *hdr =3D buf + header_offset;
> >       struct page *page =3D virt_to_head_page(buf);
> > +     struct virtnet_xdp_buff virtnet_xdp;
> >       struct page *xdp_page;
> > +     struct xdp_buff *xdp;
> >       unsigned int buflen;
> > -     struct xdp_buff xdp;
> >       struct sk_buff *skb;
> >       unsigned int metasize =3D 0;
> >       u32 act;
> > @@ -1233,17 +1250,20 @@ static struct sk_buff *receive_small_xdp(struct=
 net_device *dev,
> >               page =3D xdp_page;
> >       }
> >
> > -     xdp_init_buff(&xdp, buflen, &rq->xdp_rxq);
> > -     xdp_prepare_buff(&xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
> > +     xdp =3D &virtnet_xdp.xdp;
> > +     xdp_init_buff(xdp, buflen, &rq->xdp_rxq);
> > +     xdp_prepare_buff(xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
> >                        xdp_headroom, len, true);
> >
> > -     act =3D virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats)=
;
> > +     virtnet_xdp_save_rx_hash(&virtnet_xdp, dev, (void *)hdr);
> > +
> > +     act =3D virtnet_xdp_handler(xdp_prog, xdp, dev, xdp_xmit, stats);
> >
> >       switch (act) {
> >       case XDP_PASS:
> >               /* Recalculate length in case bpf program changed it */
> > -             len =3D xdp.data_end - xdp.data;
> > -             metasize =3D xdp.data - xdp.data_meta;
> > +             len =3D xdp->data_end - xdp->data;
> > +             metasize =3D xdp->data - xdp->data_meta;
> >               break;
> >
> >       case XDP_TX:
> > @@ -1254,7 +1274,7 @@ static struct sk_buff *receive_small_xdp(struct n=
et_device *dev,
> >               goto err_xdp;
> >       }
> >
> > -     skb =3D virtnet_build_skb(buf, buflen, xdp.data - buf, len);
> > +     skb =3D virtnet_build_skb(buf, buflen, xdp->data - buf, len);
> >       if (unlikely(!skb))
> >               goto err;
> >
> > @@ -1591,10 +1611,11 @@ static struct sk_buff *receive_mergeable_xdp(st=
ruct net_device *dev,
> >       int num_buf =3D virtio16_to_cpu(vi->vdev, hdr->num_buffers);
> >       struct page *page =3D virt_to_head_page(buf);
> >       int offset =3D buf - page_address(page);
> > +     struct virtnet_xdp_buff virtnet_xdp;
> >       unsigned int xdp_frags_truesz =3D 0;
> >       struct sk_buff *head_skb;
> >       unsigned int frame_sz;
> > -     struct xdp_buff xdp;
> > +     struct xdp_buff *xdp;
> >       void *data;
> >       u32 act;
> >       int err;
> > @@ -1604,16 +1625,19 @@ static struct sk_buff *receive_mergeable_xdp(st=
ruct net_device *dev,
> >       if (unlikely(!data))
> >               goto err_xdp;
> >
> > -     err =3D virtnet_build_xdp_buff_mrg(dev, vi, rq, &xdp, data, len, =
frame_sz,
> > +     xdp =3D &virtnet_xdp.xdp;
> > +     err =3D virtnet_build_xdp_buff_mrg(dev, vi, rq, xdp, data, len, f=
rame_sz,
> >                                        &num_buf, &xdp_frags_truesz, sta=
ts);
> >       if (unlikely(err))
> >               goto err_xdp;
> >
> > -     act =3D virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats)=
;
> > +     virtnet_xdp_save_rx_hash(&virtnet_xdp, dev, (void *)hdr);
> > +
> > +     act =3D virtnet_xdp_handler(xdp_prog, xdp, dev, xdp_xmit, stats);
> >
> >       switch (act) {
> >       case XDP_PASS:
> > -             head_skb =3D build_skb_from_xdp_buff(dev, vi, &xdp, xdp_f=
rags_truesz);
> > +             head_skb =3D build_skb_from_xdp_buff(dev, vi, xdp, xdp_fr=
ags_truesz);
> >               if (unlikely(!head_skb))
> >                       break;
> >               return head_skb;
> > @@ -1626,7 +1650,7 @@ static struct sk_buff *receive_mergeable_xdp(stru=
ct net_device *dev,
> >               break;
> >       }
> >
> > -     put_xdp_frags(&xdp);
> > +     put_xdp_frags(xdp);
> >
> >  err_xdp:
> >       put_page(page);
> > @@ -4579,6 +4603,55 @@ static void virtnet_set_big_packets(struct virtn=
et_info *vi, const int mtu)
> >       }
> >  }
> >
> > +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> > +                            enum xdp_rss_hash_type *rss_type)
> > +{
> > +     const struct virtnet_xdp_buff *virtnet_xdp =3D (void *)_ctx;
> > +
> > +     if (!(virtnet_xdp->xdp.rxq->dev->features & NETIF_F_RXHASH))
> > +             return -ENODATA;
> > +
> > +     switch (virtnet_xdp->hash_report) {
> > +     case VIRTIO_NET_HASH_REPORT_TCPv4:
> > +             *rss_type =3D XDP_RSS_TYPE_L4_IPV4_TCP;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_UDPv4:
> > +             *rss_type =3D XDP_RSS_TYPE_L4_IPV4_UDP;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_TCPv6:
> > +             *rss_type =3D XDP_RSS_TYPE_L4_IPV6_TCP;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_UDPv6:
> > +             *rss_type =3D XDP_RSS_TYPE_L4_IPV6_UDP;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
> > +             *rss_type =3D XDP_RSS_TYPE_L4_IPV6_TCP_EX;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
> > +             *rss_type =3D XDP_RSS_TYPE_L4_IPV6_UDP_EX;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_IPv4:
> > +             *rss_type =3D XDP_RSS_TYPE_L3_IPV4;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_IPv6:
> > +             *rss_type =3D XDP_RSS_TYPE_L3_IPV6;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_IPv6_EX:
> > +             *rss_type =3D XDP_RSS_TYPE_L3_IPV6_EX;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_NONE:
> > +     default:
> > +             *rss_type =3D XDP_RSS_TYPE_NONE;
> > +     }
> > +
> > +     *hash =3D virtnet_xdp->hash_value;
> > +     return 0;
> > +}
> > +
> > +static const struct xdp_metadata_ops virtnet_xdp_metadata_ops =3D {
> > +     .xmo_rx_hash                    =3D virtnet_xdp_rx_hash,
> > +};
> > +
> >  static int virtnet_probe(struct virtio_device *vdev)
> >  {
> >       int i, err =3D -ENOMEM;
> > @@ -4704,6 +4777,7 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >                                 VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
> >
> >               dev->hw_features |=3D NETIF_F_RXHASH;
> > +             dev->xdp_metadata_ops =3D &virtnet_xdp_metadata_ops;
> >       }
> >
> >       if (vi->has_rss_hash_report)
> > --
> > 2.40.1
> >
