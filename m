Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021091.outbound.protection.outlook.com [52.101.129.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DFB26AE4
	for <virtualization@lists.linux.dev>; Mon,  2 Dec 2024 03:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733110583; cv=fail; b=k88Fm6GywVSyljQbjJ9J0jyz/rTmBzK28RonVKP5LtygJz0e7/yhKoEGMe/IPTz3VMmpY3YchoAfXZW4VTozZ9iI0CJjS3IVkdTdQnJ762ExZhzvZORnWISMfoUssExYgvEVBIehStMFCnutDl4zPrS1qxtss6+YyB9Y8OIs4b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733110583; c=relaxed/simple;
	bh=stYkUNE/uWNx9ucNJOZYJlTq2jYAXLSlmFeCO0jsMnE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rZ6WibtuwCCykWnJuKZrhh4K5cCiEiYmbwHn0gVAoPdpH9OGOL2aJqkKyCr5DnPDgIEeHeNkmLnVXMJCSvBLvURLwRidO8Mggi5BOLPBOMMeGW8PkSwsfz2UwNxN6MLlc0POMAxvTUwmGbWDaFWxVxtskXw+5iMe+ch3oQUTon4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=EmUx3CaB; arc=fail smtp.client-ip=52.101.129.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="EmUx3CaB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4GVM3TNtD251mBpDMocQ4DfAiGS41KwlhU3Uc08JxYw27sDN46JOEBsI0nm5V/UCLWoc2clw+d9Vz+MeiI1Ybiv5vwpUQPBOX45AMc827AECc6DuLAAnr40IksKw2NujuBmCUvgDqeltXACWOfoJr3Sde1IsSTEdIjrcBOI4qXvIiYgEoV+YCdnJjm1cPsgiTmF4KcnSuE0eiSZof3Ru02eqSTfgCRNxgh+sxMeqhmNgwzLhQPf5j9tR+HpOW+5eqUECuVm4R18DKE5iuhsVZ325sGQQz+q7t4uFB46C5pg1hVWCiannoB2Wkk9H2g9IxpGA1++v4UAOq9JteimAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTbGhTzA9PIqumDiOOsZt+VgovZgw7gJtT9M0R4Z2Fo=;
 b=aWhbK7NfYCgJjropI7r6OmZ3SfWgO88GpjRWOiFZuUW7fMnJW1GJT8M6mwjGTGaRqCe63X4wavyZnpfJG0wzyne6Tb+sIwMa5kRFeAOodOBQQgd6gSmQblT7TZb8IDXidV65KdsSoirAW9Qz0dh5hLp/0KzcSjetZTP+VIXDo8uXno4/R7EW7iiCaO3lB3SjnBuT7R0uXhGlsfzbox5Miz1L69cFiMOgxThgF863a+I9HRVhvGqzsToWAvny+7+WO680OTIBJHk9/qiEMMeH/tOb/GFL0F7esRK17lRT76PIe+JobWfc4XtUbKBuRiC9lnBTfHF7cij4IHVbq1X5jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTbGhTzA9PIqumDiOOsZt+VgovZgw7gJtT9M0R4Z2Fo=;
 b=EmUx3CaBwn9hBUp82HkUfA3/0BlnzAI7ote5JuwFq5TVXirSmp1N0VBwiP6KF5dKQKd9PUrzFl6MDDcry4sNJf+zkg8hrGymHAalrMDYak04PD0QNwbjv/efriF1PvAf6vXXGhng7BocN9stF2xx6H8Ru3XdfML54AYOXXFVy69nNTeKW2myPhusv7sR9maENeB6qEKGB/cGL3Sdy5crxm6z71unZsguU4qHC3O+Su+LiOmUf7zoZVSO2fN21VIzvDRaAqwZPlNtKDWF8Z4hrYlwoG5QGgWlOFROWi/+qeSdrYlW7DhqLaydvIllRqb77uIrHiknmgiPiDlPx/TcRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11)
 by SEYPR06MB6681.apcprd06.prod.outlook.com (2603:1096:101:16e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.8; Mon, 2 Dec
 2024 03:36:10 +0000
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634]) by SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634%5]) with mapi id 15.20.8230.008; Mon, 2 Dec 2024
 03:36:10 +0000
