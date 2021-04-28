Return-Path: <SRS0=6MyX=JZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFA4C43460
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A5CD6143B
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5CD6143B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7EA341896;
	Wed, 28 Apr 2021 22:37:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id il9vo5hCyZWp; Wed, 28 Apr 2021 22:37:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id A358D41880;
	Wed, 28 Apr 2021 22:37:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3508AC001C;
	Wed, 28 Apr 2021 22:37:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89833C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7800B844DE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="iNi7ltQX";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="Mcy3Hq5R"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qy3ulCKy-S5h
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 80FDC844E2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:41 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMVIS7127582;
 Wed, 28 Apr 2021 22:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=4414GN3InVCcC818Km+Y6SpQrU5N4G04YQM3z19Vsr8=;
 b=iNi7ltQXg1lFBLcFyTPLoHvuIaXdZqKdSMQivNrEyjo3ZYl0QZERv14PTqL6dTDDud2q
 BiNgAF9fWsRIsNXGKHVMPrvPtAppF7Za1dzzVoNiSWcuiVFkijEwnlJNz+a6aXRMBBou
 BnveCEDM2sgnnTxAgjmSccBpKsWcCvVl4yBKLTtG+0awBsvIjLmzld6ovt5bHp1giQyT
 cyTItXu4H/vrEZ3qdx9wwWxHKa1eobIhex3RIpxsEjxsTUoNN/sfQNKcOxf+9vP6FCIG
 Rlp2LiwMvZ8EPTYRS13z319nhEp/SDxtF6ORQ0OxY79ca/+vro2NaUXQAbYmXEFFTItk kA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 385afq2k4k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMUmED043084;
 Wed, 28 Apr 2021 22:37:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
 by aserp3030.oracle.com with ESMTP id 3874d2pbek-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UazKQA/S9RRW+YX8zFEywkI17F7MAry0xrW7zoKsRqcMzW+KNvOQY/6+1P0vU4hyYGEbYbxgKm6sPH4rkZIfHTdo4Nsel0zHWLffoNaYMtidzMLPqqR4JZcWnrLMUKBiLu+eITfSdeDfwLgWhWm+pMCFQJzQU3ZR2AYbvXF6Q0vEASgvTpaL0R7nPEk+oJLFqtl23s6bal/hGCADOpgnNAoLM/DbkFNhLw/iv0CHkMifolEwpLN1/V4KJYMgusG+t0pMPFDzqclCDx3FSpvgK8JgqG8v63g3nwkeNRGEXFUTJJYN8Dk8glaGtqH034TL2P6zR3z/ZOrOvDJ7m65zug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4414GN3InVCcC818Km+Y6SpQrU5N4G04YQM3z19Vsr8=;
 b=RBH0ib3QL7G5QM1bo8/gn7rTBT9t+80d/B4sTSdP1P1EHT7BRdccFLPtSw5Uc6uIbhrp0KF18QnLTQwL4i7ZNJkSm4gsUcdKvKVKuBgmd6b0jONOXGoVXWCXttBGlPvClD4O9nD/ansXHxhaB6GfPoJBAIe3NsJ7Hgd4KeyYUc4Qk/oyyxsjo8RWUGiRTi7e5Tm8tk4L4lKxwrQ+2IPrdvWmVHsLqg5+3cw9agaj9JUv7MJzorvKrU861/bhuEFuwD9Vu4JuMgIXnln+9pwGmKjgZmkFfDEo2MMIU2xkY7y5w57hvG+rnfpaHRJwekbMdOI9X9ued+hYw5yzHEjmTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4414GN3InVCcC818Km+Y6SpQrU5N4G04YQM3z19Vsr8=;
 b=Mcy3Hq5RDxCpCwgjFNY6VA9PfO+Yk4NPGZTDKHR4aoPZ8dBKGccfmo/jvwT7+Doc5e07uD1mxzJ4jFW1DbCd0xn3PINRDFcTHm2xlX4Dsb8uh5onXnghaKxQheqsIvmIBiOb7jOMdv5YNT7DX45Qc03gBnIPuLvWMr0yUOeutqg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 22:37:38 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4%7]) with mapi id 15.20.4087.025; Wed, 28 Apr 2021
 22:37:38 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 11/14] vhost: allow userspace to create workers
