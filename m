Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699464;
	b=QbNK91jdz04o5iJXdYt3PAtw2tNTRPpXoOqx0sWd5S6fTgEz/atO1VNhFoIjhkb28pkQ
	 E7QntJ0UYxJRfcpN44kidILiJH2WCfjOxdTqr0PUnSJgiJOq/e6rgBRv/xAkkZVLbT+4E
	 cdSJbyYBdtUrtD/dMze+/Xv86RCey8Fn2PnwTDuRDR25PnDD1NUv1KO0WSezqb0cm6BmB
	 pUOPHCOUBHPv6aX3FwTd3k1XeIzk83ZDiFunoFmermNtpAMaZqTNoYkRa5xdHzz9L8FEt
	 d5pnp/dOb4oPWenroPh03yAd7Px2KV2kpmxsNo3s83zEdbeb1Wr99WcemnsNGx906pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699464;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=SN2cbNZfZk1rDvDVpASrZGK8gPmH+E9oCxWeHnJltGY=;
	b=ydCAtOCYo+r4wUFJSYfrmB6QukGSQXoXuM1njNKXc5wFB+mRtyEhiXYrtDlKygNgSil2
	 RozK9PB2+L2zQpDBmVQSpMzCxo0bOlRIa7n53PxwrQaO9TNhoBJi2qglyiVSy/YL4MNA1
	 p2m2K4lRWbkm/meovCmzFgE7IbBiD/fDCAjFEpoVs/C4dUgsCE9HqHYyRMnbYu9F6XePm
	 Po0UHLxCV6QQBIfJkkMF/9YNPYEIXG1Pbzaiq2SdYsp4eeAzLRwyzjNTMn23V4/NwNZC8
	 8dJkJ4grw7dfQFukidpledatNm899VdcW9NTCSXBSsffA//jcMIuPpcovBUEt/plGgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=karaolidis.com;
	spf=pass smtp.mailfrom=karaolidis.com;
	dkim=pass header.d=karaolidis.com header.i=@karaolidis.com header.a=rsa-sha256 header.s=protonmail3 header.b=fFWoOweV;
	arc=none smtp.remote-ip=79.135.106.112
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9A4606D801
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 09:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE9A4606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=karaolidis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=karaolidis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=karaolidis.com header.i=@karaolidis.com header.a=rsa-sha256 header.s=protonmail3 header.b=fFWoOweV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karaolidis.com;
	s=protonmail3; t=1793699461; x=1793958661;
	bh=SN2cbNZfZk1rDvDVpASrZGK8gPmH+E9oCxWeHnJltGY=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=fFWoOweVN/T9iPa3kVqaqtXUorpdm4UPfLZhHlC+BIYNRvxpIRRYbPlZRNf+8WNL9
	 0p3gSI2WuSpAduaw5Ssxo66Py30vdjrUZ5AUEoNLHQvEhYnaEaYuRSBYYC4HpQMZe+
	 V6ktmZfmFCW94vMdNyLcWhWKElVTBhpfxamZ2QyJ6cJLR9iUti23cx5e3xcm6o+JKF
	 WajtNWAicJPqiFQnU80LIz04bnBqvGIIExv9ygEyuU9vMctK0Lp6HXKQI2d2EkYHsg
	 GLwrWYG+6mGTsgLTrppjqwk5Xd6tnmjVLwYwmEEqPx5Zi9Tm3cxGwN7NxtMb9GgKnp
	 90aznmG2PDrlQ==
X-Pm-Submission-Id: 4jJkNK66X8z2ScjM
From: Nikolaos Karaolidis <nick@karaolidis.com>
Date: Tue, 03 Nov 2026 09:50:09 +0000
Subject: [PATCH RFC 3/6] virtio-mem: support memmap_on_memory in Big Block
 Mode
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-virtio-mem-memmap-v1-3-308ae1da6240@karaolidis.com>
References: <20261103-virtio-mem-memmap-v1-0-308ae1da6240@karaolidis.com>
In-Reply-To: <20261103-virtio-mem-memmap-v1-0-308ae1da6240@karaolidis.com>
To: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: Oscar Salvador <osalvador@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, 
 Hui Zhu <teawater@gmail.com>, 
 Georgi Djakov <georgi.djakov@oss.qualcomm.com>, 
 virtualization@lists.linux.dev, linux-mm@kvack.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Nikolaos Karaolidis <nick@karaolidis.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7102; i=nick@karaolidis.com;
 h=from:subject:message-id; bh=i4qH0gKvOwKh7W5tPy50bPBdXvAZkUQIhbg9Uj8kFII=;
 b=owJ4nAFtApL9kA0DAAoB2mjImL9M9YgByyZiAGrprndPZWUPQvXERzHktOvvAtXprxxImyzDe
 LcGzfZLklN4J4kCMwQAAQoAHRYhBLMZG7EWqsMYjymWX9poyJi/TPWIBQJq6a53AAoJENpoyJi/
 TPWI/BMP/01gF70UakAx03YsBaN7FIvInSKQ+wLb4aVaZphdwC/vL2B/NOiiz3wplFTGnkcLisJ
 AiYxZVP+wbK4kWN87Biml9Fk2CBmobfmnkL7t4d12F2hvF1b3B0lJN3chlN8HFYEjFU28VmC86/
 sDEcIjfOPvMJ5M/bq/MdWSX/izR8jbZ+ag1whNXH/8YQfihFLhufOWq0Ibug38iwy4KpJQw7Xme
 R/ZxrzL0kVlAmPD/MslTahfjy9WPRVJz/IDy2bPpEdTDMvTzZQoNE+jGIrJTsjWXsUY3yOx/3or
 tHPSepw2mErDJGxrJnViScOsX/9M+Gj3MgWVKjue1EO50gcvOJWZ891TgbURjzDQuXC5I/rxSV6
 kOc125fXed3doHBHxd6U27UB+9rd3OQAP87wW+CpzgS83JyGrl9xUGAY1F10Qlb4I/SBPZ+XpoL
 3xWBbB2Wtk8Q7XaN/k4ohRKKP1bEeHZWXjxGhvw+S/TTE/53oEhdA9SaW2yKNS/ODrDIF6Zg8be
 4RgSybmX8bICOQQoErcl+Ch+OMo4146se0epGEpi/eohDyfAhVMcDWHEtCNQdxA1qxDO6yUi71K
 /kPiGg9rW62rgmKiYK1FJDWE0Bbub+KggH2Fpx5OLqwVQzt0WY5n7815jBPYXvof/TS42ynoXhu
 rwqCvX5XhA4z5kWUuvZcuig==
