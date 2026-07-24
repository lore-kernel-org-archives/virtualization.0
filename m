Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021119.outbound.protection.outlook.com [52.101.65.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38E940BCB2
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 11:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893569; cv=fail; b=MWRCiA6exNXoWNc6sIrBanXg9YTGre/ZxG0Kijb3y47g7nV2qlM4THDZo1qUnnmMubCMqhf8Jc0CSDrya50JiAo9h04ZL9IrzzrzsJBkFJH9qFpky29M/BYJSMV5IeyWsR1r2GDVNoSiuVTF75YJRjyEKsHAZKxGkfUxwu+JrmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893569; c=relaxed/simple;
	bh=l0+2ieEzqXI6KiK5z3yF9+DvjFECEhIWjYpHQcPxte0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qjgSBtcUfuhA7uGBp9VtGmUl6IvutsHRk+WGms+VbAfiW+kiWQndxC8HDxEwV7btaXI30l9+/u+fjJs0Avqaikdr54IaTSlYblrfJjy+L0rqLr+n1uGLj7rxLbj3EhPsv6nC4P2sArJlEupILfPld6Vt4RI4osbsn9jzDUhNyj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=X/jTiFra; arc=fail smtp.client-ip=52.101.65.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="X/jTiFra"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJD3m0Gc0vkUIhUClOMajNejRu85a3hDvOypKCY29ZSOb0N0pYNq94ns2sRM2KkvL3jx8l18FF8+OeugAxaMd2CN2j9FdvYl0C8Zc6/cy4SJXYvq+qep7Jz9mso09h43z0y8ct4R4SiLxoJwtg6n8gfklkk8ipIRIft8vE2ojuR+7tvBMcUW1qndzAE/B2qZcQNRPHP7zh6PTZOKgS11EVZt7jwiyAm4hn7noqr+kxcGh1waxfdUzFd8E9+L4S961OmllWwCuVDVreQlXyokI6T6JYVp4fiXRU+RkxtL2Thoe0CS4qY7J7N70qZq7Ilm9wjJSanwgtthGIJkvRokZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hC1LJ15Enwc+q+qkrePWun9zc0LMVoMe3tdfHLIURaU=;
 b=GzDjMNcSqgO9RKCQZ4RZDBB11OQgOeay+h7XTanDfle3ZcSi1OakisEYQHBrGy/CSEBJw+NC1XEM1PCP5nWnuzqrpjmh/qJ3/GNu0O/wDcgCqoi7NuWSow5uy9mSgpgost9MUBvNuy/oY/IAhalDQa+TAzj2XQ4WrLEm8Gf0p7lyTsjzHxpp7GlIfG4S7HQ4QdXB48l4XOzYWqSnDTj3mBa+J4UCbRu6zMuHiUBA00MLzpnCXev+QfHhfZt0qHSXzy/KsNwUnkDziXGoa7wgPw6dwd4+JX73B2ojFa6r0rXUEXZpmIc4afzU4I/28/UqL5fY2KVGS/vS0IYGe9l2IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hC1LJ15Enwc+q+qkrePWun9zc0LMVoMe3tdfHLIURaU=;
 b=X/jTiFraunZD1fFRkUY/RgUC+mAHWk+75nCtGrlbWFUkdlmAJnZ/6UOnkkizxHsfOIqczFjTHjB3+XgMGJ6ENv8rg9UmKGlotZMkLHcOYRkybrGl6SFk9Zp4MBy1ErpsLL4c7LxFCgT8eEcuz6nfotqrdxz3fSjEdVJBZMICHFz2Ld/hxahrCQ+vCYK13zDBwTODt4vmVBt1w8gAdYhJq7wQhzute7vV/l8xWP/wg9RmFExaqM1/c8jywW1JJNvAGgyF0LkqLe6jb1Ou3SK19VLza8uGKOTwtlD9wQfwlFsYSKtyVOJVqNdSrWhQMoHbswHkIQnXGbnvB6AvNNlotw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by VI0PR08MB11775.eurprd08.prod.outlook.com
 (2603:10a6:800:311::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 11:45:54 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 11:45:54 +0000
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
Subject: [PATCH v6 4/5] vhost: synchronize with RCU readers when freeing workers
Date: Fri, 24 Jul 2026 14:45:41 +0300
Message-ID: <20260724114542.734623-5-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 96191f5e-e2c5-450a-31ca-08dee9791e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|52116014|1800799024|366016|56012099006|10067099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	bSLvzWDqf11bOAjWYFsg8T9IWX5AslP6XvCL146VmTri3k2ke7fGO2f/1XfALNTz3qRI9F77RfvAojETC7C6p8xzr1Y2DCNNXIuQGuFF8swd0hmRh4lP6tBMMxq0aL68uMzfWUJxf85dOB5ZmIBXmSrWPR0lIHwaxC/nVWxEjShLYwVMoSQ5kKs3hxwCulixbYf3NlItEZc5A1eXZEb9RRhI4AVIs4T2EQPytpELtNf8rnPz5ZxH0sSkGhTyay8AmRx88i//VferJ5fZp2T9D3ASUu0b5lalcAz179PHwAzqbzUhSygP5yREZrGPy1Q2ZBfdLRK75mXo4f1XqgGqWW1LY4dJVUZHfe02nphlkdoMCBhQnXJN3+GwKV9fLw4taPm9VwdddzGME5QXE7Pza4YCFlwTsA/ewREIO5s6m7aMVWDQyE9uYmBn4JqXhqBZTS7TKWAqIjdcii0qaYyP5fAGTODdDSWPbUzqApHcZQgvCzITVxhGUknx0SYfc0M24ia3OSnztLYZr2G+TLwwQzfRAhDbVOVQLs0qcWeTVgjZzMjaA3aAhmyTHyDh2rOTGrEIK8h7ah0xITJI/UbxamZfJ1iyIZkzkd9/BosuLVFhj27n6qDTCsEpKvV2iEXUw0FZkWdOMJxX/4HLSIFMBc4VNLSkFyTY61q33T+A0flyhFY6j4ra48YVbKx1Kp+dXIpiohGMvW4StcUbzrqtER9U6mntYJ5+Cv2m3QZMGjA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(52116014)(1800799024)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3e13WaWTn7C8QBBYkCYrVWasuwt1+xr/lZWl9I0j+ld9qqlicIeaaPm0mpg1?=
 =?us-ascii?Q?NlCsx2lGuysenY/KOFErCdkuiqsThxNs2tF2AbNFZqab/FhEqOJtaqLqMekR?=
 =?us-ascii?Q?Qpc/8cFoL4lBoy+moRKcD3NqU5gPyINUVrlKVldr9d4i+b1deAI4MWvroCaN?=
 =?us-ascii?Q?VGM/7HLBwmVNtsv/9erjHlX8+skXR18C9DS092GYwF8kpchnyYFNzSbOYmKC?=
 =?us-ascii?Q?X3vf4GtE2DvL9z+Lw78uqfHmXSkCJWuC/9tUgs7DhFG/ZQIKtpxhXcZsEcIz?=
 =?us-ascii?Q?Rb7kwKLl+Mt4TnZDjobla0F8baXf35DG5jokhuDIQy2Qnka4Za6s3kpO/z7l?=
 =?us-ascii?Q?jdHhLWsUHLz+O+QEu+sBBqNHIHbz31tTaXwXpPfEz9mpkWtTAGf2VhK6l6PX?=
 =?us-ascii?Q?O829LntXtAjmRnHZz20IX8nvHMEPPRHjH6AuEfDJTo42ylNEaacmrY15FL7H?=
 =?us-ascii?Q?9Ty44+P47o5u1TY7EoX74U9mE4ZUwcWwMMCHpWFxp0f5vLcWK+82MD26NfuA?=
 =?us-ascii?Q?d/x2TRMWPvW4IDoUeVzELnzD4I02lkohNM/o76mpUrVOTox8tuWGG+nGWvp6?=
 =?us-ascii?Q?9SvHYK6q57nSnMKLZMZYze+Bt9Acr1fc4qBpdSgSLD7lUvjhsSLsPGbVESJt?=
 =?us-ascii?Q?pend8TfJpRQqdB/cD4gRlH1oxdlhK4pOWBa2lZPUY1aRCyrisjJxMm8pfKk+?=
 =?us-ascii?Q?GAzV7DLmESyILqOoP8TwotyHPf+4OXS3wuTfXJWgaXDizZyPQulP6+K/WcKZ?=
 =?us-ascii?Q?xMHGHWZIk/3/3G78x3ygTTLy+xmuSbdCC0e+fAN833hwDCJVwKc+TSNuzSYi?=
 =?us-ascii?Q?lkunvTaRVxq+2PBk3d0RXAfRlfMMZoN8+z4F384SRuUPX7I0jZ0WaWZTrxEJ?=
 =?us-ascii?Q?VX1Kjo80eVbnuUxxwRgNx9Ez3rZYWuTgGmFVcdho1R9ctAlnkjSHmzV90E8u?=
 =?us-ascii?Q?SP7vPbiFrSFwHFe5HA9n7k5hMmIojvdKYQSAhb9v/oaunDH5IXh68qemW560?=
 =?us-ascii?Q?9brObK+qR0+zzqJjH7IMlvtwa/BBqj8IouwseFxRX2JjTeFvriYw2hDTodJP?=
 =?us-ascii?Q?8wRutHVPxejhe8es1dnLVCGNZdgjuNBLIE6uqsCRy6JZH42VUvPxeKrWsFa3?=
 =?us-ascii?Q?g8ZZ9GROkbkVhJhvXcl/1SbJnBqdFjvh8birUQagnxRlz3rUKT+JACL5Z1eR?=
 =?us-ascii?Q?6XJpOgm0ZfH8gerQbEIKAtxgEvRsSU+np/G8Op9GpwkINorHihubdFV/gvaG?=
 =?us-ascii?Q?H0JP2FSv5nDX3MGPrGJhxjEv0MF+4cZ8c+UIP3PMW9b0fSsB0hO5OB8URkm9?=
 =?us-ascii?Q?xL9eAg0D1+zyebx/foo7e6BVpu4NQ9jL5JR7dg0fV8r7vnedlftvD+MGoufM?=
 =?us-ascii?Q?bHj07MyE+2OrJ8xNqUyCUsRV/VEX5kjxLOhQ10+HfDJdlbYApcSrUXQpx38q?=
 =?us-ascii?Q?9cTYnh7GNUdtrM6BmiPNMT7ANwmUd9+u0NK+kfw6u/9/Mer0R2M732Bc52FI?=
 =?us-ascii?Q?TNvVI07Kdeazy5n8529uAlmN/HHVVBNYc6ad0x1Am2MSeklYGhnqS9rrDUeH?=
 =?us-ascii?Q?DLgdI9e3MDC03kWWXb/ZAnKyPuvVwmwezabGwEbpOcwhtKA+mjG2DwIr++o2?=
 =?us-ascii?Q?qCftkYlhAIBNM+gLWll4O+E+Nz3joa2zPIlttOraTZRQ5DnyhI4yHu0UZKw8?=
 =?us-ascii?Q?HBNjViO53q/XTvjYL0x2rClBaEjbGj+WKC9cVUnDHQNFAJWON/Tkdq6QHVdJ?=
 =?us-ascii?Q?X94dPhs9rijmzo6rPJ2wxFf8HTmnVG0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96191f5e-e2c5-450a-31ca-08dee9791e3f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 11:45:54.3014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7WqnLb8fFywYpninM6PcFQxN7M7B171twmPgLrr4IJDqBARu8/0fBI/55Xm6UvUTWwPqbvWMunu0gqnr9oaiamGuxPlEWFrI6X2diYj5XMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11775

vhost_vq_work_queue() only holds the RCU read lock while it dereferences
vq->worker and queues work on it.  vhost_workers_free() however clears
the vq->worker pointers and immediately frees the workers, without
waiting for a grace period.  A caller that fetched the worker right
before the pointer was cleared can therefore still be queueing work on
it while it is freed.  And even when the queueing itself wins the race,
the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
future attempts to queue it are silently skipped.

None of the current callers can actually hit this: net and scsi stop
their virtqueues before the workers are freed, and vsock unhashes the
device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
before the workers go away.  But the upcoming VHOST_RESET_OWNER support
in vhost-vsock keeps the device hashed while its workers are freed, so
the lockless send/cancel paths become able to race with the teardown.

Fix this by threading a bool 'sync' param through the chain:

  vhost_dev_reset_owner()
    vhost_dev_cleanup()
      vhost_workers_free()

When set, after clearing the vq->worker pointers, wait for a grace
period and flush the workers so any work the last RCU readers queued
runs (clearing VHOST_WORK_QUEUED) before the workers are freed.  Only
the vsock RESET_OWNER path (added in the next patch) passes sync=true;
every other teardown has already quiesced and passes false, so they do
not need to wait the grace period.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 drivers/vhost/net.c   |  4 ++--
 drivers/vhost/scsi.c  |  2 +-
 drivers/vhost/test.c  |  4 ++--
 drivers/vhost/vdpa.c  |  4 ++--
 drivers/vhost/vhost.c | 26 +++++++++++++++++++++-----
 drivers/vhost/vhost.h |  5 +++--
 drivers/vhost/vsock.c |  2 +-
 7 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 3e72b9c6af0c..fd089412c020 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1452,7 +1452,7 @@ static int vhost_net_release(struct inode *inode, struct file *f)
 	vhost_net_stop(n, &tx_sock, &rx_sock);
 	vhost_net_flush(n);
 	vhost_dev_stop(&n->dev);
-	vhost_dev_cleanup(&n->dev);
+	vhost_dev_cleanup(&n->dev, false);
 	vhost_net_vq_reset(n);
 	if (tx_sock)
 		sockfd_put(tx_sock);
@@ -1661,7 +1661,7 @@ static long vhost_net_reset_owner(struct vhost_net *n)
 	vhost_net_stop(n, &tx_sock, &rx_sock);
 	vhost_net_flush(n);
 	vhost_dev_stop(&n->dev);
-	vhost_dev_reset_owner(&n->dev, umem);
+	vhost_dev_reset_owner(&n->dev, umem, false);
 	vhost_net_vq_reset(n);
 done:
 	mutex_unlock(&n->dev.mutex);
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 9a1253b9d8c5..b6002b64cf42 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -2350,7 +2350,7 @@ static int vhost_scsi_release(struct inode *inode, struct file *f)
 	mutex_unlock(&vs->dev.mutex);
 	vhost_scsi_clear_endpoint(vs, &t);
 	vhost_dev_stop(&vs->dev);
-	vhost_dev_cleanup(&vs->dev);
+	vhost_dev_cleanup(&vs->dev, false);
 	kfree(vs->dev.vqs);
 	kfree(vs->vqs);
 	kfree(vs->old_inflight);
diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 24514c8fdee4..84ed9ea81219 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -163,7 +163,7 @@ static int vhost_test_release(struct inode *inode, struct file *f)
 	vhost_test_stop(n, &private);
 	vhost_test_flush(n);
 	vhost_dev_stop(&n->dev);
-	vhost_dev_cleanup(&n->dev);
+	vhost_dev_cleanup(&n->dev, false);
 	kfree(n->dev.vqs);
 	kfree(n);
 	return 0;
@@ -238,7 +238,7 @@ static long vhost_test_reset_owner(struct vhost_test *n)
 	vhost_test_stop(n, &priv);
 	vhost_test_flush(n);
 	vhost_dev_stop(&n->dev);
-	vhost_dev_reset_owner(&n->dev, umem);
+	vhost_dev_reset_owner(&n->dev, umem, false);
 done:
 	mutex_unlock(&n->dev.mutex);
 	return err;
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ac55275fa0d0..427c4a34db2c 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -898,7 +898,7 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 	case VHOST_SET_OWNER:
 		r = vhost_vdpa_bind_mm(v);
 		if (r)
-			vhost_dev_reset_owner(d, NULL);
+			vhost_dev_reset_owner(d, NULL, false);
 		break;
 	}
 out:
@@ -1396,7 +1396,7 @@ static void vhost_vdpa_cleanup(struct vhost_vdpa *v)
 	}
 
 	vhost_vdpa_free_domain(v);
