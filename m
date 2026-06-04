Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F28353EF3
	for <virtualization@lists.linux.dev>; Thu,  4 Jun 2026 05:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780550306; cv=none; b=jPz505+mq0IoQk7aBGLEVlXC0ekWu9wZ2MOC/a0M23gQhgRcMdYplTgioJPZjrPx3o4ZcH9lDMrrCKJ2adm8rbCmaxcmYlgwWt7CV3gPyK3n1JTS2V9S8AltNluoJEknPgbDSDGIwRzMHkqeRGG89B0koQeexNs6sF9+ppfjvFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780550306; c=relaxed/simple;
	bh=swCN0pyL9on2TRI3+1vBUIXQTmxVF54W3TG1qGC77p4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ICE0yIrhEsVTCeEwsY455S70xz8rgCvr1LbeU3RVYZObNUkuwWV24vpwK37wmpB6hSqzNc+L3tUZqCAiIyUOKzY8ASWvac1e5NWgQavqt/AQgh/K1eNejg+brXYenzD6dPJE0BszCLzdXjZrakWb4KrzLuE89lQmmOM20++/9Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgY8uctj; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgY8uctj"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36b95eb4bb4so164935a91.3
        for <virtualization@lists.linux.dev>; Wed, 03 Jun 2026 22:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780550304; x=1781155104; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzXAoL8G5yh9nalpFe2jIG9YHdbmlWG6e7G4yOR+whk=;
        b=MgY8uctjhAassXPP6Nx9YlNFa99f9+puFWISAgp1SJlf8zLhvTgecorz3FC44g66kr
         HPxgTgnB1NI/c6GJpma9LU6R7pIqKiNriytaJ3uqn6hWSC0vn+dwu9vo2q2goGLOGisY
         V0PCEaWDmYN9aqyr8vd8aP/dDlXNxeIy2FBegAyOv/baFY841621giumJcrffJbe18QR
         84DtRvikDbaV9sXS4qmjsQ4Vw+e3CVpELooyXBdn6tryLrQGoIo5TtWgfk0H93pLqtP7
         I4EkCtatMxWZB3G+wSx7xLyYMFsG+PnJ2IqMKHc9C+F6okm19g2CajuopoaOrssPS8X4
         OMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780550304; x=1781155104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VzXAoL8G5yh9nalpFe2jIG9YHdbmlWG6e7G4yOR+whk=;
        b=Vm3O0uz8AqxWhalPbvKGc6SwenODMdqMXCCVzCdmkpobX/C+UFuR8DX6n7bvMvQV8z
         BYDBkmCipEjeECQ9fdULyylmd4tUwnMFMGpxniT8YwgoD3mgUbR95bTy92zL1IVsEU9K
         ZcFHpDtKnxbUea6mZPIpx2BJ0xzLaLq/x6f/9p4yCRdUZGtgZbVuc7qLcfLh8m0s+pmv
         akXrFQezNvospTja9IChRDjE3k8f9QcjQKWIn2u9NbiEvtYqn9SHN2Dn/9sfQR7XnMCF
         WyZyOjFkwMcaWik2XBE5VewV62xgcU8ZIhcP5OnEZaaaJVAhI0ATOoJUO7wr/JsSH9Kc
         rVSg==
X-Forwarded-Encrypted: i=1; AFNElJ+Ca7v7gWKf2XaAVhn6cd2PX78hRLt6mLJLkz7hQTn8q0jj5ZtZMxJp47nABDtBcSJNPPkNkD5OOEqnjO4w6w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw80DMrJzJTSN0ApqolQNIUe3h6UwJ9yML+dv+EuafsqG8q5nzR
	xPu1eHP/DFo+gf3jC85QBm0xkEOUwKuoe4/pePjLsuf/u8grtUwBl0CA
X-Gm-Gg: Acq92OE31uveyl/Ylqh/nxQlyFpbABIykTMCwpBYUnzXKwUW+4jo54X+kc2yf0aGfWa
	JoFtE2WPEAbfyqkq7kzbH3Yr6Gmv8LWs8bdESetJV4wMKJ+WWHrX28MrWlU4450P8k6PWeI3Ff2
	amA32iEXuFjceZNIV2rxZoT3TTldBCg/CN1Bx5YkGUqFeqk6b7+rLctgczfKr84dDBdyzBYUwWM
	Xj+OLQjD72TauWf6x5sGf1VIQgYEaeLqqnsqP+1np0kUw5A/Vukn+hDHvIB7yHY3NE8SYzv6X3E
	VWNhKyUactuPyuuxmTvm5PLeJ90I5shQuJuNqufB/DjTckJS7ZQTHVoWXl/HUZe1NAxjUK4+Uqg
	cUjONUJbsSWpv2a/NEheujGyFTEMljzXbvKW5QEkERQp+HDIFoZ0cZZdHB+fQ2XnWf3+btSvk8h
	M0cQpQKF9Jum6m2B8zJM7bNl7o4lvzFVberxXQ3sliUbHflj+XpyQwJrwsUxA=
X-Received: by 2002:a17:90a:e710:b0:368:83e6:ca95 with SMTP id 98e67ed59e1d1-36e2dd4c595mr6569489a91.0.1780550304582;
        Wed, 03 Jun 2026 22:18:24 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf827e6sm2009262a91.1.2026.06.03.22.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 22:18:24 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jpb@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	Maoyi Xie <maoyixie.tju@gmail.com>
Subject: [PATCH 1/2] iommu: Avoid using the list iterator past the loop in iommu_insert_resv_region()
Date: Thu,  4 Jun 2026 13:18:15 +0800
Message-Id: <20260604051816.2976221-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604051816.2976221-1-maoyixie.tju@gmail.com>
References: <CAHPEe=G-FZvEXjkE+vAXN5MHXCtsOaUoKwg2RQL6m=om+c20hQ@mail.gmail.com>
 <20260604051816.2976221-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu_insert_resv_region() walks @regions to find the insertion point.
When no element compares greater, the list_for_each_entry() iterator ends
up one past the last entry, so &iter->list aliases the list head through
container_of() offset cancellation and the following list_add_tail() still
targets the tail. The result is correct, but using the iterator after the
loop is undefined per the list_for_each_entry() contract.

The loop only needs a list_head to use as the insertion point, not the
entry itself, so iterate with list_for_each() and keep the typed
list_entry() dereference inside the loop body. No functional change.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/iommu/iommu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 61c12ba78206..f9f53db9696f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -862,6 +862,7 @@ static int iommu_insert_resv_region(struct iommu_resv_region *new,
 				    struct list_head *regions)
 {
 	struct iommu_resv_region *iter, *tmp, *nr, *top;
+	struct list_head *pos;
 	LIST_HEAD(stack);
 
 	nr = iommu_alloc_resv_region(new->start, new->length,
@@ -870,12 +871,14 @@ static int iommu_insert_resv_region(struct iommu_resv_region *new,
 		return -ENOMEM;
 
 	/* First add the new element based on start address sorting */
-	list_for_each_entry(iter, regions, list) {
+	list_for_each(pos, regions) {
+		iter = list_entry(pos, struct iommu_resv_region, list);
+
 		if (nr->start < iter->start ||
 		    (nr->start == iter->start && nr->type <= iter->type))
 			break;
 	}
-	list_add_tail(&nr->list, &iter->list);
+	list_add_tail(&nr->list, pos);
 
 	/* Merge overlapping segments of type nr->type in @regions, if any */
 	list_for_each_entry_safe(iter, tmp, regions, list) {
-- 
2.34.1

