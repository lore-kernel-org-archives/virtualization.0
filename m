Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117A546449
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fl5JRrOz"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 87A6F83415
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 87A6F83415
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=fl5JRrOz
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.092
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 80pUYae3T6KS
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 16:00:54 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B4796833D3
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B4796833D3
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-336746a545fso589990f8f.0
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 08:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703088053; x=1703692853; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MIeG//CYqgQU1t4MUGLxBCDTtfcBv4CzngYE6hts0o=;
        b=fl5JRrOzGU2dhE8OMuumNZC8t/R1zSy+JfttqE/ypTFjAOfoVSOKOuKOMxp0QtD1sQ
         kOyMsmsf30n5j83LnVaHnDGvvj57RbagEgYGytld+ys+DLa2GAUSZUKU979mvAlfoEx0
         xslyKubVtY09ZJxhty/hSgCoabRt/eRKjpYLb/8hXTsSmvYCaMkPqLx36676r0vhAYpO
         eaH2lRlcIi9tXjB2DDCkhEG5xyUR1Uhd/YMLTlYF2D5TM9NqJtoHGQl1tH94/BIafAvd
         0axuPEzBAtxvAuYqiEjqGfUC0LYtQAaftPM+dYEx3nIjqfY/K8C9zK6HwI0YHXpOshog
         FwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088053; x=1703692853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MIeG//CYqgQU1t4MUGLxBCDTtfcBv4CzngYE6hts0o=;
        b=FUXIQWBeXN2dgTAiHrxa92rLi8QKr73w9ncWL2lT69R8GhX9q6b810QlvTzGtJt4Mc
         Z8vccqwpMvHGfm3/Fe1PAecO3rJpmljAfAbMliI7lF+J2/reQn6O3zHMZmbTLWCb7sqM
         GFzUPoBENolfWKOGOb7KNV96HoHOVmclCHu5sYMrI5EqR3M3XNcvBn655Nb6ZV1Do5W0
         49dCG+VWNgbdTKeP7ojD8GPXTlJOaXu5R4kjScqbjfMVhcRpxrfBRM5qf4VS8tuwWz0c
         8Ti09dMZ9EtReHSAXbFOCruZuzq+S29JA1CBTDEB51eaqoje1T8RmUNAm7sdJfTKSOUy
         yKPw==
X-Gm-Message-State: AOJu0YzKTaibDLMDuPOcI2QW7QGwJY3hmeCEAG/n3QwvP+blCGM5foAv
	b2gogM7PaGmgZbB2jqWXMBLkfA==
X-Google-Smtp-Source: AGHT+IFqWQdYTmWfiHtgaVs9TEWkO52iriQdpaOOyzN/Hx9SJcnJo/k/ijqG6DhlnoIGa8of3niFzA==
X-Received: by 2002:adf:ee0c:0:b0:336:7686:d5e2 with SMTP id y12-20020adfee0c000000b003367686d5e2mr1265268wrn.53.1703088052920;
        Wed, 20 Dec 2023 08:00:52 -0800 (PST)
Received: from localhost (cst-prg-16-115.cust.vodafone.cz. [46.135.16.115])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d564b000000b0033664ffaf5dsm9777896wrw.37.2023.12.20.08.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 08:00:52 -0800 (PST)
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
Subject: [PATCH v4 13/13] RISC-V: KVM: selftests: Add get-reg-list test for STA registers
Date: Wed, 20 Dec 2023 17:00:26 +0100
Message-ID: <20231220160012.40184-28-ajones@ventanamicro.com>
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

Add SBI STA and its two registers to the get-reg-list test.

Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 .../selftests/kvm/riscv/get-reg-list.c        | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index b8da2e86bf9c..6652108816db 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -71,6 +71,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_HSM:
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_PMU:
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_DBCN:
+	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_STA:
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_EXPERIMENTAL:
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_VENDOR:
 		return true;
@@ -461,6 +462,7 @@ static const char *sbi_ext_single_id_to_str(__u64 reg_off)
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_SRST),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_HSM),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_PMU),
+		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_STA),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_EXPERIMENTAL),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_VENDOR),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_DBCN),
@@ -509,6 +511,32 @@ static const char *sbi_ext_id_to_str(const char *prefix, __u64 id)
 	return strdup_printf("%lld | %lld /* UNKNOWN */", reg_subtype, reg_off);
 }
 
