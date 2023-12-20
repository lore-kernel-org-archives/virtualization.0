Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0985846429
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="juNOTklh"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73F996151C
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 73F996151C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=juNOTklh
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vPo-Vg32awdh
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 16:00:48 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 58F4860AC6
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 58F4860AC6
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-336746a545fso589893f8f.0
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 08:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703088046; x=1703692846; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62TTtkxd00oH+oWvK2W/ODaQKWhDhsp3HCJ4KK5vX24=;
        b=juNOTklhpSnwPIVAjIxa4uhEVhF/uRasoKDhg1B90eMtPJDM+tbNZYgnEKAg7Fe/Pt
         IRM6JndrDLd9+psZqwYaylFe4fKtmcwQzoCilcst32WpDNoRxLV7cYda7Vf/JrahvEgh
         tIiULztlvJeM+d8WFMzobR4Ls+EqAZTU9Aap3Hl+433Nm8xyCa6sEuMBIEHbr9lXUKez
         3AdRH4Z5KnWEWt4Fj5DUejHU2QZ1m6c1fC0JFm+dToqzDoOoVPVXuoZaw+uEp5ZFej7M
         XgeVgdJWd4MsRAc9GXZAXA21NLWpUV/S0qMF8dyLfpvrU4rPWgD0UsWvvVymHpcxNSTX
         g4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088046; x=1703692846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62TTtkxd00oH+oWvK2W/ODaQKWhDhsp3HCJ4KK5vX24=;
        b=Do7kiN8AXpzK5diHZk83+3Ze90HvSS3qiiwzrqkqLuO8hEJqvUXQ1kFMaEFWmxHvjI
         ZUnDt5WVMDE6MO6ka5u3V1JLJvlbLx4YidFwfIr53DRhfDvAGGkTPALNc8VaQcehYfi8
         c/Lit4zRBO8xz8NAXazYohcQukx3SfqLFS603FpRk2VWpfXY1rRNxlFrBCPfEfZgEKqf
         nL/DUnUBFSVsDSd28ZJyO7/77Qtrr9oJsjrNJ3n24Ext/+q3xvpk9w5pYOBI+EKAS5ZU
         chAtLMS+4eUo8Tq1VSwraRyU8nV/NQdDb8SZHEwuhPiiflN1naDEI63yuyMrsJAHf0Ly
         j3rg==
X-Gm-Message-State: AOJu0YwADiaR311R2vT9ai7t+2GfD/zy5XX2Y0iU6vAnG8lX2KQtIwOe
	59UHfc8X50yL+1FRio+OcwGqkYDQOwCLAA==
X-Google-Smtp-Source: AGHT+IEEMYELu7/A+1G49HQKJD0DCWws+PGCbWuHkMwSf1zShbkZAUEp29RUgz8Y81u0XEfxyO2+Uw==
X-Received: by 2002:adf:ec04:0:b0:336:7bd0:479e with SMTP id x4-20020adfec04000000b003367bd0479emr589222wrn.26.1703088046506;
        Wed, 20 Dec 2023 08:00:46 -0800 (PST)
Received: from localhost (cst-prg-16-115.cust.vodafone.cz. [46.135.16.115])
        by smtp.gmail.com with ESMTPSA id k17-20020adff291000000b003367bb8898dsm1789906wro.66.2023.12.20.08.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 08:00:46 -0800 (PST)
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
Subject: [PATCH v4 11/13] RISC-V: KVM: selftests: Add guest_sbi_probe_extension
Date: Wed, 20 Dec 2023 17:00:24 +0100
Message-ID: <20231220160012.40184-26-ajones@ventanamicro.com>
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

Add guest_sbi_probe_extension(), allowing guest code to probe for
SBI extensions. As guest_sbi_probe_extension() needs
SBI_ERR_NOT_SUPPORTED, take the opportunity to bring in all SBI
error codes. We don't bring in all current extension IDs or base
extension function IDs though, even though we need one of each,
because we'd prefer to bring those in as necessary.

Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 .../selftests/kvm/include/riscv/processor.h   | 21 +++++++++++++++++++
 .../selftests/kvm/lib/riscv/processor.c       | 19 +++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index e70ccda2011b..dc50ad62e150 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -108,6 +108,17 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t subtype,
 #define SATP_ASID_SHIFT				44
 #define SATP_ASID_MASK				_AC(0xFFFF, UL)
 
+/* SBI return error codes */
+#define SBI_SUCCESS				0
+#define SBI_ERR_FAILURE				-1
+#define SBI_ERR_NOT_SUPPORTED			-2
+#define SBI_ERR_INVALID_PARAM			-3
+#define SBI_ERR_DENIED				-4
+#define SBI_ERR_INVALID_ADDRESS			-5
+#define SBI_ERR_ALREADY_AVAILABLE		-6
+#define SBI_ERR_ALREADY_STARTED			-7
+#define SBI_ERR_ALREADY_STOPPED			-8
+
 #define SBI_EXT_EXPERIMENTAL_START		0x08000000
 #define SBI_EXT_EXPERIMENTAL_END		0x08FFFFFF
 
@@ -115,6 +126,14 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t subtype,
 #define KVM_RISCV_SELFTESTS_SBI_UCALL		0
 #define KVM_RISCV_SELFTESTS_SBI_UNEXP		1
 
+enum sbi_ext_id {
+	SBI_EXT_BASE = 0x10,
+};
+
+enum sbi_ext_base_fid {
+	SBI_EXT_BASE_PROBE_EXT = 3,
+};
+
 struct sbiret {
 	long error;
 	long value;
@@ -125,4 +144,6 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg3, unsigned long arg4,
 			unsigned long arg5);
 
+bool guest_sbi_probe_extension(int extid, long *out_val);
+
 #endif /* SELFTEST_KVM_PROCESSOR_H */
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index 6905a4348380..7ca736fb4194 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -393,3 +393,22 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 
 	return ret;
 }
+
+bool guest_sbi_probe_extension(int extid, long *out_val)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_PROBE_EXT, extid,
+			0, 0, 0, 0, 0);
+
+	__GUEST_ASSERT(!ret.error || ret.error == SBI_ERR_NOT_SUPPORTED,
+		       "ret.error=%ld, ret.value=%ld\n", ret.error, ret.value);
+
+	if (ret.error == SBI_ERR_NOT_SUPPORTED)
+		return false;
+
+	if (out_val)
+		*out_val = ret.value;
+
+	return true;
+}
-- 
2.43.0

