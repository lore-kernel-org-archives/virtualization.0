Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6331AC4332F
	for <virtualization@archiver.kernel.org>; Sun, 21 Nov 2021 17:50:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAD5B6066D;
	Sun, 21 Nov 2021 17:50:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0i4sivbqaX5y; Sun, 21 Nov 2021 17:50:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 59248607A8;
	Sun, 21 Nov 2021 17:49:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14E45C0032;
	Sun, 21 Nov 2021 17:49:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A93CFC0012
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 88B274036E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="epboAh2w";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="P38g63ep"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7vJLtRlo0lkz
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4F1F44030F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:54 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ALF22Vt016503; 
 Sun, 21 Nov 2021 17:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ZgMkUmaZ3PqHwuBbGmnLaarBZ9YNdqmIlgKkA8Txa+Q=;
 b=epboAh2w/NvL9PeGkAG/l1KwCGx8Sa/JbTEEAVgiFu9GJiT+19I8hiulDzFic75j7gEa
 m3GQOvsmpefz1lG/dXvwoWlcYxgqXBlt2SJiyr7tYIuz7aeDVGomqY2hHolafhmGyE8c
 WrUuTmQ5hvJ0dVoqJXNhc6nObgYdfo+3PhLO18gwBtbUjWKdVhKXo0URzh+tReGxDZV9
 k99Ujkqac1AwLktLHRn5o/ozLh3llRvU7U2pojWJKVLirqkilxxG8AHCXlzuVN/ju6fL
 gqFC5TDMXLeK5FQhbXgDpdbV83AVK0QwDW6KQcUj6OcxmLxREPMJeoPYmh9xA+86pRYz Tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ceqeccjnp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Nov 2021 17:49:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ALHkerr100938;
 Sun, 21 Nov 2021 17:49:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
 by aserp3030.oracle.com with ESMTP id 3ceq2bnn2j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Nov 2021 17:49:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnGWU87fskmp+TEE7ZxNIK3KiJrYYrBYPMjwNawkwsjsRKLSc9Gdke86jStjDRFook67CtIJKCUdHdVkYQ7thBSLmHljvpnBbYfkwgpfZJHuI0uLFEJJWsS7nXF/nuWFdn9A5UOT0RJoLx317ZrOyOmGutpQw6j6DS760Ftk0l9brCMLm0I2pG/PjLbAYEOIhivHKjjXSuVCJ7sHp/xni91A505QiGrPHMvQVjIvJET+WJS5ov+kyToO+4PmF+JeV7qyWe7N6UD8mJKPBrS8EqgDItXrrPigalN8sh/nWvxT/Kwxbd5HdX/+GkOwPXnrhTYulFuLKwU4P1S0L0gNhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgMkUmaZ3PqHwuBbGmnLaarBZ9YNdqmIlgKkA8Txa+Q=;
 b=g+rR0PUfbFQFpRJkYUy2uMb+pgEQgB7HxG9FbYUvo541K97NWnQv7gm/JVgEE//MCXNjJJqO92ma2MxGwVkNOuXi328ompjjJO+G8MKqwXo2Px80YtQW4sMVpAC5vNEKWUtwhsp0+W1tg663bNHIIpaP6MFvuSEM2spoiFPHKaTXAD3S0M4kFjD9MxEmkjR92aHNttEaTPx5YNdUJWMQsA3j7H7dz4miJ++8ETPMlFbA0Q3nFY5EXaPX/zm9Gi1FIsoadG8q5VvEF14V+tvAXmg7dgBdFCK6DIUUaQaHfH40+N5W2Srb7mWbS0LfYRdH2HsfVdVVH10U2wolWDidKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgMkUmaZ3PqHwuBbGmnLaarBZ9YNdqmIlgKkA8Txa+Q=;
 b=P38g63ep4/ocSd+C/m8ku7mMaB7W3nA4l68FXgJp+85v5vCzgzZ0NKxqMyPF+u38jts56Npl/YadwKg8Nv06eNpXT7gzh6LcpfdJVRC+obDYZteqFR0osZP6JQ2zTqXQI0P3gf8xIeB5HFfJhY366vDRd3bglUJYw5M6Ip/3DEs=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DS7PR10MB5055.namprd10.prod.outlook.com (2603:10b6:5:3a9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19; Sun, 21 Nov 2021 17:49:43 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4713.024; Sun, 21 Nov
 2021 17:49:43 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V5 00/10] Use copy_process/create_io_thread in vhost layer
