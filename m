Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2CC44A707
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 22:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033548; cv=none; b=oZUYTnAoqXmFbnFhInPxc4FvQvxW9U1Cx83pfnvnjcwSgRK6wQqPDdNWGQYAe/30dhJxqpfc17ZkEHb9LEf3ss5yJnWBdX/1zkPhw/VBWZH7Y/JCsj7UbO+Zex6oJGvPGJwZ8Jn36TqLO97U9zfHpA2EKfa1lH8vYy7L8zPkU9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033548; c=relaxed/simple;
	bh=JAQQN7P77tr97fU7vyuVMrvCiNP4sSFAq43cZhTlmi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SUywo28BiiDrrkLacV43nELvOLNWDKDZ+KOEJ3BEe6MRD+S3pxkaHucnZJPMuJFzlXPrzxS1+b1sS1oEbz8VTJq8vLlTI7EyjUnYlJIMZLQlAapAz2pUrGzsFj4x6uZbXUkn9CjH1LBxbTuY7Z1teoqpvfB2dLbvUOcfY0jwPRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGxDe6BM; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGxDe6BM"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6446d7a8eadso401903d50.0
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 14:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769033530; x=1769638330; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2mpdsMRuLW1cRrssyJH9GNY+tfbuaJ3H6voxC/Fdtqg=;
        b=YGxDe6BMUxXxFDzsXCkcKU0w0u4NlSQhsPFPXo8X5v0Q9Zq018rTlxthBt5Fml01ek
         HsdU1PVCq8s6BuGKM9LXQcL8w4V+i921MWdm7q5rB4Ht2XZ6z68NJR+4Q1ksXS8590PL
         XZdNctq3NVwW4AshouuN5AAsDS6JpYdT1RJxkZJLPe8ro1cSHLbIQPUi978GzraAVPuK
         9iRXjMi8/l6zRv/lFwJxO3r1xFDUd5gFIHl3hSlk/fHWwL+MbgFjqc9WQ2bAeVlbmpX+
         XgGuZzCBfyDlAYNMWIg6oAX5isHdPMzlAezWgAif3UiS3sKZTmxPH9VVCYIPvMeyjtBf
         veSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769033530; x=1769638330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2mpdsMRuLW1cRrssyJH9GNY+tfbuaJ3H6voxC/Fdtqg=;
        b=NH676xQAq3cNI3ynNQQtNkHpKlUV84J5sc6SVWxGU057hmiMjOOmCpPBDhhzeDZNp/
         DT0CjkGqOf5PxsBATNYO4KIlR7mF03XAPaqf1YMOTdZ84odHPiPbBZvmmXlhFdnV41Ij
         jnrjiHllPviqqhwHWy5dPiJdEn1zVBkIWvirRPX5iEwJJwxY1Bv2X54V6kGZiE87wtn2
         QAnL6iUqWrr7lj3Q/7BWfYM87tNwWTmzPB9dkbOKsTJ+quqaD18mqZo2AfOhN1UTBb7j
         uT9cEUuk/0MrbTBxuXd6M6ofVjwZjfqC92IpAcSUrtyniL6rDqzRo3GKGFpdpWfpN6h0
         A8jw==
X-Forwarded-Encrypted: i=1; AJvYcCUqITKfc0jEIqpBFhWiv/ct+EfwclxWR9FRTaOAm4flklDa9+3G3cK6iml481amAqJwtWdcuJWi9lRJho8mRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhWyM7cuJ7RSIUWSu8ewB6RvF+fc63uB9ZbDjnZT71NCneSzSD
	nYfBTvu2Hra678HRqZEhEQMdfxhGUzr/3nGbKQ2m0IjEAlu3qNpp1pwV
X-Gm-Gg: AZuq6aJBvMPyft4H2mtU3121ZiArtYkDH1KsWOHiPXsj3YYpozlalIqTrpTmUBHrnOr
	iErFnWcUGG0CszoqE9TFuu99UOWO9RqQlnRiMMbNOMeR7j6XK0CAE29XJotROQphZOS1C3w3+oU
	Eo/lX7UI8GviimjKB9RjFEshFPuqv2Z2ejk6CxreZAIyTE0/lxU/AIaD9EBGLNsHh3UBzkxCxVA
	GWez3Js9RmgwWGgGbrdzBlSFDX3f0RFuMYW1ES67Bt3P9ptvHXF2BFRcEfFIl3RemU+qDpYY4Cs
	RpIQGe8T3sIzEGdn42Prv1nDdHqDltod9YkgayCCX5mwPA5dCuQ0QMtrpYTrRveK2cNvp+4WRzP
	xe3Hp3g1/dLCqBSPzUdYnK7L/C+4EPOphXODv5xM6eOwV5oZc42B9UGWTFn/+IekcdVpVWsoyJj
	JsmSPGP+D7
X-Received: by 2002:a53:d013:0:b0:644:472d:db04 with SMTP id 956f58d0204a3-6493c84922emr5253487d50.55.1769033529707;
        Wed, 21 Jan 2026 14:12:09 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6494080138fsm2463523d50.20.2026.01.21.14.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:12:09 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 21 Jan 2026 14:11:52 -0800
Subject: [PATCH net-next v16 12/12] selftests/vsock: add tests for
 namespace deletion
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-vsock-vmtest-v16-12-2859a7512097@meta.com>
References: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
In-Reply-To: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
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
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add tests that validate vsock sockets are resilient to deleting
namespaces. The vsock sockets should still function normally.

The function check_ns_delete_doesnt_break_connection() is added to
re-use the step-by-step logic of 1) setup connections, 2) delete ns,
3) check that the connections are still ok.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
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