X-Developer-Key: i=nick@karaolidis.com; a=openpgp;
 fpr=B3191BB116AAC3188F29965FDA68C898BF4CF588

virtio-mem adds memory without MHP_MEMMAP_ON_MEMORY. With hotplugged
memory onlined to ZONE_MOVABLE, its memmap is allocated from the kernel
zones. A small VM grown to many times its boot size can run out of
memory for unmovable allocations.

With MHP_MEMMAP_ON_MEMORY and memory_hotplug.memmap_on_memory, the core
allocates the memmap of each memory block from the memory block itself.
In Big Block Mode memory blocks are always added and removed as a
whole, and the core uses one altmap per memory block, so big blocks
spanning several memory blocks work.

Add virtio_mem.memmap_on_memory, off by default, which only takes
effect if memory_hotplug.memmap_on_memory is enabled as well, like the
opt-in knobs of dax/kmem and s390 standby memory. It is opt-in because:

* The self-hosted memmap (1/64 with 4 KiB pages) counts towards the
  plugged size of the device but is not available to Linux, and in Sub
  Block Mode the plugged size can end up slightly below the requested
  size. Whoever sizes the device should opt in.

* Gigantic pages can no longer be allocated from virtio-mem memory
  unless memory blocks are larger than a gigantic page.

If the core would ignore MHP_MEMMAP_ON_MEMORY, warn and continue
without it.

When unplugging a big block, skip the memmap of each memory block while
fake-offlining and when rolling back, because it is not managed by the
buddy.

Sub Block Mode is not supported yet, so warn and ignore the parameter.

Assisted-by: LLM
Signed-off-by: Nikolaos Karaolidis <nick@karaolidis.com>
---
 drivers/virtio/virtio_mem.c | 64 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index ab06adbc0342..034d07207e44 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -40,6 +40,11 @@ module_param(bbm_block_size, ulong, 0444);
 MODULE_PARM_DESC(bbm_block_size,
 		 "Big Block size in bytes. Default is 0 (auto-detection).");
 
+static bool memmap_on_memory;
+module_param(memmap_on_memory, bool, 0444);
+MODULE_PARM_DESC(memmap_on_memory,
+		 "Allocate the memmap from hotplugged memory itself if memory_hotplug.memmap_on_memory is enabled. Default is 0.");
+
 /*
  * virtio-mem currently supports the following modes of operation:
  *
@@ -639,6 +644,7 @@ static bool virtio_mem_could_add_memory(struct virtio_mem *vm, uint64_t size)
 static int virtio_mem_add_memory(struct virtio_mem *vm, uint64_t addr,
 				 uint64_t size)
 {
+	mhp_t mhp_flags = MHP_MERGE_RESOURCE | MHP_NID_IS_MGID;
 	int rc;
 
 	/*
@@ -654,10 +660,13 @@ static int virtio_mem_add_memory(struct virtio_mem *vm, uint64_t addr,
 
 	dev_dbg(&vm->vdev->dev, "adding memory: 0x%llx - 0x%llx\n", addr,
 		addr + size - 1);
+	if (vm->memmap_pages)
+		mhp_flags |= MHP_MEMMAP_ON_MEMORY;
+
 	/* Memory might get onlined immediately. */
 	atomic64_add(size, &vm->offline_size);
 	rc = add_memory_driver_managed(vm->mgid, addr, size, vm->resource_name,
-				       MHP_MERGE_RESOURCE | MHP_NID_IS_MGID);
+				       mhp_flags);
 	if (rc) {
 		atomic64_sub(size, &vm->offline_size);
 		dev_warn(&vm->vdev->dev, "adding memory failed: %d\n", rc);
@@ -2154,6 +2163,20 @@ static int virtio_mem_sbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
 	return rc;
 }
 
