Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7A6C433F5
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 21:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 359D14160E;
	Tue, 11 Jan 2022 21:47:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SrvI8M6eyV7k; Tue, 11 Jan 2022 21:47:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C511B41606;
	Tue, 11 Jan 2022 21:47:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BBB9C0030;
	Tue, 11 Jan 2022 21:47:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8583C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 21:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 96D3440907
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 21:47:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="SJAB21Vc";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="K8YHM9Sa"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5xPLB4Oh4D-Q
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 21:47:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6ABFB4018D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 21:47:40 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BJNw8F028126; 
 Tue, 11 Jan 2022 21:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=DPHNO1kEumvXn7zbqf6o+KE3LQsbV+MgS5tS6xZpmEQ=;
 b=SJAB21Vcw382GyinaQPrZ21p0xumkvc/EmphGT/mvShfyU8/eCETuAv3Ltu9pSs0PQ+S
 lZV0YWQi77HLYm/Y9XQUVpNaceJHfwcH6jK7OpKpyms6v1c06wulRsiER00AQohbIEii
 1a/nTiRnWi3pIVsxXKsPcwF/6RHeekgH6jmuQoCAYwZ1OKZ8RWtRdjE7sOiXz1QY/0fc
 FUjxRnkiJxTOVO8cYF3TvQk3Cn3MJVgpalLJhO5d+2NInu2ZgnuNupsG9bCskArk5YpP
 lnIFik/qalwacLBt0KhsDbbNNzFLHfxt4kRDQ3QN2UATCbbcyIQffZ0unaUoAGVc3KN8 Qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dgn74ca8w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 21:47:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BLk2vu146254;
 Tue, 11 Jan 2022 21:47:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
 by aserp3020.oracle.com with ESMTP id 3df2e5c0nc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 21:47:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2SuxpAJwboZm2rn2Ob57uY+k3Nr3AJn8Y0Kpq1VQdI/0rokuROwHMOdXWqOOzyGcAFzHbcsH2c6wQsZ+xfk7qSQ1Df+Sd4Dy/iyAe+flhBfcCyxcbOSm8e6nh2hG2vqD2BfEAnAFdN7M/qNQ8iFIEQjknxqm8EQx2gtWb+LLFRg1qvzXcfeXXpW03WAOKu547cVV50wUJ/DSg8wRDYEiv2YV+yhWSNO6VYJ2/9hPObcZyBVcTn6CdSn3IztR0zY+hPExIKyXbbC0eeytJA3z58jerAQVH4XNk79vmLrxsRsvjri7YVa0Ml0SSo3lOrftkGF6r+QFT68PnlrOCC+aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPHNO1kEumvXn7zbqf6o+KE3LQsbV+MgS5tS6xZpmEQ=;
 b=B1YvQXwXnRCxa7OzBTzJy8AdVq9jCeucnFCPVORwTzJtWZpziYBkObi0Pf1Y9CCmImpnZtXT4MVhDGy/xZwvvC0hukGjsefbsl5j/NuoAbTTes4MYiUGmXqMnrd4MbBETo1NWWvWmedG9pXW0ofD4+dlmBmdYOZ9Lvk653StNhKGPv2wExDe6XwwSY7EBAwcGGDuxPR+696GQz06Tr66U0JwF0Aj2cD4PgjDVDxmhUrXazOLAdhWA4ugTNkRT5sNjklA2+g6bQpbqZMxXSK+ssMNuBDPQb1bc+jNSTV66gl39bBr71bAJrNQgW/7zb1hHO+01TP+2SOGAYCx9UDdIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPHNO1kEumvXn7zbqf6o+KE3LQsbV+MgS5tS6xZpmEQ=;
 b=K8YHM9SamB8lrg3QMJlddWJCJbjYtuDHQMTURsdndIWRnVariFgv+xjwz9RKocBZkaOq22FKJ/zV5v9N6Vv9/H+IgMUuMIR8mOYiJSBoKe35OjcOwru0mmL8HGPhjKavie+5V79maK1zirmeH40acLPl1Eie4fvmo4BNXLWnk9o=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB2725.namprd10.prod.outlook.com (2603:10b6:a02:b0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 21:47:34 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 21:47:34 +0000
Message-ID: <9b35af8b-9292-856f-87f2-55804eadb1b3@oracle.com>
Date: Tue, 11 Jan 2022 13:47:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 2/4] vdpa: Protect vdpa reset with cf_mutex
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20220111183400.38418-1-elic@nvidia.com>
 <20220111183400.38418-3-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220111183400.38418-3-elic@nvidia.com>
