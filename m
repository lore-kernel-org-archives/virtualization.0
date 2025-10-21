Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E396242D79
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 23:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090446; cv=none; b=C2S6TmfAHpOjGdrAAwybSaGkcxeLfIH167mP0peYv9CVqQM7W811nNYbdaQXyFLF/82ptRX6nofxoUAhBGc6qxazga7XXWJsHNoXiIfTnBGq9lJoLtM4BmlC0cGenx8o1ddsRqDgG5hV7J+Q8IPUqOF9+EelJ992LJMhdw/UtnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090446; c=relaxed/simple;
	bh=tkMGIMswqfAEZyDr4Cl0t0E9LZdA/zAbPpZnx5/so6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k32G2MFiucIOMqytzAZmoS6eKib6NkR2qm/n6UHmZz2R73Ii/0bc5gsvMLk2+lTfTaAUrYP6NVCwPCYeBgsmnFNAnHq0Ejt8mGxvVQi+KXfIfMjWQKYhLzdx79TgL53fUQM3jmhI/I00cclN6lGV2pCleI/Lk/CRF9a+P30Js3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYsYXLl4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYsYXLl4"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-79ef9d1805fso5710126b3a.1
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 16:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090439; x=1761695239; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MUSawlw3KS8OKu+neqC1xDDribwG4GyG+WJRI7AbHRY=;
        b=JYsYXLl4Y4h/PlP250nR2oDrI3QNRPXVMdzKdto+GE3i8FzKRSEHVoSIsc7eyT0kUD
         ovSuW0w/n2fvUtW465Hm7T3a4LVsWb9/sNI9otUbkicZWQcuD12sRrmz8fiQF1sa2abc
         DIDdghxp17lz5G2t9L+9DbsQdIpV/Xcb05UNzYMqqOtyp09qkFrQiD6MJGKa2eseto7y
         /O4vg0xZTMXNAo3Q7xyEMEUFdr6kD+hjj42l8+6Kon3MiKiL7jSC7HINlEXW4QddfAxS
         Nr4/BYp1Zv38jWpu4n7dNweraxRvTuUVQp7Ys1GKFteZMZM3JPNpNX05dsSIrUnpuo5v
         IhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090439; x=1761695239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUSawlw3KS8OKu+neqC1xDDribwG4GyG+WJRI7AbHRY=;
        b=EbULIa/upMJNpG57F4tYzDiK4GNJviFxHwco7SFdBtpUUHNY8ewC2ypvFMLnjqdZ8j
         Qvps5LvulJ2gGzDzthVBEPIcFbc3ho5FmC4IR4XLeh1Zj/2CUc6CIMeK/7SxzuL8rAVA
         y1A/LmxDCA41lXDPAiZ5JPTXp1JYopNpM4Im4ZRbVNBeYP3j9ethw0ItlMQ1s8ZZ3Qxd
         QZwrKK42zjcECD2YD8In+OpNvPyTmWqwLJizyEewq8rET8oI/ZNw2YYXwnpY8KonWTNy
         vLeZJHL5xf1E8jtTDwOkdga189raaNGm4wPqoh4uPVFP0URYPXPIibDPs1WTGdKozvFm
         56Tg==
X-Gm-Message-State: AOJu0YwpCNlryqBytlMIszq8qjzUe9/SnRB7ZM3jQ1OovNMddVMLn0yG
	nRR+/tkmqA0vYqZZC+VYXMsHGfansIWzfthuU6dismXbpkLWPLr/whEx
X-Gm-Gg: ASbGncuZ/N8mZ3klDY56KZ+B2tiafv6WChwYLIIiaLecouSMDMh6KBC6e4JrVB/SthR
	7ljbSPG/4B7NTWcZcUklChz6hKsNt6b0lQJY4kN5sz5C7kuBfyhYNqD9XgxFJPHSJIsvmGfJ8az
	ZqmgNt3pj3+bxjHzmmroQw53fGtEsAP37cb2IDIUFCkz6SgE1QXbZWzh7/M4o247B1Gj2O37A5P
	kK7h+VERWbEN2WugmUv/Ok3SEQKfOp5Nef3+CsypqbC2ljOm6x7DRSwQ+rGQQ8TmcjWEVe4Ia/f
	QIybP1Flo7OhmQt2fS2ejAmrs4p+p3Nzo32RpTBmj0gwzfW26/ffyXIFerrV66SGSjJprtOhj9/
	LPxd2149E5oRthLpQuTlneNKMlPc6Cg8nIX14Pc57CKdZk2WdxWdlhsNxv4czJKcw8rj0TRDE36
	7mYCrNnJQv
X-Google-Smtp-Source: AGHT+IFovlERrPh42B70YTWXTmz2rKyfI2eDHBwzjrpjJJS/U4lT6i41uck3W1mtdr1D6DfW2bDl7g==
X-Received: by 2002:a17:90b:2d83:b0:32e:5b07:15dd with SMTP id 98e67ed59e1d1-33bcf8628demr21493620a91.1.1761090438795;
        Tue, 21 Oct 2025 16:47:18 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff34b8bsm12570317b3a.22.2025.10.21.16.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:18 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:04 -0700
