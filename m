Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E50CDB483
	for <virtualization@archiver.kernel.org>; Fri, 13 Oct 2023 17:29:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61D7741FA5;
	Fri, 13 Oct 2023 17:29:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 61D7741FA5
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=zsK6AYqZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=o1p6zWXL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iwAzD0WYiUPQ; Fri, 13 Oct 2023 17:29:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C4D9D41F7C;
	Fri, 13 Oct 2023 17:29:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C4D9D41F7C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A7CAC0039;
	Fri, 13 Oct 2023 17:29:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F443C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 17:29:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4329441F8B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 17:29:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4329441F8B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I0wTpxu394jc
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 17:29:37 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F2F5641F7C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 17:29:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2F5641F7C
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39DGa88L002557; Fri, 13 Oct 2023 17:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=OMeJ0aX7xJTyhul1T8v5Z5XqyWqE36dHaGxM5jpBryw=;
 b=zsK6AYqZaa8MI7qgskMO1QB12zV3mlrrc3gUNkAdR8XJ2mm3TRo7dNfSLkfi4pESjpS3
 OQiKkGm41rtRwX84UDSq9Cu8nxZhJGMwsxXc8nKNl3fpGSqYSZ1FE4xYEAm+Moabh9Ao
 R6mRu/H94BTMfJDEz79JH0AwH6dOyj88y8VWRVKQZTG0kCNwPZf2+uwDJIqSHv9JDedy
 IOrRjQIP5UtFtGn0Fpm7dRnHrKO2l1L6JLsiC/CujvKzIvVnNArtx62sewNo2+p0rDG6
 sUNIsf5HD3LfL3crsHZA5rmxvLpBRqc60n9Df1BMLLr04lNrPBeVZuf9mKJkFAXB3jxi kQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjycdwmc2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Oct 2023 17:29:35 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39DH3IuP040242; Fri, 13 Oct 2023 17:29:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tpteaw3nv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Oct 2023 17:29:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrhRGCsj3XG9uRPOw6R3q0/rTfCYyAbG1SqkUwII4iPC8qYha2Hfar3q5jfQMI8JL03ngaNyWTKabnEtxyKIbgY5r9KE3vQxuQb4prAQm6gZxEKgeP3tWYv8zrp+QOt2D4Q6BU0UcnCfp9u9/2P6ZQQ+lhtzHJINeFpt1fa0b8CYn6AmHjwNUBk3wtGU39iubKAX+Npaybrep0OIRCEwdZGNd2rY8IvkjuKM3MWWnT7VoqzUdga9IyUFgmYWq1Rqq/DYnjwIx5hRKjXRgC7YUCpvoglk6Do/6d7wuhfQGpc7QMFnsE1J4gqoi8EUl3BGxN4WKqZeqDDe361OkRJpIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMeJ0aX7xJTyhul1T8v5Z5XqyWqE36dHaGxM5jpBryw=;
 b=J7uy+Ox3HpEMvCDH7DJ+67FSk2aILZXMgdiNIwTseSt4CSTT47Vbb6hozU8rhNEBxcId3Y0h1T1S0CWTI88Z0qvieaJ5CZ5c13JHxpHaRt9Z0HYJ96uE4Im8rFao2/gik77HnXAjrl0HWNvWHA8wc0cziiROu2AyVJwJqU2LTpZu5f+MJ5kUKXPBxHw+FJz4FOLEkJYOJa3Y2MjjC2X6Douizm1GbwFfzhlLlbYrkuVHfolZA3Li1JaUnabZi8dcHQMb+UP+2vFTffIuIJKMu0uSKXegroFPFyRuLs4yCd91siLOIA3Z72uqDWaPk+zsK5ZH2NRtsjVaeebscljNvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMeJ0aX7xJTyhul1T8v5Z5XqyWqE36dHaGxM5jpBryw=;
 b=o1p6zWXL0LKqSKc8v1RGvL8uUl8RgiBUYw6VGXeu3yXDAQmiRLqyXD+Zeeg8ssIfXWQ3CnhBvgGeLnmTEDZfCP10sF35GMoXdU0WIgnY8gn1OCGvX9i5Y36dhAKBgf6tL1szK8cWMfBG3lu+vKikvd5Oo1V3kSzBm89Dr4AIFCQ=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by IA0PR10MB7253.namprd10.prod.outlook.com (2603:10b6:208:3de::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 17:29:31 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 17:29:31 +0000
Message-ID: <2222edd1-4eb1-4b06-87ef-df2d4f591931@oracle.com>
Date: Fri, 13 Oct 2023 10:29:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] vdpa_sim: implement .reset_map support
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
References: <1697185420-27213-1-git-send-email-si-wei.liu@oracle.com>
 <4o4yuuezigilikolv2paxb7icrsm3gdnj5aeoe47uotzju7xve@s5vqaafrppdv>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <4o4yuuezigilikolv2paxb7icrsm3gdnj5aeoe47uotzju7xve@s5vqaafrppdv>
