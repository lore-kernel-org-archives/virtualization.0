Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D566732BF25
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204625; cv=none; b=ktYieZnhL6anKhEa/lIb4M2tralThL79DpW54niPTqzKLjksEn8l7TFR9zzdl6lZ/06UdacvvjDjd/VTpOylxP+RXg30puN8mMKgske5QMMLiVxgymcb/mpNHDAe3fbvuytGbGcyEBUVmEps0Y2ljDyFpJIZ8/u6z7n9mnb/GhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204625; c=relaxed/simple;
	bh=3GOLCDXkfVVZ05Y4cv6TNh30GUTHtbL7SYOT4Ce5zik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gZoM4JtzFFiQb8UDkOOJqtdNzpw741yyVXzFQUbJbPwAx824xpFw9qFZJYjTuvVVyepkJztWTX3O6UcVHfMWFOgTUTg4FiYmvcQRnz/rkp7VYEif+NMhpJU7aWogX7JM5kZi7LxTl3shu3AE23EhD3L+fXiy0jTTdQq/+PfggDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f5LaZ4RG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5LaZ4RG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768204621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNaI6vAiTafGJ4P5WzAhAEUj9FDWGHWtqmNkDzYuPE4=;
	b=f5LaZ4RGEu1R+1xddapo5gfxqNaXGUeFlNo4lEKpGxHjnphWLIRbGCfrKXu/ElzR7i80Ge
	Cb5ZQce/EHSC7L/mkiNDpiM88Wk5beYJqf/jri188j0Gf9jShpjHe0W+ziK/i2yJ3k37tU
	23YgHcloCMdHXBuBI0jvaA4DE3cFPjI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-NsFi-ZnqP0OcekoaTvMmCw-1; Mon, 12 Jan 2026 02:57:00 -0500
X-MC-Unique: NsFi-ZnqP0OcekoaTvMmCw-1
X-Mimecast-MFC-AGG-ID: NsFi-ZnqP0OcekoaTvMmCw_1768204619
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso74699385e9.2
        for <virtualization@lists.linux.dev>; Sun, 11 Jan 2026 23:57:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768204619; x=1768809419;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNaI6vAiTafGJ4P5WzAhAEUj9FDWGHWtqmNkDzYuPE4=;
        b=wVObWuuox9c7H2FJ7UoMwIAmV1/7skwULh/zRl6y66c9dkCrsouUYxd/jEQpKRMWgX
         5jxoR1p7PW7NnhYEmjtO430dPF/bp0y60G/RF4Eepum0dlHRo8LyawpzIFThaDWzgWgT
         f/DXyhnzcDmQL8d9fbJy/UP383E07OYxXtNlhijTWg7I35PUUv7HUOsNOeDN6S6WQN02
         CScfM6rlJrPNqi1YagaRiFeRmaz47N4u5gW3T62kUIlXegxtZOQjz8GNnh1RsoKK/WjJ
         w8dAXS2i13ahiF9YK559Jlx08sxq9n8I5sTRcUBv5Qe7ju2n45x11n+TJRBYBULAgfeT
         CErA==
X-Forwarded-Encrypted: i=1; AJvYcCVwWU2Rq7/auuhvi0Jq9+9v2p+hP6lWHsiAu/vFvDspClf51HcdotQzCftdtdqtZSY0tksxHbuwDsHNXAjvGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaJinhwwh4pA80elzGj3PKdBc36VFhyAlGmi3Ox5gZRutlMc4v
	xwWS9UfAIXbyZDmk7wUTwTb8jV0h9cbBeMPmOcdfJP0gTCG2g9mmTAlfvQ0T8abOjOAQvS2gLm9
	kfwj+aG/DdoSuynNEZ5z8MYzkA79wrokPBKIpCjkb9K5+WM9zSAq3RwGQQKF0n1fZwRTK
X-Gm-Gg: AY/fxX7QDgEfZNKYd9Cg1MBx7xx5S8osltSgsb4naGLGVcWYwBykzxDM62SchXQDu3V
	e0RT6iWsD3XPmIWtggoyjDiLJD/oWKryyIHuXlsNXgOZQn8a00qF9o10nsvjxC21TinVl4K7lgd
	K7hdzSPXWFHzrLDMUDCvPlAa42q4yBTQLBAGHy7qX+hElfhje+iyp/NT4am1csky/uqzP1fYylS
	ub7wCFBBsOvZOGNlbCbN46Zmksad47VLk5SmOrIy1RBQGQBYnF3e1CZjRbUI9y5NtjRn/hDjqdy
	h9BFb48sOpWrFFQl2NAVMD3+Ah3VA1FFl6gAAFdkgBEfPZzbud2d+6elzBe39frbLixK0eZ0EPU
	S8UQYiux6r+fi0iMY48S2anmETIKCgdE=
