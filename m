Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D15EB64DC
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 23:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C6E28409F9;
	Mon, 26 Jun 2023 23:23:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C6E28409F9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=kNw2RRhR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=hcfUqXes
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h4jEbY7S7rM4; Mon, 26 Jun 2023 23:23:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D50B540993;
	Mon, 26 Jun 2023 23:23:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D50B540993
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09A0BC008E;
	Mon, 26 Jun 2023 23:23:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56D67C008C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B298081919
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B298081919
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=kNw2RRhR; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=hcfUqXes
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7OmG5Q3TvVSD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64FFD8196E
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 64FFD8196E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:24 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35QMrNg4029856; Mon, 26 Jun 2023 23:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=dKt3+rZVv08Zm0iuRKLor9IZWgNcPXci0DyJ+OQkriw=;
 b=kNw2RRhR0zbpBFbddcQEDrliVHiQC3xwm90z+GwpPQx1VGJJOxOb0O3s9bw7qQx18y4f
 33DJYSuYJk5wJtaJr07j34Na+ghnrk7gHDewhYH3deKGPdvqYV3XSbdSWcCDDiCRIavh
 Y7QSaJH7YxfKIbZLleBOlVlqyX/mFq+kBInIy6vbl4t057Jmcs8WiEeibbQp6TSxliKe
 jZNivOumCTJEBVjvlkBVqo5N0q3i6FTwpnS4Q/gjwlkG5w930TTH9DAe0cO1Xg/u/CXY
 FNmqatWnF4sQNXbDTcWC2cQXNWV+0t5kegT3MxIK0JtouKvu9IaFpXDCgTHclW3kCf3g UQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40e212y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:23 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35QMJNkY028275; Mon, 26 Jun 2023 23:23:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx3rgcu-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d010/zZ1pIm+bTNUN0JRHAyG/UpEKdA/uaGBlJmeuECAH0DZ0WCXT6oxL9UgoFlIzfGx6IQDcXnkh5Ktipa7co7E7rGl7Hi+iRawzY+CtAchnkyYJzII7lnVJ8KePEUHH2z6Hj9fDb5EKz87ZzoFGykhBcOPRPrD/us03LbwfhQUI85Z6cgX/DPlxfuSGqIGDPJ+x4+tdV9hkkSNs113EvmZXdUtALGFZkylouwOiy5RVIQavQ1w6WyGEYBVf+yIwKTTZntDu5vqpuXsgOPx7hYvxTTK8ezi31dSgGAEpVAvnlwJS9nhrj64auSKwvcKX/jvwX+KIjv8kzPDVaLfJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKt3+rZVv08Zm0iuRKLor9IZWgNcPXci0DyJ+OQkriw=;
 b=gkVlDjuvxrAfCgjjl50YZQzdsLpcRJhOv1Vf6hjv+1vd1SWQ01Rv1H7d6hewA5PgIGzcu/GVVkbu2XsYuTGzun0yq3ezhOsm+eXFGIUpW/JnCj1YSEOaF8l6BIzdZAiCg/eizPRJttaPhen98EuLGwuWi1KQRHk7LKH5cR2kQCDPEc7krUmIgHxVCLFB+dnfDYlacZGajiJwM2Ap/sJKBJmTAe46ssOxCN39klgvifXpiIJe18ItF0tY6HJyXO+0xLCCy2cLRDstvZ7eIFVd3mfmz1FMIeukIMsJJg2HAHbQDEWNkUoJhMaKGsfYaPT7745rRTp/6c+xcrLA/mxL4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKt3+rZVv08Zm0iuRKLor9IZWgNcPXci0DyJ+OQkriw=;
 b=hcfUqXesJ3U6eMQfBDC7yVsjq7z+ZkgPFJktv6duYq/d+T6M2H9piDVCLMTUr6Pyml4u25TaCy3uRUcqquHeknHNaSDMKJAwOsGU/GoXE04FoQAuPnniNPDxopYq8pcDPEJDcxZnBCh3JBdGzyOmsEdp2n5GUnU0AoYMbGqt5PM=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CY8PR10MB7377.namprd10.prod.outlook.com (2603:10b6:930:94::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 23:23:15 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 23:23:15 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v9 03/17] vhost: add vhost_worker pointer to vhost_virtqueue
