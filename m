Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDB7C433FE
	for <virtualization@archiver.kernel.org>; Sun, 15 May 2022 20:29:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E050381BFA;
	Sun, 15 May 2022 20:29:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wIvZDKd4D9yJ; Sun, 15 May 2022 20:29:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7B59781B3E;
	Sun, 15 May 2022 20:29:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53F30C0039;
	Sun, 15 May 2022 20:29:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DD33C0086
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0130D408E3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="DI5a+q/C";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="e9K0LpXu"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y_QkxxPz0-Dg
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 268B1415D2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:36 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24FEiHSD012365;
 Sun, 15 May 2022 20:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=YkcNJkhbT4vcG8h2b6sGX3mOBTa1dMHVJKmvMCxLY04=;
 b=DI5a+q/CY/IskuCsca5jfglzq0jLECxAC1A1f0g7nTwzzmUr4FlnF/6wG+6F/CzVjUUp
 AbRXhveWZOVrJUWYFklfkL58GuWWP2YTpg6FjE8Hc26GtEZsK8GV6KqRs/uNKVtZdbzd
 NQOISJdqcF8cE7JSVzwm80DGgY9f2iwlul64aJ7LmWVkRTFGy+3FL9X+Qzb1GqtuG87G
 uHQkt79N733DZV1sC+4NyYF7gCg7avJVx2wr0MGIU9Rj/ccBYSBpQKkxIM++5ndRua0I
 HDnBukOAa2Q7Ad4jvW2cnAGdQJtV+8jpd7HaRSqMtPvD7cs1H7vi4+3NDu/kvJERy1fh tg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24ythsvv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 May 2022 20:29:35 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24FKOthD000789; Sun, 15 May 2022 20:29:32 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g22v17vqs-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 May 2022 20:29:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOZ3NmSPFx47VdHXvlJ0Fsj2dFsswGsnNMTCDlH4o84qN9J77GgBPcEJJeLAdlAsLTbgBGsWVzlKyEuxTYJoyhInCbsexrYfQQcbiwcELig/gWMpJh5+oNZSCCn2JIo0hmaPXOQNUvwlnntcRZKNY8l8uZMwth69LUt06uBxyoXIlGqtem1fg9J+Je0at8pPRn9Txeh9Yq1aaQHtWHA9zDxruyh1/TndcgltcSf4CJbKl2REKOmoX1NtM01P2fFueyoMK+wr9kNRIurfnZow/UDDC9Km0Nv8ltQnaigU+cpHxTle+z70liQEz+0Se3bh5Qv7M/OjH4rB9wZfXgXRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkcNJkhbT4vcG8h2b6sGX3mOBTa1dMHVJKmvMCxLY04=;
 b=nFA6CGV6Z6//Gdyd7dx5b9I18O6iTbJVpnlUqyRlQoexUWPq8FDOiDzH9XgcVt9i4+Q39nSMOaKIWEBh6Co+b4fx2Cv0WxQjl0MV2O4Q7rCUjvaGK2ukLgwDdj0Ocsx/dayQPCeRb/AAAbE2wMWS4DI+8fcIIlW2DiV3gEn60wF8QWDbz69CjkkRr5ALR+3/eswljeI7bmZzG26x8WYhitXFwnbMQqzHqymTU0sLxg+69AaVq0hH0y8h+3a/qBVGzi590iNy94A2gSsDK3LS88CeivxXrbJ2UACwMnzzY+J4OmhyqkewaDJuCV8OyZX2bdzovowgJtUuDq+fzJSzdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkcNJkhbT4vcG8h2b6sGX3mOBTa1dMHVJKmvMCxLY04=;
 b=e9K0LpXubRDHadH7o7Qxi/QmoqzvXVD+52JaJ8lCoo6qlFuizH93RaMehykmpmEGR0RxsnhWyg2H4twNOJq5CgoYJqxAwj7ujvbcTIjtazvFRGmL8rHxW9sV+qnFFyfoRKf9B6oTs43XI2JHQF8dvxAoQ4hS3xgmNHeWS8MtjaI=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 BN7PR10MB2707.namprd10.prod.outlook.com (2603:10b6:406:c9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Sun, 15 May 2022 20:29:31 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5250.018; Sun, 15 May 2022
 20:29:31 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH V2 3/8] vhost_net: get rid of vhost_net_flush_vq() and extra
 flush calls
