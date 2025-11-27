Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B952C0281
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 03:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764213884; cv=none; b=QiYYqJIopBx5AJ8wrVjvJKEppGVku4QXnY5wwllje4bz371zZzjB8MUcCrrsCLJ9meXlJ4cB3BS2PWgUGyej9M8c7RUNJoo1D+cxI42chZpwnqqjoDvrhXQ6IerqCSMK+5JcHYd+XUMyp2pBFolO70Wm+dPI2U1DSQgc4D0X4Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764213884; c=relaxed/simple;
	bh=VP/TvNg7X9kCS18WZPUsWF6u6Pdhxo7mEuIq4rFCIkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eH3MrRaphYwPWw2XAIBL9PZKycuR61P73XRR+cdjy40Dm2081OD4E50c6diyUxzWDvZ+s+S4LlF3EeHMqD9T5GCl1IzCjSSCRoKJGGgacwoV3v0P2TI/Uarrss7IIjvfjI+Mtpr8hoz7QVc4BXbQHk6lymYKup+4ywSdXoOqTKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WIQjsAGy; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WIQjsAGy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dc
	MH9eg2vJnZR5ROOS4/gWbgDdIVGTzjBWRfJyxzzrE=; b=WIQjsAGyKanbnZ3i0R
	N9oX5V6jQo3PAJuoxaPOvtzbktFcHWRxtdkdJ7fwcTp3HK7lp8ncHsKOYSj4GDNx
	aQfhCJQNA/mlhVZePclv4pg8fsz/ZByQCU+b4K4cKAJba4aD1WQ9wOwvQ7CazeNy
	K3ITta+gASwr1zs8+gPywB2bU=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCX4NVfxCdptnYQFg--.3639S8;
	Thu, 27 Nov 2025 11:24:28 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: lange_tang@163.com,
	tanglongjun@kylinos.cn,
	virtualization@lists.linux.dev
Subject: [PATCH v1 6/7] tools/virtio/virtnet_mon: add kprobe skb_xmit_done and skb_recv_done
Date: Thu, 27 Nov 2025 11:24:06 +0800
Message-Id: <20251127032407.33475-7-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251127032407.33475-1-lange_tang@163.com>
References: <20251127032407.33475-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCX4NVfxCdptnYQFg--.3639S8
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFyrKw47AFyxKF43JrW5Jrb_yoW7JFy5pF
	s8Gw1YqrZ7JFsxua95J3y5Xr1Fkws3ArWxXr97ZwsFyrs8Jr1DZF17K3WYvFWfGFWrGr17
	Aw1Uta4F9FZrZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piKLvNUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbBdggTLmknu4n8ZwAAsk

From: Tang Longjun <tanglongjun@kylinos.cn>

track the status upon receiving host notifications by using the kprobe
functions skb_xmit_done and skb_recv_done.

Signed-off-by: Tang Longjun <tanglongjun@kylinos.cn>
---
 tools/virtio/virtnet_mon/virtnet_mon.c | 82 +++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 1 deletion(-)

diff --git a/tools/virtio/virtnet_mon/virtnet_mon.c b/tools/virtio/virtnet_mon/virtnet_mon.c
index 69b4afcbeb56..09f566d3443f 100644
--- a/tools/virtio/virtnet_mon/virtnet_mon.c
+++ b/tools/virtio/virtnet_mon/virtnet_mon.c
@@ -442,6 +442,10 @@ enum event_type {
 	GRO_RECEIVE_SKB_POST_EVENT = 4,
 	IP_LOCAL_DELIVER_PRE_EVENT = 5,
 	IP_LOCAL_DELIVER_POST_EVENT = 6,
+	SKB_XMIT_DONE_PRE_EVENT = 7,
+	SKB_XMIT_DONE_POST_EVENT = 8,
+	SKB_RECV_DONE_PRE_EVENT = 9,
+	SKB_RECV_DONE_POST_EVENT = 10,
 };
 
 struct iph_info {
@@ -485,6 +489,8 @@ static char read_buf[READ_SIZE];
 static struct kprobe start_xmit_kp;
 static struct kprobe gro_receive_skb_kp;
 static struct kprobe ip_local_deliver_kp;
+static struct kprobe skb_xmit_done_kp;
+static struct kprobe skb_recv_done_kp;
 
 /* convert pkt_dir to string */
 static const char *pkt_dir_to_str(enum pkt_dir dir)
@@ -530,6 +536,14 @@ static const char *event_type_to_str(enum event_type event_type)
 		return "IP_LOCAL_DELIVER_PRE_EVENT";
 	case IP_LOCAL_DELIVER_POST_EVENT:
 		return "IP_LOCAL_DELIVER_POST_EVENT";
+	case SKB_XMIT_DONE_PRE_EVENT:
+		return "SKB_XMIT_DONE_PRE_EVENT";
+	case SKB_XMIT_DONE_POST_EVENT:
+		return "SKB_XMIT_DONE_POST_EVENT";
+	case SKB_RECV_DONE_PRE_EVENT:
+		return "SKB_RECV_DONE_PRE_EVENT";
+	case SKB_RECV_DONE_POST_EVENT:
+		return "SKB_RECV_DONE_POST_EVENT";
 	default:
 		return "Unknown";
 	}
