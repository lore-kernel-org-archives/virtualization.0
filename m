Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B93313E05
	for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 03:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273984; cv=none; b=FZFBpZ0f4YNTfG53IaV+dUltiLPRWlXKaJAZ8+3/lL/U9GCfSkDOiIyJQRVrxNfyLgcwYRUIgw7Wse14ZOLew/B4vVcFauPx2y52Rl//ohNHrI5NlR2zhDZNU8QQPX6JE4zebYDRdYLc7TWroKA8BmGI1/0qj1NB7W9sfllyKTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273984; c=relaxed/simple;
	bh=A/Re4uBOGGe0FAXjhpo7AUAS6ISO6mznmR48rNydg0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rdk4I0dnK0iuMRUyZXHutSqYE1dDfpDwEiZZJ2Hu6STdqUgPBNhHes7DhEStU38CK+SM90+IXCVvvR+Yimrm9Bnm9U6nuAv/SEePRgtCAXLzM8iJoUxVnSBW+GmJ239alpnc8ivKLxdgAKY7CnwBTyLw5xl1grcuKgQW9g8btNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uk8TrIAY; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk8TrIAY"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6446c2bbfe3so6144448d50.1
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 19:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768273982; x=1768878782; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMAS5pTBRt+D+YQ3hZNF0StDlF0aWH+C/CFg55tOZdw=;
        b=Uk8TrIAYkxjKyY8Jr+HBDc7FOufDUTGg0TeEVpStJwhL3GATgKN7WXb7nYLl4IUL4m
         zeh+yaP9HO+XvJWwx1Oz6j3fHVrFuoyOJpYRRTlUdAYCweKebgh7LEbFVOnf0Aftm5Qs
         1nBXtRXWxRWD7pwEYU2ZoHdMFgTctqXRmIQ6uLkjq8n/10R/QxiNJ3aiEtbAYSg1SMqz
         VBzk49AyxRUBKPQWFiF+o+I4MoMfI+U7c3XVOZoHGJHFD/7c4Ex7R1OmboY7F46DnAXw
         X87NV5lEquyEcb6jiAI+lhdmO76p9TV8xNNeihLwsbXBe7ffEfyFUbTthfL6WjqFVtQL
         oMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768273982; x=1768878782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bMAS5pTBRt+D+YQ3hZNF0StDlF0aWH+C/CFg55tOZdw=;
        b=hrJLDG6FTCSRqmabqJELF/+ocPI13sgv2PCnGGrIuiUpYKjfswuU7FYW4fA1xozI+m
         +wubpJM4XqD+IO6VCQIcXIK3AVvNmomcC8TA36QcABoPyuby8fhY2JkYRpnt4zbGl1LS
         Ndl4F7ZfAkGUyWGkU/JfsCvudmoWA77MQgE5XeHk/v3lIqAe/7KpkuA7dAZiYjc4R4Lk
         +9Mm77xklS1R046GZojsUJeClXCfxIxRQcp7lJT0YJHMAe39VntgZa87qO6IPfZiHL6h
         C62wAoVk0s0eMbw1CGJcKw+v/GNuDXQ7LqcEPgmMwIfbWdtZHfFVy/Lnm8WCHzOtkIl2
         WXXA==
X-Forwarded-Encrypted: i=1; AJvYcCXE0OXX7SGOxg5p6jIbt/ofpGx9dxA8Tk3QdOc7RItT3lhZFcBWYK1o5pwx06KSoI80bqeF1tCjwEGovcrx3w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3C2j099K8MmQVdPd+8W1c78FoMXr2rloLXMk2wGI+EFiC7hWE
	vdtXTwhKSgVIQQkPMZLXf/2Xh7yv+zki6g0+j89wx+EgULytcVNnfimh
X-Gm-Gg: AY/fxX5eB1nNfDqzIkol+xbVS5NQ0U4mdETQX7kx2SZsQBBeNvo+1dpQt+kF8LnbOPV
	humLKbOk3S3laXV94aJBfmf/A2Ovjyzm4/HK1x6pxmPWJOXObYQDesDM1Fqslmwcwvsg2Mzkbc7
	EegPHz7ZG3s8xZZumUja1meKlIk0RvEQKIKGKZ4fRy4K/6rj0vxeKREyFh1re4OiLfeF6EDwkHt
	Z9lYPkLv3lv4jvyIp9wf+6JlL4Kk7X+mlcFdmqStBK1iBjsOsCKHell3HQQizhZ6wla9hnxC+LE
	iwVjczox6BHukAIIgYg76bz2Fi0cKK/Xrn3oiRiK8rQJmJhlmiHMRYCVt11kVPRmgG/XDWwBqO6
	Z8Eq5D/dqrfL2hr9bOHKy6z8zYgaXEjkJwCmLOmJuteSmYalT6BEPDyUoaatyxLB0iyrH/bZ0J+
	J9aXP4JeepKg==
X-Google-Smtp-Source: AGHT+IGkQoS0QBXW7yISdzqc/XM0pcHr9WRNy/nnkdRa0saRQjs66Xbn3T42Y7YnRdRrb2CT86Wdpw==
X-Received: by 2002:a05:690e:1907:b0:644:795a:391 with SMTP id 956f58d0204a3-64716c67b3bmr15939380d50.60.1768273981699;
        Mon, 12 Jan 2026 19:13:01 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d8b246fsm8746996d50.17.2026.01.12.19.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:13:01 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 12 Jan 2026 19:11:14 -0800
Subject: [PATCH net-next v14 05/12] selftests/vsock: add namespace helpers
 to vmtest.sh
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-vsock-vmtest-v14-5-a5c332db3e2b@meta.com>
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

