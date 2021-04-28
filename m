Return-Path: <SRS0=6MyX=JZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F77C433B4
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276B86143F
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276B86143F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF1DB60DA3;
	Wed, 28 Apr 2021 22:37:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bJftKrgw_uHj; Wed, 28 Apr 2021 22:37:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E6A860D95;
	Wed, 28 Apr 2021 22:37:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92F5DC002A;
	Wed, 28 Apr 2021 22:37:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D25FC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F0885844CE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="XVnsKjrS";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="QtO1NTg5"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Iw3mu8iHn9Aw
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2533C844D4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:38 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMVG0b127578;
 Wed, 28 Apr 2021 22:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=fAemnL+P57qFkHzZ+eLxLIiMASyzSKTI5Sw5/PrsQrg=;
 b=XVnsKjrSfKbPfGIcPN9NNbzkdYnyfhmXFgzPPOz1m8AIz0St6/THPGtRec3mjGSLeyfw
 848np74o128lwXlILpNRo7oaIInd9wnv0Vy2gdUAsw6EvRUjgnM2RhzILZlZdDzKxHDb
 Y1iITU/CYNKeSU28oqnVWfHAvEbmxgbzuLKe3WHygy7SyuGQQLRdkg3ewRLxcwKuT88f
 zWlVhJpv/yxoF/XWrqRLGfFqkAU+lMhoy2WWxYgAV2/FkkeG7xwwJ5HS8sMpjA19WC/f
 B8jZ5E1oEpQ4luUyxhyUbL5F4/+U9Ys1Hp2hAWFkDkWeIlVjrtlNjsCGyR2+SSRC9vb2 Dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2130.oracle.com with ESMTP id 385afq2k4f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMTquJ184275;
 Wed, 28 Apr 2021 22:37:36 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam08lp2171.outbound.protection.outlook.com [104.47.73.171])
 by aserp3020.oracle.com with ESMTP id 384b59a4r6-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dq3jffYB/Oc29vd4oWaTSiyBAWIBwVb47E6WBJ/htceNDfvUdfvbz7qY+ajv10UI/aPAMahFJTlx22CuZhE5Dd7rCxcoWsyiNQ6CKIwxyH/44Qqg/yM1Mv8q8CNlYk2BrtpMcIGDyDUNgq+nD5/LNLTuVekr1maZBvp+Q4mptUrx9RrG0sxnq95hh/9FaGLS+FWGu/lLDIhEJs0PbItmm6pT4GtveQhQp7GTFONgo8tbPKjiA2WknnE49Xl8NwQ9sJWuMyl1h/xVYF0FuOJi/bPZCQ3jdnVPijZ1gatYC0KxP7v6p8iQZKWQv/m0f+BUFvmaViYD0m/aR7bV/xq99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAemnL+P57qFkHzZ+eLxLIiMASyzSKTI5Sw5/PrsQrg=;
 b=XMFKgo2ayHjwIQoV0M6tOZhdsjJyi4agVrO0D61UVXGES2d7C7SywNHzOsQQ0EL71TSgXRAZeCuMfwhbxYs68ngizCm1HmNdJZofEqnU24orap1q8U3GHmkqOx3Q0PzM3cXpiDT9b3zICzwMqn6rUD/CwgoWVUvXTa8bWJYdGUOOh04Hhe5Jj2nCH9D2IBD3WewvZ3F9Zf7GX8IT1/mcguMmkKS/eychQ9X1iTt8jHZobkLN2iGWBZM2nVbRYK6Gy1ATH0asIoLc2gBApQ73qG6HIckPwPDOjKAOFvH0cRKyImR+fw/cZMnugPD+5sTUVK3PQ8efa/Ec0oCtMJxBew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAemnL+P57qFkHzZ+eLxLIiMASyzSKTI5Sw5/PrsQrg=;
 b=QtO1NTg5Oz7LTT+5PwHC0Wx0C39X9YOKL6S1IJLR2p6hDW6lDn11thuVre4WYrYxY/RHtb+hH8n2iDV03NAMv8MaXkk75jCOQkQ/Nu50qWmfpAidHHTf2evxPqguyEs8Cpq9X4joy76xFQT61XPbnhi+yLGmr3tG4ILvPuftXQE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB3702.namprd10.prod.outlook.com (2603:10b6:a03:11a::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 28 Apr
 2021 22:37:34 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4%7]) with mapi id 15.20.4087.025; Wed, 28 Apr 2021
 22:37:34 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 08/14] vhost: allow vhost_polls to use different
 vhost_workers
