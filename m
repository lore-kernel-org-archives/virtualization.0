Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013027.outbound.protection.outlook.com [40.107.44.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B68E2777FD
	for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508733; cv=fail; b=Ma+o7C79IjzZ/RyIj1pPpGgY8WoVfslpISyxMGlUVofFR6hVmkgXlTEeeuwd2mAszrfTC/0CZfp1TQ4OGrDXu86xmciGC4bKPPoI9vaD8djDRzrRSskLLAh94ybH/fM+gl5I0DNY4tSAVYFSbZ4ayaswaPs4dlqh0+AVfiTGDk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508733; c=relaxed/simple;
	bh=L8mXk6nGg3ghOgjPzYeflmlRFzXUw1OnPyDDWtTB+Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RdyqVyg0mcByochewtMO2LenUXHvu6HkEOZjqsHZ0mHqDrnt6RYuHlFk9Ljf5n1uUp63YguswZsA2hgdFfgzOZMkTTLGo3R5KeU6hn7JO7G2VlMoe7KFanuJZuAupgFuV2NLJ4eGwjZSrhQZqhFIXa2eg8H6Bb8tYzl7YquRFDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=PHWRUsyX; arc=fail smtp.client-ip=40.107.44.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PHWRUsyX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjJhBqAKB/wUbi/F+vxdpFDLDrlQ6j4LrA6a5kkds9yWWvyKaGpxBHFj+yVQqg7pjYIQEKdwAMBg4jeEKb33HdmxvkRpPqUCaZj9kkologeoNe2UN672AcBtbakBrS/FwWqqPEOeuNWgUsSAeWVSyrlPkZQCcwDEv4EZ2AkgNFh+e/tZ6DfHZtwgS74By3RaJjd0rUw6TVDgQA5USYEtI2GHu7+xE/5oWrT+qEVcdTaB0nEJLlYPJjRyjlxWxw3q0a1DLrQjS3K7O3tz1ufHzoEPEqTWJzDochpMieNoe0+hj8ZGPFCDGsDdpD71Tt5TfGr6kMpV2pynfei7l9x/yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HrNOlQr6gKxih8/Jd+SoWxTePw9dqvCLOl6MSBPqBk=;
 b=jqt1EWH1pYWmfBVK+8Gfk/A+ca7kKdUpCzno6whM168OKP4EcgJS41yldTdi8is9tAQoNJMn6/RCvYGTmK3nRBgqEGjQxX+rJcCURQ8WLH8sKq/cXZsH5qp6yyP4xG7mL44o14CW3lwLonksoeBouwjw0nKDBEWO0WiTFtK/s+/PndMupcxz4rfrdoLRp+XkzJqaFqkUKS+ppwerKsshBf0Zaj9iow4vE3asHJ+rszoRSdvWn2MkvxEs6JU7NkBab0gLs8esoGpFlARBjMHpOmJTl78fPZGASUI0JmMGTRCwDEc02DaUMA1jg3ZIKiGFNehiI4F2ymQ2CWQKuxfjUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HrNOlQr6gKxih8/Jd+SoWxTePw9dqvCLOl6MSBPqBk=;
 b=PHWRUsyX4LuFdkOJiZQncbF+t1AN5pXIcOGOBLmACsKwjQ/V5ne4aETN8ms0Y9E6Tmbbuw0wPpou+Tv5017k+I4l1fz0kymiZP9UTYJ/U4InEJLMGEfM+fhqnR0UmApZ8CyQ7ToTgAomovjTPUTZKt5RZ5cvoC6uvOWPYGsfz00j//gtMCs+Am9ZZFGmLHa0CeFNSd1PQw1qpFOvZBeRsv2xqgwd66PsdH6s7Wrm4MqxfjC8M0DfgZHfowIQEpaacybFBgZQlCZkY/l7mm0vfbodRQN0mz0xJV4f+dK6NfKfkBziEgepudrreu5Tijny/0+gTrHNCScxksfYmFX+WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by JH0PR06MB7349.apcprd06.prod.outlook.com (2603:1096:990:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 09:18:48 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 09:18:48 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] virtio-vdpa: simplify the code by removing unnecessary variables
Date: Mon, 18 Aug 2025 17:18:39 +0800
Message-Id: <20250818091839.550777-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0063.apcprd02.prod.outlook.com
 (2603:1096:4:54::27) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|JH0PR06MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: eb60b186-95d9-4888-3caf-08ddde383cdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cq7pVSpucG3fmEkHcPkQiAFjYYVhmVIEtqvevCBvtyDd3cYBN9OaVdBgpLTs?=
 =?us-ascii?Q?kzHcfFDIh8jlgxUoMoM4smZaJ1RgBelioAV+TvVouGkC3WLg3xjFuetfopXi?=
 =?us-ascii?Q?2w/E7NnsEJbS9cW7mP8A/hgnbwDdG/V1VYJlXnFfncoEF6scDC2SdaNMPmRM?=
 =?us-ascii?Q?Vb4EwfEvhDuvrL7mR6yRsYBXtDSJt7YFFS2rRsSGZ7QfA3XJfjvNKgC3AfeK?=
 =?us-ascii?Q?Ilonr8GZPP4Fb9Ri4JNJriqWlAivjEw9xrrilGQUU1SpHiWhKudw6cOhyonR?=
 =?us-ascii?Q?F9LhJzS5ZU6CvDoOCEtoi1Sm309RCzMdaVBpDOgRFsFvK85W8DPvgX8osFny?=
 =?us-ascii?Q?DIQ/S3Ragd+3CusGGGonnLGlSlqx8HXN4wXSylIdUIxj0djC3viW1pDJAM49?=
 =?us-ascii?Q?xgr16wIiSQUTdaevzvfvATMX5s1au9QhsQu5IT8UmtEU5HNf72aZmr9erWh7?=
 =?us-ascii?Q?9Q5uuG2lV9YkswaW0giOaZpWCmp8NG8bzfR+54+bN2favRtaohem+C0oTSwB?=
 =?us-ascii?Q?Ls/DueFbupG3Ggzf6X1tdxj2YvrPeI3wvlBWVJKI/rwOrULDEzhTDk2jl1kl?=
 =?us-ascii?Q?Vx2R+xfc2IA7KokU4ROv2y+nKShBnpaF2JjKS1UsJu0WpJSz1d0AVC3PmiE8?=
 =?us-ascii?Q?ejMwrOTfW6peu5tjn7IVrOdXXY8Moz4rrgSSBSWXM0sm9qAjWYzyM+suzeYq?=
 =?us-ascii?Q?yZZnBK0n9xxlADCyr64pKgspNSYoVOu6zBgrrvlFJDfk9P2J/jGcxh8wvTE0?=
 =?us-ascii?Q?SH/xieusBLzth7SB0hZzRcgG3wreC20/fcEousczV2GYxm4ZRpiGvez2npwq?=
 =?us-ascii?Q?wkqNDLtajVFOuiTSIIpUQAckUvDqNjio10kCwxPxyl44ZhtQc2L7GOlYy8A/?=
 =?us-ascii?Q?z3D4S27rR9N5gq/02RZXbFyKIrm8lavlH8n1x+gZY/JG8sPfsVx1he22ya3y?=
 =?us-ascii?Q?gXxKOn0rqFBd1RSpGxVHFWmDK9J7VeU+ukz258nbR9oDh+5w9eC40AC4jMgI?=
 =?us-ascii?Q?H93wvElcEdUsTomwBxIOxsNaisMZUfXORasrm3IOxR59tGzrGkM35EaAXlJ5?=
 =?us-ascii?Q?lwAgvuqX4pJ5Y6TnBznjklqDkMPnCXbAaq/1PscKyBuXJ0NLRm/IKSnGVtRW?=
 =?us-ascii?Q?vV/UbBWK4bhBtDDE9HIMYOeN51ROZnC4qOOBpbE8KsOvXdWB7s7utQSfO9HV?=
 =?us-ascii?Q?WX+lkVMIWEyClMxAB9XRlC2T/ttGoWmcaRkzazlkhdsjKa2+0paeHdXLS4l9?=
 =?us-ascii?Q?Qe7Q1YmDQUAcrM02fCDSBIK45SVN2QZThZFD4uaUoSOL3uXSL6W3c0W2gj4z?=
 =?us-ascii?Q?2mPz0loIO+CQ7cfMSg2F6V0RIw82PRpJ1EfNcMe/4f2KBgvJF/vI6OPbhhkI?=
 =?us-ascii?Q?c/qUPp5q2sYvCT3oct181mxaoGW/cSbt4koIClB7EahHfKYFQhdJARHgTTMd?=
 =?us-ascii?Q?aNMoQK7etVlKfO86PzOMZg70UhjRbzIpCpYP/ezCIQUuvtCyPGgEkQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sQ5cOxTa+GCCail+iegaBL6PZaQJPK/dC8m3B5rFHHQLfJv72+bveBdvmiO+?=
 =?us-ascii?Q?UkzD2EepGxpj+1I8iuakCOI3JXZUQ4hGT6fe6OvU2Om84d8XlKqD6KG66nQm?=
 =?us-ascii?Q?+kyxUryIFymtvnKVu9PrPs4Pn5kfPqWb5iUT86jwZcPIg2zYhSIt0WT2BM0g?=
 =?us-ascii?Q?TIeQKN0Nwvd82cRTPAhuZVT4lPtYcseVi1heJvP2KHKRwAE9UKWQIK5GwurB?=
 =?us-ascii?Q?WfC7V7t5xTUJwKldMQpUEdeuUqEKCPWSXempa3G/CuQjBRFovXEAcV4z0LK3?=
 =?us-ascii?Q?umr2IowkoL0QExUwwinCUFtu0jwSv7nB9dwHfYmh1158gZcKzQhljupQtdgT?=
 =?us-ascii?Q?/K1kn82w0s77bhQZkn1SqPrK7b0/kaJYjf3Z6GEXNTgyMpMiOKcFehFoFJdU?=
 =?us-ascii?Q?wEbwfsr/pKBCAXsMQN27TajCLtixwlZLD2TyUQaQ9mmjATfDhKXiWim3rPIl?=
 =?us-ascii?Q?KBOtqS3KUf6RY4rvaatS0Xq3prZxFvsTOFiuwcgrTZFbidG/JBVLfB68bpXQ?=
 =?us-ascii?Q?/m5q+19GVfq7W2Z5tZenhkgQ2G2Y4eynSlxCmu24ZFH2w3YJ0VXhEgfx7rRX?=
 =?us-ascii?Q?BJQlZUiGGdoLNylkUFnHI+DFHQFylFV62PYKjGATz0ln4V8y/NW9b6uTYDR+?=
 =?us-ascii?Q?yCgDCxNFxQ/LZmVdH0sMpJA3AVWvTC8viIYFUAd6pcGyyMgg/UWJUFVbdxQC?=
 =?us-ascii?Q?01zY7aeq6p15uN2KHIlimzniBwrwda2qxrNAALjmkQKcyr0jQtZK08OKxu6K?=
 =?us-ascii?Q?8wQw+EO9/tTUVOY+KSNu9nvPczgZnwRXyWzSfQQA6LARSK8maRIBDHnfxDoU?=
 =?us-ascii?Q?eauUY5yYAtJ6Fav1crqb2YsgEJ1sv8JBJ4L+C/Ww5PbZlzKPFFnS+mJcGYVY?=
 =?us-ascii?Q?ceeIAtubwItyUuJ4iVelERbEsDLDE/SMr6DONP0CbBtkMfrElLBk/LgcERG7?=
 =?us-ascii?Q?dcduCsfK0Yw+etnCwvBQAmJuP2vLex02C2i+VZngsLFUYTkB1NGsPUQnK8f5?=
 =?us-ascii?Q?MGwvqxtoWQTraP2P+uz20h05rUCq7adYusTM7P/DdgtqyPdRrbsTjxz1UOok?=
 =?us-ascii?Q?n7b66jqNsATZxK0o/lev8TZtXJGAJ5iloQIoMT6Ml2czv8VtINWO8H6cH5x5?=
 =?us-ascii?Q?78JmWI89T0ktWIAtGaCE6C5FsLOCreMM8Z5ctaxNJNT5Feq/SorcoPTaID+7?=
 =?us-ascii?Q?bBAIJOJQttWUiS0G+IZ/wGJlq5xDrF2gdyhWQGOIVwW2fTJxVZCURLdj0+Gt?=
 =?us-ascii?Q?vLxfr7F3/n/r8UJvGwxTjy8X9CeA6bF36BAmTfzHQlVMnsmhi2FEQPx73hUR?=
 =?us-ascii?Q?VKHPSDGyx8KAziA1daOaKhAbFPfiGW0RQlVpEGMuJEueLd3OsvVk4VTmAGsQ?=
 =?us-ascii?Q?Lx5oN75YHEmrhLXma4wYdWlzkKcIl13eJkSLWnfrBrD6ks4cQD5dsZfqALM3?=
 =?us-ascii?Q?Lf562jllQa+7u2v4FYhLzyTgWtIdkq8sNfDGtdPSmOtrvl8p5PozteCv4NTu?=
 =?us-ascii?Q?OZsxPBugLkqba4G//uOUbXn4iYqZGA1kpYZXJ/B4FlmK+BESlJHg6LLVPe1i?=
 =?us-ascii?Q?yTyjTw5g/yCizl9g2di4Og65ADqZflOnhwRojh4D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb60b186-95d9-4888-3caf-08ddde383cdb
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 09:18:47.9172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/C+c++xr1yQlihdGwWY30Hj+RZ94tt8AoeePhcMWyTiKQ6SQ7QwKb52xkLnzIY08JcRr6EocqwzY2TvyZYE4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7349

The may_reduce_num is used only once and has a redundant conversion to bool.
Therefore, remove it.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/virtio/virtio_vdpa.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 657b07a60788..8f762badec86 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -142,7 +142,6 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	/* Assume split virtqueue, switch to packed if necessary */
 	struct vdpa_vq_state state = {0};
 	u32 align, max_num, min_num = 1;
-	bool may_reduce_num = true;
 	int err;
 
 	if (!name)
@@ -176,8 +175,6 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	if (ops->get_vq_num_min)
 		min_num = ops->get_vq_num_min(vdpa);
 
-	may_reduce_num = (max_num == min_num) ? false : true;
-
 	/* Create the vring */
 	align = ops->get_vq_align(vdpa);
 
@@ -186,7 +183,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	else
 		dma_dev = vdpa_get_dma_dev(vdpa);
 	vq = vring_create_virtqueue_dma(index, max_num, align, vdev,
-					true, may_reduce_num, ctx,
+					true, max_num == min_num, ctx,
 					notify, callback, name, dma_dev);
 	if (!vq) {
 		err = -ENOMEM;
-- 
2.34.1

