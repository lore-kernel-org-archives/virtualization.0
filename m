Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDA76EB67
	for <virtualization@lists.linux.dev>; Wed,  3 Apr 2024 08:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131550; cv=none; b=P0MhlsFO9XnWp57RMcJSV9N6WuQsv2SQFXI4lszRSm6eRTDIfKxFiWze2fdyGFRy6oWxYmLJMlokY/HhmNsFWIL+BFNm5zaPZZoYI2iSzIT5fvHNPNCMn3OyUGZd/3bqLXed3ZSn5AqO/KRH8lMkWRwvXy4xh7Nv+6uFs+XhOiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131550; c=relaxed/simple;
	bh=evlE8hTl45MyJIsfxvr/2bRxoIA3bwQv3sS8gzvU/GA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E8NuH32OI/9ZzKkq067WaKU8s+k1IBY1TBkO/wt8+AShFVrdMBhMV2xhLx/kraMIsGq2X/Vy/oShoVGGzmOWW/CF+1Ij2xT3yUy9MGeF5nGmAugiMoErnckKiZNrFR2SP68mf/fu2miYoZzkMNGbNqebCW7J5Q1LtIZrnrS9+lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=inukGr2N; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="inukGr2N"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e2987e9d67so1071575ad.1
        for <virtualization@lists.linux.dev>; Wed, 03 Apr 2024 01:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131548; x=1712736348; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiceCABnvA1jknfstt9FkxftBmpWokdNdmMlEhNsfyg=;
        b=inukGr2N3gCnV1ycJxgw16tdcBfuejCnnnDu+/bvWnxoIB3iSfLTTcEJPcyrrffeq2
         fFCw4VhPTQ5f/8GXT2pOg34jWMqRYR1k2IABw9Xy7ph61JcLxhoG15jgP/pumtjiMd8v
         UCRQRpkR30mrst2ABv+lto312QQZx51uUqTXWRFLbr9QwJ9NkA9C+ViYVp9KYbgPfhb4
         UZNNAzZq4gDgaD46sKSTnesgL91ucNWlTJfB2q+I5isRGV9sxlqDqH49zt/u0v87+cfW
         hqpqMSSFp4fywHgZvhZki6dMdhhw/MaAPTDPJiEy5aZiATbCjaIFcpqKI1ArQmd0IE9Y
         rWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131548; x=1712736348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiceCABnvA1jknfstt9FkxftBmpWokdNdmMlEhNsfyg=;
        b=fIPYbxmyO8wYeTZrWn5cafK1K5LBxNVX+OFjUvugadOki06N/LP0TuQUmDqIPYTm57
         oEjjRGz2NTKAXi0Z5Lao9/GK8z+f/egFiRnHYJI5T4I2JGwocBw3TMrlaMcAiAthWy6p
         Um4/t9Pqx6CEt4E3drcV5t4MqoKtTbu+/C/BcNsXayULtqny2wY5rnMQz0L2V5xd/o84
         5kHdsALvjRzwasb+gyD2UtSbOvcoEdPTUHIHQQlGUkHwx4IpQkJai/OHjZgnNMk9ALMd
         S8buvZmfIvwUiFJz6Va1EGt6x4wBTV/vCPwgOupeOwUqgP07v3vFQbU24DUu3TlREZqb
         AV/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBlfXSydwTMpj6SuqSV/Sq/L9lWCHFhmnRzJZnFUfT/C+n4z8Wmusaz9sAMtwlb86hsCMhhfJiSMK0jp/kkNSj8SHzpXgJnEnjYWR8jgI=
X-Gm-Message-State: AOJu0Yw5Sr4ELwBQD6w1BSQmrI/gqqYS8d2RwIgccdgciTDghl4QgMGk
	QZrraQwosjcNSbvWyEuKSCQ+fsa48xC/QiSGMiq4arMQZ5/dbMi5GY9376UCgjk=
X-Google-Smtp-Source: AGHT+IEPeMI0z43MjvlBXsAsUdkQGTsWnPaqF+QUoQ1JhMqwDtA7d+BW/HuEGoVFyjEvifPOaGIfHg==
X-Received: by 2002:a17:903:181:b0:1e0:e85c:72dc with SMTP id z1-20020a170903018100b001e0e85c72dcmr2464037plg.19.1712131548509;
        Wed, 03 Apr 2024 01:05:48 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:46 -0700 (PDT)
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
Subject: [PATCH v5 17/22] KVM: riscv: selftests: Add helper functions for extension checks
Date: Wed,  3 Apr 2024 01:04:46 -0700
Message-Id: <20240403080452.1007601-18-atishp@rivosinc.com>
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

__vcpu_has_ext can check both SBI and ISA extensions when the first
argument is properly converted to SBI/ISA extension IDs. Introduce
two helper functions to make life easier for developers so they
don't have to worry about the conversions.

Replace the current usages as well with new helpers.

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
index e22848f747c0..6a3e97ead824 100644
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

