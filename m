Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8BE8664C
	for <virtualization@lists.linux.dev>; Thu,  4 Apr 2024 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233175; cv=none; b=XWoo/R+8vu412kx6WfIIh67MQZub+Q1FAAAIFbwGqmngJb0dzwJNxN4rIu8DzIlNKOmqk0q+yFPH2Sf+2LdQzf2yAKkTvhRTL0bDLbOmvITBcvldkChRFSLeiHmOAttTbtSprIWtddlsih7SvRFGjTLvvlBY5BCJmABuO24ZiNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233175; c=relaxed/simple;
	bh=yFPwBTep8blPVjgy5nMdu/6Amok2vV20/Fu3FyIKsHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDye36KvkCEkpFC0J7dLz0V87aiHWSwU5aPp7DxURZtidXZkhx0UoANxtr3KVkiGD6SeTfiH+AFIsxd0zhJ4E8saW70LSn1HCIlkoaXqoN9pO18To0YRNJgKQOiDXcUNzgnxmthQ94nQLQJ3MMSQhJlYlrofXFI9DxLubk9zkb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ludkJsxa; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ludkJsxa"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-515c50dc2afso1045522e87.1
        for <virtualization@lists.linux.dev>; Thu, 04 Apr 2024 05:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712233172; x=1712837972; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lu9C520pl/QToPEuDedj4tCxIjbZApgXqw10FbpssTk=;
        b=ludkJsxayD9J7rKRnCamZzJYe1y6sCIQ1JSI14+HHO4Dd7Et28aUGIoN4tf1e4mDjV
         hgZk0+Ju4tfQ/GOJwYJ7BjG8Pvf2y7Dah/cPd+FwI+QtiXqw3cpSEQbVD2lbZb6qlOxo
         kg0WcSt04LFoq901TwTxE4ehXfvrxw/L87iqvEwVRoLXB4pq3OD4t608QwxHcH35Ubzt
         4GLzLMRIVignFJw5c02gFONHwQVrN01u9Vxi6U0z+KJ5s3sroOeFPgDh89sPciUrVtU4
         nFn3NavZwcadqtetY6n/aVPnTnBr+OrofLt3SD/vOS2TIYwN4m1gTKugQs2ypbDJ0eBa
         6Zcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233172; x=1712837972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lu9C520pl/QToPEuDedj4tCxIjbZApgXqw10FbpssTk=;
        b=Gyv+jGOUZ1544aQDYs1eTP5IpCpjU2ujMczpUP3eRN3md71NWXoOEWtUEeEQkGqbYF
         tzaj2lUTLvLuEXB3iwLw3YaiXLcayLlkJb8VM3UGJq52pstaeZFetMoYXeIzIsdQSC/c
         8cR2UTgKf/W+RbzsuA3rwLRtbG9FxNTUaiuUi8bredGz484+buTsFSv7UNlS5FXYF6Do
         xQu9f8WcgbAgbQBiLrE0qvP3i1SqF4X17/1GSZx/AcTKDP19YgCsiFaPD1Mz5nGFCCXX
         9LQg2zLcWULoSHQqFp2bhG5CnmIIlnNgcsk2iIhWEH3LVDcNRWDBf4wUJK7EofRgw5Lh
         0fOA==
X-Forwarded-Encrypted: i=1; AJvYcCWsogbu5rf/5H2QwDDtvzSSdS/qEr4LPBrKWOKf5B7urw3ps5ulyGD3gju2ytmmQHrhKI/VG7i3hS3oux/4YCAtA+dkNW3MtYZZVpRfifs=
X-Gm-Message-State: AOJu0YwEtQrYtcsu0wfLSIinzR4LmCDmBf+2ezRdQUrXtyNAkSl8Jx2k
	18pT5/AHLfzfT6pcs4eXhjF0VKZujIo8GCaJ021G0c5ZXZXQgKIvHTjo68JHCDw=
