Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E095A27F4E7
	for <virtualization@lists.linux.dev>; Fri,  7 Nov 2025 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476594; cv=none; b=auQrSKDxR1wYL6RdX7G9WNpj0Z3fAxRDUzAouxVeQbXz5wfzVIu7BnMSLJBBkRPlEL+igCVtv9y2LTrl12a7W8Lnz3ojHfFUakb94I55uxLZdakW0ZO1lzRDnsYRDpGDlEGBmtA78Tua5ikhJ9SjsoZnsWnhtxpeByL6wIV0Cno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476594; c=relaxed/simple;
	bh=579y5r6qisDyc0vXZIHMWG8pM549D8gpzJUlycZNzkY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rnP49LthA1Li1QSYg3PfqHYPQKN/tFOQsenZNAPKEBD0dtllu+4PrgVqiYyImTcwFx6Anv/QfB0F/pZCZzYIRFXLaWj8wh9SBMtNop4LRnSAHOBPivZ1N+/OHUNC3xZslRPKY8/8zFPPUZRuCwC36vmDx3hFatTdleqzya1woEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPP17h17; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPP17h17"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ba488b064cbso152112a12.1
        for <virtualization@lists.linux.dev>; Thu, 06 Nov 2025 16:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476591; x=1763081391; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xcUPU8X7KL1Zl3smrmhHQZ2OCBnQgt1CnJSI/1SUSoQ=;
        b=FPP17h1754myuXLZ7IC56YqoJYyA4CKpeRFiGgU7K4/YspneLJPYro0casSB4ILaEW
         uqiIff4pOsLLEThhYCw12RZwGrt0ainSigBScvpCCQ6wLADB2ILTjTLn1IE0nCKS2zSK
         CXxMePhgB/DczrsgSrENexS0uFC2GIfpUmXc1VgJEMPWOGzuhpiJ2w5qElR16fWWzn5M
         QdqN0lZ4xlt3SG+67AoG4F5FG8KQ9QOhqOQ7emUtkBXzcI6O6m8K1uIbWUURTkaFtv1h
         4a5nfYgFqk1qXvMguo4OVjmVEJ2bJri/kh3EHZo0gx39cLnM8rX1aHrCx7DL4itaQigQ
         8I7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476591; x=1763081391;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcUPU8X7KL1Zl3smrmhHQZ2OCBnQgt1CnJSI/1SUSoQ=;
        b=YFzDJbHNTUqD//8sVvKXVEey9z3PJe98p36gott3X0+tx8UwydxJSaBswD+8M8kXy9
         axvG7YW6/+wkVnCsQ0c1AyuaJ0b86NCcpLcC0Wn9pNsoX40qWIB1+qf+woj19d9lAq0A
         65CJDd7ShZLSRzEy2Xx38IprgCN5VUDyh/Gqqty+uo3wLFBg6jHIl9VCvSpv5lL5FDmy
         fo+IcP/hzCjtnwqKJTv/Rh7iMck4XUxxyXBJVg0onc57Ql+UoH1kP/e6VfdvkXIaOamA
         i3WRqW3VZJNGQVbz+3hqDJRuGg0UCpWbXejsl61MvohJUbhG98d/iAlSKX+4BAex3mop
         dh3g==
X-Gm-Message-State: AOJu0Yxxu7DV7LEgy++N62JsKnvCEh6EjG9C2c2tJakJRsfF4QJB5XrT
	BoDKB1amOpSXph4c3kbA87pjlFBRGOEniu+vzGjeMW4lkGG+e9WWS8hY
