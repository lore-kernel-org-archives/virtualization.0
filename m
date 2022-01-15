Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08940C433F5
	for <virtualization@archiver.kernel.org>; Sat, 15 Jan 2022 01:22:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A4B1360B97;
	Sat, 15 Jan 2022 01:22:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KByp5p9AMklZ; Sat, 15 Jan 2022 01:22:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2E37A60B6D;
	Sat, 15 Jan 2022 01:22:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E906DC002F;
	Sat, 15 Jan 2022 01:22:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DF5CC001E
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Jan 2022 01:22:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C7DA060BB6
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Jan 2022 01:22:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zLxyxaIB_aK1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Jan 2022 01:22:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9CD2260BD7
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Jan 2022 01:22:04 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20F0wmEh022535; 
 Sat, 15 Jan 2022 01:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=P5zYluMS+rZbZYekpjp44YrTTSYMiE01pNKqAGFG31A=;
 b=E7PaAwIGz65+cOTFDejVwIZMog26UoZ/DX8DJZ/u9Xon+gvLYqomFWzwGxDUO++1Nr0C
 FJUkBSk4MB7pKCAOK2gVHbWwm8jxVUI1rmheldJsrMd0w03f35Avc5dQpFnf7eeMKb/q
 Sys/27TxFbxABW4fCkkAKyKMx+78T0TKiv/Hd10y1WSaxuFEXkbmTE849jgQlxp9s1d+
 W8QCw2MxsedIOug8g0dag71RUbTVCeMkAKps/Z/qmkShPUbX+U6o6pbixVYa8tJjaEEu
 rAxaVM9EZwJd3Y6nJ8Qq4bXmLfCXD8sJKml9dLUkkl+Fu9+pzlEfQDAdIv60Eihg8tIH 3w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3djggmdbxc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 15 Jan 2022 01:22:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20F16JRQ073234;
 Sat, 15 Jan 2022 01:21:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
 by userp3030.oracle.com with ESMTP id 3dkkcsjsqt-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 15 Jan 2022 01:21:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBCKNwUseRDATANEuxUrZrkt8H/J7OvXKGcF8uWD0GTKEfeTpQnC4CU1U7sp+7qN8dpQti4qcWIjx0LqgwdhRvE4XG+71lR2l1gIeAqOawFzOOOsagEaORLUZ5OteD3S9OJrE/3CNJW9xxffd9mgwyTHR1/u9+e3//qdn2qsaAqmbY7rUT3dtSoIFlCAWWeQ1VFT3QIXjy7f6LNy6WVGTsbh1ly6HlIPPjqJm2mfyFrC9FFGzQ/qGGo9ipIsvFTkU0EtWO+1oPov/R+NwwwNW4ieNjwal4KxDdtXs3ac9P2NETmCbiFUP/zTMM8gem5TZXS+pHB08cItkA2EujBCvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5zYluMS+rZbZYekpjp44YrTTSYMiE01pNKqAGFG31A=;
 b=VD1e3a1He9rSacP4h0by+lwCUVBYdfxzU77hIbjOI922nnt3LqLo2mWFmJH4IhWmoRH3JilOq2bIafEkGIJU9RyB+Jm0SGsmdnhuVPt+bDk+Y1mW8pOeBUwz6tNRKsTsZroslbX+X35Jd3pZ2OQljMecJ5pSuEakYxEVDSzO2849xM00XP+07dbJjTsX96Luk1egXopqDqB5Q9bXg+0tUZHaT7+v/UZUctyeCi9uuVUNb1BzUaSv89UBUVsjZ6kH3T4NrwtirOLtfvd2pVpz4LxhB1duG6b7xaxVOmdtEvzLbkpq+7YFqHqQMTOnmpDzOSXmv3w7MAqaXp+lmbdMXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5zYluMS+rZbZYekpjp44YrTTSYMiE01pNKqAGFG31A=;
 b=IyzYWsyCdfUh+lVDL3iZReCumSAOGSQs8hXTLsHy/F46Zr5WssCvdu4AbEWuTxZf41n1x+60Tv4vn2j/tXxN6do/KVI4dZp55aE2hQTd4L2pCJbS5VZpbMiWAJRyuV7DblSOyvxgE99vqvY1xtvaTRsMf4jeS0hWgO4Ftlvc+Mo=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by DS7PR10MB5182.namprd10.prod.outlook.com (2603:10b6:5:38f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Sat, 15 Jan
 2022 01:21:57 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%6]) with mapi id 15.20.4888.012; Sat, 15 Jan 2022
 01:21:57 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: elic@nvidia.com, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH v2 1/3] vdpa: factor out vdpa_set_features_unlocked for vdpa
 internal use
