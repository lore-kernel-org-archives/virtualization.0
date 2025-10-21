Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1882F5328
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090451; cv=none; b=iknFMS2jLIgZEySS+6LEpdhJ+V2o4XPNt8Rhgk0xC/rMwo/FDth2/7x1VHXCJqhZFNXR88bXNDd8r2Ix2qRecQWVl+3Tsni9MU36WrCCe8bWBjnW33Lb3fEnA4eIIByj9SIXwiQ/yBZ/oEw396P0USDypILsnfLyMtzhTnXTKW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090451; c=relaxed/simple;
	bh=aux3K1IYIyz9wrqrgYN0zmRynTiqRa/rFWmvtJNo/MM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SYI6JjUAUHULh2jt0Ldw99Yz08tm0bgNx2UorrQaTDc4LKd183TCOxNBqca+ex0+Fw5fCx8n8Bylbf95+VhQDT0fmZRfl6SdSBM033Mm6UQvbG0cFMDxPJzy9G45N39AxcIOdxZWu0TfBdsATeczhStVDU1W+T/DoD6m2gMqqhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1az8QyE; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1az8QyE"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b6271ea39f4so4296273a12.3
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 16:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090442; x=1761695242; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkE1wm12EpboPq+xR0aDSe3dF2N2c2mo+B2K7wyT4X8=;
        b=k1az8QyEejrn37XtYelAx4y2yqsBjX6A11BkHFkz647hXyEbo22RCl8RlZbYQgFvxb
         itZyhBsvg1DSd/0wRMYVsev5F/qSIn9LkSTJmIpH6/1lK9SMCP6NPi+omEZY+Fx3Sgep
         xRTjcxqD8HUwZh0Xu9OhhSvJmMAp7ox976n5+JBRpNPaaBH5EOQ3j7HcKH2NSQcyv/yn
         hflIDgcIV9GGFFxoXgwKRXuaybluv+7UM7SqgNsOmOZEv7Ryb/oIO+rPCev0o36jSlqF
         CiS1lnSYC9xzgfau1g1DSX9q+j8CE7O4Yx9gAgdGofCMuh9R51nfejtzn2ifllIbwQGL
         DVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090442; x=1761695242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkE1wm12EpboPq+xR0aDSe3dF2N2c2mo+B2K7wyT4X8=;
        b=fH+f2LEoWQOaCEx65fdEiu773I0zkwzrH6K0v8SQmRfkfk21NWc3znanJXspKO3yy7
         El8oU6vHD/D5NCZ3wuL92iMcQ3vSb3tJ30Yh/e2TJyv6cyLiYvv9MGPFwtyGakt8SSML
         51b3OWVjMVoT86Iryew3Rxj/fuBf5JAwQj0ZeDNNs0sT3Kzu3LHJwh5BJENsSmuHnfMa
         s/x5TU0F4N8P7ix8pAxlPlW6EvqC3vMnmo7M38V4BCmxWcERYLIB2udNTeHzRG2WEg+u
         /Q+zQDYftidzyyO8IbNVB2Y3imha5IgztRgfqlBHdwy46oiiR+EzS5Pa7fhUPYqKE6f1
         D57w==
X-Gm-Message-State: AOJu0Yy1heasW1KUBirL1oR6nWsSiV0ugs7FdwAuyU7s4R4ehEOOtU9E
	ebDZh8fIGgn5RKY4qViDfg2d7E3zvF/0Ur2/c5ESpDg5c3Afo+xL4+Y+
X-Gm-Gg: ASbGncucBWim9ojPGCG/mh+oAStuvVx49hxlDiVMlSEvK0/2zr0XB+o0tHtaiQRrAn4
	L9muyhRbdJ4lYPEI3TwyDq0ZQD0zpekeAEIMEyWGUhgyU78C8es50O1V4pp7UjLFTQHyARx+bDF
	u09dmHxQ4ZMyIFpoxkFXKnoLV5cmkLV60RG3ZiH20gORlnDq8xTJCXT4CoWIBohnVwsZCCZLcCX
	afN2TY/bU6HpK/fozdBFnuEtWUyCQPx+Yqo4jIXIFSXqPp5/juxl+I6N7e29LdGdwC7zCOowgDz
	Eqmumse0CKavri8Ybpk2i1aLQYEAjNHJg9j2FWlpFg+VUzYzbASd14UH9jWmeZ4NMe3UYjDZKAp
	K1DsG157ocVW/DpvN1xxfBQzjGPtFuIxnEnQz8etqehFTFeYZ/Z/OcoitQLbg/52i5bnbvCwZ
X-Google-Smtp-Source: AGHT+IGJHLCu0MjtQBg0SHgooNwgM1vSlSfWRfiRu2HNlz5nsiqtV1uW/yPe7aUNptDiEFDTA5YlTQ==
X-Received: by 2002:a17:902:ea05:b0:267:f7bc:673c with SMTP id d9443c01a7336-290cb27af4cmr269152055ad.44.1761090441540;
        Tue, 21 Oct 2025 16:47:21 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b35dadsm11933323a12.26.2025.10.21.16.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:21 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:07 -0700
