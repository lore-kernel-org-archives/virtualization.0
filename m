Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C06344055
	for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 03:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273994; cv=none; b=C86IlM0yb6JmQrVOdqqGaw7SuDWnD8cqkKh39akg9ctlVEJodpbVQRYmjU1kTU3PI+5bWWXI5JLQw3CQiSNcOfgbjL+NagTZari7bW0npCXv+Pf8zGSnl/nqk63KbP76ZtAal21ghZXOtu4PjriT5diHnPrUZoFwKZblfwG83XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273994; c=relaxed/simple;
	bh=ucIpPosqEiSMdZEyChVr+4AmgFcQlUgInXBmbAzH57o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AthV+PwCOzDapn1Hg5ULkMujA0e0ui1uMXE6KI1L1rS5u9kob4HacT80inW2/ai+YOjr0VVsMN4C1Jr0dFxjVdIc91aaEV7Gc2vMLZMMy+nxYPDYKYIuc8ecPvkOdLR935hSOzyHkM0sM4LRrRFW+RL2DRIPEnRg1Ug0cgi6TAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwvNy9Gy; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwvNy9Gy"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7927416137dso24959077b3.0
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 19:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768273989; x=1768878789; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNxNvDBVFHGq590i7LC9o7diq8A3tmTtfQIAa+Qj48w=;
        b=mwvNy9GytJT8suNoeCzA/fVSt+jgnOzyEQos5C5bFfvDPJA0YgHQ/fFZhE6YTkLCA7
         dlBW902WLdy6oZpsr96ZvgI4H2bNKLnJbFIoychUV0eWMVyd4CbpLNZIpzPA34yJ86GU
         FrxJHkIEEsYuyX0LoSFzMRvO0ni+wLsTic2JhGRrrpGOrmhdYClGGdHRCZxOc/jpm71O
         zv05/6bvvsTlXXLzhQxcV4AOn7UQHWBkJrN8KbNNQCDZry46UR1JDxx958nunAUNFl2B
         p9emOXBZSzNnymEvt6VLdgTf6HrTXaMIkVB4DgE2ySEGIl0rr+5m2+dJYRQMpwfbZOBq
         3wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768273989; x=1768878789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sNxNvDBVFHGq590i7LC9o7diq8A3tmTtfQIAa+Qj48w=;
        b=FgB9mnaXllEKk9QIswbK72ytovb/sBVFuzDMaXPDPEi53rUYK2BOQ8hpRU132Abu7M
         A6a6N0t4LmlDc0cNGXkUt1tKL6hgVbEx0RRLk0rd2IxDFEM3ai6ehYulsqv7DvUdwdOW
         ZHWhPwt9d8OoC8SrOHHuNb7fd+DY2Tieu/r4GGnCm2gc9917V90CwH3/ecmI9RHnBQ+Y
         YbIuYCLTEbgaB/I7nrgoLZHKDLuT7FYt49K5h8yK6ctusiDRFA75aQiMzGL56naWhwGe
         mwpR8rNkSEGWIbLUBX3Mz5G7zFKew/yTOl5SCWAb0lAiMrlZIbwDLRrIue8oCY/D5wbZ
         V7Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXSo5erXEXmuAwOavpuclwkVtwyIspxYnUkAo+245bwf8tZ2IxQihpiAP2QjI4KxnJ/w9BvnZ/ecGQ32cX+4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwaMeENHjS2qcnnuOUtII3DKmUIw/0xwjMAyj6hkOj3pp9JGEj
	db9r7uVaffpNYB5lo1qQJtZrUHSyaB3Og1+sEmbjJnvOygtjYGCLQ9p9
X-Gm-Gg: AY/fxX6T0enSo8mO+gMQ+0gZcZamj2oOieId0XBkhTnVMNt4UwgWgW4qGRChIvREzyd
	elelQianidVwlbPbhD5nUybvcF1LfQq2+/42ZGQtJXY+Yl0vK9wszYvTtp7RMxxNfIT7PlQtfve
	dxQkwSdTU0omf+V/S566YH6agq4Sal/ZjF0ehXXZJ3myUBxOs7P9k/8ropFeoY8v+YslbkHoLUn
	GY/awcMqnT1aRmgWtmUng08ZOM+PIXdO1+Ikv9Fe7pEvBKf1WAefCqexZabHtlqRWB93oFArY3O
	Avb2ijdlQCGQR5hiQazEc28xzsSJeB+gfh6+V+8autfG45CYEKtGkp+vcbevmpnWWXpnxpHkm/E
	Jjk9PjTHtx+BViFtldnWKJFHiiFyGPMXJytas/TrUZbMt+njdqj+UGGzPMsi6HRoeBIsM/GQNIy
	dapPWR+i1UOQ==
X-Google-Smtp-Source: AGHT+IHajBIIB3lFDpmb/+cpRXnIk1X1l4rqHdpMk0OXknIIotsd4BlSh7ibgscjI2PVi5aqIdrNJw==
X-Received: by 2002:a53:a342:0:b0:635:4ecd:5fcc with SMTP id 956f58d0204a3-64716bd78c2mr12639723d50.41.1768273988637;
        Mon, 12 Jan 2026 19:13:08 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7916d0c3f72sm49160677b3.21.2026.01.12.19.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:13:08 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 12 Jan 2026 19:11:21 -0800
Subject: [PATCH net-next v14 12/12] selftests/vsock: add tests for
 namespace deletion
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-vsock-vmtest-v14-12-a5c332db3e2b@meta.com>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
In-Reply-To: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
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

