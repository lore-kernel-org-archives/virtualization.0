Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FD316D9A5
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659724; cv=none; b=ocIufftyzTFRQ1sOVJmYUcxHW3wffZRogkWbJ9/owAwEpJG0dolnIZw7NKnhL+dXQqhxDto+nM9fpE7NbyNFuz12MNQsu+vhwzmkhvNEdUJFMf4j0rWAhM0JEq+SO/gPUMA2UcRhipxDTwBb6pLxGHHmkIC1hCiv/SAV3+IxhDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659724; c=relaxed/simple;
	bh=SRMrkfOnPx+rdqmniL6jFNVCQL1r+Ntj8w9xuWb9BDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHE1fqXX4e4IgR4RxKYQFgq0bSpV5+ZUZaxuoYLwzOHpfF9Ud6bl7mAOeN10nw4gaP2fOtu0HuLAFWgjgBvbDG3SSy/sshe9+pJG4+P44lbBggUk/H7sfO4WTn4IzoLxyT96KpVRXwtso5h4ChTTzO2RIvMAvkFgW6EJH+TA9pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/Z+827o; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/Z+827o"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52C146059E
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 14:48:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gmlzw8h46OwI for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Jul 2024 14:48:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 66577600B5
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 66577600B5
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d/Z+827o
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 66577600B5
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721659720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nL1b6Ct+0A4PYkkgWT+fmhmustvbQO/NjEYepCrpRbI=;
	b=d/Z+827oIdArTOnsMZMxoaLxfJXVdmDSoAjW9XahOCofCSHmh5sDKJaS2Qyyxw76hHUZ/3
	P0CJfrWHzXG1yKCRYRQ3FMHQPTuNXPmEwizoN4IInPwIWJY6vFF7OWd21IkNRiU/5HER5r
	1R24lwQm8noWYKKhLVil5276WGClXcY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-Osr2VcqtOL-VNYbBZ8q4mw-1; Mon, 22 Jul 2024 10:48:38 -0400
X-MC-Unique: Osr2VcqtOL-VNYbBZ8q4mw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5a355a541efso1124473a12.0
        for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 07:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721659717; x=1722264517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL1b6Ct+0A4PYkkgWT+fmhmustvbQO/NjEYepCrpRbI=;
        b=a10Goz0wa6/RoowtDO4G+Id3m+jY0xigrYQQ9zMC/hF/iFE64zVVFEnCSVlkmR5XWP
         vIHQGi+njb8H6PkBH+sCW6ijiHOyLyO1J25c3YmtGVHQ3AFFvmamBoBghJGDugbpTgEw
         crCgzCcxsyuAxte8nGPvNDbDDtOTJ+jZ2TqyXMLbNVSkFON+3sKg9zdo1b/4S/c9XH62
         k1a2+vJWyaGy3yAyeFbBvnmUzaD56zhGqSWVyWwvY1WPf2BYyI/lUg8UHh3wMwlwEsuS
         hxWFV087fj3cIzmWww00Ye+l/VKMnwcXDavvd8PP80mr0d4h1UJ3/H3dzNKEZTG45HcZ
         R4Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUDG1ZDugD52Kdicm5fRCxgdI6ggeIuFkj3cIziJNtOmKcCVOcbOXl3ujc+I31g/obX7GhCY0dGA19gOH44qYwcBFR9mddGcJFh8UBmKT2YJekNDTGfp5rZOA==
X-Gm-Message-State: AOJu0YxJsfhF9YhCyb3sQbjd30XIZ53mPazOXmI+myM+e8uqBIRIvZ52
	guB1Or8wyLA6E1e+Ca2+xJskyicmbMq0AjXW/P9ZG6rPSKl4vtx6CrxSaqIOWlzR5ZkLqBS6xUr
	UfR41RFjJ8/Db4kBKAR3fvJFyZJlOThRfmtLoVCA9JXjBgOPvwclJ39EiTIPOVZIf72qhh1NxEa
	egrU/noJL8/Ieucmy5EGJPzzZx3B9fak6ui8cEXvpMvjGjCDCsmDGJow==
X-Received: by 2002:a50:9553:0:b0:5a2:8f7d:aff4 with SMTP id 4fb4d7f45d1cf-5a479b729b2mr5750882a12.20.1721659716749;
        Mon, 22 Jul 2024 07:48:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEujzFQkDOMoSemOi9mGgKDIm+sW5uf5B+Pv1IsMJHgXi5lCcdZ5DbGYJL+6Dv+saxv4yTrO0gB7p3Li0CuUg=
