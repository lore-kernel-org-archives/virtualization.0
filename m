Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D18A36308A
	for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 22:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773440157; cv=none; b=URL+cHQpjQspQ3JsfoPdOF1hnWTD3Bd0KRlqCp5jW+oPXRoAQ7i8fXa3GUiTb0+HoPns7QJa++ajdnzA4PBJr4E/VPiGKSdPCgTQva0ZUNyA5ZL3EDCeuhrrkhzumsP2OgmjxrMryQGFd+dNE1BqIiuGj1PePGl6sctNG8siGGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773440157; c=relaxed/simple;
	bh=rBRKXwPprM37HUegKVwfVcNsabxW+lLVWS1raaRWpgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s1rZEVEPOktEECDfqpLJW2qM2b2BahnAPBoqrGdnbpuwtBoKX6UKFY5gLdK3xmvT/iHnXiQJhywcCH0A9s/BXYPxq7ol1pz/gHJ5ey4kN1q8YTmBPefkJMbf9t4Hfwt64iJqXoBZdHCLJ1Fy57JobnGItOlSS2H2Lj1Vt2DS33k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ll7rBxif; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ll7rBxif"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-649278a69c5so2528655d50.3
        for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 15:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773440154; x=1774044954; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DXzMG7YyZwcIs9g8M/AdNb6aJuadGUAGleE1leZ+rzM=;
        b=ll7rBxifMNYq7ZX217mFi0DtBA1jsqr8kyxOV1PKQvxbTSnv9L+xBEQ2xsrW2oBbKC
         8g6LMjGFCyyQEAwZf8m20uOLP4L+aY784jPQdiuf71TuuYtv0+Q8xAzs/1KYv6li8i8t
         t8VpUq7UoVz7EfCD9p8p2BS/wE6o0yXFMWwEVVPZArnzaD0dNIzEq+7pYMcAIZVBWGX8
         K6/ZnrQX5cenfeMY8HMF8tNCoSEUeD/inhCx2E9QgTe6JYkFnYZ+tIFDQjvHzp/GbDoq
         YI/EPHfORzpwhPN6tLcvvmVWkbGQw8hRslKyY+oOXF+9CKLQxTm6PlWLPHlNZVmHjJSP
         aMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773440154; x=1774044954;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXzMG7YyZwcIs9g8M/AdNb6aJuadGUAGleE1leZ+rzM=;
        b=LKWjXU8dMU/Y0Ub6W6Vt1nzz7Ee0k7kLv8XG/Mggd2yxUZRixPju7baHzq1TlVbVXl
         XOksFLyqfawbCDrTKgtiruC5cn7QQHW4ofP81Ldj+jwnE9HTLza16VOigZS8IGajV3xZ
         aItsLJlULqdS7KDr70mR7bjdRSauEJbVMKP6zJXhfQBj1k4aUeDr28kzBfPBoSuxFINa
         fa7ANfFwD1GdUW2LqGVirL8/AYkwTiyXmvN3qHFvHaLi8bI83tNjXcCm+7CQpaBhYv6R
         +al+Sxz36rY0b6nwSvEor0h1gxomLuJ7qvBFti/bql59FgbAq+aie71K9GPq2/g9IrTw
         jDyQ==
X-Gm-Message-State: AOJu0YzaxaIhul/lMaRcW+gVT8Iv9Zq4JQqusdrDkKWlLP7XqqVrSXRP
	czSZPh7bMnMYPhVasZ/Gj8GpdHmlREYySwQtMBoymXKxdkIy9M2lbjxl
X-Gm-Gg: ATEYQzzEYh0aya++bwpvd3NqZ7NLCtNZTuScCtowL86tStOwqF1DdvXqov/+Ml5oITh
	jaw6lEADMvD2+lqWQbF+m6moyRJJO9ipaGw1gqDdC+7BmTLVnLQzTP60sLDvrS+2zq9tcJmr7vn
	EeofMXBDgWkLmHEij2KBdK2l1SL3d5bnfZtLdAfKvROR7dyjBgb6mP7GaiGxg7ONgZodVFDIX0d
	mc7uPdjFCE1oAgtw2QzbepXBa0/GlnAvQWOUVRUF3RS/2rXWHHKVe4+TclHi43RwY5+fqgry4a9
	oML/z3hohZpI9+fh2heNyMkXvyQ19BCxbAp4EG7AJGbJgtoFYtOmn6r6LrwN97qUXHL22OWm5aB
	/reKK/W21C8uZPUGPv535Imr+LeqfdXbl0y3yrfxGOiAVWZqtMzljVZf5dsOsVwYkVurWTM1PtM
	bSDPEWsPTRLqfR1nVPZc4XWw==
X-Received: by 2002:a05:690e:446:b0:64d:6658:3445 with SMTP id 956f58d0204a3-64e6304494bmr3950749d50.48.1773440153963;
        Fri, 13 Mar 2026 15:15:53 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:50::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e65b39917sm1796322d50.13.2026.03.13.15.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 15:15:53 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 13 Mar 2026 15:15:47 -0700
Subject: [PATCH net-next] selftests/vsock: auto-detect kernel for guest VMs
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-vsock-vmtest-autodetect-kernel-v1-1-705c35bdc7fe@meta.com>
X-B4-Tracking: v=1; b=H4sIAJOMtGkC/x3NUQoCIRAG4KvIPO+ArrSRV4keRP9q2NLQSRaWv
 XvQd4Fvp44m6BTMTg1DutRCwbjJUHrG8gBLpmBotvNivfM8ek0rj7eiK8ev1gxFUl7RCl6c83I
 5Ift4dpYmQ5+Gu2z/4EoFygWb0u04fprCRWJ6AAAA
X-Change-ID: 20260313-vsock-vmtest-autodetect-kernel-dd695ed3a710
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

When running vmtest.sh inside a nested VM the running kernel may not be
installed on the filesystem at the standard /boot/ or /usr/lib/modules/
paths.

Previously, this would cause vng to fail with "does not exist" since it
could not find the kernel image. Instead, this patch uses --dry-run to
detect if the kernel is available. If not, then we fall back to the
kernel in the kernel source tree. If that fails, then we die.

This way runners, like NIPA, can use vng --run arch/x86/boot/bzImage to
setup an outer VM, and vmtest.sh will still do the right thing setting
up the inner VM.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 86e338886b33..7247ac99cf33 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -441,6 +441,12 @@ vm_start() {
 
 	if [[ "${BUILD}" -eq 1 ]]; then
 		kernel_opt="${KERNEL_CHECKOUT}"
+	elif vng --run --dry-run &>/dev/null; then
+		kernel_opt=""
+	elif vng --run "${KERNEL_CHECKOUT}" --dry-run &>/dev/null; then
+		kernel_opt="${KERNEL_CHECKOUT}"
+	else
+		die "No suitable kernel found"
 	fi
 
 	if [[ "${ns}" != "init_ns" ]]; then

---
base-commit: 8f921f61005450589c0bc1a941a5ddde21d9aed9
change-id: 20260313-vsock-vmtest-autodetect-kernel-dd695ed3a710

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

