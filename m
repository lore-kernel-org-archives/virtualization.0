Return-Path: <SRS0=OSH5=O3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32900C433EF
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 21:45:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7D3A60FDC
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 21:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E7D3A60FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C872260796;
	Thu,  7 Oct 2021 21:45:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 76FUM0dEIjwt; Thu,  7 Oct 2021 21:45:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4F92D6080F;
	Thu,  7 Oct 2021 21:45:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37518C000F;
	Thu,  7 Oct 2021 21:45:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F023FC0027
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF27B8405B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="sJGEeWLk";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="tf8dkD40"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id upg3CYy7Q9ed
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F3F548402C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:34 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197KYYts007644; 
 Thu, 7 Oct 2021 21:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=SMrEWBdJH6U0LswhijxTTMCWpCGKqrwWsxt+EhVz3yc=;
 b=sJGEeWLkv2RqJzwqxant+qLNdoex7k1sTv4aDv1U1Wc/FCwuF88LZ2ytTZ3md8MTOG14
 qCvRvHskerH0dGb2JgUaqIPdStIul80CjmeRe0XCm4exIf7LxYX/p7gLT2eu7oDLoaGh
 rmmi24krZXeeI9w+8o9Q5r9vDFJSCiwwVfkNwyw+uVgPzt7R+Xmt2tSPOeB890tz0+lL
 T8e/QQc+87mlxWBRpRA8ePlUmrRgLPYLxflXnHMTtxp09iPqwELkylwSQVRNqQtty9kN
 AYzID5VU5hYvxtAsUqAUxTNQXwihEjAsi9leTSQDXbaujv4IAdxqHEOXe2nLBI/NDTGr 0w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bj0pw475x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Oct 2021 21:45:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197Le7IT113075;
 Thu, 7 Oct 2021 21:45:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by aserp3030.oracle.com with ESMTP id 3bev7x4uju-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Oct 2021 21:45:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1Xi/9f3BvqWHm4Uz+zzb+kXPhTOppD9gvg8vMVXvVLpcHT0SeUG7p6Nd8QjBk7CgKyUUdPtHtbA80qf8f+FqxITHcApWzAMdrFqUDDdauNKaCJMDAFCDRuZMMbpwjcRsjpHdYrv60fk90HsEeOynY8LxedExgCykMNWRtJLXUotYoag9PwkBsy2XuvYIiQIizKxtFBH/hoQbUCjDinACWST7c9XeCmbJPmGUAr9rgRewsM999NkVZwt77QFOUlhJV6mj2BG1LFNMno2uexalvgzyY0mOcIUnFh+abhvKXXp7PvwQOMW/EbRLALAoJQNgw49ra0tpB0Iy5HZlWcAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMrEWBdJH6U0LswhijxTTMCWpCGKqrwWsxt+EhVz3yc=;
 b=H1BxJIdfMrpU37c/jRUp2/0EaRykv0YbW4hm9AO3pWVIC39+/IVJ7F/hhc0+q8s7wVGjy9X8rUWBgfk1ODLyfRLBxYSqOJQRBTPMiZM1oVL5qmj2o4VdlrSKD8Aw6bdsHmxM8fZ2q/tv7EmEtsacJ6zaIksZp368RtEWtrvaMStA4C+RMIQOXyBrE7odNPVfIVAdSxWNLHp/KUbaPYJAVCtAYwRjSCyZg2gqNFI05iwUb0GBvmwELEdq9Dm7IOVsAzviu/ZIOS1ORZ81NUNv3SlIMdHEjpt/i63HioOZPiBGTt8t9s6MV1O6Qlrypf/7hDGJXp1l8I8MrliJZsJbUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMrEWBdJH6U0LswhijxTTMCWpCGKqrwWsxt+EhVz3yc=;
 b=tf8dkD40upBRuFkN1bnMg8jPgrPK4L8vzhJsjxAGCrUaGmMrw3zU1XYZVntCwCgKlKLbtdy4vUz0SJODXpJmOm63bu0YIR7DazL82KQ9Z0sAPy+7N6aLpPzTnhNkJMhCYp272VpX53P1mUEVSdBlYk45x2CdcY4KWs08i2ly5dM=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1612.namprd10.prod.outlook.com (2603:10b6:4:5::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.19; Thu, 7 Oct 2021 21:45:00 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531%5]) with mapi id 15.20.4587.021; Thu, 7 Oct 2021
 21:45:00 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V4 7/8] vhost: move worker thread fields to new struct
