Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794966931;
	b=uLYJmuoARUJcIZ8dkK/blCkODVI3CX116gaQTM5GodCDPC/yzzPITc1gQWurqER8O1Po
	 rhR0Ht5oqAp6+IN+8DiApZZeBsSneAMhbwfCikkS1+beRQv2GRA17/wVngfCm/IGqzeOy
	 PyryOf7Eeonjuk1rRY40kMvMwilOE5hG18wBpDQ3ydNiqnaFiEufUvMjin22XjnWx0gPu
	 EYkSu6i88FJthKNoNPU1phajqSIG0TQ646siO/7hBxfxFDTS87T3P4/VI0b0PiXzzNiSF
	 kbNh44HP4PqX/2wfUtx16YQe/nuBfP8pgARsj9zUewL66G4sOCzR+lzshAf7VySh1iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794966931;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version;
	bh=zFY1GmSViuXI0rPHC6t3ZteUEq5nixMZVkXt8LdMcNY=;
	b=UsmllOHfGkOwQQwUPfqS65KK2ENMn0z+YSXxbcsSp+OVplqZhQTUW/8ef2pTtma2gDyq
	 OckMQwVmJkCufmg3v0KTniyMRm4ecLHySg9DVycd+BKBMCsune5m37/Qh7RwaWYzK0lYe
	 X+jOHj3xVXxU0io6aCQbTJ/mAni+pE2wz8tpXpE4hmLbnb8CJI6pokejnlxfw8YcS7Jda
	 wFrz5zzERTaMPTfo4xOUPRLp4i5OeT/zMLKRHLVZnpD2MekgAyc2Y94/7yQvK/mhOpgMd
	 5PKXT/pvKkTVnrtTf5JJvs2VAexMST3mz2u6NL3z8nDvN4muTPCFgnmUFc0ejK6gpbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=CVs8weoz;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966A160A3808
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 01:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 966A160A3808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=CVs8weoz
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI11rAC258466;
	Tue, 17 Nov 2026 17:55:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=zFY1GmSViuXI0rPHC6t3ZteUEq5nixMZVkXt8
	LdMcNY=; b=CVs8weoz86JWvaUASY6ZBMehCnJNzYNJZ9kHX0YqQaF3Vpvmjitq/
	Jd4XJFY+GNBvFlM/g9KN3kKcBoPkaPipZ5VYmafQbbOkAkBzlE0s0DiSofoXXtVr
	jjpgA3VkEyKgdPHhvCRBNEdVUftx+CuUb90eoevtgHVwbJVI8D+B+McuTPJvkdPG
	umHmRZVCCwOM3b5wWRRxGRKzPZtXfKHZXl4rYBQhE4kWsrGcSLOP0slUR59C7t4Y
	oleIToc32+S83W0Tha1TSAbshE8FdnPvuBOhtJXXf5Xkks063sVGAxnGK1LpA+HS
	eLxJfTrHthKVmeXlo6IjhUfeAuPzLppfw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j0yu79b7g-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 17 Nov 2026 17:55:18 -0800 (PST)
Received: from localhost (2620:10d:c085:208::7cb7) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Wed, 18 Nov
 2026 01:55:08 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Tue, 17 Nov 2026 17:54:50 -0800
Subject: [PATCH net-next v7 7/7] selftests/vsock: test the netns assign
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
Message-ID: <20261117-vsock-guest-ns-v7-7-7e522ea9dd9b@meta.com>
References: <20261117-vsock-guest-ns-v7-0-7e522ea9dd9b@meta.com>
In-Reply-To: <20261117-vsock-guest-ns-v7-0-7e522ea9dd9b@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAwNyBTYWx0ZWRfX4X5jm5ND0ngv
 Qv2eyerH9J0U+/1HX9mKtdCZFoL2UNP04l4PkltbVNGLQVy5C7q+iT7dS4UUhddkyiO6MingYAh
 eV6KwJUpeZU5mHW/nLDZO928Jbso3VOwqOUCIgUXcllEtF7V0uYqat0X0NwG8y+eChoKtu/EbWz
 w3tUCC2xY3ArKuezy9aE7LLUX/M+XCJch5oj1QKXlgvu7OVizzviPcndMOdqIUpZAXMABplotI7
 mwnLVSBbewu4htQ9QDHK0Pv8FuC6Y6/IFXkIIc9f+R7KvpL3c+1V8o7C3OpAC75cY4EMcY5m38r
 WMOaI0GMJKZxZ3J8a71evs68raQHg0lPKYnlQXUEnTDBL4uicASGa2fTUtJWwCG/JrBbabo+fWy
 tTHyPfQ7vl4lDVtDt2BLQxfaPfUDX/cvWv2htCGDrJD1Sh2wknxwNk5uWgKG/6ru0G4K/ZBJ7AW
 JCRi7XyUy0LQF56yM5w==
