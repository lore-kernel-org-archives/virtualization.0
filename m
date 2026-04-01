Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0693C7DE5
	for <virtualization@lists.linux.dev>; Wed,  1 Apr 2026 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041971; cv=none; b=pxBsciohGFSSbgSVfjehjsnDUnZ/D25sU8KQ5j4SUDRPfgeNW+H0iTYiJyYxXQbJFUGKtXCwv2QmSprECdSWP6cutzd5S5K9h7i6jL8iqhf4EMDb3OhMYB7C9VxwKDw7ZXbyuhqNVqV8yoNID3SSqTJqrGIk2TIkt/5kKpaXtIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041971; c=relaxed/simple;
	bh=l7031pO/9+csvRDcUBB9IUff5JjlgcXfVmjawI6DbMg=;
	h=From:Date:Subject:MIME-Version:Message-Id:To:Cc:Content-Type; b=rGIUZrw/eXd37AdsKXe0LL1eOy1xEHcQzCyWV9hjP2m1ZiTCXF8hmGLqvZI3T1FwDRodeL1Z+eAaiyTJsQonl8NeigAt0LGGXFeGjTFCTVaWpL5o+KSK1RYRrQRGhdqjoTAOSbzi9t311vLm+HFmpvo8bsu5inf9+5lXfsl/c9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7b7Ae2/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7b7Ae2/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775041968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2CB21nD5AxdfTt+xVozs6vk1Zk6bTUrkKs07BKmFt9w=;
	b=W7b7Ae2/mzgE0pWrUh4Y6OsbqZI2Omwnle7zO/HDj3uD6kneEn46FqppkfOhCtB/aQyGIc
	pPqzVs193w966qe8R7oNy+BK+PLm8WxukmcRXatzsx3bWSDupqGXyicQHQy2yVGKKzVJjX
	tdRtgnpVVqlKZvimuOV25yRNMyLFsdQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-rRnMQcmcP_SzDJCNVNSF-g-1; Wed,
 01 Apr 2026 07:12:45 -0400
X-MC-Unique: rRnMQcmcP_SzDJCNVNSF-g-1
X-Mimecast-MFC-AGG-ID: rRnMQcmcP_SzDJCNVNSF-g_1775041964
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1555B195608C;
	Wed,  1 Apr 2026 11:12:44 +0000 (UTC)
Received: from localhost (unknown [10.44.22.22])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 344C519560AB;
	Wed,  1 Apr 2026 11:12:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 01 Apr 2026 15:12:34 +0400
Subject: [PATCH RFC] virtio-mem: support Confidential Computing (CoCo)
 environments
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260401-coco-v1-1-b9c3072e2d9c@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwND3eT85HxdA/M0Q0MTSzOzJAsjJaDSgqLUtMwKsDHRSkFuzkqxEMH
 i0qSs1OQSkAFKtbUACdT/CW0AAAA=
X-Change-ID: 20260401-coco-07f114966b82
To: David Hildenbrand <david@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Chenyi Qiang <chenyi.qiang@intel.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=12154;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=l7031pO/9+csvRDcUBB9IUff5JjlgcXfVmjawI6DbMg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpzP2m6jvb4PkfUloZ5+0Zyuu8j2MtFNeL432RD
 9JD73FoYUqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCacz9pgAKCRDa6OEJdZac
 5Y7UD/9A4wxjRaQiLlS+21iDUj5NoI5P4H0/Odjp4R9DRgdeJa+M78inRbkvFzG27GWk9dZEw2M
 GHQEtIT6BaT7EdWjztd17wf+1dN9T5x3Ac9gqmNoAnoTlItBryGwZRxWHyTHxniK83C00uxEQV6
 JC96Vt0QoRu2Up3TzDjkRfBXZvOvHRM4WVWN52Q/2bIlMOhn4+wHlGArxuQ1PgHTTyk8T4mR1xs
 8yUnHh/mzh5fnZWr+m4GbXv9dNM+XGKN0QNfgT9xtEkI67mXkPuuA+oB2VdNDE2n3juWXiHz8uo
 Ld3auprUAM1WxEKf0kPLlq4GAOLa2sutcvbfdMseEEcO32J+x9hjgFTtaLAkQgt8MQPhxQA8t6g
 ympUSYYx/PYDvUqAknWENlIslRbeR645Er1rj96DzMEFAmKbaYCxg+GEJzRaUZdvJbJve8yzSe6
 gEYBBwK8TzAWGsU7WYacngQqO52MLUXPDG0sWLV4e9ud3qdZeWmXz+v1M5qgXaELgrkb5170zRm
 f+VkiWIgXObNIEuPxun2TLbJjLoG8upq8JuZ9ATan7SA1k+wMVJcYupVdU5NvCStERNVyHCnrMu
 9f90D1T/fyNSGAzn5ZgFICNOxQIQ43XD5WcPhsEnIqa0Zlurn0Z/NJ9jNqzaLuDhMv8YHS5UajM
 CLitcjLgVvOFx0Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: WAV-F5UhqTih6TIF458y-RE-hA1r8Y5MghbFh3G-S2U_1775041964
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

