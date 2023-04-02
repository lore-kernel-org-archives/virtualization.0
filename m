Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01921C7619A
	for <virtualization@archiver.kernel.org>; Sun,  2 Apr 2023 12:52:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A3A41403AF;
	Sun,  2 Apr 2023 12:52:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A3A41403AF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=hg+FUTqj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 23qXPs_BNS1P; Sun,  2 Apr 2023 12:52:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1986B400EC;
	Sun,  2 Apr 2023 12:52:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1986B400EC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E98A9C0037;
	Sun,  2 Apr 2023 12:52:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74C3DC002F
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Apr 2023 12:52:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 37C3E41601
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Apr 2023 12:52:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 37C3E41601
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=hg+FUTqj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vcdkYmJulx_U
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Apr 2023 12:52:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 41368409E4
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe13::61b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 41368409E4
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Apr 2023 12:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nl5cer82585izH5gvKl18S4v61DhFYd650B9G96vd/RHAVU+slP1xacBsA+QS0qqUjNwF1y6vqGtdXzM3UZu6V60uj2bf8SbGT8di8N9vwK1cMMp8q7eQxduID1lIBpW6Cqdvopzq7KlDoa0lnq1Zp5MmGT7vdy2zKetW1MHSqgLWIUIW9f8LJDPK8eM7S6XMBn+1F5fuGb8XMh8LTgUSlGLXzMxQ61/ZWJjOy3fdH04XOEUyEjpWbR6T3ztB8h0/l+JrpvIfylzSahKVUHY6nif9hSIWjbrsDMtLDWrjUk7cLMlkKX/hU+e8vOM0mw/fthVODJnpY0bddIckTHa6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n18OP7vPSdiYnBPUq25VSrwcsl/zefO9nV/TBkIRO8M=;
 b=eFryHQvpGk73FZThjOzOxw3lxozg+O1FOo/ZR8L5AE4PgUbHIfLlOjitn2CPqo3Yj/ZPJT8irFjMYE8nvEcZOH1B/TCPEVeIpGt1ZTY3mmi2gEW+TdH/6ldzdr4TksahP8O5t6RrwGonEFqwW2j/rLzvN7lCHxhVzbiJK/73MdTXRRDqYiSyzrhCl3d/hy36NjVa7As3CnjhKmo149uua88HrA+aTUoeU9hKN5K/X5asIfiaVpq4D0YoMsTBwQPwbZm77u9BS4pnPJw5/Kg4Yy/Yg0yAV6zMDh6ze1YC70mD21IxlGIGjTojpQPGtcx9OoOxMacOo4RF0/CaT3mmHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n18OP7vPSdiYnBPUq25VSrwcsl/zefO9nV/TBkIRO8M=;
 b=hg+FUTqjUKGhlC1aktLSJ6l7AwTzgbksoeeFAHVLcKC6j0ZJNGUIlOtPGmz4KKiSfmC1hoKQYLjOvBKLHGay4rOMzOtp3KQ9Zl53A2WU2JojMggFUjIfk5jtbD5ivHog7qrpKqa4CX5Kpcl+jjVJ6DJG/AqEMqo8U4EvldvqlmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by DBBPR04MB7818.eurprd04.prod.outlook.com (2603:10a6:10:1f2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Sun, 2 Apr
 2023 12:52:40 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::b28a:f4f1:8415:221d]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::b28a:f4f1:8415:221d%4]) with mapi id 15.20.6254.030; Sun, 2 Apr 2023
 12:52:40 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH resend 2/2] vdpa/snet: support the suspend vDPA callback
