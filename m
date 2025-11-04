Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E518347BCD
	for <virtualization@lists.linux.dev>; Tue,  4 Nov 2025 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295960; cv=none; b=Rg2yrU/zHR9DYESWqhiat5PQhwppOnl7bMSwFumf1GzSHthw2Tnu+9UtlQoU7lwsJ7LvyY6KqDohLIvZMbJMYmFOWVIbJX4qwpw+2Xv1NMQXwLz1WeKESyVPw2o4RfoYzUIeb4NMjtFmiOWoAF1kdlcsfBwFosWfWMvNVSdgvLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295960; c=relaxed/simple;
	bh=7hS5R8uladJKmxaJNfzO1x6DQikjdO3QEQ54fQGP0Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KSXXGxjyMi7/k+FxB8D09RE5XJUSKDiOhe/pHNxxOplDzTIJIt5sjUw9CFrZbTK1J/B01VgjxwYmd53clPHJLAkCq/o3kLFEiwRECAF57R+/3+dFp6Pc0KPAmzGaZWPoDkdcQPxq17nKqlHB2lOrm8aoxvT5ZX2E2tg98UA6rB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKr4BQec; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKr4BQec"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a9c64dfa6eso2629314b3a.3
        for <virtualization@lists.linux.dev>; Tue, 04 Nov 2025 14:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295957; x=1762900757; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VT1vOKbccZAqGQoV04Y8d/n2OP/f/9vyCKaFedGSLY=;
        b=PKr4BQecSsBX/pTGXPwI/FkbjuNuEbXUV5UT6fC60KdYFs63HgZm+bRMXMGpOMWsFs
         8eHYzfEBfre6S/eprJ3uYy9zT/nE5THd4ZeNPqRSAkX+l1bAuMDiDrU7Z/IsBXK/z4On
         F1MxHHxQotEAE8WlL+TalLwQdIjEiHUWjruS4YD2srg/WEvWeC4fyRwtN84eP425mtq9
         eu0sJmiPUr+0UaUtCx7i7hy+um/eErsQVPfE+FqsR9SVApKe7xXgBq+lg4t1sa4qapNL
         TXWfHtn4xZMTxur3iNSln01PPmgMj4HyfNzsxFisG1/hQO6GFODdgxO1JxXNR+4ux9/k
         2GFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295957; x=1762900757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VT1vOKbccZAqGQoV04Y8d/n2OP/f/9vyCKaFedGSLY=;
        b=pY88g0m0/bLlZG2eQBY8Ne/5qFTbn2sSyq6p2TgP1WzkMGZtoas4LSsRp6GV1JC7nt
         71jt8n7sFO0PvFkM6Xj9WFPIm35QsOWmVs99DFFUvKycF5LN6s/UKsF2hSpdXl9ZNSQC
         lwRNQ+dkyIUoHRqfmMcWy5N6nXzFhAjPcczn6I3Zam++oYFwguDuwrMQzWkMSeUXVn63
         6Kp25cAwPBcYziGdwkN3rcOhio7uQ+WbaMCYF1DfVeW+hZKTvUTk9HbaKB46jzulvEqt
         SjoD6gxurF6X1qHOGX5xaNcaiPYjEvZQGk0ravrFc2AJF9g3r4/VMB/KABIL022GAvio
         P0GQ==
X-Gm-Message-State: AOJu0YzLxMQvq7XrvWr+1rQlMcz/13Masw8X7tKIcLgxXLyPblgBYfzS
	ayg8IvEl8kThRlHrRDd6Rr/B93HeuQT+TfJWlDtz4RBoSwGFj8RR81Ey
X-Gm-Gg: ASbGncsvXQFxPCPafONm8mfIJMkTj8RA73pDvPjck8lVZ37jHhKHGSQiet+vhjnBw8Y
	TJ/GTkrLnDlRm4F1poJcKwZTBsGQ6J3uPFRJHzbBoUZfGGNIBHRPU7qnXbdLwKC0GISvUmTVrdm
	V8slBEhWrj/juhssgLsMAD840EM/pJKdw4GZR3dC9o6RmcJiRyopqwHR42veABNQXFRY9PmuBfk
	m1j+z3I8g5+ASQCOQXoF07fF/xbNG2hNYYQnBIe4l9SNFjmU4QVxTVm2I6GWlpBnRF8rHDiG2UM
	uff9qaaD0XODVzTO0oU4xJdJ/uHOoT8acmZnjcXXfIXnr0SlrnnKCTTcg/YEFQjDPXC8wrXUsWU
	EV3iAZCzD9OHVoQMYrhETuWpbkzPS7cN7WDrtJFhf8nVyq/5iOnMgUibDSqPtpiE2W9tF7VHt8w
	==
X-Google-Smtp-Source: AGHT+IEBJAtsIuttdN50ovmDUWQDLmggku0Oz7uskPksnqBRyI0KQxzEkePGlcc8A5fgJ1MA9GtMgQ==
X-Received: by 2002:a05:6a20:914d:b0:2f5:ba02:a2a2 with SMTP id adf61e73a8af0-34f853f6c97mr1247028637.36.1762295957592;
        Tue, 04 Nov 2025 14:39:17 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd392040csm4046430b3a.19.2025.11.04.14.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:17 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:59 -0800
Subject: [PATCH net-next v2 09/12] selftests/vsock: add BUILD=0 definition
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-9-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the definition for BUILD and initialize it to zero. This avoids
'bash -u vmtest.sh` from throwing 'unbound variable' when BUILD is not
set to 1 and is later checked for its value.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- remove fixes tag because it doesn't fix breakage of kselftest, and
  just supports otherwise invoking with bash -u
---
 tools/testing/selftests/vsock/vmtest.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 678c19e089a2..3ba9a0dfdd01 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -530,6 +530,7 @@ run_shared_vm_test() {
 	return "${rc}"
 }
 
+BUILD=0
 QEMU="qemu-system-$(uname -m)"
 
 while getopts :hvsq:b o

-- 
2.47.3

