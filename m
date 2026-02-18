Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23309346A02
	for <virtualization@lists.linux.dev>; Wed, 18 Feb 2026 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771438275; cv=none; b=L6X1POpjj1W23LheO6S0aRmxiZNa717pEGqKkRU++wZGJ08LtgPCeMXI5jVpnHBryiT4IVDTjdNhLz+VX3dnJQAT3FW44uWLEXnBcsce9Q5FFOgc6wmGKlrbX0G6UTHNXSwsZfQTVGJl+YDiDV+bSXmwzFyGxCBkgsdpas9VpU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771438275; c=relaxed/simple;
	bh=Cq8ZzrMm3CGi0RM5HOgynfAVi/zZ/p+NhaJGJ/csZCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DB5u1cx3RX5qAvJJigN+OBNFqD9zIFO01tbGtH/NVJPepKvaEaPHVdsJGLiBLIDtvjoacR2a2XJ8xiSdZp9eehmiAjzwGRHvBPNJGJ2yuv5umC8aNllG/ljeuh9nqx9a+2ySPsUR61qA46ds5wGUbE8vMxgFG6C4z6P881khtoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHl2Wqrj; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHl2Wqrj"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64ae2ce2fe1so31380d50.1
        for <virtualization@lists.linux.dev>; Wed, 18 Feb 2026 10:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771438272; x=1772043072; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PAWE751YSOrD9FsbhK2tX9K0BdH9Fj+XqGCptsOgLbc=;
        b=EHl2WqrjGd1BWr1EgY7NkVAwSf42iA42ycEQAIany8XglmqGAF7x9YbilJY8fu5edr
         vesCSR8tKw3ZAw5N/JD2JPI/59ZODqeYbxsrMXm0BN4Lb+IoEmZqxA63R1ouQYq4X3qt
         ZGRvGY3Ps27tc7FLirrdT3+4cM2dYa3ndtdqRRBdnCa5duCutRfKygt/Shv1XLdbAn9B
         2goIxxtfAkMF5UPmQ2+joo4K8blCPdRsndmd7uwN8qmJE/wJsaqenz/RvRNZpi/LSNWZ
         TKGBh1xk5I5xrMDdhfzfKTulvHPFbqSDfuVTYaCc6iWzlR5MzDL7NKV5AzAQV/qlwnsh
         zMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771438272; x=1772043072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PAWE751YSOrD9FsbhK2tX9K0BdH9Fj+XqGCptsOgLbc=;
        b=B8PikrOfY81WCd1y0ND+XjgdyyiGjSoSmZaTmyXA/RhiTdk0Q8v4qgiRKVDTY1lITJ
         fa2SiVSIv87cEV2EdZgPVL/p8+OCq9b9GWrt939B5Abba4QBmPSZNzIeAkt0FQLuovB7
         ySCjoNGRHDrSOVom4gmO7CnX4kYNgN5OCLbucRcTNoF3Q5SuCQXAHXZsch/FrAWH+NV3
         i5imGRuYkWcy3KdNMuFmgExmRq43IqP7CBSZrn2nJZQmmWWqW7O75IrC3BmBPlDkaKjU
         Fci4siYT0BLkCMBgMou8/O/Itiz0YCkTMJjXRn9psGNCaFGaNTgL2Cddx5cnWaV60sNA
         Xokg==
X-Gm-Message-State: AOJu0YybheBscZkHykhQYyNa87Tp8PjyFoaTnKMiPXMimjcb25lk824m
	iR+iOOtM3Ti72x03LngloWFKzVIxVSbHcTQzKTfY5c9SMy7luVX02q+i
X-Gm-Gg: AZuq6aJjEesfIhoqQWjxhNMakCONlr+bKvKvKKPOLJbBKWfsa1kqap4gSFrOVsLxqaG
	8/o0yduem4DvATHoJarQ+/m/szhUx0rtbBRFO6z8aGB46DsqE7kKxvdJh9nm6oKhDu9bUclDjOu
	fg71/72vnSEZOP8YU4ArLi+MQPaFLFjANivzawBWK4Yh9iIX9L6q1Mfzw+Ma7+wxpSAR1xkfvzP
	MZkMV+5INeH19fJJUG3n2raM/vFqlcx34XzI9HQt78MTOAGMmAzuVo5fxUyGo6qpyGzO9LUYsQJ
	/EbDZpULot5drv5ZZBnX3VRLzHpR/nmFDUwC9yhTulJDgkBNxhvxfBUvQZRvlPzxB+SSpFtwISX
	ZY5QDtlDrLTGSHSLlUyLoQSeaLX/sR4LdbHz2LxH2eAXE4Ha/gf1qWK2NbU2pLy5JfoM7HlfBbQ
	9q+o3iolMEvNJdFDx/CZYFhw==