Date: Thu,  7 Oct 2021 16:44:47 -0500
Message-Id: <20211007214448.6282-8-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007214448.6282-1-michael.christie@oracle.com>
References: <20211007214448.6282-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM5PR20CA0008.namprd20.prod.outlook.com
 (2603:10b6:3:93::18) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR20CA0008.namprd20.prod.outlook.com (2603:10b6:3:93::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 21:45:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57aa5929-4430-4808-562d-08d989dbb6bb
X-MS-TrafficTypeDiagnostic: DM5PR10MB1612:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB1612F3D661E1CBAF2D2DC614F1B19@DM5PR10MB1612.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Hkk9x6ucM8Ebo5mO89Kdx/z1bgipT5g3ezzDjfKzLE3z4bea5wnFZ2Bc6sVx4eLh4m18aO1kT1OqcJGYHLxoKl8ZQC26NmTUgGiS/5W+e01fQmxZ8V+rP3kzTVb+fgUomnm2TMSy+xKDgj/5xNlSCH8tVU9FCwRyYNdiPl9YRXQgxBRtSzQuk4mOO/gzz5TecDqaNa5ViotZUjQNOBDpBlsWlmxg8+iy6WwclOEFWgMio2bjCeWgsBVKPHDuL+UG1Yzgq3++jrjdH+nT53dIBrMOv7HFP1Gu7L32vvl8+lBiBaS4uC+tNrFAdsqJQ6MiX+VC7eSubbkhV0We9fLJPSmD1s3Ug4cvmwtmmaGp9Ojd1YRcBnyFBos/E1nrzf8dEcWoGbgML8AGXD8aYxRT+8Xtc3eA8yrNQqBe3sAGqXCAWI9ijVK87eDiBlEz/t1bKzZANqwOGx6FbOcgdNj03wFLMmrP/jwoRCosDaqHYuRyCNYPUkiFkqVMzd5ssl4loOC10w1i/ilc8MU3j1HTN6YRVxGPrS+YckdpOVLAYlXnoxY330cITJ/Rsl3BLG39ZVdaQexwI0YibhD0QXDcVnwloik1+hg5dWsHjXmJVHPRYbcN1b9hYaBvw1Wk/rkPhYqIQ5GXjjIBOwYugOGBYez8hxLIHFxqUdumHk3ZFJ52O/D3Ob/tWwIi0D/Vp6ua6XGuCxQFAUTQB4XhrXTKiIg1I2r5aJuynvkRMaj//M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(36756003)(2906002)(66556008)(1076003)(66476007)(86362001)(186003)(6506007)(83380400001)(508600001)(7416002)(52116002)(66946007)(6512007)(8936002)(921005)(107886003)(26005)(4326008)(8676002)(2616005)(956004)(6666004)(6486002)(5660300002)(38100700002)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2xWAcFhGltWEBw20W7cqXBHLAEHh8HRu+QN7LX3c7TC2gicrqTa8CuBa5L2j?=
 =?us-ascii?Q?buNKAH4W/uxuFIwxLg5tGhJ/zZnIQ/CG+AZPdqPSPs8pLSB3JD79mydJyqea?=
 =?us-ascii?Q?vj/RDiJqR/nz6yg/JsKRQS0ATl0ml30t4k24NlEmBDsOdkclBXFGKlob6dMO?=
 =?us-ascii?Q?yfxtbOHBWh8IASCOiyYj7db4tE0taDtd7z0FTfjyteRNGLlU/tawNGg/xbe/?=
 =?us-ascii?Q?F92PaKI1YuAaajZ4eYWCwFfm6VMm/wdgUO89Haca9tNw0EhALg7bd3+xpz+K?=
 =?us-ascii?Q?a8sh+mMes4FUGT0oSl4pnk0Bk5GU49/1dSeCsMNtdnf2EJ8vXqygmX8U+XFN?=
 =?us-ascii?Q?KpQod7oZVhTKFtJ2h04IgndSg78D0VxtLByfaP9M54M/UVQ8QNzASykAVZE3?=
 =?us-ascii?Q?GYOwsP9s8IdjrsvkM4tkfc7DuPROcVqpior+P3phEcxfxxsBtd1lVfaeWjC8?=
 =?us-ascii?Q?6pk8plhtm00090TTG1uS5p71lZdtYOeY+hCIIzTtcre4+LdWHVxqcoGsLwMj?=
 =?us-ascii?Q?JbMNGCD+fGlSJ4ISC/frEJnHtWIxSN4Ua/FTMZpHd1FPMn1zyAMM3axDVlmd?=
 =?us-ascii?Q?ZrzUhHL+VnbI80A2AXUVoI0uL8TbDALRrdgrdVpaTOkN1/MJRCbszae6LzGJ?=
 =?us-ascii?Q?DEDGW6MWIj+N08N6EdsFEETFem7k9sqx8kzA2QkF1gKGBnXqleXgf7agqH4h?=
 =?us-ascii?Q?STnq+2Jke8qoWpqb/yW0RMFJ+yvEaf9aOABtwR6nAXBObs9YZVhRCFFjobZh?=
 =?us-ascii?Q?8AriqkYcqRgzLtJFChMDX3mZBq/ylbmyE2e3NTX5pmK8pl0AkaPu+Yf1MoE6?=
 =?us-ascii?Q?vD6kEKBvfHsV0DvECDnKsESa+/tI1Ch26xv3qvQrsIYnVswdU/qLoYU4GQlo?=
 =?us-ascii?Q?/6kM3Gwj0vQPvgarwy8Vma/jjcYHImstQTsNMdaWPZ434lqe2G/0pcbSLIpP?=
 =?us-ascii?Q?YMVxs+4ugfsLQf668e9n10sRgIhAJ8sdCt3rZ73gvWYeW/My4FR8WVQ1Ll/n?=
 =?us-ascii?Q?qvrXLaZNzq/l6wXZaP9Oad9CSjWmorwgayiydy3mlpq4zNqZkDf/31NfnnIp?=
 =?us-ascii?Q?izmPnAyxAo4euKx0YZ7lG0ZlqnmZLGPKWIhFh/IkgePhNpyuHjBNacy92Eis?=
 =?us-ascii?Q?7hZU9bPWjhsdUu/ttSAqinKSChkc+A7Giw1uc7mj/sR3/vPjJQZ3zpM/k0oA?=
 =?us-ascii?Q?47iyvHg4X4XY/cP7DBYixzJJ2I2KA7vLfZ5foy8/cNfWvjQFBJUeRPi/o1/7?=
 =?us-ascii?Q?g0g+G5Ah3wLh4bYENoqqSAsG7pdBv4RJdIyY4BoOrXfIAVF6CvcTi+kEeXV6?=
 =?us-ascii?Q?zEgs0b8j3JW8aBnO8Lpm4maa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57aa5929-4430-4808-562d-08d989dbb6bb
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 21:45:00.7509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4gjszYPiRQyqhitPc2WuWHZzsBtkwVppZ5HVL3H5GoCNjM+CNC4qVW6sneEErmsHNEFXxyozRd1G4F/TYkB0L3L2Rq19HxxIBWPa+pdlJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1612
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110070137
X-Proofpoint-ORIG-GUID: sNGd8QUAzQNScuyDYe5Zh6CEhivu75UK
X-Proofpoint-GUID: sNGd8QUAzQNScuyDYe5Zh6CEhivu75UK
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

This is just a prep patch. It moves the worker related fields to a new
vhost_worker struct and moves the code around to create some helpers that
will be used in the next patches.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vhost.c | 98 ++++++++++++++++++++++++++++---------------
 drivers/vhost/vhost.h | 11 +++--
 2 files changed, 72 insertions(+), 37 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 59edb5a1ffe2..c9a1f706989c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -263,8 +263,8 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 		 * sure it was not in the list.
 		 * test_and_set_bit() implies a memory barrier.
 		 */
-		llist_add(&work->node, &dev->work_list);
-		wake_up_process(dev->worker);
+		llist_add(&work->node, &dev->worker->work_list);
+		wake_up_process(dev->worker->task);
 	}
 }
 EXPORT_SYMBOL_GPL(vhost_work_queue);