Subject: [PATCH net-next v7 24/26] selftests/vsock: add tests for namespace
 deletion and mode changes
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-24-0661b7b6f081@meta.com>
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

Add tests that validate vsock sockets are resilient to deleting
namespaces or changing namespace modes from global to local. The vsock
sockets should still function normally.

The function check_ns_changes_dont_break_connection() is added to re-use
the step-by-step logic of 1) setup connections, 2) do something that
would maybe break the connections, 3) check that the connections are
still ok.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 123 ++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 0a5751c52fa8..f8fa8b16d6e3 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -62,6 +62,12 @@ readonly TEST_NAMES=(
 	ns_same_local_loopback_ok
 	ns_same_local_host_connect_to_local_vm_ok
 	ns_same_local_vm_connect_to_local_host_ok
+	ns_mode_change_connection_continue_vm_ok
+	ns_mode_change_connection_continue_host_ok
+	ns_mode_change_connection_continue_both_ok
+	ns_delete_vm_ok
+	ns_delete_host_ok
+	ns_delete_both_ok
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -129,6 +135,24 @@ readonly TEST_DESCS=(
 
 	# ns_same_local_vm_connect_to_local_host_ok
 	"Run vsock_test client in VM in a local ns with server in same ns."
+
+	# ns_mode_change_connection_continue_vm_ok
+	"Check that changing NS mode of VM namespace from global to local after a connection is established doesn't break the connection"
+
+	# ns_mode_change_connection_continue_host_ok
+	"Check that changing NS mode of host namespace from global to local after a connection is established doesn't break the connection"
+
+	# ns_mode_change_connection_continue_both_ok
+	"Check that changing NS mode of host and VM namespaces from global to local after a connection is established doesn't break the connection"
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
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
@@ -1141,6 +1165,105 @@ test_vm_loopback() {
 	return "${KSFT_PASS}"
 }
 
+check_ns_changes_dont_break_connection() {
+	local ns0="global0"
+	local ns1="global1"
+	local port=12345
+	local pidfile
+	local outfile
+	local pids=()
+	local rc=0
+
+	init_namespaces
+
+	pidfile=$(mktemp $PIDFILE_TEMPLATE)
+	if ! vm_start "${pidfile}" "${ns0}"; then
+		return "${KSFT_FAIL}"
+	fi
+	vm_wait_for_ssh "${ns0}"
+
+	outfile=$(mktemp)
+	vm_ssh "${ns0}" -- \
+		socat VSOCK-LISTEN:"${port}",fork STDOUT > "${outfile}" 2>/dev/null &
+	pids+=($!)
+
+	# wait_for_listener() does not work for vsock because vsock does not
+	# export socket state to /proc/net/. Instead, we have no choice but to
+	# sleep for some hardcoded time.
+	sleep ${WAIT_PERIOD}
+
+	# We use a pipe here so that we can echo into the pipe instead of
+	# using socat and a unix socket file.
+	local pipefile=$(mktemp -u /tmp/vmtest_pipe_XXXX)
+	ip netns exec "${ns1}" \
+		socat PIPE:"${pipefile}" VSOCK-CONNECT:"${VSOCK_CID}":"${port}" &
+	pids+=($!)
+
+	timeout ${WAIT_PERIOD} \
+		bash -c 'while [[ ! -e '"${pipefile}"' ]]; do sleep 1; done; exit 0'
+
+	if [[ $2 == "delete" ]]; then
+		if [[ "$1" == "vm" ]]; then
+			ip netns del "${ns0}"
+		elif [[ "$1" == "host" ]]; then
+			ip netns del "${ns1}"
+		elif [[ "$1" == "both" ]]; then
+			ip netns del "${ns0}"
+			ip netns del "${ns1}"
+		fi
+	elif [[ $2 == "change_mode" ]]; then
+		if [[ "$1" == "vm" ]]; then
+			ns_set_mode "${ns0}" "local"
+		elif [[ "$1" == "host" ]]; then
+			ns_set_mode "${ns1}" "local"
+		elif [[ "$1" == "both" ]]; then
+			ns_set_mode "${ns0}" "local"
+			ns_set_mode "${ns1}" "local"
+		fi
+	fi
+
+	echo "TEST" > "${pipefile}"
+
+	timeout ${WAIT_PERIOD} \
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
+	rm -f "${outfile}"
+
+	return "${rc}"
+}
+
+test_ns_mode_change_connection_continue_vm_ok() {
+	check_ns_changes_dont_break_connection "vm" "change_mode"
+}
+
+test_ns_mode_change_connection_continue_host_ok() {
+	check_ns_changes_dont_break_connection "host" "change_mode"
+}
+
+test_ns_mode_change_connection_continue_both_ok() {
+	check_ns_changes_dont_break_connection "both" "change_mode"
+}
+
+test_ns_delete_vm_ok() {
+	check_ns_changes_dont_break_connection "vm" "delete"
+}
+
+test_ns_delete_host_ok() {
+	check_ns_changes_dont_break_connection "host" "delete"
+}
+
+test_ns_delete_both_ok() {
+	check_ns_changes_dont_break_connection "both" "delete"
+}
+
 shared_vm_test() {
 	local tname
 

-- 
2.47.3

