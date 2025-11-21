Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5773002A6
	for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 05:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703911; cv=none; b=UnDKxGvAM4HcihwlLgaLtgRhG6CH98k2zWfmb73Q19GNWmJ3lfUYXlv33GNCw3k3FopIL0HDADKgggCgcyA1Jc1O8AKPDatNziXKsB3NPZOmTBWqx6+uy3PBuaAN2ZNyif/blG3OgQivdmOvr+SwcqGoA8KxVb54e+XPykj0HVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703911; c=relaxed/simple;
	bh=HcFpLUc+G6pQCjiDu3dqqPPKH+0uQ8yqBNmFiEzDG9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sp4ypt6rpofLetoHQvoYLJAvat2++3SuwaCAqY7KulqINbXw7vj4cHHcDB5sqiV5CWMzdVRQgR211G/LwLhAWLT4GPeu18XECOqx3zT5Yh86Dm90xadK3uJh0QtRg7gABxYfqMpkC4r8itRXM5kEWWcS4wG3XkJQYPj3mIscyaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+NbHxJN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+NbHxJN"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-297e982506fso22342175ad.2
        for <virtualization@lists.linux.dev>; Thu, 20 Nov 2025 21:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763703903; x=1764308703; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9sFl9qbvPwYtRInTuWVbglrBqV89lDCjlyhP3JynaY=;
        b=G+NbHxJNzeLX5TDfeEq91Wf4iBD3XL8bEcxsSegOg8VZbWJ1D3WYKJLdTIkNv886Wj
         4zU7Oq72rrxGjYuGmA1zs93MvS9Z37cAD6482+UgIEEzjNeMgyMxEkOml7L+xoOZlRg7
         6s1KsGNNReV+pd0+vhXJxqakS20lqSOfSNyYGDt2vNa7ZSQ8yhz76rXOf/xt1E5/y6rX
         zGfzIMope4B4/1Rsx6WknE9FPp1IbIATdASLzrhK6eEoWCkvlireD6TI82lg0lSH5yP2
         REJOI5RBk3m9c1SwS31W3tlH7AvLKmzCIXcKRLVgPAG40sBo2eYilxGHhoGnvYYQ51k5
         vr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763703903; x=1764308703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V9sFl9qbvPwYtRInTuWVbglrBqV89lDCjlyhP3JynaY=;
        b=C2/xk5PvRdEcADJsg7Hu65mme7i1yq6ugLpfPYUIubh6gM5qYU3LCdMOhASehKDNbE
         7GbAQfyM9y2KLxh+ElfmCzNffUOK10hYpSEUuPvbVEeIKLwNbOWaaqUKcI5A3Eoj9kiT
         b3R0p6yVxrTODRp+OIEzGWV/VbA/aUwK/sUizs21/4A0MMnoTTOI8mVLb0zD1MWf5mIy
         VgccwDfzzBLJHw6ks7FYeB8NWQgDb+BL8yn+1izzNUANrSAcpxp34AA/13oLo66nz22P
         I9IZ/pbg3dXvsjsUBnuIZEE4mGerEeHHPJDVOAj+h6yakhoYBzBga6/bKxnO4hR0F7TI
         QbXw==
X-Forwarded-Encrypted: i=1; AJvYcCUOAn6nvz4AOCFlMH+Mrakg1HQREB8zi6hRBuEKhIvgwj+BLCAyFg4AIMaY1lnHGVqYT1L+ZeqTPxpjbtNK7w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx66z3eoGVHdN5d5U95xbl/tKDjOl1Td+pMH3gPtpyI2X3QhGvs
	BBCZhWURrUG8s9ESEsmHq+k/uzvUrc9bA6UnKWKdAANVSvxzTeRxEElJ
X-Gm-Gg: ASbGnctiza0mh4q772MqmZ/z+41tAAfvXn8RDTphBG3G70567OtDhWDhDoW5s/Ax5wx
	xMDnzEkon/ebI54b9B/IvQjWBQ+/4S8RYd0IlyJROnqXwz7YCDAb+tRPHMSMmjj1XufD64Kvpkt
	qIHsYopJDiPOVlDDM6FPvI3BR9ZZeyWO0cImOZyu/1CwwBZt4ONylo4Wa6TDWWHZAxDEg7u0DYr
	WMoo9PBVgKq0Oah2qtwCJYvOnMQCRrxx0MF4Y56pI5lnqA7z7I1kKYJLoB46Q4qBnZ6ad+5ZZ1o
	PwMc7hRNMV+zXjvq5MsVGGR1R5fijUTl8EvP5zSYFOq1gmjBEKvqlBtG6CUvvzLxILu7EC6BSZD
	SAya4DRwqb5hzHJT8AKnMZCNKLn1fnlyG4lIlxqny7SGi4H6bM9IyWEW4wYO4wfVdP9qGz3w6EW
	/eAbjLaJ1NFZ/z8/oT/Ug=
X-Google-Smtp-Source: AGHT+IGNogkw6+aYEKeY1jIA1/MWu6kqW3NQeqBIULV4beIyW6SfaQAClzFvrrHi8XqojUq6urD3Lg==
X-Received: by 2002:a17:903:19ec:b0:297:f8dd:4d8e with SMTP id d9443c01a7336-29b6bf37d9dmr17593035ad.30.1763703903500;
        Thu, 20 Nov 2025 21:45:03 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25e0f0sm42902025ad.46.2025.11.20.21.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 21:45:03 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 20 Nov 2025 21:44:45 -0800
Subject: [PATCH net-next v11 13/13] selftests/vsock: add tests for
 namespace deletion and mode changes
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-vsock-vmtest-v11-13-55cbc80249a7@meta.com>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
In-Reply-To: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
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
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

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
Changes in v11:
- remove pipefile (Stefano)

Changes in v9:
- more consistent shell style
- clarify -u usage comment for pipefile
---
 tools/testing/selftests/vsock/vmtest.sh | 119 ++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index dfa895abfc7f..5f0b24845fad 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -69,6 +69,12 @@ readonly TEST_NAMES=(
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
@@ -139,6 +145,24 @@ readonly TEST_DESCS=(
 
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
 
 readonly USE_SHARED_VM=(
@@ -1288,6 +1312,101 @@ test_ns_vm_local_mode_rejected() {
 	return "${KSFT_PASS}"
 }
 
+check_ns_changes_dont_break_connection() {
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

