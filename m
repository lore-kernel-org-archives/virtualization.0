Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896C8C433FE
	for <virtualization@archiver.kernel.org>; Sun, 15 May 2022 20:29:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4875C60FE2;
	Sun, 15 May 2022 20:29:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s8dx_Vnesgyh; Sun, 15 May 2022 20:29:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F00B760FE5;
	Sun, 15 May 2022 20:29:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1E17C0086;
	Sun, 15 May 2022 20:29:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54FB1C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 35FFE81D88
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="ZFUEAflY";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="OAATJnse"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oTPBFAp0cFKy
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8F4C481BFA
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:41 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24FFUoQF016862;
 Sun, 15 May 2022 20:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=IcDZ/GCxptji7TIxU+yvYx2u2k6D+R83m19Fo3U4HbA=;
 b=ZFUEAflYtZkBqaHUWCJhYpOTZV3Q2j2bQl6GKTKinP3dHQTwzePvsn8lqtSNyCEFwq7V
 nXNVAAjob7wlQXci+qw1gRm1VV37ZN0J+nvBQouOE84TXB7yPBzwiDFv6EnHdopNv0Z5
 U6zI2ywY3qC2VcCGl6rOxVyLVw+PPiOwb2IZQVWOVQjkAt9LRMMlO6ub5sEy1Yan+VhJ
 NYEv0h/RUt1iaajnrBizHS4faXU86gS8dqWwqQMO6R1/OixzDb9yXqywveSgPtov5Qsl
 iioU9JaWvDihCw/N6Hn7/EB5a/wOytRxi65FQSQG3wCEWVmWpa7e54LJTATcSGNnMARl +w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24aa9tek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 May 2022 20:29:40 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24FKPP2K007035; Sun, 15 May 2022 20:29:39 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g22v0ycf9-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 May 2022 20:29:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYLQGO6PCQTr8WDsGC0gx74jHh4JUr8SeNBwNqDT+kTwp91aj2h6CZbdGwqgRzDDUzdukThRm+h25STLM5Hiei0zdGxbg3zn8+lFGdj+e//p9FO4zt3edlhdnoVybxKOB++20Uc1gOz0d5HJ+ZLB4xkSbuldvTIn1LRFr2FmsFXSbkFnyHgFpuDrBruN2GSRykMrk/mvfBwp4J9Jwf10GPQLxLuMSreU0lZoU3/IEajT6bEkkHwl6J4MUgsRKQJSKdZy9mV3V7s7leAv6dqTRRdF1rHgr4pdmJNfjyq/zfiukdTn9c1yCupaF79Mb9CphzhsmzVV8ADODIlLKSzh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcDZ/GCxptji7TIxU+yvYx2u2k6D+R83m19Fo3U4HbA=;
 b=EChoMD8I7owSD1C9lbnwkFPbPvcz08+flplOtS7pKjOdzdroq/H+9SkY+OOQJypmgE7pf7X3okf0rE0cqE6GeyL/woVobJ/e393Ic6d0kvO0Meb1QpdPJ9BSu0AUEmStoMbIfYCMAMXXDEWsu3c4NH/gvMq0FQCiuA+3O3wXummrDegQLmacREZrUx2miFlTyPQYos0zUC5OOtK0MJvq/7XTb7FWExxnt5thl3oyaFnX4O3i3HiX9oDYWtmo0T8B2759xHysHrE7Q8EMu/HOyNBcc+vhTKrnD5i+nZx4m/YrNULaiVDWz5apKvSjFqGvwUSO1PJSodZvBfz5d2HRJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcDZ/GCxptji7TIxU+yvYx2u2k6D+R83m19Fo3U4HbA=;
 b=OAATJnsebA0BvRkmck5LmrcnUFIxWAYuXDDRQI3zt45cYw3A6GQjNuVKVNbW1f0HTT1gXNIGb9EPaub5dqfGaA2UQuPow1nMYXsDJw3aaB9SMcl4aj9z12r8qqKMrP4fkfLZrsvT3oHhVjT8UMM3SrZMuwyRHK0ufw4/b5AYmWk=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 BN7PR10MB2707.namprd10.prod.outlook.com (2603:10b6:406:c9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Sun, 15 May 2022 20:29:33 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5250.018; Sun, 15 May 2022
 20:29:33 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH V2 7/8] vhost-test: drop flush after vhost_dev_cleanup
