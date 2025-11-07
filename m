Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B8021FF21
	for <virtualization@lists.linux.dev>; Fri,  7 Nov 2025 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476601; cv=none; b=HvTTjM70LEM4w8/fxQP8Z/cmaYnk0DZ5+0GQLMgrpMGGfltqEgMEuqC0UljiucOOTgT4vSGIniYVEjFkfiaTupnxPmXajDwUevul1geB0S+wtLeg3e0AUXLoOJJterW2fkQfHGCKKNN6IGtSYGeIymLZtL2vGLtPh53oERucEyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476601; c=relaxed/simple;
	bh=gWRJPR7nlbp70//O2u5KWOT+hLm0yZoG3tHFlE9gXpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eQB5s1u+5FhzUdJYqnUwvDZxoVOZKXhfatbEtipNRHuRADEf32/E81+DbGNDm1sLR7ThNSkKg+CNheKDDP1Qke530+Xcx9Er6T7d+iNQk6WOznCJidkuOeCl4BkFTKfgK9MieMQhWY1HzFfNdrsP4/cvm9Yc8DbD//MFBGHO58s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y10VWIH3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y10VWIH3"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7af603c06easo250454b3a.0
        for <virtualization@lists.linux.dev>; Thu, 06 Nov 2025 16:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476599; x=1763081399; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCEmvng1yWc0PKZqREcwFmN4dvc5QvU4pfz1PlM1Jyo=;
        b=Y10VWIH3gnrjotLubJEYwnKZeuXJwRlH2sOkYLQxeH1NO4K93ql/yuxkR4y7UBr++n
         49SrfYA+n4i40wwESueg/QVqxpAcZCUt8u/gQtXB/3yda+VvKiH1657hRSR5HS4epDTy
         wpIfUaAJMorDqXlgW9mLND1JG8T4PmOWfXo7hLYj0SqpWZff/ya4JG90ow0v6k5hiP2+
         BuHIsAW9aoiNBzrpTHMI2J6vr/O7+HFRsNkXD/FZOvNsoHGsz+WzBEhwZx4kDvnuB0NC
         TauTgXJHkKLUsfj4A4wvu19BTOL+lid/+aQ/wESp6Qal74/nTkVFyckvAGCpdFZbcf3r
         wjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476599; x=1763081399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gCEmvng1yWc0PKZqREcwFmN4dvc5QvU4pfz1PlM1Jyo=;
        b=C6C10X2iD3nqmg0uN9MYGvH+tpjxPW18XGE8EBIDJ+azGxTg+Ny1HjuOhjkSCNgw2O
         Ze0xb5r1rEF7SjdE3ipflqwTiFaU7zGnh83A9ro91jMcUc4rYfBDzkE/KkCgOVuXG4V4
         c3KhalcSXwN2Xl2oAVvC8K7FnwSnX3BG+S3UV6qnYKqT7ocZobovzArnSoWqJp/jdjRl
         uazNx/7B9iN3iPswoxINoioQooBqHrzntU3Xk/nCsgSk359kRUC+R6HD7FSQnIq8UAsC
         1IeCKnEGRbqYGbUJj9SDSEaOsts8vPddyKQ+VXWRQ69+h2QxDEmSCafxxoH9Qz6bFS8H
         EH6g==
X-Gm-Message-State: AOJu0YzTWjAaiTS9WhVq74nUgiHsbq3fZUlS9mPQM08IFRIBtOGEOiK2
	LfRd3epSwPhk+7gO0AbSG0lkDFc27G9fwUHpQa29S+o3I7p4ddeJJNPn
X-Gm-Gg: ASbGncscbCaRDk8NqDSTv4qei9hQc6EaIzn54Vi40L9/zRE2xfzd4JEP3BqgL3XtCBT
	Al2rs8gOnQvjM02Nxr60vMLRmN4pXtm+RVSxn0TPn97r5zImb9yzRKYQtZB8k2Q+PuYl0KBnCAm
	vJrlk7ppXwooGpXJYJ80bJXjlhR6Gns9hc4M//4Psby9c+EYkWxv/L9nZoT2vSRuBbldS7fMtD/
	ziDOj8VEEvJ4m92keOPqLfKzvm1+stlUT2OEnfajJ/ofmk93seatcdbVBv9R41ehzK1o23nF49U
	hImYi4lnrYVpk1b6XJ4baTu/13AL/OLwYJRUgejDfFg72p0ZygL/PRWBprpZgn8HzZJb2bDR/eZ
	hdn+0blgfsbctGMte2dHZ1+52raBEexl3FQ+XKzdnXhAG4yIL3ut3aCoCY+vGpaLCoFSp7Bx59+
	dKGhSFXVY=
