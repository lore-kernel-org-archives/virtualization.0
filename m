Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021119.outbound.protection.outlook.com [52.101.65.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96833E5ED7
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 11:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893557; cv=fail; b=b5aAQOnMiUgQoAACxDDhS6K2RuWmA2gfQjun/HQff2hKKf8vZg+0EgMPdGn5Tk5AdTunt6dBhzr8KD0ofvTco99yC3abic1LdQyu2APE/XggooCvhhNXEYdS7MeGV90lICAggOaYu9oQYl1W735d7KxsUj0acDBIn+01/zXzeOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893557; c=relaxed/simple;
	bh=QUUo5LdoJC3/+9LejyhzEuy9Db4qM7GyIsMW4+lSXX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZCQ4ri32hKN0yyNsL38nyYM7LqrDkz+8eSOTFDRu+qFBc3z9fXJuBQvRCnh+/NsrgECQhwcFavqkt+/bDm1btD/27yvugKTiWX5/vsVSHq9aBX0sghUZyi5EAu1VEuX0glccioAxRDr+5ppT4jrT3Pg5xjv744+8wSZmi/UN5fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=GuLQbInF; arc=fail smtp.client-ip=52.101.65.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GuLQbInF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=reOjtF23LiFgDOaNCt3SMLy61IM9G8c1sajvu988ASUWN9sewKkCrQL1+h6IlZkP7T65G1wzVx+mgkMdR8ZJ/28RoS4Qx6ui/cQIq9C+Pve/kqfTPG6AM/Bvj0RqQzTFBAEHamWcFILT5qCuyV7gB9kDy2zUvivKQw0lBEKHZe9eGKHwc3QRND9xRbqd6avHGsP2+oR0dqplCvzb1Bnz0Xxtl2TzFGVwKQDGV7RwHftgsfvQO8VjsfQJdX6Me/YDjX77FOe+83n4P3QV/zRLjt3K/LMx6abIVE9yRKIwcqiz2RzQAeUFrxjgytIgJdNFiaKWW9esqE+v/wZs0IehDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+vb3H7ga1/zO8JIhDlu/cn9DNQ0Sk/VBwY/dIrZDik=;
 b=RMah0gOaatTdkPvvVuqIolK84wrpLdPdHO2TQigAVDG/DnQLuXSKFm6lT/AEdNe3SUs8pNNjQrza9JPbrhaf1xMSU+HVGNOIL36aWDMljCIfZsfmxgs6F8jCsGQkCTsuXbpGTqLo+bOegCpyzaP0PEgZPfGTrcDvmWY/f3DhpMidyX7y8SB1nS2P8kC2EB0lQB+4KMmYxSsWWa3U6hEffTsvDAbWhOvk/s/ZovKXv2/5aDUTCFhFHjpa+KCTTqhbB7Dsaxy1Ekhk/L7uPwevqLU/FGkkuYb67Tb93jwYtQmSSRRVLKhKng22U0fpgrk1jHTadYzb97QfDULgX7+9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+vb3H7ga1/zO8JIhDlu/cn9DNQ0Sk/VBwY/dIrZDik=;
 b=GuLQbInF/jlyH/4J+/WJ3UAyrb8sUwqtI3wdTou6fu1vT19z0eQcwshj4480gS/UyIU4fZr3rKdqLNhMPGQxjl62mRghwT2K2zz0yxQhZPo0jbgMMEUSe4PuvaA3IscFbSGvu2e2ALfQHniKK1KWoeQ/YgJH8WejWkTYLJPNwcPY/d4EOp9d2kjF68jInBS43uz4tyWlo8wT+LkT0+3FBNn9DG3zvO6lIgnMo3yE6nK8R1kGPZyXg8e2O8BjtQTuUt54fv0FcQEjUXFNnbaVfG7esjQ3uAnpWrjqX3j6SCRsd8Vp1SU5DqvBJBQa3n8Nid7UMMJ408cN9hSfB9q8Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by VI0PR08MB11775.eurprd08.prod.outlook.com
 (2603:10a6:800:311::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 11:45:52 +0000
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
Subject: [PATCH v6 1/5] vhost/vsock: split out vhost_vsock_drop_backends helper
Date: Fri, 24 Jul 2026 14:45:38 +0300
Message-ID: <20260724114542.734623-2-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8ddcce81-20a0-461b-a572-08dee9791cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|52116014|1800799024|366016|56012099006|10067099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	DTg/W4du7utSZv54gwZqtkKMi6KKcOovSNk7T7cRtNHuV9RAscRSGVAbxRdq9H4xMsPBWNvGJWVlXasE1knTxZshsSIbDTVan65pUBg2q4ejEaIHklY96wnjRCFpeBB6+G/2kjk0PqXXVQfk69X6VRwItnw4AMyf0KXysU6yOsSCxZU7F1VF/CkzDgS7uWhfcK1HxpsyXE7UVeN2t1VqFD90amtjsBOUNGJ6g+kY1IMxufqVbjgSe7udk5TTsQgsGrXB+jKEF47FupXiEdtVe0C9k0kz1AlSEoUyMKGhak1XdjZd0hfoOckOPpPJUakQerKsyZWYBBeNUbCHWo3a+aNmbC4ay7zWSJQamD81P1MC/PYGNSkQboExKlMVQ4ooEzcRNKnH1guWROYCvY+cWMTeXen/eqRiaYawlVLuuAi/TSo4/mwbckpNGml+NYY+ttJdX68MkLuRTewy84xpK/8jxUUq1+q5O8bCUhUOlkDQdLetQU+XYnmQVtKnkUgkH0941IVb2qCLQNcDiobsnRv730F8Og629sfN3Gn1SIg2IKnvx4SyACzowTMD+g8nAbg8k5VoaTCC2WvoaqmQUfqfAN3sMR6op9TT+Tgfs4aKo9jPbcNucgM1pllP6o8+48O0mdW2w33/Ml3xlQJ4f0y7T4ihrcFpnpIyu/SdUIgGc3TlIofaGF4ivClI0dDGGApbJARx3kj2qlG6OSFLutEDpmxLgwpiKJcMmE1h1PY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(52116014)(1800799024)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+nr7Tyshwp0zvTzKT46274qwsBq7pzKdq91LHtd09y4T0umszFEc62+D6RWF?=
 =?us-ascii?Q?QJ0Tel1n8UovQFDHBol5gLCfUD/fbqcpzmSb+meptnHa0x+H5CQC6wk3UGWu?=
 =?us-ascii?Q?OOnjzNSkD5PWWfeaK4NRw6WqbZse6b9idLmxpeplTrje60nyFLaPbF+duXVU?=
 =?us-ascii?Q?WG07YFr70x2UGrL9lQZhOK2uzitvEKMl7G+lqHP677wgn/uzn8m4goDBi5wT?=
 =?us-ascii?Q?c4lRLIjNXdVtlFItTC3V09+sRc+A1G4Zd9xC2Ck8rS+31IQwNM+wuvXEpMm5?=
 =?us-ascii?Q?8m58uSUkfmfA4d/C6QKWkf4+COtavrkbxPoD2SV1CfbtL0Cgm9VakXicxyKu?=
 =?us-ascii?Q?UXTmhEOp26XQVFzQWQXBq3N/ehoj1DsBloUDR7qFlPucyt7lyVyAKplBGuAY?=
 =?us-ascii?Q?ErjZUqkM2IPwlkoHOQmQLkb3F1bV00A5UA7vd2j5yMFKDIfDM+PFPsrwR/oy?=
 =?us-ascii?Q?i19zRF1WwF8m5/xdVdgvO72b6ruD2HXPsuxibVYr+aa/tYcLVR0QBX0yIGOv?=
 =?us-ascii?Q?pR5q0fSQQr62yRFpMSPYn0/uU271U9AYyHuL0ih/ttwqv9KK/+0XBMiZn65y?=
 =?us-ascii?Q?NdWfYg3iyaQ6k1PRQrCdNCRRDe7XUDrCCe4mtjD4Q7OzEAQHnj5RRtx+Ymvm?=
 =?us-ascii?Q?iiM9WPTgLIj3x7J95xwH19pfpHm0+C7fT49VB7+Igr1fSJtxqO/uEpOITmMK?=
 =?us-ascii?Q?opqEjRbJ9A2AWTGOhb+bmbPYcoE0OiAl9OmsQlL+nuAdbTnIA3ssx6J4J02t?=
 =?us-ascii?Q?N29722S4+NaZMxSqqmNdGkoWUmaUL8MKXH3cNLGsfK+AiFF4gbngoesN4IJk?=
 =?us-ascii?Q?fcS5N/+vJHNWVWWth90RG7VPx/v6SmxAbIadWfPDKQvJzhTy2Y2KY2tQt2hB?=
 =?us-ascii?Q?Cl3ncb5b1IIXe/9PdG0qhhBJxzwvPO5Xn6m6TDYO4Y4hXw7rL6N3WR7REj6t?=
 =?us-ascii?Q?/T3HrRxv2GrSMuzpLxYtoGbV8DQ+U9X1dd6du6AElmBYH05t2Fv7Wmu8v8oc?=
 =?us-ascii?Q?pSx9HlPtqKnqeY+KgdJjgtmdruaW2Y400WQqPjLdAy7dU2ybLeVatXqRswhi?=
 =?us-ascii?Q?ekmNIRrh/Ho4YCPRrhl+1qXb5WaMPZya4iBn3rSrgsCjmYf8GE1JwjxGmmgE?=
 =?us-ascii?Q?McMQnx513s6QRpWN1Y5rmdLfLh0b8O7Lo+QVgtmqdjQgTiGI6vKjXwes5+en?=
 =?us-ascii?Q?tpEldY3WSIuvYJCxYALPk4JDbkS4opPfZ9iSrTsCGUlBtrTZN5/4TQsLWz5T?=
 =?us-ascii?Q?kFK7cYco/5RxFMS8sDKZ9unNdxdSJxhNSZwHg3L3qIG4yVVM8j8I58okWUIy?=
 =?us-ascii?Q?+oGlaJkvJnjzHfzjOY/i7bhj80npQfMqti3XrBBxy90ukz8ylmE/9u1Aq1QP?=
 =?us-ascii?Q?7vGduXpTBBEqS1wxaWsmzurqpICmjyRtYVizwqlNckqlcy2JnH25adTlVuVD?=
 =?us-ascii?Q?u4l2Ay0Qwo0mqs/KDeoFzcL8TX05nghct96v7lxDgxX40P7xhaPs22JR2FG8?=
 =?us-ascii?Q?TjY3en/7VK7XsSVlqXAcsWjmDJ8P5/2S54IaEaKtAe2Y+gC/WF3rLAo4spoN?=
 =?us-ascii?Q?yfDn1kVY9vpEQoEOLa0g3Fo3vrz7/+DYRv08POeEO0EIOHX3Ld0Yk/9qctMK?=
 =?us-ascii?Q?jwjHR3sO9rtnE+b9cKYOWJU4kuNQscppvFqUuCMdL2sW9ohXps8YDGQqNKkS?=
 =?us-ascii?Q?kpjonQXEexpHXkrUsPQcCJJFV3n3cybEwjWpNqHTfHP23I0Zx6Nc3GXo9Tlt?=
 =?us-ascii?Q?Jfyw9ztMhwhkUOo6cymVg1t5JPW/WDI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddcce81-20a0-461b-a572-08dee9791cf7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 11:45:52.2100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXgae6WKZkpqKdiOZPxqHJJDFYxQzq6CgElJ77QqzSp5Niw2FXTzRNBxkTPWzxRXG0y4GFsm8aL37vHJyYeIxPEOylRV8Q0NjqOUiiWGjDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11775

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

