Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B68014F70
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 03:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722395411; cv=none; b=s4m8jlo6VuGa5rOr2SPFBqWG4IMbpTGPfJTzfwcRb4PgGt/REHCHKQxQlXdr9D7JaVDwgPcBVFPmp1tCj/oFZglsJQDaKfK2eBi+cCTpWYdIBPDso8JhvXh7MDINVEE6e8eha8N+MwbXSXE/n9nPrOKqUmRAWE3bb6F02Rdmpwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722395411; c=relaxed/simple;
	bh=bzo9XoNddaulYVj+cJMR67idCtO6Y3sTbr521E7W+zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwOoOeF3FOdre/7uue+FIMt968dGTKwQdDOS6cgHFYW9rdZNCC6HYRzh0x89fdW+Six/plUXIWKuN1AtXylWBAkR/mXQ6ZRkgI37mqIfdo3iv/6HcuM/DLL//qaZuhyUImHBnw5XY89AezqfrgZzwntQWdmL6EOad8ELYBAk3p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0ls/Hev; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0ls/Hev"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722395409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nSo48UaFOj/kTMd8oGeDzJEPDqXHyMwals+M5vQ2bEM=;
	b=Z0ls/HevLqxdlUQyJ+xKumDCqxOnslMmitarZB2C3rV1xHC7Re8zFfdQ0AUX+juqHC3PxJ
	6xCzi/SIdIrbhh6fUwKDT1iPqjCSAf2Ktnz2GZC6UkGJCcPmVENXQpkPfGqv2o/VUN2IrW
	ARjqpiXWnH9XPn6ev4LFow9tmW+GvIA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-iTcz8WBLMBGfZkcFhMnhsQ-1; Tue, 30 Jul 2024 23:10:06 -0400
X-MC-Unique: iTcz8WBLMBGfZkcFhMnhsQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-70d1469f5e1so4296463b3a.3
        for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 20:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722395406; x=1723000206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSo48UaFOj/kTMd8oGeDzJEPDqXHyMwals+M5vQ2bEM=;
        b=qOXffGb46t9IR9rEUq89J39Vz//RKVTwX/eSTjE4Q+NVDKuGaihGkCQ8djvtN8SK5m
         J6JdNl9ntFV60lFkrvAIpivpLu3kGjadY6oYMJJWfrSg4ch8xBFNNLywzlEXUd7TUFDX
         5e2q8V0APIeJlKD0mCP2Z0q3HmlDhYa6DGh51DF4Ox5YpohGK5JEyX6k631lEr1WNbLH
         3zowA5AMt6dp9Nf8ip+2J10/WzxcuG/eeipkuUAgfL7TDCESFZ2culi0xAIaOQTO9FPB
         TGCgeHL6F6+Ox7TfT3nYall9TsnrV8mT8Nc9nas8Lv6/I6c5Q1UPXVmXWsuJJCxkYz5n
         bSsg==
X-Forwarded-Encrypted: i=1; AJvYcCVRVcctSPpj4XCkNGKGku6OfXgLf9cnK2OpC/VqK3G+EjJlkGLZhi+16b6rvPSeNCy9Wt9s5FyuAI5Drytw63+sMkY6/l7DIqFgqd8SfWw=
X-Gm-Message-State: AOJu0Yxxs4DABNLcCrUnt3fzMkD/EDAaQ7APFDjjnoKgHT2qwGLHkO7U
	fQOCZok/Qzlh0vAyPBoTEowYGzqZKSADlrLgBXplzEnhgrYLe0UL+FYUBG+WpRBBbtgAEGAmBG+
	MJQl5fw7lu6VSTbzimKWEmkAtVdoUVIuNHkNXGqiM8yrtsCZs8uI7qBYg8xW8OxkeerFV9NUU64
	PTFUJMoYDmAtCGMZ0576prWafMMc4A4GXkruXncFk=
X-Received: by 2002:a05:6a20:6a10:b0:1c4:7dbc:d1df with SMTP id adf61e73a8af0-1c4a1304e68mr12894368637.23.1722395405937;
        Tue, 30 Jul 2024 20:10:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwoxIVmHqmhZziJyujWvdgIDRJa8pIwCmen71oTQovcyKvcve4LM+EBaMx2x12gJB9N4v31nmZK6Lc0waiTn4=
X-Received: by 2002:a05:6a20:6a10:b0:1c4:7dbc:d1df with SMTP id
 adf61e73a8af0-1c4a1304e68mr12894336637.23.1722395405471; Tue, 30 Jul 2024
 20:10:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240731000155.109583-1-21cnbao@gmail.com> <20240731000155.109583-2-21cnbao@gmail.com>
In-Reply-To: <20240731000155.109583-2-21cnbao@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jul 2024 11:09:54 +0800
Message-ID: <CACGkMEsZPBbQfh+kyjn0nFb76Ad8_o=CXxD2hJt5fxoPa3rhvA@mail.gmail.com>
Subject: Re: [PATCH RFT v2 1/4] vpda: try to fix the potential crash due to
 misusing __GFP_NOFAIL
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com, 
	cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com, 
	lstoakes@gmail.com, mhocko@suse.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, torvalds@linux-foundation.org, urezki@gmail.com, 
	v-songbaohua@oppo.com, vbabka@suse.cz, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 8:03=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> __GFP_NOFAIL without direct reclamation may just result in a busy
