Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5197FECAAD2
	for <virtualization@archiver.kernel.org>; Fri, 26 Aug 2022 08:53:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C506F83ED1;
	Fri, 26 Aug 2022 08:53:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C506F83ED1
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=Z2JV/qOp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=GE1whpCC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R-LjF73OgNUA; Fri, 26 Aug 2022 08:53:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A79F583E96;
	Fri, 26 Aug 2022 08:53:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A79F583E96
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71F06C0033;
	Fri, 26 Aug 2022 08:53:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 713C8C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Aug 2022 08:53:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4307483E9F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Aug 2022 08:53:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4307483E9F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y01Vm5J2BrdT
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Aug 2022 08:52:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 167F683E96
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 167F683E96
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Aug 2022 08:52:57 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q7XmVO030483;
 Fri, 26 Aug 2022 08:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=nyZciptjDnmw3WqNAtxhqOGWt7IFZrE2u/sJznferfA=;
 b=Z2JV/qOpmaHKy9sIbswjheQIxETmMv2HEI8vs6F+yKKgpMW6w8y63b0DN7jE2Qgu9xgU
 D27/XbAABhvyr8SXzEEhE+XLZYtOXWj/FZ/G0ByHrr1QYundPyXJdiWXMGi4bsx2Ozt3
 oMae/ILmNGHfHmMvI3v9wEOIhd2TybZCLaNtgvqUhHKGLgV5iLn5uRt/OPzzSw5rnMlY
 D/pApw51CSOexPmYFNG8qm7o/uMBYiSyeM7lPniAWseYbDukpFMoeWmO0ePsOjFh8pf9
 U3QNDfyVD7aJ1z+yVP3MrfJw4CoVp/nQzTNOFTYQHf0sEVU7093t7T+kii3HEYJbVOSH jQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w25rvk1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Aug 2022 08:52:31 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 27Q8OoUD016228; Fri, 26 Aug 2022 08:52:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3j5n6p0ksk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Aug 2022 08:52:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmbLiTkRzob5YxLZy+6k45o6kDlG/A9pM5fSyeAyHvkS99Tfk4HFH1P7fJOvqvhEBCgYaQYKDYlMFZAhEwBRWMoQIQIK1e9vkE7dtN0gdCKG6mxfFcMxUqkXU/VHC0zhNHqtDBPiUjQifRXQ6Un1CSaFH4JqhPkigrfZXurWDfSGywO+j9cvPeVqLg5UmIuNDi7bpKsG/no2KdP2hPBsQ9UbkodWOutGDV9pAMgvZFQFvX85d3zqLfj1S+xU6pQ54v65L9dvxZhgVy87CBrrG/VJzRr3yLt/pVADYTuGas2h+7GiYIkDUv33xtea7WNOFgorxWaixw92kzq6g4LWKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyZciptjDnmw3WqNAtxhqOGWt7IFZrE2u/sJznferfA=;
 b=amo2swJRd1+FpblF4GwAVNiBdF34Fc7j5HMNvSrdrkPWjT0wFbS0G4nh3Lr5Hdy23BbT+cYoaHIjJfWzwT44VrX/fH7YmSGR5/sBIlBah/ty52p2nT3JqyOHVR7u34sJCU6U2LKDXu/GBcmj+feZITWsGcMJnaoAVBCieztIMwQFiSlPCl+gVHDNrLoW4GT1do+qt64wksA9Bc7rJ9FV2qjJPigARI0p7SrrJbttc/zd4ebvSFxnX+1B0jRLA1dBebObrz8/Jeo1wSVLddgWnsQnY+D8lYY8pzcch3JQg3i2Yc/V/FsnwROB9YJI+mh8wCtHFPv/rnyfaWtfM7VkAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyZciptjDnmw3WqNAtxhqOGWt7IFZrE2u/sJznferfA=;
 b=GE1whpCC4zRX94HnP5ea0p1w/Mw+deQOZwJLvK3uhn5toxSvzZigEDEBtOs6uelIqbnGQbV+JXUx6f1cr/dvu301HjmgLMftxDS4Nv1KGveiMYkP2M+8fwp/B0CllbrNRARVkcaUdD801E79Y+lE4q8KTe5uqrSSGbQQpcWE6ss=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by MN2PR10MB3936.namprd10.prod.outlook.com (2603:10b6:208:1bd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Fri, 26 Aug
 2022 08:52:27 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 08:52:26 +0000
Message-ID: <27204c1c-1767-c968-0481-c052370875d8@oracle.com>
Date: Fri, 26 Aug 2022 01:52:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [virtio-dev] [PATCH RESEND v2 2/2] virtio-net: use mtu size as
 buffer length for big packets
Content-Language: en-US
To: Gavin Li <gavinl@nvidia.com>, stephen@networkplumber.org,
 davem@davemloft.net, jesse.brandeburg@intel.com,
 alexander.h.duyck@intel.com, kuba@kernel.org,
 sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 virtio-dev@lists.oasis-open.org, mst@redhat.com
References: <20220825123840.20239-1-gavinl@nvidia.com>
 <20220825123840.20239-3-gavinl@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220825123840.20239-3-gavinl@nvidia.com>
X-ClientProxiedBy: MN2PR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:208:d4::47) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2db2f96d-c89d-43fd-6bd4-08da87404d0c
X-MS-TrafficTypeDiagnostic: MN2PR10MB3936:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N6Og2LrxOFqF8gQT7j6kChtL4LRNIwyOrl6/1bnYgDBbHgneG6m1s2zCle+QLbjUYqvj4YXyZLx1IoZRSFTZk3+6Ubwf9Y4dQsplyTvR4ZHJRQEP+IFGO2z2WNGpxhavKHQye12uAMps2lfc+orKRkxsglJWi+y9mU2f7sQm4uwHQexf71Ph6KbQUFYFMshOKa+hwUZ+rtWFjna28XSL+6WFubYwGP28D4DPWjtwnAFE0578arBGU8vlQcJ7f41y+V1PrZJ0TNWHOkrkX3Eb63IEBI4xadSvflELO8eM/1J5DUwZr/+xHv1K79goCKE2l4zI1YUO9SEwrC254eyuLwv2R5Otr7Q2gIDt9iC1Ezi/ApcOCgfxiq0rNOhbx5IZVOKwCS8Z0SKHCC57FxJLwj9AH73J+bD+G5u149aBxv2EN0t5beCSjZ0bkD8v+lflB+fwo9t/q97dfBhcRVVLNbVG/ODla63rH1ZM41RndGNsr2vPmwOpNH8As1zhO0CDUAE2k5hK57SIaXeRuchC+Nm+7SZJIBfb/IVDp8+2KnXQ3Cs3PSZJ71q+hT5TnNydMuCG/GRHoBHehpIWaRsc2UH5/kMJyvD8AIloIMsDav5h/6r6w/Vmd2ztRlnCn28ZH82Mni+hAf2Uq3yZGU2MsyxXC7kDbc8lGJgGW5YtrVzfAY6zlsQ1fziDU6w5CWahhHH5/V9SWB+Xc5MCjeXOXHVSD0sx7X0wP+PIAK8Na6YuCUiXtH9LcxDEHIjke7Be+cxqtozn/8zLlKXQOW2UzFpd36BAjJe6uRpfKDxtmG1vKBkkh4bA2DJi0Bm9cg4d
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(346002)(396003)(376002)(39860400002)(136003)(31696002)(921005)(86362001)(38100700002)(31686004)(316002)(2906002)(4326008)(66946007)(53546011)(7416002)(30864003)(8676002)(8936002)(66556008)(66476007)(6486002)(186003)(41300700001)(6506007)(36916002)(33964004)(83380400001)(6512007)(36756003)(26005)(107886003)(6666004)(478600001)(5660300002)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHhrMWlZRThhbk5BWUhqQVZwd2hBUW1BdERCRmc5c2RCWjVBZm9hQ25KZDND?=
 =?utf-8?B?ZmFVM1doM0VZTFFmVG1kVm1LcjFVUC9hZFdpeDNrc2hEYnV3NWQrNUthUW5N?=
 =?utf-8?B?c2pkM3dkWGdOYWFFSUh4WFZHbHBiUHFxN1pwWW16UlRjRXNBQ2pxdHEzckY5?=
 =?utf-8?B?SmFzTXpEYlJpNDBRckJURlRZR0p1cW4ycHllQmRpeHUrOXZ2OVJJYXBqVi9t?=
 =?utf-8?B?TDZzbnBhK2NVVmR3OFhHTjFjRHVXdTJPVURlRU0veEJwKzh1blk2Z3JlUFhR?=
 =?utf-8?B?MHFMQ21tV2J3cFhWdjNyQ1lwWktVL1Y1dWVteWNhblJLNkVQNTRVa1NHbXl0?=
 =?utf-8?B?dFE1ai9mbHphcjhWZnp1OFA5SVVjc2xzRDc2cGZPbi9FcFlLT05aUkZMZmor?=
 =?utf-8?B?MlZsUkdQTzdBNys3OTBkeWMyR3J6am5Na3J5SlU0ZVdXazcwOVZpUi9uTm10?=
 =?utf-8?B?enZ3akI5VW5oT1E2ZWsxb21QWjE0bTJQbmZTYUkxTys4VjdLOHIrRU1ZT0VT?=
 =?utf-8?B?T3VLek15VjRqZW1SOHdKY3VsMTI4L0VrMXJaZHRrQ2lYenJQSEd5U2E0aGdZ?=
 =?utf-8?B?RXRXd1BhT3hVR213L3BUQVJwcGdIc0l6UTVWdG1aaGY4V2U1WWNIMjQrMjkv?=
 =?utf-8?B?SmU5KzRYaUNHaWRYbkRSUGNhUmdnclhXcHNQUlJnM2J4N0l1VkJ6SWNFdlpM?=
 =?utf-8?B?NWNMN2pWRjJ0TG93YVBhNElmUWlwNFpoT25JT2pTbWU1cnJ4bG9WcW5xQVUw?=
 =?utf-8?B?UkhXSFN4VHRXQTdwNzlNaFNRN1V4WXdTeHJhcndGdFJlS3hadVgrQ2VwTUFD?=
 =?utf-8?B?SUw2azBsR3pDRCtGQU0vd2JTMlBDWnZjZVJXdER4Umo5NVJaK0pEckxTV0Zv?=
 =?utf-8?B?WUZSYVIydmwxY0RUY3VRTnNQVkZCZHJSK0NJb3pENTdab1JFeTZXNDcweEJD?=
 =?utf-8?B?WUx5SVlRWmdDSUpuTW01UnhtVkVSeVp2Tm1sUmNzeVc2UlY5M2QzcnBzZy9K?=
 =?utf-8?B?UHg4UkN2MUkvQU0ydG1Kc01SSVRFUlV2NXlvZ0tEYXROWnhYTkFaNHlVellH?=
 =?utf-8?B?UjhpUkdDWTl2djYzN1Rrd2ppb2VBTnhLdkFaL1R0NW05L3dFYkdyMGQzcWVB?=
 =?utf-8?B?U2hZUlFERFg4RCsxdENIUlpENnh0S1VsZXh5NjFvejE2SXJUZ1h0M1k0aG9t?=
 =?utf-8?B?UTExT1hlRTZQa2o0aFdWTXRDTjh4akhLdElVZFJjeCtFaDdDWDJYcXAwVzEr?=
 =?utf-8?B?S3BSOWNWa2JyWFRPS3JBNW55ckZXbysvdkJUNE9LWGpuTXc0QXpLZm5LbTRC?=
 =?utf-8?B?MFFNb3pGZHVjRjVjSEdINHVocW9BdVpQVTlBMDBYcHgxalA2RjI5ZW5oOStS?=
 =?utf-8?B?TWx3T2xYcXVCQk9Hd3kwcGJxS2pvWkJEcmsvR3NwVXBreDZGM0pYZTU4dFRZ?=
 =?utf-8?B?Z2lhdDh0L2paOFBST3F2Qi9YRk4rcnZ0bXNWclo0S0cvL3V0VjU0Vk1WYk5E?=
 =?utf-8?B?U3BuRzZoeE1RZ2VKbWt0TnYyYmh0Y3hyOVBJMmRid1RBeUNQOElSRHhYbW43?=
 =?utf-8?B?KzRsS2F2T2VpK2ZhR0UwWTkvd0RHMEpMUFc5N2M1Z1hhSitPc2cvMTNZQ3k2?=
 =?utf-8?B?eTlSL3d5WHFJNHFWbzBFWTg5MG9JcEFnNnNzb3dNYTJ5dlF4MmVNMHRFZExB?=
 =?utf-8?B?NzFMOHN3RWFib3BEZEtJaGlUc3ZxN29Qak9aeStVZG1rY0g2WDdUUUlQcjZ3?=
 =?utf-8?B?VEtPUDJYV3JybFVaN2dXVFBjd2tzTko0N2w0aktCeFRablF5R284eXNOZFBi?=
 =?utf-8?B?MDZybm02bkRoeVJFRlIyUmxoRUx5NWZJVGh6UGF6L1E4dE5XaXdJRmxpQlUy?=
 =?utf-8?B?R2JhbmZWcHpmOGh3NzZNb01mbUN2RDArQlpWbFN3SGdVNHF0QzA5ZkE0bXJI?=
 =?utf-8?B?b0VGVlpiYlZRZWZwOUZ3UWxVakhEVTc1RHpWU0VZTDlRQURReis4U0dUMDNM?=
 =?utf-8?B?cmdZakJSckRKWWovek04RVB4Q28wT3BEM2w4enEzelB1MjU3blU1TXlUQ2N4?=
 =?utf-8?B?NzlCaDVTRmlHU1VKZXhmbjZWNmhyVThYcy81L1A2bllwb3MzTEdJNTZkUXBP?=
 =?utf-8?Q?gGMGJerG67oOcFr9/idFS3cYP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db2f96d-c89d-43fd-6bd4-08da87404d0c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 08:52:26.8694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxhqDpNdNiavg+M9bgmkGeLdBATg/XeRKiFTroVEk4UcutwtmFkvQli5fHFqvbZKu6tzBj0fuCpTRK1dCrt5xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3936
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_04,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260034
X-Proofpoint-ORIG-GUID: 3ngDlU0UnK2nagxDMf5mMNTf-SkCkdLo
X-Proofpoint-GUID: 3ngDlU0UnK2nagxDMf5mMNTf-SkCkdLo
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
Content-Type: multipart/mixed; boundary="===============2884339845796556620=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============2884339845796556620==
Content-Type: multipart/alternative;
 boundary="------------D0WHH0JdGtzNmlRYGuycaOhH"
