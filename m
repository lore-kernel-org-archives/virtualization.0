Return-Path: <SRS0=6MyX=JZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE42C43460
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 627126143B
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 627126143B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1618A4189B;
	Wed, 28 Apr 2021 22:37:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2HBXTVEjv6-R; Wed, 28 Apr 2021 22:37:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7CA694188C;
	Wed, 28 Apr 2021 22:37:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A914C001C;
	Wed, 28 Apr 2021 22:37:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5BE2C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C2A33844E2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="gQHT8ef6";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="S2a9G1B1"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lv74wvYKCMhI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 16E8E844E1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:43 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMTucq006993;
 Wed, 28 Apr 2021 22:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=dQHooU/h4Fjm793OUAn5jR3w3Yq7QC3kyqFDppwcVrw=;
 b=gQHT8ef6amjZB9BdnwfOuOhgkGF/fITmWYD9hvHlAU/4rvgYRQqBNlcmYu6kNhtS/6Qt
 uaxbLZSkzPYojL5uBzMGBKnaPrHgBgX1LT8mUYLJdv00W8IE2DYEN8Azp18+C2ipRUAF
 zyzjkvjCogAnPfuCsotDpZKrOHOuIL4g2pBTNougvg4tJAxOCgTvdApeUTBtEFP2GpM7
 qIYQl4C4DZ4FdgIXeetrFxzZN4u9984c9lRzCkH6X+RqWuz1+uleA4Prstf5hBK6I1OH
 rhqXntclrgI6z14Yq95jC57J6AQR9XDZKVTYG1eMenzAeSwILRtkM0uzV2tQEA9zJ29q Cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 385ahbthgp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMTqGA184211;
 Wed, 28 Apr 2021 22:37:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
 by aserp3020.oracle.com with ESMTP id 384b59a4td-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYKHVW3UaEV5nkjwkQO+1BOOuUjGkjgzCgetRBMm+vumIQvr94ke8YKnz5OtM9u7jJb4X6I52sBvnkcomNzbSRWIpixW9MqRUxHuh2LGmsxOHnFJIrALta8M2s7R4MD6Eq/zRcYhM/Q+mn9ulIB1Zbk6yQXf66FQ7XykasLCb2LoO/Jwj2h321CqFthLgqUwVX68XUcGaaJmXxSgnXpQF7SWDgefNWvfujKwAnSwjX6mtm1K80Vus/7TyIOz4x3aL7HXEzlNXX5WhV9HM6f8o3IFHteVAvvUkRuI+kgiTxZWEM2LYCLigxcKmeN6xyft7FBkyApwPSLsHdzxwgpn8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQHooU/h4Fjm793OUAn5jR3w3Yq7QC3kyqFDppwcVrw=;
 b=MnAe+HqezBz97Rry4jZSpAd3faY2JPuWhY6VfO9OlBzprQHET2sNNG82ip0jrZswglBDzWK3HpxciXSnrN24rqGVBwRmcFDPOOQD8qdxc40cQ9kqLZX2oOD7uP4GfHc9lF/NzO0XaJtOlZo+Jrkw0sToVw5/PacAuaiqa8kVz+nKKYX7WnXCkHIiJRZEFiQtRINDveiqAt6XPqpWOqUoec08R9w2ZX2k8jz2MrvihtH6GvjP0mx6yk+wTedvkUTLaxcvHPv3fgMzk12gYtCTFqpb/TQn73qPltiWHZPslnC1cy4NtHUpOdj31dD2fyAQs+2Q5MODxQh/eTuP9/jIJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQHooU/h4Fjm793OUAn5jR3w3Yq7QC3kyqFDppwcVrw=;
 b=S2a9G1B1RgmUqAoEuSJGU95ej3Vfq4Qi62tGomvZDasYAijvquzHnYRh43MydMm2B0pe7hukxd6sRXbOPTqRmuTMUl2hPglG5nVOzl/WBOrJAgZr9HxndFCVjVpc/IdgZE3ItGHAZbD64gTjYEQQGaASVzXrmb9DUWellSYOqg8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB3701.namprd10.prod.outlook.com (2603:10b6:a03:125::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 22:37:40 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4%7]) with mapi id 15.20.4087.025; Wed, 28 Apr 2021
 22:37:40 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 13/14] vhost: support sharing workers across devs
Date: Wed, 28 Apr 2021 17:37:13 -0500
Message-Id: <20210428223714.110486-15-michael.christie@oracle.com>
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
 15.20.4065.22 via Frontend Transport; Wed, 28 Apr 2021 22:37:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d0f0ae7-83b5-41a7-53c0-08d90a963b06