In Confidential Computing (CoCo) environments such as Intel TDX or AMD
SEV-SNP, hotplugged memory must be explicitly "accepted" (transitioned to
a private/encrypted state) before it can be safely used by the guest.
Conversely, before returning memory to the hypervisor during an unplug
operation, it must be converted back to a shared/decrypted state.

Attempting to handle memory acceptance automatically using generic
architecture-level memory hotplug notifiers (e.g., MEM_GOING_ONLINE)
is not viable for devices like virtio-mem:

1. Granularity Mismatch: virtio-mem can dynamically hot(un)plug memory
   at a subblock granularity (e.g., 2MB chunks within a 128MB memory
   block). Generic memory notifiers operate on the entire memory block.
2. Lifecycle Control: Memory must be explicitly accepted *before* it is
   handed to the core memory management subsystem (the buddy allocator),
   and it must be decrypted *before* being handed back to the device.
3. State Tracking (Offline -> Re-online): If memory is offlined and
   re-onlined without proper state transitions, TDX will panic on
   attempting to accept an already-accepted page (TDX_EPT_ENTRY_STATE_INCORRECT).

To address this, this patch implements explicit CoCo memory conversions
directly within the virtio-mem driver using set_memory_encrypted() and
set_memory_decrypted():

- During hotplug, explicitly accepts only the physically plugged subblocks
  right before fake-onlining them into the buddy allocator.
- During unplug, memory is explicitly transitioned to the shared state
  before being handed back to the host. If the unplug operation fails,
  the driver attempts to re-accept (encrypt) the memory. If this
  re-acceptance fails, the memory is intentionally leaked to prevent
  confidentiality breaches or fatal hypervisor faults.

This was discovered while testing virtio-mem resize with TDX guests.
The associated QEMU virtio-mem + TDX patch series is under review at:
https://patchew.org/QEMU/20260226140001.3622334-1-marcandre.lureau@redhat.com/

Note that QEMU punches the guest_memfd on KVM_HC_MAP_GPA_RANGE, when the
guest memory is decrypted. There is thus no need to discard the guest_memfd
in the virtio-mem device.

This patch is a follow-up and supersedes "[PATCH 0/2] x86/tdx: Fix
memory hotplug in TDX guests".

Assisted-by: Claude:claude-opus-4-6
Reported-by: Chenyi Qiang <chenyi.qiang@intel.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 drivers/virtio/virtio_mem.c | 183 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 173 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 48051e9e98abf..518bc0aae5304 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -23,6 +23,8 @@
 #include <linux/log2.h>
 #include <linux/vmalloc.h>
 #include <linux/suspend.h>
+#include <linux/set_memory.h>
+#include <linux/cc_platform.h>
 
 #include <acpi/acpi_numa.h>
 
@@ -864,19 +866,90 @@ static bool virtio_mem_contains_range(struct virtio_mem *vm, uint64_t start,
 	return start >= vm->addr && start + size <= vm->addr + vm->region_size;
 }
 
