Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FA1C25B0C
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 23:56:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 771374097F;
	Mon,  8 Aug 2022 23:56:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 771374097F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=EDf5dUXq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=NtY+VHUN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jViS3KZRXcEc; Mon,  8 Aug 2022 23:56:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0D5DB408FF;
	Mon,  8 Aug 2022 23:56:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0D5DB408FF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3DB8C0032;
	Mon,  8 Aug 2022 23:56:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 211B1C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 23:56:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC2AF4097F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 23:56:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EC2AF4097F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4T7T7_EA7mDU
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 23:56:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D313408FF
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D313408FF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 23:56:46 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278NiIZn021417;
 Mon, 8 Aug 2022 23:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=4OVN42VHl3aexrX4QZftEf1jstaR3jeQZdqH/wFEBiE=;
 b=EDf5dUXq5U2hP7y68r3IJcE80EneNuloULeUDv/PWQqBHUkSUzZThj0dCKMiBqTP4phA
 gw3moFSeyTVyX8Z+43JHUuehvQR76bc1l+ofF2paoutLEgXZDc8mKJUue+Luz579clfx
 dKayygVHzwvJA4ZYryvFtIPK8ru7CR/nhizi/VqL8fA35bpr96GvOvHdlbVEPqKMycQp
 Sle5Piv26CBdzNGSOgstzEnUITz+Fxlc0FVeJ9dm9PdPi87NyctXHuk43z/+kVrcgqgs
 gnYqfml2zn6VAu+89lRJRAQ7hS/vQsTL3IL3cVUsLJ0xrBOROqvOMOjt1XZ8c3+cMdvb sw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsgut52x1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Aug 2022 23:56:40 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 278M0hFK011549; Mon, 8 Aug 2022 23:56:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hser26ndm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Aug 2022 23:56:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFjM4hpzyCr19g7TeYa1CKeEWMDX4V+U5Xsau4QEAovSxE37FxCNZzz2xzAQLObyiPHEDDE8q+PEgMyWfnn4rcsopNrgeydBeauqwHKgYZx1JXzXUwrMurHgeaYP5quxJdIJx1vdOQ3H1ThY6PuPmsqtoGIn3plI0oeRzq85bmtE0Ez3Uo/vi4rbd8diRq0hFGF3Lf0Ub/VpWxBOI+yqOqFeWZ/wv0u5vjIZJolJ+v0OlmkfXcYjejCjFbRzkmB7hAuqpF/xVbC1DmIav7e7SzjeRUUOStIw9M5KhpkLdq+h2FoUgtKeoB3nEbuoFVwwz/cqN6JU8TPUwBxSbUTkNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OVN42VHl3aexrX4QZftEf1jstaR3jeQZdqH/wFEBiE=;
 b=GIyVeukJBIfyL7XoDqWFq8EP1+HbAG5KoIlco+5VSdPFaciR6pHsA1jSW2+i9AAEgZY1z5cly3phVRXRwUYrOjcUV/ul688A6yyu1Gmbzd2yK8cxXjTFjp31HIf/jonS/0sVqBNtG4Ub4XyqNwlE0qHlPb25jtCLDdidB//9ZeyaNTvBp/iNoQdXTfw0UjJeq+btj4nvTky0PR/7rCRAt/DInfL5PxRT9b1TJZJ+gkmGDK5arn081GYXu0TOtb1xwRizMDGNsf4/Bk7z5m0V2UC45X61Wi15JA4PCpjd6QUXk5EUhA5E80R51LGsahq3t18JeyUMNXjrdCk9x7t/5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OVN42VHl3aexrX4QZftEf1jstaR3jeQZdqH/wFEBiE=;
 b=NtY+VHUN1sZ/FDx8odVoreYJKJgPARrK1PnEXDOjXQ+Wb4P4gDUl+/0CAeiOIVGhf2Pk+7ct5upAv7VgvJg5mL8RhyWCopNmHBQtwE/ojJPRWQWFNs1DyF36BNBnC/KqI0SDEhfz7qPwcysn4Dx9Ze57bE8M+tT6jWQuBxcODd4=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB5743.namprd10.prod.outlook.com (2603:10b6:a03:3ee::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 23:56:37 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 23:56:36 +0000
Message-ID: <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
Date: Mon, 8 Aug 2022 16:56:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Language: en-US
To: Gavin Li <gavinl@nvidia.com>, mst@redhat.com, stephen@networkplumber.org, 
 davem@davemloft.net, virtualization@lists.linux-foundation.org,
 virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com,
 alexander.h.duyck@intel.com, kubakici@wp.pl,
 sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
X-ClientProxiedBy: SA1PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::24) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e75f3810-b231-4f20-6fe2-08da7999a132
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5743:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IgaLx4aXLAvi3zudvHutnMOxo/JeLFuHHHv4jUqm8fp0xWwdhTG05aTXtOScByxopxlfMAHc7/wupQ0NQ0CHmhnRNakb+cIKB78/3AcfC3fHMYKDLfd+dWC2vmMbGCWJtxpQpq/E0+kqD2TGfMEna2HMwKSHQJ98pR/t1Av5qnxRc0leWPJx2nw8aqbWJj0r8489VfSQirmtIul3rHZiq6dHaksrDO8tKh1/kVScx/cTcNpjSqCbMW3vraBeaje/lYzEqkQT8SWoj4scfMdfmIogyKKoy/QANj48T0QH5SjnpZy5BQPc9URvpv+axOZeQugAvRkyBWRzIzQoR0ugTeuqkazL7kv0VFpsbvbIRsivpNN0HD69czBxzlrIOKUpOG8wMAtgBD70MEQ53Sly5Rf3exVGOD4ycivTWUkEUGCXmYaDkPkLRjmt2JuVUIQaQ5yyuEXEWBpDElAq1fR8eG9QgZ7qXdjY8iX+kiN2xui3/MEkhHawyL6lAYcDkZkXsNscl/vNVx3ic38QOB1IX//K5FNMQI9DhU2/YIr8JNsh4Nr4qE4AmtDnDKBXt8AuER5qEZdXo45Gi92kTJaNL9G9TuFs0kQ44/sihLimtRIMpSa56fEbOjybrAl3n99V2botJuwJkVmUAeRKMUqDshx8xq0cdXuGUbNWFBbhh6qj+vFRU+MvaYd3adoHg1ectiXKYRxOQgY9kThXFDo8QlzVCNNAjoBHwZEpIUkWO2gGuir+nT7qsg+2TgWi4Zzl7nVhQbOPqk4MV5kmri6EoH1MfT1S9UqO7Sw/codp/C/rVyizUTaZDyQ4Lz8SdHfSb1QmERUcnRjAVSvEZmVKXjUiXxc0XgmZoIG9ZUKBuAw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(136003)(346002)(396003)(39860400002)(366004)(376002)(2906002)(53546011)(316002)(186003)(2616005)(26005)(6512007)(6666004)(6506007)(41300700001)(36916002)(83380400001)(36756003)(86362001)(31686004)(31696002)(6486002)(66556008)(7416002)(66476007)(8936002)(66946007)(5660300002)(478600001)(921005)(4326008)(8676002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWVZN3RIbVF0OHIxYVhac0lLSEVQd1FYQ3kveXJheGJNL2tVYWxzbWRXY0do?=
 =?utf-8?B?NHVuL3BSNjFvMlRaejB1akRZK1FaNjJjVlM3eTV4Znc5UTg2SmRDSHh5Ukh0?=
 =?utf-8?B?VDFJSjNxVEdIOWh4K1dTMlpEbGZWclNEVjhlRlhHUTlWZ0ozNDA4dmtNZXBa?=
 =?utf-8?B?ZUljdU1GT0ZGM3BnNnZyb2VQY0VUaEJhTVFISjdpb3pwZnhrSUxndVVYblEy?=
 =?utf-8?B?YnlubXZwMGczVE1jc0tzaGtNQlQwd0J2L0NPbGlyWHZINEdPaUFydmhwcUNE?=
 =?utf-8?B?bXQ1YjArNXFsTHh2Y1ZTVkxadGJFVVJvUnJ1TjBHdE9VZGVIdFZLbk9nWDFj?=
 =?utf-8?B?T2hxZ1pUQUw5VE42VXpEbTZjR2kvWWNJOFFXVFJJZzA3K3VqMUxDQ2xlSWxj?=
 =?utf-8?B?clVETGtrL21udXRUSkpIVWFyZTF3NDkveXpkL1d6Z0tSY0x1bVl5MnlvaDdE?=
 =?utf-8?B?QWpWSzE5SUlkNUhIMEdiK1F4aDdIRCtqQ1JvWjhvclVCMEFkc0paVDR3VTh4?=
 =?utf-8?B?ZC9GMUVENEM5dW05L1N3WnhUTDF6VEdic2ZGT2oyekVoM3BTd3RVR09jWXAw?=
 =?utf-8?B?SWZDaXRuTWlOQXU2YytmU3lwNExJdVY3RzdQSGc4b1ppdVhMTWRpMkRlK2oz?=
 =?utf-8?B?ekZnbUR6QXhzK3hNaGtiZmpsbTRrNXZIaXJxSUw0cFNJM085TVRDOENyS1l5?=
 =?utf-8?B?U25oY1dpNWk3VThrckZ6VDljVDF4NzNwZ1IvTllaRzF0SmRZNEx4Uldla1J4?=
 =?utf-8?B?S2lYVzVLR1FLU0tNS3FBM3NEVjJuazNQMlN1NGpUTEsxM3ZRRkJ2TWg0Ykpk?=
 =?utf-8?B?ejdoKzg4c1kyTjFGek1JaytBOHJ0N3dmSlFuanc2eUlxcmIrTEJNa2EweVNH?=
 =?utf-8?B?UFBGY3hQYWp6M1VleUt4V3AwMWx3T1BaYmNFOXRvbmZRaVBqMHY3QkhsM2ZD?=
 =?utf-8?B?akl2Rzk5eW4yZnpiWDJqeTBBSmNaSWtvZTByUFZzZ283QWF6UitQLzdFYXRp?=
 =?utf-8?B?d29nSlpPMy82eFFZbUs4SGEwaDdhdTFxMjZuZ1VnNTgxUXFGdWJ3c2Y4cmo2?=
 =?utf-8?B?UWF1czFDaEFzZ0cwc0VnL2hscmt2azRNazIvQ1VpemtBNlArb2V2WVFWZVpj?=
 =?utf-8?B?R0pOd2hyUWRvNnhWcjg5YkozckNTY3ZtRG5RUklqTWdXbno0N0JhNmtweDZP?=
 =?utf-8?B?V2FLaGtMbGxIQXI3QzZPNWhNNlk5OUR1enVlVFV2MnZLNGJoUEZUVERvSElB?=
 =?utf-8?B?TUcwb3dYMmhEQWxLYWlDWUx2WUJhbjNqMmNyVjdIeWF1aUZWbTRkQjhQdDNW?=
 =?utf-8?B?bmxRalpzaSsvT3RUMi9hSngrbFpPOWgvK2JaMkNiKzdtVVRNbm9odnlPeFlh?=
 =?utf-8?B?Qm1yNFlVaFpUU21Oa0tNMmcrY2ZCeUN4dmo4Nnp0OFFJQ1ZUWkJTb2k5NUV4?=
 =?utf-8?B?cGx0dlBhZEZvNHV3SnJPUC9qYS9Ma1R4bWlGay9GSno3ejlhU3pRUmZVdGJ6?=
 =?utf-8?B?OHpxaEFKODV6Y3RxZDBFR2k5ZGMrWGQ5RW84c3R3eWlBQnZETE1QbXBuWDQr?=
 =?utf-8?B?QlZMdXV0c21hRHJnQWRBWE91VklqOVZoTXJ5eXB0R2E3blhMKy9YR3ZUOHV1?=
 =?utf-8?B?OHoveU5SUFJReHliSjRuZkhlY3JmVTYvTFp1MVlVVWVhSHlsdndIb3IyMkt6?=
 =?utf-8?B?SVRGdngvSDFpV3hZYVJUWm5VQnhldkhHWC81MFhPQW5zMWpxeGRmU3dZait4?=
 =?utf-8?B?bGUrSEJQVE43dzliSEF5WFlpQ2tGOXRtVm4ydStLUGllNmNBaDVyMkR1RENv?=
 =?utf-8?B?SzdURjhNbERNNnVqdzlkOE1uakNoS3c5M1Vvb2VDTFB6bWZmbzA2M0NKdzBk?=
 =?utf-8?B?VkFJRStiYTU5cEJ1ak8wWWVEaGdFaGJoRUNtNk8zNm9OUnp4ZjlVSi9FQjJv?=
 =?utf-8?B?ekp6aDRuc25tNVdkallxUUdIck04U0dnOEhTMmNDZk1jYzBOZkhzdnNROEdV?=
 =?utf-8?B?UDVNcll2VXp4SWxRRmhBYUJoZ1NPOXFPT1FPWnFsMk50d09ZWFF5WGI5TnZ3?=
 =?utf-8?B?Q0REU1ZwR0liSFRUMlZNbllGL3JTMVlCdno2QVZqVi9lYnFTQlkxRVhEdnFi?=
 =?utf-8?Q?ML/1IobA0LDjFkHb+tTCLWHgR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75f3810-b231-4f20-6fe2-08da7999a132
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 23:56:36.9303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7VMcTXHM2RVT3kZRvuDEEP0BKgmR8cbaPA8ICs4EcwQIrhBmeQOsV3sdwc7JgD8wlgfhF4BPk2yiaKR7PTiCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5743
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_14,2022-08-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208080105
X-Proofpoint-ORIG-GUID: BzZ1FL405O1yfhV-1dlrcxJTgnZvTgSw
X-Proofpoint-GUID: BzZ1FL405O1yfhV-1dlrcxJTgnZvTgSw
Cc: gavi@nvidia.com
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

