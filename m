Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DD42E7637
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090435; cv=none; b=K0CYCqBmRFlNGG2cl5JAZWrEct8Vz4oVdeY2PKVssjLhDEuWkdV8ZT8ICXmER2HTKS0ffsIuO8WPDjfYNUu8dsB1b3WUFsRfJcrGnIVimrqlPY3qMWQ0WS3GrQRXBAC75xzsu2npa6IN+0l1wjcHScCyE3i7wm/ngYCnUjgSVDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090435; c=relaxed/simple;
	bh=sFmiWiqcfg8xXVngUspNtrgGk8pAsdPv+UUIRplZPLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MabS/1lGowXfYVv0MfhPJ2z15Pl9Bcp4neNJcHTHAghtZ9RWubDVGdVRHYH74yK4dwNknqU1dGQvgeV57ef/2TGfLDQ0N1K+so3qWwB+JCFNwzXxbp1yT3WRK9w3RNhoJQ5/w2BVrAz0QKYc2CFdqs2t8zAKmL7BsPW2nq18HvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkN20F6r; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkN20F6r"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-793021f348fso5548288b3a.1
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 16:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090430; x=1761695230; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Lx0Vsy3+YgWmRX9GABJkmBtAr8R5JRasWccNZRzMeM=;
        b=hkN20F6rTIDjQCtBByUbCq0utITpevkc712JgC0oVCTVaHQxCMBY7pxlilnnould1R
         IJzdhZHx4Y9tGUbV7+iLUYAQ923fM2apNnguQPZHKNBcx60HT4q0obaYsdBKgAtuCpWG
         jbouj5az9zVWTGdyU7mvHVAflsOc/ryZ7uIvu0SSyLsuCWSHM4Jp4F4qPnCjCC/BpHnh
         6ydxjInMVs4lH7oxCn6EIzKYISQkcWAOVPs0I7/NvzFM+MtqUUggoWp6JH0cC1FC3e46
         wAjPOfnP5hBmB5NaWgegQ65/PxzBt73AL3ot2i7Q9ftlP0/XG7d2NhLuxPvKrQIlxbs1
         He6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090430; x=1761695230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Lx0Vsy3+YgWmRX9GABJkmBtAr8R5JRasWccNZRzMeM=;
        b=adI5ywMicJUlghkNyaIGrqWqckWSWbMEPRfKkiK0PCtY+Cxe4FlyQKPqJYTPiFD3EW
         PHfRpnfwvUR+X8OfyCc/yCXJYs0A56ryc6y4PvHVryKJrDz8yRIxfYHYGjjv5uZVFVkV
         RidxOnJ/E1PadP1anCpUWfn8vAr4hlyzCHWqJHIsTT++K9/+VCD8PXC9lVmZOAx6f/uQ
         zPTipVDLGwhTXfBKmm3OlS9bn9VYmPyGLrRjI8dWhsj0/72AOFe8YaR4unEMhvaRJC4t
         0VdFf2yZW6tLNgfXTdtVm5EMWHUcj+pUnGZrimJ8FkdfR5oTbq3bw9LEjVEHRvonw8FW
         ZGgQ==
X-Gm-Message-State: AOJu0Ywlt/3lBp6i8bE2CqTfInpb2J1HTljhu50msXkIO/QCCd8576eX
	0KePVxEe5vhHUNDtPFvfZgwYFbT3BmgB7heR7Xw6JHWoAJST5VviXB3q
X-Gm-Gg: ASbGnctVAB+xRBcNh42Dq6nA4QN8jKEiwwWp331oYsEl3GWJ11wiVKrTkv0oHsQZec8
	xRcqdut/ivnSVyl84IuCyAQzElxcKmjr/zUn3lcckrG/usAtCIjQnvwvzsvTmUU5+GVe/ZGtiw8
	og2ZTnshxzhugrB+N80v2VxiI0WWHK/MJaLJJTQUVMIETo6pGywUybm7ykAEpqoIQojqoYORvhi
	qnM4oPCsq39/ks0dL93CIvZyDgw6m+Qqb5aqKjNtHKv1w1/tnluq9UNFTHhI3OHrQ5J+vHe/fv9
	VQTt/OJaie6Nr88QvBX3CtkDa0a7N1x6nADOV2iNCoegtgQQOjxTrK2z9KfNdJxD+zsX4j5CBa7
	oYvQVgSKvKRuYyAX0CfpdalXWwrFAplA2bq5s8/XpIwtzgIEM6gtEMqRep5m37pgCKUx4+QDa/1
	9UGuFDueXP/wOrOZ9o11U=
X-Google-Smtp-Source: AGHT+IHBIC1WFg0H2qiLSSMrqYIuCevWaKcWLpJLUcG8eiGjix0DgQfBr2qDeIJoI8W1LO6p9Cikzw==
X-Received: by 2002:a05:6a00:130e:b0:77e:8130:fda with SMTP id d2e1a72fcca58-7a220aa090dmr21331246b3a.13.1761090430385;
        Tue, 21 Oct 2025 16:47:10 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff1599dsm12619953b3a.4.2025.10.21.16.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:10 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:55 -0700
Subject: [PATCH net-next v7 12/26] selftests/vsock: do not unconditionally
 die if qemu fails
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-12-0661b7b6f081@meta.com>
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

If QEMU fails to boot, then set the returncode (via timeout) instead of
unconditionally dying. This is in preparation for tests that expect QEMU
to fail to boot. In that case, we just want to know if the boot failed
or not so we can test the pass/fail criteria, and continue executing the
next test.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 9958b3250520..d53dd25f5b48 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -221,10 +221,8 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	if ! timeout ${WAIT_TOTAL} \
-		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'; then
-		die "failed to boot VM"
-	fi
+	timeout "${WAIT_TOTAL}" \
+		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 
 vm_wait_for_ssh() {

-- 
2.47.3

