Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B4EC88CB5
	for <virtualization@archiver.kernel.org>; Tue, 13 Jun 2023 01:33:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E4F560F7E;
	Tue, 13 Jun 2023 01:33:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E4F560F7E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=W/KKT0ck;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=mxly1/0k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id swMxOeQMnXPV; Tue, 13 Jun 2023 01:33:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BE34160F3C;
	Tue, 13 Jun 2023 01:33:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BE34160F3C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8582FC008F;
	Tue, 13 Jun 2023 01:33:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27AFBC0096
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E8A2440C24
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E8A2440C24
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=W/KKT0ck; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=mxly1/0k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ep0xn2WM_Zan
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 35ACD408EF
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 35ACD408EF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:23 +0000 (UTC)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35CKO0HU029030; Tue, 13 Jun 2023 01:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=BDQKoTL8e6NNA8y/5wFGvkFsEOuRqRtDb1pHkWAf4CA=;
 b=W/KKT0ck5PLCrP9wTnMMRizIyl5ctQZBYmeMDaY6GXOzj6ySSEeEQAKM++uTUlallVXQ
 Chx4a23HLjeKfjQ8akGPkunyxJPQc3sxHO4hsfxXTAZIwps0nEG3dY1T5Hz/LUtQ5NEE
 vbR7FJfoysfohPI0eYRIivsyIta2gQRnxgBaeNTssWx3hPlW+Vn3oxN+/FhAjJqWpsDn
 qXKP+PYOl25Nkwu8ydhMIyJqzRrfJCypb9C3wMf6XrQEVM6bq0d2APBo/csLgOgWGqZT
 iHJi444Th1k3aVx4VBrsuwGcqTQQHW2FE1SSzs63LZmSURL0dcvJU63iDOXFo4zKhbS/ 6Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4g3bm83m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:22 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35CNg7jg016236; Tue, 13 Jun 2023 01:33:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm3hj8m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYC8QSklaFbWYG5k5do2qNqZQtx33y5qbBvWQWY66jo6f4+Ny7GRi7iWuqQB0DF6ydYWGeU+XupZeu9yJ3FymxpnHmJg7vFu0T5lAa1GT5d43Q/95Fevr+zVQyz3dntOL8WK2Tz7qoGjlTNqoNHH2/8V5ySwKQtJxuuG7A+8K7hVOhmHCllJi7UIzvbKaVZQZQzYOqvEYbqbBWncTYF/0ul6yopqtGEV6q8YJMvkKxtYpXPtL74ZXmb/Jcb3sjGqY6jvxjvEHArB0n464hJsP3uFni+VkatKw9HZ2Czo9dEAT+tDHwokybn0w07dYeaSi0YXpB4OzhBLE8KYeEkdfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDQKoTL8e6NNA8y/5wFGvkFsEOuRqRtDb1pHkWAf4CA=;
 b=FEB1Kbdd9SXyWaEz+i5jGJVuy2AiWWIdq1zc46u4Sn8FiUh/nwiGvnRygblkxhSO8HKEqxVRtXuagB5M1VHMof3+Febkq0P0InSiSolU3G4/JEovWYLvBUlIJ/BmRiUG40BWwMpQGG+bMxw7cin3wDQ/0J4IPgbRSOdSQ1OqxOXu66ui7Mf3m6G3cT9oLvuI9VyQbvqQ4IxLApNY7iAVnSlhD/M6aGHdoZef+A+oxyF+b6Q69f4ixpbcB9XupUV3qxNz2iTq8dXtQEHB7S2r8eEBwQoUwrE8fjK6MAhjv3JIdw4F3Wagsxh6QbrjytUBBMg08sY0HGAZoojKTk8J1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDQKoTL8e6NNA8y/5wFGvkFsEOuRqRtDb1pHkWAf4CA=;
 b=mxly1/0kn9Q8/vgpNGdXEJ3Ykb1DvpUPa5mGPDRvLCzyZ7518csj9TIallrxFCL3HNoNyV3m5d4kChNBhL/NFKAmOVcH+5VibhoE3SniQ+6iWRJ4Mmu2sT0FGKx1aoFjs/mq1UWPmh8Uq3wuYdkyLljAqlzsf+zi7Op3c31uohU=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by DS7PR10MB5949.namprd10.prod.outlook.com (2603:10b6:8:86::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.44; Tue, 13 Jun 2023 01:33:19 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 01:33:18 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v8 16/17] vhost_scsi: add support for worker ioctls
