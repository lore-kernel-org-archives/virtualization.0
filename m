Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2121.outbound.protection.outlook.com [40.107.255.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1688622091
	for <virtualization@lists.linux.dev>; Mon, 18 Mar 2024 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710766828; cv=fail; b=t2c2k+WBakrOyj7HXDBeFaoTEgg7yaAHD8iw4QhlNdX8MW3V9W8w5lLTPdxFdARK/tZ0LaE0N5hRBgXlrYj3vRIeA5C6hQPdPIB2Q6aiPLBNO95wqJysGOhoflQAlPmDCEjG0cuuxjEXd0WtHgZ6Z84DyT7FsE482fGayqGQbi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710766828; c=relaxed/simple;
	bh=92VIPNz5Up+4JFO6Yy5SyYhQNIxUCWiSef558RYNSFc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ud7zohygLc0brQYOcfeR8E5usVAqvx3S1k83ctrkDtbRJ/+S/nYdRJ3l9KkrIFTWWBQxOGKfdsdUnRi/rty+nlUxshJls1aqPPXwCZauzEJWcsJuUNS/Kck2Prqdp7HqTM2XnldJf3eNoxEIcnpU1dNBtrSg8ysIwulO1yDoe1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=HV1EBSN8; arc=fail smtp.client-ip=40.107.255.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="HV1EBSN8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mF/lbkEHReEcZK60loO4b74m1nWAIzmeTB9rZh3PFdxnK7InwghN/48cSiDXhKUDnEkYrNS6FOBlZelIL3jDq3evAvdhtDn6Y/HZbGDISCkvFwhz1bqE4kOJ7RbN63/E+q+gqZCYjGUJneundjrKtOH3+vGVOtJS0XyktOJHjqAN5Vb+8w+xxAP6dxcVUgGtw4AvYDcyVh7C1S/TmBURPH6MUFvVPyF33KKDKhzHrGc47wC9IrB6SlERuMAQXt082aKgxZ478EM7BhoBS1zJbF1e8BDNq+e1Fh0MjX+SevYflo/qUoew+tzJQ3JfV2xmkyjPcu0GDvN+3JEolO5mdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKxL197qzDQHaGkzfDSk4raW+O5ZbRcluPY/uZ7VpaY=;
 b=IzXjMz7xu7Gqsotl4LCQQp6lbCO/bqgIrJdF5uecc9GkkCRW+AQCCZLJlfDzkSp3XiRQHnfMflP2FNieDYTZBA5dUT8MzcwrsmN4HCrzVff05NPIKXKPZnW3JzY2HFOxGmJSdoE30EVpOMZku9RwVHEWYlu8iCNWcWqEqxGPsAonKzOlsVjRkDPwqLfYEyVFjfsGM4QpUpz2w0Khu7lBlgt+eZEX5wOoeEIwg4YM+Zk1Ixj4qy3PpIpNaFklnhlWMibsNEL16+WG3K2E5HecyRSWpLRp8hKG8WEa+3FJsB6TTxV1FI1Shw45gUu1XnB5XPekQ3JlH7W7CNR/ObqNQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKxL197qzDQHaGkzfDSk4raW+O5ZbRcluPY/uZ7VpaY=;
 b=HV1EBSN8ZE/QEhu4oUmIe0N3WqiSJzdesRvfuukWJGymQIt+1QcPOROPaU7hktkoSQ0W0IJ9V9DnZVJ+1JmqSKlKYio6CvKRb4UhRSSuBghuuQv9mD0P2mI5EYHqA5nZ6v4J8qOD/GBlbp54daqE6ecp60yS1VOfl1xkk+Sa+oIT5lN8nIRkEZ26iVeAlAknR4mxMVLR6sNKdTBAzNcCr/fFydTexGUIstQ/07GhCBS1Blpx2kCK8o+2BnPI4wR4qCvzW9IsqxxM+FSM3Lw0yXHvVnZ0gi1Ikhym5HTcD78TSHBOmmsDkSp1DVwueECnsckouSw0Qt7L70Vll7om/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11)
 by TYZPR06MB7489.apcprd06.prod.outlook.com (2603:1096:405:bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 13:00:22 +0000
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::ce49:84ce:23db:8b8]) by SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::ce49:84ce:23db:8b8%6]) with mapi id 15.20.7386.023; Mon, 18 Mar 2024
 13:00:22 +0000
From: "gavin.liu" <gavin.liu@jaguarmicro.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	angus.chen@jaguarmicro.com,
	yuxue.liu@jaguarmicro.com
