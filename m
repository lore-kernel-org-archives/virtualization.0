Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC7B313E2F
	for <virtualization@lists.linux.dev>; Tue,  4 Nov 2025 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295953; cv=none; b=EVTxnzhCIc1AIizSHHQrdX6N1hCGGbT82NkeQidiAnlaNzBOB8qV+bO2r1qMMA7LzI5T/zcaWQEbJUVt0Q76Ne7e9Xpt5H0IBcWtLC2kcjBQM2Qdwx/23LjQUDH9PK8G39XQNwtIMbcUeBWVZZtzWLg44d2ZL+uLcGpAVH8ha3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295953; c=relaxed/simple;
	bh=MP2KoZXX+79Mi4EOxuj0JaxBOJBdoc+sCYGsGHNCwUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=murqO0GS9nyNhdMqy75s4ZCAGePriZExhwwfUkmpRRIy9fD5MTcLbEqgSe0oK3KDt2CAp9Yt/i9ry4wOmzv/z4qoV/GhJ9n5U0doAhGxHFruHyXB/0ADUZnLP1ef6h9eREeWFJ2Crh99AVuGsGLLQgVLkzwtkXw6NrZUn0xPo9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGNrUjnV; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGNrUjnV"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b679450ecb6so4591117a12.2
        for <virtualization@lists.linux.dev>; Tue, 04 Nov 2025 14:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295951; x=1762900751; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2TtF77uA9Y6v8jmRi2a/W5oTLXZ//NRPnuqn89vDsU=;
        b=JGNrUjnV2dKQ54fOaxqGDxxAYSltP6juJHVCQYdajPw+IYPH2QTeh5toA5YpzYwZCf
         2KXxKQ1hNj2EJz+RIe4hJBpCeanOpHZ6WUHoVFpu9kmUWwTD8yV4CcXCwgcE5F7NIiQQ
         2mhRt+IC3YwTfsScnmW47SHEul6hre/lt8/h19Xbc7ENd7qEKAeGiLs5TkteadTZr6Ff
         1XnqbzRZAJ/f7lFObQvy5NYWEjMxJmRhMJ4jFXnHscawUp04TDzD0MdnJLvGwwcYtr7d
         xM//KtVjIjTmH1XjE63s9rI3c85iuMVYvbhnY7535LXMpNySzBiMVv+o99+eIwb78RPg
         Qhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295951; x=1762900751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2TtF77uA9Y6v8jmRi2a/W5oTLXZ//NRPnuqn89vDsU=;
        b=EOXWKWZpmkBU49EHsu9DxSlbR/QhR8OIvpMWi24BVAq8Sbsi+lyK3PVOhyLvKVX3zy
         n/qBKfOgRwPNQbhuX6XecRwtGhS2PVYUJ4aVMjMVUZr66EE3CQtELqVymMPdEddNpUek
         aXj5tjyTaaBmc/yoQR+ciH37Cx57IrarcdtZjbMnZKBd0dSvSTDmK2YLXUaJLDpWNm1x
         e06OtQyxMkeUmMOK5q48m+FmnWgnP7DeLg9/LZZcqtGEFPrC7uKGuv3byHy9Bc9LmLbJ
         5ATImQIjOdC2jnwz1dzUBvO7udkyX0kAYRg53n9QR7JEIp46Xs21kd4PFlj9bJtOOKPZ
         dpAw==
X-Gm-Message-State: AOJu0Yy0WgnMeZanmg98PBIA6x7ln6/NXe54kM1oWlGTga+HYFUOS92u
	t1s0vSJNDgC3t/Wb2MmHUHR/rIbqjaaMzdluWdQGTl54JKKL/hF45RQe
X-Gm-Gg: ASbGncujSeIYjbNxL8Za7gubO7fqW2LTv+sWon8ZSZmj9olg3VBpf8tWkYTfFp5rgmy
	abHg/z2NgTcML8tPu4DZBgMBW4jRC015iMmjlt4RTij3EGfYoZXicbl2zBaMRdGTkRK4jJP0Skb
	r5aJPErcoMGYsAVctxrdnqOngsXiiDatII6CvQ/RHeGrd28iKrHhY4MmNILLjdqlwjlHEiqiU9B
	c5mBeSb3L2CCm5Pi13eYs9hYlBPaep6PFYKn9WKbleBCbpb/XTQ440vSxl2Yixns4ZtU0w1fPqm
	m/gnl9ft42ArHOnxzzuR4znpxmbhQIm17nzCUJcPSkg/dYfktLVEKZPcNSvz1WqD6pqzCh28LOy
	QTThLmHJsSdjp2R7HcXSYTNnAKQi+zOF1NmlzFGzZDyFw4yoPMjVvrFO7BeA+y00bSABURodv
X-Google-Smtp-Source: AGHT+IHjLept3ve48AUPW/GiyFbQHZFSoms2OQFSZb1ZP3j5dSJ+0pBWFTSSrVMg5PH2kQRmlJsbhw==
X-Received: by 2002:a05:6a20:7483:b0:34e:63bd:81c1 with SMTP id adf61e73a8af0-34f839f5a57mr1249874637.3.1762295951213;
        Tue, 04 Nov 2025 14:39:11 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd324680asm4163732b3a.1.2025.11.04.14.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:10 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:52 -0800
Subject: [PATCH net-next v2 02/12] selftests/vsock: make
 wait_for_listener() work even if pipefail is on
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-2-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Rewrite wait_for_listener()'s pattern matching to avoid tripping the
if-condition when pipefail is on.

awk doesn't gracefully handle SIGPIPE with a non-zero exit code, so grep
exiting upon finding a match causes false-positives when the pipefail
option is used (grep exists, SIGPIPE emits, and awk complains with a
non-zero exit code). Instead, move all of the pattern matching into awk
so that SIGPIPE cannot happen and the correct exit code is returned.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- use awk-only tcp port lookup
- remove fixes tag because this problem is only introduced when a later
  patch enables pipefail for other reasons (not yet in tree)
---
 tools/testing/selftests/vsock/vmtest.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 1715594cc783..da0408ca6895 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -251,9 +251,11 @@ wait_for_listener()
 
 	# for tcp protocol additionally check the socket state
 	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
+
 	for i in $(seq "${max_intervals}"); do
-		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
-		   grep -q "${pattern}"; then
+		if awk -v pattern="${pattern}" \
+			'BEGIN {rc=1} $2" "$4 ~ pattern {rc=0} END {exit rc}' \
+			/proc/net/"${protocol}"*; then
 			break
 		fi
 		sleep "${interval}"

-- 
2.47.3