Date: Mon, 26 Jun 2023 18:22:53 -0500
Message-Id: <20230626232307.97930-4-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626232307.97930-1-michael.christie@oracle.com>
References: <20230626232307.97930-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM6PR07CA0068.namprd07.prod.outlook.com
 (2603:10b6:5:74::45) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CY8PR10MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: da54fb10-8e77-4c8b-b35a-08db769c50fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: roQFsJjhcDNOzjS9gzameispvl1b7lLYk+lRm5Sa8QGzU7sPxGxKjOyQJO6VpHMsI10jg88wRH7xv6Q7hGrrm4Z1RDOEgRpg1SloTsx1fAjLEk3yLRU6CItXn5rzfvaIf8j6DLbBpZKlujAt0szndKbebiSKezbUHpP72Ru1ub3nzNyny/UbGcGKz5ORGb5ngcWTPS1gTz6HALr+APmHw4X5mSQgKgf55QBPQr1t2X5HKBrXs9w0F1fX3Q/wGGiP9Bb8zV82reni89pyIOwhNwu/eesBNhrIQ5m2VRkGegjdvQsW3mHUaxjpV2/GsvD57IboMGILtTbi9aOFpknt+i2q2lxOy6cSkSzNaFPxflW9OTHz1Q4gBCzFtRozCyuc0jsd5zvjmtDFedUsv3wVcjo6ghoz6vHjtUnkJRqkYcJScx0diRQO5YmZ6RciNbMx5a3Y/JgnlJKMjKz6pSHAe+ozWCk+2LSiEBGVkFuXL5VFc+sU4ETCbk/uGJt21p4VfmTHE1XPS3h8YCboLL6LHe9KbS/PzQ4X5XDXd9GGQMGfRpI8BF7vLOlNF1prLYAdlAk3T1tpwPZ+lDuW38jd9llGadm98ghyPlzr3t8VeG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(2616005)(107886003)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ej//ul5u1x5qgkID12mgiGNIM1FuLwhkD1IdhkkNIP5NBL30fMJJXJ7te48+?=
 =?us-ascii?Q?Sdb6FHpibrzKUTD58XLyL1geRPtpx+ZyKjIV+2Nzdw+GjDa0bdQ4KmL/cd+R?=
 =?us-ascii?Q?P6Wv4Hi/OM9l47c6kXulV8cMpG6HOeRxrD250cq8Daa8t3SSlMjeVoHwB/9h?=
 =?us-ascii?Q?G6fBLqHBp6dcMzGoeTb5jgx5wyj2adqaNvveDJGs5+AoFexvY1Q2n5z7s3iZ?=
 =?us-ascii?Q?JAGCYm0zt7MZGg74BmsjRKy8KWZCVhLyvV2APpEFD4trbuCaHyTAHyVoJFGL?=
 =?us-ascii?Q?Zdw/+JljrY5wX3Y9praq1FG0Uol2017IVoMCvD5LOADlVvPPJB8DThkFrVDQ?=
 =?us-ascii?Q?3OAwXOw0FeyW/79zruBzbqWghkQ425zaqkL13lPBKX9Dl7pZftX1obyvs4sb?=
 =?us-ascii?Q?/NyL4n6C3LzIR0gnZMsGMAnOEuqdBRp0G7kYbDFGMB3OiBApY5BsGmFvPLp2?=
 =?us-ascii?Q?qfAPAnIWAc++SBs+1SUzFapiLLZoRW7iG1VCCkd5hIG3fkl9vinUxReZgLGO?=
 =?us-ascii?Q?7vXb4zpuAv8Rmb2gMBaBnJl+QNbXqzgWexYH6G9u4cEzrCmBmGe2511kt+Kr?=
 =?us-ascii?Q?DCj23UIlknQjog1tg1S/MsMRjUNEoVOCwWA4zhteNtSyZKNOSIawAxyLCkPZ?=
 =?us-ascii?Q?JKuRJCzCYR482+8UMBFnvwKTC93vLjgIstgV3t7Q8DIhKwOodbgzjq0qc1m6?=
 =?us-ascii?Q?JN9HvvRqK2u4tiDU0enLjFMtAdeJoPJwvqwuRg3HMDm8f4jp4tX0MG8bIacq?=
 =?us-ascii?Q?Zkj67xVdMG39AOIMJxwsc3WRBhamJU2gX0PqFNHJcL3o2yu1FMK2Hk110YW2?=
 =?us-ascii?Q?g3k0dI4uS7AZPUUZTWik14jivZZrKYwNh4CmoPLY8//FSQgJEP3+kjdOzz/p?=
 =?us-ascii?Q?ROLa4HamlXN7FIsM+SF7jjJI4n0PqhnuziGinB4xtyrpGZ4T0HkjNiQqVwSp?=
 =?us-ascii?Q?bXkCYoDEKSD9HCjKpHO+0JrGMCJXPrTFejjYd59c/2FoADXyZlFsNbmboTXw?=
 =?us-ascii?Q?mxQwZj6Jre4kVpDFGeuzCNb0iOUgBxLkXi1CZyPrTx3PavsG+9g1IPvFktX8?=
 =?us-ascii?Q?f234guVarUg0v300GEZkiT8+4xlk8p8m/GXLYZTIFQpen1eeLnN5ajVM9F7S?=
 =?us-ascii?Q?K1OYIfNf7zI0JfBwBfpVWDq+TDyLBPWBLNdKKWaKLg7iONvAkuZwrBUkBD9p?=
 =?us-ascii?Q?DUu7u0vBX0AugtOy1H+W+rWxduUcfSXhTMVp+RF5XsDckqYFvvE4pTcWiDqQ?=
 =?us-ascii?Q?f8QgEoA1v43vtaTE5qDkrWz/n8xeRSArchyCnYn0Mc0XHVQia9BOwyG+D0Dj?=
 =?us-ascii?Q?Ymqy+Ddw+CCXm38oRdCQEp4C0DVAOSIvecOguZUfu4p79u1Y/npsaXURRrpA?=
 =?us-ascii?Q?aocrPisuqiiIAwlOwyailVkEshpmiAongjyqWnMznyC4bz0O4ihaeagEZRSC?=
 =?us-ascii?Q?KORssM9+6T1v9KK/3f7Rt1ccjiySwfgWJAyo2QSW5Rq6lKvYW46dcM794SJr?=
 =?us-ascii?Q?R5BCc/QjHn3Jm/w3pGPi2ccubB6KBK/3W2T9eUzpSEe6oPEhn0hkKcPNyyPQ?=
 =?us-ascii?Q?cbCVkMS8U3PWknc9iTPtBWC8ACyUWVfh+uR3ExE8qJ8Ph3eIbiPUo39tdlfI?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /x4LBqnG+Y9HfHNX7aLrlzIotSO7XFskHNJQXcyxVG4X6rmob+dqv1ZoKMw6TZlf8gH/xojFCmozbakOEYJXeoTuhOg3IAPcLKrpJlCa5FgjEz2VCKAOvPm/QXe/5zpN6zVOvOlPA1wo3H6hlP3eugcTYwDJZiSs3OPsp/Y0VaCRyx+UTmL62tDiX4xKpyMq+MiXchYOe6NQNKvxI6+65/Y6+nYmzQynauaKImDLuBhDWmklPg61i/Usb9GX5mHITtym1QS1enk07fSxBXs7n8tK/Z6i89Ctp+MkQ7J1ej1v2PrpBEXzpkRUt5yIRq+BeHeQ+eiK2pgzOgeCyLc+Cs4zPdZbB7hVEx/pxUD0k7/FNLxpPe2fk2imUxWlvGNcd8lN2HlXEEfyhtebjoWpbzRXE3bIUMZQhJE9Mdjf2Kj16Rt2fkLiq5n/r2XIqB34n6EHkBWl4n6B4UQOJMU41zCT+i7WjiIbs/Afdj8PgAwjZlLnqMXB1TVjBr9TxPy4b7JlkiFKGX1/pGwR9URAnqp1/U4nbcIapIU08nyvXBEH2/Kc6c38IUCZ+i5GVse2cum/FBZDD47kEM1+GcMAsGR25dgSEp6HeIiivB8MZTnILz6nY3yIl9xW55r4k3NRCYYLQz85PJXR3jOz6zxWEQJSEtUF/oeh1aBMjyyVxwfgXsBESpdsZ28Ks7a0Bo86tEjltF2H1kbfBW+42C+yn2idFUBFt5aXWF9vf9QfePIlT+76D/gMDIeH43jyDYKDa2LiiokKx6z3vN5r2VDj2XK5VE6r75uVijPUZLPKqhb+XvMBsDVbpxiHluK5xhhh
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da54fb10-8e77-4c8b-b35a-08db769c50fc
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 23:23:14.9835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVxDdYVEt38dfRob72mynQmRwEB2WPJLbpGvMxUqFE8GcY0l0w5zuXfW3OAPwfvG00dk0tdIRXHhgNcChsHiSM0saiM+jz57I6fsIFda0A8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_18,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260218
X-Proofpoint-GUID: Ba3iKNtKLImuzca1j0ApeR802UjTpHu2
X-Proofpoint-ORIG-GUID: Ba3iKNtKLImuzca1j0ApeR802UjTpHu2
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

