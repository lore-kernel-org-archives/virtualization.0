Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A2E14659D
	for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 23:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570488; cv=none; b=ZVdsdiGUj3XfnoIV5nkBsTzwZYr7vKkWWJvEY+RUzrDXKoxJRDH5tQKWdNBwQbZSFiUlxtdQqauvtnNYX9vqdrhpWqSAmc0vKz0pSXuNySAyxuzH12fWILi3lmJpMLER3Kr3FeKFbYp2/2RxvydazgooGvmD0H0F4IEh7O3wUiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570488; c=relaxed/simple;
	bh=HvWaHaPle0cX5HGWWdRxWlP3z/kNux1E5mFj4+zTNsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ITGNSSgj6zCsz+9mx2CLGRDH8EvHw0M006cLCPJpnsjRBL+s1yoLOwX/wlMuYpkCmPxzjjrMpextVBcfw+SBh47tmFgQ3wFay5Z7p8lKVdsmuBOCKb42Hzfpr2sPkioo4TfmC99zGcT5BSl59ZPxzTqO7X8KTvB+HySWT2SviHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Bzt/0A8Q; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Bzt/0A8Q"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so18678595ad.0
        for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 16:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570487; x=1714175287; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIyaUvQe1Xat3Gv2wtXts1DoFv5C5UbopqhCGzslRuw=;
        b=Bzt/0A8QbtSUvTlrYxAYbq7FwOlYy0pMJePq2PaooX4lZfkPdbHpsme3nJP4Ghtzkx
         5tz9agv/FQ5ox9CuWs8snFbl5rvK970VKmwdOVii2j3OMHOih6NIn6CbP623q1DkCaXp
         FrTyOiVkClxPQXJupMEIi12kmZmiHCnOjL6bs2hQphq+6N1uI1yk1tXb8PcyFZC0b2XN
         TBoZNwAOsAu+XMoOctIL6CJGMfD+qQzdYMghp+OwT0dHtBJAcxVI6RsUglC4Oq7LzjnZ
         PEOYa54z1uhMGqkmI0fHlKmAcjXT4ndSJQwMBYpD6juauTcO905F3QoVblYiGLgypLRv
         MTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570487; x=1714175287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIyaUvQe1Xat3Gv2wtXts1DoFv5C5UbopqhCGzslRuw=;
        b=fjTQiwz6hw6DWVkShUfwZSbUXiKRFHGlY9+hHpQhw1x7L7YitCh2fmcjnimTEriFnK
         0nzU0GdUNLQFSDsDqRhV8SxTHtk4WswAAXYFj2vUXOWo0I7AIbe4XfQ3aRHrm5iK0rTM
         OT8bfCs0YGUK0BVcdCMSVUAiRJNJl0gFRY6S0L3JCzDWAPY23Nytm0qFJPzeoP9ndfyI
         s6Tz84kY1tmV6d1mMRJVd68OBIgvNKQSDnPU/21/tpeC9aOuTHEkwbwj8srWEFH9gnTB
         ckGMYgfl15WKjcfELBkLn3Lb13Emp8ZjhpVrxtfYessuLjL+zU9VDJrwJI7Jb0qZQ8BK
         P1tA==
X-Forwarded-Encrypted: i=1; AJvYcCUp5/Zd0aYKwCUZ+lHrmPVIcDyIy5DWnt4FwiouP6Ymi/YpepEGXncTMKcEjT4h9CluO/8D+1GiNflIs9TzWcoUYAzpCrF125xtVGYTJ8g=
X-Gm-Message-State: AOJu0Yzc5JhOV4HbFglWTXbvxmPL7Yt9LBYmtzd4F2hULpAVJoM0WDp0
	mtUmQjlCpB/W63/PbvtjzirzseGktO+hCy0Tl10Ojrjn90L3+bWBRGyUlrBScXg=
X-Google-Smtp-Source: AGHT+IHqmOgwdzykdLgMc2WJ6EaM228nMawdh3bGDIhVF9FxVvuRHHcpcsw9cNr0lYOB2vXlkqEb3Q==
X-Received: by 2002:a17:902:d481:b0:1e7:d3e3:a927 with SMTP id c1-20020a170902d48100b001e7d3e3a927mr5602995plg.31.1713570486735;
        Fri, 19 Apr 2024 16:48:06 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:48:06 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
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
Subject: [PATCH v8 12/24] RISC-V: KVM: No need to exit to the user space if perf event failed
Date: Sat, 20 Apr 2024 08:17:28 -0700
Message-Id: <20240420151741.962500-13-atishp@rivosinc.com>
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

