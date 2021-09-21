Return-Path: <SRS0=rv7y=OL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F56C433F5
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 21:53:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C46E61107
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 21:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C46E61107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2C8E613A4;
	Tue, 21 Sep 2021 21:53:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ql2vwzBGwBoa; Tue, 21 Sep 2021 21:53:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 756BE61397;
	Tue, 21 Sep 2021 21:53:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0749DC0020;
	Tue, 21 Sep 2021 21:53:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17F0CC0020
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 45A3540703
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="vkXKMpzq";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="PmTQtD91"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f6nLxRCrv4dB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8F20D406FD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:03 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LLEIdN013621; 
 Tue, 21 Sep 2021 21:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=pk9Qp+Qoro8fZKf5Mnieg2rJwPuR5i6kymErZtT3IX4=;
 b=vkXKMpzqIFNftjkg/95LkvQS0EdGZtmwCqedzZa/6uPxPMt1HArplog6xszVoDGL+htn
 6wOLwi/c9F0OlmdLbiN27Mt+kYi5XhnRK4oOBg9/Q9K/WjZDh/+a8rpPaNRbEhEtXdCS
 +lAJCgJsUVbn2zeYavRaWrRKDHVz/xDjCBd+zEwCgLoSKSDQ2U3L0fyMDjM6H3zx/C1Z
 AgS4YhGCHIvV9tXyDCJTKS9KxDJApoUahTEfACvYjh/gRdfE7bktwUZ+QPvEyYjahUEe
 sXJ4DG5ZuUwAmgOYzKP4lcHjGfbk1UwCSbd9qj3Oy9UaYkxyb4vqt/Xv2A+Rcsi+NRn4 iA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4s04y2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Sep 2021 21:52:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18LLomVg154016;
 Tue, 21 Sep 2021 21:52:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
 by aserp3020.oracle.com with ESMTP id 3b7q59s7my-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Sep 2021 21:52:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUTbtnxmqVBJrtOVbOGGGmg7psTC/SC9K2+yBpMuaG5CyAmVgVAaYhMhCdElufgSxvEtGlJs0pTOPkURiyKrMe7AzBdNQy1wXigeA6TwiZCiqvDFkvbpQ8kDTGqsZbEjV7BVq9MxwnGWnLXL2z6+Fog7CTq3yriVOlMPeJt8hiSWbYLA59xDkfiEWcEq+U043y8HhBVEcqsD6Sj+dQDXAuCFjybVpP9uIaw96wxBjmfM0vhkxgFWnyjZL1RJWnEO3na0HsxJLJylLTP5Da9yD6x3eeagz6yPMZEslPalOzlqQHWglzlfQUTRAFHzl43sVZ7WX6CSZilMkR4a30scIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=pk9Qp+Qoro8fZKf5Mnieg2rJwPuR5i6kymErZtT3IX4=;
 b=AUZZ0hs2MBwhWWoXTZYJbVSZjH/J1TlnidT3LcE6QiSUdXUnDXhvXR+RPsXQYt7pN9yW8Fp/PAJxtUch4hFctXSrADczOLNK9jzPGK1jlmr/3VsGYy+fqYs53hXo436eySdfbsiajcNjeDFtBUICpLtWoeMDQ2wfOK5jKpOYi7ZSp2qizpggvqMUbj7Y+RdszdVqYpiNymM7wj5Xr4QbZlxwkkhzEDEZmjJpO1ioMJXDFPB9h2oI1TN1kBk8RfJ/niONhtnwYYpt12e4v1ixgvyMQ+PoOKSlW9CRWJb2w5LhRu9bXt8Ih01KH0e1vuzn3BMjGaUXQNkjFv5+A4t+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pk9Qp+Qoro8fZKf5Mnieg2rJwPuR5i6kymErZtT3IX4=;
 b=PmTQtD91tJpLpyZBzOoOt0Nuu1YqfgrgWngrhBC8vFeVCt9zZ7uia6PHU/th9SjJMuUd37et5psRq3gJM4Uhx8AtTzNMmq0NHAm9pQMgCr913Uoia7sBfGJr3gZwQZA8dZezgKEP+p7SWP9WHaGy6CUMTZ9l9qR78xsvt22uEfE=
