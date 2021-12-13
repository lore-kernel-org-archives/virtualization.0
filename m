Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01049C433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Dec 2021 22:34:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A089981361;
	Mon, 13 Dec 2021 22:34:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nsBD96XyuRCs; Mon, 13 Dec 2021 22:34:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5AA548130F;
	Mon, 13 Dec 2021 22:34:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A1B7C002F;
	Mon, 13 Dec 2021 22:34:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D777C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 22:34:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 28E844054A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 22:34:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="nWgZMkP1";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="thOW4g2y"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y5aBTXOs4Hmj
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 22:34:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3E6BA401B2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 22:34:45 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDLIKqT005529; 
 Mon, 13 Dec 2021 22:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=H44HUiHXc9Nfgv4uw0urdQrV7HSau9uY90HWzHBKcdM=;
 b=nWgZMkP18tdF8XwgEBmnLlmvnQfnkoBa+Ywn2naZHZR3jJyQEQiRVQ/UXA5NtFdsAGVK
 gcgHQ5g+XtQ+ZDJhDrgR8K5ncsXdg7jEVKm/4mpgTbk0elvaAcoYTCbNdMuzKk7R7sBy
 cUn3WF9ZlV+J9clsVPR5ix73lezD0tCujfmKyLcq6dWO6XZCJY6CEe0WgsYUTeOrGbEZ
 QKz0PxYu39w3SMoTkD2cF4f8DffNYgRZZ7SdPfbDLFQhsHFmrMiWLROEo0QMzaLY1gFh
 k2z4g3P8TOQ+DYlB+7XegH1mw5SwGBaW1V8HLfVaBYtYpEE2v4QB1z79vFrhqjIkNp7g MA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cx56u1ur5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Dec 2021 22:34:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDMVmkt074581;
 Mon, 13 Dec 2021 22:34:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by aserp3030.oracle.com with ESMTP id 3cvj1cxka9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Dec 2021 22:34:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VR2smfQuIiqYiOHDUTeI4AQmlERXO+OWtkXs9rJtI9Mv6yJsZk78NctBhQjNSee2Q0SRfSCPCCdUsyERXu/v1Ay7q/CkP1iWmYCFlCgCCt2paRQWs7n3DYl8shY8meeLbLrUc7gtkAsLBPUM8OABse8vzicjNf7gQghvIKcJngbpXhHIf4x92Z2w5lilmqaXmzykI99r2jhqxjWy2a4g3r3uJW5gAMKqiUrYH9IgwsMDArzBuShsfHD9uf83Lk3c8BMS/HcvciTpk9YraTN5mTMyg+22ABB+9wo/9W3RRhw7yDkBdpoCdsle+3+iBEXq7oKa4p9MeivP08CJz2Jv8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H44HUiHXc9Nfgv4uw0urdQrV7HSau9uY90HWzHBKcdM=;
 b=nTM3k2Z/3yYNPSdxVGOwA3icodU+Lmpw3KE+ZtCUvHpex7cnuuiLlGBXaLahR56zMZrjn8AbIJ7UgQxKS/9Eb6qMb1gHPuYOFJrgGAXASDpRdAtsum3gPtokHnGuZxx2ntfeIAG6WKB6NQ7/G9lpFmpiOfCJV+h4zU4MtiFvUDvhXg6YJEbDQbgsmaFkHp15TdUQ8zpE0GNSlFiBAk68wi+JjKW7fmQSc03+/moLb2HVmWh4VRI/0B6T1zjmSweXlUs+m6u12XRPOh0sJTk+H4qjwC10Eej/2ncbnlH/jWfRsDyh+9+3z2A/xt1qvq6jrp+ohYrRXeXG54pAiwzk6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H44HUiHXc9Nfgv4uw0urdQrV7HSau9uY90HWzHBKcdM=;
 b=thOW4g2ymlGnCa6E2kDPQ+xVTsKh9RU+ZaYbUyd1mvBdApu7uf41lKTU1rvn/SmwnL3Xb/GK88pQZOgLMQrYqa1UvkF8wYwcGFaMDHLJFtGrJoxCrIZH2UHTOslBXzAxbhcp1bRd3fu5WfQvV8JW2c2L6ND5f5VdhW5DurSRSlg=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB4101.namprd10.prod.outlook.com (2603:10b6:a03:120::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 22:34:39 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 22:34:39 +0000
Message-ID: <68fec1cf-5a11-9800-5a81-6b53a91ddfc5@oracle.com>
Date: Mon, 13 Dec 2021 14:34:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v1 1/7] vdpa: Provide interface to read driver featuresy
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>
References: <20211208201430.73720-1-elic@nvidia.com>
 <20211208201430.73720-2-elic@nvidia.com>
 <ff8cdad8-cfbd-1d7a-545f-acda1e51a360@oracle.com>
 <20211209064702.GA108239@mtl-vdi-166.wap.labs.mlnx>
 <9522131f-f3c1-1fdf-c63f-bcff00917fac@oracle.com>
 <20211212133854.GA8840@mtl-vdi-166.wap.labs.mlnx>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211212133854.GA8840@mtl-vdi-166.wap.labs.mlnx>
