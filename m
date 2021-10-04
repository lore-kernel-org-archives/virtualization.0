Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD49C433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 19:22:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E86861163
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 19:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E86861163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4B8583934;
	Mon,  4 Oct 2021 19:22:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iq2T-Dt_7WpO; Mon,  4 Oct 2021 19:22:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1DED383926;
	Mon,  4 Oct 2021 19:22:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E14DDC0011;
	Mon,  4 Oct 2021 19:22:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B5CFC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EED96606A9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="lfVgh5uW";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="NRsIvIUW"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JEVLe_59wAGE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B5F80607C8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:11 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194JJB9Z019448; 
 Mon, 4 Oct 2021 19:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=DyVI9qJShUY8jNH4MhhTGAC/4R4PcOxeqy79CYxlIJ8=;
 b=lfVgh5uWGW5Y6UT4I4DCMT6PtjwOmnESk5C+ANQFfkRfb0Wum5HQGfcYmyPpkUHfVTuS
 NbGLNXgNXTn8qXPTd46ZZWxkns4U7WE0YvUggGP85m+prJnO4WIuxnhUqmYCmOe6Hx3a
 f2QLyqZbzQ7PAK3HtXerywsnABNAknVkM1XzQwO8SAgH1g9QwRJL3kAPsnT3PYpN3uYA
 N/oUs7bEI2xoA2oByAxHNPbIf1kOSqW5RVrztJ/Dz0gF/Ole6aCphRXQW+6PEZJAbX/R
 AlC54knLozjDC/g+4XNVpONcIlt1+UuD5wXit3TFF4e31GZqgY1U6fuNXNQsNw3mCpY5 vA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bg3p5aata-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Oct 2021 19:21:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 194JAcLv132330;
 Mon, 4 Oct 2021 19:21:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
 by userp3020.oracle.com with ESMTP id 3bf16rwfhc-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Oct 2021 19:21:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G89sNZcDefB1YEt9qJQa1KCCyDYjzWtLfGe+v11Qeeo2SBH4lV1H54p1dKrvImrCerunWTwXo9KNQ/RVeTtccJbiTPps2rkxTxT3XE9NVs7B6vlhb4JTpd/GtiPDJUSGR/n2VE8edgrKeQOE+kXn5KbJ5Wx5JpdPU+aZsGuMUT9wNWr/fos4iLNmOPZab2Fy0s9wJo7CxnG4Ka56uHzW6tKOCak0r2uoDtWL+a8mVuEkOiJMrJSXRwtgjBVQ2odJRYP5G1i4rgPRr68UQIByqaoMPfi9x3FEJxEWjD9xfAP2Vp19IxIcGsqQjQ5Q6Awed3zlgMXYl2a6dn2E9ubS5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyVI9qJShUY8jNH4MhhTGAC/4R4PcOxeqy79CYxlIJ8=;
 b=SYBGz52sombgQOurDpM6YCjVse7dCPvVZJqPTPPkLfrYhOxO6GhwFnmW5lRUKg2uV/+pYukldFhkdTx3B0fI+7qqODyRj7AMtw+MqTs56Qan2FQwwZIKzWBwsoWzmJ5iHW7OUoBAw8Dp6cpmC5a5ETnbBezgkmzMxIyaByG2jMYtcYNYT+hGPwQ2qtaa6+kpuLpMxR8Jz+AMyuTiuRqT/lPX8mI4+BbngWF5xvaVK3nyaGktqlxcmqxp7l6O7a47ho4hDo61wZMr+9d51HalQSlhcqTjSPhFrewSGjuNcdAMMXuxr+Ej30/eJ08s7CxqUTm/XBHG8z8tiFhOibEYVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyVI9qJShUY8jNH4MhhTGAC/4R4PcOxeqy79CYxlIJ8=;
 b=NRsIvIUWZV6jJiD3nKmNSywDJ+h7BK4eKh3aBhYIV2/hDyja5a5SWti4z/KVq/atweHCwu+k+KQRnPzjYkbasweIeCVuBGZbCnYKQDVXGFY3LEdfKcvonmnp6cnQypVsppVcEs7PU+hC7YODwbV0BOo19Hk4S72u+xlxZBHaC1Y=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB3307.namprd10.prod.outlook.com (2603:10b6:5:1a1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15; Mon, 4 Oct 2021 19:21:38 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 19:21:38 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/9] fork: pass worker_flags to copy_thread
