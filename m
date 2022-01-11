Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234EFC433FE
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 21:48:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C101D4090D;
	Tue, 11 Jan 2022 21:48:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t11AlA3XNWUY; Tue, 11 Jan 2022 21:48:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 13ACD40907;
	Tue, 11 Jan 2022 21:48:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D83DDC0030;
	Tue, 11 Jan 2022 21:48:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D8D8C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 21:48:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7B3436FB3F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 21:48:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="weBAxogC";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="FaKSskj9"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6q4B68ey34Xd
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 21:48:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B72996FB3C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 21:48:00 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BJNrMF019911; 
 Tue, 11 Jan 2022 21:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=TAgPa/AbbW9FNFFy1jIHxtm1QdZI6+zI1kDtItfgagQ=;
 b=weBAxogCeEK+R2rUupafuRdF6GhKgSEAxroXxnCDXdfBWh6NRBI4MRy7TPSmMeqC4WvK
 xvFTkcDeShAxSTG0sFX91NvKPknDNaFGR62G4xTnLs6pUkjTWbTroPWnDDd9aQkkPJKy
 m4iKtkTNLe8mi+7Ll9x1+2T6I2tmuG1cBEakqsl4yBlkBPbZ/TzaSSyZ2Z4b1THefDMD
 n1MA36j0rBxsLJ9DVtPDETnit5NiOXzaYLTgJDHoTCrSyXWg61FEiLPhpIKer3DU31Vt
 SD78hZ2YvXYfXFIPthH22TSZfqmjx06nrgnaAgYPeRuk6J0F6C+0Voxd1VtImO73t0zX UQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dgkhx4g5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 21:47:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BLk2wi146340;
 Tue, 11 Jan 2022 21:47:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by aserp3020.oracle.com with ESMTP id 3df2e5c0xs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 21:47:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRCS4QnHJUc7Bw/w1CKtwVeeyd9aWnbidtTyMAgZtG3QG1hJgq4XuSMH7MA221/tG5NHa9Btwb/fJUKad/yPXRkooGzfroymVZr8p7BeRKHhwx0284NqMnjdNH4vVaEBLbLN5qJGAWzKJThprCG6K6IfGB1f6vlFRHynmiZPvt/3R7Sf6PGTDx2mq88r7dr6FMjb4XyGoU0lEP6Fa4GbnJh3BwhZEz70DZV+zsI2qqeZpnBlDanAICONhv5zzVNrlsBXqTG0qv21jMAfkGAfoBHaSCpOo/v9kDFNX/LfMAggFUHAl9dpkV2Mvacv6x5IeQSCvtsinxPdLHBdiMgdoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAgPa/AbbW9FNFFy1jIHxtm1QdZI6+zI1kDtItfgagQ=;
 b=aBS2HjZW0cHf4jjOShQ3oHeEKuY62Jo4OgqkbivSpfehAKEjbsjI+Wg7S36thM7yWxYj8SolLphMq4Wb8U8saLBLG8NafVUhNpOqkFMaXM598DyV2ccD0JWrHfZA1zBFBkCHMi3IxUdVjySZiHhgyUT9t9JKhs71BojCcVoqo5BfWuFi6eo3my8EyVaAYHg+syizpVQq12/SwdZUmtNphL5M/uCu6ayO9WZulRmaYaFpCSC8POWR5u2yq+kl/VvXSF0CJlu9niUhxzTF4H77ydkyepnFDhSfcSypMM773iKtesqXqoBDsem7g67f8GG/NAUDaXsx21h1OFWUN1LkPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAgPa/AbbW9FNFFy1jIHxtm1QdZI6+zI1kDtItfgagQ=;
 b=FaKSskj9j+j/u1hYlAlrc945uEGuRHiuEYKYuVFKQSjS7KqqT+C21ytSJGYytMdjVK/5qXgEPTXdrJ4857HFmjyby0BRse1jFP26PKPwuIB8bTeqpctnYKV3yPTjp99WIbbfKptmO+ZSDFkXCzFFL4ST9UOtPVessQqHX23NBwk=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB2933.namprd10.prod.outlook.com (2603:10b6:a03:88::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 21:47:56 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 21:47:56 +0000
Message-ID: <57dcefad-44f9-fb1b-531f-0c4367ef63c1@oracle.com>
Date: Tue, 11 Jan 2022 13:47:51 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 3/4] vdpa/mlx5: Fix is_index_valid() to refer to features
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20220111183400.38418-1-elic@nvidia.com>
 <20220111183400.38418-4-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220111183400.38418-4-elic@nvidia.com>
