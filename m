Return-Path: <SRS0=6MyX=JZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87D0C43460
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C5CA6143B
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5CA6143B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 75DBE40695;
	Wed, 28 Apr 2021 22:37:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U17sCcOCRqrC; Wed, 28 Apr 2021 22:37:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id B0ED04068C;
	Wed, 28 Apr 2021 22:37:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD40AC0029;
	Wed, 28 Apr 2021 22:37:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2148C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A2565844DD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="A7W9R5h5";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="YmUeD4ic"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sq-vRk8Mik8V
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C22C6844D4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:35 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMU1wj177225;
 Wed, 28 Apr 2021 22:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=kLJqaPFWC8jRhk/9J7ajWTs5O5TlYGec4bA4Kda2pCI=;
 b=A7W9R5h5yzhZzoaVstWRmxrQHFxQeKdQ2om3/m03ZucRH26RZtqRU9bX+nXPI8TNQ/2u
 M0zYnQ4w3U96CEpD1senjAPddCXyBs5XXPIhI6HP1df9HdTdy38oRHm0P97LOhy32DvK
 lLUm+vAxvbybTpgKd+KIZ/92VeJM7gJqy5g/aKiM+hedTAMdP0mWqeaT5FjbK4h+EwB5
 RRVxaBKQWq9zz4aCghtukzB8/QAtQHOBgiFmmbILreMKYUrBYOz9X/Eo8OkQHkKY8CAj
 1E2AZUpnrjt2L3/MILojBN3JOm7C8edE3UKwHMFK5s2hzr+bif4mG9aRDCwbCLHK4zLl pA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 385aeq2j3k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMTq5F184209;
 Wed, 28 Apr 2021 22:37:33 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
 by aserp3020.oracle.com with ESMTP id 384b59a4qa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckmpw6gO57IKtcDEHhpMY2ne/9UX4luFNBPxap+XmEiMGlh4U8+wVt+qJ1CB0mCdZmLCz8nRSd5udIRQK+3b16cYxhF++yn7AjBnHlm4qKDW8vkZVRiXau+Y+qU/k7QGoodR9r/W+WNr2GyDuP0jnxt0Jex7vnPcVkIlsq85J/eful5IHp46nK7Z+MbQ7M3Loj8mbdausRuhHuGR1K5YYAU8MkxFtEK1E+KwzHoUNvcolYNd9Gu61xqR3gsdLzznYP+53MeJqesL4M6gNSVJ9eWXOqQ33agYCMBNWCOvhMkl+WzQvLP1tBTAK8IseSQGLRQ/IOBKzAKACsqj5A29OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLJqaPFWC8jRhk/9J7ajWTs5O5TlYGec4bA4Kda2pCI=;
 b=KrtIsE6ckWhbQHp+EyIdklswSuq1j4hYHk6CBJB4RLdKlcrQgXOY4eF+IMMMb4Oh/TRrpHQwneWfCZd5hLg9jqIEBX9kJW1Aqi7UzK5ZvuJiUx9gdyncqA8ov5ZgXVO0ZxJrpqHAybtaPYWCC6iAzPIc/T3ZJ7c5PJ78o1UbdR8ivzFKqNOjwqe/1e8LvXmWduAqkoClpZUInkdi4rI1tXOVdJDqK+uT3ULbgEXyD9PagQsqq8tdKd3fIOQPa8xB1cYehfmFOqG8VvWxEY626tV5KrmlInFJ6KNuvwzkAJ4TqhJjZd25i7CyZJd/mbnleYMY2zn2jo0V7VcSijCTXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLJqaPFWC8jRhk/9J7ajWTs5O5TlYGec4bA4Kda2pCI=;
 b=YmUeD4icX+ErH9X5w7QoIoZh1JfIa2tr1YhiYwsKddQ+V0H62L9nOyj+5U5fVKO/jpqzKk2TG4ZsOCrN3Ejx0mzdh11/+TkDuLKSUFU/09dlUMfqxpNZya2njYVtJRuFp84Hqmw1jX6TVo+KYxR06hJjYek4eywy+Ju0FP6YjIc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB3702.namprd10.prod.outlook.com (2603:10b6:a03:11a::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 28 Apr
 2021 22:37:31 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4%7]) with mapi id 15.20.4087.025; Wed, 28 Apr 2021
 22:37:31 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 05/14] vhost: move worker thread fields to new struct
Date: Wed, 28 Apr 2021 17:37:05 -0500
Message-Id: <20210428223714.110486-7-michael.christie@oracle.com>
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
 15.20.4065.22 via Frontend Transport; Wed, 28 Apr 2021 22:37:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 810ebfae-5541-493e-8e4d-08d90a9635a3
