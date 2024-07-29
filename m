Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6781E864
	for <virtualization@lists.linux.dev>; Mon, 29 Jul 2024 03:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722224558; cv=none; b=F3t6tlxE2ujZG2fSQOMDEw1zDG31FH1QLe0mY49iJvsx1/hGGpYtV8nn2TGBeWMtLayczyGVVkPX+MwjQ7O/zE1lM9GzaEbJr87e746rgiwZ6GDwCmspP13IvJqN2R6a6cuYEncg3yV3Hvl76E/npI/94PFM+0TANvK7eGRAxlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722224558; c=relaxed/simple;
	bh=Zhbv1X2Wu3WIckzhAyvFgzq6RTG9LbYvaiFiJV6TY2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxxS5qMV9N3BWk+mOz33yc0R1DpMOFd6vyy4hldYRekzGOPvGMMkSsP8S6dRbSZfSEeYqmZsyEmcXZ5EkFXSimIJpsh6XMSdHiIonfHyPgVnY/p60EV/W2un5Dq5VoIR3L+6PvNif8HX6I5EXCmS6YJA88YVvXMitC/1LkPmAt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f7TKPMYQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7TKPMYQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722224555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zejeV14JwQZnD2gzIg7+ARzepmzNQuxM/rkGlI3CoV0=;
	b=f7TKPMYQ1PzOihjnEbb49C1zVWxKMUUMip7j/m32veuvtWutEu9/f4PYUHQvn2PDTTZP97
	QJLyNktCE+17Delv/VB1JyLLew4mWlT21BX1hsczfV7w871f/C73TVjMVO0RsZ/KpWuKRo
	53L3CUzGiCE9/Rasawg5OILAiTUK0Hg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-Obxek-XhOF23-aboOGUgBg-1; Sun, 28 Jul 2024 23:42:32 -0400
X-MC-Unique: Obxek-XhOF23-aboOGUgBg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7a23a0fb195so3107485a12.0
        for <virtualization@lists.linux.dev>; Sun, 28 Jul 2024 20:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722224552; x=1722829352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zejeV14JwQZnD2gzIg7+ARzepmzNQuxM/rkGlI3CoV0=;
        b=rvrEkh0qGeW0BgDxBKhuu4MqD5s9RCS/0qpEs1fEPUFdMOb9NDP9FVGdXGDDbv4/VT
         mLYDbQ6gAPn55dArBagQN2qewiIfSkNq/9N0kdwrMjzr87mRMfxiQ0/jMYt4pCyj150v
         MUNNOancuPngVpUclh87OCtR5/FwCeQszcSCajOMg/Nq+4zpDkSeNxcRVx6FkGgFWbXC
         oxSQSQCInGfZtWNxoo+ydfpI+20dl24JBqzDXm7KxzDDMC5RMieX8OuknR2i6E0YSU2u
         PcxSDDJoWJG7iNDI+IVAzx7gvuT2pgKe/8/NuGLML337HgFK04G0vBcSpUzJhfJhOla2
         c0cw==
X-Forwarded-Encrypted: i=1; AJvYcCUlUQUWRApplCdfFTlC/LjGAUFAFmnzmnrBrnWY2VHsKE4+TPChE/lLbM0puRo9ISKcuVS3XOZT2F7CvEnxJBLoD8Jsw/kNUKnFwBOtDsw=
X-Gm-Message-State: AOJu0YzQ2d5NHD2+wxJI9/CCXGZt43bDZ+gpmf6fscslSu1auV72phMu
	U5Ti3yPJVAlDwkSu8WIpOYlkqGjQ4F5j4R5WpEZj5mZTWF6+Ib5XvTVcq9WOEZRqAtZpCJ/hQCE
	UyqO276HTV6q8dlJqdzEslqN31H5wlE9vmmDFyo8WJCcsQHvT0dXb/tSmOermvjfjcRHAEYiV0g
	GVa6+ZVqw4J3etTfq4aT4tWdPadOxCCR/39JVp7aA=
X-Received: by 2002:a17:90a:4216:b0:2c8:84b:580e with SMTP id 98e67ed59e1d1-2cf7e71e4e1mr6699091a91.41.1722224551848;
        Sun, 28 Jul 2024 20:42:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE33V26cEZs+EJ6bDmy8FUIcOWVkQb3PPY03dbWhGpNHswimOZ80QlIlZDw1IFq5t4SbZQJnVwguOAI274+5kw=
X-Received: by 2002:a17:90a:4216:b0:2c8:84b:580e with SMTP id
 98e67ed59e1d1-2cf7e71e4e1mr6699073a91.41.1722224551326; Sun, 28 Jul 2024
 20:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240724085544.299090-1-21cnbao@gmail.com> <20240724085544.299090-2-21cnbao@gmail.com>
 <ZqDzErEQbC49F4j9@tiehlicka> <CAGsJ_4z+iMXqJP68HQzbmkmWGHa-houPUKth=vbYgL=1OLV4Gg@mail.gmail.com>
 <ZqHr9OQPDVKr-1Cs@tiehlicka> <CAGsJ_4x+V8jVuM307uGUCXVrZTWGHNKHYqGsj6UAN=QH=yWpqw@mail.gmail.com>
