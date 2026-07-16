Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012009.outbound.protection.outlook.com [40.107.75.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AFA400982
	for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784211259; cv=fail; b=otulcjs5ca+QMWGZyCvVXb6afkhTjed0PK/ubnVfBwuhGJ0uORQUs5CwcSFtdmBX4FwMd7P+wKau6QwHxBfFZw7peEC0Ix7Bq2SWpOq/UnbAlmAlDUFfD/nmI0cqaCowMd0p4zmuCO7PXrpOyyz+10KB33Xz1Y7kJONR9TjrQhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784211259; c=relaxed/simple;
	bh=NBcX5kkPZ0DVqHuBZhKKHoEJh7dt1fFkctFhXcqVc7U=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VC7II/2rzcsYSa4W3B08G+M2AvxGnfLNn6Gv/qfY032l/ckLbG4jeE4LbBnh4jDA28Rxr+teoajUhI3UAV5i8L6714xBAOo2Y+JMGr4Eb3mD/n+GXm5nOJtVmLCCfDNRXu8U7KPWQgDcSL1yRMYO5euSz+WTSAPgsZh5HRbB5t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=mWj35iuE; arc=fail smtp.client-ip=40.107.75.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="mWj35iuE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YH+AkuKhsQwVV76FeV3CYnk95VwX5+S9jSSDToMi2n0nRZ1shnPMbpf+UQNyJ19GRChG17plPzYPP7n4dO2ASSg42rK9ZVBvAkhCPXJW1NUFH78/iFPtc+OGYXClLU7z1uWy8JGYRYSxucxZ87SAZe7lXoFQHhcY2TuCrJBZHEM+BeZN4ZdDuEBihNinkKIsTTxvFYh1jVQrIw8QBKL10hHv0HpVbcnpLT1Qpb1JkC2DaKVwuuFcs7ZqQOrMKA6rNw71AE5nNjI+eVZP+1xKNrf70B8ijFx7vNlh2EtrQZyvnbp1CpACgnwziHHxqCNxCjq1Mrz0go/JDgCiFj6jXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+s1OeA4WJ3HOA7C0bLvoJEkZuBwzr0kRcrf4RRwfTz0=;
 b=v+m8Tv8GX+QIbd+1rgLX8BmNvkHwPdJabY5p9mrtb47LJqGUvmenG2POdAzjK0GgZqDS6tXQ7RccaxAirz9C4H0G4Zkaln/9WDQDXWSJqpN3VD2ddMf4cGVEGvSTWg1BunQH6+sWiQmZA2oxtGTJAVtxHCzmZA7yjY4hCgzI6KdWEjtI0dSTAf8XXg+rbMgQLt4rRKfyzsgxwYzMEZludTA6Cb3is8IiMYEM/nVdRsrSU98kIG0saRfQGWZf+TPup7mpjZtT+UUYxC3PMS29oKeHOeKqKyUx+FF5ww4RVby82twJgSVGb8JzVKAb1oVBKeF10EISALEtgNPEGhbzvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+s1OeA4WJ3HOA7C0bLvoJEkZuBwzr0kRcrf4RRwfTz0=;
 b=mWj35iuEahmGReyYeUHzzzASdpvIaVP2f+yaKbxgsplOdwl7Rz3kxAlqHpWEwJDsOB1a1pYZrqHGkPJwsp7qTKsPvwcpoHp8s0bzjpJbgdqb5kil9QYUDj9GYnBGqOX2d/PKDqAUrL3JYxQg6rbIAP7zEdJVVsIYmt2J5me6vQ/r1a7BiZqz1wOWn+LoJoUK5PEjuXS0ZB1iY/NCm23fRergHTZo29uXtktk4QXjuwoeOIk4hEw9t9PQwQ3LCIc18SfgXCaXmrMc2YrN+0tUORiGnu74XPuNhTo0ykXktWCFqPcftd3lhI4bQ4bQFQhFrxsWLM84pqPYlZAoSu/THw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by PS1PPF7E1D0309D.apcprd06.prod.outlook.com (2603:1096:308::258) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 14:14:13 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 14:14:12 +0000
From: Pan Chuang <panchuang@vivo.com>
To: schalla@marvell.com (reviewer:MARVELL OCTEON ENDPOINT VIRTIO DATA PATH ACCELE...,commit_signer:2/8=25%,authored:2/8=25%,added_lines:97/119=82%,added_lines:17/119=14%,removed_lines:16/25=64%,removed_lines:3/25=12%),
	vattunuru@marvell.com (reviewer:MARVELL OCTEON ENDPOINT VIRTIO DATA PATH ACCELE...,commit_signer:2/8=25%,authored:2/8=25%,added_lines:97/119=82%,added_lines:17/119=14%,removed_lines:16/25=64%,removed_lines:3/25=12%),
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Pan Chuang <panchuang@vivo.com>,
	Miaoqian Lin <linmq006@gmail.com>,
	Kees Cook <kees@kernel.org>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] vdpa: Remove redundant dev_err()
