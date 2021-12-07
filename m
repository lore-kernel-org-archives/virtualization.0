Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70455C433EF
	for <virtualization@archiver.kernel.org>; Tue,  7 Dec 2021 23:16:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B67160EE5;
	Tue,  7 Dec 2021 23:16:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id serNsA8TLtUi; Tue,  7 Dec 2021 23:16:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F06D060EF1;
	Tue,  7 Dec 2021 23:16:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB59FC001E;
	Tue,  7 Dec 2021 23:16:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1751FC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 23:16:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F001F4096D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 23:16:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="SyPukn5j";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="fi3qi4c9"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ob1OzEezqx21
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 23:16:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1ACD940932
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 23:16:00 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7L4xX9028666; 
 Tue, 7 Dec 2021 23:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uSPIXT+Bufd8jY/ahzodEfik/qArmIigsWHBBVAEmc4=;
 b=SyPukn5jDBhWogZzx0Cqoe0k38a05pFxvA5lYV2n/VoUk5NemYdp/Q9a72HP9xbO+vEA
 AxBFv/i+cd40n5RP8AjaJ7nOjZnT9t3UhBev2bK9YODmMgNCbpdkRUmK7hsSm3+95C4I
 jrBRzE+LG9awEMsyXPl4ygFtDWN1uTApcE/fMM8K8d9a8p9XhiJbud/8DS70HGVs1Nb3
 erEJQ4XThfdNOLjxBjAafO7Ou3OjZ2H1wKfAzDTcbX69D8uwsXvZxmkDJJa9Mh5hqvRB
 MrawC7V+aBr41C92kYmhbnzVqLw76VwGd5vAhsOhvxQwD1daYakzNQTZNlAib+rCLxCx FA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cscwcf296-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 23:15:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B7NBJf3170895;
 Tue, 7 Dec 2021 23:15:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
 by aserp3030.oracle.com with ESMTP id 3csc4ty7hd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 23:15:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b37MPp4tLpMrptwLFKtl8ugRI0rbD6ZD4oPPVJtuJjkwmic7xCCTfjVpNXW1Lu9C9FbUhl1O0YWbNIktUyd5qowB9W3xYnxgxSy2tTAVzGfJHVQm3VQhSqDsN/WBzzKr8Q7sR7dLPWPwqKLiR3eF6U8nmU10Uqx578f3CFGj2CWxwmMOsDJ51uOetWtNLDqSytek6/jFr1yuFGSP1Whh4pvYwazMkg4vq3qGTzjt5hWRV+Yfiz9dTRYyuw7cjBzriUy1F9V268owy9NrG0z99n1Kn9WAvj1vomLPKxKvC02dWHwynJ9nvgXHDS4O+D7cfRLYG3Mk4K7aKbLZmlk0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSPIXT+Bufd8jY/ahzodEfik/qArmIigsWHBBVAEmc4=;
 b=f2JUkRhWaaBdTZV1cKbaaEcS5USrAoW3HKYHmzvcMLzN7eZ7yVUZnpOxJ9w4oqh9u4gk+3k5DRpK7AE88Xw6RV6NExtcG2P3L4hK4ttUc0cQR6Rvr51SbdvYbPKQQnitZjuClCZTOXO2qeR95LAb95di0QoaayjGrpsAUkmjdBOp+CcVBo32G3jgiiB+yjFLeAAr8mDF0Z9b2++uHm6gGl++zyxK3F22fRX1WkqCHZyffLkgIK2tccg/jXPA8VQnBncFaMAtQPVLa6vgLDWmoOjjr5dpCtGy0pMGLnl0MOogLHAqIU26cLSub9ORfaybW6EtTP4IBLxFOROhRzZ4Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSPIXT+Bufd8jY/ahzodEfik/qArmIigsWHBBVAEmc4=;
 b=fi3qi4c9b0tS+lin5tKFIKS1sDiIyHBUztA7/2VLFmQqlmu7D5Xe0pOlA/rKZCntTa/oiAe9j3SaaW39440sca1bllSfDbfuqVedaaRrffZpar9o3TpuZda/5XetbCJ3LvMoJrXR1ZgkuwSb3CDSfbVBc93U0WaUhRlTs7nCXsk=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB2423.namprd10.prod.outlook.com (2603:10b6:a02:af::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 23:15:55 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 23:15:55 +0000
Message-ID: <8a196015-4024-4e56-4d21-80033322cb85@oracle.com>
Date: Tue, 7 Dec 2021 15:15:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/7] vdpa/mlx5: Support configuring max data virtqueue
 pairs
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>
References: <20211201195724.17503-1-elic@nvidia.com>
 <20211201195724.17503-4-elic@nvidia.com>
 <0e6de504-38e8-a1a9-5dc9-00c52571b21b@oracle.com>
 <20211207081946.GE15767@mtl-vdi-166.wap.labs.mlnx>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211207081946.GE15767@mtl-vdi-166.wap.labs.mlnx>
