Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAF541854
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="b0R9b5IM"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2320D40180
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2320D40180
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=b0R9b5IM
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7ovBrzfOkEHn
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 16:00:42 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9EBDD400D6
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9EBDD400D6
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-33664b4e038so3643129f8f.3
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 08:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703088041; x=1703692841; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwLdEL3t/SiXrqXkaiuKfwXDHLYhzeq9cY7LIf5M13Y=;
        b=b0R9b5IMw+JOXNN6Q7UaBqBGr4CaOqwo+l23Vq5b8ux0y4oUWGrIJCnk8recv7Hgla
         k57PCrBpWKzHE/NtTtkvZtE5p39tHT8svvfcMYk3E51DmM7OYnepkU2YwnnlFCeLs8Xp
         IlFDxmaIsZb7W5pKYOXgxw4mJrq2dFKNhdzsYLo5Ji5nklgGZdYe0OXhd/GRI/yxTxIU
         pdecB1vZbto2XOeaDy67v8V29Ec1qi5Gft2ZjoC5lKIga7Vl7lfqY9IjSWzzCPTJAABH
         3pZOOlokggbP+YYO8Jsfol5fiZlPuiC9AePySDGQKKYWt/60XK03jO+EulH9ijTG763B
         K4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088041; x=1703692841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwLdEL3t/SiXrqXkaiuKfwXDHLYhzeq9cY7LIf5M13Y=;
        b=oTf4c7Unn8BhW3s77daaEYrHTFZOKkQjUOKSQ+fSNo7TU+Hva9PQfVTK5UGLtdu3w8
         HVMEP9ZhFO3v4bXVsCB7Gs40iKS9008DAWzsIo/wrNV6X+UpSNc1tFH0jmQIc0PZeHCk
         DjPXHQN+tvQ4lz5lEwouxOOYqnZOjBmq1w1oLdhE6zdMPLO/KVY4XdxK+x/H29HBjG9W
         /U58c6wGZLwmDrwlk7tuS48Qwh5Ns065JsDjNZMXjhZomUSHfcFV4Etl3/iTlIUKfXho
         yVfu7x7UugnOxgHYeHD9i1P5+caB7GV1ZxaJgQLvdMS1RiCDserxFETm33zWm23IGtAo
         4zsg==
X-Gm-Message-State: AOJu0YzRpuy08WIIo/8A71PghCAyoFGxXXZf4GyUlkI0viWr/dZSLlsX
	RTmo0UR3xq1weJAOySVpTNJon2K7xWfVXVnzuSk=
X-Google-Smtp-Source: AGHT+IEUW/DiFOKNXsoqmxGaEpp9aDk7k7GiHIRbWZ5wbPtHchhvyTT+72hquJBGViI4njrJlZxthQ==
X-Received: by 2002:a5d:5f93:0:b0:336:6602:1b5 with SMTP id dr19-20020a5d5f93000000b00336660201b5mr3785782wrb.133.1703088040796;
        Wed, 20 Dec 2023 08:00:40 -0800 (PST)
Received: from localhost (cst-prg-16-115.cust.vodafone.cz. [46.135.16.115])
        by smtp.gmail.com with ESMTPSA id u17-20020a5d5151000000b003365e685102sm12300507wrt.29.2023.12.20.08.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 08:00:40 -0800 (PST)
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
Subject: [PATCH v4 09/13] RISC-V: KVM: Implement SBI STA extension
Date: Wed, 20 Dec 2023 17:00:22 +0100
Message-ID: <20231220160012.40184-24-ajones@ventanamicro.com>
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

Add a select SCHED_INFO to the KVM config in order to get run_delay
info. Then implement SBI STA's set-steal-time-shmem function and
kvm_riscv_vcpu_record_steal_time() to provide the steal-time info
to guests.

Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kvm/Kconfig        |  1 +
 arch/riscv/kvm/vcpu_sbi_sta.c | 96 ++++++++++++++++++++++++++++++++++-
 2 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index dfc237d7875b..148e52b516cf 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -32,6 +32,7 @@ config KVM
 	select KVM_XFER_TO_GUEST_WORK
 	select MMU_NOTIFIER
 	select PREEMPT_NOTIFIERS
+	select SCHED_INFO
 	help
 	  Support hosting virtualized guest machines.
 
diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
index 87bf1a5f05ce..01f09fe8c3b0 100644
--- a/arch/riscv/kvm/vcpu_sbi_sta.c
+++ b/arch/riscv/kvm/vcpu_sbi_sta.c
@@ -6,9 +6,15 @@
 #include <linux/kconfig.h>
 #include <linux/kernel.h>
 #include <linux/kvm_host.h>
+#include <linux/mm.h>
+#include <linux/sizes.h>
 
+#include <asm/bug.h>
+#include <asm/current.h>
 #include <asm/kvm_vcpu_sbi.h>
