Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAD468B68
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="j2EKimoy"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B64460E64
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1B64460E64
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=j2EKimoy
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kNoWYl1QoW59
	for <virtualization@lists.linux-foundation.org>;
	Tue,  5 Dec 2023 18:11:31 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3F88B60E55
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F88B60E55
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54cde11d0f4so3011261a12.2
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Dec 2023 10:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701799889; x=1702404689; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REnOHt+K++3Makx2KQUnuu8zkmaBNWfW7UtKBhZyEjc=;
        b=j2EKimoydgX4RpgWoc99Ko+a+ms03XZv5pw7nDLxXKtYxDaZuGMQG7UNo91FusnwiZ
         suMIpjEPHO2Fu2k1gQjtnwinFrik6HoZ3BuSJWCGJnSK2upoz48fnM28p/enmE/Ivn5D
         WiIZNLSxhK4yx96wICrP2m9l0RDsatbuAUgniJq00I3XGbgG72P549XjXPTzoCyvg26y
         ZBI6Myf2hx2nDIgjxRm2VcThYlQ89/5sEu6CcLJ0Cv75BHOyoQGwNuD419AfuURsLDHc
         L6yPYfI6W4Hidrxwwumc9K+yEQIaGKojXdIgSnmqFJTVJDd0RDyEkRYrgh2mm4GyhfxE
         O9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701799889; x=1702404689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REnOHt+K++3Makx2KQUnuu8zkmaBNWfW7UtKBhZyEjc=;
        b=vhoMBjK3hiq7aX3EGuFUVKO3hO1OQgkUL8S88S4OGF+ShZKxCn/1elt2oeij8cA83p
         1pI81Gd2fxwf+mfX8qqGH/Z0bzma0kFItB7gY4lNzsi7hcXreh4Ob7eJA8jDzZMePkoZ
         5w0pa7/UMHP203rSyvyEOL5g9Okk0WVGMgqxAontojTvb37nSpnAvyMJ6eht06GQaIQw
         M0WWXNJpM5NIbYcRXj0yxRKc9mckC7V8u8D4Fil0ak5VXzrwKo5xdj8EJCcelTe+KBd7
         QPDa62QrHtX/yh4mFX5cMKbCIpj3jlFN1X65tJrWw4aXfRClJgQx+cja7AWG6xxUg70x
         kRzQ==
X-Gm-Message-State: AOJu0YxDid1kR1u3Uz6RjNf/H5xVwsAQ9OZyITfhJUmSn1OLRrLMzIBt
	WyQ7cASmzERRqyG07d+Qfc/LJw==
X-Google-Smtp-Source: AGHT+IGquDSixYJu18mH30sSOmuHmw/0Pl8F0wzzIkhrPp1ptns8txZD4CRCno7vFbtWaryTynxQdg==
X-Received: by 2002:a17:906:3488:b0:a19:a1ba:da71 with SMTP id g8-20020a170906348800b00a19a1bada71mr4785159ejb.152.1701799889425;
        Tue, 05 Dec 2023 10:11:29 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id wn3-20020a170907068300b00a1b7b0cc30dsm2671743ejb.7.2023.12.05.10.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:11:29 -0800 (PST)
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
	guoren@kernel.org
Subject: [PATCH v1 06/14] RISC-V: KVM: Add steal-update vcpu request
Date: Tue,  5 Dec 2023 19:11:26 +0100
Message-ID: <20231205181119.207204-22-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205181119.207204-16-ajones@ventanamicro.com>
References: <20231205181119.207204-16-ajones@ventanamicro.com>
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
index e087c809073c..b77f585879b7 100644
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

