Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AB5C433F5
	for <virtualization@archiver.kernel.org>; Fri,  7 Jan 2022 00:34:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 65A488333E;
	Fri,  7 Jan 2022 00:34:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bo579mbjNufB; Fri,  7 Jan 2022 00:34:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F0F4B832FF;
	Fri,  7 Jan 2022 00:34:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7B2EC0030;
	Fri,  7 Jan 2022 00:34:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3F0BC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 00:34:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7DB6B8333E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 00:34:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x8VKU3wxAEuJ
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 00:34:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 525FD832FF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 00:34:00 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206Kqo82014505; 
 Fri, 7 Jan 2022 00:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=lZ0qM5b+EJzJJnsTcO50dCVxwIbkOw7c1EfGauluHeY=;
 b=B6qJwdQYpBKYBhxAj98dUuZFJA2Le5GBLo8q32cy1wxcvMIVOzLjCQRTyq9Z+O/BdE67
 nPIAtuuLACeJ49HVaRyzCCuhhvPVMm+/JUcitgs+7Cl7akJiSULxh6+q71DbfiFyl5J3
 tX7eTqAYJ69BQepg3N38ny6BpkytQIxve1YkZnOXdgvqBDF3BIAwQD5OOhXxvomkowH9
 TPpvIos5Qowb6bDLl42EQi8+NFudHf2mJqvxlXxNQTFcMyaZdWS0eJhMH3q9nrQHNItE
 cczX3aokN0tUuho5RpGXaKMMtu/7M7uveCh5HmEwWFEodxFrnD+ae4i6YDqilBFx75bF Ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3de4v8gu7j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jan 2022 00:33:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2070VMtF162555;
 Fri, 7 Jan 2022 00:33:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by userp3020.oracle.com with ESMTP id 3de4vmnyqm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jan 2022 00:33:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXZX4E6ayBEA2jjJPTMe8JmMbaF2ZMk4i1MHZrgVQlBUA1tKEmeMNtumWjNlMHhXL+jD01o6GoUf9EF7Zk8lpZ5jyUBYWrdGie0N7AgyKgc9rq5LiNjIplGitmIxTVgRlBigRwc6RxTQ5W9P7Ew1cMqqAW1Pw7+AoF3gGPlxX3E9Pdagykp5q/20IOLBz+10qcjIKwgkHBlfswW3iCIi9ZPqkwIaG7brS9M+qx9tFqPdpyuwuE4pQlXh3r0+5vQlaKBj6hb0YEANxfehDVpd1LIQhq8oPL2cdPDNPYaBB6mGczq0Gkh0jA0TdueCJbwhq3e2EjMtHp3ic1hWLCilAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZ0qM5b+EJzJJnsTcO50dCVxwIbkOw7c1EfGauluHeY=;
 b=bSxvoi1CSXjfquPSI8Q1IqT5/YMqJEFHAzW7zsEGX1Vlro+GktX9h7cw5lQldE9ATgMLYJjDsLs3Nb0OYPB1npXOfGcUdPpQBVALb5MWGTD2ZXXG3Yrej9lOK5GcupyH3LrLC4lLwLGPP110bDp0+cm7NQ5tuq9J0TyN37UglJuwGn8b8/ATQd9LbQAfEAk42Xj/dBxSFUev2v+jazoUuqIy7hRPoNOEn44es/a/mrVdsxHuKhX5DUmY7NxplBuQkWEdyB+xfjPr2PZeExbthls97HxsxE0JdVE76km6oZatALQsyyySpP5spEt2wKt4IE17wS0FnT2hJBkjIrR63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZ0qM5b+EJzJJnsTcO50dCVxwIbkOw7c1EfGauluHeY=;
 b=YGErnO32EBLojiUvxFp+wM/auQlcKrEeVDOOIzLhAOBZvL4VwsCEp/iH+YrIKKhrjSge0uKihLpmWgOKv6PkaSZeLqUrkg9YDGEbE2TGpUCJR8BLHNxOVt9Jkd4v9rWcA0bG/bPEVN3l0GzHjnsuriOlbuWZfX0zbkp8PFz0G7w=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB3368.namprd10.prod.outlook.com (2603:10b6:a03:150::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 00:33:55 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 00:33:55 +0000
Message-ID: <e6218f34-a7e6-9bc5-8de7-7690dec9aa01@oracle.com>
Date: Thu, 6 Jan 2022 16:33:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v7 03/14] vdpa: Sync calls set/get config/status with
 cf_mutex
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-4-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220105114646.577224-4-elic@nvidia.com>
X-ClientProxiedBy: SN4PR0501CA0055.namprd05.prod.outlook.com
 (2603:10b6:803:41::32) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4341e62c-9a55-4272-42ef-08d9d1756321
