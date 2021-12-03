Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8BCC433EF
	for <virtualization@archiver.kernel.org>; Fri,  3 Dec 2021 06:09:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9D9854011D;
	Fri,  3 Dec 2021 06:09:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id muUn8uWlMEDY; Fri,  3 Dec 2021 06:09:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C2790400EB;
	Fri,  3 Dec 2021 06:09:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DAF7C0012;
	Fri,  3 Dec 2021 06:09:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CF46C000A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 06:09:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E94CB40162
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 06:09:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="nFh0ES1X";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="RlK0ORQs"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mJGUIlWpT3kj
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 06:09:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75A4040147
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 06:09:22 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B34SG7M031021; 
 Fri, 3 Dec 2021 06:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9zbvtBv5g5uKpzQe6SCVt8+3KDrRe8MooqZWeNCsUsc=;
 b=nFh0ES1XCa10bWm2HTORgN8IG/U0Ds9sonBxjLePU5BAAEUvDugB2mS3Zy/5LVwPdfZ9
 GuzaUG1NlH42K7NQU00Qf4cduRLiSagz2Chqa2PVxTuGtAhkt6ntOSMl7q+epe45UVe6
 jaiWGNM+dQnby2mh/5qt94Nfq/y6dl1czqmR4k2XK1QKcegXBkmAjPO9LZ7OZSsAfHCp
 qk0caJUtU0TyFHHZwW0aGAWktFxWyy7hNtzTqhGC9eNlGCaEb9bIMDD5+2e5dk7FTUVN
 JkhEbSTmt+yLPrv4mEARDp0ryNZPCSFnp/zXb13s7A2rCBP484JpnL3yuIT9Ut+B5r6b qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cpasyv889-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Dec 2021 06:09:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B367qom120609;
 Fri, 3 Dec 2021 06:09:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
 by aserp3020.oracle.com with ESMTP id 3cnhvhyjvq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Dec 2021 06:09:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbgnYJEmWhiMDPxDb5fJB9slmvyTPmmQJWqyiiNfLu9U1K/rgd0nA6qtgWMq2lq+FNnk0eiGiLNtD1VKu6Hi3YMieWtLJsmlDDLfwLKVs1CUjELwnutaI6yan4R6jN8IFwkVnpFatStcy5U1ibsxFw7cGDFAG2LUGf1Um7QdSL/BmMqU3kIglCOMdB9Klx5IE4dWwypJ8KtK9mvWjpE5wUCYvyIUFasK9mPDtKfJ/kUjx9qpxVLlscl8qE3JSF31XMnf7P6S3dm5j1fxyLOrlBLYI4kcKHgxJaFu5rowv6FUMdvJuRtipiDqmDFYUBY2c2HfX1HE+pl42kNj3866aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zbvtBv5g5uKpzQe6SCVt8+3KDrRe8MooqZWeNCsUsc=;
 b=CviYTr29Ezn3zVYHAZImme87+9ZzryuAFmjBZpPp8R5n9WZ+7IcTi6h4NBv24zcZgLbev/iM6za399pRI3y50wXC3PHla0Na8t4UZGZa7qQ0Expum06V9Ck7rdJe3jLzeAYPUMW6W1wEenUSDOE6sH87ExsWJz5lB7tuekF8Ags06RRI757Ynv76oFfEIMUKWTKqSGm1JSv60I3ZrsA8yD4FFjRrSdZe+CzFsgjpS184rKPf66WAgO3FuD/K+T6Ao0SnI4bCGhqK6w5GfXTKB0jHxCHXS09tVxLeejiweliBbHV8aI/WdEoAjHdV10vr2Izx9LjwetyHpVPUeU3LsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zbvtBv5g5uKpzQe6SCVt8+3KDrRe8MooqZWeNCsUsc=;
 b=RlK0ORQsYeTNaGDr+qOvL5e3nkkCKnZwGDTwnna3xwtdkl9qS+7VQHSTS5X82JPUTCZ8++SrrFfbxZlhbLAOqVOCNz8yolFTwrGBnPuAwye8nFhIMVs8ZhxLgK8Zjush5cgFJpKFJZ71qLQK9ndpRBgPSXGIu/s+laJl6ESF/YE=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB2421.namprd10.prod.outlook.com (2603:10b6:a02:b3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Fri, 3 Dec
 2021 06:09:18 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::89e7:42b2:b226:2182]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::89e7:42b2:b226:2182%7]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 06:09:18 +0000
