Return-Path: <SRS0=6MyX=JZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23574C433ED
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABCBA6143D
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCBA6143D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 456614067E;
	Wed, 28 Apr 2021 22:37:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j4r4GOK6BQ9l; Wed, 28 Apr 2021 22:37:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id B76DF4064D;
	Wed, 28 Apr 2021 22:37:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94DD3C000D;
	Wed, 28 Apr 2021 22:37:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E3EBC0019
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E45A240658
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Ww8NuE1qfsw
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 934A5400FC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:30 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMUpPw177953;
 Wed, 28 Apr 2021 22:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=y57/RskCrmz45HiyhuSCRjQm5e/hQSl0A7JRDp+RM/g=;
 b=qJ/QpmfdQVU+Gi568BKqIWcLHNLMq0emAruCZTOVW5lvv3Gvl660ChrbwpyuJDBY2X5t
 lepqiCTmoAMVLxdGjRB8BipFAGJa9RBosMVYspBNuDUYEoJsvafjCO4f0lk7AeXHCC8t
 OzycoA8+97/yB8NyPRjYXZAa/YHTIr3Grz31+sam7a7Kgx77k+BZMJ4GKTHfdFEeiNnS
 Pih7DXjar673Kl3OgxKzibwoDTbSubROtSzbnk0PALy1M2zJ45g3h5SzriuXI8ZW24q0
 kFHTfxrB49VRZwvZge6grdBY3DLK3aQ7F9aob8A23aHxtDGGxEjMzVj6R6CNFLNYgowt bw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 385aeq2j3c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMUqfM066337;
 Wed, 28 Apr 2021 22:37:28 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2059.outbound.protection.outlook.com [104.47.36.59])
 by userp3030.oracle.com with ESMTP id 3848f07388-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikcukp1TcewDtehtv7vrPz+bBHodr4Al8SZiPoIpJVwfTThvVDIF2BbuclZtoexNuF7Irp7JZVYNYP5nAIE5PfW3K5kjOC25WcyaECIgC+ucxyGC8bGar98WfWx3oQ/4TFop4+BJ/Hptw7FeituOcbQi/y03oV01faxs/0eHkifrNYHLylmaAUjrsAJq5nn4MpxJcUabn6bfymjixVBPuttvTfWkgkmKGNwrFoHtIuXsdoQ8D520uuk3LwtbSiuCyaJ5dsn086q0MrwKFNBqKgMMUdOVP+3vHMc4afsruO32jvN72pm4Ue3zKpUrgibYyxK5q1qb1pn8lkA6wchnXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y57/RskCrmz45HiyhuSCRjQm5e/hQSl0A7JRDp+RM/g=;
 b=nstskAueqA2ZSGDmLskdnulNJnWsbS5IA5Pou5bfWFbGClVaOgLU685aEZcm7OOs4z0Ax5RP+mgzPFp10yYiCB4LOhPwdf6IC+g8qJjKxS/HkK0+RDKTMtCLDClqBJgrVQ5tEdB0oyi4jaSdb0toheWagoastztYpzNLJiil1omSvCRBCJ7heMYYJk1gyB8M+J+6wcwLZLcsQmBZXongYEDgiatpOgxMaNwPTE5OJwnU/D51t1gS3OxmgyWx45KW05V+JWXP+wNXulNbkL1jQCk0GwrTdvKGyAjP0+EvYKT7rmcl7NVjgxIuu5M5PYctZeniAx12Hkt6haaahRnvfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y57/RskCrmz45HiyhuSCRjQm5e/hQSl0A7JRDp+RM/g=;
 b=XpqzMegRaMfcmyV1vabOrxXQgle/PESZDC2icpbqh3uBc/yJvsxIDigUmnwxJqJ98Jo7upBXMr3zPg5Vll2KNUYZ3f+J51yB+utzqEWMk9Kiaxwtqk7mLjLCaFXE31ta1BZSOjVXRcYek8R7e5dqGZCoUJEzoUha86thCiwZD4Y=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB3702.namprd10.prod.outlook.com (2603:10b6:a03:11a::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 28 Apr
 2021 22:37:26 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4%7]) with mapi id 15.20.4087.025; Wed, 28 Apr 2021
 22:37:26 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 01/14] vhost: remove work arg from vhost_work_flush
Date: Wed, 28 Apr 2021 17:37:00 -0500
Message-Id: <20210428223714.110486-2-michael.christie@oracle.com>
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
 15.20.4065.22 via Frontend Transport; Wed, 28 Apr 2021 22:37:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f566529-744c-4700-9902-08d90a963284
