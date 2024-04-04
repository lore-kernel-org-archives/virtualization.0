Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CA280635
	for <virtualization@lists.linux.dev>; Thu,  4 Apr 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228549; cv=none; b=lARtYH7wgvUs/uor4IEx9QDfxURpWaHLedIidBoRvasj3cpBqgwG1rgs2/IbxIbJBuAE/G8+WbLhDGA0DC9SnJainefYhlTSSsm06BxmSgiLui1pTz8QObuSkk8ViBKtrJo3v5LVEn5JpZn+zqfoqrJ1n+bw0ad0x72ahNuUitU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228549; c=relaxed/simple;
	bh=t6zNz5pw//F+8XPDFb/QOAnmOim/cJz/4VwpJwe5ATY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqDDekV3GcdpMi97VBlp83fbujYYnThBHru8itYUjMnGfnlqWRNh6T4HubR/wDvPcFJzR5y8p5H4Vbq8+aP2XO+zgoNDsODQHbkZqhFo5V/Hw9p2btu+pIhdMAsqftbJ5+qJOYEtaYv/PnUbWowkv3RIAtoCTTmi/PktKoUmE8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=EdxWrPiB; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="EdxWrPiB"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so790477a12.3
        for <virtualization@lists.linux.dev>; Thu, 04 Apr 2024 04:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712228546; x=1712833346; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WI/gpDqjLiJmsDmwk7gqvmJeMZiYROtcIjc07FyAt1I=;
        b=EdxWrPiBbd69vm3/UusHZN6ncwMhguNaDdr1UtGw2p93zKl5t6DXCuwkEQlFbQVxjA
         vnFrk5LfnPSwZITWrh3iyQmJbz5OfTZUwh9xNqYoLxQhm1gF0d+IucbP/pwWNtD8GZsq
         QrX2p/ETnCj6kfRs6W5IU/rf3GWY3D9139SxtIlFhJuZpI/nf3msRY+IfC2PHVqIQaHR
         0atD7S5hfDy3s9fPixG75A/DRCN2PoM5h7/C286dMSSe7i99J7gHKo9kDJ2mOfgf0/zT
         uZOYnOR2O9j1WHnNIUqbInKkBbBHhwoK1Wk6cfi6kDFHPTcU/K3YeYtNVZigSUdxJeKh
         dU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712228546; x=1712833346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WI/gpDqjLiJmsDmwk7gqvmJeMZiYROtcIjc07FyAt1I=;
        b=U23u1+tqZeAq4yEzvctW0PtHWf8nhVqZ/AgDWiMjzCZZGNYmX/L6eBhcMs8ZqJgqPc
         3O57UKbU3gZSR0SKIhTjy1SeKcMhcQH/mlvUSFEJGx9Y1WNH0uAP2fkMP7bJ1QR6oDiu
         9K/KeiGMAnC7O0G2/+qyc1tCaXOT40e5UIuRcmw+oG2mQtiy1dMQ1XSPjVxvGDMoUcJR
         cu79XdT14FtJYXI+iZ3AEViwkOCoIHp7as3X+bqZ7HhhnFKitIvoL9zm1QNJHrrtZU1D
         T0YzcmdrxsUrO6n2w4FCqmPEysrTf2NQoxRmiTbV9//aHCYRPZvSMCeEhxuEsXKKYKaa
         H/vg==
X-Forwarded-Encrypted: i=1; AJvYcCWXe0bHz/foszrcX9+VFPIsfkJy94+fz3VZbKYv/106rjS7KK/24UsKg2s/hRHVlMoUWn0AZ1y/h2M1q/zjWESlWYRfAETuUtL5FyK1MN0=
X-Gm-Message-State: AOJu0YwWhoNnxLbdYy0qXEvMp3nsmiGSLNXDKFXZOJUKVddwo0Qe17FL
	l+cd6kUn0oVPtJv+gyudQ90+itD9OMOTvWLUbvs9lqZX7asyVDlLLaYS6qeohoM=
