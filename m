Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906FD3D57A
	for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794136; cv=none; b=fvAh0VrOlso7RoXSzMkNl7my3buvAdfWfLW9n1sN31z0oxqHpqo8yy/aKKQt0BbhIppB/sTCMRhdhpT1+a2+n3/7Traogl+X7gmqEc8IK4A9oG7JudusP+sYpIVQtts4/02fnXV/JF7Q0OwDJuzjtyqdDcv+ugLSMsNnG+Aw+3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794136; c=relaxed/simple;
	bh=UaK2BRG2cCYtJekJX1v+X6A/okSCrPqUNYx/jYqyhvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o4tR8Hs9etVc8j9BXo8reEUbBffixVEQ39QNIedkkjTcWa/CpA4ZmWpvPqlQZFSU8N0RR3o7oj7nmxFJKOxdAhL2DxkQkVY7XfYkLuUpCQ4M6NycsmEmase0MwND+u0hJQgMYioELtLQZuJnGdHT8Bs1tMUn2lU6+XHK2bKeBqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jYfzIuXI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jYfzIuXI"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e2178b2cf2so64867195ad.0
        for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 17:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794134; x=1713398934; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPwZXE2XSKrr96afFvE5Ak7Tq3sKjSlK1s+9Ond0wds=;
        b=jYfzIuXIKph/aGlK0fa3as4CiG7xEL8QZCR+25hdzeShiqErWRYQqHBm3PwrxjPhmE
         uUp1qni6ZGmDWm7sxmWm4GKJhAAXjqfujo0gnU6TbQi/OyX3EECxOitN8D3e9hlkSdg4
         tX8iSJgsjXG3TdzuO4xrtsk6n4oL3m1GGd7frDPZPHt+l/8tTmFpbq72U8CxuPE6l71s
         lbOVMKm8BbLH/LRb7AW5drc8pq8HLxAEFyj87c3hCSVpRca5/JIquGadXn2r9kcTVm8e
         jdPhYlaavFhrfALgnWyzP3JM2P06IQ6vqfGk/d4hJ/qnqsgueySn1CgbwG0Ei+Veu9ze
         t/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794134; x=1713398934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPwZXE2XSKrr96afFvE5Ak7Tq3sKjSlK1s+9Ond0wds=;
        b=IFo68Jvq+ut0CRqmZkBSCYafXpk4eTx3v9WGRcLjrJ63/BaGBCjydtNv8CnUw8ErLh
         aRsoCR8K55qXcMvkKcAuoOSerS6cE3g757FgBYMQAoEKYA8ES0t0WN5SMuhwbh4jXtQ1
         nbcJuQz6UU/N7g1GrqokTIilqxfkIdnKBE8o9xKfY9LuS1P+S3BJUdKV6Pb8c6rA1HST
         KRCGy3XLM3cenUpv49gTWq+FtNWKjXAKjzrcV5Kg3YgJSm5be6B8Jxwu/5JxVPPz6V7P
         MLxcyqZbGKsqYuSQ0prrpdp18AqDshaN6FNRLF7CCOo1JJBoWUl2EUBYZ3G6RLjK5dec
         jCSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSqXAJF7chCCZs3sPeCq1Rc2IR3p+uEa1x7LI6CNgeImsaPUhBUU7CnzITRUJvbY3coSoTGidfoYJCtxdnXlo2CPcvtwocpFwjlNhzI+M=
X-Gm-Message-State: AOJu0Yw0kyYYZHvAdL7fNON+Ofb36WgO1bA0BBaQmV3HduswAmtNnQ2H
	RDu2qG6gwrI4gBFqflBTpM1NCsmKdg5m4yP/wGWyq9zn/BvOreNeFZLh56yrSw4=
