Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD29C433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 19:22:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8281761166
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 19:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8281761166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A44060865;
	Mon,  4 Oct 2021 19:22:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PqM6Bl5ma_tu; Mon,  4 Oct 2021 19:22:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F322D60868;
	Mon,  4 Oct 2021 19:22:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6968C0020;
	Mon,  4 Oct 2021 19:22:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B4A1C0011
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE8DA83B34
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="sMqQw3VZ";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="iFzM/JKr"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oVLHpuGJR6Fz
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3DEC083934
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:14 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194JD8d7029416; 
 Mon, 4 Oct 2021 19:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=p/ldq7czTM0vqsGbuFaizStUFsB2Ak0qQhejhmA8k+0=;
 b=sMqQw3VZZpGa2S8Uq5yDEiTe8hV1kD/FBzx9B4VBx5RCdc5d03KPXrz3tVKlM4mnvjhs
 xUWkCGtABQjwP+VLzMFbCWaouVgWr6ly6gDeobdgmcLO40/ZcvhhFoiK6OSGrFkqBN0z
 7KTyNYSKGT76ambros0JzSGGIuD9PisfMx3wdAzyshrYqtMhGKHlBJco5YSZ/OVGBeMP
 kzJWK/N4WVNA3VwDGAcLcOgsuacMbldlogUwCDZjpf0ng3GNNBqPj27DFoqb85At12A5
 3hUJs0tuhl4l440I2X37j6me7V7NGHOeN/WeX0swHHznG7TqRQ0qaMw27X3T4PeqFMVm +g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bg42kj15p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Oct 2021 19:21:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 194JAbkq095280;
 Mon, 4 Oct 2021 19:21:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
 by userp3030.oracle.com with ESMTP id 3bf0s5c7jr-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Oct 2021 19:21:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itz7Qx6uVpzN8KhBc4u1L3RerGNvkAjNT0wiCwCfa4xyvqFhFOnRE1B0tQmLE+4OGP4E8cAXBsx/9mGgv5G/1zMlFoNOo7ZVq1P2nj7TsMqg+drtyh4jzRPtQExDFd7HwYmXdLmUXTXeWPAXKhJXe0pRuDk/1Hs76UREOvoEEJ5+9GziUz+NHWHoMrCfGkAu1j0oGZ32ixfA8HawcdOLkxTa1f4YU46FkUEX3SvZU2WTuF7V2kC5V+U+GuzOdJf8sPEQioJaRrvslEs3TyWKBzBsnVXze3aVu2cFYnkma8RJN3tTVqehgMGOItg4DObBeuxwHql5h+jz0OzG+ZfuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/ldq7czTM0vqsGbuFaizStUFsB2Ak0qQhejhmA8k+0=;
 b=bgqxxpZJNrrdWrJ3KcdKAkWiSXC+CUO3b2D9xDxAYdfChqke7nqixugmUpAoNIXjoGyWzcGc1sths3OVpjmPlkp2dsrMlD6q+FUfCzpONmMiPs2NDMMwHuI+5EiRshjnoKcYZcFKKRTukzPYHe1+1uKw2YxW4widCUJyKN+j3Sd3sVHb4OL7PNpYL5Rakv1MHXthQWs8kinQekHvBk/a+Kn21l06RoLTIzIL84bAobJetdFZonKZZFeJLCbdmILsygawxUq/pcvkP1lioFMvLKhFgYzjNdfgeqZxqB5V88ol1rhjyoBGo33KUrpQmOoPjk4vBe67q2/PLL9klt8OAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/ldq7czTM0vqsGbuFaizStUFsB2Ak0qQhejhmA8k+0=;
 b=iFzM/JKrtq8QGIwDaiLn+aH2xTdVSTGQOlrsCJ2nNWZkA+lrnqrlMWJLwHKlLEmD65CPeYvZnLLiKfJEls4bMIAmeDSEf+ggVCzy6KMyUf9qhaAzEX+hsNT0PvHLs9iMzgwDo0C6YaDgtn8BbzAKsnC4VLSOhUljrEEbHPCU3hc=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1548.namprd10.prod.outlook.com (2603:10b6:3:13::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14; Mon, 4 Oct 2021 19:21:41 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 19:21:41 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V3 6/9] io_uring: switch to kernel_worker
