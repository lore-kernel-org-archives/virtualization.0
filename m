Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BE3ECAAD1
	for <virtualization@archiver.kernel.org>; Wed, 31 Aug 2022 08:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93B7181AF5;
	Wed, 31 Aug 2022 08:33:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93B7181AF5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=IYpuvRHa;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=hQ+IZ2GC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0xMrIpsy7rj9; Wed, 31 Aug 2022 08:33:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 110AC81AEF;
	Wed, 31 Aug 2022 08:33:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 110AC81AEF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDC8FC0033;
	Wed, 31 Aug 2022 08:33:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B17B6C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 08:33:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 73FF94180C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 08:33:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 73FF94180C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=IYpuvRHa; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=hQ+IZ2GC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NVTfsxem9Aip
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 08:33:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3DFD0417BF
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3DFD0417BF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 08:33:11 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27V57nXZ017317;
 Wed, 31 Aug 2022 08:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=TjsxUJqFD4x8Ok5Y5ObCXryyftqySUNrYMAMtkKvw6s=;
 b=IYpuvRHav5kwfjcd3rwTIRu3zK9Y/gLzNXw5PAf4aLiqQ6nKlYMsyBR5/VmpOP+Jkm8M
 PzkhoIRMmOlD74p8Pw/+3jQB7SETZlAIq/GlySjHXmZTx+/9p+NJ+vxfSEW0Zoa4OWch
 zq7cpcqR3pB9NzPHwtpnHtKd0jkmyrvIO5O6R5RskuFLMTPctfc6KISZAqw2zxTvVijH
 jzhHbSAMAp8fMPxQFb5ueEF2b4NOW1OsfJ91ZEYqwJCvTTb7UobS8vAj8LQcrdf7L414
 b0MBNIMYPA85wZznkslQcVy/YLSnPIddfQ64MWKZeIn6H/WdOZuJn+pqlbhLU78pSjKX Fw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7b5a0f5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Aug 2022 08:32:55 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 27V6i6sO033489; Wed, 31 Aug 2022 08:32:54 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3j79q54ytf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Aug 2022 08:32:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAi0n0gRKKJerWRWTahKP2pu5ZuLbUzYc7jqy3XEKMOqp0jFCwoQ737ZwnFvXXK25ZuRP+imupho3KgGISb1r2KdmcbLgxAu0ba1rt/0rDFZ+CmoDjf5P0IBwYI8J9n/1ifjHaZUPB1n1xE10kJGWnAs7REk6XIQGRY0qKc6g3+s35grv5BfPmk2MnvlNhN8IQAlugjyrUbem/9Xl3tIhHwct0CdgBsZmHF7SEOsEtLs5sOUOTSq4J2pOIx3nG8YVyD2bia0sj2mkwtttgD7L1RXYjNbihvx9oqrMfCO5TGVTMoFYOoviwBZ436md+SiZ5szRqeZfvyvRC+szLps+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjsxUJqFD4x8Ok5Y5ObCXryyftqySUNrYMAMtkKvw6s=;
 b=jpwMcMmcGHrq+B2fX6/avMbR4ND80of336BKG0UNzs49uwTFEPvs6Q2gLQcHFjLnN7C/JQ6g3EvdeEisobHMbakyDWAF6GO1OgyFx9wmF/sue9Xm6XiyTd5vem8oCXkitPrhL8n4VclnxEALUOYfdPK6KZCdVrrFgpvVbcihGxziymLqT9K57c3Dfe36ZRqCRKDWfegvAErE67lrreviLYECnrYDn1i3xN7IPs2Z0oKHWnQ57QrTIauKuAUL5kiVhtbFBzuw5G8zqUn+V/mBZ9q1XQyr/+/lsN7TxORTEU5eWOqjxbGUU5rZFgxw+BFtbHDNMPTSdRK+JdnNYSvOpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjsxUJqFD4x8Ok5Y5ObCXryyftqySUNrYMAMtkKvw6s=;
 b=hQ+IZ2GCM/O2KedML7xcFajD1w4vQos3Zj+5qBirpUZxXPp3t1qF/tW3F/oVt+abKEA1MhYrUlHOkoyUvV3odlwoepT9c/gYSelVJd3xtvkKqTAvAuOk1xaUZjcf/YhD7lj/PqJyCVgLjsP/jaCn2eQVA6iOC2aPkTyXn+75wbo=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by CO6PR10MB5571.namprd10.prod.outlook.com (2603:10b6:303:146::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 08:32:51 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 08:32:51 +0000
Message-ID: <8407acde-ebe9-b3de-aac3-4aac74c03bff@oracle.com>
Date: Wed, 31 Aug 2022 01:32:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [virtio-dev] [PATCH v3 1/2] virtio-net: introduce and use helper
 function for guest gso support checks
Content-Language: en-US
To: Gavin Li <gavinl@nvidia.com>, stephen@networkplumber.org,
 davem@davemloft.net, jesse.brandeburg@intel.com,
 alexander.h.duyck@intel.com, kuba@kernel.org,
 sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 virtio-dev@lists.oasis-open.org, mst@redhat.com
References: <20220830022634.69686-1-gavinl@nvidia.com>
 <20220830022634.69686-2-gavinl@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220830022634.69686-2-gavinl@nvidia.com>
X-ClientProxiedBy: SA0PR11CA0030.namprd11.prod.outlook.com
 (2603:10b6:806:d3::35) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2216a052-6c31-4b1a-872e-08da8b2b64a6
X-MS-TrafficTypeDiagnostic: CO6PR10MB5571:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hIVuDDV4uqyPDyXlOD54MJapdOCFgOJpXOxu9pyo30KTxstav1+qLt23a0bxBr6y6aX/iH4S+3JTxTJN1ZqbYzF0ud8m5v+mO8QvnQOu2tmOBnfjYOSnmmsx7xybo/QH229qdOFVB6IVWAP2gg6VbWij8/skxvOs+SjOPNtOY/MrtbWB2vLZuFpKezpy9ZyEwkBQCGb6ux6dIX1A5nH8XO9gKUEsGGWJ8VS6EaCpYYHswOsWK6Otxe06dfiaRcfd3euxkkG7xRPSvb6nmagzUcszLMf/EhPbvAzf/mXRRDLd70c0zKTq5XLkhmcZgg9tG383+BvlI15gWHHZdmdCArBy8hP2Ff/sdjjftWK7TGLGE6K7NrB+ZMlvwHJwlmQ6BdqN6l1CK4WBxKbVrLTX8bcmLolJvpOOMNdNq1rPK0zW7vTCTzK4Hv6pNhJgEFj5CxVmVhTvgYvTNyMMnYpWwE+/5JYG7PbxSauoVM+IaqBAe+fvDvgE1vJW3NBkklOEWFDFfKY1NtrL4LQXuoxEnsvjdSV9dHRgfhDHpexiFWIeHt2Sylog/obNbKcYg6zexIRQafoiFUX9sCKkfuDZgYf/8QQEBoNloJ4yDFfXDi2jq1J/Y71yr7gZ/5fLRNP6TiwFPMTNr6w92zQGGNQAKGJj+lRfJq2rrqU0sYaW+7U57CYArbPdgUTky9p9i5Kc7GdbeIcERSX9eqOvzqkgRf5Kiubwcx6+WxPwWnrEmsQyuWgl/eW6nXgfZMERubdAnR0dI5vCcikY+9Nm1bIHUBiXOAmndHpuH2H7PqOrHLrVkzn3tdIMhECBRXW8zOuj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(346002)(376002)(366004)(396003)(39860400002)(136003)(8676002)(66476007)(66556008)(4326008)(66946007)(316002)(36756003)(2906002)(31696002)(6486002)(5660300002)(86362001)(7416002)(8936002)(38100700002)(31686004)(921005)(186003)(2616005)(41300700001)(478600001)(26005)(6506007)(6512007)(6666004)(36916002)(53546011)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWVsanNqT1pRcTZQSmdlUjhMS08yeUFUSmp0dlIxckNJbHpXUklGWG9LQ3cr?=
 =?utf-8?B?Qm82UUtUbWpvUUpzQnhnd0t4NGdOWitqSXFuaXdFYVFxY2FhMXdYWDc2MkQw?=
 =?utf-8?B?QW85c3ZtOHhUVlErMlhSNTltR3ZmckM3S0UxM2t4aTY2eUpUd1YzSXYrOUc5?=
 =?utf-8?B?Y0xnNnNkbkFTM2hIeFhoZS8zUVY5YzhHekNQSUdMaVVzM1ZzUlgyYng4djBJ?=
 =?utf-8?B?QkpFSjdhMXNUR0xiSXJVWkU2eW1KWkpPdGN1QVY2UHlIUWF0OUhUdERxOXVE?=
 =?utf-8?B?WGF5RnVBeThCZ0JTaHBYQkp5cGJVM3FGbEpTN3ZTRWl4T05DQzljd2ptaStw?=
 =?utf-8?B?WC9pcEg4Z29xZFRob01XMmVWYjNUODZRb2k4NjNTQ0k2SWRXWHA1cCtBMDRJ?=
 =?utf-8?B?RldlS2ZmM1pnMmdBS21vNEMrRXF1VUg3bUk5TDA3MzFFanJ2MHk1bHVJSWVL?=
 =?utf-8?B?Qjh5L1NkcHdVbEROc2pTcGhtTVhFTldhNUtUNmRiNlhyRXhkTWhXT2dFQWh6?=
 =?utf-8?B?SHhsclplcExqRGZDeElUWm5FUjd4bVp2YUMzTGN0VDJZbEFtWmFQaXEwSmNj?=
 =?utf-8?B?SHNRUHZ2a1AvUUlxaTdDTlI2TU96RUdPYnNaK2RSVUVZU0tJWEhWWGpTQUIy?=
 =?utf-8?B?ei9RVnFTT2VHd010NG5kYVRiUkRDMXpGSXZrcUt6bzl3dGZpbzBiOVZaZWpt?=
 =?utf-8?B?K3l1ZmhCRUMyV1JUTlk1S3VMNEl1TEl3TVdjY0VRL1d3SEJqUVhpd0lNNUxN?=
 =?utf-8?B?WHpJajlOQ3hiWHErUDV2RTJVRUwrdmJ4MUJ1THdnZmdheXVuRXJicERMUWNM?=
 =?utf-8?B?bUdSa21OZzJIMnduSnIvb29jUHRZcUlpTzVSK2lBS2JZR2R1Umg4M0ZyMFhx?=
 =?utf-8?B?VXJnTHdMdGRTUGFKeC92dEhJQkRVU2toUjFXR1JoOFo2VTVML1dGdmpPRXhE?=
 =?utf-8?B?bVRrWjZWaDVqc2JpV1o3RElnUFAzd3pLbkhFMFlGalE3YzNNcEFjNTlzcUdq?=
 =?utf-8?B?YjYrb09CWEhSOXBNRUVrVG00OHJoMGVsQ0VhSHAwWEtrcVhjOXA2OGZTQ1Q4?=
 =?utf-8?B?KzJ0TWZ6a3I3aFN0eGhpaTVqNklrZnZoNVJvaE44LzI3bUF2OVhPTzBRYVMw?=
 =?utf-8?B?TzYxTjlhZE1IZS96cXplK3ZSMnE0MVYwOFRjR3E0VXlRQmNZTEdvOEdqSDlC?=
 =?utf-8?B?Z2lNc28wMWtlUEdXajcvNG9wNzlKL2VRanBqdmZFSEhBc1V6ZkNWaTRVU0gr?=
 =?utf-8?B?TFlrVExNM0c1Y0xZWHdxTzlTWXV5S2xCR2hkYnVmUjRYMGs1bXc3Z3VpdE95?=
 =?utf-8?B?ZDRoR213MmJadmVINURpTHVLOGFsWS94WWVKbEc0MVQ1SlBEWjdSWGdPYTBn?=
 =?utf-8?B?VDQrSEJIQzBRRGhhYng0QkJOeHRoTHRLY3pCLzd3d1BRdkhHcldYdUZETjho?=
 =?utf-8?B?YTdDMDRoUm05RlZQRld1VWNTNTdKQVBiL2E3VE1ZeEZFRHgrVGxCdkdjaUZX?=
 =?utf-8?B?U3lJQVdJalhMK2lVNkpwWXo5UVUyMGt2QnowTHdNY2UxVFJja21DSC9iUWNQ?=
 =?utf-8?B?cVErWDMrTUNEcXJtZ09pbnQ2Q3lXTHJpVmhsU00ydUFad0tzQi9EaitibHdY?=
 =?utf-8?B?ZmVXRWE3L0U5a2JPT3B2NHllTitqQW95bENCVEFGNnZlTFVwL3FIV1ZIc2NY?=
 =?utf-8?B?UUFlWWNtQ0k4NkNacVFOZSs5cVhENGVab05QN2FIcEg4RmIwQmw4dUVmL0dZ?=
 =?utf-8?B?cEw2YXpRVkJFY05Jb05ReHlpOVJkUlRvTDV5Q3JuMzdWaWhYTkRWeDZNN1BY?=
 =?utf-8?B?UjhWNjF1bGtuVjBlWnViR0JlQUhKcXVjcmc2QTlIMFRXMnZ5WVo5bWJqQ1lD?=
 =?utf-8?B?bDRuZE9Xb3hHcDhVSUd4U3dtSVcyclFocHhRUGdhcW1QencySitsWHNTR1FZ?=
 =?utf-8?B?Ync2MlNUZ25oSEZ2RWozRVl2bnloZEp3RTdJYUltZkw3QWk2Y0o1T3hCQklI?=
 =?utf-8?B?NEJMK2o2NDUzOU9tMnBTZVpBZjBnMm5nMTJZam9yTUU4N0Z2VEhQZnd1VUE0?=
 =?utf-8?B?VkNBQ3lTNW9RZWN0N3RpbGlnZlBXS2sxTVJBK3ZLTXhpeTl4aE1LQWZObXdw?=
 =?utf-8?Q?5HAFPTY8oYvIcbqJFwnrBPyGC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2216a052-6c31-4b1a-872e-08da8b2b64a6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 08:32:51.7023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aivTNZRJifGrrnXOIjxhyZ1t7f1/o5a4Pz7CI6HP8XRCJNfIIIoVtH1SqUJyKYkrHZeiaWGeDTGoN9bQeV4UtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5571
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_05,2022-08-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310042
X-Proofpoint-ORIG-GUID: K5vCEs6HrLzMRlBuhJ3qLFa7u88Dxty7
X-Proofpoint-GUID: K5vCEs6HrLzMRlBuhJ3qLFa7u88Dxty7
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 8/29/2022 7:26 PM, Gavin Li wrote:
> Probe routine is already several hundred lines.
> Use helper function for guest gso support check.
>
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Gavi Teitz <gavi@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
> changelog:
> v1->v2
> - Add new patch
> ---
>   drivers/net/virtio_net.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 9cce7dec7366..e1904877d461 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3682,6 +3682,14 @@ static int virtnet_validate(struct virtio_device *vdev)
>   	return 0;
>   }
>   
> +static bool virtnet_check_guest_gso(const struct virtnet_info *vi)
> +{
> +	return (virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> +		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
> +		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
> +		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO));
> +}
> +
>   static int virtnet_probe(struct virtio_device *vdev)
>   {
>   	int i, err = -ENOMEM;
> @@ -3777,10 +3785,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>   	spin_lock_init(&vi->refill_lock);
>   
>   	/* If we can receive ANY GSO packets, we must allocate large ones. */
> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> -	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
> -	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
> -	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
> +	if (virtnet_check_guest_gso(vi))
>   		vi->big_packets = true;
>   
>   	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
