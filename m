Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13DD80607
	for <virtualization@lists.linux.dev>; Wed,  3 Apr 2024 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131533; cv=none; b=WUOVbF1mIfvTopLMwvkg0L2Xw1O7sYEgcycX2vhtHQRMxoZSUZ2PGvRHo20i2WPPHs+YN7rLY8ZrhD7ulIOqXbWxKkvi8AmvK6VXd647Z0MZYp5LvOspLSMLryRecbfZMVqMRUkSE2CkKO04ixzn12F12fWmxkJ/hEFQo6ZTMCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131533; c=relaxed/simple;
	bh=es6oj90niK7eIua41w4bb0VuAogviBB5JDOj1DIbVoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h3mD3c5JnHdBfSqR4CrkSHuf5LgbUeTePEqUXXL187IBur9RDt85vutEfpJAQggTUUhO2caozgzhUPnIdmmjxaeMwGDxlz70bT+2rn20SnIEDXz5Ie5z0PPeFxsV2PZ13NKfhxGr8CQC4nzJNfwd4NpTr6vbRUDif0t4O+YPVyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cEeU416b; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cEeU416b"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e28856ed7aso8288155ad.0
        for <virtualization@lists.linux.dev>; Wed, 03 Apr 2024 01:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131531; x=1712736331; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MJsU2/1DVF77yTSQMrmRq+eYVFGn04LSwUVmAHv4W8=;
        b=cEeU416bEt1WV93r48GjVh1R1/EaOzacU5b0VrclxP2PKDqmmWcGgShj305BEOfKNb
         uJFRyuBGbY6I2mZbY2e3cQMze/qbD1/6AoPLHlmE6KdnaWFGMEgZRPZix5A5DH2Lp8hm
         PN9XZetPsVtGKAZ/vW/mORiOLs99xiZy+5ahRGVyjBXGegKlgS3Y0alzavkz3XpcR157
         JhURhegyG66IIAAcxk6ch5mUHxMQEEw9LgwbXHEbv2rrUO5qiB3N6NULS/Ep8IcdGagZ
         6t7Gib9fDdAjP4Grjp7h4PpPDTCmdRwWjEhBEh+7EUph6B6zorxmsloqLKVddyPXpdKH
         NGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131531; x=1712736331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MJsU2/1DVF77yTSQMrmRq+eYVFGn04LSwUVmAHv4W8=;
        b=Q36MqsbTHRYzGdo0aAckfLogbFn3J6zkQOsVI6od7cT27p2fiOXoP6biyjPxd2+CM/
         aKebKqGVSrDr0gMMs54RRJCWihjjcOdw6lO63rhhnqjQz266XZIQUorsL22+6wDkdLx8
         kTboAsw/R5J3sc+/80m+E8VV+kyvJTPZr/vuhanD09g7tGuRz98LO+3wQDkXvz6/5t/C
         RGzXGm1G+to1olN9z/1lQyDRE39G2sEK4p4NKtkz6lXQaPuEs9C+19ijRG5tpMD7pTfs
         RIXomzJADE1aRd19Tej2EaP1JSuJSOgeql6fCBDXNFBzUp3pmp6+Jn6JmVyUjitS/mOX
         1lrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6bLeMxIq5tnvsZyVSbyiGBmc2fI0MpcQ1jahZU0v7dgoPnA3OcbQd2Vwe/BuVLo58h4/Ai3EkmfgOhIjrCBqHnSBaQTetDQnLgoQQHsM=
X-Gm-Message-State: AOJu0YwWITDvJwJXXSnbmWpB8XjqPVQEwgLPnwdn5V5OuPfyty6PWyu8
	VfhOKj03swN+1793swJNFVuKj37eX+R8qMMof9amSZ4laELbb/hInEokKPF4gro=
X-Google-Smtp-Source: AGHT+IE6hcM+iluLyfs2xAMwl4nidxEf2cHLsogRdu+mNxI8DxtzYjnOXL+jL/8fbjTuoDpYxOz/uQ==
X-Received: by 2002:a17:903:244c:b0:1e2:6191:f6ae with SMTP id l12-20020a170903244c00b001e26191f6aemr2389190pls.0.1712131531142;
        Wed, 03 Apr 2024 01:05:31 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:30 -0700 (PDT)
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
Subject: [PATCH v5 09/22] RISC-V: KVM: Rename the SBI_STA_SHMEM_DISABLE to a generic name
Date: Wed,  3 Apr 2024 01:04:38 -0700
Message-Id: <20240403080452.1007601-10-atishp@rivosinc.com>
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

SBI_STA_SHMEM_DISABLE is a macro to invoke disable shared memory
commands. As this can be invoked from other SBI extension context
as well, rename it to more generic name as SBI_SHMEM_DISABLE.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h  | 2 +-
 arch/riscv/kernel/paravirt.c  | 6 +++---
 arch/riscv/kvm/vcpu_sbi_sta.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 9aada4b9f7b5..f31650b10899 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -277,7 +277,7 @@ struct sbi_sta_struct {
 	u8 pad[47];
 } __packed;
 
-#define SBI_STA_SHMEM_DISABLE		-1
+#define SBI_SHMEM_DISABLE		-1
 
 /* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1
diff --git a/arch/riscv/kernel/paravirt.c b/arch/riscv/kernel/paravirt.c
index 0d6225fd3194..fa6b0339a65d 100644
--- a/arch/riscv/kernel/paravirt.c
+++ b/arch/riscv/kernel/paravirt.c
@@ -62,7 +62,7 @@ static int sbi_sta_steal_time_set_shmem(unsigned long lo, unsigned long hi,
 	ret = sbi_ecall(SBI_EXT_STA, SBI_EXT_STA_STEAL_TIME_SET_SHMEM,
 			lo, hi, flags, 0, 0, 0);
 	if (ret.error) {
-		if (lo == SBI_STA_SHMEM_DISABLE && hi == SBI_STA_SHMEM_DISABLE)
+		if (lo == SBI_SHMEM_DISABLE && hi == SBI_SHMEM_DISABLE)
 			pr_warn("Failed to disable steal-time shmem");
 		else
 			pr_warn("Failed to set steal-time shmem");
@@ -84,8 +84,8 @@ static int pv_time_cpu_online(unsigned int cpu)
 
 static int pv_time_cpu_down_prepare(unsigned int cpu)
 {
-	return sbi_sta_steal_time_set_shmem(SBI_STA_SHMEM_DISABLE,
-					    SBI_STA_SHMEM_DISABLE, 0);
+	return sbi_sta_steal_time_set_shmem(SBI_SHMEM_DISABLE,
+					    SBI_SHMEM_DISABLE, 0);
 }
 
 static u64 pv_time_steal_clock(int cpu)
diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
index d8cf9ca28c61..5f35427114c1 100644
--- a/arch/riscv/kvm/vcpu_sbi_sta.c
+++ b/arch/riscv/kvm/vcpu_sbi_sta.c
@@ -93,8 +93,8 @@ static int kvm_sbi_sta_steal_time_set_shmem(struct kvm_vcpu *vcpu)
 	if (flags != 0)
 		return SBI_ERR_INVALID_PARAM;
 
-	if (shmem_phys_lo == SBI_STA_SHMEM_DISABLE &&
-	    shmem_phys_hi == SBI_STA_SHMEM_DISABLE) {
+	if (shmem_phys_lo == SBI_SHMEM_DISABLE &&
+	    shmem_phys_hi == SBI_SHMEM_DISABLE) {
 		vcpu->arch.sta.shmem = INVALID_GPA;
 		return 0;
 	}
-- 
2.34.1

