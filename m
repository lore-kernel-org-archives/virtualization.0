Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E8DC433F5
	for <virtualization@archiver.kernel.org>; Thu,  9 Dec 2021 00:25:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E376E8282C;
	Thu,  9 Dec 2021 00:25:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dJ21NNczIUmY; Thu,  9 Dec 2021 00:25:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 56A878281A;
	Thu,  9 Dec 2021 00:25:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38FAFC001E;
	Thu,  9 Dec 2021 00:25:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C2DEC0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 00:25:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 466224048A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 00:25:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="h02S7N+0";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="kEXb252m"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OCqangSVjIrf
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 00:25:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 617FE40489
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 00:25:27 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8MiI3U025476; 
 Thu, 9 Dec 2021 00:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0yJwGGRk8oukOE7wU9UI6fV/AE0EzPHNIXoyGeQmVVE=;
 b=h02S7N+0e8mXjqAmL3pV4n0hE5Zwn51Nw209AtvRjDlXDPz4CSfFTgSeF4iF/e7GpkXI
 pLYv58sYjGELsLo3Yojfmwrm4cpqnYFLW1orcjq/PdT1PaEkCeUPDmpvrv14Biqa6Ebx
 mrBCF+5abzxsScsOWB0ruzlZSS03FbAJW9rGOEADNQ53K5WlLlb2gIiwX1VjDfQgHduh
 3U7oueNR/kJ/GgBu0WIGuhabb1+7fHUegQ1oNxHE3TFwFlVKIWXdt+TdF5VKuwjdYEra
 DdXJCXvywPH6o3TEKMhG4zF4gl1Uo3nDitLmT3TzjE8SQEtc8NFYJklNSw0/+8k2OaMX eA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ctse1j3y1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Dec 2021 00:25:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B90AkE5147996;
 Thu, 9 Dec 2021 00:25:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
 by userp3020.oracle.com with ESMTP id 3cr1srkqkr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Dec 2021 00:25:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9khUFVoM1mXnGmCWzcQGeF9ZFXCZYVHlZJx+mQtEBnJuayhcZYY373nhUhSDvhP02ms4kFaTxCD0sLKevpNX+Noxt2xxd9G4pDyCqiClxAlwHd1OnfygYRhV0idy97FSmL5GzdxW5fgvjoIK8D8A2vk8uAW7moQgPZExQtX4ctVyGcJPWJE8k5TAAFUZ1RgayX7qgYlpIXl0TDyndfT/KC4unFwx2slvWHA7f49GrjMJk9xldRbWTloaei6I4yldMjbRBVepQy/zngW3pIGt772pLUdUZBzdBPeNOhDKHGR4VfmMsJV5FiQYYL5Id0ppdHpHkktVedd6UdmL809sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yJwGGRk8oukOE7wU9UI6fV/AE0EzPHNIXoyGeQmVVE=;
 b=QxOE4AvTALWlEjMBf5XlEDwHqwCMxCWTvFiKol1xNY4CUtAdze4E4mG7bvIX/8EMgyjEyZg1UB6zYuNNvKewcGYSkc1x0bcbPYdPOnhWUA/DaBNFYcuyp3GSCLaM26+j9sce4GXbF1bveiL+v2vtn4izAOFx3YwloTKHpktryOaw6KNAdhIAVS3e/fscsFskLqdccPQj8s0tVNlwlHhEehlPNqHvtOoqqvxwF7rdZ87ZofsPcs9gaEx23o1L33AZdPe6BV9k0CXilq5QG9S6fNgSN0fkC7XT2f0aPlAuTGDOSnz45JL1XbClyRzbQLmUV+Y03oB0h9M/FubLC3mGyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yJwGGRk8oukOE7wU9UI6fV/AE0EzPHNIXoyGeQmVVE=;
 b=kEXb252mgI5RKi++3ZrMRneUa5k88TyXEv2j8z4mvm2VjTCKSUBbu07k2YkxN+wPgtarEyBdlraKNQPTXQ05PMbpVDCpipQJzYAq58H8ftR2UfRNa2AZAet+aIFfYAnp8kMPlCAGywvl1JIZQpwobCg+lySVpRS+rb9HZ2GP158=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB2807.namprd10.prod.outlook.com (2603:10b6:a03:8e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Thu, 9 Dec
 2021 00:25:22 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4755.022; Thu, 9 Dec 2021
 00:25:22 +0000
Message-ID: <5a9d9d83-fbe2-000a-9084-456c2a0ac094@oracle.com>
Date: Wed, 8 Dec 2021 16:25:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v1 3/7] vdpa: Allow to configure max data virtqueues
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211208201430.73720-1-elic@nvidia.com>
 <20211208201430.73720-4-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211208201430.73720-4-elic@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0240.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::35) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
