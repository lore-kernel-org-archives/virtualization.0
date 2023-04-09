Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA369C761A6
	for <virtualization@archiver.kernel.org>; Sun,  9 Apr 2023 09:10:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F3E660FB2;
	Sun,  9 Apr 2023 09:10:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F3E660FB2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=AMMa4x9Q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8gdozFzAKXYI; Sun,  9 Apr 2023 09:10:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B0DBB60AB9;
	Sun,  9 Apr 2023 09:10:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B0DBB60AB9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89315C0037;
	Sun,  9 Apr 2023 09:10:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDCE9C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Apr 2023 09:10:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 96901822DD
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Apr 2023 09:10:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 96901822DD
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=AMMa4x9Q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0GmamrIfBrhT
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Apr 2023 09:10:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CB594822F8
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::622])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CB594822F8
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Apr 2023 09:10:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6e5dAKthlPRU3/dvdSecBvXFUFLdU1JljXcItzFy/Q1H82nZ1kjMPhApSKPqs+yr9j3CJXE6o/xcVHlYsMJyY43H45aspeXtoqMO2n1Zmt5x1PBmGwijcY98V2bwNtu5eO49JVOC+2Q8BvXIsw7IoEl+VsVXzvTBohzDmzmarfiBAON5fv4PUXbCMgg/RR5W551m3ZtSaDQqk5TQIRAt3c9Nn83jiB2VQxFvB0oWJqXlO5huW7e9FlDo2tdBIZFY/w5n06LwY4xOQmix9QtvCi4mT89t0K1qGpNCqRjOMuOMjvUbmY18maIbHWDHp9cTvpBrFUTgm5Q/x/7NbVFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnT7bLmoMsT6ZKGYbp/6uJJDBLJYpNI/iT5CFmVra1E=;
 b=NlDUVBze4lk5FzjrVkxYzGqDcqmSrmeDdFdqmuhKn4EQGvH/7VYT8N7UdRh7h/T9lcfB4R8ZG0g1Qdtad8QrN4keSuZYSuIMBxs3EEijKmWxbylE+ER7XRd08BtnmuaUS2l9zOmaXFMsC28g+fB1IPlEzvGytfXDJWOjtkBsyzNFs1fFrpRG1ptgEDXn8q7NPAdXNrn+9he+2EntwjPfkMk2MCjOYqXUlrd1igl4NTU1vkVh2QQ3QROh9X2QqDbCJOX/Vk+Iob+DaoKpzd9cNKHQXauHLRnyDHqLJCUxXz2Dql9dmGq2HTqGAsFYKdIn4SL+BlFMnKoyjoJXVZfjSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnT7bLmoMsT6ZKGYbp/6uJJDBLJYpNI/iT5CFmVra1E=;
 b=AMMa4x9Q6Sv8zvOyDsXbYB0rc5zj+DGJqoUN5o3L+1ux2yfY38Hx1U+zXATJ3tj32N/z2xehAiAmNxCkisUbXlGh8uaFG4W/T9coLC6qgAfgoKccbFZ5ViLTHPUWn8ciSxMsKpXJn0LMzwZedjELYBuemIugeXrPqhs/xSz/7ck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by PA4PR04MB9485.eurprd04.prod.outlook.com (2603:10a6:102:27d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Sun, 9 Apr
 2023 09:10:42 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977%5]) with mapi id 15.20.6277.038; Sun, 9 Apr 2023
 09:10:42 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v2 2/2] vdpa/snet: support the suspend vDPA callback
