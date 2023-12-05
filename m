Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B862468B8B
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HzXIDPIF"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 503AE8148B
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 503AE8148B
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=HzXIDPIF
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LLe6WbYnQxTw
	for <virtualization@lists.linux-foundation.org>;
	Tue,  5 Dec 2023 18:11:39 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5DBD38144C
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5DBD38144C
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54c67b0da54so5734149a12.0
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Dec 2023 10:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701799897; x=1702404697; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpfMMaVnqzUKTZ+jKcmqIbb/qIkXcAgoT0iTzjOxQ48=;
        b=HzXIDPIFW8qkFl9px0ZegoiqmohJ59+/DlucmZ+wfLkm+J2lYMedYsy70jJn9Sp5h0
         QGU09d0WltXx8VN0qoh+K2Oz9+SMWGw8Lq+UtywDwB3P4w1JPdEyeABq8f2DfX7q+fq0
         O9jXA7M77EEt1patFO5evQbYfius1em+y4jc5kVTY7BUVkLqwR2aLzS0SnTnXm8nCGAW
         bXDoLwKGY/sjCxaVmRVzc/MxdxA1R1tKIvyORwYz1T302PkE3PnjSPyAsxzCiUWtcmNe
         yC0zYRPzBNzn2rFnAOytGsK9NPvhDvAUwNHJ1pSW98rqDnNPZMSzvRACRSdfWJinWlSZ
         pqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701799897; x=1702404697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpfMMaVnqzUKTZ+jKcmqIbb/qIkXcAgoT0iTzjOxQ48=;
        b=FP1JiF4A9Vmcpr7s9RWjrVsKB1ZBEczH4EaiG+Of11tzbULeN8bpzo7wToImS6MwWX
         /+yjERULq6n74ae9nfee75jgRzIrJbsofYhgDYci8nyqji43olo8IcA8gS4vE8Gcf3ZF
         lUTRWXtSklHB6xWljNqGgnjGVUD69979txo7eJxhEWnnd2gWl4oNAJ+HEBFytHKi64YZ
         MK+9gX0TOzT+pdqOMYdXETsHGNmO2RW3DJPjw2PHWuTrAHXvcYjnrFsjNN/zAEUvX23g
         aPAtc4fLo0oYVsIHXS1lQyKKD91A1cxgx3IybiwvLRuKncBJbgcwZdxyybDvAMb86BMq
         qq0w==
X-Gm-Message-State: AOJu0YzDk7AUBJbGJZLenVIich2/UeEHi5Sw+BoqjIcf30YolnuBI6lR
	KZzaFI+cZ8ihlmZQuoAXx5Zwrg==
X-Google-Smtp-Source: AGHT+IG7j4tkgG9BdEAYgsWiHNE6RETMyX70kzIJ6SCnVEsMXr6DcaKxFt+JsiwBECSXjUhwyamLrg==
X-Received: by 2002:a17:907:7ea4:b0:a19:a19b:55f0 with SMTP id qb36-20020a1709077ea400b00a19a19b55f0mr871121ejc.128.1701799897601;
        Tue, 05 Dec 2023 10:11:37 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ef3-20020a17090697c300b00a1b75e0e061sm2840625ejb.130.2023.12.05.10.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:11:37 -0800 (PST)
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
Subject: [PATCH v1 12/14] RISC-V: KVM: selftests: Add guest_sbi_probe_extension
Date: Tue,  5 Dec 2023 19:11:32 +0100
Message-ID: <20231205181119.207204-28-ajones@ventanamicro.com>
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

Add guest_sbi_probe_extension(), allowing guest code to probe for
SBI extensions. As guest_sbi_probe_extension() needs
SBI_ERR_NOT_SUPPORTED, take the opportunity to bring in all SBI
error codes. We don't bring in all current extension IDs or base
extension function IDs though, even though we need one of each,
because we'd prefer to bring those in as necessary.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 .../selftests/kvm/include/riscv/processor.h   | 21 +++++++++++++++++++
 .../selftests/kvm/lib/riscv/processor.c       | 19 +++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index e70ccda2011b..dc50ad62e150 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -108,6 +108,17 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t subtype,
 #define SATP_ASID_SHIFT				44
 #define SATP_ASID_MASK				_AC(0xFFFF, UL)
 
+/* SBI return error codes */
+#define SBI_SUCCESS				0
+#define SBI_ERR_FAILURE				-1
+#define SBI_ERR_NOT_SUPPORTED			-2
+#define SBI_ERR_INVALID_PARAM			-3
+#define SBI_ERR_DENIED				-4
+#define SBI_ERR_INVALID_ADDRESS			-5
+#define SBI_ERR_ALREADY_AVAILABLE		-6
+#define SBI_ERR_ALREADY_STARTED			-7
+#define SBI_ERR_ALREADY_STOPPED			-8
+
 #define SBI_EXT_EXPERIMENTAL_START		0x08000000
 #define SBI_EXT_EXPERIMENTAL_END		0x08FFFFFF
 
@@ -115,6 +126,14 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t subtype,
 #define KVM_RISCV_SELFTESTS_SBI_UCALL		0
 #define KVM_RISCV_SELFTESTS_SBI_UNEXP		1
 
+enum sbi_ext_id {
+	SBI_EXT_BASE = 0x10,
+};
+
+enum sbi_ext_base_fid {
+	SBI_EXT_BASE_PROBE_EXT = 3,
+};
+
 struct sbiret {
 	long error;
 	long value;
@@ -125,4 +144,6 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg3, unsigned long arg4,
 			unsigned long arg5);
 
+bool guest_sbi_probe_extension(int extid, long *out_val);
+
 #endif /* SELFTEST_KVM_PROCESSOR_H */
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index 6905a4348380..7ca736fb4194 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -393,3 +393,22 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 
 	return ret;
 }
+
+bool guest_sbi_probe_extension(int extid, long *out_val)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_PROBE_EXT, extid,
+			0, 0, 0, 0, 0);
+
+	__GUEST_ASSERT(!ret.error || ret.error == SBI_ERR_NOT_SUPPORTED,
+		       "ret.error=%ld, ret.value=%ld\n", ret.error, ret.value);
+
+	if (ret.error == SBI_ERR_NOT_SUPPORTED)
+		return false;
+
+	if (out_val)
+		*out_val = ret.value;
+
+	return true;
+}
-- 
2.43.0