Content-Language: en-US

--------------D0WHH0JdGtzNmlRYGuycaOhH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry for the delay. Didn't notice as this thread was not addressed to 
my work email. Please copy to my work email if it needs my immediate 
attention.

On 8/25/2022 5:38 AM, Gavin Li wrote:
> Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
> packets even when GUEST_* offloads are not present on the device.
> However, if guest GSO is not supported, it would be sufficient to
> allocate segments to cover just up the MTU size and no further.
> Allocating the maximum amount of segments results in a large waste of
> buffer space in the queue, which limits the number of packets that can
> be buffered and can result in reduced performance.
>
> Therefore, if guest GSO is not supported, use the MTU to calculate the
> optimal amount of segments required.
>
> When guest offload is enabled at runtime, RQ already has packets of bytes
> less than 64K. So when packet of 64KB arrives, all the packets of such
> size will be dropped. and RQ is now not usable.
>
> So this means that during set_guest_offloads() phase, RQs have to be
> destroyed and recreated, which requires almost driver reload.
Yes, this needs VIRTIO_F_RING_RESET and disable_vq_and_reset() to be 
done on RQ and refill it with appropriate size of buffer. Not for this 
patch anyway.
>
> If VIRTIO_NET_F_CTRL_GUEST_OFFLOADS has been negotiated, then it should
> always treat them as GSO enabled.
>
> Below is the iperf TCP test results over a Mellanox NIC, using vDPA for
> 1 VQ, queue size 1024, before and after the change, with the iperf
> server running over the virtio-net interface.
>
> MTU(Bytes)/Bandwidth (Gbit/s)
>               Before   After
>    1500        22.5     22.4
>    9000        12.8     25.9
>
> Signed-off-by: Gavin Li<gavinl@nvidia.com>
> Reviewed-by: Gavi Teitz<gavi@nvidia.com>
> Reviewed-by: Parav Pandit<parav@nvidia.com>
> ---
> changelog:
> v1->v2
> - Addressed comments from Jason, Michael, Si-Wei.
> - Remove the flag of guest GSO support, set sg_num for big packets and
>    use it directly
> - Recalculate sg_num for big packets in virtnet_set_guest_offloads
> - Replace the round up algorithm with DIV_ROUND_UP
> ---
>   drivers/net/virtio_net.c | 41 +++++++++++++++++++++++++++-------------
>   1 file changed, 28 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e1904877d461..ec8c135a26d6 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -225,6 +225,9 @@ struct virtnet_info {
>   	/* I like... big packets and I cannot lie! */
>   	bool big_packets;
>   
> +	/* number of sg entries allocated for big packets */
> +	unsigned int big_packets_sg_num;
> +
>   	/* Host will merge rx buffers for big packets (shake it! shake it!) */
>   	bool mergeable_rx_bufs;
>   
> @@ -1331,10 +1334,10 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
>   	char *p;
>   	int i, err, offset;
>   
> -	sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
> +	sg_init_table(rq->sg, vi->big_packets_sg_num + 2);
>   
> -	/* page in rq->sg[MAX_SKB_FRAGS + 1] is list tail */
> -	for (i = MAX_SKB_FRAGS + 1; i > 1; --i) {
> +	/* page in rq->sg[vi->big_packets_sg_num + 1] is list tail */
> +	for (i = vi->big_packets_sg_num + 1; i > 1; --i) {
>   		first = get_a_page(rq, gfp);
>   		if (!first) {
>   			if (list)
> @@ -1365,7 +1368,7 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
>   
>   	/* chain first in list head */
>   	first->private = (unsigned long)list;
> -	err = virtqueue_add_inbuf(rq->vq, rq->sg, MAX_SKB_FRAGS + 2,
> +	err = virtqueue_add_inbuf(rq->vq, rq->sg, vi->big_packets_sg_num + 2,
>   				  first, gfp);
>   	if (err < 0)
>   		give_pages(rq, first);
> @@ -3690,13 +3693,31 @@ static bool virtnet_check_guest_gso(const struct virtnet_info *vi)
>   		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO));
>   }
>   
> +static void virtnet_set_big_packets_fields(struct virtnet_info *vi, const int mtu)
> +{
> +	bool guest_gso = virtnet_check_guest_gso(vi);
> +
> +	/* If we can receive ANY GSO packets, we must allocate large ones. */
> +	if (mtu > ETH_DATA_LEN || guest_gso) {
> +		vi->big_packets = true;
> +		/* if the guest offload is offered by the device, user can modify
> +		 * offload capability. In such posted buffers may short fall of size.
> +		 * Hence allocate for max size.
> +		 */
> +		if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> +			vi->big_packets_sg_num = MAX_SKB_FRAGS;
MAX_SKB_FRAGS is needed when any of the guest_gso capability is offered. 
This is per spec regardless if VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is 
negotiated or not. Quoting spec:

> If VIRTIO_NET_F_MRG_RXBUF is not negotiated:
>
>   * If VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6 or
>     VIRTIO_NET_F_GUEST_UFO are negotiated, the driver SHOULD populate
>     the receive queue(s) with buffers of at least 65562 bytes.
>

I would just simply put:

vi->big_packets_sg_num = guest_gso ? MAX_SKB_FRAGS : DIV_ROUND_UP(mtu, PAGE_SIZE);

There needs to be another patch to address the 
virtnet_set_guest_offloads() case. For now just leave with a TODO 
comment and keep it as-is (don't start with full MAX_SKB_FRAGS segments).
> +		else
> +			vi->big_packets_sg_num = DIV_ROUND_UP(mtu, PAGE_SIZE);
> +	}
> +}
> +
>   static int virtnet_probe(struct virtio_device *vdev)
>   {
>   	int i, err = -ENOMEM;
>   	struct net_device *dev;
>   	struct virtnet_info *vi;
>   	u16 max_queue_pairs;
> -	int mtu;
> +	int mtu = 0;
>   
>   	/* Find if host supports multiqueue/rss virtio_net device */
>   	max_queue_pairs = 1;
> @@ -3784,10 +3805,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>   	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
>   	spin_lock_init(&vi->refill_lock);
>   
> -	/* If we can receive ANY GSO packets, we must allocate large ones. */
> -	if (virtnet_check_guest_gso(vi))
> -		vi->big_packets = true;
> -
>   	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
>   		vi->mergeable_rx_bufs = true;
>   
> @@ -3853,12 +3870,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>   
>   		dev->mtu = mtu;
>   		dev->max_mtu = mtu;
> -
> -		/* TODO: size buffers correctly in this case. */
> -		if (dev->mtu > ETH_DATA_LEN)
> -			vi->big_packets = true;
>   	}
>   
Can we add a comment here to note that this essentially has to be 
dev->max_mtu when F_MTU is negotiated. The implicit assumption of mtu 
being 0 when F_MTU is not negotiated is not so obvious to readers.

Thanks,
-Siwei
> +	virtnet_set_big_packets_fields(vi, mtu);
> +
>   	if (vi->any_header_sg)
>   		dev->needed_headroom = vi->hdr_len;
>   

--------------D0WHH0JdGtzNmlRYGuycaOhH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Sorry for the delay. Didn't notice as this thread was not addressed
    to my work email. Please copy to my work email if it needs my
    immediate attention.<br>
    <br>
    <div class="moz-cite-prefix">On 8/25/2022 5:38 AM, Gavin Li wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220825123840.20239-3-gavinl@nvidia.com">
      <pre class="moz-quote-pre" wrap="">Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
packets even when GUEST_* offloads are not present on the device.
However, if guest GSO is not supported, it would be sufficient to
allocate segments to cover just up the MTU size and no further.
Allocating the maximum amount of segments results in a large waste of
buffer space in the queue, which limits the number of packets that can
be buffered and can result in reduced performance.

Therefore, if guest GSO is not supported, use the MTU to calculate the
optimal amount of segments required.

When guest offload is enabled at runtime, RQ already has packets of bytes
less than 64K. So when packet of 64KB arrives, all the packets of such
size will be dropped. and RQ is now not usable.

So this means that during set_guest_offloads() phase, RQs have to be
destroyed and recreated, which requires almost driver reload.</pre>
    </blockquote>
    Yes, this needs VIRTIO_F_RING_RESET and disable_vq_and_reset() to be
    done on RQ and refill it with appropriate size of buffer. Not for
    this patch anyway.<br>
    <blockquote type="cite" cite="mid:20220825123840.20239-3-gavinl@nvidia.com">
      <pre class="moz-quote-pre" wrap="">

If VIRTIO_NET_F_CTRL_GUEST_OFFLOADS has been negotiated, then it should
always treat them as GSO enabled.

Below is the iperf TCP test results over a Mellanox NIC, using vDPA for
1 VQ, queue size 1024, before and after the change, with the iperf
server running over the virtio-net interface.

MTU(Bytes)/Bandwidth (Gbit/s)
             Before   After
  1500        22.5     22.4
  9000        12.8     25.9

Signed-off-by: Gavin Li <a class="moz-txt-link-rfc2396E" href="mailto:gavinl@nvidia.com">&lt;gavinl@nvidia.com&gt;</a>
Reviewed-by: Gavi Teitz <a class="moz-txt-link-rfc2396E" href="mailto:gavi@nvidia.com">&lt;gavi@nvidia.com&gt;</a>
Reviewed-by: Parav Pandit <a class="moz-txt-link-rfc2396E" href="mailto:parav@nvidia.com">&lt;parav@nvidia.com&gt;</a>
---
changelog:
v1-&gt;v2
- Addressed comments from Jason, Michael, Si-Wei.
- Remove the flag of guest GSO support, set sg_num for big packets and
  use it directly
- Recalculate sg_num for big packets in virtnet_set_guest_offloads
- Replace the round up algorithm with DIV_ROUND_UP
---
 drivers/net/virtio_net.c | 41 +++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e1904877d461..ec8c135a26d6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -225,6 +225,9 @@ struct virtnet_info {
 	/* I like... big packets and I cannot lie! */
 	bool big_packets;
 
+	/* number of sg entries allocated for big packets */
+	unsigned int big_packets_sg_num;
+
 	/* Host will merge rx buffers for big packets (shake it! shake it!) */
 	bool mergeable_rx_bufs;
 
@@ -1331,10 +1334,10 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
 	char *p;
 	int i, err, offset;
 
-	sg_init_table(rq-&gt;sg, MAX_SKB_FRAGS + 2);
+	sg_init_table(rq-&gt;sg, vi-&gt;big_packets_sg_num + 2);
 
-	/* page in rq-&gt;sg[MAX_SKB_FRAGS + 1] is list tail */
-	for (i = MAX_SKB_FRAGS + 1; i &gt; 1; --i) {
+	/* page in rq-&gt;sg[vi-&gt;big_packets_sg_num + 1] is list tail */
+	for (i = vi-&gt;big_packets_sg_num + 1; i &gt; 1; --i) {
 		first = get_a_page(rq, gfp);
 		if (!first) {
 			if (list)
@@ -1365,7 +1368,7 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
 
 	/* chain first in list head */
 	first-&gt;private = (unsigned long)list;
-	err = virtqueue_add_inbuf(rq-&gt;vq, rq-&gt;sg, MAX_SKB_FRAGS + 2,
+	err = virtqueue_add_inbuf(rq-&gt;vq, rq-&gt;sg, vi-&gt;big_packets_sg_num + 2,
 				  first, gfp);
 	if (err &lt; 0)
 		give_pages(rq, first);
@@ -3690,13 +3693,31 @@ static bool virtnet_check_guest_gso(const struct virtnet_info *vi)
 		virtio_has_feature(vi-&gt;vdev, VIRTIO_NET_F_GUEST_UFO));
 }
 
+static void virtnet_set_big_packets_fields(struct virtnet_info *vi, const int mtu)
+{
+	bool guest_gso = virtnet_check_guest_gso(vi);
+
+	/* If we can receive ANY GSO packets, we must allocate large ones. */
+	if (mtu &gt; ETH_DATA_LEN || guest_gso) {
+		vi-&gt;big_packets = true;
+		/* if the guest offload is offered by the device, user can modify
+		 * offload capability. In such posted buffers may short fall of size.
+		 * Hence allocate for max size.
+		 */
+		if (virtio_has_feature(vi-&gt;vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
+			vi-&gt;big_packets_sg_num = MAX_SKB_FRAGS;</pre>
    </blockquote>
    MAX_SKB_FRAGS is needed when any of the guest_gso capability is
    offered. This is per spec regardless if
    VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is negotiated or not. Quoting spec:<br>
    <br>
    <blockquote type="cite"><span style="color: rgb(0, 0, 0);
        font-family: Arial, Helvetica, sans-serif; font-size: 13.3333px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        normal; orphans: 2; text-align: left; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        text-decoration-thickness: initial; text-decoration-style:
        initial; text-decoration-color: initial; display: inline
        !important; float: none;">If VIRTIO_NET_F_MRG_RXBUF is not
        negotiated:</span>
      <ul class="itemize2" style="color: rgb(0, 0, 0); font-family:
        Arial, Helvetica, sans-serif; font-size: 13.3333px; font-style:
        normal; font-variant-ligatures: normal; font-variant-caps:
        normal; font-weight: 400; letter-spacing: normal; orphans: 2;
        text-align: left; text-indent: 0px; text-transform: none;
        white-space: normal; widows: 2; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial;">
        <li class="itemize">If VIRTIO_NET_F_GUEST_TSO4,
          VIRTIO_NET_F_GUEST_TSO6 or VIRTIO_NET_F_GUEST_UFO are
          negotiated, the driver SHOULD populate the receive queue(s)
          with buffers of at least 65562 bytes.</li>
      </ul>
    </blockquote>
    <br>
    I would just simply put:<br>
    <pre class="moz-quote-pre" wrap="">vi-&gt;big_packets_sg_num = guest_gso ? MAX_SKB_FRAGS : DIV_ROUND_UP(mtu, PAGE_SIZE);

</pre>
    There needs to be another patch to address the
    virtnet_set_guest_offloads() case.
    For now just leave with a TODO comment and keep it as-is (don't
    start with full MAX_SKB_FRAGS segments). <br>
    <blockquote type="cite" cite="mid:20220825123840.20239-3-gavinl@nvidia.com">
      <pre class="moz-quote-pre" wrap="">
+		else
+			vi-&gt;big_packets_sg_num = DIV_ROUND_UP(mtu, PAGE_SIZE);
+	}
+}
+
 static int virtnet_probe(struct virtio_device *vdev)
 {
 	int i, err = -ENOMEM;
 	struct net_device *dev;
 	struct virtnet_info *vi;
 	u16 max_queue_pairs;
-	int mtu;
+	int mtu = 0;
 
 	/* Find if host supports multiqueue/rss virtio_net device */
 	max_queue_pairs = 1;
@@ -3784,10 +3805,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	INIT_WORK(&amp;vi-&gt;config_work, virtnet_config_changed_work);
 	spin_lock_init(&amp;vi-&gt;refill_lock);
 
-	/* If we can receive ANY GSO packets, we must allocate large ones. */
-	if (virtnet_check_guest_gso(vi))
-		vi-&gt;big_packets = true;
-
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
 		vi-&gt;mergeable_rx_bufs = true;
 
@@ -3853,12 +3870,10 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 		dev-&gt;mtu = mtu;
 		dev-&gt;max_mtu = mtu;
-
-		/* TODO: size buffers correctly in this case. */
-		if (dev-&gt;mtu &gt; ETH_DATA_LEN)
-			vi-&gt;big_packets = true;
 	}
 </pre>
    </blockquote>
    Can we add a comment here to note that this essentially has to be
    dev-&gt;max_mtu when F_MTU is negotiated. The implicit assumption of
    mtu being 0 when F_MTU is not negotiated is not so obvious to
    readers.<br>
    <br>
    Thanks,<br>
    -Siwei<br>
    <blockquote type="cite" cite="mid:20220825123840.20239-3-gavinl@nvidia.com">
      <pre class="moz-quote-pre" wrap="">
+	virtnet_set_big_packets_fields(vi, mtu);
+
 	if (vi-&gt;any_header_sg)
 		dev-&gt;needed_headroom = vi-&gt;hdr_len;
 
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------D0WHH0JdGtzNmlRYGuycaOhH--

--===============2884339845796556620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2884339845796556620==--
