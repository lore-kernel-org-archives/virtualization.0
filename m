Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D6DEE4996
	for <virtualization@archiver.kernel.org>; Mon, 21 Aug 2023 14:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8102E6102D;
	Mon, 21 Aug 2023 14:27:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8102E6102D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QzWOEs0x
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mPg_rjVUYdbS; Mon, 21 Aug 2023 14:27:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D1D1660E8A;
	Mon, 21 Aug 2023 14:27:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1D1660E8A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C449C0071;
	Mon, 21 Aug 2023 14:27:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5637AC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Aug 2023 14:27:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2A6B34044C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Aug 2023 14:27:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2A6B34044C
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=QzWOEs0x
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R7kobT5u3c_e
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Aug 2023 14:27:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::616])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C36140395
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Aug 2023 14:27:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C36140395
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVepZWNXMItoKjvFEYQLmKR9S7DdNQV45ZDTW+p0ZRI4KmYsBzurLP4/xx7e/WRMZvDsL5G+tNBs726w2nz5+XJNV6AVligu37zBexf+b/qb6BlzOMCw14ININjDKOx5CqefPaJWQY+CkqDEvI67rnEt0k2JUG9UqmUBpoPr+3wehyalp5F3AAvTpWchwyo9FI8pqeY8mdW75NwmcroL7tT4kIWJuZU3mgR3kYm/qeDqFyAW3jj5ve+8tV9iPWYfYGP9hU6WTCMyqjLpgiSCTd8vhBqwpQRrYtXDS4sfNb3OS2KN1Cytvfsc19iXFPlYQgshT21v7uxS9gKToCrglQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TmHZWpKDbM3g6DM4pIChvrvZgw5lqutj+pnXOHawh8=;
 b=ArWPcKkeWMSBrC5OuDHksvBxt8YEJwlUR3CVb3vgH8jMdth84bmeqdxbIOpYJSWekWNrPkZwRu4ldoCmaehUkL1KQfGGXA1YhEC7DGKq9mdWz0cFFSeh0VkaozE8V2NsvLugrlYO4gRKHeBWQWXr55nAnLUem6Hxet0IR2vaC/P3Ba2pjZeUpk7mVMgOs+OxqMsnQfdR25H0C0X25kbO+Vn6kvXrTmu6fhIP+22lwmuzQG7weI4DvDptv1kYgUVeLqJGc24pnhqEury9mZL95Oe3YIwlwsBfHto+N7yhwq82J1oCv0oojXXPrsEtEiMPCHn7Avmp6MGGc3PvECLD5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TmHZWpKDbM3g6DM4pIChvrvZgw5lqutj+pnXOHawh8=;
 b=QzWOEs0x5lWnxygaxRmo3Dd6nGhTYe8MHC1skPHDD0ZKX3O5Prp7i4eAsB+BT4PBsP9M5q0OBHYnpYxgb2ruS3IMpepUA/rJBqirSPtBC2Hh2ZkzPagUjUeWeRTfsy0wp3sMKCEDjR1rcAcHI9KZyp1Q66ZgJ01WIbeicTExbbH+yAN6/Qdc61PxjuSjjGL8p7VjoEFVx1jM1GxktNrzATFIDG+q2U7aKmyXO2NF5WLRGpgKH5W2MXaqCR3VlOGzl2nQEztp/vbD4iOsliHJso3rIriWBy7ABHUtX8CPTDyEwU5qA0TthTXwBy7uUyWO/C4m0RsGFYWt9rumVTNlxA==
Received: from MW4PR02CA0022.namprd02.prod.outlook.com (2603:10b6:303:16d::15)
 by SA1PR12MB7441.namprd12.prod.outlook.com (2603:10b6:806:2b9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 14:27:39 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:16d:cafe::84) by MW4PR02CA0022.outlook.office365.com
 (2603:10b6:303:16d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 14:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 14:27:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 21 Aug 2023
 07:27:22 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 21 Aug 2023 07:27:21 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport;
 Mon, 21 Aug 2023 07:27:19 -0700
To: <virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3] virtio_net: Introduce skb_vnet_common_hdr to
 avoid typecasting
