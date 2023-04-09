Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AACDC77B70
	for <virtualization@archiver.kernel.org>; Sun,  9 Apr 2023 12:02:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9B01A400F1;
	Sun,  9 Apr 2023 12:02:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B01A400F1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=hXle2fyv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P3MgimGdFpNy; Sun,  9 Apr 2023 12:02:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3A5034037C;
	Sun,  9 Apr 2023 12:02:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A5034037C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6E25C0036;
	Sun,  9 Apr 2023 12:02:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E8A8C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Apr 2023 12:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1046741761
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Apr 2023 12:02:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1046741761
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=hXle2fyv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GcrByCwPQ3Tq
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Apr 2023 12:02:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E0F4B41725
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E0F4B41725
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Apr 2023 12:02:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6RQIJM68lQrIibsNJELiItGDA+MFQFtPDALFIIpYFnVVybBMUob6WJ9fXbwaVsq2QjjEaKoTTrU0ZqBy5TRzcvnXuyYjfTf5R6sC/1mhvlSkB2cKkRnpYkK2qhwbavXKf3sefkkHRZ67aDe2XBGk2zrC4d/u2q5ezACNQ4wxPLGLEhooJhjQyI746v0x88XR6Ao+rIxfPXtj9fKkDHY2jeUqzcd0wPgM7HDbJ75dRE6VE6fZhlN4UefvN8+k0slQX7aXs8Tt4vPIAF+kxPpGzCZgY9JdgSo7ndCNGkdzn006pyFK+270KMyEPAA3e8avopCHJui7T+8jONViqHUtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWIMdXd5J3D49SFjHsbs9zNU0gubenasLYy9FHFgGXM=;
 b=Ob8fUSiTTehGnwaPLfAHdXrtzrselvVD6REu4P0aGg9raAsZXfgB0HsNVoo583kCTWsbWnPAb2bscRQuLBTtZRLZcyHwC5b46Sp+vlJ8HnwQQ3OKFTDUPGbEYPd4GPmXwyxcp1Ji/iCqqr55FU9LwoS5roOXniGpfZC86y1lfV/Lyp3hRl8FKy+snWAhOtm+uXiDmk0PRUiJxbpIdOBJi4X6BU27rPy7q7APlZeb75qjhOscnk+vJe2E5DV+E6swGFeT1yrz0nX78xHFA7IaDwG4XSmSBD23LqXZeN/Qw0X2wdBoHucAGo5ZE/+PWskDlVOhnK+ZNXkiNGQN29KeKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWIMdXd5J3D49SFjHsbs9zNU0gubenasLYy9FHFgGXM=;
 b=hXle2fyv6cdAaUwJxjX8pJ7wt43Kn81DI//AzmaZhrsMfyS9j/zvVHNtV2zAYG/9EDLouWFSe0524jSk1dvyeiG2FFAwgUu31FpEByU1eXDbhV3UZE5kHz0f2Xgza++koY+5iJf6SYtXPTbI6PizTAK9UVJyRaPSB/WyJGEyB/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Sun, 9 Apr
 2023 12:02:50 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977%5]) with mapi id 15.20.6277.038; Sun, 9 Apr 2023
 12:02:50 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH] vdpa/snet: use likely/unlikely macros in hot functions