Message-ID: <9c4b5719-b58b-daa5-f540-e83a3a717e91@oracle.com>
Date: Thu, 2 Dec 2021 22:09:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/7] vdpa: Allow to configure max data virtqueues
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211201195724.17503-1-elic@nvidia.com>
 <20211201195724.17503-2-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211201195724.17503-2-elic@nvidia.com>
X-ClientProxiedBy: SJ0PR05CA0067.namprd05.prod.outlook.com
 (2603:10b6:a03:332::12) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
Received: from [10.159.148.88] (138.3.200.24) by
 SJ0PR05CA0067.namprd05.prod.outlook.com (2603:10b6:a03:332::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.10 via Frontend
 Transport; Fri, 3 Dec 2021 06:09:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0655ce55-c025-4a0f-13af-08d9b623709f
X-MS-TrafficTypeDiagnostic: BYAPR10MB2421:
X-Microsoft-Antispam-PRVS: <BYAPR10MB242103F7C8504153BE179BCCB16A9@BYAPR10MB2421.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f2VGvlyWUykH/Bu3G/PKDLe1jEFrXA7S7dQdJ81GwXODM8rWZqcgdhx6hwR2A5UhUZcU1mWW5nZFPwbivsYgmB8WngAEm1xgO99lJbZtNCiEKDW5o57shBRmeZQSff723qxxY/vCp6cymZu1ZWe7rf/+BIFPaRQB57rOC2F3s0x4lGwDBWOzSu8JFrvEGfgY9rY76r6Gk59F59MIEN4oRxb42hJYBs3pYVTeK3yitk+IbV7TqfbLPjZ+ye6hg9S01CiDCBt0+HC2fuJ7TO1K1x+gNVTweZ8VQgJolvUFRRlmelw1+dwa3kyTfbeDfrse6IhXjc/0PnsbZ5ZSMjeigLB/7qhS5wQklFHEN7CRiByWuw4BqYubVfFLPVlIn4NPtWTeaaWzezsoncdp8YjyVOipyRfovixzKklrKGXbNXsSE81EMWjNnnLPpooWCr+pZPglgbfx9DlgtrfeZ3FSog9cjeiLF9DBTYHC5ef38mCdw/8tVc126EptuWiEHudPIeW/HqkDmoFqoOBWWsTu/QXEfhxGATM9wMIy6kLaID5FpaG/TslsNiCxbed20tndyVBneLwR4AMg3MmZ9n9WcyzmwCay4T7hzfDpot0bxVrp3E3BQTlL0Uc6c1u+UgdmvPdFCdEFgdfkPSmse2d2B4rJiHxO7OkCtE7bC+KuhdzRZ26YqZjs9seyVjcD/nv6hqk6nFJFyKI4/ugw2C1oNV5cJiD8kGI090Q4H+PL4pI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6486002)(508600001)(2906002)(186003)(31686004)(86362001)(26005)(316002)(16576012)(31696002)(6666004)(4326008)(36756003)(36916002)(38100700002)(53546011)(5660300002)(66476007)(66946007)(66556008)(8676002)(83380400001)(956004)(2616005)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QndBS0gwNUdsWkVRMUEwdDREaDhTeTk3U2pIcjdwRnBZRHNVSVA3bkoxU3My?=
 =?utf-8?B?YXV0dFNOckp3dUozNHNSS0Y1QzFkVGU3eW42V1NFTm43RVJvV29KT3oyTGE3?=
 =?utf-8?B?bVgxTTl0eG9haGFQZk55TVh3Q1c0Vnllbnk4VlFZOGxZSEJmbFFmcTc3Rnph?=
 =?utf-8?B?M0xNY1JQTU02bTNYYUYyR3I4L0tJRHZ2RVZaMU5ObFdYeUtwa0piNDdUTkpo?=
 =?utf-8?B?Nk51QjBkNVhlY3RBQmxsbzlxSGd6aDhKMms4U1JaSnY1QmUwMXN5Y0RwQm5U?=
 =?utf-8?B?UkZucFNjaXR2dU1PbExuS2lQUit4U3pmM09neURDTjNnMTBRbkEyTlBXaXU5?=
 =?utf-8?B?RXZMUm1kRVNCaHpJdEQ5R25UYnd4bXM5K21CdkhjaVh5STdnZUsvNEJCVXhJ?=
 =?utf-8?B?MS84Kzhsdzd0WTJyTnR1SGhOaE9BV1ZieXVtbDFVQ211em5tdFhBMVdSQmlx?=
 =?utf-8?B?KytQR3ppNGhadm03VlhpejQxSm95ZGxUc1V3c2RmbkxWRzg2U0RYMzVacjVZ?=
 =?utf-8?B?eU85bEE3Smp1eXVRNkZ5b3JEdDh6WXg3dENnaFFFeGE2cTdhbFRkL0NEYkZJ?=
 =?utf-8?B?ZUxGV1FaQTVleEFQRXJ5T3BLekhHVWpQbnRyUHAyRHdCY0JoT2dzcWdBSGp0?=
 =?utf-8?B?bXZBcHFVc05BWVdMN3hiOXZHeDI5Z1hYVjltWmtBMVQwU0hCNkdvZXVvOEx3?=
 =?utf-8?B?QlVIU1dCY1dJWXR2Tmx4WHl5OE5tUzBPOTBzQUZ4MVhSdi9QN3MxSTc1elNE?=
 =?utf-8?B?TWhUZkhnVDJhZkkxamNYMjRTUWVTZlk0L002MFp1WU5LdXhQSWpSUnVaWWVO?=
 =?utf-8?B?THdOdC9sOXpWV1ByUDF3b0RUS0ZPVDkyQnNTano1WStlSG5HK0IvMFBleHJN?=
 =?utf-8?B?VmdFdlhjNjM4VUl6Wnc2VmJoY25zSDZNbHVkSzljRU5vYWlyTVhBTzJLWjFx?=
 =?utf-8?B?SjQxbnhCeUJzSWQzN0xVMmdhOHpIUTI0WC90MlFrR3JuTFlVSTZNb2lIdDFl?=
 =?utf-8?B?clpTZ1JqRFFMcDlKbTdJWi9vdUpYZVYwWGQ3YTVwcmlPS2Nnb3RibEZIZWFt?=
 =?utf-8?B?NnpVLzFMemt2TzVUMmh4S09vckVudTZDdkRQbFhuVlZ1ZDZ0ODZiM0hnbSts?=
 =?utf-8?B?aTJjOWJpWFIzTXVkYUM0RTVnQmFvVWREUjEwWnowc1hQZmNGck9oV2NVaHNs?=
 =?utf-8?B?T3gxWjVSdHdpa2VUN0pUTjFKRlc5VVpNenIrZmFEcWZ6eGc3b1cra2o5YWw4?=
 =?utf-8?B?TEFaalhHRVRIMFRhQ0xYUFNoVFY0eHFWT2RObWgvZ080RDNYbDBSQmx1ZXRo?=
 =?utf-8?B?aisyS3dkRTBMUVcyZFVaTW1EUmU4d3ppSVVObFZaZ1RzTFo4b3hFQmV0QXNR?=
 =?utf-8?B?alEySTJXNG5QRldyYWFqbWZzbWdMWjVTbWVSNXY4ZGYwb0xob1lrR3k3blk4?=
 =?utf-8?B?dnFXT1FvSEtjMnFCaldxZVR4MUlmK2VNc3ZIVnovSEtUUkg0cHVYYlRBSFRL?=
 =?utf-8?B?NHBKTXpwSUZTZzhSbnhiTVRxMU05LzVhZjBGdGMyT2h4U3ZZUlNrK2ErZW1D?=
 =?utf-8?B?bjJUUW9Pa3phRlBHajV5TzVWME93ckJXY2x3U1VscUU4eG9COUptZ3I3dUwr?=
 =?utf-8?B?bU1wMUFjZXVPMGM5N1RvcmJxckJHWDNjVHF0NlhLMXcvVHptc3drelNOd0V6?=
 =?utf-8?B?TUgvWi9ORzhWMnhkeTNsVmU3VE9MdXlFVjdJZWpJMWdoeGxDYmlab00xWVR0?=
 =?utf-8?B?QkFPbXBvWFB2TEhwNW1qY2FHRFhiMTF4dG9GVTlQRkY1S3FmaHNycmgxb1ZX?=
 =?utf-8?B?SDh1V1JDOWZzVUtWZkhvMGMxMW5XM3QzK1dkY1dEOE0wMU9hMFBlaThIZzBZ?=
 =?utf-8?B?SkFjdHFOVjh6L2NmL1RvOFg2cGxYTVlMdmdJaktFTUdVQ1JzM3Y5Q3VIOGNk?=
 =?utf-8?B?em1JdmU2a2hOK3pENVhDcGJvY201bjFIbk4zQVFPQWErOStjVzh2c0w4Mjgz?=
 =?utf-8?B?T3hSdzZLemIxMmtzNkt6aHFmY2tLU3l4aTM2M3hBTjhONXVla0J6MUlqTita?=
 =?utf-8?B?R05wcHNZYmdBNjZTaVBPZ2RmWk51UEpacUluL2diNUxZQkxEeXh3bi9xSGM0?=
 =?utf-8?B?cnBiZkMxMWNlV0liWk1MdXRBbTBRelFtbW9kdVFvOHJjN3h2YlNNMUZpQXRD?=
 =?utf-8?Q?nB0NKR6x3te7PSqFVy2XEgI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0655ce55-c025-4a0f-13af-08d9b623709f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 06:09:18.1668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMNWkMim6O4eqlmTEYPmECgQFxbDoGCZLVvVI9qJp+bsHalgNKRgfvXfFC8RjIOmdrCvyc9WBwlKceq9UTcMtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2421
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10186
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112030037
X-Proofpoint-GUID: kUcrbYQ2se5hAtWfobQr3f3VQrw1TLR0
X-Proofpoint-ORIG-GUID: kUcrbYQ2se5hAtWfobQr3f3VQrw1TLR0
Cc: lvivier@redhat.com, eperezma@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