X-ClientProxiedBy: BYAPR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::39) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
Received: from [10.159.158.104] (138.3.200.40) by
 BYAPR03CA0026.namprd03.prod.outlook.com (2603:10b6:a02:a8::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Tue, 7 Dec 2021 23:15:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c552798b-e86f-4c4d-a70d-08d9b9d78518
X-MS-TrafficTypeDiagnostic: BYAPR10MB2423:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB24238641E4B046DCCD6DED1CB16E9@BYAPR10MB2423.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RMduhztxxkFc34c13evUKtV0RIQVqSIvKQw851rUJzyDOKAbRyy31iGZ+85EFLJ9P+7mGjmP913JgMlwvBofRL4sFeG3jSch+1oHjWdPBnO+pGvNJcW0xm2sxCQcXe+sMvLuszQHVtpmKiBb4D7DWvyS564VBrLf2R88YmRUi8JXGu+O7IFStV65AJkVWU4amP1MfH0Uq1I8zJ6lGlxiP8NWLfDqwzlF4dVHREts9gfCm8AHLKmgucVB4Z839WgLjPU8OJZj1UEYJT/0XeNFg2xfcS+yC5Txovv44rSc51QvCVw3V6wM6W63qDxqGqwmumpQXUSZw/bRZLbaUNaWsh3OFfMIPrBpoAmjnNFBNUz/eWwq9LBxmU0hbnqg0fWyBfidyRRkI8/Xya5M/eFtXpJivRwMNSqa8oUeaSWRNChPAyE82Ve+65WAwynvYZ7q/MaJlcWacppY8ai/64lgjTzHfXYUhrJdOqPIoE0ETpn1j49B1DPxQNZTFTDcHi8o4+lmVQoOxLnoTC26kt3xAABngxfaHlNpCTnkFlctmgiB73oJAgJh/c/+eizKZdVw2P82jE4WKzkJMa9AwqFGvt59jt5NTMOGFYUJYOqGr2ovVbPeZCQxeIdQ6INrpMAXvHIXZT+vOtedNQGPumJekuOyC+JpnKxMfjX/quVkyl/xMkUlpcurX66mtNvCv/WP47KzxNNxFm6bPCIo/zeypvCkdcB9OSv3pLD+zctHgc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6666004)(66556008)(956004)(66476007)(66946007)(36756003)(31686004)(6486002)(8676002)(8936002)(5660300002)(53546011)(31696002)(2616005)(83380400001)(4326008)(186003)(38100700002)(26005)(16576012)(86362001)(36916002)(316002)(2906002)(6916009)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkZiNjY4TG1Mc1hoMXhPYzdXUnBDT3V1MEwza3pLbE00K294dGg0TTZFQ0RB?=
 =?utf-8?B?VWhETGZsamxiVjgvTDF5Mkx3Yi8xaTl4cm9Wc2daVEdyZVoyZS8rZG9Nb29p?=
 =?utf-8?B?MldEemdvVmVCZXVROFF2YStCV3oxUUVFcmdVOU9nYkdJUjlqMkpla0pQU000?=
 =?utf-8?B?OGhqR1RJbzFHRzlFLzF1amtob0txMFBNUFpJUDMzMTBVcTN2OTdldnpKbitT?=
 =?utf-8?B?b2xkZ0V4OVpKK0FoNGNiQmRUamdmYkg2Vno1WkE3azZGckd2Uy80bzNlYzdH?=
 =?utf-8?B?bkZENU9kMlMwRWdSS2hNODhHNzNQdWlRZ2pUQnEybjVQMHBLMllKYjdpM3lD?=
 =?utf-8?B?ZW55cElleVVqM2hkUy9NTWI4WmpCbUlIdGVaMnB2NzRqUUZSb0JDMDNYOGNJ?=
 =?utf-8?B?SjBNWWpHdWNIMFhPQnFSd3FzSmhQNDdSMjZ2c1ZkeGdrQmtnOUpRL25WZVF4?=
 =?utf-8?B?L3d0Rk5JTlM4SHZqRGFLVTU5ZXlJdXV3dUVPYzJSYUlaQUNmZmRHTDdVcXhS?=
 =?utf-8?B?cysra0ZUUGV4ckx0OHRQSCtQdDJzb3pLckMvZmpPVmNxTkpIclhaMFZDZTVk?=
 =?utf-8?B?dENFdkludnNiVnFabmFYNUR0SStKMzQ2WXNwKzlJVWVEQm9PUlVOSktjYmw1?=
 =?utf-8?B?QWhmU0FuQ2llSkNMVFA5WlpJNFFFZkMvMkpRZHhYS2JneVFhYnhEL3NqL3BB?=
 =?utf-8?B?UmJMY2hJSE5VaklMMnJ4ZWFUa1N5eTBmUHlJaTIxenFrdjZBSnk0Yk1BbkVL?=
 =?utf-8?B?WWFZSGVsOGgyejErWjRoOEVINWNmV2JDRVQ3YktESzI5bHNiQlJTYzJ1ZXBh?=
 =?utf-8?B?R0tXWmxCcllJcmdLQlBNR0R6eUtqVkpIYVd0MTVQcG9vb1JMb212TklDelJr?=
 =?utf-8?B?OE9TYkcrZW16WURqdU12SjlkbnQxMzVXcExwc2ZIWHdSYkR5bjA2a3NvTU0y?=
 =?utf-8?B?S1VIQmg0WFhqd2V0L3N4aHBPbzhsRmF5MFBVTjRMa0F2VWxKS3hxT3V1bzll?=
 =?utf-8?B?L24wdGI3cGxIVzhNOVBLcjJaaDR6TE5KMXlhSXhUZFVKWkJ6Zm9oRWdDdUhK?=
 =?utf-8?B?UitvOXdPeUM3alFXdkJYSGFCdGVDTy83T2xaZThUYUtNNEVrKzlhdmFLSGRE?=
 =?utf-8?B?WXpERHhsNiswVWVBazlIOWZ1WW9BZUFKaVhweFdTL25xNzNqRmh1UGc3YVNC?=
 =?utf-8?B?WUJaVm1qclozOXpnUGJoSDRCaWZSTWtlWmFIcXJzcHg1QkFSRzc1Y3FiLzZ6?=
 =?utf-8?B?anAyeGNIZmhqWDE4Rzl0ZHhCVUZPREtqK2NvVlc5YkFhbjFHNU1QUk1iRVd1?=
 =?utf-8?B?VGR1bjE5ME9Qek1Rc2pyYTREOHhiOVp0UW1jNDRDSUF5Q0E1RnRkQjBBSjg0?=
 =?utf-8?B?aTF2M2RuMGpmajlVanpVNHBmTU5UckRDclNKMzhSeFlLNWl5UkVHNUE0cnRH?=
 =?utf-8?B?OUQ4RVE2MkVqRjU3bGhZNmoveUE4Q3BCWlI2RGJSV2RYVzZaVldjYnVESHdy?=
 =?utf-8?B?OVNaaTFxOWk0U3BERmVKVWE5cko0a0FhRGxTVzR4aFlrSGQ2L3dpUmpjM2hw?=
 =?utf-8?B?bTJ5QUJ0cFhZb2VGS2htTlJ6dXQzMFpIMm1mWmxwcXhOWGFVRjhnaTdOd0Zm?=
 =?utf-8?B?U2Z2aklCM0Y3UisxSTVaVG95RzdKLzc0UndscEFVV0puS0M0cXc5WmgrY1dn?=
 =?utf-8?B?UXZLcnl6dVNDWm1xS2Q3OWd4Z1IvM1piekZPMEtjOTJPYjk2c2dPY2hnODVv?=
 =?utf-8?B?WitZbUJBclNuZGwrSE1NeXNTTWVlbnVCVTVUVXgzNy8vcG1Ua2tXUG1sbWdX?=
 =?utf-8?B?ZlpJQjFuejhqOVpCbkdMRmR5VTVRdEVuakVSWHZZUTR3R3ptbTZHNFk2eTBy?=
 =?utf-8?B?TElyYmtXN243UWl0K0RzdERlQUVlYzFuMVBLTDJEZitmbXVNaWh4WmVBQ1Fx?=
 =?utf-8?B?RzRTY1RXUGxlenllb0t3K1Vrc2pPbk5ob1hOQ0RCSXhvMTZRWVcrYk4reTFU?=
 =?utf-8?B?K2lqeS9aK2pJbDNZejY2alJtZ2lWTXJPWElWNllmSXlYQ1RJYkp3ekR4NzRK?=
 =?utf-8?B?UENseWQ4eGtPdU9SREttV3krM2FOUVBnUVp0R3dhazYwVVA0NHFSOUNHSm9T?=
 =?utf-8?B?VjV4K1BkNCtBbmhrYjdBUVhWMGxQcFprRGZNWjJmaG0vbXpOdmhud2ttSW9F?=
 =?utf-8?Q?yuAyWXEr5nanV56oOFyaHXI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c552798b-e86f-4c4d-a70d-08d9b9d78518
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 23:15:55.5790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nrLrJ2Er186xo71VUov9P86kZF936uI/7XxNpggqqBszAzCDoRkEO6LH28aY8i9Ngtgn/WryzLDqQndv7zJLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2423
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10191
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070141
X-Proofpoint-ORIG-GUID: h8PI_56WE3RY8IwVQRkaa73aouP-RvDi
X-Proofpoint-GUID: h8PI_56WE3RY8IwVQRkaa73aouP-RvDi
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



