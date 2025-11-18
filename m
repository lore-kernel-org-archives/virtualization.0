Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF4421A459
	for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 18:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489764; cv=none; b=NqDdlcLjHB5l0szaXjHf2oqbubfcO9aJ3mjhwJis3N+TOSubct1G84BPxGMR7McRFqC83zXN7ttLcB8Lx0BoW4z+tc5x19HUMKAXoPPWNPto58IwlSlrLid9xPDUhh31gykEeu/AWmFe1HuXLgDBv+1ry8nQFKs58PnqEQmnO94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489764; c=relaxed/simple;
	bh=z9jngTjYXX2N3hDh12UT7kNeVGRmibW/GBVfuJWh90U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=n5tl2/hxe/FJHId1H0iqQ5CNTnc1ALckf8qwaA3PyI5NwotVGtwyqBpeKxzEqfvkwqzgzqNxdnJFkfF99vQN4HwC7lpYR0/T2iIpOMpcgJ/h+6ykig1QZITlA0CxGCFEz9ieVmCpoqT26ZS9nyx/I84qFcSijy5rTtkajLHiJGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HwSeHjnT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HwSeHjnT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763489761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PCsmT1+txPJIS2fQNp3IVXkXdkTCnaVV7j7GhmxtV/c=;
	b=HwSeHjnTtxeGL1um019AnZKVXd9Bk8/JAu5iei1k/W/k+mGsV3s0mYtd9ryqY+ceg+28QY
	PmnfAZq6ps6zBfQVN1OWZxYLGxu1xOAIt6flCPKP6XiW9JKKu+NPMrDzh54OD/650sUT4E
	RKFpOq6VRPk7kpmEt33UK6N7y2Zv0vM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-ywKtTccKO46sXaRgcVoRTg-1; Tue, 18 Nov 2025 13:16:00 -0500
X-MC-Unique: ywKtTccKO46sXaRgcVoRTg-1
X-Mimecast-MFC-AGG-ID: ywKtTccKO46sXaRgcVoRTg_1763489759
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-64174630bf9so5137129a12.1
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 10:16:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763489759; x=1764094559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCsmT1+txPJIS2fQNp3IVXkXdkTCnaVV7j7GhmxtV/c=;
        b=jGlClnid18NWWUrECpBxL4tciu5YUPdAs127Kphr9zbOAkK2tNl0DveyxXQh4cV1kZ
         yT7YULobdSXjAYEC7aelLMfTbY7kJqW27mdIWJk6FG7BXwU42y4JFSAnKDTyHWk++gkX
         St1FlBotHwtQFazDwfAKLbcmK+rJ8uw9QA5bZM20ITaqCro3pQCKSMbeU7btVpZug/rn
         bqiskkCsgQuQoRcN4krbZBTwzItEJChCcrlcB7EfS8iL3eddZTk5gOjZzie1Doj6RBHU
         UHS3tc+RFKl3iqZ5v8OnTvUwL19s1wl3QS28ZmklbyNtRAq9ZxJvhsutrlaW0Tr8yM5S
         ipCA==
X-Forwarded-Encrypted: i=1; AJvYcCVkarBnz/j1Ivq196jgh8jid8y8HnLsiVUHb17H/Ay6mqgysE6xYfXLX9DOBiKiKdnaLOO+z7E06USyXdEJTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyrNNIUad7e/yd1aLB29ix85oo+52x1oep7eRi8RjviNDaPtnON
	/+PJltXzslKWCoOpSy4ARmpdXmA+Ft8A6as1psVU9RjfnYRrDy1okTEorgrAaHJ+i861ZhBBcu4
	n4wZlXDTNWAZS/86iEIBlok0ia5WiidPyWU+jEnZb0q19QMimeZivsfaDi+jHmb95MUta
X-Gm-Gg: ASbGncstCJmTJXodnqTIRZ2eucUKwpjbgcZ6YtIsNXwFWuvo6YA4b/K6i2dvvvsoX4j
	XcUsn2P3CPaVqvXSnJk8V6iVmoXGvnHFwTAecae495kPqcf3gNV9JtoHm3tWnQ3bT8KSPPQwDa3
	fXQTJdijmcrE6XNniqFFiNbM/hhjWNfs/KlrYSpq0thJWqSLiGUoXLafsfeFz73li4xzP0fb1qV
	KLFIUWih3a4m6Y+CJmLXeVh9BOhv2vVdOdLwIqb2KeQTC5wFAOuS6drLTYj3kXX+fwasfNWeimD
	BqSDczYY0CzJflWdYKAObDcN5YULMpm1OqDKnZ0b8N8P/+AHyROCQrZIb95L+QjopZBXg5+r0vO
	wTWqzN3daybQFU0s1AabwEh9MFpuNt/+tYvQaVZZzaqZIlo/piMB9kW+Fguo=
X-Received: by 2002:a05:6402:42c4:b0:643:18c2:124e with SMTP id 4fb4d7f45d1cf-64350e0eedamr16148795a12.7.1763489758983;
        Tue, 18 Nov 2025 10:15:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoN0mxHlnHDgcN+NdZ5LOvg9qXOI9RJny5diigWO606GHOiHMHqYfRilSL5Y7K5784adc2+Q==
X-Received: by 2002:a05:6402:42c4:b0:643:18c2:124e with SMTP id 4fb4d7f45d1cf-64350e0eedamr16148731a12.7.1763489758430;
        Tue, 18 Nov 2025 10:15:58 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-250.retail.telecomitalia.it. [82.57.51.250])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a4b28bbsm12919260a12.28.2025.11.18.10.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:15:56 -0800 (PST)