Date: Sun,  9 Apr 2023 12:10:24 +0300
Message-Id: <20230409091024.3437405-3-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230409091024.3437405-1-alvaro.karsz@solid-run.com>
References: <20230409091024.3437405-1-alvaro.karsz@solid-run.com>
X-ClientProxiedBy: ZR0P278CA0133.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::12) To AM0PR04MB4723.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4723:EE_|PA4PR04MB9485:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e7ef4fd-5d10-4ca1-a994-08db38da4b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HRdKsCjCkJaWGIBog7GOcXag6gR8bxBoZHOKjLLvcAb77klwghQKElfSi0MBqSbh1xP7cipluXe0z8gkZa7lRkbvumZumfEzRT1X7mhgcOy4FjXzpH//Kai8sP2EZ3iwUiTYAV3c39HrtcUny3c1jB6YztLa59Jq8Y3XN2g9gmYKpXFJNoOu4kJeD/OeWr/MLIU9Zqw6KWbN5MOl1Qgq1BtqYkvOdoFU4ieq3ds6TT1QJBy1As/ecBZXawxT5tplcVeLXF9rUAsBz7pJrVOda8XmHfptvC6CguBttBHhGvXsvkcaqNITcrBbrzahqoBxiFGWcHN92OK0lzcMmugyXSOX+0Ov/SgbpdSug1cqiqxTKPWCac/dF2z/u6HQt/7YPypZyX+SPYcD/DHdKzXBuedBKdhSNMZIj59g4a2XLidaaYQWODrGdqxgaRUpYulyJZG5nZClo7+KEndwsLYUgjKpjwEgVsngR3oZ7PBmLpFW1vMvQPIBgleZpmSf9rJDmB862T2j3H+ojHI+Fl4JUaHHH2KSj9NzVG40/vZAHZIfj4LVeoLwj2NHeVPvIj3HyJZO9OZHzOKMYMNeo1Xpec9pm2maikCjsLefG6oQIQ5vKGmcGjwyXfdkyvfHk49m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(39830400003)(376002)(396003)(136003)(346002)(451199021)(8936002)(83380400001)(2616005)(186003)(6486002)(52116002)(6666004)(1076003)(26005)(6506007)(6512007)(107886003)(478600001)(15650500001)(44832011)(5660300002)(2906002)(38100700002)(36756003)(38350700002)(66946007)(4326008)(41300700001)(66556008)(66476007)(8676002)(86362001)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MBIV40fDXxTCv6gwb+5R94SUV+ZyyztPD7nw/G/RM8sLevJBft2T9jgKnPgh?=
 =?us-ascii?Q?45tIe1FWJ8BmUqBgqljE9NU5IUbDd9MYufzFGa5RT/WvG08se+vRTIXyxIRm?=
 =?us-ascii?Q?tXH557H6tPgA3d2zXqnEVpm8/lsUfwZMhsaQMYn5FmWB+PpMq+eSWklG9D+B?=
 =?us-ascii?Q?VwVGT55VeRUwzgVT/tSPxO16yzuNv5j93ng9utcas3XAzX4FkGAhxNtHMR7H?=
 =?us-ascii?Q?uYz5f98pUVfXex8TI78ow3hyblEaOunEBYccjzbpne/rzwgkAjEEDEDpgaSy?=
 =?us-ascii?Q?+iNZLFRa/xCVBooNqUn7FC8igRI5tU2HRpHnto54q0+R59KDGbtsUJViqWIK?=
 =?us-ascii?Q?WbCrdSN3pfduaQzLReetZ0OZdc5aX/GIxhVl1/zJNMfhn3ICDvhb+4o+/J0G?=
 =?us-ascii?Q?EnfcWqj3xAzUQU0UvcB37goAPbV9AXsgEQm1CNJrBytXLCyVZpC7NeHGtooE?=
 =?us-ascii?Q?oZ1ilPUI/YwFDdO8T0+VpHVtfHBi07jxGiPwwqTE5QwbN68Ctq8DaArqTEFM?=
 =?us-ascii?Q?dG4tiDPNFehlt56jAXS720mHfE2FGfIIUMZ8CjhAbkVwqwhck2jze+vGSI8E?=
 =?us-ascii?Q?hXfddWQ6GGegpVYrL/Y4iXjZ8mmh7XQlu6Rmzw1o0gF2/DN1jEgV0CsGqcHq?=
 =?us-ascii?Q?HG3An4uNZ4htXclM+sL4DN+EdiuLkRAi3l8qVSbNLsmSXm/Z60iHpahQy6tK?=
 =?us-ascii?Q?4dbQSY30N51LwU24FzFUp1nZ6duYBcd/JhGNY2AvA5nPJi6DfIH2xyHQxGv7?=
 =?us-ascii?Q?OA0ww31SpPoqWz3vwCW3TawyBnJkU88lQYjSfiM4av1WByuRepIRpbRnYPSg?=
 =?us-ascii?Q?9hNRCXOqKALCTq/DUJSt2EpdEU2EiHTdQI6PPCcYY1gnOGvUNMsIENLER6XT?=
 =?us-ascii?Q?kthjnmj6GvJcG0qKwK4hYVtD9wIiMOdmO/Aosm6oJ1C0cG9RgApLs2+sBAZ5?=
 =?us-ascii?Q?ow9DmxpsjPpMHH159c0GGBfzXbbD5MRFjdTjesoVj/QDkfwQ/8lfKfrd+7SI?=
 =?us-ascii?Q?DyT1/WRijxZr0nJXK2G/frY7FaoEr1L5PNphxIxGBnmpbYsrNy+FHrZINXip?=
 =?us-ascii?Q?04lShJJBM3C1OUTpQYhDj8OL5EjrxJZiD8v32t7dL59f6TXxjAffnH6Iap8R?=
 =?us-ascii?Q?5oTjcOwM8IAtkNmT9MhOFXS9y4R5Qk7wYgKDqJdiWtR76K5m5PeRusJZoJoZ?=
 =?us-ascii?Q?venISLp3PpalQP4Ie6hNRnZ+sb/T/mVNUlQUghO2DaV4rbf+yMRALWAo+N0x?=
 =?us-ascii?Q?GESNUoOajhyjN+tO2mYYeRu+1Z1bMz1XiYK7eGDiXwUkGOYe7DikWDoBQ4L2?=
 =?us-ascii?Q?tXHL9u8ar0FJWexDM7QyKurUe54/ftN77tzwW+F4PxnvYJTh5GW0Tp5kF+ol?=
 =?us-ascii?Q?RV1O6OE/43/sX3ZPsewaH9zx0koWk3ZEZpuVi+WrTdhw8XuMq1cpmBZYwJoJ?=
 =?us-ascii?Q?O/RFLZG5PRpl/6N0jh0a9AosHJGMz9/IeoE4FVnJvSjDImwv2pjuuZHFISR4?=
 =?us-ascii?Q?RGkYxZI6TUw40o6+J6QKkz7yo419RlApwaY2PfdYyKoyY8UMB+kgOoTCd1JJ?=
 =?us-ascii?Q?HP1w6uqVbJUtDrqLuaWJoq2lrUiNN2CLH/yqclQ7ugdeGLcrFLBZlana7rtJ?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7ef4fd-5d10-4ca1-a994-08db38da4b49
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2023 09:10:42.1744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0cQWT32HVkA6uwE3IqdJECXszumDX+bD1SVCMvc1yro6wXKkCJX6Qfsrt5ptjZ+WS88Jwlbat6Q4pQZp391evNnZi+RmZ24njufZ0K7yNnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9485
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