X-MS-TrafficTypeDiagnostic: BYAPR10MB3368:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3368F85C88FBA5D3FB13EA60B14D9@BYAPR10MB3368.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3L+JtU1zapav8FYlRjZpMJeM10O99D2Yd0wHTtzLB/SsV67O6PE5wMasE1IpUctWLociL3Awd+8n5fUU4zMjh1UuXk74AdOlQ1Wm8LQr8ysnAAylaJX4hXz2G58dICD88Urw7ghfT7ne42EgYcz1uOqoP5hFibIJQUbZ/vi4QLqDfRFMhZIM6dve/Cuy7dwuaZsy2Ng9usyjDULT+iANJlyWCc2KXQ8Q9hRQurgJDrS8AXdlai8L13eYRSDJJZeE7uo6e1roX/NOlrQaNfQUEYgJxa8Sw5ymQHtPIJ4JIKQK+Jjo5/I5e+JeV+su9PvtIEMTnQ5qSn9h4AS+/bJMCNT96nB66LSYs3yGBezrI4+C5YN7d2BPJlmBSUkj4I84PMN45Zo0o58u3P3pluFRhLFblxrCHELYOPfpidoIozemnxArsst13AATYHoMi7bMGq8G3FjwhW80yEPMTuMGuLaBhqe4Jfk4pu3B+WYG/cED6Bgo7tUQRYgA8OFhEGl64aWEAPy7Z04eB1Vn9Yy7hBewt0Dy8FEhlV0tF/OX33aYpdSNsTtX5gJlHRIxOKhV5TNfOuq7fbZTcKpje8OAczFDe1P9yBvwHKxYFjYVpgcUveV1idq3869RLPvupZb00ITb8GuRM4se93q3u65e9ikgkwrqMBDITda352XP8ZP/s1gsi+nYqD1gBotdDO0M4SRytYWQrnAqBFNjPzgae6sJLXod7A3U0/MhD8APlZk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6512007)(8676002)(8936002)(508600001)(38100700002)(36916002)(26005)(186003)(66476007)(2906002)(5660300002)(6486002)(66946007)(316002)(53546011)(6506007)(66556008)(2616005)(6666004)(86362001)(4326008)(36756003)(31696002)(31686004)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3R6RDd3NTZ3UEYranhxMnZFNnl0YW9STCs4R3Nhd255ODdpVmo0eGc5RDVn?=
 =?utf-8?B?cTNkdUYvVjZPdCtrODBKK3dvM0gvSmw1TFVxZnVMdUorbmU2R28zczYrcnpC?=
 =?utf-8?B?cVNSeVJsYmxZaDZrc2lPUHN0Qkl2TjJnaWwyVXpEOEhPOU5pOUk1ZEJaVzlz?=
 =?utf-8?B?VTJtRjdRMDBNRzBCZ3FGOFgrSHRIeVR1QUp3bzhPREVraVZlR2NPSHlRWHMx?=
 =?utf-8?B?bEpQY2tGdmJ0TlA0Mmp0a2J1MzVUd2JyQnd4c2k0Q0hkdFE4MHVyVG52V1VV?=
 =?utf-8?B?Q3VRTS9jL0dMTHlkNElrc3hJcEFnMjBvZVNNRGF5VlVMM1hEaXlvQUs5ZWFt?=
 =?utf-8?B?dXFYTkJZRnNYelprVmRvUHlzbEtHM2J2SlNPNHUyZG5pK2tUbUZ3eHFMendt?=
 =?utf-8?B?eUh0WTdJSnAweEJmSm9lRHNWOHcrK2Q0VHpSOFFIQjlHcEtseHpnYjJOZFA5?=
 =?utf-8?B?Y0Y2TkE1UXUwZlNiejlvOTlDbzRROHZlYnRTTjAwd3NLQ0t5MC8xeXc1OVVz?=
 =?utf-8?B?MlZrbUlxTVE3bXlua1gvcDczbmlCUmJJV1FNM3FoWGovV0w3TklaMFVDckVm?=
 =?utf-8?B?TDJibjJZazQ4TThqZzNTakkwQUhSYWlINlJZUWIrNFM1UmVSa21FeVB6SjBY?=
 =?utf-8?B?aWc1RXFESG4ySkx6bTZQbWszVk0welRjek5MUkNEVGlhUDBPQWYxNDVVM0x6?=
 =?utf-8?B?eFMvMTNLYXk4emZxZWpXd3NHTjkzbzZRa2tMRkhhb1Y4VFlkR1ZGZ3paVTRG?=
 =?utf-8?B?V2g4Qm5LaDV1QW5aME1COGdsUlJvenVQcGx3RmRjVDFxVlJHaE9DaWhDQ1dl?=
 =?utf-8?B?K0NoRlBLZSsxTDhhWGtnTmo0Y0JnV3F6cVZ1VFRpK0NUdnB2WjdWUVd6QzZS?=
 =?utf-8?B?OElvaW9qRHZXckVCWDYzRVNzdEJCSlFhczZoQnM3RWw5dkJMR0lmcjZZdE4v?=
 =?utf-8?B?ZytkQ1BZTHBkNmJCUS85ck1GcmxsbFhnVTU0NVJDZjhBVEhoMHY4S3ZQbURH?=
 =?utf-8?B?YmpoSXAzcTRhNXZyS1o5Q2N1eHZJVW5kRElkbUx2RjB1MEVhSkpVV0FIaWRr?=
 =?utf-8?B?K3pTMGpsaXlvOTIwSWh2VGtqb1U5YlFMT202dUhldDF1VzAzSTBjSkY2OFJN?=
 =?utf-8?B?bUdJbFd3UUdRS0VLd3JmMFJFNExOT1FxejIvVmZtN0VCcm5TMjlBOENCbCtL?=
 =?utf-8?B?VUZ3UzRBZUc0aE93ZWMyM1hVZXhQeVZTQkFpYUdURWJmcXpvbmluejJVS0FZ?=
 =?utf-8?B?M2l4OTdhdjVMZWFpWHhNUXoxMHVpajlkcVlxb1hUZ3llMms2Z3BzcFBRaHRP?=
 =?utf-8?B?NGVhdjFBMkM4S1FPSTdZd2dueXFTNkNLdERQTGdrQXBaVThmMk1RZDJseUVh?=
 =?utf-8?B?V1h2eGtwcjBybklOS1RJM3JvT2NWTlljZmtsYW5vaG5ocVdiVEFUdzE4ell2?=
 =?utf-8?B?NEdXWlFibVExN2FaQUhSZUV6MnlOZVBkcTZPUzlBQjg4Sm16dnhkazJYS1JI?=
 =?utf-8?B?MjFrSzdmK2ozVHRSdDF4cTRNUFBpL1hDbnozaE1FT3duZUdkRUxIYW1HNXVP?=
 =?utf-8?B?OGpFaTRiZDNoUEhWbmhFMkNONHJuQVYzYmk1RDlRaXN3SEtoR0dqaHZOakZY?=
 =?utf-8?B?SWRDNjRTRFVnSUYwTUVXMmtJa1N2MmZkSGo2WW1mVk9pQjdibno1dVpFMFVX?=
 =?utf-8?B?Wmloa0NPdWh1R2cxdDhSWkswK3VBbUdOcEdkSndMYU9IRzYrU3V0TGE1TFIy?=
 =?utf-8?B?dkpMNVdNc3NBYkw0Z0ZqbDZ0bnlkaGNSajQ2SHZISnZHOHNCRGVWSzdvNUxw?=
 =?utf-8?B?ZjZSNEk5NzEraHc0K290V3RHcllmemlvUGhLS25VRysvK21TS0FqUzBRd3Mz?=
 =?utf-8?B?WjBHSWoyelpZTXptSXlRS1Yyb2JBN0llYm52YVl5NUJScHZleE1QZUJTSi9R?=
 =?utf-8?B?dlJwRWNTclYxMFgvbUdDREZTU2YvR1N3TE0xTjFBTTRHUmoxL2hLY2NnWHFV?=
 =?utf-8?B?eUVCNU1tdk1pdlViVUVVZFNhSU0xMG9NN1lpWkxZZDVCeVpHRDlqQjRkS09R?=
 =?utf-8?B?VUFoa2p0Yk9ndW9QZm5haENKUzVjQVcvVzhQMVRxbUxCVi9iZ1UwOUFTVFMy?=
 =?utf-8?B?SWJ5dUZpN1MzWFg1ZURoanlpNy9XR1dFS1dMRXd0eHFmYXd5WU5WRm9PMFp3?=
 =?utf-8?Q?e2WaUiuprsa6baKHU3jGupE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4341e62c-9a55-4272-42ef-08d9d1756321
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 00:33:55.6013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0YCCaCW8RlcQIwIqpaSHu+G8RTNZWMHdKs/fkCzBQakzBELJLrHjZ/F2Kq1TdJNDFNIiLTnE0BuAGHfZCuQyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3368
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201070001
X-Proofpoint-ORIG-GUID: BsMdeTA4wQWEovVzWaoEoqdaX1tMfOA6
X-Proofpoint-GUID: BsMdeTA4wQWEovVzWaoEoqdaX1tMfOA6
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



