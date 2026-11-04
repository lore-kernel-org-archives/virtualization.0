Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757268;
	b=aBcm3ZmN3pdCEUck2xpEh2CSf0JFnl9sT9LEZYT4Njlq+fGNDeOymrQaEWUsPv69m4au
	 CTaxnbPdPgEcTXAaFNo2PquMR8XCgs5Uwz8BAWiKwXRgqMoLjjehkpKeCGwr3wLvCQJCi
	 MA6w8SCs5QoIRtV7fPBH6PAWvig/cke8re9StzH/SYPPiSuZABD1gvv9l2mUWjdqxSrp/
	 wOr2S/9W5l4R6UuaCs20ejhauxb5ZuHpKA6tHjn8GisMLcDyU8OO2x3qZhwmQzqX8L8eW
	 vYvjRSWpQFZr8CVVh1/fq4PAYuldyKZ68pbEWBTw4j2H60UKft8dtrMg55qQE7DFhsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757268;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version;
	bh=5k1N2Js0SfVvfWjaVF3vgyTDwUhkemawtCQi5cXuHYY=;
	b=LJDz3lL/PMHHxHDGm/smSsVbvoAX372EyvTXboY7G6IfkDdrwMwbGx3CA6WSbrbGYTMt
	 uScfovDYbp37pH98C4tlfDSvXwiLUfrP6i7z4vVAtzl8ZVx4eW+T6tgQRTJWgUAUbZEXy
	 QX4JQ3955jCW2oAJZBcg/elAFyB/r1fKsUoQlOClP9bvRFdDwjdtczC4hQb73Lzalbe1i
	 YLWL9iSaCnjbiHGoghh6QY8Kh87khsSrP48ERuG6iF803pxHLvSLy2H3Z5OgRGQaWorL7
	 nmWeXxuAUpoihznKmzsPR6MtWO6Q8qT07/yVA2KEYcAsnyKfUFDxq70Aut6inpU2IEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=TLgJtHxZ;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A08606A33D
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 01:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97A08606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=TLgJtHxZ
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A40Suw93696504;
	Tue, 3 Nov 2026 17:54:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=5k1N2Js0SfVvfWjaVF3vgyTDwUhkemawtCQi5
	cXuHYY=; b=TLgJtHxZh8aqI40ItPpGGoiNTvRQ/gYcl7JZ4tOMANSCeo+kkMNht
	brCww2GC3PgOnRnFw8WjJeII3CyRfSBqeO4MkrF6Jvck/o5aQC7gG7U96tmR4oj1
	yoCmv32BzGCBvA7w97oikR/yY1ZABk0bYGQhODFDMjACcNWyFgmGwGqIn8COmqSZ
	noxXJvM+TKY147C5pTdfTJa0H9ixW8aluMVYFjcypXmrLa4t7d36VKFMLJn/PXTi
	hGn4nSY3iwdrlwM1wHP9sMn29NU0lHe3oxvgdLkdMc7FeCks0uPmLS45cEdl+fvA
	CTIvLSRgP8bybzNE+EWZfjQWZ/GIiRtMw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hqrad13vm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 03 Nov 2026 17:54:08 -0800 (PST)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Wed, 4 Nov
 2026 01:54:06 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Tue, 3 Nov 2026 17:53:21 -0800
Subject: [PATCH net-next v5 6/7] selftests/vsock: test the guest vsock
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
Message-ID: <20261103-vsock-guest-ns-v5-6-48179b9b66b8@meta.com>
References: <20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com>
In-Reply-To: <20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com>
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
        Eric Dumazet
	<edumazet@kernel.org>
