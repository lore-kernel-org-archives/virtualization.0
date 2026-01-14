Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E19A3816F9
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 08:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380770; cv=none; b=ULRY1++c3C6YAEyjRkIqz+DB22ReUALJGQkjKQtG58diVUXkCfCOQBroQCGJmYUfg4X87t9fRJiVjrjPy53a7Dpy3XFbDo37YQjuFr46M8OhcHUbTHI4KBwlEJhxld4gJBp5rKiW/AF64juNVtnT16e5gE9veBYASviIGDit044=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380770; c=relaxed/simple;
	bh=WuxU623lbbMTdGzzm+5bCzIY7yeXdH6a4+PbwDkCxIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYu1t2kr3pArxCTm51qYHuCLzS/upFQ9UmM50E/u6JnX8pph1TsWmeLcE9yLUEPYs6g4cFaZfXYuGwm2Sra9Fu7ooUo5Ff/kYCTxsEBOg2B8rM9Nq7yNbvFKlXSY3jrtgsRfBWE6deCTMg2mtZfGUZW+dG78Yb79dTU0GeC0Bj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=OoCXDXdd; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="OoCXDXdd"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50145d27b4cso10547291cf.2
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 00:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768380761; x=1768985561; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHib3jWzP7kVcnP0SE1eJQabXI1WWwo6ABSGI/iwYvU=;
        b=OoCXDXddnOY+AncYAVGNCyTqgbOq1RMKt9HEgKaII5Z6c2JSOmWr7cfcFt0gXUZVxb
         SkYckvZ1yzOI/NHY8WVghcAxrnMVdJxXae1SyvkZ3+usDJTTqNrtK28D1aIvqOyp5QIM
         u4lkKd4eDHqADWn0mqay5vc2xtWnxQsTulWsAMn4Zp2CB7ktGFmDAHcPG0EQfHfDlFOi
         MVcbb5m9HSORP5rHa4u7wgeagMNDHzgbEMSONqGZpZZTvNi5J5p5FCaaEslyfYLTxWA4
         RwlhzR2nOSEo0R56VN7rqeSFV6sbHuCc63aqolJ5Gz1EMvaBpCHHw8L26oNczBd616Xb
         MsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768380761; x=1768985561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AHib3jWzP7kVcnP0SE1eJQabXI1WWwo6ABSGI/iwYvU=;
        b=hqsEceWW/bDsWhGJC7jbljEiJfMb/4kYSa6eaRYq3ty0O5bNcgIBR4CE7afussROAv
         5YhwBVJCQD/8ZIDNPgt+xMRiLy6vJbB6kF5vRYDVXzgQu3dnfqYZbOmFtHZfsjD6yLz8
         XKCjt/CvzXarAXJL5HFBLunoPQQt8eyU7ZYb1qbsqqRN5zPUOmca9HN3BtcJTp2Gjl9T
         dnzhysMyT4OgD0yaIfmEpMm+B30V2Uyb9mLxAZuGD/4xzNhV9DtHml/inBPI3nYuq2gL
         uG2zwLLergxOw0L9GZ0Hbg4ABqK2bCe5U1vVSOXxePbEFCWwB/WuFrP4FRj0FkmtRHjV
         ObBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHWybG4chltbdxK9Mbng5XP0rqa0NlNtK47vpITMXizlRACUvNes8eKYJDv+OUT6Y708C8XSZ2O+zZqYXiCg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8o/ukfQ2PIvRT1511GCSXO7Ter/kJVTeKRGoEcre8aQ+c73+t
	3CW+NTuEw9LlyMTGoqHcmTrcF5NibKsYyLiTx1RjJEsrm4woBF00nTuW4+3aYfxHYVg=
