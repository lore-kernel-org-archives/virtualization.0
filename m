Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB9586656
	for <virtualization@lists.linux.dev>; Wed,  3 Apr 2024 08:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131543; cv=none; b=XkRgr/nMjfjBMzR8++mj7ulkE6JzVewopVCCPSe8kri4bQ1pUcggeNYbiHq/fWvaydYdgmAfCsErRSW+cefSxshO60Iqslo5kXOAiC8qT1iFjNi2urs1M+ErO2WFWN7gYCjiLz7QhXUyJo+5iL8N0TAJdalOoft4so72MI+1N3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131543; c=relaxed/simple;
	bh=Ior8j+spd+ufLG6mBQquUh2m0UyxRYdYbbEmV926TsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LpfeNlpb2abdxSRZHfhC3/gyoAOJc6XRWAGi8khMWcIRQz4GfSyP4UDtsBJ39vak4UO1zWchKEGFTDqRHgSyIJrb56azHefR+SM8TtqfCk1/FMroa1Lioes25OHK3i8wqv1wcmor6om4GysaN92k/U01Z38/Lf0UlHZ3mZSIJjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HBhPfJ+i; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HBhPfJ+i"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6eac64f2205so5049392b3a.2
        for <virtualization@lists.linux.dev>; Wed, 03 Apr 2024 01:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131541; x=1712736341; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZ3FkBLSpZeB7lcfW0sTr11VliYr1a02KCqdXY16nx8=;
        b=HBhPfJ+i4Xc2EGJC+F9vzD6KdphyMmSXiVuC8wYeR5J7NthbRMSsz6NZ1lHwxiyo/J
         EgJZ6MpgvC8IS96qbgZ6/11xjdcNYaxW7IdTl8NZWxuCRvJZYaKOPMkiwmQ7h/+udE1a
         piPWdmAh2DJZVUb3kz1UCKVBigYQuzi/02MuwbX4SDfFcL50wh4RJSZfI1+DWWu8nETq
         oIprg8LW1PQISQ9L2ajk/bBdR7lNgBLrpCwGfStWeG465P9/yVKlsF3mWD7ZMXkyyIFD
         jhBYACmmXrmgBvk47jkpNvF1rb+HXb8cS1ctraqMDILqat3uvIOZnhWYNZbwWK6Vtcwn
         wlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131541; x=1712736341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZ3FkBLSpZeB7lcfW0sTr11VliYr1a02KCqdXY16nx8=;
        b=wvabUq8tPK1zxoAHKFxS68AGcxRmD9UnCU3ijp3apSGZtVA/ueTQr8TpZoTVBCkAvN
         RLrmQFbWJSjIDFRa7uNVXpsuqrdFC1NNgFjEn5hEQTm8pVWIjdy9oX817MM3skOcvW03
         MIrx91jMj7fvk9iGOyYEuq98MC0PTjSwUieN+LclR24l1ASlNmZ+w9RiETCBmwFKQFTS
         uR+MW/lRPSUOIXYbXdk3v+sNHDSeyG/z0JA6AG7UjjPJDGnYEycigQDuz9XYToX6Njj4
         ygQirvaAeddB1nLIzb7CaizzUGQkT/zXQjX7k0+gl9ZUxnn8W2+BTeUN3eI3++vaEz7E
         d52A==
X-Forwarded-Encrypted: i=1; AJvYcCWWL0AVVEHM902/RCN4zW1cD+6KHn5fjmITP3VYKSZwXtN3nBumfAlPY+OsPOlMkG593OwionUHCItXGp+dPuuv6Q7gF6v6ivTOG/HebkI=
X-Gm-Message-State: AOJu0YzC1uKjyndsrYlhb8y+XMXij2EgIjHChU6V8IJIqoBD5evyecUy
	6CJtvHYde5xioGjYEaE6pgeFS40a7GxGJkFIPiXfWhBJHeu0JWAmdWkopnJ0BAk=
X-Google-Smtp-Source: AGHT+IEAq+anA/aMtiO8arRrh2Jnm92J1PBH5kUlEvdhS5op/jw7hZzAqhRtuwLXN5Zk3guWOTaagw==
X-Received: by 2002:a05:6a20:9e4c:b0:1a3:ca3c:c62b with SMTP id mt12-20020a056a209e4c00b001a3ca3cc62bmr17369882pzb.19.1712131541148;
        Wed, 03 Apr 2024 01:05:41 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:40 -0700 (PDT)
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
Subject: [PATCH v5 14/22] RISC-V: KVM: Support 64 bit firmware counters on RV32
Date: Wed,  3 Apr 2024 01:04:43 -0700
Message-Id: <20240403080452.1007601-15-atishp@rivosinc.com>
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

