Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF9B326D77
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229682; cv=none; b=T1Ay/znrjii6SwY2NWdnyoqvFc3M/cLrtNjg/ZUooMi1jPa35cGyhzoty2gjNSiVW5gDy3p5ImCpA1ijVoC07tM1Lb7ZNEJKfq6bJifbWr9OgoLtL7NfNRgKFuDvEjeGwR1g1RtDHGCSi1Lgpkgu3mfu0whxJy9lhME2KfpMfWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229682; c=relaxed/simple;
	bh=+2R3w3S681rnHvviIO0MgWHpMBdTB9OzqHRpjlN2cZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FJpbNPO44CXaN/HH8WNkDjN3mEB9tw7JfNwza5vF360/sri/+FVvzN/Q0XXoRH/nvbBnckbwLdas4j/tyCLJk76rYBHjqoAWb5fSJkGu6yoRGll+XgHpxK7ihf+6jWx+zBInjHsrpGB9Rk+ubByd9z8oUzT6CHx780hz+RkpOao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIuosqBZ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIuosqBZ"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7ade456b6abso441335b3a.3
        for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 23:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764229672; x=1764834472; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njNVZdo2YcwUcrU7+c1XfJBjEkwYcrP/2uy6YKalASA=;
        b=TIuosqBZ/Hyv9m1CaveyMuCB1qcCT1NcPwKx1PatrjmdaHU9Ii0r5btJZIhONhoPPf
         kEYDh2uTIoPJAMXOiRYvBXIUugPb6YyydEY2K+FnHO+so8NIJ3WHDEy9lSoZuEd9Dlw0
         26JwgN+n3FlPrWsZ7+Ve6bEwEX17qZ2rLb/F2W8i83s8v8alcfjfJ22Iv13djvQ9P6yO
         JxGDA40AQkSeap7kvU4V9yG4RrGvzzVUqLRAWuagmoo1ZHAUQuG6PuZfLhcDD5JSEr69
         s6gWugbZlXnFUI+rvEgUvvcotk6eOAlZt2lXs8dGJIV9nYS/zXs+lrHVZxUOKzkGGAQ6
         K7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764229672; x=1764834472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=njNVZdo2YcwUcrU7+c1XfJBjEkwYcrP/2uy6YKalASA=;
        b=PoGgQrfNyKMJIy//djXqiidF+jD662jitKDrPliTfIFa5m4RAKlAlBw2mi9gdB8pXL
         8tYWkV1GkQBXzVb83T1/FGoGYzv9Zzpj6LzRitBKmRL65eXbpwNDPBiaS0Lqrdw8aFdS
         88frWvocDMLGkWK+LfUp41eggo3tFSnzJG43fSaJEKo/Yn5D2ItjyPD1CrTShQUeLrZd
         PBZ1ugFEBnuwLZfM6I688V210ttLAnYqqHoJQImW0kAEOYACA+C4bL/js7JGeI5W0DmA
         /xpdutlMHZVXiUsTZViSj+i2gh/BEIzZnL7Khkn9hXvtZEmXVbUhJaMpA1Xx9I1Hvnnp
         sOOw==
X-Forwarded-Encrypted: i=1; AJvYcCWksi4I3nZqEwEhEasdt2aY1wYQDgJp4zcL4XjcZyaJjMjA25iV6L1KznxDWcHevpqU+00EQcd9khZuvxr7Rw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOU+nMi2wTxpzo+rPJDJANxKQmLNmIE6RGljzeBUSIJcPLD4ei
	X1GCjhFJi8ribdbakDMuP2HveNamsYfkiN37SIUmF2P+p3uvUkOylFGw
X-Gm-Gg: ASbGnctEZQwxRS6Ib9kpdM4uGt7aPYCCF5B3S+Sp9yBd0WH3WOm0U5ImRxz0DKZXZTS
	WYZgeDE3Hrtk8Nl8PlXLPrSxDHvhskq7BAIXFchN4XdMSMy8bqqmvm0BJNx8V9OTxfpS/Lkpjfa
	jNPTC+GsqpXSrzKTfii741j8bGpkuEhK28RCbeAN+mUubekVByqF175ISUzYkhjG+t/Ay4a0EDu
	lfw/b6HnD6HCvz+aujaiocW/8lUq9+Z4KQmdJnemKoqMos1hAZjl9Q4r/oeC6vN8j0kXfFNTb1O
	rocC4B9s0xo+0QGCH6bfA1014HhKfs6uWmRaviohR4GQwtOgrdEyamSdCigbUbNcuMLXVi2EoJQ
	WoydXNpX05Ai/VCl84aOO+ZazZm+H2Bem51PFYl7INsQjRo53KpuyFcDVHE9D3pimy0hiih50f8
	GdQ+y2E3nsomDyBIrHD9M=
X-Google-Smtp-Source: AGHT+IEQLozRTu5+aaYZLmpX43UDWknuXMdbfEtxDJQmwd+GQgMyCjfBlGTu04L/oX1PAGiOiTHt+g==
X-Received: by 2002:a05:6a00:1383:b0:7b9:7349:4f0f with SMTP id d2e1a72fcca58-7c58988f7camr22478072b3a.0.1764229672558;
        Wed, 26 Nov 2025 23:47:52 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15fcfd0cfsm913324b3a.65.2025.11.26.23.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 23:47:52 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 26 Nov 2025 23:47:39 -0800
Subject: [PATCH net-next v12 10/12] selftests/vsock: add namespace tests
 for CID collisions
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-vsock-vmtest-v12-10-257ee21cd5de@meta.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
In-Reply-To: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
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
 Shuah Khan <shuah@kernel.org>
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
index 28b91b906cdc..ec18eb5b4ccd 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -50,6 +50,10 @@ readonly TEST_NAMES=(
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
@@ -66,6 +70,18 @@ readonly TEST_DESCS=(
 
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
 
 readonly USE_SHARED_VM=(
@@ -576,6 +592,68 @@ test_ns_host_vsock_ns_mode_ok() {
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
 test_ns_host_vsock_ns_mode_write_once_ok() {
 	for mode in "${NS_MODES[@]}"; do
 		local ns="${mode}0"

-- 
2.47.3

