Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794626459;
	b=ZBfiJbKkRAqIWQXOk7qbjVUdTFQDetqCQGK7eR3GQn7EnxiLAklcJXbRJN6oaJpQDoCa
	 l9YvE/hmIWXWsGKdc4UKxxh0rmTDCGrRDdojX2IVKnBjDZxoTYhqWcQsJtqL1cIW/agbh
	 vc9w3gO4pn9UuO3RZUMlnIdChpSWM7/4AiM2uxTA6E/EPlc1rlZfA+Bj93DXSmbbEqOKw
	 VnYAKcjS7rlGC12W2n7M//GDIunx4COmwG4K62H00bXiM2FwGRWSQcpDeJOnY4Fj7WfJZ
	 J3Kl+FDZykOj9QaUknddE8lO48/tKohdzF4iy+eOfes0evoImBlI2Bq4bviwnrealvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794626459;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version;
	bh=1MJ4ajYt+/6gjKRrzLBPO97Eo65no36J8Dg56yk6m0k=;
	b=Bggh7vVx6YLP4G27exKxOqu2jWlDK0aHQFZiJ0eD/H2Pz0tb4vFBvDJAPYFNsLKw3+Io
	 6ZhUR006WkJ7HhhANPgHVtRw2UZN61guU4r67LZm3c1xB/jPltfUAxFDPTXIUwLEX/K44
	 +US5OJNnP1xOQXtMokuI8qTH/X6PIccM5CvBwV6lmtazFXwVgoB7dXC4wBsJmwTinEgBv
	 v/uZLHSQmFjKNY97NymqOqyHGOqhBPm1cOtqNuSGGYxj+uk1ezKM96ieH4XJgPsFYSom+
	 EwDen/EvJE/CtTltibiQb7bqiYMxG5OpU1OPEx338v85vkq3t/nbxq0omUouXpjSi3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=fmgF78fB;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A271460A6F5B
	for <virtualization@lists.linux.dev>; Sat, 14 Nov 2026 03:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A271460A6F5B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=fmgF78fB
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE23GEm3922649;
	Fri, 13 Nov 2026 19:20:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=1MJ4ajYt+/6gjKRrzLBPO97Eo65no36J8Dg56
	yk6m0k=; b=fmgF78fB8yQ1U+3ff2SebrMuO737JqhWJ/9fcD15DauUHKuEEF5rD
	dOBSlW3ThaRtDn5jmkJ8Zz054ZpgcS6Abk3/ZQsA0V6WP8i9ASJR/i1Dp+HUWABA
	S0bxaFz1TcpYN/8puKGPbkT0GraIPSaMT9IDeUYS2Oj91s6H2vngWB+SLxkPAQ0a
	Kt47RB1x097VHt55/H9EKr3MYezoKO8k6Cibpeh3XqBAVzv+OL5sp14shHU4XavU
	L/vFGEVcAQyMspNHYVgnRTaUJiebRFKLeXaiNj3bGPxjGo1am6ThX+19VKq3Cf49
	jeklyarBxcZBykdjtsYLN+lBJRPowU87w==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hxdhnrgph-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 Nov 2026 19:20:27 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1c::1b) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sat, 14 Nov
 2026 03:20:26 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Fri, 13 Nov 2026 19:14:18 -0800
Subject: [PATCH net-next v6 7/8] selftests/vsock: test the guest vsock
 device network namespace
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261113-vsock-guest-ns-v6-7-3737ce4673c0@meta.com>
References: <20261113-vsock-guest-ns-v6-0-3737ce4673c0@meta.com>
In-Reply-To: <20261113-vsock-guest-ns-v6-0-3737ce4673c0@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Stefan Hajnoczi
	<stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang
	<jasowangio@gmail.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Shuah Khan
	<shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        Donald Hunter
	<donald.hunter@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>,
        George Zhang
	<georgezhang@vmware.com>, Andy King <acking@vmware.com>,
        Dmitry Torokhov
	<dtor@vmware.com>, Eric Dumazet <edumazet@kernel.org>
