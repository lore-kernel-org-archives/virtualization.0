Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84D24DA09
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716203035; cv=none; b=law79Par8JzESk02eThDVB6lO/BF9VpwWA7RsL85SDVQ/GN1EB43g92xWDSVM8k/4Oz6RSHcSgbC/MY2iIcQbOOzx1xXReuQOtoK0PUUDif5j+ziazdM+mecZwR/ekRFx3ILNsaF5Gda2RFm5JJT7dS+xEau4FQwO2crdnCST+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716203035; c=relaxed/simple;
	bh=f2GOS3i38CUol91F/tTOAP4Cj+v7450c+gpjTS0SyZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MB53x1Kj6LAKN6J/BtsIRRQ54icv01PAUUlEOsa2QEpc46vd7JAtjpTcnbMBmjBSraELGFJB7SjS/eoF57AUsnpy0+ZHtb3KperFAje6C2BrJuWpJ99Xiy+vS+SdC34Ti9k51HUGHMlxYcamp7x9X2qAOztWhD2jaGu6l/DdbhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xIITuMTX; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xIITuMTX"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4158840173
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 11:03:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id be7J_HdlgCK4 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 11:03:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::22f; helo=mail-lj1-x22f.google.com; envelope-from=dmitry.baryshkov@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 75E7A401FE
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 75E7A401FE
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xIITuMTX
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 75E7A401FE
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 11:03:53 +0000 (UTC)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2e3efa18e6aso24423591fa.0
        for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 04:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716203031; x=1716807831; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TrnpWE7dPEJmYiT/RDr1bXYldnFvFFfi6hz3R8sA0hI=;
        b=xIITuMTXoa4Vste7vbmCEhkRAnqcA1RBuX5tblvhHpbMj/G080aLoWJrupNDZwRHpp
         sVm8G8jX9wwOFqUyzPiYn1BQcu0H8XdtTqNVNOCA8RD5RbXQgbSDNCULFqmeKh/uHr6b
         3QuKK8dmdY99r5Q0P2yCchFv7vW4Mj7PLDeWR//eFZdv9l1CCUeuO20iAFQDqVV07uR3
         pKhxYLtNZlIZgolzUlojJIcdUCHpbQ/3N31qbVbAvt+Z8psofa3wJ+C2UXA5s7ORqWZ2
         Al7MIGMjMv68mtzC8TWkqJBkXFDYIGsPoYWaEu4gqEZkxTknN4HgIUVl0b3aZJmbnHZ+
         8GRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716203031; x=1716807831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrnpWE7dPEJmYiT/RDr1bXYldnFvFFfi6hz3R8sA0hI=;
        b=jq05BpxTzMszoAZxrWiqqKo50WKyR4/ZnmvEiHuYM/NW9Yuejxz22gwlxagafYLK1u
         SDWzrBbwbIpX6326jyZC0lOETacRcE9tydpA0FRpRu7Wk3IvogQfb9zvxOOfqevn35I1
         /UhDq6bTeIC57uVzAPVGRDaIcjgAfPXsNXhn0X4Z+3YP16YLRg06YDOs2EMXfwXDlbSY
         bCq1D/6OiFcseW25Ex02fHJS8v4mUQ7ND/Jb6fQb3GNxtoei5FN8hfjtx6meq1oz1dxa
         3l1MWGB/lwU4FVqAC05aWL23fIuUG7LQ+m4I97OpZSwrI+RK5QhFRGgwWLL5uQSPm/v9
         LfXg==
X-Forwarded-Encrypted: i=1; AJvYcCVGwEfc42qpFiNaz2EQA+Tgs+ZQznsgETa3ZAmm8gbNaJ0L/EmBW5ET1Xjkqejav7u0LPA/mlz1z5KDUe2YLGfjDawgJRqXKEVeHKrf8dSUGbQ478ST/Wa+Iw==
X-Gm-Message-State: AOJu0YyFH+v2G9eGsf5TafpiLLMGpKzED/Qa3GkjcN1akB7XrI5Q5ilk
	c69CoCm4aVFywh0N4o4Bfl84kjzF5bh3Y05nGvKarr65rgxx3k5oys6D1Qy8dXQ=
X-Google-Smtp-Source: AGHT+IHrPX1EE5HJbqIWKfZcM1kS0oKboB5I8XtzpfJrKSrhX0xiWZVBV8AXw8xry+E6Y03ekdH7bw==
X-Received: by 2002:a2e:9d8a:0:b0:2d8:611c:228a with SMTP id 38308e7fff4ca-2e71714cb85mr17078161fa.8.1716203031220;
        Mon, 20 May 2024 04:03:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d0ce30e1sm34354131fa.38.2024.05.20.04.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 04:03:50 -0700 (PDT)
Date: Mon, 20 May 2024 14:03:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	david.heidelberg@collabora.com, guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] drm/ci: skip driver specific tests
Message-ID: <mxolwwmi5rjaevuwi7qy6rm5n62rhnpbi7hz4n7xbshmi2hoqq@5uzamkipouek>
References: <20240517092502.647420-1-vignesh.raman@collabora.com>
 <20240517092502.647420-6-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517092502.647420-6-vignesh.raman@collabora.com>

On Fri, May 17, 2024 at 02:55:01PM +0530, Vignesh Raman wrote:
> Skip driver specific tests and skip kms tests for
> panfrost driver since it is not a kms driver.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---

I didn't perform a through check, but generally looks good.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
