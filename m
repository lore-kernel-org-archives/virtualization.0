Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2115.outbound.protection.outlook.com [40.107.255.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4674C1C287
	for <virtualization@lists.linux.dev>; Fri, 15 Mar 2024 10:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710498705; cv=fail; b=JMX7JaHgD0OrB/PwrpYcwsCsUTVjJMbdOvFxUg4btvgx6igfkcyRwDN13rkgH3NaEtsMG3uuAUv2H3nRfO5/9zl9CoK9OC93wZW5YnElzih6ba2AAMbQiFFVaFX0fTqB9uBLkJQRvpULivnJ80QYlqkPYDfCEp1YToTIMajnR0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710498705; c=relaxed/simple;
	bh=JfTMK7RRTFQx9m8ewGlfyncUTYvVUfDUZnQgdULjQR8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KtHocdrP9Sb+zsPQcwmVginsBYU+Fh9i6Pjn/gPmAfUrTzFfv0ABKJXr/iZGK/oFMRmAQjbg4nPYpZpoYcva+GbrAim3I9H7mOZDKyBnEMKS6RUi5YQDd39jgGtFOh1StNIrmswq2QBCKo/MiVhKZtTwi2lZH9OSMqQ8teux1q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=RFkqt1+U; arc=fail smtp.client-ip=40.107.255.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="RFkqt1+U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nojc0lO19tDziE2dJ7qK2OUEL9YfDvFufiuuJYPTd7CXziHb0fNbN9ewt6Cnms3NfaLiEJrjkQjHCetJjKAfUZ1MUUnlFUD6lPj+82Ax4L/YwNL9CSsJcPKWwdK/EfSkbpF3Byxi7uGs6G84UlpfZXVTwvuzd5M3b9qY9045/QVPs1vjdII2Fh16uhe9r2oMNjhkyp9LBksp8EeUseG9XlKJ4GJ2/IH5C6RxK7lZhFyfZp1Vaucd9yuHoEcJEew0mxCYg3mVFsomYn298f/L4jI5Emfn9DFj5LMmMPwrTeC+swwuG04XRsdInKtlYGyU0N7EJPbFDTD9y3MXN0DBZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQvjLtEBHUexjCxVspaHTX36a83nNYKthA63Br355Us=;
 b=BY1iD8NmocZZM+Gm8FMjvSiWO2S8bKHr34Ies37/GV0TxG4JRWqZyBvysXoQ1D250oetKYWW3YHAr6uzjjCvomTi07XFNOMyL7kwnVXJjan9alvAQQUbMdmH/OE1+oOr3Fjs4aJff8CEfj3HlsF00ZDtXGeb01WGM6G4cEwDl0aGdBfxEVXp80hiiMch9qlSZ7IDjYGz7tmeVhcBsc6R2IepWyB8nktYYTauMjtaivOnt3RhvJXj10HOqfMnYMzt/ZWYmiN0fW6vIvGKuwtmMgyKYw8Vm7q0iYP0j5nOY4nuXbSi5AkvliJM8llQKDXeatnzdIk8bQqye9eB/wkVgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQvjLtEBHUexjCxVspaHTX36a83nNYKthA63Br355Us=;
 b=RFkqt1+UxDAyohzlKj2kv41elotzvNmoXHctzd2V81BIGGkssw3ldp6hgDaYBgWHYA84E59X21ikgM+bIhSHe7M5ZXDI2Ksxcj1AXTBCmU9cV9O3V0b8mx4sl4Xg+urXu1OY1N4k95mpvNRwCKGauuMHq603xMqfSjHA9qJEbJsDFF9FQ9CgtaLWYRXg3wsZjpiUfBCqFaMSYjehIlOeA0NEbbJbLdEELGykAJ/TDiqDY5X0UkCMfHwhN+K3cr0Px+VK7XhHXWS+VZmXZnrc+Qv+mCU4wflmDOTENp7BwCevS+qBzyaJuMVsGGUA+MAqopn4I8x9U7hun5YDduuUow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11)
 by SEYPR06MB4989.apcprd06.prod.outlook.com (2603:1096:101:3d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Fri, 15 Mar
 2024 10:31:39 +0000
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::ce49:84ce:23db:8b8]) by SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::ce49:84ce:23db:8b8%6]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 10:31:39 +0000
From: "gavin.liu" <gavin.liu@jaguarmicro.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	pbonzini@redhat.com
Cc: stefanha@redhat.com,
	virtualization@lists.linux.dev,
	angus.chen@jaguarmicro.com,
	yuxue.liu@jaguarmicro.com
