Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020130.outbound.protection.outlook.com [52.101.84.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDD63955E3
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542993; cv=fail; b=VD/L39a19vchzLWL8q6fSqWrpYljOsensWRxG7d/677fuHKDlaaeBqMVQuTCp8OPNU3dLiLqH962axlscfjtLtlz2DIk3s+sIycsFuGRG0U8R9iJrdwFMNbA0NzdE1k8kkF6bAoXCshkN3L8azM8LTySQfWR9SZiSdZGR3bdxDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542993; c=relaxed/simple;
	bh=QUUo5LdoJC3/+9LejyhzEuy9Db4qM7GyIsMW4+lSXX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dz27BMKYvbfm3pkIM3z1BXq+5A+LqvyjCmzpnmI/uaKP6W+wCoUtokayWj26aBf9AOsghrfyjDzVyL9XRR06clGZaXwVrJGRMlpLu69lMLAMg6abUAHHpaef4GQznEJhoEoTakksDqSUXo9vodngAGXkDrrbHIMmEAyiEctpfaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=C42/a9UD; arc=fail smtp.client-ip=52.101.84.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="C42/a9UD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3azSiyI9+sm0TeQXJ6wvwVf3uU4opfP+4zXzaKzWdLbY0rvpkOnrlxOIJA8mrDH31u266alSwoxkCjebQleXFLUlP2C9TzTUapeeBUAMf3/QnKJOsNprzW0HY8c8QLC6nk8HitVzpdbXOiKAFYOdgvzrQWq8Cs08HulBO+dvSlyNsLuKLbXWWyeJfAMTucZQzgN74In/cUz1lqMg54i+UGgOydPZmpkCA0LfRH1vXf8WPfz9qiHQ8qhPVz5ipQB7vWcRuDxnUMqNqfjIji33nQYZa4CkApgCmE13q5qwuQtDqWhzNy9XYVMG+v1jEKnBYpUG4hXieAUkIOxlvmJmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+vb3H7ga1/zO8JIhDlu/cn9DNQ0Sk/VBwY/dIrZDik=;
 b=nfW5dovD8G3ki6QAFN8q3IAOTTRKUnKbMs23BR2OYNZmRaQz6UmCTnfecKOqLAsjyEy1NRzOuoO0IQ4gMOoOcMAiD04znS/PbDD+hV3/fSPSPTPTRjY2cCZhfL2LRlNBLaIFNqFJahE1XoZAtw0DuDYuoZ6qY5Ciz++5LBc6Zr+nSf7sF+8d5TfawZ0uizjcyB2mVuNgjW8lGrrVJd1sOFC+nIYo831kRZWcqfQC3Yhl193dskN7x5rBhuOo4n5AXbKGQn1y50toBvP0/9dNLJLK3+zQOtqhwh3PYKccvjla7uTiG5R7e97Lv8NYsrUTCEJ5pBG6xcMzN33epv2Zkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+vb3H7ga1/zO8JIhDlu/cn9DNQ0Sk/VBwY/dIrZDik=;
 b=C42/a9UDWYVAOIkVaHQbgYxe4jE7+E7SfEwPnYSo3mtGI31koqEHsgD14+Rn+bMRIgoePKpkn/cJYi4gsyDqXyaBap8vXUEGN9gDweYd3lYlDr9y1zNNR1xU64dpJdiNnh0SOf8vbFNXxfy8fSRvUmGthfwZuaEsTCgo2l1vKlA61ZPz9jDLlVRIHbIX0YLnI4R8ekm1T9xbKf+wfGptxpRigXNeMS4JCsyfbwRhnEUtuzjmYEomL907+W12E67WanSQIZIoNr7NqHE2QkpYP2dl8N28S6LdET4/YWXGxEqoCq0gfw1LRY3U2BWsM4QAXbDvRt2oH8MfDb8N7P/Ifg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB6264.eurprd08.prod.outlook.com
 (2603:10a6:20b:29a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 10:23:07 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 10:23:07 +0000
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
Subject: [PATCH v5 1/5] vhost/vsock: split out vhost_vsock_drop_backends helper
Date: Mon, 20 Jul 2026 13:22:37 +0300
Message-ID: <20260720102241.371610-2-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6a88ce66-5f60-40a3-08a3-08dee648e40d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|10067099003|56012099006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	t6MfdZn/+0nNCB87wJfySYtWyk6TdIFHiB3Ieg5Fn2tVSlQe+iLaxqrM8jseNr4KRxJ2TDpB/B/n7fMyjCLGu7Rjl3Xwq9FOKsdpMc5uQrASaTf5qf11TD69eK0UvsbQrxi4jej0skK2h/lQ8+pzBfm5kjJnek96JzkzLNq2m4gr5vpBOsH4oHEszzj9OY8/gk18Z+20ne+LS3oH0xXpuE91kIHDxoF/Rt5KCy6bQCFpmZA1Ja68JFeKcLGPENub4qCz9CXBKKSM6w7XIN7RLRcpMM9N4jsqCZNL20PNuR4XcXgWTgY20UINniQ3ej8xhc9w5ULDcW5y+DSvjqTXYq5hkRWrwShynOKtn1UOtoFsSTF73Y9Row56ToOdYViTXsnxscKFBwPw/Uf0Udby/7tfVUlNtXyzx0TRPC0MMagBMmEV5CjEsHW6Vg3S55pFvW1hSJQ0Mt4l+gCJoXDgvl2gEs5P7EUzMYrH27oJrRGZpQT+EBwSyKzhTzWETY1/hJvsPrvGUWbo0KX9TrJf8bZ3Ey9yE3Ll+ZDZ5wEvnYx2IyA2EvNyMXuN0PE8WUWLl9pl+mTZp9ve08G6JV8xbj3kih1X8QPpFc8+9EYXevoF5r4XhEc0nwUeUYku4/fppYchadNCG7nCnA40FuJBIWy3H0v+cpxBTOXLs6vPtYcOeqxICbw7RqYuBIRndA49RmSQjSQKFobFeX2SR1dnbRtWwCvoORY9Q3/dGV5edgU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(10067099003)(56012099006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u/t+Uc19u6BHz3dwb4GhU3fI56TcNXLd72FqDge9uAVhheBCU7Xzq2yiwfv7?=
 =?us-ascii?Q?/0IAyMuFOcQcfRvO3+5mYQKkjNuVJwO9Ptp0EChR1vH/xwz3fRo/pQbVXS6G?=
 =?us-ascii?Q?Bqe2tRPvkKu9c6pBnHSvTPXXXunFncYvWpk0/Dfca7OFB09PGrdR14fNBD/i?=
 =?us-ascii?Q?HHePcb8cZnPl1PuW91SQQokcuKF64a6qLVVNUdY7mSbIk6/S7/rzQbkcc6uC?=
 =?us-ascii?Q?IwzlAhDV/Q+W/HD4Q9EtG045O9k+VSkf2nguGr4ss1OYKxCjsmBRVQPTZHAo?=
 =?us-ascii?Q?0CuKjAedAWkCsySNFSPNTanCP3vlXDnP4qrb7DP/TJoFl2zTaxqqOMkcrmya?=
 =?us-ascii?Q?re5Um8wayIjtdJAyonNUtPTbZj9s5xZu/PcwhotGY70oohRQNcaLxojY4QNw?=
 =?us-ascii?Q?MjVaNFTge5fO93P8Xy5KA74/Zjb2s2bMonkYZDhpt88Pta/HrG/h/Qy6br5c?=
 =?us-ascii?Q?l6ZZ6NhgtVjLhqD5HKdSuaWltK4K5k4z/NYsQkcLNN3HH8pWklryih2/aNgu?=
 =?us-ascii?Q?AW4qlgpTi/SrH33/4O0zwY0LuHnI/MfSi4TDmbSohTPkhpaV8grD748UgR0S?=
 =?us-ascii?Q?bParkhV81RvPa/b5LOPye3YOov+VtOwa0aWBPLbZuE3/9843FTJImssskfma?=
 =?us-ascii?Q?Yilt3jowHYE2aKygbwTrzyZd9z0xqFuOWmRVM5xp/wgxEL6X50cW+oFGscgE?=
 =?us-ascii?Q?AMIkVUjKkySaFXhDQXq/gqFB5pjbrZsmAG2/pQSJBtDk0mEDrrczJRzXBLeB?=
 =?us-ascii?Q?OOs2p0AkzAR1gMWz6NGMCq8isIEIkUSnZouaF+/eaP637s2TuPnMfLxKvVUv?=
 =?us-ascii?Q?jmbl3kxXo0oZM19ajugtBifjMUrbGd0unsQjtj//uf6G0OKSMtOlYIBJ2Ezx?=
 =?us-ascii?Q?aFp3GDvmeFY7KKVQJ3i8jIWjKIcTPYxCqSh5ltQzzzkWJbfR3veIAbVW1AtR?=
 =?us-ascii?Q?OSTRHq50X4/VCDB8BVWXY3g03034WvwHGvN2kSYOunUMKT3kVwB8gCUSKKQM?=
 =?us-ascii?Q?5ot6MSE88F4fXW/jpxYt7siZdARlDsxm8ZeWbfDxyax7p1P5n0AFiWHnAl8b?=
 =?us-ascii?Q?f3mHWH82bnyfaGoqU1AhMdx5C+ArdYOsoCJ0THreMBu85DZiNT2mZFGKAyNC?=
 =?us-ascii?Q?NlgXzlVQR5Hh7YLFCpFKRSMi+nw8Jzk7uHBvgZV1/Go7qYbJovbvOn8oDQUx?=
 =?us-ascii?Q?MKaFZGLgDY3ioYZ+rsY5oTAM/5irxBrY/wPk1+T/7aSm2g6hMHxeobrvjOjM?=
 =?us-ascii?Q?GeQwBPJXkthWqMjOaMwxs4aBf8wOTZbIOk3/A1cq4Oox4qroJBVNTPBKeCML?=
 =?us-ascii?Q?W419OzP1vmmwNe37oPeX3aMKkp+IvnOpKf8U288PzliC1N3ljHlJ0c5NVIgY?=
 =?us-ascii?Q?br1atCQCIcyw2sq3hVAsq39wLAD1A7CUaBzEbgatFLqoljxwGBu+S4OIJPtQ?=
 =?us-ascii?Q?E+upI97NCoFpvdeFu8jVl14xt7CZ2hV7E/H/UHHzgn+0iCWI94ulGJiSQ8pM?=
 =?us-ascii?Q?oAunFfU371WqdjYLhjhIm0va62Os/qT+ScSxGfVYuagRcEwElpb3jHxewWC4?=
 =?us-ascii?Q?jwtFnxcW5bdLk6pjJf7PO/n6uC96SfJz4hhEZfAJUyz16o56P3fKHYNfR/nw?=
 =?us-ascii?Q?Lo1JPtAXm4IrxsUk/puB+hVsfp0Q3iyC4S+4r12GX/R0SJP9ePyP1CjNJq2p?=
 =?us-ascii?Q?4oIN7iuE0xG6j/p6XCf1GzP+9JbjBkwQdpiXHo3YC42xwwhkXZ/Xfnb8bbg6?=
 =?us-ascii?Q?o326gXeclOMHGW1MTSNo0UgbxAxsjkw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a88ce66-5f60-40a3-08a3-08dee648e40d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 10:23:07.5479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oONVdDPA/9/5mAY1O1RhXA2llh8ky0gqAddJp3iiiOjxpNRp2U3Y8swtzsSm2ALEUbDCE7dnOkxsdBwmN8WM/8eg8EQO6uwm71qYa9Hvbyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6264

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

