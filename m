Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19101386AF
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Feb 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031029; cv=none; b=XQGTiJr8ovSzFl/rfq12A/iKvBB3cc4xPUZ0V8FWV7zI5PeEdvmHC1ukhI05yp3zfyM48mPXC7wpGaoWrLxW38AM7O24OlUlNnQgaTLAjSQUVzXXDyA1Ou3XenhG9Qm5fDwIo6z25yuKKnWlCAd7eox82nFpGnbURx3cjdqVWB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031029; c=relaxed/simple;
	bh=pFHY20CA+e9mEOAvOt8zJC8Qf6w27tcDfgr5WbY4wUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7xugBN7RWnTWGG6g2vAbkhUT+9o0DLNbFpTNCQT2u1zqWKMPyUbDeXQOfbOjIiaK83LDbVMr99EF9unSty6ufmQhqX9VGsmmg78RJYLnmU4UX0zyzMLUMIGA1DQU6oCG42IQN0j07xu90SerkwJE6KyepGqH/XCO/3TUvMKCZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OT7d0xdj; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OT7d0xdj"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 486AD60680
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Feb 2024 10:50:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RWoengcYUvu6
	for <virtualization@lists.linux-foundation.org>;
	Tue, 27 Feb 2024 10:50:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 65EBE60633
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 65EBE60633
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OT7d0xdj
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 65EBE60633
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Feb 2024 10:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709031024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cN5XW9CUdGcYyNlH2Pi+8rFm+PkW6zNYvr9vLY8Pc/4=;
	b=OT7d0xdj7e2D4BsVW4CnMxFrnZG7ioRUbSluHIqnNROJplsUd3ciXKIveF+46oxV8gnhSr
	hMlYtsfOg0lIGwrcndtOyZlISIBLfds0j3bSU3OiOTZrGJbLpW5DprhVg6te87MqRfneeE
	I5cfNzT2cktu1Q9jEksS2qKjOb7V+XI=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-LQf5GQ9sPbqSYCKepOfftw-1; Tue, 27 Feb 2024 05:50:23 -0500
X-MC-Unique: LQf5GQ9sPbqSYCKepOfftw-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-dc64b659a9cso6205125276.3
        for <virtualization@lists.linux-foundation.org>; Tue, 27 Feb 2024 02:50:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709031023; x=1709635823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cN5XW9CUdGcYyNlH2Pi+8rFm+PkW6zNYvr9vLY8Pc/4=;
        b=YndsidpsJbPKwGWEVsi8eCraAFXMS2WV1qbn5WlkQBgnyfksQvx83x9/63BMW0uzrX
         JY7Jq5CApmB+5o4e6DUJ5kIWXiqrnkwt0ehb7cUU0O2jPeknW5GqG/9QAkiUATAHTJWt
         giE7nwU+GFp9viGftAVxtVS+prc8vRSEeFDQqkYf6TwtdOiYHGPKdJn7TxDSfDzXFn9t
         eR831eFZ7cHYg7AhjeYcF3iJJfxmtgx3px+hMp/QMSyIP4hvOIoEpOE27VRdbIMvcKAc
         G4lSpTruAP15DQSaZVIxvcy8dvSwCI087DvfsenRWYrHPwLzGEQmsAACr7Jdg2pNPLl7
         RjDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8NAx1ZDzN0GAiT4xvsTpl6HtvhDsOJDzur5jo2OL6zsefcILnb+pRj+/Ky2AAVd9PXzD3IONw+1nkTDQ4/s14h1eNhnncmr/FVVUP2lgCOYVxxRoejEFLDQ==
X-Gm-Message-State: AOJu0YyDAEptPN6PrqHbMOAA6/Z4FSny7tkvP5cd+IcZ5Zax/LHNS1c4
	7nSXWidWUG2Hv0+kdsHDFmqtK4injKGwWNKOBvrJE96Gye0JnpoJGVBJmFbtjl9uUT5+C8NMThZ
	SJa+53mondOWCh5Xcz9Rf2BFBGN/nAa1EXuFx4jnRs0YOuRh1EP20SVbIYtqwv8vVbp6W69GBxN
	cJeW5gigxpFIuy6xj85QIhoaq02HKZiLIIjasVvJteW00cvGtLWvn4Ig==
X-Received: by 2002:a25:b226:0:b0:dcc:1449:71ea with SMTP id i38-20020a25b226000000b00dcc144971eamr1605458ybj.50.1709031022978;
        Tue, 27 Feb 2024 02:50:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOzuO5/7OdS8Y9+YIReLWHG1+QhlUYSZo85aLKKuXBLbo/FYogFv1f2uZ0/lkEtHpKlKfTB6cGLuQsoZn0ph4=
X-Received: by 2002:a25:b226:0:b0:dcc:1449:71ea with SMTP id
 i38-20020a25b226000000b00dcc144971eamr1605440ybj.50.1709031022659; Tue, 27
 Feb 2024 02:50:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240216142502.78095-1-jonah.palmer@oracle.com> <CAPpAL=zp+VxFUNw5W2jB0ENhYZ4Ts5+gAH7cQu-7LMhFnApqrA@mail.gmail.com>
