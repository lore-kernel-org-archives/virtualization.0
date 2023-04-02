Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3A0C7619A
	for <virtualization@archiver.kernel.org>; Sun,  2 Apr 2023 08:10:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD3D060B49;
	Sun,  2 Apr 2023 08:10:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD3D060B49
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=j2Jc5v5i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AYMDFbSWQjwo; Sun,  2 Apr 2023 08:10:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9125E60B1F;
	Sun,  2 Apr 2023 08:10:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9125E60B1F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5837DC0036;
	Sun,  2 Apr 2023 08:10:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2D20C002F
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Apr 2023 08:10:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7631060B1F
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Apr 2023 08:10:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7631060B1F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 397OxT5dOcCJ
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Apr 2023 08:10:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E4051607F1
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::61f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E4051607F1
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Apr 2023 08:10:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zpk3m3iP54RxzCvC2Hh1fnwp6re86k9bHzMEESiyjnai6+QnecopAbskWd4nPXURxh1DukS6Ezpgd7ejxVEYzqpWRzhgzWoB+THBGpmBvwivv8bAvbbts3cn36YP4CZfviuOZUTk822/QH0FSWHUTAHNR6SBPQY+3dGSANdYQaGNYPwfkcEMRq+4RA3g0jLmPbNCyI0puC/NtRtXzP6/EqUexD0TmdQTfkZNrS4QxIyIT9pfZRnRNvSSGr/yCqb1HX9Y+f0KiWKbvPk5ievUYwIIGtTYLoCsU0TWYOH/580fT7iA+zXSGYrssr+GmI4gz5vqrbWhsyQ4Vo+M2lVcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiHrxaM7uAhyf7IA2c6fbbn5X6QqpVJ05K62H+hXnp4=;
 b=lOJe5ExeuVfdAt/3PDAi6y+pNi+X4KyPkTcMGjOEAEsZ8QFXH1vq/QSZ0tDHQXz1LDR6cRtr9OUtFL0B73cbAHKEI5Geq59Z9TSq4+NIYb2ahp+ov1mpuZvHvx6JpcThkmz2Vjs4rg9oqZy7cFEREtwxy1WpS9TJrb3wveYH9TVPIPXjAa3eD7c9/pXOO6mNooHZvd8QBT/SbJzC0xAUT8SZ3QrZu8zTiUsqQCVM+FzQAIBkksqwMsiwyGXGOqI3S6qu8VIqMzq/MBDO01h/pI6z/SMcqx677Q34mWHV4qCzrewRaCL3fBc1mLQa1SYlFeVbrDli997Oh5sNzIVm8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiHrxaM7uAhyf7IA2c6fbbn5X6QqpVJ05K62H+hXnp4=;
 b=j2Jc5v5iVD4DIaYEN/ViaXXKO3AhIlOpAOaApnq1O25V2jKepHmoFpdsgFUDwrln/3TjyXomhA5kai46yqy+ac2okLY9JeSsjicMoJDoM2JQCT6wnG6jUbR4WW/iqYY6IfNxJsmXkx47F/qaRjTMqcpWUtnsK7S6iTIDO3rQF5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by GVXPR04MB9901.eurprd04.prod.outlook.com (2603:10a6:150:113::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Sun, 2 Apr
 2023 08:10:44 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::b28a:f4f1:8415:221d]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::b28a:f4f1:8415:221d%4]) with mapi id 15.20.6254.028; Sun, 2 Apr 2023
 08:10:44 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH] virtio-vdpa: add VIRTIO_F_NOTIFICATION_DATA feature support
