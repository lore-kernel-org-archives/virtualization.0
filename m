Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B1580C16
	for <virtualization@lists.linux.dev>; Thu,  4 Apr 2024 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228896; cv=none; b=fP5dr8Y/fTSxAKe+TRQ0C79TvBuSlnE4jaQ5Z+s0OAdD/pSiJBblAHJO8wxug8CUZf2eOROSqS7Spzzqai4vXN4GIz/kzDwEmXcLlvXrK3rQRbMjcmJVUaIbpkB8mISGQL918ZE0fHrvb08c8hkeUMgqkFY6KAYOdN6r/L9BCek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228896; c=relaxed/simple;
	bh=b9wRAhDeshh10P0TwW9VE8z5e9tGLWnK8X6agCj/Bog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EllmHBYzqfHZZy4R8oOUQZCgaSJSvjfOraKqY7IVP69F1+L+9NknNtpQtcv5tq7Ss3GuWTgbyowvavT60O0eHDTrJ/z2J3FprNY16nPOJtlTRu8LQSQvksMSP0MZkQLAN+nlJE4L/Kc+RSS+UkJmwp662gzGMvTcK7jx9z8h2v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dZ9LVaYk; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dZ9LVaYk"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a50f170b7e3so116181766b.2
        for <virtualization@lists.linux.dev>; Thu, 04 Apr 2024 04:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712228893; x=1712833693; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XHYX+6wGVMHeamknM7Pg3k7ckv45aX0Tuc02oE5EGZo=;
        b=dZ9LVaYkC9Q/ve7Slp5CRIHwHmeom8BeqLywGxaqoTZMDUyFsT1FH5+f1PrAWUBH2U
         xYpUn0pjkIMaC9kZDaUtJhbG57Z1Q8PsGp+vdCeNXM+bGLRy1NyH6y7wZcMmsgVx6fSg
         9rp9oeTG8dSA7k/bR8op/N5Am2VZVIcUMEteSLAkkLz4uvchsDEAR1DXkYadSfy+5WRO
         wkYI3toAQJACzVI1JDjnNw0t8C/pc+EsBlRT2Dei5Vkwr/M0g+oVtVe9It2XIjkeIulr
         6wn1+fHHqSrc4eQ7bVizl3+RJnWuL4ik2Js21/V45Oo/hLHisapqA9kvoqYE7eVCY4/a
         IsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712228893; x=1712833693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHYX+6wGVMHeamknM7Pg3k7ckv45aX0Tuc02oE5EGZo=;
        b=uHBwb2fsAE+jTiS47m/y+4A6Q0nmaDlLY3tN+8Q73tLg0FA2anM9ofGtIsZuyNmnnS
         vVApHTtp+lbkBRSqh9qlfR9UflsB3Jc2DJkbKic4CM1dEanbG5Z46W/dFMYyVyEDQAk2
         Dh+bibJ3ONTE+/Hg3gQtHf4gZq8YN+cj7VyGL9FGqvOfCv8PcOFiTqnecWOOF8fK4fOa
         867Xk8OrxTtXxjEcaxuNDp7hlmoZyriJmXdYYFmK6iusk8IKFElk10fARTYPsanYAs+0
         lX/yrBIE0gMo7pXU2WErgfNE9WIUS3uwsle04/rAx7CsWO40PUEy5qJQeKrz7pAcqo4J
         emkg==
X-Forwarded-Encrypted: i=1; AJvYcCUdX6AReNLeu+JvIpnCVh8wZK+PGli6AGcuBXGw+MWQEOnGcTp1b2YByxeLbli2LvFZgNX8tFuSrrcbKxPLVb4YNwUyjmi+fGaJqWhI67w=
X-Gm-Message-State: AOJu0YyaY6FPopVo1Ew+BCaJlW3Nqcy9AlSrBKfc9CkKQwl44bFIFE9A
	VwPE1zeV9Ivjm6f5K/2FY1zoF2hudoERM2pCUR96sLAhMzSZLj/focaJp2DCK4Y=