Date: Wed, 28 Apr 2021 17:37:08 -0500
Message-Id: <20210428223714.110486-10-michael.christie@oracle.com>
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
 15.20.4065.22 via Frontend Transport; Wed, 28 Apr 2021 22:37:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 678170b2-1742-481e-021d-08d90a9637b9
X-MS-TrafficTypeDiagnostic: BYAPR10MB3702:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB37026A1CE6E4ADDEEB7AD36FF1409@BYAPR10MB3702.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CEM7i1HOuy5N0cFSdojKMFRdxdA2iS60MvQyDxzW0llmZCNHznKlZIyLqdNSA9HTxPsyTiVpOo/JyN1hnqkFcm3t8e5AIyqT61fahxf2a+ws0jZ8ZkXjcN0plVKxnuYhHJ1AgTreeSXjCMw00MQ0y5BKo2tgh0T+ezaz1epE6hAnZQSQXPqQ/Qkd+ZQiSzgQSNa6PPmIh0wnUA2WprbJst6GX4LQExZfoO+tfh1/tmYYgThDZyznKuD5FGugDmU3yy0CN+GOGWgHwjjq16WIi9wC8fc6xEzoB2QDUBm9XT6oYr7E7O1JPElE38uvPwD1gFPv+RqoonKHRvJDCuZXkGXHtexNiVLC2p2Q1Y8FW4DZK0gty4KpvVbC1IRI15ezbYqKZpBn79jAFH18p3+yKOQsglHW6JVTzYx76wU9dztCwFPFHD7P3clnvDYmRDGfDJROvEY1Ef4k/+bf4Kh4/PYnUOrfVndFqIKyYszvCzGLmamS+Y/Btmb3S3ESo9FnvQ6CTZPdW4uaXVGaxeTzzM0X5q1t9dQXqSAuiibK902Htr3/CqF4ab9zfULsOdXGhN3sv+/Ye5zpxKBDEhG98LwZ2Yw2pZab0oj6Jfuv+HKApAw50hhGflF0He0KoeckA4o+/8K0tNRZyfm6tQvXWnlGdO275W4nR4mr8qcDNxffHWvou2Hgw8RoSdyy/7+3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(396003)(366004)(376002)(39860400002)(346002)(6512007)(83380400001)(6666004)(26005)(66556008)(107886003)(956004)(316002)(38100700002)(38350700002)(8676002)(478600001)(4326008)(2616005)(6506007)(186003)(16526019)(5660300002)(8936002)(6486002)(66476007)(1076003)(86362001)(52116002)(66946007)(36756003)(2906002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Vv6r9Je6YRXlKjCtBhpoVo9EEevaaIx6h1l/Xtls4fpYGNufO99/M6j5sNPf?=
 =?us-ascii?Q?OlUQDi+V++0Q6H5OJ0TqLnxVd688Wr59/dO8KOmvwPkiH7bdRyBqIk/tRzOO?=
 =?us-ascii?Q?P31HkAcvvK7eYXuU7KKZ5ZG8hWV+P5xzMNpM1TqlnJ358fPjyWN5PuLeWad5?=
 =?us-ascii?Q?A5PvYkaVb+5Y23vMs2WFJKoBEZ9UzNxftmKEorJpCQfM+xjbO2sd8C/d5Y5v?=
 =?us-ascii?Q?glGTgNi6DFrQVd/DZ6tKis31uThQh8TRN24Cm+I6SUS5OJvv166pWXYKiKJP?=
 =?us-ascii?Q?iAmfpQctajZp74LXJ7UxaUN0bsM0kTyCv+JorDmLV7gVTgSL1RDN7Eeo8Gdy?=
 =?us-ascii?Q?0D0rwE72X6vbSwAOB74aRrqNk+TMHgXNRBGReTmhcbQ8wyWtHMGpPgFuSbgA?=
 =?us-ascii?Q?2xltW4BHtIO61q9z+UZnwVYq1sPrG3mlx1byzsjDF2DmWIrvEsj29Iw9Jfyi?=
 =?us-ascii?Q?8tCwDOK3nqneWWZshJdCtRih9fwgz1LJNugR4fxdZrqed4Kf3cPQqMbKRiC9?=
 =?us-ascii?Q?K7RCUbgFT6OvrJxthlwJLuXDvuVnA5GXDcQR5wd37Ftzn6WEluegg7Aj6nXq?=
 =?us-ascii?Q?a7GB2M+u87GA8tpuqn+s7y0ARrbYuJaeSwbsvkdNFk4Zh38zxZIYBGzsKzam?=
 =?us-ascii?Q?BRXE+pLrtfnCj4jnttNbOy3cwFjnjNaiHVLRyzuSxs2OmIqhpGSgi/PvbGLE?=
 =?us-ascii?Q?PdM7SA3iZtdcB02ZP+vVNRcg0GcDxHwECW8YoBRaF79AzqL3mPhEp9UNBr5S?=
 =?us-ascii?Q?FZ3FSNXcgeBmR/JalgK9xLjsEQbGMvsWhh0pVnH5hCQngTCuaoMf5+Zoc7Hy?=
 =?us-ascii?Q?LgL3gyoMNYJCwoPa+uTNZHxcKA346zWp3MdvQILU4435wrQact7/rh7fsxfN?=
 =?us-ascii?Q?Ez7cjWfyVPAzZJWkPYkIuMjbvzjWEx6kyn1KeNG21iMuSPdKvcRAW+VOJumb?=
 =?us-ascii?Q?JQKD6KLAONOYyNy/0wPnyQ449IJUTmjil3ARLwHIgmAhdCHvEGVL61YzNe37?=
 =?us-ascii?Q?OSwuU3GxryeAGybqiwYqTD4h3YV89HUT0jNa6UG7v0OnzVAroMRdZZUzfVPz?=
 =?us-ascii?Q?Yenww9Hm6G7pLLlEWDYfDxKTiB+XThokqDIhXNqK6IolYMOxIYZ0pC33NxWF?=
 =?us-ascii?Q?DaHUgWGLAj3S7qcyHyV9HXshqrVh0ePbHnls2vjX/J+kkslOHgs9UZjn+A96?=
 =?us-ascii?Q?p3MNenOsr5xqh+mDQQPETINx+Jot1aXdsAoSL2BXRYJmRvxEMir54bIsOIwE?=
 =?us-ascii?Q?qWanOtQnMrzNL+2b0mLzuvHhL96aXdbVQAz14XJla5pm2vC8l6emrjolOxrT?=
 =?us-ascii?Q?KPjSxrfnelOyckJCriwD++ym?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678170b2-1742-481e-021d-08d90a9637b9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 22:37:34.8158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zflPac/fCVCLLKADro7QJliQgJZWRAvXsQWf32gkcM073k6UPjEPm1N6xbAHEqEfX8Luxo9J5TzIg8WTvYBmE7aZnwS+Sqa+KrMd0Cmgj2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3702
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280144
X-Proofpoint-ORIG-GUID: z3rrR_ZIiSE1k-1GSh8kI3gXc7HaawQ-
X-Proofpoint-GUID: z3rrR_ZIiSE1k-1GSh8kI3gXc7HaawQ-
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

This allows vhost_polls to use the worker the vq the poll is associated
with.

This also exports a helper vhost_vq_work_queue which is used here
internally, and will be used in the vhost-scsi patches.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/net.c   |  6 ++++--
 drivers/vhost/vhost.c | 19 ++++++++++++++++---
 drivers/vhost/vhost.h |  6 +++++-
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index df82b124170e..948bc3d361ab 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1334,8 +1334,10 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 		       VHOST_NET_PKT_WEIGHT, VHOST_NET_WEIGHT, true,
 		       NULL);
 