X-ClientProxiedBy: BYAPR06CA0003.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::16) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|IA0PR10MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: 366bddd9-11b3-4571-03b7-08dbcc11f586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V9CQYLrwBAMnXwnbvZJbjVeRiJyjmzPoKF2nILoUynIq3OFDAEZAp37Rz9EwgeVPypUfyypSIwWI7iHnXO6yRNcqxef5UIOcNhOV67vyv97ZmeJ65F4m9/0rNKkhqmP8EcYPGcj9BdRJCIT45YssRbqFZoBhjFlGrZoHI5jGW3CIgu/6pWOS+ahy32q4arPSDmtRSlZoRqi9dpqJHirFIlDHZhv/JH8ChyBuiV2LMBeH6ZOD4ArBV+1LJmhcC9byeVfcp1H350IeyUVfx14SZRo8Bg/0027LVS4viCdllwtdiX90yMdipqzWOabi98lOJAd/Pmho8G/+OcB/wWRsi71N3/scfsw08zATNZW9fLnQoGwAbA9YDH1EUTQn19b6fcNWVkvgyYp2jPS8+aZiJPg9B0XCOSMNYPRiyA6xkKea4Kcx6lEQyE3PzFZ0jm3jwGOZh0ue7i5jruNHEawm2kUIowzQ0FiNSuHojahSXfapxr3xtq1PyLF0HFBYHIk/jUI002t6SZfRV/gtwTq1sddRVovxE4c0gKTQiLrmkUZKXtvrhDaEL4AXD4BNod3OCabmY604Exx4L4lgc9T3TAsYfjiJZNxeKQsFBK8TDjrcKVZSxzsTlaq+ovzPt1SlwI+THB/sRfxpl4b9E/QSJ6TIqWfDl68xCr/VyfROgA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(39860400002)(366004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(6506007)(36916002)(53546011)(83380400001)(31686004)(38100700002)(6512007)(31696002)(2906002)(8676002)(966005)(6486002)(4326008)(86362001)(6666004)(6916009)(66476007)(66946007)(316002)(5660300002)(66556008)(41300700001)(36756003)(8936002)(2616005)(478600001)(142923001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NThaT0tLdU5DZHVFc1U5SkNFSmdxUUZNUWhiRGN0M0h3c2d3L1JiNDZBY3Fs?=
 =?utf-8?B?Q2pQemlYdDBNUjJ6YWNCaVdkREVIalNtQ3M2d1dTRnJBQmhKWWFrdkQ3T3FE?=
 =?utf-8?B?NGd1ZUFXaVpvdmNHeStSWTFmeGV1MXAvb0U1ZDBmMjh3OVY3U2hJclM0b01i?=
 =?utf-8?B?VFVnRHM1NCtPMXhyR3UvZnFJSy8vcUtQRG4yUUJpM0xqRjM2WEZ2ald2U1dz?=
 =?utf-8?B?Q0ZoTnB2RVpGdnFzeXJUOEwyYkJaYXBhdmh5eGJpVkJZSzZVTXA5dmUzTkhz?=
 =?utf-8?B?VWcyUjQwMXBqbUNpRHJWL2hEa0MwWityUy9WWTJ1RVNYOVpnbjIxcnNDQ2VS?=
 =?utf-8?B?UVFOS0oxQi8wSUhocDhzV0NXT3UrSU1YM0c1RDBRL1NTWkJZdk5MNnNkVWQ4?=
 =?utf-8?B?M2pGVUY0MG53SEM4aC9UeTlHQTdEVDhpNXFBdk1aMUxnSVl2ai9EanVaaVVS?=
 =?utf-8?B?V29RblFaVEsvVTZkajF3STlpNFdQcWtaVVR4OTg3cEd5R0x3T05URTJYbGRj?=
 =?utf-8?B?SkR5NjUyQWtiS1QvNWg0TW4xWXRpaVBFNnVKZU00K2laTVdEb1lSamEwVjdK?=
 =?utf-8?B?YlVQNFpsWmtuSGtyMkIvKzNKeWlGTzR1SDI5MWkvWXFQU2oveTBjeTZRSFhv?=
 =?utf-8?B?dnhETythMmVPWjcxODg2MDcxNndrTlJOSm85b0lQWDBlSUk0SlEvbHRhOVNO?=
 =?utf-8?B?SkxXc1hmRU5OS1JCNkRnWWpoU0lwUXZvdCs3eFdUemdpWlI5WG9FU1pCRm5h?=
 =?utf-8?B?Slp4SGpCelpjS0xwRytmM0N2OElraVFSbUVwdW9VQjhRWHlscVhkcEhwWGJs?=
 =?utf-8?B?Uk90LzRPaWkyQTFZRWR2T1dMYmhRdDlKTkNTRjRNSGdnUnd3M3VqMTBkaysz?=
 =?utf-8?B?ZHArTVY3RnNEZ1YySUs2NkdwVDFadXVUVDdCbEFzb2pRMGZaSlMybkhBVDlY?=
 =?utf-8?B?dm5TQ05kV3BEYU1HNXdhT0E1NVNFb1c1VGJVcEJiT2dnb2FTejZkQ00vdTV0?=
 =?utf-8?B?L3Njb2pjdHhhQm0zSW1uakJDak94K2U5SVdHTHRNQ0dDMzAwRlo1WU9CWEhL?=
 =?utf-8?B?UXBxNlJqQjVtMkNYNU9UeUZQazljbmV0VElGZnVzRllEZkhXZnQ1ckdiaFBX?=
 =?utf-8?B?Y0dUN3gvaVIxNHE3enNtY0hnZjZJWW83Zm9CUzFDVHJDSitTSUsxQy9obkxZ?=
 =?utf-8?B?KzdUcFl0R1hHNi9ucUxvSDNMY2Q4aDZGTHRJTXpTRnNoM2FJSjliZmwrZmZ5?=
 =?utf-8?B?RExTUEVIWmYxOVJsdExBVVcyVkJmNTU4RGRVMlNrd2NsOEg2dU5MM09wd25H?=
 =?utf-8?B?YXFXRDZCMU0xclRKTzVMRWJJazZ4d0dyakxYbjVuZ2FHL0JuS2tDRG1CK2FU?=
 =?utf-8?B?b0ppMjEwb0pLakN5STdwNnBTdm5uaVpXdW44dllGKzVabjM3NUNwWFFyWkxH?=
 =?utf-8?B?NVJ2MWRVWVRLa3ZwSzRwcitoeGdMT1BvNno0NlM1VmFQSUV5amVyUEFEWXRH?=
 =?utf-8?B?RXdTankrQitqSGNpZGwzT0lDaXl1L2IvbzhJWlNpTDREcHlqTUtBV2J1QndR?=
 =?utf-8?B?ODZGNjZna0hVR1ppaCs5cnRiWkZFSkM3ODdnWnVnZDg2eHQ5MlhlQmhFUmxQ?=
 =?utf-8?B?ZUxRR2ZGSGpYd0l2M3FGZWRtaEFDdGNkcnhlSHdUeGw2MmUrVkpCYitGTUVY?=
 =?utf-8?B?Q3pvTHdhYlQ2UGUyeGFlSDdHL1lNaFBUZE5mUkQzVTdHMDUveE13RENjWHN4?=
 =?utf-8?B?cXdza2EyaG1ZTmRzTzFSd25QTHU5Qm4zRXpIM0JjcWVacGZGMFZnTHNpREFS?=
 =?utf-8?B?aE1BblZyRUNDZGtoakJTclNTUnRTckNJL2xxVnhROWd1YnBxbE05cnBrMjY3?=
 =?utf-8?B?amNGMDRoYkozSGtUeVpDcHVVTmxtY3ZXNjI2T0ZPQ3kxK2tpemxPbUxWdmFC?=
 =?utf-8?B?STdBUnI2RDBOcC9URCs0YXR5aFU0cUlWZEd0YXh5cWdxcTcySmhNbkZMYzg5?=
 =?utf-8?B?Qk9BS0piVk42RHBRdmFBb1dyQ2NFRG8xWHpVb0M2L0hpUkJ1cFhjcWI1aVBT?=
 =?utf-8?B?dVdPTXFXUzBlekY3aG1CR2taZGM1ZTA3YUR0NngyQUcrdEg5eGxjVUVXTWtS?=
 =?utf-8?Q?0GjHMBvPjK+jCp1MGpH++WZud?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: r01loaGIUWbPGBHGfG4kSpTn86oRDthZGYAeu18glcHBxO0AALcoWssa3EWoSCh2ltUbzSEMM/i6J+cYyRpQW02KjH1gk25TuH/Wja8ZViyK6qTUWPRFpx/bYLO/5nsDxgJrL040AfjUpi3KA2S0ukg4t7gVYJIBhwoBeqQiPYMbEg0Pm4V4z16Yil8NAtw4ZF+6Emye04yvMXrHy0+zTzOe+lXtqRewayh6qloyJbKiwwcEsNCkAnyh5GOnnp0YbIhyXwYcBRky4LGjOn5Tdo/doo2rN1YpifHlDzIyfjsQIU321Dwyi46ix763UWE+z7PhIJWqOSlKBv2KgyuTAsGqw4aaAWvA1AxTEEYXmXOoOyMg7Mb0Odr3mJKj2hK15dobNwzU1UKKKnHkjpJ9wVfpW2SBuh9i4byK9920ZWDsZf55mOKNU1p+UT0pCqhjxoJh9TDnGTzyS8/i2KYgw23+vcpJDoipbvaeAO9l4SFBnEMjLlOjcMi4voofOlaXY1hpedCrJsvqsvvx30m05exZroXhODsBTIGbd5b4s+iLfTncGcktNZESV8Go7DBvNzOmN1LsfTvrK7W6INBEP9bkGkmIv9w7aj3z3/6g+HhtiPwpgippo5RqNu1F2PXJ+vGddbk8D3ExrVFu+kZ4IvCeX5lFuXTdV+jHbZRWDWS5oTMj3iLH1fSJtcheEIwwWwBq1NUguJDg7bk8hNzr2v3tGKgUuEJj7P51zgXAZc4nlNsP3OY3MAvNLbDpACw2aGMkvvl88GLfIS2xtZCtjKSSRRn9mcQphaGv0zEuCDN8I/7hneMnkTLEAvsPi6lmIR0E7W5Bg9uUChVY5BauxJ2QA5xpY8J3wRwc0ZuvGaU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 366bddd9-11b3-4571-03b7-08dbcc11f586
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 17:29:31.1142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWMNoGYcT/AaDQi/WrbNlRzZwiVIQOLaTDgQJQEEDJZ+cHThkJ/vsKZx8E0CXAd72kYRn8HC37wgvm3tsKk+Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7253
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_09,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130149
X-Proofpoint-ORIG-GUID: yGf7-6ZXwFsTwWzN4NG2_GpVc1ftIjCg
X-Proofpoint-GUID: yGf7-6ZXwFsTwWzN4NG2_GpVc1ftIjCg
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com
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

Hi Stefano,

On 10/13/2023 2:22 AM, Stefano Garzarella wrote:
> Hi Si-Wei,
>
> On Fri, Oct 13, 2023 at 01:23:40AM -0700, Si-Wei Liu wrote:
>> RFC only. Not tested on vdpa-sim-blk with user virtual address.
>
> I can test it, but what I should stress?
Great, thank you! As you see, my patch moved vhost_iotlb_reset out of 
vdpasim_reset for the sake of decoupling mapping from vdpa device reset. 
For hardware devices this decoupling makes sense as platform IOMMU 
already did it. But I'm not sure if there's something in the software 
device (esp. with vdpa-blk and the userspace library stack) that may 
have to rely on the current .reset behavior that clears the vhost_iotlb. 
So perhaps you can try to exercise every possible case involving blk 
device reset, and see if anything (related to mapping) breaks?

>
>> Works fine with vdpa-sim-net which uses physical address to map.
>
> Can you share your tests? so I'll try to do the same with blk.
Basically everything involving virtio device reset in the guest, e.g. 
reboot the VM, remove/unbind then reprobe/bind the virtio-net 
module/driver, then see if device I/O (which needs mapping properly) is 
still flowing as expected. And then everything else that could trigger 
QEMU's vhost_dev_start/stop paths ending up as passive vhos-vdpa backend 
reset, for e.g. link status change, suspend/hibernate, SVQ switch and 
live migration. I am not sure if vdpa-blk supports live migration 
through SVQ or not, if not you don't need to worry about.

>
>>
>> This patch is based on top of [1].
>>
>> [1] 
>> https://lore.kernel.org/virtualization/1696928580-7520-1-git-send-email-si-wei.liu@oracle.com/
>
> The series does not apply well on master or vhost tree.
> Where should I apply it?
Sent the link through another email offline.

Thanks,
-Siwei

>
> If you have a tree with all of them applied, will be easy for me ;-)
>
> Thanks,
> Stefano
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
