Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1669C433F5
	for <virtualization@archiver.kernel.org>; Fri,  3 Dec 2021 07:32:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5466D4016F;
	Fri,  3 Dec 2021 07:32:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lr1c2tCZ8Y7F; Fri,  3 Dec 2021 07:32:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BF7084013F;
	Fri,  3 Dec 2021 07:32:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AB64C001C;
	Fri,  3 Dec 2021 07:32:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B736C000A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 07:32:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EECE760631
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 07:32:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="LmhTLu40";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="zfANNSjV"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZJfoNEfr7L1I
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 07:32:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF5996060A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 07:32:18 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B36RbRx032215; 
 Fri, 3 Dec 2021 07:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Uicds/wPJhFoVCyIPEiAOkXsCNKrhEAVllJHqz7hbMM=;
 b=LmhTLu40r2MBeVHZcwv7npMjkLawlEIQb0kN29EhSNMA31MRicbTvmCCgaFMo84bVABE
 ZsUtAB5S2Jg8Jff1V7cokwjUWMfmTWV5Mvz2C12Ib7+2CoMNgZuBuHgtU+guVKOyscz+
 z3I3UQtV2BKtx+4MaHAMpWNdcGdeZEJ9eVCYv94g1NQ6d3iZvFPD/cH73GK3nK2GSGTa
 ovUTqXByDEU+FsTUQpMbR6kIe/LC74EsNp7moJzHMkNr1cmEv33r449iE3hBkC/u+pg6
 F824jywFH9Yv+I+iUP0byAH0mLde0721b62ZKSg7S6L7+q4kVL2FBkPzeQfhZ86Gqi6D dQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cpb70e1xs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Dec 2021 07:32:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B37UvlC003103;
 Fri, 3 Dec 2021 07:32:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 by userp3030.oracle.com with ESMTP id 3ck9t5qt6n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Dec 2021 07:32:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeflfvNmlW/bcJqKhan4v6Cg9NB5hTeecvzZxnVIAQQaYbWfoe1aDY908BbQqIR+2H4UOAxrlZRwMKqcmMZNY1xEMGCx4s5N3eMTscH4DLeBiusS9VSpKkOiBJiSkXEeOBM8fERoNWhiCeUfnLV3ZivBPSeN9Dh2JGdYLAtjNqR1ehHiSHaVeFF4vD3+dSiojlvbf7yuHG1rcUd7BBC/5WeSoLDHuitbUdpfeK7lCmdxGTP42/oBTVPl+MgM26OGMITZiX8ipOtXLd67Tt0I0nP5sVg1kHoOW81z1wQ+uyPYlI6Q0xPH2XXm9jgrJZtFk5sArUFbBWw6MK8scqhByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uicds/wPJhFoVCyIPEiAOkXsCNKrhEAVllJHqz7hbMM=;
 b=a8Bvx1XtVx+Jn65F8CXUokwF2IIdIWViklXZfmUItmglN2EjFNGRlygKRsCG3NXvm+UoJ/UUBWi57MmkNBh0MRYJrKPhA5LC+OFhcAV2Ewx+meC/9DwJn8Hom7SoIAemtXapTfUVLYZZsA4uwG0/tkxzpOJdix4eQVZchv5wESZ5B2TE5aRT1IGoCIjpI5DEhfcxFoLKXiYHkD4zGM/9wf5bF4z2pnJYpRl5l3ni+gG/GncVrHNVKcf+z+448IU++0++6hbfioY4Hx71H7xDkKJspaT91LkFyEqiJDexAXmmsKJehhIR6yrEjfNbTR2qprix+vnQCVWfGBRmfsJCsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uicds/wPJhFoVCyIPEiAOkXsCNKrhEAVllJHqz7hbMM=;
 b=zfANNSjVlkWQoOh/s3rYCYfq3CAlWKrbzCkxcoJoV3TVVl9YeqokcSQ44qhS2R2jnsOAan/c2I6nYW5xIInlYS9Dgq8AQOyTJgxt3gW1TAtAiFT7//6lXsXTKudh9Q0E/ZZ77cqKvT8Sq+kCcPSXh8hQXjVeqhFxasy3ANG5Gb0=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BY5PR10MB4324.namprd10.prod.outlook.com (2603:10b6:a03:205::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Fri, 3 Dec
 2021 07:32:12 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::89e7:42b2:b226:2182]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::89e7:42b2:b226:2182%7]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 07:32:12 +0000
