Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EA8244687
	for <virtualization@lists.linux.dev>; Sat,  8 Nov 2025 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617721; cv=none; b=SVi0/D8mxR+iyc0IvaDORkgpsYJrXI4mHWvFq6FtdMCxGoKBu+NMITdcbnZ+JNyiZyIxJ0sLhL6Yp+CDLii2vPKaG5ux6qvQ3fC/oEfXJM+ndCVSejPy5/jVc6szOV6GS1DftkncRm2YfBBCLR6TVNTG7XHSUZDn6SfOFns43DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617721; c=relaxed/simple;
	bh=F9FsVtLt7rSsC+SslDdvx9EYIxO2ErB70trA08f7qAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xr8Arw5/DZdgDG9mcrcfmO92zT61Dg4bqCejDeLqZn0c6vS1RPD2hGIJaaZ0bBf6ijAqxLMR0lKdMdWG9asTmunrLOrJPXFyIJK+QO4d8GoMEBOZnCz4eztdombV3MQRVbPocIfAaRvX1zwJQiRHsQ3+iPKdHVxZK/ca2LLVXbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2r4iZWt; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2r4iZWt"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b9a5b5b47bfso940146a12.1
        for <virtualization@lists.linux.dev>; Sat, 08 Nov 2025 08:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617719; x=1763222519; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/1yyOZn8r1C2HMNNmP8ItI3UkC7xFO+t2DlRUjrTgM=;
        b=l2r4iZWt0A88uX0n07bIfx7R09q+Pd4YiHLqr+oH6VQpvF+PWh5Bghn+eFxy88icJB
         I/Uw5eMiFtek975YjX1o6H6Pj8UPoyp26897OiIC+uNZHWJwTqHnFhKncb9Vw64FNeuq
         Fx2YI8erS+rHctYPNc7ikibar2U7EB8Hy/7tEEXvKrkIBIU7V1V6P/O3eLT6KZZxNzwB
         boPU4FEV6JKhvKmi6yNdjcMQA/Sl3RBTYEIn0ID0znPsa0n7wTjeRqNmzUGbnQ6fGbwE
         HB20C3NRfnp/OFidpQUNWKhgEKPC9rHY+ar5xss5e+2FYGfV3Q0m3YdmwkoTIn5cyT8e
         ii5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617719; x=1763222519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2/1yyOZn8r1C2HMNNmP8ItI3UkC7xFO+t2DlRUjrTgM=;
        b=MQq8HOAr1CJDHpzdlIdv8MMIg/f2wSinGzMmls9JRYC43Ct3dBnFGZGW4knUReWLCT
         qecJzogrgagvUIWr2qv2nV+xvukCeyonKe9EteNV1iL9CFultbPMF4KoCeyhGXGl0Drt
         8sCv+9Rx8mwcKmfW8etYcWk+Rajs1XHxgbSxb77yUG++TqyK7sXdJSNar/tnIfS/JdT2
         +05bf6KOTHuKtoJL2Z81ReDMKeaWL9+HoIatYqMgyyjG2nM7U+6Fxbjo2yePG6ZX+gN/
         LV+0nmf3e5D92IyaVWzr7dBLNk9TQKA7NXkU9gn2o2mhspFPTQMKvUPr+ghVGAvxr8VF
         Hb0g==
X-Gm-Message-State: AOJu0YwB8EZCw7DgP2Hes706B8lAFr/yf7WYyCqN5CDFDTJ0LNWZ487l
	1A5eCrGSbCQAzoLXcf7XPG3XagruQBvLN43Bx+P1+D716+8al0y87gZg
X-Gm-Gg: ASbGncsvAx2hs2BjI1CC8s1dFd4Vkq/cX393C5w4VdYF2JWdEH3q+tqMp5A38KwkLS7
	mMwhnSp1G7d2e/kxYVOtICft00BAfBV6/2QiGnpCpLgX0orQF8IZg+FW/AT3l7YnmigO/XdZr0y
	Z9UY914kJ/Q9KqbHj6vgJkKNt9CTsLkRS3jhF9CU0O0E2de+ql1zqtvygtjigLJABXOnEmY0+HV
	B5r0rmFJQmkm8SzItnNc2UZQG788fN9yDU5cqE3tOnltPuCktXah5IObVURl/DjsdolvKxY31FV
	3rTCmZECKBElbzeQ2tisV+C9PIakDLtXenOP/CQHLpalLo0Xz8+b/l/Wo4ZyrCjxdxjhNykUFHB
	cmNs9W3nDfYCVWJaAZ8HRvySYHCxr+ZeuB96o9wNIgXwODOiDtTyiklmc/m78rMf+qX0pTPZJ3J
	HoVV4ajyY=
X-Google-Smtp-Source: AGHT+IHomY4YyVD8KS6qtG7MNKX+4x/II1DuyBNIdKkYHuI5hzRRInd+7+JdQ5vyk3YIsOnkaHnafw==
X-Received: by 2002:a17:902:ebc1:b0:294:cc8d:c0c2 with SMTP id d9443c01a7336-297e5663a67mr35112645ad.27.1762617718558;
        Sat, 08 Nov 2025 08:01:58 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c94ac5sm93090585ad.92.2025.11.08.08.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:58 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:00:59 -0800
Subject: [PATCH net-next v4 08/12] selftests/vsock: identify and execute
 tests that can re-use VM
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-8-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

In preparation for future patches that introduce tests that cannot
re-use the same VM, add functions to identify those that *can* re-use a
VM.

By continuing to re-use the same VM for these tests we can save time by
avoiding the delay of booting a VM for every test.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v4:
- fix botched rebase
---
 tools/testing/selftests/vsock/vmtest.sh | 63 ++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 2dd9bbb8c4a9..a1c2969c44b6 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -46,6 +46,8 @@ readonly TEST_DESCS=(
 	"Run vsock_test using the loopback transport in the VM."
 )
 
+readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+
 VERBOSE=0
 
 usage() {
@@ -461,7 +463,44 @@ test_vm_loopback() {
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
@@ -537,23 +576,21 @@ handle_build
 
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
-	check_result "${rc}" "${arg}"
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

