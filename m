Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021098.outbound.protection.outlook.com [40.107.130.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5960466B1A
	for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787139826; cv=fail; b=bO9X6qs0N00Ke+2YKYMzwINS6Zod38sb6HHUvN84EIyGGndJCBx2XDD/+WODAVV4ZShQvSXkAxSWv7I48KbVZTR5yoSo+gKsH63JZRKGqMpMEg/UKxEy7cxfWPqqbJ7IwVT+cGUk6g1NriBeoef9c0oUmgkkxHC+eemKZRiCeSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787139826; c=relaxed/simple;
	bh=ibrrulIXx1vhDK66l2rMCZqpXCE3chx+w9rShqYowRI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aRPPg4pUIE09XUYRFL50K+4sdQoenoOPsTK4Vv6qgyOJIngm/SGtRZuEBotmiM+z8BI03puSWdY10E/4k7EYdFz//8hea1UVzvqMtOYcIZDEE7JvFg04H4YhSZprW2lZkZoLMxbXtojOgxDynbCnbzThDWPFZQF8PYYLv9yDCUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=vK+0SMG3; arc=fail smtp.client-ip=40.107.130.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vK+0SMG3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7xmpjsNNYnHJ6a23hOMXDmrT37OmCQj4Kkvj9/lUx5vRP6qy+imVJS9wVY0MEbdoT1xqDBqEa2mmLJpz1g3BKnn6Vniov8S0bLE9/SWQ8XFGaGbrDX3kJQuQz80PumpVD44q3JAsL4dTCNIxBcJ2zQKQn994VldqyW2EzMJJQtRV/aTXn55q2dNe8xuCTwRdYGcNQx8dD3WCNS8xUytNL2/D3bjch/kEAdpGNESuPtpSACfNigC+7UHABQmlLmqY3OnoRwXXYj2iZ8WzzCGAyGd9oZiWNp8+bisVrddUFVuzRNPQDirgaVLCjoAoay09FAHb/gIuob4Q25nIPDEGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0gvuC7fWbLQMJRHs3G9XYHgSkfvR4HXxWIUA5k45nI=;
 b=MeXoJtVSczpSgaLf8+mDaTrGR1i0PCX7s9C27tewDeofmjg316z+ejULmD5nrS3mS2jKCTmW5HTRbTDw9khwYLvY5mMiTtWzUPYnU3E4eTpo0gkYWWQXA3dLFJBbbt9sFMtQGVwg2Cqr4MmQoym5X3/qAiCIviyx1M5F6P1JgTjCEYjcgDC9Aub3EID5OHfEMtzkbvHio+Urz5Wr95AErX/ux3xjTE9wVqgqAeDZP2XIqiu5/NC5UVUqJgnATRxozlmSiHMB2Bu7dyTWZE/qm3wlhQj8MsL4F2GeRkY87YkZ2nDNzipyJMkrCs+IjTNs4I9VJVQIv6rg7teHgZetKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0gvuC7fWbLQMJRHs3G9XYHgSkfvR4HXxWIUA5k45nI=;
 b=vK+0SMG39kmcXA/6hp+NyrjCJ0ot+EE1/pv5z8xDOy0dnJz5SeQ2+w2okv8JZjrEoEXJvRH553Uc2fv9JoaspzOYoIVQeaSqlMBi906K2h5SPL5xYRsNx5OS1yt1rGs9QG6efXeww3TzVvyVsspi5xBrM/IRjStpBOZs49lEkbzbFvHp6Oq6cmygsIOaEXWjDDRs84gOTBxvdWfjZ7aV7EJk/CmrFJH5uEBMXZ6a6ZnJXtzyITlesueO+cNH//CCciSr4o2QSG2+IlClPiGn0VSjc21TRV4+mjahIloCt852v0ve+OkdrEsOfqgNJ9pnRIYss1B4A5k2i/s9HViLag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com (2603:10a6:10:52d::7)
 by AM9PR08MB5954.eurprd08.prod.outlook.com (2603:10a6:20b:287::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 11:43:37 +0000
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::1b2a:832c:d136:a37c]) by DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::1b2a:832c:d136:a37c%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 11:43:37 +0000
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
Subject: [PATCH v2] vhost: clear vq->worker under vq->mutex when freeing workers
Date: Wed, 19 Aug 2026 14:43:28 +0300
Message-ID: <20260819114328.426131-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0293.eurprd07.prod.outlook.com
 (2603:10a6:800:130::21) To DBBPR08MB10650.eurprd08.prod.outlook.com
 (2603:10a6:10:52d::7)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10650:EE_|AM9PR08MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ae54ac7-e220-4caa-e845-08defde71b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|52116014|18002099003|56012099006|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	cSFDCMsl3sVPs3A3t+56KISpZetJOXyj0njmsGUTSNn2bpmALSA/FYNdrZJYq+d83XcNO8ILW2DLwDqZ7WwVECaQJRUdCm3Q/yihZ9pp8HF8mrL4MyJsIQRvk5XFPxFfCsIVaDGAHjxtZGvZr/rx6lVLpyuKP+H8qDYrYkBNlY11ja80Em+Pc3foTDk2TvQHf6cGuXAil6WcZv+dHrfnXUN0jte1RvVHA3bImxGoXbKmp/AtJnRXJa+2cQFxM65T8rRTTM0YcLDhYLci/ujtKDXUjg6slVQEh5J8yfvzmWv26ZwiPoYz8izozriRfcwXWHj6Ypp5vjThXppFyRpgrI0c+h7KeULVbwbh1A2eYI9W/MM1+8LN7KQ83ph6Ql2uCz0tgumMxsQ9691pTQvP1Nvdhqq7A6adwYrBViueWxEAM369KHHPLDIH+d1vf9WHBHd4+/Iklrcjd5xqqbw+mcCL+U0FD/cTsAmfy8OQVesv/HRGUC82y4/prejHJS2NWxrd5PniDcyxNO49chd8wpOlglZm9/gVwO/nMx0PBlmzDLnnYYTA0OlMFJO9PG32H6+3VdQCQtkZfMZjPNpQrIIefyjbFdzOaCZei0J+RU+nzCgk7mzrFeWFpysnnBy/S47hFmbbBwoBpyzgQzuvOInUjX0ooSGBnGGT/7sn/5lBNnuPScH3GX2jsL09lqIugujXGfkiftkGKA5ICEK3zEHzOyjWxxehMkXTSpSdJZ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB10650.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(52116014)(18002099003)(56012099006)(10067099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9g7reWdeokWktN/eLUKF4U/xAmAv0TGP89h/Osv/xcFzWJ0bV4YxEaVDczA7?=
 =?us-ascii?Q?17AVRMKyR+Hk0krA71+9frrF95Wp89BIks8WHG/IErLcrvuIp0hzUt7adSlz?=
 =?us-ascii?Q?PHBCR/XMzQr986Zk2jAMQbD/fCzzsQ24PXksjUm/tmvV/AAehTFGL7susFVq?=
 =?us-ascii?Q?23a1IajjPyKtEEjfib5ji7nELyH1Y8seQYb7/XtXoUWSIIq0/fYta+wbLh2v?=
 =?us-ascii?Q?CirdBeiFH/XoNS8MdfcNyj+VILzJnhDFpqf6//YdjUvHZVJgEDvHCiYG7Xh8?=
 =?us-ascii?Q?C2XYS/1m5h75oW3Zf84tDITGQVaUzFB47F94UuYcQoX/ptyccNYBlC7zeXWV?=
 =?us-ascii?Q?lp745njlZ3I7SvelFU8lTT+31+dKPvspSxhvmRZFux9CVrmKVc215HVeVF1N?=
 =?us-ascii?Q?YGPPSTmj58GFB4IX6EW/faJwdXepsUyE9t/6qE2HvKvbl5AaAAq5/EuzSEqT?=
 =?us-ascii?Q?b7KGEJ1a6wy0HIAD/LkZrpyf0vWoa2V6T3xsAPEatxmSxZXj6fH5Z6CR00D4?=
 =?us-ascii?Q?J/m+BW3GSmsl6Bn959ttcX0YcNtwtmhrgNtN3cyh/gxX+IeefnXoY4JRbR7v?=
 =?us-ascii?Q?PuGSv/UsbI1xyfxo3kUossKTtGkPffX5GlaZHpXnkDmBarv8yrgLLLOluE7N?=
 =?us-ascii?Q?mjg6nxnHgJfuPtq3UyYmRuuyAZeFNihiFwpcscRoP5fjrDXP5dJ8WEtKDPnd?=
 =?us-ascii?Q?+nZRGszqY5bxLZPN1Q+BRZaZH0RFKrcpbZzAt7EmpvbZ2Gk0EYdSJgQzCPtj?=
 =?us-ascii?Q?iRCV30L/8k6QM/tBCmDmqBsF40OljwY+O3Yzyp+dJ2Adk5oh4RIjBcdAR/56?=
 =?us-ascii?Q?Zq8VUURABkVnGiUBxfUdQFBHq16oNCFVFAz1HZ0TH0GMIeDYYyMXHBsJnUit?=
 =?us-ascii?Q?ksWgFf3yjNlzymOzQMf08OEjV7WPpPo3izgdYzQsmQULdS9F2SrSbBGDJdv4?=
 =?us-ascii?Q?2Hy2JzidmAEMix/Nk/XsGGr8Kaeq+AM5vsxolmZkClbOyLEfqhGBmGJ3p8+9?=
 =?us-ascii?Q?rrxFdgwg/mMk7OHlTPQoEwQk56joGoOPF4XaZBdkqaFvDcNoFbXIy0QPC8I9?=
 =?us-ascii?Q?OZTGuigvdhxJTQOwUPupkCWr7NXYPU9EaL4N4kILjwIhNbDmxBwI9EJFv5JF?=
 =?us-ascii?Q?9ApH5QsfeI9B38U8Zsfg2itk6H3/RPXF0UEykv8/FFpoT0KCeUtH5QoJg572?=
 =?us-ascii?Q?2gpnd/XldfpJBhW2pvhp3OXIFi5WrwF7G1rkvSA1YWn0wRpCzuYyimPAQHy8?=
 =?us-ascii?Q?dSvWO6W9MPeTxEm9X8ZfX73TuTEsTFQ27LgPhvuylvy3YkYVKGzJf8wWvHgu?=
 =?us-ascii?Q?MZUF8rgPdMRR4I7Lp9dWNizUfFgPTcGQbqkI6Pnttt4teic/YA0UjMTT7vQH?=
 =?us-ascii?Q?JQW5SoGwpVo05deBdHkAg1JrBq453KKc03NOjSapoDKnE/u1I7UeXpeQo048?=
 =?us-ascii?Q?aeKj46vQOfGzz8nCqb1AzFlDTkLRdNUnBUzpDXyFF2NU1iGWbKQpWfAXrdoq?=
 =?us-ascii?Q?amJzHAdppjfvuhlS5vbL0udCPG0GChnoAXBTjQqvX76KB7Nq+4paXvRbkc41?=
 =?us-ascii?Q?AGymNqY+fpL6bXJmlFJ6O+kX22pjJFm2XYuJtgrjDrzJj1DPCKvdnbc0GSxA?=
 =?us-ascii?Q?doA1ye2rFNgsR+dy3Hr9bwIKnv7Y7/qs8YhsX/Yt7i9Dptkz+u3Sy8IDPafu?=
 =?us-ascii?Q?N0x8pM3Q6lCq5MlIMzjwEWYa1Vy2Xd1rp49PNNh+ha7nflNt8O2VkuAFjobg?=
 =?us-ascii?Q?GFC6hGvor+ZxS12k5Oy0u1TGXBs3OYc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae54ac7-e220-4caa-e845-08defde71b7a
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10650.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:43:37.4572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p30xVXJCMB1pWF4pVCu5kCyhSv0Nm5cJMHro97ssGQ1DvAKR1D1hty2KmmSCJ8Ws/4AEjrDBOKV7YMVQn1Nf5rNtGRiuZJXpMaf3DAMd42k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5954

Every other update of vq->worker is done under vq->mutex - the worker
attach/swap ioctls and vhost_worker_killed().  vhost_workers_free() is
the sole exception: it clears vq->worker without holding the lock.

The effect is harmless in practice, as this only happens while the
owning process (and thus the whole device) is dying, but the lockless
write is inconsistent with the rest of the code.  Clear vq->worker under
vq->mutex, like everyone else, so that all writers of vq->worker follow
the same locking rule.

vhost_vq_reset() also used to clear vq->worker locklessly, earlier on
the same teardown path, making the write in vhost_workers_free()
redundant.  Drop the clear from vhost_vq_reset() and initialize the
pointer in vhost_dev_init() instead, so that vhost_workers_free() is the
only place clearing vq->worker on teardown.  Any work queued while
vq->worker is still set is drained by the synchronize_rcu() +
vhost_dev_flush() in vhost_workers_free() before the workers are freed.

Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/kvm/20260721102325.1BD6C1F00A3A@smtp.kernel.org
Link: https://lore.kernel.org/kvm/20260724153334.1BCBF1F000E9@smtp.kernel.org
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---

v1 -> v2:

  * Drop the lockless vq->worker clear from vhost_vq_reset(), initialize
    vq->worker in vhost_dev_init() instead;
  * Rebase onto Michael's mst/linux-next tree (with my previously merged
    vsock patches);
  * Add links to Sashiko reports and adjust commit message.

v1: https://lore.kernel.org/kvm/20260723153310.745855-1-andrey.drobyshev@virtuozzo.com

 drivers/vhost/vhost.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index a0c1d54019aa..5764a54ddc92 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -392,7 +392,6 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 	vq->busyloop_timeout = 0;
 	vq->umem = NULL;
 	vq->iotlb = NULL;
-	rcu_assign_pointer(vq->worker, NULL);
 	vhost_vring_call_reset(&vq->call_ctx);
 	__vhost_vq_meta_reset(vq);
 }
@@ -613,6 +612,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 		vq->heads = NULL;
 		vq->nheads = NULL;
 		vq->dev = dev;
+		RCU_INIT_POINTER(vq->worker, NULL);
 		mutex_init(&vq->mutex);
 		vhost_vq_reset(dev, vq);
 		if (vq->handle_kick)
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
 	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
-- 
2.47.1