On 1/5/2022 3:46 AM, Eli Cohen wrote:
> Add wrappers to get/set status and protect these operations with
> cf_mutex to serialize these operations with respect to get/set config
> operations.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/vdpa.c          | 19 +++++++++++++++++++
>   drivers/vhost/vdpa.c         |  7 +++----
>   drivers/virtio/virtio_vdpa.c |  3 +--
>   include/linux/vdpa.h         |  3 +++
>   4 files changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 42d71d60d5dc..5134c83c4a22 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -21,6 +21,25 @@ static LIST_HEAD(mdev_head);
>   static DEFINE_MUTEX(vdpa_dev_mutex);
>   static DEFINE_IDA(vdpa_index_ida);
>   
> +u8 vdpa_get_status(struct vdpa_device *vdev)
> +{
> +	u8 status;
> +
> +	mutex_lock(&vdev->cf_mutex);
> +	status = vdev->config->get_status(vdev);
> +	mutex_unlock(&vdev->cf_mutex);
> +	return status;
> +}
> +EXPORT_SYMBOL(vdpa_get_status);
> +
> +void vdpa_set_status(struct vdpa_device *vdev, u8 status)
> +{
> +	mutex_lock(&vdev->cf_mutex);
> +	vdev->config->set_status(vdev, status);
> +	mutex_unlock(&vdev->cf_mutex);
> +}
> +EXPORT_SYMBOL(vdpa_set_status);
> +
>   static struct genl_family vdpa_nl_family;
>   
>   static int vdpa_dev_probe(struct device *d)
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ebaa373e9b82..d9d499465e2e 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -142,10 +142,9 @@ static long vhost_vdpa_get_device_id(struct vhost_vdpa *v, u8 __user *argp)
>   static long vhost_vdpa_get_status(struct vhost_vdpa *v, u8 __user *statusp)
>   {
>   	struct vdpa_device *vdpa = v->vdpa;
> -	const struct vdpa_config_ops *ops = vdpa->config;
>   	u8 status;
>   
> -	status = ops->get_status(vdpa);
> +	status = vdpa_get_status(vdpa);
Not sure why we need to take cf_mutex here. Appears to me only setters 
(set_status and reset) need to take the lock in this function.

>   
>   	if (copy_to_user(statusp, &status, sizeof(status)))
>   		return -EFAULT;
> @@ -164,7 +163,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>   	if (copy_from_user(&status, statusp, sizeof(status)))
>   		return -EFAULT;
>   
> -	status_old = ops->get_status(vdpa);
> +	status_old = vdpa_get_status(vdpa);
Ditto.

>   
>   	/*
>   	 * Userspace shouldn't remove status bits unless reset the
> @@ -182,7 +181,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>   		if (ret)
>   			return ret;
>   	} else
> -		ops->set_status(vdpa, status);
> +		vdpa_set_status(vdpa, status);
The reset() call in the if branch above needs to take the cf_mutex, the 
same way as that for set_status(). The reset() is effectively 
set_status(vdpa, 0).

Thanks,
-Siwei

>   
>   	if ((status & VIRTIO_CONFIG_S_DRIVER_OK) && !(status_old & VIRTIO_CONFIG_S_DRIVER_OK))
>   		for (i = 0; i < nvqs; i++)
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index a84b04ba3195..76504559bc25 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -91,9 +91,8 @@ static u8 virtio_vdpa_get_status(struct virtio_device *vdev)
>   static void virtio_vdpa_set_status(struct virtio_device *vdev, u8 status)
>   {
>   	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
> -	const struct vdpa_config_ops *ops = vdpa->config;
>   
> -	return ops->set_status(vdpa, status);
> +	return vdpa_set_status(vdpa, status);
>   }
>   
>   static void virtio_vdpa_reset(struct virtio_device *vdev)
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 9cc4291a79b3..ae047fae2603 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -408,6 +408,9 @@ void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
>   		     void *buf, unsigned int len);
>   void vdpa_set_config(struct vdpa_device *dev, unsigned int offset,
>   		     const void *buf, unsigned int length);
> +u8 vdpa_get_status(struct vdpa_device *vdev);
> +void vdpa_set_status(struct vdpa_device *vdev, u8 status);
> +
>   /**
>    * struct vdpa_mgmtdev_ops - vdpa device ops
>    * @dev_add: Add a vdpa device using alloc and register

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
