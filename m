Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB3668B82
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="h3aLHDaX"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F10560E64
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F10560E64
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=h3aLHDaX
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EcZ0cKov1Lco
	for <virtualization@lists.linux-foundation.org>;
	Tue,  5 Dec 2023 18:11:38 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2F6C560E55
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F6C560E55
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2ca0f21e48cso23465281fa.2
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Dec 2023 10:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701799896; x=1702404696; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHgnsxYfxbVMyX3m0HtccyvAeuvvFGofY8I7vS+QRNk=;
        b=h3aLHDaXR6zmcXBVZjvxFwBnAJ15YpWR1UnFwf0DJ9ykOgtELHodHwrmDDPTJ2xAFj
         FWcG7B1l5F/lG5MnCUxav+Dyrk8Jau/6HReyLC+TLweTbhKVfYd58YwBWWUWRVqL0Cv+
         eOcqiYvDxmaXiavlMqX7rCFiWY5CdTNydCgeIjcDmcGXDoKAYsuZKC+rB8oXwL5wUExP
         9cLEj/PBL6vfa3CDbK1SgHjsqi3rBNppK8EB15gXUsiVMbQr31RfuzT1gWkox1upIG5N
         4Z6VySxz9f/QuFDXSpGAG8aik/86gae2KHf8o1UOYXa6CNr3hzD1eZB0fdgwXP5w5/6l
         afCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701799896; x=1702404696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHgnsxYfxbVMyX3m0HtccyvAeuvvFGofY8I7vS+QRNk=;
        b=ry+GL5oN+LmlpTr4yr26inaVkpoipcpGEixEs0NDLWxG6JPTJaygWi5/Iz5RS40nd7
         5GbFlJQ0EeV98dLy8tfCtrH39KDTXrAGnGfzNYKSMyh57Wx/1iUpA3cRqLingJ+2Uv6U
         XtEKHVERAqtl4GeAKZ26p8+gSKSTYeitLvLcQm4WxFL5iM1lg8v6cHbI6qfFXZYQKYZo
         1nM4LsDXrEmuuwzkMIbc3HSKFB9yvLr6lnu0dodRGszqFDrteZrQ7W05LO9fFNdJPPhn
         HSoWx3ih6Gx2walSEjsrZK4sHpklHni6WE0fIV8Ddif4QdTooUzVzUyBNwpPIun2GEP9
         kz1Q==
X-Gm-Message-State: AOJu0YxYnRD2GWNJ+aoWDbBoqd7OcsCa5oeoK89nkf5EpdpqZQEk+uMY
	t0ZY2aws+JV2TbsROf5nie/4k3cp+HtVRCEtPB0=
X-Google-Smtp-Source: AGHT+IG97AuL+LChjgF63QnqtOy4VATXl7JSYLwN+S1ivGoshvCJ7pJfDLFDe3G+/9M89/kMqHoxhA==
X-Received: by 2002:a2e:9156:0:b0:2c9:fee0:5743 with SMTP id q22-20020a2e9156000000b002c9fee05743mr2721950ljg.99.1701799896195;
        Tue, 05 Dec 2023 10:11:36 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id d22-20020a056402079600b0054b286fa48bsm1384933edy.91.2023.12.05.10.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:11:35 -0800 (PST)
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
Subject: [PATCH v1 11/14] RISC-V: KVM: selftests: Move sbi_ecall to processor.c
Date: Tue,  5 Dec 2023 19:11:31 +0100
Message-ID: <20231205181119.207204-27-ajones@ventanamicro.com>
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

sbi_ecall() isn't ucall specific and its prototype is already in
processor.h. Move its implementation to processor.c.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 .../selftests/kvm/lib/riscv/processor.c       | 26 +++++++++++++++++++
 tools/testing/selftests/kvm/lib/riscv/ucall.c | 26 -------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index 6c25f7843ef4..6905a4348380 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -367,3 +367,29 @@ void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
 void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 {
 }
+
+struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
+			unsigned long arg1, unsigned long arg2,
+			unsigned long arg3, unsigned long arg4,
+			unsigned long arg5)
+{
+	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
+	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
+	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
+	register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
+	register uintptr_t a4 asm ("a4") = (uintptr_t)(arg4);
+	register uintptr_t a5 asm ("a5") = (uintptr_t)(arg5);
+	register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
+	register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
+	struct sbiret ret;
+
+	asm volatile (
+		"ecall"
+		: "+r" (a0), "+r" (a1)
+		: "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (a7)
+		: "memory");
+	ret.error = a0;
+	ret.value = a1;
+
+	return ret;
+}
diff --git a/tools/testing/selftests/kvm/lib/riscv/ucall.c b/tools/testing/selftests/kvm/lib/riscv/ucall.c
index fe6d1004f018..14ee17151a59 100644
--- a/tools/testing/selftests/kvm/lib/riscv/ucall.c
+++ b/tools/testing/selftests/kvm/lib/riscv/ucall.c
@@ -10,32 +10,6 @@
 #include "kvm_util.h"
 #include "processor.h"
 
-struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
-			unsigned long arg1, unsigned long arg2,
-			unsigned long arg3, unsigned long arg4,
-			unsigned long arg5)
-{
-	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
-	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
-	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
-	register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
-	register uintptr_t a4 asm ("a4") = (uintptr_t)(arg4);
-	register uintptr_t a5 asm ("a5") = (uintptr_t)(arg5);
-	register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
-	register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
-	struct sbiret ret;
-
-	asm volatile (
-		"ecall"
-		: "+r" (a0), "+r" (a1)
-		: "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (a7)
-		: "memory");
-	ret.error = a0;
-	ret.value = a1;
-
-	return ret;
-}
-
 void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-- 
2.43.0