Date: Mon, 21 Aug 2023 10:27:13 -0400
Message-ID: <20230821142713.5062-1-feliu@nvidia.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|SA1PR12MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: a87c3a00-093e-4bb6-266f-08dba252c4fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ptiyvSKCXyyodgxUjcOEFgagSYOotDlHxbZZQ8aTVBzjm2cHvDSiyPX4j+Rqnpj3Ccj5BOOWVWz9oBIJUxFGPBajFgJvKrn4GfQFs7ql2GteOBTrN+4Opg2tZWvHf4sc9hJkOeS7JIh55gBBlWzc6/9Ho7P1eMuB5NWCrD1Jnl/lttb7O9Ixi1j4lPIdSehfIZ3QwXXPzXN329P30G93dFh+zELrok8AklfYLWuNgquoZSRv7JnIaFue21nGavGy1kiYl3qMNiT1WhoQ4MrxYCrxTUQRDX2kIG+q3WWmvdoXUPUosdrRKbPixSXoHlhV72KIreasp/Q3BKweUXkjVlRkedY6FUOlrJVmJJhqDT3Lqx0TepIH/vE+BuhB9rzzZXJUCO8PXG7anmZqwOzjJ1IXYEp4uvysbKsLQKFKTmCexAoO7oWwyJTd/dxK5N7YvDRGm09ao9uzRHh/yM9hubXKcP4Sd0U5lN1C+h5ujRZ/nKTQG+WcknMV5c7Eoe9/zX7CPwOMjUJgHkyMjdC+/xAqwxutKtMbUANi1qLMlg/gDy0FTmdL6s01FslEeco0jKIau0rkYzGbjRi1FZfC+NLxbzMasFCDJEK7gvyqrTDzeeiC8IJwH4J6POc8JRwHayyg5CSLVeNnrJLHbAZKGP1zn5Lu9QP6Y/f9ZBSdF4496AA+kUIZqQqKXbtCO1tBSPfiDAMApovm0IuMseZm2J1I8+PjL3IM+v2lOSPtO0WwIrIrUX2MoLm4IdZV4Dwx
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(186009)(82310400011)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(54906003)(70586007)(316002)(66899024)(110136005)(8676002)(2616005)(8936002)(4326008)(107886003)(70206006)(1076003)(36756003)(40460700003)(41300700001)(356005)(82740400003)(478600001)(6666004)(7696005)(40480700001)(7636003)(2906002)(7416002)(83380400001)(86362001)(47076005)(36860700001)(426003)(336012)(5660300002)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 14:27:37.7971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a87c3a00-093e-4bb6-266f-08dba252c4fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7441
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@nvidia.com>, Bodong
 Wang <bodong@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>
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
From: Feng Liu via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: Feng Liu <feliu@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The virtio_net driver currently deals with different versions and types
of virtio net headers, such as virtio_net_hdr_mrg_rxbuf,
virtio_net_hdr_v1_hash, etc. Due to these variations, the code relies
on multiple type casts to convert memory between different structures,
potentially leading to bugs when there are changes in these structures.

Introduces the "struct skb_vnet_common_hdr" as a unifying header
structure using a union. With this approach, various virtio net header
structures can be converted by accessing different members of this
structure, thus eliminating the need for type casting and reducing the
risk of potential bugs.

For example following code:
static struct sk_buff *page_to_skb(struct virtnet_info *vi,
		struct receive_queue *rq,
		struct page *page, unsigned int offset,
		unsigned int len, unsigned int truesize,
		unsigned int headroom)
{
[...]
	struct virtio_net_hdr_mrg_rxbuf *hdr;
[...]
	hdr_len = vi->hdr_len;
[...]
ok:
	hdr = skb_vnet_hdr(skb);
	memcpy(hdr, hdr_p, hdr_len);
[...]
}

