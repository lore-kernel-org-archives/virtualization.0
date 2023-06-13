Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB88C7EE43
	for <virtualization@archiver.kernel.org>; Tue, 13 Jun 2023 01:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 52C0140BE3;
	Tue, 13 Jun 2023 01:33:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 52C0140BE3
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=Vg5UFhpz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=a7bbwyH2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5jljd9CYM_2X; Tue, 13 Jun 2023 01:33:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A336E40B46;
	Tue, 13 Jun 2023 01:33:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A336E40B46
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AE2FC008E;
	Tue, 13 Jun 2023 01:33:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0F68C0093
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BB4DF408B4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BB4DF408B4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S4rewjU39q2V
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D5E4B40597
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D5E4B40597
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:19 +0000 (UTC)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35CKO28I029142; Tue, 13 Jun 2023 01:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=nRQymEhW3oVAKibPF8OzS+m/SDG1dSGooz4251rY7B8=;
 b=Vg5UFhpzL0Q8DdQzYwEDIWR93qeRAoc39r2x2z8LXz4Q07cp6IZNWkjWMoUK5zqJQXz4
 JNwoRBmp/Ql0JtfHxr+7B8lFeLiXL3w1hA+dQ+bv8/JyRXmUUktA5XtG8Jx8mln3STCu
 SCVXD3IfkmHNI+OlBuntEU5aSMxvQeYR5IrKb7MwH5nmL2yspXMRVwB0LQpofIWixG5t
 pY14zpi7JBZSKaaWUXPhPZRkvyaQuV9llKVKC4LSc30hOaAagJVWFli6WbMboet7xplU
 ySzLONrg2bmeCbqjeCQn4AmI1GAr+1jm7w+IOMWNutrxmjPixVbcJYcAs9/ZvIzmJhcy tw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4g3bm83h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:18 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35D16qfm016231; Tue, 13 Jun 2023 01:33:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm3hhyq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYIJgkwq2Ihl4CQ3ToRGnCLu4NnJhMU/XkxQdZQi31iVp7kVfWtcOGPu3NOYZTlBN/J9XItO2++UiCv/7xttaOTAO9m89GiuxGZCBOtclVvcnJOFcaRW5Raqa/ZYZBbH0QVjV2Mx8zE202z+jgrbzWfMD6RVLwjhsTEEIO51TqGKVbKLUUm2SxZ5lQBENVlvSbB+nBRvT2k6ieMxiszWayFswCvObLTOElm173V0/licTj2ndIzqGXdajEwfYut5r0WbI24ubQ127huH1uIFF/AwA13DoiAeWB2XkDw0lve57hFLOorDncitDP0Dr2M76JMVpKV64zJe986v7kjPIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRQymEhW3oVAKibPF8OzS+m/SDG1dSGooz4251rY7B8=;
 b=dKJ5c4/Az+TjJ7981qmCS8OX+qqkmP0kfDrUtrdPTRgWV7xzzaAqHhG+wP/4VmYJneBtCFxWLIhFwqsoIpni6UshI4ke6FJbdTnrXalhcTCif7/yko0wDjyt84QyrjqSE3miOx9mvDGWB46s7Tj823PIMka7a2SL4GJQ7ff/oKvLniWP/t0Vxv4a8LsEPJ0K0f20DPicz8FcNUO/BOpvbx/h8oPGnWupzd5qfv0cEj8GAgeHfxJab0HJ3hcoWk9cTshDPwt2z7ZaJaC+eWR6DK9qddB8c8LOQX52YYMvP/0z4sAu/GpnMCYVZY5uhJSf7IZm8uyMaAomUGhsjYKZVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRQymEhW3oVAKibPF8OzS+m/SDG1dSGooz4251rY7B8=;
 b=a7bbwyH2uHSWrAD7RDA3/2zvC90Ttz73Uv9jQFX0k5ZQTqWc0OO19oObuN/cloKeqH+UZabsNS3n4JKPezLU8oEIQpc07YzNxu99e077e5n/SYH3b/9ODnaJwUWi9rMaUo/W4CfP/j5bfiuWmFS/9S3y0Kxzs0IxHbpcEoTVZKA=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SA2PR10MB4507.namprd10.prod.outlook.com (2603:10b6:806:119::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 01:32:51 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 01:32:51 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v8 00/17] vhost: multiple worker support
