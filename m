Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76009C77B61
	for <virtualization@archiver.kernel.org>; Thu, 13 Apr 2023 08:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9A0883B06;
	Thu, 13 Apr 2023 08:19:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E9A0883B06
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=TXKN3QaA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3tyMPF_hnW0v; Thu, 13 Apr 2023 08:19:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 440ED82022;
	Thu, 13 Apr 2023 08:19:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 440ED82022
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15870C007A;
	Thu, 13 Apr 2023 08:19:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB9F5C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 08:19:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BFEF060E7D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 08:19:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BFEF060E7D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=TXKN3QaA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9doTGH3jzoLy
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 08:19:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D3DE60E4B
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::60a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9D3DE60E4B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 08:19:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtTNaLmVtWrPX5cnyCwRSMvNC4qcahUiOlS4l8DFBLLH4effIV2LXBRJypUq1BZRF3zggQFfcGpNRrgKih1BMAaM57/ryhvZTCwEyKZqlJHf3wik4BHrVz+Fpd2G1sLpMQpBiSDJD20Cd+K4xCBOgU9DFD4ICBFSseM0T6WYvYiPsaR7fCGiF3fEB4lF2eX3AtbmB4PhVGzdo+e0WSYoxlmPGRqHLLcKZXGIUMq7H9sxKp2J1EwqLTZnjsMxM0bbZ2jVvXbwHvtDhjn4MjhECKTWLZYJZ/6d1TM48DpSVZDffsgAbC09/DofP5D3SPLfP4kQIlQBPf25aDG+CTFHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N174125ILgz38cpAln85Q8rftQqSNm/zgKL0yeDc/UI=;
 b=E/LwciEnyTXg7iJ8rs4K0eXhvqX0bqkacBqucDAxCZRhu3V5XDpTor/MbcDO9wYXjeuNzSH8/Cu64+lepQTu9sbGYvEaQixwfcLnHKEDiLpO8rdLUW4R2YNnZkpOpDevMNTt8IqemUcpzGqTK+tjxaHkePFt1Qoqfcvdj1y8Goul+GWyNNYqdXvYUZlcV1pzML+uW+xE2QaD7czNFwIkqpioxytLDwAvZ3//wBhk6l4H4MOJc7Inc1ttNNczHaS2W5Dt1zbG3IoI7bNJY6drYIJ2hYRF49p7tWf3BRvIhWiADPY26PMPsUp6D+qY2EqxhXCvWcZn5NvifCwLqRluWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N174125ILgz38cpAln85Q8rftQqSNm/zgKL0yeDc/UI=;
 b=TXKN3QaAJPANstwDLFYUuHxW4/9J7Yvxhevla6mKyZq0ZzS9dbsxPc5Ac96xwIMLUCmo8QC+xf9NlQDmcjVZW3bh4zd/oFld8VJSAMAhFC5kgkDYaGbvEK1KuqBXzo5DxucjmCLBFxXdt2FIgLRvFmNCvO2w0ol+HKEwf/qUm+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by DBBPR04MB7721.eurprd04.prod.outlook.com (2603:10a6:10:1f6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 08:19:13 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977%5]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 08:19:13 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 2/2] virtio-vdpa: add VIRTIO_F_NOTIFICATION_DATA feature
 support
