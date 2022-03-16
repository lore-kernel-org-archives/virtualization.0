Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9114C433EF
	for <virtualization@archiver.kernel.org>; Wed, 16 Mar 2022 20:00:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4938A8195C;
	Wed, 16 Mar 2022 20:00:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MUCjbmZhlfEM; Wed, 16 Mar 2022 20:00:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8AD7584245;
	Wed, 16 Mar 2022 20:00:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D4A2C0012;
	Wed, 16 Mar 2022 20:00:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5A34C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 20:00:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A0AF184245
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 20:00:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pcYgYM51RmaK
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 20:00:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C8E1A83E39
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 20:00:01 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id h23so3879971wrb.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 13:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Go/GSSfMpmHudgHidpYgrQ9jz5k/spgNS6MVMiV/d38=;
 b=hXC7zXAktO/jptIfBhe5T0AqGs0hsYrEmLgKOPpU+BWqx6yyKpnIKxVEwyPgGGR/O5
 eIt7OcGfdH2uu3FpefwZCcLJawg0p769QASidEtdiBYKUA/ONUSNgjKpdV2158A24o0I
 q+7r898zUofNp3TtaKE5tLzDs7fTKULSY/paOKwpSL0XwlnHR0Zj3hiszPDAdLPHo05d
 O2VrpUwiz4SlJHet+apwE07X4iFZhXNYofkjk+Okd4QQuOeT1cEIjPSJiYC9GxstSMvR
 R0nJKYXjMvblh5xMrZ05AhmiO7UtiuA3xYa6zQijezzZ5tv9eI1rYfKO9dIdbR4VKAMO
 q+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Go/GSSfMpmHudgHidpYgrQ9jz5k/spgNS6MVMiV/d38=;
 b=FLsN9WhWXHN5YRvQ0idxnnLQ8KsM4PCVpzzwdaqD7rAjzA9cfmCgmVYLDLbxpIwPZw
 eXQKlpx6PwJ7RWF+zWuCwli88N3oZcL+lL8LngicqoGHk+cTRY1JvSgGcTe6YY7AA4Td
 ugI8/IG8o0sJHXgLwoSk19rGQNK5uc/c8KBTJBOddwMHPsRYv8Kula0zt+iGAENo42AN
 58uDNpZqeP9aRemXYi7BXm5n8HYjhSeAoY0dzsxLSR2GAKdSxSuIKpgol8D3E6XnTGiN
 DDima54DwyDvf5snjsELk+4P6oD0cGw/0BfB0EL8rF66YHUHN3CAO73lCTccgQIEL4lc
 B28w==
X-Gm-Message-State: AOAM531rJwusMN50sGK830W+zXlDSZoCeh6g6fftXtHJBXwN37TpyoIy
 KiUE987ZZnJLRjJqIYi+QxNXDyF2J3y7hOO72Po=
X-Google-Smtp-Source: ABdhPJyaHxr3egat0pSk6uObXsiHdGVUp2oJmGNk2NqMpsRGhMxw6wVVvVrf0bdp1csh2yQK/FFXGp6oSNniY3YusTw=
X-Received: by 2002:a5d:6344:0:b0:1f0:21ee:9705 with SMTP id
 b4-20020a5d6344000000b001f021ee9705mr1199724wrw.93.1647460799823; Wed, 16 Mar
 2022 12:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220314224253.236359-1-dmitry.osipenko@collabora.com>
 <20220314224253.236359-7-dmitry.osipenko@collabora.com>
