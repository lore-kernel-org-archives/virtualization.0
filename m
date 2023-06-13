Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491F1C88CB8
	for <virtualization@archiver.kernel.org>; Tue, 13 Jun 2023 01:33:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF78F60F41;
	Tue, 13 Jun 2023 01:33:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CF78F60F41
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=u2Ob8ZYL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=ut5rPhJd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EF-mThOGk8aT; Tue, 13 Jun 2023 01:33:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6348A60E29;
	Tue, 13 Jun 2023 01:33:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6348A60E29
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B24EAC0096;
	Tue, 13 Jun 2023 01:33:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 194F3C0087
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E1F0A40AA1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E1F0A40AA1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=u2Ob8ZYL; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=ut5rPhJd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZxZEJcOx_HeF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0E5B440597
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0E5B440597
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:20 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35CKNjsR016692; Tue, 13 Jun 2023 01:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ymTxFAy96gmQ1Rg8fdITb5vFfY4ciD+tLMWaTUW1Jhc=;
 b=u2Ob8ZYLzIlEPOB1c/RzjFLDS/CzrWUSdE+AzMc8VbNYfsDtMBgrMaVq7MNWXq1MoNPI
 bUDRMr9Rw07Upqsb1NZ7iKV772kh3OkW5UZYjkHGL+qE1lMr4I+DzsZw75AeQz11HaSC
 qI+hYIVm7RlVukRqq3M3+gd/646hCuuBNsuE+Rv/6zTueQ0YKXb4G6CDQ1NcLezDOab7
 4Phi8t0mIhduOgjb7BDbp3CJv58ckzSfonKWxK9vula3AigiCzRUMBiuog9UTENLe9d8
 2YVzQ8BjlO+WBxIvBbSxCei0KSNsFFNXlcqfXpD2dQ5Kp4HD7O8bpt6ZidZxS3CdvatJ Qg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fy3c5f3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:19 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35D1CJRJ021613; Tue, 13 Jun 2023 01:33:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm3hg44-8
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOrN9pO68VvN0BM8LCFy1ZFmEfq6TrLI4dgsLDd5O0Ekab4pDJjj9TNxb5vBRvgFDMU2OEEfXFDeHKkVjjjFjivwD+qL2Fz82pegd24imkkrPX0MGMAN+vd9ZRJhW5HrQGZ9Y3pOBjT73UCyqxaRua82oRLEzPRdu4Q6QroeYGur2lC/Yk89akDpoOYUBuGlXocX5SyJ34WXe3P1lkvTnI9cyVpPr6XIlh+WzbapETwTOU+NvsrzjcFA+UGle7VIo+w3iCm8AuODWeijTRT6OAyRptx9UgHdMsbG4vOBAXdBEBRjpU+rguHw6F7Q18FU5KJSfstJTxHCc0D0HzY1dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymTxFAy96gmQ1Rg8fdITb5vFfY4ciD+tLMWaTUW1Jhc=;
 b=W0Lf4p6vLoZVExybApaClLEL7EuzRTo1msQQdb5isetV/QEMjkJO6hbEwNZSfwtoNcVx0I4/DquG/BlLmObbROoVBrZiqO4xwANl5YIx3ufGwU2odj7wFSKPkLyKenjkQIXXcwhP56RPi/FCsQrWd0Hb4B+jlOrVIQf9HOEi6dRrCjbSJm89QUxLv4MCHrCgkVYDrzwBLJSbyr9zfMI/5O/wWTiJQKUzwMOlNla+B9oPy0acX198h/IOJfNhDqmF99fnoiD1REMeMegG1i8Z0wX6+hVOgrfZWsDrIqBBtp768Hch29xT29vJtMxv74BqJKcyrtAjaNyKwc/2KEYnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymTxFAy96gmQ1Rg8fdITb5vFfY4ciD+tLMWaTUW1Jhc=;
 b=ut5rPhJdf4Jx1m0E4nxkLgcJaT4iaa9Xyhem9/lyGI0pZ38gRPOAX/hgJZD3wtJck7LQwvnBBx8gDJuifySwLmmyvTHVNQDazNoQqW8aBeKrLuo3/blRUT3KW5vEn6Zd7aDMx32BLE0fpnxupxn4XBLCMuifYmYM/HNnHAwtlE0=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SA2PR10MB4507.namprd10.prod.outlook.com (2603:10b6:806:119::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 01:33:09 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 01:33:09 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v8 11/17] vhost_scsi: flush IO vqs then send TMF rsp
