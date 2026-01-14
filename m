Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E491337F8C5
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380774; cv=none; b=N1hkGShIZ5mjZ1hQtOYEllGjg5m1kFTeGHZXcDTCVuq+YdFFrAbOqzXr2QvVL7TTi1TQWFSIOOIGSYxEKV992l3Kufq1t8tphBFqsYNz6vgeRfp1Xfo25AgRQnRgU88oOZQvGA5xcGhBjQS1MWIpNI/mW5FjLEej+3K3D1tm0Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380774; c=relaxed/simple;
	bh=IRkGW/+6U9xZlWhzp6teA03oy5t+nqHjZEeiuztKzEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIsxKEXFAIfdSmlcP5v2vaEYHRt9fu2qxlIsGefJ+zjrKJZ/ak98btFj/73u9ybrr66/kRNPW520Y3mUiRuu3OTW2d06yZww8/vC5WI5fMhXcGtJmXAdnv4z5VDbuzHa0V6ud1EP6EkswMmuXRytOEeED9/mgA5zGMPKxjMHFgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Mh/62EKo; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Mh/62EKo"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5014db8e268so3047341cf.1
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 00:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768380764; x=1768985564; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkgGAvtlp4w6GbvGEuWsv0IzEAPVl0Fov3QmaIKpKpw=;
        b=Mh/62EKoP5yYOREZoWsN3DlKcI0LgG8hAe1ooWRClRWGVjlRSTsdHoru9YgxuyoNLt
         ItNRLOBrWV4oFLB6mB+EAwdYDAvX8MOZ6/UyiJoxVog+r0QD6QJKUkyxOsxFhubCR9xc
         gE9C7d2eunThSMLIz5lwwRQdOr+1+m7B8/dLbNevI1aYdmKxeCASyRzAfugaw3Prwg3t
         I5mULsBVl2YZ1UlgzDS6ED24fgzpQSyGL2je3w5OiuBOdXp5TP+sno12z3WClQ5KNerH
         O8jAVEAwlLGCehnIkwwABzsAM4fekh65YcpOCNPNafpSyGEHfhMCMDMMMU/+Su/JGUl3
         HV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768380764; x=1768985564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AkgGAvtlp4w6GbvGEuWsv0IzEAPVl0Fov3QmaIKpKpw=;
        b=qQ8BwsUnd/ES+fB+1nSV+No1Eta6aIyiXLkFYJeZBBaVKvAoiZj5G535jaVeR+4iOZ
         C9/gAK5BUmtMO5Q7YAoime2N00UvlN2nCSMqonGh9sJRb1QsO9fIzIdSaiWcsIFgY3pQ
         GQg9G3OzE8jeUhcPjObdQ+qzcpyUamIo7yM+3xuO6lYSfgDv4uH6KW8LO3OTirg+yOJX
         rUK1+6F5Vv9x4z1Px1nqkatRPy91FFulVHMgwhUpDC5FGYe49neCaZbhBEotg9pbEtpN
         o91pzqdWSPX9r406sqH8SNM0knQQiBzp4kdvwDZYoeohwk0CNF1IjgBguhXXn1p9L7eD
         66zg==
X-Forwarded-Encrypted: i=1; AJvYcCXu/L+aptFc/If6mzk/QZHPaSweziukWjru/N582XhKax2Te9BqYA6ZjnPnbxHPqqh2IXV36qUsce1lRFaK2g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxroy9ktJkm0x55gZsDKNBob+Yio7LzIz5kvESVZ3J5kUAlNnIX
	hflx3JkRyRO+rfGcD0mNOgtWLsf75VOqvJ3uIs085/aa0ZfKeRXL1sJ56ZCCoKPyBDEaPoQh3IK
	bC4rnZ+4=
X-Gm-Gg: AY/fxX4RZJEmJfTZ8igOAy010p6rCqkIh9WZlU0jLBmqylP9tCKxtRmWxOStXamoZ3w
	LhC436wsCca5EBL+cbrvg8cXm+BhVK4X4F5PS6qddXgrdPaTWYYtF1aQqLWBiK+JbyY2oT4nD2L
	pM1vk0qk63jebyPt+PpbT4y4EwlzrnjfyZbxKUku9Bk/ZAgvhzofJ9BjYf2U2Njo33lYbl+MFEI
	zU2u7kc13CyOof0wjgKBbe9EH0adEf5lSE13gO7h22x+n+S2UNGlwV3Snw/TCJSBY8MvTNsT2rq
	MZmlA8/rFRR+U6X48F8jDvim6U8pK3H3LlBHeC3Yzw3h48vcGg+55C2oWhOZriZPUelsljgHxlS
	H56HMpjp88ehD89yj+J3HQ7I6fu5NMrq6jju7vQsAJ1AafNtVMDi2LY0HbcrdyAMV29LpfaPlR1
	ZpmFeIdCEASj6c2Nh4NDw0CSBWYcKiz9WZblmRu4ZOdgfw3eO1cZNGAgjUuZ7ZY5+T59ZkL7/H7
	rg=
