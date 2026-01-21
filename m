Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1EE441045
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033539; cv=none; b=Qry9/WsYvEnOzM7O4kGZa0d8CAd2cL9eZcDVb8bKrjkIuDoqOGCER80zVAREB7TbCjGdaDcaoO3nURlHtlSMrli8dWFuH2oLrFEu1856b6R5B8ez/uFojsafsL/km4CEkf/3l+TVc9pJKd8xTmyknHVyNhIgyEWcbGIgYySHFDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033539; c=relaxed/simple;
	bh=FIcglHOWrEg8hIuKGpVPQi7ir3gvt3puG14NMEVOHaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C1KTmshIFKlF2/0gnQRgg9DoPD2FXNIilzgiFDPtOkmQTcH+LO2BMwJDN/IqNqcZKxip4YXsVKQjVny/yu7SWtQ9ew5k5nY51KhjVTS5VstmSDPqOoCO9C/GPW26ZjjDC1p6D1EzVsYt8pECFlVuBQp3asD+V6/IbhETV2c1ibs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHrHPSDD; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHrHPSDD"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-790b7b3e594so3515807b3.3
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 14:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769033527; x=1769638327; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CfX5aCEAXTMRHVqkeJXb/fPPli7OvyVPTLJ4OZc+4kA=;
        b=AHrHPSDDYo3eK26fNHfga/6hfoQMluunnoS9vsLJQoP4YR4aheThtQtv3RMIvQ9w1t
         XHZlSF5bHVeltoi0wRAhiqk+iK2GVA1gtcPcaB45x9O1o+fl7TkQld5qcAU3ns3JJbOh
         i7Urh7UM1q46wGHDyf9xR471PgyH2hhC+FU4ts6nj+srZjoi0zBkL7RvMrfeNgIu2pTM
         t1Q08chibUuslrohPnb1C/Y3NCnrS+5wa+6BNcka7t9Xc+25ebz98eHDtBX1Qy07mU9B
         8BGEmHju1WWO3aegs5k+ux2CN7bGWFX/KjQ7+q+OXceo7O9vlB6doyyloxI11EAn6qGe
         w7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769033527; x=1769638327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CfX5aCEAXTMRHVqkeJXb/fPPli7OvyVPTLJ4OZc+4kA=;
        b=ZGfBZ/tg/23w4HVrYncEZSzepaIlZCI4hphKGKT03SNMZOQk0MFT+l5AOKS1wJ7tja
         V9Jely2H6eZPquxTTZAGG6Ntgp+Ekxa8gP1Clun66EY7wrONeUJQuuRD+IsUWHwQdirG
         kO/39v/CcDitj3iIbmpnqo3f1Y2vikMbb0EH0oTFSuRyvihXTw/IrXWzRu2k7mnD/uCC
         GvZosdda4dZsX396vt2y5ahju011i/7LIU1gIWShIw2rx3ZpHE6W0hFh+mggQQSJgQp8
         f7hkq3h7QjTrHCIeohfbVT4yoIbijSDzem8w2BEblbStXmgM/deG/x1tB2mvYU1TFHKh
         gVXw==
X-Forwarded-Encrypted: i=1; AJvYcCWk18ztibXlGXfWknkM1Wq4m1Kd30igIo9OclwckFQxBo588XHPWgsp/RHeru6BTIWUTRuD4U8EgzZkYA/pyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxiV3osqseNUrHUbmTJWF3fEriVkJZU60QCTYM7IOhxAWk6s09j
	izlWF5K/PN5HhgUqd6zy4yAlZOABMGc/0EnvKxrp7EtF5ygc1OqDnu9m
