Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B775985262
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713257350; cv=none; b=jel3fZVhmT8Q2+SkaBUaCJ5Ad50j9oQG5USgAClXmTfg0oeePCVsWyb4vrdqs0+cYdlwO4yGpAruTDojxhusDPpspjk+MedYwFg8aJZjdezJbXdld68isDlgKRJMBrtAaQcCUewLXhHX2hkW4T0PHdSpJrfJKfz7KuyYBu+mC/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713257350; c=relaxed/simple;
	bh=5Ugj44ELKaezQMYHW4xB3ZcmBsV3qnLcoNGHNm1mHxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbo1bgLUYfIBqYpDDvXsB8YZEzcVEzJbE3cK+QTCNycAyC4PNjWHVvkSoQDRABB7UI+ZuBvRcKP0obefG0B0V+pme2BApezEOts7aRQgGkzukR2Pvn8ddyaGdWrCjSnapyXIqAhILRNCmwd0bK8rKhKE0rh/5eDrOuibN6Keq8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=evSah+jz; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="evSah+jz"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a2d82537efso2665087a91.2
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 01:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713257347; x=1713862147; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YB4OKZ5azyoBQVdDaeHRwpejD252N/Wm8xYNs68na58=;
        b=evSah+jzI2FOoUC2AdM3pRgGXe4qrqu+5MRIpABEbB+ee5CZaSU55f7o7hDfEnmRmJ
         4DxenzUd9F1cwAooxTHK62qTgl3PYS0mtx3Gws907xwK8oRO9YTLsfiL2pQj032ouMj3
         KaJZhxuPPqAgCUsT2+JQD5fqKNQEDtw7XKAxvndVZk3CrmQJq6luXiFq8TGMJM/8tP0Y
         Fk5QRv5SOBT+eKo7Xfdn0vmz5IFxWzosmP99T26BAGmLFXj5/AMRkYezauCeqWHsxGSC
         6oQIdfN4xcAngAZU4GS00ELrCKt84GdnfrKjq23RXpf0wBRY7f2xapqyZaKCfysrAhnE
         hfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713257347; x=1713862147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YB4OKZ5azyoBQVdDaeHRwpejD252N/Wm8xYNs68na58=;
        b=oGvSd5NxTQ2Pxafxoxl3r7XZ26RNGqO5T56GOEQOeFSjmJphGIMas1narSMUDiGtxO
         iCHGu48oJMDSeEGX4qQAEvMPvInm45DNuTtmguc7OoRy9ZbvZYPf54JTwJ+CNPG0OaqA
         vFEZGOKHjWcK29l2b7IAwU5D5pTUhuhshHZveS0ujxGdaoTjwq547MJKClacFwWZ8hA0
         Cv+gBCwCTK87WRYFM8xqlNfEgqFcgWxfUN0eNqchBZ8+ENOAshV+TitihyY18QiDeaAG
         Td+ERhLPj/1/V2JZD2hE7nHkBOkOgGXQOXcsoq+LzF5zhZ9gybz0L2SCrFR+C76IJ6Sg
         yg7A==
X-Forwarded-Encrypted: i=1; AJvYcCX84urKVj9gxG4Ore/viysSkhsK8ErbRA0rkm3KCFefkKgJ9vMREfJkYEqPoIebGkCzOMBnwq6tS2Ihf2CDYaW4u5ct09pWih4rp9zoSps=
X-Gm-Message-State: AOJu0YyIqEZTzdQzo9oKKZ7s8r0mbY5hzCoTp48slBS2BANz1KSH+03R
	Dv/PAiZRwksvOeBfmq0f55EfBfPN6PBYoaUZykZFWLB6pYWSiTCtX4PYvpeMxq0=
X-Google-Smtp-Source: AGHT+IE5kvYAIrAzLyhCQG7YuKZN0xkJ8aTxnfQzZtfDgG4X+MG0/9j9aFOlv84kCs3vDDCZ3jMEMA==
X-Received: by 2002:a17:90a:ae12:b0:2a0:5f10:990c with SMTP id t18-20020a17090aae1200b002a05f10990cmr11367042pjq.10.1713257347059;
        Tue, 16 Apr 2024 01:49:07 -0700 (PDT)
Received: from [172.16.0.33] (c-67-188-2-18.hsd1.ca.comcast.net. [67.188.2.18])
        by smtp.gmail.com with ESMTPSA id c9-20020a17090abf0900b002a610ef880bsm8721392pjs.6.2024.04.16.01.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 01:49:06 -0700 (PDT)
Message-ID: <be9a80a3-64f1-4848-94a4-031a3ea797ad@rivosinc.com>
Date: Tue, 16 Apr 2024 01:49:04 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 24/24] KVM: riscv: selftests: Add commandline option
 for SBI PMU test
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, Ajay Kaher <ajay.kaher@broadcom.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 virtualization@lists.linux.dev, Will Deacon <will@kernel.org>, x86@kernel.org
References: <20240411000752.955910-1-atishp@rivosinc.com>
 <20240411000752.955910-25-atishp@rivosinc.com>
 <20240415-8b9ad5a7e968b1808e99e3da@orel>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240415-8b9ad5a7e968b1808e99e3da@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/24 06:43, Andrew Jones wrote:
> On Wed, Apr 10, 2024 at 05:07:52PM -0700, Atish Patra wrote:
>> SBI PMU test comprises of multiple tests and user may want to run
>> only a subset depending on the platform. The most common case would
>> be to run all to validate all the tests. However, some platform may
>> not support all events or all ISA extensions.
>>
>> The commandline option allows user to disable particular test if they
>> want to.
>>
>> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> ---
>>   .../selftests/kvm/riscv/sbi_pmu_test.c        | 77 ++++++++++++++++---
>>   1 file changed, 68 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
>> index 0fd9b76ae838..57025b07a403 100644
>> --- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
>> +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
>> @@ -33,6 +33,16 @@ static unsigned long counter_mask_available;
>>   
>>   static bool illegal_handler_invoked;
>>   
>> +enum sbi_pmu_test_id {
>> +	SBI_PMU_TEST_BASIC = 0,
>> +	SBI_PMU_TEST_EVENTS,
>> +	SBI_PMU_TEST_SNAPSHOT,
>> +	SBI_PMU_TEST_OVERFLOW,
>> +	SBI_PMU_TEST_MAX,
>> +};
>> +
>> +static int disabled_test_id = SBI_PMU_TEST_MAX;
> 
> I think we should allow specifying '-d' multiple times in case a user
> wants to disable more than one type of test. So we should set a bit
> in this variable instead of assigning it. We could also flip it
> around. If the user uses '-e' to enable test type then only type
> will be run, but then we'd probably want to allow multiple '-e'
> too so it doesn't gain anything.
> 

Sure. Added multiple disable option.

>> +
>>   unsigned long pmu_csr_read_num(int csr_num)
>>   {
>>   #define switchcase_csr_read(__csr_num, __val)		{\
>> @@ -608,19 +618,68 @@ static void test_vm_events_overflow(void *guest_code)
>>   	test_vm_destroy(vm);
>>   }
>>   
>> -int main(void)
>> +static void test_print_help(char *name)
>>   {
>> -	test_vm_basic_test(test_pmu_basic_sanity);
>> -	pr_info("SBI PMU basic test : PASS\n");
>> +	pr_info("Usage: %s [-h] [-d <test name>]\n", name);
>> +	pr_info("\t-d: Test to disable. Available tests are 'basic', 'events', 'snapshot', 'overflow'\n");
>> +	pr_info("\t-h: print this help screen\n");
>> +}
>>   
>> -	test_vm_events_test(test_pmu_events);
>> -	pr_info("SBI PMU event verification test : PASS\n");
>> +static bool parse_args(int argc, char *argv[])
>> +{
>> +	int opt;
>> +
>> +	while ((opt = getopt(argc, argv, "hd:")) != -1) {
>> +		switch (opt) {
>> +		case 'd':
>> +			if (!strncmp("basic", optarg, 5))
>> +				disabled_test_id = SBI_PMU_TEST_BASIC;
>> +			else if (!strncmp("events", optarg, 6))
>> +				disabled_test_id = SBI_PMU_TEST_EVENTS;
>> +			else if (!strncmp("snapshot", optarg, 8))
>> +				disabled_test_id = SBI_PMU_TEST_SNAPSHOT;
>> +			else if (!strncmp("overflow", optarg, 8))
>> +				disabled_test_id = SBI_PMU_TEST_OVERFLOW;
>> +			else
>> +				goto done;
>> +			break;
>> +		break;
> 
> Extra 'break'
> 

Fixed. Thanks for catching this.

>> +		case 'h':
>> +		default:
>> +			goto done;
>> +		}
>> +	}
>>   
>> -	test_vm_events_snapshot_test(test_pmu_events_snaphost);
>> -	pr_info("SBI PMU event verification with snapshot test : PASS\n");
>> +	return true;
>> +done:
>> +	test_print_help(argv[0]);
>> +	return false;
>> +}
>>   
>> -	test_vm_events_overflow(test_pmu_events_overflow);
>> -	pr_info("SBI PMU event verification with overflow test : PASS\n");
>> +int main(int argc, char *argv[])
>> +{
>> +	if (!parse_args(argc, argv))
>> +		exit(KSFT_SKIP);
>> +
>> +	if (disabled_test_id != SBI_PMU_TEST_BASIC) {
>> +		test_vm_basic_test(test_pmu_basic_sanity);
>> +		pr_info("SBI PMU basic test : PASS\n");
>> +	}
>> +
>> +	if (disabled_test_id != SBI_PMU_TEST_EVENTS) {
>> +		test_vm_events_test(test_pmu_events);
>> +		pr_info("SBI PMU event verification test : PASS\n");
>> +	}
>> +
>> +	if (disabled_test_id != SBI_PMU_TEST_SNAPSHOT) {
>> +		test_vm_events_snapshot_test(test_pmu_events_snaphost);
>> +		pr_info("SBI PMU event verification with snapshot test : PASS\n");
>> +	}
>> +
>> +	if (disabled_test_id != SBI_PMU_TEST_OVERFLOW) {
>> +		test_vm_events_overflow(test_pmu_events_overflow);
>> +		pr_info("SBI PMU event verification with overflow test : PASS\n");
>> +	}
>>   
>>   	return 0;
>>   }
>> -- 
>> 2.34.1
>>
> 
> Thanks,
> drew
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

