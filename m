Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDC0839F8
	for <virtualization@lists.linux.dev>; Wed,  3 Apr 2024 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131537; cv=none; b=miZFkhmeQVEcxjxzGVe6ijRVt18JkPt8HqoVlxkJgx2z91U1lL4Oy+zoFoUoEEKRaXhHT5XJ9wdnDGk03PaVoncr96cP9JiKg+y2kY2KEkNIbTKJ4ma6ClKgTMBcL4T6f6mXmWMrZCP8PT+75WKEcsB8BXUpdqHZkxpQq7QFC/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131537; c=relaxed/simple;
	bh=HvWaHaPle0cX5HGWWdRxWlP3z/kNux1E5mFj4+zTNsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nQcFQ4cVlL7Y6J7df7rrOivyFahc42xQTJfifbp5TFAttvj9cQKXtFz5E0/+uQjyzjKwYb/iOgfvagt6Zr8bnoX9+ewXzvh5MeOUZTo0TEVsezQxKV7Uh+xA7K6JiHZ1nQoJe08WKT73j9TBUK+nVeL7iu9Q09ecuf16K26Q1rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=r6SCqwrN; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="r6SCqwrN"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e0d8403257so47314415ad.1
        for <virtualization@lists.linux.dev>; Wed, 03 Apr 2024 01:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131535; x=1712736335; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIyaUvQe1Xat3Gv2wtXts1DoFv5C5UbopqhCGzslRuw=;
        b=r6SCqwrNQaU+VbfXYWcna6bU9y/WoD0hPbrmq+htTRz2aU0rWfXGL8oeECJOqESzjH
         k0nQNPbXKyyxqky9//UPiUwhstbJ+hlJHYKc0ZErVM7qvND/vgYMUIg5QZ+d5O78dEFQ
         HgamqS2SInHMNsPbpB3zf0rmQgnbQ2pFoE9qkuIreXEep/MMCZikqscn4XWt8lr4ddkA
         Jj3MWmyXzD46vP6eJH4a7+MRsKxJoNroTS8geSOB5/nB4a8wP29davaZoQWL69y5IT2Z
         7qS5JpLZid6Rk4TCogKqCf/ue7i82Fyl2tw2yQqC2Bk5vlxWnwdiBAasXHGsYBnnVBeg
         2RWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131535; x=1712736335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIyaUvQe1Xat3Gv2wtXts1DoFv5C5UbopqhCGzslRuw=;
        b=DGazM/f0z85T72g//xLv446kDjf/BySOad3f7QXjFgQ3C7RznfKr0JlzMOxFT6iOpg
         nDW+TosZp1E+7SnPkFWzcQMHpGmVoyOTNeqH6nffIqYvVKvgUsKtb4nZjR6IiFAhprm5
         c/nykQcnf3SdBoeBKzCia3E/8JgvSW0beCarreKl2Cn6p74GHY6vE37wJBV3CilTqGIc
         S6/A2b3g1uLmZEr6q4hS0MpzzT6V2I7qC+cdeCEq2xpgrC2yYwmRoJ9v0zXCyRSYKd4D
         Vdut/u8fD6S8U2uGwd6reExTC3rnVXDH3HOXiYXmKjC+RPVrCsgidbXnUQEro0WOxVke
         WGAg==
X-Forwarded-Encrypted: i=1; AJvYcCXp/fdlR6CWFZ8IuhhtUessyru6rIclVm3ykfM2JZsdDmsHWls3Y55d6yAItGZlLXSs0kDLQ87Br5e9cXGgWsP8zkVly+1yy6fKx5J6WBo=
X-Gm-Message-State: AOJu0Yw7uOXQsWX4FNGuzW6jlriI6FxtmeEDu8iVjw1bIT4WvHeuTmYR
	ryX9L/j1DRQoT/6xV/Xjikuejj21Ym2GX3iAbnHIF+31mvMM/DcVlMLDE8tqQak=
X-Google-Smtp-Source: AGHT+IEWaMwJlilOpjjtAd3ogSZtQYb7+W8r4UBVM9U3DF3iIMbLdC4POqTiOnAm6aIo/b0Y3UPrBw==
X-Received: by 2002:a17:902:7881:b0:1e0:cd01:9fd with SMTP id q1-20020a170902788100b001e0cd0109fdmr11915195pll.26.1712131535324;
        Wed, 03 Apr 2024 01:05:35 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:34 -0700 (PDT)
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
Subject: [PATCH v5 11/22] RISC-V: KVM: No need to exit to the user space if perf event failed
Date: Wed,  3 Apr 2024 01:04:40 -0700
Message-Id: <20240403080452.1007601-12-atishp@rivosinc.com>
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

Currently, we return a linux error code if creating a perf event failed
in kvm. That shouldn't be necessary as guest can continue to operate
without perf profiling or profiling with firmware counters.

Return appropriate SBI error code to indicate that PMU configuration
failed. An error message in kvm already describes the reason for failure.

Fixes: 0cb74b65d2e5 ("RISC-V: KVM: Implement perf support without sampling")
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_pmu.c     | 14 +++++++++-----
 arch/riscv/kvm/vcpu_sbi_pmu.c |  6 +++---
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index b5159ce4592d..2d9929bbc2c8 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -229,8 +229,9 @@ static int kvm_pmu_validate_counter_mask(struct kvm_pmu *kvpmu, unsigned long ct
 	return 0;
 }
 
-static int kvm_pmu_create_perf_event(struct kvm_pmc *pmc, struct perf_event_attr *attr,
-				     unsigned long flags, unsigned long eidx, unsigned long evtdata)
+static long kvm_pmu_create_perf_event(struct kvm_pmc *pmc, struct perf_event_attr *attr,
+				      unsigned long flags, unsigned long eidx,
+				      unsigned long evtdata)
 {
 	struct perf_event *event;
 
@@ -454,7 +455,8 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
 				     unsigned long eidx, u64 evtdata,
 				     struct kvm_vcpu_sbi_return *retdata)
 {
-	int ctr_idx, ret, sbiret = 0;
+	int ctr_idx, sbiret = 0;
+	long ret;
 	bool is_fevent;
 	unsigned long event_code;
 	u32 etype = kvm_pmu_get_perf_event_type(eidx);
@@ -513,8 +515,10 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
 			kvpmu->fw_event[event_code].started = true;
 	} else {
 		ret = kvm_pmu_create_perf_event(pmc, &attr, flags, eidx, evtdata);
-		if (ret)
-			return ret;
+		if (ret) {
+			sbiret = SBI_ERR_NOT_SUPPORTED;
+			goto out;
+		}
 	}
 
 	set_bit(ctr_idx, kvpmu->pmc_in_use);
diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.c
index 7eca72df2cbd..e1633606c98b 100644
--- a/arch/riscv/kvm/vcpu_sbi_pmu.c
+++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
@@ -42,9 +42,9 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 #endif
 		/*
 		 * This can fail if perf core framework fails to create an event.
-		 * Forward the error to userspace because it's an error which
-		 * happened within the host kernel. The other option would be
-		 * to convert to an SBI error and forward to the guest.
+		 * No need to forward the error to userspace and exit the guest.
+		 * The operation can continue without profiling. Forward the
+		 * appropriate SBI error to the guest.
 		 */
 		ret = kvm_riscv_vcpu_pmu_ctr_cfg_match(vcpu, cp->a0, cp->a1,
 						       cp->a2, cp->a3, temp, retdata);
-- 
2.34.1

