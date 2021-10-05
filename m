Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAC8C433F5
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 12:19:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6002E6120D
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 12:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6002E6120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3185883BBB;
	Tue,  5 Oct 2021 12:19:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r4dCGC1PQgJL; Tue,  5 Oct 2021 12:19:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8D0E483BA0;
	Tue,  5 Oct 2021 12:19:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7315FC0011;
	Tue,  5 Oct 2021 12:19:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9E3EC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 12:19:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ABB0A60B38
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 12:19:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ULUT8JoRL7Pk
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 12:19:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8D4E060B2A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 12:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633436376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iz/bJO8gGfz6X0Xatxi/OuCnSQ7Id+RJEaaGs0FeG00=;
 b=HXZYheV9k5PnHV40d2MYFcGwJhr25VVMdc9kOybnNm83aIrOyTCbKuIjak83GrRAZFZ0q9
 G3h5i3oKkp5wzYgzJB5Qb2iT22glfvuVARdZtf4nFu+7NXOvS+6ypxQ2oJoL5IuEhlnnWG
 f8d6akgOe5UEoBAFt/9EDXTPJiAHi+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-Q6nJ3M9xMvO3xKykIuWtCQ-1; Tue, 05 Oct 2021 08:19:35 -0400
X-MC-Unique: Q6nJ3M9xMvO3xKykIuWtCQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B72726D50A;
 Tue,  5 Oct 2021 12:19:32 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50F061F41E;
 Tue,  5 Oct 2021 12:18:50 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] virtio-mem: kdump mode to sanitize /proc/vmcore access
Date: Tue,  5 Oct 2021 14:14:30 +0200
Message-Id: <20211005121430.30136-10-david@redhat.com>
In-Reply-To: <20211005121430.30136-1-david@redhat.com>
References: <20211005121430.30136-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Michal Hocko <mhocko@suse.com>, x86@kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Stefano Stabellini <sstabellini@kernel.org>, Baoquan He <bhe@redhat.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org,
 Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Oscar Salvador <osalvador@suse.de>, Juergen Gross <jgross@suse.com>,
 kexec@lists.infradead.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Although virtio-mem currently supports reading unplugged memory in the
hypervisor, this will change in the future, indicated to the device via
a new feature flag. We similarly sanitized /proc/kcore access recently. [1]

Let's register a vmcore callback, to allow vmcore code to check if a PFN
belonging to a virtio-mem device is either currently plugged and should
be dumped or is currently unplugged and should not be accessed, instead
mapping the shared zeropage or returning zeroes when reading.

This is important when not capturing /proc/vmcore via tools like
"makedumpfile" that can identify logically unplugged virtio-mem memory via
PG_offline in the memmap, but simply by e.g., copying the file.

Distributions that support virtio-mem+kdump have to make sure that the
virtio_mem module will be part of the kdump kernel or the kdump initrd;
dracut was recently [2] extended to include virtio-mem in the generated
initrd. As long as no special kdump kernels are used, this will
automatically make sure that virtio-mem will be around in the kdump initrd
and sanitize /proc/vmcore access -- with dracut.

With this series, we'll send one virtio-mem state request for every
~2 MiB chunk of virtio-mem memory indicated in the vmcore that we intend
to read/map.

In the future, we might want to allow building virtio-mem for kdump
mode only, even without CONFIG_MEMORY_HOTPLUG and friends: this way,
we could support special stripped-down kdump kernels that have many
other config options disabled; we'll tackle that once required. Further,
we might want to try sensing bigger blocks (e.g., memory sections)
first before falling back to device blocks on demand.

Tested with Fedora rawhide, which contains a recent kexec-tools version
(considering "System RAM (virtio_mem)" when creating the vmcore header) and
a recent dracut version (including the virtio_mem module in the kdump
initrd).

