Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C716F30D3EB
	for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791845377; cv=none; b=hZdJjMcUNOx+m4+ka5McBjUSk5TEyA/0iVRnfZVpnENM7J1ztQUyIJBXBOgSM+ysqG+CGtiEQ4YOz6x6uiXCh6PUQIjKDVgd1XPhdKUJmiD0b7ggo8nTVa28FPRLpipAqwQ0XXREKPcsyIH3QYm5DNQxgRqW/xrbChlagEwDW3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791845377; c=relaxed/simple;
	bh=Uflvu9o3Tf1o1o2kOWVHQ/oUQ6OAnRm4XFaNypsQaiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=iBbOKnpPPqO+eRP2GNRrpzsYFadUzJw5ErGR4drnyDLzpM49dVsVuaRJ6loYW4xyGsBAzXz80/4iDb0PZmISsFBoZVaiLM/WkkADcxjjUmQdSuesCbtNAnbzXdXf1VgZcMbdcoFUMwwyIY0xH1tsKY9uE8AoDLpdVS3srgcf9uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=arZwgk+m; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="arZwgk+m"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CJOhFW1060277;
	Mon, 12 Oct 2026 15:49:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=2nz+v+R8l94S02t93riyzoSS3nvjG8vzF4Ylc
	mo4+qw=; b=arZwgk+mYJ+Sy/Dupz4jSaxO5Sn+WoJog5D1YpTEQFq/mlvGkRKRR
	o7bOBmzVKF/Nal1VRfrxt1LUgW8U8k0tBqIqbUhd5GtywJ3za3wxkmv1wnV928Ei
	A8D0IYPmoSbE0wGAysuEga8AJz/0ufHawXm0NPNwBBUTqimm4oX/vAlbhm+AcWwa
	bZpoEEtdf68WT73C7QFyjXBLnDT7CdvzoS4Lrz8mlieDlge/dkJKq7iPdsAk6w6D
	LKwVAlaTbiFtvi2fmHSpMNouzIy3K31xMXQSg8EjZOMYjW2kI+WX8dGATy53NJqR
	ePOEgosVBZItmdKOc5d03ctrPzRPdq0QA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4h7k208a4p-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 12 Oct 2026 15:49:23 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::4) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.49; Mon, 12 Oct
 2026 22:49:21 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Mon, 12 Oct 2026 15:48:38 -0700
Subject: [PATCH net-next v3 7/7] selftests/vsock: test the netns assign
 privilege checks
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261012-vsock-guest-ns-v3-7-b32447c66b23@meta.com>
References: <20261012-vsock-guest-ns-v3-0-b32447c66b23@meta.com>
In-Reply-To: <20261012-vsock-guest-ns-v3-0-b32447c66b23@meta.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5MCBTYWx0ZWRfX75PLWjwkGirj
 YRTVBVAQfUZgYOmgLq5NyYSpKBfL4k55cgfalXBjCT5xc1Wg620M/wrX0tLgeKuACHE4zqpK2Qj
 NWhPf8Qf/MKCe8G89GhI4WbyxeEjZMc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5MCBTYWx0ZWRfXzCTuE2oFU9Yc
 aIytWY8fH+XZ1GzTdsdIjOxXDw4DCZ+RA6RvBfRoRht1TTs+Yz2Y3GyYoFVgVlrYtv59wHJoces
 icHSTG2tG7FU7etvyDG6cwXJxnYscQYR1NE6e9Cb1vZW+aqXNobm74oHi+DjSNxnawqJ8uHRefa
 s9Y7wNg7tShoFY4NGHN3ZWOwg92sT4pva602aVBALLo7qEc9zVT3s1J+KsYOLZx1krrZ7IIdQ2b
 Y5Tfle1n6LyF4ksGLrDXjyD+bm8Coknp+9B3B5x0BbcEkwIupgk9YO3RxbGrtUFEbKtf0UIkdFe
 J76052rsJITM9A1mLoNQk9g3LRG+BpnLFGhkPGgh+8/gwsS7znTtPQ0aVyNyo/1Q2rCRPJYeEnO
 qZqt4qLSdOrXG9/R4VYQS7Sk59XPnBM9HsYO83kEUIKHNwqci+mSOdoRl1RjC33HVMsZR57/TbJ
 tnQ+ARhJl6fV5Bim6dA==
X-Proofpoint-ORIG-GUID: SpCDCBekkNcIA3frARyWbttPHlQVyAmz
X-Authority-Analysis: v=2.4 cv=Z/V5j3RA c=1 sm=1 tr=0 ts=6acd63f3 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VabnemYjAAAA:8
 a=ehl-fRECcIfF51WkWLIA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: SpCDCBekkNcIA3frARyWbttPHlQVyAmz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01

VSOCK_CMD_DEV_NETNS_SET refuses callers without CAP_NET_ADMIN in the
init user namespace.

Add two tests: one confirms that CAP_NET_ADMIN is required even by a
privileged user and the other confirms that CAP_NET_ADMIN in an
unprivileged user ns alone is insufficient.

CONFIG_USER_NS is needed to test the CAP_NET_ADMIN + unprivileged user
ns case.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v3:
- Require setpriv only for the ns_guest_ tests, not the whole script

Changes in v2:
- Assert only that the command fails, not EPERM: ynl's cli.py does not
  report the errno (Sashiko)
- Use ynl cli.py for the assign
---
 tools/testing/selftests/vsock/config    |  1 +
 tools/testing/selftests/vsock/vmtest.sh | 54 ++++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

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
index 7693d5e0a1d0..d5d7b0660c5d 100755
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
@@ -1909,6 +1919,48 @@ test_ns_guest_assign_g2h_netns_pins_ns_ok() {
 	return "${KSFT_PASS}"
 }
 
+test_ns_guest_assign_g2h_netns_no_cap_net_admin_fails() {
+	local cmd="unshare -n setpriv --bounding-set=-net_admin"
+	local rc
+
+	vm_ssh "init_ns" -- "${cmd}" python3 /root/ynl/cli.py --no-schema \
+		--spec /root/ynl/vsock.yaml --do dev-netns-set &>/dev/null
+	rc=$?
+
+	if [[ "${rc}" -eq 0 ]]; then
+		log_host "assign unexpectedly succeeded without CAP_NET_ADMIN"
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_guest_assign_g2h_netns_unpriv_user_ns_fails() {
+	local unpriv_uid=65534
+	local unpriv
+	local rc
+
+	unpriv="setpriv --reuid=${unpriv_uid} --regid=${unpriv_uid}"
+	unpriv="${unpriv} --clear-groups"
+
+	if ! vm_ssh "init_ns" -- "${unpriv} unshare -U true"; then
+		log_host "unprivileged user namespaces unavailable, skipping"
+		return "${KSFT_SKIP}"
+	fi
+
+	vm_ssh "init_ns" -- "${unpriv} unshare -Urn" \
+		python3 /root/ynl/cli.py --no-schema \
+		--spec /root/ynl/vsock.yaml --do dev-netns-set &>/dev/null
+	rc=$?
+
+	if [[ "${rc}" -eq 0 ]]; then
+		log_host "assign unexpectedly succeeded for unprivileged user"
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