X-Google-Smtp-Source: AGHT+IGEr4LvYqRVP8TkgXhtJPu1ySWcSB/CsLOqLwHtKBXo1yVAMV8rZBtRTlCE8fvE3nx9A3syYg==
X-Received: by 2002:ac2:555b:0:b0:515:d3dc:43e with SMTP id l27-20020ac2555b000000b00515d3dc043emr1852415lfk.51.1712233171751;
        Thu, 04 Apr 2024 05:19:31 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id a12-20020a170906670c00b00a46d6e51a6fsm9012975ejp.63.2024.04.04.05.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 05:19:31 -0700 (PDT)
Date: Thu, 4 Apr 2024 14:19:30 +0200
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
Subject: Re: [PATCH v5 11/22] RISC-V: KVM: No need to exit to the user space
 if perf event failed
Message-ID: <20240404-de7d09060b134d467e437fcf@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-12-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-12-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:40AM -0700, Atish Patra wrote:
> Currently, we return a linux error code if creating a perf event failed
> in kvm. That shouldn't be necessary as guest can continue to operate
> without perf profiling or profiling with firmware counters.
> 
> Return appropriate SBI error code to indicate that PMU configuration
> failed. An error message in kvm already describes the reason for failure.
> 
> Fixes: 0cb74b65d2e5 ("RISC-V: KVM: Implement perf support without sampling")
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/kvm/vcpu_pmu.c     | 14 +++++++++-----
>  arch/riscv/kvm/vcpu_sbi_pmu.c |  6 +++---
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index b5159ce4592d..2d9929bbc2c8 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -229,8 +229,9 @@ static int kvm_pmu_validate_counter_mask(struct kvm_pmu *kvpmu, unsigned long ct
>  	return 0;
>  }
>  
> -static int kvm_pmu_create_perf_event(struct kvm_pmc *pmc, struct perf_event_attr *attr,
> -				     unsigned long flags, unsigned long eidx, unsigned long evtdata)
> +static long kvm_pmu_create_perf_event(struct kvm_pmc *pmc, struct perf_event_attr *attr,
> +				      unsigned long flags, unsigned long eidx,
> +				      unsigned long evtdata)
>  {
>  	struct perf_event *event;
>  
> @@ -454,7 +455,8 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
>  				     unsigned long eidx, u64 evtdata,
>  				     struct kvm_vcpu_sbi_return *retdata)
>  {
> -	int ctr_idx, ret, sbiret = 0;
> +	int ctr_idx, sbiret = 0;
> +	long ret;
>  	bool is_fevent;
>  	unsigned long event_code;
>  	u32 etype = kvm_pmu_get_perf_event_type(eidx);
> @@ -513,8 +515,10 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
>  			kvpmu->fw_event[event_code].started = true;
>  	} else {
>  		ret = kvm_pmu_create_perf_event(pmc, &attr, flags, eidx, evtdata);
> -		if (ret)
> -			return ret;
> +		if (ret) {
> +			sbiret = SBI_ERR_NOT_SUPPORTED;

I'm still not sure about this. I replied in the v4 thread about it.

Thanks,
drew

> +			goto out;
> +		}
>  	}
>  
>  	set_bit(ctr_idx, kvpmu->pmc_in_use);
> diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.c
> index 7eca72df2cbd..e1633606c98b 100644
> --- a/arch/riscv/kvm/vcpu_sbi_pmu.c
> +++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
> @@ -42,9 +42,9 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  #endif
>  		/*
>  		 * This can fail if perf core framework fails to create an event.
> -		 * Forward the error to userspace because it's an error which
> -		 * happened within the host kernel. The other option would be
> -		 * to convert to an SBI error and forward to the guest.
> +		 * No need to forward the error to userspace and exit the guest.
> +		 * The operation can continue without profiling. Forward the
> +		 * appropriate SBI error to the guest.
>  		 */
>  		ret = kvm_riscv_vcpu_pmu_ctr_cfg_match(vcpu, cp->a0, cp->a1,
>  						       cp->a2, cp->a3, temp, retdata);
> -- 
> 2.34.1
> 
