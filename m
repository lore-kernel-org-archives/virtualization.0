Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149D9C4332F
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 19:22:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA30961269
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 19:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA30961269
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9D0C7400F1;
	Mon,  4 Oct 2021 19:22:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I3d-uaV-ubfB; Mon,  4 Oct 2021 19:22:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CCE5840263;
	Mon,  4 Oct 2021 19:22:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6B54C0021;
	Mon,  4 Oct 2021 19:22:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55527C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3221B83938
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="EpbcYJ6N";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="VahbFWlo"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wGMxHv8SI-Fp
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 639A38394A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:15 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194IR8iN004481; 
 Mon, 4 Oct 2021 19:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=PVS7BHUYs1YgOZq0+5syiiiHVDM9b7hZ8GxpMuW77ac=;
 b=EpbcYJ6NsvA4fRtzRYUS8DbThLcRY/reKedbvQ2ZKhZjDTeKYqM/1Qgpc39R3jow0x/O
 o6ZB2FB46YvxzQMysyRxDLV/PJBUYm1FUOyI64ZeorAxb+yPGZQTy3lL/+2MhKGElZKx
 vPdTldlyxLIFgDQJZrlEWm9rq97RxuBr5/3hdsv3VTwD2RgoNETlMctGQDwyShWuamRj
 eVctywZ76UBI0miF/3FwW4scUlGHtw6EBTHhBZJpBimVkn2ZXdbAltfWEhqUInEDwujH
 WW3R3Yb/eAAogSvp9ePlpmGBkcbMcFCB3CV1ta9MvNx8QiYQRksRC327ehK4xjgH3La9 AA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bg43dst5k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Oct 2021 19:21:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 194JAbkp095280;
 Mon, 4 Oct 2021 19:21:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
 by userp3030.oracle.com with ESMTP id 3bf0s5c7jr-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Oct 2021 19:21:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jdpc2tmJSQUfALeCeAfJ/hCKSRKlxE4mnA5EATI9mTZYo+IGmPM/mHyykmL5JJbm+oqQwmREsnHld3AXAsCGVgRDD9N/LGA0iA+Oa6lWkDNgPVjDDbujEKG6C3N25eb8C5MYZqDWfUwb5Fkv3CONWAhdmdZnSobGl4D6IaGEXKo/HsMkHJ+F3ej9sAxINpoUTFoylaaToo2TRk8HdzBuZjkFvlNSrXUbKBSz2JSKjI1WHQ4zIfU/+5JKBxdwA4azrgc1M/HHieti+AKQ8dREZih7A/cHNMS8+KQ219ICSeyHlSuYBo1FaZKZA1gHjXTFvzLZYjWnfu18HJAWIVk6Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVS7BHUYs1YgOZq0+5syiiiHVDM9b7hZ8GxpMuW77ac=;
 b=NcXauQD7C49LxR44L7jlPJRCQDtdd+i5Oj9zN0DJDDyFAhfse7lXdU0MvwKSi81s1qeRhna0MkWRuj0ue6jkhwJ4YEEO8UKkwHKfGB83ZsgCRurTmhni/oXioqs2eVgHzpla39NE2GY7kZgfEXPCwYubi6YR7w48OKxCPgPRDq1oc27pZZ3K7MI06vz7lHPUIN4lMh7Jzr2429Ivky9Ov+G989BiLvQijZkmPaA1qzdJNtZYf7e8Cwq8cNMSXnSoFvr9Is+PlUDv5FFAS3Xgl7iF+lB9V9qpZu4NzMkep8CvV15X6s1tNgX7Xb8x0qAQUTvQV8KOyCD2pz/TzIvCiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVS7BHUYs1YgOZq0+5syiiiHVDM9b7hZ8GxpMuW77ac=;
 b=VahbFWlo4mRVUDyRymdrdtGE8kJE6GbgQ2yZsIa8fLcV++yfQMdIVYCOfqN7c9MBW/myAPyzSKZ0RLsGH24Mjo0muqyfG+BY1UwbyoGrrG/aCk6W8FggGEIlGgequEYCJ7sx9cI5o5kXp4iaYE4TPy5MYfMzh/0dFXTK2hoGk/U=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1548.namprd10.prod.outlook.com (2603:10b6:3:13::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14; Mon, 4 Oct 2021 19:21:40 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 19:21:40 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V3 5/9] fork: add helper to clone a process
Date: Mon,  4 Oct 2021 14:21:24 -0500
Message-Id: <20211004192128.381453-6-michael.christie@oracle.com>
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
 15.20.4566.15 via Frontend Transport; Mon, 4 Oct 2021 19:21:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 121fab67-a6a3-4aca-988c-08d9876c3166
