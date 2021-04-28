Return-Path: <SRS0=6MyX=JZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADD9C433B4
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C51146143B
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51146143B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86918844DF;
	Wed, 28 Apr 2021 22:37:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 85Xa5Wz6d5wm; Wed, 28 Apr 2021 22:37:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00CF3844E1;
	Wed, 28 Apr 2021 22:37:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0CD7C000D;
	Wed, 28 Apr 2021 22:37:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9547C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 800974188F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="VFbdNQvX";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="kX6iurCt"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Rpe5W_l6Y-b
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 40ECE41894
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:42 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMV5E9127313;
 Wed, 28 Apr 2021 22:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=5c/kllAg/R+dCaTGIvLr+PqoEw405b9SIL7zEDY2Wak=;
 b=VFbdNQvXt8Cbe94L++KZapJxA1ejA6pa/n/5+XYyxeksfEMG4c6ZasU9Z6KqiGevUj5F
 kdLw8WuSZ9t23BpvgvWXuQSBH7rEilzP/b0wmMngNsETTEP/eLJMLlB0b7O3NJ0lkWfz
 SNxVeK30/VUXyfSlRQSzD8mtptgtUULHAY21RUM1EHrDBPM20dK9jur8zAeR85UW//ng
 7c6LugaSsAGdJ+Xy3NlnzlHKxnwiscgNG5z6ohLkkNcPUBToeyfiwCTp4vg4QuZa0IUw
 KOAkCjzaDzwyNwBx12VQ0YJOfu3JyAJDKb7rfv4MaMJ8X9DU76DNN81Sm9FWmZSZl4Dd 5A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 385afq2k4m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMUmEE043084;
 Wed, 28 Apr 2021 22:37:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
 by aserp3030.oracle.com with ESMTP id 3874d2pbek-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lt8OX3NVL/oBTOtgmboQaR3s/pUHww82QdOgjr2OiaIjYZ4An4gPsncNgT1UyuoP46zihejc0DgEab48zL8N9IV0SKiR3eImGWFk5p26SMG/5XPcfw5dm8taaN08C8gxXStPI9WOmyi5wX71XDv/aVhy/Czdx4D3THUDuNSCPbUXPS5up+YlWt/Yi2BLL7+ldXDcVn22Ke4Mn6T/Npz073T582mHQxxg1ITnieLDHY1/Eu5RgmU7EkoWzzcATyQNkAWACMy0sha9+m2Ozs9bAEiYMWC2iIDYMgHKgtK/6wm6p99/rLjNTwRu/j8/Cb4kMELbzLblhr1RY1mNCYjI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5c/kllAg/R+dCaTGIvLr+PqoEw405b9SIL7zEDY2Wak=;
 b=hnpfcDQNieLS+/trql4WBhYKMRmvhbMn5whNFUzzfEdHGQix9AH0eVL30ei+ABYMneykc1mYo7v4QkSYr/BM6qG0y/PUQHep/pC+aZ81aqgLS8kusQTC0NvyFHXUubftF+ddcZ60qEK3Ijz0TqCQtj2YC6AAaKRwVSDUvh0sqG0rTFindlE//0PRz41T6X3RsSc4wuayO++lZior4dfEhAlYwe+nSAc8ylKpi9TYLkb2aAZb3EfWczW9EPm8tvz/KmVGATe6cKbCm0QeqTf4YJUTL1GrkGrNVb1BoFq0Iv1lxb8oWe15JTJaRD1X+kPJJFcRGOg6oVw/anqo+Nm2yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5c/kllAg/R+dCaTGIvLr+PqoEw405b9SIL7zEDY2Wak=;
 b=kX6iurCtC/YTxHpP6IGiY7sc3GojRXgVVtw2u0fAC19VNghe1+wLlp5+hZBbupcZNE4KlJhE57baNl2zRDHe5GL13Qt8K7SeDdDJU2oLOMKnnzEL2l5wvDn3pY5XgmCns/ciPhR7WgZA+XimCStK3TFs0BSCtWWxmbI+cWBAgA4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 22:37:39 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4%7]) with mapi id 15.20.4087.025; Wed, 28 Apr 2021
 22:37:39 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 12/14] vhost: add vhost_dev pointer to vhost_work
Date: Wed, 28 Apr 2021 17:37:12 -0500
Message-Id: <20210428223714.110486-14-michael.christie@oracle.com>
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
 15.20.4065.22 via Frontend Transport; Wed, 28 Apr 2021 22:37:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e3cbcbb-263a-4eb4-81e7-08d90a963a5d
