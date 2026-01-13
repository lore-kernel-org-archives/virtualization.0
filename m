Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6F83314D7
	for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 03:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273991; cv=none; b=SENx9K7qoslHjHWRm3kVv9SzUzp4b0kFIDKZMPacQfcRsxRdp9x4X0iXRX8GsN5lfY55bMUqj7WKzZTnyJe1VUD2uC3dsyNX+LtzOtWitS63dzB1YPnyWwG3RDtqiphbKc47QRX4+32knQ0kOO0y+rKzjFcsWJNO7VxPOSqCos8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273991; c=relaxed/simple;
	bh=43YZlXDQmW65hszyjr5m3UtpfpB8+72+oSXEtxR8B+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lJW8be7QsaIaE75EjTc5oaDqnJeGx0POCwE92kk2dMgKKLg1FBn9Z9/xZk+WyQeurlhsY4Wyk9FcQAea17IhbSoPBvq4e1rJjVpzw2rZeO9BAlM6uFPJNLD+ZMkNpcMiANK6QowDkL6ytIIlUsxgr1BIHca7jNNKoT8wZAS0YAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzGdCHRO; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzGdCHRO"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78fb9a67b06so49773987b3.1
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 19:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768273986; x=1768878786; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3I8QcIsIeOrh9cIrz38ZjjL+G5z3ujRC9KA0ugGud8=;
        b=fzGdCHROcrkYqanBuBLk+6oRRfjNF/Ia2aSyQMvOruPUiu7Xi95/Wok9K7Sas1A0Dv
         lsYsqW49Mdls45mK/ImQPwvx9/98BsoNqY63Lt6LM3P0ipQQgI5LzXd2ZWyKcb5wbaKr
         0EVxoEyeMsUWv7haq+D4HcrFykyD6A8KCgc2EAY+XOX68Qeq/fcWcFbYxAdgsWKttWzO
         F69z29pwSvWXA/3mEb0tnPpRpiyK5jGXwOBrk+4+li/1wyTA5Am7bPgG9xIyrqn6Yq0T
         +V8FXTM8G7cJuZvAWLI++oMykYYG/SN3c7BSVzWrEFvZ1iy6n86SSyT9o5K3r3bN20kx
         DyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768273986; x=1768878786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y3I8QcIsIeOrh9cIrz38ZjjL+G5z3ujRC9KA0ugGud8=;
        b=Z1MSKRchEQmUN+Cg4UWRpMCA3qP28pdgIIK9b/AOoPmGABpjR6PzK03BhBv3qfk2qm
         B5cKiaX51whxw0YJZwXMgFmq1QWcVHvVjOLrpnKNmiqK2AIL31MLwYCdY958pdZRxDvV
         wO9mr1cib/tkAK+zgTYZWwG0kIL6wkEqPa7FNqYHk/+9NzeF30RIOxZLoymncnShxTwW
         IC2eWE3n2jl4Buz9EZfPa+mVPhfgZdGXW1zsYM7FkQXKVIG8ZtPo0x06MU6c39A4gYw1
         Miyx1sEQHPhb+SiUgfprM+MVzSU/KlA8jeb6Ic5NFEUJ+yW4Ol/7rZdLkmKSubi3U1FY
         OfSg==
X-Forwarded-Encrypted: i=1; AJvYcCWDBK463rlnxNeKB32IQS2Oodq/NSW+0eAhS24Ml1ZrNS7NsPsR72kVKfJmzughiLyH1w9tJUF/3u9WtSv1HA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWAlNsFYXuqqSB3NhjbH6v2lblClsRcXlzc01dxFy3BNF8ERZM
	kfefwk4pdyMaXiORjQ0wMODMp2UaGVGCJDi+YS9A6zJKmj9LojzX7oZj
X-Gm-Gg: AY/fxX6vjOJotWyXogSVxXa1uYVp5IQS9HTfgHntHWJTJqwqROOKffDKkspRgO/8Dud
	1R8TclVHYnXsyEo2TC0a0PFdly90ZkK0zszYu7uJNIx7lEdP5WIWNPpQuFN11Y/VNIsxKhCk2DV
	QpK/1P8Vov4SU5L4iLNdWUqlzlTqWDfHHwNdKd5SqRkHEykxLv0MO9Q0fIoxUx/mzmK2bfr6e9Z
	COB2vuJgqlFRQHWN6logKMZaMatqbY3GSkVXSfP3RDMe9nlFksxd1Tei/IYbO7T4d/9+iSnvlFi
	6tGDwMu82TC9uM+c/5vAOsEc4EoLSxfdd9yAHzjCGCcKXYcUgabVyW1IytKn+mxDoKNK7P95gSP
	grkb3kDlGDLO5xb9K1eAFORGG3MhajEOMxAfXq/igzM4DxZlltI8Ot3oJc+Q72k0gn6W8308GUd
	7UkjjAE0JP0H9F6jLE5DoX
X-Google-Smtp-Source: AGHT+IERhF9/l61WGAQ1JPbNCa1uy97rBtlOCcNLY+Lr8nEdQsaCK1nAx9XYRA7ZWkcN16bvEB72Wg==
X-Received: by 2002:a05:690c:6f05:b0:792:7721:e072 with SMTP id 00721157ae682-7927721ee43mr68361877b3.11.1768273986386;
        Mon, 12 Jan 2026 19:13:06 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6a3969sm75907927b3.43.2026.01.12.19.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:13:06 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 12 Jan 2026 19:11:19 -0800
Subject: [PATCH net-next v14 10/12] selftests/vsock: add namespace tests
 for CID collisions
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-vsock-vmtest-v14-10-a5c332db3e2b@meta.com>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
In-Reply-To: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
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

