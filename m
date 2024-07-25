Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10191662EF
	for <virtualization@lists.linux.dev>; Thu, 25 Jul 2024 07:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721890816; cv=none; b=ZQmK4tljD3YHLbDgamYDZclwolgszKdUTy1h8rgWUQudEe6xTIlHfEFv0YizZzxHNkY42r6IBqk9zGYLCqnTgaYRlyTyvnP0eWv9nZ/aBAKHdLLgap9XQiz77IVM/4a0xtyf0KWs+/sefbia7vCN6jaIukpeGUvMKS76j8E3UnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721890816; c=relaxed/simple;
	bh=Lp0IEG/Br5aA9Q0TTtgOcO3tblikfArv9u5fT9wc40U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZsqYwczpXANvpvq4SeuJdcDiNdgGROJJyNNwPmXuUTIdsdFabtPiVUoev7QsOOrIycQ+Sa1+StsC7BXXocdGpVLj3rMMeE4ahgKdR41gbO8PMjUfv+yHFamIUGFA/JD5mDE3PnJK8zbxDVjh/nbSmW1Twc9LyYVczp7sv+mAFaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amyLUfLH; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amyLUfLH"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4f6abcf0567so280772e0c.0
        for <virtualization@lists.linux.dev>; Thu, 25 Jul 2024 00:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721890813; x=1722495613; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qV/f4NBfUFd9uJAepvJzg2m9PwLZoTqyu3DOODQLyjc=;
        b=amyLUfLHLDc6wdqc2WFadmdWdPkl/lC3Q9ar60cIOFR6IKY9bUDDeX/lExPUASXgNZ
         +Qqz07A20WzvnwtiC90/tok4bO8Wen1B5A3AbuN6kB42LKZz11ANFmFI+Ek7xwgeHxdU
         UT4xN8OyX990+wqr6N2aFkTtzueVKmybQ1E2WphfLkz8SDbRAyHfPx+9pK7hzGqxEUJ7
         GKVkxKDUHj0eewpBjNgqDvTWCKOHaBYT2iOTd1P7g8yWrj75vXRHIqufCfaSTAGei4nQ
         tjKnj2Ljrths6L9NgrXig1VbxCBPTVDU2JyFm6CiV/HixiH293f3S+h5hEXv4U2fOEn1
         9HDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721890813; x=1722495613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qV/f4NBfUFd9uJAepvJzg2m9PwLZoTqyu3DOODQLyjc=;
        b=m6tLPsYGxsdpm79gMyQFHyEzCGraYlJc68Dmuini6bqRC7pbk++a3TerNPuxiML430
         u3BUGNljJ81t5wQgEaxOqUW7bcM4EV/TtpRjeUXDQElGoGMAwLcnHQtO3bwRsQvvYMkR
         ScZbItZwL3LEygcg4+Ca9UIuBmnhEhOhtt9M020CgWWwqCN7PS9OoOkETQuOHM5zMoEj
         0sTXj8/7YM07ixWLtSeirXi0PiWA61JWIFZOHX1r4DkoWmXEOSq1L/IIb0AdLmCZLxUH
         2+y11iwGs4RM9JeHhhO28oinYbtoKHx0P5mNLmEBUF22WuweKjn5m02fK57eItF+6VkQ
         40LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNHVWhhs38umczrSQh0/ot4fGSQxSH3+5+mrfbjE1EHZwIJJ7Yxm4tuSy9+7mR9pBbODEHR5jcGCMM2CmFXUz9zEFRGycr3yag0Q7DviQ=
X-Gm-Message-State: AOJu0YxRy30IOeOwfexGFek0ErajL4KdoDPNi4XF9VDRiTxqttesvgLA
	pbQ/x8FNWEaOPkx4FM1vcgjEs57FcY42NwHXdkPtkeJGSFqyzY6ilkhaYW8jTv7zytB2InsDQcA
	3xOygYKv9Bx8TEiCyOR6zXjX2jnU=
X-Google-Smtp-Source: AGHT+IHumo2GqIIeqiUctsxeloUYAcJ7t/cwEkcaWuL9SPuIEGK/BZu/XVYwb9DQnLhbg8wlEuUrr0yr35mHWTu9sMU=
X-Received: by 2002:a05:6122:1311:b0:4f5:261a:bdc7 with SMTP id
 71dfb90a1353d-4f6ca2c499emr1040648e0c.4.1721890813466; Thu, 25 Jul 2024
 00:00:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240724085544.299090-1-21cnbao@gmail.com> <20240724085544.299090-2-21cnbao@gmail.com>
 <ZqDzErEQbC49F4j9@tiehlicka> <CAGsJ_4z+iMXqJP68HQzbmkmWGHa-houPUKth=vbYgL=1OLV4Gg@mail.gmail.com>
 <ZqHr9OQPDVKr-1Cs@tiehlicka>
