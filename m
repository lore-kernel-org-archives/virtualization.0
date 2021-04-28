Return-Path: <SRS0=6MyX=JZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA7DC433ED
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7FD6143E
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7FD6143E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B6009406A4;
	Wed, 28 Apr 2021 22:37:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oxnqHjM-8r04; Wed, 28 Apr 2021 22:37:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2FEE94068E;
	Wed, 28 Apr 2021 22:37:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28985C001C;
	Wed, 28 Apr 2021 22:37:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46DDCC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2203B60D94
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="c6trRjoJ";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="e8kmMtZT"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6nUNcRRe6tpJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5875A60D95
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:36 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMTsVa177176;
 Wed, 28 Apr 2021 22:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=xe34tHZ+UCvb6dLGEIVeD6yY1wvQS4hdwAXiIbxKTuc=;
 b=c6trRjoJo0oBFIqX0m3MkCb1hmW7+qhP8NKb7WokJetsyHfub/BvZvB5GGAsDC2FYz6j
 rGJtiV/3SOXFMSptEFetBJ5yhhQpneMk6xhQNM4M3AF0j240XT4r4Qa3n+M5pnEYnCcD
 tenq4IGZgXgrDlfO19+FEiOn8fjAMKtRWvF33BRlZ1nuOF0LZtlvE0IksybEadEp1Vid
 LWdWkEuPQ7YfjBHUk5Qwq1YcLD7Mo6fQzcOAGlf71eiZr7l4DGXe4jklz51zlSL1v7aB
 LWeoDSG4jtabqiW6HqLgTvp7cjd3gt4dQ7+ktHSg9JYnqMrM69pYO81XLNZwrIRvOvt1 pA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 385aeq2j3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMTq5G184209;
 Wed, 28 Apr 2021 22:37:34 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
 by aserp3020.oracle.com with ESMTP id 384b59a4qa-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDzCaEGCW1k1VtN6LHXjqQMthEDQibGM+hcBJ9DSmV6cOs749+NbaV+cV2zC2b3UeWc3ue1LKy2IHfHdRgdkaxdPPdut5lJh3mhB5xzxMyKynUV/0lMzW9H3QjYLnUOYxfNKFgvR2Ig7tphAqA3T4z+qvgJkzJVW3n8OgZyEzm0oe4oEu/urA+Qq6+Pa6j7qV16/N+UpPCB+0tDq43ucJ/LnAaGbNQX2/CzhZicr6s4mc/lBGLzWwMoO3nitEjwknv1OukPgtjHVSkADhoW7QI4zpvkJwAA52NfckMDfj2DFQdyjoib6brRNOz28XJZqvlicGsNvpHJj2M/CEtG5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xe34tHZ+UCvb6dLGEIVeD6yY1wvQS4hdwAXiIbxKTuc=;
 b=KALE5GFqrValYlbpHoXj8NywCjhcQC8k+gZH+fOmQYh5rLiQjIpTunOS8En5CMzBk/jnVOEELx1DaSQalvDfTQnRiHgtgnQDkseMXB6YV9pInOxJ+1CDGvAyiUiXfu/SyjTnDSz4Xxn9MiiGoAr6/zWjJK9kqH02/63WVPMudA+KlfMHD6rYKi/OVqW0HbK8ZBfVWAFZnRkc+QuuJ24NNZRMsztmPWpUZ6HKqYYsyGRsUWciUwdXhpGhw/4CaQE4Lf8duG2kQ87gOcK+xqNR79T2gD7KwkDp0Ep6yqskOfNiQ5FbAodlS4tMrQkXcTuxWp2cp5b6cJWdC/LqNxZL2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xe34tHZ+UCvb6dLGEIVeD6yY1wvQS4hdwAXiIbxKTuc=;
 b=e8kmMtZT3hGDooD2+X6sp28n8/qVnz0TcMPZ9WYSTjyBenpWiOJtvwKS17p00WobaZzb0bbcarjVGrj0Gcee6zhx5K07T6O1mfnkuPRpE2SC67WqyWPGzLchkQfRoGsfNuOEVBNuZxO0MiMA9vjwh9RxCKpA4bFajOvv3KTdcwI=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB3702.namprd10.prod.outlook.com (2603:10b6:a03:11a::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 28 Apr
 2021 22:37:32 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4%7]) with mapi id 15.20.4087.025; Wed, 28 Apr 2021
 22:37:32 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 06/14] vhost: move vhost worker creation to kick setup
