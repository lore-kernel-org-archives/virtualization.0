Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC5728641F
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 03:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764213881; cv=none; b=OL7UiPOImFph40gD9CsF4+soEsCWKSnyF43Nv5tX3f2G8/K0au3Qn6JWwVt85ahRZVZnCWOmbb0J3wTgoUxVf0uwxAuWatV2bPcliYhZt4AxW2XfDD2CHSr0G2oOUuc3jQkf7/UvYztO+ocQGJgsG7upKPNxDXJp4wbsTJLBNZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764213881; c=relaxed/simple;
	bh=fPlyqQr49glVGATZzi+fz0WZwWDcPckmBqD2UkCeF7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BCHPOCkbsouQo1aqddX5zxlS6xcYG/lzWFR41plH1+yUroOXv6ptgbLbd6uOwNwdznms7TFXPmLVdCdlElq73DYC9ofJuKVhVH+crBAjXSxZK9S+vVcafwEe2p2R9bzbAPKnC5ZsUB1V87W2j24XiAogkB6qD5gA0FSwK3woWhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MwzLwHPf; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MwzLwHPf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Pe
	ZYUp9LMAwWEXrwXeflLEYfJrGO9s5Jxrqp8B6vXcc=; b=MwzLwHPf92+7LRcjY/
	3E7Q63xX+NUQm/g5RTUUipUOO+iFeA00SeDJoEgOXJvQ3ajhhrwAN+Tal/9+AWFY
	1+SviCDk1vbfqm6V5545+zuo7J1XfEnepAasrtXx5cQ+oio6dtQ4Q1apQwmHclm+
	AnusVmto2lRjTTBC56nDFtk9E=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCX4NVfxCdptnYQFg--.3639S6;
	Thu, 27 Nov 2025 11:24:26 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: lange_tang@163.com,
	tanglongjun@kylinos.cn,
	virtualization@lists.linux.dev
Subject: [PATCH v1 4/7] tools/virtio/virtnet_mon: add kprobe gro_receive_skb
Date: Thu, 27 Nov 2025 11:24:04 +0800
Message-Id: <20251127032407.33475-5-lange_tang@163.com>
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
X-CM-TRANSID:PigvCgCX4NVfxCdptnYQFg--.3639S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFy8Zw4fuw1kXw47GFyfJFb_yoW5Zw1DpF
	45tr1Yvr4ktrnxWay5JFWUXr1S9Fn3ArWxAr97uw10vrs5Gr18XF17tayqgr4FyFW8Gr17
	Ar4DtayF9a9rurJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piKFAJUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbBdg0TLmknu4n8JgABsh

From: Tang Longjun <tanglongjun@kylinos.cn>

track the timestamp when packets enter the network stack using
the kprobe on the gro_receive_skb function

Signed-off-by: Tang Longjun <tanglongjun@kylinos.cn>
---
 tools/virtio/virtnet_mon/virtnet_mon.c | 46 ++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/virtio/virtnet_mon/virtnet_mon.c b/tools/virtio/virtnet_mon/virtnet_mon.c
index 36b51d0a13d4..9c0b5ebc3f03 100644
--- a/tools/virtio/virtnet_mon/virtnet_mon.c
+++ b/tools/virtio/virtnet_mon/virtnet_mon.c
@@ -438,6 +438,8 @@ enum pkt_dir {
 enum event_type {
 	START_XMIT_PRE_EVENT = 1,
 	START_XMIT_POST_EVENT = 2,
+	GRO_RECEIVE_SKB_PRE_EVENT = 3,
+	GRO_RECEIVE_SKB_POST_EVENT = 4,
 };
 
 struct iph_info {
@@ -479,6 +481,7 @@ static DECLARE_WAIT_QUEUE_HEAD(virtnet_mon_wq);
 static char read_buf[READ_SIZE];
 
 static struct kprobe start_xmit_kp;
+static struct kprobe gro_receive_skb_kp;
 
 /* convert pkt_dir to string */
 static const char *pkt_dir_to_str(enum pkt_dir dir)
@@ -516,6 +519,10 @@ static const char *event_type_to_str(enum event_type event_type)
 		return "START_XMIT_PRE_EVENT";
 	case START_XMIT_POST_EVENT:
 		return "START_XMIT_POST_EVENT";
+	case GRO_RECEIVE_SKB_PRE_EVENT:
+		return "GRO_RECEIVE_SKB_PRE_EVENT";
+	case GRO_RECEIVE_SKB_POST_EVENT:
+			return "GRO_RECEIVE_SKB_POST_EVENT";
 	default:
 		return "Unknown";
 	}
@@ -724,6 +731,32 @@ static int start_xmit_pre_handler(struct kprobe *p, struct pt_regs *regs)
 	return 0;
 }
 
+/* Kprobe pre-handler for gro_receive_skb */
+static int gro_receive_skb_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct sk_buff *skb;
+	struct virtnet_mon_pkt_info info;
+	struct _virtnet_info *vi;
+	int qnum;
+
+	/* Get skb parameter (second parameter) */
+	skb = (struct sk_buff *)KP_GET_ARG(regs, 1);
+
+	memset(&info, 0, sizeof(struct virtnet_mon_pkt_info));
+	get_common_info(PKT_DIR_RX, GRO_RECEIVE_SKB_PRE_EVENT, &info);
+
+	vi = netdev_priv(skb->dev);
+	qnum = skb_get_rx_queue(skb);
+
+	if (get_queue_info(vi->rq[qnum].vq, &info.rx_tx_queue_info) != 0)
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
@@ -859,6 +892,18 @@ static int __init virtnet_mon_init(void)
 	}
 	pr_info("virtnet_mon: Registered kprobe for start_xmit\n");
 
+	/* Setup kprobe for gro_receive_skb */
+	gro_receive_skb_kp.pre_handler = gro_receive_skb_pre_handler;
+	gro_receive_skb_kp.symbol_name = "gro_receive_skb";
+
+	ret = register_kprobe(&gro_receive_skb_kp);
+	if (ret < 0) {
+		pr_info("virtnet_mon: Failed to register kprobe for gro_receive_skb: %d\n", ret);
+		unregister_kprobe(&gro_receive_skb_kp);
+		return ret;
+	}
+	pr_info("virtnet_mon: Registered kprobe for gro_receive_skb\n");
+
 	return 0;
 }
 
@@ -870,6 +915,7 @@ static void __exit virtnet_mon_exit(void)
 
 	/* Unregister kprobes */
 	unregister_kprobe(&start_xmit_kp);
+	unregister_kprobe(&gro_receive_skb_kp);
 	pr_info("virtnet_mon: Unloading module\n");
 }
 
-- 
2.43.0