Subject: [PATCH] virtio_config: add device ready status check
Date: Fri, 15 Mar 2024 18:31:25 +0800
Message-Id: <20240315103125.1817-1-gavin.liu@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::16) To SEYPR06MB6756.apcprd06.prod.outlook.com
 (2603:1096:101:165::11)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6756:EE_|SEYPR06MB4989:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f968be-7362-4b8c-2e14-08dc44db196c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lC2/diXoT8fXFDC2oFvJAc/F78NLMJaknvzKY7htWJxyI2RNwNCLAUPa30sOII2wUBlhVm0WI6Zgr+QXxJ7/Wz3Z7WOgIs1W5ffvWhs4aYt1I4f4JKSXk7KMrmPqOYRm4dP4dSmrBlm82eSkdmNbejsUvyyhUaI1oLXFUbP5UOv0XFQ90A/VAP2IrHGXZaAGL0G/F/4iPwQBq19lBrHRLoaeN7oauvPhGNgnLUrfKFv642WQJ17J6dob0XTjnYEraUdAcescxFpr0W9sIdTD6KdXB5M5LmHA9dcaEEtRq2Pqq+4WCpSpcRXhmn+Q6rG3NFmD71kOvn2SY7E6kuVrxYmq9jwhoLhyGBtzRww0IYZ3WMUj6worky6/sWU0wPtvFMj1vGNJaCA5sh3tw53ljz7bMl/+RIaVt1zxZ/udwbdGOQhOHKNOLO6bpzFJzToZWgZRAWK+XZIx4QgHhWjEKvRr6mIp5pVXm0M68WU8QYJHT6nzq5Hksq5BtVrbRtf+5OWsdcoz6qX982i6zV0YbOAXosvpOWBHM1KBVQwmfZG0ZiZI8/BfdfnLdcG0W+IVTLuLbIZokz/7EtIVCr/xwLkDaXTMcleGml6HYdqPfDrVMPIxwY6/AgYvdxH93q6y+ZxOrwVND/1j4cBGjCp+kmdXkHazYZn3YOhIY8rkd2M3UwkiCKPNhqH2NfIY/wqcz7Q6+tzyQ1SRPTK5D0qF/hk1oJnvxsqa/RoYfdOGpNg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6756.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KS/vaKBh0inrtbpUP7BLwz64V1/PwYpM6azNRJUD+SCYCfgylVy8jXSDouAI?=
 =?us-ascii?Q?iYgPpYAnSxIi8qXIoicC+xitUYwfU/JFnwQUMpo9lLg3Rruo9W/8D+Xbba2D?=
 =?us-ascii?Q?qHD/10vVURJIXA3LNYBZ5es2BFAXRnup+T8SB1t625gESpegs0cRTuMfL5lv?=
 =?us-ascii?Q?XQADWzmXlT0ux5DS4GtIVfy4dTJt6SLRnxMw6ZclW41Mx0a4BR/RuDCzqLOv?=
 =?us-ascii?Q?etM/syoFX9VheMcU8aDn89LzdG0AT+Kq1DlZje5Rs42NzS5iHzzu4Ht6hBm1?=
 =?us-ascii?Q?p65r8JAoV0MOqR1cTz7By8Jhf04sdsflXTdJxBq8BFxcmh2j76nZ+fRmYsjM?=
 =?us-ascii?Q?dzaVrnj+z2fjvnucL6wqrDJWj/X5dRSsqSM+dLqO5YcPZ9q00A1u9vzn2imm?=
 =?us-ascii?Q?GmNP88OSyX9Sn7Elqlo+NgFzt2i5AnlcN/VsZs74JgoQYpYG37KAv1xB6NfK?=
 =?us-ascii?Q?tijUg0pfXdlGLgSPJh8j/B1tglbUupmtdtxhfnQHu4+H6y8/FvaAgwavX0/h?=
 =?us-ascii?Q?17o1TjiILN2MZd71dTSplrSGB1sN6e9pBTrPAkcb8UMrMT9DF1/sVoLoYfiA?=
 =?us-ascii?Q?EgSeIME6H6ZYDcn2VnfLMN3jmajqwVgDM357tZEToVO3gnzaBFecosZakSeS?=
 =?us-ascii?Q?jcvRfdXoPMERlmJu1WeCyfqpMNchA9lb2RXqG0kQGP6OXXuHV/Bqz1vTMg4v?=
 =?us-ascii?Q?KAv67m0nujWvjt/wgRIZ0aag4zY88h4g4Sad+EoYaTeRho3Et17QjJ+ZMZVZ?=
 =?us-ascii?Q?RrH+6Rmse3AzNhFzbJ1VI1PSvMdiVZjUjN1mNmCdP1O/iOAgdm+RATyt6ODv?=
 =?us-ascii?Q?XinDH6LewxmQMo61PiEsT+EKS++hIxuw7WXAba/FJaedhoy6amFqAfMT9YG2?=
 =?us-ascii?Q?hmNCB2eBEYiZ4midqL6uOjTqci7j/WW37YOxbZpvb2wLVMMHiKRoZRt0Qjpr?=
 =?us-ascii?Q?unRE8g0oF2Y6k8j4ljLz6ZQ2VlFBySu6m6AZswPcBUxAbJTbQwSyqRcLSIAe?=
 =?us-ascii?Q?k4MnpWAOq4jkcnTNsomhNIpD0+5fT1zJtYGvfCbTyPteoh1W2Y3jIjb61skN?=
 =?us-ascii?Q?/HSTS2shcGnHtCyroEnakmWH/eV1aTdxVIdTftQCH4d+ED0m/LZv7C3+AVM/?=
 =?us-ascii?Q?ySiSsejz4ATr/aapS9XixLQjmV9smBNM9og+kE8st0EOl4M2RMAJQb/FH59n?=
 =?us-ascii?Q?OcZRTQZnxsbFGNV7S31ez/2uf+TECauxMRC3AmDDvHsi7hGBwu0ERZZy6fvl?=
 =?us-ascii?Q?QGM8KtLEt67bujS3QXoJ9Xyq87uuYXrEN70O99AIw/a0+2+boGhg8iNfo9iX?=
 =?us-ascii?Q?qqF61ytm31haKzuRRIdGAHihtkZmlVT3DqQpnNeB687u068y8OES9al0Moj1?=
 =?us-ascii?Q?c8VR4ySM92a5Rb7kp3nq/fX6jEqHd0oovxwErSBMkz8nZZU6OQMu06UI74sG?=
 =?us-ascii?Q?Rri3UhXTafyXCFt3i3O7xPuA5O68vuAudX+CtYLK0pwMmPLQGnrrPWX3WzdA?=
 =?us-ascii?Q?Ncx2To5oie7Zwh9np4l53l0dwSwrIFMMLSi1n/64KSPCAVEOA9Ui4+hdvuvN?=
 =?us-ascii?Q?l0Fi1sNtDghPXBfDAfCUrCqKVIJNruzpS/gUS3JGmtMmNMbbSxQ5fQDvvKb1?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f968be-7362-4b8c-2e14-08dc44db196c
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6756.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 10:31:39.6986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixK7piA4ro9DxrynDc6tFMARsP1OuuRXWIQR6wtw3JLtNY2DQa7c68exvhSK7MgwfZdA81JllogihsW6sW7U10nrjMogUQPzrLs2qpoofRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB4989

