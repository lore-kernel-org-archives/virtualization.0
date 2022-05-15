Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CC1C433EF
	for <virtualization@archiver.kernel.org>; Sun, 15 May 2022 20:29:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A09C481B84;
	Sun, 15 May 2022 20:29:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R09-A6srw_I7; Sun, 15 May 2022 20:29:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E727A81279;
	Sun, 15 May 2022 20:29:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9FA6C0039;
	Sun, 15 May 2022 20:29:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12531C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A8575408E0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="aWABaQQt";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="KL8M4CMt"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MTiSKZbKZrFc
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E29841603
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:34 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24FEct5e015504;
 Sun, 15 May 2022 20:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=7RW9eABbQKfJZ9rXpitVMDDuOX1TdEO9RcnG9VTwFd8=;
 b=aWABaQQt0eVzzlRKD3EMzjbqbavdRPRHpPBONJr1p61V+sfcydYvxWkZZwQlElzKHM+9
 p7h5zdc3UvMNPkZxokbu9gCTOPqmb7D2g3VKTZdKfTcUsU24bXD8L0rJg5Yxfm/BahhE
 i26FRA6qkLx6AQLXsyzDaSDKA9ZOE/zr67iby9CawI7yx2u6py+W/yGHhjn90q1ThdVI
 shrqfVB/+UOyl4CrXMsNZEXpTD1HuHW+RldqvRxrMPvPGponyvYeFnthMaOg6S3TseI6
 1G5j9G9gZ1vnv26bwpJOSmaVYpV2FpzY4MTyuOb+AXNOj0MTt9nCqPLACUuWPnMvAaLx Ig== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2371suyr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 May 2022 20:29:32 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24FKOthB000789; Sun, 15 May 2022 20:29:32 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g22v17vqs-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 May 2022 20:29:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhKpeaa6l5kI3xObTaCfNLIPa76jHisqVvxs8vcgGS6qr0bHivJgzrv2rL1yH6H2SYc9HFTLaX5PjJgHv37tZKSCaqPMwsEnuwYuh3yfghAgfe16/X6XbPkGIe8himv7N/1SlHVouB9/zCy81gpGRz4sW0uRQnY0tki9bZFFACQyi7nHVzXZUDDqFSAvSW7orLxSkrqGGTe8axhNqSzbuTx91ibaCH6JLY6LnCKpAFW/vwkq1O9sGTcAAPytcTKeF3vNkxv8mFlGZHMq4ll+WImEIE4nAo8Xev+m4rteogFZmBgZXjV2kBg1dYjIl4ysLTspcEweBST8Y6U1okQJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RW9eABbQKfJZ9rXpitVMDDuOX1TdEO9RcnG9VTwFd8=;
 b=B/bEPgsxofFgXRpMRGLQWFqo1P328enS5DDcAkwRZicxZmhlm+AMkufcxusWl68xzy8OujQt+ymFbkKR6ZUeT1TqHknCLkUbeM3edrRRFnIyfT7OC5ie8bH3dVJuxcAOj0MJwHnKZBHsTBtVkI+GqS7ua5csS7ELAtoTDPvsRwz/VYwb1uDD2hO+PxtEYmqjuqsisXhTJIuqbZKVQyWRksqLZFwyc3N8+Kt8C3vXW9l1ezbztIXpjizUOYEq5KCdClKEMBXmcbSe+dAerGxOK7fkvwMK1VEud3hKCZ6byMfNBrpN8s10BKY9MMDA9XDZtn138j50sHGP9QMqmTr/pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RW9eABbQKfJZ9rXpitVMDDuOX1TdEO9RcnG9VTwFd8=;
 b=KL8M4CMtttrW/9edtRKjUY7v1Srff+8WHKa3pkJH4L0Y9Q8Hzil1UnHUARHtfiY8UoYRe4Q3XHwMhrcwiFnHfcdi6uUS324N+8TVxxGM9lBowoRruIH2tbLqA4zYvyhSSp2g+7GLHicJVdslekDqJjNj1+q+/CAp0CWIAzJD0v8=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 BN7PR10MB2707.namprd10.prod.outlook.com (2603:10b6:406:c9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Sun, 15 May 2022 20:29:30 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5250.018; Sun, 15 May 2022
 20:29:30 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH V2 1/8] vhost: get rid of vhost_poll_flush() wrapper
