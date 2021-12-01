Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6939C433EF
	for <virtualization@archiver.kernel.org>; Wed,  1 Dec 2021 19:46:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4808141CB0;
	Wed,  1 Dec 2021 19:46:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aFA9bjLlg9hL; Wed,  1 Dec 2021 19:46:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DA87341CAD;
	Wed,  1 Dec 2021 19:46:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5671C0012;
	Wed,  1 Dec 2021 19:46:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B01C9C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 19:46:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9225B41CAF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 19:46:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WYjUURv2rDUa
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 19:46:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4021F41CAD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 19:46:42 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1J6Q9f017179; 
 Wed, 1 Dec 2021 19:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Ej/oe0g+oawwEayzvEQBdHK6fK0TVJJmmWafnHItnuY=;
 b=PyIyRX0yQbZjMvC3gAoig3CQUR3DZFxUqWqlUBP+3s3qqQNHpLl1xIlT3eLyGhWXuM+L
 ZF87368ZeYGfOToz+f5WPcPbXzDMSh0zjfoq0KxbMH+T93llKkJMh2QNFTAqa+wrHK3B
 ICIb8om/82Y/wybodmEzUU0lV4bq5qthrLZqafYFe4PK8JZZY8zNM2yjZsHlVBO2vmX2
 km7uO1DdSrrhlTBY+nausQ9CR8WCOVbLtn/D/nyOskw3Qd3VSRWEA5zEY508E073euv/
 UYmZjFxkNejtLCkMea1B5NZ13lDu9p9kUtv/nKiaX5M70Rf9aCkG9NpKq/T/7cuOzc1m 7A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cp7wek6c2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Dec 2021 19:46:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1JZlrr195733;
 Wed, 1 Dec 2021 19:46:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
 by aserp3030.oracle.com with ESMTP id 3ckaqh2aq3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Dec 2021 19:46:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0Q6rkntvTd0g2laeIMFJbCFxArBXlIFiGV67iHQe7vZS53FRc6o48QTMcBITZXHddqge2HXlZSPeP0bjjWfWAwm80PyrAAwfM5YwWWa9jGscGOdZDjgHJ5jvThd5qAHjYn7s/qE/DxhufhutI2nbhyJ6jhuDvkPNlGXGxXeFmH3wbi86qalLAPLu/qRxPMxVDDQoM/3AWknA0SSiX1Z7y11Hjl5Rh+rewbdmWqt0xFns7EPJVOLoWECCf9Zt1Ld20gB60MnaVXffU7qsbbigv/r1UDFt6FCRznTe1BMBsGZTNppvPdhg9fU94dU1anosf8jf24xnLXbAKJGlSkC2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ej/oe0g+oawwEayzvEQBdHK6fK0TVJJmmWafnHItnuY=;
 b=BXgoi/oAUF0BFwdI8X7DRAbcdg2BuK/eIJ8RwsBQeCpe+3FJXlB0fa3/0ocDJz+mc1vT8v3Bxrz1cazDX0TtHsV6oRU/y9YZC66UhzTKlWitqOpZlFcFNojC8oZyp/3yPIWmvbjKiaT3Xje3zBZU/vBC1YdMnoTVgDudUoBlwKNwvyjtChbx9tumYcONwk7AQXu5lcJmeGOVLfB3FuAmaW+r8R4CYBCpGwNuHQLpbF6d7KARnKP0dHC6009y5IqtGzr7tMwGYZ9xA7r8gaWGrTjgOvXGTmPjwLXCBSkAo+RYbpCTdr/t5qRjWzFYlA+mpqWRAQu0Z6MEWKHgCYLebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ej/oe0g+oawwEayzvEQBdHK6fK0TVJJmmWafnHItnuY=;
 b=aaOWgpsfcr0ajcz5h1I4qShL+RzakQbQFztipRFrd08iCT9yfCJeZotnlVQA3EsD5k4SBenfB+44gxDWjsIFSe9tuUK6AQTXDqOBGJpA23Dn8w/BVsNULJcNKy4aKL1jVcZmXQejuBR+fHaD4QzTekdBgrAW+TUuaE77cYsmOW0=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB3128.namprd10.prod.outlook.com (2603:10b6:a03:14e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 19:46:36 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::89e7:42b2:b226:2182]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::89e7:42b2:b226:2182%7]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 19:46:36 +0000