CgpPbiA4LzgvMjAyMiAxMjozMSBBTSwgR2F2aW4gTGkgd3JvdGU6Cj4KPiBPbiA4LzYvMjAyMiA2
OjExIEFNLCBTaS1XZWkgTGl1IHdyb3RlOgo+PiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24g
b3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cwo+Pgo+Pgo+PiBPbiA4LzEvMjAyMiA5OjQ1IFBN
LCBHYXZpbiBMaSB3cm90ZToKPj4+IEN1cnJlbnRseSBhZGRfcmVjdmJ1Zl9iaWcoKSBhbGxvY2F0
ZXMgTUFYX1NLQl9GUkFHUyBzZWdtZW50cyBmb3IgYmlnCj4+PiBwYWNrZXRzIGV2ZW4gd2hlbiBH
VUVTVF8qIG9mZmxvYWRzIGFyZSBub3QgcHJlc2VudCBvbiB0aGUgZGV2aWNlLgo+Pj4gSG93ZXZl
ciwgaWYgR1NPIGlzIG5vdCBzdXBwb3J0ZWQsCj4+IEdVRVNUIEdTTyAodmlydGlvIHRlcm0pLCBv
ciBHUk8gSFcgKG5ldGRldiBjb3JlIHRlcm0pIGl0IHNob3VsZCBoYXZlCj4+IGJlZW4gYmUgY2Fs
bGVkLgo+IEFDSwo+Pgo+Pj4gwqAgaXQgd291bGQgYmUgc3VmZmljaWVudCB0byBhbGxvY2F0ZQo+
Pj4gc2VnbWVudHMgdG8gY292ZXIganVzdCB1cCB0aGUgTVRVIHNpemUgYW5kIG5vIGZ1cnRoZXIu
IEFsbG9jYXRpbmcgdGhlCj4+PiBtYXhpbXVtIGFtb3VudCBvZiBzZWdtZW50cyByZXN1bHRzIGlu
IGEgbGFyZ2Ugd2FzdGUgb2YgYnVmZmVyIHNwYWNlIGluCj4+PiB0aGUgcXVldWUsIHdoaWNoIGxp
bWl0cyB0aGUgbnVtYmVyIG9mIHBhY2tldHMgdGhhdCBjYW4gYmUgYnVmZmVyZWQgYW5kCj4+PiBj
YW4gcmVzdWx0IGluIHJlZHVjZWQgcGVyZm9ybWFuY2UuCj4+Pgo+Pj4gVGhlcmVmb3JlLCBpZiBH
U08gaXMgbm90IHN1cHBvcnRlZCwKPj4gRGl0dG8uCj4gQUNLCj4+Cj4+PiB1c2UgdGhlIE1UVSB0
byBjYWxjdWxhdGUgdGhlCj4+PiBvcHRpbWFsIGFtb3VudCBvZiBzZWdtZW50cyByZXF1aXJlZC4K
Pj4+Cj4+PiBCZWxvdyBpcyB0aGUgaXBlcmYgVENQIHRlc3QgcmVzdWx0cyBvdmVyIGEgTWVsbGFu
b3ggTklDLCB1c2luZyB2RFBBIGZvcgo+Pj4gMSBWUSwgcXVldWUgc2l6ZSAxMDI0LCBiZWZvcmUg
YW5kIGFmdGVyIHRoZSBjaGFuZ2UsIHdpdGggdGhlIGlwZXJmCj4+PiBzZXJ2ZXIgcnVubmluZyBv
dmVyIHRoZSB2aXJ0aW8tbmV0IGludGVyZmFjZS4KPj4+Cj4+PiBNVFUoQnl0ZXMpL0JhbmR3aWR0
aCAoR2JpdC9zKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQmVmb3JlwqDCoCBBZnRl
cgo+Pj4gwqDCoCAxNTAwwqDCoMKgwqDCoMKgwqAgMjIuNcKgwqDCoMKgIDIyLjQKPj4+IMKgwqAg
OTAwMMKgwqDCoMKgwqDCoMKgIDEyLjjCoMKgwqDCoCAyNS45Cj4+Pgo+Pj4gU2lnbmVkLW9mZi1i
eTogR2F2aW4gTGkgPGdhdmlubEBudmlkaWEuY29tPgo+Pj4gUmV2aWV3ZWQtYnk6IEdhdmkgVGVp
dHogPGdhdmlAbnZpZGlhLmNvbT4KPj4+IFJldmlld2VkLWJ5OiBQYXJhdiBQYW5kaXQgPHBhcmF2
QG52aWRpYS5jb20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDIw
ICsrKysrKysrKysrKysrKystLS0tCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+PiBpbmRleCBlYzhlMWIzMTA4
YzMuLmQzNjkxOGMxODA5ZCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
Ywo+Pj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+PiBAQCAtMjIyLDYgKzIyMiw5
IEBAIHN0cnVjdCB2aXJ0bmV0X2luZm8gewo+Pj4gwqDCoMKgwqDCoCAvKiBJIGxpa2UuLi4gYmln
IHBhY2tldHMgYW5kIEkgY2Fubm90IGxpZSEgKi8KPj4+IMKgwqDCoMKgwqAgYm9vbCBiaWdfcGFj
a2V0czsKPj4+Cj4+PiArwqDCoMKgwqAgLyogSW5kaWNhdGVzIEdTTyBzdXBwb3J0ICovCj4+PiAr
wqDCoMKgwqAgYm9vbCBnc29faXNfc3VwcG9ydGVkOwo+Pj4gKwo+Pj4gwqDCoMKgwqDCoCAvKiBI
b3N0IHdpbGwgbWVyZ2UgcnggYnVmZmVycyBmb3IgYmlnIHBhY2tldHMgKHNoYWtlIGl0ISBzaGFr
ZSAKPj4+IGl0ISkgKi8KPj4+IMKgwqDCoMKgwqAgYm9vbCBtZXJnZWFibGVfcnhfYnVmczsKPj4+
Cj4+PiBAQCAtMTMxMiwxNCArMTMxNSwyMSBAQCBzdGF0aWMgaW50IGFkZF9yZWN2YnVmX3NtYWxs
KHN0cnVjdCAKPj4+IHZpcnRuZXRfaW5mbyAqdmksIHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSwK
Pj4+IMKgIHN0YXRpYyBpbnQgYWRkX3JlY3ZidWZfYmlnKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZp
LCBzdHJ1Y3QgCj4+PiByZWNlaXZlX3F1ZXVlICpycSwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnZnBfdCBnZnApCj4+PiDCoCB7Cj4+PiArwqDC
oMKgwqAgdW5zaWduZWQgaW50IHNnX251bSA9IE1BWF9TS0JfRlJBR1M7Cj4+PiDCoMKgwqDCoMKg
IHN0cnVjdCBwYWdlICpmaXJzdCwgKmxpc3QgPSBOVUxMOwo+Pj4gwqDCoMKgwqDCoCBjaGFyICpw
Owo+Pj4gwqDCoMKgwqDCoCBpbnQgaSwgZXJyLCBvZmZzZXQ7Cj4+Pgo+Pj4gLcKgwqDCoMKgIHNn
X2luaXRfdGFibGUocnEtPnNnLCBNQVhfU0tCX0ZSQUdTICsgMik7Cj4+PiArwqDCoMKgwqAgaWYg
KCF2aS0+Z3NvX2lzX3N1cHBvcnRlZCkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1
bnNpZ25lZCBpbnQgbXR1ID0gdmktPmRldi0+bXR1Owo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzZ19udW0gPSAobXR1ICUgUEFHRV9TSVpFKSA/IG10dSAvIFBBR0VfU0laRSAr
IDEgOiBtdHUgCj4+PiAvIFBBR0VfU0laRTsKPj4gRElWX1JPVU5EX1VQKCkgY2FuIGJlIHVzZWQ/
Cj4gQUNLCj4+Cj4+IFNpbmNlIHRoaXMgYnJhbmNoIHNsaWdodGx5IGFkZHMgdXAgY29zdCB0byB0
aGUgZGF0YXBhdGgsIEkgd29uZGVyIGlmCj4+IHRoaXMgc2dfbnVtIGNhbiBiZSBzYXZlZCBhbmQg
c2V0IG9ubHkgb25jZSAoZ2VuZXJhbGx5IGluIHZpcnRuZXRfcHJvYmUKPj4gdGltZSkgaW4gc3Ry
dWN0IHZpcnRuZXRfaW5mbz8KPiBOb3Qgc3VyZSBob3cgdG8gZG8gaXQgYW5kIGFsaWduIGl0IHdp
dGggYWxpZ24gd2l0aCBuZXcgbXR1IGR1cmluZyAKPiAubmRvX2NoYW5nZV9tdHUoKS0tLWFzIHlv
dSBtZW50aW9uZWQgaW4gdGhlIGZvbGxvd2luZyBtYWlsLiBBbnkgaWRlYT8gCj4gbmRvX2NoYW5n
ZV9tdHUgbWlnaHQgYmUgaW4gdmVuZG9yIHNwZWNpZmljIGNvZGUgYW5kIHVubWFuYWdlYWJsZS4g
SW4gCj4gbXkgY2FzZSwgdGhlIG10dSBjYW4gb25seSBiZSBjaGFuZ2VkIGluIHRoZSB4bWwgb2Yg
dGhlIGd1ZXN0IHZtLgpOb3BlLCBmb3IgZS5nLiAiaXAgbGluayBkZXYgZXRoMCBzZXQgbXR1IDE1
MDAiIGNhbiBiZSBkb25lIGZyb20gZ3Vlc3Qgb24gCmEgdmlydGlvLW5ldCBkZXZpY2Ugd2l0aCA5
MDAwIE1UVSAoYXMgZGVmaW5lZCBpbiBndWVzdCB4bWwpLiBCYXNpY2FsbHkgCmd1ZXN0IHVzZXIg
Y2FuIHNldCBNVFUgdG8gYW55IHZhbGlkIHZhbHVlIGxvd2VyIHRoYW4gdGhlIG9yaWdpbmFsIApI
T1NUX01UVS4gSW4gdGhlIHZlbmRvciBkZWZpbmVkIC5uZG9fY2hhbmdlX210dSgpIG9wLCBkZXZf
dmFsaWRhdGVfbXR1KCkgCnNob3VsZCBoYXZlIHZhbGlkYXRlZCB0aGUgTVRVIHZhbHVlIGJlZm9y
ZSBjb21pbmcgZG93biB0byBpdC4gQW5kIEkgCnN1c3BlY3QgeW91IG1pZ2h0IHdhbnQgdG8gZG8g
dmlydG5ldF9jbG9zZSgpIGFuZCB2aXJ0bmV0X29wZW4oKSAKYmVmb3JlL2FmdGVyIGNoYW5naW5n
IHRoZSBidWZmZXIgc2l6ZSBvbiB0aGUgZmx5ICh0aGUgbmV0aWZfcnVubmluZygpIApjYXNlKSwg
aW1wbGVtZW50aW5nIC5uZG9fY2hhbmdlX210dSgpIHdpbGwgYmUgbmVlZGVkIGFueXdheS4KCj4+
PiArwqDCoMKgwqAgfQo+Pj4gKwo+Pj4gK8KgwqDCoMKgIHNnX2luaXRfdGFibGUocnEtPnNnLCBz
Z19udW0gKyAyKTsKPj4+Cj4+PiDCoMKgwqDCoMKgIC8qIHBhZ2UgaW4gcnEtPnNnW01BWF9TS0Jf
RlJBR1MgKyAxXSBpcyBsaXN0IHRhaWwgKi8KPj4gQ29tbWVudCBkb2Vzbid0IG1hdGNoIGNvZGUu
Cj4gQUNLCj4+PiAtwqDCoMKgwqAgZm9yIChpID0gTUFYX1NLQl9GUkFHUyArIDE7IGkgPiAxOyAt
LWkpIHsKPj4+ICvCoMKgwqDCoCBmb3IgKGkgPSBzZ19udW0gKyAxOyBpID4gMTsgLS1pKSB7Cj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmaXJzdCA9IGdldF9hX3BhZ2UocnEsIGdmcCk7
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWZpcnN0KSB7Cj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGxpc3QpCj4+PiBAQCAtMTM1
MCw3ICsxMzYwLDcgQEAgc3RhdGljIGludCBhZGRfcmVjdmJ1Zl9iaWcoc3RydWN0IHZpcnRuZXRf
aW5mbyAKPj4+ICp2aSwgc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxLAo+Pj4KPj4+IMKgwqDCoMKg
wqAgLyogY2hhaW4gZmlyc3QgaW4gbGlzdCBoZWFkICovCj4+PiDCoMKgwqDCoMKgIGZpcnN0LT5w
cml2YXRlID0gKHVuc2lnbmVkIGxvbmcpbGlzdDsKPj4+IC3CoMKgwqDCoCBlcnIgPSB2aXJ0cXVl
dWVfYWRkX2luYnVmKHJxLT52cSwgcnEtPnNnLCBNQVhfU0tCX0ZSQUdTICsgMiwKPj4+ICvCoMKg
wqDCoCBlcnIgPSB2aXJ0cXVldWVfYWRkX2luYnVmKHJxLT52cSwgcnEtPnNnLCBzZ19udW0gKyAy
LAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZmlyc3QsIGdmcCk7Cj4+PiDCoMKgwqDCoMKgIGlmIChlcnIgPCAwKQo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ2l2ZV9wYWdlcyhycSwgZmlyc3QpOwo+Pj4gQEAg
LTM1NzEsOCArMzU4MSwxMCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcHJvYmUoc3RydWN0IHZpcnRp
b19kZXZpY2UgCj4+PiAqdmRldikKPj4+IMKgwqDCoMKgwqAgaWYgKHZpcnRpb19oYXNfZmVhdHVy
ZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNCkgfHwKPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCB2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX0dVRVNUX1RTTzYpIHx8Cj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgdmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRf
Rl9HVUVTVF9FQ04pIHx8Cj4+PiAtwqDCoMKgwqDCoMKgwqDCoCB2aXJ0aW9faGFzX2ZlYXR1cmUo
dmRldiwgVklSVElPX05FVF9GX0dVRVNUX1VGTykpCj4+PiArwqDCoMKgwqDCoMKgwqDCoCB2aXJ0
aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX0dVRVNUX1VGTykpIHsKPj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZpLT5iaWdfcGFja2V0cyA9IHRydWU7Cj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHZpLT5nc29faXNfc3VwcG9ydGVkID0gdHJ1ZTsKPj4gUGxlYXNl
IGRvIHRoZSBzYW1lIGZvciB2aXJ0bmV0X2NsZWFyX2d1ZXN0X29mZmxvYWRzKCksIGFuZAo+PiBj
b3JyZXNwb25kaW5nbHkgdmlydG5ldF9yZXN0b3JlX2d1ZXN0X29mZmxvYWRzKCkgYXMgd2VsbC4g
Tm90IHN1cmUgd2h5Cj4+IHZpcnRuZXRfY2xlYXJfZ3Vlc3Rfb2ZmbG9hZHMoKSBvciB0aGUgY2Fs
bGVyIGRvZXNuJ3QgdW5zZXQgYmlnX3BhY2tldCBvbgo+PiBzdWNjZXNzZnVsIHJldHVybiwgc2Vl
bXMgbGlrZSBhIGJ1ZyB0byBtZS4KPiBBQ0suIFRoZSB0d28gY2FsbHMgdmlydG5ldF9zZXRfZ3Vl
c3Rfb2ZmbG9hZHMgYW5kIAo+IHZpcnRuZXRfc2V0X2d1ZXN0X29mZmxvYWRzIGlzIGFsc28gY2Fs
bGVkIGJ5IHZpcnRuZXRfc2V0X2ZlYXR1cmVzLiBEbyAKPiB5b3UgdGhpbmsgaWYgSSBjYW4gZG8g
dGhpcyBpbiB2aXJ0bmV0X3NldF9ndWVzdF9vZmZsb2Fkcz8KSSB0aGluayB0aGF0IGl0IHNob3Vs
ZCBiZSBmaW5lLCB0aG91Z2ggeW91IG1heSB3YW50IHRvIGRlYWwgd2l0aCB0aGUgWERQIApwYXRo
IG5vdCB0byByZWdyZXNzIGl0LgoKLVNpd2VpCgo+Pgo+Pgo+PiBUaGFua3MsCj4+IC1TaXdlaQo+
Pj4gK8KgwqDCoMKgIH0KPj4+Cj4+PiDCoMKgwqDCoMKgIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUo
dmRldiwgVklSVElPX05FVF9GX01SR19SWEJVRikpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB2aS0+bWVyZ2VhYmxlX3J4X2J1ZnMgPSB0cnVlOwo+PgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
