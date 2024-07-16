Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114501991C6
	for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 11:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129798; cv=none; b=EDHX/ShrAa5fFt7eYP7lZ9VmbrybdxjlpKijYoMRO8pTezpdMTlHkjqsqfIVRG0lAHWykYNaA2ZBVZsyR8dby9dyeuPCnFSt8uNjXu+xdDtJalxalKx2BD1mC0q9AyvPNlVQjG4Kqe/QZ9q6Uc1p0s8WRwp8ZYsXf7BVFqLjpNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129798; c=relaxed/simple;
	bh=LWDlMEL3q2CLkvkRbc3DzDqtIlr5TYSnTN5v6PupEbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZClXigCq0SJfCfh/RB8NQsUXVrIMfXdkmH16HmVZKEgRuso6ZQoSFsljbH9JiYeX36ILFlzb2HIV3XZ0GfXiXjqtVl/TQw3s61qUfgE1THX1SDlrWcdg7Jw0TsPumRpGGmiSeBBoCx9p05NO2kSNa/hhtSL5a7mwtgYYQntJxw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=RgZMYWrI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="RgZMYWrI"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4266f535e82so36317395e9.1
        for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 04:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721129795; x=1721734595; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZgAFN2J7v1Ck1e8Ny+UEVR7J9wkZJeG+enVi8Hy13Y=;
        b=RgZMYWrIZnPruzM56I4M0/6Uh8jwQV2SWs4qt57XDVveWz7VnmAdvnLO9gX79N03lq
         194rQ2BjLG9/cvz/41djD7eJgyGM3b/bsf1UEW/HpdYK9NEHwplTby1mMk6GHa23sd+x
         V7S3oPjhHQuMFHAUxPgkvFGvvI6vz93D9FeB5WupwXIyaRSJbuHuSFIjt3zoE6oaDi0Q
         t7at7ouXgKMvE8Nhepdysw57czClTpvXyQbgN1JR0J1Djfx4sP9a11skmgmOwK4A22Z7
         qTdyS7+PIv7TLoyoxpVEA87sG4nYKSjTbcl/uskv/vVkXPOGSkGFxumHUaj/Qn53e1E0
         uiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721129795; x=1721734595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZgAFN2J7v1Ck1e8Ny+UEVR7J9wkZJeG+enVi8Hy13Y=;
        b=RmGe9qqPq9TKry21C8xN0V5ZmY4lJQlaFxU/wKA0WGiZ8LLKNPO1DTlGdnOeZjke7G
         VomKh8GVjyHGqyE+qiaPTFB3KO20d0LFdGMDXE8s5nErJ0Iniquf8vOv1G9/4dj0t2hX
         aW4LK8mYC8kttkmbU7mRk+DyZc3OdzEoMY6/BxPLzGFETXsq85lMYN93zCtxLkecNpBV
         VhKCjyN93B7BmT99cuelKIopi5sJcAWHxxUEMH2c1wSR4XBZBd1ICWo4hR0pOTLcPX2A
         YZWVO7qyCUqqrjVR9BeK8frO2R7eod75p3ob4YsX+TazS2gdav7I3gudtguIuA+1rb1y
         ZuxQ==
X-Gm-Message-State: AOJu0YxaZA+YIqVlMRHlcMgBIoj+MI9JqmdkosUBj6yHPJKxEg+RFmMj
	x8lnBq2lzFsnHOMh8lWQUqtGkVSbeAXSHHy9O/xl+OKcDDLLXnoOIkqrvw2sQ2r+tl/7lluzfcK
	6+T8=
X-Google-Smtp-Source: AGHT+IGNlTsnSr23Nf/Z1nWv2dMWFC++U6q6aGjRI3tAPyyKINX5ryxBVDBMMNOOH3XiTOXMMGTJvw==
X-Received: by 2002:a05:600c:4f85:b0:426:5fbe:bf75 with SMTP id 5b1f17b1804b1-427ba6af69fmr15621835e9.23.1721129795576;
        Tue, 16 Jul 2024 04:36:35 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e827efsm124493355e9.16.2024.07.16.04.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 04:36:35 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 10/13] virtio_pci_modern: create admin queue of queried size
Date: Tue, 16 Jul 2024 13:35:49 +0200
Message-ID: <20240716113552.80599-11-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716113552.80599-1-jiri@resnulli.us>
References: <20240716113552.80599-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Don't limit the admin queue size to VIRTIO_AVQ_SGS_MAX and rather rely
on the queried queue size.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/virtio/virtio_pci_modern.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 5ceb4b2c18df..a649c9dc436d 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -550,8 +550,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	if (index >= vp_modern_get_num_queues(mdev) && !is_avq)
 		return ERR_PTR(-EINVAL);
 
-	num = is_avq ?
-		VIRTIO_AVQ_SGS_MAX : vp_modern_get_queue_size(mdev, index);
+	num = vp_modern_get_queue_size(mdev, index);
 	/* Check if queue is either not available or already active. */
 	if (!num || vp_modern_get_queue_enable(mdev, index))
 		return ERR_PTR(-ENOENT);
-- 
2.45.2

