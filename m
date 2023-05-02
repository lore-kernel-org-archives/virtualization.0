Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C11C77B7E
	for <virtualization@archiver.kernel.org>; Tue,  2 May 2023 13:11:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC2BA82285;
	Tue,  2 May 2023 13:11:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AC2BA82285
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=PxtHv3ir
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Exjd5yfeWotj; Tue,  2 May 2023 13:11:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 151698227D;
	Tue,  2 May 2023 13:11:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 151698227D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F191CC0037;
	Tue,  2 May 2023 13:11:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94922C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 May 2023 13:11:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5E86E8227E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 May 2023 13:11:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E86E8227E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Efgp97LdYNGz
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 May 2023 13:11:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35D558227D
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::608])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 35D558227D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 May 2023 13:11:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBzD0YakNguKP5JbL9zavLCdVjnZrR0T6OtJtqC3ZPA5V9Roy6LdSsPG8Hc+lyFg5GTxHK1N6D3wBFWGWd6vfpHXhzfiLjFsczumP8Qyrg3MPx1at6yfMq9oUGWAaEWxUBuegEpJ2DBZofl88Q7AFhtnBgJC46cikpRPVOE2uXm/WFoWNprfz0OXr/LYXmgWx65LD5D+fVS7cBUof0v218BYrYn1HGAuZZntmbEc8Pu+5mpG872q8ilzV+dHn52iPT3Bj2kat8Z1T4vo3mr/sE+t39lMQG3y2oOQXfPJ4mmxJ4lVb1uAccBhyzu18/9zHaOaYqEM0Y+MO5TrGODmWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCXnTS84OF5E2M6FTEapeinFLw480ffLMyb40DPjsN8=;
 b=lyq4AL7GjzFQK6mbFiqVlUsdMSYf7nGztAQ+lqqsHeMBOP2lZXkJcsqSxsYgjt9VYqog445rgGtTMQWJW3l4FQJqzte9KRRzB3BXW6f5eZDn4bMM6hJa0K5Q5Xht04/z/3Hdj9PfhGWZxuTXrdKcYY2F/BmvX0UB6IH3qmbRyo2iMUbYGBA2tMFRZxfjj7QtD+i5dYeUcPTRXl14wHgwkBAioiLdUaVbgRjfCEiceAnCu7XLdnZkIq8iiA+zmFtCPa7g6IXo8WNNal5/Q9cIhncNVK15Oj4wtrzfX6mRLLl4jEEXLgIVHSW33Zlbf4wTtcO8qc9I7Ty2j5SXNdeDaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCXnTS84OF5E2M6FTEapeinFLw480ffLMyb40DPjsN8=;
 b=PxtHv3irpMbUDWg5vPWhrFMqbevyJeN3f0ubMMYjvJuvtwf4T+8oUCtJfdgZKrZw/ULidZUJkRZN/c2WQRNcis3x0BP0WrrJR95+Z+dfsqvHSyeIWaisdqbGdS1jbKHd3BpFxCxvfEdeXfgMBmuwIZsvP6VVh8ByImUmhsXFpKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 13:10:58 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::a5ea:bc1c:6fa6:8106]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::a5ea:bc1c:6fa6:8106%5]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 13:10:58 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH] vdpa/snet: implement the resume vDPA callback
