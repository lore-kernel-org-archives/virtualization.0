Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490A33803C3
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 08:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380770; cv=none; b=sn4C2z+CwpvS7r8uI+CsbA6txe/fJBR6Ri+QT3Flk21/FV07x93JINX5WCWTri5CNdnX5IH+Ky49uP32gdxeFF7A5JLwqGAg2dTeUn3jP0tS0sFYKwEicOBJnLEBEO922cHlICi8+r4oPRrSoqK0a4IW7d/DEXg6WQNQFl2vvwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380770; c=relaxed/simple;
	bh=O3e7cGKk0H8FcpihdwgdFuRgPI92sucbbxtSDb5wt50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEH6KFOeUuLbXY1xCc7N1ALwBkZO/I+TxY6rW6qyHI9iqRaYQSZNLOoaTrBPGvdudZrm5MyFaCed9RqTXrlIIqYB/DRYKNRp+31ZkLmHStsLEwStygbSnQ15ago//DrPXred9zyvIgkqAskBVQYvHat/BwEkZ03NL3vHrL0Hb1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=bjDkkXVt; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="bjDkkXVt"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5014e8b1615so1307521cf.3
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 00:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768380758; x=1768985558; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lttic/N6u5GXxgBUHet1PhNEmYleRIF6n16Y0kYNwPY=;
        b=bjDkkXVtf/xHsLawC0z5bsWxoJuk8uc6e5rJVlDj1EsdMz3zBbKgWcc1dizQJ2YqRz
         LgcLAcJc2sKdvnT0USRW9F1/i3NovgyJ4U2XTJniHRvfkdPiSMGUm1H3HMMoMtLoozi0
         0T1h4l+pU6qdz3z+dnjRv2pva1gWx983sE5inYC2R/DsuP2w7tzh6g5DOKG2rPiAjxvE
         8c85L5tFpGY/2Vsj9XoUVKJWlKjjTNXyFxFwCnIouL4m6hxZLCy8FeZtx+zWXUxO4zrM
         48UhzWkVEr5QgsW9awKhG9RXNRk9BKfK54KEHPAADkDxzvZJov2WWWkCL1uOuOYBHfhy
         m11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768380758; x=1768985558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lttic/N6u5GXxgBUHet1PhNEmYleRIF6n16Y0kYNwPY=;
        b=p/j508Durn87QaO75CFiHqkwS3zyovDqJmE5hPVsDWmvsxaSkHMa0fbqtZBl6pKNcW
         XEwFASj7pSaB+jomO15MR0ozXg6rKhoxH4UP9pconaEOO7suShfOXD8jIBn09WFIqxNr
         dl1S1gfYF6H4UQiu9vz1+PwWu4hnioEULSb4yZmnhPy4qXuDhQkAQWsJtBXv0lX3kRvz
         O0kmHKoglXCsVfG3PGhIKpHg2QH4rnR/ajcA3V0rzn0EToL+dChc1XNHe720EBdpO3q0
         eZjUmWYScn+wNC+AWftP7BokqwUoq6JMRIRReTCyAu29eJPpKhr1IwjM1aylu8tigOGt
         z4Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWruCPSIRdq+TZ1+PM65LvcIIfnvUOJ95OIGwBQRJK4CHWHs59YzynYcUcuV0zQQyD6Nktidp4QRgAukuDhJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfJ65FEq+5BwvfOO0eg/INS6rc8C+YdsZ6xWpYG/Clz/4m1qxN
	WWPdvAk0NGpeY4/FcNoi87XSoyDgqtXDW4IwQNwuETXyxuBAroK4lWMztQg5CMvbbyw=
X-Gm-Gg: AY/fxX7U3C52hKxbYyKqGXAt2wm3yzMpKzHI0peYPFNUg5wOe9rRB1WpMaP12lhv0EV
	mHGTm+IPl4g9awrwOmW3Ytkzg2oHk3H2ho7M84HIIPhkh7sbtfJlsVuaFNEww51TnFPYIMqukpc
	TjFT/42+ukU4buA8TBEw7wvY3Hdml1xSRPb4arA2DbdWVpHZ/RYmOa1Pyce8NQpFpYP1qbX/esH
	tHMd2emXgHnhoxlDzUCa/L7HK2hRTFBQhBpdz7zYDMwnHnNRnKGOSW/sZ2C7XXn202cdgyYUOGA
	/4W6QRZhdAZgW08dX/PnrWkPmjJk2JM6GxL4afErRp+qiSo6bu7BvHC1BsKNWkrI1UUKuSquYeN
	P6U3D5H6pHY3jejDX06qf5013V5btgDOGGcKOA0LoocRyVBDAqjNMh4VQgWdqG/jHOqyYhcb9qU
	mhjmJtRVbJL8pjcIL01dVJN8aZMWtimDLeln8oHTNFLcCwLX+RaIuZn/PBJzHhDTHd+aChgCoFq
	Mc=
X-Received: by 2002:ac8:5701:0:b0:4ee:1727:10bd with SMTP id d75a77b69052e-501484c531emr22881881cf.66.1768380757853;
        Wed, 14 Jan 2026 00:52:37 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148df8759sm10131931cf.10.2026.01.14.00.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:52:37 -0800 (PST)
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
Subject: [PATCH 2/8] mm/memory_hotplug: extract __add_memory_resource() and __offline_memory()
Date: Wed, 14 Jan 2026 03:51:54 -0500
Message-ID: <20260114085201.3222597-3-gourry@gourry.net>
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

