Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2EB2905
	for <virtualization@lists.linux.dev>; Thu, 14 Nov 2024 20:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731617434; cv=none; b=LGGs9TqFvDXRBol6s2O7ky355owWgvjMzEIqtRM/v6UCUPCXEQmP0PEPp+KudobICxzEtl25Ap7vSPiHdtBX8wFBpAzV5+OH67eTXXHYmT3aP/XZ13aPmddYffEz9zbrv2PTKLEXydrHZDC2LfvKM+bx4A/paY8sbGW6v/w3c+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731617434; c=relaxed/simple;
	bh=qJXzf2vRFOyNQIqTcX5qlowYo35OoHYYaamsOES44k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmZkzhYk5i+fEdXjX2rDlCyorGByO8tFINvmWLbVTdRw96P9j/2GahKYSpgx2nE1mxRMwkXi/z4LJlEi7q5LWTjsMKfPHWSveZBGCyxgzBrpka4V0epWSadKQ1wSG0uKpY9Nsl36Z6PjAfFcS6kDxD2mCagPt6a8odg9OQOAaK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Au3TNf/s; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Au3TNf/s"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e52582d28so83887b3a.1
        for <virtualization@lists.linux.dev>; Thu, 14 Nov 2024 12:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731617432; x=1732222232; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4xaN8JSe6Va0doXW+0XytL+AzQE3uddoyG06KCRhBk=;
        b=Au3TNf/svn/9n3vTfdqCPBNSbgAiP5DnBPGF5S3yoJFG96wl0u1RweMIKJt8N+Uh91
         HReqJ1LqSjqvtHjtPhaEys5atsrfLibi3I293It4QH6Tj7zXA1DLIWAUu5hfdxRieVdi
         169p8RTmY/q20UYMvBJa21IIc+vAYIutKfDBppJFZYui+Juz45gnPIBvRuMC/MRqIAfV
         yXLNRX8f6I+nGW3YtsxaRf1Act8HCrPArOskeIMuJjXi8qhbXFbg2El3gFwFhVR+8oUU
         kDgtiOQmRxf7FexnT3yIbajU5RuvNJc4qna9W+MjcjdKQHE2k0wTYo9c29bqchxMRa4G
         vFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731617432; x=1732222232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4xaN8JSe6Va0doXW+0XytL+AzQE3uddoyG06KCRhBk=;
        b=oiBEf19gHOvNvBZTBH7DWXJOIuFWK2e3BR9CfCf/Bs+g+xLx+Mdy3j7zSF7ktSFduL
         +at9v3eWb7+KMPCzfhGTmoWdRjyHe+CDg5OqBITqGkWyf5+4cg/0aGhZ/R9y7875Hgc5
         BjwpyaHLuaM8GpIhmFckVfIu0JT7PQxxOR/yYhcc/wJQ4lk9FpKQfB2i2zqQ/6Dbq7S9
         zVgw3EzSvJBQIwpp64RXlRURdQeR+KudHcp1HLbznmbHQaRAlTaeP5GZxJiCbr60sqkw
         AbcTH0Fj6pOIMHG85bruQTidJ8Bl6FZgftbUu14msAzQKWn1Tg6TG+xYGF6O76BZLTK6
         cbLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMxBn+DHhapOtWT5dM45ywxvnSfqzQD3aTmS7XSiK+VHpeTXxkAuryy++G9OVjnc2+1uk961O2l6lqrI5JHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZ4/8Xz/yGVzAtrNzEJhgkgQfomsB/KrZrxo4k534SKkVf/dDk
	xSaEU+T1te5fkUjsHieMox3/uo52p04Br7CKdmnJcRpCIh7BMsiQ2OKnDZNWwDdKc2Su1ZDv6oo
	27U7S6lLcsiiEj4GIV6gEN29FiH8=
