Return-Path: <SRS0=OSH5=O3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3117C433EF
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 21:45:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6174610A5
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 21:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A6174610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 793376080B;
	Thu,  7 Oct 2021 21:45:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nTlV7NjfpF9w; Thu,  7 Oct 2021 21:45:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D5E19606C7;
	Thu,  7 Oct 2021 21:45:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF6F1C000F;
	Thu,  7 Oct 2021 21:45:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2F86C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D2B1840A13
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="qvmyV78F";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="l4k204Zn"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c4G-R8luTu-j
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EBE0940A06
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:30 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197KYaOu025384; 
 Thu, 7 Oct 2021 21:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=xFitzQ6CCiyKdfly5mXASgwajGYMPBZVrUcWJkGyleg=;
 b=qvmyV78Fd+efk2/Te0fuBkVDeZa+LKBDuMhac5Zk4k4k6DIYdTx/cVuIhY9EFwrThbYA
 2/fqdeN77NOYjRz1mmlSB+57LYbvuKOQYISmiG+8WCR6en/cAk/sVcsQCMioqfFjYPuM
 BxwmT2WKdRT9XLOK9OyHKkjMmuGULlRvYtenG6evB6HIiz6CfknZbiw3sBub7dUjEG23
 HSc09/P7S0P1+dyKmKO7tTbBlP5Q2aSyJ306/qUFGb/YSqFCU96makwCAz2L3zI1eUJv
 Ogb9bXd4NgOm5NtfhOuI9BRqIRVo3oxciQN6Vhqndig3Vn5X2rJuQghzvl0yMNxPAw2A hA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bhy2dcdtj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Oct 2021 21:45:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197Le7IQ113075;
 Thu, 7 Oct 2021 21:45:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by aserp3030.oracle.com with ESMTP id 3bev7x4uju-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Oct 2021 21:45:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+BJ5RVrb3JrPCnDe3PaDvHx62XFsa3w63j0v+FgOH+6PXRxHw7Q/Dhni2KYY0ncglYHtYp1Dxk8w1zm+cHOmmA5jz63ghWtQReX13iEjhfF/UAuZtZyU2/NqhFXwYDlv+0EGa6WahRbapl3rD2XOMTRJMGWEsTzwPFxafMQTykDyU8sOqnlJZ3YfOwhOUKLiYEPpDuog0OeuGbHA3gAuQ9r6Zgq5kReGYrKrQ69r6157//JQ256KeHxn3VDBWfEmYlFHRC72PksmlOW0Mp+tp9t5Yow6wEVBDy1CkuWweXbdUdiFQ+d1uicoJ5WIh83+XpDt7OWcX7BsLwWtGqv8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFitzQ6CCiyKdfly5mXASgwajGYMPBZVrUcWJkGyleg=;
 b=dIlm0dkFJ+ElzqpZVd5DhWDqOIndSXcvT427Q+1AsJkGpJRWtIe5OD6T0LXp3U53Yx26aLSFCpoq0xweE1cXn336Ztj7kpn4ZgyuEHbdZnD3upqWEO72nlMb3/712xy1DjK3T5O8Gy0n1wIvbhV46zjW/NekYQmTXSwtakQG1PGzvjY9w4r8nEQjVL67v5VH0oWMIJaB/b1/e3sZBmDb/aYTl22t//SCPsTm9j4+Ei8zHiLPXCqbbdB7DsKpCEHi40Yfcrtk85evU8ldXmubCp7fhS02TeQPzyACqmvKURRP7k3dGpMvRDGKNiOZ0VdkjlM4loy2Ukr70hKawNOt0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFitzQ6CCiyKdfly5mXASgwajGYMPBZVrUcWJkGyleg=;
 b=l4k204ZnZS8ao/+m6HdhdBozzk2/J0xs5VTrDs+yEynEEV53BgaFecJL1KfiP7/mZBKwvDRZ9JZoAryvIk+aGK+4mvr9qHIxE71zhZXsv/qGeeo8e7NNMmnRwNKyFcyzs1CpaQqd/DeES07X8ZATVTlRy1tY2HbFcQX/dqgeKCI=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1612.namprd10.prod.outlook.com (2603:10b6:4:5::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.19; Thu, 7 Oct 2021 21:44:59 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531%5]) with mapi id 15.20.4587.021; Thu, 7 Oct 2021
 21:44:59 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V4 5/8] fork: add helper to clone a process
