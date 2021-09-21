Return-Path: <SRS0=rv7y=OL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48358C433EF
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 21:53:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033B660FDA
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 21:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 033B660FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9FD183EBE;
	Tue, 21 Sep 2021 21:53:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 186V9EJMVtwU; Tue, 21 Sep 2021 21:53:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CD4DA83E3F;
	Tue, 21 Sep 2021 21:53:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC73CC001C;
	Tue, 21 Sep 2021 21:53:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02D9AC0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D5E5B83ED1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zvpUfHiiCVuc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5AC8283E9F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:03 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LLE13B009998; 
 Tue, 21 Sep 2021 21:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=5nVhqY9UaE7Ad81U8I+2i/BB81OuBNLspvjClWJ3hSE=;
 b=zKzH/qZEqQeyylT+YgVoEgLPCqMPC2ZBpCSTRVqAvqaMwMC0ORGznrl46ccYrdcclso7
 3uBg77ivmJqUGkay2VarxDZg1iRUfoeiUaiRY8QQHfs292OZhVTT/lOChNzUIUD2FrHM
 trFheXxi1onaPPraFkCRroQ7HIisC6Iv+ZAozkcEXCZp8+8NK/DWuZXYb5TeereIF2oq
 f/3ZhIm+pThTLKC4E4a2iPRAg7tzEx4PfFf/VfVWjFRQKesF/WTXQHpSKRLvGONJUS9l
 EDm8m/aT4zSJ9SmgfoRWnsUb13mTOipYMH6LBw3QvocXaTLXdPoU/sZGVK95BA+EmhR4 XA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4p84km-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Sep 2021 21:52:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18LLomVe154016;
 Tue, 21 Sep 2021 21:52:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
 by aserp3020.oracle.com with ESMTP id 3b7q59s7my-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Sep 2021 21:52:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcK578BwhR4lrhadFJODAk887xJLZYsdoykMTgkaIIRuKSl4EkDi/QLs6EGYcafzSGfuWs+tGShI5cZumXB/nCsI+YBw1ekXKcjOsnwjdzbixxTtFMmklL0O0bKtGxe4byvG8btK5zFVe1hxG9QkGCm1Gi5JG1ef6yw655+yc0q3CccxjJ6iWBh71sUabbh9j7J7qid0Y5TGc9HTHB6kJwxG2t7MU5QTGJkk3NM7RqQM9IJz/aV8Hi/bMT6uUOLicUT+cEmhbdh9jp6coZjFpw49MNSFqenqlOw4MhgDkGEgK4cB+z39cltE6w/NpBMb2t6N2lzNstaAWXpb3I98Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=5nVhqY9UaE7Ad81U8I+2i/BB81OuBNLspvjClWJ3hSE=;
 b=Ifjz0X7TokJWtOTk/chSJ2Zjd0KDQB0Rg028AErazylfTdEBvF62xUjbeYtEvDd45VNwzOHx7R2q5pedI1myIptFq4a9mBym+cdYLei0aL558ZKQ8RNXy0OjzjM4tZdP4CntVAPf2SQcqKMTtNe2YgQSKu4pHzUdRhdKCHVt6aF8+r1WolAXOvesxXaLVjuB/R5Qgeian2C5XgPY7Md16c7+PGjEwhSdj2PyRwVAeEZYoFTsNb0kMRq/bE1lyr9Jwhlw1Kyg5sBTPmOW0Iy3CWTTcb1CZAmlcCReU54btucoDaQWo/VU5oOX1H6SLdDIpf0QpPFPyfXmW/PIKtSC6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nVhqY9UaE7Ad81U8I+2i/BB81OuBNLspvjClWJ3hSE=;
 b=gaNEBhdQ3rLBG5ntJY+0J7hTDypRZqFMTm8PI8MUuKM/xdc63u/ftxaLcSgCZNfYHpbWFWKBhUMIv59mhBDEUkNfXK/DUl+5bt3riqWe8kyx3yPrpd2Xe9HxolfaIwrslYY/jgFCL/mIOtMQJE3TpOdSh2jW/pKjvYFoWfslxtE=
