Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C94188734
	for <virtualization@lists.linux.dev>; Thu, 14 Nov 2024 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598232; cv=none; b=cURLhmLwhL2o5+7LGa+gNl0fPy9Quk0LV3UzdEa6smOCMJp/bjhADzsrrx56tY+rKaM0jkak/CiffD5TY41dYvI0jgLrWtfD/DHkf4iB+idw1cmGOCX69vOU9iDgDJgaaJyh6K+H2EGCYzowC7PuMoxxANOpu2cEChsSBZBrXd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598232; c=relaxed/simple;
	bh=FQnV9Hl9qJ1EyPuhUgxDQ+vOp9eyLa87aO645v4AxQk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9cnx0wAjOOo5hKJ9nrhG/RApDn951IuFY6I88OzHTz+dI+B9vvSlgC4n5KhUzP/qpQqmH9Icp4UbIx42RVHCMZA4n/Mq9f05nZuWt3AAt+tffEmMZr4UWNHxY+Bkonoot72tRD7D9T3R9bDGtDCgQytF/Xmv7oqU8W4HQRiAeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8iGKi3C; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8iGKi3C"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa1f1f2d508so109470966b.2
        for <virtualization@lists.linux.dev>; Thu, 14 Nov 2024 07:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731598229; x=1732203029; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=es+F3M5SSYwvI4y5uEWYNZ4MyERHw7dt72hObBxhhQo=;
        b=g8iGKi3CJ6gd/sCd3EAPEJDoku53NXpA16q+sz76erj5yFb+lQZeneE+qQuwEJXJxy
         4x5y30eGpggB8KJgWO/KaJHrzMC79d+QBV1fiQJFthp/2Pt1NDcvtWhE7P3CLfVgzWFc
         B92mMBevs8kldPqfnESY8h2JFDnXVns1AMY3F1gJTCpVkrmt6bmoM4F3Sci9ZGDAth0W
         wcd05UsFu8lXSX4T/mw2SQvKS6c8/Bt1A/nxEP6J4utzx38LpHjuoGhDyDCfA3vSIPMg
         mE98XtBrn6okM/gCNoTVwPJCkJV6Ut0yQ8l56St/pfGlNj8ZMEXe90l4pPQu8Gr8IW7o
         MGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598229; x=1732203029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=es+F3M5SSYwvI4y5uEWYNZ4MyERHw7dt72hObBxhhQo=;
        b=bZM+VmJVaQ0W6IyosFMP/9fBlixl1dFoa9fNciZaFd0PZsp3Zm/CiaQKN30FFN9o+C
         E8bCInXQS2GfTD6yDdBhpEVjbdIJKwOKxakdGeU+nuFFrWSpUncFwbL9AURor6xdVNsf
         9pwPcipNe8XlsZA0doMwIqL5jRfucGM3a1zKt9F8LPl88RV8BMG403xM8ozXbzBneEr+
         OzVYOCB4s0UTWNgJitrmvJUzZXTykWgVZUBHZbjCwBNjThreKixtdn/T0u0YqVq2J7Qk
         tQ9Mk0PzMg9bFtenANQ4m2jvS1LO3gFRylw6Sbp4pq5pCyTlTfnXaVyZdY4UNxBBkSUd
         aWkw==
X-Forwarded-Encrypted: i=1; AJvYcCXz9VTFcDv5gvXjvJY2Pn6mg4cXl+n6SZ1yFEB064ClUdH5olBZhWdHr1VksfpIJQTzSBCEOn3wIC6C9gbfVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWiz0lIQXQ4fOk+FhAyEqd9hdS8XyUx1gkmBIibw281yL1ZTRr
	HMNV+EOTX+qYfXR9Df7j8e+mbRap96sO4qOLB4U5cXhHhzMkhZkW
X-Google-Smtp-Source: AGHT+IG10VBr9gvvw5qDFtZWGzbKJcUB7UabePBt7gF7vc2MTqmsgNLE1c1SwGG3/4/IruuC9U/80g==
X-Received: by 2002:a17:906:da85:b0:a99:f56e:ce40 with SMTP id a640c23a62f3a-a9ef0021723mr2489316766b.47.1731598229325;
        Thu, 14 Nov 2024 07:30:29 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15c9:2500:bb23:40f5:fe29:201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e046919sm74063266b.156.2024.11.14.07.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:30:28 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To: kraxel@redhat.com,
	airlied@redhat.com,
	alexander.deucher@amd.com,
	zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Subject: [PATCH 6/7] drm/xe: drop unused component dependencies
Date: Thu, 14 Nov 2024 16:30:19 +0100
Message-Id: <20241114153020.6209-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114153020.6209-1-christian.koenig@amd.com>
References: <20241114153020.6209-1-christian.koenig@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

XE switched over to drm_exec quite some time ago.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/xe/xe_bo_types.h     | 1 -
 drivers/gpu/drm/xe/xe_gt_pagefault.c | 1 -
 drivers/gpu/drm/xe/xe_vm.c           | 1 -
 drivers/gpu/drm/xe/xe_vm.h           | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo_types.h b/drivers/gpu/drm/xe/xe_bo_types.h
index 13c6d8a69e91..99196228dcc8 100644
--- a/drivers/gpu/drm/xe/xe_bo_types.h
+++ b/drivers/gpu/drm/xe/xe_bo_types.h
@@ -10,7 +10,6 @@
 
 #include <drm/ttm/ttm_bo.h>
 #include <drm/ttm/ttm_device.h>
-#include <drm/ttm/ttm_execbuf_util.h>
 #include <drm/ttm/ttm_placement.h>
 
 #include "xe_ggtt_types.h"
diff --git a/drivers/gpu/drm/xe/xe_gt_pagefault.c b/drivers/gpu/drm/xe/xe_gt_pagefault.c
index 79c426dc2505..2606cd396df5 100644
--- a/drivers/gpu/drm/xe/xe_gt_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_gt_pagefault.c
@@ -10,7 +10,6 @@
 
 #include <drm/drm_exec.h>
 #include <drm/drm_managed.h>
-#include <drm/ttm/ttm_execbuf_util.h>
 
 #include "abi/guc_actions_abi.h"
 #include "xe_bo.h"
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index c99380271de6..00ea57c2f4b9 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -10,7 +10,6 @@
 
 #include <drm/drm_exec.h>
 #include <drm/drm_print.h>
-#include <drm/ttm/ttm_execbuf_util.h>
 #include <drm/ttm/ttm_tt.h>
 #include <uapi/drm/xe_drm.h>
 #include <linux/ascii85.h>
diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
index c864dba35e1d..23adb7442881 100644
--- a/drivers/gpu/drm/xe/xe_vm.h
+++ b/drivers/gpu/drm/xe/xe_vm.h
@@ -17,7 +17,6 @@ struct drm_printer;
 struct drm_file;
 
 struct ttm_buffer_object;
-struct ttm_validate_buffer;
 
 struct xe_exec_queue;
 struct xe_file;
-- 
2.34.1

