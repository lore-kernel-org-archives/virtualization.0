Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97DF481B7
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LGvNFv1y"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FC5D8190B
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5FC5D8190B
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=LGvNFv1y
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZrafFBFUTZez
	for <virtualization@lists.linux-foundation.org>;
	Sun, 17 Dec 2023 20:40:55 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8594481871
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8594481871
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a235eb41251so4357866b.3
        for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 12:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702845653; x=1703450453; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7vwoe3CX/elDbSVVxBrCH+gKLsjFQobx8w+cxadJhQ=;
        b=LGvNFv1y0HjbKaBvBfzm7BTHHwJeHjWQrmUA7uiB03Xb/xJRT3tXYaZ+JQw45TWe00
         bygbQFW6zXXH0H5MxetTV0+Z+nz04aUwVgnGdNuxrjXfAnNEWSgpS61eI7BZouwmJjsf
         udNUxutYyOHl2XEvfnd83hhtSDxzH3FaztUQ5LVbqNGti/oBZoMxxXNuwNsTK6XL0aC6
         TIhExabzZS5ItcGH61lbheDTUOsJMZSs8Jv7VPavRzCHJdIypYuNTP3i8WXOzFFgFs6P
         jpJwIxdjr4u10d1NdULPZny3NowChZ3y8Q+FYsxnEOJSFlcEkOBPTYvJAOSXY1HNaaaE
         8AUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702845653; x=1703450453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7vwoe3CX/elDbSVVxBrCH+gKLsjFQobx8w+cxadJhQ=;
        b=eY1jQE+kQCamTPjZWFE9gdDfLFq39Wfi05eiYTLL9mXppGq1t25st40sSwD04d+Dmv
         var7BUwOTnZokxPOU1ZGWENgvc6hpGsuym8FtpF9GEP9G8mjBkCEA1ZZ6bwQKBLepXRB
         nTcsN5aXsE7LTJZwoO4hXwsuNuFgqWlmdqw1LTzPJ23GHTHpMOmuECajHmMpbWigMCPz
         mu8sHgWS2HX3b/n5oS3iPZbFNSBHiUXGfdwz+g3dbGmumx2Ma3WZs2EbU8ZzdPIKf3b6
         wsoNlcoxpHEda8MO/N1dYxQ2+Z8tiu09oXRIVcyXVO8gzWmnmT1KV4Lt8kmlWKyGVGjy
         5Jxg==
X-Gm-Message-State: AOJu0YxjqrCA4WQvPInDn+TCF6BAKYVuYBMnzGe/pCCuvcSjxMHt7yla
	Sz9W/DIM/r1tMEmgX5WOWFosaxhbvHsY3FFnURM=
X-Google-Smtp-Source: AGHT+IHm0ZOnGz+LVNIDHqOQJjqLNvNLueuDiQKDMBt1714V/QR1XUkwgUSLwCRwL7GcimCNaPKWfA==
X-Received: by 2002:a17:907:7e8c:b0:a10:f087:ba43 with SMTP id qb12-20020a1709077e8c00b00a10f087ba43mr5497857ejc.43.1702845653800;
        Sun, 17 Dec 2023 12:40:53 -0800 (PST)
Received: from localhost (cst-prg-88-42.cust.vodafone.cz. [46.135.88.42])
        by smtp.gmail.com with ESMTPSA id ld4-20020a1709079c0400b00a1df88cc7c0sm13219257ejc.182.2023.12.17.12.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 12:40:53 -0800 (PST)
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
Subject: [PATCH v3 11/13] RISC-V: KVM: selftests: Add guest_sbi_probe_extension
Date: Sun, 17 Dec 2023 21:40:31 +0100
Message-ID: <20231217204019.36492-26-ajones@ventanamicro.com>
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

Add guest_sbi_probe_extension(), allowing guest code to probe for
SBI extensions. As guest_sbi_probe_extension() needs
SBI_ERR_NOT_SUPPORTED, take the opportunity to bring in all SBI
error codes. We don't bring in all current extension IDs or base
extension function IDs though, even though we need one of each,
because we'd prefer to bring those in as necessary.

Reviewed-by: Anup Patel <anup@brainfault.org>
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

