Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB87286656
	for <virtualization@lists.linux.dev>; Wed,  3 Apr 2024 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131545; cv=none; b=DLNHt25TA/Vhvqh18DCZTqSHisE89EnMFZ2oRkgGsgf1yG/TCcR/P1+ucwVa0FFV4G2M7LlLTIHU9fXCd4ai0juLs4k61nMdGWzm0vdFaUYpgSHUIRDEh2QJGQFMSZLXxyEDT0WArR+vde4n5wXDpFblckJRNMOBCcfhirtziw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131545; c=relaxed/simple;
	bh=bM8YEfWLGTqv0xxOOBxSCTgoJM3x8dV7ewXvwA2n16I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gsyfui+Kx9oGf4sYWaCYlUird9U4DyUoCvEq86PXM4+C31ORvLwfkF1LkeTX/z9LfcWwChOu9yIgGQLDQ9opOnYOmuUpDBg8H+GoMjacBBzlnA/1Bxq3+NAuwh/GiraJZpWyOnhUN6QVurZ2hj6kyVOhJ/k72dbwiX3my0bAVzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sfDvodRP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sfDvodRP"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e244c7cbf8so28555015ad.0
        for <virtualization@lists.linux.dev>; Wed, 03 Apr 2024 01:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131543; x=1712736343; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwALXHKqCD9Iy5mIzImMbfILjpXmZkM44DIWXWIBe7w=;
        b=sfDvodRP6jLVX9hY0uP3tmitiGF0o0uVw/P69VKmuRQgTgVDS5oppDjMBbYF8tK+IU
         vs04AEyeMAKVCIbGDi6ROlr2pT1baCO8E8nHlJZG1rWZbHAaeES8PRWimr45BF4Vw96+
         qHBcFhVOB47EugRxrOORzwf2qsPFoZbNhMN2edV2C2NF/IPd/X6stUHMSmWR2OP3Gt2s
         nUJK0+zLRE6V64C/ubryqJMAVb7yW9suySf8Kdh06npYWewNR7Ogzyh9zjKbUf4M3klR
         MPYs3BLgHom/uJg997buzmTLIVO/AZDFxok7GfhYnTV3xKblyLx6bPEtVmXkuTIfkTMp
         XOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131543; x=1712736343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwALXHKqCD9Iy5mIzImMbfILjpXmZkM44DIWXWIBe7w=;
        b=icZ5rzin7GjBwP2KLJh74D+yA36Ge/MaIQXjoa+GrFcYX2uaeX5nItb/zyN5sKiC/i
         QbNKJzmwxsMD0wqjtw7BZdg0crzTXTLxMvMqmqpky9CrScnXXgkNVzyBIXtxD1Ug+ioe
         bPrtxZNl+msPV4tvmRArEhqBcaL+cDlEMpu4AGrIPIqSuB3dcnemQAbcedDSiE+ZuqDE
         TgrrD9jKMw//cbwVdM1OvfVMlKKNemT6DbBBClLKKr5xVUet77oYzsZVH5JtQ6nLzQbX
         qV4Los+mvg7+B+6DZl6jP6pDb4lKX9LrCHOWAC2zxwgwuLhHWewuEhPJ684VQb+Rjqit
         hxSw==
X-Forwarded-Encrypted: i=1; AJvYcCUx9Vaq7jK9P/a5PYekbyey7p7U+ZzCDftcdbb12R0JIaSR6o8DAbr7punMUo/7R2r2GSqNhP4MaTE1Ejd7wKhr0mGV4Eh17UtJEVEPozQ=
X-Gm-Message-State: AOJu0Yzi5Sq+156Zjq1l1UrQGAZs3XPjFaB4/EI95l+dJze0m7vo13ux
	cvIe6wap0vC8iMKkEM0CPbE2EK7Is//1BhDg1u/cgGubjjzEhH7pB9iRl6YfX3k=
X-Google-Smtp-Source: AGHT+IFqbJuXOQnG+Kx5BB+hJvgv/ZybZvtn14tS9BuaWyH/U/F2Vi2RSE0rwqy3IKMxLYQ7u8QtTQ==
X-Received: by 2002:a17:903:2283:b0:1e0:b60e:1a33 with SMTP id b3-20020a170903228300b001e0b60e1a33mr2264737plh.31.1712131543069;
        Wed, 03 Apr 2024 01:05:43 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:42 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Ajay Kaher <akaher@vmware.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
	Andrew Jones <ajones@ventanamicro.com>,
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
Subject: [PATCH v5 15/22] RISC-V: KVM: Improve firmware counter read function
Date: Wed,  3 Apr 2024 01:04:44 -0700
Message-Id: <20240403080452.1007601-16-atishp@rivosinc.com>
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

Rename the function to indicate that it is meant for firmware
counter read. While at it, add a range sanity check for it as
well.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/kvm_vcpu_pmu.h | 2 +-
 arch/riscv/kvm/vcpu_pmu.c             | 7 ++++++-
 arch/riscv/kvm/vcpu_sbi_pmu.c         | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include/asm/kvm_vcpu_pmu.h
index 55861b5d3382..fa0f535bbbf0 100644
--- a/arch/riscv/include/asm/kvm_vcpu_pmu.h
+++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
@@ -89,7 +89,7 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
 				     unsigned long ctr_mask, unsigned long flags,
 				     unsigned long eidx, u64 evtdata,
 				     struct kvm_vcpu_sbi_return *retdata);
-int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
+int kvm_riscv_vcpu_pmu_fw_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 				struct kvm_vcpu_sbi_return *retdata);
 int kvm_riscv_vcpu_pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
 				      struct kvm_vcpu_sbi_return *retdata);
diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index ff326152eeff..94efa88d054d 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -235,6 +235,11 @@ static int pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 	u64 enabled, running;
 	int fevent_code;
 
+	if (cidx >= kvm_pmu_num_counters(kvpmu) || cidx == 1) {
+		pr_warn("Invalid counter id [%ld] during read\n", cidx);
+		return -EINVAL;
+	}
+
 	pmc = &kvpmu->pmc[cidx];
 
 	if (pmc->cinfo.type == SBI_PMU_CTR_TYPE_FW) {
@@ -747,7 +752,7 @@ int kvm_riscv_vcpu_pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
 	return 0;
 }
 
-int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
+int kvm_riscv_vcpu_pmu_fw_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 				struct kvm_vcpu_sbi_return *retdata)
 {
 	int ret;
diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.c
index cf111de51bdb..e4be34e03e83 100644
--- a/arch/riscv/kvm/vcpu_sbi_pmu.c
+++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
@@ -62,7 +62,7 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		ret = kvm_riscv_vcpu_pmu_ctr_stop(vcpu, cp->a0, cp->a1, cp->a2, retdata);
 		break;
 	case SBI_EXT_PMU_COUNTER_FW_READ:
-		ret = kvm_riscv_vcpu_pmu_ctr_read(vcpu, cp->a0, retdata);
+		ret = kvm_riscv_vcpu_pmu_fw_ctr_read(vcpu, cp->a0, retdata);
 		break;
 	case SBI_EXT_PMU_COUNTER_FW_READ_HI:
 		if (IS_ENABLED(CONFIG_32BIT))
-- 
2.34.1