Subject: [PATCH v2] vp_vdpa: fix the method of calculating vectors
Date: Mon, 18 Mar 2024 21:00:08 +0800
Message-Id: <20240318130008.1928-1-gavin.liu@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To SEYPR06MB6756.apcprd06.prod.outlook.com
 (2603:1096:101:165::11)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6756:EE_|TYZPR06MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b22b4d8-bad4-49a9-f847-08dc474b5e90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X9PUYeR53yLkAZAAG1JuYIrtN1CU8bYHyvMe7lHJlem6dLWMgoCYiskAOSM6e7RGPwAYVtcF2XZ7Dn8hSREBAz0Detqyj3tKRN4AIPegCD36I1+/KlY0vwLIorqN8JuGHHrQN1pqKgGqqfP76y9v3D+zfS+lcqAnA76djJCHjUemUVd+iFYUtzM2Cx44KSbMT/YRTGS6KHzDoP136hwfua7NbFBIFMQ7lUt8D4pYulzr/QgC06/6hDYTvvyJfIhjWLnDnFAQRqv5q9+Bz+hOzM79Jls9uHkO244YgTZrgCa4VM7JDFPX5v94P6ibaEsDPCZrtsK3pN7x7/fY0cGwGqqpmZOnbJ5lrDlQ7UzetvdkH3s/uyeS+rDuyR+7jR0iy6vOmfdFXtZMooAqUMVKPgf6VcZWpBaJGiMahkQgiMPiekkCvNjK/aRUyZuATalGj6tzTEL3wUGUhNhwtJZ9TzVLqsQZdVkWihjvnpXeTgcuoqyNbs40aBBWczEtCEDlxpYPXuaWNp3wPgW/J+B7wYMrCJY+W29X8KH7KOJKzgd1McCssKlNXFgq3ism+9ZxOxVUZfv4GIlwpFWUxp7BUQMA6LeYiprp3BfEB63bGr8dbh/ZvCSCLIP3GwsnWXS9qK4G6E15qNn7gb/1m7qvBfZGwu9Fp4JYtUvhFbGvE80=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6756.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E05A0vpPZRs2DfdCXSK4XmhfeSp1IxtlU9xIzME5HPbfrN2dnljem+e9JyiC?=
 =?us-ascii?Q?Z/HmPyreGKG1tLbtzW5tnRW156S4KmJh+lm0oybfNHJ3G8NtH+J3BXhlHGLU?=
 =?us-ascii?Q?ytEnF4W+1MgW40kpzwosSlFITgE5tV+OtubBlg0guV4CFcohUJW+SUZU2IsE?=
 =?us-ascii?Q?mzAK0FcxU/liBnMbaSnDgetNQiBjUMBKIxUmxXWqWaUlU1C1k+ZGbwNyouaF?=
 =?us-ascii?Q?M+XcQLALIDD8Yihx/t6bYu9H6tJiTFpVmAnBVrcViWkzgPZoKeCtqGhskgER?=
 =?us-ascii?Q?jC5uTmceDv/0iKRBnanK/cMq149e5g622Z3YMHqGVA7WWgHrgQrx9hJrUZEq?=
 =?us-ascii?Q?oKStNCHI1kAMU+J5MPbSesl29oMKs687llcXX0H+306Os5Mbsumrj182hAn2?=
 =?us-ascii?Q?qStxVDhGshUtWh8CIYFTleNzPQtjHCW/SKPxd0wv+GB4ZntU/cOyxhiTHdqj?=
 =?us-ascii?Q?iYkvkILhVJ5lOeRrP8p3W7BqIZItX2lrAGgS2vDYnbgSkk+w9IxXWoHYzSBz?=
 =?us-ascii?Q?q1kHfovyTSGEwGOO7EldBLBLnhUagthCbKb7MIN7Ss3/Izuv5V0Y6JeuiFbS?=
 =?us-ascii?Q?vWFrRv8xXOXtMMC8VjqsV7vDBgBJtGxvJs09e8a9L4XTppsamV041UcX1NQt?=
 =?us-ascii?Q?v8dHVXL0LJvesxXBKk+UxnR6zUKHP3pSLyFnBdm25C2aM+S1op/lrmDH2LFr?=
 =?us-ascii?Q?TrD1y/KrK+3vOGgx0/zlmCaJOtE+jRVl0e3SyH6zsRBEUIph9X6vEArTtTm3?=
 =?us-ascii?Q?AibfLIyeqY2EX9CeZ9f0MnADL+jPzpystxkRTQJP1Jx+Z2P+N+vV4QwCrX5l?=
 =?us-ascii?Q?fkYLkxinYfpZ9jZupLpmbH+79hAcuyRBiBsev76vVv8eCCTpatSZeLnm6k8b?=
 =?us-ascii?Q?91r5IwOe7/7uVZD04g7LL7qay8LKYlJHnvz3ge/neqepjvi+u5c4hJ6Fbn7m?=
 =?us-ascii?Q?6w1mQn5NBrQI/yQRW9QD9rnSV8MZrHwJ7nACnQMDruempd3/ayovQyWDVTJq?=
 =?us-ascii?Q?wFq7VpFSv/YoEB/ll3NnEoIy0J3dtb6rrRkmJenLg0NmuZEDjDJodgiEyIl1?=
 =?us-ascii?Q?b3uF6aabBzFI+C6xXu8N4Tk5DRj+B51+BKXHQH+++VKJoUFPh7V6F7T2DEb9?=
 =?us-ascii?Q?5LKjb8oUpY/LT/Bsjrt6eqZhKU5loof8MScnCAIWVTylr2GaQc6xF13zH4Xz?=
 =?us-ascii?Q?cwPc7UfcFvXDG1piSGy7bPqtAHTQ70pN6hBWLF0l6LYK+otQQV2DM1TX2+AF?=
 =?us-ascii?Q?ICqfwR4iiwPEPXpmDEqvQPWIR1u4885qs712KAAZbZQqgQof/qQvStiTL4EM?=
 =?us-ascii?Q?ANp063aoL6S4JR5sPyAvWaILpetbB53FJfXWIxOFqZgG1dywbehi8LMzGWnD?=
 =?us-ascii?Q?zxtfBFQdlObmJMhGe86w+fNRV83W4nxAp7th1kaO01mT/HYjaxCidW3ANPCw?=
 =?us-ascii?Q?tGL4uMfUXpigAiXr2/yDYyNyKqqf6USr4zBzrowaYpwiPuina9U/dTi8KW7H?=
 =?us-ascii?Q?8CSuAC0d9Hme901CrseDp9CEfgveeqnz5yT87RnlJHwHtLHXQn+VIrLdnt83?=
 =?us-ascii?Q?49OtlrfNjggTxQP43bBN9JrkpVKepbszcMQSH8ORCBdPNMJ+ArKd2TiAO/hU?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b22b4d8-bad4-49a9-f847-08dc474b5e90
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6756.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 13:00:21.9002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /waAjeFyd1TmMeL4eW+zosO+m02ICEX2VkByG0R6FuiFaLXdBNEBlJPuI2tSnIwvWpJBxKFOyxh26zKvASNZaa4qeYrhsmKGAH2HT3NRsP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7489

