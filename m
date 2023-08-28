Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F0CC83F12
	for <virtualization@archiver.kernel.org>; Mon, 28 Aug 2023 23:46:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 148E7410AF;
	Mon, 28 Aug 2023 23:46:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 148E7410AF
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=Ly0N9EfX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=Kls8ZRhi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mx3OkL_5BZc9; Mon, 28 Aug 2023 23:46:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CA14D4099E;
	Mon, 28 Aug 2023 23:46:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CA14D4099E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99DCDC0071;
	Mon, 28 Aug 2023 23:46:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4F06C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Aug 2023 23:46:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8EF3681E53
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Aug 2023 23:46:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8EF3681E53
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=Ly0N9EfX; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=Kls8ZRhi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H2PGZY2RKbey
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Aug 2023 23:46:26 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C0A881CE3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Aug 2023 23:46:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C0A881CE3
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37SHxPBr020337; Mon, 28 Aug 2023 23:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=g7NPSqfSxf6i5xuNL+C6+8bCPotx5gmCy9RZmMTVeMI=;
 b=Ly0N9EfXfiXpCgk2URyqP183+z0qDJX3kZprigK7HoYRW0dRon3NVzDunX6B0YfkHAy4
 LTOck4LteJgs8zc5wQYE5Bi5YevypTWGTE5AULPScPTcfYCNSVqmjMvarWYv1Ow1luxy
 TZ2hVlojOScptZOd4i6af4KSGbtFfSIoI5dqzZBJkOtQ5qxf2Nd8QyiZAmKZEutXaNqR
 sM1DO4E0fakgx3l6Rhlom5j0tVHuFsYkRG6YXI9GLgYlFE27A5rew7zIO4foo7QNNckE
 +3XO+dLIJr9g237YTrsUuAm4TKOsg0oj0bbkcg3UXJLwZ53ltkklAZa+TtN9dPqfgsWh ug== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9gckt0x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Aug 2023 23:46:21 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37SMdGbR033258; Mon, 28 Aug 2023 23:46:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3sr6dmv91y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Aug 2023 23:46:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlFhY+hMl5cH0GF7EC4LDrGoSLWQ3coM2K8OOzR9injWsXEjDDpAtO1b1k3E1qr5PJGChKCHmqu0cglq9iJF0NsdSM87dtvRY8HfQyaeU4JKE/VuWkyGrzRWt1HJte1EAfxBL9Ratwt9O+pyypm1BfGcZwveyTpIKVfOokDk3WnQJQBuXiNjNSYdQLUa0OOkUZE96nU934UzlwedMU8gTQSUTf+Ly1vexfOGtW1e4Fs9W2uKd0VD1IiKcq+/qN/Q/0D+P525Fdmi0dD14Ho+tUawOaXHxsL0bh2JdPTCJNIQQYv2ON9mCIbvfOH084+6zfTvGHRNuaqhYxFh3oobag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7NPSqfSxf6i5xuNL+C6+8bCPotx5gmCy9RZmMTVeMI=;
 b=N9usBX+JXOqYAzrDTR8pnW9x6/GV9YuOlDefTSKGKb+mDK4y0fZdYZg3afI0EGRwc2Xzurm8bxUxzo3f9IeGyQuZ4RGIFc+DfyOTPOjt9h+HvbVO+94g5ypgajNap9QtJ5e9rmpGNS7G1IdsfaebEcviO0zOSd1L7OWFQA9io/j+2aHwp+fstTKXOYoLQybu+9u/MyIczYRMDyAFo0S0T8MZaAYInXAN920lUfkxFOIoHoKQU8CGtK76fJiiAkhoaPFITWpxJCMvcKrSBcgzIJ49UFQcOogiSALLzoS91jtFB6blAZN9KybUtYg6XjzsvxJZxg/f+4nTCgB46cZUsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7NPSqfSxf6i5xuNL+C6+8bCPotx5gmCy9RZmMTVeMI=;
 b=Kls8ZRhic9MxBwdfETE/g8drcjgKVVzQmGGHeaMGjwcEViTOgI8j8DMdmH5acdpfamMFJz0yrqw+2/Fu92bjjl4MERruDQDr2L8qmIaIIPZsV2UNqdBPbAl10EytgvSg1MKgwM8X/cRCVsYotaH37bx1FH6/NGcN/ftxQxccBaI=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SN4PR10MB5558.namprd10.prod.outlook.com (2603:10b6:806:201::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Mon, 28 Aug
 2023 23:46:17 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b%6]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 23:46:17 +0000
Message-ID: <3364adfd-1eb7-8bce-41f9-bfe5473f1f2e@oracle.com>
Date: Mon, 28 Aug 2023 16:46:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC 4/4] vhost-vdpa: introduce IOTLB_PERSIST backend
 feature bit
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
 <1692063807-5018-5-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuCDN7U2ANYvRa1TuhH5iR5rb2cdHVixwE_C9zgP__9GQ@mail.gmail.com>
 <ea6ecd2b-5391-3820-d3fd-411b60a5a2ec@oracle.com>
 <CACGkMEvEpAsAA_kP=rgUfyeoq_Kj+rpZxEsxmPEZD5braxcT+Q@mail.gmail.com>
 <9f118fc9-4f6f-dd67-a291-be78152e47fd@oracle.com>
 <CACGkMEtNZnGw+O2PkZkCgOd+NiU3kw7asYsGH3EkuOHd=GvCnA@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEtNZnGw+O2PkZkCgOd+NiU3kw7asYsGH3EkuOHd=GvCnA@mail.gmail.com>
