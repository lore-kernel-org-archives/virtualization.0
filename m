Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8726432548D
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 07:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229676; cv=none; b=aOIY/v3/KkFtbsq57IKiv8P20sfmWHOc8k6/LeNnWmoHeXaQL3VEM29l0lPWL1Yj3sKsqxqj+f41CqYdZjXFgrsJVGQKJbX+cH3lIQ8+8q3YHRbboDD0QeaB058oiV6VOerj9jmGsFCa8ImYcoCS4FhWJgrxoPJGhvwbt7YMT3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229676; c=relaxed/simple;
	bh=czzpcNHjlEeOECy7L6VEuIsFXHYOopcrm3f9fwHEjh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GPSusA+/b5v57RKZF/f3Dqz1HypTC0hNfnhcV+9Avc7oXwQFHDssDG+XdId/l892Pd6ri2SfrLGRC/1CAGU6c6Au7IRZp6owWmlUQDX/J7KC7A4P8XvHGNlT7W04XuMKoBta6gdt/QoK+h0YEat+SGfBiNZ+Jt2SfJ1ROXT8wV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJ+zY+Lr; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJ+zY+Lr"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso893878b3a.1
        for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 23:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764229670; x=1764834470; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQ4JZaUoTsMQYrL+kuRb36qxz+zHEzB26FSI/H3YBMA=;
        b=AJ+zY+LrPqZby4VTob1drq7OuJJt8KR+J90twjIA3yiFe+Wa0Cokrdzhs+UoDSz+/Z
         jnWo8qm2snWQlTrGZa67quXOSZXYQ042fLtIgAkevxoAbXHVMRApjsCdXcK4ekXDdEw6
         u12/Q7vmvmkUhQC+Vn8jfehmJuQSIyGA8Kb+8bjaWDeUupLuWHIt40G6htkSQjjnJMvf
         eCeWHWiJubxEYlVCYOEWy28dk91SRyGQfvTG+yJI/JvR2qk0S9h4ZJsZPZ89Hl1sHjEN
         82lEQ1pr+xXS0JEIIrvYezil3K4cSMPUP+OSB/5uyQDQRq/csPMm+Bi/TWoXa3MSD4qD
         gZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764229670; x=1764834470;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NQ4JZaUoTsMQYrL+kuRb36qxz+zHEzB26FSI/H3YBMA=;
        b=QoQ4UqFyXUvdf6WRGhM3LoJasmFUh+Ou3eeTD8pxgKRCUB2R9HMZv1TA4rc/eMIiZv
         Tp2OlnFbvwCdYSdYfl7uH+Wd7KC/bFLgiK9vXppP0gGFEUWDtFbJlQQ3PWJuLRKrb4aF
         Yi+aYkh1ByXPWoXYAhZF1zcNYY4ndS9qnCLgMNPFYJdy1aawKLfTQI3zBiUgd4QNvzuP
         va2CSVQU/X4CAdAnKRHdrCUJFrvbHwnnZ5x5ex/DY7lra9Nlrf9wJIx7s3RQStArwn2R
         esaQa7DC2s73SifBlZMoaVP05WkwKJ/raaOQs5B8WvXe78D1xQAEiLoTh6hwA11SdB8L
         hHiw==
X-Forwarded-Encrypted: i=1; AJvYcCVAtCy6/6IKhT8qxyA7DkquXhpDT7mS9jEQqeobaVVx0VTnYuWk/jkDBYLIYpcdvH7ZGROeA/sa/mn/j7SyZA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4ByEwo59g1+weqFf8CEW5omzPpH3a1xWuPVztjHtpo6ex8QGe
	HWFYp7P6GCWPS/U2ycUjm72wt/C9OeNTZ7eOUK2F/Ldujm6matp1duw/
X-Gm-Gg: ASbGnct6iy7tbStN4sKUBcrE0N3bH7xWEwwtVN2MoHzbDLDZPbPU0ykchxkgsgx54K4
	rXkLJNowDIfxFfxjM9y6Lma38h+c6by89Oo7BT7uETMfXZ3gEclJtJekL/MSyf0XysWcRdNmXKS
	Bwtzd+IWWDNcFPTAwfpn4xINgy/UUi3ju65jjod7oRRIaVAInFk0OvR6bUb7GGYWxO24pHnpKlX
	SW8ZeMrai1FmlpVv1Tl4HP5k1uaDFbSQM65p/w4vyjJLWN4W1uPelJm1dVNYpIni8QalEgr1pvb
	G4h30A627bkd/YE40qZ7EaI9kaCEsObvpVFPEFR1rZLnxwdI92WIKiRyWttkV+h6t+hVFzGfDLN
	V93S78M4ZZzSmb1+sTJ31NfbgfzXUoVgyPptxVw4YK8y94S6eiOiIuTApHBDNiLoWnI4v3R3bfH
	bd3OGDtuf5Ndui/+aiAmyN
X-Google-Smtp-Source: AGHT+IG/QkipgDC5/9P1526ujkoBXHGm/apxd0sZKMmlL+0mQ3lVcIPyxsJBx47IADm7h5JzGsdVRA==
X-Received: by 2002:a05:6a00:2d0c:b0:7af:19bc:ca71 with SMTP id d2e1a72fcca58-7ca8975f7c1mr11555824b3a.19.1764229669761;
        Wed, 26 Nov 2025 23:47:49 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e6e6df9sm918997b3a.39.2025.11.26.23.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 23:47:49 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 26 Nov 2025 23:47:36 -0800
Subject: [PATCH net-next v12 07/12] selftests/vsock: add
 vm_dmesg_{warn,oops}_count() helpers
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-vsock-vmtest-v12-7-257ee21cd5de@meta.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
In-Reply-To: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
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
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
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
index 4da91828a6a0..1623e4da15e2 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -389,6 +389,17 @@ host_wait_for_listener() {
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
@@ -596,8 +607,8 @@ run_shared_vm_test() {
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
 	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
-	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_oops_cnt_before=$(vm_dmesg_oops_count "init_ns")
+	vm_warn_cnt_before=$(vm_dmesg_warn_count "init_ns")
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -615,13 +626,13 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
+	vm_oops_cnt_after=$(vm_dmesg_oops_count "init_ns")
 	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
 		echo "FAIL: kernel oops detected on vm" | log_host
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_warn_cnt_after=$(vm_dmesg_warn_count "init_ns")
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host
 		rc=$KSFT_FAIL

-- 
2.47.3

