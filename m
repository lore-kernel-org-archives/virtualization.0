Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A428C433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Dec 2021 23:59:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3BAA60B60;
	Mon, 13 Dec 2021 23:59:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R4z5sFZrHrt1; Mon, 13 Dec 2021 23:59:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4782C605A2;
	Mon, 13 Dec 2021 23:59:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F353AC001E;
	Mon, 13 Dec 2021 23:59:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DC1CC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 23:59:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F28CD40361
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 23:59:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="noUWggT3";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="b9Iz7Oc1"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sQ8Ped68BFuw
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 23:59:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1BF5F4018A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 23:59:51 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDLHvo4004117; 
 Mon, 13 Dec 2021 23:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=B3BPtLdFvb4Z64HaKDtpLB5y0Jz4yrabXgg+pJd08Fc=;
 b=noUWggT30kYr4fR9wtVzD7Joxko6mjJNBJas37a8EsEMpbLAYiY0cxRCmYMCeXEIIoad
 rWUG8h4/MhIN5bQlvoVOjQn/tQys17oGzh9CZlYdwUWzTu2y9qMHRw4AJVPdZ5JNvbVe
 mjpJYZN9Aw1VCA6M+EhdECtbTzbeO9DifqJ+RUn10v/ST0BqCUrGC1/NiteoHXO7AQ6N
 eWdOitqB1WcohfhbJdKf5Vno/0E+iym7RiTfWgD/Bb9xH4PqCHBzjvFhwnSJx3RhCc4Y
 kpzXJ+4ywcwhq2Hu+3oEjvWtI+BW5SG/qMFqz0BnJ4kxwCsphzCZiz0eZ1ekKKA6TSD2 Lg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cx3py296d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Dec 2021 23:59:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDNuR2D124114;
 Mon, 13 Dec 2021 23:59:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
 by aserp3020.oracle.com with ESMTP id 3cvkt3qgvd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Dec 2021 23:59:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eivfoq8/5FsGUhcQPnM9H/FuB2bU4eb5AaJ/w+5A1WlMXu0B3pSZNrNWzojf3Zfob87LCXPdhbk+DnZSR39+x1m9AUnTMyYtzKJFUCBr/13Sbkz2IkbusIFoMWBiu3hC+8lJqcdR42LYbtTp7Q2ZLWiNLmMl1SmRKmHNwRsZa3e7ntEw/PQ1jiSSMbTuTjO+sFgiPyooHjauU2APQNg/ivvpR/2e7BVN2RDZ7W3P7PAEPs9IZF248roF7R3LH26daTQYxV1PKGsJVCUX0JVtG5w77NoDH52daY+gqAVAjjPVoT7QkZyu9V/MDWmurgj9h02OGQ/ny3BSN1nodHcATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3BPtLdFvb4Z64HaKDtpLB5y0Jz4yrabXgg+pJd08Fc=;
 b=QQhmUuY9zhfpERECbbXDyhN9S2GPI86Ghn2Gs9ELD0xR1YJjN2ZG8Hx2if0r6aKm8byIqlar3fUnqmKIQhk8nynswhkG6cbTVIOueEyRjgD8XNyRy4gNkCLEO3Y4AN+PwfLzp9WJGWdrrUNb9+Bz/98bgkhcCUL291iFe8tEQCo5ihFRAhSqEsprVYeeTQ826NLtaMR4kQfB09UhZCpI+eEAcVQQBjY7kUpqxd2iXQPpmrSDJioUwL/f6uf+R5xC7BS+81ko8quPE7aIGVpWOVdJ9ytYwcwS4AcE0f+u2sCtFWfeZYaMhQBmVXfbJmPvBufKc9giLWja2DTvN+i9Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3BPtLdFvb4Z64HaKDtpLB5y0Jz4yrabXgg+pJd08Fc=;
 b=b9Iz7Oc1P4ALViEkq4u7XiDRIZayLt7OrAbpq/wfc1/wlAyouOW//tncFVEuUKhB7XYOwL8viM6zTbCpvp8GKgQ8ESg629+OliV2qEejf07mse9VF417kQJV9rmlXzpElsff4P39k7DHcOP1MRtDmcarpFyeoFDtNE0bh4OKARw=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB3480.namprd10.prod.outlook.com (2603:10b6:a03:119::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 23:59:46 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 23:59:46 +0000
