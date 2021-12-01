Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7E5C433EF
	for <virtualization@archiver.kernel.org>; Wed,  1 Dec 2021 01:43:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9800180DAC;
	Wed,  1 Dec 2021 01:43:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EbDSL4KHtsOY; Wed,  1 Dec 2021 01:43:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 313E980D4B;
	Wed,  1 Dec 2021 01:43:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E65D4C001C;
	Wed,  1 Dec 2021 01:43:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E96EAC000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 01:43:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C1A6E4012E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 01:43:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="WUrKT2jb";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="jtOciZoO"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e5XeV5OIszgZ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 01:43:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9985E400D1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 01:43:48 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B10kkU9007291; 
 Wed, 1 Dec 2021 01:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=f8fyTM4qF086qWxDRafe6UVK5VggDl75a5SBq8w5+MI=;
 b=WUrKT2jbQNz7z7KxwXOTjftA9fZ17lOxuxsNDwCuYn1TeUvHCOs4K9qIKse1jF1pcvwq
 OAC6LH+QT3CKdvc+cqyOu/0OL4+zJkYeWuw8wng6Y0dvVQhC5qObA2SBpmDbxnJ2sGK/
 YTys+trEu4tdh/PavyI3GR9fbVcUK9sDt1o50av5Zpm9oK1ce0oTIqluhmOfzImdb3QW
 PhTnJYZXOtJoJ8uyIJuPObZ7humazzVB9Dj+Zu8CI2TN8ap4PFu9MMqh8uypK0EMiZTr
 uRPw9C3ZvFz4i5Qs/lsMz7nR4n0mR/jzB4nPuUmrbKhvzsyZe9q5PS/zdVeSSH4Lljqf VQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cmuc9wqd5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Dec 2021 01:43:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B11aJTk094999;
 Wed, 1 Dec 2021 01:43:46 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
 by userp3020.oracle.com with ESMTP id 3cke4qtutp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Dec 2021 01:43:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoifhGT4o9U62UwY9orXZsqak4ZwJuyOEIvduliWw1SCf4qcAGokstYkIk40Rixz3QxCa82b8cg0orR0aEJxCp844ZkaN48QDQ2RVCI+RLIe92zMvNIWWXdfPqnpJkXTNxEQU9BHYgbvTETxrF2Fg+4cW/zSdweDXEFbZjzmKdByjekWVhMbg0GGNOL9GrQZrQabltVMZEuC9wo99PpY1jqjCzP/72V7j+bqFpGn+Rcd1MzOxwKQvVBELHWJWYGY26nT6JvK+mwEFyVsDS9pYKKjfH0XtwPjQ15BArDlOypeugJPu3bmNefjsm2gRGb4UjgnzlOG8pqDEQ3MMWKZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8fyTM4qF086qWxDRafe6UVK5VggDl75a5SBq8w5+MI=;
 b=DjuZUluFHyF6pcO6hfxWqDODHrXuqsLIVhQhnolQ6MuylQprDB6HUT9PGzfineNO+1oKcL9T8i3LMfztsFA1S6ec34sszMVWzitWiBjmda//5+1QgX7sdT3ypGv+hZpP60j6IoZ0cOL6ObOlmanXkKIa7gjb2UG6uw1PiubRfil5BNor8jkDwhCNwLC1ls1/CdLyRxU0ME5dtBTQ0TKROXWxkKtXTINqkr78/o5OyoI/5Q9Rysz3geUaxMqKWrp0AEcqNO2SY64xG3uH+MUIONiTvV1mOTXwTYQ18Sg3TVlG0A1Db1N3XrOJmfUCns6MrYHKBhkJucUSKIAEAFAz9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8fyTM4qF086qWxDRafe6UVK5VggDl75a5SBq8w5+MI=;
 b=jtOciZoO0wRRHDjCu2dyHXx4bf5wGrluhlQu7t/jJLQQ2veFoCJUZzuZ/i3J14LAp0hUDAeD9N1vcrIgxaQRqEGrj68aFGNswQ2AGbMl8DJPVcdy0habsgZ9OU4oByrL+l+aKLGeecGZLMKOOvtsTAyZCkCQbO4Vjw6QkTNHdBk=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB5743.namprd10.prod.outlook.com (2603:10b6:a03:3ee::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 01:43:44 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::89e7:42b2:b226:2182]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::89e7:42b2:b226:2182%7]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 01:43:44 +0000
Message-ID: <3f4b29f2-cd45-5361-6d32-da10bf83ff7d@oracle.com>
Date: Tue, 30 Nov 2021 17:43:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] vdpa/mlx5: Support configuring max data virtqueues
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211130094838.15489-1-elic@nvidia.com>
 <20211130094838.15489-3-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211130094838.15489-3-elic@nvidia.com>