X-Gm-Gg: AZuq6aKLEYizyM18bpxg4GbOaw74O0nQC42LylWagYIHU1/6HxRAm7DGYrH96nShBbk
	aTCIF+XHi0FMoUIB0VPiLghVJnKqV6/wcTn/RBn+EPIulLcUQ64CwDJZ82f0jPZW3pcpdXX/nQ/
	c6HwJm1QfUVBA3mCQp8Ix5RrbKbZowXo+2DJk/bblaLSixNaUFcPQ1FDYEwV9iU0UMgF8DQYY8r
	QXH3WGF0o1OR5I8IeU6K/5gKTgEO8GZturBwjqY8WRL7d9W1bhA7f1Q4rApqT+nEdAiT4q6kJWg
	XGvtmPcsUAmHyd+tBGDq1nn0gJmiNXie4vWGBmrIK+Syk0wytoA8rBZ6AGzBVVxaPD8EWuIciws
	P9fMC3whQZCWGMeqJYofzCsbMJoqIpdKufBqeBEAii+2Gzg5gi3b5xE9rZprPAr6HXnApkfASst
	2YWgoyfmMgWA==
X-Received: by 2002:a53:eb83:0:b0:646:e33d:52ba with SMTP id 956f58d0204a3-6491650f769mr12153674d50.66.1769033527016;
        Wed, 21 Jan 2026 14:12:07 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:4c::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6493c0940basm3061194d50.10.2026.01.21.14.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:12:06 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 21 Jan 2026 14:11:49 -0800
Subject: [PATCH net-next v16 09/12] selftests/vsock: add tests for proc sys
 vsock ns_mode
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-vsock-vmtest-v16-9-2859a7512097@meta.com>
References: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
In-Reply-To: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add tests for the /proc/sys/net/vsock/{ns_mode,child_ns_mode}
interfaces. Namely, that they accept/report "global" and "local" strings
and enforce their access policies.

Start a convention of commenting the test name over the test
description. Add test name comments over test descriptions that existed
before this convention.

Add a check_netns() function that checks if the test requires namespaces
and if the current kernel supports namespaces. Skip tests that require
namespaces if the system does not have namespace support.

This patch is the first to add tests that do *not* re-use the same
shared VM. For that reason, it adds a run_ns_tests() function to run
these tests and filter out the shared VM tests.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v13:
- remove write-once test ns_host_vsock_ns_mode_write_once_ok to reflect
  removing the write-once policy
- add child_ns_mode test test_ns_host_vsock_child_ns_mode_ok
- modify test_ns_host_vsock_ns_mode_ok() to check that the correct mode
  was inherited from child_ns_mode

Changes in v12:
- remove ns_vm_local_mode_rejected test, due to dropping that constraint

Changes in v11:
- Document ns_ prefix above TEST_NAMES (Stefano)

Changes in v10:
- Remove extraneous add_namespaces/del_namespaces calls.
- Rename run_tests() to run_ns_tests() since it is designed to only
  run ns tests.

Changes in v9:
- add test ns_vm_local_mode_rejected to check that guests cannot use
  local mode
---
 tools/testing/selftests/vsock/vmtest.sh | 140 +++++++++++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 0e681d4c3a15..38785a102236 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -41,14 +41,38 @@ readonly KERNEL_CMDLINE="\
 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
 "
 readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
-readonly TEST_NAMES=(vm_server_host_client vm_client_host_server vm_loopback)
+
+# Namespace tests must use the ns_ prefix. This is checked in check_netns() and
+# is used to determine if a test needs namespace setup before test execution.
+readonly TEST_NAMES=(
+	vm_server_host_client
+	vm_client_host_server
+	vm_loopback
+	ns_host_vsock_ns_mode_ok
+	ns_host_vsock_child_ns_mode_ok
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
+	# ns_host_vsock_child_ns_mode_ok
+	"Check /proc/sys/net/vsock/ns_mode is read-only and child_ns_mode is writable."
 )
 
-readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly USE_SHARED_VM=(
+	vm_server_host_client
+	vm_client_host_server
+	vm_loopback
+)
 readonly NS_MODES=("local" "global")
 
 VERBOSE=0
