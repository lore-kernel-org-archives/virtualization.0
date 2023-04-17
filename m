Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DBAC77B72
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 08:39:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD8B741B33;
	Mon, 17 Apr 2023 08:39:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DD8B741B33
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=iuLzgPru
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XzGOZcVLfqh4; Mon, 17 Apr 2023 08:39:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 39BB941B50;
	Mon, 17 Apr 2023 08:39:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 39BB941B50
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10679C0037;
	Mon, 17 Apr 2023 08:39:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE152C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 08:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 862C341B33
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 08:39:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 862C341B33
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o3zbS5KLNnlN
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 08:39:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 462FD41989
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::60f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 462FD41989
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 08:39:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIDTCJ9HOF4nM5JVAmpcBuodn+Hu+geFgghJq+qRKiAeSPDJAQs+d1Bhkhg/v9xSARywYU2tt28ag3C9odRWomCoJl+IWJ+5OVjfXLcE8F9xrfQL7nkBEki96ZcWsCwYZEtgn5B3phYPDLrPiQCbm+ylvPPAaYeC6xacbPDVy6H6NHASvrRdRGb2BzbaiExYs0TgeOHI+8b4ur4Aorqf4ZF+4JTPsbcqa93kDp2TQBCo4sHrO2mlAxlYFJ1+nu3m4gmSpGTMYFO8WcusxaCTdBaVIidUkWH05PtMWM3bfMUMXa2q1kyZEHf3lZJJWeTRoxF8qke+njGv/5MRZPHcmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKMeSd3HGb+TSORMS7oEtJhyYmW8TyTYqG38F2Vrz2c=;
 b=eMa69L1bDDQVua+tY8X9RaTOPZBmuEDhTX/+rg7UkTYvyJ5a3D2A7oAZRXhGTeKitiBVXrAngTUNMGztBYBT9AnmnWiph8FuhzjIJvHv4qedUVEnnjLUaJ843YILyPmux1tiPJ1fmDvGRZHAwR77HwBQfbr21whGYBd3RxlnRpaUUcG5S5DWC8zAyGg5wUFCyekVDmmchZtm1GmE+EuG102LC0n7gsEsKMR5JcD/OvtEHPgnqW+6sO+yE9GKEHUGnuf1TRQ/fu2gv81vyKMnoAb7wXUJbyDijNzcfDkXyArMcPLzOq5Gz+OnxUIlV9nNxVLvY2wCwhXqJBxps+sZFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKMeSd3HGb+TSORMS7oEtJhyYmW8TyTYqG38F2Vrz2c=;
 b=iuLzgPru0gQVVSx5JakZkZmEupsNst5R5vunsUdPqijl9gQEyVTZq/MyZIf4xspqH0ui1Rhc3TMkjpHG6EvqLpIdW+INl6tHtwd/6FVkX4Rz4cfYJcJbkQUCoC1j7YEC/dkgKR7iLWJVBDkX0KFjR1CrjM4IxFO+AFECLwRcvvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by PR3PR04MB7420.eurprd04.prod.outlook.com (2603:10a6:102:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 08:39:02 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977%5]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 08:39:02 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH] vdpa/snet: implement kick_vq_with_data callback
