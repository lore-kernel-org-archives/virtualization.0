Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F02ECAAD1
	for <virtualization@archiver.kernel.org>; Wed, 31 Aug 2022 22:23:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30D264195F;
	Wed, 31 Aug 2022 22:23:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30D264195F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=KwbXWz0N;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=KqlgkM0V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tRbkQCcZgcKm; Wed, 31 Aug 2022 22:22:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 99D4F41675;
	Wed, 31 Aug 2022 22:22:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 99D4F41675
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B013C0032;
	Wed, 31 Aug 2022 22:22:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C07BEC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 22:22:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8D84340182
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 22:22:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8D84340182
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=KwbXWz0N; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=KqlgkM0V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id frEhuiVZVa8I
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 22:22:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EB755400CE
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB755400CE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 22:22:52 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VL0nc4000995;
 Wed, 31 Aug 2022 22:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=rQX5/I64z47zpYFgjKFJcWTglsq7OYtNe90emJuQOBw=;
 b=KwbXWz0NSWSY3HMW8er2UxHKFfJalh6hSLJlUqxBif/inSYz0MEITZ2GlNDt48+Pl1C7
 EbbJSqrMYH8gpIzqULMUyZZONeaRCKgFmDiJ3w0FoekZuBe3yrPBnX1FvKzATJVjqyat
 RAhMOx058e0f1VXCs0n3KOaPc0U6cNOHCHRa/q1gYLGButw/90TUf/yxjUnKcg4tipeq
 poJlzhR6UP2ZRo4H1ZyiI5WXOZy6lzJXPfzI4wOe6Mr1BRnYOO0xwz9WDXyYx3FZRS/f
 sBazg8zWu9q9/cwV/JIoXqs9Fnfqmd+G9gQhcl4CLmDytdAhM4hDbj5oqQqz5PjG/P5I SQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7b5a2axt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Aug 2022 22:22:51 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 27VK5njr014704; Wed, 31 Aug 2022 22:22:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3j79qbts7v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Aug 2022 22:22:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Delb4USjyNLNLGhhKdpS4PxgEi6/1IaSkAco3bzyjFS64rdzaP/AVMtiapFqHE88Dr7QmgTSDfayZMmQZlVTnsv0NSWnIj4nQWnebJqNpTsohZXOdsQd9dfNWIFpOqQ765HafzNAJfw3XnfxGxfVoQ5MBaECueZVUCfNz4F/kGi7YLMlPHH616Byey6B5FbYvZKIo68mPpQT0EAUS0oCgltcZlnxzkNSRJNX5m0QxY7T1alDKhhp0nJRAvS9xS4onMFVgkoOP/ZrkOnGvUadGLvVecTUOLkmO51FPvfwcOjBH7LRqyRFDHrWbKnwbvbRbdXxMFWDUmfZYgIJSzEP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQX5/I64z47zpYFgjKFJcWTglsq7OYtNe90emJuQOBw=;
 b=Ofa6DsMtybL5GpB/rYu99fTZIhB7LxQ7jsmuwOsD0xKV07DCbYOLaVpGxkBGd5n3AMiXHoj4cZuvwAT9oz3Lq1ELG3JSlCspcWOvKNc3Z9MtLEaAnMNyW/Tpt9x7i6hrvSp4OFt5zcJW8gzDMrtN5FGxeIW6Dr7j+AY17edudYLoR0REX1mbXQ3bZOAwuboir+AQmrKyo/mkKb7gJ8mxbhWwZzqXgnQJBTMEEBKIZBdwl+RnI1TCZR25+QEzsudetNMSoh65xraZX3N255J4QAhE7PjeB5352Hn9EtUmrsvrDVYPVLySE0BM/c1QDh/M6Cp0tg/+HtAIFz3H31b8Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQX5/I64z47zpYFgjKFJcWTglsq7OYtNe90emJuQOBw=;
 b=KqlgkM0VOkWLd86DE2pT1k3CvibCCjrPx/FPvvkGawTR4TkZlkb9e5wmwv+DYeB72ijqYxrU9eralrygFaDPSA2QiasGik+VVOZ6FFswlsZdTbCOKlWU6cO6LKYaRFhlNeAUHVp/4yGo9mjFYP/Yo2IKx17QHhCTajKSzfyhs9g=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by DM4PR10MB5966.namprd10.prod.outlook.com (2603:10b6:8:b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 22:22:47 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 22:22:47 +0000
Message-ID: <8b6cca4e-9caa-30c3-521a-87c984484238@oracle.com>
Date: Wed, 31 Aug 2022 15:22:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: RFC: control virtqueue size by the vdpa tool
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <DM8PR12MB5400FEB0322A9FD6B3271D45AB799@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220830154938-mutt-send-email-mst@kernel.org>
 <7460d7c7-5b44-661f-7763-3e7a6a15f138@oracle.com>
 <20220830180119-mutt-send-email-mst@kernel.org>
 <ef63889c-4f61-75ae-4faa-fa1619995256@oracle.com>
 <DM8PR12MB54006D58A2ACA88CC786B9A8AB789@DM8PR12MB5400.namprd12.prod.outlook.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <DM8PR12MB54006D58A2ACA88CC786B9A8AB789@DM8PR12MB5400.namprd12.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0187.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::12) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3f2e5e2-40ad-4dfd-e921-08da8b9f5560
