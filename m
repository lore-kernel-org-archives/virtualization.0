Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48542F658D
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 23:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090451; cv=none; b=QrurFQ4jb98aKk6BJxXrLCWGacesq+6VKOC13wfNqDwZ2rRay6OS/pX3wPUdn72QknPzwlXgcdRklndzFNILPraLtCHOc5lQJylCfsNQkJMhemnUWgIaJcfnD4drWlxOacwvxHB6qEOW11JR2ZCUC+d+QfayR4m9VV5obVIppmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090451; c=relaxed/simple;
	bh=iuoFGVXiyma5BjD4qVBCYGN/H+01qwexZAVvYObUk/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XXoDFBXjJO68m4ID/DSw7tFYsYKJFu3jSFLyuZIQv4MYhqh1zxu19xxVP35ayjHf2rQkrEbapxTdBFXFnrxZGemMOOAmUWvInw2RO4uAVfCa4LJymsQF3dCD0/VNoIXRthT7KsvrIEhtwX478k1vky1EEEzYp/ZCj5F6OwLesNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClHGM3tS; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClHGM3tS"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b6a73db16efso3883512a12.3
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 16:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090442; x=1761695242; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1mW3ek33KlnkdGQnSq6JCzqGkY1/dpZqhI7Q32Dbqk=;
        b=ClHGM3tSJIf9iuOyek2uMdUfDbjCJrjz+moMwxv5gwfhZgDTE2eXcVdd5BZ13b8DbB
         R0Vb4Evk5tS3/SdQSYu76Ur8SMWt8ZUeSjAvP1j6B+STSjdGUsb1pm21CkydGE19SFUb
         EjzEPBXHutzbZ+Vtrg1eI2WaD4PBps4figSB/lrn7OGfaZ+4YrThczBKd5U3VkvXfpmL
         3vp9GCsrktIFuBv5PNAOz24zrAXmBoiCqeoKuN4l6hk6tW6mGgYZpUaoL7Met027K5S1
         N/rVzrdLDc6Nmp6Ci+i9+sb9FmmmEJDmKcePcxBByNfOwk1HTa1L++d2qPD+6u+AZy2W
         J8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090442; x=1761695242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1mW3ek33KlnkdGQnSq6JCzqGkY1/dpZqhI7Q32Dbqk=;
        b=kW+OwgEvKq5pc45CkQKUslzAh/V7YrgSGfP7jOOX9R9wW6p/D4NEQUfJanzJBZ8rXr
         Eavqu1E9NXRcDIaPakBrIjD8l8tIrDX7zCehEWt82H/rgatkkTC2tquJModScHURixyZ
         cYNEHyRLX39d0bFGaVZhtziL/SnNhi5dq7whYIRpcZMDgQCOjP38UApQpYHndanRCzvi
         bHpbMaVz2/V1gBYVY6fObqreaXmkkk6mUa38de92Z8rI4DRa6Cv/9IGgSdJvvLDKVkBD
         wpGZCbDBrBx7MIUrwvpar6C1kkXqRdpPKu6JuZzfdC/Rn28twEq7d6JC8/H/RRNKLgdh
         TEFA==
X-Gm-Message-State: AOJu0YxvOQpCs/zHRW7pDTMFwv8EvwFzt5mY67W12gF4p+/azJtbCJtm
	uyMI4XKIq3Cg8HYbDBugPIWfwhqg1USeYm1n3VlE1/1aSxS0L9lccdkl
X-Gm-Gg: ASbGncvZESCALtOEqMJ5/HS4v+ER4HMiuyhiDDIH+ugHJyprbNHxmoJeeTHV2+PpDOP
	BbATqG1BjFPQRLQeL+JeIsMP18ypGGh0hz3Ge0cWKgkzlaQXmWVwCQjQJjCcJMWkmUqo7aWlvyA
	rjU5AU/bMKj6KS7JCDRaiputOyhVl1RWitWpHv/G5ac5+7hNkSfpO/HFDjHUPy97GzXc9OPGHxD
	BohZtmeHGFE5M8a7BumuOkWnwJQi9ly0R56oQea1Q8bZXfbL9J+jwGH2ew4PyByLhc1uT9VpIli
	KEhyivAdt0vmIqImmR8/Frl5TJOTW9m25RmTKnpMGrL7AmVfEjq3+JC6yX7pWHPj0S+JO15k7F0
	2ho4qkt1HFzAg0fwYLTgS43WYaAdk1mOofg0VaArekQwQpMecFdfN6nB/f5O9vwXLmUnnyjOAXQ
	==
X-Google-Smtp-Source: AGHT+IEnoXliC4DZTHE40VZWQCvx9ip3e2WPqCXD2akJhvJXh22fPmIW6LK7Ka+Qk8/lrzwfhc3o6g==
X-Received: by 2002:a17:902:d58d:b0:269:9719:fffd with SMTP id d9443c01a7336-290c9cf9775mr231885445ad.1.1761090442484;
        Tue, 21 Oct 2025 16:47:22 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fd8dfasm120381925ad.43.2025.10.21.16.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:22 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:08 -0700
Subject: [PATCH net-next v7 25/26] selftests/vsock: add tests for module
 loading order
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-25-0661b7b6f081@meta.com>
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

