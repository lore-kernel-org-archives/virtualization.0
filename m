Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73617C433EF
	for <virtualization@archiver.kernel.org>; Wed, 12 Jan 2022 03:12:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06CF482BC3;
	Wed, 12 Jan 2022 03:12:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7R9KfXvhqD67; Wed, 12 Jan 2022 03:12:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8F3C18278F;
	Wed, 12 Jan 2022 03:12:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B293C0030;
	Wed, 12 Jan 2022 03:12:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BBFEC001E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 03:12:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0060940924
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 03:12:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="Nk9ebAGi";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="NYVBb7JS"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5rXkAw_w6USE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 03:12:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A6344091C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 03:12:21 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BMfL8p019147; 
 Wed, 12 Jan 2022 03:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9Kis9QuUTO+YE0zepOPdtrLCGW4Uugt6iFKxWFsZfOw=;
 b=Nk9ebAGiUnAXP9hMf+pjfs4paVOLgKU/Ez++V7zgWdJlxm6oNMWiB8wwn/BQHvSoxFU5
 +JDfilON9SDAunlsJD7LhZOZdySaZXJQ7/BM90m/0J3qItYP/9l+uluN0dy1B0B9hrYR
 ExfhwqqDb7SulAu/Z5rhygPDH4/FRg2S2f3cViqt6jYpiHMK26qxAcYo3FyG7wPMytwx
 liLytfFZ7VvzJuaPQSVtV9e4q66tpUnqihC4xaXLt2iVfUcnnPrNwNLMMS+LBr06rd1b
 jSGhuRduasleSEbkVGt1Jgp0454HIeR12mAjg/rtc9LnHYTj0u2hj7EX4jiIBbyRNbLo Tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7nmsus-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jan 2022 03:12:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20C3AUHv063727;
 Wed, 12 Jan 2022 03:12:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
 by aserp3030.oracle.com with ESMTP id 3df0nevvg5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jan 2022 03:12:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOgMB/9stiOEr0oMF61EwgJP+VCXWvKgF19xJwx0vsQRNMqBIhZevwf0Gj5WawSIMTx9Ptm5aItTB2eScCus40OGrMepf4iapLg/ogARuoOy80HBuWkxlSL1NBNU+CylooQJF+USbO0JvdvdT7nbTP+atjY2Zx8cSBmvKr5xNASd2NTBE0wcD7Dt9uwo8Wz2YhEKBD3k/CJUTQYaIUcZIq/HhASlT7jzvdKGdMpojALFexzX84Oq6yMp/xeyl93QrkPWon0wjYA116TDiMfzsQx3Z1wnC7nfAtJKxSbHVXxmvO8WrOrLaa2k7TdhwX3ZJotSQKFH6aX9e18M8Qj2aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Kis9QuUTO+YE0zepOPdtrLCGW4Uugt6iFKxWFsZfOw=;
 b=GI5qfyPxHKzHoVgeg9W8G3NVWslH2rn8mPWsyshZ8N950cltT3FFyaoj++rmHDTYICKYHzgP/c4NU0KXdQTIStqQNnhS0qUVVjtTf9WzCfmfegkjC2jLubxcTFIKtOkXBLmXKd90kQiX/i2PS5mgg+t0Ma/7hdffphB4wqXV7N6zegSiWnHCNnk+CQjVuJ+4Q8+cyFpHbSHhKL4vFr57U0ejisz4nQRrI+JHXd2Yr5mfpazcZAa7YjK+dQII+xB6bExiISWD0MRa8SiqCSzKrqnVDNhMlEmCAnubAr+x5+ssrlNCO7/5k7VoDejRrUU7XZfOvHOwLhBAVjC18SySFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Kis9QuUTO+YE0zepOPdtrLCGW4Uugt6iFKxWFsZfOw=;
 b=NYVBb7JS3hZhsGB625YBRnBUvXgGKTg5zbfG5DcIxZNDHfU5Wt+tDvxc2f5xyz+YlBhMZdQTBaqTF4VmAAiq32sGpUyR3C+IxIYJEX0xQHMlJnFyoU2Kj9GwZMEey6dYuuGnyCUQoJuBd2n6sGWIdtCYO4aBzIX+GW/5eChGReE=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB2584.namprd10.prod.outlook.com (2603:10b6:a02:b1::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 03:12:17 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%5]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 03:12:16 +0000