X-Google-Smtp-Source: AGHT+IF8yYoHBcrZWt4GzM+ysw0POg0ICb/9yRrQudN3/9O7gkblsoI/jWuKP/Ss/tkhSCXhiUTmUCcW1yHV19wPp94=
X-Received: by 2002:a05:6a00:4fd6:b0:720:2f5b:495d with SMTP id
 d2e1a72fcca58-72476b78565mr164925b3a.2.1731617431413; Thu, 14 Nov 2024
 12:50:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241114153020.6209-1-christian.koenig@amd.com> <20241114153020.6209-2-christian.koenig@amd.com>
In-Reply-To: <20241114153020.6209-2-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Nov 2024 15:50:18 -0500
Message-ID: <CADnq5_Mtc3oyRwNOb8+aTCJTQa2BeSDdxy6P+YZpFWkZc7KLeQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] drm/radeon: switch over to drm_exec v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kraxel@redhat.com, airlied@redhat.com, alexander.deucher@amd.com, 
	zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 10:30=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Just a straightforward conversion without any optimization.
>
> Smoke tested on actual hardware.
>
> v2: rebase
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/radeon/Kconfig         |  1 +
>  drivers/gpu/drm/radeon/radeon.h        |  7 ++--
>  drivers/gpu/drm/radeon/radeon_cs.c     | 45 +++++++++++++-------------
>  drivers/gpu/drm/radeon/radeon_gem.c    | 39 ++++++++++++----------
>  drivers/gpu/drm/radeon/radeon_object.c | 25 +++++++-------
>  drivers/gpu/drm/radeon/radeon_object.h |  2 +-
>  drivers/gpu/drm/radeon/radeon_vm.c     | 10 +++---
>  7 files changed, 66 insertions(+), 63 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/Kconfig b/drivers/gpu/drm/radeon/Kcon=
fig
> index 9c6c74a75778..f51bace9555d 100644
> --- a/drivers/gpu/drm/radeon/Kconfig
> +++ b/drivers/gpu/drm/radeon/Kconfig
> @@ -13,6 +13,7 @@ config DRM_RADEON
>          select DRM_TTM
>         select DRM_TTM_HELPER
>         select FB_IOMEM_HELPERS if DRM_FBDEV_EMULATION
> +       select DRM_EXEC
>         select SND_HDA_COMPONENT if SND_HDA_CORE
>         select POWER_SUPPLY
>         select HWMON
> diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/rad=
eon.h
> index fd8a4513025f..8605c074d9f7 100644
> --- a/drivers/gpu/drm/radeon/radeon.h
> +++ b/drivers/gpu/drm/radeon/radeon.h
> @@ -75,8 +75,8 @@
>
>  #include <drm/ttm/ttm_bo.h>
>  #include <drm/ttm/ttm_placement.h>
> -#include <drm/ttm/ttm_execbuf_util.h>
>
> +#include <drm/drm_exec.h>
>  #include <drm/drm_gem.h>
>  #include <drm/drm_audio_component.h>
>  #include <drm/drm_suballoc.h>
> @@ -457,7 +457,8 @@ struct radeon_mman {
>
>  struct radeon_bo_list {
>         struct radeon_bo                *robj;
> -       struct ttm_validate_buffer      tv;
> +       struct list_head                list;
> +       bool                            shared;
>         uint64_t                        gpu_offset;
>         unsigned                        preferred_domains;
>         unsigned                        allowed_domains;
> @@ -1030,6 +1031,7 @@ struct radeon_cs_parser {
>         struct radeon_bo_list   *vm_bos;
>         struct list_head        validated;
>         unsigned                dma_reloc_idx;
> +       struct drm_exec         exec;
>         /* indices of various chunks */
>         struct radeon_cs_chunk  *chunk_ib;
>         struct radeon_cs_chunk  *chunk_relocs;
> @@ -1043,7 +1045,6 @@ struct radeon_cs_parser {
>         u32                     cs_flags;
>         u32                     ring;
>         s32                     priority;
> -       struct ww_acquire_ctx   ticket;
>  };
>
>  static inline u32 radeon_get_ib_value(struct radeon_cs_parser *p, int id=
x)
> diff --git a/drivers/gpu/drm/radeon/radeon_cs.c b/drivers/gpu/drm/radeon/=
radeon_cs.c
> index a6700d7278bf..64b26bfeafc9 100644
> --- a/drivers/gpu/drm/radeon/radeon_cs.c
> +++ b/drivers/gpu/drm/radeon/radeon_cs.c
> @@ -182,11 +182,8 @@ static int radeon_cs_parser_relocs(struct radeon_cs_=
parser *p)
>                         }
>                 }
>
> -               p->relocs[i].tv.bo =3D &p->relocs[i].robj->tbo;
> -               p->relocs[i].tv.num_shared =3D !r->write_domain;
> -
> -               radeon_cs_buckets_add(&buckets, &p->relocs[i].tv.head,
> -                                     priority);
> +               p->relocs[i].shared =3D !r->write_domain;
> +               radeon_cs_buckets_add(&buckets, &p->relocs[i].list, prior=
ity);
>         }
>
>         radeon_cs_buckets_get_list(&buckets, &p->validated);
> @@ -197,7 +194,7 @@ static int radeon_cs_parser_relocs(struct radeon_cs_p=
arser *p)
>         if (need_mmap_lock)
>                 mmap_read_lock(current->mm);
>
> -       r =3D radeon_bo_list_validate(p->rdev, &p->ticket, &p->validated,=
 p->ring);
