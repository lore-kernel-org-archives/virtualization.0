Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62422C636D4
	for <virtualization@archiver.kernel.org>; Mon, 13 Feb 2023 06:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7FAE4109B;
	Mon, 13 Feb 2023 06:51:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D7FAE4109B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=bZPCXuhO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=gzdhxIdP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G7qq2v8TEu3R; Mon, 13 Feb 2023 06:51:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DC279410A1;
	Mon, 13 Feb 2023 06:51:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC279410A1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CBC3C007D;
	Mon, 13 Feb 2023 06:51:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0C77C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 06:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9D3D560EC2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 06:50:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D3D560EC2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=bZPCXuhO; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=gzdhxIdP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rtkud1BnUmvT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 06:50:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A6ED560EAB
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A6ED560EAB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 06:50:58 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 31D1iPDf026123; Mon, 13 Feb 2023 06:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=C5sA2RSFuEvG2Uj7rkojeC4qEgQEbNOrVFivAC1ufhA=;
 b=bZPCXuhOBE0OJBJTnWQYpyIQFKNoXBEe8TRMsnReEKDQzSuxADmQT5uF/9eLJcajVXkg
 4wWhrJ5pDE5h0QYJo3ZJ+MEJrgzl7adEnnXbp/UKgD2hWvWJxIlR9IGg1FqbuPxqRsW3
 chdg79F6F9jvAOw7euN9Ji6VkP/Hayy9JJVnWa20if0dDkgQb1DBdMp+DRw06gN4NYgw
 sWD7Rdho2xEnrawXPTWLG4st3jPxVhBFXlRz2025KsaAi1CH91gcSzaxcWesu71uwvlX
 j9FiNd4yJ0LM7EDO7aUz3RJrUat6yhugKS1mMJWKY0u83GkB1UehmBsSdDKUJbBklfDL Nw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1m0t476-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Feb 2023 06:50:48 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 31D6H5q0032641; Mon, 13 Feb 2023 06:50:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3np1f3q0ny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Feb 2023 06:50:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXOD6F9jPM3mT634zCIVH/NbvHXv8Bl9Ute5WhwEqHRshE5NqFYxyyyootKdeo/IhtEpGxEZ/ZlY34tsKCZg1z186Pqq4rDCEnVvcZWt4dS5G2gwiFRaA182Hrg8b8xkLXpnNxLSGRYTUiT/U6DbHoxKG/Ab8kyVG6oCsG5XqYNEmjyde0gDCDeCSbtDrK5DuO61K/Ge8PtXCyeZzKNbVKVD1wanaFcpiXSbEaBSE9C8V/p8Ej+V+JjKZDMKBx0bnkojbchwaBwZajx6Csu/d102dI16tj7aOkU62mFn8JP6TBuxMnoEvjfr4KXoQ2A1wyI0wbExewtPul3ndzqXjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5sA2RSFuEvG2Uj7rkojeC4qEgQEbNOrVFivAC1ufhA=;
 b=EshQZYAclt5oVXYzYxdmy99WSoHSnT10A9ufULkmEvQlVJrSbSwb7BUvtIUjfvv1upUxxO+VsGGsO0Ar3WGOIXgjtjN1CJqqprNXM2KL1UHS/Czim/9c8Patw9O5LUYfRaWxbttZOfU5q1K9Od6z/8jx/cXbwrxEcpFv/xK+Lhf+uaofKwGJ4nZ7RYWuWkA8qlGuajYHPJ9DDDzaof6VcY7X4ccwMk80Ab3P0BVPHfhpSU++7jFW5y2ydzR4a40OFKgPyjmQP7kN3cU3JI7ojZ+KkZBw819tigEL++evDhMH4RHQ653STiaNSb57CPEPc8+uDhRXQcLcld38FEBNVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5sA2RSFuEvG2Uj7rkojeC4qEgQEbNOrVFivAC1ufhA=;
 b=gzdhxIdPkKWSB4g1DxwaG/zRyFFQRC56CaD2VDqKa72OOM7D+4I5uAMDZFWrm3F72yJ150BoOdOfQXpLGRqLsXYA8ztBNto5xAxetH2WxoC2J07XLJOqrWtVKNRBSW5f+j7xTvMDy6dLSdDtJcfWSBm8+z1XkLYYDTznibCc3Qo=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by MN2PR10MB4272.namprd10.prod.outlook.com (2603:10b6:208:1dc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Mon, 13 Feb
 2023 06:50:40 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3%9]) with mapi id 15.20.6111.010; Mon, 13 Feb 2023
 06:50:39 +0000
