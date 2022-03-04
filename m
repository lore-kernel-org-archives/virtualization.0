Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FC2C433EF
	for <virtualization@archiver.kernel.org>; Fri,  4 Mar 2022 22:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B2D5C405B6;
	Fri,  4 Mar 2022 22:34:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8PK-aUF5fvlc; Fri,  4 Mar 2022 22:34:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4B7214010E;
	Fri,  4 Mar 2022 22:34:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A749C0012;
	Fri,  4 Mar 2022 22:34:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 700A5C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 22:34:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4B3DC81CC3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 22:34:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="Dv2rozRP";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="AAk4ke3u"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cdpJ84xBWH7B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 22:34:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 18E0F8175E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 22:34:28 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224K73hr020764; 
 Fri, 4 Mar 2022 22:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=dhCXexqsyFW3kosHpbIm9BEwy182Z7xwEFBpbJP/QZg=;
 b=Dv2rozRP5j+/8+NzkEg5aNyo+hk0lerRy+WCx1GfOkle20epy61JUa8aEpGq0CobHbTp
 77PRbja0a6IujskEGer7p3kKJSHZdkHaa88JVB7wpp+4lpeyNlQ90hkcvmHlzRH7IdfT
 6xTrpvkNTwjJ2vB/b/MXFIHwGwm7/SiI/X+64Ptru4RIZKKCN26YL64VrqIK7rvYqLUW
 nIKiAQbsfDf5foUxuXPV2vd401ni+0Hq6Q+qJOEj8fQ6itoJU59NpD6d6fnH7v5kPdcV
 MX7P/t3IgiWRbLtrdUefBXSmE1qNDqZoOuHF2UCZ8QdUBJg8oJdGptRUls0KbVRONXCD WA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ek4hw325n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Mar 2022 22:34:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 224MFmnt055591;
 Fri, 4 Mar 2022 22:34:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
 by userp3020.oracle.com with ESMTP id 3ek4jhh997-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Mar 2022 22:34:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H01gDyZN/5N6nYflXSulbGJuhGXW+Dsfj1AxP4OlNiY8UeE/+rCKZOoveAnyvtSWpjPnZGeSLZiUnP7B6WyukQLf2AsuTH0ZVnrpVhKDEdNx1DBVIyVLOotd7JVrnvXJ6JD3nDHmNE2QI3GWLjp8K+vWJKs2zeWLJRX/Zs57kL1Nt15QLr1LhIn5S3ipeklgQGnzsWoWeovE4PxKnMHjfxCAWy4PqxMr6plCZnuIMjLHzsT1oslg2QIfMwa8nig/5aCIfc1Np8OAUe226+LwZ+gpL2gNi2JfVI/oVRBiQzYCzWThVGaSNmzgBHHtEbQEMijxr3F2w0bdURvnUPpfHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhCXexqsyFW3kosHpbIm9BEwy182Z7xwEFBpbJP/QZg=;
 b=aRwJVfU14idrocKNrHB5Sweu03DrYaKpWwM/7j+bpuL+k/M4bi8zbISkrqKM+yRDmLccjp529zgF7YZslM2WRjx5EpV6HHcGjp2kWwsgQHWieKVH7wITDqE/JNlbKG17vkxEkcGcd/Nf9+fvn08AO7a0mWJORzLODnURDT/NXvnu+D1lD0tfwqjfojTg2ocY9I50vupZXNynAmK8PALkVhZqsKxbReG/ESnnNHtzQmmYOaez3aVQ+sc8sTneSKJdIdUBvwSEQd6T3+2wiMvXFyZgItBXWN2meQ4UX/eP5yCXqD8bOs9DdvQO1CcSJEDU+pzHrLaVALFem3ZQu8/LDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhCXexqsyFW3kosHpbIm9BEwy182Z7xwEFBpbJP/QZg=;
 b=AAk4ke3uZo+FdWzyTuSCV1IxFec2pEak5b61ldwwgdYD6Imn8cZj1I4Cl78/st4Pf7J7XNfH/ee5i3bi8Evp6rz/fUyWfzDLazIRuXrM9jNyEuzNfw+cVtPgysS5liFNTpC7YrUKweHZ8Hv/3frZbK8/PVLqZl/bvIFkQL3FpYg=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by CH0PR10MB5500.namprd10.prod.outlook.com (2603:10b6:610:111::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 22:34:24 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::e478:4b5e:50a8:7f96]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::e478:4b5e:50a8:7f96%6]) with mapi id 15.20.5038.014; Fri, 4 Mar 2022
 22:34:24 +0000