X-Google-Smtp-Source: AGHT+IEwWasdhwJaS9vUXUMAlSdyN0d8CLHZIu2tQiTvCmJ1aDUIwnQzoZygayQdRyXB/log4Zvjmw==
X-Received: by 2002:a17:906:a02:b0:a4e:2d69:e379 with SMTP id w2-20020a1709060a0200b00a4e2d69e379mr1481920ejf.4.1712228893383;
        Thu, 04 Apr 2024 04:08:13 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id xh12-20020a170906da8c00b00a4e579ce949sm6017903ejb.51.2024.04.04.04.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:08:12 -0700 (PDT)
Date: Thu, 4 Apr 2024 13:08:11 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Ajay Kaher <akaher@vmware.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Alexey Makhalov <amakhalov@vmware.com>, 
	Anup Patel <anup@brainfault.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 04/22] drivers/perf: riscv: Use BIT macro for shifting
 operations
Message-ID: <20240404-9a84f2090d00f6b994e1de7c@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-5-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-5-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:33AM -0700, Atish Patra wrote:
> It is a good practice to use BIT() instead of (1UL << x).

(1UL << x) isn't generally a problem. The problem is with (1 << x).

> Replace the current usages with BIT().
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 20 ++++++++++----------
>  drivers/perf/riscv_pmu_sbi.c |  2 +-
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index ef8311dafb91..4afa2cd01bae 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -233,20 +233,20 @@ enum sbi_pmu_ctr_type {
>  #define SBI_PMU_EVENT_IDX_INVALID 0xFFFFFFFF
>  
>  /* Flags defined for config matching function */
> -#define SBI_PMU_CFG_FLAG_SKIP_MATCH	(1 << 0)
> -#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	(1 << 1)
> -#define SBI_PMU_CFG_FLAG_AUTO_START	(1 << 2)
> -#define SBI_PMU_CFG_FLAG_SET_VUINH	(1 << 3)
> -#define SBI_PMU_CFG_FLAG_SET_VSINH	(1 << 4)
> -#define SBI_PMU_CFG_FLAG_SET_UINH	(1 << 5)
> -#define SBI_PMU_CFG_FLAG_SET_SINH	(1 << 6)
> -#define SBI_PMU_CFG_FLAG_SET_MINH	(1 << 7)
> +#define SBI_PMU_CFG_FLAG_SKIP_MATCH	BIT(0)
> +#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	BIT(1)
> +#define SBI_PMU_CFG_FLAG_AUTO_START	BIT(2)
> +#define SBI_PMU_CFG_FLAG_SET_VUINH	BIT(3)
> +#define SBI_PMU_CFG_FLAG_SET_VSINH	BIT(4)
> +#define SBI_PMU_CFG_FLAG_SET_UINH	BIT(5)
> +#define SBI_PMU_CFG_FLAG_SET_SINH	BIT(6)
> +#define SBI_PMU_CFG_FLAG_SET_MINH	BIT(7)
>  
>  /* Flags defined for counter start function */
> -#define SBI_PMU_START_FLAG_SET_INIT_VALUE (1 << 0)
> +#define SBI_PMU_START_FLAG_SET_INIT_VALUE BIT(0)
>  
>  /* Flags defined for counter stop function */
> -#define SBI_PMU_STOP_FLAG_RESET (1 << 0)
> +#define SBI_PMU_STOP_FLAG_RESET BIT(0)
>  
>  enum sbi_ext_dbcn_fid {
>  	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index babf1b9a4dbe..a83ae82301e3 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -386,7 +386,7 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
>  			cmask = 1;
>  		} else if (event->attr.config == PERF_COUNT_HW_INSTRUCTIONS) {
>  			cflags |= SBI_PMU_CFG_FLAG_SKIP_MATCH;
> -			cmask = 1UL << (CSR_INSTRET - CSR_CYCLE);
> +			cmask = BIT(CSR_INSTRET - CSR_CYCLE);
>  		}
>  	}
>  
> -- 
> 2.34.1
>

Other than the commit message,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
