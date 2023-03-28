Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08FDC77B6F
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 09:29:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9BFE0415ED;
	Tue, 28 Mar 2023 09:29:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9BFE0415ED
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jyL7LBtO41Uv; Tue, 28 Mar 2023 09:29:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6CEB9416B3;
	Tue, 28 Mar 2023 09:29:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6CEB9416B3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2BF0C007C;
	Tue, 28 Mar 2023 09:29:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22771C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:29:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 34F8E411A9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:29:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 34F8E411A9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8FW3GuoRVAV3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:29:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B15994158F
Received: from out30-101.freemail.mail.aliyun.com
 (out30-101.freemail.mail.aliyun.com [115.124.30.101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B15994158F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:28:59 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VesbhfA_1679995732; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VesbhfA_1679995732) by smtp.aliyun-inc.com;
 Tue, 28 Mar 2023 17:28:53 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH 04/16] virtio_net: separating cpu-related funs
Date: Tue, 28 Mar 2023 17:28:35 +0800
Message-Id: <20230328092847.91643-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230328092847.91643-1-xuanzhuo@linux.alibaba.com>
References: <20230328092847.91643-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: e880b402863c
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

Add a file virtnet_common.c to save the common funcs.
This patch moves the cpu-related funs into it.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/Makefile         |   2 +-
 drivers/net/virtio/virtnet.c        | 132 ++------------------------
 drivers/net/virtio/virtnet_common.c | 138 ++++++++++++++++++++++++++++
 drivers/net/virtio/virtnet_common.h |  14 +++
 4 files changed, 163 insertions(+), 123 deletions(-)
 create mode 100644 drivers/net/virtio/virtnet_common.c
 create mode 100644 drivers/net/virtio/virtnet_common.h

diff --git a/drivers/net/virtio/Makefile b/drivers/net/virtio/Makefile
index ccd45c0e5064..3bef2b51876c 100644
--- a/drivers/net/virtio/Makefile
+++ b/drivers/net/virtio/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
 
-virtio_net-y := virtnet.o
+virtio_net-y := virtnet.o virtnet_common.o
diff --git a/drivers/net/virtio/virtnet.c b/drivers/net/virtio/virtnet.c
index 92ef95c163b6..3fcf70782d97 100644
--- a/drivers/net/virtio/virtnet.c
+++ b/drivers/net/virtio/virtnet.c
@@ -14,7 +14,6 @@
 #include <linux/scatterlist.h>
 #include <linux/if_vlan.h>
 #include <linux/slab.h>
-#include <linux/cpu.h>
 #include <linux/filter.h>
 #include <linux/kernel.h>
 #include <net/route.h>
@@ -22,6 +21,7 @@
 #include <net/net_failover.h>
 
 #include "virtnet.h"
+#include "virtnet_common.h"
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -2233,108 +2233,6 @@ static int virtnet_vlan_rx_kill_vid(struct net_device *dev,
 	return 0;
 }
 
-static void virtnet_clean_affinity(struct virtnet_info *vi)
-{
-	int i;
-
-	if (vi->affinity_hint_set) {
-		for (i = 0; i < vi->max_queue_pairs; i++) {
-			virtqueue_set_affinity(vi->rq[i].vq, NULL);
-			virtqueue_set_affinity(vi->sq[i].vq, NULL);
-		}
-
-		vi->affinity_hint_set = false;
-	}
-}
-
-static void virtnet_set_affinity(struct virtnet_info *vi)
-{
-	cpumask_var_t mask;
-	int stragglers;
-	int group_size;
-	int i, j, cpu;
-	int num_cpu;
-	int stride;
-
-	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
-		virtnet_clean_affinity(vi);
-		return;
-	}
-
-	num_cpu = num_online_cpus();
-	stride = max_t(int, num_cpu / vi->curr_queue_pairs, 1);
-	stragglers = num_cpu >= vi->curr_queue_pairs ?
-			num_cpu % vi->curr_queue_pairs :
-			0;
-	cpu = cpumask_first(cpu_online_mask);
-
-	for (i = 0; i < vi->curr_queue_pairs; i++) {
-		group_size = stride + (i < stragglers ? 1 : 0);
-
-		for (j = 0; j < group_size; j++) {
-			cpumask_set_cpu(cpu, mask);
-			cpu = cpumask_next_wrap(cpu, cpu_online_mask,
-						nr_cpu_ids, false);
-		}
-		virtqueue_set_affinity(vi->rq[i].vq, mask);
-		virtqueue_set_affinity(vi->sq[i].vq, mask);
-		__netif_set_xps_queue(vi->dev, cpumask_bits(mask), i, XPS_CPUS);
-		cpumask_clear(mask);
-	}
-
-	vi->affinity_hint_set = true;
-	free_cpumask_var(mask);
-}
-
-static int virtnet_cpu_online(unsigned int cpu, struct hlist_node *node)
-{
-	struct virtnet_info *vi = hlist_entry_safe(node, struct virtnet_info,
-						   node);
-	virtnet_set_affinity(vi);
-	return 0;
-}
-
-static int virtnet_cpu_dead(unsigned int cpu, struct hlist_node *node)
-{
-	struct virtnet_info *vi = hlist_entry_safe(node, struct virtnet_info,
-						   node_dead);
-	virtnet_set_affinity(vi);
-	return 0;
-}
-
-static int virtnet_cpu_down_prep(unsigned int cpu, struct hlist_node *node)
-{
-	struct virtnet_info *vi = hlist_entry_safe(node, struct virtnet_info,
-						   node);
-
-	virtnet_clean_affinity(vi);
-	return 0;
-}
-
-static enum cpuhp_state virtionet_online;
-
-static int virtnet_cpu_notif_add(struct virtnet_info *vi)
-{
-	int ret;
-
-	ret = cpuhp_state_add_instance_nocalls(virtionet_online, &vi->node);
-	if (ret)
-		return ret;
-	ret = cpuhp_state_add_instance_nocalls(CPUHP_VIRT_NET_DEAD,
-					       &vi->node_dead);
-	if (!ret)
-		return ret;
-	cpuhp_state_remove_instance_nocalls(virtionet_online, &vi->node);
-	return ret;
-}
-
-static void virtnet_cpu_notif_remove(struct virtnet_info *vi)
-{
-	cpuhp_state_remove_instance_nocalls(virtionet_online, &vi->node);
-	cpuhp_state_remove_instance_nocalls(CPUHP_VIRT_NET_DEAD,
-					    &vi->node_dead);
-}
-
 static void virtnet_get_ringparam(struct net_device *dev,
 				  struct ethtool_ringparam *ring,
 				  struct kernel_ethtool_ringparam *kernel_ring,
@@ -4091,34 +3989,24 @@ static __init int virtio_net_driver_init(void)
 {
 	int ret;
 
-	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "virtio/net:online",
-				      virtnet_cpu_online,
-				      virtnet_cpu_down_prep);
-	if (ret < 0)
-		goto out;
-	virtionet_online = ret;
-	ret = cpuhp_setup_state_multi(CPUHP_VIRT_NET_DEAD, "virtio/net:dead",
-				      NULL, virtnet_cpu_dead);
+	ret = virtnet_cpuhp_setup();
 	if (ret)
-		goto err_dead;
+		return ret;
+
 	ret = register_virtio_driver(&virtio_net_driver);
-	if (ret)
-		goto err_virtio;
+	if (ret) {
+		virtnet_cpuhp_remove();
+		return ret;
+	}
+
 	return 0;
-err_virtio:
-	cpuhp_remove_multi_state(CPUHP_VIRT_NET_DEAD);
-err_dead:
-	cpuhp_remove_multi_state(virtionet_online);
-out:
-	return ret;
 }
 module_init(virtio_net_driver_init);
 
 static __exit void virtio_net_driver_exit(void)
 {
 	unregister_virtio_driver(&virtio_net_driver);
-	cpuhp_remove_multi_state(CPUHP_VIRT_NET_DEAD);
-	cpuhp_remove_multi_state(virtionet_online);
+	virtnet_cpuhp_remove();
 }
 module_exit(virtio_net_driver_exit);
 
diff --git a/drivers/net/virtio/virtnet_common.c b/drivers/net/virtio/virtnet_common.c
new file mode 100644
index 000000000000..bf0bac0b8704
--- /dev/null
+++ b/drivers/net/virtio/virtnet_common.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+#include <linux/cpu.h>
+#include <linux/netdevice.h>
+#include <linux/virtio.h>
+#include <linux/virtio_net.h>
+
+#include "virtnet.h"
+#include "virtnet_common.h"
+
+void virtnet_clean_affinity(struct virtnet_info *vi)
+{
+	int i;
+
+	if (vi->affinity_hint_set) {
+		for (i = 0; i < vi->max_queue_pairs; i++) {
+			virtqueue_set_affinity(vi->rq[i].vq, NULL);
+			virtqueue_set_affinity(vi->sq[i].vq, NULL);
+		}
+
+		vi->affinity_hint_set = false;
+	}
+}
+
+void virtnet_set_affinity(struct virtnet_info *vi)
+{
+	cpumask_var_t mask;
+	int stragglers;
+	int group_size;
+	int i, j, cpu;
+	int num_cpu;
+	int stride;
+
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
+		virtnet_clean_affinity(vi);
+		return;
+	}
+
+	num_cpu = num_online_cpus();
+	stride = max_t(int, num_cpu / vi->curr_queue_pairs, 1);
+	stragglers = num_cpu >= vi->curr_queue_pairs ?
+			num_cpu % vi->curr_queue_pairs :
+			0;
+	cpu = cpumask_first(cpu_online_mask);
+
+	for (i = 0; i < vi->curr_queue_pairs; i++) {
+		group_size = stride + (i < stragglers ? 1 : 0);
+
+		for (j = 0; j < group_size; j++) {
+			cpumask_set_cpu(cpu, mask);
+			cpu = cpumask_next_wrap(cpu, cpu_online_mask,
+						nr_cpu_ids, false);
+		}
+		virtqueue_set_affinity(vi->rq[i].vq, mask);
+		virtqueue_set_affinity(vi->sq[i].vq, mask);
+		__netif_set_xps_queue(vi->dev, cpumask_bits(mask), i, XPS_CPUS);
+		cpumask_clear(mask);
+	}
+
+	vi->affinity_hint_set = true;
+	free_cpumask_var(mask);
+}
+
+static int virtnet_cpu_online(unsigned int cpu, struct hlist_node *node)
+{
+	struct virtnet_info *vi = hlist_entry_safe(node, struct virtnet_info,
+						   node);
+	virtnet_set_affinity(vi);
+	return 0;
+}
+
+static int virtnet_cpu_dead(unsigned int cpu, struct hlist_node *node)
+{
+	struct virtnet_info *vi = hlist_entry_safe(node, struct virtnet_info,
+						   node_dead);
+	virtnet_set_affinity(vi);
+	return 0;
+}
+
+static int virtnet_cpu_down_prep(unsigned int cpu, struct hlist_node *node)
+{
+	struct virtnet_info *vi = hlist_entry_safe(node, struct virtnet_info,
+						   node);
+
+	virtnet_clean_affinity(vi);
+	return 0;
+}
+
+static enum cpuhp_state virtionet_online;
+
+int virtnet_cpu_notif_add(struct virtnet_info *vi)
+{
+	int ret;
+
+	ret = cpuhp_state_add_instance_nocalls(virtionet_online, &vi->node);
+	if (ret)
+		return ret;
+	ret = cpuhp_state_add_instance_nocalls(CPUHP_VIRT_NET_DEAD,
+					       &vi->node_dead);
+	if (!ret)
+		return ret;
+	cpuhp_state_remove_instance_nocalls(virtionet_online, &vi->node);
+	return ret;
+}
+
+void virtnet_cpu_notif_remove(struct virtnet_info *vi)
+{
+	cpuhp_state_remove_instance_nocalls(virtionet_online, &vi->node);
+	cpuhp_state_remove_instance_nocalls(CPUHP_VIRT_NET_DEAD,
+					    &vi->node_dead);
+}
+
+void virtnet_cpuhp_remove(void)
+{
+	cpuhp_remove_multi_state(CPUHP_VIRT_NET_DEAD);
+	cpuhp_remove_multi_state(virtionet_online);
+}
+
+int virtnet_cpuhp_setup(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "virtio/net:online",
+				      virtnet_cpu_online,
+				      virtnet_cpu_down_prep);
+	if (ret < 0)
+		return ret;
+
+	virtionet_online = ret;
+	ret = cpuhp_setup_state_multi(CPUHP_VIRT_NET_DEAD, "virtio/net:dead",
+				      NULL, virtnet_cpu_dead);
+	if (ret) {
+		cpuhp_remove_multi_state(virtionet_online);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/virtio/virtnet_common.h b/drivers/net/virtio/virtnet_common.h
new file mode 100644
index 000000000000..0ee955950e5a
--- /dev/null
+++ b/drivers/net/virtio/virtnet_common.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __VIRTNET_COMMON_H__
+#define __VIRTNET_COMMON_H__
+
+void virtnet_clean_affinity(struct virtnet_info *vi);
+void virtnet_set_affinity(struct virtnet_info *vi);
+int virtnet_cpu_notif_add(struct virtnet_info *vi);
+void virtnet_cpu_notif_remove(struct virtnet_info *vi);
+
+void virtnet_cpuhp_remove(void);
+int virtnet_cpuhp_setup(void);
+
+#endif
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