X-Received: by 2002:a05:600c:3556:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-47d84b3bb18mr205146015e9.22.1768204619048;
        Sun, 11 Jan 2026 23:56:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEspCuw6gu7JaBhGRE+BEzTTY49qSNtwWtVX3obRDb+/f1rMFg2mt//SfGiZ/PkjtZLbS9GYA==
X-Received: by 2002:a05:600c:3556:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-47d84b3bb18mr205145755e9.22.1768204618585;
        Sun, 11 Jan 2026 23:56:58 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f410c6csm353613865e9.1.2026.01.11.23.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 23:56:57 -0800 (PST)
Date: Mon, 12 Jan 2026 02:56:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v11 04/12] vhost: move vdpa group bound check to
 vhost_vdpa
Message-ID: <20260112025556-mutt-send-email-mst@kernel.org>
References: <20260109152430.512923-1-eperezma@redhat.com>
 <20260109152430.512923-5-eperezma@redhat.com>
 <20260110184515-mutt-send-email-mst@kernel.org>
 <CAJaqyWcZ8YBWudqFzhnxSLCNO85ttoqTNbw54hjn3qy6C7SKRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWcZ8YBWudqFzhnxSLCNO85ttoqTNbw54hjn3qy6C7SKRA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: S2goRjiWAVB2qlXIh_IoqA6gEpEEayVjlkjSJi87ih4_1768204619
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jan 12, 2026 at 08:38:26AM +0100, Eugenio Perez Martin wrote:
> On Sun, Jan 11, 2026 at 12:46 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Jan 09, 2026 at 04:24:22PM +0100, Eugenio Pérez wrote:
> > > Remove duplication by consolidating these here.  This reduces the
> > > posibility of a parent driver missing them.
> > >
> > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 ---
> > >  drivers/vdpa/vdpa_sim/vdpa_sim.c  | 6 ------
> > >  drivers/vhost/vdpa.c              | 2 +-
> > >  3 files changed, 1 insertion(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index ddaa1366704b..44062e9d68f0 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -3640,9 +3640,6 @@ static int mlx5_set_group_asid(struct vdpa_device *vdev, u32 group,
> > >       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > >       int err = 0;
> > >
> > > -     if (group >= MLX5_VDPA_NUMVQ_GROUPS)
> > > -             return -EINVAL;
> > > -
> > >       mvdev->mres.group2asid[group] = asid;
> > >
> > >       mutex_lock(&mvdev->mres.lock);
> > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > index c1c6431950e1..df9c7ddc5d78 100644
> > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > @@ -606,12 +606,6 @@ static int vdpasim_set_group_asid(struct vdpa_device *vdpa, unsigned int group,
> > >       struct vhost_iotlb *iommu;
> > >       int i;
> > >
> > > -     if (group > vdpasim->dev_attr.ngroups)
> > > -             return -EINVAL;
> > > -
> >
> > BTW is the original ">" here an off by one error? Should have been >= ?
> > if yes then this is a kind of bugfix and maybe needs a fixes tag.
> >
> 
> Ouch that's a good catch, thanks! Do you prefer me to mark this patch
> as "Fixes:" and send it for backporting to stable to or to create a
> new patch just adding the ">=" and then moving the check to the vdpa
> core on top?

It seems adequate to just send this to backporting.
Do document that this is a fix in the commit log though.


> > > -     if (asid >= vdpasim->dev_attr.nas)
> > > -             return -EINVAL;
> > > -
> > >       iommu = &vdpasim->iommu[asid];
> > >
> > >       mutex_lock(&vdpasim->mutex);
> > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > index 05a481e4c385..9d25b735b43d 100644
> > > --- a/drivers/vhost/vdpa.c
> > > +++ b/drivers/vhost/vdpa.c
> > > @@ -680,7 +680,7 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
> > >       case VHOST_VDPA_SET_GROUP_ASID:
> > >               if (copy_from_user(&s, argp, sizeof(s)))
> > >                       return -EFAULT;
> > > -             if (s.num >= vdpa->nas)
> > > +             if (idx >= vdpa->ngroups || s.num >= vdpa->nas)
> > >                       return -EINVAL;
> > >               if (!ops->set_group_asid)
> > >                       return -EOPNOTSUPP;
> > > --
> > > 2.52.0
> >

