Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD2F3161A1
	for <virtualization@lists.linux.dev>; Tue,  4 Nov 2025 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295954; cv=none; b=J9YfDpivCF0TRvAoF8rOMZbSrIw+nisBALQ6wXZYG4FrKjsWjvFUAilAgez2LpZP9326GCPDXNO0seg13fiyBA8+JG7eSV0hi/8/UeMloOTAjFQ98Kz6LHY/m21RAValeOQTLFzgN2KPCy6qpnGatALKLSg++iliUcRHYmJNgnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295954; c=relaxed/simple;
	bh=/8284WgqZBkmvYo7p6HbzA4BQ9SwpvVlj048Ne45Jpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tjtzxyA2A5UtqgFYoeIu9yzHWpfokFG5834TcJZW/S57MOAUn4mhTCtx2rGY0TN++oDiObkc7JHt/Vm8WVdgWXKbyv7nyGuoZpJFu8qGmfd7fuvKOZqGg9tsGcr+7LMqIcZvXxYUvSRc0Te3SQN38GdJeMaeIVfx8iBjITjQAtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a02IPxEa; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a02IPxEa"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34029cee97fso6233036a91.1
        for <virtualization@lists.linux.dev>; Tue, 04 Nov 2025 14:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295952; x=1762900752; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZp+C4CcVFJXBROG1xENTNsT1iMwKGcBzeNVL/tTmVw=;
        b=a02IPxEaAcPurh8aMooE389OwVGrXSKU2CtKm/2jMnzV3h8cwSj4ZSQK8UYxPdVXKz
         sWdkZExyGgbjvsDaHzRQm42dTbwrXPMxT6GAE6ZD5yHmsOLwVLckWXhagI1fZH0gVmpl
         Qyy3ydKMlKg5EoTaYFw0Wc/N9GP0XYZ673Vzh911/7QGMGmZFjDiHWdUuQ5uHYUJmtAC
         sfQ3fRKkq+D3aEt3eJOQO19HITHVW0qSFcExvhtAQyo+gD+T34HorDifPRqmzk0sN4oJ
         9mi0J9YMjfnEvEL8FHgaL0GBzpj/2JBNpY1auF4rNwq3Lm03lvHGQBroC/jvROhqG1O9
         8dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295952; x=1762900752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZp+C4CcVFJXBROG1xENTNsT1iMwKGcBzeNVL/tTmVw=;
        b=fE6OUhETMA20nxyroJgBUu2emVuHgWVTnBE+SP2puwHohPmEdtyTG6WZyo6vLPJ+Ry
         aTiKhiCNOgXUMwfuHsKdmrZ1dMPjmtkawR/nSy5OgUapo2o1fzmMMRsOFYkxjh3R8Onh
         wvxWvsc7IlwW3QYFFYXNTTMB2IY4J/FVLs+4lbG023fZ+9Wes60/4K0Ntuzy8fT3IdNE
         KBTgozjFcjauVGPgpjXVFGz0XEizFIBauzi0IaSYp57WnIDaK5vhEm1EpDz8h1FDIlW0
         Dtwi3xrBRMV8fx6t2oB8Ww+v1WyfaSclATHv6I/UeVGfpGYPpUVWd4xfGETlgeknqi83
         renQ==
X-Gm-Message-State: AOJu0YyEL3Km4YhR1Ckqc1CgNJp5l0NE/Da01ZyzcE/jGFasm9niwOwd
	TzDH+8mgJ6DEPlHL0+vMvzpYjEUSXqFLeM9oJKMljm4tF3+LAbxkg3ci
X-Gm-Gg: ASbGncuOusPsN4upNgOGLBZxAHGc7XnhAjho11qMpXj5XyDKjXEOHxdJR11166Fxs82
	3LdkogfUHrbOYK8+PxCO62E3bKauwr/cnN2b5M5Ij1OT6iM0HaLZCXmtnfzzsI0QPEvpbA3y0pN
	7YdELbxt0aBFLdlAVGmiehsa953uRu9UgK75E9rbHVnmgdOowiwFKsVVKd8+2+NVmcandVWZFrk
	8CXVwexxw9Fy53F6NQLj6UvpWeLmhf7e1ZGcRmV/WqxnTwb2hbXPhvLNg+RcpGm7A3rN5haqzha
	CyodFd0JDwXI9oUg0HE7NtppbiYIjIH27nYlq/+YE1w41niSQDpgNmQ/Zc8Sp3+R+GAEfisXebW
	pWQNy4G89S+oblspoJCdxDcIl5fdFbXzCWh9F3/btocj7ylUDZwW7WuzonCVgzuDDmC71JyONbw
	==
X-Google-Smtp-Source: AGHT+IHtBPG9OeMS+uLaPZ7VQjgXPmnJkhyPQNwSqGa6hD901ItTF9A+GhcbDo+Uvew9U846BuIvcg==
X-Received: by 2002:a17:90b:3751:b0:341:194:5e7c with SMTP id 98e67ed59e1d1-341a6dd6953mr825767a91.24.1762295952118;
        Tue, 04 Nov 2025 14:39:12 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f18315bfsm3432766a12.5.2025.11.04.14.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:11 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:53 -0800
Subject: [PATCH net-next v2 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-3-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
the vsock_test binary. This encapsulates several items of repeat logic,
such as waiting for the server to reach listening state and
enabling/disabling the bash option pipefail to avoid pipe-style logging
from hiding failures.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 130 ++++++++++++++++++++++----------
 1 file changed, 91 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index da0408ca6895..03dc4717ac3b 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -273,7 +273,77 @@ EOF
 
 host_wait_for_listener() {
 	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
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
+		host_wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+		rc=$?
+	fi
+	set +o pipefail
+
+	return $rc
 }
 
 log() {
@@ -312,59 +382,41 @@ log_guest() {
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

