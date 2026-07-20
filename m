Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021091.outbound.protection.outlook.com [52.101.70.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF395353EE0
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542998; cv=fail; b=a7VW0lOkWpskSfFPgdZi2s5I53aQ5MV/o2RLqMJJhUIfUOOOvC0EXLdMO8tWSLMTxd3bm445uRH7Au/HW3msutfR9gLd5uuzabjK1qnTINFbHBB2+D+4U8Xn2ebHujw678duB446oOI1SatSdRCfWo44co3MwxkyQdWIYLUrlUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542998; c=relaxed/simple;
	bh=7yhxoBZ/wxX+Ctp+AT/GMSPp27/7YYLiXHLe8jO/KOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=llReU7edrsVtdp0TsJiFKw4tYthWoISFFswMT0n26kHqXKHc95eEpVVaRceovu2KJHzVbkXxYQl0hhgdrw4bunnjscHLmIMTCyrVjUpLqpcACK2BgFwu190jN/B3FV/14EP0p8sFmqhzpGmOlTqzaujpHfl2CbJLUYweAVLBtH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=Zl2KbvCz; arc=fail smtp.client-ip=52.101.70.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Zl2KbvCz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQp364nU13pl52jf1JnspfjvSaODf9q0b4XIQZ/gsiHifDmXQiR8xREo0GRscPw017Oe63QZNr53RzS7KliEZvF+IGobUkFpS2e9FxSvrhtnAnSCXQ/SYxTX02s2rLbZ+tK9Kn0PQmqhg6zXmWLTyPprWAP2hwm19KnqTYb+rKUY7RQ1yqnpIM7UDtsTwVzWh15I6rkMfU8En51UD/9K5e8vC3b+DOEJHEVFIliw4xISCIGOAmawzJBDJu9OqEAte9m0QYBJPrRcN7iVw4wtvJSuWeXMdbBey3m6Dek2AhsxY2qkDO57Grfp+OxB0YyLiSPCSqIzX4ZhP2wNbq7uNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IENLpuB5Ml/RTZriyLBBAEVfZVZ5lSB57FR7jCjqQys=;
 b=b46DEpT/+M19981jhrKEYf9p/hoUePetWtYS9sLyY/pLlcu2559iJ+bjVE9TdJUssWPVmTz7p30tOJLJSd4knRU16vrIljss4KbGugLt3Mi9ya9YZn6tnR0rYjKZ6zW6mX0vETE27vaRg0qie8km6jvFJSvanz2iAA45Rqg1UIYemm3jFkhOtNl6Q3NeN2U6h/EJfbzRe9iVQGbVjK3gfs6IHErxQhdTYBNzp8P8DM7qHJvWpks58pCrvItD/cK0vczDdCopxSL1Br2IHWgF7WTyI1gOMP9oqM4Aw6hgBLKokT2yt4iqkYAv0x2CeHDhU1USS8lhZcF135YsH3urlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IENLpuB5Ml/RTZriyLBBAEVfZVZ5lSB57FR7jCjqQys=;
 b=Zl2KbvCzwiJ5htHyfWX9eLqNhJobGdWSdS1f9Xx7u4mDR08dw3Mh3Xzcch1SmLmbt8ovGMarWxh+2bpiJK8wp+snccMEyKZHYVbC6XSoE4O3YbSk1Irz2DnhNEE8dLp6XXOE9g3FbCN1TOWJtsXaBbLyKos4oLMinhv9gJ+zt792Fxa9I/+T5P3WICJsnK2G9oj9F6GRCGSUuu7i1CA7cCOWYLp41evIkRUL40TPpRMI5O54brcPmlJAiw19OJS3jE/Z9tcn247FogdXpIKpT7X3ejRxYm8OLiWJXw0FzYFi5bc7hS1rxqEmDGIxq0Na3SK1tf7QeaKG4trMIPQ3mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB11204.eurprd08.prod.outlook.com
 (2603:10a6:102:469::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 10:23:12 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 10:23:10 +0000
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
Subject: [PATCH v5 5/5] vhost/vsock: add VHOST_RESET_OWNER ioctl
Date: Mon, 20 Jul 2026 13:22:41 +0300
Message-ID: <20260720102241.371610-6-andrey.drobyshev@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB11204:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b180fd2-cdda-4ff2-a6e1-08dee648e5fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|23010399003|7416014|366016|56012099006|10067099003|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7F8tNJ31bLpVj5EzVHSonst/GtoNnpVCLuJW8Ryv107BabWhDr4krW6keRlmRJCv0hA/3eT4rIxA9CigW6W6xBOpjUF47+MED1p8kzUUFQ3d7+W5dkWUbFUiQ2dQTGuMsz6OJJm1Scs2vD6TIa9gfQFcSMNOWmyAgZN1nPmgvV8PdvtzKBbsQvKX0dnV17UiAGAaWCMaHilWz3hto7BF5vazmXJXb2TT33dFf5czPKielKfvDsOkkqCR8/gMbebBpPbmiTZg0SoNiP5k/SPAc/oP0otOfUB5HSYTDNT1UKb68F00/8q+pJEvlezKmQtMmx2tD5PXcv0+BDSvNfukGjOM/vd2G89oM3mDP6ceUvdrYA+Q1VEB7h2Gbc4fkyjg9iprs1UrbSg2wdKDDQMCwW/rAKznjdAKZZEOjeh+s0shv+iRp+kFmdWy82Huri41figY1DJrYmUaIDUO+PJQuH3k65zDusxKd9b9ixCFf0sJHiH9wL+rRQlOPhf2G7ijEjn1QhEgW0H48+PSxlqd3GkggaUUJubFj1GzkAq8mTzOJUEHkUZjRH5Yc1CrK4sFWGe0lDU0Rn4mTjqYeXTFn+G/4XPgtZmpDg6DQn7UpfgQlhqA7jJ6xk27c4z26sLbITz10HZcy3e2O3PGuK2NXFfvfriVUBuxwQzLvugEcFD1QeuwdN8wiQrJSSTX3B7jpNYW35nPJXvESr0h93eEIeSUwaQear/5nqF+s4pojz8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(23010399003)(7416014)(366016)(56012099006)(10067099003)(38350700014)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h8GVrP1GKgg4J36RPlpxp8L0XO6u7b9/80VGccgWpHb9sqp4npyZhANMpZfu?=
 =?us-ascii?Q?P22/112yH7jbA3qO2jbyumDA4PDQ7TTvZBbUZ4JPLqDbMyCrG6IW7UUXqpOO?=
 =?us-ascii?Q?+DEZiPLE++ynLyDXfIqzwjuo+cFUtLaH70qIahGQR6tStGUae3wZ+MxQL5hs?=
 =?us-ascii?Q?vvUyOILI6S64quqOjpKTygJmy/a/tRXOHruEsX++UY7m21drOwXwRmL4oDZ0?=
 =?us-ascii?Q?LzfagAVwtNcBeoqNbUAJjdKGS5Q8xstntUKaxZTN7nLV/ESf3DgyVRYID7uB?=
 =?us-ascii?Q?1a6LZzB0X8ZuVeC65hiLGYb6sp25RB+Fgn44TTy8ggH3teoAVHNXmVjYPS3c?=
 =?us-ascii?Q?m05zuBAgGhREVJT4MaxCw8BE8RK3pPXeYblbVFjqdBSrAAhExUJ/VOkHvPP6?=
 =?us-ascii?Q?v9uQaz64heFczWsSlJRrufMOr7DBZPCEPTex0FSLHckF3IfpQlkZ7BLHLXMz?=
 =?us-ascii?Q?ig6zVg7WrVLSnwLzOGQ/karWxEQkib42t2Z15D5TgofqqywPeyQgGNCLWVCN?=
 =?us-ascii?Q?DX5tAf26uOY5baHAOf8bXlUybhFlAGUqTufE2EI8kFchPioSns7fjsBci6pL?=
 =?us-ascii?Q?YOxb7ATKvf693XxccE+Y0hdofWrd6XPpdLnidU0P9a/ufB44EaqFxE7+dc/7?=
 =?us-ascii?Q?rcCNoq97nWuVMnoJYfgf+MGh91Gm/UJBrirR5qjZWjDUSrmgBfUSOvHKpOMY?=
 =?us-ascii?Q?zy1FwVS17ZiKhsWfKASSyNKv7FnNRJBYI1Yr/QRcQgJau6Ec89lXfBeLLQuL?=
 =?us-ascii?Q?wo0d9lNdt83EavyEu7PEvWVHrkatpF8kc/d+BIGV+rFwuParGJzJ0mhiPtIS?=
 =?us-ascii?Q?pmwMl1APK1K7y7B3SAKXgAlECWQ5/swKIAEMU2VxUV5dXqIKTgjwq14dDH1q?=
 =?us-ascii?Q?eD3iJb5QOndAe330cvV0U7MRcMQOlyBRe7uZn+gFeOOYDcHkG6Gf56I/ojRa?=
 =?us-ascii?Q?qw4S37QpJHXhFxSz9o93DII0hvvCVYU5nR5Qo+NISxBGqeLE4iHwY8DfP+kk?=
 =?us-ascii?Q?buI08ixHDsdygQfD+2uij/WQSy740EqPB5mP/3kxHcHr7jE4HgJ587PWE2Af?=
 =?us-ascii?Q?JjAhmj9BL2VV7hBT49msNItk2ho9dMN4EggJXO+Lu6Cf0DT8UUevjNFFJh3F?=
 =?us-ascii?Q?afDU/LQg2rrujiAYTrionlKVwW5ADl3LlLk8e9hoCwev7Q1vu2ChZCdKiVeB?=
 =?us-ascii?Q?5KBxh1m/dipTXxMxZcNtiqIkM2XgRx6Zsv/jC1e+MD/KdHyxyef08vXDspDn?=
 =?us-ascii?Q?Op0cDv284pd3tsCpOJBcXOWaZ+umZaGUR3X7XbAPddrvFfFT4Ls9xtW+n98K?=
 =?us-ascii?Q?xLR3bwGZeDpvqWG2MGE0+ER2GK54+lzJYYYW47wPICljjhprCZ9vIxpwqdWQ?=
 =?us-ascii?Q?mn1Ib9RUz0Q9OGg1kZTWcADwP8RKcOtMXa237uMvCDNI2xmUdEmGaq1KuouE?=
 =?us-ascii?Q?fx6PkYS0uYATy24SmFmfzg3EipLNrWyIcQh09b/l1s7eI8XT62kYWyBVppR9?=
 =?us-ascii?Q?1nlCnYy5eOR7Wa7TRps0DY9ZKrV+5nacslvCDnoJWEVqjhgGiOex/KsFSjFU?=
 =?us-ascii?Q?An8dZNMY0ous2Z4Jq5oJ5NNJBKpkJ+dNjKEtfXX4/M3JBVyV/E73CVzwxFFQ?=
 =?us-ascii?Q?R8QQOy8SNeB42ive/AubzG/UeXwoXwpJFI8XJRN4uYDwqMJFOuGupoD1VZ+o?=
 =?us-ascii?Q?5SJ6lF8b2LKlsSo2RnrvzOgm+jww6Zkwq/0TFCPTAeM54RVmE+eimqaeBSYH?=
 =?us-ascii?Q?qkbxr6OU4iIxUTgr8BTNQbvqrMbuIY0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b180fd2-cdda-4ff2-a6e1-08dee648e5fb
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 10:23:10.6067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+PHBwqgd1vvxGvVvinuebCtsIH372J7JThD2fpHFPfdsvjSBlza9zxR7b1t5B7QGKyjY+8scSsdZm7Id7mqOzoiYYUHyKbmcwobPgEbCig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11204

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
 drivers/vhost/vsock.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index d5022d21120b..86f25ff80722 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -903,6 +903,29 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
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
+	vhost_dev_reset_owner(&vsock->dev, umem);
+done:
+	mutex_unlock(&vsock->dev.mutex);
+	return err;
+}
+
 static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
 				  unsigned long arg)
 {
@@ -946,6 +969,8 @@ static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
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

