Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B1816C852
	for <virtualization@lists.linux.dev>; Fri,  5 Apr 2024 12:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319474; cv=none; b=rSKyPjgYitEW5y16kmUb9MziHIarLOWqbBMV7ynh9BiqhKHWg4sPZG+a8xfHbzp0qul4LqNttH2R4IhV1g0Gn94gMpSLACSau+Am5uuMcpWC0phQub2/Jr4lrh1L3zfNsDIHqvEvq1NR1v6CJ4cdUDmymScfwh2IsybZb+uh7Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319474; c=relaxed/simple;
	bh=ZaMBHOKq748J8AuTwS4EK3v5U+cz98pQBcMrLhGPsgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBw9xh9Vy0H8kDlOP8iOr4SfsP2te9fUyAt2CVoF8ZD6pWfUoXUk31XTpcVp7R74/5+lVsVMdCtAxVzdH2eSEkjfNm/9uP60jO6xpgIo/eshJtrqIE0OgIk3bJYpkS0aiR2A3TGlKg6h9Y1gn5a0prZSVdSQjbZfGRIwHohdE8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=n9ySDu0p; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="n9ySDu0p"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4162f7ea4d0so3037685e9.1
        for <virtualization@lists.linux.dev>; Fri, 05 Apr 2024 05:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712319470; x=1712924270; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0g33fTsVSlizqg1S+bo16IuI7wIXRqKOdHvOtcRNGdQ=;
        b=n9ySDu0p43ZdKIN4LY7IIA2w+AQyUCKD1ZMuJW9oMjXduEx7HGk0+pbvO2A6NwKQjZ
         coejcExvQSTEx8IEwPW2JPxXI9j1a8tnd3aqobJ5xg+Mi5Ik1YvZ2dmskdt569ZMjOxP
         P+mm2Xzq3WNoDuUTdOTFtPOVDQ6y8bTxmIVS/cjgcuf7eRxCxOhLEm5/mfPa0iKAAEvz
         hjGYQ5ZJVBMuTCZsd/fo+f0BBiea2GoDtdJDwmf7CgJYltFpvPzgtrBKQaPTUnWQxZ1w
         UuVjqLWS0/PpUAK8De7omJLDioPHI0+UkfoIhhuHpAgAm46pDiDepFXYguYlAPDcnXhu
         W3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712319470; x=1712924270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0g33fTsVSlizqg1S+bo16IuI7wIXRqKOdHvOtcRNGdQ=;
        b=h3TQJ5ek5h4GlyoNTOxlA3NBwxvT26k/mCObgP63lz8bzruccdoCv9SzdeIQ+VN+GC
         Y01ERD797toODalkO2r//Eb1uFhMK8TGx8LLhCgpuewqG+egJwHWsYmaz4zeSKbrjk/5
         3nYQbimIjJnMqO/ravXz21GPa6CwFcBaumYCzCZfxqwNu4RHBekxVdtVXL6r3fDr+qkD
         ygMc8QAFVjEFu9usLWRAaoKjYeXLypvH33UicmOOyo7hq72i7Q+tRIGFAHrb8w76iwuS
         uHYCFqa71LuaKBx2RH4YSweGENaw8RyCd6VkwMp3RRVk09hanV5lJW9rvSA69qI3iXr9
         1Qew==
X-Forwarded-Encrypted: i=1; AJvYcCXtzy44IPUX15fE1xnuGtsU9VeTCWlHd+bHUV9+f7P8WES11wUB5j4Z3GYaGWBmCvztU7d582siqN72j7RKb858AJFsSLLd8gXCCNr9RT0=
X-Gm-Message-State: AOJu0YyGZyv2N95cA+hjEblnIYbtNsgXSzqRqybGef18ZCyjCbN0/TL1
	DNa1miiTI5UGTkyl/jiIK3hGL5JlnG40SoppIoR56ZhuYK0N7EzjoS2/sD6xYeo=
X-Google-Smtp-Source: AGHT+IHSUvbZnvo4yH+jaq8czfWTlAV7G9MX9xSOk1rTV7ws0g9gKf124xz7RpWYcZhefNvu3BhLlw==
X-Received: by 2002:a05:600c:4746:b0:415:431d:7747 with SMTP id w6-20020a05600c474600b00415431d7747mr2014418wmo.7.1712319470607;
        Fri, 05 Apr 2024 05:17:50 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id j10-20020a05600c488a00b004161ea7ed6dsm6093903wmp.38.2024.04.05.05.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 05:17:50 -0700 (PDT)
Date: Fri, 5 Apr 2024 14:17:49 +0200
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
Subject: Re: [PATCH v5 17/22] KVM: riscv: selftests: Add helper functions for
 extension checks
Message-ID: <20240405-dae6363b92b742554e85cf4c@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-18-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-18-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:46AM -0700, Atish Patra wrote:
> __vcpu_has_ext can check both SBI and ISA extensions when the first
> argument is properly converted to SBI/ISA extension IDs. Introduce
> two helper functions to make life easier for developers so they
> don't have to worry about the conversions.
> 
> Replace the current usages as well with new helpers.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  tools/testing/selftests/kvm/include/riscv/processor.h | 10 ++++++++++
>  tools/testing/selftests/kvm/riscv/arch_timer.c        |  2 +-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
> index 3b9cb39327ff..5f389166338c 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -50,6 +50,16 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t subtype,
>  
>  bool __vcpu_has_ext(struct kvm_vcpu *vcpu, uint64_t ext);
>  
> +static inline bool __vcpu_has_isa_ext(struct kvm_vcpu *vcpu, uint64_t isa_ext)
> +{
> +	return __vcpu_has_ext(vcpu, RISCV_ISA_EXT_REG(isa_ext));
> +}
> +
> +static inline bool __vcpu_has_sbi_ext(struct kvm_vcpu *vcpu, uint64_t sbi_ext)
> +{
> +	return __vcpu_has_ext(vcpu, RISCV_SBI_EXT_REG(sbi_ext));
> +}
> +
>  struct ex_regs {
>  	unsigned long ra;
>  	unsigned long sp;
> diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/tools/testing/selftests/kvm/riscv/arch_timer.c
> index e22848f747c0..6a3e97ead824 100644
> --- a/tools/testing/selftests/kvm/riscv/arch_timer.c
> +++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
> @@ -85,7 +85,7 @@ struct kvm_vm *test_vm_create(void)
>  	int nr_vcpus = test_args.nr_vcpus;
>  
>  	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
> -	__TEST_REQUIRE(__vcpu_has_ext(vcpus[0], RISCV_ISA_EXT_REG(KVM_RISCV_ISA_EXT_SSTC)),
> +	__TEST_REQUIRE(__vcpu_has_isa_ext(vcpus[0], KVM_RISCV_ISA_EXT_SSTC),
>  				   "SSTC not available, skipping test\n");
>  
>  	vm_init_vector_tables(vm);
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