@@ -272,7 +272,7 @@ EXPORT_SYMBOL_GPL(vhost_work_queue);
 /* A lockless hint for busy polling code to exit the loop */
 bool vhost_has_work(struct vhost_dev *dev)
 {
-	return !llist_empty(&dev->work_list);
+	return dev->worker && !llist_empty(&dev->worker->work_list);
 }
 EXPORT_SYMBOL_GPL(vhost_has_work);
 
@@ -343,7 +343,8 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 
 static int vhost_worker(void *data)
 {
-	struct vhost_dev *dev = data;
+	struct vhost_worker *worker = data;
+	struct vhost_dev *dev = worker->dev;
 	struct vhost_work *work, *work_next;
 	struct llist_node *node;
 
@@ -358,7 +359,7 @@ static int vhost_worker(void *data)
 			break;
 		}
 
-		node = llist_del_all(&dev->work_list);
+		node = llist_del_all(&worker->work_list);
 		if (!node)
 			schedule();
 
@@ -368,7 +369,7 @@ static int vhost_worker(void *data)
 		llist_for_each_entry_safe(work, work_next, node, node) {
 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
 			__set_current_state(TASK_RUNNING);
-			kcov_remote_start_common(dev->kcov_handle);
+			kcov_remote_start_common(worker->kcov_handle);
 			work->fn(work);
 			kcov_remote_stop();
 			if (need_resched())
@@ -487,7 +488,6 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->byte_weight = byte_weight;
 	dev->use_worker = use_worker;
 	dev->msg_handler = msg_handler;
-	init_llist_head(&dev->work_list);
 	init_waitqueue_head(&dev->wait);
 	INIT_LIST_HEAD(&dev->read_list);
 	INIT_LIST_HEAD(&dev->pending_list);
@@ -579,10 +579,60 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 	dev->mm = NULL;
 }
 