-	vhost_dev_cleanup(&v->vdev);
+	vhost_dev_cleanup(&v->vdev, false);
 	kfree(v->vdev.vqs);
 	v->vdev.vqs = NULL;
 }
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 4c525b3e16ea..b18429b15d32 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -719,7 +719,7 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
 	kfree(worker);
 }
 
-static void vhost_workers_free(struct vhost_dev *dev)
+static void vhost_workers_free(struct vhost_dev *dev, bool sync)
 {
 	struct vhost_worker *worker;
 	unsigned long i;
@@ -729,6 +729,21 @@ static void vhost_workers_free(struct vhost_dev *dev)
 
 	for (i = 0; i < dev->nvqs; i++)
 		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
+
+	/*
+	 * This path can be reached by lockless work queuers.  In this case
+	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
+	 * RCU reader that fetched a worker before we cleared the pointers above
+	 * may still be queueing work on it.  Wait for those readers to finish,
+	 * then flush so any work they queued runs (clearing VHOST_WORK_QUEUED)
+	 * before the workers are freed.  Notably, that is the case for the
+	 * vsock RESET_OWNER path.
+	 */
+	if (sync) {
+		synchronize_rcu();
+		vhost_dev_flush(dev);
+	}
+
 	/*
 	 * Free the default worker we created and cleanup workers userspace
 	 * created but couldn't clean up (it forgot or crashed).
@@ -1148,11 +1163,12 @@ struct vhost_iotlb *vhost_dev_reset_owner_prepare(void)
 EXPORT_SYMBOL_GPL(vhost_dev_reset_owner_prepare);
 
 /* Caller should have device mutex */
-void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
+void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem,
+			   bool sync)
 {
 	int i;
 
-	vhost_dev_cleanup(dev);
+	vhost_dev_cleanup(dev, sync);
 
 	dev->fork_owner = fork_from_owner_default;
 	dev->umem = umem;
@@ -1197,7 +1213,7 @@ void vhost_clear_msg(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_clear_msg);
 
-void vhost_dev_cleanup(struct vhost_dev *dev)
+void vhost_dev_cleanup(struct vhost_dev *dev, bool sync)
 {
 	int i;
 
@@ -1221,7 +1237,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 	dev->iotlb = NULL;
 	vhost_clear_msg(dev);
 	wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
-	vhost_workers_free(dev);
+	vhost_workers_free(dev, sync);
 	vhost_detach_mm(dev);
 }
 EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 0192ade6e749..29fb1f510a34 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -216,8 +216,9 @@ long vhost_dev_set_owner(struct vhost_dev *dev);
 bool vhost_dev_has_owner(struct vhost_dev *dev);
 long vhost_dev_check_owner(struct vhost_dev *);
 struct vhost_iotlb *vhost_dev_reset_owner_prepare(void);
-void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *iotlb);
-void vhost_dev_cleanup(struct vhost_dev *);
+void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *iotlb,
+			   bool sync);
+void vhost_dev_cleanup(struct vhost_dev *dev, bool sync);
 void vhost_dev_stop(struct vhost_dev *);
 long vhost_dev_ioctl(struct vhost_dev *, unsigned int ioctl, void __user *argp);
 long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp);
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index d5022d21120b..87309c68af15 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -824,7 +824,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
 
 	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
 
-	vhost_dev_cleanup(&vsock->dev);
+	vhost_dev_cleanup(&vsock->dev, false);
 	put_net_track(vsock->net, &vsock->ns_tracker);
 	kfree(vsock->dev.vqs);
 	vhost_vsock_free(vsock);
-- 
2.47.1

