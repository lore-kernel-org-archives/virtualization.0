Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023107.outbound.protection.outlook.com [40.107.44.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBEC5A7AA;
	Tue,  3 Dec 2024 02:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733193469; cv=fail; b=hcz2hIjIO+itGexAAzXSPx26Vj3UGWtRr5S1KMcYcbE4+oGa2gJJ4Fir1w1Tks+r6Z+J8seXZ7DkI3ardVKTktjq+5MKPHSG013U4Exopr013+TaetaIWHRvpYQoIFLjGAolGqvRo+FfHkaC+lw55Xh0rBusxFHSJ23BKUOBLi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733193469; c=relaxed/simple;
	bh=z+aCgE/vr9Q++2MmGL2m7ElnSHnEHn+3/bzvgfy6rho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nBjlnUM3j/CfayUa7XGjQby/ic+pgeB1R+LPeGl4njwrmO14nfmSkgBtuoByhAZyk/8zXO7x7YEh6vWZjsLKIpxHw6gA7bERX94rvUgvEM05vdBRzoJfb2KBQYj2MM5TsvJwmzMPuGizsbTT+Z4nIez4z9um7qvDohkJwZVMjgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=c6+TrShR; arc=fail smtp.client-ip=40.107.44.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="c6+TrShR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EU27LKNmqp+NoM46dbkPaNhhdsljs2uQFCAIkMvGvzQl6v8ZIb38LDwYpvPrUCizNrl0yi6jCAcOelOg0WYAl4xV3WP5keYSr3KAj1WjK3ebHr0FlFZTht2aiXYpmQGnBGdXfesdpc9UrFPjRe5QSNKcP4MNgHQNGqonSIFKfL1rEfYEefzyVhJkXOkU8l+NT2jki7TR16X+NAs9bvBuXLReP0ujcs/NC+A7fZa8kpYyT+G4a160q3x6Zwyo/bQr94EgTflDXePQnBzE5ahwI/bgPayuAtKkzcizPASU73U0Cd3GRpX8M87StXjqiDXU79lGY9a/mxNvyJ2lRD59jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NlcPSssFiT/Xbd9EZOQilwl4flvU6ARypuFSQmmKnQ=;
 b=OKKcULNHgsOhpr9d9pgR3Ze3nr5QTJ8MZlCjD+WMd7YzcLf081TtwiwIHS+l4DDXpHiGUjC9uwQ1zXBpvisSHTL4xkqx5lPpH0B9on2BoQ9ZvQK5rEx4jmXYisvftb++EdxCzQp3pnAW3v0117yYTAiBQmfXRHdDeolSlyvRWYr4ljEH4Bk3EWJwLVrFeCjOtXl7qavrOvFKOKtEFkBHlM3MWlmO+EpFWGj0UzTbofQaeMV3GQVdKytdU7tRGS+8ygbJ61ItyCcP8DjQe0gXYcgFIDLhnrD9RBXlXYbmXvbS0wS9cdOyhLsQkn6cjXSS1qtPchrCaC0P8FeAj7E2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NlcPSssFiT/Xbd9EZOQilwl4flvU6ARypuFSQmmKnQ=;
 b=c6+TrShR4bhoaIpzTCOdXXFwsDSAV1Tx2rIeuLagDq5IwAc5RBsyzrh5OLH9bEzydY57zoiLx2BlEVMfwg9+UVrSjcU8Tx7HnIyyhOs6jqeUAM5ddO/RrSVyMgETSKBqJcNm2/9b5UnRP/2Va9uq6V6aIkzrylk0BaP6dfX+2dcwYjtOPJ/mFQKGQboZ2UPl81WflwpOBGfNKkDqK1bESMnHtBOS7u/JBqdztujGlJ35+2iHAZWfw/eQa/Hv9v6YHKG2hBEAO57TTbvdYFfdHW3SlNMLjA2XNSM/Lq4AVx+dPzJPYboefQp1QfzRmuyolToukYCmcCpP3xvrpZd3yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11)
 by SEZPR06MB7186.apcprd06.prod.outlook.com (2603:1096:101:231::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.6; Tue, 3 Dec
 2024 02:37:41 +0000
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634]) by SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634%5]) with mapi id 15.20.8230.008; Tue, 3 Dec 2024
 02:37:40 +0000
