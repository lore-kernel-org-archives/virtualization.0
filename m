Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D213C067
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LsGcRkOY"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B44D7436E8
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:16:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B44D7436E8
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=LsGcRkOY
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ky6Oh_VyNuuD
	for <virtualization@lists.linux-foundation.org>;
	Thu, 14 Dec 2023 10:16:11 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7EBEE436DF
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:16:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7EBEE436DF
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c55872d80so2330785e9.1
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 02:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702548969; x=1703153769; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpfMMaVnqzUKTZ+jKcmqIbb/qIkXcAgoT0iTzjOxQ48=;
        b=LsGcRkOYhIBoFCqm8YxdKojJUWgWZdkyXznU7vsFw5bpCBu2T5Wyk8KiztMi5OR1kM
         39Li23WgtcBsnWzS/LGJ3tOe2dpPPY3R2pZlIOenzIFeqcIbEtZ4W55lZkWdnbwk9pV5
         FDCaxsSMySxbdjLol5toXW4c5J9ZYLhj/mC2/3Q/YvhPPNNTPtCDa5Yqd4nWFL3WuYvW
         JoXJ2wcjA0fd59tMQSqrM9IYmLqNn6tzsa/1+EFI25olOZLR2QDM6BbKCKQsB6pYKStL
         Iu7rvBr+hr9WbBgCY9zu6GQRLhfAqQYmLO7srBIocln8MbA4nhDstQQzXU2oLP7W8dw0
         HnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702548969; x=1703153769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpfMMaVnqzUKTZ+jKcmqIbb/qIkXcAgoT0iTzjOxQ48=;
        b=Wb6qDVwAHoY0q6uxDBKPbqxaZNobQChLLamT1HWkxCi0KJ9Qabt3GiP1xhYczjC7lT
         rYhTjjN2EBuoHFu54MveMVyh9aBm7qMJqJTe2R4kzSxGdRYrWSn0zNsNS4iY34IAqDQB
         nSxu/HTFbT8K2NO6/LKu6uUioZHs0S9jj1LApGSOU90c+v2+LkCjTGDlMLMgg1ZaOqmn
         Su1NYB8WNTccfEd6z+l8hHHlZhiH9uKNxEMWj6Sk0GHpNRgXwCQoM+5JI9CzNFvEhCX3
         575s4SfF+gJ6jZJ96U+qgn6jsRjT8z9hcfMeeRI6JApsmFITGFzj8YHvGXJY17DayMH9
         gtPw==
X-Gm-Message-State: AOJu0YzritYwTj4yiV8RF2l3VQMpCQ/qrPHRG+JyPxMsSg03UFtkLxxz
	Z5wAya2hBig/i7HlZWIENN8QIQ==
X-Google-Smtp-Source: AGHT+IH8xl+ijX8dy/fYqdeXj3sDdM1Fx/56Gx0qIx0bsNCFGogCneF0tpSFuyBW40lufrw2yTA12w==
X-Received: by 2002:a05:600c:4511:b0:40c:2d0c:a3ca with SMTP id t17-20020a05600c451100b0040c2d0ca3camr4996515wmo.89.1702548969712;
        Thu, 14 Dec 2023 02:16:09 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c470900b0040c4acaa4bfsm13075586wmo.19.2023.12.14.02.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:16:09 -0800 (PST)
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
Subject: [PATCH v2 11/13] RISC-V: KVM: selftests: Add guest_sbi_probe_extension
Date: Thu, 14 Dec 2023 11:16:03 +0100
Message-ID: <20231214101552.100721-26-ajones@ventanamicro.com>
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

