Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DB737B417
	for <virtualization@lists.linux.dev>; Mon, 23 Feb 2026 22:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886336; cv=none; b=W10/3QdgUiGdTT5XHlkMfFrUodzLY936ZT/loa72Uq35JKsKNCx6q+clgq7Mwz4sZgxh2Buhr9NHWBD3iMCZIjIh8jAvdWBLHGxoZRS96qCHSbTWvKJcr1Q37SPUoPRkOobmVBYQILxqs+j9yBk59ObNDQIBt9tW406cNN4v7FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886336; c=relaxed/simple;
	bh=H9xSN+o2u3DPOyU3qSAxjvQ1NV6WYvyCbOgeBvy/A0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a6JWg2RVotdPHb86s9PopuOUkLuHG9V/QTFKvcCk1bmBPCzUzoO9nk2QGRZHAyKZsDGybzeCZ4S95u5hGChoqUgMBu6+IwDTVTE4z7UlnZ+AJW7c8NARLonDMxRXjpulGtikyRZmyT6yEaX0eDTv8DaynHkO2MsDSihcLdAqNyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9xhj86I; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9xhj86I"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7964f1405a0so48798287b3.1
        for <virtualization@lists.linux.dev>; Mon, 23 Feb 2026 14:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771886334; x=1772491134; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M6YNbaSbY/a/RFjAEl4EW9IaCZutb07kY998isXwAsE=;
        b=C9xhj86IoKYnDEIBL79odSSNrSoN8n5jsuqXc72SeRiw3nYARIyxOdj3leAPjBFpWl
         5hEpFphHg3qg4Jfx//oadHIrNKFDf1N57UIZpEMNwcNg4a4Ov7zOEtn1/XOhMf7n+9Od
         IEoTjj282+hymHs38E4W1J0Av+/ZwuvSkt4GSNqUBQCkMfCHERiHV+dzGNxaQKOxe24D
         m/5VsIdbNNMJrhBA2Lka+ALqmU18/OMNXLT+keTvEdBK/BqZ0uv0QkXksrTo5HObUS6G
         ReoQQIEIIPgyHEWk9N5Cj9qgvaytkfBW9wbbWNaevCdx9PpgliAE2OPRoB5NqQ1QyECw
         7WcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771886334; x=1772491134;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M6YNbaSbY/a/RFjAEl4EW9IaCZutb07kY998isXwAsE=;
        b=qTZYt0Yl1XxbzaNX1QsBB9+VO5HF2AAQkwKoLjBiZRc/3apT8DWQ9RxyBFs3fHrLGl
         HQGPgJi+Js4haMLa2AqB6M3DdNC9pbfffWW6YtElbBAwo8RQb46erK/MB8xn5QMimsJH
         HfEpr6NdchZ5c68pGXyFlQZOwCzlxKSivl+bBW0BP4c4+YZW8pJjbsWj3gsdGUPpAenY
         8l7/Z6EPA5USKtJoto7D+0h3bX51PPzgSNK7rTuTlaL+57xqwAVxTJo6XEKH0l+6Ht3h
         dTcMH4lh+UEnAZglrLlMUW4YKZUZtiZ7h48flyH9Mkxx5kOKoUfUix5A3d2P0NJ5OREM
         zbrQ==
X-Gm-Message-State: AOJu0Yx35lLjIHg+jXqnTYLZ6vRRl+PdGuYkab128Iof5j+AFYAGsB09
	TpdxIWb/hOJW9sYsh9kZcphtuCVU+QmrbMdTU6JUWFLw8feyqmVKPZuf
