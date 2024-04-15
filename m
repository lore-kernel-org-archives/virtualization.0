Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B33E823D0
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186109; cv=none; b=lVqb9vrU+XzGJtc5lfrLkQjU6FkIsCsPL9YeXCl0e9nmKs1BS3voSPZogK9tEAHZYV43BX7rEjh5cykVj0Iq5DuRZWIXKThducnX2yMj19ieEvMMsIeFGQ1VKZFabdBBaF3GmYn3hJTicdprJz75LuwYDadQcMp+MqD81tMvlXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186109; c=relaxed/simple;
	bh=htFP120gjn5bGGk+lM2AXxOpa6zNGkVhobl+AAmgTfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkaltmComwtgyRvJcTpvVUiYeIME8f32slku/DIdcueDfqsR0I8N+U63Wf4kGQejD+yypBS05NAJDRvjIB8hOimOaJXZWRFQOO/E30zyLz6qOE3l+PL5yFw+ubsXH0j7J51j0wY61OUL1Q8h+Uv5Sh7hyGxpaufaEfgguHziUnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=TXje1nrj; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TXje1nrj"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516f2e0edb7so3790678e87.1
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 06:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713186103; x=1713790903; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JAzNe/Dr2zrsI9zQzFBtyYItApxCRsnWpljg+FQj6uo=;
        b=TXje1nrj9pJINJ9HOZZFpGc4qqXSIbkMGr4cq8iPOnMkbmaeEH1zwOZ19/lbX1P9Oi
         HP94txlgn7YtVsOubeN2JuEq3msBWiyScKgl4oZl975vGzazVaT67SkNx24eNbhtPpwE
         oVfbiKMXopC/TOig6CKfq/WjLpO3a3Yrano8kYdr+FhAWyENXG4zdDZNF2NoHg+oamBq
         EoC2aRKk6zLdaWqJfxla1DKiXoEylZ/Y4fs2NoYLkqTH0aMNF+vy8aECUYImYeh1KzQb
         FBIrhpW0XP5whtVJKtnh3h1BKFCo+HCWdrRUAZwv/1c0mzkEam7VnrfA74EYBsJkaTNN
         JxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713186103; x=1713790903;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JAzNe/Dr2zrsI9zQzFBtyYItApxCRsnWpljg+FQj6uo=;
        b=xJutBPOEHjV7nTJVwHobG43QhMZ0HFTpHoaqOaJHMVUaIlNDCoujQKwhYRSdNsWmAS
         iyaNlQjBOvuZZY9bhBWQJ97IWSYysEjC06Lu6rqUFE5sdnM4hsNmJtgy3HhvMyfounQc
         hGSCNALvbyoiHMmfrPhvPBVnOyAxLf6c4vTD3VBsBU+vC6rGRp45GNdmBEEOkk+K64a6
         mq080rzm74ARYiWba42g5bCC88J7kFd8b7vM92kGLEKznmRsBIGlsZqCiSCEaEF7cvyc
         eyu113byOq+66yjhKUdMCLU7GXOwZrL7eIPeIVKn2r+SvniAdCKpkY68mtyO9rX9nXaz
         XOKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbAY/SZp27kEf6u4A4JYrfSvUiGeOgyloMw8HEDRSRcwRwO3Cp2htRav/Rno4WOX0sC7cAqvmKf1TTx6kff9YIw36cpMyz9rirwMOahrA=
X-Gm-Message-State: AOJu0Yzv3tRpMX4uuzGP9ko3h6rYTxLyz7b7OhlmGegFUl1J+QSa8gwS
	hhdXfJ7lzxnPMixfuki8mqOgA4fQ/jyUeTWN7ge3nPafX4GHSgUc4VIIl4se808=
X-Google-Smtp-Source: AGHT+IF1FG1SINFeCjGlp0eZOZIZwVeoNZP8XYe8YPY4t8v9NbI69LFZuWlNvlzfivwxMIckGeJs1Q==
X-Received: by 2002:a2e:b4a8:0:b0:2d8:6b0c:d91c with SMTP id q8-20020a2eb4a8000000b002d86b0cd91cmr5501216ljm.47.1713186103351;
        Mon, 15 Apr 2024 06:01:43 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id r9-20020adff109000000b00341de3abb0esm11994830wro.20.2024.04.15.06.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 06:01:42 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:01:42 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Anup Patel <anup@brainfault.org>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Alexey Makhalov <alexey.amakhalov@broadcom.com>, Atish Patra <atishp@atishpatra.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, Will Deacon <will@kernel.org>, 
	x86@kernel.org
Subject: Re: [PATCH v6 01/24] RISC-V: Fix the typo in Scountovf CSR name
Message-ID: <20240415-b899e62329c901f59db9f146@orel>
References: <20240411000752.955910-1-atishp@rivosinc.com>
 <20240411000752.955910-2-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240411000752.955910-2-atishp@rivosinc.com>

On Wed, Apr 10, 2024 at 05:07:29PM -0700, Atish Patra wrote:
> The counter overflow CSR name is "scountovf" not "sscountovf".
> 
> Fix the csr name.
> 
> Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")
> Reviewed-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/csr.h | 2 +-
>  drivers/perf/riscv_pmu_sbi.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 2468c55933cd..9d1b07932794 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -281,7 +281,7 @@
>  #define CSR_HPMCOUNTER30H	0xc9e
>  #define CSR_HPMCOUNTER31H	0xc9f
>  
> -#define CSR_SSCOUNTOVF		0xda0
> +#define CSR_SCOUNTOVF		0xda0
>  
>  #define CSR_SSTATUS		0x100
>  #define CSR_SIE			0x104
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 8cbe6e5f9c39..3e44d2fb8bf8 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -27,7 +27,7 @@
>  
>  #define ALT_SBI_PMU_OVERFLOW(__ovl)					\
>  asm volatile(ALTERNATIVE_2(						\
> -	"csrr %0, " __stringify(CSR_SSCOUNTOVF),			\
> +	"csrr %0, " __stringify(CSR_SCOUNTOVF),				\
>  	"csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),		\
>  		THEAD_VENDOR_ID, ERRATA_THEAD_PMU,			\
>  		CONFIG_ERRATA_THEAD_PMU,				\
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