This patchset allows userspace to map vqs to different workers. This
patch adds a worker pointer to the vq so in later patches in this set
we can queue/flush specific vqs and their workers.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 21 ++++++++++++++-------
 drivers/vhost/vhost.h |  1 +
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index dfd96cf6a152..db88464c1691 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -333,6 +333,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 	vq->busyloop_timeout = 0;
 	vq->umem = NULL;
 	vq->iotlb = NULL;
+	vq->worker = NULL;
 	vhost_vring_call_reset(&vq->call_ctx);
 	__vhost_vq_meta_reset(vq);
 }
@@ -545,7 +546,7 @@ static void vhost_worker_free(struct vhost_dev *dev)
 	dev->worker = NULL;
 }
 
-static int vhost_worker_create(struct vhost_dev *dev)
+static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
 	struct vhost_task *vtsk;
@@ -553,7 +554,7 @@ static int vhost_worker_create(struct vhost_dev *dev)
 
 	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
 	if (!worker)
-		return -ENOMEM;
+		return NULL;
 
 	snprintf(name, sizeof(name), "vhost-%d", current->pid);
 
@@ -572,17 +573,18 @@ static int vhost_worker_create(struct vhost_dev *dev)
 	dev->worker = worker;
 
 	vhost_task_start(vtsk);
-	return 0;
+	return worker;
 
 free_worker:
 	kfree(worker);
-	return -ENOMEM;
+	return NULL;
 }
 
 /* Caller should have device mutex */
 long vhost_dev_set_owner(struct vhost_dev *dev)
 {
-	int err;
+	struct vhost_worker *worker;
+	int err, i;
 
 	/* Is there an owner already? */
 	if (vhost_dev_has_owner(dev)) {
@@ -603,9 +605,14 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 		 * below since we don't have to worry about vsock queueing
 		 * while we free the worker.
 		 */
-		err = vhost_worker_create(dev);
-		if (err)
+		worker = vhost_worker_create(dev);
+		if (!worker) {
+			err = -ENOMEM;
 			goto err_worker;
+		}
+
+		for (i = 0; i < dev->nvqs; i++)
+			dev->vqs[i]->worker = worker;
 	}
 
 	return 0;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 6cd72d0b5245..0baacc245934 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -74,6 +74,7 @@ struct vhost_vring_call {
 /* The virtqueue structure describes a queue attached to a device. */
 struct vhost_virtqueue {
 	struct vhost_dev *dev;
+	struct vhost_worker *worker;
 
 	/* The actual ring of buffers. */
 	struct mutex mutex;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