Date: Sun, 15 May 2022 15:29:17 -0500
Message-Id: <20220515202922.174066-4-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220515202922.174066-1-michael.christie@oracle.com>
References: <20220515202922.174066-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:8:57::22) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07811b6f-fb16-4048-fba7-08da36b19dd8
X-MS-TrafficTypeDiagnostic: BN7PR10MB2707:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2707CB61C0AD351FA4061E1DF1CC9@BN7PR10MB2707.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9wxaKpQk2T7Dq93YpNql6su4t3RWFdAHVcTG5qY24rxMK//X5dFy6uNOQbbjVZVlSI32lVkc1nVAIiBwRTjKJyKdqHHCojRjCkGZ35fN30LDSNgSNGw81qgaehe+kEvmAJOhbJHx3Vb97Q4vL6uVfpQdghHhXvcrRPXoBILeZOejAucCW+onnzR5h7EP1RPEIsBvQSurffF5Et0sGTQrfwHKb3vlxNWTyKCScXfvyNGHjA74n+u4g0is0sqGtDQonpOGPBWndo47lCFyFpRzX8rCUbJ/0Uu8YihsDdDz48lbe0nJSM8opZJYX32RZbFZ60iWRW+EwzByfg5MHw1HkY3joo4OoX2ddjUdIc9hJWYgIGrw2TxR6rxOe15Lmtoj2mqScAoivdDEW0LP29qnHkTxHTbJR8xT5+Ya/jmxtE1+d73P58FBGM91aA9enLqZm0HkqNBP0DQtn2tNBMsblqA1z2DjXMsA+qAestRHRIkn0/ioHLrSluQdkkyndZRrYZfuxF3xxLz2m4g4WQmXB5L/yJigdDfROj0vSvyrtPzCxo6Qsp0m2sgf3PrvDRb7y0vmq0GU4QdcVtc51oAnt0oNILTJ23PpPR1Bg8RFW5rvw9LBRj0OFdv+Ujb1yeiFrIiDZDaTdAvIzJuQJGgRtyw4Tan4iTQ0lk6v9+5mtqerza0xQcPx1cdgQrm2AKaSGX3BPjf/jG5RUwW5ez9dhHxYvSEqxhuh3v2Y+HaCew8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(1076003)(8676002)(107886003)(38350700002)(8936002)(36756003)(316002)(26005)(6512007)(2616005)(186003)(5660300002)(6506007)(6486002)(2906002)(38100700002)(86362001)(4326008)(6666004)(66946007)(66476007)(52116002)(83380400001)(66556008)(508600001)(26583001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DKRV7taNOcZ4RzLz4qhyT9hEm3KCqiIq8RFeut6I7kKr551I/7rpjNDdtnS1?=
 =?us-ascii?Q?SbGj2dQu7cirgAkdVNzYir9B+/QJX/GzGURMyaHhylTUiampOioManuUEFzK?=
 =?us-ascii?Q?LK/4S9vA8DJyLE5Ze1zsxEAgxRxqzlDjDCgvWLbKLrO1tOwsq8EU1+LxrxEM?=
 =?us-ascii?Q?I5fVGW5FPIKOUWM7RL4uI6ShOHZRoQlWJ6GgSDS7A9JHcV1WrgdM37w1BEGr?=
 =?us-ascii?Q?uv1bzR8wN++MVX80NhwAH8ULgrbxSotPKQMx4LjE4SFtIG+lKC+V5c4UhbHo?=
 =?us-ascii?Q?uhYBUR3KzmmXP5rSL9D23ZG5P25qS/YR0bAFaMlWrVtjLgT0ID7cCepNibZR?=
 =?us-ascii?Q?pNLMjPXk+3m0jH6Bn+njx7/KmXKyg7WGQ/AG2h7aoH9e5esh0iD7idKRw3Qf?=
 =?us-ascii?Q?92+QY0u35sUvxj4oJ+ckEm09ublfBrm95jSHOtDHaSWp84ynHI1JJS9E33wB?=
 =?us-ascii?Q?U5yB76A1QZeAavSC257Nt7M13DDGOC06VSUA1KJvM6XrWchwMH7y4fmiNsL6?=
 =?us-ascii?Q?uJ4z5PAREgU/fiUb16kqntNS6LdZDHHnW8yY9SD9USwsaBdSVdpMIvaGObNb?=
 =?us-ascii?Q?kVHBo5bcMsFDcDorTRFq5B2OsBkj0w26eAOWqiNF5ms16YsRXwVcV+VqOMOw?=
 =?us-ascii?Q?Om57xpiY0ObMSk75mnY+/EaOb9DwUUETupvGCQZtJVAlGIJu1h5PlMoWt6kR?=
 =?us-ascii?Q?J30wNmNyJHlZ8OqevWtZvelzsq146tIgpsN5TQDLcURtEmi6BEqjGvGB96Xn?=
 =?us-ascii?Q?HukAk6AmmiHqpe7I3AFFEnBxYFZKVsC7x2KLvbjBxFxR8CfF9gZSp2c/iWR0?=
 =?us-ascii?Q?NdjfKLRpqXuC6insmZCTyF0V4SPcDmXUs0D05MLpdWlXzCdiju18b9osju58?=
 =?us-ascii?Q?k8TgqgHlqtTCFrqPrAaFL2ibe+x7sZvazETlhXqn3JzutKPMMGNis/uujZqi?=
 =?us-ascii?Q?4dnizkfFnFdtWXsxAlDZNbkS82dTHUbfgLdu1yxUap3GEZ6TOYSCWBQpGkvS?=
 =?us-ascii?Q?f5LFsRb/jzArTyI/c6aMT+qQ/wMAAdObLi8GdP78pULHyPypsmWsR0lI0dXD?=
 =?us-ascii?Q?nB2T25730jpWVDFeZ4zzWcIPOKOI2a1ZXGKA99ZFThnc8Q20cqKnOVmbfmG9?=
 =?us-ascii?Q?rR9ExnQAP00nBH7G6ReH9KMHTRdH5hV2T9c4ur1IKTF35MSWwFE8MHJcmLVv?=
 =?us-ascii?Q?KtMWPlP3AfF2/yM4GLpOD1OAJHJTRrp0oRd9i+CHHA0tryGXR6ghqk0JMg0a?=
 =?us-ascii?Q?dWeDpCWBq7z1oXJ6+K55L6dfM+VrVR50Ygv10v3iMVUWTUj/s9dWn5t3xAUN?=
 =?us-ascii?Q?lnQM94l9xfsioypvTP/YC7ifxGYf32Kv97Ri80p4eXZtjCyNMydaZSZkKqsD?=
 =?us-ascii?Q?c+KloP3KrHhmnfkKhRfqVpc9r4luddYbBvxIC0txsyAkFNm8mp7U3+zxevv3?=
 =?us-ascii?Q?E3VBUZtuUUd6eK0mm8wdVlgfoNOO8Lm1evhsAnUqlpoENFSn4r7AkyVGj8R+?=
 =?us-ascii?Q?HJfSfF4PmFZEq9PMHluImT9RENxep7k0FNZafg2AEXIstH9TxheO7f2Cs/wP?=
 =?us-ascii?Q?UmJ7kCuWCtIaV3OJO4zZH8VfdRpuuJvSQKGdgxN8vbMx0Vzkugb9VWFO5t8T?=
 =?us-ascii?Q?o0O7843lstdqZn40Bom6jiEvYBHJJBhW/ThgMRDmGVwJW7IHSJ1TUGOkDPwS?=
 =?us-ascii?Q?/o1+mTkt1vPl6HSHMWt3lpxSoWr4vemT8j14gUfLxUkbW3Kz/qmGdFc1Xu7E?=
 =?us-ascii?Q?bfU9rP74ZEqo5v9hA0lCqtdLyA1oX0o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07811b6f-fb16-4048-fba7-08da36b19dd8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2022 20:29:31.3419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjaMM9VqGTbcupjo+LTdT9s0pSzXo1wub5+SbWDLF0PU2f9m1rfeST9pfZ3rN7etaqKQblGs4wUD/Niz03UnCoHwNmDBtYk25r+d/dZ8kEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2707
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-05-15_11:2022-05-13,
 2022-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205150120
