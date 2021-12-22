Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97242C433EF
	for <virtualization@archiver.kernel.org>; Wed, 22 Dec 2021 02:04:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C552415A6;
	Wed, 22 Dec 2021 02:04:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W4EVkP8qM_yt; Wed, 22 Dec 2021 02:04:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CB2E741598;
	Wed, 22 Dec 2021 02:04:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92684C002F;
	Wed, 22 Dec 2021 02:04:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 374BDC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 02:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0FF9A82E9D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 02:04:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="Beq5rLfG";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="b4QBXM2U"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ttJX8uCEHb7s
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 02:04:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2CC2782C3C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 02:04:34 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BLLE0pf001287; 
 Wed, 22 Dec 2021 02:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=CJEZ8MREYPRwIfM/L0lv7n8BvlRqezS02HLHDNOvZmY=;
 b=Beq5rLfG1vRke/W5yxZd3aAcTxyOgtfmez0zKFAQ28N9o6n8VagHUjiSYgtlujc84qo/
 GUxi341vcOsy1QlXV3nNxq2Cp1aIp/yrMqIBDgBzYesZMtagVvfhEzsuzAaMSdzMRfAv
 6L+orUM7f4JUSHFtYqWdb2/0L1v5q+E/5vfEqnZJKNyQe6tN6Q+1eLAgksWc4cXO1Btv
 Hb+TeR92OnxUeePeAmEfy9t1+PS8pCaTZIkbL29/5Veszp/8zFHQTNinIMJ7AiAv/tKW
 sOafOUIffo6QQKLVc7P2aohNs3HBTGmFd4T1CgHaLAD1EbAA0uWbYMe3z2RmitXtpu5p IQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3d2qpd4stc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 02:04:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BM1usnk075808;
 Wed, 22 Dec 2021 02:04:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
 by aserp3030.oracle.com with ESMTP id 3d15pe1nyr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 02:04:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTqyZdvrQGOkqtR7kF1LcBLE7OZwq05G0JzcsbFTyWPE8aJ+qhCfi3zlaFpeqhQq5qrCOsCn1XplGj6TciLKPah49tYh3R9Imk4gpgG3xJCu7pcLKEV0ROOsr0k48gf1BaqUsBjX3sIpZProfIiPHfmNgqA/E8lur70rMTjSna/+Tu49nRrr5v1PEqVrcv5Q1WEnZmJm4r6ciiDZLfjCMjVKNVPcQ3BzuRO8v7rclzdtmGSAAt/Lm8KJvCClVY4yxt04AU879Q+uGFZ5iTSaeWwk4KTgIwGwVOANuVIZxyOW9yUB6yC0Fp8wMhlXbqJS5HxIROZQ+Sn8owxmW5Y4gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJEZ8MREYPRwIfM/L0lv7n8BvlRqezS02HLHDNOvZmY=;
 b=VXO0nBbChoiabgPz7endtPDfiYWUxYWBtaSRevjP5kzC6kBQXqtuTIcVx+4Tm9oUVoGx+9tJSG325615cZw9ZFJtfcSP3DnGdpg3dRJRypiBNQx1reCU+6yNz7Hz3RJDE9UG6K9zp0FG9XwumAyunwDUfJrwX36K2vNsuY8zlJxMY93+Dqr+Ld2yW3yXFLPr9vUzeFWANP5H0dRwfwmIAX3jDuZ/GCyKnrX2J5IgT9PfdZ3nr/pTTzfPxJgvTHkcg0uAcFzs4hRpCb3zh/Y7iL0Wdgvs5KKlVgl0CBeL1vUWBXIk8nsvwKZLoLXnxr3nTGaoxS0CxKJivOnrlROSKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJEZ8MREYPRwIfM/L0lv7n8BvlRqezS02HLHDNOvZmY=;
 b=b4QBXM2UMw3M5sbOXvuCVb4ohgaN6M8+5OqrCd1yrdm9fMyMXV3R6LG5XCKDxjvSMUuUrnIFkT2AiyT1j2tdHwsv2KIDum/3DlVWxec0ESZl3A/XIdmgkMz4EwlPSKA4fc2U+y3SH/L/nP4FQvyZrpriQRAvbUgOmOvpKJkkI3k=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BY5PR10MB4308.namprd10.prod.outlook.com (2603:10b6:a03:203::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Wed, 22 Dec
 2021 02:04:30 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 02:04:30 +0000
Message-ID: <2f17ecef-40b8-3c43-54e2-6e084f19d44e@oracle.com>
Date: Tue, 21 Dec 2021 18:04:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 08/13] vdpa: Add support for returning device
 configuration information
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211221172006.43784-1-elic@nvidia.com>
 <20211221172006.43784-9-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211221172006.43784-9-elic@nvidia.com>
