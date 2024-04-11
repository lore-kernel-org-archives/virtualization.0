Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5AB2BB14
	for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 00:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794123; cv=none; b=VR3apRzHWUqaUqOG1pWQVKUXxb3VoHaAhaEy1+sPaHDmFBqyMk48mIsjNhDKAbF2Ih384GNHpER/82A6XKsHHrSGk5IMzY0LPEv0mNhB3PMVtXyBdCuWgw+V3196sqktGd0HjIshWcGNTyRg6BpAQbpwBbsouHF/981wf6IKGnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794123; c=relaxed/simple;
	bh=HvWaHaPle0cX5HGWWdRxWlP3z/kNux1E5mFj4+zTNsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NyNyWmGLab+8Av9Jarvc6Rmj30q3jMoNnHUF5M/5ltesdphPvTnovC3iS9V+K2Vvrdeyf57/tb9BuXViSzR2WI09mmY0Y5ohE5yDInzudGC8a+ks/vilPJ1Bj9wJ59q6RFmrQhHhHNyhKLpH7vELV17thJPm2nK9GQgzRHuvEe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=r5bot5H1; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="r5bot5H1"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so3099999b3a.0
        for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 17:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794120; x=1713398920; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIyaUvQe1Xat3Gv2wtXts1DoFv5C5UbopqhCGzslRuw=;
        b=r5bot5H1o96PFCrSC0ffJGidNNSCtblS/NvqtiHQwxmCveKXLk4IlF9N4aafP07YdV
         2LIjsAxSrRwk0FJ/ro4ZWR1iO0/MFlVrCl5y4hhLHV7aTYREw9nzqUG6RxdIBbiecaf5
         8/CAKxYWmTj+J1oRL3iR7SCiv2NXejjdf8Wjt2JOd2OqxXkigyEGoAI+S5vnZnOoSVil
         GDnNg4tMxmnarWHSn31IbjrMXo/zvrnFGBGSPEn7hVN3U4Y1Jg1yiGaj5+3/t6Q8nL+f
         1XHF7cp0C37bKC0WmclXu+TvcDtghlgBF9Ast9UlsWboRwPE6A9NjG0dftq8R+BOA8nb
         kJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794120; x=1713398920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIyaUvQe1Xat3Gv2wtXts1DoFv5C5UbopqhCGzslRuw=;
        b=fIyHmVigYIRzSuzDC4GdHQ3kxICfHKDkDSdsid2RkxAP6YIWBsrBdJDUwadHxTGl1B
         Mciwe10RRlFCUxorw8L6sPiKAe0IZ64dw4tut9Cmw+cYYHam3gSdc3qJpkjuUYxyHzjX
         WQ5JMm+ORX6KRaODyNSeYpKnpsKaTCQ4cbdaE/yhQUud+NaU5un+zBrzzTM9hb36h2a7
         9BYXHbFxjMlG76atqTGWNBZc+9mQ1NtRosu1JqHIkRQSIwibLx3LiyGqlnCM5SF4YaO7
         nbAm//ScSZgL8+rEiU1PhtWXJojXneCq4ZUICns8ALbT/rJrQEpqnjYmgrUwgh/8J+gt
         2JwA==
X-Forwarded-Encrypted: i=1; AJvYcCXAEFtmy2AVm4/Ass2kFM/Kb1FX85OZjULov4cY/Y1DMhELyuSyNGy1HQToQfgIDB/8o6NRogeTXff2oscSFRTZ3xvnrYhPhmz9oYMyIi0=
X-Gm-Message-State: AOJu0Yw7mewfNYtVHF+bGcnbV2HwwTF1SJJkRXzNDequcclIaVX1tDkY
	ALS2plU08K9XIm28hMqimBrYSY0tXk8C8QmkLD3CkIz5nPmjU1CsLfCGj1Vchow=
X-Google-Smtp-Source: AGHT+IF/iUH6j4wqYw+9KON4EcdThSC+Ra1ZyGUZbtrB63cmqdWgioWmkvLwZPQEH37uBSDgq6VsEQ==
X-Received: by 2002:a05:6a20:96cc:b0:1a9:8152:511c with SMTP id hq12-20020a056a2096cc00b001a98152511cmr231480pzc.62.1712794119434;
        Wed, 10 Apr 2024 17:08:39 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:08:37 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@atishpatra.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
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
Subject: [PATCH v6 12/24] RISC-V: KVM: No need to exit to the user space if perf event failed
Date: Wed, 10 Apr 2024 17:07:40 -0700
Message-Id: <20240411000752.955910-13-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411000752.955910-1-atishp@rivosinc.com>
References: <20240411000752.955910-1-atishp@rivosinc.com>
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

