Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11021006.outbound.protection.outlook.com [52.101.133.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122B717BB5
	for <virtualization@lists.linux.dev>; Mon, 18 Mar 2024 03:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710730881; cv=fail; b=IuTKH9TWIYvUl+p53nVC8SmKiaDOtlBk664GaqYhPOlrjnW7S1fz2SuW96k2NpbgA7osLqYU/cBJgwrr0LrI5EuM4yjnrT7KhevOh7tk+7DITmRLzifz2PLeKSQr0IYWO9RR8IxRZQ/9Oc06dGUJShcfXGu5WdsMpwErav44P1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710730881; c=relaxed/simple;
	bh=+epaA6onWInRYImB3hRBarnf/RV9MUAyvhVaZ9xU7NQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XSbc0SPakbbI2yc3j4RlLO8Ci9c0VyjBvIIBkwnOeUL6w9wLHXGMoPY+E9wjuZVrWVf5SY8bnEWzhcbRQg1Gd/ffFROs0gbZUdYuJ4J1kcraQon8H9kJxCTDyLIGdLyI2ee1vqFZTiuebucn0uDUl4AEV0p6LVV7tpr2ZkEu3aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=PK8ncrgp; arc=fail smtp.client-ip=52.101.133.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="PK8ncrgp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0CMt7vuvemXCBR8Xt6Lv9w0Bld1CiFIloVjJTcZbwq1JFfzgMi1pWY/RNmN5OqzwxpIA69Shn0e9IWkkcVWxpUPnEltrKQfroApmd6ZgXj3XY+DrafgEEiWX+hJzo9AXZ2LwVsLgMDnObQ8VpamO4tVpy+YRONtnqGQlMSXGhjRgp/DRxTEvHtDAhm6+jfR2unnma4db94BK53DwjpfqZlg3xybDLrdUSJGEtKuld6FlpFZT+CLZ8ZlmyCExFDl37SpiBoTxZhl47CZgorgpp4mjoa69gKNyvZtYQ7+ZQtlhB7EwXo+9zDCx6wt92d6XSwMG7fnDtPgqRM1IfvNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwREAFiGghBVZ7SXbtI6AiFfkRTyU2F9CFLM5E6AE8k=;
 b=HrPfpEi2bQPDGXXPUTtOE5jkCrjJ8axTxKBpArRKZq2bIH9aR2E5SsxTCeM+sS8N2iefxWXBo028+f733nq19BUOrUv0Hfv83kf1gv3IKtd9jb3m6/Yi03TFoTWAHbFcfJHGuFhz+KVTkWnS94uT/ybyzcbG4nneF7+FWJcMaVDBoVJY/gSxiyCz2bJl72OUP5IEJGoINntS8Skv3+D0m4sBF27ps7WpFIOcDsKOrBqhZ5W0KZtafSpIycjsXwIaPtDxrKI+UJmD9wYksSCK9aOY1+lqBRynEG63X01Swjce63ui3gQ+hb3KBATvnX/K0ues32JyMc2o+k/AmKijPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwREAFiGghBVZ7SXbtI6AiFfkRTyU2F9CFLM5E6AE8k=;
 b=PK8ncrgpc6rqCxCq0YZ8e6VGnEycUxY4QNhZAN4C4IToqjLQE7rrXLJMSO3i7k5uHER3LZYjIhZh7gc+gK+mHcCUfIHPYDMWkNRDf+WXr2sOKgR7BgaIlg+gVXlUombJOHDJwDtqE6R7nRPguLdF74Mhsm2LrcoZytgSIpDLQKT0ygirdaWtj+HfK4tqhk60Jo/Ql6xYQoFrxvz41hAW2SWGO1NqT4ofbATAIQA28SQUDY4vMoG9EafSifrBmi1YW2m0p0ZQUrNTFBegoyJBf/e9/QRWWz2g3DVsKuJ/DFhOt7nSaE+ZcvxTx1ctRYLPCtLe3Jp3guYmqL12YOE+MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11)
 by SEYPR06MB6430.apcprd06.prod.outlook.com (2603:1096:101:16a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 03:01:11 +0000
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::ce49:84ce:23db:8b8]) by SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::ce49:84ce:23db:8b8%6]) with mapi id 15.20.7386.023; Mon, 18 Mar 2024
 03:01:11 +0000
From: "gavin.liu" <gavin.liu@jaguarmicro.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	angus.chen@jaguarmicro.com,
	yuxue.liu@jaguarmicro.com
