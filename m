Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CF51CD1F
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177878; cv=none; b=EANqVbq9H+gsWLFnGRNuzzmoD42mnZ5U9QMzPtvweSC5tIzeMC5qm92Aq709JtSgn5Y0OtDoiTAVTZlFvD9OX8p1B39HkdefYWFn2p13iXs9+oQ7Eog9FNLQ3IjmcZQujXY3BbNlBp9xRALhsKxJ0bthLiWjfH6eQcbzBpiTBZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177878; c=relaxed/simple;
	bh=YwbxBvQAdM1n1pMjvJXsYu4MRXdtRPQRqLlRL9XNhrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OpCQxOi7Ee0KrdGcM8RzdkB/j79SgABzWFuoB92YxMptfbSIfg2tGYizdNHNSkAYzVpcFhwoimUJ3nRsZuqaiBW90xNmO8uo1TaT23uZbilCnd/lWEMUkZKGa4VeqQN7IicGv3swzChsx78GYh4Ci1ATJdeM0BtPu/zL8Ov/QRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LI4s5mns; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LI4s5mns"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9466142EC6
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 10:17:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9466142EC6
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LI4s5mns
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UcziiphT2mvR
	for <virtualization@lists.linux-foundation.org>;
	Thu, 25 Jan 2024 10:17:55 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2D4994036E
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 10:17:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2D4994036E
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-55ad2a47b7aso6043149a12.3
        for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 02:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706177873; x=1706782673; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1fVAqra08WznhwU67oxxWkjzb5vj9WVlzKpwxsbfyo=;
        b=LI4s5mns9xdJS8322TusXfRqDUV1iRGoLM3LpRaQ14YWpkcqXGVwh5BcGSL6/PMBlb
         s9+8mzoryjo0vKtJwnz5jJKlabbikw/dfm5lJx4b4pzaF1ez/OSo+Io6gX8juJbLHDfb
         5ypZ6UEXDVZvgczxpIx8xOwpUsxH72pje5+/UWTQbIitP/J1IUtb+StY43NvilkmDKCa
         AkZobhwQ1TBfNk/CctZeKUjNaJWulQhAT9YhBigXz+3WSQfSs4vvstco15cLOV3o/oj3
         BxYG8db6I8RyGAgd7rPaSiwRa2JiXfO4Q4S6rxkUStuFJ0qxTuW/6fwGPVto4F4LeFXf
         63ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706177873; x=1706782673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1fVAqra08WznhwU67oxxWkjzb5vj9WVlzKpwxsbfyo=;
        b=l4OVmsKFATgAbOxQfALb5lDJ/cOvQWA1WFNiPK0JNvxtJAqHS7oMheC9bHMoF+0IuK
         R1RJ2hEBT/DY2p91kXil0lZYuV3gRILBmtUy+ieOqENfjPyYD5xf0MXKOaPdxtiy/jzG
         RCBKuO0t7WXSDSdvN20KaL3Q7PXacEkDh6Pir8oXjlo3D1lLEwRBtsCzk3SBM3SnG5i3
         9wQvEHt9ACr9gr0TLScjvUx4AHSTOerdKK+ghbBa7kYyKjOKx67lf54OFuVjKcZjSP/z
         P36ECmO6zwxM9jE8j2rJvZm949YIZ2HklIG9buCkipqwSnpAZs/m78bWjbCtmA8nbMdv
         /Cxw==
X-Gm-Message-State: AOJu0YxcIOzsGK4D5fARaGtWBV3W17rTB17+5pPfbr35p30QLGPVgqqB
	MGWqMhtG6YFQdT+n95kpC4OlfaUqlkvjKd1WHOlexBr+gP24qcJYfwhsFFLyLImSpU8Dihqdqwb
	tzlX9fX7jx0fDq0KhReLHak+Z/yc=
X-Google-Smtp-Source: AGHT+IGYwzyl0uZoxuhyMGqcxiUenKW3nFpf837mLbgvKORbrkcmh6vBU5OXBNB3pGSXJsBsNpW2s8WAEJZ06/hVYl4=
X-Received: by 2002:a17:906:54c8:b0:a31:1ab7:621d with SMTP id
 c8-20020a17090654c800b00a311ab7621dmr227283ejp.208.1706177872652; Thu, 25 Jan
 2024 02:17:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240124085721.54442-1-liangchen.linux@gmail.com>
 <20240124085721.54442-2-liangchen.linux@gmail.com> <1706087207.116824-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706087207.116824-1-xuanzhuo@linux.alibaba.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Thu, 25 Jan 2024 18:17:40 +0800
Message-ID: <CAKhg4tKGuA=ZC1agLGsqzNSKnzWvVewZj2gTEHFmX7HAK1Xfwg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] virtio_net: Preserve virtio header before XDP
 program execution
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	mst@redhat.com, jasowang@redhat.com, hengqi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 5:08=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 24 Jan 2024 16:57:19 +0800, Liang Chen <liangchen.linux@gmail.com=
> wrote:
> > The xdp program may overwrite the inline virtio header. To ensure the
> > integrity of the virtio header, it is saved in a data structure that
> > wraps both the xdp_buff and the header before running the xdp program.
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > ---
> >  drivers/net/virtio_net.c | 43 +++++++++++++++++++++++++++++-----------
> >  1 file changed, 31 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index d7ce4a1011ea..b56828804e5f 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -349,6 +349,11 @@ struct virtio_net_common_hdr {
> >       };
> >  };
> >
> > +struct virtnet_xdp_buff {
> > +     struct xdp_buff xdp;
> > +     struct virtio_net_common_hdr hdr;
>
> Not all items of the hdr are useful, we can just save the useful items.
>

Sure. Will do in v3. Thanks.

> > +};
> > +
> >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf=
);
> >
> >  static bool is_xdp_frame(void *ptr)
> > @@ -1199,9 +1204,10 @@ static struct sk_buff *receive_small_xdp(struct =
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
> > @@ -1233,17 +1239,23 @@ static struct sk_buff *receive_small_xdp(struct=
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
> > +     /* Copy out the virtio header, as it may be overwritten by the
> > +      * xdp program.
> > +      */
> > +     memcpy(&virtnet_xdp.hdr, hdr, vi->hdr_len);
>
> Can we put this into virtnet_xdp_handler?
>
> And just do that when the hash is negotiated.
>
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
> > @@ -1254,7 +1266,7 @@ static struct sk_buff *receive_small_xdp(struct n=
et_device *dev,
> >               goto err_xdp;
> >       }
> >
> > -     skb =3D virtnet_build_skb(buf, buflen, xdp.data - buf, len);
> > +     skb =3D virtnet_build_skb(buf, buflen, xdp->data - buf, len);
> >       if (unlikely(!skb))
> >               goto err;
> >
> > @@ -1591,10 +1603,11 @@ static struct sk_buff *receive_mergeable_xdp(st=
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
> > @@ -1604,16 +1617,22 @@ static struct sk_buff *receive_mergeable_xdp(st=
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
> > +     /* Copy out the virtio header, as it may be overwritten by the
> > +      * xdp program.
> > +      */
> > +     memcpy(&virtnet_xdp.hdr, hdr, vi->hdr_len);
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
> > @@ -1626,7 +1645,7 @@ static struct sk_buff *receive_mergeable_xdp(stru=
ct net_device *dev,
> >               break;
> >       }
> >
> > -     put_xdp_frags(&xdp);
> > +     put_xdp_frags(xdp);
> >
> >  err_xdp:
> >       put_page(page);
> > --
> > 2.40.1
> >
