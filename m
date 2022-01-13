Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE748C433EF
	for <virtualization@archiver.kernel.org>; Thu, 13 Jan 2022 06:05:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4EB09409D6;
	Thu, 13 Jan 2022 06:05:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yfYgk5Mn4XwW; Thu, 13 Jan 2022 06:05:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 88DFC4090C;
	Thu, 13 Jan 2022 06:05:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53CE4C0030;
	Thu, 13 Jan 2022 06:05:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5991C001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:04:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9B374415F2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:04:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="lbmIAuCm";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="L5RZbPlY"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y221rm3j0PnE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:04:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 70476415F1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:04:57 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20D0iomD031717; 
 Thu, 13 Jan 2022 06:04:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=3pXv9bz3uWwdkjkmB+/U9cFQ3Ko8CXgo+/cBWz5Xnrc=;
 b=lbmIAuCmwops6eQ8j9k5TAwWRHZsElLynPO9nxr2yBjQw+Uo1dPpiw22dIHOHV8rFc9R
 KuKsiNoU82+xos8pO5515mFnoh2CFQt/7Sz6+f5zebciKXHSFm5v83A57UNKbuUlbdUT
 J/OO7CrVhXUxfcQjCErrBs0ZoPYanejOErR6aaKYyR8HfdJHox1E3y/ca86zKwf/+KQ9
 4t3JA8O5UuBk5MYzMKHGYH7ov3jSKbb7V+au/d+YMwvTyEGH6MV8KkCamt9ODxyiBgtJ
 f8gtuXVxpeQh+jnQv4s1dsTvzdR5uotYVu9DROYa9b41j4jhvscQCnUrCj5sV+qpwqMk dw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dgmk9g7me-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jan 2022 06:04:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20D5tiXl168433;
 Thu, 13 Jan 2022 06:04:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by userp3020.oracle.com with ESMTP id 3df42qxdw7-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jan 2022 06:04:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUOabmOyvgW4bdr4I3xQ8yKNQUt1cqpPsQcqpRWxdn0JvRhzfbQLmCIoRFn8jSG9P2d7lAZjS/z+0Eopy1+ImKSs0nnzUHEvvIoBoSStmUFWf59AtAtVrW+sV8J2pSMFNC1R+2I16qyyvI8dOcu97buofoPNo3PdaNo+cUqKbYhHCl5l9qDW9YKyDOotRR2ZvBpt7eIJ7sejHQSXpdulCGzeDMLs2NfWHkMqQ24VUFkAlr23+Sw2901epbLMrQktKKPM9mjYAspIPVVVEoya71e8zXsJ+VFKLDFXobFJy1+o0bKDcqi9Qx6mp8vvOBCAeiM3WNWuLjf5S/2A1z1cpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pXv9bz3uWwdkjkmB+/U9cFQ3Ko8CXgo+/cBWz5Xnrc=;
 b=kbq+atL2Ujh44Ims/btdQQBQKi4hQBpcFmiHcMc7xetFc3gPyOy6rRk78GyQWPtuZsxuV+FoME7SwF9RXZQSsX4j7q2YHtcctm2AztI5gh6xoBYf6+IjHdLWlIjLPd1d2EpFW9PMWSLF2cK4nfnyf6zaQ8qizU3xGP/M2IQrA+I4WCDYs97XycyvXGyIIyKvvrK/9x5iv+nYTm3MmY7S1pBlzgs56SlXs9MlkEfAb4wHH+R02BSkUxYD1YwI4EFZc9HbgWaL6YsIwUKKAf8XdpVgYyD/x62m5S5741J3zCDBWXpAcyc1Tr5Y6pgMcahJH1Qcb7Uh9dTzTNKIa9oueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pXv9bz3uWwdkjkmB+/U9cFQ3Ko8CXgo+/cBWz5Xnrc=;
 b=L5RZbPlY0pb/C1BXLKE9BPJkAWkI5r5VzLpraBWqxCNDeiGHifNEryqIDBjVSVccYoEjp80MgNx9GPb2pkLmQ3D6RnMJo/Em4RVk6ZxnOXFb5ChEjz2YewtiuWt1ekvxyDg/jj5maQaPdc/jen3ZqyaKOI8KA/ewn+ZSp4ivLvU=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB5599.namprd10.prod.outlook.com (2603:10b6:a03:3dc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 13 Jan
 2022 06:04:51 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%5]) with mapi id 15.20.4867.012; Thu, 13 Jan 2022
 06:04:51 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: elic@nvidia.com, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH 0/3] fixes for mlx5_vdpa multiqueue support
