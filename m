Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB45128828
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472247; cv=none; b=knZMIQTTxHb7LQ3xpSpQLkH5tRjyAxoTMUw1gp0E/jE3p+TI8Vlva4GnF+hY/Q2PFYKTJ9Uwf055JRKPfa8b6OE1B+/7JOnPqASfpMthXi5yKrO4r2Ipe3/CkjMGTKc/y1qHfxWZzDI4u07wp8MXQf0jG9Vv9t7uIdCDEP4bDlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472247; c=relaxed/simple;
	bh=AVxBw4jJDmo2mb14BKYuflx3kx2EIDQMDJJh8tHoa7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FawDay/5+rWvpodhP1eYuDmEZ+PYc7yi9YCe3uRRFg6YoDLoZ2n0EmRc+vS18pnfEB0OmnUzu7LGWBFifm295Ie/0fti9Yo6x07ZBNfVZMJrnhZqBYPNNmSkPNJRnOhWEagc5sTw8yQhpE/Si0WzwSS4ln8KIRe5yexWbYH68oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tJAM0oSL; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tJAM0oSL"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D009B402A1
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 10:17:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TduISPoHOat7 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Apr 2024 10:17:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::235; helo=mail-lj1-x235.google.com; envelope-from=dmitry.baryshkov@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6E7C340278
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6E7C340278
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tJAM0oSL
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6E7C340278
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 10:17:21 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2def8e5ae60so63056951fa.2
        for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 03:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714472239; x=1715077039; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vLkLH0SSmvOSmWzdY7vcX+RCH3AFTNGOUA3YHRv8hu4=;
        b=tJAM0oSLBznaflJO/LgTJw0asIRtn/fAKDkpDtg3NmAqU1S3bSwxT3XcQ2GVvwlGDA
         ZUH1gXqWbv22np5rjbUD5uI1sVRfTZ1nDdvui6iUg0Of09ZAxGZMrsRb0RSryoEVWb6O
         0b8OanBxhpsUpdE/TfizVVDVScUbx7GTi6vWYckeNky9IvpkzQKrmtnCJT+2RREmT7bB
         lEA9Aui79sXZR+wZh6LNhpZFdpZ31BV8tFQqOvRu7AKx1ihVfMJx+oS7Ljd1xFtq9/bV
         b2qKLdnbqMiTmFfI2g/SmY4iufz10V/HBufLBRrlHMU0T20MX/E30ocEXTbUY96kEXtn
         j4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714472239; x=1715077039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLkLH0SSmvOSmWzdY7vcX+RCH3AFTNGOUA3YHRv8hu4=;
        b=jj9Hy3C4h2qUqcUzb6CHDoEP8j4PKqMEwuM7Iln1ATh4lelhaAYV9z9KKC5BBdt3PM
         GuTa3+mh8Cr6MnTehqY62IpNKL93wtUZN/UxAovc1V+tjblXbwnIv/PE1ckGy7aPsRIF
         eSnSadA1jEAeikil2+R8DOHpnqK0+wJUbWIzdVZHMVRPLx4D6It5hdvmalDLLm/Oga9q
         hJEHdBctokn9u/rjfI55QeBbUlpx0VomVVHxidBMjJfFitT+aNsV7VUPPSeJ6/qxdGtR
         Kt/7XtZWOIzAY2ATxhIUYl6aogTqsw1hGbu6O0MontHY7yM7Z1swEngVBorDm0cfx2Dx
         glpw==
X-Forwarded-Encrypted: i=1; AJvYcCUoWniACNLCzTqH/Aeq6WnwxT2IEFedtohUuIQBJKDgMYQFhPDAeVj8DkS1feg1uSBVNbVBNtz1WJ1lFQ8wyTXbOYc8kbMS9nhzFVgldSRQyufvMY5VUiHJng==
X-Gm-Message-State: AOJu0YyI4Ed+LIpVy1+3H6DMBV58v7jZ+OKeA120m4Y2SZjA6G9Nw2fU
	rGG8ySrKd8kdiYEMDcEl1S//SwasihK9m9cOTmrpEycbg2C+w6tJwCtgpQOnf/A=
X-Google-Smtp-Source: AGHT+IHaFm4lzkxq9U1a8iPWUfix49p5Xd5gLpx7H0AEzCvQ84t8kRB/7beeUSB3FIO6fjrXa0k+4A==
X-Received: by 2002:a2e:8e23:0:b0:2e0:e129:7011 with SMTP id r3-20020a2e8e23000000b002e0e1297011mr1308756ljk.16.1714472238962;
        Tue, 30 Apr 2024 03:17:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id f28-20020a2eb5bc000000b002e0e78240a4sm205475ljn.77.2024.04.30.03.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 03:17:18 -0700 (PDT)
