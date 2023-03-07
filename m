Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE22BC678D4
	for <virtualization@archiver.kernel.org>; Tue,  7 Mar 2023 09:11:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 679F760F56;
	Tue,  7 Mar 2023 09:11:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 679F760F56
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=eT4OLZYN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=B6/Q4yVI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id irj4ooz2Bi_6; Tue,  7 Mar 2023 09:11:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B07F660E22;
	Tue,  7 Mar 2023 09:11:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B07F660E22
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94DD5C0035;
	Tue,  7 Mar 2023 09:11:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F025C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 09:11:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2B86B41506
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 09:11:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B86B41506
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=eT4OLZYN; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=B6/Q4yVI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uW8T9EnJ3tkS
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 09:11:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CCBBB414C9
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CCBBB414C9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 09:11:44 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32784D81017315; Tue, 7 Mar 2023 09:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=laczvX1pB4T9jQJgdfi4XCSVFwLLCMOEr6Wxc98d7Iw=;
 b=eT4OLZYNK1fn8wusIujWci5ruAmeHlT2Y2ppwDUgU6Jt2Tj21Yz07yZeEXfjf+Rb3rEX
 pXOiQwiAtFH0GnRmvoyr312yF6xlzm+c9jA+bhHX/BGnWkf3CW24fTZnndIZIjoRCN83
 4EB5EZX1x+BHrgaem9Tqy6dzSJqYfGSfjSlyMac4ckigmVXRFQauAIcAxI1UOFIFc7r6
 lTfstVmQfgISHHi6ZuYJcWFVQAo3D4TSe3f322+7kv7Vsy1LjSX8Rrz6gqvK+TJDDNo5
 vbQEqUKaj1OQrbTJKbSG2qD1fuD0ThhQYJg8Wvwxobd/QGRYvazDV/+rONUJxxl+hlVl jw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p417cd067-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Mar 2023 09:11:43 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 3277jC3Z011213; Tue, 7 Mar 2023 09:11:43 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3p4u2hfype-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Mar 2023 09:11:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaO94dttw1zJt1Mktkroye7gLvm340pEQdybfTgoxNuciIHRyAh40h6NXpKpTKDUKASywjj0UqHkkn4scWSoR7K0DnFk4z/XAA6hoMmCUlWfJUpVXAYVaGBottdakfteVvx+0SM+9+4xAQ1anNNjv+B+ao95eTQVle2cexyhRdZx7JXStTMxiXUqtY5pXqmxRn0fiYafyM9IcC7LYQLammrGBWBC1vNCeLef0ZgxNR0GE6Syw4YTKXYvJLIdJcr77x4tbTq0A+QWcLCEpBTxf+Vq1yaKFc1l9JMWB+JqiMqXDTiQXPfuInSLqMgdGz8SfAFNZtGXwCQN+fl4ftdL2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laczvX1pB4T9jQJgdfi4XCSVFwLLCMOEr6Wxc98d7Iw=;
 b=D0pultjo/gEe9ZIfnB+bGbtV/GY7BsQ13wkVQDfqIN9I+DQEcKiQG3jgBp/atnayWpVsLz08TXOAZB9Ytf7h8GLC9lvaPeWW6RU67GtgY5xfSxBu45K8EauR2ZmDDWkwvuj05odkB8TnQJn/Sa8BvFCjSw3Y0ksrJRkN8iR4B+Rap/5auCC9rhVfsJ2uDpYjbyJtynHqRvRmGk6HGxctkl4rYWYKAQ9F2bhPCzxgJP4iDvgXabL7eMQxllPXqqz1IuM0A+WI34WqL38j9Qh4JcS74N6aiZmKrJxOvRo60wGPF29Q8sqNQ6bjhlZMEa6X94ctTAhX/HGpGvX7ZxY2Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laczvX1pB4T9jQJgdfi4XCSVFwLLCMOEr6Wxc98d7Iw=;
 b=B6/Q4yVI2X1p5ngwnArKQ+CaBTTOaclltMCpQLhkUZ5obd0SRxrg2Q3CUhybRktANIBfciRKSrIFCNKcTJOzCkB2z3oFBThmDHtjSWQcGxdU2PhAjDwRK2axFMura3zwtESPtkGbed73Js2fXXExYCpHoT/eAewvrJof0NOh4A4=