Message-ID: <4228c5d8-5e56-91fb-1b62-e58d253c8cb7@oracle.com>
Date: Wed, 1 Dec 2021 11:46:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/2] vdpa: Allow to configure max data virtqueues
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>
References: <20211130094838.15489-1-elic@nvidia.com>
 <20211130094838.15489-2-elic@nvidia.com>
 <ab454062-da69-a72e-1953-716257bb464c@oracle.com>
 <20211201100307.GA239524@mtl-vdi-166.wap.labs.mlnx>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211201100307.GA239524@mtl-vdi-166.wap.labs.mlnx>
X-ClientProxiedBy: SJ0PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::28) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
Received: from [10.65.140.160] (138.3.200.32) by
 SJ0PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:33b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Wed, 1 Dec 2021 19:46:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a1cc077-ccbb-47e6-af5a-08d9b50348dc
X-MS-TrafficTypeDiagnostic: BYAPR10MB3128:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3128050A0C7C7796D6E101C0B1689@BYAPR10MB3128.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pW6Fjk9ST3THl9Wk2fbrlqyiSy6RaL2u2Cffx1Nlp1uFpljsPD8deJA8qhJNpjkkQJh27/doJbtnd0dlbEJR5HN3ffGFBE1qzXS6EAPPNZZ/daFFHwI6qjlXmDkTAWLP6rUja3tIYLYJquFzgm9c5DYskFjr5BLvOeyc/T99pJjYpvSyhnWIX4pNsi5di9Bef3Azm91nHQ8QLMnumW/CJ0ov70anUZfzjl5CmrxvN0sKLskwcaoqbvMNi7kqRJfldVkLRDPqQVlPEdZCZuYQYyNXmLSCVAk35i0yxXKCgnjwJvTWn7vQGM8R+8JbGqMMgSZowYt+0ckh+fa8O1VqCGgdQ08koE2Zxh97HJZQ0l8J5qFHULyF11I8tA/+owfHp6nhKOM02iLtlI6klV5eUYBaqe8HBCW8sEI//udBcRLYWxTGfRclrR1JtDx+ZIOt0C4qFzDg7RXqTpFoSCVU7mry4yLA7HdO3Ab15OxLXMBikq/kKeOrebcbgx2/ZVMNb606FYsEn7Qlccyx2kAanXxyzMURxCh9lOvAPtlPWklYu52YblJqAMpogGrLQ2UdW2w27Sxnqy8ALMGI6YSYNHYKGC3a3pmZO5oXkiBcKjAYVTCQi69F8Au8WjhP6OFYWEh2LNhEZETSxKew+enGHo9Is1ZWWeH8dJem5Gr0lq/PeuLDP00NPXa7wqe/n5zvU6Qxsk0c5yah7u+CiodeN2hfVL2DA09/c5UzOCNNHC0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(186003)(66556008)(66476007)(6916009)(66946007)(86362001)(4326008)(53546011)(508600001)(33964004)(83380400001)(5660300002)(36916002)(26005)(6486002)(36756003)(956004)(2616005)(31696002)(31686004)(8676002)(16576012)(2906002)(38100700002)(316002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amhOVmdMenh0ZnA5NmkvLzZrdXovaEh4c2RaVERtcEV5MW1WRkRVNE5Fenl3?=
 =?utf-8?B?eDVhZ2lDZ2F2K3BwU2VURGtiMzczaXZoMVNDTXIwSk96d2E2L3JKcmZWMGp2?=
 =?utf-8?B?YytlV0k3c0NvalNxK09UbkJnYWdHYU9jOWlvektTcUJFbnpIY0NEVE53Ti8x?=
 =?utf-8?B?Ly9VMXo2N2xLRkgwd3FVOU1ubVd5NjczZlEzTTJ1N2lTcTk0SVpoeDZSa3VM?=
 =?utf-8?B?NFdRNkxZbnJGNDZLT29GV2YzdGFtYWp4RjlPMFB5MkVyeHRJNFYrVDFSL3BU?=
 =?utf-8?B?aFkzclp3QjNRclpCb0ppakEvOG1Na3A3dEpNcWlyMFhuTkgzOW4zUWF6cENl?=
 =?utf-8?B?eXZkRGNYRWxkUTZmeXkreEo4dk52U2M3QkdTb1BQeWp2ZjNWbTRNdSt4VzRH?=
 =?utf-8?B?Tk1yZ0dTUjdEMXNmZFN3bWlVdHMzR0s5aFFVK241ZGcwaXJGS2c1K3VzL1Zt?=
 =?utf-8?B?bitBOENpZFNIR0wxRWFNSGRJMnBzS2FySlc4K08xeXVoZjhReVJDZ0VubDZR?=
 =?utf-8?B?MmhXUUpNZ0dReWJMV3lyNkVvZ1RUSHdmR3Q4VWE0WVhmNE05WXBidEJhZUR3?=
 =?utf-8?B?Nm9NMkdjOWJoNzRIcTR6SEcvWFZBKzJIaFcrWXNicmphZTJqamlkdHQwbi9t?=
 =?utf-8?B?RTJmWkttMjVCVHF4TUlhRis1WVB2bjU2TGRkUUgvaTBhRzdON1ErRDA3ZDJz?=
 =?utf-8?B?YTdnbDVMTjN0dzNPU0FHbGcxd2J4YzNZTHlsN0laRkhveHA3NmdCOUcxZ1JO?=
 =?utf-8?B?Ri9KaU1DTS9WZS92Y2g0dSt0SGpIM3MwOGdLWkxZdkVkTzlOeEE2eSs0Q2dj?=
 =?utf-8?B?QklMZVpUbjFuSkFWaWxoU0o5TWpCdGNLS3RsYS9peitKNEpRekNXeDB0VXhm?=
 =?utf-8?B?bE5YaGl2TEtJcWxrL1kwa2VLZUQwcktKZHRRL3lHdnhrdWhOclZQU093cHFi?=
 =?utf-8?B?c2tjamQ5WkxvZUFKSXdaZWJSdWdPU3d5bHEzN1NaOWM2MW4vTzRoQ3BVNXFv?=
 =?utf-8?B?WUxyZVBQQVg3aFBXTG1IK3BWWG9EWlhQWEYrbVFYdmJidHN6eEhzWEpWWVQx?=
 =?utf-8?B?cUxuc0pLcHpSbzVKYjZDT2VjaWQxRWhvOC9oc2JvZ3JMMTBFSUdBRG9FSExk?=
 =?utf-8?B?bEtQMkNNNVpNNUU0dzVLdVZCdVh0YU5sS3dSekxVZU9lTTZzV1NYTk05NVlt?=
 =?utf-8?B?a1dibEZUbzliZlh1bjF6ZG1INDhjSG9qTnNWajlTaWRjT0FqRmpkNTlhY1VV?=
 =?utf-8?B?T2czWnQ5dFd6RExNdHhNOTFpeWxNQXg5WTVFWFR2b2h1WUl4dlQxUXZZU3N2?=
 =?utf-8?B?N3JDY1lTQmI3NzJiTFdqRnlGcUJSN095UGs4MzdBMUlVb1hTeTB5UEFKV1hW?=
 =?utf-8?B?VjF0SEtSeU1iaGMvbGhMS0FQd3hOeFhtTnJVRTJHOEZZVmsyOEhrNTQ3bEFq?=
 =?utf-8?B?RDRFZUMwV3dKcjVsZ3c2M05zYWRvMHlWMlNja0MvWHlXdnFZNU5CMDYxODY3?=
 =?utf-8?B?MlpzTm1kakZhYUxnQ0NicHlrZXhHWUw3MjJqNWZlWHhUdkxGNktXK3d4U3hi?=
 =?utf-8?B?Rm0wSitZOVV3N2ZOQjAyVnRSYzdjQSsrelhNZU9Fd0ZFZis0WmNIbE00SVNt?=
 =?utf-8?B?eTlxU3NPT2twRkZ6U1EyQjkzQ3VieEZwbElqbkRTenllQ2QwalJxZjdqV3FS?=
 =?utf-8?B?TkRFY2tPeGtCV0Z0QW5HWDB0dzQybllWazFvUnVKSWl5Tkx4djB0enpUQUdW?=
 =?utf-8?B?QXRPYm11RWtieWd3b25LYXE4d0ZjRVdGekVmSHJYQ1E1THJKR3ErQ3NxK0tT?=
 =?utf-8?B?TTg2bFY3Y0pYd0hvUGFwOTZMMFVDRENjTGZSNVp0bTVIbmdlS2JOTEJoYkxr?=
 =?utf-8?B?bzcvaXZSdlZ4TjhQWHBUS1V3YzdPRXV6Y2UyamxsMlM2c21yTDFwQnUxYXRF?=
 =?utf-8?B?QXVScnBLWHNEMDM2NlRzaDdFOFJBUEJuTGFxa2IwY2ljeDlCaFZ6QmYwOCt0?=
 =?utf-8?B?WTR1c1Z2MGtwOFpFc1hqMTNYRFArYVVnV0lDSTk5TmVMZytFQTRycDFpTTRR?=
 =?utf-8?B?eDZRR2FZdVZONFVtYlhLMERzQy94cGRFNXhuZ2R0aHJaYTRReldHQzdoeTFa?=
 =?utf-8?B?aDJMa0Y2eDF5cmxzYUVNc3JFS09jRTMrcGF5ajdUZGM1MExMM3QvVmR0ZDMy?=
 =?utf-8?Q?LHYmi7sBDWnX5p3cTZmpLTc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1cc077-ccbb-47e6-af5a-08d9b50348dc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 19:46:36.3206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LORxaIy8UvJrJXBI1PixYnHkfeMdUOSMfNJ6X4euoTBVPYWN+zNlKKnF9oPTHzHO8EiRLMIy7jcqWg/Fdvuymg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3128
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10185
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=928 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010104
X-Proofpoint-ORIG-GUID: dsrm-ZGqIeJIji_bPmQnr8K-6NScNqLe
X-Proofpoint-GUID: dsrm-ZGqIeJIji_bPmQnr8K-6NScNqLe
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
Content-Type: multipart/mixed; boundary="===============5399957517822707864=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============5399957517822707864==
Content-Type: multipart/alternative;
 boundary="------------fFkExau10tP02tc4TLO3Om8G"
