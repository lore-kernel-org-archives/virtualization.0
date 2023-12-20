Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0480846431
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LNujbpAL"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C81936151C
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C81936151C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=LNujbpAL
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X35Xk86qJy00
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 16:00:52 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B8A6360AC6
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B8A6360AC6
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-336755f1688so1590254f8f.0
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 08:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703088050; x=1703692850; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfFfKWtvrkmT221HR8Q1VQaH3JsKQHJKfN6wXUEYG9g=;
        b=LNujbpALewbQMp3gS+k1MAYdj5ZcvePmlgqlmhs31WfLQMFlGMXroYE6+DskY0fFOs
         L7cO31vfRiYt5cYBqTfj+aMMGLmD1Oy7eggAXRocf6I7YZ6pqOHDpG8ZKJ98N1HYxm+4
         bMUiBQBl+kRn5Ugg2JdoOwLZauJP8hBGr5LzEEdIItCGA8CyvZwLZpmxY+Ec04nve3GL
         uhxeoS2QRJR5/i0/dXFUoah6rlDX8HH67Bog9KOK52snR2qFjbMc1ewAvLnS/+JAQsp/
         8nOPcUdolPi6Nr7a75p7tksRvMJ9Ja49UkenAfVHSsgy/IWzmrp4okzeo9c58+rNIVoF
         Jw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088050; x=1703692850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfFfKWtvrkmT221HR8Q1VQaH3JsKQHJKfN6wXUEYG9g=;
        b=jyB95FKeGI8nQDYaAojW9sjfwX+d6Sx06eEa4vmAGR+9StAVe0tJGjDIWXWG+A8FAQ
         /+lrj0eL9Jf7Fa5hAl1vM+JruhrKZuu6/o7XsTLQlO3a2S0wuN7XThI2bHmqfJkYQ3YJ
         K9GfdOu3eYivHo5UJwtC9QFb36FPOF8DllSjqLjO5PBFjZPg1UA/R2qB/1/i7ZgJQwp0
         AB9OAt2PekniitqfwuEMp0V8SQq3iL8g7PbufcGKoIFoRGoHJgza1sqBD+h7sg0Hyydl
         gaBDIlKSKlx1t3I6CXQEQc9jp5KNHbLlCN0Uw7kRybSPV+w/TpSuGfbvFHQZ9Wioybqm
         5a+g==
X-Gm-Message-State: AOJu0Yzcmg5QwRNlO4zJpM8UFDEaEWbow0QMsjZbQGPhaaMJKgRK0zZe
	CQ8ljsYcq1EhBNmtGybQQSFNwg==
X-Google-Smtp-Source: AGHT+IFy7hQsVy6wi/dJPns4yQ8X3HqUXJ+wUSSQic4Yuf6fqtPe4NMhMJQy4J8MUdxydm1j127xlg==
X-Received: by 2002:a05:6000:400a:b0:336:6956:b848 with SMTP id cp10-20020a056000400a00b003366956b848mr3022937wrb.134.1703088049887;
        Wed, 20 Dec 2023 08:00:49 -0800 (PST)
Received: from localhost (cst-prg-16-115.cust.vodafone.cz. [46.135.16.115])
        by smtp.gmail.com with ESMTPSA id t18-20020adfa2d2000000b003364aa5cc13sm2977693wra.1.2023.12.20.08.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 08:00:49 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	virtualization@lists.linux-foundation.org
Cc: anup@brainfault.org,
	atishp@atishpatra.org,
	pbonzini@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jgross@suse.com,
	srivatsa@csail.mit.edu,
	guoren@kernel.org,
	conor.dooley@microchip.com,
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v4 12/13] RISC-V: KVM: selftests: Add steal_time test support
Date: Wed, 20 Dec 2023 17:00:25 +0100
Message-ID: <20231220160012.40184-27-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220160012.40184-15-ajones@ventanamicro.com>
References: <20231220160012.40184-15-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

With the introduction of steal-time accounting support for
RISC-V KVM we can add RISC-V support to the steal_time test.

Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 tools/testing/selftests/kvm/Makefile          |  5 +-
 .../selftests/kvm/include/riscv/processor.h   |  1 +
 tools/testing/selftests/kvm/steal_time.c      | 99 +++++++++++++++++++
 3 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 963435959a92..4bf4f52341a8 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -194,12 +194,13 @@ TEST_GEN_PROGS_s390x += kvm_binary_stats_test
 
 TEST_GEN_PROGS_riscv += demand_paging_test
 TEST_GEN_PROGS_riscv += dirty_log_test
-TEST_GEN_PROGS_riscv += guest_print_test
 TEST_GEN_PROGS_riscv += get-reg-list
+TEST_GEN_PROGS_riscv += guest_print_test
+TEST_GEN_PROGS_riscv += kvm_binary_stats_test
 TEST_GEN_PROGS_riscv += kvm_create_max_vcpus
 TEST_GEN_PROGS_riscv += kvm_page_table_test
 TEST_GEN_PROGS_riscv += set_memory_region_test