Message-ID: <9c4aa370-b01a-dca6-78e1-ecacb33635b9@oracle.com>
Date: Mon, 13 Dec 2021 15:59:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 04/10] vdpa: Allow to configure max data virtqueues
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211213144258.179984-1-elic@nvidia.com>
 <20211213144258.179984-5-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211213144258.179984-5-elic@nvidia.com>
X-ClientProxiedBy: SA9PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:806:20::13) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b4553c3-0a95-4975-eb4d-08d9be94a3ef
X-MS-TrafficTypeDiagnostic: BYAPR10MB3480:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3480E46B40225FFD9AE03FCFB1749@BYAPR10MB3480.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z3aYLf+RysAbts+Xjha06J3/G581iJ9hK29nu5+tuZUVqpmElHmbkCQJyW3G/E3BbdMfaYMLEUZ70RWiKapf932yzMwzC44sAmDwUmQJET6BnTef8Ned2EfyXNz21bGuFi1Fm27ZfFVgdCmWMHYq+dfAAgE6k1f4ux76WLHcfnEBYXfFVRQIz/uTV7YtuQSNNie1YzxwYsOmgv7VEBU6neTXYNh08AJ1daNjwzPv8rY/TedfawUetJyP3T2ZLjsOxNeAHHl0GMK6e7g6dIaUkZeKnQPyA3fzSgR8hJvlge+I3hRpfTEnqjWIWOWeuEFhIN0+yHRNIBQP5Xa35g7yf+qs/iyzydKO7WxiTE5JZgXUXWz1GFbg/Ir2n6/ktikb6pnwkYAG+/baV7u3h+/uCpgEuVRFZjEbXZ5yf+vm77ealyHHt6EPUYMbXj4is9uDfTOUELBQvtpu2KY/Mwh4lg5e1CajKpfQH/SqgjJGJqJhf3G9OlNpp2CoxlXe/uilkImHguJGN2LAdPPVzBeosJmu17qB4wBcDfDIR2/QVVvexDEJRVEpVtvXaLWKe+teVbu77Cc73HTgptfLFAUqDyHrnEYuyS4yKuykmzG0YCev5QC3uIHEgZ+v+tKpfB682smj1cHCXSl0Kxs2a9Yj2naAK1NSKjWfLCGcohyGZ0yzS3oE9kvt+AA22nqV2J3MWlmPSO98bFbwtlaGW4o7kpf0savZYL5d0gO3cfkUCQ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(8676002)(38100700002)(2616005)(31686004)(5660300002)(31696002)(8936002)(86362001)(83380400001)(508600001)(316002)(186003)(36916002)(6666004)(36756003)(2906002)(6486002)(6512007)(66556008)(66476007)(4326008)(66946007)(26005)(53546011)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW5XR09ubmIyWDM0ajI3UzB5RVBKeFdZa0JlZndxR0xxakR4NTl4SmREWEZm?=
 =?utf-8?B?b1NaNEN2MVdGWWdUUlpoaGdBWHN0c3pDbG4ydHZ0VTJaWUlSVEVDREw5ZFE1?=
 =?utf-8?B?MFl6blJCazBNd0x4S3E4ZzhZbWJDOVRDZDFhQ05wL3NWUnhQVVBPK3U0ald6?=
 =?utf-8?B?NWs2VzFyaG52UkZYKzBEMFlQcEM1TlBUbDNCWnk4ZHlyR01kakJ3b0hUNXBi?=
 =?utf-8?B?eCtTTi9SOUQ1Nk9iR3hVYkpmdnc1dW9aa2JFNEtqRWZEeThxNWhFUlNXMGtX?=
 =?utf-8?B?czN3UTVRcUVlVXhSWlMwYmpwbUxkY2VCWndienM1RWVOb3BHeTY3UEp3VVhE?=
 =?utf-8?B?YXIrbFdISEVyUVhLaEF1dnVDWHlicHp6UjhZM0ZVNm1sczI0aDhpTHY4T3FP?=
 =?utf-8?B?N0xMQ3JIcENoZXYraEtHNVM1YUo0UlQ5aFdMTnFxMitabWpTK0ZPbkUzekNo?=
 =?utf-8?B?WWwrZklkcFdUeEJoU2VhbWFPRVRPREJKUGlwUFhKU0VvUHN1amtMc3RwTXBL?=
 =?utf-8?B?NkVwbk1aOS9qeGhXeXNVMWpkck16QXM4Vzh1TFpFYjZZWUNTQ2xLdDlNQWJX?=
 =?utf-8?B?bUo2aFNFbDF2ckxLWHp6WGhRaDRxcjZybTRHMWZQM3ArVE56MTIwcEZXZk12?=
 =?utf-8?B?aWZESXp3T0FsTnNza0xUQ2dtSEg5UkpDK3I1SlRjOEI0aVh5eHJVWVJGRFov?=
 =?utf-8?B?U1dwVFRoM2Ryd1A0MGt0NUJrQ2JraDF3dFIveFA1cC9OMHRIazRKTGhNN2Y4?=
 =?utf-8?B?UlVHd1M3S21IVGI3TTY0cFUrUWxnQTF6ZVJxY2RkUUdUSFNUTWNYeVpzalBJ?=
 =?utf-8?B?dm5wZ2RCSWREa1o4Q2cwOVZDM0hhTHB0MnhzaEcrM0VIWGQ4QjJGU1BDTjE3?=
 =?utf-8?B?LzNLU2xLRzc1ZTJmT1JYOXhxUnpBT0oyM25XbnNUUVFFTFJvZSs4M0wxMGFj?=
 =?utf-8?B?ajhYb1dya2JVQ3NtTHBoRlhlY05JVGZPd3ZJb1VFUDBGUkwrODdkNnZPTmxv?=
 =?utf-8?B?Y1RTK0Q1MThmamRFU3NCZElPM3J0emMyYk5kaUZZNCt2QmRpdUx1RUMwcS9q?=
 =?utf-8?B?Q0wzSmNEcmx0amdHVkVHdmRlbjJqd3RwTTNQOThwaDgvb2JMMFVlbXhMemI4?=
 =?utf-8?B?SFp6VnpXbnFVbDB5WGwycVFUcFovOXZmbllmMkV4eVVSeGRZRTk3R1JobWoy?=
 =?utf-8?B?NmV6NWJ4a25wZ1gyZXJheGZNSXJxT1dOeXRWUzIvRFVTN0tUZHBnM1N1SDBS?=
 =?utf-8?B?SFhvMzFmYmFNcXc0NmVWSVFaL1Nqb093Y05hWXNFd3Nib1RIWGxmUG5PK1dL?=
 =?utf-8?B?WkVjdzlnNytRdXd3OUN5TVh1Rld6cHVSTVdDdk5wZDZ2VmJQYkQxbXdUNjRO?=
 =?utf-8?B?ejA1c1FxNXkxZ3hyRGR3T2FvejJaWXR1b0xxK084ZDJubEdTTlpPVllaM0tF?=
 =?utf-8?B?RERvdXhTVktYaG1KbWRiQzRGblZsQUdMU0ltNWphVVBFbkphcFhvMytCVDh4?=
 =?utf-8?B?ZGdvOERZbG1nUGZmazVMWUN3SVYxU0hFU0xxK0p3cEw2cTBHZDJmUC93L3Vp?=
 =?utf-8?B?ZWtacmNPVnBBK0lyU29waWF6NnBkU2Vpc21rSjY2VjVIWmZnQWl5RzBZczZr?=
 =?utf-8?B?MFdyODRzS1pndm5jdWRRMTJ6VUdoYThaZkhmWlVLRUFwRWhXbXFxZzZ5NzJ6?=
 =?utf-8?B?ZXJaYS9GeWlIK1lMaUQwYWlMLzR0Rk5WNkgzc01Kd2pZaTdKV21tOWlvdlRM?=
 =?utf-8?B?NmU0U2xiZmRXYnk1c0RnZWxwSlVMR21aQlV2R1RQTEVOc1l1YlZqalRIdWVH?=
 =?utf-8?B?UFM4SlJVOE8wbE5MK0laelE0em5qOUp4a25NMU94NkF2UUFaVWJONkE0dGZl?=
 =?utf-8?B?V3VzME1DOVZOQnFpcXVvS2VJWmgyWVc1MWd0N0IwcWpaYWlFUFg3R3dDanFl?=
 =?utf-8?B?TEZOM0NXbWRVK20xQ3ZpblZ0aUZzaktpOTM5ODBIcnBkeEdlL2RFaFBiMjdV?=
 =?utf-8?B?S0QvSDRkYWRFQnozYUhLa29KemdsbW9PWVpZWUxhWUlqMDFzTkxZM042cHVY?=
 =?utf-8?B?THNlaHFLOWhSQXZ3RTk4elh6aFRJc2dYNVZ0ZHYxcWFpNFdLYnR6TzBnQTBj?=
 =?utf-8?B?NzdUdzFid2pJa2J0OWtiUU56VmlXaE4zWEdzN0ZhZGtPRU9aaVV0MnRFS1ZW?=
 =?utf-8?Q?I6jl0fKDbCqp/TQs9U0BMls=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4553c3-0a95-4975-eb4d-08d9be94a3ef
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 23:59:46.7294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhEHORRcY49yFanRGbRLRu1K8R8ZUSSsJyew3cjitnqb3sv+uQNhMoPnOImgdLNio7bhzZnACKzjPTN5v+eLvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3480
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112130140
X-Proofpoint-ORIG-GUID: enGiLdbEgP29QLZwNf6ycQY9_ZDxdnLE
X-Proofpoint-GUID: enGiLdbEgP29QLZwNf6ycQY9_ZDxdnLE
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



