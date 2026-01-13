Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04F434DB7E
	for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323053; cv=none; b=Ul8l/15RJMUxgoSzsao8D/c4aCbL+HRUAwGydRVgXat4tJHTXcNMyDuLI1e8XwoUK9rghmpAnnUm3UsuQXiUNCUWzpk1+lEC3/6ppHPbtSzMemYKoTveygMrzHjOQ/bE/K+RhPTpfylTjcgGGTY8JsfNga1WERi3iNn2Mg5xJac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323053; c=relaxed/simple;
	bh=l/MzUKV5vBhOjr5ZED+tJpwan1YXWA9mauHZNOyldN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oj/gjgrU9ZAbob6FLMgUZhkqcXnVEp/aCJX1Gl+1ElJrijARzAgMHYV/KzD4MLopQTpl9SkT+r5ukz1Z6YCSak/uQlyM9C+JhsUT8Oyw7KNwcldom5gbJSUxGkWCQUjW526XkzyiTR+P+fy7VRRTQ5QKXjeuQrAHCCHGlsMcRBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPDsUKYM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPDsUKYM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768323049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DG0WRw7YxgTU3+MntFsjdanWVcUUw4Bpd9rGhDr013E=;
	b=EPDsUKYM/iHMyQzeU3SwLfDtsJ1qv5zoEfA83mHcT1a3H2GG7h/rSHDKmvL0cQ8tzzPgqW
	nF3Zyuzl5TALA33M7Hw8+tL71JFsqVEq2sDGbQgBGGwdVqrLeXmYK38zJQD/rwpK5+Pw7z
	DRDpDAoEJufKchehzbgYTkMMmlMs1KI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-W-JAzOSIN9efWS5yIBBAaA-1; Tue, 13 Jan 2026 11:50:48 -0500
X-MC-Unique: W-JAzOSIN9efWS5yIBBAaA-1
X-Mimecast-MFC-AGG-ID: W-JAzOSIN9efWS5yIBBAaA_1768323047
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4776079ada3so78178915e9.1
        for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 08:50:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768323047; x=1768927847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DG0WRw7YxgTU3+MntFsjdanWVcUUw4Bpd9rGhDr013E=;
        b=AVg+QnwvkWdZESqRIZQCsMq4swcIIPSSFSUSsVv2a3uViaJ8jLqSYa3RCr5AiWUDX/
         ++9MCTYpWFBnLTrBPkIgGJomQr2n41VJyUVplkNsp5WTacWWXBYF9EV8efRI7i9snkzx
         zyrkgmxANf94G2F2SQZNE0YBDe/RgV7TQVzESF+CO4X7a+GfOk6p3HNT7JofZlKYcMi5
         Xk50b1n6WA2hqqUyrz7maF7U8YX4PmzNHwA5eVMC13FZIA89UYI79iMFLvati/hTrcS2
         Bb/8YDJQdymTPnWHXnmlqTGxo0Ylo5sGBaIE+9Au77bBhlyBrJWy4dOnPCsVRme2WVo8
         QqUg==
X-Forwarded-Encrypted: i=1; AJvYcCXWxXxqY9UMh8VV6KhIAlS7VmgtBYvremCCWR7t+lNKdtXrcDAGO5hbMivehLBuZ+fv4cz+t2+zBz30T5Pk6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSLV0NxwCcLyZuiCJHesUR9yfSIWSzV6AMl9CUvOcbFCZ6SIDD
	ZZxzVktZ175gJ62h0qneZHuYjSv+mOPLjH/Ov9ZKd6HxrANLGWvNFo9liMU5il9WvK86KNFr9De
	neoyK0wt+mYaae/qgTwRIsOTJsML+exj6EZGL1H4qh2shpb+uoybl7gGxgCExjyMGLmL5
X-Gm-Gg: AY/fxX46RceVYm/iXAk3dauo8EwzBWjgDLnjR3x0e3SLy6NU97fyPQ/eGhaWqz7qbuF
	pD7GsuvQSUVO5jF7MmRpNyYjJmBuUNIAE4s2HUPOjCoV5BekGTTUJSb92p5BQxPgBU9B6ryaJmP
	pw/v4D0vLOn2QCNQYi2QrDlwMTcfemhFlH5dcDSzS8LlBOLTd06woXg1vcEOhgRvCxILGkvOR8U
	tvekOyNUReqlh+jcaPaVvjR/JCp85hqYoBfzAaHMG+OZjptdLO/Pa7euPGNiHA977ReR79Iplc0
	ume2TjpuP8TFk+Y90W/UQHok0KTJIgWkTZS2ZA/1zV8cvR9IHXJAvCHxTF1g9haZidIpn3wb7Dl
	MmxcY6Zk/u7AOBgLbMu1c/ONCk91qHIE1HHBK2eTXGOXnO82WFd/w0/wCuai4Ww==
X-Received: by 2002:a05:600c:4692:b0:47d:3ead:7439 with SMTP id 5b1f17b1804b1-47d84b5403dmr248980075e9.37.1768323047194;
        Tue, 13 Jan 2026 08:50:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlubu09xauLTgM5vIaUwncOAsAxE5DLD0jbAoR78s6Ju0YY/wLL6jLo1N3GDIcOu7AsHYzxQ==
X-Received: by 2002:a05:600c:4692:b0:47d:3ead:7439 with SMTP id 5b1f17b1804b1-47d84b5403dmr248979725e9.37.1768323046648;
        Tue, 13 Jan 2026 08:50:46 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee134a057sm7988835e9.14.2026.01.13.08.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 08:50:46 -0800 (PST)
