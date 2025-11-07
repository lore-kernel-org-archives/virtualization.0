Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F562F069E
	for <virtualization@lists.linux.dev>; Fri,  7 Nov 2025 00:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476599; cv=none; b=Qy5/PVeBCmtRPpTgZDxtRTMRhJcgV6XzdY0o6Ub6e2c2topxBv+oJZJ/lRFjLZDUx3RsRKsKRNUCe8tAcffGVFLFg7XY4Ql/8UPamn0rJkWjs2AUQX+cOa8y9T2ibk+RqYEMNr4C771uyZ4EVwwWUp4LVbPUdiLrWmUrDXjBgXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476599; c=relaxed/simple;
	bh=4uCVZgM6UeuQx0XSrGdd9WXjIqluMM3jZUftpCJANAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lr6hLRezOUKMoE8Bp5i5n+25nP8xfpdmBx6pSd0NgCZTX2uXPwu36xRtimcxO+Vq46pNPi/qJmfdI9t7KMuPOzP3cT2snFap0uRAK4alwLnJ5xOmvCHlZ0KZs4AxKgSP6KlnieLLrLBg4IYhvT+AjXkfPwqwAw1sBBa2/3vS8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsY/M0u+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsY/M0u+"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27c369f8986so1824255ad.3
        for <virtualization@lists.linux.dev>; Thu, 06 Nov 2025 16:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476596; x=1763081396; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ijXE7xEmBTHmMpA+2gEwbQm6yVHcpL7r2RPNx0k5rU=;
        b=EsY/M0u+mNzm0QXxnlCh/5PiKVq1Xgh+8ZWF+rwXOJo6GdGtWsSFe5pdBLyWVu3LEy
         TxtvSb1CJ3A7Fnka5LmtTBOgA6wep4+ugI4ppj0DjuqBjrR8SiiDAcj5VyVWZovAsQTF
         piHg7FUNk9AKLchx4qloGSNNIqfqe8W5mbprFjVVeGyu458kU+F5N4s8TJrSaYR2fVlL
         AXSSEmUKrFKrPTK9UDaUH3zDHp3bUoSBBf62SxLSudQrE8O1R3menZ/3t8YFJ91KmVoe
         iyYNx2VvpvoxWX5R+3xDzf3tVg6w56CsEPHC0WUPagbPeBumBL7Qg/gE/UX5wROtNngt
         y02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476596; x=1763081396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/ijXE7xEmBTHmMpA+2gEwbQm6yVHcpL7r2RPNx0k5rU=;
        b=qvnWbP1Dl15wG43cGpUCcdT74Hyj92Z7GujogjC7xRPY2L+9ClqFcOb6SZmf3AfqEl
         5Hkq1suN5h1Z4xoVHwk8vNKYLobEY7BbkjgQFy/u8y0uAwpcNcXMm2tA68Dkou88yJZt
         t9UpRJ9jHIKTR1qi1wUU3KT8ehBsxcNc74ZFE1lkfVBRddeyCFjRxN/MP5g4yBgBhM1Y
         Cb/mboXjvV3LyfOtlu+EnmUcao6BfRzI4CBQHednypkZJHIKNmXioQ7bOFoWO6kGT0hl
         f104hfPgXhaEkek07TnKhLZGqvkDRVfNoEOpiusrhft5Jvq6HgaYod/+qWYaIPQLwMxv
         zjTg==
X-Gm-Message-State: AOJu0YzGUUTwAN6R20LTFBl+FzdOGopxyn35Te64d+emKk2mvQ4xosZ4
	CQXptORNzUbKCnLBR8RO3MqTBRpHagQJuD9AJdSma8J4/k9Wdenb8wzT
X-Gm-Gg: ASbGncuuZHrF52MkSioCqzw3sMpbawjW8MxQIWyKdMK/TSVO5rEBFzw4M/cIs18wCPg
	nrLJHdTQ3x6fs6/AWCle+Ma61duCoEFrACJoysuJjPFUyfGZeN+XEWXuR9zYPmYDvHu78JNLoon
	xPo36O8AjEOHUih2WnkjwNBA4h8AxJ1mqkK/I7gmeI4J7JKH+MBvvJP8FchiEx0hPVV1u82YAXA
	6QYFDZQqxKUnibB3mRv7r2Wepb5ZkNXbdikun8gkhLWjQs8pFGxYlccfe/EgP7/Ls0ZCnjPQwgb
	ETVu3ZA6s3KPreIOmuAhxqpaTRZ1aL97ATgXbt0p8eSkXLzQx9pAtUk3UYOqUsv9MlXmGGID2hz
	vs3MGPgV5Smcc17e9sTOCcOFG4xnQANltQxyrmkheLwxCNY/xYyTgZWHzVEvAwMO6XDcPqFfz2g
	==
X-Google-Smtp-Source: AGHT+IGDT33BspNwLZAZGr8rW1mWSoTCi6gvaV3hnBfSUxt42Bs8QnGChK2Hk2M/l58MMqK2S4GupA==
X-Received: by 2002:a17:903:1a86:b0:277:3488:787e with SMTP id d9443c01a7336-297c0389ec8mr16267605ad.12.1762476596231;
        Thu, 06 Nov 2025 16:49:56 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096dbe4sm40974195ad.11.2025.11.06.16.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:55 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:49 -0800
Subject: [PATCH net-next v3 05/11] selftests/vsock: do not unconditionally
 die if qemu fails
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-5-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

If QEMU fails to boot, then set the returncode (via timeout) instead of
unconditionally dying. This is in preparation for tests that expect QEMU
to fail to boot. In that case, we just want to know if the boot failed
or not so we can test the pass/fail criteria, and continue executing the
next test.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index a461ef1fcc61..ede74add070a 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -246,10 +246,8 @@ vm_start() {
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