Date: Fri, 14 Jan 2022 19:27:59 -0500
Message-Id: <1642206481-30721-2-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1642206481-30721-1-git-send-email-si-wei.liu@oracle.com>
References: <1642206481-30721-1-git-send-email-si-wei.liu@oracle.com>
X-ClientProxiedBy: BY5PR17CA0071.namprd17.prod.outlook.com
 (2603:10b6:a03:167::48) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d861c75c-7f9b-44f1-bc0e-08d9d7c56c36
X-MS-TrafficTypeDiagnostic: DS7PR10MB5182:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5182F8AC628A183A7533663DB1559@DS7PR10MB5182.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: btSs+rSC4pugsCGjr7m3caTM0jHxPwO0znHbe/6y3KAe8ZvTfniKCcS+B6IGYBVyCUNqGyHYlgvEK6hWJ4aT9JSTwW9M4To53pGhjibqTcEiLPwzsbiqs3tkPiVbzSPbBVadcmIhkVGa4MPorNHMLePH2YlyEw8qCGXL48YcW2C4D9stUjY0jxx5sf7f1crPEHskb+qBcD4u4nfj57WC2wSL4cZwwKdVhYWkyANLJV6cAXGg/mJiYRsClnIuC/qHn6PI3FiHIro3LuiNQA4rQ077vEqeEBGjnJMjWgQXWBmMw/qtOmVTUQh+2IHts0v48Z60BFBbHLNFx/84+rN0CoC1dKcd54ATJ28yb91y+ZWNAaMyB6/CrfYCcw3pXNThdjDvUS18QBVd7YJ93xFvjXw/Na9V68ASS5BQgLSY57cBvnUovvOn73KuCg5u7H46ZeBdY1LeG68IhpL6kzHxq32r/DeAK2PJOp1Fcf2IO2RKHL7KOwRcQZ2eW6i7uebTXBWmDJZELgmvLQW7bmEEkTu4j1yS1rtaGJh5JkddOj3zA2ozC5oP+z7chB/HTZSbBBnki9T5vdkGuIHqSXN5K0XnUE06gGtS9rZSdQSimWZYsAC9GYm9UqF7GRArG2apA1PEY2vBxlP9IlsQYcCOlIEfsC6ZwnIb1MSTX0mLmv3YfWuzAbLVx5dSqBHxrNoqC8967Qkr/xGa2Duo6QppQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(6512007)(4326008)(6486002)(66946007)(38350700002)(83380400001)(66556008)(5660300002)(107886003)(8676002)(66476007)(186003)(6506007)(36756003)(86362001)(508600001)(2906002)(26005)(8936002)(38100700002)(52116002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D2uWklmT6DFu4Eh/aEaeR1g6+96MrrIQ6bukLBZxmK3FUaezirDHfQ4zEpHC?=
 =?us-ascii?Q?mMQf77PhKK55GXFpHak86h3gw531pDRhNzb7RnIXhgYxUS4tGPZPzmu5iyxF?=
 =?us-ascii?Q?iNjo5DzPLhTMgvyZtLsdiQUNyXpsBRcq/fc7gO/7/at5ZZn37CnslPIG3xKY?=
 =?us-ascii?Q?Cur7XzmWWQpTEJV0Kkbpm+uSMt1YHxamytJUIMT1yGTr7MQLkqnMWIg708rP?=
 =?us-ascii?Q?C4grSanb1iMgaVkNw0TF7qWbLaytMMg88s2VobdR4ylTmE7k41B+BSL2Mt5q?=
 =?us-ascii?Q?FXZrEiAQxOvQwB2FtqfLCiwpG0M0jFsbp2s/qU2m5Lr7agxy7FleUdCyVcls?=
 =?us-ascii?Q?2Sc6Tae9xyFZB6GTdta4KeFSGNLbbsx4I+z1+cNQ5bPyYM7OHIpoDImEeI9z?=
 =?us-ascii?Q?KqiF6blZJEdtjr8z5ERmJmfbds2I2xFAZ3vJ7PRibSZjxbor7k/KlgaFJ1XD?=
 =?us-ascii?Q?PZ5yhQRzG7vSdvEIKlR81QafsBY9X4tGschrSaX22mnvQu0KpMzJjNHpQ9XL?=
 =?us-ascii?Q?eKAioY3rHR69O3iTlyYEXQ0iYJ5BdvU5b/Tc6p2SSnYZgct9mBYCGBwqqbty?=
 =?us-ascii?Q?QCQxCZTKaCg/cWa7BbeOJkARnFHMDn9lvTdLx9zk+9w81g69ngqlpw6+dw80?=
 =?us-ascii?Q?1zTHkjrcKKMU+WYX8bSxyMTUA9ZAMUOi8coAZYuFlQDLnRKRvw6gmx0RsXF9?=
 =?us-ascii?Q?ihTcZ5u4ma3R2vkXvQuOjx6uXH9z6MiEFlNW4pKoApAJhfEwXr3o1ffoO212?=
 =?us-ascii?Q?nGYynbtPrL7f6+QQZlAaT98cOdwU8Nw9kowfDIwM2NNIywAeHt6z/S1njN0G?=
 =?us-ascii?Q?mIPZcdx6FIxE8nFjV12+mzgBiKOvL26jpvlWJb/DRb0aWoLHujPFywN2WmN1?=
 =?us-ascii?Q?W8C/pfbkpgmnsOp1eQF1/wjLi40f0EmO4Euzer/DT4wlT+BFQf7W4qFZRzv6?=
 =?us-ascii?Q?jfdfa6vafUNGuxkTlvE0uL02HJ97nElnzCGx1SIdC9tlbpB2m+ohwLtANqzV?=
 =?us-ascii?Q?Hh6IkleEmsrZ+IBaFsXLpmLA56POvBiu8dPBLL3CZ2BvHSCUbmC5/fIIXuSz?=
 =?us-ascii?Q?LLAO+NxDhABVJBysq2Tuy2Xhgllac3rIEuSutbSWOMi5ADIRAMM5D0Uxx773?=
 =?us-ascii?Q?4Yt3slXyC0I3OHxc0vOSxJBotxMAYxyS8/XgEWfw6HnwIK/zgFIRAbdrK7iz?=
 =?us-ascii?Q?qZb29mt26UkLBMqWENaSXEQL++ShAWzX0yuxPJju/HPhhvAsTyJlbyZgK+Yf?=
 =?us-ascii?Q?gfjjaNOxTvO8ZpydbhGd9/Nx6sO+MBOUyDyZQx4HoEwNRYga4FcvLKtzKIOw?=
 =?us-ascii?Q?cgEJnRLnRnYaD3RD5TeOUd0BjSovyoCSaat/WuN7vdOb9CHhRVm4bIX5y6y1?=
 =?us-ascii?Q?+N/zgq3W2GUeIJb6be9//xAg2G0Lf1qwe2SwV6+20KqH8/pbhzUri/XAagrj?=
 =?us-ascii?Q?OqOFNijYGBXLEtXK1CnVnA2EtURTZPrBlD1iAbN5LhGnEsAptoMe1WEo3+oL?=
 =?us-ascii?Q?REcNKNoIDjlGtuJTI0Ut59qKovbHv6FWkz6T9wWzBAmGLWGLznIXjv43CbvS?=
 =?us-ascii?Q?S2Sd/HzzL5oVq+BF5GbhFTMj7zj4hthlU9+q+XC01oTT7dhyLwY0FB7ZR/Fb?=
 =?us-ascii?Q?VC/wGFNcnREFcRUtBJHq3MM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d861c75c-7f9b-44f1-bc0e-08d9d7c56c36
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2022 01:21:57.6503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SjbZF9kghv1x8K2dREu12WwDroRE4IozMjIWqDtimyilc7eyyMAVim7kv75mno0MEtjhTF9FnrLTdTawaltx/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5182
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10227
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201150003
X-Proofpoint-GUID: uBvHc-poTJiblXaVQ_gx3VGkSFMfJVgN
X-Proofpoint-ORIG-GUID: uBvHc-poTJiblXaVQ_gx3VGkSFMfJVgN
Cc: lvivier@redhat.com, eperezma@redhat.com, si-wei.liu@oracle.com
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

No functional change introduced. vdpa bus driver such as virtio_vdpa
or vhost_vdpa is not supposed to take care of the locking for core
by its own. The locked API vdpa_set_features should suffice the
bus driver's need.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/vdpa.c          |  2 +-
 drivers/vhost/vdpa.c         |  2 +-
 drivers/virtio/virtio_vdpa.c |  2 +-
 include/linux/vdpa.h         | 18 ++++++++++++------
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 9846c9d..1ea5254 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -393,7 +393,7 @@ static void vdpa_get_config_unlocked(struct vdpa_device *vdev,
 	 * If it does happen we assume a legacy guest.
 	 */
 	if (!vdev->features_valid)
-		vdpa_set_features(vdev, 0, true);
+		vdpa_set_features_unlocked(vdev, 0);
 	ops->get_config(vdev, offset, buf, len);
 }
 
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 8515398..ec5249e 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -286,7 +286,7 @@ static long vhost_vdpa_set_features(struct vhost_vdpa *v, u64 __user *featurep)
 	if (copy_from_user(&features, featurep, sizeof(features)))
 		return -EFAULT;
 
-	if (vdpa_set_features(vdpa, features, false))
+	if (vdpa_set_features(vdpa, features))
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 7767a7f..7650455 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -317,7 +317,7 @@ static int virtio_vdpa_finalize_features(struct virtio_device *vdev)
 	/* Give virtio_ring a chance to accept features. */
 	vring_transport_features(vdev);
 
-	return vdpa_set_features(vdpa, vdev->features, false);
+	return vdpa_set_features(vdpa, vdev->features);
 }
 
 static const char *virtio_vdpa_bus_name(struct virtio_device *vdev)
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 2de442e..721089b 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -401,18 +401,24 @@ static inline int vdpa_reset(struct vdpa_device *vdev)
 	return ret;
 }
 
-static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features, bool locked)
+static inline int vdpa_set_features_unlocked(struct vdpa_device *vdev, u64 features)
 {
 	const struct vdpa_config_ops *ops = vdev->config;
 	int ret;
 
-	if (!locked)
-		mutex_lock(&vdev->cf_mutex);
-
 	vdev->features_valid = true;
 	ret = ops->set_driver_features(vdev, features);
-	if (!locked)
-		mutex_unlock(&vdev->cf_mutex);
+
+	return ret;
+}
+
+static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
+{
+	int ret;
+
+	mutex_lock(&vdev->cf_mutex);
+	ret = vdpa_set_features_unlocked(vdev, features);
+	mutex_unlock(&vdev->cf_mutex);
 
 	return ret;
 }
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