X-MS-TrafficTypeDiagnostic: DM5PR10MB1548:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB1548F25E72919E5E6262BCD2F1AE9@DM5PR10MB1548.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zF1+BmZTv22jeenKPbobDYvB3Ipf9PHOQALA9Vc7RhrOYVrnKYZ6T2SR/+lVHEaYAUcEGDnp2UBe11VDHbygxsR0LV4dYwObg0t4w5JcxCPcUUMWGNGIJILrErATLpg2vdQZ6sfI45/7SnNlGIH80if7M0/YpszrHIJlHcGwpwSGVMFN+lKdicSAg804wbasq+pIoGUKbR0tutxFGcn7DSAg1zvy1c8qmitqB8AiTC+FlaWHRwWxipkChU8SQUuCQ3SFpZKnAA3//9wOd/E9SpGV7kJinft7VtAldyxkrGHGM3XS5pOSc7ccEEJKd+p7XmetQV+S2LiEPWOo/dhVo3KhvmSSW0mdaTcvJCWd5C6VU3FEmLeQJSXDsL6UgoCxIVZz9OGBD4nzuXyQMZx0n3mx4rm+2vgSpLWSeXtZnCb5uooS3zIwnMgQvMrEfPKh04y+hpx84/MjHTm3jnCXZrXlz2Iuv5waRGnXq6M/uUSyaHvoHwa/5FHgOo+qoR1i3Wr3qe+1yeHxLggovTtaFMunti3SOolq27Mup3um7dZAfbnJ0zRTlRbusFZCEBpil8kNPTyjwRa6585AJGyS/VL1q24gBd7S818P7vG1T2ntzga7ZKbY8KeWcm2DpgF05SbdJRhkb+HkfvCQBN4cMAWH4WrXkJgisIwj1TeGtFVHdtBJM/DSCUNjefWomFeex52dKBhT1ItXAgnVpYhu3BZvGOoTlEDMygp6jbDHaqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(83380400001)(8676002)(921005)(7416002)(186003)(38100700002)(38350700002)(6506007)(8936002)(4326008)(26005)(508600001)(2906002)(6512007)(6666004)(86362001)(316002)(52116002)(1076003)(36756003)(66476007)(66556008)(66946007)(107886003)(2616005)(956004)(6486002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yo8PcYKDJawmZzX9485qBCdJc7Ro3CnJCUArjnJtPwbpEDF2wBdAZ+UXyv/t?=
 =?us-ascii?Q?ey9xJ1M5LfZVM59p0lAZnBE/Srd72WyrgE3sW0E11WP8biaKhCThWZXhPQVD?=
 =?us-ascii?Q?I98W2IA2j4EewkaNpFC//Zntlf3B/Q9N7Z6D1q7VMvFq2d+LHslZ9U3bO6GG?=
 =?us-ascii?Q?VpKqKS5DWfcjd451o4QQWgC5DCH6QJBUg4TbcNeqipKstc6MIwUID5TavUYa?=
 =?us-ascii?Q?5IbIRzJ/kV1o28ftDfAXG2sPOuZBADXBk7QL2wqyH+KgUgqbXr6CVOgglzhG?=
 =?us-ascii?Q?qhpEOtCkDDvHWfjMTgHYrxDvxb+oN1owcYek8dncY8qCMeim5etg9gA0qASY?=
 =?us-ascii?Q?WJtTQXpHnBY5ApdygWTSPJmvuSFkuoZUm5Cc1hLB0IyTTNJYij62jBKBUACF?=
 =?us-ascii?Q?Alp7JQfR4XllkHV23RehOv86icSA/jJzSzLbpX13br5JPwgg8JquhU9UEYB3?=
 =?us-ascii?Q?bud+7Ss5qd/z0ZkDJC6L2a+F8mh1fi7qvXSqgHTX53k0rOztTII976glz4qR?=
 =?us-ascii?Q?ScNBpd7tS7Jr/5jOe1RqZOzD1UPbdY/Z1edWiWyFHCQ4nsj7EC9Ipb3O9tgp?=
 =?us-ascii?Q?ZE8nP2Tgr//RjFLxONPJn3ClUejNGnWbkH0aCUu2+zJU68vJDa54ZPmDV1fz?=
 =?us-ascii?Q?m1TwV5ow+A+DSKy/b5ymMbZJx24FZ6214twgMA4R39xUOlC6T/Q3lpv6I1mp?=
 =?us-ascii?Q?0u3BeAPB27jnD6ujU4NkrStExsjqa9UqB/W9pz19FXDNxfGraZNnmvwgfUgd?=
 =?us-ascii?Q?RQPyds0xfNnGvx1ms5T0N9qggzpxslW5oXwV7xv0v9SyhHxa8gKyy6IxiNl1?=
 =?us-ascii?Q?M7XdfZTmnzKJQtgF4ZtgkHmDXNTgVIh+J3ybru57p1kUK5ixmlicvAlbdalY?=
 =?us-ascii?Q?i5Q1Yj9fZBFhOSfG4tZos00LYqaGEBZhS8JKJcng/nSNfSg8m2Ftr94Cuz7f?=
 =?us-ascii?Q?kgt7KD/k8qP2pXHyqYv912hl8IP/vn9SHpoFHaKqMsgeISxPA5bva1pa1X3r?=
 =?us-ascii?Q?9w8p+BG5K2d39SdJBzSKF7mDfLP8wwPr7NXNCR0pfyxAbrqyohK208kw8ZgH?=
 =?us-ascii?Q?jk2UCoZFAuQZIOHGC8LjSTxZqu56gO8sENqSV0MI96MmnUV33IA1/ojrjgsu?=
 =?us-ascii?Q?UhOQPk/DqY1RvZ8NCMx6Y5J9SmGRvGE4IbAcnOHH7Z6B742id7uwxB3ihfSK?=
 =?us-ascii?Q?X8m29CxGxh3rBSPDOeNIY9LMcuQ3AsU0MEveW/3K0ao6gzVPRFyoBtMr3wxo?=
 =?us-ascii?Q?QjffKlUEE6HPHGaajzRIbCes3XlRtySXOlRMWPxxt4IjQWmwW1XxqvOI53Z5?=
 =?us-ascii?Q?dMoMz8/9fYUYyNYEjUuS2CUK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121fab67-a6a3-4aca-988c-08d9876c3166
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 19:21:40.7809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGdKCxUYPkT7rcLmOt5qEGO/XTlfyamR+PxfmWJ53NSvOW0hsXsqY79EBBKxJLpwj4aoeFgsYJ6SpFeIeK6y0V5DRob8LbC0+tMIBPP/QuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1548
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110040131
X-Proofpoint-GUID: TtR1GpdzEWHmLF_BSkv2TmvEOJCs-oTA
X-Proofpoint-ORIG-GUID: TtR1GpdzEWHmLF_BSkv2TmvEOJCs-oTA
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

