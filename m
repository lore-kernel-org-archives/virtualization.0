Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513F9145FF5
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293117; cv=none; b=Is2ytbDXiZi3KdX2u1nl1MYvIKzdbmF8+1L7eQkpwcINGJD/C/hRzzUDTOuSn29skv70xkatwAt3QpCuuqQTfwHJtK/fGVhwYAoge5t9EUOXR4NiUFGeJOzNleytvG1Q+ccoZDdWCYzcioTjh1esbNsSQKan7i9cIk8FbBhAmGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293117; c=relaxed/simple;
	bh=4h0IzOtLBFbHmqIztYQtJnRQ5i+JxAIa21rlgcy6DFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MQVXEdoj1d1hEfEc7FAyLzLm/BAmSzQnxgE0Lo1jkszxAJG4CR6ETNnYhsnl7xWXJuUlCabgR8lij8qNAdsFvnmh3L3oAmcKlT8ifQ+RVbpOz86Z0JD9tUA7MPmvzDTaQA8/x2mv6+Q/zzaR7EFHJtUq0bW+rjcKL+BnoEZ7dnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=za+1S4+f; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="za+1S4+f"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a2d248a2e1so48782a91.0
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 11:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293116; x=1713897916; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8dppvgVnh54sEjPJluz+VPGn0XVIgbI5aDFYcuHKMk=;
        b=za+1S4+ftyEtZaXOID/VaLX9x6aEnCTRZivlnlZtp3Eol+QW67uFDzDyO51SJMeFN4
         4wLLu/81ozQ0nmC5JRSIlT1Rq7EKkURoB1JguyTdi5/kJtNqKuX6ZKdro1z+qG95k+/p
         7JgzD8ZHexMRjt4smFSmfSLU7nRvUHkZrzHegFk801Cko+7ha87gm5lThwnegF5iZ4hb
         bRLtjbQOd/KRefpeaJrj5uanb+X4j+MLsOKC99I02mAgt8suWFKoKENnIWLOslzfqFwY
         Mx6UZ0/p6XUXuuW5R52tDhaaGE1VwwY6H6JbeQsY2+TZ8gyBBM318kCrH0BLTUQtbr6s
         yu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293116; x=1713897916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8dppvgVnh54sEjPJluz+VPGn0XVIgbI5aDFYcuHKMk=;
        b=hjqB00xDiKm6k3AnrKlhv88Q7ekoxiD+i1ggy9hyJAqe3VFyI9fzKRhDmez6PANfpJ
         8KwpaJBChh3Pom+t6VdfhU9fJcnqhXgOtpPfR6tVk9LeJ9uz5x/hbxhZ03fe0ed9rhQ5
         g3H+VPmyt7i9AlHTTbB5Spfk52QVUIxaUwucq8v/4vcb+xjynM3NYjNtoP4Ud5UsQtVk
         I6gmXBx6B4R4YHvchOWE6eShTBf5+/pCeov+CJhr0WZV77FuYX/fVmqDSx+kB1D+kpGq
         7AzPBDuV8OuWad2HuHwMCWAbQYSND8Y4EjeyiZwH5OR2qBGJfMUFLVz2kwnED2T0XDvq
         LWVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfopwEHdToBAtXf4jyE412Lg2xxkCs18MyXrcD74stuw4NyDZkr2oaIDfYfob/qI5F5t7OlYzbm5isEnBlBVzwlE8tV7rYeTihO1Aacr4=
X-Gm-Message-State: AOJu0YxBaGZ5AIy+lldF4G9HA9WI9XyKyPUkAo5QnH7VTmlcyxFqCbRM
	3ak8A13QROAY0zdLr7FETsIY1rVXBBeO6JbLSpWHJMEHkgpwsna60ZyVD/iXT+A=
X-Google-Smtp-Source: AGHT+IHzc2MYBxQtrmJtlm+A3Ba+b1xBo3biutdeONIY5AZoPZgv68J1XHzbTpk7PKvAcyeeK8RTRQ==
X-Received: by 2002:a17:90b:1a88:b0:2a2:faf4:71da with SMTP id ng8-20020a17090b1a8800b002a2faf471damr4887452pjb.10.1713293115724;
        Tue, 16 Apr 2024 11:45:15 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:45:15 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
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
Subject: [PATCH v7 24/24] KVM: riscv: selftests: Add commandline option for SBI PMU test
Date: Tue, 16 Apr 2024 11:44:21 -0700
Message-Id: <20240416184421.3693802-25-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416184421.3693802-1-atishp@rivosinc.com>
References: <20240416184421.3693802-1-atishp@rivosinc.com>
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