Message-ID: <e65292c9-2d4e-bfb9-545b-75a2f97b67e5@oracle.com>
Date: Tue, 11 Jan 2022 19:12:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 4/4] vdpa/mlx5: Fix tracking of current number of VQs
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20220111183400.38418-1-elic@nvidia.com>
 <20220111183400.38418-5-elic@nvidia.com>
 <8f1d7e2c-e8ca-4c09-f18c-72cd4c09c44f@oracle.com>
 <CACGkMEs77urb3Ef++tVHvQow2eRKpzW3c8TPtdiGrq9jQcmWjA@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEs77urb3Ef++tVHvQow2eRKpzW3c8TPtdiGrq9jQcmWjA@mail.gmail.com>
X-ClientProxiedBy: SA0PR11CA0081.namprd11.prod.outlook.com
 (2603:10b6:806:d2::26) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edcc85a9-f6a3-4836-c5af-08d9d5795664
X-MS-TrafficTypeDiagnostic: BYAPR10MB2584:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2584A27984C0BF2E2CB88518B1529@BYAPR10MB2584.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PHMqEWAgre7NTXhfEr3kLVQX28lhlf4aTcS68T9JqrTfq5F9faGaO1mI5vqtu855uVOTIoox/QfpyhSQYc4d9mHL8IKWxtD8ftmh62pCCZnebGnv2GinfPs1+Bozt/e03Xqr6gNDuFZvUJb1r9rQF2qzkahM/vziY9FVur/wsHtsZmidYvNXxn/P8mgUL/SYdkGuJZ8NUFUvOPUG7YdHhbKnh8AscW6FQTsiP2ReWsl8lYPNLGcuRLd3pyCGlfspOzDMnBTG7SNZuJ9bDpl/e8PHK+YaJjnzKXMWEVsvBs7NIhZu2n1eM/6UL32BM25YeMgKKUGoUq2iiXGLPCLKtW7VYtkiVTmIlFld2W9sZ7Jx4FjUD5q+59ahbSZbG5xHqv/imuoiWjKhShcgR9Ge8ZQ2qJ+atQVEyQqitX2Tlka6he8RypB8sE6xfUWUngex5GH3/YxrzQdo2Gl/XGpBXwfGB/TQJR5CsW8G6W/potUuw5eyafUMloKS7fCIwN12hxFmoRTAw+kZjTwuBY8iv2H9/18z+HtC33+9OcEXuJe8AROY4qbhgB+y8ZmSTZdi5UiVuEIUuqBzVNjF+20IUStQ9UrD+fPCUHF9Qs6UzlKG0rtwpzqb6e/rabF8TN5NwH3234o5XZoUf4jnexHCPpMjf8eTqvk2AQ0zMvQl1CAUxXK1hUaZ6aT8yMUKTZFeRqX62WZ+xRSV8OebZsxk0rxcwInUGiw010rvVxE5Ru0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(8936002)(316002)(2616005)(6916009)(8676002)(6666004)(36916002)(38100700002)(83380400001)(508600001)(36756003)(4326008)(54906003)(2906002)(66946007)(6512007)(66556008)(6486002)(66476007)(186003)(26005)(86362001)(5660300002)(31696002)(6506007)(53546011)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlU2a3IxMUEvQzk0TjhZYjFnRmlaVm1SWjVCcVQ0SnloRldvYmFtem1wSjdh?=
 =?utf-8?B?SDNTcnNxdTkxY3V1NnkrbEdlQWd5dUc0WUVVaGFSRThnTjRDcG4rc003N2l1?=
 =?utf-8?B?aG9IYThzZ2liQjNnU2M4andlVGR0YnVSNFQ1ejlnYkltSlBMS0E3aEJMZDBy?=
 =?utf-8?B?dXZnMUJjNkdISFRmN2wzaHJnWit4bWRKVVhMWG9nSXZXSXp0SmxndHFTMkI2?=
 =?utf-8?B?dTBxTkdFYVV2U3Vudno1OTNWUmdvN1lNSHQ3VUt6eVpnODNKOTMrUU83OWxv?=
 =?utf-8?B?b1dka2p5RmR0bE9TVVEvWEZOSGZZMjRqdGM3MDdWclVUNGk0NUl1VWkzR3lr?=
 =?utf-8?B?eTIvVVdzUjNUTi9KY2UxV3ZFT3RFTUFBN1dnQTJHV0o1cUhjVzhBUnNzNUlH?=
 =?utf-8?B?NnBUbWNRc2t2OHBiM3o5bUd2QnlTSy9xSlhXV24rVlRRdmdyQk5MTVpacVVr?=
 =?utf-8?B?WEVpcjI0b1lGRk4xbGZLL29IdUtlZWpOS29Fa2FvZU5hVU5QV3VvZjJVQVpT?=
 =?utf-8?B?alBJTlVlYnd3dFZFdkM4OEQxZXBxcjBFbXRFeXNYVEdmN3JrQVdVaXpFYUx6?=
 =?utf-8?B?LzhJanZZblpjbUZidWx6UDNmdGR5ZHdGb2FHVHRPT3MrQ0U5TEVDZUJvM015?=
 =?utf-8?B?REl4K2pWUzYrY2RBWkZpWGlUU0p6MjY3WXdLTjNEYTRYdHlnbTJtWnd0ZXYx?=
 =?utf-8?B?c2I2K3NhQ2tvYUJDZFJ5UjZmK3c0R21yUzA5SGVMVEdoNmc5azdoczE5WmNG?=
 =?utf-8?B?M2pzSVJZQTZIZ1U2S0RDR3ZZdFdLSTEvT0g2NHZuTk16M2huVHBISzJtcUFF?=
 =?utf-8?B?ZnpqcDArTFhPNER6a3Joak4vendmRmZPbVFySzBXVGVxVUlLSWQvdWlPTllV?=
 =?utf-8?B?dmZxdkhrekxXOHFrSkZnNll4QjRac1VZTXF4WmRzQ1BCbXlSQi8wUldYMWF1?=
 =?utf-8?B?bUZtL3YyRjdJaXZSbUZIdHg5RGFNOTNLVmxDS3RyVUdOakczeDhQN1hSdXlT?=
 =?utf-8?B?Vmwva2VobEoxV2JJU0NOUFF0ME9VVVIwUWVnaXFwTmVBbFI5VVQ5aUVpbEJI?=
 =?utf-8?B?ZWZaMjJCTGlIZGN0dTZGMEd0RmpSVUtVMnpzdFk5Q2pwM3hpYWd2U2lMaUJ2?=
 =?utf-8?B?MUdvR0NHd0dqSVozVVJvQnVUdS9ISlErd2g0RGRZRmxQSFBlRXBHdGhtMGRI?=
 =?utf-8?B?TFBqVmY2dHBYZHVaejNTeGpueXlJbGtOYndYVlhvUjd1RGpjRWhzNHltU2I5?=
 =?utf-8?B?a2k5MnZWQ3ViRnZiY3k3WnZXQ29ibHI1VVZKVUZNbUhKZThQZmUxWnRzek9p?=
 =?utf-8?B?b1htUm0xWHlEMDVxaWpKOWhYV2RZMEZndlk3TUl2N3h1OGkvT1llaEgyZHJn?=
 =?utf-8?B?WDgrZnRDWHA1TjhmRGlVcTN6Tzcwb3lnMjAwWDZQV0ZBZWdva3JBRDdUVUcx?=
 =?utf-8?B?cmlLTWVyZWJnbngyeXJwY0JkK0ltTFVPaS9NcG43VVVSQkdPOUtlam11MGdq?=
 =?utf-8?B?UTFPZmJHZnc3aUIwNW1UZnlNS2ZNZGdKZU9TZWVMeHE1MWNTME1nNWN6bFVi?=
 =?utf-8?B?Z2pyd2JzVEtBQklGN3oxWnBaeFA4UVVuYXE4bTNJdUFtZlF4MXcva1ZCMGc5?=
 =?utf-8?B?dlBETUNkYUlMcXBML3lTNWZOUDA0ek9BSWxkRGRtTXdQVGwvMTNtUzAzbEI2?=
 =?utf-8?B?MlRLVlpUbldBbFdBZU1LRmgyYmgxQ3JIMmN6UWdFRE5senVBdmZxa0txMXEv?=
 =?utf-8?B?WGRhbFRKdFZzUk1JL2ROU1ZLZkI4ampDSjIzVzc1aWVBMVpjcmpDdk5aajgw?=
 =?utf-8?B?NUx5eFg0M0oxK0FuTlFyVHowY0llMFJlNUNqclQ1dFdlRjAwUDFGdGJ3L3lK?=
 =?utf-8?B?SVllbXZOT0ZNVTRHZGltZGdiUEJtTHFOVXkwL2R3UGVSWi9acEhrczZSaFNi?=
 =?utf-8?B?N3hHaEhxSGFPTUh4QWFDZHptKzdUc0hza0tHMllNOWZ2Y0xONWM3WHZXYUNm?=
 =?utf-8?B?TWZuVytPeGt4RjRBTlpvL3VxUkxrYWdmUWZPUS8rQVlvVFU5Smt6R0wzeGJS?=
 =?utf-8?B?SGdTTkc3ZHdCR2MxS1dBK0p4ZGV1RUMwSHpKTnd4SEh4Sk14SE1sclZGVkg0?=
 =?utf-8?B?eUptZDJWcGJua0Q1anhVSU1NRkU5WU9vTmdrd01vMEo0UTNCT1ZlMUNETjhU?=
 =?utf-8?Q?/HXDT73ru3gJ/NJUK5wzut8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edcc85a9-f6a3-4836-c5af-08d9d5795664
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 03:12:16.9027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRTxecbb3hYKVwieIxCLpUf2yzQime6OWl3RU4e/dln7m6BaIrjtqA9PadQQjcFCBzmd4hgLobNuMeMsJe9wtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2584
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201120016
X-Proofpoint-GUID: yEgE4QCp0hfmAD2DpLl1uzElLkC7qco3
X-Proofpoint-ORIG-GUID: yEgE4QCp0hfmAD2DpLl1uzElLkC7qco3
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>
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



