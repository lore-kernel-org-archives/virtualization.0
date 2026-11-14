Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794626448;
	b=wi8XM84kLIOANbxHf8Du4d+jKrk4pCOjHDPIFN1oOGEOJOVTxwDoZc1WxrhA4tazr+GM
	 bKjSUxmASTDULukKNhBCwZOujK9mT52B1CpeBkjQFIbXOHvBfVJ+BukHMJ49O+4xY7PQh
	 fRu9ZqRzctBwXkJRg6d+aD01dSBySSAu8y2wqxi1OI7gEBocL398lAqh41AXqjJUpBatR
	 DYGXjF2Lo9oXleveisQ2BV9UI9+vwoFSscR/4vblqcN2ITPfe57b5XAo9HRcMH5FeiT9X
	 Ek4oC4TTdMpS6QArzjiRLA1r9QPHXGXigCIjSfHcs7ERfsz8yB3/7qZyWq3Q/ADb5Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794626448;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=aaejf7SFe5NjEefor3mOQyX0aBzCAp6hoi2jYUb8isM=;
	b=dvjfY1urPkV4PRlLTYauTIrVPzd1ySPOBS3NwRWl6RNzbeEVxyv5gUre/NDBevXvNbfC
	 WDAWoq9Ujf2M8xiF91CbBn7JYdyOJsgK1j5WoVLjJtmwyqVbCPBZahBd9+P++azVz70Ic
	 ebsP2TzK5oq3QOttALlHjqRse8i1v56lp0KGGtasLrkbjPSf7ZveDz5ts0qgciFzBIRy1
	 3PsigwSKgpE/4yV8rGFYOA/B8icJn4ik2hvhX8XWqZT7eNRKx1mdixBZBTyuYaUduI9oj
	 Zs/dtzLSYOiU/H4X1mangVusaKMeqcjtWw2+QwHdWuQ4YEpDj5/7Ob4ZlOS/JycwQHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=R7ulxfKW;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD948606A32E
	for <virtualization@lists.linux.dev>; Sat, 14 Nov 2026 03:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD948606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=R7ulxfKW
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE22Xeb3157915;
	Fri, 13 Nov 2026 19:20:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=aaejf7SFe5NjEefor3mOQyX0aBzCAp6hoi2jY
	Ub8isM=; b=R7ulxfKW+3DP9E/xh004CdzAi+d1HcifKYnozqmSeprKqHWlDaFXi
	6pLznawbm9lbDjEiyq17v/2o+H15Wke8/8SaYxOcFZv9vua5guWltAUhmUTyQqdL
	qZCrqMaGhbI6XV2jw1oCa9kitnleP/deTZVDEDMt3CqEaNNrKXUQuHMGplYyumWc
	o8Z7nNUDk0SDrKsmnPHWQbZ6ENZv76d721+9mMsr2rzji2ZRpQHEB+uXwu+CQKkI
	4+VWqDBKD4k8inMQeDxbA2EfTyDjyiLMwN6OmIeBKkup+iOwr5WjjvJevf7W3VAT
	ZfImkNWJTry6yRmENeygZDo7z+3PEr5Vw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hwjg5tf9k-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 Nov 2026 19:20:27 -0800 (PST)
Received: from localhost (2620:10d:c085:208::7cb7) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sat, 14 Nov
 2026 03:20:26 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Fri, 13 Nov 2026 19:14:19 -0800
Subject: [PATCH net-next v6 8/8] selftests/vsock: test the netns assign
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
Message-ID: <20261113-vsock-guest-ns-v6-8-3737ce4673c0@meta.com>
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
X-Proofpoint-ORIG-GUID: nfk9mf7E0eX-Qe8HZbpQBcc1DjlMZrQA
X-Proofpoint-GUID: nfk9mf7E0eX-Qe8HZbpQBcc1DjlMZrQA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAxMiBTYWx0ZWRfX2H8B5qur7lwz
 thoSC27oOpq4Ne4cPQJaQYoAGNBWqeOVD0efq4EirKJR4vmnvqe+XSeF/3DLTToskryArce8Of0
 A9w6l/UZInntOgtqDoIE+WkoJrpT3xE=
X-Authority-Analysis: v=2.4 cv=Mcb5KJ/f c=1 sm=1 tr=0 ts=6af7d37b cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22 a=VabnemYjAAAA:8
 a=xFiaXek5eyy1MN0Ju3QA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAxMiBTYWx0ZWRfX54Xbp4Kupy/K
 ZzCNRn1OZdXQho7B/ssqyoYAjRxpQncaLi1TtuCDAWSFjtZJmxh10wIkb3vfhSD+u7FUYv1BGV0
 Ng1+pIhSDyCUPPSoyEfBCBEFRMBKGb3IZMWB0bC52BYr/xWMpMls7rNyz4RgenKdpmTKjiTasXE
 j2fOJds2b/tVedFD0t9a3F6c8BCJv+iwT/NJdWD7pPvnIhJRou6e1K0jIGOw/CmhoJ9PNwiGt9p
 CaU9fWWM4W/hTK1ckqxA9/KzaZQLg0I5uBA+zWtpb8eXnmoL7Dr0ueqgQI/3cAAagMK1DCcdXLP
 Z7t09JZVPewAFJ+t0VOKuSzkODb0+cqcb1UKiWuJvt+hgXvBot2EW+uUB1X02QbZjvfi1fCOSM2
 /s2d2NO+aRXKLt/kKEPoB7FPUUMuaH0dKh4/mU6PrzBNUBaGvAv8mCpfREqN2us6sYvaWYDQRYV
 unJ9vUv350UzeOBaxIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_01,2026-11-11_03,2025-10-01_01

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
index a800b63dfbb1..9614532a5628 100755
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

