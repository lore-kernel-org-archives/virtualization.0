Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE362405E7
	for <virtualization@lists.linux.dev>; Thu, 28 Aug 2025 00:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341110; cv=none; b=X9t7kNL3ui4HISqdk3k/4xvqlGBOf1Jfwkir40RzGMSZTnG64uXa44harKkFPNC7EZJp4MxWZx0Y7w74JZkn7U1x6OesXbujowt2drKCv8rMwCKrbEaU1p/GVaxzc11NcOJSsdOCKuM+hmbkub6N2opyYuXHs2N7NABZ4IB5DxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341110; c=relaxed/simple;
	bh=BquwX6HjvEBxZ0NOdjFPMl3JAQrw/BuuZkbNRV5kNDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=InlnLb47pMxJ/Fkfmk6ip0GwWWhSw5txVlaAnVitHGZs70ea/Md5CLjTeRFEZmg3EakPUXCxhh7BTml4P40iFDF5zp9C2lbq378nZ1UZDJlExwnGSxigImIErAtkFvZb2Gdr/unVCqM2rDiy1M+nqd/klyLBQW78ErXn/qOnEpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxYIaEQg; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxYIaEQg"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3256986ca60so441797a91.1
        for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 17:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756341106; x=1756945906; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1YyzkIGkPcN4s/5n8XbmWu5wXR7Mhh7fBZ/cTvP3v7E=;
        b=QxYIaEQga/Ll240SJdwe2UwoGEArBr1HB6/XnCarjfs+jpNj6Flt6Uj61yim+2tYP9
         O/qQjuzuLni9v8xDwMtat6I2M9IUGkFmu+ndbY7hMvImxgdZd3gyV5JSBq7mKm7MKmJO
         T1zmE1IgEQ0Fk1ZONJnj2NVKj2xCHJuNnl5hDDzOa93xwl71tcIzoFZbQboBr58DBxNO
         OuCrFw3p15A71EwI1ifebE+caahVUyl5maG4ALk9CVjq5UDs7yZCyFkwG5yymMlnsc26
         12xL8E81fYDfAaSl8fYs6DpVMqmQpwBkz16GX895FDeI/VG1hiRN4aAORiMIVpeQ7fVj
         JNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756341106; x=1756945906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YyzkIGkPcN4s/5n8XbmWu5wXR7Mhh7fBZ/cTvP3v7E=;
        b=XhY7jeNEGLdj2FkjBelc6zSxq0N+Fd3zCecqaHRmuYpB5kuoJtG7UQPhMQlhE587cm
         4I4bSUkaqNpo7Pb5ABbxrPpF3coSbUnHtjFRowJ5jaRZL5ldxPIgPmsV4x0D49maoKDo
         0dNlGrHEXq5MjLH0xYf3G4Nfc3jdBR9RJQs6JKylbT1zJz4ALAc3v433Jh34AXUOcWUH
         MKstCRSLOy1f0U9903lYlSGK9JNvsk/juqHGB6sicmMCvKKtEXe4W8/W3AxwSak7b/iF
         7/gQjB+hA6+vA5iTjIbOYDRLuPg+4dSA/Gv1GySAjzrzvlzzccB8SPCqfU8stwt/2QfG
         9hrg==
X-Gm-Message-State: AOJu0Yz+1QiauiEetZa25myLZ2yHNQIOfg+kugCQ/HyjptbsHpY15X5Y
	xjRQm+mFh80uy4E6VkkU4LogtZozj36G4tJGvL3dpxEtqELHm0pDQBZR
X-Gm-Gg: ASbGncteGMVDk3coOlqk2w5OTFzUClRu4wFhPCBvUX6e0SLOxpyG3F3dwUvL/E9CRiX
	K6h6pP1zzPb5gK+6x/n7WUdwvvAF8uY9odS6ib31r0HtKqJmqoLkBYm/QWbFkG/dCaLMmDP6caa
	Nzizt4DfAZt9yn1o/0xJuKxXSCffoBSFol/TuStUGZ82LPKvM5uRy3OCohbRYP9cVj7nxl+ir1J
	3KvmmieUGUL9UYHmp6gAjjP+wVBwmtDxoeTG8Fg6tRh6pieifff5sZ23v58nMvOoLpLC0+BAX6a
	+sw/72jTSE6N1gYUDiLHeCZ4zAn24BJFi9k0VY7fQD1aguRm2jtYwZMeH3U6jiSAXsQN6fNmWQU
	V+Ly2w1yMebtFwJOlh04C
X-Google-Smtp-Source: AGHT+IH0iX22i5zp4tqvi0cHsT4JxA9i1Dra/FRoxR4Vn+2NrRWAtx9wzlm5+GyzO17IIEvA0poyuQ==
X-Received: by 2002:a17:90b:53cc:b0:327:aaeb:e805 with SMTP id 98e67ed59e1d1-327aaebf070mr1055603a91.21.1756341106213;
        Wed, 27 Aug 2025 17:31:46 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7703ffb9d3bsm14220480b3a.23.2025.08.27.17.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 17:31:45 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 27 Aug 2025 17:31:36 -0700
