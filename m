Return-Path: <SRS0=YcCX=LS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1BEC48BC2
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 03:08:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2810D613B4
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 03:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2810D613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E578F40223;
	Thu, 24 Jun 2021 03:08:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vKhUHP1Qz3hv; Thu, 24 Jun 2021 03:08:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DFAD94025C;
	Thu, 24 Jun 2021 03:08:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD061C001A;
	Thu, 24 Jun 2021 03:08:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6028FC0022
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 03:08:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4BC99839E0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 03:08:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="LQtMcmMv";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="aDXW9g6l"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L0sFg7WAJSr5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 03:08:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56C93839B8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 03:08:33 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15O36xGl028306; Thu, 24 Jun 2021 03:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=N3ua3Y70ZKiRuFePQ5YrILWJBN/jJWlkLQRq8b/6hAc=;
 b=LQtMcmMv/WZUh9XNPqQc1Kwusbs3LZatzB9b7JeWI3VI0IscxxYlaFUalXkUvENdh8Ju
 kQG4ybjuaqPqyS7a7YaG0a1Qky/vEFy8g6PF7u9uqCq53nzm+hSOtpv5IzCTsPKCz3XR
 Bo5lG9Cll779UO+w1A6U5S2WQ5lb7iDX+5FoUndH04W54VY5YojXCAXJAMTkZF54NheK
 CLu/SKIp0LQc0pY5HcWspK3RSD8m1hjDPZmL+csp0Ma71J5mdO0JCKeKXi2h078Pd0kN
 +z6wYjRHT5sLcaKXVe6qVQvMGjVYqn1m+qFMvJB14pK7gTgWUhvqifNJaafK4yBVC+iF fQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 39cd2krb3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jun 2021 03:08:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15O31Xuh096615;
 Thu, 24 Jun 2021 03:08:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
 by aserp3020.oracle.com with ESMTP id 3998d9xm8h-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jun 2021 03:08:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2GX1NtvAKVCJrnRVw2+VGyyP2t+DkBTm6oS0x2wFEQv86ORfF2JBCLJhsJtnhu64YY4EWOb7JRhfe6L6fQCUuyaBshSqW4IYY7Vtr6w+GU23oDtK3ZMbM/sNAc6mhh4JqfCf64gD6XO0yCvSH1iHIcXJvqo0mNLp+NOKjbVqTv1Jn0ygZ4k0GgghauMB4pRj+ztnHZdOZMxf9+g9v9IZQ8MOsSQHkMLqGWMNVZ0W+mkO29DCtNfMBHJgRSDsud2B0xlGXT2iT8ZXdpYE8OJo28icBYGSkr6hqmzMp09u5TBW+yjKg90m11yPabWGgBeHHaSM1ZvOWvAENwae8H2Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3ua3Y70ZKiRuFePQ5YrILWJBN/jJWlkLQRq8b/6hAc=;
 b=VBEGiF5DHRwY0If4n82j4p2E6VNyVn/NN0o7qOrjHCWd1rOmUE3vtjPzqaqhEXJ8u+133YyJTw+jFBFju6r7Fnz04WGaHmtqUsku//tq2+ax6uPmvyNu0y7awig3dM+K38TnkAg2o82BHa/551Wb9RmVc0iWcXdWSO9ac+Ow+ZnzICB1nyN4qF/kMeDmqxqRLBOX/7QTa7R3yauXF70QL1Vz6FbFyt7HOKOv/HcBboKf2Hwa6oNLJ4vA3GGcelXdnYCmSxDwsUo4S5SPRI2k7ru+qNkUcYOVoqxtR44xduuj7RCMaA70ciEE4v+2QlE6iaRJBsf0VgC0hfJdURmE3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3ua3Y70ZKiRuFePQ5YrILWJBN/jJWlkLQRq8b/6hAc=;
 b=aDXW9g6lz6VyYD1zf9S8CLLTchqKW+bYJsTNtgNp7QDe5K21pD+8qE0qhFgTSNUS9FVblpz61VWTlvkqhGC7gcFMoMldhaximheX43J0IzPQpDB22kFBGoEYS296Gghy0f1yX1WjhGFE5HW8Pr2WpaLVkyVcNTKQJvpyiYNkcuM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none; vger.kernel.org; dmarc=none action=none header.from=oracle.com; 
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB2837.namprd10.prod.outlook.com (2603:10b6:a03:81::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 03:08:17 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::b09d:e36a:4258:d3d0]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::b09d:e36a:4258:d3d0%7]) with mapi id 15.20.4242.025; Thu, 24 Jun 2021
 03:08:17 +0000
