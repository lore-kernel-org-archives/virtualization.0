Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE58C43217
	for <virtualization@archiver.kernel.org>; Mon, 17 Oct 2022 18:44:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3712D40210;
	Mon, 17 Oct 2022 18:44:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3712D40210
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=EqVCGnLJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=PDuVrfct
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s5czU8sm5IAs; Mon, 17 Oct 2022 18:44:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EA082401D3;
	Mon, 17 Oct 2022 18:44:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EA082401D3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A956DC0033;
	Mon, 17 Oct 2022 18:44:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18795C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 18:44:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D8E45400F6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 18:44:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D8E45400F6
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=EqVCGnLJ; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=PDuVrfct
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MNq5VDinR7ae
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 18:44:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8860340155
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8860340155
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 18:44:09 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HITJrN026745;
 Mon, 17 Oct 2022 18:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : from : subject : to : cc : references : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=SZGdZ7CHFS6ls6MTRgdLbTv6uswGD0jtr2K5jk1H/wE=;
 b=EqVCGnLJNGDcnJ1y14lbhIYZQ8b42dE0riVr/rbbNPPg9K0q+YN9yjRWX0iQuz+fHj2m
 ch8yw2hOi5yoKjw9Mt3RZkl+HihtWzi53Bu8Zc6gzht9ra1jB5qR+DaZRUT67OUJhtDb
 cGdzxDtuWG4XcFD4LP67waRu64PGTdO2MWNUvPQwYIS6EJ3j3RmDsMWbiu+AMfi2Pp1g
 46A/JM1yvJOsjKOqWGGr0TgnNCphgrigJ99eJfcxrMHjRCF/HRMdFo9N3rU/ANXhTQB3
 B4HZl5uT3lcIEHIYtWxmgOH1yGoRPX7D2s81/vHjwCs66A4J7r/zeeMJjYyzRLvVnY7p SQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9b7sg7dp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Oct 2022 18:43:49 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 29HHJuVY029772; Mon, 17 Oct 2022 18:43:48 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3k8hu5a329-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Oct 2022 18:43:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4Chr3XxU09/9IweeGvQvO6Aget5LSHVgsCLPtKGxOWwuCxyq2zDIvfplnpalqnq1Zve2x+jKvLRM7l6Pli+J8ttuXKHKLHHJG4b9yWnrjPcbwljd08IJYsvl6JQGccIw3MomQ9Nt8Sc5AB2g1G3afG15WG0iDdYOecpXaXD8SAvq8+8nBfMXgDyH4vmBcM/VHMopS6C+kwZrAGoMOhaoMvdTmWNhqoBaKM+RDZgYramACkdqwfsviQplBa9BiMt7XxZVkRUjEuOeD/Oe9wEl+R2ZukmWRtKGMj3/eM4FsC3P6JmmrxXDcldMD07NvIq55c+rOiEmpGBX0K4qBSfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZGdZ7CHFS6ls6MTRgdLbTv6uswGD0jtr2K5jk1H/wE=;
 b=CK9rU2pwIRB1ps4u++1WHvPgf/MainOKc0os57fCaNgJ6T5kfNc13tkrDq8Eypt2/Efh3IWDNW/ykFY/QzLI6VvmbtAzQ6QzbF4OoqgQXJVbFJ/NQG6OzEUc+u5dj0EZUzPvhdDzlnuclCk/BKxDDqp5ZOYBEnBrMheZ4BAlVH7yXGNUXegotwkuiUXNOAOl0Z+JuIYEE/+nvpYD7ifhHlByF+qFqFBMVn/QdQuaOVyCxgTIV43vk70aTpb3zsxL0WIhE2YFKzG9XXWN39SJNOQLAzl28awW3EB6t9DTqW/p4XtNZ6zlmUV88z3L6ey2uxTKE0HI+e7pYQMdqfZoZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZGdZ7CHFS6ls6MTRgdLbTv6uswGD0jtr2K5jk1H/wE=;
 b=PDuVrfctfWreaTF3myK3JbqUNn1hpnd2L9V6kB/KORc60jCMiaAATWnG6299T+KvN31wai/dPCY2lpRC4k39RkYk0o59K5waBGwcTT/O51Khmd+AzUUlwSmqyEGJfCDwlYBTxW2c7StV6bhf0o4hSnjAVEoKZ3tUVZTSncSOZj0=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BLAPR10MB5330.namprd10.prod.outlook.com (2603:10b6:208:333::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 18:43:44 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a%5]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 18:43:44 +0000
Message-ID: <e613a51c-c8c3-1021-6ac8-8ca485f4a9a5@oracle.com>
Date: Mon, 17 Oct 2022 11:43:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
To: Jason Wang <jasowang@redhat.com>
References: <20220922024305.1718-1-jasowang@redhat.com>
 <20220922024305.1718-3-jasowang@redhat.com>
 <a1e98754-114e-b401-e927-5f2b71c3c641@oracle.com>
 <CACGkMEu9JfBDP4VkK76jdAnH225yUfTF+xMnqmy7_yDW3P0rKA@mail.gmail.com>
 <afe960d3-730a-b52c-e084-40bf080b27fa@oracle.com>
 <CACGkMEsWPbTs+D4PBHQL2hUOtGWj_6zo-669cUhYK5zK039QCQ@mail.gmail.com>
 <c5a96de5-699a-8b5e-0e89-bfe1822e1105@oracle.com>
 <CACGkMEsJZshW6cMiGPBu4LBSAQYr3ZhsD006v2ncCvNgXW6RJw@mail.gmail.com>
 <8a4e3998-f4ae-a295-0cd5-5629776aec6a@oracle.com>
 <886bf07b-838d-2f7b-cb99-664c3e76a291@redhat.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <886bf07b-838d-2f7b-cb99-664c3e76a291@redhat.com>