The vhost layer has similar requirements as io_uring where its worker
threads need to access the userspace thread's memory, want to inherit the
parents's cgroups and namespaces, and be checked against the parent's
RLIMITs. Right now, the vhost layer uses the kthread API which has
kthread_use_mm for mem access, and those threads can use
cgroup_attach_task_all for v1 cgroups, but there are no helpers for the
other items.

This adds a helper to clone a process so we can inherit everything we
want in one call. It's a more generic version of create_io_thread which
will be used by the vhost layer and io_uring in later patches in this set.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/sched/task.h |  6 ++++-
 kernel/fork.c              | 48 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index e165cc67fd3c..ba0499b6627c 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -87,7 +87,11 @@ extern void exit_files(struct task_struct *);
 extern void exit_itimers(struct signal_struct *);
 
 extern pid_t kernel_clone(struct kernel_clone_args *kargs);
-struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
+struct task_struct *create_io_thread(int (*fn)(void *i), void *arg, int node);
+struct task_struct *kernel_worker(int (*fn)(void *), void *arg, int node,
+				  unsigned long clone_flags, u32 worker_flags);
+__printf(2, 3)
+void kernel_worker_start(struct task_struct *tsk, const char namefmt[], ...);
 struct task_struct *fork_idle(int);
 struct mm_struct *copy_init_mm(void);
 extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
diff --git a/kernel/fork.c b/kernel/fork.c
index 98264cf1d6a6..3f3fcabffa5f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2540,6 +2540,54 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 	return copy_process(NULL, 0, node, &args);
 }
 
+/**
+ * kernel_worker - create a copy of a process to be used by the kernel
+ * @fn: thread stack
+ * @arg: data to be passed to fn
+ * @node: numa node to allocate task from
+ * @clone_flags: CLONE flags
+ * @worker_flags: KERN_WORKER flags
+ *
+ * This returns a created task, or an error pointer. The returned task is
+ * inactive, and the caller must fire it up through kernel_worker_start(). If
+ * this is an PF_IO_WORKER all singals but KILL and STOP are blocked.
+ */
+struct task_struct *kernel_worker(int (*fn)(void *), void *arg, int node,
+				  unsigned long clone_flags, u32 worker_flags)
+{
+	struct kernel_clone_args args = {
+		.flags		= ((lower_32_bits(clone_flags) | CLONE_VM |
+				   CLONE_UNTRACED) & ~CSIGNAL),
+		.exit_signal	= (lower_32_bits(clone_flags) & CSIGNAL),
+		.stack		= (unsigned long)fn,
+		.stack_size	= (unsigned long)arg,
+		.worker_flags	= KERN_WORKER_USER | worker_flags,
+	};
+
+	return copy_process(NULL, 0, node, &args);
+}
+EXPORT_SYMBOL_GPL(kernel_worker);
+
+/**
+ * kernel_worker_start - Start a task created with kernel_worker
+ * @tsk: task to wake up
+ * @namefmt: printf-style format string for the thread name
+ * @arg: arguments for @namefmt
+ */
+void kernel_worker_start(struct task_struct *tsk, const char namefmt[], ...)
+{
+	char name[TASK_COMM_LEN];
+	va_list args;
+
+	va_start(args, namefmt);
+	vsnprintf(name, sizeof(name), namefmt, args);
+	set_task_comm(tsk, name);
+	va_end(args);
+
+	wake_up_new_task(tsk);
+}
+EXPORT_SYMBOL_GPL(kernel_worker_start);
+
 /*
  *  Ok, this is the main fork-routine.
  *
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