CC: <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <sargun@sargun.me>, <jlinbox@meta.com>,
        Bobby Eshleman <bobbyeshleman@gmail.com>,
        Bobby Eshleman
	<bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=fLWsTpae c=1 sm=1 tr=0 ts=6aea9040 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22 a=VabnemYjAAAA:8
 a=CMzfravdsZyu_tbiwAgA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: wVDBxmQ5H8jtha7tOaW-pH1vpxkN_Uyc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAwNyBTYWx0ZWRfX17aF1/8Fz+5W
 yX25q/1PA51+ixQVndVk/EEbqj5Xl0cVGJVJqJwUxSavBM5vTxenk+W5eQEOBWCRcTSp13NLwSY
 9ZkCEtgmoEP7i+s60m7ft0XDYolkPlQJnFJgG8Sky99mmCWPxvFCMNqXrZKZseRXALQPZnC+WGO
 Rutufi9Q2rGoJ4F/KqttY1bclCcOcvkgvs1dEsg54JpZSeM+1XX46kG6xSqeYXAG5qrMhel4UoJ
 MZA63oiM1VwaigWCI2UCnfx3dhcdOi28PlnXsWqxQ7j8dGiDUUqJSrQwHwpwv+z6C+FVc0y1Ojn
 0VveTkTMu5UeHl4xHEzAXl/gTuIuv5zIaP1YX+lqviBM1oQNVwSVzCLtWxqxywp+dPCluFGOq0P
 RED/ueojw93flJvWxcJ+gdzl0/e1IT8YsNGB5vGHZbUhmFNx3yeVhA4sOexmWKVjYpiwDapVC8k
 tpXPvRl8NJO5OmIplFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAwNyBTYWx0ZWRfX7eGNLAkR6R7g
 Vhje4k+SCaXD/0XTfLi8J4ta9KotK0pO3NNLzhev2yahKKd+HtOJlS2Y1goEGlWnFUwoTu8+3aU
 igHrbMdB05YS6DcY2Hu33KY/mifvGL0=
X-Proofpoint-GUID: wVDBxmQ5H8jtha7tOaW-pH1vpxkN_Uyc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01

Add tests for guest vsock device namespace assignment, including ns
destruction and the device moving between namespaces.

The tests drive the device through ynl's cli.py and create guest
namespaces with unshare, so they need python3, PyYAML and unshare. A
missing one skips only these tests, not the whole script.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
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
 tools/testing/selftests/vsock/vmtest.sh | 502 +++++++++++++++++++++++++++++++-
 2 files changed, 501 insertions(+), 6 deletions(-)

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
index 310dfc2a39ad..f8aee1336a09 100755
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
@@ -73,6 +87,12 @@ readonly TEST_NAMES=(
 	ns_delete_vm_ok
 	ns_delete_host_ok
 	ns_delete_both_ok
+	ns_guest_local_connect_to_host_fails
+	ns_guest_assign_g2h_netns_connect_to_host_ok
+	ns_guest_assign_g2h_netns_init_ns_connect_fails
+	ns_guest_assign_g2h_netns_host_connect_ok
+	ns_guest_assign_g2h_netns_pins_ns_ok
+	ns_guest_assign_g2h_netns_old_conn_send_fails
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -149,12 +169,36 @@ readonly TEST_DESCS=(
 
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
+	ns_guest_assign_g2h_netns_init_ns_connect_fails
+	ns_guest_assign_g2h_netns_host_connect_ok
+	ns_guest_assign_g2h_netns_pins_ns_ok
+	ns_guest_assign_g2h_netns_old_conn_send_fails
 )
 readonly NS_MODES=("local" "global")
 
@@ -316,6 +360,34 @@ check_deps() {
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
 
@@ -401,6 +473,19 @@ setup_home() {
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
@@ -528,6 +613,82 @@ vm_wait_for_ssh() {
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
@@ -564,17 +725,33 @@ wait_for_listener()
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
@@ -1421,6 +1598,317 @@ test_ns_delete_both_ok() {
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
 
@@ -1453,7 +1941,8 @@ run_shared_vm_tests() {
 			continue
 		fi
 
-		if ! check_netns "${arg}"; then
+		if ! check_netns "${arg}" ||
+		   ! check_ns_guest_deps "${arg}"; then
 			check_result "${KSFT_SKIP}" "${arg}"
 			continue
 		fi
@@ -1517,7 +2006,8 @@ run_ns_tests() {
 			continue
 		fi
 
-		if ! check_netns "${arg}"; then
+		if ! check_netns "${arg}" ||
+		   ! check_ns_guest_deps "${arg}"; then
 			check_result "${KSFT_SKIP}" "${arg}"
 			continue
 		fi

-- 
2.53.0-Meta