X-Proofpoint-GUID: 6Y-FZ5uo1aR49g4HGwJZtF0lfGDg53aB
X-Authority-Analysis: v=2.4 cv=Zph4uN7G c=1 sm=1 tr=0 ts=6afd0586 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VabnemYjAAAA:8
 a=xFiaXek5eyy1MN0Ju3QA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: 6Y-FZ5uo1aR49g4HGwJZtF0lfGDg53aB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAwNyBTYWx0ZWRfX7w4PEP8IuPmu
 pM5lMK35WzOXcFWfw3VES7X/TsLGGcQQDb63Thv1ucWaEqaMFyo24hyGIJYt2Ub2ek6HfBRb815
 ouWbUJo3YmNyILg32L6wNV7IaxlJ1Bg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01

VSOCK_CMD_DEV_NETNS_SET refuses callers without CAP_NET_ADMIN in the
init user namespace.

Add two tests: one confirms that CAP_NET_ADMIN is required even by a
privileged user and the other confirms that CAP_NET_ADMIN in an
unprivileged user ns alone is insufficient.

CONFIG_USER_NS is needed to test the CAP_NET_ADMIN + unprivileged user
ns case.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v6:
- Require setpriv only for the two privilege tests, not every ns_guest_
  test (Sashiko)

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
 tools/testing/selftests/vsock/vmtest.sh | 59 ++++++++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 1 deletion(-)

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
index c771d0cb9268..248a4c6900f1 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -94,6 +94,8 @@ readonly TEST_NAMES=(
 	ns_guest_assign_g2h_netns_host_connect_ok
 	ns_guest_assign_g2h_netns_pins_ns_ok
 	ns_guest_assign_g2h_netns_old_conn_send_fails
+	ns_guest_assign_g2h_netns_no_cap_net_admin_fails
+	ns_guest_assign_g2h_netns_unpriv_user_ns_fails
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -191,6 +193,12 @@ readonly TEST_DESCS=(
 
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
@@ -204,6 +212,8 @@ readonly USE_SHARED_VM=(
 	ns_guest_assign_g2h_netns_host_connect_ok
 	ns_guest_assign_g2h_netns_pins_ns_ok
 	ns_guest_assign_g2h_netns_old_conn_send_fails
+	ns_guest_assign_g2h_netns_no_cap_net_admin_fails
+	ns_guest_assign_g2h_netns_unpriv_user_ns_fails
 )
 readonly NS_MODES=("local" "global")
 
@@ -367,13 +377,22 @@ check_deps() {
 
 check_ns_guest_deps() {
 	local tname=$1
+	local deps="unshare python3"
 	local dep
 
 	if [[ ! "${tname}" =~ ^ns_guest_ ]]; then
 		return 0
 	fi
 
-	for dep in unshare python3; do
+	# test-specific guest dep checks
+	case "${tname}" in
+	ns_guest_assign_g2h_netns_no_cap_net_admin_fails | \
+	ns_guest_assign_g2h_netns_unpriv_user_ns_fails)
+		deps="${deps} setpriv"
+		;;
+	esac
+
+	for dep in ${deps}; do
 		if [[ ! -x $(command -v "${dep}") ]]; then
 			log_host "no ${dep} for test ${tname}"
 			return 1
@@ -1951,6 +1970,44 @@ test_ns_guest_assign_g2h_netns_pins_ns_ok() {
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
2.53.1-Meta