Message-ID: <2901fd82-5c0e-c830-5288-a72b8c08d628@oracle.com>
Date: Sun, 12 Feb 2023 22:50:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 07/13] vdpa: add vdpa net migration state notifier
Content-Language: en-US
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20230208094253.702672-1-eperezma@redhat.com>
 <20230208094253.702672-8-eperezma@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230208094253.702672-8-eperezma@redhat.com>
X-ClientProxiedBy: DM6PR07CA0128.namprd07.prod.outlook.com
 (2603:10b6:5:330::20) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|MN2PR10MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: ff6db832-31c2-4092-3be9-08db0d8e9e65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OKP4tzeg73tJdE3zC3zt2bqXXiXJpM0hXXUKCha0gL1+5jsCr14y7NROAsC7z20KXMgIySys5apcXexQql3jD/bUV21824+a31cR6oqcGPVICm9AkqI6TXlO7nU2OkDK35MzYx2Mmgb5KFDeyt596UMnx4CWp5TXyKV22wPCWXtYzEVxayA9DIgNYuoksG+OWaTbcLuaWSuz8en9u8UTptEs3eRSkEqpylNggWbPRLlNOzvNq8t9z7DSmMzPO3m9pz0v+8neZAgOOzYC6cFdU1OXSlfr4ljxlKR2jMJViZaYlihsGnOGQi8OFLsJ7Q8/YHcIpEOwFIqPprO83wcuBg4ks5M2uO+SERmfi5GKAsBHka0LGttha5Hu/K9hrrd4MbVZcjgVAzNSXLsPzaPaPhy86IKuuVHwu0kjCCEjuBf9wWl9Px62xEclFXmLxA+bUkxxtBrDMDGEcCMbvkKnWGLL0DSbXkkXEdMu+8BgFf9+lYcE1GgF1FzsTihWAN1THxxgOIIAU23ClJqI8ne22njMHB7RPNTrQkhKqyE1/+kpXEs7WmKRRli9kwGuXj9XlkmloxYENPyy9gRJ23MuPpjEKuiPvBh9LsWMXNi++o2/bsfpOXe1/+tGc439B1pxm+0YwFui28h877bq2aVBdfqRCQ3tvnVkrDMSOugdlJAmr33CxseH5dMk2z5Rr1R3tCN0BuRNPgMDZoSbOfcxr8DPdSqSeKb/2trBQHE4lh4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199018)(38100700002)(86362001)(31696002)(36756003)(2906002)(41300700001)(66476007)(4326008)(8676002)(5660300002)(7416002)(8936002)(66556008)(36916002)(2616005)(66946007)(6512007)(6506007)(26005)(186003)(53546011)(83380400001)(66574015)(6666004)(54906003)(316002)(478600001)(6486002)(66899018)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk9nSlY5MUl2OEZFaUJTQWszTUxXekFLeGFJYS9QQmlaK2Z1L1ZwQm80WEE0?=
 =?utf-8?B?UDJSa1BsWVdnUDVoQmdVZWZGelRZaFpxNkJVUUU3SktOYzRpSXAwaU5GNStZ?=
 =?utf-8?B?d1hZZUNiV0dDRHViZmxlUFM5R3FIK3RWSlQ2eUZRMHY3cGhsRkoxU0Zta3lu?=
 =?utf-8?B?TjlYaUFoZ2V5SHlzdnJCVkM2cjV5UzFuWjY0WWpSNXF6eER6S1BDakNueHNy?=
 =?utf-8?B?aFdQOUtPTU5UWWIrQzhCU3dYNHJPTlIvbVcySVZveE92L1pYbktTSG9kR0gv?=
 =?utf-8?B?VFJZbkY4MWpIM1pyWG9QRmUyRXZ5UjVnUU9GN3dyNHBSM1J5YlVqSDJUWkRT?=
 =?utf-8?B?S1d5RUF0REVYRCtpbG56ZEFZdjFtNDNFbktyRm8rRlRnWmFQVDh1bDN1c0dS?=
 =?utf-8?B?dktaMG1ORE9ibGF6Zkh0eEZNMWxhSkt6eGpYMFNxcmVDaFUzSEdILzg5V1VH?=
 =?utf-8?B?dzRNdW50bkpVL1lXQm5SbGJZK2ppMjNkTStYdmVFbjduYjJFRVFFMm50ckxi?=
 =?utf-8?B?QytYS3FPdUkvc0kxQndCVzZleDBqVU1vWkM1bXdVTjJQTkRmZGtaczhYQkk1?=
 =?utf-8?B?ZjlFbVJ1RVI1dnFWTWdzSVl4MEJZSUZJMlAzSGlUbjgySURqOEJtOGZWYkk0?=
 =?utf-8?B?MlFGMTVEQ2hiRWdmQVg4SFMxUUxmd2dxOGtHM2krTDhxNW1oR2hwL1A2ZUxG?=
 =?utf-8?B?TVRvSERIQ3drTGNHZ1FGQ3lZK1hjWXFpWkhUZS9TMUNVZ242elg2bFdYSmtJ?=
 =?utf-8?B?Y3pQQmNvR0FmTEFlY1AweFVGSVRWRStFdzBpRTAyMDlaVWdHVGtkd2U4VGtw?=
 =?utf-8?B?QnFRbzhQV3RYdmE2UFRqZU9uQitKTW9zMlVrWjdsQnQ3dUZnSUdwbHpib0s4?=
 =?utf-8?B?bjM4ZHQzWklyUC9HdGtpUE9iamREVy9yRHJ3eXNFTTNDbkhLMFFsRHFKV2pC?=
 =?utf-8?B?UXFHcjJlSDlDREdZbVV0eHliQ2E4WG5CS2E0ZFMvcGxZWFhtSWl1SlU4ZEV3?=
 =?utf-8?B?dW0yMzE0ekxQeWYrSzljQm1RYXRzeUpTR0tQbXcxSzdhOGExMG5WbG8xajZt?=
 =?utf-8?B?OVJuNmFJT0hwTG5ENWNrNjVmKzNmNys0K1pFZUtRajJYWjBRSDQ1Nm5zQ1ln?=
 =?utf-8?B?cGZPM2Fpam1PMDl0MFVJOVBZcm1DTjBMK0NXOHJkaDQ3YyswYkhZbVJ3ajRU?=
 =?utf-8?B?TmdlWE5xOFZmK0R4QTh5Y1VWRTlYbFdpeDNGMFRkdERDZmlKb0FDWDNwa2ph?=
 =?utf-8?B?VW9IWHVRY2pSdDlPZkZhRTdGK25sMzJRVkY5aUhQd2RzVXU5NXhWeU9yaCsx?=
 =?utf-8?B?dGhZZHdHaE5Da2tzajVyU0ZBd3lsL0lwcUJ0dy9Jc1dHM2xUMk5VQlpFZUJ4?=
 =?utf-8?B?Y3pvSC9JT2p2a2htbWJDUjRqNkhuRkVxa21tL3VHZTllcG96MXZ5K3JEQnU1?=
 =?utf-8?B?YzY1ZERMbWVSRStQZ2RvZW1QTFduTzFOS1FBaGdweHlqTFFWdHBDellZUi85?=
 =?utf-8?B?Tk1JZVhhYWJ0WWJRRkRrTHVDcmhBaXFoMXhSYjhKZVZuQ2hzdVowb0xFdWtk?=
 =?utf-8?B?VzBKT0RacVlIME1yTWRuMlVtdVBoT3BOWUtOWHFuekpWSDNjcTg2NVF6RGg2?=
 =?utf-8?B?NVRDS2hFYXZWRW1XOTh5UDhISHVSY1Q3RHoyMitVZzAxTnVuZmowand5dGx1?=
 =?utf-8?B?b3Z3NGh4eEhuQTVNVVkvempZOE5VTHh1bzBPblVzVC9oK21BbFhLQ3lhRnFa?=
 =?utf-8?B?ZzhSbkplMkZlTUx1dGpIdlJHVHFUYk9lVDQwRnpWcUtDTlVPODlxQWl4MjE3?=
 =?utf-8?B?SHVDVkRqaDZ1WWU5clJYR05RUTA4cFNBTHZOdWlnV0pOV2lnNXV2R2N1MVQx?=
 =?utf-8?B?SGxTMWlJV2QwUG52R1ZMSi9xc21iZit2Y0cyOVhnVjRjZWxXeDRjYzVwWEo5?=
 =?utf-8?B?aXYwa0g2UHJmbmJMVWgvTUpNbmtsNXM5SmFIYU9KUTJYVldwNTB2MFV0VUtZ?=
 =?utf-8?B?Zm1SSmdoRjNHaytuOTJ5cVYxdlB0aWVaM2ZjMkUzU2hpeEh4WHdocnEzY1hh?=
 =?utf-8?B?YnNkTjlxQlpCcWVZb0k4cU1Ram9GTFBOcmVSQmJxVXI5OXNQYW1ObVFzc1JV?=
 =?utf-8?Q?1Vlc2i7pOnbY1qzoSq0jFR7/V?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RHZZNldaQ1I2M3NjRHBHcFFSWEE3bTJjVkNZbXhXZTBvdkhmbllhdW1kb1NL?=
 =?utf-8?B?dmFZdkxEMzVaUGJaN3ZqK3doUlQ3U1VEM2ljUVZIMENNaEczUDNOYmxOTkVW?=
 =?utf-8?B?ei93Zy9NVi9zSEdaRXg0Tm9ZcVRFQ25JMUk1WC8vbkhYeG1QYVpQSUhUeWRw?=
 =?utf-8?B?bENPWW5YREEvVWRHQXA5MXc1SE9MSnR5VG5zQzNSVFhvSHpkWFZiZ3VyYVln?=
 =?utf-8?B?YWZNdWloclBFLzdzamJnRUxoeFBEazUxVk1WUHNDVE52Wk5BbXRTbDhXVzlz?=
 =?utf-8?B?dE5ncTUyTVV2eG43Q2ZNZVlrMWZMRStjdmtRcGlEalQwQVlGS2VlQmJiNHBW?=
 =?utf-8?B?RkxINDdhZHZVMEJleUl1L2t1U0RENXkxSjV0ajZha3hUT2pYN1hVV3NURkE5?=
 =?utf-8?B?RnpsYVVzWC9KaExIaHhjbkQwMGVReHhTRmZ0OGcxNW9PRVRydGxCZDk4Umhx?=
 =?utf-8?B?VU5PZzRNV29SZW5ZVGVraHl0UU40VHU1REhPMjlodk9USktOVEJ5ZzFZVzdF?=
 =?utf-8?B?dFJHUlM3dDVTenFpdDBZVW1USDF3L0t0NG5sejM1bHQ3Si81R3BDY1pCYjFP?=
 =?utf-8?B?TTNXckV5YnlqMWwwKzhrOW5zdTFuYkN1aXBuajFpYTVYS2R1VnAzT3FseEtZ?=
 =?utf-8?B?NmVCT2VCUEVPczdUREszUzR6YkdEV2lObU1jM29wRloyVGQySTJSMndWZDRR?=
 =?utf-8?B?UjFyMmthaVE5dDR2c01oY205QzNEZVVhaWc5WWhvL29WdnlYMkZjdHJUWVVS?=
 =?utf-8?B?RVRBNjUrT2c4ekhJazEwVVdFMFlHK3pRUXJFeFJxb0pRU3R1Z1ByeE1zUUwy?=
 =?utf-8?B?bCtLTzIyVmtMaUlxd1NLK3pJSlg5N2h0QURheW5IamFJcmZxZW1qQVU4OUhW?=
 =?utf-8?B?clNZRjVKUmJYdDFXSld4MldXQS9UUmF3NnQvaEt3Qk1GcUZxaExRSDQwc3Vr?=
 =?utf-8?B?aGN2N1JQZ2t4UXFtZ0lyclNEaHY0WlV5ZEV3SE5XbzBTcDh1MXZTUGlVWnpz?=
 =?utf-8?B?c0JReWFITExDVHVXNUJ3SVZqYjFIYllwb3haNDNBMitLM01QMDRiQXdXK0NW?=
 =?utf-8?B?UXlDUXNyekFxaHFmWVE4TGUydHJEckRiQTlJdnp2dU5FaTg4ZlVxeURtZVpP?=
 =?utf-8?B?Wk05ZS8zdmNJM0dpWVRsYll5Sk9OQ2QvdDBPcEJsNitOK05lV0pacnhWNm02?=
 =?utf-8?B?NW1XUUVlWEpsL0grQWtJZmRvSlJ6NjlRem0yeGgvSFI5MVA0eDlCVXBORXM4?=
 =?utf-8?B?VEV5b0l3UlJUQ3BNeWFaWVAyYWd6NUh3T0JOWjFycUF3eHUyb2VaNzR2QzQv?=
 =?utf-8?B?aGZ4ZU5GWW1iMC9ueDlxUGluVWwvTUhFMGc1bGk1OWdXUlFhSGcwSFA2WFBS?=
 =?utf-8?Q?/hW9M7v6bQOANv1kdqyV6oFNTtJrRUX4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6db832-31c2-4092-3be9-08db0d8e9e65
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 06:50:39.8415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehK1mzbDZSvmrgc8borYA5jvDTLrz8/Kj1ubATlhcWT8o90dYifjYSfRte2i8InzYCBMEQJSHLvY+F546SUY5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4272
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_02,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130060
X-Proofpoint-GUID: 0ePJpfaHVuym7S2bIC6jZtOhJRW_KPER
X-Proofpoint-ORIG-GUID: 0ePJpfaHVuym7S2bIC6jZtOhJRW_KPER
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gautam Dawar <gdawar@xilinx.com>, virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Lei Yang <leiyang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 longpeng2@huawei.com, Shannon Nelson <snelson@pensando.io>,
 Liuxiangdong <liuxiangdong5@huawei.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIvOC8yMDIzIDE6NDIgQU0sIEV1Z2VuaW8gUMOpcmV6IHdyb3RlOgo+IFRoaXMgYWxsb3dz