Subject: [PATCH] vp_vdpa: fix the method of calculating vectors
Date: Mon, 18 Mar 2024 11:01:21 +0800
Message-Id: <20240318030121.1873-1-gavin.liu@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0150.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::30) To SEYPR06MB6756.apcprd06.prod.outlook.com
 (2603:1096:101:165::11)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6756:EE_|SEYPR06MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: bfde9c1e-cbd6-4cbb-63c8-08dc46f7aa1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w/nnfDzAOS/QIB4VB7ig1m3AT9Q8PwihPUdu3Wv6HzUHxXR87y0dATkTCFuqf1lX7ZTiTo8LNdvjqhLraUvRpqHIkCsxlP+uhM0TjB0J+uHPmbyyMnMduH1gUcjaltxDNZ+aY9KkC6oWI+09oADvbpKvT4lIX4lFviWY0rEJTXBrato4Ao3p1SAsyUEnsklHfFAjpGqpSymuu2mMAC1eNDGJpOPhZh6jPibkTzWDnAC9hCzY3lIUDr1rWUubigWbT4wGtvkuxGkv4UVuuxmw3xT/ZH/KM3J+IrJpwFMtGkX1R8CNOUbfahOy/JU51Qp285VuYTm25OJWexSGDn/bk+LZ+3k8jJE4uApjMTHMazTe9EfSOLIxyaEht06ZhqMNAyIoOte1LBQzfTk+qfVw9Yv5PcBd1CCQizLTwJ39lhbSlVp1JlwYTRn5gm2EDknwxiKGd4wUYGK1P3HSshBdrjD/ymiMSUQ46Nw4BUwQhiF9biq2ZICGJLeTplEQ6s8bwjBv6BsvPUuDnRfPo9ps/+dzp/riRGF5s2PN7yoxTbabnvs16LtZGNzdzLCpxVTartOXlVLhVXqxi/psCVdHDDKGqTrYJmKA8st48GzmvfWVxVU1vzHMjwCxLcB/uk51lA9MxBAsACxv8B4bz670S8WLvqPiIkaNMHcZA8n0oP1Sz9gZJNUCdZnnDI7QDt7vrgbFBeMrCudCnRvNyyQekySuss0DlSzZDPoo3fiFlWU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6756.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6EwTTGltDjLAbItujWJ/3dPoGlJMhhObjOfasM3DkBxZqITMiqCgs2tZIVbm?=
 =?us-ascii?Q?Qlds/P4Mv5pTPvko3mNI129XXP9kRZsRikK7ltDjKb7QgLGTS3w8G3TY9ooh?=
 =?us-ascii?Q?R6qIPPA+pLkOTJZce9R9JW9NBC9R43xuzeb9gnTAUjiDK5H4sgrMICAUkup5?=
 =?us-ascii?Q?O45W8HbSWsUIuTZiIoJIZjSeB2lAoNl/J/SIyUTPYMSSqiz15GSNszlqX3FS?=
 =?us-ascii?Q?GB+wcuaLqWXNEB2cKAlWoYFvliRyKk8xA2h9RhEnpGhgrKwgGE0uQgron6Zj?=
 =?us-ascii?Q?nbayImQRCN9yMvUDQoLjmpgyT9jc91YbqcRmi9bexxxcDN3R03KnnE3rQZCJ?=
 =?us-ascii?Q?tLzmjsPOpiKBH/Rie+hoUoilROKFrLf+/VisTRXf9ExyMG5acSOS2Oa97CLt?=
 =?us-ascii?Q?Dxn0TYOPnZhsUSBZpW8oTol212z5Z16LeLSWRGfR/4p1y2Ohv/rEO3MYOr2w?=
 =?us-ascii?Q?m3N4r/qjIpRn4UCWzW39bvgT7SqWHgTcz1GrvoySfx6hv55mD2D/MfffWtrl?=
 =?us-ascii?Q?RHZtHz43HlLLIkTK+s1kUZxi8ErVLw4Zt1WPd2nxzCGaCAehxzR36PqTU9FT?=
 =?us-ascii?Q?CwmGS6jci/xNjlJQC3kzXsJ6F9IfTJN5RBgp6a4GkzJiWwpgbDYyZ2wgNy6E?=
 =?us-ascii?Q?JfPS9uoThmNNUm9OwisSb24uSImRUFgMfdHpc855hBlfBfieBBLtdBUBXuL4?=
 =?us-ascii?Q?ZlNQBtVxmjC3TZ2UnWyGt+85wVOIEc2iG7flU7OtPAp8BYFitrbyuKoAtG2F?=
 =?us-ascii?Q?rFQO5Gx/No1HH9G6zH56lBMOuKyP88FarHLBIn0CfMeYdkZOcSa7WkpSaLc3?=
 =?us-ascii?Q?Fbq02G9ucbuQwOPDGNdVI1FVXsRYldaLn+YzP/lqkMiXu19QYgDBKcfBUNIu?=
 =?us-ascii?Q?VxUFJBm5HmXpII6N7T3qtoIploi3/ve5OxQi0GGs+dEqEJ6rrWBWn/ehAVzA?=
 =?us-ascii?Q?acSunB965P5sas3XOqh2eAaYY2tPj0UuCklZwMD3VKxQw7LI+S5OXq2wfXut?=
 =?us-ascii?Q?4JY2kJ72uJHHtammKz0E+hB1sVMf2BbzU4rEpX/BE1zMIgIPp+lD9zOsyisd?=
 =?us-ascii?Q?8YBueDcgz/bzKQ+LSRVnkwg/AkM9kbkUxE5g1TxqJhCQTCezmgah54WxGHFA?=
 =?us-ascii?Q?kOinCgfU7WFklXYjA1u0p9RIdjma6eDpucirqy4NA/e7R16roP/lOpBdJiPh?=
 =?us-ascii?Q?MRs//f9/zgCuNlyCUZWkqk5rXnPve2TILaSkhDAbFMXC12VizOapD9ynL1mF?=
 =?us-ascii?Q?PmQsIvBF7iFSznraZ6SqWO9XHh7d04Vubvy6d//dLfNS543p1GaqiS1uQw/t?=
 =?us-ascii?Q?rkYVTKwo6qzxoDXd2v0k+aDlbDi94sXGiW3SDrDZGrJgVrN5hxMm1hKQXHyk?=
 =?us-ascii?Q?keVnARYi2smq70dHeJoMdYoRx+Y264G9sgArLe3G8zbWiYnjlRuOiCM5F32P?=
 =?us-ascii?Q?Q9C5lg0CRdnu6H4U+N+0nCHKmGi8vrJCQBT6pH8ENP1R/6a+ReRlYWx1Njhv?=
 =?us-ascii?Q?z4p/270D5U2Uoqc3jzFLGNhMp/rJccOPj7UTIDrbipPE7yEbEMwbR1YDwD/m?=
 =?us-ascii?Q?ZYfMPJvnywpeNn7OD5sbSqH6tTcz7lufG9RrX1ILgAk0pTGuGuwEMoPhxTMO?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfde9c1e-cbd6-4cbb-63c8-08dc46f7aa1b
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6756.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 03:01:10.8350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUp3GMHvEISN0CsqhIv1KR7vGQ8DzDnQOZuq+ElYpkf/3VHjvS0JFTzW9LI9KK/+g7S/3JgU6sb+9s0vAVIaKVPUbWnfdBnFCkKNp06YGOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6430

