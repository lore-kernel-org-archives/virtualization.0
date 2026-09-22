Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9C936C588
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 01:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039919; cv=none; b=OzLaQrLOwFPfcB9xkqkdGPsupcL6Sc2Vm39/ZqZdtcPj6+UNhcRqN5aDOgUK6y4Gr524fiO65C686gCfpUP7gRuwyxZaqMZqPdAJUT65LP42ZYNnpvN94rxPYmN7RCw+n1lJYv2Zkfk+kKAUSnzJO5KUuoCJ1BYNFiVZvgI8Q7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039919; c=relaxed/simple;
	bh=O2u2pSj9Qz/3jUWj1+DPrF71Or2viln4RrS+4V/syQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NrS/XbC5uGwNKxYIj4xuNvnLN1n+N14obKvy6v3lO6uudws7BqzPKnYxwQYwZAoQDxirwss66hrjvwM46rEHap4RNKrzv7KEWfc+xQdHxg5q0Ii0fCS0tpuxCwT8GzQPBg0HeDh0mgx6S9QDmpjQZgZieg3hp5whYKOvi7WmF60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffZvGWFv; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffZvGWFv"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c54eed93e4so1406044b6e.3
        for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 18:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039915; x=1790644715; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQRMHNrBZb4fE3a5puaoEKZQMJld9V6GAqGwvxaywF4=;
        b=ffZvGWFvi94No5pwSEnwcsAleM0+E56Ok2vxpYCmcyCt12save8Z2a0I24aiotjYvd
         eBHFzv0xa5tpCEqe+/oHF4EAXWWARKzP9UCe+Utj1i6vqbyV7BXPrBMcE3osN6H4WDsP
         tYrmgqNZA421UEZX9DDS5/jd6H9Qe1xVLtwkS71E1pcmjop/kBFJdvh+2A6Y0HFxAvku
         inF+WetuYi/DwcwPeZpnNM7M2E4WNV2mAlHWY00NrkkQtsRsprIiTiGaqe+ZgCCpz1Fg
         anDQkprTT1fVnwVt9wZkzuAGhQdmwVkrgh3NrsIixuPHMaAj5Xvg6b4yWDPrk4rPym+S
         EpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039915; x=1790644715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CQRMHNrBZb4fE3a5puaoEKZQMJld9V6GAqGwvxaywF4=;
        b=e3EC2Spm6bkKFBeP6TxoBP6shm37Njy7E0vsiOx1X0Me124vghDrv6gIvTytPPWr2S
         FQZj8PlumAx9W9Z2+LA3NQjBByo40lIx5WVxpkrJA13LgadEAdxJd6zYTlBrLhWyMMKp
         7LVPg5xx6O39gO+6wuwZ43MwuNMevzhqIphNYX+tLR/N1gpsJXQGBC0aFXw/n05+NsFW
         UF544GwpqgJlM1KOo8X6tIpShpmff5DigEzUhP//Aymk/HYo2C4qhZkkD6dQL2RNYCfu
         l3FyuDAYN0358OMm8yRWPRV+vKBOMFoT/XnXY1CctB41CYEvk9WC0Et3wfPQhx/8sj9u
         zZPg==
X-Gm-Message-State: AFuF++mS2tm+ltazm7l5Ilnunt+NdrGY2C7BdWqcIN8UUcri5fT+7+ys
	GcOhXbQXlCMcn2Tg9VgD0Eia2oUPxG575nFYtgn8gyTcgOcSdLCeyqUD
X-Gm-Gg: AYBFou12yX2rEYStZ5Ho6XQ+bgStVaf0ddvMEokPX/XKxt4W+jf+JgRwOq6PspCr6/4
	K6eScsbt99eu5vjzG6N/A2i5Tw2UvCcQefWzcWuo28Epx5t2Eq5L/gkn8Jb6zbYLbmZXI6wEb2P
	K6qO1jbOneBPdS/dMVgsmps4JubIlCk2uMKWXE3nxINIu4THAPRFbIfJfk7t76SeNghv3G49XqQ
	r/hrqHIvZpxhwt/Wo4wRZScwqiMeCPDbEfxJJ5tcs4xaa1F1Tnao5V1XTgcutW4adU8+whZsPBa
	tDKoMMBvPfa7uvMxM1QijgHaz3MtCvl3aFIs8X+OH0vnONBrY2MLP3Mzt9aG2FzNJCUjYl+r7+P
	a0C9yVV+wvyqAMqRooV0CjCRx6ZAqXWEcaTTjGqoLl93WbFlpgnN/fkxtrRXx20OfwDm+fuzELr
	LYG1yDSTVvEWXlG0pn4cs8J/qZUzhMjc6UOx5Zrc3MZAICCaJKfKphgv4LtHJsq+lv/3M=
