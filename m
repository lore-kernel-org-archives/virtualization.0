Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B04034BA2D
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244101; cv=none; b=sdEjOvVSg40xSJO23/ldJsF/2TP2GS0WKkXDbKxjbokwOMoyA3UkKvdIPQmMMRDf1dEc/dHnfAwBYRKyBuSEMkSEHpheWwx/dAEXfgBpVqAGOtGOnPp44fU4b3uI51yXNLlRkAVo+JB6aqDa4RPlFY22dWN8dYn9R85Ti/8TYSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244101; c=relaxed/simple;
	bh=anCqqm0H2OQb9o6cG3PzE54wXEZtduJV7GSF2BMwUsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JeAYNlVDgNmP2gilp4SpWPrWEo4yHr9H7tQ1NwsCpjVqSUumEluez1LqBIWQrQr8xzCTHOyecw6ZyMmo4bno4PIFHWR7tudBerlTM/IHOyofJasJIihVP0gLoafUW7+bCGMmSv0qKtznitoIKqTkmSHtodeQvMeL8ct0mBR85W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADmC+dZ6; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADmC+dZ6"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33db8fde85cso1318256a91.0
        for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 11:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244093; x=1761848893; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yx2j8uUaCk8810Lo4egWYFk1GDSKalZa+Z2hgltzRRY=;
        b=ADmC+dZ6HuctwF2imvBl0zjPY5P+8c0l11kQTaD/eSEQk4rD4ttLMAco9g+yZmcsFL
         O0hyVSBodKpIVMs+m5541elX0ZgklMwFLOJQXQgHE2u2CRBebUKeGGuD3BNm3iokY2kE
         yFRKbOch3afAOqb0nAYdgeR54Cf6lKJbbLx4OQiss79qR/CWtneP9DgASdwWwyMCLx7L
         yVTKbxhyEQvrxB1f13CmTM4+IXmXIyRNwguMRcnIhODaYwAaG/ngk1UOQbzksf8+VYNb
         1emxn3MrtFYpILr/tIdelG3pU82taDvqYxEUb/E1eKBJgbkeVDaHtMrzGduB/TozWc/4
         3OJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244093; x=1761848893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yx2j8uUaCk8810Lo4egWYFk1GDSKalZa+Z2hgltzRRY=;
        b=Y+BCoTJUv0X6TZIjS6YOYyS3RW1KUvRc1XXfsLiFWQQnO98BB+pF8hcFQ5RjFzRHbF
         wxr5RNca9ZfhZAbpd3dotxLYfX55PqGPfUtNzQEatVvMRGuxWhSgBcYOddTPIdVsHo9o
         Xm5LaNoXA7KGaQa4eWwDy2GPoOU1W5N4IvpDYbeq/YANLeTBjxXungWwpybzswUiWNNZ
         mgYMB7v7PSmPYcy5jqDSm58cq2XOQ0qbT5DG6Udl9jWS9r4t8oo6zYoykjiSeLWVAQQ2
         1d1uQv2fbsHKwJNY8uScNILUX86qlQwlONzdJNDU6LheVkGPutFhT/K+cXVYfWZLYxRC
         zvRw==
X-Gm-Message-State: AOJu0YxppF2Kz6pBfpUr3R/Y7EMTglrnA9pG0qC+v6twW6qZP/AsY9qW
	U6BmJVr3sasXxQa208ObzjJdbytcdDtPywrdHENil+b94LqoTkZmNOQo
X-Gm-Gg: ASbGncvHK3DSjo5QYbypZetT2f3ZdY6pKxLwEhEoHcZmEaiwphXJSPjhWQlZAjnh+PM
	uStEtYu6ZTU6M3SZ2uvzZxUp/rA+InVlqqz/8v9GANzW0dbwdlVV7WnxagSgR/OvRlm/T0WeVpU
	M/+c3Hz2KhhwCm0D3+uWvUpRfEJEgoovJH9J3oUEa6iGLwtmGX1JPcqXKvsiEaG7od0thIveqTB
	+grsfU3g2Eclhxr+tX9O8AXv4h3uosb6/w7gQZ8+vzxs0Sb1G2tEHgqrADd60xcZ4YhLGaBYbbT
	YoWxXAYq0sySnxiqbeqCYmLoJsftMBA40DIBaaChiJYLk5YgGPKGlFC6Na78xos/9mh8j0XHL5f
	U0ab1JQGEhg6HKBDggpMoysENnWuPwuYhg2Bc+zq+0ITnykjcTdJwQ8U477dyHirptjSIDuWZiP
	zwAFjbeYM=
