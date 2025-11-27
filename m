Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF7B2BFC70
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 03:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764213882; cv=none; b=P28HFP4PAmoCxCwUliiTTBRj+0oR2DpE2eyPtVZRkhR2fI30Iw/hR0tZfWAiiY2ZuX0vhWAAWxz2fmcG/JtM2ZZMxopu6oUBE1+C3f5U5oln6j3kOg2yvf8A/31hGB5pI0ARI3yRrLZWlIbPZyYG3RfjkfeKRtaiqkjNcmkSfIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764213882; c=relaxed/simple;
	bh=zpwyD9LxEDNgFz2FXkrfy+kuD/+UqLOIpB26+Hn55HU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oclfO8Zh70hpp5CyDHaFoBhe4kOATtxXS+mEkGNHDlMbfGUQKw8XwNQi5ILryytnmLlU1ONJI8mj8UNVVBEbJcIOLC7rVYzeGhBq2cS8UpxMcLE4pi/ofbBD6E5X40g8yt+GttEzUS8HbOKA7fHyXJqAKKAPCYnzObCSOY2O608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IeNgvQvX; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IeNgvQvX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5t
	cO5VuywX5oAjfDbh7bUljxnC+grB7xED7njBekNtg=; b=IeNgvQvXFY98ZFKfG3
	RrJz7umhEThM1c7EQ49dhft+prET+qs2uWpGWxA/9La2mmCpuhw44vOj1ElimlFL
	QieOuRld/LJd3V7PovoDPGynbfCGFelMyUNdKxl47JVLBa1cETDAm/9JdG7s7l+s
	mFQKtCed/cMyWMRTxeSmDclHw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCX4NVfxCdptnYQFg--.3639S7;
	Thu, 27 Nov 2025 11:24:27 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: lange_tang@163.com,
	tanglongjun@kylinos.cn,
	virtualization@lists.linux.dev
Subject: [PATCH v1 5/7] tools/virtio/virtnet_mon: add kprobe ip_local_deliver
Date: Thu, 27 Nov 2025 11:24:05 +0800
Message-Id: <20251127032407.33475-6-lange_tang@163.com>
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
X-CM-TRANSID:PigvCgCX4NVfxCdptnYQFg--.3639S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxWryrJFWkAr43Cw47Xw1rCrg_yoW5urWkpF
	yDG3s0krWkJFsxWa93Ja15Wr1Skwn7CFyxCryxZw42yrs8Jw1kX3W7KF12gFWY9rWjkr1I
	yr43ta4Y9FnruFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piKLvNUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/1tbiXRgTLmknwAJ9CgABsC

From: Tang Longjun <tanglongjun@kylinos.cn>

track the IP header information of packets through the kprobe
ip_local_deliver function

Signed-off-by: Tang Longjun <tanglongjun@kylinos.cn>
---
 tools/virtio/virtnet_mon/virtnet_mon.c | 42 +++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/virtio/virtnet_mon/virtnet_mon.c b/tools/virtio/virtnet_mon/virtnet_mon.c
index 9c0b5ebc3f03..69b4afcbeb56 100644
--- a/tools/virtio/virtnet_mon/virtnet_mon.c
+++ b/tools/virtio/virtnet_mon/virtnet_mon.c
@@ -440,6 +440,8 @@ enum event_type {
 	START_XMIT_POST_EVENT = 2,
 	GRO_RECEIVE_SKB_PRE_EVENT = 3,
 	GRO_RECEIVE_SKB_POST_EVENT = 4,
+	IP_LOCAL_DELIVER_PRE_EVENT = 5,
+	IP_LOCAL_DELIVER_POST_EVENT = 6,
 };
 
 struct iph_info {
@@ -482,6 +484,7 @@ static char read_buf[READ_SIZE];
 
 static struct kprobe start_xmit_kp;
 static struct kprobe gro_receive_skb_kp;
+static struct kprobe ip_local_deliver_kp;
 
 /* convert pkt_dir to string */
 static const char *pkt_dir_to_str(enum pkt_dir dir)
@@ -522,7 +525,11 @@ static const char *event_type_to_str(enum event_type event_type)
 	case GRO_RECEIVE_SKB_PRE_EVENT:
 		return "GRO_RECEIVE_SKB_PRE_EVENT";
 	case GRO_RECEIVE_SKB_POST_EVENT:
-			return "GRO_RECEIVE_SKB_POST_EVENT";
+		return "GRO_RECEIVE_SKB_POST_EVENT";
+	case IP_LOCAL_DELIVER_PRE_EVENT:
+		return "IP_LOCAL_DELIVER_PRE_EVENT";
+	case IP_LOCAL_DELIVER_POST_EVENT:
+		return "IP_LOCAL_DELIVER_POST_EVENT";
 	default:
 		return "Unknown";
 	}
@@ -757,6 +764,26 @@ static int gro_receive_skb_pre_handler(struct kprobe *p, struct pt_regs *regs)
 	return 0;
 }
 
+/* Kprobe pre-handler for ip_local_deliver */
+static int ip_local_deliver_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct sk_buff *skb;
+	struct virtnet_mon_pkt_info info;
+
+	/* Get skb parameter (first parameter) */
+	skb = (struct sk_buff *)KP_GET_ARG(regs, 0);
+
+	memset(&info, 0, sizeof(struct virtnet_mon_pkt_info));
+	get_common_info(PKT_DIR_RX, IP_LOCAL_DELIVER_PRE_EVENT, &info);
+	if (get_iph_info(skb, &info.iph_info) != 0)
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
@@ -904,6 +931,18 @@ static int __init virtnet_mon_init(void)
 	}
 	pr_info("virtnet_mon: Registered kprobe for gro_receive_skb\n");
 
+	/* Setup kprobe for ip_local_deliver */
+	ip_local_deliver_kp.pre_handler = ip_local_deliver_pre_handler;
+	ip_local_deliver_kp.symbol_name = "ip_local_deliver";
+
+	ret = register_kprobe(&ip_local_deliver_kp);
+	if (ret < 0) {
+		pr_info("virtnet_mon: Failed to register kprobe for ip_local_deliver: %d\n", ret);
+		unregister_kprobe(&ip_local_deliver_kp);
+		return ret;
+	}
+	pr_info("virtnet_mon: Registered kprobe for ip_local_deliver\n");
+
 	return 0;
 }
 
@@ -916,6 +955,7 @@ static void __exit virtnet_mon_exit(void)
 	/* Unregister kprobes */
 	unregister_kprobe(&start_xmit_kp);
 	unregister_kprobe(&gro_receive_skb_kp);
+	unregister_kprobe(&ip_local_deliver_kp);
 	pr_info("virtnet_mon: Unloading module\n");
 }
 
-- 
2.43.0

