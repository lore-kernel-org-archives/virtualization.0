Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372AB356A29
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768434666; cv=none; b=hJry3dW8arVwj3Ra9bKuaYpyftUHRvFLug2C4FNJ6UuUVsuKYLrx9UG1xCJPNYJbO3QYwgzPjbkxPmxC+ce8c22DrrjHTBwiecmUyv4K4VupnIr+j+wT8V1qN/4HV7HQR+lrm8D8BAKyUwrOnOkCoyrlbDck6yYrSK35vHn9TJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768434666; c=relaxed/simple;
	bh=Ts4OR3TE6GFvXvPkLNSwvDxigmljGOw1xgooqw3bmMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4zDG0PcMaSxbTyqei//mXu1lZn3cEErqL1eB+MwlZIw02g97IZxoH1OzD9iZKhD1K59UDqCFO/Dp1+wNKkS9/rSeFIVWXnpYP8z7JR0WUh3Z5DsF48U1WfXr3QGlt56Sk0vD7nUifP6dUV8730uOLOQuTRC/EpoHcMRS5gHge4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XFYd/25e; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XFYd/25e"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-88888c41a13so3862076d6.3
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 15:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768434662; x=1769039462; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXtSnfgPBjwiSCGU9CrPH4hnxnqEFEy6STkxK/VjbLc=;
        b=XFYd/25ecTDDGwmBnEGCS7azPeM2tuElO55dqhqahA4+waN2HBhi9j6A66RCQOBh29
         e2no1FkyGUdhtUnOjGq2gsEXhS05FGSY3KM7AywmVdUgSdMxRFgk65le5SO/FOV+QmmS
         SaV09P3xb+e7yccle+Leaee4wgKigZABwyc0BYIbDUSoh2QzmO9qbfsxGcRI7vAAHPol
         xJ7YUnP8S+eIK8BXhZj28Aj6A5Lr1EHPSCui/IVwYCO7gXssy88hZYzRz5GFQ67004UG
         yKE/FAj644z30SkxKfswzpbna2RTYFAysq+cNqSYb9TLtLJLlcIqKBRRDHfN2LWFmFay
         fEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768434662; x=1769039462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cXtSnfgPBjwiSCGU9CrPH4hnxnqEFEy6STkxK/VjbLc=;
        b=dvwpBYOPhMh//sRHSEwxrwvU+KkXxaJjkIYU9iS65x7q5W9Q24EFZ+Hd+Ej5YwNO3t
         bO0/+eKrCQlDlArjZkz1j57d1F1XvcDQzBEHNDg3r3B3XVwi6JE7NPVtIMgpoDb09Ooi
         jjfX9YFjemt/PpbOjjNmEi72Gw4wDyDEQWFb9P2CFZReAq4ZCBRd1SLZ05xIvmV1uv/j
         rNla7bAOzclSyaVxlryRkQGF8l39YBXWuOlGAcc4tl/pjPZLNBmen5UQMd+AYlXfzv6T
         IPpourDSWti/UCKyCySh0hsX3bCiQ0Q7PjmXH2Ec3KibItUPa1nyQnYk1kr9WxNqae6/
         NK+g==
X-Forwarded-Encrypted: i=1; AJvYcCVfo1l+SQp5Jm2OK4b3olA0/keQzrXQ+UDOQRzodBxj9SlW8TbCJLwfBbi8oTvHov9qkhC3yAU12cFMX28xgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxDQYq/duxf/olxVri1Smko7EoVQvIYfWzEUryzgLxh/O7kWyu
	9TEiKNxq4J45R5uNThVoODQx+YegbcOG7IIazVZmWgMi2xKn0W+F6zrp5VoiG82mu9M=
X-Gm-Gg: AY/fxX7nn7oV6PGJVi+0EdluZBX3QzIN/jiLTzoPZrqdKegVkXvnKn1Kso1icua9Gf9
	sj0hK7xuPehrM1mY1XXwrfm/dJKsVBbZmCVfjbs8ZsKtIlWrZIZW8Kc6fHvFnBeKd7p4kGb2ysP
	u42CaRddHCFiTTxWwDoDYAY3do3CyQmPfLdvAQ1SE4moHEE4lBJjQVwOpHa2hy845QX8h3uFdON
	Njbuve+3Qen7SbOr1EHrJ0bXKfomf1dMLlipSEp0fesX0RnF6u8lkzmkdcGaaRsT0BNIaYsgJjQ
	pGSBndoa1snZckqUCbkhvN+olw1HvR5wiYjHPSShXTbRKv7Whi4DDxExh9IVeEQC0rzc8TMBOIe
	gqPYSeGKpN3aa9vKNUTH1Xvi5X7DQLfqXPtHhgzDzp99DIRQ0jLtlnozp2VV2pUgWFBpv/FwMGQ
	lYbmTfJcJwNMVP0fgxgiuYefVsoo7j1NnoE38SilB4rDCeH1mbDeYgQmPiO7NuVcFiP5BpwqiO9
	4E=
