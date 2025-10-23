Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6704E1E98E3
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181230; cv=none; b=SJwqDrUd5nHNvRDIKGpVZSPoXoCWEJNUMlLY7hPu4Sckt4baKQ6TT6h6+x3iXdhTxwBgrW0jUGrDDFb9v4NI0gYjwphiIXOLOTlpqfnwGIbNyjL1GWOwJ8HSg2zA/la+fUa8BQGM26mC3jJVVzsWQb2nUhbVHwwQxriX56l9vuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181230; c=relaxed/simple;
	bh=bLgJRj0B3l4I9LRxTwg4ipTz6i5xRpftUXJZZBIn7VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ldQbm2trp/oon/7BDsRV3BkQ5Bf9CgblOpv639wI5R0v/JbnioqTBa++ZpHbCd7LMsZp+BZPcQh49W9h3S8E2fxC332wN2PC41hyDDpKRYaqgIUBtNzPDMRYgRM5PBCj7UlW9dzMpD2ExuUAVfaE+OMmEJHE5DZopMd6/7UM+Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4wwb3he; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4wwb3he"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a26ea3bf76so320106b3a.2
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 18:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181227; x=1761786027; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysnAf5Q6/F37oVxnktahtq8MWGwMsYn3elO8YpXbx58=;
        b=Q4wwb3heh+AJUTNwQhb9hsJ6DH31/ppMyQ7a3QNoIeuXB0+IGKJ9CmECxm/iahP6Hz
         PUsTS544TcQXjxD3IgcLPZdQE0dBbfo47nNJKCzyi26/OtxrF+tE4EthkA/CyDz1t/Pr
         KB9/rsa5uGAdxAs1agEI8RGSwwRXLQfdQWLsWwpKkgrraVRqunFd+rfCm8kXeRUW74SW
         0sY4Ky5TLqZE00wkQd3TY6aPkc11k3zeUB7Rq0SN0BC1qvZt/mEgHOkf+xfUzT085yt8
         +pOimcXVN4uQ6l3mDs1Ldd3+SRB2iUxORR72gfbMJpxF5Tjsr0KfKKLQdkeXFfj2ka0O
         +1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181227; x=1761786027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysnAf5Q6/F37oVxnktahtq8MWGwMsYn3elO8YpXbx58=;
        b=i21vd+s3Y1P0YkYRq35UaTtfm2Qt+bTD7qiwBvRIKHR1X3SXhMuYpKpkjpJS3JVM7O
         9wIjdd5+2kaOvKytanYaTfzpfPhhaisNQnin1HstBtTKQ6uf6hrJ1H5QodESTl0fPuHv
         pf+RmD0p2wKGauYdo4fNRC77v+pVxx6vttGz//PLgw6J15UjdAt8irzRcN04HAdS31g1
         S5H5CzntAaKqoomD97uw6oBlBoOf1OXdoDnci7OPb7/6NuftfKmfqPpu/4lBVdUJEuHA
         tr3gweZ9LVn0BXI0TQGV9jF7TGq57B7sCfucQWYcA4avx6BerI/YatmCAA2cVGk+oAkG
         lePQ==
X-Gm-Message-State: AOJu0YzHXXD9pTZVcQ7AdZxQLsqtm7GHBkxooxyWa0PbwqHjO1IioJ3M
	Kv6KwmoGdRO45BH5JAcKsKoWgDWNa/57qzoGMZovDEq6bhLQ+ISDfS9gI0azuirO
X-Gm-Gg: ASbGnct2wfMOvixfIm9xqSEjAhULldDOjhoOVOe9gRuKBdXTED6m+e6n4fJu6L0jxX+
	vfZmTWyF6IuxgZ400eNudcodT1IEDLn4uCFEM6hgCXs8YTTj97UW+w9ch363YZlubE/pPtrhCJd
	HEbs+PeV8QynfFbO3S+8U+ub4Mb3CPCHLHzDkEDHVKFlE7D2/GDEC2LONP/gJGFBHjB85Ic3iAI
	SqcIgJVByPiKGS+cZh1glmlGkrYZWaISZoBYMZDKMpXNdfEfSzs3hP2DPrxuDO1Hzy/sNmc3OL9
	4IA/cbhbbk6gVAq61nNyvGSR4uwtbvWjuR/LmQk0MCbYh1Zeo7Owp+fn97OwEa63dbUp71gPeH7
	S0MhHFpbwG9z3fS8l6J8eTiRDs0ta6iv4zsIlpJKQBJ0s+gIG6M+EhH8ULO9JI0qlDIBBnD3BRa
	ZUdjq19l4X
X-Google-Smtp-Source: AGHT+IHOazPmZapnzVoec11my1SEQGOMvfwZs/K9HZJGzOPAxbA0ZzCZ6eN45sS9QYFtvW0q4Wovgw==
X-Received: by 2002:a05:6a00:4652:b0:77f:11bd:749a with SMTP id d2e1a72fcca58-7a220d2330amr21377015b3a.20.1761181227244;
        Wed, 22 Oct 2025 18:00:27 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274abf6d5sm563573b3a.33.2025.10.22.18.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:26 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:07 -0700
Subject: [PATCH net-next 03/12] selftests/vsock: reuse logic for vsock_test
 through wrapper functions
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-3-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
the vsock_test binary. This encapsulates several items of repeat logic,
such as waiting for the server to reach listening state and
enabling/disabling the bash option pipefail to avoid pipe-style logging
from hiding failures.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 131 ++++++++++++++++++++++----------
 1 file changed, 92 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index ec3ff443f49a..29b36b4d301d 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -283,7 +283,78 @@ EOF
 
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
+	set -o pipefail
+	if [[ "${host}" != server ]]; then
+		# log output and use pipefail to respect vsock_test errors
+		vm_ssh -- "${VSOCK_TEST}" \
+			--mode=client \
+			--control-host="${host}" \
+			--peer-cid="${cid}" \
+			--control-port="${port}" \
+			2>&1 | log_guest
+		rc=$?
+	else
+		# log output and use pipefail to respect vsock_test errors
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
@@ -322,59 +393,41 @@ log_guest() {
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