Date: Wed, 28 Apr 2021 17:37:06 -0500
Message-Id: <20210428223714.110486-8-michael.christie@oracle.com>
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
 15.20.4065.22 via Frontend Transport; Wed, 28 Apr 2021 22:37:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5d69afd-e468-4deb-0a97-08d90a96367b
X-MS-TrafficTypeDiagnostic: BYAPR10MB3702:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB370231C73F7529209EFE75E2F1409@BYAPR10MB3702.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+f8J371VBGJVHnqZpWCYMYUrBZrJi3kbYs5hRn0pl+vsm6WNykQaef7bSuhZvY74ocstiNTxYfKoOJuOysktHQoYCjkjoWVsuL9nGtC8K4j+VYX1Ng/eTEvxyTlbxV/lMo4VnrO3c2Q24Il3bfJHAiRLnCY72S6tFHY2OKBU4DEm0TvvuNq8NvAdh4zKDJIMiQHJaEK6QBroRGcVj3l3c/7WXagIwPNcFnSww6dtJFRW1d02H1j3P3caykT0FFcwNdE1E/bam2pIE7Pl3A4vOqdV+i21PDTsku7qlG3ZvBj8GXtB1Ss0H2pi1GgLUNenMBQEe4cRT8aUKcHssQhl/fA6BNRWxogFvdNb369gk5GhaC8/08bFpbqwqiAfl+6R5NP2cuMy0ckFysrAw5Oo9WDCofgZhvQHElbuEbi8Msw1KL736zBqUnjSlJoa/LyOGdNt9PK8HcuQx0TjhosSG0BD56ct8eIaIX3k7+F7Dk0+0TI+nkynhUCGcIUmDEjI383/zK98kpNLhbsvemCdcKjOhb9aTEXbH8BnGmwjU+DCLsmzS5HIPWIZNv0T1E2XyrhSn8BHtEfu2htOXMYS0IHOwQyKr47Lw++oKfQXJetRjo8OUCR7n51J10iW0+ncwGawQeaUV2yp7IS+cxWY5JYYyyW6PETYwV8PbpQfc4uHap/Pg5jmA8iMHcxM6Ba
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(396003)(366004)(376002)(39860400002)(346002)(6512007)(83380400001)(6666004)(26005)(66556008)(107886003)(956004)(316002)(38100700002)(38350700002)(8676002)(478600001)(4326008)(2616005)(6506007)(186003)(16526019)(5660300002)(8936002)(6486002)(66476007)(1076003)(86362001)(52116002)(66946007)(36756003)(2906002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NlC3YNbHZmj7PFNek57DXNSeMwTi+vfxgtUYSPgaoaD5W4TH9pezxzjcTq8u?=
 =?us-ascii?Q?jZlgfz3LRG5aGxEVWj6ZgPwehxXF8yyCdtglMZxeQCeCslGN3n57jND7xwNk?=
 =?us-ascii?Q?jS+bs1TESWiTByDi1q9GCNM+ZbdWwfJjlk+5tGwwVnoGk1ibGA5zasjllooY?=
 =?us-ascii?Q?+MHPidY/0hdLJawQLpJB42Kx8guUiiQsBcs79U1H6iW4MRo0POfyhGjyAOmt?=
 =?us-ascii?Q?3SVH6gxWkZwJqN23TfGxVbFmLhB4Dz4TOJr/d0t9tkagTsq1ydXUKpJRUZtI?=
 =?us-ascii?Q?MVZtYZKTYXak7A1YsJJ8arZw6x5dFPXv094eOuCseIyvnrYcpOVk8H6o9SFI?=
 =?us-ascii?Q?vLVZTV+FguLXQkK7Lx+6kMwbMYtua4UzVtcLU5lDP/oj2Z1z46kNjohAPrvH?=
 =?us-ascii?Q?YrSwpBzTE0lcAMpcAkHANgoeUjuzYJfrJPaGiWqXKIHL4byjxYqpFmXVyiTw?=
 =?us-ascii?Q?1b/jpOTitX1EXxGTs0EVviwmNOkfEXs6QOqdcmw+AWgx46IjBaAwzu2mVTZq?=
 =?us-ascii?Q?9Ln3JOaBwSWugOQq8FG5VJldFlg6XJcmyJrNbBYmk7YURIkgk4xtpmemJCEQ?=
 =?us-ascii?Q?VAWGy/fdT99VEdk8z5CWK7ENmoPW/1WdTyAoXa8lMn15n+3i33XrMX2vORQr?=
 =?us-ascii?Q?v8xznr3JcoFmK9Ayvp7c45eDAt+k/5aypD6lO2kEYotHe2mLVDJeHN8tQX33?=
 =?us-ascii?Q?Xnn+c78zOePHUtCn1QH+ZZbZUXqPS/cWGsZjBlAlMbiMaX/IlknXkusjkua0?=
 =?us-ascii?Q?1s011liYTexxu6EAvxttVgoZk/EJCHwoJX5VvCgaUpvJvkUAOrVMpDpAsPzL?=
 =?us-ascii?Q?/FuA+EaWQs0g0yabjiJ7SPay9KWUROyG/bnBSXtJjrodIz3KhuwH+Mz/siIp?=
 =?us-ascii?Q?P+/h/K1qyeeXwgbX341G9cMZwmew46UrE3+9T79ggxxg5YOAniQDYhVdinBt?=
 =?us-ascii?Q?FTfmf6uE8MrZZ2RPStDnyHlRNcwQxPPKhWxIsYF9/2Pwp+Q2ZdyBUT9vu/7+?=
 =?us-ascii?Q?sJnPknN3hfCp4zEstX3uQYGMYCljBHYCVeETbiySEw9N8fKWDj3pempyLCvK?=
 =?us-ascii?Q?C8RO4epYvID0i0LSjQmLZTeon+uuICOiPNzAeEdgNg5oqYw2pDrO0KjGoOJn?=
 =?us-ascii?Q?CWVqjQNHnOdeyOyFjltoEp/LCrJh7Eav9WJUbxQBKJz4s5Jf6XWXeQz6nj/f?=
 =?us-ascii?Q?d6qcsUXUTqrwpLdOuG8UKWoMZSz6jt7awcvcabHBs7Zv6TN9QuiDbgAWeN1N?=
 =?us-ascii?Q?nzaZS1YBm+X7OxZHmt51KaDxIrRCLnjrmoXsVEjAP/Iv3ae0rV5uuHV6ZKIJ?=
 =?us-ascii?Q?CSbikulWirCwZ8Rgjw38wYS1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d69afd-e468-4deb-0a97-08d90a96367b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 22:37:32.6760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88ELdL8JRjPUnftQ4p2rrF7BjxpvKxtLRp4wusXhxpITVXW6EtitkXxmi7Snen31v2QOZr9jQxFP5V6wFJLCVkcV1ADz0XNNeHs7B6veOCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3702
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280144
X-Proofpoint-ORIG-GUID: 6NSZ6og6FjMAHQSQNWzeF6BXnDM171hs
X-Proofpoint-GUID: 6NSZ6og6FjMAHQSQNWzeF6BXnDM171hs
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

The next patch will add new ioctls that allows userspace to create workers
and bind them to devs and vqs after VHOST_SET_OWNER. To support older
tools, newer tools that want to go wild with worker threads, and newer
tools that want the old/default behavior this patch moves the default
worker setup to the kick setup.

After the first vq's kick/poll setup is done we could start to get works
queued, so this is the point when we must have a worker setup. If we are
using older tools or the newer tools just want the default single vhost
thread per dev behavior then it will automatically be done here. If the
tools are using the newer ioctls that have already created the workers
then we also detect that here and do nothing.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 0cd19b1a832e..a291cde95c43 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -629,6 +629,15 @@ static int vhost_worker_create(struct vhost_dev *dev)
 	return ret;
 }
 
