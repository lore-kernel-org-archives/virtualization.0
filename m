Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA6AC48BE6
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 08:22:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664706142E
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 08:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664706142E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 265844038F;
	Thu, 10 Jun 2021 08:22:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hnMpjePdpx_p; Thu, 10 Jun 2021 08:22:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 91E00401D1;
	Thu, 10 Jun 2021 08:22:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CF8FC000D;
	Thu, 10 Jun 2021 08:22:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3291BC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0AA7B606F8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ohNu633TeFCf
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A84C26058B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:13 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=21; SR=0; TI=SMTPD_---0UbxK9UC_1623313329; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0UbxK9UC_1623313329) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 10 Jun 2021 16:22:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v5 01/15] netdevice: priv_flags extend to 64bit
Date: Thu, 10 Jun 2021 16:21:55 +0800
Message-Id: <20210610082209.91487-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210610082209.91487-1-xuanzhuo@linux.alibaba.com>
References: <20210610082209.91487-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
 "dust . li" <dust.li@linux.alibaba.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

The size of priv_flags is 32 bits, and the number of flags currently
available has reached 32. It is time to expand the size of priv_flags to
64 bits.

Here the priv_flags is modified to 8 bytes, but the size of struct
net_device has not changed, it is still 2176 bytes. It is because _tx is
aligned based on the cache line. But there is a 4-byte hole left here.

Since the fields before and after priv_flags are read mostly, I did not
adjust the order of the fields here.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/linux/netdevice.h | 140 ++++++++++++++++++++------------------
 net/8021q/vlanproc.c      |   2 +-
 2 files changed, 73 insertions(+), 69 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index be1dcceda5e4..3202e055b305 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1549,9 +1549,9 @@ struct net_device_ops {
                                                          struct net_device_path *path);
 };
 
+typedef u64 netdev_priv_flags_t;
+
 /**
- * enum netdev_priv_flags - &struct net_device priv_flags
- *
  * These are the &struct net_device, they are only set internally
  * by drivers and used in the kernel. These flags are invisible to
  * userspace; this means that the order of these flags can change
@@ -1597,73 +1597,76 @@ struct net_device_ops {
  * @IFF_TX_SKB_NO_LINEAR: device/driver is capable of xmitting frames with
  *	skb_headlen(skb) == 0 (data starts from frag0)
  */