In-Reply-To: <20220314224253.236359-7-dmitry.osipenko@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 16 Mar 2022 13:00:42 -0700
Message-ID: <CAF6AEGsmtM6rTJtOJwTA49cwW7wCjF53Devzodd_PzLO0EOkVw@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] drm/shmem-helper: Add generic memory shrinker
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Gert Wollny <gert.wollny@collabora.com>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 David Airlie <airlied@linux.ie>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 Dmitry Osipenko <digetx@gmail.com>, Steven Price <steven.price@arm.com>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Mar 14, 2022 at 3:44 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Introduce a common DRM SHMEM shrinker. It allows to reduce code
> duplication among DRM drivers, it also handles complicated lockings
> for the drivers. This is initial version of the shrinker that covers
> basic needs of GPU drivers.
>
> This patch is based on a couple ideas borrowed from Rob's Clark MSM
> shrinker and Thomas' Zimmermann variant of SHMEM shrinker.
>
> GPU drivers that want to use generic DRM memory shrinker must support
> generic GEM reservations.
>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 194 +++++++++++++++++++++++++
>  include/drm/drm_device.h               |   4 +
>  include/drm/drm_gem.h                  |  11 ++
>  include/drm/drm_gem_shmem_helper.h     |  25 ++++
>  4 files changed, 234 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 37009418cd28..35be2ee98f11 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -139,6 +139,9 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
>  {
>         struct drm_gem_object *obj = &shmem->base;
>
> +       /* take out shmem GEM object from the memory shrinker */
> +       drm_gem_shmem_madvise(shmem, 0);
> +
>         WARN_ON(shmem->vmap_use_count);
>
>         if (obj->import_attach) {
> @@ -163,6 +166,42 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_free);
>
> +static void drm_gem_shmem_update_purgeable_status(struct drm_gem_shmem_object *shmem)
> +{
> +       struct drm_gem_object *obj = &shmem->base;
> +       struct drm_gem_shmem_shrinker *gem_shrinker = obj->dev->shmem_shrinker;
> +       size_t page_count = obj->size >> PAGE_SHIFT;
> +
> +       if (!gem_shrinker || obj->import_attach || !obj->funcs->purge)
> +               return;
> +
> +       mutex_lock(&shmem->vmap_lock);
> +       mutex_lock(&shmem->pages_lock);
> +       mutex_lock(&gem_shrinker->lock);
> +
> +       if (shmem->madv < 0) {
> +               list_del_init(&shmem->madv_list);
> +               goto unlock;
> +       } else if (shmem->madv > 0) {
> +               if (!list_empty(&shmem->madv_list))
> +                       goto unlock;
> +
> +               WARN_ON(gem_shrinker->shrinkable_count + page_count < page_count);
> +               gem_shrinker->shrinkable_count += page_count;
> +
> +               list_add_tail(&shmem->madv_list, &gem_shrinker->lru);
> +       } else if (!list_empty(&shmem->madv_list)) {
> +               list_del_init(&shmem->madv_list);
> +
> +               WARN_ON(gem_shrinker->shrinkable_count < page_count);
> +               gem_shrinker->shrinkable_count -= page_count;
> +       }
> +unlock:
> +       mutex_unlock(&gem_shrinker->lock);
> +       mutex_unlock(&shmem->pages_lock);
> +       mutex_unlock(&shmem->vmap_lock);
> +}
> +
>  static int drm_gem_shmem_get_pages_locked(struct drm_gem_shmem_object *shmem)
>  {
>         struct drm_gem_object *obj = &shmem->base;
> @@ -366,6 +405,8 @@ int drm_gem_shmem_vmap(struct drm_gem_shmem_object *shmem,
>         ret = drm_gem_shmem_vmap_locked(shmem, map);
>         mutex_unlock(&shmem->vmap_lock);
>
> +       drm_gem_shmem_update_purgeable_status(shmem);
> +
>         return ret;
>  }
>  EXPORT_SYMBOL(drm_gem_shmem_vmap);
> @@ -409,6 +450,8 @@ void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem,
>         mutex_lock(&shmem->vmap_lock);
>         drm_gem_shmem_vunmap_locked(shmem, map);
>         mutex_unlock(&shmem->vmap_lock);
> +
> +       drm_gem_shmem_update_purgeable_status(shmem);
>  }
>  EXPORT_SYMBOL(drm_gem_shmem_vunmap);
>
> @@ -451,6 +494,8 @@ int drm_gem_shmem_madvise(struct drm_gem_shmem_object *shmem, int madv)
>
>         mutex_unlock(&shmem->pages_lock);
>
> +       drm_gem_shmem_update_purgeable_status(shmem);
> +
>         return (madv >= 0);
>  }
>  EXPORT_SYMBOL(drm_gem_shmem_madvise);
> @@ -763,6 +808,155 @@ drm_gem_shmem_prime_import_sg_table(struct drm_device *dev,
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_prime_import_sg_table);
>
> +static struct drm_gem_shmem_shrinker *
> +to_drm_shrinker(struct shrinker *shrinker)
> +{
> +       return container_of(shrinker, struct drm_gem_shmem_shrinker, base);
> +}
> +
> +static unsigned long
> +drm_gem_shmem_shrinker_count_objects(struct shrinker *shrinker,
> +                                    struct shrink_control *sc)
> +{
> +       struct drm_gem_shmem_shrinker *gem_shrinker = to_drm_shrinker(shrinker);
> +       u64 count = gem_shrinker->shrinkable_count;
> +
> +       if (count >= SHRINK_EMPTY)
> +               return SHRINK_EMPTY - 1;
> +
> +       return count ?: SHRINK_EMPTY;
> +}
> +
> +static unsigned long
> +drm_gem_shmem_shrinker_scan_objects(struct shrinker *shrinker,
> +                                   struct shrink_control *sc)
> +{
> +       struct drm_gem_shmem_shrinker *gem_shrinker = to_drm_shrinker(shrinker);
> +       struct drm_gem_shmem_object *shmem;
> +       struct list_head still_in_list;
> +       bool lock_contention = true;
> +       struct drm_gem_object *obj;
> +       unsigned long freed = 0;
> +
> +       INIT_LIST_HEAD(&still_in_list);
> +
> +       mutex_lock(&gem_shrinker->lock);
> +
> +       while (freed < sc->nr_to_scan) {
> +               shmem = list_first_entry_or_null(&gem_shrinker->lru,
> +                                                typeof(*shmem), madv_list);
> +               if (!shmem)
> +                       break;
> +
> +               obj = &shmem->base;
> +               list_move_tail(&shmem->madv_list, &still_in_list);
> +
> +               /*
> +                * If it's in the process of being freed, gem_object->free()
> +                * may be blocked on lock waiting to remove it.  So just
> +                * skip it.
> +                */
> +               if (!kref_get_unless_zero(&obj->refcount))
> +                       continue;
> +
> +               mutex_unlock(&gem_shrinker->lock);
> +
> +               /* prevent racing with job submission code paths */
> +               if (!dma_resv_trylock(obj->resv))
> +                       goto shrinker_lock;

jfwiw, the trylock here is in the msm code isn't so much for madvise
(it is an error to submit jobs that reference DONTNEED objects), but
instead for the case of evicting WILLNEED but inactive objects to
swap.  Ie. in the case that we need to move bo's back in to memory, we
don't want to unpin/evict a buffer that is later on the list for the
same job.. msm shrinker re-uses the same scan loop for both
inactive_dontneed (purge) and inactive_willneed (evict)

I suppose using trylock is not technically wrong, and it would be a
good idea if the shmem helpers supported eviction as well.  But I
think in the madvise/purge case if you lose the trylock then there is
something else bad going on.

Anyways, from the PoV of minimizing lock contention when under memory
pressure, this all looks good to me.

BR,
-R

> +
> +               /* prevent racing with the dma-buf exporting */
> +               if (!mutex_trylock(&gem_shrinker->dev->object_name_lock))
> +                       goto resv_unlock;
> +
> +               if (!mutex_trylock(&shmem->vmap_lock))
> +                       goto object_name_unlock;
> +
> +               if (!mutex_trylock(&shmem->pages_lock))
> +                       goto vmap_unlock;
> +
> +               lock_contention = false;
> +
> +               /* check whether h/w uses this object */
> +               if (!dma_resv_test_signaled(obj->resv, true))
> +                       goto pages_unlock;
> +
> +               /* GEM may've become unpurgeable while shrinker was unlocked */
> +               if (!drm_gem_shmem_is_purgeable(shmem))
> +                       goto pages_unlock;
> +
> +               freed += obj->funcs->purge(obj);
> +pages_unlock:
> +               mutex_unlock(&shmem->pages_lock);
> +vmap_unlock:
> +               mutex_unlock(&shmem->vmap_lock);
> +object_name_unlock:
> +               mutex_unlock(&gem_shrinker->dev->object_name_lock);
> +resv_unlock:
> +               dma_resv_unlock(obj->resv);
> +shrinker_lock:
> +               drm_gem_object_put(&shmem->base);
> +               mutex_lock(&gem_shrinker->lock);
> +       }
> +
> +       list_splice_tail(&still_in_list, &gem_shrinker->lru);
> +       WARN_ON(gem_shrinker->shrinkable_count < freed);
> +       gem_shrinker->shrinkable_count -= freed;
> +
> +       mutex_unlock(&gem_shrinker->lock);
> +
> +       if (!freed && !lock_contention)
> +               return SHRINK_STOP;
> +
> +       return freed;
> +}
> +
> +int drm_gem_shmem_shrinker_register(struct drm_device *dev)
> +{
> +       struct drm_gem_shmem_shrinker *gem_shrinker;
> +       int err;
> +
> +       if (WARN_ON(dev->shmem_shrinker))
> +               return -EBUSY;
> +
> +       gem_shrinker = kzalloc(sizeof(*gem_shrinker), GFP_KERNEL);
> +       if (!gem_shrinker)
> +               return -ENOMEM;
> +
> +       gem_shrinker->base.count_objects = drm_gem_shmem_shrinker_count_objects;
> +       gem_shrinker->base.scan_objects = drm_gem_shmem_shrinker_scan_objects;
> +       gem_shrinker->base.seeks = DEFAULT_SEEKS;
> +       gem_shrinker->dev = dev;
> +
> +       INIT_LIST_HEAD(&gem_shrinker->lru);
> +       mutex_init(&gem_shrinker->lock);
> +
> +       dev->shmem_shrinker = gem_shrinker;
> +
> +       err = register_shrinker(&gem_shrinker->base);
> +       if (err) {
> +               dev->shmem_shrinker = NULL;
> +               kfree(gem_shrinker);
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(drm_gem_shmem_shrinker_register);
> +
> +void drm_gem_shmem_shrinker_unregister(struct drm_device *dev)
> +{
> +       struct drm_gem_shmem_shrinker *gem_shrinker = dev->shmem_shrinker;
> +
> +       if (gem_shrinker) {
> +               unregister_shrinker(&gem_shrinker->base);
> +               mutex_destroy(&gem_shrinker->lock);
> +               dev->shmem_shrinker = NULL;
> +               kfree(gem_shrinker);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(drm_gem_shmem_shrinker_unregister);
> +
>  MODULE_DESCRIPTION("DRM SHMEM memory-management helpers");
>  MODULE_IMPORT_NS(DMA_BUF);
>  MODULE_LICENSE("GPL v2");
> diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
> index 9923c7a6885e..929546cad894 100644
> --- a/include/drm/drm_device.h
> +++ b/include/drm/drm_device.h
> @@ -16,6 +16,7 @@ struct drm_vblank_crtc;
>  struct drm_vma_offset_manager;
>  struct drm_vram_mm;
>  struct drm_fb_helper;
> +struct drm_gem_shmem_shrinker;
>
>  struct inode;
>
> @@ -277,6 +278,9 @@ struct drm_device {
>         /** @vram_mm: VRAM MM memory manager */
>         struct drm_vram_mm *vram_mm;
>
> +       /** @shmem_shrinker: SHMEM GEM memory shrinker */
> +       struct drm_gem_shmem_shrinker *shmem_shrinker;
> +
>         /**
>          * @switch_power_state:
>          *
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index e2941cee14b6..cdb99cfbf0bc 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -172,6 +172,17 @@ struct drm_gem_object_funcs {
>          * This is optional but necessary for mmap support.
>          */
>         const struct vm_operations_struct *vm_ops;
> +
> +       /**
> +        * @purge:
> +        *
> +        * Releases the GEM object's allocated backing storage to the system.
> +        *
> +        * Returns the number of pages that have been freed by purging the GEM object.
> +        *
> +        * This callback is used by the GEM shrinker.
> +        */
> +       unsigned long (*purge)(struct drm_gem_object *obj);
>  };
>
>  /**
> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
> index d0a57853c188..455254f131f6 100644
> --- a/include/drm/drm_gem_shmem_helper.h
> +++ b/include/drm/drm_gem_shmem_helper.h
> @@ -6,6 +6,7 @@
>  #include <linux/fs.h>
>  #include <linux/mm.h>
>  #include <linux/mutex.h>
> +#include <linux/shrinker.h>
>
>  #include <drm/drm_file.h>
>  #include <drm/drm_gem.h>
> @@ -15,6 +16,7 @@
>  struct dma_buf_attachment;
>  struct drm_mode_create_dumb;
>  struct drm_printer;
> +struct drm_device;
>  struct sg_table;
>
>  /**
> @@ -272,6 +274,29 @@ static inline int drm_gem_shmem_object_mmap(struct drm_gem_object *obj, struct v
>         return drm_gem_shmem_mmap(shmem, vma);
>  }
>
> +/**
> + * struct drm_gem_shmem_shrinker - Generic memory shrinker for shmem GEMs
> + */
> +struct drm_gem_shmem_shrinker {
> +       /** @base: Shrinker for purging shmem GEM objects */
> +       struct shrinker base;
> +
> +       /** @lock: Protects @lru */
> +       struct mutex lock;
> +
> +       /** @lru: List of shmem GEM objects available for purging */
> +       struct list_head lru;
> +
> +       /** @dev: DRM device that uses this shrinker */
> +       struct drm_device *dev;
> +
> +       /** @shrinkable_count: Count of shmem GEM pages to be purged */
> +       u64 shrinkable_count;
> +};
> +
> +int drm_gem_shmem_shrinker_register(struct drm_device *dev);
> +void drm_gem_shmem_shrinker_unregister(struct drm_device *dev);
> +
>  /*
>   * Driver ops
>   */
> --
> 2.35.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
