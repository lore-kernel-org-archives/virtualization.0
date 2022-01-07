Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A399C433EF
	for <virtualization@archiver.kernel.org>; Fri,  7 Jan 2022 01:27:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE8C24299C;
	Fri,  7 Jan 2022 01:27:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id smCw23e8sVj8; Fri,  7 Jan 2022 01:27:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 07D4341545;
	Fri,  7 Jan 2022 01:27:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0808C002F;
	Fri,  7 Jan 2022 01:27:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F176AC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 01:27:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CBB3183005
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 01:27:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="SVTcVVom";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="XOrfDpmk"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CrugGcecD_Zn
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 01:27:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8598581D9F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 01:27:46 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206KbYig016731; 
 Fri, 7 Jan 2022 01:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=lhUh6pqm8IdXdmdVEzioRHwKp/z7T4bbp21wNm0ZUm0=;
 b=SVTcVVomIksHZ7n66UHi08kEQVTiHau3j3v/jJhrJ5u23Bwln+ghFENL51v9AH+5+SII
 taRjmTv7sRpkybReENufN/83qo/9UixlEbmMcuWDaLYPKDOhqEqtWtD8YjQiAWTY3ISQ
 CXQUv+WsPBTJK6yki3FtEhiPPunXPwS6tP58i7QhIV5kUwGx1PU40GNOJS50PS888twR
 lK2VfgtD1c8HVx49CD4+OkJzOQVjtP1GWkD1FXqWalZQdB5JCft+Cen90t3oR3ue/+Nw
 wbHZdHpcUK9Ry0NSpttvEvXQFeMCmuu9vboFiEFpxrN3BCDNOKzjPVje3v4FR+A1na4B JA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3de4v88wmp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jan 2022 01:27:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2071Frqh150217;
 Fri, 7 Jan 2022 01:27:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by userp3030.oracle.com with ESMTP id 3de4vwxpdj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jan 2022 01:27:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eomGNw3uyhbLjeHP1s42ZgeyZEVQYb1E4dHtfDhsMCzn7htNQDD5urX7cMgGCC8z0hEl/uEZfhq12fyK1e7EpvUZHevre2RLKNu8uuQmWkI0EvtLAsQ3Er2phcMSJQ/EH2orx1OqDthj3lIweFA4Y0GVItspvSJGkaBPHKJwpIMIZjkEdeqV+OAAHp9fA7kgSiMfnahuRLE0GJBd0OXqR1DfiprsNyIrpu1WJSjaT9Rr76+zh+MV4OZTQjOWHip8L8jthSYhRY1N5SFm68yDpvKU4wHmKaEUworT47UkKugH1MEDsu8/9z3/CSJvN/rrVbs/D1O3oCGP+ILLoWfavQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhUh6pqm8IdXdmdVEzioRHwKp/z7T4bbp21wNm0ZUm0=;
 b=eVDX5BcGj9hiJ/aAUHU00tRzwCIRp4v2YeuLJCmgoKFFrEXlPhc6vXnpMd8A7nmnS5Gka4G4YLI+zkAvudGaBbhiuGxLMzGLjzjo1wKU+qPOim6EHf3Eok0t/zorUd0YdrbAHdBaubmxvxSJ6w9tH87mEqjn6CEs3EBk1lWljxghP95wxSrEGZtp7Kde4rTvAdtJRsTgeLILqubDRtj8UTwWQ23+gHVCJl0Iij2P2pUKm0X2H7kwQcFyUACo89RWs7SxxbaKTOlJo5/3sW+ASj6gk8NOGS/eSvlWt3AKg07OXLNtOo6Q9LtpIVqRYxUx13AlRedR44RgVeD8noolVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhUh6pqm8IdXdmdVEzioRHwKp/z7T4bbp21wNm0ZUm0=;
 b=XOrfDpmk2+E6Y+w1XK6dgJhDzfsZsLmnF6I9W8uZ7N2pHGdRRqgpS96/9YktTX+9+JSK781ShFLk6Is3WaEljZvn2Hb+JrSTDdppleZFi4jLUPwu8jd3gJQfLcqlJPRR0tUr3/O1ek0LvRQBnIT8xRDOZ+wszA1YnH9Q43GZD3M=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB3064.namprd10.prod.outlook.com (2603:10b6:a03:8c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 01:27:41 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 01:27:41 +0000
Message-ID: <99150f0c-6814-a0cc-8640-aa8014af6ed0@oracle.com>
Date: Thu, 6 Jan 2022 17:27:35 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v7 07/14] vdpa/mlx5: Support configuring max data virtqueue
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-8-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220105114646.577224-8-elic@nvidia.com>
X-ClientProxiedBy: SN4PR0501CA0104.namprd05.prod.outlook.com
 (2603:10b6:803:42::21) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b06dd72c-03d6-450a-d194-08d9d17ce5a9