Received: from [10.159.159.125] (138.3.200.61) by
 SJ0PR03CA0240.namprd03.prod.outlook.com (2603:10b6:a03:39f::35) with
 Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Thu, 9 Dec 2021 00:25:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73db038e-f8d6-471f-450e-08d9baaa632b
X-MS-TrafficTypeDiagnostic: BYAPR10MB2807:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB28075681A7D91B347977F783B1709@BYAPR10MB2807.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4jpLSp18Id0OpWlph1LJFvlraEtIGLXkgjuD81mratYjrNez0znSzyl4VXDN3XV4cIipLhASwRbYRP/o688Y8HRb7PmSvBa02UhFdWStaY4MY8pegda52CzDNs5gcQpYHNnKLunFnL1qAdMtYhlX3Yqng0XCw2Gkjv9nNorxyJz1IUz/PxVcqCxz3zpzo70a0t5DXPrIq6zFX791vCiPcn5VAWp7hTatInCkrgx9nnw18uFGH4h+qwjkrI0bDeit3zFXOGrqT2mxn8d4oqpFjDC0tNF+gJced6GkNW6kLuYe09AoGMHsjqDMEEkpxd143P9aw7JquM1+dTtVV9gifFyX0Mrel7K6GuAmJM/iIl17rd9OUyx/tBHpGQlQW4i7vDkSbTT0DEjMEYns93eUn8KO4FIqm5zLAcuc6tpmTXC10SqWP6Zm7ddm647CI0z4hqVXhTH3IovciGHChrfEqjFIZpDG/prUDngkIAS72l1kyF+wMTRftShyOvDJZUmAWQFJLKLPwV1uz7+AslhhpMthisVbPyr63yJCEmQl4jW6XwJ4VR4+cks85vyV0oXhU/m83oAaETlt77XicGzZZqSQZFHjsgEgg43r6yS88ArsiOhalrcrfiGQI0b6b728cnTFjas6uBTO3S+jy5l651KbDRRM7F85SGTlFgWNyeafY6s3ObmC+eE2JxccjV3vqePjLPmaUbzFcUVmp9eqtBwDBbIVDg+AQ39uzXIKj5ltH1J5eRVX2E5wpEO/cSMq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(83380400001)(8676002)(38100700002)(956004)(2906002)(4326008)(2616005)(31686004)(53546011)(186003)(36916002)(5660300002)(316002)(66946007)(16576012)(31696002)(508600001)(6666004)(6486002)(26005)(36756003)(66556008)(66476007)(8936002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkRQUUIrdkhZYjdIa1ZkUUZwMjZaZlBxUmNuakNCTEhpYmZZUW83RTFTbkE4?=
 =?utf-8?B?a2NEOUZyNGNEZVRKSThQcDgreENpZHVXQUJEYXRqNUp6VzBCbkFnWHMwWTh4?=
 =?utf-8?B?OUZwYkZYNmtZSVNzQjIxZkIwMmdwSkt2SXlMcE9mSWRuU1hBUGtDNlVlRVM1?=
 =?utf-8?B?UHlDV0E3SlRwVGRuSlVMa3BxNjZjZVlTaHl5Y0RlSkk4OFQvRzA5WFllKzha?=
 =?utf-8?B?aTJJS0phMzBaWjRzSGNyV3QwZFM0L1NBK1I1enhxd3JWWEQ0Zlg5Nk02cUsv?=
 =?utf-8?B?NXI3K24yNUUwby9JN2M4SUc3dHdpajFvcGVET1JFODViOE9HV1FlYzk2d24x?=
 =?utf-8?B?TzZPUGVKazgxVkZIaU94TStmWms3eTc0dXBnVGJEV3FFdXEwb05zOWVSVlVq?=
 =?utf-8?B?cXpPQlhuczlpU3MrUFA4L1RqV0pXaDRZN0J4bmdCb3BUUFk1SWZqUnM3bTd2?=
 =?utf-8?B?UWR4VE1id2p4bGxGaDk4U05qVjAxSm9GUFBjNkozN3BLdnMvUEE1SUo3OFpU?=
 =?utf-8?B?TDVEd3l3a0tKWlV0em5QcFF2OHdoSmVoclNUYVhlVTV4ajBkd3ZscVg2VThs?=
 =?utf-8?B?QjcxNUhHNmJPZVR0M0pyOHd1NWJxWmlycE03TTE4bjN0ZWgwNmNaWTFyaXM3?=
 =?utf-8?B?L0REOWNUOW1uTks1WTVHWmlQL1RTN1JMakozMWM4SjREVlN3Mm9JWWErNjZH?=
 =?utf-8?B?ZFIxZk1ZRkZZN2IwaWlKN3FNWjR5WDhYaGxXM2ZjQ2ttUjVMUFBHaHh2K1Ba?=
 =?utf-8?B?eEQ1YzhaV2w0VmMwZHBNQ01PVHRQY1lxZmxzZWtacWNycjJRM1R6VFZhMzBI?=
 =?utf-8?B?SVNSQTBUS1dIMy9ienl4emkxeGRjMEFxdjhlK2VKcm5URjY4M0E5L3dQbUs5?=
 =?utf-8?B?SXJ1TWplRjNmaW92MUltQVRRbGE1M3c3MlA4bWdvNFJGL0k3Q1FOQ25iMXcz?=
 =?utf-8?B?eEUwODc1M2JyWXNrM1d2ZmhvaU1ONzZ6RU0wbDdSMEZDMkNJTC9WTnlMU2Qv?=
 =?utf-8?B?SldFQXR4dFZUQVRXOEMxak9tRHFkRmQ3TzlRWHpwT0EzZ01UWnhhUVZiU2Rm?=
 =?utf-8?B?ZFoxaHU3anhyVTBDcVhodElZVGZuclBRVTcyS0w5L3BGbWdhYzM0bzBBWEMz?=
 =?utf-8?B?Q0NNY1c5Q21hVmxXTWd5Nlo0OS8wQ29WQWZld1MzSlc4Q2p6UmhzeWZVTGts?=
 =?utf-8?B?YnRTSXFWcGFiVlJQeGVGeXRoUFRrK3FKYUdjUFlhVVVkMm85MDJnMXc1dEhC?=
 =?utf-8?B?TEtGSmdZSVczNjRjS3RtZ3dXZWxyTEF2QlpCVnhZUG1Qd3Q1TjRaclF0b2RX?=
 =?utf-8?B?OTZ2VUVnWDNlTHQ2eC9wZE45cWsxZEY2TGNIVmdGRzRkdjB1NTR0anl1dFhn?=
 =?utf-8?B?VXVsN1JRRDZvVUdoeVdXWS83eW5NeDRRdVpmYlFidlpzbEhHYSsxYUk3ZEpk?=
 =?utf-8?B?cnFaa0VkaUxRSE9vMng4bE5ZVzB1V1ZtVUJta2ZmZVowOXFyUVpTdzRsYTg5?=
 =?utf-8?B?T2t1T2ZKd2FHakpDaGYyaDJKOG83aWE0bHRqZVRkczdSUGVRNWFUVndqT3hu?=
 =?utf-8?B?aUZUS1lUNm5WM1RDRlJrcW82NVpmbmZZTnhiRFpRbHhWVHp5UXV4VWk1d1B4?=
 =?utf-8?B?OEFGWjhtT0xReG1pWWM3TUlOMGVnUEpVbHZlWmFoZzcxd2k1a0VIOEVBcU9X?=
 =?utf-8?B?Qm8vWGdUQ0tmenpZd2p2ZnFDMUM1Z1lFNE82WDh6ajVpeUpqeTJxUGRTMTdJ?=
 =?utf-8?B?MmRNSzRKNkpqbGpCR1BEdlBTUUFlQnlsVnhZSlRFdC9yQjNnOU9VcHNMTXBQ?=
 =?utf-8?B?bmQxR0xqd2JPV0wrM093clRsNkl3dHRYVXZSczlQL2xDOW5mdXduU0ZnY1FB?=
 =?utf-8?B?emxNWU95Wm9iOHVrYXZQWlh3dElqTXZHeUQwOGRmWmlnYmVGNlU1SFM2RmhP?=
 =?utf-8?B?aWRzWGx3TjBsTkliSXFiaE5DWDM5OFBBQ1IydTJoRmpOWjhRQXppSlltNkN0?=
 =?utf-8?B?S3ZHNytvTjRPdmxXYnBxV1hYdGVuUnhJTWtlQ0YweW5ndWo0dHQ2MXBuQjN4?=
 =?utf-8?B?Ty96SUViYjFlYmJhTVZJaHVPVlNKcG15YURuZEFxTENIUGJkRkJqYTJjNkUv?=
 =?utf-8?B?enkxQzRod0pqVnY0SE5rSUZmYUZ4ajlmdUIyYjVGTW1wM0o0aDlEQUd6VUFR?=
 =?utf-8?Q?YpeeFjo0jP8ln7B0EEwbwXU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73db038e-f8d6-471f-450e-08d9baaa632b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 00:25:22.3591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYsT0+px6DcqE7oqkIn3XTebndImF3naO4lWbt1qvikL4UTDX9BTM/9MES5S0yb9vP01JeZ2z+KnTHmM74S82w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2807
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10192
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112080132
X-Proofpoint-GUID: mQvnvFR_HixF0_Ya29qmiADGij-X5aNB
X-Proofpoint-ORIG-GUID: mQvnvFR_HixF0_Ya29qmiADGij-X5aNB
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



On 12/8/2021 12:14 PM, Eli Cohen wrote:
> Add netlink support to configure the max virtqueue pairs for a device.
> At least one pair is required. The maximum is dictated by the device.
>
> Example:
>
> $ vdpa dev add name vdpa-a mgmtdev auxiliary/mlx5_core.sf.1 max_vqp 5
Not this patch, but I think there should be a mega attribute defined 
ahead to specify the virtio class/type to create vdpa instance with. 
Like the existing ones e.g. mac_addr and mtu, max_vqp is also vdpa net 
specific attribute.

-Siwei

>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> v0 -> v1:
> 1. fix typo
> 2. move max_vq_pairs to net specific struct
>
>   drivers/vdpa/vdpa.c  | 14 +++++++++++++-
>   include/linux/vdpa.h |  1 +
>   2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index c37d384c0f33..3bf016e03512 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -480,7 +480,8 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
>   }
>   
>   #define VDPA_DEV_NET_ATTRS_MASK ((1 << VDPA_ATTR_DEV_NET_CFG_MACADDR) | \
> -				 (1 << VDPA_ATTR_DEV_NET_CFG_MTU))
> +				 (1 << VDPA_ATTR_DEV_NET_CFG_MTU) | \
> +				 (1 << VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
>   
>   static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
>   {
> @@ -506,6 +507,17 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
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
> +		}
> +		config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
> +	}
>   
>   	/* Skip checking capability if user didn't prefer to configure any
>   	 * device networking attributes. It is likely that user might have used
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index db24317d61b6..b62032573780 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -99,6 +99,7 @@ struct vdpa_dev_set_config {
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
