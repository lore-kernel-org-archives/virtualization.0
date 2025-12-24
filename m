Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2682874E9
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 00:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536157; cv=none; b=G2rPkseVXANlMonPEThRab+IRcEe3KlC0NKDZq+9ZSh6L5bLHuR7WjnwhPLZ4Bb1vydoL1jmPqCMm80W2m6ouxV63ue4IwENl4pj3dC2CSbXPZe09l55L8RcEXoEIHAwrWup9KHkVTi3WGeGG6AHluhlaG3pZBUISJWadnQRFEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536157; c=relaxed/simple;
	bh=ucIpPosqEiSMdZEyChVr+4AmgFcQlUgInXBmbAzH57o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kjPHIyl6Ggj4DOGiBDrEiN9wVQh+ZKvWoCulRSeZc5MJ8t+RYsrHOUOZO6IK6fBSvEl8l+SDq6izxd3uQOMbS9gVjUEro3wgaGC2w2msZ2uu4RxVS01OtsaVQRWZNvVfTOov1V0qV7GJyHcS7q80OI2xjryiEksopxFLFeshquE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOx+PkCu; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOx+PkCu"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso8610577b3a.2
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 16:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766536150; x=1767140950; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNxNvDBVFHGq590i7LC9o7diq8A3tmTtfQIAa+Qj48w=;
        b=JOx+PkCujF94xCQ+02OKhow4YwxMKJxFYuXUZzkuUXyEmjZRhXcVDZvZq/8ZgYNhvU
         DsFL951m13IyusgfewY8Fp4upHi3Pzuyc447Iq43K8/yBRYav6d3cbkVyf9Sewi7HfiG
         AtkBiXBFIqQh92JufRYsDo7RLvwN4lUAtIzjvIK+JI5H9S4Uie1OKPo/mUqnzpUOjwVR
         dANk6ilcHzgy1PhveBx1JFh8uEJ5IbonKPI2VAWeiK8XQnNQsDjP6oVxkoTDu9JW0XWm
         mD5WCdQPGgptv9dEEfKfp/JD99cnRfSBzmwMFRf1qCV2GlGbSr9SuJ12+it7jexAuPqp
         0DnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536150; x=1767140950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sNxNvDBVFHGq590i7LC9o7diq8A3tmTtfQIAa+Qj48w=;
        b=g1iArsa9tN/3OFufyPvgZyqOrtHNSpmijTjerf6fULMb0Sih+z7RJmxC2ASMIcQzE4
         1Bsu+CWQhLiUHiZVUvP4u2GZqYn4sfxS68vCLv8ZKPO98/weYqnmxRxX3nta6YuKolov
         Y2wEvOHMcnG7xeAsNlkAceFWmf7DyXzrBWlMiQfRtrIGvBMmoDkfGEPKlH3o7wgeJtXr
         SmvSleR9Et+RxLc5wi8sbcB/RFbbcUefT9w6tr3TkVgWz2E55t2EzPwu3Cw2b5xB3iGa
         WvBqb50ytMNmwls6sGvECpwx0Qyehtt26WDL6cprD2LCERHrF2FSEeOZ5bxj74Zm3czt
         fqrg==
X-Forwarded-Encrypted: i=1; AJvYcCWTqHd59TGgsc80/Xy8uTbipZxXoXaToNeQrhAuFYXtCFZTiIRtqYJcTFkJSbf5uLSPZhGHFJkMzDFFbJIgoA==@lists.linux.dev
X-Gm-Message-State: AOJu0YymEWnS8xjCEtEYv2qRFYT4PiZ9jqPmAlLqK/IGz6pYXWRGY1UV
	/4EcEtQqXX/AMMG6omyBZhoKTMbA10gL2g6N+MQeLxxZY8HeG3FN554M
X-Gm-Gg: AY/fxX5fiCgmYCMLFq3AAGo/3QCjpRoxxpveMgjOon0SV176ZvTmXaNt31M1Zwucq7E
	0p+yEkSwZFXlSeAcQ72qX7SCHbsI/bpSpzEgTJJrUGjwJSNXv0fY46lT+5ALv/UP95W09RP0AgW
	4d8esWoyXE4QiJf5fzgrMnUS1tmo5Zk5HOST2RuaiVC64wmJpU5MokSEhftAWBYr1vM3ZktUVEw
	imUBpvD/SF7NJUXvALK0OWHSUfmtIpLpIhRFifLhXQPuVmj79w7WJernXWyT1aNZ1a4MBYhffNa
	GW4WJnjHvYb2krPoIpLZ3aneFxkzN/x13e8uZ1VbJOV+lqVjcJpyGlWJ1zZGn4KIc4XVj4yB3cn
	BzQ1tmQyftSxYpleIxf93K49sxWbvj+NRfnacoMsMyGefqV+/TK5orRa5O7NSwmz7cZRgtdiE4B
	s0llR3AhvZZUn21Bk4v7mH
