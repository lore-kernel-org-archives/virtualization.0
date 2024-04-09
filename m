Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB33619A
	for <virtualization@lists.linux.dev>; Tue,  9 Apr 2024 00:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712621087; cv=none; b=bRlsfOxUt3xinKxGZiZ4mezSyTnZRNGcdoZQSkKBMC5A4K1DKMKtHDmT9tqWvqIgijnd1pNVOrh8akKNhZ8WNLaY/v1juwuiO7AK0T2/sCMuKZ/SBIp6LCz+Cd3jKC9rENj8Kywkgsn/0JHmuozORMmY3KEDX2jJKlojvgEKPFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712621087; c=relaxed/simple;
	bh=tGemAdGs1i/th5kpM2ts3FwXyK6yltFMw9jonLi8+1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uEarfnPlM3OaAbmfdLbHXuO8du7h/flQaibxQDnj2mAakDWgFHhV1MxBZnsqO8Z2K9jjO0nLcZAEAlgtXt50Z0GN27p08PKDLjml0B5bOyit2lHMc1mwFtDlRHlP+fdym2OKGdBgmaNl9iV+d5Z3S4l/GB+t3kc0hT7gCuAi2/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jl+5M4wl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jl+5M4wl"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e45b9a5c53so8758875ad.3
        for <virtualization@lists.linux.dev>; Mon, 08 Apr 2024 17:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712621084; x=1713225884; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xd+FWiZlX/lpCLCXGGzdHlU3p21YETfnnn9ljhWHF9I=;
        b=jl+5M4wlJCAlGTRMzVcULQcG8cCX1ycAq5Y9pILNYGx2iNxgnct+sIw0qtT5QtbYdd
         9CMoQhSax5/gr7L7Smw7ymoPNKSqOfv4MPBR7Z34A/0RehTm/2ZUJyU6RwZPRtFoSx2y
         U5OarBGZj7AXfgq3F/r7kIeB792WpB6J+YvSnbVPYN+PiFxtLtozO7bF46VJHDTID9hJ
         9npCfXxaLv5XJ4/1GlKRuMDovaR/dqMrtqtuI+hySMNLjX+9FGNhiauVDQqIiaGWMc2F
         pGFVHeOpXrO/7WF8WSjPHFhpaujK+334pBZTrr4ohJYsJsX1rcqTOdvV74vaT8R42DNA
         pgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712621084; x=1713225884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xd+FWiZlX/lpCLCXGGzdHlU3p21YETfnnn9ljhWHF9I=;
        b=mbdkc7XzFhAynncCIWJo53/J6/hq0SgzCvqWjXsvRAG60xpGRf3F5HGANrRjnuthfR
         4UnnTc3AwIxjK3ABUtXWM0616LHr/I/rPn5MiQi7mEcaBBJ9JU4Pb/SCLrmfleVkuFgU
         1TZXtBdJ3mNdsHccXXKl3gjtT7ndhxQvHLnvBaY+e3Hmsgy6zH/fgVLIDDicf6yb8fDh
         8hqiGAYJCd5kp9X+K/ZoUf1GaanARm7QPiknww0qXdyTbd2QiFhyJbRcW8eOEZrkwz1M
         sz4+ZSBz0tqDCRRrz6V1xRGP5qxwVuLUIYqJjyyjj7CppHxknr7smLC4xi+EGOtG/Swu
         vHkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4Ruz+keZDscJ/4UV9wTHrecTQ8+XEZrko2Kf0z/KUoZsMQke27kRSBWyWLwxEN0Cdz7iloolHWl2Xdt8J2CtUE2sg84ZRdZCiH5Zf88k=
X-Gm-Message-State: AOJu0YxmWluP4O/32XhoUoK8EXfYnogO3iXh0b3f2MMpT/95KcPWtPyb
	QGbveAco96Y0XaXAfjH91ysc7rsPf5oJfvLDii67jIsMhzDeBkglQl9LPB06bTs=
X-Google-Smtp-Source: AGHT+IG0OLdQkdZe7TuiqVfC4hYuT4+LNj+NNHp96L1eyYQkeOCssr3BNq26TdksuIIDjP/3fRra5A==
X-Received: by 2002:a17:902:d2ca:b0:1e4:1932:b0a5 with SMTP id n10-20020a170902d2ca00b001e41932b0a5mr5371923plc.68.1712621084126;
        Mon, 08 Apr 2024 17:04:44 -0700 (PDT)
Received: from ?IPV6:2601:647:4180:9630::e8c1? ([2601:647:4180:9630::e8c1])
        by smtp.gmail.com with ESMTPSA id c17-20020a170902d49100b001e1071cf0bbsm4411011plg.302.2024.04.08.17.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 17:04:43 -0700 (PDT)
