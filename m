Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F2131E2A
	for <virtualization@lists.linux.dev>; Wed,  3 Apr 2024 08:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131564; cv=none; b=O7Sj6OvWGdA6KL4vnCO9EgOA8spmCSY0ezmMbNAFSclAgWjRJ8o3kkl+2jYwVcf9OVhF7vM5Dm+hpfDUNG7HEFIukjw53UZUqh7tExC1LhU6F5cE/HGi5iBI80c3nmtxgpyvltKspstxDphSmtxOKtbcpesSKbuRvBVNKf8TYGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131564; c=relaxed/simple;
	bh=HPH+bQ+ud9CPVlAAxj5MJgVXSyPuFRNLxCzCWuT8AhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DwEo5ngICQXDLy9r/2W6j1k8c3Q9733bmMXWpDOJ76kg/j7kngHQxboeTMyITrBDXLRjA2suJan6TUfD96BwKeQh6FvpY3i0jgjh5FgURvl9Z8B39Q3+EzjSViI/uh7+8kPmpSi8StbkVEVujXzC/eXQaXuPzlTyKElMJCV3yG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=R9cqV6Vi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="R9cqV6Vi"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e223025ccbso27000105ad.3
        for <virtualization@lists.linux.dev>; Wed, 03 Apr 2024 01:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131562; x=1712736362; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08Ow0qzJAlLAfVOdK6hW39Nfp7LW+caK9DtQyZhdmmU=;
        b=R9cqV6ViZIgQyR+92e3/KVefi5hBDPXVlbr6w7HI4icWaNy8C64Tz56PksnPZulEKN
         BTgBAKTmjfbZouofOT2n/g41fhW1yGC2ETlzOBAbH4d3kQXFkUjTL6y1IM3ng9T0A/QW
         5yETI1GrKd9MNUEp2wS22m4G/TkQR7Smratxm8kUSQ41S7+zzGy7Tv71sU1Xh2kPAJRe
         +QSrwJr8GlXLw+W6AAVWDvI+9JmR2Ue1SvHn7q99JgYAC5PQFFfeSOu28KP9pswf+dEY
         RX1uPNFY3yGtzWQCePu5J77fOflFYzPyaQxjFNwvjDCq2TY0/11yAu91ACk1d9Kl9dZo
         /2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131562; x=1712736362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08Ow0qzJAlLAfVOdK6hW39Nfp7LW+caK9DtQyZhdmmU=;
        b=oWci85JKi5NzLbI/PNdeST4/vI/qkRBiaWzwOBD498BCyj5G2e6wVhKDqullfBpkoC
         OeiIbASmV+Waf5HJgj/vra2DewZxoGf/NF9KMrIq4+CPx0/f07r0k4MDe79UoP9jgmte
         nyuRuRxxN8IMCt2ZdcdAxDYj4dsT8bDISjfQ7zbUtlU+GWRX0kfr41YoOusL6dFw881V
         lcBO5eUyZAAHbJwiRjKNUPIyMvhUMBBYH6critQsUF916yhNX47QmPAOEv2PSiTlvBY8
         vKxDX8nSPodBPlkkk/X57LyNKBoEm3sNkMlgYB1NdowgEk/myxd3pATM94eLiXvug/f6
         ePQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFRByH4gRNTJsvWvbm04j90zL670NqFbTeQff7h2Nsm2Xkqekdyv425ElzM8V9ufy/TFW/ae7ta+SuiWgDmk4UG5g0DHF8D10cWoLKU+0=
X-Gm-Message-State: AOJu0YwCQoxWVdUr4iFqSwOeO+MSGNITiyGWVRF1uWPRWXckh72NtxVY
	bTPpjHy1jEoMH6tbHQm/TTCPgxQ1Sq9wFMd6Qo5lnXy4gqd6zVleSW5J+vT18DI=
