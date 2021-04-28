Return-Path: <SRS0=6MyX=JZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623A6C43460
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BB6C6143B
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB6C6143B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6AE260D98;
	Wed, 28 Apr 2021 22:37:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jyvWF0cEhs1t; Wed, 28 Apr 2021 22:37:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D5D160D67;
	Wed, 28 Apr 2021 22:37:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54221C000F;
	Wed, 28 Apr 2021 22:37:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5159DC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4083F60D91
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dA4EieukbZuU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89FB760D67
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:32 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMTSn5170068;
 Wed, 28 Apr 2021 22:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=HxaHmujvezSrA/gKetIQoSJRgxqdS1/sqY65qcZ9xPU=;
 b=uOeVT+hw2WtbI5b127O7jaraWXPEn+FYIG7nwR5n4Td22Fw5aGxI5A3wMfIuBsC9Q4Xz
 brhOj6cjIu5vp1GbloU9P5xbzULKbF2u2Kaj2aSwMgOMxEwf6psb6XL/G50r3qlR4mzm
 ZK0vk3Rt5IelBR/lBvMBYlPshICDOtopdG9hG3B1/PbNubRiJpbdTqX4L/mVbXIBL6fm
 GeOE1zCxr/77fOSkdB1jwZSD6l+y3vCO2Cj2RMUABEALe7PlG9mC/ujLiyu2wUFAxWqJ
 CffO5wSi1GE3ZUTWPN0HC5D1MaWp7sS9UnhHtyzA4KMPmCReAew9Pe/EAi/14vcFPSp2 Bg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 385aft2gwh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMTqJv184372;
 Wed, 28 Apr 2021 22:37:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
 by aserp3020.oracle.com with ESMTP id 384b59a4n8-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQvFA+o+X5qVHGiEhWg7t9mp70FNYHrgzCsGssvb/3yw/th42jcNfEIxSqSqmAs7OGAf0l2mB3cZqkwpw0XGRaJ4TemCsr+7hHHd5fUi41c1Ws/TIm07pAjo15YVozW6OhvdMoHP3MT2WTsaDq5ciFgUg3gbfyjH7/P9/c3BVmXh9vP4eW5JS4STcjudAyxPX7WSYhiCEIQK6He/v586YL7eLko5pwBtBE+uraM9h+sAknB4z4eMkRIrTQNigOgECpTCvfdXGeFcfaZSTrQ9dAi0WGMeauZVXs/pz2SSr9Ckg7dJk277+tXFwjPFj4eJfSnMv0ST5TWHmL6Qggd4QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxaHmujvezSrA/gKetIQoSJRgxqdS1/sqY65qcZ9xPU=;
 b=HSyboRoFABQsBtdME1YKGnALONmrxXoxYb6VLKcGHevoNBxqQRX26W+Q9GsCAhLRdcqGzgsO5CRfdmOmw8ApMeEv5XIPqZ6XG5WBS3nozkDmyu/duFfsbC0S8Z21TBh1cujBDYrAnyxbWgVZkTeXLNnedJ6Li8VgHuYAuyARFn6QLmb93vf/jTCvt1KGBP/0AnABS25+KTUaVNDjH8idI87Lo8lVdbj5CwTP++RRxUQd+8IlC30IaUyrqhKgCGyeJPm4sfDRra3mG2Wbs1HMmLu0aKvpIZc2NhSWa+FPGsSRS8xNY8iQu6m9FFu0lvzY1hQmjNTJKK3eO5PUQhXKXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxaHmujvezSrA/gKetIQoSJRgxqdS1/sqY65qcZ9xPU=;
 b=UVOil46BzAI4wLuYE3jkYp0kD/4nCBP43vMhzcNH6Y2sqN7NpnO0NVehZISQScjC/wLaL1YUqKubG+BjkwQ1YlDIv6uzQ+eYxtGi40Bhjg6d6ov3VDbV4yMuDi94GOBD74b1ywLMTB/iCOT/xojl3XKgj2tR/AnsxdTAUoFxhco=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 22:37:29 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4%7]) with mapi id 15.20.4087.025; Wed, 28 Apr 2021
 22:37:29 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 03/14] vhost-scsi: reduce flushes during endpoint clearing