Date: Thu,  7 Oct 2021 16:44:45 -0500
Message-Id: <20211007214448.6282-6-michael.christie@oracle.com>
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
 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 21:44:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3475aa1c-6f9b-49b5-a945-08d989dbb5ca
X-MS-TrafficTypeDiagnostic: DM5PR10MB1612:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB1612700C23EB327250D9226BF1B19@DM5PR10MB1612.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 71fhYOpOchXr8xhgMOIvvSbzrjd6WNZ9wQEAOQ/ovyNWReS66IPSNV/C52TxEfvuzrnFSPc2SZSlECAAStQHLljV/wdsSm4+cS1MmJYnTfmi0BXwzN1/jHBVe0OG6AJK4cqlUXIyOK/t6MgWkqbWk3E+dn2azTXG8Rr3MVZ0CCaR6wD2SwYJKFsY3HyduwipqQw2YYt1c17bJmocWLguZmzG+PK9fJybZAnQRZ5GT0zYEAQ6iI8DZFvFjWCfdxxOYAfXRlFH3a34/BovSckB/4qTP2BcUsCqEKyn6A24544DqJ2ErCb96dS3gaH5Vn3t1HSf7V2LPYddKxiOJBdNw9W8kr1zvmOrg+cbiKi/e92O3ZqiknqAx58jckJ8zB/78vUuIs0ntsiNp7E97ClEYfpRc5P8D+TKk3a4PgszF9VTLLvD6lEibOddA/+oULpV6416T27zsF+SpAYWoCpOLIDn5gqUdrdF3U458R8+uuMiFjUTcb8vIyj5Id3IUur/J1qR8n90ewroL5vMlRzXq9CLK6YtxPQwIctK93T3pte03Os9OeruCJXDt/rx2mVVReJ+UzUK1fhRbhZShSp6NExpbt3+XPyRLY0oZai9GLAIvHPiae/4/V8n9A3Yo38AWUR9HnhjCZi5A7Ju5/UQRlKJdtMTTkjoOavtVD/y0B/3GngYH7suYHLrJePftPjos6+tfMdJ20NRtMLotiFdNMCwGLrtknjYSl/++wwv6v4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(36756003)(2906002)(66556008)(1076003)(66476007)(86362001)(186003)(6506007)(83380400001)(508600001)(7416002)(52116002)(66946007)(6512007)(8936002)(921005)(107886003)(26005)(4326008)(8676002)(2616005)(956004)(6666004)(6486002)(5660300002)(38100700002)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z7BDttTq52CfFn1IUQP4CeHDV3Ee5FUJNG1p1KLInl64yr2DLHg+7nmMeahx?=
 =?us-ascii?Q?Fjly9YjheAiNQRnnAJneQtqGlhosLSja2lXchRMylKUkbFlk0Enb82VGGvpT?=
 =?us-ascii?Q?HLfqT/HLso/Uefw5irHFNbhpa67LddDSQU7Pr02Y5R2L759e05Ch45U61yao?=
 =?us-ascii?Q?7L+ZJR37kna3y/AlAw5/ITBvWpVDSHP8vMmckAdUHGj6H2w9gzRMtxVWtglw?=
 =?us-ascii?Q?Zdtezl2zq2t+Qvx53TQnGTyXiXtfgo/lybPsRb0l91TEao/lXB2KmYOtgJCj?=
 =?us-ascii?Q?M1xBUut9UZd9e6P879pgcYTEKaKX1Zf2RVYWrApf+8W2o4QXlUu8uGJJiPJ1?=
 =?us-ascii?Q?bOCVTR3AaocnddbpyhxTn5KomRL1z6a1wIf9iTHkEldkJwo7b8Nry/LVzXbr?=
 =?us-ascii?Q?6ZzBhBD6sD/mEFEpMea3YnC+L/1TbVMpNk1+mugmq4XfZ19IcxpfN4sS3Jbk?=
 =?us-ascii?Q?qoYOH3GYy9wCOqdCcEOGZVLfvL7L8b09YKw/oKWZdieex7droYPqMYspF+Xo?=
 =?us-ascii?Q?QAwPJnStpDCPwZPkBXHOTMLIqYXYa/rcWyfTnIQGG3gHxo3szTVqdav8TfzF?=
 =?us-ascii?Q?EK/DbtYC4LKx2k0aEmTbuuPjIWVrP51cJd+ZyGQsTdFe8kahKc5waLpK5q/j?=
 =?us-ascii?Q?PyaGz5bCVX6eHjlt8EChdqRJag2SHZSJ0BTKEko1vt4+pp26ol5hKAkW8EXM?=
 =?us-ascii?Q?RsUDUCDUB7+PLJ8ym5U2naoqaIJaMuP2fYT9QASUrPrEBw+8hAalDinAwV9E?=
 =?us-ascii?Q?GqnjlnZ0Gw5btMYIBLhuK96HApLpfDO+83VGn4s+uLLcp5G8/bjO+ZrfJ7iQ?=
 =?us-ascii?Q?Vc2dqO5NMdeobEOmyrasHalPgnejtrg/17A6Uck1Tv6vY5kyVMbMwXZlkkvX?=
 =?us-ascii?Q?ZiBZmVZ6PW+yW0StXqSxfjqZ/1i2WjM0L3t+qxvTNuT3tyLqANHcnCxmwtsp?=
 =?us-ascii?Q?his29JwFb58NdnUG5aenao+EAh41woKLtQZYmHF4siaY3a9s+eFHk4kkfHMF?=
 =?us-ascii?Q?qLCCSyYHSnNe2mrlan7RH4uN2KmYoQ83cXBFM/rSCB9FE2pAcd0nHhCFP1B9?=
 =?us-ascii?Q?MZ3w5R6isKm16V+FKQnBKW8Ym8rYBpcd3JoXVnhvkJTMhrenTw2KwpTWhLa9?=
 =?us-ascii?Q?pPNzC116YyTYLd1EeEtwq/A/eJ1ZOCKUrnFKyXvea0K78vqCANObK6pgu6n4?=
 =?us-ascii?Q?cMaEaMa5A0u/QmGiGNqTcjIVz6EktQoBgJ3Psy42R6fVGVCeOUUScZAICzXO?=
 =?us-ascii?Q?hSLKiU7+SOrCwK5+pH5CRLUsKqH8JEH9GYaoU6Z5k+TWpHRfYguF30+zXkGz?=
 =?us-ascii?Q?SdMzLjMcn3A6stfe9ZPaZuGi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3475aa1c-6f9b-49b5-a945-08d989dbb5ca
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 21:44:59.2265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10aSb8ZrA3QcEwK2int9aVjzwF/uYw7QuRBEI+2spb0yUJ6548+fYsgjno52nXteX8dNGot6xRq4lquQ6+hzx6bK4xlSnhGx0BOVNyAI2CE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1612
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110070137
X-Proofpoint-ORIG-GUID: CkCam1U8f3Om5Q4lTZplpZlXurGjRErf
X-Proofpoint-GUID: CkCam1U8f3Om5Q4lTZplpZlXurGjRErf
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