X-ClientProxiedBy: SA0PR12CA0021.namprd12.prod.outlook.com
 (2603:10b6:806:6f::26) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e28b2fe3-d53f-4f65-9717-08d9be88bfdb
X-MS-TrafficTypeDiagnostic: BYAPR10MB4101:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB4101E953035ABCECD9E6BF46B1749@BYAPR10MB4101.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ayeGoQWUYBgEHlYVs5PbLZfXmk2C5zos5hNnPmZl3WDQtOS7EoNlP3Qr0qqrN41wP+66XU7Wh1Ed98pthMce00qoT4qDAHQ+jlnevh6N06U/HOsxmKRh7PFOw/XZp4B9dGnk/r6TnMpnmZeDtiJhFzpXc3QNNugDjgC5pljRJrFRSH5ZDIaSa6qg5+P0A6EqDeYvgQwX8RGqEPWH58ME3FrtX8Z4LioRLB8EWwk7mPgFslYOXoTNuy4iQwAGzhZI5fyTyTZYW6oL7xoqFUmTjzXcvVXs2h9qlvLLOXJsc8UnBfmuXfWT1cAr56g+5rHt+mhFQQKfBh7+6xMRrm0A6XKQG0wTYGymPM/IHOzBzt8wS8zs4NO3MUp50iQ36be1Y+6TPEqrIGsZ+4k8HAS0zFI0uTRgoDMPXvrCDBIafGzwxRTYvIwBExMp7ImhvhbZcHa3akyalKPDtVOpNu0jtz9DFu10udzOGoKoIkmVfUVhe6fbXuwtfLoOmD7XUh9h+z/5jruz/XiT1Qmc1H4IQFmXAkFm7gojPdP+3DTgqkwOb48XVV534xq9fan75nPxSKOM9pMJhZQm6xXI1T+eAaYqE6k+pkvWfdqNtGo+icKZzWhCA6KHmziSZhiEOmCwf08P7hkvMYeOQ1uVbK26pGLXwQU02VaN4uRp2WOzgdOX/klGQOrICWLpq3I2MgSof1u4pGLE98Lr2yLiFWks1n7Fp3p+K+XBkL9hCROmwLY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6506007)(83380400001)(53546011)(8936002)(38100700002)(8676002)(6486002)(2616005)(186003)(316002)(31686004)(30864003)(26005)(6916009)(36916002)(6666004)(66946007)(66556008)(508600001)(4326008)(5660300002)(6512007)(86362001)(66476007)(2906002)(36756003)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1NrU1BySGVrci81WTloZlZvRG5ad2hXc1NsRjBzbEp6K1Q0V3VmakY3alV6?=
 =?utf-8?B?MGg1dENUdHBySEVnNjFGenp5U2dDTjYybDVKS3ZVWjZmTnBVK3JQa1dGNlJa?=
 =?utf-8?B?MHNCYjJNeWdZUWptL2NxU3FXUysxVjhHUndJcDhobllsRmRHZHp1aW1UNUtJ?=
 =?utf-8?B?TUw5M1ppamE5Yll6Z3grQXdzbUh1VmtJN1lkc0NpRHNqc0xHQ1BVOWJUbDlH?=
 =?utf-8?B?UjNUU2NRMXZndnpOZ1hQU3plUG93N0lrMTYwMjNLWHRaeHp2M0tsTkRvWUwv?=
 =?utf-8?B?Q0l0QWVjMWhLUi9VQW5MUXZXdGVVN1dMTUxrSjIwcG1ZbmlQM1E0SDBhQTla?=
 =?utf-8?B?Q2hCQWZiWmQ2T1V1OGVIVG5uRk1iK1dkTndDbUVONFVjbnBmQ1NETk9xZFJa?=
 =?utf-8?B?bDJDSkxiSHZUcVpDVi9hZFhzTDU2VEJBWGhKUFBPbnVNVVI2S0l2MjRIb1J1?=
 =?utf-8?B?cVdvNlBXamdwUlR1eHphdlNjaTI2VTZ3VFhlTHVKbkZBbTJ5NFpoRG9jQ3k1?=
 =?utf-8?B?bEhEdStzOUErMWJGckdNMU9vUFpHRWxTU2ZRNVlSeVRFTWxndWhScWNpaFdK?=
 =?utf-8?B?TnNkWHpRVUpiNzNrZXRTeit2a3FYNlBkZTM3SXRkTWxQa0JwMWduVmdMOW5N?=
 =?utf-8?B?aWdpMTVGelVzYUpVeUhlQVh5Sm9Bc2MrZ0c0SVBCbk1PM0lXNHlCTjJjbFZK?=
 =?utf-8?B?NElwQUE5Y3VDSUxqNXBMSHQzY1ZGZWtkb0kzblRiK1dPNWpVVmcwOFp5T3hn?=
 =?utf-8?B?VCtxYXZkMTExeHBjSHFLcVRDMHBkTnV5STdReUhrRnRIa2E3Vjl2Yjg2QzRr?=
 =?utf-8?B?bGR3Rmp2aTl6dUhXN2U3RVozWks2NDE4bkZQRG9vMTNERmJXQjRDU3dKTUta?=
 =?utf-8?B?d3FlOFRpNWE1Ym0vMEs2R3hiVkVSSkhLY0pxQ0tsRzFZTHdCWHljTXFnU2Na?=
 =?utf-8?B?amhDWCtGZ2JyZVZDYm15MWRIQzRKeEp6YzJXNTJVQzk0RzBMSUlxbGtGc3Jx?=
 =?utf-8?B?ZUh1UUFScERjZndPOTR4c2dsWjBwK043bFFiYlQ4VHJvNi9SaDlIWWhrSEY3?=
 =?utf-8?B?TTF3RVJnRnZuVVM4blA0TmdBbzBsU1UvaDgzMzZtR3Y4WmYyNEYwazhUS3pP?=
 =?utf-8?B?RU94azZqeThlTWpQbkgvaGxpaUZIWU5JQlRqWlduaHliSVFWTHNCY3Q0QzhS?=
 =?utf-8?B?bG9OaHpJS05wRXZFclhsZy9DLzJNR1Q4cmdBOWZVNm1WNGhHbWpQK1VOdjRV?=
 =?utf-8?B?YlJLWEVESm5IM3kyM0s5YnRxNWEzWnowL0NKMDZRa1pmQU1Kd3JMTFRoOSt4?=
 =?utf-8?B?NUJiN0Z1aXo2NlFYUUhXaC9KKzl0ZFdITmtCQXoyalArdjlzZ1lvZ2MrUHRQ?=
 =?utf-8?B?L3ZlYUlXU0JnNUhiWnc3b05vWkZkZTBXUzJSRnVwRXZ5K3ZjbElUa0dsRStX?=
 =?utf-8?B?cUczeEZYcWlpbGZRVEErUlUydXVSTDNXcHAzUTl6Qm90M0syeHpPUDNsa0ZB?=
 =?utf-8?B?bGtGQ2k4M1FVRmorN1dic0VRdDEreG9lSFJiN0JvbVdwVWxyZUUxMlRQS0Qz?=
 =?utf-8?B?V0ZlNkpPQmVURURvN1FnU0s5RVloYjhXQzZudDg2SkZTZ1NxeThCQzdIeFly?=
 =?utf-8?B?ZlVTQlB4a2NubEc5MHBDdUFiU2s3VGFnd0JHeXg1U0NSOFVmMFRvR2JBM0lz?=
 =?utf-8?B?cVNKZkZDUWJDOUFFeTBQenBpODBiOUJJb1ptUFU1cUVBV1EzNmZkdDczMHVN?=
 =?utf-8?B?K0Z6a3RMNUpvWjdxWTRzemc2T0dCR0VGbFd2bStBUWJCUHBycGpGTHRTbnQx?=
 =?utf-8?B?dVErclNoTllWSmVGeFNGUndCSEpDMXJmbHdDdkdTdEd5U2ZnSVFtaDNzOGhj?=
 =?utf-8?B?dW1odGVlUFNHdnRRL3doa1hobU1rU3RyTmhWVm1MMU5pZ25hS3luUk5yemJR?=
 =?utf-8?B?R3MzWVhQM3lMR1RqQ1dyT05jMzhsUjRyeEZZSnQ1emh0WDRvMURtdnlHcmtE?=
 =?utf-8?B?ZTZleTg2OHVYdnRSeFRYeTQzOEY4Y0llUFh2V3FvZnU4UzlqTnQ0TWc3elgw?=
 =?utf-8?B?dVFqSnd1em1HY3c2TGVpNHM4THhTYU1GY0xZd0NEVHFWYTJuKzQ3ZWxpWHJv?=
 =?utf-8?B?Z1JIazhUa3dlZDZRazBKcEJjTzZkclIyTzhGUHF4c1I5VXZZd1hSMlpmOVBq?=
 =?utf-8?Q?e/4DMyqXBBVnPwrK30vY4O4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28b2fe3-d53f-4f65-9717-08d9be88bfdb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 22:34:39.5960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vy96k2fkVbDq6NG+gC2Jc0VaSxQ4k9su4hNXlr0/0VmVyidbk5XqU/AmwV7EeSCKmb6G+Q+eBIveBV34DRlihQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB4101
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112130131
X-Proofpoint-ORIG-GUID: kdmyrWNY1YGUa8Yr0x53ZM5aWCZgKx9T
X-Proofpoint-GUID: kdmyrWNY1YGUa8Yr0x53ZM5aWCZgKx9T
Cc: lvivier@redhat.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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



