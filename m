Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6ABC433EF
	for <virtualization@archiver.kernel.org>; Wed, 22 Dec 2021 19:25:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9AE160AAF;
	Wed, 22 Dec 2021 19:25:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NLPk5KKyoI-D; Wed, 22 Dec 2021 19:25:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5736060AB2;
	Wed, 22 Dec 2021 19:25:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14358C001E;
	Wed, 22 Dec 2021 19:25:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83A94C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 19:25:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6FA5A404CF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 19:25:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="g6hqVo57";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="zj7/5QsH"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ggVISN_vAPWT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 19:25:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 275E3400CE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 19:25:23 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BMIKEr0024169; 
 Wed, 22 Dec 2021 19:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=m3fUtxGrc8K8V3q+xPXpubHKNK2Ysy4nlv7ocZVUWZ4=;
 b=g6hqVo57Vx/+q7tDsD3K5iU44Z+2kYvuakQtlvYY+ouwgDyqKRvz2bGA5GwtkGeOqkrt
 gIVIgVk3l7iw3MHarh1IvGb0n5wOGcY2uo6tIo0xbNxn1okqKIvOIoeA+A82phpuccwd
 pkd2OY80Tn7ozxs1HuaoULJhwq1xuC+jWIlLFbimPlLQ0TsWcI1aU1WE/yHwpygmEXVo
 8vTb79Ejb4A0oarbuFdVPVfWlDaUbe0crWm5UefuFUcGZULr65ZuubGuEpe8kDojpC6T
 hPFEK1mZDsl9TBgbiDDmmwCix3YNF1oTLjshpN/5UJb7+y7t3Cf8xqunJYkzdenh09JA 4A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3d2udcev5a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 19:25:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BMJGvZc132267;
 Wed, 22 Dec 2021 19:25:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
 by aserp3020.oracle.com with ESMTP id 3d17f5qm3v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 19:25:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4qHGPruQp63c9ccIadt2+KnVL0fbuFkUDJcF8EK4EeDkkaKO+ymc9JJxMhCYHIoWY2Nps7MmQqY5qOrz4AH4XPa536k/IXr/eU5CDU8CZrIHhbxHCTE7tK9UruH5Dbu/Lyqu4An3RqTiQsv+vmBwKWBk6+S506DiZZn9jp99i4wmq1GHaQrcdWOKASFFsppxjGks2Ny/2VwzjbYAWm2QN7s3lmNBXmxctJ/2AxsyaaBAKkD1hFmW9lFZN6vNaDXuAgh2F6AJ3SBSGINFt4ksDRXfuteWo+BlQsaxWtTlxjVY1/xZ/B8XMcIRU73KlJ15A4LB8fArsQV8gLAXTKUow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3fUtxGrc8K8V3q+xPXpubHKNK2Ysy4nlv7ocZVUWZ4=;
 b=UZfQvM5YapwjqAJtV0045H5d+jussHZWBm0a2Kj/yhYYE7AjCn8hZ4ycDkKM+AqspWX+vw8pmuYpfGccbq0mEJENFGEBzJDE2lN4ykRY1bnBmkKr5AJ4Y1ktMxJNgO0Vqblk1I8ZZmPBoiS/M2XthoFFfEXMj5lCLBuikOmLrGB7ir3Aln/HU5+JippZ2pwDSVvZY7MimQjea0uiWLK9Xim77MDUf7b1w9ktxAg9w796HyiZwfTKhrlNAw4gL9tc+wW+2+zkKu19eUb4+WtxgNkwHImB7gu0qK+ZoWjZR+d5kHLKEg+K3Lf2UukdHMzOGVgLz5iX4JNr56iLN+rD4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3fUtxGrc8K8V3q+xPXpubHKNK2Ysy4nlv7ocZVUWZ4=;
 b=zj7/5QsHpQ2mqShtrqsUmSnaNKEs+W7HZ3nValR57Ms7OlI8bDcjZ8bypdTB8z6+iWTjWtKilpfKL9k8u9LPCzCGJt0D4lmTkTKDtLVZV3RGoIOftI7umigULN5BioudNUFRhoMK89wKewOop23OSmJwAt9af0re+aqNyvLERPY=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB5672.namprd10.prod.outlook.com (2603:10b6:a03:3ef::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 22 Dec
 2021 19:25:13 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4801.024; Wed, 22 Dec 2021
 19:25:13 +0000
Message-ID: <8e93cfc4-b71e-adc5-8b35-337523e3a431@oracle.com>
Date: Wed, 22 Dec 2021 11:25:07 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 10/13] vdpa: Support reporting max device virtqueues
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>
References: <20211221172006.43784-1-elic@nvidia.com>
 <20211221172006.43784-11-elic@nvidia.com>
 <e98dfbaf-8a2d-4cd6-c875-b4780137b0f8@oracle.com>
 <PH0PR12MB54816A7E1D045997B797961BDC7D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211222064728.GE210450@mtl-vdi-166.wap.labs.mlnx>
 <PH0PR12MB5481C33A91EAE3AADABA73E8DC7D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211222071036.GA213382@mtl-vdi-166.wap.labs.mlnx>
 <84292943-b4de-8162-1fde-fcfab479b629@oracle.com>
 <20211222075402.GA214545@mtl-vdi-166.wap.labs.mlnx>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211222075402.GA214545@mtl-vdi-166.wap.labs.mlnx>