When suspend is called, the driver sends a suspend command to the DPU
through the control mechanism.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
 drivers/vdpa/solidrun/snet_ctrl.c |  6 ++++++
 drivers/vdpa/solidrun/snet_main.c | 15 +++++++++++++++
 drivers/vdpa/solidrun/snet_vdpa.h |  1 +
 3 files changed, 22 insertions(+)

diff --git a/drivers/vdpa/solidrun/snet_ctrl.c b/drivers/vdpa/solidrun/snet_ctrl.c
index 01e746ba7ac..4e808ec9ad0 100644
--- a/drivers/vdpa/solidrun/snet_ctrl.c
+++ b/drivers/vdpa/solidrun/snet_ctrl.c
@@ -15,6 +15,7 @@
 enum snet_ctrl_opcodes {
 	SNET_CTRL_OP_DESTROY = 1,
 	SNET_CTRL_OP_READ_VQ_STATE,
+	SNET_CTRL_OP_SUSPEND,
 };
 
 #define SNET_CTRL_TIMEOUT	        2000000
@@ -314,3 +315,8 @@ int snet_read_vq_state(struct snet *snet, u16 idx, struct vdpa_vq_state *state)
 	return snet_ctrl_read_from_dpu(snet, SNET_CTRL_OP_READ_VQ_STATE, idx, state,
 				       sizeof(*state));
 }
+
+int snet_suspend_dev(struct snet *snet)
+{
+	return snet_send_ctrl_msg(snet, SNET_CTRL_OP_SUSPEND, 0);
+}
diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index daeb69d00ed..96830e58211 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -483,6 +483,20 @@ static void snet_set_config(struct vdpa_device *vdev, unsigned int offset,
 		iowrite8(*buf_ptr++, cfg_ptr + i);
 }
 
+static int snet_suspend(struct vdpa_device *vdev)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+	int ret;
+
+	ret = snet_suspend_dev(snet);
+	if (ret)
+		SNET_ERR(snet->pdev, "SNET[%u] suspend failed, err: %d\n", snet->sid, ret);
+	else
+		SNET_DBG(snet->pdev, "Suspend SNET[%u] device\n", snet->sid);
+
+	return ret;
+}
+
 static const struct vdpa_config_ops snet_config_ops = {
 	.set_vq_address         = snet_set_vq_address,
 	.set_vq_num             = snet_set_vq_num,
@@ -508,6 +522,7 @@ static const struct vdpa_config_ops snet_config_ops = {
 	.set_status             = snet_set_status,
 	.get_config             = snet_get_config,
 	.set_config             = snet_set_config,
+	.suspend		= snet_suspend,
 };
 
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
diff --git a/drivers/vdpa/solidrun/snet_vdpa.h b/drivers/vdpa/solidrun/snet_vdpa.h
index a4213e97cfc..6dbb95fe2b7 100644
--- a/drivers/vdpa/solidrun/snet_vdpa.h
+++ b/drivers/vdpa/solidrun/snet_vdpa.h
@@ -201,5 +201,6 @@ void psnet_create_hwmon(struct pci_dev *pdev);
 void snet_ctrl_clear(struct snet *snet);
 int snet_destroy_dev(struct snet *snet);
 int snet_read_vq_state(struct snet *snet, u16 idx, struct vdpa_vq_state *state);
+int snet_suspend_dev(struct snet *snet);
 
 #endif //_SNET_VDPA_H_
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