Received: from DS7PR10MB4926.namprd10.prod.outlook.com (2603:10b6:5:3ac::20)
 by BY5PR10MB4130.namprd10.prod.outlook.com (2603:10b6:a03:201::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 09:11:40 +0000
Received: from DS7PR10MB4926.namprd10.prod.outlook.com
 ([fe80::9ee4:1e8a:76b6:959b]) by DS7PR10MB4926.namprd10.prod.outlook.com
 ([fe80::9ee4:1e8a:76b6:959b%2]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 09:11:40 +0000
From: David Edmondson <david.edmondson@oracle.com>
To: Feng Liu <feliu@nvidia.com>, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 2/3] virtio_ring: Avoid using inline for small functions
In-Reply-To: <20230307035705.4479-3-feliu@nvidia.com>
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-3-feliu@nvidia.com>
Date: Tue, 07 Mar 2023 09:11:35 +0000
Message-ID: <m2wn3tylh4.fsf@oracle.com>
X-ClientProxiedBy: LNXP265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::24) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|BY5PR10MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eeffc3d-6e7d-4b4f-56c8-08db1eebf65a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YfQXvbiDLHFT22ecQlhAqbmHUQlpmjXYWyAV9PULs3zHj769wjBO/xoMcvqLHzFZoVnHs+Js87UFgRyTxeMFJnx+5vjq2YVHP4OVhT+WIXojJChwrQbRGhbvb6mm7KI5ynGpt98z3pLqulMMkAAHbCfVRC2/RdtlgDRx17H46EOcW0WA2na33aKxeLO/hHyE+lhBH3TaPzLzd2zULtqWECVeXEZR90SwMn7j2mghPxkFm57tzjM21YZjilyY2P79zQ9tDzvWtVPnJItK+z8sOTAYpkcVM4W3iAHi6LF18Cxi1rGdUsHMpXO3SR/BfqGPXy5ZCkpS0+YGuD2v6bIOH7NgCrDLnZJqKE/+2RaZbK5r+FAdCi3SSjX6zgxZ6kGynyD5GQFZ4rx+l/dvhvDj8cepdepZgxX2EY8pJ2dU0dNPgvjTyTVMA346vj2g8EDKMQxJ3kHf5AT0PsvGPR4loF9g5rDfNE8wq5i+5oE3v0qoRxaLx/+8dUuxW0ejnouN8UYAhwBCsD5iQDkROHr6tBmYD87Mh/lzPeiXeE1+7AfJBqSmubWudlYNQ25nkO8n4GM+brXb4O091DeQAefT/EELcF4aKIrK0Y04m9nX5MIAiKC09UNchTvq7voaudgehx4rbXfPGVHyd5q8uM2v96V9t5znLN0zwn4UZNEs6qY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB4926.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199018)(36756003)(86362001)(66946007)(66556008)(66476007)(44832011)(5660300002)(41300700001)(4326008)(6486002)(478600001)(54906003)(316002)(966005)(8676002)(2906002)(8936002)(38100700002)(6666004)(6512007)(6506007)(186003)(26005)(2616005)(83380400001)(66899018);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3VedaAoeuvz4eRcEa2Ore2klRuzs+3ARysG4m7arclRwRE2RPUY51ITt1aXq?=
 =?us-ascii?Q?0/J+sLVUcDVqV3sdmx5uTsranicMjxdURujgdTocYivvrSkKb1DZhE8L7b14?=
 =?us-ascii?Q?V1Y7/OtTb1gm3OE0MTukdbOyFTlZvWeT3cC/gE1nIdGCX2E2ylFMCm/d4cP/?=
 =?us-ascii?Q?BMjnrWKBaAQggGmDgqlCfJ9qUaMZx7VhGfOMcCzTnbn6o1R5YfO/MRUz2pYi?=
 =?us-ascii?Q?mIl9uep9UN+WHwkjdnHXjx7LhCLJxg26mYUqurYh8bmHcc7O/zTxrqiO/Kic?=
 =?us-ascii?Q?dDxkDxTbrEqX0FRL9ms7qA7GPxxXSqBGwIRHus7Q69ncknnvFMjHwN1ZFrNy?=
 =?us-ascii?Q?En21nZT/HBdLO6IU3dvnbCuamjQ6kDZf0vulwrF02EVZqA1QVvS6G2j1P32j?=
 =?us-ascii?Q?LGWvIErZzAyYTRf+4gFxeVtSvEHg69mbBy2pt2M6azsp2PK1O2lDKsXKzyOa?=
 =?us-ascii?Q?/MOd7DhsVzgPVoQtIPsJ0B9HEXPmky3QF776Yo9bX+4THGh2JdK/URwXJ3aK?=
 =?us-ascii?Q?ZWM+nz4Zzbg+OABl7uwD+qPqh6NsgjhzYUh04IyM+pVy8tpVP47jOTx6Kf60?=
 =?us-ascii?Q?jW8J5TxqxTxHCyPibKN7ALaq4Im75jbwFaN6yS1QAK/SwGFic9G88vClyKSf?=
 =?us-ascii?Q?K/XBrf/q3Fr8vvDCW0d8nUHiln1SFfz+AILm4tBdCI8nKab0JAcaQ5BQbcl6?=
 =?us-ascii?Q?ps362inF3n2nKAICTNyuysRZ9+OtO3qj8jpYssEkbbHoMN2y9+Rs7IyxpsZQ?=
 =?us-ascii?Q?D57YwFnz3oiBsXg6ngj1Rsbxt6zjw/dz7/3pT0hGOSGGjYB+Pd2Kbl90EiAC?=
 =?us-ascii?Q?dnvKMFj1e4X7t4vZ/bG7CfMIzNxSFUq0A5OhQ39qQsT3GRFCBgGTSk7sHi10?=
 =?us-ascii?Q?ehvUQajn85Jt5MmOTlEvrgDtpPaliGL9dQvZwJkFykyMCGNdcir2/6OXLYyJ?=
 =?us-ascii?Q?Fm+VJcagvcWC0PDfSyuO7vm8iueBo7+UB/vssIqlCPb7E3aL76QybBLWhSUN?=
 =?us-ascii?Q?CfdUGPSoLxG/6AGrUgsJDylbNtij6aZQFedvq4K0WgsK/cmIVylaZb9rKi8T?=
 =?us-ascii?Q?MR5miXXyHIcL2RpIPrIc17LpVwUKUnwnozzOEOYPK/CvwEaw4mqAzRniKX87?=
 =?us-ascii?Q?O7zGDJQVG7WMEzxcf2OLm7AFY7B289PvmOCvrMncU9n2wCo55dGhs8FpAbnx?=
 =?us-ascii?Q?UtP04edGXgMJ/qDHDWQK57H0BkW01JqWhQfffBefuf1m/DpsLwwAwP4LksUM?=
 =?us-ascii?Q?B2d/bRNwtjz+cfzekwV4WVQBlIaVkaixJ5wbLdKzciIfmuVA43xgDthX//8c?=
 =?us-ascii?Q?iWliT3CmCcJ8+G8JHRK8RPERXB9Fhe31/cdQs3AvBknuyna52B3k4R2nwra4?=
 =?us-ascii?Q?jGerVbiU++OdoYAH4SrNd26jbUMpKN73d9YVQUmM1L4Z/pwe8kLteoDKiI98?=
 =?us-ascii?Q?dckLsagn8U3uzdnal+kJkPdTwD8qMwzMqKtRY5vlx6eNth+93vW/nMUkie1O?=
 =?us-ascii?Q?MCKEunS+qZWU8MsjopUW0lu/Q61GUZpsxccIG8dygJv5b4XhnjxkCt6EMeQJ?=
 =?us-ascii?Q?PshfoTrrxwMx9+284QVRS0YkKlycbsnIVZ+4Kf6dI5NN8HConLAc7gk4rYjg?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +LS4FGl06+c5ksZ87szfNfhLOXrXl7FXwR4I4yroFvBIkV8++J+PsBc9UwrJxv9sNxY0fDlAU+N4fTlNmmqzjWZhW/vGPOLUpMQ4qGyQK63K8PLYV5vi/NouwN0ZI64E1HuIOWrQW+5BJAEoLhHheE21/QDEwyftxH2w+PQTFAwQTzNJWW4MpUxmMXn/lLL9j1HcIXPtf0b3ZNW5faCGbfv7aufM853V/TKr51Zqe91A2MufP9Z7zru/sbgi/Ihjn87188h6BlVVve/r3zCbiLZ6pWuMB7TzC9Fnf/ho8UvFL9BOcDEcCts4QQ80puY+z1uE4z+w5Q4OZ9O6CMMdD+1ObB8WeGO4ql8C85w8b/eZ8We2kRMUrz9Lg9BmF1ldbeTAYZg5EzeyAnA9lDwSQ5ltUdQkiDUe/S/HXyg1tFGPRuMRhf3gN5/YN7IxyvCORwrkZTwy8eHARddThije7QwEoFsbGThMXZQktBeF0RcuphnLB/ngH8heuoEYOd5uS3jejcIPCBQOi3CIfa7Wlbmpbd4krVnkbZaBhTO46nySyYc8LC4SlTawI9SQdFhw5pRG5AmqEt6sS7JGHPDIKGarUjfqLUpaVA4d833w8IApaUbUrTVpuKq3/ryFC3CN4QAjIHzImmP6MOGsUIkFoINac5eBUCnArKUCk4Kfc+ieSfqGjqLwStUZKgGPq7jJE6MxVVvIWt8WNyBbMoWFyv9YvqNYQKVYsxuHy7cv/Mu6Ub2b7z5FCk3tyi1Ijmal8JdEgS+94+MaA/Me3aiQdB5K1zgHsdJwvbc8f/sGz4ceOYO31wojhONbzNSuu2CejRvImtlJLD6+rm6blAwg0H42Azye8ywk0KkICZGBWmc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eeffc3d-6e7d-4b4f-56c8-08db1eebf65a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 09:11:40.3414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jwh0+qhU9GY4TzKeNVpu7yVkm9eQVAI+fe+Z4p5xQ4s23difeJB09udrBYeB2gH7X2bYNv5+Q88duoUUYLA5VHjypRUb/CDNJKMm6bI7zs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_03,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070083
