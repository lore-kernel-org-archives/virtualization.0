Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08822331A70
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203547; cv=none; b=pHEcVi1rBBmfKB3Ut4OLIDTCN3L0qI5MTDrAwQOO1aRiA5lj8YgUwCMMCNYJD8L6Z7xKVal1s+gaKLNqwwmoPOgu7nenaNoLYdRv4KnGkGXuibVeUtkNGmnbX6oCTImXMdt/ThEcYvBvuGcsdYM7wLB5ql6SjTeFW+CX7tmzN7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203547; c=relaxed/simple;
	bh=XXobUFJE2NaSx0C7Zwa0ukh2RuXQhVlvLk3h00RsR/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdKCh3DaE+Mb7VZjd91PX5wXZaE01+qSIAPbBq92UD2aMzdAF2ZxwyEMLu8jBIIdv39AbW4YTnTeGuw80Q9kP+CmucVs6DuqwmCesIVzVDmfub4m3KoxP6J6LDbkhLizDyKPgGLPnaegbGKuG8fxTwwLFWzvWtl1pNVTKp6XK1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X5DU4k46; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5DU4k46"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768203545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Zi9BxOJfmw9d6VOYC5IRimlV3x5WqU/DCTVD2lJ2sM=;
	b=X5DU4k46XE5oV9KljEAgMaES92A5q//0hxtDIf/QfvHTsO64zQJkR8OHQIM4pJAWfegzP1
	3LqbPDheLSix/wSJZJe1yzXXWb6AZRryGXneRNkIoQWdAiaWUIiCa7DXkh6LvYC5dIo/mb
	TCTk7x1k4CCA9z7PcVrjFZ6doRahxAA=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-BOau3HAXOW-8VyXXeqOUbg-1; Mon, 12 Jan 2026 02:39:03 -0500
X-MC-Unique: BOau3HAXOW-8VyXXeqOUbg-1
X-Mimecast-MFC-AGG-ID: BOau3HAXOW-8VyXXeqOUbg_1768203543
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-646faf19e5bso9867675d50.2
        for <virtualization@lists.linux.dev>; Sun, 11 Jan 2026 23:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768203543; x=1768808343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Zi9BxOJfmw9d6VOYC5IRimlV3x5WqU/DCTVD2lJ2sM=;
        b=K/UlOYQ+1iOOLdyFZakYgoyG/kW9VnkF/mZTyT2XUw8WaNisPAghT+eXyLZty8+X3C
         dOGcWV+m18q//Tonwc+Ee3TTA5c3e7s9tnVmGwPKDejpA9im0EXz4RcL7L4OCwxkLUVf
         ngPsU3EI2UpdV8qaRR6GEhVSVxilm7rC0li/e0s1uBk0QZSWpx3QOYAJg6fnbdsGc8YY
         wJzU2EdP+1A5ppLtVfnYQsQjAVPHi/xsjnzGxc1eyHJEwugsCEsQM/1hRTG0gVctkZsO
         lu52Dr6IyWVtMi7e++3OXApjMXO7UtG/XknZFe7y8CXR0H9+WwI6H6iUeftomf4flHX3
         pLVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAXLSCmNMI/i6xaNWiPsaPAQ87zGnX2u001Mki0Ss7OZ3QZB1Yr6NkxVpyc4q8ryqQHHuOLXU5i73g352zYA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhqeJ7p3jpjqi4uuuU9zUrPhrbMyiIjvgwqvu46/qR8nNAKiE9
	NPlf56MUN+/dsg1nTA2Htd4KOi+h2PoP/xwev+FHfUbNJNK9sFRNOFtor9KGzI10mZLHFI6MlGo
	jvbafK8Sd7IvOZJ+hmGkXLYVR6ki/rBpWTqD3ypAGtvKMPJZ+jXTuR+f6c+Y0s8RBhF28i240Bz
	fDax24S2lQ8Kln10eTtRtfGQmm5ljq56eGPZU3hUQctkE=
X-Gm-Gg: AY/fxX5eq/7oK6Y7Y1KChpYVJ6KnjKwr16NgAx+KIxuAqihVqHUcxHj3iNGbX7Khkh7
	/5izH9DCK2NxDVfmC65ybFLIAgBx2BuOhnShXWik2TmTGWwxaJZbmolHDYPWYOlpd+7hBpZcygC
	IkffB86gYsHF1/erwAHDY3WjX2yfR0mEbKdzNQn/PIZAtgi/OWXxkqGLoCbBBhVZn+bg==
