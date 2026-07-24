Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021119.outbound.protection.outlook.com [52.101.65.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B4140DB3B
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893573; cv=fail; b=pJBOOXr5DHgTpfQ7WpYuxY3c1r/5NOnyex5NfCYIr//pA7fzdsiHhvxn9sIm3kf4sVLKJVzNSF7zIsubcFfDGhVt3hLHhmT3HdMXj4FcROM2wpAC0BxBXKkRNDlwwODeYeXhWRhOVM9RDnDPQKTz01qjcNWV3kVQwz3tsrFUKi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893573; c=relaxed/simple;
	bh=Qn7GlmcEyU973Y36HRx2cSL3+zWzo2n9IzF4mzuDtTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kAFwRAYNjOYZuVJ9bNQjmsR1Ir8bWR4ns6WQlmrXNjf7uDH9yST9gQzzriZ44yXOB0WEuhYVAN+fGKkciBoOD3yRk0QKVzp9gX4NrM+KDEvU/ygoGjzWV9TSYvpbUYlGgac2r43aNWWKbTVQ8/21XZOOlYTsS70Y/tPvUPLJPeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=xVnRh5GI; arc=fail smtp.client-ip=52.101.65.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="xVnRh5GI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkWld0SD+AXdAu3b14YzCR+tKP+njTbxdg8okvXqxyNtLG6+d0OXKMr7G30jts7chsgwPhqOwuH4k7H1t+LbOc1GyJ3ZLzLg22i3bpTHAS75RERt926sUuSzSoQIgCVNo5La8Z3GbS9yN33jHjdPppkS/Byve6S6UwcuYUD4AgVeRxghLmvM7bHlaFxan21CeWsNvqmduUXvF0WgSbtYqqua1BkXeAZQBN2QQXfvbK2pZ1+DZuhdA6JhM15CSwkXO3WxzQVisKS5G/QJA5DlStFDD6/yVa9puUvBxXKGsNFcrL4pxK+zKoJeowE/9owirPKokeQXCcYFFO3UR+MLGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LowirimV4TKla9sXoL1YSW9xOqXlum6OCEtXjy4h2zA=;
 b=StIQMR3k4mT9W7l66rMSgxr2gBRj0FeGdMGK7HvFDApchAjk5kSl6+MAZMMUamIFJ06QiecPICbzMK1ytNEYX4qDnBKoAbNHDSLNgRMA0KrBM2PKZZUDSWjRw3JHhTe0Kgiu21Nazl7SVleJzlmcivTdI3vaUTC+s8SiTfrY6xLFcrqRGwbSCtXOLEoKvrlZciU5wFHSocMqa+aMnj0yEaIa/zX3eZjiCNGvVwWKZRHDnUbnWaIJYmWmqrExRAQ0RxYDbWkdJcbuPUhP3N3EEKPPMEnpyJpMDwg8jgz6FTcW9Qs2st+1FgnnWmG49nCZ4Z0KO2VajrguQ9xN4wo+3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LowirimV4TKla9sXoL1YSW9xOqXlum6OCEtXjy4h2zA=;
 b=xVnRh5GIIqteUvt+p1yRAqr7oS8wAJlRSMcn1fmU2cjYzbAuWJeC+Vf7mlcxWFcTe0aEktbTYZx/WEMxsTGk60O3eM2dLJQZq3jg9Bqd18zqKi+mGKhAO7aoRpkqkD14e1ynhx6Sg/ZxQkNoRKnJuf03imVpDhqqewuIEMkqE9J2KoB1cGRAK5JYTuPNxGPXrlKEzN3zPlhmF6GX9t7oMEVvkwmPIluCadGwKcKiYx8An0/IPXfLv5SFYIsCTXz8EKtBU12B5IswOcOf3xG+AOsd2vVyhH5aJE6NWe6kmA/8NmDB6sFxuOgQroWuqXPhNaKkPqbk3ChtXPJc+ReJPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by VI0PR08MB11775.eurprd08.prod.outlook.com
 (2603:10a6:800:311::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 11:45:55 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 11:45:55 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	sgarzare@redhat.com,
	mst@redhat.com,
	stefanha@redhat.com,
	dongli.zhang@oracle.com,
	maciej.szmigiero@oracle.com,
	bchaney@akamai.com,
	mark.kanda@oracle.com,
	ptikhomirov@virtuozzo.com,
	den@openvz.org,
	andrey.drobyshev@virtuozzo.com
Subject: [PATCH v6 5/5] vhost/vsock: add VHOST_RESET_OWNER ioctl
Date: Fri, 24 Jul 2026 14:45:42 +0300
Message-ID: <20260724114542.734623-6-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260724114542.734623-1-andrey.drobyshev@virtuozzo.com>
References: <20260724114542.734623-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::14) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|VI0PR08MB11775:EE_
X-MS-Office365-Filtering-Correlation-Id: 6177ca94-703c-4b1e-efe3-08dee9791eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|52116014|1800799024|366016|56012099006|10067099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	CuQ5qOJ6go5/sv5/7A6CFqu+WVLAOP8iAD2gGLsdjzud8H3BdQrc1sK1/l1sDVWEsyOgUMBqPR0y9Df2fwjzmucXTIjYkLbXpMCPQW3iDkJAYgHUvf4pQpqU3PqkYEcFs+z9Og+ROZqx5A1HJqCCMxjDo1N+YC96sdNxsRQK/Zd1WekVwxVRr8eYuVKGjGx6S/FLeqbo0n4MfUutG05/DXDmcjIBDfcanRuxtSZF+69K4huLo4LK8yaa0g+iy5QF7dv5TaBDH9HBQiIKxrHzPnQXQ7aNAuv2WmJD5B+SHOkOvkeguXG9NMZpxyrcGWFyODRe5UeBa+reXluDuVaBrKPQ8VZYK544VxzuJBIDcd3Ny+FCi2w/1Ub5OMhdBRfC7vRPkPszvZGu6yfK6AkGi/XJhYSrruM/dsZmdj6VtgEotPSIw2xkVKTs8vnEEFq7ND8j0yPGHTTsz6KBr52JbIPM25Qw21taJT29niJNjn8Zsu74ZaNQhH3nYxSC5RG3p3tGLanBEXAfWv6OQ+GnKToLIsNn5Yl7Xe79GIepduPbcTBncB3zAfGbDkzM5ZXUHoiz0EEun2Y+jCTjKfQaoj8z8iKbP6JZcruAC5BHdOllmyIuOAF+vjw/VMUub0GlOdyHItQsrWELjPjozPzE0MzaBuBdFLoSaHezWuf9DKHxpjpm69VI8IDym8mztER/Lx2NrLZBz2FHvpY9WeghOsYjzsAsf5SoxAzx5U3F1dc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(52116014)(1800799024)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rL18LN/GK23j1g2G2mDuO0SmQSkUWZ6YCHlBxpXnkVGIdmguOMCPWO33v6xB?=
 =?us-ascii?Q?Q4Su9q3EeZH4om1GwMNhbbuS0/j9fC6ElqjhXETmzdJPO606n/mQpNiSNGHn?=
 =?us-ascii?Q?4ChL2GX7JrgDKAwJAHPyygFEMIGd9ua0iZNvK1WPvQVcrsWKQrSEjFXORoyl?=
 =?us-ascii?Q?uHC+aG3wJqnGh3xYjgXrfXx39dI//Kj7ejNYusoeDHiuk5sgN4BeGp/cLkhu?=
 =?us-ascii?Q?qNaVX1s8frgz6GQPnjjCPf/Bq7XyEczNlkm/9DS0N4l+g8gsLfWr4Fm1Vd4V?=
 =?us-ascii?Q?yoNa9zbUnc3M0lh9RjXFuvFmUl/LenBK8sh+hSnZ1V6qG2rqfjJqSzxz477/?=
 =?us-ascii?Q?e/EOoXbO92uq3WT6CUNnncOsFi+JTwqXJ28ur1Zripy4c1teFoxxmccmI6/A?=
 =?us-ascii?Q?QO9W0aaySmJAon0G6CZYN9WNRZBiL00oBNAob8eKTwKMA8hgk1+PIL7TxoaI?=
 =?us-ascii?Q?JQHTX6eFt6PEyBl5qR21QG6C7T2FiwIhpQ6qJIWgVsP4IIss9pJG+inKPkYO?=
 =?us-ascii?Q?wrJkb1oE0T6Kpto+W7ux+/4W5nFoS+Oebll/hmWRvgRXq16EJsSp/+nA1V3o?=
 =?us-ascii?Q?SdStXtzDm3EIWzrAxzZOhP5KSlOMLuJWG5q7JhONOMR/RCC8T68pNm8fp5jN?=
 =?us-ascii?Q?G6Klz321TDPFtCCR9lhj8W4iukM50mVO3vsNwQ5bEGOaYQpdrv7wGVhQP4St?=
 =?us-ascii?Q?1q4VDcrK7qZxNKBsY/3SJSdHhn/st1J6CgvD+HKrD+4pGR+2e//oHO8a9CA7?=
 =?us-ascii?Q?NasHPvagSO91LWZr6Vzk43D//tf9K+qs+oLq9Zu8aeU6kfs34aOGmzg3JGMr?=
 =?us-ascii?Q?Ee41t95MNSKfH9zIo+r6c24SLm/JXOzBWNNQbi0gsszSdiAoK8fgPbh7uWz7?=
 =?us-ascii?Q?HTJ5i9xJxQpiDY2uXhvgwXfvnebeRsoy2rpytfWjbSrrLZf/GS0J8R42KmE2?=
 =?us-ascii?Q?VELU9ODzJjArEKFFr01u0Y3tJKZRYj1QIFTPgHjpI+5AN0p/neIPcrn/mypF?=
 =?us-ascii?Q?bC0l4EmaIp/pkFu7xK/wX9GJGYPpp1iOIBx9oVfeGDy89UpvQu6R4pHVzsMH?=
 =?us-ascii?Q?500hKj4uyzfRjZoVwMyj/Ec6RCxeaj6Ljd2M4y3L8AaW8hCIA/ySn1nW2KkB?=
 =?us-ascii?Q?Yb1FJY/Fx5M3V0AcTFoFZbwfoqbQRdsNtrhY6aA9H9oufg2ajSMM4NLkEs8t?=
 =?us-ascii?Q?tPrErf+bZLg6Qc/F9EPJO6LzmFVG+Ys0bKfz+B0DB42691eiuQre2kSvY/K9?=
 =?us-ascii?Q?yD3nD7pDcpGU3PJUTZrO3gX3UjSts6HrZevRltzdxV5EBJ34ggekpWNIResq?=
 =?us-ascii?Q?YX4seI0rIswpk0bLSJC3Gl7MGJaq/fKgGTKbZp/2B7r+cRL+MQNoaJjQ4L/Z?=
 =?us-ascii?Q?lV06HnhyCKL+DknzvDKOamLkwnpKTzBeqy/qqwpcrfMjPU6tfYTK1n+Sg0OG?=
 =?us-ascii?Q?gY2lDJTZrCKYDAUGIeE1MHiuQ1BkAnIv1Vk9oRW6hh1xsBEW9EBbsoM8CYgf?=
 =?us-ascii?Q?I3F42GYmJKrtt5IU75f7qfS9LEUOZKwUjxbz8TgFbJjaZMcgznhUZ9KRIPK2?=
 =?us-ascii?Q?5O7N8R4x9uqOfw/BM+8TrD57CvksyVvMOv6c65P4L1P1U6ymifl59iP4RQDp?=
 =?us-ascii?Q?3iyosmil9C8cT9YmZEk6o2vRWFPhoO/BBQGR+oB2TR15fEY7kRm1/oTVy3nB?=
 =?us-ascii?Q?lg5dU8T7Tvrt+RpELKeDqrKehqKbm/JN0P7qcvrHS+WjhUZEvNfE9+ruSqmO?=
 =?us-ascii?Q?3Eh+k5aqLPFJz0VR9yEO49LkOnjHtOc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6177ca94-703c-4b1e-efe3-08dee9791eb4
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 11:45:54.9958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndd9Kk+NdgYG/e+OOJWPmGp3sq4N+13GIICy1L+npeKyNj2yzr9cRI1k/VXXwdmqqryJnEBfUcPyz/cf4XN/ZZEFDbciAaQnO+EWRHgbKsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11775

From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

This ioctl is needed for QEMU's CPR (checkpoint-restore) migration of
the guest with vhost-vsock device.  For this to work, we need to reset
the device ownership on the source side by calling RESET_OWNER, and then
claim it on the dest side by calling SET_OWNER.  We expect not to lose any
AF_VSOCK connection while this happens.

To that end, unlike the release path, RESET_OWNER keeps the guest CID
hashed: established connections survive, and host sends issued while
the device is between owners simply stay on send_pkt_queue until the
next device start drains them.

Since the device stays reachable through the CID hash, the lockless
send/cancel paths can race with the worker teardown in
vhost_workers_free().  The previous commit ("vhost: synchronize with
RCU readers when freeing workers") makes that safe.

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 drivers/vhost/vsock.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 87309c68af15..906cec7b5afd 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -903,6 +903,36 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	return -EFAULT;
 }
 
+static long vhost_vsock_reset_owner(struct vhost_vsock *vsock)
+{
+	struct vhost_iotlb *umem;
+	long err;
+
+	mutex_lock(&vsock->dev.mutex);
+	err = vhost_dev_check_owner(&vsock->dev);
+	if (err)
+		goto done;
+	umem = vhost_dev_reset_owner_prepare();
+	if (!umem) {
+		err = -ENOMEM;
+		goto done;
+	}
+	vhost_vsock_drop_backends(vsock);
+	vhost_vsock_flush(vsock);
+	vhost_dev_stop(&vsock->dev);
+
+	/*
+	 * vsock keeps the CID hashed across RESET_OWNER, so a lockless sender
+	 * can still reach the device while its workers are freed.  Pass
+	 * sync=true so vhost_workers_free() fences RCU readers and flushes
+	 * before freeing them.
+	 */
+	vhost_dev_reset_owner(&vsock->dev, umem, true);
+done:
+	mutex_unlock(&vsock->dev.mutex);
+	return err;
+}
+
 static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
 				  unsigned long arg)
 {
@@ -946,6 +976,8 @@ static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
 			return -EOPNOTSUPP;
 		vhost_set_backend_features(&vsock->dev, features);
 		return 0;
+	case VHOST_RESET_OWNER:
+		return vhost_vsock_reset_owner(vsock);
 	default:
 		mutex_lock(&vsock->dev.mutex);
 		r = vhost_dev_ioctl(&vsock->dev, ioctl, argp);
-- 
2.47.1

