Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A492A4596C
	for <virtualization@lists.linux.dev>; Thu, 29 Feb 2024 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709191313; cv=none; b=Hql2zGvPKUoD6hLbViygqcfAUdGDf1sVDjnNR+TFY4ugpnzCxgPziBPIzb+wKfJiwAsRVhnFnV+fQAK0SXt7Rsd47Ha+u5AKkRJPiqHnzgzWLgqql02hU5ieuyNPGyP3kGN7NO7G1a6DAItxDDUw/AP7FVaDvGFu0MDU98ZbTlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709191313; c=relaxed/simple;
	bh=HqknOjEjlYxT7iVdqKOIUCiHsRYWnF8WRHrWHM7BaNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ux4oCx6O9SyHDOu5mAvFmZJo5ZGQX5w2lydEfNRlJbe+kDS/Y6fz3qj5etXZHnAG+Aa6NCjXMANdlMuW/Bpok8LSyL4Psc87TA4q+ZzZ+ST/mwmvjvhkmcSf0gxr8tcuMSd3E4tTuubkKACpnlnS7zp3AkbzH4ib5On+AOeVFo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fuAnC3Lp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fuAnC3Lp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709191310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Net7WSZ0SLXfX6qP1fBqoZy/fUubtzc+/J9dRqSPBjo=;
	b=fuAnC3LpSFsEfOh0B2+6nUeT3+gZjZkEjbcVPUWgw2RUz8ZHs2RDDEHoe6ohr0ROw1/nYy
	LEpxh5FdUX0Uxdczz79TeCqs/68hH0AToWWpFRcZmlLeSvf2htWKG7rFzq8fS64nx+WB0W
	dnC0UjiT5P6dgqyHBWeSxfH9EHb+oFo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-I0WjZ6BKM9ulSVs6vQlr2w-1; Thu, 29 Feb 2024 02:21:47 -0500
X-MC-Unique: I0WjZ6BKM9ulSVs6vQlr2w-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a3ec1d8b1e2so37349966b.3
        for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 23:21:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709191306; x=1709796106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Net7WSZ0SLXfX6qP1fBqoZy/fUubtzc+/J9dRqSPBjo=;
        b=QHqmmXDlsWwP9okbO4E0A66fGBrAA57aLvWr1YqYVGBckw+3lzyIbLRftl1UzltNIp
         sxdY5DcvyL//za1qDXPDykNZScxfd4gqo9P6CtjKKYSK34IrTnxWuEL9GpsEK8X8Bxsz
         KKYnGd8//M0yOal07oVgk+i776q2m24WavtbQzT8daU5odtR/VtyUw/E8XePcOOePEEc
         5Jj18lX/MEqEyiu0bmW5JmuSKWRnMnf5WhtUa6yUmihCpJRU2/7HygSdi0XBodHrjOwh
         KdRT/QjAgygCtzQdQ2LjCi9SHBArZ80gp76DLPBcyMJtHW/5SSKjqAWm+GXLKi6caQvl
         QoNg==
X-Forwarded-Encrypted: i=1; AJvYcCUAtKLSYAJvXa+Rq6+IpK4JqX9D/OmK3I26DK22ieEV28dIxlwepFAyyD8hd5Q321gu6DJlyrYYh8QjMp3EjlYnE61JLVVYvCR9Nel/Ozg=
X-Gm-Message-State: AOJu0YzFS0pV42aJxx0huJVizZrCMRXDguOeXZeOXROUjxrnWj2xOIIf
	cVLYnrjqC0hK+PgYXOS7T3wWEzO8psZbqrQ22Hbc8NqJA9gLn6Gsg1sAq367FDAFItJNs3YaQpo
	TrGBqrGRXM6vKuAUZ2Yk+FWDh3lm9bFbRcp75G8vfll7kVdqe2VYvggNv45jwCq1My3Z7BFnU9P
	BoWEdTI5jYzaTCv/+HBd1nYvIXm2tRgbo40KtVk20=
X-Received: by 2002:a17:906:f848:b0:a3f:d71d:d820 with SMTP id ks8-20020a170906f84800b00a3fd71dd820mr688214ejb.26.1709191306657;
        Wed, 28 Feb 2024 23:21:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHR1+8q9qhWcpHCQv9NfHXzSbTJvOggAWbOmIh8P8wUWatZVIF7qiSuP0cDF+Mqh1M4VO49hebtH0JZ7m1N8oM=
X-Received: by 2002:a17:906:f848:b0:a3f:d71d:d820 with SMTP id
 ks8-20020a170906f84800b00a3fd71dd820mr688204ejb.26.1709191306393; Wed, 28 Feb
 2024 23:21:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <98298b2f-7288-4b0b-8974-3d5111b589cb@moroto.mountain> <CAJSP0QWW2QvibpcrZbcLzVp8ngnooiTqP8i2emd+0sdCj_7Yww@mail.gmail.com>
In-Reply-To: <CAJSP0QWW2QvibpcrZbcLzVp8ngnooiTqP8i2emd+0sdCj_7Yww@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 29 Feb 2024 15:21:09 +0800
Message-ID: <CACLfguXksa4TEb5gk2bvoeGaQrR8s5TZMJGzR0r7Y9Wo9N82UQ@mail.gmail.com>
Subject: Re: [PATCH v3] vduse: Fix off by one in vduse_dev_mmap()
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Xie Yongji <xieyongji@bytedance.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 3:19=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> On Wed, 28 Feb 2024 at 13:24, Dan Carpenter <dan.carpenter@linaro.org> wr=
ote:
> >
> > The dev->vqs[] array has "dev->vq_num" elements.  It's allocated in
> > vduse_dev_init_vqs().  Thus, this > comparison needs to be >=3D to avoi=
d
> > reading one element beyond the end of the array.
> >
> > Add an array_index_nospec() as well to prevent speculation issues.
> >
> > Fixes: 316ecd1346b0 ("vduse: Add file operation for mmap")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > v2: add array_index_nospec()
> > v3: I accidentally corrupted v2.  Try again.
> >
Thanks for fix this
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by:  Cindy Lu <lulu@redhat.com>
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index b7a1fb88c506..eb914084c650 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -1532,9 +1532,10 @@ static int vduse_dev_mmap(struct file *file, str=
uct vm_area_struct *vma)
> >         if ((vma->vm_flags & VM_SHARED) =3D=3D 0)
> >                 return -EINVAL;
> >
> > -       if (index > dev->vq_num)
> > +       if (index >=3D dev->vq_num)
> >                 return -EINVAL;
> >
> > +       index =3D array_index_nospec(index, dev->vq_num);
> >         vq =3D dev->vqs[index];
> >         vaddr =3D vq->vdpa_reconnect_vaddr;
> >         if (vaddr =3D=3D 0)
> > --
> > 2.43.0
> >
> >
>