Authentication-Results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BY5PR10MB3892.namprd10.prod.outlook.com (2603:10b6:a03:1fb::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 21:52:32 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701%6]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 21:52:31 +0000
From: Mike Christie <michael.christie@oracle.com>
To: hdanton@sina.com, hch@infradead.org, stefanha@redhat.com,
 jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/9] fork: move PF_IO_WORKER's kernel frame setup to new
 flag
Date: Tue, 21 Sep 2021 16:52:12 -0500
Message-Id: <20210921215218.89844-4-michael.christie@oracle.com>
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
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 21:52:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 484c0cc9-3134-4c8b-1fab-08d97d4a1cd1
X-MS-TrafficTypeDiagnostic: BY5PR10MB3892:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB389286A4720A2C84864FCAFBF1A19@BY5PR10MB3892.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a81tCkbJREykSBZQ5Ck511iqZEo62a3yRimKDok0/a14s+Mz71EVRXP7gOq2WYalXkuEdnbEdPj9g8zVJ3crtdwA9GwK9PxorjS7XhV4Qqz5tW8Lfhn8lmiySiBoNf5o+MfBmSkUgiGuIvSZQPnBIS9AtlTQYb0Adc6ZHykVhIpz9zu5ZZnhnCvZEw2A8JXwUiOOEnpe7ml0hLTxVq6C4wUWiX4vYnsZ1Gcx/j+cF4f0u0REtkTIazfVbfcR+/mMxWANyzaxDb9pEiuiPbMaRc0IB8L0yMzZefQjQf9COSP+u48517Ao7g7gclzdil3qhEGZk3Bgk10spRGXccfzP+BZ3AChJ1BvF9Kp75c0DQKbjUvulBOgdYx9M7gxqHXm2ZuU2HB9SdewnHLKNJI7a9HEyESr6GK1GARPq5a7xHU3IcKYhlR5EL2zHmJkS1Bw/HWPtVBKcyZUqUGz6RsGQ/Peu1OANy3upZmNW86LPhsGAjAbitSt+FsdGiLXjsr9q/jGkS2XnDQYEETjPAMYOJYOphmvtzd/dcfF8DOQWjld/Umjaf01HCzbg2hXWeVXoh4HK5tNPL1nCnw6m9By/m7u30z5RuAN+EiCidD0X/8Myc4lmAdyKiW7M9uMjscRdlKwUxVzUDZRrKW5ycAQPjLXlUkSzlIJRbBeyrJUS/GNKXInVCQ+1P+lJasJH1CKDRGF3oPIuO+YoozViHzjHf2jLTbmX5tCH3qDEoFkGNw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6506007)(52116002)(107886003)(956004)(66946007)(26005)(4326008)(7416002)(66556008)(2616005)(66476007)(86362001)(30864003)(6486002)(8676002)(6666004)(508600001)(316002)(2906002)(6512007)(8936002)(38100700002)(1076003)(5660300002)(83380400001)(186003)(38350700002)(921005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ruaXNR4sHosiRIGoUfmTQIKlSVvzESbEI88lbnpFzBOQW5hB2wL3idi88MZ3?=
 =?us-ascii?Q?0WjyVLe/v8/UsKzpeJxwGY+WaU1GD3ogm4/bKl6K6G4jztncrDa9oaeAGlBG?=
 =?us-ascii?Q?liiLns0Q7ZPOsnJ7n3+9rhI/mAVnFje6sQmKQ/syTAYwTJg9Xag6KlXckaOC?=
 =?us-ascii?Q?ITXXsRXR9lnE9/9CFobbIxEamjYjiDloGXXpE4wGAybeLcH20ImV2FB+0+Ml?=
 =?us-ascii?Q?j3P3J6R0jw7iw1/l9zGn5Q7NRWLQi6/urK7fqwKY+6ff8/qZvnaJBFTK2b+I?=
 =?us-ascii?Q?FCWdddVKIv4HGBZ2NQ7p0CgKgf5P8jbT7sT5Nb+brcJ1FRlEaLM3OYuirZvp?=
 =?us-ascii?Q?2J263eX8pbggyE9AEDricjrYENQbUyxZOEH6izGuJZ32/NSbyDpXnVdvZ7SI?=
 =?us-ascii?Q?Nvp5ND8rpX7winNTcT1Cgy9fqVQQQKzD7/jGDHF1tWJLbOg7qxbmPmklGGs8?=
 =?us-ascii?Q?hoC/jsUbExnMnGreQS1GuWiLgOtkd2sH6oLtt+oryQACpRc2+FlFXl1/VPs6?=
 =?us-ascii?Q?xy+NYQLF0mv9tsII15RO9+2HpT7mL1M06RrYTEw2mELF++D/MHNxw66YFV9N?=
 =?us-ascii?Q?FDkaUZCuleOJzUIETV6CrmBQzeMkD7IfsSd/+ewlbrRuDCYU4VAuxYA/0cXT?=
 =?us-ascii?Q?aCrHZngBFs+F+3iL7+gpmMYKlQtpohtIoqoBNNo8uTgJahCJWlPd67w0AGmx?=
 =?us-ascii?Q?kWwfAD1g4BtW8b7lHFyyE/QjnYz8JdnS4MGJ7XtlCoMomjBekHkL2l9JIkeg?=
 =?us-ascii?Q?s6kXVKqvVtjkBc7V3KuGJuPMG7nowTHGDXlKls73FT6VhPqaVd4NXKoK4PGy?=
 =?us-ascii?Q?/03D8Ngwe9wVuynXfS2j4bxTMTjniOaZp7GQIfXGfAhQN9MHzB09cd/AdrBr?=
 =?us-ascii?Q?4ydrKQ9wzD9rTM0WhcHT8osn+gtp8y3hI+szyxWza8jQOaanWib6ik+nrnLC?=
 =?us-ascii?Q?deU3zVr5cBQ3oKcLWxWrixH2q1481z3K0o9DHByoZEj8Lu7i3E3xlpEBdliY?=
 =?us-ascii?Q?eUc4/J+E7bzWI3P48LBqidwqTT1f/+tXZZT2bYrqAcjFGaAhdoyYQKLeZ60O?=
 =?us-ascii?Q?lUMoliH5ZhgubEMgVy7NYaCeak/MkhBIBqDa99BTL1S5a7DdXYOVOnx95hVn?=
 =?us-ascii?Q?PANqfZ8FdIGDJed7BO0kC3Gc+qVJa0iprBwNagC5aL9imKGtruPmBRhTgHTn?=
 =?us-ascii?Q?/Gk59aBV7zlg5YP6wHtt1vPFMojgW3UvidcZYbQ7gz5TYiXJr+cpsqCa3JYQ?=
 =?us-ascii?Q?aT760lBvVnnbYdqoyfYsHRjuh6eBWfM4nNKdBvOzPAWOqfmGf2LjHEp7PV8w?=
 =?us-ascii?Q?zSKceVGu+ws09scWl2ahvAkD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 484c0cc9-3134-4c8b-1fab-08d97d4a1cd1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 21:52:31.9441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4XEhIjbOqFvdYeHrsoPlNChh6oFYjTwsjuKuqD0h6jMlbGSusy+dTDsa7dXkS7XlNsACzl19yWOKrML/YvPJuAfcE6zq+cDF5bvehVXt0/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3892
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109210130
X-Proofpoint-ORIG-GUID: 9RupoUGtsoMmZ-uREvUnU4Tr1q71R8zq
X-Proofpoint-GUID: 9RupoUGtsoMmZ-uREvUnU4Tr1q71R8zq
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
PF_IO_WORKER into a kernel_clone_args flag, KERN_WORKER_USER.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 arch/alpha/kernel/process.c      | 3 ++-
 arch/arc/kernel/process.c        | 3 ++-
 arch/arm/kernel/process.c        | 3 ++-
 arch/arm64/kernel/process.c      | 3 ++-
 arch/csky/kernel/process.c       | 3 ++-
 arch/h8300/kernel/process.c      | 3 ++-
 arch/hexagon/kernel/process.c    | 3 ++-
 arch/ia64/kernel/process.c       | 3 ++-
 arch/m68k/kernel/process.c       | 3 ++-
 arch/microblaze/kernel/process.c | 3 ++-
 arch/mips/kernel/process.c       | 3 ++-
 arch/nds32/kernel/process.c      | 3 ++-
 arch/nios2/kernel/process.c      | 3 ++-
 arch/openrisc/kernel/process.c   | 3 ++-
 arch/parisc/kernel/process.c     | 3 ++-
 arch/powerpc/kernel/process.c    | 3 ++-
 arch/riscv/kernel/process.c      | 3 ++-
 arch/s390/kernel/process.c       | 3 ++-
 arch/sh/kernel/process_32.c      | 3 ++-
 arch/sparc/kernel/process_32.c   | 3 ++-
 arch/sparc/kernel/process_64.c   | 3 ++-
 arch/um/kernel/process.c         | 3 ++-
 arch/x86/kernel/process.c        | 4 ++--
 arch/xtensa/kernel/process.c     | 3 ++-
 include/linux/sched/task.h       | 1 +
 kernel/fork.c                    | 2 +-
 26 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 6005b0dfe7e2..f7432f921fb2 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -249,7 +249,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	childti->pcb.ksp = (unsigned long) childstack;
 	childti->pcb.flags = 1;	/* set FEN, clear everything else */
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD) ||
+		     worker_flags & KERN_WORKER_USER)) {
 		/* kernel thread */
 		memset(childstack, 0,
 			sizeof(struct switch_stack) + sizeof(struct pt_regs));
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index 4e307e5b5205..4dca64153972 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -191,7 +191,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	childksp[0] = 0;			/* fp */
 	childksp[1] = (unsigned long)ret_from_fork; /* blink */
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD) ||
+		     worker_flags & KERN_WORKER_USER)) {
 		memset(c_regs, 0, sizeof(struct pt_regs));
 
 		c_callee->r13 = kthread_arg;
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 07ae4444b6ab..3d80f8ee2829 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -248,7 +248,8 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	thread->cpu_domain = get_domain();
 #endif
 
-	if (likely(!(p->flags & (PF_KTHREAD | PF_IO_WORKER)))) {
+	if (unlikely(p->flags & (PF_KTHREAD) ||
+		     worker_flags & KERN_WORKER_USER)) {
 		*childregs = *current_pt_regs();
 		childregs->ARM_r0 = 0;
 		if (stack_start)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 7979ec253c29..2fcc2be22d25 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -334,7 +334,8 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 	ptrauth_thread_init_kernel(p);
 
-	if (likely(!(p->flags & (PF_KTHREAD | PF_IO_WORKER)))) {
+	if (unlikely(p->flags & (PF_KTHREAD) ||
+		     worker_flags & KERN_WORKER_USER)) {
 		*childregs = *current_pt_regs();
 		childregs->regs[0] = 0;
 
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index f38b668515ae..17927e15f4ff 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -50,7 +50,8 @@ int copy_thread(unsigned long clone_flags,
 	/* setup thread.sp for switch_to !!! */
 	p->thread.sp = (unsigned long)childstack;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD) ||
+		     worker_flags & KERN_WORKER_USER)) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childstack->r15 = (unsigned long) ret_from_kernel_thread;
 		childstack->r10 = kthread_arg;
diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
index 9a8f6c033ad1..066001ca931a 100644
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -113,7 +113,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 
 	childregs = (struct pt_regs *) (THREAD_SIZE + task_stack_page(p)) - 1;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD) ||
+		     worker_flags & KERN_WORKER_USER)) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->retpc = (unsigned long) ret_from_kernel_thread;
 		childregs->er4 = topstk; /* arg */
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index 664367be55e5..b7593c07a769 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -73,7 +73,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 						    sizeof(*ss));
 	ss->lr = (unsigned long)ret_from_fork;
 	p->thread.switch_sp = ss;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD) ||
