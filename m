Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2751C433F5
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 12:34:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 63FA882A87;
	Thu, 28 Apr 2022 12:34:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pyxY_e0eEOi9; Thu, 28 Apr 2022 12:34:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DFCA082AC6;
	Thu, 28 Apr 2022 12:34:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADB26C0032;
	Thu, 28 Apr 2022 12:34:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16EC6C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 12:34:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DF3DB41B55
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 12:34:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=ffwll.ch
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A21dWf8Uv_3M
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 12:34:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 37BB841B3F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 12:34:00 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id j15so6612776wrb.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 05:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=oM/mhDtYgrTfoqWHcDfm1oQ6TI+8agMAO+j/ubn1fLc=;
 b=QFjsWJOlqR+0ZVt8NYJ+S/caZI3wMRsvdf5luivf3r9b3TOTg8jOxqcs7+oxnyUENI
 5QdlvMdqDxO/q5fmRIgPkMqki7Yx6mTzhjfvC0MwrxuozgeDajkjYApi21QWMPQjayjA
 cAcvWqQlh2+AVQ0W8SppkQa9DBc9c66zwFwww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=oM/mhDtYgrTfoqWHcDfm1oQ6TI+8agMAO+j/ubn1fLc=;
 b=7yaIIF0Mw0YVW0eguAdH3c1LOzsCoStifoTmFU9PH9rvateAZ4wG/E9Ib4XUCEw7VK
 KJjkWDSMtt9YX6W+e9pcfSNz3I1IFqkHsqwNd1sBIHggcJAv5BX81W+26HL0VqWlB+Ia
 RbiM/TX5YwRRNwdei1YcFcE1GemPegOM+xvYEz0phgptad/4ZGaOq704e+cR+9mA+nHq
 aHAkiIBmDJSz8ujF8Ch+c+MEIFXMgVT55zRlmEvQGjdi8d+8D/NWpRS24MCG5UlMEFCp
 RxqUwXiz5EDc4BdEzMdDSZLL+KVI53BgUStGg5Wqq8+uW3cyEIbnVvcLpZQnugjPzd7y
 kmSA==
X-Gm-Message-State: AOAM533K8UmiGOrjAEAdz/T9UVTbm5KxFxpLIN7hRYaN5bR/+QrxbsSZ
 vDNpA3OuZB7BjrOJRRZ38wEoRw==
X-Google-Smtp-Source: ABdhPJyyK4ExiKJP8QtekER2JcpnlC5WS6PaDYGWUo71doJitzURTCSFG1Gx5e2x4TNnODMzeQ0Gdw==
X-Received: by 2002:a05:6000:1883:b0:205:c0cb:33c6 with SMTP id
 a3-20020a056000188300b00205c0cb33c6mr27531231wri.39.1651149238107; 
 Thu, 28 Apr 2022 05:33:58 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 f66-20020a1c3845000000b00393e84ea043sm4015952wma.44.2022.04.28.05.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 05:33:57 -0700 (PDT)
Date: Thu, 28 Apr 2022 14:33:55 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v5 15/17] drm/shmem-helper: Make
 drm_gem_shmem_get_pages() private
Message-ID: <YmqJsxHYB2DNBzX0@phenom.ffwll.local>
Mail-Followup-To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Rob Clark <robdclark@gmail.com>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Qiang Yu <yuq825@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Dmitry Osipenko <digetx@gmail.com>
References: <20220424190424.540501-1-dmitry.osipenko@collabora.com>
 <20220424190424.540501-16-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220424190424.540501-16-dmitry.osipenko@collabora.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Osipenko <digetx@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Rob Herring <robh@kernel.org>, Daniel Stone <daniel@fooishbar.org>,
 Steven Price <steven.price@arm.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, virtualization@lists.linux-foundation.org,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Emil Velikov <emil.l.velikov@gmail.com>, linux-kernel@vger.kernel.org,
 Rob Clark <robdclark@gmail.com>, Qiang Yu <yuq825@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Robin Murphy <robin.murphy@arm.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
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

On Sun, Apr 24, 2022 at 10:04:22PM +0300, Dmitry Osipenko wrote:
> VirtIO-GPU driver was the only user of drm_gem_shmem_get_pages()
> and it now uses drm_gem_shmem_get_pages_sgt(). Make the get_pages()
> private to drm_gem_shmem_helper.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 3 +--
>  include/drm/drm_gem_shmem_helper.h     | 1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 25e9bc2803ee..7ec5f8002f68 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -490,7 +490,7 @@ static int drm_gem_shmem_get_pages_locked(struct drm_gem_shmem_object *shmem)
>   * Returns:
>   * 0 on success or a negative error code on failure.
>   */

We also delete the kerneldoc for functions not exported (kerneldoc is
geared towards driver writes). If there's anything critical the comment
explains about the internals, you can keep that as a normal C style
comment without the /** but generally there's no need for these anymore.
-Daniel

> -int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
> +static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
>  {
>  	int ret;
>  
> @@ -507,7 +507,6 @@ int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL(drm_gem_shmem_get_pages);
>  
>  static void drm_gem_shmem_get_pages_no_fail(struct drm_gem_shmem_object *shmem)
>  {
> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
> index 638cb16a4576..5b351933c293 100644
> --- a/include/drm/drm_gem_shmem_helper.h
> +++ b/include/drm/drm_gem_shmem_helper.h
> @@ -180,7 +180,6 @@ struct drm_gem_shmem_object {
>  struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t size);
>  void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem);
>  
> -int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem);
>  void drm_gem_shmem_put_pages(struct drm_gem_shmem_object *shmem);
>  int drm_gem_shmem_pin(struct drm_gem_shmem_object *shmem);
>  void drm_gem_shmem_unpin(struct drm_gem_shmem_object *shmem);
> -- 
> 2.35.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