X-ClientProxiedBy: SA9P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::19) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 760ce4f8-07c0-4220-60bc-08d9d54c0738
X-MS-TrafficTypeDiagnostic: BYAPR10MB2933:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2933DEE7413058CBECD4F713B1519@BYAPR10MB2933.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KENB12oCIC/MzpYnVmBKMX90behpFSMg1QDa9WxI3syGWQMrMRMEaa7N5vBFMEy/fOpD7OlMMTbgu/uTrZUxTJUhi91gMawey7L1tWZTqbn+tRj4o4VCp3nmX7WHysqeAifWLJc/XoCfXk2u+Lhu8ZCTr5YLvilGHcoiuDmYArGx3NaGG1Dxixlu5j0w/aNS0zYAYIYTfl2qUkB/fV4T8L1S+zRct/aIgv1SNYhClVWALq3CDsiVEtUBOZ8SF9BUqyp+dlo6sTWhCCLoWvW7vjhTeQwpHMDB+nXLG45nuyDuRZEKyNycCmqDyJMkLOrYmR/APVfkz1gJ1PbVU8oa2uDjGfPBW9v2ktxnIj5JQ0nHjkDVig2yiQ+zkQAiM6wS7iwunla1g+lRKVhvRumNp+CxTfZzxb+HmrLG1D67FYzlYRf7SgTRpy56Np8Om3B/GmE9QbxmsCGYIhRoNcivB5RgNX/tCkqO2qYJMRRRhzVZxRdXx/qoDzunNqHV1/+PAv65vHwciL4VUNu9MZjk8/VPRHXfneft+rhPU2cj8AInobPRdwvg0mP9AougR8zSYaPmGtj28fKRZBs/4mk+RTvV8h5lYup+uZzXU5mZBqFgV1Lk2a7/CXYnDyUCwm9OSWJbG2Kgl2rZEz/6bZ/jtKajsf5974M5jUrSNeah9Zg18gFl37m6Izxyt42aAoYbYmuR4kjAU0Vp1jgYK0vf+eDvlC0LqkClb0vRIdbFEKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6666004)(6506007)(66946007)(8936002)(36916002)(6486002)(186003)(2906002)(66556008)(83380400001)(508600001)(2616005)(5660300002)(66476007)(86362001)(316002)(26005)(38100700002)(31686004)(36756003)(6512007)(4326008)(31696002)(53546011)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkpvT3VIWVc1dGZ2dTZBQTduZXFWaDh4dXZPUW05Lzh5MXBxRThQRU5VK2NF?=
 =?utf-8?B?UUl6Y2VDZWZvdTdsc1hkR0paWElaWEZzOWdJYVR0ckwwZ2ZQcGV3MkVzTmVS?=
 =?utf-8?B?SU9oOFJXdEJ1bnF2dlFNNTJVc0ZyRGplNDIvSEk3RDFoWlVQQUkxTjZFcHRo?=
 =?utf-8?B?T25SZUE2RXloQXFQeDZJMDBZQU5RVCsyS0Yranp3eG5vWkpHVjk3L2k5bDlr?=
 =?utf-8?B?dmt4NDhEYlVkUzhKZjdxaW9NSDh0OGxzWGdsM1hCM1dkaHlKdHBTWWxyOXRy?=
 =?utf-8?B?d0ZoN2U5TzZTVTlKckRBdEl0R0xON1FKS0Z2TlZPVlNSeFdhRVJ4NmVOcjlE?=
 =?utf-8?B?MEczWDExZkNKQmNhblZHbUtFUWVXVjBmQXM2TkdZSjk4VTFvWURLMklYbFBn?=
 =?utf-8?B?eWRXZkVsK3phY081OGxxRW9pWU9CQ09kN3hOUWttekJoK2VNZndLdUZ1SFpY?=
 =?utf-8?B?QzVqTkRhTEttTTc5eWlsd2FDU3VmaXZHQUJhejVvYVduUmwxTnFSMFovR1hW?=
 =?utf-8?B?VVBiRDZLWVgySWFpTlRDZ3VWQnAya0IvMUd4VDRUNUZvWWxXVHFkY3pOTXZO?=
 =?utf-8?B?RFowSmE1WUFMQURwSEphNmlNeXc0WFcxd0VBcHJFMThDcUtISkViRW9TNUJQ?=
 =?utf-8?B?bmNhbXc4dGNrbnptQ25hV2pvQ3l2bHZObm1rVzJBbUNrL0hZb2hpRHRMemhJ?=
 =?utf-8?B?SUdnaVFySmQwRmg4ei9lM3p3ZHFkS0RWNlNEbmttWCtqYldDRk1uTDN5UDRu?=
 =?utf-8?B?eGkva0RsT3gwbytxQkVyY25YQ2NHMzNKb0FRWVpwMGdQRnRuRDN5S1JuTUpQ?=
 =?utf-8?B?Z1NKblBmZGdXeTZWK1YxaDgzQ1YrZ3lpZkhVRUFKUkpqNFkrQW1DdTlCaXhH?=
 =?utf-8?B?TjlWdVBEWWFyNEYzaFFQQjJrSnhnRHlQOFVVdHc1RCszeDI4TkU1T1JCME41?=
 =?utf-8?B?cFVpbm55K045aEV3K3hCcm5hcG1OSHhCdEFPRUlucmMxc0wwcGdnamNQNDU1?=
 =?utf-8?B?ejdQV1l3VGdkWGlDaFdVelZTcHArN1JKQnBVUTczUTZOMGozUGpIZUpNQ2dD?=
 =?utf-8?B?Q1V4eEUxcXJrL1Z1MWVpUHNHYTY2T3VKUHJ0RFUycGdoK0R5UTAwY1cxT2R4?=
 =?utf-8?B?UkdnMzA3TTRHbUVMRG5FSDlxd0NWR2daam8rRlZGN0NlSTNLL0ZlQkNQeWpR?=
 =?utf-8?B?c0hHNkNpb2sxYnp4ZmRuQnRlcEFGUGYrbGUyTGJjZWN6TUZKZ0MxdlBBVGtU?=
 =?utf-8?B?N3JVUElQbVcxWXRqZFh5WkxtejEwMlRhb2VWS1VRb0tDSERmaVByczNzU1c3?=
 =?utf-8?B?N2RiWDVIZjZOWUIvUlQzamIzb2MxRXlFL3VWL2daMkNlMlIyVm9zWEJWYlVZ?=
 =?utf-8?B?TW9sdnJDeURkMDlIaTlQTWlpbnRBY0Vib3ZvaENxb0Fma0Q2MDE0dUNMRUFR?=
 =?utf-8?B?NFF2MzdMSEtFM3dZMjVHd2NkR2RFaXFnTGVrR0cwcVJPRy82cWM3d1BVNkdX?=
 =?utf-8?B?eStqVWFQc1dRWWFDMEdzNzQ5ZlkweXp3OWlBS05wVmN4WGVEMmpRQUJwa1p3?=
 =?utf-8?B?SGNhUUpTbGNzWEFtdC9lWnZuL0Nwa0pLYmZXRUlmOFE0VU9TZ25ybCs1WGNx?=
 =?utf-8?B?QklCNVNtbnorcjl6SXVYT3NRK1I0TVJnRzM5RmxvVFFYUk50RFBRV2VLcGVD?=
 =?utf-8?B?WFdMUXBzeVpYZFFIS1lMRStpSjR5Q0FVWk81eDhXTDIzNnh3ZHN3NHpWVnhU?=
 =?utf-8?B?bjVwejdGNVJpNzdxSXJCWDBhSkRQRktYejZSVGY0TkR3bEV4VUx2T2VMSGJ2?=
 =?utf-8?B?Mjh0enpoR05VWm1iQUhCU1dVbnZLNUVQR1pkMU50d3g4YmlkZFhTVWpwbGJP?=
 =?utf-8?B?VUwxUTEyRzhuUWo0YlFNRitBU0JDUnUzMzhha3NlOFc4UmtEMTFibXo4UXhI?=
 =?utf-8?B?V2pPMnVnNGI4eGVXRXpLZkxZNlhKbFk1VU51dE9lWTUzcUQ2NTN6WVVWeEVr?=
 =?utf-8?B?eHByMGNFNkJvK0oyeDBHZ2dSay91NFlnejlmRXo3VzR0KzNKNUcxVTFCM2hR?=
 =?utf-8?B?SytVd0ExbGtKeFczWGZUcGpZeThyZStCMndKeG8zS1NmM0pHbUZnTFhyL0pX?=
 =?utf-8?B?YW5KL2JsTGVTVjBzVDhGcGoyNjFkYjQyV3UrMTQ1UUwwdGZNcTl5a05EZjRD?=
 =?utf-8?Q?gZXlK0EkYkTY5gQRRLF1c5k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760ce4f8-07c0-4220-60bc-08d9d54c0738
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 21:47:56.6564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGGnWCHHWgcSSIvo4/bC9MExxtNhnEXSpjkR7nlIUECMa6kqYC+8xoc2tlR0soLyJvzteh/fQVNDVoOxLTyCyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2933
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110113
X-Proofpoint-GUID: VjrFZqWg-BdWHJL8eCxGXHUjryBRi94X
X-Proofpoint-ORIG-GUID: VjrFZqWg-BdWHJL8eCxGXHUjryBRi94X
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



On 1/11/2022 10:33 AM, Eli Cohen wrote:
> Make sure the decision whether an index received through a callback is
> valid or not consults the negotiated features.
>
> The motivation for this was due to a case encountered where I shut down
> the VM. After the reset operation was called features were already
> clear, I got get_vq_state() call which caused out array bounds
> access since is_index_valid() reported the index value.
>
> So this is more of not hit a bug since the call shouldn't have been made
> first place.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
Reviewed-by: Si-Wei Liu<si-wei.liu@oracle.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index d1ff65065fb1..9eacfdb48434 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -133,10 +133,14 @@ struct mlx5_vdpa_virtqueue {
>   
>   static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
>   {
> -	if (unlikely(idx > mvdev->max_idx))
> -		return false;
> +	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ))) {
> +		if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> +			return idx < 2;
> +		else
> +			return idx < 3;
> +	}
>   
> -	return true;
> +	return idx <= mvdev->max_idx;
>   }
>   
>   struct mlx5_vdpa_net {

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
