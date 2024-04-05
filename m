Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B1216C867
	for <virtualization@lists.linux.dev>; Fri,  5 Apr 2024 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319395; cv=none; b=QJRrHmFFdBu24q2GmZCu/RhNmIJkg45go6sKxFpruVhYrZ5kyWlsCNjtFHktQ3Vt0cx/hpq90TllbthRa5tAQ0DPcr5TE3ApC6wgIt2sE1Y7BUSlwLhYoYt6FhMciqlapsw8PXJWqKOesKDboQquAgABvxA1CTfvicJRObJ8OIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319395; c=relaxed/simple;
	bh=WjeDlT9dBOQe+BLqgl2oRIytcPuInRU8X9ml0l76d9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+UDjD1EH/m0hkDd6wxYBSkYRZTQWX4sYjtMxAIC992PVyAXxm8N7rFLAX9MvqjkTmnZqQkApWfV+CJ/D8tIUtOsczkik7smY5viJ8pbONQ0pDG3dTy2Se3hLDKUpNSh/88JaqBaM+IKz93m5oesdjhXPJ/d03JUtAoF7YoF09Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=eIGyMyqG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="eIGyMyqG"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4162bac959cso11869515e9.0
        for <virtualization@lists.linux.dev>; Fri, 05 Apr 2024 05:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712319390; x=1712924190; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YIBbg/0Gkc3vc8eXQdCLIpelrpcjO2owsNnM3FfwOWI=;
        b=eIGyMyqGTW4w2n6FjuRhxsgLnqm5MnCSmEz5kGUlTO/yyneT4vOFYi4UevHrx1IpPY
         /kRTGCFDoAPqKJO7+cCs1PWF2tvmaPGQQUOSzmwfvfUm4HLEaz2th5yEMhKxQDLwfxkw
         Tnz+d3dp734plyUMMe1hCFfu9B6mxBjS7Xk7KMXj5XXDai1GJk1RaH6zx7nEBVtBysum
         MFYxGLlbe8qoD/ExHUkKKy0yisVGNyMb9ceMvOn+2bkPuUQSGA8VDIYSkDlXpVFvdbnb
         pqYMGVcs+HfmoKsoqCOiUNHHndDbB4SmGqd/BEP5E5bg49NR/9TiCrLWDiNIVLV2UaPq
         3KTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712319390; x=1712924190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIBbg/0Gkc3vc8eXQdCLIpelrpcjO2owsNnM3FfwOWI=;
        b=SVOlW944+BlRBAcgNoYbS6K5vsQrqgDILg6bdCZYz+MUAFnmPkkb2wRJlK+arqqu4X
         87pejMiMczswgvj2p4oNTaGck3n81WO5xggEv6ldjQ0yDaNoVD70FeaP5HdmH1e0ktCn
         /n2Q82Z6KSGO8BehYTdAkaeR0rvu/BjUACaLQhDsgh9aG2LFuoK4X9NuKJgIIBFg3qBj
         pt4K2fPICEbBy5MiHcP/lk4BqQU2ifS7prs3Uw5Ru2nZWpjEkGhWJ65ceQUz+9nbhSib
         5c2HJ3FhDa67oV1j59kpodiIlRTOjojhEkgIU3E1ioB1d6wSm4qrMa3fRNg3Im5jSEWq
         GoKg==
X-Forwarded-Encrypted: i=1; AJvYcCX1DKQ0S4N6gg3gJbTSTSwxJgnl5YpK91GfwFa/PHDkevoBXmI/qMOgdzaBVhURduFQCHHg1FtTSnSIiTiok1zTWjiZE9y5auDb0s8ryxU=
X-Gm-Message-State: AOJu0YwB918RcfIgCz4hg4QhfQdKiv+IuxuY/2IwgIdj/GX+8GqemElq
	08Qf+ItoqyO78qIQQYujaMb5A7ZQUTHPwCVaYdmc3Zh+1S943jcPJn/S1gfQwJA=
X-Google-Smtp-Source: AGHT+IHWoJ0SVigRSQdE8aAqZ9Ahbq2SNfjubKUhDIh9/SPSG+4VJxdmaUN4mIX3yesibcIkwnQlKw==
X-Received: by 2002:a05:600c:4e0c:b0:414:250:ccaa with SMTP id b12-20020a05600c4e0c00b004140250ccaamr1142350wmq.12.1712319390374;
        Fri, 05 Apr 2024 05:16:30 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id fc9-20020a05600c524900b004162a9f03a6sm5867007wmb.7.2024.04.05.05.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 05:16:29 -0700 (PDT)
Date: Fri, 5 Apr 2024 14:16:29 +0200
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
Subject: Re: [PATCH v5 16/22] KVM: riscv: selftests: Move sbi definitions to
 its own header file