X-MS-TrafficTypeDiagnostic: BYAPR10MB3702:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB37023DFFF01407DA6B8DAE00F1409@BYAPR10MB3702.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aA8G54QDPrDmmixe7+HOZuUMmUbuL2KNAZ+mAfxEG3jxjjxEjjQdtPLYYEaSMNhVeU3dLKJrMoMzTfUGEmkRL7y3AFmvXsnMbjvrF7SV7sOvvD2U7fWg24PsRrf8Zdenm1dWuxCdVpG7kMQxdJrC08i/f70zu4yeZm0amOKesdBBhCP82mH65oYilUGP7zqq8XjubNCZHX/byp8uE4bdqFzSpcP3jVh04X7wJnmzQNjKMtogC6gG/vgTsIbzaoM4yDlfI7vuq9RcIM/gw35b/v8DkYLj3tGraY/5lNSY9eN8d77SpfRXkoc1OqB9ab3E1kBHj8jlaaovWUmLBwvLujUsm+Jq95S3sAaUFUJWvl719wRMcBiuwFcUVoONvMZi/G+A9sGnmbCQDyryMqhhtS6zL6YbtBmxN3BjLuStpiVP7PD6Qipne0NI5VKp9zZeH6fSmKcRmu5IrHnPkNGrJYxa0o9t1gitB9JX+ouMxpKvngb2S2Vi7Hlol5lwBIlNYSHUSRzL71lTip0ft93ubp69d3GbLzKoxO1C14Er5s8bUGTNWFP52fDpaBLKqtEMyeKTWgkihYQtpGi4D3girh0jc4dEZVT9j0ka3Meu2AF5eqN6g1xWHoK/XRi6cpudJJrdayDHNqRbMmkeJlFwNDPs86FswvFfG9zk7V67aWX5eNjegWonyLUgukhWSf2Y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(396003)(366004)(376002)(39860400002)(346002)(6512007)(83380400001)(6666004)(26005)(66556008)(956004)(316002)(38100700002)(38350700002)(8676002)(478600001)(4326008)(2616005)(6506007)(186003)(16526019)(5660300002)(8936002)(6486002)(66476007)(1076003)(86362001)(52116002)(66946007)(36756003)(2906002)(54906003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nbeyZkB17N7OjyVgA3YYD/R5yaWid5TPwE3iBhx+0NF6UHT+ytro4TIeUVkP?=
 =?us-ascii?Q?vANxir+PMrTarCa/00wFL/YPv1plyVGRBuLtoLDIf/uI+T5k0dBpRN5eV073?=
 =?us-ascii?Q?2tHEectDVg7klAaOEH6o98dp+7zAS5E7gWr6AHq/d2zWX0H+Xm4EQzoywL80?=
 =?us-ascii?Q?AaXwD2Gryhu3V3yxirUz78lxJCsdkJziw1epP8RR4zqUdChk1BZYppb5a83m?=
 =?us-ascii?Q?EueQPeubc7+ctQyTEXlauivSzTnLUyyk4N+5CsF4DQLJZUtkorrCd+ceXqPu?=
 =?us-ascii?Q?pB/6gZZtopaWO1Q0xkrsEr+9QfiQcOgayl05VATZSaTl1D5sPe4e9fjejrMq?=
 =?us-ascii?Q?ekdQt/hX97Pi1HD/pb1sHuWq/b1EHeqVBxNZSQYpRgVnuTjnHhYIxg7NmPtO?=
 =?us-ascii?Q?s7WH6SNHG8z3FESjZwK1CZBENcgEZxUBO6igzSbExLyOMqwq+Kwtdhs+TU9B?=
 =?us-ascii?Q?XmuXva7yO7BlTvEzstoDNzdlImqt6XCPTjy1Y60P6m35RXjgwmp2Rrh03sYJ?=
 =?us-ascii?Q?u0+kywcwce3v8hdYigoaatw/RqHtKVFDRT0Y5MPp/PiVI6Pw1UtYTuDm++E/?=
 =?us-ascii?Q?oityiLLxoiBsdw+fzOeUsoupqOSzN5C/0kS8J95BIeGiEKOeIeOku1yaV+HO?=
 =?us-ascii?Q?7s+aVO3I7IvjtpgRKnrGmgs4YedlOgGncAn3GEcBdmbruDQ3DI0crTUGcdS5?=
 =?us-ascii?Q?evLdERK2YMJUx72JqMI/STmjoU6Gloz4uJYNh7xe2IJGM1pwZ1X+TsHb7q/o?=
 =?us-ascii?Q?UC4WVYQj+gF714jINekw4eQVvuFaYUG4XXMJHYMnWLu1CMGFJfqXT7JmeMkW?=
 =?us-ascii?Q?JS1YY9QOdrdf6vCoB9C2gi66Ztv/lUt/A72WA1YLu5L1FCQ+zPIx3U0AQGOK?=
 =?us-ascii?Q?PNjEab069PF3p8Cfz6f/mdYTviy+p5yjB+ofb9L95dF1hMov7y5tAYNZ8xhT?=
 =?us-ascii?Q?1cRYcPKQmOB1lhRmsyJ4VroWvkZLFJKkYtHK0iiDsbJnshVBoYlYYxEr3No7?=
 =?us-ascii?Q?t0PhHXBJ7bLFF+KHXw7YK1TV30w0elV1CIplp6ugpQ9sOUkU3HbSd+TXWGaN?=
 =?us-ascii?Q?3QG7D88ewldP7vuffk56b4gz/kqUVIE7osnWnlm4vCny3lb9Wj8WIKOQrviu?=
 =?us-ascii?Q?B+XOZyJsWKZRI9pJM2pKQeYLS+Xj80Rx/iyJkYF4U7/z87PjuDyDE/QPoW9p?=
 =?us-ascii?Q?ZB27SaCLAO64A/x0IRauLDEf8BzL0/x+P/i5qWVo4Ayj/tSEEJ/R6N/PVVWF?=
 =?us-ascii?Q?TwLHJ0bxL3uQxqCytb48rcfhZ8188YcTJ0ulKscl2pK4Mxf6xGc6z2IYg9Cu?=
 =?us-ascii?Q?dNrYqz4PoO/s+Bk1yF6LOYJ1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f566529-744c-4700-9902-08d90a963284
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 22:37:25.9937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NuLUTYZgd2knRSnDyk4LW4fomBDIWKoSmn/piDfBqGLZEk6pFZwDKFLu9m84XjFdUgW9o1j7XN9Y7JP738x3F/Od0xheMIvjFB3FvzPdno4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3702
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280144
X-Proofpoint-ORIG-GUID: NavgbYNWvyBGM2hdQtOZKrDq4BlM5Ylp
X-Proofpoint-GUID: NavgbYNWvyBGM2hdQtOZKrDq4BlM5Ylp
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104280144
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
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

vhost_work_flush doesn't do anything with the work arg. This patch drops
it and then renames vhost_work_flush to vhost_work_dev_flush to reflect
that the function flushes all the works in the dev and not just a
specific queue or work item.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/vhost/scsi.c  | 4 ++--
 drivers/vhost/vhost.c | 8 ++++----
 drivers/vhost/vhost.h | 2 +-
 drivers/vhost/vsock.c | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index d16c04dcc144..0fd596da1834 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1455,8 +1455,8 @@ static void vhost_scsi_flush(struct vhost_scsi *vs)
 	/* Flush both the vhost poll and vhost work */
 	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++)
 		vhost_scsi_flush_vq(vs, i);
