Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD62C23D28F
	for <virtualization@lists.linux.dev>; Sat,  8 Nov 2025 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617720; cv=none; b=C9p2PX6FK26wi5d42xghk+hEbqBiY052Fba6RUzUKJ6vdl4FXlT4aclOhDjpwXaTt3mO/FThi6zPH7oHhXSF/ja0zDkO3w9ZZKNL1nVT7vLOwh1MqPXmaGmzZ+1rtkA9aQYa0H7BN85DwUlBh8cROSWC+x4QFKNk9IoySbsZEZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617720; c=relaxed/simple;
	bh=o4MlQeDS6auM9P4kHNQ3k9pmc0q9lYi9e4vGWiCOtnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q6KzSqnSDsWcYbP4LbW1aKwgSZ6XL1U74QwiL0tQV36seae6wlZZ6RYTFdx9WufqSGR2ogm4qY07c9jpAQBzQ3rLnKdnpcXDAJySv7go9yydP+FNrIPl4CP7FyGptomF2EO70BUhtc4Qj6bdUhx9kQF2HSPE7gpGyV5cqTUjH1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1qXnSu1; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1qXnSu1"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3434700be69so2257261a91.1
        for <virtualization@lists.linux.dev>; Sat, 08 Nov 2025 08:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617717; x=1763222517; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WAjRw7PTsJ0iELJkuhd3H4m56at8173dELtud6Xr4j4=;
        b=e1qXnSu1iTOtKUQe7SHfA7r3x0r1fel0Nc2GcR4pifokXTyhE2h8tOEFIR3h3BZc0C
         AHYGKCtOAwBXCZeY4K6OP0GpJVtEV5rnkqO1UOS5VJqIzhP7UvwkQwnXhVmkrTMUUJ78
         P9uL361TPlLF4fTnIreFYbGmpUPsT050XKq/BlYR/4jLID4/UfSZh8gmYaD2rSN1HzkZ
         Gbqwc/qI4NfabZhrH5y8HGa9X2X+fcx2VMmWNe//QEZ3JapFy60afBwtFOZsxeUPEuKm
         dzny0C3lFsjK/sP+VGSzXh8r8gtUo1DboJ4eJ+xxMyfU/XXMobfxNmPfVzM6Wq5nIjsU
         cEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617717; x=1763222517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WAjRw7PTsJ0iELJkuhd3H4m56at8173dELtud6Xr4j4=;
        b=FoI3RYaZNz/rqjiqzVBs3rHZrL2TXYJcfKydC2vEMCqo28sSCcaNZjyqSVpGGNcTgY
         0b7BqNR9dyfX1if4QhI4VKnO2TCkVTNJpq/BTfDjZuq39hLKC3lXDewJ+z5w/pxhkKRh
         81qCJEIWshWC75QqLNsi9fip7vCVci5/kD+T+U8KLCCoyrHv56/qYsBfS6dbmjWu4I9s
         ZLL8LYZsiq5r5AcykC7WteipFDGO5T8kJ6WON8q0x59q5LxvJRPZ+qqyXLjJBcyuKffs
         CR4XPzW5wI9Xn/pvCnHgaxbnFoL9ZFR1+suCpJc/gmG9e4NGzXWDik9A1LQJi5Qd96dT
         TV/A==
X-Gm-Message-State: AOJu0Ywywnaxl9M91JY2pWzewwDx9nMnUtt6fKZPggIRm8Nlej/1wIhP
	D1g9WTlqxksvzBGi1uX5zLjFLzVK5EPEPItjbXosusUuhEE6V1Ne8KWa
X-Gm-Gg: ASbGncthQMW9j/aAvbDHfAz9svuX2vQ0+vdcQ93vFGVgAbMN2btWcPOvRJALynGeZXX
	qez5bjkP14Xeaqp/Gu3nxBo61kIbpqCBIDUPI7IuEfbRikAISHU+JxS3B0WdLDCqg14j8APBNlC
	ZXfZoPeBwBf63fD3juKDmT5RWeRsylpBK7qMRw4ga/MfKfdIRI/wS/Re0cSaMsRTiThRg4qAnml
	KMmoV7j59eD2latQrj7GmWo0k8yv/4esPN6A/VcBFHB41mHFiTOxKMb8pt3TDlXsYm8qxtAyBax
	1hoJGOfv/VdyRDnlyvUbn5GzWZmfIQPfIbI0OLOcMGhW7qLLFxo0jEjd7165HoovnnE4R3p1MLy
	oydqj3bkO0aEju3b/iVu4KGYkBrn+KJIWYE8/yNuNXYWWuh3MF2SFGkvqwiecqA8ggqZ+ghvdYw
	==
X-Google-Smtp-Source: AGHT+IFJMiSDPJLEVgezSpGbFJbQVVjV01QEtUzeI+pmHkqds9NcgUya4c0r1u1o+ppTnMUl7FVAsQ==
X-Received: by 2002:a17:90a:dfd0:b0:33f:ebc2:634 with SMTP id 98e67ed59e1d1-3436cb3d256mr4326835a91.9.1762617716780;
        Sat, 08 Nov 2025 08:01:56 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c3357bbsm5935730a91.12.2025.11.08.08.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:56 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:00:57 -0800
Subject: [PATCH net-next v4 06/12] selftests/vsock: speed up tests by
 reducing the QEMU pidfile timeout
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-6-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
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
index 6889bdb8a31c..bd231467c66b 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -22,7 +22,7 @@ readonly SSH_HOST_PORT=2222
 readonly VSOCK_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
-readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
+readonly WAIT_QEMU=5
 readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
 declare -A PIDFILES
 
@@ -236,7 +236,7 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	timeout "${WAIT_TOTAL}" \
+	timeout "${WAIT_QEMU}" \
 		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 

-- 
2.47.3

