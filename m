Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7097329C67
	for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431243; cv=none; b=WBZyfA3DXC3Sjm/agvlCpt88uYd2fNXwj53yCY3N5AlLLuKSkXwE6XlZt3ecv4QuqZpno9B24oj4KzHjboyBkXEvp6HKuNZxVw/dncNMOeES1wZBn65k4wOT1Oo28GxIFWo6O695XxlLSvsF3fGEH6UxLdAuL9Q+EhljXtw6BxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431243; c=relaxed/simple;
	bh=3zstnYgrjjZTcL85zX/bwEXTpc6YD365WK9ireof2ic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lP9y/R0qO5z8mN+Z6xMQkIyBabOHXhTKjdir7wf3SXKHsPMmrZGg6Exjubz0lOuxp3/2XxvJ7mEPlIklB0jE90mH+RZmEb7rMLRf5EwvAATSz0xtGXLWs+DUKqL4BcuZd7TuuwD8EQVuXRZaVQb9Ye8zHFB5P20YNnEYoqBoC/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7n4kIYe; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7n4kIYe"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3414de5b27eso4054200a91.0
        for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 18:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431239; x=1764036039; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qhvm+dnH460Tt7FFn5Fd2rcGuVIIsnu9XpGRtebTbS8=;
        b=B7n4kIYe5DyUiRfFRnfMRdXWYqtrzpqZ4u5NC/55rPYApPuQUUsGLr7h2C52euE35q
         1cSzT3YaVALXAmkGJ2tn/c0Izf0TnPdd/58DndJmkkRNCx29gQrdQgOI6LYrkB4D1BbY
         f2jO16MmYuyujOOMm13xheSxOlnnpDYwsLV4EYFX9PEobjX6Lp0o3dBVHje0ZgfrsVDK
         cqyrqnVf6pXzHuvTYqK8IpwlLNggP32lNRbWLH5XY9ynh4cIC0Uk8HkdfCSbE1+FzOAw
         svePxMBLAlseaozea+BdqPB+L+qry737vMPfSSe9kMPPpKOSfKMa/VqKInAvrEKJU4tf
         yX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431239; x=1764036039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qhvm+dnH460Tt7FFn5Fd2rcGuVIIsnu9XpGRtebTbS8=;
        b=qJ9cbDvZmr45VBTM40HbpwZUUBdHK7Q0/mEEj0hNx2msz0aZiXm86Q0/NwL+jzOpad
         hBXKjAIzJ51KQYb9+0ic6HQsBeULbi3hdXAsy65nGlMHL9WhCzIj3nbJWNJjWImf8HhJ
         ASOgV8Xf+FgWCmRLNEvM8AntDz0UZGoNq/D824IuqKfwcpOARvcX60pzwqCuXK+4ZxQt
         gMJNZaKpV1rS1BHGEZvtx9Mibj6UlMPwSGYsawUKqCkI+WnEDo2mPaqf9AJ10xpoKXy4
         nSZpcX3K7dwwsyF96+SZML6yIffMn4o8IwgPV0XdOV0PfEA5N3IYzri44yTnKQ2AimJZ
         MUxg==
X-Forwarded-Encrypted: i=1; AJvYcCUIL6+NjIX1g7CJ3/yXKxCTLzWFs2etmuXsU5cQU2QPAhAUK05qMaRbvxpzt5m7xeurSMB+4wwQjeHkqEd05w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdB1xueTE35mcPnT0resLYJCw0rTwATQ2OV6O6y8WcPu8/RQ0o
	Rhd7ajZisYvC9Oozo9rdzfVZW6MhXdFeL1InWc1FCo34VoNE9ckcIHg2
X-Gm-Gg: ASbGncvKYveVGSyfCDVi3SqFRBJkF+pqWCRLwn+YD7aAMZlri08nOCzZ3czz+u1bct7
	5avrrKDbdk1xvedSei3QKRaChvB1YJIAfJ+8+RTrW063tVz/K4zNWzJLh1O6IN9brvTto77p7vp
	FeePHyJKRw6wbKGf6Z3roKXWJpAbQ1tWELwopF689nKyfPTlzn5UPzptjXeDQNzG7/rjVRiQ8av
	OaeaB/4BCQFgKLk1JLLtGeqXoW1ixev/TRPUiog71vaSyFHtxLlxbBjqqJ8ZGZBSIiTO5JRoggD
	tJn1sfBgCJDzqn+fKDdUVcXRnv3kjsMDdbASWSTDai9pjpimUXRAzguBXKTTqHHq03zfTA6MTBR
	9IIl7DBtVG0CTMItKntThnRPKAYjRShMjOHwOV+2T81AYGH6qy/8glt+g/R6o8wMR5emahD1rtA
	Tqj3KMfGOcHow2mg1xo1FGB+cIvuSAkQ==
X-Google-Smtp-Source: AGHT+IFqV1GrHr3XrPIYmCcvEa4oEIM7omi6fW12jvd7AtWF00Di4zCzOTV0RIbzxFbKb2Lo+nb8Qw==
X-Received: by 2002:a17:90b:2f08:b0:33b:dec9:d9aa with SMTP id 98e67ed59e1d1-343fa7493admr15317741a91.25.1763431239229;
        Mon, 17 Nov 2025 18:00:39 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345b0202b16sm369741a91.2.2025.11.17.18.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:00:38 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 17 Nov 2025 18:00:32 -0800
Subject: [PATCH net-next v10 09/11] selftests/vsock: add namespace tests
 for CID collisions
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-vsock-vmtest-v10-9-df08f165bf3e@meta.com>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
In-Reply-To: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
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
 linux-kselftest@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
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
index 86483249f490..a8bf78a5075d 100755
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
@@ -553,6 +568,64 @@ test_ns_host_vsock_ns_mode_ok() {
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
 	for mode in "${NS_MODES[@]}"; do
 		local ns="${mode}0"

-- 
2.47.3