Date: Tue,  2 May 2023 16:10:48 +0300
Message-Id: <20230502131048.61134-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
X-ClientProxiedBy: ZR0P278CA0078.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::11) To AM0PR04MB4723.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4723:EE_|AM9PR04MB8793:EE_
X-MS-Office365-Filtering-Correlation-Id: f4692e02-019f-4293-994f-08db4b0eab8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vQLzMT1lkKgrYy9iuFVDqeEawxONrOoQUgTTZJ0Vjxr01gwZIvqwgx1QGg2aOdJVL4eqQ251grHxWw0hoWc18/EN4UChXqtrDakzFd1YK+A1Uo03AjrBgsZqOrBxLKQA3Sd264KdNF2DbUYZbnChwEhGndL3zKLjU21aTc7Kb95mjImxWUn8mKd64Y2/9Iwght6lv9nnIR2ouAl/k406V4v9JtcSdwL3+jQgyXDsWj8a+fQx6NDBdoKVJifH5bD9kdphUlnufMfyv5GsaztihEevlutTmSIdBpe7R9mN5IzDMn+9+mIfv2ocFnZKqxkU9xGqwslgA3l8Z5QoVTKewNF7OpQqFAnKWQkOQwzP5gEK1MshBRNSLOJKK55WWyM6wFbt2dv3XBeF2A5YpHIfYchK7hlrOJT6TZZtWG9yi22zk+DhNrdJfCF3+L8Dv9pwR0XCX+z3ySSWGq1j3BKm85mquVYIaTNiBAJfE58K1AACZo/nPOwhY0sYRuwhh5DYjRUjqTEIvgSB9kzTt8aSCETihi0J+rahzkh97au+IX1huOkjfapzLqSHowHEHNALIaHAbbPOUANjsFI+PKbyq5dVRP6hWXoTXOVjHqukNoNQremE+bIvSu5FVeNfsdLA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(39840400004)(366004)(396003)(376002)(451199021)(478600001)(52116002)(2616005)(186003)(6486002)(6666004)(4326008)(66556008)(316002)(66476007)(6506007)(107886003)(6512007)(83380400001)(66946007)(1076003)(26005)(41300700001)(5660300002)(8676002)(8936002)(44832011)(38100700002)(38350700002)(2906002)(86362001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eXdpPgsXqWmlQTfD8uflfO1B2ZFG1QQlZbmmy3TMF/NOOvmboN/zBnUJK9o7?=
 =?us-ascii?Q?W7wE5/jcizS9wRTH5UQCN7NnPtXlKclVrpbRrePAXJaFBwpMePAYlhYbmInw?=
 =?us-ascii?Q?oTFvOutXd0yvDz2U1IJQbQP44WRATo4oKkTOUh4z0njv1pVLH1ZM9r4b2XSZ?=
 =?us-ascii?Q?8ubyKL9qQhVkR0gtZM0+eSlCs5GEc+S57xuku1CrGGeU5BOqZOKIF/XfpHEw?=
 =?us-ascii?Q?3qRtlSZJjRQhEioLgGKiHIYdVG1ZiPCOjtTSSyrOCLSsz2KI0e7xdCRG3I7/?=
 =?us-ascii?Q?7TL5ZOqLObFsCWbyFtq7zQ13CXWDVLcnGMLTkxWoqGma1sLLbVbj4Wr2GTl4?=
 =?us-ascii?Q?GkhYGms1Un9wuqcK918bGkRVcMRar8sNhBcdykJlENuZcZGHGUrTS8KyDeuY?=
 =?us-ascii?Q?7qn6CcL63zRBngMJqxzykB+1AUFFBEUL+f2Hf0k2aeExbpbcz1fBIUYUrkir?=
 =?us-ascii?Q?SAC0bLrF3VfHm5/R/BeZ2NXL2Ayh7xE9Z86QSUGJWHSko3KikGZm50i0OfNi?=
 =?us-ascii?Q?zAuctgLhDitfXdCfl3D/f1K8JQvD9eLIMPhnfbVFk+L2gytJt0cSeNg/9Lj8?=
 =?us-ascii?Q?+b7XVOdU9OS7pMXIwi+q58vgHjW9hdbabJlDUNleCCpgib6C+SZuXziYUmub?=
 =?us-ascii?Q?B38LjKZvxeoNI8scrfpiLks+ZOiqWi8eeg2HRH7cJWoW5on4ffVJCC8dhpIw?=
 =?us-ascii?Q?yyh+oSb3LXEu5oNv2wAdArk1cdj4YUVtcb6JyTu91dYTbp//H/EH3+xFCrdL?=
 =?us-ascii?Q?RWZOjZAwXtsj6II1Yux4cT5bXCzVhfQ7iQrTh8BtiDRcXWxxMYJZrcEaan4R?=
 =?us-ascii?Q?Ni0bgj1IkrZZPyT9untotB8ARWoqxzuwKltIiRA5FKCo+xpTfPmLXcTshfbC?=
 =?us-ascii?Q?WtgJL1HuNnXn4yXHqIs5G3UIvUG4oBag/BH8oMV2I15vlSEoDl0DQOJ+h7c2?=
 =?us-ascii?Q?kcUETJrYyN+xslaJkh4hyGaziS4gin9B5V9Nv6YboSZH5dv7kKrQkfyisyNy?=
 =?us-ascii?Q?GSh3iK8gT+jpSEaCg/rLZtsRehsVFTIBMC7m+HxKLgecHY2DV0Gb7hAsuumK?=
 =?us-ascii?Q?911Ifr/7wcBdi/m2ziWxcvOEtArbhCMH1vYdOdakK4RzwUNdEo3lUW92Y121?=
 =?us-ascii?Q?HXxSRZkpOI9DZ1t1OyKBKLJpt1NakZU61igCcgc00JoG1p+RMqreAA7Q2XQd?=
 =?us-ascii?Q?H+j7h76RFVdHPNlgDBVrry98/KXMEuUkI4SIa+2wv10j9ktqT1qktzXFuZYg?=
 =?us-ascii?Q?xE4WMzwpMxKr0WdZO32V+qIAto7ajwYGm/SMQ8G0sO/3cZp2kJsNOFQdCBUD?=
 =?us-ascii?Q?9F591NcXdZXUs35ubE+H/QCLVRNzSkOXKpAU9MZ1UXqJng/04IM+Md40YRem?=
 =?us-ascii?Q?5K3R1VGJEruQwNkJ5WR+RQlzq5PPtjEYj1mDv1q3KXMgxrVnkrbFgiyOdCD8?=
 =?us-ascii?Q?40PxTqSHqLWRG9VW4qdesfPY9wXZara8wFbPAaKMhcIFu2h2j5mkOrW4u+NK?=
 =?us-ascii?Q?LX7snXgj89W2JSVhJcm7D4U4QTDQq4RZ6wvHTEDZ100e7V/ZsJKIrWlyrZZW?=
 =?us-ascii?Q?1zQVT1IYeqB+qXQBwN8j0SkLp3WXBxs7wNoN9FK981+I+0rEaD71jEZfGaxV?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4692e02-019f-4293-994f-08db4b0eab8d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:10:58.5166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnnndYvsGAyKWEdRvGu2arOqVAmkK0WnfLkBuLm88PWkkgL9nAhygQvPJqoLTTG1Mtl/i2EguELxaIt58hHOBiVRcKx2xBefeTgsJiwHi68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8793
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

The callback sends a resume command to the DPU through
the control mechanism.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
 drivers/vdpa/solidrun/snet_ctrl.c |  6 ++++++
 drivers/vdpa/solidrun/snet_main.c | 15 +++++++++++++++
 drivers/vdpa/solidrun/snet_vdpa.h |  1 +
 3 files changed, 22 insertions(+)

diff --git a/drivers/vdpa/solidrun/snet_ctrl.c b/drivers/vdpa/solidrun/snet_ctrl.c
index 3858738643b..3cef2571d15 100644
--- a/drivers/vdpa/solidrun/snet_ctrl.c
+++ b/drivers/vdpa/solidrun/snet_ctrl.c
@@ -16,6 +16,7 @@ enum snet_ctrl_opcodes {
 	SNET_CTRL_OP_DESTROY = 1,
 	SNET_CTRL_OP_READ_VQ_STATE,
 	SNET_CTRL_OP_SUSPEND,
+	SNET_CTRL_OP_RESUME,
 };
 
 #define SNET_CTRL_TIMEOUT	        2000000
@@ -328,3 +329,8 @@ int snet_suspend_dev(struct snet *snet)
 {
 	return snet_send_ctrl_msg(snet, SNET_CTRL_OP_SUSPEND, 0);
 }
+
+int snet_resume_dev(struct snet *snet)
+{
+	return snet_send_ctrl_msg(snet, SNET_CTRL_OP_RESUME, 0);
+}
diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index cdcd84ce4f5..99428a04068 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -509,6 +509,20 @@ static int snet_suspend(struct vdpa_device *vdev)
 	return ret;
 }
 