+#include <asm/page.h>
 #include <asm/sbi.h>
+#include <asm/uaccess.h>
 
 void kvm_riscv_vcpu_sbi_sta_reset(struct kvm_vcpu *vcpu)
 {
@@ -19,14 +25,100 @@ void kvm_riscv_vcpu_sbi_sta_reset(struct kvm_vcpu *vcpu)
 void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
 {
 	gpa_t shmem = vcpu->arch.sta.shmem;
+	u64 last_steal = vcpu->arch.sta.last_steal;
+	u32 *sequence_ptr, sequence;
+	u64 *steal_ptr, steal;
+	unsigned long hva;
+	gfn_t gfn;
 
 	if (shmem == INVALID_GPA)
 		return;
+
+	/*
+	 * shmem is 64-byte aligned (see the enforcement in
+	 * kvm_sbi_sta_steal_time_set_shmem()) and the size of sbi_sta_struct
+	 * is 64 bytes, so we know all its offsets are in the same page.
+	 */
+	gfn = shmem >> PAGE_SHIFT;
+	hva = kvm_vcpu_gfn_to_hva(vcpu, gfn);
+
+	if (WARN_ON(kvm_is_error_hva(hva))) {
+		vcpu->arch.sta.shmem = INVALID_GPA;
+		return;
+	}
+
+	sequence_ptr = (u32 *)(hva + offset_in_page(shmem) +
+			       offsetof(struct sbi_sta_struct, sequence));
+	steal_ptr = (u64 *)(hva + offset_in_page(shmem) +
+			    offsetof(struct sbi_sta_struct, steal));
+
+	if (WARN_ON(get_user(sequence, sequence_ptr)))
+		return;
+
+	sequence = le32_to_cpu(sequence);
+	sequence += 1;
+
+	if (WARN_ON(put_user(cpu_to_le32(sequence), sequence_ptr)))
+		return;
+
+	if (!WARN_ON(get_user(steal, steal_ptr))) {
+		steal = le64_to_cpu(steal);
+		vcpu->arch.sta.last_steal = READ_ONCE(current->sched_info.run_delay);
+		steal += vcpu->arch.sta.last_steal - last_steal;
+		WARN_ON(put_user(cpu_to_le64(steal), steal_ptr));
+	}
+
+	sequence += 1;
+	WARN_ON(put_user(cpu_to_le32(sequence), sequence_ptr));
+
+	kvm_vcpu_mark_page_dirty(vcpu, gfn);
 }
 
 static int kvm_sbi_sta_steal_time_set_shmem(struct kvm_vcpu *vcpu)
 {
-	return SBI_ERR_FAILURE;
+	struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
+	unsigned long shmem_phys_lo = cp->a0;
+	unsigned long shmem_phys_hi = cp->a1;
+	u32 flags = cp->a2;
+	struct sbi_sta_struct zero_sta = {0};
+	unsigned long hva;
+	bool writable;
+	gpa_t shmem;
+	int ret;
+
+	if (flags != 0)
+		return SBI_ERR_INVALID_PARAM;
+
+	if (shmem_phys_lo == SBI_STA_SHMEM_DISABLE &&
+	    shmem_phys_hi == SBI_STA_SHMEM_DISABLE) {
+		vcpu->arch.sta.shmem = INVALID_GPA;
+		return 0;
+	}
+
+	if (shmem_phys_lo & (SZ_64 - 1))
+		return SBI_ERR_INVALID_PARAM;
+
+	shmem = shmem_phys_lo;
+
+	if (shmem_phys_hi != 0) {
+		if (IS_ENABLED(CONFIG_32BIT))
+			shmem |= ((gpa_t)shmem_phys_hi << 32);
+		else
+			return SBI_ERR_INVALID_ADDRESS;
+	}
+
+	hva = kvm_vcpu_gfn_to_hva_prot(vcpu, shmem >> PAGE_SHIFT, &writable);
+	if (kvm_is_error_hva(hva) || !writable)
+		return SBI_ERR_INVALID_ADDRESS;
+
+	ret = kvm_vcpu_write_guest(vcpu, shmem, &zero_sta, sizeof(zero_sta));
+	if (ret)
+		return SBI_ERR_FAILURE;
+
+	vcpu->arch.sta.shmem = shmem;
+	vcpu->arch.sta.last_steal = current->sched_info.run_delay;
+
+	return 0;
 }
 
 static int kvm_sbi_ext_sta_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
@@ -52,7 +144,7 @@ static int kvm_sbi_ext_sta_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 
 static unsigned long kvm_sbi_ext_sta_probe(struct kvm_vcpu *vcpu)
 {
-	return 0;
+	return !!sched_info_on();
 }
 
 const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta = {
-- 
2.43.0