[1] https://lkml.kernel.org/r/20210526093041.8800-1-david@redhat.com
[2] https://github.com/dracutdevs/dracut/pull/1157

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 136 ++++++++++++++++++++++++++++++++----
 1 file changed, 124 insertions(+), 12 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 76d8aef3cfd2..3573b78f6b05 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -223,6 +223,9 @@ struct virtio_mem {
 	 * When this lock is held the pointers can't change, ONLINE and
 	 * OFFLINE blocks can't change the state and no subblocks will get
 	 * plugged/unplugged.
+	 *
+	 * In kdump mode, used to serialize requests, last_block_addr and
+	 * last_block_plugged.
 	 */
 	struct mutex hotplug_mutex;
 	bool hotplug_active;
@@ -230,6 +233,9 @@ struct virtio_mem {
 	/* An error occurred we cannot handle - stop processing requests. */
 	bool broken;
 
+	/* Cached valued of is_kdump_kernel() when the device was probed. */
+	bool in_kdump;
+
 	/* The driver is being removed. */
 	spinlock_t removal_lock;
 	bool removing;
@@ -243,6 +249,13 @@ struct virtio_mem {
 	/* Memory notifier (online/offline events). */
 	struct notifier_block memory_notifier;
 
+#ifdef CONFIG_PROC_VMCORE
+	/* vmcore callback for /proc/vmcore handling in kdump mode */
+	struct vmcore_cb vmcore_cb;
+	uint64_t last_block_addr;
+	bool last_block_plugged;
+#endif /* CONFIG_PROC_VMCORE */
+
 	/* Next device in the list of virtio-mem devices. */
 	struct list_head next;
 };
@@ -2293,6 +2306,12 @@ static void virtio_mem_run_wq(struct work_struct *work)
 	uint64_t diff;
 	int rc;
 
+	if (unlikely(vm->in_kdump)) {
+		dev_warn_once(&vm->vdev->dev,
+			     "unexpected workqueue run in kdump kernel\n");
+		return;
+	}
+
 	hrtimer_cancel(&vm->retry_timer);
 
 	if (vm->broken)
@@ -2521,6 +2540,86 @@ static int virtio_mem_init_hotplug(struct virtio_mem *vm)
 	return rc;
 }
 
+#ifdef CONFIG_PROC_VMCORE
+static int virtio_mem_send_state_request(struct virtio_mem *vm, uint64_t addr,
+					 uint64_t size)
+{
+	const uint64_t nb_vm_blocks = size / vm->device_block_size;
+	const struct virtio_mem_req req = {
+		.type = cpu_to_virtio16(vm->vdev, VIRTIO_MEM_REQ_STATE),
+		.u.state.addr = cpu_to_virtio64(vm->vdev, addr),
+		.u.state.nb_blocks = cpu_to_virtio16(vm->vdev, nb_vm_blocks),
+	};
+	int rc = -ENOMEM;
+
+	dev_dbg(&vm->vdev->dev, "requesting state: 0x%llx - 0x%llx\n", addr,
+		addr + size - 1);
+
+	switch (virtio_mem_send_request(vm, &req)) {
+	case VIRTIO_MEM_RESP_ACK:
+		return virtio16_to_cpu(vm->vdev, vm->resp.u.state.state);
+	case VIRTIO_MEM_RESP_ERROR:
+		rc = -EINVAL;
+		break;
+	default:
+		break;
+	}
+
+	dev_dbg(&vm->vdev->dev, "requesting state failed: %d\n", rc);
+	return rc;
+}
+
+static bool virtio_mem_vmcore_pfn_is_ram(struct vmcore_cb *cb,
+					 unsigned long pfn)
+{
+	struct virtio_mem *vm = container_of(cb, struct virtio_mem,
+					     vmcore_cb);
+	uint64_t addr = PFN_PHYS(pfn);
+	bool is_ram;
+	int rc;
+
+	if (!virtio_mem_contains_range(vm, addr, PAGE_SIZE))
+		return true;
+	if (!vm->plugged_size)
+		return false;
+
+	/*
+	 * We have to serialize device requests and access to the information
+	 * about the block queried last.
+	 */
+	mutex_lock(&vm->hotplug_mutex);
+
+	addr = ALIGN_DOWN(addr, vm->device_block_size);
+	if (addr != vm->last_block_addr) {
+		rc = virtio_mem_send_state_request(vm, addr,
+						   vm->device_block_size);
+		/* On any kind of error, we're going to signal !ram. */
+		if (rc == VIRTIO_MEM_STATE_PLUGGED)
+			vm->last_block_plugged = true;
+		else
+			vm->last_block_plugged = false;
+		vm->last_block_addr = addr;
+	}
+
+	is_ram = vm->last_block_plugged;
+	mutex_unlock(&vm->hotplug_mutex);
+	return is_ram;
+}
+#endif /* CONFIG_PROC_VMCORE */
+
+static int virtio_mem_init_kdump(struct virtio_mem *vm)
+{
+#ifdef CONFIG_PROC_VMCORE
+	dev_info(&vm->vdev->dev, "memory hot(un)plug disabled in kdump kernel\n");
+	vm->vmcore_cb.pfn_is_ram = virtio_mem_vmcore_pfn_is_ram;
+	register_vmcore_cb(&vm->vmcore_cb);
+	return 0;
+#else /* CONFIG_PROC_VMCORE */
+	dev_warn(&vm->vdev->dev, "disabled in kdump kernel without vmcore\n");
+	return -EBUSY;
+#endif /* CONFIG_PROC_VMCORE */
+}
+
 static int virtio_mem_init(struct virtio_mem *vm)
 {
 	uint16_t node_id;
@@ -2530,15 +2629,6 @@ static int virtio_mem_init(struct virtio_mem *vm)
 		return -EINVAL;
 	}
 
-	/*
-	 * We don't want to (un)plug or reuse any memory when in kdump. The
-	 * memory is still accessible (but not mapped).
-	 */
-	if (is_kdump_kernel()) {
-		dev_warn(&vm->vdev->dev, "disabled in kdump kernel\n");
-		return -EBUSY;
-	}
-
 	/* Fetch all properties that can't change. */
 	virtio_cread_le(vm->vdev, struct virtio_mem_config, plugged_size,
 			&vm->plugged_size);
@@ -2562,6 +2652,12 @@ static int virtio_mem_init(struct virtio_mem *vm)
 	if (vm->nid != NUMA_NO_NODE && IS_ENABLED(CONFIG_NUMA))
 		dev_info(&vm->vdev->dev, "nid: %d", vm->nid);
 
+	/*
+	 * We don't want to (un)plug or reuse any memory when in kdump. The
+	 * memory is still accessible (but not exposed to Linux).
+	 */
+	if (vm->in_kdump)
+		return virtio_mem_init_kdump(vm);
 	return virtio_mem_init_hotplug(vm);
 }
 