-	vhost_work_flush(&vs->dev, &vs->vs_completion_work);
-	vhost_work_flush(&vs->dev, &vs->vs_event_work);
+	vhost_work_dev_flush(&vs->dev);
+	vhost_work_dev_flush(&vs->dev);
 
 	/* Wait for all reqs issued before the flush to be finished */
 	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++)
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 5ccb0705beae..b9e853e6094d 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -231,7 +231,7 @@ void vhost_poll_stop(struct vhost_poll *poll)
 }
 EXPORT_SYMBOL_GPL(vhost_poll_stop);
 
-void vhost_work_flush(struct vhost_dev *dev, struct vhost_work *work)
+void vhost_work_dev_flush(struct vhost_dev *dev)
 {
 	struct vhost_flush_struct flush;
 
@@ -243,13 +243,13 @@ void vhost_work_flush(struct vhost_dev *dev, struct vhost_work *work)
 		wait_for_completion(&flush.wait_event);
 	}
 }
-EXPORT_SYMBOL_GPL(vhost_work_flush);
+EXPORT_SYMBOL_GPL(vhost_work_dev_flush);
 
 /* Flush any work that has been scheduled. When calling this, don't hold any
  * locks that are also used by the callback. */
 void vhost_poll_flush(struct vhost_poll *poll)
 {
-	vhost_work_flush(poll->dev, &poll->work);
+	vhost_work_dev_flush(poll->dev);
 }
 EXPORT_SYMBOL_GPL(vhost_poll_flush);
 
@@ -538,7 +538,7 @@ static int vhost_attach_cgroups(struct vhost_dev *dev)
 	attach.owner = current;
 	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
 	vhost_work_queue(dev, &attach.work);
-	vhost_work_flush(dev, &attach.work);
+	vhost_work_dev_flush(dev);
 	return attach.ret;
 }
 
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index b063324c7669..1ba8e814989d 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -46,7 +46,7 @@ int vhost_poll_start(struct vhost_poll *poll, struct file *file);
 void vhost_poll_stop(struct vhost_poll *poll);
 void vhost_poll_flush(struct vhost_poll *poll);
 void vhost_poll_queue(struct vhost_poll *poll);
-void vhost_work_flush(struct vhost_dev *dev, struct vhost_work *work);
+void vhost_work_dev_flush(struct vhost_dev *dev);
 long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp);
 
 struct vhost_log {
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 5e78fb719602..f954f4d29c95 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -663,7 +663,7 @@ static void vhost_vsock_flush(struct vhost_vsock *vsock)
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++)
 		if (vsock->vqs[i].handle_kick)
 			vhost_poll_flush(&vsock->vqs[i].poll);
-	vhost_work_flush(&vsock->dev, &vsock->send_pkt_work);
+	vhost_work_dev_flush(&vsock->dev);
 }
 
 static void vhost_vsock_reset_orphans(struct sock *sk)
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
