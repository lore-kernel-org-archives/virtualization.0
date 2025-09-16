Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64052F60C9
	for <virtualization@lists.linux.dev>; Tue, 16 Sep 2025 23:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066245; cv=none; b=p1mMos+cYnAGSkqJPnCnyHNIbacunsMXcMrA1ZGj7xAh9h/AOb9IlH9YG0sWSG2uuoSKy6PfHDUxSPqh7ConZgJU4xqWmswiV0oh+lLSInOKDBwRMvfn7fRYbbvfftPbQQuR7VLmg9mEkE0/uvcnUMNUhFLFRXDkzDsU94RKUHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066245; c=relaxed/simple;
	bh=EcIbGeQZlwbG2n3LwrGpP4mEJH5ftJ79PCsbYjs89dI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aTXOwrAScF1Z7aJARIm9lM0DEuQpCWJtsKEHE9o3JZLnQYFXcOUee2be7T1WTqnOldeDEKJ3sYOSvDctIYWJMNmXmom7NWFErGa1e2kUz6kxjPoRcqVDLnK3ksQkh/luLGzRVum9bjSpmZcj7TnhgLGfpJI1GJ+TgaBgF1TVrAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0xIW8gY; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0xIW8gY"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7728815e639so4256254b3a.1
        for <virtualization@lists.linux.dev>; Tue, 16 Sep 2025 16:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066242; x=1758671042; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2evao2yHguRL1K3LeUb7zk3K6u4tPHmAj2zWCiTI2M=;
        b=l0xIW8gYO2WB/jxCA2/n4GjJ2LqrFJa9jWVfLxUf05WqNXVTrhYj+q1e3gZvKPzbMv
         g0HdaXux9GF37fu1xUa0JTrofjbPTS1ClgWPPRAw1KbXm04zuhbB5y3/qXoYTPCcuucJ
         pRTkhRCeZPP/ARRdSfkp9b0mx58ynb4JK2vQZmcmgf+Y2tmaik6CBSMZRHST/71rNLa+
         e0Kxb12oAWT5GCwQm/L0NvhNhZnhgKq9l4PPG+dPhxVNIRc9R5lPR9l0SlC1sq82x8OC
         4Ux7relsZIPmF00PeJh307mMXNhR1GHBSpTH7kgWRMZubTHyNiifYW7TzI9IlrHJjFeh
         tDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066242; x=1758671042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2evao2yHguRL1K3LeUb7zk3K6u4tPHmAj2zWCiTI2M=;
        b=bCxbYLZDd4CBI4aMqSIDdHi1h2F1zM3ltP2/vbGbYe6aEShOQMgXqNvAyYMsw0Y2ZF
         EvcOYgYDj0VXLBKOdNRmljrTQKSVJhgdujk1OqbCqXN9Ktqh1+Zyc6Ev8ygfHzYURt7C
         kpVD0h3U8FZQL0Hf9kIUw1SthqYcFRX81SGn2QY7YG/UKL6O0GKbdeaBarlo5ugz9pPi
         blgM6wUsaBq3v8bWXnLxh6gzHg+7Vqd2wkWTx6kqjI+VsSLRgI46nfcP3BoImOH49Wpa
         V+K0GzFQnWHTNcLSXoP+36JtHMfHmVqyb6ks9oIZn9AZp9Za50iFzbPhxpo15CnUvhDs
         xZvw==
X-Gm-Message-State: AOJu0Yxzh1BYI8CMBb9jTj0Zn3Z8P6o6b0lKsc89MvoSrIoVWYaVavl8
	CIUAIYp5KR/VkAAJ+vSG1G8XbN73BaEvFFc1fqirBa3bWpZO1Xt4ap1Hb8QQ1ToB
X-Gm-Gg: ASbGncuNb+utjrEvrmWgZ05D8OLK0wWqC949SUxuhncWqXrN3MrEPRUgt4kUccC07MB
	svgA/KgXX5V9ZZaVie9Qcmnif7rvcQBM3GGj6SJyNMvYp9hENP8K9xld8lsA1arVE0peHf5hCRl
	aL9Ajd1FZgYO1YOmbK45RMo6d3CH+MAiXzeqJXbrnBgK/AkLjrVwV/UZR7wCoVqUupd9aOSe2+g
	gVG/MpUSLC0kXSTonV8p/NUcs6grXhRGL3ADJs6E8fLAQvCCtvY8kY+hr9acznY1GTtrGm7IXmt
	lam9avclBhLw5aF2YHhg8pHSEkPiEhjvMh2gfTC8H0uVX36KN9VicMXbVky+KbIyhdY5i/ZzvOo
	0TQ23yCpU4/I/Ggyw
