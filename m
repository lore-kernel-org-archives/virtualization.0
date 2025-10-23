Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B15517A305
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181228; cv=none; b=idyWx85js/VQNmfRsAemToEZrehLcE6cBTCVImc6sAWuoaQCrb+8ABCuP9Ay7HvFRyr3ChrIcTutCVUypJ+IxUw81qTxJbrL7xNIJY+1gZ3U4g32ritah2xxjCFhCEL5f3POJOBJl16rBsy+7xfdgoRipWBXoIRl/y4iZIpb9Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181228; c=relaxed/simple;
	bh=U0+iogbO2NAE9Gz/LUnVfHwQ3vHz0eclu+dJB7jTvdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ucFpqh6Vlt1u/DV0iKGyPuY7Rm5NKfHXQZQwYSYY3/3QfVfY9R57c89DGfNbBrpgPUZEYFox7APP3Mhr568e4kdtftuUAl84kE4iQsPLZa2jxvZh13RUxk+/GgoPrkQupSMF8Aj3dcB2EBUZNbRIB0Jlaw4wGjuYeWF0ApCgFuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dq5P884c; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dq5P884c"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27ee41e0798so2944255ad.1
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 18:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181225; x=1761786025; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oW0MnMyTuve6rQX9Tu+VETj6VkCGFjnMpCoeDie56zE=;
        b=Dq5P884cxVvpdM6arLfrhKYIqvhX6/fmIjG8wx3inhh5bfVN+2tPsIVxuaTm8VrzaM
         FhvqfH3T4dSEaRoKezavkmzUOp8b4584VXT2n74YvDBUIyyGThtoD7YpmWeuBfT84ra/
         0OMkfOiKxs14RRYqnGQGf+nG5lR6MjVYpAKvfytJ3Q6yMqavpPth/2LVPYQfXd16zxm1
         30tz86mQJ73JD1IR/v6aHDLjHCpldNnYsBoSZ+rQBbeU2hOU/w977R8t6y2/g8vI5sWo
         3PTRmlr5lJP14BzAGjxr1jejxFMczo3nxILiZEfWjUKD2+AipWqSmOpLjCozrKzRBXni
         KlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181225; x=1761786025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oW0MnMyTuve6rQX9Tu+VETj6VkCGFjnMpCoeDie56zE=;
        b=cCb7ur2Nl6Ex8WFiag+xuTg+TRz7SZ2vEXC7bYIouIZmfjBbIwJ3DkwF3G3tNjsqBz
         2nChaWDOrObvRso0Ci3zbQd9iEHHJyLlyMeofBtzbnMee/UNM2yHw9Ivji22i9qDgApD
         hySzO/No5SX7ak1RVT7ZGkEeGV0mNTtxQRfq2QfTpXHPjt99OcNlEw8qikuagZasJMiC
         RFc+pjVtu/XvrXlYgQ+3Bc24l5SoQIwqtxZPAT8xFBX3qfm0ubKNgzT+X4+WXPwDA0m0
         nG1DeF6jVv+oGHcSm0aE9q/hZ3r/ksRmkgURuuTBVAYp/fOwZv/nDKyMmexxuKl0miim
         znWQ==
X-Gm-Message-State: AOJu0Yw88j4H5116oYxG8G6Ib6dL6Zkict+q5DoM8R1neMnpntz9O/FH
	+PsR+tT+fKWVLdjRz9nYbNTTOhr4gurrbQ+lI3fL5n9IeBeqQKSd9Cpz2ifZr37P
X-Gm-Gg: ASbGncszaRcEDAhF4SdXW08YYQHioQQci/VttAJkKs7dRc1xlGWogyz01sF4OWDIvSS
	KD1Bgh+4W8J0AuBJMxqOye2sJmwlhVds20fqeqtrrPbsY9NnSx4U+j/da6ZnDW2JXJPx3RYxyqY
	+JnF3gbahg+rUrTms8CfcZCW/hBseuF4hiixd5f/C3LOC/bzqOdn7OLpAyw9I8feMihR5wxUZ9K
	xkowFmAf1XZjx44xTEqRrrNivtc75Efmp7qKn27PZdZVZmAIA7Rp5MmZIxWsL/whM2qnwGYEDTb
	GpsUJ4SGDLaqR7yN9pVjFTWIpI3s9azqU6a4W1EKq54dZaWnZejNl4IXwU3YQ6yc2zytkBXY8Ja
	pLI6K3tehynECzC+PsNMtVfUrrR6AwHY1WYkY4d729cOUsa8BB3f2wfopx+3/k2tt5Fu2vgR4KZ
	kFBnZjES8=
X-Google-Smtp-Source: AGHT+IHG++8q7Kb1lCEC8iKHKpMzuHPgGkCaxiytL35YQPpXEzIYeu+Im2bo6LwrLWNlMz3x3oU9yA==
X-Received: by 2002:a17:902:d492:b0:293:623:3246 with SMTP id d9443c01a7336-29306233744mr52514715ad.13.1761181225265;
        Wed, 22 Oct 2025 18:00:25 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda86f8sm4582525ad.1.2025.10.22.18.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:24 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:05 -0700
Subject: [PATCH net-next 01/12] selftests/vsock: improve logging in
 vmtest.sh
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-1-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Improve usability of logging functions. Remove the test name prefix from
logging functions so that logging calls can be made deeper into the call
stack without passing down the test name or setting some global. Teach
log function to accept a LOG_PREFIX variable to avoid unnecessary
argument shifting.

