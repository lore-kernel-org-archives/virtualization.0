Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311152F12A3
	for <virtualization@lists.linux.dev>; Fri,  7 Nov 2025 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476600; cv=none; b=ai6ot403zhQGgqGqn04O8pfYH0IImjcxCbRHkoU3hF4+/tZgBF0V1NNqe/34PSNq/Mn/YzW1fHwsPl2oKN83DuF5x4wGq62loujD4ZY0PsqR2DKWzKM7FGwgMkrFanuFjkvDfNphsqdDRkfj4SYhqz9bnCjmri8RJQ+ZX6Ce9N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476600; c=relaxed/simple;
	bh=NjhEgtu5medwkPvG2Enm9tK5HgLlZ3KE8dn38aGAOtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d1G3AZcWBfzFYEN3sHGvJyhzcCiv0xA8FTAM/ZTwNhQ/mB4GK1TT757hWIeNJMxNvNWMVfXJ9rgzloELCwo8b1kUq28YdpEnqc/nwNnQ4jMg9FyXOo2GTq48DtNgPXizgMLa9e8wmPiCnYrQAxphzmGf2GGkxU4p33WrIDflBE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6B4XASc; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6B4XASc"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7a9c64dfa6eso161755b3a.3
        for <virtualization@lists.linux.dev>; Thu, 06 Nov 2025 16:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476597; x=1763081397; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cB0jrnxyKvtVXOL0SkOCiQy/hsJ1kDvUYjzNG1+oTMw=;
        b=E6B4XAScpos9n4maCMUJjOTabydtIdewt2CrbEGmp7GnCuT1c+csDwkV9jY90ztSzX
         i+fxPTLyz1hnIwmvud92clg+4LfnuPPa/MeJaHWis7ZeELg3BXL/jDDGun+d3C+Cj9Jv
         G6UVm7imLpWKXCtLIt1iLl3iiZP0q5Xqw200N9dqjFS7C6kozWGxjjGFtBkI3MR+CcTa
         QCvyXYIz/xIHzCQyOV7ZSXaxN6jEtllBOQ1VLDuIZYlg2jdePdTQ5P0D0+A+Qj4VXloM
         fOUooTNOLIZNP71twE3XODg8iH2kpdfgorW0tqrGE/zM66LO39b4DXLaMxO+d4aoIUIG
         0gJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476597; x=1763081397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cB0jrnxyKvtVXOL0SkOCiQy/hsJ1kDvUYjzNG1+oTMw=;
        b=DS351ojPV/+Qe0OV7bKs4jbmhwpsWL9fjuEFAAGLZwNCPinYXTQ/Gq3BRYBfyilRCw
         8HV/SpxSgalmMw20WVMiyNTF8TYraPyvF7/TsJhXDgtxZaffok5xh6wLiqJlD0IsFr4P
         dJbK5NuH208ohHBdnl2t5LwH2wv4FxqhrZZLVomZnZZWTbBAM2Dfo5KFmOqR54cpqkLe
         dk2otGVdnYaIr9W4HQuXkbo/RFUaa5KfVUbp3rockMpzhRyg8vwevCDtl8T3+3RPiV8q
         YFRxYW76H66f72aWSbykAkKSj0MLyMWWHz6eNScDvrxD3aLhXUBntZoZKEHbqlf5OUs/
         FoEw==
X-Gm-Message-State: AOJu0YyVWTsTbPCPfapY+XxDZkDSAHhP9wE73LIHHc25y1fLbsOd2Eqt
	W94Ds4wXgPdAgrBWiekKYOWWsOPQ9fp8uLz25Ej3lLi246zM0x5klUDT
X-Gm-Gg: ASbGncuJ0bYMYonqs7p7TrGIEJBf+57S1H564AUlTUSqTK532LUsqu+MJFRSXzpllwI
	1y8KWZpNrzHvh5G0TVzmX2johX8w7/lLnLyyLJ0TzYBKVv+Th38FKd4QOJEzC+7Dn8qt1U4Rsxx
	MMTGvzSnh0hPOUVL0ZIuKUrfoAMhe5BiyVXtI6oEnLTNRbKoy/YfDvpmBuMGzDUisu3YNA4RRn1
	fYVJqsaZLj3Jendl5b9dtFo5vpSHNtkREdRB7ZQFmtekVrn49/rP6FVFTVlYPq/1HvwS2zx/DwO
	hzwqCus4lNWOQLeunLKFhAGGKo8Ia+jboC5rzTUAqLqc3smQEHfQ0qQ20b26YFFQiUYA3LJFFHZ
	tKi1iaGZBbz+x0wudt6O3i8sabrZVSzv9r5OuxkdNeIdGz8+dx9OhFVPwe0lRbENryKmBw8B4
X-Google-Smtp-Source: AGHT+IHEjR+tD3f5onmBvKNAdZ43ttTdSjninDQiFysSI8E3D14rKPjUX1v0eti1pW9Okz7YIsxP6w==
X-Received: by 2002:a05:6a20:e291:b0:33e:6d4b:609a with SMTP id adf61e73a8af0-3522806bf44mr1924302637.6.1762476597267;
        Thu, 06 Nov 2025 16:49:57 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9635007sm875993b3a.2.2025.11.06.16.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:56 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:50 -0800
Subject: [PATCH net-next v3 06/11] selftests/vsock: speed up tests by
 reducing the QEMU pidfile timeout
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-6-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Reduce the time waiting for the QEMU pidfile from three minutes to five
seconds. The three minute time window was chosen to make sure QEMU had
enough time to fully boot up. This, however, is an unreasonably long
delay for QEMU to write the pidfile, which happens earlier when the QEMU
process starts (not after VM boot). The three minute delay becomes
noticeably wasteful in future tests that expect QEMU to fail and wait a
full three minutes for a pidfile that will never exist.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index ede74add070a..557f9a99a306 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -22,7 +22,7 @@ readonly SSH_HOST_PORT=2222
 readonly VSOCK_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
-readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
+readonly WAIT_QEMU=5
 readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
 declare -a PIDFILES
 
@@ -246,7 +246,7 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	timeout "${WAIT_TOTAL}" \
+	timeout "${WAIT_QEMU}" \
 		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 

-- 
2.47.3

