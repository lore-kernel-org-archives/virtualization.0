From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 10/21] virtio scsi: Convert to hotplug state machine
Date: Tue,  6 Sep 2016 19:04:46 +0200
Message-ID: <20160906170457.32393-11-bigeasy__18838.1353080787$1473181612$gmane$org@linutronix.de>
References: <20160906170457.32393-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160906170457.32393-1-bigeasy@linutronix.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, rt@linutronix.de, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

Install the callbacks via the state machine. It uses the multi instance
infrastructure of the hotplug code to handle each interface.

virtscsi_set_affinity() is removed from virtscsi_init() because
virtscsi_cpu_notif_add() (the function which registers the instance) is invoked
right after it and the cpuhp_state_add_instance() functions invokes the startup
callback on all online CPUs.

The same thing can not be applied virtscsi_cpu_notif_remove() because
virtscsi_remove_vqs() invokes virtscsi_set_affinity() with affinity = false as
argument but the old CPU_DEAD state invoked the function with affinity = true
(which does not match the DEAD callback).

Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/scsi/virtio_scsi.c | 76 ++++++++++++++++++++++++++++++----------------
 include/linux/cpuhotplug.h |  1 +
 2 files changed, 50 insertions(+), 27 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 7dbbb29d24c6..deefab3a94d0 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -107,8 +107,8 @@ struct virtio_scsi {
 	/* If the affinity hint is set for virtqueues */
 	bool affinity_hint_set;
 
-	/* CPU hotplug notifier */
-	struct notifier_block nb;
+	struct hlist_node node;
+	struct hlist_node node_dead;
 
 	/* Protected by event_vq lock */
 	bool stop_events;
@@ -118,6 +118,7 @@ struct virtio_scsi {
 	struct virtio_scsi_vq req_vqs[];
 };
 
+static enum cpuhp_state virtioscsi_online;
 static struct kmem_cache *virtscsi_cmd_cache;
 static mempool_t *virtscsi_cmd_pool;
 
@@ -852,21 +853,33 @@ static void virtscsi_set_affinity(struct virtio_scsi *vscsi, bool affinity)
 	put_online_cpus();
 }
 