X-Received: by 2002:a05:690e:1505:b0:644:60d9:750e with SMTP id 956f58d0204a3-64716cad436mr12937795d50.94.1768203543082;
        Sun, 11 Jan 2026 23:39:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcqtPk7GV6Q+Ky8XgKuLpkQfzoAa03EVbHvK0HFTMedewAPJJ7rj+DqlyQQm5oJW0mhNkWhlYxlLv23P+IXEc=
X-Received: by 2002:a05:690e:1505:b0:644:60d9:750e with SMTP id
 956f58d0204a3-64716cad436mr12937789d50.94.1768203542697; Sun, 11 Jan 2026
 23:39:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109152430.512923-1-eperezma@redhat.com> <20260109152430.512923-5-eperezma@redhat.com>
 <20260110184515-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260110184515-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 12 Jan 2026 08:38:26 +0100
X-Gm-Features: AZwV_QiyJ558fZuNeGTAckLtdGG4mnuo6azXKjIxTUJH5vawdx52CACErRJ44iI
Message-ID: <CAJaqyWcZ8YBWudqFzhnxSLCNO85ttoqTNbw54hjn3qy6C7SKRA@mail.gmail.com>
Subject: Re: [PATCH v11 04/12] vhost: move vdpa group bound check to vhost_vdpa
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	Maxime Coquelin <mcoqueli@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	jasowang@redhat.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vgEuCHaaej0iPJUl_0P97t5GB-j23RizWEr8J9J7WoQ_1768203543
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 12:46=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Fri, Jan 09, 2026 at 04:24:22PM +0100, Eugenio P=C3=A9rez wrote:
> > Remove duplication by consolidating these here.  This reduces the
> > posibility of a parent driver missing them.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 ---
> >  drivers/vdpa/vdpa_sim/vdpa_sim.c  | 6 ------
> >  drivers/vhost/vdpa.c              | 2 +-
> >  3 files changed, 1 insertion(+), 10 deletions(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index ddaa1366704b..44062e9d68f0 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -3640,9 +3640,6 @@ static int mlx5_set_group_asid(struct vdpa_device=
 *vdev, u32 group,
> >       struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> >       int err =3D 0;
> >
> > -     if (group >=3D MLX5_VDPA_NUMVQ_GROUPS)
> > -             return -EINVAL;
> > -
> >       mvdev->mres.group2asid[group] =3D asid;
> >
> >       mutex_lock(&mvdev->mres.lock);
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/v=
dpa_sim.c
> > index c1c6431950e1..df9c7ddc5d78 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > @@ -606,12 +606,6 @@ static int vdpasim_set_group_asid(struct vdpa_devi=
ce *vdpa, unsigned int group,
> >       struct vhost_iotlb *iommu;
> >       int i;
> >
> > -     if (group > vdpasim->dev_attr.ngroups)
> > -             return -EINVAL;
> > -
>
> BTW is the original ">" here an off by one error? Should have been >=3D ?
> if yes then this is a kind of bugfix and maybe needs a fixes tag.
>

Ouch that's a good catch, thanks! Do you prefer me to mark this patch
as "Fixes:" and send it for backporting to stable to or to create a
new patch just adding the ">=3D" and then moving the check to the vdpa
core on top?

> > -     if (asid >=3D vdpasim->dev_attr.nas)
> > -             return -EINVAL;
> > -
> >       iommu =3D &vdpasim->iommu[asid];
> >
> >       mutex_lock(&vdpasim->mutex);
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index 05a481e4c385..9d25b735b43d 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -680,7 +680,7 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdp=
a *v, unsigned int cmd,
> >       case VHOST_VDPA_SET_GROUP_ASID:
> >               if (copy_from_user(&s, argp, sizeof(s)))
> >                       return -EFAULT;
> > -             if (s.num >=3D vdpa->nas)
> > +             if (idx >=3D vdpa->ngroups || s.num >=3D vdpa->nas)
> >                       return -EINVAL;
> >               if (!ops->set_group_asid)
> >                       return -EOPNOTSUPP;
> > --
> > 2.52.0
>

