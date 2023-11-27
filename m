Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492B12F867
	for <virtualization@lists.linux.dev>; Mon, 27 Nov 2023 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GR2BZMMC"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2c59a4dd14cso48276271fa.2
        for <virtualization@lists.linux.dev>; Mon, 27 Nov 2023 06:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701096881; x=1701701681; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSEG4sTiIvOaqG5bPt1ilhvbIlmU0KB6Os6E4jKcDYY=;
        b=GR2BZMMCCNwouLpYZnTaPodTtMYAGEOl2e9d/pWTW0OxURp9d/JixYBt2wBQO27E1X
         x/YKj6a5zFTiDcX1mim/fXrKR5B3+yqS4vhecOqld49r4z09jWvaHUFBThwFpIy/dqI6
         cGn0/QNfreqWpDuRod3cWWhPreW2anjAluN+pfEj3DllmUr6eGJ4CGdeQjW+P2F5ejST
         4gk4R5sHykHbfgKyIDSjIYTZza0OzediDLckkrm5FuYZ7PUgVR7a42aI9KyzTY0yf+Ik
         HlJQPykNvqmKxdMBHPyxTUSW/7BhfedR9kW+K9iJ8SPddVoTWNpFvLUpDf6bh0mdeb5E
         pP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701096881; x=1701701681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSEG4sTiIvOaqG5bPt1ilhvbIlmU0KB6Os6E4jKcDYY=;
        b=Y4kIFUNqJJZ1/NX/AwFxjb2nc84W2dlL9oFvGsfNx+uZE+NE88uCip2M20JYyuYtf/
         3YG/jyazjB1oCORX4lQSQ/NoBs62rUI7sQEwRjmEAJ0xrapoJJfGoMEjMZP4IV5HixMk
         FB9TCJ0qwyDqerk+KTR+llWTC8DuN8PLhipF6jalfCXU/KGf5jHwR3aI+c0SYoipEm/E
         +mx9HsDNyh1gKSYwHv1EA7JDnKOru3PkuBzLHrxIYUpJp9VetbOtZajoF/zY3mFx/yK8
         yg0MqlyJDTvD/1S9bMvWPk5jEqTtB+y+/3C574HkzhVJO2ZwhbTqzzwh94EWUoI0S5PB
         FRig==
X-Gm-Message-State: AOJu0Yz1YLWFo8HuoEjGgKMsTbgNA8xHinRx0mjCy558a3+lRz0/cYzR
	NFCyCv1rlLzHjO+yNjG9XOw=
X-Google-Smtp-Source: AGHT+IHs0EIiKLSWsOIceGS/WBtO2H21E+asFh5ZpwSqtA9J2gylk2jPiKWwEEY67g6K+/9G1z/0YQ==
X-Received: by 2002:a05:651c:21b:b0:2c5:1490:1687 with SMTP id y27-20020a05651c021b00b002c514901687mr4916598ljn.33.1701096880939;
        Mon, 27 Nov 2023 06:54:40 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:158f:ed00:5d13:a893:4139:6a08])
        by smtp.gmail.com with ESMTPSA id z13-20020a170906074d00b00a0c3b122a1esm2888763ejb.63.2023.11.27.06.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:54:40 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To: jani.nikula@linux.intel.com,
	kherbst@redhat.com,
	dakr@redhat.com,
	zackr@vmware.com,
	marek.olsak@amd.com,
	linux-graphics-maintainer@vmware.com,
	amd-gfx@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: use GTT only as fallback for VRAM|GTT
Date: Mon, 27 Nov 2023 15:54:37 +0100
Message-Id: <20231127145437.15060-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127145437.15060-1-christian.koenig@amd.com>
References: <20231127145437.15060-1-christian.koenig@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Try to fill up VRAM as well by setting the busy flag on GTT allocations.

This fixes the issue that when VRAM was evacuated for suspend it's never
filled up again unless the application is restarted.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index aa0dd6dad068..ddc8fb4db678 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -173,6 +173,12 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 			abo->flags & AMDGPU_GEM_CREATE_PREEMPTIBLE ?
 			AMDGPU_PL_PREEMPT : TTM_PL_TT;
 		places[c].flags = 0;
+		/*
+		 * When GTT is just an alternative to VRAM make sure that we
+		 * only use it as fallback and still try to fill up VRAM first.
+		 */
+		if (domain & AMDGPU_GEM_DOMAIN_VRAM)
+			places[c].flags |= TTM_PL_FLAG_BUSY;
 		c++;
 	}
 
-- 
2.34.1