X-MS-TrafficTypeDiagnostic: BYAPR10MB3702:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3702C08A730A8364527AD33CF1409@BYAPR10MB3702.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g1GNneaJIUBkzcVZLzL4P8SwIyAzaYf5ehpsa1+SSCIiPn4WAn4VIApxmd2mpZg9vaZsNj1UKPsEsj+V8VSZRKF8/wsZyYFpYoeiDu8ywl2IgWtBUSZtt3dQVxFFrzn2xUPs6IWBaBzth/kp5YKLPmcdHapIeE2Us9Glzwkr4V4ryKxe0Z/lVpthnjof4a1dBKRqdKuP6MU/BEOJXAkHd9nnROUMG6/RSf4gFILhYz5dRi6hWHaOEeyee6j5yopjQlkWzLQV/Mr/qrLhAycQIGcrZuDnwCrXqrx75Tx6OjtMB1RAXcDNxKPPNuSnhm3N2rjdRjozUsrZNgTNgw84dvyk4nE+xInNJcdHGppWndV7pvuJT9f95bq+IFNUE82wx6E6IGgzhJz/UYiNXKYgK2wktfZGvoHwI3ztfD3uDolT89EMZgOD0GY1Eo9iKxFSB8V99bVlI0AR3pqIIO1wUux/Xb1Wqbj59GmBlPYpVPL754xy7KoNsRMUd4S75khnICwUbzBLM+vsF/TseJNOcTyMEpNHihk2w0pwHRGAzetnRTXr8jS+53nJJjROitsEY2BzyZIM04ztqSH/fpCCanrsoHyguCT0IJ/zt2VY0EOtT8C7xJy5sV1jQXJfcW3THoJqGKHdq57NLo3tlf+hGHhvVGPh/VRSYgBVDueZKL0HYqgxMnlVZtT2cRzQvnMS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(396003)(366004)(376002)(39860400002)(346002)(6512007)(83380400001)(6666004)(26005)(66556008)(107886003)(956004)(316002)(38100700002)(38350700002)(8676002)(478600001)(4326008)(2616005)(6506007)(186003)(16526019)(5660300002)(8936002)(6486002)(66476007)(1076003)(86362001)(52116002)(66946007)(36756003)(2906002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vkp3uP3Te+5bIXC+O56vQlwQ0ww60VYeSJJje/Kzt3t/Hg7s9DsTjbtnATaN?=
 =?us-ascii?Q?87JyOK7sPFDWIt/jpWFPPU7NsBkT0cLEtJxh9lzQVdWbyVlqp3aSwvrhgCUw?=
 =?us-ascii?Q?bl2sdWcFd/vOdgwjU/7ZvgAK9q3pwMKmYa2Xz+h+t0yddHjfidumEEAhduZj?=
 =?us-ascii?Q?Bq3b29qW/L2zuA4lc7OT1YMXGR8Y8NO2AgAwmjmcJEoV7jNOZFWLWDC80b8b?=
 =?us-ascii?Q?6lOfaRRCv6krydGJi939lGF/afGiAOfQy96br5QjoahWU+qdrQWCOmAVgJy7?=
 =?us-ascii?Q?DP0H7b7/AIZFw6lvfUHWNqRuWfYlNZpIZtz/8dEIY+C3hqVZAN6272sXe+78?=
 =?us-ascii?Q?cz0+S6fImVxjT2M4e1hkSoQMGC7dDNOvQoQRXRQwqhBzwR0astF7xLziuEAe?=
 =?us-ascii?Q?8EEhyZvw4r0JgUui3v9GmNZ3ghcmGCY89Cs4CB3s1WqKTA7In5em5DGOAorf?=
 =?us-ascii?Q?Xe04PmObchIpjh9nR0EonMEMsi26pT6dZykcyEvY3BYdR2bDdoDO3jjqjxQv?=
 =?us-ascii?Q?pn9B4c4TXrgLrz0raTWzY8rZN1GOinJ15d1YM6foxYqPbZIlYxKny1RzJ1j5?=
 =?us-ascii?Q?SdWjA8Jw7Bc6/iTHlEuuudeBuT2psA/0crFxKEGAsd5WRrA0x52AtbVQYLhy?=
 =?us-ascii?Q?Cxzrfgmf9lq4whNFjx/N+PfFOpzTdyUp3pX8A6Uu20B3zklfkdGmchX/ispz?=
 =?us-ascii?Q?vf3AgWSJwMJChQkb5SuGmM5rhzmEvDay0CQyDxgUYFlVThH/GK6wjYy+0XeO?=
 =?us-ascii?Q?IsME7Hb187n4/BeR1PD/ZPVGttTTaEO68CX7hcZvBD4KwB9AczfHR7mSGinF?=
 =?us-ascii?Q?1wMqbi60Q0z1Q1VULNM5q8eUNOb0gZqK0ODq6r2nK8+JfzNq2nuKbNIQd91T?=
 =?us-ascii?Q?dvk8pYACraevb6bokcuynnzznclJGSenFx4U+WVrXcKTWqtRplghbh8NYF5h?=
 =?us-ascii?Q?GFtyxWCKcuyaBlzttO0609k6AMZdhi5TcmXVyFL8uVIRcciRQQ9Vr9Dbs9iu?=
 =?us-ascii?Q?k8F/bwciOwZfDWELipbprGerlk+Q9lcIZDijR+iSH2IUti6v1OLox4vRz+10?=
 =?us-ascii?Q?3sBSMD3vu4XT+kQXfV+ce/6ITbVIQ34pQyNvhFyjZGz61ISRPIIwdpDE/9xD?=
 =?us-ascii?Q?xWMpY1G3WBGEvI/2w1METEweQ7yErdRB+VPs2hPKGDJuABAHH/yal98RlLdI?=
 =?us-ascii?Q?D2KyRDZRYa5gFBDUZl9DnJBI/WCG5JANZGbdbkn7ycRQOyiDIqjJGp17lg+V?=
 =?us-ascii?Q?r7+fECzbffndIhHsRZ/FlaWxKrSu3sUltvtyeFhS6Po0YD7rUdPaKjVA61oI?=
 =?us-ascii?Q?YxojSGzqgLGqUEroK28p7xOW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810ebfae-5541-493e-8e4d-08d90a9635a3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 22:37:31.5936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GEiDaWZqDm4EZV9NV94wdaPcwMJnD/RiCeXYHZMQK3tTW2EPJDCL+a+R6wfeXZEZy4e9J3ylc/5TM3RYGS0DlTt/AYuEBF7xZyXUL40cQPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3702
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280144
X-Proofpoint-ORIG-GUID: 4FMAVuqcJjd0gzQRz0Uc-JB8mIGMLEpg
X-Proofpoint-GUID: 4FMAVuqcJjd0gzQRz0Uc-JB8mIGMLEpg
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104280144
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
---
 drivers/vhost/vhost.c | 94 +++++++++++++++++++++++++++++--------------
 drivers/vhost/vhost.h |  9 ++++-
 2 files changed, 70 insertions(+), 33 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index b9e853e6094d..0cd19b1a832e 100644
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
 
@@ -487,7 +488,6 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->byte_weight = byte_weight;
 	dev->use_worker = use_worker;
 	dev->msg_handler = msg_handler;
-	init_llist_head(&dev->work_list);
 	init_waitqueue_head(&dev->wait);
 	INIT_LIST_HEAD(&dev->read_list);
 	INIT_LIST_HEAD(&dev->pending_list);
@@ -579,10 +579,59 @@ static void vhost_detach_mm(struct vhost_dev *dev)
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
+	worker = kzalloc(sizeof(*worker), GFP_KERNEL);
+	if (!worker)
+		return -ENOMEM;
+
+	dev->worker = worker;
+	worker->dev = dev;
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
@@ -595,31 +644,18 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 
 	dev->kcov_handle = kcov_common_handle();
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
 	dev->kcov_handle = 0;
@@ -712,13 +748,9 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
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
+	dev->kcov_handle = 0;
 }
 EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
 
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 575c8180caad..5b1e4cdc7756 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -25,6 +25,12 @@ struct vhost_work {
 	unsigned long		  flags;
 };
 
+struct vhost_worker {
+	struct task_struct	*task;
+	struct llist_head	work_list;
+	struct vhost_dev	*dev;
+};
+
 /* Poll a file (eventfd or socket) */
 /* Note: there's nothing vhost specific about this structure. */
 struct vhost_poll {
@@ -149,8 +155,7 @@ struct vhost_dev {
 	struct vhost_virtqueue **vqs;
 	int nvqs;
 	struct eventfd_ctx *log_ctx;
-	struct llist_head work_list;
-	struct task_struct *worker;
+	struct vhost_worker *worker;
 	struct vhost_iotlb *umem;
 	struct vhost_iotlb *iotlb;
 	spinlock_t iotlb_lock;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