X-Google-Smtp-Source: AGHT+IE72ENkNXFbTzbhg6SzqOY0byxQCRn9OXM0YoFZNh+Y8OZZcNtpF6ZIM4eDWD3GUsrp+79BKw==
X-Received: by 2002:a17:902:ea10:b0:1e0:e6b0:2364 with SMTP id s16-20020a170902ea1000b001e0e6b02364mr14335253plg.64.1712131562243;
        Wed, 03 Apr 2024 01:06:02 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:06:00 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Ajay Kaher <akaher@vmware.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Juergen Gross <jgross@suse.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v5 22/22] KVM: riscv: selftests: Add a test for counter overflow
Date: Wed,  3 Apr 2024 01:04:51 -0700
Message-Id: <20240403080452.1007601-23-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403080452.1007601-1-atishp@rivosinc.com>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test for verifying overflow interrupt. Currently, it relies on
overflow support on cycle/instret events. This test works for cycle/
instret events which support sampling via hpmcounters on the platform.
There are no ISA extensions to detect if a platform supports that. Thus,
this test will fail on platform with virtualization but doesn't
support overflow on these two events.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 .../selftests/kvm/riscv/sbi_pmu_test.c        | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
index 7d195be5c3d9..451db956b885 100644
--- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
+++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
@@ -14,6 +14,7 @@
 #include "test_util.h"
 #include "processor.h"
 #include "sbi.h"
+#include "arch_timer.h"
 
 /* Maximum counters(firmware + hardware) */
 #define RISCV_MAX_PMU_COUNTERS 64
@@ -24,6 +25,9 @@ union sbi_pmu_ctr_info ctrinfo_arr[RISCV_MAX_PMU_COUNTERS];
 static void *snapshot_gva;
 static vm_paddr_t snapshot_gpa;
 
+static int vcpu_shared_irq_count;
+static int counter_in_use;
+
 /* Cache the available counters in a bitmask */
 static unsigned long counter_mask_available;
 
@@ -117,6 +121,31 @@ static void guest_illegal_exception_handler(struct ex_regs *regs)
 	regs->epc += 4;
 }
 
+static void guest_irq_handler(struct ex_regs *regs)
+{
+	unsigned int irq_num = regs->cause & ~CAUSE_IRQ_FLAG;
+	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;
+	unsigned long overflown_mask;
+	unsigned long counter_val = 0;
+
+	/* Validate that we are in the correct irq handler */
+	GUEST_ASSERT_EQ(irq_num, IRQ_PMU_OVF);
+
+	/* Stop all counters first to avoid further interrupts */
+	stop_counter(counter_in_use, SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT);
+
+	csr_clear(CSR_SIP, BIT(IRQ_PMU_OVF));
+
+	overflown_mask = READ_ONCE(snapshot_data->ctr_overflow_mask);
+	GUEST_ASSERT(overflown_mask & 0x01);
+
+	WRITE_ONCE(vcpu_shared_irq_count, vcpu_shared_irq_count+1);
+
+	counter_val = READ_ONCE(snapshot_data->ctr_values[0]);
+	/* Now start the counter to mimick the real driver behavior */
+	start_counter(counter_in_use, SBI_PMU_START_FLAG_SET_INIT_VALUE, counter_val);
+}
+
 static unsigned long get_counter_index(unsigned long cbase, unsigned long cmask,
 				       unsigned long cflags,
 				       unsigned long event)
@@ -276,6 +305,33 @@ static void test_pmu_event_snapshot(unsigned long event)
 	stop_reset_counter(counter, 0);
 }
 
