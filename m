Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC1516C45E
	for <virtualization@lists.linux.dev>; Fri,  5 Apr 2024 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712316190; cv=none; b=pVKcMA9LK4Xr8bScIPewxGEIyBVyG657ro143LMC1EB+6Rc5JlWUuGjh6zhoWDozOpLHQivIrIaik86dRPvYF4YCjJXFO5RUBfHN1ATMRqSTQvYCVsxeG8TzKZ4OcvzCnoMdTMUeFyJaPUMT1LT0nybDSTJpOBCnusmsJ8Zz8cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712316190; c=relaxed/simple;
	bh=oGJdt/19LKDTvxYgKTkWSed86buXn0F4UgK7eTA38I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eolPpRtoB/kkMoveFHkV+96YYV3YMdLe9qHqpbBdq5jNvrYW/Sxr9Y3Bswh7rX7pcgKbHmTkPf6aPwJgbMZPsIuRZmMvvZmipfTDcGz2G4a3SYmm1cUXDyH9STnV4W6k7a9uTzcl+XWV/CKFEx/DK0U1AF4ECwUQWUFU86P8yE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=RpwvfbMl; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RpwvfbMl"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d536f6f2so521445e87.2
        for <virtualization@lists.linux.dev>; Fri, 05 Apr 2024 04:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712316187; x=1712920987; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1StIt3kBG1sKfWkM0jYTmYiHX1k739mPkjj6luO5sU=;
        b=RpwvfbMlNgAuuagdN4aecixTyH/flXrj5iq4nfmCh2W89DbRksWzSU+X/XOoXWz0ob
         z1psCeiZQEkleJNlz/I2CnJ1+fCG9rhZISwN0UGO2Y/a9oDT8JpmUAfi+YOlNn808fr3
         pvwFkH/T238Ei6m9inczuRBnhww+AYxJr7r4C83jcLJiLRBicXFdEmSF/+NUcdL+Yokb
         cY7X5gP8bLp++P7PxPfpq43azELMWBYTvga57e7fw5yb02GFJnl7wzvhf0JgeP9P7uOl
         N7Fo6fmrfP40I2WwprqA6e3pAQBtBLxVDAyusMk8VZq5fg26bJN2DK6XX3Zvi34zJe7u
         3g5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712316187; x=1712920987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1StIt3kBG1sKfWkM0jYTmYiHX1k739mPkjj6luO5sU=;
        b=ILvfTAv3jQuvziwaC5gtkZ7qQGaVo8qfe7SsCKCY49A+lNIzC9ypkhy+Qas9Z4QtrJ
         cPTSenyT5/fHldKaSMd+1qDnexfKF0apCPuDLnGwZSFNUJbXxxnlAjYIlDZfG73+TVfY
         ymi7bNkKYFVe1Jf6FoimWYqxzJJRmXH2nvsNtThaJ0cU3EFz+oJUSv69K1Ne42lbWkhv
         GyVrgoICJ49hm3wqvuyie1Lvn+x7a9Tp3qEt2LjZhU38ueB2M1yomaljCmbXULdlObD6
         Hn3go9Q7Dhzo+N0zlnLXeMS//dHZ9UKVytH+P0n56bkTUSgx4O/ybcFOrxFFeurjXybz
         eAHg==
X-Forwarded-Encrypted: i=1; AJvYcCXDVyIdjIyrDJRTHWDe1oVCCkkXlpj3A6jxDemNgi67ZMyLRvHlHf9MwY3Ujdw41YrJ9myXOvwPuCnOAhS2zafUZeU9sWBpaC/DJA1iYqY=
X-Gm-Message-State: AOJu0YwLzBU6y5t7PS3szpXnhSQhMSvUPTi0fRbzaTHXITGfR7ekJGQb
	CxDEoGFSIVpLtdh3Y4mdTbUAiBUgE9C1YIv6JfNUi4XuV8hUUj2+aq7VBuaAmHw=
X-Google-Smtp-Source: AGHT+IHkj15u2Bxl0RbCYsvSnoaNnRvyO2MnsCgl4V2xQvxUMx8unnpUY36pEW96b3ybfXEcZnPVSw==
X-Received: by 2002:a19:f604:0:b0:516:d152:b892 with SMTP id x4-20020a19f604000000b00516d152b892mr952297lfe.60.1712316186941;
        Fri, 05 Apr 2024 04:23:06 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id j13-20020a50ed0d000000b0056c4372c161sm686856eds.55.2024.04.05.04.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 04:23:06 -0700 (PDT)
