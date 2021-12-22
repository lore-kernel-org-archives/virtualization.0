Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA78C433EF
	for <virtualization@archiver.kernel.org>; Wed, 22 Dec 2021 02:00:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4922782F6F;
	Wed, 22 Dec 2021 02:00:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eXja6hMNg_CR; Wed, 22 Dec 2021 02:00:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E2A7A82F14;
	Wed, 22 Dec 2021 02:00:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A23E6C002F;
	Wed, 22 Dec 2021 02:00:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FC02C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 02:00:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 31AD882F4A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 02:00:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LyH1paYGFZB2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 02:00:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2630B82F14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 02:00:51 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BLLE16I005964; 
 Wed, 22 Dec 2021 02:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=THdY5ccH7Svfk2Fibi8mk/iPpUbkYYHioDtauDIMg7w=;
 b=fAMuS0URXh96VtKXXHsnHQaTsMkdXqbdkI8Zzdo2NGzWd8jd8S2F3frM1FVjAEv0R4lj
 r1ce4vi7hOqd0MQF5tjoifXfj/UBpk0lF7XTVihtZhISjP4wTAbIqUCgnh+PWAG3raN4
 7I7SvZPZaC/mvb/iX6Zr7sS59q3XUtOZKkaFBA2CkSJnYTKbHYhg5pnSk71g2aZ+mfhS
 bqZeX/gywohxYeeN3AkANRCCtBax4ybMHwzUMjOJkA6Gif+u5fDQm9jnTZjetXhrWH/N
 F+fD8BbdNjnZVoEcJ1Hw8gA4wGB1pjzh7GcVAHDDpj/DkXum9jGerkP0xLu7G3FEQh1e aQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3d2qbqvxtc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 02:00:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BM1uxkS020611;
 Wed, 22 Dec 2021 02:00:49 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
 by userp3030.oracle.com with ESMTP id 3d14rwgs11-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 02:00:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PY9URme69vEcDS0Ob7++XmodMh8h2zdz3/1a3akoV5GTa/FxjMRGb166VzZObQTajgWvYT4sCGzdk5Zq681epzUzMIWe0wMWGc3/Bg215pI9/48YZgeoSLC4HVPk1TgyxnBgIGW4FHiD5w6Eo+i7psZOniHhA33kQKeT1DdOapeQMp38bHLBn+FKFb+rszFPjcqqUPbXQjqH16KUXke6qhka7gN+mvFYbysHJ3Kg9aLzHDdNbFDy5WDA/YUk1YrGZ43iAF1ktb50Thz78R+Q9GAgGlmRSG2hhd69xN8bt0Zdv58/ZGY6RPjHx0GyOmfbJU9jXA6NNuHWFpJLeZWD/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THdY5ccH7Svfk2Fibi8mk/iPpUbkYYHioDtauDIMg7w=;
 b=UgEiGYV7qK52b9IWKsRibLz8X7sYgQ+56eqs5yW0vsMyEVg6wrrI/5oeQNaFhi9N8yMBeWoV+vvEQVkOP7QKvDnJtSCWlj+yDLu1+rclDGbH5jrB0yB1RjtMjzSZ2mzJ4FfvAbyPKNg5DyIC5GxwUJZaiv4OYRp2MbgMRWUv9o8YPewbyT2JOy+Aheq7VMGm25aeBJ2sQEam98guKFS5/xKzKqfA9vODA0Y0GpIvDdreh1Shsr5dis4Y7ZZs041sKM6XR4mkMGMRM19o5Nzui7SNq8p8oRtrIs4ETqucH3C7rRH68sFuS3UOG9oF2M8/R57BJ8CUySjFa8GVFfwzog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THdY5ccH7Svfk2Fibi8mk/iPpUbkYYHioDtauDIMg7w=;
 b=lShN0oqz1qS462j68HNBETYV1giX3NkcbLDtosK39ywYbiMtSOTpq1YIdg8jf9QAjSRi+dl3JtA4fa+D0ORadgwFU6Poe7GhAbUNqA6vMZj50p3BzoVsK0xTOI49QykveHmbT4db9TJUxPbCl+B4blTX7h9No9UdkDIC6VV+cKM=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB2935.namprd10.prod.outlook.com (2603:10b6:a03:8e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Wed, 22 Dec
 2021 02:00:46 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 02:00:46 +0000
Message-ID: <e98dfbaf-8a2d-4cd6-c875-b4780137b0f8@oracle.com>
Date: Tue, 21 Dec 2021 18:00:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 10/13] vdpa: Support reporting max device virtqueues
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211221172006.43784-1-elic@nvidia.com>
 <20211221172006.43784-11-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211221172006.43784-11-elic@nvidia.com>