Date: Wed, 28 Apr 2021 17:37:11 -0500
Message-Id: <20210428223714.110486-13-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210428223714.110486-1-michael.christie@oracle.com>
References: <20210428223714.110486-1-michael.christie@oracle.com>
X-Originating-IP: [73.88.28.6]
X-ClientProxiedBy: DM5PR1101CA0019.namprd11.prod.outlook.com
 (2603:10b6:4:4c::29) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR1101CA0019.namprd11.prod.outlook.com (2603:10b6:4:4c::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22 via Frontend Transport; Wed, 28 Apr 2021 22:37:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cae7a6d-2a6d-447f-200e-08d90a9639c0
X-MS-TrafficTypeDiagnostic: BY5PR10MB3794:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB3794DA068B559A8B69F20D46F1409@BY5PR10MB3794.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:216;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kqgc18/4YnvwS4qzVJDJwVf+LrbJOcRD/Gk5/XIyiFgOtC9IrXHEqpl0zi+4VvYQVJw5qTBek4WD3WhsuBApv0nfUg08MEBZS5+b4LTn8dCqo0OtvGNhWpRFxdiVO92HiWswYwgJFonz5jeT/vUlHaUPaCJ7J8CVS4Hi/g+9OCAYmW7tEkq3LRCCpfKK6YkbStNcSPzjUCUpyUmBQho1059ia0x/GZ46yeNCIQONY3fJk9CbNxdOSRs7zWLtsOO+vxwrObY6GIQQ0nIjXKA4PAo1YYom+bN4Ta/ef8W6FbJUTyEPGnftARPR8uBnOhwFin2M8FqXlGhsdYIHdq68OfWiEFPVnyQC0RyUYolOEE4Yj1be1IOunVZe6lwj7xD1+tqnlg/Vi4+JHkT1B3wrEquAsHkmwwEnxIpQQvR8tstzMunH2LeV7nPRO3CxuWdISTtgo0WWkkKaUZqoJu8evjlVzLck8D7o3xNWVsLRcfBTY3Np43sMTBpZydeAmqS7935EqcnrmcvT60N4dtzNwSxhoyL7yFDDJhZDsfxS52Oe1s1WK9wWZbvsavrdcOrjA5pAq8rDF+SesDTJcH//vVxhSokORXBaQb+10IG/4yH6lMe5pfKnrLJEfzInEpu3tKYRWsFgn3m1G0IzV7AZ6um/XdowQSBmCYLam8zLe85E2jLEY0kuarSauJoO8+24
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(39860400002)(136003)(366004)(376002)(396003)(26005)(1076003)(186003)(16526019)(6666004)(107886003)(83380400001)(86362001)(6512007)(8936002)(316002)(36756003)(52116002)(6506007)(2906002)(6486002)(956004)(38100700002)(478600001)(66476007)(4326008)(2616005)(5660300002)(66946007)(38350700002)(8676002)(66556008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LHbmbc87G3ZVcz6o39/o1yucC/vYXDA+jgAgLAUabj6pq8BCCdd/0wYqas64?=
 =?us-ascii?Q?IZVTZuzaoSurXuVy5nkO5FkxaxXgSX+nHgMIh95Hi64HSGJ357b0ZVExorIA?=
 =?us-ascii?Q?9GHP/KoBdt4W9l+43MyvFrWeSZyPj3p0uyugYzllm+RhpHozyF5IflUfof3U?=
 =?us-ascii?Q?P5pc9qCwtBdVgW6Mvz/eI+tM4ahvIYC+F3VVPJvFHwxcJYSC40+j+oVzMTjT?=
 =?us-ascii?Q?0QGbAcRPQVygjAIvlbkF2hR46ScVY892q9+GeZMDPImm1pwWaLfMZRDiU9VL?=
 =?us-ascii?Q?8U8aHtyVbDRmAatv5HnHlipq79wYuVLOg5j5RCUs+L9X6337LkE2dtYbRoZw?=
 =?us-ascii?Q?+cEZa+lu0Rw/teONx6DlGQ2d+oLoI+/2iy00iwp5j8IoRoQrHzUCl6JaCFzd?=
 =?us-ascii?Q?UmaGuN6Kdsjh6hHHfCuXPw6HCe20IRtnNByyM++EZdQDP1a5/LzWd3/Q9Wfz?=
 =?us-ascii?Q?GYOin4LldNbwSKsbryPOjiIPvkoRxMj1Jt3GamW3EorkbdoeU4GbuxgUy5M+?=
 =?us-ascii?Q?eLf8UrH+QGDl9HtVqiwhp3/UkY5MSHxKxP5eRCeR8j4rEz3f81qqkEcx58bC?=
 =?us-ascii?Q?phh14zWcv5L5OL3BHVEe21Sp+F+e70Q/VDGsQfb6AOTL6bN6KpqcZBN/lid/?=
 =?us-ascii?Q?QhOJZpnmAfzzt7yQmoqYamUNZ1609lgLklKYKCno26MVm8uT57FGePC3XuFg?=
 =?us-ascii?Q?dcxQM1H8V/kJ6ny9fcT91hWXUuaM+cxgZdBhpZSCRTEccD0H1Y3x31crbQ3V?=
 =?us-ascii?Q?pG7Jmz+daEvM6O5ZzZf6OdLm+seVp/Ou4d4uParV21OQFt65B8p3r6v13DMb?=
 =?us-ascii?Q?9OfDEw+dN3X/VOjqAU46zM7vAZh5W4Z2EUys8bg2mEg2MFFkLR9t/cmH8EzS?=
 =?us-ascii?Q?/bF++QgcoIIjxslYf8SSlgtFZrpl2rJeSpgIESZ7hbJqwMWRWUBnqDiYWFbL?=
 =?us-ascii?Q?4FGRe6cj7Ils6biSp7eQAb8aWsrrVDJ9KI8AVT3fLDZtEEx7fJ5zoVWJXcdZ?=
 =?us-ascii?Q?8iY3aB8CqNCM7cdvObPNer3srECBGT9u4m7887mVDmz4qddxAtRwCX9j5Gk3?=
 =?us-ascii?Q?VKGEXJOXbWj8I6Ksgkkb2JmtKd1HOkrmvkh+vjjLyVLOXw1lLuFkwZ5bcMks?=
 =?us-ascii?Q?mTmm/7QFQQYHLihxYoSmvm2n370y3TjoFcB6GEBf0QP+dfYB0pK/xdV8VQ28?=
 =?us-ascii?Q?E+lz0G6ECgmRe5Yj/mVcdjW58E7sVJ4ngrhl0ih4W2oTsIztlXPNzFM4Bu6R?=
 =?us-ascii?Q?2UVPQTgtuuKMmPFngq23Yhvjq0wdcxkvUO7NRlzOGeTkMvzD1ZzxRae+y4u0?=
 =?us-ascii?Q?tfnPhr2Fi+RQ+ayopf0thTx4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cae7a6d-2a6d-447f-200e-08d90a9639c0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 22:37:38.2818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KGxFb2KSkRb72m+XPRG59EpHGda+sIMGgK8FYtjRJVIh+8EDX6EseAb9e4vuWZBX4Z21FqAVyq6ZuZm0DidLRv4ztv7EXDcfe+L6dzsyZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3794
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280144
X-Proofpoint-ORIG-GUID: mxbm399XeHtUb8eqK1VRVO1Bp8tT5UYr
X-Proofpoint-GUID: mxbm399XeHtUb8eqK1VRVO1Bp8tT5UYr
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280144
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

This patch allows userspace to create workers and bind them to vqs, so you
can have N workers per dev and also share N workers with M vqs. The next
patch will allow sharing across devices.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c            | 95 +++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h            |  3 +
 include/uapi/linux/vhost.h       |  6 ++
 include/uapi/linux/vhost_types.h |  9 +++
 4 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 345ade0af133..fecdae0d18c7 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -42,6 +42,9 @@ module_param(max_iotlb_entries, int, 0444);
 MODULE_PARM_DESC(max_iotlb_entries,
 	"Maximum number of iotlb entries. (default: 2048)");
 
+static LIST_HEAD(vhost_workers_list);
+static DEFINE_SPINLOCK(vhost_workers_lock);
+
 enum {
 	VHOST_MEMORY_F_LOG = 0x1,
 };
@@ -617,8 +620,16 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 	dev->mm = NULL;
 }
 
-static void vhost_worker_free(struct vhost_worker *worker)
+static void vhost_worker_put(struct vhost_worker *worker)
 {
+	spin_lock(&vhost_workers_lock);
+	if (!refcount_dec_and_test(&worker->refcount)) {
+		spin_unlock(&vhost_workers_lock);
+		return;
+	}
+	list_del(&worker->list);
+	spin_unlock(&vhost_workers_lock);
+
 	WARN_ON(!llist_empty(&worker->work_list));
 	kthread_stop(worker->task);
 	kfree(worker);
@@ -632,7 +643,7 @@ static void vhost_workers_free(struct vhost_dev *dev)
 		return;
 
 	for (i = 0; i < dev->num_workers; i++)
-		vhost_worker_free(dev->workers[i]);
+		vhost_worker_put(dev->workers[i]);
 
 	kfree(dev->workers);
 	dev->num_workers = 0;
@@ -652,6 +663,8 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 	worker->id = dev->num_workers;
 	worker->dev = dev;
 	init_llist_head(&worker->work_list);
+	INIT_LIST_HEAD(&worker->list);
+	refcount_set(&worker->refcount, 1);
 
 	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
 	if (IS_ERR(task))
@@ -664,6 +677,9 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 	if (ret)
 		goto stop_worker;
 
+	spin_lock(&vhost_workers_lock);
+	list_add_tail(&worker->list, &vhost_workers_list);
+	spin_unlock(&vhost_workers_lock);
 	return worker;
 
 stop_worker:
@@ -673,6 +689,71 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 	return NULL;
 }
 
+static struct vhost_worker *vhost_worker_find(struct vhost_dev *dev, pid_t pid)
+{
+	struct vhost_worker *worker;
+
+	/* TODO hash on pid? */
+	spin_lock(&vhost_workers_lock);
+	list_for_each_entry(worker, &vhost_workers_list, list) {
+		if (worker->task->pid != pid)
+			continue;
+
+		/* tmp - next patch allows sharing across devs */
+		if (worker->dev != dev) {
+			spin_unlock(&vhost_workers_lock);
+			return NULL;
+		}
+
+		refcount_inc(&worker->refcount);
+		spin_unlock(&vhost_workers_lock);
+		return worker;
+	}
+	spin_unlock(&vhost_workers_lock);
+	return NULL;
+}
+
+/* Caller must have device mutex */
+static int vhost_vq_set_worker(struct vhost_virtqueue *vq,
+			       struct vhost_vring_worker *info)
+{
+	struct vhost_dev *dev = vq->dev;
+	struct vhost_worker *worker;
+
+	if (vq->worker) {
+		/* TODO - support changing while works are running */
+		return -EBUSY;
+	}
+
+	if (info->pid == -1) {
+		worker = vhost_worker_create(dev);
+		if (!worker)
+			return -ENOMEM;
+
+		info->pid = worker->task->pid;
+	} else {
+		worker = vhost_worker_find(dev, info->pid);
+		if (!worker)
+			return -ENODEV;
+	}
+
+	if (!dev->workers) {
+		dev->workers = kcalloc(vq->dev->nvqs,
+				       sizeof(struct vhost_worker *),
+				       GFP_KERNEL);
+		if (!dev->workers) {
+			vhost_worker_put(worker);
+			return -ENOMEM;
+		}
+	}
+
+	vq->worker = worker;
+
+	dev->workers[dev->num_workers] = worker;
+	dev->num_workers++;
+	return 0;
+}
+
 /* Caller must have device mutex */
 static int vhost_worker_try_create_def(struct vhost_dev *dev)
 {
@@ -1680,6 +1761,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 	struct eventfd_ctx *ctx = NULL;
 	u32 __user *idxp = argp;
 	struct vhost_virtqueue *vq;
+	struct vhost_vring_worker w;
 	struct vhost_vring_state s;
 	struct vhost_vring_file f;
 	u32 idx;
@@ -1794,6 +1876,15 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 		if (copy_to_user(argp, &s, sizeof(s)))
 			r = -EFAULT;
 		break;
+	case VHOST_SET_VRING_WORKER:
+		if (copy_from_user(&w, argp, sizeof(w))) {
+			r = -EFAULT;
+			break;
+		}
+		r = vhost_vq_set_worker(vq, &w);
+		if (!r && copy_to_user(argp, &w, sizeof(w)))
+			r = -EFAULT;
+		break;
 	default:
 		r = -ENOIOCTLCMD;
 	}
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 973889ec7d62..64dc00337389 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -14,6 +14,7 @@
 #include <linux/atomic.h>
 #include <linux/vhost_iotlb.h>
 #include <linux/irqbypass.h>
+#include <linux/refcount.h>
 
 struct vhost_work;
 typedef void (*vhost_work_fn_t)(struct vhost_work *work);
@@ -28,6 +29,8 @@ struct vhost_work {
 struct vhost_worker {
 	struct task_struct	*task;
 	struct llist_head	work_list;
+	struct list_head	list;
+	refcount_t		refcount;
 	struct vhost_dev	*dev;
 	int			id;
 };
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index c998860d7bbc..61a57f5366ee 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -70,6 +70,12 @@
 #define VHOST_VRING_BIG_ENDIAN 1
 #define VHOST_SET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x13, struct vhost_vring_state)
 #define VHOST_GET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x14, struct vhost_vring_state)
+/* Create/bind a vhost worker to a virtqueue. If pid > 0 and matches an existing
+ * vhost_worker thread it will be bound to the vq. If pid is -1, then a new
+ * worker will be created and bound to the vq.
+ */
+#define VHOST_SET_VRING_WORKER _IOWR(VHOST_VIRTIO, 0x15, struct vhost_vring_worker)
+
 
 /* The following ioctls use eventfd file descriptors to signal and poll
  * for events. */
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index f7f6a3a28977..216f1658d0b6 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -47,6 +47,15 @@ struct vhost_vring_addr {
 	__u64 log_guest_addr;
 };
 
+struct vhost_vring_worker {
+	unsigned int index;
+	/*
+	 * The pid of the vhost worker that the vq will be bound to. If -1,
+	 * a new worker will be created and it's pid will be returned in pid.
+	 */
+	__kernel_pid_t pid;
+};
+
 /* no alignment requirement */
 struct vhost_iotlb_msg {
 	__u64 iova;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
