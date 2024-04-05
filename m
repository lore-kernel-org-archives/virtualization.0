Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF07216C865
	for <virtualization@lists.linux.dev>; Fri,  5 Apr 2024 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322673; cv=none; b=VmL8A2l3cqFq7+VB1Qlj7F8KzyUP8Ot/icfo0asb6Q/TYeO903OBbh8qRn4BPRRUEp2VqLzHDpaV3S6DxZhkeA8f4JK57v+3Us3JDiBs7CTZR98gQkAudaec6/aSVDYn+R4Fx9PJ3bZIfBt2m/nHov606vmf2wa3f7mjYOs8R+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322673; c=relaxed/simple;
	bh=fHAxLDbcaIxHbfHsGsuoG1un+CSFtvHV+lyoBBHlgaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVzXVCAqeglJ6hOlkVxfRpQRcnK6H9bQao+MRUXfg+SNmA+fxHWdfOc/wo0qMNZrYwNqtsy7LbOMpQpSyQ75AvGc7dY/07tr3xl638EpLQcXpliMuxmCL+ozXC86cWnTAyhlUf9POjCUtmM6mW76lWNtxxwYtrI4nRV499krBuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ij/UwevF; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ij/UwevF"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3416df43cabso1573474f8f.3
        for <virtualization@lists.linux.dev>; Fri, 05 Apr 2024 06:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712322670; x=1712927470; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BIFYSL8LJt6foHdfxw10rN1acsJrRDe5PI5D+QNa+Qs=;
        b=ij/UwevFgCf7IdGEE7hTICoP3kEfKD6cnMlJYdJ0WSLI4TRT8/ZGoTZ3wcEsnxqvad
         IWihvDbA43T+lzCN3gHTKVHGk2lAqQ9WCsasZqbbC3bJTrmgiAr5qIdkh8RdcNbau3LB
         JvwBYqPqFpIEvJuKGi9tEpzx/yB0EuJs3MaIpIlGdsBNJmkMACfiXGUJ9BNECaIaRMOH
         D0TDfYg6jrORol6TtxSjDCc2g7d5E30pXKAQTDPWBHirp6GEzpXQqnFhMxdkVnuccxUx
         0vY69R2uM1aMmel1HYg7eFIPg5CJSclH1OxNEE6xdiHYnsVtQ9Qr0VfXadKuKo2wCB+L
         S2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712322670; x=1712927470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIFYSL8LJt6foHdfxw10rN1acsJrRDe5PI5D+QNa+Qs=;
        b=Xu++CSoOYo1YBFroRsBYoJ0t6MEOyrpt+vHEgbQiO2AXLr+UIJvklz4O0lXlpm+OV/
         nBNBnhVTqK1rynYGexWM2pLCxPXItSLhprV7y7Exh7KuHrNHTUK0H2txUSczbLD5SR6Y
         ZrU+NSsQfEQpyO/Oo1vSlpN5Ikkka9D4CBzXqjeeNgO2zHkAc0Maad3kG8Xu2O0D7MY4
         PEeLVeeAFd+IRK7HYtZdBZag4VICfYDqkE3X2lFdPI1bejJV1O2cs8L88XNJNBh1jR4+
         ZSiSnyKmgFdDDs2RHCfgeVAJ8o+CvzhstEOMUfixGEbGF9spbjrXa/JDcOaoB4bUUOo4
         3zmw==
X-Forwarded-Encrypted: i=1; AJvYcCUF3S4KkPjiOaRlBxHQGa7jQvGRAgbdqxGb0+3j+1AP/7zdhus2VZOiR21kiRkb7/8iQ/LmdR9VYnL4pFghtepcldulByzjHcyxO6N2ymo=
X-Gm-Message-State: AOJu0Yw0l7vEKqji2R/QKndbAvuWxM6LBVyaXg5GGSHCexPgM4V0ukm9
	WeKW6P+QGO+UtIs9uavYe62KDkxAVZRachpxrjJOY6QAjDt5oQbRcmmVFUyS03s=