Date: Sun, 15 May 2022 15:29:21 -0500
Message-Id: <20220515202922.174066-8-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220515202922.174066-1-michael.christie@oracle.com>
References: <20220515202922.174066-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:8:57::22) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60d9c07e-7306-4f6c-7230-08da36b19ef9
X-MS-TrafficTypeDiagnostic: BN7PR10MB2707:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB27079CD6A1BC006DD2380F9BF1CC9@BN7PR10MB2707.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2r6QYEWJufm8I5lvSUYJE/nG+UUpi0VQ2Fqr8ZxtJCUZC4bbuIj1gc/n4zHEPTPoh02a1QYMzr8Yx8R5FvI/UEkJF726kcZm9Gx1pBgJjt8ANoPlHoRobyY9X+72UYPyEHonfcvTYqJyv3D/BqGFh+R1HX/PeLGUhXTffBM48n1y2mukqN5IofxTONj2UywfmNDvKH7crZHdqE0i96Jqxs81H/e2OK/p4lquTvVzrAbGVxTpXHFJ5W27r1enCmjok0+sghkwADE8hXx67IVWZtSgZkg9PxkZXt/UZoeJtWy8vBa/8GJ4bJQsM8NsxriL0HrouPKhWIu/YtS5K3/l3iA46mtXllyGLMJpmDd9ysRZqvMnJanJGZiV00rqCnddC8v0g8Eujy0M1c4bJlH3Jt3MT8dL59KGXxDas3f+TxiAuy6MWUsQrqEP3NLwEk2w8A1JXRcudmjRjNhFOn20pJ2FDExgEAUU8zR1TKpoY1viUMGAptnyJFHGR/i9rHS0mDs3GISN0MrQwCpZd4h4HQI05MfABC2uQUOKoneziNPCIreQePhlbrlcjCx0R/zPLiKqMFKIbgSGAwNqs1Gq1qVdDM7MGOZhfgLM7FkEHO7FJ8+culk0Xy1PKu4CurzLoAPnPe8yAtQrrhItCdBN0quH8132UOQfe089XRGOGdXNSOcXLT8xgboXZ3ZcarWYS+3rj8d62R0tBknxp44v/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(1076003)(8676002)(107886003)(38350700002)(8936002)(36756003)(316002)(4744005)(26005)(6512007)(2616005)(186003)(5660300002)(6506007)(6486002)(2906002)(38100700002)(86362001)(4326008)(6666004)(66946007)(66476007)(52116002)(83380400001)(66556008)(508600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a5A/mNI73bm9wfG/WIDN7zf6Ds2QYNKFAs2w7gdkLSjL9hjZpO3Nf8nXJlAJ?=
 =?us-ascii?Q?vuA8eafllfsARgJEbZoqwK6KT1aPQ2CKb5cUEGaBGpgdWbp48QIAShf6FdYD?=
 =?us-ascii?Q?PixtPYXIxvfrajUvyNXdV02TOVzCH4qrxuWmq3BBCirW/mkX63Ww2CTA4xD4?=
 =?us-ascii?Q?f8ChR28Vc8vj+7PaOKk2iJFn02aguK1FS0sAKaIAB0qrX31aD0mhwKVpb7eP?=
 =?us-ascii?Q?O6D8aDeoal7T4h5bobJN2YS6YpUEsSBvoGOLHBIaYxOjOc8TUiuK0Kb9k9lx?=
 =?us-ascii?Q?JUFxjj1zTcs5YavERAsDnm/y2XvSopdOz4UQIkaMpkKdXd4DS2HYN7biiUvF?=
 =?us-ascii?Q?930dQf/ZeVbfVrLKFo7Wl99VYvY7JjLzta5pBZE8caxjo44x90n7PEFQmka5?=
 =?us-ascii?Q?Y2klHLgTG6kfBdMmSSGqYLJG0bnsOzucA/4Zca/VUU1eHlKeAz5m23q7xyMq?=
 =?us-ascii?Q?KkZStj9IUW2iwNJsAFV24Y4AnQCo4ZRFAD0eVw2JhWSvibNZJ6LOwRtavzbv?=
 =?us-ascii?Q?bdzx/Ohg1sKu6Wb3lrjBAu6QXNzQMkYSOXKxuX+rg1RxTm906ECrX47bqHqI?=
 =?us-ascii?Q?A8erL5ELTewy3gbi46DVJGkpQ0cO3EPB2xi4khgvBH8S9e37/Eokx574wBa3?=
 =?us-ascii?Q?irBTcWoR/NwON97IPekqtx/5Z1XAgYAR8yV05yKBZsJe4/v+VY4FLQqXvlkT?=
 =?us-ascii?Q?spZt5mDy5ej1wsYbI0KE/gpdeI9+pU1rCi3X1y/qQcSQqCIsMWtBn/viI8yQ?=
 =?us-ascii?Q?5YW5Bu6ontUWqJWLa408pb+gNBxigzcCl6vvRmy7/HM5gjRxVlaMJDOshzGY?=
 =?us-ascii?Q?8znfeTfVmUYogZvpHqdo2PiiBHP1fDuVzrwvXfxwrVAaSb6OCoqh5KwyWtfZ?=
 =?us-ascii?Q?Svx+zecrMmZI5NV1r9fb+8t8Pl5nJaDfAG+lyxfp/JQ/rMJ+C33HDZB8XkpZ?=
 =?us-ascii?Q?jeFcrvKiv21Fxlijjtb6npd5Ut5ZDYl6J4+2h0Eu7y0bg4fZE4i7UfYKJ+4M?=
 =?us-ascii?Q?Rn5TCz8kzYPFzIURjGH5ikXzSmfbw2U2U5KaRiDDgor5G3JXiVvvCSGW/gVU?=
 =?us-ascii?Q?9L/OO30WZBzu4PZVXCxgS1OZWDpn2unBpYr1bOSHFakToC+m+/eLLUIuhq1X?=
 =?us-ascii?Q?TL8LsItJ1xrOUPFRS2+FSREo4+IlDXAlhG0ZbieNJKSSmwGFG0sZihhIRE/1?=
 =?us-ascii?Q?szxbbImTNkdeJH7SIlyTrNuSmMiu099D13e+N9dTZss27gctaiC2FNL5Y6TH?=
 =?us-ascii?Q?hqmvWhWZxmCVn77o1lR5EX2dTKwW4Y85vwYx8tyePh/f9m52KBq+PRTOCj3V?=
 =?us-ascii?Q?j2nMz7WQa022M/lmxpygfA5jmLMFzZBhLyjl53BnSBKTyQq1X3pRcuVcnb4U?=
 =?us-ascii?Q?FIW45XBVM3suFdqgAJHdLwz2wEgLmuuuaIKgq9FrtseT8zMtMbJRq4jMewjM?=
 =?us-ascii?Q?Oirz3GLQjNJ4ZGlt59hLJOBtM9cRxSUEozuRWC1h/fYdEmdTFitMK8rKU5iQ?=
 =?us-ascii?Q?+CeGISajfGyXvcdv5nCOzq9935xoSIgXqD3E9rbP02yCyGEuOnkr3p5eUygl?=
 =?us-ascii?Q?ymYYpXpqTbyDOtaC7nSwh3PVhNYDulZl5FVpjHAC2lAiaNKRwgRvXO5Oi5mq?=
 =?us-ascii?Q?NDMvhnPO9amQCxPj2PuTF/HSaJ2rcvHkSMW+96UhUXYS+TiZnddxwtvvKTiv?=
 =?us-ascii?Q?DZO9ngdQjzwsh81D5dSmQTZmlz3z4lSKG9+cAkfZR6glpDo4eWgm2qhblVue?=
 =?us-ascii?Q?zzg+rNz7kJ5j3gSJEKJwDW/1qdKTL8w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d9c07e-7306-4f6c-7230-08da36b19ef9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2022 20:29:33.2480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuokAlN4g6HZY0hNZzaMrcq/j2bV2iFeYw0JleOzZRSNdoh2NBODQDXXMIEij7zhsGp6ot6Uvs8HlaCvoFvLLruy7ks5Ka3vymA/Yvcty3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2707
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-05-15_11:2022-05-13,
 2022-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205150120
X-Proofpoint-ORIG-GUID: TsJ4LBn8llnhC9HiDuTncILw5ZuwBEEZ
X-Proofpoint-GUID: TsJ4LBn8llnhC9HiDuTncILw5ZuwBEEZ
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
index 837148d0a6a8..a63a626a554e 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -158,9 +158,6 @@ static int vhost_test_release(struct inode *inode, struct file *f)
 	vhost_test_flush(n);
 	vhost_dev_stop(&n->dev);
 	vhost_dev_cleanup(&n->dev);
-	/* We do an extra flush before freeing memory,
-	 * since jobs can re-queue themselves. */
-	vhost_test_flush(n);
 	kfree(n->dev.vqs);
 	kfree(n);
 	return 0;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