Date: Mon, 12 Jun 2023 20:32:31 -0500
Message-Id: <20230613013248.12196-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: DM6PR06CA0084.namprd06.prod.outlook.com
 (2603:10b6:5:336::17) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SA2PR10MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: 6834872f-d79e-4408-ad31-08db6bae1a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T3xDU2NqylLTW6QowJIB7qxcAuXB4FqB3XjoO5btY2Ks9+5tn50v+yywGp1O8D5RSbwlgzDWcCcp7zKUkPDveB93ergg0rkHgCQr2PzdQO0TtKau9ICEYP/zzEM9q7/Q9zB86d37D8QOZ/YPYAeHcwNTvyZvRCrBv3xiHlAjWkZk6Dhf2maljTMaOq1nnTGiSXjrw++FNkxrNp92maznmsR6UkDxOHv6gdNotmLETjH26J7GT7JiBpSTbuJHQK0bBwv7ux25hmVMRJLXcGO2gjEpJDpAHGy2r0teua4SVnwEpCMP4rYtFd2Ex4pJ8fDZ+Nqba1oYMB+k/N2UueGr2+JgNW3ZGIbUMG74cdBUa1ULXMh6zoKrKDJxmgZkifneVvwkX6n7/vk552VQrjIxedOMfEzo1IqRb0CBY8UZwmm2prXfc+fmPKNOQD6t5b75jU8c2w7rUyjvJAhIXRj+S1Do8kt78qNn/uY7CyB+Lw/0l3wfEuUgbuj0rsgP0q7p1L7uL0q9ir/cNQVSUfDr6AokyECwF1YvDsdLjChBZP9lOQhfM5J1S5dsOXPijxwk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(36756003)(86362001)(66556008)(478600001)(66476007)(66946007)(6666004)(316002)(6486002)(8936002)(5660300002)(2906002)(8676002)(41300700001)(38100700002)(2616005)(6512007)(6506007)(1076003)(26005)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lfLBW032UhXjRTIT+aYWXFwkFR4JGqmTxjchvlr2FPePq6Eddlh+RkV89JJA?=
 =?us-ascii?Q?UqEClED7lYg1HQdEWNkDACUB1mWwOfe9ndMh6vomvEpAj9/kZ/OrwXSaYlTM?=
 =?us-ascii?Q?/CfG1wThUtYsfz4zS4NLUXlkyxFWxSLS7zxIpBDJV8qt84H3QAUJZSXxOOPs?=
 =?us-ascii?Q?YO9t6iFLgkqx64quIEku9z1ypEuDam45sJAV56V+MLW/xaqtNMNipTYIo9+a?=
 =?us-ascii?Q?zLDPA6z92jcIbg9yCzcv9eHDTa/xXshR1+LGqHRIar+WDwPE5+A4CISxMw9C?=
 =?us-ascii?Q?y0/0K7wKZO3u++Rxt+nLEHYl1T4N0+WndQ0vy0os5smKTQf78eA8Hl8Bojos?=
 =?us-ascii?Q?iqP8nRoc9I1YlnbdrQ0eo3OR7sGTjLmX31MOUtADOl/pjlaaau6yHALZhtot?=
 =?us-ascii?Q?gCQoc+fFFjoNC/P7f0HSLr5En0WnhJ/60AAlKyso44G/Z6dFBFnpir1NSuSg?=
 =?us-ascii?Q?euSnyQ5KIdLe+v2Buf6lfEemftJGoBosvulwIBG6X8u2RnX16gTK4WSwhfqp?=
 =?us-ascii?Q?T6IGu854PJalrj0KkqvJh3FeLtmQiu0UQ08bBn7zsoZDjj5TXa4Q73cEmMOW?=
 =?us-ascii?Q?BoD406aT6T7uy4ET62iJKa2nOh381s5y/NTJLDX4EelJd3Z6WdOdPn/s7J97?=
 =?us-ascii?Q?8JhZCNF6yxtWAVLQuQNfRHP6+30PO5DY3UC8fkE1L4E07sBrwyQ1jlS1sZWo?=
 =?us-ascii?Q?hr4bgVSVM+heb8sVhDwjDi0p2ygRpZVIliWKleaj9QfkL+QxpRcFQIgG//lW?=
 =?us-ascii?Q?RGWgQaChrylJ8yt/Lq6mVNUDDkcGL4T9zwXMSR/RqcnsKozPIH6mF559hEGH?=
 =?us-ascii?Q?o44JH7H6R4WacByDVOeMUksqwH5uWEhgUivLJgmiZm164w8B/NHB2tXgRU1d?=
 =?us-ascii?Q?dm3fb8VsjoenoYQaHrHyyH5mKAbnYjLdZtyLuVmcKjm+pVsdAKxUK3IjNY+X?=
 =?us-ascii?Q?mhYSR2yreTuga/koXXw2/GGtcnKbdVehYIK8AVYs47DGK9VN6aLU+UCuYS3L?=
 =?us-ascii?Q?8Q1grfaDoTzOAx983e/JCWX8jt+AbnAiBOMFG492oXvs56kDatRBvWaO+gfD?=
 =?us-ascii?Q?JJnnjdbEGcloxE+KgeX5UZMk4/Hskg3Z4LC0LoDeRGt4eCVnb3fQmMAIEL8d?=
 =?us-ascii?Q?Hu8fXFiZLIJR2YuA67V3MS2KOAyb3pSQxLSKzRqkF6DDYC1xZDHecNTs5k9I?=
 =?us-ascii?Q?BQj2TZYMqnqw2341J4FxgGuCZF9ipXtHXwI0VUrIEopWRk/sVf3bQ0ahFF+2?=
 =?us-ascii?Q?C1xAr973zR7ncvK5px8UEowKPynV2jQoO9IvFRa+UChB3ByCJ6kRB46gwH6v?=
 =?us-ascii?Q?f9Q52Zp5C+NEK1p404qFd344WH79M3M3wjo+YrNfVwxJSk6bA2U/cJl4+dJW?=
 =?us-ascii?Q?gVusP6raTm7lM/oO6pQyiZC3CkeVcf9yByMSZtN5Xe+REGTUx5XT0DTLgfdQ?=
 =?us-ascii?Q?3dVahfaYlWXjUc1ZhdayMyVDyWcm/SWq2rYrrYbkrpxpnIXgdd4Dphf/nKit?=
 =?us-ascii?Q?VHKtPqT6Biehys3UGAiwrBxMzc6BVM4C4xDbg3GsYR8EHEfdN6twv293Dt7O?=
 =?us-ascii?Q?P1YldesxDTZ6wPvBtYAWUr2i2lGG/Aw3kGrq2yTaPdB3i92eBDbIMYwarE8E?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: miNZpJ2KkVx+TupuBrGK72tngUnwTDOPS42o9gyjYwdsVA2+1BGVQmvhJ3sQZVCLH1eAJ2eKhnWfm8B2ScU6JAY+QjRV2lWgBRaHfYsKIbnHGCtHRRtc3awhB3oHFFXWKu+AraRJJNNdxJ8sEQutQ2gt4wxgXqsVYftK44I2N8voPCb/V5o4T96uM7JBlsOep6ThSGmKtX0yd3wlk5P4xvudBaGh906UC+5qof35Sq9EFAXUBS4WkhfwIX7JrJPGH0eeESdaDoKERh3nyteze2xnkmBMNG+Agn4DK71KQN+cwi8DRXBacL2htK2GgFuI3n+e/g0+q2zcIHGwD/I6gBg2WWFGEw8zAyVxd6zxg6o7bTWSVMHRfqia93I++KGBaImX2J+D/GjQ5fV6O4gz/iJEtOR0gDyE7WhCONwal8/FBbgKlmDC+NPp9PssReECe5oGnfnwj43wXfMhPIP/qJn/BqaB7cTkY8dJ/ppV4FKxi51t1Bto4xlZR5So73/Lj7MPk1B9Oag5/lhBhm5+me38aOpfhfdkkVzkBTPYJpxK93MupUl82kmdVlYe5FCJF6DKWGlZmuXROjImbsVKv+TuKxZTInCz145qA8P8vrE6e+1bLAtiaR11cbhyR+igKe0qfdtO4asnvGXkVPkfwIu3Fvit6YdPLqdRrcjMmY2yIKWMigLlatEOvHDncIN1XQ9Mf5Bv/RHsQD0NOaY45Fs3JjwHYRFTAmHP0AI720PL9UivAkoWbuO1toEN9YZxiQbUeD5D5H02AactRze4OxNuW1pcQAoH6zxVwgK5I5YmIEuO0v00KDblI9sH7GRy
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6834872f-d79e-4408-ad31-08db6bae1a3e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 01:32:51.3681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJflWDHrHUZtrzNt+FYh1x0U4VmetMupLYty/9puvWB4E3lULDx+Wa1cKVoJFkWdgxE2qwrTJqsMLBICrH6XL7m+1IK4QtJ1FK1u/IO4PtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=989
 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130012
