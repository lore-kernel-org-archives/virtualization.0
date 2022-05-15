Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28013C4332F
	for <virtualization@archiver.kernel.org>; Sun, 15 May 2022 20:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6B20823CB;
	Sun, 15 May 2022 20:29:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Vdt1ai_KEk9; Sun, 15 May 2022 20:29:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 788EB8239A;
	Sun, 15 May 2022 20:29:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C622C008A;
	Sun, 15 May 2022 20:29:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AB84C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 69FC240408
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="LLFuRhto";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="DU52guRT"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dbe98_422qkS
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 990D9404AF
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:41 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24FE9viE014217;
 Sun, 15 May 2022 20:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=IdAYy1OUkWXx/y4Iq8m0DbB71pegIQ2lho9GHl/dPnc=;
 b=LLFuRhto5QminnyOtw2goiwRtrsHrdHL03MhosY4fQMSUQGG8iHXf2swVghwUI/gSpBz
 MgSDi8CXiakKxQYkJfKOhOUt/3MTE6eH6J2QOo5hW+tbScL6LlbPjELB1/N1cLmM2gUd
 CVsG6hAzRyHvclOkAKH1BZmvL4lQeMsShplVEY+dx1a/A3drH9Wvm9WjqDyNl6RNs/lN
 YWJthJLfVKqvaeeEINqf0Y276gX5DoVbeu8a6qlsr/lOTu3VnUoHaJKaXc67ey2nClqQ
 D/IfWR1SP4wb9Re5F0gmIUwB0nNWXBUlr1J3gS9tOEm1FlBKTniesN54/Q5xP4miDigb oQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2371suyt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 May 2022 20:29:40 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24FKPP2L007035; Sun, 15 May 2022 20:29:39 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g22v0ycf9-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 May 2022 20:29:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqFSGIVN1V7AqApSmdNZ3GF5LQwePGF4RiiIzll+Db43UtVQ0pAlzDPg215c/7Vh8oAE1KZstrIJJ4ixKGYuZ1nokZFY79mvMm4+1FuacwKyIzkcrLZZbIHuhH66EpBimFhflRzeVKQq950CZiNBfHGgfphXYtwgaHhTxb7bXe4rBduZR4uEGopoyf431M8xNTWUsbGS35N13LgI779j6phPdj8Bzdc+oFkVEBu9xrTW14Lzdg6O6XRRix7zoqkviIx5X2elvotqGVxnMEOjUjtZ2ExeVkWWEoMcdpP/Lg+OeFjo7SQjOYlEV/5mS8Dr+bATm1flQcC1YIGvJqmFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdAYy1OUkWXx/y4Iq8m0DbB71pegIQ2lho9GHl/dPnc=;
 b=g3Fgp71mIBCUDuCtWWX+UyhE0zxJrJELWj9aThJUVJaWnua8nJDrqsrL0gYKoGQ3EpChW9anrJd7kxPOz8d3JTI9pwNfw+xd3v3rJ5HaOlGf7nEoQNQJT2Ap3WkdgBSm7uulAHlrh4G8eEJxe7qYMgLkyROHWmYpeJIT3jPinCmf/V7swPAqNCkMXt3tpU2zykCaKUfWBVXzwoeBFOe+Fs7/AX0s7YQyryDBA+02xjd9/EK385gXCcpxg8BJTCxnU/1h2XbnFqSb68VvH/ISOg/FfX5mJ9DVqG61ANaU/ZQsamafj4PtuuCv2XhPTXJdFUqKEe22bAKBhCIalE9UGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdAYy1OUkWXx/y4Iq8m0DbB71pegIQ2lho9GHl/dPnc=;
 b=DU52guRTgTjxuXx8zSsKMo6Weqvttk8768aHjHkA8pLcSUcW+8a/W3sew5avxHUtaPw/I0tNdcEEiaI1tEmaTGB9ZOfQBj0YQr077Cnb8Ff7fyrUD2Yq7wA9yc0hN/b7wQzZ1nULUlu1sBCM+0u2STc+2k9cbwx75uihW9jzggg=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 BN7PR10MB2707.namprd10.prod.outlook.com (2603:10b6:406:c9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Sun, 15 May 2022 20:29:34 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5250.018; Sun, 15 May 2022
 20:29:34 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH V2 8/8] vhost: rename vhost_work_dev_flush
