Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1387C46467
	for <virtualization@archiver.kernel.org>; Tue, 29 Nov 2022 16:40:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63B95408A8;
	Tue, 29 Nov 2022 16:40:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 63B95408A8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=nSB5KCiZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yaqkK5uVVwFs; Tue, 29 Nov 2022 16:40:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5A8C9404E7;
	Tue, 29 Nov 2022 16:40:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A8C9404E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16434C0032;
	Tue, 29 Nov 2022 16:40:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D280C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 16:40:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 77C1E81E8A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 16:40:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 77C1E81E8A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=nSB5KCiZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TRQehKftl6zR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 16:40:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A586981E89
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A586981E89
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 16:40:43 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 p8-20020a056830130800b0066bb73cf3bcso9459941otq.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 08:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K78waBDJGkif7za6gqKCFTtsu32p8+QANMOHhvDlwsw=;
 b=nSB5KCiZI7DAGDSJaDYZqmduGMY2KQVyAFKkhuk3fFegPUfW1cDr+c1iUFeyyJz/of
 gIWXnGnR80+eiA1FXqAvuTvQFwSGl32+QZIarxtgRB1b06ZV8BJSTW3MakSo1H1ldSmX
 vzIooVJwV5nLyqyf/vSwBCdafTX4Ltdwjdf1ZrjQy7SXEFleHcvIuE/MwVSk+lV2k63+
 ibOed6JWKqfobTPF/hiIb5IY5u6nMCD5qA5qLJDwlPdNUaRyoGrvROGiYm1aS64qJoG9
 chgwMiLL4DBl11hNz6JjP1H75mAeEECPuwTwuzX5Kcx0nZAiIcxP6iQpuvq4LuPme1lC
 likA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K78waBDJGkif7za6gqKCFTtsu32p8+QANMOHhvDlwsw=;
 b=U63pe4JVEXJ7GAtcpZFpXgd2PokBAIJe+4lI5xi0SOpNXbVdJ2T9rvRy7dWhJhSMJR
 XJvK+Fjj2SKg0fiXxZyilDLllHC4EGaFJ+ClxNfQTLBzX6Xh+bEayIzPN4cX9ftrdchK
 dXP5LXJDVPpwtAZySXd4dAu3Euxb9Ea97aD827aHNDhGIMRfUF1hZWL8gqMMOKAdxord
 t4pddk+RDzb/B7BtGRGk7JFBVufL/6viQq6p8TPDL2pU0F2Dxxt1NqpkmDkT/0R0UIV+
 +n0UwvCMJzCnrUNUFnZDsNltuZ4krF5IEVrOKLO8HMR2Jq1vgl+nw/7omkK/XQRXsVuC
 ND5A==
X-Gm-Message-State: ANoB5plazI+VZp1+wHhDRIDb9qdAd2ajpBYX3ROLxNBYtFt0WAy6hRGA
 JLe3wRP2etICVjEOQ9jsfCyKO/QjJXwC/oKsUPM=
X-Google-Smtp-Source: AA0mqf6QNn+q3W6OtufOMJC0QkPzO9jSHQOngL9Jsl3MZqmgQD8IOdpUGysoS6cLjUDNBXcPEr/LpqoksrOxBBV2mwI=
X-Received: by 2002:a9d:75d5:0:b0:667:7361:7db5 with SMTP id
 c21-20020a9d75d5000000b0066773617db5mr21623192otl.22.1669740042594; Tue, 29
 Nov 2022 08:40:42 -0800 (PST)
MIME-Version: 1.0
References: <20221123025723.695075-1-dmitry.osipenko@collabora.com>
 <20221123025723.695075-2-dmitry.osipenko@collabora.com>
In-Reply-To: <20221123025723.695075-2-dmitry.osipenko@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 29 Nov 2022 08:40:33 -0800
Message-ID: <CAF6AEGv832O8m-7pP8qaDChA3=Y6TmBZrwf-NYwvHkvH6sVMkw@mail.gmail.com>
Subject: Re: [PATCH v9 01/11] drm/msm/gem: Prevent blocking within shrinker
 loop
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, kernel@collabora.com,
 David Airlie <airlied@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Rob Herring <robh@kernel.org>, Daniel Stone <daniel@fooishbar.org>,
 Steven Price <steven.price@arm.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Maxime Ripard <mripard@kernel.org>,
 virtualization@lists.linux-foundation.org, Sean Paul <sean@poorly.run>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-kernel@vger.kernel.org,
 Qiang Yu <yuq825@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Tue, Nov 22, 2022 at 7:00 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Consider this scenario:
>
> 1. APP1 continuously creates lots of small GEMs
> 2. APP2 triggers `drop_caches`
> 3. Shrinker starts to evict APP1 GEMs, while APP1 produces new purgeable
>    GEMs
> 4. msm_gem_shrinker_scan() returns non-zero number of freed pages
>    and causes shrinker to try shrink more
> 5. msm_gem_shrinker_scan() returns non-zero number of freed pages again,
>    goto 4
> 6. The APP2 is blocked in `drop_caches` until APP1 stops producing
>    purgeable GEMs
>
> To prevent this blocking scenario, check number of remaining pages
> that GPU shrinker couldn't release due to a GEM locking contention
> or shrinking rejection. If there are no remaining pages left to shrink,
> then there is no need to free up more pages and shrinker may break out
> from the loop.
>
> This problem was found during shrinker/madvise IOCTL testing of
> virtio-gpu driver. The MSM driver is affected in the same way.
>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Rob Clark <robdclark@gmail.com>

> ---
>  drivers/gpu/drm/drm_gem.c              | 9 +++++++--
>  drivers/gpu/drm/msm/msm_gem_shrinker.c | 8 ++++++--
>  include/drm/drm_gem.h                  | 4 +++-
>  3 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index b8db675e7fb5..299bca1390aa 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1375,10 +1375,13 @@ EXPORT_SYMBOL(drm_gem_lru_move_tail);
>   *
>   * @lru: The LRU to scan
>   * @nr_to_scan: The number of pages to try to reclaim
> + * @remaining: The number of pages left to reclaim
>   * @shrink: Callback to try to shrink/reclaim the object.
>   */
>  unsigned long
> -drm_gem_lru_scan(struct drm_gem_lru *lru, unsigned nr_to_scan,
> +drm_gem_lru_scan(struct drm_gem_lru *lru,
> +                unsigned int nr_to_scan,
> +                unsigned long *remaining,
>                  bool (*shrink)(struct drm_gem_object *obj))
>  {
>         struct drm_gem_lru still_in_lru;
> @@ -1417,8 +1420,10 @@ drm_gem_lru_scan(struct drm_gem_lru *lru, unsigned nr_to_scan,
>                  * hit shrinker in response to trying to get backing pages
>                  * for this obj (ie. while it's lock is already held)
>                  */
> -               if (!dma_resv_trylock(obj->resv))
> +               if (!dma_resv_trylock(obj->resv)) {
> +                       *remaining += obj->size >> PAGE_SHIFT;
>                         goto tail;
> +               }
>
>                 if (shrink(obj)) {
>                         freed += obj->size >> PAGE_SHIFT;
> diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
> index 1de14e67f96b..4c8b0ab61ce4 100644
> --- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
> +++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
> @@ -116,12 +116,14 @@ msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
>         };
>         long nr = sc->nr_to_scan;
>         unsigned long freed = 0;
> +       unsigned long remaining = 0;
>
>         for (unsigned i = 0; (nr > 0) && (i < ARRAY_SIZE(stages)); i++) {
>                 if (!stages[i].cond)
>                         continue;
>                 stages[i].freed =
> -                       drm_gem_lru_scan(stages[i].lru, nr, stages[i].shrink);
> +                       drm_gem_lru_scan(stages[i].lru, nr, &remaining,
> +                                        stages[i].shrink);
>                 nr -= stages[i].freed;
>                 freed += stages[i].freed;
>         }
> @@ -132,7 +134,7 @@ msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
>                                      stages[3].freed);
>         }
>
> -       return (freed > 0) ? freed : SHRINK_STOP;
> +       return (freed > 0 && remaining > 0) ? freed : SHRINK_STOP;
>  }
>
>  #ifdef CONFIG_DEBUG_FS
> @@ -182,10 +184,12 @@ msm_gem_shrinker_vmap(struct notifier_block *nb, unsigned long event, void *ptr)
>                 NULL,
>         };
>         unsigned idx, unmapped = 0;
> +       unsigned long remaining = 0;
>
>         for (idx = 0; lrus[idx] && unmapped < vmap_shrink_limit; idx++) {
>                 unmapped += drm_gem_lru_scan(lrus[idx],
>                                              vmap_shrink_limit - unmapped,
> +                                            &remaining,
>                                              vmap_shrink);
>         }
>
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index a17c2f903f81..b46ade812443 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -475,7 +475,9 @@ int drm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
>  void drm_gem_lru_init(struct drm_gem_lru *lru, struct mutex *lock);
>  void drm_gem_lru_remove(struct drm_gem_object *obj);
>  void drm_gem_lru_move_tail(struct drm_gem_lru *lru, struct drm_gem_object *obj);
> -unsigned long drm_gem_lru_scan(struct drm_gem_lru *lru, unsigned nr_to_scan,
> +unsigned long drm_gem_lru_scan(struct drm_gem_lru *lru,
> +                              unsigned int nr_to_scan,
> +                              unsigned long *remaining,
>                                bool (*shrink)(struct drm_gem_object *obj));
>
>  #endif /* __DRM_GEM_H__ */
> --
> 2.38.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
