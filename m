Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FD33BFE33
	for <virtualization@lists.linux.dev>; Thu,  4 Jun 2026 05:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780550313; cv=none; b=mAywepOYxRLOLLVn8XU1pk3SVrMHBC4k1yq6UqzEe+OWCeSfG6c7iHanY+/j+wd82elq0XRzjhd7ak6kppSNsIy7ACVL/9BHsDgg8yTOiu5qMt6kyDlhD8auyZr6sSwW1ZeLUcC+gscqvznh/rk2aWmlpiU4be5egOR1eOHo+hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780550313; c=relaxed/simple;
	bh=s3eSFIhSroDbWAI1zZwjjlbEoJePmn4Sz3PrpBM79bw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h+YK6Hhd7N7m890+nc811uhtM6r5Z3LmfBELZnvtwFEKwJfPDTRecS0JGEvzOpBmngWI0ZMhGYCO+J9eC02GIMmXfBkCAZDZt63lplCC7N6L2FF0Q1w4QNVqG3L+gcN+/VlLvWTvF9UQDM9o2JjmX+rK3RB8zFIcYEx34hFEYT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvWMH54p; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvWMH54p"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36d9794d82aso160580a91.0
        for <virtualization@lists.linux.dev>; Wed, 03 Jun 2026 22:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780550307; x=1781155107; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umuccskTvPELH8yp9qi1ExFn7OMlDISJoOngAwbhXJA=;
        b=jvWMH54p4kKKktBazYOp9x3MnYePKk8Av708JDbaKdVnY8OU/SdvnxTFdm/5k0p/cY
         BYsGZFhv5/zFkRYYDvdLuRY+DC/SFMFQj+4LkF+1Rb93xj5scUG3a8iET5GUgpBsOXIL
         jrb+lKyKOud5I+ml473b1qGAj5zrE2Ht4DMPe0PWZwSb+m9AdN2+dBfljBFKilNKU9lY
         wenJUihpRxuI8Do7Eko0jkULYTEY68BawJve0VUrHayvxaJJkBRJ7t+W3B8DwwczRG7d
         t2++U1Zr5NEidNQFL6PZEZ6rH6GtYWzt2VJK0kA3Fq4W1Y07rHzdhUkEFJd9d8qAAkP9
         rieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780550307; x=1781155107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=umuccskTvPELH8yp9qi1ExFn7OMlDISJoOngAwbhXJA=;
        b=YjdpZgOwXSFS5uHSTnTxjimuvcy1Sq3vUNJRGD0U68eyw2zF3MXoFewRbYCzSzexvW
         fgafL5jmzgEXMfwTrFA0zmuwrGeA9qDcz/R5sKUDR3cvFaEnDE/XvcuIql3tijSEvZOY
         J8ixZdFDEpYZb28kX9DQUaeNFk/QU30QJeTjQwFDlnLL3nbYettcs6QTAixSDJs9daj/
         qdaZDpZUTK4D5NIEF+6FV/CZUQ3T7QUceA4yBpC27ORixjXnVHPlz8Im26fPDZAm/49F
         +2jW+gTiwXHSpmP48OR3H12/+LX9UIFnbMLZuP4DKXSjc+HjbwAyDSnoBrB5+36SSuQE
         a/Sw==
X-Forwarded-Encrypted: i=1; AFNElJ/anbCYhGU1syz5hEDl+nXTau/7aS3WE2udhxSw3QIivOKKAKTRM6pyrtsH6sKzSHEBFE3BytZtOq8PgLw+Jw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxm+ZF2TtuyQFt0K8BdSX/WU+dryZjceso5MZ2/9gSSPnlL/tDG
	lTS9MzJPb6HWmMl8fQcmIadpd2Q6ULhwc9tsBj/6XONvJyWmrCfhLAZF
X-Gm-Gg: Acq92OEQeiWBaBbr4teImKcaPPKTBNt4AqHUw+HL/yhbzRFLB+MJNOST4pE8O/a2jDZ
	NzGJkmlZrCTO+dkKBRSZRKL5ODVp10n67BcTpnR/DL0DNMa/c7lI6ilVKviZZ0lEHRqzgi0tCz6
	EGmbHIhlA+Q0GEAvc0KTESOK1LTlb5XxD2alRDy3Rg9JT3pmjJFn2zry74YxuK1ijhlGENxeLiU
	93NgOZEIdtuNCVsIl1sBGLVefOYXhcdDK9CoVRh/xF9mdvnLqwVIK25uDxRCjojf9N35YhtYwaq
	Q2SZxWUNWw1WGKnVF6uexB3Z5aQGrcgMsWsZE8OFEyXkbdqMwsClWAJD1ZENODnbEgepRnNjAqY
	GJno3grFvPTFYSXBmr7185GAeNmPWOhPV1lLAOIl05wV8LKiN28KB6RWq8xaDc6qOUqu2+DZ4ot
	zIxaYIGJ7MKAY/iXr0tSPtQPcRP8Uk5P3B5cM9XKjCfm35O1h/f9MzK+8lfbk=
X-Received: by 2002:a17:90b:2811:b0:36d:5dbe:2a0d with SMTP id 98e67ed59e1d1-36e30c23af4mr6513768a91.7.1780550307210;
        Wed, 03 Jun 2026 22:18:27 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf827e6sm2009262a91.1.2026.06.03.22.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 22:18:26 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jpb@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	Maoyi Xie <maoyixie.tju@gmail.com>
Subject: [PATCH 2/2] iommu/virtio: Avoid using the list iterator past the loop in viommu_add_resv_mem()
Date: Thu,  4 Jun 2026 13:18:16 +0800
Message-Id: <20260604051816.2976221-3-maoyixie.tju@gmail.com>
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

viommu_add_resv_mem() walks vdev->resv_regions to find the insertion
point. When every element has a smaller start address, the
list_for_each_entry() iterator ends up one past the last entry, and
&next->list then aliases the list head, so the following list_add_tail()
still appends at the tail. The result is correct, but using the iterator
after the loop is undefined per the list_for_each_entry() contract.

The loop only needs a list_head as the insertion point, so iterate with
list_for_each() and keep the typed list_entry() dereference inside the loop
body. No functional change.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/iommu/virtio-iommu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 587fc13197f1..1d58d6b626a5 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -486,7 +486,8 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 	size_t size;
 	u64 start64, end64;
 	phys_addr_t start, end;
-	struct iommu_resv_region *region = NULL, *next;
+	struct iommu_resv_region *region = NULL;
+	struct list_head *pos;
 	unsigned long prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 
 	start = start64 = le64_to_cpu(mem->start);
@@ -520,11 +521,14 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 		return -ENOMEM;
 
 	/* Keep the list sorted */
-	list_for_each_entry(next, &vdev->resv_regions, list) {
+	list_for_each(pos, &vdev->resv_regions) {
+		struct iommu_resv_region *next =
+			list_entry(pos, struct iommu_resv_region, list);
+
 		if (next->start > region->start)
 			break;
 	}
-	list_add_tail(&region->list, &next->list);
+	list_add_tail(&region->list, pos);
 	return 0;
 }
 
-- 
2.34.1

