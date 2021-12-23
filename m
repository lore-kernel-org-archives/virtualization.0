Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF66BC433EF
	for <virtualization@archiver.kernel.org>; Thu, 23 Dec 2021 02:43:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C43560ADF;
	Thu, 23 Dec 2021 02:43:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HvUu4pUjzacl; Thu, 23 Dec 2021 02:43:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BB45C60AC7;
	Thu, 23 Dec 2021 02:43:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89F8CC002F;
	Thu, 23 Dec 2021 02:43:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0386CC0012
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 02:43:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DCE5060ACA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 02:43:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RSgK02Y8kwO2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 02:43:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7889460AC7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 02:43:49 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BN0U8cO006458; 
 Thu, 23 Dec 2021 02:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ULPaH3qG8gbgXc0cHT6D8N9c4IGG6Qc17m+Lw6gCZqE=;
 b=IF5xiAoHH2e0s+IPdiI2N4H5zJve7YHwJ+1e1dhj8YHtz/BvbTvx/ZhFtHM9ZqroKtC4
 79M0HgjrncDHy55aqmAONmyuZX2p8Ocdzt5Fb+KgVUKxwQPAKObEzM7MrTy3LSAq6tIv
 s5i9YqZCdzXoPS9YSnbjOWsKc9ZXYgjR5G5gMns2AYlTxRY9do3cue9g+TR6NU/2gXVy
 lD0DrvH33SWbSNJtDbf9tFYh/1T+WscfbbjN7a8IN6i3vTU/PHwVtXfpzkuyG4NXE9/D
 K7WGPWCoEFyqmVmtOgbX8b6yX7dRQ/4QqJcym9Pi5CthSJ55uQMw1umbgOilmwMzn8+U ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3d47a0h95n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Dec 2021 02:43:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BN2b09a159299;
 Thu, 23 Dec 2021 02:43:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
 by aserp3030.oracle.com with ESMTP id 3d15pfgy49-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Dec 2021 02:43:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqC7s3N/7mlZrkdivE3yARTdBoaXmXDhta7WapMGiYgoqr2iIUNO8Q0RPl/jwhq2qBYI/3NzE6G5S2ATxzsVEGdjG1SqIvxZETYIG8wwHN1mHRDRzswTTBNMK7/fSGtNHQL0mMclYiD1E3unxvOYKkR9iZAftnEL9RlEILXgvHn+n619nmoHcQK9LwU5OFOAWHH4TVd8vNn/5FU3CFdw29Ybt//pEDRnIlqo2TbeyGSEHoCRuRcs9uak+3ylpFFP+oJ/TS80kZj/ZTkHTbsYbDNWiGf4Iu/emRDT1E1bu2zugdX4OBw81gtoR9rvjb9UlCpKP5gkhdEtVOJDiAVykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULPaH3qG8gbgXc0cHT6D8N9c4IGG6Qc17m+Lw6gCZqE=;
 b=bR6Wp22LAJJpEq0LoHq/ENVE1DhDtmwc0+cvxUCaWZYbzBWB/bj83NX584II1rftvM3leYpI1V7+H2+HrcZsJxfcelb0LZIfWA0rGvCnj0BCQM3fahRJtsWcQilVpRLnuOIAxgZIsLHfsztbUSZaxGu4odiA1wMusYJ7LLKYH2cc3nt9QfBX1h4Ihl3lQWf0euSEgwBBtNDeNp6aP7BoBea+0RKdFvAKwpDqxIr2G/QiUOtIwod5hs33gs9Btm/LdHEaIhaYQfdE0M1oKtxG069nQL/rHcncbP1AjFeJQXbpN7CaWWgkHAK32rWY0NZfbpS3kjpaqEyQgOf6T/iE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULPaH3qG8gbgXc0cHT6D8N9c4IGG6Qc17m+Lw6gCZqE=;
 b=AtyiJSQRRdGjUPHILSTutL7dZbJzPl2++kma8G7mB1Rnq15ae6oMU2eownO0Y279oyoSqCPVYTO2Gme0PdBDErYhdLw78U/ChLobF52oWDdJlmnfxRZGmxSz037lElYubU0rI6xfBRNtxp4x/ZSXDGFnhw883hJwHONN/iPxyVI=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BY5PR10MB3796.namprd10.prod.outlook.com (2603:10b6:a03:1fe::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.19; Thu, 23 Dec
 2021 02:43:43 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4801.024; Thu, 23 Dec 2021
 02:43:42 +0000
Message-ID: <47ce323e-c2e4-cf13-063e-78067c03a4d4@oracle.com>
Date: Wed, 22 Dec 2021 18:43:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 10/13] vdpa: Support reporting max device virtqueues
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20211221172006.43784-1-elic@nvidia.com>
 <20211221172006.43784-11-elic@nvidia.com>
 <e98dfbaf-8a2d-4cd6-c875-b4780137b0f8@oracle.com>
 <PH0PR12MB54816A7E1D045997B797961BDC7D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211222064728.GE210450@mtl-vdi-166.wap.labs.mlnx>
 <PH0PR12MB5481C33A91EAE3AADABA73E8DC7D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211222071036.GA213382@mtl-vdi-166.wap.labs.mlnx>
 <84292943-b4de-8162-1fde-fcfab479b629@oracle.com>
 <20211222075402.GA214545@mtl-vdi-166.wap.labs.mlnx>
 <8e93cfc4-b71e-adc5-8b35-337523e3a431@oracle.com>
 <CACGkMEvMAS1PspbRdL-0SHfGkkZLp-1AFQAwCkQPAiZeMzxAHw@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEvMAS1PspbRdL-0SHfGkkZLp-1AFQAwCkQPAiZeMzxAHw@mail.gmail.com>
