Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85365C77B61
	for <virtualization@archiver.kernel.org>; Thu, 13 Apr 2023 07:33:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0578460EE0;
	Thu, 13 Apr 2023 07:33:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0578460EE0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=Y9a74rXI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iZ4hsH7V_zQk; Thu, 13 Apr 2023 07:33:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6F20C60F2A;
	Thu, 13 Apr 2023 07:33:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6F20C60F2A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59936C0036;
	Thu, 13 Apr 2023 07:33:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F76EC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 07:33:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 49FFE4101F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 07:33:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 49FFE4101F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=Y9a74rXI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8U9K6DTgXuo3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 07:33:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 632EC40CAA
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::60d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 632EC40CAA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 07:33:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVFSS3JOrouafn2VXb6Cq9DFt5weQ/TkEKz0efZZPSZjp7uc1mXJs+CdE0jfiT1QlxONTXhT+gnDO1SQSJI6X+4nD6Bm7HqHjiXYtlHfBjhBZJ8JlOJsNCakv+jVDzJBimLL0PL+Z8TY4RBpa9mGJoeXv0opnZCUiW1lydTVQLxVjBR/fN4hgG1Q4ZamdIgt3tm5N/3QlNcRcDDCnZz0yV0k9THa0O8C+ZpZ5Z6NMsf2J/fWDlwLQt8l5+6qdSte+V2hEux4BtytK+kLFRzDecOTMnEsW9XLnLYWg3oscVSYnJ4072pocwvRkiZnJGp4PKvC26anCeTThZvxd7RVLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q55aBTmZZD86f4rxtt6Qqx39n8BO9jBLEhyiqgZ3wKQ=;
 b=UJpW2fbKQi+HidQ0Ib5kiyVtR899yaRQ7czcAX+8lGK/I2S70tieTgZnPu7uKTk1vDhpJxp0FnKvSA5V3PU35SpqBQy9y03Yldckl9NA0vDacOm8JSeuE9cFxXI55I2YmqNOUcSQyRjVFrJYiZX+NiPnh/EwfEm43RbLdgtWZ4PTeKD1aETQdQUNBdz2ygwejJPwwhhD7sKCRpv+nHq2tDMb+xepeaKdIp+eH+QRd/ggyR6n4rDW6mVdrcVxgUrz1uQZmcIef+WPRl++XTNHD/wokSVAqNda6exUkNZRL+cQ9YB0YGukqdmJ25bxCjaWXLNMIIiJDIN0N0cUD1wuBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q55aBTmZZD86f4rxtt6Qqx39n8BO9jBLEhyiqgZ3wKQ=;
 b=Y9a74rXIPgFZo4dzLrvQ4Ggo+VmFoG/D0wTp4M0sY4eUqygw0xSKJPflJ028o8jRFXoIMlxBocqcdQS78TdaQX+b+A2QFshHbwHifOFvWZpQpf4nNi/2farkRnlMPsS0L31XphU2IVV0ZrzYnQqrjQQG+RagwgCxyuLq6UnyVDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by PAXPR04MB9326.eurprd04.prod.outlook.com (2603:10a6:102:2b8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Thu, 13 Apr
 2023 07:33:48 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977%5]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 07:33:48 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v4 2/2] vdpa/snet: support the suspend vDPA callback