X-Google-Smtp-Source: AGHT+IFnRN2kqEQWg3F1ajCbRwtqkrji7IA+bfyA4M8oQZqQSHuWScxk3g9jwjuxm36IJwivZampNQ==
X-Received: by 2002:a05:6a20:7f98:b0:250:f80d:b334 with SMTP id adf61e73a8af0-27a6fdc4458mr89552637.0.1758066242210;
        Tue, 16 Sep 2025 16:44:02 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54dd63d5e5sm3149345a12.4.2025.09.16.16.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:44:01 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 16 Sep 2025 16:43:51 -0700
Subject: [PATCH net-next v6 7/9] selftests/vsock: improve logging in
 vmtest.sh
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-vsock-vmtest-v6-7-064d2eb0c89d@meta.com>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
In-Reply-To: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
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

Improve logging by adding configurable log levels. Additionally, improve
usability of logging functions. Remove the test name prefix from logging
functions so that logging calls can be made deeper into the call stack
without passing down the test name or setting some global. Teach log
function to accept a LOG_PREFIX variable to avoid unnecessary argument
shifting.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 75 ++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index edacebfc1632..183647a86c8a 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -51,7 +51,12 @@ readonly TEST_DESCS=(
 	"Run vsock_test using the loopback transport in the VM."
 )
 
-VERBOSE=0
+readonly LOG_LEVEL_DEBUG=0
+readonly LOG_LEVEL_INFO=1
+readonly LOG_LEVEL_WARN=2
+readonly LOG_LEVEL_ERROR=3
+
+VERBOSE="${LOG_LEVEL_WARN}"
 
 usage() {
 	local name
@@ -196,7 +201,7 @@ vm_start() {
 
 	qemu=$(command -v "${QEMU}")
 
-	if [[ "${VERBOSE}" -eq 1 ]]; then
+	if [[ ${VERBOSE} -le ${LOG_LEVEL_DEBUG} ]]; then
 		verbose_opt="--verbose"
 		logfile=/dev/stdout
 	fi
@@ -271,60 +276,56 @@ EOF
 
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
-	if [[ ${VERBOSE} -eq 0 ]]; then
+	if [[ ${VERBOSE} -gt ${LOG_LEVEL_INFO} ]]; then
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
+		if [[ -n "${prefix}" ]]; then
+			echo "${prefix}: " "$@"
+		else
+			echo "$@"
+		fi
+	fi | tee -a "${LOG}" > ${redirect}
 }
 
-log_setup() {
-	log "setup" "$@"
+log_host() {
+	LOG_PREFIX=host log $@
 }
 
-log_host() {
-	local testname=$1
+log_guest() {
+	LOG_PREFIX=guest log $@
+}
 
-	shift
-	log "test:${testname}:host" "$@"
 }
 
-log_guest() {
-	local testname=$1
 
-	shift
-	log "test:${testname}:guest" "$@"
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
 
@@ -332,18 +333,17 @@ test_vm_server_host_client() {
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
 
@@ -351,19 +351,18 @@ test_vm_client_host_server() {
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
 
@@ -371,7 +370,7 @@ test_vm_loopback() {
 		--mode=client \
 		--control-host="127.0.0.1" \
 		--control-port="${port}" \
-		--peer-cid=1 2>&1 | log_guest "${testname}"
+		--peer-cid=1 2>&1 | log_guest
 
 	return $?
 }
@@ -429,7 +428,7 @@ QEMU="qemu-system-$(uname -m)"
 while getopts :hvsq:b o
 do
 	case $o in
-	v) VERBOSE=1;;
+	v) VERBOSE=$(( VERBOSE - 1 ));;
 	b) BUILD=1;;
 	q) QEMU=$OPTARG;;
 	h|*) usage;;
@@ -452,10 +451,10 @@ handle_build
 
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