X-ClientProxiedBy: SA0PR11CA0168.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::23) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dc6cd60-42e8-4feb-6253-08d9c4ef63a8
X-MS-TrafficTypeDiagnostic: BY5PR10MB4308:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4308EC102F92E75ED3A5E5A5B17D9@BY5PR10MB4308.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BN7i8nOgiJRRBc6C3yf/DOBUQLQBqEuXC35yg8YlOWFl95PmRlhPYvDMXyg2DSBoHM2qdN2jZrMy/OET4HZloO1GuFz1xO9TOYvqSSR4K6bseZ72+NRgSDIzhDMeNEJSibD5jxQFVH7ysuX3nJHVzCC34DkNcq3T6I9qVf6WCfyG1QPvDYDWDHW1TzzPse5mjUgFBBeI+UUvkqWErgiLED4ISZ2+TMKra/6uREySusP9JPTkufH08TWWz0rvrJTTWRed+97TpM4qBwsh/dnAJNND0SzON12MtJ32n2nZgp2eEXMMmfPy7qCMWNiVV5dx2zhrbj0xPScD92O4rlD0OCeX2ZWC2KK2tJdFh/ias7PplPwxjYzCdsBnCu75yXZO+7CEKgCvgqbrFf885EcHOTRg3qHFIb4u3OSeRLd0wRfZXSJzhRZUq3z8ZeFUHaH7QYxnZKU9WTeyTzVUdx6nHJgY8AG1oTxOrQSdMWHtPYvRvvEo8uiKyBD1YCT+FCkUV3cqq/G7kyk67dFrGLt8C6xtt0WfihdquGxQ5pwrJNtjQpdfNpHQO981EUYmPMCkiLvaOu7+M1x1QkNlnUm3R4cx7kQ7NaYzQ+NFF8ygbAa+BBZTujQRI5SpsXovO4OCwAevCOQPiG14rHDzpOBMyHUaQMCTWxtpfNp9bJvtB2UHQNo/s9YNgY9X8H+BDPcReEcAVB6bOmXSUxpyH5JpQTJ1c2/8YaFVDEZBN6uG8X0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6666004)(6506007)(38100700002)(66946007)(53546011)(2616005)(31696002)(66556008)(508600001)(4326008)(26005)(6512007)(66476007)(5660300002)(31686004)(83380400001)(36916002)(6486002)(36756003)(316002)(8936002)(86362001)(186003)(2906002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFNSaUpKNTBnamtNeHVCU1VnL1M4cGxBeVRlQnJBVVRuSHVHVWhJb2lqZ3NO?=
 =?utf-8?B?TnZkaXFxcXN3Q0lhM3dBUHRMeXZxS05VZlh6a3BQWWJRUjVqS0dmeC9VNk8z?=
 =?utf-8?B?ZnIxVDYzRWtSU3VHUU5wdEp6NEhtV2UvaVpuRzlkU08zeDhiV25DVndnMk9S?=
 =?utf-8?B?M1ZyWXZzQjFoendTb085TytOUjRScStQamg0S2thdU1JczNDcUxONXpCcE9R?=
 =?utf-8?B?QmNoNG1oOTVUOWczZXZSTnV4TWVhODMwNjM2YnFIWGhoQVlHTE1kdUlzN3dq?=
 =?utf-8?B?L1Jib2VBQm9qS2l4YTUwWlQwWnNjR0F1cHJlVjNhOGsyVHFJUTBqdEcxaHVy?=
 =?utf-8?B?cjFTN1J4TkM5TzhBVUs2RTVZMkppTnY1eTB3ZFVETTVZKzZnall4dGF3RStS?=
 =?utf-8?B?UGg0SlFoNVd0YThvcVlJV2xmbXpOTmhCMUxMNVVEdU4yeThkY1dUbmRjWWJn?=
 =?utf-8?B?eGswTWNkNkVPN2VtM3pTZUJIU3FLejJMUXFFaWJGK21ZUXdaMFVPV2p6OVZs?=
 =?utf-8?B?ckFBdWxURXFoaDl5bjJBVU14RllqR1VKNFhEUzNoZjRHOXZYNUxuaXk0ekF3?=
 =?utf-8?B?cWE1K2NWWndaS1Z3U2VkNUdYcHN4SzNWVVJzNWo4MG55UEY0dlJlbHZsSWIz?=
 =?utf-8?B?WE1GZzh1YjFudGxGeWlxZlhwQ3BDdEdyTjdRdnpEbDI3MERseHk2dlRFcGhs?=
 =?utf-8?B?K1p2V1d5Vng1SmpKandibmtxRWtYdXgxQTNSOEt2U0srMVlKM0QybU1pMGk2?=
 =?utf-8?B?UUc3SlBQU1BhaUxlVVhtQVhkaEZWcmlsTXN1ZTZBR2F3MlovcDBxbDRZbWgx?=
 =?utf-8?B?VFUrMytjeVRtU0J5d2szS0RCUGRXMkhsVmh4djBzVDM4Qy9pK3NrQUFhLzQr?=
 =?utf-8?B?TGJTN2lyU2NqK254Q3NoaG1CSGpXaWI2YzBIdDNRYXNibDBLTDhjcWVwYjRj?=
 =?utf-8?B?dTFWRVBKa2dzOFdOdWkvaFoxWWdnWGRtekpTSTVFODFsdTBCaklhYzM4bGVV?=
 =?utf-8?B?Wm4yaWRuTDNRcUVyenQrWDdrMDFzN3JCdDV4dnpneENKNzI1dHRJTTdwekNU?=
 =?utf-8?B?WUxlRDE5clcvS2N2YXZDaWFNTmxXcXY4VWI0bkx6TkxwU1ZtV3dzR1k4V0Fr?=
 =?utf-8?B?Z3g2TkU0akhxTWVCc3NVZnRGZGZIbmdUM1FvcTBuK0xKeS9sMndWYmNSM1BN?=
 =?utf-8?B?RzZXR01qMXh3NHNQWTJUUHZ5Qko5MlpzUWdVSzBMN01CVTFjUXh6TW05cmdT?=
 =?utf-8?B?eGJIdVNudVl5Um11TS9PbDB5S24rU01CZjRBNlFtV2hMYytZYlR6U1ZSR3Vk?=
 =?utf-8?B?SEFQR1lCYkZJYUtEMDZTWDBPRWczSEZCdlIwQ1h3cWVCaDVhODFiRVgyM0pN?=
 =?utf-8?B?Q3I1M01JMnhtWmw3amlLdW1wemdFNTVGM3dQM1lQMWNVdDFRWW1DditPWllr?=
 =?utf-8?B?QjRlQUIwOEFZZ0lJdFdTRUIyWkZuMmZ1RVZGRjNobE5oM3FxWkVEUENFSDNV?=
 =?utf-8?B?L3NKOEJzMlN1aWVtYkZxc3RtcUJSVG9SbGJJZG1ZKzVSSEFUSytLckFhd3Ay?=
 =?utf-8?B?ZkhWYm5xYXprUVdSTHlJM0MwNXEwNnN4cXdHa3NjcDBTZnozbDYza0FLS2Jx?=
 =?utf-8?B?NnMrMlpjVVZCRzZPUGRTSnlhMWlLU211MmQ5M25yYlBxVm5pd2NRcGxMNHZ0?=
 =?utf-8?B?WEltWDJiam9VQWNyQkdwR1lEWEIzRERHQ0QzZUdxWWQ2UG1hK2VJWkkwakU2?=
 =?utf-8?B?OXNzY0MyTjQxUUFZM0ZXdGJ1T2dVUHord0VlSlJFYWRnVkRlblN6V1IvbWFZ?=
 =?utf-8?B?dXNLK2pSZk9CQXZlNWs1bW1uYWE3aU9zeDh4MGpMUUc5VnI4NTJ0VXJETkVZ?=
 =?utf-8?B?Qmc4V0ZYUWlsVUtaY3JlM1k5cU1TWDRtNms3U2xlNXFWajJvdmFPL0VkSzZv?=
 =?utf-8?B?Q3lUeS9LM29wOTh4L2duWlBPSVpzVTNRYyt3WkRKYmQ4cE5XU3hOTk9iY0VW?=
 =?utf-8?B?V3RrL3U1cWp2K29LbXVHOGwrVkJVeS9paG4rOWxJYW5QWW96NFlSeWl5aHAx?=
 =?utf-8?B?aXVlWUp0eENOYUtkakxpSDgwcUlBTmFKQXdJYjZNVlk2K0xhTWZRM2xLazhm?=
 =?utf-8?B?bTIyZWVCMmNNWkdWK0Q2eXVWeWFLRFBIMXlobzdVeVNzY2tEWHBvcnI1bzJL?=
 =?utf-8?Q?bIHmih1niPq7H7QHCXoZDHc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc6cd60-42e8-4feb-6253-08d9c4ef63a8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 02:04:29.8936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRKWBSz3EYsOOWo6sDEXBMbK4pVwFxIYbEp9kLQKS871GBpZ4nrlbHNoS4hdKnc2rBizq+tcRMT8QQUVjDVkXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4308
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10205
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112220010
X-Proofpoint-ORIG-GUID: zL8kOjE3uji3uB2c5AqCQJos7mLyLocv
X-Proofpoint-GUID: zL8kOjE3uji3uB2c5AqCQJos7mLyLocv
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



On 12/21/2021 9:20 AM, Eli Cohen wrote:
> Add netlink attribute to store the negotiated features. This can be used
> by userspace to get the current state of the vdpa instance.
>
> Example:
>
> $ vdpa dev config show vdpa-a
> vdpa-a: mac 00:00:00:00:88:88 link up link_announce false max_vq_pairs 4 \
>    mtu 1500 features c3182bc3182b
> CSUM GUEST_CSUM MTU MAC HOST_TSO4 HOST_TSO6 STATUS CTRL_VQ MQ \
>    CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/vdpa.c       | 3 +++
>   include/uapi/linux/vdpa.h | 4 ++++
>   2 files changed, 7 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 45e4df4076da..eb223bec5209 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -839,6 +839,9 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>   		return -EMSGSIZE;
>   
>   	features = vdev->config->get_driver_features(vdev);
> +	if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features,
> +			      VDPA_ATTR_PAD))
Any reason why specify VDPA_ATTR_UNSPEC doesn't work here? ATTR_PAD for 
better naming?

Thanks,
-Siwei

> +		return -EMSGSIZE;
>   
>   	return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
>   }
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index a252f06f9dfd..db3738ef3beb 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -23,6 +23,9 @@ enum vdpa_command {
>   enum vdpa_attr {
>   	VDPA_ATTR_UNSPEC,
>   
> +	/* Pad attribute for 64b alignment */
> +	VDPA_ATTR_PAD = VDPA_ATTR_UNSPEC,
> +
>   	/* bus name (optional) + dev name together make the parent device handle */
>   	VDPA_ATTR_MGMTDEV_BUS_NAME,		/* string */
>   	VDPA_ATTR_MGMTDEV_DEV_NAME,		/* string */
> @@ -40,6 +43,7 @@ enum vdpa_attr {
>   	VDPA_ATTR_DEV_NET_CFG_MAX_VQP,		/* u16 */
>   	VDPA_ATTR_DEV_NET_CFG_MTU,		/* u16 */
>   
> +	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
>   	/* new attributes must be added above here */
>   	VDPA_ATTR_MAX,
>   };

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
