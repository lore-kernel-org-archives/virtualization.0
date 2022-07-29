Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13BCC00144
	for <virtualization@archiver.kernel.org>; Fri, 29 Jul 2022 20:56:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E961415D4;
	Fri, 29 Jul 2022 20:56:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5E961415D4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=y82TDaHC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=PLi6MLCE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EL0uo7Ne0Epo; Fri, 29 Jul 2022 20:56:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F16294154D;
	Fri, 29 Jul 2022 20:56:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F16294154D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E9C6C0033;
	Fri, 29 Jul 2022 20:56:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDBFFC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jul 2022 20:56:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93D0B415D4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jul 2022 20:56:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 93D0B415D4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SDYaEZAtMU-t
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jul 2022 20:55:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6ABD34154D
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6ABD34154D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jul 2022 20:55:58 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26TKEYsl031936;
 Fri, 29 Jul 2022 20:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5ilPBWmnQP77Cf16m4cEekpwTJL7AajdC5e3o78KHok=;
 b=y82TDaHCinw4AgLyOB6rM900qeBiLq7dTZJu+lpZQ1FwwQbVECel1zV/3o4ZsySemvZa
 /ZXd80SbGllq3ktMebiuYQXpkHN9T2FFsPWkL9+diKbq3WAcZoaJTerK2PaRRuQL3Fjs
 1RCSsPA8dgMsMhQzCFRVqK87egj9ocx4zL9F5UV1WU1CN00S66Yc5XB/e3qFEdrjbZbh
 NnS1CgjB7BeyQWpxfrZY94/ELgr8maYJ7QKmn+jZh6Dl46dPkYa4YT1gY39jJSnYWuv0
 2jBYEYw1O/KluutMi7hKYehLTx9R5hSItGi42vTpHIKYAZrLxNBLV6wMMS/vozMiq5lY Ew== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9ap7qgu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Jul 2022 20:55:47 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 26TK4nfZ029777; Fri, 29 Jul 2022 20:55:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3hkt7d6gxd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Jul 2022 20:55:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nn6ldDlblmai8t20gD9yPwXu59azE6bHKeThZ/V5LsXESgDaR2mZDZyTarks3LoUz7icyt/BelXcOps4mwL2usshUoyoYLqB2bsIFDAhhTnsjGuayhd7BA7+D5yxgcsH/2jQ6FHJTT9D44shJO1DDiETZKz6WRiq+V948pe09ICUvyj6dejthsVZ54WQucYPsbTfO0DwgKYKr36NLZoV1tPeCrK8tcKhjfsBwRHxvEd5BsHwbJ/FL0L6KAtOvZrNQ2fLAXDwvLCGjr3eZPs5GZQzygNHSt47if5AL6T+nhcADHX5o2BzO4V87AqpoL9M/FfWNLRA0wInYq2RExqYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ilPBWmnQP77Cf16m4cEekpwTJL7AajdC5e3o78KHok=;
 b=beww+Ubx1wT8Z9WTXOfd63qUvOfSmzwvlStG2N0I18QF7l6tIJAk2LrJWcgoLTx2RPhQbSaJ5WCSPiNFLSbkJ/KvqQeucKNbPNGCIImJ6NfkgCO5zPOW6w48VUYFypYYs5yJyY6otiZEV/0yNChXO2Ri7lsyheH+sDc/U/WUZWZulJZGE0ihLZQhgJCr1K4pyHDuYjdhmSWYbDNY/qppB5rwp4odMFHsNbJbk5sMd1nhL0M023hvGHTWdLuaQ2WRqCxr3aLPRMW1H9rRbDQnPylp1nTpXP6ZARoeB9VZcHJNAlQbv/wPF/hEd3+eAGeZ7yUnJWwiyaMIx8SMPxmmcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ilPBWmnQP77Cf16m4cEekpwTJL7AajdC5e3o78KHok=;
 b=PLi6MLCE2AekazycmIa0KHLDgXFAT2fh0gDQnmplvJVrW5uLup9Fkl7V6Zpb6FLcbSIMlT1E0AmmZhF1V2/NWuLHUqjf2DdT4/4Rpf+eml/OoRXO8ydkNV4SD14RebGdso9lg2T/exz3EKi34rNk3HA46Aq5kbgz+0P4zmGNjWg=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BLAPR10MB5124.namprd10.prod.outlook.com (2603:10b6:208:325::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Fri, 29 Jul
 2022 20:55:41 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5482.012; Fri, 29 Jul 2022
 20:55:41 +0000
Message-ID: <454bdf1b-daa1-aa67-2b8c-bc15351c1851@oracle.com>
Date: Fri, 29 Jul 2022 13:55:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 4/6] vDPA: !FEATURES_OK should not block querying
 device config space
Content-Language: en-US
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Parav Pandit <parav@nvidia.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-5-lingshan.zhu@intel.com>
 <PH0PR12MB548190DE76CC64E56DA2DF13DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <00889067-50ac-d2cd-675f-748f171e5c83@oracle.com>
 <63242254-ba84-6810-dad8-34f900b97f2f@intel.com>
 <8002554a-a77c-7b25-8f99-8d68248a741d@oracle.com>
 <00e2e07e-1a2e-7af8-a060-cc9034e0d33f@intel.com>
 <b58dba25-3258-d600-ea06-879094639852@oracle.com>
 <c143e2da-208e-b046-9b8f-1780f75ed3e6@intel.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <c143e2da-208e-b046-9b8f-1780f75ed3e6@intel.com>