+		     worker_flags & KERN_WORKER_USER)) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		/* r24 <- fn, r25 <- arg */
 		ss->r24 = usp;
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index a69cc33b5e32..cbb237ae8b0d 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -339,7 +339,8 @@ copy_thread(unsigned long clone_flags, unsigned long user_stack_base,
 
 	ia64_drop_fpu(p);	/* don't pick up stale state from a CPU's fph */
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD) ||
+		     worker_flags & KERN_WORKER_USER)) {
 		if (unlikely(!user_stack_base)) {
 			/* fork_idle() called us */
 			return 0;
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index ebcea8a1b680..2e17b2f6e299 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -157,7 +157,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	 */
 	p->thread.fs = get_fs().seg;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD) ||
+		     worker_flags & KERN_WORKER_USER)) {
 		/* kernel thread */
 		memset(frame, 0, sizeof(struct fork_frame));
 		frame->regs.sr = PS_S;
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index b8eb544e1fd6..d3dd88b82959 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -59,7 +59,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	struct pt_regs *childregs = task_pt_regs(p);
 	struct thread_info *ti = task_thread_info(p);
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD) ||
+		     worker_flags & KERN_WORKER_USER)) {
 		/* if we're creating a new kernel thread then just zeroing all
 		 * the registers. That's OK for a brand new thread.*/
 		memset(childregs, 0, sizeof(struct pt_regs));
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index d494e1d76e71..0c0819eb22ba 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -120,7 +120,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	/*  Put the stack after the struct pt_regs.  */
 	childksp = (unsigned long) childregs;
 	p->thread.cp0_status = (read_c0_status() & ~(ST0_CU2|ST0_CU1)) | ST0_KERNEL_CUMASK;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD) ||