X-ClientProxiedBy: BYAPR06CA0033.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::46) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccd9e83f-524c-43e7-a981-08d9c580c6dd
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5672:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5672DDBAE25D4A4198851661B17D9@SJ0PR10MB5672.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L9s2rbZwbxxviEtTjKvTXuOq8yqs+Mw4y/FHjGLTVUKkKdx6rmzWU52FUXt1ztCzP3RZeo+YlWt3wjAfJqbvymyYNL9YdDf5MXEEU6yFmX9iPPZqDfdcBz62wOIfLTWdOhKN+vt2rw74Ga842sbBK2hZEwyq7LoREgl9jhr4o3Qz4aP52op3V4giDaLoMPEw2SAv83Tb8gSMWvQ1kfBhFGwxwcpFaINkkPWgN83plHqc104sKxU8hTOsIQQ04g9F7Kl6ddBgDzXvI/ChVPvg9fyMKuZnogY20JNuTE6/Ym94KWk6/Ag8tOfzCp08s9rWeCA3AjcDIWrV7g8PGkxHCgXAPAWGLLpEjLY+IUN/SSQzI01OGJkXZfcScKNntoyx0h/qVQpNKsXXGpmLGyHOnv+Oct424cLrBn9wN1RyaXFKOAkilsEu1YJ6cED/syI9IDucALzIV1q+QPiPFvoXw7XNPBuBeWrbDBLEsSpLyI8iTJAlhD23S9cfVWcYhd7DAO0Ckb37W4feqraBCqJWzxI2XU3AmvliEGkm+oiPeCFKUPyY8y6eDoM+kn8zIHnWtMGw56SQXO1HoNejxl8tWd9F99iDF/KZBcebjtP28JmpOG6pjLmsAhHPYO/gQ0SnZFowBoFTn9J49Z1Ii5JA58Z7RrEZ49OS8ByEAkzUQ8myK1vDFsACmlbupjOi4isdYrDPB6cEQqQOq3RUQ4cXVmdcjqVCfYRWv1XQzxMiqHI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(6506007)(66476007)(6666004)(54906003)(2906002)(36916002)(31686004)(53546011)(8936002)(38100700002)(66946007)(83380400001)(31696002)(36756003)(8676002)(26005)(86362001)(5660300002)(6916009)(4326008)(6512007)(186003)(2616005)(6486002)(508600001)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXlvOFYweGVOZjlNMlhjVmVGM1RwMGloaWY5Vm9xVkVKRXRDSjVsbUNFRTda?=
 =?utf-8?B?UElZNmVPQWNHbjl5WkJCWHQrMmFveDM5TW0rcW5qMk0zVDNCN20rRFB1cWlp?=
 =?utf-8?B?ei96cHdXNDhqc2NCSVFyS29BdWUxU01TQ25jU3ZqazJHTEhDU1VTVE85cHVX?=
 =?utf-8?B?dVppOVV4eGhjVEV6SG9JeE5vbnJzUXVrdHB3WG5GUFZNN3BkNmZnOFZMaWxs?=
 =?utf-8?B?RFJxcml6YXpiS2Rlc3M5L1pZaE5qZXJsVHRRcWFVeVg2VjRNSUttWUhRdVE0?=
 =?utf-8?B?N1FSazk4M0hZRzhDQm9SRTI1NUVLNms2TU0xbytRVTN3NE1yTG9WTTFRaFBK?=
 =?utf-8?B?T3hvdnc0d1JDeHI3WUM4em9vTEM1SDFmQ1dGeUk3WW9QY3Z0REZvN0VYZ1F4?=
 =?utf-8?B?TGd2aHJFUm80VUpFWmp4OGJ0aWNBN0haRmp2WUdLeEVlQU9WcWdKc1NNeXNT?=
 =?utf-8?B?bUgzMUdRaWtCY0k1R1JvelYraVU4cHdaVk5IanBSenhvNHVCcXF1emthZm5T?=
 =?utf-8?B?UHF1cWFMaTl5NmlpTzBLOHN5TXhoV0JzdjVucDFXeGdhdVBsT21HUDgrNDJP?=
 =?utf-8?B?aHU3ejFvVWNsNmtKT05pdEhzSHl6cGRJcFdvcjdOUExXUm1mdElPdXlLNzlM?=
 =?utf-8?B?YXFQWUxKNTcvZlplYjRwV2N5WFRqRE1WL1NoWFZWeFFBTnBLVmE4dy8wbGJH?=
 =?utf-8?B?T21lTTFGSEhES09qODMxNzlCc0tTL1daQnBMSDgreW9NalMzaWZ2L2dUT2Zy?=
 =?utf-8?B?RUdjdE9IelRXU2lvazdxTXlaWGQwT1BEeGFLZFp5a3Qyb0RRK1lJSmJCZHZt?=
 =?utf-8?B?MjRSYlIvczJPdFZCclYvL0ZDYkhJTTFBdjhXdXpZTC95Q1V1YmhFcTlmTzdv?=
 =?utf-8?B?bDJlbUg3OGMrTlhFVEdvZXQ0cGRmaUphdi90ZXl5Q05WREx5QnB6TVpmMGVM?=
 =?utf-8?B?UUpSeEdtbnplQXR3cUVId1ZHRzlYWjVNSVZ5U2RLZTVreTQvdGlYaEtHczUr?=
 =?utf-8?B?M1dhZTNVT3U2TytVNEs4Q0N2T3lQaFduU3J1cGpvS2s3RjM1K2pXLzZCUHhB?=
 =?utf-8?B?cXMxdHQ1Y0pLbXlmRjZrUzhnRC82clNTOEF4elZhY2hCUVl3Nlo1S3FSYkhr?=
 =?utf-8?B?TXFSWGFudTJvZWRqSkRoc3pkeWtZeEY4L0VuTGM5TDZFNkdER0cyMDFRaEs3?=
 =?utf-8?B?TENhSWsvR0xzV0pwSnRhRFlBM0s3MGwrK2c1d2g2NEMzTy9KMTZzZXlJRzVT?=
 =?utf-8?B?eXEwUlhsVXNEMHdkWVVwYldibS9GNkg3djRzZDZPZ0hOcUorM0U5dksydkd5?=
 =?utf-8?B?enFPZE9IUktkRDZXdmN2UmlFeHg4NThTcS9GcGZTMFZwZDNNY0dTUGdHeDc2?=
 =?utf-8?B?Z3FiWTVJOFBKNkozTENGTHdFNUl5UkJQelRndUw0bGM3OSt3MCtDS240NnJ0?=
 =?utf-8?B?T0R2Y1BMY1IzZnU1aXFKd0lwdGlEN1F2Y0poWTVDMWtiZVlHSnl0Sk5iSy9n?=
 =?utf-8?B?cVdkVVRZaFkrY1dmdUpvSEJXNXZXL25OZ0xSZnYxYUZ3VlFiZlRmVTV1OXhY?=
 =?utf-8?B?QlI3ekJzcUUrRzgzOUNZL1pTV1dpY1J6amZIZWRJNXBhY2VJSFlMVmVnbEJ5?=
 =?utf-8?B?QzlPWjlNN08yMFI1TVV5R05zaFFOakJyRlI0MmxDcjU2YzRQNGFZeTJDRXpT?=
 =?utf-8?B?cURJN1VzQlpNZmY2eG95OW5WOTJ6ekp0L0FpRUkya3NsbE1wdS95bDNIemxF?=
 =?utf-8?B?dzRrUlhIeGlhK1YzMHR6MlY1djFpWjRlWFBvbWkvaFZPWU1qYWVLT3N2YnRB?=
 =?utf-8?B?bGM3T3RhRjFMUjNVVk1saE9Kbk0zMWZrVjh3enRvcWtFalpaRTZlbEhFb1RF?=
 =?utf-8?B?OE5FSDBCMk1IamFZMGUvMHhIV1BnMXUyS2lqYWw3THZRWmZac083NVI1VEFj?=
 =?utf-8?B?YUY2bWg2MERLcjczSWJQMWsrMnlFSS9WZTh4czVwWjRSY0JSWFhybnA1ZjQ1?=
 =?utf-8?B?ei9uNUZQekgvSmp5ZzI1eU8vbzlXenhSVnpmSG43OFV6cW4ycUZ0MSs1Z3h4?=
 =?utf-8?B?QlJ0YU9OSmV3c0lyZ2Y5NzlPaW92WUN0N253R3pvTnpvdC9jZm9UMXlhQ05P?=
 =?utf-8?B?TDR3WTNLUlgzbENROVZiazN5NUlTVGFjMzYxNnl5ejFXQm1ZWmJ3UHZiek0r?=
 =?utf-8?Q?pcU5oV0agIe5QtwDQ6BtP2E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd9e83f-524c-43e7-a981-08d9c580c6dd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 19:25:13.5037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqJvD6fZFxHDVkZJwoHWiBzsQ3EDIAADtAvioBM4dhPvctGYcmHoLCO9Nj54oE31LYoo7kdOdTNdC2HlabVuFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5672
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10206
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112220106
X-Proofpoint-ORIG-GUID: v5b-ApxE2dJIZmCncfW6fv2XrQAa4Xt0
X-Proofpoint-GUID: v5b-ApxE2dJIZmCncfW6fv2XrQAa4Xt0
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>
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



