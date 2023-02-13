Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5EFC636CC
	for <virtualization@archiver.kernel.org>; Mon, 13 Feb 2023 06:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5ECB410AC;
	Mon, 13 Feb 2023 06:51:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D5ECB410AC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=tLXSU8K4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=gNLMgl4X
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T7VEmSAiHc9e; Mon, 13 Feb 2023 06:51:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1324E40338;
	Mon, 13 Feb 2023 06:51:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1324E40338
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5A4EC0033;
	Mon, 13 Feb 2023 06:51:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95407C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 06:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7024340E47
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 06:50:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7024340E47
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K3OQAIwjtMpu
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 06:50:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 92E6040338
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 92E6040338
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 06:50:58 +0000 (UTC)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 31D1ia65009660; Mon, 13 Feb 2023 06:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=H1no1MTJWMdSYLxgZo67+tgkx8RXbIL/J1utFs+U6tk=;
 b=tLXSU8K4U0TX3CIh9EuNDkdk8C6vW2tKM4GXJmp8U4zEKZ5v78A5CAeVPc2tfzJlVkZz
 Oj+zYkSQgqbRf5RWdSdozoNsj+v5geQPwAhp1go91VRcNwZjZvh4jlMsrHce9Z8XTQqa
 N5i0jw/hD7bIqYC1LWgLja/IUYIKNxw/OTWcLsy8ZOt382KQC+CqecogQ2AXqXDEVWq1
 OxMvYnoQAcBrXMJmyS/B0qo0ESR/nC0DlCNF1zaKVnxd8fsKEX4ulX3qCiYby5LmC6C1
 5MQQL4+nvaTF1sZC4WO2uMhQa8tCylpv7s1pHDuIy/wV5hwFMyfh1UBBribYtQXl+EVr XQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1xb244m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Feb 2023 06:50:48 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 31D6H5q1032641; Mon, 13 Feb 2023 06:50:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3np1f3q0ny-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Feb 2023 06:50:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIHpzDyeqTRyzTwCFbVRH4urnc/uoQR+a0mOVjjvjlcCT8Lzi02JnXJlo9Co27/13tbGhC9ehCwQULyThQUuzijdLi1qN6iRA2J/XcpfzAJWdUMc43K+5DCBbSY+ymSIjZBT49r1FIMrVgImYJEkcqUlrdT1djvRnxprz1ctEaDtZQPZsJA8V1aEyWUwnvZ1MBwoMZam604ZPqgsxOi4w/3gFtnHE5sR4aBeus6QldPwa8CT/dEWQq5wBtJEkETx2ViXwLYmjSU6JqWzGn/sMEYgMr5M+qg6FWwGrKeJy/FPZw7P5PaKae+jE3zPkjkQYCmH6HsJ+tzkYNcC1qn1CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1no1MTJWMdSYLxgZo67+tgkx8RXbIL/J1utFs+U6tk=;
 b=XX0QgS8uFUlfuUF1ik9hINV+3IxFkO/H5l61WP8Gri8dVNwv/4apU+VVrBEkaw3YATsHm5pW9nhTEK2++/+k7JRAyC+FmehdRPhQyvNuzJIJ1uGa4anO5lIdwp88sa5BM//YVMeTBlZMLwnp2ZhPnmZ2Tm0hRi7P78qsbGNznwF4q7rVr25XpLM6nI/GRn6OdJOUo2PimwK191R6SeDMCfxhq0xKURVmzkg9ht1dAAsL7Xc5Gp/hIMwHvbyKu/x+PE9zo8WtE7kbjsKCQp0SoP20kdJhOjpOqFOi9DDvp1pqF86CZfCCWr2h7qyCEJfqBPoJiNP6Z8MK/9OrSOhpTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1no1MTJWMdSYLxgZo67+tgkx8RXbIL/J1utFs+U6tk=;
 b=gNLMgl4XnDDHpNNNji8MHhzgnoWD1+RHpyS+5o++dNOnUaRMUFHugnlRS7ZHn4YmB2unmKTbbNAHmXFjAl62Kw63y2Yp2I5iUBzMzzgqhijAqenL+cysKyuVOjnsRw5aUoM4TvAAMfCQUWd2zNk7GaeUdwKm4rwExrApsvgybh0=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by MN2PR10MB4272.namprd10.prod.outlook.com (2603:10b6:208:1dc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Mon, 13 Feb
 2023 06:50:43 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3%9]) with mapi id 15.20.6111.010; Mon, 13 Feb 2023
 06:50:43 +0000