X-Google-Smtp-Source: AGHT+IGKtnBjY8qVMQri7rK2UM9kYsU1JWM0jsDUq4zxMWO7Sx0v5+rbDtIzGBXE3bX4EOFk1Fr9Zg==
X-Received: by 2002:a05:6a00:e11:b0:7b8:ac7f:5969 with SMTP id d2e1a72fcca58-7ff646f92f6mr15898637b3a.4.1766536149791;
        Tue, 23 Dec 2025 16:29:09 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48cea1sm15118831b3a.45.2025.12.23.16.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:29:09 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 23 Dec 2025 16:28:47 -0800
Subject: [PATCH RFC net-next v13 13/13] selftests/vsock: add tests for
 namespace deletion
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-vsock-vmtest-v13-13-9d6db8e7c80b@meta.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
In-Reply-To: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add tests that validate vsock sockets are resilient to deleting
namespaces. The vsock sockets should still function normally.

The function check_ns_delete_doesnt_break_connection() is added to
re-use the step-by-step logic of 1) setup connections, 2) delete ns,
3) check that the connections are still ok.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v13:
- remove tests that change the mode after socket creation (this is not
  supported behavior now and the immutability property is tested in other
  tests)
- remove "change_mode" behavior of
  check_ns_changes_dont_break_connection() and rename to
  check_ns_delete_doesnt_break_connection() because we only need to test
  namespace deletion (other tests confirm that the mode cannot change)

Changes in v11:
- remove pipefile (Stefano)

Changes in v9:
- more consistent shell style
- clarify -u usage comment for pipefile
---
 tools/testing/selftests/vsock/vmtest.sh | 84 +++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index a9eaf37bc31b..dc8dbe74a6d0 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -68,6 +68,9 @@ readonly TEST_NAMES=(
 	ns_same_local_loopback_ok
 	ns_same_local_host_connect_to_local_vm_ok
 	ns_same_local_vm_connect_to_local_host_ok
+	ns_delete_vm_ok
+	ns_delete_host_ok
+	ns_delete_both_ok
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -135,6 +138,15 @@ readonly TEST_DESCS=(
 
 	# ns_same_local_vm_connect_to_local_host_ok
 	"Run vsock_test client in VM in a local ns with server in same ns."
+
+	# ns_delete_vm_ok
+	"Check that deleting the VM's namespace does not break the socket connection"
+
+	# ns_delete_host_ok
+	"Check that deleting the host's namespace does not break the socket connection"
+
+	# ns_delete_both_ok
+	"Check that deleting the VM and host's namespaces does not break the socket connection"
 )
 
 readonly USE_SHARED_VM=(
@@ -1287,6 +1299,78 @@ test_vm_loopback() {
 	return "${KSFT_PASS}"
 }
 
+check_ns_delete_doesnt_break_connection() {
+	local pipefile pidfile outfile
+	local ns0="global0"
+	local ns1="global1"
+	local port=12345
+	local pids=()
+	local rc=0
+
+	init_namespaces
+
+	pidfile="$(create_pidfile)"
+	if ! vm_start "${pidfile}" "${ns0}"; then
+		return "${KSFT_FAIL}"
+	fi
+	vm_wait_for_ssh "${ns0}"
+
+	outfile=$(mktemp)
+	vm_ssh "${ns0}" -- \
+		socat VSOCK-LISTEN:"${port}",fork STDOUT > "${outfile}" 2>/dev/null &
+	pids+=($!)
+	vm_wait_for_listener "${ns0}" "${port}" "vsock"
+
+	# We use a pipe here so that we can echo into the pipe instead of using
+	# socat and a unix socket file. We just need a name for the pipe (not a
+	# regular file) so use -u.
+	pipefile=$(mktemp -u /tmp/vmtest_pipe_XXXX)
+	ip netns exec "${ns1}" \
+		socat PIPE:"${pipefile}" VSOCK-CONNECT:"${VSOCK_CID}":"${port}" &
+	pids+=($!)
+
+	timeout "${WAIT_PERIOD}" \
+		bash -c 'while [[ ! -e '"${pipefile}"' ]]; do sleep 1; done; exit 0'
+
+	if [[ "$1" == "vm" ]]; then
+		ip netns del "${ns0}"
+	elif [[ "$1" == "host" ]]; then
+		ip netns del "${ns1}"
+	elif [[ "$1" == "both" ]]; then
+		ip netns del "${ns0}"
+		ip netns del "${ns1}"
+	fi
+
+	echo "TEST" > "${pipefile}"
+
+	timeout "${WAIT_PERIOD}" \
+		bash -c 'while [[ ! -s '"${outfile}"' ]]; do sleep 1; done; exit 0'
+
+	if grep -q "TEST" "${outfile}"; then
+		rc="${KSFT_PASS}"
+	else
+		rc="${KSFT_FAIL}"
+	fi
+
+	terminate_pidfiles "${pidfile}"
+	terminate_pids "${pids[@]}"
+	rm -f "${outfile}" "${pipefile}"
+
+	return "${rc}"
+}
+
+test_ns_delete_vm_ok() {
+	check_ns_delete_doesnt_break_connection "vm"
+}
+
+test_ns_delete_host_ok() {
+	check_ns_delete_doesnt_break_connection "host"
+}
+
+test_ns_delete_both_ok() {
+	check_ns_delete_doesnt_break_connection "both"
+}
+
 shared_vm_test() {
 	local tname
 

-- 
2.47.3

