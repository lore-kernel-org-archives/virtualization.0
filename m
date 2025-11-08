Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C553231842
	for <virtualization@lists.linux.dev>; Sat,  8 Nov 2025 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617719; cv=none; b=nP/krn3sL+QGnL1aXUDtIcZ/7T5g+IHpuV9Iw+przUTwb+HX1Pe7g0jeUESRFFV5ARb1Tng1e+/C0dseM22YIKlWa+aSRpSnKrhy46b/uyi2+sggPTSJQS+StaaYTLCN7dVj21NGYC6AJgkjeRINKYtjXFU0b9zXyvWi4C5y+6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617719; c=relaxed/simple;
	bh=vFLZWv/FUrDafqhdvi7+WMCrHvjI3U/d+lidxcdSdHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HGePm6mcAaJs7jo1gw2naLeiaY/DxGPMUJEmMBX5eR3J0pLekmYLTRJYPSuGeD+cQisZMb6K8tf6PdzKNxDgD0qeDo2OmzbZdiOC9UyrxpVsuhOwDIoH1NsGThgz1LBSKy1LSn6ZOckq0O9ycU4waL1fQpL6qDne64G7aWOBUVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGD89s5q; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGD89s5q"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b8c0c0cdd61so1423961a12.2
        for <virtualization@lists.linux.dev>; Sat, 08 Nov 2025 08:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617716; x=1763222516; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TzgGQWG9WGn9L//XYwS5wGYUOE0Hzr54Zzu6AsNpCQ=;
        b=nGD89s5qXe6kHVvSx0L8cNGBXeen4EntX6kcFLaw65Rp7kx8stFRDzm4PBmG5hKSRF
         12A+0KUeXtEqJVrDayDrZBu0/Gq1Iv0atDg+SuliZOVduKNBSh9aoR6GQYC+f1FyfxD5
         7DYdGyTfsgNCBwcmcEWYK5Opr9FtDUd4QRftYnFV0ex89O0Hx/WdZjGzvp9X5fb2HUf+
         EnkFgKTubHIcpedq2XUud+O9MMsibFsCKxeXZlar+KebBDJwz10q+9gg7QAjePCjKoaC
         eoFOqMUhWxHyx/wd0dmcaFzI9/r7dU7MDeTGuyvgUa2usbZi2gIegHYEbFjrxLIKD2YM
         bcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617716; x=1763222516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8TzgGQWG9WGn9L//XYwS5wGYUOE0Hzr54Zzu6AsNpCQ=;
        b=io4pRAp9ywjDhvb39FvQusmyE7ODetg9RUthkAQXrJNrlFBIMhw1ZixSaJawjqhCDw
         4D/tUrKkurVg7D49pc6k+zLa/KLbDVG2VNDDqKGIoK82JdbCzHfEw91CNo/8bad6jhBO
         bx52SiToVlaTsl6+YHXQlQleLjFlMHTZKoN2szFDgNR6tNh6aXE0JweF44Z36Xzd815K
         l3lftt27pcnFMwkkHIb5ZylXqkSmcvMURMeSGMUYOC16sQD+YZY5+IjcQ23Sv3ACXVTF
         Ltu5egZq8/8KwmxTHJzWxBv/PM5GztGH+3K0a34zx7QXHHbhLDuTemhuhnCOK4oCrjZV
         ePZg==
X-Gm-Message-State: AOJu0Yx50kX/LsdWM0IE3P8cEISSyvM+tGwpvgie+IRTZLcFeXl+nTW6
	KcoH+WUfXoADBzw+ZfaNwlaT9rq1ldzJ5vxUPOMmXhAh46BJY4e4YbzQ
X-Gm-Gg: ASbGncs7AKg04iYraIHkjqd8EZsMJ4sfDYQp1InweoyMeuOnrmUpKx7eBBFjDRcvXuF
	oj2mFEWkaTv/bLXhL43qtCoTuVq3Vczn0s1j3qvOY4rBfLE9soJeFu6qZhVCCjHkbesDEKqRr1+
	R3Mr+tJZxZPBpMtKPxtXX4diEWvTYhz4YrlV7jBIpyNJHeG9xUa82VeFzRt+lynXQq1ArqlU4Os
	6NcMh2oP6a6lF+mO5v6sdJEqrbql9TxmCzzIRt8M8SGU+B3dc6rjCTNZag9squVC+qbdqedH2OU
	qXim+kRkewDA+jPlzaO6CoF0OnM5Vs5fm1b0180MKS6Fab9tPKfro6v/v4LRR62cyvat6vBWMcw
	bIpFMzWnvnw/hcw6xvh0vvONcCRELYUgDz6eFjysWNKj6RmpxiEnIHFpX16fU7INZhlgTx3w16z
	FCehA7Sxj2
X-Google-Smtp-Source: AGHT+IEfqRtwhtlx9re+8tiJC6AWXgiAQTuALNt7ZHJZ0Q9RkasCM/u0W7yOilEslz3OhmJAdBVkcA==
X-Received: by 2002:a17:903:244a:b0:295:592f:94a3 with SMTP id d9443c01a7336-297e57101bamr32706755ad.48.1762617715878;
        Sat, 08 Nov 2025 08:01:55 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cd0060sm92578535ad.108.2025.11.08.08.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:55 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:00:56 -0800
Subject: [PATCH net-next v4 05/12] selftests/vsock: do not unconditionally
 die if qemu fails
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-5-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
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
index 13b685280a67..6889bdb8a31c 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -236,10 +236,8 @@ vm_start() {
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

