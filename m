Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159F8376A1B;
	Tue, 23 Jun 2026 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209908; cv=none; b=T4+We0qrUZucyfY4mjQ2gfGCFnzCQEHALYy7lepFyXItKsj6UIGuGXw7vJSfSZBH4WVjTKliCHTq5KRqzn1PODrnNPhyqWcepsHjIcB/GAx6MNFbgDTorS+b07HXlcW8B+BeVULK4arHf1qQArYmZQzLkP2+SW9WIKYqw4LsLfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209908; c=relaxed/simple;
	bh=gk1N272mlFLWJH0cquE0KJv2+MVQstwQ630C3ttO7qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nllkOomnaU9hpeHKOCpWG7+faMNMbmW0wtsbcEUMTzLQoOevzYTZrSNjMl+C94i6yWy/QcwJ6kVjc9dvpEs+g+3Y+qU2QxOIsNt71XQfFc1Z6m/BWQFbMYcWsNarNwsydu7k53GhnT8uozsGnJp7Yf9+wulYDI94xoDPfv0X5S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FvvGVfSy; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FvvGVfSy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782209907; x=1813745907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gk1N272mlFLWJH0cquE0KJv2+MVQstwQ630C3ttO7qo=;
  b=FvvGVfSy72E6vP0IAKBfJWFeRtUTftBZrOfxLHHaFs7c7JB6uxRORTkj
   a4u6xAKJY9luI9osTxSweR+lmrO/v6o0I9VT8iOkIQ099gJiz1p/ky3kb
   kpUbtnZhAuJZ3dtc2/UMv9o8uQCdR+10+rszGjzBKq2IaRYi+tiJ9CtkR
   RIJmAONEcW8/cBsFm2MjwO5y2wYuZXZm9ZNhB5Gt2u2LeT49csQq5zvHv
   HO9VWEjoOF7UYst30Rn0nRQ+fzmdH4p0C3NU1k0jU/pJvgDWXsVSPBcWm
   f2/UfzMP/3RHCAloa6J4R3e9/O0AY9oXIrRommYCRFH1zvRBhV57VwFBr
   A==;
X-CSE-ConnectionGUID: Z8dDU4TWRFibx+xiBkPOVA==
X-CSE-MsgGUID: G8gw8UU6THqXDiq4wroBKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82717854"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82717854"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:18:17 -0700
X-CSE-ConnectionGUID: No2sf3WpRHqWa7gY0fXxNQ==
X-CSE-MsgGUID: 8HvBOxVdTsynYgiBx036EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="245339926"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:18:13 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: marcandre.lureau@redhat.com,
	david@kernel.org,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	prsampat@amd.com,
	pbonzini@redhat.com,
	mst@redhat.com,
	peterx@redhat.com,
	chenyi.qiang@intel.com,
	elena.reshetova@intel.com,
	michael.roth@amd.com,
	ackerleytng@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	virtualization@lists.linux.dev,
	x86@kernel.org,
	yilun.xu@intel.com,
	xiaoyao.li@intel.com,
	chao.p.peng@intel.com
Subject: [RFCv2 PATCH 6/6] virtio-mem: Support memory hotplug/unplug for coco guest
Date: Tue, 23 Jun 2026 06:17:37 -0400
Message-ID: <20260623101739.79695-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260623101739.79695-1-zhenzhong.duan@intel.com>
References: <20260623101739.79695-1-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Integrate coco memory management operations into the virtio-mem driver to
manage the state of hotplug memory.

In virtio_mem_send_plug_request(), once the host hypervisor acknowledges a
plug request, invoke coco_set_plugged_bitmap() to set the corresponding
bits in the plugged bitmap. Conversely, in virtio_mem_send_unplug_request()
and virtio_mem_send_unplug_all_request(), call unaccept_memory() to let the
guest autonomously transition the target private pages back to "unaccepted"
state before asking the VMM to unplug them. After the VMM acknowledges the
unplug request, clear the ranges from the plugged bitmap.

Note that memory block hotplug/unplug also sets or clears the plugged
bitmap at memory block granularity. While doing this at device block
granularity here creates a slight redundancy, it is completely harmless.

Additionally, update virtio_mem_fake_online() to explicitly invoke
accept_memory() when transitioning memory out of the fake-offline state and
back into service. This ensures that any pages returning to the buddy
system are cleanly accepted by the guest architecture before they are freed
back into the allocator via free_contig_range().

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 drivers/virtio/virtio_mem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 48051e9e98ab..9f6e53df8caf 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1211,6 +1211,7 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
 			generic_online_page(page, order);
 		} else {
 			virtio_mem_clear_fake_offline(pfn + i, 1 << order, true);
+			accept_memory(page_to_phys(page), PAGE_SIZE << order);
 			free_contig_range(pfn + i, 1 << order);
 			adjust_managed_page_count(page, 1 << order);
 		}
@@ -1436,6 +1437,7 @@ static int virtio_mem_send_plug_request(struct virtio_mem *vm, uint64_t addr,
 	switch (virtio_mem_send_request(vm, &req)) {
 	case VIRTIO_MEM_RESP_ACK:
 		vm->plugged_size += size;
+		WARN_ON(coco_set_plugged_bitmap(addr, size, true));
 		return 0;
 	case VIRTIO_MEM_RESP_NACK:
 		rc = -EAGAIN;
@@ -1471,9 +1473,12 @@ static int virtio_mem_send_unplug_request(struct virtio_mem *vm, uint64_t addr,
 	dev_dbg(&vm->vdev->dev, "unplugging memory: 0x%llx - 0x%llx\n", addr,
 		addr + size - 1);
 
+	unaccept_memory(addr, size);
+
 	switch (virtio_mem_send_request(vm, &req)) {
 	case VIRTIO_MEM_RESP_ACK:
 		vm->plugged_size -= size;
+		WARN_ON(coco_set_plugged_bitmap(addr, size, false));
 		return 0;
 	case VIRTIO_MEM_RESP_BUSY:
 		rc = -ETXTBSY;
@@ -1498,10 +1503,13 @@ static int virtio_mem_send_unplug_all_request(struct virtio_mem *vm)
 
 	dev_dbg(&vm->vdev->dev, "unplugging all memory");
 
+	unaccept_memory(vm->addr, vm->region_size);
+
 	switch (virtio_mem_send_request(vm, &req)) {
 	case VIRTIO_MEM_RESP_ACK:
 		vm->unplug_all_required = false;
 		vm->plugged_size = 0;
+		WARN_ON(coco_set_plugged_bitmap(vm->addr, vm->region_size, false));
 		/* usable region might have shrunk */
 		atomic_set(&vm->config_changed, 1);
 		return 0;
-- 
2.52.0