Message-ID: <20240405-a09f9ed26805b6988179132c@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-17-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-17-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:45AM -0700, Atish Patra wrote:
> The SBI definitions will continue to grow. Move the sbi related
> definitions to its own header file from processor.h
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  .../selftests/kvm/include/riscv/processor.h   | 39 ---------------
>  .../testing/selftests/kvm/include/riscv/sbi.h | 50 +++++++++++++++++++
>  .../selftests/kvm/include/riscv/ucall.h       |  1 +
>  tools/testing/selftests/kvm/steal_time.c      |  4 +-
>  4 files changed, 54 insertions(+), 40 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/riscv/sbi.h
> 
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
> index ce473fe251dd..3b9cb39327ff 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -154,45 +154,6 @@ void vm_install_interrupt_handler(struct kvm_vm *vm, exception_handler_fn handle
>  #define PGTBL_PAGE_SIZE				PGTBL_L0_BLOCK_SIZE
>  #define PGTBL_PAGE_SIZE_SHIFT			PGTBL_L0_BLOCK_SHIFT
>  
> -/* SBI return error codes */
> -#define SBI_SUCCESS				0
> -#define SBI_ERR_FAILURE				-1
> -#define SBI_ERR_NOT_SUPPORTED			-2
> -#define SBI_ERR_INVALID_PARAM			-3
> -#define SBI_ERR_DENIED				-4
> -#define SBI_ERR_INVALID_ADDRESS			-5
> -#define SBI_ERR_ALREADY_AVAILABLE		-6
> -#define SBI_ERR_ALREADY_STARTED			-7
> -#define SBI_ERR_ALREADY_STOPPED			-8
> -
> -#define SBI_EXT_EXPERIMENTAL_START		0x08000000
> -#define SBI_EXT_EXPERIMENTAL_END		0x08FFFFFF
> -
> -#define KVM_RISCV_SELFTESTS_SBI_EXT		SBI_EXT_EXPERIMENTAL_END
> -#define KVM_RISCV_SELFTESTS_SBI_UCALL		0
> -#define KVM_RISCV_SELFTESTS_SBI_UNEXP		1
> -
> -enum sbi_ext_id {
> -	SBI_EXT_BASE = 0x10,
> -	SBI_EXT_STA = 0x535441,
> -};
> -
> -enum sbi_ext_base_fid {
> -	SBI_EXT_BASE_PROBE_EXT = 3,
> -};
> -
> -struct sbiret {
> -	long error;
> -	long value;
> -};
> -
> -struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> -			unsigned long arg1, unsigned long arg2,
> -			unsigned long arg3, unsigned long arg4,
> -			unsigned long arg5);
> -
> -bool guest_sbi_probe_extension(int extid, long *out_val);
> -
>  static inline void local_irq_enable(void)
>  {
>  	csr_set(CSR_SSTATUS, SR_SIE);
> diff --git a/tools/testing/selftests/kvm/include/riscv/sbi.h b/tools/testing/selftests/kvm/include/riscv/sbi.h
> new file mode 100644
> index 000000000000..ba04f2dec7b5
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/riscv/sbi.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * RISC-V SBI specific definitions
> + *
> + * Copyright (C) 2024 Rivos Inc.
> + */
> +
> +#ifndef SELFTEST_KVM_SBI_H
> +#define SELFTEST_KVM_SBI_H
> +
> +/* SBI return error codes */
> +#define SBI_SUCCESS				 0
> +#define SBI_ERR_FAILURE				-1
> +#define SBI_ERR_NOT_SUPPORTED			-2
> +#define SBI_ERR_INVALID_PARAM			-3
> +#define SBI_ERR_DENIED				-4
> +#define SBI_ERR_INVALID_ADDRESS			-5
> +#define SBI_ERR_ALREADY_AVAILABLE		-6
> +#define SBI_ERR_ALREADY_STARTED			-7
> +#define SBI_ERR_ALREADY_STOPPED			-8
> +
> +#define SBI_EXT_EXPERIMENTAL_START		0x08000000
> +#define SBI_EXT_EXPERIMENTAL_END		0x08FFFFFF
> +
> +#define KVM_RISCV_SELFTESTS_SBI_EXT		SBI_EXT_EXPERIMENTAL_END
> +#define KVM_RISCV_SELFTESTS_SBI_UCALL		0
> +#define KVM_RISCV_SELFTESTS_SBI_UNEXP		1
> +
> +enum sbi_ext_id {
> +	SBI_EXT_BASE = 0x10,
> +	SBI_EXT_STA = 0x535441,
> +};
> +
> +enum sbi_ext_base_fid {
> +	SBI_EXT_BASE_PROBE_EXT = 3,
> +};
> +
> +struct sbiret {
> +	long error;
> +	long value;
> +};
> +
> +struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> +			unsigned long arg1, unsigned long arg2,
> +			unsigned long arg3, unsigned long arg4,
> +			unsigned long arg5);
> +
> +bool guest_sbi_probe_extension(int extid, long *out_val);
> +
> +#endif /* SELFTEST_KVM_SBI_H */
> diff --git a/tools/testing/selftests/kvm/include/riscv/ucall.h b/tools/testing/selftests/kvm/include/riscv/ucall.h
> index be46eb32ec27..a695ae36f3e0 100644
> --- a/tools/testing/selftests/kvm/include/riscv/ucall.h
> +++ b/tools/testing/selftests/kvm/include/riscv/ucall.h
> @@ -3,6 +3,7 @@
>  #define SELFTEST_KVM_UCALL_H
>  
>  #include "processor.h"
> +#include "sbi.h"
>  
>  #define UCALL_EXIT_REASON       KVM_EXIT_RISCV_SBI
>  
> diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
> index bae0c5026f82..2ff82c7fd926 100644
> --- a/tools/testing/selftests/kvm/steal_time.c
> +++ b/tools/testing/selftests/kvm/steal_time.c
> @@ -11,7 +11,9 @@
>  #include <pthread.h>
>  #include <linux/kernel.h>
>  #include <asm/kvm.h>
> -#ifndef __riscv
> +#ifdef __riscv
> +#include "sbi.h"
> +#else
>  #include <asm/kvm_para.h>
>  #endif
>  
> -- 
> 2.34.1
>


Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