On 12/21/2021 11:54 PM, Eli Cohen wrote:
> On Tue, Dec 21, 2021 at 11:29:36PM -0800, Si-Wei Liu wrote:
>>
>> On 12/21/2021 11:10 PM, Eli Cohen wrote:
>>> On Wed, Dec 22, 2021 at 09:03:37AM +0200, Parav Pandit wrote:
>>>>> From: Eli Cohen <elic@nvidia.com>
>>>>> Sent: Wednesday, December 22, 2021 12:17 PM
>>>>>
>>>>>>>> --- a/drivers/vdpa/vdpa.c
>>>>>>>> +++ b/drivers/vdpa/vdpa.c
>>>>>>>> @@ -507,6 +507,9 @@ static int vdpa_mgmtdev_fill(const struct
>>>>>>> vdpa_mgmt_dev *mdev, struct sk_buff *m
>>>>>>>>     		err = -EMSGSIZE;
>>>>>>>>     		goto msg_err;
>>>>>>>>     	}
>>>>>>>> +	if (nla_put_u16(msg, VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,
>>>>>>>> +			mdev->max_supported_vqs))
>>>>>>> It still needs a default value when the field is not explicitly
>>>>>>> filled in by the driver.
>>>>>>>
>>>>>> Unlikely. This can be optional field to help user decide device max limit.
>>>>>> When max_supported_vqs is set to zero. Vdpa should omit exposing it to user
>>>>> space.
>>>>> This is not about what you expose to userspace. It's about the number of VQs
>>>>> you want to create for a specific instance of vdpa.
>>>> This value on mgmtdev indicates that a given mgmt device supports creating a vdpa device who can have maximum VQs of N.
>>>> User will choose to create VQ with VQs <= N depending on its vcpu and other factors.
>>> You're right.
>>> So each vendor needs to put there their value.
>> If I understand Parav correctly, he was suggesting not to expose
>> VDPA_ATTR_DEV_MGMTDEV_MAX_VQS to userspace if seeing (max_supported_vqs ==
>> 0) from the driver.
> I can see the reasoning, but maybe we should leave it as zero which
> means it was not reported. The user will then need to guess. I believe
> other vendors will follow with an update so this to a real value.
Unless you place a check in the vdpa core to enforce it on vdpa 
creation, otherwise it's very likely to get ignored by other vendors.

