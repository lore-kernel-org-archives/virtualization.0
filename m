Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962FE34D4ED
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244098; cv=none; b=AElxTbJjNmppwFZQI22VdobuQVF3OYooQfcZcEEDO41bfbt42UqOS2hMrJM1HK1FSRZF5lK+CU7Ay/NG4E+OVAh5JY1TSCTqHcZuU9m2pNHsuNSU3eyBx3whxO2ZPR7h8rYjMRTXS9lSqxjeuTs2Ki4I6uAc5Oz6MJ9/4+WKNrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244098; c=relaxed/simple;
	bh=qsdEM4mUEx6lc62dcdEXc4nlTIYZClzkDbVeOSxLeZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XzooqIIhW8KH87GBXpjArCuxwJRd0DxhVqRwjcnZnQsgSNl4R4u5SlBYrbZX5bY5fP4jLpirhnKATb9U7XRiMMtbPAxcZLfRna8ZNwukuwPEGYpnlD7f8fa310gEEaPyfvoMG2hVnM6I5bsinUvNvQYByvuDXLQCH/3BA+QuoUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdWA5DCr; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdWA5DCr"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b67684e2904so842523a12.2
        for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 11:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244092; x=1761848892; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1bBkEHiFKeL/UsD+j471vNGh5kKPPSFbcwNUOh3PyM=;
        b=XdWA5DCrTz6RYD/0cH862gZcEEQjtULkWt9mDz06GDX7L/18BlGhs8B5fqsQ8Oh8Mj
         JciFZtJYH5D75FQ5pGwvVqVE/ZIWYaRsVZTFJBzmWjJqAY9E1zzWjzgRmW94/CdV9Jle
         5oVsUeHNHPIijHA+OllqvLR0HkNOOqRPa3bBteKv3CiRWICX8ItecbPn9P4qmn54EkGt
         s7Ym5b6fNiFss84Ub8Fu5TiUnP9nvPn1nmlRrythQQt1F/cEi1/FIjAe0An/KAk+D6AF
         waOGyJZwg60N2iUxSvzq0EI7Cb3mxMmldZVuq5Zy2ciz7IvkwMANXWpAEcpboicHcT3W
         JA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244092; x=1761848892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1bBkEHiFKeL/UsD+j471vNGh5kKPPSFbcwNUOh3PyM=;
        b=FgXhoHERPxhJ0zSICRINFoQ+YmV72muhuPUfQ4pg0XPoMYtb5IldgWFxjlmSSWGKZt
         nnqEnHD87ZAQIvE24JZ57jH+a3ksvd6U9PG536n9m0z6MtIq01Fkm/YGK1Qs7FtCu0/f
         YmBGPUS5pQBCjWo8TGBVwEraAB6k2j74C6K72v2oMNs2NLeO3NNlwReMJiXgqycj4hp/
         Mvqzy5xBQQBcqTBHvE9x7XGTSPV90cCj4cxowLN37d3XKF0IQ4skYzn78HZ3uGKPPgg6
         dZVSIErnkSXh6A82NdT71us6x+Ft5v3IbZvrhUBe7UNoSsYgJwhGQ1YUz7X0aNJkve1o
         hNDw==
X-Gm-Message-State: AOJu0YyAo0sg6dOab4l8aJkykwiTrVULhOdKJ4JpIJ0tFL9rHKm4PwGo
	KUWRPN8xu3KlaJrnViAS+LjvkqOHgbRxDzV3W0OEKrZiqusfBVPGgxae
