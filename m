Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F78F383326;
	Thu,  4 Jun 2026 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565789; cv=none; b=oSHDPc4hVJmHbXZQBHhfsKNEKYHfQzXrwzNeKuLX0Q0pioD3pxBq42psk0fbNO+K4KBzxx7Oln4akvm7w7suOhDgDyAPBwjhs96+NQZIhWNPCNE9zUnmCgoJgYSmgiaqEUULML16BzF05j9gb7HnwOqAC7kOh7+m7mMeJ3FEZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565789; c=relaxed/simple;
	bh=EQyMo+ctWfI8wcAt+vTvRpCS23Lw4PpWu6nq6X8E2wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUd4tgzsMkCCSMdomVZ/mfn8Bru3UpuUB3b7tQg1eVEkhdewVY8MHTIKNrK6RKO9cMZZeeEadVj/eT5QqbsPWxBjIbAzXoir9aEjwSom3yr6OwNerrXuZEScfx/lW3ZpVqkYbV6XR3qw6H52oW4tQH2Q74B5NxvSrm58NN6laXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1LsVLjA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1LsVLjA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780565788; x=1812101788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EQyMo+ctWfI8wcAt+vTvRpCS23Lw4PpWu6nq6X8E2wU=;
  b=i1LsVLjAzx/BY20bWzY+g0STAcCjPdy4NsWsrFNDTBpL4nwfZuIjgwbE
   7RuTDCRGaHDxkQsprCf3TB2yvMPyPBVw1cpuBDhCGD5NikgYn26HyGwjo
   c8BPKvlObpeI9sVK/XmK9l4diBoyEf8BUUyHs/UpDEto2wx1MBD40usbz
   /z6ilWACMXxvytD5Ur1oQ+yOgmqmR3x198SGGeMXyhdW1zaaqgkLW67tR
   TCZA9V+F5Jprk3Ig1rg1Wo55H2SxeRdIYD29KqUJ2EasALul7eAEUrN5D
   8Qet2NbxywCHfmchPFgev9/qbFgOpb4e24sAS+zCAsrGq0C0hjt1sjG6Q
   Q==;
X-CSE-ConnectionGUID: hpO7IbXaTdCn8dD2u5dUmA==
X-CSE-MsgGUID: f+e563bIRwK4itrcX+lSCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="98963741"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="98963741"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 02:36:27 -0700
X-CSE-ConnectionGUID: IQccCbP4S/6e+evU1fSaoQ==
X-CSE-MsgGUID: l9Z5P2TDSpWwY9CAeAr8sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="240037624"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 02:36:23 -0700
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
	michaeluth@amd.com,
	ackerleytng@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	virtualization@lists.linux.dev,
	x86@kernel.org,
	yilun.xu@intel.com,
	xiaoyao.li@intel.com,
	chao.p.peng@intel.com
Subject: [RFC PATCH 3/6] virtio-mem: Integrate memory acceptance and release callbacks
Date: Thu,  4 Jun 2026 05:35:48 -0400
Message-ID: <20260604093551.1511079-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260604093551.1511079-1-zhenzhong.duan@intel.com>
References: <20260604093551.1511079-1-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Integrate the memory post-plug and pre-unplug callbacks into virtio-mem's
plug and unplug operations to support TDX memory acceptance and release.

For memory plugging, call the post-plug callback after successfully
requesting memory from the hypervisor to ensure newly added memory is
accepted by TDX guests. If acceptance fails, return -EINVAL to mark the
device as broken rather than attempting rollback, since unplug operations
may also fail and partial acceptance creates difficult-to-recover state.

For memory unplugging, call the pre-unplug callback before requesting
memory removal from the hypervisor to allow TDX guests to release memory
pages. If release fails, return -EINVAL to mark the device as broken.

If the hypervisor unplug request fails after successful memory release,
attempt to re-accept the memory to restore consistent state for retry. If
re-acceptance fails, mark the device as broken to prevent corruption.

The config_changed check is moved to the wrapper functions to ensure
callbacks are not invoked unnecessarily when operations will be retried.

This integration ensures proper memory lifecycle management in
confidential computing environments while maintaining backward
compatibility with non-TDX systems where the callbacks are no-ops.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 drivers/virtio/virtio_mem.c | 80 ++++++++++++++++++++++++++++++++-----
 1 file changed, 70 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 48051e9e98ab..12b8229dab0d 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1416,8 +1416,8 @@ static uint64_t virtio_mem_send_request(struct virtio_mem *vm,
 	return virtio16_to_cpu(vm->vdev, vm->resp.type);
 }
 