From: Yuxue Liu <yuxue.liu@jaguarmicro.com>

Under the VDPA framework, when the VDPA driver of a device sets the status
to DRIVER OK,success is not guaranteed. The virtio driver should provide
some protection or notification.

Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
---
 drivers/block/virtio_blk.c    |  4 +++-
 drivers/net/virtio_net.c      |  7 ++++++-
 include/linux/virtio_config.h | 14 ++++++++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 42dea7601d87..14cabf662705 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1535,7 +1535,9 @@ static int virtblk_probe(struct virtio_device *vdev)
 		set_disk_ro(vblk->disk, 1);
 
 	virtblk_update_capacity(vblk, false);
-	virtio_device_ready(vdev);
+	err = virtio_device_ready_safe(vdev);
+	if (err)
+		goto out_cleanup_disk;
 
 	/*
 	 * All steps that follow use the VQs therefore they need to be
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d7ce4a1011ea..0431fc9095ae 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4808,7 +4808,12 @@ static int virtnet_probe(struct virtio_device *vdev)
 		goto free_failover;
 	}
 
-	virtio_device_ready(vdev);
+	err = virtio_device_ready_safe(vdev);
+	if (err) {
+		pr_debug("virtio_net: setting device ready failed\n");
+		rtnl_unlock();
+		goto free_unregister_netdev;
+	}
 
 	_virtnet_set_queues(vi, vi->curr_queue_pairs);
 
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index da9b271b54db..de4e864952ef 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -301,6 +301,20 @@ void virtio_device_ready(struct virtio_device *dev)
 	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
 }
 
+static inline
+int virtio_device_ready_safe(struct virtio_device *dev)
+{
+	u8 status;
+
+	virtio_device_ready(dev);
+	status = dev->config->get_status(dev);
+	if (!(status & VIRTIO_CONFIG_S_DRIVER_OK)) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static inline
 const char *virtio_bus_name(struct virtio_device *vdev)
 {
-- 
2.43.0