Date: Mon,  4 Oct 2021 14:21:25 -0500
Message-Id: <20211004192128.381453-7-michael.christie@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: db64f741-f12b-41f6-d439-08d9876c31f3
X-MS-TrafficTypeDiagnostic: DM5PR10MB1548:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB15489D33E944BC1C52ACB5C8F1AE9@DM5PR10MB1548.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:79;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pyBqjhemeDtFGg2K5iwxqWOshBjMZoIXGV0Cp770Z3SFWdOMjhyFekDXgw7N6PD9dD7+Jyiddy/XjCeMO68D5DVBsWaadgLI1g7m0Rp2o0iROstp/JFQZeDblP20zIt7THp0N1a/w2a+XJuYM8XttZIYLc7bTWAaWpTRGOezDPDoMHTJLXuaIZFuYwUQQ2ECpAC72V9kq3fudB9C3AlPFsvIH8TyrjqzYm8jmdTvbhqDbOM/m4/QWLXb7cFqcCDR/mwvXCOzXkw3MvpIid1Ax2EetRhHgQZSsA09n5ZGgsroDdNeQFqu5zipVHbzNW9nvh2tv3aQSfLHzyEig+u4r3yB/ySBfv5VzBbAhwckAGGIt05vis7gW10XcHbY/ZHuC5PfeoFViGI48Fow8uPwFWUgFiBNLXsFTFwXMsWOE1VevCvlcc3ohwyjI4U7UUVCh4duHhZFBPj5ZnSo0oYXkT+XJtCEoUwGLWfnGb97UD6dXn7FsXf0ylkhEMe3xcUwOL9ArL6kcz1kLQiFeKTZF37cPapca6RnETCMcyooo+uCtr268J2Rd2UP9dVee9jxhTcu3iGF7y2hpO4EmrO6eBs+zplOLgQwcgGDAZp3RG//bxN0zVQUaEotiQYFm0lsgdt2cILUFb7NzbKmwde56rL9lVrYMRrH3JLTShSKiZ49zeAtkVia8QTvzDXYENpjWvhGQP9jdKrwTLHa2JG4R/v2by2hf5N5yq2b3xIitME=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(83380400001)(8676002)(921005)(7416002)(186003)(38100700002)(38350700002)(6506007)(8936002)(4326008)(26005)(508600001)(2906002)(6512007)(6666004)(86362001)(316002)(52116002)(1076003)(36756003)(66476007)(66556008)(66946007)(107886003)(2616005)(956004)(6486002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gHu6N1uyb7QmWV1S5VgGjYTZSgNRQatAFlQTJA6V42Egbumbgro6irsQjwoY?=
 =?us-ascii?Q?nJCjBzWMca4irBJaZ44PMEAwIY7wwA1bFkcWLxf4NmwIgiJufMy6WO8lyuZx?=
 =?us-ascii?Q?Pf/kYJgbEFp5dK3Vx02lV19Nwt0QxdausuytV/HGpTR6P2Lj7vxDXC8u48+b?=
 =?us-ascii?Q?bTQn5LI5WZ6lFx0IsKGlaNk6iAx8LWx+SvCzyFDmAvun4UKHgmKTF8610rxG?=
 =?us-ascii?Q?Q3nOx/XEc7VhiOfc4Fj2V9jcyJ7zj0Lado6LKt4+CfYKtdXtbf+IsPeSW4Ko?=
 =?us-ascii?Q?QGduznCttDRNRwxEDENgMcZO8JuPSM5/xFWsuGrrRWcm9D8PUWZhB4rQF+Kb?=
 =?us-ascii?Q?w17j60xEOVOuXqhGKbgSuHib58dwqZ4qMHQIq7KnK++zAcNSnJSlhhVO3/NH?=
 =?us-ascii?Q?PFp3DhEPfjmUlK6jmanESDaBQjP94+PenTq+pCjmC4DkaWkLpRPV2K3vVVit?=
 =?us-ascii?Q?Rzf+sqsjLwCZGAb7d+ivG6vmRxIwlCEVh3raaXzPRZo79mGbfmDAfIGYZ2kt?=
 =?us-ascii?Q?GTo6huCXleeS07V8BiTI59AMjeafsH8lBESeViavWjsTXjebpVU4wOnwaLqw?=
 =?us-ascii?Q?XVblyT1s+bcjlCiYKm0GJJH8IcSHATYF9CTsTKrCMNTbHzh4o2iuWbq+9dq9?=
 =?us-ascii?Q?fBg0Ags1dQ90HnF5qqUTki2SD4lvcnDsXk89Hz+ehARdjnSRSUvhDzKuCLwQ?=
 =?us-ascii?Q?IBNGC6AUDEwBaUTvTfrsJSrJlpQLv6QtFDpNscbPGWUAqgPedKANd08ezXo4?=
 =?us-ascii?Q?Yv+iSFvg133hIrvYfDucgnQMsi91g6I5scM0g9BAfzz9TQVOeWtUyGU9ihsB?=
 =?us-ascii?Q?E+pHuP6SlPeR3rtWEY2W9TIyPB0R9PJQ6930JJY2ynbpsPHwWyOYwX7tVKiP?=
 =?us-ascii?Q?7ohD4xE+BmmxBRZheH3tuz+q+18ulRY/gfb9+5eIPss/fEHhmCIinBiNMzhR?=
 =?us-ascii?Q?6uGNYhhn7MqwiXbT+4dGpaUKeeXKexKPoYYg9c1dG9tcu82pkOvhCh3nv/lb?=
 =?us-ascii?Q?el7SBoEglvGmpaLnl5RDI0OGERxIjdRISSkzgz8T5aE5O7R9JSrqhO6BXSXt?=
 =?us-ascii?Q?cdyEDRE91MfJjJAEkN8QzGu/ahO/7gUhWrpSwf6xer9nyOIMfZMApC6Eom/C?=
 =?us-ascii?Q?gUGxaJvJQoj52GB+Jx+2XlOiWa/vBkIZcgRDc/UHSMwgDEsc8rr4gnGA+mGd?=
 =?us-ascii?Q?89103VaD8ESlBB3h2BaXLh3F39Qj0mv9sGsvnEfAtgHTsVQCwrH4/7Vjudmv?=
 =?us-ascii?Q?DZS2W5VfYvC7kqn/E5PaYjOjOrP93ZKua6I9U7qCCfClm4ECsaGvG5Tc4pKj?=
 =?us-ascii?Q?3ifhyT3xbcWcfnC2UGVdm16z?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db64f741-f12b-41f6-d439-08d9876c31f3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 19:21:41.5695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUnSBt2utACz/TiiZtLz7XS8SKr7JOPOTxKlcPOvcViY0Cut5eAGBN/tP6NK+/TqYVRRLTGutMqLIhDVVyNapWR1qBQn2ZNP/7Wugs8gKFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1548
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110040131
X-Proofpoint-GUID: -gskAAu-sLLxkCJqTxwY5MMYVLtY0TBs
X-Proofpoint-ORIG-GUID: -gskAAu-sLLxkCJqTxwY5MMYVLtY0TBs
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

