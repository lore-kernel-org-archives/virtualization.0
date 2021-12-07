Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD89C433FE
	for <virtualization@archiver.kernel.org>; Tue,  7 Dec 2021 02:45:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9206760E5E;
	Tue,  7 Dec 2021 02:45:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vmeWfVUnWbfr; Tue,  7 Dec 2021 02:45:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 00B4060E55;
	Tue,  7 Dec 2021 02:45:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD951C001E;
	Tue,  7 Dec 2021 02:45:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E52DC0072
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B6A3141C71
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="kShJtLVB";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="GNPJzL/O"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xuBDJLlROURx
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EDE6B41C73
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:25 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6M5Hlc012536; 
 Tue, 7 Dec 2021 02:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=WkqYcsRKqbSTPXZv1ussQhIrPhzFU6l0mcZ8QeX5NSs=;
 b=kShJtLVBZqhu8zDnuVxEJPMuZPQWTEOTTqXhYy+Lh6iDi/mXD+3qXgVNB0rekKGzZgSz
 t6gVkvY4LT30wIqdCN5gq3Q9AGpKN4Yvni2qKHjYJuZeRIYee9XwIXG0k2ChpKUd/V+w
 pegndEcDhZ8eSYym5LiliqLFXUMtBOTYg+5xlqmmwmQRv3nhN4NHbDx/5pRRixL3K8e1
 iEGDxnM+KDfRl2uxxHKjrxlm0xI2jrb6Lot99VbsV1aOc6ASwGPudj/145OsUXtYHTRc
 mqWsgVgOT7nYhMz2xbhRXHg5BTPKXs9R3OHvNVKMjuJ14S9J7ZidMvvdwUrAfW12G0qw CQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3csc72c2xa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 02:45:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B72bJer124653;
 Tue, 7 Dec 2021 02:45:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
 by aserp3030.oracle.com with ESMTP id 3csc4snh1a-8
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 02:45:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNZQZgqMMuqDrCZDBE9IpwBdHpSeY0jjimrGsAdQEjR0YTXvLIeJn4A9FBxSdSszvP8JV6lM9pNuVl1ElhAuw4W/UXfTGgmyq9V16qAwFVMsI72pmn94r2kj9p/i2vYkBg2WHAasHdc3iFLL3Cjj54TQIDQZgogJcZ9tottJPWlJbEzyWCs6MTSws3RaytEOOUI2W9fxowBgIfuxj024KE2/Ey6CiTX3CMpSxE78WJ2OdK+ipbSLorU7UJG55SsrOzRrU/PbbMIIB4aZ6jjC6m4rpDfYNe5HcftEJ9470RAOVYYUXkaDADx3aDSYprt4IcHATqgO6OhLLZRjQPHY4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkqYcsRKqbSTPXZv1ussQhIrPhzFU6l0mcZ8QeX5NSs=;
 b=PHq2sbErDo7Uhmayi1IRsmOQS1wvl6z9FIOS9KOr4edKMD7sbAbJhE3SP5UdWaCDUFUecDLerL7wsnS0LrLfpGh4icmV67SmqfpqJGG+92/47mqZfDFTTJebwau7pz0NCgVo0Inqlfxe/Notehd5ztpbFmC8KCGg3jDqkK+MThgMEvJs789JHXkswh9jkyy9+tVGevqcHIKxr7wdyU8Fltc9w1rjQoFz9Q1kOs4X+d0T0Vc3DJEBwInCH5K26mSE2S8sNFKg0V+qAsYUKI0fJVD+MdWyDJSKEj5eAHOFQtYhzo5C5PTYNtsnfMcm2CUkpD8Efzy7KJ9phPp6DZWRhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkqYcsRKqbSTPXZv1ussQhIrPhzFU6l0mcZ8QeX5NSs=;
 b=GNPJzL/OzfB8a7fnOrwcM9bcTdwhqOAK0/HbGrWXh/Zea1lQlziSY1oHU/EuP2pDA8a2SUYXj78SivyHHA94umcpJh5kRUIc0yK6WipWDTQRyuCA15LyroEa1S7Lh+asW6pAlrw6b4+LFYhzsPWah6l9N0OCM0hq6FhuE54OAaY=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Tue, 7 Dec 2021 02:45:21 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 02:45:21 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH 7/7] vhost-test: drop flush after vhost_dev_cleanup
