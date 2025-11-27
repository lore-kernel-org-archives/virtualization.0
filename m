Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB76320A2E
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 07:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229678; cv=none; b=oC5dYrtU77DKFbmoGxJyyvYZr3oyFyba/caXiAKRpHcamzH7K6edgRTvQjctmgzIjw46jS9dnMPKJMkcsUG8+d+asU1ITUazfqbPnGPkJyKof+qNcYzFDx+tgV2AJpFgiQH6zQ+ob/yy/LmUqFOEhhxDZ+SroG0ZUgmgBS0HnYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229678; c=relaxed/simple;
	bh=F9qzWvarzspoUbvluZkW92TRtUEFCNdPtvyTfxTGneI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zv3scUii8xb53Delw2VW6mu5NDSUMx+YS1rtqdyeAl/DpT7EUlsikc7MSPBYW6FRuxvJ9BQUnBzFFfgwSHmCOdMUjKdXIGuDbuICGDcQU15iD4L+GcB5FeunlMBw4gv97flQoJ8I+w1griiKcbjP9K5Gm3XWwGEsnSTmal3NRsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btia4Nny; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btia4Nny"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7aad4823079so496417b3a.0
        for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 23:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764229672; x=1764834472; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7w0kW50AlmYUAXmX9e+2xAS4l5tTncqOsdNWYiuLxg=;
        b=btia4NnyL4THzWGCja3qprd/OEBPG0Etv5Lpht97gYVeHRiVqyA1Gevf2ckkXEkTIN
         m9/tQzM6FjMdLnBSLLoxuwhWa/LgsT0ei8hI7edS1XxXBJeKks4mTw4MhdDgi9OYcGQ4
         Ahd2DLL878H+ux94v11xtgp7HNeyqeZS6Wb2/EUljh9fT+1ApHHYOnPWYsNat+Ce89gT
         47obb1W+T0y3NUQjUyShZ4HBcq0zGFJNg7rXPyHjcAFeJVKmG9XTCs93IJksdbG/+U7o
         ENjUPc1zpFXWCM/BFO8DTW4UTS8Oi96QNbJXUQJR8A9TqmzeNN5xWeNJTIDXlGVj/F1I
         vE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764229672; x=1764834472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t7w0kW50AlmYUAXmX9e+2xAS4l5tTncqOsdNWYiuLxg=;
        b=tNesn01zc2Y0xY9R9YcXBLtbd8gRS8Jza/+bR9Xif913XpDqqemwBAGKk26BVGaIxB
         FZqAOGCccFdT5TnLV5kQBxIr7Xy8SdNkDyYM1kSeNO2tZk0dOGUbRqDgr1pEIai4rgBc
         TLq4vfH8Hp1hSv93rokXs4M8e/z+kv7W3AJIba8nmKXdGQ8h51NJNDS6UWGwUzVZNIyi
         5XXWOPa7zkenAuV1zMkkFFggXJFPhwEmMwqDTcpgi90O80bXCiIYbABZ5keB7cRXO7NU
         7gQY+5Ua+Y6pKVYgdagFlc2j3fzARovs7TvNqvh96wOGw4QDv1vYrWuwb//BWoMbD3Ln
         Dung==
X-Forwarded-Encrypted: i=1; AJvYcCU7Gp+WWNgPEm5O+HUUhmjh37DHP2jAVacOB8hUPmnSJIfhd64NG9ti5tiLHuoraEYk4kIY5ywdzo+Ve2sKog==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqUhKNzxIqss3KHTlxmGQj7gSN2e/K7akcdgiG96GmG15mcrBz
	/IKBmbGy05yZ9V4sLRp+kWiLKRG596ufu2j9DEYOFDvX4IgY7xzPWiFo