X-MS-TrafficTypeDiagnostic: BYAPR10MB3701:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB370117488EA284259C971E9DF1409@BYAPR10MB3701.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BBbk58Q27e7+FbrrXFtT6/GKHPjXFErs/FLpq85zvkdW0hkf59cDLMsGTMMy/YOAVlcavO1pdiYsrALPTfOxn6piL5bu1MAE2rTDe8HjFWzfS0EZm6s7nNmW2sZfIpw6sgVD/P/T6wVLHNv0Pz5M4amfwrPSPJyYGRZ9g5/IOmZs7JRUrzIWVaupCb7dZNtD8uyvsUdEoB4LFC5KAFGNJTF7bvX1dMTlf1XVcAJYLSRwdJ0Se8zeEdoOUlnn0X3WAT2rQJ1SbP0Sn8a3/Q62jr56rPaACv7pG3UFVpDLvddxnqKFxErj0C1O8wn2PhwLLYZXo7kXWfS7orPl3P2qtORRbjrRet9+h4avy5ibzl8Hykmo6wwNI18hROi6RcYtrBxz1uirUxzPuI923RAkkEBX3aCk0pqilZ0qgvpb+E5N08Y1YB38/RVbPvCCRtm4x/ZZKO4XZ8PSqv+oYvzjIPvGVJ4we1B2Rp02RK9QVxUwaXYg2xwv4UEY8volLW/GUt3NWv+TZA1bwb60NAsOBt/qrozsU3q6UHsXTG/FxriZjSWdETY4PM5hbM9xXAwYv5jeYA9aHHx5dAkJffUfLliNt/1QebSjEzufNmJZ6nMr+sEh3ahZEvJpL+1xgykMVwiNY0Wk9KlJY/mIt0A9vs7bPesW91r/GudhYN/irKDEtMUeE8acvos5Axgvji6t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(376002)(366004)(39860400002)(396003)(346002)(2616005)(956004)(8936002)(1076003)(36756003)(6506007)(107886003)(4326008)(2906002)(38100700002)(6512007)(6486002)(86362001)(38350700002)(6666004)(5660300002)(8676002)(478600001)(186003)(66946007)(52116002)(66476007)(26005)(83380400001)(66556008)(16526019)(316002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1WVvYgLywbcwciZ0rtizsRAV1fIXqC20HRtWWICyF+2Zwhh9kbJgQ5rD5teB?=
 =?us-ascii?Q?GyJwEdA/qLXa4LlhhOql9vE0vFdEDo9ugZR3gdaYwLjvBCtF8Q+I24WYTRF+?=
 =?us-ascii?Q?l9dGnsk9kM+JkrnjGqQ33gVAGKSSZ86moKBqmz3/I+di96vzjDmkNEvgtzs1?=
 =?us-ascii?Q?BVxAnR9nhhmAP0TVM3u3Gcmo/lK+Q/hjTiBPF1gfySS9zCLLVmnMui8m2amx?=
 =?us-ascii?Q?aUvlhlVlkQwwb4tvTtGXb5dM1a7XDsqne3FXkKwfM5gm4S+cXXJFPz+mD22o?=
 =?us-ascii?Q?bj1X89W9E1NT/8Bovif6u3mj1N2meWe52tl90HL0wDQoA8yHmoAMD+Mqn1B0?=
 =?us-ascii?Q?/DMy4SHSUZCBVYR3Pxu+sbFEpyoQRwKRv0SxL3U8IotuZU7CD/ETS9FxU2lS?=
 =?us-ascii?Q?jjPPQtP24Xqm6Q4JunSp109IN+QE9V3xPSL+LHoiLiohuLp+w7PvMObz7/qq?=
 =?us-ascii?Q?/MvpBovpz+Wtw+xtGQ1A5zD6XNzYq01zuZ8mZjLfaZxsoRY94vstBaS5qc5n?=
 =?us-ascii?Q?zHMnDWBjUSj6x7/GTnB8b61iIiAr0ueRRLXEvn5D9iG4pl3bhk8qxkmkMWBy?=
 =?us-ascii?Q?5nokzWD2XiWrGdhvZg+XDcwHUPJCunjs1RZ2o442MY7m8iPusfZ4wewswnXx?=
 =?us-ascii?Q?cosHyTBYiwkUKr9pqYhubdYwqT6/dM2TmvTvoOjwwtWF9VfQYxbhGcWjFug9?=
 =?us-ascii?Q?FRy8ZatHkJGx61rUIjL+N2haI8O+lAUhuouoia1fIC2kceuGDqoZ+jM5TyDj?=
 =?us-ascii?Q?zjomOkmby+eL2tj5LfucssbUxkhNi7DPxfDPEj3+8ARVA3tIFmnrrqjJFWlJ?=
 =?us-ascii?Q?31MUtJFlHAN+LWKsti8fpMiXKUx+7d6i7FHwcufiuEgytJXT8gvfLrlsvYSj?=
 =?us-ascii?Q?3JLSE7VpzTwj+y1mQaDGp3dOAgN6S2dzSHp0JPI3lU/UvnQCIY5jMF/oVNNl?=
 =?us-ascii?Q?yCwa2hnOm9MfisKObzZoJtyRHjBYYE00Jxftvh/vqKDs2vrksvwOTf3U6AYT?=
 =?us-ascii?Q?H4+JCGZFtnEXQ9XTV0WkNfNF2BwrDbcT4g52zSGARJSqv2pwfpqkj6zTNhbE?=
 =?us-ascii?Q?rKaasoSEVemmfL6zxZf6zMYTapra+ubkBif8THgvYnRzrKKabWYDzmCPdQ6G?=
 =?us-ascii?Q?8XQT1BpCgmSaevqe+862LuVSy9UOe3AGCQP0KaiaimBaUdwYw9LW3HMqiQ3Z?=
 =?us-ascii?Q?LXawf89/2cHMWq57K2wtEhauYvMx5I3JqtNgNYX/X0zLCHV9oq3spRny3Y2i?=
 =?us-ascii?Q?NA65j63e+yCAb3EiPP4GI4h4LNaStgFHV3b1nUrPKq3tO0f7gl32dLH2UBHf?=
 =?us-ascii?Q?iSufRTIoQdOBM/eDnPfAx6C0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0f0ae7-83b5-41a7-53c0-08d90a963b06
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 22:37:40.3177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOyTH3vnwzQKRBCzpt4Pd2HP5lSVL3j1+hcmpbC3WIyXJ4uXHAD5j2C75cSGj4DboFxJRSj8Gy3wnOqtWwjFm4OpZL2Yij2uCbeU3Z5hw6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3701
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280144
X-Proofpoint-GUID: 7QMA9O21jitIpH9yMtUQadPcI2apezIP
X-Proofpoint-ORIG-GUID: 7QMA9O21jitIpH9yMtUQadPcI2apezIP
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
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

This allows a worker to handle multiple device's vqs.

TODO:
- How to handle if the devices are in different cgroups/VMs.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 18 +++++++-----------
 drivers/vhost/vhost.h |  1 -
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 7ba0c303bb98..b2d567a4cd53 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -387,12 +387,10 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 static int vhost_worker(void *data)
 {
 	struct vhost_worker *worker = data;
-	struct vhost_dev *dev = worker->dev;
 	struct vhost_work *work, *work_next;
+	struct vhost_dev *dev;
 	struct llist_node *node;
 
-	kthread_use_mm(dev->mm);
-
 	for (;;) {
 		/* mb paired w/ kthread_stop */
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -411,15 +409,20 @@ static int vhost_worker(void *data)
 		smp_wmb();
 		llist_for_each_entry_safe(work, work_next, node, node) {
 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
+			dev = work->dev;
+
+			kthread_use_mm(dev->mm);
+
 			__set_current_state(TASK_RUNNING);
 			kcov_remote_start_common(dev->kcov_handle);
 			work->fn(work);
 			kcov_remote_stop();
 			if (need_resched())
 				schedule();
+
+			kthread_unuse_mm(dev->mm);
 		}
 	}
-	kthread_unuse_mm(dev->mm);
 	return 0;
 }
 
@@ -665,7 +668,6 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 		return NULL;
 
 	worker->id = dev->num_workers;
-	worker->dev = dev;
 	init_llist_head(&worker->work_list);
 	INIT_LIST_HEAD(&worker->list);
 	refcount_set(&worker->refcount, 1);
@@ -703,12 +705,6 @@ static struct vhost_worker *vhost_worker_find(struct vhost_dev *dev, pid_t pid)
 		if (worker->task->pid != pid)
 			continue;
 
-		/* tmp - next patch allows sharing across devs */
-		if (worker->dev != dev) {
-			spin_unlock(&vhost_workers_lock);
-			return NULL;
-		}
-
 		refcount_inc(&worker->refcount);
 		spin_unlock(&vhost_workers_lock);
 		return worker;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 051dea4e3ab6..6d97fdf231c2 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -32,7 +32,6 @@ struct vhost_worker {
 	struct llist_head	work_list;
 	struct list_head	list;
 	refcount_t		refcount;
-	struct vhost_dev	*dev;
 	int			id;
 };
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
