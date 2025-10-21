Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC482BE653
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 23:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090439; cv=none; b=XK7rRKoMRRH/IGLbf4r69zorS9BMfgKLcO9VJqkRT3r9WP82lwod5fDcHoIKZcjXvWlpIx7msEk4Ven/Xyb73gNRv56X62pnClne1oQi+N8zsrJ2lGxmLrBuTVhKZXEA2gRBF7W2aeGyV4tXjkkdPWn1CLBs9f7q9o1ylxcFvuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090439; c=relaxed/simple;
	bh=BO9LQWlKtI1shvhDlqPu16W9qVY6XwRMkI/EUMrjZE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GGvAhjiSRjx7Swk9HVb57zPpFYfQ4dyuxk/I6wPlkJjUvgZ2fII7o2nJnqIhNfxRyOrWMwsKIhQQ9Gte6k1Ixb3NRzOnWeTotXov7ZhVnNXR/0csrxmHhVpDuYnYVBQkX2Reo9a8iDigGw43E8Sv7XMpB7uhus/uV5ZtVvO8veQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6Rx8pxz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6Rx8pxz"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-290dc630a07so33209325ad.1
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 16:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090433; x=1761695233; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUo2ea9cpuDIObzkB+5zIj/xuLOHXIXFOy7ynypiC8o=;
        b=P6Rx8pxzXDdzH4cEPjT/ZJHjhzOHwKbcdQ2n4z5wwgcm9ltrcFHZGBAKqmWmP4oSgc
         ISymPJC4JA/24AHZvqZDsoBNfZPqbzsVNYRnjHClHs7tmh3wpbcFOqyIDDpdZM+JOpRa
         PyZML4PjmxIlAJ6VCPOtP66J5Y40YXHFpnB8YTFcuPntmpD9lgdTzQwwp4wgdGgEzB0t
         jok0cj/toi3lEtdc29SIC+/gpndHekGQ3OztSs/vW2hvZ5a/64g+zR+6JQcbklArC4or
         M0SmdxsnMlGsB5z7el4ehvdomGbL4zmTaqfm3GFJSOTHl83GwoDiTucqGTi+VmSQat+f
         IibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090433; x=1761695233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUo2ea9cpuDIObzkB+5zIj/xuLOHXIXFOy7ynypiC8o=;
        b=bP/Fs8xvO5lj74WODbz8haGErF03hfHMNywUL3ClLAxv2G96Ub4dNgfkbWoGVOk3vJ
         A2bf6QDfaXdWRgztacks1q1xTpAOg4je9btdTP1dZMSCwP4PN0Bks2q41A5ahkjGczzu
         VskJoelK6VkI7N7sLQ9iqoZ2UCZk+Z2LuFikLIkflqNvEns+Jnoi2cyV8ZAMGt/5raf9
         FpWGUj2pQqP+KEA36YgUvD1BVSE86TIIpB2U6bDlQojg9z5xSkk6vt1T06KucwaT0hsS
         YxQZFzP77PGqRqcM9W0KKdAPdk8cKw3Yhe4ZfQ6ZzxHK8xSFqDg1KkCSJh1svCHBxdqy
         AQRg==
X-Gm-Message-State: AOJu0Yw5YlDsmw+lpprXVMG+UT50Z31oVB6Q3CGCcfoSP7Hn+9aZnWvb
	ay6w3N0RkAyh/zgh9YW93akccr9lNDsQNRYn+gt7n7IcnY08KC82VMlQ
X-Gm-Gg: ASbGncuDLfo6Y9X2dQfqPPXnQucUMr5CxeSkhx9T5C4JVMFuOPtuyIRXOaPqf3+MoAN
	99jv2Grpfx2EBypQHl7/JQ6krSPSv5EnZgG9M03X6Brb9/UwJLi1FSaurQVpbalq4M0vXxnTaAC
	iaQKEjwp64U6tV1TvbwETzq/jMnKWKndfxnsO7qHcnurNqiwVAatht6QUDqu7SV1icStpsi86Br
	AGHr4WGacNCVyzYMf9DC0HnxAqTHX7ie3tLdfmVA4oSvE6D8LACwT2r7hXcO1RiVQ9j/L6gI76Q
	OLbh8+RRnaAGO3thPWCVGFY4jkQNCvfBYbfUmxhgAOVoW4SoMxH2UTA6D+4KPGfIlnY552Lr63n
	7TswTeoJ03kCJEZ7ddX4gI50/UN5Q315Gx+aDx4YzGHR7LexIflnHTeCqwHtsXScU2541MOqpeA
	==
X-Google-Smtp-Source: AGHT+IG4mF21y9b4ILzi1VUa6/N8UQb6jbaApizlergIx98zJ8IQeCKiZxAt0HtWfKk/EMQPlOy3Uw==
X-Received: by 2002:a17:902:e944:b0:290:b14c:4f36 with SMTP id d9443c01a7336-290cba4edaemr218306105ad.31.1761090433298;
        Tue, 21 Oct 2025 16:47:13 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a813d4766sm9627762a12.5.2025.10.21.16.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:13 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:58 -0700
Subject: [PATCH net-next v7 15/26] selftests/vsock: identify and execute
 tests that can re-use VM
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-15-0661b7b6f081@meta.com>
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

In preparation for future patches that introduce tests that cannot
re-use the same VM, add functions to identify those that *can* re-use a
VM.

By continuing to re-use the same VM for these tests we can save time by
avoiding the delay of booting a VM for every test.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 63 ++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 5368ec7b1895..4ee77e6570e8 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -45,6 +45,8 @@ readonly TEST_DESCS=(
 	"Run vsock_test using the loopback transport in the VM."
 )
 
+readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+
 VERBOSE=0
 
 usage() {
@@ -454,7 +456,44 @@ test_vm_loopback() {
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
@@ -530,23 +569,21 @@ handle_build
 
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