+/*
+ * A self-hosted memmap is not managed by the buddy and must not get
+ * fake-offlined. Returns the first pfn to process in the memory section
+ * starting at @pfn, which is beyond the section if the memmap covers it.
+ */
+static unsigned long virtio_mem_bbm_section_skip_memmap(struct virtio_mem *vm,
+							unsigned long pfn)
+{
+	const unsigned long mb_pfn = ALIGN_DOWN(pfn,
+						PHYS_PFN(memory_block_size_bytes()));
+
+	return max(pfn, mb_pfn + vm->memmap_pages);
+}
+
 /*
  * Try to offline and remove a big block from Linux and unplug it. Will fail
  * with -EBUSY if some memory is busy and cannot get unplugged.
@@ -2167,7 +2190,7 @@ static int virtio_mem_bbm_offline_remove_and_unplug_bb(struct virtio_mem *vm,
 	const unsigned long start_pfn = PFN_DOWN(virtio_mem_bb_id_to_phys(vm, bb_id));
 	const unsigned long nr_pages = PFN_DOWN(vm->bbm.bb_size);
 	unsigned long end_pfn = start_pfn + nr_pages;
-	unsigned long pfn;
+	unsigned long pfn, first_pfn, next_pfn;
 	struct page *page;
 	int rc;
 
@@ -2184,12 +2207,17 @@ static int virtio_mem_bbm_offline_remove_and_unplug_bb(struct virtio_mem *vm,
 	mutex_lock(&vm->hotplug_mutex);
 	virtio_mem_bbm_set_bb_state(vm, bb_id, VIRTIO_MEM_BBM_BB_FAKE_OFFLINE);
 
-	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
-		page = pfn_to_online_page(pfn);
+	for (pfn = start_pfn; pfn < end_pfn; pfn = next_pfn) {
+		next_pfn = pfn + PAGES_PER_SECTION;
+		first_pfn = virtio_mem_bbm_section_skip_memmap(vm, pfn);
+		if (first_pfn >= next_pfn)
+			continue;
+		page = pfn_to_online_page(first_pfn);
 		if (!page)
 			continue;
 
-		rc = virtio_mem_fake_offline(vm, pfn, PAGES_PER_SECTION);
+		rc = virtio_mem_fake_offline(vm, first_pfn,
+					     next_pfn - first_pfn);
 		if (rc) {
 			end_pfn = pfn;
 			goto rollback;
@@ -2213,11 +2241,15 @@ static int virtio_mem_bbm_offline_remove_and_unplug_bb(struct virtio_mem *vm,
 	return rc;
 
 rollback:
-	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
-		page = pfn_to_online_page(pfn);
+	for (pfn = start_pfn; pfn < end_pfn; pfn = next_pfn) {
+		next_pfn = pfn + PAGES_PER_SECTION;
+		first_pfn = virtio_mem_bbm_section_skip_memmap(vm, pfn);
+		if (first_pfn >= next_pfn)
+			continue;
+		page = pfn_to_online_page(first_pfn);
 		if (!page)
 			continue;
-		virtio_mem_fake_online(pfn, PAGES_PER_SECTION);
+		virtio_mem_fake_online(first_pfn, next_pfn - first_pfn);
 	}
 	virtio_mem_bbm_set_bb_state(vm, bb_id, VIRTIO_MEM_BBM_BB_ADDED);
 	mutex_unlock(&vm->hotplug_mutex);
@@ -2607,6 +2639,19 @@ static int virtio_mem_init_hotplug(struct virtio_mem *vm)
 					      vm->offline_threshold);
 	}
 
+	/* All memory blocks of a device must agree, decide once. */
+	if (memmap_on_memory) {
+		vm->memmap_pages = mhp_memmap_on_memory_nr_pages();
+		if (!vm->memmap_pages) {
+			dev_warn(&vm->vdev->dev,
+				 "memmap_on_memory is disabled or not supported by the core, ignoring\n");
+		} else if (vm->in_sbm) {
+			dev_warn(&vm->vdev->dev,
+				 "memmap_on_memory is only supported in BBM, ignoring\n");
+			vm->memmap_pages = 0;
+		}
+	}
+
 	dev_info(&vm->vdev->dev, "memory block size: 0x%lx",
 		 memory_block_size_bytes());
 	if (vm->in_sbm)
@@ -2615,6 +2660,9 @@ static int virtio_mem_init_hotplug(struct virtio_mem *vm)
 	else
 		dev_info(&vm->vdev->dev, "big block size: 0x%llx",
 			 (unsigned long long)vm->bbm.bb_size);
+	if (vm->memmap_pages)
+		dev_info(&vm->vdev->dev, "memmap on memory: 0x%llx bytes per memory block",
+			 (unsigned long long)PFN_PHYS(vm->memmap_pages));
 
 	/* create the parent resource for all memory */
 	rc = virtio_mem_create_resource(vm);

-- 
2.55.0