Subject: [PATCH net-next v7 21/26] selftests/vsock: add tests for proc sys
 vsock ns_mode
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-21-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add tests for the /proc/sys/net/vsock/ns_mode interface.  Namely,
that it accepts "global" and "local" strings and enforces a write-once
policy.

Start a convention of commenting the test name over the test
description. Add test name comments over test descriptions that existed
before this convention.

Add a check_netns() function that checks if the test requires namespaces
and if the current kernel supports namespaces. Skip tests that require
namespaces if the system does not have namespace support.

This patch is the first to add tests that do *not* re-use the same
shared VM. For that reason, it adds a run_tests() function to run these
tests and filter out the shared VM tests.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 99 ++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index b129976e27fc..4defadad5701 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -38,11 +38,28 @@ readonly KERNEL_CMDLINE="\
 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
 "
 readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
-readonly TEST_NAMES=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly TEST_NAMES=(
+	vm_server_host_client
+	vm_client_host_server
+	vm_loopback
+	ns_host_vsock_ns_mode_ok
+	ns_host_vsock_ns_mode_write_once_ok
+)
 readonly TEST_DESCS=(
+	# vm_server_host_client
 	"Run vsock_test in server mode on the VM and in client mode on the host."
+
+	# vm_client_host_server
 	"Run vsock_test in client mode on the VM and in server mode on the host."
+
+	# vm_loopback
 	"Run vsock_test using the loopback transport in the VM."
+
+	# ns_host_vsock_ns_mode_ok
+	"Check /proc/sys/net/vsock/ns_mode strings on the host."
+
+	# ns_host_vsock_ns_mode_write_once_ok
+	"Check /proc/sys/net/vsock/ns_mode is write-once on the host."
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
@@ -201,6 +218,20 @@ check_deps() {
 	fi
 }
 
+check_netns() {
+	local tname=$1
+
+	# If the test requires NS support, check if NS support exists
+	# using /proc/self/ns
+	if [[ "${tname}" =~ ^ns_ ]] &&
+	   [[ ! -e /proc/self/ns ]]; then
+		log_host "No NS support detected for test ${tname}"
+		return 1
+	fi
+
+	return 0
+}
+
 check_vng() {
 	local tested_versions
 	local version
@@ -500,6 +531,43 @@ log_guest() {
 	LOG_PREFIX=guest log $@
 }
 
+test_ns_host_vsock_ns_mode_ok() {
+	add_namespaces
+
+	for mode in "${NS_MODES[@]}"; do
+		if ! ns_set_mode "${mode}0" "${mode}"; then
+			del_namespaces
+			return "${KSFT_FAIL}"
+		fi
+	done
+
+	del_namespaces
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_host_vsock_ns_mode_write_once_ok() {
+	add_namespaces
+
+	for mode in "${NS_MODES[@]}"; do
+		local ns="${mode}0"
+		if ! ns_set_mode "${ns}" "${mode}"; then
+			del_namespaces
+			return "${KSFT_FAIL}"
+		fi
+
+		# try writing again and expect failure
+		if ns_set_mode "${ns}" "${mode}"; then
+			del_namespaces
+			return "${KSFT_FAIL}"
+		fi
+	done
+
+	del_namespaces
+
+	return "${KSFT_PASS}"
+}
+
 test_vm_server_host_client() {
 	if ! vm_vsock_test "init_ns" "server" 2 "${TEST_GUEST_PORT}"; then
 		return "${KSFT_FAIL}"
@@ -573,6 +641,11 @@ run_shared_vm_tests() {
 			continue
 		fi
 
+		if ! check_netns "${arg}"; then
+			check_result "${KSFT_SKIP}"
+			continue
+		fi
+
 		run_shared_vm_test "${arg}"
 		check_result $?
 	done
@@ -626,6 +699,28 @@ run_shared_vm_test() {
 	return "${rc}"
 }
 
+run_tests() {
+	for arg in "${ARGS[@]}"; do
+		if shared_vm_test "${arg}"; then
+			continue
+		fi
+
+		if ! check_netns "${arg}"; then
+			check_result "${KSFT_SKIP}"
+			continue
+		fi
+
+		add_namespaces
+
+		name=$(echo "${arg}" | awk '{ print $1 }')
+		log_host "Executing test_${name}"
+		eval test_"${name}"
+		check_result $?
+
+		del_namespaces
+	done
+}
+
 BUILD=0
 QEMU="qemu-system-$(uname -m)"
 
@@ -671,6 +766,8 @@ if shared_vm_tests_requested "${ARGS[@]}"; then
 	terminate_pidfiles "${pidfile}"
 fi
 
+run_tests "${ARGS[@]}"
+
 echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
 echo "Log: ${LOG}"
 

-- 
2.47.3

