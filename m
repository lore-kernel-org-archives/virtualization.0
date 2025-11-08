Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43799227BB5
	for <virtualization@lists.linux.dev>; Sat,  8 Nov 2025 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617724; cv=none; b=XjP5+V0ERQ5iDuRORm9yiDI0zC3gywPDnAZKiI/OuG8bulfbk2AeLeA3CAuWxU1YDICJvkcfU8NmFGe0roF1bo+OcaOO/0h6c+5DCGZ0lDYnac6JIiip94q2+OIs+DVMMg/WANKeC0JvzPNiMEzpGinuSjuyGm/GIrTwc9tPcYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617724; c=relaxed/simple;
	bh=SP8z1T+qlVVpgOEY39bC1ez51Ud9AdASTxD/jvP34Z8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CUMRL5e6TLwqj6hmVB0ysw4LLbrEeaEhMuONRZx8EKhU6NLJSBtqsCythzat4P6Q6jf99d3ge7bXx9Or8QUSAT2n63RkhLUwQ3ieYLb8EgcGE4Mu/PvkJu2Djg4/e64XQd6WtPV+Lbby+10/sDoKWbauicWQLjW34PYpHlTi4TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFJAJVGn; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFJAJVGn"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bb2447d11ceso104508a12.0
        for <virtualization@lists.linux.dev>; Sat, 08 Nov 2025 08:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617721; x=1763222521; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYpbI2qDd2ToMrlc8dBEHmpGvANrMWIZX9h8c/Keihk=;
        b=OFJAJVGntYlp5WMsOrDgT8yexNZpRMTxw4LLjEnSMWTN25jUnhgwTSezhRH9nd8MsH
         oK8S/2MfElvk+3YvprjZ6ftDjHsBEj99KkR6J5mSfTLcBytXII7zHQx3Q2RIKtPHXcld
         lep3ghKFyyHk8QPWjhiGRdcxgZUbtQ8loOrwRNPdMxuYbZ+fDSRu/o3NPGEtlHtXTe9S
         X3zV9Au6O+7pOcl7TDanThSLVYlJdAhskOu+BR674PQoj0EA64kSTuDvXui3J99gQ80s
         cUL5pAtCv7LBT31NSKU8zkTPt8bZ/4PY38exuRmTBjWplTDLSi1ONonY0i2odK+QUYp7
         jVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617721; x=1763222521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FYpbI2qDd2ToMrlc8dBEHmpGvANrMWIZX9h8c/Keihk=;
        b=M8orOW7S6tcWznJqsx9HGg6iVC6qC1Ob7AdxdAMEYcitoS0/O5hi7+LGM+S3QFgU+T
         jH93afpyBt6cHA2OTHwjMl/xfWP72cgxWsSR3vXIZh7OFp5K0FmIeiMn/ZsQ/5Cirqoc
         Xf20uKFMWvf6o4movv03GdAj/J1qTGEovSZakX4ipDTp5PcWVi7TlbWjAfnydMx0beb7
         6PGYN0Pep+rPAVB19SdjG9O9xz082OTr5zFYsYeVE7/lwQWCXZ8uyArD0RB2YJZJ+mml
         w1DN7BNEUBJEmCOVNaiIA0jP9ZBXVy4FQcipOrlHiW6mcEGVD7h7ecl2kaxqj3FQfVNl
         5y3g==
X-Gm-Message-State: AOJu0YyjZMdtkNGeMQBBi07Fyf0F8oB62e/4ZL5oB+A7COibQjp050k9
	R+U19oXk+3ozUEFwJSBjYagROg7qrlEUaDbq3O+VvfWKg4GXM/3hvrwa
X-Gm-Gg: ASbGncvx73hvUCqGRw29Iyk5zK+B26mgtvXYAHievsRAtXm1hfPkjeEAJ5ze4q3YduA
	ZuCPETOUyV+aBfqTqjUQ3mDPamQ2GePyw9SNLxRGKwUCcPXOmeLb5nwMUaq1h8xLc67/sNl0ilA
	V05sCCML8odAH/pNjJEcISXk6vVjkE6HfPWmrTOkA3dZovN/oKzHm2rEI4xhHqjo8ouX4zUvhd7
	aCnhmUwjtRDopeHm9nrxm+Lz2ul8P+uoDGE5E4atGcg9osRaM6YnSpZITy2vTKDNDhsxQqamubB
	3qCNXl3dbJ18AeimdAAYP2Kkk/0TH+E3ZoDFwhr7T0yGoD5aCa/owpmzwvFEOhRmH9H4NwDfR+b
	E0gUZCTZ7bNAn8KkVztJb14bxb5/h7moHs/JAvqt255Z0PTF7X9Xhri3ZMBYQUf+iYa8/G6lhG2
	Km2QuJoK4=
X-Google-Smtp-Source: AGHT+IHCGCSZhbNlxrVbkMXRN4C1nK7xsiQfSpEwGwQVUYt3YG8Lt+frrWDbMAZVEikAd86U4GMidg==
X-Received: by 2002:a17:902:cf4c:b0:297:eca3:cee5 with SMTP id d9443c01a7336-297eca3d0f4mr25654655ad.39.1762617721363;
        Sat, 08 Nov 2025 08:02:01 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651042c24sm93003605ad.50.2025.11.08.08.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:02:01 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:01:02 -0800
Subject: [PATCH net-next v4 11/12] selftests/vsock: add vsock_loopback
 module loading
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-11-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add vsock_loopback module loading to the loopback test so that vmtest.sh
can be used for kernels built with loopback as a module.

This is not technically a fix as kselftest expects loopback to be
built-in already (defined in selftests/vsock/config). This is useful
only for using vmtest.sh outside of kselftest.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index b611172da09e..42e155b45602 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -452,6 +452,8 @@ test_vm_client_host_server() {
 test_vm_loopback() {
 	local port=60000 # non-forwarded local port
 
+	vm_ssh -- modprobe vsock_loopback &> /dev/null || :
+
 	if ! vm_vsock_test "server" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi

-- 
2.47.3

