Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021119.outbound.protection.outlook.com [52.101.65.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AFF404BFD
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893564; cv=fail; b=M4pyRfHoc45DdhRb4bDItPLRjaaDzWVwLeR5OGWpXxZ1msxmQjPNLnaWrOAAhE3NdonV0caqZFAyNSJso2/3AJwvw0upAyYmkhOxykpabEVhQHQVfzti+Xt9+pXdfzxBZgbtnOLMhHeYT3/rUeEXuoPM/uTjEPg2U5Qxd/TzZo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893564; c=relaxed/simple;
	bh=ySILu8+ErvN5Uw68u9kWzp+Im3b/dEmiNtt4DJE2Jqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TGKIl8wgtKc709Y+ohbMBdQBLvkB66ZDpbqkq3u92EJriE5HDx0IctShQG2s8ZnddyVpS3znC6EZYohMWD0mDWeznwTT48LYvkDyWpEYNqU8NWbDhq4QQC6hL9DYcMakmKOuCRvmpbROA/k36zKcRTwuSj35Z/ShNEgDvBaS544=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=bLKTcPlO; arc=fail smtp.client-ip=52.101.65.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bLKTcPlO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMIzuPIdn6b4DqIC9wAf/lBoj37I5gnjS06/4/oVYdQSTM128NXc/4ZV+qEh08u/ws2+g+ETPu9sDqNHzdKDcDaE4rpO+88cIfXRC/0AxQ2NkBZ2z6Y5zlxhZDhPD/ce4DUz5NS1I5PYSPZUjG10qP/Bt0X4uEsGNgNTUhpQmwnUozGGITDpqEn/l9NYi0IsPWq0cWSIG78+YM9pQHAx05FPKqJWFVtYRCOCqWPY2Jc+O02EWI9eZSZz6dI8bWOuLGgs/BA1VpRmBgTzol4KLJTpXyFksfDTXlk5tTEfRu9R0z6M611EHP29p+ea3Mh53T8uTZT6KRYWJt4qjPJ18g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmdejHUWaFQG1C+6G1uBJZLM+M+UEopKDqENouDCHWc=;
 b=YTVEH7eI+q5rkLjAbFWDpIOI3XwmYp5MbAKMYfPVzZLZhgFCqGJLzLSyXRcDLVeh5YlEqKvFVXzIl4GvmKDfz1vpMT+85LFHbpH0VLqJROR+CncvdYjXF/Uy5B71hON7qDK4u0nZnyCT26XLj/Yxi89TniMkJEL1GG3cgawZ8SHwSMKKTuIFZ9O1fJIqm5fwrSiZcEH2R7vZ2aKJnZ4yjg+A0gEXhRIvi3KOXwRE/GfrBrtpCYnBj+qD8P7IRjjvFg2IGG+1Z6nU4LrgVpUEVae40oNuTd7OWdyA7l5kWSLvnBzUHjIZvB8ACsyKjQzNYpMB06sNHhkjBxWU0HV5nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmdejHUWaFQG1C+6G1uBJZLM+M+UEopKDqENouDCHWc=;
 b=bLKTcPlOfnV4QyLM8bPspCwzZwUW1GSyeSM/yq7oGSZwshylkYmLnKqcH6ChV5Bzd0wxtD87u7h4db3EuyFUv0DV7//lNWEbx5etR1UZnGUvm843pxCFsnp1CAZmI2TLPfWfWcvm0mj5FcxDDG3imteA8MS2Rx3ZV58MFisVeuvwDVmJ295IKFVeurBHbKX/qNxKX17OpvGcEn100Pd17lC+UmS2WjgQ3rUV6tZuNok9GwgF0HJg5fw8UGTNQIvhKQ068awMsdq4Vgf11mLTLiuI65FaTcoNVu2S7UCa5M9Kzm0K9AfZvhuN3hvGRQjMzOdxzeHmA7+RaFzqc51b7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by VI0PR08MB11775.eurprd08.prod.outlook.com
 (2603:10a6:800:311::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 11:45:53 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 11:45:53 +0000
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
Subject: [PATCH v6 3/5] vhost/vsock: re-scan TX virtqueue on device start
Date: Fri, 24 Jul 2026 14:45:40 +0300
Message-ID: <20260724114542.734623-4-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a538801f-cc60-40b8-a1bb-08dee9791ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|52116014|1800799024|366016|56012099006|10067099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	sPfX+8JxTahxb0J3M9LD96/5+0fZwkBv6b2NdQ/sVhSHbvQDyPvnt0LNJRJc85gZyi/WwXZU8+7fRuXQj1Ct/2yPlLKXya0Z58acSeUyzQv3aSUCFl9fjARVMltmdkjt1SZUGisll9IzM2u3CKqoAjufTsQxs8ugAEJIEE0Do9j5NiZGjlRQyXOFZ+GbsbF/JZOTAiYHRehfRcPwr6zGKECSMmKQq+zq6J4UwNAt4xKIccvlcQKAqpo+HJXx5anRRoHUFYJkA4ZNKPeiLqguOVDqCOQIznFuSXob/8AX5OYCOfD7Q/uOB8Pf43cwx9h4Tw1hbeTYbQV/NtwHNdu3guwvvmfvq7jyJfDb3UoCcytb8ghu8nh8uINhdpxg0+XVOmJFs9BIO6qBdkSVSNFBM0vDJ0m2CcyVzrPVa0if9WSrj+qYmgVOmy3LOGdh5fSvq1UjRxSP0jOAnbWy1WzMTHE5JEOdBUkxMkU0xoZS+vV/qCrcdU1l1jl6FGvQYHCajWmkspPAc75Mm/Q1WAdOppvgGfw9VIWKF1nZIXAr96qi1phn20dkvz6BMcJSzvD67uMOwew0x2S22UBn+YIJKj9eLFAC8Ezstqw9AUZNSq4YypPVxiaefQRieE5tiSj2U4Du+oIm7A2vMmYiqtDryTDs08tF7GMvMPb36hY4XWKLC8agrUi98iBby+YB1X8GukW+rw0l9rEz2noC6Yw6V9yI73WSfGaaM6cRXEXcDQU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(52116014)(1800799024)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H/YPcf98g05e9q0aYK1XJK5fdpd99CEJtVR1nTSXnrDyyyAL1x1vlR8Ivfrm?=
 =?us-ascii?Q?fa2k+aCcQfIOKaitxQHCitKgsetVZmPSxr2dGzvgsjzHHLDApQNYzctwAT8Q?=
 =?us-ascii?Q?I93Ebte1r+gRLI5nYeGOaoLXmRWK2nfEXPq4fibUmSmCugc/ASMPIdHTfzgc?=
 =?us-ascii?Q?zoxzWNiTJFlCtIBEwj94izGs2/lxnzRUtAOloKGdMzsDHZS8gjLAIwihoI5S?=
 =?us-ascii?Q?rN8Cmwa2wO9HMGqDqOSVLoVr3pJOQP4tfvg2zrwaSTKliGcQvlwiob63lEiN?=
 =?us-ascii?Q?jATPA2kE4WHahgINOUTHtPhCV9OWUiLe6hkkh18MY5lLqU/T8pUDiHTFtvgY?=
 =?us-ascii?Q?FPQc4FhLyjDZ+Qd11bF2PfbEO/b/BQU9h0sC65+Vy4Il9G6Na8x3ZziOxtqo?=
 =?us-ascii?Q?iAMA4uBbvoQR9ci0UmLIK+LC3fmJwghDnsu4BV/gkMPjNRHLZExTK5ywb0pS?=
 =?us-ascii?Q?0uGI6xvelYNnaCdx8j0hlNJySZzFF5Lkqp4sprGuBbM9SsvK8jFpHK/sh5Qa?=
 =?us-ascii?Q?/psQC2MSZ2mgPmcpdtJk+s/0lFOKlUIEJ5LfUxIhtoP9qB1ZsWrl8x6ha5eW?=
 =?us-ascii?Q?MrcnWPutgsquGDRva7qSRSUV5ac+OxVJ/mYsvQl885AOShxd194/TLJTgtCo?=
 =?us-ascii?Q?bctlmRHwxIF+LvZ+DZPNDhNyrs014BS/8srEDR9hEfAUY8I/OqUAZKKXEULc?=
 =?us-ascii?Q?5jCQfBpBOZNebUmIaCtW01Ue97kAcU7fJ7YDpWbh2gLNzX4mPcEpTe9Yqu6W?=
 =?us-ascii?Q?eBLLyZ2mOeMcH1MtIaifrDxKw0FTvKLz+db10b67p9AONva4rGyGkXgVuX3I?=
 =?us-ascii?Q?YCpfTuInCw1rtYCfqnAWPxOqgwGeEieajJH2fgHjMfUlXHJEoMESQJ9sv/jQ?=
 =?us-ascii?Q?BoYzF6ju+YXArMshZjqq38oT5Nd5PSZ8cyn7qlvIxs5sDAlgHQjmwfLSrPen?=
 =?us-ascii?Q?V0AFg3UIPvoUtzjiVeHrP3FOiZNxz8L1joZdsoJ7Rtrt1UGXlVCbGjdgwZu/?=
 =?us-ascii?Q?JjxfpkyAC4BMFhU9Hpn1BszpBuP9fIkS/ZrZROKCIdy2MMwb2A1HSlcEv8Tz?=
 =?us-ascii?Q?DQoiExuWZeIAEk/s2cmtxB6Kwn+CNZEc0v7JWR+6ZyP48HRHO2uIZH7gFocn?=
 =?us-ascii?Q?KHhob8/UtnjukCafUfV259LwIZFsRUY6t57YQM71K11pZVoCPKjWKJI16Qhr?=
 =?us-ascii?Q?oy/uJLqJwdmGLeeQGr4vida8ppoxqBd4hhWRpkkUENZ/pphpgdOKupam/twd?=
 =?us-ascii?Q?EB9GaQtyKLU+K407D6ZzuIOItgxLLZSXFT3J/6PGX8N/cJ2JL0ul2DHCSIfh?=
 =?us-ascii?Q?c2qW/SBhXRBuwiQ7fd3UGzHRzYyoNQJ/5IIQJGzUBfJTMYHarKdWdbWYnA0M?=
 =?us-ascii?Q?KZqEbWvWO01RL3VZJZMrvKezaNl7t071ejAtCFK05+pVn01V1cPjAzFenq7S?=
 =?us-ascii?Q?ZJyTTvWjgFhFkDuoX5AveimFGTnkOAQD1AQPkWnarvh88dAS/zsVAps14JCl?=
 =?us-ascii?Q?xjOZh7JitnDI67bRHwbP+Qvbo4L9YGFKL2J1k3Yd0ZT5CoUh/+b4lnYjCBGO?=
 =?us-ascii?Q?46bi3ahegvOtSepKUJgyOX1ajoHxkYZJ6xXxy3Fc1nArWGqWPvd4ch22fYft?=
 =?us-ascii?Q?YyTmqgRB3NhVggs9BOeGDhgNsCzipzO/6+A4F2B5qBdaPd8C1XFlCKqRwEoh?=
 =?us-ascii?Q?1IwmWrB+3uNS6wR1ZP49tdSQkZg4GbM85sqthiZ6PanEpgwOT22KzjNk7Af0?=
 =?us-ascii?Q?7bmByoDMrPQeVgfjq4GqOUY6KUpmJJU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a538801f-cc60-40b8-a1bb-08dee9791ddd
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 11:45:53.5899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rxTlv0Ifs+qiHvKKMOTjD6igLVRRIuhGggKkf60WnVWvBtlAg6WlDhzmQ/9S0lkGa7B1/2EwUqo0TccZ3XPjyzij2v7HLaVF8A6yH9z06U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11775

During QEMU CPR live-update (and VHOST_RESET_OWNER in general) the guest
keeps running while the host drops and later re-attaches vhost backends.
If the guest adds a buffer to the TX virtqueue (guest->host) and kicks
while the backend is temporarily NULL (between vhost_vsock_drop_backends()
and the next vhost_vsock_start()), then the kick is delivered to the
vhost worker, handle_tx_kick() sees a NULL backend and returns, and the
kick signal is consumed.  The buffer is then left in the ring.

Then upon device start vhost_vsock_start() only re-kicks the RX send
worker, never the TX VQ, so the buffer is processed only if the guest
happens to kick again.  But if the guest itself is now waiting for data
from the host, it will never kick TX VQ again, and we end up in a
deadlock.

The issue itself is pre-existing, but it only manifests during a device
pause caused by VHOST_RESET_OWNER.  Namely, the deadlock is reproduced
during active host->guest socat data transfer under multiple consecutive
CPR live-update's.

To fix this, in vhost_vsock_start(), after kicking the RX send worker, also
queue the TX vq poll so any buffers the guest enqueued while we were paused
get scanned.

The VHOST_RESET_OWNER ioctl itself is implemented in the following
patch, thus this patch is a preparation to support VHOST_RESET_OWNER.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vsock.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 27169a09e87e..d5022d21120b 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -646,6 +646,13 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
 	 */
 	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
 
+	/* The guest may have added TX buffers while the device was stopped
+	 * (e.g. across VHOST_RESET_OWNER) and their kicks got consumed by
+	 * the NULL-backend window.  Re-scan the TX VQ, mirroring the RX
+	 * send-worker kick above.
+	 */
+	vhost_poll_queue(&vsock->vqs[VSOCK_VQ_TX].poll);
+
 	mutex_unlock(&vsock->dev.mutex);
 	return 0;
 
-- 
2.47.1