On 12/13/2021 6:42 AM, Eli Cohen wrote:
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
> index 5749cf0a1500..7b7bef7673b4 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -555,7 +555,8 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
>   }
>   
>   #define VDPA_DEV_NET_ATTRS_MASK ((1 << VDPA_ATTR_DEV_NET_CFG_MACADDR) | \
> -				 (1 << VDPA_ATTR_DEV_NET_CFG_MTU))
> +				 (1 << VDPA_ATTR_DEV_NET_CFG_MTU) | \
> +				 (1 << VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
>   
>   static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
>   {
> @@ -581,6 +582,17 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>   			nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]);
>   		config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MTU);
>   	}
> +	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP]) {
> +		config.net.max_vq_pairs =
> +			nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP]);
> +		if (!config.net.max_vq_pairs) {
> +			NL_SET_ERR_MSG_MOD(info->extack,
> +					   "At least one pair of VQs is required");
> +			err = -EINVAL;
> +			goto err;
Should directly return -EINVAL, vdpa_dev_mutex is not taken.

> +		}
> +		config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
> +	}
>   
>   	/* Skip checking capability if user didn't prefer to configure any
>   	 * device networking attributes. It is likely that user might have used
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 9cc4291a79b3..9245dfbf1b08 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -101,6 +101,7 @@ struct vdpa_dev_set_config {
>   	struct {
>   		u8 mac[ETH_ALEN];
>   		u16 mtu;
> +		u16 max_vq_pairs;
>   	} net;
>   	u64 mask;
>   };

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
