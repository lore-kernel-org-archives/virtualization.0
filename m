Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020130.outbound.protection.outlook.com [52.101.84.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7581E39A4B3
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542995; cv=fail; b=DC297MULRigTXcZSLTedXuq/8buDbbbcUyXWMclPUv7NKHfWhMRoxMgcgJUNCKZ1OJijMCvGXUX8Nlky8jS5/851pE5HjKWnOyrYH0jsqMl6das8LuUAajeFdrH2I8YfLFLsXfZjoUhK1z/Np8t+PPZ2S8Nu/u0IXKmz4al5JSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542995; c=relaxed/simple;
	bh=ydU+oXAsuhWrk45lruJ9qpp+PozOdICdjCQBRWWyQR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=grvL+qQIEweMpLIKMpiuUTa1af2rvD+kO1a3SfBwY5b/1PZ2I3aNS9cg5+6+ktQYLr/LDA98/nvA47g4VDr35Z1pzpdF5wH/F8HL6VCbsS2WnFoXQJCGBxbvX/CIyqHKScg48PQ3YAcZ8xoyy82gZfqFvcuvovsDnkO/0MHKK1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=Ac4OcPk0; arc=fail smtp.client-ip=52.101.84.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ac4OcPk0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgm0Eevze4+vVyqlFnb8Xm/wMh/vIyjqPaS+1q3v3sBJSg/HqvFoo5aiLWmvVtM29RCFn3gD183rTpxe2NAf4criAKUO5bMP6fT+OP9Gn6lttNEQBeauMsPTmuojyQGAJFadTkk0H2bA0aDTV/LL+0cVNg93c/NAifiOJMDFZyDdxz1ULA2UJB4w9hE/D8mmGLNnmsHGQW6UBuUkQGKWLQODZgW8byKKcYyv2W5TXXmMKXxkzR425fU/BT/Sw+nFRlnbvSl4fW9Rggmac79LphNz1i1Z5+LOK/cX9GEB73MsFLw+xuN3t6CScc7VcXuIvinP0xQDdgKmECAnoO5JzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rMmVOc6DiwI0NQL5M8bhoO50mPRicAqqqRFmQXakjI=;
 b=s0QNY6VbcYgMFos07rlwz1F999vOLbL/5SdUH1ILEBoweKbPdY1a/w/y+DRtMEqyWZAv82QIaGzKGIn29WyICkcLl4/UJdyzCQDUEa4ep75eIFYtB6pAMh02avK15fK3gJfSXichA3R9Z2rRyhTnyK+JoFewRP6Lfz5rVTzFgRPnO7rit3797HIQpaGALzl8ak8WrXRB3bociUzEX7ywJxUOeTFZ8vV5BF+nDchocIrfvVrlFQi831IsGhVaHc5KvixqOixyEg2IU1omr008yBb6yGVVTbyTCTkTyjRn2jZdZcIsj0jIhVpjpyjZYa6jev3RssRjobTE0wcH/JycXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rMmVOc6DiwI0NQL5M8bhoO50mPRicAqqqRFmQXakjI=;
 b=Ac4OcPk0JfSkXA5DShAUuowlFwXt0bHcJYsnGyUMzaUPnRUf/nm677nVTfoMX8J8hAN1447tHD1k4SBd4lWYMxcABhJfF+QL4Q9q1TWyDEAui0X4l97VKQa93X4DJBbtZrQ5y+B52GEDqgN3ViRBWFO7hTfBqoSCilKmUhLRjIFbuZSnbHQTtObYTGvieKQ9uT/znVMRKB7X64JPycQ/MmRwXw9vN6GDyMB1Db9bxsNIMORGRo/cUjs2qtJaCstIiocriL7XyEzOquEPPSpgWPjr7jwsL+9o+XP8woXNPzGUS7JVT7O1q+j/jD+9t83dOobwTkhqyh60SJcpZpLLJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB6264.eurprd08.prod.outlook.com
 (2603:10a6:20b:29a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 10:23:08 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 10:23:08 +0000
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
Subject: [PATCH v5 2/5] vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause
Date: Mon, 20 Jul 2026 13:22:38 +0300
Message-ID: <20260720102241.371610-3-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0055.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34b::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 4026b682-f688-4f71-71ab-08dee648e4a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|10067099003|56012099006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WEpNcvWmQSZRqHfn2iDKlXccgEwq7p0AgO3GvqZdCZaYb+tmUTxbGEDEE7F/9HVEQRBQ0zhkW9bPm48pC9mxHpt+TsCTJ4EKYEOeEud/e2rUfBAcItmht45lrwQseutBQAPcNcjmY1eLTwEpZAlattr6fUW2bZYPNm8Udt9NUx5NmD0/CxgMwJQSq9/ZsZ5DinLDv0sEAdc3SF/qEBUuUOb2r6PIh4/gLESxvaLeNYGkn0r6SU2WiTcmPq9IDNkj7pY9yPWmhc86+AkmN38TtLlKL9DtOWfC4J11HGKDGfTE/4MuyyC+OKzrX9M5giTIYUfHS5IXN9ee4fJ1qrUjUJF3VZAaG4fRNRQbWenEv+yIew+FGFzcTR5rY5xHnPxCT4haFRddUBcXRo3ssF+kpNHwyPbkguxmSf8Vxo4/D6DwMvPHH69VZju77yShwz4dAFw/5kA1Q6fa5+WPIyNB9rRlp8M34+Q4KkPo61+0/7u5l9NPvln0kzQeJHGqSl+CN4MCXWjZ8j1rl+fwtlklO2Urw9RclCpKPA+oiFcbYSzKv/E3VoEJ24qVDwCkJwiFaZ+xzDI7GeGZcBSkpZC8tnuDGwZms2ubQnBjtqQK+4lb64R5irumqclTpJqlw2CR26K8MXV0JazWhFdPXZig3kUnabkH9Ws+1UkajC491C3eS+Sw0jr1smeCdbra+E+Ss9SqBYpizjfKPLtuMeaVMaFT1oDN4JIjJMvt9SAMMa4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(10067099003)(56012099006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e4uMZieyMuR7uMFK6QwupdbpgNNVinV+0i+Qs6wWQG3npkQZr7f6YLBcntjH?=
 =?us-ascii?Q?vs17HjqTaNgVFwlh44nqbsNsZLx6Of86DKdWgj9Sa4RCZYb19rHF0ps+52EU?=
 =?us-ascii?Q?UY7kmg9L0Zs6PaK2Na7UV+4C4dh2XadKDBVe6SnWI0Duh5ZqVnuXR5de4u3P?=
 =?us-ascii?Q?JIpqdRVgFUAV8uFYvE6VN7bzjcU1IhZ/ViR4osK0ESLI4i3fbEXJAhKct+H2?=
 =?us-ascii?Q?kwnC4AAKZ/cbHgS9laxw1PAhut/wlUj18FUbaVNIatg4rayjPdOgXEGzZPEw?=
 =?us-ascii?Q?0pidEeMoqewOrlQCUi5p6y6cviFgEk3KpTjN9/z9bvztFosOvX2Bck38KkLo?=
 =?us-ascii?Q?hZs4JADI91t4FPQaOE217blVPqopXq5KJwp1Up72s+9B5XDbHgfC+zdfVDgg?=
 =?us-ascii?Q?XvORrDe9WhXh0HX0X8ju4ZFffkaLwDoSfyBV0ZZLjyWjmH44iuzsdJIBbxtf?=
 =?us-ascii?Q?QRqdf6LVg0YfTYe4p8+7cldtQir4GgvLkkXz48q6QQwKR3k5rXDXRHPJn/iS?=
 =?us-ascii?Q?gI0yY6O3aZbCHsplgdjAz3GocGButtU1sBhY0r9v+B0BvYXy63VsnIFmAxHD?=
 =?us-ascii?Q?OE7148fRX7V/1MfwH582yCj2H+06pPXtswBoI7tiH7cv///BPYLltbYNOYg4?=
 =?us-ascii?Q?YXEb+akARq5V3kznS2T32kB3aH59OQH7euYXaogcj1XFbn6o/tEy2Q99EhLW?=
 =?us-ascii?Q?i8nA+KjzbKmVpAiJXLQCNby7Nk9beNyKZWG+d8s6NALLniaZaqp27o47N4ab?=
 =?us-ascii?Q?KRp7RyM8mUvNsUlVCTEAJWnfbO+K1Ap9I3PeM9gf3Ah3ghSe47DVo7tucGvc?=
 =?us-ascii?Q?5IwgDaT3DBbmJLCkEAzE6RYdK+MjsE7bydT9+jPmJ4OLdvRui26huqTSmui5?=
 =?us-ascii?Q?yWQSHAD4gpuhzpPLK7l7c89zrEsAe50e9p9u8+JFwRy3rFGPq6j8Oq2+BIbw?=
 =?us-ascii?Q?B2U3iNY+EVZ6sxuExnqt+dhpY8tdkexnAy7IcEHsNo1iZrJPDBvP/+fH+ZNV?=
 =?us-ascii?Q?hq6lHVNlS6GFQZfDnBk/DGIiApuEX4SlC46A84UX60r7RrRWb1z7LFWwtXQC?=
 =?us-ascii?Q?fRXR/RuRPo9ZR5A2O3n31LEvIJfZZElspGGuOCZwaQbQx2/4RXIIi/9N6iM1?=
 =?us-ascii?Q?mdOqw932pfFmuCx+ULqhTVSo+eWKpLIieopAyglMr6PLRO4F2Giy4VEfArI1?=
 =?us-ascii?Q?iLgggx5ylzCZZMtX1v7iNwoV3SrKWQvlJX2pJ9naFxOid+BsO9/0eIdc/tH1?=
 =?us-ascii?Q?f6Nl/KcXk5FjRrVLA4VbUGbzDhmUZAF6HSQLQ+PxdxasVZ2xkhhHOu+RDx9A?=
 =?us-ascii?Q?mKOrrEw38aIg2TNFE0n648wD8H3VuJHqGRooEp5BDrsSsxOq07XU2l0b0BMr?=
 =?us-ascii?Q?87R7I4KeD4TxSoRtcT5pt1IUvGy3eUWX+4yKmOT5Hy8YkBxkiwtsqPuuI+zp?=
 =?us-ascii?Q?b1bUqlVdV3QRsMlXtzu/4CPDCESQiwTOTdQ8AUrLEgJjmOkWHX1W0M53VaUx?=
 =?us-ascii?Q?zhigpsRJ0Xg5rbVKUUniQDsFqkBK8J2EBp8DngfYQo1flqFzHv3g6eh/L5/a?=
 =?us-ascii?Q?z7agukuOcFygGHOCTvjT3xkuK4NQ40PoNzYVM882dN7JsfldqvSEIeMkX3xd?=
 =?us-ascii?Q?SGfqCeVNDROtNNqu1x7quGhEtcH2tXE/+CoVL9vbKkGofLwgZzAwewQxJ8hT?=
 =?us-ascii?Q?PH27fgW2HYRxszEZwnRYV5XmmEEymhNZxJk/3wIm6PNh/wyNXHpdaYraNY3U?=
 =?us-ascii?Q?FxM7D0iriEdtUbn0q1puHhOYB76S0Cc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4026b682-f688-4f71-71ab-08dee648e4a9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 10:23:08.3248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MHdRacMsGIDVcTDCIrkyAqBSTxAhZAYfB8p02yntxGIZOKecCRxHJxa4EGn6CqPAUw1M1Up00N5t+jUQt9z7rL/A69kLmaW/Ic77ipWnF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6264

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

