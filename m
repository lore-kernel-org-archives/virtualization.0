Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A35BC433FE
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 19:22:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0527661163
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 19:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0527661163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B349C4017A;
	Mon,  4 Oct 2021 19:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id su5134iDo73j; Mon,  4 Oct 2021 19:22:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D859240015;
	Mon,  4 Oct 2021 19:22:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3759C0011;
	Mon,  4 Oct 2021 19:22:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CF4FC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0AE26405AE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="YuYfIHfQ";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="hvqgSBq3"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kDoIF2DXZs6T
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 177EB405AB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:10 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194IHEfV019244; 
 Mon, 4 Oct 2021 19:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=BY+JfaVugOuhjzQ2Bqe0DhDyXCAWezfBK0nGMTluqaA=;
 b=YuYfIHfQQYvEs5MQJJb7nBHCWdgNB4O70WCgjggOsTN7rbIUmRqlzdAQ1TVEouEHXUbt
 8Y38eQYu1w2A9R4ZwH8eee814LlUTWv0YCo1lFWprS2KgPoDBTk+C3T8yPiuEtkIS6gG
 VQuvvF9WI3PBwY9aRhLvwm3Q2VrKgN96afG8bgNoXx7RKYEVtJxR5rytRcStqJwPZ7mu
 WHfkXZeCU7QHzUNWfuWdKitlgcIUY41nytIhgKB8YCdlDgdFbcnM7IM509gMhbZicdds
 WsvX69dc42NDEfoloj0vuhcGOgzGBld5YDR4txpx7H13GPxGk8T1PbVTzHh3+VBJuNfp 2Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bg3p5aat2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Oct 2021 19:21:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 194JAcLt132330;
 Mon, 4 Oct 2021 19:21:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
 by userp3020.oracle.com with ESMTP id 3bf16rwfhc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Oct 2021 19:21:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVXNSPNBa/zklBoyK5tjZ6V43aPDp6sLTirHqnZl3C/IqdNBYWFP0DSI+hqrAgm7ZVdLpnsnzzFpWZa6duP/zi+JGjvJFRrBwjRxVpatO7HhXJL9knriyeopVhESDPoJlVGYlE0ZgAO0nCT+gPEQ4rK2z170Pfardq9+DiDu/dZ2Cf0/15dxQl8f8hUl/Lkzd5LhsR6EAZlsNO/zd0zxCUt/xwuQcacF5VWnuWLssivgA1tSmbt4S3Cx5ahdVSO3fmcIC9sivW5VnmPsfnOz8Nke0pLZpgWX9mlNAtt/AxgcMnvEW8ucDQSqYXgUKibDNDQCbJFSrtRjq2sIz9on0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BY+JfaVugOuhjzQ2Bqe0DhDyXCAWezfBK0nGMTluqaA=;
 b=NZFlo/Mgf+CxtStU9V/KdMLih380Bat4+ToqjAsQ8BEHXqQ+01t3M2gMXnF4VfDa35Den/6huIUa2kfjVOr8jYesfUuis/LRFl5JJnTzTHYqkvWE/QWsm+6pdbb7aTdY4rPPpTNNqoIZQVdrZLpq+2kUj050NbjQz5ixB8kX2fjot9UFOwEhY0lLUD8rfA4M3OFBa5QnRjdb4P4SjCg9D2k8a+BO+E9VZqAaNPelA5eztON29TZb1WK1FbW8zzrxJwXUfFbI1HEW3cmjOKP/SpS3jTri4PTXgC5UFuIOTHmYFy1Cw8vp7F/qjmznC9PA1BWvf1ceHLPde1h7gX/6hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BY+JfaVugOuhjzQ2Bqe0DhDyXCAWezfBK0nGMTluqaA=;
 b=hvqgSBq3BBlNXkEfSLbv+PPgaNW2MNvBa8ks8MRkXOQU5xuyba6CBltkEAKARiuvbB+4m/xuG/7UgCZaUEhPd7O9VABANFpnRiNQKSoaHmAz5gCXpIXzIj9OHJsjN4N+avaokFJr8vzQ5DkMdKAhIOvSRijFOkpSSgncHlK6Eqc=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB3307.namprd10.prod.outlook.com (2603:10b6:5:1a1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15; Mon, 4 Oct 2021 19:21:37 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 19:21:37 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/9] Use copy_process/create_io_thread in vhost layer
