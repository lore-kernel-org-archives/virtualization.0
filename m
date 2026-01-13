Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC51134D4E4
	for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768324629; cv=none; b=bM5v66Lb2DGdMhzYAWj9t6vq6+ZUbAJozIiqx4c80FqEMPd51gr88ZyVnMjZJJpBv9OpL/RWpU9EL8A7W3TqIInA12+nq92v9j4zqnZReG12HhLCPyXkymFpKY2v+t8SazbDSe/JEqkz+icqGoLRfxvrvnxfeU4WCEKFIXF809g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768324629; c=relaxed/simple;
	bh=BOiAlUio2xt6kMFB7Iqg42Lzr5vEiOhyy/79lkkulkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ik/cdxfHt45c2uuLeimEbpCdULT8q/rMNoVER0QFXOGrwjtfnuebesD6g3tiXQDJOneTE3PzIB57Sm8wzye6qgvWubfjNU/QWZK6ZQCopQ97G+tSGP2Nle2bvNZqLF5PgeMpphKMicvFbLJNyIWziyfaVXewURplGiohnCYf54o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NHVkp9rW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHVkp9rW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768324625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3UUsl99U+a3n2frGXSYzi136UPXsqcjTTgTorfCP1Ac=;
	b=NHVkp9rWef3cOzZxI5LMGcVajFLYa324YszaVUXnNnW38uvMo6mEjYb11b8CDFgAJTKY8S
	cpnhnDDkUC06Rctsn1nAAzWX6Gm6WI1Mzgc8cv09je4d2c13r4GByJdk5InkroaW3QSM27
	2MjeEjmPB7LYaH6iOlAP4M7vHw5ZYRE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-0LPkZnBFOx27DS4YrGtQLg-1; Tue, 13 Jan 2026 12:17:04 -0500
X-MC-Unique: 0LPkZnBFOx27DS4YrGtQLg-1
X-Mimecast-MFC-AGG-ID: 0LPkZnBFOx27DS4YrGtQLg_1768324623
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477964c22e0so203995e9.0
        for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 09:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768324623; x=1768929423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UUsl99U+a3n2frGXSYzi136UPXsqcjTTgTorfCP1Ac=;
        b=Pb3kl9cN3edPTIf06Ma6oPtp4cur1TPMGgmRcQbHpyUHC1y+dV7b7JLRSIeF1LKUA3
         Vq/yUwGe9SJvRcOeGZdS+WlVpLRcrUSq0dJb1c0lplifldENAqlQ0MBNQhQg/ecDHBs8
         uuw6BoAsX4O2wNdwdUNNh13r4ZMGxxcTqovTnV1ibTQvQrWG6phoSFEbgzVybQdgNa6z
         mgAH5RhhjGay4YXjxAXYQjELPyHE/n8LvZoBjoTY4jHUIxPiv6m4QT+OKptZhzNAzTTo
         WelkUCkuwX2p7bIwWvGpCQ+hTwUN1R/Sc5lqtFkGXAY4V+nh+R1Mxb83hC1KrU+Sy+TH
         gDsg==
X-Forwarded-Encrypted: i=1; AJvYcCUDb+42Zi1XwDBhwfs+jb8tSk/q+tBJ4QbSkd3zWmeZTxoeFGFYVeiQJJUkEff63n6TB3tRJsnBhwUmsnPQvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqVr+XyDBX6gvmFYjDD4XXkELSef6nB1GBDWg+66KzQhOM/oxF
	WaG/JVVNBICGpenXxhVHM+6Ljtgw3D7RhGtlAQpU7KdrNIg4cqaKGeTQbue20o7b7Wk+Fvy8Y3A
	h2kfV1TuK0KQPMpFk/B8TFZuiOhbwQkqsP5z/tLVMs2lGkZzcvOqXPUzIuJv7CAvydAds
X-Gm-Gg: AY/fxX51K4NE3LRmO1IM4y6f3JwYadkKW263lpLgxvU405vSXnEiFVJHPr+MxLeEbJr
	X0eA2KKT1aBpm4mtAUEGOOXMDJ1Lj65uQ+YTWu5IshlHh8jhP5LvsdFfxygCJtdwr+xnKtpkt7p
	HunhQvjIzQH74VwEbqQq3A2CTQMMlp5Z1ZEh7Qsxd6dwkUkFFBrIaIo5K3KF7RMKih+3UpTnjnS
	8DP6nYfmYr4xRZa1E/OsOfXvusBr0IrxetsGzAJgfxfvKymHAjXLw7a8FpohQ13bBYg4RPTadNa
	EExvJfUIgSBz8KgrHK0uw+erahsGf+cvLeCR5apHplRab8dz+lPzRqy/P4FhSUPA6owgLIMPDpe
	KFBSY9kIJr9wqTOfrPIhjxVPJ7q8qfrSYchfR9rhKE0w2hG51vnia73DS1fsQRQ==
X-Received: by 2002:a05:600c:450a:b0:471:5c0:94fc with SMTP id 5b1f17b1804b1-47ed7c074f8mr51944535e9.6.1768324622983;
        Tue, 13 Jan 2026 09:17:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCSYBYlMR5NUmwo3nUrikwa7NopKszIR4niyQXAQsU/DKal6wX+cyMdumSidxaQyfxjCmWhA==
X-Received: by 2002:a05:600c:450a:b0:471:5c0:94fc with SMTP id 5b1f17b1804b1-47ed7c074f8mr51943825e9.6.1768324622288;
        Tue, 13 Jan 2026 09:17:02 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e17aasm45799146f8f.15.2026.01.13.09.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:17:01 -0800 (PST)
