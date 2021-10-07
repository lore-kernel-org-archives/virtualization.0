Return-Path: <SRS0=OSH5=O3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40062C433F5
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 21:45:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E762160F23
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 21:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E762160F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9583840A02;
	Thu,  7 Oct 2021 21:45:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QQ_Wv52LOwYe; Thu,  7 Oct 2021 21:45:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3424B409DC;
	Thu,  7 Oct 2021 21:45:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0498CC000F;
	Thu,  7 Oct 2021 21:45:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1D64C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B0AEC84028
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="h9XQGnNe";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="IZTSfYQT"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TqkY1n-5sHsf
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7556284024
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:23 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197KYaOp025384; 
 Thu, 7 Oct 2021 21:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=vOEgKMyw6ykpoZsFUoahvuPME14ABttNwK+tyYVlRCI=;
 b=h9XQGnNecvixcme0SV0Qv1+vG7Lw7PRnw5N8xyUbrJfnbr4sM2AqGPr0USQvh68NFvhv
 tgGf68qOCdrTvW62YG1cI6hMloX71FROoysxIZLo/boU9ZxUF9KI/yyflbtQL834M44Z
 oCCn3GJaqHLcCpIcRCTLu+BoQGbCEcUSfs13biBFKSbXNwXcx1eCn3W/cXZmNuuq98Zc
 l7uwvfFw+fY71pj4e2cE9maBD+SAS1cwZ3AF27d8wQQZvYgsz4gANsoBViFuSpH7BBLG
 AXAIPB28886UZ35aFBfVj+BXTOaOk2ePsJWps9pAfs63mwSHV9jo+bs1H4ig3zW35XDO Jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bhy2dcdsp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Oct 2021 21:44:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197Le8aO113346;
 Thu, 7 Oct 2021 21:44:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
 by aserp3030.oracle.com with ESMTP id 3bev7x4uhn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Oct 2021 21:44:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7PU4fSlNiXP4viXgdTkOfnRt8Hu4mY4TnlBJTYKrpEBVVFqL6vDUa4CI0d8KrO2F3JOyewNaTvvfGRAHHS1mKLWedMjcOTvrYv2gnqnrHHFFTLqvGLGHenzNjgv9hDPFRA2GKrkn8wxYT9oXAM18HH1t6Eqw3VA7tBPPlzyF3sjN0hBaMUAo59pgEeARUNMgwx9O2Jy5WTjZUNsjwqBN1XIpB5/rwXJZfpIe9DtwtslCD8+rU/l6lnOasNAbK94zIEcWdUbCrmi+8cMRW/3AE00KeVqhSU4nuTopsLoYxHHoUJr+LsN1M38favVth91ovPwwnBLpzT5YvDPnBaurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOEgKMyw6ykpoZsFUoahvuPME14ABttNwK+tyYVlRCI=;
 b=Uq/JwIT9Jlp/s5xWjtZs5MRRy3WJ8UpSe5zqJ/+qvhesU4KwdsCMdbiRXsuONk1AkVN0yWZxHppoum3RdQoSA4pcO0YbH0OeLWXiG7Yib5zMYrptvikg33NuvPfv4ur+iZsQS7au3IvuN9aRxMydqJh5EwMkQkZeGw8b8e4kgshs/g12lqedFjvfJzSgYICPNw2HaZ+oDpKZE5z2zJrzU3e6K3hODG2RjuzQB1c45SnTujsH3l5WRCHcgVrn4NGMO3OUDdHDlJK5t8bSMoy7sa0MfXbeSMbM5IVHb0ocWQWWMkvGrVZzcrkoei1bTOMDZVCQ1w4NS7RobVWYDIgNBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOEgKMyw6ykpoZsFUoahvuPME14ABttNwK+tyYVlRCI=;
 b=IZTSfYQT4MAeX624wKP1QqJVDv/+NPRHzTS54E5zZ/E4rMcpbFeXPXCSyZJJNnnANtq4+4QMgSfxBULc/KVBX8pL6Cb7aZ526wx/zFOBCAKLCCTjhV/W4Gy6NNZuaAa8oY+6IlYeG8UjPtlSEGUwEYVckcvd3huaJCQkdHM4kHc=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1884.namprd10.prod.outlook.com (2603:10b6:3:106::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.19; Thu, 7 Oct 2021 21:44:56 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531%5]) with mapi id 15.20.4587.021; Thu, 7 Oct 2021
 21:44:56 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/8] Use copy_process/create_io_thread in vhost layer