X-Google-Smtp-Source: AGHT+IEEVSI7PLtAWNEyXJZ8FHg/4Q6Y1/7c5iDEXvnzHD01A3bhw6qUhmbi6j5D7nCVkqGmbLYwyw==
X-Received: by 2002:a17:90b:28c4:b0:330:852e:2bcc with SMTP id 98e67ed59e1d1-33bcf8e6348mr33077100a91.21.1761244092847;
        Thu, 23 Oct 2025 11:28:12 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fb01c0708sm3131526a91.21.2025.10.23.11.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:28:12 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 11:27:48 -0700
Subject: [PATCH net-next v8 09/14] selftests/vsock: prepare vm management
 helpers for namespaces
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-vsock-vmtest-v8-9-dea984d02bb0@meta.com>
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

Add namespace support to vm management, ssh helpers, and vsock_test
wrapper functions. This enables running VMs and test helpers in specific
namespaces, which is required for upcoming namespace isolation tests.

The functions still work correctly within the init ns, though the caller
must now pass "init_ns" explicitly.

No functional changes for existing tests. All have been updated to pass
"init_ns" explicitly.

Affected functions (such as vm_start() and vm_ssh()) now wrap their
commands with 'ip netns exec' when executing commands in non-init
namespaces.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 102 ++++++++++++++++++++++----------
 1 file changed, 71 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 5f4bae952e13..d047f6d27df4 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -141,7 +141,18 @@ ns_set_mode() {
 }
 
 vm_ssh() {
-	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
+	local ns_exec
+
+	if [[ "${1}" == init_ns ]]; then
+		ns_exec=""
+	else
+		ns_exec="ip netns exec ${1}"
+	fi
+
+	shift
+
+	${ns_exec} ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost $*
+
 	return $?
 }
 