Date: Tue, 13 Jan 2026 18:16:41 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v14 12/12] selftests/vsock: add tests for
 namespace deletion
Message-ID: <aWZ92zp_zphz7geq@sgarzare-redhat>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
 <20260112-vsock-vmtest-v14-12-a5c332db3e2b@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260112-vsock-vmtest-v14-12-a5c332db3e2b@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H9kcR-U9nFhGvyyG11Tfno_dm5qbccsAth3ymVsX-zg_1768324623
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jan 12, 2026 at 07:11:21PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add tests that validate vsock sockets are resilient to deleting
>namespaces. The vsock sockets should still function normally.
>
>The function check_ns_delete_doesnt_break_connection() is added to
>re-use the step-by-step logic of 1) setup connections, 2) delete ns,
>3) check that the connections are still ok.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v13:
>- remove tests that change the mode after socket creation (this is not
>  supported behavior now and the immutability property is tested in other
>  tests)
>- remove "change_mode" behavior of
>  check_ns_changes_dont_break_connection() and rename to
>  check_ns_delete_doesnt_break_connection() because we only need to test
>  namespace deletion (other tests confirm that the mode cannot change)
>
>Changes in v11:
>- remove pipefile (Stefano)
>
>Changes in v9:
>- more consistent shell style
>- clarify -u usage comment for pipefile
>---
> tools/testing/selftests/vsock/vmtest.sh | 84 +++++++++++++++++++++++++++++++++
> 1 file changed, 84 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index a9eaf37bc31b..dc8dbe74a6d0 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -68,6 +68,9 @@ readonly TEST_NAMES=(
> 	ns_same_local_loopback_ok
> 	ns_same_local_host_connect_to_local_vm_ok
> 	ns_same_local_vm_connect_to_local_host_ok
>+	ns_delete_vm_ok
>+	ns_delete_host_ok
>+	ns_delete_both_ok
> )
> readonly TEST_DESCS=(
> 	# vm_server_host_client
>@@ -135,6 +138,15 @@ readonly TEST_DESCS=(
>
> 	# ns_same_local_vm_connect_to_local_host_ok
> 	"Run vsock_test client in VM in a local ns with server in same ns."
>+
>+	# ns_delete_vm_ok
>+	"Check that deleting the VM's namespace does not break the socket connection"
>+
>+	# ns_delete_host_ok
>+	"Check that deleting the host's namespace does not break the socket connection"
>+
>+	# ns_delete_both_ok
>+	"Check that deleting the VM and host's namespaces does not break the socket connection"
> )
>
> readonly USE_SHARED_VM=(
>@@ -1287,6 +1299,78 @@ test_vm_loopback() {
> 	return "${KSFT_PASS}"
> }
>
>+check_ns_delete_doesnt_break_connection() {
>+	local pipefile pidfile outfile
>+	local ns0="global0"
>+	local ns1="global1"
>+	local port=12345
>+	local pids=()
>+	local rc=0
>+
>+	init_namespaces
>+
>+	pidfile="$(create_pidfile)"
>+	if ! vm_start "${pidfile}" "${ns0}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+	vm_wait_for_ssh "${ns0}"
>+
>+	outfile=$(mktemp)
>+	vm_ssh "${ns0}" -- \
>+		socat VSOCK-LISTEN:"${port}",fork STDOUT > "${outfile}" 2>/dev/null &
>+	pids+=($!)
>+	vm_wait_for_listener "${ns0}" "${port}" "vsock"
>+
>+	# We use a pipe here so that we can echo into the pipe instead of using
>+	# socat and a unix socket file. We just need a name for the pipe (not a
>+	# regular file) so use -u.
>+	pipefile=$(mktemp -u /tmp/vmtest_pipe_XXXX)
>+	ip netns exec "${ns1}" \
>+		socat PIPE:"${pipefile}" VSOCK-CONNECT:"${VSOCK_CID}":"${port}" &
>+	pids+=($!)
>+
>+	timeout "${WAIT_PERIOD}" \
>+		bash -c 'while [[ ! -e '"${pipefile}"' ]]; do sleep 1; done; exit 0'
>+
>+	if [[ "$1" == "vm" ]]; then
>+		ip netns del "${ns0}"
>+	elif [[ "$1" == "host" ]]; then
>+		ip netns del "${ns1}"
>+	elif [[ "$1" == "both" ]]; then
>+		ip netns del "${ns0}"
>+		ip netns del "${ns1}"
>+	fi
>+
>+	echo "TEST" > "${pipefile}"
>+
>+	timeout "${WAIT_PERIOD}" \
>+		bash -c 'while [[ ! -s '"${outfile}"' ]]; do sleep 1; done; exit 0'
>+
>+	if grep -q "TEST" "${outfile}"; then
>+		rc="${KSFT_PASS}"
>+	else
>+		rc="${KSFT_FAIL}"
>+	fi
>+
>+	terminate_pidfiles "${pidfile}"
>+	terminate_pids "${pids[@]}"
>+	rm -f "${outfile}" "${pipefile}"
>+
>+	return "${rc}"
>+}
>+
>+test_ns_delete_vm_ok() {
>+	check_ns_delete_doesnt_break_connection "vm"
>+}
>+
>+test_ns_delete_host_ok() {
>+	check_ns_delete_doesnt_break_connection "host"
>+}
>+
>+test_ns_delete_both_ok() {
>+	check_ns_delete_doesnt_break_connection "both"
>+}
>+
> shared_vm_test() {
> 	local tname
>
>
>-- 
>2.47.3
>