X-ClientProxiedBy: SA9PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:806:27::19) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
Received: from [10.159.158.73] (138.3.200.9) by
 SA9PR13CA0134.namprd13.prod.outlook.com (2603:10b6:806:27::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.12 via Frontend Transport; Wed, 1 Dec 2021 01:43:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f496b700-72e7-4fff-bbc2-08d9b46c0250
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5743:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB574307D5202E79666FC2213CB1689@SJ0PR10MB5743.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5XYloQf+Mpp7lIgi6RI6a2fkzzGk1lGzxcLpzzyEc6V3LtIt0rLT/AxloMF4wzo5MXXHJOkuHGJ+Cil8G7MKtKxFGyBpTmgM0GDfCgor07hlDOTMi1W5K1CeVxIqeDFBAtDbgUty0asux6CzGuIfZoZ4PCAncvbua9OYzaFTTyOGUsdBgHqRKGI5YF8v5ru1uobe+psLypq2+X5aurwkEd8oRmU1j4pyTNvFqGtnI20T7AENPHnfP0RC/BZRPRdurZ++hN5ez/LxSdxsOJ/xwA9qwwZ+ry8ANS6vYHcqZIgOjP2+8lklzdHf1yoZ4KNgtZxDYwWv2MnYGNv5pKqVgruG1523UzCz0TtBTojFT7cchbi/DtRrEkq9mbHu22LOT1eaGs27qgHWvW0NxP3k7TjoTK9vpFn3TXeoWHj0StZ6fiwqpPxU4Qzwoq9iLqBw8ap61Tk+9elbY7tnrOFloC4EEsLGnH3FhEcVLApJpeWr1EKOfgI10AqP1CX2laJRcGPle+f8Nx3GnL1tk99QPXxgQ4g31filpkqyIRbERlBVol5kRQ5bN/c33DKfKyXsmHgFESeZ/EjoflsYKg/hRMBM0oYkJgmjXa0ov1Nn52HYEeO9+m70fZvduPYjrsHyMuMvLZHqXQaZ+mT/a0NHXFKqNYCUy3brUzXe8x7IpqR/BMPU3xNDhpcdRnVc4XekwrqwgYc29Ouh+j1w96wIIL9GtmTTybfttiI0v8SboKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(53546011)(26005)(66946007)(86362001)(66476007)(956004)(2906002)(508600001)(66556008)(31696002)(38100700002)(16576012)(6666004)(2616005)(83380400001)(31686004)(4326008)(36756003)(186003)(8676002)(36916002)(8936002)(6486002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1huN3NQU1FZaTI2aS9QK0E5YzNVZVYzNGo4OGYyT3dzV0w2Tm9nc3lZb01n?=
 =?utf-8?B?VUJXbDlpcDhXWTl4aHN2cHIyMm1vajYxV21rcS9MN25LVk5wT2RQblBtdW5p?=
 =?utf-8?B?NFF0a1NmbW9ZVVBicmIzU3BwQjNRMGI2bXAyNWdPL2JKU1FETUxOOWh5RERn?=
 =?utf-8?B?NGllWkIvcjIwN0h4QzZUdS9INnc1YS9FbkJaWVJnaDdyU1MrUzVmWnlreTRi?=
 =?utf-8?B?OVRWSnA3L1kwcENZNUJKaGVXZDBxeDM1Ni9QdmpGTiswSTRlWmtkc3AzZ3By?=
 =?utf-8?B?VmlMbWVhUjU0NzdXa1kvdUFuVkViUzF4c1FIb2VMV05qTkFDQklkd0NEd3d2?=
 =?utf-8?B?Z3BjTGprQmJjOFBJbk9qVGRaQld2bDcwMmJCNUxISGdyclo3Ti8wc2xIZFFt?=
 =?utf-8?B?dWhYeGJDRkpHNmI2YTQvOEEzZ0VqU1FuNjl6S21GUldudVMzYTFQbS9mUDNU?=
 =?utf-8?B?bXZLS1NkdG8zdWloMWZodWloVWQyWUVmc0dGTmVQdG80M205eUh3RUNwbHh3?=
 =?utf-8?B?RWVhaHVPQmRWSHQrMStDbm9rektNUURvTXh6RHlIODZIUjh1a2hZMzAvbWVi?=
 =?utf-8?B?ZmYxTzYzZmVRTFplMVFDcG9rWVlmL0daeEo2cVZ2Z3hzeTlBS1NLU28xclpM?=
 =?utf-8?B?V1EvbTJGaEt0OU9iekxiUmVvMWEyWEtTaHk2VVEwcTEyOFQ3MzFMWStKbVhE?=
 =?utf-8?B?MDZ1RCtQU2twbldWVllrUytROEYydmFoNytaNWFNaSsrUEVId1Bac1pkcDJa?=
 =?utf-8?B?ZUg3RDJnUy8zQ3lyZEp5UzFRNm1ZMUpMUGVKWnp4L1JJSU5IclMvNVlocEp4?=
 =?utf-8?B?YjBjeVcyYlJBN1BlR3MwbXNpc0FEZFo3ZlJ3TlZINFBsSnd4andoTzFnOWdm?=
 =?utf-8?B?c29hY0tDRTZMOHEvNkxPR3VjZFIzR0wrM2pjNHJoWFR2R1B0b0kyQ2Rsc0R3?=
 =?utf-8?B?UjZvQmUzcUdlNittTjFESFkyaW9TRm5IbHBTLysyY2krMkltMUhDZnRQNXU5?=
 =?utf-8?B?dXVndTBpdkE2Z3BXZFdKUUIvVDZCWkpHaG56aEdvQStoRytPalUwTlRCeERX?=
 =?utf-8?B?dU15VW41SUFFRXhOQ1ViUmt6bDQ0UVEycm1waExrcWVtWmNyWTlPcjZSZVpx?=
 =?utf-8?B?WWxGNUE3WFI4NlFMTDVLZWM2ejlKRVQzUlRINFVEb2hUYTUwT1I3d1lweC81?=
 =?utf-8?B?dE1ZZzhUQkVhUm5EeW1jeWpPUHV5czhka3kwRmFqaDhzRnBPT2J3Z202UlBo?=
 =?utf-8?B?bEZXVTFqd0xiU00xZ2wyVUFwUDhEMDlDTDM4c3Z5MHJGZkFxZXNKc0dta0ZS?=
 =?utf-8?B?UUpOeTd6a1AySzUwbHN4UExTVE5XWlovTUp5M1JDWjVGMVI2djBMQU1OZm1y?=
 =?utf-8?B?MjZUc0lMQmRQVUtHVFFpSkJaUlFtYTZzSWdqNmMwaWQyTUFzZlNvajBKWXhX?=
 =?utf-8?B?eHFtREdJZE9LdXloNDZLUmE3SlRxS1RaakwraElhV2pYbUtCdGphMUJiUGI5?=
 =?utf-8?B?WFNRa0MrekI1eHh1SHdYVS8zd2RWRm85WjIrS0pnRWRrRWxQWHlrMmt4YzVt?=
 =?utf-8?B?RFUyNGk0VEYydnF0V203WHUzTHgxU1dBcUFsd0xTa0kwTFVJMytZUkg2VEV3?=
 =?utf-8?B?R1VvVndxUjI1L3B6SnJEZDZsSkRDVHV6S2xIdmJlSjl6QXo0Si9PaEcrdVBz?=
 =?utf-8?B?MktrK0JKSEtteS9LMkVEcEZIS2NJWkZsSy9yTitaWnZuZzV0NlZLWmloV1Nv?=
 =?utf-8?B?ZHNIS0tuV3N1aTdOUkxBMFMzb0x0QXVjQm44Z1B3K01OSXcvM0pqejJxKzJZ?=
 =?utf-8?B?K1JtaTBUakVnTnJ6a1ZTNG80K2hDRUVoTGZqblBaWFR4SmM2aWI4Wkt2Lzc5?=
 =?utf-8?B?N1QrYW9zZHF5aHJRR3RWNENXNDltdUlNQkx5NSt1NDhWb2Vrc0tSSlVTbWhY?=
 =?utf-8?B?Rjd6cTJQUVFBVjE5b0hsTnBMT3RjYW02Vm1ETXFXa1ZvNzFXM0lsZWRVR1l4?=
 =?utf-8?B?Yjl5a2Z1UEZrQTNmRk96WGszdGxpQ1ZiYzM5TTdPL3VKUXVOT1RWbUxZM1Zh?=
 =?utf-8?B?YmxKZXhwbWpjMCtZWU1TV0RMMkR2bkk0ejJ5blhrdmdYaGtodnNSZDFSaWhl?=
 =?utf-8?B?dEJ3S0ZtMzM3NGNueWhNQVo2cERQM2UvRkd0NWQwdUpvNFhmZEdERGFUUUZZ?=
 =?utf-8?Q?k2+1Acim6IENzh+RlZEmxQ4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f496b700-72e7-4fff-bbc2-08d9b46c0250
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 01:43:44.0057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcE2VNr3FL9FNpx0tYhSKXJ3vaeJE5tMCy9MK/UOItH7yTTHR/4gqNWPygUi3K+SethBSl++H6f0vWVEbBGjTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5743
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010007
X-Proofpoint-GUID: K4CKJfEj3RwwjoUhkktDDIS0Q84ZDAAq
X-Proofpoint-ORIG-GUID: K4CKJfEj3RwwjoUhkktDDIS0Q84ZDAAq
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



On 11/30/2021 1:48 AM, Eli Cohen wrote:
> Check if the required number of data virtqueues was provided when a
> adding a new device and verify the new value does not exceed device
> capabilities.
>
> In addition, change the arrays holding virtqueue and callback contexts
> to be dynamically allocated.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 32 +++++++++++++++++++------------
>   1 file changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 63813fbb5f62..54e276e0df18 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -131,11 +131,6 @@ struct mlx5_vdpa_virtqueue {
>   	struct mlx5_vq_restore_info ri;
>   };
>   
> -/* We will remove this limitation once mlx5_vdpa_alloc_resources()
> - * provides for driver space allocation
> - */
> -#define MLX5_MAX_SUPPORTED_VQS 16
> -
>   static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
>   {
>   	if (unlikely(idx > mvdev->max_idx))
> @@ -148,8 +143,8 @@ struct mlx5_vdpa_net {
>   	struct mlx5_vdpa_dev mvdev;
>   	struct mlx5_vdpa_net_resources res;
>   	struct virtio_net_config config;
> -	struct mlx5_vdpa_virtqueue vqs[MLX5_MAX_SUPPORTED_VQS];
> -	struct vdpa_callback event_cbs[MLX5_MAX_SUPPORTED_VQS + 1];
> +	struct mlx5_vdpa_virtqueue *vqs;
> +	struct vdpa_callback *event_cbs;
>   
>   	/* Serialize vq resources creation and destruction. This is required
>   	 * since memory map might change and we need to destroy and create
> @@ -1218,7 +1213,7 @@ static void suspend_vqs(struct mlx5_vdpa_net *ndev)
>   {
>   	int i;
>   
> -	for (i = 0; i < MLX5_MAX_SUPPORTED_VQS; i++)
> +	for (i = 0; i < ndev->mvdev.max_vqs; i++)
>   		suspend_vq(ndev, &ndev->vqs[i]);
>   }
>   
> @@ -1245,7 +1240,7 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>   	int i, j;
>   	int err;
>   
> -	max_rqt = min_t(int, MLX5_MAX_SUPPORTED_VQS / 2,
> +	max_rqt = min_t(int, ndev->mvdev.max_vqs  / 2,
>   			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
Here the user configured number of data vqs may get silently capped to 
what the device can support (up to 2^log_max_rqt_size). Do you consider 
expose this device specific capacity to vdpa users so it doesn't get 
blindly misconfigured, and/or return appropriate error message to 
indicate the failure cause?

If mlx5 vdpa really can't support power of 2 number of data vqs due to 
hardware limitation (?), an appropriate message should be returned here.

-Siwei
>   	if (max_rqt < 1)
>   		return -EOPNOTSUPP;
> @@ -2235,7 +2230,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>   	clear_vqs_ready(ndev);
>   	mlx5_vdpa_destroy_mr(&ndev->mvdev);
>   	ndev->mvdev.status = 0;
> -	memset(ndev->event_cbs, 0, sizeof(ndev->event_cbs));
> +	memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
>   	ndev->mvdev.actual_features = 0;
>   	++mvdev->generation;
>   	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
> @@ -2308,6 +2303,8 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
>   	}
>   	mlx5_vdpa_free_resources(&ndev->mvdev);
>   	mutex_destroy(&ndev->reslock);
> +	kfree(ndev->event_cbs);
> +	kfree(ndev->vqs);
>   }
>   
>   static struct vdpa_notification_area mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
> @@ -2547,13 +2544,23 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   
>   	/* we save one virtqueue for control virtqueue should we require it */
>   	max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
> -	max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
> +	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
> +		if (add_config->max_virtqueues > max_vqs)
> +			return -EINVAL;
> +		max_vqs = min_t(u32, max_vqs, add_config->max_virtqueues);
> +	}
>   
>   	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
>   				 name, false);
>   	if (IS_ERR(ndev))
>   		return PTR_ERR(ndev);
>   
> +	ndev->vqs = kcalloc(max_vqs, sizeof(*ndev->vqs), GFP_KERNEL);
> +	ndev->event_cbs = kcalloc(max_vqs + 1, sizeof(*ndev->event_cbs), GFP_KERNEL);
> +	if (!ndev->vqs || !ndev->event_cbs) {
> +		err = -ENOMEM;
> +		goto err_mtu;
> +	}
>   	ndev->mvdev.max_vqs = max_vqs;
>   	mvdev = &ndev->mvdev;
>   	mvdev->mdev = mdev;
> @@ -2676,7 +2683,8 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>   	mgtdev->mgtdev.ops = &mdev_ops;
>   	mgtdev->mgtdev.device = mdev->device;
>   	mgtdev->mgtdev.id_table = id_table;
> -	mgtdev->mgtdev.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR);
> +	mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR) |
> +					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
>   	mgtdev->madev = madev;
>   
>   	err = vdpa_mgmtdev_register(&mgtdev->mgtdev);

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
