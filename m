Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020130.outbound.protection.outlook.com [52.101.84.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2D23C7E13
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 10:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542997; cv=fail; b=IC9jbbFR4yX4I2wXqBzPB7hMYn4CXM5+gpKRvHqcDd39+0jO5eMSERJ75AB5CrLHHxDUn0ammBtHO42udcZJ30aFHRixPFenY4b8eFdbU96t2d3WQLgB4u4yZmmtE5vOqWJhEWkMbE2y0HmnlBNZSvsIx6gh6Kj5tLN46A9YqC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542997; c=relaxed/simple;
	bh=clVkNMWQu/An3QoFFOUF/P6axkRskmAfUM+Ff5KcnYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d7u6O0Pr8HJGu2+jB/cvqrcFMZQ4Dlo/QRj2KUdfB53J0UJMTyIfVR4thFp5iCWT5qK9OXw2Ri7nq/af8Ajsrged1AtBkbh3VCCVUwx/vbeOsVEZbvXYbaadPMqbJag4mgWtI/3WBSy/isaj/VOmdtz18w/FDKMzBMk/m3kM5uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=loq123Y4; arc=fail smtp.client-ip=52.101.84.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="loq123Y4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5lUTSTbxlYFud4v/OmkEd/6h17a2giIIfBE/yuJlsS5GpVdM4OawuUSi/tiAQ9aAYxpaMbQ8SsTJInWaBV/wgK2iU9A/wG8uNszdZIZI5nUF26+NoS+PUwVhpc7nZuo1TnEcAIxiFJd8S9JzU8urwJN/UZJFLUiLIuTVhr4nMaXn8BS+oxuD6MfDft6FtPUfugIYPUJMVhRwMkh/7lTsioF1H3ojulFnTxujTpAvcKcRBmdYyhhlvQ6ze46y5ZZ+BZGNCG0IjWIjqzG5A/+5hH2MqrGGcXJxv9Z5cKLDQefyQQQXNTBfji/MhqmEauKi1vfm2qsmoacN8eBYQvvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lFori+rJNvuLSDAetygN/oDBgfCbIYaQ+gXkzGPvFw=;
 b=KVdqcozo6Mn3IcrgQ3jKHauGx6naFqvllMNJI/fL8PgratoVNdrHRqDxDGDh5Gn6/HriiYtmaZ5t1DvfBOvN0icc8kWy5FLUdTQjrwjRLczQe2uKF0/P/ZusKhX4brs/GYySely9iZdXFD9SO+eB3YQteCtfY3HmKLeh0bERq7OXeo+ztq1gLekteqO3pESdZkir4EQII1Z6nN7rId7FCfEbi3eepUSX4NWlziHoUcSu+Z4K07NE7Ty8+EseMnbAJ9vmCy2Y3cNbsChSW57k1kzgHcI7dZUo8/VvkqrVNrDxD8QVOu9o7ezMzzZFCPvfwv7DWWOkUZvzS/7H3ryBVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lFori+rJNvuLSDAetygN/oDBgfCbIYaQ+gXkzGPvFw=;
 b=loq123Y4o9G4+5rP6GiIQK60kt77ABnAb58CrUXpzaviITA6cP6IFwkld7xZkPPfowa3QZ4l3GVuqhuYABrMMUH63hrK6pRcLCsYNYoa8jdsViaiD3hjIf6fUVqnbRf9nSBRMlSfzgm9BN8VcYKGGWrHXzHCWf74OojvTwyOVWWRUW6S+dRL1kK0lsDZCvrYi5ziASWlvwYsFOvJVRoKniAeqEqqmit5BF/D86h/dbKBMZ33mB+W8J7eGrG2dEiN6DQUdJ24BTkGLDvHWGwcQTZLL1UfNjR3swwc03+Y5Gbm8uhxrILW64KkwT2fn921SuXZ+T4KFkxn2gTLM6yFgA==
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
Subject: [PATCH v5 3/5] vhost/vsock: re-scan TX virtqueue on device start
Date: Mon, 20 Jul 2026 13:22:39 +0300
Message-ID: <20260720102241.371610-4-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 55f438ca-3aea-4af7-07f0-08dee648e517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|10067099003|56012099006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pZmgVOPRdQEXvuckJuqg5DQZKHJhbiNK8RDzhHJJ/N9XhHBCEydWuEXY4HgIVXzzijENLvSdu0xstemIsqlezkvjbb+2WjVr/cfDGc38qx5F+HktN+Rg3cMiSOBNriB6pqHQdEKa9/p/ueeSR+NaV2asH4MvlwgQNTgOZpZLToG/J6ITVBg92Q5cGtN1H13qtaGT29laEqNjjKzKHIYQFIPrlbIiNE7VyWIzSPNZej0YI/qMu2OqhHU5ImfanIkrwJq8lkZI1TFE36KdObWaXFISrBKZuxx6DZWU376rPbRWsYZ7Qeb4rTbYoKke7X3wS3OVV8eO3NmLNfp4tsIDV/9SbgNEG1gPPQP5AzGhPuu342tBg10bd1wG+UJVJDrpONE3U3KbeWmLX3i8tHQ/lRwhdQtFhp9eWwV9/m+2DmmsBDf3BX3xZ1l6vObGHZce4fBUYhx5Ajpu7OoLWGk5xn1iKDBazxTbO0h9tl50dHlTGA3sFeRZVZs+CFN6NQ1iXXTeDnz46spRZlY2ABAQuTJ8Ob2r47kxeLLlWaloN3wD4oktucEuRyG3ZGf1GGtQp7f7JBdYUM7Y7yS29mLelp3F1ntDmqZ8xVyh4rRU4UsTKy3t15+4LrzLceVc0W5vdJerodaDcA2/HRpUYBtjWtQ6JKxGKeDlsMo9sfjNHRYRXKCJ7/pGk6v0aWdUGTH3O0wv1xV/ECqY0Uy407J1tta8cosJua7e+ABtA1aneQ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(10067099003)(56012099006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jsErJbrEgzFZk2Y9JjHlGiAjfxWaytcz6b1HR1AMONCVcafJBWbA72W+a83E?=
 =?us-ascii?Q?ryiNM6kEkUvX7mxL9ZOGYkm9lB0Crtn/C9o7oCn4ohbr9+0Dd9JLWTYJTYh6?=
 =?us-ascii?Q?jTsQSLWaHbWlF3AzE3NhWQo4JLLys9iwSgGVu7ylVBOjColvVN9wtYQOjGmY?=
 =?us-ascii?Q?k1cpKwGaEkn8N+p/uUGdimYvkq9ahLoFMNJBJtXoFY3AUKO03tP7bGLKKc7K?=
 =?us-ascii?Q?Is7lfaOskamFu6jGmEAhk2sCRm5gvDNuyGcG2T7s7ecODcN1CD+3s9K8THP1?=
 =?us-ascii?Q?u3NTasGFnf5Ogl3vQlrW+tJD/tzmctpbzTpIBbpQPVFdS9tfgfYplR85b4Jn?=
 =?us-ascii?Q?InxwWN5PifeulnLXKIc/1xtL2m7yZ4wOsvJRIo9KS3v2J8E5V1ioVM5jQ28r?=
 =?us-ascii?Q?r/J2ohSMr9XKXiPyTrpw2jNdno920DIhRVpSF9uINfGjYTc++K7CLzR4V7pN?=
 =?us-ascii?Q?U7nTDfsPoKSfB/c+0LyMK6sb6lX3ZmXoGWMS53jxTs+61eJXziYb734azrKe?=
 =?us-ascii?Q?BAt1CqB28lq0iA3uiZuxOTF6TEnG5cLtT3UCyQ5Li68G+byWX3bu5EO+P7sp?=
 =?us-ascii?Q?9OLgUFrGXv3ck1EQXN8dCvxqjAv79AISqbQ859Qu6GUbTJ6WRRrHiUe1OvTu?=
 =?us-ascii?Q?G7cmTlE2cOFSeyUd7+X9LAE1Id8x+jdcmTcIxasEhbC4rkO/ASTU6hAM1Cng?=
 =?us-ascii?Q?sM4JaGKtqn1Enn6EH63tQvfB2E2Gpu3qc0ft4kLY83KEzEkDR9rWulaY/ogw?=
 =?us-ascii?Q?dHEqxMrX8wvzsi+yoKt864Wff75DhBQrgDZBlClNrkj3LNDgGGruxo7TI9m+?=
 =?us-ascii?Q?S508tVyDD8qAPWm1ypdBWfy4KkDMZKUy1ogCsvhxOxoFniG1TTsqf7jEv1QG?=
 =?us-ascii?Q?rjBU/sOPLZ/DVcKW4rQdT59md0YhUpft94xOE3FchK+LhGpMR4QBu2Oe+RyX?=
 =?us-ascii?Q?rO8rf6mEWnD5e2lU4L27z3c4KuHOqfDm4HDH+9it/7AFo0bzeHMGU3DoX8Y/?=
 =?us-ascii?Q?YN6rxyE6cIRz9cH0o+jcCdLm7fkq4fojkf25PqNXfvITQrKV93CDzdY2qoKO?=
 =?us-ascii?Q?U3ZgNyt6+lWslxwyCxXtEdlYEJGIO7GIosgPLj2RhSrWBqMOV34Q/KQcg4is?=
 =?us-ascii?Q?GlPvINCApZ/CyIGpFuHiHpeag6OrcSTqBrwvrtIPOiy2htaMRIkjPIzqwd26?=
 =?us-ascii?Q?BH2yXbfoT/btXNAl+MVo22Fr97Osc+hr2t2DqBTvh36zM3k7HYGBGROq2cIU?=
 =?us-ascii?Q?Jz8rIQBwwwClIYLwppqs/cMLPoGbHY8x72ASu5KYhffnAwPJLfgs6qgzc10X?=
 =?us-ascii?Q?n203Mxxeonvt2LC+6kh6TXhLFcJ6QlUTt6Ds6luf9ICfT2oUAUOzDwyBYiYu?=
 =?us-ascii?Q?RRpdjddjn+3afsr2/a3uDBeLa9f6bE6vcg8L/uIuwkPyXygglWqS9ojdZrZj?=
 =?us-ascii?Q?HHd3v0SYBocCBxU4KWdDaYeZvvBIxyDWjHbtDtf1t5EgNVZNUJ/EOMMUrLVX?=
 =?us-ascii?Q?UZ3R6M6nIOqVGu0JYgpiq23Si2g04p6hHJVQls1tNNynWlk3aoVhL+N3W5Cg?=
 =?us-ascii?Q?U3u3USz1VVI7Jg23YsjJs0mbozGl6cPzW+B7OhLq+ObbS0KFR0eXyd9/RrZ+?=
 =?us-ascii?Q?74wQYjWkaBUyIK+fa7+WvwveY6XvC5/5xUFO3M8cfzXaeDEBGnYbbmoR8QDU?=
 =?us-ascii?Q?vPsUvlAgar6ETN8WMQtjOr6ZBty431QTMJhexCkXObJxzTFp+PkZ1zWN74Xu?=
 =?us-ascii?Q?JFt45mnJsQ6CG8Z86JIciP7phkGmKd4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f438ca-3aea-4af7-07f0-08dee648e517
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 10:23:09.0398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdLq9eb1cBzB5YWOitmFiDzJsxLau9w5YRw4w8ShYNuCxv3s9NX4HanoSVnLSQOloV4B0Y5lDAIyOM7xkF97+H6zG1oIm8qwpTKLkReFTFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6264

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