CC: <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <sargun@sargun.me>, <jlinbox@meta.com>,
        Bobby Eshleman <bobbyeshleman@gmail.com>,
        Bobby Eshleman
	<bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAxMiBTYWx0ZWRfX/Vrlbdc4j6Nb
 j8AP6+/G3audrXEPY6a26MVHUqHw3oZ2f6EXFrhNdFWqFaqBYM/SLe8ldvUQQWJZpqFvrHnjNat
 +ZKbxFkq4IAHIwmDUYd/PbBgTN/hTFQL6lrEZ3GYsLg4n+oFjX7UkI/5KidqEMo27Nkhgp9eUYt
 G7WX+auH6igirUJ25bBcdsm5+S9p/2DvEY1QTkTqMwe3qUZrl7tTRHla/jYXmFZ1mtno/Y3i282
 zkQxp6nHscVurG/e0YIIzF9Yf/ROC96OHtaFohWSXL4Di+PC6+qRhcZk+zAbzVvR7ck9HHbSUjE
 lHxdBUO0/QgW/4XqTQS2vL0xIS/anKEOTpFR1CSWL0z0WG2QTQg27b1WDJlBVI1xPO7IParPrmk
 um9GbUegZ64FxnjzO1mQm1yfjW8LGbVCD5punz6oft2c0ljsRP/oagcLzHfXj5n8onnszln6mTM
 6l8Qgcn8e+j1g2AGQuA==
X-Authority-Analysis: v=2.4 cv=ftxJ914f c=1 sm=1 tr=0 ts=6af7d37b cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22 a=VabnemYjAAAA:8
 a=gDTz01qrHhL5zdhS2SUA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: RcQEv3JP8h3WAtswHLR_CtaddIt0qF5_
X-Proofpoint-ORIG-GUID: RcQEv3JP8h3WAtswHLR_CtaddIt0qF5_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAxMiBTYWx0ZWRfX74vzkbEWhCy4
 VT47FKqvj4YqYYlP1cWqFpuPSBZzd4XOLB/UCvhnK0c9ZGTD1iwd7LEkqKaes5FHPoPgP+3+jM4
 xtLtYTM9MEhlek4aTRwo3K9UG6eNL+4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_01,2026-11-11_03,2025-10-01_01

Add tests for guest vsock device namespace assignment, including ns
destruction and the device moving between namespaces.

The tests drive the device through ynl's cli.py and create guest
namespaces with unshare, so they need python3, PyYAML and unshare. A
missing one skips only these tests, not the whole script.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v6:
- Add ns_guest_assign_g2h_netns_by_pid_ok for the netns-pid attribute

Changes in v4:
- Start the old_conn_send_fails stopwatch before the sender, so a slow
  guest skips rather than fails (Sashiko)

Changes in v3:
- Replace reset_on_ns_delete_ok with pins_ns_ok, to cover the netns
  pinning
- Skip only the ns_guest_ tests when PyYAML or the ynl CLI or spec is
  missing, and ship the ynl bits via TEST_FILES for installed trees
  (Sashiko)
- Also skip only the ns_guest_ tests when unshare or python3 is missing
- Make vm_ns_start() wait for the namespace and report failure (Sashiko)
- Poll for FIRST in old_conn_send_fails instead of sleeping, and report
  an over-long assign as a skip (Sashiko)
- Kill the guest-side socat by name, $! names a local subshell (Sashiko)
- Wait for the host listener to exit before the next test binds its
  port (Sashiko)

Changes in v2:
- Drive the assign with ynl cli.py, drop the vsock_assign_g2h_netns
  ioctl helper and its patch
- Terminate the guest socat sender too, it sometimes outlived the test
  and kept holding on to a port the next test binds
---
 tools/testing/selftests/vsock/Makefile  |   5 +
 tools/testing/selftests/vsock/vmtest.sh | 544 +++++++++++++++++++++++++++++++-
 2 files changed, 543 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/vsock/Makefile b/tools/testing/selftests/vsock/Makefile