-static int virtio_mem_send_plug_request(struct virtio_mem *vm, uint64_t addr,
-					uint64_t size)
+static int _virtio_mem_send_plug_request(struct virtio_mem *vm, uint64_t addr,
+					 uint64_t size)
 {
 	const uint64_t nb_vm_blocks = size / vm->device_block_size;
 	const struct virtio_mem_req req = {
@@ -1427,9 +1427,6 @@ static int virtio_mem_send_plug_request(struct virtio_mem *vm, uint64_t addr,
 	};
 	int rc = -ENOMEM;
 
-	if (atomic_read(&vm->config_changed))
-		return -EAGAIN;
-
 	dev_dbg(&vm->vdev->dev, "plugging memory: 0x%llx - 0x%llx\n", addr,
 		addr + size - 1);
 
@@ -1454,8 +1451,8 @@ static int virtio_mem_send_plug_request(struct virtio_mem *vm, uint64_t addr,
 	return rc;
 }
 
-static int virtio_mem_send_unplug_request(struct virtio_mem *vm, uint64_t addr,
-					  uint64_t size)
+static int _virtio_mem_send_unplug_request(struct virtio_mem *vm, uint64_t addr,
+					   uint64_t size)
 {
 	const uint64_t nb_vm_blocks = size / vm->device_block_size;
 	const struct virtio_mem_req req = {
@@ -1465,9 +1462,6 @@ static int virtio_mem_send_unplug_request(struct virtio_mem *vm, uint64_t addr,
 	};
 	int rc = -ENOMEM;
 
-	if (atomic_read(&vm->config_changed))
-		return -EAGAIN;
-
 	dev_dbg(&vm->vdev->dev, "unplugging memory: 0x%llx - 0x%llx\n", addr,
 		addr + size - 1);
 
@@ -1489,6 +1483,72 @@ static int virtio_mem_send_unplug_request(struct virtio_mem *vm, uint64_t addr,
 	return rc;
 }
 
+static int virtio_mem_send_plug_request(struct virtio_mem *vm, uint64_t addr,
+					uint64_t size)
+{
+	int ret;
+
+	if (atomic_read(&vm->config_changed))
+		return -EAGAIN;
+
+	ret = _virtio_mem_send_plug_request(vm, addr, size);
+	if (ret)
+		return ret;
+
+	/*
+	 * If memory acceptance fails, we cannot safely rollback to the pre-plug
+	 * state because the unplug operation may also fail (e.g., hypervisor
+	 * out of memory, VM migration in progress). Additionally, acceptance
+	 * failures may be partial, leaving some pages accepted and others not,
+	 * creating inconsistent memory state that is difficult to track and
+	 * recover from.
+	 *
+	 * Rather than attempting complex state recovery that may fail, we treat
+	 * acceptance failure as a critical error and return -EINVAL. This causes
+	 * the caller to set the broken flag and stop processing further requests,
+	 * preventing potential memory corruption or system instability. As a
+	 * consequence, the hypervisor-side memory for the failing range is
+	 * leaked for the lifetime of the device.
+	 */
+	if (memory_post_plug_call(addr, size))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int virtio_mem_send_unplug_request(struct virtio_mem *vm, uint64_t addr,
+					  uint64_t size)
+{
+	int ret;
+
+	if (atomic_read(&vm->config_changed))
+		return -EAGAIN;
+
+	/*
+	 * If memory release fails, treat it as a critical error similar to
+	 * acceptance failure. See virtio_mem_send_plug_request() for detailed
+	 * rationale on why we avoid complex error recovery.
+	 */
+	ret = memory_pre_unplug_call(addr, size);
+	if (ret)
+		return -EINVAL;
+
+	ret = _virtio_mem_send_unplug_request(vm, addr, size);
+	/*
+	 * If the hypervisor unplug request fails (e.g., out of memory, VM
+	 * migration), the operation will be retried later. Since we already
+	 * released the memory from TDX perspective, we must re-accept it to
+	 * restore consistent state for the next retry. If re-acceptance fails,
+	 * treat it as critical error to prevent state corruption. As a
+	 * consequence, the hypervisor-side memory for the failing range is
+	 * leaked for the lifetime of the device.
+	 */
+	if (ret && memory_post_plug_call(addr, size))
+		return -EINVAL;
+
+	return ret;
+}
+
 static int virtio_mem_send_unplug_all_request(struct virtio_mem *vm)
 {
 	const struct virtio_mem_req req = {
-- 
2.52.0

