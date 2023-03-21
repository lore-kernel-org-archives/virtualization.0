Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7D6C6FD1D
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 23:33:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C8DC040CA6;
	Tue, 21 Mar 2023 23:33:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C8DC040CA6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=A+0tCaxc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=SXW8JnAU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JxorovxDgEkF; Tue, 21 Mar 2023 23:33:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1BFA3405D3;
	Tue, 21 Mar 2023 23:33:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1BFA3405D3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFBB8C0071;
	Tue, 21 Mar 2023 23:33:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E4E8C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 23:33:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 58CD3405D3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 23:33:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 58CD3405D3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4sXflC4zH3S2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 23:33:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 281DB4032C
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 281DB4032C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 23:33:27 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32LKxTGq001463; Tue, 21 Mar 2023 23:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2W7a32XUejWY1JNR0Y5r8tc+9lM/U9KHCCIeutSkP+E=;
 b=A+0tCaxcUOH4oK8mywPJEBDfueYaBn2LVBNzvnNpiiKsWUHH6HHlfxYYiM5TcD/bjsEq
 qANREGxFnZRKbRYCWhPSOmnjafCGelXBw5d0Tq2zqoZonDq5DLIyv4NOX9CdRMY5w/Cz
 ZUMPT1Zz2WLJgqGBNpRVPLRfDzVcINyu1DiopvpVN2K+97OCicLh/aQt+plwfs4YubEH
 WP7CNY7fNUt50q79JSi7Cj5bsAH2/O0Ce88EvX2cwVT0tHA+76U6gst292nrX8LV1/Cu
 dE+KYwCrfYOncXCGrz2R8R/CQwQr82gJxUFXauOn2tCp4RhhPL+wjDv/04SDXcuAd9Xj Pw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd5uufjfp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Mar 2023 23:33:26 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 32LMnF0I016838; Tue, 21 Mar 2023 23:33:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3pfnq5h93p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Mar 2023 23:33:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ku1GwNTL+gWRLWSG1XVKHnzKc718vdYQqFMdmZFSP7RTNVF4w2Jgn+2vl7dx5Upk0PmR4xWoxvbNfA1OfSWKfaRQlbJNmn+2Z+h344suwU8cYB4B5nALCf2YiQBylzVWknEi5OSkBKwJfkuUNSU6EALF8BEcNUQmNrj8/1zHRRqoMnWcCqynvflwVLaqsQlN3s2OTG4CP8Qwy5599Ghw1F6IT33Y30jdLRcPA+mZE7xr/z1woBXa95Bq8HlMl2EcdeVjX4a9P+aQtIplviPmEmzO+t+03dz+QQb9gfc1eO4yQL8MPOPmNP7IdgSOqCmn0vk6UtJL9i+jv89JJDUERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2W7a32XUejWY1JNR0Y5r8tc+9lM/U9KHCCIeutSkP+E=;
 b=WBxkoW4HXu4hHU2eb7BaFFKRidIcBfV58hm1JUN+S9RgCl6+waAUfHyqDMIPkGbWppoUHsgX2l8vxuiU3PSq8selFIs4q3CnsMJH7BktXGVT6O1qKXAioazdpkygQI0ybsK5n9YpaSIPnGFkzRH9ZaOtlWhLZ/Kxr8luLRBymsdhR+XLWZSTo7PckCvxRDE/h/fDAMFf1UiUY1SSddfdGkqLIWXYFxhnvNIcptca8gfWgVC+2QrB4TnGntAvxJ6uIYIPs3CMAANuu/7trkFmdDP40egx0qLK03REMqBybzPvzh0XB/lUSLCF/NYEkRxJQEFSh2bPUeEr1LgS2C2Q/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W7a32XUejWY1JNR0Y5r8tc+9lM/U9KHCCIeutSkP+E=;
 b=SXW8JnAU187P5ZUd1vijnzjFgFDx/qWk+RytYTmw9Ibb0slUVK5UEc06p3PeZOGCTAfSqQpBdfRcNcKaK9TJdI1+IA2zS8FrPiqAYViu9cIdbNT1R4jG6kM6WKwvV3HOV7QuA+p5ceNHqa7AthBeyTqGTcTC1llJJmQKXQ/Ajig=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by PH8PR10MB6412.namprd10.prod.outlook.com (2603:10b6:510:1c7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 23:33:14 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3%9]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 23:33:14 +0000