@@ -784,6 +798,46 @@ static int ip_local_deliver_pre_handler(struct kprobe *p, struct pt_regs *regs)
 	return 0;
 }
 
+/* Kprobe pre-handler for skb_xmit_done */
+static int skb_xmit_done_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct virtqueue *vq;
+	struct virtnet_mon_pkt_info info;
+
+	/* Get vq parameter (first parameter) */
+	vq = (struct virtqueue *)KP_GET_ARG(regs, 0);
+
+	memset(&info, 0, sizeof(struct virtnet_mon_pkt_info));
+	get_common_info(PKT_DIR_TX, SKB_XMIT_DONE_PRE_EVENT, &info);
+	if (get_queue_info(vq, &info.rx_tx_queue_info) != 0)
+		return 0;
+
+	kfifo_in(&virtnet_mon_kfifo, &info, 1);
+	wake_up_interruptible(&virtnet_mon_wq);
+
+	return 0;
+}
+
+/* Kprobe pre-handler for skb_recv_done */
+static int skb_recv_done_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct virtqueue *vq;
+	struct virtnet_mon_pkt_info info;
+
+	/* Get vq parameter (first parameter) */
+	vq = (struct virtqueue *)KP_GET_ARG(regs, 0);
+
+	memset(&info, 0, sizeof(struct virtnet_mon_pkt_info));
+	get_common_info(PKT_DIR_RX, SKB_RECV_DONE_PRE_EVENT, &info);
+	if (get_queue_info(vq, &info.rx_tx_queue_info) != 0)
+		return 0;
+
+	kfifo_in(&virtnet_mon_kfifo, &info, 1);
+	wake_up_interruptible(&virtnet_mon_wq);
+
+	return 0;
+}
+
 // open device
 static int virtnet_mon_open(struct inode *inode, struct file *file)
 {
@@ -943,6 +997,30 @@ static int __init virtnet_mon_init(void)
 	}
 	pr_info("virtnet_mon: Registered kprobe for ip_local_deliver\n");
 
+	/* Setup kprobe for skb_xmit_done */
+	skb_xmit_done_kp.pre_handler = skb_xmit_done_pre_handler;
+	skb_xmit_done_kp.symbol_name = "skb_xmit_done";
+
+	ret = register_kprobe(&skb_xmit_done_kp);
+	if (ret < 0) {
+		pr_info("virtnet_mon: Failed to register kprobe for skb_xmit_done: %d\n", ret);
+		unregister_kprobe(&skb_xmit_done_kp);
+		return ret;
+	}
+	pr_info("virtnet_mon: Registered kprobe for skb_xmit_done\n");
+
+	/* Setup kprobe for skb_recv_done */
+	skb_recv_done_kp.pre_handler = skb_recv_done_pre_handler;
+	skb_recv_done_kp.symbol_name = "skb_recv_done";
+
+	ret = register_kprobe(&skb_recv_done_kp);
+	if (ret < 0) {
+		pr_info("virtnet_mon: Failed to register kprobe for skb_recv_done: %d\n", ret);
+		unregister_kprobe(&skb_recv_done_kp);
+		return ret;
+	}
+	pr_info("virtnet_mon: Registered kprobe for skb_recv_done\n");
+
 	return 0;
 }
 
@@ -956,6 +1034,8 @@ static void __exit virtnet_mon_exit(void)
 	unregister_kprobe(&start_xmit_kp);
 	unregister_kprobe(&gro_receive_skb_kp);
 	unregister_kprobe(&ip_local_deliver_kp);
+	unregister_kprobe(&skb_xmit_done_kp);
+	unregister_kprobe(&skb_recv_done_kp);
 	pr_info("virtnet_mon: Unloading module\n");
 }
 
@@ -965,4 +1045,4 @@ module_exit(virtnet_mon_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Tang Longjun");
 MODULE_DESCRIPTION("Monitor virtio_net driver packet transmission and reception");
-MODULE_VERSION("0.2");
+MODULE_VERSION("0.3");
-- 
2.43.0

