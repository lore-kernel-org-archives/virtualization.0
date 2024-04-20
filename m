Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC4814A0B2
	for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 23:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570499; cv=none; b=HWEn8ugwIMDQ/FoQrfudmCgjY1cm3Pbx4kUg0LpwyKAiRrKOY6+Xbredx6bCNdEpA+kFxNdgYjGpizf4Zhl4XIf3K4luFYnDzX/wC8CTj0PxyJNDZlrdZXNF+vdsB/vBVur+Y4+KxK++91s9ho2UL3RJZy6797jL7fgJIVZ0djw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570499; c=relaxed/simple;
	bh=RcVsdOTpWmQDe3QFQB057eZKtxuHNPDvA9mLhc2A9Tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nME/cDSYN/b55LpPZmmjrAQ6PnD5fwvwzyaRXaszJkrhe0ztfkZCz32Y4BbMJzAHEh1kIk43Oq73n48/43hu9Fq3swVaXPiEN5xJ85GtU6MLkitiPpfbjFKm43ad4LWc1OxX6bY7GSEJ/7RkR4TJG0KgLreEigg0nL7rBFVADQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3IebMq1a; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3IebMq1a"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e411e339b8so20031635ad.3
        for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 16:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570497; x=1714175297; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBWeKaYtpXhvKjSg+whNN/rWnhjngNSIx7A/W77I8WQ=;
        b=3IebMq1af5SidIYHaC3dJ47mt/SlbMGescX545eT+nhc6khbwOkPFJR0MfAUvuquYj
         TMzGrEoNW7bjrsU4EoDP8xFdjQsNmNVozV5kN6+fKCtFXDva5M26/KWYf//00TzZ4b1W
         H9LaGyz453vuKM0jPX9jDIRsi8C5DFVp4XVcD926Ypir+cFYGuva7P5rT6CIfh9AFZZp
         c/r3hkzHBZeF3Y1UHSTrkWu1p8uZBMXhE49czSl6Zy8UNv0uHFJOcW1xHWAfHWKZ8mPx
         /e+L0Ag1RUIijC4eMTUDt4BQlnKFA/TH2MCe3Z7pEDtaOGYfsPXm4Oa1fQtWBPbzJZIm
         +HGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570497; x=1714175297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBWeKaYtpXhvKjSg+whNN/rWnhjngNSIx7A/W77I8WQ=;
        b=Cd75qtmMAY+2J72zE1uJT2SZLsZ4ql54tsYjLuZK87VHT/ZKGis4cGR6rFDMjcvktV
         6QECo7tWHwqaTU1Jp5afJkkdMi110i6U/3uvEP/ykp3w/R0UeQUTHRof17W6qbQbCsRj
         DMWWIKFF3+qlEP/hlpP/uZI6LCu9yTlbArknDHoNyRweijvWMt1uCLVX/OpXP1r9QYOF
         273ZCy0pWTSxaw8WXFEGne6c4YoA/7l5n0bFffM+2LG4JWFqnzDNXgWZ5WMWzCGBkZub
         enf9Dk9Rtz3QVd3mP/ob721yZyfddEyQcb7zNJYQwTgusU7TLwYiW29TAJiIvzjFw3Ac
         c3Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVOGBVnjPFfZjEZIPVLPJ/a+sJj27k2DGmcHSWlH/tx60A+4qASDXYuIOIOobUpEqNozB+Kq04VFjJLplOZXUVsxWz5tcQt2UUl9sup2Vs=
X-Gm-Message-State: AOJu0YyWMZXpsLeoPXqS6HhQNcUFnpIlTM0R2sYGUXgk0DCoNiOYQBNq
	8ikqP/KL26YyfL7AhnA0agm5fSqKn1HVQkj7xXtuMlCZbsgaPXNW4GJEevdXoG4=
X-Google-Smtp-Source: AGHT+IE2mHqGqaemrrX/cDzhjt11McUd9BYci2ip5fvQwZrUnUGPNDdVb8jlSh60g/yN+PhfEpHNag==
X-Received: by 2002:a17:902:da89:b0:1e4:2d13:cf68 with SMTP id j9-20020a170902da8900b001e42d13cf68mr5056407plx.17.1713570497604;
        Fri, 19 Apr 2024 16:48:17 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:48:17 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	samuel.holland@sifive.com,
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
Subject: [PATCH v8 18/24] KVM: riscv: selftests: Add helper functions for extension checks
Date: Sat, 20 Apr 2024 08:17:34 -0700
Message-Id: <20240420151741.962500-19-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420151741.962500-1-atishp@rivosinc.com>
References: <20240420151741.962500-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__vcpu_has_ext can check both SBI and ISA extensions when the first
argument is properly converted to SBI/ISA extension IDs. Introduce
two helper functions to make life easier for developers so they
don't have to worry about the conversions.

Replace the current usages as well with new helpers.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 tools/testing/selftests/kvm/include/riscv/processor.h | 10 ++++++++++
 tools/testing/selftests/kvm/riscv/arch_timer.c        |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index 3b9cb39327ff..5f389166338c 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -50,6 +50,16 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t subtype,
 
 bool __vcpu_has_ext(struct kvm_vcpu *vcpu, uint64_t ext);
 
+static inline bool __vcpu_has_isa_ext(struct kvm_vcpu *vcpu, uint64_t isa_ext)
+{
+	return __vcpu_has_ext(vcpu, RISCV_ISA_EXT_REG(isa_ext));
+}
+
+static inline bool __vcpu_has_sbi_ext(struct kvm_vcpu *vcpu, uint64_t sbi_ext)
+{
+	return __vcpu_has_ext(vcpu, RISCV_SBI_EXT_REG(sbi_ext));
+}
+
 struct ex_regs {
 	unsigned long ra;
 	unsigned long sp;
diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/tools/testing/selftests/kvm/riscv/arch_timer.c
index 0f9cabd99fd4..735b78569021 100644
--- a/tools/testing/selftests/kvm/riscv/arch_timer.c
+++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
@@ -85,7 +85,7 @@ struct kvm_vm *test_vm_create(void)
 	int nr_vcpus = test_args.nr_vcpus;
 
 	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
-	__TEST_REQUIRE(__vcpu_has_ext(vcpus[0], RISCV_ISA_EXT_REG(KVM_RISCV_ISA_EXT_SSTC)),
+	__TEST_REQUIRE(__vcpu_has_isa_ext(vcpus[0], KVM_RISCV_ISA_EXT_SSTC),
 				   "SSTC not available, skipping test\n");
 
 	vm_init_vector_tables(vm);
-- 
2.34.1

