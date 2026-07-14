Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023088.outbound.protection.outlook.com [52.101.72.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B82D49552D
	for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042215; cv=fail; b=FrGq4SzlW4eoOZefEaYEvNnjaWhbB1hSw7tTDBgScR1x2AxrNMO/i0oXX+LGD2MFfIVUHd28AhyHLP7ttrIbGQjqT479zRWwqVpWfFs+unLi4uYValUbgDNhRjLcP5eUtxiWjkkKo+/xiNctQwKrrF6xoEcP54y4HWILqjjGCls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042215; c=relaxed/simple;
	bh=QUUo5LdoJC3/+9LejyhzEuy9Db4qM7GyIsMW4+lSXX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k+ilEbAp5/i6C96xA0vli4D8hNiURsbI1vFvh1uTY6Lj8Bldt2H1fFyu+s2hGkFj61zsCx//ImlQsp4A9iCFNrz7ySoX45Aphk2oR0l+9FQhPEA8LBwcLyeFGEKzDQvclV4wF5FGcPIM3djHVK3nUBcRIsaSvnXsYItilWbHqTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=eTSCDkDn; arc=fail smtp.client-ip=52.101.72.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eTSCDkDn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a89EYQ0iONeAqwG2OTKLkI7pIL5CIeUAwGozYtjglgCH+ZNI3VPXTZiY8z+yhs+2pEBY6WAXoo9bMW4ihJZha0/GfKkj57KvN44As3m5OlM4JhNRmUQgMqKlFvI0KmHi3843SpBlgv3qxCWClZsEAx1qZeD7MLG7757PRpwZB0/8NDPQPjuTrY80IAti4SaYOzHZLf834vKcDgH6vcvC0pes2j/vO5S21chZIJ4qvRPJn1TCf8a8IgLZ1+XXAX5gP1ucOqBjhjrcMHhUTzADFHZ22Zt1RYIZhowuCJTqQ4wsIPZb5d73KrVf6kQw2bne/C6UYFwmJmYHOhqZhUCitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+vb3H7ga1/zO8JIhDlu/cn9DNQ0Sk/VBwY/dIrZDik=;
 b=cWdkZ9v+lQcJd8U+zpxeHvahPpC1At9Cemp4G9NKkXj3CtsNN/lCQewrk76AhXLgOrDZPaLwYZ959NDwXl8zUU2nVLG9Op+b3fuUdkIfyvjfQ5tdN+lBLgT7aV4fpibX91ZIGq2EX0NIYcjROunhOnKIZgpQdtpHyXx4/Pkqp93RA94yWt913pefv5BkdLj8PKBXjJiYET7fK/3WZSDJRXOl/oBEvAba+IGOS5c4E/ODPJtHJA08XDkpyJ9NYZ2guXsOH7zBD5OkbPtwbyB8UolDb7Am0pgsDGFJ8EJqiQX3vgSPMwsop51i+H4h+somtMUSGjd4UMoL8Eto9eiIXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+vb3H7ga1/zO8JIhDlu/cn9DNQ0Sk/VBwY/dIrZDik=;
 b=eTSCDkDnmX5BjiCiOeqddJHazF6wWcu9D2QuCzQ+6O+SuLEMQZpEmFydPD3chS4MCvPiRnQlFwgaOexDl5p6Fb/CqHjNR4Oe5Od2YUQ5WAr8NBQfYmOVKvQWJiqAAAUK64MT3s/HQhBuf3dH60gGFPAykriNNdbTpB5Z8Q+ivxglu/TDK91OtHBUVHKLD5pn+p0FC0IJ8kyp70Q9lsd2MEWsABDF9AyeyYuzIhcHJBgS/bEoS0D14B7vOjDCgOYPVkVt5wLOa7vJbV7UVC+67jMKCv0rpa+FPgrSCF8CTyx9pk6vkFq5EQBPZdt/JF6F1gikbEYceQ+pps4sAFUWyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB7692.eurprd08.prod.outlook.com
 (2603:10a6:10:3a4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 15:16:49 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 15:16:49 +0000
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
Subject: [PATCH v4 1/5] vhost/vsock: split out vhost_vsock_drop_backends helper
Date: Tue, 14 Jul 2026 18:16:34 +0300
Message-ID: <20260714151638.143019-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260714151638.143019-1-andrey.drobyshev@virtuozzo.com>
References: <20260714151638.143019-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0107.eurprd09.prod.outlook.com
 (2603:10a6:803:78::30) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: 042acd29-2627-4338-af45-08dee1baecd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|52116014|7416014|1800799024|56012099006|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VaE+rjdT1CRlFy0pLLvT0ctxymF7LfzkYLZiEV7sRAODdt5/p7+KuKmgsDYcrNpUh8F/rE9F1kYOtcdsSDAX8Tbqycprrc004FK0S+Rsi+n5YKtvM8ZcJqsya0gqmJQyB7lrMRzVXdZRE4a7GtVzdr4j5Rox3bUKcHDmnaGgU/ogSjMcXoBuhQ61Sy4uTdLmsBDpttbL7K8VAE01+g0xYE62fveVzS7ujNoAzDCHo5apXYJohdXeHC/SEImmKOmi2g9u9ryInAqcAnxKUWrQB2SN1tGo2bWOQHcYPOeXC04ESYxHMvm4Pk8in2PrLggSlG7hDG0NEQULwzGW4EC9LO/PYIZXjWwDCWsz9FD5PbgA7/tADmtemDY1J7k+Hx6LcVyf9PbY3K4UHKjO4EDUjmWP7Qcuc3Ga1trpmJK68sykrPUCpQXDUNWvYTvizhvNP29dX83RswDMthE5NDXNXHIeaXH6Yt4qSL9ioZf8bb1I5FhhxoDFLFh7TZXR8RLJhA8vtLv6M27Dk8ve4Q5PWIRtoyGFuGqZyWcfRtATjsk8j6yVmxA/U6tO6LSIz8QHV3sRxiyJHrmRUi44732PJzIp9Fm0eJA1lDovGcdqOzVTEa8IsZxIL5vIP4yqCQT5BTySXDjtfQd8/G/11Znvm3OdmhFld+4LtR5Qp5Hihix3Z/36Katg9ClbTQhlD8W1YLSTBrnv3rLjCFb3CpU/P0MU7EPfzn20l36OuvmL3Nw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(52116014)(7416014)(1800799024)(56012099006)(38350700014)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ccMfQVtyKF5VnlibFlHJVYjyuCo2kcY7xe4swwgNUi7J5sJRlCJIswNtoAa3?=
 =?us-ascii?Q?gHQRlT8cioVELTQWWidIEcRO2U6MBrqqPmV4pXcGsHJE5akEgnA4HCeqwoIX?=
 =?us-ascii?Q?hcKTAPuSKgB5VelGe19Mt50yTdD7yrmylxmTdd2HPQ+Us0T6BGGnd3aK+6T1?=
 =?us-ascii?Q?wYpbOhnxwsFGAzL4K+I4td/SI/C8ZnBVFBIYvp2ekSh3lE+tm2b/SGI1vSlI?=
 =?us-ascii?Q?2OUgPLmU55FaRhPgY6U+MCsOXhXQPvaD2ZeHrL5jiibSENV6tUh4jEq57yvo?=
 =?us-ascii?Q?Brtib8bvtUGxB6ZIoknBsN377NWE4JWyGV/XmwT9i4vvRXWsvo3I+AqAWUtC?=
 =?us-ascii?Q?FVkYLvuLDbQIZjM+zU8CDac97+wNtRik0KVb634b9/r1YWxLIyIm/yAdyRIR?=
 =?us-ascii?Q?TkrPd9k/cXjvsdhvyQHCzst2+ZUNgnOF8LARXRs0p1ma+uX8Ai+JNjmnYwwK?=
 =?us-ascii?Q?oTSoYhmBFdfPWTxUsTZiFWiD1bQvT7LcYz+6e/RfxuPJTmmp26d7zx/7wUZI?=
 =?us-ascii?Q?bE8z1QQtg8emwfRR0IPQuPrJYQiVOlMQzwvieFw/vTNUYkvDsKmR/vvuRt0D?=
 =?us-ascii?Q?8Mp/yn1/8zN7XhB4kD0ufcHFmoW3Jchpl8S25V3moGCb7riYYl+1ykwo3BfB?=
 =?us-ascii?Q?wVxSXzU05C6q6qZfq6q06uUXvqJMEEPSynoqRD01YuFR2D8XyyvMYOl8fqJy?=
 =?us-ascii?Q?pJC1qckdEdl0asJHdeZGdfU220PXCu7Hz3v2BxYoJw21LbA75n4Ksm/3NbeI?=
 =?us-ascii?Q?411+RqTuPVHuJNOHVHW4QRmUSvb5fF/fY4hyh1ZhVfkKJx0DdUzGmlaMg7Yu?=
 =?us-ascii?Q?fxIuArDcSX2t8LMjBwphIxPwyNDxTe0TbYUujp76s6l0jiJIK/xKFlSMAifA?=
 =?us-ascii?Q?79Xhf4lMwvw1LO1En0nGB/+AthCPm1QfOwEiV8vsuXPUkvRmRnV/fl90XRDt?=
 =?us-ascii?Q?WLcHggJJ4ZGVm0POZEVVHLO/6RU1ZY3LocSrZgc/AF6TaMAfFNThUO0JkL5L?=
 =?us-ascii?Q?hD8w6bTu/KVuB1hjLSh0aRE8KaXhM2mpjB5XQyVGZVp+i+leyOOAzLMdCrgR?=
 =?us-ascii?Q?FNgmjkqpl81fOPIeJ4FLdCFucFL11SJApZAf0VyU3uuU+0jZZXfQg1j3J0n4?=
 =?us-ascii?Q?DgsSn3fhiVpwRQmV+t3+V1NdS3jb+9juPu3Uhu5rqAHHkByHR9eDcL4/mjsg?=
 =?us-ascii?Q?aoaVs23pVLUqMksy7Lpx6IDunxWmYYMNQCXsxrkhliWSUvrKS9Iah6IfXPFX?=
 =?us-ascii?Q?xf9M6uUXTA8TRCHjovaJKJKcTcDRAqas9K7y6U/Yq8HSh2KCcauNdAVjVhvx?=
 =?us-ascii?Q?WwQrHPs3yQrT5tw7XRved2sxHi94dKBnXjOl2znJReao/UYWg/GjnbTDcHg/?=
 =?us-ascii?Q?ce0XkeVmImxrqbv/lAFx1XZILVONdthmBmqWFqsJlQFQ5k2VN0mxpZavYrvL?=
 =?us-ascii?Q?m25Hdt5EAJlm7KXnlpL1ZVd1Cbvq2Ipt/9uyxCERVFU7guqQ9Pzpl4zpZ9z5?=
 =?us-ascii?Q?EG17ehIfu7fzOxbbyx4atP6IX7DPfayJMR3QieZU59ctQDVCx/YNrbe+NhYo?=
 =?us-ascii?Q?wF2h91Qn8VfWo7afj81exvfHVgmRE9fRWdxROomvJ8/IoAqGgAl9Adb0wjHi?=
 =?us-ascii?Q?+RiZH0MgF2WMf9Wz3QN4Aw9k7OMi3edNxcfcs1NrakmC+ePyuKehso742oFX?=
 =?us-ascii?Q?xMmnQ1+UQTQ67eJGlMHt91mNbC04D4gqKAFmVgoN6gRwrW9XolIjEU6Nbz3+?=
 =?us-ascii?Q?ASE63myEYQGIp5MWUarex/fYtzPBUlA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042acd29-2627-4338-af45-08dee1baecd9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 15:16:48.9702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiPNVBpUNBOjzunreGmrLsE72XRP2BPrhieoW6lnNupuauDjqp8jYWkMuo9XxyOV1taeUH7VfZdMcz1+xo7SdVlRvk7Eta/WlNAyn6mVewQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7692

From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

Split the actual backend dropping part from vhost_vsock_stop.  We're
going to need it for the VHOST_RESET_OWNER implementation in the
following patch, when vsock->dev.mutex is already taken and owner is
checked.

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vsock.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 9aaab6bb8061..b12221ce6faf 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -664,9 +664,24 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
 	return ret;
 }
 
-static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
+static void vhost_vsock_drop_backends(struct vhost_vsock *vsock)
 {
+	struct vhost_virtqueue *vq;
 	size_t i;
+
+	lockdep_assert_held(&vsock->dev.mutex);
+
+	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
+		vq = &vsock->vqs[i];
+
+		mutex_lock(&vq->mutex);
+		vhost_vq_set_backend(vq, NULL);
+		mutex_unlock(&vq->mutex);
+	}
+}
+
+static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
+{
 	int ret = 0;
 
 	mutex_lock(&vsock->dev.mutex);
@@ -677,14 +692,7 @@ static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
 			goto err;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
-		struct vhost_virtqueue *vq = &vsock->vqs[i];
-
-		mutex_lock(&vq->mutex);
-		vhost_vq_set_backend(vq, NULL);
-		mutex_unlock(&vq->mutex);
-	}
-
+	vhost_vsock_drop_backends(vsock);
 err:
 	mutex_unlock(&vsock->dev.mutex);
 	return ret;
-- 
2.47.1