On 12/1/2021 11:57 AM, Eli Cohen wrote:
> Add netlink support to configure the max virtqueue pairs for a device.
> At least one pair is required. The maximum is dictated by the device.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/vdpa.c  | 14 +++++++++++++-
>   include/linux/vdpa.h |  1 +
>   2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 7332a74a4b00..f06f949d5fa1 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -480,7 +480,8 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
>   }
>   
>   #define VDPA_DEV_NET_ATTRS_MASK ((1 << VDPA_ATTR_DEV_NET_CFG_MACADDR) | \
> -				 (1 << VDPA_ATTR_DEV_NET_CFG_MTU))
> +				 (1 << VDPA_ATTR_DEV_NET_CFG_MTU) | \
> +				 (1 << VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
>   
>   static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
>   {
> @@ -506,6 +507,17 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>   			nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]);
>   		config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MTU);
I wonder if worth another patch to fix it altogether: 
BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)
>   	}
> +	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP]) {
> +		config.max_vq_pairs =
> +			nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP]);
> +		if (!config.max_vq_pairs) {
> +			NL_SET_ERR_MSG_MOD(info->extack,
> +					   "At list one pair of VQs is required");
s/list/least/
> +			err = -EINVAL;
> +			goto err;
> +		}
> +		config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
> +	}
>   
>   	/* Skip checking capability if user didn't prefer to configure any
>   	 * device networking attributes. It is likely that user might have used
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index c3011ccda430..820621c59365 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -101,6 +101,7 @@ struct vdpa_dev_set_config {
>   		u16 mtu;
>   	} net;
>   	u64 mask;
> +	u16 max_vq_pairs;
This should be vdpa net specific config. Move it to under mtu?

-Siwei
>   };
>   
>   /**

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
