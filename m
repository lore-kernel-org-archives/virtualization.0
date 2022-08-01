Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C3EC3F6B0
	for <virtualization@archiver.kernel.org>; Mon,  1 Aug 2022 22:53:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AFF1240185;
	Mon,  1 Aug 2022 22:53:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AFF1240185
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=tNCcuaSo;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=PI5oozaV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lXgMVUrkb4D6; Mon,  1 Aug 2022 22:53:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7FFFB40129;
	Mon,  1 Aug 2022 22:53:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7FFFB40129
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EEB6C0032;
	Mon,  1 Aug 2022 22:53:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B619C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 22:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 674C040166
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 22:53:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 674C040166
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 44OcugWwrmeR
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 22:53:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C4B0D40129
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C4B0D40129
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 22:53:50 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271MEOcd003974;
 Mon, 1 Aug 2022 22:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=UADTIpGkDJQHxGjNn70jx2EkKY4Hv5RStNFHFl12aoA=;
 b=tNCcuaSo1gIceVeSVglZEAybmpLw0WaE47he7+/ZhwE5pA+UjFrkFifLwSgaRJ2pO+eg
 wStbKSdVZHgg6JoJi7CAxPHMnA8NX6QchO4Te0OZXz9UxPBCWpsDdFexv1+0nQC+qXzY
 Wy12oy6ckh2063czRX781FDcJ/RPE1af++v7ZPSsz6EJ5dUKsaC+Et/ivhQRDs0xVun7
 Hb0nwKNb3rcKP9TOEWRcO3iH0T3qZQzwt0uHY4rwsSw2uOPS5QNl0MhtEb5WK2WRYxw1
 hJXGmi7v9GjbMipkj/HN1Y93CEyv0lvEjYrzheE1wGwp0azgPNxuYPwF7xQiNGS72U5P wQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmvh9n1na-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Aug 2022 22:53:45 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 271KX1MO001154; Mon, 1 Aug 2022 22:53:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hp57qn4n1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Aug 2022 22:53:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QiLxSXWJqJC9rljolqxc4MSpt4XLc/7TAS/kpJk7N10al6mr5P68d5dBvxF+ClE+qXTc7NFJ9kpIOL3o4NDAxEUcXqtv7IxFH3lr4Oxao2d7XOMkwE20jcAsq+Y8iHJOWw5+4Pum/HsME2M8nBHYwjDJIksMToCuThqxoccpaRmg0ODPXbYHIpq313nakf7RhppHOW00pszMSixHNnnvGnaJ5LbinQbRwU+0FfkAQ0PqSLrMQlZ+JWTq1CE+hzkdzljJe6moAGAwacWc6eZmdvLAujAZoN0tJ4tauQTgi0G1RUWAH3kRj7NJiDIzRt+HIRVOEcvurJM9nK0hrKEndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UADTIpGkDJQHxGjNn70jx2EkKY4Hv5RStNFHFl12aoA=;
 b=VcdWPma6KRtOIjODrA49cm6VRtgYG59iXcuSwT9T1yK667yqbcWJbZKOqWQ0W7b6OJjgqdRxw4Re5iErV4d5+C33vZQzI9Av+r+DNx1WXloPHHxu9lIsPfhuIyEPirLbQZKdcRmFEa/TdPSIF+7wrKwRU+K6O/LehEPWGhJZnOFIAphC+NYhp4AErmeD3wy9Ys0f5YhTZ1RGcPIkLRx7CBp3nxuVWIY45AVpPrYF84B8cWBrnbcY8qp/l1B/nJwMrJPVmnoHmo8X2jzcjlsThkYPc6suYqx3DwrqeG8sddQJqyextWss0wHRiov2rS2Pys6l0zkJIiAkdzHzp7vuzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UADTIpGkDJQHxGjNn70jx2EkKY4Hv5RStNFHFl12aoA=;
 b=PI5oozaVcU6kavosFX28hPwFB0+8/nfYy1T+6xrAlZ3vZheSFlD2DzykriOgJqj1EQ3qgUoSsgfNnqwNeji/pFhBTBiVEZAWoxe53g4ZZtkG7gjKoeBsK5z+Zy12lOGiCf2HDX3mcDX/ukEDGoNY0REIzYq/4g0JD6VD4fccssk=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by MN2PR10MB3597.namprd10.prod.outlook.com (2603:10b6:208:117::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Mon, 1 Aug
 2022 22:53:41 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 22:53:41 +0000
Message-ID: <ec302cd4-3791-d648-aa00-28b1e97d75e7@oracle.com>
Date: Mon, 1 Aug 2022 15:53:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 4/6] vDPA: !FEATURES_OK should not block querying
 device config space
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>,
 Parav Pandit <parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
 Eli Cohen <elic@nvidia.com>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-5-lingshan.zhu@intel.com>
 <PH0PR12MB548190DE76CC64E56DA2DF13DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <00889067-50ac-d2cd-675f-748f171e5c83@oracle.com>
 <63242254-ba84-6810-dad8-34f900b97f2f@intel.com>
 <8002554a-a77c-7b25-8f99-8d68248a741d@oracle.com>
 <00e2e07e-1a2e-7af8-a060-cc9034e0d33f@intel.com>
 <b58dba25-3258-d600-ea06-879094639852@oracle.com>
 <c143e2da-208e-b046-9b8f-1780f75ed3e6@intel.com>
 <454bdf1b-daa1-aa67-2b8c-bc15351c1851@oracle.com>
 <f1c56fd6-7fa1-c2b8-83f4-4f0d68de86f4@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <f1c56fd6-7fa1-c2b8-83f4-4f0d68de86f4@redhat.com>