Add tests to check that module loading order does not break
vsock_loopback. Because vsock_loopback has some per-namespace data
structure initialization that affects vsock namespace modes, lets make
sure that namespace modes are respected and loopback sockets are
functional even when the namespaces and modes are set prior to loading
the vsock_loopback module.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 131 ++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index f8fa8b16d6e3..648ae71bf45a 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -68,6 +68,8 @@ readonly TEST_NAMES=(
 	ns_delete_vm_ok
 	ns_delete_host_ok
 	ns_delete_both_ok
+	ns_loopback_global_global_late_module_load_ok
+	ns_loopback_local_local_late_module_load_fails
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -153,6 +155,12 @@ readonly TEST_DESCS=(
 
 	# ns_delete_both_ok
 	"Check that deleting the VM and host's namespaces does not break the socket connection"
+
+	# ns_loopback_global_global_late_module_load_ok
+	"Test that loopback still works in global namespaces initialized prior to loading the vsock_loopback kmod"
+
+	# ns_loopback_local_local_late_module_load_fails
+	"Test that loopback connections still fail between local namespaces initialized prior to loading the vsock_loopback kmod"
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
@@ -912,6 +920,23 @@ test_ns_diff_local_vm_connect_to_local_host_fails() {
 	return "${KSFT_FAIL}"
 }
 
+unload_module() {
+	local module=$1
+	local i
+
+	for ((i = 0; i < 5; i++)); do
+		modprobe -r "${module}" 2>/dev/null || :
+
+		if [[ "$(lsmod | grep -c ${module})" -eq 0 ]]; then
+			return 0
+		fi
+
+		sleep 1
+	done
+
+	return 1
+}
+
 __test_loopback_two_netns() {
 	local ns0=$1
 	local ns1=$2
@@ -1264,6 +1289,112 @@ test_ns_delete_both_ok() {
 	check_ns_changes_dont_break_connection "both" "delete"
 }
 
+test_ns_loopback_global_global_late_module_load_ok() {
+	declare -a pids
+	local unixfile
+	local ns0 ns1
+	local pids
+	local port
+
+	if ! unload_module vsock_loopback; then
+		log_host "Unable to unload vsock_loopback, skipping..."
+		return "${KSFT_SKIP}"
+	fi
+
+	ns0=loopback_ns0
+	ns1=loopback_ns1
+
+	ip netns del "${ns0}" &>/dev/null || :
+	ip netns del "${ns1}" &>/dev/null || :
+	ip netns add "${ns0}"
+	ip netns add "${ns1}"
+	ns_set_mode "${ns0}" global
+	ns_set_mode "${ns1}" global
+	ip netns exec "${ns0}" ip link set dev lo up
+	ip netns exec "${ns1}" ip link set dev lo up
+
+	modprobe vsock_loopback &> /dev/null || :
+
+	unixfile=$(mktemp -u /tmp/XXXX.sock)
+	port=321
+	ip netns exec "${ns1}" \
+		socat TCP-LISTEN:"${port}",fork \
+			UNIX-CONNECT:"${unixfile}" &
+	pids+=($!)
+
+	host_wait_for_listener "${ns1}" "${port}"
+	ip netns exec "${ns0}" socat UNIX-LISTEN:"${unixfile}",fork \
+		TCP-CONNECT:localhost:"${port}" &
+	pids+=($!)
+
+	if ! host_vsock_test "${ns0}" "server" 1 "${port}"; then
+		ip netns del "${ns0}" &>/dev/null || :
+		ip netns del "${ns1}" &>/dev/null || :
+		terminate_pids "${pids[@]}"
+		return "${KSFT_FAIL}"
+	fi
+
+	if ! host_vsock_test "${ns1}" "127.0.0.1" 1 "${port}"; then
+		ip netns del "${ns0}" &>/dev/null || :
+		ip netns del "${ns1}" &>/dev/null || :
+		terminate_pids "${pids[@]}"
+		return "${KSFT_FAIL}"
+	fi
+
+	ip netns del "${ns0}" &>/dev/null || :
+	ip netns del "${ns1}" &>/dev/null || :
+	terminate_pids "${pids[@]}"
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_loopback_local_local_late_module_load_fails() {
+	declare -a pids
+	local ns0 ns1
+	local outfile
+	local pids
+	local rc
+
+	if ! unload_module vsock_loopback; then
+		log_host "Unable to unload vsock_loopback, skipping..."
+		return "${KSFT_SKIP}"
+	fi
+
+	ns0=loopback_ns0
+	ns1=loopback_ns1
+
+	ip netns del "${ns0}" &>/dev/null || :
+	ip netns del "${ns1}" &>/dev/null || :
+	ip netns add "${ns0}"
+	ip netns add "${ns1}"
+	ns_set_mode "${ns0}" local
+	ns_set_mode "${ns1}" local
+
+	modprobe vsock_loopback &> /dev/null || :
+
+	outfile=$(mktemp /tmp/XXXX.vmtest.out)
+	ip netns exec "${ns0}" socat VSOCK-LISTEN:${port} STDOUT \
+		> "${outfile}" 2>/dev/null &
+	pids+=($!)
+
+	echo TEST | \
+		ip netns exec "${ns1}" socat STDIN VSOCK-CONNECT:1:${port} \
+			2>/dev/null
+
+	if grep -q "TEST" "${outfile}" 2>/dev/null; then
+		rc="${KSFT_FAIL}"
+	else
+		rc="${KSFT_PASS}"
+	fi
+
+	ip netns del "${ns0}" &>/dev/null || :
+	ip netns del "${ns1}" &>/dev/null || :
+	terminate_pids "${pids[@]}"
+	rm -f "${outfile}"
+
+	return "${rc}"
+}
+
 shared_vm_test() {
 	local tname
 

-- 
2.47.3

