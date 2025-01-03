Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1B625761
	for <virtualization@lists.linux.dev>; Fri,  3 Jan 2025 05:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735883942; cv=none; b=YVouK9VzvkOoZ3OJqoQmlI3eOXY8u8Qx/PXomvzopUFtoG+wtfMo9jggcx1gV9N73dqn9n+sN2cxNaLu2OgmQtUQ15hQlqghewcqUft9soyJMQxuCUHXGLFtdTH1k61PG8Eg1+Jt8lUO1lS67wIw/bRo8dyPEfL2Vn5DTwcZ9jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735883942; c=relaxed/simple;
	bh=jq8zaIr86J5t9dGa4kCtGLabIIcRGn7o2639WehuCrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9mmmmrFtRfbHiX8uw/liUqxAufsI8OkfCErniliobhBTIcz4tn89eE31ImdfYNWez8Z7NrG8NXcKUgcIILJZ08l1CHNcARgwOLsJ3zctLzjX+PgqKfNvMgPW0ChjuBJ00yZHKg/QfoRRf6LfagiwRqVZ9sPoWCv7TC4o1Vcb4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IB+LBiSj; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IB+LBiSj"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3022484d4e4so149001421fa.1
        for <virtualization@lists.linux.dev>; Thu, 02 Jan 2025 21:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735883938; x=1736488738; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sFlWSYAVuSson+OhthOc5MObp0JO2PaKlR/7cwxtKLk=;
        b=IB+LBiSjntDH/PQAJDu2rk6FCVJuZqk1eIzhx/zyZ6Jp3Rhk8YPFce4OEUt+aqMx4r
         ENQrtg5dmpvC7XcmSGkODZMx1BeFgxIiSOCADbrCWXnrL19vjV1SSaSBdFn7ZXHVZeTg
         xz/Jd99ykD4+UZ++hMQri46VhWnE8G482vV/Aoofvv+1moVsX35c4ea1LC5KOn8dip0J
         +sWiUKHmvt7pMVjk7npqIfSSQqx2hQhEMrqJQpGNUCZdfa8Vpg3KYqfjWnGsmNFI1OAM
         PvWRlke9hHn4cm04+8w25P+OI81K2jgThiibmf6HJZAuZCTky9HVn7bPN6rxJgDyXkco
         jO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735883938; x=1736488738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFlWSYAVuSson+OhthOc5MObp0JO2PaKlR/7cwxtKLk=;
        b=sYR6rQWTXBfukRBtYHuInZbVgKPtKLrMzj3s8EYbuTFFLreZ17lSWUft+P8+vCsEcX
         Y0KIZsLTOZVhqUW6qJB2wsdeA3ZKyKXpsECfrIKpcmcOs94OhzQRPCRrmv/k6Tw8VDhI
         fDmj8zlmdUagUWF1UIGxq4udwXlKChpHly9UBBaCYn2XqzoIOtmgROZs7wjyNwBzPEhR
         9vpI2j8ya/mhb4tcN8qEmAsIbKpbrmCZBI3Go31NEsQLab3T57xbBfYloohEFecoDkSc
         imeLbMBn5mmwoP8M80SD8JLhPyoVXNydMAg8EBDA2fyBCSSPsPvLeq98xN+iz2U82wug
         2Uig==
X-Forwarded-Encrypted: i=1; AJvYcCUfwEuNyvOBq/J3UJ8F/wj1X/eIxan4LEoqu05OMKnT28ULvt0ooNmO8NusZA6PQAghkaWEZL+vhEGcTqJJCw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxyj8bizHp3UCx4s4j6FJS7KYWJpZt53cFnC04U9PqRTyvTmSvG
	T0h5VmDHQjY2OWPvWYnVhIcY4o8zNMl8ye4vE6VaOiwZVjEhX3JLQ3Z+0XZfNZQ=
X-Gm-Gg: ASbGncugXJcL8VI27RemtFZlYZ2sZpQQiHn+BL3thniyWa1Ii4jRhAuQ6SsjHVB+Bmh
	Nl7+VLdJZBZINMHZJavw5x5h3tXB5XxNV+C37u/PoQqSS5D0XLyeK3FpHtjzDhGU/BbFOiZZiIc
	KuPN/2sdrKd1f5Rr0uwJeGUCKh/4eJRkS3Fmn08ufdmzzskLfi/hdK65LIgEJSHqEu9oMyRdLox
	w5zWYJtgF0/nu/qoUNNJKjiiWnUr+yqeHZC1OYpQBwSWWecC0m4xBbzhd6SL6pbtEiweHooYfxx
	1/QANzdvL8/PFE6+d+BzQHdMv9KNcjaK0DGh
X-Google-Smtp-Source: AGHT+IE6y4JdTtlzcbrnGGg7v7FjSgwU7e/vWxQ7TgNE5uhhWt7BpBzFop0XHrbVtbgwiv0CXbLJOQ==
X-Received: by 2002:a2e:bc1a:0:b0:302:3a46:10a7 with SMTP id 38308e7fff4ca-3046851f9cemr129431821fa.5.1735883938405;
        Thu, 02 Jan 2025 21:58:58 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3049ec4ca6bsm26165151fa.56.2025.01.02.21.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 21:58:57 -0800 (PST)
Date: Fri, 3 Jan 2025 07:58:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/ci: uprev IGT
Message-ID: <dj2r22upxnj2aicjnsvoqnhd4n73tyfgm36jtvixxp4vphocev@gggcjakm3xge>
References: <20241217160655.2371138-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217160655.2371138-1-vignesh.raman@collabora.com>

On Tue, Dec 17, 2024 at 09:36:52PM +0530, Vignesh Raman wrote:
> Uprev IGT to the latest version and update expectation files.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v1:
>   - Pipeline link - https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1327810
>     Will update the flake bug report link after v1 is reviewed.
> 
> v2:
>   - Pipeline link - https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1331363
>     Updated flake test bug report links.
> 

What is the current state of this patch? It would have been really nice
to get it in, we have patches depending on updated IGT.

-- 
With best wishes
Dmitry