X-ClientProxiedBy: SN7PR04CA0175.namprd04.prod.outlook.com
 (2603:10b6:806:125::30) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BLAPR10MB5330:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a1566eb-9ab7-490b-7288-08dab06f8473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BtQ0nLWOf34yb+covjq8RBfFLkA+YjNhUOF1M+AnqHAz2k+uLU9DblKSqogUObHOhetukS51xNeRF+lwIeWFC7apyA1JuoEGf8AKzlhqobeSAOR5dPIsOrZJ9GN+dpLIDRmBJ5VW7/GirUoNUCKvBysStAJz995bLnEhASJC7t6hKUmjpuDiVLX/jqeNGGZPhMR84cbSA0BmaQFh6YcpEwiPcs7pvlnpCqCQwPFkQya7MXDuEhth5MvvycNP1ZXOwTqjsOIqJIJYXuCbf4MXLyo3REy9kaI1YCYpQT7+XbBG34F1b5xJPUunczMR0msJXy/QlHgR+u7MEHEfeuONyWVmTKxY/YHaTm+3vZuMSNochXYDJQUjCQDlipV0MeQ9fhwTKxOG12rxWMDE9AzQQj8BV/UAucTccB5moeMQb3EbpqwMtye7niPMqJm38PseBygFrHWTqnIwb9T3/ZBm85DG5YA6qRC8KjF/XH3HNsDBVyoYN4pBjbi+z+QzPTrt8BZFh9KvSXEKQL4jPyJ7fCAwnSsvQKyfRLdYxv2zb4AR7K4dK5xd4ya8kjQdrFCNVhSm5pryz1r5VzmzIjrzelcCE5xssXp8tueFRVLIDkexxG4KrPfaO0h3oSvCbwJ8CC4QISDW9ar/m1Ps6CjC34S5VjifTLO9PNbRJHbkwaJe38oIssQQvbqjhWsKwH3Dy66hCgjJZXR5EsW9RHPoET3m5acc6JhB44uXPmUPZYNn+sTF9KiQXGeLsmJAUdtKBnFjwS5BVfV1PgJ1Gv33HaJZSDJjlWyCuvYEzDGSwyA4HyrGmsExfPLb1xHt+l08/UnNwznJnaLNQ9qw9LWXLl8ybYnmnzdeDO4NUBGh3tU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199015)(6916009)(31686004)(66899015)(7416002)(30864003)(8676002)(66476007)(54906003)(316002)(478600001)(36916002)(66556008)(6506007)(33964004)(4326008)(26005)(53546011)(6512007)(966005)(2906002)(186003)(8936002)(6486002)(2616005)(41300700001)(5660300002)(36756003)(166002)(83380400001)(6666004)(38100700002)(66946007)(31696002)(86362001)(43740500002)(45980500001)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXBqZHZ3bHMySTZNNHI2RTZSYkVtSWJvWFVhaytiaXgrTHdjS3JlTndQNmxv?=
 =?utf-8?B?M2ZyWnM5dDBKU2t5QjdpQXhZV0p5dUJLd3BuWDV0ZXpuV2NBYUJoWGpGdDNN?=
 =?utf-8?B?dDhxN3dhZTViZkpucnVxMCsreWdZQmp0Y01XQllNM29GcmxBNXBld082dVl2?=
 =?utf-8?B?dE9ONS9uQ1NVRkNRQ1k1aWliQWRBcTVyYlBhUC9iZ3E0aUlTRldmTnBqVEor?=
 =?utf-8?B?bVZNZWJSQy9YRWR1emo3YVZXdVZBdUx3aUt2L0NzTU02WVcyM0luZVgyeTRx?=
 =?utf-8?B?ZFdQdmtSZVpySzlTZmVnQjJqSEMxNXVDREhTZDVHc293YXBGV05iMWhySzBJ?=
 =?utf-8?B?L1YzMHNXZGZIeXhCME9nWmtQeFJUN20rTS9lSW9HZTY0UFpPYm9BcjJ3UUll?=
 =?utf-8?B?MlNWOWpRTHRXbHFwQzROWTJmb2hXRkl5eG82enNxZXV5cjNSKytyU2pKK3pM?=
 =?utf-8?B?eGJHUXVrNC85R0QvVkw1SS9YM0tWS0U0ODFLZ1J1SjB4b3RmL0U0RVdnRjRU?=
 =?utf-8?B?ek5aL0RxOE1VNFp2Kzc5M1pvcXl3QlVBRDFDSG9qSDJRQ1dUbUQzOWdlLzN0?=
 =?utf-8?B?Szk2cGVGS0RLQ1ptNUxlVGdWNU44T3ZGTG5iNElkbURLYTAyd2pCSElRUVRK?=
 =?utf-8?B?NG45TnJRaUg3cnFlL2FSMFJPRncxN2tUQTNoTENmTXozb1k1bEpqNlVLYjU1?=
 =?utf-8?B?TUpsU2M5NXZJL05IN3JWOWd5VFNCZnR6OGJVbEhJdUp2MU1LQjVsU0Q3WnZs?=
 =?utf-8?B?dzM2K3NoUk05SWVhWmRFeWppR2xseDlyWW1zbXBNb1c5ZzYzRDFpdWpBUmkz?=
 =?utf-8?B?K01GNlBJN1RpaXNXRmVLUFprRWRxOEJIQmU0bGNTeng0eHpIMTVBckFRNitS?=
 =?utf-8?B?YnNKNUowbjZGUHI0MElacHViQnZGOUZ3K3l0ZElJSmVMck1UUUh1cUdEUnVF?=
 =?utf-8?B?NFNlakRGelpOWWd3Qk1rMEFPTE1yOTJ1M1pVNnBVMmJsMFk0cS83Z1phUTZY?=
 =?utf-8?B?QSswWGIwKzVpWkNpREVvdTFFRjRsQkxmSUozNm9YVk9YNjhUMzVJblJvUmpt?=
 =?utf-8?B?TmY4MnB2bnNWWVMxaUFVRFFDU3pNNHd1dVpNQlQzR1Z0VERwdEpYd3puK0Fy?=
 =?utf-8?B?dGJFL1NvblBXZHc1YjNZNk13NjJqck1zSURKdzN2aCtBcit2MmsrQmZPbUlm?=
 =?utf-8?B?T2k3YlBFUWtGeWRrSXUxTTBPbUE5RktRZU5MUHZLUEhGaEJZbkdoM3JNRG5F?=
 =?utf-8?B?bENBeHRNRDh1bXdlZ3hGZXJPRkVwZkVPQjZjUHFDeG10UDBCTmdrY2F6L0pX?=
 =?utf-8?B?cXRjbE9tejlIcERRS3FobWpDUC9BRXJtV2ZuTmVIR0lQdFYwdk8yWU41dXhE?=
 =?utf-8?B?MG5ubWpGM3o0NFNuZlJ4cVJkY2ZmZUdLc001aWhYaTlOd1BSbSt6Z0w4cy9m?=
 =?utf-8?B?dkNLcTJwK1I2czQwZzZSTGhOUEdrWW1vRGxHU0xKOWwrU053cnZwcmNBcDBm?=
 =?utf-8?B?SUJKcUVDaW1XVzIydTFNUERWcEJibUgrOERjYXdDT3VyMkdQT1c0Q1BqVWIx?=
 =?utf-8?B?aDJwR3Z4YTZJZ2tEaitJYWFOZFFGN05XR2t6dlh1SE5sTW0rc1lPcWRIaTJ5?=
 =?utf-8?B?c3FGSmZyZlE1VzkrcDY3dEhLeXpjcXAzaytOdU54U2NtQTZ6SWVOTzQwOFcw?=
 =?utf-8?B?V0IyQ2ozTENmQXhiSkVVNXQvUHVXMGcvL0hidWd1ZlJXYTlrbjJqL3EybzVn?=
 =?utf-8?B?SjQ4OUREb2lVbDdKUzZ6R1RqNktuR0EzeW1md080bWdjNVlJSDNkZkFSdjdR?=
 =?utf-8?B?U2VDSzlHL2FQZHNoZnlYSVI4OXBOV3BLcWIwS2xLQjBlSGxFYmZDbUlPVU9I?=
 =?utf-8?B?V3BTekQvZ0kyQ1QxUmo1dGRuRG9mRjVGTktqTzl4NDlvMUNjV050VUxvTmhj?=
 =?utf-8?B?UnN6Q28ybXllaG5lYm9UTEFnRTNaVDU5c3EySjBMVDc3WkpQZ2hlYlBWTFZI?=
 =?utf-8?B?aUpobVkxSmhhQkZQckowdWZuQTFCOXJ2bU81d3VUZEZxUWtBMVNaQnd6NDBF?=
 =?utf-8?B?Z21zajVtcGhQRk5BODIwOE1SRFJhS0ZVNFM2c0pIbFhuRWROTDNUd3dhUzkr?=
 =?utf-8?Q?DAWdmCFuH9ZW5dhjZF1jvjnRR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1566eb-9ab7-490b-7288-08dab06f8473
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 18:43:43.9175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzTLfbLlyXTPBDM8JdMcYuqFgYzNSlRtW7/7/c+U03ugg+plx9R0pKl6SOk6+HP9Z3Pd1t+v+1wXk+imhSVN6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5330
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210170108
X-Proofpoint-GUID: yIo8iZoDy4KcP_tVW2VSIBR8ZeOAVoXX
X-Proofpoint-ORIG-GUID: yIo8iZoDy4KcP_tVW2VSIBR8ZeOAVoXX
Cc: Cindy Lu <lulu@redhat.com>, mst <mst@redhat.com>,
 Yongji Xie <xieyongji@bytedance.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Gautam Dawar <gdawar@xilinx.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Wu Zongyong <wuzongyong@linux.alibaba.com>,
 Eli Cohen <elic@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>
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
Content-Type: multipart/mixed; boundary="===============2939223337291338501=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============2939223337291338501==
Content-Type: multipart/alternative;
 boundary="------------BObuSjupMeTyvmP97tUNLtnM"
Content-Language: en-US