X-MS-TrafficTypeDiagnostic: BY5PR10MB3794:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB379468F00DD737E61AB3F3B7F1409@BY5PR10MB3794.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:291;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ur17mN/PNrnnIIdEmJjNXoErb7MoKu3/sXthqMtZcvQMxEvHUKYTPLfiiVvpzqNvpqG5Aru8qTIBZhPuAZ/3nEQDMv9B/z5lnJDy4Y8XIVXsOVc0V6W4E+fqh6bd/UsKBC0Fj5+euzOgCQHdC3gmv04p0Lxv3fVAtrDZzHFAsO6sZhk/cFaQYHJlzkLO84m+ubPEgGA5cDhstND5XFNjX46dtjOkt1Y70IzMsSiHIS8DL4Uay80fNXDCwYFJviVL9LixkH20e0up/Of7XgCEnkLkrWBgLq71zvFH8S8Z5+gjI24b5EzqdzD62T0v+xRPs2a0wFiVJLj+y1ZLRPHgFXICZhTgGAI0/ppxEZa/yT6XYynNbRXqGw8RjGZOnY4zqxZPe5Z7LxMd3s04nfnw0LaOgXIAGtoB4dbLzj3VjYiS9C9TvxheQjuQh8i6pMKJbiYHj940zW8r8yvx784LR3KYApSqQYiOxZjSeRjYTpE6188C9T8/zEiU3WaEgvjjbQkJzQRmLLE25KZgX4rZkFFUGdNqhZ4WJlm7BrSXbzrTwzYY4jhh2MKuOhAUHBbo6Rst0U4qV2jOymZdlXsSnadbxeMl/RxFQGQwQY17mhU8aLpnHT7fsO3FsH5BY3tMhfSESzzUGkWjys913UsNvY9kvwIO3k03vRLlVXAwShRbCmGUm+wPaKa4YqpyG6eT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(39860400002)(136003)(366004)(376002)(396003)(26005)(1076003)(186003)(16526019)(6666004)(107886003)(83380400001)(86362001)(6512007)(8936002)(316002)(36756003)(52116002)(6506007)(2906002)(6486002)(956004)(38100700002)(478600001)(66476007)(4326008)(2616005)(5660300002)(66946007)(38350700002)(8676002)(66556008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3fknnbRvp2HZ8GX+hRIhto33YPVXEQSIRh3ygEIUkRGMI99IHYH2TChjQNR6?=
 =?us-ascii?Q?VSuxY3W0MUUj6SA9/BC6f4GClE8Aco6UqiPzU0RNWa7hxizJ6+ATfNmtTCOu?=
 =?us-ascii?Q?OOzfgO1N+julsAYYHrLu+3noTCPu3xCGaZV8TT7Fc8X5tfpKLFd2Y0Pfjlx3?=
 =?us-ascii?Q?ldd+YfQKP/zAm1RGsQOkOgQcSVbIFPp3YsLRCihgWmMSH3zsZUtqeW1JpSaw?=
 =?us-ascii?Q?oXhMdXAVC9jp0Q0/lglYzYYaP28qD4xflYQ6vvayUMwWofEJh4v4h03DNkkw?=
 =?us-ascii?Q?aMTepQWJ1fBv/T1WhKOyx1Yd8UDz4cJbkZQnakvICD4GeCq5LWo6uQBJkxQ2?=
 =?us-ascii?Q?InFqznElU/wOxR9x4jLoQiyDhbND/JIsnxSJhqcnskOebYcKJ4l1v9fe9St+?=
 =?us-ascii?Q?bC65OnyNUMy2+qBQChjPk+aUBj4XRvTPqfA1iujM74Sdrt5+4gowZ1DfzmP7?=
 =?us-ascii?Q?Mwl6I+wp9sbF2WTcjiYciAnOZDlLGi6fgu+dV5bHvMPfNYeEVJwoyy5dHQIu?=
 =?us-ascii?Q?mu+4X7wRdxjmTCGhDh4vkvmviSz/gjpRWJy5gQ7f18+gVwC+CltvMpYxnJVZ?=
 =?us-ascii?Q?BN0hS+Volrqs3vWH9+V6tk4cVuyq6cZfkuSbqfFynB+rSmqPIiUBu63zUNbu?=
 =?us-ascii?Q?VaIhp4cX1n/550LzUHlLhz8+N1mz4kTQqI5TdMbGsPJ5DYDWJrtOSAwX5+bf?=
 =?us-ascii?Q?IurE/PaDRJpPc2q60wf89CC/hTauj8QwhLyFd2U3B6TTJmz6+sXDxeQ56u56?=
 =?us-ascii?Q?D2tmPDL9TZ3MXaFvTwulh3CYXbYUCRlvTWhXQvVOpiXbDKPuOM++AF0CNCT/?=
 =?us-ascii?Q?vyxVW79d3iFk4FiO+ZdtEEoRTuDedNpvxZJq63dz0VV84MHWuXUFCeKJJdbm?=
 =?us-ascii?Q?3IpzwWn5s/M4Bo9/CEQ8G74nJ5pLbSFW2UsZK7P7vNgSey/u2w5GmxK2Xfhj?=
 =?us-ascii?Q?acU5UWhBF4Qy8NUbkiVs4fl+hf1WtxIOtLyHGAUXyC2COjK6YSqqKsOoHBa7?=
 =?us-ascii?Q?w/CqvvHY8rt5XLhXe8X3O1v62pluGNYg/MUvHltCGErhjqnknb4yatfK5Uni?=
 =?us-ascii?Q?XoriQrtnGdbMNt72vdBy2bou/mZsvd+N7UsXwdQ6GQnSb4UFXJZXJrXwNR9A?=
 =?us-ascii?Q?8z74RM9JDUSppljVeNw0POR5tWP/gtuxqDvlHAE7UDim7QUo2pucMRDIdCdf?=
 =?us-ascii?Q?vfYu5A9//4Z96IoHqngd3jnhgBgixMwcQ3BuBuSVeFe2YBsd0sKFp1yMKEa9?=
 =?us-ascii?Q?4rt5M14ODoHX2WbdN5Z18/I1a5HBanCtLZaqjg5eLujoTOPv69NMe1wB7EB/?=
 =?us-ascii?Q?btBsC51N+evK/rHiNJAIUVFp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3cbcbb-263a-4eb4-81e7-08d90a963a5d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 22:37:39.3772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LlAa19Cj44MbmhFQCk1udyCEgqAJPam0qJ6Q/JaCQ/znoNcswXmDx1JPHRPlm6jTubeuimprp5GaRhjbbrfYOm4fHO2EbsVK51F8XGY5bbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3794
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280144
X-Proofpoint-ORIG-GUID: cL2UDDBkPvt3kwPGmeohAEyas9EkoGct
X-Proofpoint-GUID: cL2UDDBkPvt3kwPGmeohAEyas9EkoGct
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

The next patch allows a vhost_worker to handle different devices. To
prepare for that, this patch adds a pointer to the device on the work so
we can get to the different mms in the vhost_worker thread.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c  |  7 ++++---
 drivers/vhost/vhost.c | 24 ++++++++++++++----------
 drivers/vhost/vhost.h | 10 ++++++----
 drivers/vhost/vsock.c |  3 ++-
 4 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 2f84cf602ab3..0e862503b6a8 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1808,7 +1808,7 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 	if (!vqs)
 		goto err_vqs;
 
-	vhost_work_init(&vs->vs_event_work, vhost_scsi_evt_work);
+	vhost_work_init(&vs->dev, &vs->vs_event_work, vhost_scsi_evt_work);
 
 	vs->vs_events_nr = 0;
 	vs->vs_events_missed = false;
@@ -1823,7 +1823,7 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 		vqs[i] = &svq->vq;
 		svq->vs = vs;
 		init_llist_head(&svq->completion_list);
-		vhost_work_init(&svq->completion_work,
+		vhost_work_init(&vs->dev, &svq->completion_work,
 				vhost_scsi_complete_cmd_work);
 		svq->vq.handle_kick = vhost_scsi_handle_kick;
 	}
@@ -2017,7 +2017,8 @@ static int vhost_scsi_port_link(struct se_portal_group *se_tpg,
 	if (!tmf)
 		return -ENOMEM;
 	INIT_LIST_HEAD(&tmf->queue_entry);
-	vhost_work_init(&tmf->vwork, vhost_scsi_tmf_resp_work);
+	vhost_work_init(&tpg->vhost_scsi->dev, &tmf->vwork,
+			 vhost_scsi_tmf_resp_work);
 
 	mutex_lock(&vhost_scsi_mutex);
 
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index fecdae0d18c7..7ba0c303bb98 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -181,10 +181,12 @@ static int vhost_poll_wakeup(wait_queue_entry_t *wait, unsigned mode, int sync,
 	return 0;
 }
 
-void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn)
+void vhost_work_init(struct vhost_dev *dev, struct vhost_work *work,
+		     vhost_work_fn_t fn)
 {
 	clear_bit(VHOST_WORK_QUEUED, &work->flags);
 	work->fn = fn;
+	work->dev = dev;
 }
 EXPORT_SYMBOL_GPL(vhost_work_init);
 
@@ -200,7 +202,7 @@ void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
 	poll->wqh = NULL;
 	poll->vq = vq;
 
-	vhost_work_init(&poll->work, fn);
+	vhost_work_init(dev, &poll->work, fn);
 }
 EXPORT_SYMBOL_GPL(vhost_poll_init);
 