+/* Caller must have device mutex */
+static int vhost_worker_try_create_def(struct vhost_dev *dev)
+{
+	if (!dev->use_worker || dev->worker)
+		return 0;
+
+	return vhost_worker_create(dev);
+}
+
 /* Caller should have device mutex */
 long vhost_dev_set_owner(struct vhost_dev *dev)
 {
@@ -643,11 +652,6 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 	vhost_attach_mm(dev);
 
 	dev->kcov_handle = kcov_common_handle();
-	if (dev->use_worker) {
-		err = vhost_worker_create(dev);
-		if (err)
-			goto err_worker;
-	}
 
 	err = vhost_dev_alloc_iovecs(dev);
 	if (err)
@@ -655,8 +659,6 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 
 	return 0;
 err_iovecs:
-	vhost_worker_free(dev);
-err_worker:
 	vhost_detach_mm(dev);
 	dev->kcov_handle = 0;
 err_mm:
@@ -1665,6 +1667,13 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 			r = -EFAULT;
 			break;
 		}
+
+		if (f.fd != VHOST_FILE_UNBIND) {
+			r = vhost_worker_try_create_def(d);
+			if (r)
+				break;
+		}
+
 		eventfp = f.fd == VHOST_FILE_UNBIND ? NULL : eventfd_fget(f.fd);
 		if (IS_ERR(eventfp)) {
 			r = PTR_ERR(eventfp);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
