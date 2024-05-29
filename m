Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7FC181D0B
	for <virtualization@lists.linux-foundation.org>; Wed, 29 May 2024 08:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970201; cv=none; b=SyFiIovtiGe0GivUQioiJW/K4zGs/va0mJ4PJraCFir4cidJ3Xt8PCzvKGmhFECmnmCrsFH2EtQyZyILEm/AoNWJl7Y+NCNyYoPG5hycmsaZmOsdz6W3tqBC1itzLLYFpsG8bgD5RdSqeehSTZAK97hwQuAfzx/WlTXlU6uGepA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970201; c=relaxed/simple;
	bh=WgixO3taSRbE0QziVmAcwTsoz8TFfpyR0rpCo3iNMFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmH5VI6YNFfK/Ve0JPUFfSCx9847ZsYHPQ+IqR6R9dBfORey5n9MQT14d267TtLrPxcv5kKwS8Sr55TljUUqMpoLXi7KWlmLSX7nL817Zlj8qUSOzilBBwEx5LsQtdQYtSqm9ant3nLzwWexpf29L6ofL01YiNsbkSl85I5sY2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MrqzHLA/; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MrqzHLA/"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8ADA1401D5
	for <virtualization@lists.linux-foundation.org>; Wed, 29 May 2024 08:09:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tew-_0NW4V3k for <virtualization@lists.linux-foundation.org>;
 Wed, 29 May 2024 08:09:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::134; helo=mail-lf1-x134.google.com; envelope-from=dmitry.baryshkov@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BD45940026
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BD45940026
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MrqzHLA/
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BD45940026
	for <virtualization@lists.linux-foundation.org>; Wed, 29 May 2024 08:09:57 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-52b119986f2so298002e87.1
        for <virtualization@lists.linux-foundation.org>; Wed, 29 May 2024 01:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716970195; x=1717574995; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=enlxS5GkWub7qfeq6FBQU5uJl3JqVotYfwFdD9Rt9Ng=;
        b=MrqzHLA/cFDMX81SsnyJtmDUykYffRbR1p+g5/SEjyZuOnB9Q6FY68x/Gg8TOh8cHT
         2btcq2nJ3c3luJUMN/nEYG3B+C2xslrCGC6xyzNN/WBiW1jweAyqS2r/t0LFVshydTxF
         nfSgtUSfI6rJCa5UkQX+l7hPofePe8Zd0Q1QpjIrzue75XdgE3xZZnGlyVPokAndOUP7
         YzC7mqyn6XNhuRpLTTGU/WqQPabU2WSF/MZN1FMFBLCEErXUKpZU/S8tBoEGebZAXXhl
         dwHMkt9ZzahIjQbtcaFFRnzdUhl2xyu8wO1IZd6a/HsWghGUZtmjlhlSyEL6y3i2b0uZ
         8JaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970195; x=1717574995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enlxS5GkWub7qfeq6FBQU5uJl3JqVotYfwFdD9Rt9Ng=;
        b=uDgDQrEZOYclpA+yZcboNt7MxhuoyCV/G2wIK4PpDCRngo+GFFsly/BOpwxsdjTY7k
         r/MM3EdTjNjYs0gcEzAtQT5WOfvQ9l1SjrLTGdlf83HchJVkzAvX0QgitW98Y3DCQAXg
         0vFPqpFdsGvikILqmMCFM/PNMj0mAlu4eU4ykDE8b10ihbyuv/N7ks9a+qfwxRn+eRzD
         qe8+F+k7Y8yiac1v9aKGLYDnBI9vsXuMmDvwYtoaQbMSSD191+zrdL784PR4crsW3k7D
         Tzbn5GvdwrVdjKPsb/y336KJ168oyBD09cok9hDtytmIEOrc2qt5DoXNtoWDUY9Jz/9F
         RgYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfy4qE+LYmQ0qQgI0zPL4zgxzIkfWOlNRbCJuYUwK6fE5gbm0AbbYKNouL+PcmiJcD4PBIy1uavWllv8QmkhB8WuHWpbBBFiqg3axugdQbIU3S8dJUf7eqcw==