Date: Tue, 18 Nov 2025 19:15:50 +0100
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
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 11/11] selftests/vsock: add tests for
 namespace deletion and mode changes
Message-ID: <snj3w4fhh2az6wp6kf7ca3bgd6jp2aawvyic7thdnoktdumbx6@zmjqiorc2uda>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-11-df08f165bf3e@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251117-vsock-vmtest-v10-11-df08f165bf3e@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bFVPziSZ_MNktZKuNQiHa1I5DurP5WOzW_9LTlXIEnE_1763489759
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Nov 17, 2025 at 06:00:34PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add tests that validate vsock sockets are resilient to deleting
>namespaces or changing namespace modes from global to local. The vsock
>sockets should still function normally.
>
>The function check_ns_changes_dont_break_connection() is added to re-use
>the step-by-step logic of 1) setup connections, 2) do something that
>would maybe break the connections, 3) check that the connections are
>still ok.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v9:
>- more consistent shell style
>- clarify -u usage comment for pipefile
>---
> tools/testing/selftests/vsock/vmtest.sh | 123 ++++++++++++++++++++++++++++++++
> 1 file changed, 123 insertions(+)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 9c12c1bd1edc..2b6e94aafc19 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -66,6 +66,12 @@ readonly TEST_NAMES=(
> 	ns_same_local_loopback_ok
> 	ns_same_local_host_connect_to_local_vm_ok
> 	ns_same_local_vm_connect_to_local_host_ok
>+	ns_mode_change_connection_continue_vm_ok
>+	ns_mode_change_connection_continue_host_ok
>+	ns_mode_change_connection_continue_both_ok
>+	ns_delete_vm_ok
>+	ns_delete_host_ok
>+	ns_delete_both_ok
> )
> readonly TEST_DESCS=(
> 	# vm_server_host_client
>@@ -135,6 +141,24 @@ readonly TEST_DESCS=(
>
> 	# ns_same_local_vm_connect_to_local_host_ok
> 	"Run vsock_test client in VM in a local ns with server in same ns."
>+
>+	# ns_mode_change_connection_continue_vm_ok
>+	"Check that changing NS mode of VM namespace from global to local after a connection is established doesn't break the connection"
>+
>+	# ns_mode_change_connection_continue_host_ok
>+	"Check that changing NS mode of host namespace from global to 
>local after a connection is established doesn't break the connection"
>+
>+	# ns_mode_change_connection_continue_both_ok
>+	"Check that changing NS mode of host and VM namespaces from global to local after a connection is established doesn't break the connection"
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
>@@ -1256,6 +1280,105 @@ test_ns_vm_local_mode_rejected() {
> 	return "${KSFT_PASS}"
> }
>
>+check_ns_changes_dont_break_connection() {
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
>+
>+	# wait_for_listener() does not work for vsock because vsock does not
>+	# export socket state to /proc/net/. Instead, we have no choice but to
>+	# sleep for some hardcoded time.
>+	sleep "${WAIT_PERIOD}"

can we use `ss --vsock --listening` ?

>+
>+	# We use a pipe here so that we can echo into the pipe instead of using
>+	# socat and a unix socket file. We just need a name for the pipe (not a
>+	# regular file) so use -u.
>+	pipefile=$(mktemp -u /tmp/vmtest_pipe_XXXX)

Should we remove this file at the end of the test?

>+	ip netns exec "${ns1}" \
>+		socat PIPE:"${pipefile}" VSOCK-CONNECT:"${VSOCK_CID}":"${port}" &
>+	pids+=($!)
>+
>+	timeout "${WAIT_PERIOD}" \
>+		bash -c 'while [[ ! -e '"${pipefile}"' ]]; do sleep 1; done; exit 0'
>+
>+	if [[ $2 == "delete" ]]; then
>+		if [[ "$1" == "vm" ]]; then
>+			ip netns del "${ns0}"
>+		elif [[ "$1" == "host" ]]; then
>+			ip netns del "${ns1}"
>+		elif [[ "$1" == "both" ]]; then
>+			ip netns del "${ns0}"
>+			ip netns del "${ns1}"
>+		fi
>+	elif [[ $2 == "change_mode" ]]; then
>+		if [[ "$1" == "vm" ]]; then
>+			ns_set_mode "${ns0}" "local"
>+		elif [[ "$1" == "host" ]]; then
>+			ns_set_mode "${ns1}" "local"
>+		elif [[ "$1" == "both" ]]; then
>+			ns_set_mode "${ns0}" "local"
>+			ns_set_mode "${ns1}" "local"
>+		fi
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
>+	rm -f "${outfile}"
>+
>+	return "${rc}"
>+}
>+
>+test_ns_mode_change_connection_continue_vm_ok() {
>+	check_ns_changes_dont_break_connection "vm" "change_mode"
>+}
>+
>+test_ns_mode_change_connection_continue_host_ok() {
>+	check_ns_changes_dont_break_connection "host" "change_mode"
>+}
>+
>+test_ns_mode_change_connection_continue_both_ok() {
>+	check_ns_changes_dont_break_connection "both" "change_mode"
>+}
>+
>+test_ns_delete_vm_ok() {
>+	check_ns_changes_dont_break_connection "vm" "delete"
>+}
>+
>+test_ns_delete_host_ok() {
>+	check_ns_changes_dont_break_connection "host" "delete"
>+}
>+
>+test_ns_delete_both_ok() {
>+	check_ns_changes_dont_break_connection "both" "delete"
>+}
>+
> shared_vm_test() {
> 	local tname
>
>
>-- 
>2.47.3
>

