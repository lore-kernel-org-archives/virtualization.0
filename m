Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F16F68B88
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="XTdCkNL4"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CAA1E43591
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CAA1E43591
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=XTdCkNL4
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xJvrvXAXs2sM
	for <virtualization@lists.linux-foundation.org>;
	Tue,  5 Dec 2023 18:11:36 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 94140400D0
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 94140400D0
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54ca339ae7aso3921667a12.3
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Dec 2023 10:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701799895; x=1702404695; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ivOuqr+FRV10zZI63T6X0mHp+G+0XGejIucx0BbhjU=;
        b=XTdCkNL4QipksZBed3POWEVU3/jf0ZkUuYbGsFtvhur53mXsBDsb6pDKS2CbgWxAvI
         Pf8Z9eQZ+J1Ucz1zzZp7lUhuPLDI4ja2K5x6TZ+U+xdQXJxptEBeRmIkH1C0Wt5kpitb
         RrvFj6cjkH9GWPJoRe2KAH3Wl8d7UWdMK+qS5cYgC1mIriZUZSpoNj5mTP7dGXPsYLoi
         HmVTPOfmtBKePbLoFsd2uZX8XjC2BGTEaAcqqXU0smJladRTIJSQNwXTg2FTfgTdsIFV
         Z7fxxBRmQKVWe5sUs+5bI+CuTY6gV/ZUNoZXFjrGKzN5rJ9bEDYe1MT4G2yzEKkYLder
         nsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701799895; x=1702404695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ivOuqr+FRV10zZI63T6X0mHp+G+0XGejIucx0BbhjU=;
        b=PM2faS2aOS5FuWx6xKUZSQZKpat5IQG9dI5zHit+sTr5A1YXil6dqmm3kHU1SIjqHO
         s73QqBvPUn9aGc+qiscNI/0EWeFKgsRQuONCQ0MnywwgRaXhx7jm73wySafPTF//k/Uv
         DkL0yNISHeyI7GEQGa2MczU+8egYlGIANEviM3BvNeWuGl1q0yzzJilUQefrLhOnlN67
         qwW1NIXRaYdtL7IpeWoMCja8LEIGeCL+2tWV0RRZo9CtkotHy1jgnnIvCYzO6vf+RXZZ
         LBKGgCc5pSYvTqUt4kUNUWt+VSm5TSbleIXeq3VwIuTHO09yJFknbbO43i4lDuLf7WIu
         vHUQ==
X-Gm-Message-State: AOJu0Yx3gSBgIjPSpq6Jy9PSrQcLLr0vid+RJAkUROtZSGS1i91+464X
	tJC1bUGEzgFjHWDALbcVkwnJDg==
X-Google-Smtp-Source: AGHT+IFtcdRDElDGQo9iA1Q5Jph8SaZn5M3BJzpb1sazlFsO3tnE85b6UjcLN5+isUqYw6gU1SW50g==
X-Received: by 2002:a50:d74c:0:b0:54c:8f76:cdb9 with SMTP id i12-20020a50d74c000000b0054c8f76cdb9mr3495992edj.32.1701799894729;
        Tue, 05 Dec 2023 10:11:34 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id bf17-20020a0564021a5100b0054ca1d90410sm1403899edb.85.2023.12.05.10.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:11:34 -0800 (PST)
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
Subject: [PATCH v1 10/14] RISC-V: KVM: Implement SBI STA extension
Date: Tue,  5 Dec 2023 19:11:30 +0100
Message-ID: <20231205181119.207204-26-ajones@ventanamicro.com>
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

Add a select SCHED_INFO to the KVM config in order to get run_delay
info. Then implement SBI STA's set-steal-time-shmem function and
kvm_riscv_vcpu_record_steal_time() to provide the steal-time info
to guests.

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
index 073bc47013b7..8b8dbee5500a 100644
--- a/arch/riscv/kvm/vcpu_sbi_sta.c
+++ b/arch/riscv/kvm/vcpu_sbi_sta.c
@@ -6,21 +6,113 @@
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
@@ -46,7 +138,7 @@ static int kvm_sbi_ext_sta_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 
 static unsigned long kvm_sbi_ext_sta_probe(struct kvm_vcpu *vcpu)
 {
-	return 0;
+	return !!sched_info_on();
 }
 
 const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta = {
-- 
2.43.0