X-Google-Smtp-Source: AGHT+IH6QOK2VOZDXQeYLcgWm2su03VMTaIdWBBWIhcwDxNyGR7vDIXVDmwGpRkaYjCW1TpcjR+oZw==
X-Received: by 2002:adf:8b94:0:b0:33e:69db:bf8a with SMTP id o20-20020adf8b94000000b0033e69dbbf8amr1024264wra.59.1712322669954;
        Fri, 05 Apr 2024 06:11:09 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id r4-20020a5d6944000000b00343b09729easm1998572wrw.69.2024.04.05.06.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 06:11:09 -0700 (PDT)
Date: Fri, 5 Apr 2024 15:11:08 +0200
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
Subject: Re: [PATCH v5 21/22] KVM: riscv: selftests: Add a test for PMU
 snapshot functionality
Message-ID: <20240405-4e840120e8117c286cb593f9@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-22-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-22-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:50AM -0700, Atish Patra wrote:
> Verify PMU snapshot functionality by setting up the shared memory
> correctly and reading the counter values from the shared memory
> instead of the CSR.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  .../testing/selftests/kvm/include/riscv/sbi.h |  25 ++++
>  .../selftests/kvm/lib/riscv/processor.c       |  12 ++
>  .../selftests/kvm/riscv/sbi_pmu_test.c        | 127 ++++++++++++++++++
>  3 files changed, 164 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/riscv/sbi.h b/tools/testing/selftests/kvm/include/riscv/sbi.h
> index 6675ca673c77..8c98bd99d450 100644
> --- a/tools/testing/selftests/kvm/include/riscv/sbi.h
> +++ b/tools/testing/selftests/kvm/include/riscv/sbi.h
> @@ -8,6 +8,12 @@
>  #ifndef SELFTEST_KVM_SBI_H
>  #define SELFTEST_KVM_SBI_H
>  
> +/* SBI spec version fields */
> +#define SBI_SPEC_VERSION_DEFAULT	0x1
> +#define SBI_SPEC_VERSION_MAJOR_SHIFT	24
> +#define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
> +#define SBI_SPEC_VERSION_MINOR_MASK	0xffffff
> +
>  /* SBI return error codes */
>  #define SBI_SUCCESS				 0
>  #define SBI_ERR_FAILURE				-1
> @@ -33,6 +39,9 @@ enum sbi_ext_id {
>  };
>  
>  enum sbi_ext_base_fid {
> +	SBI_EXT_BASE_GET_SPEC_VERSION = 0,
> +	SBI_EXT_BASE_GET_IMP_ID,
> +	SBI_EXT_BASE_GET_IMP_VERSION,
>  	SBI_EXT_BASE_PROBE_EXT = 3,
>  };
>  enum sbi_ext_pmu_fid {
> @@ -60,6 +69,12 @@ union sbi_pmu_ctr_info {
>  	};
>  };
>  
> +struct riscv_pmu_snapshot_data {
> +	u64 ctr_overflow_mask;
> +	u64 ctr_values[64];
> +	u64 reserved[447];
> +};
> +
>  struct sbiret {
>  	long error;
>  	long value;
> @@ -113,4 +128,14 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>  
>  bool guest_sbi_probe_extension(int extid, long *out_val);
>  
> +/* Make SBI version */
> +static inline unsigned long sbi_mk_version(unsigned long major,
> +					    unsigned long minor)
> +{
> +	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
> +		SBI_SPEC_VERSION_MAJOR_SHIFT) | minor;

Should also also mask 'minor'. I see this matches what we have in the
kernel so we should fix it there too.

> +}
> +
> +unsigned long get_host_sbi_spec_version(void);
> +
>  #endif /* SELFTEST_KVM_SBI_H */
> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
> index e8211f5d6863..ccb35573749c 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -502,3 +502,15 @@ bool guest_sbi_probe_extension(int extid, long *out_val)
>  
>  	return true;
>  }
> +
> +unsigned long get_host_sbi_spec_version(void)
> +{
> +	struct sbiret ret;
> +
> +	ret = sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_SPEC_VERSION, 0,
> +		       0, 0, 0, 0, 0);
> +
> +	GUEST_ASSERT(!ret.error);
> +
> +	return ret.value;
> +}
> diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> index 8e7c7a3172d8..7d195be5c3d9 100644
> --- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> @@ -19,6 +19,11 @@
>  #define RISCV_MAX_PMU_COUNTERS 64
>  union sbi_pmu_ctr_info ctrinfo_arr[RISCV_MAX_PMU_COUNTERS];
>  
> +/* Snapshot shared memory data */
> +#define PMU_SNAPSHOT_GPA_BASE		BIT(30)
> +static void *snapshot_gva;
> +static vm_paddr_t snapshot_gpa;
> +
>  /* Cache the available counters in a bitmask */
>  static unsigned long counter_mask_available;
>  
> @@ -178,6 +183,32 @@ static unsigned long read_counter(int idx, union sbi_pmu_ctr_info ctrinfo)
>  	return counter_val;
>  }
>  
> +static inline void verify_sbi_requirement_assert(void)
> +{
> +	long out_val = 0;
> +	bool probe;
> +
> +	probe = guest_sbi_probe_extension(SBI_EXT_PMU, &out_val);
> +	GUEST_ASSERT(probe && out_val == 1);
> +
> +	if (get_host_sbi_spec_version() < sbi_mk_version(2, 0))
> +		__GUEST_ASSERT(0, "SBI implementation version doesn't support PMU Snapshot");
> +}