X-Received: by 2002:a05:6820:81c9:b0:6cd:3fdc:a931 with SMTP id 006d021491bc7-6cd3fecdef2mr8158701eaf.78.1790039915084;
        Mon, 21 Sep 2026 18:18:35 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d1dbd52475sm117564eaf.1.2026.09.21.18.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:18:33 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 21 Sep 2026 18:18:08 -0700
Subject: [PATCH net-next v2 5/6] selftests/vsock: test the guest vsock
 device network namespace
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vsock-guest-ns-v2-5-693bd78fde9e@meta.com>
References: <20260921-vsock-guest-ns-v2-0-693bd78fde9e@meta.com>
In-Reply-To: <20260921-vsock-guest-ns-v2-0-693bd78fde9e@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me, 
 jlinbox@meta.com, Stanislav Fomichev <sdf.kernel@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add tests for guest vsock device namespace assignment, including ns
destruction and the device moving between namespaces.

We do add ynl/cli.py, so have added python3 and PyYAML to the dependency
checks.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- Drive the assign with ynl cli.py, drop the vsock_assign_g2h_netns
  ioctl helper and its patch
- Terminate the guest socat sender too, it sometimes outlived the test
  and kept holding on to a port the next test binds
---
 tools/testing/selftests/vsock/vmtest.sh | 421 +++++++++++++++++++++++++++++++-
 1 file changed, 416 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 310dfc2a39ad..e94cc2fd90cc 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -17,6 +17,8 @@ readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)
 source "${SCRIPT_DIR}"/../kselftest/ktap_helpers.sh
 
 readonly VSOCK_TEST="${SCRIPT_DIR}"/vsock_test
+readonly YNL_CLI="${KERNEL_CHECKOUT}"/tools/net/ynl/pyynl/cli.py
+readonly VSOCK_SPEC="${KERNEL_CHECKOUT}"/Documentation/netlink/specs/vsock.yaml
 readonly TEST_GUEST_PORT=51000
 readonly TEST_HOST_PORT=50000
 readonly TEST_HOST_PORT_LISTENER=50001
