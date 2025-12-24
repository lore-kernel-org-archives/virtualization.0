Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81D422FDEA
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536144; cv=none; b=VRf1d2ikFo9yTznXUaerptKKXOZqZ6SIzq4tsrkjWqlroAhnvf+BjTO/KG6f8OCM7TrFLgOf1cNpLuU0K9QN8KekoAkApNWtwVloBK4O99tmk2BuC3x2gQUNNqvM+yZOq6yhMW2gHTPwRfkPeBpME2rFI7GBkAj55L+/tJLPq0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536144; c=relaxed/simple;
	bh=A/Re4uBOGGe0FAXjhpo7AUAS6ISO6mznmR48rNydg0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PB0Z6DikMRQ5h5ru6J5h9PFK6ayHoldF0xKArV9y5HO2jBhxYMVr5UayMyFLs9/1INh9PGfWk8RT8+kHvjJrnfArifwweUbU9FzzbwM0ONjnUpvQ6SpioPJLJYANlKffnz6M4FUBvrxoLr0YfBQQDjqBS8kmYXBMh55CBU4gypE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeMd9nm3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeMd9nm3"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29f30233d8aso67223965ad.0
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 16:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766536142; x=1767140942; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMAS5pTBRt+D+YQ3hZNF0StDlF0aWH+C/CFg55tOZdw=;
        b=VeMd9nm3KXSYz8xrvNl1RlDn6BngDKP8+umihufm9LRO3/8D8ObfHiqC27LoAyiJJq
         MqoNF1h1aFLxpfOwNySYkWhKHUeL+VKZuhsI6AaVRdDLWUY0bppd/iLVOVImHsjBBqk4
         aFOIA2b2IWrtigaVtHTEmkPGuf+pPRVI7elJuTwAl2cVcyPmIShBXfgqEn1brRbi67+2
         nZrs9KbmbXjn6NsyYm+TSXsbhnkO8rh8S1SJQVWdAo6GiPl2PgGJn4QGpab3aUVZO/nt
         Nhz+//V47XEc3d5ATpTmPm07CQaBW7hOoCiCfDCbbiaXFV+PphSjZJzBX8TIJime8rmt
         r56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536142; x=1767140942;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bMAS5pTBRt+D+YQ3hZNF0StDlF0aWH+C/CFg55tOZdw=;
        b=k+/NTghbSY+K7SxJQVLd2j7wJhg0p/Ri5mYX30EYrvbuSNc83qIcFTWbPm72B5DfGV
         5xrKE9YUpvXKyCb5PbsVfDt7FSKwe5pRDa9jAkrtXNyeNhtPpjUMpUWCstcnjIe06+XI
         SsrN0cthYRyyAf9vwTSJHb6bL9+fLnVUX8yg7H4PBwxsVzJRTkp+AWz4dSm+zCkGUilM
         vLn9gmnOG1byqV3G18EQZuK9g6z6tjMrWJBNmB9zL8XpEalRWiiMujeMYufnEwzkkpW8
         PD1K0OkJMHFLq+/XH1SBjMSQu0RZvOrn6frbpjSHYGO59Q3SrBSrhgEo9AChlk/mn464
         xCFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd8VtX39VMJHz398i4i9IZm6xtWCogsJC2194QTrOjwLkbANWta8AMTAd71l6MtwB1wHWl1oqUbJxLN1OKBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxlO1fZBXd6Rf1KssWJRNxemDRw/IY17mRecUTSmKg3PwVsRvBK
	Ca9VDbx8cLFQUvW7H1w5+nrv5JLO6ocpvA/plbAc2/XMd1jH0QUTU0ID
X-Gm-Gg: AY/fxX50s6qTfvEDDUnPGvFMOz5WG/iqYFe9bzYZQGmKrIkbaLhckbpu0TbfH++2BWg
	ur9GOeoTjdgRU0+rDis/397foZ7XUlJj1tow00oZhfGcuSy/1DVnXv33c218vgnZUWgF+NEV2uG
	KyKaKnOqd4D48+Pl0yoRnCDxWHSQ2+ZkO23Ps90gCgCEqYwkR8+t9YC3QxXwOanXR0IojcDrYIS
	j/7ZdSG3LUWsYvGj8XA3AexOatMQEQJP2J0HtX6rNbar3Fk2u2I/omgdpXI95XflQMWuOaGXZiJ
	m5IF5170Ip0u1bkj37cm1sDHk/N3DaTZ2C/rDUNQ3qcmC44P0TYXqFaZbYKssjg1JWyxeBATN80
	qFulD0P0+fW16m9QX8Im0S+US5yfNaT2v7Wi52E4UK21XrQn7aPVhaUlHNO2CHHlup1WYPjkmVw
	UbJbGS/OXggqXOCWs4X1eX
X-Google-Smtp-Source: AGHT+IGk5LVdk+TERc/fw8l5nIc94qgaWAolimWSUPj2FUxbokwJ6dSPaiM4BcignHXWPYwD+sNmTw==
X-Received: by 2002:a17:903:b8b:b0:297:df4e:fdd5 with SMTP id d9443c01a7336-2a2f2327264mr159417125ad.23.1766536141803;
        Tue, 23 Dec 2025 16:29:01 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c828dbsm135979755ad.22.2025.12.23.16.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:29:01 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 23 Dec 2025 16:28:40 -0800
Subject: [PATCH RFC net-next v13 06/13] selftests/vsock: add namespace
 helpers to vmtest.sh
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-vsock-vmtest-v13-6-9d6db8e7c80b@meta.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
In-Reply-To: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
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