+static const char *sbi_sta_id_to_str(__u64 reg_off)
+{
+	switch (reg_off) {
+	case 0: return "KVM_REG_RISCV_SBI_STA | KVM_REG_RISCV_SBI_STA_REG(shmem_lo)";
+	case 1: return "KVM_REG_RISCV_SBI_STA | KVM_REG_RISCV_SBI_STA_REG(shmem_hi)";
+	}
+	return strdup_printf("KVM_REG_RISCV_SBI_STA | %lld /* UNKNOWN */", reg_off);
+}
+
+static const char *sbi_id_to_str(const char *prefix, __u64 id)
+{
+	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_SBI_STATE);
+	__u64 reg_subtype = reg_off & KVM_REG_RISCV_SUBTYPE_MASK;
+
+	assert((id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_SBI_STATE);
+
+	reg_off &= ~KVM_REG_RISCV_SUBTYPE_MASK;
+
+	switch (reg_subtype) {
+	case KVM_REG_RISCV_SBI_STA:
+		return sbi_sta_id_to_str(reg_off);
+	}
+
+	return strdup_printf("%lld | %lld /* UNKNOWN */", reg_subtype, reg_off);
+}
+
 void print_reg(const char *prefix, __u64 id)
 {
 	const char *reg_size = NULL;
@@ -565,6 +593,10 @@ void print_reg(const char *prefix, __u64 id)
 		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_SBI_EXT | %s,\n",
 				reg_size, sbi_ext_id_to_str(prefix, id));
 		break;
+	case KVM_REG_RISCV_SBI_STATE:
+		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_SBI_STATE | %s,\n",
+				reg_size, sbi_id_to_str(prefix, id));
+		break;
 	default:
 		printf("\tKVM_REG_RISCV | %s | 0x%llx /* UNKNOWN */,\n",
 				reg_size, id & ~REG_MASK);
@@ -651,6 +683,12 @@ static __u64 sbi_base_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_VENDOR,
 };
 
+static __u64 sbi_sta_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_STA,
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_STA | KVM_REG_RISCV_SBI_STA_REG(shmem_lo),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_STA | KVM_REG_RISCV_SBI_STA_REG(shmem_hi),
+};
+
 static __u64 zicbom_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | KVM_REG_RISCV_CONFIG_REG(zicbom_block_size),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICBOM,
@@ -757,6 +795,9 @@ static __u64 fp_d_regs[] = {
 #define SUBLIST_SBI_BASE \
 	{"sbi-base", .feature_type = VCPU_FEATURE_SBI_EXT, .feature = KVM_RISCV_SBI_EXT_V01, \
 	 .regs = sbi_base_regs, .regs_n = ARRAY_SIZE(sbi_base_regs),}
+#define SUBLIST_SBI_STA \
+	{"sbi-sta", .feature_type = VCPU_FEATURE_SBI_EXT, .feature = KVM_RISCV_SBI_EXT_STA, \
+	 .regs = sbi_sta_regs, .regs_n = ARRAY_SIZE(sbi_sta_regs),}
 #define SUBLIST_ZICBOM \
 	{"zicbom", .feature = KVM_RISCV_ISA_EXT_ZICBOM, .regs = zicbom_regs, .regs_n = ARRAY_SIZE(zicbom_regs),}
 #define SUBLIST_ZICBOZ \
@@ -832,6 +873,7 @@ static struct vcpu_reg_list config_sbi_##ext = {		\
 /* Note: The below list is alphabetically sorted. */
 
 KVM_SBI_EXT_SUBLIST_CONFIG(base, BASE);
+KVM_SBI_EXT_SUBLIST_CONFIG(sta, STA);
 KVM_SBI_EXT_SIMPLE_CONFIG(pmu, PMU);
 KVM_SBI_EXT_SIMPLE_CONFIG(dbcn, DBCN);
 
@@ -858,6 +900,7 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zihpm, ZIHPM);
 
 struct vcpu_reg_list *vcpu_configs[] = {
 	&config_sbi_base,
+	&config_sbi_sta,
 	&config_sbi_pmu,
 	&config_sbi_dbcn,
 	&config_aia,
-- 
2.43.0