+		     worker_flags & KERN_WORKER_USER)) {
 		/* kernel thread */
 		unsigned long status = p->thread.cp0_status;
 		memset(childregs, 0, sizeof(struct pt_regs));
diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
index 1ca8900f9d07..828d84acafd3 100644
--- a/arch/nds32/kernel/process.c
+++ b/arch/nds32/kernel/process.c
@@ -157,7 +157,8 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD) ||
+		     worker_flags & KERN_WORKER_USER)) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		/* kernel thread fn */
 		p->thread.cpu_context.r6 = stack_start;
diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
index b49dc6500118..342e2d1a63b9 100644
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -109,7 +109,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	struct switch_stack *childstack =
 		((struct switch_stack *)childregs) - 1;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD) ||
+		     worker_flags & KERN_WORKER_USER)) {
 		memset(childstack, 0,
 			sizeof(struct switch_stack) + sizeof(struct pt_regs));
 
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 7b356a9a8dc7..99cc4b6f4d8f 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -173,7 +173,8 @@ copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	sp -= sizeof(struct pt_regs);
 	kregs = (struct pt_regs *)sp;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD) ||
+		     worker_flags & KERN_WORKER_USER)) {
 		memset(kregs, 0, sizeof(struct pt_regs));
 		kregs->gpr[20] = usp; /* fn, kernel thread */
 		kregs->gpr[22] = arg;
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index d9555ccf1e9c..704a13ebf579 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -198,7 +198,8 @@ copy_thread(unsigned long clone_flags, unsigned long usp,
 	extern void * const ret_from_kernel_thread;
 	extern void * const child_return;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD) ||
+		     worker_flags & KERN_WORKER_USER)) {
 		/* kernel thread */
 		memset(cregs, 0, sizeof(struct pt_regs));
 		if (!usp) /* idle thread */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index d2f2301b0ad1..f397ab3ead2d 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1700,7 +1700,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	/* Copy registers */
 	sp -= sizeof(struct pt_regs);
 	childregs = (struct pt_regs *) sp;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD) ||