On 1/11/2022 6:29 PM, Jason Wang wrote:
> On Wed, Jan 12, 2022 at 6:15 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 1/11/2022 10:34 AM, Eli Cohen wrote:
>>> Modify the code such that ndev->cur_num_vqs better reflects the actual
>>> number of data virtqueues. The value can be accurately realized after
>>> features have been negotiated.
>>>
>>> This is to prevent possible failures when modifying the RQT object if
>>> the cur_num_vqs bears invalid value.
>>>
>>> No issue was actually encountered but this also makes the code more
>>> readable.
>>>
>>> Fixes: c5a5cd3d3217 ("vdpa/mlx5: Support configuring max data virtqueue")
>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>> ---
>>>    drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++----
>>>    1 file changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> index 9eacfdb48434..b53603d94082 100644
>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> @@ -1246,8 +1246,7 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>>>        if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
>>>                num = 1;
>>>        else
>>> -             num = mlx5vdpa16_to_cpu(&ndev->mvdev,
>>> -                                     ndev->config.max_virtqueue_pairs);
>>> +             num = ndev->cur_num_vqs / 2;
>> Nit: the if branch can be consolidated
>>
>>>        max_rqt = min_t(int, roundup_pow_of_two(num),
>>>                        1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
>>> @@ -1983,6 +1982,11 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
>>>                return err;
>>>
>>>        ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
>>> +     if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ))
>>> +             ndev->cur_num_vqs = 2 * mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
>> Hmmm, not this patch, but there should've been validation done in the
>> upper layer to guarantee set_featuers() for VIRTIO_NET_F_MQ always comes
>> with VIRTIO_NET_F_CTRL_VQ. Maybe checking both: BIT_ULL(VIRTIO_NET_F_MQ)
>> |  BIT_ULL(VIRTIO_NET_F_CTRL_VQ)?
> So the upper layer is unaware of the device type. It's better to do
> that in mlx5's set_features()
That'll be fine. I thought the upper layer can be made device type aware 
and consolidate it to common library routines avoiding duplicated code 
in every individual driver of the same type. If this is against the goal 
of making vdpa core device type agnostic, then it's perhaps not needed.