Date: Thu, 16 Jul 2026 22:13:43 +0800
Message-Id: <20260716141349.158824-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0031.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::9)
 To SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|PS1PPF7E1D0309D:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b110d8-d8e1-41f5-6051-08dee344829f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|23010399003|1800799024|38350700014|921020|6133799003|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mTzdIEQsO0RApydv6KShwJFytC1ldUuA3+8F3Yu1MGycFC5weBO2UK8dWqSawTQDdCoGzecqM4GnJXlnL+//AEZy5Co7YcopWIbq+KUqOYLPX2pwoOSScDwCSaCTL0w7WYdSKvWLky3Yxpu3moAzI8KqYZJ1RxDjGk7gWh0CXUD+SZGrBC2uq+/mmy6dIKdKZvz2qJrcNxGOas1JI9z1RiHV9ajqahBaDJnSpTOp+6BSoWwLq+r7UPn4uQSqolznJp4scJp9S5fqmZJ8FLR10FVdbUrv85xoLQqKlG9FAjhSzHB4lfhkzbJ6hzLzthMwNbv5xeIvOA9EHWNiYdcLkxyPtdfP1Y0/yPGvPLTwstO6HCIZKSFPh4DAKy2u80TOR2ogpJA7RuYd5ILvfpA9fj/NTzCE6uwwYyDwbkKFPBrqCVfdQ7KUxb8upaMdRzoV09Gon6FhhQLAcXfITarDkSIBCvVRRL9aAU6LRrhmVYRjpEb4Dc0LmNTc9MKmGrj6MG2YVleOEKno/phYxcdLcuLdVtRngxMGIokOkNZZuaBY7MNV2C4tJOJTr5EwbB0//esgm/DnAgGuzc//r1rbdAYuCB5TshZhIOhi72Gw1M6N6tkwVBWiWCw+Rjl2FzGtLrP3++3AO67MaKktCgu/gJH/gajqGVkTT0108GoIe3tPvfJiWh0DC6qZy6wf0a7G2zC/PceNVVACFnmUaQzXX3YFFiktWwdN7GUtxA1njDPqsY4cD1fPApTi/DPsMlrl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(23010399003)(1800799024)(38350700014)(921020)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yt3iEx+wQM2q+1CKC+zWMTY0wKyPagBZdme3Nt3aOfYRNfYzYj8pdQoKoHXb?=
 =?us-ascii?Q?qo97xYHyfUFQDSC1mfP4OMNd47v2Mq+qEK5X31wLBvVThkyJ+keGUhnxxpuK?=
 =?us-ascii?Q?1RYSjMwKkag6xvXrX8wPCaQq/o/MJdzbI2OpH0jEBFgikp9H1RJEc69U72f+?=
 =?us-ascii?Q?hC3m4jEH6hxcUZSXbejkD6q83x5nRWrs3i6et8IuKQaCk6272N+nZD2t5DfD?=
 =?us-ascii?Q?DNZeWxtBB+OEn43LKfE2UYbjqGNd7zmNYZWhSmfh4410mcIDMosKtw5E25N+?=
 =?us-ascii?Q?sQyAjHq+np7mZS69g2kui4OTW6BWc/bqMQYSScbCD0qL6uh6iz5VgpUrNZLE?=
 =?us-ascii?Q?K+55PgVlIp/Ua7L/ws0ADN7Uru8EV9fmkJV+nMh3d5WR8v/NSqPzt7Nrl4By?=
 =?us-ascii?Q?Dk1dl0qNfigsgyR8W5cBtmPe5NWPHB4wEX/wGaMJG/idjJOX6bfKmydqk46B?=
 =?us-ascii?Q?880gUlIbBzq7GaBXRgSp18CbkQ7AWJND1rcN1G7nidOZKuWuGJaBLDsoyIXt?=
 =?us-ascii?Q?IWNIK2818+/vkTog/Q3UCwH1+ItmG8r7EeVBCYga//HYBprHqFV7eO41ciHL?=
 =?us-ascii?Q?1mne2mAcVaVQStRLg1jiIqR0n9ptp1NCVgHypLRKUe/2sP+H6M2g7mY54PTk?=
 =?us-ascii?Q?GBYEgcJsYYWnwlKX06Vb1XUvX+4J/olTxn0CSWi2W0dUMqLRB/PihS7KcGDc?=
 =?us-ascii?Q?RXB3+amgYP8Q+FEFuZx2g8bA+Qy8aZw2URIrMOjuMxVjl8TwUPyQNUSBfGdX?=
 =?us-ascii?Q?PqhlaBAq6j+hqaIGjqcYhpXKP+XLAIDeitX6WPCaTaKMKo/mEuaLiXfmQcMN?=
 =?us-ascii?Q?IpBuRdKREcY+/zYhBZhl4isJ5oVz2ENHwtMBw7p/PxIrCH4+lQpDw9vfE/Md?=
 =?us-ascii?Q?9e22v/C1528tf1nGRElJQw+zbNvrqpj0JbRYh9t7t3xG7Fu5cdljeYRHVxzF?=
 =?us-ascii?Q?HNGIg3ixhLfkQIuQyT2UL7pmDtHPXjzp3q0YvgK9Fij7k5nRFAvWhgxylN9i?=
 =?us-ascii?Q?oOQntMQOzavtu1N/2jmzJBM5EeM0r8wdmYFB8GXWpo5XC6A75OJGh5YnX/Cs?=
 =?us-ascii?Q?fA0kiRO2b9pfTl0rQrFTF1+nROHqRnwQSUDOSmv8wqptIgNKZOpn9fE/eTA0?=
 =?us-ascii?Q?VpMbQBf4mdLkcOZRFeEpO03gu2kQV84GUmy9Wnpi+M5+lEL2pLofZP8gXKIt?=
 =?us-ascii?Q?Gt9v34DB7yoAMq4S49hxjDYUpxgP8UzOWQiXthf5ghRr7Ik1dA6Xle2p8v09?=
 =?us-ascii?Q?GkIRoXDyQ/Zpp3he7cwTf5JTp0WDw+O0FuU9ebVSjz6mO5wt96W6GlbeMOJI?=
 =?us-ascii?Q?V/E65+h+KhjV+FYxoq9Pzz3NfnVfIIXHXNBURC9PxvSRD6uikMf1av37DneP?=
 =?us-ascii?Q?exAH5S5Q0iNHLNGaukstlNKBViKactZxSmAzkcUfYD9QD3eDR63EK1JuBAyY?=
 =?us-ascii?Q?ztsiI7QYGg9j58aIQ+7+I/qikS7xbUG6piYcqTalfCafFqcokodNHIS+zo7H?=
 =?us-ascii?Q?2ih2Ku7B3gSJ2cLmZj+giq+0F+ejVqDN/O1DZnYAL3zC+/Zs8Y3kD4DzUxtS?=
 =?us-ascii?Q?Ze7Ch13+ss4I04scqjJMCYjTeGM3HExYogPUZXqunHiXE4doD2q6RkNYIGpq?=
 =?us-ascii?Q?EIqdQzXyVR3xtvE8jyQ+K8h1e33zTfhIzhFaStPASMdDwYtUQRvUKMtYSHjF?=
 =?us-ascii?Q?dRhYyMcEXPnCLz83HEPwy/S9YfVHo3t7wrsh5dhB7dt8NhCcbF42uBo2hlja?=
 =?us-ascii?Q?9byUDFNmYg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b110d8-d8e1-41f5-6051-08dee344829f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 14:14:12.4525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfx/Qsbis1r6nmt+AsTaupw3bKctp5rHoLVTZ4hEtqiDgSccGZuVASCP4wgAovuUrdj5HiqllrGatN7wp9nzHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF7E1D0309D

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/vdpa/octeon_ep/octep_vdpa_main.c |  4 +---
 drivers/vdpa/virtio_pci/vp_vdpa.c        | 12 +++---------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index 5b35993750f5..6e32925bc57a 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -170,10 +170,8 @@ static int octep_request_irqs(struct octep_hw *oct_hw, irqreturn_t (*irq_handler
 		irq = pci_irq_vector(pdev, idx);
 		ret = devm_request_irq(&pdev->dev, irq, irq_handler, 0, dev_name(&pdev->dev),
 				       oct_hw);
-		if (ret) {
-			dev_err(&pdev->dev, "Failed to register interrupt handler\n");
+		if (ret)
 			goto free_irqs;
-		}
 		oct_hw->irqs[idx] = irq;
 	}
 	oct_hw->requested_irqs = nb_irqs;
diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 51ffc245a038..f2eb654b1665 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -189,11 +189,8 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
 				       vp_vdpa_vq_handler,
 				       0, vp_vdpa->vring[i].msix_name,
 				       &vp_vdpa->vring[i]);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"vp_vdpa: fail to request irq for vq %d\n", i);
+		if (ret)
 			goto err;
-		}
 		vp_modern_queue_vector(mdev, i, msix_vec);
 		vp_vdpa->vring[i].irq = irq;
 		msix_vec++;
@@ -204,11 +201,8 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
 	irq = pci_irq_vector(pdev, msix_vec);
 	ret = devm_request_irq(&pdev->dev, irq,	vp_vdpa_config_handler, 0,
 			       vp_vdpa->msix_name, vp_vdpa);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"vp_vdpa: fail to request irq for config: %d\n", ret);
-			goto err;
-	}
+	if (ret)
+		goto err;
 	vp_modern_config_vector(mdev, msix_vec);
 	vp_vdpa->config_irq = irq;
 
-- 
2.34.1