Date: Mon,  6 Dec 2021 20:45:10 -0600
Message-Id: <20211207024510.23292-8-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207024510.23292-1-michael.christie@oracle.com>
References: <20211207024510.23292-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM6PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::39) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM6PR17CA0026.namprd17.prod.outlook.com (2603:10b6:5:1b3::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11 via Frontend Transport; Tue, 7 Dec 2021 02:45:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6455a0b5-0b24-4883-0477-08d9b92b9ce5
X-MS-TrafficTypeDiagnostic: DM6PR10MB4347:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB4347D0923F8D955AD21BCD80F16E9@DM6PR10MB4347.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55POuGu82AaBiqPVG/oQ1hcRtDW1qfS/tIWTAqhqcFmvvebwlNXcYjaE2xH/pI6ggLOmZJIRL74zMFySFdWYp3VOKsK5BHwV+O8cH2pLUS7y2hYWVUIdKGmWqGHjDD9ROr6iDFgpEfLqgEsjdp3ocfDkAvYvo8xTuVpfqF0XhFwB/vakdTiVxwU51atGSnCjAVKJD8jCJFvumAdo4X0Lv2PjTS/GaaZyUNrnEsHzcE3zNr3Ur30XqIDatfDuYLxHtcwET/pEq9hASgQcxb64pqEeTv10mZdPGKDGJcGhMjeQH78fdfQb1iNpfLIofHUGxNFyIPvvpQtQqc/PzZ10vcybbDKJ3qRwmSCVLxOEaKaXdcmvv8gX5XRqx4OJVX+jFD7vE+bwWnEMb6WEwG+mcTKxcQChXN4C2rDGJmozUsi9eFOpcATzKevtvzwW75JUwHttMyX6iHex6Nk8IdZgR08BgWiA37toMXJuBAD0DrEDBwb/gSTkYqvfdLwKvj1r3lW/Mfam/I3U1ckciMOHsViTKZr0zh1TFQmobUAMIWYnbWZipXh6Z3XTpsJF5sVPwPqsyYCLREPYvF+linIaEteZqXPD4UhGXuQFC/oIjnoVfpIgHZNp0m3KzjpSfB25oV3W26aDwZLsD+lxr0jukGl2jN0+Pi0c7nzGia79kz4BI6C7zKYtNFV4SwlTlkGOWcssAOQN8VzkXurtsqoivQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6506007)(316002)(36756003)(8936002)(38350700002)(38100700002)(26005)(8676002)(186003)(6666004)(66476007)(66556008)(66946007)(83380400001)(4326008)(1076003)(2616005)(6486002)(956004)(4744005)(52116002)(107886003)(5660300002)(6512007)(86362001)(508600001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o2+wgVV460sMVanSnEmlQtg8peOr6dGzB9GnfnhZMxZBOUq3D6aiBFm4bTxO?=
 =?us-ascii?Q?hqZ3WVCeq6PAuSkezPH2e+o4HVdyYk1K50nuF+eMpgSWQw7WFGRLbt2360OV?=
 =?us-ascii?Q?D/nNgcC7oF9QWjUz6/9YjDv/72SEJnm1RSYJiNj6XqouyeOURl9X+BdrdYvH?=
 =?us-ascii?Q?XRy8yWoW/YngPBVlG/mZ5tz702uQ0kQMrmOBlhyl9UdouiAQww9qujFUKVEF?=
 =?us-ascii?Q?5oALxSz8+drAMPU0/bzNNxcZXI1PkOLkyqEB/PYDhdJuqCwTogyMXMUraFvm?=
 =?us-ascii?Q?Ekp8e3n77ati9qVWOQuaTwaIywm/vctmgE7mREKMZg5EyEmK3m8JSSlNJHe+?=
 =?us-ascii?Q?JEZU3QIi7CcJ39i+d95qXhPJIJvbhQBgWpvtN2Bl3k+7sRZwFm80bJVg0JHs?=
 =?us-ascii?Q?gWGUl7FfwolNeq+ZOewiFeNkeowy+XAPb2LvnUIRWJbIz5FF083D9JE/0lJv?=
 =?us-ascii?Q?yqAIdTiUn53BdN040hBdnNqLwNv71uR6XmgMoJiZ0qIm14bdR+f2qio31kaA?=
 =?us-ascii?Q?xVdcmDU7ZYpL3v/ga+8NW87IvhELGxd9WKUR9+eGp/gKZ5RmBgn8FKNAAd2M?=
 =?us-ascii?Q?Yuld/o/KwC+0ltprui5Ly8ej4caIt/Z2GRmHAm72VlKhymVOm5PyWvtQzIuX?=
 =?us-ascii?Q?qbF86QMy0VS6k0dcaO5VB1BVV2IkbVmheAsdyFES9sISwLbxrvhtGLhHiYcT?=
 =?us-ascii?Q?MPaMvWBMzHyrWQ3aEeuWuE/rNEdwvVo7FbH9fSj/fKES4R3N5oAXwbJtA3Bu?=
 =?us-ascii?Q?omOicxKxKlykebvMoaQQN9G8l29tvZH2Sdditt9aeiSTMSnpNiue5UOixzrH?=
 =?us-ascii?Q?BqbSP3eF3OSK/kDesGxQHb1nLNE4Mhnsdq3f5Ih4O3YHpxh0Hrjt69iL9UIs?=
 =?us-ascii?Q?T4VLBw/XQXbVKszyaGPZ9T2HTSjPRXNNrpj0E9PMLbyfYbCa1JQUU7Xw2DWf?=
 =?us-ascii?Q?PW6AUHzFBrj1Rplk3ICRNBSvVLu9m/7g6LR9cJeYAJ6v/JROfQ6VNKnj9Ae3?=
 =?us-ascii?Q?GO/MkaMp9wdpKaIH1J7T9YdA3infFZ6ufEq45RxmGr4l7Ce6Dt8227+eg+DJ?=
 =?us-ascii?Q?DaL9vlzcZ/pytTCcXhBOStxe+6zu831tVwqe3hHUEWbOQ037H2/7jHYmbbvQ?=
 =?us-ascii?Q?4kkDAwkczW7WQwGPUSNRp+RDzTjtwYiUvptPi5PTSCkXa51NRIK5DRvsU5AK?=
 =?us-ascii?Q?l8LpJPAMpUoIq1VG+Fu59Cqi98vJOqaIStLE1VONsKcESq4Kt9O8HK2SwiaV?=
 =?us-ascii?Q?ZAiMZvqBN5bH8qBHPTuZbPyC8hqqultrqRwQHodRrProhVJlE8o72TTvJu71?=
 =?us-ascii?Q?C/GeaqJVS9Dbnc7TWTYxIBlWJo4xm82ylUN+LueXISPtzOTDgtXEOl0Fp1G1?=
 =?us-ascii?Q?3CF0i6NHZ6TnxZSA4lmZSP4WpMVPQT+me6J7mLXDjJn+R2HE+wFA2l0cxFAR?=
 =?us-ascii?Q?t6auyeHHgcBOFvi+o+McuNltIeS25nvaHzdyEF0G8sPYQxAW4Nnr+ImF93Vh?=
 =?us-ascii?Q?FgmjNHOO8jNIQUQ0oyzcVQ8STe4ZMxgGbUTVLcu/2UEHXEZ04bJrztUGy3M3?=
 =?us-ascii?Q?wEP08TpS/E/NFYtjHcrmc9MucT4nVntwMQ9q+pxnj2xqXqbIeQs6AX5VSzdD?=
 =?us-ascii?Q?Ran5+01nrX2mry89saOfbjxuz0ggV8Hl9xZePrFbgbQijWwLOvHoL/7yX/M0?=
 =?us-ascii?Q?Ul8Rug=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6455a0b5-0b24-4883-0477-08d9b92b9ce5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 02:45:21.7882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbjuhVU0sd8vGDFrsuRp1XJVNVMO0Wq/LdczERQ+ctSmjmnOhhnzI/7ZkrPGO3iTkcbDMundAHWIMemr/7q9Zs8BVhgk/lCf6WWfJYcNdn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070015
X-Proofpoint-ORIG-GUID: 22ndmM0O8KhNwk1UhQmSdIZ5gZ0_vbcM
X-Proofpoint-GUID: 22ndmM0O8KhNwk1UhQmSdIZ5gZ0_vbcM
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The flush after vhost_dev_cleanup is not needed because:

1. It doesn't do anything. vhost_dev_cleanup will stop the worker thread
so the flush call will just return since the worker has not device.

2. It's not needed. The comment about jobs re-queueing themselves does
not look correct because handle_vq does not requeue work.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/test.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index d4f63068d762..57e24eceff27 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -158,9 +158,6 @@ static int vhost_test_release(struct inode *inode, struct file *f)
 	vhost_test_flush(n);
 	vhost_dev_stop(&n->dev);
 	vhost_dev_cleanup(&n->dev);
-	/* We do an extra flush before freeing memory,
-	 * since jobs can re-queue themselves. */
-	vhost_test_flush(n);
 	kfree(n);
 	return 0;
 }
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