Extract internal helper functions with explicit parameters to prepare
for adding new APIs that allow explicit online type control:

  - __add_memory_resource(): accepts an explicit online_type parameter.
    Add MMOP_SYSTEM_DEFAULT as a new value that instructs the function
    to use mhp_get_default_online_type() for the actual online type.
    The existing add_memory_resource() becomes a thin wrapper that
    passes MMOP_SYSTEM_DEFAULT to preserve existing behavior.

  - __offline_memory(): extracted from offline_and_remove_memory() to
    handle the offline operation with rollback support. The caller
    now handles locking and the remove step separately.

This refactoring enables future callers to specify explicit online
types (MMOP_OFFLINE, MMOP_ONLINE, MMOP_ONLINE_MOVABLE) or use
MMOP_SYSTEM_DEFAULT for the system default policy. The offline logic
can also be used independently of the remove step.

Mild functional change: if try_remove_memory() failed after successfully
offlining, we would re-online the memory.  We no longer do this, and in
practice removal doesn't fail if offline succeeds.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/memory_hotplug.h |  2 +
 mm/memory_hotplug.c            | 69 ++++++++++++++++++++++------------
 2 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index f2f16cdd73ee..d5407264d72a 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -29,6 +29,8 @@ enum {
 	MMOP_ONLINE_KERNEL,
 	/* Online the memory to ZONE_MOVABLE. */
 	MMOP_ONLINE_MOVABLE,
+	/* Use system default online type from mhp_get_default_online_type(). */
+	MMOP_SYSTEM_DEFAULT,
 };
 
 /* Flags for add_memory() and friends to specify memory hotplug details. */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 5718556121f0..ab73c8fcc0f1 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1490,7 +1490,8 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
  *
  * we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG
  */
-int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
+static int __add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags,
+				 int online_type)
 {
 	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
 	enum memblock_flags memblock_flags = MEMBLOCK_NONE;
@@ -1499,6 +1500,10 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	bool new_node = false;
 	int ret;
 
+	/* Convert system default to actual online type */
+	if (online_type == MMOP_SYSTEM_DEFAULT)
+		online_type = mhp_get_default_online_type();
+
 	start = res->start;
 	size = resource_size(res);
 
@@ -1580,12 +1585,9 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		merge_system_ram_resource(res);
 
 	/* online pages if requested */
-	if (mhp_get_default_online_type() != MMOP_OFFLINE) {
-		int online_type = mhp_get_default_online_type();
-
+	if (online_type != MMOP_OFFLINE)
 		walk_memory_blocks(start, size, &online_type,
 				   online_memory_block);
-	}
 
 	return ret;
 error:
@@ -1601,7 +1603,12 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	return ret;
 }
 
-/* requires device_hotplug_lock, see add_memory_resource() */
+int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
+{
+	return __add_memory_resource(nid, res, mhp_flags, MMOP_SYSTEM_DEFAULT);
+}
+
+/* requires device_hotplug_lock, see __add_memory_resource() */
 int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags)
 {
 	struct resource *res;
@@ -2357,12 +2364,12 @@ static int try_reonline_memory_block(struct memory_block *mem, void *arg)
 }
 
 /*
- * Try to offline and remove memory. Might take a long time to finish in case
- * memory is still in use. Primarily useful for memory devices that logically
- * unplugged all memory (so it's no longer in use) and want to offline + remove
- * that memory.
+ * Offline a memory range. In case of failure, already offlined memory blocks
+ * will be re-onlined.
+ *
+ * Caller must hold device hotplug lock.
  */
-int offline_and_remove_memory(u64 start, u64 size)
+static int __offline_memory(u64 start, u64 size)
 {
 	const unsigned long mb_count = size / memory_block_size_bytes();
 	uint8_t *online_types, *tmp;
@@ -2388,11 +2395,37 @@ int offline_and_remove_memory(u64 start, u64 size)
 	 */
 	memset(online_types, MMOP_OFFLINE, mb_count);
 
-	lock_device_hotplug();
-
 	tmp = online_types;
 	rc = walk_memory_blocks(start, size, &tmp, try_offline_memory_block);
 
+	/*
+	 * Rollback what we did. While memory onlining might theoretically fail
+	 * (nacked by a notifier), it barely ever happens.
+	 */
+	if (rc) {
+		tmp = online_types;
+		walk_memory_blocks(start, size, &tmp,
+				   try_reonline_memory_block);
+	}
+
+	kfree(online_types);
+	return rc;
+}
+
+/*
+ * Try to offline and remove memory. Might take a long time to finish in case
+ * memory is still in use. Primarily useful for memory devices that logically
+ * unplugged all memory (so it's no longer in use) and want to offline + remove
+ * that memory.
+ */
+int offline_and_remove_memory(u64 start, u64 size)
+{
+	int rc;
+
+	lock_device_hotplug();
+
+	rc = __offline_memory(start, size);
+
 	/*
 	 * In case we succeeded to offline all memory, remove it.
 	 * This cannot fail as it cannot get onlined in the meantime.
@@ -2403,18 +2436,8 @@ int offline_and_remove_memory(u64 start, u64 size)
 			pr_err("%s: Failed to remove memory: %d", __func__, rc);
 	}
 
-	/*
-	 * Rollback what we did. While memory onlining might theoretically fail
-	 * (nacked by a notifier), it barely ever happens.
-	 */
-	if (rc) {
-		tmp = online_types;
-		walk_memory_blocks(start, size, &tmp,
-				   try_reonline_memory_block);
-	}
 	unlock_device_hotplug();
 
-	kfree(online_types);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(offline_and_remove_memory);
-- 
2.52.0

