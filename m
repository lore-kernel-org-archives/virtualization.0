From: Andrei Vagin <avagin@openvz.org>
Subject: [PATCH net-next] net: allow to call netif_reset_xps_queues() under
	cpu_read_lock
Date: Mon,  6 Aug 2018 21:14:54 -0700
Message-ID: <20180807041454.18315-1-avagin@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "David S. Miller" <davem@davemloft.net>
Cc: "Nambiar, Amritha" <amritha.nambiar@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Andrei Vagin <avagin@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Andrei Vagin <avagin@gmail.com>

The definition of static_key_slow_inc() has cpus_read_lock in place. In the
virtio_net driver, XPS queues are initialized after setting the queue:cpu
affinity in virtnet_set_affinity() which is already protected within
cpus_read_lock. Lockdep prints a warning when we are trying to acquire
cpus_read_lock when it is already held.

This patch adds an ability to call __netif_set_xps_queue under
cpu_read_lock().

============================================
WARNING: possible recursive locking detected
4.18.0-rc3-next-20180703+ #1 Not tainted
--------------------------------------------
swapper/0/1 is trying to acquire lock:
00000000cf973d46 (cpu_hotplug_lock.rw_sem){++++}, at: static_key_slow_inc+0xe/0x20

but task is already holding lock:
00000000cf973d46 (cpu_hotplug_lock.rw_sem){++++}, at: init_vqs+0x513/0x5a0

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(cpu_hotplug_lock.rw_sem);
  lock(cpu_hotplug_lock.rw_sem);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by swapper/0/1:
 #0: 00000000244bc7da (&dev->mutex){....}, at: __driver_attach+0x5a/0x110
 #1: 00000000cf973d46 (cpu_hotplug_lock.rw_sem){++++}, at: init_vqs+0x513/0x5a0
 #2: 000000005cd8463f (xps_map_mutex){+.+.}, at: __netif_set_xps_queue+0x8d/0xc60

