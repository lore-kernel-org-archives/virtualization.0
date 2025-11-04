Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F913161A1
	for <virtualization@lists.linux.dev>; Tue,  4 Nov 2025 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295957; cv=none; b=gykweegzsZph9cNMLyuU+mUF1Vo3h/9mWO0VJcXKpLziNLTzucDl53OCiVqihnuLgBPAKmEsKPOHpKdIB0mb9QyETtVVRGaNO3mdPueOGsNPVd5oYE2ZlIPkAW9hdx0zEV3rTFxRyNPU8BXOCN1A+1hGOPeMljHcMsmk0/kuhww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295957; c=relaxed/simple;
	bh=hLx98oFksm1euOd3gRvzTKc2fkdp8CNEeWRtz4krUsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IouUeRBaC82OnbcIkmwVvRmQ6rkONIaJgRkgv/Q27kOkgXcyDCwlCLYkz9AwFqiN3vTzhUq066v1//z9TjIuVs1DyoBBD+WwU0NXrVD+tigSfrxaun9UUBzydLaBYj07SdgeEsI8DxuGl1mKPk0QxXlGaBZmaAuvWx1tpMDSUQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYr0g4bh; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYr0g4bh"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-340bcc92c7dso327002a91.0
        for <virtualization@lists.linux.dev>; Tue, 04 Nov 2025 14:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295955; x=1762900755; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7NPOoIdp5+m43RuZesJ5XJFKTqD36Mp7WZTcw49QJWI=;
        b=lYr0g4bhauOJvznaQUNIArMh3y9XDkXAoNR3d2zzKgUAWduVQWN0YVwJ3JhvjOhM5Q
         lvBFGMErprdnLw8TPEgRWerAiEiZk/bPQAOfd7dsN9LxwUH4Ktg3M8XNc5+HNY+q1Eyv
         YtmUeRNwr4s3Cc7vLAmjJt6xfTcNWn4RDKzaZqJWZk3wYzHlp6eEV4sAEEXKXH1n/bIf
         wi9atXBHY1DAr6oRmvG70FoMxU8lz0wkWKxEzTcoQf13voTjnQAZFUrZTUwLe9WrN4Uw
         64meKJd19kqifTGRDHF1S4gUdDuf4pjCMmGhy+9sG+OCO5JX2dQf2rfeXwNT5yrcqXsn
         Dl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295955; x=1762900755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NPOoIdp5+m43RuZesJ5XJFKTqD36Mp7WZTcw49QJWI=;
        b=dcgm28pwWVa/kUDBbthyar3J0Ey3GhholrKRg5zGllpTR2SE+eO90MNLEfD1FipCt8
         br1kGOEDdLhujRKQHrp55hufZQRW9Z+OdEK7S/yUbsVtwtD2lLbOEZSc2xqj2xU2QwPJ
         twfmkrenvv72fWBawnhMRc8U16I08oqoW9YfWY4AU9ZebtM+GMPhIF5rZz2xSCeZJ1C4
         AGtBPfEi6eMftBOANUv5tmcYNn7qFstqtuyCax9AQuJvYxR5MZ0OrJLhEASuuWSLuB5z
         ByDx2XIUgbo17wU7MimjsxOhnyFQPPewqFAcC38x2b536h3ewB1AmIum0A/emQZc/wy5
         9WVg==
X-Gm-Message-State: AOJu0Yw1QAz+t7Npc6HHugdD6u937FxjC3f2sVdj0K0//sKxZa9xwcaW
	QT7aCPtkHE1RWYH/0fJn4rJ2EF3Be84WoB2ivnzhLhsNaVOLMlAslKV3
X-Gm-Gg: ASbGnctkXPtJJHkodI1CJWHFUN74fDeFna7I4ZgDAyI46oiIkq3gWgge/hthKV6Wc2W
	kW1+41wnXzKmVnT0CKZ/d7a08ibPECa1HE+zT1f5gW7VUdeJCQhMmNOKk3pprLTWEombrMKkG77
	XySgaHEfRkTRuXnxMtnCIHivNXYHpyWkVRit2JZ6EL0IkqR/uDlN01XFl7XP2jKpqDNKDPNVcyM
	yo2Qhx2zg0NeTi+RlmktkvXbXDCCF8OMcvBctb2ct2GN9N2PkSgm4owuHMnxm0cUBDKQoDGhWo+
	7cEqDQkns1vyZ1ty6hC3zWLFsmMFqUvxkITqamxZZgBJrhkvD/D5DxEraushRDBFm46cllxTS9L
	fkY4EuhHXsszOVb7siPwGLszSc2sfVKRNDCKyn2XFIm7hITuUd5311zh+rOOACBPmpNve2Da5zg
	==
X-Google-Smtp-Source: AGHT+IFcWJCIHYENfyxIioaojYZp29/Ndik7t8pPlyOLj+vibXcfDiidJwI3fcQfTIxtp/Uq8IFSMw==
X-Received: by 2002:a17:903:22cb:b0:295:55f:8ebb with SMTP id d9443c01a7336-2962adb7080mr13883295ad.21.1762295954777;
        Tue, 04 Nov 2025 14:39:14 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:47::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972ac6sm39637535ad.8.2025.11.04.14.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:14 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:56 -0800
Subject: [PATCH net-next v2 06/12] selftests/vsock: speed up tests by
 reducing the QEMU pidfile timeout
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-6-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

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
index 81656b9acfaa..940e1260de28 100755
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