--------------BObuSjupMeTyvmP97tUNLtnM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/13/2022 12:10 AM, Jason Wang wrote:
>
> 在 2022/10/7 08:35, Si-Wei Liu 写道:
>>
>>
>> On 9/28/2022 9:55 PM, Jason Wang wrote:
>>> On Tue, Sep 27, 2022 at 5:41 PM Si-Wei Liu <si-wei.liu@oracle.com> 
>>> wrote:
>>>>
>>>>
>>>> On 9/26/2022 8:59 PM, Jason Wang wrote:
>>>>
>>>> On Tue, Sep 27, 2022 at 9:02 AM Si-Wei Liu <si-wei.liu@oracle.com> 
>>>> wrote:
>>>>
>>>>
>>>> On 9/26/2022 12:11 AM, Jason Wang wrote:
>>>>
>>>> On Sat, Sep 24, 2022 at 4:01 AM Si-Wei Liu <si-wei.liu@oracle.com> 
>>>> wrote:
>>>>
>>>>
>>>> On 9/21/2022 7:43 PM, Jason Wang wrote:
>>>>
>>>> This patch implements features provisioning for vdpa_sim_net.
>>>>
>>>> 1) validating the provisioned features to be a subset of the parent
>>>>      features.
>>>> 2) clearing the features that is not wanted by the userspace
>>>>
>>>> For example:
>>>>
>>>> # vdpa mgmtdev show
>>>> vdpasim_net:
>>>>     supported_classes net
>>>>     max_supported_vqs 3
>>>>     dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 
>>>> ACCESS_PLATFORM
>>>>
>>>> Sighs, not to blame any one and it's perhaps too late, but this
>>>> "dev_features" attr in "mgmtdev show" command output should have been
>>>> called "supported_features" in the first place.
>>>>
>>>> Not sure I get this, but I guess this is the negotiated features 
>>>> actually.
>>>>
>>>> Actually no, that is why I said the name is a bit confusing and 
>>>> "supported_features" might sound better.
>>>>
>>>> You're right, it's an mgmtdev show actually.
>>>>
>>>> This attribute in the parent device (mgmtdev) denotes the real 
>>>> device capability for what virtio features can be supported by the 
>>>> parent device. Any unprivileged user can check into this field to 
>>>> know parent device's capability without having to create a child 
>>>> vDPA device at all. The features that child vDPA device may support 
>>>> should be a subset of, or at most up to what the parent device 
>>>> offers. For e.g. the vdpa device dev1 you created below can expose 
>>>> less or equal device_features bit than 0x308820028 (MTU MAC CTRL_VQ 
>>>> CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM), but shouldn't 
>>>> be no more than what the parent device can actually support.
>>>>
>>>> Yes, I didn't see anything wrong with "dev_features",
>>>>
>>>> Yep, it didn't appear to me anything wrong either at first sight, 
>>>> then I gave my R-b on the series introduced this attribute. But 
>>>> it's not a perfect name, either, on the other hand. Parav later 
>>>> pointed out that the corresponding enum definition for this 
>>>> attribute should follow pre-existing naming convention that we 
>>>> should perhaps do 
>>>> s/VDPA_ATTR_DEV_SUPPORTED_FEATURES/VDPA_ATTR_MGMTDEV_SUPPORTED_FEATURES/ 
>>>> to get it renamed, as this is a mgmtdev level attribute, which I 
>>>> agree. Now that with the upcoming "device_features" attribute (vdpa 
>>>> dev level) from this series, it's subject to another confusions 
>>>> between these two similar names, but actually would represent 
>>>> things at different level. While all other attributes in "mgmtdev 
>>>> dev show" seem to be aligned with the "supported_" prefix, e.g. 
>>>> supported_classes, max_supported_vqs, from which I think the stance 
>>>> of device is already implied through "mgmtdev" in the command. For 
>>>> the perspective of clarify and easy distinction, 
>>>> "supported_features" seems to be a better name than "dev_features".
>>> See another reply, I think I get your point,
>>>
>>> 1) VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES (lingshan's series) and
>>> VDPA_ATTR_VDPA_DEV_FEATURES should be equivalent and unified to a
>>> single attribute.
>>> 2) A better name to "supported_features" should be fine, patches are 
>>> welcomed
>>>
>>>>   it aligns to the
>>>> virtio spec which means the features could be used to create a vdpa
>>>> device. But if everyone agree on the renaming, I'm fine.
>>>>
>>>> Never mind, if it's late don't have to bother.
>>>>
>>>>
>>>>
>>>> I think Ling Shan is working on reporting both negotiated features
>>>> with the device features.
>>>>
>>>> Does it imply this series is connected to another work in parallel? 
>>>> Is it possible to add a reference in the cover letter?
>>>>
>>>> I'm not sure, I remember Ling Shan did some work to not block the
>>>> config show in this commit:
>>>>
>>>> commit a34bed37fc9d3da319bb75dfbf02a7d3e95e12de
>>>> Author: Zhu Lingshan <lingshan.zhu@intel.com>
>>>> Date:   Fri Jul 22 19:53:07 2022 +0800
>>>>
>>>>      vDPA: !FEATURES_OK should not block querying device config space
>>>>
>>>> We need some changes in the vdpa tool to show device_features
>>>> unconditionally in the "dev config show" command.
>>>>
>>>> That's true, I think I ever pointed it out to Lingshan before, that 
>>>> it's not needed to bother exposing those config space fields in 
>>>> "dev config show" output, if the only intent is for live migration 
>>>> of device features between nodes. For vDPA live migration, what 
>>>> cares most is those configuration parameters specified on vdpa 
>>>> creation, and userspace VMM (QEMU) is supposed to take care of 
>>>> saving and restoring live device states. I think it's easier to 
>>>> extend "vdpa dev show" output to include device_features and other 
>>>> config params as well, rather than count on validity of various 
>>>> config space fields.
>>> Probably, but for the migration it's more about the ability of the
>>> mgmtdev instead of the vDPA device itself I think.
>> If picking the appropriate device for migration is what it is 
>> concerned, it's subject to the capability that mgmtdev offers. That's 
>> true, for sure.
>>
>> On the other hand, mgmt software would also need to take care of 
>> reconstructing the destination device with the same configuration as 
>> that at the source side. For example, a mgmtdev on source supports 
>> features A, B, C, D,  and destination mgmtdev supports features B, C, 
>> D, E. When vdpa device on the source is initially created with 
>> features B and C but without feature D (noted: creation with a subset 
>> of mgmtdev features was already supported before, and this series 
>> just makes it more explicit), the mgmt software is supposed to 
>> equally create a device with features B and C on dest, even though 
>> the destination may support feature D that the mgmtdev on both sides 
>> can support. My point is, we should have some flexibility on the mgmt 
>> software implementation that allows the mgmt software to easily tell 
>> apart the exact features (i.e. B and C in the above example) and the 
>> exact configuration a specific vdpa device was originally created 
>> with, via some simple query command. Having mgmt software to remember 
>> the vdpa creation args could work, but on the other hand it'd be nice 
>> to allow lightweight software implementation without having to 
>> persist the list of vdpa args and make vdpa tool more self-contained.
>>
>> I will post a patch (series) shortly to demonstrate this idea. 
>> Basically, there's no actual need to mess around with those config 
>> space values for live migration. It was not built for that purpose.
>
>
> Ok, let's see.
>
>
>>
>>>
>>>> https://lore.kernel.org/virtualization/454bdf1b-daa1-aa67-2b8c-bc15351c1851@oracle.com/ 
>>>>
>>>>
>>>> It's not just insufficient, but sometimes is incorrect to create 
>>>> vDPA device using the config space fields.  For instance, MAC 
>>>> address in config space can be changed temporarily (until device 
>>>> reset) via ctrl_vq VIRTIO_NET_CTRL_MAC_ADDR_SET command. It's 
>>>> incorrect to create vDPA using the MAC address shown in the config 
>>>> space.
>>> I think it's still a must for create the mac with the exact mac 
>>> address:
>>>
>>> 1) VIRTIO_NET_F_CTRL_MAC is not a must
>>> 2) there's no way for us to know whether or not the mac has been 
>>> changed
>> Noted I think here we are still talking about VERSION_1 device which 
>> is spec conforming. So far as I understand the spec, if the 
>> VIRTIO_NET_F_CTRL_MAC feature is not negotiated, there's no way for 
>> driver to change the default MAC address.
>
>
> For 1.0 device yes.
>
>
>>
>> Even if we want to simulate or support a legacy device model, when 
>> MAC address is changed by legacy driver somehow, QEMU should be able 
>> to detect this and issue a vdpa ioctl call to change the MAC address 
>> filter underneath. I don't see that it ever happens in today's code, 
>> so I presume the only possibility this may work is that the specific 
>> vDPA device may have an internal learning bridge that adapts to what 
>> MAC address the driver actually sends. 
>
>
> This is not true AFAIK. E.g when switchdev is enabled for mlx5 parent.
Hmmm, I guess you mean switchdev mode with external learning bridge 
software e.g. Open vSwitch? It's conceptionally the same with device 
internal learning bridge, no?

OK, though the point was that QEMU should anyway notify the backend of 
the mac address change for vDPA driver to apply the new MAC filter, 
similar to the way how CTRL_MAC ctrl_vq command is doing. It should not 
blindly assume that the every vDPA hardware may have underlying learning 
bridge construct, being internal or external. Basically it's not a 
universal assumption on the existence of learning bridge, this won't 
work for any other vDPA NIC without switchdev or learning bridge.

>
>
>> In this case, since the device doesn't care, recreate with the MAC in 
>> use is not needed, and technically it is even incorrect. In data 
>> centers or cloud environment, MAC address is usually controlled and 
>> managed by some central entity/service. If a driver can dominate the 
>> MAC address in use by deliberately overriding the default MAC and 
>> bypassing the central rule via live migration, that'd be a more 
>> severe security issue to address in the first place.
>
>
> There used to be a discussion to allow trust and spoof check as what 
> SR-IOV did. For safety, we can filter out CTRL_MAC right now. But I 
> think it's something out of the scope for this discussion.
Sorry I don't get what you mean here, but I guess we may talk about 
different thing here (it seems you talked about trusted model that 
allows any MAC address, but it's orthogonal to programming MAC address 
filter to the underlying hardware as far as I understand).

>
> But I still don't get what's wrong with have the same mac address 
> provisioned in both src and dst.
It looks like we may have misunderstood each other - that's exactly the 
point I want to make. The persistent mac address provisioned in dst by 
the mgmt software should stay the same with that on src, which is the 
default mac address rather than whatever other (temporary) mac address 
the VM might be using at the time of migration switchover at the source.

> It is the model used currently (e.g libvirt will guarantee the same 
> mac in both src and dst). The mgmt software can then guarantee that 
> the mac was fetched from the centralized manager.
Right, this is exactly the way our mgmt software works.