-enum netdev_priv_flags {
-	IFF_802_1Q_VLAN			= 1<<0,
-	IFF_EBRIDGE			= 1<<1,
-	IFF_BONDING			= 1<<2,
-	IFF_ISATAP			= 1<<3,
-	IFF_WAN_HDLC			= 1<<4,
-	IFF_XMIT_DST_RELEASE		= 1<<5,
-	IFF_DONT_BRIDGE			= 1<<6,
-	IFF_DISABLE_NETPOLL		= 1<<7,
-	IFF_MACVLAN_PORT		= 1<<8,
-	IFF_BRIDGE_PORT			= 1<<9,
-	IFF_OVS_DATAPATH		= 1<<10,
-	IFF_TX_SKB_SHARING		= 1<<11,
-	IFF_UNICAST_FLT			= 1<<12,
-	IFF_TEAM_PORT			= 1<<13,
-	IFF_SUPP_NOFCS			= 1<<14,
-	IFF_LIVE_ADDR_CHANGE		= 1<<15,
-	IFF_MACVLAN			= 1<<16,
-	IFF_XMIT_DST_RELEASE_PERM	= 1<<17,
-	IFF_L3MDEV_MASTER		= 1<<18,
-	IFF_NO_QUEUE			= 1<<19,
-	IFF_OPENVSWITCH			= 1<<20,
-	IFF_L3MDEV_SLAVE		= 1<<21,
-	IFF_TEAM			= 1<<22,
-	IFF_RXFH_CONFIGURED		= 1<<23,
-	IFF_PHONY_HEADROOM		= 1<<24,
-	IFF_MACSEC			= 1<<25,
-	IFF_NO_RX_HANDLER		= 1<<26,
-	IFF_FAILOVER			= 1<<27,
-	IFF_FAILOVER_SLAVE		= 1<<28,
-	IFF_L3MDEV_RX_HANDLER		= 1<<29,
-	IFF_LIVE_RENAME_OK		= 1<<30,
-	IFF_TX_SKB_NO_LINEAR		= 1<<31,
+enum {
+	IFF_802_1Q_VLAN_BIT,
+	IFF_EBRIDGE_BIT,
+	IFF_BONDING_BIT,
+	IFF_ISATAP_BIT,
+	IFF_WAN_HDLC_BIT,
+	IFF_XMIT_DST_RELEASE_BIT,
+	IFF_DONT_BRIDGE_BIT,
+	IFF_DISABLE_NETPOLL_BIT,
+	IFF_MACVLAN_PORT_BIT,
+	IFF_BRIDGE_PORT_BIT,
+	IFF_OVS_DATAPATH_BIT,
+	IFF_TX_SKB_SHARING_BIT,
+	IFF_UNICAST_FLT_BIT,
+	IFF_TEAM_PORT_BIT,
+	IFF_SUPP_NOFCS_BIT,
+	IFF_LIVE_ADDR_CHANGE_BIT,
+	IFF_MACVLAN_BIT,
+	IFF_XMIT_DST_RELEASE_PERM_BIT,
+	IFF_L3MDEV_MASTER_BIT,
+	IFF_NO_QUEUE_BIT,
+	IFF_OPENVSWITCH_BIT,
+	IFF_L3MDEV_SLAVE_BIT,
+	IFF_TEAM_BIT,
+	IFF_RXFH_CONFIGURED_BIT,
+	IFF_PHONY_HEADROOM_BIT,
+	IFF_MACSEC_BIT,
+	IFF_NO_RX_HANDLER_BIT,
+	IFF_FAILOVER_BIT,
+	IFF_FAILOVER_SLAVE_BIT,
+	IFF_L3MDEV_RX_HANDLER_BIT,
+	IFF_LIVE_RENAME_OK_BIT,
+	IFF_TX_SKB_NO_LINEAR_BIT,
 };
 
-#define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
-#define IFF_EBRIDGE			IFF_EBRIDGE
-#define IFF_BONDING			IFF_BONDING
-#define IFF_ISATAP			IFF_ISATAP
-#define IFF_WAN_HDLC			IFF_WAN_HDLC
-#define IFF_XMIT_DST_RELEASE		IFF_XMIT_DST_RELEASE
-#define IFF_DONT_BRIDGE			IFF_DONT_BRIDGE
-#define IFF_DISABLE_NETPOLL		IFF_DISABLE_NETPOLL
-#define IFF_MACVLAN_PORT		IFF_MACVLAN_PORT
-#define IFF_BRIDGE_PORT			IFF_BRIDGE_PORT
-#define IFF_OVS_DATAPATH		IFF_OVS_DATAPATH
-#define IFF_TX_SKB_SHARING		IFF_TX_SKB_SHARING
-#define IFF_UNICAST_FLT			IFF_UNICAST_FLT
-#define IFF_TEAM_PORT			IFF_TEAM_PORT
-#define IFF_SUPP_NOFCS			IFF_SUPP_NOFCS
-#define IFF_LIVE_ADDR_CHANGE		IFF_LIVE_ADDR_CHANGE
-#define IFF_MACVLAN			IFF_MACVLAN
-#define IFF_XMIT_DST_RELEASE_PERM	IFF_XMIT_DST_RELEASE_PERM
-#define IFF_L3MDEV_MASTER		IFF_L3MDEV_MASTER
-#define IFF_NO_QUEUE			IFF_NO_QUEUE
-#define IFF_OPENVSWITCH			IFF_OPENVSWITCH
-#define IFF_L3MDEV_SLAVE		IFF_L3MDEV_SLAVE
-#define IFF_TEAM			IFF_TEAM
-#define IFF_RXFH_CONFIGURED		IFF_RXFH_CONFIGURED
-#define IFF_PHONY_HEADROOM		IFF_PHONY_HEADROOM
-#define IFF_MACSEC			IFF_MACSEC
-#define IFF_NO_RX_HANDLER		IFF_NO_RX_HANDLER
-#define IFF_FAILOVER			IFF_FAILOVER
-#define IFF_FAILOVER_SLAVE		IFF_FAILOVER_SLAVE
-#define IFF_L3MDEV_RX_HANDLER		IFF_L3MDEV_RX_HANDLER
-#define IFF_LIVE_RENAME_OK		IFF_LIVE_RENAME_OK
-#define IFF_TX_SKB_NO_LINEAR		IFF_TX_SKB_NO_LINEAR
+#define __IFF_BIT(bit)		((netdev_priv_flags_t)1 << (bit))
+#define __IFF(name)		__IFF_BIT(IFF_##name##_BIT)
+
+#define IFF_802_1Q_VLAN			__IFF(802_1Q_VLAN)
+#define IFF_EBRIDGE			__IFF(EBRIDGE)
+#define IFF_BONDING			__IFF(BONDING)
+#define IFF_ISATAP			__IFF(ISATAP)
+#define IFF_WAN_HDLC			__IFF(WAN_HDLC)
+#define IFF_XMIT_DST_RELEASE		__IFF(XMIT_DST_RELEASE)
+#define IFF_DONT_BRIDGE			__IFF(DONT_BRIDGE)
+#define IFF_DISABLE_NETPOLL		__IFF(DISABLE_NETPOLL)
+#define IFF_MACVLAN_PORT		__IFF(MACVLAN_PORT)
+#define IFF_BRIDGE_PORT			__IFF(BRIDGE_PORT)
+#define IFF_OVS_DATAPATH		__IFF(OVS_DATAPATH)
+#define IFF_TX_SKB_SHARING		__IFF(TX_SKB_SHARING)
+#define IFF_UNICAST_FLT			__IFF(UNICAST_FLT)
+#define IFF_TEAM_PORT			__IFF(TEAM_PORT)
+#define IFF_SUPP_NOFCS			__IFF(SUPP_NOFCS)
+#define IFF_LIVE_ADDR_CHANGE		__IFF(LIVE_ADDR_CHANGE)
+#define IFF_MACVLAN			__IFF(MACVLAN)
+#define IFF_XMIT_DST_RELEASE_PERM	__IFF(XMIT_DST_RELEASE_PERM)
+#define IFF_L3MDEV_MASTER		__IFF(L3MDEV_MASTER)
+#define IFF_NO_QUEUE			__IFF(NO_QUEUE)
+#define IFF_OPENVSWITCH			__IFF(OPENVSWITCH)
+#define IFF_L3MDEV_SLAVE		__IFF(L3MDEV_SLAVE)
+#define IFF_TEAM			__IFF(TEAM)
+#define IFF_RXFH_CONFIGURED		__IFF(RXFH_CONFIGURED)
+#define IFF_PHONY_HEADROOM		__IFF(PHONY_HEADROOM)
+#define IFF_MACSEC			__IFF(MACSEC)
+#define IFF_NO_RX_HANDLER		__IFF(NO_RX_HANDLER)
+#define IFF_FAILOVER			__IFF(FAILOVER)
+#define IFF_FAILOVER_SLAVE		__IFF(FAILOVER_SLAVE)
+#define IFF_L3MDEV_RX_HANDLER		__IFF(L3MDEV_RX_HANDLER)
+#define IFF_LIVE_RENAME_OK		__IFF(LIVE_RENAME_OK)
+#define IFF_TX_SKB_NO_LINEAR		__IFF(TX_SKB_NO_LINEAR)
 
 /* Specifies the type of the struct net_device::ml_priv pointer */
 enum netdev_ml_priv_type {
@@ -1963,7 +1966,8 @@ struct net_device {
 
 	/* Read-mostly cache-line for fast-path access */
 	unsigned int		flags;
-	unsigned int		priv_flags;
+	/* 4 byte hole */
+	netdev_priv_flags_t	priv_flags;
 	const struct net_device_ops *netdev_ops;
 	int			ifindex;
 	unsigned short		gflags;
diff --git a/net/8021q/vlanproc.c b/net/8021q/vlanproc.c
index ec87dea23719..08bf6c839e25 100644
--- a/net/8021q/vlanproc.c
+++ b/net/8021q/vlanproc.c
@@ -252,7 +252,7 @@ static int vlandev_seq_show(struct seq_file *seq, void *offset)
 
 	stats = dev_get_stats(vlandev, &temp);
 	seq_printf(seq,
-		   "%s  VID: %d	 REORDER_HDR: %i  dev->priv_flags: %hx\n",
+		   "%s  VID: %d	 REORDER_HDR: %i  dev->priv_flags: %llx\n",
 		   vlandev->name, vlan->vlan_id,
 		   (int)(vlan->flags & 1), vlandev->priv_flags);
 
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
