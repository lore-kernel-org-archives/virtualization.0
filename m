Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89719F4FB
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jul 2024 02:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787203; cv=none; b=XRAmkOCI/HGDgMRect8e//HXxTNLS84ZzUxLidCRb243xIxwS2H2WRl19hFQNSbtR34ZVIGY2wGyBOQs5ti2ThV7dKXZZgXvkspr2p+BvtEWkEfiVzsd75eW9H6Wv3G/wguusVeugmeXCanCWvncponkzWupmQaX8l9rcQmgejY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787203; c=relaxed/simple;
	bh=aY2W229IPrwJpsVdE9grFLsD722tHQKjq+jC7vW2vuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThHJcUNdnYAGNV9VNGV37HMtu5j+3uFKY0ZaxRF9QMfKBJTcR1ro97H6raKzUv209vJChqhSBa3gr9KKD9dx7VshH6a4QyNxOj3tN39G+ij7qKcCdqKdmp5x0vbPkOo/zUk/7muxUeUmYDcjNtl10vfHH8lFVe+CJay+xDwUXwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LlbGewht; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LlbGewht"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 08DB24045C
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jul 2024 02:13:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M3qtdJ3s4aKK for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Jul 2024 02:13:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DD2FE4023F
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD2FE4023F
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LlbGewht
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DD2FE4023F
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jul 2024 02:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721787199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KpQmKrcQvwUzPm1WYMAhk6x806GQpIo0dxtm+FS0LQ4=;
	b=LlbGewhttwGnaFx2CyHJZC6EqumasoFEGdkVDZOlyhBAcrEnZ4TzCDj3VUBdUz55hZ9+X1
	4rRGD8uxdrB6hw3YTMKUUQFChncHPkyVgnUfnwTWpWVx2UR8tKMwcI0vrEuUDGoBA7dSZM
	ZpIRAkm1K34t/ZfzyG+L9KWncgOaGHg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-skWQBOThPZK0aZrPQU7P-A-1; Tue, 23 Jul 2024 22:13:18 -0400
X-MC-Unique: skWQBOThPZK0aZrPQU7P-A-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2f01bd7ad5eso20014261fa.2
        for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 19:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721787196; x=1722391996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpQmKrcQvwUzPm1WYMAhk6x806GQpIo0dxtm+FS0LQ4=;
        b=DYIOi9Yy3O/JRaK4uW5z2nred8QRJPamo+c8Ax95CYDSy7K74y8+eWaJU6unT3xyqN
         zmWRYDuAxVyLmBFZGRFlrCAwcERfFiSCszl9llshZSiFlastM3P0tldD7VASWpbysgwm
         ZrWsTpJGmUm0G3ypytodhBw39H9Zqenk8kbKA4eov4rWS/Y3vPon43qwNCtNV/n2j6rw
         tzvjqVksBp4Q4RrtXof7z3KMHDCJOUP7Hl8Z/ZlIMSuK+PEVtj5rnAtFaLIVhQ1y//aw
         RCw+n8/mDa+ygncJhP59BBWCGzef2pQ9ZFM8TR6r8yud4tZcn33DxPMyMwfYNXkZe64j
         IFJA==
X-Forwarded-Encrypted: i=1; AJvYcCVDIwh+nWonvD3goAGlXxI2JjB2OFLtOcwac276mswfh7PRJihWvJkGRA+wGM30o9NijRw+tR8m2oCZyAOOfCLOOzh7ZAnijo25eUNvjS8HCnEPkiWPXAKgZA==
X-Gm-Message-State: AOJu0YwSpB5XSNVVQwjGc31kU2CLfz44PIDGScmKQm2HQbQH/xR0W6pj
	WcmU07Gl6XGcsHDVSr5nCoAvib8Cs2pYiKET7rxvM9d8qTRynEptVpGoJWRan+GCa1I+KhKhNTK
	M7WMC/fPiI1wgeWkF+0b8C8HkAytEcL+2MPBoTRFD26BCBGklod7N1LRA8F5YM5XwM0zm3/HCXA
	mVoWPQZmbBh9O3bppYad13KjYLgpppdTcMGwz8fxkYuhHVTwqRCqilVQ==