@@ -269,12 +271,13 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 }
 EXPORT_SYMBOL_GPL(vhost_work_queue);
 
-static void vhost_work_dev_flush_on(struct vhost_worker *worker)
+static void vhost_work_dev_flush_on(struct vhost_dev *dev,
+				    struct vhost_worker *worker)
 {
 	struct vhost_flush_struct flush;
 
 	init_completion(&flush.wait_event);
-	vhost_work_init(&flush.work, vhost_flush_work);
+	vhost_work_init(dev, &flush.work, vhost_flush_work);
 
 	vhost_work_queue_on(&flush.work, worker);
 	wait_for_completion(&flush.wait_event);
@@ -285,7 +288,7 @@ void vhost_work_dev_flush(struct vhost_dev *dev)
 	int i;
 
 	for (i = 0; i < dev->num_workers; i++)
-		vhost_work_dev_flush_on(dev->workers[i]);
+		vhost_work_dev_flush_on(dev, dev->workers[i]);
 }
 EXPORT_SYMBOL_GPL(vhost_work_dev_flush);
 
@@ -305,7 +308,7 @@ EXPORT_SYMBOL_GPL(vhost_has_work);
 
 void vhost_vq_work_flush(struct vhost_virtqueue *vq)
 {
-	vhost_work_dev_flush_on(vq->worker);
+	vhost_work_dev_flush_on(vq->dev, vq->worker);
 }
 EXPORT_SYMBOL_GPL(vhost_vq_work_flush);
 