X-Gm-Message-State: AOJu0Yy7N4zN6jhorpOc7y7EkFghMV1gmDhKa2Ozaey26U37tonXOd7Y
	l1RFOSmOv5lR0SQYEYY26Vz7tvDmUMYwt5cTO3yMefKvkAxmX0mpRCZ9KMKRLbg=
X-Google-Smtp-Source: AGHT+IHAAOSe1YF9ohma3qLilcNBhTgUrp5XW+R17Dfxhf/XQBKuTb9CXtbrrq9LBMBwT336LwrXXQ==
X-Received: by 2002:a05:6512:3128:b0:522:33cd:64bd with SMTP id 2adb3069b0e04-52964aba466mr8988769e87.27.1716970195416;
        Wed, 29 May 2024 01:09:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529aa049e3csm859093e87.167.2024.05.29.01.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:09:55 -0700 (PDT)
Date: Wed, 29 May 2024 11:09:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	david.heidelberg@collabora.com, guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] drm/ci: uprev IGT
Message-ID: <bj6mpegmxo6i5o34xyxwiytdaokv2u6p5iu4eoek3ctqimwviy@jbo5aw7gy4ue>
References: <20240529024049.356327-1-vignesh.raman@collabora.com>
 <20240529024049.356327-5-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529024049.356327-5-vignesh.raman@collabora.com>

On Wed, May 29, 2024 at 08:10:47AM +0530, Vignesh Raman wrote:
> test-list.txt and test-list-full.txt are not generated for
> cross-builds and they are required by drm-ci for testing
> arm32 targets. This is fixed in igt-gpu-tools. So uprev
> IGT to include the commit which fixes this issue. Also
> disable building xe driver tests for non-intel platforms.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v2:
>   - Split IGT uprev to seperate patch.
> 
> v3:
>   - No changes.
> 
> ---
>  drivers/gpu/drm/ci/build-igt.sh  | 4 ++++
>  drivers/gpu/drm/ci/gitlab-ci.yml | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/ci/build-igt.sh b/drivers/gpu/drm/ci/build-igt.sh
> index b7d2a49a6db3..eddb5f782a5e 100644
> --- a/drivers/gpu/drm/ci/build-igt.sh
> +++ b/drivers/gpu/drm/ci/build-igt.sh
> @@ -45,6 +45,10 @@ MESON_OPTIONS="-Doverlay=disabled                    \
>                 -Dlibunwind=enabled                   \
>                 -Dprefix=/igt"
>  
> +if [[ "$KERNEL_ARCH" = "arm64" ]] || [[ "$KERNEL_ARCH" = "arm" ]]; then
> +    MESON_OPTIONS="$MESON_OPTIONS -Dxe_driver=disabled"
> +fi
> +
>  mkdir -p /igt
>  meson build $MESON_OPTIONS $EXTRA_MESON_ARGS
>  ninja -C build -j${FDO_CI_CONCURRENT:-4} || ninja -C build -j 1
> diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
> index 8f32de63d92e..1b29c3b6406b 100644
> --- a/drivers/gpu/drm/ci/gitlab-ci.yml
> +++ b/drivers/gpu/drm/ci/gitlab-ci.yml
> @@ -5,7 +5,7 @@ variables:
>    UPSTREAM_REPO: git://anongit.freedesktop.org/drm/drm
>    TARGET_BRANCH: drm-next
>  
> -  IGT_VERSION: d2af13d9f5be5ce23d996e4afd3e45990f5ab977
> +  IGT_VERSION: 0df7b9b97f9da0e364f5ee30fe331004b8c86b56

Let's land this, then I'll ask to uprev to
dc2d7fb4f978048b87707ea9ec32da748b01b378, which fixes an issue with the
writeback tests on MSM devices.

>  
>    DEQP_RUNNER_GIT_URL: https://gitlab.freedesktop.org/anholt/deqp-runner.git
>    DEQP_RUNNER_GIT_TAG: v0.15.0
> -- 
> 2.40.1
> 

-- 
With best wishes
Dmitry