In-Reply-To: <CAGsJ_4x+V8jVuM307uGUCXVrZTWGHNKHYqGsj6UAN=QH=yWpqw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Jul 2024 11:42:19 +0800
Message-ID: <CACGkMEs49KckODWSpe7VPfTeshogni0_eOdkMO0b7zW2A5YX2w@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] vpda: try to fix the potential crash due to
 misusing __GFP_NOFAIL
To: Barry Song <21cnbao@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	42.hyeyoo@gmail.com, cl@linux.com, hch@infradead.org, iamjoonsoo.kim@lge.com, 
	lstoakes@gmail.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com, 
	vbabka@suse.cz, virtualization@lists.linux.dev, hailong.liu@oppo.com, 
	torvalds@linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 3:00=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Thu, Jul 25, 2024 at 6:08=E2=80=AFPM Michal Hocko <mhocko@suse.com> wr=
ote:
> >
> > On Thu 25-07-24 10:50:45, Barry Song wrote:
> > > On Thu, Jul 25, 2024 at 12:27=E2=80=AFAM Michal Hocko <mhocko@suse.co=
m> wrote:
> > > >
> > > > On Wed 24-07-24 20:55:40, Barry Song wrote:
> > [...]
> > > > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/=
vdpa_user/iova_domain.c
> > > > > index 791d38d6284c..eff700e5f7a2 100644
> > > > > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > > > > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > > > > @@ -287,28 +287,44 @@ void vduse_domain_remove_user_bounce_pages(=
struct vduse_iova_domain *domain)
> > > > >  {
> > > > >       struct vduse_bounce_map *map;
> > > > >       unsigned long i, count;
> > > > > +     struct page **pages =3D NULL;
> > > > >
> > > > >       write_lock(&domain->bounce_lock);
> > > > >       if (!domain->user_bounce_pages)
> > > > >               goto out;
> > > > > -
> > > > >       count =3D domain->bounce_size >> PAGE_SHIFT;
> > > > > +     write_unlock(&domain->bounce_lock);
> > > > > +
> > > > > +     pages =3D kmalloc_array(count, sizeof(*pages), GFP_KERNEL |=
 __GFP_NOFAIL);
> > > > > +     for (i =3D 0; i < count; i++)
> > > > > +             pages[i] =3D alloc_page(GFP_KERNEL | __GFP_NOFAIL);
> > > >
> > > > AFAICS vduse_domain_release calls this function with
> > > > spin_lock(&domain->iotlb_lock) so dropping &domain->bounce_lock is =
not
> > > > sufficient.
> > >
> > > yes. this is true:
> > >
> > > static int vduse_domain_release(struct inode *inode, struct file *fil=
e)
> > > {
> > >         struct vduse_iova_domain *domain =3D file->private_data;
> > >
> > >         spin_lock(&domain->iotlb_lock);
> > >         vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
> > >         vduse_domain_remove_user_bounce_pages(domain);
> > >         vduse_domain_free_kernel_bounce_pages(domain);
> > >         spin_unlock(&domain->iotlb_lock);
> > >         put_iova_domain(&domain->stream_iovad);
> > >         put_iova_domain(&domain->consistent_iovad);
> > >         vhost_iotlb_free(domain->iotlb);
> > >         vfree(domain->bounce_maps);
> > >         kfree(domain);
> > >
> > >         return 0;
> > > }
> > >
> > > This is quite a pain. I admit I don't have knowledge of this driver, =
and I don't
> > > think it's safe to release two locks and then reacquire them. The sit=
uation is
> > > rather complex. Therefore, I would prefer if the VDPA maintainers cou=
ld
> > > take the lead in implementing a proper fix.
> >
> > Would it be possible to move all that work to a deferred context?
>
> My understanding is that we need to be aware of both the iotlb_lock and
> bounce_lock to implement the correct changes. As long as we still need
> to acquire these two locks in a deferred context, there doesn't seem to
> be any difference.
>
> I can do the memory pre-allocation before spin_lock(&domain->iotlb_lock),
> but I have no knowledge whether the "count" will change after I make
> the preallocation.
>
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c
> b/drivers/vdpa/vdpa_user/iova_domain.c
> index 791d38d6284c..7ec87ef33d42 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -544,9 +544,12 @@ static int vduse_domain_release(struct inode
> *inode, struct file *file)
>  {
>         struct vduse_iova_domain *domain =3D file->private_data;
>
> +      struct page **pages;
> +      spin_lock(&domain->iotlb_lock); maybe also + bounce_lock?
> +      count =3D domain->bounce_size >> PAGE_SHIFT;
> +      spin_unlock(&domain->iotlb_lock);

We probably don't need any lock here as bounce_size won't be changed .

> +
> +       preallocate_count_pages(pages, count);
> +
> ....
>         spin_lock(&domain->iotlb_lock);
>         vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
> -       vduse_domain_remove_user_bounce_pages(domain);
> +       vduse_domain_remove_user_bounce_pages(domain, pages);
>         vduse_domain_free_kernel_bounce_pages(domain);
>         spin_unlock(&domain->iotlb_lock);
>         put_iova_domain(&domain->stream_iovad);

This seems to work.

Thanks

>
>
> > --
> > Michal Hocko
> > SUSE Labs
>

