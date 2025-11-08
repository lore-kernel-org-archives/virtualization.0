Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6C52139CE
	for <virtualization@lists.linux.dev>; Sat,  8 Nov 2025 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617714; cv=none; b=V436bFKPnlTusXyKEbeOr7S8ajbXQAXxrAjL0A/QtrZx+CxOTeQiC8liRqgDmWnEEJh+bDEC6vrJ6DxiwVgI6h0t/Di2k66JqVMT5/i2LR0iGv68NMHEazRh5fd05HUCMQ5cZ1Ndr+KeVmJqkNKp892qhq17lQbz6Rt2YGsV/vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617714; c=relaxed/simple;
	bh=KaZPXYApVo3gzuCQZxOqqdj7Oefz16QZ4HcopRgoUyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SgMJqlulPgcRc47h8fjDZPSPWd2pFUHO0ZLcSg0HgTb+7zuQ8w0nECrQbVZ4vVoQ1OUMbQspJ837MOSXHhKl0MtiAW28dgo1BTI8h4wkIHKVnSkFdpuZZLrTAqvjJln1WfArlStDenoUKj0acHU6bhH643s2ZWJbv4P4tWtre8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kElfyOx8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kElfyOx8"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a9c64dfa6eso1302907b3a.3
        for <virtualization@lists.linux.dev>; Sat, 08 Nov 2025 08:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617712; x=1763222512; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KuFcuN4dciZC8eK8448U1zaLcwyfmGMtaq+xAMSDgTg=;
        b=kElfyOx8C8lfeoype0qygu6HS4TTxFvp3tPLDZ79kBCdBjvyWON225bfPKFO9Y7vg8
         kzfiE5q9ZB75guaXV9L0oxcOmyHWfVAMZn3OKYd17kZbRgUCIF99x+Cdgj4ZQyHxSa1X
         LdmbLwOcJo4y00Xg9mksrj9GJj995mBGhLlqKuzp9NCTL/EZFE7GTCW/16/bkVzKUbt0
         Z1qum/ZL4rHyaNLwMM84+FuS/JSTcwdAmsc+h74voLkWnIp9+/H3XAtjUZVuPt31wENl
         T0meJbO5LSkWBKI6XzqFHbbslVERh9UtMo1VXnbDJZAJBRHU7S1ZEHGt7ufnyscLcEyH
         Fh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617712; x=1763222512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KuFcuN4dciZC8eK8448U1zaLcwyfmGMtaq+xAMSDgTg=;
        b=AtT/+2bWbNter3k8RHK8BZ+Z6VqZA1NMVmyT4+l1oJjLkb3ZMxIUt2Z039A3Lx24E1
         ODuSkWdZcoQ2N2JhkI/8HZE5KmFh6P22o9uSKa/Ufv1O9ShAjqcoxjBc1ELemdodS/Up
         cx2PAb8IeUaMryxuzhAWntB+qZVqO6Vytt+E+BKFjI2mxDkdhAnbMFNfsS2PuZH9Ocse
         vhmqIZWHzRRh8gz1v5zIHEEDEDcj0wOgZOB/AjkuW/0bfn35XkrskQ5BuAupo3Hn5AK1
         k1+vlFl6NONQ7V8Dbl7iY8BnU/Fht1Jy2jjOR1eRNf8jqQRaqjMzuxZDBAoLNM0vIp47
         bojA==
X-Gm-Message-State: AOJu0YwFxSMfmVWAnQLbB4vV8c+VSkfHQDP6xYORUHW/mFQhYlGAM9nb
	RkHrRLnP5Y8mUwld81LphEj4yfT6s+hmjz/H1eeNzmgx9TnKuCBMYoxO
X-Gm-Gg: ASbGncvY5Y3lAGhTo5WGEb4SqMgMKETh/lgszSEcVkzMhljmhA9MZY2sSNw9U1aFu69
	ffVD2f53bIpHzdKJfKrjCIGrXQH8ZULnKPUZiLacAkwp2LsxZQCD+tvPiGfdiMuSsYYbFYsJJR4
	nKjSUOHPUC2pnReEjII84x9Agv/YISbRqk714i5otjyOCPCV5+plpg3wfoww9RjJSk6HS0YPzOu
	euT92ewhLSxXqSQVOZgTILM+ZAvBcYNP7fpT2AShwWJ+EzV7mfD7mztv//gESoMcej8irv+Skxy
	6GnhqoxxMKYjYJE5M8FYKRStLuNRB2NnTr5gnhXG2fanwyRkadZoVB4Rs68Bf2FqerBtODPR+/Z
	9yyX29eHO9D92c6bizn6SFlludwiSPk2GfYjdISMSds+AA8FlmviDBBqwj4Aii0ZXxgMy0hAILA
	==
X-Google-Smtp-Source: AGHT+IFfAGmgLKI4wsdRP449UjnWCEHQ8HjRd06GWOlMDD2Oh5K2oGmSXaRp75cZh2HiCmppgc3Cvw==
X-Received: by 2002:a17:90b:4a8d:b0:340:f05a:3ed1 with SMTP id 98e67ed59e1d1-3436cced91fmr3307290a91.21.1762617711672;
        Sat, 08 Nov 2025 08:01:51 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c30b96dsm5767493a91.5.2025.11.08.08.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:51 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:00:52 -0800
Subject: [PATCH net-next v4 01/12] selftests/vsock: improve logging in
 vmtest.sh
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-1-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

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
Changes in v4:
- add quotes to "${redirect}" for consistency

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
index 8ceeb8a7894f..bc16b13cdbe3 100755
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
+	fi | tee -a "${LOG}" > "${redirect}"
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
 
 	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i 'vsock')
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
 
 	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
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