-TEST_GEN_PROGS_riscv += kvm_binary_stats_test
+TEST_GEN_PROGS_riscv += steal_time
 
 SPLIT_TESTS += get-reg-list
 
diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index dc50ad62e150..a0f9efe5a2a8 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -128,6 +128,7 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t subtype,
 
 enum sbi_ext_id {
 	SBI_EXT_BASE = 0x10,
+	SBI_EXT_STA = 0x535441,
 };
 
 enum sbi_ext_base_fid {
diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index 171adfb2a6cb..bae0c5026f82 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -11,7 +11,9 @@
 #include <pthread.h>
 #include <linux/kernel.h>
 #include <asm/kvm.h>
+#ifndef __riscv
 #include <asm/kvm_para.h>
+#endif
 
 #include "test_util.h"
 #include "kvm_util.h"
@@ -203,6 +205,103 @@ static void steal_time_dump(struct kvm_vm *vm, uint32_t vcpu_idx)
 	pr_info("    st_time: %ld\n", st->st_time);
 }
 
+#elif defined(__riscv)
+
+/* SBI STA shmem must have 64-byte alignment */
+#define STEAL_TIME_SIZE		((sizeof(struct sta_struct) + 63) & ~63)
+
+static vm_paddr_t st_gpa[NR_VCPUS];
+
+struct sta_struct {
+	uint32_t sequence;
+	uint32_t flags;
+	uint64_t steal;
+	uint8_t preempted;
+	uint8_t pad[47];
+} __packed;
+
+static void sta_set_shmem(vm_paddr_t gpa, unsigned long flags)
+{
+	unsigned long lo = (unsigned long)gpa;
+#if __riscv_xlen == 32
+	unsigned long hi = (unsigned long)(gpa >> 32);
+#else
+	unsigned long hi = gpa == -1 ? -1 : 0;
+#endif
+	struct sbiret ret = sbi_ecall(SBI_EXT_STA, 0, lo, hi, flags, 0, 0, 0);
+
+	GUEST_ASSERT(ret.value == 0 && ret.error == 0);
+}
+
+static void check_status(struct sta_struct *st)
+{
+	GUEST_ASSERT(!(READ_ONCE(st->sequence) & 1));
+	GUEST_ASSERT(READ_ONCE(st->flags) == 0);
+	GUEST_ASSERT(READ_ONCE(st->preempted) == 0);
+}
+
+static void guest_code(int cpu)
+{
+	struct sta_struct *st = st_gva[cpu];
+	uint32_t sequence;
+	long out_val = 0;
+	bool probe;
+
+	probe = guest_sbi_probe_extension(SBI_EXT_STA, &out_val);
+	GUEST_ASSERT(probe && out_val == 1);
+
+	sta_set_shmem(st_gpa[cpu], 0);
+	GUEST_SYNC(0);
+
+	check_status(st);
+	WRITE_ONCE(guest_stolen_time[cpu], st->steal);
+	sequence = READ_ONCE(st->sequence);
+	check_status(st);
+	GUEST_SYNC(1);
+
+	check_status(st);
+	GUEST_ASSERT(sequence < READ_ONCE(st->sequence));
+	WRITE_ONCE(guest_stolen_time[cpu], st->steal);
+	check_status(st);
+	GUEST_DONE();
+}
+
+static bool is_steal_time_supported(struct kvm_vcpu *vcpu)
+{
+	uint64_t id = RISCV_SBI_EXT_REG(KVM_RISCV_SBI_EXT_STA);
+	unsigned long enabled;
+
+	vcpu_get_reg(vcpu, id, &enabled);
+	TEST_ASSERT(enabled == 0 || enabled == 1, "Expected boolean result");
+
+	return enabled;
+}
+
+static void steal_time_init(struct kvm_vcpu *vcpu, uint32_t i)
+{
+	/* ST_GPA_BASE is identity mapped */
+	st_gva[i] = (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
+	st_gpa[i] = addr_gva2gpa(vcpu->vm, (vm_vaddr_t)st_gva[i]);
+	sync_global_to_guest(vcpu->vm, st_gva[i]);
+	sync_global_to_guest(vcpu->vm, st_gpa[i]);
+}
+
+static void steal_time_dump(struct kvm_vm *vm, uint32_t vcpu_idx)
+{
+	struct sta_struct *st = addr_gva2hva(vm, (ulong)st_gva[vcpu_idx]);
+	int i;
+
+	pr_info("VCPU%d:\n", vcpu_idx);
+	pr_info("    sequence:  %d\n", st->sequence);
+	pr_info("    flags:     %d\n", st->flags);
+	pr_info("    steal:     %"PRIu64"\n", st->steal);
+	pr_info("    preempted: %d\n", st->preempted);
+	pr_info("    pad:      ");
+	for (i = 0; i < 47; ++i)
+		pr_info("%d", st->pad[i]);
+	pr_info("\n");
+}
+
 #endif
 
 static void *do_steal_time(void *arg)
-- 
2.43.0