> And we can't depend purely on the migration since in some case it 
> can't work: e.g src MTU 4000 dst MTU 1500, migration will fail and 
> mgmt stack need to provision an 4000 to work.
This seems like a bug of libvirt. For our case, we strictly prohibit 
unequal MTU on src & dst to work. Even migrating from MTU 1500 to 4000, 
it effectively changes the underlying behavior for packet dropping and 
network setup at which maximum size the packet should be allowed when 
entering the VM.
>
>
>>
>>> 3) migration code can restore the mac during restore
>>>
>>> So exactly the same mac address is still required. (This is the same
>>> as we are doing for live migration on software virtio)
>>>
>>>>   Another example, if the source vDPA device has MAC address table 
>>>> size limit of 100, then in the destination we should pick parent 
>>>> device with size limit no smaller than that, and create vDPA on 
>>>> remote node matching the exact same size. There's nothing config 
>>>> space field can assist here.
>>> Two ways:
>>>
>>> 1) mgmtdev should show the mac table size so mgmt layer can provision
>>> the mac table size
>>> 2) If the mac table exceeds what is supported in the destination, it
>>> needs to enable the all uni in this case.
>> Yep, so no field in the config space can help with these two 
>> solutions, right? MAC table size is not showing up there. Whether the 
>> parent device supports ALLUNI via VIRTIO_NET_F_CTRL_RX is not there, 
>> either. (showing them in the 'vdpa mgmtdev show' output is the right 
>> thing IMHO).
>>
>>>
>>>> One example further, in the future, if we are going to introduce 
>>>> mandatory feature (for e.g. VERSION_1, RING_PACKED) that the device 
>>>> is unable to support the opposite case, the destination device 
>>>> should be created with equally same mandatory device features, 
>>>> which only vDPA creation parameters should matter. While I can't 
>>>> think of a case that the mgmt software or live migration tool would 
>>>> have to count on config space fields only.
>>> Yes, in this case we need to introduce new netlink attributes for both
>>> getting mandatory features from the management device and provisioning
>>> those manadating features.
>> True, management device level thing again, not related to anything in 
>> the config space.
>>
>>>
>>>>
>>>>
>>>>
>>>> 1) provision vDPA device with all features that are supported by the
>>>>      net simulator
>>>>
>>>> # vdpa dev add name dev1 mgmtdev vdpasim_net
>>>> # vdpa dev config show
>>>> dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>>>>     negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1 
>>>> ACCESS_PLATFORM
>>>>
>>>> Maybe not in this patch, but for completeness for the whole series,
>>>> could we also add device_features to the output?
>>>>
>>>> Lingshan, could you please share your thoughts or patch on this?
>>>>
>>>> Noted here the device_features argument specified during vdpa 
>>>> creation is introduced by this series itself, it somehow slightly 
>>>> changed the original semantics of what device_features used to be.
>>>>
>>>> I'm not sure I get this, we don't support device_features in the past
>>>> and it is used to provision device features to the vDPA device which
>>>> seems to be fine.
>>>>
>>>> Before this change, only look at the dev_features in "mgmtdev show" 
>>>> and remember creation parameters is sufficient to get to all needed 
>>>> info for creating vDPA at destination.
>>> Note that even with the same vendor, mgmtdev may support different 
>>> features.
>>>
>>>> After this change, dev_features in "mgmtdev show" becomes less 
>>>> relevant, as it would need to remember vdpa creation parameters 
>>>> plus the device_features attribute. While this series allows cross 
>>>> vendor live migration, it would complicate the implementation of 
>>>> mgmt software, on the other hand.
>>> To allow cross vendor live migration I couldn't find a better way.
>> The idea itself is great, I think, though the CLI interface may have 
>> some space for improvement. For example, user has to supply the 
>> heximal value consisting of each feature bit, which is a bit 
>> challenging for normal users who are not super familiar with each 
>> virtio feature. On the other hand, there could be ambiguity against 
>> other vdpa create option, e.g. users may do "vdpa dev add name vdpa0 
>> mgmtdev ... mtu 1500 device_features 0x300020000" (no F_MTU feature 
>> bit in device_features) that needs special validation in the code.
>
>
> We can accept e.g XML in the future I think.
Regardless of XML being a good interface or not for end users, but I 
don't see how it relates to the issue here i.e. conflict/ambiguity or 
extra validation in the (kernel) code.

>
>
>>
>> How about we follow the CPU flags model or QEMU virtio-net-pci args 
>> to define property representing each feature bit? I think the current 
>> convention for each "vdpa dev add" option implies that the 
>> corresponding feature bit will be enabled once specified in creation. 
>> Similarly we can introduce additional option representing each 
>> feature bit, along with a new features_default property denoting the 
>> initial value for device_feature bits:
>>
>> # vdpa mgmtdev show
>> vdpasim_net:
>>   supported_classes net
>>   max_supported_vqs 3
>>   dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 
>> ACCESS_PLATFORM
>> # vdpa dev add name dev1 mgmtdev vdpasim_net features_default off \
>>                           csum on guest_csum on mtu 2000 ctrl_vq on 
>> version1 on access_platform on
>> # vdpa dev show
>> dev1: type network mgmtdev vdpasim_net vendor_id 0 max_vqs 3 
>> max_vq_size 256
>>    features_default off mtu 2000
>>    device_features CSUM GUEST_CSUM MTU CTRL_VQ VERSION_1 ACCESS_PLATFORM
>>
>> If the features_default property is left unspecified or with the 
>> "inherited" value, it would just inherit all of the 
>> supported_features from mgmtdev (which is already the case of today).
>>
>> # vdpa dev add name dev1 mgmtdev vdpasim_net features_default inherited
>> # vdpa dev show
>> dev1: type network mgmtdev vdpasim_net vendor_id 0 max_vqs 3 
>> max_vq_size 256
>>   features_default inherited
>>   device_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 
>> ACCESS_PLATFORM
>>
>> I can definitely help implement this model if you find it fits.
>
>
> I prefer XML since it could be reused and we may exceed 64bit 
> limitation in the future. But we can hear from others.
I don't see how this can be re-used by QEMU as QMP is not 
taking/exporting XML. Are we talking about libvirt here, which happens 
to be one amongst many others? My personal feeling is that not quite a 
lot of human end users (rather than management software or script) today 
would prefer using XML. Instead, like any other iproute utility, json 
seems to a more popular interface for script and mgmt software to 
consume, which vdpa tool supports natively already.

I think basically we can support two set of CLI interfaces, one friendly 
enough for human users, and another scriptable and parseable by 
management software users. IMO for now we should start to focus on the 
human oriented CLI design first. Whether XML v.s. json being an ideal 
interface for managment software would be another discussion that would 
need more inputs from the broader range of extended community, which is 
not worth distracting from.

>
>>
>>>
>>>>
>>>>
>>>> When simply look at the "vdpa dev config show" output, I cannot really
>>>> tell the actual device_features that was used in vdpa creation. For 
>>>> e.g.
>>>> there is a missing feature ANY_LAYOUT from negotiated_features 
>>>> compared
>>>> with supported_features in mgmtdev, but the orchestration software
>>>> couldn't tell if the vdpa device on destination host should be created
>>>> with or without the ANY_LAYOUT feature.
>>>>
>>>> I think VERSION_1 implies ANY_LAYOUT.
>>>>
>>>> Right, ANY_LAYOUT is a bad example. A good example might be that, I 
>>>> knew the parent mgmtdev on migration source node supports 
>>>> CTRL_MAC_ADDR, but I don't find it in negotiated_features.
>>>>
>>>> I think we should use the features that we got from "mgmtdev show"
>>>> instead of "negotiated features".
>>>>
>>>> That was how it's supposed to work previously, but with this 
>>>> series, I think the newly introduced device_features will be needed 
>>>> instead of the one in "mgmtdev show".
>>> Just to clarify, there won't be a device_features in mgmtdev show
>>> since it is device specific, each individual device can have its own
>>> device features which are subset of what is supported by the mgmtdev.
>> Yep.
>>>
>>>>
>>>> On the migration destination node, the parent device does support 
>>>> all features as the source offers, including CTRL_MAC_ADDR. What 
>>>> device features you would expect the mgmt software to create 
>>>> destination vdpa device with, if not otherwise requiring mgmt 
>>>> software to remember all the arguments on device creation?
>>> So the provisioning in the destination should use exactly the same
>>> device_feautres as what the vdpa device has in the source. But before
>>> this, management layer should guarantee to provision a vDPA device
>>> whose device_features can be supported on the destination in order to
>>> allow live migration.
>> Exactly.
>>>
>>>> So in this example, we need use "dev_features" so we get exact the
>>>> same features after and operation as either src or dst.
>>>>
>>>> If the device_features vDPA created with at the source doesn't 
>>>> include CTRL_MAC_ADDR even though parent supports it, then the vDPA 
>>>> to be created at the destination shouldn't come with CTRL_MAC_ADDR 
>>>> either, regardless of whether or not CTRL_MAC_ADDR is present in 
>>>> destination "mgmtdev show".
>>>>
>>>> However, if just taking look at negotiated_features, some mgmt 
>>>> software implementations which don't persist the creation 
>>>> parameters can't get the device features a certain vDPA device at 
>>>> the source node was created with.
>>>>
>>>>
>>>> SOURCE# vdpa mgmtdev show
>>>> vdpasim_net:
>>>>     supported_classes net
>>>>     max_supported_vqs 3
>>>>     dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 
>>>> ACCESS_PLATFORM
>>>> SOURCE# vdpa dev config show
>>>> dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>>>>     negotiated_features MTU MAC CTRL_VQ VERSION_1 ACCESS_PLATFORM
>>>>
>>>> DESTINATION# vdpa mgmtdev show
>>>> vdpasim_net:
>>>>     supported_classes net
>>>>     max_supported_vqs 3
>>>>     dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 
>>>> ACCESS_PLATFORM
>>>>
>>>>   But it should be sufficient to
>>>> use features_src & feature_dst in this case. Actually, it should work
>>>> similar as to the cpu flags, the management software should introduce
>>>> the concept of cluster which means the maximal set of common features
>>>> is calculated and provisioned during device creation to allow
>>>> migration among the nodes inside the cluster.
>>>>
>>>> Yes, this is one way mgmt software may implement, but I am not sure 
>>>> if it's the only way. For e.g. for cpu flags, mgmt software can 
>>>> infer the guest cpus features in use from all qemu command line 
>>>> arguments and host cpu features/capability, which doesn't need to 
>>>> remember creation arguments and is easy to recover from failure 
>>>> without having to make the VM config persistent in data store. I 
>>>> thought it would be great if vdpa CLI design could offer the same.
>>>>
>>>> One minor difference is that we have cpu model abstraction, so we can
>>>> have things like:
>>>>
>>>> ./qemu-system-x86_64 -cpu EPYC
>>>>
>>>> Which implies the cpu features/flags where vDPA doesn't have. But
>>>> consider it's just a 64bit (or 128 in the future), it doesn't seems to
>>>> be too complex for the management to know, we probably need to start
>>>> from this and then we can try to introduce some generation/model after
>>>> it is agreed on most of the vendors.
>>>>
>>>> What you refer to is the so-called named model for CPU flags. I 
>>>> think it's a good addition to have some generation or named model 
>>>> defined for vDPA. But I don't get the point for how it relates to 
>>>> exposing the actual value of device features? Are you saying in 
>>>> this case you'd rather expose the model name than the actual value 
>>>> of feature bits? Well, I think we can expose both in different 
>>>> fields when there's really such a need.
>>> It's something like:
>>>
>>> vdpa dev add name dev1 mgmtdev vdpasim_net device_features 
>>> VDPA_NET_MODEL_1
>>>
>>> and VDPA_NET_MODEL_1 implies some feature sets.
>>
>> Not sure if this could be very useful for virtio devices, given we 
>> don't have a determined set of virtio features unlike CPU 
>> generation/model, but I think even with the features_default property 
>> we can still achieve that.
>>
>> -Siwei
>
>
> Yes.
Let me get some time to implement and post the relevant patches (mostly 
in iproute) later. Basically this would supplement those config 
attributes introduced through the 'vdpa dev show' series below [1] with 
provisioned device features to reference:

