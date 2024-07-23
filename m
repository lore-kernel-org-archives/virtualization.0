Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F61139597
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 01:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721698130; cv=none; b=KnoOqWOJFo7JCM19B6NEtgLUQESerLIYKTiMjxEdq4/Bnks+eeWI6tKfkS5s1EBIYpNymfywETtvAhmO3A0OYS7LEuSgObltaekgK38Bm9XIXlNeeAas/6s7nMK6jJPvPXlaoHMqFqR4vYQXPG1YGpXwsNjyaQLF6ZF+DkDwGNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721698130; c=relaxed/simple;
	bh=hmJv9NIRC+0TWcZWU6vysfnV1T9npK2Yd4rCz4I6KqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LuV+94ZlrPIiw+kmKULxyxdq/NOlbj8MuehXcCzwJWezovnI5xVVcpaWQCTSYWS1v1XcxBArSvGQjqzz9+P8IEWr7owAw6CQGCbUkxcKaOmoZMKm/Ro+DXwZyQJdu+iURdXdttPq66Ef8cGBCpQXXyv2JLUWktE4Spi/jgsluhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fsGe2Ymp; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsGe2Ymp"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27D8A606EE
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 01:28:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a2cVmrqpn5RQ for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Jul 2024 01:28:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4B05460597
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B05460597
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fsGe2Ymp
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4B05460597
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 01:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721698126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2dPIatpVSHzVHBHYiz7SKefAqNEyf3yo6kuC1ZYdgc=;
	b=fsGe2YmpTjbbsDRHcW1iEfnJxHtROPSglJW8pSi/Lx+BEDpxBBzsIl8QWiO78D0eoXVs0W
	CuK25FiZC7OVFaugx4jWOn4JNMo5IP/yV8PNuVYyxfwxyVpeIwsMtPHM0/XJo/FUtIq/wN
	xGhllOqfVdw4gY6+40qvDH2sObGq/gc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-zeGg0JXoN-ypMYFzbPFmYQ-1; Mon, 22 Jul 2024 21:28:42 -0400
X-MC-Unique: zeGg0JXoN-ypMYFzbPFmYQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c96e73c886so3945272a91.3
        for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 18:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721698121; x=1722302921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2dPIatpVSHzVHBHYiz7SKefAqNEyf3yo6kuC1ZYdgc=;
        b=h23Vj+JYryybr49fYT5hPVIw+HkgmdLyvPs+VO9R36B82mDLsZmwrB8L6WWC9wL9h7
         rKFihlY6zG/rUKLK9X32a/gprXa6ytwNbNQp8t3Pj20r5FhvFBeD1Kg1HIUr5rXwoDpQ
         PosDi+QwDotQhoxvqAWSXldm1KjCzoBaHeO8AYO1zpu8lkG9uQ5fF8fLMFvcxG30LioT
         t+JG5w3tYpQmp+vn/H5G3/B3FQ5/MBtl09GP9/ts/4LqK8hbadcrEr8BOFAU5Vz3IUOp
         mVWTCbuPYa/WmnFHV2m5fkEEkLuvumQRKIKMUfbmm4gK/lQLLL/9RbaI9LQGb9jZhoW3
         E2nw==
X-Forwarded-Encrypted: i=1; AJvYcCVUpC0ZbuL3cutg0JdKia5XyUt8Ulf0jOfdygmcopuFDvCytly8EhXhuo8rE2/KF39JLmp4K0UdSSEESlFju4H1eEtZUmeAUr20dLZe/mfFKvx55FGrrv4jyg==
X-Gm-Message-State: AOJu0YyW920OxJ7mndICJ50mDydBwfui+p6oc0NFofhaqCzaUP163pm5
	oiGBnL1uRCGv9etcsTrhlI+WcsFwUzSsnWD5h9p67Vjf6RZ742v//8VQnzmSdZkU//BmTW1w42F
	KqDZpNN+KwwBS9iY6sJnnhBIAyfvlyPmFOiF4MzXajwFpOA/tAEh51jWQI2eewZoPU9i3ZE1URH
	qg//AtqqHttYizGl1F5xSjGnCGy4TANY70+RaMctR9YhisO2ZMdDCqTQ==
X-Received: by 2002:a17:90a:66cd:b0:2ca:a318:2729 with SMTP id 98e67ed59e1d1-2cd2751ca3cmr4555708a91.37.1721698121453;
        Mon, 22 Jul 2024 18:28:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm9l9yopQ8gKbnepufKwmhhZJViwYbJ+IaU9VHuP40/XlFCamg/GuB/7IU2kaDDEGgde0TY0jSAYiL6312qIo=