From: "Yuxue Liu yuxue.liu@jaguarmicro.com" <yuxue.liu@jaguarmicro.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yuxue.liu@jaguarmicro.com,
	angus.chen@jaguarmicro.com
Subject: [PATCH] vdpa/vp_vdpa: implement kick_vq_with_data callback
Date: Mon,  2 Dec 2024 11:36:11 +0800
Message-Id: <20241202033611.1374-1-yuxue.liu@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To SEYPR06MB6756.apcprd06.prod.outlook.com
 (2603:1096:101:165::11)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6756:EE_|SEYPR06MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: 965a7b23-570a-4f89-08b8-08dd128276c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P950BQMev3HK0hEoZX8XhSzERIVjk4DE0s9LMhhSpQT9aimNTwePi+xsHiUW?=
 =?us-ascii?Q?Ths3ULYQxdsCFlS0MNAWvxUhYDwQ9g4RGh21DmsPIWNN/XXnCpyuBl8ih3Um?=
 =?us-ascii?Q?vgiRxHEQKxxe/4/SU6rom1DUiVUpZZ/tkZPRzyv4RuvXV6Vt6gxVQg/YTIUS?=
 =?us-ascii?Q?sKALfW5Twq/E+j2QkWHVqF6VZWWZmZbrVDxV2SEdocUj8TuNj/j2WR352iG+?=
 =?us-ascii?Q?fXjkvq9MURCokJY1NdCEBE+HkoOdsIizHUQT7JICb/I2nkmLaDQEv6CKuBwN?=
 =?us-ascii?Q?ltK/kpMmyDd0F8Gv6CJtpHbyqICestXMRvmuZvf9U7voSipISFZ+epyDNA33?=
 =?us-ascii?Q?Ogb14iCM2F1rscb6OzvBc6RQ22ZO91ekWzRFMHZNeJYJgBomUJBYV16tDpDU?=
 =?us-ascii?Q?0LMDBcQA9xzk8HXF189uVuBxU9uy+TMLW+g5GqptCvMLj7oAydgmT7Puz5YP?=
 =?us-ascii?Q?snW2vry9jJlEC4fUc0R9zxprw/juzCCYDUIB9J9pZ5SdIYIs9HSnSotP/AYH?=
 =?us-ascii?Q?xHNvOmDbW1gPdkCPnA3ZanAUt8tsHkjUZ3203bEpyd9Jz35R4mMdaAVN7BUQ?=
 =?us-ascii?Q?c4DuQcIeiblN+RL4ozn+Xl4QbXoSjTTknE8sI0MORh9OiQooZ1DNUQZReHhv?=
 =?us-ascii?Q?VBoKHMM9cW86Zbn+xbtEuJWxDu7AfcshAw2P5PeQmhFMuZwPTCNZKzSIhq9n?=
 =?us-ascii?Q?FiPYlZYxK7RSMSbHWJVbNAt6TL3XLYmpBh85mv5TKPp8onJi8sQ2SdqrIRPS?=
 =?us-ascii?Q?vtoclL1nTedntu8mRyltfdcin78RBdGrkAVYyAM8zoS95jVbVHjH3tYhMq1z?=
 =?us-ascii?Q?AhTBJLXBas9QGrFCnIkipNNd5tvDADrqzcHR2d6MCykKWSeAhvQFaHoVipNM?=
 =?us-ascii?Q?SKC0PTDuaudMwBqXFfpSxGk6CAh1wHNkN5ppNF5ns0JwAqjQcXEMo9f6EbNE?=
 =?us-ascii?Q?UNOAfEbgdp4r3iyURpWLPnSnREnZ8BEqQnDcWS1v6ylGXs8t+TmdGgPFTSAH?=
 =?us-ascii?Q?rxVBnFpqidIND3KIgGVBer4432PWqZ6FGVW0ETkVgAwzTWGmjC2TRSRBJiYN?=
 =?us-ascii?Q?8h+68UZINOA5RvbT3Hpe1QiKV+iZ/OSsbywsaCyBD4ct57XWdOQ4z1Sd2DXH?=
 =?us-ascii?Q?Oo4FpK9vXKm9ND/ws3WkSh8jH84mlvjkVqMBfVBZRQMAb4dM7w30DV6xLhqn?=
 =?us-ascii?Q?YZJxUd/AvCsw+owrhXRwXAIfKlAC8JTp+Kkg8+OP+PO39HIfOyWk3Z8UxEo5?=
 =?us-ascii?Q?/F5URflWfiWP6nGRWK38Y01FdfGpcSxdCAcxI3PrXoHJZshGTG8EjXMf2z/F?=
 =?us-ascii?Q?A1IcmJysDIFUSU9UNQY4K9twb2FO2IYVPHCpnYNqYi5lsD96VXodKeG70yix?=
 =?us-ascii?Q?ujAwujO0tox2wUeLuVJci+g+p8pOuq0WviJHG3FlTZIwjXOIXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6756.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5JbmZ44DNV/wdYYtpG0tYlmieeQVmFPsK/H9u0yn0+LUxUwx4Py2ln8HzMDS?=
 =?us-ascii?Q?QHhc68zTT8kTT3p+5k42a31Odlqg5wEXYiGS2tjbgC38yiHipLSQm2PqmwRa?=
 =?us-ascii?Q?xQY+YDZw5p4L848JFG8NVvkLo8OXGQg/SQOPdmJO3WOpuOdLqzbmmEEf7F1K?=
 =?us-ascii?Q?NG+Zh1EibtFpJi2wmREcQ7k15ADh1D/yvOFTmNzrOHFP+5q0XE5v6uHirF9h?=
 =?us-ascii?Q?HTx8Is2kWUh+LuVmYK2c6soJHsvaGNrYVPCtqOvkENP6U/fRt2ioBfxV1ZB7?=
 =?us-ascii?Q?YHmYXPJ6ghQGhIEJy/6sIH1fyCWaiYYzb2g25QGlxRo7zsiqLnX8jz2VOpB7?=
 =?us-ascii?Q?K26khaskmX8T61Sog77whCD7MyQR2pJg1VPM63SbfsdK3UF9yr3p0WW7ZdM1?=
 =?us-ascii?Q?i+Z8AKUfoXDgU/BtfM0fHb8B5FsysbX3nZjkYNXssaCU5YlFl0bFFSZBbHDI?=
 =?us-ascii?Q?jUCNIJqwWjXxzzTQk3GoYQlnD6Su1VI+LwFDfr421t5FbbT51GV7jEsQhq8b?=
 =?us-ascii?Q?tYA41qZ5PUhhUP62cOpXo9E+VFPcf3K59TngDFy0QSTVd99OrzKQT+cGawfN?=
 =?us-ascii?Q?CoaUminv0bb0L1JUIIGSyOhgo/Bwl4vwpH/vfH5iCJYJAR5VQ/3zKCiamzB4?=
 =?us-ascii?Q?+J0FSb0rabHfwJ0oqFDG2fgW7Bzgee7twHLeZrre9WAGNl782IMBuC/8v4IA?=
 =?us-ascii?Q?ZoipY2a+J9T3Z0w5qEjLlCK0pr12yhWCgVr7dn1Yptw9ENkm0ZWnoIa2Tw9i?=
 =?us-ascii?Q?GU8ogm61kHvNUOaEExgJEZ2OZxH/4uKBN6vXTlSc05ont2wm0uPrdB0mOz6T?=
 =?us-ascii?Q?ER0XPiLVtyX8ODw5ABlw0he0530+MwGSOXo7OG/DoghX0bdXjVRQRz0JQaok?=
 =?us-ascii?Q?ykMZ3b4o7lwDsYWXsUD1lx+t6qAdw4vfRrXw+FBu7/A2hT8uRFw8cZdYhYe/?=
 =?us-ascii?Q?h7yv1cJAw8ii02PdmR1pBOMSl68N2aJifm/6wxxGWHvUQ+yzaQYSqq7vpPHi?=
 =?us-ascii?Q?48rbqc60tG2hciPf9F3dLlAhnVCHXi2q/3coerE/JJpbS2LFmCVMVYvET7Ka?=
 =?us-ascii?Q?YJvW+WraTRcKXZMiBWOmsjpP89jqyVU7TpTIlMJ/liMj+aanX5D6qk4IocWe?=
 =?us-ascii?Q?vYvZBgrbF5LZKQ1zrORwVnCmkwsi3LzfV1xj7BoFxfxacAIIKjgLLi2g5Ulk?=
 =?us-ascii?Q?TDD1ltzojZ78TiCMYKL66k+AcBDXud8o/cLb87PqfY0Bt0XThx5Cu0+a/l3t?=
 =?us-ascii?Q?4inmfil7/cSs0OEj2hV7z7k56REEkMJ+yYw4xpkPnYvHBjzB9bmVTymgtKg9?=
 =?us-ascii?Q?NqHlaoAevo9w53ES7F6srung8kpPBU+65Zj4ys2MmZ83Ic2FU+xGS7EVt0hT?=
 =?us-ascii?Q?d9NQ7CuJnKddGWsURYGpKnmyhtNSKPDJ3PV4L4w44fO4kIzobgS/P7DCw3rX?=
 =?us-ascii?Q?QcQkKUSYl5FZ2nxvcPnetub15KoX3Q71IxAqv6hf5X39wtrHeMxdVaGSzEfS?=
 =?us-ascii?Q?p4SB7C55q7LqpURvSCy2FEtd/Kxcm1AEpQpKA4g/vgLmaNdgkIPWjgQSNhHR?=
 =?us-ascii?Q?nWkeWOFXwmCmCp/ndUOoPMcBcdMwWjfIC9EndILi/EAozCY+TR/yoacMyjJx?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965a7b23-570a-4f89-08b8-08dd128276c5
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6756.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 03:36:10.6142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upCJCPUDPFQZSelF8u+JSx28NxD03qKoEk6qOSMDj3LZwxW2Ahqjg1OrUeWcgcynMgyIiKu+6Q7bjai1ECfowYTKjiWHXraXhoG3sgzifR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6681