X-Proofpoint-ORIG-GUID: xaqxvuMBd-Q1oGSQXN5hol9M_Zrohq9s
X-Proofpoint-GUID: xaqxvuMBd-Q1oGSQXN5hol9M_Zrohq9s
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

The following patches were built over Linux's tree. The also apply over
the mst vhost branch as well.

The patcjes allow us to support multiple vhost workers tasks per device.
The design is a modified version of Stefan's original idea where userspace
has the kernel create a worker and we pass back the pid. In this version
instead of passing the pid between user/kernel space we use a worker_id
which is just an integer managed by the vhost driver and we allow
userspace to create and free workers and then attach them to virtqueues
at setup time.

All review comments from the past reviews should be handled. If I didn't
reply to a review comment, I agreed with the comment and should have
handled it in this posting. Let me know if I missed one.

Results:
--------

fio jobs        1       2       4       8       12      16
----------------------------------------------------------
1 worker        160k   488k     -       -       -       -
worker per vq   160k   310k    620k    1182K    1564K   2002k

Notes:
0. This used a simple fio command:

fio --filename=/dev/sdb  --direct=1 --rw=randrw --bs=4k \
--ioengine=libaio --iodepth=128  --numjobs=$JOBS_ABOVE

and I used a VM with 16 vCPUs and 16 virtqueues.

