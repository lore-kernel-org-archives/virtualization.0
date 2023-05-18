Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3720C77B7A
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 01:02:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5F4E541C70;
	Thu, 18 May 2023 01:02:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5F4E541C70
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=ex1mbMSI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=MSUy6aAN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0P1xSJYA7wCe; Thu, 18 May 2023 01:02:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E12A74010F;
	Thu, 18 May 2023 01:02:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E12A74010F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEDF3C0037;
	Thu, 18 May 2023 01:02:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DADF3C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 01:02:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9DB88416D8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 01:02:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9DB88416D8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=ex1mbMSI; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=MSUy6aAN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SbYRW_HGmPGU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 01:02:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 796C9400ED
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 796C9400ED
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 01:02:05 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34HIGm61024473; Thu, 18 May 2023 01:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HBAWJ8shORXuyQLGZiBknHOhUsjawMieK2cKLGXgtVU=;
 b=ex1mbMSIGii/ziPiFsi3xoM3nprOvNCWe7B/UNOU4/60+3wncsWDh3uSGOc5is0c1ToO
 +efQyfxEjt17rKlaLiqOEV/AV8k+v7mRmiWM9/WEaOZlTLDdl+wpkkfaLcPv0P3RS/Ld
 UxT5Rveq0pdBGVPHJ7/2x/A52obOKI9P/wI2ou73M5YbvkVQvRE52wzbYEupBbWqNjXa
 ardKjQSroWpWCjV0PUcuy6MjWALMtsFejIDhl7MPStkOn8pBU1IoZShIE9BxyZa3wZsw
 VtOENaFpZbC5b4ApG12ln7jvmENWP2Yt2QoEqk2/5Bs/qxeUFG1GSQsywQa1XftgrbaC fQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxwphf4y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 May 2023 01:01:53 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34I0TLKq036376; Thu, 18 May 2023 01:01:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3qmm0354fs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 May 2023 01:01:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwTo4Hq2PADBBGp2X+qWVo8IREB7iRzPstS7gudoM2lkZ3IYpsQOPJ5FHBke/fuVSTcTqRFjX7/Bd1RZ4Bkufc8I018RTTX046EgPpMzKZtF4laDaY1mllD6DAQdZEB1+no+63DAtE4QkrMYLP5WHAZndFuWwnBieMHeRR9tUons+WfMmRq5reY+WibPXQecE0ErrkjfvlKu+tLz/dStWJLkmJfQkjP1fkFRl6nGa8/wdZEGdSE8g4oZskTJDNT+/e0wY7dVsUZI2EffhNHLJEujSupiNTiGvuPUGN8kAUgkMRcRi9TTPM0IFEB5zivYXt9m7VI15t9NUljQsaJ/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBAWJ8shORXuyQLGZiBknHOhUsjawMieK2cKLGXgtVU=;
 b=F+cU4esZ5yYSmLqmgbTBp/SZWH3svRRYDwGydysdrcmw0m4zX3P1hEA1yEw+7DhVbthAtaHsTcs0Fi9NeMrbjUpNAhkL6mDJk0LPRJvx7SQBM8uwmpXrPQpHR8CD1HG2sViELyMEQ+MFW8zojKjWGsQTE3yLKMsZFYzZmqa54gYsXfL7UDgWAZ0zhvJvnp8S5ikB6VgBmHuyzgX0Fh+ArbNm52LE1bdTrK4nkFK5EK2P9XwtyE1Qrv+2U9Fq2jmYT7JpWPvVil/EMju1+aaSRbed/3cvpa1VN0TLigiF1thrZOn0maZDnGzWwvzKo6baWyMPze3qFRg/l10LjvXr2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBAWJ8shORXuyQLGZiBknHOhUsjawMieK2cKLGXgtVU=;
 b=MSUy6aANrec4vhuSGkHim+jBsXYGQvHvpG7UAhMPs8GcId2oBpnkM7h3GwIA82ltcSnD0eu3XQvbEinH8XgxVa9RFn9wjRPuddQeAoLdoHmBePbTgoJym0gfUv2SGzuBmC/UKlfbpChmAIJgdl+03w9TWKTHaIwDvJv2L/btUSI=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by LV3PR10MB7818.namprd10.prod.outlook.com (2603:10b6:408:1bb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 01:01:49 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 01:01:49 +0000
Message-ID: <3c2adf29-c201-9534-cc07-d35c4dead948@oracle.com>
Date: Wed, 17 May 2023 20:01:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC PATCH 2/8] vhost/vhost_task: Hook vhost layer into signal
 handler
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-3-michael.christie@oracle.com>
 <CAHk-=wga+96PqV4x8EwFAMfi--m9essdX+3uPE-AoOSAQR1ddA@mail.gmail.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CAHk-=wga+96PqV4x8EwFAMfi--m9essdX+3uPE-AoOSAQR1ddA@mail.gmail.com>