X-ClientProxiedBy: SN6PR01CA0026.prod.exchangelabs.com (2603:10b6:805:b6::39)
 To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SN4PR10MB5558:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ba8f50-36a7-41da-799d-08dba820f8bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GtEe6gCCU/N9hKDnNXVpSTfBrzYJqRznSLVfWvZnfJlTPK2AVFfW3kW+HB9noP7/AYoJOaKj3sWO7gxSxWPK2MCrPxcUjkHp4jP83XqtKNcBZzehKeBxw0QuimQ03tzf19douqfyx8zld/Rlqfo63TybDvlDyAK+9zJt2BKwLTOgdcFSKJD5ydTzzZbIt7Ohw6sIF0HTtzkX7QoJBsE9fa2tEKwffOHiDD7TgEmchuOD34zYzvk+j++0lzpb51TCH2tWoFocU2xEkEdskhHjhNylhdrZ5eCk6TG1HAcqOUJMRS3x+wiQtSdLiANknGhMrqpMEwO6BQdmbN+iXh9zh80J6fuEBsQs0O81h9ZoIVZddm0RWbWzul33yGbF5Eu31ZSDafjP6Fk+DVFhME8z5BB1DVZLKolIGmw/G4UcRZXWVGslgnqRWbV2um0KbK2T6GMkhDL0LSbzFccpCM3mmUhWojwamsahFmRlsZoM9HRKSV+37sQ1LubS3Pb8KpoWmAi9fdgAGj5tlxAv3d+7+o8Dx2e7CpgzuuAnt/MOnQ8bNkpThZe+nCjbkFw403VR3JSxKsp2j00dN4Uzug25SKBbT1n5qfvQeisLLLoqvFRXOCKkaTuTBoyzitBgQFsslikd54zeDapdv1MAMx5hQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(186009)(451199024)(1800799009)(6666004)(6512007)(6506007)(6486002)(36916002)(53546011)(478600001)(83380400001)(26005)(2906002)(2616005)(316002)(6916009)(66476007)(66946007)(66556008)(41300700001)(8936002)(5660300002)(4326008)(8676002)(36756003)(38100700002)(86362001)(31696002)(31686004)(66899024)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU9TcllDSVVNRHRjdUV6ejBjUlhkWTFuVXpHaGlnbGp2RW5SaTRjSFpoTElX?=
 =?utf-8?B?eXlubmFBRmx5MUdVdlMxTGZkS3NicGhxYWRuRUZZWWt3T0Q3WGlqS2hucDZT?=
 =?utf-8?B?S215ZHNIUjZsK1c3MEIreGMwdXJ6VTQyWXBMYTRJR1h5MWEzTUpRSXJOa0cz?=
 =?utf-8?B?V1p0Y0EvdTRiSWpFT3pRd3R0bTNaVEJDdzVsYXRXUXk1Y3dFNEdZUHhxWDl1?=
 =?utf-8?B?T0hkeVA2TlBOQW12bnpibVFLczRvUjdDOHEyMmw5QWpuY1R3VHBEWnRFMjl0?=
 =?utf-8?B?eS8rNURNNFBJMVNZYko4Uk5GbnNpRlNBYWRwV2ozdkVGVlBOb1N4NEwwT21i?=
 =?utf-8?B?REpvZGZPdTVsc0ZRaURSTk5oZW9TRjRsdDBVQmR0ZnBMUE5tTnZwTzRmNXh5?=
 =?utf-8?B?NTRiRWR4a1NmM2JNWkZmZUtNMmRWZEVsbFpFRnNSbEhMd2VHRWFlaU5lK2g2?=
 =?utf-8?B?MTJXWU1HUWhJZmh2a09FcURGeVJvVHRTeDRLZCt6MjBPZlJkSVhaMURjTEt4?=
 =?utf-8?B?aHNjSG9PbkJXSzA2ZVNuWm8xQmNtVkh3OG4wdlhtb1k3TjVrajEzZWZzd1dP?=
 =?utf-8?B?WEhGdWZvMTlMOEpoQ2tUODdIajFSVDQzWXNTQUtXbHAwQldiVVZGZ2ZrcldP?=
 =?utf-8?B?cTgwdzFZK05NbGNrb1gzMGFXTFp0dzd4dEdoV29JcWRsRXVmK25pMWJzdnln?=
 =?utf-8?B?aWwwVmxIbVVnbURZSnFHbmdIdDM3Zk1xZjlPRVVpeHk1eFV6RjVaY3JNUVF0?=
 =?utf-8?B?VnlJWlJMK283YXdwSHJhdi93MHlFTDYrOFU0d0l1bVJZWnEramZxMkU4WGhL?=
 =?utf-8?B?NG9wVWhSTEMyMWVDR2wwbEJBblArZ3AvSFp1SHJRYU5hK0Voenp2SXMrVSt4?=
 =?utf-8?B?REFBYVM0aHZEOENqM1NxZ1RXellCdm43RCt5YXVONUd6QU9WaFdqYlk4RXdj?=
 =?utf-8?B?dFVkaHBMYnl6OHNpKzBTcnAwSlc2QnlzaXd3VUd6WjZlQ3N0ZkM4eG91QXlh?=
 =?utf-8?B?VVZsMDkyaVc4WThDUzV0QkV6bEVtaXhOOHNhWEwzelJVY2xnUVhuS1pWV0lZ?=
 =?utf-8?B?UDVEc2NCUTM5R0EwSGZrNENLVUZxdkNHQS9iTFhZbDhxYUZKYXBreDZ6dVBN?=
 =?utf-8?B?Z01zN0Qwa0ZIcEZtOTFoYkNDNUozZVo2ZmtBQ2ZwR2RDK1E4ZGwvTDEra1RL?=
 =?utf-8?B?U0V0K1hHNHFYNkpVMEJHc1RmVCs1VjFTUkw2bXc0c0Q0NnFqM3dUbm5hSW9W?=
 =?utf-8?B?aUpIQUw0OVY2alVaZTNTSUJFMlNPMVhiME5LalBHWHNCekE5aVRBbzN1a28z?=
 =?utf-8?B?cktESVlxSHZXOURPS2pObHlkZlN6eXNXV0FSVWh0c3JsekMxaGwxekRFNmRN?=
 =?utf-8?B?VDVLRkdiZ09KTlcwWHQxSmc3R1VEZi9Rdmx4MTAxVHBsdmJDMERCeVJPamlO?=
 =?utf-8?B?V1hOamt4T0J1dWhscDBoMWs3c1lRaTZPdXB2c1JMVHM3Q3o3dXAwREVKWTJx?=
 =?utf-8?B?dGxGZWNPN2piVWlkQmp5cVcwZWhydEdXZkNqeTRYR3Yxa252QzB3S1ZTSHBt?=
 =?utf-8?B?ZFBLcytrbkcwdjhCZkdxTkdYZzdhalV2RWRkT2ZEdFBuaU5CUU53dmtaeWYz?=
 =?utf-8?B?Y1Y5TnNDeW4wM0c5TkNpUzhwUGwvdWVNVWZkeFE2Njd1bnh4VnF6NlJsenlY?=
 =?utf-8?B?N3NMU1dVeTNQTHE1eWo2cnN1ajRnaGNHcTVZcURqQ0VDckI2ZC8zc2l4Nmlj?=
 =?utf-8?B?dkpqU2ZWa1VnOWdvMGhzUUlMSkhyY2s5c05RVUQ4RlJjRXdjTU9uZGUxTnBo?=
 =?utf-8?B?NHZKNzFEQmlYYytQL1hBQTZyczNpekQ1N1p5eWNFdkxIY3JOMzZpZ2c4a25T?=
 =?utf-8?B?KzhJbXU1OWtyMFFUNDNhdXZSQ2tJVlc0cElGRUxxSjhrQXkrZk1HQzQ3Vmph?=
 =?utf-8?B?SXcvUDZhZ1lIaXcrRnNmb3JQVjZaa1VTdm1BdzRMU3hlQlpacVFPZTFmZ1FC?=
 =?utf-8?B?eVFuN2dQQ0sydGhoK1IxaUZLcWhlbnU5T2pGbTdTY1ZoTy8wUGVLK0ZPNlJq?=
 =?utf-8?B?YTJxY01KUkdNR1RkemJQUWg2czIyZE13VklkejlRdE9KYi9EOXlRU1NmTkwv?=
 =?utf-8?Q?k8yuw9yMNFTQHK9G3BCc68E9E?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RHcxMVM1a2lDNE9iUmFMdUFLSW9WbkhxOTFzd2tQbFhuR3d6UzNSeERCZ05s?=
 =?utf-8?B?Z3B4dFNET29CQzBRQ0duMFlCUlNPWVdhSHVWcUtnK2l0YW5JSDh1WVNoVjl2?=
 =?utf-8?B?WGt5dDBqbzlacllGMlJlb1NaVmQ2TWxQdWZxMGk1WHAxTmJiT1A5TGI5RE94?=
 =?utf-8?B?NEs4UEJha1dMZnp4SDUxUWlCUFhtQmc0WkJEaWh1eEd2Y002MHk2L214Z3E0?=
 =?utf-8?B?bEFzUXRUU0lNUkVXMHpNS2hQeXFZWTQvd0FDL0QrSEZETjNwbGM2YTU4czhW?=
 =?utf-8?B?RGI3bmVOb295N0YxUm5kYlpKVDcvRWExSVBQczRmOHBxNFpxcVNIYlRVMmhu?=
 =?utf-8?B?cFBXazlZNngxalhTMjEraERGSlBtQ0k0a1ZjaDBkQXBWeVo0bzhyNHk3YmFC?=
 =?utf-8?B?RXRMSkVIc3RLOXJTL2dBRFh0RmhjdE1RU2s1dzk3dTI4OWVOWUR1QzlwMHdn?=
 =?utf-8?B?WWJJZkhiLzVPMEgwVThNNUI1RkF4Y20rV25zcEUvekM5RkduWlp6U2l1ck5n?=
 =?utf-8?B?bWFBcmp3UWtPK05pRHU2UHFSbFV2MWR1YjZTSWY4d3hWVHo4TERlVnVZSHRl?=
 =?utf-8?B?NUhZdFlQbHVwMFovTlR6aXlnZ1ZBdTJCYVhRZ1N1YlcxeGtYaUhTeldXUGxm?=
 =?utf-8?B?RjlZTnRDSWRDalNJVmtRanYvSEhWZWU5RnoycExVdmt6OFA0a1luUi9OUkU4?=
 =?utf-8?B?MXZNdjgxb090SEZCOHFBL09nVnlpaURuZGpyd1dmU2NQTnhjRFdRdjNqRURS?=
 =?utf-8?B?MnBqc2IyWWlNWWZJejZ6RzU2NXlpdTBPaGRVS2VzeUNhTm9WZzliUHI1czlO?=
 =?utf-8?B?VDBjazArUUFtaU1EQU95RGFOUFh5SVBWSkYwb0RoY0JRTmFpVWRnWVh3bnNs?=
 =?utf-8?B?eWtFRHlUMm1UYUxqS0UvdDN5UmF5N254Zm14d0ZSQnVnSlJ3RzZQNjdxaFRH?=
 =?utf-8?B?aDRUeUMrTmtrWmlxUG5jbkhuenVyd2JsaHdzWmluaFN6R3RHVmFpTHlyTE9h?=
 =?utf-8?B?bG90UVk0VGhQM0ZIZnNJdElYRVV5c2tNWEF3aC90VDZ2c0lJRkJSNmNEcGxZ?=
 =?utf-8?B?MGtJRzdMY2MzSjI0bFE5NUZSdzRjZUJUN2xJTUdZbzFhWXpNRGl5U2NRdnR4?=
 =?utf-8?B?L2EyaDlNZTJ6N3BzY2JPREh2UVIveEQ0MnRRdnlyM1hsc2pESkdtRU1aVUd0?=
 =?utf-8?B?V3Nwc1d3WDlobEpKMVlEVTNVVGZjYndkOTA4S2xvbE1BRlRhbzRBWVdKalV6?=
 =?utf-8?Q?XfHgMVw6KT+K7qQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ba8f50-36a7-41da-799d-08dba820f8bb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 23:46:17.0710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8R4gcOjgTaujaRioNWkviuKVpEQgFCQ9/LE6DlZsBL0mT16HefyLMlfL9W4morjU8EBE33DGtySEm4XbOOeQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5558
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_18,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280203
X-Proofpoint-ORIG-GUID: y8MkRWsUQhmZo97ODn3DOka2cp-MVmVf
X-Proofpoint-GUID: y8MkRWsUQhmZo97ODn3DOka2cp-MVmVf
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, gal@nvidia.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com
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

