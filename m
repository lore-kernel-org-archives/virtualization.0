Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020092.outbound.protection.outlook.com [52.101.84.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B954477E6
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820804; cv=fail; b=oK+6KJM5rqZ8uvGttc9uH6EbAm7rPRpDayIkg3Zac5LZ8sE8OtqJo1MqdGVsG+1dMHBTfgBuOOgEXDRmqM1oEKRUSa3TXzN1L4Aljtx+RODvnYf994WiYipnBEPUiOd4hKtZos36VbLR/qJAUhhRkGl9N7Rq2I3JghafdYYaZyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820804; c=relaxed/simple;
	bh=x61YAUgtgy1qQUFZ9p4/3qcV4aW3a8WzWzDLvqvQDV8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=vA7LxIBrde7gFN1N70FUA82/CLWRj7j1pORJER4Co99/keZSDt9yRo+780MJ5blMUys8E1gxpPaXcWHDa8w9TN+TfLrDsK1HV5EDDHnPvj1QARx7Ht5rWFoRIxroAm6IQXJIatHfI5hjk4ow4nrMS4usLMgsk7phu91oDti+n30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=HfUfQBUP; arc=fail smtp.client-ip=52.101.84.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HfUfQBUP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLWdWmtJ6nUwL+yi3aws65gRvL3cb7bfJGaKl1dpP17zF/ELjSfuVR9tTJyf9HpHDY6KyuKP+e9vupHbMPBZ9GdvWL+IuNJNopa9YEeYIL9j65LlMsBoGFTnqPqizYFcCQwi/qjRFSyXJkiAy+/Yd5SPFN4cvrQwJipSdvQ2VJ+3c29u6kYUXubhse2uFy7+IRGvwQAhNes5OgTWDQdD9PVYTf+gS5qdSUbLUIbyIMrSQ3VXag9dg8ub/K2zPeA8Hz8GAsMCKxhQG47KTX9GFRhNHnUYnrfMdofIf3ehoOw52c47GBPGyUG6JjEnRh8CzJUxq196Ud7/da6kaIFcXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qg81drHMS1r5fyWHTv6/E/7ab5a6CD0XWjPb9KFPpsA=;
 b=FL4jYgn3XnsuDQF4fxT6GbG5gbEppw9RsXPTkQU8lLmF5rp7VrP+N0FuGfMCcHMhRliWfKo0Eu7aQsm16nMm0IXZk1FCpScBTjqvjpGOqt5k9CnZngTEdq4UjRd7fewtPluPsp6CWqw0mmuevHfNS6PizTh0i3w7sLMoo4oXsrfnjqmHVw/noAVnFHWG/tjYKeDIq3zADXoVVGgBifjsuCPn1R0oVbkOpbfEpQe6DOG3ra2xN4OaEaVmosoi0+npTpqMEZ5julr/1iXdJlV/6tmfO/jWfgNpm2cAhz5PbSszco6m3DizmagcA5mXfJcW1sB0+/9wfwn6/DSCPiW0dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qg81drHMS1r5fyWHTv6/E/7ab5a6CD0XWjPb9KFPpsA=;
 b=HfUfQBUPOT9UasFzgEc3PamnWGbZN0M++y3Fiv0zGFecsw8Z664tAps48bjUi9lkNVZWH4wuBwV2tzZ3cz3IO1Oa1f7sxJbfdWCNYw9CAFIu8Iwqk6eyHfUVgUXvwYXvgm7CDjFZzrg2TDvrjohgLA1BKLcr9GNeGcF1RY7V2xIV/99fI1LgKSdIIZdehcvbmqIgLZz0IX/u1IQE057R1ZZBKg2N9h0ZKO7aBu1ULomYQDXH4Dd9T6w99FjxWKlojwo3VpXsAIGOVEe5Q9IZxoTNFdnDetcE40lURhrycnrKmHWiklD6lcKocyOeIZqb74AQO5bjnEX7zUDKoQC3qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM0PR08MB11702.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 15:33:19 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 15:33:19 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	sgarzare@redhat.com,
	mst@redhat.com,
	stefanha@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	andrey.drobyshev@virtuozzo.com
Subject: [PATCH] vhost: clear vq->worker under vq->mutex when freeing workers
Date: Thu, 23 Jul 2026 18:33:10 +0300
Message-ID: <20260723153310.745855-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0078.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:349::16) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM0PR08MB11702:EE_
X-MS-Office365-Filtering-Correlation-Id: f4507207-4e2b-4b26-a50e-08dee8cfb8b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|52116014|376014|10067099003|56012099006|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info:
	xKiN4JDIDY+CPVDXPMxaBE02OmkyjexFQ1QaXHb35da+Bp5wmhvLUDUImII6ut8NcDjsac+TiGZ2CqLuAyNuDQHuM7wsw0fxXXiyga/tisqvFWlHLNluzhtOYDiStjFZFxYvjt0qo4amaGdhWwHPnl1GlLPHgou3zgHvLnEzxCBnIDbF03Iwmi1SVvIKMEM/QZOyCVxu5wHh9DnV7O7bd84Zbeh4Q28YMktIes9HDU/K1mFhOjvxYuCEvSQxBa50Ml/M+7+aHDPyMzjGXRIs+lfxLJgPiNR1Ine8bpFFEpy7tLGYZQIj+qWdfOSaIidTLbumY3eg7R6uRKiY+7ZbkueFQVIxPK6Mq25mIO0unSYOJ2JWyQPsqMmRqDx44wbdWoNzqNcCKW+JRq1w8ExegGXD/NPcbTBDtF2/nFiCWeimf43yOIK4gyqkLuc7bvQG0ZYEne74CPaki/YBsFA1qzZMvgYGfUf1qnRvc6MLgSnzQjspfIrvBYvRgKjeCAiYyNhN/bvh3Zs/rgpU86ZV36C+KVm6e2xVJYPQYNkEMSk6NImXz+4VbzboiSfepM1aiosBDGVIBVj/BPmWiIfxciZXOmxxbS9d3Corkxo0XJ6hxrl7ya/efPAJ2B20ZpOFo0GDRplc9fDxTTZnnJyJUIxXHUjtusts+yrMaQI6DjnYqlqpeh2upXf5qaG8LVRJnAtjWGOV8w2JFTBY1jJPgGvh1Q6gEA92SraAB4AH6hA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(52116014)(376014)(10067099003)(56012099006)(38350700014)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GWDgtmP9Wi95Mup8MoQfsil0Uk8NWig1qWZsEAOJEb19lSGTBd4qkl7uD5yN?=
 =?us-ascii?Q?d4laNtdLeTGXyEZMrzN/7MbiBzbpKKguzq5fNCJXUS6WSBCm2ndHKSQnb501?=
 =?us-ascii?Q?tNI3KBOfsIIHO3SCldq+U7tjMh3964cBVA04fSi25OI/l6+yoBIRqLH3BMOQ?=
 =?us-ascii?Q?pGTIaqrMx30NrPVJBkL/Yz5hfkjJGkMKNUuYumS+TfGD8k9hOOmeeL/ixtLo?=
 =?us-ascii?Q?WJD3C2t0kEH6vFvwyCruRMdWY/8LniUoRUrT1wn3F4wWjUOhb/ur73dZF6P1?=
 =?us-ascii?Q?D3NW4PwqoG6AgFUimyolosC4vcCXMjzufrFHTqo5hPsVIMJ34//iTDZa7au4?=
 =?us-ascii?Q?FRnkg9sjrkDC8pFbV9SzZH+Nj/Z4JqLJqABkvXenPh5NJNMYuQwvaLdaWuJN?=
 =?us-ascii?Q?OoU2htmfBX7QzYe0B1n4ohxgVmR7DxbmE0Qu822oaTS5G+1QQlZiQjibBQbv?=
 =?us-ascii?Q?pk3bGTAj0nHWZljYXdPrS42BTRHH4JVJhLpqypFhtknlUIT+gnLfdyuE0g6y?=
 =?us-ascii?Q?kwzklUX9FqT4CKGSjQw/uUb3D9g1c+65VH5l2FZt1blyh9O2Og19IuZgaHra?=
 =?us-ascii?Q?e/7CdbUr1Sq54jdideMn47AtNL4eljNhdEBly+BAUub/g2vRBv30rySzyQHW?=
 =?us-ascii?Q?kytRB2hjzZD9N2P0wucwApLopDVXvW5LtnHwCf2bUCGGPnhCtIM6d/iEgQi4?=
 =?us-ascii?Q?FtNvB7+v3vmbyohqObBGcWGOXv0FwqZ4TPorCsGmMbof0SmzYqco5Pe2UaXf?=
 =?us-ascii?Q?EUyDUywCSlpQrUPrXMgxwwQ05lke8v2KMvf/u/o9+OKkokdLIQG50Ui5FWy8?=
 =?us-ascii?Q?apuZluEQv6V5IN1ZF9nikdhdfl6OsFY882ctslgf/bC8gKy1dlWq0ucA8jNG?=
 =?us-ascii?Q?HLxenparFDeDGn46UxmKZYFtFZwx6JiE/g/SQxY5l4BliHnADKIi2yj1k4Ch?=
 =?us-ascii?Q?69FtD2AwoTbT8WX4RjFSTmd/jYGl7lLlEQCGAcQw8mH/XQ/EA5mnSFxBKtXC?=
 =?us-ascii?Q?kmow5QrapKokYm0pDmsOSti58Ic03fIVEi5ddk6qgOtxKOGQFZHGzm3in8Qw?=
 =?us-ascii?Q?3F+OJb+dvU42Oy+szSW9t9u3RLRhqOm8Sj8C+y373Sd17Y8c8ZIOa0DVs9aH?=
 =?us-ascii?Q?8y4dvXOa+Vz3qWu5/kmxpiZ9PweVSGInI4twl3lMgyrE417TOg5ju5xxaIjo?=
 =?us-ascii?Q?evm8cEMgr4BdeOxKlXkNhouN9PjbhJmHfIJBnYeRWxes31ujEQs4G9HfNlFZ?=
 =?us-ascii?Q?96v4Z+CTKSER4ppcfBk1860pgR4LiJA8JHj0PXb4SEoWzH6xrDSUMOoyzKE0?=
 =?us-ascii?Q?2uG/mNXQAghAhFKn6AYwfS3BGYXX/OmJNKJRgJhs1UZgxstSGxPNc5uWU0F8?=
 =?us-ascii?Q?1fgGEVVdEaxmAzpM2EQL3JUL9grIRRCz9DY6+/y+Lq6E4SGmJVCQA/nhhmdW?=
 =?us-ascii?Q?iU58RAM21dXYrZ1xOo9Q7E9EePoCMU+MwC3K5vpauRhNmqnQq3hMBaCf79bd?=
 =?us-ascii?Q?jRnzHCQvb8EolZo30akclkx3MjplFFhDeum1p9YQ2/ZtaoqqHYe86OHzbXvs?=
 =?us-ascii?Q?rA+lpCwa7D/f7EhN8LP8MRRXswzljRP+GURZXBUalfoxzweULVOQ7P3T1LOn?=
 =?us-ascii?Q?mtQJpihyjhrKRJ7HNyb9UPXAjEkWN7mtrkNF0gAgDPBIKBPc9DJoABGVijV6?=
 =?us-ascii?Q?RbSBI12dBb9j9X/nyIUOuUIrLyGS1lyI6Vrj+jaizzktyz3TLg3CsnZPeaol?=
 =?us-ascii?Q?qYO2g7xtarWdURgdH81bv52G9WuNFOM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4507207-4e2b-4b26-a50e-08dee8cfb8b9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:33:18.9559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9a6AvPthaRJt46E8DcJWm66CzthsbbtaWEfdvSV2Yc9MraUTN0gGHhB+X7xRrJiMOxgxFy4fTyDwSWPx/PslvP/NruTV2+F4ArJmM7DWZN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB11702

Every other update of vq->worker is done under vq->mutex - the worker
attach/swap ioctls and vhost_worker_killed().  vhost_workers_free() is
the sole exception: it clears vq->worker without holding the lock.

The effect is harmless in practice, as this only happens while the
owning process (and thus the whole device) is dying, but the lockless
write is inconsistent with the rest of the code.  Clear vq->worker under
vq->mutex, like everyone else, so that all writers of vq->worker follow
the same locking rule.

This issue was found by Sashiko AI review.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 drivers/vhost/vhost.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 4c525b3e16ea..dbb6cb5eccea 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -722,13 +722,19 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
 static void vhost_workers_free(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
+	struct vhost_virtqueue *vq;
 	unsigned long i;
 
 	if (!dev->use_worker)
 		return;
 
-	for (i = 0; i < dev->nvqs; i++)
-		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
+	for (i = 0; i < dev->nvqs; i++) {
+		vq = dev->vqs[i];
+
+		mutex_lock(&vq->mutex);
+		rcu_assign_pointer(vq->worker, NULL);
+		mutex_unlock(&vq->mutex);
+	}
 	/*
 	 * Free the default worker we created and cleanup workers userspace
 	 * created but couldn't clean up (it forgot or crashed).
-- 
2.47.1