@@ -73,6 +75,12 @@ readonly TEST_NAMES=(
 	ns_delete_vm_ok
 	ns_delete_host_ok
 	ns_delete_both_ok
+	ns_guest_local_connect_to_host_fails
+	ns_guest_assign_g2h_netns_connect_to_host_ok
+	ns_guest_assign_g2h_netns_init_ns_connect_fails
+	ns_guest_assign_g2h_netns_host_connect_ok
+	ns_guest_assign_g2h_netns_reset_on_ns_delete_ok
+	ns_guest_assign_g2h_netns_old_conn_send_fails
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -149,12 +157,36 @@ readonly TEST_DESCS=(
 
 	# ns_delete_both_ok
 	"Check that deleting the VM and host's namespaces does not break the socket connection"
+
+	# ns_guest_local_connect_to_host_fails
+	"Check a guest process in a local ns cannot reach the host without the netns assign."
+
+	# ns_guest_assign_g2h_netns_connect_to_host_ok
+	"Check a guest process in a local ns reaches the host once the vsock device is assigned to it."
+
+	# ns_guest_assign_g2h_netns_init_ns_connect_fails
+	"Check the guest's initial ns loses vsock once the device is assigned to another ns."
+
+	# ns_guest_assign_g2h_netns_host_connect_ok
+	"Check the host reaches a guest listener in the ns the vsock device is assigned to."
+
+	# ns_guest_assign_g2h_netns_reset_on_ns_delete_ok
+	"Check the guest's vsock device returns to the initial ns when its ns is deleted."
+
+	# ns_guest_assign_g2h_netns_old_conn_send_fails
+	"Check connections made before the assign stop sending once they lose the device."
 )
 
 readonly USE_SHARED_VM=(
 	vm_server_host_client
 	vm_client_host_server
 	vm_loopback
+	ns_guest_local_connect_to_host_fails
+	ns_guest_assign_g2h_netns_connect_to_host_ok
+	ns_guest_assign_g2h_netns_init_ns_connect_fails
+	ns_guest_assign_g2h_netns_host_connect_ok
+	ns_guest_assign_g2h_netns_reset_on_ns_delete_ok
+	ns_guest_assign_g2h_netns_old_conn_send_fails
 )
 readonly NS_MODES=("local" "global")
 
@@ -302,7 +334,8 @@ check_args() {
 }
 
 check_deps() {
-	for dep in vng ${QEMU} busybox pkill ssh ss socat nsenter; do
+	for dep in vng ${QEMU} busybox pkill ssh ss socat nsenter unshare \
+		python3; do
 		if [[ ! -x $(command -v "${dep}") ]]; then
 			echo -e "skip:    dependency ${dep} not found!\n"
 			exit "${KSFT_SKIP}"
@@ -314,6 +347,18 @@ check_deps() {
 		printf " Please build the kselftest vsock target.\n"
 		exit "${KSFT_SKIP}"
 	fi
+
+	if ! python3 -c "import yaml" &>/dev/null; then
+		echo -e "skip:    python3 yaml module not found!\n"
+		exit "${KSFT_SKIP}"
+	fi
+
+	for dep in "${YNL_CLI}" "${VSOCK_SPEC}"; do
+		if [[ ! -r "${dep}" ]]; then
+			printf "skip:    %s not found!\n" "${dep}"
+			exit "${KSFT_SKIP}"
+		fi
+	done
 }
 
 check_netns() {
@@ -401,6 +446,17 @@ setup_home() {
 	mkdir -p "$(dirname "${SSH_KEY_PATH}")"
 	ssh-keygen -t ed25519 -f "${SSH_KEY_PATH}" -N "" -q
 	cp "${VSOCK_TEST}" "${TEST_HOME}"/vsock_test
+
+	mkdir -p "${TEST_HOME}"/ynl
+	cp "${YNL_CLI}" "${TEST_HOME}"/ynl/
+	cp -r "$(dirname "${YNL_CLI}")"/lib "${TEST_HOME}"/ynl/
+	cp "${VSOCK_SPEC}" "${TEST_HOME}"/ynl/
+
+	# One of the tests runs the CLI as an unprivileged user, so the CLI
+	# has to be reachable by one.
+	chmod -R a+rX "${TEST_HOME}"/ynl
+
+	chmod 755 "${TEST_HOME}"
 }
 
 create_pidfile() {
@@ -528,6 +584,59 @@ vm_wait_for_ssh() {
 	done
 }
 
+# Create a local mode namespace in the VM and echo the pid holding it open.
+vm_ns_start() {
+	local ns=$1
+
+	vm_ssh "${ns}" -- \
+		"echo local > /proc/sys/net/vsock/child_ns_mode" &>/dev/null
+
+	vm_ssh "${ns}" -- "unshare -n sleep infinity" \
+		'>/dev/null 2>&1 & echo $!'
+}
+
+# Returns once the holder is gone, so that the namespace is unreferenced and
+# the kernel can start tearing it down.
+vm_ns_stop() {
+	local ns=$1
+	local nspid=$2
+
+	vm_ssh "${ns}" <<-EOF &>/dev/null
+		kill ${nspid}
+		for ((i = 0; i < ${WAIT_PERIOD_MAX}; i++)); do
+			kill -0 ${nspid} 2>/dev/null || break
+			sleep 1
+		done
+	EOF
+}
+
+# Runs in the guest's initial namespace when <nspid> is empty. The command must
+# not contain single quotes.
+vm_ns_exec() {
+	local ns=$1
+	local nspid=$2
+	local cmd=$3
+
+	if [[ -z "${nspid}" ]]; then
+		vm_ssh "${ns}" -- "${cmd}"
+		return
+	fi
+
+	vm_ssh "${ns}" -- nsenter -t "${nspid}" -n sh -c "'${cmd}'"
+}
+
+vm_ns_assign_g2h() {
+	local ns=$1
+	local nspid=$2
+
+	vm_ns_exec "${ns}" "${nspid}" "python3 /root/ynl/cli.py --no-schema \
+		--spec /root/ynl/vsock.yaml --do dev-netns-set"
+}
+
+vm_reset_g2h() {
+	vm_ns_assign_g2h "init_ns" "" &>/dev/null
+}
+
 # derived from selftests/net/net_helper.sh
 wait_for_listener()
 {
@@ -564,17 +673,33 @@ wait_for_listener()
 	done
 }
 
-vm_wait_for_listener() {
+# Runs in the guest's initial namespace when <nspid> is empty.
+vm_ns_wait_for_listener() {
 	local ns=$1
-	local port=$2
-	local protocol=$3
+	local nspid=$2
+	local port=$3
+	local protocol=$4
+	local nsenter=
+	local args
+
+	[[ -n "${nspid}" ]] && nsenter="nsenter -t ${nspid} -n"
+	args="${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX} ${protocol}"
 
 	vm_ssh "${ns}" <<EOF
 $(declare -f wait_for_listener)
-wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX} ${protocol}
+export -f wait_for_listener
+${nsenter} bash -c "wait_for_listener ${args}"
 EOF
 }
 
+vm_wait_for_listener() {
+	local ns=$1
+	local port=$2
+	local protocol=$3
+
+	vm_ns_wait_for_listener "${ns}" "" "${port}" "${protocol}"
+}
+
 host_wait_for_listener() {
 	local ns=$1
 	local port=$2
@@ -1421,6 +1546,292 @@ test_ns_delete_both_ok() {
 	check_ns_delete_doesnt_break_connection "both"
 }
 
+# Send a string from the guest to a host listener and leave what the host
+# received in <outfile>.
+guest_send_to_host() {
+	local ns=$1
+	local nspid=$2
+	local port=$3
+	local outfile=$4
+	local cmd="echo TEST | socat -u STDIN VSOCK-CONNECT:2:${port}"
+	local pid
+
+	socat -u VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" 2>/dev/null &
+	pid=$!
+	host_wait_for_listener "${ns}" "${port}" "vsock"
+
+	vm_ns_exec "${ns}" "${nspid}" "${cmd}" 2>/dev/null
+
+	timeout "${WAIT_PERIOD}" \
+		bash -c 'while [[ ! -s '"${outfile}"' ]]; do sleep 1; done'
+
+	terminate_pids "${pid}"
+}
+
+# Send a string from the host to a listener in the guest and leave what the
+# guest received in <outfile>.
+host_send_to_guest() {
+	local ns=$1
+	local nspid=$2
+	local port=$3
+	local outfile=$4
+	local cmd="socat -u VSOCK-LISTEN:${port} STDOUT"
+	local dst="VSOCK-CONNECT:${VSOCK_CID}:${port}"
+	local pid
+
+	vm_ns_exec "${ns}" "${nspid}" "${cmd}" > "${outfile}" 2>/dev/null &
+	pid=$!
+	vm_ns_wait_for_listener "${ns}" "${nspid}" "${port}" "vsock"
+
+	echo TEST | socat -u STDIN "${dst}" 2>/dev/null
+
+	timeout "${WAIT_PERIOD}" \
+		bash -c 'while [[ ! -s '"${outfile}"' ]]; do sleep 1; done'
+
+	terminate_pids "${pid}"
+}
+
+test_ns_guest_assign_g2h_netns_old_conn_send_fails() {
+	local gap=$(( WAIT_PERIOD * 3 ))
+	local port=12346
+	local outfile
+	local result
+	local sender
+	local nspid
+	local pid
+
+	nspid=$(vm_ns_start "init_ns")
+	if [[ -z "${nspid}" ]]; then
+		log_host "failed to create a namespace inside the guest"
+		return "${KSFT_FAIL}"
+	fi
+
+	outfile=$(mktemp)
+	socat -u VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" 2>/dev/null &
+	pid=$!
+	host_wait_for_listener "init_ns" "${port}" "vsock"
+
+	# Send a message, wait, then send another. While waiting, assign the
+	# device to a namespace. Confirm the second message does not arrive.
+	vm_ssh "init_ns" -- \
+		"(echo FIRST; sleep ${gap}; echo SECOND) |" \
+		"socat -u STDIN VSOCK-CONNECT:2:${port}" &>/dev/null &
+	sender=$!
+
+	sleep "${WAIT_PERIOD}"
+
+	if ! vm_ns_assign_g2h "init_ns" "${nspid}"; then
+		log_host "failed to assign the vsock device to the guest ns"
+		terminate_pids "${pid}" "${sender}"
+		rm -f "${outfile}"
+		vm_ns_stop "init_ns" "${nspid}"
+		vm_reset_g2h
+		return "${KSFT_FAIL}"
+	fi
+
+	# Let the second write happen and land, if it is going to.
+	sleep $(( gap + WAIT_PERIOD ))
+
+	terminate_pids "${pid}" "${sender}"
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	vm_ns_stop "init_ns" "${nspid}"
+	vm_reset_g2h
+
+	if [[ "${result}" != *FIRST* ]]; then
+		log_host "no connection before the assign: [${result}]"
+		return "${KSFT_FAIL}"
+	fi
+
+	if [[ "${result}" == *SECOND* ]]; then
+		log_host "old connection still delivered after the assign"
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_guest_local_connect_to_host_fails() {
+	local port=12345
+	local outfile
+	local result
+	local nspid
+
+	nspid=$(vm_ns_start "init_ns")
+	if [[ -z "${nspid}" ]]; then
+		log_host "failed to create a namespace inside the guest"
+		return "${KSFT_FAIL}"
+	fi
+
+	outfile=$(mktemp)
+	guest_send_to_host "init_ns" "${nspid}" "${port}" "${outfile}"
+
+	vm_ns_stop "init_ns" "${nspid}"
+	vm_reset_g2h
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" == TEST ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_guest_assign_g2h_netns_connect_to_host_ok() {
+	local port=12345
+	local outfile
+	local result
+	local nspid
+
+	nspid=$(vm_ns_start "init_ns")
+	if [[ -z "${nspid}" ]]; then
+		log_host "failed to create a namespace inside the guest"
+		return "${KSFT_FAIL}"
+	fi
+
+	if ! vm_ns_assign_g2h "init_ns" "${nspid}"; then
+		log_host "failed to assign the vsock device to the guest ns"
+		vm_ns_stop "init_ns" "${nspid}"
+		vm_reset_g2h
+		return "${KSFT_FAIL}"
+	fi
+
+	outfile=$(mktemp)
+	guest_send_to_host "init_ns" "${nspid}" "${port}" "${outfile}"
+
+	vm_ns_stop "init_ns" "${nspid}"
+	vm_reset_g2h
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" != TEST ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_guest_assign_g2h_netns_init_ns_connect_fails() {
+	local port=12345
+	local outfile
+	local result
+	local nspid
+
+	nspid=$(vm_ns_start "init_ns")
+	if [[ -z "${nspid}" ]]; then
+		log_host "failed to create a namespace inside the guest"
+		return "${KSFT_FAIL}"
+	fi
+
+	if ! vm_ns_assign_g2h "init_ns" "${nspid}"; then
+		log_host "failed to assign the vsock device to the guest ns"
+		vm_ns_stop "init_ns" "${nspid}"
+		vm_reset_g2h
+		return "${KSFT_FAIL}"
+	fi
+
+	# The device now belongs to a local-mode namespace, so the guest's
+	# initial namespace must no longer reach the host.
+	outfile=$(mktemp)
+	guest_send_to_host "init_ns" "" "${port}" "${outfile}"
+
+	vm_ns_stop "init_ns" "${nspid}"
+	vm_reset_g2h
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" == TEST ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_guest_assign_g2h_netns_host_connect_ok() {
+	local port=12345
+	local outfile
+	local result
+	local nspid
+
+	nspid=$(vm_ns_start "init_ns")
+	if [[ -z "${nspid}" ]]; then
+		log_host "failed to create a namespace inside the guest"
+		return "${KSFT_FAIL}"
+	fi
+
+	if ! vm_ns_assign_g2h "init_ns" "${nspid}"; then
+		log_host "failed to assign the vsock device to the guest ns"
+		vm_ns_stop "init_ns" "${nspid}"
+		vm_reset_g2h
+		return "${KSFT_FAIL}"
+	fi
+
+	outfile=$(mktemp)
+	host_send_to_guest "init_ns" "${nspid}" "${port}" "${outfile}"
+
+	vm_ns_stop "init_ns" "${nspid}"
+	vm_reset_g2h
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" != TEST ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_guest_assign_g2h_netns_reset_on_ns_delete_ok() {
+	local port=12345
+	local outfile
+	local result
+	local nspid
+	local i
+
+	nspid=$(vm_ns_start "init_ns")
+	if [[ -z "${nspid}" ]]; then
+		log_host "failed to create a namespace inside the guest"
+		return "${KSFT_FAIL}"
+	fi
+
+	if ! vm_ns_assign_g2h "init_ns" "${nspid}"; then
+		log_host "failed to assign the vsock device to the guest ns"
+		vm_ns_stop "init_ns" "${nspid}"
+		vm_reset_g2h
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_ns_stop "init_ns" "${nspid}"
+
+	# The holder is gone, but the namespace itself is dismantled from a
+	# workqueue, so the device does not come back the same instant. Retry
+	# until it does, rather than expecting the first send to succeed.
+	outfile=$(mktemp)
+	for ((i = 0; i < 5; i++)); do
+		sleep "${WAIT_PERIOD}"
+		guest_send_to_host "init_ns" "" "$(( port + i ))" "${outfile}"
+		result=$(cat "${outfile}")
+		if [[ "${result}" == TEST ]]; then
+			break
+		fi
+	done
+
+	rm -f "${outfile}"
+	vm_reset_g2h
+
+	if [[ "${result}" != TEST ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
 shared_vm_test() {
 	local tname
 

-- 
2.53.0-Meta

