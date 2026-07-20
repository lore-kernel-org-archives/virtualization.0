Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020130.outbound.protection.outlook.com [52.101.84.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3373D8133
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 10:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542999; cv=fail; b=TdG2SqEufm+QR3V7DQVooyihYNAvOcabAI/p30MYCZnQyWehQAaymzUh/Rsj3OwEHYsP5I/CzCImddD6ZagSp3DNcls1pPqH36EExXw/kQyB3wvCJctqk65tkH6vlG3yf2VBCwuRHObJ9dNsVPnhC81UWBLenepQ8d6ez0qpHD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542999; c=relaxed/simple;
	bh=lgys8dbD7hERXyIaRM3FZCwyT6Rhx4mFh/TH8g6Kxvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YbKDep2CQjZJJSqLs354mbwc74iWorqwE8DVgxOazbK5Ln4b1R1J0Zi6tVH44sDDCxmYKu/Si55+HBpZ9kuarB3HttSCWx0IHOBfhvKDan45YfbYavRsI0eXmOdbRIaJafYxgkm1l9WLPZZYhoNBD24yowrRrsmfeoSfJ3cTFgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=mrPjBnBS; arc=fail smtp.client-ip=52.101.84.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mrPjBnBS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPuDuLnw4aDJE1RRP6VH3ks8s1GD7EwDykoDfiL0n3VvjVOTxk19A87uu+5/L1+gXJresdz8/dxKt638WVawKT2XMI/ogz73NXVIZdJdpW3cRe+TQaI4LlJPsH3sgfChWMn92LGzGNNBpVsMkCUXZUJcExo2yDEsklKbTm+W8NiKqmR4N7vGIAjors5G+iXCFqLkSpypReOiOQHTdzEsN/kNivA/3JeG+qS2p28nbgh9HUg1QtlQ6pmLsrTq/YXA0/YZou5duWwc6W+vqzfcZBzq0MAegfFJ4uexX2wdMHSmviG7YC7Xb5vxPl5nsIIC/IMo+RNDpqiiKpUjyahSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vW51SbnbG8ZQ0F6VS0lR2oqfOZo4OqMAUEC0jtRi+s=;
 b=H0DeX590XVuqPOrSfnkQvYZFkVbKjTlSrhY8IQfKX1z70QWCh//i5YqywqyA6Kw3BdqSKPafuBJO5k2AVWH0k0EWmixSIME+CzNxYDh6Y2FJ8utywJK2MU4gojkaX6Q4OvzGrpqoEmSmesmNELnPY0677oL+x/oYihTG6UGFj5CiXXBcfIoRYjSOnHqhpIretudzPMb6tIj+REVovv+ts8tXJBD0aEcXq87nI9xUzY46HY+j7NEBaxJQMjpCCYGzZpTODHdJg5OEpQYrpgH0ZDzYLfTRGFfaKX5Kgt3lcw/cFX+z2xU+VofTBIy5HTWSnAZHFqE9X+7x0+CR9L4sAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vW51SbnbG8ZQ0F6VS0lR2oqfOZo4OqMAUEC0jtRi+s=;
 b=mrPjBnBS91K7njTZfV+s8Jvo3PAaSpuS9eAoLbZnjVD1dqIdxFpCN7sXVCfLb+4TQyl7NHA5zv8yWAtdam3clVp0JL+ohSr3ERvL4kwf5TC21QJV0ORRsGoD8TyGxtv1xucoW83Um9VCzDuoVtjy0/ShXuh6Tmr7hlerexMU1RXgSgBFnu5Sq2t2LBuF8zNWaEM0l64SeRNtRmMeVkXp+jifCGOSsf5IQrtUvScmqqzKBUl2WnHe9n/LlofTqerj+1XhlcrjHRCMTuTRuGeit2epFmgd6oJ1kTgz+CYfpMVcwJsraNA/s8aBtOkLlrVVs/BlIWDyZDZ8mqcerYxFeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB6264.eurprd08.prod.outlook.com
 (2603:10a6:20b:29a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 10:23:09 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 10:23:09 +0000
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
Subject: [PATCH v5 4/5] vhost: synchronize with RCU readers when freeing workers
Date: Mon, 20 Jul 2026 13:22:40 +0300
Message-ID: <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ccae916d-cc90-486b-8c82-08dee648e586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|10067099003|56012099006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QH2q4s1SxndfiTEUMl7LOwjXU+vDY3+QvYDOl9URxiUr3b0c2KIYGZUHxgGR/lCUps3qsVMEcN7SOAlVlgYdTSJUfHjg5FAv3ae5SneE4HvBLsxC8V/SZC21LnLf3qUqEwECqWbCksG7dRtoKufuKVtwJXQlj72dxb/C0QOp68oq0s0sH+a5/tL1MX+MX/0vv3obSOI5h7tG4e6Zjg2lHHQDtjLYKTI+dwtOGc5uv6CWl5VHuBEEit2y/s2s+XA2BtluiEA1Yb8s7LvJW45sNmmtj5IO3YV9uYtiNMuZRGU6L4AFaZK+TPJPZ8n3+FT4HZ6cfpW0tokeK/Axh0Ix61B5Tt+rwLrp8OQZjWzqgdTay2CjN1OdutOoqMzceFHNA1t0ec1IV+opFRvoKBxKEePFuqEgAn6H24MOT/X7Lz6CLf0qoVPRh6b0xAT9B1+aksURkwOlTgOSzsZ+eGgA0JcIjrrvZfJ2c++zVLJNqb/MFPNCPshsHechZVuo9noDpfQdFRlSDTBGrQs/hy/uQ1FJ4rqAOsF7ijG+lWzud7UEagcseLHYLbuOOnLd4CCC+zHspxgz7INat91uwNXdnzWzA0oSbby+Puh7EXRZVsbmruK/dMYXourkIwi6zyj4weWECvHf43dmt08d+R35d5n2YxwUqf937DUYlyopA/7e2vNb2MappAvNzeu3ognXW9W1TROR7fNFAW755/Si0AflLtwM/DgcGB6A/UTV9zs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(10067099003)(56012099006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JPM7WzR9scHZ7EyDICNKDlOOxYB7DNi4uyd2TXmcOz7tPSchMi7syA+jlxVo?=
 =?us-ascii?Q?G7yc5dtnwCAwvjMmCfAbxtmV8YS9G9bnUD6wVWJFvj4tZclNoSCEg4nawmXi?=
 =?us-ascii?Q?2Gjo8KAvJTaliU5lt5XhebAUdfG/A9poC1ndCdH6OhMmvw91K7RZ8r2AUMp6?=
 =?us-ascii?Q?c6hIpg+UQHg3q+zdq+KtqVC1EIsD6UqpZc4VM8oTkMR2LZelqqXfM2qTt1MJ?=
 =?us-ascii?Q?jHC8UaOzIbwoYVwRFdS25G+WQDa66sVz2wY1AlqsCaqOtYeMF4C6p++yHMe3?=
 =?us-ascii?Q?QUDoJePuuvfb1rIKbuHznduP98Jw1mE3nYidemEoUq3ebPVef8kjefwbtL+c?=
 =?us-ascii?Q?TzmgTogxJm4cVm1vYVRX0mJWALAJ/ueNU2cpNDipFJaVHJQITQJf8oWTeOb4?=
 =?us-ascii?Q?B64mveLF3sE4RXb4XqR9gYxEHW3l79LUIAMKvWX67Q0BtV+kBP43e2hBsn+j?=
 =?us-ascii?Q?E0iJRsRtfp0+52tziR4HWzBHvdVNEAk9WeBf49B3PrmtXeXl+HNYhEAQh0Pz?=
 =?us-ascii?Q?ZKGXwbWf52IgyJ0UK9ulHi3/jE/4M+YQa1zLLCOYhvTSGcbgNOeBslVx1V7y?=
 =?us-ascii?Q?lWX3d26B5yfZiSH92aTR4+bqjPxMsoWj02u8JwlCRbBosBwAbO6X6dUlz+ZS?=
 =?us-ascii?Q?4I+eId8kdkQrpXhV5OnCz4zN913zInqqP2zhY+C+tkLWdC5lUJ71SiiTce1n?=
 =?us-ascii?Q?juHu0qNjfbl+gKiw9TRz8oraOfvZmWqJUpimOudPHogXMH5tUpEb7t66QYDo?=
 =?us-ascii?Q?zjiExurEFa2NR9leDMAHuJa180Yex+oJUC0Znop2SAzX/JxnrqMY858bpRrg?=
 =?us-ascii?Q?LK+jOCc3n6xDhgI2yByel+ZkPHL0ctbO/mi+o/SACcFs62eAM5FMDWqiqqeB?=
 =?us-ascii?Q?+v7MAxQhd2uKyJ46QdO0Nl6M8kuYcnFJVrmC9mcaaWNWqA/R1KsHLrSrlTqH?=
 =?us-ascii?Q?qvz16Z7ZrgwoACSD1XGnJeeNhQRFg4uX8yv95PX9FTia1l/8OSBX/i2wcJEm?=
 =?us-ascii?Q?RG+fZJ8s+DfC9+FH2AahHIxjXS+5jZygxBuXkrk5OW/sZy+png7xIpqsNRyw?=
 =?us-ascii?Q?db/XMUvhou1DwSpWG1b0KHady0BSERJeNy0GwbvrFAh4J8A/QEE2p91dYxmw?=
 =?us-ascii?Q?zuN28CatMi6cVokz1Ixm4kEONVWsAhjzxQgKVPgPXDe55uNm04gMKP2pufVG?=
 =?us-ascii?Q?0WJo4U2+MxyItz9xKHnva7/aB0eAKMTEACSY/UjOkNcUw3b6Bpezir35IdLR?=
 =?us-ascii?Q?uxTqPxikqMx1zI7Cm96te5RAhNiybuqnmudYFUJwLis2bhtZ/feLVpPOWyoE?=
 =?us-ascii?Q?hTxvD+qJ+l34BhaAw1QvygK0Z8IU94LKCgA7lZA7P/NM/EOort5zl7/6WxE3?=
 =?us-ascii?Q?/VoMUNqmSyVp+Hu/RR1ngR0dBqvv9LwQLK4amxC3HUMUsW/t+/kuAmmyWnHn?=
 =?us-ascii?Q?B8HMDASi15p479hI9Y2ezFb7zuPgP7A2XcQNqDjuPxD+QdwWfvDg4d4MBYIH?=
 =?us-ascii?Q?mQombhGClDV9kjoXDx++747clGGL+6ZFu5rff79f0xF3UEB2Rh8+pULIQNnm?=
 =?us-ascii?Q?+imcHFkNCizAHRhporJVdR1u/YnxsGqvK6AKfDBtCUEuzopGj+0zpYKbqrKL?=
 =?us-ascii?Q?QU9sgYqHhznVDVtKSht7t0o8nmhk6GQg7geYrKQebGUpUPsuyfSmnywqYZpQ?=
 =?us-ascii?Q?gBPxY/Dogh8XpgDPmE1RQwm9U4bEHOiBBP50xz7M4BamcL4FWcU5iyk/uht8?=
 =?us-ascii?Q?BXJ5EbPBbl1Jwby3LP/5D2FMjHdZr1Q=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccae916d-cc90-486b-8c82-08dee648e586
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 10:23:09.7833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCz/OeAP9UF8vLNqSbN03gOujD6oJGhMPTeZa9kAocRKp7X6UNmwgcfIoZL+RduAM+R4gjNHF15Yir7/6UCgEf7Z4ppJdZYdcnqtwzX8wHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6264

vhost_vq_work_queue() only holds the RCU read lock while it dereferences
vq->worker and queues work on it.  vhost_workers_free() however clears
the vq->worker pointers and immediately frees the workers, without
waiting for a grace period.  A caller that fetched the worker right
before the pointer was cleared can therefore still be queueing work on
it while it is freed.  And even when the queueing itself wins the race,
the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
future attempts to queue it are silently skipped.

None of the current callers can actually hit this: net and scsi stop
their virtqueues before the workers are freed, and vsock unhashes the
device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
before the workers go away.  But the upcoming VHOST_RESET_OWNER support
in vhost-vsock keeps the device hashed while its workers are freed, so
the lockless send/cancel paths become able to race with the teardown.

Fix this by clearing the vq->worker pointers, waiting for a grace
period, and then flushing the workers so any work the last readers
queued runs before the workers are freed.

Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 drivers/vhost/vhost.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 4c525b3e16ea..d6e235c25254 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -729,6 +729,17 @@ static void vhost_workers_free(struct vhost_dev *dev)
 
 	for (i = 0; i < dev->nvqs; i++)
 		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
+
+	/*
+	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
+	 * reader that fetched a worker before we cleared the pointers above
+	 * may still be queueing work on it.  Wait for those readers to
+	 * finish, then flush so any work they queued runs (clearing
+	 * VHOST_WORK_QUEUED) before the workers are freed.
+	 */
+	synchronize_rcu();
+	vhost_dev_flush(dev);
+
 	/*
 	 * Free the default worker we created and cleanup workers userspace
 	 * created but couldn't clean up (it forgot or crashed).
-- 
2.47.1

