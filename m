Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B24481C4
	for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 00:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794154; cv=none; b=fMbW0P1X2UIHItTW/3zvG7w+46OF3rGjD+gHgIY6fHzj5CXXiFmQEZT4zGl0WK5fJkxTBlyFyHAOuJOKpmg59bHqHGlgcXKgs7of3t8p2xvyLkK2KGUEy7Jzu7osOXmAPHyNzYSXXk8tl7z8ZPrisibF/lOFwHg9CCiAATOg/cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794154; c=relaxed/simple;
	bh=FfM/sSt5pOIT+SFPpfrQ5W4Ri7Uq0XA+YsWN/Asw1ro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UvWBADwVb0DDRnse9OCgOqQ2Pu6UTP/n9fZjQeYq4G08SH74VBYTtuCrRFg86tArOiBgCn51VDovZRLYs2f9j1M3jyitqRg+h6/wfDrpp+TlBKc+X+H0ZjGe/jshiXXNd7DUazfAu+YFtud0qjQbq7ujc67rndYLfyg3qVFIHNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XU606aXY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XU606aXY"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e4266673bbso34130495ad.2
        for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 17:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794152; x=1713398952; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLia834y+X9tlrjVFjCEV4aQslhHW6gNjSHeO9Lbrys=;
        b=XU606aXYCjapULwIB7L7WI/6pKYidPDz4yg/ci7+fCkoBy0ConX4bKDU+AGkCdT8h2
         /hZHsYqJ0Uyy09LEfiY4pRvjy38gHQbi3uKt/cEhDRB6siNdXEUuA/JSdD4OpO/Q2inV
         tWhJ/DusCbHA/3Ry3ir/ZmSZSycrcOL9zuFI3yG9CfZMu8PIvP2nY2kHNEa2ydR60TE1
         4J+9MhOG4Nju1PcgMjRlESkBz/6yEAnc44PkLS3nInIaA2JZs9KQqM3G3jK375/hIxAK
         8aZ30D6ZSpBPu7OZif0u5uUvmWViJ3MflDor09N1tgh7L3+Ay7d+/nIf+lX6KVEBK+b0
         vXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794152; x=1713398952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLia834y+X9tlrjVFjCEV4aQslhHW6gNjSHeO9Lbrys=;
        b=xQ8M/pzTfyPE6Eg0m/hJUF0KLdJOxblrjDvcU5nn3Pzsg+PNe4laHc1ov+pObhebat
         vF4FZKju/j2uWmYWOGmLotpHZITGiQuDKK9Aq6uH8ShSFqMwK+QX0f5bPtvx1uReZ3Pm
         AW64rIK9Z9Lc6py9REu1Ll2cTPjR0mhIVZoVd/+MxcSCs5liBmsF73Ei48+rbsAm9AD/
         4IUdsuCr9aqBxrrDSzA8gvywj1vrOdu81W/3Dj2n4fW623gdwbQZJKYQE2fVJR8HP4gS
         HRYnTfVe6bIhEgCnDxPCyjr2zZ+z21Dp8CrMcV1jYlg8AuC0MRkhkBDFPjOtXK6UtY22
         h/3w==
X-Forwarded-Encrypted: i=1; AJvYcCV3Lbtw0nH6FZ7fWWd0NM5P4/HQ1JYdP3JSOjGBFQmIMZvgtdVBU3OoFumzuVUsnoTjN8SP53UKgUJLaqS4Bvil4kTiYp5HX+AbTQtR3wQ=
X-Gm-Message-State: AOJu0YwFUxTggdknEYzEjXyMuOG7RWpcsJQr3zo946hVuLk4o3vtRbLr
	/TYmHIfptxi0KU8LXXhrVLmIzKgAXr2XBMZV4qNj0qSwu+RDxvjjwF4mCmXEMMw=
X-Google-Smtp-Source: AGHT+IEBm3O3QxbfldIjrwscHpX7a8J2zp8FjCH5WuQpHu2gdn7/EG4AoSaaS2YDQBteQAhuqRWwog==
X-Received: by 2002:a17:902:eb88:b0:1e5:5559:c4a7 with SMTP id q8-20020a170902eb8800b001e55559c4a7mr85239plg.51.1712794152327;
        Wed, 10 Apr 2024 17:09:12 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:09:11 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Anup Patel <anup@brainfault.org>,
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
Subject: [PATCH v6 24/24] KVM: riscv: selftests: Add commandline option for SBI PMU test
Date: Wed, 10 Apr 2024 17:07:52 -0700
Message-Id: <20240411000752.955910-25-atishp@rivosinc.com>
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

