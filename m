Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E368167DAB
	for <virtualization@lists.linux-foundation.org>; Wed, 29 May 2024 07:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968689; cv=none; b=PhhwqFSBfaoD8dUeCH6Dr7ZDJPjZT3vbhE5d65iWoYytZYmw63yBNehnZwTu18gP6tTv1l4dwBNLI5nkBl2XagoU8jeCYCV4ALDQwrBfisAZy4fKiiHD9yEkj7L7Cyq3Ok58MbmHnQC+kjWI9bt7/AS0vcvZLY+cgha9ucbYGyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968689; c=relaxed/simple;
	bh=V2Tay+cwE/xAfntGJvfIlOvq+Bb4o/mzQBalXXWGSTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErELA+diZlUW3eB5k9pL3PSXyJ3bZM6nMWufovahAGVlU+ivKfrdks2MmPTUJgr2WXNHxJY6/C+yYKEKuX7YXiFWHQsOlWdBoT7aobHc3CX/xSXakV1QBiXggHkrJcDMJXj02w2xUJKqEEOMCeFKfXGKGqEEk3Q6gaHWd3/A9EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DcItz9bf; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DcItz9bf"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F29E6076A
	for <virtualization@lists.linux-foundation.org>; Wed, 29 May 2024 07:44:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x43RW0NbVC45 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 May 2024 07:44:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::22f; helo=mail-lj1-x22f.google.com; envelope-from=dmitry.baryshkov@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 43FF360604
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 43FF360604
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DcItz9bf
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 43FF360604
	for <virtualization@lists.linux-foundation.org>; Wed, 29 May 2024 07:44:47 +0000 (UTC)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2e9819a6327so20696621fa.1
        for <virtualization@lists.linux-foundation.org>; Wed, 29 May 2024 00:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716968685; x=1717573485; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S1XyMvug7w7dhtxZdl8ZlGvff2YgfxxUHgfNNPJEirc=;
        b=DcItz9bfjL6WnOR2BlCQBpwAV93ucmIhedjDwmGjN5nqhWp86tRLpC9CScuwMFsGrm
         8lJAmRKmVKsWjRx00keryDWp6lyuiB5SfvvQ49WmfToyOEPZq9PLp3O2rYigrOEmcLHN
         Bp1qHGShMj/oduUK0VuwEq2XPQR8ieN9z5YCnAg2mX+bHDssaFfeHIziCVQeNXE+TOui
         VmoF+OWa02EhEijwD1+Xy4dUTClrc9Wz8sK62DObF90Qal+TGQtcX1FF26sXJMyAx2eE
         /ZVx6jqbVbLt6kqeCNvJ6/R8fov/JkPnNMRDJphdbFAiS3tAQ1V/RwI+msDp+3cewbNn
         dV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716968685; x=1717573485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1XyMvug7w7dhtxZdl8ZlGvff2YgfxxUHgfNNPJEirc=;
        b=KUEkojOIhsQG83UDlG6+TzlAj3y807XFKYn1H4+S3CJ7lIrpRfVymPyL4sHyl5fRZv
         Pq8/i7fK9xP65sS6y+YZSnxhejl20rJ2iMsRCwb4vctN/FOk5teJeIVoNR1pFcDRZ56e
         FQYxGynsPNXYUZKf9HC9WDeEte/8ZzufLADrXH/t4VjiC4UG+tVUOsntQt0+PC0eMUk6
         d2eCXG1rWrpFx9hGuOUISK1FucLBtPtK8XxkLxonDnwGSNbfxzyJIE929IwRT6jDiZPg
         MY+Q926GvOZihet56+cGODnTBMRvOQNWo2ld+cv7YCEXPdamdAxnBKKw8gypK1NsOQAV
         sgWg==
X-Forwarded-Encrypted: i=1; AJvYcCWYHrMSEksIoxWvJORxqVqEadqvcfLkBq92BXpIkcOXJ/ARjW7RhqWVvAb/NwuMxb0sOlAuy7IErC+9qb9FngGROY1Y/676j6FvMvofWg1qw3ruSbl+QO4yKw==
X-Gm-Message-State: AOJu0YyE5wPFSJwlcHxFnnnFxIvNE1E//3305Xrd+mjPzQX6shQbseoi
	FqGLeg6FXGmJgENMESQKGqKkOvC+OR2iXeXF7Vfswh82eckwj4ZUcaTlFXDxnWY=
X-Google-Smtp-Source: AGHT+IHWA2lvLG0B0kntbUD/V5owakoa3EW0tQI6tq3UwCSFqELYaCxoJok/0cawUBov1/1KRXreEw==
X-Received: by 2002:a2e:b05a:0:b0:2e7:c29:dadc with SMTP id 38308e7fff4ca-2e95b24e06amr72686241fa.34.1716968684582;
        Wed, 29 May 2024 00:44:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e9816943d2sm6297271fa.61.2024.05.29.00.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 00:44:44 -0700 (PDT)
Date: Wed, 29 May 2024 10:44:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	david.heidelberg@collabora.com, guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] drm/ci: generate testlist from build
Message-ID: <nsamdoevg6fhop3otikwsmu4ga6ysyrg2ogxbqhw3sqg2nbqq2@n5xbqid7ltiw>
References: <20240529024049.356327-1-vignesh.raman@collabora.com>
 <20240529024049.356327-4-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529024049.356327-4-vignesh.raman@collabora.com>

On Wed, May 29, 2024 at 08:10:46AM +0530, Vignesh Raman wrote:
> Stop vendoring the testlist into the kernel. Instead, use the
> testlist from the IGT build to ensure we do not miss renamed
> or newly added tests.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v2:
>   - Fix testlist generation for arm and arm64 builds.
> 
> v3:
>   - Rename generated testlist file to ci-testlist.
> 
> ---
>  drivers/gpu/drm/ci/build-igt.sh  |   35 +
>  drivers/gpu/drm/ci/igt_runner.sh |    9 +-
>  drivers/gpu/drm/ci/testlist.txt  | 2761 ------------------------------
>  3 files changed, 40 insertions(+), 2765 deletions(-)
>  delete mode 100644 drivers/gpu/drm/ci/testlist.txt
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
