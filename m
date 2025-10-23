Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A8F22257E
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181233; cv=none; b=kJiexEVU7mkeuXZIlHOFh+CK2O7nn7jvrchpxtqbL7B20IquwU/Rxszfcszil1UwpuMnt/4r05IpeFtXPFz10bp00fwaM2zpUL1+FQS6p3gsxFfVV3Sca7hsCxyQo0diaeGygLATFqBvE3shX22Bt5tMOpe0800bnhhBjtnk7CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181233; c=relaxed/simple;
	bh=53S5Zx5/+dq3CxymSoKg3PxckRbS+/iJdEXFwbACpeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AGnmtAdycHqmpoZkAATBtf12ZUqp04FMpafXOzg9v7NK1gjNR03hu5GNuhLU/KygAVdcocQNJTjjRxVWl6wmvPfI3Z9rBc3g6kb5RKL0CY70cuTLn8VGBqovVjLQKcVgWbDAzV6jyTbTMYgWekmOv2Xg2lYa7N/uprP0C8UF0eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0fsaAs4; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0fsaAs4"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a265a02477so176306b3a.2
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 18:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181230; x=1761786030; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6hhytdydN3st1fvO6O+FLwguIsO7CYdeOMt51FRiMAY=;
        b=j0fsaAs40IGpd0B0VT32Gl7x5vdVTzpTnPfcE1xFKtjQ9lAXXVo87zV3mrIdklgBCg
         kCRKB3TIV4+vX6GZ5HwL3S1mJn/+uKKjC0RbMnRmz13/yhs9h+oqbTu+FCpIzAs45mov
         QD5hm1sV6jUSoTMsyGc2JOLRSGiEwyxmDaNTPgAbY6pvr29r8r0gdfuAvg/FX3yFvkgE
         LkLhimtfq9sYBZo0LgHI7WTxclkeOdQPsz4y3dXDIVVf9seMGHP677F91aReNLgC2+HT
         oVvY5pUK0o5oxQLstbohlCfOssAYNyToBgbO41xRCPFltBAEJAalS3AiXdtKwguPnKKX
         zayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181230; x=1761786030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hhytdydN3st1fvO6O+FLwguIsO7CYdeOMt51FRiMAY=;
        b=KIBjWby/2wfKxGyC0LVMICWjdorwN4SfhRanCDsW1lN/IrVonsJ6ptRhf+THxBAQKB
         YJ7rOwSGPZeuSmzG3KWJQ08Dnez1UE+ieK2erCcV1WUetURAxiZW58NHeTHf8/wHJh2a
         ifecoluAGbS2YJ6UxBVIxBp87WI7cetodjc81YQYw4ykTGr8P5uwBRMB/i+Gn7O5iQwl
         otjzd8OOCGm+wfiaT/lpkZ1eFYAVfgRx1/tRXr/Nvc/yEJFXSRGiMmrkOBohE/T5UD4/
         ajFMGT26W7rUv/ZyZyoOgGpal44SFfPkfvScEs9Mvpy6ohpHuaWLlsx6iDuEfDgcI2f3
         WIPw==
X-Gm-Message-State: AOJu0Ywtwa+6B/0AGvoPMwZFg4vstILwZZHIaEq0hBjxIIZptheAqOHL
	9c9nVS6g4Z28BqDDbLaaUY5J8GgdxiyZZ1ne1/xLsv7H92F1gGQlnduuDzRc9Vza
X-Gm-Gg: ASbGncvayS9o0rk5Y/JOyOnvKRTc+n4gH4FTZTkeDim6lFsBL4IQKMhi08xN2Wiv1L/
	9tkZqi+FmIqz6hwyeXQf5vKdvELZ0pHjbFr6mihX2a2vmlR3OziCusrOtneixpBqpLyrzwUow+0
	0McWXludM2tct5wpZLLiH8Da99Uyxi+XCsj+DznTyewpyOnQ73wbLJ7rQYIkdQnKx1bQoVpnu+x
	NwL7ese3yQfym78AR2mMNrmnmxdEKMOb5wEhfjjcho7nxRWjfR9p69FriFQO6/GboI52le6WYhZ
	Pu7dBEe9ttkRDe5Q1iHsNnQAcLHyKDc5xkQEdZNXXrGYKuY1pfm05sOGROL6+Ra0uZFQb0mP1vT
	7ERsTkxhGUPm6zDABMWRe76G7jneYKVzs6TnjoADLhMIuk9l3c9KUffNzyKwfTxlFwgCLp0HjuL
	cXdwiGJgb+
X-Google-Smtp-Source: AGHT+IEOLFrEwrP2Rf2uPvi/YyHr9hHzHgOPOlWS5DL5z4avx5Oje0geKjvDdLHF1RWLtx4Gg/89VA==
X-Received: by 2002:a05:6a00:4fc9:b0:7a2:7458:7fc8 with SMTP id d2e1a72fcca58-7a2745880c9mr1173130b3a.13.1761181230338;
        Wed, 22 Oct 2025 18:00:30 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274b8a0edsm560059b3a.35.2025.10.22.18.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:30 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:10 -0700
Subject: [PATCH net-next 06/12] selftests/vsock: speed up tests by reducing
 the QEMU pidfile timeout
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-6-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Reduce the time waiting for the QEMU pidfile from three minutes to five
seconds. The three minute time window was chosen to make sure QEMU had
enough time to fully boot up. This, however, is an unreasonably long
delay for QEMU to write the pidfile, which happens earlier when the QEMU
process starts (not after VM boot). The three minute delay becomes
noticeably wasteful in future tests that expect QEMU to fail and wait a
full three minutes for a pidfile that will never exist.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 6c8f199b771b..99db2e415253 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -22,7 +22,7 @@ readonly SSH_HOST_PORT=2222
 readonly VSOCK_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
-readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
+readonly WAIT_QEMU=5
 readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
 
 # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
@@ -221,7 +221,7 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	timeout "${WAIT_TOTAL}" \
+	timeout "${WAIT_QEMU}" \
 		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 

-- 
2.47.3