X-Proofpoint-GUID: 6OcIOxW-9fsHcCIUXb1GGAnjdL183k4g
X-Proofpoint-ORIG-GUID: 6OcIOxW-9fsHcCIUXb1GGAnjdL183k4g
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

From: Andrey Ryabinin <arbn@yandex-team.com>

vhost_net_flush_vq() calls vhost_work_dev_flush() twice passing
vhost_dev pointer obtained via 'n->poll[index].dev' and
'n->vqs[index].vq.poll.dev'. This is actually the same pointer,
initialized in vhost_net_open()/vhost_dev_init()/vhost_poll_init()

Remove vhost_net_flush_vq() and call vhost_work_dev_flush() directly.
Do the flushes only once instead of several flush calls in a row
which seems rather useless.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
[drop vhost_dev forward declaration in vhost.h]
Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/net.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 4e55ad8c942a..047b7b05109a 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1374,16 +1374,9 @@ static void vhost_net_stop(struct vhost_net *n, struct socket **tx_sock,
 	*rx_sock = vhost_net_stop_vq(n, &n->vqs[VHOST_NET_VQ_RX].vq);
 }
 
-static void vhost_net_flush_vq(struct vhost_net *n, int index)
-{
-	vhost_work_dev_flush(n->poll[index].dev);
-	vhost_work_dev_flush(n->vqs[index].vq.poll.dev);
-}
-
 static void vhost_net_flush(struct vhost_net *n)
 {
-	vhost_net_flush_vq(n, VHOST_NET_VQ_TX);
-	vhost_net_flush_vq(n, VHOST_NET_VQ_RX);
+	vhost_work_dev_flush(&n->dev);
 	if (n->vqs[VHOST_NET_VQ_TX].ubufs) {
 		mutex_lock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
 		n->tx_flush = true;
@@ -1573,7 +1566,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 	}
 
 	if (oldsock) {
-		vhost_net_flush_vq(n, index);
+		vhost_work_dev_flush(&n->dev);
 		sockfd_put(oldsock);
 	}
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