-Siwei

> according to the spec:
>
> The device MUST NOT offer a feature which requires another feature
> which was not offered.
>
> Thanks
>
>> otherwise it looks good to me.
>>
>> Reviewed-by: Si-Wei Liu<si-wei.liu@oracle.com>
>>> +     else
>>> +             ndev->cur_num_vqs = 2;
>>> +
>>>        update_cvq_info(mvdev);
>>>        return err;
>>>    }
>>> @@ -2233,6 +2237,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>>>        clear_vqs_ready(ndev);
>>>        mlx5_vdpa_destroy_mr(&ndev->mvdev);
>>>        ndev->mvdev.status = 0;
>>> +     ndev->cur_num_vqs = 0;
>>>        memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
>>>        ndev->mvdev.actual_features = 0;
>>>        ++mvdev->generation;
>>> @@ -2641,9 +2646,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>>
>>>        ndev->nb.notifier_call = event_handler;
>>>        mlx5_notifier_register(mdev, &ndev->nb);
>>> -     ndev->cur_num_vqs = 2 * mlx5_vdpa_max_qps(max_vqs);
>>>        mvdev->vdev.mdev = &mgtdev->mgtdev;
>>> -     err = _vdpa_register_device(&mvdev->vdev, ndev->cur_num_vqs + 1);
>>> +     err = _vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs) + 1);
>>>        if (err)
>>>                goto err_reg;
>>>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