X-Received: by 2002:a05:6214:246c:b0:88a:2f46:8224 with SMTP id 6a1803df08f44-89275c89a31mr55155636d6.68.1768434662147;
        Wed, 14 Jan 2026 15:51:02 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890772346f8sm188449106d6.35.2026.01.14.15.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 15:51:01 -0800 (PST)
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
Subject: [PATCH v2 2/5] mm/memory_hotplug: add 'online_type' argument to add_memory_driver_managed
Date: Wed, 14 Jan 2026 18:50:18 -0500
Message-ID: <20260114235022.3437787-3-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114235022.3437787-1-gourry@gourry.net>
References: <20260114235022.3437787-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable external callers to select how to online the memory rather than
implicitly depending on the system defauilt.

Refactor: Extract __add_memory_resource to take an explicit online type,
and update add_memory_resource to pass the system default.

Export mhp_get_default_online_type() and update existing callers of
add_memory_driver_managed to use it explicitly to make it clear what the
behavior of the function is.

dax_kmem and virtio_mem drivers were updated.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/kmem.c             |  3 ++-
 drivers/virtio/virtio_mem.c    |  3 ++-
 include/linux/memory_hotplug.h |  2 +-
 mm/memory_hotplug.c            | 31 +++++++++++++++++++++++--------
 4 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index c036e4d0b610..bb13d9ced2e9 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -175,7 +175,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		 * this as RAM automatically.
 		 */
 		rc = add_memory_driver_managed(data->mgid, range.start,
-				range_len(&range), kmem_name, mhp_flags);
+				range_len(&range), kmem_name, mhp_flags,
+				mhp_get_default_online_type());
 
 		if (rc) {
 			dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 1688ecd69a04..63c0b2b235ab 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -654,7 +654,8 @@ static int virtio_mem_add_memory(struct virtio_mem *vm, uint64_t addr,
 	/* Memory might get onlined immediately. */
 	atomic64_add(size, &vm->offline_size);
 	rc = add_memory_driver_managed(vm->mgid, addr, size, vm->resource_name,
-				       MHP_MERGE_RESOURCE | MHP_NID_IS_MGID);
+				       MHP_MERGE_RESOURCE | MHP_NID_IS_MGID,
+				       mhp_get_default_online_type());
 	if (rc) {
 		atomic64_sub(size, &vm->offline_size);
 		dev_warn(&vm->vdev->dev, "adding memory failed: %d\n", rc);
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index f2f16cdd73ee..b68bc410db67 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -295,7 +295,7 @@ extern int add_memory_resource(int nid, struct resource *resource,
 			       mhp_t mhp_flags);
 extern int add_memory_driver_managed(int nid, u64 start, u64 size,
 				     const char *resource_name,
-				     mhp_t mhp_flags);
+				     mhp_t mhp_flags, int online_type);
 extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 				   unsigned long nr_pages,
 				   struct vmem_altmap *altmap, int migratetype,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 5718556121f0..2b4e31161fc1 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -239,6 +239,7 @@ int mhp_get_default_online_type(void)
 
 	return mhp_default_online_type;
 }
+EXPORT_SYMBOL_GPL(mhp_get_default_online_type);
 
 void mhp_set_default_online_type(int online_type)
 {
@@ -1490,7 +1491,8 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
  *
  * we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG
  */
-int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
+static int __add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags,
+				 int online_type)
 {
 	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
 	enum memblock_flags memblock_flags = MEMBLOCK_NONE;
@@ -1580,12 +1582,9 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
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
@@ -1601,7 +1600,13 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	return ret;
 }
 
-/* requires device_hotplug_lock, see add_memory_resource() */
+int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
+{
+	return __add_memory_resource(nid, res, mhp_flags,
+				     mhp_get_default_online_type());
+}
+
+/* requires device_hotplug_lock, see __add_memory_resource() */
 int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags)
 {
 	struct resource *res;
@@ -1649,9 +1654,16 @@ EXPORT_SYMBOL_GPL(add_memory);
  *
  * The resource_name (visible via /proc/iomem) has to have the format
  * "System RAM ($DRIVER)".
+ *
+ * @online_type specifies the online behavior: MMOP_ONLINE, MMOP_ONLINE_KERNEL,
+ * MMOP_ONLINE_MOVABLE to online with that type, MMOP_OFFLINE to leave offline.
+ * Users that want the system default should call mhp_get_default_online_type().
+ *
+ * Returns 0 on success, negative error code on failure.
  */
 int add_memory_driver_managed(int nid, u64 start, u64 size,
-			      const char *resource_name, mhp_t mhp_flags)
+			      const char *resource_name, mhp_t mhp_flags,
+			      int online_type)
 {
 	struct resource *res;
 	int rc;
@@ -1661,6 +1673,9 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
 	    resource_name[strlen(resource_name) - 1] != ')')
 		return -EINVAL;
 
+	if (online_type < 0 || online_type > MMOP_ONLINE_MOVABLE)
+		return -EINVAL;
+
 	lock_device_hotplug();
 
 	res = register_memory_resource(start, size, resource_name);
@@ -1669,7 +1684,7 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
 		goto out_unlock;
 	}
 
-	rc = add_memory_resource(nid, res, mhp_flags);
+	rc = __add_memory_resource(nid, res, mhp_flags, online_type);
 	if (rc < 0)
 		release_memory_resource(res);
 
-- 
2.52.0