X-Gm-Gg: ASbGncvWFmpAn6NUoDhzq6WzRdx9ODtk060upI5msf8XOdyLWhKdy6exDvZEbs+irUQ
	sav6VORHvq9GDXK3UKvpc1QEHR/E7442Fj6TGfcnbMpwDimTxIl+JN4uxDjFjHw+oS4Rr3ot4sX
	3X9uOdgRYPWGkN/rMKLoL87vLuCjDVCAuCyspn5ripyvLJrAn6aGlUNjfOCr7JyvMX6d1qt31bj
	vaBnzWwzIXpct2sYgjzdTK6DrWMA2fKg8ilWu7ikHsIwPbyXx+kNzLpSSgdgRgaTRiAtY9uvnT9
	pNlL22wbTuUwX95mk0f/C3qNE4l++ouFq4oMKBgkll2jH3gIeE0L7+oqkVaTDMXU9b0SrSZvl7q
	hvx8po8KJc5FijQolIOLzrToyV9gPCLfQb4TK03jJ7xs3rdFg73m1Z2GPG1zoc3k1w6etlUpYnA
	==
X-Google-Smtp-Source: AGHT+IGVbNnnCv/JKP0L4AJIgAT7XYbbLVjx7tiV6GHUi/PF7nRC7D/K/BXQFE6YswbPc0qA9n+hkw==
X-Received: by 2002:a17:902:d4c1:b0:290:2a14:2ed5 with SMTP id d9443c01a7336-297c03a5f63mr17937825ad.4.1762476591127;
        Thu, 06 Nov 2025 16:49:51 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c8f07csm42074815ad.78.2025.11.06.16.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:50 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v3 00/11] selftests/vsock: refactor and improve
 vmtest infrastructure
Date: Thu, 06 Nov 2025 16:49:44 -0800
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAChCDWkC/52OwWrDMBQEf0W8s1+RZCcmPuU/Sg62tWpEYsnoC
 ZES/O8hptBr6XmHmX2SIAcIDepJGTVISJEG1TaK5usYv8DB0aDIansw2hqukuYbC+6+QIqwDw8
 Ij9FxWNacKhbEIqwPfddp7yfrR2oUrRk7SYP6pIjCEY9Cl0bRNUhJ+Xt/UM2+/8TsX2PVsOYOp
 771zs6YzHlBGT/mtLzT/7LBYTL9yR27Y/tru2zb9gLV0w7oMwEAAA==
X-Change-ID: 20251021-vsock-selftests-fixes-and-improvements-057440ffb2fa
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.3

Hey all,

This patch series refactors the vsock selftest VM infrastructure to
improve test run times, improve logging, and prepare for future tests
which make heavy usage of these refactored functions and have new
requirements such as simultaneous QEMU processes.

These patches were broken off from this prior series:
https://lore.kernel.org/all/20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com/

To: Stefano Garzarella <sgarzare@redhat.com>
To: Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Changes in v3:
- see per-patch changes

Changes in v2:
- remove "Fixes" for some patches because they do not fix bugs in
  kselftest runs (some fix bugs only when using bash args that kselftest
  does not use or otherwise prepare functions for new usage)
- broke out one fixes patch for "net"
- per-patch changes
- add patch for shellcheck declaration to disable false positives
- Link to v1: https://lore.kernel.org/r/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com

---
Bobby Eshleman (11):
      selftests/vsock: improve logging in vmtest.sh
      selftests/vsock: make wait_for_listener() work even if pipefail is on
      selftests/vsock: reuse logic for vsock_test through wrapper functions
      selftests/vsock: avoid multi-VM pidfile collisions with QEMU
      selftests/vsock: do not unconditionally die if qemu fails
      selftests/vsock: speed up tests by reducing the QEMU pidfile timeout
      selftests/vsock: add check_result() for pass/fail counting
      selftests/vsock: add BUILD=0 definition
      selftests/vsock: add 1.37 to tested virtme-ng versions
      selftests/vsock: add vsock_loopback module loading
      selftests/vsock: disable shellcheck SC2317 and SC2119

 tools/testing/selftests/vsock/vmtest.sh | 355 ++++++++++++++++++++++----------
 1 file changed, 243 insertions(+), 112 deletions(-)
---
base-commit: 8a25a2e34157d882032112e4194ccdfb29c499e8
change-id: 20251021-vsock-selftests-fixes-and-improvements-057440ffb2fa

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