X-ClientProxiedBy: DS7PR03CA0265.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::30) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|LV3PR10MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2089bf-aa9f-404d-1aac-08db573b7597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Wf5DDKJ4P6DxkcxLY1IlSkfTKn99mDgKhen4cYpOuK0BfiILhlij9vnhRFsPNMMPuWRjtcv6J9DNcIX83yp4UHdEt5YGDGzzz7OfrluTSe+aVquJhAZzQylJeoA9W/C2lob5gHuBBTQgZmA1l2KIxcBiuzu2DTETeO9y+dir251OE4gPaUZcPPnE5OWvw77TfBF+jqa6x/oHSRwYwHtxDsFnV8+qT7GmLrWl3aPnx42JQ4bMQMPGSxNkVFIpwcVSpmLtvrjvZNzMO4WAfnqYk0FmyxuziFmLunLQCc2uGKRpkZsp9oDMKgh2yvPPc05jJTl5LuEIHjOceZ5e22iZxTjHSht/7sToo5IW4kPAuDq5UVsk9NBxHpnJQnUaeATdfoKf2+cdKAADEXLegHTyNCNVNWwD00OQLHl7N34H8fE1gMFrH7UG1M/YjG0tjU4GtMZM95vZlWht/otMit4O9j0GZd9+ZtYw6hFf9YY6e6VQXnK8++jNFdr36JotRyXgJVRibicEdEtZzN/6qOkIbfK2+1SwCdpV9ZqEJN7VzAT90Hcd9NHffYsWi/EV9zWuaxaNsLLcek3nMlRBJfwKb/JRJ0mM7fwH9HVomoZhvYTU4k5PDormZWJl+Hk0oDmzl2F00vYII/lv12bvfv55w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199021)(31696002)(41300700001)(86362001)(31686004)(316002)(5660300002)(7416002)(38100700002)(4744005)(478600001)(2906002)(66946007)(8676002)(6916009)(66556008)(8936002)(66476007)(4326008)(6486002)(36756003)(6666004)(6506007)(26005)(6512007)(186003)(53546011)(2616005)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlJnU0hTd2JYWkVJVnFlUHNJeS83MTFrd2RJTVVjbWViQXZaSUdKSkVWeDlT?=
 =?utf-8?B?RTNoQ0syOTBETmpZZUV1U2NjektVSnFNNGxQZGYwdGRON2R1RGZVT3d2bjdn?=
 =?utf-8?B?WWl2R3gvdkZmSCsvNWY5dzROL3R2eTVlLzNvV2lvSEZMeEtqQjdwNjRHN3Uv?=
 =?utf-8?B?c1l1a3pRK2Q0NWw4VnhkT3lzYTNBaU0vMnhLamF5eDh0VG9zQkc0SzJqSDFV?=
 =?utf-8?B?OHM4SFBXeEdvSGQyU3RMTWhjOHAwSTNsbmI2STFiTUhZWW56a3hocDNVc3FF?=
 =?utf-8?B?U1FOQlgvM0cwOUQvNEpqL3NsV3FZSVltbk02OEZhZGxUYSs0L0QvQi9UajY1?=
 =?utf-8?B?S3pFQkEvL1cyODN6STJEMEdKTDduYndaMkFKUFh6Q3dQME5iUGc1cUpvVmVP?=
 =?utf-8?B?RDNzaTh2bk5WYjFCT29rTnVLbS9MU1NOR2V4SWkxa094Z3Y3Z1JrRnJVUE5p?=
 =?utf-8?B?VjJKMktwcDgyRDh1TVFxZldMSmh0TGUvaVNSYUpXZ0FaTEt1QStwR0RaVUtY?=
 =?utf-8?B?QXFGUDVYZC95aGx6R3lWMXhjYlFHVTkyLzFYei9DYUhmcytCT2x1Sk5PVlNs?=
 =?utf-8?B?bWJ4akZUL1VSWnpPdGRTNGRDaXFWbVdKOXhKc3VBM2YraitZNkNSaVU1T21o?=
 =?utf-8?B?UDBDamxDS3laTzIvVXF5b2p4eHZveFhOWFcrbC9iSkFrWjNmQzNQenlocWgw?=
 =?utf-8?B?QkNZR0l2cXUzNHh6N0YyV29QN0FNcnB2Z2dkTzNaMGM3UlEvc2ZVU3RSRnVY?=
 =?utf-8?B?VCtJZTMyUXVKbzN6em5XVktnQmhKUUFHRkRzVFhISUhJcjBTTXViN0R2ZE1u?=
 =?utf-8?B?WERwWFFTUHg3a1NqMXNlSUcybXFDV2hrbDJRRmN3elRvQmM5YWM3TklPUVJS?=
 =?utf-8?B?ZXpJVnVYWmtoRnBtcC9qM2pNaXZxTmZrb2ZrS3oyeEVPK1FNN3pqZVNLQW1m?=
 =?utf-8?B?K2RUTGV0a1dUSEJFRVoreG1oOWZXMjdYMDZ6VGFkOTBRYUk4V2x6VjhpRGdT?=
 =?utf-8?B?Nk5Md3BGUWlieDZ6Ymh4N0x3NnhUOTJlNUtiSTFRdkxPTFk1cHNvcG9DRHFy?=
 =?utf-8?B?c0xpb0dzcTBJT0NIb2xwK25aZkVWMkZhNE1LcEk0ejNFbExlZGljWTFZS2s0?=
 =?utf-8?B?N1ZJTWsxUXFKNmI4Si81T05HYWJGdlhWcnJnUmRpMEFDM2h1bFZneGUvbFFR?=
 =?utf-8?B?QnJ0S05WVVBMUUNDVnpteVRxRk5PM0Q0TUNBOVdPK2dPbnVlb3Ivc0V2Yy90?=
 =?utf-8?B?Rk8rbnk5NTRHYW8wN3hmaUtzRmZUUTJVYTM5VTBjd1ZZWHZBRUJ6Q3dlSUQ2?=
 =?utf-8?B?UWRrNFZKcXgwemJuQ3pPU2h3eUJzSGF6VzN3YnNHbGw2N3VqWVRTbWMzL3Rl?=
 =?utf-8?B?KzB6amhkd2RudC8yMWNFSVZZcHdMT2lPaTF5SUpCWUNnQnpoZHlsa2lMSUhH?=
 =?utf-8?B?RUFaRy83ZjV2YmJmYlRVN2NIUC8rWWhMQmpvZEdvZlZFZktzRzBuZ0RLZTNx?=
 =?utf-8?B?N3NxTHBMRUlCME10YUg3aWc0TVk1aFZ0MlVaSi9jT2hEN2lITVFRRG1ZM3lC?=
 =?utf-8?B?dW1RV0xCMHhhT0Q1bExqR0I4VzB6ak1vWFZ2ZklsaEpiZmxoTXJ2NjhodWQv?=
 =?utf-8?B?dlU2VUw5Y2tiS1M3RnVITERSZVhha0VKNHZsQzVmZVpCKyt5TTZ6MHhKclVz?=
 =?utf-8?B?K3BCc1hIVG9LUGxzWGVQNEFaaEVPWXUyaDJhVzF0NzNnVis0Nk1ranVCT2xz?=
 =?utf-8?B?UWNsekdIQU55Z2hLUUdUODJOM3F1cllqM0dXVVIrVDZnZ3N0YXU2Y0dFclVz?=
 =?utf-8?B?bVgrbG5PR3BnUlFpM2ZkUGRBU3dCTVhHcWlqb0kyNWZwdEdUZ1dGZERpaEta?=
 =?utf-8?B?Rm8vcDJJNUFESkJUdzZQa3NMVXlJWHl5a2xBdmZzejgrYTE3bW1IQkQwWjR3?=
 =?utf-8?B?bHBES1dXbUo2a0N1eFRjckRXMGRIZC9KS0tpaG51MW12NWVpYTZwMXJUbjVS?=
 =?utf-8?B?UE1US1VRRjJYM1JOdDl2U1puN3JyTmZLTkR5N1dJeEU1RTR4MitIV1RVbi9m?=
 =?utf-8?B?RWF1S1hNQ0t1U2tPV255OVNkUHZPRy9jR3RhNnNoN1pGSm1sTGkxdVlYU2Va?=
 =?utf-8?B?a3RDOEsvdnFtK2JDK3VIT1J2ejZBbW82SWMweFFSVjdSYnJrdWRHRm92N1Yz?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Zi9NVE1kVkhLVVNRWmxUMDJCTzBHbko1QzZkSDZPK29wWGpMMWE0L2k4Y01s?=
 =?utf-8?B?MVlSQnVCZGVqS2RTdnoyRnJVYndCZlIzUXhUemYyWHZBQ2F1dHhJeVlacjdi?=
 =?utf-8?B?dWx5cHViUDNxVVA3T0grTi83b1VOMHJuNHdQaWxBeVVUUWE3SmVaalcva25l?=
 =?utf-8?B?cm15NmZ6NkJ3Uk1yRG1DNDMrKytZK0lkeUJpM2UzcmRFRW9mMFpQNm1mYkpw?=
 =?utf-8?B?L1Y3YUNmcTBRNXcxVjkxdDd2UHF4SmtiKzNuQTh2UGNGc0ZMVVZMdGN4VGUx?=
 =?utf-8?B?SUdCMVkxR3ZEeTBUZzE1OFlsN2NKZjlTVTJ4eHFFcTAzNWZBQ2pSUTR6SDA5?=
 =?utf-8?B?RzV3RUN1L2REQ1lxZmZ1Q1FYcUhIK0Q0MVByZE9vVW5XMnl3WndWYlR3RTRS?=
 =?utf-8?B?MENwZmxQcFpDZ1JGQ1NoZW1MeTRSOXNJb2phb25IU3R4d0N3b2dhV3UybE5J?=
 =?utf-8?B?NkNwdHlIZDgyei9SL215cXFrWlZEWDNtbEhtcXcxOXFzbTY1SjFEWW1xTkVO?=
 =?utf-8?B?YmFCVFYxWHUrWkJsNTRVSGkyVFR0Q2w5QVlzR0JJY2tEdDd0dmNTR2ZvY2xQ?=
 =?utf-8?B?SHNibUZVVkFiVWtQSXRxbkEzb3VyRmtUdjBaeVNSc1JORVNxNW8yNGcxQit0?=
 =?utf-8?B?YUp2ZWJpbkdtaFk0WDF0MUdyeTZWclFnbnk2ZXZyV2t1MS9hYUVlREJocnFw?=
 =?utf-8?B?SnN6Z2I5Yys3T2lNRG42NXJDb2ZwSE9GV2hyQk5KNDI4VDNsdUxXRWRHWWVW?=
 =?utf-8?B?NkdpdFNMeXRrZGdkZDFha2V4MmJyR1dURTZKdGJDZEtBVHBGR09WbW1qaVF6?=
 =?utf-8?B?ckZpOWpkeU5pU0RuR1NyN3paZXBEQ2lEdU5rYXRFWi9lQjBYY1RMRGFzSzZS?=
 =?utf-8?B?NkpHa2tQM2RrSkZUTWNQTmN3TjVzTGJhVEdXMmx1VElZS3hxQTN0VndlUWl4?=
 =?utf-8?B?MnZoNDZvbEpYK1NPWWZDT01zTlBTNUsrMmNKODFEYmxWRGNyc0V1Y2lpWFNz?=
 =?utf-8?B?emVIQXNLTzlER3ZNdUhjTjlHbysrTnYrWkZmZ1QvcGVvdEhRcEU2MzdkVHAr?=
 =?utf-8?B?TzNOdmpKQ1JCd0dlUlgvVENNelVHVWhuTTc0Tmp0RFhmQXNyNlMvZEhKQ2RL?=
 =?utf-8?B?MUl4aDdOdy92NzFiT2VOaVBQZWRLTERQeG5NYk9iUkVMU0Y5ZUhXZThNaXlh?=
 =?utf-8?B?MTN3YmNqVjA1T2FqbzA3UCtKMXR4QVVhUHlDREdpcTNLUlgzYXM3TTdjb1g1?=
 =?utf-8?B?NENzc0xjTXd4VjRHYmJVY25XK21xblhDdWV0MUVFSWp1K28vZ0pJMllMRC9p?=
 =?utf-8?B?VlJNRUtIcFgxQUJkVXo5TVVVbEpIekJxZkxBSmlVYkF5YlNUL3RncTFqNTBY?=
 =?utf-8?B?ZFE1dGNYUW5VUnd2emwzRnZSR3B2ZzVGVnEvOEhvZkQ1M210azFENHRRUlNN?=
 =?utf-8?Q?XqtG72BD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2089bf-aa9f-404d-1aac-08db573b7597
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 01:01:49.4859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxYORe3PQP/6c1cwXodfTfEMO8v1vR/H5hKdJ/EYlpwGBJB/n96ej8SvMXER2bc56wF/Iy/hTmV88eZNtKgPKaNkGBNctpu6A5NZa2KoQuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7818
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_05,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180003
X-Proofpoint-GUID: GXdAE0ttNmAzCeS7YAsPvyLQBPJ5Gxbb
X-Proofpoint-ORIG-GUID: GXdAE0ttNmAzCeS7YAsPvyLQBPJ5Gxbb
Cc: axboe@kernel.dk, brauner@kernel.org, mst@redhat.com,
 linux-kernel@vger.kernel.org, oleg@redhat.com, ebiederm@xmission.com,
 stefanha@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
 virtualization@lists.linux-foundation.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gNS8xNy8yMyA3OjE2IFBNLCBMaW51cyBUb3J2YWxkcyB3cm90ZToKPiBPbiBXZWQsIE1heSAx
