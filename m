Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179AA19882B
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181232; cv=none; b=RvbadhXN3MHNlUItjP9IjKgkcYfHb8uCgUErN+CXs1jlBLPaHNHMz8EtfjqLDCX/EMXmAf3QaFOAhAHooTjhe3BPv8SG+GWxgLskGSVj+U6hYMVuzxCEwNv/N+2aU1s1Vi3sVPMYaIe/+9/5mVWMwBaARwbnQmQHoz15KppWVek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181232; c=relaxed/simple;
	bh=4pbEdZWO3naganJPGX2hHH04O1jq6bd0JAXIDNigrjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XP9JWNI6+vM22rMLy2z6/q0GwcRvq4sSEn8QVJvHu6tn5n66QAkbjSIy3zzxIy1Y7Hs70CIGqkxkZGaUAY9Zt1gU59hAyRp5ydkza9GGHCXBE7GTJU32KyeiO0G2ufE1iUsVjjmCU5hdf0+YkHtCtkcIRktT2+L8GLJk8/Maxy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/aDjiOh; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/aDjiOh"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33ba37b3ff7so238837a91.1
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 18:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181230; x=1761786030; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXOvnbfPKIC6rRblSxQAXqJxbJ18ywkGP6EdCLVk0Qg=;
        b=E/aDjiOhlZdmi6N19oCkHC3t43u+g/OFVZXPfbjulBiY9itRmmrreY77PWfveDsdW9
         FfIalnZyltjhcKjS7k3g1NOxlwnSvfKHcJmPylanXgwV2e/7b1IcLRr1KeXJLKtUOjgB
         k5xe6NI+EVMcNr1qi44G0KrOl6isCHTvDd/2rO/LPQllTwIE9D7OJaNOzRzfSHokZQk/
         qiWLU7HuiD4qKqZlNoGbceqipDeQFEhEqgx6bkjoOwfTeBLOeQq1/jAXesXxI59A9NBZ
         X5Zkg7mZ0TkrX2UrIsQ7G9D+cmGjTy2FC0Je/gQaldF6LXZ6+FtyIa0L0gmj7RJuFyWT
         jtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181230; x=1761786030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXOvnbfPKIC6rRblSxQAXqJxbJ18ywkGP6EdCLVk0Qg=;
        b=tFqvVSGfAUR6DhnuiqiEeTKhZPWuvlBAfeg0HlAbJwEgmhkTehZ73s7rpmcGRon/2d
         7iJoo0N6wfTgE5nkjcM1akkvevQdbLsZAhMoBZBsSQ+88mhAyA50f+h4xGA6VmrKS3dk
         zUA7DbYWakN/qaR811VZMT+O8DON7QfO/UQnXqrnIJ4SxvevD7PURDtIDzKMkGxTQx3i
         4qUx8Ab1RhFHphDYgGR2m6sblDo0WUPPGUMJauFYDJonWP7H0zUDSRjq2UQvpJkOKKCu
         yGwtWrZ3oChOXXTTjtJYYNl99srgNz7+vHhlNT5MPlpc/R1eiSLm/fDXVT8CZhxR4yD4
         XF9g==
X-Gm-Message-State: AOJu0YwQu7vgKCgPRaNUrLWqhhgX9kftcihM5s7aloWkZ6Tg65Nzf6UN
	1aJBTqBzB/YPa+i1auhTv3SC3mIkYlZ9po2VLRPc69jvNq4OTQyazf3dAxd7w5J0
X-Gm-Gg: ASbGncvGT2BRLQTNUs6tRnm31NuzwM76CNc1wbvo4IHYmKmuyJe5W7XYZ9rqXR640Vc
	DN4EOuhq69pivmbxThC3iiRYPJS694HwxaM4m19hiKq+cjWnQOIPHPsY6b13ddKXeSJx16p7aha
	upoZ2Omd5JI53sWVg0Ie3DfHAVcyR0Rd9Xgf/4dFsH+ljcDyy++grH465Gg6dtZFJQ8elsG2GPK
	XMgzDx5PDkBtVGxx048fBkoj2kFmznH5bfilR5L0Yl+H8nzwf52T2nCNKXD9OeBv8VmcUc/baeS
	6JeH/nSKac2Jt3m86R5lDF48FFCpdwJdM1UNwGKWm2aeShGcW6hmaF5fjbyfNmAO2F+IbSOuYf/
	5F9nongQy4X2+vl/s6cEzDJfbBRf/Po1XntRTi5FIMpurq7CVZ948RFfc3gIEj8gSmF3v54a7H0
	/VpXxWMbY=
X-Google-Smtp-Source: AGHT+IGDhjee3qb0RmCmk094kyxxRhSnp6cpHy/pZvteX5hCRnyEn25K/Mo2iLuTUZkw6wAqEltkkw==
X-Received: by 2002:a17:90b:4a03:b0:32e:7277:9a81 with SMTP id 98e67ed59e1d1-33e21ec3286mr7594732a91.4.1761181229218;
        Wed, 22 Oct 2025 18:00:29 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fb016f865sm491272a91.11.2025.10.22.18.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:28 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:09 -0700
Subject: [PATCH net-next 05/12] selftests/vsock: do not unconditionally die
 if qemu fails
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-5-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
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
index 9c72559aa894..6c8f199b771b 100755
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