Date: Mon, 17 Apr 2023 11:38:53 +0300
Message-Id: <20230417083853.375076-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
X-ClientProxiedBy: MR1P264CA0194.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::9) To AM0PR04MB4723.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4723:EE_|PR3PR04MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: 19affb4d-c794-4a1b-061a-08db3f1f31e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9pkQR5J/g2+t6jjKc14ICVr5cE3uSQSx+PwOObRoaEx8ASFAc8Hz7/VZSC9C3y7UsArCOhlKFiGO5ctKWn6v5lPbr6kKJv6WxBekBS0uEczsQ4QCO3L7L9OOc8j/GdlT4QVbcAS1ezqloliYCYGA5yQ5ESEo/U06oLvXUJ7TyYdHfcWdCn3wrVonBYz5MaCjpLZEgUbHW3hGz70B071MV8rPjpsTaDKHoux7t9CmYuJWxGuKGapGLGblCsU4l9Ih659r39ypppy0YuKBcTf2vWONcKP7mqKUMSyMmtorLH+nKGHHM1SOR+rkla42FBfllrKPJJTfL7u87MDyDFwmzCF2y884lGslDP8/UYUm5U0e5z0mdvAmdSmofOQ3Oscp5yPM+gVBW1fEM9H/BHva/P2weHaoprY80Z3ZML7/wQhhyC3Tf2gqTF7hU244SqDzeOpLkcjceuTCaPrNpScEwIyoFqLCgzNzI7YVHMlquUwOY4dj9XGw3bxIEzuP+KjLZjhQku3juJ/RRpfArkO5Ejt22fkTZHv3vHyRTuv3VKOo+QTQve2QN3QiE78uqyFGk36JYn5iKE2crSjvBffe5ezHiO9Bm0nGUKPCDelPak=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(136003)(346002)(376002)(39840400004)(366004)(451199021)(5660300002)(44832011)(2616005)(86362001)(107886003)(966005)(186003)(26005)(6506007)(1076003)(6512007)(38100700002)(38350700002)(8676002)(8936002)(478600001)(6666004)(6486002)(52116002)(316002)(41300700001)(36756003)(66476007)(66556008)(4326008)(66946007)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lPODoFZP+smkwONOsNIA0o7hqig0julJn9RZgoJfpuHWVaal8J2UhN2w2GNl?=
 =?us-ascii?Q?QMdP4p7ovsstCDgvId4rbsPcp60YTieLSOnawInVpYd8V0fAX15hbyLoFPIo?=
 =?us-ascii?Q?nduoDMWa1Cvu8OcAVOf4/FXSyIWeRr4wOHmJ5pAEx6Hlv/m6AyNiyCAMn0hF?=
 =?us-ascii?Q?xP27gUoP5fdyP18b0670pzh79K+oEtLXdWUxWJHElcQ3PErq5xd7iTYHoijE?=
 =?us-ascii?Q?0U6nUwHOyOk4p3ODV7E/Im8UQSBMQsiUk7aRiLC0Yy8/Vj04Gkrw++22QKrt?=
 =?us-ascii?Q?A97paHkiFMLamV8dJyXIry93UDTyvWuPkWL2gbn4Zr0EASyEsVjLk1m6gX2/?=
 =?us-ascii?Q?ymE9n8TU/2ogkFobL6t3+JPpkotSLfxp/hO4t9Vv68TDSFzDgrO4mbo8YRmX?=
 =?us-ascii?Q?AKxCUN4+eGr4PXsmt1A+BF8zDFmw5YmuREgifh6LHVZNQj8w+xnHNMaUu/1X?=
 =?us-ascii?Q?HiCSz8e2pc3mQntfEGHsvRE+ZZVy+eOwMPjYXMLwEJdwmevABT8oW/MMQ1wP?=
 =?us-ascii?Q?r8RbP4h1IcbKVQHVrLfWclqjUSq/254xkachHH6gL2e3/vivwqMW9/vjQG/M?=
 =?us-ascii?Q?u4XJXEt/ZIBZ7j8Wr+5dUhIECLgA/cjU99x7WnxaBjbwx3lRPQRpB6rH91Fx?=
 =?us-ascii?Q?CJHUG+OoXKpH0JuOHQbEFBZYU3L3/M4UgKBoZuSZKdasqkOuwNZssXkf8OFs?=
 =?us-ascii?Q?DCPCG6tlNFjgnLhPiDN0K8g618balqDOGV+pbti7iZMj5FWmaO5AZWlMOOa7?=
 =?us-ascii?Q?K8HzBrgAybrCYFWf4LrHtayhbAJ/6Z/lfA502A58kA/2E91UFcIMSUOTumMa?=
 =?us-ascii?Q?BlWuRBudObCCmhg626ExPUcq4trsnyZs76FOF9UcfEVrmOz9tBskNkGjk96B?=
 =?us-ascii?Q?UiBk4gcbs+zg5eCJIkl2y2M8ZVnGX+YGz9Z911IKfmNH6F41YaUsR5iuzzyF?=
 =?us-ascii?Q?sHs5EtUcvvgGiMAYd9+Qxur5VfZ+59Mi6l30GaU2x+TYD86M1D+ne7/gIuv6?=
 =?us-ascii?Q?6rCU2RE8nUU9tLln9TOzrdD7HimFMPN28ryZnUNkoAp9tZAGbrwEIpSjbv7W?=
 =?us-ascii?Q?IypmwkaMQhmPnJY3lk3gJLQfz1ZVbUsfuZXF0VYvMd36z5xMqWR2OEl3IZwX?=
 =?us-ascii?Q?82InrYjWL6c9q3o3ZtGlFEd9bXIxjlTdDazDAhaL1DaeZOf6wGAGTrQMzRov?=
 =?us-ascii?Q?DJKcasY3h5BMYYxj7VQq7VCP39CXCX9pKwXGPUgDC+uDxdztB19mqjl+JV/M?=
 =?us-ascii?Q?mseN1qqaHxbCUk7y8geagBKUIoS1B8Asq4mgu9Q5PNCyboM3L+oCltsNSg70?=
 =?us-ascii?Q?Ye4H9BgoAu/kmfOj9Lqx/Y67DiEQ4kLcf1bcaoZWsULMrsxyo8lzJ8aPI+rH?=
 =?us-ascii?Q?p9MbWaVszkHYVVFW38NXWv4GP2BvUQfi2c/V7lo1MB6VdZRyaOB0TTAcWFXh?=
 =?us-ascii?Q?EV5tzL4QGCHQr3HcNDCxYurxfRqFZBXixxQdQ5jpDy+5nXnik3RFjdSUxmAX?=
 =?us-ascii?Q?DmrWxh4Tu1FjrAxa+KtTGLN48lJtoJTn2H0MFH7/yOWESb07y2d0wxhqcOit?=
 =?us-ascii?Q?eWum7uaqYIPrSoznZUmwz4oP2OwoTymApSRVqIXi05IlWdmYt798zNCVfqF5?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19affb4d-c794-4a1b-061a-08db3f1f31e3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 08:39:01.9864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UuwXHYxBxZE9etGBknwN8D89ChP7vfThiIHm8jHOv2rOzF0BmgdX7YT63tuodJ39W/HeP3qLOjLmSnkUGgEXBaX1kUJ+NVrmyrHIg5qG5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7420
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