From: Mike Christie <michael.christie@oracle.com>
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com,
 stefanha@redhat.com, christian@brauner.io, akpm@linux-foundation.org,
 peterz@infradead.org, christian.brauner@ubuntu.com
Subject: [PATCH 1/3] kthread: allow caller to pass in user_struct
Date: Wed, 23 Jun 2021 22:08:02 -0500
Message-Id: <20210624030804.4932-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210624030804.4932-1-michael.christie@oracle.com>
References: <20210624030804.4932-1-michael.christie@oracle.com>
X-Originating-IP: [73.88.28.6]
X-ClientProxiedBy: DM5PR2001CA0008.namprd20.prod.outlook.com
 (2603:10b6:4:16::18) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR2001CA0008.namprd20.prod.outlook.com (2603:10b6:4:16::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 03:08:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bd5324c-5ac7-4b0c-4cf1-08d936bd4ff7
X-MS-TrafficTypeDiagnostic: BYAPR10MB2837:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB283721F8E2AAEF4EC430D911F1079@BYAPR10MB2837.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Coxzz4ho6TdG/MKgZ6Ggfrq1NVUG2T44S6uWc6CJ6vaJ6TYGcg7b4IA8bL2QlEWk2YfcI1NLU3mkHeR4bjRRjqP6hFj6MUzVfTKvcfas8A3eKWUkQe/kUt0Yl0dd/xGhsBuo8ftFMAyru4jB0OZOVbW8FHBFr/CZ4mT45vDtEoLWDJLCfAu5rOeXCw54XxqABVngfeVuSsNCZmQD5V4ToC1mjXTY9JYuG/AAN3jST6jsOB2xA6ihAG+PkjhGG76Z2UXBmg/gmOos4q3Es5h9yhm4zA/7JJUGadZqQ27GTctxAQR07ZJd/9A5ned5zbyRfRtzlHY+MhGLMbJ3e+sU+5jrcVJza8TXN+zz9Qm3VZBabfKRIpSMqqrWaTv0UPYj4uTFOdm3ibz/vk66tzRWqptwTg41Aoh+rrjEVHMXl5vzeF4harOdwMi6CR9j9cjE26RD/xuSDbn1UTOAlvuaPqHt+e3L+ijghSqHjloiQUYJQrLc4W14IiT4QoF4W5yr/K3eYOEq+r2DKYP3feX4XqVPEO1zLaesE13xuhHi78wm5LAdDvvRno8T0gh2WKfEAVQ8bejjPj6VPWZPKc3CLPYzD6CywrlA6WK5xJDy1cZkPNBVX43LiSTMjg2td0icaGGLEE2niRwlpgRFCk1r+c4l82uxGY+7DgUtlWMH3tF3VTuapegjHv8P2R9byel3wPARIr86k+PCxE64lEcmNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(396003)(136003)(346002)(376002)(39860400002)(66946007)(66476007)(66556008)(5660300002)(2906002)(2616005)(6512007)(4326008)(26005)(6506007)(316002)(186003)(52116002)(16526019)(956004)(1076003)(7416002)(8676002)(478600001)(38350700002)(38100700002)(921005)(83380400001)(6666004)(8936002)(6486002)(107886003)(36756003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8GBC5q3vE/gn93HQgaYZh5PPHqiSjIVbqH8f2ac+8kMNJtk7EhaFdMJWOJUZ?=
 =?us-ascii?Q?9FHH8yFicylJfnEtiwN3pc4OxWTC9b0kuh6SnP+YkVcbfChwDQ02ok9TZdvs?=
 =?us-ascii?Q?Jm9n/Lh4yIKSVrzOw/Bamfma5r2Xa7YBVScGfUtNIsPzhTb5xoJbI9UACmGr?=
 =?us-ascii?Q?a4iF1p/IlyVcpPVClqy4S2zFIqkw0Cqx9MuAen6GW18eZiBaj6zFQg3IS9kg?=
 =?us-ascii?Q?2VPgWIDzWtVnnXHLg6sNcH75xroIs01Q7lpsqeLcMDz4u8avv7oGqHRjCzY0?=
 =?us-ascii?Q?0v1FogaH4Q03X5fSJrmUMEd/eLKRrfj1LCZsBZy+ffXe4joB/Gu5odViQQP3?=
 =?us-ascii?Q?P6zBfaq/WiTINrEZ3YAL+JYHa8E/UoTB3x1JXM78vE1Y6Lkv29ls6zgiKHUN?=
 =?us-ascii?Q?xAL82R+OGHheUo3oJ0MHxMZT7yfabNpgDaFHP9yBNl6oj+qqwoHv64OTuNaT?=
 =?us-ascii?Q?ye2j5RLGphruejQE+8JEXD2mGiw+x3hdeF7Hopb4I4ZKxOaPRGUAu1vzRKhV?=
 =?us-ascii?Q?TyAyNpmXbYaHahaFNe7uEHY+e4otJD7tJ8IPK/9tqKEVahbRXzN9E2FWD0E4?=
 =?us-ascii?Q?qJ4mLUNC8dOrdUp8XuPcc+LbqzxlCzpWkK8R0rjZzeKxcRCfR7qQiCpgNl56?=
 =?us-ascii?Q?0++okjxHrJTCH6iM8lHHF6cXgCv0PyUcEyii7fYnhlFn8WMvY3u1voy8HqY9?=
 =?us-ascii?Q?e9JAPuc2YMSjRtHjt2vpqSsqRldDa3oCooddL1MTcxrTChpG1Tfm9iNhoBT/?=
 =?us-ascii?Q?Rrq4+f8NhCz0Y9fNha+vU/dd8FGVlh0+UoxDvQ4AtTCQtqFoUcgON1/rMrph?=
 =?us-ascii?Q?AzMf83PtFnMvBabG3A307MUUpG9XRBq8m3oKcvpRvfYyOnNrxpkM8niYvDh5?=
 =?us-ascii?Q?NegPdOXFXDpZjAGJc8KIQTA3qcDOXvemPLyBmi4rp9G8aH0tT4U0ybvoNnSm?=
 =?us-ascii?Q?lA3P7RWXGEf3TQePXcBNyUPeVuk79tErBywcayhIx+5YmQwaJmWJUQPjCB12?=
 =?us-ascii?Q?ZhWuz8tAhQ/sakEwuMFIqpnIC2q2/P2SAUCqB9VrzxhFqCO6+bLaG+6QqkTg?=
 =?us-ascii?Q?5bTDP1lMYbVDq9G1SWMw6htHF5r/36XF6c6r2VX8LNL4t6+eXs6vrRYWBHPA?=
 =?us-ascii?Q?er/u+Um0BW5mDR08q5WrPTu2zGLwfqEdUCHnnGBKAeTu2tBri12D10SQryLp?=
 =?us-ascii?Q?zQFwJHTN9b9za1TgyM0N8hpWUv65hJggg5T8DlqG9FjsiuQsEN1BIn+6uqNE?=
 =?us-ascii?Q?220TTOQvVT4uFgpTVde8g6ORhIaKnvvhtdgE3aG6n+Z+Qh7ew+Lwc39R5ukx?=
 =?us-ascii?Q?l579PqxmVRo+F3z0gX2E9H7l?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd5324c-5ac7-4b0c-4cf1-08d936bd4ff7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 03:08:17.3498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zy0vJNzD+joKVp7xPRuWQMoNX7Sc+o8G1dE0sQvs6D/1dKqxUX/tv6c67U/3dO9QUS2zhW3sTsoxS2LGPyRbg+onkk0UcfL1uWaoXwG6dAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2837
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10024
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106240016
X-Proofpoint-GUID: Iq6TDWJeuwJbrLd-YoD_tYbhc-8GIMAr
X-Proofpoint-ORIG-GUID: Iq6TDWJeuwJbrLd-YoD_tYbhc-8GIMAr
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

Currently, the kthreadd's user_struct has its processes checked against
the RLIMIT_NPROC limit. In cases like for vhost where the driver is making
a thread for userspace, we want the userspace process to have its processes
count checked and incremented.

This patch allows the kthread code to take a user_struct and pass it to
copy_process. The next patches will then convert the fork/cred code.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 include/linux/kthread.h    |  5 ++++
 include/linux/sched/task.h |  2 ++
 kernel/kthread.c           | 58 ++++++++++++++++++++++++++++++++------
 3 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 2484ed97e72f..3c64bd8bf34c 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -28,6 +28,11 @@ struct task_struct *kthread_create_on_node(int (*threadfn)(void *data),
 	kthread_create_on_node(threadfn, data, NUMA_NO_NODE, namefmt, ##arg)
 
 
+struct task_struct *kthread_create_for_user(int (*threadfn)(void *data),
+					    void *data,
+					    struct user_struct *user,
+					    const char namefmt[], ...);
+
 struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data),
 					  void *data,
 					  unsigned int cpu,
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ef02be869cf2..357e95679e33 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -34,6 +34,8 @@ struct kernel_clone_args {
 	int io_thread;
 	struct cgroup *cgrp;
 	struct css_set *cset;
+	/* User to check RLIMIT_NPROC against */
+	struct user_struct *user;
 };
 
 /*
diff --git a/kernel/kthread.c b/kernel/kthread.c
index fe3f2a40d61e..9e7e4d04664f 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -41,6 +41,7 @@ struct kthread_create_info
 	int (*threadfn)(void *data);
 	void *data;
 	int node;
+	struct user_struct *user;
 
 	/* Result passed back to kthread_create() from kthreadd. */
 	struct task_struct *result;
@@ -327,13 +328,21 @@ int tsk_fork_get_node(struct task_struct *tsk)
 
 static void create_kthread(struct kthread_create_info *create)
 {
+	/* We want our own signal handler (we take no signals by default). */
+	struct kernel_clone_args clone_args = {
+		.flags		= CLONE_FS | CLONE_FILES | CLONE_VM |
+				  CLONE_UNTRACED,
+		.exit_signal	= SIGCHLD,
+		.stack		= (unsigned long)kthread,
+		.stack_size	= (unsigned long)create,
+		.user		= create->user,
+	};
 	int pid;
 
 #ifdef CONFIG_NUMA
 	current->pref_node_fork = create->node;
 #endif
-	/* We want our own signal handler (we take no signals by default). */
-	pid = kernel_thread(kthread, create, CLONE_FS | CLONE_FILES | SIGCHLD);
+	pid = kernel_clone(&clone_args);
 	if (pid < 0) {
 		/* If user was SIGKILLed, I release the structure. */
 		struct completion *done = xchg(&create->done, NULL);
@@ -347,11 +356,11 @@ static void create_kthread(struct kthread_create_info *create)
 	}
 }
 
-static __printf(4, 0)
+static __printf(5, 0)
 struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
-						    void *data, int node,
-						    const char namefmt[],
-						    va_list args)
+					     void *data, int node,
+					     struct user_struct *user,
+					     const char namefmt[], va_list args)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
 	struct task_struct *task;
@@ -364,6 +373,7 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 	create->data = data;
 	create->node = node;
 	create->done = &done;
+	create->user = user;
 
 	spin_lock(&kthread_create_lock);
 	list_add_tail(&create->list, &kthread_create_list);
@@ -444,13 +454,43 @@ struct task_struct *kthread_create_on_node(int (*threadfn)(void *data),
 	va_list args;
 
 	va_start(args, namefmt);
-	task = __kthread_create_on_node(threadfn, data, node, namefmt, args);
+	task = __kthread_create_on_node(threadfn, data, node, NULL, namefmt,
+					args);
 	va_end(args);
 
 	return task;
 }
 EXPORT_SYMBOL(kthread_create_on_node);
 
+/**
+ * kthread_create_for_user - create a kthread and check @user's RLIMIT_NPROC
+ * @threadfn: the function to run until signal_pending(current).
+ * @data: data ptr for @threadfn.
+ * @user: user_struct that will have its RLIMIT_NPROC checked
+ * @namefmt: printf-style name for the thread.
+ *
+ * This will create a kthread on the current node, leaving it in the stopped
+ * state.  This is just a helper for kthread_create_on_node() that will check
+ * @user's process count against its RLIMIT_NPROC.  See the
+ * kthread_create_on_node() documentation for more details.
+ */
+struct task_struct *kthread_create_for_user(int (*threadfn)(void *data),
+					    void *data,
+					    struct user_struct *user,
+					    const char namefmt[], ...)
+{
+	struct task_struct *task;
+	va_list args;
+
+	va_start(args, namefmt);
+	task = __kthread_create_on_node(threadfn, data, NUMA_NO_NODE, user,
+					namefmt, args);
+	va_end(args);
+
+	return task;
+}
+EXPORT_SYMBOL(kthread_create_for_user);
+
 static void __kthread_bind_mask(struct task_struct *p, const struct cpumask *mask, long state)
 {
 	unsigned long flags;
@@ -785,8 +825,8 @@ __kthread_create_worker(int cpu, unsigned int flags,
 	if (cpu >= 0)
 		node = cpu_to_node(cpu);
 
-	task = __kthread_create_on_node(kthread_worker_fn, worker,
-						node, namefmt, args);
+	task = __kthread_create_on_node(kthread_worker_fn, worker, node, NULL,
+					namefmt, args);
 	if (IS_ERR(task))
 		goto fail_task;
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
