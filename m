Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C816C433F5
	for <virtualization@archiver.kernel.org>; Sun, 21 Nov 2021 17:50:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0797340475;
	Sun, 21 Nov 2021 17:50:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i0bxe6GHMI2e; Sun, 21 Nov 2021 17:50:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 844D940460;
	Sun, 21 Nov 2021 17:50:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2472EC0032;
	Sun, 21 Nov 2021 17:50:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FDB9C0035
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 803FB40458
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BOweUL0HIYjj
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 615534039C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:58 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ALHE1Kr023349; 
 Sun, 21 Nov 2021 17:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=bsdVUpcZusXIN93pPYI7QDWfbzMOL/q42DR7HFQ3Jl4=;
 b=vQHPmqKmXYweOwQWf8JHXx6V5MzXy/eYJMe571DTcQ2BOdV1ML1VDh9ZrCLRJplATSjr
 kaoJBP0sS4XS6AcK+l5+sZmDSLr90s1NOWIoiOiyHmRBmXsy6wAOuGvnsCkf1zdq6A0P
 ZCzQyTgrl+v9j1Ttx3tQCBLa5Emlzv123VoSMBG6MEJU47atry1h6G1ET5EPcPSdJEL6
 jJzTDnrwX/+5h40hqmO6Au1nNDujFUq120fH7FdiZI0Fedyv0VmCkxzEuFo2EZrcAF/x
 CmYXK/Ry9Xh7DdVAX8880j2Kpu5XsND11QgULQPXhPF+Rn/aOwPQgcl0pZc2OVOrLiNk rQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cerwamd1a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Nov 2021 17:49:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ALHkUY2015043;
 Sun, 21 Nov 2021 17:49:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by userp3030.oracle.com with ESMTP id 3cep4vp60k-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Nov 2021 17:49:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZA59ik3wWeSY5SLsv6PmutulUe4R6BmSVBFyH71/XEGpBr3PxRaCbn5SZml3jdnBq+wIVhjSuXUzBzxhMm0EhMONTgwsA6fTuCOeC5zY6jEzFn6ncbMKoGQ+ZQGQJ0LAOAtORxMayGLqxwy0o7BWg43f2RKlj4eEIEoROoORwfE5S9xJZmsCOektE5Zv+OxdLfXto84kTmZMDn8e6bDZDoc2ZXe11wvskYGJw+FEtqsUsZVf9paOFc+tYotKjkm86xmoud8PUeQeb8/B4zdn6mdqXHkm8TxH/JYRwrVaPaYFWRd/aZjcwvT0XcYiSlht2Z2q3IOsk6YhUeyUPcy52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsdVUpcZusXIN93pPYI7QDWfbzMOL/q42DR7HFQ3Jl4=;
 b=Z8aXPbiw1zIsMtYsr7rodnyb2Yqx2tqidLtdWgFdxyIkznxPaAM137dm4svskRoFb73lkQB09R5ltQedQlnHveUhNfCbtB2BD7m5zaYK5v2m24BmQuWehWpxlt5VsUFpD86YsxLh1D4xj9SqxVXDLK11FrZoRU8sUvSdqp1YnEYiP9gOohAdGRHm206ujnULcfteNdvXxJ/VWkARhdPO8d24tAUAX6ZugOtXN/dN0MT+exL998hF9kwbzWKsyW1AXdJVswvDJR3j1GZ1Xz4G8rIy+5nmndeYQBqo902qln3+P86Xv6MyBwiQ+6Ira9JlZN/uwWrg3QKBIG/bzO8y2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsdVUpcZusXIN93pPYI7QDWfbzMOL/q42DR7HFQ3Jl4=;
 b=mzaPYCbunqLsWdz8JVwYgI9WMTRKd/tKdKtIzIiacJYMZyv2XdAAGwpRjTr9cGzTZzKUKlXNeQR5rMEa/YvxfD5zpj+CyPtPJIgH/Fy8tAqnEadArRN14Wz0NAHtDLHHSyEmhMImszOyto8j4VaK9ow4GLa8gdLC2n4ptafhb7s=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DS7PR10MB5055.namprd10.prod.outlook.com (2603:10b6:5:3a9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19; Sun, 21 Nov 2021 17:49:48 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4713.024; Sun, 21 Nov
 2021 17:49:48 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V5 06/10] fork: add helper to clone a process
