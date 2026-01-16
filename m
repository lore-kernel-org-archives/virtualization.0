Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833E0315D51
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 21:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598958; cv=none; b=DaYzde+oFME5o5kdTnX7PXc5ZOIkQ6Rdcn/JobY54oI5PgvoN1geXAhjiN3M/wL1P/yJXdy2/UwQIXMZKUejxLcdANiIu4w/PqW3OMNhw14dBIYRRLXNrxO4x3vu5Z9H44aERa2td9bZY7P6wPxdnU2tXexiuD8+ntqVQ34TPv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598958; c=relaxed/simple;
	bh=43YZlXDQmW65hszyjr5m3UtpfpB8+72+oSXEtxR8B+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tf5t7jdIDI90hJ/3kAq5t/xR+F8MAoOcpgjuo/ZPhOFygPZmPyA0g4bUYgIk3JAxCFCqIn7Wl7/j3CJt38lfNT/vuHntotnG1OPn7+oObOrtsxAfXlsHaK4ms7pkp7c4fiOaXnqFxQmuXFIJXATxmhpUexYhwYsJCt2k4LqVE5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGVz2W1P; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGVz2W1P"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7926d5dbdf7so20595907b3.2
        for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 13:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598952; x=1769203752; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3I8QcIsIeOrh9cIrz38ZjjL+G5z3ujRC9KA0ugGud8=;
        b=aGVz2W1Pa27TO0GfR85aXfV5Zf88GlOrTVSYDzrrhEMujXTvb1dcbINcwycRPhVs/g
         8Jd3Lbqzw6pu6PqbZEe/+mQRKw+w5XMTywRvMuWFKqkan/PCdc/PAPSf11q+F1Ede1vE
         lExylygwVGH2wE9JU/27LEXuHpzpxT7A/EreeK12KT2jH+ekIGFiOmxgoaxgGgT8chtG
         CsFWaPK37R+Nm56uwbDNQXMSj9vQvqxnqIP9BIdD7VDNvMTozQ5AS8oNfMNJ1gdThwkN
         PgtgRGyrLM5nBjanBJycRqWqdmSRWVoRo3pfZmfHzb5bsKLz+dwQqb0vPPH29VsifSGR
         e0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598952; x=1769203752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y3I8QcIsIeOrh9cIrz38ZjjL+G5z3ujRC9KA0ugGud8=;
        b=h8iPWLeXWdzGN/NB79Own/4fmHTCxqt3TjV/i9AT1je5DYjua/Cb/jkgAHfd8V3e9S
         J52yyWuNcdw3lNQGt31dgevCcLheP8BuIMbMoBGoy3DntmX7wuvs1yAAK936lRzbHRvg
         pNnQ1KAF73yLKjxoEo34V/4eY2U67IQudwGVoJlSja2W9D4OEMyzJ0booAYqGxGGAwlW
         NuKLDvaD3M9WwM6W8UGNwjdheD4HFhMDlbRqVwzwAuGD7lsIN63zfq641KUsS4l1t7mS
         4Ag7j9GZoeKz7LU/7fu2s9YTMdz31CJ2wjVzkW95Uf7VrA+i3k1oal0bDSSkVeV4QenV
         me/A==
X-Forwarded-Encrypted: i=1; AJvYcCUB+GBXAjKPJbXKMr+mH+I7rRpzfdrUbOyP5CaymGAijz7RdTGrTFiSwqDbm1IWPXzgNc72WwLo/WqaSMdrDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVx3LKl6xehKTSQAPYqT2tLQNyenKPxfiSqBWSnFm+FSydngZf
	BZX476fUNLoI15gjWM8frdbgVPhg0TtijerRnfkiY577KKOxQEAsa2FA
X-Gm-Gg: AY/fxX5FeSUUy9lBTX+s7LiTP1FYPoLBBN/P/o9wTDLRQblKsxmVcqC0TJLXwHZQ8lM
	+RrrMUhdhrmbeC3XbiyJ7+emniK1B1/sPMPVfJDG9S8+phFUdkFjWHNhK6hM8vO2oz1MfJSEutm
	hg/6fdme6Ap6UI5m5nscjEIraP09e6hXjfXYfbQmpg7EfoS4Sg39Tj9LVk9BRr8k3k/48Nw0u2W
	DhjlBmhcwOWIya+uo7zT1Fmfst8uLP+DbRpUlCgSn46s+UB2usDbuIM/Yu0ulAjeHkJLE7zq3Xw
	3P/xSrS5dlnxt3trVnpJj/uOMXHRzgNN+liodDNnE2uNMDt7uWZ6Kxq9m0A6DGyfVgyT/4NbdqR
	c9vg65TdzBtbXhqckuPqFpWjlvp0v8rUl/SDEiEVxOd0knKWil9xo3TrN81hinRkqkWVpjqW3jT
	VbI+GAsC4UaZjLy29sA7M=