X-ClientProxiedBy: SA9P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::13) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 288dad97-1e53-47ee-d6c5-08d9d54bf9c5
X-MS-TrafficTypeDiagnostic: BYAPR10MB2725:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB27254636EBD2DA82E9ECD6A7B1519@BYAPR10MB2725.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAZXQZTM8kEdo4rpa/fwZ2J8k979xC1tMBr+NkbyFWVv2Rho5ylNKslALIrLuq2XTNzWRCvCdj7aN4wpg8RHp63OYpvB1lxas2wU8DTwRORmY/ihChSpz4FiEFQmuh1VKUbTep7Zcw0UgW+9jYsL/x9HQyfepUZMj/KaOkiNWlbEskuWU1IBXhAerWAl5PrWyLICsd1Xx2Uitf3jcSia7lfMrRhVxW+ePy+wvqYkikQcWUGKM/4YfnIUPpP/p6N0YurVs6I49NW1W6mgyxffgrEN0MupWV7YJ9jxrQ/oJjRHny93zNc/gNK6NSc9WCCyTMvNSwWIgX2NUpItk8uSQcrIuRJFbFqnmQNsCiTxdHSEoMVlmpuEzzV5Ova3046bY25nABLxdM7PQe6uMf+/LNnEqwwNAfgA4OKDLWDk2c061Pg6u/gba4y73VOmwEvzFrINxplzJqm8DB/bTi9J33IDta7AoGUtVthvvVOWUa8H1xabCvvY0jJPNxXssr/SK3lSftciP9eRt0PuUb9hVjrNFBVFRqHNVmk0Eh71RzqO/S55bAVx9CaD2CYQuckqTo5atw1/QGorZAg9odiTorsLrJcFPUgWKHSCoxGPk3VI+xTNj8sUZ6GiAjUePLGTKu1ZB4iqB23TRFJC8BBBuV6tpcwRzzlT4Ru5b3vUsr6EyhKNRBmH/rqe72KorUMjjPol2z1M4E+wC7qslIMGnNQNbUmX1J5xEOTVDqWNWOc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6666004)(8936002)(26005)(8676002)(66476007)(6512007)(316002)(36916002)(66556008)(66946007)(4326008)(2906002)(186003)(53546011)(38100700002)(36756003)(2616005)(86362001)(6486002)(83380400001)(508600001)(5660300002)(31686004)(31696002)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGFiM2FBbCtwcFJ0Wi90V3ZtM2UzVzMyQlZtbTYyRTlZRTQ2UmxoL1RlcktP?=
 =?utf-8?B?b0lqZThITGdROWpYanYwOTY2K1pmNXhTcVozUGlJLzJpMi96b0J0eHNzelZN?=
 =?utf-8?B?THFlTm9hN3BHNWlnQUpMcXpteGhiY1lxcDFXUnpyeW8rWUNaMytYdHM5ek5k?=
 =?utf-8?B?NDdlY25WdEN0TkRDWnJGbWpmZFNyeG1GckxyNVB0TzJqZzdoTmpsNmFtRy9C?=
 =?utf-8?B?L3p0YklqZlViaEpTdHdOL3JLamJJZ1NUQ2s3TjVZM2RHQ2pWcUs3YnZVcmhU?=
 =?utf-8?B?cUpnSXl6YmVLa0dmbTBmbkFwakpSNW04RG5IRTc0SzFxYkt3a2VoR3VUdEQv?=
 =?utf-8?B?VmhkRnNyaEVEeXJ2U25OWm9Lb0RURCtPMllkMjVCSGkwTFQ4bFNuaDY4NFdt?=
 =?utf-8?B?d2s2S0RIVVF6YnhHK2NUWThkRGpFQnhESGtJUGZFZDdDVWgvTkVoS1dGWUJL?=
 =?utf-8?B?akNjODVPUTQyM3ptY1k4Y2FQaHVWWm1XTDVBSXNUT29TMzhaYVZCRE5PdXRV?=
 =?utf-8?B?eXhuZndsNnZRSjA3bFFlOWFCOWFNY2ZDZjdyTlUyQ1Vkdk5wRVVHUTlSYWUw?=
 =?utf-8?B?K2ljSUFIZmdBaEl5V3Z4bnJqdUhuKzA4N2JCeVdxRGZRME80eUowWGN1TDZL?=
 =?utf-8?B?aFR5ZEZDS2lEN1dUWVFSbjVMVXNaLzZ2a0dBeTZVc1hlc1VUbWlodDRVUEJ1?=
 =?utf-8?B?UTk1Z1RFdEtrbERXN21hL3FSMkJXMlpVblBFMzgvTHBBbFVaZEVscWczS1pr?=
 =?utf-8?B?MC90NERZVjNIR1U5R3dER0RqZHdHcU9FZnZIWFhKcjh4QmpTTDFkS2JRZW5j?=
 =?utf-8?B?QUlDYm5IcGtQcXZ4K1ZwYXpGZmhjbVpnQTVYU3drYmtPNzhMMUVDcys3a2VM?=
 =?utf-8?B?L3g4czdwUlNEZ1Y3ZWxSOEFRODJzWi9mc0RDV0FSSGxBSEhlUDYvZXV1YXVB?=
 =?utf-8?B?aUlna3lyTUIvOC9tRDEyQkN2N29uU0dHanVGS2JLQjBjRXpralMzaWxGcVJK?=
 =?utf-8?B?OFd3YTA2MzhMV3pNa21YN1ZVZ3l2UnBnaitEMjdlS0FoTEQraEplbVhDa0RH?=
 =?utf-8?B?M3ZXQ0N1UTdDN2NJZ3RrZnlOY0RMRXZqcE1Sejc0cnlQZkxRQ052K2phUThK?=
 =?utf-8?B?T3RDdlJHVnUwMFdsRzk4U3hBU09DOXIyQ2tycDVSV1g0dXZzTjYwdUV2VG02?=
 =?utf-8?B?NzB4Mmt5U09kNFRZYlV2Z0tUbCttSEVXbklvTDV1b1F3NGJ5d0xlZ0FIMDFG?=
 =?utf-8?B?d0lmWVM4M1UvNmxHcFN3ZGZST3FMQm42bnc2UGNZVkV1YWMvNHpHeGNkNXBM?=
 =?utf-8?B?dWxRNS8zdW5wTlNUUSs1YWE3RzkwRFB4clQvcVczblFDY3BxRjdHVkVzNWgx?=
 =?utf-8?B?TGtiUlptQVRCQ0c5c1A5NGZzZHQxL2VxdFdZYXRYU2I2Q0w5Rmh5UHJxTXpt?=
 =?utf-8?B?aThBTEgybEN1V1g1K0x4WXJya2xNQk5qQ24veFNZYlNwMTh4VzVoZm0rdm9m?=
 =?utf-8?B?ZGtRYjlXOUw5SVdoVUxyd1hKTDNobVN3UWt1Y1hoblVEbzc1cWlhdDA5T0JN?=
 =?utf-8?B?Z21TQ3JCNmdaYklXbHBCaFU0STl2cjFEU1Uwcnp6ZE56M0s3ZlkvLzlHWTZV?=
 =?utf-8?B?SllSTDhZc2FmZHBUYmxwMnFrTDBSejdjVk5IdGttUzZuYXZlV3d3VU03QS9i?=
 =?utf-8?B?Uk1xTmJ0ME9hUncvVlhMVWJzSnQvSml3K1MxSjBGN1ZEUTlSc2p1QmdCMnEy?=
 =?utf-8?B?cHJGQk92UWJkcUVTcGx4RXplL3pCQ0NLV3QxOWE0ZkQxdzIxT0RONnlVS0JZ?=
 =?utf-8?B?S0NkK1VEL0xRWE9UZjQvdDVnSWp1Y1lmL0pycktYVCtXaVhGQzQ1YWFBYjRh?=
 =?utf-8?B?TmREcEZlZUJocmtPWFc2WGRqdWE3eDZsbkNIdFRwUmFUUEVvZW1EZ1hTQ2hE?=
 =?utf-8?B?VjJBU0tGc0Z6WGI1MDg3TmtaKzJqV2pJeDVMVXc1czVOYmdiaFVMcExPUFNp?=
 =?utf-8?B?L1VtOXgzTHZsUDdZdmhuMU1WQ3J0bVlIR0p0RXd3d1BSd1BjL2RWRkQyc1Js?=
 =?utf-8?B?aitGQm5oNDZwVEthMDJ4RWVZaE56UFVadkM0OUVjclowMVR1QUxMZDlkcWYx?=
 =?utf-8?B?TXJCSDlOdDF4cGJ4NTBVWTVyL0RiNm0rL285OUZlcFBQNEFrYmozaktIcWZE?=
 =?utf-8?Q?4VQPOOWG7mJWCOKE7YuqQ+Q=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288dad97-1e53-47ee-d6c5-08d9d54bf9c5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 21:47:34.4703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhmUqErEKpRlvJNK9ulXGe0GCeu8kRRzlImvCAYS1S5Nkb+cAJvaIFx66Dw876RA7e53x68bFEgXl08YO7stPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2725
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110113
X-Proofpoint-ORIG-GUID: XtHudDcN47pmA9cQw9fwWngltGHhlMDs
X-Proofpoint-GUID: XtHudDcN47pmA9cQw9fwWngltGHhlMDs
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
> Call reset using the wrapper function vdpa_reset() to make sure the
> operation is serialized with cf_mutex.
>
> This comes to protect from the following possible scenario:
>
> vhost_vdpa_set_status() could call the reset op. Since the call is not
> protected by cf_mutex, a netlink thread calling vdpa_dev_config_fill
> could get passed the VIRTIO_CONFIG_S_FEATURES_OK check in
> vdpa_dev_config_fill() and end up reporting wrong features.
>
> Fixes: 5f6e85953d8f ("vdpa: Read device configuration only if FEATURES_OK")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
Reviewed-by: Si-Wei Liu<si-wei.liu@oracle.com>
> ---
>   drivers/vhost/vdpa.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 0ed6cbadb52d..851539807bc9 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -178,7 +178,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>   			vhost_vdpa_unsetup_vq_irq(v, i);
>   
>   	if (status == 0) {
> -		ret = ops->reset(vdpa);
> +		ret = vdpa_reset(vdpa);
>   		if (ret)
>   			return ret;
>   	} else

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