+static void test_pmu_event_overflow(unsigned long event)
+{
+	unsigned long counter;
+	unsigned long counter_value_post;
+	unsigned long counter_init_value = ULONG_MAX - 10000;
+	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;
+
+	counter = get_counter_index(0, counter_mask_available, 0, event);
+	counter_in_use = counter;
+
+	/* The counter value is updated w.r.t relative index of cbase passed to start/stop */
+	WRITE_ONCE(snapshot_data->ctr_values[0], counter_init_value);
+	start_counter(counter, SBI_PMU_START_FLAG_INIT_SNAPSHOT, 0);
+	dummy_func_loop(10000);
+	udelay(msecs_to_usecs(2000));
+	/* irq handler should have stopped the counter */
+	stop_counter(counter, SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT);
+
+	counter_value_post = READ_ONCE(snapshot_data->ctr_values[0]);
+	/* The counter value after stopping should be less the init value due to overflow */
+	__GUEST_ASSERT(counter_value_post < counter_init_value,
+		       "counter_value_post %lx counter_init_value %lx for counter\n",
+		       counter_value_post, counter_init_value);
+
+	stop_reset_counter(counter, 0);
+}
+
 static void test_invalid_event(void)
 {
 	struct sbiret ret;
@@ -366,6 +422,34 @@ static void test_pmu_events_snaphost(void)
 	GUEST_DONE();
 }
 
+static void test_pmu_events_overflow(void)
+{
+	int num_counters = 0;
+
+	/* Verify presence of SBI PMU and minimum requrired SBI version */
+	verify_sbi_requirement_assert();
+
+	snapshot_set_shmem(snapshot_gpa, 0);
+	csr_set(CSR_IE, BIT(IRQ_PMU_OVF));
+	local_irq_enable();
+
+	/* Get the counter details */
+	num_counters = get_num_counters();
+	update_counter_info(num_counters);
+
+	/*
+	 * Qemu supports overflow for cycle/instruction.
+	 * This test may fail on any platform that do not support overflow for these two events.
+	 */
+	test_pmu_event_overflow(SBI_PMU_HW_CPU_CYCLES);
+	GUEST_ASSERT_EQ(vcpu_shared_irq_count, 1);
+
+	test_pmu_event_overflow(SBI_PMU_HW_INSTRUCTIONS);
+	GUEST_ASSERT_EQ(vcpu_shared_irq_count, 2);
+
+	GUEST_DONE();
+}
+
 static void run_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct ucall uc;
@@ -451,6 +535,33 @@ static void test_vm_events_snapshot_test(void *guest_code)
 	test_vm_destroy(vm);
 }
 
+static void test_vm_events_overflow(void *guest_code)
+{
+	struct kvm_vm *vm = NULL;
+	struct kvm_vcpu *vcpu;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	__TEST_REQUIRE(__vcpu_has_sbi_ext(vcpu, KVM_RISCV_SBI_EXT_PMU),
+				   "SBI PMU not available, skipping test");
+
+	__TEST_REQUIRE(__vcpu_has_isa_ext(vcpu, KVM_RISCV_ISA_EXT_SSCOFPMF),
+				   "Sscofpmf is not available, skipping overflow test");
+
+
+	test_vm_setup_snapshot_mem(vm, vcpu);
+	vm_init_vector_tables(vm);
+	vm_install_interrupt_handler(vm, guest_irq_handler);
+
+	vcpu_init_vector_tables(vcpu);
+	/* Initialize guest timer frequency. */
+	vcpu_get_reg(vcpu, RISCV_TIMER_REG(frequency), &timer_freq);
+	sync_global_to_guest(vm, timer_freq);
+
+	run_vcpu(vcpu);
+
+	test_vm_destroy(vm);
+}
+
 int main(void)
 {
 	pr_info("SBI PMU basic test : starting\n");
@@ -463,5 +574,8 @@ int main(void)
 	test_vm_events_snapshot_test(test_pmu_events_snaphost);
 	pr_info("SBI PMU event verification with snapshot test : PASS\n");
 
+	test_vm_events_overflow(test_pmu_events_overflow);
+	pr_info("SBI PMU event verification with overflow test : PASS\n");
+
 	return 0;
 }
-- 
2.34.1