@@ -254,10 +265,12 @@ terminate_pidfiles() {
 
 vm_start() {
 	local pidfile=$1
+	local ns=$2
 	local logfile=/dev/null
 	local verbose_opt=""
 	local kernel_opt=""
 	local qemu_opts=""
+	local ns_exec=""
 	local qemu
 
 	qemu=$(command -v "${QEMU}")
@@ -278,7 +291,11 @@ vm_start() {
 		kernel_opt="${KERNEL_CHECKOUT}"
 	fi
 
-	vng \
+	if [[ "${ns}" != "init_ns" ]]; then
+		ns_exec="ip netns exec ${ns}"
+	fi
+
+	${ns_exec} vng \
 		--run \
 		${kernel_opt} \
 		${verbose_opt} \
@@ -293,6 +310,7 @@ vm_start() {
 }
 
 vm_wait_for_ssh() {
+	local ns=$1
 	local i
 
 	i=0
@@ -300,7 +318,8 @@ vm_wait_for_ssh() {
 		if [[ ${i} -gt ${WAIT_PERIOD_MAX} ]]; then
 			die "Timed out waiting for guest ssh"
 		fi
-		if vm_ssh -- true; then
+
+		if vm_ssh "${ns}" -- true; then
 			break
 		fi
 		i=$(( i + 1 ))
@@ -344,28 +363,42 @@ wait_for_listener()
 }
 
 vm_wait_for_listener() {
-	local port=$1
+	local ns=$1
+	local port=$2
+
+	log "Waiting for listener on port ${port} on vm"
 
-	vm_ssh <<EOF
+	vm_ssh "${ns}" <<EOF
 $(declare -f wait_for_listener)
 wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
 EOF
 }
 
 host_wait_for_listener() {
-	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+	local ns=$1
+	local port=$2
+
+	if [[ "${ns}" == init_ns ]]; then
+		wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+	else
+		ip netns exec "${ns}" bash <<-EOF
+			$(declare -f wait_for_listener)
+			wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
+		EOF
+	fi
 }
 
 vm_vsock_test() {
-	local host=$1
-	local cid=$2
-	local port=$3
+	local ns=$1
+	local host=$2
+	local cid=$3
+	local port=$4
 	local rc
 
 	set -o pipefail
 	if [[ "${host}" != server ]]; then
 		# log output and use pipefail to respect vsock_test errors
-		vm_ssh -- "${VSOCK_TEST}" \
+		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
 			--mode=client \
 			--control-host="${host}" \
 			--peer-cid="${cid}" \
@@ -374,7 +407,7 @@ vm_vsock_test() {
 		rc=$?
 	else
 		# log output and use pipefail to respect vsock_test errors
-		vm_ssh -- "${VSOCK_TEST}" \
+		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
 			--mode=server \
 			--peer-cid="${cid}" \
 			--control-port="${port}" \
@@ -386,7 +419,7 @@ vm_vsock_test() {
 			return $rc
 		fi
 
-		vm_wait_for_listener "${port}"
+		vm_wait_for_listener "${ns}" "${port}"
 		rc=$?
 	fi
 	set +o pipefail
@@ -395,22 +428,28 @@ vm_vsock_test() {
 }
 
 host_vsock_test() {
-	local host=$1
-	local cid=$2
-	local port=$3
+	local ns=$1
+	local host=$2
+	local cid=$3
+	local port=$4
 	local rc
 
+	local cmd="${VSOCK_TEST}"
+	if [[ "${ns}" != "init_ns" ]]; then
+		cmd="ip netns exec ${ns} ${cmd}"
+	fi
+
 	# log output and use pipefail to respect vsock_test errors
 	set -o pipefail
 	if [[ "${host}" != server ]]; then
-		${VSOCK_TEST} \
+		${cmd} \
 			--mode=client \
 			--peer-cid="${cid}" \
 			--control-host="${host}" \
 			--control-port="${port}" 2>&1 | log_host
 		rc=$?
 	else
-		${VSOCK_TEST} \
+		${cmd} \
 			--mode=server \
 			--peer-cid="${cid}" \
 			--control-port="${port}" 2>&1 | log_host &
@@ -420,7 +459,7 @@ host_vsock_test() {
 			return $rc
 		fi
 
-		host_wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+		host_wait_for_listener "${ns}" "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
 		rc=$?
 	fi
 	set +o pipefail
@@ -464,11 +503,11 @@ log_guest() {
 }
 
 test_vm_server_host_client() {
-	if ! vm_vsock_test "server" 2 "${TEST_GUEST_PORT}"; then
+	if ! vm_vsock_test "init_ns" "server" 2 "${TEST_GUEST_PORT}"; then
 		return "${KSFT_FAIL}"
 	fi
 
-	if ! host_vsock_test "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"; then
+	if ! host_vsock_test "init_ns" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"; then
 		return "${KSFT_FAIL}"
 	fi
 
@@ -476,11 +515,11 @@ test_vm_server_host_client() {
 }
 
 test_vm_client_host_server() {
-	if ! host_vsock_test "server" "${VSOCK_CID}" "${TEST_HOST_PORT_LISTENER}"; then
+	if ! host_vsock_test "init_ns" "server" "${VSOCK_CID}" "${TEST_HOST_PORT_LISTENER}"; then
 		return "${KSFT_FAIL}"
 	fi
 
-	if ! vm_vsock_test "10.0.2.2" 2 "${TEST_HOST_PORT_LISTENER}"; then
+	if ! vm_vsock_test "init_ns" "10.0.2.2" 2 "${TEST_HOST_PORT_LISTENER}"; then
 		return "${KSFT_FAIL}"
 	fi
 
@@ -490,13 +529,14 @@ test_vm_client_host_server() {
 test_vm_loopback() {
 	local port=60000 # non-forwarded local port
 
-	vm_ssh -- modprobe vsock_loopback &> /dev/null || :
+	vm_ssh "init_ns" -- modprobe vsock_loopback &> /dev/null || :
 
-	if ! vm_vsock_test "server" 1 "${port}"; then
+	if ! vm_vsock_test "init_ns" "server" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi
 
-	if ! vm_vsock_test "127.0.0.1" 1 "${port}"; then
+
+	if ! vm_vsock_test "init_ns" "127.0.0.1" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi
 
@@ -554,8 +594,8 @@ run_shared_vm_test() {
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
 	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
-	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_oops_cnt_before=$(vm_ssh "init_ns" -- dmesg | grep -c -i 'Oops')
+	vm_warn_cnt_before=$(vm_ssh "init_ns" -- dmesg --level=warn | grep -c -i 'vsock')
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -573,13 +613,13 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
+	vm_oops_cnt_after=$(vm_ssh "init_ns" -- dmesg | grep -i 'Oops' | wc -l)
 	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
 		echo "FAIL: kernel oops detected on vm" | log_host
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i vsock)
+	vm_warn_cnt_after=$(vm_ssh "init_ns" -- dmesg --level=warn | grep -c -i vsock)
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host
 		rc=$KSFT_FAIL
@@ -623,8 +663,8 @@ cnt_total=0
 if shared_vm_tests_requested "${ARGS[@]}"; then
 	log_host "Booting up VM"
 	pidfile=$(mktemp $PIDFILE_TEMPLATE)
-	vm_start "${pidfile}"
-	vm_wait_for_ssh
+	vm_start "${pidfile}" "init_ns"
+	vm_wait_for_ssh "init_ns"
 	log_host "VM booted up"
 
 	run_shared_vm_tests "${ARGS[@]}"

-- 
2.47.3

