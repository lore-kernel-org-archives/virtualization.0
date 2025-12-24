Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3381727FD56
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 00:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536153; cv=none; b=pzhMVBjsU4K7Ol3zWiuhiLzTTXOBU0O4HWSb2nGwL3qUxUiMMeO54mu85GHkqOQPqy6hTs9YeNibO8SY2SDAXM/pIaV3rHPPJd+1r8yM8kwK5yFEOo6AETD4cQ0IXT4wzqlI63EsmvntkxbvtA5cwLjCRoW7brEZAsLvk8dKFeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536153; c=relaxed/simple;
	bh=43YZlXDQmW65hszyjr5m3UtpfpB8+72+oSXEtxR8B+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pk9G0SLnm387n+SwiCNC1NUIqK1SlV2FND2cOXsOpNOBsUqK/aN8GsDvFR6zn5tRmB628ye6CGy2uAzwtVZuJExs4HgPqVU6nwkHvVYTKxYjgrDFBR8iBVg8y4M6UVr3QzyeYOxRjKrLqcFqSvM78GmaaJEgNM3p9PSG7YQlKGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX/r82D9; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX/r82D9"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34ccdcbe520so2972507a91.1
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 16:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766536148; x=1767140948; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3I8QcIsIeOrh9cIrz38ZjjL+G5z3ujRC9KA0ugGud8=;
        b=YX/r82D95MuGeDkjyU0ewu8snatz6a3l/LWuvyz4psGk4B1gKYeq5SANSeTrVq+/Kg
         wWYh6TQsi0agCYHRxx2QEUdRrnhVGistl4Hm43LcJrLoqm0mfMPQaD8heOP+XFIv2Yyo
         6cssYR3X4F+PO1RaWwPWoSkCQqwfjSH/yM4SmIYJR3cYe7snNZp4iFOsbHD+nUGxTo6J
         YqX04+ymK21XI2hRdPXlNYp1Op4c3VtWPu4hjWFsK+YfOEIGUpWZNAlbb65pwbDAywts
         FKad7QPbwUIgJkrAFkRokFuKSRrhTwhOR3L5gmeizxEHl5/pckG+FhhlWwzZYVlE0JGn
         L1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536148; x=1767140948;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y3I8QcIsIeOrh9cIrz38ZjjL+G5z3ujRC9KA0ugGud8=;
        b=JMrrsLmXO+ZtcbsZTSxOpZ6z0NGTpvv2ezujeEzaLJw52AMlIFAvYAhFgtIC8EbA0R
         cRYIc+1fCdKXmjRKn3qqPOk/pFpzrL8182MiS1jy0Emp1v2W1k35wQX70vUMgBbwhzN0
         P0P0irbuJKblpxyZIQRwpdRSSrxWCCuXTQbHcTuKso6rsG4ZpT+CMeG2di0HzYpZan+z
         1qFKLR3uV3gfTHTN0/9b9ayfOABqCU9F3/z7HIIJJvhoPGb07/YaRAK/kstacq6ORftk
         vUHpOrEknv4Q8lW96tqW01y9+qAdGfdLJir6avAcjGzC59b03XprEoy/6b9zK72Kutm6
         Ulpw==
X-Forwarded-Encrypted: i=1; AJvYcCVwVmU5BVQhmvp7Hqogp9K+aQU6UBNqn+ICiMkar2DyrimJ3DusiYNMJ4kP4t5BtzcXY6e65UPY1ib/qu8Xjw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvjXq4iJkyeSi8j3qAMnwGGqeDbuuhuFCOi5RO1PWyd8ydkvSu
	LmIcPo5rEPRbJEZ8D472Y5+Bkl0CsKEoKnNHENrK3vQBo4v2h0zJQ+G2
X-Gm-Gg: AY/fxX4+vh5Ixt6AMlbgBeCM2XAB/3qWwAbVj46+QVtdqKQU4Z1JKFwbfT1NdsUk5OJ
	7iHpfYEePqVORNQNGriDrx/3R8L4SxVeBPp6D81a2X4kLHQU5ihCkWgRc+NZQ2M5WXGZSPI9TZB
	pi5ov0j64Bd1s4QODMswAgbp7jED8xZcQKXmDNcpMOtPsLjgX4LQqwhmJJD2Qm5vQElz3F3uh4s
	g5Eau/19NAyRnGVg10L8ty3uyvH/XjOVW4uHawqonOdxJtBo+2kjQu0D/leMgQS+F2GGfOI/o38
	Afjna7yAQsDhAy13RqgvgY20R/euhAm4jeP9yMnlkLm2UvN+7IvrLYPKn4parYtS9i/3SCx27MO
	RFPypawHdN6KVPRcbkHeq59n/8on+RvzjyM0L1cdg1ce+X9a09nwt4befIqIHJ2Kn51rXDXX2gw
	C47oy9rjDJ4TCP095z
X-Google-Smtp-Source: AGHT+IEnt5MFD2z92xcaaC0B2FD3jHvTV/CdQSmrEfTkHhvBEkCeNRbln24shg4R5xbEeUrAsqetcw==
X-Received: by 2002:a17:90b:1d0d:b0:32e:23c9:6f41 with SMTP id 98e67ed59e1d1-34e90d6980bmr13148402a91.5.1766536147584;
        Tue, 23 Dec 2025 16:29:07 -0800 (PST)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7bc69728sm13429268a12.19.2025.12.23.16.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:29:07 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 23 Dec 2025 16:28:45 -0800
Subject: [PATCH RFC net-next v13 11/13] selftests/vsock: add namespace
 tests for CID collisions
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-vsock-vmtest-v13-11-9d6db8e7c80b@meta.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
In-Reply-To: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
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
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
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

