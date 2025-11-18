Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738BA1FC8
	for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 02:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431240; cv=none; b=IdRlw6NknayVPELiL9r7Nw+ux1VwdkXucciU3+D9+EJVrPR4TNaZmF/c0jARl4ye3EJBo2FOexXrOFy0I46puitP4piZazNDQAL5SrrDhoAsMBgUlprzP9XQ6ETkbnh4Bkfp2uvDNAQQ8RwJDq3cPg476qD8jIZUv6le7htkO1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431240; c=relaxed/simple;
	bh=C74tPtLEcFlxKPQiq+20Ok+iNGw0X0cvYTmDWlPCWgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iVHR9os6oUCW/1ItT1yg4h0L7EaDLIk7bukuu/epMSpejeR5ksI8bJ7AsZHo1KqhYKZldzqRWmnE9fm+sFAix/eMtizdaKFHn9CrKgqFKErosj0GH1GhAzjRhj6A1sRzQ7Lhqx5O8bDpP52drv0p9moK3AnHtS/TMVTOi6ThTFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fa+Z6tgw; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa+Z6tgw"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7ade456b6abso4363346b3a.3
        for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 18:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431236; x=1764036036; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p28zEBQeBUk36AvYw3frZ4faKmOpLSnPo9g0yADkH2g=;
        b=Fa+Z6tgwPaUbhDH+0rWb+9837Pf70d/WIXo97MvwfOvECozLW/hUQBDUzeNNzPOTtG
         0nsyZCaErwXZLOM4FoVJOiTJK9y3im3P3z9OpvR4ws1vW5a6B9BGEQFvViyg3K+W/NIN
         Nl4Lq7kL7cHhQEEpGQpP5cZOe+ls79zm3eC19yvO9v/FM3k/vdto3Cx31b9jPTCL5TWH
         RBqVNcut1V08pKiVmRI9T9k0gctcVboFrH0quBKCvjFal9FtkqWdq28+pywLvXMEarEs
         /vC28pFvPWFLeSHhvKj7ASN5UhldAkvpascH23IZ3SvDFBABpZR6Yk4QeJYKVmAq1FHG
         9/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431236; x=1764036036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p28zEBQeBUk36AvYw3frZ4faKmOpLSnPo9g0yADkH2g=;
        b=B2y4BkyoPNZdvaXrQaoXm1oTreE/IxX2HpxWfWMj/xqLIvZeQjUeoAhE3S92ZPEZS+
         cFU/WpglmlH7znB431WNUvFas8uAJnmAWO01SdFMHeYKSqI6PHN9wPOPAzLcnjhKX+Qp
         mU8/Z2JHpidoLuDjaM4W0nGDPAKE06Myt/Bm6NvU50xZEAzjNSYhWjruWOP++wiy6DtL
         TD+JW1BFIIxckzYT6la4CFNzycHWNBNmb5zb/vqf9dMpb294Z7STEB0cwht5TfhlyTq+
         Ok6zG7/zrYzfOjNpPMxhKcWRxwX+6X7GXK9DIZCKI7DcYpflUb87u6SoCjTS87dtDfW1
         E3Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXua3yXiuQSzXnp1Zaq0wXheF5p73uGGszk98Rc2qENKKRFiO7sPeddtT0trEYDwjpLvcesNdeOTfYSol3Xeg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4slhNABezMmWk5ePlLPriHuSc7/QSdr+hkjcf2YohFjAVQxYo
	z3VFS88u2Ffzh8oddsj4jPjGWOP+CecmfbNSzSkim3xggHqA5YZ/ycGz
X-Gm-Gg: ASbGncubSwzVafOtz5EUTeafCbRIx4bXlewfV7+ofALEWHeiSnXhRcyIR3ey2NhtAbj
	Rxh6PfHbJO5d9DEDMX4y2Lc/mkOfl/HogSOawBtejaaZ38wHegV4KCvQbYF9hemDuwEkpsGpawf
	xKW51K5AHdb5GgLcZbDkO5Oo23cAfEBLQy2fX+X63nypsPhf5Y5gFfFpbPnwI33/ilnN7XWPj5I
	YdKeYxq0UiG7h2GhpplVhgBGoXdT1Cps9le0rEJ8II36+dY+vuIYoxvavhraLG6MHxIKz9BrdsP
	VpwZ7lZFexg5Niv4XLz8G1QGxt5zcwGVnsffZUsQt8SFUKBMRYPNxH5dcVqRxlHaVbO+9o1SOeE
	SWCwxeH5wgce4TRLsSDYCU/lmhHl7ilWb/wKb8shq5BSqyvTK1hSy3Kz0rGCvstNAznEFqbE3cc
	YV882S78e/l1rULhIv2PW3
X-Google-Smtp-Source: AGHT+IEmbu2Oq+eI39o+T4uA9OHsNgBlxQx43D24whybJe4Uoof/z/T6SCWomsjNpxxj053tcafmCw==
X-Received: by 2002:a05:6a00:2d1e:b0:7b8:c7f7:645e with SMTP id d2e1a72fcca58-7ba3c07eeebmr20196264b3a.17.1763431235927;
        Mon, 17 Nov 2025 18:00:35 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92714e298sm14608613b3a.34.2025.11.17.18.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:00:35 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 17 Nov 2025 18:00:29 -0800
Subject: [PATCH net-next v10 06/11] selftests/vsock: add namespace helpers
 to vmtest.sh
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-vsock-vmtest-v10-6-df08f165bf3e@meta.com>
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
 tools/testing/selftests/vsock/vmtest.sh | 41 +++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index c7b270dd77a9..f78cc574c274 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -49,6 +49,7 @@ readonly TEST_DESCS=(
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly NS_MODES=("local" "global")
 
 VERBOSE=0
 
@@ -103,6 +104,45 @@ check_result() {
 	fi
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
@@ -110,6 +150,7 @@ vm_ssh() {
 
 cleanup() {
 	terminate_pidfiles "${!PIDFILES[@]}"
+	del_namespaces
 }
 
 check_args() {

-- 
2.47.3