Message-ID: <8e834c04-47d2-1286-117d-28caa3e84606@oracle.com>
Date: Fri, 4 Mar 2022 14:34:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v1 1/2] vdpa: Add support for querying vendor statistics
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>
References: <20220216080022.56707-1-elic@nvidia.com>
 <20220216080022.56707-2-elic@nvidia.com>
 <22f77b5c-2003-c963-24c9-fce9cb53160d@oracle.com>
 <20220217064619.GB86497@mtl-vdi-166.wap.labs.mlnx>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220217064619.GB86497@mtl-vdi-166.wap.labs.mlnx>
X-ClientProxiedBy: BY5PR17CA0042.namprd17.prod.outlook.com
 (2603:10b6:a03:167::19) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67ec0903-1b59-47f6-34ee-08d9fe2f21f4
X-MS-TrafficTypeDiagnostic: CH0PR10MB5500:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5500A7922FC11EB0E43C2727B1059@CH0PR10MB5500.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NnCxt62h3oBvQpmh/eK6/Q4b0KMWnLw3OuEnajlIqGP8UMdpYiiWGZ3bwsptAE6tfOQY3zBb7gZu/VjZvI1AZ8zR+gRcT1WNeOG7K/PToF1/oZQTjhHWDJH+ulmySNBCHIIsL7ds9vRfAgnWS8z7GpMS8QspwIIurblHdr78A7ibP3St3+YG3d7EutsHh7e7msgJDqfBQwEOB+I2rGSDJRQm8GtHG+5B+rKanlUgEqFpCEpTUUNjcjreuxWONKNua7OvpjtpWdmpaP+Xr+E5Q42QhwFESQOtOZP7uijGCwBOKe33JHpJ6faN8WU4api83iBxw9V+mKGGaxr7wLgJSVhJVMrM+R/SIm+xbY/rw296hXw161QdRzlpKlxqa+nj4J4YEt1xskjuJoan2yZLEnG5FUdZhj3AEbvrdlry+a6xpxDItv/T94haz309XkapnSoViVWjVR+WvhyHdaF4QfQ9OOBGJS3BTjh91xe96+bCUDPb2/yxCgH/HLi4pVNz92d67giNfMdtYUg2QbtVvfg6K5uSyvQ8/AhCkj2DbVEw+/XW/mKwft9OeYyyZBrqL1T9KAZlbrjALZctC+WSW10T+oIRPusnbLJGNq0wW1rixIkU54oykU8eh40conb7+Zg87rPh3d7eDF7MphCF/aGJ0N5fe8+kFKCl4hKWvcbQI1qPomj0u3k5+AHRmRsvRyLkDxp34aoY8Nez9xPAziqyrm9Y5pgF79OGA9iizM4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(6916009)(36916002)(66556008)(53546011)(38100700002)(6506007)(5660300002)(4326008)(8936002)(8676002)(66946007)(66476007)(6666004)(316002)(2906002)(86362001)(186003)(31696002)(2616005)(6512007)(31686004)(36756003)(508600001)(6486002)(83380400001)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFVkL0dDRnhKTWpiZEkvcUJDbHd1c3RiU1ZsdHhrLzcxQ1FUelMxWDFzbjRy?=
 =?utf-8?B?K2lhczJsb0tBU2ZTOXhsRTJyUkIvTW9PL0NoR2ZNNVc0Q3pMQ255eXdzamJE?=
 =?utf-8?B?d2JCTzNRV2IyREZZck02T1ZkRlp4ayszSmZjWG1lL0NyZ3dyY2FGWTFjYzU4?=
 =?utf-8?B?S2xRM3NqOCsvaXZRa3U4a1YvOWxveXRGSE9vam0rSWZpb2x6NmxsNXoxaHhs?=
 =?utf-8?B?d3R1Z1ZZNzBFa2VkcnA1QlAxTXI0VW1JUmphTVo2Y01EY1Q5T1F5WHREamRP?=
 =?utf-8?B?N0RkblUwNWVYbjk5WnA1M3YwSm12OWxVM1dHejhLckN6K1R5eXFFNy8wTzFP?=
 =?utf-8?B?SkJMRXFFN01iZ2xBODB4NFE1M1JmWEl4RDNSS0RNMkd5eFpFUkEvUFBsM3J6?=
 =?utf-8?B?NDFwUFdqaVJrVlVtcHI1NXR3cHBRZy9Rc3hXN1NQMmh0VnNqSzYvc2g0MzVm?=
 =?utf-8?B?UkpDaFQrVGxsYm9CUUtZTVNUWGUyZDBIaGVJSG9MSG1QdHdib1puclBUeFI4?=
 =?utf-8?B?RCs3UHE5UytZc0VqQjl3NjAyRlhTM0h0UDM3cVJLMy80N2pLVHhFMEM1MmVk?=
 =?utf-8?B?Rm5nSm9ZdDBObnVsQyswVGl2aWhqQUhiakdaRTJtK0ZRNk94cDJoaThBU2xO?=
 =?utf-8?B?VXB2VU52eDRKVFlTdnpmSHJCOE9qYmxmNWtGTjlsd1kzb01ST1R6dGhoOWsv?=
 =?utf-8?B?ZTVENVBXN0U3NFpva2tKNmVCMjhlTStxMVd5ZnJ6eHdFcU5udlg5VldsVFdu?=
 =?utf-8?B?V2ZuV0dKV3ljdDFpeCtuejlubVRiVUhZNlhDUHJvUm93N0pvekcreVdOSjhp?=
 =?utf-8?B?MERLako1N2E3ZVphU2gzYXFiczRJN3JiUnphZlYzRWpPbDZWaW9YM1VzN3h6?=
 =?utf-8?B?NnZYWEpFNDVDM2ZNeDBtMXJSOXVLdUNCRWl1emlSakM2b1RzUzdIK3p0K2Ji?=
 =?utf-8?B?UzF1QVJiakJlSFJzVDgyb0paUDhRTGhMU3pCVGIycE02SEtxUThrY21pdzM1?=
 =?utf-8?B?eUt6SjdkTUpQaEtwVmRDRkYxR04xQktuL2hjbllPSXVLRXpvaWxLVVdvVVpm?=
 =?utf-8?B?VkVyRm5QYU9GeEk3bzhNT1BFaWd0bEFyMVNLaElLeWUwZjU3VTNYVGJub2xY?=
 =?utf-8?B?anNOcFV2eDRYcHR6WXRKKzRUVmZPWHNUL3FMN3VrUXFKRG5SN1hzdktDQjNX?=
 =?utf-8?B?VzNGWlgvVG1oWkxoYXVhYnFtQjAvcUJQeTVUOWM3OHRZeVhvS2VKSFJ2V3BH?=
 =?utf-8?B?ejR6ZW1oak9haEZmWVBJSTQ2aUhUMGdaZElTaldzN29JVmxXRUk1aXJSOXRN?=
 =?utf-8?B?d3ZMM09odkpOMEZNZkI5N0h3cGNwOEdDSDhreC9hNnZJY3R1U3BaQjY0YXFp?=
 =?utf-8?B?bjAwSzdIOEVEc0F1RjVrckEzRytjMTI4bHFZT04xaUdRV0JOZmhsRVVvWjBx?=
 =?utf-8?B?U0Y1VWdKeFpNZHMwVUpINkFRUnkycFFGYlY2MCs1SkdEM0dkNi9sTDdrYWxx?=
 =?utf-8?B?NEJWUG5KWW1JK3NJNVFRQWlOazR0M1k4bnExcWFJOTFZY2VBRXNDSElvRTUy?=
 =?utf-8?B?WlRkY0xFU2VKWlRHd09ZZnorSnkybHkxV0hRaGw2VWM5QjcvcjcrY2FOa0hs?=
 =?utf-8?B?WER6dkJQcFRzTEFVNlN1dHd3Kzk1eUQ3Z1JlLzU5SnU1ZS9GRlptYnlrUC93?=
 =?utf-8?B?Tm5qS3VVcFNlMk9HVCtzbzJiaGhVc0w4VEZqK0x4UU0vMmxqOUNOckUvRk1r?=
 =?utf-8?B?WmlnMkNLV0piYng5MVZnWGdTVjFIWG1VUHZuVWRPbWZSVUU4N25wVVhsc3VY?=
 =?utf-8?B?YUdPR0dpbk1RZWJ5aEQzOFRKN1JGeUNodTc0bFZJLzNXNHZxNFRLMVFtaEgr?=
 =?utf-8?B?emxPMnlDRTFhWGc0WGx0clR4YnFBNGoxUi9NVEVjekJqTDRITEUzMTZCZHZ1?=
 =?utf-8?B?c2kvSnNPZGc3aHd4Q21pRSsxOGlZVXpjKzJheGVVWENHc0Zua2k1c2R3OGdW?=
 =?utf-8?B?M3RkblNNTFpjNlhDUmgwcG1oaThkelBsaHltZzRRMjdkT0xuODF5M1QyQVJl?=
 =?utf-8?B?b0dlbGFDUmZSUy9kRmczN0d0TnR4RWxhSzBja3JaQmd4RlVCTU1GUFRVMHVo?=
 =?utf-8?B?TnBubmE4YzN4dDZGekM5YnU2ZlBXbkNLcW0xRnVPQmlaY0hUUHN1dmloR1VY?=
 =?utf-8?Q?78NtyyCNB6mT2/NDKJxp2Aw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ec0903-1b59-47f6-34ee-08d9fe2f21f4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 22:34:23.9643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7DkkUeiK/U2PDQvBPXqk8aXlYq17T/DmQf57TiUDsBuPRqsV+VQNU3O6PdAsKu2pmIGTqrd/YH1ZuQL7zzWgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5500
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10276
 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203040111