@@ -196,6 +220,20 @@ check_deps() {
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
@@ -519,6 +557,54 @@ log_guest() {
 	LOG_PREFIX=guest log "$@"
 }
 
+ns_get_mode() {
+	local ns=$1
+
+	ip netns exec "${ns}" cat /proc/sys/net/vsock/ns_mode 2>/dev/null
+}
+
+test_ns_host_vsock_ns_mode_ok() {
+	for mode in "${NS_MODES[@]}"; do
+		local actual
+
+		actual=$(ns_get_mode "${mode}0")
+		if [[ "${actual}" != "${mode}" ]]; then
+			log_host "expected mode ${mode}, got ${actual}"
+			return "${KSFT_FAIL}"
+		fi
+	done
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_host_vsock_child_ns_mode_ok() {
+	local orig_mode
+	local rc
+
+	orig_mode=$(cat /proc/sys/net/vsock/child_ns_mode)
+
+	rc="${KSFT_PASS}"
+	for mode in "${NS_MODES[@]}"; do
+		local ns="${mode}0"
+
+		if echo "${mode}" 2>/dev/null > /proc/sys/net/vsock/ns_mode; then
+			log_host "ns_mode should be read-only but write succeeded"
+			rc="${KSFT_FAIL}"
+			continue
+		fi
+
+		if ! echo "${mode}" > /proc/sys/net/vsock/child_ns_mode; then
+			log_host "child_ns_mode should be writable to ${mode}"
+			rc="${KSFT_FAIL}"
+			continue
+		fi
+	done
+
+	echo "${orig_mode}" > /proc/sys/net/vsock/child_ns_mode
+
+	return "${rc}"
+}
+
 test_vm_server_host_client() {
 	if ! vm_vsock_test "init_ns" "server" 2 "${TEST_GUEST_PORT}"; then
 		return "${KSFT_FAIL}"
@@ -592,6 +678,11 @@ run_shared_vm_tests() {
 			continue
 		fi
 
+		if ! check_netns "${arg}"; then
+			check_result "${KSFT_SKIP}" "${arg}"
+			continue
+		fi
+
 		run_shared_vm_test "${arg}"
 		check_result "$?" "${arg}"
 	done
@@ -645,6 +736,49 @@ run_shared_vm_test() {
 	return "${rc}"
 }
 
+run_ns_tests() {
+	for arg in "${ARGS[@]}"; do
+		if shared_vm_test "${arg}"; then
+			continue
+		fi
+
+		if ! check_netns "${arg}"; then
+			check_result "${KSFT_SKIP}" "${arg}"
+			continue
+		fi
+
+		add_namespaces
+
+		name=$(echo "${arg}" | awk '{ print $1 }')
+		log_host "Executing test_${name}"
+
+		host_oops_before=$(dmesg 2>/dev/null | grep -c -i 'Oops')
+		host_warn_before=$(dmesg --level=warn 2>/dev/null | grep -c -i 'vsock')
+		eval test_"${name}"
+		rc=$?
+
+		host_oops_after=$(dmesg 2>/dev/null | grep -c -i 'Oops')
+		if [[ "${host_oops_after}" -gt "${host_oops_before}" ]]; then
+			echo "FAIL: kernel oops detected on host" | log_host
+			check_result "${KSFT_FAIL}" "${name}"
+			del_namespaces
+			continue
+		fi
+
+		host_warn_after=$(dmesg --level=warn 2>/dev/null | grep -c -i 'vsock')
+		if [[ "${host_warn_after}" -gt "${host_warn_before}" ]]; then
+			echo "FAIL: kernel warning detected on host" | log_host
+			check_result "${KSFT_FAIL}" "${name}"
+			del_namespaces
+			continue
+		fi
+
+		check_result "${rc}" "${name}"
+
+		del_namespaces
+	done
+}
+
 BUILD=0
 QEMU="qemu-system-$(uname -m)"
 
@@ -690,6 +824,8 @@ if shared_vm_tests_requested "${ARGS[@]}"; then
 	terminate_pidfiles "${pidfile}"
 fi
 
+run_ns_tests "${ARGS[@]}"
+
 echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
 echo "Log: ${LOG}"
 

-- 
2.47.3