Date: Sun,  9 Apr 2023 15:02:42 +0300
Message-Id: <20230409120242.3460074-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
X-ClientProxiedBy: ZR2P278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::14) To AM0PR04MB4723.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4723:EE_|DU2PR04MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: 818ceb46-73a3-45d3-3935-08db38f25724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sH43eQPhGlUxIlll+UNeCzwSmNZlQ7H7uslPXXuQMoFGNwq4KFq7kE19iX+RA+87vUliOoD76ZI+9PqChJUTNzv1Ukx3YsX3K7J4bKZARDBgvxcekoqlVdojgSmTzjTDy+GJcUA3vTOq4BuzqKccpnjgMm2Yk1YREDX+H8+vabq1BB3/fjKC1mOyYp1RCtpLJ6fiUQxkG30eDWSKT95LlMPWlQOZOQasQi65TuE+k4citDQg5sBBqK8cGwj4rHuVJ4AnDo3HPLV/kJQCPkVhgErYKJZJQ0POqiBx3sVw2jCXB9sFWJCsz8StlKLjw1RWKAm6fueIyMhFnm10RNm9w+gdMIAikx/2zl++Mb6I+KZp38n2kHt7I9cyQuCdRquykARpZudtnB36k7lPd0dyoLiB60h4SJC//Cq+/M70wQzxQn23qkTG0NmKc+M+Wb4Dsehmp3awEBhjL9N0QyPBF2fVtWdwOcy9eow+tKmI7GxN4pGKnVheB96AtDnfT7nRZ2pZmxL2nYQZNrvrYJSVt8kxgoy9d+MEwcPwOegfow3o7ROmAe86p7vkb8OynNFomeCo68yAN9nUAJo+9GuMq+6lnFI6erp4LyzrGff8sR3JwJ8lJzxUaYm82JUqOOz8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(136003)(39840400004)(366004)(376002)(346002)(451199021)(66946007)(86362001)(26005)(1076003)(316002)(6506007)(6512007)(66556008)(66476007)(4326008)(186003)(36756003)(6666004)(6486002)(52116002)(478600001)(107886003)(38350700002)(8676002)(8936002)(38100700002)(2616005)(5660300002)(41300700001)(2906002)(83380400001)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y1KBq8AdzlaWteMtr1zce7gy1jAXaNbbiKvG0+7iqr5l8Iz1rhgFcmYh8kE+?=
 =?us-ascii?Q?/yzrqBbKXvmLTDmSuh5mJbNER0vH2X6XOFlz4M8gYnVNGe+SgKyFfehIFTGv?=
 =?us-ascii?Q?QBaV80eT1LN5wh0nzNoU0K8QEoeBgaa0FOVxF8C9ac+f5YTUH7QcbfmUxbXC?=
 =?us-ascii?Q?EOqrDZHj5E9J3GSnH8a9/LChGC5miuyu+UV264KrEW9TdtwTAHyeh64iOnca?=
 =?us-ascii?Q?X2X+vAyPkUnYuCpYJ+IHGIpBMaEXLVK+ftAUj0xNde0IWFwoo8q2cv2l9dg5?=
 =?us-ascii?Q?mayZAHZDASOVBKtT1aKgWzzU+UitQJT1oHaAGr8L8Zny5A1CJor+T24Gpyk/?=
 =?us-ascii?Q?QSivhj7Yf7hIS8jsF1u4q+F6WBgBD/qV3RNoaTmP7syr7beYeucY+IhGF3bB?=
 =?us-ascii?Q?tU1GB1oX6tod59qsGoGyfDJ+qColzIE7WXGDhsgKRB6GFjvmTL/CGuUDKcn8?=
 =?us-ascii?Q?UXme2U7QGo1TtK8ZtrONVVe9DLILTWinr95ZE+xsTbtZ7DkDqpcdK2mI2mJN?=
 =?us-ascii?Q?Jtv4SQImtglIt1RKDI2kIh5AB68eB39Q2cJts1sIyYCCo0tVwdxRyXxbSVWL?=
 =?us-ascii?Q?iyUcqDi4MT8RecxX8GNbJlr5FVIhztrTh7eSabAYsL8hTNbBr1moub4yd6Ey?=
 =?us-ascii?Q?cT0n3m+rSp+UyA0p9lv8aoA9ZXoFh44hW964Stk/kFBnJrfC0qHY+088rpgb?=
 =?us-ascii?Q?Ke0AxyLtidh5ea4MAJXI5IOrmJD2NdcUx8gxZqmGrR6+WEKDv+qFKWx3+2So?=
 =?us-ascii?Q?90qiOFyfYtq11GLyGEXtVZP6+zbFvu5iXPAclP0/xAmLVTdrXppONym/e1Ta?=
 =?us-ascii?Q?Q7Q4kD4PvVMg4L7tn2qNaWy2DPXGfzl5I80gD2VT7gLjYLkNSiWWxmUmxiRm?=
 =?us-ascii?Q?9cuiILivoGVQVacayybaSlsfm+H6NVoOoOTBVofqIQuVCUGMoY9vnKNUSIeH?=
 =?us-ascii?Q?00zx+gGwriWp7ga73qYtF4WmC/4R9kwu0VAcPu5Eia/77z8Lc2NMCj3D6H20?=
 =?us-ascii?Q?JOkuIQ/rGH1DEP3Im5x7wvsGCWFBKAUp8kFhPKFZgq9+wMtVAYElUj60h3hY?=
 =?us-ascii?Q?mgjE5Wm6WaVk4EIyD5/oqYywTXJDFdGTlsaG2P5BcGigGSUAgYoVnLbjzDiJ?=
 =?us-ascii?Q?/7JkGet7J3xtxSKECLwF0AlvyB48kObP4p5DXFjDxm50dKXEAzoTFAL+CQKn?=
 =?us-ascii?Q?M9bgNRrX01wO3dvXnJnvKte8G44RdrTZVsIF0rD6zXP++JX5EjsDMBCd6LAC?=
 =?us-ascii?Q?rMJQwJGI+OPQ6rS6ouYEe5ZfGYeXuTyE+D0ceau3QOZy6r2MceEkzxB+gguq?=
 =?us-ascii?Q?4gNhBZoZ7alCij+A0DLusbkihEz3+d6YIj14gGqQLvZz4MvxMLtSrO8xtcPN?=
 =?us-ascii?Q?SjnNwWK53dOwUBmV772ujkLj81X2jSeJ665ZM38Z3JYSeZAIyuZmU66zk4Fc?=
 =?us-ascii?Q?SnXgEbeeSbmK4tk2YvrhImMDughlOoJwgPOoLqYx+yJemc4jvLx7i1sJ5cj0?=
 =?us-ascii?Q?7g9gsXFN1a3WWhMXS1uxQDXbKleb9qVOi0zLkwqS0TJG9wa7c8atOddDTFFd?=
 =?us-ascii?Q?zNxTawQYAeagLpK6nzYzWjLwuhdTeXb+tpdnMKGASIXt0R46hzmLZ6MtlbgX?=
 =?us-ascii?Q?8g=3D=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818ceb46-73a3-45d3-3935-08db38f25724
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2023 12:02:50.0675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mRkMKsbVoVVvfrln5kOKrAahzOCDmut/+xeXgriCrEyTg9yWzJq9M6eFSgW/SGh4ZzhkhsvZgtuhT5sl1xv30Zq8uMj0gwEQUI8tz2hT1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8536
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

