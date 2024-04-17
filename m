Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AC046B8
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713322541; cv=none; b=CJgHKcL0VGAw/wo2B7qgFndXuOBjT/cU6Ev3nOrgpzUoHJjizuEnI1vsd1mtqCMj3dK79PK+e/iSvQ8GErwu8wMklbRmPkY/X7FR1e28ysEt7QaFsp6NQjoygfj1eT+xC3Lky+7Olt4VaFRjrVn9PGBquj8JMYaZvcesecUrCgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713322541; c=relaxed/simple;
	bh=IAj14PITpzUBBfd0BdPRImzQrp8Sr8llvz7H0t6Se+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URC/L8IN/5U0mqth4Ha5ykVa+PWF8+MKl1qQX4S515KaET8nuaNyKzfLJANccc8PAfkQstCks6aUedawJJrFUCcgmmn73HFwU/soHQ0fUEmAg69sLzBCYj4qjhvaJYXj5J7Bmr/ntOO/ucGmY+7ZjOaAr7FkBPEu/T6e0lxMrIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIU8Vem1; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIU8Vem1"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso5491497a12.0
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 19:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713322538; x=1713927338; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YU8HGKFVgDu5PmPmQa9rQm9q2w67RmlvbR2fV4Fj4C8=;
        b=lIU8Vem12wqn0SQ9T8dwKfQuU7dPD6kQsexYQbdKl6BJcOzoW2Zkg/nbh0vclXVo4j
         lTtLtD/9vOLbh4qNFp/d/DhoF+W48K6ZnCx4mWfmVgsfQ+BomCZCeQESxLUgEhlaDg/m
         Lj22kIyqs9Am41kK+SsAyGUKBociQC9FES8gd3Wrkze5cQTbnIc5J6GbGAgRJqtBu03n
         jwQozzR56TmjjCEvxOkLoPQqmOf0yLXad8QJPHz0tCgZogpTtrhRPi4X5tm5vYczw/d7
         5P0+0UBcaROsZuMhrqII7dZ4FmZ0BRoHnO9cMPtzBV1D4FVe8xKH6eRg5tLVxet/GaqM
         FgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713322538; x=1713927338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YU8HGKFVgDu5PmPmQa9rQm9q2w67RmlvbR2fV4Fj4C8=;
        b=WwOXq73nd/wy4Kbj+uBkA++nG767zTCR862vNeSuFOEixsXmZK7eWmdDazkZ+H/Euu
         a0ld3R/UiQT/8NIF6v4UCenXZMXWoBj3AA/jukSOr1fRNQKl/Zk7mIXa0GemxH0OJCmI
         tole0FLnt5tu5PvUkJdhPNobSdG1T/bhIZ1SjjG7dwqhj1i8ba8iCeP3h49+sJDAStHs
         Ao8FahT+/dxOPfegmEpZenG9o8NHJqCMaCg6CLW9Gy5vxrsZXDeXoTK6wosrEchuaNdv
         lBIokuUpUUro8SFCGAyJMEgrj5sAjaSNDSICdHFMwgzuJZbQOIq5xiyZlyhSQq6jzNnH
         Bxow==
X-Forwarded-Encrypted: i=1; AJvYcCXR7zBM8+13Anz4yfBd8UVIGhcJ55Y+jj5KXk+5l0fxindUyz2BOfht++aoMFyks46yi8kL1L63BivXxVCajBKkCj9427/ua+XCSYWTSRA=
X-Gm-Message-State: AOJu0YymCAPSms0OTXKXT8Ec0GqY4qS5P282dAinmU4OPzfvjO7657PT
	ban810R71SnCFw6/Xtf3SIuF0IR9mzPAauKD5tAbi175maKNJ99iA9ry/VzEIQjgIF6YnzK//YG
	KNAUYIV+j2cx+85QJ11Mg/MohpRc=
X-Google-Smtp-Source: AGHT+IHnLcuxtZ/uwP32Uiu9SghWa6lLAfLw4GcSxchoRgTp88uEW8gkPF8hzIXEyKeaaD+Mj9NOczupbaoeOSmiIDI=
X-Received: by 2002:a50:c313:0:b0:568:c6a2:f427 with SMTP id
 a19-20020a50c313000000b00568c6a2f427mr9999014edb.27.1713322537712; Tue, 16
 Apr 2024 19:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240416061943.407082-1-liangchen.linux@gmail.com> <CACGkMEuJBdsePgszsM51DZc1GvF0naorHDsMR+SGZ1SiA6jrZQ@mail.gmail.com>
