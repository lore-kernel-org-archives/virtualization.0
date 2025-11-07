Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23532EBB84
	for <virtualization@lists.linux.dev>; Fri,  7 Nov 2025 00:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476596; cv=none; b=ez+7bN0N6eaN38LaABCoMRGhuwyJto6iZWMEUiiR8dVC5qz12exKTRlvqwt3YxvnwEOHw6iEMUdSEFiwmU1zHgk6mYux22rrTfyWyoke0Ceev7AzoPMa8lZykDax1sd+MbYwWMsJTfHsVWJBv1LV4snJ0iE09huJcDzP6oOw6JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476596; c=relaxed/simple;
	bh=dwrVGPkUKFfHciYh/BOwW5ybz1vWWecMLURQ6DmfPcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AH/zG6p5AR1x7/NPAllTE6CGA9hWFD4XA276kOOAMI8m1iziE17hWUpALZ1gmSal+cmQ7BeVIGJPfD/MIHVXYhlqeRZLuDKj6pD53/RAAjqV7txvK7ZcWwQjHDAGp+LKfN8+Mo8pBm0ndWETWs7alh3elWbq+0KuywIeVSjvxH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbwLIgxM; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbwLIgxM"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7af603c06easo250401b3a.0
        for <virtualization@lists.linux.dev>; Thu, 06 Nov 2025 16:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476594; x=1763081394; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRbKKbPo7sghLlyHK7HWRfe/WOnldFy+fNHUccLNkyY=;
        b=DbwLIgxM+cAFL3XaO6WF/P03PWBKcEyLac6KOoU8GDgt8lcH1iGEmtz0Lx7ZaxADMc
         hwon/bz/S7SLft8xzGKLp7INRBkdD8pQPYZIdlpsgNkt+GZBWaX4jOm8bnWilBQ4lE8u
         nOsxA74lGpT6q7CQfaQsqgNPKyC2gVK4GXIgoSKZFAlRevBu99chLgpbR+ds7JOgbaa7
         gZJv6eC8orSbookIwMgofdGJcmRYGerPw3NbM8H1aFQTn7C3e280kMqbsumzvCC12az+
         /MnQ1+5kRh/KoF8YhK6Z0Ht3J8mMlLIK7inG9eZ/1Rf/Jo/PQ2ymebng2Ra7WCFeUdhf
         PPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476594; x=1763081394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YRbKKbPo7sghLlyHK7HWRfe/WOnldFy+fNHUccLNkyY=;
        b=fFspZDTKjRQlmplpO4v2vjPURIIGfL9qjEDXb62o6oNmYPAYjIPElEqSvx8BgWeM2x
         dVXuhluXtvyuqBHBgq3xPf7/S7XIhegdwhZTOswZEHhhMW6L5ZJu72Uxc9TuIzVo1HiF
         7MXQRQsJMtNVfKXbO+8tKoJPZBA4vEU+34/UeYC22KN8ZqBfNzyYcscjcdF+loLWAhaV
         fjyWBqSR/y6AvZAvNlvKGLe9Bbjb1P6uS0eDwcCUxsC4b5VuMaNwsYQX1EFn+DTilCkb
         Rhs9Eo6hNSTmUkvrUHBFwwcrTWa0i+t/vzP39lwAL7sP1EJlEMWiNz3Oi33tuAhnvO1T
         BlpQ==
X-Gm-Message-State: AOJu0YzmRZrk6C1+U4SV7yzPyODeOgoGzMBZRTJb+8f83VtXP6kYpSIG
	WHsea8kBPvkDwTXwSbz6GCgC8z7oobLcHYFrfM4GKQiVD3SrVd3kOAzM
X-Gm-Gg: ASbGncsi953kcIFxZxMQ+yWu+bcGmHApHjeiQHtglMeZquDlAV0RdBeyKJrxvqqLcxZ
	Mxwy8tL+IunB2LzLGk6hb5GT+Crrx2IatB293sit75cq8YKuES/9svY2NLdxSXYAjSjaktE/8+l
	Nw9mzDvEjKyckPk4p77WSuS3igAdUvDUEgo4BgUow5hP0n5hFObiNx9CP/cPv1JF2uXxYBqqCz3
	+25PzHxKfaVQBBEo9xmsEHUL+BmwhBYeTEHCCtst+xcQ9CtYsH28IQmW8LipRig0W3XILwZNoqL
	oaySBac0hobAobqpJK9p4vByW93vBvgwCsMJNQH97NEkzcXMnh6Cf0PuuHeIJSJPv68faeXo7kt
	u642bZvsZERuSedBSLvyqinFq9ibXx8ZK8ZFz0hHSXDMjhqxhPAXYxfZ0Mjv6gT5mPrtFzDyy
X-Google-Smtp-Source: AGHT+IEbuIc5GRka/5Y9I021s/vgHn1nIjge60jkwm47qZF7uc1qjEbVWXKKl/0cBwa3wQt/WmA2Cg==
X-Received: by 2002:a05:6a00:8014:b0:7a9:acdf:e8f8 with SMTP id d2e1a72fcca58-7af6fbd5c22mr6105213b3a.4.1762476594202;
        Thu, 06 Nov 2025 16:49:54 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17a252sm869506b3a.41.2025.11.06.16.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:53 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:47 -0800