Date: Mon, 12 Jun 2023 20:32:42 -0500
Message-Id: <20230613013248.12196-12-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613013248.12196-1-michael.christie@oracle.com>
References: <20230613013248.12196-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::30) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SA2PR10MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: 944f84ae-6089-4ca9-6b47-08db6bae2530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wUeisfr4kMkvW0jZR88hIbXjY/yX/TecJSUaCzOJs/TTJ3NZr6fqpGEtmlFmK+AjoyGKQMh/tBVwo5Sd6HuKOLPFdXvzPc9F/GTdMgslm0VXzCjzc/Hpe+Cn/9UIsyIs2wp8fUUsopumuPNKDEgZdY1CPZzVRzjcQlTLKSxTC38RLg9pyfETowmiuftxF0OitNoRPq4iTNUu8fvtI2UuywgsfBpJj3TMnlUg1ffBENeEKWdxTxJ/8KuQAUL5j4iEnATlTCnSZPDgMZgArLAYq2nQEUvTqlM6I3Kve+o3QTzzGw3Az9PBA/gXt5cqx6kB5kelFeKVBJCtl0EMz5S19x/oOlf0fdyxcEgYimRXOnbQ3iGo5k/EoRi0l7T2U7F+C+4+ONl5nnQTsS92LjN3bWVYHhGyxdotch0BqfrRLQf15wHLABsjjXjoIA8+tUNbjDGI7K/vUt7I+/uSGAumRngTAf0qOdpD8jHPvbL+HCU1/N63YCFHRgMY/Q7PuVJyFu0ZIEs+ZNB9flixX2I0sOik4BRgqVA/sJC6sSa7eA+cOUmyAGu/W4Do3ivJ56BD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(36756003)(86362001)(66556008)(4326008)(478600001)(66476007)(66946007)(6666004)(316002)(107886003)(6486002)(8936002)(5660300002)(2906002)(8676002)(41300700001)(38100700002)(2616005)(6512007)(6506007)(1076003)(26005)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6LQWP/7gLEILCJAH57Zc9z/T/2N2o32yBM6E+/iVkA1XFTy9xVmtjLBE3I96?=
 =?us-ascii?Q?AJsnkXuawSu2kpqEe1vTK6cIpPIwNJswAfIi2oZSxH05U69XQ5Aqynn6vAbG?=
 =?us-ascii?Q?h5hydsCRRlHNibAIKMV2WWPKJDmnlithDVYiTlagtU+BU6rWeJiRHRsqkz5v?=
 =?us-ascii?Q?bF3Q+BoBA7us8h7jwaM28GOCFRxJvSPjIf8ZDlEio2gjN0wMi4DwMPaBClHy?=
 =?us-ascii?Q?93BJNcSI4xtGwARDcx0FDa7kTaox7YppX7Q+BrvZ/bCb7GTbrCiH1NqyP6pg?=
 =?us-ascii?Q?8j1h1Ef1bgHaRHJO0OZyxwptMlquHoypiwKlr0/9V1modWgdz4TGz34BpaJI?=
 =?us-ascii?Q?O69cG6TREwcdnpNUOK3e6CixEJDqPfq1AshNJqWqxJGoIEPr8HrFfLwCBn22?=
 =?us-ascii?Q?wlo7/s7UAY5CK2WfAU+N12UTuhDuvs5ChbgclIQ6x/d24Fs6d4P8YBwepllA?=
 =?us-ascii?Q?5p9dJh08oDsjU7rCamybJM8TEAQVeO9Rz6vBv/nqmkWrrGIetzBJIXukBXjI?=
 =?us-ascii?Q?CWSVOg53KgdvqEpCgEkt7EcnuRn5hN+g0zULpXLMwltxdWYxwHPfsOqkOd2C?=
 =?us-ascii?Q?PVkdSDxuJO2rQrf2j66l87k3hxb9oW4+05H/+weRcLG2hz/6818TQ1VTjpxR?=
 =?us-ascii?Q?+c+26+wkCj7aO4B3Oav2jbTfum7zruGnQO+axv4rMHB6c6QU2Hy+Q6fTeY1s?=
 =?us-ascii?Q?SHaAzHt5AqRmBfyJVDnzsPuay+RM1oQDRWqTMsbXHagfIRaqVg3HMb4wGsGq?=
 =?us-ascii?Q?NDSfP7WknYs3Xe6n7HjezV81VOrtdKkCJkiKrosKGch91bQQ7hF+X06s2cJZ?=
 =?us-ascii?Q?LI7KksBlzv9XfbgmskQH6JrjgTCxdw6+YQwb+tQsrd7x1zwnz5h6KWjXsiQd?=
 =?us-ascii?Q?Qy/gccluzFZyR4fbm/R8SgevC7wm4yv1eg9uyKlsBDOXXJYzWeL/e+CffXTg?=
 =?us-ascii?Q?hANlOTN336rNctu+d5BS5oqCZbuI3I2QXSADh4dFKObvFjWSwVXfSSgcWpXf?=
 =?us-ascii?Q?Ezxgw5Sv3TgbIk8y/pllwj9P4bhLFxfSalP47GMuHcgMKKPXNj16X3Wf68bw?=
 =?us-ascii?Q?y09Srb3kRfgNks8cZ3ArAUwVly6uJBXfQXLeVtZ80ezueKVp5xTx2WdmKQ1/?=
 =?us-ascii?Q?5nobYeQjW0S/Ia50CY3KFoVs9AsQaKnex+6NydPNCCQpTpx1Hx8jEy6qQIKa?=
 =?us-ascii?Q?2ad0S8YRWEXpJ8LaWpbO9mopIyxSw3iCkJDBTS/RIzzRqwRiYvcQ62kMDDqq?=
 =?us-ascii?Q?Q2QPo5PlhS/ZgWhaPHxkuRClBI3qdFXircXCzLa472cAAO4TOTPfTMlLMo0n?=
 =?us-ascii?Q?OXqWQ+nW+ltSNaeb+gyI1+WCPc7jeTeFs19zMsmZUIsZxYTZfdw1TEDqlerh?=
 =?us-ascii?Q?z6fW3+JsaeqPNZBbTKEqy+IHuURXH4B/cbheaqmQ/NXDo1CgX3Ie+kcHxz/z?=
 =?us-ascii?Q?8d0AIe4B9prC/XIWSwra6xMYFKbaAp/qaFB3Pk/JapCMzA9gGJ+N/5CZpmCp?=
 =?us-ascii?Q?eZ16yOWJzorlxK0Uj0gLm34T0kLldfIi1zS1bJ2rdsb2R0L08E2fX24YmgvR?=
 =?us-ascii?Q?wUudoYLROD5hQo5v+0mLoBLZHfXZTBylEDD0+Gw2+J3SlHsTyNSOrnVV6yGc?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +e4QxiaehEEaegODfqw6v8zv5uVj+vvW0iFrsuq6y2A0G8VFa8bcVbSOC29z8aSPJ4dg5PGD7M7k9LIZpICzdbK82RIWtvlSvhiYQysQKEhpAwlhWrZ2Cxij+Ewli+/tEDR3CswlmOlfV3Ycfds9TTtbrxrKo08Tv4DC+OtvPnexFtSrotEbLC1rQpXvEr+CJOHkgheYOFNK/akKL9tVv1IOTuFK/XsX/5SBbSuyPASuSZLNdZStlRybbHekYFREqqA/L/k83YxkNiODJGOFUK9x85zGA65gW0FPSajn/bBejbqHmKorHmoE8K89XjM6IMeQw+eYgLkD8dynSUswHfe/tc03UCiUShJG+r0bh6gYMevreIYkv59a2RVLo79HhHWeNS0jY26wbrI69YScWtaO3u4JppfiZnyStf2yTiUQlrrmAPDjfL0pXxTW6H2n8rF6fZ64P/8rYbsA34Pw1Doo9+FS7kx+AjrZsMvl6jm5sbD5G8FmHRlVh4JejjgmzGJYmgA7D6pe0V7sihuns/jgtVRD97yd0TDu4bVGRGFP10cISnZaNPggVxHHsmrB9mpB+MKhUDroXXRgQjx/BrCOTaL1PYpcEWmt6KyvjK3eN6YJeyhTb1jewci3LXyEomeiZ2AS8S4nzG+Bq+5aWW2EhTsLoX7hQOFIBpuzspXb8pe5pf2z2a9OAeE2RX7jTYReaBZu9L5Tj88hswNKVaUe0W3XflpHE15NkfusJhXCxP9L8D6K5JIarFzRnr3zq1vfZXld6SDkg3X+DguyI7CGWVhO0A7oN6/rcd6ADfYAhkMzCAQJgU5pBIvq5Gs3
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 944f84ae-6089-4ca9-6b47-08db6bae2530
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 01:33:09.6714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIuFvVcjFW/TYlX/rf0uh9Hgo0p2XdcZh33zo8KmIhT/W8ouj8xj/BNPbdbDUaO3lo95NKUOMkAHJQ9N9oFzdwgu0igYIMNwCojg9hoC85g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130012
X-Proofpoint-GUID: T_eludg7qsuabJfpK_iSZWeGyudFYPIS
X-Proofpoint-ORIG-GUID: T_eludg7qsuabJfpK_iSZWeGyudFYPIS
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

