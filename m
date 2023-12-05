Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE83B68B62
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HYAAUSfK"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A0B4460E64
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A0B4460E64
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=HYAAUSfK
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HW1wAWeobOYt
	for <virtualization@lists.linux-foundation.org>;
	Tue,  5 Dec 2023 18:11:40 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A6A9060E55
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A6A9060E55
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a00191363c1so822305766b.0
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Dec 2023 10:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701799899; x=1702404699; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gX5WWhfig998/yZSJ0nntzGN5FS4doIX9lLnxn8Eabk=;
        b=HYAAUSfKxLxZ+nYBeWRsm9gXa/epxEOcYAD8hMKQS1ga1jcTY3jXosSe877yIYgoRS
         Nej3xFPZhI0dO9ND+K0ItQoCuOwcbMt7mhPU6cYrZKgIUSomVUSD13vLxxV9XAN7rrDE
         w+oBrZb9iUUK00d/pcLadscEIdevhEi0g9zTd01FJIG5WH11qmsFpEvWIDbXFhkK9kgH
         UmrQ57GXxXtcEMzzAdXcM2DrH4/Ro3RP9L19YylJo2XXMFiG0gs2jJxpiXeQPArU06OI
         nwJmIb/gSqtWLWQ2Tlub7paQPNNARMj3Z6kgnM0KT/Gsf68nGF667Ld0nMVJxej4YgKP
         hEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701799899; x=1702404699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gX5WWhfig998/yZSJ0nntzGN5FS4doIX9lLnxn8Eabk=;
        b=XZiKwAZP8n6MRCYzqecT73yvpaUQpkQ80c+gT+BbLXcXVQBJiZOlwzbFeZXKShK9lX
         lWtkf5ooMM2871XwSHjBbHkS+gMxKjSrtnoASzKWYJCJKZweIoduLdWujZHNWW8iXrO6
         nuDurV6I8YDIHPDVSiqsZZ4THpoxCgmexRhoFCPfStMfcms/F44oVY3viyGL3uOsmPjs
         5+PwoSN9jSviTEXNa8rbuiuh26GQVsx/MNL1EA1aUfT3wzvOB1covCrUnM063IrP86I0
         5wmEJUNvl5J0j3DTWaRkvjQwmuoG3u4BX/mvNZMVImCzVYMaZRCbE200SgdphXK3xuIL
         NG1w==
X-Gm-Message-State: AOJu0Yx1ll7TqbrcW9IsHcVew/mw/Ob2Ak35b9uPUQ92OeXzgQ8WRvtM
	k9Fz2kmKd4/akSfbyegIeafaKQ==
X-Google-Smtp-Source: AGHT+IGVDqSAVAc4n/NzKSePh93TSBdvQlfnzm4mjv1k7NCVmXDLW2EClZhu4K7O7TGJV0YruDqlXw==
X-Received: by 2002:a17:906:209e:b0:a1c:7444:a847 with SMTP id 30-20020a170906209e00b00a1c7444a847mr443883ejq.239.1701799898948;
        Tue, 05 Dec 2023 10:11:38 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id p4-20020a170906140400b00a1b61096ce6sm3768390ejc.129.2023.12.05.10.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:11:38 -0800 (PST)
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
	guoren@kernel.org
Subject: [PATCH v1 13/14] RISC-V: KVM: selftests: Add steal_time test support
Date: Tue,  5 Dec 2023 19:11:33 +0100
Message-ID: <20231205181119.207204-29-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205181119.207204-16-ajones@ventanamicro.com>
References: <20231205181119.207204-16-ajones@ventanamicro.com>
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

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 tools/testing/selftests/kvm/Makefile          |  5 +-
 .../selftests/kvm/include/riscv/processor.h   |  1 +
 tools/testing/selftests/kvm/steal_time.c      | 99 +++++++++++++++++++
 3 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index a5963ab9215b..ab52bd0c0c5b 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -193,12 +193,13 @@ TEST_GEN_PROGS_s390x += kvm_binary_stats_test
 
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

