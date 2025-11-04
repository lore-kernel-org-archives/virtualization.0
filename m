Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1966347FDD
	for <virtualization@lists.linux.dev>; Tue,  4 Nov 2025 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295961; cv=none; b=UjEm+dH/cZEKBdHA4RQIfvzBQ16D1jf+01fnCmJHJ258AofFeq4pbuiy3RPRs6/OT8pWW/M4nPDwAbTdcC4htVS2H10rGXSpJzIaTRv5HbBLF2vzf2hXVBEx6e+P04Ph2J/85vZM8h7yt1mhIFay77j2ZkhRL+2XP8CqwE16EIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295961; c=relaxed/simple;
	bh=XlP32tEwpZirdMr7sqd9mNrUqkac/qnWShul7Fw9yow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ajgtjq1G1Uy2fiAZnPi0LyPS4q4/snGqxs+rm3f+QaXQhIfHkb0Wkzpfsl+KqMgbTxu5Q6DH8yfTiZCuQpRF+Et57u+HXo2Tok7wZb7Kjxp/R52rAbWL0rZ7w9q6XwAPr6PzkQ7/9ZB3EcZ6rN0w8Vk3T2A1fclcoHMKNuTCh0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c57GO5P8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c57GO5P8"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2953e415b27so39534415ad.2
        for <virtualization@lists.linux.dev>; Tue, 04 Nov 2025 14:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295958; x=1762900758; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/TRuhdOoSSGipeIAHAxq+HN65/ys/fdjImQ5W470jiE=;
        b=c57GO5P84Jt4jFHQDgXWsApfmMqyBzOVgqIpnKShsZV+tvPumwB0/9+nZMxkvlUDyt
         94yHvVatB1v4Oe0H0RkWY9ab+O8ro+9noknMT2fT3CtwZAOAUA2Kal2yuxdqqjPLy3Nc
         zvlh3wKiaj0KHPKX6sPLKL9kPm4bsxVtKtPa7pIyc1qqCp3Ux+zCqC5dswDYYAZuVo0i
         fjCTeHuECaqkv71H2S8PTIpUeMaQWYRZgcQ9L7YHM2G/ZjR//NFJGRS8inGoVG2T65t0
         VorKOG8SCatb5GH2F2vlONzYC9Q+GSR9elNuTmf2r9NMnQnTd6W9jejM585RHUWB0iyn
         ODzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295958; x=1762900758;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TRuhdOoSSGipeIAHAxq+HN65/ys/fdjImQ5W470jiE=;
        b=Bj6f6fNZhAwUiWvq2Z/zH839jsnP5eubAzkma51DI3j5I49/stuFbNdL/xdP1ajk5f
         VpdCOIU6586/QwzJ1YXBnfpex+pcOmFJrPp/z4uH64AymOhKFUIwIdfuxgraNRG3mIb0
         n9S1TMXM7dzPHR6oNtsxLVUfQXgwTmqGpodfTbWjpCPG7B4w34CslRXtsgibwnpYfIDC
         tyAAwmdv4OLGMeQdOnE1TtD8TE9RgYEkzHFmRXDCAvS7UNZIgpq4u9XRYYP9yUgwtgfA
         /qYGhP93Pi/OO0Xympo3JzZaBYGwew/l6QZaZejIs7abFYudXr1U6ayUUtoXfBnkr9AM
         q7Gg==
X-Gm-Message-State: AOJu0YwIdffIR3v139u9bkUJG1+44uIR1bvyC2eoqFPnbVymwsT3OPpV
	IVakp1NvlIVC1kk5oXg1edNwIoooHGHEWNMOl3ieeVXD3mAGcfubpaIu
X-Gm-Gg: ASbGncu6XrVH8R3wfrqYX+3xIGD9YHodbWWTUss0S8qxnWvUQKC06hoh3PRUkvTp60U
	Qo7T4PDIQD/cbpRNouEmtF6tzFcIZg1D+dt2xdRpZuN9PvCodsPXiaZ6SoF/sH7lGTbJtwbMbJp
	jlC/qVC7fS3EfFlgOfe9uOxgj2FU+RzdFX21jOEmZtaf9uC8w3ftITtePJlWg0xMbxGKp9ZoZOS
	tmBsNnNzX4FH8rb0QsI2h8o6bhqZv8LcY7eWUna7Mq5vIydLc2LpXHWfGd2mXjZ6LgxGYxcUbD3
	B2jKj/j+V4xSI7qnLYVJc2sAFXKluFOqpUNVIBxuo6oCVQ7pTbzNhhNpX8L8sUsgQRL0abRNkgz
	AhKedgz6NFqwCn9z/Ky2nF/sLLlDJnJmb3MmK//brYpL46OT7ABEYuNj0DlboPOJTR56QEIwq
X-Google-Smtp-Source: AGHT+IGkcKOy3RYFgLwyd/NR+t0Lm3XzaO4mSqwdUYhsWqQ4Xq3qCSzgiAZO/1PlUw5asRlhZe6BpQ==
X-Received: by 2002:a17:902:d488:b0:26d:d860:3dae with SMTP id d9443c01a7336-2962ad83389mr16923805ad.3.1762295958422;
        Tue, 04 Nov 2025 14:39:18 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972a36sm39341705ad.1.2025.11.04.14.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:18 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:39:00 -0800
Subject: [PATCH net-next v2 10/12] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-10-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Testing with 1.37 shows all tests passing but emits the warning:

warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
	The following versions have been tested: 1.33 1.36

This patch adds 1.37 to the virtme-ng versions to get rid of the above
warning.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 3ba9a0dfdd01..0657973b5067 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -152,7 +152,7 @@ check_vng() {
 	local version
 	local ok
 
-	tested_versions=("1.33" "1.36")
+	tested_versions=("1.33" "1.36" "1.37")
 	version="$(vng --version)"
 
 	ok=0

-- 
2.47.3