Cc: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Fixes: 8af2c06ff4b1 ("net-sysfs: Add interface for Rx queue(s) map per Tx queue")

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 drivers/net/virtio_net.c  |  4 +++-
 include/linux/netdevice.h |  2 +-
 net/core/dev.c            | 23 +++++++++++++++++------
 net/core/net-sysfs.c      |  2 +-
 4 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 62311dde6e71..a4abcfcf26b2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1903,9 +1903,11 @@ static void virtnet_set_affinity(struct virtnet_info *vi)
 
 	i = 0;
 	for_each_online_cpu(cpu) {
+		const unsigned long *mask = cpumask_bits(cpumask_of(cpu));
+
 		virtqueue_set_affinity(vi->rq[i].vq, cpu);
 		virtqueue_set_affinity(vi->sq[i].vq, cpu);
-		netif_set_xps_queue(vi->dev, cpumask_of(cpu), i);
+		__netif_set_xps_queue(vi->dev, mask, i, false, true);
 		i++;
 	}
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 282e2e95ad5b..124f9a00ce71 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3320,7 +3320,7 @@ static inline void netif_wake_subqueue(struct net_device *dev, u16 queue_index)
 int netif_set_xps_queue(struct net_device *dev, const struct cpumask *mask,
 			u16 index);
 int __netif_set_xps_queue(struct net_device *dev, const unsigned long *mask,
-			  u16 index, bool is_rxqs_map);
+			  u16 index, bool is_rxqs_map, bool cpuslocked);
 
 /**
  *	netif_attr_test_mask - Test a CPU or Rx queue set in a mask
diff --git a/net/core/dev.c b/net/core/dev.c
index f68122f0ab02..d6a0f64ccdd9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2176,6 +2176,7 @@ static void netif_reset_xps_queues(struct net_device *dev, u16 offset,
 	if (!static_key_false(&xps_needed))
 		return;
 
+	cpus_read_lock();
 	mutex_lock(&xps_map_mutex);
 
 	if (static_key_false(&xps_rxqs_needed)) {
@@ -2199,10 +2200,11 @@ static void netif_reset_xps_queues(struct net_device *dev, u16 offset,
 
 out_no_maps:
 	if (static_key_enabled(&xps_rxqs_needed))
-		static_key_slow_dec(&xps_rxqs_needed);
+		static_key_slow_dec_cpuslocked(&xps_rxqs_needed);
 
-	static_key_slow_dec(&xps_needed);
+	static_key_slow_dec_cpuslocked(&xps_needed);
 	mutex_unlock(&xps_map_mutex);
+	cpus_read_unlock();
 }
 
 static void netif_reset_xps_queues_gt(struct net_device *dev, u16 index)
@@ -2251,7 +2253,7 @@ static struct xps_map *expand_xps_map(struct xps_map *map, int attr_index,
 }
 
 int __netif_set_xps_queue(struct net_device *dev, const unsigned long *mask,
-			  u16 index, bool is_rxqs_map)
+			  u16 index, bool is_rxqs_map, bool cpuslocked)
 {
 	const unsigned long *online_mask = NULL, *possible_mask = NULL;
 	struct xps_dev_maps *dev_maps, *new_dev_maps = NULL;
@@ -2275,6 +2277,9 @@ int __netif_set_xps_queue(struct net_device *dev, const unsigned long *mask,
 			return -EINVAL;
 	}
 
+	if (!cpuslocked)
+		cpus_read_lock();
+
 	mutex_lock(&xps_map_mutex);
 	if (is_rxqs_map) {
 		maps_sz = XPS_RXQ_DEV_MAPS_SIZE(num_tc, dev->num_rx_queues);
@@ -2317,9 +2322,9 @@ int __netif_set_xps_queue(struct net_device *dev, const unsigned long *mask,
 	if (!new_dev_maps)
 		goto out_no_new_maps;
 
-	static_key_slow_inc(&xps_needed);
+	static_key_slow_inc_cpuslocked(&xps_needed);
 	if (is_rxqs_map)
-		static_key_slow_inc(&xps_rxqs_needed);
+		static_key_slow_inc_cpuslocked(&xps_rxqs_needed);
 
 	for (j = -1; j = netif_attrmask_next(j, possible_mask, nr_ids),
 	     j < nr_ids;) {
@@ -2427,6 +2432,8 @@ int __netif_set_xps_queue(struct net_device *dev, const unsigned long *mask,
 
 out_no_maps:
 	mutex_unlock(&xps_map_mutex);
+	if (!cpuslocked)
+		cpus_read_unlock();
 
 	return 0;
 error:
@@ -2444,15 +2451,19 @@ int __netif_set_xps_queue(struct net_device *dev, const unsigned long *mask,
 	}
 
 	mutex_unlock(&xps_map_mutex);
+	if (!cpuslocked)
+		cpus_read_unlock();
 
 	kfree(new_dev_maps);
 	return -ENOMEM;
 }
+EXPORT_SYMBOL_GPL(__netif_set_xps_queue);
 
 int netif_set_xps_queue(struct net_device *dev, const struct cpumask *mask,
 			u16 index)
 {
-	return __netif_set_xps_queue(dev, cpumask_bits(mask), index, false);
+	return __netif_set_xps_queue(dev, cpumask_bits(mask),
+						index, false, false);
 }
 EXPORT_SYMBOL(netif_set_xps_queue);
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 0a95bcf64cdc..06a141445d80 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1400,7 +1400,7 @@ static ssize_t xps_rxqs_store(struct netdev_queue *queue, const char *buf,
 		return err;
 	}
 
-	err = __netif_set_xps_queue(dev, mask, index, true);
+	err = __netif_set_xps_queue(dev, mask, index, true, false);
 	kfree(mask);
 	return err ? : len;
 }
-- 
2.17.1
