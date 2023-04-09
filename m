Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D73C77B61
	for <virtualization@archiver.kernel.org>; Sun,  9 Apr 2023 07:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7AE8E40169;
	Sun,  9 Apr 2023 07:07:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7AE8E40169
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=SBu/YGbw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l9MSacKYN8jy; Sun,  9 Apr 2023 07:07:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A8D6F400CB;
	Sun,  9 Apr 2023 07:07:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A8D6F400CB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C7E7C0036;
	Sun,  9 Apr 2023 07:07:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04D12C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Apr 2023 07:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B9B3E842B4
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Apr 2023 07:07:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B9B3E842B4
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=SBu/YGbw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v2P7urYMgAfy
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Apr 2023 07:07:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 793BE841FD
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::61a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 793BE841FD
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Apr 2023 07:07:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7qGJYEgQPqy1idCdo1am3tzxXOqQNJQaspZd9gacmdJSsuWKVLzfy8m2BG2GESjodwpmiM5XAcOTHblYerFhbBpEMkH4/31zp5Q2qgxG89n64C/1TrA25NYnxY9SR81V1B1JA0QHFu9NncuxIEEs/JRkEEAv7EU9SQmMUS5bnym/OBqHfxkJ6xWJw93a2iU54L/EYLoEsJyfkA74+36D9Ix3jNcCt5mFiyG1PDcymvX+BtOnzpJtBWJ5bxmign5CzzNv5KN19HtfpOAwBKKSMQj1EKgljv5NZYJf8+NKKVA43fVNH/zycRA42/a7IUHPYq5O/aEF6h1Dl+TYqfwvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HipI68aSTjCKaeykw30LxYUmuP9OyVgjSWQwvTub3q8=;
 b=gOii4fW0pzDsKeOwuvjSePaL8S060e1lvOEcb7jhXqasOh1V0uB54EF0B0Anl9bBfKIEgP72f9GaZDWt90BqGll+dApXXUDFzxuMQZ7fovjG+b6JoO7Q9h4xnMZxwn+vqTrlgClKeZw/2fwNBsWP1RVs4BoP5vuQ3RRrIP4Nm02AwiigT68XNlz7HGCwEhvfWvPgFcVHcP17jJLWIz9fpUamnNXP3W6d6/NfbSZY/thLmQiSzapJyJy6dtKXjTb5E3+5XmmNdhNdUBYPBqdhdl0+OZW1t8mBSZfjCp0LvADAfY1rumXHo99JgEjvBcIHZvaSJfMdf4A3pXLKChZOZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HipI68aSTjCKaeykw30LxYUmuP9OyVgjSWQwvTub3q8=;
 b=SBu/YGbwDmS1ZsFAeAAJGKwMk9ekrPJ7iMTjr0KgK+3CugWdPwG0FxgfLHRVEk1tKV99xeDqOAQiPrcUp6Tdbb1Z5Q0gznyawM7sxxp1be/u/tr7bS4Jx7BSprR3DfTYOUSk+B3F7e6mQMwL2JEFQ22xLp9yYpMVfXwyKqPUuWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by PAXPR04MB8157.eurprd04.prod.outlook.com (2603:10a6:102:1cf::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Sun, 9 Apr
 2023 07:07:15 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977%5]) with mapi id 15.20.6277.038; Sun, 9 Apr 2023
 07:07:15 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v2] virtio-vdpa: add VIRTIO_F_NOTIFICATION_DATA feature support
