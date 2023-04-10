Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C633C77B61
	for <virtualization@archiver.kernel.org>; Mon, 10 Apr 2023 10:02:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF94460EED;
	Mon, 10 Apr 2023 10:02:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AF94460EED
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=IVLCyQBl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aQxOMvE9HPyY; Mon, 10 Apr 2023 10:02:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CD5086FE87;
	Mon, 10 Apr 2023 10:02:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD5086FE87
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81909C008F;
	Mon, 10 Apr 2023 10:02:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97D32C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 10:02:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 369BF60EED
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 10:02:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 369BF60EED
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aXSMR_tJxMk7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 10:02:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 792D960B2A
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 792D960B2A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 10:02:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzrlAjAc6+pCRkr9vn1MeQODGY3fyYJTQ6SMNLVekp9V40ud71lsyHIk2cbaepMbaLEN/nCwr4A7+7GrJE4siMp515A0dGbJXs1qD3m1NkWtGisx4nW49fOcMYP2anvQ3tcm0B8lOZ12iAAp3yolINf7clxw9JCBLJFls/sJ3O8ghDrv+DNWdff+0Gfo+kzuYH/LYOn0L09oW+zrgZhUlJUEuxOYSsgMQ1sCVEFV/18A7iXquhvKmEa8Oa3tgC+E68uCXTQvIytJlrObsO8zwBcDyDL/ujjqZkXyO3Y/cOsxCgEaFJBz8jebHb3kUaSY42zxhVZmVJBQ1F3xjPRaWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVHfGyEdDCkWV6kunwp9ED7QSWA0ZGZWkhFZsRJPUFY=;
 b=Tg78aOs9C3Zjfhb+QysHJUFKNQCDa/ZTKiAZA+57N9ugFT44szUsgWCsx4QRbqFwme13kebrkEqSUAOAKFxVVODt6UKODccuv3SxYX4nYPAT1XPxgumXUl2ymnOeb4whcGxZLHCqIz2mW0P4ND7pF7I8C59JUNmknjxtScMaplQAQwd5dh7mv3klEvxi14/sKsYL8CD937YTh5sAPZQxNDssBSdwm4C2bIGGSFyCPvrzkQykKBBzElo6XTSpBvhMO6RRRCnHeJcoWcKB2kZIfIO31mZJwPj7q+PKG9D7RO0DqI0Tl0Q6Yxo+UfonGVG5aRGw65Hs4TmqF1rqNUVMGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVHfGyEdDCkWV6kunwp9ED7QSWA0ZGZWkhFZsRJPUFY=;
 b=IVLCyQBlaiV2AfCV2TR9hgDOForr+r2jykaKIufiJx6WPC5yB3uxsYnkNMOyJF6jyBqwHRiCRZv+kVT0TJ8+V6CSq+Pl8MHtwIQZpGLM5sDL+EPYow6lPkeWeLS78prYa4zwIsFPALiAdDofCbPii71/KMNBYxbCaUgvDEyIqAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by PA4PR04MB7999.eurprd04.prod.outlook.com (2603:10a6:102:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Mon, 10 Apr
 2023 10:02:48 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977%5]) with mapi id 15.20.6277.038; Mon, 10 Apr 2023
 10:02:48 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v3 2/2] vdpa/snet: support the suspend vDPA callback