Date: Sun, 15 May 2022 15:29:22 -0500
Message-Id: <20220515202922.174066-9-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220515202922.174066-1-michael.christie@oracle.com>
References: <20220515202922.174066-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:8:57::22) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b01b8f1e-d5d4-41cb-598c-08da36b19f43
X-MS-TrafficTypeDiagnostic: BN7PR10MB2707:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2707670F1EAE19A1CE0F31D8F1CC9@BN7PR10MB2707.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +geePB/2aLJdpUL2/96PjIS+NfuqH7unMUj3PqEDxo9kMGDU4QUwaH6V+b8RyHffw4pceSScV+PIhS17k9oUzCnDCc71WPzMiDgCYi+C4kvuUjo/aNyZ9Os0zd7aKrJ0Fd34NjJTPpstDJO6dtLZvX5MyzPbwxP0Avzm6UcVxOwNsHjxlS5jmZcw+mDSAOciKwQSWp+AXlCIw71FkMMVFKlSw5G/jf0zwHuy0PZ6TsCuaGT0W0Jj++qx/LjBu2V9ftvJOW6fOsZmdArbdxv7aBMEFvtIkD+eCjL900VCiy5VTfa2/KBMQKXOArHzvS3OFFqaHhOuQBiHMTrc0YkAXg/VO+014p4Yzxyiap8/n0xXUmiZES4gSwKwTUfKDBFX7GWgnkwnnLrH7GYRdUbqRuz2Q1fZEtoGuFsXct2XMtIaiXeWo0VyU2CvIs+CgEqti6GOw0x0xb1vmbX6krH6G16xVPALDNf4zr/D2YsliOlZbJKr1ya8F++q/8Mxw1//VQenGwneNrrPpDJkL4qrpH5lsy05ost/4MfuAKlwwvyyzhyxvUx4NKP0yFiS29NfmesW5A66IlKaH3lFE/6JWuY0G48lHJq38ME74qUbECaL0P8weDnl45RraClmdOJrXm/NsuEVM7nJ/X2rEqDlXjPxDn4tZm2tiWkD6KxASqcDDpHhBjbbdPe+FDy/gCe2/L2NFLhbMQ4PP28JRZZW2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(1076003)(8676002)(107886003)(38350700002)(8936002)(36756003)(316002)(26005)(6512007)(2616005)(186003)(5660300002)(6506007)(6486002)(2906002)(38100700002)(86362001)(4326008)(6666004)(66946007)(66476007)(52116002)(83380400001)(66556008)(508600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/NiQfo6AJOPMBgdo+CLnxVJgs+rnfPgpwZYzp1TRV2tsbBCOhJpCX8orqUn7?=
 =?us-ascii?Q?TlW/UDiNcjae7FN6M87peSGcUwDK1sncYkaepDQfOPlRR+YCe+K4suhz18Tu?=
 =?us-ascii?Q?03Sn9wkmKT1K967ykU+YlJxt6iyVg+dsMKbltGvSi8Dqn4zj7/Yj2BDm6BLB?=
 =?us-ascii?Q?3P90b2XYSlkg15NEqZ4H/eNBDo6B4S9DALIhowSw50cGVtuf7u2i2EWo1DkT?=
 =?us-ascii?Q?J9LkaDQaNflYhUyrs+/RecW2qwWzTGgJW9R11HGbr9RS7tU7zOiY07YNaamG?=
 =?us-ascii?Q?vb7T5A67z2CtbotxURomnJarVJ2GzNFTJQDIJPqL8Y+3D3S2XpU/ZrNxSYn/?=
 =?us-ascii?Q?AdjsZnIOHZZUAVO5TsLnHXPsJ1oyUXvZypzfu2QZPNO//x/8wIGl7SGya6W6?=
 =?us-ascii?Q?/3DBofO1oN78k7G6Zk93A10PL+bK3llOeM2deLBNt4lmo7SGw0m061S7wJqE?=
 =?us-ascii?Q?v1vi+jC/LrEp6G0JOd0pVq6GWvH1fxGgtzxxGWLad2TQdCiFpoFTZHqsbBce?=
 =?us-ascii?Q?/wOx8/aMmXXHDBSW/71+X+CkjNDbyWAWWGD2AZCQZfx3l2xQR5Ynn/S4AWAP?=
 =?us-ascii?Q?k9UF9CnyjPfPbYP8KDejwBN6l4I59RxZS6PNnSfHaOolTWy4tF5lmCYcgdPb?=
 =?us-ascii?Q?zjzaRYGJ0VKCKeADTKw8yC1YVJo2Et62MmpUB/cDjTpwzZsswsNCnVqurHBm?=
 =?us-ascii?Q?ARTuq5ZDXcjNKvgSHnY6xOnnqEppb6iDE4Vu+OMDJqudELdswSE2dcxNEiOd?=
 =?us-ascii?Q?REvyBN5hRVw7LVGsMd56r7geFDr/nBEuU1CIvqWglyMnRZAaIE7N9Zz33zGQ?=
 =?us-ascii?Q?DuH3426NH0WLewmHOTQEhEORwReDgR3GqgUXOXDSToU9Dg4aXnAX0VChO3uV?=
 =?us-ascii?Q?VrHbxoCCp0eLYXpCosDcs/ERQ0vLqZaTefK3iU3+Bp03fL9KyIjwDcjCNkPv?=
 =?us-ascii?Q?481yrivMyvuCvJjUMFLwBTYReHY4MAKTqGzX60gEtgEqdI0Mp/TJyz6lNvnq?=
 =?us-ascii?Q?fX5ezFEybtEIyHrOlARHnDA/UeCrg1+ibkTf9GvCrZcJytV+FG3Tsenxmdk5?=
 =?us-ascii?Q?4PT9InRo9DNZ6z8ArE14DvVjHTb+bn92yaSohkbATIX0aJv+Y2C82iIrvmN1?=
 =?us-ascii?Q?cgKSz9r071fe4e62CnQEjcd/KAo+LpO+/zjsiqShVHssjpifSpGHK5LwjoR5?=
 =?us-ascii?Q?Qxe/TbxhejbyW9yzFBjwg3jrnPYVupk3L4nC3ngKV4gL9FcSVLxmq5ycqB9c?=
 =?us-ascii?Q?xfAJoXsuXMQqDOESHVOLC5FW6EmTPrzrwnNIJlXGSItJc+XYpLtCbWSYKWxt?=
 =?us-ascii?Q?d+EypXNd9sVE0SvVqQnunCz+fPsj4ZuBhpOKqsCd2gzwbW5wZIjzygP/yavB?=
 =?us-ascii?Q?U80T+8H7ThcPedLfdFAA9+DSJzU5Y60mYGyg5zu+550JPnlwa2+OgbImI0Ex?=
 =?us-ascii?Q?VSGRWnbdDGQ61t+yF6kZ9Y0Vh+x64MAA1k3MLX9czQ6Au4NHhObnI7cbO1KA?=
 =?us-ascii?Q?A53fuRH7U/+dFehaUTpsIUbdSFtm9JcZfnDsI7U0jShia9O0oWPEXMe9xXsJ?=
 =?us-ascii?Q?S+2W8V2BytYblHFDBqnjatTkLYhkbUdD1w0nS3oNRwfXlBnRheQQbFVaVlHy?=
 =?us-ascii?Q?rO5kXKESBx3GhP2H/WyzAKzmuy44TKo8/r/gQIj1odKvQ5BnqGr7IVVpRvta?=
 =?us-ascii?Q?XHyNc7jOabGrG7ClIlKCaKT4eKJw3Q9W2acEpN8PAxsJ95KoIjN9VDzvdbKe?=
 =?us-ascii?Q?BBdao+Lcnc9hCjv8wgGo45+60peLCwY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01b8f1e-d5d4-41cb-598c-08da36b19f43
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2022 20:29:33.7167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgvZWdy2OVHp7JLP2NPWKHzt70LJy8DwOh1gUJazPICSPiN/1LL6hspjF8LpHcMmjK/j8eIB/WFor7WIy7YOryITN8x1K2slXYfigrew+EM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2707
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-05-15_11:2022-05-13,
 2022-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205150120
