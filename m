Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988801292D5
	for <virtualization@lists.linux.dev>; Wed,  3 Apr 2024 08:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131547; cv=none; b=G+XCLzLyMDfABeRhLsaHpLtMfZLiigeqURY3KgKnIOCpjEQDLqwIfJWGpF1a69lz2VjCa/xhhoeuoI73E+9G0TIAqbCMLiuiZdoTW7of0mmD3d7Cudz9iGjYnMn85d7I13Oe5CtgyZCNZE4RYRpOHeRLNredliX9Ofo2qOEOs6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131547; c=relaxed/simple;
	bh=BAJjj9DUFC41oCUghV1zdmiJwIpGKHSqJMMsbfwWnaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Npl9txjz11n4qW5jxa62Pq4mdB2zzomQx3z16nsRemA1yIz9fglz02nfBh9YwjqLgzqrtuB03wgrrLfYWb62q9Rqk4a3/Ydx2/FMFmnJ9DAFiM1lvy0LP/s7lyOfOgH0IYHJ14qqllxj2LIAsACyFHO0paxJDCLsYhACKw7Uufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=d8ZG11ko; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="d8ZG11ko"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e0ae065d24so51513735ad.1
        for <virtualization@lists.linux.dev>; Wed, 03 Apr 2024 01:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131545; x=1712736345; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKKIkxhVPzlR31GWSQWSWFD216hXiUzA8utaOE+u8sQ=;
        b=d8ZG11kojsXeUxrT2kc59BHWeEGW1IbxMaJikLacTDQ3Qd4ty8DAzNdoOpWb0L2XOW
         TjgNhFmfU46xjx+TzH4HE+ZL3iZWIHZai79XiSbwymwIBz8y+wxG7foOp0Ascckbwdon
         3QsDgHz2f6qdWKV+o2BFDbmRFXu86PXQds+ebovkjZuW503SAdLioGhp6RABrSrWBSn/
         EQOwskKTn/byjeoUK/hwDlq9dD+apFH6sPncs72hP2HAIrqR2VJRC25B8qk2ykYVFVFY
         yRJ/yeXqKrVJ8uaZ3JppKGJpx77y6MyOm86bDlsdrTbokrZpC0e0k99OaJix6/Bf9mry
         j/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131545; x=1712736345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKKIkxhVPzlR31GWSQWSWFD216hXiUzA8utaOE+u8sQ=;
        b=QCyQ9L3SBg2qhkleIjPaIkIVFBtxKjOddrS/AQNORjRCREhNAdQiNZCL9qAqhYU5vc
         oUBxofAVyqQ3Hgo3gGOoaBgo1EwqoOhuqZD9M9w11XGiQ7Pb1PjvAsBQpPIJtZZPJn9j
         xYVzfTetaTeXbEW0156vluO2lZqD09/0xiupVBOSkSnfAlg83LA+HGSWhkI3Z2NyPKs1
         dGZ2Qe66EBxbFhiwKX/+mr/7uXefALZUJeri49BCJ7dTXBHQxzups65IPuBMFvlIjjvN
         qRazPZc1jehhqJzs98lhjgkC+4uPokfvFypmL1VhyCUKcDmM44ziNouKVgRb1sElkoTC
         rmnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTdWRh3mWAWLqPJMZzlbUBtVGufDh3aT+HppZmTTPbqIeO74Ve3hZaZBqfY/xqL9qxWpdObEwK3+d/DQVe6PUoYfZ+5IL+82rQZxORyvk=
X-Gm-Message-State: AOJu0Yzn/iBIZXPOF+dklpnB0HQERbKzm5a8FIPTVmg91jyMK2n+81c+
	idNRNB9EH/cyGp3zBzxnGCxfJVFkCJw8KI324BsxGr2ftNxabgaV8cgnlGK/t+4=
X-Google-Smtp-Source: AGHT+IEHII7tSGtUqO5wpO59JDooIKUZaJc45tvRQjDzAvEN2jSXssf4AqTMGpJ/lHoLRFAsmkx1xA==
X-Received: by 2002:a17:902:bf04:b0:1e0:115c:e03c with SMTP id bi4-20020a170902bf0400b001e0115ce03cmr11696876plb.53.1712131545155;
        Wed, 03 Apr 2024 01:05:45 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:44 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <akaher@vmware.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
	Anup Patel <anup@brainfault.org>,
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
Subject: [PATCH v5 16/22] KVM: riscv: selftests: Move sbi definitions to its own header file
Date: Wed,  3 Apr 2024 01:04:45 -0700
Message-Id: <20240403080452.1007601-17-atishp@rivosinc.com>
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

The SBI definitions will continue to grow. Move the sbi related
definitions to its own header file from processor.h

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
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

