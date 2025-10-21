Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD112F260B
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 23:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090450; cv=none; b=T5vnSt5Qp67Nv5P6Gyih5XSbcO6SZoLoWEu3oZqUuR9fnJwxnSsykplB88UlrXJ/VCaJpcn3ZVa5/eJMbjLlsKbycqwHI1eqNrI838SifWKd3B/kiJrKD2SNhX5UpIQy/xHWqxn9gUvYTzURu0U5nsl8SdZsXycAQBg3HRyGdt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090450; c=relaxed/simple;
	bh=BMoDKOrhS66bBpIGFuMcrxO7gUW03URrQ8nNkpSPZhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T7I4k51wOLouCf4PQFaJRDauDzeOK27/Q6nQkWnD4b/UBoUSJMVrhiyeMsBbV9E2apQIFyEtWVHheC/2OKW0eUJ0YVAmyY80I1vkVLGGU6dNbIrAU4c/vuAuPfBHOP31lnNnNHgU4eDFWMMTUDPb8ytym3Pj/BjWSABwT/HquIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ijz19+ho; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ijz19+ho"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b55517e74e3so6325402a12.2
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 16:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090443; x=1761695243; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCa9hiumthv+bRPHMdag7ntkQWTFgKpIIbTw+AdtIpU=;
        b=Ijz19+howyAwFoOQmZG3b3gHQ+0QVqkNKFAt3y2WZUTZmkd070U5IGFaeka/vY1aJh
         fdSRJ9gGg0FOBZKvLaulv0cITGupFEWTKdbGgShKo7zyUeM7skicpYTfCev1dk7NoYi7
         kxHN9UTU+o43DDzm6wfFSCz8hn6McgNK0Ir3tD06T7U0N4vKvsdIRcW55DATP0FOt3+N
         KdXcwIyTwPiN8MifnVWLKkuGEjK1k51U2d7K7EM3Ui3b1r4eiWcKf8vEHFQWc/I6k3bf
         tjl8DpqVtVT1OqbKV4zhW0sNo6v2zp6X2YvNJvNiyspUsS5Rqz+akqyxhyHPKqox8oUL
         Zy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090443; x=1761695243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCa9hiumthv+bRPHMdag7ntkQWTFgKpIIbTw+AdtIpU=;
        b=MpNyxCL+xBOcSejdzzpxO24KTol7RZTjmD67i+6WvfUz1z+cJz2VHD0o7i9XdtqSla
         a0gVTKLlMF9MCAMZ7+EIM5d0Br514YLX0aTrlU5bb1e186JpQmvsz+y7QpiP37doSsxF
         kHnNfte9isDKHZi/5FAXXcYBnU5zDEkWir0bgCA3m8Ao7BLElGEgdRfYXP0T+HpqPBk3
         Cs1Ys1gGN7u5ulv+cGOJG+FrOLFEV+exx+nU+bgSxC5NlQw0q7zVrVu8MNS9oNzezg0C
         uDsHzns/UokkWnj5mag6X79F+zVOQKzPrfpdTEhwuNMb1PErpWTAXeXUpc1JJVCP54Om
         9ZdA==
X-Gm-Message-State: AOJu0Yz9rgyjGhu45Rk/RDWIPv6KFoU+2qxBhwZJGaM8hK7MHmtJ0+hW
	SUh18U4iV0+rd5F/FTk604n6jbcKS1Wbkoe3UZOZVw/8AaqtDsDuCRRi
X-Gm-Gg: ASbGncvQR9HLC9vhFxym3kcXuXkJ6yXoaCf0XnOHQagu9PHh2LSbt2kjImSojJorNSB
	dYf70DQZls6wisOqN59Cc4SO2rmJzSb5t9ey/EMfSnqhBVg96M7ksGf2S4UqsJoovfaCjC4BO0i
	i8/AZ9CRCdBv0iGqqWjAtiTTA2DPj0l6w0pm78N0bqJ6sJtjzvGjrMLLalsVwrXyfISZq3luyC/
	9mPZ5LiDsQ4SH/FnsHAsUE9rUPwFHXG0Z1tdopRcj1YBHwg7LM8U+c4KtY8u1iS1ABcWdEKwemp
	FpWcH6h+lPaYgxVU2VRWiUXIWxVxrjuQXBcUq3p/VkWCYtIihiQftNnFdCeLST1XB49rnXxzMpZ
	/hCxBXTXYIjltTwBF6H9II9fikgPU8fGNyzbmReVeMybflMFqjxM4HrVuEVDCVQFJeuriZnFu1f
	YEBduECIcO
X-Google-Smtp-Source: AGHT+IGaqRNpMxUjoe2TEEOGYZ81AJdjcRS3PZQjYosVwq9rn7Rp/cmS0OGVE01pd5g/Wml0FTdNXQ==
X-Received: by 2002:a17:903:22c3:b0:293:57e:c8a7 with SMTP id d9443c01a7336-293057eca74mr3060095ad.23.1761090443407;
        Tue, 21 Oct 2025 16:47:23 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d598asm120489125ad.63.2025.10.21.16.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:23 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:09 -0700
Subject: [PATCH net-next v7 26/26] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-26-0661b7b6f081@meta.com>
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

Testing with 1.37 shows all tests passing:

warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
	The following versions have been tested: 1.33 1.36
1..30
ok 1 vm_server_host_client
ok 2 vm_client_host_server
ok 3 vm_loopback
ok 4 ns_host_vsock_ns_mode_ok
ok 5 ns_host_vsock_ns_mode_write_once_ok
ok 6 ns_global_same_cid_fails
ok 7 ns_local_same_cid_ok
ok 8 ns_global_local_same_cid_ok
ok 9 ns_local_global_same_cid_ok
ok 10 ns_diff_global_host_connect_to_global_vm_ok
ok 11 ns_diff_global_host_connect_to_local_vm_fails
ok 12 ns_diff_global_vm_connect_to_global_host_ok
ok 13 ns_diff_global_vm_connect_to_local_host_fails
ok 14 ns_diff_local_host_connect_to_local_vm_fails
ok 15 ns_diff_local_vm_connect_to_local_host_fails
ok 16 ns_diff_global_to_local_loopback_local_fails
ok 17 ns_diff_local_to_global_loopback_fails
ok 18 ns_diff_local_to_local_loopback_fails
ok 19 ns_diff_global_to_global_loopback_ok
ok 20 ns_same_local_loopback_ok
ok 21 ns_same_local_host_connect_to_local_vm_ok
ok 22 ns_same_local_vm_connect_to_local_host_ok
ok 23 ns_mode_change_connection_continue_vm_ok
ok 24 ns_mode_change_connection_continue_host_ok
ok 25 ns_mode_change_connection_continue_both_ok
ok 26 ns_delete_vm_ok
ok 27 ns_delete_host_ok
ok 28 ns_delete_both_ok
ok 29 ns_loopback_global_global_late_module_load_ok
ok 30 ns_loopback_local_local_late_module_load_fails

This patch adds 1.37 to the virtme-ng versions to get rid of the above
warning.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 648ae71bf45a..d73fdea886fb 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -338,7 +338,7 @@ check_vng() {
 	local version
 	local ok
 
-	tested_versions=("1.33" "1.36")
+	tested_versions=("1.33" "1.36" "1.37")
 	version="$(vng --version)"
 
 	ok=0

-- 
2.47.3