Subject: [PATCH net-next v5 8/9] selftests/vsock: invoke vsock_test through
 helpers
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-vsock-vmtest-v5-8-0ba580bede5b@meta.com>
References: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
In-Reply-To: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
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
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add helper calls vm_vsock_test() and host_vsock_test() to invoke the
vsock_test binary. This encapsulates several items of repeat logic, such
as waiting for the server to reach listening state and
enabling/disabling the bash option pipefail to avoid pipe-style logging
from hiding failures.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 120 ++++++++++++++++++++++++++++----
 1 file changed, 108 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 183647a86c8a..5e36d1068f6f 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -248,6 +248,7 @@ wait_for_listener()
 	local port=$1
 	local interval=$2
 	local max_intervals=$3
+	local old_pipefail
 	local protocol=tcp
 	local pattern
 	local i
@@ -256,6 +257,13 @@ wait_for_listener()
 
 	# for tcp protocol additionally check the socket state
 	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
+
+	# 'grep -q' exits on match, sending SIGPIPE to 'awk', which exits with
+	# an error, causing the if-condition to fail when pipefail is set.
+	# Instead, temporarily disable pipefail and restore it later.
+	old_pipefail=$(set -o | awk '/^pipefail[[:space:]]+(on|off)$/{print $2}')
+	set +o pipefail
+
 	for i in $(seq "${max_intervals}"); do
 		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
 		   grep -q "${pattern}"; then
@@ -263,6 +271,10 @@ wait_for_listener()
 		fi
 		sleep "${interval}"
 	done
+
+	if [[ "${old_pipefail}" == on ]]; then
+		set -o pipefail
+	fi
 }
 
 vm_wait_for_listener() {
@@ -314,28 +326,112 @@ log_guest() {
 	LOG_PREFIX=guest log $@
 }
 
+vm_vsock_test() {
+	local ns=$1
+	local mode=$2
+	local rc
+
+	set -o pipefail
+	if [[ "${mode}" == client ]]; then
+		local host=$3
+		local cid=$4
+		local port=$5
+
+		# log output and use pipefail to respect vsock_test errors
+		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
+			--mode=client \
+			--control-host="${host}" \
+			--peer-cid="${cid}" \
+			--control-port="${port}" \
+			2>&1 | log_guest
+		rc=$?
+	else
+		local cid=$3
+		local port=$4
+
+		# log output and use pipefail to respect vsock_test errors
+		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
+			--mode=server \
+			--peer-cid="${cid}" \
+			--control-port="${port}" \
+			2>&1 | log_guest &
+		rc=$?
+
+		if [[ $rc -ne 0 ]]; then
+			set +o pipefail
+			return $rc
+		fi
+
+		vm_wait_for_listener "${ns}" "${port}"
+		rc=$?
+	fi
+	set +o pipefail
+
+	return $rc
 }
 
+host_vsock_test() {
+	local ns=$1
+	local mode=$2
+	local cmd
+
+	if [[ "${ns}" == none ]]; then
+		cmd="${VSOCK_TEST}"
+	else
+		cmd="ip netns exec ${ns} ${VSOCK_TEST}"
+	fi
+
+	# log output and use pipefail to respect vsock_test errors
+	set -o pipefail
+	if [[ "${mode}" == client ]]; then
+		local host=$3
+		local cid=$4
+		local port=$5
+
+		${cmd} \
+			--mode="${mode}" \
+			--peer-cid="${cid}" \
+			--control-host="${host}" \
+			--control-port="${port}" 2>&1 | log_host
+		rc=$?
+	else
+		local cid=$3
+		local port=$4
+
+		${cmd} \
+			--mode="${mode}" \
+			--peer-cid="${cid}" \
+			--control-port="${port}" 2>&1 | log_host &
+		rc=$?
+
+		if [[ $rc -ne 0 ]]; then
+			return $rc
+		fi
+
+		host_wait_for_listener "${ns}" "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+		rc=$?
+	fi
+	set +o pipefail
 
+	return $rc
 }
 
 test_vm_server_host_client() {
+	vm_vsock_test "none" "server" 2 "${TEST_GUEST_PORT}"
+	host_vsock_test "none" "client" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
+}
 
-	vm_ssh -- "${VSOCK_TEST}" \
-		--mode=server \
-		--control-port="${TEST_GUEST_PORT}" \
-		--peer-cid=2 \
-		2>&1 | log_guest &
+test_vm_client_host_server() {
+	host_vsock_test "none" "server" "${VSOCK_CID}" "${TEST_HOST_PORT_LISTENER}"
+	vm_vsock_test "none" "client" "10.0.2.2" 2 "${TEST_HOST_PORT_LISTENER}"
+}
 
-	vm_wait_for_listener "${TEST_GUEST_PORT}"
+test_vm_loopback() {
+	vm_vsock_test "none" "server" 1 "${TEST_HOST_PORT_LISTENER}"
+	vm_vsock_test "none" "client" "127.0.0.1" 1 "${TEST_HOST_PORT_LISTENER}"
+}
 
-	${VSOCK_TEST} \
-		--mode=client \
-		--control-host=127.0.0.1 \
-		--peer-cid="${VSOCK_CID}" \
-		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host
 
-	return $?
 }
 
 test_vm_client_host_server() {

-- 
2.47.3