Date: Mon, 12 Jun 2023 20:32:47 -0500
Message-Id: <20230613013248.12196-17-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613013248.12196-1-michael.christie@oracle.com>
References: <20230613013248.12196-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:8:57::16) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|DS7PR10MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e69f3e-7004-4cca-40e1-08db6bae2a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dtb9y/29R1p9R3lz7Xj7aZcEC24+EcMQ8+a3rL7725qGN8B76RVyDaYjbaA+YgE4IHux/W+3tT4THAFZLc59TUIQ//OfpoKDF9HbVm9Sn7iFVp82q7zjEo/RwgdNnPNdElXfet3PYiG7myqabXBDIZ+xZ8A0o+mR/nk9TSiJk0wnhOlwO3EDyhdcYykVTLd2rzVhl8KWp6VCiTU+Y6NVu9/8Suv3FvIu/x0j4vliQ39iJJeHNEJnGNzh5cRwbStAneoEdCZMXEzPngoS2vBJCON0Rtwbzc2JGGQTjDdAbmnYiGnJPksJnnRxaiDLEi64nPzztmR2fP6FQIs6yOCxS6DLajhOsaWXdMatQCF5as5+F7tRjWCQGNb/OYoztp97ze4vnVCkYexl8lqG2XbBZiAht3SSA2yIQrvWt5VnPJ+NFlaShbVfapASYhGgyI9QSSUPqht+evbnOeniTFz/nfVjIgw7j+ZNZP5dXGXXew7Xx4nrvye6VVPV0j8qaXFEibYCcHwNc3eDotnsnjmj6dmWY4RvDUZ2AE6Bd6JUGrI6QyKdj9CtvIv9fhTEW/jG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199021)(8676002)(107886003)(8936002)(478600001)(5660300002)(41300700001)(6666004)(316002)(6486002)(186003)(66476007)(66946007)(6512007)(66556008)(6506007)(26005)(4326008)(1076003)(2616005)(2906002)(83380400001)(38100700002)(86362001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1PEjkqTAH6cuJDNKJMYoxNVMByKiu+4M3NWKvs8Fom0sr9bdZ3BHaEqdgRm8?=
 =?us-ascii?Q?P7THqI/y+FJI/0uwJ3FykSZ/pCjkB3U6qI730Q/oDcMhcggp23Cuf1fHsa33?=
 =?us-ascii?Q?KdD4CdrSSe+HVn5RQYfBwKLz07dpPeHzVuaI09w+X4eu34eZpuJgVFlfAFac?=
 =?us-ascii?Q?gfTs3Hm9XjsNjf2P4mx2lW3nmAEUxc+SEXJxJjRTWo3QCMlPdSMt8v9PrHa/?=
 =?us-ascii?Q?y9ueimsq6pCYWsRaD2Skj8ega4MpjZoiWOR+xFzFd3wNMX5dJoXdi0B+0o1D?=
 =?us-ascii?Q?qWbE2JT7HgR4EXO6wFdPBLPfxXbn4swCiZhDdPCRUWB180e0ulny4P8ZnOcP?=
 =?us-ascii?Q?X3pOwOcxjnUX5kRkifTLFz0z3oARf68btmXf4sCJEo8u4rq9nA7DiTSY7rIe?=
 =?us-ascii?Q?fzY0PxtW5j/doI6/JcZ4R9JKH1BqXsxp3H6Dvgl6bRB5ds6PFjbIanBaWRtK?=
 =?us-ascii?Q?vsHwlrxwRUa1V6WjpxnGJ64cAXO02VuQVADxd4BjER63f7tyR2jB1B0L0Oe0?=
 =?us-ascii?Q?wiS5yGDXr5AHdog7NQSQzwD/iFEd/JTFoJN3uj0/olW8Wp1cbKjzTcpot19/?=
 =?us-ascii?Q?aOODD2/JHe7iP1NTKwFKFSrQZfL3Bs5tvkZ5DTWrT7eI8E9OQ61z9mIoLzOF?=
 =?us-ascii?Q?5GSGvZ3XoG/OAIl62tlnV1+3/l9Z/txjfGmg5EdN7x4DqULnFdqoUmQ0I/IW?=
 =?us-ascii?Q?yhMb7kbIcPJpFta3CTujXmo4gG/ZR6+2uGCuCJ7EoOmtk5jQuTA8FiPJGdeg?=
 =?us-ascii?Q?B1BI/4FFvK4jZIP4vX2q5P4FXm8Mf8Omfjy04UKpF77D9MhwJyQpR36sVLs3?=
 =?us-ascii?Q?uCuuUQOIQR07rE9Fuepig95EMrkN1NE+B10nHD7LnvpULqv9sFWj5ZlU/Npi?=
 =?us-ascii?Q?chVxr4jS+OiQjNQX5oH1RoCAOyFn53zdqxcUkjQnn+R8N0kOqbE4LlGG8tSc?=
 =?us-ascii?Q?v3IFlKHVr05yaDCnh+yL9BQQwNMBmQd7PHQX6h7NdrIFFB6gH5Tz2yzmKnJh?=
 =?us-ascii?Q?cmCnAeALz0c78aeiXuCtOOpXGpynrES+1ZRcID8Bj19SK2SfWukpn5HGNsXe?=
 =?us-ascii?Q?drc+f4cN4UxMWLaFqNBs5L1O+0w392Ba8+CBmdhHq0Ge2+zWPIGserphiI5P?=
 =?us-ascii?Q?bXHLso6IeT+JJ4DB0ge3YgXTQU0Yd6eqkcQkPWqra1UqXo7iZu5dzibzqQIf?=
 =?us-ascii?Q?gUl3WVOdfQhMF/5nOaAUOEj9XTk6SzHipwgFAks+kfbj3fnNhaipPnoOsVgG?=
 =?us-ascii?Q?7jr/BwjdtK/tQDZvRPQr9Y5nUu6IE1MJGILhHhIQ++wVMROnGmlJw43+W9yX?=
 =?us-ascii?Q?eq4aX0lM1YUIl9vfOJq7ONButNBhUWYHHGa1xRjclhCQCsvsYIzxOKbqd3S3?=
 =?us-ascii?Q?uV8SB2noL54s4UatBcImcCq7QrebEmTuvcXbJOW27ONLnxmUOFweZO1lgejv?=
 =?us-ascii?Q?v6L6pKagiYbE3LUrV8tBBykem2OXfr6lKCH2Hqu5EvJaipo6mLqqjdBQRaLL?=
 =?us-ascii?Q?dfAfx+sasyt7zoQGpcUYErZy/E0hJkSyQUvtafPlofPVL9axrloj3R4DV20c?=
 =?us-ascii?Q?7SmEn21LlECUzGlZijHmPCGFlVbXbUtUT2cjamrH0Db6gzQxNxXfoXQuNE1O?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: k6Jwt6fcWPFPvfsQdANLuXXEMsPoynIXtMgsdGmB7rK13TISOrn29h3U3t1CKtWM84QUHC+igTEaAnKM/A1Yz5cYt7Y4rfpQSIpUmyQi4OR5v7CBmlDaHCbXJwRvP8xG9KUZyaMxvWQzf9SOim7XDhCPbu9WyhRL8rl6e4J71oQzTb1umXHbEh/mOzm2Y3stcL2yizvr1GgdO3hJppEwjC0w2PbfB9tEM/HD73aMBy00hqlACyX7SpeGpNoempeQjxrLYdqBBlLjaFu2MGz/yxo7Tu2590D2ufPreDyb7TqwdYwHBY+9uXoY3pLyF4adYRPVrOAHuJOJSBNxgQvMEnlhm3altHfpus7UlcDLqLNZxjAsb83PhoUzIdzdI0d8RuGoO18/Oz0gw0Za83mIm7I6yh3MZJcklutDvPdYDkboOULwnA6lZcxEktR9svjCj1r7Mw3Og8DrJAC1avCBhS61740xxo0hqURTWtxwAfQsAqcl492CrIJH16fxjpXs8txL9nDkjBd4Hdnm7DKJnZTRv8pqf+AxLb3SILyDRYfVmM2vfElZ59rNOytQoAqaOviT4LNWxbkMwwNjan3wBETNQQSw7YI48P6ak5XkVH/ig8mZW566SOiKn2NqiP5/wdEnVvUjWg44f3AAmD9ZRMAks16vxbHdqu4KcIOH0UOrvNOpI0bgv6ZspYG+DrxzA9nAjh6dGI1kiGvctBT/6kTrEX/4szxSnQ1A1C2TV+Rr3cGC1Fw4f9ahZAqWkSqxB5l/VB1dLHFlfTdnN10ubamYWACAqh0MqMZESf2EAEWL3rI74ZXtia+kzprt6cZ8
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e69f3e-7004-4cca-40e1-08db6bae2a90
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 01:33:18.6854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPi5vS/HZm3ZayDIMUpnTyAoXc7P9bjaNYaxgc6SPHBz0bh+uVcSSur3wBco/BMkoFOA+igxu5G8dDOLuCfKTejfYNftfgw9YoZlGs3/qIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130012
X-Proofpoint-ORIG-GUID: RR01_2Wij47S7uu58ZtfXWv5L8n1fs-e
X-Proofpoint-GUID: RR01_2Wij47S7uu58ZtfXWv5L8n1fs-e
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