X-MS-TrafficTypeDiagnostic: DM4PR10MB5966:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7pPRO8JYIG4S+vLRWSRWSycdhJSneCzp64KpPvxBdP4xeWSy81LcxcpjB10HviOnbUpzxNfQBkkm0IQec54NCz/JRFliUl5vHEOOT2UGNktauYKYesvn7GetEKa4i2KD7l/562WbsXz7fsK0qbdmia4PWUgxON2zkBnrkMy+tzI1OBNcst7M3b5FEytaIAe2lpmiQ4rVP50prpn09IEEjfU3qmo9sAvrZI8S+yjwhOq1Ak0a8jy+5QfUOxkEtTdzaF5q+awl03h1rBRioW7zkCa7owOKDr5e77Tyuw66W0BK9ehGMfgz7o3E32teq4ib65iW5isrp5nrcsp6XnrPiq6KiaWj6T/ohzk1eEWa9hkGn2g7bYrTtUpk/AvvAAxd/6223PjQ1poeU+PsVPpHTegL6B4Twrsc/JrmvEbWM24oSlV6i9HmVfXXzd8Kws0SjDNExVKy4fHtRhjDtUWLKBIe9Zhmtd+4wiz+iGjoay9YCMc0IM2WvuoKzpK79XGJHqMBM+U2CGCFA1MLgbP3ziDmAL/j3/s++H/IXzOCuWTgAY4nHRCNhUSGmp/gUTvK4ha0yAShR0PI4nbwR3eOlX0/HiPv87uRlaGMzZTfTseWrGAYOdgKjvg8frQVPrwt2hW0OgMkJR1G5TL8URKdM8AE/2yxGTYFL02+hE4ErT/JsUWbtgimmXco+LF0bWc8UbxIpMimAtmUs2G2dH02K98azVBNT3WQrh/HawjkcIEwCjab90L8DDXrMfqdrnLjInMiH/fXJzHoQ0lczT1RXYxsxCGEhu/2peJnPnMkORk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(136003)(39860400002)(366004)(346002)(376002)(396003)(186003)(2616005)(8676002)(66946007)(66476007)(4326008)(5660300002)(66556008)(31686004)(36756003)(478600001)(53546011)(6512007)(41300700001)(6666004)(6486002)(36916002)(26005)(6506007)(38100700002)(86362001)(31696002)(8936002)(54906003)(110136005)(2906002)(316002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlZEa3R1KzdzS01QYmtDRlN5cnI1a3E0aHV6OFh5bks0QklzSG1WVWM3NUp3?=
 =?utf-8?B?SUZQblJ0V0ZtdElsdldiN3lRTUxFV0FheW1FNDVSNmd6aDJXOENKcjQzL2h3?=
 =?utf-8?B?L3FhV1h4MzVxdnZ4RjlNTUp5RUVBYlY4TjhRSkI2MnY5QlltMzNaTzNQRjE3?=
 =?utf-8?B?RVFpbW1CQVN2Z29Pa1pWdlAvbzJwVFBad29qdW9NMlRwcEFKcFNrOUszQ3Jr?=
 =?utf-8?B?cDI1dDF6bXJaeVdUckd0SkRYWVJXZzVpU0wxREloWCtmNlF1YXZHYUJObHdL?=
 =?utf-8?B?VWFDS3dSVTAvVDJnK1pTaTRyM0dueUNtcXJnbWtYODMydlZ2VnB4K29OL0c3?=
 =?utf-8?B?a2hhdDJmdkRsZmcwamdCMmNmV0pGNktsSEJYMVBlOHMxcVhzQ2RXa21mMEo1?=
 =?utf-8?B?cHBiRWkyeC9MOFNNSWR1S3ZsWTE0N1EzRnE4cU4yNXptVFhuQUp2N1NueWNJ?=
 =?utf-8?B?OTFtcVkwMlUrbWd3M3doMEx5MU9MdkpPNEhaSE8xYlM3aitDSVhCRnNXa1h2?=
 =?utf-8?B?MVB2V0d1dVUxa1RiZWhuS3VTaXdLanB4N05lQk8xZU55b0NtZ0JJYmxmb051?=
 =?utf-8?B?dFpkRXFPTXJhQ2t1d29WL213c1dtNWVpV0xRZCt5cFNSaHp4ZEFrVTYzZGdt?=
 =?utf-8?B?KzlFaUFFVElMeDJET0tBVWdiNWtxU1JHYzBkeWlkOGFMTlRwN2ZSSWFkb2sr?=
 =?utf-8?B?V1FCRGJ5V2hGMUNTcEhUV0M0ai9vdXNubWRpOUFFeDdZNkRYRkNHdUlqNnpy?=
 =?utf-8?B?VDIydFE3QmZ4dTZjcTN4WUllK0tTMVJGTHd4d1d4Ui8vWXdtbUNUU1lDVVF1?=
 =?utf-8?B?clNZMkhKQ09BR0gwc2xLRjZyM0tXWDE2Unp3eTJKcVQxbnFBY01UazFsaTF2?=
 =?utf-8?B?Z3pFaWJFekNnODlUcHJRMDNsMFhBQXVqLzJwanc0MzByZVNsMjRZeGE3L0dO?=
 =?utf-8?B?QWpLc2hFZFNUWEJ3RWVyMmRETUR1bm0xUVA5T09lbUxEY2hBRjJrK3Q2dFBP?=
 =?utf-8?B?Ym0zUFdHK3dOT0d2TWtqK0tOYkpySEJTdllBTjNDL2dNcUdEZmRvbTZuRmdp?=
 =?utf-8?B?aDJocGRtczQreXpPSUIxdll4UXYvU04rMkxMUTdOR3MxNDVLLzFad28vOWV4?=
 =?utf-8?B?cFZaajBpZEUrZTdlWG5Dc3JpMG9Nbk9vOFZFblBJRFYzaExhZnh3dGRVbmt0?=
 =?utf-8?B?TUJwRENNTmwrZE1ISkdYZkppbzduT0F1dFpLYnZNWkI3WGZUUXIzRk9zcS9a?=
 =?utf-8?B?VTgwM2VlVGpiUndTUi9PZDlZVzJNMSt5akN3OFpZZmZvYlVtSzlqcjErWEtI?=
 =?utf-8?B?K09WVHZ3QnpuaHJpZmdWQjRJbEtyR1k2ZmZ0bTNTVnMwaktmYkdCc3BLNXRV?=
 =?utf-8?B?Z0hXNk5PRTEvb05vZ2J6Mkk3dUlNekxTb3FzRXFqNytzODRwcWQ5aTBLZzRK?=
 =?utf-8?B?S0JKU1NPVHVLd3BYMHNQTE9aZ1pqM1YxMi95YmdqblV2eDVraHNSU2VyYnZa?=
 =?utf-8?B?dCtIc0czSC8xcWtrRVhoaHFKenRPUjk1U2Z3dTBHN2VxT2JTZmUrbVJQNEFw?=
 =?utf-8?B?ZEtrdS85cVY0bjA1dzRrMnNoeWNPUGI3NzZIR1VIQThvaFNXdHB1cFFnak1w?=
 =?utf-8?B?enhpMGl3d0JHdDUzUFFnNVFrMkNUMEYzMmRqejZHLzY4ZVc2cXZ4V3FkWXRG?=
 =?utf-8?B?N3hNTTBWZExGMVU3WnFXYzRCTVIwdGJaamFFUkpRM1FJQVljZzRDM1g2NnE5?=
 =?utf-8?B?cUhON0hiUVdxQlBkVmJKMlg1eVh5aG0zT3RZSE9OL0F1Q1ZCN2xhakpvN25W?=
 =?utf-8?B?SXFYNkxPc1pMSTdUQTlTNHIyMWVPdXYzSjVqaDBsSzRUWHFEazRxaEVHZ2J4?=
 =?utf-8?B?TVFtaHpURGZUWHdYS3I1OGR0NVYya0dNeEZ2Mk9xYVhReEV1K21oUGhKTG13?=
 =?utf-8?B?THFZMmUvMkVwL2NVbDFCa21ta0Z0azVvTFdBMW5SVDNYcWFKSW1iTExDNVg3?=
 =?utf-8?B?cDJ3NzZRVXNTRGdSODk2Sk51Z1d5UUdVOEZzcnBPa2pPZGJnVHVQT3FKVWZh?=
 =?utf-8?B?eXR2c09NbmkxMElObGZnZXE3OGVuT0hGOWo3NXlZbDFxamhKMGNuZmpYUThz?=
 =?utf-8?Q?CZlS8MRbvsDXMzMH3sNfuseXP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f2e5e2-40ad-4dfd-e921-08da8b9f5560
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 22:22:47.7009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZR6MuH3P+bwbnopM5NYxsCySd8nwjCvNDGQLL712Rb+Z4Fq+5qcllZKiCWf/5Sq9YtR6YHNCg9tT9mubTYwkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_14,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310109
X-Proofpoint-ORIG-GUID: As9HemPZMT63d1a76AJOt_o_Ag0Uabuh
X-Proofpoint-GUID: As9HemPZMT63d1a76AJOt_o_Ag0Uabuh
Cc: "eperezma@redhat.com" <eperezma@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

CgpPbiA4LzMwLzIwMjIgMTA6MjIgUE0sIEVsaSBDb2hlbiB3cm90ZToKPj4gRnJvbTogU2ktV2Vp
IExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+PiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAz
MSwgMjAyMiAyOjIzIEFNCj4+IFRvOiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29t
Pgo+PiBDYzogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+OyB2aXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZzsKPj4gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT47IGVwZXJlem1hQHJlZGhhdC5jb20KPj4gU3ViamVjdDogUmU6IFJGQzogY29udHJvbCB2aXJ0
cXVldWUgc2l6ZSBieSB0aGUgdmRwYSB0b29sCj4+Cj4+Cj4+Cj4+IE9uIDgvMzAvMjAyMiAzOjAx
IFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+PiBPbiBUdWUsIEF1ZyAzMCwgMjAyMiBh
dCAwMjowNDo1NVBNIC0wNzAwLCBTaS1XZWkgTGl1IHdyb3RlOgo+Pj4+IE9uIDgvMzAvMjAyMiAx
Mjo1OCBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4+PiBPbiBUdWUsIEF1ZyAzMCwg
MjAyMiBhdCAwNjoyMjozMUFNICswMDAwLCBFbGkgQ29oZW4gd3JvdGU6Cj4+Pj4+PiBIaSwKPj4+
Pj4+Cj4+Pj4+Pgo+Pj4+Pj4gSSBoYXZlIGJlZW4gZXhwZXJpbWVudGluZyB3aXRoIGRpZmZlcmVu
dCBxdWV1ZSBzaXplcyB3aXRoIG1seDVfdmRwYQo+PiBhbmQgbm90aWNlZAo+Pj4+Pj4gdGhhdCBx
dWV1ZSBzaXplIGNhbiBhZmZlY3QgcGVyZm9ybWFuY2UuCj4+Pj4+Pgo+Pj4+Pj4gSSB3b3VsZCBs
aWtlIHRvIHByb3Bvc2UgYW4gZXh0ZW5zaW9uIHRvIHZkcGEgdG9vbCB0byBhbGxvdyB0byBzcGVj
aWZ5Cj4+IHRoZSBxdWV1ZQo+Pj4+Pj4gc2l6ZS4gVmFsaWQgdmFsdWVzIHdpbGwgY29uZm9ybSB0
byB0aGUgbWF4IG9mIDMyNzY4IHNwZWNpZmllZCBieSB0aGUKPj4gc3BlYy4KPj4+Pj4+Cj4+Pj4+
PiDigJx2ZHBhIG1nbXRkZXYgc2hvd+KAnSB3aWxsIGhhdmUgYW5vdGhlciBsaW5lIHNwZWNpZnlp
bmcgdGhlIHZhbGlkIHJhbmdlCj4+IGZvciBhCj4+Pj4+PiBtYW5hZ2VtZW50IGRldmljZSB3aGlj
aCBjb3VsZCBiZSBuYXJyb3dlciB0aGFuIHRoZSBzcGVjIGFsbG93cy4KPj4gVGhpcyByYW5nZSB3
aWxsCj4+Pj4+PiBiZSB2YWxpZCBmb3IgZGF0YSBxdWV1ZXMgb25seSAobm90IGZvciBjb250cm9s
IFZRKS4KPj4+Pj4+Cj4+Pj4+PiBBbm90aGVyIGxpbmUgd2lsbCBkaXNwbGF5IHRoZSBkZWZhdWx0
IHF1ZXVlIHNpemUKPj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4gRXhhbXBsZToKPj4+Pj4+Cj4+Pj4+PiAk
IHZkcGEgbWdtdGRldiBzaG93Cj4+Pj4+Pgo+Pj4+Pj4gYXV4aWxpYXJ5L21seDVfY29yZS5zZi42
Ogo+Pj4+Pj4KPj4+Pj4+ICAgICAgc3VwcG9ydGVkX2NsYXNzZXMgbmV0Cj4+Pj4+Pgo+Pj4+Pj4g
ICAgICBtYXhfc3VwcG9ydGVkX3ZxcyA2NQo+Pj4+Pj4KPj4+Pj4+ICAgICAgZGV2X2ZlYXR1cmVz
IENTVU0gR1VFU1RfQ1NVTSBNVFUgSE9TVF9UU080IEhPU1RfVFNPNgo+PiBTVEFUVVMgQ1RSTF9W
USBDVFJMX1ZMQU4KPj4+Pj4+IE1RIENUUkxfTUFDX0FERFIgVkVSU0lPTl8xIEFDQ0VTU19QTEFU
Rk9STQo+Pj4+Pj4KPj4+Pj4+ICAgICAgZGF0YSBxdWV1ZSByYW5nZSAyNTYtNDA5Ngo+Pj4+Pj4K
Pj4+Pj4+ICAgICAgZGVmYXVsdCBxdWV1ZSBzaXplIDI1Ngo+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+PiBX
aGVuIHlvdSBjcmVhdGUgdGhlIHZkcGEgZGV2aWNlIHlvdSBjYW4gc3BlY2lmeSB0aGUgcmVxdWVz
dGVkIHZhbHVlOgo+Pj4+Pj4KPj4+Pj4+ICQgdmRwYSBkZXYgYWRkIG5hbWUgdmRwYS1hIG1nbXRk
ZXYgYXV4aWxpYXJ5L21seDVfY29yZS5zZi42Cj4+IG1heF92cXAgMSBtdHUgOTAwMAo+Pj4+Pj4g
cXVldWVfc2l6ZSAxMDI0Cj4+Pj4+Pgo+Pj4+PiBBIGZvbGxvdyB1cCBxdWVzdGlvbjogaXNuJ3Qg
aXQgZW5vdWdoIHRvIGNvbnRyb2wgdGhlIHNpemUKPj4+Pj4gZnJvbSBxZW11PyBkbyB3ZSBuZWVk
IGFiaWxpdHkgdG8gY29udHJvbCBpdCBhdCB0aGUga2VybmVsIGxldmVsPwo+Pj4+Pgo+Pj4+IFJp
Z2h0LCBJIHRoaW5rIHRvZGF5IHdlIGNhbiBvcHRpb25hbGx5IGNvbnRyb2wgdGhlIHF1ZXVlIHNp
emUgZnJvbSBxZW11Cj4+IHZpYQo+Pj4+IHJ4X3F1ZXVlX3NpemUgb3IgdHhfcXVldWVfc2l6ZSwg
YnV0IGl0IGhhcyBhIGxpbWl0IG9mIDEwMjQgKGJ0dyB3aHkgaXQgaGFzCj4+Pj4gc3VjaCBsaW1p
dCwgd2hpY2ggaXMgcmVsYXRpdmVseSBsb3dlciBpbiBteSBvcGluaW9uKS4gSSB0aGluayB3aGF0
IHdhcwo+Pj4+IG1pc3NpbmcgZm9yIFFFTVUgaXMgdG8gcXVlcnkgdGhlIG1heCBudW1iZXIgb2Yg
cXVldWUgc2l6ZSB0aGF0IHRoZQo+PiBoYXJkd2FyZQo+Pj4+IGNhbiBzdXBwb3J0IGZyb20gdGhl
IGJhY2tlbmQuCj4gSSBhZ3JlZSB0aGF0IGV0aHRvb2wgaXMgdGhlIHdheSB0byBnby4KPiBCVFcs
IFNpLVdlaSwgY2FuIHlvdSBwb2ludCB0byB0aGUgY29kZSB0aGF0IGxpbWl0cyB0aGUgY29uZmln
dXJhdGlvbiB0byAxMDI0PwpJdCdzIGluIFFFTVUncyB2aXJ0aW9fbmV0X2RldmljZV9yZWFsaXpl
KCk6CgogwqDCoMKgIHZpcnRpb19uZXRfc2V0X2NvbmZpZ19zaXplKG4sIG4tPmhvc3RfZmVhdHVy
ZXMpOwogwqDCoMKgIHZpcnRpb19pbml0KHZkZXYsICJ2aXJ0aW8tbmV0IiwgVklSVElPX0lEX05F
VCwgbi0+Y29uZmlnX3NpemUpOwoKIMKgwqDCoCAvKgogwqDCoMKgwqAgKiBXZSBzZXQgYSBsb3dl
ciBsaW1pdCBvbiBSWCBxdWV1ZSBzaXplIHRvIHdoYXQgaXQgYWx3YXlzIHdhcy4KIMKgwqDCoMKg
ICogR3Vlc3RzIHRoYXQgd2FudCBhIHNtYWxsZXIgcmluZyBjYW4gYWx3YXlzIHJlc2l6ZSBpdCB3
aXRob3V0CiDCoMKgwqDCoCAqIGhlbHAgZnJvbSB1cyAodXNpbmcgdmlydGlvIDEgYW5kIHVwKS4K
IMKgwqDCoMKgICovCiDCoMKgwqAgaWYgKG4tPm5ldF9jb25mLnJ4X3F1ZXVlX3NpemUgPCBWSVJU
SU9fTkVUX1JYX1FVRVVFX01JTl9TSVpFIHx8CiDCoMKgwqDCoMKgwqDCoCBuLT5uZXRfY29uZi5y
eF9xdWV1ZV9zaXplID4gVklSVFFVRVVFX01BWF9TSVpFIHx8CiDCoMKgwqDCoMKgwqDCoCAhaXNf
cG93ZXJfb2ZfMihuLT5uZXRfY29uZi5yeF9xdWV1ZV9zaXplKSkgewogwqDCoMKgwqDCoMKgwqAg
ZXJyb3Jfc2V0ZyhlcnJwLCAiSW52YWxpZCByeF9xdWV1ZV9zaXplICg9ICUiIFBSSXUxNiAiKSwg
IgogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJtdXN0IGJlIGEgcG93ZXIg
b2YgMiBiZXR3ZWVuICVkIGFuZCAlZC4iLAogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIG4tPm5ldF9jb25mLnJ4X3F1ZXVlX3NpemUsIFZJUlRJT19ORVRfUlhfUVVFVUVfTUlO
X1NJWkUsCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVklSVFFVRVVFX01B
WF9TSVpFKTsKCi1TaXdlaQo+IEFuZCBpZiBldGh0b29sIGRvZXMgbm90IHByb3ZpZGUgYSB3YXkg
dG8gc2hvdyB0aGUgbWF4IHdlIGNhbiBhZGQgdGhpcyBzdXBwb3J0IGluIHRoZSBmdXR1cmUuCj4K
Pj4+PiAtU2l3ZWkKPj4+Pgo+Pj4gb2theSBzdXJlLiBteSBxdWVzdGlvbiBpcyBob3cgaW1wb3J0
YW50IGlzIGl0IHRvIGNvbnRyb2wgaXQgaW4gdGhlCj4+PiBrZXJuZWw/Cj4+IEkgZG9uJ3QgaGF2
ZSBhIHNwZWNpZmljIHVzZSBjYXNlIGZvciB0aGF0IChpbiBrZXJuZWwpCj4+Cj4+IC1TaXdlaQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