X-Gm-Gg: ATEYQzwzJaVNGeyiiAwGgibDMurCf6EknIOFxWJ5RnexUAVuZY7dSQYHy/cl/TYv3HH
	aBJTkx91Be1azC8Usruav+poRWtmGUA0fTb4pYGAaQrKjErfGfvCEUoXcBAmNq7Q3B66vFpY+dA
	l32CT6838NXv9O9dvJCu+lJVSjBo66fqlG8EaJ0P+QYazjleEqCnlng68Rf0lfr4VnULc6SIjqn
	sPdLXufwaQ/TKx2C6WU3b95iZPlRj/5ifvrrIPxEHO+RtgUDJxFvfZqrMQ3XlWwr4xeyJi5yQQ9
	nm8cMxypf/rtIc7wYd2HXuVf6v7mIHScZq18W2RuLMjO4VJhTj3Y8ut0Eg2/1areTqBWNgQ2waz
	3kUKbgupBCIdjsTbN2hOGFHP/wCWvyoNbwMzrjkQtwuTSz+Hcp8FtkAherY6HRrmIFHkW9zHB2O
	0GFwIr8KQLWWZRoJuQDkOG
X-Received: by 2002:a05:690c:6d91:b0:794:baaa:cca7 with SMTP id 00721157ae682-79828f1e7b7mr96957847b3.20.1771886333827;
        Mon, 23 Feb 2026 14:38:53 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982ddccc24sm37639337b3.40.2026.02.23.14.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:38:53 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 23 Feb 2026 14:38:32 -0800
Subject: [PATCH net v3 1/3] selftests/vsock: change tests to respect
 write-once child ns mode
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-vsock-ns-write-once-v3-1-c0cde6959923@meta.com>
References: <20260223-vsock-ns-write-once-v3-0-c0cde6959923@meta.com>
In-Reply-To: <20260223-vsock-ns-write-once-v3-0-c0cde6959923@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 kuniyu@google.com, ncardwell@google.com
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

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 41 +++++++++++++++++----------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index dc8dbe74a6d0..86e338886b33 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -210,16 +210,21 @@ check_result() {
 }
 
 add_namespaces() {
-	local orig_mode
-	orig_mode=$(cat /proc/sys/net/vsock/child_ns_mode)
-
-	for mode in "${NS_MODES[@]}"; do
-		echo "${mode}" > /proc/sys/net/vsock/child_ns_mode
-		ip netns add "${mode}0" 2>/dev/null
-		ip netns add "${mode}1" 2>/dev/null
-	done
-
-	echo "${orig_mode}" > /proc/sys/net/vsock/child_ns_mode
+	ip netns add "global-parent" 2>/dev/null
+	echo "global" | ip netns exec "global-parent" \
+		tee /proc/sys/net/vsock/child_ns_mode &>/dev/null
+	ip netns add "local-parent" 2>/dev/null
+	echo "local" | ip netns exec "local-parent" \
+		tee /proc/sys/net/vsock/child_ns_mode &>/dev/null
+
+	nsenter --net=/var/run/netns/global-parent \
+		ip netns add "global0" 2>/dev/null
+	nsenter --net=/var/run/netns/global-parent \
+		ip netns add "global1" 2>/dev/null
+	nsenter --net=/var/run/netns/local-parent \
+		ip netns add "local0" 2>/dev/null
+	nsenter --net=/var/run/netns/local-parent \
+		ip netns add "local1" 2>/dev/null
 }
 
 init_namespaces() {
@@ -237,6 +242,8 @@ del_namespaces() {
 		log_host "removed ns ${mode}0"
 		log_host "removed ns ${mode}1"
 	done
+	ip netns del "global-parent" &>/dev/null
+	ip netns del "local-parent" &>/dev/null
 }
 
 vm_ssh() {
@@ -287,7 +294,7 @@ check_args() {
 }
 
 check_deps() {
-	for dep in vng ${QEMU} busybox pkill ssh ss socat; do
+	for dep in vng ${QEMU} busybox pkill ssh ss socat nsenter; do
 		if [[ ! -x $(command -v "${dep}") ]]; then
 			echo -e "skip:    dependency ${dep} not found!\n"
 			exit "${KSFT_SKIP}"
@@ -1231,12 +1238,8 @@ test_ns_local_same_cid_ok() {
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
 
@@ -1246,15 +1249,13 @@ test_ns_host_vsock_child_ns_mode_ok() {
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

