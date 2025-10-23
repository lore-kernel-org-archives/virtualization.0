Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22052259CBC
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181240; cv=none; b=OFEUw+4WlbsSlf30reMi+TAYV7O8/vY4vQgDGjLf+fWZljL0CNT6GBIEqrW88TulPC/t45JLyOpS377+SRznXYrdPLpZbCVQ/IHJAku09ghdjfcIANpeCj3VR8UmCT0YSBjSOQ52m6LaQ9sdN1Es4cLf0Yjzk+cu6F6AS9w+w4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181240; c=relaxed/simple;
	bh=0gdl78nLUN6qDU9c49g00gHfPsOWu9yWlnAwLxCpxsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mrV0aHZE/8FC9nrPDCT6CyWu228w0PNCM6h8aM3kjlTgYJkQW1IeTD4ZhTIFmLbW9l2XabAU2t0YpvHAqaXMnjdqa5JmmeG6RbNM1A8Nj+syMRNV9ECEU9xzXJ3r4T/0fVms9tLT0uQ85b1joFfNMKTQCVNtdTjBJQNvLJP626M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AE8O6uqu; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AE8O6uqu"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso254350b3a.0
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 18:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181237; x=1761786037; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+cswws6nw1UcLqOlSgHDjsHbmmRPUE9+8RNFOhZ/bbU=;
        b=AE8O6uquRdQ+/e0ysRnCw8U9juW477ELOymRbnMs8diuE9huoHZdK5ShXSSIIwSYkK
         ZO3UDlYuFyr5OP7tnrlFdxvTQSYCc6l7Hqe1//tQJqP2kmUY5lNQ3CUq1J9dOqicx9sn
         48OGCcHaZEhWgmDDJiIl5IqkwG2kh7wp0Sng/6T/g1sgub+I1OzEfT5TVaxOnumBXat+
         d0jEIpLJ50saG0eMzpm0i3QHC+XN2C7hMsX7Td4PW05I7NhOgivKP67TdGxMvZ8KJHv1
         5OhUBajSwboyZD08yXreMQCcIn7D1snngjz0jbm0+83SIhXbgn2eIp9FRn/Yko4Yocbk
         Kbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181237; x=1761786037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cswws6nw1UcLqOlSgHDjsHbmmRPUE9+8RNFOhZ/bbU=;
        b=lWs2KoUNfDA9dMBUoru+tYx5iY9jhCbxmPQT9LwHP5Z2LGtkWeqVuIxMjmxR9HoxXp
         bPL50m8guYuO3qsnG466X90iwgjSu5uR09N/PkHaS/q26VU1tHVUCDYHRFNWCok6SNYe
         wXpFe1utKnSD9bkrwEVtWaKTfDBaJbke/yTzlgi+j3V9zV/GQtVgAejwhMsKeQyJ9ucV
         hkyj+G9F2QxYvharjc6WBweDDaFuN3NlIqbQ7Y/NPJmz6O8ak86jZV7jPDbkAJZLcTmw
         HAh5+Dbk2vXSoH8WXAckCIJfh/gfVUCHi6zImWt84CgwldgByHO5AX9BRHRHKf7R0I5A
         1WwA==
X-Gm-Message-State: AOJu0YxJgsUuQacaYDf8vv+pOydvLzLQB/T6wAbYaXgffmWf9NsykrpF
	ULvfLwdlPggM+cmLz9b8dpyWlF8R5u/seQ8tS31xvOmAJlq5Sf62m7whfLiqu7wn
X-Gm-Gg: ASbGncvcuPJPgcihB+XcqCQiTG6Pixvo4T/YZ6SPbK7YvQZjE+wNc8wXTf9pfHLHbJ5
	v9C/5CKjzHDah0nAwBlDxowOoYBCkubsu1lHVsGGyAhN+w3DU+0dbgvnFJ1/mU9Bx8I3c+noc20
	+Y/VluxG6GMC15ZC0SIURM1Ypgpn9FTPLF/4gk3OLQKE7D9WUzRcBuqc2Y4oQTeJrNmE14474Vk
	VcJTq/InwLfuMbxWc2VV6bcFCev/t9YYVXyrKi55pMTsqNawTFykTUMrhvQKZ4lxtD8OYdYdMfo
	3V5NqoYe2AWCaeHSNWE7nEzHEezgQg0ta6zi9BSliOyxhPd9bZ7ygZV6GUbNZpDOWonSC8Fm44D
	zr2zD1eG5YaK8/2/hfJC1uZXCqfsonRkAvFL9wm4wGFJnH3CSmQjelqItwqTU6lVw+7QYqx2R2D
	T/PG6IKVg=
X-Google-Smtp-Source: AGHT+IHFMWz/k3rf0exIhdMWgyBNfPBQLd//9lK2ixQKJ308LaXrH8yGDSVFtVxEd+3WBYMDTmigrg==
X-Received: by 2002:a17:90b:5105:b0:32e:749d:fcb7 with SMTP id 98e67ed59e1d1-33bcf87a85amr32540449a91.13.1761181236821;
        Wed, 22 Oct 2025 18:00:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dfb67f151sm3310254a91.2.2025.10.22.18.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:36 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:16 -0700
Subject: [PATCH net-next 12/12] selftests/vsock: add vsock_loopback module
 loading
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-12-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add vsock_loopback module loading to the loopback test.

When testing vsock_loopback as a module, it must be loaded before the
test executes or else the test will fail with errno 110.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 038bb5e2b5e2..62b4f5ede9f6 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -445,6 +445,8 @@ test_vm_client_host_server() {
 test_vm_loopback() {
 	local port=60000 # non-forwarded local port
 
+	vm_ssh -- modprobe vsock_loopback &> /dev/null || :
+
 	if ! vm_vsock_test "server" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi

-- 
2.47.3