Date: Thu,  7 Oct 2021 16:44:40 -0500
Message-Id: <20211007214448.6282-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: DM5PR20CA0008.namprd20.prod.outlook.com
 (2603:10b6:3:93::18) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR20CA0008.namprd20.prod.outlook.com (2603:10b6:3:93::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 21:44:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce0daf24-e039-4c80-9502-08d989dbb3e4
X-MS-TrafficTypeDiagnostic: DM5PR10MB1884:
X-Microsoft-Antispam-PRVS: <DM5PR10MB18841890149C27958C96459DF1B19@DM5PR10MB1884.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXkpXTwgtkoo7poxYNFTtcBp5LyMAywDxI2x38juOW4dwGnOq69hCwYmVnbqVm66Q79dYuuChocFKJ22Xinqdn8dNPXzUXfdjThNUHmodEbnIeVRwarskIXLsHGNxnSvFEnlLGy4aFsr/b2DBMWbfp81LstVOLbWBGGrQoT4b718KqWHHmmgf5XVcPNhspg/HeZe/z742kG/ay/yx5CtDhH+WCkGbx69g3uzzVY+Sx4q/L/fZ1na+LnXYfVmEk05r6Ftgc/8kDfnAVDC1XVV5bi9MgEje4zYx5hKAW7ARWXmh8DdrJ4XJM4Eoj8NVHdwaQLK46bpjhSgFuWLDMwyoGVKechqa+qGml6fWqNyrgoTKEvv0uA4blwBAodG1MLXPERfWvWxyEljBsf3z76oxWVtkS4XsV0WHxngX7aEBaelc55sfB0F3bGT1cAvd91cjoyB5qPU9k/ZSAEM+/QMMf4q9wbULfUK0y+wU4rqOuzxEXbyrD0/aGKU4ic97UoDHQQFlcqU/i9NX8IJHTU8T/o/WDOY350g6HOlprnRwPiVhur8r6mTnR+SCpJkN5vzJQKP6DAc2/Hup5NIEq6HFVK/TnLTh8OvspR+t1plA2sa8v5na9sgkYZKqpPsbma/i1wsWRuuvn6TGTUhnImMIUB7RGOmz2V3XkBLpZDQrAyY/8SoMrnSP3VGXgN21oaypB2LhTp0Ls54d1OpHR3HSpBLYy8Vjx6CH3XBZwTZKA/Se7ISuW+Z9hC78PgfaCfSPHqUmBwYN8LgqpC+QXrDn3n0bMJVi4qjr4Im7a8hv5w3bofHqrQgbCS/qpuZSKZV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(52116002)(508600001)(6506007)(66556008)(26005)(6512007)(2906002)(83380400001)(921005)(1076003)(66946007)(956004)(2616005)(186003)(6666004)(8676002)(38100700002)(8936002)(86362001)(36756003)(966005)(6486002)(5660300002)(7416002)(38350700002)(66476007)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f2s4CxLy/a+ywETvQARBvja3YoX791x8bTc9pB6BjXRqGX9IDz2ZiALjapzk?=
 =?us-ascii?Q?/uqC4DP9JkCXAyKbc0O9GDynJ7bvhNXlwy5/io25Af4yHEwmES6+DlwtzUWc?=
 =?us-ascii?Q?gsKmCdH58DqMSMwz6muMYO6SzWgGSEZ2wlGA7SA9G2mfnRFmObRqlvz2SDjg?=
 =?us-ascii?Q?+H2szV0+KLMEukIrSjrwbIi2ljB/Hdoa4GH2bsJ5BgtQyY/mqoP7nHiX0ipg?=
 =?us-ascii?Q?DyIKzMCm5DSlRZwnhWTP7/1xvwxWtZUhanwjohd8IhDt5+2zfkByqEr+20n1?=
 =?us-ascii?Q?yHHiUTwF77cOPpR9RyEpV/QYZUr/dbQhJS7mAspab67cDBz9Gs7W+6i0Bl8J?=
 =?us-ascii?Q?UlnjwrGTuHsg8jBdFoTelAcUROq0EtZIVddC9RPQ5rMjnXIJOFbrZskQmNwH?=
 =?us-ascii?Q?72+gL7ZxGK6E6rRd8UolxZrdzIdXWmMpNb9gVcycFX3+A1eJ6+h5WdoPck2R?=
 =?us-ascii?Q?ZlAu1o69r5k7rT+Bi0IMQAPWCK4vS/ZgM5rcwNDTWTdVLdvNid4UZJI35Zbt?=
 =?us-ascii?Q?zO3lS3pEqODS65eTK1yUX+oh5CAzITUyRPPKZxvUXpZ7mdV9HZMPhgFqg3C6?=
 =?us-ascii?Q?iV+LsbARryeIvM5hUNnLK54R0dGP69ppBVPJM/UvV6CiftQ1UaqGy9K8fVf2?=
 =?us-ascii?Q?DZS80GkCkDZNaHAHT4OK9qeqHDtX1mwSOwRucUfKUOWRavuVSwgkRWdJNxRL?=
 =?us-ascii?Q?yI8Y9xuXSSNu1pqMdGcUbMSDYDZu3wHK3UgVRN6/TnzsgXcnoqSp0o1bJjfe?=
 =?us-ascii?Q?BWi1tGTF0N4/42Ev5wBuwRg9qaMnCjg9vj1UglgVh4jRyuZLzUYt3ZzMGg6h?=
 =?us-ascii?Q?BnX6N/elDdBx+CDhnhwFbqxMP6S1ZMvq0ESTaLojHXH5q4Jafy2PMC6FvTJo?=
 =?us-ascii?Q?xP09FszoXFd4KJshxcHTQsuTf1PuBSHpL67GWUwNQK2gS9p3blwLWhMUpJtr?=
 =?us-ascii?Q?Y3QJOcwDh+Q/MMtf87XnEdEsybPl++ZX6uUI3OCBHIxeiV3Y6PaejLt3c7Jx?=
 =?us-ascii?Q?yRC53cCvZuiDi3iqb90HfkTdfe6ZQRTU0XZlO7nvbRP+L0VAffo/XFS+zyrS?=
 =?us-ascii?Q?YPkd9Dh8Sq81j2QCWb7o9qyYBzoNTjHWMxzyZosqUM6EzVusxt59x6m4VGA1?=
 =?us-ascii?Q?5GGNKZfi3ZcHcU1PBG4Jgjr1LE3PrHSn2qCfh8jx0ovHCE/sffsvaUi1KhiP?=
 =?us-ascii?Q?PZr79pJb36fS6tXqlk6Woktn81HnXLsragEp0K67moL9QbDgPHMZNa0MWqWb?=
 =?us-ascii?Q?Q4nd8OAxuBPmvJEnQBtXFpB0sMYwbV/beVQa5GL7jGnWd19z2xAgZU7ueni0?=
 =?us-ascii?Q?DhdTd5K3sMctp1uifD+fuAIJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0daf24-e039-4c80-9502-08d989dbb3e4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 21:44:56.0150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Voa8s7GyBIU/182Gz/vZhqqZDKGH7fNZKQd0lTkX6CDLXBYf+mYWSwoBd8XWw/PW7b5a+54oh+iV4mSm1hCBXzdOUEioc26XeUrBLwgnWis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1884
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=824 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110070137
X-Proofpoint-ORIG-GUID: 2izF_TUqEsziKzO4cSguRLzBd1Ny_C5k
X-Proofpoint-GUID: 2izF_TUqEsziKzO4cSguRLzBd1Ny_C5k
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

The following patches apply over Linus's, Jens's or mst's trees, but were
made over linux-next because patch 6:

io_uring: switch to kernel_worker

has merge conflicts with Jens Axboe's for-next branch and Paul Moore's
selinux tree's next branch.

This is V4 of the patchset. It should handle all the review comments
posted in V1 - V3. If I missed a comment, please let me know.

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
