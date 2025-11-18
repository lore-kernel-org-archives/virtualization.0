Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D903590BB
	for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489633; cv=none; b=tATWms8iRhP4IcUILUf//jRjwha3SwLx/px6EpxyfXcTSJBd6Mb31JjJrf/RFEq5DUecnHjGMYvPjdtcJzPr8Jp7V8oX7Ga4obnppC/Xp7Fhcmgmlfo17aJkKkZC0U3/SzSG8tBAZeGPnJCEJMkM60A1HolZt/QGfJ15iLo7lQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489633; c=relaxed/simple;
	bh=t3HokRBvzk92tWqhfXFr5XVYUp8FzOUrOhuoJpPP+58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FfnNRQYzfjvupx9S3warHipl17GNAKHHxTBU7H1bbKOuVlNZXldu53oc4PQ5gaxu1RQcHg9FV+piS+UAtGwUpYxIIxtP5i/FvW6rLupo7yzULWUQsq+wDIRKusjeehi3bAKoI79cYYYNX38msiX1IMwrNsNNg4Y9SQqvQE6HGxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RrxqIc0A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrxqIc0A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763489630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cA4eJ9pim7VdQNrmudwFzP70yzHXe562WV92nI6SXhs=;
	b=RrxqIc0ANWWp4QhZm1rQo1Qd7Oy6bRkyG5HBWm9KaK5VexZ1AewVrQp3Bja3DjkuvsEpxA
	U1EoWuHhnaHWkYNNBXIwH/QVcdgRLm197bJIxquHkCjtyeY14FhZqm/Z91Yp0nz8R7grYN
	aeIS2T4eFj1BBSSG46od/F9p/lRHaXI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-4THsw28EOACkeWyQkTt5pQ-1; Tue, 18 Nov 2025 13:13:48 -0500
X-MC-Unique: 4THsw28EOACkeWyQkTt5pQ-1
X-Mimecast-MFC-AGG-ID: 4THsw28EOACkeWyQkTt5pQ_1763489627
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so14573775e9.3
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 10:13:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763489627; x=1764094427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cA4eJ9pim7VdQNrmudwFzP70yzHXe562WV92nI6SXhs=;
        b=s5IZWv8aSEsns5eB/C2lmxWtmKSNlumnJW7WsA23xA0z3FJEvuPzlz4Xvg/8Dcuhom
         QxllicOA/lGcw2PPMVg/Y1K+7T9TAwH/eristtkLh8JDot2nB2euBiVFlol2FEO28QTJ
         VpU5wYChXxcf9ZMB4PJhIRnB7/RSUFMS7FYJ96nl6DlQROM9surHyOWDrIt8tYwRrjlz
         ifm6Cc/gpNRQRbyhKNx4rmq13h7eaQzugt1ttfw0tMzz64d7PwyEtNPH29MndXIKr835
         QR2vXIPOLUF9jaoJzbKsbbzuTNYAxUm4Ip46CCQaTKZjDWNtN1YCBTFIq6H1btkvj8Cz
         WTEg==
X-Forwarded-Encrypted: i=1; AJvYcCVGDNuNzn5ZiWOw9d6XbdJx5DnKE6JH1O3pOt53Be9+0SuF///3WbNC5VqNZ81Ogz0boq6fF9KIKe35DvZvTA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywgb5d+K/Fv0dB4xvGUbWmv5P8m/Tr4VSp9yXZVlvP5fCJU7xYi
	O1TWsUG27yfBr0Uj0Z61dPbShCIGG+55ZdP4BQp4y9fvh//tBqRz+8Ek287X2VtPFmYahUcPptz
	KPJWkI74jtimBn9EFhRY5dn6o8Ne7w6aIRnsyntXBKykJjgSbqnGSqj/rmo9xIr8X9cvb
X-Gm-Gg: ASbGncvBlvx+eWMHAvdWNdHKP/wmCP+Z0zeVdIx4zTGZ3Qv/fTSMJAUMDWpQ8438n8b
	vQqPUk1JAv5FWnJpCiRjsMH9iTzuOq3Ek7UvPQ0Y6WQmqhjPHHe01wqUW4rdyGF9Q0aXFsFwxeX
	/Ffrhm2+ukWE1WHYmh5UxX/ns+I5hCYHtjJ9TV5UlREovqp1FX9uXlAucC8aqLw3Za7iFiUSnaH
	t2YjD/BQ3T/8HTMq2eWUUQwMZBr3d9E/ioBK4/vw06Vkv5Vr50FVRq9Jdnj/psEWR3iPrsUP1QM
	qYJINRLFWyKhncmxzKygj8VWALtdw+D5VoCHzwNEEseD8SrfxopuOaMonz1dQ2Fr+OmEAM1I0uf
	NiPegDtVK7+kZXd4Bcyd8/vkNHcgwtHwo7ZVwcl8fvaxev9MP6leT+CEgNRI=