X-MS-TrafficTypeDiagnostic: BYAPR10MB3064:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB30642B6BCDDEF697C3402EBBB14D9@BYAPR10MB3064.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I7PbkrRtfdVSboWGtb+RMbolGOpgvFHw8PtRFyg3VL20Jz75kZW9yyx0RPmFzFKG8m79O/M/soZrNnHXz6HBXEWxZBgCn294acE6M0dceKNbNEqnVoIOlALWkYTqYlyyD7QEeE+vROiq7hQNnfSzR2a8rRujAjszSYHbgqCBKF556qZV5FYF4/AV4SLYXnBVhkGnFFjuHNaucIGNWlNASVCZHKzYdg/A+PplkAxix3W8ago1hkmHgybujKxCRjsND5z0tPMfSv/a5vnv9VH0b0MkPpjgCFF3/GFs9+xU1dM1Pp3vfTkSsTMsRpICuXU1pwMgPB4VgjKZF6j8e5vKLcRtpr/+R1ySvUQJX4iA7rjmTDPus2sap45vEVuj7FGH3vaYDg1dDmBdrqxzVqQ9rQ7aXrQmFk5m0yUujx9iJ7XSE1x8WGW6xYt9qemi261vgglENhC6vwvCHloWZIPHwETynD8aTH18+ADe3zDEZxl+BIfHFAV+KyJUUqJU8EzPBP/CWBLGPCkU+TbOKz6bnuIlpH8weZ2m0vj/pGCTc8Ujm0FrAwXM00TVIXuacKVTc8c1GoSJ91RDD7Hu0gvMtmICIK4/Dy5sdJE7IV+NrvjN3DRFXoFmve7FLgITfb7aH+karlJfYL4JSd/BdU8CzRnWc3BeSL+kgLip8TVsRwhvWCjddfu2NKhpEIRtw3YBaL+/JbiQrJQVbqtp9VqSGzoMn/MLxpAW2ll3t/IbihU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(2616005)(38100700002)(86362001)(6512007)(6666004)(8676002)(4326008)(8936002)(5660300002)(31696002)(6486002)(53546011)(6506007)(2906002)(186003)(36756003)(83380400001)(508600001)(36916002)(31686004)(66476007)(66946007)(26005)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlBDaG5EelV5MWFFRGF2bllDRWY0UWtycWxiNENiVlJ2MDdmTTg2RTFNek52?=
 =?utf-8?B?SmpEWmZVWWw2YU0zN3FWM2JJMlQ1bzBvVlhaTGFGcjNYWXRTbmhlNjJHTUp2?=
 =?utf-8?B?eWs5TUF4TzcyY2hCVDBudENIaEVWb0NDd0pTREplQmtnbzNhVno1T3dzWkVO?=
 =?utf-8?B?a1pDZk4wV1JuQjdyVHlaZGpHNTVCNGlKejdzNFNoOHBvcUpnSW1RR1ZYT2dr?=
 =?utf-8?B?N01VeU85MWRBald3RFVwRkx6VXlWejF6WkpFM0lUWTBnengyblRxRmV0ekpR?=
 =?utf-8?B?U1Jnbjh0dCthcWdIVUdTdjVHSHJNWndUZTB5QlV0QzVtZEJJUXhBRUFoS3Er?=
 =?utf-8?B?NmFyVVlZcUVBMVc2UFJ0UVFCRWdoZWt3bkwrQy95M0F6ZFR3eTlMcUVKc254?=
 =?utf-8?B?ZithbUV1aTVFMEEvUGpoYTByK0l1akRDNEhyWXRReW1Qcjh2LzNJaUhEWXpG?=
 =?utf-8?B?RHBIRnB3cEhVMVk5bWxTdzhPR1BMSENWRE1DL1A1TUc2U3VlWnBoR3BFbGZF?=
 =?utf-8?B?YWRDOEJwUlVSSHNSaDAvTlFpMm81R3RheTB1N2sraW5sME9OalRQVGY3M1NN?=
 =?utf-8?B?NisrREQyL1VEbEVhS05VSHQzUXh6eHZqL2JtaEF4dnF5b2VESHhycFAvTzFs?=
 =?utf-8?B?K0VKQ3RSaTVHRlBnTGgxa1VvOEpSMHBndUlUUnU3RGR5dHU2cnNpL0JYejk3?=
 =?utf-8?B?VzE4ZTAzRkZjd0ZOTkVWMVBJU2N0U3JrUXJDTW0zSHkwbFB2cUJDMVNQSmRp?=
 =?utf-8?B?Y2FFQzZhdEdFTDhvN3pGWXdQdEhyQmJYUHR2YzlhWHloTllLSUdLNXViY2Ro?=
 =?utf-8?B?eDFsZi9aVEFFb3gveWMrQzVzYnBmMlNYQkErMjQwSzlLVVFOeDRXUHZXYlU2?=
 =?utf-8?B?M3FPckpHeG05dmk1V1l3akhpQlJNclVjRWd6RkNub1ZuOFJOU0JNQ3JnRGRO?=
 =?utf-8?B?bWl2cFM4U01wbjNkSUhHV3RxaHBvRVR5MENBZXU1T2E2K1pUYWhXeUFVMlRI?=
 =?utf-8?B?SnA1MkkwVXlNM1pjNitMWFFMbW9ISWR0UnNxOXdNQ0cxZXB2RytZZ1JQVVRR?=
 =?utf-8?B?bFUrdDV2eXpCMGkrWU1qODJtTU0zTDR1d3IzaW9LaXRRSVZSUE0vMHB5MWJB?=
 =?utf-8?B?bmFsWmhmbTZXWFlvZEFlOXR2Rk4wdjVVb2FOOVRJODJLS09zUFNEVWNkNjVT?=
 =?utf-8?B?ZSttRWFnMEZPeDduU2xuSVJ3QXhJVjhjekZDQ2NNNmJ6aFNJODRkS2dDc1Az?=
 =?utf-8?B?L1pkeFBUeUNmY05LOHlEVnpqOG1zMm55aFJOOVplSlJmSUxOQzEvcDZNblFC?=
 =?utf-8?B?NzJhMlYwWHJRbU9PcnQ3K1k2djlkeFhmWWZkRnZtd1pvMFdPMUo2QldENjRB?=
 =?utf-8?B?SDUxVHpCVVBUZjluYVphTVYxNGsyZlgxWUJiT0RJcEQwSlU2NTgxRVg0c2Zm?=
 =?utf-8?B?UTdScU5nNzE4M1pTTTBGdUFaV0JHTVVuRmc5WjlVVFVXbVhMNWFGdWhXaFlI?=
 =?utf-8?B?OTVDUi9MWFpaYU0wV21yVml1V3RQL0M2djdBNHNpSDB5SGxNZVRLbnRteTRU?=
 =?utf-8?B?MGtoTHNYYmRsSDF5bEdnT2hma2NTc3R6SUVDL0oxQ21EYWh2TWdLUEpzbnRO?=
 =?utf-8?B?RHVpQUpaYUpoUko2ZVcxampXQVViTTdWMzN6RXlBQkREZE5IVFdNOU5tZjVp?=
 =?utf-8?B?MTRaTE1PcDNONHdlMnZnaXZGUTFwUVFDcmJJM3ZLS1RKSmhMZHVWQU85YS9S?=
 =?utf-8?B?VE40ZFdzYVZPakZXK2F6RHRrVElqV2hYaTVRTlp5anBVTXVwaHlpeDBRcHlr?=
 =?utf-8?B?bE9aeG5hUHY5SUpDdkNqQWl4TXEyb2Q2N0pERWNDdFFBMkJYUkJTVExYYVNp?=
 =?utf-8?B?ckJLaEJMNElPVDlocTBXT3lqVmdKUHU5UWRPdUpNSTJoSDhnVlRobk9VbDFL?=
 =?utf-8?B?Q2tYaFpyWGNBZ2JZemM5bkdtb05XYVJMTHNkdnF2WVF1TlVjTWdvUWI2OVRT?=
 =?utf-8?B?QkE4ZFEvdTdjR3M5SWxVOWl0RU5KSTd1MFg2WExKd1RhNjA2aE5YUGk4L3o3?=
 =?utf-8?B?Wmh2QTdPU2N1bHhkcWpFQm1tNng0bG5Uem9PWDdIekh4ekdUM01KNUZ1amZv?=
 =?utf-8?B?N2k1K2VzL0FkZ0tCazBTYnN0aG04T2EzUG5MVytKRXE5d0pJN3d2VFZxQkRv?=
 =?utf-8?Q?3KgteKW/P+uUfMa4dVL/WlI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06dd72c-03d6-450a-d194-08d9d17ce5a9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 01:27:41.0616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQm6CISpVULX4wV6/oU6jCRTNqpHbyyoDjnq1fMQjG3bYX/MvOeIh9KoZEO42oTSlHmU7F83GairzKloL/ssyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3064
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201070007
X-Proofpoint-ORIG-GUID: EAO9FDCji2kO1EUj-LmO51taqSbyZz9y
X-Proofpoint-GUID: EAO9FDCji2kO1EUj-LmO51taqSbyZz9y
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
> Check whether the max number of data virtqueue pairs was provided when a
> adding a new device and verify the new value does not exceed device
> capabilities.
>
> In addition, change the arrays holding virtqueue and callback contexts
> to be dynamically allocated.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> v6 -> v7:
> 1. Evaluate RQT table size based on config.max_virtqueue_pairs.
>
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 51 ++++++++++++++++++++++---------
>   1 file changed, 37 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 4a2149f70f1e..d4720444bf78 100644
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
> @@ -1244,8 +1239,14 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>   	void *in;
>   	int i, j;
>   	int err;
> +	int num;
>   
> -	max_rqt = min_t(int, MLX5_MAX_SUPPORTED_VQS / 2,
> +	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> +		num = 1;
> +	else
> +		num = le16_to_cpu(ndev->config.max_virtqueue_pairs);
> +
> +	max_rqt = min_t(int, roundup_pow_of_two(num),
>   			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
>   	if (max_rqt < 1)
>   		return -EOPNOTSUPP;
> @@ -1262,7 +1263,7 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>   	MLX5_SET(rqtc, rqtc, rqt_max_size, max_rqt);
>   	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
>   	for (i = 0, j = 0; i < max_rqt; i++, j += 2)
> -		list[i] = cpu_to_be32(ndev->vqs[j % ndev->mvdev.max_vqs].virtq_id);
> +		list[i] = cpu_to_be32(ndev->vqs[j % (2 * num)].virtq_id);
Good catch. LGTM.

Reviewed-by: Si-Wei Liu<si-wei.liu@oracle.com>

>   
>   	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
>   	err = mlx5_vdpa_create_rqt(&ndev->mvdev, in, inlen, &ndev->res.rqtn);
> @@ -2220,7 +2221,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>   	clear_vqs_ready(ndev);
>   	mlx5_vdpa_destroy_mr(&ndev->mvdev);
>   	ndev->mvdev.status = 0;
> -	memset(ndev->event_cbs, 0, sizeof(ndev->event_cbs));
> +	memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
>   	ndev->mvdev.actual_features = 0;
>   	++mvdev->generation;
>   	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
> @@ -2293,6 +2294,8 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
>   	}
>   	mlx5_vdpa_free_resources(&ndev->mvdev);
>   	mutex_destroy(&ndev->reslock);
> +	kfree(ndev->event_cbs);
> +	kfree(ndev->vqs);
>   }
>   
>   static struct vdpa_notification_area mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
> @@ -2538,15 +2541,33 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   		return -EOPNOTSUPP;
>   	}
>   
> -	/* we save one virtqueue for control virtqueue should we require it */
>   	max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
> -	max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
> +	if (max_vqs < 2) {
> +		dev_warn(mdev->device,
> +			 "%d virtqueues are supported. At least 2 are required\n",
> +			 max_vqs);
> +		return -EAGAIN;
> +	}
> +
> +	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
> +		if (add_config->net.max_vq_pairs > max_vqs / 2)
> +			return -EINVAL;
> +		max_vqs = min_t(u32, max_vqs, 2 * add_config->net.max_vq_pairs);
> +	} else {
> +		max_vqs = 2;
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
> +		goto err_alloc;
> +	}
>   	ndev->mvdev.max_vqs = max_vqs;
>   	mvdev = &ndev->mvdev;
>   	mvdev->mdev = mdev;
> @@ -2627,6 +2648,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   		mlx5_mpfs_del_mac(pfmdev, config->mac);
>   err_mtu:
>   	mutex_destroy(&ndev->reslock);
> +err_alloc:
>   	put_device(&mvdev->vdev.dev);
>   	return err;
>   }
> @@ -2669,7 +2691,8 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>   	mgtdev->mgtdev.ops = &mdev_ops;
>   	mgtdev->mgtdev.device = mdev->device;
>   	mgtdev->mgtdev.id_table = id_table;
> -	mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
> +	mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR) |
> +					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
>   	mgtdev->madev = madev;
>   
>   	err = vdpa_mgmtdev_register(&mgtdev->mgtdev);

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
