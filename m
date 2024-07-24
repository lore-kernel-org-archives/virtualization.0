Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF986F068
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 22:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721861459; cv=none; b=Sslx9h1CyrIvopeewX9zDEZHd8LT5bU3PzWiNYzSfOQB4cQ1/DCGUPfIifDKTb3DwpyzApq5K8gd2WSUFAWMG12s9yaEN1OkOKrA1ie4ksfVrgoDDC9ZxjcRMnmdhvW5wlf/CwUjZ6XguhCHdQfaw4+zhdquSBwN++OpPYYKPks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721861459; c=relaxed/simple;
	bh=1K5MJcPm110rs8Da7LAR7Z0e9o3tNycLUaSfAEfqCJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTmmCjRP8TMhlPOkd3WtSxh+aIl0B0XCDwDH7lpKd24rGZDiWIuU6984+wUl0JOxbcpfRthMcS/KpWVm2w7no4luNsa7zLGOCTLbJ7qyGjmT71Q54l4e/Ii8LHMeI86/k5A2Mo+aqwWaDzYCWHrT+hyZBZM3u0PbuCU0sJpIfqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lN8PrB+U; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lN8PrB+U"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4ef33a09a3aso108406e0c.2
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 15:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721861456; x=1722466256; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMTaZgYWcI6v49RBUgHrP21YAl60U14zeDcRc4tLOQQ=;
        b=lN8PrB+UBZVHc2FpyhKAMOiNbd8+9knIpy1KEsyO0CKAEg+1dj+nBa2jkD26kjblhO
         83fkSPlZcMewqhFYxbtOyI21m/QAoEQtG5/Ebcf1+KWB4Z6QwSgI4oJIa2ZZXt0VUTOv
         0FPw+8DqPXqPkfyDZTCkkDzepYFBU+UGdPzXx2067UvzGThLaYTIq17aKJ4ftJXfi7F6
         mNae/0vb/TpYcbcHIydgErmnQciQrw3wg+wdDJkjSIfEtSsXVThcO45OjKIYm7aF2CzD
         dsUzIeac64okGzDbnIIR9OKWlepqYSAxeScqv372yBLs5p7v9KI1MFZ5IC3o/M26kalo
         czMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721861456; x=1722466256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMTaZgYWcI6v49RBUgHrP21YAl60U14zeDcRc4tLOQQ=;
        b=YTxFK9E0ygF60ZQ11AmZRRPFjksyjirnpDsT8NoW32/9bPn1DN1tS8MkHnTXmmbUwp
         izkcyjvZRNlAYNtUumuTKDKAyHZqGjHO+mWKpmB/KZknYo2B54eyuLqH4W+jH7TsTVPr
         hmE/+caYhzkjUo1GGEAPsVCH/BDRN3DKKWbFNAX7b879ghIMBWUeFS4iptmSk8JoM2PH
         tHc3Tp7d9Mdb+HFJmJMQgg9ZFiGlNaqW8xCmjeIE2Ud/7rWAuTfXYRjxjaEX6ZRU0IGL
         Asj+LewQym7C5I1I4SHBu1afwpnqbO9RhVSsEUKvx34xhSSMoV7NgfTlUiE/TNzfvGSj
         mAYw==
X-Forwarded-Encrypted: i=1; AJvYcCWmZv+rpNaz8cklps8JFmMmQL+xzH+DZVyJauMB4mvizOPuLekQEvBWUBE+jIP45y7wcyFqfJfA1AefrR1YCSylQC08TnpRVzvH1EW6wjU=
X-Gm-Message-State: AOJu0Yy5BUS0Nw9aRolF2rtMr4l435VemGs+qcb75LYE3V6/oyTx6pEW
	9cjqb7knFvCFgOVWvvVgNNAXQNdcj74IWGbkqkaIgHwJ51yTqXk7yK9lt0rmS9fvLXXtj6D/hxv
	6nrqreIDWWvhw6VL0GiWqKee1NAQ=