Date: Sun,  2 Apr 2023 11:10:34 +0300
Message-Id: <20230402081034.1021886-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
X-ClientProxiedBy: ZR2P278CA0049.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::15) To AM0PR04MB4723.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4723:EE_|GVXPR04MB9901:EE_
X-MS-Office365-Filtering-Correlation-Id: 68497b8a-3660-40dc-9e64-08db3351c1cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wCH2JSdfc7qTZNyq1E901dWvMOezv9tUl4wkBU2R/+g/hwLSb8Vfom721Z53//aW58AEALJblftKOeG4VWfVncZgB+mgaPdalIKT4W1e+8rdfe+4DVgtKYuR09QMuQyE05ZOv3QoRuYQJHS/tEICwwIiblKB+PeUmbKMYJUhOTAzYvr7bL8hdYlja9tzcPpo3HDvshOHIy7VC2AMMAqrTI8PjMYjWSQJ+DIhaT9lUIjm+0Vcbk/VPQwUu6bBpGPVk/tWpvACsl273DEX3WBu6USqPeGUz40ZOM1fKXFsPngzDlFhkfHdDZpx4vA9JG7+PEHshnWO+qm1xwT1+1AVp6QwGJKAoiQZD9xa66mmPXWK6brWE1fXoDKX59wKMhhEsaFO1rPbBy24/3dRf+GfO/kAxfVCo6BoxEFM3VbCPMRBT8xHr3WYqnENma0wzxTFpTQgw6imCgC4j+KW7siZaTvAEXdykSWKhGF2JeCyEhiRq/eB1SR5V3mht96UEY/E3y80Vauj/AmTyqAMpMJxAjSdCZUb3aRlmd7ar8MzshFFd2cVz0eKcRUc32PbFQ1HHxnkv+iNbNMkgIrzjEghRGc6by8RBLWnB5ixAhGq2r4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39830400003)(366004)(346002)(396003)(136003)(376002)(451199021)(86362001)(38100700002)(38350700002)(66899021)(316002)(478600001)(44832011)(6666004)(66556008)(66946007)(66476007)(4326008)(41300700001)(6486002)(52116002)(2906002)(36756003)(107886003)(186003)(966005)(26005)(6512007)(1076003)(6506007)(8936002)(8676002)(2616005)(5660300002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yDO77Lms0JTalmZWBVavXCN6novR7BSgKt6+0cielQ8ufjs0RtPzH83Oqjzz?=
 =?us-ascii?Q?TnBeisKWyWpaqskOXWoDzMI1UHgYheNXtgT0u02RfraIDPxOx09Cw34ZOFX+?=
 =?us-ascii?Q?dv/GdaES7idtooGTPeryBPpZnS1yy/ZthYEy2ycE8uysQ2C9YAQcPMoHY+c9?=
 =?us-ascii?Q?d2+TECOkrtuGuJSZeIQXQ8HWtK5bKdnpgvXLZ6FT1SK5DhrxOt65a5qkm4QW?=
 =?us-ascii?Q?oNrxmeLdAD3D9NnzwPUNzJfwXwPi/DvT+J4hllcUAuSEe1o4dNhxDpz+UTpT?=
 =?us-ascii?Q?oCBgJzCWm0Gh2lYVqJIc0yhWaP2cqnGEFpqsmqBJTAj8Y3iB1iNiGityt62+?=
 =?us-ascii?Q?GnfTZV4A301y7HUwmS6fT6u40m1cRhjHxzhG1rSt1Miob6OzqA900ZWz2rko?=
 =?us-ascii?Q?kDQ+EtmWYABcyF1ioykVn2jOVFw+77R5yGfvxD3geNycTHqgRBkxogB9QoNe?=
 =?us-ascii?Q?3K6HLwjsklcnRV4kVkdQ5fHJ2jvNsB5psULQ0y4R+j/mCPrbWGpZTFeQA0zN?=
 =?us-ascii?Q?k05s8XuO3mnw7/LZKqG/WEubqQLYcf/EG7ezgNJpq5zrp5xCbuLAfyq7hOeu?=
 =?us-ascii?Q?D6wkkRbbxunir2Gjy1GQWBRyQPWfRYXbG+ZnUr93zKMwrUjxOxxmE98Ib2WR?=
 =?us-ascii?Q?cU/b+Xf56O6NtOmwDZ1Kb4wcUtRESOGEb0dzjV/sRKheeKidAu3X9ilqbrK4?=
 =?us-ascii?Q?LO+njDw1QosWrpoyBB3T1Z5iteCIf78qvIl8XgX8cv4fTV+lTScIt/tKmnl6?=
 =?us-ascii?Q?y1FKXOmDM/olK3JOFRfJTlvW3OVZteSywSQDLaSwcbnm5QUsSdmNd1xlxGBF?=
 =?us-ascii?Q?UMpdr4EVZw+kqaYJfCLLnYr94GV9pn4AjlwWZBulTUhW89Vi619b3CIO8/SV?=
 =?us-ascii?Q?rxSFL3BtPB+Se3uurscvxkJuowWHitgN7lAH8soCaxxrcxPsfWC7THzIbLJv?=
 =?us-ascii?Q?RnywszkGGA2HYk7tuqNKik7PiS1ze2QAVV+N7Z9V1oh9twKKEiyhSw4W5NQi?=
 =?us-ascii?Q?rrH2cv5ovaDBYjp5kBIXmG6MqVcKuMyvKgX7v0K5+mlUtuEh04PGA8YljB3s?=
 =?us-ascii?Q?gOOclNuTtYvJs+dnpYEWhD4uRWgQFA1h86Oa/Vpbef/5OACWKhfc1xDwlwt8?=
 =?us-ascii?Q?UJ7QmxIHVQv7QgBxiXSQ6Kqrhq5FYrgVPvkFHxS/HEdHb0i3XL+5kUoweOlQ?=
 =?us-ascii?Q?OljMHlWdtlP24mzGHusRV3t/sBOC+qLNsb5HnZq6e7cmJO73B8SERyYLxVEc?=
 =?us-ascii?Q?hLs1e2Ju2QAn/vvQ2LU8kx6r9Qd1fhBtGf3gXZWxgfvKhSOjjLz2Kmabxct3?=
 =?us-ascii?Q?9ShvxLHT99t6sgJdyaVbrCWn2c/9qOBjOssE7O/7+9aqxNLGd+9fCLAHaZra?=
 =?us-ascii?Q?d3VLEZ61Ow/BdIE/O0BvRVPrXaPzJz3QPffSoXoneqmGvb4CycxsA8mJfEXI?=
 =?us-ascii?Q?AKwzXxEtVWeSb1jpnK+OglBAYk0+CP8qMix558j+PLV0QOuK0Y2m30+qr5m3?=
 =?us-ascii?Q?wcGvUBDXQZccRuxTLMdNXAt3aIAHaa7pHoTxhCFxh5U/7BnYHpoIxcxBl0qD?=
 =?us-ascii?Q?cF2QLTpx1cTeOZy1AMJ928BEcaA96uDj44knbSjcZ1Ht8aGH5F+gKz761yM0?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68497b8a-3660-40dc-9e64-08db3351c1cf
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2023 08:10:44.3230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nU20aYk33SbnoXgonkiavtO4uFNMAMvZfhDFQ+8z/39DqVgI2II5q4r0dbj3ZbpuL3In2niXDXEVB5DGzM2mT6Fh75JkOLLlrHFEa97u19A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9901
Cc: eperezma@redhat.com, viktor@daynix.com,
 virtualization@lists.linux-foundation.org
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
data includes the vqn, next_off and next_wrap for packed virtqueues.