[1] 
https://lore.kernel.org/virtualization/1665793690-28120-1-git-send-email-si-wei.liu@oracle.com/


Thanks,
-Siwei

>
> Thanks
>
>
>>
>>>
>>>> BTW with regard to the cpu model in mgmt software implementation, 
>>>> the one implemented in libvirt is a mixed "Host model" [1] with 
>>>> taking advantage of QEMU named model and exposing additional 
>>>> individual CPU features that gets close to what host CPU offers.
>>> So creating vDPA device without "device_features" is somehow the host
>>> model, it will have all features that is supported by the parent.
>>>
>>>> I think this implies that mgmt software should have to understand 
>>>> what the model name really means in terms of individual CPU 
>>>> features, so having feature bit value exposed will just do more 
>>>> help if vDPA goes the same way.
>>> Exactly.
>>>
>>> Thanks
>>>
>>>>
>>>> Regards,
>>>> -Siwei
>>>>
>>>> [1] 
>>>> https://qemu-project.gitlab.io/qemu/system/qemu-cpu-models.html#two-ways-to-configure-cpu-models-with-qemu-kvm
>>>>
>>>>
>>>> Thanks
>>>>
>>>> Thanks,
>>>> -Siwei
>>>>
>>>>
>>>> Thanks
>>>>
>>>> Thanks,
>>>> -Siwei
>>>>
>>>>
>>>> 2) provision vDPA device with a subset of the features
>>>>
>>>> # vdpa dev add name dev1 mgmtdev vdpasim_net device_features 
>>>> 0x300020000
>>>> # vdpa dev config show
>>>> dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>>>>     negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
>>>>
>>>> Reviewed-by: Eli Cohen <elic@nvidia.com>
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>> ---
>>>>    drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
>>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c 
>>>> b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>>>> index 886449e88502..a9ba02be378b 100644
>>>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>>>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>>>> @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct 
>>>> vdpa_mgmt_dev *mdev, const char *name,
>>>>        dev_attr.work_fn = vdpasim_net_work;
>>>>        dev_attr.buffer_size = PAGE_SIZE;
>>>>
>>>> +     if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
>>>> +             if (config->device_features &
>>>> +                 ~dev_attr.supported_features)
>>>> +                     return -EINVAL;
>>>> +             dev_attr.supported_features &=
>>>> +                      config->device_features;
>>>> +     }
>>>> +
>>>>        simdev = vdpasim_create(&dev_attr);
>>>>        if (IS_ERR(simdev))
>>>>                return PTR_ERR(simdev);
>>>> @@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
>>>>        .id_table = id_table,
>>>>        .ops = &vdpasim_net_mgmtdev_ops,
>>>>        .config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
>>>> -                          1 << VDPA_ATTR_DEV_NET_CFG_MTU),
>>>> +                          1 << VDPA_ATTR_DEV_NET_CFG_MTU |
>>>> +                          1 << VDPA_ATTR_DEV_FEATURES),
>>>>        .max_supported_vqs = VDPASIM_NET_VQ_NUM,
>>>>        .supported_features = VDPASIM_NET_FEATURES,
>>>>    };
>>>>
>>>>
>>>>
>>
>

