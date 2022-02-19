Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F69EC433F5
	for <virtualization@archiver.kernel.org>; Sat, 19 Feb 2022 00:34:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3AB0E607F6;
	Sat, 19 Feb 2022 00:34:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aT3A5dh9Vf3g; Sat, 19 Feb 2022 00:34:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C04F460A92;
	Sat, 19 Feb 2022 00:34:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 539D8C0021;
	Sat, 19 Feb 2022 00:34:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78791C000B
 for <virtualization@lists.linux-foundation.org>;
 Sat, 19 Feb 2022 00:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 52E3483EB7
 for <virtualization@lists.linux-foundation.org>;
 Sat, 19 Feb 2022 00:34:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="ZDU0m2Fq";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="a0apo1GH"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iXW75nov1wqz
 for <virtualization@lists.linux-foundation.org>;
 Sat, 19 Feb 2022 00:34:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EFB4681254
 for <virtualization@lists.linux-foundation.org>;
 Sat, 19 Feb 2022 00:34:26 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21INDJSu031982; 
 Sat, 19 Feb 2022 00:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WhMEbR2nenhLIvvABd1N8sWRsuMOSarzox4ZJr5dFj8=;
 b=ZDU0m2FqjwUIkDi/H/Bc5CqgmlbydlsvVtUMvlVD5u+x415CDRlsdeI1M7Raxxs6FEgo
 QWwk9rL0j2GMb1sta58+GJ3R+qIMwMVXt5IPVWBa/wLG3lH7Z5nf+YR9ObdUEAED8+ti
 74qx+1n+QMYDF4qF3KsP7xyqkOtbuNHv4EINvCJRvVYHL1vIeo5OzeuXS1tssX6zUPzM
 8UfbEGpJe0PXEiGAv7y9edhqcZBpbe329dDepeiLYVN6mSdmMToY2nGAJEaFh7NCPEoM
 XMDOhtczMqhs8QodXZoulbbxwxOD/Qs/bDV1Xx6jqo1gkYU4j1QjTjBIk8MIjTpd6lai ZA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3e8n3fj8cu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 19 Feb 2022 00:34:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21J0GGLA010586;
 Sat, 19 Feb 2022 00:34:11 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
 by aserp3020.oracle.com with ESMTP id 3e8nvvyxn3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 19 Feb 2022 00:34:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdcjDjvzfdLpmNqEHJD9j9BYDcwHBnbqOkCHzhicOZrmzBwAFpLI6vAuasPMiVd1sABo143Wvd9X6ONiMMovw0GR8gT9bqrIEjqD2KRM1oNfavJEuC1WUSw1QdGDLt10Wdbsavwd5mdvX9gBDr8j7wykEpuQgUOs/SWHOAQJKGVSDnHH+hUhHRg1Hw+UJeQ1tHN1O50xE4S477E2FiS6PA4f+hcPWOL+2gn+HT8uFJNsoRBAiilntcZ2QDVV7K4yT08gXhEbH7Y1zI8aS/HxbdkJrS5KK+S0TwuDNKKJUbIEQB7MEG98FugpTHAi2rdht7RveR+RHaeVrRT4hQk6Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhMEbR2nenhLIvvABd1N8sWRsuMOSarzox4ZJr5dFj8=;
 b=C7LuqnLk2nXE9hmIyYjxhKqKCMznq3IC+AWbYZenZ301tnbKaeILgQKkHsqqCSUVkQKsHPObnxJq5jd2DGBQQCUP5NDynMK5zT6AbMJM2GzinLmXV3Y4iB6s7F/Pxd+yNoUX9tHgpK0L61cN4cOnZCbSelIHJ9zqzwRU+lKiJ1oUOlM6spHFzmN34zBOC3cxVgJFn5mYfWgT9Duj9Xk2pBxMiVUmECnDZjc120GKQCkeG2sKaWrKeCXYZTnEP4y1BuwyYV09N7+ee+pm5MD8Zh0THX9U8TAzPePZknNdVlq15JJkGWGvuIHO0TqE4XL/4Ra6xfxS2q76OyeRq1o0gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhMEbR2nenhLIvvABd1N8sWRsuMOSarzox4ZJr5dFj8=;
 b=a0apo1GHP0JdRMm8tJikk1wkjuX3FzNrZOH1sZlkeEwDxUVfMWGOo969iy2YVa1v35SgeANvekRz80ZJUczCXvaBmA1bgSsWv3IrwqE+UxTy33F/JFUQxjy6LERlgxOwxGA9A688GT12eQeBVGbRPSpjlmCVyw2YXlW/Sk6pKNg=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by DM5PR10MB1468.namprd10.prod.outlook.com (2603:10b6:3:c::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.17; Sat, 19 Feb 2022 00:34:09 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::54c5:b7e1:92a:60dd]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::54c5:b7e1:92a:60dd%6]) with mapi id 15.20.4995.016; Sat, 19 Feb 2022
 00:34:09 +0000