+		     worker_flags & KERN_WORKER_USER)) {
 		/* kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->gpr[1] = sp + sizeof(struct pt_regs);
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 3d0e6390f34c..2ee6d896acd0 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -125,7 +125,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	struct pt_regs *childregs = task_pt_regs(p);
 
 	/* p->thread holds context to be restored by __switch_to() */
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD) ||
+		     worker_flags & KERN_WORKER_USER)) {
 		/* Kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->gp = gp_in_global;
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 01b969bb868e..bd3ca46ca131 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -131,7 +131,8 @@ int copy_thread(unsigned long clone_flags, unsigned long new_stackp,
 	frame->sf.gprs[9] = (unsigned long)frame;
 
 	/* Store access registers to kernel stack of new process. */
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD) ||
+		     worker_flags & KERN_WORKER_USER)) {
 		/* kernel thread */
 		memset(&frame->childregs, 0, sizeof(struct pt_regs));
 		frame->childregs.psw.mask = PSW_KERNEL_BITS | PSW_MASK_DAT |
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index d199805552c0..8dd82814bbda 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -114,7 +114,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 
 	childregs = task_pt_regs(p);
 	p->thread.sp = (unsigned long) childregs;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD) ||
+		     worker_flags & KERN_WORKER_USER)) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		p->thread.pc = (unsigned long) ret_from_kernel_thread;
 		childregs->regs[4] = arg;
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 6e04cfc64b99..a95fb7f82116 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -296,7 +296,8 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	ti->ksp = (unsigned long) new_stack;
 	p->thread.kregs = childregs;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD) ||
