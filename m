Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC122F3C23
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090446; cv=none; b=PhOZ0P2iKlUatRf+5+GZNWWypDz4AQ+U1ZJ7LtQ5MTkoeM6xAzqKmsB85qkgewtZh272QysAryjAPM4zTDh22Uw2TpFWhQuuBoG1XzuAXBhdsppQB1Lhsm1Y4codp3X/0engpGEcXFcPoBeG8fsg9LFj8rxWQsz6x286VVZDIZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090446; c=relaxed/simple;
	bh=5WTKWKiUk8Dj2RvkxdNnCT58i8QpYZiL92GnKNlZW6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SXRgONyr0gWLUWOSEvfmM0NxP+Wzm/qlTb7QHBWRexf2RL5sN1uF2SO3DToCP12H1fgmv2L2oY0TP62dGhmSVLjfy1C7APq4aOpmXCvUAY76JG2XzgeA0+XusO6LyUzpnPwUtPF8RPquiehYVMPOJZK/h74kSyrDHgHHZxGSMSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jm6KpV4S; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jm6KpV4S"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2897522a1dfso62366595ad.1
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 16:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090440; x=1761695240; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TV8626iy6qZJteqWMHB3Fb4Ctz0bR6NM9tHbIBJXOjs=;
        b=Jm6KpV4SXeNrpK55R7jVvpJxjSxizZ4/pZQiYolCIj4tmtMlHDpexzs2bhPQYnATIb
         GVoGrbCV9C1cppOYAe1MBL1AqP8aOq+GgVQnBgsSWcjAzgaWQ8IRP9XLTpeDWfIMpzIM
         q5H0756z8GU1zv7HAKjIJ1PNwKDb6vuM97HBX2/e/6Qc3q+YtCWCDSsjzXeInCjTjGNn
         YsVbAK0ettQesih6GPbkPOa+mrNbET4bUw0e01qqeHVJ1yyFInZG09tJPPSrlrWX1+Y8
         ydcPiUYszJdd+rlGFsQujFRmktMlg02lHdPBJ0rGtxoOwNNQ2WNW/xtzwVD+Sb74/4sJ
         6htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090440; x=1761695240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TV8626iy6qZJteqWMHB3Fb4Ctz0bR6NM9tHbIBJXOjs=;
        b=gvIBioynPRCRTxMDX1fUcIjUWHyiaLfsaesHNXM3snjfVHxWhhg2nYzIuzS4kXOveR
         yGpAJ1G3AMtAU0H5g+0Wvpd4aV0HNrFaYwYElycg2ba1pZse9/75HOqwxjHGGAJohDAI
         Kr0r4Ff0Ljc2EmdPxcVCZHdFCeqFU9gGW3F5Eww6Q5MmN3fNvMloToaO15eNgrGNBNXH
         Ow6crue4RLUa3AYO/5cUdNOBto5bdRb461ZembQV0HGmx8YbftO7y/qP+exTvRH2N/Kn
         r9LrkshBK898bwyx4Qez+GTm/AyNSLScAuvfTKlhBB1APd7haP3N/14PnUCeFW8r3ftK
         ZxRA==
X-Gm-Message-State: AOJu0YxGgeTOY9uABbVu8NRhaxPliUQpijmTsyVOD8173b0916UIbe0y
	fqk1oy1wXjPGekElEswmqRLcIL80iZEmGEJSua6ipg1mgge8ws6Gb/zs
X-Gm-Gg: ASbGncvGkFfo5Xk+8o9gLA1MfKa/YlBTKga+86KXvz2oe/MbQofLt5lPhNZGmDgMK/z
	wK0DPCNybGeARq29kKKGYzXSUr8uCVEgpDUeBjnWq2B7v5zh8ZNHLxiTsYRrcGzfAc3hCX8OPcn
	aW4ku83BpIdI6i4rsWF2BtXoG5A5lGrgT6LDfHmJQdzDKmGP749En54qa+wqfN9gRYd5z6TwDvV
	CuKkhotT5gmS5e2ZZRMi16eEXttf14V8pXogR4L9kiU7O16qg2pihZwEcdmWOrd4MqEEaD/UtVv
	NrRd/h4CTYXiOFU1Fm4JFczskyqrnrnK60OSIlM6cdrTUAzABFaCsJs+77gbTvKJGe14Xyo86bQ
	vstUjv2U4wg81kIjiK6b0RPr7nztMMFl0jzyrJdnkmYaB3hGZby+HAefX2t6sn82FtKCeS2GzLS
	ccToFg
X-Google-Smtp-Source: AGHT+IF3YtiPWvZebVNqksLPddW34hdGMs6SWVpzynIffF/Cg3VXxCHnVj5pafWbxKnLw/A6JvakJA==
X-Received: by 2002:a17:903:11cd:b0:290:9a31:26d6 with SMTP id d9443c01a7336-290cba4ec04mr234640025ad.57.1761090439594;
        Tue, 21 Oct 2025 16:47:19 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29247223a3csm120532795ad.112.2025.10.21.16.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:19 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:05 -0700
Subject: [PATCH net-next v7 22/26] selftests/vsock: add namespace tests for
 CID collisions
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-22-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
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
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add new namespace tests that validate the CID collision namespace rules.
There are tests to ensure that global namespaces collide on the same
CID, while local+local and local+global namespace combinations do not
collide.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 74 +++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 4defadad5701..69ec6ec82b0c 100755
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
@@ -546,6 +562,64 @@ test_ns_host_vsock_ns_mode_ok() {
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