X-Proofpoint-GUID: GdOgTWgUBXxLU9vWmFEiNjWDOe4GZlyl
X-Proofpoint-ORIG-GUID: GdOgTWgUBXxLU9vWmFEiNjWDOe4GZlyl
Cc: Bodong Wang <bodong@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 Gavin Li <gavinl@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>
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

Feng Liu via Virtualization <virtualization@lists.linux-foundation.org>
writes:

> According to kernel coding style [1], defining inline functions is not
> necessary and beneficial for simple functions. Hence clean up the code
> by removing the inline keyword.
>
> It is verified with GCC 12.2.0, the generated code with/without inline
> is same. Additionally tested with pktgen and iperf, and verified the
> result, the pps test results are the same in the cases of with/without
> inline.
>
> Iperf and pps of pktgen for virtio-net didn't change before and after
> the change.
>
> [1]
> https://www.kernel.org/doc/html/v6.2-rc3/process/coding-style.html#the-inline-disease
>
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Bodong Wang <bodong@nvidia.com>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
>  drivers/virtio/virtio_ring.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 41144b5246a8..806cc44eae64 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -233,7 +233,7 @@ static void vring_free(struct virtqueue *_vq);
>  
>  #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
>  
> -static inline bool virtqueue_use_indirect(struct vring_virtqueue *vq,
> +static bool virtqueue_use_indirect(struct vring_virtqueue *vq,
>  					  unsigned int total_sg)
>  {
>  	/*
> @@ -349,7 +349,7 @@ static void vring_free_queue(struct virtio_device *vdev, size_t size,
>   * making all of the arch DMA ops work on the vring device itself
>   * is a mess.
>   */
> -static inline struct device *vring_dma_dev(const struct vring_virtqueue *vq)
> +static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
>  {
>  	return vq->dma_dev;
>  }
> @@ -784,7 +784,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  	}
>  }
>  
> -static inline bool more_used_split(const struct vring_virtqueue *vq)
> +static inline more_used_split(const struct vring_virtqueue *vq)
>  {
>  	return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev,
>  			vq->split.vring.used->idx);
> @@ -1172,12 +1172,12 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
>  /*
>   * Packed ring specific functions - *_packed().
>   */
> -static inline bool packed_used_wrap_counter(u16 last_used_idx)
> +static bool packed_used_wrap_counter(u16 last_used_idx)
>  {
>  	return !!(last_used_idx & (1 << VRING_PACKED_EVENT_F_WRAP_CTR));
>  }
>  
> -static inline u16 packed_last_used(u16 last_used_idx)
> +static u16 packed_last_used(u16 last_used_idx)
>  {
>  	return last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
>  }
> @@ -1612,7 +1612,7 @@ static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
>  	return avail == used && used == used_wrap_counter;
>  }
>  
> -static inline bool more_used_packed(const struct vring_virtqueue *vq)
> +static bool more_used_packed(const struct vring_virtqueue *vq)
>  {
>  	u16 last_used;
>  	u16 last_used_idx;
> -- 
> 2.34.1
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
-- 
Would you offer your throat to the wolf with the red roses?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