X-Google-Smtp-Source: AGHT+IH+cR5LnT4HHFFZfBDVpuneEFANhm0q0RefyMMIWR5DVI1nM63K0UMkrPub9LuoEZqin8kkoA==
X-Received: by 2002:a17:906:7954:b0:a4e:a068:7f with SMTP id l20-20020a170906795400b00a4ea068007fmr1635905ejo.49.1712228545941;
        Thu, 04 Apr 2024 04:02:25 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id an19-20020a17090656d300b00a4e58c74c9fsm5892101ejc.6.2024.04.04.04.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:02:25 -0700 (PDT)
Date: Thu, 4 Apr 2024 13:02:24 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Anup Patel <anup@brainfault.org>, Ajay Kaher <akaher@vmware.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Alexey Makhalov <amakhalov@vmware.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 03/22] drivers/perf: riscv: Read upper bits of a
 firmware counter
Message-ID: <20240404-89ee7d7f90a5fcc91809065e@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-4-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-4-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:32AM -0700, Atish Patra wrote:
> SBI v2.0 introduced a explicit function to read the upper 32 bits
> for any firmware counter width that is longer than 32bits.
> This is only applicable for RV32 where firmware counter can be
> 64 bit.
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 3e44d2fb8bf8..babf1b9a4dbe 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -57,6 +57,8 @@ asm volatile(ALTERNATIVE(						\
>  PMU_FORMAT_ATTR(event, "config:0-47");
>  PMU_FORMAT_ATTR(firmware, "config:63");
>  
> +static bool sbi_v2_available;
> +
>  static struct attribute *riscv_arch_formats_attr[] = {
>  	&format_attr_event.attr,
>  	&format_attr_firmware.attr,
> @@ -511,19 +513,29 @@ static u64 pmu_sbi_ctr_read(struct perf_event *event)
>  	struct hw_perf_event *hwc = &event->hw;
>  	int idx = hwc->idx;
>  	struct sbiret ret;
> -	union sbi_pmu_ctr_info info;
>  	u64 val = 0;
> +	union sbi_pmu_ctr_info info = pmu_ctr_list[idx];
>  
>  	if (pmu_sbi_is_fw_event(event)) {
>  		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ,
>  				hwc->idx, 0, 0, 0, 0, 0);
> -		if (!ret.error)
> -			val = ret.value;
> +		if (ret.error)
> +			return 0;
> +
> +		val = ret.value;
> +		if (IS_ENABLED(CONFIG_32BIT) && sbi_v2_available && info.width >= 32) {
> +			ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ_HI,
> +					hwc->idx, 0, 0, 0, 0, 0);
> +			if (!ret.error)
> +				val |= ((u64)ret.value << 32);
> +			else
> +				WARN_ONCE(1, "Unable to read upper 32 bits of firmware counter error: %d\n",
> +					  sbi_err_map_linux_errno(ret.error));

I don't think we should use sbi_err_map_linux_errno() in this case since
we don't have a 1:1 mapping of SBI errors to Linux errors and we don't
propagate the error as a Linux error. For warnings, it's better to output
the exact SBI error.

> +		}
>  	} else {
> -		info = pmu_ctr_list[idx];
>  		val = riscv_pmu_ctr_read_csr(info.csr);
>  		if (IS_ENABLED(CONFIG_32BIT))
> -			val = ((u64)riscv_pmu_ctr_read_csr(info.csr + 0x80)) << 31 | val;
> +			val |= ((u64)riscv_pmu_ctr_read_csr(info.csr + 0x80)) << 32;
>  	}
>  
>  	return val;
> @@ -1135,6 +1147,9 @@ static int __init pmu_sbi_devinit(void)
>  		return 0;
>  	}
>  
> +	if (sbi_spec_version >= sbi_mk_version(2, 0))
> +		sbi_v2_available = true;
> +
>  	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING,
>  				      "perf/riscv/pmu:starting",
>  				      pmu_sbi_starting_cpu, pmu_sbi_dying_cpu);
> -- 
> 2.34.1
>

Thanks,
drew