@@ -2640,6 +2736,7 @@ static int virtio_mem_probe(struct virtio_device *vdev)
 	hrtimer_init(&vm->retry_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	vm->retry_timer.function = virtio_mem_timer_expired;
 	vm->retry_timer_ms = VIRTIO_MEM_RETRY_TIMER_MIN_MS;
+	vm->in_kdump = is_kdump_kernel();
 
 	/* register the virtqueue */
 	rc = virtio_mem_init_vq(vm);
@@ -2654,8 +2751,10 @@ static int virtio_mem_probe(struct virtio_device *vdev)
 	virtio_device_ready(vdev);
 
 	/* trigger a config update to start processing the requested_size */
-	atomic_set(&vm->config_changed, 1);
-	queue_work(system_freezable_wq, &vm->wq);
+	if (!vm->in_kdump) {
+		atomic_set(&vm->config_changed, 1);
+		queue_work(system_freezable_wq, &vm->wq);
+	}
 
 	return 0;
 out_del_vq:
@@ -2732,11 +2831,21 @@ static void virtio_mem_deinit_hotplug(struct virtio_mem *vm)
 	}
 }
 
+static void virtio_mem_deinit_kdump(struct virtio_mem *vm)
+{
+#ifdef CONFIG_PROC_VMCORE
+	unregister_vmcore_cb(&vm->vmcore_cb);
+#endif /* CONFIG_PROC_VMCORE */
+}
+
 static void virtio_mem_remove(struct virtio_device *vdev)
 {
 	struct virtio_mem *vm = vdev->priv;
 
-	virtio_mem_deinit_hotplug(vm);
+	if (vm->in_kdump)
+		virtio_mem_deinit_kdump(vm);
+	else
+		virtio_mem_deinit_hotplug(vm);
 
 	/* reset the device and cleanup the queues */
 	vdev->config->reset(vdev);
@@ -2750,6 +2859,9 @@ static void virtio_mem_config_changed(struct virtio_device *vdev)
 {
 	struct virtio_mem *vm = vdev->priv;
 
+	if (unlikely(vm->in_kdump))
+		return;
+
 	atomic_set(&vm->config_changed, 1);
 	virtio_mem_retry(vm);
 }
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