Message-ID: <f224d441-72b7-5812-5af5-e6ad520ddea5@oracle.com>
Date: Tue, 21 Mar 2023 16:33:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 1/2] vdpa/mlx5: Make VIRTIO_NET_F_MRG_RXBUF off by
 default
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 eperezma@redhat.com, virtualization@lists.linux-foundation.org
References: <20230321112809.221432-1-elic@nvidia.com>
 <20230321112809.221432-2-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230321112809.221432-2-elic@nvidia.com>
X-ClientProxiedBy: SN6PR16CA0051.namprd16.prod.outlook.com
 (2603:10b6:805:ca::28) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH8PR10MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: d96393a3-56dd-4bb1-7572-08db2a64a426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHLEhDseOHMd7oewGVQzW3jWRDzCPpesfO+/S3JKKRPaabx+Ipim7nNawK/53O+uP2NWpUjLb8fWJOA92nP8hy2A64k++cVvFR+84K2IEcr9IXWvuWpGbK+1VvwBtENQU6XCEHzluq0kO/zbzqXgr1BUGOJgYtolTZ8o69LUSu0ae4GiI7tRfmxZlcEyHzfVW9jR2aXMwCBO30sESb7uQ1DqCMhsO1QPrCpMgm032km/h1FxgWE2NsLJyh8axiwnfZ0LEqeFvg+/xnLVR5VslyQtDBqHP3tfrvXNLbv7/hBkWeyTHzmjSa+Ht1dDpiJpCpAiM7wP2MAphWpoKkv5JKus742gn2qedV6zCd9EtbH5JpxBbEyW8iPE0b+Q4x0Z1bSEnXF3VXTEylt4B2DN1SQ+IK+Mj8AjRZ30rzlYGTkD/N9wGOnF8ydKQCK7KeaOiUL/p0dCVawXh+SMYj3mwBvF6C/KgUtcfMKuO6PYZtXFDNeDBqBhw6G/wx03SnmduS6e7AmP3FbpP6Il2oRQPWnaxxkXSC7G9vqnMsumRc0TFwHzGUXP1TTGqyob7UK5RUjhRLQaDjgmf7JKZsCZs2jYy+7ACxr3+eQMjw+OdeiDZHJjTk1ZHljEUQBwVoWe2Uq4ElRsVkyntAzWigZUe01yDNIYFmmTkjb3PpXdehssHKM29B2tFYd+lqAUFMTmVqxsXMk/MleR4sPvmZM0Sfe0YPL8bmEyZk09MO2DW78=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199018)(316002)(478600001)(36756003)(31686004)(6506007)(36916002)(6512007)(26005)(53546011)(6486002)(8676002)(4326008)(66556008)(66476007)(66946007)(83380400001)(2906002)(31696002)(86362001)(2616005)(41300700001)(186003)(38100700002)(6666004)(8936002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmVWaUc1WExHVmNMR3Y3Ujl6NnBxeG04NEFKUTByRW1PWkNEdjF2R2V2N2ND?=
 =?utf-8?B?RzRKMFZOMjNURzJIZk5DYi9CZlZyMU53TU9Yc242TGhqZHNRRmN2LzNoTlNr?=
 =?utf-8?B?NWZWZTFtMTJ0WmI5K3B5TlF5R3NJWVFRQkg5cmxvWHkxc3VDUGlaYTRFUFll?=
 =?utf-8?B?bjdVa0ZjaHFTQ1RUeFRSMTVxWFczaE5TekFsVUthaDk2UTJEaVZ2UmxmWmZo?=
 =?utf-8?B?Z2EzSExTYll2RFhXK1BMSC9janliMEpGYWVoc0dSTndzcldxaXdGNU8rVGFM?=
 =?utf-8?B?MWFYWmY4cUVYdlF0Y24wMUt2Q1hTZlhHM1E5MFkvWDF1RGxaMEg5ZEx4b2Zs?=
 =?utf-8?B?T3JPQmtvaVB0SGVQZCtxWUNNeFVIMWVPcCtzSSs4VkVpaFZoc1BleE5ta0E0?=
 =?utf-8?B?ZDB0ZGRQUVNQV04wQTRtTzhwYjhLWWhqa1NnTnRoK2pRUVpPZnVQOUxSeGtu?=
 =?utf-8?B?bXdGM0FyWWp1MlVrZzRWRWxES3Y1d2NkZXFTZFMvK0xYQlJmd0lvTWk1WGdH?=
 =?utf-8?B?TlkvbGw4alBmeEFoeGEzUjNKb051TCtTNktON3Q2T3lEQmR1V0hQN2YwTjZp?=
 =?utf-8?B?TXFTUUVBTmpBWmdtOFpDMkEzZ2ZHYndWTEp5RGxXYWNrQWtIYis4cFBZM1ZG?=
 =?utf-8?B?Si9ubllqMEhMVi9IbTNmOUlsSDRvVExIQUZXNTI5Y0d4cmgyOEM5UTVNZHJn?=
 =?utf-8?B?Ykw4TUpXTUU0TkhKNFdvblhSb2pyY3pDMUdRZWlCTSt4TjhPTjlOMGdRTzV4?=
 =?utf-8?B?TnJIaFFqNTg4UTIvZ0V0bElVNHByeTN1djZmb3VlUldKeURGUGtKS0tmNEF1?=
 =?utf-8?B?NXdxR2pRSXVoNmhOdWpTb0QrMTBqam9nZ0RBVFlKQTdrTUViWlZ1SmE5cUFo?=
 =?utf-8?B?S1ZtOE9BZmVnR0JDNFowbFA0OCtVUCtQVldqQmVuNDNNdUhPMVBmYitIRDJW?=
 =?utf-8?B?SngvOTM1SURhMnZxMXBXU2NJMGxqOGFTZlJEL2NBUnhwc0JsYUlCK0NIR0R0?=
 =?utf-8?B?WGdWbVN3Y1A3TVNZdjVVSUVoNjJXdGlTalFaR0UxeGYxK2hGTXpqOTArU2RI?=
 =?utf-8?B?UUMxSGZnRFVnTWNIcEhVenZhSlhtMnd1TlRoT3NBREFJYXBIMmRNVCtrOVdx?=
 =?utf-8?B?dUsxL1IvUzJqb29zWUNPaURIKzgvNEhNaFNyc2cxVURnS0tXYS9kOWZ1cFdt?=
 =?utf-8?B?T2pVVjR4cFJIakQ1S0NhWVlzMXdRR3YwbGJweTczbTViYkNDejNSVC8vZXdw?=
 =?utf-8?B?VURkRU11cDJCdnFuVFVmdkJuSXdYYzB5NXRDZFhrL0ZiWEZua2o5QmVnWmtG?=
 =?utf-8?B?ekVlWm1SMlhjYmczemdnQ2lkMThEaElIUzZaLzN1cEdFSVpmWS8vRnNhMkw3?=
 =?utf-8?B?T1BubHcyWmNqSWxwSFM3U3lsRk13MUlpeVQxK1VJZVdDQkNFWHpXaXBiZ1VQ?=
 =?utf-8?B?UktjSEFlekFLMEZCVm1uaFJkcWlxb3RPVGJ6bUJQTDZPcnlpaXUyQnFxbG1k?=
 =?utf-8?B?THZhbE9hS0RVK3NTRzA3UHU0a2tJcUg4T21zZzlnVm5yeU85QjlzNk9sS0lV?=
 =?utf-8?B?L2VDeUxBVTlFN2ZYSkhjNnlGeVZ5S3N3Z1NWUDZBZXM0cnExL3hGdlFkVGhD?=
 =?utf-8?B?bHV5eUpQeUdJUWF2ZjgxRVNWSkZ6dGVPRUMxelRpUllWdDhyd0E0U3FYZE1U?=
 =?utf-8?B?ejRraFMxOHdiNkNENGFZai81QjZYRVJnWUdEczcxbnp5RWNITHpKN0wvdkR0?=
 =?utf-8?B?NnV1aWh2REpPc2cwYjdKbXpKTnBJZHBLREZnMEg4eXVqdUZzZVZjN3lsbzh0?=
 =?utf-8?B?UTN3QlUydGppc0k2RDZZMzVqZFFjaXVkbXlzMGZ6WUhYUVZNZVJmVFdRcmtN?=
 =?utf-8?B?ZkRjV1YxUDFXUGY0WklTcER4VlRMVzBYSkpGM3NYQk9lSUwrdE10M25LWm14?=
 =?utf-8?B?bml0dUJHSlRVQU9ZQTVpTzU3Wm5DVWV5T3FnRW5aaHFKMTlGdm9RRTY5WUhP?=
 =?utf-8?B?djdDK0VoV3Q4TG9MSng1bVBKblQxb21iem0zRHF5cWN2VnlCQTg5cEdsUkhN?=
 =?utf-8?B?QWVDZ3hiZENqdk1iTThLY1J4QTFWYnRJMThoSlZiWitOanlqYlZ2THYzeEw4?=
 =?utf-8?Q?85oEkCVd90u1vIRJj5rMKg5si?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dfKMtMAs3Gqambnal9Kci6IpLIJnEx7r+fLSHYhLIYmAYLrGFu/Ij2CHzL9KbbeefDm5E/uoq1hTLJa90Gh74TyWLw7B/N8k8+XNwkAw+oOQT09GnmD5lP3qV11eHsnDwLcsvEpWhfj6OVhKQg0K08ItgMFPWwrPM42wzxrAIhboIfSt9imzEdT4SikxmN7SecPEHYEP0GJccwpOqfzMLXA7eqquJc1E/HYg87AGaEDymYA9GXf4qN+qnh70QiisJc5DXH7Y9IeWtwsSa3JgqQ/1cz0MIToWZ4baUHKsnQkuUOxu9772XRuIVZMv0Js5jQIRXeIuxgpKhF/2VcLNHbuPFJ4y0rpFpUDMquGmaAiExK+nLkkhXpAl3306aasn6lMICmDMc8WYICO4Z5Dv1F+JbBDCRnihnyimUm98TeCKXcuhlLkpNrxKc5KyV6ZkGiXkRv/B7ReTEKa3UntVMR7C+hpghlGWRrxtDs9oSCnJbuxf+qmx8VLUo/6QKV8LVrJ/ZrHEtztzLWBq/r9D+jso744ubI1JZ31E9yjUcrT82hyKnaChIaATh7aNn74c0JlBmjHTca20fVuvNOP2FnEf5+U8xASQwb4fNwN6f7ro+6lfC+CR+sqLtydPhRm8pyfR0PLQfqv+zZW+qMzp2h5XTPyPY6UdBGFn+aEQ8pT0qE/GtZHRtZeDRi1Wul1S7UbvoTJYYWm1i3xKZSmcB25ZjgMIPzKfeDthHptW5Yhredr0gUf/OPuvPdhBzcxRLw2uoJyvx7JWwVNbVvFNb3PicNbCumEtTeVUGEuju8drcQos2mCpdk6C3MmB6sArRj/KwqTHxa/6RO5z9QeBuoLu9RAcL28uH8u4kskVgCNgzYpDdalHMJ5FrDsAzk+8
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d96393a3-56dd-4bb1-7572-08db2a64a426
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 23:33:14.4011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71Fk21ZcCPAtdPN40MspCCiioMlJVuQNbpznHxstHxxBdflmz1D5br0nrY1LLK6uGKLFlyBuL4LqnK45SWlTrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210186
X-Proofpoint-GUID: og4uE5RnkzxD4iW-3RowtvivxO1zxDtF
X-Proofpoint-ORIG-GUID: og4uE5RnkzxD4iW-3RowtvivxO1zxDtF
Cc: parav@mellanox.com
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




On 3/21/2023 4:28 AM, Eli Cohen wrote:
> Following patch adds driver support for VIRTIO_NET_F_MRG_RXBUF.
>
> Current firmware versions show degradation in packet rate when using
> MRG_RXBUF. Users who favor memory saving over packet rate could enable
> this feature but we want to keep it off by default.
>
> One can still enable it when creating the vdpa device using vdpa tool by
> providing features that include it.
>
> For example:
> $ vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 device_features 0x300cb982b
>
>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
Looks good to me.

Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 520646ae7fa0..502c482a93ce 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3122,6 +3122,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   			return -EINVAL;
>   		}
>   		device_features &= add_config->device_features;
> +	} else {
> +		device_features &= ~BIT_ULL(VIRTIO_NET_F_MRG_RXBUF);
>   	}
>   	if (!(device_features & BIT_ULL(VIRTIO_F_VERSION_1) &&
>   	      device_features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM))) {

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