X-Received: by 2002:ac8:7dc1:0:b0:4ee:ccd:7215 with SMTP id d75a77b69052e-501481206a5mr26400211cf.0.1768380764400;
        Wed, 14 Jan 2026 00:52:44 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148df8759sm10131931cf.10.2026.01.14.00.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:52:44 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	david@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	osalvador@suse.de,
	akpm@linux-foundation.org
Subject: [PATCH 6/8] dax/kmem: add online/offline helper functions
Date: Wed, 14 Jan 2026 03:51:58 -0500
Message-ID: <20260114085201.3222597-7-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114085201.3222597-1-gourry@gourry.net>
References: <20260114085201.3222597-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helper functions for onlining and offlining memory ranges:

  - dax_kmem_do_online(): online memory with specified type (MMOP_ONLINE
    or MMOP_ONLINE_MOVABLE) using online_memory_range()
  - dax_kmem_do_offline(): offline memory using offline_memory()

These helpers use the memory hotplug APIs from the memory_hotplug
refactoring and will be used by the upcoming sysfs interface to allow
userspace control over memory state transitions.

No functional change as these helpers are not called yet.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/kmem.c | 103 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 5225f2bf0b2a..30429f2d5a67 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -190,6 +190,109 @@ static int dax_kmem_do_hotremove(struct dev_dax *dev_dax,
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
+/**
+ * dax_kmem_do_online - online memory blocks for dax kmem device
+ * @dev_dax: the dev_dax instance
+ * @data: the dax_kmem_data structure with resource tracking
+ * @online_type: MMOP_ONLINE or MMOP_ONLINE_MOVABLE
+ *
+ * Onlines all ranges in the dev_dax region with the specified online type.
+ * On partial failure, previously onlined ranges are rolled back to offline.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int dax_kmem_do_online(struct dev_dax *dev_dax,
+			      struct dax_kmem_data *data, int online_type)
+{
+	int i, j, rc;
+
+	for (i = 0; i < dev_dax->nr_range; i++) {
+		struct range range;
+
+		rc = dax_kmem_range(dev_dax, i, &range);
+		if (rc)
+			continue;
+
+		if (!data->res[i])
+			continue;
+
+		rc = online_memory_range(range.start, range_len(&range),
+					 online_type);
+		if (rc)
+			goto rollback;
+	}
+
+	return 0;
+
+rollback:
+	/* Rollback previously onlined ranges */
+	for (j = 0; j < i; j++) {
+		struct range range;
+
+		if (dax_kmem_range(dev_dax, j, &range))
+			continue;
+
+		if (!data->res[j])
+			continue;
+
+		/* Best effort rollback - ignore failures */
+		offline_memory(range.start, range_len(&range));
+	}
+	return rc;
+}
+
+/**
+ * dax_kmem_do_offline - offline memory blocks for dax kmem device
+ * @dev_dax: the dev_dax instance
+ * @data: the dax_kmem_data structure with resource tracking
+ *
+ * Offlines all ranges in the dev_dax region.
+ * On partial failure, previously offlined ranges are rolled back to online.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int dax_kmem_do_offline(struct dev_dax *dev_dax,
+			       struct dax_kmem_data *data)
+{
+	int i, j, rc;
+
+	for (i = 0; i < dev_dax->nr_range; i++) {
+		struct range range;
+
+		rc = dax_kmem_range(dev_dax, i, &range);
+		if (rc)
+			continue;
+
+		if (!data->res[i])
+			continue;
+
+		rc = offline_memory(range.start, range_len(&range));
+		if (rc)
+			goto rollback;
+	}
+
+	return 0;
+
+rollback:
+	/*
+	 * Rollback previously offlined ranges. Use MMOP_ONLINE as a safe
+	 * default - the original online type is not tracked per-range.
+	 */
+	for (j = 0; j < i; j++) {
+		struct range range;
+
+		if (dax_kmem_range(dev_dax, j, &range))
+			continue;
+
+		if (!data->res[j])
+			continue;
+
+		/* Best effort rollback - ignore failures */
+		online_memory_range(range.start, range_len(&range), MMOP_ONLINE);
+	}
+	return rc;
+}
+
 static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 {
 	struct device *dev = &dev_dax->dev;
-- 
2.52.0