--------------BObuSjupMeTyvmP97tUNLtnM
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 10/13/2022 12:10 AM, Jason Wang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:886bf07b-838d-2f7b-cb99-664c3e76a291@redhat.com"> <br>
      在 2022/10/7 08:35, Si-Wei Liu 写道: <br>
      <blockquote type="cite"> <br>
        <br>
        On 9/28/2022 9:55 PM, Jason Wang wrote: <br>
        <blockquote type="cite">On Tue, Sep 27, 2022 at 5:41 PM Si-Wei
          Liu <a class="moz-txt-link-rfc2396E" href="mailto:si-wei.liu@oracle.com">&lt;si-wei.liu@oracle.com&gt;</a>
          wrote: <br>
          <blockquote type="cite"> <br>
            <br>
            On 9/26/2022 8:59 PM, Jason Wang wrote: <br>
            <br>
            On Tue, Sep 27, 2022 at 9:02 AM Si-Wei Liu <a class="moz-txt-link-rfc2396E" href="mailto:si-wei.liu@oracle.com">&lt;si-wei.liu@oracle.com&gt;</a>
            wrote: <br>
            <br>
            <br>
            On 9/26/2022 12:11 AM, Jason Wang wrote: <br>
            <br>
            On Sat, Sep 24, 2022 at 4:01 AM Si-Wei Liu <a class="moz-txt-link-rfc2396E" href="mailto:si-wei.liu@oracle.com">&lt;si-wei.liu@oracle.com&gt;</a>
            wrote: <br>
            <br>
            <br>
            On 9/21/2022 7:43 PM, Jason Wang wrote: <br>
            <br>
            This patch implements features provisioning for
            vdpa_sim_net. <br>
            <br>
            1) validating the provisioned features to be a subset of the
            parent <br>
            &nbsp;&nbsp;&nbsp;&nbsp; features. <br>
            2) clearing the features that is not wanted by the userspace
            <br>
            <br>
            For example: <br>
            <br>
            # vdpa mgmtdev show <br>
            vdpasim_net: <br>
            &nbsp;&nbsp;&nbsp; supported_classes net <br>
            &nbsp;&nbsp;&nbsp; max_supported_vqs 3 <br>
            &nbsp;&nbsp;&nbsp; dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT
            VERSION_1 ACCESS_PLATFORM <br>
            <br>
            Sighs, not to blame any one and it's perhaps too late, but
            this <br>
            &quot;dev_features&quot; attr in &quot;mgmtdev show&quot; command output should
            have been <br>
            called &quot;supported_features&quot; in the first place. <br>
            <br>
            Not sure I get this, but I guess this is the negotiated
            features actually. <br>
            <br>
            Actually no, that is why I said the name is a bit confusing
            and &quot;supported_features&quot; might sound better. <br>
            <br>
            You're right, it's an mgmtdev show actually. <br>
            <br>
            This attribute in the parent device (mgmtdev) denotes the
            real device capability for what virtio features can be
            supported by the parent device. Any unprivileged user can
            check into this field to know parent device's capability
            without having to create a child vDPA device at all. The
            features that child vDPA device may support should be a
            subset of, or at most up to what the parent device offers.
            For e.g. the vdpa device dev1 you created below can expose
            less or equal device_features bit than 0x308820028 (MTU MAC
            CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM),
            but shouldn't be no more than what the parent device can
            actually support. <br>
            <br>
            Yes, I didn't see anything wrong with &quot;dev_features&quot;, <br>
            <br>
            Yep, it didn't appear to me anything wrong either at first
            sight, then I gave my R-b on the series introduced this
            attribute. But it's not a perfect name, either, on the other
            hand. Parav later pointed out that the corresponding enum
            definition for this attribute should follow pre-existing
            naming convention that we should perhaps do
            s/VDPA_ATTR_DEV_SUPPORTED_FEATURES/VDPA_ATTR_MGMTDEV_SUPPORTED_FEATURES/
            to get it renamed, as this is a mgmtdev level attribute,
            which I agree. Now that with the upcoming &quot;device_features&quot;
            attribute (vdpa dev level) from this series, it's subject to
            another confusions between these two similar names, but
            actually would represent things at different level. While
            all other attributes in &quot;mgmtdev dev show&quot; seem to be
            aligned with the &quot;supported_&quot; prefix, e.g.
            supported_classes, max_supported_vqs, from which I think the
            stance of device is already implied through &quot;mgmtdev&quot; in the
            command. For the perspective of clarify and easy
            distinction, &quot;supported_features&quot; seems to be a better name
            than &quot;dev_features&quot;. <br>
          </blockquote>
          See another reply, I think I get your point, <br>
          <br>
          1) VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES (lingshan's series)
          and <br>
          VDPA_ATTR_VDPA_DEV_FEATURES should be equivalent and unified
          to a <br>
          single attribute. <br>
          2) A better name to &quot;supported_features&quot; should be fine,
          patches are welcomed <br>
          <br>
          <blockquote type="cite">&nbsp; it aligns to the <br>
            virtio spec which means the features could be used to create
            a vdpa <br>
            device. But if everyone agree on the renaming, I'm fine. <br>
            <br>
            Never mind, if it's late don't have to bother. <br>
            <br>
            <br>
            <br>
            I think Ling Shan is working on reporting both negotiated
            features <br>
            with the device features. <br>
            <br>
            Does it imply this series is connected to another work in
            parallel? Is it possible to add a reference in the cover
            letter? <br>
            <br>
            I'm not sure, I remember Ling Shan did some work to not
            block the <br>
            config show in this commit: <br>
            <br>
            commit a34bed37fc9d3da319bb75dfbf02a7d3e95e12de <br>
            Author: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@intel.com">&lt;lingshan.zhu@intel.com&gt;</a>
            <br>
            Date:&nbsp;&nbsp; Fri Jul 22 19:53:07 2022 +0800 <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; vDPA: !FEATURES_OK should not block querying device
            config space <br>
            <br>
            We need some changes in the vdpa tool to show
            device_features <br>
            unconditionally in the &quot;dev config show&quot; command. <br>
            <br>
            That's true, I think I ever pointed it out to Lingshan
            before, that it's not needed to bother exposing those config
            space fields in &quot;dev config show&quot; output, if the only intent
            is for live migration of device features between nodes. For
            vDPA live migration, what cares most is those configuration
            parameters specified on vdpa creation, and userspace VMM
            (QEMU) is supposed to take care of saving and restoring live
            device states. I think it's easier to extend &quot;vdpa dev show&quot;
            output to include device_features and other config params as
            well, rather than count on validity of various config space
            fields. <br>
          </blockquote>
          Probably, but for the migration it's more about the ability of
          the <br>
          mgmtdev instead of the vDPA device itself I think. <br>
        </blockquote>
        If picking the appropriate device for migration is what it is
        concerned, it's subject to the capability that mgmtdev offers.
        That's true, for sure. <br>
        <br>
        On the other hand, mgmt software would also need to take care of
        reconstructing the destination device with the same
        configuration as that at the source side. For example, a mgmtdev
        on source supports features A, B, C, D,&nbsp; and destination mgmtdev
        supports features B, C, D, E. When vdpa device on the source is
        initially created with features B and C but without feature D
        (noted: creation with a subset of mgmtdev features was already
        supported before, and this series just makes it more explicit),
        the mgmt software is supposed to equally create a device with
        features B and C on dest, even though the destination may
        support feature D that the mgmtdev on both sides can support. My
        point is, we should have some flexibility on the mgmt software
        implementation that allows the mgmt software to easily tell
        apart the exact features (i.e. B and C in the above example) and
        the exact configuration a specific vdpa device was originally
        created with, via some simple query command. Having mgmt
        software to remember the vdpa creation args could work, but on
        the other hand it'd be nice to allow lightweight software
        implementation without having to persist the list of vdpa args
        and make vdpa tool more self-contained. <br>
        <br>
        I will post a patch (series) shortly to demonstrate this idea.
        Basically, there's no actual need to mess around with those
        config space values for live migration. It was not built for
        that purpose. <br>
      </blockquote>
      <br>
      <br>
      Ok, let's see. <br>
      <br>
      <br>
      <blockquote type="cite"> <br>
        <blockquote type="cite"> <br>
          <blockquote type="cite"><a class="moz-txt-link-freetext" href="https://lore.kernel.org/virtualization/454bdf1b-daa1-aa67-2b8c-bc15351c1851@oracle.com/">https://lore.kernel.org/virtualization/454bdf1b-daa1-aa67-2b8c-bc15351c1851@oracle.com/</a>
            <br>
            <br>
            It's not just insufficient, but sometimes is incorrect to
            create vDPA device using the config space fields.&nbsp; For
            instance, MAC address in config space can be changed
            temporarily (until device reset) via ctrl_vq
            VIRTIO_NET_CTRL_MAC_ADDR_SET command. It's incorrect to
            create vDPA using the MAC address shown in the config space.
            <br>
          </blockquote>
          I think it's still a must for create the mac with the exact
          mac address: <br>
          <br>
          1) VIRTIO_NET_F_CTRL_MAC is not a must <br>
          2) there's no way for us to know whether or not the mac has
          been changed <br>
        </blockquote>
        Noted I think here we are still talking about VERSION_1 device
        which is spec conforming. So far as I understand the spec, if
        the VIRTIO_NET_F_CTRL_MAC feature is not negotiated, there's no
        way for driver to change the default MAC address. <br>
      </blockquote>
      <br>
      <br>
      For 1.0 device yes. <br>
      <br>
      <br>
      <blockquote type="cite"> <br>
        Even if we want to simulate or support a legacy device model,
        when MAC address is changed by legacy driver somehow, QEMU
        should be able to detect this and issue a vdpa ioctl call to
        change the MAC address filter underneath. I don't see that it
        ever happens in today's code, so I presume the only possibility
        this may work is that the specific vDPA device may have an
        internal learning bridge that adapts to what MAC address the
        driver actually sends. </blockquote>
      <br>
      <br>
      This is not true AFAIK. E.g when switchdev is enabled for mlx5
      parent. <br>
    </blockquote>
    Hmmm, I guess you mean switchdev mode with external learning bridge
    software e.g. Open vSwitch? It's conceptionally the same with device
    internal learning bridge, no? <br>
    <br>
    OK, though the point was that QEMU should anyway notify the backend
    of the mac address change for vDPA driver to apply the new MAC
    filter, similar to the way how CTRL_MAC ctrl_vq command is doing. It
    should not blindly assume that the every vDPA hardware may have
    underlying learning bridge construct, being internal or external.
    Basically it's not a universal assumption on the existence of
    learning bridge, this won't work for any other vDPA NIC without
    switchdev or learning bridge.<br>
    <br>
    <blockquote type="cite" cite="mid:886bf07b-838d-2f7b-cb99-664c3e76a291@redhat.com"> <br>
      <br>
      <blockquote type="cite">In this case, since the device doesn't
        care, recreate with the MAC in use is not needed, and
        technically it is even incorrect. In data centers or cloud
        environment, MAC address is usually controlled and managed by
        some central entity/service. If a driver can dominate the MAC
        address in use by deliberately overriding the default MAC and
        bypassing the central rule via live migration, that'd be a more
        severe security issue to address in the first place. <br>
      </blockquote>
      <br>
      <br>
      There used to be a discussion to allow trust and spoof check as
      what SR-IOV did. For safety, we can filter out CTRL_MAC right now.
      But I think it's something out of the scope for this discussion. <br>
    </blockquote>
    Sorry I don't get what you mean here, but I guess we may talk about
    different thing here (it seems you talked about trusted model that
    allows any MAC address, but it's orthogonal to programming MAC
    address filter to the underlying hardware as far as I understand). <br>
    <br>
    <blockquote type="cite" cite="mid:886bf07b-838d-2f7b-cb99-664c3e76a291@redhat.com"> <br>
      But I still don't get what's wrong with have the same mac address
      provisioned in both src and dst.</blockquote>
    It looks like we may have misunderstood each other - that's exactly
    the point I want to make. The persistent mac address provisioned in
    dst by the mgmt software should stay the same with that on src,
    which is the default mac address rather than whatever other
    (temporary) mac address the VM might be using at the time of
    migration switchover at the source.<br>
    <br>
    <blockquote type="cite" cite="mid:886bf07b-838d-2f7b-cb99-664c3e76a291@redhat.com"> It is
      the model used currently (e.g libvirt will guarantee the same mac
      in both src and dst). The mgmt software can then guarantee that
      the mac was fetched from the centralized manager.</blockquote>
    Right, this is exactly the way our mgmt software works.<br>
    <br>
    <blockquote type="cite" cite="mid:886bf07b-838d-2f7b-cb99-664c3e76a291@redhat.com">And we
      can't depend purely on the migration since in some case it can't
      work: e.g src MTU 4000 dst MTU 1500, migration will fail and mgmt
      stack need to provision an 4000 to work. <br>
    </blockquote>
    This seems like a bug of libvirt. For our case, we strictly prohibit
    unequal MTU on src &amp; dst to work. Even migrating from MTU 1500
    to 4000, it effectively changes the underlying behavior for packet
    dropping and network setup at which maximum size the packet should
    be allowed when entering the VM.<br>
    <blockquote type="cite" cite="mid:886bf07b-838d-2f7b-cb99-664c3e76a291@redhat.com"> <br>
      <br>
      <blockquote type="cite"> <br>
        <blockquote type="cite">3) migration code can restore the mac
          during restore <br>
          <br>
          So exactly the same mac address is still required. (This is
          the same <br>
          as we are doing for live migration on software virtio) <br>
          <br>
          <blockquote type="cite">&nbsp; Another example, if the source vDPA
            device has MAC address table size limit of 100, then in the
            destination we should pick parent device with size limit no
            smaller than that, and create vDPA on remote node matching
            the exact same size. There's nothing config space field can
            assist here. <br>
          </blockquote>
          Two ways: <br>
          <br>
          1) mgmtdev should show the mac table size so mgmt layer can
          provision <br>
          the mac table size <br>
          2) If the mac table exceeds what is supported in the
          destination, it <br>
          needs to enable the all uni in this case. <br>
        </blockquote>
        Yep, so no field in the config space can help with these two
        solutions, right? MAC table size is not showing up there.
        Whether the parent device supports ALLUNI via
        VIRTIO_NET_F_CTRL_RX is not there, either. (showing them in the
        'vdpa mgmtdev show' output is the right thing IMHO). <br>
        <br>
        <blockquote type="cite"> <br>
          <blockquote type="cite">One example further, in the future, if
            we are going to introduce mandatory feature (for e.g.
            VERSION_1, RING_PACKED) that the device is unable to support
            the opposite case, the destination device should be created
            with equally same mandatory device features, which only vDPA
            creation parameters should matter. While I can't think of a
            case that the mgmt software or live migration tool would
            have to count on config space fields only. <br>
          </blockquote>
          Yes, in this case we need to introduce new netlink attributes
          for both <br>
          getting mandatory features from the management device and
          provisioning <br>
          those manadating features. <br>
        </blockquote>
        True, management device level thing again, not related to
        anything in the config space. <br>
        <br>
        <blockquote type="cite"> <br>
          <blockquote type="cite"> <br>
            <br>
            <br>
            1) provision vDPA device with all features that are
            supported by the <br>
            &nbsp;&nbsp;&nbsp;&nbsp; net simulator <br>
            <br>
            # vdpa dev add name dev1 mgmtdev vdpasim_net <br>
            # vdpa dev config show <br>
            dev1: mac 00:00:00:00:00:00 link up link_announce false mtu
            1500 <br>
            &nbsp;&nbsp;&nbsp; negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR
            VERSION_1 ACCESS_PLATFORM <br>
            <br>
            Maybe not in this patch, but for completeness for the whole
            series, <br>
            could we also add device_features to the output? <br>
            <br>
            Lingshan, could you please share your thoughts or patch on
            this? <br>
            <br>
            Noted here the device_features argument specified during
            vdpa creation is introduced by this series itself, it
            somehow slightly changed the original semantics of what
            device_features used to be. <br>
            <br>
            I'm not sure I get this, we don't support device_features in
            the past <br>
            and it is used to provision device features to the vDPA
            device which <br>
            seems to be fine. <br>
            <br>
            Before this change, only look at the dev_features in
            &quot;mgmtdev show&quot; and remember creation parameters is
            sufficient to get to all needed info for creating vDPA at
            destination. <br>
          </blockquote>
          Note that even with the same vendor, mgmtdev may support
          different features. <br>
          <br>
          <blockquote type="cite">After this change, dev_features in
            &quot;mgmtdev show&quot; becomes less relevant, as it would need to
            remember vdpa creation parameters plus the device_features
            attribute. While this series allows cross vendor live
            migration, it would complicate the implementation of mgmt
            software, on the other hand. <br>
          </blockquote>
          To allow cross vendor live migration I couldn't find a better
          way. <br>
        </blockquote>
        The idea itself is great, I think, though the CLI interface may
        have some space for improvement. For example, user has to supply
        the heximal value consisting of each feature bit, which is a bit
        challenging for normal users who are not super familiar with
        each virtio feature. On the other hand, there could be ambiguity
        against other vdpa create option, e.g. users may do &quot;vdpa dev
        add name vdpa0 mgmtdev ... mtu 1500 device_features 0x300020000&quot;
        (no F_MTU feature bit in device_features) that needs special
        validation in the code. <br>
      </blockquote>
      <br>
      <br>
      We can accept e.g XML in the future I think. <br>
    </blockquote>
    Regardless of XML being a good interface or not for end users, but I
    don't see how it relates to the issue here i.e. conflict/ambiguity
    or extra validation in the (kernel) code.<br>
    <br>
    <blockquote type="cite" cite="mid:886bf07b-838d-2f7b-cb99-664c3e76a291@redhat.com"> <br>
      <br>
      <blockquote type="cite"> <br>
        How about we follow the CPU flags model or QEMU virtio-net-pci
        args to define property representing each feature bit? I think
        the current convention for each &quot;vdpa dev add&quot; option implies
        that the corresponding feature bit will be enabled once
        specified in creation. Similarly we can introduce additional
        option representing each feature bit, along with a new
        features_default property denoting the initial value for
        device_feature bits: <br>
        <br>
        # vdpa mgmtdev show <br>
        vdpasim_net: <br>
        &nbsp; supported_classes net <br>
        &nbsp; max_supported_vqs 3 <br>
        &nbsp; dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT
        VERSION_1 ACCESS_PLATFORM <br>
        # vdpa dev add name dev1 mgmtdev vdpasim_net features_default
        off \ <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; csum on guest_csum on mtu 2000 ctrl_vq
        on version1 on access_platform on <br>
        # vdpa dev show <br>
        dev1: type network mgmtdev vdpasim_net vendor_id 0 max_vqs 3
        max_vq_size 256 <br>
        &nbsp;&nbsp; features_default off mtu 2000 <br>
        &nbsp;&nbsp; device_features CSUM GUEST_CSUM MTU CTRL_VQ VERSION_1
        ACCESS_PLATFORM <br>
        <br>
        If the features_default property is left unspecified or with the
        &quot;inherited&quot; value, it would just inherit all of the
        supported_features from mgmtdev (which is already the case of
        today). <br>
        <br>
        # vdpa dev add name dev1 mgmtdev vdpasim_net features_default
        inherited <br>
        # vdpa dev show <br>
        dev1: type network mgmtdev vdpasim_net vendor_id 0 max_vqs 3
        max_vq_size 256 <br>
        &nbsp; features_default inherited <br>
        &nbsp; device_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT
        VERSION_1 ACCESS_PLATFORM <br>
        <br>
        I can definitely help implement this model if you find it fits.
        <br>
      </blockquote>
      <br>
      <br>
      I prefer XML since it could be reused and we may exceed 64bit
      limitation in the future. But we can hear from others. <br>
    </blockquote>
    I don't see how this can be re-used by QEMU as QMP is not
    taking/exporting XML. Are we talking about libvirt here, which
    happens to be one amongst many others? My personal feeling is that
    not quite a lot of human end users (rather than management software
    or script) today would prefer using XML. Instead, like any other
    iproute utility, json seems to a more popular interface for script
    and mgmt software to consume, which vdpa tool supports natively
    already.<br>
    <br>
    I think basically we can support two set of CLI interfaces, one
    friendly enough for human users, and another scriptable and
    parseable by management software users. IMO for now we should start
    to focus on the human oriented CLI design first. Whether XML v.s.
    json being an ideal interface for managment software would be
    another discussion that would need more inputs from the broader
    range of extended community, which is not worth distracting from.<br>
    <br>
    <blockquote type="cite" cite="mid:886bf07b-838d-2f7b-cb99-664c3e76a291@redhat.com"> <br>
      <blockquote type="cite"> <br>
        <blockquote type="cite"> <br>
          <blockquote type="cite"> <br>
            <br>
            When simply look at the &quot;vdpa dev config show&quot; output, I
            cannot really <br>
            tell the actual device_features that was used in vdpa
            creation. For e.g. <br>
            there is a missing feature ANY_LAYOUT from
            negotiated_features compared <br>
            with supported_features in mgmtdev, but the orchestration
            software <br>
            couldn't tell if the vdpa device on destination host should
            be created <br>
            with or without the ANY_LAYOUT feature. <br>
            <br>
            I think VERSION_1 implies ANY_LAYOUT. <br>
            <br>
            Right, ANY_LAYOUT is a bad example. A good example might be
            that, I knew the parent mgmtdev on migration source node
            supports CTRL_MAC_ADDR, but I don't find it in
            negotiated_features. <br>
            <br>
            I think we should use the features that we got from &quot;mgmtdev
            show&quot; <br>
            instead of &quot;negotiated features&quot;. <br>
            <br>
            That was how it's supposed to work previously, but with this
            series, I think the newly introduced device_features will be
            needed instead of the one in &quot;mgmtdev show&quot;. <br>
          </blockquote>
          Just to clarify, there won't be a device_features in mgmtdev
          show <br>
          since it is device specific, each individual device can have
          its own <br>
          device features which are subset of what is supported by the
          mgmtdev. <br>
        </blockquote>
        Yep. <br>
        <blockquote type="cite"> <br>
          <blockquote type="cite"> <br>
            On the migration destination node, the parent device does
            support all features as the source offers, including
            CTRL_MAC_ADDR. What device features you would expect the
            mgmt software to create destination vdpa device with, if not
            otherwise requiring mgmt software to remember all the
            arguments on device creation? <br>
          </blockquote>
          So the provisioning in the destination should use exactly the
          same <br>
          device_feautres as what the vdpa device has in the source. But
          before <br>
          this, management layer should guarantee to provision a vDPA
          device <br>
          whose device_features can be supported on the destination in
          order to <br>
          allow live migration. <br>
        </blockquote>
        Exactly. <br>
        <blockquote type="cite"> <br>
          <blockquote type="cite">So in this example, we need use
            &quot;dev_features&quot; so we get exact the <br>
            same features after and operation as either src or dst. <br>
            <br>
            If the device_features vDPA created with at the source
            doesn't include CTRL_MAC_ADDR even though parent supports
            it, then the vDPA to be created at the destination shouldn't
            come with CTRL_MAC_ADDR either, regardless of whether or not
            CTRL_MAC_ADDR is present in destination &quot;mgmtdev show&quot;. <br>
            <br>
            However, if just taking look at negotiated_features, some
            mgmt software implementations which don't persist the
            creation parameters can't get the device features a certain
            vDPA device at the source node was created with. <br>
            <br>
            <br>
            SOURCE# vdpa mgmtdev show <br>
            vdpasim_net: <br>
            &nbsp;&nbsp;&nbsp; supported_classes net <br>
            &nbsp;&nbsp;&nbsp; max_supported_vqs 3 <br>
            &nbsp;&nbsp;&nbsp; dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT
            VERSION_1 ACCESS_PLATFORM <br>
            SOURCE# vdpa dev config show <br>
            dev1: mac 00:00:00:00:00:00 link up link_announce false mtu
            1500 <br>
            &nbsp;&nbsp;&nbsp; negotiated_features MTU MAC CTRL_VQ VERSION_1
            ACCESS_PLATFORM <br>
            <br>
            DESTINATION# vdpa mgmtdev show <br>
            vdpasim_net: <br>
            &nbsp;&nbsp;&nbsp; supported_classes net <br>
            &nbsp;&nbsp;&nbsp; max_supported_vqs 3 <br>
            &nbsp;&nbsp;&nbsp; dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT
            VERSION_1 ACCESS_PLATFORM <br>
            <br>
            &nbsp; But it should be sufficient to <br>
            use features_src &amp; feature_dst in this case. Actually,
            it should work <br>
            similar as to the cpu flags, the management software should
            introduce <br>
            the concept of cluster which means the maximal set of common
            features <br>
            is calculated and provisioned during device creation to
            allow <br>
            migration among the nodes inside the cluster. <br>
            <br>
            Yes, this is one way mgmt software may implement, but I am
            not sure if it's the only way. For e.g. for cpu flags, mgmt
            software can infer the guest cpus features in use from all
            qemu command line arguments and host cpu
            features/capability, which doesn't need to remember creation
            arguments and is easy to recover from failure without having
            to make the VM config persistent in data store. I thought it
            would be great if vdpa CLI design could offer the same. <br>
            <br>
            One minor difference is that we have cpu model abstraction,
            so we can <br>
            have things like: <br>
            <br>
            ./qemu-system-x86_64 -cpu EPYC <br>
            <br>
            Which implies the cpu features/flags where vDPA doesn't
            have. But <br>
            consider it's just a 64bit (or 128 in the future), it
            doesn't seems to <br>
            be too complex for the management to know, we probably need
            to start <br>
            from this and then we can try to introduce some
            generation/model after <br>
            it is agreed on most of the vendors. <br>
            <br>
            What you refer to is the so-called named model for CPU
            flags. I think it's a good addition to have some generation
            or named model defined for vDPA. But I don't get the point
            for how it relates to exposing the actual value of device
            features? Are you saying in this case you'd rather expose
            the model name than the actual value of feature bits? Well,
            I think we can expose both in different fields when there's
            really such a need. <br>
          </blockquote>
          It's something like: <br>
          <br>
          vdpa dev add name dev1 mgmtdev vdpasim_net device_features
          VDPA_NET_MODEL_1 <br>
          <br>
          and VDPA_NET_MODEL_1 implies some feature sets. <br>
        </blockquote>
        <br>
        Not sure if this could be very useful for virtio devices, given
        we don't have a determined set of virtio features unlike CPU
        generation/model, but I think even with the features_default
        property we can still achieve that. <br>
        <br>
        -Siwei <br>
      </blockquote>
      <br>
      <br>
      Yes. <br>
    </blockquote>
    Let me get some time to implement and post the relevant patches
    (mostly in iproute) later. Basically this would supplement those
    config attributes introduced through the 'vdpa dev show' series
    below [1] with provisioned device features to reference:<br>
    <br>
    [1]
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/virtualization/1665793690-28120-1-git-send-email-si-wei.liu@oracle.com/">https://lore.kernel.org/virtualization/1665793690-28120-1-git-send-email-si-wei.liu@oracle.com/</a><br>
    <br>
    <br>
    Thanks,<br>
    -Siwei<br>
    <br>
    <blockquote type="cite" cite="mid:886bf07b-838d-2f7b-cb99-664c3e76a291@redhat.com"> <br>
      Thanks <br>
      <br>
      <br>
      <blockquote type="cite"> <br>
        <blockquote type="cite"> <br>
          <blockquote type="cite">BTW with regard to the cpu model in
            mgmt software implementation, the one implemented in libvirt
            is a mixed &quot;Host model&quot; [1] with taking advantage of QEMU
            named model and exposing additional individual CPU features
            that gets close to what host CPU offers. <br>
          </blockquote>
          So creating vDPA device without &quot;device_features&quot; is somehow
          the host <br>
          model, it will have all features that is supported by the
          parent. <br>
          <br>
          <blockquote type="cite">I think this implies that mgmt
            software should have to understand what the model name
            really means in terms of individual CPU features, so having
            feature bit value exposed will just do more help if vDPA
            goes the same way. <br>
          </blockquote>
          Exactly. <br>
          <br>
          Thanks <br>
          <br>
          <blockquote type="cite"> <br>
            Regards, <br>
            -Siwei <br>
            <br>
            [1]
            <a class="moz-txt-link-freetext" href="https://qemu-project.gitlab.io/qemu/system/qemu-cpu-models.html#two-ways-to-configure-cpu-models-with-qemu-kvm">https://qemu-project.gitlab.io/qemu/system/qemu-cpu-models.html#two-ways-to-configure-cpu-models-with-qemu-kvm</a><br>
            <br>
            <br>
            Thanks <br>
            <br>
            Thanks, <br>
            -Siwei <br>
            <br>
            <br>
            Thanks <br>
            <br>
            Thanks, <br>
            -Siwei <br>
            <br>
            <br>
            2) provision vDPA device with a subset of the features <br>
            <br>
            # vdpa dev add name dev1 mgmtdev vdpasim_net device_features
            0x300020000 <br>
            # vdpa dev config show <br>
            dev1: mac 00:00:00:00:00:00 link up link_announce false mtu
            1500 <br>
            &nbsp;&nbsp;&nbsp; negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM <br>
            <br>
            Reviewed-by: Eli Cohen <a class="moz-txt-link-rfc2396E" href="mailto:elic@nvidia.com">&lt;elic@nvidia.com&gt;</a>
            <br>
            Signed-off-by: Jason Wang <a class="moz-txt-link-rfc2396E" href="mailto:jasowang@redhat.com">&lt;jasowang@redhat.com&gt;</a>
            <br>
            --- <br>
            &nbsp;&nbsp; drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++- <br>
            &nbsp;&nbsp; 1 file changed, 10 insertions(+), 1 deletion(-) <br>
            <br>
            diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
            b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c <br>
            index 886449e88502..a9ba02be378b 100644 <br>
            --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c <br>
            +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c <br>
            @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct
            vdpa_mgmt_dev *mdev, const char *name, <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_attr.work_fn = vdpasim_net_work; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_attr.buffer_size = PAGE_SIZE; <br>
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; if (config-&gt;mask &amp;
            BIT_ULL(VDPA_ATTR_DEV_FEATURES)) { <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (config-&gt;device_features &amp; <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~dev_attr.supported_features) <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL; <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_attr.supported_features &amp;= <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;device_features; <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; } <br>
            + <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; simdev = vdpasim_create(&amp;dev_attr); <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(simdev)) <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return PTR_ERR(simdev); <br>
            @@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .id_table = id_table, <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ops = &amp;vdpasim_net_mgmtdev_ops, <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .config_attr_mask = (1 &lt;&lt;
            VDPA_ATTR_DEV_NET_CFG_MACADDR | <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt;&lt;
            VDPA_ATTR_DEV_NET_CFG_MTU), <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt;&lt;
            VDPA_ATTR_DEV_NET_CFG_MTU | <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt;&lt;
            VDPA_ATTR_DEV_FEATURES), <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .max_supported_vqs = VDPASIM_NET_VQ_NUM, <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .supported_features = VDPASIM_NET_FEATURES, <br>
            &nbsp;&nbsp; }; <br>
            <br>
            <br>
            <br>
          </blockquote>
        </blockquote>
        <br>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------BObuSjupMeTyvmP97tUNLtnM--

--===============2939223337291338501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2939223337291338501==--