From: "Yuxue Liu yuxue.liu@jaguarmicro.com" <yuxue.liu@jaguarmicro.com>
To: jasowang@redhat.com,
	lkp@intel.com
Cc: mst@redhat.com,
	angus.chen@jaguarmicro.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com,
	oe-kbuild-all@lists.linux.dev,
	llvm@lists.linux.dev,
	yuxue.liu@jaguarmicro.com
Subject: [PATCH v2] vdpa/vp_vdpa: implement kick_vq_with_data callback
Date: Tue,  3 Dec 2024 10:37:43 +0800
Message-Id: <20241203023743.1757-1-yuxue.liu@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <CACGkMEvf9TS6c9PTiwWn3POr33m7m1shNfHOkviZpk-Pkbf79Q@mail.gmail.com>
References: <CACGkMEvf9TS6c9PTiwWn3POr33m7m1shNfHOkviZpk-Pkbf79Q@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6756:EE_|SEZPR06MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: 4001c0e2-7b81-4eff-ba46-08dd13437529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NsIshxzEX1Nccy323Rn1SFzHM7RnN29GBkMXhbwxP8C/bGld9MIAYobkKyZn?=
 =?us-ascii?Q?/6x/H1eszXGpN7m7rWj445J8kFd0XHs9Diz2nKISaIM7YcYgqnbhvJhB07D1?=
 =?us-ascii?Q?iYUvqbJ8HwLz7HntUw/7EWZRB2xPGhxMF9k+xEQxbkZTsA+jKPnNptvP7DGF?=
 =?us-ascii?Q?A3WefzE1DPpYC3vkNxEfmU5yqDx58PI2IXw/uC16qSRjty3fmpG5zd51IGYb?=
 =?us-ascii?Q?7IB8WKGQy58AF3znnj0+vQd05r5T3KDA8kBVYvM+IfCPQoF+qVQv59GiZrar?=
 =?us-ascii?Q?z8qjfRIKHwtr1RsPWR/aPXUTm1IWBABbfF6uLCUuz3fRveHYzzR1vALFrO/Z?=
 =?us-ascii?Q?/DyYON1LR96NvPUyyYVULvxOaYBwBImHe/haflcfYXaezz1O5JYqBXAxCh0E?=
 =?us-ascii?Q?610llbV1YR1QevSM5xWqXVxh0sBnX1I4MHuxG5+LMb1ZR7BxqrWnn5sDk86q?=
 =?us-ascii?Q?mPIC+J3MXSIJvPf53E/JJ9tWm+NsDGxYUpUW5DBXPx7IgeS5SOMrT1RTJKd1?=
 =?us-ascii?Q?kcO4ZVUEpsvaSJATj9mjrZ3SB+04ZiLpPozAvDVExJvXq0hEH7jGM3WfM64D?=
 =?us-ascii?Q?ojdhmQ993NwrL6Z/3xJjKJb4oMu6msiywcKmpr8h4qsd5KQeJFe+1kJoWaQy?=
 =?us-ascii?Q?YHErDxWP6S2LHgGij642LYwiLVWcpacb4eShSjCFOq3wbDij+ugz+lzI5rOt?=
 =?us-ascii?Q?msPVoHYZSsb41IZ8PDjUyNlojmPfHRmyFLLnMVrPUPNK2R4H0PDgwK7mQuiV?=
 =?us-ascii?Q?RUQEM2nhoLAKFoj9LS3goLXRYiSpxjZmdnp7Dfdq66z+8j7OablEdUDajgai?=
 =?us-ascii?Q?U7XzMVMx+59i2O0N+v8sSBuIcCPlL5ho92aevc0q7iurfs5RdybTaW5KiMsP?=
 =?us-ascii?Q?rtUD7t0NeSKYvEiYqGNo8i6Fz3BsOoVTo6mVGjw0tufwo1Hwhsuw13L//aA6?=
 =?us-ascii?Q?s2THtASR2JOyeZ2yIL9M6RFh8COhIsQt4eqUC6DjoBWHexhN8u42DQ1UwYfr?=
 =?us-ascii?Q?3EhkQEWHZlst+l5MO12jxcDgwrBXbi0hO/O1BxjbiH+ts78S648T+mNZRxKv?=
 =?us-ascii?Q?bMG1ub1Cr1F1S98LAv5L0uX0R+xHdEjlwQ0AbCYWCYz5tbf8YAi80UTZMxKL?=
 =?us-ascii?Q?PJWMpPbX/IKd4TxyYfBH1n8NNbQG3IRnI+ZW1LIT/Ydgyq6aQDA6rXdl8AFN?=
 =?us-ascii?Q?N0nbwqmoXWpMDwmne6zrsBcwRoGTtBYUdGvioQTFj7/hHZvGnGQiXNvm3EGv?=
 =?us-ascii?Q?xcqXDNG/bONv5YBQSDV74soiNMn5QKVDDN3BmtNALZtmGwQ85qDVozIS7fro?=
 =?us-ascii?Q?dzuQ1v2BsmNbQYA1jDTt51KEPChBLETGKv+GpH47tm9pOWSH5VOAXb+53+ZR?=
 =?us-ascii?Q?SSz1Kvz70WKFSMHvLmDxDo8uc7l8DjL6H/FmAst6X+Yj6eOX+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6756.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jrn0Iwo6iXfkI0qBWHDDBKNj4IgNPOJ1i/JtMgRVsFpjExLm/y3dEGBWLZJh?=
 =?us-ascii?Q?QgLDpd6eXBqZEppSrkpGyTQYVmc1KE7QQSEOee3jARbYP/Pp3P0udbbTYqAC?=
 =?us-ascii?Q?c7EQ1wgNDYukfadNdoK+dg2CWssvdLVPDCd2oU3CjUDM6f+T0AmWUAWIQKVa?=
 =?us-ascii?Q?WAb6FhiKdfDl5u730aILERMb0tB61wpAKMEQAAjB+KbtNXxc1O21POZvS6cE?=
 =?us-ascii?Q?4/ppYCHGHPyXor30eDbwoPAsPpY/OeqqjZtix/GhobhPlyo51c3wFIW1+qNv?=
 =?us-ascii?Q?pmZ7xdl2w8yldXMN7HKRxZxfvEE48MskzKSb75R24OgASGGy38DKS1Vs8P1t?=
 =?us-ascii?Q?ZXebPxGmNYCO8k8DmPihK9ol2p4PpTY5ZMQt4FnEMhA8KKCtw6A9M8qKLWDa?=
 =?us-ascii?Q?nZBvf0a/dFvCteMBcRTab66oDZMLMA6q3AoE08CZKQDRZdtCET4z6I0qMs6d?=
 =?us-ascii?Q?3N+Q939yzi7qwYnZ1cG5Q/4BdGlWapDHCu/zmiCv+CVa8cVAwt2mYcnmAOCp?=
 =?us-ascii?Q?ZnAkuFsv/IhG1HBFBvaVpbnW5ZP3sGgZz3yUJ2GO0ofBfv3FUmeQBJ+wBtC4?=
 =?us-ascii?Q?uLLiIsp/drg0GRgU/96Cn5/Cw45WYTThF5cQBplF15xBnT7DGAR/ENPhu4i6?=
 =?us-ascii?Q?oDfRdfd7D3inQiCd939fUibnmmuwT5SvJhqBDdWbHsphyFj6FAjxh+ZallPw?=
 =?us-ascii?Q?vBLBz13mFNcySfIDSkG1MUSqAaTE83tMSaPd6Fy8vjgc2Rb1O+0u7m1v0x3x?=
 =?us-ascii?Q?v3OzJEKibnKiobB7XZhISHHufnBjUiiTDAVaMhDXisnMGjbD+/RVkxVfeUjN?=
 =?us-ascii?Q?3FNO7/f4RyUBF6rKTa4ciLptIh0q3LtIiDlFvNwn4o71h3vuLGnnqVKaKnMe?=
 =?us-ascii?Q?YFNTR4jXeNYU1Ow6suElKD+AJfuoMmH19XrHAfkTY8RAuNxdCeq+/W41N2pn?=
 =?us-ascii?Q?zS5VMzHGedSuXazN/40/w5BMDoXjEedTc7Nr4vhE5dOk89d4uMQAbJwQJT+U?=
 =?us-ascii?Q?CeC1gtESf6OmRYyGPT6CAtXGe6BRVGzjgFBa9AdFzRP070Ct4uk8KkhQfLoU?=
 =?us-ascii?Q?TXrxw9SZsOBi54xB/WQ90ls8oIuRd+NyVIfIFm25yBaLCsjfnIqXU5oJbQom?=
 =?us-ascii?Q?Awo6nlAW5DaP48pOpukDBHZctIg5ieuCubgcnUVxzwiRzjwKr0w5tU7znKjj?=
 =?us-ascii?Q?B1hCtj8DOIV7xlyHGkuAS9z8dr+kassyCQ3NqOgfauioIIkEnRYkISvMz5BC?=
 =?us-ascii?Q?A+/OUfYT+CfrIJq56975WopwFc1+8M3/n+AOeUb2y2vKI+ZiBEKsqtXEVzb+?=
 =?us-ascii?Q?v41iv3uX04dn7kBHl9VZrnCyHMZ2pWAZJzUZA/SjGIidFIrMlvRYojL23YBL?=
 =?us-ascii?Q?ITrfduKuMq+rh4Ji/isi4lJsrbfmRCllfFNqew8Ah5LNQwKiOymlRFO7otyx?=
 =?us-ascii?Q?YsFfmrVHIGU2xsIbBfG/FhGUvi5nb5IsPNHhw/d8S3BLMNuPZayYF9PnVjpp?=
 =?us-ascii?Q?kOfFoajS2FSjA2mHzlFkPhbmCe6X1Fp1sYyWbdSsU7SEGAijqg3tZYg5oFi4?=
 =?us-ascii?Q?bpeILqfAbikLZ/DQ81rTkw1RfrdunWfJKC97rnEZrAY0FN6K1I5Yp5XioMSK?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4001c0e2-7b81-4eff-ba46-08dd13437529
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6756.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 02:37:40.8221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xm/Yffhn+htR7FsMzd5qIonDKU2jioDAHGnS7TuBiJD4Lw0dlAx+ZOTzayzREuBZdVelQxN0KxZEP9Ir0cf99AxTTDxm/LkVmZrXfB9E7gE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7186

From: Yuxue Liu <yuxue.liu@jaguarmicro.com>

Implement the kick_vq_with_data vDPA callback.
On kick, we pass the next available data to the hardware by writing it in
the kick offset.

Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
---
v2: fix build error for kernel test robot

 drivers/vdpa/virtio_pci/vp_vdpa.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 16380764275e..8787407f75b0 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -367,6 +367,14 @@ static void vp_vdpa_kick_vq(struct vdpa_device *vdpa, u16 qid)
 	vp_iowrite16(qid, vp_vdpa->vring[qid].notify);
 }
 
+static void vp_vdpa_kick_vq_with_data(struct vdpa_device *vdpa, u32 data)
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

