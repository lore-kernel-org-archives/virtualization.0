Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F78F2D9EEF
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 23:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090434; cv=none; b=gO/q9xCtkHHOkXmKBu5JGBUOnSqVoGTRI2JCCbS0eadtq6KWlHOLOkKjd5vwrDpvSetLwcY9heORM9bgv38vkBKoGazjmNBoBj0ezqExbuvG/w2flDmAy+w3mu/pqbtwzLx6WbSDAGOKbYn5WhzWDmpL0/jiWQ4wRDymRNi8zz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090434; c=relaxed/simple;
	bh=bLgJRj0B3l4I9LRxTwg4ipTz6i5xRpftUXJZZBIn7VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oKtMMjZGK/D7iy5SZ4Bpw4PTltnoK3d4VXA90OxhwOCG1MxuT+NteqxVh/jwhhpvI7Kb8xsW+bTRewvuquMLmXYtEX6asJnkYtvG9sphki/jvs83AwrSDMZUxBDKcUGHQ4Wv6j9WhzjYyDlUEW423wyYsOfwggUYJJMEMrSF4yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPAFNqWN; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPAFNqWN"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a213c3c3f5so8063045b3a.3
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 16:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090429; x=1761695229; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysnAf5Q6/F37oVxnktahtq8MWGwMsYn3elO8YpXbx58=;
        b=bPAFNqWN4205G69bvZTQoj8QH5S0BF3t+G1+GKIhyxas5qI4cVQOa/5gt5srwcsiBL
         szpx67cD2q0ifyxsQe/UgkIXVSnCtRAIfa5QNnyjjpihjAilrBCUMgybZOb35vsr3sVO
         v+W/xhYFVyhMn/LL2iwSXiNfCxjVbXrTZBrpsrOjtaeMlpulX8FZCkzRrJU2hnln4nJI
         5RSTb2HzIun5EHTxX1AdckaAzw00Hy1GhsM+FFHIxyY+2hLhYWo4Cnv2ONHrwH3Hy00j
         PrzEViQd39kpS+JVTCsA+wFB4fsW+FDVM9U1+1WX0olN0GnzjdGLAeXy6ltjqFIi34Mn
         eaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090429; x=1761695229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysnAf5Q6/F37oVxnktahtq8MWGwMsYn3elO8YpXbx58=;
        b=im8rXonfFhpjy/d0BvfzGMqwITz25kLOy6PEOCCmaqaGZKt09qpEFOm/mFSV9mfeuy
         eo6q6W6IaRIJk7uvXiEg00p7evjE2iJAlFq43Y1J/3gsFcSK/kWqtQxLu9ERoA3XJDME
         QsJvgwsoWfCIbACveZtqkQ+6tef/tSU8TqpxnT9ePBfwqfeTt6aFYDguYLjPS8nM25Y4
         0rHk3YiSwgmwWckyUARkdmpuZaLN+mh9SpB8qtEAJOH33X3htdRk3SgKTZBXzZ68zz22
         UmrLlzKlILfc1N34SI6uP/AqWBfwtaqGp4j31yk9BU5tTepvEs7aMcquv+VX3L0HMiNc
         GpTA==
X-Gm-Message-State: AOJu0YxatgC4O+6GxIDU6ToSpdmZ81XpnI3w6og0PE1ACkKD7U80kJDS
	nmyifw7DgaAW4UFDXeEnhwuMi/6JD45ZS0XPHpfB/Cud9QFx+AMstSpv
X-Gm-Gg: ASbGncvDZZ7RkXpWK3HAsanZC+68a5pzlnhKXT4oW+OHIs6PvRlnQ6UCZtmxSM6R+xs
	/AIE9y4wXZdWHYW2cmTg1Xfo+PPoLKj/EVP6c3XM7N/BS8cj50ngfgMIFwaPSs8arldD+s18ObP
	1sKAkjQlfIdP1X7kQUMqJLBTKaUGLcbR8c+B6j7L/KzC/chQTRdKkJSoTa+LYvg/JrRuMQh259i
	jeYOTD/k888Z1TX0gScxX9+iXmGotVxfl/LJB8EWgb32X6jjH5zzwF6r8nUHWlDoLXfA4DgRx9L
	RyM+IxZqVERGJES87Zgj5J/s5IiBdwy8naewPftS/t0+vMxq9NgZPKe0XCbluBzZHZeQaPstjDQ
	jXvjqWqp7QuywcfNan9xQI2MS9017ZPtvwfColr4bD6Owz49YoDU49PJ+F3TtbikuELnVzlId
X-Google-Smtp-Source: AGHT+IESeY2Sh9LyXvlNWSBcoIwZ1r/2aMHLIXNnNKYEULemMRlMzJHh0W4ok0D91ZgsuVhYMMaokA==
X-Received: by 2002:a05:6a20:1611:b0:2ae:dee:4ba with SMTP id adf61e73a8af0-334a85bb208mr23055148637.50.1761090428628;
        Tue, 21 Oct 2025 16:47:08 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff5d76bsm12490315b3a.33.2025.10.21.16.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:08 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:53 -0700
Subject: [PATCH net-next v7 10/26] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-10-0661b7b6f081@meta.com>
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