Date: Wed, 28 Apr 2021 17:37:03 -0500
Message-Id: <20210428223714.110486-5-michael.christie@oracle.com>
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
 15.20.4065.22 via Frontend Transport; Wed, 28 Apr 2021 22:37:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 040ba42d-2313-43b5-ad2b-08d90a96345b
X-MS-TrafficTypeDiagnostic: BY5PR10MB3794:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB3794A0B1517498F4BD3ED8ADF1409@BY5PR10MB3794.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+VICDnUMbGk15cIZ7ON+C4OTLcs+opJa1pvFcKmJY0kz1HcEV8Okd/05uwKBh/cydRzajWUrxLgRDRsIj1xEF6AzuQ096gDA2K2bBnZwp/cbQx8oYyJh68ABx0B5fKu8XlLKviCOVS3hoyLd6GFyK+kB7V+B3HPcnGgMvnSaFTtczZkntHMw8Ro5XvzZlTOIYmc4Pa7V2H5I9sfZnGS0n+a54W9lKebqjXi1gOoEPpMZTT7l/+QVcV1ksikFmZJ26xyHSwz90dKX/mEhUD89WD7xLTiQJxaWg9B1Y0aHB5sedT/93xf9/2DaS7D2ADy45upoW1qNJYU0PCip5gTcsgkP7gNXd4AnxUbyRiuydvyNM4KnDg741xfP6374l93YzWfyiueyqXakot+ifSyGI5vEnU/izOQTYizP2+Asal/l4/hbgLGXeuABs/CoWc3YTItrt3EQccDJ92cYjv7LearkO0VVXlECFQ56zCQGE3vyWgr8FEF4H3vXEGNo8ER5Jx6S1eSkDq6YWCYHb1uhk4HVBHgQ0NipTdH+WE0tmMLWIGxJJr+EMK6e9ik358yiBsHTm/FuzVCVAsZA2Qhs15ay4zG1y0P+keh9YTctAVoueqJwAHX3UIu9lle0f5Faug6x621HjT59smeYvJ34F70uLuL/OfgHaQhucoDfsZN86G3D5+fAdL9MgVG829m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(39860400002)(136003)(366004)(376002)(396003)(26005)(1076003)(186003)(16526019)(6666004)(107886003)(83380400001)(86362001)(6512007)(8936002)(316002)(36756003)(52116002)(6506007)(2906002)(6486002)(956004)(38100700002)(478600001)(66476007)(4326008)(2616005)(5660300002)(66946007)(38350700002)(8676002)(66556008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?K+iwTdxcOsIBE/ePB7oKSAoqHQM95sI7b+B1UZTHbGv2MTPkd4fOclLQLF8C?=
 =?us-ascii?Q?ISELtAok33UYGxKLJhQm5RnBnDQOlVGffrOBsedN7YhdB2Wy8j+YeE+gNdpX?=
 =?us-ascii?Q?2r+vlFEuqBBd64sysIc5Dhqxtg9Vioo7toodw1SUgEC02tMU0oPCiCqR8oHJ?=
 =?us-ascii?Q?hxWFF5NXuucNw/kBVE8pej5+DWSPU0Brc2Vms1XZcXyIoe7/0+0sivMsne2w?=
 =?us-ascii?Q?Hb6mSD8e3nbwPl21k6rl9Dmv2K0JjOtC4GuUZNDDwFhRTY9baf28OqQ388Yz?=
 =?us-ascii?Q?lS58foojnfMZLEFGSCkV7OpoohbC8AqDKQn5nKb7imzAkf3u2rHm2JTwSnBl?=
 =?us-ascii?Q?wiyId9aNrynU2qgQ7vL9KPurUNPI10LwxuB3W+vjP5VlkISve3TrtKkdPzzu?=
 =?us-ascii?Q?55ut2Qy5fke1Trp/MWs1DncxyF/wzg6icZ/5hrcaM+4T5/EZLeNCQdxEerIP?=
 =?us-ascii?Q?XmoSuGLgD046rlSyEO6LIld4xSkVkVi+leR2XEwCEDZU/x5soWgpMXolpiVa?=
 =?us-ascii?Q?rRt64RJZZkW2AVmY6DeQzCM0dRhbJnF3ErClI6lc8ouqxlxedEurRSP1smUf?=
 =?us-ascii?Q?5BV8Vc4CUxqRwVd5dWiuHPZJWqwC9x31Ob0yiuR9kaGWLZzGej2RDDYF4AC2?=
 =?us-ascii?Q?lzNogfpc8qc0Ff/AkwHvbCFG98t+cuyGZ4Evyisw5sYv4LTZc17Z3btAfcWh?=
 =?us-ascii?Q?XEGOykmjYJx4/nDmKxrWts6GyQl0gu5Ik1e+gpuaLyGSJpYBnqckS4Gi5EC0?=
 =?us-ascii?Q?YRJgRZsI+vTqJFdnFbJbA+H+W7RmjWplYvlvHF+oSe4qRVQrN1bunlfGzfCF?=
 =?us-ascii?Q?mVC9ii06IdhwIG2kIHihAf2oEjH2EzWjcIbJa1/IMDBKJZGPbayhPNEOBExM?=
 =?us-ascii?Q?faPXtfErRsSLOOCdh7Y8OAeElpK23OY+kT9hZ5f7BnBlzpMNIesMAmYw/DR6?=
 =?us-ascii?Q?eZKsxyJhV2x5HSPqeMgiEZFuPpIvQnp1egd5olq4SKcfupPZI030ON0wf69Q?=
 =?us-ascii?Q?Qg+id0uUUjmdoaS02l5BCbmu+odWE4gZ4KlbqxT0vBlMTUgZhwxZOgY8ydho?=
 =?us-ascii?Q?cGA2KflzLmDm4Lpkh0S+oYffE/DA/nzwvU+Qs4cWsEiOR/L0ilya2GEp1VZa?=
 =?us-ascii?Q?KFz+PJBOCKnzYydETBlBZUrA9gCTJeW1ADOGwwSSOJsbasijW7zDBBlaCTLy?=
 =?us-ascii?Q?izii+HoRt9MFZXOyPJ5/OC+fdGyhbr0/arAGWBY2l7QO+7OEP6xMzGuYmpuY?=
 =?us-ascii?Q?xIHv4U4m3QG+Y79V++EgRgsS2daQdaPO3voTwfLMiJfhKFDBSEPvcm0wJR/1?=
 =?us-ascii?Q?5r70aQVR0ft8jhKvQXi1G+vC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 040ba42d-2313-43b5-ad2b-08d90a96345b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 22:37:29.1110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/kKi9Wz5tJhEVEG0E1MQXUyZxEWF8iAuHeGydwOrYrSXWE1eXl9DhP244Scj/P/iGmEg9WeS3El1o4qwBZ3CQVeXzp6dhM3LLTBikEwol0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3794
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=977 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280144
X-Proofpoint-GUID: Z8U87xDq0u_ccNOaiQaYNYMDp66AN3Tm
X-Proofpoint-ORIG-GUID: Z8U87xDq0u_ccNOaiQaYNYMDp66AN3Tm
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

vhost_scsi_flush will flush everything, so we can clear the backends then
flush, then destroy. We don't need to flush before each vq destruction
because after the flush we will have made sure there can be no new cmds
started and there are no running cmds.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index b3e6fe9b1767..46f897e41217 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1732,11 +1732,12 @@ vhost_scsi_clear_endpoint(struct vhost_scsi *vs,
 			mutex_lock(&vq->mutex);
 			vhost_vq_set_backend(vq, NULL);
 			mutex_unlock(&vq->mutex);
-			/*
-			 * Make sure cmds are not running before tearing them
-			 * down.
-			 */
-			vhost_scsi_flush(vs);
+		}
+		/* Make sure cmds are not running before tearing them down. */
+		vhost_scsi_flush(vs);
+
+		for (i = 0; i < VHOST_SCSI_MAX_VQ; i++) {
+			vq = &vs->vqs[i].vq;
 			vhost_scsi_destroy_vq_cmds(vq);
 		}
 	}
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