X-Received: by 2002:a05:690e:1384:b0:64a:e063:d3ad with SMTP id 956f58d0204a3-64c556dfed0mr2342999d50.94.1771438271947;
        Wed, 18 Feb 2026 10:11:11 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:45::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22fc4bb9sm6143499d50.20.2026.02.18.10.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 10:11:11 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 18 Feb 2026 10:10:36 -0800
Subject: [PATCH net v2 1/3] selftests/vsock: change tests to respect
 write-once child ns mode
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-vsock-ns-write-once-v2-1-19e4c50d509a@meta.com>
References: <20260218-vsock-ns-write-once-v2-0-19e4c50d509a@meta.com>
In-Reply-To: <20260218-vsock-ns-write-once-v2-0-19e4c50d509a@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

The child_ns_mode sysctl parameter becomes write-once in a future patch
in this series, which breaks existing tests. This patch updates the
tests to respect this new policy. No additional tests are added.

Add "global-parent" and "local-parent" namespaces as intermediaries to
spawn namespaces in the given modes. This avoids the need to change
"child_ns_mode" in the init_ns. nsenter must be used because ip netns
unshares the mount namespace so nested "ip netns add" breaks exec calls
from the init ns. Adds nsenter to the deps check.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 35 +++++++++++++++------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index dc8dbe74a6d0..e1e78b295e41 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -210,16 +210,17 @@ check_result() {
 }
 
 add_namespaces() {
-	local orig_mode
-	orig_mode=$(cat /proc/sys/net/vsock/child_ns_mode)
+	ip netns add "global-parent" 2>/dev/null
+	echo "global" | ip netns exec "global-parent" \
+		tee /proc/sys/net/vsock/child_ns_mode &>/dev/null
+	ip netns add "local-parent" 2>/dev/null
+	echo "local" | ip netns exec "local-parent" \
+		tee /proc/sys/net/vsock/child_ns_mode &>/dev/null
 
-	for mode in "${NS_MODES[@]}"; do
-		echo "${mode}" > /proc/sys/net/vsock/child_ns_mode
-		ip netns add "${mode}0" 2>/dev/null
-		ip netns add "${mode}1" 2>/dev/null
-	done
-
-	echo "${orig_mode}" > /proc/sys/net/vsock/child_ns_mode
+	nsenter --net=/var/run/netns/global-parent ip netns add "global0" 2>/dev/null
+	nsenter --net=/var/run/netns/global-parent ip netns add "global1" 2>/dev/null
+	nsenter --net=/var/run/netns/local-parent ip netns add "local0" 2>/dev/null
+	nsenter --net=/var/run/netns/local-parent ip netns add "local1" 2>/dev/null
 }
 
 init_namespaces() {
@@ -237,6 +238,8 @@ del_namespaces() {
 		log_host "removed ns ${mode}0"
 		log_host "removed ns ${mode}1"
 	done
+	ip netns del "global-parent" &>/dev/null
+	ip netns del "local-parent" &>/dev/null
 }
 
 vm_ssh() {
@@ -287,7 +290,7 @@ check_args() {
 }
 
 check_deps() {
-	for dep in vng ${QEMU} busybox pkill ssh ss socat; do
+	for dep in vng ${QEMU} busybox pkill ssh ss socat nsenter; do
 		if [[ ! -x $(command -v "${dep}") ]]; then
 			echo -e "skip:    dependency ${dep} not found!\n"
 			exit "${KSFT_SKIP}"
@@ -1231,12 +1234,8 @@ test_ns_local_same_cid_ok() {
 }
 
 test_ns_host_vsock_child_ns_mode_ok() {
-	local orig_mode
-	local rc
-
-	orig_mode=$(cat /proc/sys/net/vsock/child_ns_mode)
+	local rc="${KSFT_PASS}"
 
-	rc="${KSFT_PASS}"
 	for mode in "${NS_MODES[@]}"; do
 		local ns="${mode}0"
 
@@ -1246,15 +1245,13 @@ test_ns_host_vsock_child_ns_mode_ok() {
 			continue
 		fi
 
-		if ! echo "${mode}" > /proc/sys/net/vsock/child_ns_mode; then
-			log_host "child_ns_mode should be writable to ${mode}"
+		if ! echo "${mode}" | ip netns exec "${ns}" \
+			tee /proc/sys/net/vsock/child_ns_mode &>/dev/null; then
 			rc="${KSFT_FAIL}"
 			continue
 		fi
 	done
 
-	echo "${orig_mode}" > /proc/sys/net/vsock/child_ns_mode
-
 	return "${rc}"
 }
 

-- 
2.47.3