X-Received: by 2002:a17:90a:66cd:b0:2ca:a318:2729 with SMTP id
 98e67ed59e1d1-2cd2751ca3cmr4555689a91.37.1721698120961; Mon, 22 Jul 2024
 18:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240722010625.1016854-1-lulu@redhat.com> <20240722010625.1016854-4-lulu@redhat.com>
 <CACGkMEvXk8_sXRtugePAMv8PM0qGU-su0eFUsFZ=-=_TjcGZNg@mail.gmail.com>
 <7a4d99e0f16cbe91000c3c780334a4c866904182.camel@nvidia.com>
 <CACLfguUR_hdJGDcjnmYY=qOXFiSnsBsXD5evTDZQi=K0RM4gZQ@mail.gmail.com> <CACLfguUWCY6MJkv+GuJ0W0t0Q0iX3fna+EjWxV5E=au9Oa5-aw@mail.gmail.com>
In-Reply-To: <CACLfguUWCY6MJkv+GuJ0W0t0Q0iX3fna+EjWxV5E=au9Oa5-aw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Jul 2024 09:28:28 +0800
Message-ID: <CACGkMEsapSx4Hk+2PcsenGzaBbJ2OKXde_onEb+8gZG9AMAX6A@mail.gmail.com>
Subject: Re: [PATH v4 3/3] vdpa/mlx5: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, 
	Parav Pandit <parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 10:48=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Mon, 22 Jul 2024 at 20:55, Cindy Lu <lulu@redhat.com> wrote:
> >
> > On Mon, 22 Jul 2024 at 17:45, Dragos Tatulea <dtatulea@nvidia.com> wrot=
e:
> > >
> > > On Mon, 2024-07-22 at 15:48 +0800, Jason Wang wrote:
> > > > On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Cindy Lu <lulu@redhat.com> =
wrote:
> > > > >
> > > > > Add the function to support setting the MAC address.
> > > > > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > > > > to set the mac address
> > > > >
> > > > > Tested in ConnectX-6 Dx device
> > > > >
> > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > ---
> > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 25 +++++++++++++++++++++++++
> > > > >  1 file changed, 25 insertions(+)
> > > > >
> > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx=
5/net/mlx5_vnet.c
> > > > > index ecfc16151d61..415b527a9c72 100644
> > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > @@ -3785,10 +3785,35 @@ static void mlx5_vdpa_dev_del(struct vdpa=
_mgmt_dev *v_mdev, struct vdpa_device *
> > > > >         destroy_workqueue(wq);
> > > > >         mgtdev->ndev =3D NULL;
> > > > >  }
> > > > > +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
> > > > > +                             struct vdpa_device *dev,
> > > > > +                             const struct vdpa_dev_set_config *a=
dd_config)
> > > > > +{
> > > > > +       struct mlx5_vdpa_dev *mvdev;
> > > > > +       struct mlx5_vdpa_net *ndev;
> > > > > +       struct mlx5_core_dev *mdev;
> > > > > +       struct virtio_net_config *config;
> > > > > +       struct mlx5_core_dev *pfmdev;
> > > Reverse xmas tree?
> > >
> > will fix this
> > > > > +       int err =3D -EOPNOTSUPP;
> > > > > +
> > > > > +       mvdev =3D to_mvdev(dev);
> > > > > +       ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > > > > +       mdev =3D mvdev->mdev;
> > > > > +       config =3D &ndev->config;
> > > > > +
> > > You still need to take the ndev->reslock.
> > >
> > sure, will do
> > > > > +       if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADD=
R)) {
> > > > > +               pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev)=
);
> > > > > +               err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > > > > +               if (!err)
> > > > > +                       memcpy(config->mac, add_config->net.mac, =
ETH_ALEN);
> > > What is the expected behaviour when the device is in use?
> > >
> > if the err is 0 then copy the Mac address to config
> > will change this code to make it more clear
> > Thanks
> > Cindy
> sorry for the misunderstanding. The VDPA tool does not support
> changing the MAC address after the guest is loaded. I think I can add
> a check for VIRTIO_CONFIG_S_DRIVER_OK here?

Still racy, and I think we probably don't worry about that case. It's
the fault of the mgmt layer not us.

Thanks

> Thanks
> cindy
> > > > > +       }
> > > > > +       return err;
> > > >
> > > > Similar to net simulator, how could be serialize the modification t=
o
> > > > mac address:
> > > >
> > > > 1) from vdpa tool
> > > > 2) via control virtqueue
> > > >
> > > > Thanks
> > > >
> > > > > +}
> > > > >
> > > > >  static const struct vdpa_mgmtdev_ops mdev_ops =3D {
> > > > >         .dev_add =3D mlx5_vdpa_dev_add,
> > > > >         .dev_del =3D mlx5_vdpa_dev_del,
> > > > > +       .dev_set_attr =3D mlx5_vdpa_set_attr,
> > > > >  };
> > > > >
> > > > >  static struct virtio_device_id id_table[] =3D {
> > > > > --
> > > > > 2.45.0
> > > > >
> > > >
> > > Thanks,
> > > Dragos
>

