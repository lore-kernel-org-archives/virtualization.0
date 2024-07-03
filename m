Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B972181BA6
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022570; cv=none; b=rJ+9L1FB+5xCBIIRJf/ltFq1BUIXYWVjQUcqFKPipPNEeSpXxLP9a0r1Pds7alodysDgUHioucblTUXk13VPfzJGRMwq5XHI3TrzQboxcHrHXxQ40XOspuRsVxmSlsHrjrrmFQqVVyd1/5exupeivQPLaf2HV2ZCcc3VI+MI4lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022570; c=relaxed/simple;
	bh=6L9NY57jmpj8sQ+NfzV23lGrMZsexvRx3xhnQCcLgdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McjevbPU62jj+mVSzWdqRtAK5yZltHCFPd0DQbsSZA5wLiVdwcC04C2CujWvUN/Uv+BypABipUD6TvTr5joisvGkHBoQAq+UykbLG6f0YFx6uUsSj9WXW1Yqn7wnfcvXwK/UIE8lsGld7nCc8I8ybv7xRHMiYTavOFHY/ar1dzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=glZVLoaB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glZVLoaB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720022566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2cZYZWG6Pe+QgIPXlNlnU44T2JexrvRdPhkV7V2BNno=;
	b=glZVLoaB4rPhm8gwAnDrQzvtuRF3ZHGv6Lor8VX7iR+8hitbycJo1VsaUg6edYeIyouKQN
	JwUMGNW3Hq7x+a96DiGrqE4AvRrTLUeId2joNiSg8fBuE1nBT/9wAGIEJn8ruLaDq5ECBY
	/vnT+El6bi2btyrI+jBZAm9JJYIZzTc=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-3aHZkjBPMxSRe_4ERqGkFw-1; Wed, 03 Jul 2024 12:02:36 -0400
X-MC-Unique: 3aHZkjBPMxSRe_4ERqGkFw-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6502e4c5aafso8042797b3.1
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 09:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720022556; x=1720627356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cZYZWG6Pe+QgIPXlNlnU44T2JexrvRdPhkV7V2BNno=;
        b=RaXCcrJ1zA4rE7e2hgt57DO2C1Fc8pvoOHfoXuYSTsFu830mobTZBLCq+xG6XQll67
         Tw5SjMv2rlsi2E3vldeqskGSPt09lpVbCFwGwiVhgvoL47OnG/npl6ctrOh8bTtCd8oG
         9HyYUT1DHJ8NH4VTHM6Gfm1oKjNeMF4mS5yfd9e+lOxNTn8tfRdHxQFN5DENr1riygrA
         iA5uK7Xvq7yMr1I5/VKdR33yEwKWcAhCmADeDD/fNgX11QNJX4EFUcE1n/lbJvgweckR
         ePLQfsoc0xgif9WksCQprLsB9+22TWvQj3waa+IPKNQNErQ1/PUfiJBaTkp9K4JyMZrc
         6/vw==
X-Forwarded-Encrypted: i=1; AJvYcCV45mXZ4O1yIHtgcbUPqQ82dOe5IOxTb/HgrBV+6jNxrXUyXG9o8XP3VHIiRv+cVcNY0apYc9EfBaP7n6kL1JfIUGrWj8TFE9pVUMzc2C0=
X-Gm-Message-State: AOJu0YzZaMgzhRqJAaoUhfeesMFKOjf01JzPNCorPEtq2jBosCWWn67y
	9Xtg+AEpzzqLGS6lN709Be4isSq33QGZatUTL5XWxntU7tgu7ds+a4IO9eKg9hBsbqjEb50ck/e
	XlMOKlK0Z2hFRPz0XlRRMWk2NtGikU7V7TKjYjwtMDm4x+AVjX3UhyJoZaowoxCAasg1h2c0T+3
	QPNin/VaeS2jmaetZavgEb0yJtp+l9zfjMhJf65Pk=
X-Received: by 2002:a05:690c:680f:b0:651:ee07:76c with SMTP id 00721157ae682-651ee07079bmr10340187b3.15.1720022555409;
        Wed, 03 Jul 2024 09:02:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJEOD0j6Fdz3pMKQ3JW6XMwPwyu8ibTc12rO5h2L/BNg/OImtMoNq9K9CCxxA4ZFtP+3+hN3kt2OxZI51fJeQ=
X-Received: by 2002:a05:690c:680f:b0:651:ee07:76c with SMTP id
 00721157ae682-651ee07079bmr10339557b3.15.1720022554801; Wed, 03 Jul 2024
 09:02:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com>
 <20240617-stage-vdpa-vq-precreate-v1-20-8c0483f0ca2a@nvidia.com>
 <CAJaqyWd3yiPUMaGEmzgHF-8u+HcqjUxBNB3=Xg6Lon-zYNVCow@mail.gmail.com> <308f90bb505d12e899e3f4515c4abc93c39cfbd5.camel@nvidia.com>
In-Reply-To: <308f90bb505d12e899e3f4515c4abc93c39cfbd5.camel@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 3 Jul 2024 18:01:58 +0200
Message-ID: <CAJaqyWeHDD0drkAZQqEP_ZfbUPscOmM7T8zXRie5Q14nfAV0sg@mail.gmail.com>
Subject: Re: [PATCH vhost 20/23] vdpa/mlx5: Pre-create hardware VQs at vdpa
 .dev_add time
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Tariq Toukan <tariqt@nvidia.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, 
	"si-wei.liu@oracle.com" <si-wei.liu@oracle.com>, "jasowang@redhat.com" <jasowang@redhat.com>, 
	"mst@redhat.com" <mst@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 11:27=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> On Wed, 2024-06-19 at 17:54 +0200, Eugenio Perez Martin wrote:
