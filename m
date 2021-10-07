Return-Path: <SRS0=OSH5=O3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8844C4332F
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 21:45:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CC2661283
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 21:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5CC2661283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 03556404CE;
	Thu,  7 Oct 2021 21:45:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y37YNbaiTPrw; Thu,  7 Oct 2021 21:45:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 536A1404A1;
	Thu,  7 Oct 2021 21:45:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16117C0020;
	Thu,  7 Oct 2021 21:45:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2834EC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B19D56071A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="Ad9w9n77";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="L0xpTlZ4"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aVIuQz9lP_yW
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9AD40606C7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:29 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197KYdAu001318; 
 Thu, 7 Oct 2021 21:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=mxWyxb4uR/Sa47xL/c2mXLefcr7NBWn3Z+y1OsW3BXs=;
 b=Ad9w9n77u+jQG4X/ZNXMfgmRy/4ptW9G1WxwN8zvjTxtWg/7D09f7bgo4KfHhpi5zyBY
 TDiULB3wl5erMpUt0uIDzkATHGPYcT5FNnGt7c4v54JWJg0wt5i+Nyi64JG8T61pPb91
 D+m6CI1fsNy6bGzqR/kUzpAd9ARAgMJguqBwFNTPfPFYydxTnY7sStVp5rMt/NrEU95l
 VrJ6syESlAAchCJJYyCt1FMP0ieqHrfzAaeo3KqslT0JbhjkEzjLOuV6PqTqTVBI8sQQ
 K7p4KMZgcbKkQeFE+KtTRohyOoD5rmndX/F4+US6+egUTxXLO5tlEauOrPUL1ft2u9Ci KA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bj1eckwyu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Oct 2021 21:45:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197Le8aR113346;
 Thu, 7 Oct 2021 21:44:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
 by aserp3030.oracle.com with ESMTP id 3bev7x4uhn-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Oct 2021 21:44:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHWTzXpfuYFY9kYHp5Lo6ZFGiOhDR1K+yBFFrQNUDwjhwJt9hnFM1v0dG0YIP4Zgl+7lMgjQdtbcXXwYRdwTUsCEapAfoPBcDvA8ktAG9vIDPdE4BmTI8b0mykOltH86yavafQ9VzMZB2uNof41Y4c1o6DpRx2nP4OPJFk2ooNUfNpOY1fP9gVBpy3X13fVWLpMd7YsjBdaY2iEdvkKHbTCYma5RMapC/0X0K5Zq0O0ycwUcZjeswhx7KT/46GhGXMj/AhUA+VgDTnQBJTP5fSvmffcQNjHXSEEqny7XMC0IgtfxT63xPee9uZJaPV1y7uKoEaxMFScP3nyZQqOPBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxWyxb4uR/Sa47xL/c2mXLefcr7NBWn3Z+y1OsW3BXs=;
 b=TqfVGQLTwzuMpV55oczQPsaeDFsYjHqym4JlpCilLQ0vTExeXvQevxO8KA3Y0bQzJXEwmEtG16cURqT9mdmpHfb/HyDYFO5vttcGkgdxGdqy+Jh6JZ6w2UNVWb976CoXQjF0qfpe3ILvWTuj6iYCOy4QHhAk0miHugfSsKg5PauMwQK56md3ya/SyfO0ni4JG5tuCesbv3N7Yx9enM5m57WzbuA0qcNOoKSgNjgGQ8oVX6LccMDU5ypSsivy7nM8aPwnO43FaYNm/ccJfsVNMdBQ6n1krpQPghYx7qHKzV8a1wxYK3YdKTW4snPlJ6dXaytk0xwumgeNujisHNE+aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxWyxb4uR/Sa47xL/c2mXLefcr7NBWn3Z+y1OsW3BXs=;
 b=L0xpTlZ42rS/JxeTOqJGLURwNC78guMn2zxdYTuS/Sy/0JwGzI37BtsChAO18T+R8jCvhcglT9CZUB9vd2puoztqhdq5YWx/qdpKtb7SHqO2CZrFT82Oi1uJuUdZMLa08k0+Rhpau5OSXXDhDBhS1JpHnKyhEwN6jR11SX5pjaY=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1884.namprd10.prod.outlook.com (2603:10b6:3:106::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.19; Thu, 7 Oct 2021 21:44:57 +0000
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
Subject: [PATCH V4 2/8] fork: move PF_IO_WORKER's kernel frame setup to new
 flag
Date: Thu,  7 Oct 2021 16:44:42 -0500
Message-Id: <20211007214448.6282-3-michael.christie@oracle.com>
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
 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 21:44:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: def7273d-da13-4453-7852-08d989dbb499
X-MS-TrafficTypeDiagnostic: DM5PR10MB1884:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB188418517CFBEF96A40B7690F1B19@DM5PR10MB1884.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: snIp3NTrhrz1ZtWlregBsnAv48MiPdf9BDK4su26ugG3sNX0jOhbsyTZ2JdpH2lcexuo67LzxvcMBXLwnSrw7Y/jDcoEjeFaI7d7Hvpxl+hNt4SFExrBHC9x1IC7GiTJs4ZbcJ7aYvmrY15gm0ViC0xRQXZWEKRB5in4zMp0Jl3Rh0WFP17ZO9sW8IB6rzlKhDzi8kGLomO1FoREry9cD7ZGHXD8MK7pg69XLaeJxU0hW2UMn4AaJU47KP51RzeVrJiS4ih97bVVy6ijX2BJxcIvIl2JNQqLeG0ahieOs1D7a0898c6wBdhbEavnMPV0VvXG0yZOpijnlWwcMw5otd8shRF6e2LCJvbq6/1/uc9SpESqdPzeBm5Cl/TnuEvS/083u6FQwWzAEpY1gU2kIxlHyeEA0EVMClayCj7IXIRON1sHDxksEAAM7QKf9EXvMLxD1g6bibvmWO0Rve5zLCRWBWO8EBwZgeWuCq1Og6Z58HzNmVJ4SNjpKBjO6hh+TuU0+nXUr55rSXioVAg5jSBEb/xOxrVhQW8TH8c33LL2v1KQ+ZmCvM7jP0k7sQ2X3POFlhJur0OC7sXxiI0//ibS1hXk/DjdWnJor7au/IXfvLdGFXc2Vc8ig2QI0l1cfrbGW43kXdnb5hGxNJKLrDC3ZCjkpeRpQiLahExGetn9XucGishTBwaeWfpTmQ1hMbD07gvRy08EOvGuwN2drCJ/AnQMRh7AC8xf29rQ0go=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(52116002)(30864003)(508600001)(6506007)(66556008)(26005)(6512007)(2906002)(83380400001)(4326008)(921005)(1076003)(107886003)(66946007)(956004)(2616005)(186003)(6666004)(8676002)(38100700002)(8936002)(86362001)(36756003)(6486002)(5660300002)(7416002)(38350700002)(66476007)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rA59+ArKk/hvVxLFk0l/ZdJPPy4Ai5T5PxJMZtyiAp9AxImg0zvWJOc90aYO?=
 =?us-ascii?Q?fjtWFcxaEvfI/y7idd7LcaxNzck4oQC5NfsKyaksW8RSg4IyV9t+7yNqWzTj?=
 =?us-ascii?Q?OUETQUOBT2jWlGQng8/1GUxuijuqlcY3e/F04vi0FH4RQj6o1fzMwa+FUH+8?=
 =?us-ascii?Q?EhHVpUubZ6boYaJuVb/aPybvmrD9R9ev8ewaVBq7VfbLvkaboECDeI7FR1ZX?=
 =?us-ascii?Q?8TSrDcpbC68X1IJI6yh1SGbOL+lTBbX/AMApb0eaXdKs3Af1awvuv326mv6j?=
 =?us-ascii?Q?6QGXIy/FVqAAisrytQgVHbieM3XqYFLY0d7m6wTr8Mze8oo7xQbWOAl9lKAj?=
 =?us-ascii?Q?aSIQo/KP4irzWQf1XX9bNJcV7FMKKroLcDIa0KPCS1TocVyokuJh20oe+ECr?=
 =?us-ascii?Q?kZwsIoCZKywzJyiyNCscOlqGp3sSbjVw5+Rm4P6jPjF2//VODZH/ATiJDY1/?=
 =?us-ascii?Q?w8+Qb7dPIMvDbX2cZALv5dLZ9uCCVXvWW6HpaXO/XB54/KmsIUZxbem+3brn?=
 =?us-ascii?Q?PeVo2FoSmXHcbZGJB+i8J6t62taFHVO6KQzKrBEQDtF/K2DgNS0IxXLi0P+U?=
 =?us-ascii?Q?ZMPI9xLimbIdiABk/iLea1Yc4Jqxol0nuMb2ebAUPPwWpUATejjztS01Gwa9?=
 =?us-ascii?Q?mBjv0QthzIsYGRJqL38IuMqjtVvHZyomyOMHbnHh9RmD/hU7xieyWOl6Hfn3?=
 =?us-ascii?Q?GnypB6eD4F58m1L0fqovBKktMbkUqdC62L1huWSrwnbOw09u2Hkib9Dbv1Aa?=
 =?us-ascii?Q?G1szH/55Hfn7JuPeeGP4HsuprYqzIMV0A0ajwfHI/cFw7IB1rxiwKDzpWllZ?=
 =?us-ascii?Q?PwbbukzpFuwY43rG0AOdgnHZnCoPqk9H1G50C8mr4RpZwk2wzh6pSRCc/i7A?=
 =?us-ascii?Q?WKc26VeigdB5VlL/oJ5JtYy2I56lNragdWFScOzulkN3sKcbF9Sk6I6kMtMk?=
 =?us-ascii?Q?Il/UteY5TC60w7krtQb2si/zkkg98Zw8N8sbnX8NQ6KvzoNwh/xLQXPxsw2s?=
 =?us-ascii?Q?z67suu0HDd5Ac9iSQV4SFbWR3TiEKVvb8/b3X84u7HuUUX/Oyn7URfbckutM?=
 =?us-ascii?Q?2gq4zkO7SLODmiSdHsjADd9Q7R5bNzYob073FwOMcw4DPPie9QiJrxXTrwYv?=
 =?us-ascii?Q?Jq5vfJ+C1Mr+69vPzVYSVRofJamMdTX7vfxOLUpBXjFRSuB3n6CIK2Slr4o/?=
 =?us-ascii?Q?nlAYa4ks3N2eycjAEi0svwBa7rDtZlp022Gdve9EkzDwI50KsGvcgnOwwp5r?=
 =?us-ascii?Q?Vx9xJQhgeJV0ohUBZsu/HotjofFH6zqByLzta8VnKvx8/RjoUzjhve2y3EJO?=
 =?us-ascii?Q?f76BfRlIPipFDdJfxKn535nq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def7273d-da13-4453-7852-08d989dbb499
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 21:44:57.2034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23YBvMf1QC9GEqgWgdYzVzdEPQPc/kkhOJ49hvPvGUBG+Sf7nkxwnwNDt3qMt5deis4L0ZGoL6FLbfsScPBJVO1+8+T4SDcFlBdKqjhByLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1884
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110070137
X-Proofpoint-GUID: eYY5DqJG9PVXqn-hYIczjqkS6BXWQHtW
X-Proofpoint-ORIG-GUID: eYY5DqJG9PVXqn-hYIczjqkS6BXWQHtW
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

The vhost worker threads need the same frame setup as io_uring's worker
threads, but handle signals differently and do not need the same
scheduling behavior. This patch separate's the frame setup parts of
PF_IO_WORKER into a new PF flag PF_USER_WORKER.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 arch/alpha/kernel/process.c      | 2 +-
 arch/arc/kernel/process.c        | 2 +-
 arch/arm/kernel/process.c        | 2 +-
 arch/arm64/kernel/process.c      | 2 +-
 arch/csky/kernel/process.c       | 2 +-
 arch/h8300/kernel/process.c      | 2 +-
 arch/hexagon/kernel/process.c    | 2 +-
 arch/ia64/kernel/process.c       | 2 +-
 arch/m68k/kernel/process.c       | 2 +-
 arch/microblaze/kernel/process.c | 2 +-
 arch/mips/kernel/process.c       | 2 +-
 arch/nds32/kernel/process.c      | 2 +-
 arch/nios2/kernel/process.c      | 2 +-
 arch/openrisc/kernel/process.c   | 2 +-
 arch/parisc/kernel/process.c     | 2 +-
 arch/powerpc/kernel/process.c    | 2 +-
 arch/riscv/kernel/process.c      | 2 +-
 arch/s390/kernel/process.c       | 2 +-
 arch/sh/kernel/process_32.c      | 2 +-
 arch/sparc/kernel/process_32.c   | 2 +-
 arch/sparc/kernel/process_64.c   | 2 +-
 arch/um/kernel/process.c         | 2 +-
 arch/x86/kernel/process.c        | 2 +-
 arch/xtensa/kernel/process.c     | 2 +-
 include/linux/sched.h            | 1 +
 include/linux/sched/task.h       | 1 +
 kernel/fork.c                    | 4 +++-
 27 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index a5123ea426ce..e350fff2ea14 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -249,7 +249,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	childti->pcb.ksp = (unsigned long) childstack;
 	childti->pcb.flags = 1;	/* set FEN, clear everything else */
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(childstack, 0,
 			sizeof(struct switch_stack) + sizeof(struct pt_regs));
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index 3793876f42d9..c3f4952cce17 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -191,7 +191,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	childksp[0] = 0;			/* fp */
 	childksp[1] = (unsigned long)ret_from_fork; /* blink */
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(c_regs, 0, sizeof(struct pt_regs));
 
 		c_callee->r13 = kthread_arg;
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 0e2d3051741e..449c9db3942a 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -247,7 +247,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	thread->cpu_domain = get_domain();
 #endif
 
-	if (likely(!(p->flags & (PF_KTHREAD | PF_IO_WORKER)))) {
+	if (likely(!(p->flags & (PF_KTHREAD | PF_USER_WORKER)))) {
 		*childregs = *current_pt_regs();
 		childregs->ARM_r0 = 0;
 		if (stack_start)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 40adb8cdbf5a..e2fe88a3ae90 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -333,7 +333,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 	ptrauth_thread_init_kernel(p);
 
-	if (likely(!(p->flags & (PF_KTHREAD | PF_IO_WORKER)))) {
+	if (likely(!(p->flags & (PF_KTHREAD | PF_USER_WORKER)))) {
 		*childregs = *current_pt_regs();
 		childregs->regs[0] = 0;
 
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index 3d0ca22cd0e2..509f2bfe4ace 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -49,7 +49,7 @@ int copy_thread(unsigned long clone_flags,
 	/* setup thread.sp for switch_to !!! */
 	p->thread.sp = (unsigned long)childstack;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childstack->r15 = (unsigned long) ret_from_kernel_thread;
 		childstack->r10 = kthread_arg;
diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
index 2ac27e4248a4..11baf058b6c5 100644
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -112,7 +112,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 
 	childregs = (struct pt_regs *) (THREAD_SIZE + task_stack_page(p)) - 1;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->retpc = (unsigned long) ret_from_kernel_thread;
 		childregs->er4 = topstk; /* arg */
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index 6a6835fb4242..f17573b66303 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -73,7 +73,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 						    sizeof(*ss));
 	ss->lr = (unsigned long)ret_from_fork;
 	p->thread.switch_sp = ss;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		/* r24 <- fn, r25 <- arg */
 		ss->r24 = usp;
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index e56d63f4abf9..4a58daa56af4 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -338,7 +338,7 @@ copy_thread(unsigned long clone_flags, unsigned long user_stack_base,
 
 	ia64_drop_fpu(p);	/* don't pick up stale state from a CPU's fph */
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		if (unlikely(!user_stack_base)) {
 			/* fork_idle() called us */
 			return 0;
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index 1ab692b952cd..e7474a118410 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -157,7 +157,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	 */
 	p->thread.fc = USER_DATA;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(frame, 0, sizeof(struct fork_frame));
 		frame->regs.sr = PS_S;
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index 62aa237180b6..5b543be324d4 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -59,7 +59,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	struct pt_regs *childregs = task_pt_regs(p);
 	struct thread_info *ti = task_thread_info(p);
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* if we're creating a new kernel thread then just zeroing all
 		 * the registers. That's OK for a brand new thread.*/
 		memset(childregs, 0, sizeof(struct pt_regs));
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 95aa86fa6077..d9ca11dd544f 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -120,7 +120,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	/*  Put the stack after the struct pt_regs.  */
 	childksp = (unsigned long) childregs;
 	p->thread.cp0_status = (read_c0_status() & ~(ST0_CU2|ST0_CU1)) | ST0_KERNEL_CUMASK;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		unsigned long status = p->thread.cp0_status;
 		memset(childregs, 0, sizeof(struct pt_regs));
diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
index 391895b54d13..2dba51d1889c 100644
--- a/arch/nds32/kernel/process.c
+++ b/arch/nds32/kernel/process.c
@@ -156,7 +156,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		/* kernel thread fn */
 		p->thread.cpu_context.r6 = stack_start;
diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
index 9ff37ba2bb60..ce6ad177da15 100644
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -109,7 +109,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	struct switch_stack *childstack =
 		((struct switch_stack *)childregs) - 1;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childstack, 0,
 			sizeof(struct switch_stack) + sizeof(struct pt_regs));
 
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index b0698d9ce14f..d1d189c16676 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -172,7 +172,7 @@ copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	sp -= sizeof(struct pt_regs);
 	kregs = (struct pt_regs *)sp;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(kregs, 0, sizeof(struct pt_regs));
 		kregs->gpr[20] = usp; /* fn, kernel thread */
 		kregs->gpr[22] = arg;
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index 38ec4ae81239..257bec7e67d4 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -197,7 +197,7 @@ copy_thread(unsigned long clone_flags, unsigned long usp,
 	extern void * const ret_from_kernel_thread;
 	extern void * const child_return;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(cregs, 0, sizeof(struct pt_regs));
 		if (!usp) /* idle thread */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 50436b52c213..817847723bff 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1700,7 +1700,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	/* Copy registers */
 	sp -= sizeof(struct pt_regs);
 	childregs = (struct pt_regs *) sp;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->gpr[1] = sp + sizeof(struct pt_regs);
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 03ac3aa611f5..8deeb94eb51e 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -125,7 +125,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	struct pt_regs *childregs = task_pt_regs(p);
 
 	/* p->thread holds context to be restored by __switch_to() */
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* Kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->gp = gp_in_global;
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 350e94d0cac2..f596843ab55c 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -130,7 +130,7 @@ int copy_thread(unsigned long clone_flags, unsigned long new_stackp,
 	frame->sf.gprs[9] = (unsigned long)frame;
 
 	/* Store access registers to kernel stack of new process. */
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(&frame->childregs, 0, sizeof(struct pt_regs));
 		frame->childregs.psw.mask = PSW_KERNEL_BITS | PSW_MASK_DAT |
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 717de05c81f4..e74906f53c3e 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -114,7 +114,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 
 	childregs = task_pt_regs(p);
 	p->thread.sp = (unsigned long) childregs;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		p->thread.pc = (unsigned long) ret_from_kernel_thread;
 		childregs->regs[4] = arg;
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index bbbe0cfef746..978e0bc10ad4 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -296,7 +296,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	ti->ksp = (unsigned long) new_stack;
 	p->thread.kregs = childregs;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		extern int nwindows;
 		unsigned long psr;
 		memset(new_stack, 0, STACKFRAME_SZ + TRACEREG_SZ);
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index d1cc410d2f64..1c45cd5089f4 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -594,7 +594,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 				       sizeof(struct sparc_stackf));
 	t->fpsaved[0] = 0;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(child_trap_frame, 0, child_stack_sz);
 		__thread_flag_byte_ptr(t)[TI_FLAG_BYTE_CWP] = 
 			(current_pt_regs()->tstate + 1) & TSTATE_CWP;
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 457a38db368b..2bc3141cbf01 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -157,7 +157,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 		unsigned long arg, struct task_struct * p, unsigned long tls)
 {
 	void (*handler)(void);
-	int kthread = current->flags & (PF_KTHREAD | PF_IO_WORKER);
+	int kthread = current->flags & (PF_KTHREAD | PF_USER_WORKER);
 	int ret = 0;
 
 	p->thread = (struct thread_struct) INIT_THREAD;
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1d9463e3096b..d88be9dd5dfd 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -178,7 +178,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	task_user_gs(p) = get_user_gs(current_pt_regs());
 #endif
 
-	if (unlikely(p->flags & PF_IO_WORKER)) {
+	if (unlikely(p->flags & PF_USER_WORKER)) {
 		/*
 		 * An IO thread is a user space thread, but it doesn't
 		 * return to ret_after_fork().
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index 060165340612..61ad0bfbd7ea 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -217,7 +217,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp_thread_fn,
 
 	p->thread.sp = (unsigned long)childregs;
 
-	if (!(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (!(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		struct pt_regs *regs = current_pt_regs();
 		unsigned long usp = usp_thread_fn ?
 			usp_thread_fn : regs->areg[1];
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c1a927ddec64..b1027e916be4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1665,6 +1665,7 @@ extern struct pid *cad_pid;
 #define PF_VCPU			0x00000001	/* I'm a virtual CPU */
 #define PF_IDLE			0x00000002	/* I am an IDLE thread */
 #define PF_EXITING		0x00000004	/* Getting shut down */
+#define PF_USER_WORKER		0x00000008	/* Kernel thread cloned from userspace thread */
 #define PF_IO_WORKER		0x00000010	/* Task is an IO worker */
 #define PF_WQ_WORKER		0x00000020	/* I'm a workqueue worker */
 #define PF_FORKNOEXEC		0x00000040	/* Forked but didn't exec */
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 48417c735438..53599a99d7e0 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -19,6 +19,7 @@ struct css_set;
 #define CLONE_LEGACY_FLAGS 0xffffffffULL
 
 #define KERN_WORKER_IO		BIT(0)
+#define KERN_WORKER_USER	BIT(1)
 
 struct kernel_clone_args {
 	u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index 3988106e9609..4f780424de46 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2035,6 +2035,8 @@ static __latent_entropy struct task_struct *copy_process(
 		siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
 	}
 
+	if (args->worker_flags & KERN_WORKER_USER)
+		p->flags |= PF_USER_WORKER;
 	/*
 	 * This _must_ happen before we call free_task(), i.e. before we jump
 	 * to any of the bad_fork_* labels. This is to avoid freeing
@@ -2526,7 +2528,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
 		.stack		= (unsigned long)fn,
 		.stack_size	= (unsigned long)arg,
-		.worker_flags	= KERN_WORKER_IO,
+		.worker_flags	= KERN_WORKER_IO | KERN_WORKER_USER,
 	};
 
 	return copy_process(NULL, 0, node, &args);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