X-Google-Smtp-Source: AGHT+IF11ECfDkrAOL26MJyjmT79+xLGDG/Ytj6Ei/EiKdAKawern86JaaIrL1JMNC/BLjFptc9iLr+X8AxXI9txLgo=
X-Received: by 2002:a05:6102:801a:b0:48f:48c0:4335 with SMTP id
 ada2fe7eead31-493d642b0a5mr1596957137.18.1721861456179; Wed, 24 Jul 2024
 15:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240724085544.299090-1-21cnbao@gmail.com> <20240724085544.299090-2-21cnbao@gmail.com>
 <ZqDzErEQbC49F4j9@tiehlicka>
In-Reply-To: <ZqDzErEQbC49F4j9@tiehlicka>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 25 Jul 2024 10:50:45 +1200
Message-ID: <CAGsJ_4z+iMXqJP68HQzbmkmWGHa-houPUKth=vbYgL=1OLV4Gg@mail.gmail.com>
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

On Thu, Jul 25, 2024 at 12:27=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Wed 24-07-24 20:55:40, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> > __GFP_NOFAIL without direct reclamation may just result in a busy
> > loop within non-sleepable contexts.
> >
> > static inline struct page *
> > __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> >                                                 struct alloc_context *a=
c)
> > {
> >         ...
> >         /*
> >          * Make sure that __GFP_NOFAIL request doesn't leak out and mak=
e sure
> >          * we always retry
> >          */
> >         if (gfp_mask & __GFP_NOFAIL) {
> >                 /*
> >                  * All existing users of the __GFP_NOFAIL are blockable=
, so warn
> >                  * of any new users that actually require GFP_NOWAIT
> >                  */
> >                 if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> >                         goto fail;
> >                 ...
> >         }
> >         ...
> > fail:
> >         warn_alloc(gfp_mask, ac->nodemask,
> >                         "page allocation failure: order:%u", order);
> > got_pg:
> >         return page;
> > }
> >
> > Let's move the memory allocation out of the atomic context and use
> > the normal sleepable context to get pages.
> >
> > [RFC]: This has only been compile-tested; I'd prefer if the VDPA mainta=
iners
> > handles it.
> >
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> > Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  drivers/vdpa/vdpa_user/iova_domain.c | 24 ++++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_u=
ser/iova_domain.c
> > index 791d38d6284c..eff700e5f7a2 100644
> > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > @@ -287,28 +287,44 @@ void vduse_domain_remove_user_bounce_pages(struct=
 vduse_iova_domain *domain)
> >  {
> >       struct vduse_bounce_map *map;
> >       unsigned long i, count;
> > +     struct page **pages =3D NULL;
> >
> >       write_lock(&domain->bounce_lock);
> >       if (!domain->user_bounce_pages)
> >               goto out;
> > -
> >       count =3D domain->bounce_size >> PAGE_SHIFT;
> > +     write_unlock(&domain->bounce_lock);
> > +
> > +     pages =3D kmalloc_array(count, sizeof(*pages), GFP_KERNEL | __GFP=
_NOFAIL);
> > +     for (i =3D 0; i < count; i++)
> > +             pages[i] =3D alloc_page(GFP_KERNEL | __GFP_NOFAIL);
>
> AFAICS vduse_domain_release calls this function with
> spin_lock(&domain->iotlb_lock) so dropping &domain->bounce_lock is not
> sufficient.

yes. this is true:

static int vduse_domain_release(struct inode *inode, struct file *file)
{
        struct vduse_iova_domain *domain =3D file->private_data;

        spin_lock(&domain->iotlb_lock);
        vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
        vduse_domain_remove_user_bounce_pages(domain);
        vduse_domain_free_kernel_bounce_pages(domain);
        spin_unlock(&domain->iotlb_lock);
        put_iova_domain(&domain->stream_iovad);
        put_iova_domain(&domain->consistent_iovad);
        vhost_iotlb_free(domain->iotlb);
        vfree(domain->bounce_maps);
        kfree(domain);

        return 0;
}

This is quite a pain. I admit I don't have knowledge of this driver, and I =
don't
think it's safe to release two locks and then reacquire them. The situation=
 is
rather complex. Therefore, I would prefer if the VDPA maintainers could
take the lead in implementing a proper fix.

>
> --
> Michal Hocko
> SUSE Labs

Thanks
Barry