> > On Mon, Jun 17, 2024 at 5:09=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia=
.com> wrote:
> > >
> > > Currently, hardware VQs are created right when the vdpa device gets i=
nto
> > > DRIVER_OK state. That is easier because most of the VQ state is known=
 by
> > > then.
> > >
> > > This patch switches to creating all VQs and their associated resource=
s
> > > at device creation time. The motivation is to reduce the vdpa device
> > > live migration downtime by moving the expensive operation of creating
> > > all the hardware VQs and their associated resources out of downtime o=
n
> > > the destination VM.
> > >
> > > The VQs are now created in a blank state. The VQ configuration will
> > > happen later, on DRIVER_OK. Then the configuration will be applied wh=
en
> > > the VQs are moved to the Ready state.
> > >
> > > When .set_vq_ready() is called on a VQ before DRIVER_OK, special care=
 is
> > > needed: now that the VQ is already created a resume_vq() will be
> > > triggered too early when no mr has been configured yet. Skip calling
> > > resume_vq() in this case, let it be handled during DRIVER_OK.
> > >
> > > For virtio-vdpa, the device configuration is done earlier during
> > > .vdpa_dev_add() by vdpa_register_device(). Avoid calling
> > > setup_vq_resources() a second time in that case.
> > >
> >
> > I guess this happens if virtio_vdpa is already loaded, but I cannot
> > see how this is different here. Apart from the IOTLB, what else does
> > it change from the mlx5_vdpa POV?
> >
> I don't understand your question, could you rephrase or provide more cont=
ext
> please?
>

My main point is that the vdpa parent driver should not be able to
tell the difference between vhost_vdpa and virtio_vdpa. The only
difference I can think of is because of the vhost IOTLB handling.

Do you also observe this behavior if you add the device with "vdpa
add" without the virtio_vdpa module loaded, and then modprobe
virtio_vdpa?

At least the comment should be something in the line of "If we have
all the information to initialize the device, pre-warm it here" or
similar.

> Thanks,
> Dragos
>
> > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 37 +++++++++++++++++++++++++++++=
+++-----
> > >  1 file changed, 32 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/ne=
t/mlx5_vnet.c
> > > index 249b5afbe34a..b2836fd3d1dd 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -2444,7 +2444,7 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_=
device *vdev, u16 idx, bool ready
> > >         mvq =3D &ndev->vqs[idx];
> > >         if (!ready) {
> > >                 suspend_vq(ndev, mvq);
> > > -       } else {
> > > +       } else if (mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) {
> > >                 if (resume_vq(ndev, mvq))
> > >                         ready =3D false;
> > >         }
> > > @@ -3078,10 +3078,18 @@ static void mlx5_vdpa_set_status(struct vdpa_=
device *vdev, u8 status)
> > >                                 goto err_setup;
> > >                         }
> > >                         register_link_notifier(ndev);
> > > -                       err =3D setup_vq_resources(ndev, true);
> > > -                       if (err) {
> > > -                               mlx5_vdpa_warn(mvdev, "failed to setu=
p driver\n");
> > > -                               goto err_driver;
> > > +                       if (ndev->setup) {
> > > +                               err =3D resume_vqs(ndev);
> > > +                               if (err) {
> > > +                                       mlx5_vdpa_warn(mvdev, "failed=
 to resume VQs\n");
> > > +                                       goto err_driver;
> > > +                               }
> > > +                       } else {
> > > +                               err =3D setup_vq_resources(ndev, true=
);
> > > +                               if (err) {
> > > +                                       mlx5_vdpa_warn(mvdev, "failed=
 to setup driver\n");
> > > +                                       goto err_driver;
> > > +                               }
> > >                         }
> > >                 } else {
> > >                         mlx5_vdpa_warn(mvdev, "did not expect DRIVER_=
OK to be cleared\n");
> > > @@ -3142,6 +3150,7 @@ static int mlx5_vdpa_compat_reset(struct vdpa_d=
evice *vdev, u32 flags)
> > >                 if (mlx5_vdpa_create_dma_mr(mvdev))
> > >                         mlx5_vdpa_warn(mvdev, "create MR failed\n");
> > >         }
> > > +       setup_vq_resources(ndev, false);
> > >         up_write(&ndev->reslock);
> > >
> > >         return 0;
> > > @@ -3836,8 +3845,21 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_=
dev *v_mdev, const char *name,
> > >                 goto err_reg;
> > >
> > >         mgtdev->ndev =3D ndev;
> > > +
> > > +       /* For virtio-vdpa, the device was set up during device regis=
ter. */
> > > +       if (ndev->setup)
> > > +               return 0;
> > > +
> > > +       down_write(&ndev->reslock);
> > > +       err =3D setup_vq_resources(ndev, false);
> > > +       up_write(&ndev->reslock);
> > > +       if (err)
> > > +               goto err_setup_vq_res;
> > > +
> > >         return 0;
> > >
> > > +err_setup_vq_res:
> > > +       _vdpa_unregister_device(&mvdev->vdev);
> > >  err_reg:
> > >         destroy_workqueue(mvdev->wq);
> > >  err_res2:
> > > @@ -3863,6 +3885,11 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt=
_dev *v_mdev, struct vdpa_device *
> > >
> > >         unregister_link_notifier(ndev);
> > >         _vdpa_unregister_device(dev);
> > > +
> > > +       down_write(&ndev->reslock);
> > > +       teardown_vq_resources(ndev);
> > > +       up_write(&ndev->reslock);
> > > +
> > >         wq =3D mvdev->wq;
> > >         mvdev->wq =3D NULL;
> > >         destroy_workqueue(wq);
> > >
> > > --
> > > 2.45.1
> > >
> >
>

