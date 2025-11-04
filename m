Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97080346FAD
	for <virtualization@lists.linux.dev>; Tue,  4 Nov 2025 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295958; cv=none; b=aiGXTCO1KGwrX2oKeWLl5pfykzgrsh4fRiUrsKnWq1vDyRDvC2H9o1hsvAdhZCwbAQDtCLzWRnuUzL7UwMEWcf+O+d+P3EE92s5lmOUs2vPYafMFpqkBjrNreqWYW4KkhlYcaxQwYs/BZuJ0PPxQPxtW5i0p3RskRgrtqt5CUao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295958; c=relaxed/simple;
	bh=ZD+kE7Km9hitPWcu6/+QvjzHaUtwlQLzQuuF071Kneo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IIpeNp/bc8sAUiK8UflFZMpHe8AzFbHDBddbrN386n4tpjXdE0OkytCTdCb8Z7XvJl25lIEoJWrLhRNrDNUKDj7TQSYPpTOZM9f8VMH+jLAnKciutHZ+iHiTQ2JHpSzdukaLBgCSMDk6PQ6O+i8vR3Ij0f5j1YP72WPV1/ks76U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/HpDC7M; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/HpDC7M"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-294fe7c2e69so57317475ad.0
        for <virtualization@lists.linux.dev>; Tue, 04 Nov 2025 14:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295956; x=1762900756; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FdVSUjHTikcWcPgapXwx/mSIY+mfI9o+bTGGuyPCvg=;
        b=g/HpDC7MWh9k0bneaa3LneNZgoq9vzBbbq270ErEwRpCM/4krvCxB7Eya0nzOQB7Yw
         nBdFzH59/PPDjWk+V5fKGGnGN024DWQmJssz7NEgxZ/qiFyInIPoTG8bnwGtlhK4EmzQ
         dE9qLKKnk5SN524yF4DSp9EP4BPqFC7ia165cqJEJAiN+ZV+v+0FYtY+gPCayxGBeVcS
         QDDSQWBMyhpAymSvdBgK4Jg4SUXzvCnBVaqemdADeV2DaPAAL8Z2FYll58X78J7Z+r9J
         vRxuKTjdWlvtF1VaDSwSk4pXlMnH3oKrEULHH1ZnadDPVuznLbMtKlzt3j9bCRDGHD/r
         DQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295956; x=1762900756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FdVSUjHTikcWcPgapXwx/mSIY+mfI9o+bTGGuyPCvg=;
        b=kLeKJ5R0dJZTXZZWe4mpEW4ZhcseapCGv/ws3RV6tgqXJ6qDQCnkvINefIH/a4FoKG
         pjhxQBaJB6X/vGM9W3czvI+m1a7po3zMhXbXTGEsZu0afbtIuVGL6VeuQ87Yj3OUEwXd
         E3V2Ud3Y0UXJN8sWyn6TZnhsyh+LdI/VvbzmG1g3APSKYoAHjq3IId407JVGXNqCSEny
         pLvicniJ+pql8eE1yVLDHuN1P3LYsZbPz5GkZRL+QTYzoQIRIbl21zpUZckZpZfXDNow
         FmM6xBRMBS1SQBBDLjfppbcsECeHVHNyhbx0x329QCd4pZbZH2cX4zKH8MRpdQsFtGIX
         vwwg==
X-Gm-Message-State: AOJu0YzJd7nQWCTEoTjkmhhXKFHliMmnKiVHxDeFLV3EWTrALHvZ2Qys
	JCQTYFUJqRVUSXfnbHGgP15wN95KHg3ppONODR14l8jGDCJFHF8/esbE
X-Gm-Gg: ASbGncsjUcD9NszEF1XKE9FowD/zsBFl/D1nyXe74XDs1mhDShuRXFaej1Jyi3zkOuN
	0qfrFC2XwJevFOrUz5xepQCt++2YFXOW7IWfu5hxHd4rFxP8Rqommx+lDtalWb+8/dZjDbRCMF3
	8vQZtXqsTiko5xUFT4WRhkKng0qclyjPll08eJpCSUV2rYcVe+tJLGgs2b8WgqYUnEeynRMOxhX
	/91ABKQgWdxxlYqRkJhlfiz/2QwIEQPc0xjC3XL2qv1vVM5kCQ5DTAh7NOrV57BuBvf7SOKm/69
	I8UUTx8A/o5vRolz+oKeTBcqgc4/AQj36QS9pLyVTwVY//Thxrab9tgLBpY/H+pmkp3j8nK2fD1
	G1IeoICUeNwMTZISgoiIqSoE+kv2L6Y6dFIqJkvwB/sfEpZUmHJ3Ja/AMAkR+1Cx+mY0t8e+PJQ
	==
X-Google-Smtp-Source: AGHT+IGE2AJdLQ3ih5rbl3nytu4JYVPoufSf2/AeWyCovMJpVIx4Pfkn2JQACMKcx394CGEglGnVnw==
X-Received: by 2002:a17:903:2447:b0:295:b490:94bb with SMTP id d9443c01a7336-2962ae75808mr13019465ad.50.1762295955674;
        Tue, 04 Nov 2025 14:39:15 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998893sm39091575ad.40.2025.11.04.14.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:15 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:57 -0800
Subject: [PATCH net-next v2 07/12] selftests/vsock: add check_result() for
 pass/fail counting
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-7-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add check_result() function to reuse logic for incrementing the
pass/fail counters. This function will get used by different callers as
we add different types of tests in future patches (namely, namespace and
non-namespace tests will be called at different places, and re-use this
function).

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 940e1260de28..4ce93cef32e9 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -78,6 +78,26 @@ die() {
 	exit "${KSFT_FAIL}"
 }
 
+check_result() {
+	local rc num
+
+	rc=$1
+	num=$(( cnt_total + 1 ))
+
+	if [[ ${rc} -eq $KSFT_PASS ]]; then
+		cnt_pass=$(( cnt_pass + 1 ))
+		echo "ok ${num} ${arg}"
+	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
+		cnt_skip=$(( cnt_skip + 1 ))
+		echo "ok ${num} ${arg} # SKIP"
+	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
+		cnt_fail=$(( cnt_fail + 1 ))
+		echo "not ok ${num} ${arg} # exit=$rc"
+	fi
+
+	cnt_total=$(( cnt_total + 1 ))
+}
+
 vm_ssh() {
 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
 	return $?
@@ -510,17 +530,7 @@ cnt_total=0
 for arg in "${ARGS[@]}"; do
 	run_test "${arg}"
 	rc=$?
-	if [[ ${rc} -eq $KSFT_PASS ]]; then
-		cnt_pass=$(( cnt_pass + 1 ))
-		echo "ok ${cnt_total} ${arg}"
-	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
-		cnt_skip=$(( cnt_skip + 1 ))
-		echo "ok ${cnt_total} ${arg} # SKIP"
-	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
-		cnt_fail=$(( cnt_fail + 1 ))
-		echo "not ok ${cnt_total} ${arg} # exit=$rc"
-	fi
-	cnt_total=$(( cnt_total + 1 ))
+	check_result ${rc}
 done
 
 terminate_pidfiles "${pidfile}"

-- 
2.47.3