Content-Language: en-US

--------------fFkExau10tP02tc4TLO3Om8G
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/1/2021 2:03 AM, Eli Cohen wrote:
>>> +		if ((config.max_virtqueues - 1) & config.max_virtqueues) {
>>> +			NL_SET_ERR_MSG_MOD(info->extack,
>>> +					   "Must provide power of two number of virtqueues");
>> Why there's such limitation for the number of vDPA virtqueues? I thought the
>> software virtio doesn't have this limitation (power of two).
> Right, the limitation comes from mlx5_vdpa. I will post a patch later to
> remove that limitation.
>
I mean the check should not live here. Other vdpa vendor device/driver 
may not have this limitation.

-Siwei
--------------fFkExau10tP02tc4TLO3Om8G
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 12/1/2021 2:03 AM, Eli Cohen wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20211201100307.GA239524@mtl-vdi-166.wap.labs.mlnx">
      <blockquote type="cite" style="color: #007cff;">
        <blockquote type="cite" style="color: #007cff;">
          <pre class="moz-quote-pre" wrap="">+		if ((config.max_virtqueues - 1) &amp; config.max_virtqueues) {
+			NL_SET_ERR_MSG_MOD(info-&gt;extack,
+					   &quot;Must provide power of two number of virtqueues&quot;);
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Why there's such limitation for the number of vDPA virtqueues? I thought the
software virtio doesn't have this limitation (power of two).
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">Right, the limitation comes from mlx5_vdpa. I will post a patch later to
remove that limitation.

</pre>
    </blockquote>
    I mean the check should not live here. Other vdpa vendor
    device/driver may not have this limitation.<br>
    <br>
    -Siwei<br>
  </body>
</html>
--------------fFkExau10tP02tc4TLO3Om8G--

--===============5399957517822707864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5399957517822707864==--