Date: Sun, 21 Nov 2021 11:49:26 -0600
Message-Id: <20211121174930.6690-7-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211121174930.6690-1-michael.christie@oracle.com>
References: <20211121174930.6690-1-michael.christie@oracle.com>
X-ClientProxiedBy: CH0PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:610:e7::12) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 CH0PR03CA0217.namprd03.prod.outlook.com (2603:10b6:610:e7::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19 via Frontend Transport; Sun, 21 Nov 2021 17:49:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3829c35-6b02-4741-f995-08d9ad174fc0
X-MS-TrafficTypeDiagnostic: DS7PR10MB5055:
X-Microsoft-Antispam-PRVS: <DS7PR10MB5055463DB5F55139F416591BF19E9@DS7PR10MB5055.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gI0hE4KGb+oyEQtCml7nIBEfG3bnajJMVieidWrSHTX85p3sXqEfOnpcXUXL/kJLZN8eGtjGG/JJDrk+4gW6hgTornud47gVl5GBWcj2i0D6HTQxBeU2M7XMV4ltLU6jnTtzvw7GuAo9ZPgY+e6rBP/xaZ7FNunDxE993rBRqI5E8tKuR1EheQgV/usILqw5OVSttkHsIWi50/hJr2NLQ1hqt4TGMeOrKj1poNg+Xxj1WSsTDRucPMh0vwai/+hsPMEjD77sL56IilC+mn7hZOil1ApTQ1yt+C+TcGpuRcr+JUt+v2zJaY27N38N7/fTjPtLdRPbuwtipxhBzZKihIZsDagiCK32XXAB0LETSygUN+XeFQhOdpWNRvhaRQknaUqJFCxoW3v05Q1r5WNigYE41zF+dUQ/iFjobLj5LESKY6wd5wrj3azkbhDRZjvg8C4uI0/M7Dyk25fcESSznsYuXxv5kiRTy8cbu/BgQ06Zx356DS0GjrkERWO3ksA1uiQfSUWD2U8gW+/02zbfXH9vVushbefqbBs+RnnOU7ZVJUXQauOt8rMF6L98xg0+MDQVgXikuxCruG5cIO1MOuglFALcyZ0UVHcv3G2RL8sKVHnvfF4mjT3IxyiejOs4Rq2FH1GfTNKRdhLChYHXwnunTW27ynFL6ug2Pmrv0IsZe+T0AF6mJILZJpUKgOKJV319ARBmXVR4o8D8V7IkwyLQiPv9lv46+Lpmkn2olHU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(8676002)(66476007)(52116002)(38350700002)(5660300002)(8936002)(1076003)(2616005)(6512007)(6666004)(6506007)(7416002)(66556008)(4326008)(2906002)(316002)(86362001)(921005)(54906003)(508600001)(38100700002)(6486002)(83380400001)(26005)(36756003)(66946007)(186003)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sZwznhr9IeW4e0Opa8MvKSgYJ3TFM243HvayjyRdn1xbEGwe3KjpBvqGIN7y?=
 =?us-ascii?Q?6WJTpftWvy/568Z0l6jHoTcVlza9BQVXtEaw4CKb2Mb6lRIdDg/3KIYBUYcQ?=
 =?us-ascii?Q?Qa1z8YS2MuUAblu//wcSBXlvnlXzDfPWLfsYA4wBOhGXOmQ2kUFKXg/ZKMJS?=
 =?us-ascii?Q?H758co12kW9FCen0fTYweVMDQ1/vTceXSg+IZwxwx8t4CMzEqQ4pxIJPKIy2?=
 =?us-ascii?Q?UACKTkTY+SHX6qU5GnZT4uD4RjN4z+VFYuEIexAved+9w8TfoQ1iOMTzZrL3?=
 =?us-ascii?Q?hpvCq5hCb+4cVJzS+Dj/olG7naQl3EjKbOfzSgIypEiwc2OXc6q4dewfioKk?=
 =?us-ascii?Q?/6d+wI16qzF2lrwnwi6eP7sOevD80Is4jD+PK4pKzD0bpsiCBHBIRXoI1e6Q?=
 =?us-ascii?Q?8iVtW8RPbezRuaGrdRuqdym2Jdbeqx2tM7ECXyQ8ADiPbuM3zdcqmYR38Gnk?=
 =?us-ascii?Q?bUclRfy+y/HB5tNnurBkKdgJc5zgPpvLbHPRsWEpit6/nPO617hJmNwZzpEq?=
 =?us-ascii?Q?MGF3P4I+uocpbLV6dLAHPGZz1uRaviTZUDKBknFC2KZg8HGGON6IKM8ghLVG?=
 =?us-ascii?Q?jHOlopxWMNokryHSuxyByek8/0eonp7yhn486mar+aoIQayY3xiolG7zOtUj?=
 =?us-ascii?Q?YIubgzZYgeiC0wJREJFTxNiWmZo2WhrUqozJlo6pS6jj2tH4WDYRjz6bBPr1?=
 =?us-ascii?Q?28uEp/wZS5La993H8TpTNe27+tLZow5Jv2MxTvlgWoCerQFfPByp6gE9Ca5q?=
 =?us-ascii?Q?vnGR4cEICmk+fRpHlDIFwOfaFw8NEdVVoMslEWA2b4N9Wjlbt7ZRD5HTgXIO?=
 =?us-ascii?Q?ijNq98punHge3sahOZ0SxtHzvdFKe90NZimYiUYV1INyjnPsy4K08y47glQ0?=
 =?us-ascii?Q?syUksBvneeuc41u5bKIfEhe6U1exPlmSNOLiWmT33CWBAPd9lTRp1iTgT99T?=
 =?us-ascii?Q?xxZX8lJsu+EkFiE1BXz7lOk3ZceMIqaISz4gsapznczSABuzI3MXWLlryeM2?=
 =?us-ascii?Q?8b2V6WN60giwTX5IUfViBcS+07xOI75wbR65uWbErGt7bTc3BVpz66COHZNS?=
 =?us-ascii?Q?ePZ2w24l173/ojpPCLnsDprg7ZIHQ8foH0MKJq47C6v7ywJtqcdO3OiwIU//?=
 =?us-ascii?Q?TOHLFVHtkXRHqQ3yNiVO3GUDSuK5hH+hKkj1/n7oTeRjklcbLtdl3+1E8GDK?=
 =?us-ascii?Q?qAX2lYLRaIjcLDMSvOQBEQ8YK2qaFosNew6J+CkzinsJs27r5/UWwV93F7Lu?=
 =?us-ascii?Q?my3qvJlDUAGw8PupOCkbcP5kYNK43wnL/lhmDg0DgoowKBjKlxexVkBeo2MU?=
 =?us-ascii?Q?h0XxOyQw7hXWKXLg6BKhDJpcG2Ynf7EbIUJx8uxoY+d/sCmN9Thx5QwN8/8B?=
 =?us-ascii?Q?22SGSBJN/SW6lNwSaJ3KVdLe4lFVZK5KrTQvcxU61sjZZ9RukchcJffwxjzF?=
 =?us-ascii?Q?pxiK7f1DoV1kn4oOCzcwqvXaZJAowW2B2PPeD/ae8E2Vf6Wz+MPheciEpCaV?=
 =?us-ascii?Q?lE1YU6REo+0hT9AzLstKhrLK/Bsz26RzRtOX6C1DLywyNqRcPARf2b+Xg9ef?=
 =?us-ascii?Q?7HewkjkEz+9S3xOkLBoWe3ORGVAkwlKcG4MmpyJlHU4Dt9mx52gZFWmvq7RD?=
 =?us-ascii?Q?jhOwCfGopJKUTn4ynV51wOvxmZtHldmKZ0NSZyA7CjFoFWr7lmq9TxfzQlsD?=
 =?us-ascii?Q?C2uG9w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3829c35-6b02-4741-f995-08d9ad174fc0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2021 17:49:48.5085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orCYbY1FYKFqk4rTkD6toaltKY4YZ0kCBzCVjeGgZKi8duMwEif31pk63xm4CFbgo2ftl/7WJbsastmt6/2kIzhGCvSLI7hQWBz1lNIdSK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5055
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10175
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111210110
X-Proofpoint-ORIG-GUID: j-2WdCencUYgVZxrDBuh9adsO1AF3wEz
X-Proofpoint-GUID: j-2WdCencUYgVZxrDBuh9adsO1AF3wEz
Cc: Christoph Hellwig <hch@lst.de>
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

[added flag validation code from Christian Brauner's SIG_IGN patch]
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/sched/task.h |  4 +++
 kernel/fork.c              | 71 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ef3a8e7f7ed9..2188be3a3142 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -90,6 +90,10 @@ extern void exit_itimers(struct signal_struct *);
 
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
index 6e6050d588ae..3729abafbdf9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2543,6 +2543,77 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
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
