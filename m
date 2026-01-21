Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465FE43D50E
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033531; cv=none; b=uL32Ir4lTuZNV0iDOPFQHR4NbncEtA0y/8XLH3BKQ4SkXIEG/6KmM9sbLLq83lPt8+gFUMbd1zzLY+z8hLUti2DNDGlDDUEeiw/Q3YvybhmSYmPJdd0Md9yjH/dHGO8M+jWVD4x+CyClXpVzk6iKZ4wYdQCLxq++KX0VnOdByVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033531; c=relaxed/simple;
	bh=Uqeotcna4sKhnpsKpqu9ZIU7Rje31wAi6t7AlhVdLKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZE+Q876IKkq12SGfSo9WsklI+Nwa6oaSGwvB8W+t+a6CJOGWUI8yPbs8//C3iBX+UVXjSQ6FSm8K8EjrOTfPLL/JHC/E95XWCs9MGJlGYxeEbTS+r2c4KqMWrOury0Cp0G/mVK4v+Bn/Zd01lmGytJj2FAKQPPbgZTp94saVflA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVhRYLAP; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVhRYLAP"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79028cb7f92so3076557b3.2
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 14:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769033525; x=1769638325; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUBBU245D9tnMf9A+ObhwqUmHTyrgT+5VJLzKaof8o4=;
        b=QVhRYLAPLAOk3EHINPg4bbLmp6rBjeCRaotGGvlDyJNkSoAZA0FY51ra30RjC0V5Cg
         Jyc+mimDOltnCBnvcl/pUVWpW8aEjABA7kJBkv74ZDVOw90l6+79KMRbjX+vuuWzEL28
         xV1tUacsBBdUQpNrNdPrzrghSZfWEUL4urX6U1omtka3H18e0VXi9JDj3HVTq65RlmjY
         EzIzRwRR5HqONtVF/tT5tgt3drA2P3E7vgLb9fnQz8G/kGEWe3W9rgj1WUYI8G3nHn/s
         3krWpfgR9LYjFQ4uLWfb4KaocAfnggraVMbk7aBdLEuHMGvmN6MJlC38LK64bw+HKxSm
         XCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769033525; x=1769638325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dUBBU245D9tnMf9A+ObhwqUmHTyrgT+5VJLzKaof8o4=;
        b=j+OJ8DuxgPhewLa781/ov+SnxPPdj1Zz6DIxzj0BB/dCTjN03m0gnaINbqZ/85RU4O
         U5Bqq6lOubNEF0mocX7s197IbHMLGb2+DtAQX73S7n+cyihYpII65JMhFBQHqk75NPeO
         fviRk4cF5lnO2uqb3GY6ORfWNbtOKrqNN+hJ4PArqfK4pXGOQfwS1u6XGWEJG+D3USgg
         TBh8ZkrrbK56kjWd6jajEAfbM28dQ856T2pRs2yOrv0WnU0Is0YnrPcXBDEgs3oaGOQJ
         c/Ad07lQRzWES9REdVkocZSEucyAHZOTRunM68iXEPkX5OWJ/6rXxU/T2X8r38UAqExq
         Oy/w==
X-Forwarded-Encrypted: i=1; AJvYcCVcNVi5cMbE7/JIUXlDR9O7PW0GjnzxDws9gB2VLHIrlU9UI2jRSp3adEsG7GaR2KAAUrFRd8jltdANguYgrA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwuQiwLDRPmd6DNJzlItTE2YrEqErGe3Ojvkdp8zmTTwdJW8yYV
	M2gPT36TshpniMRojO+ehriLlXnIlrxh3tWXu3SNhqcDSR/7C8A07Wfz
X-Gm-Gg: AZuq6aKPWD0BsF9vHgImDIAz9DG0pGmepEU7iHGU7QrT2cCXI9oe8xLyJkP6btK3/6Q
	kHVH5BqgZvPZWZf00zOq+OEJ2prvkH3mmdyrHiFtKPBVW+OlogdW612RWNa3fVDzpMhBSWJJD9y
	bl7raHWkQehY2u5Mad0Y4d2EkhuL3DzHlht5QHvBBQveG4UzLwU6SQAPCCIY2XGxBDl6Sp6RL2+
	Fgqoxg8c5a3/uc+FnQ/BO1QzEcWvMgsH+q+ss876Vhl68Rnmgvqiq7+Wa473cHvtusRWU0BNEOt
	oViZyoMYywX504fmljypaNoOtw4oNAQjMJilupJyHUfijjEjROY2SZMu3yD0iLOPc9SUKkZ0Ahu
	kpup2CZHXKQVG8TRNvBXShstJ8Zs3h7xYW4lM7dAyL6n7b5d8eEE0ILMKVUbdS5HQYE46yQr0fe
	W3drUdxvLZUTYqqkVKR/XI
X-Received: by 2002:a05:690c:d1b:b0:786:6179:1a47 with SMTP id 00721157ae682-793c6803c15mr130911767b3.44.1769033525375;
        Wed, 21 Jan 2026 14:12:05 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:50::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66c729fsm71255977b3.12.2026.01.21.14.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:12:04 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 21 Jan 2026 14:11:47 -0800
Subject: [PATCH net-next v16 07/12] selftests/vsock: add
 vm_dmesg_{warn,oops}_count() helpers
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-vsock-vmtest-v16-7-2859a7512097@meta.com>
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

These functions are reused by the VM tests to collect and compare dmesg
warnings and oops counts. The future VM-specific tests use them heavily.
This patches relies on vm_ssh() already supporting namespaces.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v11:
- break these out into an earlier patch so that they can be used
  directly in new patches (instead of causing churn by adding this
  later)
---
 tools/testing/selftests/vsock/vmtest.sh | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index c4d73dd0a4cf..4b5929ffc9eb 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -380,6 +380,17 @@ host_wait_for_listener() {
 	fi
 }
 
+vm_dmesg_oops_count() {
+	local ns=$1
+
+	vm_ssh "${ns}" -- dmesg 2>/dev/null | grep -c -i 'Oops'
+}
+
+vm_dmesg_warn_count() {
+	local ns=$1
+
+	vm_ssh "${ns}" -- dmesg --level=warn 2>/dev/null | grep -c -i 'vsock'
+}
 
 vm_vsock_test() {
 	local ns=$1
@@ -587,8 +598,8 @@ run_shared_vm_test() {
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
 	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
-	vm_oops_cnt_before=$(vm_ssh "init_ns" -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh "init_ns" -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_oops_cnt_before=$(vm_dmesg_oops_count "init_ns")
+	vm_warn_cnt_before=$(vm_dmesg_warn_count "init_ns")
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -606,13 +617,13 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_oops_cnt_after=$(vm_ssh "init_ns" -- dmesg | grep -i 'Oops' | wc -l)
+	vm_oops_cnt_after=$(vm_dmesg_oops_count "init_ns")
 	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
 		echo "FAIL: kernel oops detected on vm" | log_host
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh "init_ns" -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_warn_cnt_after=$(vm_dmesg_warn_count "init_ns")
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host
 		rc=$KSFT_FAIL

-- 
2.47.3