Convert io_uring and io-wq to use kernel_worker.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/io-wq.c                 | 15 ++++++++-------
 fs/io_uring.c              | 11 +++++------
 include/linux/sched/task.h |  1 -
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 5bf8aa81715e..a31c260d39c3 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -69,6 +69,9 @@ struct io_worker {
 
 #define IO_WQ_NR_HASH_BUCKETS	(1u << IO_WQ_HASH_ORDER)
 
+#define IO_WQ_CLONE_FLAGS	(CLONE_FS | CLONE_FILES | CLONE_SIGHAND | \
+				 CLONE_THREAD | CLONE_IO)
+
 struct io_wqe_acct {
 	unsigned nr_workers;
 	unsigned max_workers;
@@ -549,13 +552,9 @@ static int io_wqe_worker(void *data)
 	struct io_wqe *wqe = worker->wqe;
 	struct io_wq *wq = wqe->wq;
 	bool last_timeout = false;
-	char buf[TASK_COMM_LEN];
 
 	worker->flags |= (IO_WORKER_F_UP | IO_WORKER_F_RUNNING);
 
-	snprintf(buf, sizeof(buf), "iou-wrk-%d", wq->task->pid);
-	set_task_comm(current, buf);
-
 	while (!test_bit(IO_WQ_BIT_EXIT, &wq->state)) {
 		long ret;
 
@@ -650,7 +649,7 @@ static void io_init_new_worker(struct io_wqe *wqe, struct io_worker *worker,
 	list_add_tail_rcu(&worker->all_list, &wqe->all_list);
 	worker->flags |= IO_WORKER_F_FREE;
 	raw_spin_unlock(&wqe->lock);
-	wake_up_new_task(tsk);
+	kernel_worker_start(tsk, "iou-wrk-%d", wqe->wq->task->pid);
 }
 
 static bool io_wq_work_match_all(struct io_wq_work *work, void *data)
@@ -680,7 +679,8 @@ static void create_worker_cont(struct callback_head *cb)
 	worker = container_of(cb, struct io_worker, create_work);
 	clear_bit_unlock(0, &worker->create_state);
 	wqe = worker->wqe;
-	tsk = create_io_thread(io_wqe_worker, worker, wqe->node);
+	tsk = kernel_worker(io_wqe_worker, worker, wqe->node,
+			    IO_WQ_CLONE_FLAGS, KERN_WORKER_IO);
 	if (!IS_ERR(tsk)) {
 		io_init_new_worker(wqe, worker, tsk);
 		io_worker_release(worker);
@@ -750,7 +750,8 @@ static bool create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 	if (index == IO_WQ_ACCT_BOUND)
 		worker->flags |= IO_WORKER_F_BOUND;
 
-	tsk = create_io_thread(io_wqe_worker, worker, wqe->node);
+	tsk = kernel_worker(io_wqe_worker, worker, wqe->node, IO_WQ_CLONE_FLAGS,
+			    KERN_WORKER_IO);
 	if (!IS_ERR(tsk)) {
 		io_init_new_worker(wqe, worker, tsk);
 	} else if (!io_should_retry_thread(PTR_ERR(tsk))) {
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6b9e70208782..a5970fc182b7 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -7401,12 +7401,8 @@ static int io_sq_thread(void *data)
 	struct io_sq_data *sqd = data;
 	struct io_ring_ctx *ctx;
 	unsigned long timeout = 0;
-	char buf[TASK_COMM_LEN];
 	DEFINE_WAIT(wait);
 
-	snprintf(buf, sizeof(buf), "iou-sqp-%d", sqd->task_pid);
-	set_task_comm(current, buf);
-
 	if (sqd->sq_cpu != -1)
 		set_cpus_allowed_ptr(current, cpumask_of(sqd->sq_cpu));
 	else
@@ -8626,6 +8622,8 @@ static int io_sq_offload_create(struct io_ring_ctx *ctx,
 		fdput(f);
 	}
 	if (ctx->flags & IORING_SETUP_SQPOLL) {
+		unsigned long flags = CLONE_FS | CLONE_FILES | CLONE_SIGHAND |
+					CLONE_THREAD | CLONE_IO;
 		struct task_struct *tsk;
 		struct io_sq_data *sqd;
 		bool attached;
@@ -8667,7 +8665,8 @@ static int io_sq_offload_create(struct io_ring_ctx *ctx,
 
 		sqd->task_pid = current->pid;
 		sqd->task_tgid = current->tgid;
-		tsk = create_io_thread(io_sq_thread, sqd, NUMA_NO_NODE);
+		tsk = kernel_worker(io_sq_thread, sqd, NUMA_NO_NODE,
+				    flags, KERN_WORKER_IO);
 		if (IS_ERR(tsk)) {
 			ret = PTR_ERR(tsk);
 			goto err_sqpoll;
@@ -8675,7 +8674,7 @@ static int io_sq_offload_create(struct io_ring_ctx *ctx,
 
 		sqd->thread = tsk;
 		ret = io_uring_alloc_task_context(tsk, ctx);
-		wake_up_new_task(tsk);
+		kernel_worker_start(tsk, "iou-sqp-%d", sqd->task_pid);
 		if (ret)
 			goto err;
 	} else if (p->flags & IORING_SETUP_SQ_AFF) {
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ba0499b6627c..781abbc1c288 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -87,7 +87,6 @@ extern void exit_files(struct task_struct *);
 extern void exit_itimers(struct signal_struct *);
 
 extern pid_t kernel_clone(struct kernel_clone_args *kargs);
-struct task_struct *create_io_thread(int (*fn)(void *i), void *arg, int node);
 struct task_struct *kernel_worker(int (*fn)(void *), void *arg, int node,
 				  unsigned long clone_flags, u32 worker_flags);
 __printf(2, 3)
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