It's a pity we can't check the SBI spec version that KVM is advertising
from KVM userspace. Normally we'd want to check something like this at
the start of the test with TEST_REQUIRE() before running a VCPU in order
to generate a skip exit.

(We probably should allow reading and even writing the SBI spec version
from the VMM in order to better support migration.)

> +
> +static void snapshot_set_shmem(vm_paddr_t gpa, unsigned long flags)
> +{
> +	unsigned long lo = (unsigned long)gpa;
> +#if __riscv_xlen == 32
> +	unsigned long hi = (unsigned long)(gpa >> 32);
> +#else
> +	unsigned long hi = gpa == -1 ? -1 : 0;
> +#endif
> +	struct sbiret ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
> +				      lo, hi, flags, 0, 0, 0);
> +
> +	GUEST_ASSERT(ret.value == 0 && ret.error == 0);
> +}
> +
>  static void test_pmu_event(unsigned long event)
>  {
>  	unsigned long counter;
> @@ -210,6 +241,41 @@ static void test_pmu_event(unsigned long event)
>  	stop_reset_counter(counter, 0);
>  }
>  
> +static void test_pmu_event_snapshot(unsigned long event)
> +{
> +	unsigned long counter;
> +	unsigned long counter_value_pre, counter_value_post;
> +	unsigned long counter_init_value = 100;
> +	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;
> +
> +	counter = get_counter_index(0, counter_mask_available, 0, event);
> +	counter_value_pre = read_counter(counter, ctrinfo_arr[counter]);
> +
> +	/* Do not set the initial value */
> +	start_counter(counter, 0, 0);
> +	dummy_func_loop(10000);
> +	stop_counter(counter, SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT);
> +
> +	/* The counter value is updated w.r.t relative index of cbase */
> +	counter_value_post = READ_ONCE(snapshot_data->ctr_values[0]);
> +	__GUEST_ASSERT(counter_value_post > counter_value_pre,
> +		       "counter_value_post %lx counter_value_pre %lx\n",
> +		       counter_value_post, counter_value_pre);
> +
> +	/* Now set the initial value and compare */
> +	WRITE_ONCE(snapshot_data->ctr_values[0], counter_init_value);
> +	start_counter(counter, SBI_PMU_START_FLAG_INIT_SNAPSHOT, 0);
> +	dummy_func_loop(10000);
> +	stop_counter(counter, SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT);
> +
> +	counter_value_post = READ_ONCE(snapshot_data->ctr_values[0]);
> +	__GUEST_ASSERT(counter_value_post > counter_init_value,
> +		       "counter_value_post %lx counter_init_value %lx for counter\n",
> +		       counter_value_post, counter_init_value);
> +
> +	stop_reset_counter(counter, 0);
> +}
> +
>  static void test_invalid_event(void)
>  {
>  	struct sbiret ret;
> @@ -272,6 +338,34 @@ static void test_pmu_basic_sanity(void)
>  	GUEST_DONE();
>  }
>  
> +static void test_pmu_events_snaphost(void)
> +{
> +	int num_counters = 0;
> +	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;
> +	int i;
> +
> +	/* Verify presence of SBI PMU and minimum requrired SBI version */
> +	verify_sbi_requirement_assert();
> +
> +	snapshot_set_shmem(snapshot_gpa, 0);
> +
> +	/* Get the counter details */
> +	num_counters = get_num_counters();
> +	update_counter_info(num_counters);
> +
> +	/* Validate shared memory access */
> +	GUEST_ASSERT_EQ(READ_ONCE(snapshot_data->ctr_overflow_mask), 0);
> +	for (i = 0; i < num_counters; i++) {
> +		if (counter_mask_available & (BIT(i)))
> +			GUEST_ASSERT_EQ(READ_ONCE(snapshot_data->ctr_values[i]), 0);
> +	}
> +	/* Only these two events are guranteed to be present */
> +	test_pmu_event_snapshot(SBI_PMU_HW_CPU_CYCLES);
> +	test_pmu_event_snapshot(SBI_PMU_HW_INSTRUCTIONS);
> +
> +	GUEST_DONE();
> +}
> +
>  static void run_vcpu(struct kvm_vcpu *vcpu)
>  {
>  	struct ucall uc;
> @@ -328,13 +422,46 @@ static void test_vm_events_test(void *guest_code)
>  	test_vm_destroy(vm);
>  }
>  
> +static void test_vm_setup_snapshot_mem(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> +{
> +	/* PMU Snapshot requires single page only */
> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, PMU_SNAPSHOT_GPA_BASE, 1, 1, 0);
> +	/* PMU_SNAPSHOT_GPA_BASE is identity mapped */
> +	virt_map(vm, PMU_SNAPSHOT_GPA_BASE, PMU_SNAPSHOT_GPA_BASE, 1);
> +
> +	snapshot_gva = (void *)(PMU_SNAPSHOT_GPA_BASE);
> +	snapshot_gpa = addr_gva2gpa(vcpu->vm, (vm_vaddr_t)snapshot_gva);
> +	sync_global_to_guest(vcpu->vm, snapshot_gva);
> +	sync_global_to_guest(vcpu->vm, snapshot_gpa);
> +}
> +
> +static void test_vm_events_snapshot_test(void *guest_code)
> +{
> +	struct kvm_vm *vm = NULL;
> +	struct kvm_vcpu *vcpu;
> +
> +	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
> +	__TEST_REQUIRE(__vcpu_has_sbi_ext(vcpu, KVM_RISCV_SBI_EXT_PMU),
> +				   "SBI PMU not available, skipping test");
> +
> +	test_vm_setup_snapshot_mem(vm, vcpu);
> +
> +	run_vcpu(vcpu);
> +
> +	test_vm_destroy(vm);
> +}
> +
>  int main(void)
>  {
> +	pr_info("SBI PMU basic test : starting\n");
>  	test_vm_basic_test(test_pmu_basic_sanity);
>  	pr_info("SBI PMU basic test : PASS\n");
>  
>  	test_vm_events_test(test_pmu_events);
>  	pr_info("SBI PMU event verification test : PASS\n");
>  
> +	test_vm_events_snapshot_test(test_pmu_events_snaphost);
> +	pr_info("SBI PMU event verification with snapshot test : PASS\n");
> +
>  	return 0;
>  }
> -- 
> 2.34.1
>

Since my comments are a bit out-of-scope for this patch,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