From: Yuxue Liu <yuxue.liu@jaguarmicro.com>

When there is a ctlq and it doesn't require interrupt
callbacks,the original method of calculating vectors
wastes hardware MSI or MSI-X resources as well as system
IRQ resources. Referencing the per_vq_vectors mode in the
vp_find_vqs_msix function, calculate the required number
of vectors based on whether the callback is set.

Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
---

V1 -> V2: fix when allocating IRQs, scan all queues.
V1: https://lore.kernel.org/all/20240318030121.1873-1-gavin.liu@jaguarmicro.com/
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 281287fae89f..87329d4358ce 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -160,8 +160,15 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
 	struct pci_dev *pdev = mdev->pci_dev;
 	int i, ret, irq;
 	int queues = vp_vdpa->queues;
-	int vectors = queues + 1;
+	int allocated_vectors, vectors = 0;
+	u16 msix_vec;
 
+	for (i = 0; i < queues; i++) {
+		if (vp_vdpa->vring[i].cb.callback != NULL)
+			vectors++;
+	}
+	/*By default, config interrupts request a single vector*/
+	vectors = vectors + 1;
 	ret = pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSIX);
 	if (ret != vectors) {
 		dev_err(&pdev->dev,
@@ -169,13 +176,17 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
 			vectors, ret);
 		return ret;
 	}
-
 	vp_vdpa->vectors = vectors;
 
 	for (i = 0; i < queues; i++) {
+		if (vp_vdpa->vring[i].cb.callback == NULL)
+			continue;
+		else
+			msix_vec = allocated_vectors++;
+
 		snprintf(vp_vdpa->vring[i].msix_name, VP_VDPA_NAME_SIZE,
 			"vp-vdpa[%s]-%d\n", pci_name(pdev), i);
-		irq = pci_irq_vector(pdev, i);
+		irq = pci_irq_vector(pdev, msix_vec);
 		ret = devm_request_irq(&pdev->dev, irq,
 				       vp_vdpa_vq_handler,
 				       0, vp_vdpa->vring[i].msix_name,
@@ -185,13 +196,14 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
 				"vp_vdpa: fail to request irq for vq %d\n", i);
 			goto err;
 		}
-		vp_modern_queue_vector(mdev, i, i);
+		vp_modern_queue_vector(mdev, i, msix_vec);
 		vp_vdpa->vring[i].irq = irq;
 	}
 
+	msix_vec = allocated_vectors;
 	snprintf(vp_vdpa->msix_name, VP_VDPA_NAME_SIZE, "vp-vdpa[%s]-config\n",
 		 pci_name(pdev));
-	irq = pci_irq_vector(pdev, queues);
+	irq = pci_irq_vector(pdev, msix_vec);
 	ret = devm_request_irq(&pdev->dev, irq,	vp_vdpa_config_handler, 0,
 			       vp_vdpa->msix_name, vp_vdpa);
 	if (ret) {
@@ -199,7 +211,7 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
 			"vp_vdpa: fail to request irq for vq %d\n", i);
 			goto err;
 	}
-	vp_modern_config_vector(mdev, queues);
+	vp_modern_config_vector(mdev, msix_vec);
 	vp_vdpa->config_irq = irq;
 
 	return 0;
-- 
2.43.0