Date: Thu, 13 Apr 2023 10:33:37 +0300
Message-Id: <20230413073337.31367-3-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413073337.31367-1-alvaro.karsz@solid-run.com>
References: <20230413073337.31367-1-alvaro.karsz@solid-run.com>
X-ClientProxiedBy: ZR0P278CA0122.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::19) To AM0PR04MB4723.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4723:EE_|PAXPR04MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 097f53ff-3a9d-4de8-e7e7-08db3bf16bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yH7/FVfAwOl5RkZ83+WiWL1KzrwZweEGNOaTcltnDO/KOkT7mAKEO0ETrp8p0aa0DLYF+8PiDtSdPz7IwqFqTb5I9tqmDhcLjWtN8rSRttK48XR3+qVctuTA9nTdDITfrOykMm1+Z8XcW0bm2etqJBl++qvvwSHFul9hPckn09xxXc4g1zmJ07IY+Nc9TmnP8WGWcXToi82O7P68fni4xJvXPlMSoPn+Wt96IHGhI3NSsK+5Md1yoB4XX9IrH2orJFFa/JVqa2W7EajEAWpufsN1pAqWsrGof/Fd3Io9AnqzVURCTnCciyf25j+jkgcav642IiM/vD5X8uhMcsrbv+/Ri+I3OTaXIiPpJ6qcK7I6XDc0nHkG4ohtokpg1pLhzvc2VnaJzWudHLm2fSFYb1Hs4BygzniWlW6OX2WHe7ESSzuztO/aByUowlUoMdMxYxKtIbdlLW7qPQvsSrFxvQqHsu7a1d+pVywDHescVtVQz8R9Fi7ELFzUxJqViYO1i/lGINq7pRXTp03HSnCwp2SfKreikhcjkFK/9T82W816fQ17PPCIH9oJU9FQ9mQ5Isv3bzobJhoETQksFIVDRZWYjT3LBLK3rMXGLureId8+WfBn0WKQNnxBi8Ga9dS1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(366004)(136003)(346002)(39840400004)(451199021)(6666004)(478600001)(52116002)(83380400001)(36756003)(38100700002)(38350700002)(2616005)(86362001)(2906002)(6486002)(44832011)(316002)(26005)(5660300002)(1076003)(6506007)(186003)(6512007)(8676002)(66476007)(41300700001)(4326008)(107886003)(8936002)(15650500001)(66556008)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A37YhgFOorAbcqxIDGA3fQsiF3nMDpCrVbvLVpDvxKToFoq9tY7NS6VajKvI?=
 =?us-ascii?Q?6fZ+BRboHoVD0VjwHHKP9LA713iq5vvGmowpQcpKUF9M2jsrvhTK1EuoMXOI?=
 =?us-ascii?Q?IA2OmMN4N6+mZd+OvjXbk7wkQ5lvor2/kAnEyyIb5p6OZ0rU1tU77PSFc2Kk?=
 =?us-ascii?Q?CJn+H76N+1pxG040ph7IZA/p5xYZudt6u++tm1++vNPN0d91skylci2dDc+b?=
 =?us-ascii?Q?wrOZD/SFN7fXhr/jbLFGxMdTeWBr3+Bseaiwq4Li0fPj2Tt/K51eUj54Y3cE?=
 =?us-ascii?Q?G3GFd/5CV14VVmjSuZdCJSIA0MRcPHuG+V7PzUGXl/HHQqnZQ3XyzYQ2Qq/c?=
 =?us-ascii?Q?U2yQac4as4XDxqspYsCqLUQpHOCWM8quCyZaxXh1mk8b7ZZtOmgbW3Hon1Qa?=
 =?us-ascii?Q?5cPwyUx8iCQmfE0dTFfu58pMr7wnVwnJhRnhPXeac48arzEi+3Ax+qt4VOfD?=
 =?us-ascii?Q?km3tTZNERNSjYloTPxgQUDwUTiZOJtEbSAJQhApS74QfHZ5IRxLRo1y+Iyed?=
 =?us-ascii?Q?m438Jo6Woe89MezpjWAjfDdUhwwKX/tOz2X0oWVXG2+HhwWC2qrVA4rvwidN?=
 =?us-ascii?Q?Dl7jLkYGONhzg7p5BLJTVUdLABNUNk6e8vs8xnExbwtOI5X0ycUJk3Pf/pmg?=
 =?us-ascii?Q?vu0pSEe6d45mVT5OJAV6tdrJzHA56RUNEGactoEekfx3FZfl+YnMxxCoOBK+?=
 =?us-ascii?Q?fX11XNrNkzEs9pWDK9SWu/6fOsB/rFqWQL2wKhaF/N+LS0MScXSB2xueEbnm?=
 =?us-ascii?Q?nMAk3nuyiS14R8w1CfsF/1Yum1QtXJyAyAOJ0RQRAryndx3VUm3HirLbEXBo?=
 =?us-ascii?Q?aMthdexbEKKwKVJuPmFAFCxsXQlXGl8t1in8MuGYOrl9wbdWnUeqYITS6o4j?=
 =?us-ascii?Q?GRihqAY0eq/e9q3hh4hTqg0RzoSRj29katY8gEDmxRzf9D1RJLPJx+BhAVG3?=
 =?us-ascii?Q?Cz/uc+5N9WJypx1gZXR5P5gjFoQBH8TeKarWOiLyMANRWSl6EZL+IKnZSJd2?=
 =?us-ascii?Q?tda1GB05EcnDQWqBv91yPtaoQ4o6lgPiaG/zKSHGQhd5E6qDe7optMKm796z?=
 =?us-ascii?Q?HQKj0kBPlbriFFJInb0TK6VIerSlsRMYfllUT2RA5R4tYiIsGZVOnqvvVaQH?=
 =?us-ascii?Q?jWbo1KaIWBmuFeXNnc+3uqaGxN1D9YpfKbDMHAeZV+BZIhiY9bUgDcLxTzRP?=
 =?us-ascii?Q?5D+fygkKQw7oI/v55XoXw1F02RsLgTcvexpK5HDTuEj/+ovbKTaMVDTx40pC?=
 =?us-ascii?Q?lxDZItHl1U5omUJaxEyQf6IAu+HKNVLsgITb6U/KaOOfSlFtu2eDlWnWYHzt?=
 =?us-ascii?Q?WsIWBOytzl1TM29WMk0/kaRpk77rEFRxwAH3yNG0XXYPIElHJPnj7/E9Sb43?=
 =?us-ascii?Q?ihyDAjlbffLyuCybPNmQ9oMRjj0SZb2NJl+fNCF9pJWBhy+hdzQAGXxEkq24?=
 =?us-ascii?Q?qsP5hAjjqQK1cTjDkfstUIEwI6SvrYu6/89r1rKUWry4L4avDUXVKcbuQuz0?=
 =?us-ascii?Q?PsOZ7kbTFvMD8DwIz+RV1hW2A/KgSE9KLnBNtBaGbJEieThB159dxOOrMa/D?=
 =?us-ascii?Q?wK7DqR8fgNDxSU9fQvFXYaa/Pt9JRJZ8EteDiJ+EAFnoA7VyGI27eYw5cQDQ?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097f53ff-3a9d-4de8-e7e7-08db3bf16bee
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 07:33:48.8934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBekIBIWVoaJlPCdi8BGPAaCYZ/6idJbmP6lZT/Ge4i5kwUhS5iHQNHPQr9UhLTupIqfT9s/4aE3gRYHaFcKT12joqz773a9ff8RB9Lc1xY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9326
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
index 10cde502f1a..3858738643b 100644
--- a/drivers/vdpa/solidrun/snet_ctrl.c
+++ b/drivers/vdpa/solidrun/snet_ctrl.c
@@ -15,6 +15,7 @@
 enum snet_ctrl_opcodes {
 	SNET_CTRL_OP_DESTROY = 1,
 	SNET_CTRL_OP_READ_VQ_STATE,
+	SNET_CTRL_OP_SUSPEND,
 };
 
 #define SNET_CTRL_TIMEOUT	        2000000
@@ -322,3 +323,8 @@ int snet_read_vq_state(struct snet *snet, u16 idx, struct vdpa_vq_state *state)
 	return snet_ctrl_read_from_dpu(snet, SNET_CTRL_OP_READ_VQ_STATE, idx, state,
 				       sizeof(*state));
 }
+
+int snet_suspend_dev(struct snet *snet)
+{
+	return snet_send_ctrl_msg(snet, SNET_CTRL_OP_SUSPEND, 0);
+}
diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 86769f436b4..7359599e09e 100644
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
index 09ff676e7a2..3c78d4e7d48 100644
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