Message-ID: <0ed99d13-3aa0-59c6-0e1f-e8e9803f84d1@oracle.com>
Date: Fri, 18 Feb 2022 16:34:04 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] net/mlx5: Add support for configuring max device MTU
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>
References: <20220216113318.74218-1-elic@nvidia.com>
 <9d48a945-612c-2fb5-d0d4-3752fead7f78@oracle.com>
 <20220217062008.GA86497@mtl-vdi-166.wap.labs.mlnx>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220217062008.GA86497@mtl-vdi-166.wap.labs.mlnx>
X-ClientProxiedBy: BY5PR17CA0030.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::43) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 658186e9-0900-4866-e447-08d9f33f8aef
X-MS-TrafficTypeDiagnostic: DM5PR10MB1468:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1468DC6762F77B631AB47105B1389@DM5PR10MB1468.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FovLHOLitfinBImmQRrIa2ZZ6KpslgxYvnj+dWKBqxgIM3WXzIso8h0Oh8KC5tt3ACcx2cql+poLsn6x9x1uSvStRQuvy3vBHcHIvLL9QRgpcs5FtPoCIr6ijIoXi/IQ/0mS9e9XLTESfRJXuP+KeIdGJU9zPb3Infw4USRK3PpDs90pMFWWyDni55Xbp05B8Cin3Y5VpYyLGFVrthtKBM8XoqCKBqbvCJB+3FZ1q6B2E4BInjG9+CoIJP3VALWTz8+jjd1iPI+OXJ6vbPGR7axJmbI6AVQlWOI1hS+pmW5chw9MdJ/oG2BmlyEj3nuwJ4hfNiaMjviNi+W//dQNgnl75dgEJGyEYRhN3VXEIn1CGTQr9X+rcChu6cx8zQw3G78hk/NvxSUVa9cUOu+mKPnrhjXgtC4VzJdYqmhV6G0/Y81AoVm8io6cu+/CzTh8RftDXYB0G+xlPsKsuQcLA9/ws5VD0ldM31lQgdgLZ+5pmkVTvicyXGoCtFdcsf0RmXxzBC1Lhk/LfnJWRww6UGsQZWiTp4lgMqs0EQ20OOuLoQfwIV4G5HWLL5EF9s/gT6LOPJ6kTBFeI3bEHJ8Ks5dH41pQbpEIngymRQHo/ciulNdSmK6kpeC8cFX5a5RkjEISWhaXLLykuQKIoXVVerUP9HE+ZElz2D/44ZW3uhB56Hots9k5RmupcvG4wT/AMgFiPhm1WKfsYDX96E271H7lWapTI4Cd7rzIF+pl4/0RRaARAWI0Za1j130/s/xR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(2906002)(6512007)(6916009)(31686004)(36756003)(6486002)(66946007)(508600001)(4326008)(66556008)(66476007)(8676002)(26005)(6506007)(31696002)(36916002)(316002)(5660300002)(53546011)(6666004)(8936002)(86362001)(186003)(83380400001)(2616005)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aml2bDlLU0dETUNGMVVuUE52SUEvQXVvb2xmSE1EU2E4UXFJSVZxR0l5SGN1?=
 =?utf-8?B?ZzFISEVYd090WkVUVlkrRVYrT1dtKzYwc1U3azdHd0Q2RFE5Q3ZTSGdRSXZ0?=
 =?utf-8?B?a0UrUUthV1dFaE1aRmhTRnRab1JBVFZNb0ZyRzR0V0ppVkJaa1R3NWxEdUlG?=
 =?utf-8?B?QmpRMWdiajZJWXd4Y3dRZlNjM0lxTU8xaFBkbzRmRGJSOHJ6eGVvSDhCZ3Nm?=
 =?utf-8?B?aHBzWTZWR3hVUFplRE90NDZueGd2VlBkcXBYdGN6T09tSWtuc3NTU2V2SlNx?=
 =?utf-8?B?ditUc1g5N3NzakwwaDVMbEt6SzBNZlhLemx4Q01OQkRsTjBiK0h3T0NSMG5h?=
 =?utf-8?B?QklYMVlyU2dGMDNyRktxeGZKYlRpRmNmMTEyNHJ0Q2p1emRnQnlIb3VScUI5?=
 =?utf-8?B?dGcwZFY2akpRdUFpY2Y0MS9kYVpaY2MwVFpWMjZCQ1ZPTjAzVmNYWUR2d1JR?=
 =?utf-8?B?VFdWUVhUN05wcC93NVBvc1kwNzErWTJpVElDVjhHYWMweEU2aGxvdXdQdXY5?=
 =?utf-8?B?VXk3TWpLQmRnYVhpYzdlY3hCdlA3NlVBNTJZYld5Vk5rNHpzS2hhS0lnbytB?=
 =?utf-8?B?WWZ0WjlLNkRwNjRCNzgxRmYwcW83S1o5ZU9mY3NHZW9rcWlkWDJueXk1UmZo?=
 =?utf-8?B?Z0IybEZIajNSMzlPRGJmMTQ0YzI0SVUzTzE1eGNKdElTSisyZkx0VmloeUJH?=
 =?utf-8?B?cjhMMlR6b0ptL0ptR051ZUtDMFRDL0VDQVAycFNVbWYwSm9jaHBnSDlONlVU?=
 =?utf-8?B?cnlIamtGUVdxaTB1THB4dkhoOTFtNXl1UkxLMTVWd1ZQYUIwWWIzQkM0dTcw?=
 =?utf-8?B?aC84NjYydFFLcUNGTDNvUzRQM0RTVEdqb3R3NEw2cllmaXh0dWcwaFI1bkdK?=
 =?utf-8?B?Q0czZElRNkJielZBQ0x1N3RqTjJ4dTcvME8rUTRKdUZzdlJrNXRYQnVrclJX?=
 =?utf-8?B?c053OHVwQUcrUnR6T2orVVkrOURmb3RXQ3lqLzhXMUd3RkpPbjhFcHRBMXZD?=
 =?utf-8?B?MW1wM3J5alJld0hoM2hMSnV1b0NPdlV5Wi9NU0o0U0EvSEtuM2xRV3d6c3pZ?=
 =?utf-8?B?a2RjeW5GTVVic0ZTMUd1VHZEWjZnT0dZZ3Y3Qk55N1VKdTNYMENZT3VJRm9Y?=
 =?utf-8?B?aUhEWkE0RFlwanFCOUtNb0J2V1FpK2JkZUNDc2lNeUszYlE3MStCYVdBODJG?=
 =?utf-8?B?QVYxdCtSOHNGY1h3ZHJ1STljUEZZU1ZwY0I5M055VU9KbEVSWmprTmNWamN6?=
 =?utf-8?B?bjVIT1kxNG1VV3ZRTXZNbTNaTWVsQXdEWC9oUDZzZjV5b01wZ3lKN2hOc3oy?=
 =?utf-8?B?VDA2TjdMTmhtQ2J5ZnRKUlhOVmhtZlM5MUR2cFRsSlFsdFY5b3BQL01LZGNw?=
 =?utf-8?B?dFViSks5RENYa2pKa2tONkk0ZXJnc1hHUUNtZGEvaERtSGtFa3ZXemhlUnBq?=
 =?utf-8?B?clZ0c2hwU0ZId2l6eUMvVUpvWmR5UzB2dDBHd0t1WDBzeDlYUlNiU2VkV2xW?=
 =?utf-8?B?eWhxZFFTQThUeFlSR0JVTkpYL3BlTFNmcVlwUlk2bmFtYkVZYUlsUzArMzZ3?=
 =?utf-8?B?MGJFMzNxaTcxN3lpTVR0OFhmVVRRbGNERzMzbXFWUk03UHNxRGJ4ZXpSb1RR?=
 =?utf-8?B?WTcvU25QRkZFQzB0bUJBZk9HSHhwbldiZDhaN1JXTHhtWE9XOWlDbEdON1dM?=
 =?utf-8?B?OVFYYWF4bEpYNzllNkh3TkhuYTBaWkJ3RUludmtycWxpUWRqRHY5eVVQUDVT?=
 =?utf-8?B?YUVEekt3L1FRRDU1TllBaGY5S3B6YXJ5Q3hicGQybjhBQTEzRjRCa2F4YUVy?=
 =?utf-8?B?OFFHR0JnWDY4aThZYTdBMFBUb2xRemlCQi9hRjBmY0ZVZEVsQkFZUjkxcmRS?=
 =?utf-8?B?ZldtMW4yRk1wQ0d6MTJTSnJnS211ekttWGo5dVhJSnEvUWJyWU05NU5Ubyty?=
 =?utf-8?B?cUZyWnkrZkQ4d2RTc0laMHkzRkFIMHJsWURIa2Y5ejRQRGxNTU0wQ1d6WnpI?=
 =?utf-8?B?VlUyM1VOVG9qRHhaQ3hZdXZ2UVg4cTYyajlvVDdJWFYrcXEwRThLRUlqWnFm?=
 =?utf-8?B?dHFEUUM0T1RiUjk3TVZOUCtwQWNKUkdtT25zRFdZcEVRa2pmeEx1NEVqWEpV?=
 =?utf-8?B?ZE8zSDdaZXlrWUlQQllISlhtRndKK0N5ZHE1U2F6MTRyQVZwdE1jSXl6bEd5?=
 =?utf-8?Q?9J9bIuCr1odSDYkOLqOHeM4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658186e9-0900-4866-e447-08d9f33f8aef
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 00:34:09.0977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ba2vbFNrY7s+Ceu0dM9vU7vsV9LvZ4XYFE3eaRzhnv9LiQ373qiXCSETwvCvBDiZh1k2T2Hq9XIYO81TSijGsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1468
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10262
 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202190000