Date: Tue, 13 Jan 2026 17:50:35 +0100
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
Subject: Re: [PATCH net-next v14 09/12] selftests/vsock: add tests for proc
 sys vsock ns_mode
Message-ID: <aWZ3xxGbK0Ccldv9@sgarzare-redhat>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
 <20260112-vsock-vmtest-v14-9-a5c332db3e2b@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260112-vsock-vmtest-v14-9-a5c332db3e2b@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1Bx8aH6zlDfpIjbdCaSy8SokdX73BRJwOANcIfC1SVw_1768323047
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jan 12, 2026 at 07:11:18PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add tests for the /proc/sys/net/vsock/{ns_mode,child_ns_mode}
>interfaces. Namely, that they accept/report "global" and "local" strings
>and enforce their access policies.
>
>Start a convention of commenting the test name over the test
>description. Add test name comments over test descriptions that existed
>before this convention.
>
>Add a check_netns() function that checks if the test requires namespaces
>and if the current kernel supports namespaces. Skip tests that require
>namespaces if the system does not have namespace support.
>
>This patch is the first to add tests that do *not* re-use the same
>shared VM. For that reason, it adds a run_ns_tests() function to run
>these tests and filter out the shared VM tests.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v13:
>- remove write-once test ns_host_vsock_ns_mode_write_once_ok to reflect
>  removing the write-once policy
>- add child_ns_mode test test_ns_host_vsock_child_ns_mode_ok
>- modify test_ns_host_vsock_ns_mode_ok() to check that the correct mode
>  was inherited from child_ns_mode
>
>Changes in v12:
>- remove ns_vm_local_mode_rejected test, due to dropping that constraint
>
>Changes in v11:
>- Document ns_ prefix above TEST_NAMES (Stefano)
>
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

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 0e681d4c3a15..38785a102236 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -41,14 +41,38 @@ readonly KERNEL_CMDLINE="\
> 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
> "
> readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
>-readonly TEST_NAMES=(vm_server_host_client vm_client_host_server vm_loopback)
>+
>+# Namespace tests must use the ns_ prefix. This is checked in check_netns() and
>+# is used to determine if a test needs namespace setup before test execution.
>+readonly TEST_NAMES=(
>+	vm_server_host_client
>+	vm_client_host_server
>+	vm_loopback
>+	ns_host_vsock_ns_mode_ok
>+	ns_host_vsock_child_ns_mode_ok
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
>+	# ns_host_vsock_child_ns_mode_ok
>+	"Check /proc/sys/net/vsock/ns_mode is read-only and child_ns_mode is writable."
> )
>
>-readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
>+readonly USE_SHARED_VM=(
>+	vm_server_host_client
>+	vm_client_host_server
>+	vm_loopback
>+)
> readonly NS_MODES=("local" "global")
>
> VERBOSE=0
>@@ -196,6 +220,20 @@ check_deps() {
> 	fi
> }
>
>+check_netns() {
>+	local tname=$1
>+
>+	# If the test requires NS support, check if NS support exists
>+	# using /proc/self/ns
>+	if [[ "${tname}" =~ ^ns_ ]] &&
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
>@@ -519,6 +557,54 @@ log_guest() {
> 	LOG_PREFIX=guest log "$@"
> }
>
>+ns_get_mode() {
>+	local ns=$1
>+
>+	ip netns exec "${ns}" cat /proc/sys/net/vsock/ns_mode 2>/dev/null
>+}
>+
>+test_ns_host_vsock_ns_mode_ok() {
>+	for mode in "${NS_MODES[@]}"; do
>+		local actual
>+
>+		actual=$(ns_get_mode "${mode}0")
>+		if [[ "${actual}" != "${mode}" ]]; then
>+			log_host "expected mode ${mode}, got ${actual}"
>+			return "${KSFT_FAIL}"
>+		fi
>+	done
>+
>+	return "${KSFT_PASS}"
>+}
>+
>+test_ns_host_vsock_child_ns_mode_ok() {
>+	local orig_mode
>+	local rc
>+
>+	orig_mode=$(cat /proc/sys/net/vsock/child_ns_mode)
>+
>+	rc="${KSFT_PASS}"
>+	for mode in "${NS_MODES[@]}"; do
>+		local ns="${mode}0"
>+
>+		if echo "${mode}" 2>/dev/null > /proc/sys/net/vsock/ns_mode; then
>+			log_host "ns_mode should be read-only but write succeeded"
>+			rc="${KSFT_FAIL}"
>+			continue
>+		fi
>+
>+		if ! echo "${mode}" > /proc/sys/net/vsock/child_ns_mode; then
>+			log_host "child_ns_mode should be writable to ${mode}"
>+			rc="${KSFT_FAIL}"
>+			continue
>+		fi
>+	done
>+
>+	echo "${orig_mode}" > /proc/sys/net/vsock/child_ns_mode
>+
>+	return "${rc}"
>+}
>+
> test_vm_server_host_client() {
> 	if ! vm_vsock_test "init_ns" "server" 2 "${TEST_GUEST_PORT}"; then
> 		return "${KSFT_FAIL}"
>@@ -592,6 +678,11 @@ run_shared_vm_tests() {
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
>@@ -645,6 +736,49 @@ run_shared_vm_test() {
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
>@@ -690,6 +824,8 @@ if shared_vm_tests_requested "${ARGS[@]}"; then
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

