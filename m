Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51F5C433F5
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 19:22:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AACF61264
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 19:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9AACF61264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6FF0340255;
	Mon,  4 Oct 2021 19:22:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mSkuaCL3WLXg; Mon,  4 Oct 2021 19:22:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E6FE9402A2;
	Mon,  4 Oct 2021 19:22:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E799C0020;
	Mon,  4 Oct 2021 19:22:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EC3BC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 14152405B3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="gaX1BqMJ";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="LgaXQtQm"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mHiA0VGdBvzW
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C9247405AD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:15 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194IR8iO004481; 
 Mon, 4 Oct 2021 19:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=yG4NO3ds3SUK5GdHkg0gecyx6SihjSiMbEungKPpFjQ=;
 b=gaX1BqMJWQDVh9ufDFIje2GBjVAadLUshiVzxEfZBOzPo8xswjHsAUYy+BCMooczLUd1
 rSJl927cu/bbGLka6TOnREBBRb3FK6OnkMSpvbTGQgRT3JMovGXoSVnPub6eFKCWvw3x
 vPXRenVe/+A9/kCVu7N3fmJw4wdfmHDTWZx2sbwLEO2S5yVBvFqyH99bYwLFuMky+2Dq
 qucmJIxE2x2l0yLzuQNTrBx874bCd9PGkW2/ZVqxjrky4vnOfflTjGhzz/C5VQ7//El0
 BcMfXSxpogjrTv6iqttdvf44lqaBy/TYL+15GwATBjCjdA4gfPh/tOS1PYkjGC3MeFNI oQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bg43dst5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Oct 2021 19:21:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 194JAbkr095280;
 Mon, 4 Oct 2021 19:21:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
 by userp3030.oracle.com with ESMTP id 3bf0s5c7jr-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Oct 2021 19:21:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9xlqUsyPTDQYrS4Sq3V0CsvpsREWJbTC/P0CECNGlKuYS8zOSUinAzdaHguF2N8nyiAm0XGxdb2dUs/JKjU4btpo8mleVVafDmshjLtqVwf3vuqeaEGqV+7PgiC2JqxdxlUk+NhPFMeWV2BqAY4A+H6osZGT0rFU7Opb6XmX5EfM9g9xl9ZKRcvW8M7Uo1EVGVLYBBr2ZWLyXgwV4AyiqHC35AmZokiLh+u3bQ/ZA6T47a0yTJ2wONkVUKrhsoILjnb7A84LTI6rILRNGYLayyc2tCsuWkHXu0eBT0rJK21HmD+2GR4D7a2/5QRhSSvHhLxjCR3z5+CdaIT9mguxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yG4NO3ds3SUK5GdHkg0gecyx6SihjSiMbEungKPpFjQ=;
 b=TuQKLTdvYKuTEcovXINaA/fzvR870NKdywMR9vi+drTqylx1AOSOvQJ8ZAuNtBLNqODvLehyUm7MUXLCq6IBIwTxj6TIBEjZjWo12rc9DpbNAW4VAHoJJ6qEQcrPslHzQrEjOXLz9f1+N6O5nzBbI6ITRH+68zIVq0SeR7MUUmSte2Baz8sDb/i/GiozhvkKdSla76I2ErRZ8h89WsTOo/vw3Xk+QNkUVignA0cgCdlWDHyPQE2HpLHkoYEeuh19IbshOEds7XZJ1Iv9x1hWobQRFh9tF93IndWcreDe0lq/Zn9xOUZO6/3s3hLhAamAMj7/1l4Opb7HhDLTFmZybA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yG4NO3ds3SUK5GdHkg0gecyx6SihjSiMbEungKPpFjQ=;
 b=LgaXQtQmyQLCT3v1gJfrvSk/guBhn3Uf0aFBBa1XD6gplHd7D0bmLNtiXj1dGiIly4Pfh3z5ehhalnnF6vE40S6qVf8ey1KL16Y1ZCgjZMPZIuKsaZ5KMzXfF6XXCbwvvKSRoCIKJBMnrSX+eud1hfZz34ywPAnuoOaes/JKp2g=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1548.namprd10.prod.outlook.com (2603:10b6:3:13::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14; Mon, 4 Oct 2021 19:21:42 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 19:21:42 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V3 7/9] fork: Add worker flag to ignore signals