Date: Thu, 13 Apr 2023 11:18:55 +0300
Message-Id: <20230413081855.36643-3-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413081855.36643-1-alvaro.karsz@solid-run.com>
References: <20230413081855.36643-1-alvaro.karsz@solid-run.com>
X-ClientProxiedBy: ZR0P278CA0054.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::23) To AM0PR04MB4723.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4723:EE_|DBBPR04MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: 4344d1b9-3b2e-4f73-fbce-08db3bf7c3ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pthIlGDCP8GebUhMWbDibezoEbzWh50JNkVTXjkYZ8uvZo8wr+mIk+SvOwLwzw8efeEkXs5qSvErS7ClYRxV86U8vbg7DIwFMotnObzFz2ojK5nsm0DUgSsIA/PO/OYruY7Gb26JGgJqH5othIpajXPXfSE5pQjrxSrO3VE7w2me3lNOwGlt79MTyEPEZfEdM4U4vNLuYO7R6xHMUw95inrVTNU6NwuFQRHpGlIdzND/8Gv82Dvj94oph4Wmd/pwGxHYc1w7aiX0HAO/4TObH3oRH7hgWTMHoiE6HTCoctieN/TvGIKIbQqWA39qNRYZvtqnjnhWoA6bVQCoxFQZjI4t2MXF9RjZcteG+PO86ZIbb0DP6HWk9soaaM68pJfBWd033Ud9oVhpEt0ZUS03b6qGrCs9+KG3c/CVaEjuOFvVxqPYbhayFA/Np9qXXh9tQsaoTXGVOrRpbeiPdgXTitepCI7nzmMH2zvCSLeZZ+34ihNFdC1sIwBNyr59qliZo63EfOUxCI9ousAjs1Y2Nm6tYiK4vYjOH7H/QsLdzj8Gz7YteKfpG+8zL4T1+xii6cp1zqiT9d43zP+h70ulAW28imacbd+UuzrgY2WhRL0a6iPpT0QVa8cUz6g3SKCJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(396003)(346002)(376002)(39840400004)(366004)(451199021)(6666004)(52116002)(6486002)(66476007)(66556008)(66946007)(4326008)(36756003)(2906002)(7416002)(44832011)(86362001)(41300700001)(5660300002)(8676002)(8936002)(316002)(38100700002)(38350700002)(478600001)(6512007)(6506007)(1076003)(26005)(2616005)(186003)(107886003)(66899021)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8yi89h6SVWgUkl1g1O57kE7SYDzoBXmtf4YKPiAs03kJh6Tzd10uAPHLYuVC?=
 =?us-ascii?Q?93dFr5clPcyDjS89BU9gXSzCelCX19MZ+2G1kXl+s53vEj0aBcEMh5OncoiU?=
 =?us-ascii?Q?dQcQGo+v6Dv3PAtkCjJdwk8W4s54cmHWxYNHp/XtgiJ/Ky+xUiVTx5ecVSe2?=
 =?us-ascii?Q?s/D7XkNpw6J30YoKO5XG+QYXiQVPfo2aTrA/ge6jYzEBZjXywyciwJQZ7lBm?=
 =?us-ascii?Q?CGN53sFQgvmuAED6wVMgdpdAHM63evLruVyaWgVi3nlefExkrRceDfmHCnU+?=
 =?us-ascii?Q?pdTy1QJddDAkYHYz2ULqESbWKcOnPc9TqlNcKPdqa4+q+e7X+TO9Zm37TSZV?=
 =?us-ascii?Q?Zg4xi7AStIPm/M+6JRTBBl7f4R8SZqTNp6uJhXa1CHDqoMkZJQhKHSItXQg9?=
 =?us-ascii?Q?276+GDHPbfvgyaYYc29bIgl5EhFeFFmMjJxvHTvtOy4p4ViuSrR0G0V4e7Wa?=
 =?us-ascii?Q?7Nr1ntnDsDn1JJzAk7FkcUSBMayL1XAyEkccEzlo8tPSzrsjkzT0U0PTXQ4P?=
 =?us-ascii?Q?EdUGEzKUMvQr4Y1bvPVZM9SM9rjgyWO5nLtz+Jc8OG9w/ihRbVlYLg44n9qB?=
 =?us-ascii?Q?Aqeo+otmmXPQLiqzBNBGXmo1ddYC0cWlsVMxIEFvwHOISCJgqSe1teLjHDDL?=
 =?us-ascii?Q?PToY7P6FH6IW4GQSMP6QrZzg8GblvR6X64fGszAO2/IrvY+6ckNycOEsFZEZ?=
 =?us-ascii?Q?URvFoEcL9+iMDOGIFtcvCDfoB/LXistOQOmvnocpTsijCJ8MLCPIgm0jQ3f3?=
 =?us-ascii?Q?NlHsEqKYjyrlVT5i5rA5ef6xM5AWFI71qtAF59ScABQ74OU0VYKpz9/SPPr1?=
 =?us-ascii?Q?735JKod+Wu7Ek2JXZHWfeBa44+YDMJ8Dlad4PYvKascSwK9N/QMwtmsR5Zhi?=
 =?us-ascii?Q?8Z4YllMSBEvEtrRs9B2rohBZ4j0iuKjR0VJxD40rWs06DEDjEvktgECBAajr?=
 =?us-ascii?Q?dlkX3A1zV5Et8/XRUO3yc5q9+Esz3xiyEQNZF7922jFBImtgn8PH5KP/Glt3?=
 =?us-ascii?Q?IwdMJXzNlWWu0a8FPQMG9Q9slTiniwO9xPbjYujKqIH5Vlpe6ZAiIOa76+xo?=
 =?us-ascii?Q?jTzohB+SraRU7lNElQ/UWlrTkR24np8SGMZkpa1A4NAGO66xclRTWqJ95wtE?=
 =?us-ascii?Q?hX0Cq58+P9H0ctiQ8ns81zDhA8c5DQ+accrdpPFS2xbz0E9Mb0O7w5lqH8US?=
 =?us-ascii?Q?ZnZRF4265ELSl6k7ijI5ZceMwKbkVYqkPr577imijfmobNENOR9cGsGqjhSb?=
 =?us-ascii?Q?8UNrS+bP5ZVUTP70KvhINr0Gc0yZwO4htbKLZxeTqIuMEKkUH5b0CH9xZDEi?=
 =?us-ascii?Q?6UijCQaURNaeNun91d81zo8sLXaryMPKoMuh5fzrceP2/AnVSrtFrp/ffrrm?=
 =?us-ascii?Q?u5xWpSYisiop0urvsAeUZ2KM/vpvZlUyFaSlWnnx1LPXBI0GxNxW8WyrJ/rd?=
 =?us-ascii?Q?ph/rsSqaes9eZz7lgk+yb3k4eTZRI7SilGE9V7iKKSY1JznzB3bISj/oeehr?=
 =?us-ascii?Q?U5kxmQabqUhGOnScrF0jL942Bc5pj2Rj+YrZADNZ91P9+IdxI+8uNnjRW/VQ?=
 =?us-ascii?Q?rdQzMZbijF8yGRVJbKJCgRGEeXTQfAj9YK+clgst8eus2Ec46pkUuq58Y1EY?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4344d1b9-3b2e-4f73-fbce-08db3bf7c3ff
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 08:19:13.6481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRNZOUTPJ4Sos5ZJAnJahNVxxsTITNfzJWlJVkYrPChbBlT7XPt/ED3HWD7coAWhfbSR/V3gcya8YWyuNve10CWByPIF2PuIsM8uv0+8Gzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7721
Cc: linux-s390@vger.kernel.org, farman@linux.ibm.com, kvm@vger.kernel.org,
 cohuck@redhat.com, viktor@daynix.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com, yan@daynix.com
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

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
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