From: Yuxue Liu <yuxue.liu@jaguarmicro.com>

Implement the kick_vq_with_data vDPA callback.
On kick, we pass the next available data to the hardware by writing it in
the kick offset.

Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 16380764275e..a9034c59b020 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -367,6 +367,14 @@ static void vp_vdpa_kick_vq(struct vdpa_device *vdpa, u16 qid)
 	vp_iowrite16(qid, vp_vdpa->vring[qid].notify);
 }
 
+static void vp_vdpa_kick_vq_with_data(struct vdpa_device *vdpa_dev, u32 data)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+	u16 qid = data & 0xFFFF;
+
+	vp_iowrite32(data, vp_vdpa->vring[qid].notify);
+}
+
 static u32 vp_vdpa_get_generation(struct vdpa_device *vdpa)
 {
 	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
@@ -472,6 +480,7 @@ static const struct vdpa_config_ops vp_vdpa_ops = {
 	.get_vq_size	= vp_vdpa_get_vq_size,
 	.set_vq_address	= vp_vdpa_set_vq_address,
 	.kick_vq	= vp_vdpa_kick_vq,
+	.kick_vq_with_data      = vp_vdpa_kick_vq_with_data,
 	.get_generation	= vp_vdpa_get_generation,
 	.get_device_id	= vp_vdpa_get_device_id,
 	.get_vendor_id	= vp_vdpa_get_vendor_id,
-- 
2.34.1

