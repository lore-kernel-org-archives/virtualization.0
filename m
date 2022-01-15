Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728C3C433FE
	for <virtualization@archiver.kernel.org>; Sat, 15 Jan 2022 01:22:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 01E9040384;
	Sat, 15 Jan 2022 01:22:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xwYV4UtXylTn; Sat, 15 Jan 2022 01:22:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 91571408D6;
	Sat, 15 Jan 2022 01:22:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7787EC002F;
	Sat, 15 Jan 2022 01:22:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 715BAC001E
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Jan 2022 01:22:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5214460BB6
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Jan 2022 01:22:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="Ck8hM6aL";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="Uw9se3k6"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7g6Qp1_uFhzL
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Jan 2022 01:22:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 84E8160B74
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Jan 2022 01:22:04 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20F0wnd6005666; 
 Sat, 15 Jan 2022 01:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=oXoqgr0xZLjv0xtjMYRn6tRwSBJnI9jaLsbh7+ofQ8U=;
 b=Ck8hM6aLRIdlTYGNXFdhTOpfzW6ubCYqCAOLM60Q/RiS8L1TtRh/yk2tnd93W/DAQYaL
 NWqTBXKAHLuCmjZJ7b+3CGoqyrSqYCL8ISu2r/jrtDrINt6TeBAnMg1X1KIJ+0dfhwYU
 YX22WfdoHlukdMxKMttcRFhQmYYMxUBYLcuN5pnoFxxjwkmDisSW8z5nWS0ZMU5hkGiQ
 oio3ufz2rkkXCf+6o0GWMyNyJ9fAwjlPIXAOZnLth2Ewk6S42it0UNmOFP14po3z11ah
 JkMFlyDehqSDwvr+wGn+7vxLfjMjIcGVZ/xbY0X7cpzf/XvMSxwnXmVR+r2ek18j/RED zQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3djjm0mxax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 15 Jan 2022 01:22:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20F16KUo073296;
 Sat, 15 Jan 2022 01:22:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by userp3030.oracle.com with ESMTP id 3dkkcsjsrx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 15 Jan 2022 01:22:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXg9U8+msQ2tdf2yacLZJ0YCgZuqTxqJ4POmerBmKskHWLIMb3KO4aUrPK57eLNQqy7ySy5wSa7CeurioTC6DnGUJ/xeO92ShW3Cxd7oRhLqT8d4Gj/89Md0ctHlB/mvM8R786hpugrmoauuFlApdQq+54KXhrJAbmj74jmeFs1MZANxwUHxf5wIfc0bD3leeOhB0HxtyTMG2IxF6Ho+cDpPh7oCC6gbHoBe3JWa+dc+vNBMXpY/GH/sq75e32tjohe+OxWLXCACaoXKT4DOeLaWTpvI9CmROE5+3JFuZdEWaG/3XK4TIf5jFTl49e0g4hsBMs5NhabL3GrHNjKxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXoqgr0xZLjv0xtjMYRn6tRwSBJnI9jaLsbh7+ofQ8U=;
 b=jj0NKd9Z73ocDkBdX1no9uPAyHcduX5ooZfET4M9sYvVWy7S7UZFwfr2ban4BzGp0JXxoSO2XmraJRbQSORat/iLBGslISC4tB2n50pE+oRWAnGnE97qoyg1cQxy/e62AnSCKQop44A+ZmLv1nLYgrfizcx76OW4UL3GUdwmgGrvOzkg1zF3prGjcMk5pr7fEt+tYZphbFRGCRc+kvuV+J/zHDnCdyW2OleQBeOY6Kx5KzQdMcBZD59CVOsISbSXVBiwQsTtUbeLLk8TCAgu3Ztma7YKSCH6lJy3N1mW0msX7qkFOPCBA+X7Xh5cbhBw4RMO9lXPsr8kvBwL6YARNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXoqgr0xZLjv0xtjMYRn6tRwSBJnI9jaLsbh7+ofQ8U=;
 b=Uw9se3k61XXPLQdrsNwtGDz/jvDfC1oMMs95T4hBtzdCyY47iJQ2gUYK3EFQL8IH2feOvs1wap2Y4Qtj9N/CuBMS8RCdWDY106UmUrL7ulky+izQqup5PjFDhzbxnEmbT9vxMwLfhxSnpq94E55a0eRCoVNZoyrGOLCGHqRaQ7I=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by DS7PR10MB5182.namprd10.prod.outlook.com (2603:10b6:5:38f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Sat, 15 Jan
 2022 01:21:59 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%6]) with mapi id 15.20.4888.012; Sat, 15 Jan 2022
 01:21:59 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: elic@nvidia.com, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH v2 2/3] vdpa/mlx5: should verify CTRL_VQ feature exists for MQ
Date: Fri, 14 Jan 2022 19:28:00 -0500
Message-Id: <1642206481-30721-3-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1642206481-30721-1-git-send-email-si-wei.liu@oracle.com>
References: <1642206481-30721-1-git-send-email-si-wei.liu@oracle.com>
X-ClientProxiedBy: BY5PR17CA0071.namprd17.prod.outlook.com
 (2603:10b6:a03:167::48) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41a22a43-b224-4260-97f4-08d9d7c56d3a
