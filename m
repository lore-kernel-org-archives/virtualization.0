Return-Path: <SRS0=OSH5=O3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7BFC433F5
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 21:45:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F896610A5
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 21:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7F896610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4989B40474;
	Thu,  7 Oct 2021 21:45:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xab8SS1o-r8M; Thu,  7 Oct 2021 21:45:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9FDFE40132;
	Thu,  7 Oct 2021 21:45:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 791C4C000F;
	Thu,  7 Oct 2021 21:45:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15851C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EC2BF60796
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="hHkhA59U";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="zgI0Gyes"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OByEKfRv_C-X
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3826F6071A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:30 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197KYXPo007639; 
 Thu, 7 Oct 2021 21:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=72je7QVmWXWAuy8spysscwUujUXuywaWz1Lnt+WNqCo=;
 b=hHkhA59URQUsWDaBFFoFdPhRpdH7dcRlb8T53khVpv4sfSFAisj/3vilxYgXAhwvBCXo
 qDxWQ4TedaQbnZp2+q9m+tX0weOcKIu4i6d2xauwGe5TMtl70ej3XxoUAQu+uJ69/HuI
 Ng2FGhCa7mKTt1MZjKOC3SWs3IXtVgjlJTqFIzQHCqoS72ZGC1vM4odXoXNXovqGgJsN
 2pYaZGIY7aKza7ZqibbE1LuNdWWLdCJc7CfdBmJm1jnoSXgvyHyp0U0bCUbWN5kB+pRL
 3Ghz6m3AbsablrIbeyJzqYrQ4d4nULFQrOL1H5gCwuynnQTGf+u0vyOQZKnAi85vay13 9A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bj0pw4751-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Oct 2021 21:45:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197Le7IO113075;
 Thu, 7 Oct 2021 21:45:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by aserp3030.oracle.com with ESMTP id 3bev7x4uju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Oct 2021 21:45:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmAagoR1QAaUBWti+/nLpB2AO4j0kL3TeDzgAHGuzM1OM3hyouzuC4rW/CW0i3Sv8vcshzyVg8KTqgeUiVqg2E32IvO14rO/LtfQfolljJNLz+dV5S9cR0ASX4JpwdH8PCmdmjE6MA90ZGtsAkA8RtjUG29VlgAw3yIrIfdt5I6Q1pAiKXJn08x8lfra+8f+TXO+PM4ViV2EhLoLVLjfn/fboEEnT8vauD5x0fkWjGeeWUS4tOr62G7vS9zbm0HDuSASF1ZHBbRfFpuSfmomAfAhcoNiGgVTmZ5RuAWKuVNjD6nYLqOYCMhh9DRK7saF5XP5ctecTR5oUoptxRjYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72je7QVmWXWAuy8spysscwUujUXuywaWz1Lnt+WNqCo=;
 b=cyWkhGlFXYwjLcH9Idbb1zmF9ZmgwwieSpnVoMtYBrJDXrWDqvkli3fRlPczSMmichzLrIVsSn0zYmyzfO2PW18NiBJS4ThaRhA4PPq7A4MSACiksyxeEPMVR6dPtI/E6yUQmTCBPhrhpwwWSB31KBqhQyksFIy+ElcU/SkybBBItqvq9lJ0GhlRPDexhc6xZp8wrvejuUmZpTf8KLAKYMngBSt7oYwSG2X6/Hcx4MY580lr4uf5ME/B+M8ZTmJhaGdQt4R4nRxaMEb6LNQtRiJlXFIFdxAfrrsPomiSo3kK+od+EHh8nE8/si9hGnzvkdQu2hPTg9uYOt+fuIVxKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72je7QVmWXWAuy8spysscwUujUXuywaWz1Lnt+WNqCo=;
 b=zgI0Gyes5KU8OPlaCPkEOrgrTh25oB01ibFvfUWoVBmLas7C6y/36NcFBrFyAtpo0jhArEG7igZ7/oYk8EdKP4aV5qsWUQtURMBWabcNf9/NxkSp4DxJhK75H3kYDNEwJvPOzX3Vf971/lAZ9fh2mqf9HHhnYzcAPWyS8vszZfM=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1612.namprd10.prod.outlook.com (2603:10b6:4:5::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.19; Thu, 7 Oct 2021 21:44:58 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531%5]) with mapi id 15.20.4587.021; Thu, 7 Oct 2021
 21:44:57 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V4 3/8] fork: add option to not clone or dup files