X-Gm-Gg: ASbGncswTn5itHR9Eh1N5BizoWjJoA0JMR+YbhqVBG7qutdQm+Gm+ev5tDkjQTk6GH1
	A7+3SEgH0jntUFZGArDHID8m9fxwZtrNNcQSVQS9MQUukuZ8hT0ZV+N+MhPf6gQYhMJnFPBzRDc
	WQiMXmlipgglYaE1aBmm7REeyE5XkcBsy4wfiVZRx3dATBDJAtPptiZBBD30kNbOm6fIl7uldDD
	8IGTrRlzxqAFP8d/XzNLtrTiAan+pZl4TjYV0YbzoT3T0M1gd4YVjX2q5mYl0DHXZ+iHUjmpfe6
	+ViEdE5UBYhDMfapso9bw/jIC51sGPAodIbH81WgQj0HTBZalBuT+C74junv5vfYhxjtJD4KKb4
	HuoRGxshWM6RTNWrfIMSQqTjfqbhiATf3lVrX0NN4zADibTkKoA55t93TSoiyVEPVtSfBtBL1
X-Google-Smtp-Source: AGHT+IE/dwExmoLUemuWd0Z4IzWtCnVPvukg5v4cVC/ETItw8BzfPltzLRhLMffJHMVaO6fvdpyktg==
X-Received: by 2002:a17:903:24f:b0:267:a95d:7164 with SMTP id d9443c01a7336-290cba42a8bmr268233595ad.60.1761244091859;
        Thu, 23 Oct 2025 11:28:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ddec8d8sm30411195ad.36.2025.10.23.11.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:28:11 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 11:27:47 -0700
Subject: [PATCH net-next v8 08/14] selftests/vsock: add namespace helpers
 to vmtest.sh
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-vsock-vmtest-v8-8-dea984d02bb0@meta.com>
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

Add functions for initializing namespaces with the different vsock NS
modes. Callers can use add_namespaces() and del_namespaces() to create
namespaces global0, global1, local0, and local1.

The init_namespaces() function initializes global0, local0, etc...  with
their respective vsock NS mode. This function is separate so that tests
that depend on this initialization can use it, while other tests that
want to test the initialization interface itself can start with a clean
slate by omitting this call.

Remove namespaces upon exiting the program in cleanup().  This is
unlikely to be needed for a healthy run, but it is useful for tests that
are manually killed mid-test. In that case, this patch prevents the
subsequent test run from finding stale namespaces with
already-write-once-locked vsock ns modes.

This patch is in preparation for later namespace tests.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 45 +++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 62b4f5ede9f6..5f4bae952e13 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -46,6 +46,7 @@ readonly TEST_DESCS=(
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly NS_MODES=("local" "global")
 
 VERBOSE=0
 
@@ -100,11 +101,55 @@ check_result() {
 	cnt_total=$(( cnt_total + 1 ))
 }
 
+add_namespaces() {
+	# add namespaces local0, local1, global0, and global1
+	for mode in "${NS_MODES[@]}"; do
+		ip netns add "${mode}0" 2>/dev/null
+		ip netns add "${mode}1" 2>/dev/null
+	done
+}
+
+init_namespaces() {
+	for mode in "${NS_MODES[@]}"; do
+		ns_set_mode "${mode}0" "${mode}"
+		ns_set_mode "${mode}1" "${mode}"
+
+		log_host "set ns ${mode}0 to mode ${mode}"
+		log_host "set ns ${mode}1 to mode ${mode}"
+
+		# we need lo for qemu port forwarding
+		ip netns exec "${mode}0" ip link set dev lo up
+		ip netns exec "${mode}1" ip link set dev lo up
+	done
+}
+
+del_namespaces() {
+	for mode in "${NS_MODES[@]}"; do
+		ip netns del "${mode}0" &>/dev/null
+		ip netns del "${mode}1" &>/dev/null
+		log_host "removed ns ${mode}0"
+		log_host "removed ns ${mode}1"
+	done
+}
+
+ns_set_mode() {
+	local ns=$1
+	local mode=$2
+
+	echo "${mode}" | ip netns exec "${ns}" \
+		tee /proc/sys/net/vsock/ns_mode &>/dev/null
+}
+
 vm_ssh() {
 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
 	return $?
 }
 
+cleanup() {
+	del_namespaces
+}
+
+trap cleanup EXIT
 
 check_args() {
 	local found

-- 
2.47.3

