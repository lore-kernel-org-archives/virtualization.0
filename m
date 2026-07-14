Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023088.outbound.protection.outlook.com [52.101.72.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B32A4BC01B
	for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042223; cv=fail; b=pgmIUMl7RQQAuQkr/inf/fbO8IugleVMcWnH8gDnSX26eiVvbTq59w7CIEIeaY00lk6cGtqdAr8TqQp2Kr8Ha/CaCWFD/6HZgIxWa+VgpHBnR5BLLVpb5G4D4lL3eKf/EiEt0Sg7Es+uj4gvWCHKEInYtzkfsTqq3UW3ZE8UqHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042223; c=relaxed/simple;
	bh=7yhxoBZ/wxX+Ctp+AT/GMSPp27/7YYLiXHLe8jO/KOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eZhet6N9s50gGt6vxFooNNGlfZLUoeN7p4Bq1oDkJQoln5Fcx/PeWckPmkit5Alv/uzP+DTSpiKmEGz2FROPHeJjHnTGjBsc8bfffQTQfj/aQRhUwhgsybs0jef3C9LMlhB/xAZLqzkOVcp4sdDhprnK5PVQV6gB/slVVTp9p80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=jTJWbXu3; arc=fail smtp.client-ip=52.101.72.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jTJWbXu3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIv9eZ272Nhd0XmBbF8yhHRI9pUWA+6LgzDsubtSMTwR9qVGUim2idfnr0+K6OhwBJZcA3He6r+seBxLqR8IWCvEkNUuHnGAUmh6Zuab9PIgXDnCyCj3ddUTfdMOP1KIaLztent20ofRo88RMEDpMnYqhgON8rFg4YLw99XYW2G+Rq2roQ/uuV4WEu8VTNCl+tKSU8aGUjID6nqhGFTfGzrUJxoo9Cd+ixpM57HlVRU0eZiG4vTvH/x8jd71jC8Bigc7XXKKStZRQZ9k8/PcNAv/1Me68RH0moVOyccxOuLQk8xWPgbEIeFX1cp7FtX2GseAkf1iB8dm9s85BX1CQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IENLpuB5Ml/RTZriyLBBAEVfZVZ5lSB57FR7jCjqQys=;
 b=v+L9hgfiKp1XFdSgFV9HxrTA+QYdgr2KAsZJIFHsoyASQU5QvJoS4QAgwvX09xj2eeyyBkVEHbHz5hFkAEVNkSqKmOfYuyi3xGQP4P3GCb7gEg/uBvCO3EA/pZt9/b5qQ0yXV9/NYc8zjNzRJgEQ5T38M21GgwgjihHuOdUlv8W29sIFsrChVR/IP9DN1tFVMzPF6YrZchvuwt9S3lyd9jPJ2J1itA//EzzDhjYpftp5R76jBaI3BDhozJw254sK3gzDKggas1c0GDhtKAxT/VxAzlaZKBeKjs8tToq/49u4KN/0Jznq8galo88C39XnJ9ux8rCa03EVacI+d625mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IENLpuB5Ml/RTZriyLBBAEVfZVZ5lSB57FR7jCjqQys=;
 b=jTJWbXu3LdBm3ZIxrfogIj+D6dMi+4AAcNaB78z2uR+UwfixxrJxBiePOxBE8CvzkHhP6SG0dCzjsIjJ6GF1zowfAqrglnuP2oc7QA/l/oobr+Mgs9lKGg/Twc7wP/jy7LEZ/IoMIYmKtCZ8d7zrrWYSx4oSsc8N4KfZXht9E378rjWrD/1jXi4QBy8qtzlW/SoXti87Wadse0UgpUOSeJHUdpGNfVlb3SfP1WZmhY+4urUaHm6ENeeBfRkVCvyoTkFLNd7imkrdV1XGqe9w+ruNtHQl4cYfxGp5XcqbJ72WgjzdY7YfA3N6zohfMztimZ0cs3qw4B0qJib8pdFlIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB7692.eurprd08.prod.outlook.com
 (2603:10a6:10:3a4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 15:16:53 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 15:16:53 +0000
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
Subject: [PATCH v4 5/5] vhost/vsock: add VHOST_RESET_OWNER ioctl
Date: Tue, 14 Jul 2026 18:16:38 +0300
Message-ID: <20260714151638.143019-6-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7845cc5b-6772-4526-4636-08dee1baee87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|52116014|7416014|1800799024|56012099006|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	946jBYZ45mAHPBO33hxS+GK/jZRPOuJ7vB447lcUm/HVNwBZWnQr2dX9VVsOOmuFpqStIiz/5/z+CF7e5yN+PcQMp+k2lNykGIKhcQGE7cmV+8FLimRnRLM6GU4dmclyOsTMhCxRIdnlkkwohkbh0Bz1BWqnYeHbjur6wYzKzmKQJrjH5gqkbSxs1Z7epDlx+Hhgym748iV6a4COXU/lEHNLeSX8lFRmQssLVCdJW8/wIPCUhL9NATkPHRLF9bERPkOnl9p+Xm8VGhMkw0mALFlZkIREDk9EKBK/aRdBkYFq46gU1pOLegoQZG/R4igs15nVg0XvRScuKzDY+eBCvMS+94RsHG/2hVdew/iVHZRPoU4twMMeYb6Cj55Ji9HT2FR1dqGx0EEuEimNlyHKnMWPjQhJW+V98n9F71yvH/Ec6MSYfTYm1gZnIvrQkRQ3shq/LndzjRT00nNA1mXianwPTZ45Yn0eX4Lo+otLzjr7k4KOl5QNVY9iLCFgtROznOk4+Xq7pr5MR4DMKktXQtQP4x7qTO8dE37QjUrhoKVAoQJT2EyjZX8KKV+V5e5a2d1EeEvaSkgdooO+rO5Ju1MYLsvkaSPWmpUETLB//3iCwEeBKaxW90JK9tMo9JWcJ6BaIH0TTd9WHyJmO1D2Q/kxT4kh5FbjKmK/s7hwW/0Y9acySXbtrOiFBoSLifN/KvO6YalGcCrhZch7pVXDThXxIlcemW/K1CRxY+HA2v8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(52116014)(7416014)(1800799024)(56012099006)(38350700014)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o+GjTcPv04UJw7He4lKwzVv5AL2XcQPkxvuLjcMnv5QX8afjRfj4DfOl4gfR?=
 =?us-ascii?Q?UgdMkLal6RrfO1fXDv2FSRt/Pz/jTiTEx1gUg9NzXjBsvbByWAM+W0zYOkkP?=
 =?us-ascii?Q?l4yBGiRhcBWnf+BW2LZDAPbs3wotWr10s9ysvzmuOfUHu1cZWG1/VLeSiFZz?=
 =?us-ascii?Q?Y7BA95Q97JSauLP1AhRn49x+ctc55N6+AZ2ShqRw5nOuf9rPpPGVaxRU0kWr?=
 =?us-ascii?Q?hPVh7zJNQHKdPpiDAYJGHc1qZlO2LmszI1IdqBK8zJgf9j3Zj57wMKgg7T6n?=
 =?us-ascii?Q?3u5Hh9iCfMeFfXWSJj70/fABKZ2y5M6dhfcr3xEBLytMpM+07hrOqbFJ/G0f?=
 =?us-ascii?Q?wpoThggBBmX7xZKr98OScTiBJTNFRprw/xDispSth0w1ifsZRXIFo8Kljubr?=
 =?us-ascii?Q?C/RxMnP0zrne8WgLBIXTxAIM9hfdWRNi2sF1RhcnT/4XwSJMeho4igUe0kzo?=
 =?us-ascii?Q?VvrUWD0dD9d8zwLM5zbq1EdmGTzLSDjpFcsjtQS9ZiyEJTO2vM/CtGNO9xRc?=
 =?us-ascii?Q?oqhSCllmLVGZ+TrRPdm0u0+FUnQwPoVVKXa/xs2/fgnnfg7J+p+3FutdAOij?=
 =?us-ascii?Q?6WzNM6LpEuxs/0AarR0G0bvvWF4bjovojPo5pVOTGTaGjls994H2LFDcDLkC?=
 =?us-ascii?Q?qhclLDc28BBHhdkW6iJ/d5AbwklRgu+YpW2kGqJ/z1b5A/czuw/W86W8U8XW?=
 =?us-ascii?Q?rCs4dEobw5DSz7ZK9QyeRimsHNowJBVgGyCEggw4mzPKYNJAY9NtNRH18lxK?=
 =?us-ascii?Q?fbhbqATBTyIx8liXGJnrKWWF0vLTh5AC+HzfG+XqTy6xMrf4vTqEbXjLnThZ?=
 =?us-ascii?Q?IsQjYQcrz69aKLRcLXIhqFghYMmU3jsOJbUj4A2r1+9o5H0UwR+bdb1y730O?=
 =?us-ascii?Q?hEZzfyEbffoN8xqAj/2tA9kXs6gVNVEsoqV++m26hQDLRrPrB0/kr4oNCnWB?=
 =?us-ascii?Q?W5o9YhWb4E53uRntGvCtCqcm5TXVsMcc/mtqUgLRLR98oxR5EMmS232D7onW?=
 =?us-ascii?Q?+CzmLjtKdMmxZPM98OQcK5BtX+qN9ZFR/JIzvQS5E1DXrKuV9oCO+yAvzCbU?=
 =?us-ascii?Q?onLFW4m+Haz012cKwAxIpkSZZTAVMSuxYlBPp0nM/ssJsYncCFBvU6jMfRiO?=
 =?us-ascii?Q?S3FovA4xUJTGyt2RaOVm/rd+RTOjumi1XLJ9pz9T7wh1Lo9IW+fuoof5NiZ3?=
 =?us-ascii?Q?KABY1aKdLZD8Ynu4K7N46eB24aMlwu1Wcibdpynuvu6nfapmHk1UgQLtCgI6?=
 =?us-ascii?Q?Rpb6Y0j97G1RjlYvJBLvC2pQ2VUO0niouqDqSGAraY5wKory+46XkBmnPq8E?=
 =?us-ascii?Q?0mR0Tfw5MQFynzFO2m7L+XtuS1KQSpwZzLXfx7csyyXRt7zdQjLRCYmSZw+p?=
 =?us-ascii?Q?LH1bDvqzXxoBQCWB8DH04HFVLe7SWDLV81pOiPv1FPHkyF68YR6ynxVrNx48?=
 =?us-ascii?Q?djUcU+w0XXc0zdACMqC3wn4uI3s+hCrZ/rB7nrIr0/WLu5GdpQ1MHvSbm+Mc?=
 =?us-ascii?Q?TKP/C36s/zmFpylciQAMTnzrqLkGhslePyFN9j1EBoMfGx3EexxX2BBhPziM?=
 =?us-ascii?Q?Rz4WFzU8h4ksp5f0AXmEWxYjQtJ1KQTtGKld9OXpscA6aZ5ADt8zNU3xqk1P?=
 =?us-ascii?Q?0vxvBysJD8h0Tf/578lOU/bqnX+KaSb+LBBLaD2d31faXHrQD5Fv+K+Y/iSS?=
 =?us-ascii?Q?hyuRxIaPwx8BPcPZOfXKJYkQKEx8G7i+ZVpL/GG9Zgo/3qEMZk4Qh3Ak8WYl?=
 =?us-ascii?Q?3rJebhAbrCjzLhQoQEAPij20fWXQKXg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7845cc5b-6772-4526-4636-08dee1baee87
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 15:16:51.6529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +eZaUA0nGl029oPphJ3/jxMHtHMqW/iXtAM657Ywtm9iH8JB62qXzZs9iMswijHOWouJ1qPJAtQ9mPqXkWWi0UkDxgx5wYaS+xgXc40agM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7692

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