+static void vhost_worker_free(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker = dev->worker;
+
+	if (!worker)
+		return;
+
+	dev->worker = NULL;
+	WARN_ON(!llist_empty(&worker->work_list));
+	kthread_stop(worker->task);
+	kfree(worker);
+}
+
+static int vhost_worker_create(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker;
+	struct task_struct *task;
+	int ret;
+
+	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
+	if (!worker)
+		return -ENOMEM;
+
+	dev->worker = worker;
+	worker->dev = dev;
+	worker->kcov_handle = kcov_common_handle();
+	init_llist_head(&worker->work_list);
+
+	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
+	if (IS_ERR(task)) {
+		ret = PTR_ERR(task);
+		goto free_worker;
+	}
+
+	worker->task = task;
+	wake_up_process(task); /* avoid contributing to loadavg */
+
+	ret = vhost_attach_cgroups(dev);
+	if (ret)
+		goto stop_worker;
+
+	return 0;
+
+stop_worker:
+	kthread_stop(worker->task);
+free_worker:
+	kfree(worker);
+	dev->worker = NULL;
+	return ret;
+}
+
 /* Caller should have device mutex */
 long vhost_dev_set_owner(struct vhost_dev *dev)
 {
-	struct task_struct *worker;
 	int err;
 
 	/* Is there an owner already? */
@@ -593,36 +643,21 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 
 	vhost_attach_mm(dev);
 
-	dev->kcov_handle = kcov_common_handle();
 	if (dev->use_worker) {
-		worker = kthread_create(vhost_worker, dev,
-					"vhost-%d", current->pid);
-		if (IS_ERR(worker)) {
-			err = PTR_ERR(worker);
-			goto err_worker;
-		}
-
-		dev->worker = worker;
-		wake_up_process(worker); /* avoid contributing to loadavg */
-
-		err = vhost_attach_cgroups(dev);
+		err = vhost_worker_create(dev);
 		if (err)
-			goto err_cgroup;
+			goto err_worker;
 	}
 
 	err = vhost_dev_alloc_iovecs(dev);
 	if (err)
-		goto err_cgroup;
+		goto err_iovecs;
 
 	return 0;
-err_cgroup:
-	if (dev->worker) {
-		kthread_stop(dev->worker);
-		dev->worker = NULL;
-	}
+err_iovecs:
+	vhost_worker_free(dev);
 err_worker:
 	vhost_detach_mm(dev);
-	dev->kcov_handle = 0;
 err_mm:
 	return err;
 }
@@ -712,12 +747,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 	dev->iotlb = NULL;
 	vhost_clear_msg(dev);
 	wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
-	WARN_ON(!llist_empty(&dev->work_list));
-	if (dev->worker) {
-		kthread_stop(dev->worker);
-		dev->worker = NULL;
-		dev->kcov_handle = 0;
-	}
+	vhost_worker_free(dev);
 	vhost_detach_mm(dev);
 }
 EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 638bb640d6b4..102ce25e4e13 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -25,6 +25,13 @@ struct vhost_work {
 	unsigned long		flags;
 };
 
+struct vhost_worker {
+	struct task_struct	*task;
+	struct llist_head	work_list;
+	struct vhost_dev	*dev;
+	u64			kcov_handle;
+};
+
 /* Poll a file (eventfd or socket) */
 /* Note: there's nothing vhost specific about this structure. */
 struct vhost_poll {
@@ -148,8 +155,7 @@ struct vhost_dev {
 	struct vhost_virtqueue **vqs;
 	int nvqs;
 	struct eventfd_ctx *log_ctx;
-	struct llist_head work_list;
-	struct task_struct *worker;
+	struct vhost_worker *worker;
 	struct vhost_iotlb *umem;
 	struct vhost_iotlb *iotlb;
 	spinlock_t iotlb_lock;
@@ -159,7 +165,6 @@ struct vhost_dev {
 	int iov_limit;
 	int weight;
 	int byte_weight;
-	u64 kcov_handle;
 	bool use_worker;
 	int (*msg_handler)(struct vhost_dev *dev,
 			   struct vhost_iotlb_msg *msg);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