X-MS-TrafficTypeDiagnostic: DS7PR10MB5182:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5182792667D8E29FF59796B4B1559@DS7PR10MB5182.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:254;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mv8QUHiqHFF5U3bFZTCszE2vKQZihsV/R6RhAtBTkYN+mCqroSsRmBAKqQasI890za9ugUETkoozgHuse0Kti4MHm8AsS5aRPqyRGZVopVZsnYEdMerl3iRHUBtCWQZXAJ6L3IG+oI8NC/Gb3Ha1M7/GaFKacMPpOS/7KyRtSKms45y1f2ESJ2bMJwLEl0llSSEFE3QiRKX4rzPKp0JHMrAMryanWuUe4etXJLmPi9nHewUg8eoj1lUjl+7I+eX/iTii2Re5txracW8RH2l7maVUkCc28/up1NxZkCAEOpfbJyO+WXnFhBshFmF3cIUPrzykp6xoitKiceAspnS9JywbuKJFyknoRzCsmZkrmlJ6s3ubbx6wONdTYw0DvvhvjUbepB4a8tYg3htzEOV3digUHr/E9r+7L/wgD2vOOLNNWVnlA1uu7zW6bxwddJ2l3NA9zvvdLQLqBTW9chV85y+cJdeijaVlJM5aOIMTwguN3BNcRuQRgiH5nhTuKAUYTwL+AhcT92mWHccJDVexonZjnJc5R5m5j2hcGqI8s2xiRPw6lhAyCT8SpmvrLRosThyvomrv/HzpNbhGKaeX2rdy45PbV81sAEF0Al9ujx7qPlf/hemsw0VUVSXtJmeH7vKpUOBTHcr4zMdy7E84yxZIT6nElU/Kj9rYPPYBKk9gafQXeZ6B8ob7eD/kC73vh4jX56OylRzWwKApw158CA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(6512007)(4326008)(6486002)(66946007)(38350700002)(83380400001)(66556008)(6666004)(5660300002)(107886003)(8676002)(66476007)(186003)(6506007)(36756003)(86362001)(508600001)(2906002)(26005)(15650500001)(8936002)(38100700002)(52116002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6n68y+waMk0yJkGqg426uvFYIN59/yjIMmbgLTgWKMbaXpaP4L6JEFbmZ1BU?=
 =?us-ascii?Q?LI2o5hu4olmFiJiurBXErHlRDS4b55V+fBgcvywhEqflnu3heDjJc8wwItz/?=
 =?us-ascii?Q?IU1HLo7QD2XAYA06wjQH7eRcxlozrK55pIBH5sCGfQWblUkfYo6KIHNolVXy?=
 =?us-ascii?Q?VGoWaBfi7h1nyFuEktTUejokzTxMWoFJtCv/gsIPSbe58lDwwe8ahsYuT4eu?=
 =?us-ascii?Q?4DVcTEJxiYn9OvKQfsGowDfx//ItG1egncYh83Rj5mGd0suEdNLBRReImx9U?=
 =?us-ascii?Q?PVAbfOY5YeG2qT8miBKkol1hE6oySJ8B47h5OqiW5qZGuW6DE0vg/F9g8xfW?=
 =?us-ascii?Q?TLwR2itQtPyEQmJdiHIUIdcmGmeu4nHtiWbXELu3Hp+noS6qc9wKwneCO81g?=
 =?us-ascii?Q?KfqbQnclVTcskjvOTeNwzYUSxuuXoCKTws+FcwFuZUhxDDd+PscLVdgJkKFs?=
 =?us-ascii?Q?z0bpZPHmjuOcEHiqID/hDQOmz/Tk5K4lZ0HXZqjisbwZVmS13t/D5pg8Nyh8?=
 =?us-ascii?Q?lO/UDB/pRWEDBbU/HBuSf0tignGe4vPIirwyQ/g62c4yp3Tb4fEWFyzygik1?=
 =?us-ascii?Q?sOB8BIVd1kmPmZXhzzKq6rsRXrId7Df0LlxlrpR72NosOAMYSJxuwRQhF0lY?=
 =?us-ascii?Q?DYQIyrHhx8FQEen7KsXTZ3IPmN1LOGPxabAjpkDB2arNSlrAg2E/yTGxUx61?=
 =?us-ascii?Q?rnGSLJ88G2CxeGeXUTOcaSXVHlFlcs9bIKPvockn4OFSyEI8Kzh8ziMHMICT?=
 =?us-ascii?Q?hrSmawz1yoLFjrMMzfzdvobja0NrBlwghqgRQoZzPumlj+Bv31ln/UjyDLOW?=
 =?us-ascii?Q?zV5Z2tixrrOg4vYshlaEZ0DR40apIp1ApbQPcWIaj966Qt2FT2Fk5M2r6D5v?=
 =?us-ascii?Q?rAX9A+nIn6zhLHV1Tof9xekbtBWvhUbOWrcAaKul03GeDQviqhSH2sP6M+HB?=
 =?us-ascii?Q?+CNvW03DjXw0RSiXODXUU08hkYL32yPaUfxg1aez/daze2iK9EPmrb7Y4IlT?=
 =?us-ascii?Q?NCjahRSBaGeD8TnEfMzHR0boMWHoYTpVpLGjElboFh7TLGbjJnzpNoWU3k01?=
 =?us-ascii?Q?nLHXtrE+O6AE6OfyqUqA8LMQkX6qOeavNzufoDf54jfMEXfy3r4NoRP0JV7S?=
 =?us-ascii?Q?blv5zcQxz0fCBAA1DD3mn7OpflkBhWCj4dUqs/y4UUNamYkmbeYDdaR3E0pQ?=
 =?us-ascii?Q?dpjja5ChLQxXEEOJQzVqtADeWAAY29dDL4Xi5P2jzsRDFg+OGK7HGKwOkW46?=
 =?us-ascii?Q?Ng8o2ePYosWSJZ8vDZ7SNU4xWi87qTvL/Ikvyeha1IJ5fgffonCuAGaPs5cj?=
 =?us-ascii?Q?OLzUXRPG7rFoekxywSx4JIIKhhQwbtY2wMWQUlFmqG0SnAQyZ3AJ5JBYCjEL?=
 =?us-ascii?Q?HzDCgK4rwpcquw1EMFOJlJ0Lp3rJoUQzl/d5bpSAi3ZqAZ0UYANYLNo0dDDa?=
 =?us-ascii?Q?87ShiISbmIXHYUt5eMBrL+OHDfC+V/K31rN5ony0iWuGtAkcQNaXInfdZ5no?=
 =?us-ascii?Q?dPPkScVXjVEaHCfItc7a6ScsHVddBxB+iz/DrqjPZ4SjFaEYMZfkiYuOlNYb?=
 =?us-ascii?Q?gTdQw/h25Mzighnn6HZXZ5Cq/61u3rvJFHjpN1lUWyseRHKy94BaWRCg0u+O?=
 =?us-ascii?Q?NBQAMBqJAKdSQaRwvGMOFSo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a22a43-b224-4260-97f4-08d9d7c56d3a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2022 01:21:59.1971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkNgN+QDR9NByFNM/9xjuWAN3sXIyvp25Fp/B+wdpE2EKZgkSKtzmayhfzEpLq9Mq209WMM/IGNsOppb+1nBBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5182
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10227
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201150003
X-Proofpoint-GUID: CGF-oXN_wlP1JgtMpgTbW9EAplQy8ZUO
X-Proofpoint-ORIG-GUID: CGF-oXN_wlP1JgtMpgTbW9EAplQy8ZUO
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

Per VIRTIO v1.1 specification, section 5.1.3.1 Feature bit requirements:
"VIRTIO_NET_F_MQ Requires VIRTIO_NET_F_CTRL_VQ".

There's assumption in the mlx5_vdpa multiqueue code that MQ must come
together with CTRL_VQ. However, there's nowhere in the upper layer to
guarantee this assumption would hold. Were there an untrusted driver
sending down MQ without CTRL_VQ, it would compromise various spots for
e.g. is_index_valid() and is_ctrl_vq_idx(). Although this doesn't end
up with immediate panic or security loophole as of today's code, the
chance for this to be taken advantage of due to future code change is
not zero.

Harden the crispy assumption by failing the set_driver_features() call
when seeing (MQ && !CTRL_VQ). For that end, verify_min_features() is
renamed to verify_driver_features() to reflect the fact that it now does
more than just validate the minimum features. verify_driver_features()
is now used to accommodate various checks against the driver features
for set_driver_features().

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index b53603d..6fa968f 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1897,11 +1897,25 @@ static u64 mlx5_vdpa_get_device_features(struct vdpa_device *vdev)
 	return ndev->mvdev.mlx_features;
 }
 
-static int verify_min_features(struct mlx5_vdpa_dev *mvdev, u64 features)
+static int verify_driver_features(struct mlx5_vdpa_dev *mvdev, u64 features)
 {
+	/* Minimum features to expect */
 	if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
 		return -EOPNOTSUPP;
 
+	/* Double check features combination sent down by the driver.
+	 * Fail invalid features due to absence of the depended feature.
+	 *
+	 * Per VIRTIO v1.1 specification, section 5.1.3.1 Feature bit
+	 * requirements: "VIRTIO_NET_F_MQ Requires VIRTIO_NET_F_CTRL_VQ".
+	 * By failing the invalid features sent down by untrusted drivers,
+	 * we're assured the assumption made upon is_index_valid() and
+	 * is_ctrl_vq_idx() will not be compromised.
+	 */
+	if ((features & (BIT_ULL(VIRTIO_NET_F_MQ) | BIT_ULL(VIRTIO_NET_F_CTRL_VQ))) ==
+            BIT_ULL(VIRTIO_NET_F_MQ))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -1977,7 +1991,7 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
 
 	print_features(mvdev, features, true);
 
-	err = verify_min_features(mvdev, features);
+	err = verify_driver_features(mvdev, features);
 	if (err)
 		return err;
 
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
