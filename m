Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A15C433F5
	for <virtualization@archiver.kernel.org>; Sat, 15 Jan 2022 01:22:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E5C360BAB;
	Sat, 15 Jan 2022 01:22:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pHpJHo3a2VHS; Sat, 15 Jan 2022 01:22:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5148560BD1;
	Sat, 15 Jan 2022 01:22:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 206DEC002F;
	Sat, 15 Jan 2022 01:22:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AD0EC001E
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Jan 2022 01:22:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5300B82B8C
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Jan 2022 01:22:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="MW5I9M1F";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="id3e0bhR"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hVvEBiSVuKDn
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Jan 2022 01:22:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3CC4582B81
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Jan 2022 01:22:01 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20F0wrEI005704; 
 Sat, 15 Jan 2022 01:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=4NEBU2O/rnEjj9FHeLKs6IXcAmq+I8j03BPGt2now0o=;
 b=MW5I9M1F6kS1kAYH9/at4ihvbJA11E1MPudnwprYjHwbsoZZreJooZqjkXis8fSAc4NS
 iZcShJ8u68am8dEhceYZUcKYSVLrQHjNOzTTLward6a5L/8YCYoPKi5Xm1imf5nUMlgJ
 fQYAkOIC3HvmGxCVMyT4J9UL9QShARNxRGoPF6oao2G0m9tWc3bJ9PV3pxnKso9UlH3S
 RxAcDxeLgLYeD9Ndqbbs1M1fwLcMd64kSuZ2zd4OP4AIOFLkjSToh7qV+rhuSFZldXP5
 rO6uQ8bZooKaEHB2RxixQs2FCaVnz9jeTn3V3T7XOJh48iKUfZdwynIXQJiqlQxw3ZrS 0A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3djjm0mxav-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 15 Jan 2022 01:21:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20F16JRP073234;
 Sat, 15 Jan 2022 01:21:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
 by userp3030.oracle.com with ESMTP id 3dkkcsjsqt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 15 Jan 2022 01:21:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kg7PnAl2kr9vuFM6/+hivzxDHXIFovyjQc4jsC4WwCmC+MKISSlcGMrlniWkR4gx/80asm0E2aPXTQ7ImIM6Ma7Z/C+HJ5Vxh2MGyejYJNYkh4fXLu0UIpIOzNatNZtCNR6bmFu3oh4ExZazsR+vS/yUo+WdBr8c50BZnZkUPeMiK+TPrCME5T/JDf0KOQA2u1Amklw05Sva/k2a+Qanxs7W7LpydhNr2GkbkojqWNQGYDLKKyxIYt4O2duZG94f+WjgS6uKzwwAlXl7zz/CzQkF1F9rBZuDLh9UdHRhcW7y1mVAWv4QjvktPsluDSV4s8uLyUG5wXyzSTEx0vRveA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NEBU2O/rnEjj9FHeLKs6IXcAmq+I8j03BPGt2now0o=;
 b=Zs/oNWC4tN60MyjFr6jv76QnoY6BuGmalD/RmYYhs50YbqQ9BQe01R7weP7V/zkgh3150d0fjyY+i285D/MrnE2KvlzIo0jxcXJEBpU9sHl3XNI31PA+Wqyq4JUpdEBnOrYOteo+rFoBinR0q1fvwZXnPLnJ4Iq5mwn4qfID+IURAu4CxMvK/+e9qjzzzRmiqxdEUadOmzE8q/97KEHL8ngOKOwkTgHK3m/J5ToCla9dzX5vwPUYLY5+cbni5HFmNGojIfczXeiW1EO0Ag9jsf0rSWRjf2MqVe5fTWST3tf51HuhVTj+BDtHeYWO6lTQF7s5YnFh6OFOwenBliI7gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NEBU2O/rnEjj9FHeLKs6IXcAmq+I8j03BPGt2now0o=;
 b=id3e0bhRSAxcIF1R57C3r+G2df+k2X5AdwmIs3UsWJrzbbUjwSempoNfr3pW9dcPfRmlBwZjHjFGDdqBkZ48ygeRinZRStF5LFTdOkvV+KItgwagotzOn2Ce5zRZX5z2YpNFZEPEJPeGE4VP5Vf7wbZQHxDZl8hMA/r5O0Zo6+4=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by DS7PR10MB5182.namprd10.prod.outlook.com (2603:10b6:5:38f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Sat, 15 Jan
 2022 01:21:56 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%6]) with mapi id 15.20.4888.012; Sat, 15 Jan 2022
 01:21:56 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: elic@nvidia.com, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH v2 0/3] fixes for mlx5_vdpa multiqueue support