Date: Mon,  4 Oct 2021 14:21:26 -0500
Message-Id: <20211004192128.381453-8-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004192128.381453-1-michael.christie@oracle.com>
References: <20211004192128.381453-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM5PR15CA0034.namprd15.prod.outlook.com
 (2603:10b6:4:4b::20) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR15CA0034.namprd15.prod.outlook.com (2603:10b6:4:4b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15 via Frontend Transport; Mon, 4 Oct 2021 19:21:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe0a153b-0cb9-4213-ffa2-08d9876c3264
X-MS-TrafficTypeDiagnostic: DM5PR10MB1548:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB1548C8CB0690F94820176CB0F1AE9@DM5PR10MB1548.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /O9J52bJ1D9uTGxrLRBzWBvGNaM4nH62j4tjSnwXhchlZPG9pwwy3xZJ39bqf8fYFVrz8jQr32Sk5Pd5/z5Im27yXIkraMkFMrJ+38jTZepqUGuQmst3XAt8XOjfyXfy6jAd1jbeUDbB6+MqhBgMeIPxA8aFlm2AgRuspayTrlkvGmQA2HFeYB3+8xi+BvWKiLkuUi0IbbJwDpqMN7MFxTBdHOEs0IAL5sYoxtn+RMfl7caXjvwcRgNOyPMF0pfV/bl1+FsNNubiFFilyfQuowocBGeYQLoc+8oE4gCJ0wkd7kLBr+4h+zV2ak7Vzgm8h/t/yxUtRAdhd2gswfKHY7CMYcPkXqI0I3Vq6F3S94whO21JYkevXmyA9RUj0gI0KfPkll+w7wSWfHW9SzNtq9hnaeZaHOHbR1sP+X956BtzmsK0b4c+ynXgCUoBeK/cn3uwXo9NiJlktRokl+BUNgRgg+K27gKS2VXjE76lo13b35uGIgEwY7kEzMAYjE2LSyp5DBiVayJroUkNWYzZrcCiu5U6SIfly25Xxnw+IIHBFBPAP+vWYy7UfKrlWlP49XbmWZWrFUexpkDuZ1UWW7sqvR7lOwWRhhJN7pVuxF+yV/mkfvj8p8AGaAhLa7TOkvrTfkTBEhc3tKSuFBjA0dFvKgq9CTmivlKtstnNyF/5imcwNLcfRsPecaP8/ZY2qiW7toX5K80ZYRqWhjka8+MFUhEzB3VpMTD3DRkke2k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(83380400001)(8676002)(921005)(7416002)(186003)(38100700002)(38350700002)(6506007)(8936002)(4326008)(26005)(508600001)(2906002)(6512007)(6666004)(86362001)(316002)(52116002)(1076003)(36756003)(66476007)(66556008)(66946007)(107886003)(2616005)(956004)(6486002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fb1o2BP1/EXevwYNxePdt0LbtrB4i1vInrHg2iCVgpZpKDEwHemHfTZ8+pzm?=
 =?us-ascii?Q?aMRmK/Qbb6EpGQC0iXswzt88WdcYhIW2YTbhZynk3JqI9SAuxBEC79/8KT6U?=
 =?us-ascii?Q?NWsDRs1f4a+7CMxvVUPLWy6LAGr8zY11lSYHAX+u8pjSmotXdHxL8LzcvOwC?=
 =?us-ascii?Q?mOJLeeJD7g7WvcwoqOP70lnHmqvlDx2XMbIWDQSevVssm/+AzDF1arV4n9B9?=
 =?us-ascii?Q?2id/1Lhj/ExsSZqxiDuWn6b2jt4Iv0bbLsHf9j92VSkVzT0My2thgQoaFoLh?=
 =?us-ascii?Q?PMScU/mddsMeC+nZosLCVeoBPdnj4uJcjsoWmo1txQ4HzwEXR2jTsmF8mBB1?=
 =?us-ascii?Q?TM3jtwtB/rnuWNlqOn+UO8YOj//LGlV6wsI7YhuqOAmGxwqbIX2hKoZeXBqE?=
 =?us-ascii?Q?k6MMxKv/qWEh1nbn705jebpw/VKb95ZwXuk3EKS0jlUsiMFHIaPO8tHO6Djl?=
 =?us-ascii?Q?dR9jf+8MdAptvMXIWV1jWfqyFZcUrdUwECWUcY/XAw/bTPkcxmhpU5vWitrP?=
 =?us-ascii?Q?iyZDsewliTTPNB7eFuo+sBa2vZgfVuEi70AdWfMGDPwHAJOg7PoeHlnbm9qm?=
 =?us-ascii?Q?g3982ossxO0Mv1fK+8b76dM/17nfSQ6UkpEWyiEgYRoumn82Ku2Py4n/6J1K?=
 =?us-ascii?Q?Zlxyltcm1nkv6pNgFSqvMSgAf4wzyKc5yRdsJPLNNmvgW1l9PuMpjbGQ11DH?=
 =?us-ascii?Q?GpVgmsRBwzq3iau0W0fCMxrGgEua+OPRy9NIPCz9nucthcvjh7SPc7W0cizw?=
 =?us-ascii?Q?y+Ci9uconvXfan1MhknhP+Rupmpcpo+f+VLbMnf1CC/8dw/Ns+0wC89MnUvE?=
 =?us-ascii?Q?CFYJ4m1MpmFTVkURw3NjO6d5JXYnI85SA4Z7doCStTOqYd6aFwxYDLUL7j3H?=
 =?us-ascii?Q?lwRTjxcvBiUJ7see6HZ4LvYsE5TXrqdeUsAKKtw0FPl8JBHjYRUPbQM3QWtE?=
 =?us-ascii?Q?IupxN6v8d76kaN0NhLMung4dRBLZ0P3rOz5ZvOSTooWzcTVjxZ/usAO3IjLN?=
 =?us-ascii?Q?hrQG+/ScLIw7+23cY7w6y/KTD8EfkYnqeEo5oCrWE6bUK4pTLjCR21rxfcyd?=
 =?us-ascii?Q?8TpiwoRhBeOuYzi3nnlmWyuNF8huukw9jKIYz3FDJNyzx9o318lQtStmGiEF?=
 =?us-ascii?Q?vTiHAOfOTK3QTiNGbAzDsNuS7IhF2vkMNiFHLPOQtxengqYHm8ELkefdzHTS?=
 =?us-ascii?Q?FPzOLHVVIC6PXj2KivgN63O3KFDumDwpXhk1hLas2RLYL+4euF6b1tUKT8mf?=
 =?us-ascii?Q?m+ouli0I56wmkYTM0OvJCn4e7ERJ0PchKhK+GMDd27bZaBvH9fnSWPrrnMHN?=
 =?us-ascii?Q?QOia4xu75dLimQ9TNB4TzDaQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0a153b-0cb9-4213-ffa2-08d9876c3264
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 19:21:42.2812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eaIprhTByqsLVm1EcW/mitElPCI+/WpuYcHFwGHQsssxUwu3L4w4jpgzN2MCSxJuviDCPoEYhnc4SdCwy53XtmkUgGHlar8NisBfJDExhiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1548
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110040131
X-Proofpoint-GUID: jXxhT5Pc-wXPFq5CUUyMxu6dFucHhroT
X-Proofpoint-ORIG-GUID: jXxhT5Pc-wXPFq5CUUyMxu6dFucHhroT
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

The kthread API creates threads that ignore all signals by default so
modules like vhost that will move from that API to kernel_worker will
not be expecting them. This patch adds a worker flag that tells
kernel_worker to setup the task to ignore signals.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/sched/task.h |  1 +
 kernel/fork.c              | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 781abbc1c288..aefa0d221b57 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -21,6 +21,7 @@ struct css_set;
 #define KERN_WORKER_IO		BIT(0)
 #define KERN_WORKER_USER	BIT(1)
 #define KERN_WORKER_NO_FILES	BIT(2)
+#define KERN_WORKER_NO_SIGS	BIT(3)
 
 struct kernel_clone_args {
 	u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index 3f3fcabffa5f..34d3dca70cfb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2555,6 +2555,8 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 struct task_struct *kernel_worker(int (*fn)(void *), void *arg, int node,
 				  unsigned long clone_flags, u32 worker_flags)
 {
+	struct task_struct *tsk;
+
 	struct kernel_clone_args args = {
 		.flags		= ((lower_32_bits(clone_flags) | CLONE_VM |
 				   CLONE_UNTRACED) & ~CSIGNAL),
@@ -2564,7 +2566,14 @@ struct task_struct *kernel_worker(int (*fn)(void *), void *arg, int node,
 		.worker_flags	= KERN_WORKER_USER | worker_flags,
 	};
 
-	return copy_process(NULL, 0, node, &args);
+	tsk = copy_process(NULL, 0, node, &args);
+	if (IS_ERR(tsk))
+		return tsk;
+
+	if (worker_flags & KERN_WORKER_NO_SIGS)
+		ignore_signals(tsk);
+
+	return tsk;
 }
 EXPORT_SYMBOL_GPL(kernel_worker);
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
