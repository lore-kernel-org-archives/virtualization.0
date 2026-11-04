Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757263;
	b=IxrUgJypq6UiK2G0YyrQjn+v9dSlayMTckhpI0fHMFkD++vfv/zkjxWLk9MOskIaKvTh
	 GZAN4Bpsan7xuIvmihACelRWHfsntHmh8WvLd8iJM1ZvZpmbd8cujbB3Ezz4kDqju92Te
	 JlXZQHbvL6Ozaq0XQ9M95wlBEaMYO37buvWpb/4FBEYhm1qrhat2zv4vVfqrZ2W7n4i8p
	 omWAAXDwS03KrpZn7DAQ8MB9jmTjvIVP8SMUzJXq0wqKV43aU8mGdNKDq3zbLktwLwSeX
	 4HeaOXsUO2S6+Y+cGv11Ml6DMA796AhoLasdqXCq93qYmJz5WLjZcVKTlTUhLpCLc3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757263;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=GxkdG/Dl3xWarXPL1wkKFiT3BqGEfgSBRQnLy3BPbNo=;
	b=L8mb84m5GKl7eNWu+eoqZT30HZkaywomFCI/RketapM2tQNbQIysa+14G7kiD7sCmQOK
	 y8a3zS7dGSPCuTLdpnc7kctWW/W/FeonytQTjcH24FK2mYmZm4O1J6V+v6rCTTblZSHOI
	 O2P59i8alh3tRVp+9OViU5u5N59MB6L36uiQUv8w411Mn4youo/yL4nyZ5OIYe+iosCIH
	 HwChysQy0Kbm59xfAgvvQlGslAIebuxa/BVYMF69nuW507mdO/hEzak+V+ffJbBFPqAtT
	 HKwwlJoXmUatrWRaU1/6zGTO+8p7rUYE9pzdvGy0OLCx8WIPGsnEs9Qhx01xIauNB2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=apj00lgk;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD0C606A332
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 01:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CD0C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=apj00lgk
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A40T5RK2662374;
	Tue, 3 Nov 2026 17:54:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=GxkdG/Dl3xWarXPL1wkKFiT3BqGEfgSBRQnLy
	3BPbNo=; b=apj00lgk1l4t497TVZOOiAUGyhFhVebkivUEUtTnPLEN+csm0pqZI
	w4HFKbRFXZtGowSz6BrvwjVMQOiRE3AXxyLpsWeNjZeCI1vyxPuUiO9PYTM5MDoh
	b4lFPvDJDkkxQM9vdEG6SDmGV80hx1bk+tkXy1a8/3NJV9Z1TD5lJXnJPBi1L9Zi
	/c0curquiGV9d3/YCP5eP5+defLXXrEtQN6PYttkLSAhMuw4JiGVJRhqPzVisRKm
	U40/SYrKxwVnTMT7t2ySCRTqqeo5/EeIIZyr6YLJcKyD9zlJvAtUOeWqNT0Kwyqk
	DtLzeh/PZg6yzwGjmHs0BULYiy9r+8Lbg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hqmyv2s9m-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 03 Nov 2026 17:54:08 -0800 (PST)
Received: from localhost (2620:10d:c0a8:fe::f072) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Wed, 4 Nov
 2026 01:54:07 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Tue, 3 Nov 2026 17:53:22 -0800
Subject: [PATCH net-next v5 7/7] selftests/vsock: test the netns assign
 privilege checks
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
Message-ID: <20261103-vsock-guest-ns-v5-7-48179b9b66b8@meta.com>
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
X-Proofpoint-ORIG-GUID: g_Khp4yoyHnOrq95vI6ikEayXZLLDvJQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAwNyBTYWx0ZWRfX5R9ymhi7InlR
 ml/giaOY81l93eAOvw64w4pY6LP9dof/3fyefeRlby3QAEMgXaoPh7H5ZEMCPHNfff6HZXRisyv
 LuSzgpMYrQSb4nnTB50NgNRdPKBAHbY=
X-Authority-Analysis: v=2.4 cv=VcFir1p9 c=1 sm=1 tr=0 ts=6aea9040 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22 a=VabnemYjAAAA:8
 a=ehl-fRECcIfF51WkWLIA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: g_Khp4yoyHnOrq95vI6ikEayXZLLDvJQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAwNyBTYWx0ZWRfX7PsGX/WNNqKd
 q/JdnZ01mBQsB0xmeajxB12TeiCis8LTnuKeTTgD5aP+wkS7O+kA8+VFbratg1tb30Iv/QOvfUn
 9ZcHJfRKd0x29Wl9jibZJgmp1ljZX4rIYffiwWWhtaIbgOR3FU2HuXrzYrT/phoi7JMvnthRwAH
 y1J7AYj2+M96VRC7hA4z192k3sMAmxWOh8YUn/90rjZbjg7HSMkmSGiVvBG02uLfGpDe63slrj6
 6tMri1ppmgSxTyOKeQiiuynUnpf6gOBsG3tuiMXNFSaXmFB4uix3K2k5DE02VjtSNH8x5t6DpM1
 An2lRBFIKGB1D62kQ1Qi/zwPgl4DehWN6gua1m6c9Kr+kXZXkkEYWjeJQXyYq/3OfqGPoLbe446
 oCohXE9WwAw60mXJRkJWXpP6VGyDYRWJPEtsbgHeZ9j6KFEVnAR7Cz9/l3zCCtWRHE0qar0jW3j
 ZYruxuhhXG//bidKefA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01

