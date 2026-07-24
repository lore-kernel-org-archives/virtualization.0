Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021119.outbound.protection.outlook.com [52.101.65.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE383B7B7D
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893560; cv=fail; b=NPVmxAdAOim/JcdeGHPcYs/9nM6LAYhk6j7ABEX+ysnihQAWbQLGHmTFU8Sa8IuMwO4TktpoBlXkQUdm2oMjy4HF8UvbZmJhQi9BJxM32ramuE8Tjg2/6bFU/Plm0K3eemhwALIrTzBhAAea0kYkXK+GuEVhU609RG19yI51PT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893560; c=relaxed/simple;
	bh=OO+cSQIa+sSlzqiQyDskP0VhFHE8+WfBMigAFXluAKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u1BTML5PDz9bvTJgC8Z2XTb5CkuxnygnRqtf50GN2E+3GJGIGw8BqaJUcKUcAqE1STKZwdNL/RdyWVqOhmVkKvCwbi5LEcKE3GY8hy26xgbs+jShc3GZGRFtnPs40L1ttx2+182+CeMpO2SuzB61sfmhb3JNYJMTWjVWNVkQ4nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=oyTaUITi; arc=fail smtp.client-ip=52.101.65.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oyTaUITi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGooZErwYF1NiqFsUZbUz5hBwPRLsxmNJmyAWxsYRvvxGzj6FW4G3EjAsncCoVJNhKFaqcW4PEUyf/MDCnHlQfVtqDbxYFmeUktuVMV9jXZMDjMlPlx0pVy2WQ4EUyxs4nXkkt1esCVTjPrDUzGevcVDqIUgwbNDWXuf/Rp3rNfEb8rqYeiieCo3sezk0G1JH9ipMk0C/B4rZaMbYXs+0svZQh4qFZcQvjFDf8HWNiuBM3/8FplQFUSAHAAiMj4MHRXHDc7l3X07bi3VAmn3OG0+vQWtF764C5kn59+7WXlQYBm9rIh46MVlte4DTMPsrCJesE0zcFBN7TIWqghlIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIDPu/3sl9SXi0XewZlr30zobS3X065RfRnj+KBScao=;
 b=femZrG9343zsnSs6L91lmlq2PaqEB/OBL4eXSo8v8E4soRpGnC5SDlEhsiEr8pf+SMvPpoCI9DNUJN5V6plviYU4Yy5Jpf2PjVG1/PurnBFfRHy9q9HnMoJWny9uQlakD+ZYmGtYjWNv/oMgr43Xl9fNND+c+kvX4mkGmbiZOb7rkeQn9mVnr00LrtXBxDZbhMKua/MFpbqY/KN2lO362CATyMSYxKwUP40C7gNaa1JgwGHJlz0m8Y9RaEhP+b/953asyzrv71bjFFVjkA5JpJF67Dts6NqSN5X/CLqhGSjifEB9o/JcLAIZIZO4AkSjto+HUjTAn+DsQYEvNq6JEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIDPu/3sl9SXi0XewZlr30zobS3X065RfRnj+KBScao=;
 b=oyTaUITiz3JfaZmanAd2xN6cyZd8LdiG0e52eZSthcg1YMYU2pQNi5Yyk/CYjtFVlzT0t+5qSl369lyKudNX3n7lx0PVZcEo1rG4xDdNKUwNZuTMdc1bu03YaMFs1qBUxRaJxGynaH5cMi/jZHninE7q34I9VolIS4+yZrwzQ6Cen8RZoe3lwPmyZpl8G3QB90SzzsWZl2iCIueUMp9dKzBOM3eLjq8sHF3JPpjT0G3ilTYgQS8jChJIpjtKfWeEH3wcg9sGY/1SmSBdPIXIPmfLL9sXW/G1drn22Mm9fNpWO4QcpyI6sbdSzGgilPxM05nrFzszIN7TEv5De0/cUQ==
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
 11:45:52 +0000
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
Subject: [PATCH v6 2/5] vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause
Date: Fri, 24 Jul 2026 14:45:39 +0300
Message-ID: <20260724114542.734623-3-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3b06bfce-5b16-40fe-2187-08dee9791d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|52116014|1800799024|366016|56012099006|10067099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	9rKHTieu1EEm4yvmNdjJ7/a/C7mx+l+W60dgK5eOuq56DdAykRldqeNixWEmX8ZJ0f26sJryLawzPnFKdGTx79ACR1n2+LWF2ZE+3f/qxnLa3AKBvc5JxG2io8PB8hsw4rUim8luEIaHWbWtfuCINsFpZkKtNdBKZCEtWSnpyiTZB1Ka41tYKg430w5sRlSlv+FTayhIqxn0nCf1gU3Q0F7BvZYhAYAazZdzW8mp2aRPvIB3c5RUpBMZYpHD5xV0gcTB/YLA0MGXQa9w8qVNCt2zMxQVN0p6RzTX4MG7KKd2RQ97XNOTEEXAWbNsfsCnTEoyQMpR5mxGl26pqd6cXCZJ7YHPfFYKpCZ5TZHiT/5n8ZVOqe3LF8UdE7uqc6KfsI8IAPiLeCYT6I4BJ133MjoSIghzYCP6lA05z065xO9Ove6ZU0tHCOnp9dpj+lAJF2kOMsAPFDhHF/xH0BDqa1Li+i8YnwyYgVhBskIToXOLJgIBysHdw0ynJNPAet3DihNzGxyt8U51P3O/ZtJobT5+Xqp3MT04q7YOgrDkWLU1SNQuesquDNkZFfeEX9iVEouvXom8ScAfN3C+PhCemKnekejygUCcdSdwesEFh33d9yQ/ETVYyJKDuah39EFFi2qofS/DeviKKvJDyblltQkwPNpt7DQ6YLqI/Cz1VMbDtp2Mq2PewiPVmtmg5u4dSQZ33J3xEAM/SQg7VLdllV6iqBIu40BLHgXNtz1k/xs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(52116014)(1800799024)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?idEsF4z7DWJkKhkKtf2pw9WFcfobTUtFuxHsnh+hmUUU0N87YThySWJlyqag?=
 =?us-ascii?Q?nnRmjr8TvrlGTdyRAQdVAre8cNpE1VeBSeBJ7zy/27TEC9aHZZZIPzA8elUq?=
 =?us-ascii?Q?v78FpxWoJ5GJCltoF4v+7jbiTC28N7YkNt8K01qTe2/HT+MAPN1rhubsfxZH?=
 =?us-ascii?Q?usVgSfh3nVPCVLqopyKk6IouvacKpMHY6tO7HLoN0RUmF1ISPBV0Gw3O65sK?=
 =?us-ascii?Q?OBEEOXgF+dUHXf+0qpvDAHE1tl/Ow7Uq6UDX97Y3s/sfEsWHoVnCkwFttAQ3?=
 =?us-ascii?Q?C0/cNoPIVTbotNti6JloV9S1NSG7CIBybcsj7WBQtDkl5/pbHL3JUUThlqzs?=
 =?us-ascii?Q?P4k7OrD2jwMDVsT1OukptTJltApGm4pHGqCYlfWPTET1/jFqhxgeYemGHiah?=
 =?us-ascii?Q?9yHoX3w0jhsDYhzZNaLJ2T52u/RgGG8eZEw0+3NvRxE3XiCoXt264dyYb5Kq?=
 =?us-ascii?Q?+d1nZfwVsEQ7+GXynTXkqoCqKyvCxzpgZbijwEZNe8lGoB9gBGdWRXAfykY3?=
 =?us-ascii?Q?u54LbP24CefE40FgVHkgeRlb4aBdOE6gBU+gY+L27YJhzw8J+aQ8MkkbtuJM?=
 =?us-ascii?Q?Jh8etj1cl6s9pvbA7EjPm1Iv5Onjw9EZBMUkGVwlXieJECJbLub7fhUefS4K?=
 =?us-ascii?Q?G0otPlPOM+SCzOuNk7ggPKcZv211Mv/SQhxARQOr+S5OWBaBW6rxoKt2PZKM?=
 =?us-ascii?Q?byzHuKPvPgk47zcHC2O17JOuLCUy5x4tOKLJgqyccjc8+a6BBIktUO90Yg3q?=
 =?us-ascii?Q?AneD9N5gjzSFWLzerwrLlXBCfkvPjx7CYGd1f/lohOUqRKaB7ZlUXm0ASooZ?=
 =?us-ascii?Q?H1kyOgJ3JJBYDGI9DRDars7vli3wksIjOEDFDAEZhZYXUoPRASRyZt9rucll?=
 =?us-ascii?Q?7TezTAk2fjmwRe2eZipvRXvYkeLHmFLgR2mY+PKM/R0MRMWvitxgaHId2Q0T?=
 =?us-ascii?Q?wkb4ZsZLY1YqGKQ8XCurjfIGtjf3aiqi9O2PvRFDbThSEO05gnKY+E9PvR8E?=
 =?us-ascii?Q?NJVY2OIUbhBphWfvJejDx+xFkPiltTkVJpfmAgRvmKTSmRtBvvDckPli2oSm?=
 =?us-ascii?Q?z96OeCoWVkqpVdzVxSdHv8sTOH8GR00qd4/JdAbZ57jbYEMp6bqo3AzCx7XV?=
 =?us-ascii?Q?e/M0R3oomzhOkY3HnaI8PVH3IDfmYE/tmAHhjAHl4AS6DhoXjeQmvzt1AlNH?=
 =?us-ascii?Q?JU3AnezOctGWdN05ahzYd5lmH1MsJ5eyZ5QETPEDgD3RLtwUD+WhecF6z7O6?=
 =?us-ascii?Q?gTSfjLhxI5wWGi0ApWBjQ0udEqgWz6LgHgxSE/rDKsNBVPBN9qQ3S4dPvZRV?=
 =?us-ascii?Q?B2bOMCRvtI4Gbj3yWvuKpXGXCA8ESCqgSnEDVwNpNLQtGJZ31ZRnSumZ0KKp?=
 =?us-ascii?Q?uKLpiSEq067sza/AT+1E4s8n2Gn53WfWKTAZYvMuVs7usFWFHzAFKUkQzBlO?=
 =?us-ascii?Q?1KttJH+7tjqDXTDRbkZjtRPbkBTocWjQ3Dq+zWKZaAgi0PXv6QLMrR1wg5oB?=
 =?us-ascii?Q?/nCLo8nItlQk3DRhOWUSSpUO8BKNc73Y6lN7dzhm6kRNM1FxysGns7ER+9n5?=
 =?us-ascii?Q?5ucxEb7eX94Oews+CZxLwYFVF/O5vk30E4aECrPEGMTYDxko/RJa6nIa0TSd?=
 =?us-ascii?Q?xlRFpV7JGbBxufiln7jjvcbT6NvB4fj+n4L1t0j3Jq+aRIrO4CEWyoL1ehxQ?=
 =?us-ascii?Q?8JUKuWChWzLzxENmKhSYcbPFAf5NpIMWb9u1iTpmdFdZ3J55MHeeFpr+Xi40?=
 =?us-ascii?Q?qdnci6qKIzDVoagThSxq2ZXF6POkIQ8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b06bfce-5b16-40fe-2187-08dee9791d73
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 11:45:52.8887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7N2EqxDTrHJTsKMqj1clKXBKRLgommR3LMwYxY91ANe3OmipC57o9qx0DS1tkyDprGze5QEWchFpvGqaLQ54N2qOsniwoS14nc8EI3+9T6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11775

Earlier commit bb26ed5f3a8b ("vhost/vsock: Refuse the connection
immediately when guest isn't ready") added a fast-fail in
vhost_transport_send_pkt().  It rejects every host send with -EHOSTUNREACH
until the destination calls SET_RUNNING(1).  The fast-fail condition checks
whether device's backends are dropped, and if they're, the guest is
considered to be not ready.

However, there might be other reasons for backends to be nulled.  In
particular, when QEMU is performing CPR (checkpoint-restore) migration,
device ownership is being RESET and SET again, which leads to backends
drop and reattach.  If we end up connecting during this window, an
AF_VSOCK client gets -EHOSTUNREACH, which is wrong.

Add an 'ever_started' flag which is set once in vhost_vsock_start() and is
never cleared.  The behaviour changes to:

  * When device was never started -> flag is unset -> no listener can
    exist yet -> fast-fail;
  * Once the device starts -> flag is set -> we don't fast-fail ->
    we queue and preserve during any later stop / CPR pause.

The VHOST_RESET_OWNER ioctl is implemented in a following patch, and
without RESET_OWNER the problem we fix here isn't manifesting - thus
this patch is a preparation to support RESET_OWNER.

Important caveat: after the first start, a connect during any stopped
window is queued instead of fast-failed.  That was the behaviour before
the patch bb26ed5f3a8b, and we're restoring it now.  However we still
keep the behaviour originally intended by that commit (i.e. fast-fail if
there's no real listener yet) while fixing the CPR path.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vsock.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index b12221ce6faf..27169a09e87e 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -61,6 +61,7 @@ struct vhost_vsock {
 
 	u32 guest_cid;
 	bool seqpacket_allow;
+	bool ever_started; /* set on first SET_RUNNING(1); never cleared */
 };
 
 static u32 vhost_transport_get_local_cid(void)
@@ -302,17 +303,12 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
 		return -ENODEV;
 	}
 
-	/* Fast-fail if the guest hasn't enabled the RX vq yet. Queuing the packet
-	 * and making the caller wait is pointless: even if the guest manages to init
-	 * within the timeout, it'll immediately reply with RST, because there's no
-	 * listener on the port yet.
-	 *
-	 * vhost_vq_get_backend() without vq->mutex is acceptable here: locking
-	 * the mutex would be too expensive in this hot path, and we already have
-	 * all the outcomes covered: if the backend becomes NULL right after the check,
-	 * vhost_transport_do_send_pkt() will check it under the mutex anyway.
+	/* Fast-fail until the guest first enables the device (SET_RUNNING(1)).
+	 * Before that there is no listener, so queuing is pointless.
+	 * 'ever_started' is never cleared, so once we're up we keep queuing
+	 * across later stop / CPR-pause windows.
 	 */
-	if (unlikely(!data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])))) {
+	if (unlikely(!READ_ONCE(vsock->ever_started))) {
 		rcu_read_unlock();
 		kfree_skb(skb);
 		return -EHOSTUNREACH;
@@ -640,6 +636,11 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
 		mutex_unlock(&vq->mutex);
 	}
 
+	/* Set 'ever_started' flag on the first start; never cleared, so send_pkt
+	 * keeps queuing (instead of fast-failing) on later stop / CPR pauses.
+	 */
+	WRITE_ONCE(vsock->ever_started, true);
+
 	/* Some packets may have been queued before the device was started,
 	 * let's kick the send worker to send them.
 	 */
@@ -728,6 +729,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
+	vsock->ever_started = false;
 
 	atomic_set(&vsock->queued_replies, 0);
 
-- 
2.47.1

