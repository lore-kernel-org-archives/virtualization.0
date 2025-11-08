Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE48822CBE6
	for <virtualization@lists.linux.dev>; Sat,  8 Nov 2025 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617717; cv=none; b=B/HbS81EfqHY9IcvGNULTqyD+0biBnQIRh1OqEHBVnxD+1hTLxJX+ggaUS6WA3SK85nnuCtYXDKgDAFxXk+IT25b4TIwTCvzWwYh6EGluNbmO1vZ85j7a1Q6BRAdGB8SPhZWsfgKLkQr0W3wlV9pkunVGA/ustOeIRg3hnqBB2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617717; c=relaxed/simple;
	bh=eLu5JMiHu7of9BZggEGnla9HL0md05KgCo8UZ0w6Q1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d/ftEZcyPt+BYLCCFIc/5YWt3yMcEY1suxqUHoUTSB/f5saC7gW6Q6P5t/F7VMZ2hEViViML+rzbasaRz8Ybs0fwKiaNQAr+xkkaoNuVdM24mEx9Ypa6OvJxhOEAIgC+rjoHbDJtcVdBgkM9apZRQEYpKc7wGKnbFmjycDiZYPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJ41v1M1; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJ41v1M1"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b99bfb451e5so1073184a12.2
        for <virtualization@lists.linux.dev>; Sat, 08 Nov 2025 08:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617714; x=1763222514; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ld63LQM/QM5aoQNbMBPk41vQtmCfRJO34YdHJwziNzk=;
        b=NJ41v1M1QzvGWiWJN9u4ivFCDK1bhxDzc8HZzt29WouCpcAS0g3+xeoXE96NnN+oTe
         BB7EF552mRvmrA1tj0/UnixfuG5n58o/pYMyz3ubhmKKa2Yr2uL4XsLx+vvtWb99+YIZ
         M/DLT1yT+dQdFibgqCM5JQkIu95we90ohCAQY4yDvst6jLdLkPdR7mSL8xl1BNS/fMJP
         uh3w+qNtzdMHYIgOgUQ5QZqwC1kAoh1rlhAj0aVyiz+5V/167554gWy8tWwcPa2bJZB0
         Cra+FPFQgpRReV7pC4OxiMHZxT4P+OJ3LQzOOXBmNt+VjzVqEhtgOcr5jupU5nzhDXA8
         paHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617714; x=1763222514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ld63LQM/QM5aoQNbMBPk41vQtmCfRJO34YdHJwziNzk=;
        b=T6PYNJ4NdZ3Qvz+n1ka/mAaSXAske/zcSEyhiwk1z8JlAcz8CJOudq3BCzB1wMwH6P
         N0LYFF8H0WkaQMde36UvVVt1Te3vX4ipVkiXbrfqboIQyg6pQDicPmx/nVEcJ/t7RJj7
         A+hc7Q5Nbs70JNto8I4s8Gsy0UbpenjrYnaHoVHYJSHPanb2MCQcSATW0kyclRdcME5+
         XpoPgAPpkv1+Ho6hempxTiPmGK+zm+6Sj+WKVZ3yJZOlD3BtV3x+9NS+dUvqmGZFNCuC
         JaZtmgpuDJ76HzwAI29RbF8O0cCGjsWEAgw0y1NxSFqEjavv+PI0rknrGqiPo4z7bA1S
         5zLA==
X-Gm-Message-State: AOJu0Yzj1vfyjCHvXG/cyf3MANtd14HxOnpH4pwu5F9fA52D7wSbyOIk
	D4f4J0LwkHnIOcBUhw7yDb/F2pVqOZHO9s6ci+Dje2IDNZDxMe01rGA6
X-Gm-Gg: ASbGncubLRfaXxb2rN6zu8bfP5Iw98NtfXCzHgZQ0gXbOIsFZKype/YLbuH02zatiMs
	sgU7DqhGTpAtprSaoP4fKY3LE53XNM3HZzeoLulpXoYIHQg5OVrilHywKPt2rJZcDONVSHyj3/c
	JD2pQ/Nw39XXfq5+arJvPWajbfV1NoV5ps3IJ1YS7mcN6tty4b8C1N3ejnDOwuYZQGKYwtNxuUV
	X2a+E6cafYzIudkDcjPI5AYguYgCjbY4OANDwZ1OVznpxGZ4+1R115rsVziYRFi5SoV1yI0V//u
	PMVZ46rRuwS7xmpj8iNGz/b1gRFDspLre2GYRcTrtLkAE3oj+uJgASRRIRmlSgJLEdxcLUa2IQJ
	zjrGLAx4DeHyITW8gwm05u/wmvLIng1OWbLqv0feJRguE5sXD5ZQ8yW4i+fHkcfFTrQ/KuXyYwg
	==
X-Google-Smtp-Source: AGHT+IGifjrTmGVD9wlbbooqM+v0wrdw8qePPIjfo/9CbYLQnx0+xdbZOZ5/Z/0HPHNkoo96/RnkPQ==
X-Received: by 2002:a17:902:ea0d:b0:288:5d07:8a8f with SMTP id d9443c01a7336-297e5665a51mr40532995ad.24.1762617713853;
        Sat, 08 Nov 2025 08:01:53 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5d66dsm93126765ad.37.2025.11.08.08.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:53 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:00:54 -0800
Subject: [PATCH net-next v4 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-3-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
the vsock_test binary. This encapsulates several items of repeat logic,
such as waiting for the server to reach listening state and
enabling/disabling the bash option pipefail to avoid pipe-style logging
from hiding failures.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v4:
- remember to disable pipefail before returning from host_vsock_test()

Changes in v3:
- Add port input parameter to host_wait_for_listener() to accept port
  from host_vsock_test() (Stefano)
- Change host_wait_for_listener() call-site to pass in parameter
---
 tools/testing/selftests/vsock/vmtest.sh | 135 ++++++++++++++++++++++----------
 1 file changed, 95 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 01ce16523afb..3bccd9b84e4a 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -272,8 +272,81 @@ EOF
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
+			set +o pipefail
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
@@ -312,59 +385,41 @@ log_guest() {
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

