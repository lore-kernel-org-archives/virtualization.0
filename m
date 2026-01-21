Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E81D43DA53
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033529; cv=none; b=XSTtAaCBU8AoaHfmOFJWq46dn3RiXinXVpkACSSP0lVwRxI2gu46u4CPZym0MZq2/C5BFnyFfiGN5wg/Zl9Um3k0peiA/cI2bbWXtmjPQk0nmammsRSDmo1xv5dl92ErmBPMmryfw5ce4tgc5t+f1sE2+CcqYn+ER5P6FyRVYV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033529; c=relaxed/simple;
	bh=FRcd1avd4PB9PmO5dQgmUicVEjm2xp4QOwjVLS7lcRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KIVmMqkGW/K7xcU40BuqJI5v4DwOAKj7dz0O3lPglv9Jzb5IktCtuFeA7QRtLYIb62bmM7I12pTtxbYfdSHA2xi/BRMkzhGZFJt3kasxHUjDJVqXqUujeP0WZSgHo0/4cd3BmJrVOlZ3+UWkAKBY5gEbRBMaYRUxoy+CpcMMOKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThpnblvS; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThpnblvS"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-648ff033fb2so428056d50.0
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 14:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769033523; x=1769638323; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I07oD5ozWqHJLvu76IbvCT33HoDsgDmgjc920I58eyc=;
        b=ThpnblvSC9a0cp9cThHtiByIFe2cfYKQMTrwJIQcp3Aq//+HxgsQinN/QPURtNa1Ao
         UnTYRIfodAW8zhNPG+upUpmL26zLaevmMYs6Sk5Ok6rBw5XN6OzPENx9wzEgJJjmA9sQ
         icgI1YnZiwpX+5WO3QXllOCrv6T35axZUqteZ0bmnjL3CfFNn3I10/2G2ScnSTHEfP6B
         5QFVJRoIt0/AK+tlZVwdC+vrUpv1VThgGML+BLHDnMGPxetNzR409JcxIDDV0srqUynt
         zKKEvS7523vwp8IsxdqCkJvR+mebbwBZE19+Ua1AUPaNiGgxXbsyJj0pB1r1wlvkOgG2
         hn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769033523; x=1769638323;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I07oD5ozWqHJLvu76IbvCT33HoDsgDmgjc920I58eyc=;
        b=j7SL1nEwQu0Bqywf68ujjZ+iiV1PLkPkdoTdfRXjoxZYjUxahRBGveVJOMdLf5R/1X
         HPH4hfOZlGd2OhBvmxFi+hxNVODacgldCgIx8KaB9zHq6cCUJ1dUxFppikv+4A0sgC5T
         K05yB0Vnimq6ADvUWZ2YV4QYWJyjGLgsUpH6CzXum5DdrNNBA/QSwR8gYCu5qV21M8W3
         VrlZ14QhbdW6pB4LGFdhwDd5H8CWb+YvmDpouJNhpTe4BaLV4FxMZ2iwwBSyUmsvBQIU
         a8Ho9o/kpCpQe9+FNlILePbgKV1TiiPknKYiHDtdufXNUyLXDA25IjC01VjPBSx8z5uL
         ZUng==
X-Forwarded-Encrypted: i=1; AJvYcCWE1Hzxp6lUDWAqDLDWms5irRyLgKeBesIlPB+w3FyIGfxa8Iuhk5lBH33VL2V4JpzWIiw/+IEo6tjTue9ipA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzksy8bxSLpCJVG+iUQ1SZ43uSxaUfWSTX28/8ke0/qNPlDJwAQ
	9lBc53xlgbaqeCota+4O7j0RKjnZbenhCkgftZfoCEP9j3fqmTmyuqZ3
X-Gm-Gg: AZuq6aJaIhvzYMxEYeR1UichHszozD9TYtXA3fZwcHcI83ABDsr+1MHZoEc6loQ4Zwn
	Q1SSTwpjvjG8mKi1RZtSA/vEKhg3XWeh50FOI+IQ82XTB47c6f+712hznr0vzZH29UJGm9e6uQR
	mXMbSx0Zs1fiEDr0BuPwiABnDMMyKLOW3DJm6ADZowOn0GG/crQaGPdjNcFBDK8Vm8CLa5beKyA
	ciUBE+niHxGiO09CfV6KrAzF5u6Z8p7E0eGKqXCdQTbktq4W4uAU6gAtGzZNssX/AFrk9hZEqSx
	lI42P7wrX4rox7xtArkvkfg3h+6soQOhlnfUFcecHNBD5qO2DbnMhnWD1Vl8x8PvJZpkZfNiXFB
	Xci9ReUtEPzSIgfe2u9BRwAeNFPypO/jAwa5mR/5Gb7wuiVs3niGUSJp8ekH5sbnZwGXv29364/
	5973byXyg+HA==
X-Received: by 2002:a53:bc8e:0:b0:641:f5bc:6960 with SMTP id 956f58d0204a3-64916510381mr11289328d50.76.1769033523366;
        Wed, 21 Jan 2026 14:12:03 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:49::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6494080138fsm2463373d50.20.2026.01.21.14.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:12:03 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 21 Jan 2026 14:11:45 -0800
Subject: [PATCH net-next v16 05/12] selftests/vsock: add namespace helpers
 to vmtest.sh
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-vsock-vmtest-v16-5-2859a7512097@meta.com>
References: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
In-Reply-To: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
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

Add functions for initializing namespaces with the different vsock NS
modes. Callers can use add_namespaces() and del_namespaces() to create
namespaces global0, global1, local0, and local1.

The add_namespaces() function initializes global0, local0, etc... with
their respective vsock NS mode by toggling child_ns_mode before creating
the namespace.

Remove namespaces upon exiting the program in cleanup(). This is
unlikely to be needed for a healthy run, but it is useful for tests that
are manually killed mid-test.

This patch is in preparation for later namespace tests.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v13:
- intialize namespaces to use the child_ns_mode mechanism
- remove setting modes from init_namespaces() function (this function
  only sets up the lo device now)
- remove ns_set_mode(ns) because ns_mode is no longer mutable
---
 tools/testing/selftests/vsock/vmtest.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index c7b270dd77a9..c2bdc293b94c 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -49,6 +49,7 @@ readonly TEST_DESCS=(
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly NS_MODES=("local" "global")
 
 VERBOSE=0
 
@@ -103,6 +104,36 @@ check_result() {
 	fi
 }
 
+add_namespaces() {
+	local orig_mode
+	orig_mode=$(cat /proc/sys/net/vsock/child_ns_mode)
+
+	for mode in "${NS_MODES[@]}"; do
+		echo "${mode}" > /proc/sys/net/vsock/child_ns_mode
+		ip netns add "${mode}0" 2>/dev/null
+		ip netns add "${mode}1" 2>/dev/null
+	done
+
+	echo "${orig_mode}" > /proc/sys/net/vsock/child_ns_mode
+}
+
+init_namespaces() {
+	for mode in "${NS_MODES[@]}"; do
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
 vm_ssh() {
 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
 	return $?
@@ -110,6 +141,7 @@ vm_ssh() {
 
 cleanup() {
 	terminate_pidfiles "${!PIDFILES[@]}"
+	del_namespaces
 }
 
 check_args() {

-- 
2.47.3