CgpPbiA4LzIyLzIwMjMgMTo1NCBBTSwgSmFzb24gV2FuZyB3cm90ZToKPiBPbiBUaHUsIEF1ZyAx
NywgMjAyMyBhdCA3OjQ04oCvQU0gU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPiB3
cm90ZToKPj4KPj4KPj4gT24gOC8xNS8yMDIzIDY6NDggUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+
PiBPbiBXZWQsIEF1ZyAxNiwgMjAyMyBhdCA2OjMx4oCvQU0gU2ktV2VpIExpdSA8c2ktd2VpLmxp
dUBvcmFjbGUuY29tPiB3cm90ZToKPj4+Pgo+Pj4+IE9uIDgvMTQvMjAyMyA3OjI1IFBNLCBKYXNv
biBXYW5nIHdyb3RlOgo+Pj4+PiBPbiBUdWUsIEF1ZyAxNSwgMjAyMyBhdCA5OjQ14oCvQU0gU2kt
V2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPiB3cm90ZToKPj4+Pj4+IFNpZ25lZC1vZmYt
Ynk6IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4KPj4+Pj4+IC0tLQo+Pj4+Pj4g
ICAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jICAgICAgICAgICAgIHwgMTYgKysrKysrKysrKysrKysr
LQo+Pj4+Pj4gICAgIGluY2x1ZGUvdWFwaS9saW51eC92aG9zdF90eXBlcy5oIHwgIDIgKysKPj4+
Pj4+ICAgICAyIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
Pj4+Pj4+Cj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJz
L3Zob3N0L3ZkcGEuYwo+Pj4+Pj4gaW5kZXggNjJiMGEwMS4uNzUwOTJhNyAxMDA2NDQKPj4+Pj4+
IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+Pj4+PiArKysgYi9kcml2ZXJzL3Zob3N0L3Zk
cGEuYwo+Pj4+Pj4gQEAgLTQwNiw2ICs0MDYsMTQgQEAgc3RhdGljIGJvb2wgdmhvc3RfdmRwYV9j
YW5fcmVzdW1lKGNvbnN0IHN0cnVjdCB2aG9zdF92ZHBhICp2KQo+Pj4+Pj4gICAgICAgICAgICBy
ZXR1cm4gb3BzLT5yZXN1bWU7Cj4+Pj4+PiAgICAgfQo+Pj4+Pj4KPj4+Pj4+ICtzdGF0aWMgYm9v
bCB2aG9zdF92ZHBhX2hhc19wZXJzaXN0ZW50X21hcChjb25zdCBzdHJ1Y3Qgdmhvc3RfdmRwYSAq
dikKPj4+Pj4+ICt7Cj4+Pj4+PiArICAgICAgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYt
PnZkcGE7Cj4+Pj4+PiArICAgICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9
IHZkcGEtPmNvbmZpZzsKPj4+Pj4+ICsKPj4+Pj4+ICsgICAgICAgcmV0dXJuICghb3BzLT5zZXRf
bWFwICYmICFvcHMtPmRtYV9tYXApIHx8IG9wcy0+cmVzZXRfbWFwOwo+Pj4+PiBTbyB0aGlzIG1l
YW5zIHRoZSBJT1RMQi9JT01NVSBtYXBwaW5ncyBoYXZlIGFscmVhZHkgYmVlbiBkZWNvdXBsZWQK
Pj4+Pj4gZnJvbSB0aGUgdmRwYSByZXNldC4KPj4+PiBOb3QgaW4gdGhlIHNlbnNlIG9mIEFQSSwg
aXQnIGJlZW4gY291cGxlZCBzaW5jZSBkYXkgb25lIGZyb20gdGhlCj4+Pj4gaW1wbGVtZW50YXRp
b25zIG9mIGV2ZXJ5IG9uLWNoaXAgSU9NTVUgcGFyZW50IGRyaXZlciwgbmFtZWx5IG1seDVfdmRw
YQo+Pj4+IGFuZCB2ZHBhX3NpbS4gQmVjYXVzZSBvZiB0aGF0LCBsYXRlciBvbiB0aGUgKGltcHJv
cGVyKSBzdXBwb3J0IGZvcgo+Pj4+IHZpcnRpby12ZHBhLCBmcm9tIGNvbW1pdCA2ZjUzMTJmODAx
ODMgKCJ2ZHBhL21seDU6IEFkZCBzdXBwb3J0IGZvcgo+Pj4+IHJ1bm5pbmcgd2l0aCB2aXJ0aW9f
dmRwYSIpIGFuZCA2YzNkMzI5ZTY0ODYgKCJ2ZHBhX3NpbTogZ2V0IHJpZCBvZiBETUEKPj4+PiBv
cHMiKSBtaXN1c2VkIHRoZSAucmVzZXQoKSBvcCB0byByZWFsaXplIDE6MSBtYXBwaW5nLCByZW5k
ZXJpbmcgc3Ryb25nCj4+Pj4gY291cGxpbmcgYmV0d2VlbiBkZXZpY2UgcmVzZXQgYW5kIHJlc2V0
IG9mIGlvdGxiIG1hcHBpbmdzLiBUaGlzIHNlcmllcwo+Pj4+IHRyeSB0byByZWN0aWZ5IHRoYXQg
aW1wbGVtZW50YXRpb24gZGVmaWNpZW5jeSwgd2hpbGUga2VlcCB1c2Vyc3BhY2UKPj4+PiBjb250
aW51aW5nIHRvIHdvcmsgd2l0aCBvbGRlciBrZXJuZWwgYmVoYXZpb3IuCj4+Pj4KPj4+Pj4gICAg
IFNvIGl0IHNob3VsZCBoYXZlIGJlZW4gbm90aWNlZCBieSB0aGUgdXNlcnNwYWNlLgo+Pj4+IFll
cywgdXNlcnNwYWNlIGhhZCBub3RpY2VkIHRoaXMgbm8tY2hpcCBJT01NVSBkaXNjcmVwYW5jeSBz
aW5jZSBkYXkgb25lCj4+Pj4gSSBzdXBwb3NlLiBVbmZvcnR1bmF0ZWx5IHRoZXJlJ3MgYWxyZWFk
eSBjb2RlIGluIHVzZXJzcGFjZSB3aXRoIHRoaXMKPj4+PiBhc3N1bXB0aW9uIGluIG1pbmQgdGhh
dCBwcm9hY3RpdmVseSB0ZWFycyBkb3duIGFuZCBzZXRzIHVwIGlvdGxiIG1hcHBpbmcKPj4+PiBh
cm91bmQgdmRwYSBkZXZpY2UgcmVzZXQuLi4KPj4+Pj4gSSBndWVzcyB3ZSBjYW4ganVzdCBmaXgg
dGhlIHNpbXVsYXRvciBhbmQgbWx4NSB0aGVuIHdlIGFyZSBmaW5lPwo+Pj4+IE9ubHkgSUYgd2Ug
ZG9uJ3QgY2FyZSBhYm91dCBydW5uaW5nIG5ldyBRRU1VIG9uIG9sZGVyIGtlcm5lbHMgd2l0aAo+
Pj4+IGZsYXdlZCBvbi1jaGlwIGlvbW11IGJlaGF2aW9yIGFyb3VuZCByZXNldC4gQnV0IHRoYXQn
cyBhIGJpZyBJRi4uLgo+Pj4gU28gd2hhdCBJIG1lYW50IGlzOgo+Pj4KPj4+IFVzZXJzcGFjZSBk
b2Vzbid0IGtub3cgd2hldGhlciB0aGUgdmVuZG9yIHNwZWNpZmljIG1hcHBpbmdzIChzZXRfbWFw
KQo+Pj4gYXJlIHJlcXVpcmVkIG9yIG5vdC4gQW5kIGluIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiB2
aG9zdF92ZHBhLCBpZgo+Pj4gcGxhdGZvcm0gSU9NTVUgaXMgdXNlZCwgdGhlIG1hcHBpbmdzIGFy
ZSBkZWNvdXBsZWQgZnJvbSB0aGUgcmVzZXQuIFNvCj4+PiBpZiB0aGUgUWVtdSB3b3JrcyB3aXRo
IHBhcmVudHMgd2l0aCBwbGF0Zm9ybSBJT01NVSBpdCBtZWFucyBRZW11IGNhbgo+Pj4gd29yayBp
ZiB3ZSBqdXN0IGRlY291cGxlIHZlbmRvciBzcGVjaWZpYyBtYXBwaW5ncyBmcm9tIHRoZSBwYXJl
bnRzCj4+PiB0aGF0IHVzZXMgc2V0X21hcC4KPj4gSSB3YXMgYXdhcmUgb2YgdGhpcywgYW5kIGlm
IHlvdSBtYXkgbm90aWNlIEkgZG9uJ3QgZXZlbiBvZmZlciBhIHdheQo+PiBiYWNrd2FyZCB0byBy
ZXRhaW4vZW11bGF0ZSB0aGUgZmxhd2VkIHZob3N0LWlvdGxiIHJlc2V0IGJlaGF2aW9yIGZvcgo+
PiBvbGRlciB1c2Vyc3BhY2UgLSBJIGNvbnNpZGVyIGl0IG1vcmUgb2YgYSBidWcgaW4gLnNldF9t
YXAgZHJpdmVyCj4+IGltcGxlbWVudGF0aW9uIG9mIGl0cyBvd24gcmF0aGVyIHRoYW4gd2hhdCB0
aGUgdmhvc3QtdmRwYSBpb3RsYgo+PiBhYnN0cmFjdGlvbiB3aXNoZXMgdG8gZXhwb3NlIHRvIHVz
ZXJzcGFjZSBpbiB0aGUgZmlyc3QgcGxhY2UuCj4gVGhhdCdzIG15IHVuZGVyc3RhbmRpbmcgYXMg
d2VsbC4KPgo+PiBJZiB5b3UgZXZlciBsb29rIGludG8gUUVNVSdzIHZob3N0X3ZkcGFfcmVzZXRf
c3RhdHVzKCkgZnVuY3Rpb24sIHlvdSBtYXkKPj4gc2VlIG1lbW9yeV9saXN0ZW5lcl91bnJlZ2lz
dGVyKCkgd2lsbCBiZSBjYWxsZWQgdG8gZXZpY3QgYWxsIG9mIHRoZQo+PiBleGlzdGluZyBpb3Rs
YiBtYXBwaW5ncyByaWdodCBhZnRlciB2aG9zdF92ZHBhX3Jlc2V0X2RldmljZSgpIGFjcm9zcwo+
PiBkZXZpY2UgcmVzZXQsIGFuZCBsYXRlciBvbiBhdCB2aG9zdF92ZHBhX2Rldl9zdGFydCgpLAo+
PiBtZW1vcnlfbGlzdGVuZXJfcmVnaXN0ZXIoKSB3aWxsIHNldCB1cCBhbGwgaW90bGIgbWFwcGlu
Z3MgYWdhaW4uIEluIGFuCj4+IGlkZWFsIHdvcmxkIHdpdGhvdXQgdGhpcyBvbi1jaGlwIGlvbW11
IGRlZmljaWVuY3kgUUVNVSBzaG91bGQgbm90IGhhdmUKPj4gdG8gYmVoYXZlIHRoaXMgd2F5IC0g
dGhpcyBpcyB3aGF0IEkgbWVudGlvbmVkIGVhcmxpZXIgdGhhdCB1c2Vyc3BhY2UgaGFkCj4+IGFs
cmVhZHkgbm90aWNlZCB0aGUgZGlzY3JlcGFuY3kgYW5kIGl0IGhhcyB0byAicHJvYWN0aXZlbHkg
dGVhciBkb3duIGFuZAo+PiBzZXQgdXAgaW90bGIgbWFwcGluZyBhcm91bmQgdmRwYSBkZXZpY2Ug
cmVzZXQiLiBBcHBhcmVudGx5IGZyb20KPj4gZnVuY3Rpb25hbGl0eSBwZXJzcGVjdGl2ZSB0aGlz
IHRyaWNrIHdvcmtzIGNvbXBsZXRlbHkgZmluZSB3aXRoIHBsYXRmb3JtCj4+IElPTU1VLCBob3dl
dmVyLCBpdCdzIHN1Yi1vcHRpbWFsIGluIHRoZSBwZXJmb3JtYW5jZSBwZXJzcGVjdGl2ZS4KPiBS
aWdodC4KPgo+PiBXZSBjYW4ndCBzaW1wbHkgZml4IFFFTVUgYnkgbW92aW5nIHRoaXMgbWVtb3J5
X2xpc3RlbmVyX3VucmVnaXN0ZXIoKQo+PiBjYWxsIG91dCBvZiB0aGUgcmVzZXQgcGF0aCB1bmNv
bmRpdGlvbmFsbHksIGFzIHdlIGRvbid0IHdhbnQgdG8gYnJlYWsKPj4gdGhlIGFscmVhZHktZnVu
Y3Rpb25pbmcgb2xkZXIga2VybmVsIGV2ZW4gdGhvdWdoIGl0J3Mgc3Vib3B0aW1hbCBpbgo+PiBw
ZXJmb3JtYW5jZS4KPiBJJ20gbm90IHN1cmUgaG93IHRoaW5ncyBjYW4gYmUgYnJva2VuIGluIHRo
aXMgY2FzZT8KVGhpbmdzIHdvbid0IGJlIGJyb2tlbiBpZiB3ZSBkb24ndCBjYXJlIGFib3V0IHBl
cmZvcm1hbmNlLCBmb3IgZXhhbXBsZSAKcmVib290IGEgbGFyZ2UgbWVtb3J5IFZNICh0cmFuc2xh
dGVkIHRvIGRldmljZSByZXNldCBpbnRlcm5hbGx5KSB3aWxsIApmcmVlemUgdGhlIGd1ZXN0IGFu
ZCBpbnRyb2R1Y2UgZXh0cmEgcmVib290IGRlbGF5IHVubmVjZXNzYXJpbHkuIElmIHdlIAp3YW50
IHRvIGZpeCB0aGUgcGVyZm9ybWFuY2UgYnkgcmVtb3ZlIG1lbW9yeV9saXN0ZW5lcl91bnJlZ2lz
dGVyKCkgCnVuY29uZGl0aW9uYWxseSBhbmQgd2UgZG9uJ3QgaGF2ZSBzdWNoIGEgZmxhZyB0byBk
aXN0aW5ndWlzaCwgd2Ugd2lsbCAKYnJlYWsgbmV0d29yayBjb25uZWN0aXZpdHkgZW50aXJlbHkg
YWZ0ZXIgcmVzZXQgLSBhcyBhbGwgbWFwcGluZ3MgYXJlIApwdXJnZWQgZHVyaW5nIHJlc2V0IG9u
IG9sZGVyIHBhcmVudCBkcml2ZXIuCgo+ICAgT3Igd2h5IGl0IGlzIHNwZWNpZmljIHRvIHBhcmVu
dCB3aXRoIHNldF9tYXAuCkFzIGlmIHdpdGhvdXQgdGhlIC5yZXNldF9tYXAgb3AgYW5kIGNvcnJl
c3BvbmRpbmcgZHJpdmVyIGltcGxlbWVudGF0aW9uIAooaW4gY29ycmVjdCB3YXkpLCB0aGVyZSdz
IG5vIGFwcHJvcHJpYXRlIG1lYW5zIGZvciBvbi1jaGlwIGlvbW11IHBhcmVudCAKZHJpdmVyIHRv
IHBlcnNpc3QgaW90bGIgbWFwcGluZ3MgYWNyb3NzIHJlc2V0LCBpc24ndCBpdD8gSWYgdGhlIGRy
aXZlciAKZGVsaWJlcmF0ZWx5IHJlbW92ZXMgaXQgZnJvbSAucmVzZXQsIHRoZXkgZG9uJ3Qgc3Vw
cG9ydCAxOjEgRE1BIG1hcHBpbmcgCmZvciB2aXJ0aW8tdmRwYSBvbiB0aGUgb3RoZXIgaGFuZCwg
Zm9yIGluc3RhbmNlLgoKPgo+PiBJbnN0ZWFkLCB0byBrZWVwIG5ldyBRRU1VIGNvbnRpbnVpbmcg
dG8gd29yayBvbiB0b3Agb2YgdGhlCj4+IGV4aXN0aW5nIG9yIG9sZGVyIGtlcm5lbHMsIFFFTVUg
aGFzIHRvIGNoZWNrIHRoaXMgSU9UTEJfUEVSU0lTVCBmZWF0dXJlCj4+IGZsYWcgdG8gZGVjaWRl
IHdoZXRoZXIgaXQgaXMgc2FmZSBub3QgdG8gYm90aGVyIGZsdXNoaW5nIGFuZCBzZXR0aW5nIHVw
Cj4+IGlvdGxiIGFjcm9zcyByZXNldC4gRm9yIHRoZSBwbGF0Zm9ybSBJT01NVSBjYXNlLCB2ZHBh
IHBhcmVudCBkcml2ZXIKPj4gd29uJ3QgaW1wbGVtZW50IGVpdGhlciB0aGUgLnNldF9tYXAgb3Ig
LmRtYV9tYXAgb3AsIHNvIGl0IHNob3VsZCBiZQo+PiBjb3ZlcmVkIGluIHRoZSB2aG9zdF92ZHBh
X2hhc19wZXJzaXN0ZW50X21hcCgpIGNoZWNrIEkgc3VwcG9zZS4KPiBKdXN0IHRvIG1ha2Ugc3Vy
ZSB3ZSBhcmUgYXQgdGhlIHNhbWUgcGFnZS4KPgo+ICBGcm9tIHRoZSB1c2Vyc3BhY2UgcG9pbnQg
b2YgdmlldywgdGhlIElPVExCIHBlcnNpc3RzIGFuZCB2aG9zdC12RFBBCj4gZG9lc24ndCByZXNl
dCB0aGUgSU9UTEIgZHVyaW5nIHZEUEEgcmVzZXQuIEJ1dCB3ZSBoYXZlIGFyZSB0d28gbGV2ZWxz
Cj4gb2YgdGhlIGNvdXBsaW5nIGluIG90aGVyIHBsYWNlczoKPgo+IDEpIFFlbXUgbGV2ZWw6IG1l
bW9yeSBsaXN0ZW5lciBpcyBjb3VwbGVkIHdpdGggRFJJVkVSX09LL3Jlc2V0Cj4gMikgdkRQQSBw
YXJlbnQgbGV2ZWw6IG1seDUgYnVpbGQvZGVzdHJveSBNUiBkdXJpbmcgRFJJVkVSX09LL3Jlc2V0
Cj4KPiBJZiBJIHVuZGVyc3RhbmQgeW91IGNvcnJlY3RseSwgc2luY2Ugd2UndmUgY291cGxlZCBp
biAxKSwgUWVtdSBjYW4ndAo+IGJlIGF3YXJlIG9mIHdoZXRoZXIgdGhlIG1hcHBpbmcgaXMgY291
cGxlZCB3aXRoIHJlc2V0IG9yIG5vdD8KSSBzdXNwZWN0IGl0IGhhZCBiZWVuIGFscmVhZHkgbm90
aWNlZCBieSBzb21lb25lIHdobyB3cm90ZSB0aGlzIFFFTVUgCmNvZGUgc2luY2UgZGF5IG9uZSwg
anVzdCB0aGF0IHRoZXJlJ3MgbGFjayBvZiBhIGNvbW1lbnQgZG9jdW1lbnRpbmcgaXQuIApPciBh
bnkgb3RoZXIgcmVhc29uIHdoeSBRRU1VIGhhZCB0byBkZWNvdXBsZSBpdCBpbiB0aGUgZmlyc3Qg
cGxhY2U/IEl0IAphZmZlY3RzIHBlcmZvcm1hbmNlIGFjcm9zcyB0aGUgYm9hcmQgZm9yIHBsYXRm
b3JtIElPTU1VIHZkcGEgcHJvdmlkZXJzIAphcyB3ZWxsLgoKPiAgIElmIHdlCj4gc2ltcGx5IGRl
Y291cGxlIGluIDEpLCBtZW1vcnkgbWFwcGlnbnMgbWlnaHQgYmUgbG9zdCBkdXJpbmcgdkRQQSBy
c2V0LgpJIHdvdWxkIHRlbmQgdG8gc2F5IDEpIGlzIGFuIGluYWR2ZXJ0ZW50IGFydGlmYWN0IG9y
IHNpZGUgZWZmZWN0IG9mIDIpLCAKYXMgSSBkbyBub3Qgc2VlIG1lbW9yeSBsaXN0ZW5lcnMgYXJl
IHVzZWQgbGlrZSB0aGlzIGluIG90aGVyIFFFTVUgCnN1YnN5c3RlbXMsIGUuZy4gdmhvc3QsIHZm
aW8uIENvbnNpZGVyIHRoaXMgY291cGxpbmcgaW4gMSkgaGFkIGJlZW4gaW4gCnRoZSBwbGF5IHNp
bmNlIGRheSBvbmUgd2l0aCBuZWl0aGVyIGFkdmFuY2VkIHZEUEEgZmVhdHVyZXMgbGlrZSBTVlEg
bm9yIAplcXVpdmFsZW50IGRlZmljaWVuY3kgaW4gcGxhdGZvcm0gSU9NTVUgdmRwYSBwcm92aWRl
cnMsIGl0J3Mgc3VzcGljaW91cyAKdGhhdCBtbHg1IGJ1aWxkL2Rlc3Ryb3kgTVIgZHVyaW5nIHJl
c2V0IHdhcyB0aGUgY3VybHByaXQgdGhlbi4KClJlZ2FyZHMsCi1TaXdlaQoKPgo+IFRoYW5rcwo+
Cj4+Cj4+IFRoYW5rcywKPj4gLVNpd2VpCj4+PiBUaGFua3MKPj4+Cj4+Pj4gUmVnYXJkcywKPj4+
PiAtU2l3ZWkKPj4+Pj4gVGhhbmtzCj4+Pj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