NywgMjAyMyBhdCA1OjA54oCvUE0gTWlrZSBDaHJpc3RpZQo+IDxtaWNoYWVsLmNocmlzdGllQG9y
YWNsZS5jb20+IHdyb3RlOgo+Pgo+PiArICAgICAgIF9fc2V0X2N1cnJlbnRfc3RhdGUoVEFTS19S
VU5OSU5HKTsKPj4gKyAgICAgICByYyA9IGdldF9zaWduYWwoJmtzaWcpOwo+PiArICAgICAgIHNl
dF9jdXJyZW50X3N0YXRlKFRBU0tfSU5URVJSVVBUSUJMRSk7Cj4+ICsgICAgICAgcmV0dXJuIHJj
Owo+IAo+IFRoZSBnYW1lcyB3aXRoIGN1cnJlbnRfc3RhdGUgc2VlbSBub25zZW5zaWNhbC4KPiAK
PiBXaGF0IGFyZSB0aGV5IGFsbCBhYm91dD8gZ2V0X3NpZ25hbCgpIHNob3VsZG4ndCBjYXJlLCBh
bmQgbm8gb3RoZXIKPiBjYWxsZXIgZG9lcyB0aGlzIHRoaW5nLiBUaGlzIGp1c3Qgc2VlbXMgY29t
cGxldGVseSByYW5kb20uCgpTb3JyeS4gSXQncyBhIGxlZnRvdmVyLgoKSSB3YXMgb3JpZ2luYWxs
eSBjYWxsaW5nIHRoaXMgZnJvbSB2aG9zdF90YXNrX3Nob3VsZF9zdG9wIHdoZXJlIGJlZm9yZQpj
YWxsaW5nIHRoYXQgZnVuY3Rpb24gd2UgZG8gYToKCnNldF9jdXJyZW50X3N0YXRlKFRBU0tfSU5U
RVJSVVBUSUJMRSk7CgpTbywgSSB3YXMgaGl0dGluZyBnZXRfc2lnbmFsLT50cnlfdG9fZnJlZXpl
LT5taWdodF9zbGVlcC0+X19taWdodF9zbGVlcAphbmQgd2FzIGdldHRpbmcgdGhlICJkbyBub3Qg
Y2FsbCBibG9ja2luZyBvcHMgd2hlbiAhVEFTS19SVU5OSU5HIgp3YXJuaW5ncy4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