In-Reply-To: <CAPpAL=zp+VxFUNw5W2jB0ENhYZ4Ts5+gAH7cQu-7LMhFnApqrA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 27 Feb 2024 11:49:46 +0100
Message-ID: <CAJaqyWe4V23-Koadp3dQhmfmZyDP9dhS56s1ObwJgb+Veb+Twg@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa/mlx5: Allow CVQ size changes
To: Lei Yang <leiyang@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, si-wei.liu@oracle.com, 
	virtualization@lists.linux-foundation.org, dtatulea@nvidia.com, 
	boris.ostrovsky@oracle.com, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 2:09=E2=80=AFAM Lei Yang <leiyang@redhat.com> wrote=
:
>
> QE tested this patch's V2, qemu no longer print error messages
> "qemu-system-x86_64: Insufficient written data (0)" after
> enable/disable multi queues multi times inside guest. Both "x-svq=3Don
> '' and without it are all test pass.
>
> Tested-by: Lei Yang <leiyang@redhat.com>
>
> On Fri, Feb 16, 2024 at 10:25=E2=80=AFPM Jonah Palmer <jonah.palmer@oracl=
e.com> wrote:
> >
> > The MLX driver was not updating its control virtqueue size at set_vq_nu=
m
> > and instead always initialized to MLX5_CVQ_MAX_ENT (16) at
> > setup_cvq_vring.
> >
> > Qemu would try to set the size to 64 by default, however, because the
> > CVQ size always was initialized to 16, an error would be thrown when
> > sending >16 control messages (as used-ring entry 17 is initialized to 0=
).
> > For example, starting a guest with x-svq=3Don and then executing the
> > following command would produce the error below:
> >
> >  # for i in {1..20}; do ifconfig eth0 hw ether XX:xx:XX:xx:XX:XX; done
> >
> >  qemu-system-x86_64: Insufficient written data (0)
> >  [  435.331223] virtio_net virtio0: Failed to set mac address by vq com=
mand.
> >  SIOCSIFHWADDR: Invalid argument
> >

Also,

Fixes: 5262912ef3cf ("vdpa/mlx5: Add support for control VQ and MAC setting=
")

> > Acked-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index 778821bab7d9..ecfc16151d61 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -151,8 +151,6 @@ static void teardown_driver(struct mlx5_vdpa_net *n=
dev);
> >
> >  static bool mlx5_vdpa_debug;
> >
> > -#define MLX5_CVQ_MAX_ENT 16
> > -
> >  #define MLX5_LOG_VIO_FLAG(_feature)                                   =
                             \
> >         do {                                                           =
                            \
> >                 if (features & BIT_ULL(_feature))                      =
                            \
> > @@ -2276,9 +2274,16 @@ static void mlx5_vdpa_set_vq_num(struct vdpa_dev=
ice *vdev, u16 idx, u32 num)
> >         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> >         struct mlx5_vdpa_virtqueue *mvq;
> >
> > -       if (!is_index_valid(mvdev, idx) || is_ctrl_vq_idx(mvdev, idx))
> > +       if (!is_index_valid(mvdev, idx))
> >                 return;
> >
> > +        if (is_ctrl_vq_idx(mvdev, idx)) {
> > +                struct mlx5_control_vq *cvq =3D &mvdev->cvq;
> > +
> > +                cvq->vring.vring.num =3D num;
> > +                return;
> > +        }
> > +
> >         mvq =3D &ndev->vqs[idx];
> >         mvq->num_ent =3D num;
> >  }
> > @@ -2963,7 +2968,7 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *=
mvdev)
> >                 u16 idx =3D cvq->vring.last_avail_idx;
> >
> >                 err =3D vringh_init_iotlb(&cvq->vring, mvdev->actual_fe=
atures,
> > -                                       MLX5_CVQ_MAX_ENT, false,
> > +                                       cvq->vring.vring.num, false,
> >                                         (struct vring_desc *)(uintptr_t=
)cvq->desc_addr,
> >                                         (struct vring_avail *)(uintptr_=
t)cvq->driver_addr,
> >                                         (struct vring_used *)(uintptr_t=
)cvq->device_addr);
> > --
> > 2.39.3
> >
>

There is another related issue in both mlx and vdpa_sim, although I
think it does not cause any direct bug. They both return a hardcoded
256 in .get_vq_num_max, although they both accept bigger sizes with
.set_vq_num.

QEMU just never calls .get_vq_num_max, so it does not forward this
maximum to the guest.

To be aligned with the VirtIO standard it should return the actual
maximum, which I think is only bounded by the uint16_t maximum in the
packed case and the half in the case of split, due to the requisite of
being a power of 2. This is a very big value however, so I think the
right solution is to allow to specify this maximum on vdpa command
line tool.

Moreover, the virtio standard allows the device to set different max Q
size values per virtqueue, something that the vdpa ops does not allow
as it cannot tell between queues, is a per device vdpa_op.

Having said that, maybe it is not worth all the trouble, as it has not
been reported to cause any issue?

Thanks!

