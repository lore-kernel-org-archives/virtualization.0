Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E4B2609C5
	for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529849; cv=none; b=l0i7uiuzQcuQau9kK2sMFsNEl9szxp+D6r9HNiRObMI4wt6uc1f6A6o6dzKXX7A6HKBTELFhdKTCmY69QCck5S16LqxleTFT4kAE8jxzY9iWtKrOECvIg42l+zq7DKkVvAbQKuvWHTXcK481I4fga392vxoXCZ2WRDFO1PzYIAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529849; c=relaxed/simple;
	bh=cYYrig6PV1TMFUpvdrC38s6x3cKU7TXE8XEtRmDi518=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OcQ6oyv/4ZyueFlSxaEf2mfHTGsK0UO1ho/IM/4C7V7D5U3G27FEscTB1PoonoQwF1vOoeyRX50kq+DFOOoroWSvGOgBMfNO+zokWcnHD/+BsP5ptJ3jG0ppAJqN0gJ94X5dmk8F0q2L0tf3f9M3YMaxxIcz4aS8KawEC/PE/Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=B1qEPehq; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="B1qEPehq"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-88e22898072so97485985a.2
        for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 05:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1760529845; x=1761134645; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X3tSr4HAvbS0zz40z1XcCEFjgrGlF3qXMnfs2AVWb3Y=;
        b=B1qEPehqKSnU1V4o0NanpgSp8zb9I4GQpieb+OluhHjkCs9tPGl3ur7/jPLMdCrFrR
         6O6mXURbBH41USS8iiBxBAavLEgxMG2LKPPc+ckf3yoFRVEJS75yEoKlO3l7nAyEPqYh
         mGmYnPuNVKeysDwduCV5DcJN+s6lBDx2Lu8et8rXWHc2gwWQh4afYIdwVr6biTCpuQnt
         5IaDfB1hBK4eb8WFN9TwSK+Mwj/FWLyYtNSplP22pXn53XWu/pt5Od7qxvUaoOle2b6C
         jsREA4ZhcZrr2wdfnbJqr26X95+bEvErYSJvwQULP/RhW5tXNeQX3M82fJIG+PXBnF8o
         HF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760529845; x=1761134645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3tSr4HAvbS0zz40z1XcCEFjgrGlF3qXMnfs2AVWb3Y=;
        b=JkqMwEfYULf5ThoHU8OdxWmNffLkgUdl1kM0du60f3VVCn1olHlzrAPNQy56x0u83e
         CKzH2FJOfGlrM+/6cm3GwwIJaN4tFaCV4jJmKi8oMJc19FZ/EO13csZWLuULha0Y3OiV
         Ot0N8/wJmMsfo654j2glMEkS5wcsdOxDKvSjmwvU/xU/dWVZ7BsQ06PkpohudYMpdJ3t
         nI4EHiZv4L+aHwmW7Rw0T2UExO7pMZKcInGc8bc8yIQ8HJTnmvOl1rbH9F8sQ8ubKlpa
         lxHz5wRhBNkvURyf2r0/4b1ZmIF2Xk/DLo/J0/FJOK37WpEkoZiBm+cw+UaFqhAnb6PF
         1RRw==
X-Forwarded-Encrypted: i=1; AJvYcCW1bf/8qfJSVEGRL4PF1qEXIOeEkfGEybz5+RGUdCIiBlCf4LznCB9am9PyfTowgQz/IHCH1jZrT9SSt8tR1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YySBlpVrq3Jnr4bL/lbXt4CFr6ytokplhLQAq7sf031O5rCu/hQ
	RzRV+iHxnDl5ufiKsNE+eFyeRDRiNPTfT3q22KuonSySJAEiE8AVc87VGQ7YVPwet0j32sXco57
	iuja9DrQJyTtoI2G0vL3GdYYe2d3gR9k/RQFsCQrdTQ==
X-Gm-Gg: ASbGncsFWSlRIp2Jb7l1HpjE4Y7+oskTSwMWVzCT+P8c/hW8dq6asSG5424O9qg0AG6
	167NeySlSDB9R6iKgDgc6l7jwKPOJv6A+dsUfdRCd9y6v0BZhNAL3OxB+34q8MaYiXtseWMFtIR
	zV0urhE82xWcZmcHgrCjmBXmF7wFI0hJExjf/HoFPa4/CzVW1Frk62tgw+tgbbJKtwr30KpNdMt
	NgdSPDMB8tFUhny/Ub1TlrxZ3Nwz9y8MQ==
X-Google-Smtp-Source: AGHT+IHqCTndsaW9mNNOpEoxqpK+g671TVftkJwHJncfJRnISWrovh6jkW0GrLsJk4LzlYEdY/SfnIetRnQxqll+9N8=
X-Received: by 2002:a05:620a:d89:b0:859:7e5d:efb0 with SMTP id
 af79cd13be357-883521dbdb5mr3978297485a.43.1760529845105; Wed, 15 Oct 2025
 05:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250718105407.32878-1-vignesh.raman@collabora.com>
In-Reply-To: <20250718105407.32878-1-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 15 Oct 2025 13:03:53 +0100
X-Gm-Features: AS18NWCXawAF8rrUemNB4cY6pOyINS36FA1C_QZssu58BBI9i4GnKsHpaQ9lquo
Message-ID: <CAPj87rMRKdm4BvfD8gMmSF3jjeMK4nurzTKPOFY15V0tBr4pyw@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] drm/ci: add new jobs, uprev IGT and mesa
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch, 
	robdclark@gmail.com, guilherme.gallo@collabora.com, 
	sergi.blanch.torne@collabora.com, valentine.burley@collabora.com, 
	lumag@kernel.org, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi VIgnesh,

On Fri, 18 Jul 2025 at 11:54, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> This series introduces new jobs to drm-ci for testing the following
> devices:
> - rk3588-rock-5b
> - mt8192-asurada-spherion-r0
>
> Other updates include:
> - Uprev IGT and updating test expectations accordingly.
> - Adapting to recent changes in Mesa CI, such as:
>    - LAVA overlay-based firmware handling
>    - Container/job rule separation
>    - Removal of the python-artifacts job
>    - Use of the Alpine container for LAVA jobs
>    - Various other CI improvements
> - Disabling bare-metal jobs for apq8016 and apq8096, as these devices
>   are being migrated to LAVA.
> - Updating the runner tag for i915: cml (switching from hatch to puff)
>   to improve device availability.
> - Adjusting parallelism in jobs (sm8350-hdk, amly) to better utilize
>   test resources.

Series is:
Reviewed-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel
