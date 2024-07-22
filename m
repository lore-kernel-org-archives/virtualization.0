Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31F51607B0
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721635043; cv=none; b=fjU9ER0M9CbK45YYgVUSmRA8edRpTpiAWiSrrnGtU7bhTJmQdhNupzVh+iCtXbyH5HqIBWYWbnBAUIvdgwUqSaznQhPiUNHi62Cew2npFP1lFPhsi+CvoejtwSfcUE13rX2qb7Qbn3BE1JzAUD2u4GF0mO1ON9/mVHC6PQmciCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721635043; c=relaxed/simple;
	bh=HWNPQ/1vUrq7iKlpWAUp1cUMrSt4KvhLV953piOX8g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzlgsizDO/6UK6CFm3n/fWwUswm5PXUHka5Xt+j8VJcfc0EM1opNjwmfC5E8JJ3Ag5xWNPh9BOXUtG5WEB/GVnNewRHzkgqNu8hCkRfKwLmDNm7ylDFjvrLT+3+Hyxt2mHHLYouQ7OAqNMe0XYiBwhMMlmzpUVVHPKdD68XLb2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gjg/kFvT; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjg/kFvT"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 33AC14033F
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 07:57:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gCElrKbuOtmj for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Jul 2024 07:57:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2F91A4036E
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F91A4036E
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gjg/kFvT
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2F91A4036E
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 07:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721635038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQEopZwHga4C7qzVJPruzVlevn1Kn/ATvarPGUPiBhY=;
	b=gjg/kFvTrkQVmSalBfgCMjsw1Z628iwt+5gl/V9lMmyMu2L68mNFYKEvDcvg3MYw//be9l
	svCu7LWRcMGnvVd5H56ipgVwnUvX2tffBNwW8FS5c8t9E7xAU+U4EQghM9EegfzTbikCoo
	731QFpOfj40P1CVxdN4Kw1LvwPENiSI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-TtbKkydpO-qBpRGWkr9ClQ-1; Mon, 22 Jul 2024 03:57:16 -0400
X-MC-Unique: TtbKkydpO-qBpRGWkr9ClQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ef23d3650fso11894021fa.2
        for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 00:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721635035; x=1722239835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQEopZwHga4C7qzVJPruzVlevn1Kn/ATvarPGUPiBhY=;
        b=I6hboS3/yrsGZsc4xE+9rfldbARwdYsGykGLCZjASf2GWHn3LF1YMtX0NIcGvtzq13
         49kDq6PaIWGlVhwHLZO/LF7W96bh26mc3AwbR1ei6WeJVsWs0Zu1DX8cxoABDJt37B9W
         4cxPOmI9ZBObNZswiwuFMBuFjedYsUSTtmkumqrGUVdAZKJQv/QDMSA2iyZMXO6VhiVO
         STNBIEqZ08J/zWVYufZKbEILYfxCpIQ2L7g7jyjDaKVJaLyvc/pl3nKxYK4BgCoC2cEo
         g2Jx6p5gOvZPOgGP0Mrcv/9xmWmemgR3Dfrj7TayHb6mT5u0LVQusWsjCsSscuBfhAHp
         GbVg==
X-Forwarded-Encrypted: i=1; AJvYcCVuwJYIzBjYMYhemUV4mKIdiRmPOxDKuYrSzhpIIIGb8k+lH3MQhtDnLgZWUB9Ksbin+fMH0tuSyBOC//B4MkjlyWJNfdwEtgoNjK81cF/TzEzc81JqFrbY3A==
X-Gm-Message-State: AOJu0YwiXi+pVTb4VF49R0rqeJVIJHVB7zZw2+7XdkR3B1ycts+XUBio
	Ytz3+LpF7R6bkGX7g7QZhe/1rJhwpggB5yJmrzd0btLxfKdGwOSPvJdcXwiTr38GpMACGjE2Dqk
	23xJxpzKH7Zxaz6DX2PmNU6jcIDzGqMUPJSpwFR/L15nkzQTxknIyGkD5uZ89bhG+pN/Rh0SFIq
	S4JSbGFQUpS952s/RBybrQBNa5b/UCD+pTeG3Gm05iDQUVbzhMBKZ+IA==
