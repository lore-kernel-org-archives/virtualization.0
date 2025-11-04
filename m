Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E03313534
	for <virtualization@lists.linux.dev>; Tue,  4 Nov 2025 22:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295952; cv=none; b=kY/WzPevu50X23s0ctdtWmi8Gv2lsa9WubVuRpD4On2tSE+OWtvdSvpWB9FaD/8mZMRofSdWDB3C4UvzfGKz2d/9ZJoWvN4hlxkJlqv5FGWa1FeNry9JKaC6tEfGozMQuzoam8IOA5SDqrRrP0DPm3j15MvKwS+gMIewKTs2qF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295952; c=relaxed/simple;
	bh=d0lXSaAPV1hSCbv4riJfsbPBoHPeUelaGN5Zg0VyKzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ls/fcbbdXraLaInT+yNtNkWdy2+mr+taH5D5aetl6eRCTj9SEkYOSfOpIP9z4dxijieMdTEwCJ41yPCWs3Xpsy3+PPQZt3RXk+SX9850vG+8H2QMcF7uIInl1d+tp4lJSZqkBZa5fskEOLaEIq0FmmaeKmqRZyOrk1GO2+ZONE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYN3/Gd7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYN3/Gd7"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2947d345949so54346985ad.3
        for <virtualization@lists.linux.dev>; Tue, 04 Nov 2025 14:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295950; x=1762900750; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8SCnFxkAKvo4bMRASv7XIHpGepGtL4M3i1ZyZegDajE=;
        b=XYN3/Gd7FLq/Mj6fT1xtQ5Blcfl35XyjMfRjD9AspzYVcjAvrgwidV7jxgRU2X3Rl2
         HM5U0BF1kjUZuYbxEq3zZwXLr7+JNdBJiJz3P66WwnqHBZESI2059IBgFeiaKPBPXXZQ
         IfK/4XyJDp/F+LikGLFeCEVXWeXhvT2TS+eXGq1aLVsK+OOD++JSalXD1GEAaVCDMnBS
         xLfw26pJMFEXT4qMbL2RXVCRRUGQCEgKJrbAJTCdtiBx79G22rLZei8XHx4F/BPxZhcZ
         anxFmqDGm7t2ormxA6xKpdNX0vqWhevRH0oz8W3P33WlLCG2upaz1yMpxBFO3p0n1XYr
         43jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295950; x=1762900750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SCnFxkAKvo4bMRASv7XIHpGepGtL4M3i1ZyZegDajE=;
        b=OuTmlLjJxbJFBKwRIvTja4xGVOkn3HK7WEVFVEI2HuzJ/0W432P1V8SyQY+eO9a2k/
         J7X18/m+/StfRWK4ZGjYbp3EDJl7HMImyAIW1JDRBl/uhGMXc6inVo1MCbdx17nxUY+m
         PQjAGGLVFp2Sma6wO1UmVNRqILQdFbcfoSXlnCgSKH/1WB+qgZicZ1jM90FpG//cpgu/
         o4thGJuBc/mfQ0uRyLCsOERvxMQL8h8j1XrdR09zHu5/1pDKB7uUj0zIvADVvGXHa/nH
         lnbZMZ2JB4YKlOjR4gWmrGmX6cjN44gGTieGUJNoovyZM16pENJQD7HXKthNyYGCN3wW
         QgCQ==
X-Gm-Message-State: AOJu0YyC9DDWu4UUYZcHaIzg/uUjyzNiFSBgaH2n8Psn2NjI9PqUUY7j
	HsBjw2UpkWWpjBMjgJOiAQ03jIf/bGOzqL3tTVaAqKcLZwbbukJdzYMt
X-Gm-Gg: ASbGnctjpelx6oRFQiHOkcfi/4HIcz6e9fdBuAbdowTFUiS9AAwZxSi/lCEegRzC729
	sJwsWo3egbyaW79ybsEu66uURuH5589CsjDSDdpIwJy47Whpan+/y8aieki5VWkMWfSKcNqvg2k
	IAo/0c+xXd+QO3SoldKkQ6xs5LRyM+54PrXtIc/0gkmJ4y7tUAt+5WCKfDrP60iSZT5YcCbO5PH
	uCNZuOEHoI1Rq/LES8vM/mtYippQE4vjABpw2Au5SY+vVG/ZhW436Qefe5MhbWcTw2nNxkSNqOA
	ryLboR3G23bL0+TQuxTK4I26VYouig8UPqMR1o38HQkTtcjP+dshAIFZnky7qHSy5o0+75+N3hv
	d11d9JfA6jD1ym8Ub9ilieLbG7NyBsa7Jpj0ym4HQ4NfVUZ6CF/knYBb3F2Yr4vh6fJZvjfEb
X-Google-Smtp-Source: AGHT+IFj0ralhxCw9gtXMNxyl9Kpp7b0xZeMtfhdxLBXWpHqRS7iX83xZgLhRxoK9y2BWDEiCj0m4A==
X-Received: by 2002:a17:902:d2c6:b0:295:7453:b58b with SMTP id d9443c01a7336-2962adb29cdmr12165085ad.4.1762295950273;
        Tue, 04 Nov 2025 14:39:10 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a609c8sm38264015ad.92.2025.11.04.14.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:10 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:51 -0800
Subject: [PATCH net-next v2 01/12] selftests/vsock: improve logging in
 vmtest.sh
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-1-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
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
Changes in v2:
- add quotes around $@ in log_{host,guest} (Simon)
- remove unnecessary cat for piping into awk (Simon)

Changes from previous series:
- do not use log levels, keep as on/off switch, after revising the other
  patch series the levels became unnecessary.
---
 tools/testing/selftests/vsock/vmtest.sh | 69 ++++++++++++++-------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index edacebfc1632..1715594cc783 100755
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
+			awk -v prefix="${prefix}" '{printf "%s: %s\n", prefix, $0}'
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
+	LOG_PREFIX=host log "$@"
 }
 
 log_guest() {
-	local testname=$1
-
-	shift
-	log "test:${testname}:guest" "$@"
+	LOG_PREFIX=guest log "$@"
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