Date: Mon, 10 Apr 2023 13:02:37 +0300
Message-Id: <20230410100237.3499578-3-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410100237.3499578-1-alvaro.karsz@solid-run.com>
References: <20230410100237.3499578-1-alvaro.karsz@solid-run.com>
X-ClientProxiedBy: ZR0P278CA0019.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::6) To AM0PR04MB4723.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4723:EE_|PA4PR04MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d3d2f38-8715-4cfa-122e-08db39aabd1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: owlQ6NwDejoko4qrvi2XlVXTIVsPBc/HDk+vbwVwjAq4o5WftV5hqD56HNuCLSqakvtn+sGgMsug/3lNtjYJ6GVBgtp+uB5TvE9gDFKXBlb0X+T6nOP/ADrkHvSNiw4S5rVVwZqV36mhpH+uFOG1my4PHq4HGAa/BF6Q9z+oUWu8LxesjD6gZpc7aoEEQDA+e3XnNTQJDyoIgaEmF/hbBdotlhipoKIPVzBQ5tk2cnAB97NcGzBQUeZ74GbROYfYkclyXy5dk/YkgkjSF5ArxDUctaZQUFsc9Yz+ro9rT76eS9HnDhM6gVPIkIgoJLSEmVb47fCqfjt0kWrIUfOFJV2TgTKYPDoIa+GBeqCFWMbtC/5KmyNCuGxoyGrhRiCspYZ6jSSTu42YyQTweOaIXSmylf9EruxNzSXeEzOW9+NUdV4gqYB2iA+KmYcpmxX1/vjYQl7l8HAQtlcbB/ZcLvfn4cIJVfqwlXPUrRGR+dRvzBoOTrUgIRUpm1ejqpypBNvJzPaxC9zBJXU+ASJcO7WzhduhPiDkZ44DafNEEA3Cu1QoHlV5p2gTwUETy5BnUL+9Q5sS1L7bsbZpooPIuXNE9f7UCyy9Y9DpB0C1lnl3OmCr6ZDNSTQQSmYymfsu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39840400004)(366004)(346002)(396003)(376002)(136003)(451199021)(52116002)(478600001)(86362001)(83380400001)(36756003)(38350700002)(38100700002)(2616005)(6666004)(107886003)(6486002)(44832011)(2906002)(316002)(186003)(6512007)(6506007)(1076003)(26005)(8676002)(41300700001)(8936002)(66476007)(15650500001)(66556008)(5660300002)(4326008)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xohlMKYiuuVoXINKx9j11rDllqwb4H6s5IHVpLLZdDNCE9baYxgLI57kMvMi?=
 =?us-ascii?Q?xwwKH62NCoSRN+1I64vU0ObQW+GjuG99WABsnjKUo6q+mvm703CyVgH04f52?=
 =?us-ascii?Q?B938K/w0hGO/sX+PW0srRg9vts4ZmRBM8XTB4C+ExizhDOC1wZ/L+gn33jDg?=
 =?us-ascii?Q?/GrtXH1nmU+Qt8DifxWeztKNSZ4TXUuNt04UuEKqJ9aFSScSo/i0QZpossKP?=
 =?us-ascii?Q?x4bLI/tPg/OPKB3ZLROojzf6xYn/rHjoCWwYt+RANj/PmT+piAliHa1fSBox?=
 =?us-ascii?Q?vuFy/O48RGlFmq+VTe+fL0El0InGWVSd0mPx7kE34fY/GK7V7NbLws4TVsWD?=
 =?us-ascii?Q?871MOu3bRmcVM1U15DsWUXtwbwSlahdnk7s4oz+aKIkGRQahSgdgP6EZABtM?=
 =?us-ascii?Q?3nANRyYs5qQJgsQwtsKVqMBG0CBUfdIL4WI4ZDgK2+FUKwBl+YFJSv1untF6?=
 =?us-ascii?Q?R9J2lK2n+yqSR3CmZhWVyaoh6qpwzARocQQ4EVm39YHrjb9RTLES+55GkDhB?=
 =?us-ascii?Q?VHWq+uxvYGlY0WQ4k7MbwXkxvI6wKf3uyM+TcEyq6cPrdf/ihtPIPkEU13+f?=
 =?us-ascii?Q?vH40d6ZMhT086NkZVRtZ3VLSX5AMNUYh1UMtPIhvlOXSfpYoqgtVyFCZIixQ?=
 =?us-ascii?Q?BidMW1ctrGqwoHISz4M7t3DOovR/TNNCpaiWBW6URxPruDccizv1UcAs5MXC?=
 =?us-ascii?Q?EcR6RC9/5aqeWGTovuI5QcJ+yW/h2FX/ZBeia8fAmLU62KHC9DCLkrhT7STE?=
 =?us-ascii?Q?jF3Yic3c01+ZgPSztKQw8V450gY6vYLCgIRIQ+nK2bE+XOPtjSX2I92aQt9l?=
 =?us-ascii?Q?KT7Pinu5HVTOUmBuNREbC+iKlbyf/YUDwvCddAAE4dbcaVJWqxjNRqgAPCk8?=
 =?us-ascii?Q?J2CqUbTQz47PeyMg90fhK57tnSKEni+Lmda26DEtfIa6IzhFjNaMBe+TrKgY?=
 =?us-ascii?Q?e9jFJdEgb8yyxRkW9JYSuBu7Y9Ahl+r2pd3pRg/X8QIcKaqbRFa9GA/QRPp1?=
 =?us-ascii?Q?NnPUaXiN9Ol5CJIg/XC6+meyEgMIjCW8GtGSTWCfBcx6Mf1BQJ5UYKfzHp8M?=
 =?us-ascii?Q?Ksb3PVaRZ+nILoZ0zD+pu/OWtb56PSnDaxZszNfOtJvGbWBb6TmckPnwu2Yz?=
 =?us-ascii?Q?1mwRMgesyOUGfiQh1iFVgFpaN/q190dhuQfUJLeJR3lWp9FDA2zcsRR2xCSU?=
 =?us-ascii?Q?LQHgg6uVVorVxuDi3Zl4csG4KYNnSpXliM2wuMhQ1reB6S0P+D8IJ0j5nv9U?=
 =?us-ascii?Q?K6xsOhrstiNCtGVt5xXXftjgBsUO3TZ0ubQfihjWEFgJWNk6v52EKixrU832?=
 =?us-ascii?Q?0weIICvlUK1wRuSpEb84vj0uIWWSBuKRA9D4Zx98dmz7UnLXnHxlSvFwdxlg?=
 =?us-ascii?Q?IdrZS5DkjeNHyk904qZvzud+/UE6HGzOHjnqvrPJ2amMQmur6jtbH+wlWoHS?=
 =?us-ascii?Q?2ZitURyzLL5zBkcdUerXyquD4Z5TiH+jGYZd4esrIrY/nEKOFscmGOzU4DMp?=
 =?us-ascii?Q?4NCTs0nxaG0QyaN4zb1rCItRdON/LuEFSDCrrp6XfZwhSYMpha1GSzLK7zBN?=
 =?us-ascii?Q?ipH8/i371xKDoI5MHxyOGansiPFbAJbq9cO79N7ABqg6ypIx7iXgGR/jkwAg?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3d2f38-8715-4cfa-122e-08db39aabd1f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 10:02:48.5124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xcw6qiUwFw3uC1tK9zzUj+tJ3AMcAE4c7t8pimCFhVh/haD0Ppx1X73M2Rk3ygKiebeny+ZB7WmBE8xixb8affhqeImfBx2qU0dsxUdwK/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7999
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
index f7b3b2887d6..c0449671baf 100644
--- a/drivers/vdpa/solidrun/snet_ctrl.c
+++ b/drivers/vdpa/solidrun/snet_ctrl.c
@@ -15,6 +15,7 @@
 enum snet_ctrl_opcodes {
 	SNET_CTRL_OP_DESTROY = 1,
 	SNET_CTRL_OP_READ_VQ_STATE,
+	SNET_CTRL_OP_SUSPEND,
 };
 
 #define SNET_CTRL_TIMEOUT	        2000000
@@ -321,3 +322,8 @@ int snet_read_vq_state(struct snet *snet, u16 idx, struct vdpa_vq_state *state)
 	return snet_ctrl_read_from_dpu(snet, SNET_CTRL_OP_READ_VQ_STATE, idx, state,
 				       sizeof(*state));
 }
+
+int snet_suspend_dev(struct snet *snet)
+{
+	return snet_send_ctrl_msg(snet, SNET_CTRL_OP_SUSPEND, 0);
+}
diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 5647a75b457..5216b27e112 100644
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
index 46133db3063..e33528f28bd 100644
--- a/drivers/vdpa/solidrun/snet_vdpa.h
+++ b/drivers/vdpa/solidrun/snet_vdpa.h
@@ -203,5 +203,6 @@ void psnet_create_hwmon(struct pci_dev *pdev);
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