Authentication-Results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BY5PR10MB3892.namprd10.prod.outlook.com (2603:10b6:a03:1fb::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 21:52:34 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701%6]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 21:52:34 +0000
From: Mike Christie <michael.christie@oracle.com>
To: hdanton@sina.com, hch@infradead.org, stefanha@redhat.com,
 jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/9] fork: add helper to clone a process
Date: Tue, 21 Sep 2021 16:52:14 -0500
Message-Id: <20210921215218.89844-6-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210921215218.89844-1-michael.christie@oracle.com>
References: <20210921215218.89844-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM5PR1101CA0021.namprd11.prod.outlook.com
 (2603:10b6:4:4c::31) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR1101CA0021.namprd11.prod.outlook.com (2603:10b6:4:4c::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 21:52:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1aa08ff-94fc-4ccb-4d26-08d97d4a1e71
X-MS-TrafficTypeDiagnostic: BY5PR10MB3892:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB38928540A4FCA2D3F37FEAFDF1A19@BY5PR10MB3892.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QIHIszztQYGq234jfhVITVbir806iaqwP13RBtk52Qmwvh+6lsWP6DcypwLjSrOd1CEzsvikyqR2CXGNcvwVWGxta0YfQu/DBh1YImgVPlLG3MTPgrfO1GcUtMlz3kLHlBD8wS8I4BL2N0+mupBOSqqGewIkWbv+gmFgcz2Ni0SzY7s0P1SObgjlTLfP5EexNaGTe1oXWm/HX7Zlhipmt1g7+lYoyI0bxT7ve1+AssTvZycfeACm91e3yCRVerBccCNnEi5ODO4LisAV7xQISrkNS5DBUKRrAyjqfZqCkc/nVdICDu+h9zolHUbsfF35hrSwrzRFBzntbH88WzPKYI/8eBj6eyadjU5LjRpvw9rBQBWAZBwTlg2tV4Nh5+P4tFqIhb7GaFoofjWD5dDDoPMyWrw5YTyXpE8nALwkwoXiC3LVRPMD+sCY34CotNJEr/ddiUsiTyp+xq/dZUeOlCQs9X/OJT7MtiA0nwHUfrBJUsuig4EcWdFpwWIY7eMOnmT1U/U2m09cwO8Zc3YcYiCHN/htaiA4DY55H1JFe7NF6jFWsg2WL77Ii0AVCxc1HW4ayJDrecGK2mcrp26rUiiGI08QWyMWgJdrezY7keTLt8Z1bs3VFZRTYyJChYtafeCpDi5PqnFMiPY3SC2+9irL7BlRdfw/X42iKygQH8sl1rPy4WfE+tKxb9Hf3Jnx3WPh8XDcB4SidYnXNSApDAlqAVmfq3+ZFMWUVQ/PAg0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6506007)(52116002)(107886003)(956004)(66946007)(26005)(4326008)(7416002)(66556008)(2616005)(66476007)(86362001)(6486002)(8676002)(6666004)(508600001)(316002)(2906002)(6512007)(8936002)(38100700002)(1076003)(5660300002)(83380400001)(186003)(38350700002)(921005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BMVkctPAUgOSPQuNyw/0P2gkOhvqHTehhnZmDlKCnunSBNCo2QN7Gs6Z47cm?=
 =?us-ascii?Q?VnI/7HtugdeTd2/W+umArTj0N9ax1z6dda7M3q7CXZQgQF2gcfkXpbBYrD2y?=
 =?us-ascii?Q?J0i1x95aotzV/mzWA0zcuwPCnDZLdKopEKWS4mmBDnOrG3tLaIpKAwvKEJsy?=
 =?us-ascii?Q?io2n2zZ405BFDKYcFwk3TmDwhikLf9pXnW3oogdww7X5IbCnxdBXzCS9XcoV?=
 =?us-ascii?Q?Fs81ZAkJwZJ1Q/I+20pA0PCCgLWoAqqHoGhY1c4xNZymw6/GNdD+OFmVbspe?=
 =?us-ascii?Q?JPlp210xY4/C6CAGPhxfsLdHh/oYltiAx4ZnE5bebIGu/fbM7I5n2ceOsQAu?=
 =?us-ascii?Q?BjxBd1U7zQ2C7dEvcS+nX1blG63fDpusRlW9wW1EGeiS6A3/U8m9flMeJHY2?=
 =?us-ascii?Q?Ty9wyknZKGFrI6+GPMmt76VudhjseKbN0nDWlBzojlVQP6lv9OMKpw6r1lqI?=
 =?us-ascii?Q?GdL+z/3rYTgL9Vs/5GwZcPJwhQu8h/cDiwnNpdj6KyHflj8eIvxlKeGQVDiC?=
 =?us-ascii?Q?0u0wBq7B9m6SdhHo75mpocVcpBb2Q+Y1/TtAeAVQOp9aAbYNU8UfKKzzRL3G?=
 =?us-ascii?Q?lW7QEFKDgC8SKGYdC5JWDUb1b6TPfZmPGKkNNEMktQWza6C/aAWXu22FrYW9?=
 =?us-ascii?Q?NhnC6Geodbw90nv8H0gBfeqXG2OPZ+qlP21c0Z7LH7tVZ/0/y/sEeRpIhm1V?=
 =?us-ascii?Q?q4q+Wbwm/6lsOqc83NwiumTtmPirn8+auogx8LH/QwtHaHtOWhNRuATImujD?=
 =?us-ascii?Q?uR9Oz2BwQj7lm4aE0/Y9Z1Y+jnlOP/mzhLEu3UWGi/uGRc2dzk92uPapMRGi?=
 =?us-ascii?Q?l88XE94MK51ObWS1MNX0r86Gkn060JTY0uiqHe+Z3bfzwEuZBUvbvl2g7q2p?=
 =?us-ascii?Q?tjeydhNLB/7B6tQsar9swh3twIf0c7SYUYmEah8A4AWnqvRTvQpWNztPhDCe?=
 =?us-ascii?Q?6WKFZRuKzQ7kg+7JNqDmzimCrdBQ7nfFbi8r2i4Te3ntsuHLN1fNNBPpfvy7?=
 =?us-ascii?Q?iVPWDw+RK8ZFKGW2BAXFZtkfjdeWabvbC6OxbxA7rWVXZfpDqgWYozmAdAEu?=
 =?us-ascii?Q?4SEUi2AGqHAQYTFjM7wqAPmh/V8G1jfdGhqLfNJAUp6u+77nw0kupFzucOao?=
 =?us-ascii?Q?DwtQOVUbj8T4svcZlxuq9jg35ph5ItBQQmPuGEXtC+7momtsWCwjoJm2ZUBP?=
 =?us-ascii?Q?M+XNGRY17k9mb/KvDLaBGQWXCoLJLYvFJQp2NzFGlcSZsgex3XI3ZLbTsmft?=
 =?us-ascii?Q?OUzsAwaOsCGqgyqeUTartRUJnHs4Gz/27mh8F5b4/Y1t2LB0q2DEuGLzU/2N?=
 =?us-ascii?Q?KNjN3WsTs1L2aBRvzBvRTpvn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1aa08ff-94fc-4ccb-4d26-08d97d4a1e71
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 21:52:34.3088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIT5cHQATsKfaYN2TbtHEbr9nFIQQjeFvdH+LwnRpN0fC3Yk27q2kEaNi9c89X21dph/N8HRlVR+hnpwwBrbutkzfTMbxNocXmf129Dw0rU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3892
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109210130
X-Proofpoint-GUID: 0L3KNyMezGyb4WTqzfXyIRdp7jLydZwF
X-Proofpoint-ORIG-GUID: 0L3KNyMezGyb4WTqzfXyIRdp7jLydZwF
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
