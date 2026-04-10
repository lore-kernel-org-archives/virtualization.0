Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E3313B7A3
	for <virtualization@lists.linux.dev>; Fri, 10 Apr 2026 03:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775793188; cv=none; b=O0hiso9tskynGNDYou6So3LGHDEd8xRKJz+b7acCxPS+XYuOUJs+7ADgMehgQfIZRntzRUa2Fqoyd2z8iz1tlJVkLE7HOdGgTbXvdEIpT7BzxnR0ih/m4yq5VcxY7U+X+RsRjAZ58obTkUESppsJFv9FZSKGukre88Uh8iL5qs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775793188; c=relaxed/simple;
	bh=B3Hr7MThBpO8RqdOYClkmVKDi21UlYk4buIXNfjCDEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L+j7xl/IjK/MjcyoIoQuj7ldIr+AA0icYGB2t+SM2NFL4+js3zijMglL3gdNezvbApGZ9/M4zyzD7THGb6rBfI5bUUDOUeBPsRElYS0mbkCbC8RmiRTcMTWWnRQaVgWKENsCK+StKV7E39UtVXo/j5CSLfUvUFm+qRlASweB24Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FqGbFMAg; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FqGbFMAg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Bq
	ZHRt7/maD5XNq017TDZ2Tr69V/Pp021rgrxlLU/8w=; b=FqGbFMAg8Pk+kuU2O/
	Is4bo1plK18rymqRzDoIW77PDSchzClUHKy9lshxQk7SUz6Np4cIT0xHGV/Yrhsm
	dcsN22YB/wW7LPSAB962rTT9T5Q4FIAXxfHDSaZ8QJyV6D/k7GO2uGKOVOSKKqEq
	eoAyxYKeEpYbGcN3cBBt3udHM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAnPvUMdNhpyMguEQ--.28809S2;
	Fri, 10 Apr 2026 11:52:46 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
To: stefano.garzarella@gmail.com
Cc: sgarzare@redhat.com,
	shuah@kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	Cao Ruichuang <create0818@163.com>
Subject: [PATCH v2] selftests: vsock: avoid races creating Unix socket paths
Date: Fri, 10 Apr 2026 11:52:37 +0800
Message-Id: <20260410035237.59644-1-create0818@163.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260405195733.86043-1-create0818@163.com>
References: <20260405195733.86043-1-create0818@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnPvUMdNhpyMguEQ--.28809S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw1UXr1DWFy7Xry3tw4UXFb_yoW5GFWrpF
	yFqrWktr1S9F1avF17Cw1UGFyFgFs8JF47X39xZr1jvF47Krn7Zrs7tFn8X3Z3WFs3XFWr
	Ca9YgFs5ZF18K37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pREeHhUUUUU=
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbC5w6w6WnYdA4ZigAA3o

Signed-off-by: Cao Ruichuang <create0818@163.com>
---
v2:
- retitle the patch to describe the race being fixed
- replace rm -rf with explicit rm and rmdir cleanup

 tools/testing/selftests/vsock/vmtest.sh | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 86e338886b3..c345fa539d3 100755
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
@@ -758,6 +760,8 @@ test_ns_diff_global_host_connect_to_global_vm_ok() {
 
 	terminate_pids "${pids[@]}"
 	terminate_pidfiles "${pidfile}"
+	rm "${unixfile}"
+	rmdir "${unixdir}"
 
 	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
 		return "${KSFT_FAIL}"
@@ -814,6 +818,7 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
 	local ns0="global0"
 	local ns1="global1"
 	local port=12345
+	local unixdir
 	local unixfile
 	local dmesg_rc
 	local pidfile
@@ -826,7 +831,8 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
 
 	log_host "Setup socat bridge from ns ${ns0} to ns ${ns1} over port ${port}"
 
-	unixfile=$(mktemp -u /tmp/XXXX.sock)
+	unixdir=$(mktemp -d /tmp/vsock_vmtest_XXXXXX)
+	unixfile="${unixdir}/sock"
 
 	ip netns exec "${ns0}" \
 		socat TCP-LISTEN:"${port}" UNIX-CONNECT:"${unixfile}" &
@@ -845,7 +851,8 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
 	if ! vm_start "${pidfile}" "${ns0}"; then
 		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
 		terminate_pids "${pids[@]}"
-		rm -f "${unixfile}"
+		rm "${unixfile}"
+		rmdir "${unixdir}"
 		return "${KSFT_FAIL}"
 	fi
 
@@ -862,7 +869,8 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
 
 	terminate_pidfiles "${pidfile}"
 	terminate_pids "${pids[@]}"
-	rm -f "${unixfile}"
+	rm "${unixfile}"
+	rmdir "${unixdir}"
 
 	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
 		return "${KSFT_FAIL}"
-- 
2.39.5 (Apple Git-154)