X-ClientProxiedBy: SN6PR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:805:66::34) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b05b550-4189-45be-3bab-08da7410adae
X-MS-TrafficTypeDiagnostic: MN2PR10MB3597:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lr/vpIXLEwf7sG6o/w+LngjawsC1actOLFT85AEh5EtPP0DaMCZC1SRK6bF+qDcaDCV3dNNmlWgrVUEz18bFuAKH1aZ6H+/Jj95G0BcSyiWwHlBPfn/kw3zcoxNHIb4SjPVw53KVPbq5e6lrcec/CKfMqf3EPYqKxHGtLEgmNkb8+pEAa+l1PfrS80zQqMpMT18szaqtzoZdvgygKDkW3NgoaXbp/hiGTi3k+OTKTKDTjXvfzk8TdYJThN8hE+VFGPQnltPrrKNp5g5dlEjqvt5g0df8sHV+Za8wYOubefT7/3lFIJ1j35BFfccV7NXy5pbgknvyj9L0s9F14ctfTjy++pN2MYTWzQ5mXnCIJhNL1yd3vucS8KyZojlUo6CckyWcQ7WRA6pNSPuokb06qaTKUpOhZ0TrZLqSn7qH8QkhwzkXa593P79+v8DqgeLJal6z7sj6QYplpathyeKlg9TWnnc01QYUjr7YP7UsjDxqdX+VYwjDHTim/k7VkV1xtDtCFLXugny0Zngwh5x/5O5lztwZ2ba7Wh3ZCbtwPsKtBCNrfQTQBzw0hiTUWCw/xPtOy4hGpKaHSgGtT7Ad/NpPUbOw0WYoamyYjcKBkBGheQp/AcYfddVQT7gUMvnAckM/e02uPMwmff7iv+TzE0U6gkzgtNrvbt2BJ1U2D8OJrYTA7HwR/yyc3ka0HJfthaPuUgAA3PlX2dYPIHmPhKDMbqRSUva2VzyXG9svGEfNVTSKPRvl5z+Qb3GDJArPtj/jVfa5ye7uH2lb2Lm04NcM5u5aFcJQ6kjq8y0pzVs71VD+JwMR4yv9oKkCdHRfB7VDXI9PtTMC9Ngp5JpYpyqBYCOuUtHmUwaYv5CiJkc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(376002)(346002)(136003)(366004)(396003)(39860400002)(66476007)(66946007)(66556008)(8936002)(4326008)(8676002)(478600001)(38100700002)(186003)(5660300002)(6486002)(966005)(31696002)(316002)(54906003)(110136005)(86362001)(6666004)(2616005)(6506007)(53546011)(36916002)(2906002)(41300700001)(31686004)(83380400001)(36756003)(26005)(6512007)(30864003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2x6dEtTT1JneWZlL09hU0tIQ1ZQdWc4V0lOaW9KRUh4NUNCZ1FUUHZQb0Zv?=
 =?utf-8?B?WER4YWs0bGhTQ2dPWmxmekF5RllJNmRvYTREMWdNWC9sWnBINkJHWFZaUmIv?=
 =?utf-8?B?dXg4Q2txOFJaS3FSWERndkZOUmlweWk4V1R2S0o2dis0dlBZTzJtWjd6UU0w?=
 =?utf-8?B?T3RSL1Q3LzFnSStyWUJWcDNjWWJkdnphK241SW1OOHFidW83WlZGOVZwMWUy?=
 =?utf-8?B?QS8rbTRBdW1wMnNLeGhDZ0NxcThkK3RaNnRzVk5ITXVhVGJsb0tELzdJdW1G?=
 =?utf-8?B?WEhKTUJ3OVNTZldQaTlVZzdFRERNRitmSHBWUHMvVklvZVZwWks3K3ZTVEpI?=
 =?utf-8?B?eFgvdVpIdlcwZ0FlZTJ1b1BYUzZ5MmEzT1RXK3JURlM4Z0hOM29lcnJrY2Rt?=
 =?utf-8?B?cmRrcGFZUjArR0p2Ti9CNzNlLzJqY1NyWi9wUFY2cG5BQ21xUXB0aHhJMkd2?=
 =?utf-8?B?TmNqcW9kdjZHVUQ4Qk5lazNDc0FNM29mNFJMNzMzQU5kTWd5WEdpSUwzM0dx?=
 =?utf-8?B?UjFvSFBVWUdPOCtjcVZmVzMzWjBDb1A5N2svOWE4UXBEZnV5ZWFad1pzQ1E5?=
 =?utf-8?B?SERlSUlIVmpXOVVNZFBjdDZqeEFNS3lidWZSK3F6VlFmdG0zbWVKbXNabHNv?=
 =?utf-8?B?R3FHMXNtT1p1b1BNeTFGRTh4KzNnQjRBZTgyMXllK0QwbmZVOFJaa3UxNkwy?=
 =?utf-8?B?b0x1VjhQQjhVdlo1cDBDVi84TE4weEhNb1lvbDF3c2VwZWdWY0hLOGlIZGRH?=
 =?utf-8?B?OWdPOXJvWnBLeTcvQjVPNStLZDZmaVNwTkl3NUJRS1ZNNlhGM0JoajZPWkRw?=
 =?utf-8?B?QkU1MzV5c3pLKzczYXErMzhPeHVPVVc5anpNUFlvbjdVWEpBT2NwSWdSZmVD?=
 =?utf-8?B?aXg0VU1aZDBRT2ZwU3NwUnFJQ0VuMS84dUM3emRDZ0pnYkxFZWc1Qm81V3VR?=
 =?utf-8?B?UE1XbHhkcHQwWlNHOUxHUVBkUjZkY3dZRC9BUldOVEVKK29NQkxiSHBiUkhl?=
 =?utf-8?B?RktKeTh5em9yUWJLNmlRUktyR2VFZWh6dDc4VlJNQnVnUXpKZkhjTjhKeFkz?=
 =?utf-8?B?b3lMMzdJZ0hPTFJIMklYU0VZdG9LNldNQXArb3lFcFppRmYyblV6UlpERFZQ?=
 =?utf-8?B?TERaMXdnTzNuMHdGdTBkL2luL2hMcW9zR0xMYzYrYW5KZXVad3NOVUdwUHZF?=
 =?utf-8?B?Ky9FanB4M2hHM3hURE5lczZ4a2Y0OEFSWWN1VWdscmpqZ0x5aFhvYlRhem9P?=
 =?utf-8?B?TW9ybHRBOEhIVDdIdVkxSnIvbytJRHNySFNWeEFWVFZlTXl5MVJJbXhsNWhp?=
 =?utf-8?B?cys0TkRkdDVmMTNRQ29vNDlEOFAyUW0xcVNXQ3Z3TzRHbEFienZVVEN2Q2lN?=
 =?utf-8?B?ZHZuUWZQSW1SdUJQZ2M1ZFJIUmxFZE13bVYvQi9tMUdsV2ludUpueHIvNU9w?=
 =?utf-8?B?ckZiVHhlMDRyQ1FEZkd5Q1A0SlYrQms2ZzBiUEVtUnNuaEh4dzYwTUFGUjVP?=
 =?utf-8?B?ejdhQUJ6QTBvMVZQOHhwZjdFNE11NWpWemhocmVlcWFHTG9YbVI1cnhKYlZi?=
 =?utf-8?B?aks1WjZIOUF2Wmwwd0NmTVkwMzZ0b1laRXJiVlJGVlE1V1RkZ2VoK29IekQx?=
 =?utf-8?B?Tk8rczNUL1JieXRiaFNlYzI2b3NwTXJ1UW5KNkRQOG85SU96S0tLSnNBMmkr?=
 =?utf-8?B?cm52MUtITHVCZGhlNWMrYWlSdDhOc0R1Tlk5bzZSbGNsZllJeUdGNm1UYVZq?=
 =?utf-8?B?NDdQS1ZwbmZJTWhkK2I1TDZNaDhlY2pFc0NnVVdqUnhObUNHM1pIV29TdmtS?=
 =?utf-8?B?T1hrMmlhTHJuSWN6VDdmenp0UFpFTFh5RG9NWi9GVmNwY2toZWU2YUluODhJ?=
 =?utf-8?B?ZlJsbjlpcHpISllpaVdsbGNjS1A3OEluMEJlaWIwRDN0eTJ3eXpGemcyMFdZ?=
 =?utf-8?B?dHRXczN0VUVPVXIwZ0oxbDFXK3ArK2JGT0xlbVNGbkdFQ0hQbmNDS2QzTUlP?=
 =?utf-8?B?ZG5IK1d4eU0rWWNDSU1KRXlYQ0FycTVxbTlQSnJVdmhXOGxKakdtU3prUWtD?=
 =?utf-8?B?ZGZCU1lWQS9NRmFnUldvZ1lzVXBsbnFVdTZ2M3lqU2Zka2hmRmpxWE8wQUlp?=
 =?utf-8?Q?pHFg1d71UaCH5kK18A7nzx/ML?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b05b550-4189-45be-3bab-08da7410adae
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 22:53:41.1021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PrEUv0iQ9/dSuF4y0uyvGKk3ftsC3B7u5/0K3vDf4vF9ciy/hu9KsxmWws2Bxi7GGMG9s1Kzdms3K7l8iOH0pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3597
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_11,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010115
X-Proofpoint-ORIG-GUID: gcCCJOGJGWQ5pwtirTIsv1F89KycctDh
X-Proofpoint-GUID: gcCCJOGJGWQ5pwtirTIsv1F89KycctDh
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

CgpPbiA3LzMxLzIwMjIgOTo0NCBQTSwgSmFzb24gV2FuZyB3cm90ZToKPgo+IOWcqCAyMDIyLzcv
MzAgMDQ6NTUsIFNpLVdlaSBMaXUg5YaZ6YGTOgo+Pgo+Pgo+PiBPbiA3LzI4LzIwMjIgNzowNCBQ
TSwgWmh1LCBMaW5nc2hhbiB3cm90ZToKPj4+Cj4+Pgo+Pj4gT24gNy8yOS8yMDIyIDU6NDggQU0s
IFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pj4KPj4+Pgo+Pj4+IE9uIDcvMjcvMjAyMiA3OjQzIFBNLCBa
aHUsIExpbmdzaGFuIHdyb3RlOgo+Pj4+Pgo+Pj4+Pgo+Pj4+PiBPbiA3LzI4LzIwMjIgODo1NiBB
TSwgU2ktV2VpIExpdSB3cm90ZToKPj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4gT24gNy8yNy8yMDIyIDQ6
NDcgQU0sIFpodSwgTGluZ3NoYW4gd3JvdGU6Cj4+Pj4+Pj4KPj4+Pj4+Pgo+Pj4+Pj4+IE9uIDcv
MjcvMjAyMiA1OjQzIFBNLCBTaS1XZWkgTGl1IHdyb3RlOgo+Pj4+Pj4+PiBTb3JyeSB0byBjaGlt
ZSBpbiBsYXRlIGluIHRoZSBnYW1lLiBGb3Igc29tZSByZWFzb24gSSBjb3VsZG4ndCAKPj4+Pj4+
Pj4gZ2V0IHRvIG1vc3QgZW1haWxzIGZvciB0aGlzIGRpc2N1c3Npb24gKEkgb25seSBzdWJzY3Jp
YmVkIHRvIAo+Pj4+Pj4+PiB0aGUgdmlydHVhbGl6YXRpb24gbGlzdCksIHdoaWxlIEkgd2FzIHRh
a2luZyBvZmYgYW1vbmdzdCB0aGUgCj4+Pj4+Pj4+IHBhc3QgZmV3IHdlZWtzLgo+Pj4+Pj4+Pgo+
Pj4+Pj4+PiBJdCBsb29rcyB0byBtZSB0aGlzIHBhdGNoIGlzIGluY29tcGxldGUuIE5vdGVkIGRv
d24gdGhlIHdheSBpbiAKPj4+Pj4+Pj4gdmRwYV9kZXZfbmV0X2NvbmZpZ19maWxsKCksIHdlIGhh
dmUgdGhlIGZvbGxvd2luZzoKPj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCBmZWF0dXJlcyA9IHZk
ZXYtPmNvbmZpZy0+Z2V0X2RyaXZlcl9mZWF0dXJlcyh2ZGV2KTsKPj4+Pj4+Pj4gwqDCoMKgwqDC
oMKgwqDCoCBpZiAobmxhX3B1dF91NjRfNjRiaXQobXNnLCAKPj4+Pj4+Pj4gVkRQQV9BVFRSX0RF
Vl9ORUdPVElBVEVEX0ZFQVRVUkVTLCBmZWF0dXJlcywKPj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFZEUEFfQVRUUl9Q
QUQpKQo+Pj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVN
U0dTSVpFOwo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBNYWtpbmcgY2FsbCB0byAuZ2V0X2RyaXZlcl9mZWF0
dXJlcygpIGRvZXNuJ3QgbWFrZSBzZW5zZSB3aGVuIAo+Pj4+Pj4+PiBmZWF0dXJlIG5lZ290aWF0
aW9uIGlzbid0IGNvbXBsZXRlLiBOZWl0aGVyIHNob3VsZCBwcmVzZW50IAo+Pj4+Pj4+PiBuZWdv
dGlhdGVkX2ZlYXR1cmVzIHRvIHVzZXJzcGFjZSBiZWZvcmUgbmVnb3RpYXRpb24gaXMgZG9uZS4K
Pj4+Pj4+Pj4KPj4+Pj4+Pj4gU2ltaWxhcmx5LCBtYXhfdnFwIHRocm91Z2ggdmRwYV9kZXZfbmV0
X21xX2NvbmZpZ19maWxsKCkgCj4+Pj4+Pj4+IHByb2JhYmx5IHNob3VsZCBub3Qgc2hvdyBiZWZv
cmUgbmVnb3RpYXRpb24gaXMgZG9uZSAtIGl0IAo+Pj4+Pj4+PiBkZXBlbmRzIG9uIGRyaXZlciBm
ZWF0dXJlcyBuZWdvdGlhdGVkLgo+Pj4+Pj4+IEkgaGF2ZSBhbm90aGVyIHBhdGNoIGluIHRoaXMg
c2VyaWVzIGludHJvZHVjZXMgZGV2aWNlX2ZlYXR1cmVzIAo+Pj4+Pj4+IGFuZCB3aWxsIHJlcG9y
dCBkZXZpY2VfZmVhdHVyZXMgdG8gdGhlIHVzZXJzcGFjZSBldmVuIGZlYXR1cmVzIAo+Pj4+Pj4+
IG5lZ290aWF0aW9uIG5vdCBkb25lLiBCZWNhdXNlIHRoZSBzcGVjIHNheXMgd2Ugc2hvdWxkIGFs
bG93IAo+Pj4+Pj4+IGRyaXZlciBhY2Nlc3MgdGhlIGNvbmZpZyBzcGFjZSBiZWZvcmUgRkVBVFVS
RVNfT0suCj4+Pj4+PiBUaGUgY29uZmlnIHNwYWNlIGNhbiBiZSBhY2Nlc3NlZCBieSBndWVzdCBi
ZWZvcmUgZmVhdHVyZXNfb2sgCj4+Pj4+PiBkb2Vzbid0IG5lY2Vzc2FyaWx5IG1lYW4gdGhlIHZh
bHVlIGlzIHZhbGlkLiBZb3UgbWF5IHdhbnQgdG8gCj4+Pj4+PiBkb3VibGUgY2hlY2sgd2l0aCBN
aWNoYWVsIGZvciB3aGF0IGhlIHF1b3RlZCBlYXJsaWVyOgo+Pj4+PiB0aGF0J3Mgd2h5IEkgcHJv
cG9zZWQgdG8gZml4IHRoZXNlIGlzc3VlcywgZS5nLiwgaWYgbm8gX0ZfTUFDLCAKPj4+Pj4gdkRQ
QSBrZXJuZWwgc2hvdWxkIG5vdCByZXR1cm4gYSBtYWMgdG8gdGhlIHVzZXJzcGFjZSwgdGhlcmUg
aXMgbm90IAo+Pj4+PiBhIGRlZmF1bHQgdmFsdWUgZm9yIG1hYy4KPj4+PiBUaGVuIHBsZWFzZSBz
aG93IHVzIHRoZSBjb2RlLCBhcyBJIGNhbiBvbmx5IGNvbW1lbnQgYmFzZWQgb24geW91ciAKPj4+
PiBsYXRlc3QgKHY0KSBwYXRjaCBhbmQgaXQgd2FzIG5vdCB0aGVyZS4uIFRvIGJlIGhvbmVzdCwg
SSBkb24ndCAKPj4+PiB1bmRlcnN0YW5kIHRoZSBtb3RpdmF0aW9uIGFuZCB0aGUgdXNlIGNhc2Vz
IHlvdSBoYXZlLCBpcyBpdCBmb3IgCj4+Pj4gZGVidWdnaW5nL21vbml0b3Jpbmcgb3IgdGhlcmUn
cyByZWFsbHkgYSB1c2UgY2FzZSBmb3IgbGl2ZSAKPj4+PiBtaWdyYXRpb24/IEZvciB0aGUgZm9y
bWVyLCB5b3UgY2FuIGRvIGEgZGlyZWN0IGR1bXAgb24gYWxsIGNvbmZpZyAKPj4+PiBzcGFjZSBm
aWVsZHMgcmVnYXJkbGVzcyBvZiBlbmRpYW5lc3MgYW5kIGZlYXR1cmUgbmVnb3RpYXRpb24gCj4+
Pj4gd2l0aG91dCBoYXZpbmcgdG8gd29ycnkgYWJvdXQgdmFsaWRpdHkgKG1lYW5pbmdmdWwgdG8g
cHJlc2VudCB0byAKPj4+PiBhZG1pbiB1c2VyKS4gVG8gbWUgdGhlc2UgYXJlIGNvbmZsaWN0IGFz
a3MgdGhhdCBpcyBpbXBvc3NpYmxlIHRvIAo+Pj4+IG1peCBpbiBleGFjdCBvbmUgY29tbWFuZC4K
Pj4+IFRoaXMgYnVnIGp1c3QgaGFzIGJlZW4gcmV2ZWFsZWQgdHdvIGRheXMsIGFuZCB5b3Ugd2ls
bCBzZWUgdGhlIHBhdGNoIAo+Pj4gc29vbi4KPj4+Cj4+PiBUaGVyZSBhcmUgc29tZXRoaW5nIHRv
IGNsYXJpZnk6Cj4+PiAxKSB3ZSBuZWVkIHRvIHJlYWQgdGhlIGRldmljZSBmZWF0dXJlcywgb3Ig
aG93IGNhbiB5b3UgcGljayBhIHByb3BlciAKPj4+IExNIGRlc3RpbmF0aW9uCj4KPgo+IFNvIGl0
J3MgcHJvYmFibHkgbm90IHZlcnkgZWZmaWNpZW50IHRvIHVzZSB0aGlzLCB0aGUgbWFuYWdlciBs
YXllciAKPiBzaG91bGQgaGF2ZSB0aGUga25vd2xlZGdlIGFib3V0IHRoZSBjb21wYXRpYmlsaXR5
IGJlZm9yZSBkb2luZyAKPiBtaWdyYXRpb24gb3RoZXIgdGhhbiB0cnktYW5kLWZhaWwuCj4KPiBB
bmQgaXQncyB0aGUgdGFzayBvZiB0aGUgbWFuYWdlbWVudCB0byBnYXRoZXIgdGhlIG5vZGVzIHdo
b3NlIGRldmljZXMgCj4gY291bGQgYmUgbGl2ZSBtaWdyYXRlZCB0byBlYWNoIG90aGVyIGFzIHNv
bWV0aGluZyBsaWtlICJjbHVzdGVyIiB3aGljaCAKPiB3ZSd2ZSBhbHJlYWR5IHVzZWQgaW4gdGhl
IGNhc2Ugb2YgY3B1ZmxhZ3MuCj4KPiAxKSBkdXJpbmcgbm9kZSBib290c3RyYXAsIHRoZSBjYXBh
YmlsaXR5IG9mIGVhY2ggbm9kZSBhbmQgZGV2aWNlcyB3YXMgCj4gcmVwb3J0ZWQgdG8gbWFuYWdl
bWVudCBsYXllcgo+IDIpIG1hbmFnZW1lbnQgbGF5ZXIgZGVjaWRlIHRoZSBjbHVzdGVyIGFuZCBt
YWtlIHN1cmUgdGhlIG1pZ3JhdGlvbiBjYW4gCj4gb25seSBkb25lIGFtb25nIHRoZSBub2RlcyBp
bnNpZGVzIHRoZSBjbHVzdGVyCj4gMykgYmVmb3JlIG1pZ3JhdGlvbiwgdGhlIHZEUEEgbmVlZHMg
dG8gYmUgcHJvdmlzaW9uZWQgb24gdGhlIGRlc3RpbmF0aW9uCj4KPgo+Pj4gMikgdmRwYSBkZXYg
Y29uZmlnIHNob3cgY2FuIHNob3cgYm90aCBkZXZpY2UgZmVhdHVyZXMgYW5kIGRyaXZlciAKPj4+
IGZlYXR1cmVzLCB0aGVyZSBqdXN0IG5lZWQgYSBwYXRjaCBmb3IgaXByb3V0ZTIKPj4+IDMpIFRv
IHByb2Nlc3MgaW5mb3JtYXRpb24gbGlrZSBNUSwgd2UgZG9uJ3QganVzdCBkdW1wIHRoZSBjb25m
aWcgCj4+PiBzcGFjZSwgTVNUIGhhcyBleHBsYWluZWQgYmVmb3JlCj4+IFNvLCBpdCdzIGZvciBs
aXZlIG1pZ3JhdGlvbi4uLiBUaGVuIHdoeSBub3QgZXhwb3J0IHRob3NlIGNvbmZpZyAKPj4gcGFy
YW1ldGVycyBzcGVjaWZpZWQgZm9yIHZkcGEgY3JlYXRpb24gKGFzIHdlbGwgYXMgZGV2aWNlIGZl
YXR1cmUgCj4+IGJpdHMpIHRvIHRoZSBvdXRwdXQgb2YgInZkcGEgZGV2IHNob3ciIGNvbW1hbmQ/
IFRoYXQncyB3aGVyZSBkZXZpY2UgCj4+IHNpZGUgY29uZmlnIGxpdmVzIGFuZCBpcyBzdGF0aWMg
YWNyb3NzIHZkcGEncyBsaWZlIGN5Y2xlLiAidmRwYSBkZXYgCj4+IGNvbmZpZyBzaG93IiBpcyBt
b3N0bHkgZm9yIGR5bmFtaWMgZHJpdmVyIHNpZGUgY29uZmlnLCBhbmQgdGhlIAo+PiB2YWxpZGl0
eSBpcyBzdWJqZWN0IHRvIGZlYXR1cmUgbmVnb3RpYXRpb24uIEkgc3VwcG9zZSB0aGlzIHNob3Vs
ZCAKPj4gc3VpdCB5b3VyIG5lZWQgb2YgTE0sIGUuZy4KPgo+Cj4gSSB0aGluayBzby4KPgo+Cj4+
Cj4+ICQgdmRwYSBkZXYgYWRkIG5hbWUgdmRwYTEgbWdtdGRldiBwY2kvMDAwMDo0MTowNC4yIG1h
eF92cXAgNyBtdHUgMjAwMAo+PiAkIHZkcGEgZGV2IHNob3cgdmRwYTEKPj4gdmRwYTE6IHR5cGUg
bmV0d29yayBtZ210ZGV2IHBjaS8wMDAwOjQxOjA0LjIgdmVuZG9yX2lkIDU1NTUgbWF4X3ZxcyAK
Pj4gMTUgbWF4X3ZxX3NpemUgMjU2Cj4+IMKgIG1heF92cXAgNyBtdHUgMjAwMAo+PiDCoCBkZXZf
ZmVhdHVyZXMgQ1NVTSBHVUVTVF9DU1VNIE1UVSBIT1NUX1RTTzQgSE9TVF9UU082IFNUQVRVUyBD
VFJMX1ZRIAo+PiBNUSBDVFJMX01BQ19BRERSIFZFUlNJT05fMSBSSU5HX1BBQ0tFRAo+Cj4KPiBO
b3RlIHRoYXQgdGhlIG1nbXQgc2hvdWxkIGtub3cgdGhpcyBkZXN0aW5hdGlvbiBoYXZlIHRob3Nl
IAo+IGNhcGFiaWxpdHkvZmVhdHVyZXMgYmVmb3JlIHRoZSBwcm92aXNpb25pbmcuClllcywgbWdt
dCBzb2Z0d2FyZSBzaG91bGQgaGF2ZSB0byBjaGVjayB0aGUgYWJvdmUgZnJvbSBzb3VyY2UuCgo+
Cj4KPj4KPj4gRm9yIGl0IHRvIHdvcmssIHlvdSdkIHdhbnQgdG8gcGFzcyAic3RydWN0IHZkcGFf
ZGV2X3NldF9jb25maWciIHRvIAo+PiBfdmRwYV9yZWdpc3Rlcl9kZXZpY2UoKSBkdXJpbmcgcmVn
aXN0cmF0aW9uLCBhbmQgZ2V0IGl0IHNhdmVkIHRoZXJlIAo+PiBpbiAic3RydWN0IHZkcGFfZGV2
aWNlIi4gVGhlbiBpbiB2ZHBhX2Rldl9maWxsKCkgc2hvdyBlYWNoIGZpZWxkIAo+PiBjb25kaXRp
b25hbGx5IHN1YmplY3QgdG8gInN0cnVjdCB2ZHBhX2Rldl9zZXRfY29uZmlnLm1hc2siLgo+Pgo+
PiBUaGFua3MsCj4+IC1TaXdlaQo+Cj4KPiBUaGFua3MKPgo+Cj4+Pgo+Pj4gVGhhbmtzCj4+PiBa
aHUgTGluZ3NoYW4KPj4+Pgo+Pj4+Pj4+IE5vcGU6Cj4+Pj4+Pj4KPj4+Pj4+PiAyLjUuMcKgIERy
aXZlciBSZXF1aXJlbWVudHM6IERldmljZSBDb25maWd1cmF0aW9uIFNwYWNlCj4+Pj4+Pj4KPj4+
Pj4+PiAuLi4KPj4+Pj4+Pgo+Pj4+Pj4+IEZvciBvcHRpb25hbCBjb25maWd1cmF0aW9uIHNwYWNl
IGZpZWxkcywgdGhlIGRyaXZlciBNVVNUIGNoZWNrIAo+Pj4+Pj4+IHRoYXQgdGhlIGNvcnJlc3Bv
bmRpbmcgZmVhdHVyZSBpcyBvZmZlcmVkCj4+Pj4+Pj4gYmVmb3JlIGFjY2Vzc2luZyB0aGF0IHBh
cnQgb2YgdGhlIGNvbmZpZ3VyYXRpb24gc3BhY2UuCj4+Pj4+Pgo+Pj4+Pj4gYW5kIGhvdyBtYW55
IGRyaXZlciBidWdzIHRha2luZyB3cm9uZyBhc3N1bXB0aW9uIG9mIHRoZSB2YWxpZGl0eSAKPj4+
Pj4+IG9mIGNvbmZpZyBzcGFjZSBmaWVsZCB3aXRob3V0IGZlYXR1cmVzX29rLiBJIGFtIG5vdCBz
dXJlIHdoYXQgdXNlIAo+Pj4+Pj4gY2FzZSB5b3Ugd2FudCB0byBleHBvc2UgY29uZmlnIHJlc2lz
dGVyIHZhbHVlcyBmb3IgYmVmb3JlIAo+Pj4+Pj4gZmVhdHVyZXNfb2ssIGlmIGl0J3MgbW9zdGx5
IGZvciBsaXZlIG1pZ3JhdGlvbiBJIGd1ZXNzIGl0J3MgCj4+Pj4+PiBwcm9iYWJseSBoZWFkaW5n
IGEgd3JvbmcgZGlyZWN0aW9uLgo+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+Cj4+Pj4+
Pj4+IExhc3QgYnV0IG5vdCB0aGUgbGVhc3QsIHRoaXMgInZkcGEgZGV2IGNvbmZpZyIgY29tbWFu
ZCB3YXMgbm90IAo+Pj4+Pj4+PiBkZXNpZ25lZCB0byBkaXNwbGF5IHRoZSByZWFsIGNvbmZpZyBz
cGFjZSByZWdpc3RlciB2YWx1ZXMgaW4gCj4+Pj4+Pj4+IHRoZSBmaXJzdCBwbGFjZS4gUXVvdGlu
ZyB0aGUgdmRwYS1kZXYoOCkgbWFuIHBhZ2U6Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiB2ZHBhIGRldiBj
b25maWcgc2hvdyAtIFNob3cgY29uZmlndXJhdGlvbiBvZiBzcGVjaWZpYyBkZXZpY2UgCj4+Pj4+
Pj4+PiBvciBhbGwgZGV2aWNlcy4KPj4+Pj4+Pj4+IERFViAtIHNwZWNpZmllcyB0aGUgdmRwYSBk
ZXZpY2UgdG8gc2hvdyBpdHMgY29uZmlndXJhdGlvbi4gSWYgCj4+Pj4+Pj4+PiB0aGlzIGFyZ3Vt
ZW50IGlzIG9taXR0ZWQgYWxsIGRldmljZXMgY29uZmlndXJhdGlvbiBpcyBsaXN0ZWQuCj4+Pj4+
Pj4+IEl0IGRvZXNuJ3Qgc2F5IGFueXRoaW5nIGFib3V0IGNvbmZpZ3VyYXRpb24gc3BhY2Ugb3Ig
cmVnaXN0ZXIgCj4+Pj4+Pj4+IHZhbHVlcyBpbiBjb25maWcgc3BhY2UuIEFzIGxvbmcgYXMgaXQg
Y2FuIGNvbnZleSB0aGUgY29uZmlnIAo+Pj4+Pj4+PiBhdHRyaWJ1dGUgd2hlbiBpbnN0YW50aWF0
aW5nIHZEUEEgZGV2aWNlIGluc3RhbmNlLCBhbmQgbW9yZSAKPj4+Pj4+Pj4gaW1wb3J0YW50bHks
IHRoZSBjb25maWcgY2FuIGJlIGVhc2lseSBpbXBvcnRlZCBmcm9tIG9yIGV4cG9ydGVkIAo+Pj4+
Pj4+PiB0byB1c2Vyc3BhY2UgdG9vbHMgd2hlbiB0cnlpbmcgdG8gcmVjb25zdHJ1Y3QgdmRwYSBp
bnN0YW5jZSAKPj4+Pj4+Pj4gaW50YWN0IG9uIGRlc3RpbmF0aW9uIGhvc3QgZm9yIGxpdmUgbWln
cmF0aW9uLCBJTUhPIGluIG15IAo+Pj4+Pj4+PiBwZXJzb25hbCBpbnRlcnByZXRhdGlvbiBpdCBk
b2Vzbid0IG1hdHRlciB3aGF0IHRoZSBjb25maWcgc3BhY2UgCj4+Pj4+Pj4+IG1heSBwcmVzZW50
LiBJdCBtYXkgYmUgd29ydGggd2hpbGUgYWRkaW5nIGEgbmV3IGRlYnVnIGNvbW1hbmQgCj4+Pj4+
Pj4+IHRvIGV4cG9zZSB0aGUgcmVhbCByZWdpc3RlciB2YWx1ZSwgYnV0IHRoYXQncyBhbm90aGVy
IHN0b3J5Lgo+Pj4+Pj4+IEkgYW0gbm90IHN1cmUgZ2V0dGluZyB5b3VyIHBvaW50cy4gdkRQQSBu
b3cgcmVwb3J0cyBkZXZpY2UgCj4+Pj4+Pj4gZmVhdHVyZSBiaXRzKGRldmljZV9mZWF0dXJlcykg
YW5kIG5lZ290aWF0ZWQgZmVhdHVyZSAKPj4+Pj4+PiBiaXRzKGRyaXZlcl9mZWF0dXJlcyksIGFu
ZCB5ZXMsIHRoZSBkcml2ZXJzIGZlYXR1cmVzIGNhbiBiZSBhIAo+Pj4+Pj4+IHN1YnNldCBvZiB0
aGUgZGV2aWNlIGZlYXR1cmVzOyBhbmQgdGhlIHZEUEEgZGV2aWNlIGZlYXR1cmVzIGNhbiAKPj4+
Pj4+PiBiZSBhIHN1YnNldCBvZiB0aGUgbWFuYWdlbWVudCBkZXZpY2UgZmVhdHVyZXMuCj4+Pj4+
PiBXaGF0IEkgc2FpZCBpcyBhZnRlciB1bmJsb2NraW5nIHRoZSBjb25kaXRpb25hbCBjaGVjaywg
eW91J2QgaGF2ZSAKPj4+Pj4+IHRvIGhhbmRsZSB0aGUgY2FzZSBmb3IgZWFjaCBvZiB0aGUgdmRw
YSBhdHRyaWJ1dGUgd2hlbiBmZWF0dXJlIAo+Pj4+Pj4gbmVnb3RpYXRpb24gaXMgbm90IHlldCBk
b25lOiBiYXNpY2FsbHkgdGhlIHJlZ2lzdGVyIHZhbHVlcyB5b3UgCj4+Pj4+PiBnb3QgZnJvbSBj
b25maWcgc3BhY2UgdmlhIHRoZSB2ZHBhX2dldF9jb25maWdfdW5sb2NrZWQoKSBjYWxsIGlzIAo+
Pj4+Pj4gbm90IGNvbnNpZGVyZWQgdG8gYmUgdmFsaWQgYmVmb3JlIGZlYXR1cmVzX29rIChwZXIt
c3BlYykuIAo+Pj4+Pj4gQWx0aG91Z2ggaW4gc29tZSBjYXNlIHlvdSBtYXkgZ2V0IHNhbmUgdmFs
dWUsIHN1Y2ggYmVoYXZpb3IgaXMgCj4+Pj4+PiBnZW5lcmFsbHkgdW5kZWZpbmVkLiBJZiB5b3Ug
ZGVzaXJlIHRvIHNob3cganVzdCB0aGUgCj4+Pj4+PiBkZXZpY2VfZmVhdHVyZXMgYWxvbmUgd2l0
aG91dCBhbnkgY29uZmlnIHNwYWNlIGZpZWxkLCB3aGljaCB0aGUgCj4+Pj4+PiBkZXZpY2UgaGFk
IGFkdmVydGlzZWQgKmJlZm9yZSBmZWF0dXJlIG5lZ290aWF0aW9uIGlzIGNvbXBsZXRlKiwgCj4+
Pj4+PiB0aGF0J2xsIGJlIGZpbmUuIEJ1dCBsb29rcyB0byBtZSB0aGlzIGlzIG5vdCBob3cgcGF0
Y2ggaGFzIGJlZW4gCj4+Pj4+PiBpbXBsZW1lbnRlZC4gUHJvYmFibHkgbmVlZCBzb21lIG1vcmUg
d29yaz8KPj4+Pj4gVGhleSBhcmUgZHJpdmVyX2ZlYXR1cmVzKG5lZ290aWF0ZWQpIGFuZCB0aGUg
ZGV2aWNlX2ZlYXR1cmVzKHdoaWNoIAo+Pj4+PiBjb21lcyB3aXRoIHRoZSBkZXZpY2UpLCBhbmQg
dGhlIGNvbmZpZyBzcGFjZSBmaWVsZHMgdGhhdCBkZXBlbmQgb24gCj4+Pj4+IHRoZW0uIEluIHRo
aXMgc2VyaWVzLCB3ZSByZXBvcnQgYm90aCB0byB0aGUgdXNlcnNwYWNlLgo+Pj4+IEkgZmFpbCB0
byB1bmRlcnN0YW5kIHdoYXQgeW91IHdhbnQgdG8gcHJlc2VudCBmcm9tIHlvdXIgCj4+Pj4gZGVz
Y3JpcHRpb24uIE1heSBiZSB3b3J0aCBzaG93aW5nIHNvbWUgZXhhbXBsZSBvdXRwdXRzIHRoYXQg
YXQgCj4+Pj4gbGVhc3QgaW5jbHVkZSB0aGUgZm9sbG93aW5nIGNhc2VzOiAxKSB3aGVuIGRldmlj
ZSBvZmZlcnMgZmVhdHVyZXMgCj4+Pj4gYnV0IG5vdCB5ZXQgYWNrbm93bGVkZ2UgYnkgZ3Vlc3Qg
Mikgd2hlbiBndWVzdCBhY2tub3dsZWRnZWQgCj4+Pj4gZmVhdHVyZXMgYW5kIGRldmljZSBpcyB5
ZXQgdG8gYWNjZXB0IDMpIGFmdGVyIGd1ZXN0IGZlYXR1cmUgCj4+Pj4gbmVnb3RpYXRpb24gaXMg
Y29tcGxldGVkIChhZ3JlZWQgdXBvbiBiZXR3ZWVuIGd1ZXN0IGFuZCBkZXZpY2UpLgo+Pj4gT25s
eSB0d28gZmVhdHVyZSBzZXRzOiAxKSB3aGF0IHRoZSBkZXZpY2UgaGFzLiAoMikgd2hhdCBpcyBu
ZWdvdGlhdGVkCj4+Pj4KPj4+PiBUaGFua3MsCj4+Pj4gLVNpd2VpCj4+Pj4+Pgo+Pj4+Pj4gUmVn
YXJkcywKPj4+Pj4+IC1TaXdlaQo+Pj4+Pj4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gSGF2aW5nIHNhaWQs
IHBsZWFzZSBjb25zaWRlciB0byBkcm9wIHRoZSBGaXhlcyB0YWcsIGFzIGFwcGVhcnMgCj4+Pj4+
Pj4+IHRvIG1lIHlvdSdyZSBwcm9wb3NpbmcgYSBuZXcgZmVhdHVyZSByYXRoZXIgdGhhbiBmaXhp
bmcgYSByZWFsIAo+Pj4+Pj4+PiBpc3N1ZS4KPj4+Pj4+PiBpdCdzIGEgbmV3IGZlYXR1cmUgdG8g
cmVwb3J0IHRoZSBkZXZpY2UgZmVhdHVyZSBiaXRzIHRoYW4gb25seSAKPj4+Pj4+PiBuZWdvdGlh
dGVkIGZlYXR1cmVzLCBob3dldmVyIHRoaXMgcGF0Y2ggaXMgYSBtdXN0LCBvciBpdCB3aWxsIAo+
Pj4+Pj4+IGJsb2NrIHRoZSBkZXZpY2UgZmVhdHVyZSBiaXRzIHJlcG9ydGluZy4gYnV0IEkgYWdy
ZWUsIHRoZSBmaXggCj4+Pj4+Pj4gdGFnIGlzIG5vdCBhIG11c3QuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+
IFRoYW5rcywKPj4+Pj4+Pj4gLVNpd2VpCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IE9uIDcvMS8yMDIyIDM6
MTIgUE0sIFBhcmF2IFBhbmRpdCB2aWEgVmlydHVhbGl6YXRpb24gd3JvdGU6Cj4+Pj4+Pj4+Pj4g
RnJvbTogWmh1IExpbmdzaGFuPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4+Pj4+Pj4+Pj4gU2Vu
dDogRnJpZGF5LCBKdWx5IDEsIDIwMjIgOToyOCBBTQo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gVXNl
cnMgbWF5IHdhbnQgdG8gcXVlcnkgdGhlIGNvbmZpZyBzcGFjZSBvZiBhIHZEUEEgZGV2aWNlLCB0
byAKPj4+Pj4+Pj4+PiBjaG9vc2UgYQo+Pj4+Pj4+Pj4+IGFwcHJvcHJpYXRlIG9uZSBmb3IgYSBj
ZXJ0YWluIGd1ZXN0LiBUaGlzIG1lYW5zIHRoZSB1c2VycyAKPj4+Pj4+Pj4+PiBuZWVkIHRvIHJl
YWQgdGhlCj4+Pj4+Pj4+Pj4gY29uZmlnIHNwYWNlIGJlZm9yZSBGRUFUVVJFU19PSywgYW5kIHRo
ZSBleGlzdGVuY2Ugb2YgY29uZmlnIAo+Pj4+Pj4+Pj4+IHNwYWNlCj4+Pj4+Pj4+Pj4gY29udGVu
dHMgZG9lcyBub3QgZGVwZW5kIG9uIEZFQVRVUkVTX09LLgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4g
VGhlIHNwZWMgc2F5czoKPj4+Pj4+Pj4+PiBUaGUgZGV2aWNlIE1VU1QgYWxsb3cgcmVhZGluZyBv
ZiBhbnkgZGV2aWNlLXNwZWNpZmljIAo+Pj4+Pj4+Pj4+IGNvbmZpZ3VyYXRpb24gZmllbGQKPj4+
Pj4+Pj4+PiBiZWZvcmUgRkVBVFVSRVNfT0sgaXMgc2V0IGJ5IHRoZSBkcml2ZXIuIFRoaXMgaW5j
bHVkZXMgZmllbGRzIAo+Pj4+Pj4+Pj4+IHdoaWNoIGFyZQo+Pj4+Pj4+Pj4+IGNvbmRpdGlvbmFs
IG9uIGZlYXR1cmUgYml0cywgYXMgbG9uZyBhcyB0aG9zZSBmZWF0dXJlIGJpdHMgCj4+Pj4+Pj4+
Pj4gYXJlIG9mZmVyZWQgYnkgdGhlCj4+Pj4+Pj4+Pj4gZGV2aWNlLgo+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4gRml4ZXM6IDMwZWY3YThhYzhhMDcgKHZkcGE6IFJlYWQgZGV2aWNlIGNvbmZpZ3VyYXRp
b24gb25seSBpZiAKPj4+Pj4+Pj4+PiBGRUFUVVJFU19PSykKPj4+Pj4+Pj4+IEZpeCBpcyBmaW5l
LCBidXQgZml4ZXMgdGFnIG5lZWRzIGNvcnJlY3Rpb24gZGVzY3JpYmVkIGJlbG93Lgo+Pj4+Pj4+
Pj4KPj4+Pj4+Pj4+IEFib3ZlIGNvbW1pdCBpZCBpcyAxMyBsZXR0ZXJzIHNob3VsZCBiZSAxMi4K
Pj4+Pj4+Pj4+IEFuZAo+Pj4+Pj4+Pj4gSXQgc2hvdWxkIGJlIGluIGZvcm1hdAo+Pj4+Pj4+Pj4g
Rml4ZXM6IDMwZWY3YThhYzhhMCAoInZkcGE6IFJlYWQgZGV2aWNlIGNvbmZpZ3VyYXRpb24gb25s
eSBpZiAKPj4+Pj4+Pj4+IEZFQVRVUkVTX09LIikKPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBQbGVhc2Ug
dXNlIGNoZWNrcGF0Y2gucGwgc2NyaXB0IGJlZm9yZSBwb3N0aW5nIHRoZSBwYXRjaGVzIHRvIAo+
Pj4+Pj4+Pj4gY2F0Y2ggdGhlc2UgZXJyb3JzLgo+Pj4+Pj4+Pj4gVGhlcmUgaXMgYSBib3QgdGhh
dCBsb29rcyBhdCB0aGUgZml4ZXMgdGFnIGFuZCBpZGVudGlmaWVzIHRoZSAKPj4+Pj4+Pj4+IHJp
Z2h0IGtlcm5lbCB2ZXJzaW9uIHRvIGFwcGx5IHRoaXMgZml4Lgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
PiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGluZ3NoYW48bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPj4+
Pj4+Pj4+PiAtLS0KPj4+Pj4+Pj4+PiDCoCBkcml2ZXJzL3ZkcGEvdmRwYS5jIHwgOCAtLS0tLS0t
LQo+Pj4+Pj4+Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA4IGRlbGV0aW9ucygtKQo+Pj4+Pj4+Pj4+
Cj4+Pj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhLmMgYi9kcml2ZXJzL3Zk
cGEvdmRwYS5jIGluZGV4Cj4+Pj4+Pj4+Pj4gOWIwZTM5YjJmMDIyLi5kNzZiMjJiMmY3YWUgMTAw
NjQ0Cj4+Pj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGEuYwo+Pj4+Pj4+Pj4+ICsrKyBi
L2RyaXZlcnMvdmRwYS92ZHBhLmMKPj4+Pj4+Pj4+PiBAQCAtODUxLDE3ICs4NTEsOSBAQCB2ZHBh
X2Rldl9jb25maWdfZmlsbChzdHJ1Y3QgdmRwYV9kZXZpY2UgCj4+Pj4+Pj4+Pj4gKnZkZXYsCj4+
Pj4+Pj4+Pj4gc3RydWN0IHNrX2J1ZmYgKm1zZywgdTMyIHBvcnRpZCzCoCB7Cj4+Pj4+Pj4+Pj4g
wqDCoMKgwqDCoCB1MzIgZGV2aWNlX2lkOwo+Pj4+Pj4+Pj4+IMKgwqDCoMKgwqAgdm9pZCAqaGRy
Owo+Pj4+Pj4+Pj4+IC3CoMKgwqAgdTggc3RhdHVzOwo+Pj4+Pj4+Pj4+IMKgwqDCoMKgwqAgaW50
IGVycjsKPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IMKgwqDCoMKgwqAgZG93bl9yZWFkKCZ2ZGV2LT5j
Zl9sb2NrKTsKPj4+Pj4+Pj4+PiAtwqDCoMKgIHN0YXR1cyA9IHZkZXYtPmNvbmZpZy0+Z2V0X3N0
YXR1cyh2ZGV2KTsKPj4+Pj4+Pj4+PiAtwqDCoMKgIGlmICghKHN0YXR1cyAmIFZJUlRJT19DT05G
SUdfU19GRUFUVVJFU19PSykpIHsKPj4+Pj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgTkxfU0VUX0VS
Ul9NU0dfTU9EKGV4dGFjaywgIkZlYXR1cmVzIG5lZ290aWF0aW9uIG5vdAo+Pj4+Pj4+Pj4+IGNv
bXBsZXRlZCIpOwo+Pj4+Pj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCBlcnIgPSAtRUFHQUlOOwo+Pj4+
Pj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsKPj4+Pj4+Pj4+PiAtwqDCoMKgIH0KPj4+
Pj4+Pj4+PiAtCj4+Pj4+Pj4+Pj4gwqDCoMKgwqDCoCBoZHIgPSBnZW5sbXNnX3B1dChtc2csIHBv
cnRpZCwgc2VxLCAmdmRwYV9ubF9mYW1pbHksIAo+Pj4+Pj4+Pj4+IGZsYWdzLAo+Pj4+Pj4+Pj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBWRFBBX0NNRF9ERVZfQ09ORklHX0dFVCk7
Cj4+Pj4+Pj4+Pj4gwqDCoMKgwqDCoCBpZiAoIWhkcikgewo+Pj4+Pj4+Pj4+IC0tIAo+Pj4+Pj4+
Pj4+IDIuMzEuMQo+Pj4+Pj4+Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPj4+Pj4+Pj4+IFZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdAo+Pj4+Pj4+
Pj4gVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPj4+Pj4+Pj4+IGh0
dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbl9fOyEhQUNXVjVOOU0yUlY5OWhRIU56
T3Y1RXdfWjJDUC16SHlEN1JzVW9TdExaNTRLcEIyMVF5dVo4TDYzWVZQTEVHREV3dmNPU0RsSUd4
UVBIWS1ETWtPYTlzS0taZEJTYU5rbk1VJCAKPj4+Pj4+Pj4KPj4+Pj4+Pj4KPj4+Pj4+Pgo+Pj4+
Pj4KPj4+Pj4KPj4+Pgo+Pj4KPj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