X-ClientProxiedBy: BY5PR17CA0057.namprd17.prod.outlook.com
 (2603:10b6:a03:167::34) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4d189fe-e97d-4cfc-1285-08d9c5be086a
X-MS-TrafficTypeDiagnostic: BY5PR10MB3796:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB37969AF4778C18B189FE816DB17E9@BY5PR10MB3796.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mRafbQW13bKzuUapYixLOfnfh6WmhoNtQGRozd+GV9PgDx62e8tDOmrXdaZ87Fha6OOnuPeDfq1HZcV2Z3b8S+G8SjTwRejEOORmztzmvQ5COorUDcG1qlpiIKrKsO8Xc12Iy7y0Jexuui2f3s0lJFIrW3ffo05zbnShe17o1QKDWznlY480Efd9upez2rhs535Bhjbv2Jjz1Gqdxv4Z4DruJXfOAxfI3gv5e8IumoTvgmU0YL617ryZU66jonRQiao/YffuGg8rk/tyJIbrqfANjLd5jv6xZ4MXutpXXcP4fISxcXC70aNTBm3cVPL/EcFN9THjpKPYgrKXGnc42QYIeNAiJuALQKHfUwc2PDEgfe/52R5W9CLuMvrfzgIurLg/hmx/mZxOgE5rCiPLzZozGcZxjygNpCg87TJSjr0voUHC+kQrIBGRdtxjkLK9MdqPG7BN84Lgmmz0fydtrxFNAtDa2zvN23DrJ0qh6fqeSRZx+STdAnU526fCwSMbhDqQRja11F5B5/CTzRFBY0pLC17DKUlzdVD9LWN7lC1t15DyJFhctXYeoMFBzl+jOzBR4XZ7ffQtimJDnrj5jv6TUlu5eDjBkfZNhSGRu8w1P8F2gtX7KaG5wydu4ZgPFR2MfCR+8VZ14H+quqx1s7OztISLRbK5KfYQBF7V5Y99bKm/02DKWuVaoaHxEl0aNMtD8al8MyXIH4eCxivQzp0z6aTeWJQXGrrmRzrk4po=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(2616005)(66946007)(31696002)(66556008)(36756003)(31686004)(26005)(6666004)(54906003)(6486002)(66476007)(53546011)(316002)(6506007)(5660300002)(6512007)(86362001)(8676002)(2906002)(186003)(83380400001)(8936002)(36916002)(508600001)(38100700002)(4326008)(6916009)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkRtNlJZeHM2dGlvU1B6UFBsSGFCaDUwZFZLRHZ3VlpzVEhScTJZa2w3QjZ2?=
 =?utf-8?B?TGppM3JhNHFwRjI1Y2d1U01wdWFjZld0UWhyNWNMdjFyRWRKRktBUktSc2d2?=
 =?utf-8?B?eDU4LzNFTTQ1WkhaSFVvbk5WemY4YldqOW1Jd2dveWc1bmVlNElub3E3bzdi?=
 =?utf-8?B?U3k1bUduVEwvOVRNRm9KVTErWnZiRHJNWjkvYzNjdXUyWGptRTVDMTNrVTVH?=
 =?utf-8?B?cWtRbzRKdGhSWHRYeWE4MWdyZ1NYR0lOWHkzZWF5Z1cxTjRwYnBaTTVzdFhR?=
 =?utf-8?B?YnNlVzhRWndCUGM2dElleldJSnB0cHVTcDk5d25Ga1ZSQ3ErNjFHZzkzZGlh?=
 =?utf-8?B?cVorZHErWTk4OFdBcitMN0JJV09CYnZnL1FTSlV5WE9rRGNCbExhcGR1bmhz?=
 =?utf-8?B?OEs0WjdZbTFpL3plaVZuRTVMOVlQZGRBeWtaYzZ5OEVHNmZzSlFRSDBTTHdn?=
 =?utf-8?B?eE1BTkVYQXYyL2FmL0QzVEdpaWtxNkZFN1NYdFdzcEtVV2c5S3E0Z3VOdWJJ?=
 =?utf-8?B?MjhJUklwajJRL3lqVGlaQjU4c2xnNkp6dnFuTU9mWWlLcWwwTDZVUk4wUi80?=
 =?utf-8?B?QjB2SXZiZlg1MlhwNysxUUFBeWY3ZDN5U05FdmZaL3dBdjUwVkVmVEVpTHJi?=
 =?utf-8?B?MXNXblRGdUJxNE1yY2drYnZiK0JlbVVjampPalZlck55bzVuOUdjVzRDWllS?=
 =?utf-8?B?VCtwcGNyKy9rNTh5NlNZclNuZnVHdGtBbDlDa3JmM29mdldnY1FKb21RMEt5?=
 =?utf-8?B?MVNvRXNVQ1BQdHdIc2l4NjBxd2R3Z2hNWi9OeC9zKzN0RGJsQ3hDUWI1ZEZJ?=
 =?utf-8?B?am1Lc2RaeHRSMjh5dGtNaWZKYU1mZXNZeE14NHFaQlBWM2s3Z1dKYWcwWjdF?=
 =?utf-8?B?RWdLdFR3VWtBU2phYjd0M1FvdTcvYUFaT1JDcVUvTDVWWmdVSlFuM0k1NjJo?=
 =?utf-8?B?UysxejNDb3NaWnlEUk4yZHJrMy9LeGh4UWNQeVg4ajk4QVNjQ2NVS2FtMC9W?=
 =?utf-8?B?NGlEVHVWUGp3SjdSdmVObzhQVGQyVWJ1QUxuUnp1ZFNKZWF1TG40N0RubURC?=
 =?utf-8?B?bGovS254U01YSUQvTVZDa01iUGp6WVEyU3BnZDdsdzJ2UHVCM2JmL0NQNnZh?=
 =?utf-8?B?M0NyblF1TzlpQVFNMmw0QXVzL1E4Z0VGUWpJcEhQYkd5YTI1UnJNQUpzOFp2?=
 =?utf-8?B?QnVQdWpIbFZoWjlORDlqdHRPbkRGVjZnWHhxbFdpVU1OQm05YnQ0VmZYcEps?=
 =?utf-8?B?QndYRFNubG9QWEd6ZDNGTllUSy8xQkhtS0h1R2xsQW5SNHpDV0R2R3N1bUQv?=
 =?utf-8?B?bW4ycVJRRzBVcGlkMndIZlpPd3FKLzFteTl2L0loZFB4dmdCYVhKS29QUjNK?=
 =?utf-8?B?Qms2MU1RNWl5TlhrRXdDVmdvNlB1cHI4UHpiWEJlbDk2MStreDNWUzFkczBl?=
 =?utf-8?B?T0NoajVlMnBDeGNOYlQvWW45dkwxaWR3NzY5SEQ4dmdldWtiYUhFcXB6U0lC?=
 =?utf-8?B?SVBPODh1SklPeUxzVExUdTdodWdCRU1sTjdvZVZ6WEdLeUtEdFRpaFpYMFhG?=
 =?utf-8?B?T0NCeTlWLys4OVJtSzRscVNjV1laWEdYUFY5bzNxMHlrZlBBZG84NktKRWJC?=
 =?utf-8?B?M3l2SkdDVHR1dHg3TjZhaVJpaWhoQXFWbTFxVVViMVI3ek9qTDlVNitCVk1p?=
 =?utf-8?B?N1VCN2tzL2ltOWh5NkFZa1Z4SU1XQkNHYm9VZUl0L2lJbk9GSWQ1MVZSOEhQ?=
 =?utf-8?B?NEVlUFdoMFg4NzBvMlRsQWp5dVh0cXBiN0ZvNUpCVzVhaGpGRm9TZEN3SERl?=
 =?utf-8?B?SkVrRVo1SThBNmFxMVhkTkZGR2xUdTZ0Q1BxWG1lTU1lV3RMWUwvbXZSMmdn?=
 =?utf-8?B?VGJvVWpCWDIxVDF1bWR5L1dtVWpBRFpTeldJVTJSM0sxM0o3Nk5PeUZoWTJ5?=
 =?utf-8?B?T2NoWEkxR3dydWM2WE1rK2hMbHBINU1VMEpmVEFIWHNVU0gyanIydjBRMEJD?=
 =?utf-8?B?SUdwY2lpVWtHSWxYcmNmUGJMbTVkVUZNVFJvdDYwbklrRW9CM09XSVpGam92?=
 =?utf-8?B?WWwyTU9UZWw3RmZ6RGpJN1BTTHU5NnZzL21zT3RIazVZT2YwZXhUYXhhenF4?=
 =?utf-8?B?VVlPWm9KT3k2V1BUMkRuUnI1NWNMaXdpeWtvMVdwYTVnalJrbWZwNkc3Z2Vr?=
 =?utf-8?Q?EgbGr8uG2n0uFzQDnH2AUn8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d189fe-e97d-4cfc-1285-08d9c5be086a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 02:43:42.8544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTD4Yj25LW9TZw6XvIFMI1a4siL9F0WKYHVy4MB8H2Pc6HYFFKYgFORG8ngmgmsV4igBoWKF1hqsjuKzNY659Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3796
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10206
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112230010
X-Proofpoint-ORIG-GUID: 3CAi9WByuyLHqBylNMaZkamgABpFl5L0
X-Proofpoint-GUID: 3CAi9WByuyLHqBylNMaZkamgABpFl5L0
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>
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



