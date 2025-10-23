Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D390134DB53
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244103; cv=none; b=JpMeOAjGdVAybsCqcncPB8I+tJxflBvNtpd3v8sQ/Ao8Z8c8walXCHTSVUN0koUP83B7aQN1VfnBBWPnSSIiLL32YkCUXlQPvXvN2ySPYn+btyADunFq5dtSaPi+yeyEpLCOoPQgQ2Q1b9OdckyIhMOvel+4VXhuHIe6V+e19d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244103; c=relaxed/simple;
	bh=5F5v73spaO6g7IkcyDH3GDS87tLNHAMWY+Aqa2TXZbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZJu+gpk0Id1pfz8i+gIYVJbcAfoDkzNvB5efaRFUIhMPdqLoNXC7x06hNN5BlrmaMCfYyX5k0aS8tlK8aAKeqqR0pUfypzGZIjII/XPJtibEuityfTEMkIpCaoYHewvj7M4BRUBdXVHz5nkf9QGLmvfgh6yinWHIcBhWK619HKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeTuEBk9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeTuEBk9"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3307de086d8so1252246a91.2
        for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 11:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244095; x=1761848895; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edpWGMd9VbWpBkt/1Y+NJ91tcxlgSe0i7beuNiNUjc4=;
        b=jeTuEBk9DT3vAhGsen3peVLOxPscUIzW1Yrx7k2MmbX+byLwBAz7g7txt+k1d3y8MH
         sCgwq80EQPGVBkAighPMgkCYmXoZHCsDZjdT2im/uIFTtUsKBtu5TICyeY971sjwl2NT
         K9OHNMAFVUCd4vrTRzmXgTFL23TyiYSSXdwEKNwIsBU0PGHARZ2lSSPYuq3ZijWmBocP
         xljIdB/QxOAtTSIHQr6a0LIcqGNZC+xQSfod/IP6r0SPfMVqYwbJWhZlCBLjbZVZzkSw
         IGwTYD59vQzuwubC2SxPJ7OYaEgDCgNL3bb3mpBuGVua0HnYEtKLKbr9jrM69SuqFPAB
         z+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244095; x=1761848895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edpWGMd9VbWpBkt/1Y+NJ91tcxlgSe0i7beuNiNUjc4=;
        b=ovy70ht4i0IpvNUZxju/g7P9K5aizj2RhNjAa9WTbYI/Gr7Hp1A67Zx4gkIwZzqs1L
         W4WrRgOSQhb2YSO3xOh9kipi4ajE1siiS5hVa7QsWynJi1BC8jS9Ieur2cTJPpE8ZszR
         LBJuemUAPcipv3JnSfNQuI+JzbWjQXhAlaFgAlY7ug+cCjtT2IXVtIZFJE9Jn5CV1FTw
         5sr/0yGJJrttpfMEHCiy3nHGEY9oyaSHEl918yDZbneqUuIxD0AjGjC/Sri2JRzZYxHW
         v0uQ3zHaSXHmXno1ePaBrdYGGNJf24fAT2T3+893Yxuw10xhF3z7PsFCZFSKPuuykzsl
         tWpg==
X-Gm-Message-State: AOJu0YwoZqxuAlxw+5MlUT6ya89uHEJLkM8t+AAainwKBUZLWF+g0Fah
	EUCXlcK5ddNYB9Sfo7efCudfT3I5QVX5VH3WWHETjkBo/jredx4YZnbm
X-Gm-Gg: ASbGncs0SJ09Key8S9AEK+g8fxVOYvBToh5gq8ADL4SFfD4AENZUuo2Sk7pAbetrZ4p
	BjYyFDK8Du0tyVMKTDMFFD1pFyBJkUty5xkXF6pu3xCT50EE7sGsM0+C5nDQ4auL477n81/TKq9
	bMZx+l4MbWQV4fSXxwIq/z+Tzwb2Zqcn9rLHMBZHQxE7rxLaD5saPwnXjmsHKCsxx8roXgIYrqJ
	osU6lW/RavtWUS5rdWfLUAegIsOaeHLQwJYdSIf/ECHFHrHEtBPcQ/cN0fmCm4GenM3iCSwdDdc
	+pL+tU25I2M2yGF/Ff/xs66b3PN4oSPNEY0+1OeTLftLy6gjseKzmwNgYSSlMYcgI665osFCv0q
	ZeKhxR3Ssj6PwUtcBprNEPwwS3LBiNn/gCzqWewiNgkxsOiHHjOjfsZ9nbqSrBZ2xKTsNcocy0H
	iZ+OmRHdE=
X-Google-Smtp-Source: AGHT+IHqGJGfE7/AR7EEKGb5aGT4lYi4Q0CdcUhFDN32WBMZZ/a+b4mtH/4xEGFnf/S5gHM7f9sTTQ==
X-Received: by 2002:a17:90b:2789:b0:329:e703:d00b with SMTP id 98e67ed59e1d1-33bcf8f769fmr34761255a91.19.1761244094881;
        Thu, 23 Oct 2025 11:28:14 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dff46d539sm3689641a91.13.2025.10.23.11.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:28:14 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 11:27:50 -0700
Subject: [PATCH net-next v8 11/14] selftests/vsock: add namespace tests for
 CID collisions
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-vsock-vmtest-v8-11-dea984d02bb0@meta.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
In-Reply-To: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
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

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 74 +++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index b775fb0cd4ed..f2a99cde9fb4 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -44,6 +44,10 @@ readonly TEST_NAMES=(
 	vm_loopback
 	ns_host_vsock_ns_mode_ok
 	ns_host_vsock_ns_mode_write_once_ok
+	ns_global_same_cid_fails
+	ns_local_same_cid_ok
+	ns_global_local_same_cid_ok
+	ns_local_global_same_cid_ok
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -60,6 +64,18 @@ readonly TEST_DESCS=(
 
 	# ns_host_vsock_ns_mode_write_once_ok
 	"Check /proc/sys/net/vsock/ns_mode is write-once on the host."
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
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
@@ -548,6 +564,64 @@ test_ns_host_vsock_ns_mode_ok() {
 	return "${KSFT_PASS}"
 }
 
+namespaces_can_boot_same_cid() {
+	local ns0=$1
+	local ns1=$2
+	local pidfile1 pidfile2
+	local rc
+
+	pidfile1=$(mktemp $PIDFILE_TEMPLATE)
+	vm_start "${pidfile1}" "${ns0}"
+
+	pidfile2=$(mktemp $PIDFILE_TEMPLATE)
+	vm_start "${pidfile2}" "${ns1}"
+
+	rc=$?
+	terminate_pidfiles "${pidfile1}" "${pidfile2}"
+
+	return $rc
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
+	if namespaces_can_boot_same_cid "local0" "local0"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
 test_ns_host_vsock_ns_mode_write_once_ok() {
 	add_namespaces
 

-- 
2.47.3

