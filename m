Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C8F80611
	for <virtualization@lists.linux.dev>; Thu,  4 Apr 2024 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228203; cv=none; b=a7jai99STKpTex5TsM3IG+J9TMqwd07g7w9K9IY1HxcvM2wGHPsClApdQnAKjTc5CAXcjvmm28fw3CQYbQ/tJqzhYHGbxrsaJ2Y5ueCu06qKm+l6x2MF36oS9r0vC7dtKCsxf/mMuNV70oAjDJpy72W3oDUKibz1vlfgP5iX2KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228203; c=relaxed/simple;
	bh=ILJL7HVZXiFmQJJigk5doa9mj2osaYbOmdnt4D25RYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9amv7N+JWAjY4IStOeHno3YK9PysJoHcZg5CFoUlQ6ttweDRsguMKeKHWDvc8SmypsA44XGrdNbn/CBgF2poR1HuJokTd3pHtWbS2Kywi5FgNUmsKQJ043ldSqRc/nXPcIEg9W0kLr3c9Y/I7NY/sCLbekFAmw/2vuKPbC+v0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=eYyQTroS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="eYyQTroS"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33ff53528ceso577421f8f.0
        for <virtualization@lists.linux.dev>; Thu, 04 Apr 2024 03:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712228198; x=1712832998; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EFHFiM3SNW59iwbZR58YbB15YVKnaSxrhFOdislttik=;
        b=eYyQTroSxyoXuuebNU1mYRfi4bA2I8nYRoVSS1oDUdkKzfVPcqUjdkgRyYKZWRW9HE
         KLvzAzyJlV1V4dxvK0nhI6TalSbOI44kD8D2DufyjZN+2hY13zuu+z8CQiJX7qsdzb+y
         omlUZsS5jhpqLsWTIgldO1obhC2pBX5d4M/PK6XAmwv6UbA2JwQBFaGCRMIN/O+JpCZy
         7vZW5axntjEwuxg9HkZCfY0A59VlydwemWsgGbdKFaFNIe7wxaWk2YMQgColjD9oDikH
         XC7Pc6cAt0NRbfLaqNMcJXEbLrLpj1p1YUtVy9AARJeiCdOf1eDOtNpkNp2yglXQ9k6r
         oqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712228198; x=1712832998;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EFHFiM3SNW59iwbZR58YbB15YVKnaSxrhFOdislttik=;
        b=rHZ3tDkwUGUkqNhTfQvgrONtkRpr2B2QpGATwoq47sUMT36tTuXiY1ED1tyJKNHTuO
         IlMjOTlMpClwemiSB1qfootuTEZaScQLCz6xy6Olq8IjLvwZ93v9ETVmdZqdLTino3Nm
         VqCiRgNvhaQqiCh1OuQWOTzGECc9oLoLlBpgXM7/vgcL8AOapzI6QQu0LIhgU/zIatTV
         lNSlVOe3b4Qz8PVuTn5OVMh73w0JMWhsFcD9Bc9/VG41xRvvvkE9ZvDcKmELjGGYg4Yj
         nm+GsIuJ6NBIH5kFfJcyd5COER9vB4bMloILIeWQVnYcfVQxUsalDBftyQZEk+lwjYnT
         4VrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/hEB89GDheHAhCuMa64y4OzsP7cVcY+OPqVs7fguthwWHoOC/CWElzjTSZ6VcBGsdly1Yjb1c7PqmYst0CW0mzPeY+jYfNQUlN9d1MV4=
X-Gm-Message-State: AOJu0Yx1KQ/ZhuSg/nRp86e6H/aURm80Lp6xXk0l2H8/vnxeoWfXDqJ1
	bwF/hbcheG5EqNmgkCEHuMvGfosjgT8BBwRlMEWSyFQHaPr9m/9LO2LerJX9QrY=
X-Google-Smtp-Source: AGHT+IENSyz17ALt9X+5ZUYzaEpWJFzo0+v4zqkPSZygVwnsdSsHijcp2D+46t60iJ6/39PaQMtB1w==
X-Received: by 2002:a05:6000:1805:b0:343:7158:aace with SMTP id m5-20020a056000180500b003437158aacemr1379890wrh.17.1712228198219;
        Thu, 04 Apr 2024 03:56:38 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id f10-20020a0560001b0a00b00341dbb4a3a7sm19705617wrz.86.2024.04.04.03.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 03:56:37 -0700 (PDT)
Date: Thu, 4 Apr 2024 12:56:36 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Anup Patel <anup@brainfault.org>, Ajay Kaher <akaher@vmware.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Alexey Makhalov <amakhalov@vmware.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 01/22] RISC-V: Fix the typo in Scountovf CSR name
Message-ID: <20240404-9c750d13d89168feb5ff34de@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-2-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240403080452.1007601-2-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:30AM -0700, Atish Patra wrote:
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