1. The patches were tested with LIO's emulate_pr=0 which drops the
LIO PR lock use. This was a bottleneck at around 12 vqs/jobs.

2. Because we have a hard limit of 1024 cmds, if the num jobs * iodepth
was greater than 1024, I would decrease iodepth. So 12 jobs used 85 cmds,
and 16 used 64.

3. The perf issue above at 2 jobs is because when we only have 1 worker
we execute more cmds per vhost_work due to all vqs funneling to one worker.
I have 2 patches that fix this. One is just submit from the worker thread
instead of kikcing off to a workqueue like how the vhost block patches do.
I'll post this after the worker support is merged. I'm also working on
patches to add back batching during lio completion and do polling on the
submission side.

We will still want the threading patches, because if we batch at the fio
level plus use the vhost theading patches, we can see a big boost like
below. So hopefully doing it at the kernel will allow apps to just work
without having to be smart like fio.

fio using io_uring and batching with the iodepth_batch* settings:

fio jobs        1       2       4       8       12      16
-------------------------------------------------------------
1 worker        494k    520k    -       -       -       -
worker per vq   496k    878k    1542k   2436k   2304k   2590k

V8:
- Rebase.
- Move comments about assumptions so it's in the body of the code
instead of top of function so it's more clear.
- Added patch for RCU support and swapping workers while works are
running.

V7:
- Add more comments about assumptions.
- Drop refcounting and just use an attachment_cnt variable, so there
is no confusion about when a worker is freed.
- Do a opt-in model, because vsiock has an issue where it can queue works
before it's running and it doesn't even need multiple workers, so there
is no point in chaning the driver or core code.
- Add back get worker ioctl.
- Broke up last patches to make it easier to read.

V6:
- Rebase against vhost_task patchset.
- Used xa instead of idr.
V5:
- Rebase against user_worker patchset.
- Rebase against flush patchset.
- Redo vhost-scsi tmf flush handling so it doesn't access vq->worker.
V4:
- fix vhost-sock VSOCK_VQ_RX use.
- name functions called directly by ioctl cmd's to match the ioctl cmd.



_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