On 12/12/2021 5:38 AM, Eli Cohen wrote:
> On Thu, Dec 09, 2021 at 02:29:17PM -0800, Si-Wei Liu wrote:
>>
>> On 12/8/2021 10:47 PM, Eli Cohen wrote:
>>> On Wed, Dec 08, 2021 at 03:57:21PM -0800, Si-Wei Liu wrote:
>>>> On 12/8/2021 12:14 PM, Eli Cohen wrote:
>>>>> Provide an interface to read the negotiated features. This is needed
>>>>> when building the netlink message in vdpa_dev_net_config_fill().
>>>>>
>>>>> Also fix the implementation of vdpa_dev_net_config_fill() to use the
>>>>> negotiated features instead of the device features.
>>>> Are we sure the use of device feature is a bug rather than expected
>>>> behavior?
>>> I think so since in vdpa_dev_net_config_fill() we're returning the
>>> current configuration so you you don't want to mislead the user with
>>> wrong information.
>> You seem to imply vdpa_dev_net_config_fill() should return the
>> current/running driver config rather than the initial setting of the device
>> side before feature negotiation kicks in. This seems to work for the running
>> link status which is propagated to the configuration space, but how do you
>> infer the other untrackable running config the driver is operating, such as
>> mtu, the effective value of which is not written back to config space or
>> propagated back to vdpa backend?
>>
> I would think MTU should be configured by devlink before adding the
> device and reading should also be done using devlink. This is not
> supported currently and I am trying to have this supported although at
> least for ConnectX 6DX it might require to add firmware support.
Thanks for keeping me posted on MTU support. But again, what you said is 
device side capability/config that is made static once vdpa is created.