Date: Sun,  9 Apr 2023 10:07:06 +0300
Message-Id: <20230409070706.3288876-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
X-ClientProxiedBy: ZR0P278CA0082.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::15) To AM0PR04MB4723.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4723:EE_|PAXPR04MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: ded51914-e620-422b-83cc-08db38c90c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7F0EDUaVLzCX16pYh/QPHWo8PSLM9u6jsUWxSMcASiNxiBjNiI0QMxOvFnC6+HCcXBvkHA+u/Ae3gQbIjwqrqNg7ucOTEw2mogr77egfux+oTKRChOFDO6dLeTdcnYiCUlgmu2ADJbhVhhTw98FgFYCzCPsALOskQD+sr6vGBXd3fAHyq5FF/glP/VmYzzdQni9CVntbPZUyN3Q0N6W+P+wFPqf/UK7KILqvBG5Ra2Chc1XtqW6PDLN+QykGHAtcGl7jkwUM3HFGQ2Arwg1wtpLVLfJcbRwcijyQV6Zeq4y5D53oQA42dU+HyL3aZIwYhZTej9xrJpO6+CqABc9kndDFbNuLLUlQIjusuR4Wdank2NQMBlr/8zU1xe4u8UzhD96QuLRqw28TZZ2RVjG9X7IIfC9z86uGfirXpm8X36FIB7uvKKNlPppG2whnC+WGkOYOcGuKBB9H30IB+dOmDyLcxzPSrNDVhCqb3zYh1f4GIpRfzGI7UH840fs5fJgfzg2iTUOFDfDV6cvOxV1nx0OeGK/WYy6LNE9//Q540Z3x6Ee/UPazLlZKRuphAPPGG++RAvS5xUFZHdrYsUvaDN4y+UTK9TeLVUiKAW16gfA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(39830400003)(366004)(136003)(396003)(376002)(451199021)(478600001)(52116002)(316002)(6512007)(1076003)(26005)(6506007)(186003)(44832011)(107886003)(6666004)(966005)(6486002)(2906002)(4326008)(66946007)(5660300002)(8676002)(41300700001)(8936002)(66476007)(66556008)(38350700002)(38100700002)(86362001)(36756003)(83380400001)(2616005)(66899021);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d8tQAEYsxtEjV/9Tu2PQiYVrrZ9YXsAFQqw3oCxAkb5MAOVhjS6AbDvrHMUA?=
 =?us-ascii?Q?YH8OrJqvZJEaIp+efmf4P6r2ZsatqLXgBO0VzEeXttHx1MDFJ50c/+59QhSs?=
 =?us-ascii?Q?QY/jMgHHScEst/lRaIZh115VH4QYaDfHq4WsIv+tCj19S7tYLogSlB51OjTS?=
 =?us-ascii?Q?CGDOq8ji7SuKqv8yLOtgelDnjhQMuhViWsy/oRTWQMpA2jIgfIl04UNg5aIJ?=
 =?us-ascii?Q?3gyJE/ne6qOGtOybYSLbN2N1Tmeco+Ov5r22PjdUJl1h172RFTvl5zIxfk11?=
 =?us-ascii?Q?ZO4Q1+J+mum6VgKmrf/qTczAjKhQrZ7R8f1t8ymul7C7zmiduOAom6MNnvCj?=
 =?us-ascii?Q?OVm3FydnYlNqeS8KbfiZbgM+ANwHM8gPc9GqrnwcUyh9LDmdFLhJ6F+0VbHX?=
 =?us-ascii?Q?4zNgbbAU6I8CwbYd2nc+SNBE+9b6mgs6Cs3MB9vlG15Jmo81D4Hl7/xGTpZZ?=
 =?us-ascii?Q?xIShB5903yqFy625I1gL/q4qjwHNe/lCj9rqP3Z9i6y4LEsTExFp8jMQjH37?=
 =?us-ascii?Q?d20ObER7u+ASHqkHVt6BI0G7nfslLIJ1AsQx/wkjiXDWCfGVimOK4hkv78aI?=
 =?us-ascii?Q?nNTG9HSO7/WXAAm4K3P1lrYzOy87MbCdAGgQOmAmx9vDddgFIACwvE2YULL8?=
 =?us-ascii?Q?//MWXugTd2g3RJ/2QcBAgKWr36tFY4jryaSQ1ME1OYubvMsIOmIwrwUP3Xzd?=
 =?us-ascii?Q?ak8i736XAwNmVP49s3LLdPq55P4AErbu5GZTTXJIG4pKDo7uAReNSzyWC/Qq?=
 =?us-ascii?Q?jQI7tTTpjgptj6fiThAMNmtlkmXZ0oIlA271qu8pqa200zFBTISulDnfq4B5?=
 =?us-ascii?Q?NFtWUYrmDCikkUWnxs394ALP5KkWUFSOkpHCk7lsS24rZt2yLtGfGE1Rf+FZ?=
 =?us-ascii?Q?naRQAt2Sl9G3A7U9QtTICUndUKPDOXm7JtVs0Yqzv3Z/PB+Ny1YJYO+6uJr4?=
 =?us-ascii?Q?3DjPhoEUhSH+brtFdc+zsnWNYTm3LC2YT2z6FO2DjNojbxpq52YXcgNH44tK?=
 =?us-ascii?Q?gp4lKGpcE+Kgo/wL8kiCIzB0q8F0dDAAOfMvt4wL75PshyqiU1y0B7xiKEqk?=
 =?us-ascii?Q?tjO/ITcarhDDyJMp3whbM5Q1VhOAfVfxAdhYauQTesX8Jg/yEYZKr0Ja/U9p?=
 =?us-ascii?Q?CA07rtrMd/3Sq9H1bs+QCZ8CJLAyrllDexuA9UqUbuATdm10ag0UBj+TyyLI?=
 =?us-ascii?Q?OzZVnaGUcKcL0+vTUW/TDfftYd8BrPrmNAJcL45cVXiQb7pw+Bx827GcANQ/?=
 =?us-ascii?Q?+jhidaDHnKLq7bQl+9XBaOj/80TOIbfUSyMdv8ND2cWChsSNJe8YEjpVXUa0?=
 =?us-ascii?Q?gua+WESRQq7Sx3XaaYiu7XWE2y3w8QloXahiL66wZQ7O81e3R0vgnGRf1Xo9?=
 =?us-ascii?Q?atYv0WLxWFPSwegjwkRKoml4YupsVBZzcF0oVexBSENLsCvdlN4OQqJePddv?=
 =?us-ascii?Q?a6rDMBBgA0bkexhu0emgmmaJFoHFrINASo8BTiZSup7vIoz4FzkcoA6RIBmz?=
 =?us-ascii?Q?To3YCWCekyj7X3MaaamkP/fsYNtKofPBzLVj4WLDj4f8jEtOZHC8QJVqXKeP?=
 =?us-ascii?Q?W+Aiu+3QcqqBeVXOt+bHpvkGhVnj7lpjLuM5oGtYZTT4TK0hgrYt5F1l5hq0?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded51914-e620-422b-83cc-08db38c90c24
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2023 07:07:14.8320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43m3pJZpLKT4LR0yqtejyF6WgmKR4lW/gvFNPfY451I+v/ayIxFapDW5iMIAA2aq6j1n60jl6bJF/cVEK2LjwYgCDC/d9OzK9aGYMFvFIoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8157
Cc: virtualization@lists.linux-foundation.org
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