-	vhost_poll_init(n->poll + VHOST_NET_VQ_TX, handle_tx_net, EPOLLOUT, dev);
-	vhost_poll_init(n->poll + VHOST_NET_VQ_RX, handle_rx_net, EPOLLIN, dev);
+	vhost_poll_init(n->poll + VHOST_NET_VQ_TX, handle_tx_net, EPOLLOUT, dev,
+			vqs[VHOST_NET_VQ_TX]);
+	vhost_poll_init(n->poll + VHOST_NET_VQ_RX, handle_rx_net, EPOLLIN, dev,
+			vqs[VHOST_NET_VQ_RX]);
 
 	f->private_data = n;
 	n->page_frag.page = NULL;
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 4bfa9a7a51bb..3cc1196d465b 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -187,13 +187,15 @@ EXPORT_SYMBOL_GPL(vhost_work_init);
 
 /* Init poll structure */
 void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
-		     __poll_t mask, struct vhost_dev *dev)
+		     __poll_t mask, struct vhost_dev *dev,
+		     struct vhost_virtqueue *vq)
 {
 	init_waitqueue_func_entry(&poll->wait, vhost_poll_wakeup);
 	init_poll_funcptr(&poll->table, vhost_poll_func);
 	poll->mask = mask;
 	poll->dev = dev;
 	poll->wqh = NULL;
+	poll->vq = vq;
 
 	vhost_work_init(&poll->work, fn);
 }