The commandline option allows user to disable any set of tests if
they want to.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 .../selftests/kvm/riscv/sbi_pmu_test.c        | 73 ++++++++++++++++---
 1 file changed, 64 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
index 0fd9b76ae838..69bb94e6b227 100644
--- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
+++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
@@ -33,6 +33,13 @@ static unsigned long counter_mask_available;
 
 static bool illegal_handler_invoked;
 
+#define SBI_PMU_TEST_BASIC	BIT(0)
+#define SBI_PMU_TEST_EVENTS	BIT(1)
+#define SBI_PMU_TEST_SNAPSHOT	BIT(2)
+#define SBI_PMU_TEST_OVERFLOW	BIT(3)
+
+static int disabled_tests;
+
 unsigned long pmu_csr_read_num(int csr_num)
 {
 #define switchcase_csr_read(__csr_num, __val)		{\
@@ -608,19 +615,67 @@ static void test_vm_events_overflow(void *guest_code)
 	test_vm_destroy(vm);
 }
 
-int main(void)
+static void test_print_help(char *name)
+{
+	pr_info("Usage: %s [-h] [-d <test name>]\n", name);
+	pr_info("\t-d: Test to disable. Available tests are 'basic', 'events', 'snapshot', 'overflow'\n");
+	pr_info("\t-h: print this help screen\n");
+}
+
+static bool parse_args(int argc, char *argv[])
+{
+	int opt;
+
+	while ((opt = getopt(argc, argv, "hd:")) != -1) {
+		switch (opt) {
+		case 'd':
+			if (!strncmp("basic", optarg, 5))
+				disabled_tests |= SBI_PMU_TEST_BASIC;
+			else if (!strncmp("events", optarg, 6))
+				disabled_tests |= SBI_PMU_TEST_EVENTS;
+			else if (!strncmp("snapshot", optarg, 8))
+				disabled_tests |= SBI_PMU_TEST_SNAPSHOT;
+			else if (!strncmp("overflow", optarg, 8))
+				disabled_tests |= SBI_PMU_TEST_OVERFLOW;
+			else
+				goto done;
+			break;
+		case 'h':
+		default:
+			goto done;
+		}
+	}
+
+	return true;
+done:
+	test_print_help(argv[0]);
+	return false;
+}
+
+int main(int argc, char *argv[])
 {
-	test_vm_basic_test(test_pmu_basic_sanity);
-	pr_info("SBI PMU basic test : PASS\n");
+	if (!parse_args(argc, argv))
+		exit(KSFT_SKIP);
+
+	if (!(disabled_tests & SBI_PMU_TEST_BASIC)) {
+		test_vm_basic_test(test_pmu_basic_sanity);
+		pr_info("SBI PMU basic test : PASS\n");
+	}
 
-	test_vm_events_test(test_pmu_events);
-	pr_info("SBI PMU event verification test : PASS\n");
+	if (!(disabled_tests & SBI_PMU_TEST_EVENTS)) {
+		test_vm_events_test(test_pmu_events);
+		pr_info("SBI PMU event verification test : PASS\n");
+	}
 
-	test_vm_events_snapshot_test(test_pmu_events_snaphost);
-	pr_info("SBI PMU event verification with snapshot test : PASS\n");
+	if (!(disabled_tests & SBI_PMU_TEST_SNAPSHOT)) {
+		test_vm_events_snapshot_test(test_pmu_events_snaphost);
+		pr_info("SBI PMU event verification with snapshot test : PASS\n");
+	}
 
-	test_vm_events_overflow(test_pmu_events_overflow);
-	pr_info("SBI PMU event verification with overflow test : PASS\n");
+	if (!(disabled_tests & SBI_PMU_TEST_OVERFLOW)) {
+		test_vm_events_overflow(test_pmu_events_overflow);
+		pr_info("SBI PMU event verification with overflow test : PASS\n");
+	}
 
 	return 0;
 }
-- 
2.34.1