[added flag validation code from Christian Brauner's patch]
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/sched/task.h |  4 +++
 kernel/fork.c              | 71 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 5f3928fe0544..2bfc0629c868 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -89,6 +89,10 @@ extern void exit_itimers(struct signal_struct *);
 
 extern pid_t kernel_clone(struct kernel_clone_args *kargs);
 struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
+struct task_struct *kernel_worker(int (*fn)(void *), void *arg, int node,
+				  unsigned long clone_flags, u32 worker_flags);
+__printf(2, 3)
+void kernel_worker_start(struct task_struct *tsk, const char namefmt[], ...);
 struct task_struct *fork_idle(int);
 struct mm_struct *copy_init_mm(void);
 extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
diff --git a/kernel/fork.c b/kernel/fork.c
index 07f9e410fb64..b04e61a965e2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2544,6 +2544,77 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 	return copy_process(NULL, 0, node, &args);
 }
 
+static bool kernel_worker_flags_valid(struct kernel_clone_args *kargs)
+{
+	/* Verify that no unknown flags are passed along. */
+	if (kargs->worker_flags & ~(KERN_WORKER_IO | KERN_WORKER_USER |
+				    KERN_WORKER_NO_FILES | KERN_WORKER_SIG_IGN))
+		return false;
+
+	/*
+	 * If we're ignoring all signals don't allow sharing struct sighand and
+	 * don't bother clearing signal handlers.
+	 */
+	if ((kargs->flags & (CLONE_SIGHAND | CLONE_CLEAR_SIGHAND)) &&
+	    (kargs->worker_flags & KERN_WORKER_SIG_IGN))
+		return false;
+
+	return true;
+}
+
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
+	if (!kernel_worker_flags_valid(&args))
+		return ERR_PTR(-EINVAL);
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
+	WARN_ON(!(tsk->flags & PF_USER_WORKER));
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