> +       r =3D radeon_bo_list_validate(p->rdev, &p->exec, &p->validated, p=
->ring);
>
>         if (need_mmap_lock)
>                 mmap_read_unlock(current->mm);
> @@ -253,12 +250,11 @@ static int radeon_cs_sync_rings(struct radeon_cs_pa=
rser *p)
>         struct radeon_bo_list *reloc;
>         int r;
>
> -       list_for_each_entry(reloc, &p->validated, tv.head) {
> +       list_for_each_entry(reloc, &p->validated, list) {
>                 struct dma_resv *resv;
>
>                 resv =3D reloc->robj->tbo.base.resv;
> -               r =3D radeon_sync_resv(p->rdev, &p->ib.sync, resv,
> -                                    reloc->tv.num_shared);
> +               r =3D radeon_sync_resv(p->rdev, &p->ib.sync, resv, reloc-=
>shared);
>                 if (r)
>                         return r;
>         }
> @@ -276,6 +272,7 @@ int radeon_cs_parser_init(struct radeon_cs_parser *p,=
 void *data)
>         s32 priority =3D 0;
>
>         INIT_LIST_HEAD(&p->validated);
> +       drm_exec_init(&p->exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
>
>         if (!cs->num_chunks) {
>                 return 0;
> @@ -397,8 +394,8 @@ int radeon_cs_parser_init(struct radeon_cs_parser *p,=
 void *data)
>  static int cmp_size_smaller_first(void *priv, const struct list_head *a,
>                                   const struct list_head *b)
>  {
> -       struct radeon_bo_list *la =3D list_entry(a, struct radeon_bo_list=
, tv.head);
> -       struct radeon_bo_list *lb =3D list_entry(b, struct radeon_bo_list=
, tv.head);
> +       struct radeon_bo_list *la =3D list_entry(a, struct radeon_bo_list=
, list);
> +       struct radeon_bo_list *lb =3D list_entry(b, struct radeon_bo_list=
, list);
>
>         /* Sort A before B if A is smaller. */
>         if (la->robj->tbo.base.size > lb->robj->tbo.base.size)
> @@ -417,11 +414,13 @@ static int cmp_size_smaller_first(void *priv, const=
 struct list_head *a,
>   * If error is set than unvalidate buffer, otherwise just free memory
>   * used by parsing context.
>   **/
> -static void radeon_cs_parser_fini(struct radeon_cs_parser *parser, int e=
rror, bool backoff)
> +static void radeon_cs_parser_fini(struct radeon_cs_parser *parser, int e=
rror)
>  {
>         unsigned i;
>
>         if (!error) {
> +               struct radeon_bo_list *reloc;
> +
>                 /* Sort the buffer list from the smallest to largest buff=
er,
>                  * which affects the order of buffers in the LRU list.
>                  * This assures that the smallest buffers are added first
> @@ -433,15 +432,17 @@ static void radeon_cs_parser_fini(struct radeon_cs_=
parser *parser, int error, bo
>                  * per frame under memory pressure.
>                  */
>                 list_sort(NULL, &parser->validated, cmp_size_smaller_firs=
t);
> -
> -               ttm_eu_fence_buffer_objects(&parser->ticket,
> -                                           &parser->validated,
> -                                           &parser->ib.fence->base);
> -       } else if (backoff) {
> -               ttm_eu_backoff_reservation(&parser->ticket,
> -                                          &parser->validated);
> +               list_for_each_entry(reloc, &parser->validated, list) {
> +                       dma_resv_add_fence(reloc->robj->tbo.base.resv,
> +                                          &parser->ib.fence->base,
> +                                          reloc->shared ?
> +                                          DMA_RESV_USAGE_READ :
> +                                          DMA_RESV_USAGE_WRITE);
> +               }
>         }
>
> +       drm_exec_fini(&parser->exec);
> +
>         if (parser->relocs !=3D NULL) {
>                 for (i =3D 0; i < parser->nrelocs; i++) {
>                         struct radeon_bo *bo =3D parser->relocs[i].robj;
> @@ -693,7 +694,7 @@ int radeon_cs_ioctl(struct drm_device *dev, void *dat=
a, struct drm_file *filp)
>         r =3D radeon_cs_parser_init(&parser, data);
>         if (r) {
>                 DRM_ERROR("Failed to initialize parser !\n");
> -               radeon_cs_parser_fini(&parser, r, false);
> +               radeon_cs_parser_fini(&parser, r);
>                 up_read(&rdev->exclusive_lock);
>                 r =3D radeon_cs_handle_lockup(rdev, r);
>                 return r;
> @@ -707,7 +708,7 @@ int radeon_cs_ioctl(struct drm_device *dev, void *dat=
a, struct drm_file *filp)
>         }
>
>         if (r) {
> -               radeon_cs_parser_fini(&parser, r, false);
> +               radeon_cs_parser_fini(&parser, r);
>                 up_read(&rdev->exclusive_lock);
>                 r =3D radeon_cs_handle_lockup(rdev, r);
>                 return r;
> @@ -724,7 +725,7 @@ int radeon_cs_ioctl(struct drm_device *dev, void *dat=
a, struct drm_file *filp)
>                 goto out;
>         }
>  out:
> -       radeon_cs_parser_fini(&parser, r, true);
> +       radeon_cs_parser_fini(&parser, r);
>         up_read(&rdev->exclusive_lock);
>         r =3D radeon_cs_handle_lockup(rdev, r);
>         return r;
> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon=
/radeon_gem.c
> index bf2d4b16dc2a..f86773f3db20 100644
> --- a/drivers/gpu/drm/radeon/radeon_gem.c
> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> @@ -605,33 +605,40 @@ int radeon_gem_get_tiling_ioctl(struct drm_device *=
dev, void *data,
>  static void radeon_gem_va_update_vm(struct radeon_device *rdev,
>                                     struct radeon_bo_va *bo_va)
>  {
> -       struct ttm_validate_buffer tv, *entry;
> -       struct radeon_bo_list *vm_bos;
> -       struct ww_acquire_ctx ticket;
> +       struct radeon_bo_list *vm_bos, *entry;
>         struct list_head list;
> +       struct drm_exec exec;
>         unsigned domain;
>         int r;
>
>         INIT_LIST_HEAD(&list);
>
> -       tv.bo =3D &bo_va->bo->tbo;
> -       tv.num_shared =3D 1;
> -       list_add(&tv.head, &list);
> -
>         vm_bos =3D radeon_vm_get_bos(rdev, bo_va->vm, &list);
>         if (!vm_bos)
>                 return;
>
> -       r =3D ttm_eu_reserve_buffers(&ticket, &list, true, NULL);
> -       if (r)
> -               goto error_free;
> +       drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +       drm_exec_until_all_locked(&exec) {
> +               list_for_each_entry(entry, &list, list) {
> +                       r =3D drm_exec_prepare_obj(&exec, &entry->robj->t=
bo.base,
> +                                                1);
> +                       drm_exec_retry_on_contention(&exec);
> +                       if (unlikely(r))
> +                               goto error_cleanup;
> +               }
>
> -       list_for_each_entry(entry, &list, head) {
> -               domain =3D radeon_mem_type_to_domain(entry->bo->resource-=
>mem_type);
> +               r =3D drm_exec_prepare_obj(&exec, &bo_va->bo->tbo.base, 1=
);
> +               drm_exec_retry_on_contention(&exec);
> +               if (unlikely(r))
> +                       goto error_cleanup;
> +       }
> +
> +       list_for_each_entry(entry, &list, list) {
> +               domain =3D radeon_mem_type_to_domain(entry->robj->tbo.res=
ource->mem_type);
>                 /* if anything is swapped out don't swap it in here,
>                    just abort and wait for the next CS */
>                 if (domain =3D=3D RADEON_GEM_DOMAIN_CPU)
> -                       goto error_unreserve;
> +                       goto error_cleanup;
>         }
>
>         mutex_lock(&bo_va->vm->mutex);
> @@ -645,10 +652,8 @@ static void radeon_gem_va_update_vm(struct radeon_de=
vice *rdev,
>  error_unlock:
>         mutex_unlock(&bo_va->vm->mutex);
>
> -error_unreserve:
> -       ttm_eu_backoff_reservation(&ticket, &list);
> -
> -error_free:
> +error_cleanup:
> +       drm_exec_fini(&exec);
>         kvfree(vm_bos);
>
>         if (r && r !=3D -ERESTARTSYS)
> diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/rad=
eon/radeon_object.c
> index 7672404fdb29..a0fc0801abb0 100644
> --- a/drivers/gpu/drm/radeon/radeon_object.c
> +++ b/drivers/gpu/drm/radeon/radeon_object.c
> @@ -464,23 +464,26 @@ static u64 radeon_bo_get_threshold_for_moves(struct=
 radeon_device *rdev)
>  }
>
>  int radeon_bo_list_validate(struct radeon_device *rdev,
> -                           struct ww_acquire_ctx *ticket,
> +                           struct drm_exec *exec,
>                             struct list_head *head, int ring)
>  {
>         struct ttm_operation_ctx ctx =3D { true, false };
>         struct radeon_bo_list *lobj;
> -       struct list_head duplicates;
> -       int r;
>         u64 bytes_moved =3D 0, initial_bytes_moved;
>         u64 bytes_moved_threshold =3D radeon_bo_get_threshold_for_moves(r=
dev);
> +       int r;
>
> -       INIT_LIST_HEAD(&duplicates);
> -       r =3D ttm_eu_reserve_buffers(ticket, head, true, &duplicates);
> -       if (unlikely(r !=3D 0)) {
> -               return r;
> +       drm_exec_until_all_locked(exec) {
> +               list_for_each_entry(lobj, head, list) {
> +                       r =3D drm_exec_prepare_obj(exec, &lobj->robj->tbo=
.base,
> +                                                1);
> +                       drm_exec_retry_on_contention(exec);
> +                       if (unlikely(r && r !=3D -EALREADY))
> +                               return r;
> +               }
>         }
>
> -       list_for_each_entry(lobj, head, tv.head) {
> +       list_for_each_entry(lobj, head, list) {
>                 struct radeon_bo *bo =3D lobj->robj;
>                 if (!bo->tbo.pin_count) {
>                         u32 domain =3D lobj->preferred_domains;
> @@ -519,7 +522,6 @@ int radeon_bo_list_validate(struct radeon_device *rde=
v,
>                                         domain =3D lobj->allowed_domains;
>                                         goto retry;
>                                 }
> -                               ttm_eu_backoff_reservation(ticket, head);
>                                 return r;
>                         }
>                 }
> @@ -527,11 +529,6 @@ int radeon_bo_list_validate(struct radeon_device *rd=
ev,
>                 lobj->tiling_flags =3D bo->tiling_flags;
>         }
>
> -       list_for_each_entry(lobj, &duplicates, tv.head) {
> -               lobj->gpu_offset =3D radeon_bo_gpu_offset(lobj->robj);
> -               lobj->tiling_flags =3D lobj->robj->tiling_flags;
> -       }
> -
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/radeon/radeon_object.h b/drivers/gpu/drm/rad=
eon/radeon_object.h
> index 39cc87a59a9a..d7bbb52db546 100644
> --- a/drivers/gpu/drm/radeon/radeon_object.h
> +++ b/drivers/gpu/drm/radeon/radeon_object.h
> @@ -152,7 +152,7 @@ extern void radeon_bo_force_delete(struct radeon_devi=
ce *rdev);
>  extern int radeon_bo_init(struct radeon_device *rdev);
>  extern void radeon_bo_fini(struct radeon_device *rdev);
>  extern int radeon_bo_list_validate(struct radeon_device *rdev,
> -                                  struct ww_acquire_ctx *ticket,
> +                                  struct drm_exec *exec,
>                                    struct list_head *head, int ring);
>  extern int radeon_bo_set_tiling_flags(struct radeon_bo *bo,
>                                 u32 tiling_flags, u32 pitch);
> diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/=
radeon_vm.c
> index c38b4d5d6a14..21a5340aefdf 100644
> --- a/drivers/gpu/drm/radeon/radeon_vm.c
> +++ b/drivers/gpu/drm/radeon/radeon_vm.c
> @@ -142,10 +142,9 @@ struct radeon_bo_list *radeon_vm_get_bos(struct rade=
on_device *rdev,
>         list[0].robj =3D vm->page_directory;
>         list[0].preferred_domains =3D RADEON_GEM_DOMAIN_VRAM;
>         list[0].allowed_domains =3D RADEON_GEM_DOMAIN_VRAM;
> -       list[0].tv.bo =3D &vm->page_directory->tbo;
> -       list[0].tv.num_shared =3D 1;
> +       list[0].shared =3D true;
>         list[0].tiling_flags =3D 0;
> -       list_add(&list[0].tv.head, head);
> +       list_add(&list[0].list, head);
>
>         for (i =3D 0, idx =3D 1; i <=3D vm->max_pde_used; i++) {
>                 if (!vm->page_tables[i].bo)
> @@ -154,10 +153,9 @@ struct radeon_bo_list *radeon_vm_get_bos(struct rade=
on_device *rdev,
>                 list[idx].robj =3D vm->page_tables[i].bo;
>                 list[idx].preferred_domains =3D RADEON_GEM_DOMAIN_VRAM;
>                 list[idx].allowed_domains =3D RADEON_GEM_DOMAIN_VRAM;
> -               list[idx].tv.bo =3D &list[idx].robj->tbo;
> -               list[idx].tv.num_shared =3D 1;
> +               list[idx].shared =3D true;
>                 list[idx].tiling_flags =3D 0;
> -               list_add(&list[idx++].tv.head, head);
> +               list_add(&list[idx++].list, head);
>         }
>
>         return list;
> --
> 2.34.1
>