X-Google-Smtp-Source: AGHT+IHKxJVlEJl1bIRvxy3wACB6zmCTyQenR8DXY67Mr7CLfIwwr6/IL7jBf9RGIaMj04NY6rQR/Q==
X-Received: by 2002:a17:902:c94d:b0:1e2:6152:3439 with SMTP id i13-20020a170902c94d00b001e261523439mr4102847pla.6.1712794133940;
        Wed, 10 Apr 2024 17:08:53 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:08:53 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
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
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v6 17/24] KVM: riscv: selftests: Move sbi definitions to its own header file
Date: Wed, 10 Apr 2024 17:07:45 -0700
Message-Id: <20240411000752.955910-18-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411000752.955910-1-atishp@rivosinc.com>
References: <20240411000752.955910-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SBI definitions will continue to grow. Move the sbi related
definitions to its own header file from processor.h

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 .../selftests/kvm/include/riscv/processor.h   | 39 ---------------
 .../testing/selftests/kvm/include/riscv/sbi.h | 50 +++++++++++++++++++
 .../selftests/kvm/include/riscv/ucall.h       |  1 +
 tools/testing/selftests/kvm/steal_time.c      |  4 +-
 4 files changed, 54 insertions(+), 40 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/riscv/sbi.h

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index ce473fe251dd..3b9cb39327ff 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -154,45 +154,6 @@ void vm_install_interrupt_handler(struct kvm_vm *vm, exception_handler_fn handle
 #define PGTBL_PAGE_SIZE				PGTBL_L0_BLOCK_SIZE
 #define PGTBL_PAGE_SIZE_SHIFT			PGTBL_L0_BLOCK_SHIFT
 
-/* SBI return error codes */
-#define SBI_SUCCESS				0
-#define SBI_ERR_FAILURE				-1
-#define SBI_ERR_NOT_SUPPORTED			-2
-#define SBI_ERR_INVALID_PARAM			-3
-#define SBI_ERR_DENIED				-4
-#define SBI_ERR_INVALID_ADDRESS			-5
-#define SBI_ERR_ALREADY_AVAILABLE		-6
-#define SBI_ERR_ALREADY_STARTED			-7
-#define SBI_ERR_ALREADY_STOPPED			-8
-
-#define SBI_EXT_EXPERIMENTAL_START		0x08000000
-#define SBI_EXT_EXPERIMENTAL_END		0x08FFFFFF
-
-#define KVM_RISCV_SELFTESTS_SBI_EXT		SBI_EXT_EXPERIMENTAL_END
-#define KVM_RISCV_SELFTESTS_SBI_UCALL		0
-#define KVM_RISCV_SELFTESTS_SBI_UNEXP		1
-
-enum sbi_ext_id {
-	SBI_EXT_BASE = 0x10,
-	SBI_EXT_STA = 0x535441,
-};
-
-enum sbi_ext_base_fid {
-	SBI_EXT_BASE_PROBE_EXT = 3,
-};
-
-struct sbiret {
-	long error;
-	long value;
-};
-
-struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
-			unsigned long arg1, unsigned long arg2,
-			unsigned long arg3, unsigned long arg4,
-			unsigned long arg5);
-
-bool guest_sbi_probe_extension(int extid, long *out_val);
-
 static inline void local_irq_enable(void)
 {
 	csr_set(CSR_SSTATUS, SR_SIE);
diff --git a/tools/testing/selftests/kvm/include/riscv/sbi.h b/tools/testing/selftests/kvm/include/riscv/sbi.h
new file mode 100644
index 000000000000..ba04f2dec7b5
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/riscv/sbi.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * RISC-V SBI specific definitions
+ *
+ * Copyright (C) 2024 Rivos Inc.
+ */
+
+#ifndef SELFTEST_KVM_SBI_H
+#define SELFTEST_KVM_SBI_H
+
+/* SBI return error codes */
+#define SBI_SUCCESS				 0
+#define SBI_ERR_FAILURE				-1
+#define SBI_ERR_NOT_SUPPORTED			-2
+#define SBI_ERR_INVALID_PARAM			-3
+#define SBI_ERR_DENIED				-4
+#define SBI_ERR_INVALID_ADDRESS			-5
+#define SBI_ERR_ALREADY_AVAILABLE		-6
+#define SBI_ERR_ALREADY_STARTED			-7
+#define SBI_ERR_ALREADY_STOPPED			-8
+
+#define SBI_EXT_EXPERIMENTAL_START		0x08000000
+#define SBI_EXT_EXPERIMENTAL_END		0x08FFFFFF
+
+#define KVM_RISCV_SELFTESTS_SBI_EXT		SBI_EXT_EXPERIMENTAL_END
+#define KVM_RISCV_SELFTESTS_SBI_UCALL		0
+#define KVM_RISCV_SELFTESTS_SBI_UNEXP		1
+
+enum sbi_ext_id {
+	SBI_EXT_BASE = 0x10,
+	SBI_EXT_STA = 0x535441,
+};
+
+enum sbi_ext_base_fid {
+	SBI_EXT_BASE_PROBE_EXT = 3,
+};
+
+struct sbiret {
+	long error;
+	long value;
+};
+
+struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
+			unsigned long arg1, unsigned long arg2,
+			unsigned long arg3, unsigned long arg4,
+			unsigned long arg5);
+
+bool guest_sbi_probe_extension(int extid, long *out_val);
+
+#endif /* SELFTEST_KVM_SBI_H */
diff --git a/tools/testing/selftests/kvm/include/riscv/ucall.h b/tools/testing/selftests/kvm/include/riscv/ucall.h
index be46eb32ec27..a695ae36f3e0 100644
--- a/tools/testing/selftests/kvm/include/riscv/ucall.h
+++ b/tools/testing/selftests/kvm/include/riscv/ucall.h
@@ -3,6 +3,7 @@
 #define SELFTEST_KVM_UCALL_H
 
 #include "processor.h"
+#include "sbi.h"
 
 #define UCALL_EXIT_REASON       KVM_EXIT_RISCV_SBI
 
diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index bae0c5026f82..2ff82c7fd926 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -11,7 +11,9 @@
 #include <pthread.h>
 #include <linux/kernel.h>
 #include <asm/kvm.h>
-#ifndef __riscv
+#ifdef __riscv
+#include "sbi.h"
+#else
 #include <asm/kvm_para.h>
 #endif
 
-- 
2.34.1

