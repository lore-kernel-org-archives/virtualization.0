Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43236C48BE0
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 08:22:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F084D6143C
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 08:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F084D6143C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BFBC7403C6;
	Thu, 10 Jun 2021 08:22:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RSXY4Qs2dSLs; Thu, 10 Jun 2021 08:22:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E4D21401D1;
	Thu, 10 Jun 2021 08:22:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BECE4C000D;
	Thu, 10 Jun 2021 08:22:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A470C0022
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6F68E6058B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mBNS9pbFdSki
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 09D97606A7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:13 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04420; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=21; SR=0; TI=SMTPD_---0Ubx5.HQ_1623313330; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Ubx5.HQ_1623313330) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 10 Jun 2021 16:22:10 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v5 02/15] netdevice: add priv_flags
 IFF_NOT_USE_DMA_ADDR
Date: Thu, 10 Jun 2021 16:21:56 +0800
Message-Id: <20210610082209.91487-3-xuanzhuo@linux.alibaba.com>
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

Some driver devices, such as virtio-net, do not directly use dma addr.
For upper-level frameworks such as xdp socket, that need to be aware of
this. So add a new priv_flag IFF_NOT_USE_DMA_ADDR.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/linux/netdevice.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3202e055b305..2de0a0c455e5 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1596,6 +1596,7 @@ typedef u64 netdev_priv_flags_t;
  * @IFF_LIVE_RENAME_OK: rename is allowed while device is up and running
  * @IFF_TX_SKB_NO_LINEAR: device/driver is capable of xmitting frames with
  *	skb_headlen(skb) == 0 (data starts from frag0)
+ * @IFF_NOT_USE_DMA_ADDR: driver not use dma addr directly. such as virtio-net
  */
 enum {
 	IFF_802_1Q_VLAN_BIT,
@@ -1630,6 +1631,7 @@ enum {
 	IFF_L3MDEV_RX_HANDLER_BIT,
 	IFF_LIVE_RENAME_OK_BIT,
 	IFF_TX_SKB_NO_LINEAR_BIT,
+	IFF_NOT_USE_DMA_ADDR_BIT,
 };
 
 #define __IFF_BIT(bit)		((netdev_priv_flags_t)1 << (bit))
@@ -1667,6 +1669,7 @@ enum {
 #define IFF_L3MDEV_RX_HANDLER		__IFF(L3MDEV_RX_HANDLER)
 #define IFF_LIVE_RENAME_OK		__IFF(LIVE_RENAME_OK)
 #define IFF_TX_SKB_NO_LINEAR		__IFF(TX_SKB_NO_LINEAR)
+#define IFF_NOT_USE_DMA_ADDR		__IFF(NOT_USE_DMA_ADDR)
 
 /* Specifies the type of the struct net_device::ml_priv pointer */
 enum netdev_ml_priv_type {
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
