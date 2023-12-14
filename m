Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639B93BB23
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="T6akodVe"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9CAE83BD5
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:16:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C9CAE83BD5
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=T6akodVe
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UUr8w1wGIokS
	for <virtualization@lists.linux-foundation.org>;
	Thu, 14 Dec 2023 10:16:03 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CEA14821DE
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:16:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CEA14821DE
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3332efd75c9so6807536f8f.2
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 02:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702548961; x=1703153761; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6/BA021ZzKWgeNWs12dBxi4zSF5L/byI6HgH2juHwc=;
        b=T6akodVe5ayjjeQ5Vx4w3eZ3+7Ug3pBnhKtg6zhmZL78C1EL/lBsB6ELT+VUEXM/hb
         u0AlHPk0ej1U0hWp9+zGl4DxuLmh5+PptPA3VjX9DtJ/FbSGb0VssSQmp4R0u/mMXXc4
         wJFl3c+NE5bl18TLD67Zc8CsWBiA9Vp5ZAw0QcpAVsGPF6sEfmdK6vQatKCruP41A2Vp
         fop8czs4mwjRLnZZAUaw+NpyOc211abNmVro9t/SY98GHcb/fj6AeVor2CTnMsD6MWNO
         y9ccxtMM1eIR17Zg5Y9Bil/7HREsftSAQl6a/7g87VtFlUKJsNX1EfIqstCe04hl5apw
         iG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702548961; x=1703153761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6/BA021ZzKWgeNWs12dBxi4zSF5L/byI6HgH2juHwc=;
        b=KLOq889h3RNvKLrNlMgC6yDt0CR8HvVaDbWCCFh8+MXOZPJbUIuHZG/msOJxc+Xwcg
         Zy2RqEz3TGquyE76/oPCgZZu/pM+cf8JJUNYo5u5J+UJykMooYxxwJSwwQUCq4fb+GMG
         sBS8CWQGGTGCFRCKdMkBdhc7kwGifUSO/jUt81pDGhLCUrIPWJX5T5OW/P7LWFx/AV6i
         v2j+UF/ee3lx8HQA+g52eEJtZxX6KluOO0QSvACYXZEqfn+sq11T4TAFqK2urTblW5si
         aMpE/kcSgs3aqsZg79wskUHuEE9Tn0qFicMfdMF9XJ82MTIefYC+e6s9qI+6bXt0d3ur
         sPJQ==
X-Gm-Message-State: AOJu0Yy7wCq8Cw2FSHE+75mGZL/jy3ROlcFooFe/6CJgW3GCuCBYoMeB
	582wZtfalxmo9BZrwTOMkgk82w==
X-Google-Smtp-Source: AGHT+IFWW1BaBAfCrJLpTyR2/xFci7LP24uJR6uiHUbj9Zh90p2KSPvpULG4OxbBAFLGSENZK5wJgg==
X-Received: by 2002:a5d:6712:0:b0:336:36b2:249a with SMTP id o18-20020a5d6712000000b0033636b2249amr772277wru.269.1702548961060;
        Thu, 14 Dec 2023 02:16:01 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4cc1000000b0033350f5f94dsm15550808wrt.101.2023.12.14.02.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:16:00 -0800 (PST)
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
	conor.dooley@microchip.com
Subject: [PATCH v2 05/13] RISC-V: KVM: Add steal-update vcpu request
Date: Thu, 14 Dec 2023 11:15:57 +0100
Message-ID: <20231214101552.100721-20-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214101552.100721-15-ajones@ventanamicro.com>
References: <20231214101552.100721-15-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

Add a new vcpu request to inform a vcpu that it should record its
steal-time information. The request is made each time it has been
detected that the vcpu task was not assigned a cpu for some time,
which is easy to do by making the request from vcpu-load. The record
function is just a stub for now and will be filled in with the rest
of the steal-time support functions in following patches.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_host.h | 3 +++
 arch/riscv/kvm/vcpu.c             | 5 +++++
 arch/riscv/kvm/vcpu_sbi_sta.c     | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 0eefd9c991ae..230b82c3118d 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -41,6 +41,7 @@
 	KVM_ARCH_REQ_FLAGS(4, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_HFENCE			\
 	KVM_ARCH_REQ_FLAGS(5, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
+#define KVM_REQ_STEAL_UPDATE		KVM_ARCH_REQ(6)
 
 enum kvm_riscv_hfence_type {
 	KVM_RISCV_HFENCE_UNKNOWN = 0,
@@ -372,4 +373,6 @@ bool kvm_riscv_vcpu_has_interrupts(struct kvm_vcpu *vcpu, u64 mask);
 void kvm_riscv_vcpu_power_off(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_power_on(struct kvm_vcpu *vcpu);
 
+void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu);
+
 #endif /* __RISCV_KVM_HOST_H__ */
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index bf3952d1a621..6995b8b641e4 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -541,6 +541,8 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	kvm_riscv_vcpu_aia_load(vcpu, cpu);
 
+	kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
+
 	vcpu->cpu = cpu;
 }
 
@@ -614,6 +616,9 @@ static void kvm_riscv_check_vcpu_requests(struct kvm_vcpu *vcpu)
 
 		if (kvm_check_request(KVM_REQ_HFENCE, vcpu))
 			kvm_riscv_hfence_process(vcpu);
+
+		if (kvm_check_request(KVM_REQ_STEAL_UPDATE, vcpu))
+			kvm_riscv_vcpu_record_steal_time(vcpu);
 	}
 }
 
diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
index 839911dcd837..e28351c9488b 100644
--- a/arch/riscv/kvm/vcpu_sbi_sta.c
+++ b/arch/riscv/kvm/vcpu_sbi_sta.c
@@ -8,6 +8,10 @@
 #include <asm/kvm_vcpu_sbi.h>
 #include <asm/sbi.h>
 
+void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
+{
+}
+
 static int kvm_sbi_sta_steal_time_set_shmem(struct kvm_vcpu *vcpu)
 {
 	return SBI_ERR_FAILURE;
-- 
2.43.0