Date: Mon,  4 Oct 2021 14:21:19 -0500
Message-Id: <20211004192128.381453-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: DM5PR15CA0034.namprd15.prod.outlook.com
 (2603:10b6:4:4b::20) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR15CA0034.namprd15.prod.outlook.com (2603:10b6:4:4b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15 via Frontend Transport; Mon, 4 Oct 2021 19:21:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c883166e-3d45-42b4-d8a2-08d9876c2f48
X-MS-TrafficTypeDiagnostic: DM6PR10MB3307:
X-Microsoft-Antispam-PRVS: <DM6PR10MB3307BD1B138CD6D804C18A1BF1AE9@DM6PR10MB3307.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Txvct5jgYZWIrj73qxjos+r5h5TKzmST3Q2wHZCLpulL4MiWoz4cZ/ykOQ40KQwF5U7S8PNDfsbs1AICrG9WJFRaJPzAEJTDjergh8cWSuQNP25/rj9RmNvlKwwHLUw8YoDjvTS3M5TVAAropaHgxI/jB5h9pB5+ZMbRw8bLvPVtvXx2lOwY0cqgjghvm8RZyjPAUCxE//iEOH1wCoDZqLzstDAyqo3uYHHchae9GdhUoqfp5xAYLV0FQ8dj120tEiquIk6AOz10/hSoGemKRBXJPqSWt60tdl/XBtO4boYOz26740tlukxE7tTBG3Y+YttWkHNGxgUuJ4TDSlH8Ve8HEEneqkveW8mBwIK5rRWDjcTrdHq+7Nt0TzBJBq/w5lfyXYSt6X7mFhz+ENRB7Gut2+cD6cUxE23as2CBqezogvYQA2Ok8sbssR007Ws3GhyRH6e3CESA2BHV7UDfIsIqVzMS19lUlNzu6h9rYh4gf7Pns1JQQax7IvcP9pty6MeVdDRRJZqazbuYYA1guWSeqyn5XzTOYbnM88drES3nz+aFz+/Wq+LCF5V09Y9efvNn8DQ1HUFu0X2l2zV7luRZGUeUDkTe7WM/9bLDhBEubkLI/kJ7myWa8GAW8KiBtRUbFWv+AaQTyQ5IsPNu7MjfzigP4nWVLc97LKmm6gdRAAKzyReB3pXpOV98X/Yl4dWpOXMWPWdY2oO91uY+2vbr0yAP2O47h6wGci+1yC+/jM1CSiRx91MAtcm0RjkEMHDa2bmh5ghSd/PKnvL4aqj8ChGNFUlHgLrAelqvdOmKnZITBymXnvQbb4SV87uB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(66946007)(66476007)(66556008)(36756003)(1076003)(6512007)(52116002)(6506007)(83380400001)(2906002)(8676002)(8936002)(6486002)(26005)(6666004)(186003)(5660300002)(2616005)(7416002)(921005)(508600001)(316002)(966005)(956004)(86362001)(38350700002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9YdVZp/c4SO5vO1ddrLbxqjVGxvwuFwl+jbckYji3jhw7VskwglSnD3gb5uk?=
 =?us-ascii?Q?3HPxp/MiRwutSo3weBy89eQiYemQhhi0O7QaSyy7d7ZtLzfTw5z/E2p2Y6Py?=
 =?us-ascii?Q?MiF8yOZ35xAVShRyRhmTmrYVfH/rn+UDAp+GggHO1I+xc1tOQ3UnQTZBZjrk?=
 =?us-ascii?Q?/+Hm8agW471TPODn21KBIWgsL1+usds2FRYiUQ3847bghmmRUQiAa4dfhvrN?=
 =?us-ascii?Q?e+SHe0wB4RooGvdgCqI7N+dN8+E0IqJS9KOtYsTBoRw3VdD61VtumCa3eGiJ?=
 =?us-ascii?Q?9WZLw+JVB/SDqGUf0wkGVgJk4xMQi8l3YchDYrw8vUKO7lUQ9EiW65EBrgKe?=
 =?us-ascii?Q?k30yER0g4neQ3rU5cLWkdwIPjW4o2XRNboRRX7g8OSHK/wuSFVEURpU/VFry?=
 =?us-ascii?Q?Hm/cCK2CVhANFF1e77Oi2SFjNJ7X/D6DQr1HA+R3oYib0YyLqFtwx4+7hhDV?=
 =?us-ascii?Q?tv7tHZc9YHUHvo3MwaRVtuMv6Uo40uRR+n1bwi3jy7K/Pt8FeU9AY9UB6Sm7?=
 =?us-ascii?Q?PHDuP746YTlMY6pavJu6Vy/Iz2v9GG+REkLdixCIgcsbARLHc4ya8kpKNIWe?=
 =?us-ascii?Q?eP8qZ9n7Y1q+wS7nUhMjuArsW/DIvmOJGH/sKc2bOHEnjZDkQl6UvslFCfVh?=
 =?us-ascii?Q?7NwcsQqS/kILBk41bfkJ8+LzPLQhkxcsVrO68WS/XTMxaUOX7DCI0GV6Ti4/?=
 =?us-ascii?Q?yCaqwncEM56KTw9lKEfBHfmErQ4R8yHa7ZEa8Pz6T9kq80Ek4xEPj6mVdDrT?=
 =?us-ascii?Q?m/uqd7mnpihKoEPCapkiNwp2JkoLIkDidi3D8JwI9SCkSWArVcjZK8a7gRlI?=
 =?us-ascii?Q?u6lxupbAJJLo0Hs5w7PwnUkqCKvMy9AifmEquM/+hiZS1zxdJmR1+RsJffcV?=
 =?us-ascii?Q?U7CTiqNN+xqeRZwxIOOxdjKRToEhmosnX1fms+l1Fz2zpp08REIfW9iUF4tL?=
 =?us-ascii?Q?lHL74TdN0dsZWXAweMgG9Wo8VeQqSrNdIXMH4NFahWAdSD5JoIySrnwgMe+b?=
 =?us-ascii?Q?5minH+VTm9oTR30aNOfdlDC1zEw4saYUWIk91Sdi85tCopu0mFGPjR6QD0L8?=
 =?us-ascii?Q?yejJWGw8YcGnQZiXP19vFUQkK+DhadzVl0OCq2LmvS/2xgXoTdNoTmejkgkL?=
 =?us-ascii?Q?8FzlZjDl7RKyRQFXqx21oDvC2qnYcl/zkh3N0RWPS6rQ3CyjfGbk5w4xRql8?=
 =?us-ascii?Q?pCtv/8fh5Ufu6nGsRe7S6NABLfu2Re0SvHaavAIkIi+24L14li7TlncYIz5P?=
 =?us-ascii?Q?f0DW6DiQ6Mu6Tbr1n1JNMEys+BQ0MND/quAkEan8mFo7mWQgaUpjLUnn+fci?=
 =?us-ascii?Q?qldQP6wBBTGAZMsoPYrYCulh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c883166e-3d45-42b4-d8a2-08d9876c2f48
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 19:21:37.0436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7AKlLKrrrvjQ2bUj9/bhZEoZG/GDwZBS3GXIAMEoxwGN7kawv/ZKIN4ZfXMQRWoHnIdbBftUQie4lJBqxVSQqFHWC2cvEwRO8l9mwOwsRK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3307
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=742 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110040131
X-Proofpoint-ORIG-GUID: iYXouoBwAWr0NiGn5bI0lpR5eOoiC33r
X-Proofpoint-GUID: iYXouoBwAWr0NiGn5bI0lpR5eOoiC33r
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

The following patches were made over Linus's tree but also apply over
Jens's for-next io_uring branch and Michaels' vhost/next branch.

This is V3 of the patchset. It should handle all the review comments
posted in V1 and V2. If I missed a comment, please let me know.

This patchset allows the vhost layer to do a copy_process on the thread
that does the VHOST_SET_OWNER ioctl like how io_uring does a copy_process
against its userspace app (Jens, the patches make create_io_thread more
generic so that's why you are cc'd). This allows the vhost layer's worker
threads to inherit cgroups, namespaces, address space, etc and this worker
thread will also be accounted for against that owner/parent process's
RLIMIT_NPROC limit.

If you are not familiar with qemu and vhost here is more detailed
problem description:

Qemu will create vhost devices in the kernel which perform network, SCSI,
etc IO and management operations from worker threads created by the
kthread API. Because the kthread API does a copy_process on the kthreadd
thread, the vhost layer has to use kthread_use_mm to access the Qemu
thread's memory and cgroup_attach_task_all to add itself to the Qemu
thread's cgroups.

The problem with this approach is that we then have to add new functions/
args/functionality for every thing we want to inherit. I started doing
that here:

https://lkml.org/lkml/2021/6/23/1233

for the RLIMIT_NPROC check, but it seems it might be easier to just
inherit everything from the beginning, becuase I'd need to do something
like that patch several times. For example, the current approach does not
support cgroups v2 so commands like virsh emulatorpin do not work. The
qemu process can go over its RLIMIT_NPROC. And for future vhost interfaces
where we export the vhost thread pid we will want the namespace info.

V3:
- Add parentheses in p->flag and work_flags check in copy_thread.
- Fix check in arm/arm64 and xtensa which were doing the reverse of other
  archs in their check for PF_IO_WORKER.
V2:
- Rename kernel_copy_process to kernel_worker.
- Instead of exporting functions, make kernel_worker() a proper
  function/API that does common work for the caller.
- Instead of adding new fields to kernel_clone_args for each option
  make it flag based similar to CLONE_*.
- Drop unused completion struct in vhost.
- Fix compile warnings by merging vhost cgroup cleanup patch and
  vhost conversion patch.



_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
