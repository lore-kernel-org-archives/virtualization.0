Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792545336;
	b=pZvtb2SjA4oZnbgwXXVNXoSJoR2aXRrAoxzNTvKS/4AmnbqfpYHPIPYWyMeOO4Yl6Mvk
	 St3UxiCEaoqWsvybJIe1oIi+X56gVddFHN1tdGC+aPm5Eeej7ikLMzWsUsM7GN873b8Ot
	 1IDsOQCHj/2kuf/5GCR++0XRcsijbZxThllKwfg2KSrKGxyU1JWSPxfJ7BAJivquUqgWC
	 8X5R3nBWNFjoMijBbfseduExz0IN1ohCYayxVJl5c6V+9DfBH/eT0BH2ICk6mgZdB7F0Z
	 bK89USjnl6vcQg/A5mb4TnMgJnXUml/dFd6kc2VKtSAUqn5PsVwlpkJdpAYbxu1mnqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792545336;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=GxkdG/Dl3xWarXPL1wkKFiT3BqGEfgSBRQnLy3BPbNo=;
	b=XhDK5N0jSjGcSwLcyYkBtk+hyDHxRcON9xbbxSt/2Po0ZVthdKqu4nGXdq3y/S4nYKnz
	 X4xokgIMPiV11OgkgBgT+P1Fu+xFckivmgYObVsZPh8cDSZ8I+mPcacw5u9w1pfq9iNC5
	 H9BQGtD9Tr+X+WG0NFHglSm51236lx2gRKgU8JbpWGkVWIUZID8qgxso2yIlAvbTLeR9E
	 6xWwGfEZrJYdvCwtBVyc+sRsF7jl+7iyOzYXX4NcIo/ukpTz1y+y+ktwYe5zxJmkw88TZ
	 z6UKPEG1C5NYTJKkusuuQ9MOsLOhiavdYzH1lPexJd72jP24aDXWChzCoSfYjyfkB+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=JCIB10Ll;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A45D606A31A
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 01:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A45D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=JCIB10Ll
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KNF49B883649;
	Tue, 20 Oct 2026 18:15:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=GxkdG/Dl3xWarXPL1wkKFiT3BqGEfgSBRQnLy
	3BPbNo=; b=JCIB10LlIzl7Z8zjI7udo58I793DfNkYErG5ztCpJvr6sbCwL2Jlf
	vApx5HmTsJDFYhoUghdNyLLUAcgYwrcdOb8C3Cb3CM8OsZtGA/gddP+zOP4h7BGE
	GuCACfLU+a/duS1sb2AaobqPcfPNVufikSzOTQPcJUrEkL871FeBolMwgmkg6yJC
	78Tp4XhiXifhGUZRJJ+05iDjE3UVD6S23N7UC2Tgbi5nSf8hLZn+pPwdqaWLPS1m
	z22DWikAr+lDzAHwbztOvimfBa5r5A4GiGbGVgGj7dXxjT8ZDpBCfVbLmducaKPg
	Yxw5QODx73A5849JQ+yCv/vnpc7jwwy8A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hdw52r0ms-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 20 Oct 2026 18:15:24 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::8e35) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.49; Wed, 21 Oct
 2026 01:15:22 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Tue, 20 Oct 2026 18:15:10 -0700
Subject: [PATCH net-next v4 7/7] selftests/vsock: test the netns assign
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
Message-ID: <20261020-vsock-guest-ns-v4-7-047527cfccfc@meta.com>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
In-Reply-To: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwNCBTYWx0ZWRfX1oZPRn2uAZqx
 HPqPzcqfgl+TFjuyFeucrUaen2f+8zJ3UIo84DRBHx4KaCWTzjfM873i8nOLtsYX08G7r0pcg6p
 MdliHECvlEwnZX7Ay+VyLBnYl4GLm4igGgAW6tMo/PSE3XeU9xc/p3mfI8YwzBcdQ5/E8xe+k8d
 8JeWcBz4QT6NvwOEmIbv07NO8B+ePpR5crkNkqawbST7mDgLnUQ9+HBwlWMm/g3lsSkJfLLzwZD
 IVgmfekhtei/BDNA9IJSwUZh+xXLcxH5LZnGcpOqu+FF6BEr4lmPNQlqPZURMvxfAys1rOzZ0CX
 Wj/1A/RZGdKBntezXXEZYTfLSc7zRg9z6pNU+zWYf7d3TYpSg0Gj5Xx4aF+H6aNCbVHUqB9/hF1
 UbazfGEvWfkES5GEes7UjK4tmrZU1bKda2Fh3+45M9KxJPfC/Kk0iTE5Svx80d6HunJnTOq2e+s
 7aY4FD68LXBFu/QuW6g==
X-Proofpoint-ORIG-GUID: XRl1x1w-UlIrLgWMXVDDXcWITWMtLn-F
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwNCBTYWx0ZWRfX6fCqKSnjL081
 rqA7VlKTxsyXw1q/9MUM3ixj7y4SOhPy16bF5Xvt/JFvxGWfg/mOjrK/tlHXKchXhZE2x5a8Kh0
 Q6smjbP3x5vA+qnwlxMTan1x17ANLnI=
X-Proofpoint-GUID: XRl1x1w-UlIrLgWMXVDDXcWITWMtLn-F
X-Authority-Analysis: v=2.4 cv=BqEIUoX5 c=1 sm=1 tr=0 ts=6ad8122c cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22 a=VabnemYjAAAA:8
 a=ehl-fRECcIfF51WkWLIA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01

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