> loop within non-sleepable contexts.
>
> static inline struct page *
> __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>                                                 struct alloc_context *ac)
> {
>         ...
>         /*
>          * Make sure that __GFP_NOFAIL request doesn't leak out and make =
sure
>          * we always retry
>          */
>         if (gfp_mask & __GFP_NOFAIL) {
>                 /*
>                  * All existing users of the __GFP_NOFAIL are blockable, =
so warn
>                  * of any new users that actually require GFP_NOWAIT
>                  */
>                 if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
>                         goto fail;
>                 ...
>         }
>         ...
> fail:
>         warn_alloc(gfp_mask, ac->nodemask,
>                         "page allocation failure: order:%u", order);
> got_pg:
>         return page;
> }
>
> Let's move the memory allocation out of the atomic context and use
> the normal sleepable context to get pages.
>
> [RFT]: This has only been compile-tested; I'd prefer if the VDPA maintain=
ers
> handles it.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  drivers/vdpa/vdpa_user/iova_domain.c | 31 +++++++++++++++++++++++-----
>  drivers/vdpa/vdpa_user/iova_domain.h |  5 ++++-
>  drivers/vdpa/vdpa_user/vduse_dev.c   |  4 +++-
>  3 files changed, 33 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_use=
r/iova_domain.c
> index 791d38d6284c..9318f059a8b5 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -283,7 +283,23 @@ int vduse_domain_add_user_bounce_pages(struct vduse_=
iova_domain *domain,
>         return ret;
>  }
>
> -void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *dom=
ain)
> +struct page **vduse_domain_alloc_pages_to_remove_bounce(struct vduse_iov=
a_domain *domain)
> +{
> +       struct page **pages;
> +       unsigned long count, i;
> +
> +       if (!domain->user_bounce_pages)
> +               return NULL;
> +
> +       count =3D domain->bounce_size >> PAGE_SHIFT;
> +       pages =3D kmalloc_array(count, sizeof(*pages), GFP_KERNEL | __GFP=
_NOFAIL);
> +       for (i =3D 0; i < count; i++)
> +               pages[i] =3D alloc_page(GFP_KERNEL | __GFP_NOFAIL);
> +
> +       return pages;
> +}
> +
> +void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *dom=
ain, struct page **pages)
>  {
>         struct vduse_bounce_map *map;
>         unsigned long i, count;
> @@ -294,15 +310,16 @@ void vduse_domain_remove_user_bounce_pages(struct v=
duse_iova_domain *domain)
>
>         count =3D domain->bounce_size >> PAGE_SHIFT;
>         for (i =3D 0; i < count; i++) {
> -               struct page *page =3D NULL;
> +               struct page *page =3D pages[i];
>
>                 map =3D &domain->bounce_maps[i];
> -               if (WARN_ON(!map->bounce_page))
> +               if (WARN_ON(!map->bounce_page)) {
> +                       put_page(page);
>                         continue;
> +               }
>
>                 /* Copy user page to kernel page if it's in use */
>                 if (map->orig_phys !=3D INVALID_PHYS_ADDR) {
> -                       page =3D alloc_page(GFP_ATOMIC | __GFP_NOFAIL);
>                         memcpy_from_page(page_address(page),
>                                          map->bounce_page, 0, PAGE_SIZE);
>                 }
> @@ -310,6 +327,7 @@ void vduse_domain_remove_user_bounce_pages(struct vdu=
se_iova_domain *domain)
>                 map->bounce_page =3D page;
>         }
>         domain->user_bounce_pages =3D false;
> +       kfree(pages);
>  out:
>         write_unlock(&domain->bounce_lock);
>  }
> @@ -543,10 +561,13 @@ static int vduse_domain_mmap(struct file *file, str=
uct vm_area_struct *vma)
>  static int vduse_domain_release(struct inode *inode, struct file *file)
>  {
>         struct vduse_iova_domain *domain =3D file->private_data;
> +       struct page **pages;
> +
> +       pages =3D vduse_domain_alloc_pages_to_remove_bounce(domain);
>
>         spin_lock(&domain->iotlb_lock);
>         vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
> -       vduse_domain_remove_user_bounce_pages(domain);
> +       vduse_domain_remove_user_bounce_pages(domain, pages);
>         vduse_domain_free_kernel_bounce_pages(domain);
>         spin_unlock(&domain->iotlb_lock);
>         put_iova_domain(&domain->stream_iovad);
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_use=
r/iova_domain.h
> index f92f22a7267d..17efa5555b3f 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.h
> +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> @@ -74,7 +74,10 @@ void vduse_domain_reset_bounce_map(struct vduse_iova_d=
omain *domain);
>  int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
>                                        struct page **pages, int count);
>
> -void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *dom=
ain);
> +void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *dom=
ain,
> +                                          struct page **pages);
> +
> +struct page **vduse_domain_alloc_pages_to_remove_bounce(struct vduse_iov=
a_domain *domain);
>
>  void vduse_domain_destroy(struct vduse_iova_domain *domain);
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 7ae99691efdf..5d8d5810df57 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1030,6 +1030,7 @@ static int vduse_dev_queue_irq_work(struct vduse_de=
v *dev,
>  static int vduse_dev_dereg_umem(struct vduse_dev *dev,
>                                 u64 iova, u64 size)
>  {
> +       struct page **pages;
>         int ret;
>
>         mutex_lock(&dev->mem_lock);
> @@ -1044,7 +1045,8 @@ static int vduse_dev_dereg_umem(struct vduse_dev *d=
ev,
>         if (dev->umem->iova !=3D iova || size !=3D dev->domain->bounce_si=
ze)
>                 goto unlock;
>
> -       vduse_domain_remove_user_bounce_pages(dev->domain);
> +       pages =3D vduse_domain_alloc_pages_to_remove_bounce(dev->domain);
> +       vduse_domain_remove_user_bounce_pages(dev->domain, pages);
>         unpin_user_pages_dirty_lock(dev->umem->pages,
>                                     dev->umem->npages, true);
>         atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);

We miss a kfree(pages); here?

Thanks

> --
> 2.34.1
>