- kick callback: most likely that the VQ is ready.
- interrupt handlers: most likely that the callback is not NULL.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
 drivers/vdpa/solidrun/snet_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 96830e58211..8d9c033a7bf 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -39,7 +39,7 @@ static irqreturn_t snet_cfg_irq_hndlr(int irq, void *data)
 {
 	struct snet *snet = data;
 	/* Call callback if any */
-	if (snet->cb.callback)
+	if (likely(snet->cb.callback))
 		return snet->cb.callback(snet->cb.private);
 
 	return IRQ_HANDLED;
@@ -49,7 +49,7 @@ static irqreturn_t snet_vq_irq_hndlr(int irq, void *data)
 {
 	struct snet_vq *vq = data;
 	/* Call callback if any */
-	if (vq->cb.callback)
+	if (likely(vq->cb.callback))
 		return vq->cb.callback(vq->cb.private);
 
 	return IRQ_HANDLED;
@@ -106,7 +106,7 @@ static void snet_kick_vq(struct vdpa_device *vdev, u16 idx)
 {
 	struct snet *snet = vdpa_to_snet(vdev);
 	/* not ready - ignore */
-	if (!snet->vqs[idx]->ready)
+	if (unlikely(!snet->vqs[idx]->ready))
 		return;
 
 	iowrite32(SNET_KICK_VAL, snet->vqs[idx]->kick_ptr);
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