In-Reply-To: <CACGkMEuJBdsePgszsM51DZc1GvF0naorHDsMR+SGZ1SiA6jrZQ@mail.gmail.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Wed, 17 Apr 2024 10:55:19 +0800
Message-ID: <CAKhg4tLsjeJASbdvDumBrbhkddGs4xAV0y5QPv=nhrHcZdSM0g@mail.gmail.com>
Subject: Re: [PATCH net-next v8] virtio_net: Support RX hash XDP hint
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, hengqi@linux.alibaba.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 3:20=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Apr 16, 2024 at 2:20=E2=80=AFPM Liang Chen <liangchen.linux@gmail=
.com> wrote:
> >
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
> >   Changes from v7:
> > - use table lookup for rss hash type
> >   Changes from v6:
> > - fix a coding style issue
> >   Changes from v5:
> > - Preservation of the hash value has been dropped, following the conclu=
sion
> >   from discussions in V3 reviews. The virtio_net driver doesn't
> >   accessing/using the virtio_net_hdr after the XDP program execution, s=
o
> >   nothing tragic should happen. As to the xdp program, if it smashes th=
e
> >   entry in virtio header, it is likely buggy anyways. Additionally, loo=
king
> >   up the Intel IGC driver,  it also does not bother with this particula=
r
> >   aspect.
> > ---
> >  drivers/net/virtio_net.c        | 42 +++++++++++++++++++++++++++++++++
> >  include/uapi/linux/virtio_net.h |  1 +
> >  2 files changed, 43 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index c22d1118a133..1d750009f615 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -4621,6 +4621,47 @@ static void virtnet_set_big_packets(struct virtn=
et_info *vi, const int mtu)
> >         }
> >  }
> >
> > +static enum xdp_rss_hash_type
> > +virtnet_xdp_rss_type[VIRTIO_NET_HASH_REPORT_MAX_TABLE] =3D {
> > +       [VIRTIO_NET_HASH_REPORT_NONE] =3D XDP_RSS_TYPE_NONE,
> > +       [VIRTIO_NET_HASH_REPORT_IPv4] =3D XDP_RSS_TYPE_L3_IPV4,
> > +       [VIRTIO_NET_HASH_REPORT_TCPv4] =3D XDP_RSS_TYPE_L4_IPV4_TCP,
> > +       [VIRTIO_NET_HASH_REPORT_UDPv4] =3D XDP_RSS_TYPE_L4_IPV4_UDP,
> > +       [VIRTIO_NET_HASH_REPORT_IPv6] =3D XDP_RSS_TYPE_L3_IPV6,
> > +       [VIRTIO_NET_HASH_REPORT_TCPv6] =3D XDP_RSS_TYPE_L4_IPV6_TCP,
> > +       [VIRTIO_NET_HASH_REPORT_UDPv6] =3D XDP_RSS_TYPE_L4_IPV6_UDP,
> > +       [VIRTIO_NET_HASH_REPORT_IPv6_EX] =3D XDP_RSS_TYPE_L3_IPV6_EX,
> > +       [VIRTIO_NET_HASH_REPORT_TCPv6_EX] =3D XDP_RSS_TYPE_L4_IPV6_TCP_=
EX,
> > +       [VIRTIO_NET_HASH_REPORT_UDPv6_EX] =3D XDP_RSS_TYPE_L4_IPV6_UDP_=
EX
> > +};
> > +
> > +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> > +                              enum xdp_rss_hash_type *rss_type)
> > +{
> > +       const struct xdp_buff *xdp =3D (void *)_ctx;
> > +       struct virtio_net_hdr_v1_hash *hdr_hash;
> > +       struct virtnet_info *vi;
> > +       u16 hash_report;
> > +
> > +       if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
> > +               return -ENODATA;
> > +
> > +       vi =3D netdev_priv(xdp->rxq->dev);
> > +       hdr_hash =3D (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->=
hdr_len);
> > +       hash_report =3D __le16_to_cpu(hdr_hash->hash_report);
> > +
> > +       if (hash_report >=3D VIRTIO_NET_HASH_REPORT_MAX_TABLE)
> > +               hash_report =3D VIRTIO_NET_HASH_REPORT_NONE;
> > +
> > +       *rss_type =3D virtnet_xdp_rss_type[hash_report];
> > +       *hash =3D __le32_to_cpu(hdr_hash->hash_value);
> > +       return 0;
> > +}
> > +
> > +static const struct xdp_metadata_ops virtnet_xdp_metadata_ops =3D {
> > +       .xmo_rx_hash                    =3D virtnet_xdp_rx_hash,
> > +};
> > +
> >  static int virtnet_probe(struct virtio_device *vdev)
> >  {
> >         int i, err =3D -ENOMEM;
> > @@ -4747,6 +4788,7 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >                                   VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
> >
> >                 dev->hw_features |=3D NETIF_F_RXHASH;
> > +               dev->xdp_metadata_ops =3D &virtnet_xdp_metadata_ops;
> >         }
> >
> >         if (vi->has_rss_hash_report)
> > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virti=
o_net.h
> > index cc65ef0f3c3e..3ee695450096 100644
> > --- a/include/uapi/linux/virtio_net.h
> > +++ b/include/uapi/linux/virtio_net.h
> > @@ -176,6 +176,7 @@ struct virtio_net_hdr_v1_hash {
> >  #define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
> >  #define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
> >  #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
> > +#define VIRTIO_NET_HASH_REPORT_MAX_TABLE      10
>
> This should not be part of uAPI. It may confuse the userspace.
>

Sure. I will just move it to virtio_net.c right above the table
definition. Thanks!

> Others look good.
>
> Thanks
>
> >         __le16 hash_report;
> >         __le16 padding;
> >  };
> > --
> > 2.40.1
> >
>
