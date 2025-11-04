Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135E03491E6
	for <virtualization@lists.linux.dev>; Tue,  4 Nov 2025 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295963; cv=none; b=PLTu0z1kXdbpTCoVSmfjLm3fEcHE/g152M/h7su5S2LPC9MvTjmI7BHp+2MiPz8caW6PBk6eHaQD949iYZGyKwHmzx4/WCyN9GmB6Nq48FfDSFgWslRNGPE0NH+iiuur29HOeec+gbvDle1BIFBOgsxz+RJmatFX+ZKjRZ2fSSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295963; c=relaxed/simple;
	bh=n+S3IdSADlP9+aYaZkaHpgaj3HAWH7tJS0ebxViFg4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N/H9zo6bo5FRyEF2KFY4BQfRcM1XLiX0FEts5A4Fb3q4Os6CuRaQgqDpxULw0sWiPCkl2YAhj8CWbZoCjFTz35oAg7Guh72bS77hdxIGElUyCf4mvu2L4SB9e3D/Mt8V04MGI7TBwpLmaUV1t9t43RAPt449ljA64o3RyafT9GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQH/1nhG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQH/1nhG"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29555415c5fso48467525ad.1
        for <virtualization@lists.linux.dev>; Tue, 04 Nov 2025 14:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295960; x=1762900760; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=louJU79g2eVK8rdbuOIXqwqI8nr9ZueJcAcohNn7EZQ=;
        b=nQH/1nhGsAJayYQwetotKxdbnh8gSes43Ug+TzU27H9cIsi1TzxAhw+LGfRDmiKLfD
         Kc746Clx/LHWFnomkXazdbyZoHMFEYvwPXhCGGrEHLyRCwZx+F3vbCtXpu7FY8AYKag+
         3m/jFUgA+6ZhKFiqXnVNI276xJgrp5y5EzyVuKydzrlN1HffFIldOs74uQnvBcS3LBdR
         nHZzDm9+zXoUHd0X9rIQJ8uJQcVbL5Dm/2aAVa5bFZw35hzvfEgCrIuZhFn0wQa+LRuS
         ydjlNsrqrzZXk7rvd7AQIoBV/ETTXMwsE2E2pHHsYldbpfuXQ87rAtA4Gf5IH9QdsWFn
         uogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295960; x=1762900760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=louJU79g2eVK8rdbuOIXqwqI8nr9ZueJcAcohNn7EZQ=;
        b=WZQUD22pXu3ReoFXKAQDxTeppc42ApLP3j1J6slf78smBtjBJxmv09E7FUVOhYsJyd
         E3ZzUp4pnzzM/p1FpCZ6FjrfBNuRxXJPix9kP/y8lpk+izaZpsUkSdCIOseiJsfIi5zx
         rd6P4iZmykj/E3ZUftwKkFas5WbyzKzbS6+f9gIm/dCO9rZ/LMFTbzpb83qodhW+Vzn9
         cK44uQ2Vky6IwdmevV/eFwtwwwLIWzCSwXffTbt/RDd+/3gYJy0vcac+YxjPi+ofk4dC
         uurws8K/oldRm40IMmV3AC5vFEQvZqloye/oPdFKceFCH2cYkn9bi2NLKmyb8tk0kCmJ
         wEWQ==
X-Gm-Message-State: AOJu0Ywlj1uc8xiP5ruX/WwOvw6PKtr0L0yt7aOdfFSxo5Ric5KD8D5p
	ciL7avoZyY6oc3cBaPcqI1I5OFHyPrrBoiJOXMXH/zWqtNv2HgErTlTW
X-Gm-Gg: ASbGncuspCs/75K/NRtISYsJpamDnxeqgblPJVgikXJdGmB8o1G6bIGvVXatbckPf4I
	VdOYibbA0EXQpuQDp3UTl4NmTQoQX9Nm94vdUB4H4NCzz8RPfkn/+efOpx955j7nr+suR57ddz5
	NLujaUP0FWAJjStAXVymqXeULGWmE3igSbU4P3PUYCQfUb4AbTd429OpfxomatWEEfINyvVlHvl
	oGG3weeZBYmGGbTSb7KllWTo2h5SoVQObnkWlnV8J+dVwnZ+K2rNLMruXAPEzSgKxCyWKtXrnUV
	z2G3gCLzuXJq06dXby0d9/tvuq9ppqA3aM6eiyS3yQmW0BeJwGThbELY++zbVSov+N2p1LgwqTw
	QmkX2u2BfNhnv4elBLXF5niUGyM2gUZWdTRNmml946MNw7bdyqxQiz3ATCTNvj3OWDll2h25y
X-Google-Smtp-Source: AGHT+IGqM/yITUFIcVMiTb5JYv2w0Kqx9gT7akPgWVpAVZ8aDi3SBcd1PdYtAWJDT/UIWXG9sHA8og==
X-Received: by 2002:a17:903:41ca:b0:293:e5f:85b7 with SMTP id d9443c01a7336-2962ad0c942mr17413335ad.11.1762295960355;
        Tue, 04 Nov 2025 14:39:20 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f2a7db8asm3463802a12.14.2025.11.04.14.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:20 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:39:02 -0800
Subject: [PATCH net-next v2 12/12] selftests/vsock: disable shellcheck
 SC2317 and SC2119
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-12-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Disable shellcheck rules SC2317 an SC2119. These rules are being
triggered due to false positives. For SC2317, many `return
"${KSFT_PASS}"` lines are reported as unreachable, even though they are
executed during normal runs. For SC2119, the fact that
log_guest/log_host accept either stdin or arguments triggers SC2119,
despite being valid.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index cfb6b589bcba..6085e4cf56d5 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -7,6 +7,8 @@
 #		* virtme-ng
 #		* busybox-static (used by virtme-ng)
 #		* qemu	(used by virtme-ng)
+#
+# shellcheck disable=SC2317,SC2119
 
 readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
 readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)

-- 
2.47.3