Implement the kick_vq_with_data vDPA callback.
On kick, we pass the next available data to the DPU by writing it in
the kick offset.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
Should be applied on top of:
https://lore.kernel.org/virtualization/20230413081855.36643-1-alvaro.karsz@solid-run.com/

 drivers/vdpa/solidrun/snet_main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 20dbb2b82c8..99428a04068 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -112,6 +112,18 @@ static void snet_kick_vq(struct vdpa_device *vdev, u16 idx)
 	iowrite32(SNET_KICK_VAL, snet->vqs[idx]->kick_ptr);
 }
 
+static void snet_kick_vq_with_data(struct vdpa_device *vdev, u32 data)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+	u16 idx = data & 0xFFFF;
+
+	/* not ready - ignore */
+	if (unlikely(!snet->vqs[idx]->ready))
+		return;
+
+	iowrite32((data & 0xFFFF0000) | SNET_KICK_VAL, snet->vqs[idx]->kick_ptr);
+}
+
 static void snet_set_vq_cb(struct vdpa_device *vdev, u16 idx, struct vdpa_callback *cb)
 {
 	struct snet *snet = vdpa_to_snet(vdev);
@@ -515,6 +527,7 @@ static const struct vdpa_config_ops snet_config_ops = {
 	.set_vq_address         = snet_set_vq_address,
 	.set_vq_num             = snet_set_vq_num,
 	.kick_vq                = snet_kick_vq,
+	.kick_vq_with_data	= snet_kick_vq_with_data,
 	.set_vq_cb              = snet_set_vq_cb,
 	.set_vq_ready           = snet_set_vq_ready,
 	.get_vq_ready           = snet_get_vq_ready,
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