X-Received: by 2002:a05:600c:4fd2:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-4778fe4fa18mr162302185e9.2.1763489626877;
        Tue, 18 Nov 2025 10:13:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJW+/iuChgFRraW70MIR1TDXfcEwMvm+w71wLHAdMua0RyeIpmzX027JJ8Fn6LsaDHZf5jnw==
X-Received: by 2002:a05:600c:4fd2:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-4778fe4fa18mr162301985e9.2.1763489626387;
        Tue, 18 Nov 2025 10:13:46 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-250.retail.telecomitalia.it. [82.57.51.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1022a32sm5350695e9.8.2025.11.18.10.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:13:45 -0800 (PST)
Date: Tue, 18 Nov 2025 19:13:31 +0100
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
Subject: Re: [PATCH net-next v10 08/11] selftests/vsock: add tests for proc
 sys vsock ns_mode
Message-ID: <4xfytzvgzk55cl4xbe7if56yodshsevfgvc34ubiwb5ozr6arn@nksp3rfq7jm6>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-8-df08f165bf3e@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251117-vsock-vmtest-v10-8-df08f165bf3e@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zt8Vuqepg844TmZ5OhaYVgPoVSGzR2ZgfZx4QEXBL2Q_1763489627
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Nov 17, 2025 at 06:00:31PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add tests for the /proc/sys/net/vsock/ns_mode interface.  Namely,
>that it accepts "global" and "local" strings and enforces a write-once
>policy.
>
>Start a convention of commenting the test name over the test
>description. Add test name comments over test descriptions that existed
>before this convention.
>
>Add a check_netns() function that checks if the test requires namespaces
>and if the current kernel supports namespaces. Skip tests that require
>namespaces if the system does not have namespace support.
>
>Add a test to verify that guest VMs with an active G2H transport
>(virtio-vsock) cannot set namespace mode to 'local'. This validates
>the mutual exclusion between G2H transports and LOCAL mode.
>
>This patch is the first to add tests that do *not* re-use the same
>shared VM. For that reason, it adds a run_tests() function to run these
>tests and filter out the shared VM tests.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v10:
>- Remove extraneous add_namespaces/del_namespaces calls.
>- Rename run_tests() to run_ns_tests() since it is designed to only
>  run ns tests.
>
>Changes in v9:
>- add test ns_vm_local_mode_rejected to check that guests cannot use
>  local mode
>---
> tools/testing/selftests/vsock/vmtest.sh | 140 +++++++++++++++++++++++++++++++-
> 1 file changed, 138 insertions(+), 2 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 1a7c810f282f..86483249f490 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -41,14 +41,40 @@ readonly KERNEL_CMDLINE="\
> 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
> "
> readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
>-readonly TEST_NAMES=(vm_server_host_client vm_client_host_server vm_loopback)
>+readonly TEST_NAMES=(
>+	vm_server_host_client
>+	vm_client_host_server
>+	vm_loopback
>+	ns_host_vsock_ns_mode_ok
>+	ns_host_vsock_ns_mode_write_once_ok
>+	ns_vm_local_mode_rejected
>+)
> readonly TEST_DESCS=(
>+	# vm_server_host_client
> 	"Run vsock_test in server mode on the VM and in client mode on the host."
>+
>+	# vm_client_host_server
> 	"Run vsock_test in client mode on the VM and in server mode on the host."
>+
>+	# vm_loopback
> 	"Run vsock_test using the loopback transport in the VM."
>+
>+	# ns_host_vsock_ns_mode_ok
>+	"Check /proc/sys/net/vsock/ns_mode strings on the host."
>+
>+	# ns_host_vsock_ns_mode_write_once_ok
>+	"Check /proc/sys/net/vsock/ns_mode is write-once on the host."
>+
>+	# ns_vm_local_mode_rejected
>+	"Test that guest VM with G2H transport cannot set namespace mode to 'local'"
> )
>
>-readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
>+readonly USE_SHARED_VM=(
>+	vm_server_host_client
>+	vm_client_host_server
>+	vm_loopback
>+	ns_vm_local_mode_rejected
>+)
> readonly NS_MODES=("local" "global")
>
> VERBOSE=0
>@@ -205,6 +231,20 @@ check_deps() {
> 	fi
> }
>
>+check_netns() {
>+	local tname=$1
>+
>+	# If the test requires NS support, check if NS support exists
>+	# using /proc/self/ns
>+	if [[ "${tname}" =~ ^ns_ ]] &&

If check_netns() is based on the test name, IMO we should document that 
on top of TEST_NAMES.

Thanks,
Stefano

>+	   [[ ! -e /proc/self/ns ]]; then
>+		log_host "No NS support detected for test ${tname}"
>+		return 1
>+	fi
>+
>+	return 0
>+}
>+
> check_vng() {
> 	local tested_versions
> 	local version
>@@ -503,6 +543,32 @@ log_guest() {
> 	LOG_PREFIX=guest log "$@"
> }
>
>+test_ns_host_vsock_ns_mode_ok() {
>+	for mode in "${NS_MODES[@]}"; do
>+		if ! ns_set_mode "${mode}0" "${mode}"; then
>+			return "${KSFT_FAIL}"
>+		fi
>+	done
>+
>+	return "${KSFT_PASS}"
>+}
>+
>+test_ns_host_vsock_ns_mode_write_once_ok() {
>+	for mode in "${NS_MODES[@]}"; do
>+		local ns="${mode}0"
>+		if ! ns_set_mode "${ns}" "${mode}"; then
>+			return "${KSFT_FAIL}"
>+		fi
>+
>+		# try writing again and expect failure
>+		if ns_set_mode "${ns}" "${mode}"; then
>+			return "${KSFT_FAIL}"
>+		fi
>+	done
>+
>+	return "${KSFT_PASS}"
>+}
>+
> test_vm_server_host_client() {
> 	if ! vm_vsock_test "init_ns" "server" 2 "${TEST_GUEST_PORT}"; then
> 		return "${KSFT_FAIL}"
>@@ -544,6 +610,26 @@ test_vm_loopback() {
> 	return "${KSFT_PASS}"
> }
>
>+test_ns_vm_local_mode_rejected() {
>+	# Guest VMs have a G2H transport (virtio-vsock) active, so they
>+	# should not be able to set namespace mode to 'local'.
>+	# This test verifies that the sysctl write fails as expected.
>+
>+	# Try to set local mode in the guest's init_ns
>+	if vm_ssh init_ns "echo local | tee /proc/sys/net/vsock/ns_mode &>/dev/null"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	# Verify mode is still 'global'
>+	local mode
>+	mode=$(vm_ssh init_ns "cat /proc/sys/net/vsock/ns_mode")
>+	if [[ "${mode}" != "global" ]]; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
> shared_vm_test() {
> 	local tname
>
>@@ -576,6 +662,11 @@ run_shared_vm_tests() {
> 			continue
> 		fi
>
>+		if ! check_netns "${arg}"; then
>+			check_result "${KSFT_SKIP}" "${arg}"
>+			continue
>+		fi
>+
> 		run_shared_vm_test "${arg}"
> 		check_result "$?" "${arg}"
> 	done
>@@ -629,6 +720,49 @@ run_shared_vm_test() {
> 	return "${rc}"
> }
>
>+run_ns_tests() {
>+	for arg in "${ARGS[@]}"; do
>+		if shared_vm_test "${arg}"; then
>+			continue
>+		fi
>+
>+		if ! check_netns "${arg}"; then
>+			check_result "${KSFT_SKIP}" "${arg}"
>+			continue
>+		fi
>+
>+		add_namespaces
>+
>+		name=$(echo "${arg}" | awk '{ print $1 }')
>+		log_host "Executing test_${name}"
>+
>+		host_oops_before=$(dmesg 2>/dev/null | grep -c -i 'Oops')
>+		host_warn_before=$(dmesg --level=warn 2>/dev/null | grep -c -i 'vsock')
>+		eval test_"${name}"
>+		rc=$?
>+
>+		host_oops_after=$(dmesg 2>/dev/null | grep -c -i 'Oops')
>+		if [[ "${host_oops_after}" -gt "${host_oops_before}" ]]; then
>+			echo "FAIL: kernel oops detected on host" | log_host
>+			check_result "${KSFT_FAIL}" "${name}"
>+			del_namespaces
>+			continue
>+		fi
>+
>+		host_warn_after=$(dmesg --level=warn 2>/dev/null | grep -c -i 'vsock')
>+		if [[ "${host_warn_after}" -gt "${host_warn_before}" ]]; then
>+			echo "FAIL: kernel warning detected on host" | log_host
>+			check_result "${KSFT_FAIL}" "${name}"
>+			del_namespaces
>+			continue
>+		fi
>+
>+		check_result "${rc}" "${name}"
>+
>+		del_namespaces
>+	done
>+}
>+
> BUILD=0
> QEMU="qemu-system-$(uname -m)"
>
>@@ -674,6 +808,8 @@ if shared_vm_tests_requested "${ARGS[@]}"; then
> 	terminate_pidfiles "${pidfile}"
> fi
>
>+run_ns_tests "${ARGS[@]}"
>+
> echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
> echo "Log: ${LOG}"
>
>
>-- 
>2.47.3
>

