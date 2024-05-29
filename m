Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4207116729D
	for <virtualization@lists.linux-foundation.org>; Wed, 29 May 2024 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968641; cv=none; b=Ogkd+H7CqqA1SdovUYxleZq2eL9QD8ooG9w7SBlCINbhznzYZta1jncoECc/scOOoRUHu63QMCcCzUiNiYzwrVp1bzJIoIMckSB/Y/QIZ/5sYlEXPRb5hGhAV4+iuEJQMcGoV3zRjhUqmzPiRuzBE24CVtI77O6edGD1RdUD18s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968641; c=relaxed/simple;
	bh=+QUSnP/ngwbPQEWBZkzfhpGYUxEWZhbTwbH0REe7wBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q624sc8YN/Bm9rVI8fdT4S5v7ctAVSqPpj0ewRDf8YpMxHU9bkOMEi952q2LlBYZM3AbolPyk+3KdmkDZm7vJXXiM87p9liRYV8crrP/OibAJEmCM50yycznJiBNIQAOHYm+A3GEh2YdqkN4AhSL0P1n3Aigu6SQBtu2iMH88R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IetmP6jf; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IetmP6jf"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CBE7581175
	for <virtualization@lists.linux-foundation.org>; Wed, 29 May 2024 07:43:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 05j5Etxkfh1r for <virtualization@lists.linux-foundation.org>;
 Wed, 29 May 2024 07:43:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::12b; helo=mail-lf1-x12b.google.com; envelope-from=dmitry.baryshkov@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7EC1F810E8
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7EC1F810E8
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IetmP6jf
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7EC1F810E8
	for <virtualization@lists.linux-foundation.org>; Wed, 29 May 2024 07:43:58 +0000 (UTC)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-529682e013dso2062410e87.3
        for <virtualization@lists.linux-foundation.org>; Wed, 29 May 2024 00:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716968636; x=1717573436; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka2Maam5Ei5EuRcb2P0MO3/hFv2w3w7reQQ7Fg93ZTo=;
        b=IetmP6jfMauz1DS61BVjDLP9um4lVdhTCOgPd+aWNf7TyzLFKwIWRBFgpLK/ly9sEG
         USQAuTfqJey5JxgiuLkGJW4FAsdPNAsT0DEWzUFhcHw1JU4uZ0ZH/n6zwOO3S9/84veM
         BdaOqwe6XbBGpGbHvTxXoSlPEZ9EjSoalydc+G/igShwQeufB9+VU+Pje7YZyujx8AcQ
         GkznztkaJ+hYtXcHYKA4kI2nQ2KZBJnSRopIZZJ797xiB0ZutrX7KwEKWcKaDR0vsxnb
         q5aaAbEMaitvprybLk04n6Q++x35IboVJA7VjCCusAKXoblEvL3oLBQH2AeFURRK99QD
         zBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716968636; x=1717573436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ka2Maam5Ei5EuRcb2P0MO3/hFv2w3w7reQQ7Fg93ZTo=;
        b=Jtq1i23WVY3HIftFs9QJtKBlJOjZZL34pkyueDSrYuqgrjbGblFTCbXuV1NThUbdwo
         /TNBuZ0ONZ4W6nZFecA2vsvzq01MWlm7ALyCFLnQ2J2GD/eeveREfrloIhQtyrZeuSGN
         1PVvE5w/NGiAzcSRRnYW2YqMFWK/fW1CUo+cH6ORfpTsSzUO3DlSyX0alBUUKCemyA9k
         EYFsvf2e8wJyFxLadh6zySRsubngEVogOaBxXoRwEO9ccmliCU+GAokb0GEU8VSLcc4C
         1kwFQD0pmS3/qQ8Bvgi97uYyiXDiYns4Ta0yLTOFQdyZ+h4hQkSSfZwdtoLNSxM8Rg+2
         aeMw==
X-Forwarded-Encrypted: i=1; AJvYcCU4yNPprITFs4VmJGm8E8fstNfJ/RSlzmlkyl70WFGF02oQt/Gi0iuol3mfBeFV7IQn1xgyAsYy4a9OKo65/AxKafCQ7gnLayaKLROJQDTm9XZb49BL7OmAuw==
X-Gm-Message-State: AOJu0Yxzp4/K0wBbJHbeF1S+7LPL6t9rgqDnrHiH8fFchL9eKUtweonI
	emveZGdoPTRfYoQS4kyOMPXZD7cETZYilnQfp6DktIfOzWKiOBbR6x/Bdht78mk=
X-Google-Smtp-Source: AGHT+IEpKoJxeYMMRmRHKz19pKO8ijGaGc5T6KYCnRuUNFgdev3K9Yfz0P6oPUoZ1/TYqG8Ww0hnig==
X-Received: by 2002:a05:6512:3241:b0:51c:df1f:2edc with SMTP id 2adb3069b0e04-529644ebe8cmr7988541e87.2.1716968635950;
        Wed, 29 May 2024 00:43:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529a50b1d85sm978336e87.113.2024.05.29.00.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 00:43:55 -0700 (PDT)
Date: Wed, 29 May 2024 10:43:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	david.heidelberg@collabora.com, guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] drm/ci: add farm variable
Message-ID: <xhdcswueynlctjznqnxo663v2k6q2lrk55jjdodrkd7ojijaiw@lg3e2e5qcnny>
References: <20240529024049.356327-1-vignesh.raman@collabora.com>
 <20240529024049.356327-3-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529024049.356327-3-vignesh.raman@collabora.com>

On Wed, May 29, 2024 at 08:10:45AM +0530, Vignesh Raman wrote:
> Mesa uses structured logs for logging and debug purpose,
> https://mesa.pages.freedesktop.org/-/mesa/-/jobs/59165650/artifacts/results/job_detail.json
> 
> Since drm-ci uses the mesa scripts, add the farm variable
> and update the device type for missing jobs.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v3:
>   - New commit to add farm variable and update device type variable.
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