X-Google-Smtp-Source: AGHT+IFI0mcKzM1/Q8A1uRGQq4SFewTSb0w9plBTnCGZlfhkXZ/d0eC96TItpJKFxk7QSLfYEMblUQ==
X-Received: by 2002:aa7:93c1:0:b0:7a2:6adc:cbe8 with SMTP id d2e1a72fcca58-7af72464564mr5156477b3a.16.1762476598594;
        Thu, 06 Nov 2025 16:49:58 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9632e15sm868507b3a.14.2025.11.06.16.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:58 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:51 -0800
Subject: [PATCH net-next v3 07/11] selftests/vsock: add check_result() for
 pass/fail counting
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-7-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add check_result() function to reuse logic for incrementing the
pass/fail counters. This function will get used by different callers as
we add different types of tests in future patches (namely, namespace and
non-namespace tests will be called at different places, and re-use this
function).

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v3:
- increment cnt_total directly (no intermediary var) (Stefano)
- pass arg to check_result() from caller, dont incidentally rely on
  global (Stefano)
- use new create_pidfile() introduce in v3 of earlier patch
- continue with more disciplined variable quoting style
---
 tools/testing/selftests/vsock/vmtest.sh | 95 +++++++++++++++++++++++++--------
 1 file changed, 72 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 557f9a99a306..05cf370a3db4 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -46,6 +46,8 @@ readonly TEST_DESCS=(
 	"Run vsock_test using the loopback transport in the VM."
 )
 
+readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+
 VERBOSE=0
 
 usage() {
@@ -79,6 +81,28 @@ die() {
 	exit "${KSFT_FAIL}"
 }
 
+check_result() {
+	local rc arg
+
+	rc=$1
+	arg=$2
+
+	cnt_total=$(( cnt_total + 1 ))
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
@@ -450,7 +474,44 @@ test_vm_loopback() {
 	return "${KSFT_PASS}"
 }
 
-run_test() {
+shared_vm_test() {
+	local tname
+
+	tname="${1}"
+
+	for testname in "${USE_SHARED_VM[@]}"; do
+		if [[ "${tname}" == "${testname}" ]]; then
+			return 0
+		fi
+	done
+
+	return 1
+}
+
+shared_vm_tests_requested() {
+	for arg in "$@"; do
+		if shared_vm_test "${arg}"; then
+			return 0
+		fi
+	done
+
+	return 1
+}
+
+run_shared_vm_tests() {
+	local arg
+
+	for arg in "$@"; do
+		if ! shared_vm_test "${arg}"; then
+			continue
+		fi
+
+		run_shared_vm_test "${arg}"
+		check_result "$?" "${arg}"
+	done
+}
+
+run_shared_vm_test() {
 	local host_oops_cnt_before
 	local host_warn_cnt_before
 	local vm_oops_cnt_before
@@ -526,33 +587,21 @@ handle_build
 
 echo "1..${#ARGS[@]}"
 
-log_host "Booting up VM"
-pidfile="$(create_pidfile)"
-vm_start "${pidfile}"
-vm_wait_for_ssh
-log_host "VM booted up"
-
 cnt_pass=0
 cnt_fail=0
 cnt_skip=0
 cnt_total=0
-for arg in "${ARGS[@]}"; do
-	run_test "${arg}"
-	rc=$?
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
-done
 
-terminate_pidfiles "${pidfile}"
+if shared_vm_tests_requested "${ARGS[@]}"; then
+	log_host "Booting up VM"
+	pidfile="$(create_pidfile)"
+	vm_start "${pidfile}"
+	vm_wait_for_ssh
+	log_host "VM booted up"
+
+	run_shared_vm_tests "${ARGS[@]}"
+	terminate_pidfiles "${pidfile}"
+fi
 
 echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
 echo "Log: ${LOG}"

-- 
2.47.3