X-Received: by 2002:a05:651c:50d:b0:2ef:17ee:62b0 with SMTP id 38308e7fff4ca-2ef17ee6747mr44078071fa.2.1721635035151;
        Mon, 22 Jul 2024 00:57:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYfWrHNz6DUflgtw/ZcTjXibd8jwa6+RV9ykMQ9YOOIBFKj5ChXg/RudR/hIBIlgmdHIluX8YxfscwNFeCP2U=
X-Received: by 2002:a05:651c:50d:b0:2ef:17ee:62b0 with SMTP id
 38308e7fff4ca-2ef17ee6747mr44077821fa.2.1721635034786; Mon, 22 Jul 2024
 00:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240722010625.1016854-1-lulu@redhat.com> <20240722010625.1016854-3-lulu@redhat.com>
 <CACGkMEtq=2yO=4te+qQxwSzi4G-4E_kdq=tCQq_N94Pk8Ro3Zw@mail.gmail.com>
In-Reply-To: <CACGkMEtq=2yO=4te+qQxwSzi4G-4E_kdq=tCQq_N94Pk8Ro3Zw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 22 Jul 2024 15:56:38 +0800
Message-ID: <CACLfguUaDo3seJZT_yQNp_fa4bELHwwAb8OTbXGwBLw2fGdj+w@mail.gmail.com>
Subject: Re: [PATH v4 2/3] vdpa_sim_net: Add the support of set mac address
To: Jason Wang <jasowang@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jul 2024 at 15:48, Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add the function to support setting the MAC address.
> > For vdpa_sim_net, the driver will write the MAC address
> > to the config space, and other devices can implement
> > their own functions to support this.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 22 +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_s=
im/vdpa_sim_net.c
> > index cfe962911804..936e33e5021a 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > @@ -414,6 +414,25 @@ static void vdpasim_net_get_config(struct vdpasim =
*vdpasim, void *config)
> >         net_config->status =3D cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_L=
INK_UP);
> >  }
> >
> > +static int vdpasim_net_set_attr(struct vdpa_mgmt_dev *mdev,
> > +                               struct vdpa_device *dev,
> > +                               const struct vdpa_dev_set_config *confi=
g)
> > +{
> > +       struct vdpasim *vdpasim =3D container_of(dev, struct vdpasim, v=
dpa);
> > +       struct virtio_net_config *vio_config =3D vdpasim->config;
> > +
> > +       mutex_lock(&vdpasim->mutex);
> > +
> > +       if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +               memcpy(vio_config->mac, config->net.mac, ETH_ALEN);
> > +               mutex_unlock(&vdpasim->mutex);
> > +               return 0;
> > +       }
> > +
> > +       mutex_unlock(&vdpasim->mutex);
>
> Do we need to protect:
>
>         case VIRTIO_NET_CTRL_MAC_ADDR_SET:
> read =3D vringh_iov_pull_iotlb(&cvq->vring, &cvq->in_iov,
>                                              vio_config->mac, ETH_ALEN);
>                 if (read =3D=3D ETH_ALEN)
>                         status =3D VIRTIO_NET_OK;
>                 break;
>
> As both are modifying vio_config?
>
> Thanks
>
i have added a lock for this; CVQ also needs to take this lock to
change the MAC address.I thinks maybe this can protect?
Do you mean I need to compare the mac address from the vdpa_tool and
mac address in vio_config?
this vdpa tool should not be used after the guest load, if this is
different this is also acceptable
thanks
Cindy

> > +       return -EINVAL;
> > +}
> > +
> >  static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
> >                                      const struct vdpa_dev_set_config *=
config)
> >  {
> > @@ -510,7 +529,8 @@ static void vdpasim_net_dev_del(struct vdpa_mgmt_de=
v *mdev,
> >
> >  static const struct vdpa_mgmtdev_ops vdpasim_net_mgmtdev_ops =3D {
> >         .dev_add =3D vdpasim_net_dev_add,
> > -       .dev_del =3D vdpasim_net_dev_del
> > +       .dev_del =3D vdpasim_net_dev_del,
> > +       .dev_set_attr =3D vdpasim_net_set_attr
> >  };
> >
> >  static struct virtio_device_id id_table[] =3D {
> > --
> > 2.45.0
> >
>