Date: Sun, 15 May 2022 15:29:15 -0500
Message-Id: <20220515202922.174066-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220515202922.174066-1-michael.christie@oracle.com>
References: <20220515202922.174066-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:8:57::22) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72d09038-21bb-4871-186b-08da36b19d51
X-MS-TrafficTypeDiagnostic: BN7PR10MB2707:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2707BF72E8B482C4F6DEDC40F1CC9@BN7PR10MB2707.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MxMCY/He/soBAsofMi1gLNuS7bcVBe+xt7a30Gw8cOrr0aiFm2EcXQc5GGPuMoDNOrsyjApLt+ejakzSrQ2JjBQhV5qbYKInm1vkM+fURZyU1Ej+d6jvw+TMGI7fbory4dNsWdB2r3psmqSeFHbUiA5mgBzeJdbYUD/zbjzCkr+cc0e9qOgXBe/YKzxQ+gOOVw0T/0gv2u3rgYEoii+vIvCG+a66GwqO4m3wZhglb9YcVUZ4yJYtUBpXP08Y8Rsd9GdqxAEXN3TmdkeeOfjq9ehWYTCuDEB0+cGxTgR1pnhb3qsRJ8/hfpI9xqF1fthPq60kKN3pSrQ9zAfZaS6UkYJx+K58VTnHvqZARintKS/3POR2CCdGhZ3pSzZ+AG6TiNHOddnzcTie8IcGCwkoWZpiWtdR0hksrh+0p4FCzLqadJPLbRmR49AkyxhgnQxdYST+RPPNr1DwZs4aJtvTVSKOqVkbW5XAgyrPYGypctwxRosoRAxKcMJ/hAEpstqD0ozHUiaSkkpmp5KIw7tB53yFrsEk6+4nk9Fqp1OElBdws1I0MI8gHDH8nTBdLWdluRowuxtBhcKE5i0SfpcZBP5bs//21+Vtk+dwuwjHqIWcztMR1ILk72uatlkIcuxPWreLngae5oWYpyBHyxMdO9bepCkVncsncADdEkZ6G1WMBQ2aWY5ToGrsPjspH4DCDrnmK2CupLFuF58h935b90ell+PAnfaKrbP7xD3Pj7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(1076003)(8676002)(107886003)(38350700002)(8936002)(36756003)(316002)(26005)(6512007)(2616005)(186003)(5660300002)(6506007)(6486002)(2906002)(38100700002)(86362001)(4326008)(6666004)(66946007)(66476007)(52116002)(83380400001)(66556008)(508600001)(26583001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x8TDJfLU25SZiJf0hFWxVtItlfYYQo8cxR0EWFNVYSfZQsQhiGKTykcGP4TG?=
 =?us-ascii?Q?yZHFMuXIeoyUHD/j3ouZcw06jFwu3yiWNwMQJYHkuJZ5d+tcus2EN6eO4i+o?=
 =?us-ascii?Q?z9iceBmvw78EkUp02pBS0wR934Ii+J78ydyjfvIfc4dzcVDmpsj4ZvxwI04U?=
 =?us-ascii?Q?GSkfwuyaVmydu93uoYbsN/ErwobRWPJUWFXJS02zC4q+8aFesbbNkYRLa3Aj?=
 =?us-ascii?Q?WwOSXdOH8S9ZCPNLNkbdsz0l1K8AIN5DG6njGateeatYtmzaITc6g/jljWT6?=
 =?us-ascii?Q?6/Xw4hAMdLeLZ9HsWhVu52FrKZyFzZGaoJYuln8gWyL8PbKGfMW0bVFBz3i3?=
 =?us-ascii?Q?5Ro1ptKOpZMhZOvU9jtcxlfZp8pRYBtSq9xH49NVragX4df2gOvY9TVA8Nwt?=
 =?us-ascii?Q?gVwkeBqEeByN+O3+8J3sgtYiqm/iwQRjxn+LmZhFJfYeDh97Nnmr8WPHYlMi?=
 =?us-ascii?Q?zUH2bUAri41KDuzHQPZIpXytI9POgb1Val8FS1Un49Ylld3xwM8GKVnRdh/6?=
 =?us-ascii?Q?UWTskK7xX36ewMRuUHKx1WoZv74V0bURiJxNGjI2LE+z22wyMqYd3esHQtx5?=
 =?us-ascii?Q?mkjFNamZheur2E5U1kN9Da8ElRB5K0tk7SEcqgIT6ELU6+tylQGRuS1rqROp?=
 =?us-ascii?Q?MPkpsg646W++0nptDMjG+ic8QZjrZyPUlMt2Pi5UUPnrb0HeL65cHCYPwf6C?=
 =?us-ascii?Q?LzC4ZDlc3fY/kJf66IuXNlFZNbv/romEAvw7JCSbMLD9Ikqt2XjmeWz7cGHr?=
 =?us-ascii?Q?AyDixmck7qqS4WLzXpeXbTUfRP3YgUQeJfmVEsP4xVUBjdYknCFW5F/7q03R?=
 =?us-ascii?Q?UPHq0xWCGfTevpkmmpzNtr0GfA4Ne91I5R/HLnelaw8WiCvNBia6wleYrRVY?=
 =?us-ascii?Q?dztDAyHvulzDrYjjv7WE6XGX2bvIbRUHZvmiLi0vI9CsJ+bUlKJ8OHNiJn3a?=
 =?us-ascii?Q?GYibZ7Yhhk8eVfMsxpzuIbrrH2pXVMcYi1DLzDvdU1c0BMOOAGOuDHSx9Bn8?=
 =?us-ascii?Q?sC1IdJysXaZFhibDQ4KQaAfI9OFRG3DFDRNyOttBVK+YqXp6jcjzjkJM4owk?=
 =?us-ascii?Q?jonrvBC3YZ76MWVAeoz7kBNaYVADb0Jwl/dUtJtXddPMz6Wb2v0Iz+r8KGDu?=
 =?us-ascii?Q?4VnLGBg/SGMY989s84Cck0JlclOrOut9NismLXGOlTysKKakLVmClOKQ4476?=
 =?us-ascii?Q?b7UiBiYqxg2obTCPndrVAse9rb1Sg0YGBhmmQU0lEY0nq+Ey/rmi8OK2oF30?=
 =?us-ascii?Q?zgkinXMm79zD1O0uRvpcKdu9xLrjbEs462ggTO279lhJSp2iMeB2uneryYcK?=
 =?us-ascii?Q?2y7KsYR57FaVsaPeXHxsKjGYgtC4T9hIm80ZHUbSrjqNyh1g2W+gJcOhq0rv?=
 =?us-ascii?Q?UlRxKQY76gFsKMy6yfdOySS5WFrCWtzNIgtZVw/AxB07LTTOGbG6u1Hsv01V?=
 =?us-ascii?Q?W4Ky4zdXnW4sPZ8UEH0Hni7uSY2XQ8eBY2mt1eeGG5MlG4LsNgJB6fevuveX?=
 =?us-ascii?Q?P3+OqOC7BDWMZvCeL5j5yd3oy0TDKgqBRBKOiyW2DUCnz01ExEWhsad4yDDP?=
 =?us-ascii?Q?v6mwMR6pVoVei3F7uEshPtJEp7yhY+lI23mpka25cc5Gy0uH7IOULRbw493B?=
 =?us-ascii?Q?0YpF8hqZ2TBASTko3wBsPu6afdCegAeRv+GTVdPyZVhi0VVRNyO/ccjsKok9?=
 =?us-ascii?Q?F+Xtf23FoLBPI/Z0Zy1AqYOFazfZUgK9DujVCv/NSTu/4U+1aoz90lVxGueC?=
 =?us-ascii?Q?z9YzhI6DTErBo6HIZmXV8mqZATXHIRs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d09038-21bb-4871-186b-08da36b19d51
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2022 20:29:30.4357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: goZkDohu0LJwErNdyQMHu55Plpd/n+EURWQgWo/unEOI23u/uwtG/nygksYmPE6Vym6fK7KVyAxKAVPf9kfaRTxcsqNUftZzHjM8tyGK204=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2707
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-05-15_11:2022-05-13,
 2022-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205150120