The SBI v2.0 introduced a fw_read_hi function to read 64 bit firmware
counters for RV32 based systems.

Add infrastructure to support that.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/kvm_vcpu_pmu.h |  4 ++-
 arch/riscv/kvm/vcpu_pmu.c             | 44 ++++++++++++++++++++++++++-
 arch/riscv/kvm/vcpu_sbi_pmu.c         |  6 ++++
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include/asm/kvm_vcpu_pmu.h
index 257f17641e00..55861b5d3382 100644
--- a/arch/riscv/include/asm/kvm_vcpu_pmu.h
+++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
@@ -20,7 +20,7 @@ static_assert(RISCV_KVM_MAX_COUNTERS <= 64);
 
 struct kvm_fw_event {
 	/* Current value of the event */
-	unsigned long value;
+	u64 value;
 
 	/* Event monitoring status */
 	bool started;
@@ -91,6 +91,8 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
 				     struct kvm_vcpu_sbi_return *retdata);
 int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 				struct kvm_vcpu_sbi_return *retdata);
+int kvm_riscv_vcpu_pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
+				      struct kvm_vcpu_sbi_return *retdata);
 void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu);
 int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long saddr_low,
 				      unsigned long saddr_high, unsigned long flags,
diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 9fedf9dc498b..ff326152eeff 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -197,6 +197,36 @@ static int pmu_get_pmc_index(struct kvm_pmu *pmu, unsigned long eidx,
 	return kvm_pmu_get_programmable_pmc_index(pmu, eidx, cbase, cmask);
 }
 
+static int pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
+			      unsigned long *out_val)
+{
+	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
+	struct kvm_pmc *pmc;
+	int fevent_code;
+
+	if (!IS_ENABLED(CONFIG_32BIT)) {
+		pr_warn("%s: should be invoked for only RV32\n", __func__);
+		return -EINVAL;
+	}
+
+	if (cidx >= kvm_pmu_num_counters(kvpmu) || cidx == 1) {
+		pr_warn("Invalid counter id [%ld]during read\n", cidx);
+		return -EINVAL;
+	}
+
+	pmc = &kvpmu->pmc[cidx];
+
+	if (pmc->cinfo.type != SBI_PMU_CTR_TYPE_FW)
+		return -EINVAL;
+
+	fevent_code = get_event_code(pmc->event_idx);
+	pmc->counter_val = kvpmu->fw_event[fevent_code].value;
+
+	*out_val = pmc->counter_val >> 32;
+
+	return 0;
+}
+
 static int pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 			unsigned long *out_val)
 {
@@ -705,6 +735,18 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
 	return 0;
 }
 
+int kvm_riscv_vcpu_pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
+				      struct kvm_vcpu_sbi_return *retdata)
+{
+	int ret;
+
+	ret = pmu_fw_ctr_read_hi(vcpu, cidx, &retdata->out_val);
+	if (ret == -EINVAL)
+		retdata->err_val = SBI_ERR_INVALID_PARAM;
+
+	return 0;
+}
+
 int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 				struct kvm_vcpu_sbi_return *retdata)
 {
@@ -778,7 +820,7 @@ void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu)
 			pmc->cinfo.csr = CSR_CYCLE + i;
 		} else {
 			pmc->cinfo.type = SBI_PMU_CTR_TYPE_FW;
-			pmc->cinfo.width = BITS_PER_LONG - 1;
+			pmc->cinfo.width = 63;
 		}
 	}
 
diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.c
index d3e7625fb2d2..cf111de51bdb 100644
--- a/arch/riscv/kvm/vcpu_sbi_pmu.c
+++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
@@ -64,6 +64,12 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	case SBI_EXT_PMU_COUNTER_FW_READ:
 		ret = kvm_riscv_vcpu_pmu_ctr_read(vcpu, cp->a0, retdata);
 		break;
+	case SBI_EXT_PMU_COUNTER_FW_READ_HI:
+		if (IS_ENABLED(CONFIG_32BIT))
+			ret = kvm_riscv_vcpu_pmu_fw_ctr_read_hi(vcpu, cp->a0, retdata);
+		else
+			retdata->out_val = 0;
+		break;
 	case SBI_EXT_PMU_SNAPSHOT_SET_SHMEM:
 		ret = kvm_riscv_vcpu_pmu_snapshot_set_shmem(vcpu, cp->a0, cp->a1, cp->a2, retdata);
 		break;
-- 
2.34.1