Date: Sun, 21 Nov 2021 11:49:20 -0600
Message-Id: <20211121174930.6690-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: CH0PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:610:e7::12) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 CH0PR03CA0217.namprd03.prod.outlook.com (2603:10b6:610:e7::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19 via Frontend Transport; Sun, 21 Nov 2021 17:49:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b66d79a-ba80-47a1-fecf-08d9ad174ca2
X-MS-TrafficTypeDiagnostic: DS7PR10MB5055:
X-Microsoft-Antispam-PRVS: <DS7PR10MB50557C287BB60671489E615EF19E9@DS7PR10MB5055.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ako+nKYgI2yBzlk2dcY32r4/dXMgzrNFK0ycG+nL5Pac0Iy1I9H8ksPf4+kwou2rUy2q/CFa7ZmiNH7zVPafqaQ3TmHl8wIR8EgGAvkOxSg5ZVUQJ+9qAKYhv4GAUYj2EoLPU7gViOFDgpdfXqSC3cgsPWr0aPcW93rXSVH0oxd437g5xZYBYnzPUxFZBildD3S/OaNEgD0kkn17WJszy1jhpryvo69wzPd5eJ8WQ+5zubpoCZM13qvRThXBIvaYaYCFSpSIba2Lao/HJKd5cPwxK95SIty7sM3PdSp66kd+ekLu34Y/LjVCgUbxUiKQs/RbUxsbtEDecwCOdzLxuwmg4OQ43ZbynGAkxfj0/23Ka9yY+ywjQ1hPPY2IS6voZY7rBwg8fcRIKhSL127lpnGq+Pxf+H9rm+qKPGRPFGH5QnYNAj9tlEAez1r1LKhqXE+O9vLnFMgarxQFzCIly0+sJ72F2Lu50WM7GMmOF1/tYIoHYWoed1mDNWuJwBNBdC/Ytk1l53QrKxF6k3ehbYWfe3ByESgCUwRsHyjTG47j4TB0OvjP8aiaMZNl7TVHccigWixsHRu5kDmwYHOjk+ecCdItNztDOw2z3FXiOoxVfZtRH0+6BdMEj1ZyrsR4dnaCeYfqb5hOWWQXXEjAylWyEwNVPJusRrJJ+bpIZHWhILRG6hdlMU075ISpF8cRezgCv2Fj7E6xrsZ2FRLHMPTrvuC7ASvtnZjUTwGMeYl1XXWn0b/zvBEEPHCayv8pPHefQJnqTVCVcxJtICWWvMuMnQ0EzXtkgAZN7miVPW/3iXkEs4XzhY9KSiuoJ7bT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(8676002)(66476007)(52116002)(38350700002)(5660300002)(8936002)(1076003)(2616005)(6512007)(966005)(6666004)(6506007)(7416002)(66556008)(2906002)(316002)(86362001)(921005)(508600001)(38100700002)(6486002)(83380400001)(26005)(36756003)(66946007)(186003)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OST2/KO4G4TgcGRo8473jKG808UinhS1OHheO3LJfbZWx45htTJUIqvpK60+?=
 =?us-ascii?Q?vYVovnKKj9hYCIDhE+Dy6JdhomjLZ5htt/a27YtLyitYXHABHxTOZ0KJn/kv?=
 =?us-ascii?Q?VR+0Xk8HqQFnivax9UE20HaQK11OIpPdLkgjosKHiW6QMJnDM7+khiCjgIRi?=
 =?us-ascii?Q?P5tRAdeytvbGPrNyvHVnEVBIPvroQAEJpaApBaNpjlaqYy1s8NvSGfs3T4fe?=
 =?us-ascii?Q?sXyTmqbPSAUrdOT+m7i3EkYYumiAa0ZOY0MSSdDXY6Xr1h89hJ/dYjno/oqO?=
 =?us-ascii?Q?BzXV6Rl4AM3JOTD6bXBdMwntIPnCchGcTY8ueXTS7R5XdwtIdX7Zs8A+5len?=
 =?us-ascii?Q?xsnGwAaJKka/2i8y3rHHZZKn8BjMWpDAABUO/ay7wcPRfiheyt3+S1mMOqzS?=
 =?us-ascii?Q?Nqsi13KkjrY89IBl+T6haBlCe3ZPDNftGedYulsqEo2VdrD3YLH2c2PZWj4D?=
 =?us-ascii?Q?PpHG6cXppJshUQIxHet6Zjtz0gMItaL+ZnacdqwChI6HyuhtCqm+V76jigcU?=
 =?us-ascii?Q?W+F++yfK/wMOH2KhnWlZjr1eD/T0tSkrWiFo/cAL80C1m+q8AJ++gsHTf9T9?=
 =?us-ascii?Q?8UqfunzxwXhoeWstsvxe7+cdMC+jMKe2yERPlXd/UEDwp3o56lh4Dw77vvg3?=
 =?us-ascii?Q?s+HpPF058RREYLwqu3W7yfx57GztssQ+QGwi7FK4IsyFk5I2pgqokaaKVHIj?=
 =?us-ascii?Q?hkcONFQJA4p2gFo5lAmasxEgKcEhAujSxh+Xc7t//PfI3Ied11s+OQGm8zlP?=
 =?us-ascii?Q?m0HtjqhTQOdA4Rcsr/BkvdaXd4fKPD8YhWxYrrxCnJUr4tWFPwsHy8KRr+tt?=
 =?us-ascii?Q?fnSq/kZekoipXbnX048v4rBS036mSoq86sawnzeDQgNpJwF1dvDWDGc8YsIb?=
 =?us-ascii?Q?YyGucseMKiryBtbjvFjB8rIrMr/oP/SOsXcsBcArPxm9n6JafNFvbdvY60Xs?=
 =?us-ascii?Q?c9JbxQzaI+m+f+k/TPTuzXUFR7Cx5wAoQKjV0sSlH0P0kjCeOKyP5sF3GAmQ?=
 =?us-ascii?Q?beRR6L8iIB6gBo9XrLvEft4MKU9P7QPsgPL8sqlXNvVuAb5XNbQZpyCDjrjz?=
 =?us-ascii?Q?FBAjpewadT3XcbDRgO7GT/6Wdosgm87EzvkidXy4ZKU71DS07QjJBirajKIy?=
 =?us-ascii?Q?yZTC4+vyjS4yUF1m6rcv2MpnO8qLTr0dEYzIeI0eAmg48ewKFsg/VzDyAEWx?=
 =?us-ascii?Q?6JbpD+hMSyV6g8cgYcli2Xrr4fM9BncfjWvKj6a9oSN3H7tL/Mb4b5X9cILM?=
 =?us-ascii?Q?76aAWdxyzyVP+gT6PFeyCN+Un3vM/m8nkH4OqDe9hKQnxAdMuqOxen4dMtQs?=
 =?us-ascii?Q?K5Yjde9NBEq9+PSfgyV91/ipOEYyJweEIxGyqvRK1gLc6wX8H3k4jsZr4Bsf?=
 =?us-ascii?Q?mzpujF0qJkW5ay+s+CDsTJlX/z8Oex6zG5ihhw7kdX6kDkSIf5QOYTEfOOOs?=
 =?us-ascii?Q?kUtQ9mVkOl+LgD3+WYeqAPAS5HuBN5zEFlHHaFVB2Kuugj/NB81gLtBQgVup?=
 =?us-ascii?Q?A3wm9zkMSYeb1avwCa4cmlX8Z6Zkh2hMzWE9Bq19SfSshc/ihHfKbGqk4sOx?=
 =?us-ascii?Q?SK9xl5aRjxUgQ8SXmopoWF8YWT7/CnkgR4WjD2ZKApbDjk66DAW7Y/FD8kNX?=
 =?us-ascii?Q?5xeoBuVclccesnPyWngcz0qNb/uoqrjqzA6hXnxxPsEfNuqxzC8qbu06h7BK?=
 =?us-ascii?Q?oP136A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b66d79a-ba80-47a1-fecf-08d9ad174ca2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2021 17:49:43.2928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkgG2yu7rR9C/8eN1135/K0N0KhWJo0WFUD7RxEMG3bJaM/sliz47mT/DL2Hz8A21S5qVeUvGbv8FU/I5CKCKhz+27gTQ5eOzkhgHoSNt1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5055
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10175
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=492 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111210110
X-Proofpoint-ORIG-GUID: yV1ynCrrJg5oHvbU5Ev7N1n-em43Ucdw
X-Proofpoint-GUID: yV1ynCrrJg5oHvbU5Ev7N1n-em43Ucdw
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

The following patches made over Linus's tree, allow the vhost layer to do
a copy_process on the thread that does the VHOST_SET_OWNER ioctl like how
io_uring does a copy_process against its userspace app. This allows the
vhost layer's worker threads to inherit cgroups, namespaces, address
space, etc and this worker thread will also be accounted for against that
owner/parent process's RLIMIT_NPROC limit.

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
like that patch several times.

V5:
- Handle kbuild errors by building patchset against current kernel that
  has all deps merged. Also add patch to remove create_io_thread code as
  it's not used anymore.
- Rebase patchset against current kernel and handle a new vm PF_IO_WORKER
  case added in 5.16-rc1.
- Add PF_USER_WORKER flag so we can check it later after the initial
  thread creation for the wake up, vm and singal cses.
- Added patch to auto reap the worker thread.
V4:
- Drop NO_SIG patch and replaced with Christian's SIG_IGN patch.
- Merged Christian's kernel_worker_flags_valid helpers into patch 5 that
  added the new kernel worker functions.
- Fixed extra "i" issue.
- Added PF_USER_WORKER flag and added check that kernel_worker_start users
  had that flag set. Also dropped patches that passed worker flags to
  copy_thread and replaced with PF_USER_WORKER check.
V3:
- Add parentheses in p->flag and work_flags check in copy_thread.
- Fix check in arm/arm64 which was doing the reverse of other archs
  where it did likely(!flags) instead of unlikely(flags).
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