In-Reply-To: <ZqHr9OQPDVKr-1Cs@tiehlicka>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 25 Jul 2024 19:00:02 +1200
Message-ID: <CAGsJ_4x+V8jVuM307uGUCXVrZTWGHNKHYqGsj6UAN=QH=yWpqw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] vpda: try to fix the potential crash due to
 misusing __GFP_NOFAIL
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com, 
	cl@linux.com, hch@infradead.org, iamjoonsoo.kim@lge.com, lstoakes@gmail.com, 
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev, 
	urezki@gmail.com, v-songbaohua@oppo.com, vbabka@suse.cz, 
	virtualization@lists.linux.dev, hailong.liu@oppo.com, 
	torvalds@linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Maxime Coquelin <maxime.coquelin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 6:08=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 25-07-24 10:50:45, Barry Song wrote:
> > On Thu, Jul 25, 2024 at 12:27=E2=80=AFAM Michal Hocko <mhocko@suse.com>=
 wrote:
> > >
> > > On Wed 24-07-24 20:55:40, Barry Song wrote:
> [...]
> > > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vd=
pa_user/iova_domain.c
> > > > index 791d38d6284c..eff700e5f7a2 100644
> > > > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > > > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > > > @@ -287,28 +287,44 @@ void vduse_domain_remove_user_bounce_pages(st=
ruct vduse_iova_domain *domain)
> > > >  {
> > > >       struct vduse_bounce_map *map;
> > > >       unsigned long i, count;
> > > > +     struct page **pages =3D NULL;
> > > >
> > > >       write_lock(&domain->bounce_lock);
> > > >       if (!domain->user_bounce_pages)
> > > >               goto out;
> > > > -
> > > >       count =3D domain->bounce_size >> PAGE_SHIFT;
> > > > +     write_unlock(&domain->bounce_lock);
> > > > +
> > > > +     pages =3D kmalloc_array(count, sizeof(*pages), GFP_KERNEL | _=
_GFP_NOFAIL);
> > > > +     for (i =3D 0; i < count; i++)
> > > > +             pages[i] =3D alloc_page(GFP_KERNEL | __GFP_NOFAIL);
> > >
> > > AFAICS vduse_domain_release calls this function with
> > > spin_lock(&domain->iotlb_lock) so dropping &domain->bounce_lock is no=
t
> > > sufficient.
> >
> > yes. this is true:
> >
> > static int vduse_domain_release(struct inode *inode, struct file *file)
> > {
> >         struct vduse_iova_domain *domain =3D file->private_data;
> >
> >         spin_lock(&domain->iotlb_lock);
> >         vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
> >         vduse_domain_remove_user_bounce_pages(domain);
> >         vduse_domain_free_kernel_bounce_pages(domain);
> >         spin_unlock(&domain->iotlb_lock);
> >         put_iova_domain(&domain->stream_iovad);
> >         put_iova_domain(&domain->consistent_iovad);
> >         vhost_iotlb_free(domain->iotlb);
> >         vfree(domain->bounce_maps);
> >         kfree(domain);
> >
> >         return 0;
> > }
> >
> > This is quite a pain. I admit I don't have knowledge of this driver, an=
d I don't
> > think it's safe to release two locks and then reacquire them. The situa=
tion is
> > rather complex. Therefore, I would prefer if the VDPA maintainers could
> > take the lead in implementing a proper fix.
>
> Would it be possible to move all that work to a deferred context?

My understanding is that we need to be aware of both the iotlb_lock and
bounce_lock to implement the correct changes. As long as we still need
to acquire these two locks in a deferred context, there doesn't seem to
be any difference.

I can do the memory pre-allocation before spin_lock(&domain->iotlb_lock),
but I have no knowledge whether the "count" will change after I make
the preallocation.

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c
b/drivers/vdpa/vdpa_user/iova_domain.c
index 791d38d6284c..7ec87ef33d42 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -544,9 +544,12 @@ static int vduse_domain_release(struct inode
*inode, struct file *file)
 {
        struct vduse_iova_domain *domain =3D file->private_data;

+      struct page **pages;
+      spin_lock(&domain->iotlb_lock); maybe also + bounce_lock?
+      count =3D domain->bounce_size >> PAGE_SHIFT;
+      spin_unlock(&domain->iotlb_lock);
+
+       preallocate_count_pages(pages, count);
+
....
        spin_lock(&domain->iotlb_lock);
        vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
-       vduse_domain_remove_user_bounce_pages(domain);
+       vduse_domain_remove_user_bounce_pages(domain, pages);
        vduse_domain_free_kernel_bounce_pages(domain);
        spin_unlock(&domain->iotlb_lock);
        put_iova_domain(&domain->stream_iovad);


> --
> Michal Hocko
> SUSE Labs