SBI PMU test comprises of multiple tests and user may want to run
only a subset depending on the platform. The most common case would
be to run all to validate all the tests. However, some platform may
not support all events or all ISA extensions.

The commandline option allows user to disable particular test if they
want to.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 .../selftests/kvm/riscv/sbi_pmu_test.c        | 77 ++++++++++++++++---
 1 file changed, 68 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
index 0fd9b76ae838..57025b07a403 100644
--- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
+++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
@@ -33,6 +33,16 @@ static unsigned long counter_mask_available;
 
 static bool illegal_handler_invoked;
 
+enum sbi_pmu_test_id {
+	SBI_PMU_TEST_BASIC = 0,
+	SBI_PMU_TEST_EVENTS,
+	SBI_PMU_TEST_SNAPSHOT,
+	SBI_PMU_TEST_OVERFLOW,
+	SBI_PMU_TEST_MAX,
+};
+
+static int disabled_test_id = SBI_PMU_TEST_MAX;
+
 unsigned long pmu_csr_read_num(int csr_num)
 {
 #define switchcase_csr_read(__csr_num, __val)		{\
@@ -608,19 +618,68 @@ static void test_vm_events_overflow(void *guest_code)
 	test_vm_destroy(vm);
 }
 
-int main(void)
+static void test_print_help(char *name)
 {
-	test_vm_basic_test(test_pmu_basic_sanity);
-	pr_info("SBI PMU basic test : PASS\n");
+	pr_info("Usage: %s [-h] [-d <test name>]\n", name);
+	pr_info("\t-d: Test to disable. Available tests are 'basic', 'events', 'snapshot', 'overflow'\n");
+	pr_info("\t-h: print this help screen\n");
+}
 
-	test_vm_events_test(test_pmu_events);
-	pr_info("SBI PMU event verification test : PASS\n");
+static bool parse_args(int argc, char *argv[])
+{
+	int opt;
+
+	while ((opt = getopt(argc, argv, "hd:")) != -1) {
+		switch (opt) {
+		case 'd':
+			if (!strncmp("basic", optarg, 5))
+				disabled_test_id = SBI_PMU_TEST_BASIC;
+			else if (!strncmp("events", optarg, 6))
+				disabled_test_id = SBI_PMU_TEST_EVENTS;
+			else if (!strncmp("snapshot", optarg, 8))
+				disabled_test_id = SBI_PMU_TEST_SNAPSHOT;
+			else if (!strncmp("overflow", optarg, 8))
+				disabled_test_id = SBI_PMU_TEST_OVERFLOW;
+			else
+				goto done;
+			break;
+		break;
+		case 'h':
+		default:
+			goto done;
+		}
+	}
 
-	test_vm_events_snapshot_test(test_pmu_events_snaphost);
-	pr_info("SBI PMU event verification with snapshot test : PASS\n");
+	return true;
+done:
+	test_print_help(argv[0]);
+	return false;
+}
 
-	test_vm_events_overflow(test_pmu_events_overflow);
-	pr_info("SBI PMU event verification with overflow test : PASS\n");
+int main(int argc, char *argv[])
+{
+	if (!parse_args(argc, argv))
+		exit(KSFT_SKIP);
+
+	if (disabled_test_id != SBI_PMU_TEST_BASIC) {
+		test_vm_basic_test(test_pmu_basic_sanity);
+		pr_info("SBI PMU basic test : PASS\n");
+	}
+
+	if (disabled_test_id != SBI_PMU_TEST_EVENTS) {
+		test_vm_events_test(test_pmu_events);
+		pr_info("SBI PMU event verification test : PASS\n");
+	}
+
+	if (disabled_test_id != SBI_PMU_TEST_SNAPSHOT) {
+		test_vm_events_snapshot_test(test_pmu_events_snaphost);
+		pr_info("SBI PMU event verification with snapshot test : PASS\n");
+	}
+
+	if (disabled_test_id != SBI_PMU_TEST_OVERFLOW) {
+		test_vm_events_overflow(test_pmu_events_overflow);
+		pr_info("SBI PMU event verification with overflow test : PASS\n");
+	}
 
 	return 0;
 }
-- 
2.34.1