X-Proofpoint-ORIG-GUID: oOQY_sMATSl8HAPMmLLoWXSOmc-2skTN
X-Proofpoint-GUID: oOQY_sMATSl8HAPMmLLoWXSOmc-2skTN
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

Sorry, I somehow missed this after my break. Please see comments in line.

On 2/16/2022 10:46 PM, Eli Cohen wrote:
> On Wed, Feb 16, 2022 at 10:49:26AM -0800, Si-Wei Liu wrote:
>>
>> On 2/16/2022 12:00 AM, Eli Cohen wrote:
>>> Allows to read vendor statistics of a vdpa device. The specific statistics
>>> data is received by the upstream driver in the form of an (attribute
>>> name, attribute value) pairs.
>>>
>>> An example of statistics for mlx5_vdpa device are:
>>>
>>> received_desc - number of descriptors received by the virtqueue
>>> completed_desc - number of descriptors completed by the virtqueue
>>>
>>> A descriptor using indirect buffers is still counted as 1. In addition,
>>> N chained descriptors are counted correctly N times as one would expect.
>>>
>>> A new callback was added to vdpa_config_ops which provides the means for
>>> the vdpa driver to return statistics results.
>>>
>>> The interface allows for reading all the supported virtqueues, including
>>> the control virtqueue if it exists.
>>>
>>> Below are some examples taken from mlx5_vdpa which are introduced in the
>>> following patch:
>>>
>>> 1. Read statistics for the virtqueue at index 1
>>>
>>> $ vdpa dev vstats show vdpa-a qidx 1
>>> vdpa-a:
>>> queue_type tx queue_index 1 received_desc 3844836 completed_desc 3844836
>>>
>>> 2. Read statistics for the virtqueue at index 32
>>> $ vdpa dev vstats show vdpa-a qidx 32
>>> vdpa-a:
>>> queue_type control_vq queue_index 32 received_desc 62 completed_desc 62
>>>
>>> 3. Read statisitics for the virtqueue at index 0 with json output
>>> $ vdpa -j dev vstats show vdpa-a qidx 0
>>> {"vstats":{"vdpa-a":{
>>> "queue_type":"rx","queue_index":0,"name":"received_desc","value":417776,\
>>>    "name":"completed_desc","value":417548}}}
>>>
>>> 4. Read statistics for the virtqueue at index 0 with preety json output
>>> $ vdpa -jp dev vstats show vdpa-a qidx 0
>>> {
>>>       "vstats": {
>>>           "vdpa-a": {
>>>
>>>               "queue_type": "rx",
>> I wonder where this info can be inferred? I don't see relevant change in the
>> patch series that helps gather the VDPA_ATTR_DEV_QUEUE_TYPE? Is this an
>> arbitrary string defined by the vendor as well? If so, how does the user
>> expect to consume it?
> The queue tupe is deduced from the index and whether we have a
> virtqueue. Even numbers are rx, odd numbers are tx and if there is CVQ,
> the last one is CVQ.
OK, then VDPA_ATTR_DEV_QUEUE_TYPE attribute introduced in this patch 
might not be useful at all? And how do you determine in the vdpa tool if 
CVQ is negotiated or not? Looks to me there are still some loose end I 
don't quite yet understand.


>
>>>               "queue_index": 0,
>>>               "name": "received_desc",
>>>               "value": 417776,
>>>               "name": "completed_desc",
>>>               "value": 417548
>> Not for this kernel patch, but IMHO it's the best to put the name & value
>> pairs in an array instead of flat entries in json's hash/dictionary. The
>> hash entries can be re-ordered deliberately by external json parsing tool,
>> ending up with inconsistent stat values.
This comment is missed for some reason. Please change the example in the 
log if you agree to address it in vdpa tool. Or justify why keeping the 
order for json hash/dictionary is fine.

Thanks,
-Siwei

>>
>> Thanks,
>> -Siwei
>>>           }
>>>       }
>>> }
>>>
>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>> ---
>>>    drivers/vdpa/vdpa.c       | 129 ++++++++++++++++++++++++++++++++++++++
>>>    include/linux/vdpa.h      |   5 ++
>>>    include/uapi/linux/vdpa.h |   7 +++
>>>    3 files changed, 141 insertions(+)
>>>
>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>> index 9846c9de4bfa..d0ff671baf88 100644
>>> --- a/drivers/vdpa/vdpa.c
>>> +++ b/drivers/vdpa/vdpa.c
>>> @@ -909,6 +909,74 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
>>>    	return err;
>>>    }
>>> +static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff *msg,
>>> +			       struct genl_info *info, u32 index)
>>> +{
>>> +	int err;
>>> +
>>> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
>>> +		return -EMSGSIZE;
>>> +
>>> +	err = vdev->config->get_vendor_vq_stats(vdev, index, msg, info->extack);
>>> +	if (err)
>>> +		return err;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int vendor_stats_fill(struct vdpa_device *vdev, struct sk_buff *msg,
>>> +			     struct genl_info *info, u32 index)
>>> +{
>>> +	int err;
>>> +
>>> +	if (!vdev->config->get_vendor_vq_stats)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	err = vdpa_fill_stats_rec(vdev, msg, info, index);
>>> +	if (err)
>>> +		return err;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int vdpa_dev_vendor_stats_fill(struct vdpa_device *vdev,
>>> +				      struct sk_buff *msg,
>>> +				      struct genl_info *info, u32 index)
>>> +{
>>> +	u32 device_id;
>>> +	void *hdr;
>>> +	int err;
>>> +	u32 portid = info->snd_portid;
>>> +	u32 seq = info->snd_seq;
>>> +	u32 flags = 0;
>>> +
>>> +	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
>>> +			  VDPA_CMD_DEV_VSTATS_GET);
>>> +	if (!hdr)
>>> +		return -EMSGSIZE;
>>> +
>>> +	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev))) {
>>> +		err = -EMSGSIZE;
>>> +		goto undo_msg;
>>> +	}
>>> +
>>> +	device_id = vdev->config->get_device_id(vdev);
>>> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {
>>> +		err = -EMSGSIZE;
>>> +		goto undo_msg;
>>> +	}
>>> +
>>> +	err = vendor_stats_fill(vdev, msg, info, index);
>>> +
>>> +	genlmsg_end(msg, hdr);
>>> +
>>> +	return err;
>>> +
>>> +undo_msg:
>>> +	genlmsg_cancel(msg, hdr);
>>> +	return err;
>>> +}
>>> +
>>>    static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info *info)
>>>    {
>>>    	struct vdpa_device *vdev;
>>> @@ -990,6 +1058,60 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
>>>    	return msg->len;
>>>    }
>>> +static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
>>> +					  struct genl_info *info)
>>> +{
>>> +	struct vdpa_device *vdev;
>>> +	struct sk_buff *msg;
>>> +	const char *devname;
>>> +	struct device *dev;
>>> +	u32 index;
>>> +	int err;
>>> +
>>> +	if (!info->attrs[VDPA_ATTR_DEV_NAME])
>>> +		return -EINVAL;
>>> +
>>> +	if (!info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX])
>>> +		return -EINVAL;
>>> +
>>> +	devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
>>> +	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>>> +	if (!msg)
>>> +		return -ENOMEM;
>>> +
>>> +	index = nla_get_u32(info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
>>> +	mutex_lock(&vdpa_dev_mutex);
>>> +	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
>>> +	if (!dev) {
>>> +		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
>>> +		err = -ENODEV;
>>> +		goto dev_err;
>>> +	}
>>> +	vdev = container_of(dev, struct vdpa_device, dev);
>>> +	if (!vdev->mdev) {
>>> +		NL_SET_ERR_MSG_MOD(info->extack, "unmanaged vdpa device");
>>> +		err = -EINVAL;
>>> +		goto mdev_err;
>>> +	}
>>> +	err = vdpa_dev_vendor_stats_fill(vdev, msg, info, index);
>>> +	if (!err)
>>> +		err = genlmsg_reply(msg, info);
>>> +
>>> +	put_device(dev);
>>> +	mutex_unlock(&vdpa_dev_mutex);
>>> +
>>> +	if (err)
>>> +		nlmsg_free(msg);
>>> +
>>> +	return err;
>>> +
>>> +mdev_err:
>>> +	put_device(dev);
>>> +dev_err:
>>> +	mutex_unlock(&vdpa_dev_mutex);
>>> +	return err;
>>> +}
>>> +
>>>    static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>>>    	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
>>>    	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
>>> @@ -997,6 +1119,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>>>    	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
>>>    	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
>>>    	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
>>> +	[VDPA_ATTR_DEV_QUEUE_INDEX] = NLA_POLICY_RANGE(NLA_U32, 0, 65535),
>>>    };
>>>    static const struct genl_ops vdpa_nl_ops[] = {
>>> @@ -1030,6 +1153,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
>>>    		.doit = vdpa_nl_cmd_dev_config_get_doit,
>>>    		.dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
>>>    	},
>>> +	{
>>> +		.cmd = VDPA_CMD_DEV_VSTATS_GET,
>>> +		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>>> +		.doit = vdpa_nl_cmd_dev_stats_get_doit,
>>> +		.flags = GENL_ADMIN_PERM,
>>> +	},
>>>    };
>>>    static struct genl_family vdpa_nl_family __ro_after_init = {
>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>>> index 2de442ececae..274203845cfc 100644
>>> --- a/include/linux/vdpa.h
>>> +++ b/include/linux/vdpa.h
>>> @@ -275,6 +275,9 @@ struct vdpa_config_ops {
>>>    			    const struct vdpa_vq_state *state);
>>>    	int (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
>>>    			    struct vdpa_vq_state *state);
>>> +	int (*get_vendor_vq_stats)(struct vdpa_device *vdev, u16 idx,
>>> +				   struct sk_buff *msg,
>>> +				   struct netlink_ext_ack *extack);
>>>    	struct vdpa_notification_area
>>>    	(*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
>>>    	/* vq irq is not expected to be changed once DRIVER_OK is set */
>>> @@ -466,4 +469,6 @@ struct vdpa_mgmt_dev {
>>>    int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
>>>    void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
>>> +#define VDPA_INVAL_QUEUE_INDEX 0xffff
>>> +
>>>    #endif /* _LINUX_VDPA_H */
>>> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>>> index 1061d8d2d09d..c5f229a41dc2 100644
>>> --- a/include/uapi/linux/vdpa.h
>>> +++ b/include/uapi/linux/vdpa.h
>>> @@ -18,6 +18,7 @@ enum vdpa_command {
>>>    	VDPA_CMD_DEV_DEL,
>>>    	VDPA_CMD_DEV_GET,		/* can dump */
>>>    	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
>>> +	VDPA_CMD_DEV_VSTATS_GET,
>>>    };
>>>    enum vdpa_attr {
>>> @@ -46,6 +47,12 @@ enum vdpa_attr {
>>>    	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
>>>    	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */
>>>    	VDPA_ATTR_DEV_SUPPORTED_FEATURES,	/* u64 */
>>> +
>>> +	VDPA_ATTR_DEV_QUEUE_INDEX,              /* u16 */
>>> +	VDPA_ATTR_DEV_QUEUE_TYPE,               /* string */
>>> +	VDPA_ATTR_DEV_VENDOR_ATTR_NAME,		/* string */
>>> +	VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
>>> +
>>>    	/* new attributes must be added above here */
>>>    	VDPA_ATTR_MAX,
>>>    };

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