@@ -298,9 +300,15 @@ bool vhost_has_work(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_has_work);
 
+void vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work)
+{
+	vhost_work_queue_on(work, vq->worker);
+}
+EXPORT_SYMBOL_GPL(vhost_vq_work_queue);
+
 void vhost_poll_queue(struct vhost_poll *poll)
 {
-	vhost_work_queue(poll->dev, &poll->work);
+	vhost_vq_work_queue(poll->vq, &poll->work);
 }
 EXPORT_SYMBOL_GPL(vhost_poll_queue);
 
@@ -359,6 +367,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 	vq->busyloop_timeout = 0;
 	vq->umem = NULL;
 	vq->iotlb = NULL;
+	vq->worker = NULL;
 	vhost_vring_call_reset(&vq->call_ctx);
 	__vhost_vq_meta_reset(vq);
 }
@@ -527,7 +536,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 		vhost_vq_reset(dev, vq);
 		if (vq->handle_kick)
 			vhost_poll_init(&vq->poll, vq->handle_kick,
-					EPOLLIN, dev);
+					EPOLLIN, dev, vq);
 	}
 }
 EXPORT_SYMBOL_GPL(vhost_dev_init);
@@ -662,6 +671,7 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 static int vhost_worker_try_create_def(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
+	int i;
 
 	if (!dev->use_worker || dev->workers)
 		return 0;
@@ -674,6 +684,9 @@ static int vhost_worker_try_create_def(struct vhost_dev *dev)
 	if (!worker)
 		goto free_workers;
 
+	for (i = 0; i < dev->nvqs; i++)
+		dev->vqs[i]->worker = worker;
+
 	dev->workers[worker->id] = worker;
 	dev->num_workers++;
 	return 0;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 9eb7c3bf0bd6..56a6806be8f6 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -41,14 +41,17 @@ struct vhost_poll {
 	struct vhost_work	work;
 	__poll_t		mask;
 	struct vhost_dev	*dev;
+	struct vhost_virtqueue	*vq;
 };
 
 void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn);
 void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work);
 bool vhost_has_work(struct vhost_dev *dev);
+void vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work);
 
 void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
-		     __poll_t mask, struct vhost_dev *dev);
+		     __poll_t mask, struct vhost_dev *dev,
+		     struct vhost_virtqueue *vq);
 int vhost_poll_start(struct vhost_poll *poll, struct file *file);
 void vhost_poll_stop(struct vhost_poll *poll);
 void vhost_poll_flush(struct vhost_poll *poll);
@@ -76,6 +79,7 @@ struct vhost_vring_call {
 /* The virtqueue structure describes a queue attached to a device. */
 struct vhost_virtqueue {
 	struct vhost_dev *dev;
+	struct vhost_worker *worker;
 
 	/* The actual ring of buffers. */
 	struct mutex mutex;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