VSOCK_CMD_DEV_NETNS_SET refuses callers without CAP_NET_ADMIN in the
init user namespace.

Add two tests: one confirms that CAP_NET_ADMIN is required even by a
privileged user and the other confirms that CAP_NET_ADMIN in an
unprivileged user ns alone is insufficient.

CONFIG_USER_NS is needed to test the CAP_NET_ADMIN + unprivileged user
ns case.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v4:
- Require EPERM in the privilege tests, cli.py does print the errno, and
  probe unshare -Urn so a setup failure skips (Sashiko)

Changes in v3:
- Require setpriv only for the ns_guest_ tests, not the whole script

Changes in v2:
- Assert only that the command fails, not EPERM: ynl's cli.py does not
  report the errno (Sashiko)
- Use ynl cli.py for the assign
---
 tools/testing/selftests/vsock/config    |  1 +
 tools/testing/selftests/vsock/vmtest.sh | 50 ++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/config b/tools/testing/selftests/vsock/config
index 5f0a4f17dfc9..4b31085558fa 100644
--- a/tools/testing/selftests/vsock/config
+++ b/tools/testing/selftests/vsock/config
@@ -109,3 +109,4 @@ CONFIG_FS_DAX=y
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_ZONE_DEVICE=y
+CONFIG_USER_NS=y
diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index f8aee1336a09..5bd90a0c2380 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -93,6 +93,8 @@ readonly TEST_NAMES=(
 	ns_guest_assign_g2h_netns_host_connect_ok
 	ns_guest_assign_g2h_netns_pins_ns_ok
 	ns_guest_assign_g2h_netns_old_conn_send_fails
+	ns_guest_assign_g2h_netns_no_cap_net_admin_fails
+	ns_guest_assign_g2h_netns_unpriv_user_ns_fails
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -187,6 +189,12 @@ readonly TEST_DESCS=(
 
 	# ns_guest_assign_g2h_netns_old_conn_send_fails
 	"Check connections made before the assign stop sending once they lose the device."
+
+	# ns_guest_assign_g2h_netns_no_cap_net_admin_fails
+	"Check assigning the guest's vsock device to a namespace needs CAP_NET_ADMIN."
+
+	# ns_guest_assign_g2h_netns_unpriv_user_ns_fails
+	"Check an unprivileged user cannot claim the guest's vsock device via a user ns."
 )
 
 readonly USE_SHARED_VM=(
@@ -199,6 +207,8 @@ readonly USE_SHARED_VM=(
 	ns_guest_assign_g2h_netns_host_connect_ok
 	ns_guest_assign_g2h_netns_pins_ns_ok
 	ns_guest_assign_g2h_netns_old_conn_send_fails
+	ns_guest_assign_g2h_netns_no_cap_net_admin_fails
+	ns_guest_assign_g2h_netns_unpriv_user_ns_fails
 )
 readonly NS_MODES=("local" "global")
 
@@ -368,7 +378,7 @@ check_ns_guest_deps() {
 		return 0
 	fi
 
-	for dep in unshare python3; do
+	for dep in unshare setpriv python3; do
 		if [[ ! -x $(command -v "${dep}") ]]; then
 			log_host "no ${dep} for test ${tname}"
 			return 1
@@ -1909,6 +1919,44 @@ test_ns_guest_assign_g2h_netns_pins_ns_ok() {
 	return "${KSFT_PASS}"
 }
 
+check_assign_g2h_eperm() {
+	local wrapper=$1
+	local out
+
+	if out=$(vm_ssh "init_ns" -- "${wrapper}" python3 /root/ynl/cli.py \
+		--no-schema --spec /root/ynl/vsock.yaml \
+		--do dev-netns-set 2>&1); then
+		log_host "assign unexpectedly succeeded under '${wrapper}'"
+		return "${KSFT_FAIL}"
+	fi
+
+	if [[ "${out}" != *"Operation not permitted"* ]]; then
+		log_host "no EPERM under '${wrapper}': [${out}]"
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_guest_assign_g2h_netns_no_cap_net_admin_fails() {
+	check_assign_g2h_eperm "unshare -n setpriv --bounding-set=-net_admin"
+}
+
+test_ns_guest_assign_g2h_netns_unpriv_user_ns_fails() {
+	local unpriv_uid=65534
+	local unpriv
+
+	unpriv="setpriv --reuid=${unpriv_uid} --regid=${unpriv_uid}"
+	unpriv="${unpriv} --clear-groups"
+
+	if ! vm_ssh "init_ns" -- "${unpriv} unshare -Urn true"; then
+		log_host "unprivileged user namespaces unavailable, skipping"
+		return "${KSFT_SKIP}"
+	fi
+
+	check_assign_g2h_eperm "${unpriv} unshare -Urn"
+}
+
 shared_vm_test() {
 	local tname
 

-- 
2.53.0-Meta