X-Gm-Gg: AY/fxX67fwZs7+s51CEPoFcpEzkN2cIdZcdUGuE/Ufcb2fRqE6yOWkPEhshCSksAjqq
	4CavG4rMLmEwUqAggGb40VnF1VC5Im8oFiD2Qoc6yNBgBtwDRZ+hZbOt1bXBO0Mh+B9uAYTTDPP
	ShL4X64r81tQzOSLIgHSAYa8nIe2BCn3KReG22cZuklqAxsJyHYrRqtn6onoyuiXdS/RV2maFTn
	mjw0qfTgqOGnvJP/i2eNqjvMtkAtwm+jVXWjSVtJUZd/vDNoSajbqv22HL89FvQvC4/dRz0qwUu
	nABEZzSis+k6yOcUj1xzA1C4c4T7Q5hYVDjFTV8HTQpXYlEJ+KL5mYpAqgQHPCbJqyNZJ5FAZIC
	qmU/3L0Q5qdUjnDLPnxHozg3R64gakVNhjiNf6I6TfYyMH5DmMm9z3nkJn5DwNdeT4Hqzqi71yf
	hMuTx6eyoPEVQBqE6xPIT6yIzoE2yLgC5dfWdf8/J3Bo6Ki4/fTk/TLu3AZbFEbpMbB2yuBgzg/
	7c=
X-Received: by 2002:ac8:7f0a:0:b0:4ee:228d:d6b8 with SMTP id d75a77b69052e-50148482933mr21948301cf.70.1768380761194;
        Wed, 14 Jan 2026 00:52:41 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148df8759sm10131931cf.10.2026.01.14.00.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:52:40 -0800 (PST)
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
Subject: [PATCH 4/8] mm/memory_hotplug: return online type from add_memory_driver_managed()
Date: Wed, 14 Jan 2026 03:51:56 -0500
Message-ID: <20260114085201.3222597-5-gourry@gourry.net>
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

Change add_memory_driver_managed() to return the online type (MMOP_*)
on success instead of 0. This allows callers to determine the actual
online state of the memory after addition, which is important when
MMOP_SYSTEM_DEFAULT is used and the actual online type depends on the
system default policy.

Update virtio_mem to handle the new return value semantics by checking
for rc < 0 to detect errors.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/kmem.c          | 2 +-
 drivers/virtio/virtio_mem.c | 5 +++--
 mm/memory_hotplug.c         | 4 +++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 5e0cf94a9620..d0dd36c536a0 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -178,7 +178,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 				range_len(&range), kmem_name, mhp_flags,
 				MMOP_SYSTEM_DEFAULT);
 
-		if (rc) {
+		if (rc < 0) {
 			dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
 					i, range.start, range.end);
 			remove_resource(res);
diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index b1ec8f2b9e31..4decb44f5a43 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -656,15 +656,16 @@ static int virtio_mem_add_memory(struct virtio_mem *vm, uint64_t addr,
 	rc = add_memory_driver_managed(vm->mgid, addr, size, vm->resource_name,
 				       MHP_MERGE_RESOURCE | MHP_NID_IS_MGID,
 				       MMOP_SYSTEM_DEFAULT);
-	if (rc) {
+	if (rc < 0) {
 		atomic64_sub(size, &vm->offline_size);
 		dev_warn(&vm->vdev->dev, "adding memory failed: %d\n", rc);
 		/*
 		 * TODO: Linux MM does not properly clean up yet in all cases
 		 * where adding of memory failed - especially on -ENOMEM.
 		 */
+		return rc;
 	}
-	return rc;
+	return 0;
 }
 
 /*
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 515ff9d18039..41974a1ccb91 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1689,7 +1689,7 @@ EXPORT_SYMBOL_GPL(add_memory);
  * MMOP_ONLINE_MOVABLE to online with that type, MMOP_OFFLINE to leave offline,
  * or MMOP_SYSTEM_DEFAULT to use the system default policy.
  *
- * Returns 0 on success, negative error code on failure.
+ * Returns the online type (MMOP_*) on success, negative error code on failure.
  */
 int add_memory_driver_managed(int nid, u64 start, u64 size,
 			      const char *resource_name, mhp_t mhp_flags,
@@ -1721,6 +1721,8 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
 	rc = __add_memory_resource(nid, res, mhp_flags, online_type);
 	if (rc < 0)
 		release_memory_resource(res);
+	else
+		rc = online_type;
 
 out_unlock:
 	unlock_device_hotplug();
-- 
2.52.0