On 12/22/2021 6:27 PM, Jason Wang wrote:
> On Thu, Dec 23, 2021 at 3:25 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 12/21/2021 11:54 PM, Eli Cohen wrote:
>>> On Tue, Dec 21, 2021 at 11:29:36PM -0800, Si-Wei Liu wrote:
>>>> On 12/21/2021 11:10 PM, Eli Cohen wrote:
>>>>> On Wed, Dec 22, 2021 at 09:03:37AM +0200, Parav Pandit wrote:
>>>>>>> From: Eli Cohen <elic@nvidia.com>
>>>>>>> Sent: Wednesday, December 22, 2021 12:17 PM
>>>>>>>
>>>>>>>>>> --- a/drivers/vdpa/vdpa.c
>>>>>>>>>> +++ b/drivers/vdpa/vdpa.c
>>>>>>>>>> @@ -507,6 +507,9 @@ static int vdpa_mgmtdev_fill(const struct
>>>>>>>>> vdpa_mgmt_dev *mdev, struct sk_buff *m
>>>>>>>>>>                 err = -EMSGSIZE;
>>>>>>>>>>                 goto msg_err;
>>>>>>>>>>         }
>>>>>>>>>> +      if (nla_put_u16(msg, VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,
>>>>>>>>>> +                      mdev->max_supported_vqs))
>>>>>>>>> It still needs a default value when the field is not explicitly
>>>>>>>>> filled in by the driver.
>>>>>>>>>
>>>>>>>> Unlikely. This can be optional field to help user decide device max limit.
>>>>>>>> When max_supported_vqs is set to zero. Vdpa should omit exposing it to user
>>>>>>> space.
>>>>>>> This is not about what you expose to userspace. It's about the number of VQs
>>>>>>> you want to create for a specific instance of vdpa.
>>>>>> This value on mgmtdev indicates that a given mgmt device supports creating a vdpa device who can have maximum VQs of N.
>>>>>> User will choose to create VQ with VQs <= N depending on its vcpu and other factors.
>>>>> You're right.
>>>>> So each vendor needs to put there their value.
>>>> If I understand Parav correctly, he was suggesting not to expose
>>>> VDPA_ATTR_DEV_MGMTDEV_MAX_VQS to userspace if seeing (max_supported_vqs ==
>>>> 0) from the driver.
>>> I can see the reasoning, but maybe we should leave it as zero which
>>> means it was not reported. The user will then need to guess. I believe
>>> other vendors will follow with an update so this to a real value.
>> Unless you place a check in the vdpa core to enforce it on vdpa
>> creation, otherwise it's very likely to get ignored by other vendors.
>>
>>>> But meanwhile, I do wonder how users tell apart multiqueue supporting parent
>>>> from the single queue mgmtdev without getting the aid from this field. I
>>>> hope the answer won't be to create a vdpa instance to try.
>>>>
>>> Do you see a scenario that an admin decides to not instantiate vdpa just
>>> because it does not support MQ?
>> Yes, there is. If the hardware doesn't support MQ, the provisioning tool
>> in the mgmt software will need to fallback to software vhost backend
>> with mq=on. At the time the tool is checking out, it doesn't run with
>> root privilege.
>>
>>> And it the management device reports it does support, there's still no
>>> guarantee you'll end up with a MQ net device.
>> I'm not sure I follow. Do you mean it may be up to the guest feature
>> negotiation? But the device itself is still MQ capable, isn't it?
> I think we need to clarify the "device" here.
>
> For compatibility reasons, there could be a case that mgmt doesn't
> expect a mq capable vdpa device. So in this case, even if the parent
> is MQ capable, the vdpa isn't.
Right. The mgmt software is not necessarily libvirt. Perhaps I should be 
explicit to say the mgmt software we're building would definitely create 
MQ vdpa device in case on a MQ capable parent.

-Siwei

>
> Thanks
>
>> Thanks,
>> -Siwei
>>
>>>
>>>> -Siwei
>>>>
>>>>>> This is what is exposed to the user to decide the upper bound.
>>>>>>>> There has been some talk/patches of rdma virtio device.
>>>>>>>> I anticipate such device to support more than 64K queues by nature of rdma.
>>>>>>>> It is better to keep max_supported_vqs as u32.
>>>>>>> Why not add it when we have it?
>>>>>> Sure, with that approach we will end up adding two fields (current u16 and later another u32) due to smaller bit width of current one.
>>>>>> Either way is fine. Michael was suggesting similar higher bit-width in other patches, so bringing up here for this field on how he sees it.
>>>>> I can use u32 then.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