Message-ID: <0434d44b-f742-3cd8-d84c-fa940b59cfd9@oracle.com>
Date: Sun, 12 Feb 2023 22:50:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 09/13] vdpa net: block migration if the device has CVQ
Content-Language: en-US
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20230208094253.702672-1-eperezma@redhat.com>
 <20230208094253.702672-10-eperezma@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230208094253.702672-10-eperezma@redhat.com>
X-ClientProxiedBy: DS7PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::33) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|MN2PR10MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c70726c-3066-4978-4f17-08db0d8ea0c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1WRxvjSgaL2c2K4WOWdPWIOca/A3CZUmmiwd1IK9l+bvQ8w+DUgyQUD5I+yHgo3K+OLv40t3C5qJInnR33fry7YzFBMFVIK7mdkrBO5kypUtc4+SD4z7YHDA5aEhNqw12PWKI1kGsguZfBX0sAu/ZgUFggHEf5tPVb7nQjlZUFRmQexsBjVGId5W738yAYa9Hev7Ze3ginCs6cm59B76VWL3acfJ3cdFTE8feQdSjdLS2PwGEmtpzhgi6nObrUgWAbRLXCfUu91BHqlMY50fNyMHrJB1ofQ473HVTveX5PjO00uA/PJPV0WfOCr9OwnesaBWaGmxwxCwwhmVhl1KC3mBXvEuFsIrhdJjuvsv7Clh+ngqHZ/7W+zl9HuiAb/27KGI/fk/5bSnjQ7UUFiybLLppm4xlgocLtxJ5JgqY485ALbbvV7Ns6say7aDmFbdCOlobTGvuYTlR9MB/TJIYzm0jTYlshWd2H2YpDW47k0mEjugFNWsG4KHBf93xbyquu9XPdv3hw4Ds6j//amYHyFbov1RLlaLSTgGpNlI0Xa3WJy3g7ROBSU6uD+fHZ9IofdMVE5/t/cgHg2t/5c8StGrJe81e5ZTthqn4/Pga5bCpH/Ub3bKrb0SL59QXHzn7BGtJqeRsrhq25p5GQPionSg3h105zWZjlbiNHabOmfEbXVBD2cT1IKjlGUmrHS7bIvKhhKLObZoV1mG+A6PhWTCXpBZ+xfbCxS3Sc/fyKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199018)(38100700002)(86362001)(31696002)(36756003)(2906002)(41300700001)(66476007)(4326008)(8676002)(5660300002)(7416002)(8936002)(66556008)(36916002)(2616005)(66946007)(6512007)(6506007)(26005)(186003)(53546011)(83380400001)(6666004)(54906003)(316002)(478600001)(6486002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3VCbFhxZHR6MlFMY2w0eWhPUnZiNjJNMUZUMzVOVk4xbThEbCtFaFlKSUZp?=
 =?utf-8?B?UEJxNFh3dDEwcTJqamF5RjJFdmtqRFZYZTZoUng0ZEhWRXlNZitpR3Q4aElM?=
 =?utf-8?B?cllnd2dVb2c5QjRPTC9wZ0pqRW5DTWx0Q2ljRzRGbkRjYzZ6eFJmM1lGbHlx?=
 =?utf-8?B?WEU4QXlXZ3RzckRaZ0xOMjd5NDV4di85d25BNUpydTVGNGpycGROVTNaVG05?=
 =?utf-8?B?WW1aYXIwNnFmV0ZNZ1NVVENoN3dDWWpiWHVEelBJM1ArTFhGc1hRTHRpck5n?=
 =?utf-8?B?b0w5UDBZM3Z1Q2RHcjFCSnc5WGIrSXpTZXowTTZwc2s4VkxTSHpFeFhrRHVy?=
 =?utf-8?B?K0E1cmFUZ3JJY2RtMXkwUVlHSGJ6dVVlem05Z0V0bHJKT05td0pVekE2WjFN?=
 =?utf-8?B?dmhZaEs0clIwK0RIRnFURkhZbUMxUG5RQnJYbUhzSytCWmVIcmxNNEE2Z2dp?=
 =?utf-8?B?dDd2QjU5ZnhVZWF4NWppR1UvUTdRQjF6UWNFTUJ2ZWlFOEJ4VExaSW9DamZr?=
 =?utf-8?B?TEhLaC96c2ljZHZFZmJxaGtrMUZJMzh6aHZ3QjV2Wmx2QjZlTVFEblZCWmM5?=
 =?utf-8?B?ZmdOWDVaSDhoeVFwK2M2dHBMVjl0MnlVYXJnN0N2UUJHYTZqbjRTRlFsaEtv?=
 =?utf-8?B?WDBTZ0xxT2pyaFF5S1dsUGo2K3dqdXhTSmw5eFRXdUVVdXhVRElFaFU4VTdz?=
 =?utf-8?B?WVkydndNaE16ZHRJYkZNeTdDV0tPdWtCTkZmelRZNnBuOWk1NCtnNFk5L3RU?=
 =?utf-8?B?Q0JPK3FBOGtUSGVaM2FVTWh0SUFybzdRL0p2OXplR2pYMXFwYjF0UUh2c2Z1?=
 =?utf-8?B?ZlFBSGROdmZhSUZpUE96bndaanZVMm15Nk5tN3ZFYUhZdlViY1lLNFNoU0c1?=
 =?utf-8?B?bmVjUFVSZmVkalZncHg3QVFYNHZXMkxkV3NncEl4djVvaG9Ha05YSFl4VkRO?=
 =?utf-8?B?TXVteXN3dlB6RDJ0anZoanpKQjN6NDhxRTJuTnVxR1pOV1haSjhYQ3Bna0J5?=
 =?utf-8?B?VUdXNlBGRG5HRlJ0V044dmJDZUh6cFdBRzlnYmswNUhKbTltQy9MWGcva1F1?=
 =?utf-8?B?MlY4TUVzZWFWYU9tVjcya3hna1Bwd3c0TDYydFBaSHM5dGFUQThFL2hwQlpC?=
 =?utf-8?B?T0t4MlFURHlqVS9JWnhvRkFYekZwRkVqdUdTQXNpb2dYajYvaG55Lys2amFZ?=
 =?utf-8?B?S1NPWW41ZUZqdi96a1V0ZFFGdjlDVjQ2N1JwWHFmVGRFNGZPY1RHZzdrbElZ?=
 =?utf-8?B?WkZHeE14TGs3QW0yOVhocEdzcUxyRjhieit4Sm1ONkZnaUlOMUZmL3pJdGxq?=
 =?utf-8?B?UXhnbUtWQm1kcmNwaG9uNDBkQ0gySWxNeklUUm1RNmhYMGJHMERxOFhWdmlW?=
 =?utf-8?B?RE9XekZwNTFlYytDRE8zRmpiVmFMZlNZREFjMzZpVE1MNC9kelF2MkdLR0NX?=
 =?utf-8?B?Mng4SDh3ZmtBanY1bnk4WC9oTjBUN1ZRejcxaGJ0K2k5K3doR1ppaVIweTNS?=
 =?utf-8?B?RFMxSGFaS2R3ZWsxa25yNmJLNVJNUUNETTNZcGpjTitqekRpR0xmUXo1VFNL?=
 =?utf-8?B?QWpneVJiSUQ3alZxM1Z0RWNWeE1yTG9uWE5xdDZNVkFZSXVKbjUrVzJ3MFB1?=
 =?utf-8?B?SU14NWMrWWNUYThFVnRmaWxuTFZIL2NvNzU3d3NlZHp0eTJMa3hnV253S3NZ?=
 =?utf-8?B?ZS9uQUJKQjl3d2FtYnhrU05lRXlWcjV3ZFF2QXNKeDhidk1WaENnTGhjV0RO?=
 =?utf-8?B?aGRyQ3o3L1ZjTDRrZWRFUUs0M0thMUxsL0lwU3ZxUDYzYXhRbHdMRWp3NUYw?=
 =?utf-8?B?ZmgwK2xOM3NkOFBrekd1c3dlV0FrQnZSK3NmMHpJSWlLejJMUUtlbTZxcXZj?=
 =?utf-8?B?YU1NZmFVQU15UUFCUjdLQm0rU29FU1FDWXFTb0x3Ym80NmFzcUdaYXN1TjQ0?=
 =?utf-8?B?NUJCakRsbzAxdkNTclNNMXdzY05JN0xyRWVxOHBtTW1ZNWEvbkNJeUIzR1Vq?=
 =?utf-8?B?eVBoNFZVdWd1NTNPRklUaFZvdVhmNml1OUdZNVhEQ1hnS1c3aE92aWNZVEJ6?=
 =?utf-8?B?QVQydVhkU2dYZHByYmJvMUVtbTloc2xiaksyUlBCc0NnSEJnaGZpSVpwd3I2?=
 =?utf-8?Q?/bx6tnZqRULIWLPg+D4UJMbgg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VVQweXd5ZGRoVFZBOXNCNkNZRXdLckpWcGMyMEQ0cm5DelhsQ1dkYlBKUmQx?=
 =?utf-8?B?a2hIeFhpNWQ1bjdvU3h1RE5zMStiL3VFbXdscnRzdTkxaUF1akJPcGJLOTNW?=
 =?utf-8?B?V21vVW91L09uVUVTYnU0b01mcU9JWkt4SzdoVDVyakE3ajFZQ01NQVg4SjVn?=
 =?utf-8?B?bUtzV1hGbkFGQUs0UDN1QklBbGFSQU5TcXdKNC82bFl2OVZyVjV6U20xcEcy?=
 =?utf-8?B?TVh5RUFCdm5lTUVPeHo2OVc0WWlySHBtcFFUMTZCV0oyY05qckdUcXJ4NkFv?=
 =?utf-8?B?aU9QNDJINHYvQXVQcXpjNFFyNllSTm54RHNRWmZ6MDhDNXE4U25DVEREN29P?=
 =?utf-8?B?MUhaMm04Vk1ESERnYVpjaEhpdDI1R1htWGY3SmFWcWJ2MHlHbnJhL0taQ0Qy?=
 =?utf-8?B?ZEE4N0pac2txYlVpbTh5Sk9oUGVCYk1CSjZSU1VmT0RVRWdWWm4zcFhENkJu?=
 =?utf-8?B?RHMvUFVqcXo2Tzl1ZjR0dkdwSklqOVBLa3dwd0xteU5UeFQyL2dxMXlLR1Qw?=
 =?utf-8?B?TDZyV3JmYlZSNnl0Rmp1aVhKNldKWUVYODcvKzNkZWZza0QrTDlBZytSdXow?=
 =?utf-8?B?bUxSa3hOcEEzY3JkcG41NVZaVHByeTdNVW50Y2VJMVJBQVR5UWZMUklVSG5l?=
 =?utf-8?B?QnhYNXhZODhUOHhyVXFKNm5abHJtb3lPa1FDa3dUdXo4Smpva1E3NEZZQVNX?=
 =?utf-8?B?c2M2YU81Q21zSVZQQk5zc2NDUGw5ZXFSNXBrMkJZaW1qalo4OWxCUmtBaDgz?=
 =?utf-8?B?NjRvaTVZZEIrYm1LQXlhRVF3OGFzckhYUldlcGdPR2h6SVRsUlc3Uy9JalFB?=
 =?utf-8?B?WEFVUVdxN1RIeUJPMnNuNjdabHpDa25jOW1CWisxUXRFVzNNb2U1cldTbUpq?=
 =?utf-8?B?WXJ0d3cvTG5EN1NZWTJ1eE5ReG8wdnJQajBPMXZBc2xNdXhjaUZXcS9welpC?=
 =?utf-8?B?YWUxdzVUSm45dHFXcytTSTBHeHR4cWVSY0I2Y0pWdDJ4RjdoQ3ZFWThTU210?=
 =?utf-8?B?ZGFybjBEZHdvWFJCNURCM1ZTVHkxZmpTQU1Iajh2SWRlbUVNa0F1L3lZRE5p?=
 =?utf-8?B?WDN5VGk5dWRPWmpNays3THI3Q2ZNOXBhWTFmSU8vdG5heVU3eUVWTWVHRUd3?=
 =?utf-8?B?VG5SMUQwSDFoNGZ4VWV3aFBCelZPRm9NZG0zWG1NTFc4bHFSTFdqTE82alBO?=
 =?utf-8?B?ei9xb1dabGNNUEtjWTdHb1ZkSjJhbXFyVVRsZU55RGRNOW1XMy81TmtZMkpw?=
 =?utf-8?B?NHRlcjlwQ2pTMmYzS1JpUGJnWFg3MzUrVHlUK2hMb29pMEFhS0YzWGlrVXc1?=
 =?utf-8?B?bkpIRzRwT3F6YXlCZDJhcHFQRlRHa0xxcExNU1l1SktWOHQ4K01EQk8vejRX?=
 =?utf-8?Q?IWSZ/zjxCcXx7Xijn3PLJo/BRltNTUqU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c70726c-3066-4978-4f17-08db0d8ea0c5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 06:50:43.8266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRUgOI2bsT+5z0M5tMjg9SqefOCpj22sDYFsF/ro1GiJyR6fjGq2fF7fAhYloVpuNy5Yz8eprb9OgM0OoZCHug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4272
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_02,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130060
X-Proofpoint-ORIG-GUID: cVlg2_onRTQyosb_Y-DOf5fRga-54vyT
X-Proofpoint-GUID: cVlg2_onRTQyosb_Y-DOf5fRga-54vyT
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gautam Dawar <gdawar@xilinx.com>, virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Lei Yang <leiyang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 longpeng2@huawei.com, Shannon Nelson <snelson@pensando.io>,
 Liuxiangdong <liuxiangdong5@huawei.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAyLzgvMjAyMyAxOjQyIEFNLCBFdWdlbmlvIFDDqXJleiB3cm90ZToKPiBEZXZpY2VzIHdp
