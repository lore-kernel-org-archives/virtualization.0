Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBEB190694
	for <virtualization@lists.linux.dev>; Wed,  7 Aug 2024 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013554; cv=none; b=Qn82RXW4VEVbDwGlTKWDzJTI5gU68Vj4vvsaWMfqNklgSKKulmnY4wZ7L/xZB2vMQ4JQLxKlDtwHb1oOyrcci5hDozENLvJvqZpDuM1rqQhT6UCp8w+dDdbUab5rnQKORz8CLH6FO5GgTiukCZWr75nzY261tUXByx1aWrVuK+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013554; c=relaxed/simple;
	bh=w2k/1GAk/8e3BZcu7LRZq57LRIyFylfLKs6FQXVsiYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4Nc/5LDzc+dRjHxkOmeMuNNPjR/EfyKOD6ORuRck59mNOSK5yT4uvIm4cc5e423ZuDleJ6WH6wG7VLQBvdHp1C5+LcHGVICjsjKNEmWyUhomzLycebUHkrYiKXtWVJW9YNVRKOnYE9RwD3xOJsw9l3/tICw6Vc6d1/GKoRpTOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=A4H5rhM/; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="A4H5rhM/"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d399da0b5so1171651b3a.3
        for <virtualization@lists.linux.dev>; Tue, 06 Aug 2024 23:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723013551; x=1723618351; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojZPHCizjT8+8LuseW1+ElDUzxljEVvHbFiBE43a/C8=;
        b=A4H5rhM/6wcHEEOOH7p+lil59gjHBoFySM8gJlVtLolx2BB1t0+2LXCu05SDRGxnPd
         wnWTqL6lDoQfWum0td/71ncks415MWUvKrnYYNvkLOjNcnODbZtW3z4GzvCX29Hp2cG+
         UPNmRF2M7VrqhmhDe55t8PYVy8UjO8Nmw5I3xDy9WK6wVeV6hPEhDo0CvtERv2HIJwAu
         9/gHMmEFkLO2+QUhK2QqdIljp2lm3vSjMw5EWl/o1m3u5V/KTi+fzou4KLMuvf1vtYEy
         rRtAOy1QzSIfTIxgi1uxJQXsfwRiXEuf4052HOhG3z4zidaLav9RhdPvlrb7fajg3aei
         6X4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723013551; x=1723618351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojZPHCizjT8+8LuseW1+ElDUzxljEVvHbFiBE43a/C8=;
        b=NNHVGWn/HNOnQbR1R/k/T9raHn6+Vg+iCIwtndE1gqnWrooubNE5JMufYuqK/mwHUx
         qcpAEgzxsSU4KU6oOxir0ZVgxIACLsl7zhwDk3n7iqAGDzxMZG50IYis4RWCmMrSac2W
         ILaBmYxW8J2YPGgaOiEhJT2+GEg4rpKwM9MnB0aMShJLZ0oY5VfnVcUZK6XLtLoT5JrV
         3Bba/bZ1w08xgPLy5etTetQKDb1wkcojohRFjc+Kqd9zXUaRWbLzdUykZLW9q4sfq1Iy
         ZNUtp2U7Rzyet75Neuj8rcLuVAzuXyOsHAfEnBZfUfuPHAFLtMikGSAkGaIuVV162V1L
         ug+w==
X-Forwarded-Encrypted: i=1; AJvYcCXmKTDuc2tV7osUE8pRgy1Xhfi65k36lCq9+UhlD0sNDJoJSsIreczZRe09ZbvMXBXhZB9AYDUSJAQxE8Go+/+43AxGg3WFiUHKWC8DiXo=
X-Gm-Message-State: AOJu0YzDQmUAPcLKmCBGJLHwamrKMdL4I9qzWge/QgaY/gLiKrpPjcQs
	wTqJxaYbMgYwTZxnDxNwJ14wJ1EugQQEcyCsAJEWFl8hEgqxCnp/de2sIy3+jULNHftX/Nj6bf6
	mUPL5dRt4eFIAM7r74/n7niiayOap+jiBkqie
X-Google-Smtp-Source: AGHT+IETt1KM8mTnwNBX/+Qs7S9wNiln513XQSwOOCU5mmeBIz6oHmWu32ViLfcmLt4UwTl+aQsEffppahddkuy8SIg=
X-Received: by 2002:a05:6a21:38b:b0:1c0:f77e:2521 with SMTP id
 adf61e73a8af0-1c69958230emr22419273637.19.1723013550618; Tue, 06 Aug 2024
 23:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com>
In-Reply-To: <20240805082106.65847-1-jasowang@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 7 Aug 2024 14:52:19 +0800
Message-ID: <CACycT3uM1jSdqFT0LGqy1zXZkWF8BNQN=8EMKYMoyP_wjRtsng@mail.gmail.com>
Subject: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel <linux-kernel@vger.kernel.org>, 
	21cnbao@gmail.com, penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> Barry said [1]:
>
> """
> mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> __GFP_NOFAIL without direct reclamation may just result in a busy
> loop within non-sleepable contexts.
> ""=E2=80=9C
>
> Unfortuantely, we do that under read lock. A possible way to fix that
> is to move the pages allocation out of the lock into the caller, but
> having to allocate a huge number of pages and auxiliary page array
> seems to be problematic as well per Tetsuon [2]:
>
> """
> You should implement proper error handling instead of using
> __GFP_NOFAIL if count can become large.
> """
>
> So I choose another way, which does not release kernel bounce pages
> when user tries to register usersapce bounce pages. Then we don't need
> to do allocation in the path which is not expected to be fail (e.g in
> the release). We pay this for more memory usage but further
> optimizations could be done on top.
>
> [1] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2sa=
LnUdfOGOLg@mail.gmail.com/T/#m3caef86a66ea6318ef94f9976ddb3a0ccfe6fcf8
> [2] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2sa=
LnUdfOGOLg@mail.gmail.com/T/#m7ad10eaba48ade5abf2d572f24e185d9fb146480
>
> Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bounce buff=
er")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
Tested-by: Xie Yongji <xieyongji@bytedance.com>

Have tested it with qemu-storage-daemon [1]:

$ qemu-storage-daemon \
    --chardev socket,id=3Dcharmonitor,path=3D/tmp/qmp.sock,server=3Don,wait=
=3Doff \
    --monitor chardev=3Dcharmonitor \
    --blockdev driver=3Dhost_device,cache.direct=3Don,aio=3Dnative,filename=
=3D/dev/nullb0,node-name=3Ddisk0
\
    --export type=3Dvduse-blk,id=3Dvduse-test,name=3Dvduse-test,node-name=
=3Ddisk0,writable=3Don

[1] https://github.com/bytedance/qemu/tree/vduse-umem

>  drivers/vdpa/vdpa_user/iova_domain.c | 18 ++++++++++--------
>  drivers/vdpa/vdpa_user/iova_domain.h |  1 +
>  2 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_use=
r/iova_domain.c
> index 791d38d6284c..933d2f7cd49a 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -162,6 +162,7 @@ static void vduse_domain_bounce(struct vduse_iova_dom=
ain *domain,
>                                 enum dma_data_direction dir)
>  {
>         struct vduse_bounce_map *map;
> +       struct page *page;
>         unsigned int offset;
>         void *addr;
>         size_t sz;
> @@ -178,7 +179,10 @@ static void vduse_domain_bounce(struct vduse_iova_do=
main *domain,
>                             map->orig_phys =3D=3D INVALID_PHYS_ADDR))
>                         return;
>
> -               addr =3D kmap_local_page(map->bounce_page);
> +               page =3D domain->user_bounce_pages ?
> +                      map->user_bounce_page : map->bounce_page;
> +
> +               addr =3D kmap_local_page(page);
>                 do_bounce(map->orig_phys + offset, addr + offset, sz, dir=
);
>                 kunmap_local(addr);
>                 size -=3D sz;
> @@ -270,9 +274,8 @@ int vduse_domain_add_user_bounce_pages(struct vduse_i=
ova_domain *domain,
>                                 memcpy_to_page(pages[i], 0,
>                                                page_address(map->bounce_p=
age),
>                                                PAGE_SIZE);
> -                       __free_page(map->bounce_page);
>                 }
> -               map->bounce_page =3D pages[i];
> +               map->user_bounce_page =3D pages[i];
>                 get_page(pages[i]);
>         }
>         domain->user_bounce_pages =3D true;
> @@ -297,17 +300,16 @@ void vduse_domain_remove_user_bounce_pages(struct v=
duse_iova_domain *domain)
>                 struct page *page =3D NULL;
>
>                 map =3D &domain->bounce_maps[i];
> -               if (WARN_ON(!map->bounce_page))
> +               if (WARN_ON(!map->user_bounce_page))
>                         continue;
>
>                 /* Copy user page to kernel page if it's in use */
>                 if (map->orig_phys !=3D INVALID_PHYS_ADDR) {
> -                       page =3D alloc_page(GFP_ATOMIC | __GFP_NOFAIL);
> +                       page =3D map->bounce_page;
>                         memcpy_from_page(page_address(page),
> -                                        map->bounce_page, 0, PAGE_SIZE);
> +                                        map->user_bounce_page, 0, PAGE_S=
IZE);
>                 }
> -               put_page(map->bounce_page);
> -               map->bounce_page =3D page;
> +               put_page(map->user_bounce_page);

map->user_bounce_page =3D NULL?

Thanks,
Yongji