Date: Sun,  2 Apr 2023 15:52:19 +0300
Message-Id: <20230402125219.1084754-3-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230402125219.1084754-1-alvaro.karsz@solid-run.com>
References: <20230402125219.1084754-1-alvaro.karsz@solid-run.com>
X-ClientProxiedBy: ZR0P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::21) To AM0PR04MB4723.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4723:EE_|DBBPR04MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b98fd19-79da-4fa5-9262-08db337924d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uv91eQ2kGKJoJRvKRPVRBgEiRvV+wj0FkGZ6sd+FRRu08K2dtxk4iqDK30uJvjv+s3VWkfOQedGTRNnpI1UivBrHEDZctN8n2PlgKHbdVpD2rjlJgiW1Th1A9fnTqu8TCaFFWxdhXpdfUG0oLxRxBtB8rALOQtkCbeNjiVnGFR4sVJ1oo91jAVpE1bIHmTbwQuXSvo3C3bZGBTQmnSfrCAVnRKLp14xDx34pMZU8px5cAA151gOe6dfRB7E4nwuyMb8YgohQkm3Kh5LX2G3Ikvue48BYwbVRjtCr8VvOjjrEwhwM/4e9zQ1D8+ph90P7R7Jd5A6jUgDa585zFz0ZkqquFxX2Uj4ZdGSYhQ+C/lqUF9aQOWSOSl4x0WDh9SVQoIPvf4hZfF0UX5a9ReUpBOgEjRY9tvoiK4x9PjYHYU+AotIMrpOy7nT/HqsIUAhT+6MY4JJIzoolZ39sDZKvWLVXPCDeGU7XoV6TtkXvfQ0qphdS+oxliVryjZj1HUQ11VZgfknRYyhDaPI5de/COheR/elrYCOaGevaS0IG5v18j/Hfn05ITCAw7Gwgg34ZcYp5lEah8aIupM6jjTCTKKHYVuE4vGgd9GNgGX1PgUoOHL5jKGfN7hg5tpNmyo3O
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39840400004)(136003)(376002)(366004)(396003)(346002)(451199021)(36756003)(316002)(26005)(6486002)(6512007)(66476007)(66556008)(8676002)(66946007)(4326008)(478600001)(52116002)(8936002)(5660300002)(44832011)(86362001)(15650500001)(41300700001)(186003)(38350700002)(2616005)(38100700002)(6666004)(107886003)(6506007)(1076003)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G/K0mcJ4r8kCAG6XgOwofYv7RJdoA4WPsQsIBZdN8cRiy4xh36X8nKhbAmuC?=
 =?us-ascii?Q?y3RgToajz/HAbJ90PLJ/s/DW4d6HYg7fL3+xgCkm0EzZCt09328kyYe59lMo?=
 =?us-ascii?Q?JI+kBZlSVc0ftud/Ir7R9O6ydm9DUlWJUdN7lA3tNZl0mPExY+ftkHJQ1mCa?=
 =?us-ascii?Q?mKPJqC7ZVlHUHg6vQjJZCPtCIpnSPuu/+Qam4bqbhZ3bNkw6rCtytBJorhKB?=
 =?us-ascii?Q?iJN9BMGXbdhK3KekZUvcR5mCfxecqOoPiG8eozLNB43NpHyh/xPbOvcBxkQs?=
 =?us-ascii?Q?u8AUZE8A+/JKiAmsqQt0a/oq0Rf+LuAR2boKwrUH5nF+B59Cjpsr1yQTCDV5?=
 =?us-ascii?Q?lfTqR0Fqf4W5bKP7cVqFEUf89Hk8fFAGKwz7faa+ByYDVh9hMnteFbwkX+p9?=
 =?us-ascii?Q?6UVtf/QtyA/7apF75B/KwgKFM2qN6xuSQC4kSX1sTC5KzZCZD533E+CYnIzF?=
 =?us-ascii?Q?GvhvuuxdQI5DYo8ujbXXLbLqezxo6HGIioVmJSSTpqHlWKPfbKukEIf+uGsc?=
 =?us-ascii?Q?mum/aWzSeL9IrBq9cj5EfaaFJ8+D4mNTesM0sKcsJh4HjE/oHe7H25cZvbBV?=
 =?us-ascii?Q?AhqcpBOUduD2lChOSGOT/jtMXPRG13Hv/+4wlFW/SV+5hhoPFknv6OCy87g9?=
 =?us-ascii?Q?b1G+fBS89OlH4vNWn0y7s2vH+9cx6YYUVsJIZxLdKYaXKOO5Vr+1rciQggIW?=
 =?us-ascii?Q?BTO6fbGFehmHs7D/IIQ4Tkfd19xGowsCtStkhN3IK6DHwfwxX851ak7Tzbr8?=
 =?us-ascii?Q?s3U4uVPhH0sw3frCKRjKZOHMFZdWaSvQco83cuSYIJMAn3NSGzLrRJ7pxN1D?=
 =?us-ascii?Q?+tHehF0XjVUQvcLYg7pfAz9e2BfVm26OFFUIbXMFPQYwyAgsBbezOJXGQTus?=
 =?us-ascii?Q?jNwdoEPRY8C7qKG/RmYCZaskasd/y9s4qFeB5uLnhVPEHkyoft0U5HZklRul?=
 =?us-ascii?Q?dvrd9+VvZ8pXjBVjb4H8gugZjGuzeKNUoi39gU6odx+gHziIxY9pi2xDmndz?=
 =?us-ascii?Q?TLpTHEYy9qlwvB4hcMD/UbzI3aty5f0sx5pILiO086eXc4c5HY60S6b00ZUe?=
 =?us-ascii?Q?qC0wimy8OPIQoOKclQeIlFiZ3FFAVTApGHqfGrRqI0fwinuH5CGFrEZa0UvQ?=
 =?us-ascii?Q?GakvuLhVzTlGeEGfTXBJuOTgOiFEgzozTbSPEHsQOXJOJ+/ctIICCHy4Osol?=
 =?us-ascii?Q?+BWj/xZTUVwBZdd0OOdggj4TO/us47Ac4EEnylKbYgZ1rkdTdrKni9GA07gO?=
 =?us-ascii?Q?/NEVSxnvrSkf2gBZ7hkGsBG5d8r+ipkMygl5w88AcAh3Yp7EOErC1XSt5sT4?=
 =?us-ascii?Q?6rgWhqTGHTE1YFrshxHnHWsZR/JEJAJEK6u209gHrfXmeXhxG35jXS/eaHLB?=
 =?us-ascii?Q?xbaas3yrT5cDYOjIhSb9rZoQFgh3mGGQZgPbLw1Rw4FjZKiwYigfOhZVJI9B?=
 =?us-ascii?Q?Uf2qdBkTb8+Lh2qgKiZ7CIg8p/kgS6kbVKhMS1e9YyC3lBNwNhclQM3k+LRY?=
 =?us-ascii?Q?QQcbSwKNHJxE0bqCeyMkyphMmNOi27TRw2sqSC90AW781K27QdUkATPVpNpm?=
 =?us-ascii?Q?NakaAU6pG0/TPxEKQJsQ7zUhi69IK+G7M3xTmExr6buT8Kd27Sdoc8mQCaBn?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b98fd19-79da-4fa5-9262-08db337924d6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2023 12:52:40.6935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXO3fyOTqq31SlIuMMU1+zt7JGCnD0bKa3CHOZLl0VCf6QJ4pLthq4c/FBrUfbWv2U+R3y/vIQmWiBPUJ+Ib+bxDUaHRv2+sP2TUPgYJQyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7818
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
index 54909549a00..7bbbbd08e6f 100644
--- a/drivers/vdpa/solidrun/snet_ctrl.c
+++ b/drivers/vdpa/solidrun/snet_ctrl.c
@@ -15,6 +15,7 @@
 enum snet_ctrl_opcodes {
 	SNET_CTRL_OP_DESTROY = 1,
 	SNET_CTRL_OP_READ_VQ_STATE,
+	SNET_CTRL_OP_SUSPEND,
 };
 
 #define SNET_CTRL_TIMEOUT	        2000000
@@ -316,3 +317,8 @@ int snet_read_vq_state(struct snet *snet, u16 idx, struct vdpa_vq_state *state)
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