X-Proofpoint-GUID: EU275L0q5WLCSm_Q2Uk1oFnqWx5CSjfk
X-Proofpoint-ORIG-GUID: EU275L0q5WLCSm_Q2Uk1oFnqWx5CSjfk
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



On 2/16/2022 10:20 PM, Eli Cohen wrote:
> On Wed, Feb 16, 2022 at 10:19:52AM -0800, Si-Wei Liu wrote:
>>
>> On 2/16/2022 3:33 AM, Eli Cohen wrote:
>>> Allow an admin creating a vdpa device to specify the max MTU for the
>>> net device.
>>>
>>> For example, to create a device with max MTU of 1000, the following
>>> command can be used:
>>>
>>> $ vdpa dev add name vdpa-a mgmtdev auxiliary/mlx5_core.sf.1 mtu 1000
>>>
>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>> ---
>>>    drivers/vdpa/mlx5/net/mlx5_vnet.c | 32 ++++++++++++++++++++++++++++++-
>>>    1 file changed, 31 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> index 6156cf6e9377..be095dc1134e 100644
>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> @@ -2689,6 +2689,28 @@ static int event_handler(struct notifier_block *nb, unsigned long event, void *p
>>>    	return ret;
>>>    }
>>> +static int config_func_mtu(struct mlx5_core_dev *mdev, u16 mtu)
>>> +{
>>> +	int inlen = MLX5_ST_SZ_BYTES(modify_nic_vport_context_in);
>>> +	void *in;
>>> +	int err;
>>> +
>>> +	in = kvzalloc(inlen, GFP_KERNEL);
>>> +	if (!in)
>>> +		return -ENOMEM;
>>> +
>>> +	MLX5_SET(modify_nic_vport_context_in, in, field_select.mtu, 1);
>>> +	MLX5_SET(modify_nic_vport_context_in, in, nic_vport_context.mtu,
>>> +		 mtu + MLX5V_ETH_HARD_MTU);
>>> +	MLX5_SET(modify_nic_vport_context_in, in, opcode,
>>> +		 MLX5_CMD_OP_MODIFY_NIC_VPORT_CONTEXT);
>>> +
>>> +	err = mlx5_cmd_exec_in(mdev, modify_nic_vport_context, in);
>>> +
>>> +	kvfree(in);
>>> +	return err;
>>> +}
>>> +
>>>    static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>>    			     const struct vdpa_dev_set_config *add_config)
>>>    {
>>> @@ -2749,6 +2771,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>>    	mutex_init(&ndev->reslock);
>>>    	mutex_init(&ndev->numq_lock);
>>>    	config = &ndev->config;
>>> +
>>> +	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
>>> +		err = config_func_mtu(mdev, add_config->net.mtu);
>>> +		if (err)
>>> +			goto err_mtu;
>>> +	}
>>> +
>> The code change here looks fine. Maybe not this patch, does this vDPA MTU
>> option assume the exclusive use of parent SF device? I wonder if worth
>> restoring the MTU upon any subsequent failure in this function, could the
>> updated MTU value affect other SF children (e.g. Ethernet netdev, rdma), as
>> vport's context has changed but the MTU change is not notified to other
>> sibling drivers?
> We assume that if mlx5_vdpa is using the function it is the only real
> user of the function. e.g. the mlx5_core net device is still there but
> should not be used.
Could you capture this assumption in the commit log? Otherwise you can add

Reviewed-by: Si-Wei Liu<si-wei.liu@oracle.com>


Thanks,
-Siwei


>> -Siwei
>>
>>>    	err = query_mtu(mdev, &mtu);
>>>    	if (err)
>>>    		goto err_mtu;
>>> @@ -2867,7 +2896,8 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>>>    	mgtdev->mgtdev.device = mdev->device;
>>>    	mgtdev->mgtdev.id_table = id_table;
>>>    	mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR) |
>>> -					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
>>> +					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP) |
>>> +					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU);
>>>    	mgtdev->mgtdev.max_supported_vqs =
>>>    		MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues) + 1;
>>>    	mgtdev->mgtdev.supported_features = get_supported_features(mdev);

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