Date: Thu,  7 Oct 2021 16:44:43 -0500
Message-Id: <20211007214448.6282-4-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007214448.6282-1-michael.christie@oracle.com>
References: <20211007214448.6282-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM5PR20CA0008.namprd20.prod.outlook.com
 (2603:10b6:3:93::18) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR20CA0008.namprd20.prod.outlook.com (2603:10b6:3:93::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 21:44:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7adc6f7f-6e20-45e2-e539-08d989dbb4fe
X-MS-TrafficTypeDiagnostic: DM5PR10MB1612:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB16122B22376574051721374EF1B19@DM5PR10MB1612.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qeNHj/FQZRIGrf6qk5qwn1+UjRWpm2iuEgdEx6MW6dS6t2hzZHH5yu/osF9HINxI5Vgyu2ZU25aPKT3TXiptSaIn2Jbg7bYabo+4TfvVc6eAYDrOv/etc+VBHeA/F7ngNvdtu3fNAmkY/c+6ydYReT0I+T9NcXCS9qpyL16SXL3N4+n6umgTMvrVBTvTPWkUm/us+AgoRDlNE+41H7hRuw4RWldufCl7z+I/PpwvS6VmtYXLHqegLbCpUEihjYwfb1jUofWlXrYcVNZrjmUX0mUFu3TRm697l13jiACWf9/umZG9yOoj4xHOPIEw2GurYIIBPLzSFbpDGpRp4pqQGzJFcfGJnW+mwvB3wN3phwrj8Y22uAwXfPpx1zGU0VQ5UfltgNTtsg+VhhD9NNLQzpIWN3HJRsKStYsu2Ju1TUSbzwaDDRM+UJDamvA/dN63bSOV+88T3fU81fYYJPMgueEWhZ4hd25m3YjjTsvbn4dJXNs4GVNyo+gQXwoOKZ1aFHjNgawZLuYzV4XXdyQ+QlRR+bmDcJJTPUrOvRDn6ouHtbNdbQ+cy0pzC1azJp1SOqH7rtkiWSwgC4Y9wNn5LRPF77ocI0ueiiun75Rw4aQEGwDGlE1+lPZl3YDRTG2CLf9yh4VjoKv4lmtCMs9So4zy2JZyadkcxHbd5awGHFbj+ZZg3QL/3WKDuqEEseHtnLArwfSVgJAJX0TGXOc/NnWoVcTJfbCnDNCJwkQfAqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(36756003)(2906002)(66556008)(1076003)(66476007)(86362001)(186003)(6506007)(83380400001)(508600001)(7416002)(52116002)(66946007)(6512007)(8936002)(921005)(107886003)(26005)(4326008)(8676002)(2616005)(956004)(6666004)(6486002)(5660300002)(38100700002)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zzDVP3yaQYMCzEerk+Ec5ClrUW1KkwrUBALIaTCF89ptV8e1XFbiGOfH3730?=
 =?us-ascii?Q?EzedjMeetRHwh6gtdFN73Oksu1PewVOdPbmwfbJAVWAQB0L5EUOHclGzT2Er?=
 =?us-ascii?Q?rmR5j3RWp4bNDNsofY61DG5jxQP7z3niY7SY2rGzCjNy0ObRslR/f8fK82z8?=
 =?us-ascii?Q?iYw+GgjgHxegf/7saoqq5izkwRcojRtFdNNgGhAxDQavqqlwg/xiAUVZ4PSi?=
 =?us-ascii?Q?Z8V99XDcTmTcQhMV0BYkhOQwtvhIX6gLD14h2YurnZ8fk2canJ/NVkY51Smi?=
 =?us-ascii?Q?w5bvH4bmA8uzlJ5IDOHeoTHsq4NQe3pBYE5s+fopL6oglKAC0okOYo6lNvMH?=
 =?us-ascii?Q?R/on2WNDa73fXZ/BZrdnq3WxLNV0rVW2iMBRHcrR1OzWA0wRrk6XVlKKPetr?=
 =?us-ascii?Q?Hn/S7NUg0AKuCLF2kJkg/x47bcGa6btLTvhC/SGSM69mVcZ1pFMKs77K8gMf?=
 =?us-ascii?Q?XyQFnc0VvqPactmhJGkuB6oQbqnpSnT7ioi52JTfvxPG2StVnKbNSnRWSuuQ?=
 =?us-ascii?Q?Ondfw1cqrGBZbeLxdPqhT7UEsnevkmvG7wDcOVLWZ7+Z3Q7PapFfHDDQ4HSs?=
 =?us-ascii?Q?KOgSTutHKSkUhKK8BBC93mHjzE6iwds9bvG2FhI6bvKchpUor4wbKObdJEfH?=
 =?us-ascii?Q?8OEWvAGj16vB/NI4KQo/UD3TtWPslw4+lFoXK9AdWs0ekl7HmwtE323FfYFl?=
 =?us-ascii?Q?PVrKH2BTfev4M83Kpmf8wYUJ8PtqR/KZWDUUpnrBil17GuOc9WC34jIlq+hb?=
 =?us-ascii?Q?PV1IJEkNzd+uDyG1Hh5vxJRBkRoPD+NqezUR3c1FxKiYM3XQ5hc0moHM0S7d?=
 =?us-ascii?Q?bYszfnVQDaH9cqFU+RWsiM171cOKq3J1xw0eeen8cnXChVlIHBg252+3WPne?=
 =?us-ascii?Q?hvWfM9tJ2QLPFkz0uVZEp0zzA3ZpTWLwmQ8HrY11MswqUnS0an102m0cyc75?=
 =?us-ascii?Q?XYVwqQ42bHHjft5j+ziDRmFDIsGXVV8WR7ZbrLvd0CY69boUuAZx47KQIxMx?=
 =?us-ascii?Q?fNyfkkufAfeP3QPfmGGFY7ktbeJRr4WSiIu1sZAl8Y6FjYvzklhYdwEI7sdD?=
 =?us-ascii?Q?KTViY1qcjAYHJfcJaaQ9AW9AKT3U8v9M8dKtriJ2uafiGml4n1CNvoCfxgK3?=
 =?us-ascii?Q?TEqlSXZVLNfVmIQwUKSb0+GBsHkbi4pYDgXxxUVZEpHp+mM8jJW8nzg483ox?=
 =?us-ascii?Q?tHGm97kCY3fnAIbaT++tZJQ8k16MfLQLx+Cxkt+dCGHZED+msgML7V2dzafH?=
 =?us-ascii?Q?uG3/vrs7JJfJCTUJnM0XmhN4ejPCp8Mbwwc7TjSIq2BSngaxHRYchnVq4LuP?=
 =?us-ascii?Q?VyW2U35dwNRPT1gF1RzeKroZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adc6f7f-6e20-45e2-e539-08d989dbb4fe
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 21:44:57.8402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXJInPcSgisKB0qFY3EIZMY5piwXiI/AnjtQxUxzxn7ft3+zaUiVMXEY2xFyrPNtYOYlgziCIYZ3CUZiM8/MpOT9C9f2XkogYzTCJVadtp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1612
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110070137
X-Proofpoint-ORIG-GUID: PZwFDXX6WNj-4oXd_7JX4gLQ_BFpWRSI
X-Proofpoint-GUID: PZwFDXX6WNj-4oXd_7JX4gLQ_BFpWRSI
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

Each vhost device gets a thread that is used to perform IO and management
operations. Instead of a thread that is accessing a device, the thread is
part of the device, so when it calls the kernel_worker() function added in
the next patch we can't dup or clone the parent's files/FDS because it
would do an extra increment on ourself.

Later, when we do:

Qemu process exits:
        do_exit -> exit_files -> put_files_struct -> close_files

we would leak the device's resources because of that extra refcount
on the fd or file_struct.

This patch adds a no_files option so these worker threads can prevent
taking an extra refcount on themselves.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/sched/task.h |  1 +
 kernel/fork.c              | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 53599a99d7e0..1153f9e5d10e 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -20,6 +20,7 @@ struct css_set;
 
 #define KERN_WORKER_IO		BIT(0)
 #define KERN_WORKER_USER	BIT(1)
+#define KERN_WORKER_NO_FILES	BIT(2)
 
 struct kernel_clone_args {
 	u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index 4f780424de46..3161edac1236 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1532,7 +1532,8 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 	return 0;
 }
 
-static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
+static int copy_files(unsigned long clone_flags, struct task_struct *tsk,
+		      int no_files)
 {
 	struct files_struct *oldf, *newf;
 	int error = 0;
@@ -1544,6 +1545,11 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
 	if (!oldf)
 		goto out;
 
+	if (no_files) {
+		tsk->files = NULL;
+		goto out;
+	}
+
 	if (clone_flags & CLONE_FILES) {
 		atomic_inc(&oldf->count);
 		goto out;
@@ -2181,7 +2187,8 @@ static __latent_entropy struct task_struct *copy_process(
 	retval = copy_semundo(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_security;
-	retval = copy_files(clone_flags, p);
+	retval = copy_files(clone_flags, p,
+			    args->worker_flags & KERN_WORKER_NO_FILES);
 	if (retval)
 		goto bad_fork_cleanup_semundo;
 	retval = copy_fs(clone_flags, p);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
