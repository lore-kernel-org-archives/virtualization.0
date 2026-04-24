Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7060F3DA7C8
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038916; cv=none; b=EizO3kWUrf4YX3xiY4UhfnRs8xn2ml1iUZfeu1UMPo/nZn9e9432oiUNAkIIExzyKxbRaCVxdjLnU19pZRozdqOlUuEE/JT0poGxKPw7ZPKrTLm+IxhjmbHQAZLUEFhfWhUTT8wfRHWTLg59UC6UhqMFjpa14oWf+ut3Bta/oTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038916; c=relaxed/simple;
	bh=d4mxzTO2Ltl/eUXMBRQNyDiMx5nB3UU/ry0cuOPEU7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e6oZxn0Dpb+Jbv29yXxmp8SdcTAdoivcX/U+KJXytOd9M+jCaTipORJG1m4RnzFW3kzwKAc+wyOHu2uIBFrs7/P84JFXfqdhWR94upBClzjLRXYr3pu19IeWeIzijXi3nICXLhXQmST+OtrZZMwTZkO4flUxl/cdlhkSH3Rkz3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJPP5sYS; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJPP5sYS"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so6245472a91.0
        for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 06:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777038907; x=1777643707; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kMeiAHdTbFhy7JXd41HJZsYauWdI9RVH3tSuSNB+WCI=;
        b=eJPP5sYS5UfSSjqURtmPQsjACHcXc1OKNTgz8XPh8zLsNIucL/ftRx6Q0d8NsLjL8R
         yYs8YKE8NG9sLQ6nC2CDoz2zApqGYfo5dUrhD/KLeyoo0Nc3yWeHdCmL8QHFYPt6lHdx
         2R5bhhwROG1uFxzCD5g00pVs5h+gtKoMMcr9wZRBQphQ/X8pxKjDb9XeqyhCfe93FAhs
         G/0ZnOi450ayUY5fHE8h42kGpyuGjp0vJeChV5NlQa5YAEjzxsRLncjuc5kWY0BYYlxp
         VwQZ4eZTaeQanIBDNF858fOo2n6FEgGBDz8FhyOVBODXkPSHg4md/+Pvx9OQqfWvBWJO
         3LQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777038907; x=1777643707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMeiAHdTbFhy7JXd41HJZsYauWdI9RVH3tSuSNB+WCI=;
        b=RMhU0TIAgMyikiEhiCZMM82m3eB1GNAlYpR2AbpfB+lPztF58ynCdD5LlccNavfNVK
         u5xlgPOdnKCo2chYabHzDVLVMG2m4V9TQjgYYKR2YD0XdLMi0p4Pl6PNeBaSkugbpDv9
         JKimJ8qNQLI5o7pSLRDOIMXlpYopudymzGo4+p4HmZvltLiFIJuneLW0jr6d85MEgwP8
         Vl3w964UkMP9OQzNuj6dVTnULxFg7EiGM5lnqK9d0+ECr/gsGrL0jOE2n03mda4NOHlb
         7lb4qa5N2l4Ah6lTEDcZKSt/Lmj1xtEaY2c461qI/V03nyRF1M29Fz/FAx+zoqOw7nrf
         O5AA==
X-Forwarded-Encrypted: i=1; AFNElJ+s4cH3iJ8nJVVeX1/uFxUZuH+eNMnRqFU1LOOxf+zJsf+OOrHNU4XyJVCfEf7UOMGoiFJeFkcYt8+mA5BoWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywl6udDp1z/7euK874f3w4Uo8+yp8i3Ky/o0PG3QP9o1cSX4/nF
	RBqUJLy06/s9rDYgPSbkedcFGvkMAM28xIAOZVwBoTaUWqpV1tpGEiw=
X-Gm-Gg: AeBDiesZWAvBHgWb2RT9zTHzh4w459zOCaQ9qrTl2TqACzYyVdxilYOrgrlfWb5FvJz
	ckdWGDBmEVIA4hTi4h3fTWHK9cGMgdFFZ9wMhXHs6L3E07zo00oAgJx/mPZTQtuesZNoR/zFgw6
	5AGlTaqpoeoTllPt8Uw6lc5ACduk60/gOXLKpDPh1b1NBuK9Caz2FMSlGLTZQJkNwXh3azqZOcn
	YiVailB5ABNxnI9MlrhfkEFdjysmkojA9fSLQSf/7MJnDMhmjsBvVid5yypb3TPUxE+EzOGKZnH
	tGWWY0J1SVzTG2eVwfKzIm4ij6CR45a3bMz3ziBepa3S8EaNgS/ij2jdkZJs8pPGwqszlgN7aSc
	8eVLCGjUH8TMycK0OQurDpYdF/sab2D5t5ZtPQWZr08Hx6kjtnn5dJ2ClgBLtNlSUJrICihLXZD
	+xptH/wPSw5ie00BR3Su+VqNn+/zWB4yfJjwXMJ0MWnVPrtvtCUkE/k3PxbdNqU3NMbtnEYBtZk
	zYDzGFEILevogA=
X-Received: by 2002:a17:90b:2dc1:b0:35e:30bc:96e2 with SMTP id 98e67ed59e1d1-361403f1901mr33384481a91.10.1777038906954;
        Fri, 24 Apr 2026 06:55:06 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141990bb6sm24427479a91.17.2026.04.24.06.55.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Apr 2026 06:55:06 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bochs: Drop manual put on probe error path
Date: Fri, 24 Apr 2026 22:54:42 +0900
Message-ID: <20260424135501.18483-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bochs_pci_probe() allocates the DRM device with devm_drm_dev_alloc(),
which registers a devres action to drop the initial DRM device reference
on driver detach or probe failure.

The error path currently calls drm_dev_put() manually. If probe then
returns an error, devres will run the registered release action and put
the same device again, after the first put may already have released it.

Return the probe error directly and let devres own the final put.

Fixes: 04826f588682 ("drm/bochs: Allocate DRM device in struct bochs_device")
Cc: stable@vger.kernel.org
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/tiny/bochs.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 222e4ae1ab..5d8dc5efec 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -761,25 +761,21 @@ static int bochs_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent
 
 	ret = pcim_enable_device(pdev);
 	if (ret)
-		goto err_free_dev;
+		return ret;
 
 	pci_set_drvdata(pdev, dev);
 
 	ret = bochs_load(bochs);
 	if (ret)
-		goto err_free_dev;
+		return ret;
 
 	ret = drm_dev_register(dev, 0);
 	if (ret)
-		goto err_free_dev;
+		return ret;
 
 	drm_client_setup(dev, NULL);
 
 	return ret;
-
-err_free_dev:
-	drm_dev_put(dev);
-	return ret;
 }
 
 static void bochs_pci_remove(struct pci_dev *pdev)
-- 
2.39.5
