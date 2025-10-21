Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8477F2ECD1A
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 23:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090438; cv=none; b=Ie6NfrxAoMRf9dMnk/iXISI7JyVHHI6EAsZ4k/rV7j8XbziIziEy8gwLJvx0myiXcaFSwtQU+Munv+GkkuRoOYzJh8yafSkhpaxJ1yshprKfQdkPN3jirGnSv7Qp30iAhULRVVGb7BiBYINUgopFpbCYxSv1rlnaxqZ34ej49e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090438; c=relaxed/simple;
	bh=cSAsRDqBVRjV5+J5lLGOrcD4Yn/sBflKtNCYHEuiaRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lPRuAkrXhMkntopCC7tUVs/4SDD3U6St/B7h9hRRrM+P85dxOR2YQZoainflQ/MXwJdwxeF/K6T/TaMg5tGXjNRiMnw4AwqBg6rLSHkTk3jSy0iyPwXuPj2dG47Wc5nIMuib8gs7N/3j1s9ATGugDTDL0GOjesySoJOrIl/wlvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuGuqG8d; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuGuqG8d"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b5507d3ccd8so5101130a12.0
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 16:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090432; x=1761695232; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERN+jbjLqe2GDwDaLELjNRkAEJw/pLWXwhebqrcXkEc=;
        b=EuGuqG8dEjFN87c6t7ueA4XXCcm/cnfylIJnDvBrOGsalLT8Z0RzhaYyCBVsYclc2K
         uKbM0OH03wjVTxIDMrf27GLnHMUWoPzeX2Dk4oCXuN4AXaQKVjFJJxRHGEpQZVrfEWOs
         ylLfBQgr/ERcZZ8LOQvjB8HbQ1IS4zDAqwkPRWky7bubaAVlgRQYgwIdJkPJZEZboX3+
         oC+T4CqBbmPCUMRdhkpRr7J3m1nmOxBF110A5koOLmWBu5QVxNA6d03+bivXXbv9rXsa
         Jf5v2im0sCcqN0GC2bwIo6a6GyrY0gtKJ4rWyGP4OVqjmUm1YapYFyEJREIkNw0XJjtP
         GZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090432; x=1761695232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERN+jbjLqe2GDwDaLELjNRkAEJw/pLWXwhebqrcXkEc=;
        b=Mh4zcnH+tGfgEivz+kecKL5ezSkzkSVDuRuNt8MUYXMVi/nZk6nPFKNTlX5z0pb5/Z
         1UT5scS8D5oTA2EBQeP8uSvhH9lykZC7BwqXFbC7E76KMg9hMK0wlKSbljM2aVCu/f0o
         9bWEtcMGW0nadiSTqWA5Wzjoy/XkzoMYPNzEXg93974k5KPLV1Lw7sRg/A/+dnEQ7X0z
         pAc4qhbkDlm6+SzFuwx/yHkvLvjpTBCGurCIFiMdwrdnCSRXBlYX4DbnuKwWp3hag0cN
         P8gElOamb5mLOWzVe03MIL1HXz0dYzohTmVod1ei0d8pk3jwRXsb1Ew5QyOU6K8+Ggcs
         tjUQ==
X-Gm-Message-State: AOJu0Yy2RcBVqxBpTeh+gJOTUbuy7OwXquam5/iQLpAIKsX/LafMDPA+
	+EKwJlIOfoSDudmdf0zKZbdxJ4p7/h97DmcUQ2svF/yDp+/dwgXz3HcoL67cK265
X-Gm-Gg: ASbGncu05T60RPNHXYX84yrHgyJgsUlGHRwVrj3aGSah5pFu/BwqOPxTIdAxY3K7Pzg
	CqniMH/VnNb3MWPgzd9o1/FIivuz+yanKx6KOtqWTKMLnMwmGOeBiG9cY4MxQkoQaHONT1D4LIq
	aaXy527bcxZNMffiPTVZr5YCCQBp6c/AXQak9GMEPA55W6hU+iOqPnOF1QKKPNL7aq0xW3a8st1
	A/fc/cf1eqei6rZ3EaZHtaxOtr5CXeIrqNaujeXxdMcPpEZSuPdBeh2Wzr+Prv3zdDdl9cOaK7B
	HTV9HA0extfibSwHlIk0MKXK6RW3on16psAH+aePX602SC/uGxYZoLqfjh12b9YfN8dSU3eFuH8
	/M0NqC/9VMrFN4JBmi2GTmS3B+ApMFd0L/o3Wxl7u8hGZhOv1N6Fr3hx/U4OE2ooITiMmfLN2AM
	RWhbm7HmUP7ErgknlQSg==
X-Google-Smtp-Source: AGHT+IFGmvrlTRJrVB5IZHQoRBZsqDSzVsYhhC0KT8URosDDz4O0ZlQ6n+lydCzN5y/3yUEEnGsBVg==
X-Received: by 2002:a17:902:cf0b:b0:24c:cb60:f6f0 with SMTP id d9443c01a7336-290cb66025amr253714265ad.58.1761090432218;
        Tue, 21 Oct 2025 16:47:12 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fcc2e0sm120841465ad.34.2025.10.21.16.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:11 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:57 -0700
Subject: [PATCH net-next v7 14/26] selftests/vsock: add check_result() for
 pass/fail counting
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-14-0661b7b6f081@meta.com>
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

Add check_result() function to reuse logic for incrementing the
pass/fail counters. This function will get used by different callers as
we add different types of tests in future patches (namely, namespace and
non-namespace tests will be called at different places, and re-use this
function).

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 020796e1c31a..5368ec7b1895 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -78,6 +78,26 @@ die() {
 	exit "${KSFT_FAIL}"
 }
 
+check_result() {
+	local rc num
+
+	rc=$1
+	num=$(( cnt_total + 1 ))
+
+	if [[ ${rc} -eq $KSFT_PASS ]]; then
+		cnt_pass=$(( cnt_pass + 1 ))
+		echo "ok ${num} ${arg}"
+	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
+		cnt_skip=$(( cnt_skip + 1 ))
+		echo "ok ${num} ${arg} # SKIP"
+	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
+		cnt_fail=$(( cnt_fail + 1 ))
+		echo "not ok ${num} ${arg} # exit=$rc"
+	fi
+
+	cnt_total=$(( cnt_total + 1 ))
+}
+
 vm_ssh() {
 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
 	return $?
@@ -523,17 +543,7 @@ cnt_total=0
 for arg in "${ARGS[@]}"; do
 	run_test "${arg}"
 	rc=$?
-	if [[ ${rc} -eq $KSFT_PASS ]]; then
-		cnt_pass=$(( cnt_pass + 1 ))
-		echo "ok ${cnt_total} ${arg}"
-	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
-		cnt_skip=$(( cnt_skip + 1 ))
-		echo "ok ${cnt_total} ${arg} # SKIP"
-	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
-		cnt_fail=$(( cnt_fail + 1 ))
-		echo "not ok ${cnt_total} ${arg} # exit=$rc"
-	fi
-	cnt_total=$(( cnt_total + 1 ))
+	check_result ${rc}
 done
 
 terminate_pidfiles "${pidfile}"

-- 
2.47.3