X-Received: by 2002:a05:690c:883:b0:78d:6657:fd1a with SMTP id 00721157ae682-793c5393f96mr32809527b3.37.1768598951767;
        Fri, 16 Jan 2026 13:29:11 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:1::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66ed7a1sm13166067b3.14.2026.01.16.13.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:29:11 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 16 Jan 2026 13:28:50 -0800
Subject: [PATCH net-next v15 10/12] selftests/vsock: add namespace tests
 for CID collisions
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-vsock-vmtest-v15-10-bbfd1a668548@meta.com>
References: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
In-Reply-To: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add tests to verify CID collision rules across different vsock namespace
modes.

1. Two VMs with the same CID cannot start in different global namespaces
   (ns_global_same_cid_fails)
2. Two VMs with the same CID can start in different local namespaces
   (ns_local_same_cid_ok)
3. VMs with the same CID can coexist when one is in a global namespace
   and another is in a local namespace (ns_global_local_same_cid_ok and
   ns_local_global_same_cid_ok)

The tests ns_global_local_same_cid_ok and ns_local_global_same_cid_ok
make sure that ordering does not matter.

The tests use a shared helper function namespaces_can_boot_same_cid()
that attempts to start two VMs with identical CIDs in the specified
namespaces and verifies whether VM initialization failed or succeeded.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v11:
- check vm_start() rc in namespaces_can_boot_same_cid() (Stefano)
- fix ns_local_same_cid_ok() to use local0 and local1 instead of reusing
  local0 twice. This check should pass, ensuring local namespaces do not
  collide (Stefano)
---
 tools/testing/selftests/vsock/vmtest.sh | 78 +++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 38785a102236..1bf537410ea6 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -50,6 +50,10 @@ readonly TEST_NAMES=(
 	vm_loopback
 	ns_host_vsock_ns_mode_ok
 	ns_host_vsock_child_ns_mode_ok
+	ns_global_same_cid_fails
+	ns_local_same_cid_ok
+	ns_global_local_same_cid_ok
+	ns_local_global_same_cid_ok
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -66,6 +70,18 @@ readonly TEST_DESCS=(
 
 	# ns_host_vsock_child_ns_mode_ok
 	"Check /proc/sys/net/vsock/ns_mode is read-only and child_ns_mode is writable."
+
+	# ns_global_same_cid_fails
+	"Check QEMU fails to start two VMs with same CID in two different global namespaces."
+
+	# ns_local_same_cid_ok
+	"Check QEMU successfully starts two VMs with same CID in two different local namespaces."
+
+	# ns_global_local_same_cid_ok
+	"Check QEMU successfully starts one VM in a global ns and then another VM in a local ns with the same CID."
+
+	# ns_local_global_same_cid_ok
+	"Check QEMU successfully starts one VM in a local ns and then another VM in a global ns with the same CID."
 )
 
 readonly USE_SHARED_VM=(
@@ -577,6 +593,68 @@ test_ns_host_vsock_ns_mode_ok() {
 	return "${KSFT_PASS}"
 }
 
+namespaces_can_boot_same_cid() {
+	local ns0=$1
+	local ns1=$2
+	local pidfile1 pidfile2
+	local rc
+
+	pidfile1="$(create_pidfile)"
+
+	# The first VM should be able to start. If it can't then we have
+	# problems and need to return non-zero.
+	if ! vm_start "${pidfile1}" "${ns0}"; then
+		return 1
+	fi
+
+	pidfile2="$(create_pidfile)"
+	vm_start "${pidfile2}" "${ns1}"
+	rc=$?
+	terminate_pidfiles "${pidfile1}" "${pidfile2}"
+
+	return "${rc}"
+}
+
+test_ns_global_same_cid_fails() {
+	init_namespaces
+
+	if namespaces_can_boot_same_cid "global0" "global1"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_local_global_same_cid_ok() {
+	init_namespaces
+
+	if namespaces_can_boot_same_cid "local0" "global0"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_global_local_same_cid_ok() {
+	init_namespaces
+
+	if namespaces_can_boot_same_cid "global0" "local0"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_local_same_cid_ok() {
+	init_namespaces
+
+	if namespaces_can_boot_same_cid "local0" "local1"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
 test_ns_host_vsock_child_ns_mode_ok() {
 	local orig_mode
 	local rc

-- 
2.47.3

