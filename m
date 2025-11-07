Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4CA2FD1AA
	for <virtualization@lists.linux.dev>; Fri,  7 Nov 2025 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476605; cv=none; b=Z+jkGhmf6YXQEMiygHiyDAZDa5kzv3IKGe9WBADa9XsZ0u/NGXVovKDtX3yDxl+K40FimlRvqbiykZb+HsTNE+5pxH7YVGZWY+zkhEfgPCMGM3+Yy/ynohl8TW7aGCHp53T0FW3ooNXUbPID0/mjH05xDa1Is5xpxEHlSdWWPOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476605; c=relaxed/simple;
	bh=iMU473kfbxLIfx41vDd7YtatXvonwJ3nvGqIOn/zk5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kssXzk0kYXa4/NnfM8VNYoSR4VfraYb7744qJ6RIWtpQ1ZcWGaTB8Be2SX8qKIoE9JYZoR8ncqzw8UmARxSn3ZqdJ9rANlaYQaNlGfz42caKvbS4fmohzl18ZB1+byUf7ABM+nd1niaBOBa3ABwACHn9Wu+UG3AsnN6kwgbT/j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGiZIhg2; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGiZIhg2"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b67ae7e76abso119094a12.3
        for <virtualization@lists.linux.dev>; Thu, 06 Nov 2025 16:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476602; x=1763081402; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uegf6nxs6P81Dwl5DQm2UBLSV3f9YHB+8bNv996m32s=;
        b=KGiZIhg2GR1YGPypZ7qbK77l8VZtkxTpSkqbfyiCVzaZRsXaJWVvLPgtvgNOXhh6Wv
         6fNAYHLGCx/K4aaEJbcGLPB3rwpDQUTTRTURqRpuOMuSPQ4FGquXDPGYz8FeCWb0e59u
         a/q9yg/iMh3QDDnZaGThQQervpmAce5S5lHXu6Zuuhcz6vK0fsC5pZJTwMJ51eO4f3nW
         nuPSyVl7TZ4UD73xGvjHYdks8lGIsBAW11ykhLGk0hZOO7wfqqxRE3c7jEbZiwfCPJ5J
         BewbkPX9K7DrqI95+o/9zlQ6ZCet2S5ZjVFNnwKiOQI9Ttmu634+l0rC9X7NIwlgwu+0
         CRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476602; x=1763081402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uegf6nxs6P81Dwl5DQm2UBLSV3f9YHB+8bNv996m32s=;
        b=YfVaBv+I1SD1lbr6/4v5pvc63ITiGzirdaz6KZlHwH2Ho0QuTcm7sUFhl5GBS9BsRF
         yjNZOWZiNoCw2HrNKTkJPwQL1jcSlpIXvWYEDoIMuJyEy0d9Gu/e2TNfuDIqrGW+o9cG
         u2cvwnTnnuzdd5ujf5gQmyO3K3cwMvsH2/dKA7kujEQxpzZ2cB+2SWHHvsSct8utDcwP
         OY5PG2YLvNsrlshdny1DEbH/kVQPW5wKBQ9KWgiFoDeiaekIjp5QA8jshpEkz5a9Q2gF
         KwAMurmpxAJRgl2QksaEfcvyTEw7K/dGjl2x452rKkwaOFr2HaKP/3PUR5bjrGT0kREJ
         yobg==
X-Gm-Message-State: AOJu0YwVDeR1IKhB1PrPAFFv0WB7tPREUfRobxoQmPfPgJ6FhkTawsOm
	vNgDrUGXo0EYTJt77wrdzxqjSY73gOIst0UDyfefFOr1TQT16UfozuHA
X-Gm-Gg: ASbGncvDbTRhylySnLHqapRbLSVghAZkGALIe8Wwi8ufV4CKeFfo4n3GrT4rT5nXBiL
	ixvt2PwHFy9nzUVJY/AxbU6t8XXYAEF9kQM9eOrT3FCCF9rHY9Ipdp3d0Pf9jUi8MY606gCnP02
	ICUax0csEsNqIg92SnP25C6MQfGs0tWIG+LEss5qPeSAjmEL+Yv5GpdYznUOWpFnmuVJrInDTII
	29//hWNXxpNOlyM3U7oNLFfJpvWry6sH/qsws7zidEjpuu1GFgmBdnJGaJceP2nW8jIhByF+lN5
	Bt6DykZB8HVrXerDzi86rxYRpkw1d8So8D7x7R8tnNtj7wPZpemyFBVEq/B3p5fYgtrpWVdsyGz
	I7W+nty8Zzs9YbNGQ+igyfisSDayM7UUQQBCX5/+vH0em96AIcHvxefY0evPB2oQQdDJYwwzN
X-Google-Smtp-Source: AGHT+IEn4ofaJtpDiBFAzxzfLcnblypBsnuT/tfNp8v2pmgiedvOY3KtH3CWotZWmHCTlxnnmEILUA==
X-Received: by 2002:a17:902:ecca:b0:295:a1a5:baee with SMTP id d9443c01a7336-297c03d28dfmr16719935ad.4.1762476602405;
        Thu, 06 Nov 2025 16:50:02 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c778a5sm41166315ad.73.2025.11.06.16.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:50:02 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:55 -0800
Subject: [PATCH net-next v3 11/11] selftests/vsock: disable shellcheck
 SC2317 and SC2119
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-11-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

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
index cde048bd7fe6..bda1ad173ad1 100755
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