When VIRTIO_NET_F_HASH_REPORT feature is enabled, hdr_len = 20
But the sizeof(*hdr) is 12,
memcpy(hdr, hdr_p, hdr_len); will copy 20 bytes to the hdr,
which make a potential risk of bug. And this risk can be avoided by
introducing struct skb_vnet_common_hdr.

Change log
v1->v2
feedback from Willem de Bruijn <willemdebruijn.kernel@gmail.com>
feedback from Simon Horman <horms@kernel.org>
1. change to use net-next tree.
2. move skb_vnet_common_hdr inside kernel file instead of the UAPI header.

v2->v3
feedback from Willem de Bruijn <willemdebruijn.kernel@gmail.com>
1. fix typo in commit message.
2. add original struct virtio_net_hdr into union
3. remove virtio_net_hdr_mrg_rxbuf variable in receive_buf;

Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8e9f4cfe941f..8c74bc8cfe68 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -303,6 +303,14 @@ struct padded_vnet_hdr {
 	char padding[12];
 };
 
+struct virtio_net_common_hdr {
+	union {
+		struct virtio_net_hdr hdr;
+		struct virtio_net_hdr_mrg_rxbuf	mrg_hdr;
+		struct virtio_net_hdr_v1_hash hash_v1_hdr;
+	};
+};
+
 static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
 
@@ -344,9 +352,10 @@ static int rxq2vq(int rxq)
 	return rxq * 2;
 }
 
-static inline struct virtio_net_hdr_mrg_rxbuf *skb_vnet_hdr(struct sk_buff *skb)
+static inline struct virtio_net_common_hdr *
+skb_vnet_common_hdr(struct sk_buff *skb)
 {
-	return (struct virtio_net_hdr_mrg_rxbuf *)skb->cb;
+	return (struct virtio_net_common_hdr *)skb->cb;
 }
 
 /*
@@ -469,7 +478,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 				   unsigned int headroom)
 {
 	struct sk_buff *skb;
-	struct virtio_net_hdr_mrg_rxbuf *hdr;
+	struct virtio_net_common_hdr *hdr;
 	unsigned int copy, hdr_len, hdr_padded_len;
 	struct page *page_to_free = NULL;
 	int tailroom, shinfo_size;
@@ -554,7 +563,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		give_pages(rq, page);
 
 ok:
-	hdr = skb_vnet_hdr(skb);
+	hdr = skb_vnet_common_hdr(skb);
 	memcpy(hdr, hdr_p, hdr_len);
 	if (page_to_free)
 		put_page(page_to_free);
@@ -966,7 +975,7 @@ static struct sk_buff *receive_small_build_skb(struct virtnet_info *vi,
 		return NULL;
 
 	buf += header_offset;
-	memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);
+	memcpy(skb_vnet_common_hdr(skb), buf, vi->hdr_len);
 
 	return skb;
 }
@@ -1577,7 +1586,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 {
 	struct net_device *dev = vi->dev;
 	struct sk_buff *skb;
-	struct virtio_net_hdr_mrg_rxbuf *hdr;
+	struct virtio_net_common_hdr *hdr;
 
 	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
 		pr_debug("%s: short packet %i\n", dev->name, len);
@@ -1597,9 +1606,9 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 	if (unlikely(!skb))
 		return;
 
-	hdr = skb_vnet_hdr(skb);
+	hdr = skb_vnet_common_hdr(skb);
 	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
-		virtio_skb_set_hash((const struct virtio_net_hdr_v1_hash *)hdr, skb);
+		virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
 
 	if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -2105,7 +2114,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 	if (can_push)
 		hdr = (struct virtio_net_hdr_mrg_rxbuf *)(skb->data - hdr_len);
 	else
-		hdr = skb_vnet_hdr(skb);
+		hdr = &skb_vnet_common_hdr(skb)->mrg_hdr;
 
 	if (virtio_net_hdr_from_skb(skb, &hdr->hdr,
 				    virtio_is_little_endian(vi->vdev), false,
-- 
2.37.1 (Apple Git-137.1)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