This has vhost-scsi support the worker ioctls by calling the
vhost_worker_ioctl helper.

With a single worker, the single thread becomes a bottlneck when trying
to use 3 or more virtqueues like:

fio --filename=/dev/sdb  --direct=1 --rw=randrw --bs=4k \
--ioengine=libaio --iodepth=128  --numjobs=3

With the patches and doing a worker per vq, we can scale to at least
16 vCPUs/vqs (that's my system limit) with the same command fio command
above with numjobs=16:

fio --filename=/dev/sdb  --direct=1 --rw=randrw --bs=4k \
--ioengine=libaio --iodepth=64  --numjobs=16

which gives around 2002K IOPs.

Note that for testing I dropped depth to 64 above because the vhost/virt
layer supports only 1024 total commands per device. And the only tuning I
did was set LIO's emulate_pr to 0 to avoid LIO's PR lock in the main IO
path which becomes an issue at around 12 jobs/virtqueues.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 2c3cf487cc71..c83f7f043470 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1927,6 +1927,14 @@ vhost_scsi_ioctl(struct file *f,
 		if (copy_from_user(&features, featurep, sizeof features))
 			return -EFAULT;
 		return vhost_scsi_set_features(vs, features);
+	case VHOST_NEW_WORKER:
+	case VHOST_FREE_WORKER:
+	case VHOST_ATTACH_VRING_WORKER:
+	case VHOST_GET_VRING_WORKER:
+		mutex_lock(&vs->dev.mutex);
+		r = vhost_worker_ioctl(&vs->dev, ioctl, argp);
+		mutex_unlock(&vs->dev.mutex);
+		return r;
 	default:
 		mutex_lock(&vs->dev.mutex);
 		r = vhost_dev_ioctl(&vs->dev, ioctl, argp);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