Date: Tue, 30 Apr 2024 13:17:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	david.heidelberg@collabora.com, guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/5] drm/ci: generate testlist from build
Message-ID: <k7sepoksttro3dgxxtwxfmlxwv5w5zn3aeso7p24mm3n74bo45@kx2dpe2qkqgo>
References: <20240430091121.508099-1-vignesh.raman@collabora.com>
 <20240430091121.508099-3-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430091121.508099-3-vignesh.raman@collabora.com>

On Tue, Apr 30, 2024 at 02:41:18PM +0530, Vignesh Raman wrote:
> Stop vendoring the testlist into the kernel. Instead, use the
> testlist from the IGT build to ensure we do not miss renamed
> or newly added tests.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>  drivers/gpu/drm/ci/build-igt.sh  |   23 +
>  drivers/gpu/drm/ci/igt_runner.sh |    9 +-
>  drivers/gpu/drm/ci/testlist.txt  | 2761 ------------------------------
>  3 files changed, 28 insertions(+), 2765 deletions(-)
>  delete mode 100644 drivers/gpu/drm/ci/testlist.txt
> 
> diff --git a/drivers/gpu/drm/ci/build-igt.sh b/drivers/gpu/drm/ci/build-igt.sh
> index 500fa4f5c30a..cedc62baba1e 100644
> --- a/drivers/gpu/drm/ci/build-igt.sh
> +++ b/drivers/gpu/drm/ci/build-igt.sh
> @@ -26,6 +26,29 @@ meson build $MESON_OPTIONS $EXTRA_MESON_ARGS
>  ninja -C build -j${FDO_CI_CONCURRENT:-4} || ninja -C build -j 1
>  ninja -C build install
>  
> +set +ex
> +export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/igt/lib64
> +while read -r line; do
> +    if [ "$line" = "TESTLIST" ] || [ "$line" = "END TESTLIST" ]; then
> +        continue
> +    fi
> +
> +    tests=$(echo "$line" | tr ' ' '\n')
> +
> +    for test in $tests; do
> +        output=$(/igt/libexec/igt-gpu-tools/"$test" --list-subtests)
> +
> +        if [ -z "$output" ]; then
> +            echo "$test"
> +        else
> +            echo "$output" | while read -r subtest; do
> +                echo "$test@$subtest"
> +            done
> +        fi
> +    done
> +done < /igt/libexec/igt-gpu-tools/test-list.txt > /igt/libexec/igt-gpu-tools/testlist.txt
> +set -ex

Is the list in sync between x86 and arm/arm64 IGT builds? Is there a
chance of having a safety net here?

> +
>  mkdir -p artifacts/
>  tar -cf artifacts/igt.tar /igt
>  
> diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_runner.sh
> index f1a08b9b146f..20026612a9bd 100755
> --- a/drivers/gpu/drm/ci/igt_runner.sh
> +++ b/drivers/gpu/drm/ci/igt_runner.sh
> @@ -59,25 +59,26 @@ fi
>  
>  curl -L --retry 4 -f --retry-all-errors --retry-delay 60 -s ${FDO_HTTP_CACHE_URI:-}$PIPELINE_ARTIFACTS_BASE/$ARCH/igt.tar.gz | tar --zstd -v -x -C /
>  
> +TESTLIST="/igt/libexec/igt-gpu-tools/testlist.txt"
>  
>  # If the job is parallel at the gitab job level, take the corresponding fraction
>  # of the caselist.
>  if [ -n "$CI_NODE_INDEX" ]; then
> -    sed -ni $CI_NODE_INDEX~$CI_NODE_TOTAL"p" /install/testlist.txt
> +    sed -ni $CI_NODE_INDEX~$CI_NODE_TOTAL"p" $TESTLIST
>  fi
>  
>  # core_getversion checks if the driver is loaded and probed correctly
>  # so run it in all shards
> -if ! grep -q "core_getversion" /install/testlist.txt; then
> +if ! grep -q "core_getversion" $TESTLIST; then
>      # Add the line to the file
> -    echo "core_getversion" >> /install/testlist.txt
> +    echo "core_getversion" >> $TESTLIST
>  fi
>  
>  set +e
>  igt-runner \
>      run \
>      --igt-folder /igt/libexec/igt-gpu-tools \
> -    --caselist /install/testlist.txt \
> +    --caselist $TESTLIST \
>      --output /results \
>      $IGT_SKIPS \
>      $IGT_FLAKES \

-- 
With best wishes
Dmitry
