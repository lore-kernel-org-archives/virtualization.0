Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D132B2ECEA8
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 23:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090440; cv=none; b=guY1ZZCJ9yxb6fGBDQM4IK+ncEawSr+8/gs8FG3f33iHF+7MzNKM5EVi0kEG3lV6FIUttgWzzDmX708IYtzxlmf2CEpe1kx0Awz29ydoIdzK60ajyyc4aLrGFlxQNYoGrROzLiVz8rKzkSIGxGbp8/cqgXPm4E6h8OWJamg3pdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090440; c=relaxed/simple;
	bh=X9WzUQups8TkdsWmkHEfnPyp3k1TVWabO4OwH0YlSZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nmB84i7EmUKHsrcilte9tXZc4PJUOyUsM+7+nwlS1CHrvCE4wXV81gDy9Dgt+8tg949+OSoO0fpUECVUHiQpzeNzMW74u0vj6J3nmmDtFGXWQ+zwcxTp1kTKuI0nn8edqzashcFroKb0PPnmY1IEydqNRdvCAG4t9LQLTJJ1WDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REfw3Es2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REfw3Es2"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-26e68904f0eso61343515ad.0
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 16:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090434; x=1761695234; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExL6guYlGMpC9HoFsJPCjZr8NPSDth7dE4rzR6CctFc=;
        b=REfw3Es2ZS6r75PrhqAN+04y7DKVLmdtMxjaZuVCVjEK42ulc+fUNEvnWW1p0SiLgj
         9xsC53xRS/gBMws2Fb+yVKhl0nnZk0aUMT824P6M3H/r3w75fFkBPTSh+Jb1Kx1eU7I6
         ilepNcnxUHh/+BwEYmnJFPR6gHTPw3J+6BBcxFhFGv0cawZHCP27OvPMausjKdr55JKn
         IaBOaR0Ig3Kzme0vh7xUd+vnnAAMdgo45b6mV19kleOSng2rPyWte8R+ZInyfYtOxCST
         8LP9+ZImAYIslRXt4bhdG1qJC+VcatlOTPOWyh2ZSY8IoLceHzlfF9ezhhR/nzk1ZQI4
         dXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090434; x=1761695234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExL6guYlGMpC9HoFsJPCjZr8NPSDth7dE4rzR6CctFc=;
        b=ftuDrWjD07qjfoIEwmzjyadHIeAzi3tNOKUcTBlER+xKenGLzgW8g2gUn09dsowJSD
         6FL50xuBRC4V/fd1LlFHtOgAyXeG7iMN5HKILAmYAO1zWZ1FHkYqKcMwukMXaRtvCLUO
         6KeMcAEtNI3ZdNWkMyXwVnkk9b1jQqVjQIzv+/Wflrw3hPp30+FY48T+IOvCQ5v0uSlw
         iV7HwShNoahtjzMi96qTrVpbwUmGSgaQ3llaHpSofjGWehN1KYgQkm7+As2YNp3KXBtA
         D/wCVYvqHpBTYO/QEcVSD/SR8Gh6Ybhwr5ZNFiRKMARHzrrzvnmY3baxkK0h41we9xqh
         co9w==
X-Gm-Message-State: AOJu0Yz7ReR4y9JcSP8b0d1QjL0qXoDh4RBeO9sQBAV4w1OgkJTOKrKx
	vBcj6QqHDemfWHPFVo6K/ZoAQ2l6H6GcZFvx44yfCVFeYsKw8nTl72Sr
X-Gm-Gg: ASbGncvUElffc9VuOgTyDwJC9KL4Ppq7Qob5Obiz+JMRr44ilvkyBsTRRLUvfES5LNS
	cI6wspvVQV9gyGVNY+fJD3pSFGW5KtVqWhzP64OngRh8AKiBAqQgh4D5aNZM4vnxz2JC7YWEPVc
	5vxYj0huZ1rRAiHFR1HVxPo80g6S7L6k1BLQNyxmFTnK8aGeNq9+sBEXR0oV/UzGdj/ADBUraND
	Myo6NxE2drPle26mrSpHb2X31SDXIsbc8IpCgS0y6cx+amHEt9/If8vLwWTmhBoqWRHKI6REEPT
	NnEs5TFFp8j50TRfpv1z3XtKhcWQqotzwEL4VmWLlSyJQPY4E1IGCNDKj8kosBam9TcsCrOUDeC
	ooHn61f1dqMVWkDn7uzOEnsjMk/DSip9qglPV9Ae4lksIsBknyf0jq0lCcMfuPLFlX8nbRYjK
X-Google-Smtp-Source: AGHT+IGFjlVJaAVI5l1l9XcDArSqr800gCJXUHbkf8qJCt41RTFarYvpfL88FKlbpibTKt7cQQNqLw==
X-Received: by 2002:a17:902:f548:b0:276:76e1:2e84 with SMTP id d9443c01a7336-290c9c8941dmr231390815ad.3.1761090434188;
        Tue, 21 Oct 2025 16:47:14 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdcc1sm120666255ad.82.2025.10.21.16.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:13 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:59 -0700
Subject: [PATCH net-next v7 16/26] selftests/vsock: add namespace
 initialization function
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-16-0661b7b6f081@meta.com>
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

Add functions for initializing namespaces with the different vsock NS
modes. Callers can use add_namespaces() and del_namespaces() to create
namespaces global0, global1, local0, and local1.

The init_namespaces() function initializes global0, local0, etc...  with
their respective vsock NS mode. This function is separate so that tests
that depend on this initialization can use it, while other tests that
want to test the initialization interface itself can start with a clean
slate by omitting this call.

This patch is in preparation for later namespace tests.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 40 +++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 4ee77e6570e8..914d7c873ad9 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -46,6 +46,7 @@ readonly TEST_DESCS=(
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly NS_MODES=("local" "global")
 
 VERBOSE=0
 
@@ -100,6 +101,45 @@ check_result() {
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

-- 
2.47.3