@@ -572,14 +575,15 @@ static void vhost_attach_cgroups_work(struct vhost_work *work)
 	s->ret = cgroup_attach_task_all(s->owner, current);
 }
 
-static int vhost_attach_cgroups_on(struct vhost_worker *worker)
+static int vhost_attach_cgroups_on(struct vhost_dev *dev,
+				   struct vhost_worker *worker)
 {
 	struct vhost_attach_cgroups_struct attach;
 
 	attach.owner = current;
-	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
+	vhost_work_init(dev, &attach.work, vhost_attach_cgroups_work);
 	vhost_work_queue_on(&attach.work, worker);
-	vhost_work_dev_flush_on(worker);
+	vhost_work_dev_flush_on(dev, worker);
 	return attach.ret;
 }
 
@@ -673,7 +677,7 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 	worker->task = task;
 	wake_up_process(task); /* avoid contributing to loadavg */
 
-	ret = vhost_attach_cgroups_on(worker);
+	ret = vhost_attach_cgroups_on(dev, worker);
 	if (ret)
 		goto stop_worker;
 
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 64dc00337389..051dea4e3ab6 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -21,9 +21,10 @@ typedef void (*vhost_work_fn_t)(struct vhost_work *work);
 
 #define VHOST_WORK_QUEUED 1
 struct vhost_work {
-	struct llist_node	  node;
-	vhost_work_fn_t		  fn;
-	unsigned long		  flags;
+	struct llist_node	node;
+	vhost_work_fn_t		fn;
+	unsigned long		flags;
+	struct vhost_dev	*dev;
 };
 
 struct vhost_worker {
@@ -47,7 +48,8 @@ struct vhost_poll {
 	struct vhost_virtqueue	*vq;
 };
 
-void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn);
+void vhost_work_init(struct vhost_dev *dev, struct vhost_work *work,
+		     vhost_work_fn_t fn);
 void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work);
 bool vhost_has_work(struct vhost_dev *dev);
 void vhost_vq_work_flush(struct vhost_virtqueue *vq);
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index f954f4d29c95..302415b6460b 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -648,7 +648,8 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	file->private_data = vsock;
 	spin_lock_init(&vsock->send_pkt_list_lock);
 	INIT_LIST_HEAD(&vsock->send_pkt_list);
-	vhost_work_init(&vsock->send_pkt_work, vhost_transport_send_pkt_work);
+	vhost_work_init(&vsock->dev, &vsock->send_pkt_work,
+			vhost_transport_send_pkt_work);
 	return 0;
 
 out:
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
