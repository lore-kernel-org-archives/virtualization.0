Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E3A4207D
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="SkN4O/cY"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7064B813C2
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7064B813C2
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=SkN4O/cY
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sgRXiMd4H-N3
	for <virtualization@lists.linux-foundation.org>;
	Sun, 17 Dec 2023 20:40:50 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7CEC2813BB
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7CEC2813BB
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5534d8fcf7bso255028a12.3
        for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 12:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702845648; x=1703450448; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqR2C7zz01TFiIRh8DqKIf6Ieu9BaM0pJyMslNaYBQk=;
        b=SkN4O/cYhp8RYfgnVl0r/nA642fy84+B4vxENzwzmb9OJjYHjvq3SJ82abhuYV9n7N
         7MTEJRZklth1W4/1q1RLAYI/pxrp/k+V1YeMFfLbTWAGTbMHwjP84a5YRIEA76Aj7wjb
         iW2glMSWY+CAjVh3RlfveuOSA/VGxCX6a37mwFJ6jOBT52BvinDt0EV0CWeNieht8E+2
         U4EV4RcJmt9qz42YB50tWcKw1Xh9laPf9F04T4qUGSouxB0tk4DhSSiJU6/GCaEtX5Ap
         +YXjFUkqXbzLuhqAvDjudLq8zwLiFEDy0A4eMx2bqS0wImBqptUA8ojML5MVNXObtgCW
         3ZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702845648; x=1703450448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqR2C7zz01TFiIRh8DqKIf6Ieu9BaM0pJyMslNaYBQk=;
        b=AmpZVy0mZrJfdszb5F0Ur5p8YFHsPGUpC/0cszwlQgmFzlmNLRh6H89+ScqJrGOclc
         CV7sanX2JrLEHV4PtwrRxZaQ1ql1YywVJRgyJVPAgiM3//xgJfY0o0duxoZ+NSbg5IKy
         BJMrFVNKCV7y1j+npbwKkPwE/ZKFVIypb+aGh6CuVsyZzEl6UwsJinDKwfWxC0QmgUAg
         8tmXFiFTmdUYlYfP7lsWClH9KAlBU3wjY4zgbJtSisUIJgEruWsCmepS68Xy98zBqanD
         6yyAtwR4rbhPS/SAqsCveXpHgbfZwAU70SAdlUFYAgRXfl3o8x7W1jAD38czFyV06yNX
         1IKA==
X-Gm-Message-State: AOJu0Yxs0gZuSXBLklKqq+ThjkMjBSigEGVQiuLlM8VhDdZgm5tDJT5c
	lOXsQ3PBpXIqQDA1hRfznsNznw==
X-Google-Smtp-Source: AGHT+IEfGs4OQaguX6OAmX8Oe3Y0KxLn+ASdz7H+Iz7dSMU5rXaa7WIYeXOCpVviVKaTjXqSem+pTw==
X-Received: by 2002:a17:906:c20e:b0:9e6:38f2:8439 with SMTP id d14-20020a170906c20e00b009e638f28439mr6546645ejz.60.1702845648676;
        Sun, 17 Dec 2023 12:40:48 -0800 (PST)
Received: from localhost (cst-prg-88-42.cust.vodafone.cz. [46.135.88.42])
        by smtp.gmail.com with ESMTPSA id tk7-20020a170907c28700b00a1d1ebc2206sm13365557ejc.72.2023.12.17.12.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 12:40:48 -0800 (PST)
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
	conor.dooley@microchip.com
Subject: [PATCH v3 09/13] RISC-V: KVM: Implement SBI STA extension
Date: Sun, 17 Dec 2023 21:40:29 +0100
Message-ID: <20231217204019.36492-24-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217204019.36492-15-ajones@ventanamicro.com>
References: <20231217204019.36492-15-ajones@ventanamicro.com>
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

