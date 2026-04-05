Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895D6C8EB
	for <virtualization@lists.linux.dev>; Sun,  5 Apr 2026 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775419070; cv=none; b=mYjAX0t0o57iLmgau+fvO/fK0q5HGQ231IPoi+LulQRIBhoBrvE/n+WUutcVsgyRg7IG3zmedX9jYw/BosY/nHfoGgBDH/HtsrxIeCOeEh+XZMvBYexFLv3PdG5yOdkH7k/zVcs5QTSMTUEhSw4/f93DdVJw2sDZ4Cl7QKvI6GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775419070; c=relaxed/simple;
	bh=mr+n5Lb6V+b1/GO9pFMZU3SpjhBT4hIZrAwsX9QQqb0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sjcCS7DhLwsVpF926Y7pRTEqymH/dbhKa1ESS/37sQidM0/Ms9JU0F0kp4L2sjV59D7JhyhseqAbEtAzgoCn1A29LMDgX8Bx/3RPXnA9wA2ZBjcY89Z+A5NoJN4FV3reZPhisdCHdpLKw8SMY4fzdEQVDnna80DhHCOvXvQ6bFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eOv0TMRY; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eOv0TMRY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ym
	zywPE5Lp18k1Lf7VdFqM/Ieh7Q8sd8fqBVNAE02fo=; b=eOv0TMRYeb383y5tC2
	S4y1Em7SaEDfXXfsHD0Rq5GkEZZ8rd1E4OF2RhjuqJERmqsckD2weI6q97P47Et1
	SxkZfjg31Eq1eH0/EL+s+AzMQ1toBm4RnoinCwKWX1ObDjrhTHmL+EmdHvCSKKoX
	I53k1QiAWObDVy9Mrz9splzIU=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXX8CbvtJpRAqFCA--.641S2;
	Mon, 06 Apr 2026 03:57:21 +0800 (CST)
From: CaoRuichuang <create0818@163.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	CaoRuichuang <create0818@163.com>
Subject: [PATCH 1/1] selftests: vsock: avoid mktemp -u for Unix socket paths
Date: Mon,  6 Apr 2026 03:57:09 +0800
Message-Id: <20260405195709.85957-1-create0818@163.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDXX8CbvtJpRAqFCA--.641S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw1furWUtFyDXr4UGr47CFg_yoW5WrW5pF
	ySqrWDtry0kF1avF1fCw4jkryFgan5AF47X39xZr1jyrsrGrn7Zr4xtFn8ZFnxWF4fXFWr
	uayvgFs5ZF4UK37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRVRRtUUUUU=
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbC6AHmIGnSvqE2RwAA36

The namespace tests create temporary Unix socket paths with mktemp -u and
then hand them to socat. That only prints an unused pathname and leaves
a race before the socket is created.

Create a private temporary directory with mktemp -d and place the Unix
socket inside it instead. This keeps the path unique without relying on
mktemp -u for filesystem socket names.

Signed-off-by: CaoRuichuang <create0818@163.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 86e338886..91e0037d2 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -718,6 +718,7 @@ test_ns_diff_global_host_connect_to_global_vm_ok() {
 	local pids pid pidfile
 	local ns0 ns1 port
 	declare -a pids
+	local unixdir
 	local unixfile
 	ns0="global0"
 	ns1="global1"
@@ -736,7 +737,8 @@ test_ns_diff_global_host_connect_to_global_vm_ok() {
 	oops_before=$(vm_dmesg_oops_count "${ns0}")
 	warn_before=$(vm_dmesg_warn_count "${ns0}")
 
-	unixfile=$(mktemp -u /tmp/XXXX.sock)
+	unixdir=$(mktemp -d /tmp/vsock_vmtest_XXXXXX)
+	unixfile="${unixdir}/sock"
 	ip netns exec "${ns1}" \
 		socat TCP-LISTEN:"${TEST_HOST_PORT}",fork \
 			UNIX-CONNECT:"${unixfile}" &
@@ -758,6 +760,7 @@ test_ns_diff_global_host_connect_to_global_vm_ok() {
 
 	terminate_pids "${pids[@]}"
 	terminate_pidfiles "${pidfile}"
+	rm -rf "${unixdir}"
 
 	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
 		return "${KSFT_FAIL}"
@@ -814,6 +817,7 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
 	local ns0="global0"
 	local ns1="global1"
 	local port=12345
+	local unixdir
 	local unixfile
 	local dmesg_rc
 	local pidfile
@@ -826,7 +830,8 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
 
 	log_host "Setup socat bridge from ns ${ns0} to ns ${ns1} over port ${port}"
 
-	unixfile=$(mktemp -u /tmp/XXXX.sock)
+	unixdir=$(mktemp -d /tmp/vsock_vmtest_XXXXXX)
+	unixfile="${unixdir}/sock"
 
 	ip netns exec "${ns0}" \
 		socat TCP-LISTEN:"${port}" UNIX-CONNECT:"${unixfile}" &
@@ -845,7 +850,7 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
 	if ! vm_start "${pidfile}" "${ns0}"; then
 		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
 		terminate_pids "${pids[@]}"
-		rm -f "${unixfile}"
+		rm -rf "${unixdir}"
 		return "${KSFT_FAIL}"
 	fi
 
@@ -862,7 +867,7 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
 
 	terminate_pidfiles "${pidfile}"
 	terminate_pids "${pids[@]}"
-	rm -f "${unixfile}"
+	rm -rf "${unixdir}"
 
 	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
 		return "${KSFT_FAIL}"
-- 
2.39.5 (Apple Git-154)

