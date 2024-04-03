Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63D312C80F
	for <virtualization@lists.linux.dev>; Wed,  3 Apr 2024 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131556; cv=none; b=LhmR83TL02xTfhuHFQIEd/zkcY6tdmHIJu3BPT6GSjS0iMPi1QMXBBlAgYvWlJ0diC1cBWPybvCwCXxvL+PmtAiG4ev1tTLDSe+ElWpYqMZIYyHGln0cqG9CwaQ2EWhnFfm5ViqSSfxzy5SIolEtLcudqLxgM2hRY4ketpYEMCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131556; c=relaxed/simple;
	bh=780bxI6naAUr6IQqUhjJBAL1yGnj9U7hJOgqG70RfWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=twQFdebJct+C//rxsv2tvgYCwwbAjxM85kZDfWgdxNS4uxQWaW2Y0ToPeKKQILhE2Otdw9shQGCV0sP/OitHKCAGG377hGXtORzQjuOS/bfSxpiVKPL7lza6uRfa0bq2fouOs/Ah2lZkS2KHMTdsby86h2OiDV4klr3xUEYSUlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kE/nZkC4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kE/nZkC4"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e0edd0340fso54653865ad.2
        for <virtualization@lists.linux.dev>; Wed, 03 Apr 2024 01:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131554; x=1712736354; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkhEh3Kwi0UVSPm+lxEXp9oZg2L7eBy2zYGiPlgLtso=;
        b=kE/nZkC4sx5n/7Bqqp5dlll4LElzjzzdbRScsFYuDZ8EKpgbzy3i2i628veGgPF0At
         cFr45Mc3Ott/8XfZPkwIj/bvjt5is8VYFJ+vpmP4rst/WnWX5VUhMi/lU5pc0iDq3pRT
         HafO9OKZ6sZIZkmo21ZUDUs35TlSKlVQdM204/5h9kp8j8mbkhg1G1bRWzDdTOOo3McL
         3IWVFV+F/wlogB/wWtF9YNx7MUsn/xLlCia6uLSwEG6cAfnHZmR+RYKZ/nxwnRhL8Cum
         6ewR9hpg3sEN71hvsKo0f3m/Ca9mPNDwTcb4acnPoqtaYocqL1MbZHWKVhiyHOcTny+l
         radA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131554; x=1712736354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkhEh3Kwi0UVSPm+lxEXp9oZg2L7eBy2zYGiPlgLtso=;
        b=ra3IcpdNraXI/DD6bhM+0CijqFur6mUq91uKoNAf8m5ICfGY+kywWErBAxeNqldTi0
         rGSnKYD4rym1QnJf2EX9rSB/rQcwTGya42PNdqNjrKZ6/bRcTKwvWpHQsi5Y+r9JQZuJ
         3N9tgQtKbBlirmcilRqNF7Z9jhbEnACt7rgZVIyXGvlr5YXXWLWkOUo/fgWHDp49m4al
         JkXCB1RLKZFyOkIAkt1ru4qLtmI9+5i4J+O8w3vXQCUruV3cDahFAkqgcy4MwubwUlwy
         FfOXtuH3n1Ef3eYL7QDYrb/osuinyCXXufQns2LI2JWiPwH9vlxaGVLXhgfY0+BUHWam
         pvdw==
X-Forwarded-Encrypted: i=1; AJvYcCVwdeJpMz31cMlCM+atUev28ZXRkFCaFnMm3Es+7QM4aTLTv2JN5a7FQVj6LA6GLdgO0VaM/ZEVzJ4Lt9HkSKJwLxswMb27ji/+gdKEx4Y=
X-Gm-Message-State: AOJu0YzWDlytJRpke0WR0StTo3173CSUxtSn9H7QvlGxueETUD+lXnzE
	707cue3pIyM4llerAOpRHBZdROsYVc3ULYJE2PN1NZNmYMm/yL1arPs8MZbPy5c=
X-Google-Smtp-Source: AGHT+IHXyVuhd2UN6DaFS3pRiDjXF6BBqw4nhkvMX8+6lolbeavqTSelxKMWeizm1rfTvMdNdGFtWA==
X-Received: by 2002:a17:903:292:b0:1e2:6240:72e7 with SMTP id j18-20020a170903029200b001e2624072e7mr5867168plr.53.1712131554171;
        Wed, 03 Apr 2024 01:05:54 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:52 -0700 (PDT)
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
Subject: [PATCH v5 19/22] KVM: riscv: selftests: Add SBI PMU extension definitions
Date: Wed,  3 Apr 2024 01:04:48 -0700
Message-Id: <20240403080452.1007601-20-atishp@rivosinc.com>
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