What I'm concerned about is driver running config that is made by the 
guest. Such as the effective number of queues via "ethtool -L" done in 
the guest will show up in "vdpa dev show config".

However the mtu effective value for driver running config set by guest 
"ip link set mtu ..." command won't show up in "vdpa dev show config". 
This is on contrary with other vdpa config, which is why I think it'd be 
quite confusing and misleading to show them all with mixed nomenclature 
in the same place.

-Siwei
>
>>>> How do users determine the configured number of queue pairs at any
>>>> point in case of a non-multiqueue supporting guest/driver or that the device
>>>> is being reset (where actual_features == 0)?
>>> I would think if you read during reset (which is really a short period
>>> of time), you get what there is at the moment.
>> I would stress out the case if guest not supporting multi-queue. For e.g
>> guest firmware might only support single queue without control queue, which
>> is not considered to be transient. Since the validity of the value connects
>> to feature negotiation, how does the host admin user infer feature
>> negotiation is complete? What is the administrative value if they have to
>> keep track of the change without knowing the effective negotiation status?
> So you want to know how many VQ pairs the device supports? I think it is
> appropriate to return this information in VDPA_ATTR_DEV_MAX_VQS.
> Currently the returned value is not the device capapbilty but rather the
> device configured value.
> Does that make sense to you?
>
>> Thanks,
>> -Siwei
>>>> Maybe we should differentiate
>>>> the static device config against driver/device running state here. I thought
>>>> the change to vdpa_dev_net_config_fill() in this patch would break vdpa tool
>>>> user's expectation that the value of max_vqp config is a fixed value since
>>>> the vdpa creation time.
>>> That was not intended to be fixed AFAIU.
>>>
>>>> Perhaps worth adding another attribute to represent the running state
>>>> (cur_max_qps) based on the negotiated features.
>>>>
>>> You can get that information by running e.g. ethtool -l ens1.
>>>
>>>> -Siwei
>>>>
>>>>> To make APIs clearer, make the following name changes to struct
>>>>> vdpa_config_ops so they better describe their operations:
>>>>>
>>>>> get_features -> get_device_features
>>>>> set_features -> set_driver_features
>>>>>
>>>>> Finally, add get_driver_features to return the negotiated features and
>>>>> add implementation to all the upstream drivers.
>>>>>
>>>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>>>> ---
>>>>>     drivers/vdpa/alibaba/eni_vdpa.c    | 16 ++++++++++++----
>>>>>     drivers/vdpa/ifcvf/ifcvf_main.c    | 16 ++++++++++++----
>>>>>     drivers/vdpa/mlx5/net/mlx5_vnet.c  | 16 ++++++++++++----
>>>>>     drivers/vdpa/vdpa.c                |  2 +-
>>>>>     drivers/vdpa/vdpa_sim/vdpa_sim.c   | 21 +++++++++++++++------
>>>>>     drivers/vdpa/vdpa_user/vduse_dev.c | 16 ++++++++++++----
>>>>>     drivers/vdpa/virtio_pci/vp_vdpa.c  | 16 ++++++++++++----
>>>>>     drivers/vhost/vdpa.c               |  2 +-
>>>>>     drivers/virtio/virtio_vdpa.c       |  2 +-
>>>>>     include/linux/vdpa.h               | 14 +++++++++-----
>>>>>     10 files changed, 87 insertions(+), 34 deletions(-)
>>>>>
>>>>> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
>>>>> index 3f788794571a..ac0975660f4d 100644
>>>>> --- a/drivers/vdpa/alibaba/eni_vdpa.c
>>>>> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
>>>>> @@ -58,7 +58,7 @@ static struct virtio_pci_legacy_device *vdpa_to_ldev(struct vdpa_device *vdpa)
>>>>>     	return &eni_vdpa->ldev;
>>>>>     }
>>>>> -static u64 eni_vdpa_get_features(struct vdpa_device *vdpa)
>>>>> +static u64 eni_vdpa_get_device_features(struct vdpa_device *vdpa)
>>>>>     {
>>>>>     	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
>>>>>     	u64 features = vp_legacy_get_features(ldev);
>>>>> @@ -69,7 +69,7 @@ static u64 eni_vdpa_get_features(struct vdpa_device *vdpa)
>>>>>     	return features;
>>>>>     }
>>>>> -static int eni_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
>>>>> +static int eni_vdpa_set_driver_features(struct vdpa_device *vdpa, u64 features)
>>>>>     {
>>>>>     	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
>>>>> @@ -84,6 +84,13 @@ static int eni_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
>>>>>     	return 0;
>>>>>     }
>>>>> +static u64 eni_vdpa_get_driver_features(struct vdpa_device *vdpa)
>>>>> +{
>>>>> +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
>>>>> +
>>>>> +	return vp_legacy_get_driver_features(ldev);
>>>>> +}
>>>>> +
>>>>>     static u8 eni_vdpa_get_status(struct vdpa_device *vdpa)
>>>>>     {
>>>>>     	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
>>>>> @@ -401,8 +408,9 @@ static void eni_vdpa_set_config_cb(struct vdpa_device *vdpa,
>>>>>     }
>>>>>     static const struct vdpa_config_ops eni_vdpa_ops = {
>>>>> -	.get_features	= eni_vdpa_get_features,
>>>>> -	.set_features	= eni_vdpa_set_features,
>>>>> +	.get_device_features = eni_vdpa_get_device_features,
>>>>> +	.set_driver_features = eni_vdpa_set_driver_features,
>>>>> +	.get_driver_features = eni_vdpa_get_driver_features,
>>>>>     	.get_status	= eni_vdpa_get_status,
>>>>>     	.set_status	= eni_vdpa_set_status,
>>>>>     	.reset		= eni_vdpa_reset,
>>>>> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
>>>>> index 6dc75ca70b37..6a6a0a462392 100644
>>>>> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
>>>>> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>>>>> @@ -169,7 +169,7 @@ static struct ifcvf_hw *vdpa_to_vf(struct vdpa_device *vdpa_dev)
>>>>>     	return &adapter->vf;
>>>>>     }
>>>>> -static u64 ifcvf_vdpa_get_features(struct vdpa_device *vdpa_dev)
>>>>> +static u64 ifcvf_vdpa_get_device_features(struct vdpa_device *vdpa_dev)
>>>>>     {
>>>>>     	struct ifcvf_adapter *adapter = vdpa_to_adapter(vdpa_dev);
>>>>>     	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
>>>>> @@ -187,7 +187,7 @@ static u64 ifcvf_vdpa_get_features(struct vdpa_device *vdpa_dev)
>>>>>     	return features;
>>>>>     }
>>>>> -static int ifcvf_vdpa_set_features(struct vdpa_device *vdpa_dev, u64 features)
>>>>> +static int ifcvf_vdpa_set_driver_features(struct vdpa_device *vdpa_dev, u64 features)
>>>>>     {
>>>>>     	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
>>>>>     	int ret;
>>>>> @@ -201,6 +201,13 @@ static int ifcvf_vdpa_set_features(struct vdpa_device *vdpa_dev, u64 features)
>>>>>     	return 0;
>>>>>     }
>>>>> +static u64 ifcvf_vdpa_get_driver_features(struct vdpa_device *vdpa_dev)
>>>>> +{
>>>>> +	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
>>>>> +
>>>>> +	return vf->req_features;
>>>>> +}
>>>>> +
>>>>>     static u8 ifcvf_vdpa_get_status(struct vdpa_device *vdpa_dev)
>>>>>     {
>>>>>     	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
>>>>> @@ -443,8 +450,9 @@ static struct vdpa_notification_area ifcvf_get_vq_notification(struct vdpa_devic
>>>>>      * implemented set_map()/dma_map()/dma_unmap()
>>>>>      */
>>>>>     static const struct vdpa_config_ops ifc_vdpa_ops = {
>>>>> -	.get_features	= ifcvf_vdpa_get_features,
>>>>> -	.set_features	= ifcvf_vdpa_set_features,
>>>>> +	.get_device_features = ifcvf_vdpa_get_device_features,
>>>>> +	.set_driver_features = ifcvf_vdpa_set_driver_features,
>>>>> +	.get_driver_features = ifcvf_vdpa_get_driver_features,
>>>>>     	.get_status	= ifcvf_vdpa_get_status,
>>>>>     	.set_status	= ifcvf_vdpa_set_status,
>>>>>     	.reset		= ifcvf_vdpa_reset,
>>>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>>> index 63813fbb5f62..ce2e13135dd8 100644
>>>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>>> @@ -1880,7 +1880,7 @@ static u64 mlx_to_vritio_features(u16 dev_features)
>>>>>     	return result;
>>>>>     }
>>>>> -static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
>>>>> +static u64 mlx5_vdpa_get_device_features(struct vdpa_device *vdev)
>>>>>     {
>>>>>     	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>>>>     	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>>>>> @@ -1972,7 +1972,7 @@ static void update_cvq_info(struct mlx5_vdpa_dev *mvdev)
>>>>>     	}
>>>>>     }
>>>>> -static int mlx5_vdpa_set_features(struct vdpa_device *vdev, u64 features)
>>>>> +static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
>>>>>     {
>>>>>     	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>>>>     	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>>>>> @@ -2339,6 +2339,13 @@ static int mlx5_get_vq_irq(struct vdpa_device *vdv, u16 idx)
>>>>>     	return -EOPNOTSUPP;
>>>>>     }
>>>>> +static u64 mlx5_vdpa_get_driver_features(struct vdpa_device *vdev)
>>>>> +{
>>>>> +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>>>> +
>>>>> +	return mvdev->actual_features;
>>>>> +}
>>>>> +
>>>>>     static const struct vdpa_config_ops mlx5_vdpa_ops = {
>>>>>     	.set_vq_address = mlx5_vdpa_set_vq_address,
>>>>>     	.set_vq_num = mlx5_vdpa_set_vq_num,
>>>>> @@ -2351,8 +2358,9 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
>>>>>     	.get_vq_notification = mlx5_get_vq_notification,
>>>>>     	.get_vq_irq = mlx5_get_vq_irq,
>>>>>     	.get_vq_align = mlx5_vdpa_get_vq_align,
>>>>> -	.get_features = mlx5_vdpa_get_features,
>>>>> -	.set_features = mlx5_vdpa_set_features,
>>>>> +	.get_device_features = mlx5_vdpa_get_device_features,
>>>>> +	.set_driver_features = mlx5_vdpa_set_driver_features,
>>>>> +	.get_driver_features = mlx5_vdpa_get_driver_features,
>>>>>     	.set_config_cb = mlx5_vdpa_set_config_cb,
>>>>>     	.get_vq_num_max = mlx5_vdpa_get_vq_num_max,
>>>>>     	.get_device_id = mlx5_vdpa_get_device_id,
>>>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>>>> index 7332a74a4b00..c37d384c0f33 100644
>>>>> --- a/drivers/vdpa/vdpa.c
>>>>> +++ b/drivers/vdpa/vdpa.c
>>>>> @@ -733,7 +733,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>>>>>     	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
>>>>>     		return -EMSGSIZE;
>>>>> -	features = vdev->config->get_features(vdev);
>>>>> +	features = vdev->config->get_driver_features(vdev);
>>>>>     	return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
>>>>>     }
>>>>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>>>> index 41b0cd17fcba..ddbe142af09a 100644
>>>>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>>>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>>>> @@ -399,14 +399,14 @@ static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
>>>>>     	return VDPASIM_QUEUE_ALIGN;
>>>>>     }
>>>>> -static u64 vdpasim_get_features(struct vdpa_device *vdpa)
>>>>> +static u64 vdpasim_get_device_features(struct vdpa_device *vdpa)
>>>>>     {
>>>>>     	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>>>>>     	return vdpasim->dev_attr.supported_features;
>>>>>     }
>>>>> -static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
>>>>> +static int vdpasim_set_driver_features(struct vdpa_device *vdpa, u64 features)
>>>>>     {
>>>>>     	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>>>>> @@ -419,6 +419,13 @@ static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
>>>>>     	return 0;
>>>>>     }
>>>>> +static u64 vdpasim_get_driver_features(struct vdpa_device *vdpa)
>>>>> +{
>>>>> +	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>>>>> +
>>>>> +	return vdpasim->features;
>>>>> +}
>>>>> +
>>>>>     static void vdpasim_set_config_cb(struct vdpa_device *vdpa,
>>>>>     				  struct vdpa_callback *cb)
>>>>>     {
>>>>> @@ -613,8 +620,9 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
>>>>>     	.set_vq_state           = vdpasim_set_vq_state,
>>>>>     	.get_vq_state           = vdpasim_get_vq_state,
>>>>>     	.get_vq_align           = vdpasim_get_vq_align,
>>>>> -	.get_features           = vdpasim_get_features,
>>>>> -	.set_features           = vdpasim_set_features,
>>>>> +	.get_device_features    = vdpasim_get_device_features,
>>>>> +	.set_driver_features    = vdpasim_set_driver_features,
>>>>> +	.get_driver_features    = vdpasim_get_driver_features,
>>>>>     	.set_config_cb          = vdpasim_set_config_cb,
>>>>>     	.get_vq_num_max         = vdpasim_get_vq_num_max,
>>>>>     	.get_device_id          = vdpasim_get_device_id,
>>>>> @@ -642,8 +650,9 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
>>>>>     	.set_vq_state           = vdpasim_set_vq_state,
>>>>>     	.get_vq_state           = vdpasim_get_vq_state,
>>>>>     	.get_vq_align           = vdpasim_get_vq_align,
>>>>> -	.get_features           = vdpasim_get_features,
>>>>> -	.set_features           = vdpasim_set_features,
>>>>> +	.get_device_features    = vdpasim_get_device_features,
>>>>> +	.set_driver_features    = vdpasim_set_driver_features,
>>>>> +	.get_driver_features    = vdpasim_get_driver_features,
>>>>>     	.set_config_cb          = vdpasim_set_config_cb,
>>>>>     	.get_vq_num_max         = vdpasim_get_vq_num_max,
>>>>>     	.get_device_id          = vdpasim_get_device_id,
>>>>> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
>>>>> index c9204c62f339..1e65af6ab9ae 100644
>>>>> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
>>>>> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
>>>>> @@ -573,14 +573,14 @@ static u32 vduse_vdpa_get_vq_align(struct vdpa_device *vdpa)
>>>>>     	return dev->vq_align;
>>>>>     }
>>>>> -static u64 vduse_vdpa_get_features(struct vdpa_device *vdpa)
>>>>> +static u64 vduse_vdpa_get_device_features(struct vdpa_device *vdpa)
>>>>>     {
>>>>>     	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
>>>>>     	return dev->device_features;
>>>>>     }
>>>>> -static int vduse_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
>>>>> +static int vduse_vdpa_set_driver_features(struct vdpa_device *vdpa, u64 features)
>>>>>     {
>>>>>     	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
>>>>> @@ -588,6 +588,13 @@ static int vduse_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
>>>>>     	return 0;
>>>>>     }
>>>>> +static u64 vduse_vdpa_get_driver_features(struct vdpa_device *vdpa)
>>>>> +{
>>>>> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
>>>>> +
>>>>> +	return dev->driver_features;
>>>>> +}
>>>>> +
>>>>>     static void vduse_vdpa_set_config_cb(struct vdpa_device *vdpa,
>>>>>     				  struct vdpa_callback *cb)
>>>>>     {
>>>>> @@ -720,8 +727,9 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
>>>>>     	.set_vq_state		= vduse_vdpa_set_vq_state,
>>>>>     	.get_vq_state		= vduse_vdpa_get_vq_state,
>>>>>     	.get_vq_align		= vduse_vdpa_get_vq_align,
>>>>> -	.get_features		= vduse_vdpa_get_features,
>>>>> -	.set_features		= vduse_vdpa_set_features,
>>>>> +	.get_device_features	= vduse_vdpa_get_device_features,
>>>>> +	.set_driver_features	= vduse_vdpa_set_driver_features,
>>>>> +	.get_driver_features	= vduse_vdpa_get_driver_features,
>>>>>     	.set_config_cb		= vduse_vdpa_set_config_cb,
>>>>>     	.get_vq_num_max		= vduse_vdpa_get_vq_num_max,
>>>>>     	.get_device_id		= vduse_vdpa_get_device_id,
>>>>> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
>>>>> index e3ff7875e123..97285bc05e47 100644
>>>>> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
>>>>> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
>>>>> @@ -53,14 +53,14 @@ static struct virtio_pci_modern_device *vdpa_to_mdev(struct vdpa_device *vdpa)
>>>>>     	return &vp_vdpa->mdev;
>>>>>     }
>>>>> -static u64 vp_vdpa_get_features(struct vdpa_device *vdpa)
>>>>> +static u64 vp_vdpa_get_device_features(struct vdpa_device *vdpa)
>>>>>     {
>>>>>     	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
>>>>>     	return vp_modern_get_features(mdev);
>>>>>     }
>>>>> -static int vp_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
>>>>> +static int vp_vdpa_set_driver_features(struct vdpa_device *vdpa, u64 features)
>>>>>     {
>>>>>     	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
>>>>> @@ -69,6 +69,13 @@ static int vp_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
>>>>>     	return 0;
>>>>>     }
>>>>> +static u64 vp_vdpa_get_driver_features(struct vdpa_device *vdpa)
>>>>> +{
>>>>> +	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
>>>>> +
>>>>> +	return vp_modern_get_features(mdev);
>>>>> +}
>>>>> +
>>>>>     static u8 vp_vdpa_get_status(struct vdpa_device *vdpa)
>>>>>     {
>>>>>     	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
>>>>> @@ -415,8 +422,9 @@ vp_vdpa_get_vq_notification(struct vdpa_device *vdpa, u16 qid)
>>>>>     }
>>>>>     static const struct vdpa_config_ops vp_vdpa_ops = {
>>>>> -	.get_features	= vp_vdpa_get_features,
>>>>> -	.set_features	= vp_vdpa_set_features,
>>>>> +	.get_device_features = vp_vdpa_get_device_features,
>>>>> +	.set_driver_features = vp_vdpa_set_driver_features,
>>>>> +	.get_driver_features = vp_vdpa_get_driver_features,
>>>>>     	.get_status	= vp_vdpa_get_status,
>>>>>     	.set_status	= vp_vdpa_set_status,
>>>>>     	.reset		= vp_vdpa_reset,
>>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>>>> index 29cced1cd277..6d087a4fb581 100644
>>>>> --- a/drivers/vhost/vdpa.c
>>>>> +++ b/drivers/vhost/vdpa.c
>>>>> @@ -262,7 +262,7 @@ static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
>>>>>     	const struct vdpa_config_ops *ops = vdpa->config;
>>>>>     	u64 features;
>>>>> -	features = ops->get_features(vdpa);
>>>>> +	features = ops->get_device_features(vdpa);
>>>>>     	if (copy_to_user(featurep, &features, sizeof(features)))
>>>>>     		return -EFAULT;
>>>>> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
>>>>> index f85f860bc10b..a84b04ba3195 100644
>>>>> --- a/drivers/virtio/virtio_vdpa.c
>>>>> +++ b/drivers/virtio/virtio_vdpa.c
>>>>> @@ -308,7 +308,7 @@ static u64 virtio_vdpa_get_features(struct virtio_device *vdev)
>>>>>     	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
>>>>>     	const struct vdpa_config_ops *ops = vdpa->config;
>>>>> -	return ops->get_features(vdpa);
>>>>> +	return ops->get_device_features(vdpa);
>>>>>     }
>>>>>     static int virtio_vdpa_finalize_features(struct virtio_device *vdev)
>>>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>>>>> index c3011ccda430..db24317d61b6 100644
>>>>> --- a/include/linux/vdpa.h
>>>>> +++ b/include/linux/vdpa.h
>>>>> @@ -169,14 +169,17 @@ struct vdpa_map_file {
>>>>>      *				for the device
>>>>>      *				@vdev: vdpa device
>>>>>      *				Returns virtqueue algin requirement
>>>>> - * @get_features:		Get virtio features supported by the device
>>>>> + * @get_device_features:	Get virtio features supported by the device
>>>>>      *				@vdev: vdpa device
>>>>>      *				Returns the virtio features support by the
>>>>>      *				device
>>>>> - * @set_features:		Set virtio features supported by the driver
>>>>> + * @set_driver_features:	Set virtio features supported by the driver
>>>>>      *				@vdev: vdpa device
>>>>>      *				@features: feature support by the driver
>>>>>      *				Returns integer: success (0) or error (< 0)
>>>>> + * @get_driver_features:	Get virtio features in action
>>>>> + *				@vdev: vdpa device
>>>>> + *				Returns the virtio features accepted
>>>>>      * @set_config_cb:		Set the config interrupt callback
>>>>>      *				@vdev: vdpa device
>>>>>      *				@cb: virtio-vdev interrupt callback structure
>>>>> @@ -276,8 +279,9 @@ struct vdpa_config_ops {
>>>>>     	/* Device ops */
>>>>>     	u32 (*get_vq_align)(struct vdpa_device *vdev);
>>>>> -	u64 (*get_features)(struct vdpa_device *vdev);
>>>>> -	int (*set_features)(struct vdpa_device *vdev, u64 features);
>>>>> +	u64 (*get_device_features)(struct vdpa_device *vdev);
>>>>> +	int (*set_driver_features)(struct vdpa_device *vdev, u64 features);
>>>>> +	u64 (*get_driver_features)(struct vdpa_device *vdev);
>>>>>     	void (*set_config_cb)(struct vdpa_device *vdev,
>>>>>     			      struct vdpa_callback *cb);
>>>>>     	u16 (*get_vq_num_max)(struct vdpa_device *vdev);
>>>>> @@ -395,7 +399,7 @@ static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
>>>>>     	const struct vdpa_config_ops *ops = vdev->config;
>>>>>     	vdev->features_valid = true;
>>>>> -	return ops->set_features(vdev, features);
>>>>> +	return ops->set_driver_features(vdev, features);
>>>>>     }
>>>>>     void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