-static int virtscsi_cpu_callback(struct notifier_block *nfb,
-				 unsigned long action, void *hcpu)
+static int virtscsi_cpu_online(unsigned int cpu, struct hlist_node *node)
 {
-	struct virtio_scsi *vscsi = container_of(nfb, struct virtio_scsi, nb);
-	switch(action) {
-	case CPU_ONLINE:
-	case CPU_ONLINE_FROZEN:
-	case CPU_DEAD:
-	case CPU_DEAD_FROZEN:
-		__virtscsi_set_affinity(vscsi, true);
-		break;
-	default:
-		break;
-	}
-	return NOTIFY_OK;
+	struct virtio_scsi *vscsi = hlist_entry_safe(node, struct virtio_scsi,
+						     node);
+	__virtscsi_set_affinity(vscsi, true);
+	return 0;
+}
+
+static int virtscsi_cpu_notif_add(struct virtio_scsi *vi)
+{
+	int ret;
+
+	ret = cpuhp_state_add_instance(virtioscsi_online, &vi->node);
+	if (ret)
+		return ret;
+
+	ret = cpuhp_state_add_instance(CPUHP_VIRT_SCSI_DEAD, &vi->node_dead);
+	if (ret)
+		cpuhp_state_remove_instance(virtioscsi_online, &vi->node);
+	return ret;
+}
+
+static void virtscsi_cpu_notif_remove(struct virtio_scsi *vi)
+{
+	cpuhp_state_remove_instance_nocalls(virtioscsi_online, &vi->node);
+	cpuhp_state_remove_instance_nocalls(CPUHP_VIRT_SCSI_DEAD,
+					    &vi->node_dead);
 }
 
 static void virtscsi_init_vq(struct virtio_scsi_vq *virtscsi_vq,
@@ -929,8 +942,6 @@ static int virtscsi_init(struct virtio_device *vdev,
 		virtscsi_init_vq(&vscsi->req_vqs[i - VIRTIO_SCSI_VQ_BASE],
 				 vqs[i]);
 
-	virtscsi_set_affinity(vscsi, true);
-
 	virtscsi_config_set(vdev, cdb_size, VIRTIO_SCSI_CDB_SIZE);
 	virtscsi_config_set(vdev, sense_size, VIRTIO_SCSI_SENSE_SIZE);
 
@@ -987,12 +998,9 @@ static int virtscsi_probe(struct virtio_device *vdev)
 	if (err)
 		goto virtscsi_init_failed;
 
-	vscsi->nb.notifier_call = &virtscsi_cpu_callback;
-	err = register_hotcpu_notifier(&vscsi->nb);
-	if (err) {
-		pr_err("registering cpu notifier failed\n");
+	err = virtscsi_cpu_notif_add(vscsi);
+	if (err)
 		goto scsi_add_host_failed;
-	}
 
 	cmd_per_lun = virtscsi_config_get(vdev, cmd_per_lun) ?: 1;
 	shost->cmd_per_lun = min_t(u32, cmd_per_lun, shost->can_queue);
@@ -1049,7 +1057,7 @@ static void virtscsi_remove(struct virtio_device *vdev)
 
 	scsi_remove_host(shost);
 
-	unregister_hotcpu_notifier(&vscsi->nb);
+	virtscsi_cpu_notif_remove(vscsi);
 
 	virtscsi_remove_vqs(vdev);
 	scsi_host_put(shost);
@@ -1061,7 +1069,7 @@ static int virtscsi_freeze(struct virtio_device *vdev)
 	struct Scsi_Host *sh = virtio_scsi_host(vdev);
 	struct virtio_scsi *vscsi = shost_priv(sh);
 
-	unregister_hotcpu_notifier(&vscsi->nb);
+	virtscsi_cpu_notif_remove(vscsi);
 	virtscsi_remove_vqs(vdev);
 	return 0;
 }
@@ -1076,12 +1084,11 @@ static int virtscsi_restore(struct virtio_device *vdev)
 	if (err)
 		return err;
 
-	err = register_hotcpu_notifier(&vscsi->nb);
+	err = virtscsi_cpu_notif_add(vscsi);
 	if (err) {
 		vdev->config->del_vqs(vdev);
 		return err;
 	}
-
 	virtio_device_ready(vdev);
 
 	if (virtio_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG))
@@ -1136,6 +1143,16 @@ static int __init init(void)
 		pr_err("mempool_create() for virtscsi_cmd_pool failed\n");
 		goto error;
 	}
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+				      "scsi/virtio:online",
+				      virtscsi_cpu_online, NULL);
+	if (ret < 0)
+		goto error;
+	virtioscsi_online = ret;
+	ret = cpuhp_setup_state_multi(CPUHP_VIRT_SCSI_DEAD, "scsi/virtio:dead",
+				      NULL, virtscsi_cpu_online);
+	if (ret)
+		goto error;
 	ret = register_virtio_driver(&virtio_scsi_driver);
 	if (ret < 0)
 		goto error;
@@ -1151,12 +1168,17 @@ static int __init init(void)
 		kmem_cache_destroy(virtscsi_cmd_cache);
 		virtscsi_cmd_cache = NULL;
 	}
+	if (virtioscsi_online)
+		cpuhp_remove_multi_state(virtioscsi_online);
+	cpuhp_remove_multi_state(CPUHP_VIRT_SCSI_DEAD);
 	return ret;
 }
 
 static void __exit fini(void)
 {
 	unregister_virtio_driver(&virtio_scsi_driver);
+	cpuhp_remove_multi_state(virtioscsi_online);
+	cpuhp_remove_multi_state(CPUHP_VIRT_SCSI_DEAD);
 	mempool_destroy(virtscsi_cmd_pool);
 	kmem_cache_destroy(virtscsi_cmd_cache);
 }
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index a12044828e03..73a4daf08c04 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -24,6 +24,7 @@ enum cpuhp_state {
 	CPUHP_ARM_OMAP_WAKE_DEAD,
 	CPUHP_IRQ_POLL_DEAD,
 	CPUHP_BLOCK_SOFTIRQ_DEAD,
+	CPUHP_VIRT_SCSI_DEAD,
 	CPUHP_WORKQUEUE_PREP,
 	CPUHP_POWER_NUMA_PREPARE,
 	CPUHP_HRTIMERS_PREPARE,
-- 
2.9.3