X-Proofpoint-GUID: kMnO97el9OI59QbXXeItN80aNbTcjDIU
X-Proofpoint-ORIG-GUID: kMnO97el9OI59QbXXeItN80aNbTcjDIU
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

This patch renames vhost_work_dev_flush to just vhost_dev_flush to
relfect that it flushes everything on the device and that drivers
don't know/care that polls are based on vhost_works. Drivers just
flush the entire device and polls, and works for vhost-scsi
management TMFs and IO net virtqueues, etc all are flushed.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/net.c   |  4 ++--
 drivers/vhost/scsi.c  |  2 +-
 drivers/vhost/test.c  |  2 +-
 drivers/vhost/vhost.c | 10 +++++-----
 drivers/vhost/vhost.h |  2 +-
 drivers/vhost/vsock.c |  2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 047b7b05109a..0e4ff6a08f5f 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1376,7 +1376,7 @@ static void vhost_net_stop(struct vhost_net *n, struct socket **tx_sock,
 
 static void vhost_net_flush(struct vhost_net *n)
 {
-	vhost_work_dev_flush(&n->dev);
+	vhost_dev_flush(&n->dev);
 	if (n->vqs[VHOST_NET_VQ_TX].ubufs) {
 		mutex_lock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
 		n->tx_flush = true;
@@ -1566,7 +1566,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 	}
 
 	if (oldsock) {
-		vhost_work_dev_flush(&n->dev);
+		vhost_dev_flush(&n->dev);
 		sockfd_put(oldsock);
 	}
 
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 94535c813ef7..ffd9e6c2ffc1 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1436,7 +1436,7 @@ static void vhost_scsi_flush(struct vhost_scsi *vs)
 		kref_put(&old_inflight[i]->kref, vhost_scsi_done_inflight);
 
 	/* Flush both the vhost poll and vhost work */
-	vhost_work_dev_flush(&vs->dev);
+	vhost_dev_flush(&vs->dev);
 
 	/* Wait for all reqs issued before the flush to be finished */
 	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++)
diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index a63a626a554e..87498c1109fe 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -146,7 +146,7 @@ static void vhost_test_stop(struct vhost_test *n, void **privatep)
 
 static void vhost_test_flush(struct vhost_test *n)
 {
-	vhost_work_dev_flush(&n->dev);
+	vhost_dev_flush(&n->dev);
 }
 
 static int vhost_test_release(struct inode *inode, struct file *f)
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 9f8de04bb673..716a80c61fa9 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -231,7 +231,7 @@ void vhost_poll_stop(struct vhost_poll *poll)
 }
 EXPORT_SYMBOL_GPL(vhost_poll_stop);
 
