Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023142.outbound.protection.outlook.com [40.107.162.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AB1344023
	for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782151117; cv=fail; b=CfVEyqQbhbEcr0AfveH1LdTA4IKtJln4FKby1meG0w4NVmz4cuNljw70AyeCpS8yynlupV5feDea8v3C7u6wmNtGF+UG5auwxB5sbnT0oWHWp9gttRT14SmzEyQEZhhlKFBHosBaCGPLPvtBqui4R5j6eQTsB39fIJ64QBVx85w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782151117; c=relaxed/simple;
	bh=zw8y82FElvyAh2wPwp+QVGL+mWnTMGc1Sv6ISsjHskw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T6M1W8ZCQM1C4Q1ZD9qYiipZycC7q4muqWop94vzmH/aZQl7AP5oZ0QpBwNlP1DrdiNwMdl5pcqhnahGcbZyLkLM2XA+rB7GrYTY5TsCwn+qidt1Fyf1ImbJjr9nAt6M5HQaPB4mVX/rShn+dhZm0qJm1MMlZcWimkHORYiCM6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=vT+E3tjj; arc=fail smtp.client-ip=40.107.162.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vT+E3tjj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKR39duiPPFxngZZJ/278uXt4jAjY8gVZuXeuZFTDAeKH0ylNob8XPvbBBlto0KTT5X8lgOMTEsq0KdsX1FNCAPv2hcA2WmdhrifAVj/1cxf7iUsl3N6z47lvksn36YHeNhtsHwyYGsIaWGj8tMEMqyNa9CdSv4WKZeaDAlh6in3g5FRbqy2RBCqccwKm2IOxsqFsrwlVxysk7ga9+MZmnAIPTckCZBVWbpuUb0Li8a1GRSricQ+7eZ65nd+1OAq6bxLvjTiAwnzP1l4VvCMFSK9CXl+qUGikvIdBivaSB/NNmTn7dXtVsejFAisUjkGBRtNxGQAKg9jlhgQ2IYCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpcqnaQDCC/IyXne2EM2T4RvOixxG7IEe5O8uoV8zgc=;
 b=bj+pCZESunVMK2l/hjlAQbx8cAjN2CEh3oRKueJ+HmTK2+HwFdWqEIMPv+82Rs/fr+AqrniwO5DY6r+MPV6TGIoiEtgTOiio3QDeT9mvzIsnnDX2L+Z31nRu/gk9dkRuFfj2A6IPnfera4s+7a1sqtXjO2djQIAhxRcTnCugTuqta3RfoKMhmDKYAKQABp45wjT66JkkM8K6BumE++AzAlf+rry9nkkHIQNMJ9BsYKn7UGN+1WZTwNAqYAcH7/FyqFtjkAlfSc1hPIRPmTYnQO0XS0abH2B9Yzh6vFxpOhk7bxyVNK+SN4H2by3Nf7G8jvjPIcaG5LlAh1lod9drqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpcqnaQDCC/IyXne2EM2T4RvOixxG7IEe5O8uoV8zgc=;
 b=vT+E3tjjqchzEFb7FC6E9mN33ukx5LTEhgPxLKtn9vfJeSa91OP29xB6NCCdtk7TW9RY/xpdv7MbMCD8fjU36gM5O1Nfj2QSCMrD1ks1bIJNzehZNmmgaDBJLMiWiCLMshZHgUKZCOsBPDfhIyzzjLmWC8uqt9kcgs48WvkEYQwilbWpfrdOTeiN6BcaplnJnx3WSDdcHZ78ox+RpASkYHmVMwpAZDyf0Z2VYEgF9expVCY5BCOieh3IZTUZPuyACggrgWR7H/ccMfGvoXmqXWCdrT4RY/K/jlqKkZ4GLS2ARy69bZwrJ2xgFIr8ck0Zv4KOwMUh6JvX48KXfr7ckg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU2PR08MB7375.eurprd08.prod.outlook.com
 (2603:10a6:10:2f3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Mon, 22 Jun
 2026 17:58:19 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 17:58:18 +0000
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
Subject: [PATCH v2 1/4] vhost/vsock: split out vhost_vsock_drop_backends helper
Date: Mon, 22 Jun 2026 20:58:05 +0300
Message-ID: <20260622175808.508084-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260622175808.508084-1-andrey.drobyshev@virtuozzo.com>
References: <20260622175808.508084-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0012.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34f::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU2PR08MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: d7fb497d-4f8e-478c-3d17-08ded087d74f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|52116014|7416014|376014|1800799024|18002099003|22082099003|38350700014|56012099006;
X-Microsoft-Antispam-Message-Info:
	4B8WMs3qS5yJw+7taq/H+c+ob3tNRF6ZqTiW5s7g8q4Mq86kI6AZ0G6za/GBWmdqnW8PD6wRIjsv2W3+Us2oEpK18FACJfNh36FhA3e0LqrMxUH0XJJF2HGXpJfF0LfOAz85dpHsiNE8sqpz2vrB7Tu+4D5yYwLV5GwDzUBuJcKCXHmsbuKwYGRTwCwxm6hE4bRLiIiRvhWkCgMha+TynJElF0wDgcCshnZF3Hyhocl4aoj4JEbExPFGNoeTaJMi8WezB7OfoU1vy2cG/Z6ngCivmaWugbMu6HZlBYV2Wl85JAGZiw+TvYNYFTdkndxQwmBQWEc8AzKFebU63O5TSXIS/HeMzthaVs8zCvBwyZAFA6ghHgB/1d1mAy0zXC/eERvzKKtSUn9arJ4aEhxIvH9BiE/H5TeY/3fUIB59QHitTcKliZxEERd+DZ8wD4+8El9yjjaqdxas0O06lVL8NgneCwtcqWNzrnEQ2QREIryFkZMm10lN7jatYIgL7gH803sB2DwRREzwGTF3PZsw8GqooelJS2qPPFpWpKC7i9UOgdDu63j5VhIGhsy8efsNCmJ3O7KwWyLlrzKnWloc4icf4IoK4sr5QAAllIkgOll7liUbcwF9tjjjhwFrxJcJZT87ie8oamg0g2KYntt0dA5u+QOTwZRjdsHMVzzJgzBcLxIzfsaauOHLZhyuKgkzMcqmIF9tI2In92MqNUJpuP9WovKkDgWlHokCUgBBDxw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(7416014)(376014)(1800799024)(18002099003)(22082099003)(38350700014)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YD7QTIAlJWATjIoag8EaibxmcKGr7mEXzpni4G2B5XkfS0mSF06ho56FRUME?=
 =?us-ascii?Q?HSih/mzcbedYwhHFpZVslExd+ja5zYWh26bPHRqYzjrjWFXnOCRUOEnBmsxh?=
 =?us-ascii?Q?2ph12GrsQ3c/nP9RQxP5MlNacFjy4D5ONoMO2jPBvc1vTzApfprM3adjxIBN?=
 =?us-ascii?Q?kiUn0k1Fb7kecygXDo0/H+qybo1oM4IadlTwUY0J/Ei7/YBNO7g5/nbmL8tO?=
 =?us-ascii?Q?PrPkFoR25DISvjuKjJWSz0qXXVkF6Zq6aZ0/o7aE3shb4u7NUAFR7ve9OWnO?=
 =?us-ascii?Q?CQ4NfWHyEZgY2bi09kvrTi9YTCT0zCXA6UpW8w8t5EEouBdEMDJByk4p9wL+?=
 =?us-ascii?Q?JwkdIOBorJOnVvXzFTJCTy+I7kBmWyKhx1VcQsfCxRNOrzkR7E7MooezMNHh?=
 =?us-ascii?Q?BYrpWl7KTKQ2GH38N2YUSmxQRU4lmVPJ8FKxcHx7hyky02zcEXCJFmYi8WYy?=
 =?us-ascii?Q?ozIlxjL0YfoXlj0LMEEvhX1UVDIk558TlLW8PP0uOQ3Dl5o4AjtJrSjPD6tI?=
 =?us-ascii?Q?1LkQCvuCmtjyXelelOi/X3t/dskNmpUSFMFMBbUFWQrAWpTEwdWP6HOLNxgj?=
 =?us-ascii?Q?zgF0gTKjZr/EQ2c4Ovu5b2IIEj20ZWObvtyneMhGwQ9/T7gjcovDsn2/hCW8?=
 =?us-ascii?Q?IPE0t0wE8Hk4zMCJwo1z67FC2K51DO2F2iZxM5fEbt9LZjAHYkRHfLV/ypL6?=
 =?us-ascii?Q?ithCfbJx1vBUyXxYTZP8n3XXQ0oFYtyo1RQJgkDpyWAuuQonjU66jmEMhmDx?=
 =?us-ascii?Q?2rUNrt8rI+RY+rN5aw5xi/bZNRgHp+5HRInYvvXBwKeNkciTJyBMiXBsnnM6?=
 =?us-ascii?Q?HT3vx7X3mEi80ye6HlJmFoVgM98sdRSpKXyykyWtB+hBhebxDKnutZZ5/JF2?=
 =?us-ascii?Q?YeZPwkK89cfT449oATgdQmILdH+W4HzpEzrEpxTQnvzCs7n9Lq36nIpOa6nZ?=
 =?us-ascii?Q?D4qn8+bbfDmlBptb3HTe0yO8VWFzLVMvmp4YZUrQIgYyebxS1pfcL/RyyzaO?=
 =?us-ascii?Q?HYuGtipAG35OD1YDgpj4m5ZlqIRjLRFMDvsmq9L6eeCgykuQ1Gc1xz6fXWP/?=
 =?us-ascii?Q?TI4VHbYdG03MmSMXuyDycEgBpxqR8tQ4T2IpY2gx/W/QLxFQhRbAJ5uZv7Ok?=
 =?us-ascii?Q?ITZmuxEYaOh0teSbTbAzJr/zwro3vYLVFeKBPrn34YfeCLq0Y8okWOsVFccq?=
 =?us-ascii?Q?Ewlz3R7qS+GSgSXsswi0juhUACQIlGUghwhKCwEDkdSh4jua82kQ9YoNuwJ7?=
 =?us-ascii?Q?9ZhR4y7itO+F46Un3O2DlEOMqlYd0V8sn86fhIyMFM35RKX2U2R0DJDMDtDi?=
 =?us-ascii?Q?7Thm8svG54PhhxdZ2KXWOAksIWsbleuNMBPSFy8aYnHSMZTjl4K0o12tjnwg?=
 =?us-ascii?Q?wYd2kmA+PTbcYVMNIEpxsKDqQE+bYwBTO3Q6m1vWUEAa9mAyBmIOPfVKpuPc?=
 =?us-ascii?Q?Kf7JnmDt4U2fv7TG04ehFhYkaZdp+W3OaPUoWczRwr3AfEj413qRVj+zv4NQ?=
 =?us-ascii?Q?B6hxM2UA/Z8KXIbqMdCIvQdRtI2Dn59JEcVsiSXJSuM5Al4m9y9/oKuUJHJf?=
 =?us-ascii?Q?b/V3BsLwTXuzR+tAXqrIiTwN+vNOXIYQaY/w5+nQgjRNQNqaZisyQMmptbg8?=
 =?us-ascii?Q?W02iZUcCKhTrQSkG8Qj4dqdhpeyBw/3uk2S0sj2OQVwgaPsf36oJ0FNz38BL?=
 =?us-ascii?Q?DNoUJqnIlINdP+jRi5G8avXnI4Ili29XZLKGBw5ZddtYJufwI+HLBR4ncC8D?=
 =?us-ascii?Q?VFobZ7SBHwVpr1KPR8rrAyCqzhyw+Bc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fb497d-4f8e-478c-3d17-08ded087d74f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 17:58:18.5934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PAQ+K4sqOlmIzfZHFgaSQRCAuEen14DxxWNWWwn8bvmXpJJYtj2/TpnsZ01CO65lNmBWfABnhNId8XpyPVZuLwmf0LZKSI1ddV+8Jmo11Bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7375

From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

Split the actual backend dropping part from vhost_vsock_stop.  We're
going to need it for the VHOST_RESET_OWNER implementation in the
following patch, when vsock->dev.mutex is already taken and owner is
checked.

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
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