>
>> But meanwhile, I do wonder how users tell apart multiqueue supporting parent
>> from the single queue mgmtdev without getting the aid from this field. I
>> hope the answer won't be to create a vdpa instance to try.
>>
> Do you see a scenario that an admin decides to not instantiate vdpa just
> because it does not support MQ?
Yes, there is. If the hardware doesn't support MQ, the provisioning tool 
in the mgmt software will need to fallback to software vhost backend 
with mq=on. At the time the tool is checking out, it doesn't run with 
root privilege.

>
> And it the management device reports it does support, there's still no
> guarantee you'll end up with a MQ net device.
I'm not sure I follow. Do you mean it may be up to the guest feature 
negotiation? But the device itself is still MQ capable, isn't it?

Thanks,
-Siwei

>
>
>> -Siwei
>>
>>>> This is what is exposed to the user to decide the upper bound.
>>>>>> There has been some talk/patches of rdma virtio device.
>>>>>> I anticipate such device to support more than 64K queues by nature of rdma.
>>>>>> It is better to keep max_supported_vqs as u32.
>>>>> Why not add it when we have it?
>>>> Sure, with that approach we will end up adding two fields (current u16 and later another u32) due to smaller bit width of current one.
>>>> Either way is fine. Michael was suggesting similar higher bit-width in other patches, so bringing up here for this field on how he sees it.
>>> I can use u32 then.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