From: Yuxue Liu <yuxue.liu@jaguarmicro.com>

When there is a ctlq and it doesn't require interrupt
callbacks,the original method of calculating vectors
wastes hardware MSI or MSI-X resources as well as system
IRQ resources. Referencing the per_vq_vectors mode in the
vp_find_vqs_msix function, calculate the required number
of vectors based on whether the callback is set.

Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 281287fae89f..5066970b2570 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -160,7 +160,13 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
 	struct pci_dev *pdev = mdev->pci_dev;
 	int i, ret, irq;
 	int queues = vp_vdpa->queues;
-	int vectors = queues + 1;
+	int vectors = 0;
+
+	for (i = 0; i < queues; i++) {
+		if (vp_vdpa->vring[i].cb.callback != NULL)
+			vectors++;
+	}
+	vectors = vectors + 1;
 
 	ret = pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSIX);
 	if (ret != vectors) {
@@ -172,7 +178,7 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
 
 	vp_vdpa->vectors = vectors;
 
-	for (i = 0; i < queues; i++) {
+	for (i = 0; i < vectors - 1; i++) {
 		snprintf(vp_vdpa->vring[i].msix_name, VP_VDPA_NAME_SIZE,
 			"vp-vdpa[%s]-%d\n", pci_name(pdev), i);
 		irq = pci_irq_vector(pdev, i);
@@ -191,7 +197,7 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
 
 	snprintf(vp_vdpa->msix_name, VP_VDPA_NAME_SIZE, "vp-vdpa[%s]-config\n",
 		 pci_name(pdev));
-	irq = pci_irq_vector(pdev, queues);
+	irq = pci_irq_vector(pdev, vectors - 1);
 	ret = devm_request_irq(&pdev->dev, irq,	vp_vdpa_config_handler, 0,
 			       vp_vdpa->msix_name, vp_vdpa);
 	if (ret) {
@@ -199,7 +205,7 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
 			"vp_vdpa: fail to request irq for vq %d\n", i);
 			goto err;
 	}
-	vp_modern_config_vector(mdev, queues);
+	vp_modern_config_vector(mdev, vectors - 1);
 	vp_vdpa->config_irq = irq;
 
 	return 0;
-- 
2.43.0