+/*
+ * In CoCo (TDX, SEV-SNP) environments, hotplugged memory must be explicitly
+ * accepted before use (private/encrypted), and converted to shared/decrypted
+ * before returning to the hypervisor on unplug.
+ */
+static int virtio_mem_coco_set_encrypted(uint64_t addr, uint64_t size)
+{
+	return set_memory_encrypted((unsigned long)__va(addr), PFN_DOWN(size));
+}
+
+static int virtio_mem_coco_set_decrypted(uint64_t addr, uint64_t size)
+{
+	return set_memory_decrypted((unsigned long)__va(addr), PFN_DOWN(size));
+}
+
+/*
+ * Convert all plugged subblocks of a memory block back to shared/decrypted.
+ * Used to undo set_encrypted on failure or cancel.
+ */
+static void virtio_mem_sbm_coco_set_decrypted(struct virtio_mem *vm,
+					      unsigned long mb_id)
+{
+	int sb_id, count;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return;
+
+	for (sb_id = 0; sb_id < vm->sbm.sbs_per_mb; sb_id += count) {
+		count = 1;
+		if (!virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
+			continue;
+		while (sb_id + count < vm->sbm.sbs_per_mb &&
+		       virtio_mem_sbm_test_sb_plugged(vm, mb_id,
+						      sb_id + count, 1))
+			count++;
+		virtio_mem_coco_set_decrypted(
+			virtio_mem_mb_id_to_phys(mb_id) +
+				sb_id * vm->sbm.sb_size,
+			(uint64_t)count * vm->sbm.sb_size);
+	}
+}
+
 static int virtio_mem_sbm_notify_going_online(struct virtio_mem *vm,
 					      unsigned long mb_id)
 {
+	int sb_id, count, rc;
+
 	switch (virtio_mem_sbm_get_mb_state(vm, mb_id)) {
 	case VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL:
 	case VIRTIO_MEM_SBM_MB_OFFLINE:
-		return NOTIFY_OK;
-	default:
 		break;
+	default:
+		dev_warn_ratelimited(&vm->vdev->dev,
+				     "memory block onlining denied\n");
+		return NOTIFY_BAD;
+	}
+
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return NOTIFY_OK;
+
+	/*
+	 * In CoCo environments, explicitly accept plugged subblocks before
+	 * they get onlined and handed to the buddy. Only accept at subblock
+	 * granularity -- unplugged subblocks have no backing in the secure
+	 * page tables (SEPT) and accepting them would fail.
+	 */
+	for (sb_id = 0; sb_id < vm->sbm.sbs_per_mb; sb_id += count) {
+		count = 1;
+		if (!virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
+			continue;
+		/* Coalesce consecutive plugged subblocks */
+		while (sb_id + count < vm->sbm.sbs_per_mb &&
+		       virtio_mem_sbm_test_sb_plugged(vm, mb_id,
+						      sb_id + count, 1))
+			count++;
+		rc = virtio_mem_coco_set_encrypted(
+			virtio_mem_mb_id_to_phys(mb_id) +
+				sb_id * vm->sbm.sb_size,
+			(uint64_t)count * vm->sbm.sb_size);
+		if (rc)
+			return NOTIFY_BAD;
 	}
-	dev_warn_ratelimited(&vm->vdev->dev,
-			     "memory block onlining denied\n");
-	return NOTIFY_BAD;
+
+	return NOTIFY_OK;
 }
 
 static void virtio_mem_sbm_notify_offline(struct virtio_mem *vm,
@@ -1055,8 +1128,16 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 			break;
 		}
 		vm->hotplug_active = true;
-		if (vm->in_sbm)
+		if (vm->in_sbm) {
 			rc = virtio_mem_sbm_notify_going_online(vm, id);
+		} else {
+			/*
+			 * For BBM, accept the whole memory block range. Unlike
+			 * SBM, the entire big block is always plugged.
+			 */
+			if (virtio_mem_coco_set_encrypted(start, size))
+				rc = NOTIFY_BAD;
+		}
 		break;
 	case MEM_OFFLINE:
 		if (vm->in_sbm)
@@ -1106,6 +1187,14 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 	case MEM_CANCEL_ONLINE:
 		if (!vm->hotplug_active)
 			break;
+		/*
+		 * Undo CoCo acceptance done in MEM_GOING_ONLINE. Pages were
+		 * made private but never onlined -- convert back to shared.
+		 */
+		if (vm->in_sbm)
+			virtio_mem_sbm_coco_set_decrypted(vm, id);
+		else
+			virtio_mem_coco_set_decrypted(start, size);
 		vm->hotplug_active = false;
 		mutex_unlock(&vm->hotplug_mutex);
 		break;
@@ -1583,12 +1672,17 @@ static int virtio_mem_bbm_plug_bb(struct virtio_mem *vm, unsigned long bb_id)
  * memory block. Will fail if any subblock cannot get unplugged (instead of
  * skipping it).
  *
+ * If @coco_shared is true, convert each subblock range to shared/decrypted
+ * before unplugging. This is required for offline blocks that have a direct
+ * map but must not be used for blocks in PLUGGED state (no direct map).
+ *
  * Will not modify the state of the memory block.
  *
  * Note: can fail after some subblocks were unplugged.
  */
 static int virtio_mem_sbm_unplug_any_sb_raw(struct virtio_mem *vm,
-					    unsigned long mb_id, uint64_t *nb_sb)
+					    unsigned long mb_id, uint64_t *nb_sb,
+					    bool coco_shared)
 {
 	int sb_id, count;
 	int rc;
@@ -1609,6 +1703,15 @@ static int virtio_mem_sbm_unplug_any_sb_raw(struct virtio_mem *vm,
 			sb_id--;
 		}
 
+		if (coco_shared) {
+			rc = virtio_mem_coco_set_decrypted(
+				virtio_mem_mb_id_to_phys(mb_id) +
+					sb_id * vm->sbm.sb_size,
+				(uint64_t)count * vm->sbm.sb_size);
+			if (rc)
+				return rc;
+		}
+
 		rc = virtio_mem_sbm_unplug_sb(vm, mb_id, sb_id, count);
 		if (rc)
 			return rc;
@@ -1630,7 +1733,11 @@ static int virtio_mem_sbm_unplug_mb(struct virtio_mem *vm, unsigned long mb_id)
 {
 	uint64_t nb_sb = vm->sbm.sbs_per_mb;
 
-	return virtio_mem_sbm_unplug_any_sb_raw(vm, mb_id, &nb_sb);
+	/*
+	 * Called for PLUGGED blocks (add_memory failed) -- no direct map
+	 * exists, so CoCo conversion is not possible.
+	 */
+	return virtio_mem_sbm_unplug_any_sb_raw(vm, mb_id, &nb_sb, false);
 }
 
 /*
@@ -1744,6 +1851,17 @@ static int virtio_mem_sbm_plug_any_sb(struct virtio_mem *vm,
 		if (old_state == VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL)
 			continue;
 
+		/* Accept memory for CoCo before fake-onlining into buddy */
+		rc = virtio_mem_coco_set_encrypted(
+			virtio_mem_mb_id_to_phys(mb_id) +
+				sb_id * vm->sbm.sb_size,
+			(uint64_t)count * vm->sbm.sb_size);
+		if (rc) {
+			virtio_mem_sbm_unplug_sb(vm, mb_id, sb_id, count);
+			*nb_sb += count;
+			return rc;
+		}
+
 		/* fake-online the pages if the memory block is online */
 		pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
 			       sb_id * vm->sbm.sb_size);
@@ -1941,7 +2059,8 @@ static int virtio_mem_sbm_unplug_any_sb_offline(struct virtio_mem *vm,
 {
 	int rc;
 
-	rc = virtio_mem_sbm_unplug_any_sb_raw(vm, mb_id, nb_sb);
+	/* Offline blocks have a direct map -- convert for CoCo before unplug */
+	rc = virtio_mem_sbm_unplug_any_sb_raw(vm, mb_id, nb_sb, true);
 
 	/* some subblocks might have been unplugged even on failure */
 	if (!virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->sbm.sbs_per_mb))
@@ -1989,10 +2108,32 @@ static int virtio_mem_sbm_unplug_sb_online(struct virtio_mem *vm,
 	if (rc)
 		return rc;
 
+	/* Convert private→shared for CoCo before handing back to device */
+	rc = virtio_mem_coco_set_decrypted(
+		virtio_mem_mb_id_to_phys(mb_id) +
+			sb_id * vm->sbm.sb_size,
+		(uint64_t)count * vm->sbm.sb_size);
+	if (rc) {
+		virtio_mem_fake_online(start_pfn, nr_pages);
+		return rc;
+	}
+
 	/* Try to unplug the allocated memory */
 	rc = virtio_mem_sbm_unplug_sb(vm, mb_id, sb_id, count);
 	if (rc) {
-		/* Return the memory to the buddy. */
+		/*
+		 * Try to return the memory to the buddy. If set_encrypted
+		 * fails, we must not fake-online shared memory -- that would
+		 * be a CoCo confidentiality breach. Leak the memory instead.
+		 */
+		if (virtio_mem_coco_set_encrypted(
+			    virtio_mem_mb_id_to_phys(mb_id) +
+				    sb_id * vm->sbm.sb_size,
+			    (uint64_t)count * vm->sbm.sb_size)) {
+			dev_err(&vm->vdev->dev,
+				"CoCo set_encrypted failed, leaking memory\n");
+			return rc;
+		}
 		virtio_mem_fake_online(start_pfn, nr_pages);
 		return rc;
 	}
@@ -2191,8 +2332,30 @@ static int virtio_mem_bbm_offline_remove_and_unplug_bb(struct virtio_mem *vm,
 	}
 	mutex_unlock(&vm->hotplug_mutex);
 
+	/*
+	 * Convert private→shared for CoCo while direct map still exists.
+	 * Must happen before offline_and_remove tears down the mapping.
+	 */
+	rc = virtio_mem_coco_set_decrypted(
+		virtio_mem_bb_id_to_phys(vm, bb_id), vm->bbm.bb_size);
+	if (rc) {
+		mutex_lock(&vm->hotplug_mutex);
+		goto rollback;
+	}
+
 	rc = virtio_mem_bbm_offline_and_remove_bb(vm, bb_id);
 	if (rc) {
+		/*
+		 * Try to re-accept the memory for CoCo. If this fails, we
+		 * must not fake-online shared memory -- leak it instead.
+		 */
+		if (virtio_mem_coco_set_encrypted(
+			    virtio_mem_bb_id_to_phys(vm, bb_id),
+			    vm->bbm.bb_size)) {
+			dev_err(&vm->vdev->dev,
+				"CoCo set_encrypted failed, leaking memory\n");
+			return rc;
+		}
 		mutex_lock(&vm->hotplug_mutex);
 		goto rollback;
 	}

---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260401-coco-07f114966b82

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>