-void vhost_work_dev_flush(struct vhost_dev *dev)
+void vhost_dev_flush(struct vhost_dev *dev)
 {
 	struct vhost_flush_struct flush;
 
@@ -243,7 +243,7 @@ void vhost_work_dev_flush(struct vhost_dev *dev)
 		wait_for_completion(&flush.wait_event);
 	}
 }
-EXPORT_SYMBOL_GPL(vhost_work_dev_flush);
+EXPORT_SYMBOL_GPL(vhost_dev_flush);
 
 void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 {
@@ -530,7 +530,7 @@ static int vhost_attach_cgroups(struct vhost_dev *dev)
 	attach.owner = current;
 	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
 	vhost_work_queue(dev, &attach.work);
-	vhost_work_dev_flush(dev);
+	vhost_dev_flush(dev);
 	return attach.ret;
 }
 
@@ -657,7 +657,7 @@ void vhost_dev_stop(struct vhost_dev *dev)
 			vhost_poll_stop(&dev->vqs[i]->poll);
 	}
 
-	vhost_work_dev_flush(dev);
+	vhost_dev_flush(dev);
 }
 EXPORT_SYMBOL_GPL(vhost_dev_stop);
 
@@ -1711,7 +1711,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 	mutex_unlock(&vq->mutex);
 
 	if (pollstop && vq->handle_kick)
-		vhost_work_dev_flush(vq->poll.dev);
+		vhost_dev_flush(vq->poll.dev);
 	return r;
 }
 EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index aeb8e1ad1496..d02adf1b2bf8 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -45,7 +45,7 @@ void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
 int vhost_poll_start(struct vhost_poll *poll, struct file *file);
 void vhost_poll_stop(struct vhost_poll *poll);
 void vhost_poll_queue(struct vhost_poll *poll);
-void vhost_work_dev_flush(struct vhost_dev *dev);
+void vhost_dev_flush(struct vhost_dev *dev);
 
 struct vhost_log {
 	u64 addr;
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 96be63697117..368330417bde 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -705,7 +705,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 
 static void vhost_vsock_flush(struct vhost_vsock *vsock)
 {
-	vhost_work_dev_flush(&vsock->dev);
+	vhost_dev_flush(&vsock->dev);
 }
 
 static void vhost_vsock_reset_orphans(struct sock *sk)
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