Date: Fri, 14 Jan 2022 19:27:58 -0500
Message-Id: <1642206481-30721-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-ClientProxiedBy: BY5PR17CA0071.namprd17.prod.outlook.com
 (2603:10b6:a03:167::48) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5b4fe23-0d17-4a3f-06eb-08d9d7c56b3a
X-MS-TrafficTypeDiagnostic: DS7PR10MB5182:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB51825684190DC31654132927B1559@DS7PR10MB5182.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUMU+zEwjGUMWC+Jz48b182s/9UK0kiT87/HYb35Rn/vLY3ioeVzfs9d5hpHun0XlR5Uk/1aVkt6SGSMwJVJCZ5BfBUHJ1FchPUXrc1Tp4jnwG2Zu7vmx+mErPpK/KdQJIEX3xioz/ugq2U24WtQyhMrgPzVGXdO56/TmApO68og6TIvE4zjrnmB2u+NKxnDRyFPv+6pHS84V7gmtXnmTGqrHB8upngyoTr1gtj793LEAHhkCcEM2yy2w6CgpfKiE5ZE9me+z/WUtRGuUFQ0NJCNvBKMqO5DoJm6Ralyq7/8YqaFJ60cOzBY5kle1DJQYTFPvwyEPv1NiOLGtEDScyWVtXkElxhx0NC36lMlp2OASxLVzSKvk02IlByks2V3OiSI1YXwDHnDF9PtIjwyybRaslmqDAvrB2Coeluk0+tDqN8tviTOb/RxppVnCvWuHAeMKeTbNrE2LNiMCd0xQ4uHQbR+3IWCpWmAlv9nYzfoWGrcuA6Oylt3HIgUDJkBda5BVXXl/CtxIwmgUb8BMdvzFmIJyI5RTSz4m7sbviz9yliq8FlKE8CQWTGuf6sc4TUCVXEsRx4ppFbmjCe9etZfvTid4hJ6TJkXFRHUqDqDU173yotfvs+Kve6KsM1ULv/ESBLxkNaTMeGr7EbAgzIaaeRZNx9bSE5liFV2VWMcKYVH0mA5ZEfgeZSbClEwTTFFxq3In9Vamkbs3GjZ2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(6512007)(4326008)(6486002)(66946007)(38350700002)(83380400001)(66556008)(5660300002)(107886003)(8676002)(66476007)(186003)(6506007)(36756003)(86362001)(508600001)(2906002)(26005)(8936002)(38100700002)(52116002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mtVcKvxdxpwPpe6ihrH3r1bGm14GbaYitGl9Z234fjluZlk8llzTApkPOGFs?=
 =?us-ascii?Q?0s6iAkdn/3JbJ+fC6Qgtz+lcZhlFqrgD7PocDc7IqP8EVh80hiWM0+rsR2uK?=
 =?us-ascii?Q?iW+0mIsV5yLeEGhjb2qriMrADTl3L40WHsGSN3tlbRFg6q1hsfhvNGuV4/nK?=
 =?us-ascii?Q?v9+0N6q/oCrLLcgM9UbM4P6xcgnrclQNSXxxZmk6iTBmDol44bAnaTrCKl8U?=
 =?us-ascii?Q?TzbP99hE/g3k2LWBEkHupVTecDgx/v65Do5X2nTfNzUZqBRdnrzqTlmH7eB/?=
 =?us-ascii?Q?5hPrbSCvcoqJhcGFkJCCyVc838stoXLbKGGsWPkiNrMtjZ7vbWDnKrebCmpD?=
 =?us-ascii?Q?9lqErevhj+hjdr0lhkfMsmnybvoYSKuDp2OJH3eOUgMXncZ8wxCeXLZ60FZi?=
 =?us-ascii?Q?WUAJRPrmx/udoQaryND/ArY3aJXuCe8+OkBRntFSHu2Rt1BiNifWsKK2kuK7?=
 =?us-ascii?Q?JN1qxx1qE/l8lAoYt0of+h/1ttyJcdurLBHjogcdJJcIarUbLkPPYmkQouRS?=
 =?us-ascii?Q?gYhQAV+P5TWts6qFoy3QBF+qiGGobdjbOIUylD4qFeW95Ta1+2Ngj1+T76mP?=
 =?us-ascii?Q?AHpGwLHqv/hjUpjc33WzIwD/kOAkLizsAPkXVWXuVtNNyyp+M7KChrblcsH1?=
 =?us-ascii?Q?tYB+UJP0D8El0/LadXtMHctz57GV5eco4HwoMtL3R6y9e1ieneFxTf+uWOJ5?=
 =?us-ascii?Q?WrVlzopfRfNV4caae5GmRIHZ6BXia4wv1cBuFAoy/XWb1Zlyv37o4+Ywr6DL?=
 =?us-ascii?Q?3hCqI7pdEHVPsxVxODKM++BU+L6BvM13Snfob+PMWfoHXz9hjDKZR/Q63iF/?=
 =?us-ascii?Q?/FwR21B8H62XxKXW8PLPREVjvzc4ZAw6Rk3VURJ5itmj3o+IJfOtKkZ7AGYF?=
 =?us-ascii?Q?0vZES9H9iVCoR5ddV+CV/kc6qncarNcawwYwdXKYnX8pDO/e5GB7i6SggVrc?=
 =?us-ascii?Q?IEjruyEfsZEW4GtD7WkBYf7qAedTPXLgRv6BFS5ui7yJYdyanVb2KduErSSc?=
 =?us-ascii?Q?nvqYPRq2ImopK7OpFSVWPBj/N512S5Q/rB1Qhtv2nBmOzPLAF1mLSN4rwRRr?=
 =?us-ascii?Q?ZHz8EnEOd0PRWydZimCmbsvNLzva6JjosqZenDUJv6NTgZ39DuZwMMjPUv1n?=
 =?us-ascii?Q?k3Go6M+4OkC4cDsElkMvgEZmLZnq+/g0jGumkeVyO5g0IIrl+gvO7aFU9hih?=
 =?us-ascii?Q?oV0cSUQVaacLpxzhkcpfxRJWHTYa0CIXn6sbCONjeMQDvwzBbQ1ntoCqOmCb?=
 =?us-ascii?Q?ahyPyZHx+FmGDxdNqB2CDRq9NFstV+7hPsuvL5YYxUfD4HBF7zzgZZaY+km9?=
 =?us-ascii?Q?bNiH4jX0kOjNQFgqrg0noUGWWCDW31BaZXQa7AlzCy+t0gPzJML4ExuD3vVx?=
 =?us-ascii?Q?+Meu8Hi0QHVeg2ZxW9N56k55U9JffnMJZdYzSqslPI5eNKfPMqNGShjrR98/?=
 =?us-ascii?Q?yhgIlaXVKBSkzZQ4pNP4/0QVgW8zw/ihDTB5NBxGTL70V88fQxIxJ0pWYFin?=
 =?us-ascii?Q?t7FIvsR7fw0zMAgTP7HJEPi3PpqrTolDerEulgMEqEu22PiM+mO5G/jCLmCi?=
 =?us-ascii?Q?1bHNUpnwdMgyrSj1WomUZ2sXjV/VgY9Z6M73WQ+V86CtVo1LkSfI/wu2LQqu?=
 =?us-ascii?Q?VP9k+MpMKS7oqXAEGB5agMk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b4fe23-0d17-4a3f-06eb-08d9d7c56b3a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2022 01:21:56.0411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJnjKBiB9apqqCLdZvqPI1Ek6IYIpV3qeJYuRetbrObPvRJhy67oP+nRn+mSoIph5ouJcAzhiC2sq4S+eqo/oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5182
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10227
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201150003
X-Proofpoint-GUID: Su5LzKdyV4CmqyKoC7BN-_1Ugq6ualuy
X-Proofpoint-ORIG-GUID: Su5LzKdyV4CmqyKoC7BN-_1Ugq6ualuy
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

This patchset contains the fixes and code cleanups for a couple issues
uncovered during the review for the "Allow for configuring max number
of virtqueue pairs" series.

It is based on Eli's fixes:
2e4cda633a22 ("vdpa/mlx5: Fix tracking of current number of VQs")
in the vhost tree.

--
v1 -> v2:
  - removed unneeded Fixes tag to avoid confusion
  - failing the set_features op instead of clearing invalid feature
  - add motivation to the commit log
  - fix or add code comments in place per review feedback
  - re-align the subject in some patches to better reflect the actual
    code change
  - fixed corrupted email address format in SoB

Si-Wei Liu (3):
  vdpa: factor out vdpa_set_features_unlocked for vdpa internal use
  vdpa/mlx5: should verify CTRL_VQ feature exists for MQ
  vdpa/mlx5: add validation for VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 34 ++++++++++++++++++++++++++++++++--
 drivers/vdpa/vdpa.c               |  2 +-
 drivers/vhost/vdpa.c              |  2 +-
 drivers/virtio/virtio_vdpa.c      |  2 +-
 include/linux/vdpa.h              | 18 ++++++++++++------
 5 files changed, 47 insertions(+), 11 deletions(-)

-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