X-Received: by 2002:a2e:7012:0:b0:2ef:284e:1d07 with SMTP id 38308e7fff4ca-2ef284e20edmr67226861fa.13.1721787196496;
        Tue, 23 Jul 2024 19:13:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfe+PSFOuw1GOx0ba6wih32b5Q24TWF2YXgMjSQkS2m3HAbcXqAiQFID2J6XbwaqHY0X71rjwNpHYBoZFbDPg=
X-Received: by 2002:a2e:7012:0:b0:2ef:284e:1d07 with SMTP id
 38308e7fff4ca-2ef284e20edmr67226751fa.13.1721787196155; Tue, 23 Jul 2024
 19:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240723054047.1059994-1-lulu@redhat.com> <20240723054047.1059994-4-lulu@redhat.com>
 <d8031e518cf47c57c31b903cb9613692bbff7d0d.camel@nvidia.com> <20240723072712-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240723072712-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 24 Jul 2024 10:12:39 +0800
Message-ID: <CACLfguV53JA9Lk_sTr+ug_x+JDxTr3S3rOcjVQVDy7tkL_B--A@mail.gmail.com>
Subject: Re: [PATH v5 3/3] vdpa/mlx5: Add the support of set mac address
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	"sgarzare@redhat.com" <sgarzare@redhat.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jul 2024 at 19:29, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jul 23, 2024 at 07:49:44AM +0000, Dragos Tatulea wrote:
> > On Tue, 2024-07-23 at 13:39 +0800, Cindy Lu wrote:
> > > Add the function to support setting the MAC address.
> > > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > > to set the mac address
> > >
> > > Tested in ConnectX-6 Dx device
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 28 ++++++++++++++++++++++++++++
> > >  1 file changed, 28 insertions(+)
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/ne=
t/mlx5_vnet.c
> > > index ecfc16151d61..7fce952d650f 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -3785,10 +3785,38 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgm=
t_dev *v_mdev, struct vdpa_device *
> > >     destroy_workqueue(wq);
> > >     mgtdev->ndev =3D NULL;
> > >  }
> > > +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
> > > +                         struct vdpa_device *dev,
> > > +                         const struct vdpa_dev_set_config *add_confi=
g)
> > > +{
> > > +   struct virtio_net_config *config;
> > > +   struct mlx5_core_dev *pfmdev;
> > > +   struct mlx5_vdpa_dev *mvdev;
> > > +   struct mlx5_vdpa_net *ndev;
> > > +   struct mlx5_core_dev *mdev;
> > > +   int err =3D -EINVAL;
> > > +
> > > +   mvdev =3D to_mvdev(dev);
> > > +   ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > > +   mdev =3D mvdev->mdev;
> > > +   config =3D &ndev->config;
> > > +
> > > +   down_write(&ndev->reslock);
> > > +   if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > > +           pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> > > +           err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > > +           if (0 =3D=3D err)
> > if (!err) would be nicer. Not a deal breaker though.
>
>         yes, no yodda style please. It, I can not stand.
>
sure=EF=BC=8C Will fix this
Thanks
cindy
>
> > Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> >
> > > +                   memcpy(config->mac, add_config->net.mac, ETH_ALEN=
);
> > > +   }
> > > +
> > > +   up_write(&ndev->reslock);
> > > +   return err;
> > > +}
> > >
> > >  static const struct vdpa_mgmtdev_ops mdev_ops =3D {
> > >     .dev_add =3D mlx5_vdpa_dev_add,
> > >     .dev_del =3D mlx5_vdpa_dev_del,
> > > +   .dev_set_attr =3D mlx5_vdpa_set_attr,
> > >  };
> > >
> > >  static struct virtio_device_id id_table[] =3D {
> >
>

