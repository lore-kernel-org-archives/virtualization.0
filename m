Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA422F39A5
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930553; cv=none; b=AM4c4nLw08UvmZ7rqjqBqs+JIo0y42khE2Y9JvhrjBhqu6KP10f4QSMBRqnUY17vVpHg+XLOQPbZXPr0xDhqksRwrQupPglv2VauqHqJOcf2+Coe/pjI3F4Esn60I8t9W5aemIlrUKZH2IWEv3Av6bqfsWyLYFACCPw7GW5bb70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930553; c=relaxed/simple;
	bh=1H3EUWCH7xSBo5TO1aY6eWGm6uEkReSWSwsgMjSlU2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tKgBjHFdbMOCELNz0vf/FulG2y/gYyRoHtMbyRyRpsXm0Gc+uOIX74jhIf30SrkMBMKj8DTimrUOvPQ2EtwD+4GPwTGwXHYJzfR4M0KyMlwGuPUhSWjmF07P9AIYUunDwAZimi/R+ZnE2Eibb6kA/cWnfKVJGGFqM40ZyCoKxPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnsVAmRj; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnsVAmRj"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7810289cd4bso513533b3a.2
        for <virtualization@lists.linux.dev>; Tue, 11 Nov 2025 22:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762930546; x=1763535346; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPZC3vwzZRkI5HZ/q+i3flgAzmARVxeU5m73M6Jn+5M=;
        b=CnsVAmRjaVuQnL8qYY0tkWZcwL1dgnrAJBX2jJJB0sr/uPVxbRZpbGorniSomXMbU0
         jkEK3wkx/aOUN9z/kOfK+aSlokbaPWQLyRml1cekY8eJLGiF9+ALDgKk0XshoSMFBDU9
         m7VMe6hizBpr6BZ0aSjRIxdkfaHfQ8BBKXL9h6QM58k6jjQOC/dh05PBakYJY2vfFxlG
         fSOcFBzir4E6c6UWYictBwD4BbMMjcbyPTLlUWgG3W09/YXvYNOGig581p4HBr0MCzmW
         X/SEnH7LGnqiUsisE+q31ZtXW7CQLiBM0qUQlPbAYcmB5qZLgANaT6/kTvKU1SK605GN
         q2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762930546; x=1763535346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JPZC3vwzZRkI5HZ/q+i3flgAzmARVxeU5m73M6Jn+5M=;
        b=UKHMPwagFF1epyjPEpNN9Ak4oCrFtJ9kyyDI1o7jzZsl6NcV5JBSlMeEdMSP4JesVz
         geL6DoX2GyZ2TFXBTT6Gddt8wv5OGCzBgsZEO+bfFKkP2ZIMTYsw9bndd9g0qM/uqePx
         Yc2kM4nY2YQ3A/7snxdhyuykuFeNWlsAONEOTW7xP7meU4QBIMQXlPRiIXEUx46xj8/n
         SZeROBqShhRaOkRr7T0CjrFUk2XSyJd62UvFpouX1NNdoqW79EsdRtwRIPvULR6I9TIa
         OuzIW9+zg7jy7z/u0DxgfWA6UIe0k9KFld1MWf52U8yXc5bIAeRfU1sbLiuKTI4DC4s2
         IUQA==
X-Gm-Message-State: AOJu0Ywh8SRzulqlN4GRuuaa1OHXYQQ7o4gMFpUDesaYHViFDtfdeEvK
	4ccWyZnUigMIhCgFysnYChqmEcQUx9PdNtg/l0FcCQdDVtLKJo4USu8f
X-Gm-Gg: ASbGncvPAyFTFoxH6DWKTM1ZzWDp8gLzBGGKtqUKs0P6XUHUX2slasXsv1OxWKWE1Y/
	oY4QWLH8sr2spyeCNIaLrZ/RVVa+arBkyEmRkLTQj2RUIa2M7ucBj1rt+YtXI75IwK3/+4ab9iZ
	5nv2jqpraoVliaeY/d9WdTULqmHNzpEHe3glQpHA4RGSpBlSJVWuCWfJvlpgU0BvuvGAl9AKH+l
	DlEzh+Ch2uuvL+cO/x2XBKLNU74inp4MyVN/5BsSJBakryKOk435sCp1oItwD+pWmZWnkIRQ77R
	CpyVQe0vMnjmnNP719/F6vlTciZadQAGGIPw/hRdNKAlrcCptmziX3DvaQ6uLrJVRID5MMuGxk3
	5Ib/UCgHMleaFs2o6uPv3jN4RBtzDuhavdpmjDLIaz/i1+ueqTFARk9YM8ZqS7IqYSVtZtyID
X-Google-Smtp-Source: AGHT+IF63wc5PyBiuw3bp1ZcuTXR2K3zypie/OPBry1LcGiDsecEoImp4LY23rndvM78wnDiolZbBA==
X-Received: by 2002:a05:6a20:7d9b:b0:351:1cf3:7f20 with SMTP id adf61e73a8af0-3590bb184d2mr2455933637.59.1762930546212;
        Tue, 11 Nov 2025 22:55:46 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf0fab0ef9sm1730860a12.9.2025.11.11.22.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:55:45 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 11 Nov 2025 22:54:54 -0800
Subject: [PATCH net-next v9 12/14] selftests/vsock: add namespace tests for
 CID collisions
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-vsock-vmtest-v9-12-852787a37bed@meta.com>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
In-Reply-To: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
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
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
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
 tools/testing/selftests/vsock/vmtest.sh | 73 +++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index ef5f1d954f8b..cc8dc280afdf 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -48,6 +48,10 @@ readonly TEST_NAMES=(
 	ns_host_vsock_ns_mode_ok
 	ns_host_vsock_ns_mode_write_once_ok
 	ns_vm_local_mode_rejected
+	ns_global_same_cid_fails
+	ns_local_same_cid_ok
+	ns_global_local_same_cid_ok
+	ns_local_global_same_cid_ok
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -67,6 +71,17 @@ readonly TEST_DESCS=(
 
 	# ns_vm_local_mode_rejected
 	"Test that guest VM with G2H transport cannot set namespace mode to 'local'"
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
@@ -558,6 +573,64 @@ test_ns_host_vsock_ns_mode_ok() {
 	return "${KSFT_PASS}"
 }
 
+namespaces_can_boot_same_cid() {
+	local ns0=$1
+	local ns1=$2
+	local pidfile1 pidfile2
+	local rc
+
+	pidfile1="$(create_pidfile)"
+	vm_start "${pidfile1}" "${ns0}"
+
+	pidfile2="$(create_pidfile)"
+	vm_start "${pidfile2}" "${ns1}"
+
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

