Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E231DB94F
	for <virtualization@lists.linux.dev>; Mon,  7 Oct 2024 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319073; cv=none; b=sXDbHpQVhxpE9N9JJiJNFhJcGBEbhSkF8qC5LJVfxYKKILbLTQzrgsl70GxDYA2RjvDM3Iz2tuhrDjEwbhW0hag6mSOZ4PrCIkFcIcBCY4jWB0h1E19AP2XJKsCcXYePH3kbyZlcY072w+jqTn1X6L/6vTTJVOtwAks0hrnO8sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319073; c=relaxed/simple;
	bh=0mzLrB2OomyLtoMgMpkUXKBQAaht79Vh1csmlF+3YCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6e46SyhcvNlaGCczajTelVUDlalD296CidQsW6PUal+UThQGHeF8lSEJlUUdoZXqLGkVBnGBoW2aGwIBNE3MrnsmLvn8+oKtuKwCBPChoj3XxgHIQ+V9cli4qtggp10kyjb/F3Pv44YcllgEnR1pHh+ep0tPZeg1/X9l7+RlL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=bzLpXXlO; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="bzLpXXlO"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a9a23fc16fso416962185a.2
        for <virtualization@lists.linux.dev>; Mon, 07 Oct 2024 09:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1728319071; x=1728923871; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W4CFFIJB0/w1KDKpJP7Na0Tu7Wo8uI2KSmr76xqMrKs=;
        b=bzLpXXlOtzz8PlrfBAcZiSRwhfrERhoZObmzRp1rWfrlUZqrORwqoxC/ItfPA3cUb7
         eDSDEFEC6bEzMIO35xLmIoRjVy72A8WpJDm37w0yoenn90nfb/Xh1Mi+QrHXTDjWEEhf
         lFDohfDFnfapztKz48mZxG7aT5hgf+G6bq9RvWVUu2F+9IVXBqXA1HF86W8r8BxPPUnf
         WSy4tVCXxUMf4VMLnKlE62N7PVMRYmgrYyLdrbEv+NcIdqj8/hZH48iUZysLj1NUGn9G
         cHmseMw+rtiu4juT1Y7hlPQNfwwJKVb8Ccl3TSZxwnAjZa6VL5FiPaOFl5ujtB406tSK
         Cp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728319071; x=1728923871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W4CFFIJB0/w1KDKpJP7Na0Tu7Wo8uI2KSmr76xqMrKs=;
        b=ph+7PuKZiJD5fg6CfxTy/CPtTVaBLndcIdktXpOQubjZUKnFf74o3TAiuyRLLe7GD2
         WLkEyaGdXHlYFexc1W7zL4vGLUQnVHVn/Hsk493NE89IPnHlHhsALm3vBj2IgU3ujbXu
         yhTmfbOpgN9CA3WBS9ZAON4X+CFmxohfQ+TIldtlJhoxki0Kio/CLm5gCfVVIMcdfCJG
         hjVNH+7X1grZknUiATfati/XosODcs9NVXow01U89f98v+/+UUnE62VWa74/Gz4W8VRg
         ys+c34U3HbyOy9hC8yiQRddFprz71DvFGuppoZY6QzCSxN+uaJsT6+DxDBwFN5fNmF6+
         FTRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4i/E1Q1dquZSvjtvMVV/MH+4I8ycKWdt/rlbiAwgRD+5ai3Q9PK3su1FH0wr0JJdRkdH5PqEltb/8SFCCnA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxiMG8lw14bizbmoniaghBQhWb/St8hymTVlfG6vzVcp1EZx/OO
	1SZmtN2+p3g8glEHlfgXMt/1wyJ/zmKtIxXAthO0uAxD72WpihIBTqQBl2TermZnS0QBAJ2ry16
	W9yiW2vveEBzrSogqSiz9021BRZragxMW/Zv0sA==
X-Google-Smtp-Source: AGHT+IFUEdp+6Zfk/3canOH8YLTeCDElWZbOWdFUC/AjiXkqb6tWoEUHRz5ImwY747H/eYo44KjaW8o6FN6Tmv1CB1Q=
X-Received: by 2002:a05:620a:1aa0:b0:7ac:b3bf:c30c with SMTP id
 af79cd13be357-7ae6f48ae1fmr1890545885a.45.1728319070658; Mon, 07 Oct 2024
 09:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241004133126.2436930-1-vignesh.raman@collabora.com> <20241004133126.2436930-2-vignesh.raman@collabora.com>
In-Reply-To: <20241004133126.2436930-2-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Mon, 7 Oct 2024 12:37:39 -0400
Message-ID: <CAPj87rPGD8Pu_CSPXfRtsS_w8UYVJGR9CoLx7RAT69EUKefs3A@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] drm/ci: refactor software-driver stage jobs
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, 
	robdclark@gmail.com, guilherme.gallo@collabora.com, 
	sergi.blanch.torne@collabora.com, deborah.brouwer@collabora.com, 
	dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vignesh,

On Fri, 4 Oct 2024 at 09:31, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> +.software-driver:
> +  stage: software-driver
> +  extends:
> +    - .test-gl
> +    - .test-rules
> +  timeout: "1h30m"
> +  tags:
> +    - kvm
> +  script:
> +    - ln -sf $CI_PROJECT_DIR/install /install
> +    - mv install/bzImage /lava-files/bzImage
> +    - mkdir -p /lib/modules
> +    - mkdir -p $CI_PROJECT_DIR/results
> +    - ln -sf $CI_PROJECT_DIR/results /results
> +    - install/crosvm-runner.sh install/igt_runner.sh

Instead of inlining this here, can we please move towards reusing more
of .gitlab-ci/common/init-stage[12].sh? If those files need to be
modified then that's totally fine, but I'd rather have something more
predictable, and fewer random pieces of shell in each job section.