X-ClientProxiedBy: SJ0PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::23) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e58a94c-444b-4037-73aa-08da71a4b2a9
X-MS-TrafficTypeDiagnostic: BLAPR10MB5124:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fIPrp/m/mZjLWnFPa7BWDg/aC1P8o+Gtjf5korQVrhvhRbGsPGe4GAApo0UA+oG+B3MlHMmzR0QpfiemkhlK3TPu23CMqtNrxnI6s/K1Sz17bYnHh3PAmobelah67BAQLxYZ+bYuuNzsSfl+Ku2dAnBUf42vxhi4HZUNr1YupzW3mYHrw8x7CreqIQGBPAC8E7D4tuCRwlWHRe69xzWvXEj323F6lXj4TqdqGGqYJccUjjUBGITCysCaj+bClqVnLOX8P4Ox93QOCkR9fCdXm5Tn25RP+5lIqHaboIqKW9nbobuZhK6p37IisTcQcsJTHbdxuZvn75ONi+TSXJHwIAAnK6LS3RO4mB0FBtdmcGA2anH2QBvE6KuthYD7tYQoiUcv3sieJnrjs6jZaAdaMCkDB35fiiZV+xPu7sw22wDZ+4UmrTFODyaDBY4ktIE+bjvll5oGZED+WwI2dER1hxbWXQj8kKvLi9/IjgMunl04RGInZF5BKEDQuyb/w49MnLaialcb2ZTUq7sfMeynE1LmXLN66zODS5k3wGjB8oo5h4Jhv9gHNO4AKN4BgFy9BbHHKCVoN/vQyWEeqWqtexjkq6562sovsWY9HS+H2lPaXzjolME4GCPHzifTRPC6x9s9TblgHxt2A94Ds8MGF6akb6zOOveeR27j2rCMYm/7Yyc5xDMWcRSlig5F9HUt/ixKQSJAW/Apk53S8x57H5niL9HQJKCuns0E3FNE9fjWx+HZFkxKsNvhe1REmhvbe5YoTgDniL0xaL/HpOezYq+hHzKW6+hlc8RDg8zyhDoG6XM52yvmiHUFyMo7SQZ0owLDzTBsz1/M/x+vPqQ7E41tyGs1XAcj4xGjZmKvCgw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(376002)(346002)(136003)(39860400002)(396003)(31696002)(36916002)(2616005)(30864003)(2906002)(6506007)(26005)(6512007)(53546011)(6666004)(186003)(31686004)(41300700001)(8676002)(66556008)(5660300002)(66946007)(66476007)(38100700002)(83380400001)(86362001)(36756003)(966005)(8936002)(4326008)(6486002)(54906003)(478600001)(110136005)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWsxRUNxcHJnblN4TGxJY0tDanVTdXZReEhXZ1VvRWxmUmNkVHVSWHFrSDFJ?=
 =?utf-8?B?MW9yRDZURjBENUZPOHR6RHhReCtPMDNPMGlaU1daM3daRmtoK1VjNGdscVJa?=
 =?utf-8?B?cHdTd1BFTjdmcGpscE44QWpPS0s0bGs4WWgwa1N2TFFHVkZneFRWc0JFQTZJ?=
 =?utf-8?B?ME5UbHg2WmRheWdicS96S0ZNUVpidExDM013b0JZRFJPblNZZVp5dFhUNU1Q?=
 =?utf-8?B?WGFqbDVtZVVZNllGSEFRZ0hmWG0rRnUyNmZZWUZZK0cwaTJwenhTREFSbnZh?=
 =?utf-8?B?ZEcxNG0vdllPQ0tKS1pCWE5ZQ2pOV0tQQURtdjZMWktlaVJ2cTMycDEwbkha?=
 =?utf-8?B?TGM1ZFYrT0ZZVnpXV3V3SCtzbXJMRjhLeGdzMENIMTB0YitxcUNnZDJMTzVl?=
 =?utf-8?B?TDVlSHhDb01wSkJ5TU5oZzM4TDBSY2NDd2NzcWo1Qmxhenc3VkhSdFgrTmJB?=
 =?utf-8?B?SzNiU2w2T2xROUpYQWtPNTlNQUlpYnRnanBTY3JOVEIwNFdOZDJDTThwbDkx?=
 =?utf-8?B?cHJVU0FtbHBWUjh6RExXbjJNeGpiRUVmQlp3VEVIdHRYVXlzNmlJSFBGNnVB?=
 =?utf-8?B?SCtvd3k4ZWozZ2ZUczRyb0F0eUNFYlQvVlQ2cGxiazVTRmtNL3VlVTVzdEhk?=
 =?utf-8?B?MkhuZTNBbm9GSGRPSUJORE1SVmFya3MrRzd6VjhWRFdUbmZRanROSVNlQlVO?=
 =?utf-8?B?T2tQUWZRVFpXSXpucVJ1eGRIVEVZK00vZkd0Z1pqWVo5UHVZYVFBUUR2TTla?=
 =?utf-8?B?UStwWk9reUtkMlFJVDJrVTdmWnkyY2Y1RWp1dU5VZ1cxbnhicDFtclBDcDJU?=
 =?utf-8?B?R25IOFQ0RzlzbXJINTZKdnZmcnQyNkJlczkydXVOemlpY1NBejh5UVNyK29M?=
 =?utf-8?B?QzNlQ1QzWFJTckpUbTc2d3NielBGYjdQUVhxWTQ1VkQvb0svSWhSTVdqMXFQ?=
 =?utf-8?B?YWFOVXhjdE8yNUtXQjJsN3Y4RHp1bUZPZXdFdmR5aU9UbG5aUHVBNkVJdUdj?=
 =?utf-8?B?YlNGY3pTR21XY0VHL3pwODkzSVloaURZRDJBTU5SN3BSc3lwdmRROGlpZVZ0?=
 =?utf-8?B?ZUp4QXpsMnIyb0d1aVhiM1BPQlFGNGdkRHluTzJybDhQdEhzUCtUbUp4TnI4?=
 =?utf-8?B?Q0pPYmprSk82RWpLN01PK0FmcUFYMjh1bVBCTjFlWWIwRjNUMDNIeWJ4Q2FB?=
 =?utf-8?B?YVlpRnZ3S1cxVEQ1WWRGU094Y3FOWFBlbjZ2K0tqZkFGSG9Cb2J4SC9SZVlQ?=
 =?utf-8?B?QlJmdW92MzZGdDlLcDdBY3ZHZ1N1SEpTT1JVVG5LcThzU3BHQk81S3I3S3hn?=
 =?utf-8?B?QnpUS3MrOVFwZElqUTVGdWpRZzlsYjAvWlRqRDFicGNSSldVN2V3aHpweUND?=
 =?utf-8?B?TUlTRGxqZndEWVNjUDJPRGFibDNra05LSEMzcFBXRGVuOGR6QUNKOVZyb3o1?=
 =?utf-8?B?dmZNWEY0dkZMQ1FhamQ5WENYZ0JNSWRSRHRMVG80YzNmRHR4T0g3YmNvYjMz?=
 =?utf-8?B?N252WGpRSmx0YVZVSjRMSENCUGtqRVoyZkRFc2wxeHR4S1kwckt5L1FzQmEw?=
 =?utf-8?B?MWgyOUlGYy9sb0syTmppb0Z2TWw2Z0RhMjlpNmJTRmJCMCtPMjY2eC9PaTN6?=
 =?utf-8?B?SWs1ZDhLdWdqWjhwdzBzSjRET1BYRUxoUWJYcmhqTWJWNHI0N2FzYzFlUjFN?=
 =?utf-8?B?S2MzZGpRb3RRb2pRaUg5dEc4V2g4NGU4bG9zdFJQbUduc0pTSjZOZjRuTUhP?=
 =?utf-8?B?TEJSRFF1VjI0cnZtYkV2MldCUUhlMTBsc0lOcmkxbkdVOWlFaVF4YUNZanNq?=
 =?utf-8?B?RDQ4Z0lKZ1VPQ3cwbFVSeFFHdU9xZkZjS0J2SitNWEZ1Z3RyZFdhakdwRXY0?=
 =?utf-8?B?NjFLRTZ0UDk5cjliOFZDeFFjaGlQb2NMUFoxbW13TEFwUzBmYnJWWnRzUjd6?=
 =?utf-8?B?Z0NmT2ExcHJMZ0FKa2RtOENNcGFOWEliSFYxT0pvL2hPWTFFRXcxSHB6Zzhh?=
 =?utf-8?B?amkxMXFYeW1vR004d1daS2xzejRod1RmZFl1bk5xVEdZek1lZWhMSkpvRVVt?=
 =?utf-8?B?NElJaG5yZkFvb1d0aWxPd0pLM0VjQXZBSXc5N1Q2Ky8ybS8yVGNobEdaZFp2?=
 =?utf-8?Q?GvihbIEBJpAPiQwLzTXHM0WbN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e58a94c-444b-4037-73aa-08da71a4b2a9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 20:55:41.3465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epi0CajTVg+7CSdEpawDAKfMF4yBr1Q/chIvm7QIKWuob1QHjWcZJxGvB5WXxPvq00mXNvG/tG+iP0Cd7bX8xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_19,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207290086