index c407c0afd938..2b066ba91bcd 100644
--- a/tools/testing/selftests/vsock/Makefile
+++ b/tools/testing/selftests/vsock/Makefile
@@ -13,5 +13,10 @@ $(VSOCK_TEST_DIR)/vsock_test: $(VSOCK_TEST_SRCS)
 TEST_PROGS += vmtest.sh
 TEST_GEN_FILES := vsock_test
 
+TEST_FILES := \
+	../../../net/ynl/pyynl/cli.py \
+	../../../net/ynl/pyynl/lib \
+	../../../../Documentation/netlink/specs/vsock.yaml
+
 include ../lib.mk
 
diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 310dfc2a39ad..a800b63dfbb1 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -17,6 +17,20 @@ readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)
 source "${SCRIPT_DIR}"/../kselftest/ktap_helpers.sh
 
 readonly VSOCK_TEST="${SCRIPT_DIR}"/vsock_test
+
+# "make install" copies the ynl CLI, its lib package and the spec next to this
+# script (see TEST_FILES); in a source tree they stay where they are built.
+if [[ -r "${SCRIPT_DIR}"/cli.py ]]; then
+	readonly YNL_CLI="${SCRIPT_DIR}"/cli.py
+	readonly YNL_LIB="${SCRIPT_DIR}"/lib
+	readonly VSOCK_SPEC="${SCRIPT_DIR}"/vsock.yaml
+else
+	readonly YNL_DIR="${KERNEL_CHECKOUT}"/tools/net/ynl/pyynl
+	readonly YNL_CLI="${YNL_DIR}"/cli.py
+	readonly YNL_LIB="${YNL_DIR}"/lib
+	readonly SPEC_DIR="${KERNEL_CHECKOUT}"/Documentation/netlink/specs
+	readonly VSOCK_SPEC="${SPEC_DIR}"/vsock.yaml
+fi
 readonly TEST_GUEST_PORT=51000
 readonly TEST_HOST_PORT=50000
 readonly TEST_HOST_PORT_LISTENER=50001