Date: Mon,  4 Oct 2021 14:21:21 -0500
Message-Id: <20211004192128.381453-3-michael.christie@oracle.com>
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
 15.20.4566.15 via Frontend Transport; Mon, 4 Oct 2021 19:21:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f555814-f620-4630-8ac3-08d9876c3025
X-MS-TrafficTypeDiagnostic: DM6PR10MB3307:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB33078846E43E2A1C19AEABDEF1AE9@DM6PR10MB3307.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vT9pAexQTi7pvtYf/hhoK1cV+2EEm0iOKXKKQwmTNpurMlkhFReBkwqBjwCBzm1m39gk8CjUmMgeRS+RJEZZr3x1+vS9T3s+kd9j5YHksD4hYy54tNndK4RgZw8KSro8gCr9NIueucVQ+Kod2KSYceZoy6ckKMQSyMdCjchNpKivWfkJyFTVHsywivrhUwThkGKIg7gfu+sypvATLXuHw4WwfcisJTuAaOO7JxiplDliqpZOmHBP0DjAhrMvPIhuxpsy61QLp6XkJpDiAr5IDMrELop1FXLS8x6GgTbNvaxtKQwPd4GIV/WQcGQvHGEfInAC3Mjd648bcRUiC5B763+B5hL524VlfUVJ0Nbm4UfdE7Ll+cKKubUtAMuybSlkrdTI0qmcaiZiRKdeMfLEjHqufnobBe+I5QhEEoVGhPkaysEDdOE+59tHAOU8dF4+wdpOHaeDSsC9XEFSHVCSbPB/3uAMUS1iDg6i0fBLhSiB4hJ/dmDYTlZmuKchghfNpXNxGI/3R7ma9LnJsTawPJgE7rM4HjFfhPc5AnfGWVy4ifygoRbMgWXUrgwCW+vqHvl/5bPOfcRedtdwCC3bjmvIISSzyRX8PEjhPLe/Kl/IJGty8xxfQaiFYsRogHPs64K+PaMPNs5PJWBRTLKNN8EtGSm5iUo6na2ylOyC4F8j1vdXaDMes85jB2kmUSI/BVsGyeFPApCSebwndw5p5wlre7fG3FtkL58zsfAGEtE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(66946007)(66476007)(66556008)(36756003)(1076003)(107886003)(6512007)(52116002)(6506007)(83380400001)(2906002)(8676002)(8936002)(6486002)(26005)(6666004)(186003)(5660300002)(4326008)(2616005)(7416002)(921005)(508600001)(316002)(30864003)(956004)(86362001)(38350700002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4KkqmUPrqc1inuYtRRykadff3OWLHjIEraQ9TEl8xi2r6CIaiCobNpTqr7h4?=
 =?us-ascii?Q?T+GJl+eySp+ZG7IJ5eY5yXPCYSPw/5SeO6RUvrui2ZhtTtd3YVzlO3Vhwvbe?=
 =?us-ascii?Q?uU9wgpRzxFUttxaeeiB2IIFdrOjMGpGccFTyKr3q28z7TUJRrFKrCr0ZGUWJ?=
 =?us-ascii?Q?W1VQVFkKgckm0wZrQOFppfgMlpV++C75CZSpWpTx7GHFOt6o9OGmeWud/spi?=
 =?us-ascii?Q?v7094Z+U5lhEQj6extd1ikhn472g+OjGCHIRVg2yYb+rCg1H1GMV3RGGhDsV?=
 =?us-ascii?Q?QOgF0LXK36YlBdy007piRSMnU5o4TqgJnEbtkogAqYy9LADBJ/98Rmu8qnnv?=
 =?us-ascii?Q?SkntwbMXGEm7AbJ5/Hvofj50qTVgVvaPDtZyiOh69HCu5wSuyXVnZqkk7bhE?=
 =?us-ascii?Q?/RqYUtZNsDd/L4Ho6OXvX5skk9j3e44SBOl4kFtWk2vxUZkasjQlo+lCxsLt?=
 =?us-ascii?Q?/nwDB65FT9teKlicOOV7qKA4ADuDb1tI82EZYXnjCmy4mIL/bmEtzOd9tjwC?=
 =?us-ascii?Q?/K1Y1JEikIUhTUmiwaV2FaMYyM+cxibPDQ6LKH2MkvpdAg8Lf3Rlo/gwS2tK?=
 =?us-ascii?Q?rurkYQt2jeU3HX3t0GYEQCLvPDw2lXwiiNgZnJsxy1uBQBB4Uc3Yqnd7ZUKT?=
 =?us-ascii?Q?VZhPsr+8IGlURZh97g5h5/D9ETfCCdjvjfJq41CRkOfPP1SQZHXCUQSxl9KB?=
 =?us-ascii?Q?ssxuP3c5uqcv9NAZ3Tte07/Jhct0cFJPFGJ5xKPQ5G9V9PcIDrEbVpzp6l4N?=
 =?us-ascii?Q?+R+1qPoqw2Qe/xTGzksJKbTazmd2fripzNqyrbNTf33PTpvSr7gA2TrzFy8V?=
 =?us-ascii?Q?uQxSU6hGaDQNUGHuE6B3g5IaGnXCv+TQe736ofYxwhm9N/xPG40ImBiUbyra?=
 =?us-ascii?Q?w7HSAa9uuIBurrjFbYFNkaJfEfW2+cv+xDhAgUsLbI60OzqotPNPWURkEnum?=
 =?us-ascii?Q?g5uXcUZv+blOhjvHY5jnWHm/c6egzz6o+Ojx/BzBh7j9bnSEOB0FXuWVMRM4?=
 =?us-ascii?Q?BC7oDa9WCPuRO7A6GCGlhO7dSWO8fA3kLrimJAMtizFYKDTBuFwb8OUrk345?=
 =?us-ascii?Q?6b4Ys8N6NvzeSCx5h8w0YILisTV0f+orM6Flghi3+XwBXyzoP4CGHJlUZ2pF?=
 =?us-ascii?Q?WtfW1AMgbEqJ8fUhEo69nX75ZXmWX8IkJFLN8XYVBVbnVjzJ+7HFi0tTGnQf?=
 =?us-ascii?Q?vGG/zjzw8BH7FO7fUnoM/mTi7IMdI0IpZpQIxFXivcRYlJKwm2c0M6UfEWby?=
 =?us-ascii?Q?TTaTVy55jPWljdg+22i5B6X/BFGVCj25aNUeWwuhevcVkB/PNQY/mX/f2deg?=
 =?us-ascii?Q?mqQN3TLVBlIARIaiSQBRaE00?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f555814-f620-4630-8ac3-08d9876c3025
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 19:21:38.4829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgdtkUj+kcIFlLgI+TUX6RGpZl2r/rqsAPQojdMkWqiO4YHzunZzbSv/6WtTEiMp7HUNk/Ama1P5sSRS9lEUnxjZIiQwI9eZG+PED00W9fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3307
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=952 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110040131
X-Proofpoint-ORIG-GUID: qzdfe4v5oZR_J34DTPHbpJYLVnxLyzEx
X-Proofpoint-GUID: qzdfe4v5oZR_J34DTPHbpJYLVnxLyzEx
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

We need to break up PF_IO_WORKER into the parts that are used for
scheduling and signal handling and the part that tells copy_thread to
treat it as a special type of thread during setup. This patch passes the
worker_flags to copy_thread, so in the next patch we can add new worker
flags that function can see.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/alpha/kernel/process.c      | 2 +-
 arch/arc/kernel/process.c        | 2 +-
 arch/arm/kernel/process.c        | 3 ++-
 arch/arm64/kernel/process.c      | 3 ++-
 arch/csky/kernel/process.c       | 3 ++-
 arch/h8300/kernel/process.c      | 3 ++-
 arch/hexagon/kernel/process.c    | 2 +-
 arch/ia64/kernel/process.c       | 3 ++-
 arch/m68k/kernel/process.c       | 2 +-
 arch/microblaze/kernel/process.c | 2 +-
 arch/mips/kernel/process.c       | 2 +-
 arch/nds32/kernel/process.c      | 3 ++-
 arch/nios2/kernel/process.c      | 2 +-
 arch/openrisc/kernel/process.c   | 3 ++-
 arch/parisc/kernel/process.c     | 3 ++-
 arch/powerpc/kernel/process.c    | 2 +-
 arch/riscv/kernel/process.c      | 2 +-
 arch/s390/kernel/process.c       | 3 ++-
 arch/sh/kernel/process_32.c      | 2 +-
 arch/sparc/kernel/process_32.c   | 2 +-
 arch/sparc/kernel/process_64.c   | 2 +-
 arch/um/kernel/process.c         | 3 ++-
 arch/x86/kernel/process.c        | 2 +-
 arch/xtensa/kernel/process.c     | 2 +-
 include/linux/sched/task.h       | 2 +-
 kernel/fork.c                    | 3 ++-
 26 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index a5123ea426ce..6005b0dfe7e2 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -235,7 +235,7 @@ release_thread(struct task_struct *dead_task)
  */
 int copy_thread(unsigned long clone_flags, unsigned long usp,
 		unsigned long kthread_arg, struct task_struct *p,
-		unsigned long tls)
+		unsigned long tls, u32 worker_flags)
 {
 	extern void ret_from_fork(void);
 	extern void ret_from_kernel_thread(void);
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index 3793876f42d9..4e307e5b5205 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -164,7 +164,7 @@ asmlinkage void ret_from_fork(void);
  */
 int copy_thread(unsigned long clone_flags, unsigned long usp,
 		unsigned long kthread_arg, struct task_struct *p,
-		unsigned long tls)
+		unsigned long tls, u32 worker_flags)
 {
 	struct pt_regs *c_regs;        /* child's pt_regs */
 	unsigned long *childksp;       /* to unwind out of __switch_to() */
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 0e2d3051741e..07ae4444b6ab 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -230,7 +230,8 @@ void release_thread(struct task_struct *dead_task)
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 
 int copy_thread(unsigned long clone_flags, unsigned long stack_start,
-		unsigned long stk_sz, struct task_struct *p, unsigned long tls)
+		unsigned long stk_sz, struct task_struct *p, unsigned long tls,
+		u32 worker_flags)
 {
 	struct thread_info *thread = task_thread_info(p);
 	struct pt_regs *childregs = task_pt_regs(p);
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 40adb8cdbf5a..7979ec253c29 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -316,7 +316,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 asmlinkage void ret_from_fork(void) asm("ret_from_fork");
 
 int copy_thread(unsigned long clone_flags, unsigned long stack_start,
-		unsigned long stk_sz, struct task_struct *p, unsigned long tls)
+		unsigned long stk_sz, struct task_struct *p, unsigned long tls,
+		u32 worker_flags)
 {
 	struct pt_regs *childregs = task_pt_regs(p);
 
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index 3d0ca22cd0e2..f38b668515ae 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -34,7 +34,8 @@ int copy_thread(unsigned long clone_flags,
 		unsigned long usp,
 		unsigned long kthread_arg,
 		struct task_struct *p,
-		unsigned long tls)
+		unsigned long tls,
+		u32 worker_flags)
 {
 	struct switch_stack *childstack;
 	struct pt_regs *childregs = task_pt_regs(p);
diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
index 2ac27e4248a4..9a8f6c033ad1 100644
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -106,7 +106,8 @@ void flush_thread(void)
 }
 
 int copy_thread(unsigned long clone_flags, unsigned long usp,
-		unsigned long topstk, struct task_struct *p, unsigned long tls)
+		unsigned long topstk, struct task_struct *p, unsigned long tls,
+		u32 worker_flags)
 {
 	struct pt_regs *childregs;
 
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index 6a6835fb4242..664367be55e5 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -51,7 +51,7 @@ void arch_cpu_idle(void)
  * Copy architecture-specific thread state
  */
 int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+		struct task_struct *p, unsigned long tls, u32 worker_flags)
 {
 	struct thread_info *ti = task_thread_info(p);
 	struct hexagon_switch_stack *ss;
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index e56d63f4abf9..a69cc33b5e32 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -296,7 +296,8 @@ ia64_load_extra (struct task_struct *task)
  */
 int
 copy_thread(unsigned long clone_flags, unsigned long user_stack_base,
-	    unsigned long user_stack_size, struct task_struct *p, unsigned long tls)
+	    unsigned long user_stack_size, struct task_struct *p, unsigned long tls,
+	    u32 worker_flags)
 {
 	extern char ia64_ret_from_clone;
 	struct switch_stack *child_stack, *stack;
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index 1ab692b952cd..7587291793fb 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -139,7 +139,7 @@ asmlinkage int m68k_clone3(struct pt_regs *regs)
 }
 
 int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+		struct task_struct *p, unsigned long tls, u32 worker_flags)
 {
 	struct fork_frame {
 		struct switch_stack sw;
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index 62aa237180b6..b8eb544e1fd6 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -54,7 +54,7 @@ void flush_thread(void)
 }
 
 int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+		struct task_struct *p, unsigned long tls, u32 worker_flags)
 {
 	struct pt_regs *childregs = task_pt_regs(p);
 	struct thread_info *ti = task_thread_info(p);
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 95aa86fa6077..d494e1d76e71 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -107,7 +107,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
  */
 int copy_thread(unsigned long clone_flags, unsigned long usp,
 		unsigned long kthread_arg, struct task_struct *p,
-		unsigned long tls)
+		unsigned long tls, u32 worker_flags)
 {
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs, *regs = current_pt_regs();
diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
index 391895b54d13..1ca8900f9d07 100644
--- a/arch/nds32/kernel/process.c
+++ b/arch/nds32/kernel/process.c
@@ -150,7 +150,8 @@ DEFINE_PER_CPU(struct task_struct *, __entry_task);
 
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 int copy_thread(unsigned long clone_flags, unsigned long stack_start,
-		unsigned long stk_sz, struct task_struct *p, unsigned long tls)
+		unsigned long stk_sz, struct task_struct *p, unsigned long tls,
+		u32 worker_flags)
 {
 	struct pt_regs *childregs = task_pt_regs(p);
 
diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
index 9ff37ba2bb60..b49dc6500118 100644
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -101,7 +101,7 @@ void flush_thread(void)
 }
 
 int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+		struct task_struct *p, unsigned long tls, u32 worker_flags)
 {
 	struct pt_regs *childregs = task_pt_regs(p);
 	struct pt_regs *regs;
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index b0698d9ce14f..7b356a9a8dc7 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -127,6 +127,7 @@ extern asmlinkage void ret_from_fork(void);
  * @arg: arg to fn for kernel thread; always NULL for userspace thread
  * @p: the newly created task
  * @tls: the Thread Local Storage pointer for the new process
+ * @worker_flags: kernel_clone_args's worker_flags
  *
  * At the top of a newly initialized kernel stack are two stacked pt_reg
  * structures.  The first (topmost) is the userspace context of the thread.
@@ -153,7 +154,7 @@ extern asmlinkage void ret_from_fork(void);
 
 int
 copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
-	    struct task_struct *p, unsigned long tls)
+	    struct task_struct *p, unsigned long tls, u32 worker_flags)
 {
 	struct pt_regs *userregs;
 	struct pt_regs *kregs;
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index 38ec4ae81239..d9555ccf1e9c 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -186,7 +186,8 @@ arch_initcall(parisc_idle_init);
  */
 int
 copy_thread(unsigned long clone_flags, unsigned long usp,
-	    unsigned long kthread_arg, struct task_struct *p, unsigned long tls)
+	    unsigned long kthread_arg, struct task_struct *p, unsigned long tls,
+	    u32 worker_flags)
 {
 	struct pt_regs *cregs = &(p->thread.regs);
 	void *stack = task_stack_page(p);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 50436b52c213..d2f2301b0ad1 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1682,7 +1682,7 @@ static void setup_ksp_vsid(struct task_struct *p, unsigned long sp)
  */
 int copy_thread(unsigned long clone_flags, unsigned long usp,
 		unsigned long kthread_arg, struct task_struct *p,
-		unsigned long tls)
+		unsigned long tls, u32 worker_flags)
 {
 	struct pt_regs *childregs, *kregs;
 	extern void ret_from_fork(void);
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 03ac3aa611f5..3d0e6390f34c 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -120,7 +120,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 }
 
 int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+		struct task_struct *p, unsigned long tls, u32 worker_flags)
 {
 	struct pt_regs *childregs = task_pt_regs(p);
 
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 350e94d0cac2..01b969bb868e 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -95,7 +95,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 }
 
 int copy_thread(unsigned long clone_flags, unsigned long new_stackp,
-		unsigned long arg, struct task_struct *p, unsigned long tls)
+		unsigned long arg, struct task_struct *p, unsigned long tls,
+		u32 worker_flags)
 {
 	struct fake_frame
 	{
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 717de05c81f4..d199805552c0 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -93,7 +93,7 @@ asmlinkage void ret_from_fork(void);
 asmlinkage void ret_from_kernel_thread(void);
 
 int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+		struct task_struct *p, unsigned long tls, u32 worker_flags)
 {
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs;
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index bbbe0cfef746..6e04cfc64b99 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -260,7 +260,7 @@ extern void ret_from_fork(void);
 extern void ret_from_kernel_thread(void);
 
 int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+		struct task_struct *p, unsigned long tls, u32 worker_flags)
 {
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs, *regs = current_pt_regs();
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index d1cc410d2f64..b339eaa1f890 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -575,7 +575,7 @@ void fault_in_user_windows(struct pt_regs *regs)
  * Child  -->  %o0 == parents pid, %o1 == 1
  */
 int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+		struct task_struct *p, unsigned long tls, u32 worker_flags)
 {
 	struct thread_info *t = task_thread_info(p);
 	struct pt_regs *regs = current_pt_regs();
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 457a38db368b..0815a43b9f4a 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -154,7 +154,8 @@ void fork_handler(void)
 }
 
 int copy_thread(unsigned long clone_flags, unsigned long sp,
-		unsigned long arg, struct task_struct * p, unsigned long tls)
+		unsigned long arg, struct task_struct *p, unsigned long tls,
+		u32 worker_flags)
 {
 	void (*handler)(void);
 	int kthread = current->flags & (PF_KTHREAD | PF_IO_WORKER);
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1d9463e3096b..20d9bab61b14 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -117,7 +117,7 @@ static int set_new_tls(struct task_struct *p, unsigned long tls)
 }
 
 int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+		struct task_struct *p, unsigned long tls, u32 worker_flags)
 {
 	struct inactive_task_frame *frame;
 	struct fork_frame *fork_frame;
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index 060165340612..a0ad9f0cc0cf 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -203,7 +203,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 
 int copy_thread(unsigned long clone_flags, unsigned long usp_thread_fn,
 		unsigned long thread_fn_arg, struct task_struct *p,
-		unsigned long tls)
+		unsigned long tls, u32 worker_flags)
 {
 	struct pt_regs *childregs = task_pt_regs(p);
 
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 48417c735438..ffc7c6a384ad 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -68,7 +68,7 @@ extern void fork_init(void);
 extern void release_task(struct task_struct * p);
 
 extern int copy_thread(unsigned long, unsigned long, unsigned long,
-		       struct task_struct *, unsigned long);
+		       struct task_struct *, unsigned long, u32);
 
 extern void flush_thread(void);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 3988106e9609..3c3624786e4d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2200,7 +2200,8 @@ static __latent_entropy struct task_struct *copy_process(
 	retval = copy_io(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_namespaces;
-	retval = copy_thread(clone_flags, args->stack, args->stack_size, p, args->tls);
+	retval = copy_thread(clone_flags, args->stack, args->stack_size, p,
+			     args->tls, args->worker_flags);
 	if (retval)
 		goto bad_fork_cleanup_io;
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