With one worker we will always send the scsi cmd responses then send the
TMF rsp, because LIO will always complete the scsi cmds first then call
into us to send the TMF response.

With multiple workers, the IO vq workers could be running while the
TMF/ctl vq worker is running so this has us do a flush before completing
the TMF to make sure cmds are completed when it's work is later queued
and run.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 1668009bd489..2c3cf487cc71 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1133,12 +1133,27 @@ static void vhost_scsi_tmf_resp_work(struct vhost_work *work)
 {
 	struct vhost_scsi_tmf *tmf = container_of(work, struct vhost_scsi_tmf,
 						  vwork);
-	int resp_code;
+	struct vhost_virtqueue *ctl_vq, *vq;
+	int resp_code, i;
+
+	if (tmf->scsi_resp == TMR_FUNCTION_COMPLETE) {
+		/*
+		 * Flush IO vqs that don't share a worker with the ctl to make
+		 * sure they have sent their responses before us.
+		 */
+		ctl_vq = &tmf->vhost->vqs[VHOST_SCSI_VQ_CTL].vq;
+		for (i = VHOST_SCSI_VQ_IO; i < tmf->vhost->dev.nvqs; i++) {
+			vq = &tmf->vhost->vqs[i].vq;
+
+			if (vhost_vq_is_setup(vq) &&
+			    vq->worker != ctl_vq->worker)
+				vhost_vq_flush(vq);
+		}
 
-	if (tmf->scsi_resp == TMR_FUNCTION_COMPLETE)
 		resp_code = VIRTIO_SCSI_S_FUNCTION_SUCCEEDED;
-	else
+	} else {
 		resp_code = VIRTIO_SCSI_S_FUNCTION_REJECTED;
+	}
 
 	vhost_scsi_send_tmf_resp(tmf->vhost, &tmf->svq->vq, tmf->in_iovs,
 				 tmf->vq_desc, &tmf->resp_iov, resp_code);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