@@ -73,6 +87,13 @@ readonly TEST_NAMES=(
 	ns_delete_vm_ok
 	ns_delete_host_ok
 	ns_delete_both_ok
+	ns_guest_local_connect_to_host_fails
+	ns_guest_assign_g2h_netns_connect_to_host_ok
+	ns_guest_assign_g2h_netns_by_pid_ok
+	ns_guest_assign_g2h_netns_init_ns_connect_fails
+	ns_guest_assign_g2h_netns_host_connect_ok
+	ns_guest_assign_g2h_netns_pins_ns_ok
+	ns_guest_assign_g2h_netns_old_conn_send_fails
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -149,12 +170,40 @@ readonly TEST_DESCS=(
 
 	# ns_delete_both_ok
 	"Check that deleting the VM and host's namespaces does not break the socket connection"
+
+	# ns_guest_local_connect_to_host_fails
+	"Check a guest process in a local ns cannot reach the host without the netns assign."
+
+	# ns_guest_assign_g2h_netns_connect_to_host_ok
+	"Check a guest process in a local ns reaches the host once the vsock device is assigned to it."
+
+	# ns_guest_assign_g2h_netns_by_pid_ok
+	"Check the vsock device can be assigned to a ns given by PID from outside it."
+
+	# ns_guest_assign_g2h_netns_init_ns_connect_fails
+	"Check the guest's initial ns loses vsock once the device is assigned to another ns."
+
+	# ns_guest_assign_g2h_netns_host_connect_ok
+	"Check the host reaches a guest listener in the ns the vsock device is assigned to."
+
+	# ns_guest_assign_g2h_netns_pins_ns_ok
+	"Check the assignment keeps the ns alive when deleted, and that reassigning releases it."
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
+	ns_guest_assign_g2h_netns_by_pid_ok
+	ns_guest_assign_g2h_netns_init_ns_connect_fails
+	ns_guest_assign_g2h_netns_host_connect_ok
+	ns_guest_assign_g2h_netns_pins_ns_ok
+	ns_guest_assign_g2h_netns_old_conn_send_fails
 )
 readonly NS_MODES=("local" "global")
 
@@ -316,6 +365,34 @@ check_deps() {
 	fi
 }
 
+check_ns_guest_deps() {
+	local tname=$1
+	local dep
+
+	if [[ ! "${tname}" =~ ^ns_guest_ ]]; then
+		return 0
+	fi
+
+	for dep in unshare python3; do
+		if [[ ! -x $(command -v "${dep}") ]]; then
+			log_host "no ${dep} for test ${tname}"
+			return 1
+		fi
+	done
+
+	if ! python3 -c "import yaml" &>/dev/null; then
+		log_host "no python3 yaml module for test ${tname}"
+		return 1
+	fi
+
+	if [[ ! -r "${YNL_CLI}" ]] || [[ ! -r "${VSOCK_SPEC}" ]]; then
+		log_host "no ynl cli or vsock spec for test ${tname}"
+		return 1
+	fi
+
+	return 0
+}
+
 check_netns() {
 	local tname=$1
 
@@ -401,6 +478,19 @@ setup_home() {
 	mkdir -p "$(dirname "${SSH_KEY_PATH}")"
 	ssh-keygen -t ed25519 -f "${SSH_KEY_PATH}" -N "" -q
 	cp "${VSOCK_TEST}" "${TEST_HOME}"/vsock_test
+
+	mkdir -p "${TEST_HOME}"/ynl
+	if [[ -r "${YNL_CLI}" ]]; then
+		cp "${YNL_CLI}" "${TEST_HOME}"/ynl/
+		cp -r "${YNL_LIB}" "${TEST_HOME}"/ynl/
+		cp "${VSOCK_SPEC}" "${TEST_HOME}"/ynl/
+	fi
+
+	# One of the tests runs the CLI as an unprivileged user, so the CLI
+	# has to be reachable by one.
+	chmod -R a+rX "${TEST_HOME}"/ynl
+
+	chmod 755 "${TEST_HOME}"
 }
 
 create_pidfile() {
@@ -528,6 +618,82 @@ vm_wait_for_ssh() {
 	done
 }
 
+# Create a local mode namespace in the VM and echo the pid holding it open.
+vm_ns_start() {
+	local ns=$1
+	local initns
+	local nspid
+	local newns
+	local i
+
+	local mode=/proc/sys/net/vsock/child_ns_mode
+
+	if ! vm_ssh "${ns}" -- "echo local > ${mode}" &>/dev/null; then
+		return
+	fi
+
+	nspid=$(vm_ssh "${ns}" -- "unshare -n sleep infinity" \
+		'>/dev/null 2>&1 & echo $!')
+	if [[ -z "${nspid}" ]]; then
+		return
+	fi
+
+	initns=$(vm_ssh "${ns}" -- "readlink /proc/self/ns/net")
+	for ((i = 0; i < WAIT_PERIOD_MAX; i++)); do
+		newns=$(vm_ssh "${ns}" -- "readlink /proc/${nspid}/ns/net" \
+			2>/dev/null)
+		if [[ -n "${newns}" ]] && [[ "${newns}" != "${initns}" ]]; then
+			echo "${nspid}"
+			return
+		fi
+		sleep 1
+	done
+
+	vm_ns_stop "${ns}" "${nspid}"
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
@@ -564,17 +730,33 @@ wait_for_listener()
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
@@ -1421,6 +1603,354 @@ test_ns_delete_both_ok() {
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
+	# Wait for the listener to actually go, or the next test binding the
+	# same port races it and silently reads nothing.
+	terminate_pids "${pid}"
+	wait "${pid}" 2>/dev/null
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
+	vm_ns_exec "${ns}" "${nspid}" \
+		"pkill -f VSOCK-LISTEN:${port}" &>/dev/null
+	terminate_pids "${pid}"
+	wait "${pid}" 2>/dev/null
+}
+
+ns_old_conn_cleanup() {
+	local port=$1
+	local pid=$2
+	local sender=$3
+	local outfile=$4
+	local nspid=$5
+
+	vm_ns_exec "init_ns" "" "pkill -f VSOCK-CONNECT:2:${port}" &>/dev/null
+	terminate_pids "${pid}" "${sender}"
+	wait "${pid}" "${sender}" 2>/dev/null
+	rm -f "${outfile}"
+	vm_ns_stop "init_ns" "${nspid}"
+	vm_reset_g2h
+}
+
+test_ns_guest_assign_g2h_netns_old_conn_send_fails() {
+	local gap=$(( WAIT_PERIOD * 3 ))
+	local port=12346
+	local elapsed
+	local started
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
+	started=${SECONDS}
+	vm_ssh "init_ns" -- \
+		"(echo FIRST; sleep ${gap}; echo SECOND) |" \
+		"socat -u STDIN VSOCK-CONNECT:2:${port}" &>/dev/null &
+	sender=$!
+
+	timeout "$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))" \
+		bash -c 'while [[ ! -s '"${outfile}"' ]]; do sleep 1; done'
+
+	if ! vm_ns_assign_g2h "init_ns" "${nspid}"; then
+		log_host "failed to assign the vsock device to the guest ns"
+		ns_old_conn_cleanup "${port}" "${pid}" "${sender}" \
+			"${outfile}" "${nspid}"
+		return "${KSFT_FAIL}"
+	fi
+	elapsed=$(( SECONDS - started ))
+
+	sleep $(( gap + WAIT_PERIOD ))
+
+	result=$(cat "${outfile}")
+	ns_old_conn_cleanup "${port}" "${pid}" "${sender}" \
+		"${outfile}" "${nspid}"
+
+	if [[ "${result}" != *FIRST* ]]; then
+		log_host "no connection before the assign: [${result}]"
+		return "${KSFT_FAIL}"
+	fi
+
+	if [[ $(( elapsed + 1 )) -ge ${gap} ]]; then
+		log_host "connect and assign took ${elapsed}s of a ${gap}s gap"
+		return "${KSFT_SKIP}"
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
+test_ns_guest_assign_g2h_netns_by_pid_ok() {
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
+	if ! vm_ssh "init_ns" -- python3 /root/ynl/cli.py --no-schema \
+		--spec /root/ynl/vsock.yaml --do dev-netns-set \
+		--json "'{\"netns-pid\": ${nspid}}'"; then
+		log_host "failed to assign the vsock device by PID"
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
+test_ns_guest_assign_g2h_netns_pins_ns_ok() {
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
+	vm_ns_stop "init_ns" "${nspid}"
+	sleep "${WAIT_PERIOD}"
+
+	outfile=$(mktemp)
+	guest_send_to_host "init_ns" "" "${port}" "${outfile}"
+	result=$(cat "${outfile}")
+	if [[ "${result}" == TEST ]]; then
+		log_host "device returned to the init ns instead of pinning it"
+		rm -f "${outfile}"
+		vm_reset_g2h
+		return "${KSFT_FAIL}"
+	fi
+
+	# Assigning it back is what releases the deleted namespace.
+	vm_reset_g2h
+
+	guest_send_to_host "init_ns" "" "$(( port + 1 ))" "${outfile}"
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" != TEST ]]; then
+		log_host "device did not come back on reassign: [${result}]"
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
 shared_vm_test() {
 	local tname
 
@@ -1453,7 +1983,8 @@ run_shared_vm_tests() {
 			continue
 		fi
 
-		if ! check_netns "${arg}"; then
+		if ! check_netns "${arg}" ||
+		   ! check_ns_guest_deps "${arg}"; then
 			check_result "${KSFT_SKIP}" "${arg}"
 			continue
 		fi
@@ -1517,7 +2048,8 @@ run_ns_tests() {
 			continue
 		fi
 
-		if ! check_netns "${arg}"; then
+		if ! check_netns "${arg}" ||
+		   ! check_ns_guest_deps "${arg}"; then
 			check_result "${KSFT_SKIP}" "${arg}"
 			continue
 		fi

-- 
2.53.1-Meta