Subject: [PATCH net-next v3 03/11] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-3-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
the vsock_test binary. This encapsulates several items of repeat logic,
such as waiting for the server to reach listening state and
enabling/disabling the bash option pipefail to avoid pipe-style logging
from hiding failures.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v3:
- Add port input parameter to host_wait_for_listener() to accept port
  from host_vsock_test() (Stefano)
- Change host_wait_for_listener() call-site to pass in parameter
---
 tools/testing/selftests/vsock/vmtest.sh | 134 ++++++++++++++++++++++----------
 1 file changed, 94 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index d936209d3eaa..01ac2b7ee8db 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -272,8 +272,80 @@ EOF
 }
 
 host_wait_for_listener() {
-	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+	local port=$1
 
+	wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+}
+
+vm_vsock_test() {
+	local host=$1
+	local cid=$2
+	local port=$3
+	local rc
+
+	# log output and use pipefail to respect vsock_test errors
+	set -o pipefail
+	if [[ "${host}" != server ]]; then
+		vm_ssh -- "${VSOCK_TEST}" \
+			--mode=client \
+			--control-host="${host}" \
+			--peer-cid="${cid}" \
+			--control-port="${port}" \
+			2>&1 | log_guest
+		rc=$?
+	else
+		vm_ssh -- "${VSOCK_TEST}" \
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
+		vm_wait_for_listener "${port}"
+		rc=$?
+	fi
+	set +o pipefail
+
+	return $rc
+}
+
+host_vsock_test() {
+	local host=$1
+	local cid=$2
+	local port=$3
+	local rc
+
+	# log output and use pipefail to respect vsock_test errors
+	set -o pipefail
+	if [[ "${host}" != server ]]; then
+		${VSOCK_TEST} \
+			--mode=client \
+			--peer-cid="${cid}" \
+			--control-host="${host}" \
+			--control-port="${port}" 2>&1 | log_host
+		rc=$?
+	else
+		${VSOCK_TEST} \
+			--mode=server \
+			--peer-cid="${cid}" \
+			--control-port="${port}" 2>&1 | log_host &
+		rc=$?
+
+		if [[ $rc -ne 0 ]]; then
+			return $rc
+		fi
+
+		host_wait_for_listener "${port}"
+		rc=$?
+	fi
+	set +o pipefail
+
+	return $rc
 }
 
 log() {
@@ -312,59 +384,41 @@ log_guest() {
 }
 
 test_vm_server_host_client() {
+	if ! vm_vsock_test "server" 2 "${TEST_GUEST_PORT}"; then
+		return "${KSFT_FAIL}"
+	fi
 
-	vm_ssh -- "${VSOCK_TEST}" \
-		--mode=server \
-		--control-port="${TEST_GUEST_PORT}" \
-		--peer-cid=2 \
-		2>&1 | log_guest &
-
-	vm_wait_for_listener "${TEST_GUEST_PORT}"
-
-	${VSOCK_TEST} \
-		--mode=client \
-		--control-host=127.0.0.1 \
-		--peer-cid="${VSOCK_CID}" \
-		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host
+	if ! host_vsock_test "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"; then
+		return "${KSFT_FAIL}"
+	fi
 
-	return $?
+	return "${KSFT_PASS}"
 }
 
 test_vm_client_host_server() {
+	if ! host_vsock_test "server" "${VSOCK_CID}" "${TEST_HOST_PORT_LISTENER}"; then
+		return "${KSFT_FAIL}"
+	fi
 
-	${VSOCK_TEST} \
-		--mode "server" \
-		--control-port "${TEST_HOST_PORT_LISTENER}" \
-		--peer-cid "${VSOCK_CID}" 2>&1 | log_host &
-
-	host_wait_for_listener
-
-	vm_ssh -- "${VSOCK_TEST}" \
-		--mode=client \
-		--control-host=10.0.2.2 \
-		--peer-cid=2 \
-		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest
+	if ! vm_vsock_test "10.0.2.2" 2 "${TEST_HOST_PORT_LISTENER}"; then
+		return "${KSFT_FAIL}"
+	fi
 
-	return $?
+	return "${KSFT_PASS}"
 }
 
 test_vm_loopback() {
 	local port=60000 # non-forwarded local port
 
-	vm_ssh -- "${VSOCK_TEST}" \
-		--mode=server \
-		--control-port="${port}" \
-		--peer-cid=1 2>&1 | log_guest &
-
-	vm_wait_for_listener "${port}"
+	if ! vm_vsock_test "server" 1 "${port}"; then
+		return "${KSFT_FAIL}"
+	fi
 
-	vm_ssh -- "${VSOCK_TEST}" \
-		--mode=client \
-		--control-host="127.0.0.1" \
-		--control-port="${port}" \
-		--peer-cid=1 2>&1 | log_guest
+	if ! vm_vsock_test "127.0.0.1" 1 "${port}"; then
+		return "${KSFT_FAIL}"
+	fi
 
-	return $?
+	return "${KSFT_PASS}"
 }
 
 run_test() {

-- 
2.47.3

