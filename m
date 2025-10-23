Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CED34C14A
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244103; cv=none; b=B+vUdnX80PS1nH/4hsVtkEXxZS3N3Ntgwe+GboHsN9snMZVOkkvXLC7VQ0LBcMdFIkhJsVZRl1BayIPyGFjCT9wPv7v64O9q1h2oFy2SIVZ80d2ExgtllBTe8+W3bnZmvLeOaZeq6TFrKL0FSQjAQJeB74dsKvsdgRN+udZ9QxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244103; c=relaxed/simple;
	bh=kQBee9DoWSc6883yGLsxi//tyX5HHzjIliVS8SZbc0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rxjM2YztKwVFivoryoa4MdDD2sCQRDvx88hvLWNrVyC9ZDC3ekZs+ONvmXsqMg4NMaueLKEsSymI2lY33mfPjVIS07SGJC7gix0N+8fho+HiDtokr5rTmloU4iXYtInTIFRfJw27ZPlMoXQj8F651JLqtTNsuKtpo5X2/9h3KgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCT1LPz2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCT1LPz2"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-292fd52d527so12906495ad.2
        for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 11:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244094; x=1761848894; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukvtIuA2GTbBdDn1KeFlCInIvIk5c30LHz1pGa2sbYQ=;
        b=WCT1LPz2L9DxrzJyzQk/vytKEFSVmS3oizBg2/c0mLziw1V6uGGFmNtw5AtGN3N6Wu
         Nzf95bLQe40wfEL+OHTmEm0ACs+5HOfSjBVBU+vBs/pos6CxzkOv24O2x3wo9u/uSdNl
         lvapDeR65UC/9Fezisdsm8i1CTtm7U169MMt6IHPh8Iorpnu8rJCIXShPuB5ulr5kUjq
         ZdXJOEjXiK3iDgs8fWUwncweksp0OADE6GVt+k7g3qzo0QqDtJFDBQqaJ0iYdnV7dke8
         HgBJVXSfHUwma46GgpuFuIIe6fIgR8YyaVNg76+j/efo0rCWK+vS0dq2SnWd7PW0U//t
         FICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244094; x=1761848894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukvtIuA2GTbBdDn1KeFlCInIvIk5c30LHz1pGa2sbYQ=;
        b=rbkdsJf/CSnpedD4avswGG1Ljlk2+D30P7JkPSIPp5fnCHVAqCGIyCeTDk+iusdiBm
         nYi8eNYwohzHNIOR+tULwvYty73OKb+ttB8L6Z5gQsoQPbIgTDW9Z76gJR71GeA1FmNZ
         GAmkjkPQM+3RT3Ij+DFki28XQWoNWBP5x8F7lqt5btVVpYcuNYg2Mw1Fbc99iZjbFpvo
         8T+99CoqtuucJZGSKftN2i191AtmsE4WtdVMo068Bhs/AGwxzQs9CevOt0GbTZLpaygb
         8mZTIwR4wmbj6M9759oU2uKs51GLbpmefgAwA5taX5Grpyz/+EZ0t4ErUn+acOOIzXNV
         0Paw==
X-Gm-Message-State: AOJu0YwH3enMU7YNKdKR2bpNUpK89klWaXCJ7EnFzLPD9ytL322mk2nv
	DiEz9ogQFT/hgRPyFoTHODWvrbRKDEPfyCSaMYAlKZmY8vvc9hYGEMbC
X-Gm-Gg: ASbGnctEuH8hkfKH5OsVz5d+M2NBnUIXDBpwYqX3s6hZPI7ZoJNLrLFSJ10L6s5X8j9
	iwwQY1Y+wP5m3qN/nbGlN5tLsMb9YAcMtZ/K4Rtw0FFciCK9AC0i/eYJu75emQ0nBf0WBRXaam6
	SmT1/c4SitcXkXz0/TdYyEokvgEXhZb4i8mUZ9KgwByblEpgqwFkS5wXIcalx1GZqEByqhiMkbb
	bOQig9VehCnjzef5EoUxEV3axT/elGZHlWxmsHanBvtD9Skfk1k/bxT9Le0nkq4NPFwbmgSAlCx
	tN+h0RLP2+BwgTbk76ihJWuCRhTwkkKztfEpfX+i65jY2+Mo7wdSt9xr59/nCJiIWEntoUuXwgp
	Pr8PXKAwBQd+PMcH8yNHiTYbadh7lWID1IkFhFMBL7tD9jq5MBlb4rH8a9nlb+snoDLkHLrZTwh
	NCqMATcFtAOWQsX7o5Nlc=
X-Google-Smtp-Source: AGHT+IGZ1uFbSH3kISIMtcXAT6m/nUhLcNZeEGyE8hNSy9KW4xwjRKfbKytlo0lhRW4rLAUXnaGm1g==
X-Received: by 2002:a17:902:f605:b0:26e:62c9:1cc4 with SMTP id d9443c01a7336-290c9c89da2mr279808105ad.4.1761244093791;
        Thu, 23 Oct 2025 11:28:13 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:40::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946de03081sm30876635ad.43.2025.10.23.11.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:28:13 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 11:27:49 -0700
Subject: [PATCH net-next v8 10/14] selftests/vsock: add tests for proc sys
 vsock ns_mode
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-vsock-vmtest-v8-10-dea984d02bb0@meta.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
In-Reply-To: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
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
X-Mailer: b4 0.14.3

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
index d047f6d27df4..b775fb0cd4ed 100755
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
@@ -203,6 +220,20 @@ check_deps() {
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
@@ -502,6 +533,43 @@ log_guest() {
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
@@ -575,6 +643,11 @@ run_shared_vm_tests() {
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
@@ -628,6 +701,28 @@ run_shared_vm_test() {
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