Date: Fri, 5 Apr 2024 13:23:04 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Ajay Kaher <akaher@vmware.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Alexey Makhalov <amakhalov@vmware.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 12/22] RISC-V: KVM: Implement SBI PMU Snapshot feature
Message-ID: <20240405-1060c986299eaac3528c7d4f@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-13-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-13-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:41AM -0700, Atish Patra wrote:
> PMU Snapshot function allows to minimize the number of traps when the
> guest access configures/access the hpmcounters. If the snapshot feature
> is enabled, the hypervisor updates the shared memory with counter
> data and state of overflown counters. The guest can just read the
> shared memory instead of trap & emulate done by the hypervisor.
> 
> This patch doesn't implement the counter overflow yet.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/kvm_vcpu_pmu.h |   7 ++
>  arch/riscv/kvm/vcpu_pmu.c             | 121 +++++++++++++++++++++++++-
>  arch/riscv/kvm/vcpu_sbi_pmu.c         |   3 +
>  3 files changed, 130 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include/asm/kvm_vcpu_pmu.h
> index 395518a1664e..77a1fc4d203d 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_pmu.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
> @@ -50,6 +50,10 @@ struct kvm_pmu {
>  	bool init_done;
>  	/* Bit map of all the virtual counter used */
>  	DECLARE_BITMAP(pmc_in_use, RISCV_KVM_MAX_COUNTERS);
> +	/* The address of the counter snapshot area (guest physical address) */
> +	gpa_t snapshot_addr;
> +	/* The actual data of the snapshot */
> +	struct riscv_pmu_snapshot_data *sdata;
>  };
>  
>  #define vcpu_to_pmu(vcpu) (&(vcpu)->arch.pmu_context)
> @@ -85,6 +89,9 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
>  int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
>  				struct kvm_vcpu_sbi_return *retdata);
>  void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu);
> +int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long saddr_low,
> +				      unsigned long saddr_high, unsigned long flags,
> +				      struct kvm_vcpu_sbi_return *retdata);
>  void kvm_riscv_vcpu_pmu_deinit(struct kvm_vcpu *vcpu);
>  void kvm_riscv_vcpu_pmu_reset(struct kvm_vcpu *vcpu);
>  
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 2d9929bbc2c8..f706c688b338 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -14,6 +14,7 @@
>  #include <asm/csr.h>
>  #include <asm/kvm_vcpu_sbi.h>
>  #include <asm/kvm_vcpu_pmu.h>
> +#include <asm/sbi.h>
>  #include <linux/bitops.h>
>  
>  #define kvm_pmu_num_counters(pmu) ((pmu)->num_hw_ctrs + (pmu)->num_fw_ctrs)
> @@ -311,6 +312,80 @@ int kvm_riscv_vcpu_pmu_read_hpm(struct kvm_vcpu *vcpu, unsigned int csr_num,
>  	return ret;
>  }
>  
> +static void kvm_pmu_clear_snapshot_area(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
> +	int snapshot_area_size = sizeof(struct riscv_pmu_snapshot_data);
> +
> +	if (kvpmu->sdata) {
> +		if (kvpmu->snapshot_addr != INVALID_GPA) {
> +			memset(kvpmu->sdata, 0, snapshot_area_size);
> +			kvm_vcpu_write_guest(vcpu, kvpmu->snapshot_addr,
> +					     kvpmu->sdata, snapshot_area_size);
> +		} else {
> +			pr_warn("snapshot address invalid\n");
> +		}
> +		kfree(kvpmu->sdata);
> +		kvpmu->sdata = NULL;
> +	}
> +	kvpmu->snapshot_addr = INVALID_GPA;
> +}
> +
> +int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long saddr_low,
> +				      unsigned long saddr_high, unsigned long flags,
> +				      struct kvm_vcpu_sbi_return *retdata)
> +{
> +	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
> +	int snapshot_area_size = sizeof(struct riscv_pmu_snapshot_data);
> +	int sbiret = 0;
> +	gpa_t saddr;
> +	unsigned long hva;
> +	bool writable;
> +
> +	if (!kvpmu || flags) {
> +		sbiret = SBI_ERR_INVALID_PARAM;
> +		goto out;
> +	}
> +
> +	if (saddr_low == SBI_SHMEM_DISABLE && saddr_high == SBI_SHMEM_DISABLE) {
> +		kvm_pmu_clear_snapshot_area(vcpu);
> +		return 0;
> +	}
> +
> +	saddr = saddr_low;
> +
> +	if (saddr_high != 0) {
> +		if (IS_ENABLED(CONFIG_32BIT))
> +			saddr |= ((gpa_t)saddr << 32);

saddr |= ((gpa_t)saddr_high << 32)

> +		else
> +			sbiret = SBI_ERR_INVALID_ADDRESS;
> +		goto out;
> +	}
> +

Thanks,
drew