X-Received: by 2002:a50:9553:0:b0:5a2:8f7d:aff4 with SMTP id
 4fb4d7f45d1cf-5a479b729b2mr5750863a12.20.1721659716425; Mon, 22 Jul 2024
 07:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240722010625.1016854-1-lulu@redhat.com> <20240722010625.1016854-4-lulu@redhat.com>
 <CACGkMEvXk8_sXRtugePAMv8PM0qGU-su0eFUsFZ=-=_TjcGZNg@mail.gmail.com>
 <7a4d99e0f16cbe91000c3c780334a4c866904182.camel@nvidia.com> <CACLfguUR_hdJGDcjnmYY=qOXFiSnsBsXD5evTDZQi=K0RM4gZQ@mail.gmail.com>
In-Reply-To: <CACLfguUR_hdJGDcjnmYY=qOXFiSnsBsXD5evTDZQi=K0RM4gZQ@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 22 Jul 2024 22:47:57 +0800
Message-ID: <CACLfguUWCY6MJkv+GuJ0W0t0Q0iX3fna+EjWxV5E=au9Oa5-aw@mail.gmail.com>
Subject: Re: [PATH v4 3/3] vdpa/mlx5: Add the support of set mac address
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, 
	Parav Pandit <parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jul 2024 at 20:55, Cindy Lu <lulu@redhat.com> wrote:
>
> On Mon, 22 Jul 2024 at 17:45, Dragos Tatulea <dtatulea@nvidia.com> wrote:
> >
> > On Mon, 2024-07-22 at 15:48 +0800, Jason Wang wrote:
> > > On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Cindy Lu <lulu@redhat.com> wr=
ote:
> > > >
> > > > Add the function to support setting the MAC address.
> > > > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > > > to set the mac address
> > > >
> > > > Tested in ConnectX-6 Dx device
> > > >
> > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > ---
> > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 25 +++++++++++++++++++++++++
> > > >  1 file changed, 25 insertions(+)
> > > >
> > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/=
net/mlx5_vnet.c
> > > > index ecfc16151d61..415b527a9c72 100644
> > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > @@ -3785,10 +3785,35 @@ static void mlx5_vdpa_dev_del(struct vdpa_m=
gmt_dev *v_mdev, struct vdpa_device *
> > > >         destroy_workqueue(wq);
> > > >         mgtdev->ndev =3D NULL;
> > > >  }
> > > > +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
> > > > +                             struct vdpa_device *dev,
> > > > +                             const struct vdpa_dev_set_config *add=
_config)
> > > > +{
> > > > +       struct mlx5_vdpa_dev *mvdev;
> > > > +       struct mlx5_vdpa_net *ndev;
> > > > +       struct mlx5_core_dev *mdev;
> > > > +       struct virtio_net_config *config;
> > > > +       struct mlx5_core_dev *pfmdev;
> > Reverse xmas tree?
> >
> will fix this
> > > > +       int err =3D -EOPNOTSUPP;
> > > > +
> > > > +       mvdev =3D to_mvdev(dev);
> > > > +       ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > > > +       mdev =3D mvdev->mdev;
> > > > +       config =3D &ndev->config;
> > > > +
> > You still need to take the ndev->reslock.
> >
> sure, will do
> > > > +       if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)=
) {
> > > > +               pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> > > > +               err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > > > +               if (!err)
> > > > +                       memcpy(config->mac, add_config->net.mac, ET=
H_ALEN);
> > What is the expected behaviour when the device is in use?
> >
> if the err is 0 then copy the Mac address to config
> will change this code to make it more clear
> Thanks
> Cindy
sorry for the misunderstanding. The VDPA tool does not support
changing the MAC address after the guest is loaded. I think I can add
a check for VIRTIO_CONFIG_S_DRIVER_OK here?
Thanks
cindy
> > > > +       }
> > > > +       return err;
> > >
> > > Similar to net simulator, how could be serialize the modification to
> > > mac address:
> > >
> > > 1) from vdpa tool
> > > 2) via control virtqueue
> > >
> > > Thanks
> > >
> > > > +}
> > > >
> > > >  static const struct vdpa_mgmtdev_ops mdev_ops =3D {
> > > >         .dev_add =3D mlx5_vdpa_dev_add,
> > > >         .dev_del =3D mlx5_vdpa_dev_del,
> > > > +       .dev_set_attr =3D mlx5_vdpa_set_attr,
> > > >  };
> > > >
> > > >  static struct virtio_device_id id_table[] =3D {
> > > > --
> > > > 2.45.0
> > > >
> > >
> > Thanks,
> > Dragos