Message-ID: <b807d549-3bf7-dad8-503c-a50c378486cd@oracle.com>
Date: Thu, 2 Dec 2021 23:32:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 4/7] vdpa/mlx5: Report queried max supported virtqueues
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211201195724.17503-1-elic@nvidia.com>
 <20211201195724.17503-5-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211201195724.17503-5-elic@nvidia.com>
X-ClientProxiedBy: BYAPR01CA0061.prod.exchangelabs.com (2603:10b6:a03:94::38)
 To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
Received: from [10.159.148.88] (138.3.200.24) by
 BYAPR01CA0061.prod.exchangelabs.com (2603:10b6:a03:94::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11 via Frontend Transport; Fri, 3 Dec 2021 07:32:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21475a8a-ac7f-4de6-3929-08d9b62f0544
X-MS-TrafficTypeDiagnostic: BY5PR10MB4324:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4324B38A0659DEBA60993F03B16A9@BY5PR10MB4324.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HBRR8SihLYmjJMTmHSF1SolRI5FNx7+nfMR03n4e0wpiLsk0M2sqjrbZaSrL5pnYx4nQ/6nfC6QtUwzBwt4v1Kitr4QF2P7WNiP6S3n363q8pR1dC1dBfqnVeGx+ItytMqh/fd8fnA1htWHD0UTxavUqhE206gyXORQt96OtWu8gf958LCLCKw76uNFvQAi5RgVM6lTaVriBE0LVVXofJOulNhmYukTjJR6tX6Xr5U/FkmD+FXe1GjXcN1c46oey51cRMybZLmFT9Qe4fG6FvU5ByHNmaJi0UueCLyk03IKxxJX740w5KxWbXijoPEYodgdaOWU2TQXSTSep7Wd24CH8wpgXo0r84rYxBCZdUXBWex+s72VbexTwBGMo2474iwXwUIiqtDGsql+LdDBUfnNO3lG06q5C0grwPxL1dq/kgMR+hFSlmE2Xq3FsjXeSha5Ih21ju4w/4jftB/neyeilf2plNm0h7LU5kuUI05YZ0W4RpKtf8hyWvLHhoQxeBYrwGKAqRXOa8yuZ3dCayn8R1z6vQUGWofdDRxzMucyUSlEvS5ynzuKWvza1CNXX8nH15dvjtp1+Aj7kI1lBnHvpvCVv3JHzfn6B0xXyRfELaXfftGnqv/8eJXYhgaCVwLiJM07FybMAPHGTdy45dxlm+gt0qF5QwrzTuPwkCP/sP9n/nSce09D97Dw2UDFDxJen9/Lm9JrI5rtI5vgvyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(38100700002)(2906002)(83380400001)(508600001)(8676002)(4326008)(16576012)(36756003)(316002)(66946007)(6486002)(53546011)(31696002)(86362001)(2616005)(956004)(66476007)(5660300002)(66556008)(31686004)(26005)(36916002)(186003)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RElSSmZ0eG1LSmJsaHl0OVovdG1JaDAxVUNleml6WWJwZWQ3ZU5taDhacHAz?=
 =?utf-8?B?VGJNQkt4bWZvT1RlaUdMOGdzY0pIeTNldXl6QWs3VFpYZEdaVDl6K2htU1pq?=
 =?utf-8?B?ZXhNZ2VlVHY4ME5STDczV2ZHeG5QNGRLaENhVzFLMStBVGFVMnlpZWhxOHVT?=
 =?utf-8?B?RzF2Q0RhUHB5aDFVQWl1ZDZkK201MElXOWtsWS9lb3ZVUGszekVzdk5zc0kz?=
 =?utf-8?B?ZTRMWTk1c3FRa2xzNGc2aGRvZjhCRDRGaWZJTjZjM2c3Rk9Lelpac0pHbW5M?=
 =?utf-8?B?dXpPc2ZKYk14QS96VFJrbWpPRWRra0VWd2VXYVF5THZ1aTZVYm1ZUU5RaGJD?=
 =?utf-8?B?Zm93OUhNTlZrajd4RU43M1ZIVllpS1RNOVdic2ZrWDYxVVAyMGF4d0xUN09K?=
 =?utf-8?B?Wk1sREJvYjd6djMwbzZEdUk2MllFOHRmUkpMdmVMZzFqTXlxM3kyT1JUTTFa?=
 =?utf-8?B?amF1eHhIZEI1eGJsU2w1V0FCNDJVUlh5SHdjRTdpMS82MGZIb2dpVU9IMnhn?=
 =?utf-8?B?ZC9YcTZnbUgzWFd0RWlxb2p2b0VpeWtIL2oxUVdsakxNd2lmaExybHNNbWQ4?=
 =?utf-8?B?czJVMmxoWTYrWXc3NTBaejdlK2xSQlpmMmVTZ0kwZE5sSEdpSkF4aWdqTDI4?=
 =?utf-8?B?NjlvNXZ5ZXhyQXRDQklIMlY5S1YwOTlHaGxyZUQxYU51MTM1aE8xM1pFUTdn?=
 =?utf-8?B?V2tWUWwyQ01qVlA4YTlvK0tHQm81VCt1enQvYjJQSEREd3A0dmE0T21yZGpR?=
 =?utf-8?B?WTlrSi96eGV5Ymo0eWRRYjZXc0crRmw5Rkhud3pEdEptclo3OENLL25ZS3BG?=
 =?utf-8?B?RENoVmN0aE90QUk0VXB0UHNyZWJBdytxOGJQdG16ZnhMa3k0aWlQaGdWN21M?=
 =?utf-8?B?bXVkcC9xL2Z3M1l2RlF0cTQzUUZVcHNFRW5KZEVyMGVMMGlZU1NVS0dLUCtq?=
 =?utf-8?B?eUFOUUhVdzFQWkQ4Yk8zRWJISjQ5b3B6NkI0cHp2dEtYRk5xREpsd0dMNjdH?=
 =?utf-8?B?b3dqaWRFZHJSVmwvck9ObW84YjZuLys5VG9wYVJzeTNINU5haEpGRU1QUXVa?=
 =?utf-8?B?V0g4VExHM1pXTnpNdGdGQVZrQ0JnYnRKNXMzMTRNMlpyUGREb05RK3RwS1VF?=
 =?utf-8?B?VU9EY2JJZE1HQi9DREVxUmdLNC8yLzF1Y1JveEJhOHpaUCtJYzdQT2VxcTdY?=
 =?utf-8?B?ZlY4NkxiSXdDQXN2YnpLcWl2UElWeXdSU3NleTlNelNkS3FWbVJBTTY3cEF1?=
 =?utf-8?B?K0UrZmFDclp5UEtLL3dOU2Q0N2MvWGluTHg5bmJGQUIxTjRUUlkwQkVYTjRu?=
 =?utf-8?B?YmgxMkh2VDR0eVZ2NVFHTUZkbEdFOHQ0NncydFZhcjkyQXVQODRxalVLYzE2?=
 =?utf-8?B?amExUy9zS3gvQk9Kenh5dXBXbGVQcjQyY1d1ZFdiS1ZqcC9xR0ZxNCtFQmcx?=
 =?utf-8?B?VjlnWG03emhCcE9OcWgrN0lrSUdQSHU3MENYMDFMZnl0S1hFQk95dGtoZUt0?=
 =?utf-8?B?RFlMRW1OOXo5a01WdXJLVjlzVlVJZ0xiTnRWMG9PUldMcWJPdjdEWjZIcFhw?=
 =?utf-8?B?RkxWNXZJS3ZpU29VQmsrVEpJVkhhRGxqR2Nha085L3FnWlQwZUlhNXQwUVZv?=
 =?utf-8?B?NFpGZkV5SCtvRFNOSkpuOGdaZUxJL1ZVam5iS2tZZzRDdVpsK2hQdmtvQU9H?=
 =?utf-8?B?WmdUVDA1VGRsUSs2YWlLZjdiUDUyMEhjMHEwUlJiTHIwTzRTRU56eXdwTjFK?=
 =?utf-8?B?aDJySng3UDhQTDA0eThwaWpjbUxrdzdqeC9KbkVGeEZIZnVLNHlsRWNvZ04y?=
 =?utf-8?B?ZmRqZ1NiNzVRYm8zQTBwZTRLR0JBOEFpbUN3UGlxWHRrbVVwRTVyYlhGTGVT?=
 =?utf-8?B?bU1kYlBING9BS2xoQUdYcnQ5L3ZiMUMvUnpIYktUa2EwUHRrYnNpNTlhcUgv?=
 =?utf-8?B?aXRQYm1rbGdzM0NydFVraU12WUNma0tkQ2RTL1VBN2pjV3QzMUo2aEFFdzZ4?=
 =?utf-8?B?Ti9PRlByb29HRlk2cVJuWEVNZzNjNFZaeUo5RFc1K3hDRlFEWmpTZ2hsa3Az?=
 =?utf-8?B?SkEwREc0a2IwYWhaaG5ndU94RE11azVqQ1cyNlJwZytsTmlXbjZxSXpvcEFj?=
 =?utf-8?B?Q01lRjR6Sjh0SVVBOHZkUTVHL0dNdGp3RTRtcXQ4V2VBQitrSzZkbjFIMitl?=
 =?utf-8?Q?a6aiXwW7E4BA3Gu9dNmEldo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21475a8a-ac7f-4de6-3929-08d9b62f0544
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 07:32:11.9150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: we2jk9BPWRSyxS1NnxYBLEZmNByI5KxaokAZlR3icwd3bo0oMS2pMRIsqOa6G1Xq31G2hIo90EmMtN7+iCbDGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4324
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10186
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112030046
X-Proofpoint-ORIG-GUID: KzKPBvuFAc2GEtRv6v__DqegMgcPKENE
X-Proofpoint-GUID: KzKPBvuFAc2GEtRv6v__DqegMgcPKENE
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



On 12/1/2021 11:57 AM, Eli Cohen wrote:
> Report back in get_vq_num_max() the correct number of virtqueues queried
> from the device instead of using a constant value.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 62aba5dbd8fa..336eda3dcf41 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1992,10 +1992,10 @@ static void mlx5_vdpa_set_config_cb(struct vdpa_device *vdev, struct vdpa_callba
>   	ndev->config_cb = *cb;
>   }
>   
> -#define MLX5_VDPA_MAX_VQ_ENTRIES 256
>   static u16 mlx5_vdpa_get_vq_num_max(struct vdpa_device *vdev)
>   {
> -	return MLX5_VDPA_MAX_VQ_ENTRIES;
> +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> +	return MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, max_num_virtio_queues);
This denotes the size i.e. # of descriptor entries in a virtqueue, 
rather the total number of virtqueues. You need to add another op 
(vdpa_net specific) to get this info.

-Siwei
>   }
>   
>   static u32 mlx5_vdpa_get_device_id(struct vdpa_device *vdev)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
