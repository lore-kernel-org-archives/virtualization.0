Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E2346FD8
	for <virtualization@lists.linux.dev>; Tue,  4 Nov 2025 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295959; cv=none; b=MDMKdKet2elsAAguNLa25FLDJ61ZBoQdhanID5hKUrg+fVmK2DkK1gv1n1BRJ23FYGMl9gUIz0JISh8wFYwmzP0QPzvgLD1fjo1FkLIqOeYZJmI44hTRN+Pk9dR6qZEvn6ZnE0ryhwTby2XJO85MTFjogJ+bLSwdbWKYa9tKG5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295959; c=relaxed/simple;
	bh=6JthngltpkcWftejwxT4QQ+XaYtKnwnkggaq1rsEx0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XRPAV70M23Cdl9KChS5MGpTJZva0rQXS8TCW1dX5ee+0AxJpVrIXW05J4P3LLr1IL1aZpgDTLt1t9QGZVs5uIgiOgsnfB2MympNeTfZWpspCpONW2i7VbNFOekN0P4/lIIl3hqKfrsRnV9OvpMz5GhxTL7gIdIyoh4UO0Cmhlzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOJNcda4; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOJNcda4"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33be037cf73so6249925a91.2
        for <virtualization@lists.linux.dev>; Tue, 04 Nov 2025 14:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295957; x=1762900757; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xDsH9kNNXBt4JKt5mitfCe2Rq8PZuvGot+36QHyMJvw=;
        b=GOJNcda49qu/IJu76wnsMQZmxsSD44l4fJiQlhnTWlXytC+GWXC1v9bHrLS8EFdd67
         lj0NuGbZhIiV0QAeHtp3bsSoiUPI41FsfW5784S9ILQe8mdZ53drj49ItEH+uwsF5cW+
         9z/yOZkH7uXveY6nFa5ChNsojMxafgDuU32VgaiiGcY9aAu/bfaHyh7e+KuZbmPognpS
         Q7ILt+rwJRcwNp+eiumkcLSc1sKUV0BzwLYXfE7Fi1dJ5CT8tpqDs61kGSaYavi8yzHN
         +Gmqg9IkHVmEyklrmOwkqo1Hq72//jVycpiFT1hYLGg7kOn/YCOsZ8kMnprNthQOUBZG
         Z82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295957; x=1762900757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDsH9kNNXBt4JKt5mitfCe2Rq8PZuvGot+36QHyMJvw=;
        b=L6Ihwnidov9lwaIYqI4SFP0wvpncvxlOfXF9jE9+m01m+xDFEMAYUOvjQQTY/mFi6k
         WSQoC8XrlfOEsZZqO1O3PKhlON32Xu3ZE9Nlq34rhkFyMvoRaZ+B+EaLPQ8jr3le0n1e
         TB9ErNffAcj5NlzH/SqEplmN64BWWb4BFoErXdBpQ+mW3twRv9Z9gF64cC9pe0AlBGbu
         zCj4O0wMHfOYdqiT2xZGw+NoGw59OcQIA0JcGb3Ypgb9Wtmsb4JJvDCkP5rQ+mFT0F8/
         knIWbeGTx7zj1yEDpVI8HLfk1FTwWXLusZWX/aVUWJerdkXmBUfZN45cAA0jXpkV73cS
         0VMA==
X-Gm-Message-State: AOJu0YxuQp2VHt/HV9nr6JeePthR424t1A4Q+o3s4bBAweGZeaUFOiHg
	RgOxZ7/8qRbSPnMTjTAj/E3VjfhL6s+lduHbWEHF+lGiNzTLjBBLv2/yn+sn7g==
X-Gm-Gg: ASbGncvW3hnQ29AKs1ilrn3yo/wSx967tR2rqg3flIvx9rg+SVXPdjfk71A+AgsdmyJ
	+pSVObNHuK5TesJiMAIgje2IODUYGmEq+G8mRqgvIo1NaDpQkbwNOp12TYd2pcyTEKddz4zVt9w
	TvUFFkI/fA6DUNRxondAWlv9pqzs9Fh2va80214001va0qyw124/33ysMPlm92Zeeb+ZajWgRPR
	XX6D7b3uupyi2qiO+WlRrhBtdANEq6VIQ1blGJD2aRNzoWmifjh3FqPTl2OKMxqun+iKN/o+2Je
	0Kf3D3GTR/JmfbFT/JRh802qK49uCvZ5xkk6LYgxfRUqHww102q4sD02o6pwhqETtB25tLP8hcX
	CDuMzT5w9EqGjhNLRpQhmVanbsx1Sh8FM8Gkm4+cZbLxGB5GFDseFjVCn/uNgf1jmX77qtqx6wQ
	==
X-Google-Smtp-Source: AGHT+IGmcX9KQhrwLWD8vDeS4NjjuNE+rklNtcRnYnJAg/yp6Cd7qau2TSc8kt5ZpkI4HpwFXvMX9w==
X-Received: by 2002:a17:90b:3e4e:b0:33b:b078:d6d3 with SMTP id 98e67ed59e1d1-341a6db60ebmr937766a91.23.1762295956648;
        Tue, 04 Nov 2025 14:39:16 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68e4149sm638270a91.16.2025.11.04.14.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:16 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:58 -0800
Subject: [PATCH net-next v2 08/12] selftests/vsock: identify and execute
 tests that can re-use VM
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-8-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

In preparation for future patches that introduce tests that cannot
re-use the same VM, add functions to identify those that *can* re-use a
VM.

By continuing to re-use the same VM for these tests we can save time by
avoiding the delay of booting a VM for every test.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 63 ++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 4ce93cef32e9..678c19e089a2 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -45,6 +45,8 @@ readonly TEST_DESCS=(
 	"Run vsock_test using the loopback transport in the VM."
 )
 
+readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+
 VERBOSE=0
 
 usage() {
@@ -443,7 +445,44 @@ test_vm_loopback() {
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
+		check_result $?
+	done
+}
+
+run_shared_vm_test() {
 	local host_oops_cnt_before
 	local host_warn_cnt_before
 	local vm_oops_cnt_before
@@ -517,23 +556,21 @@ handle_build
 
 echo "1..${#ARGS[@]}"
 
-log_host "Booting up VM"
-pidfile="$(mktemp -u $PIDFILE_TEMPLATE)"
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
-	check_result ${rc}
-done
 
-terminate_pidfiles "${pidfile}"
+if shared_vm_tests_requested "${ARGS[@]}"; then
+	log_host "Booting up VM"
+	pidfile=$(mktemp $PIDFILE_TEMPLATE)
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