Date: Thu, 13 Jan 2022 00:10:48 -0500
Message-Id: <1642050651-16197-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-ClientProxiedBy: SA0PR11CA0188.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::13) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6779b6c2-449a-4489-bc42-08d9d65a9c58
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5599:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5599D12E8A912ADB5A9E0CFCB1539@SJ0PR10MB5599.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lbZYW5juiEPQx1YLWpJf3r8odGnxj70jgClr7joLwP/XgUkyNUrJFkEDmq3kXw+XdoJ6OVSjrMajJdj4fASyHAgz9eabzy7Nv3OZDDMfqBx4uZO5mMFHU6X8Cpbyc3WS/req0SZDigTDhKG0jJdRIKG0cdZ7NHse8sVlbj/UBdVRnf5B3HtqQlNa2KFUDNj9uM2oF0HHuKtAMTQdXeg0XVzH0x27W8ffM2Dc/ob1/3nGNMwr4ejsGrxYCSmbx5ZGz1s2i8RgJ6sMOS6TY/QIHhOh/Gn/onVc+QW4vR57XLjWbU4cmFi1lzJmTGyseWEfo4VgR3EHglz7TuqIkmuM0WGHYbvp0pCSBTF6WNdeRk9tlDTvyrD4EaG/h18jZhZT+DFSaqLhKCjgc6pgW7YpzB2KfZZRnoIixxKoUiH7IlGaz5hchi5QzYQJYMg/dmzkltlpQAnxGr49y+2ezf8iPcWUfuOFzmevja5hPCfY72enNEXtamKg6MiYpYABoufcpu+lL9IsqKjr7leRsRru4FYoY+6eZACbtfde7ItHU6egajDJnVEN+6vkauxenn6CYPfnVWm4CU9GDLpj+JhVTPL5LzEvNvy+goHnVg+FrpRPcCNv7sFXjWfHiU/YetlVZbJu0fbWAFa1WMdR5RDX9rS3Ix3dPvIM0wE6+aUbSEPpDdBekaAM4N967bOBTMiUvWYhnk831PhLiTAte+wgOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(83380400001)(36756003)(52116002)(26005)(6506007)(38100700002)(8936002)(8676002)(6486002)(4744005)(2616005)(107886003)(38350700002)(66946007)(508600001)(6666004)(66556008)(2906002)(66476007)(6512007)(4326008)(5660300002)(186003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EKhYC6up1BJ/2gxR/jWznqB9Nbv7Rz1GZ5tM3SL+0bhmldA/LY+t5iOGToh6?=
 =?us-ascii?Q?Fi5IUia5PGaTQ21knUyJRuCxuQGpmZxD21ccrFeQs8p+r0Ua3fmndeCiN7v+?=
 =?us-ascii?Q?I/GhtHAE7m+ZNTK5lzsxDBXNLTYicN8GIaDCj0OaQpFChn4/0VbwNrWxeBgN?=
 =?us-ascii?Q?SvlmUsn1s8lVC5Acg7NvLMWn7HkvNGDGlYflTax2RKZKoAu5wZBIKIXs1409?=
 =?us-ascii?Q?2WCTKUK3R+xjm7JByQG9jQVAm9dQF/CyDg8nNBps+byddyfVVjx5xaNDL24C?=
 =?us-ascii?Q?pBOX3TLA2E6w5xrWBaEp/AeW/Rj4RSupX6wEkdDPwiKJwWIiZl3kgN7KFF3Y?=
 =?us-ascii?Q?QwgZP3fhDuvFTXRtDgyFchzanCuWLLOOtcmzNR5laPq6x26mLBib/YcS0AoF?=
 =?us-ascii?Q?eBkOcXcDw5VFwGDjoyBwcZ07B57sUX8cRfchY8xgFzCEStRbXdBGTrmUAIl4?=
 =?us-ascii?Q?ldkriQBqAd1F+CY6LmKQqC3MtlQ6tblAwF5lxlRE/8xzQ/n4SY5DDMntGyCM?=
 =?us-ascii?Q?EA0CTiTDOrdIrPdOgazrkIbo7kRCC6dl65s1dN0UNDUpiOx6dW6v+5cT9PMe?=
 =?us-ascii?Q?HxAipwxQJDLY72Ccaeh88Uwm0qGfJmNFEXLE2pPOTKeVGWyT+57ha95VCD8G?=
 =?us-ascii?Q?78x0YxhrVsv2HC4HZU3bsy8crRhsAGZWHO16XtU+zE7uhd3loJISq1Ar2ReC?=
 =?us-ascii?Q?5EMFr5EQKiokKrP8PJg7WzsK8kC87Jm7MA9SEQjF9n9Cez66Ah6CyHICXvsl?=
 =?us-ascii?Q?y8vNmdR6IM5t/cssxwnizbrFmu9U7i0AISSAlvczzpV18XafCcKy89XCxeFY?=
 =?us-ascii?Q?Ov7YIl31kUilNN8BnTylrjjVuynAquUzGyTsdzOpg0gSH7e8Y+GJq79PzvDo?=
 =?us-ascii?Q?CAT/XyzTgM3tGnOWpBz1uBISGQlRlHAZfun++KcP9xr6j9FT+DNyW0YvptTr?=
 =?us-ascii?Q?tijR1j2hUMTaeWPGmW1n1BSatPB4opY1vR2PB/HVAAyGnjQRLmmwj/FNdoCu?=
 =?us-ascii?Q?VC4sxbCVzZ9k5WwEIZ/u1WfqW56+Hi9oktJA2EFGv4fsk6DDp1tdyASh9SEx?=
 =?us-ascii?Q?uj2F70eL8R+X+7S+Ukcpto3hR6FfhdIQHxIoonufJM4mV+ZkJ8zhMYwKdV9t?=
 =?us-ascii?Q?AKUpkpnPywTurFEJSwPz0yWLRdMGhCD6wiQtwcVInoLAwSDQGx+z+Fh2Vz/D?=
 =?us-ascii?Q?YcjDF79MkbN6KqJhK8xKDk0CVqM427dJCcCoqQCmq/3FPwItChkyTIc4xuwX?=
 =?us-ascii?Q?5FrCNq4/Rc8DLQ6AITnWwjzFGrfeOi7LHiJ3zUiVTNhKKQYWX1xVtYHHhabn?=
 =?us-ascii?Q?0Qgnxtr6Da9Fo/JQWTqNZND4jR3SAoAjb5zAcPX9nE/+2JUd5fST7pFr06ze?=
 =?us-ascii?Q?4+8kA9nr0FS+ebjM4iqzdNvDQrmNDxe8GAueR8VfXC0sYGwSAPlyiqVijHN9?=
 =?us-ascii?Q?Ol19PFoyend9YKPeTNF0KlchYC6ufU7VTKLxbggwPINup9Yc1TJjgiZarBoz?=
 =?us-ascii?Q?ptmx3/scTsOFryjOKsRmyvzLmip0GUknIIiosakpq9Hz2bRFTKOO0jT8zxf8?=
 =?us-ascii?Q?HSD/dh3SusYr+qRS5212O9KWyR16/tVxc21zCnrkBfAwzKAGiP+UYlRW6/o7?=
 =?us-ascii?Q?g53GFnifF5jQCZO3jEvlQFQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6779b6c2-449a-4489-bc42-08d9d65a9c58
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 06:04:51.0597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SIXKDRjUaGPdZrynxUesFSSgPpS1IegX9kNY2YGZSEYVxYFY8ikj+JcBtPEOoSJDyR2g0/WxDCo8B7LPE4ycg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5599
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10225
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 mlxlogscore=938 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130031
X-Proofpoint-GUID: rFD1NaKgM3cHAI6CnZn41ZXGjB6q8ZbQ
X-Proofpoint-ORIG-GUID: rFD1NaKgM3cHAI6CnZn41ZXGjB6q8ZbQ
Cc: lvivier@redhat.com, eperezma@redhat.com, si-wei.liu@oracle.com
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

This patchset contains the fixes for a few issues uncovered during the
review for the "Allow for configuring max number of virtqueue pairs"
series.

It is based on Eli's fixes:
2e4cda633a22 ("vdpa/mlx5: Fix tracking of current number of VQs")
in the vhost tree.

Si-Wei Liu (3):
  vdpa: factor out vdpa_set_features_unlocked for vdpa internal use
  vdpa/mlx5: set_features should nack MQ if no CTRL_VQ
  vdpa/mlx5: validate the queue pair value from driver

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 26 +++++++++++++++++++++++---
 drivers/vdpa/vdpa.c               |  2 +-
 drivers/vhost/vdpa.c              |  2 +-
 drivers/virtio/virtio_vdpa.c      |  2 +-
 include/linux/vdpa.h              | 18 ++++++++++++------
 5 files changed, 38 insertions(+), 12 deletions(-)

-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