Message-ID: <e95f9821-e83c-4abb-941d-60ce24b9c0a3@rivosinc.com>
Date: Mon, 8 Apr 2024 17:04:41 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/22] drivers/perf: riscv: Read upper bits of a
 firmware counter
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
 Conor Dooley <conor.dooley@microchip.com>, Anup Patel <anup@brainfault.org>,
 Ajay Kaher <akaher@vmware.com>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Alexey Makhalov <amakhalov@vmware.com>, Juergen Gross <jgross@suse.com>,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 virtualization@lists.linux.dev,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Will Deacon <will@kernel.org>, x86@kernel.org
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-4-atishp@rivosinc.com>
 <20240404-89ee7d7f90a5fcc91809065e@orel>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240404-89ee7d7f90a5fcc91809065e@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/24 04:02, Andrew Jones wrote:
> On Wed, Apr 03, 2024 at 01:04:32AM -0700, Atish Patra wrote:
>> SBI v2.0 introduced a explicit function to read the upper 32 bits
>> for any firmware counter width that is longer than 32bits.
>> This is only applicable for RV32 where firmware counter can be
>> 64 bit.
>>
>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> Reviewed-by: Anup Patel <anup@brainfault.org>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> ---
>>   drivers/perf/riscv_pmu_sbi.c | 25 ++++++++++++++++++++-----
>>   1 file changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>> index 3e44d2fb8bf8..babf1b9a4dbe 100644
>> --- a/drivers/perf/riscv_pmu_sbi.c
>> +++ b/drivers/perf/riscv_pmu_sbi.c
>> @@ -57,6 +57,8 @@ asm volatile(ALTERNATIVE(						\
>>   PMU_FORMAT_ATTR(event, "config:0-47");
>>   PMU_FORMAT_ATTR(firmware, "config:63");
>>   
>> +static bool sbi_v2_available;
>> +
>>   static struct attribute *riscv_arch_formats_attr[] = {
>>   	&format_attr_event.attr,
>>   	&format_attr_firmware.attr,
>> @@ -511,19 +513,29 @@ static u64 pmu_sbi_ctr_read(struct perf_event *event)
>>   	struct hw_perf_event *hwc = &event->hw;
>>   	int idx = hwc->idx;
>>   	struct sbiret ret;
>> -	union sbi_pmu_ctr_info info;
>>   	u64 val = 0;
>> +	union sbi_pmu_ctr_info info = pmu_ctr_list[idx];
>>   
>>   	if (pmu_sbi_is_fw_event(event)) {
>>   		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ,
>>   				hwc->idx, 0, 0, 0, 0, 0);
>> -		if (!ret.error)
>> -			val = ret.value;
>> +		if (ret.error)
>> +			return 0;
>> +
>> +		val = ret.value;
>> +		if (IS_ENABLED(CONFIG_32BIT) && sbi_v2_available && info.width >= 32) {
>> +			ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ_HI,
>> +					hwc->idx, 0, 0, 0, 0, 0);
>> +			if (!ret.error)
>> +				val |= ((u64)ret.value << 32);
>> +			else
>> +				WARN_ONCE(1, "Unable to read upper 32 bits of firmware counter error: %d\n",
>> +					  sbi_err_map_linux_errno(ret.error));
> 
> I don't think we should use sbi_err_map_linux_errno() in this case since
> we don't have a 1:1 mapping of SBI errors to Linux errors and we don't
> propagate the error as a Linux error. For warnings, it's better to output
> the exact SBI error.
> 

Sure. Fixed it.

>> +		}
>>   	} else {
>> -		info = pmu_ctr_list[idx];
>>   		val = riscv_pmu_ctr_read_csr(info.csr);
>>   		if (IS_ENABLED(CONFIG_32BIT))
>> -			val = ((u64)riscv_pmu_ctr_read_csr(info.csr + 0x80)) << 31 | val;
>> +			val |= ((u64)riscv_pmu_ctr_read_csr(info.csr + 0x80)) << 32;
>>   	}
>>   
>>   	return val;
>> @@ -1135,6 +1147,9 @@ static int __init pmu_sbi_devinit(void)
>>   		return 0;
>>   	}
>>   
>> +	if (sbi_spec_version >= sbi_mk_version(2, 0))
>> +		sbi_v2_available = true;
>> +
>>   	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING,
>>   				      "perf/riscv/pmu:starting",
>>   				      pmu_sbi_starting_cpu, pmu_sbi_dying_cpu);
>> -- 
>> 2.34.1
>>
> 
> Thanks,
> drew