dGggQ1ZRIG5lZWRzIHRvIG1pZ3JhdGUgc3RhdGUgYmV5b25kIHZxIHN0YXRlLiAgTGVhdmluZyB0
aGlzCj4gdG8gZnV0dXJlIHNlcmllcy4KPgo+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6
IDxlcGVyZXptYUByZWRoYXQuY29tPgo+IC0tLQo+ICAgbmV0L3Zob3N0LXZkcGEuYyB8IDYgKysr
KysrCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEv
bmV0L3Zob3N0LXZkcGEuYyBiL25ldC92aG9zdC12ZHBhLmMKPiBpbmRleCBiY2ExM2Y5N2ZkLi4z
MDk4NjFlNTZjIDEwMDY0NAo+IC0tLSBhL25ldC92aG9zdC12ZHBhLmMKPiArKysgYi9uZXQvdmhv
c3QtdmRwYS5jCj4gQEAgLTk1NSwxMSArOTU1LDE3IEBAIGludCBuZXRfaW5pdF92aG9zdF92ZHBh
KGNvbnN0IE5ldGRldiAqbmV0ZGV2LCBjb25zdCBjaGFyICpuYW1lLAo+ICAgICAgIH0KPiAgIAo+
ICAgICAgIGlmIChoYXNfY3ZxKSB7Cj4gKyAgICAgICAgVmhvc3RWRFBBU3RhdGUgKnM7Cj4gKwo+
ICAgICAgICAgICBuYyA9IG5ldF92aG9zdF92ZHBhX2luaXQocGVlciwgVFlQRV9WSE9TVF9WRFBB
LCBuYW1lLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmRwYV9kZXZpY2Vf
ZmQsIGksIDEsIGZhbHNlLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb3B0
cy0+eF9zdnEsIGlvdmFfcmFuZ2UpOwo+ICAgICAgICAgICBpZiAoIW5jKQo+ICAgICAgICAgICAg
ICAgZ290byBlcnI7Cj4gKwo+ICsgICAgICAgIHMgPSBET19VUENBU1QoVmhvc3RWRFBBU3RhdGUs
IG5jLCBuYyk7Cj4gKyAgICAgICAgZXJyb3Jfc2V0Zygmcy0+dmhvc3RfdmRwYS5kZXYtPm1pZ3Jh
dGlvbl9ibG9ja2VyLAo+ICsgICAgICAgICAgICAgICAgICAgIm5ldCB2ZHBhIGNhbm5vdCBtaWdy
YXRlIHdpdGggTVEgZmVhdHVyZSIpOwpOb3Qgc3VyZSBob3cgdGhpcyBjYW4gd29yazogbWlncmF0
aW9uX2Jsb2NrZXIgaXMgb25seSBjaGVja2VkIGFuZCBnZXRzIAphZGRlZCBmcm9tIHZob3N0X2Rl
dl9pbml0KCksIHdoaWNoIGlzIGFscmVhZHkgZG9uZSB0aHJvdWdoIApuZXRfdmhvc3RfdmRwYV9p
bml0KCkgYWJvdmUuIFNhbWUgcXVlc3Rpb24gYXBwbGllcyB0byB0aGUgbmV4dCBwYXRjaCBvZiAK
dGhpcyBzZXJpZXMuCgpUaGFua3MsCi1TaXdlaQoKPiAgICAgICB9Cj4gICAKPiAgICAgICByZXR1
cm4gMDsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