On 12/7/2021 12:19 AM, Eli Cohen wrote:
> On Thu, Dec 02, 2021 at 11:28:12PM -0800, Si-Wei Liu wrote:
>>
>> On 12/1/2021 11:57 AM, Eli Cohen wrote:
>>> Check whether the max number of data virtqueue pairs was provided when a
>>> adding a new device and verify the new value does not exceed device
>>> capabilities.
>>>
>>> In addition, change the arrays holding virtqueue and callback contexts
>>> to be dynamically allocated.
>>>
>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>> ---
>>>    drivers/vdpa/mlx5/net/mlx5_vnet.c | 33 ++++++++++++++++++++-----------
>>>    1 file changed, 21 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> index b66f41ccbac2..62aba5dbd8fa 100644
>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> @@ -131,11 +131,6 @@ struct mlx5_vdpa_virtqueue {
>>>    	struct mlx5_vq_restore_info ri;
>>>    };
>>> -/* We will remove this limitation once mlx5_vdpa_alloc_resources()
>>> - * provides for driver space allocation
>> Is this comment outdated, i.e. driver space allocation in
>> mlx5_vdpa_alloc_resources() already provided?
>>
> Not sure I follow. The comment was removed in this patch since we no
> longer depend on MLX5_MAX_SUPPORTED_VQS and rather use dynamic
> allocations.
>>> - */
>>> -#define MLX5_MAX_SUPPORTED_VQS 16
>>> -
>>>    static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
>>>    {
>>>    	if (unlikely(idx > mvdev->max_idx))
>>> @@ -148,8 +143,8 @@ struct mlx5_vdpa_net {
>>>    	struct mlx5_vdpa_dev mvdev;
>>>    	struct mlx5_vdpa_net_resources res;
>>>    	struct virtio_net_config config;
>>> -	struct mlx5_vdpa_virtqueue vqs[MLX5_MAX_SUPPORTED_VQS];
>>> -	struct vdpa_callback event_cbs[MLX5_MAX_SUPPORTED_VQS + 1];
>>> +	struct mlx5_vdpa_virtqueue *vqs;
>>> +	struct vdpa_callback *event_cbs;
>>>    	/* Serialize vq resources creation and destruction. This is required
>>>    	 * since memory map might change and we need to destroy and create
>>> @@ -1218,7 +1213,7 @@ static void suspend_vqs(struct mlx5_vdpa_net *ndev)
>>>    {
>>>    	int i;
>>> -	for (i = 0; i < MLX5_MAX_SUPPORTED_VQS; i++)
>>> +	for (i = 0; i < ndev->mvdev.max_vqs; i++)
>>>    		suspend_vq(ndev, &ndev->vqs[i]);
>>>    }
>>> @@ -1245,7 +1240,7 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>>>    	int i, j;
>>>    	int err;
>>> -	max_rqt = min_t(int, MLX5_MAX_SUPPORTED_VQS / 2,
>>> +	max_rqt = min_t(int, ndev->mvdev.max_vqs  / 2,
>>>    			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
>>>    	if (max_rqt < 1)
>>>    		return -EOPNOTSUPP;
>>> @@ -2235,7 +2230,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>>>    	clear_vqs_ready(ndev);
>>>    	mlx5_vdpa_destroy_mr(&ndev->mvdev);
>>>    	ndev->mvdev.status = 0;
>>> -	memset(ndev->event_cbs, 0, sizeof(ndev->event_cbs));
>>> +	memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
>>>    	ndev->mvdev.actual_features = 0;
>>>    	++mvdev->generation;
>>>    	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
>>> @@ -2308,6 +2303,8 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
>>>    	}
>>>    	mlx5_vdpa_free_resources(&ndev->mvdev);
>>>    	mutex_destroy(&ndev->reslock);
>>> +	kfree(ndev->event_cbs);
>>> +	kfree(ndev->vqs);
>>>    }
>>>    static struct vdpa_notification_area mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
>>> @@ -2547,13 +2544,24 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>>    	/* we save one virtqueue for control virtqueue should we require it */
>>>    	max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
>>> -	max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
>>> +	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
>>> +		if (add_config->max_vq_pairs & (add_config->max_vq_pairs - 1) ||
>>> +		    add_config->max_vq_pairs > max_vqs / 2)
>>> +			return -EINVAL;
>> It'd be the best to describe the failing cause here, the power of 2
>> limitation is known to me, but not friendly enough for first time user.
>> dev_warn would work for me.
> I could add a warning but if some test script does this plenty of times
> you will clutter dmesg. You do fail if you provide a non power of two
> value.
You could pick dev_warn_once() and fix other similar dev_warn() usage in 
the same function. But I do wonder why your firmware has this power-of-2 
limitation for the number of data queues. Are you going to remove this 
limitation by working around it in driver? I thought only queue size has 
such power-of-2 limitation.

Thanks,
-Siwei
>>> +		max_vqs = min_t(u32, max_vqs, 2 * add_config->max_vq_pairs);
>>> +	}
>>>    	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
>>>    				 name, false);
>>>    	if (IS_ERR(ndev))
>>>    		return PTR_ERR(ndev);
>>> +	ndev->vqs = kcalloc(max_vqs, sizeof(*ndev->vqs), GFP_KERNEL);
>>> +	ndev->event_cbs = kcalloc(max_vqs + 1, sizeof(*ndev->event_cbs), GFP_KERNEL);
>>> +	if (!ndev->vqs || !ndev->event_cbs) {
>>> +		err = -ENOMEM;
>>> +		goto err_mtu;
>> Not a good idea to call mutex_destroy() without calling mutex_init() ahead.
>> Introduce another err label before put_device()?
> Thanks, will fix.
>> -Siwei
>>
>>> +	}
>>>    	ndev->mvdev.max_vqs = max_vqs;
>>>    	mvdev = &ndev->mvdev;
>>>    	mvdev->mdev = mdev;
>>> @@ -2676,7 +2684,8 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>>>    	mgtdev->mgtdev.ops = &mdev_ops;
>>>    	mgtdev->mgtdev.device = mdev->device;
>>>    	mgtdev->mgtdev.id_table = id_table;
>>> -	mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
>>> +	mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR) |
>>> +					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
>>>    	mgtdev->madev = madev;
>>>    	err = vdpa_mgmtdev_register(&mgtdev->mgtdev);

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