X-Gm-Gg: ASbGncueWbYyzniS3IV6alumRZFWmNQ26jCoYfe+AfvPeSckkcpdmqwZWMQMnul5KUz
	KW2z3BX0INvK9TyyVOOdPAUPar5g5F9GpvPgn8oNZr82VXeLKYqvy6jDsihLECrrptC3a4D/uTx
	co8WGJw9lVEEjXhGBIO9LSQdYo1DtiDhXE5+DA3iVmrwaYdK6CzedYS7OR6zx2iP7AtTypqJoaG
	Um/Um46s3aZ0K4oTVuxMDKy6XLbTIBjowFG1LHrq9MPW9kpT8wsomH0UANo73XQRACEXZiwK5lH
	plbx7KfhvoOb+xCJe19Xe7Q8LISsqn8KwMrHpbCXssSeximaRc5go3k8I8cg3IQeN165Rom8hlx
	psPyWr9WwUKgwI+UUmlu8iJdQKauJfVijkT+E+DPniYnFmYRbyEFfiPWgq3X02wK9E5CHWM16I2
	bQRgBXof3fOf1B3u6SwvA=
X-Google-Smtp-Source: AGHT+IGEYmtf5UyCmZLOOSPGMZMDsJ6uWauj+yI5/GaJ4MNR6NysYv4OOh6lVMxLOGQMBecx4geSKw==
X-Received: by 2002:a05:6a20:3d07:b0:35d:53dc:cb60 with SMTP id adf61e73a8af0-36150e21647mr25470206637.6.1764229671642;
        Wed, 26 Nov 2025 23:47:51 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4fbb003a1sm1063358a12.8.2025.11.26.23.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 23:47:51 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 26 Nov 2025 23:47:38 -0800
Subject: [PATCH net-next v12 09/12] selftests/vsock: add tests for proc sys
 vsock ns_mode
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-vsock-vmtest-v12-9-257ee21cd5de@meta.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
In-Reply-To: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
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
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
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

Add a test to verify that guest VMs with an active G2H transport
(virtio-vsock) cannot set namespace mode to 'local'. This validates
the mutual exclusion between G2H transports and LOCAL mode.

This patch is the first to add tests that do *not* re-use the same
shared VM. For that reason, it adds a run_tests() function to run these
tests and filter out the shared VM tests.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
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
 tools/testing/selftests/vsock/vmtest.sh | 118 +++++++++++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index e32997db322d..28b91b906cdc 100755
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
 
-readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly USE_SHARED_VM=(
+	vm_server_host_client
+	vm_client_host_server
+	vm_loopback
+)
 readonly NS_MODES=("local" "global")
 
 VERBOSE=0
@@ -205,6 +229,20 @@ check_deps() {
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
@@ -528,6 +566,32 @@ log_guest() {
 	LOG_PREFIX=guest log "$@"
 }
 
+test_ns_host_vsock_ns_mode_ok() {
+	for mode in "${NS_MODES[@]}"; do
+		if ! ns_set_mode "${mode}0" "${mode}"; then
+			return "${KSFT_FAIL}"
+		fi
+	done
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_host_vsock_ns_mode_write_once_ok() {
+	for mode in "${NS_MODES[@]}"; do
+		local ns="${mode}0"
+		if ! ns_set_mode "${ns}" "${mode}"; then
+			return "${KSFT_FAIL}"
+		fi
+
+		# try writing again and expect failure
+		if ns_set_mode "${ns}" "${mode}"; then
+			return "${KSFT_FAIL}"
+		fi
+	done
+
+	return "${KSFT_PASS}"
+}
+
 test_vm_server_host_client() {
 	if ! vm_vsock_test "init_ns" "server" 2 "${TEST_GUEST_PORT}"; then
 		return "${KSFT_FAIL}"
@@ -601,6 +665,11 @@ run_shared_vm_tests() {
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
@@ -654,6 +723,49 @@ run_shared_vm_test() {
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
 
@@ -699,6 +811,8 @@ if shared_vm_tests_requested "${ARGS[@]}"; then
 	terminate_pidfiles "${pidfile}"
 fi
 
+run_ns_tests "${ARGS[@]}"
+
 echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
 echo "Log: ${LOG}"
 

-- 
2.47.3