X-Proofpoint-GUID: 2_Mu9H3HgUCSpkOcoJhxzARxeGW9lead
X-Proofpoint-ORIG-GUID: 2_Mu9H3HgUCSpkOcoJhxzARxeGW9lead
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

From: Andrey Ryabinin <arbn@yandex-team.com>

vhost_poll_flush() is a simple wrapper around vhost_work_dev_flush().
It gives wrong impression that we are doing some work over vhost_poll,
while in fact it flushes vhost_poll->dev.
It only complicate understanding of the code and leads to mistakes
like flushing the same vhost_dev several times in a row.

Just remove vhost_poll_flush() and call vhost_work_dev_flush() directly.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
[merge vhost_poll_flush removal from Stefano Garzarella]
Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/net.c   |  4 ++--
 drivers/vhost/test.c  |  2 +-
 drivers/vhost/vhost.c | 12 ++----------
 drivers/vhost/vhost.h |  1 -
 drivers/vhost/vsock.c |  2 +-
 5 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 792ab5f23647..4e55ad8c942a 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1376,8 +1376,8 @@ static void vhost_net_stop(struct vhost_net *n, struct socket **tx_sock,
 
 static void vhost_net_flush_vq(struct vhost_net *n, int index)
 {
-	vhost_poll_flush(n->poll + index);
-	vhost_poll_flush(&n->vqs[index].vq.poll);
+	vhost_work_dev_flush(n->poll[index].dev);
+	vhost_work_dev_flush(n->vqs[index].vq.poll.dev);
 }
 
 static void vhost_net_flush(struct vhost_net *n)
diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 05740cba1cd8..f0ac9e35f5d6 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -146,7 +146,7 @@ static void vhost_test_stop(struct vhost_test *n, void **privatep)
 
 static void vhost_test_flush_vq(struct vhost_test *n, int index)
 {
-	vhost_poll_flush(&n->vqs[index].poll);
+	vhost_work_dev_flush(n->vqs[index].poll.dev);
 }
 
 static void vhost_test_flush(struct vhost_test *n)
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index d02173fb290c..1d84a2818c6f 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -245,14 +245,6 @@ void vhost_work_dev_flush(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_work_dev_flush);
 
-/* Flush any work that has been scheduled. When calling this, don't hold any
- * locks that are also used by the callback. */
-void vhost_poll_flush(struct vhost_poll *poll)
-{
-	vhost_work_dev_flush(poll->dev);
-}
-EXPORT_SYMBOL_GPL(vhost_poll_flush);
-
 void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 {
 	if (!dev->worker)
@@ -663,7 +655,7 @@ void vhost_dev_stop(struct vhost_dev *dev)
 	for (i = 0; i < dev->nvqs; ++i) {
 		if (dev->vqs[i]->kick && dev->vqs[i]->handle_kick) {
 			vhost_poll_stop(&dev->vqs[i]->poll);
-			vhost_poll_flush(&dev->vqs[i]->poll);
+			vhost_work_dev_flush(dev->vqs[i]->poll.dev);
 		}
 	}
 }
@@ -1719,7 +1711,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 	mutex_unlock(&vq->mutex);
 
 	if (pollstop && vq->handle_kick)
-		vhost_poll_flush(&vq->poll);
+		vhost_work_dev_flush(vq->poll.dev);
 	return r;
 }
 EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 638bb640d6b4..aeb8e1ad1496 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -44,7 +44,6 @@ void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
 		     __poll_t mask, struct vhost_dev *dev);
 int vhost_poll_start(struct vhost_poll *poll, struct file *file);
 void vhost_poll_stop(struct vhost_poll *poll);
-void vhost_poll_flush(struct vhost_poll *poll);
 void vhost_poll_queue(struct vhost_poll *poll);
 void vhost_work_dev_flush(struct vhost_dev *dev);
 
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index e6c9d41db1de..a4c8ae92a0fb 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -709,7 +709,7 @@ static void vhost_vsock_flush(struct vhost_vsock *vsock)
 
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++)
 		if (vsock->vqs[i].handle_kick)
-			vhost_poll_flush(&vsock->vqs[i].poll);
+			vhost_work_dev_flush(vsock->vqs[i].poll.dev);
 	vhost_work_dev_flush(&vsock->dev);
 }
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