X-ClientProxiedBy: SA9PR13CA0049.namprd13.prod.outlook.com
 (2603:10b6:806:22::24) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 103892b4-1605-4bb3-c806-08d9c4eede3e
X-MS-TrafficTypeDiagnostic: BYAPR10MB2935:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB293575F588E97503751E3450B17D9@BYAPR10MB2935.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 16NRsEiyRx6rA8R7l0xU1UhuJSJhR8Xh9gB1CTiFVCIuEvcME8pmhRB1Zp44A8bEh8PVcPs1CV93+tUxNFKyO9JgkYIsK2En2r2gQf+pR87A5oAXabCbgwkjIXrfFUWDVQtlzxvwYawV3uO5uI4dEqyE1YMU9mwsYTENGq+bSbTMssftHgGOcjiGULgArID3Q9vex7LJU5QiKdc4Zf40Z2HQbxLab+9BJDvsWijnYD+E1jyUu15HprKT78dr1pNwcnfAIRIKJC0MbZjpDeSoBsS5WJTw3/S1WUqOk0JF3qOGW9vecpFiEBz20nGs+kgpuOjs1OK5ec+zuG6ltL5WhUIzDnjxEI0oPhwq8sBfFCMZVouHSWL3sHw77ObMt50e0GNPN96sS6poLkoLb++g56tMuJTIroKOj8BzK2r9/U76XeGHrEoYXa8xkc63RlN3l7XIfp6t5pu/VQChXlGJglBhst7l/I/t5Dz0WkCv8GwVfWYCwK4PUyIuMDqmrKB5Rs1xABYNdNN2iCMI7K2RATXvGI8jyZN3NMQAXQRX0KKdvfo0qcLUpwOYsvgpMTYB0frTX/zE8G00CRGcfHyIEOrdrIrDckUnOKe7ofxC0Zpyw/YwdQ1E1nzOThL5ykon6kw2xqfAJpSCgpUo/mbF2c+LlJsPC6CPVn6uFLRKxrt8kQz2eGVxB8AeO6NWqtIgO0mDmo4+Ovk89TFkGib6uHpTlPp69pGaqW5AHBzz2L4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(186003)(6506007)(4326008)(2616005)(8936002)(86362001)(316002)(6512007)(508600001)(26005)(2906002)(31686004)(53546011)(6486002)(8676002)(5660300002)(6666004)(36916002)(36756003)(31696002)(38100700002)(66476007)(66946007)(66556008)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?di9mQ3VwNFQ1TmRGcjdGRFM3aWE4K3NGWlNjWjdyZnMvMVI5WlJiYWx5bytN?=
 =?utf-8?B?bDh5elcxdFZCZ1E0TEdMN2JCNUNVRHNHZlc4RmNHZndqY09nclJzWVlWeFZy?=
 =?utf-8?B?VW5tdmFDQUlrVnFOdkdPMFphZ2hXdVhKdVJIWStkRzFWMUlFdDdHT1RXUzBN?=
 =?utf-8?B?WWFRd0lpY0RmN1ZKelNpeEFyb2hmUG9zc3dMdW1Icm5VREd3M1Fpa1Y0WXZU?=
 =?utf-8?B?ekRSVHRTOElnTjNzb0N1SW5jVGZwOTNsZGI4TzhTWHk2dFIyZkdsUnFlNVdq?=
 =?utf-8?B?eHZNZnhkSlMvN201alB4ekx0U3MxWnJOQWVyQ00yZGd1RUFTQU5vMkEzVTg4?=
 =?utf-8?B?WHpLS3FKTVYxZEt0eGtUT3ZSbDZra2ZQRSthemlNZkdPYjFGd3BBSmRIcnJT?=
 =?utf-8?B?cnQ3aVNtQUtBRVJBUkY2Ry93SEh1WUkvSG4yQTUzZFkrVWpQY1Q3by9WZnlH?=
 =?utf-8?B?MGllN2JITzNDYnRqeG1NWWZwRERIS2ord2Y2VGFoMnpwN2tLZjRlY0VEcFVR?=
 =?utf-8?B?TnQ5UFpKTWFuM2VBMWpua1VzRWpTVGhqMFgwQmlBYy9RWUNORThLeWZISTZO?=
 =?utf-8?B?MXlOenFNL0trWkFELzNqWldTVlczaG9HbUpvdytiYXdHYS9jc0JOODhLOEsy?=
 =?utf-8?B?NFFoTnBMajlBbnNTKzRCM2FPQ0Y2K0tnNUtjeHFlWVpyS1pQKzQ4NERZV1ZS?=
 =?utf-8?B?YmREaXBRSWlKQjYwNHZjWHdQSkx5YnJxWFg0Ty9CS1F4RTNjN241NjE0R3RO?=
 =?utf-8?B?RGd6bTNZOU9QUXZ5MHR5OHNGZTRUZlU2Q1ZnUHNmaHJnT2ptT3JPMzR3MHBS?=
 =?utf-8?B?ZHRDSDdZNW1tL1BSVGNZencxL2V5VkRPSUt3NjJJN09TNm1ERDJacFlWOEZS?=
 =?utf-8?B?SzhCbGhYbFBHQmVSbjZYUnJJR1ZmWTV2N0Y1Q014a0JyMDl0ZElCUS9memh0?=
 =?utf-8?B?RlhIQytqcHM1Nlc1YmRuaHZETmxIcHRiK1d6SGY4THNlbXJ0MERtbmJLS0p6?=
 =?utf-8?B?OXpxQ2FEQkVsb1JoeFBTMU9RY2I2OWhJZkE1K2JWWEFRbmplbENvTDVhMTgr?=
 =?utf-8?B?S2k2V2V2Rm1pRmF4RjZaMjIxV29OcVBTbGFYeVM3Zk9tbVhzUFZFaUdJUWpM?=
 =?utf-8?B?cHpxWE1aMlVkeTJORzR5eG1IeTI4SFpkWDBLc1ZhbjJQNm53NlZBUi80WnFC?=
 =?utf-8?B?WWFxRkRudUQxU0hLaW9ablR5M1MvLzhmeGJCQ2QxYWFIc1lSTVVMUDgwNmxr?=
 =?utf-8?B?N1JQYmMvWGRmVE5TY1dLRnM3bGk2ZzhIcjhOOER6ZXQ5UkJKemhtYTFvcEdN?=
 =?utf-8?B?VjB1b2I2NGRkdzBPK3U1dUJ1aFh5cnRlRjF5eHJxOHMyZ2RBWXFQMVVtSjRI?=
 =?utf-8?B?NFNxYjV1eFQycnA1Vy8zYVJBSzVhTEpzd2JPYkJuaFI2QXlDaU92SExyT1M0?=
 =?utf-8?B?TUxIN1BqZkx2OThWMGJLN0sxNGtMOUh4VlkrbU94RG1KYUZJYnNzanZpRHhl?=
 =?utf-8?B?TldEdGNXYUtKWm9XRVgvazY2Y2Q2RmVhL3ErOEs5VStoOGdZVkpSNGdEYUh6?=
 =?utf-8?B?ZWpHczh4SDExVENpK2s3cmpBRWNTNlR3UGlDQ3ZKQnU1S2FZaGw4VXFBa0RJ?=
 =?utf-8?B?U0xpTDZ5VkRoNVlpaHVWM2Q5QytWMXF6NXRVQmllbDJucTFvWUtyS2N5MWFO?=
 =?utf-8?B?d2E1dkFKK1QwQUc1aDVOdC9Wa3dnSEtTQzFMZU9NZGxUejdWSG0yZCsyeVFo?=
 =?utf-8?B?RlJzQVN1TlZUV2Q1OE9uK1pnQytSK2lNd1lFZ1hxbXYxd2Y4RDhWblYvdGpR?=
 =?utf-8?B?TGxTYjV2SkJ4NDQ3MytLcGRSR1JLck40TW9UMkUvQTVFcWpSTUxlYmhRaUNU?=
 =?utf-8?B?aHJnbDlRTDEyb0dla2RqNzNTUVNnRVV6RGc4N1lIRDFVMUhtYzNodEFwRm9F?=
 =?utf-8?B?dU1wN0YzVWJDeC8rUlhDdjBOZUtVOEVkb3BXR1F0QnNzeEdOTXZHa210K3U3?=
 =?utf-8?B?WVBvNEJzSTcvNG5yOTVldURGRVM5QUh3eEdvK1RnRWZtNW5uWDYyNjJzeE5G?=
 =?utf-8?B?WlRFSlM5R2tQa0sxUndCOGtUem14Nk92dGtuRkRpNmxpSXg4ZFVLbnNRZGRw?=
 =?utf-8?B?U0lHRDhmUUNUakpwTVBqVmhuazk0ODVwdlBHaHhaWHZhd3h2dndlTndCSTA3?=
 =?utf-8?Q?V8G6bErzkJuc56ufo1YW9hA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 103892b4-1605-4bb3-c806-08d9c4eede3e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 02:00:46.1896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FH6otmgmB9m9dlu2oXUOvF3mMtJbEQa/BKohwXdxD+66LC1lu9/OoJPpf+ICKXpcuDfbpDne0KzYO9OQ5ZT66w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2935
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10205
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112220010
X-Proofpoint-ORIG-GUID: nlXFuaCZI0ZelFufPAFOiaGyfSOrWosJ
X-Proofpoint-GUID: nlXFuaCZI0ZelFufPAFOiaGyfSOrWosJ
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
> Add max_supported_vqs field to struct vdpa_mgmt_dev. Upstream drivers
> need to feel this value according to the device capabilities.
>
> This value is reported back in a netlink message when showing management
> devices.
>
> Example:
>
> $ vdpa dev show
s/dev/mgmtdev/

