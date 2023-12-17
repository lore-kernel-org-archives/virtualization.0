Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2589D48CC0
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dehwYF8K"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B2A381367
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9B2A381367
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=dehwYF8K
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1ScyqaCjxHNO
	for <virtualization@lists.linux-foundation.org>;
	Sun, 17 Dec 2023 20:40:40 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BB26C81319
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB26C81319
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54dcfca54e0so3154013a12.1
        for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 12:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702845638; x=1703450438; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSoHYNOgfqU5+c8x6IeudkotxUSJD6YLApsHwAAqgOM=;
        b=dehwYF8KiKqECb2YzrX+mw+1l/SRSN9iLtOGR9bwbgvL8AHYovymHCwoDyUO/TZ1jo
         hi+3/3aHtfKN60SbW2IfKelGYYlyZl+X5g0OYGDis4IWBXqE3HGmYLdUZjBj7+bQkQD2
         BU2wsEmnbfJgcYIidE92j7k2qyKJAg8c0fbRdCvP7C7JxOvTC/YSMFnlKJlZiYLyNYbg
         tF5A/KgaEwGWYh1KNpRQiOoqBPfUunJtjGYWWXjzHmAVfI/5GNjhg8b+CfZpCejPbVPt
         R9+zBacK+003o7+ShSncIALX4sqLqNeloP1DL6fV4089FrUwVq5PbP/v/oNQ3vXNnK4/
         IqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702845638; x=1703450438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSoHYNOgfqU5+c8x6IeudkotxUSJD6YLApsHwAAqgOM=;
        b=dcNUZxZd1LVVfAlt1PsMGDIl5an4QASHw29+exVQASq6lZhOcvBEvvzehF62M3WVr4
         50AxG88XE4KT3j6SBOyI793TN8VG0I/Af+Ty7C3dx3QHU1Nd+vjhQj1Aw/N9iP/1dfK3
         YqUcd4cX9kIpbBQ3UUnxfTr8v8jz7R1RnxUJ5auA1bGVTtVM0Nf95XOsqCoCsIE51fNt
         ta7QqStmrCI/CyRBiQm7u2aKbrrqpHQRZEzhYMKuNAivrbOOTWEIsDjZulw35cXGGQdC
         ykUBm3dsg076b2LTqcFup6H5Pi6jiN79W4mjLX9zqsbhsQiEcLlH2NKxuG6NhhXQwRlQ
         mjgQ==
X-Gm-Message-State: AOJu0YxkoZDfOAjtSxhDB9gbgPULkpedaDHrJo+MVw/x2nURUR+o97hY
	fpf4sL48Ae2dazfYpWHnaIfBEA==
X-Google-Smtp-Source: AGHT+IFE5RF/SHXnJzGGw3wICaxYmcL1l5BAUO47j5YWQTpa+0J6ApMFhpsBULpgQvfhkW22Oeq7dg==
X-Received: by 2002:a17:906:dfd0:b0:a19:a1ba:da41 with SMTP id jt16-20020a170906dfd000b00a19a1bada41mr8077173ejc.104.1702845637696;
        Sun, 17 Dec 2023 12:40:37 -0800 (PST)
Received: from localhost (cst-prg-88-42.cust.vodafone.cz. [46.135.88.42])
        by smtp.gmail.com with ESMTPSA id ld4-20020a1709079c0400b00a1df88cc7c0sm13219047ejc.182.2023.12.17.12.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 12:40:37 -0800 (PST)
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
Subject: [PATCH v3 05/13] RISC-V: KVM: Add steal-update vcpu request
Date: Sun, 17 Dec 2023 21:40:25 +0100
Message-ID: <20231217204019.36492-20-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217204019.36492-15-ajones@ventanamicro.com>
References: <20231217204019.36492-15-ajones@ventanamicro.com>
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

Reviewed-by: Anup Patel <anup@brainfault.org>
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