Add VIRTIO_F_NOTIFICATION_DATA support for vDPA transport.
If this feature is negotiated, the driver passes extra data when kicking
a virtqueue.

A device that offers this feature needs to implement the
kick_vq_with_data callback.

kick_vq_with_data receives the vDPA device and data.
data includes:
16 bits vqn and 16 bits next available index for split virtqueues.
16 bits vqs, 15 least significant bits of next available index
and 1 bit next_wrap for packed virtqueues.

This patch follows a patch [1] by Viktor Prutyanov which adds support
for the MMIO, channel I/O and modern PCI transports.

This patch needs to be applied on top of Viktor's patch.

[1] https://lore.kernel.org/lkml/20230324195029.2410503-1-viktor@daynix.com/

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
v2:
	- clear the feature bit if kick_vq_with_data is not implemented.
	- Fix kick_vq_with_data comment in include/linux/vdpa.h
	- Write in more detail about the extra data in the commit log

 drivers/virtio/virtio_vdpa.c | 23 +++++++++++++++++++++--
 include/linux/vdpa.h         |  9 +++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index d7f5af62dda..737c1f36d32 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -112,6 +112,17 @@ static bool virtio_vdpa_notify(struct virtqueue *vq)
 	return true;
 }
 
+static bool virtio_vdpa_notify_with_data(struct virtqueue *vq)
+{
+	struct vdpa_device *vdpa = vd_get_vdpa(vq->vdev);
+	const struct vdpa_config_ops *ops = vdpa->config;
+	u32 data = vring_notification_data(vq);
+
+	ops->kick_vq_with_data(vdpa, data);
+
+	return true;
+}
+
 static irqreturn_t virtio_vdpa_config_cb(void *private)
 {
 	struct virtio_vdpa_device *vd_dev = private;
@@ -138,6 +149,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	struct device *dma_dev;
 	const struct vdpa_config_ops *ops = vdpa->config;
 	struct virtio_vdpa_vq_info *info;
+	bool (*notify)(struct virtqueue *vq) = virtio_vdpa_notify;
 	struct vdpa_callback cb;
 	struct virtqueue *vq;
 	u64 desc_addr, driver_addr, device_addr;
@@ -154,6 +166,14 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	if (index >= vdpa->nvqs)
 		return ERR_PTR(-ENOENT);
 
+	/* We cannot accept VIRTIO_F_NOTIFICATION_DATA without kick_vq_with_data */
+	if (__virtio_test_bit(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
+		if (ops->kick_vq_with_data)
+			notify = virtio_vdpa_notify_with_data;
+		else
+			__virtio_clear_bit(vdev, VIRTIO_F_NOTIFICATION_DATA);
+	}
+
 	/* Queue shouldn't already be set up. */
 	if (ops->get_vq_ready(vdpa, index))
 		return ERR_PTR(-ENOENT);
@@ -183,8 +203,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 		dma_dev = vdpa_get_dma_dev(vdpa);
 	vq = vring_create_virtqueue_dma(index, max_num, align, vdev,
 					true, may_reduce_num, ctx,
-					virtio_vdpa_notify, callback,
-					name, dma_dev);
+					notify, callback, name, dma_dev);
 	if (!vq) {
 		err = -ENOMEM;
 		goto error_new_virtqueue;
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 43f59ef10cc..04cdaad77dd 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -143,6 +143,14 @@ struct vdpa_map_file {
  * @kick_vq:			Kick the virtqueue
  *				@vdev: vdpa device
  *				@idx: virtqueue index
+ * @kick_vq_with_data:		Kick the virtqueue and supply extra data
+ *				(only if VIRTIO_F_NOTIFICATION_DATA is negotiated)
+ *				@vdev: vdpa device
+ *				@data for split virtqueue:
+ *				16 bits vqn and 16 bits next available index.
+ *				@data for packed virtqueue:
+ *				16 bits vqn, 15 least significant bits of
+ *				next available index and 1 bit next_wrap.
  * @set_vq_cb:			Set the interrupt callback function for
  *				a virtqueue
  *				@vdev: vdpa device
@@ -300,6 +308,7 @@ struct vdpa_config_ops {
 			      u64 device_area);
 	void (*set_vq_num)(struct vdpa_device *vdev, u16 idx, u32 num);
 	void (*kick_vq)(struct vdpa_device *vdev, u16 idx);
+	void (*kick_vq_with_data)(struct vdpa_device *vdev, u32 data);
 	void (*set_vq_cb)(struct vdpa_device *vdev, u16 idx,
 			  struct vdpa_callback *cb);
 	void (*set_vq_ready)(struct vdpa_device *vdev, u16 idx, bool ready);
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