and,
> vdpa mgmtdev show
remove this line.
> auxiliary/mlx5_core.sf.1:
>    supported_classes net
>    max_supported_vqs 256
Not consistent with the example in patch #11 in the series.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/vdpa.c       | 3 +++
>   include/linux/vdpa.h      | 1 +
>   include/uapi/linux/vdpa.h | 1 +
>   3 files changed, 5 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index eb223bec5209..4b649125a038 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -507,6 +507,9 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
>   		err = -EMSGSIZE;
>   		goto msg_err;
>   	}
> +	if (nla_put_u16(msg, VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,
> +			mdev->max_supported_vqs))
It still needs a default value when the field is not explicitly filled 
in by the driver.

-Siwei

> +		goto msg_err;
>   
>   	genlmsg_end(msg, hdr);
>   	return 0;
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 47e2b780e4bc..b575f71fa5e7 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -447,6 +447,7 @@ struct vdpa_mgmt_dev {
>   	const struct vdpa_mgmtdev_ops *ops;
>   	const struct virtio_device_id *id_table;
>   	u64 config_attr_mask;
> +	u16 max_supported_vqs;
>   	struct list_head list;
>   };
>   
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index db3738ef3beb..995257c6bf2a 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -44,6 +44,7 @@ enum vdpa_attr {
>   	VDPA_ATTR_DEV_NET_CFG_MTU,		/* u16 */
>   
>   	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
> +	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u16 */
>   	/* new attributes must be added above here */
>   	VDPA_ATTR_MAX,
>   };

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