The SBI PMU extension definition is required for upcoming SBI PMU
selftests.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 .../testing/selftests/kvm/include/riscv/sbi.h | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/riscv/sbi.h b/tools/testing/selftests/kvm/include/riscv/sbi.h
index ba04f2dec7b5..6675ca673c77 100644
--- a/tools/testing/selftests/kvm/include/riscv/sbi.h
+++ b/tools/testing/selftests/kvm/include/riscv/sbi.h
@@ -29,17 +29,83 @@
 enum sbi_ext_id {
 	SBI_EXT_BASE = 0x10,
 	SBI_EXT_STA = 0x535441,
+	SBI_EXT_PMU = 0x504D55,
 };
 
 enum sbi_ext_base_fid {
 	SBI_EXT_BASE_PROBE_EXT = 3,
 };
+enum sbi_ext_pmu_fid {
+	SBI_EXT_PMU_NUM_COUNTERS = 0,
+	SBI_EXT_PMU_COUNTER_GET_INFO,
+	SBI_EXT_PMU_COUNTER_CFG_MATCH,
+	SBI_EXT_PMU_COUNTER_START,
+	SBI_EXT_PMU_COUNTER_STOP,
+	SBI_EXT_PMU_COUNTER_FW_READ,
+	SBI_EXT_PMU_COUNTER_FW_READ_HI,
+	SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
+};
+
+union sbi_pmu_ctr_info {
+	unsigned long value;
+	struct {
+		unsigned long csr:12;
+		unsigned long width:6;
+#if __riscv_xlen == 32
+		unsigned long reserved:13;
+#else
+		unsigned long reserved:45;
+#endif
+		unsigned long type:1;
+	};
+};
 
 struct sbiret {
 	long error;
 	long value;
 };
 
+/** General pmu event codes specified in SBI PMU extension */
+enum sbi_pmu_hw_generic_events_t {
+	SBI_PMU_HW_NO_EVENT			= 0,
+	SBI_PMU_HW_CPU_CYCLES			= 1,
+	SBI_PMU_HW_INSTRUCTIONS			= 2,
+	SBI_PMU_HW_CACHE_REFERENCES		= 3,
+	SBI_PMU_HW_CACHE_MISSES			= 4,
+	SBI_PMU_HW_BRANCH_INSTRUCTIONS		= 5,
+	SBI_PMU_HW_BRANCH_MISSES		= 6,
+	SBI_PMU_HW_BUS_CYCLES			= 7,
+	SBI_PMU_HW_STALLED_CYCLES_FRONTEND	= 8,
+	SBI_PMU_HW_STALLED_CYCLES_BACKEND	= 9,
+	SBI_PMU_HW_REF_CPU_CYCLES		= 10,
+
+	SBI_PMU_HW_GENERAL_MAX,
+};
+
+/* SBI PMU counter types */
+enum sbi_pmu_ctr_type {
+	SBI_PMU_CTR_TYPE_HW = 0x0,
+	SBI_PMU_CTR_TYPE_FW,
+};
+
+/* Flags defined for config matching function */
+#define SBI_PMU_CFG_FLAG_SKIP_MATCH	BIT(0)
+#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	BIT(1)
+#define SBI_PMU_CFG_FLAG_AUTO_START	BIT(2)
+#define SBI_PMU_CFG_FLAG_SET_VUINH	BIT(3)
+#define SBI_PMU_CFG_FLAG_SET_VSINH	BIT(4)
+#define SBI_PMU_CFG_FLAG_SET_UINH	BIT(5)
+#define SBI_PMU_CFG_FLAG_SET_SINH	BIT(6)
+#define SBI_PMU_CFG_FLAG_SET_MINH	BIT(7)
+
+/* Flags defined for counter start function */
+#define SBI_PMU_START_FLAG_SET_INIT_VALUE BIT(0)
+#define SBI_PMU_START_FLAG_INIT_SNAPSHOT BIT(1)
+
+/* Flags defined for counter stop function */
+#define SBI_PMU_STOP_FLAG_RESET BIT(0)
+#define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT BIT(1)
+
 struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg1, unsigned long arg2,
 			unsigned long arg3, unsigned long arg4,
-- 
2.34.1