Remove log_setup() and instead use log_host(). The host/guest prefixes
are useful to show whether a failure happened on the guest or host side,
but "setup" doesn't really give additional useful information. Since all
log_setup() calls happen on the host, lets just use log_host() instead.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes from previous series:
- do not use log levels, keep as on/off switch, after revising the other
  patch series the levels became unnecessary.
---
 tools/testing/selftests/vsock/vmtest.sh | 69 ++++++++++++++-------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index edacebfc1632..561600814bef 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -271,60 +271,51 @@ EOF
 
 host_wait_for_listener() {
 	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
-}
-
-__log_stdin() {
-	cat | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
-}
 
-__log_args() {
-	echo "$*" | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
 }
 
 log() {
-	local prefix="$1"
+	local redirect
+	local prefix
 
-	shift
-	local redirect=
 	if [[ ${VERBOSE} -eq 0 ]]; then
 		redirect=/dev/null
 	else
 		redirect=/dev/stdout
 	fi
 
+	prefix="${LOG_PREFIX:-}"
+
 	if [[ "$#" -eq 0 ]]; then
-		__log_stdin | tee -a "${LOG}" > ${redirect}
+		if [[ -n "${prefix}" ]]; then
+			cat | awk -v prefix="${prefix}" '{printf "%s: %s\n", prefix, $0}'
+		else
+			cat
+		fi
 	else
-		__log_args "$@" | tee -a "${LOG}" > ${redirect}
-	fi
-}
-
-log_setup() {
-	log "setup" "$@"
+		if [[ -n "${prefix}" ]]; then
+			echo "${prefix}: " "$@"
+		else
+			echo "$@"
+		fi
+	fi | tee -a "${LOG}" > ${redirect}
 }
 
 log_host() {
-	local testname=$1
-
-	shift
-	log "test:${testname}:host" "$@"
+	LOG_PREFIX=host log $@
 }
 
 log_guest() {
-	local testname=$1
-
-	shift
-	log "test:${testname}:guest" "$@"
+	LOG_PREFIX=guest log $@
 }
 
 test_vm_server_host_client() {
-	local testname="${FUNCNAME[0]#test_}"
 
 	vm_ssh -- "${VSOCK_TEST}" \
 		--mode=server \
 		--control-port="${TEST_GUEST_PORT}" \
 		--peer-cid=2 \
-		2>&1 | log_guest "${testname}" &
+		2>&1 | log_guest &
 
 	vm_wait_for_listener "${TEST_GUEST_PORT}"
 
@@ -332,18 +323,17 @@ test_vm_server_host_client() {
 		--mode=client \
 		--control-host=127.0.0.1 \
 		--peer-cid="${VSOCK_CID}" \
-		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host "${testname}"
+		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host
 
 	return $?
 }
 
 test_vm_client_host_server() {
-	local testname="${FUNCNAME[0]#test_}"
 
 	${VSOCK_TEST} \
 		--mode "server" \
 		--control-port "${TEST_HOST_PORT_LISTENER}" \
-		--peer-cid "${VSOCK_CID}" 2>&1 | log_host "${testname}" &
+		--peer-cid "${VSOCK_CID}" 2>&1 | log_host &
 
 	host_wait_for_listener
 
@@ -351,19 +341,18 @@ test_vm_client_host_server() {
 		--mode=client \
 		--control-host=10.0.2.2 \
 		--peer-cid=2 \
-		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest "${testname}"
+		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest
 
 	return $?
 }
 
 test_vm_loopback() {
-	local testname="${FUNCNAME[0]#test_}"
 	local port=60000 # non-forwarded local port
 
 	vm_ssh -- "${VSOCK_TEST}" \
 		--mode=server \
 		--control-port="${port}" \
-		--peer-cid=1 2>&1 | log_guest "${testname}" &
+		--peer-cid=1 2>&1 | log_guest &
 
 	vm_wait_for_listener "${port}"
 
@@ -371,7 +360,7 @@ test_vm_loopback() {
 		--mode=client \
 		--control-host="127.0.0.1" \
 		--control-port="${port}" \
-		--peer-cid=1 2>&1 | log_guest "${testname}"
+		--peer-cid=1 2>&1 | log_guest
 
 	return $?
 }
@@ -399,25 +388,25 @@ run_test() {
 
 	host_oops_cnt_after=$(dmesg | grep -i 'Oops' | wc -l)
 	if [[ ${host_oops_cnt_after} -gt ${host_oops_cnt_before} ]]; then
-		echo "FAIL: kernel oops detected on host" | log_host "${name}"
+		echo "FAIL: kernel oops detected on host" | log_host
 		rc=$KSFT_FAIL
 	fi
 
 	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
-		echo "FAIL: kernel warning detected on host" | log_host "${name}"
+		echo "FAIL: kernel warning detected on host" | log_host
 		rc=$KSFT_FAIL
 	fi
 
 	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
 	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
-		echo "FAIL: kernel oops detected on vm" | log_host "${name}"
+		echo "FAIL: kernel oops detected on vm" | log_host
 		rc=$KSFT_FAIL
 	fi
 
 	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
-		echo "FAIL: kernel warning detected on vm" | log_host "${name}"
+		echo "FAIL: kernel warning detected on vm" | log_host
 		rc=$KSFT_FAIL
 	fi
 
@@ -452,10 +441,10 @@ handle_build
 
 echo "1..${#ARGS[@]}"
 
-log_setup "Booting up VM"
+log_host "Booting up VM"
 vm_start
 vm_wait_for_ssh
-log_setup "VM booted up"
+log_host "VM booted up"
 
 cnt_pass=0
 cnt_fail=0

-- 
2.47.3

