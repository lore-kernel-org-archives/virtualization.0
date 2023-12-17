Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843D3481C5
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YDmm3WQ9"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02ACD60A77
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 02ACD60A77
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=YDmm3WQ9
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3z9OawySD1l8
	for <virtualization@lists.linux-foundation.org>;
	Sun, 17 Dec 2023 20:40:53 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1474460881
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1474460881
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a235eb41251so4356066b.3
        for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 12:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702845651; x=1703450451; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOMbKPx9f+JcS4fNjPCKfauG48/CPKUV3NQDAwTQdeE=;
        b=YDmm3WQ95dPJVvejL2XbFLMMxYNYiof82TyZBANWqry7em6KJ8bu0+6dDgkaeIrSY7
         WpyX3zklmSUBxcWYTMrrpGUqoGexRTQHE1nb8dXQAwWIcngL+Bs8rwz7EIdCpqOX9Lbi
         JnuX0z7Xby4RO6DdBxu+/jyLe1ld1Gko5XppI013CJYRcNhBtDRwlHBLL3v2qXWDRBTy
         c0ciWmFYImN4uNIr0xKwPHKTnrfOjs7egUpvBljKoOSW7GJ4b9d8ZqPPPkVKgTep2cjb
         EE7xC11xXBIZvB8QNoRgtgR80exPWB14VfNpNivewdVXPXTC/Fgd7Lk209hPNVtewkTz
         ljzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702845651; x=1703450451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOMbKPx9f+JcS4fNjPCKfauG48/CPKUV3NQDAwTQdeE=;
        b=d2KlrzKv4H05SEG0dB0lWQR4EytrYIgMdSIESDIxc5nj3kAk2+nrKb0z+JMHVQCytk
         E4vnjSmULrPj8PLuiJMlMR6u80I5DekfpeKx/T91VVzHlKH+K1lz2ZAsn3gxR0k47PZZ
         5zwwTTg98RPU07xWuG55T4Q0h+mVfXOcFm9/Bmk7eUBqEg2GEdJAcgW/ym4C+FUTMw2K
         Jn4d+baq17CsMkD7ZnmYsV+kCvvCy25wUevFDNwUN4onqpPB9yCDf62+JqjUaopGB/8m
         Bdp1P40uv9+wMvJIq60/kUPwA8U67HPw1oqUVLlWc5uLgDl+IHUyxSNi6AR50KQcgiLJ
         c6WA==
X-Gm-Message-State: AOJu0YyaaEN6yPDgZGyfxhQ7EtjH6ZMRn6OARq0SxGVYB3tQCheu5g8A
	m/BAOIt4U5/XyirzkekwWkuj0Q==
X-Google-Smtp-Source: AGHT+IElKIALGSKv91isCCjAY+9MIW2ym0pewkkwdkfoL3kKEux4VitJsNehhoeuFDnBHYAQt77IKw==
X-Received: by 2002:a17:906:83:b0:a23:195c:8a59 with SMTP id 3-20020a170906008300b00a23195c8a59mr1296006ejc.34.1702845651321;
        Sun, 17 Dec 2023 12:40:51 -0800 (PST)
Received: from localhost (cst-prg-88-42.cust.vodafone.cz. [46.135.88.42])
        by smtp.gmail.com with ESMTPSA id oz39-20020a170906cd2700b00a235f3b8259sm38073ejb.186.2023.12.17.12.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 12:40:50 -0800 (PST)
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
Subject: [PATCH v3 10/13] RISC-V: KVM: selftests: Move sbi_ecall to processor.c
Date: Sun, 17 Dec 2023 21:40:30 +0100
Message-ID: <20231217204019.36492-25-ajones@ventanamicro.com>
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

sbi_ecall() isn't ucall specific and its prototype is already in
processor.h. Move its implementation to processor.c.

Reviewed-by: Anup Patel <anup@brainfault.org>
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