This patch follows a patch [1] by Viktor Prutyanov which adds support
for the MMIO, channel I/O and modern PCI transports.

This patch needs to be applied on top of Viktor's patch.

[1] https://lore.kernel.org/lkml/20230324195029.2410503-1-viktor@daynix.com/

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
 drivers/virtio/virtio_vdpa.c | 20 ++++++++++++++++++--
 include/linux/vdpa.h         |  6 ++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index d7f5af62dda..bdaf30f7fbf 100644
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
+	bool (*notify)(struct virtqueue *vq);
 	struct vdpa_callback cb;
 	struct virtqueue *vq;
 	u64 desc_addr, driver_addr, device_addr;
@@ -154,6 +166,11 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	if (index >= vdpa->nvqs)
 		return ERR_PTR(-ENOENT);
 
+	if (__virtio_test_bit(vdev, VIRTIO_F_NOTIFICATION_DATA))
+		notify = virtio_vdpa_notify_with_data;
+	else
+		notify = virtio_vdpa_notify;
+
 	/* Queue shouldn't already be set up. */
 	if (ops->get_vq_ready(vdpa, index))
 		return ERR_PTR(-ENOENT);
@@ -183,8 +200,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
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
index 43f59ef10cc..a83bb0501c5 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -143,6 +143,11 @@ struct vdpa_map_file {
  * @kick_vq:			Kick the virtqueue
  *				@vdev: vdpa device
  *				@idx: virtqueue index
+ * @kick_vq_with_data:		Kick the virtqueue and supply extra data
+ *				(only if VIRTIO_F_NOTIFICATION_DATA is negotiated)
+ *				@vdev: vdpa device
+ *				@data: includes vqn, next_off and next_wrap for
+ *				packed virtqueues
  * @set_vq_cb:			Set the interrupt callback function for
  *				a virtqueue
  *				@vdev: vdpa device
@@ -300,6 +305,7 @@ struct vdpa_config_ops {
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