+static int snet_resume(struct vdpa_device *vdev)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+	int ret;
+
+	ret = snet_resume_dev(snet);
+	if (ret)
+		SNET_ERR(snet->pdev, "SNET[%u] resume failed, err: %d\n", snet->sid, ret);
+	else
+		SNET_DBG(snet->pdev, "Resume SNET[%u] device\n", snet->sid);
+
+	return ret;
+}
+
 static const struct vdpa_config_ops snet_config_ops = {
 	.set_vq_address         = snet_set_vq_address,
 	.set_vq_num             = snet_set_vq_num,
@@ -536,6 +550,7 @@ static const struct vdpa_config_ops snet_config_ops = {
 	.get_config             = snet_get_config,
 	.set_config             = snet_set_config,
 	.suspend		= snet_suspend,
+	.resume			= snet_resume,
 };
 
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
diff --git a/drivers/vdpa/solidrun/snet_vdpa.h b/drivers/vdpa/solidrun/snet_vdpa.h
index 3c78d4e7d48..36ac285835e 100644
--- a/drivers/vdpa/solidrun/snet_vdpa.h
+++ b/drivers/vdpa/solidrun/snet_vdpa.h
@@ -204,5 +204,6 @@ void snet_ctrl_clear(struct snet *snet);
 int snet_destroy_dev(struct snet *snet);
 int snet_read_vq_state(struct snet *snet, u16 idx, struct vdpa_vq_state *state);
 int snet_suspend_dev(struct snet *snet);
+int snet_resume_dev(struct snet *snet);
 
 #endif //_SNET_VDPA_H_
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