+		     worker_flags & KERN_WORKER_USER)) {
 		extern int nwindows;
 		unsigned long psr;
 		memset(new_stack, 0, STACKFRAME_SZ + TRACEREG_SZ);
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index b339eaa1f890..78a6d7025b07 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -594,7 +594,8 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 				       sizeof(struct sparc_stackf));
 	t->fpsaved[0] = 0;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD) ||
+		     worker_flags & KERN_WORKER_USER)) {
 		memset(child_trap_frame, 0, child_stack_sz);
 		__thread_flag_byte_ptr(t)[TI_FLAG_BYTE_CWP] = 
 			(current_pt_regs()->tstate + 1) & TSTATE_CWP;
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 0815a43b9f4a..9f4c7a9d9f15 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -158,7 +158,8 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 		u32 worker_flags)
 {
 	void (*handler)(void);
-	int kthread = current->flags & (PF_KTHREAD | PF_IO_WORKER);
+	int kthread = current->flags & PF_KTHREAD ||
+		      worker_flags & KERN_WORKER_USER;
 	int ret = 0;
 
 	p->thread = (struct thread_struct) INIT_THREAD;
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 20d9bab61b14..a904f5524d73 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -178,9 +178,9 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	task_user_gs(p) = get_user_gs(current_pt_regs());
 #endif
 
-	if (unlikely(p->flags & PF_IO_WORKER)) {
+	if (unlikely(worker_flags & KERN_WORKER_USER)) {
 		/*
-		 * An IO thread is a user space thread, but it doesn't
+		 * A user worker thread is a user space thread, but it doesn't
 		 * return to ret_after_fork().
 		 *
 		 * In order to indicate that to tools like gdb,
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index a0ad9f0cc0cf..39defa61c98d 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -217,7 +217,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp_thread_fn,
 
 	p->thread.sp = (unsigned long)childregs;
 
-	if (!(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD) ||
+		     worker_flags & KERN_WORKER_USER)) {
 		struct pt_regs *regs = current_pt_regs();
 		unsigned long usp = usp_thread_fn ?
 			usp_thread_fn : regs->areg[1];
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ffc7c6a384ad..cf7c9fffc839 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -19,6 +19,7 @@ struct css_set;
 #define CLONE_LEGACY_FLAGS 0xffffffffULL
 
 #define KERN_WORKER_IO		BIT(0)
+#define KERN_WORKER_USER	BIT(1)
 
 struct kernel_clone_args {
 	u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index 3c3624786e4d..4b0e8257993b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2527,7 +2527,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
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