X-Proofpoint-ORIG-GUID: F16wQUXNeP87bxeIkv9zeyYNPC21uCQh
X-Proofpoint-GUID: F16wQUXNeP87bxeIkv9zeyYNPC21uCQh
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>
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

CgpPbiA3LzI4LzIwMjIgNzowNCBQTSwgWmh1LCBMaW5nc2hhbiB3cm90ZToKPgo+Cj4gT24gNy8y
OS8yMDIyIDU6NDggQU0sIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDcvMjcvMjAyMiA3
OjQzIFBNLCBaaHUsIExpbmdzaGFuIHdyb3RlOgo+Pj4KPj4+Cj4+PiBPbiA3LzI4LzIwMjIgODo1
NiBBTSwgU2ktV2VpIExpdSB3cm90ZToKPj4+Pgo+Pj4+Cj4+Pj4gT24gNy8yNy8yMDIyIDQ6NDcg
QU0sIFpodSwgTGluZ3NoYW4gd3JvdGU6Cj4+Pj4+Cj4+Pj4+Cj4+Pj4+IE9uIDcvMjcvMjAyMiA1
OjQzIFBNLCBTaS1XZWkgTGl1IHdyb3RlOgo+Pj4+Pj4gU29ycnkgdG8gY2hpbWUgaW4gbGF0ZSBp
biB0aGUgZ2FtZS4gRm9yIHNvbWUgcmVhc29uIEkgY291bGRuJ3QgCj4+Pj4+PiBnZXQgdG8gbW9z
dCBlbWFpbHMgZm9yIHRoaXMgZGlzY3Vzc2lvbiAoSSBvbmx5IHN1YnNjcmliZWQgdG8gdGhlIAo+
Pj4+Pj4gdmlydHVhbGl6YXRpb24gbGlzdCksIHdoaWxlIEkgd2FzIHRha2luZyBvZmYgYW1vbmdz
dCB0aGUgcGFzdCBmZXcgCj4+Pj4+PiB3ZWVrcy4KPj4+Pj4+Cj4+Pj4+PiBJdCBsb29rcyB0byBt
ZSB0aGlzIHBhdGNoIGlzIGluY29tcGxldGUuIE5vdGVkIGRvd24gdGhlIHdheSBpbiAKPj4+Pj4+
IHZkcGFfZGV2X25ldF9jb25maWdfZmlsbCgpLCB3ZSBoYXZlIHRoZSBmb2xsb3dpbmc6Cj4+Pj4+
PiAgICAgICAgICBmZWF0dXJlcyA9IHZkZXYtPmNvbmZpZy0+Z2V0X2RyaXZlcl9mZWF0dXJlcyh2
ZGV2KTsKPj4+Pj4+ICAgICAgICAgIGlmIChubGFfcHV0X3U2NF82NGJpdChtc2csIFZEUEFfQVRU
Ul9ERVZfTkVHT1RJQVRFRF9GRUFUVVJFUywgZmVhdHVyZXMsCj4+Pj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgVkRQQV9BVFRSX1BBRCkpCj4+Pj4+PiAgICAgICAgICAgICAgICAg
IHJldHVybiAtRU1TR1NJWkU7Cj4+Pj4+Pgo+Pj4+Pj4gTWFraW5nIGNhbGwgdG8gLmdldF9kcml2
ZXJfZmVhdHVyZXMoKSBkb2Vzbid0IG1ha2Ugc2Vuc2Ugd2hlbiAKPj4+Pj4+IGZlYXR1cmUgbmVn
b3RpYXRpb24gaXNuJ3QgY29tcGxldGUuIE5laXRoZXIgc2hvdWxkIHByZXNlbnQgCj4+Pj4+PiBu
ZWdvdGlhdGVkX2ZlYXR1cmVzIHRvIHVzZXJzcGFjZSBiZWZvcmUgbmVnb3RpYXRpb24gaXMgZG9u
ZS4KPj4+Pj4+Cj4+Pj4+PiBTaW1pbGFybHksIG1heF92cXAgdGhyb3VnaCB2ZHBhX2Rldl9uZXRf
bXFfY29uZmlnX2ZpbGwoKSBwcm9iYWJseSAKPj4+Pj4+IHNob3VsZCBub3Qgc2hvdyBiZWZvcmUg
bmVnb3RpYXRpb24gaXMgZG9uZSAtIGl0IGRlcGVuZHMgb24gZHJpdmVyIAo+Pj4+Pj4gZmVhdHVy
ZXMgbmVnb3RpYXRlZC4KPj4+Pj4gSSBoYXZlIGFub3RoZXIgcGF0Y2ggaW4gdGhpcyBzZXJpZXMg
aW50cm9kdWNlcyBkZXZpY2VfZmVhdHVyZXMgYW5kIAo+Pj4+PiB3aWxsIHJlcG9ydCBkZXZpY2Vf
ZmVhdHVyZXMgdG8gdGhlIHVzZXJzcGFjZSBldmVuIGZlYXR1cmVzIAo+Pj4+PiBuZWdvdGlhdGlv
biBub3QgZG9uZS4gQmVjYXVzZSB0aGUgc3BlYyBzYXlzIHdlIHNob3VsZCBhbGxvdyBkcml2ZXIg
Cj4+Pj4+IGFjY2VzcyB0aGUgY29uZmlnIHNwYWNlIGJlZm9yZSBGRUFUVVJFU19PSy4KPj4+PiBU
aGUgY29uZmlnIHNwYWNlIGNhbiBiZSBhY2Nlc3NlZCBieSBndWVzdCBiZWZvcmUgZmVhdHVyZXNf
b2sgCj4+Pj4gZG9lc24ndCBuZWNlc3NhcmlseSBtZWFuIHRoZSB2YWx1ZSBpcyB2YWxpZC4gWW91
IG1heSB3YW50IHRvIGRvdWJsZSAKPj4+PiBjaGVjayB3aXRoIE1pY2hhZWwgZm9yIHdoYXQgaGUg
cXVvdGVkIGVhcmxpZXI6Cj4+PiB0aGF0J3Mgd2h5IEkgcHJvcG9zZWQgdG8gZml4IHRoZXNlIGlz
c3VlcywgZS5nLiwgaWYgbm8gX0ZfTUFDLCB2RFBBIAo+Pj4ga2VybmVsIHNob3VsZCBub3QgcmV0
dXJuIGEgbWFjIHRvIHRoZSB1c2Vyc3BhY2UsIHRoZXJlIGlzIG5vdCBhIAo+Pj4gZGVmYXVsdCB2
YWx1ZSBmb3IgbWFjLgo+PiBUaGVuIHBsZWFzZSBzaG93IHVzIHRoZSBjb2RlLCBhcyBJIGNhbiBv
bmx5IGNvbW1lbnQgYmFzZWQgb24geW91ciAKPj4gbGF0ZXN0ICh2NCkgcGF0Y2ggYW5kIGl0IHdh
cyBub3QgdGhlcmUuLiBUbyBiZSBob25lc3QsIEkgZG9uJ3QgCj4+IHVuZGVyc3RhbmQgdGhlIG1v
dGl2YXRpb24gYW5kIHRoZSB1c2UgY2FzZXMgeW91IGhhdmUsIGlzIGl0IGZvciAKPj4gZGVidWdn
aW5nL21vbml0b3Jpbmcgb3IgdGhlcmUncyByZWFsbHkgYSB1c2UgY2FzZSBmb3IgbGl2ZSBtaWdy
YXRpb24/IAo+PiBGb3IgdGhlIGZvcm1lciwgeW91IGNhbiBkbyBhIGRpcmVjdCBkdW1wIG9uIGFs
bCBjb25maWcgc3BhY2UgZmllbGRzIAo+PiByZWdhcmRsZXNzIG9mIGVuZGlhbmVzcyBhbmQgZmVh
dHVyZSBuZWdvdGlhdGlvbiB3aXRob3V0IGhhdmluZyB0byAKPj4gd29ycnkgYWJvdXQgdmFsaWRp
dHkgKG1lYW5pbmdmdWwgdG8gcHJlc2VudCB0byBhZG1pbiB1c2VyKS4gVG8gbWUgCj4+IHRoZXNl
IGFyZSBjb25mbGljdCBhc2tzIHRoYXQgaXMgaW1wb3NzaWJsZSB0byBtaXggaW4gZXhhY3Qgb25l
IGNvbW1hbmQuCj4gVGhpcyBidWcganVzdCBoYXMgYmVlbiByZXZlYWxlZCB0d28gZGF5cywgYW5k
IHlvdSB3aWxsIHNlZSB0aGUgcGF0Y2ggc29vbi4KPgo+IFRoZXJlIGFyZSBzb21ldGhpbmcgdG8g
Y2xhcmlmeToKPiAxKSB3ZSBuZWVkIHRvIHJlYWQgdGhlIGRldmljZSBmZWF0dXJlcywgb3IgaG93
IGNhbiB5b3UgcGljayBhIHByb3BlciAKPiBMTSBkZXN0aW5hdGlvbgo+IDIpIHZkcGEgZGV2IGNv
bmZpZyBzaG93IGNhbiBzaG93IGJvdGggZGV2aWNlIGZlYXR1cmVzIGFuZCBkcml2ZXIgCj4gZmVh
dHVyZXMsIHRoZXJlIGp1c3QgbmVlZCBhIHBhdGNoIGZvciBpcHJvdXRlMgo+IDMpIFRvIHByb2Nl
c3MgaW5mb3JtYXRpb24gbGlrZSBNUSwgd2UgZG9uJ3QganVzdCBkdW1wIHRoZSBjb25maWcgCj4g
c3BhY2UsIE1TVCBoYXMgZXhwbGFpbmVkIGJlZm9yZQpTbywgaXQncyBmb3IgbGl2ZSBtaWdyYXRp
b24uLi4gVGhlbiB3aHkgbm90IGV4cG9ydCB0aG9zZSBjb25maWcgCnBhcmFtZXRlcnMgc3BlY2lm
aWVkIGZvciB2ZHBhIGNyZWF0aW9uIChhcyB3ZWxsIGFzIGRldmljZSBmZWF0dXJlIGJpdHMpIAp0
byB0aGUgb3V0cHV0IG9mICJ2ZHBhIGRldiBzaG93IiBjb21tYW5kPyBUaGF0J3Mgd2hlcmUgZGV2
aWNlIHNpZGUgCmNvbmZpZyBsaXZlcyBhbmQgaXMgc3RhdGljIGFjcm9zcyB2ZHBhJ3MgbGlmZSBj
eWNsZS4gInZkcGEgZGV2IGNvbmZpZyAKc2hvdyIgaXMgbW9zdGx5IGZvciBkeW5hbWljIGRyaXZl
ciBzaWRlIGNvbmZpZywgYW5kIHRoZSB2YWxpZGl0eSBpcyAKc3ViamVjdCB0byBmZWF0dXJlIG5l
Z290aWF0aW9uLiBJIHN1cHBvc2UgdGhpcyBzaG91bGQgc3VpdCB5b3VyIG5lZWQgb2YgCkxNLCBl
LmcuCgokIHZkcGEgZGV2IGFkZCBuYW1lIHZkcGExIG1nbXRkZXYgcGNpLzAwMDA6NDE6MDQuMiBt
YXhfdnFwIDcgbXR1IDIwMDAKJCB2ZHBhIGRldiBzaG93IHZkcGExCnZkcGExOiB0eXBlIG5ldHdv
cmsgbWdtdGRldiBwY2kvMDAwMDo0MTowNC4yIHZlbmRvcl9pZCA1NTU1IG1heF92cXMgMTUgCm1h
eF92cV9zaXplIDI1NgogwqAgbWF4X3ZxcCA3IG10dSAyMDAwCiDCoCBkZXZfZmVhdHVyZXMgQ1NV
TSBHVUVTVF9DU1VNIE1UVSBIT1NUX1RTTzQgSE9TVF9UU082IFNUQVRVUyBDVFJMX1ZRIApNUSBD
VFJMX01BQ19BRERSIFZFUlNJT05fMSBSSU5HX1BBQ0tFRAoKRm9yIGl0IHRvIHdvcmssIHlvdSdk
IHdhbnQgdG8gcGFzcyAic3RydWN0IHZkcGFfZGV2X3NldF9jb25maWciIHRvIApfdmRwYV9yZWdp
c3Rlcl9kZXZpY2UoKSBkdXJpbmcgcmVnaXN0cmF0aW9uLCBhbmQgZ2V0IGl0IHNhdmVkIHRoZXJl
IGluIAoic3RydWN0IHZkcGFfZGV2aWNlIi4gVGhlbiBpbiB2ZHBhX2Rldl9maWxsKCkgc2hvdyBl
YWNoIGZpZWxkIApjb25kaXRpb25hbGx5IHN1YmplY3QgdG8gInN0cnVjdCB2ZHBhX2Rldl9zZXRf
Y29uZmlnLm1hc2siLgoKVGhhbmtzLAotU2l3ZWkKPgo+IFRoYW5rcwo+IFpodSBMaW5nc2hhbgo+
Pgo+Pj4+PiBOb3BlOgo+Pj4+Pgo+Pj4+PiAyLjUuMSAgRHJpdmVyIFJlcXVpcmVtZW50czogRGV2
aWNlIENvbmZpZ3VyYXRpb24gU3BhY2UKPj4+Pj4KPj4+Pj4gLi4uCj4+Pj4+Cj4+Pj4+IEZvciBv
cHRpb25hbCBjb25maWd1cmF0aW9uIHNwYWNlIGZpZWxkcywgdGhlIGRyaXZlciBNVVNUIGNoZWNr
IHRoYXQgdGhlIGNvcnJlc3BvbmRpbmcgZmVhdHVyZSBpcyBvZmZlcmVkCj4+Pj4+IGJlZm9yZSBh
Y2Nlc3NpbmcgdGhhdCBwYXJ0IG9mIHRoZSBjb25maWd1cmF0aW9uIHNwYWNlLgo+Pj4+Cj4+Pj4g
YW5kIGhvdyBtYW55IGRyaXZlciBidWdzIHRha2luZyB3cm9uZyBhc3N1bXB0aW9uIG9mIHRoZSB2
YWxpZGl0eSBvZiAKPj4+PiBjb25maWcgc3BhY2UgZmllbGQgd2l0aG91dCBmZWF0dXJlc19vay4g
SSBhbSBub3Qgc3VyZSB3aGF0IHVzZSBjYXNlIAo+Pj4+IHlvdSB3YW50IHRvIGV4cG9zZSBjb25m
aWcgcmVzaXN0ZXIgdmFsdWVzIGZvciBiZWZvcmUgZmVhdHVyZXNfb2ssIAo+Pj4+IGlmIGl0J3Mg
bW9zdGx5IGZvciBsaXZlIG1pZ3JhdGlvbiBJIGd1ZXNzIGl0J3MgcHJvYmFibHkgaGVhZGluZyBh
IAo+Pj4+IHdyb25nIGRpcmVjdGlvbi4KPj4+Pgo+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IExh
c3QgYnV0IG5vdCB0aGUgbGVhc3QsIHRoaXMgInZkcGEgZGV2IGNvbmZpZyIgY29tbWFuZCB3YXMg
bm90IAo+Pj4+Pj4gZGVzaWduZWQgdG8gZGlzcGxheSB0aGUgcmVhbCBjb25maWcgc3BhY2UgcmVn
aXN0ZXIgdmFsdWVzIGluIHRoZSAKPj4+Pj4+IGZpcnN0IHBsYWNlLiBRdW90aW5nIHRoZSB2ZHBh
LWRldig4KSBtYW4gcGFnZToKPj4+Pj4+Cj4+Pj4+Pj4gdmRwYSBkZXYgY29uZmlnIHNob3cgLSBT
aG93IGNvbmZpZ3VyYXRpb24gb2Ygc3BlY2lmaWMgZGV2aWNlIG9yIAo+Pj4+Pj4+IGFsbCBkZXZp
Y2VzLgo+Pj4+Pj4+IERFViAtIHNwZWNpZmllcyB0aGUgdmRwYSBkZXZpY2UgdG8gc2hvdyBpdHMg
Y29uZmlndXJhdGlvbi4gSWYgCj4+Pj4+Pj4gdGhpcyBhcmd1bWVudCBpcyBvbWl0dGVkIGFsbCBk
ZXZpY2VzIGNvbmZpZ3VyYXRpb24gaXMgbGlzdGVkLgo+Pj4+Pj4gSXQgZG9lc24ndCBzYXkgYW55
dGhpbmcgYWJvdXQgY29uZmlndXJhdGlvbiBzcGFjZSBvciByZWdpc3RlciAKPj4+Pj4+IHZhbHVl
cyBpbiBjb25maWcgc3BhY2UuIEFzIGxvbmcgYXMgaXQgY2FuIGNvbnZleSB0aGUgY29uZmlnIAo+
Pj4+Pj4gYXR0cmlidXRlIHdoZW4gaW5zdGFudGlhdGluZyB2RFBBIGRldmljZSBpbnN0YW5jZSwg
YW5kIG1vcmUgCj4+Pj4+PiBpbXBvcnRhbnRseSwgdGhlIGNvbmZpZyBjYW4gYmUgZWFzaWx5IGlt
cG9ydGVkIGZyb20gb3IgZXhwb3J0ZWQgCj4+Pj4+PiB0byB1c2Vyc3BhY2UgdG9vbHMgd2hlbiB0
cnlpbmcgdG8gcmVjb25zdHJ1Y3QgdmRwYSBpbnN0YW5jZSAKPj4+Pj4+IGludGFjdCBvbiBkZXN0
aW5hdGlvbiBob3N0IGZvciBsaXZlIG1pZ3JhdGlvbiwgSU1ITyBpbiBteSAKPj4+Pj4+IHBlcnNv
bmFsIGludGVycHJldGF0aW9uIGl0IGRvZXNuJ3QgbWF0dGVyIHdoYXQgdGhlIGNvbmZpZyBzcGFj
ZSAKPj4+Pj4+IG1heSBwcmVzZW50LiBJdCBtYXkgYmUgd29ydGggd2hpbGUgYWRkaW5nIGEgbmV3
IGRlYnVnIGNvbW1hbmQgdG8gCj4+Pj4+PiBleHBvc2UgdGhlIHJlYWwgcmVnaXN0ZXIgdmFsdWUs
IGJ1dCB0aGF0J3MgYW5vdGhlciBzdG9yeS4KPj4+Pj4gSSBhbSBub3Qgc3VyZSBnZXR0aW5nIHlv
dXIgcG9pbnRzLiB2RFBBIG5vdyByZXBvcnRzIGRldmljZSBmZWF0dXJlIAo+Pj4+PiBiaXRzKGRl
dmljZV9mZWF0dXJlcykgYW5kIG5lZ290aWF0ZWQgZmVhdHVyZSAKPj4+Pj4gYml0cyhkcml2ZXJf
ZmVhdHVyZXMpLCBhbmQgeWVzLCB0aGUgZHJpdmVycyBmZWF0dXJlcyBjYW4gYmUgYSAKPj4+Pj4g
c3Vic2V0IG9mIHRoZSBkZXZpY2UgZmVhdHVyZXM7IGFuZCB0aGUgdkRQQSBkZXZpY2UgZmVhdHVy
ZXMgY2FuIGJlIAo+Pj4+PiBhIHN1YnNldCBvZiB0aGUgbWFuYWdlbWVudCBkZXZpY2UgZmVhdHVy
ZXMuCj4+Pj4gV2hhdCBJIHNhaWQgaXMgYWZ0ZXIgdW5ibG9ja2luZyB0aGUgY29uZGl0aW9uYWwg
Y2hlY2ssIHlvdSdkIGhhdmUgCj4+Pj4gdG8gaGFuZGxlIHRoZSBjYXNlIGZvciBlYWNoIG9mIHRo
ZSB2ZHBhIGF0dHJpYnV0ZSB3aGVuIGZlYXR1cmUgCj4+Pj4gbmVnb3RpYXRpb24gaXMgbm90IHll
dCBkb25lOiBiYXNpY2FsbHkgdGhlIHJlZ2lzdGVyIHZhbHVlcyB5b3UgZ290IAo+Pj4+IGZyb20g
Y29uZmlnIHNwYWNlIHZpYSB0aGUgdmRwYV9nZXRfY29uZmlnX3VubG9ja2VkKCkgY2FsbCBpcyBu
b3QgCj4+Pj4gY29uc2lkZXJlZCB0byBiZSB2YWxpZCBiZWZvcmUgZmVhdHVyZXNfb2sgKHBlci1z
cGVjKS4gQWx0aG91Z2ggaW4gCj4+Pj4gc29tZSBjYXNlIHlvdSBtYXkgZ2V0IHNhbmUgdmFsdWUs
IHN1Y2ggYmVoYXZpb3IgaXMgZ2VuZXJhbGx5IAo+Pj4+IHVuZGVmaW5lZC4gSWYgeW91IGRlc2ly
ZSB0byBzaG93IGp1c3QgdGhlIGRldmljZV9mZWF0dXJlcyBhbG9uZSAKPj4+PiB3aXRob3V0IGFu
eSBjb25maWcgc3BhY2UgZmllbGQsIHdoaWNoIHRoZSBkZXZpY2UgaGFkIGFkdmVydGlzZWQgCj4+
Pj4gKmJlZm9yZSBmZWF0dXJlIG5lZ290aWF0aW9uIGlzIGNvbXBsZXRlKiwgdGhhdCdsbCBiZSBm
aW5lLiBCdXQgCj4+Pj4gbG9va3MgdG8gbWUgdGhpcyBpcyBub3QgaG93IHBhdGNoIGhhcyBiZWVu
IGltcGxlbWVudGVkLiBQcm9iYWJseSAKPj4+PiBuZWVkIHNvbWUgbW9yZSB3b3JrPwo+Pj4gVGhl
eSBhcmUgZHJpdmVyX2ZlYXR1cmVzKG5lZ290aWF0ZWQpIGFuZCB0aGUgZGV2aWNlX2ZlYXR1cmVz
KHdoaWNoIAo+Pj4gY29tZXMgd2l0aCB0aGUgZGV2aWNlKSwgYW5kIHRoZSBjb25maWcgc3BhY2Ug
ZmllbGRzIHRoYXQgZGVwZW5kIG9uIAo+Pj4gdGhlbS4gSW4gdGhpcyBzZXJpZXMsIHdlIHJlcG9y
dCBib3RoIHRvIHRoZSB1c2Vyc3BhY2UuCj4+IEkgZmFpbCB0byB1bmRlcnN0YW5kIHdoYXQgeW91
IHdhbnQgdG8gcHJlc2VudCBmcm9tIHlvdXIgZGVzY3JpcHRpb24uIAo+PiBNYXkgYmUgd29ydGgg
c2hvd2luZyBzb21lIGV4YW1wbGUgb3V0cHV0cyB0aGF0IGF0IGxlYXN0IGluY2x1ZGUgdGhlIAo+
PiBmb2xsb3dpbmcgY2FzZXM6IDEpIHdoZW4gZGV2aWNlIG9mZmVycyBmZWF0dXJlcyBidXQgbm90
IHlldCAKPj4gYWNrbm93bGVkZ2UgYnkgZ3Vlc3QgMikgd2hlbiBndWVzdCBhY2tub3dsZWRnZWQg
ZmVhdHVyZXMgYW5kIGRldmljZSAKPj4gaXMgeWV0IHRvIGFjY2VwdCAzKSBhZnRlciBndWVzdCBm
ZWF0dXJlIG5lZ290aWF0aW9uIGlzIGNvbXBsZXRlZCAKPj4gKGFncmVlZCB1cG9uIGJldHdlZW4g
Z3Vlc3QgYW5kIGRldmljZSkuCj4gT25seSB0d28gZmVhdHVyZSBzZXRzOiAxKSB3aGF0IHRoZSBk
ZXZpY2UgaGFzLiAoMikgd2hhdCBpcyBuZWdvdGlhdGVkCj4+Cj4+IFRoYW5rcywKPj4gLVNpd2Vp
Cj4+Pj4KPj4+PiBSZWdhcmRzLAo+Pj4+IC1TaXdlaQo+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4gSGF2aW5n
IHNhaWQsIHBsZWFzZSBjb25zaWRlciB0byBkcm9wIHRoZSBGaXhlcyB0YWcsIGFzIGFwcGVhcnMg
dG8gCj4+Pj4+PiBtZSB5b3UncmUgcHJvcG9zaW5nIGEgbmV3IGZlYXR1cmUgcmF0aGVyIHRoYW4g
Zml4aW5nIGEgcmVhbCBpc3N1ZS4KPj4+Pj4gaXQncyBhIG5ldyBmZWF0dXJlIHRvIHJlcG9ydCB0
aGUgZGV2aWNlIGZlYXR1cmUgYml0cyB0aGFuIG9ubHkgCj4+Pj4+IG5lZ290aWF0ZWQgZmVhdHVy
ZXMsIGhvd2V2ZXIgdGhpcyBwYXRjaCBpcyBhIG11c3QsIG9yIGl0IHdpbGwgCj4+Pj4+IGJsb2Nr
IHRoZSBkZXZpY2UgZmVhdHVyZSBiaXRzIHJlcG9ydGluZy4gYnV0IEkgYWdyZWUsIHRoZSBmaXgg
dGFnIAo+Pj4+PiBpcyBub3QgYSBtdXN0Lgo+Pj4+Pj4KPj4+Pj4+IFRoYW5rcywKPj4+Pj4+IC1T
aXdlaQo+Pj4+Pj4KPj4+Pj4+IE9uIDcvMS8yMDIyIDM6MTIgUE0sIFBhcmF2IFBhbmRpdCB2aWEg
VmlydHVhbGl6YXRpb24gd3JvdGU6Cj4+Pj4+Pj4+IEZyb206IFpodSBMaW5nc2hhbjxsaW5nc2hh
bi56aHVAaW50ZWwuY29tPgo+Pj4+Pj4+PiBTZW50OiBGcmlkYXksIEp1bHkgMSwgMjAyMiA5OjI4
IEFNCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IFVzZXJzIG1heSB3YW50IHRvIHF1ZXJ5IHRoZSBjb25maWcg
c3BhY2Ugb2YgYSB2RFBBIGRldmljZSwgdG8gY2hvb3NlIGEKPj4+Pj4+Pj4gYXBwcm9wcmlhdGUg
b25lIGZvciBhIGNlcnRhaW4gZ3Vlc3QuIFRoaXMgbWVhbnMgdGhlIHVzZXJzIG5lZWQgdG8gcmVh
ZCB0aGUKPj4+Pj4+Pj4gY29uZmlnIHNwYWNlIGJlZm9yZSBGRUFUVVJFU19PSywgYW5kIHRoZSBl
eGlzdGVuY2Ugb2YgY29uZmlnIHNwYWNlCj4+Pj4+Pj4+IGNvbnRlbnRzIGRvZXMgbm90IGRlcGVu
ZCBvbiBGRUFUVVJFU19PSy4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gVGhlIHNwZWMgc2F5czoKPj4+Pj4+
Pj4gVGhlIGRldmljZSBNVVNUIGFsbG93IHJlYWRpbmcgb2YgYW55IGRldmljZS1zcGVjaWZpYyBj
b25maWd1cmF0aW9uIGZpZWxkCj4+Pj4+Pj4+IGJlZm9yZSBGRUFUVVJFU19PSyBpcyBzZXQgYnkg
dGhlIGRyaXZlci4gVGhpcyBpbmNsdWRlcyBmaWVsZHMgd2hpY2ggYXJlCj4+Pj4+Pj4+IGNvbmRp
dGlvbmFsIG9uIGZlYXR1cmUgYml0cywgYXMgbG9uZyBhcyB0aG9zZSBmZWF0dXJlIGJpdHMgYXJl
IG9mZmVyZWQgYnkgdGhlCj4+Pj4+Pj4+IGRldmljZS4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gRml4ZXM6
IDMwZWY3YThhYzhhMDcgKHZkcGE6IFJlYWQgZGV2aWNlIGNvbmZpZ3VyYXRpb24gb25seSBpZiBG
RUFUVVJFU19PSykKPj4+Pj4+PiBGaXggaXMgZmluZSwgYnV0IGZpeGVzIHRhZyBuZWVkcyBjb3Jy
ZWN0aW9uIGRlc2NyaWJlZCBiZWxvdy4KPj4+Pj4+Pgo+Pj4+Pj4+IEFib3ZlIGNvbW1pdCBpZCBp
cyAxMyBsZXR0ZXJzIHNob3VsZCBiZSAxMi4KPj4+Pj4+PiBBbmQKPj4+Pj4+PiBJdCBzaG91bGQg
YmUgaW4gZm9ybWF0Cj4+Pj4+Pj4gRml4ZXM6IDMwZWY3YThhYzhhMCAoInZkcGE6IFJlYWQgZGV2
aWNlIGNvbmZpZ3VyYXRpb24gb25seSBpZiBGRUFUVVJFU19PSyIpCj4+Pj4+Pj4KPj4+Pj4+PiBQ
bGVhc2UgdXNlIGNoZWNrcGF0Y2gucGwgc2NyaXB0IGJlZm9yZSBwb3N0aW5nIHRoZSBwYXRjaGVz
IHRvIGNhdGNoIHRoZXNlIGVycm9ycy4KPj4+Pj4+PiBUaGVyZSBpcyBhIGJvdCB0aGF0IGxvb2tz
IGF0IHRoZSBmaXhlcyB0YWcgYW5kIGlkZW50aWZpZXMgdGhlIHJpZ2h0IGtlcm5lbCB2ZXJzaW9u
IHRvIGFwcGx5IHRoaXMgZml4Lgo+Pj4+Pj4+Cj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFpodSBM
aW5nc2hhbjxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+Pj4+Pj4+PiAtLS0KPj4+Pj4+Pj4gICBk
cml2ZXJzL3ZkcGEvdmRwYS5jIHwgOCAtLS0tLS0tLQo+Pj4+Pj4+PiAgIDEgZmlsZSBjaGFuZ2Vk
LCA4IGRlbGV0aW9ucygtKQo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
ZHBhL3ZkcGEuYyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMgaW5kZXgKPj4+Pj4+Pj4gOWIwZTM5YjJm
MDIyLi5kNzZiMjJiMmY3YWUgMTAwNjQ0Cj4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBh
LmMKPj4+Pj4+Pj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGEuYwo+Pj4+Pj4+PiBAQCAtODUxLDE3
ICs4NTEsOSBAQCB2ZHBhX2Rldl9jb25maWdfZmlsbChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYs
Cj4+Pj4+Pj4+IHN0cnVjdCBza19idWZmICptc2csIHUzMiBwb3J0aWQsICB7Cj4+Pj4+Pj4+ICAg
CXUzMiBkZXZpY2VfaWQ7Cj4+Pj4+Pj4+ICAgCXZvaWQgKmhkcjsKPj4+Pj4+Pj4gLQl1OCBzdGF0
dXM7Cj4+Pj4+Pj4+ICAgCWludCBlcnI7Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+ICAgCWRvd25fcmVhZCgm
dmRldi0+Y2ZfbG9jayk7Cj4+Pj4+Pj4+IC0Jc3RhdHVzID0gdmRldi0+Y29uZmlnLT5nZXRfc3Rh
dHVzKHZkZXYpOwo+Pj4+Pj4+PiAtCWlmICghKHN0YXR1cyAmIFZJUlRJT19DT05GSUdfU19GRUFU
VVJFU19PSykpIHsKPj4+Pj4+Pj4gLQkJTkxfU0VUX0VSUl9NU0dfTU9EKGV4dGFjaywgIkZlYXR1
cmVzIG5lZ290aWF0aW9uIG5vdAo+Pj4+Pj4+PiBjb21wbGV0ZWQiKTsKPj4+Pj4+Pj4gLQkJZXJy
ID0gLUVBR0FJTjsKPj4+Pj4+Pj4gLQkJZ290byBvdXQ7Cj4+Pj4+Pj4+IC0JfQo+Pj4+Pj4+PiAt
Cj4+Pj4+Pj4+ICAgCWhkciA9IGdlbmxtc2dfcHV0KG1zZywgcG9ydGlkLCBzZXEsICZ2ZHBhX25s
X2ZhbWlseSwgZmxhZ3MsCj4+Pj4+Pj4+ICAgCQkJICBWRFBBX0NNRF9ERVZfQ09ORklHX0dFVCk7
Cj4+Pj4+Pj4+ICAgCWlmICghaGRyKSB7Cj4+Pj4+Pj4+IC0tCj4+Pj4+Pj4+IDIuMzEuMQo+Pj4+
Pj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+Pj4+
Pj4gVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0Cj4+Pj4+Pj4gVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKPj4+Pj4+PiBodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbgo+Pj4+Pj4KPj4+Pj4KPj4+
Pgo+Pj4KPj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