IG5ldCB0byByZXN0YXJ0IHRoZSBkZXZpY2UgYmFja2VuZCB0byBjb25maWd1cmUgU1ZRIG9uIGl0
Lgo+Cj4gSWRlYWxseSwgdGhlc2UgY2hhbmdlcyBzaG91bGQgbm90IGJlIG5ldCBzcGVjaWZpYy4g
SG93ZXZlciwgdGhlIHZkcGEgbmV0Cj4gYmFja2VuZCBpcyB0aGUgb25lIHdpdGggZW5vdWdoIGtu
b3dsZWRnZSB0byBjb25maWd1cmUgZXZlcnl0aGluZyBiZWNhdXNlCj4gb2Ygc29tZSByZWFzb25z
Ogo+ICogUXVldWVzIG1pZ2h0IG5lZWQgdG8gYmUgc2hhZG93ZWQgb3Igbm90IGRlcGVuZGluZyBv
biBpdHMga2luZCAoY29udHJvbAo+ICAgIHZzIGRhdGEpLgo+ICogUXVldWVzIG5lZWQgdG8gc2hh
cmUgdGhlIHNhbWUgbWFwIHRyYW5zbGF0aW9ucyAoaW92YSB0cmVlKS4KPgo+IEJlY2F1c2Ugb2Yg
dGhhdCBpdCBpcyBjbGVhbmVyIHRvIHJlc3RhcnQgdGhlIHdob2xlIG5ldCBiYWNrZW5kIGFuZAo+
IGNvbmZpZ3VyZSBhZ2FpbiBhcyBleHBlY3RlZCwgc2ltaWxhciB0byBob3cgdmhvc3Qta2VybmVs
IG1vdmVzIGJldHdlZW4KPiB1c2Vyc3BhY2UgYW5kIHBhc3N0aHJvdWdoLgo+Cj4gSWYgbW9yZSBr
aW5kcyBvZiBkZXZpY2VzIG5lZWQgZHluYW1pYyBzd2l0Y2hpbmcgdG8gU1ZRIHdlIGNhbiBjcmVh
dGUgYQo+IGNhbGxiYWNrIHN0cnVjdCBsaWtlIFZob3N0T3BzIGFuZCBtb3ZlIG1vc3Qgb2YgdGhl
IGNvZGUgdGhlcmUuCj4gVmhvc3RPcHMgY2Fubm90IGJlIHJldXNlZCBzaW5jZSBhbGwgdmRwYSBi
YWNrZW5kIHNoYXJlIHRoZW0sIGFuZCB0bwo+IHBlcnNvbmFsaXplIGp1c3QgZm9yIG5ldHdvcmtp
bmcgd291bGQgYmUgdG9vIGhlYXZ5Lgo+Cj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXog
PGVwZXJlem1hQHJlZGhhdC5jb20+Cj4gLS0tCj4gdjM6Cj4gKiBBZGQgVE9ETyB0byB1c2UgdGhl
IHJlc3VtZSBvcGVyYXRpb24gaW4gdGhlIGZ1dHVyZS4KPiAqIFVzZSBtaWdyYXRpb25faW5fc2V0
dXAgYW5kIG1pZ3JhdGlvbl9oYXNfZmFpbGVkIGluc3RlYWQgb2YgYQo+ICAgIGNvbXBsaWNhdGVk
IHN3aXRjaCBjYXNlLgo+IC0tLQo+ICAgbmV0L3Zob3N0LXZkcGEuYyB8IDc2ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQs
IDc2IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9uZXQvdmhvc3QtdmRwYS5jIGIvbmV0
L3Zob3N0LXZkcGEuYwo+IGluZGV4IGRkNjg2YjQ1MTQuLmJjYTEzZjk3ZmQgMTAwNjQ0Cj4gLS0t
IGEvbmV0L3Zob3N0LXZkcGEuYwo+ICsrKyBiL25ldC92aG9zdC12ZHBhLmMKPiBAQCAtMjYsMTIg
KzI2LDE0IEBACj4gICAjaW5jbHVkZSA8ZXJyLmg+Cj4gICAjaW5jbHVkZSAic3RhbmRhcmQtaGVh
ZGVycy9saW51eC92aXJ0aW9fbmV0LmgiCj4gICAjaW5jbHVkZSAibW9uaXRvci9tb25pdG9yLmgi
Cj4gKyNpbmNsdWRlICJtaWdyYXRpb24vbWlzYy5oIgo+ICAgI2luY2x1ZGUgImh3L3ZpcnRpby92
aG9zdC5oIgo+ICAgCj4gICAvKiBUb2RvOm5lZWQgdG8gYWRkIHRoZSBtdWx0aXF1ZXVlIHN1cHBv
cnQgaGVyZSAqLwo+ICAgdHlwZWRlZiBzdHJ1Y3QgVmhvc3RWRFBBU3RhdGUgewo+ICAgICAgIE5l
dENsaWVudFN0YXRlIG5jOwo+ICAgICAgIHN0cnVjdCB2aG9zdF92ZHBhIHZob3N0X3ZkcGE7Cj4g
KyAgICBOb3RpZmllciBtaWdyYXRpb25fc3RhdGU7Cj4gICAgICAgVkhvc3ROZXRTdGF0ZSAqdmhv
c3RfbmV0Owo+ICAgCj4gICAgICAgLyogQ29udHJvbCBjb21tYW5kcyBzaGFkb3cgYnVmZmVycyAq
Lwo+IEBAIC0yNDEsMTAgKzI0Myw3OSBAQCBzdGF0aWMgVmhvc3RWRFBBU3RhdGUgKnZob3N0X3Zk
cGFfbmV0X2ZpcnN0X25jX3ZkcGEoVmhvc3RWRFBBU3RhdGUgKnMpCj4gICAgICAgcmV0dXJuIERP
X1VQQ0FTVChWaG9zdFZEUEFTdGF0ZSwgbmMsIG5jMCk7Cj4gICB9Cj4gICAKPiArc3RhdGljIHZv
aWQgdmhvc3RfdmRwYV9uZXRfbG9nX2dsb2JhbF9lbmFibGUoVmhvc3RWRFBBU3RhdGUgKnMsIGJv
b2wgZW5hYmxlKQo+ICt7Cj4gKyAgICBzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiA9ICZzLT52aG9zdF92
ZHBhOwo+ICsgICAgVmlydElPTmV0ICpuOwo+ICsgICAgVmlydElPRGV2aWNlICp2ZGV2Owo+ICsg
ICAgaW50IGRhdGFfcXVldWVfcGFpcnMsIGN2cSwgcjsKPiArICAgIE5ldENsaWVudFN0YXRlICpw
ZWVyOwo+ICsKPiArICAgIC8qIFdlIGFyZSBvbmx5IGNhbGxlZCBvbiB0aGUgZmlyc3QgZGF0YSB2
cXMgYW5kIG9ubHkgaWYgeC1zdnEgaXMgbm90IHNldCAqLwo+ICsgICAgaWYgKHMtPnZob3N0X3Zk
cGEuc2hhZG93X3Zxc19lbmFibGVkID09IGVuYWJsZSkgewo+ICsgICAgICAgIHJldHVybjsKPiAr
ICAgIH0KPiArCj4gKyAgICB2ZGV2ID0gdi0+ZGV2LT52ZGV2Owo+ICsgICAgbiA9IFZJUlRJT19O
RVQodmRldik7Cj4gKyAgICBpZiAoIW4tPnZob3N0X3N0YXJ0ZWQpIHsKPiArICAgICAgICByZXR1
cm47CldoYXQgaWYgdmhvc3QgZ2V0cyBzdGFydGVkIGFmdGVyIG1pZ3JhdGlvbiBpcyBzdGFydGVk
LCB3aWxsIHN2cSBzdGlsbCBiZSAKKGR5bmFtaWNhbGx5KSBlbmFibGVkIGR1cmluZyB2aG9zdF9k
ZXZfc3RhcnQoKT8gSSBkb24ndCBzZWUgcmVsZXZhbnQgCmNvZGUgdG8gZGVhbCB3aXRoIGl0PwoK
PiArICAgIH0KPiArCj4gKyAgICBkYXRhX3F1ZXVlX3BhaXJzID0gbi0+bXVsdGlxdWV1ZSA/IG4t
Pm1heF9xdWV1ZV9wYWlycyA6IDE7Cj4gKyAgICBjdnEgPSB2aXJ0aW9fdmRldl9oYXNfZmVhdHVy
ZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfQ1RSTF9WUSkgPwo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgbi0+bWF4X25jcyAtIG4tPm1heF9xdWV1ZV9wYWlycyA6IDA7Cj4gKyAgICAv
Kgo+ICsgICAgICogVE9ETzogdmhvc3RfbmV0X3N0b3AgZG9lcyBzdXNwZW5kLCBnZXRfYmFzZSBh
bmQgcmVzZXQuIFdlIGNhbiBiZSBzbWFydGVyCj4gKyAgICAgKiBpbiB0aGUgZnV0dXJlIGFuZCBy
ZXN1bWUgdGhlIGRldmljZSBpZiByZWFkLW9ubHkgb3BlcmF0aW9ucyBiZXR3ZWVuCj4gKyAgICAg
KiBzdXNwZW5kIGFuZCByZXNldCBnb2VzIHdyb25nLgo+ICsgICAgICovCj4gKyAgICB2aG9zdF9u
ZXRfc3RvcCh2ZGV2LCBuLT5uaWMtPm5jcywgZGF0YV9xdWV1ZV9wYWlycywgY3ZxKTsKPiArCj4g
KyAgICBwZWVyID0gcy0+bmMucGVlcjsKPiArICAgIGZvciAoaW50IGkgPSAwOyBpIDwgZGF0YV9x
dWV1ZV9wYWlycyArIGN2cTsgaSsrKSB7Cj4gKyAgICAgICAgVmhvc3RWRFBBU3RhdGUgKnZkcGFf
c3RhdGU7Cj4gKyAgICAgICAgTmV0Q2xpZW50U3RhdGUgKm5jOwo+ICsKPiArICAgICAgICBpZiAo
aSA8IGRhdGFfcXVldWVfcGFpcnMpIHsKPiArICAgICAgICAgICAgbmMgPSBxZW11X2dldF9wZWVy
KHBlZXIsIGkpOwo+ICsgICAgICAgIH0gZWxzZSB7Cj4gKyAgICAgICAgICAgIG5jID0gcWVtdV9n
ZXRfcGVlcihwZWVyLCBuLT5tYXhfcXVldWVfcGFpcnMpOwo+ICsgICAgICAgIH0KPiArCj4gKyAg
ICAgICAgdmRwYV9zdGF0ZSA9IERPX1VQQ0FTVChWaG9zdFZEUEFTdGF0ZSwgbmMsIG5jKTsKPiAr
ICAgICAgICB2ZHBhX3N0YXRlLT52aG9zdF92ZHBhLnNoYWRvd19kYXRhID0gZW5hYmxlOwpEb24n
dCBnZXQgd2h5IHNoYWRvd19kYXRhIGlzIHNldCBvbiBjdnEncyB2aG9zdF92ZHBhPyBUaGlzIG1h
eSByZXN1bHQgaW4gCmFkZHJlc3Mgc3BhY2UgY29sbGlzaW9uOiBkYXRhIHZxJ3MgaW92YSBnZXR0
aW5nIGltcHJvcGVybHkgYWxsb2NhdGVkIG9uIApjdnEncyBhZGRyZXNzIHNwYWNlIGluIHZob3N0
X3ZkcGFfbGlzdGVuZXJfcmVnaW9uX3thZGQsZGVsfSgpLiBOb3RlZCAKY3VycmVudGx5IHRoZXJl
J3MgYW4gaXNzdWUgd2hlcmUgZ3Vlc3QgVk0ncyBtZW1vcnkgbGlzdGVuZXIgcmVnaXN0cmF0aW9u
IAppcyBhbHdheXMgaG9va2VkIHRvIHRoZSBsYXN0IHZxLCB3aGljaCBjb3VsZCBiZSBvbiB0aGUg
Y3ZxIGluIGEgCmRpZmZlcmVudCBpb3ZhIGFkZHJlc3Mgc3BhY2UgVkhPU1RfVkRQQV9ORVRfQ1ZR
X0FTSUQuCgpUaGFua3MsCi1TaXdlaQoKPiArCj4gKyAgICAgICAgaWYgKGkgPCBkYXRhX3F1ZXVl
X3BhaXJzKSB7Cj4gKyAgICAgICAgICAgIC8qIERvIG5vdCBvdmVycmlkZSBDVlEgc2hhZG93X3Zx
c19lbmFibGVkICovCj4gKyAgICAgICAgICAgIHZkcGFfc3RhdGUtPnZob3N0X3ZkcGEuc2hhZG93
X3Zxc19lbmFibGVkID0gZW5hYmxlOwo+ICsgICAgICAgIH0KPiArICAgIH0KPiArCj4gKyAgICBy
ID0gdmhvc3RfbmV0X3N0YXJ0KHZkZXYsIG4tPm5pYy0+bmNzLCBkYXRhX3F1ZXVlX3BhaXJzLCBj
dnEpOwo+ICsgICAgaWYgKHVubGlrZWx5KHIgPCAwKSkgewo+ICsgICAgICAgIGVycm9yX3JlcG9y
dCgidW5hYmxlIHRvIHN0YXJ0IHZob3N0IG5ldDogJXMoJWQpIiwgZ19zdHJlcnJvcigtciksIC1y
KTsKPiArICAgIH0KPiArfQo+ICsKPiArc3RhdGljIHZvaWQgdmRwYV9uZXRfbWlncmF0aW9uX3N0
YXRlX25vdGlmaWVyKE5vdGlmaWVyICpub3RpZmllciwgdm9pZCAqZGF0YSkKPiArewo+ICsgICAg
TWlncmF0aW9uU3RhdGUgKm1pZ3JhdGlvbiA9IGRhdGE7Cj4gKyAgICBWaG9zdFZEUEFTdGF0ZSAq
cyA9IGNvbnRhaW5lcl9vZihub3RpZmllciwgVmhvc3RWRFBBU3RhdGUsCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBtaWdyYXRpb25fc3RhdGUpOwo+ICsKPiArICAgIGlm
IChtaWdyYXRpb25faW5fc2V0dXAobWlncmF0aW9uKSkgewo+ICsgICAgICAgIHZob3N0X3ZkcGFf
bmV0X2xvZ19nbG9iYWxfZW5hYmxlKHMsIHRydWUpOwo+ICsgICAgfSBlbHNlIGlmIChtaWdyYXRp
b25faGFzX2ZhaWxlZChtaWdyYXRpb24pKSB7Cj4gKyAgICAgICAgdmhvc3RfdmRwYV9uZXRfbG9n
X2dsb2JhbF9lbmFibGUocywgZmFsc2UpOwo+ICsgICAgfQo+ICt9Cj4gKwo+ICAgc3RhdGljIHZv
aWQgdmhvc3RfdmRwYV9uZXRfZGF0YV9zdGFydF9maXJzdChWaG9zdFZEUEFTdGF0ZSAqcykKPiAg
IHsKPiAgICAgICBzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiA9ICZzLT52aG9zdF92ZHBhOwo+ICAgCj4g
KyAgICBhZGRfbWlncmF0aW9uX3N0YXRlX2NoYW5nZV9ub3RpZmllcigmcy0+bWlncmF0aW9uX3N0
YXRlKTsKPiAgICAgICBpZiAodi0+c2hhZG93X3Zxc19lbmFibGVkKSB7Cj4gICAgICAgICAgIHYt
PmlvdmFfdHJlZSA9IHZob3N0X2lvdmFfdHJlZV9uZXcodi0+aW92YV9yYW5nZS5maXJzdCwKPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2LT5pb3ZhX3Jhbmdl
Lmxhc3QpOwo+IEBAIC0yNzgsNiArMzQ5LDEwIEBAIHN0YXRpYyB2b2lkIHZob3N0X3ZkcGFfbmV0
X2NsaWVudF9zdG9wKE5ldENsaWVudFN0YXRlICpuYykKPiAgIAo+ICAgICAgIGFzc2VydChuYy0+
aW5mby0+dHlwZSA9PSBORVRfQ0xJRU5UX0RSSVZFUl9WSE9TVF9WRFBBKTsKPiAgIAo+ICsgICAg
aWYgKHMtPnZob3N0X3ZkcGEuaW5kZXggPT0gMCkgewo+ICsgICAgICAgIHJlbW92ZV9taWdyYXRp
b25fc3RhdGVfY2hhbmdlX25vdGlmaWVyKCZzLT5taWdyYXRpb25fc3RhdGUpOwo+ICsgICAgfQo+
ICsKPiAgICAgICBkZXYgPSBzLT52aG9zdF92ZHBhLmRldjsKPiAgICAgICBpZiAoZGV2LT52cV9p
bmRleCArIGRldi0+bnZxcyA9PSBkZXYtPnZxX2luZGV4X2VuZCkgewo+ICAgICAgICAgICBnX2Ns
ZWFyX3BvaW50ZXIoJnMtPnZob3N0X3ZkcGEuaW92YV90cmVlLCB2aG9zdF9pb3ZhX3RyZWVfZGVs
ZXRlKTsKPiBAQCAtNzQxLDYgKzgxNiw3IEBAIHN0YXRpYyBOZXRDbGllbnRTdGF0ZSAqbmV0X3Zo
b3N0X3ZkcGFfaW5pdChOZXRDbGllbnRTdGF0ZSAqcGVlciwKPiAgICAgICBzLT52aG9zdF92ZHBh
LmRldmljZV9mZCA9IHZkcGFfZGV2aWNlX2ZkOwo+ICAgICAgIHMtPnZob3N0X3ZkcGEuaW5kZXgg
PSBxdWV1ZV9wYWlyX2luZGV4Owo+ICAgICAgIHMtPmFsd2F5c19zdnEgPSBzdnE7Cj4gKyAgICBz
LT5taWdyYXRpb25fc3RhdGUubm90aWZ5ID0gdmRwYV9uZXRfbWlncmF0aW9uX3N0YXRlX25vdGlm
aWVyOwo+ICAgICAgIHMtPnZob3N0X3ZkcGEuc2hhZG93X3Zxc19lbmFibGVkID0gc3ZxOwo+ICAg
ICAgIHMtPnZob3N0X3ZkcGEuaW92YV9yYW5nZSA9IGlvdmFfcmFuZ2U7Cj4gICAgICAgcy0+dmhv
c3RfdmRwYS5zaGFkb3dfZGF0YSA9IHN2cTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
