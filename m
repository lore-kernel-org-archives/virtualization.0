Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E65C00144
	for <virtualization@archiver.kernel.org>; Mon,  1 Aug 2022 22:58:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CBB060761;
	Mon,  1 Aug 2022 22:58:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2CBB060761
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=o5dHpbGj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=DvkUCxWP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aCDwWiu5LQRX; Mon,  1 Aug 2022 22:58:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 20CA3605AB;
	Mon,  1 Aug 2022 22:58:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 20CA3605AB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED8E0C0032;
	Mon,  1 Aug 2022 22:58:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D58CC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 22:58:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3963F60701
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 22:58:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3963F60701
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IR1CuJsq5_hz
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 22:58:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8390605AB
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A8390605AB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 22:58:28 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271MEYiE028814;
 Mon, 1 Aug 2022 22:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jSPhfCb0Oo0n4x7SdqObcERl+zwiTznF2KAzqKgvF3Q=;
 b=o5dHpbGjToy8ZlIGhYcjrsAlKOTh6ljNNAYHGFFAKEJ4tViOkZ+g5b0frhh+BjAn/ulD
 807ATFvNlv6CINiCGOpcQVquAODtIftFC+dwgSjzuS/ILxzwnFSj4LwLNC6tWwjOMS0G
 cWBFNIlvNjg8bWjZMSAM95apLb4apvbfsy6CVgSr8Hf71wYj253yE4TVBcPV24ffxD03
 lF4bg5/k+5etwPvaXVehGNFKSx4NjS+dfaRc6OahJg/rMia0OvpO66mFi6X/mOnp3sv8
 fn9Ps5Fn2ccNvGrGPy4qsszXAJv+POyS7J039M9H98nAvGDAYEPxHQgF1B4R7hA6bokp Zg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu80w6a2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Aug 2022 22:58:25 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 271JqOWK010847; Mon, 1 Aug 2022 22:58:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hmu31q1qb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Aug 2022 22:58:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hi9OlOZmtXyKiiX96IQmQZelM4NQx8jxZOoW1deGd4vscTx+qf78b45JMxxYV6KQ/pdz3ajN82CuewSyCj/b4zWUH3SXkVrywBn7f19THwIUeaJ5EM51Y59SjfsMZDFhb3vCd7qo8GAVXvwIg0+P0pEFr0I8qZZNgPrCasz6a1Oj3srFbb7Wq6SVwOXKKy0ZfM4pHFUvKbLOjOTmN6sNercskBXtmgNcpQJfXyNC6EvLLBwGzxpESZ4Y0mCV/a9DVbIndI5iQJzMNgIrp/wzhv4+o6tZtSuXZzgRla4UoiHhavenHh96YsA+t6X30j0L33oRXnpg5turopQufwWo/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSPhfCb0Oo0n4x7SdqObcERl+zwiTznF2KAzqKgvF3Q=;
 b=IS18Ssyjwqn96r/GiFgff7eo2ycn+Az1795PggRHHMjPd/jgN7Z0L+24Ykk8GqQ64uuUoW3qpCbbFG9wQSz/awlCKycA7Yz2c9kj6bADlHKbv0lDvHat1n6i9j0Oz+ll5YDeg+DsHS1NwDYGKfcDL2OIYw9DCpOMu1kx2y8oQ6+Pfxpn25YKFr7sXW3wB8o2KkgUKJOhHCNSGcE8o52eitPqTlVgCtQ/7X1xGoU6TAgx0+0E8GnHNnZ79HhCk4c5nV3OC0NxExyAV/VZJ0VIKbf+o98qdGChGUTGjN27L3FporlWVaCXje4B5CRuPuWJpZ0DI3kxtPeqFTEWIfZ59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSPhfCb0Oo0n4x7SdqObcERl+zwiTznF2KAzqKgvF3Q=;
 b=DvkUCxWPGEJAy4P1DvetYC1mcwfnPGYvtNxLqnrIMb8uVsGn0ANsTLbv2gHvI/IHkC9nrwe//RrxTI8BHVgO9DKL7xmUbqCsOgcASMheSOIa4cvolmVSnEd2ho6e04ns6V/1SBhgXYm3cFVQO8JeOTIxdEv4PkDWzqlsjuynP/M=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SN6PR10MB2654.namprd10.prod.outlook.com (2603:10b6:805:40::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Mon, 1 Aug
 2022 22:58:22 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 22:58:22 +0000
Message-ID: <c77aa133-54ad-1578-aae3-031432cc9b36@oracle.com>
Date: Mon, 1 Aug 2022 15:58:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 4/6] vDPA: !FEATURES_OK should not block querying
 device config space
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
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
 <ec302cd4-3791-d648-aa00-28b1e97d75e7@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ec302cd4-3791-d648-aa00-28b1e97d75e7@oracle.com>
X-ClientProxiedBy: SJ0PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::25) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7a30fb0-dd53-4084-b3cb-08da74115579
X-MS-TrafficTypeDiagnostic: SN6PR10MB2654:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KkrXB16PzHzJCFXL51YQ/4Av9SPdTvgNNwH6P3PO/M/0jLHL8Zx//K8rf9/eNs1keEJuPWfL4Y8NqkQaVla6eF37WppRwwZLyjPzSdlDcBF5Z2bycrAb4Wyp2Ik4bgw3pbPq9mqEexg2g7oywVZ7WEvgbKizrdEL7eMpdkfOyi7i32DUvgBpDQd2/EHg4MMbTuzsh+Ucc19LXTathgy1zbV55thnERN4/sYbQ1Db3Uzg6Is6hf74nWg+VaSDjVWVL67OCh2zR3EAYrLeuxCHKwLQRQnvlLy1BTy3l8mO1EURbXmQ1t2xjZ68vVQTt+SEASXspXCjQ8FtlAEeIrqgd6hZMaHkbnhyFeFF6rtydz7OpR3fqXbgZB57whDGuOy1nkivYeWVdujQYhPilV5XSmfPGFWF086mjxMOT3sR9mJiKwMa9Ls9Dc/+6QT+L5qGrYYGyuYQKslCK/7c0TMNsOwLHJh1mSTFcDTVQuFveceNKdOnMFLFdLI3GrBMCA9ppDcb7odLLSL4xNXMlw2ORyITvQLGE5ASVhwuRKLqQxpW09DA92FMdVHSEZu8+mRaJC3tatn/sodFoQVHyvKSuGPMi8cKxIb6WmV7TEAIUkaYkRgsW/2oYL3+yhl76syQCjJ03k9l8yhPE2QuiJlIiZBc0mqm6jrS9uTw6yP0Qh7kXtMjk9iNh6w3NqOq64VPl/pEBrwQe18PWbtO4RC8lSPpbM1JVXJneW5svfa17gTCz5FVYBPFwkzAJYVXWUYpOxdNBKFDU5yGMd3HYbMGIOMcN21U+qhmwzm+5TKSZKvjVWklKTZ/wpC6Z9lHtd8QhbZKCKyNIrv6MptdQ5quknlTtBJriXO7KiQ/SyeHuwk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(136003)(396003)(366004)(346002)(376002)(39860400002)(53546011)(6506007)(36916002)(31696002)(86362001)(6512007)(2616005)(26005)(5660300002)(478600001)(966005)(6486002)(2906002)(8936002)(30864003)(41300700001)(4326008)(186003)(38100700002)(83380400001)(36756003)(54906003)(110136005)(66556008)(8676002)(66946007)(316002)(31686004)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3ptTUVyLzU2RDF5dWlOK1JReVNCWUswN0IvdlN3cnRobVVFcXJrdXozQ0U3?=
 =?utf-8?B?RFZzQnV6RGdMQlRFeE1TZkRuRG5nRlBsR3pzWDlZck9zWmlUSDlCYXBEdTFr?=
 =?utf-8?B?eVVVREl3NTZBdTdLTVgzZWhxWUFKL0liWG9PdjFCelNpOGNuZEdNajZkRFVq?=
 =?utf-8?B?K0l0emVzZWEwdFljZmtRTXlRbVZxVWdsbHRWa0J1aFFpcGdjV1dXczBmM1Ew?=
 =?utf-8?B?ZUd0dFRQd1g2S3dFQlFjT0Y0bUM2NUhCWUZ0S2Q2NEJ3OGhuVEcyeEZ2SzEr?=
 =?utf-8?B?NTNOUnJ3d3p4ZXJGeGs2T2p0QVgxOEsxQkxreUNGUTVsdndqb0I0aUw5dXFt?=
 =?utf-8?B?dTVqM2hGZzdWUXpiQXE1UEloeDJwQmpWWjNLd2x5RUZRcW80RFN2S3V6Y2U3?=
 =?utf-8?B?ZzM5R3h5U05wTjN4dDBCb0lHUDl0TDNVcHRJeWxSTXZBQ2JKRXdYbzd4MXpN?=
 =?utf-8?B?d0h2N3ZCakFOajBETEloY3RpaWlabkY1eDIzcFlVRGtMWGR2VDMyTFF3Z0tX?=
 =?utf-8?B?ZjZ0dkRsbVRtZzJJSGU0d3dBQnZFWHNzMjBIY083N0c2Ym03Q3JMK08weUdJ?=
 =?utf-8?B?NEU3OThWa1hoaExQMzQ0NTExZ1IvemxVNktoZld2OGJLeE5jSzlkNGd4YWI2?=
 =?utf-8?B?dmxpMHZrcGF4YVRLMDEvRDYwTWJLUzNxMmpqYWJXcjdSZzVjT01TRnVKeVdI?=
 =?utf-8?B?Q2JhZ0FlTjUzTDIzalRuYmVWMEdhbzBUdDFZN1RSV0pGaFd6MyswcHgxZGlI?=
 =?utf-8?B?SlhRelJmTzZjREdvR2EvUGlyS0luVytGVGl3T2ZnWDZ2bkJLOWVjMCtBZGZF?=
 =?utf-8?B?OU5tZUN5VnkvTWFaY3FGS0dFam9Tck9nL2NtVUlpNzQ4Vlc4cmtsVkY1MEo5?=
 =?utf-8?B?YmlkWVVFeTVSN1VKR3p0aGJjYkJBL1cwMXh6VTlSN3JJbndBRWxLak0xVmlz?=
 =?utf-8?B?a2NZeG5JMVdqYmtqVFlXcXFzQnd6T2hXRDkzNng2VzdBeVBTRVZjeWxhaXdr?=
 =?utf-8?B?M1NmMlJ3eE5yUFJJZjBRQUxMQXFEVlpwOERsazNqRVhTMU1DVG82bmFRKzZ2?=
 =?utf-8?B?eXk3RU01U0ZPVnZLY0c2Ri96QkR6KzM1TnhjM3JnSE5hZEJXYWpTVkdXbHFK?=
 =?utf-8?B?SDhmRHk1aDRsVFY1VGQ2K0o0NlQ0cnkxa2tqSUttaWJvMlNNUjJNZ1NFUUxy?=
 =?utf-8?B?djdXWjdlWmV5UHY0Z3FoVlFWTkhDMThaVVpRM3k5VTVCU2I4RzhpMDBtUjk0?=
 =?utf-8?B?M3gvR1hXT09DaFRwUVpkQkhnTytkVFRWK1htdkFYQVZsUG1pV2JNMVdlWW01?=
 =?utf-8?B?UUxHTzd5RnQwaTM5NDdFRXNNS3BtR1VTSEl4OHVDY2k1c3VTandqSjR3eWx5?=
 =?utf-8?B?OTZKNnkvR3hrV3JLSmsrK1ArMUdJUmE4MldacU5aWmVFQWx4ZmRLZlI0TzFP?=
 =?utf-8?B?SFNwWGljYjNCY2srbUpwNVVXMFNua3BzUWE2MW5kK0FvZTRsVzJhdGhOQ0RQ?=
 =?utf-8?B?MU5CTXQvQmxrS2lkM2RwSW9hdzBUT2FvSmZGemxLdVhSektyVTdXUWk4V251?=
 =?utf-8?B?Mlg2bTVWemdBWWVQL3J4cmowZnBvSkhqdFdKQXZMQWZ3OUxWRGZoanFRdWd6?=
 =?utf-8?B?R2NTS3FwZ24wdGVCc3FyM1hMekplbnlRVkhSUzhqOGViWEk1MFc2dFNsVnFI?=
 =?utf-8?B?NDNQTEJuLy9WYVEwQzd2dnZlNW5WajZEYjVnRkNEanpYSnU5TUZnWUNjRkFv?=
 =?utf-8?B?V3IvZDF1N3QzWGxGTkRlWHdOYUJ4akVMSERTOC9EanI0bHNBQVBHL0sxM1U4?=
 =?utf-8?B?WE5LSC9CaXk3NlVpZ05JanRvRnlPS1c5eEhOVEczb0svQmpkVzhDOTVFcVFU?=
 =?utf-8?B?T2VwODVTZlg0bkkxMnQvOWx4MmtwMU0vc2dlSDlybkdzYUxUZFk0bXJERUc0?=
 =?utf-8?B?SE5EQm5RZVBKUWFEU2llcXo5bjhCVU10K3IyRWhJampVT3l2TnZDcEpGVk82?=
 =?utf-8?B?QnNiVnBnSEdoTWYvNnA2dWFHeEVVQ0xaeW1IY2Q2bW96K0I4eFJkUjNtSUJZ?=
 =?utf-8?B?bWtheERmOWdsRjNIUW9WUkdCMkx5NGtNNTZNRlBrTVY1YUlubmNTVlNmZTNY?=
 =?utf-8?Q?+yBuRzwo6bv35hAytYUFJro1V?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a30fb0-dd53-4084-b3cb-08da74115579
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 22:58:22.4745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewWIQyKqpJHnCMDD7Q40a7ZJkFKx/HCAGxyyY5SDuJvarBw8RNDTfPn2iQMwYBeM4tD4KjuNqGzTE3kAxeyI3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_11,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010116
X-Proofpoint-ORIG-GUID: OKej-driv1ur_uLZidaURjTmu2qKta9h
X-Proofpoint-GUID: OKej-driv1ur_uLZidaURjTmu2qKta9h
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

CgpPbiA4LzEvMjAyMiAzOjUzIFBNLCBTaS1XZWkgTGl1IHdyb3RlOgo+Cj4KPiBPbiA3LzMxLzIw
MjIgOTo0NCBQTSwgSmFzb24gV2FuZyB3cm90ZToKPj4KPj4g5ZyoIDIwMjIvNy8zMCAwNDo1NSwg
U2ktV2VpIExpdSDlhpnpgZM6Cj4+Pgo+Pj4KPj4+IE9uIDcvMjgvMjAyMiA3OjA0IFBNLCBaaHUs
IExpbmdzaGFuIHdyb3RlOgo+Pj4+Cj4+Pj4KPj4+PiBPbiA3LzI5LzIwMjIgNTo0OCBBTSwgU2kt
V2VpIExpdSB3cm90ZToKPj4+Pj4KPj4+Pj4KPj4+Pj4gT24gNy8yNy8yMDIyIDc6NDMgUE0sIFpo
dSwgTGluZ3NoYW4gd3JvdGU6Cj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IE9uIDcvMjgvMjAyMiA4OjU2
IEFNLCBTaS1XZWkgTGl1IHdyb3RlOgo+Pj4+Pj4+Cj4+Pj4+Pj4KPj4+Pj4+PiBPbiA3LzI3LzIw
MjIgNDo0NyBBTSwgWmh1LCBMaW5nc2hhbiB3cm90ZToKPj4+Pj4+Pj4KPj4+Pj4+Pj4KPj4+Pj4+
Pj4gT24gNy8yNy8yMDIyIDU6NDMgUE0sIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pj4+Pj4+PiBTb3Jy
eSB0byBjaGltZSBpbiBsYXRlIGluIHRoZSBnYW1lLiBGb3Igc29tZSByZWFzb24gSSBjb3VsZG4n
dCAKPj4+Pj4+Pj4+IGdldCB0byBtb3N0IGVtYWlscyBmb3IgdGhpcyBkaXNjdXNzaW9uIChJIG9u
bHkgc3Vic2NyaWJlZCB0byAKPj4+Pj4+Pj4+IHRoZSB2aXJ0dWFsaXphdGlvbiBsaXN0KSwgd2hp
bGUgSSB3YXMgdGFraW5nIG9mZiBhbW9uZ3N0IHRoZSAKPj4+Pj4+Pj4+IHBhc3QgZmV3IHdlZWtz
Lgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IEl0IGxvb2tzIHRvIG1lIHRoaXMgcGF0Y2ggaXMgaW5jb21w
bGV0ZS4gTm90ZWQgZG93biB0aGUgd2F5IGluIAo+Pj4+Pj4+Pj4gdmRwYV9kZXZfbmV0X2NvbmZp
Z19maWxsKCksIHdlIGhhdmUgdGhlIGZvbGxvd2luZzoKPj4+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKg
wqAgZmVhdHVyZXMgPSB2ZGV2LT5jb25maWctPmdldF9kcml2ZXJfZmVhdHVyZXModmRldik7Cj4+
Pj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgIGlmIChubGFfcHV0X3U2NF82NGJpdChtc2csIAo+Pj4+
Pj4+Pj4gVkRQQV9BVFRSX0RFVl9ORUdPVElBVEVEX0ZFQVRVUkVTLCBmZWF0dXJlcywKPj4+Pj4+
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBWRFBBX0FUVFJfUEFEKSkKPj4+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiAtRU1TR1NJWkU7Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gTWFraW5nIGNh
bGwgdG8gLmdldF9kcml2ZXJfZmVhdHVyZXMoKSBkb2Vzbid0IG1ha2Ugc2Vuc2Ugd2hlbiAKPj4+
Pj4+Pj4+IGZlYXR1cmUgbmVnb3RpYXRpb24gaXNuJ3QgY29tcGxldGUuIE5laXRoZXIgc2hvdWxk
IHByZXNlbnQgCj4+Pj4+Pj4+PiBuZWdvdGlhdGVkX2ZlYXR1cmVzIHRvIHVzZXJzcGFjZSBiZWZv
cmUgbmVnb3RpYXRpb24gaXMgZG9uZS4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBTaW1pbGFybHksIG1h
eF92cXAgdGhyb3VnaCB2ZHBhX2Rldl9uZXRfbXFfY29uZmlnX2ZpbGwoKSAKPj4+Pj4+Pj4+IHBy
b2JhYmx5IHNob3VsZCBub3Qgc2hvdyBiZWZvcmUgbmVnb3RpYXRpb24gaXMgZG9uZSAtIGl0IAo+
Pj4+Pj4+Pj4gZGVwZW5kcyBvbiBkcml2ZXIgZmVhdHVyZXMgbmVnb3RpYXRlZC4KPj4+Pj4+Pj4g
SSBoYXZlIGFub3RoZXIgcGF0Y2ggaW4gdGhpcyBzZXJpZXMgaW50cm9kdWNlcyBkZXZpY2VfZmVh
dHVyZXMgCj4+Pj4+Pj4+IGFuZCB3aWxsIHJlcG9ydCBkZXZpY2VfZmVhdHVyZXMgdG8gdGhlIHVz
ZXJzcGFjZSBldmVuIGZlYXR1cmVzIAo+Pj4+Pj4+PiBuZWdvdGlhdGlvbiBub3QgZG9uZS4gQmVj
YXVzZSB0aGUgc3BlYyBzYXlzIHdlIHNob3VsZCBhbGxvdyAKPj4+Pj4+Pj4gZHJpdmVyIGFjY2Vz
cyB0aGUgY29uZmlnIHNwYWNlIGJlZm9yZSBGRUFUVVJFU19PSy4KPj4+Pj4+PiBUaGUgY29uZmln
IHNwYWNlIGNhbiBiZSBhY2Nlc3NlZCBieSBndWVzdCBiZWZvcmUgZmVhdHVyZXNfb2sgCj4+Pj4+
Pj4gZG9lc24ndCBuZWNlc3NhcmlseSBtZWFuIHRoZSB2YWx1ZSBpcyB2YWxpZC4gWW91IG1heSB3
YW50IHRvIAo+Pj4+Pj4+IGRvdWJsZSBjaGVjayB3aXRoIE1pY2hhZWwgZm9yIHdoYXQgaGUgcXVv
dGVkIGVhcmxpZXI6Cj4+Pj4+PiB0aGF0J3Mgd2h5IEkgcHJvcG9zZWQgdG8gZml4IHRoZXNlIGlz
c3VlcywgZS5nLiwgaWYgbm8gX0ZfTUFDLCAKPj4+Pj4+IHZEUEEga2VybmVsIHNob3VsZCBub3Qg
cmV0dXJuIGEgbWFjIHRvIHRoZSB1c2Vyc3BhY2UsIHRoZXJlIGlzIAo+Pj4+Pj4gbm90IGEgZGVm
YXVsdCB2YWx1ZSBmb3IgbWFjLgo+Pj4+PiBUaGVuIHBsZWFzZSBzaG93IHVzIHRoZSBjb2RlLCBh
cyBJIGNhbiBvbmx5IGNvbW1lbnQgYmFzZWQgb24geW91ciAKPj4+Pj4gbGF0ZXN0ICh2NCkgcGF0
Y2ggYW5kIGl0IHdhcyBub3QgdGhlcmUuLiBUbyBiZSBob25lc3QsIEkgZG9uJ3QgCj4+Pj4+IHVu
ZGVyc3RhbmQgdGhlIG1vdGl2YXRpb24gYW5kIHRoZSB1c2UgY2FzZXMgeW91IGhhdmUsIGlzIGl0
IGZvciAKPj4+Pj4gZGVidWdnaW5nL21vbml0b3Jpbmcgb3IgdGhlcmUncyByZWFsbHkgYSB1c2Ug
Y2FzZSBmb3IgbGl2ZSAKPj4+Pj4gbWlncmF0aW9uPyBGb3IgdGhlIGZvcm1lciwgeW91IGNhbiBk
byBhIGRpcmVjdCBkdW1wIG9uIGFsbCBjb25maWcgCj4+Pj4+IHNwYWNlIGZpZWxkcyByZWdhcmRs
ZXNzIG9mIGVuZGlhbmVzcyBhbmQgZmVhdHVyZSBuZWdvdGlhdGlvbiAKPj4+Pj4gd2l0aG91dCBo
YXZpbmcgdG8gd29ycnkgYWJvdXQgdmFsaWRpdHkgKG1lYW5pbmdmdWwgdG8gcHJlc2VudCB0byAK
Pj4+Pj4gYWRtaW4gdXNlcikuIFRvIG1lIHRoZXNlIGFyZSBjb25mbGljdCBhc2tzIHRoYXQgaXMg
aW1wb3NzaWJsZSB0byAKPj4+Pj4gbWl4IGluIGV4YWN0IG9uZSBjb21tYW5kLgo+Pj4+IFRoaXMg
YnVnIGp1c3QgaGFzIGJlZW4gcmV2ZWFsZWQgdHdvIGRheXMsIGFuZCB5b3Ugd2lsbCBzZWUgdGhl
IAo+Pj4+IHBhdGNoIHNvb24uCj4+Pj4KPj4+PiBUaGVyZSBhcmUgc29tZXRoaW5nIHRvIGNsYXJp
Znk6Cj4+Pj4gMSkgd2UgbmVlZCB0byByZWFkIHRoZSBkZXZpY2UgZmVhdHVyZXMsIG9yIGhvdyBj
YW4geW91IHBpY2sgYSAKPj4+PiBwcm9wZXIgTE0gZGVzdGluYXRpb24KPj4KPj4KPj4gU28gaXQn
cyBwcm9iYWJseSBub3QgdmVyeSBlZmZpY2llbnQgdG8gdXNlIHRoaXMsIHRoZSBtYW5hZ2VyIGxh
eWVyIAo+PiBzaG91bGQgaGF2ZSB0aGUga25vd2xlZGdlIGFib3V0IHRoZSBjb21wYXRpYmlsaXR5
IGJlZm9yZSBkb2luZyAKPj4gbWlncmF0aW9uIG90aGVyIHRoYW4gdHJ5LWFuZC1mYWlsLgo+Pgo+
PiBBbmQgaXQncyB0aGUgdGFzayBvZiB0aGUgbWFuYWdlbWVudCB0byBnYXRoZXIgdGhlIG5vZGVz
IHdob3NlIGRldmljZXMgCj4+IGNvdWxkIGJlIGxpdmUgbWlncmF0ZWQgdG8gZWFjaCBvdGhlciBh
cyBzb21ldGhpbmcgbGlrZSAiY2x1c3RlciIgCj4+IHdoaWNoIHdlJ3ZlIGFscmVhZHkgdXNlZCBp
biB0aGUgY2FzZSBvZiBjcHVmbGFncy4KPj4KPj4gMSkgZHVyaW5nIG5vZGUgYm9vdHN0cmFwLCB0
aGUgY2FwYWJpbGl0eSBvZiBlYWNoIG5vZGUgYW5kIGRldmljZXMgd2FzIAo+PiByZXBvcnRlZCB0
byBtYW5hZ2VtZW50IGxheWVyCj4+IDIpIG1hbmFnZW1lbnQgbGF5ZXIgZGVjaWRlIHRoZSBjbHVz
dGVyIGFuZCBtYWtlIHN1cmUgdGhlIG1pZ3JhdGlvbiAKPj4gY2FuIG9ubHkgZG9uZSBhbW9uZyB0
aGUgbm9kZXMgaW5zaWRlcyB0aGUgY2x1c3Rlcgo+PiAzKSBiZWZvcmUgbWlncmF0aW9uLCB0aGUg
dkRQQSBuZWVkcyB0byBiZSBwcm92aXNpb25lZCBvbiB0aGUgZGVzdGluYXRpb24KPj4KPj4KPj4+
PiAyKSB2ZHBhIGRldiBjb25maWcgc2hvdyBjYW4gc2hvdyBib3RoIGRldmljZSBmZWF0dXJlcyBh
bmQgZHJpdmVyIAo+Pj4+IGZlYXR1cmVzLCB0aGVyZSBqdXN0IG5lZWQgYSBwYXRjaCBmb3IgaXBy
b3V0ZTIKPj4+PiAzKSBUbyBwcm9jZXNzIGluZm9ybWF0aW9uIGxpa2UgTVEsIHdlIGRvbid0IGp1
c3QgZHVtcCB0aGUgY29uZmlnIAo+Pj4+IHNwYWNlLCBNU1QgaGFzIGV4cGxhaW5lZCBiZWZvcmUK
Pj4+IFNvLCBpdCdzIGZvciBsaXZlIG1pZ3JhdGlvbi4uLiBUaGVuIHdoeSBub3QgZXhwb3J0IHRo
b3NlIGNvbmZpZyAKPj4+IHBhcmFtZXRlcnMgc3BlY2lmaWVkIGZvciB2ZHBhIGNyZWF0aW9uIChh
cyB3ZWxsIGFzIGRldmljZSBmZWF0dXJlIAo+Pj4gYml0cykgdG8gdGhlIG91dHB1dCBvZiAidmRw
YSBkZXYgc2hvdyIgY29tbWFuZD8gVGhhdCdzIHdoZXJlIGRldmljZSAKPj4+IHNpZGUgY29uZmln
IGxpdmVzIGFuZCBpcyBzdGF0aWMgYWNyb3NzIHZkcGEncyBsaWZlIGN5Y2xlLiAidmRwYSBkZXYg
Cj4+PiBjb25maWcgc2hvdyIgaXMgbW9zdGx5IGZvciBkeW5hbWljIGRyaXZlciBzaWRlIGNvbmZp
ZywgYW5kIHRoZSAKPj4+IHZhbGlkaXR5IGlzIHN1YmplY3QgdG8gZmVhdHVyZSBuZWdvdGlhdGlv
bi4gSSBzdXBwb3NlIHRoaXMgc2hvdWxkIAo+Pj4gc3VpdCB5b3VyIG5lZWQgb2YgTE0sIGUuZy4K
Pj4KPj4KPj4gSSB0aGluayBzby4KPj4KPj4KPj4+Cj4+PiAkIHZkcGEgZGV2IGFkZCBuYW1lIHZk
cGExIG1nbXRkZXYgcGNpLzAwMDA6NDE6MDQuMiBtYXhfdnFwIDcgbXR1IDIwMDAKPj4+ICQgdmRw
YSBkZXYgc2hvdyB2ZHBhMQo+Pj4gdmRwYTE6IHR5cGUgbmV0d29yayBtZ210ZGV2IHBjaS8wMDAw
OjQxOjA0LjIgdmVuZG9yX2lkIDU1NTUgbWF4X3ZxcyAKPj4+IDE1IG1heF92cV9zaXplIDI1Ngo+
Pj4gwqAgbWF4X3ZxcCA3IG10dSAyMDAwCj4+PiDCoCBkZXZfZmVhdHVyZXMgQ1NVTSBHVUVTVF9D
U1VNIE1UVSBIT1NUX1RTTzQgSE9TVF9UU082IFNUQVRVUyAKPj4+IENUUkxfVlEgTVEgQ1RSTF9N
QUNfQUREUiBWRVJTSU9OXzEgUklOR19QQUNLRUQKPj4KPj4KPj4gTm90ZSB0aGF0IHRoZSBtZ210
IHNob3VsZCBrbm93IHRoaXMgZGVzdGluYXRpb24gaGF2ZSB0aG9zZSAKPj4gY2FwYWJpbGl0eS9m
ZWF0dXJlcyBiZWZvcmUgdGhlIHByb3Zpc2lvbmluZy4KPiBZZXMsIG1nbXQgc29mdHdhcmUgc2hv
dWxkIGhhdmUgdG8gY2hlY2sgdGhlIGFib3ZlIGZyb20gc291cmNlLgoKT24gZGVzdGluYXRpb24g
bWdtdCBzb2Z0d2FyZSBjYW4gcnVuIGJlbG93IHRvIGNoZWNrIHZkcGEgbWdtdGRldidzIApjYXBh
YmlsaXR5L2ZlYXR1cmVzOgoKJCB2ZHBhIG1nbXRkZXYgc2hvdyBwY2kvMDAwMDo0MTowNC4zCnBj
aS8wMDAwOjQxOjA0LjM6CiDCoCBzdXBwb3J0ZWRfY2xhc3NlcyBuZXQKIMKgIG1heF9zdXBwb3J0
ZWRfdnFzIDI1NwogwqAgZGV2X2ZlYXR1cmVzIENTVU0gR1VFU1RfQ1NVTSBNVFUgSE9TVF9UU080
IEhPU1RfVFNPNiBTVEFUVVMgQ1RSTF9WUSAKTVEgQ1RSTF9NQUNfQUREUiBWRVJTSU9OXzEgUklO
R19QQUNLRUQKPgo+Pgo+Pgo+Pj4KPj4+IEZvciBpdCB0byB3b3JrLCB5b3UnZCB3YW50IHRvIHBh
c3MgInN0cnVjdCB2ZHBhX2Rldl9zZXRfY29uZmlnIiB0byAKPj4+IF92ZHBhX3JlZ2lzdGVyX2Rl
dmljZSgpIGR1cmluZyByZWdpc3RyYXRpb24sIGFuZCBnZXQgaXQgc2F2ZWQgdGhlcmUgCj4+PiBp
biAic3RydWN0IHZkcGFfZGV2aWNlIi4gVGhlbiBpbiB2ZHBhX2Rldl9maWxsKCkgc2hvdyBlYWNo
IGZpZWxkIAo+Pj4gY29uZGl0aW9uYWxseSBzdWJqZWN0IHRvICJzdHJ1Y3QgdmRwYV9kZXZfc2V0
X2NvbmZpZy5tYXNrIi4KPj4+Cj4+PiBUaGFua3MsCj4+PiAtU2l3ZWkKPj4KPj4KPj4gVGhhbmtz
Cj4+Cj4+Cj4+Pj4KPj4+PiBUaGFua3MKPj4+PiBaaHUgTGluZ3NoYW4KPj4+Pj4KPj4+Pj4+Pj4g
Tm9wZToKPj4+Pj4+Pj4KPj4+Pj4+Pj4gMi41LjHCoCBEcml2ZXIgUmVxdWlyZW1lbnRzOiBEZXZp
Y2UgQ29uZmlndXJhdGlvbiBTcGFjZQo+Pj4+Pj4+Pgo+Pj4+Pj4+PiAuLi4KPj4+Pj4+Pj4KPj4+
Pj4+Pj4gRm9yIG9wdGlvbmFsIGNvbmZpZ3VyYXRpb24gc3BhY2UgZmllbGRzLCB0aGUgZHJpdmVy
IE1VU1QgY2hlY2sgCj4+Pj4+Pj4+IHRoYXQgdGhlIGNvcnJlc3BvbmRpbmcgZmVhdHVyZSBpcyBv
ZmZlcmVkCj4+Pj4+Pj4+IGJlZm9yZSBhY2Nlc3NpbmcgdGhhdCBwYXJ0IG9mIHRoZSBjb25maWd1
cmF0aW9uIHNwYWNlLgo+Pj4+Pj4+Cj4+Pj4+Pj4gYW5kIGhvdyBtYW55IGRyaXZlciBidWdzIHRh
a2luZyB3cm9uZyBhc3N1bXB0aW9uIG9mIHRoZSB2YWxpZGl0eSAKPj4+Pj4+PiBvZiBjb25maWcg
c3BhY2UgZmllbGQgd2l0aG91dCBmZWF0dXJlc19vay4gSSBhbSBub3Qgc3VyZSB3aGF0IAo+Pj4+
Pj4+IHVzZSBjYXNlIHlvdSB3YW50IHRvIGV4cG9zZSBjb25maWcgcmVzaXN0ZXIgdmFsdWVzIGZv
ciBiZWZvcmUgCj4+Pj4+Pj4gZmVhdHVyZXNfb2ssIGlmIGl0J3MgbW9zdGx5IGZvciBsaXZlIG1p
Z3JhdGlvbiBJIGd1ZXNzIGl0J3MgCj4+Pj4+Pj4gcHJvYmFibHkgaGVhZGluZyBhIHdyb25nIGRp
cmVjdGlvbi4KPj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IExh
c3QgYnV0IG5vdCB0aGUgbGVhc3QsIHRoaXMgInZkcGEgZGV2IGNvbmZpZyIgY29tbWFuZCB3YXMg
bm90IAo+Pj4+Pj4+Pj4gZGVzaWduZWQgdG8gZGlzcGxheSB0aGUgcmVhbCBjb25maWcgc3BhY2Ug
cmVnaXN0ZXIgdmFsdWVzIGluIAo+Pj4+Pj4+Pj4gdGhlIGZpcnN0IHBsYWNlLiBRdW90aW5nIHRo
ZSB2ZHBhLWRldig4KSBtYW4gcGFnZToKPj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gdmRwYSBkZXYgY29u
ZmlnIHNob3cgLSBTaG93IGNvbmZpZ3VyYXRpb24gb2Ygc3BlY2lmaWMgZGV2aWNlIAo+Pj4+Pj4+
Pj4+IG9yIGFsbCBkZXZpY2VzLgo+Pj4+Pj4+Pj4+IERFViAtIHNwZWNpZmllcyB0aGUgdmRwYSBk
ZXZpY2UgdG8gc2hvdyBpdHMgY29uZmlndXJhdGlvbi4gSWYgCj4+Pj4+Pj4+Pj4gdGhpcyBhcmd1
bWVudCBpcyBvbWl0dGVkIGFsbCBkZXZpY2VzIGNvbmZpZ3VyYXRpb24gaXMgbGlzdGVkLgo+Pj4+
Pj4+Pj4gSXQgZG9lc24ndCBzYXkgYW55dGhpbmcgYWJvdXQgY29uZmlndXJhdGlvbiBzcGFjZSBv
ciByZWdpc3RlciAKPj4+Pj4+Pj4+IHZhbHVlcyBpbiBjb25maWcgc3BhY2UuIEFzIGxvbmcgYXMg
aXQgY2FuIGNvbnZleSB0aGUgY29uZmlnIAo+Pj4+Pj4+Pj4gYXR0cmlidXRlIHdoZW4gaW5zdGFu
dGlhdGluZyB2RFBBIGRldmljZSBpbnN0YW5jZSwgYW5kIG1vcmUgCj4+Pj4+Pj4+PiBpbXBvcnRh
bnRseSwgdGhlIGNvbmZpZyBjYW4gYmUgZWFzaWx5IGltcG9ydGVkIGZyb20gb3IgCj4+Pj4+Pj4+
PiBleHBvcnRlZCB0byB1c2Vyc3BhY2UgdG9vbHMgd2hlbiB0cnlpbmcgdG8gcmVjb25zdHJ1Y3Qg
dmRwYSAKPj4+Pj4+Pj4+IGluc3RhbmNlIGludGFjdCBvbiBkZXN0aW5hdGlvbiBob3N0IGZvciBs
aXZlIG1pZ3JhdGlvbiwgSU1ITyAKPj4+Pj4+Pj4+IGluIG15IHBlcnNvbmFsIGludGVycHJldGF0
aW9uIGl0IGRvZXNuJ3QgbWF0dGVyIHdoYXQgdGhlIAo+Pj4+Pj4+Pj4gY29uZmlnIHNwYWNlIG1h
eSBwcmVzZW50LiBJdCBtYXkgYmUgd29ydGggd2hpbGUgYWRkaW5nIGEgbmV3IAo+Pj4+Pj4+Pj4g
ZGVidWcgY29tbWFuZCB0byBleHBvc2UgdGhlIHJlYWwgcmVnaXN0ZXIgdmFsdWUsIGJ1dCB0aGF0
J3MgCj4+Pj4+Pj4+PiBhbm90aGVyIHN0b3J5Lgo+Pj4+Pj4+PiBJIGFtIG5vdCBzdXJlIGdldHRp
bmcgeW91ciBwb2ludHMuIHZEUEEgbm93IHJlcG9ydHMgZGV2aWNlIAo+Pj4+Pj4+PiBmZWF0dXJl
IGJpdHMoZGV2aWNlX2ZlYXR1cmVzKSBhbmQgbmVnb3RpYXRlZCBmZWF0dXJlIAo+Pj4+Pj4+PiBi
aXRzKGRyaXZlcl9mZWF0dXJlcyksIGFuZCB5ZXMsIHRoZSBkcml2ZXJzIGZlYXR1cmVzIGNhbiBi
ZSBhIAo+Pj4+Pj4+PiBzdWJzZXQgb2YgdGhlIGRldmljZSBmZWF0dXJlczsgYW5kIHRoZSB2RFBB
IGRldmljZSBmZWF0dXJlcyBjYW4gCj4+Pj4+Pj4+IGJlIGEgc3Vic2V0IG9mIHRoZSBtYW5hZ2Vt
ZW50IGRldmljZSBmZWF0dXJlcy4KPj4+Pj4+PiBXaGF0IEkgc2FpZCBpcyBhZnRlciB1bmJsb2Nr
aW5nIHRoZSBjb25kaXRpb25hbCBjaGVjaywgeW91J2QgCj4+Pj4+Pj4gaGF2ZSB0byBoYW5kbGUg
dGhlIGNhc2UgZm9yIGVhY2ggb2YgdGhlIHZkcGEgYXR0cmlidXRlIHdoZW4gCj4+Pj4+Pj4gZmVh
dHVyZSBuZWdvdGlhdGlvbiBpcyBub3QgeWV0IGRvbmU6IGJhc2ljYWxseSB0aGUgcmVnaXN0ZXIg
Cj4+Pj4+Pj4gdmFsdWVzIHlvdSBnb3QgZnJvbSBjb25maWcgc3BhY2UgdmlhIHRoZSAKPj4+Pj4+
PiB2ZHBhX2dldF9jb25maWdfdW5sb2NrZWQoKSBjYWxsIGlzIG5vdCBjb25zaWRlcmVkIHRvIGJl
IHZhbGlkIAo+Pj4+Pj4+IGJlZm9yZSBmZWF0dXJlc19vayAocGVyLXNwZWMpLiBBbHRob3VnaCBp
biBzb21lIGNhc2UgeW91IG1heSBnZXQgCj4+Pj4+Pj4gc2FuZSB2YWx1ZSwgc3VjaCBiZWhhdmlv
ciBpcyBnZW5lcmFsbHkgdW5kZWZpbmVkLiBJZiB5b3UgZGVzaXJlIAo+Pj4+Pj4+IHRvIHNob3cg
anVzdCB0aGUgZGV2aWNlX2ZlYXR1cmVzIGFsb25lIHdpdGhvdXQgYW55IGNvbmZpZyBzcGFjZSAK
Pj4+Pj4+PiBmaWVsZCwgd2hpY2ggdGhlIGRldmljZSBoYWQgYWR2ZXJ0aXNlZCAqYmVmb3JlIGZl
YXR1cmUgCj4+Pj4+Pj4gbmVnb3RpYXRpb24gaXMgY29tcGxldGUqLCB0aGF0J2xsIGJlIGZpbmUu
IEJ1dCBsb29rcyB0byBtZSB0aGlzIAo+Pj4+Pj4+IGlzIG5vdCBob3cgcGF0Y2ggaGFzIGJlZW4g
aW1wbGVtZW50ZWQuIFByb2JhYmx5IG5lZWQgc29tZSBtb3JlIAo+Pj4+Pj4+IHdvcms/Cj4+Pj4+
PiBUaGV5IGFyZSBkcml2ZXJfZmVhdHVyZXMobmVnb3RpYXRlZCkgYW5kIHRoZSAKPj4+Pj4+IGRl
dmljZV9mZWF0dXJlcyh3aGljaCBjb21lcyB3aXRoIHRoZSBkZXZpY2UpLCBhbmQgdGhlIGNvbmZp
ZyAKPj4+Pj4+IHNwYWNlIGZpZWxkcyB0aGF0IGRlcGVuZCBvbiB0aGVtLiBJbiB0aGlzIHNlcmll
cywgd2UgcmVwb3J0IGJvdGggCj4+Pj4+PiB0byB0aGUgdXNlcnNwYWNlLgo+Pj4+PiBJIGZhaWwg
dG8gdW5kZXJzdGFuZCB3aGF0IHlvdSB3YW50IHRvIHByZXNlbnQgZnJvbSB5b3VyIAo+Pj4+PiBk
ZXNjcmlwdGlvbi4gTWF5IGJlIHdvcnRoIHNob3dpbmcgc29tZSBleGFtcGxlIG91dHB1dHMgdGhh
dCBhdCAKPj4+Pj4gbGVhc3QgaW5jbHVkZSB0aGUgZm9sbG93aW5nIGNhc2VzOiAxKSB3aGVuIGRl
dmljZSBvZmZlcnMgZmVhdHVyZXMgCj4+Pj4+IGJ1dCBub3QgeWV0IGFja25vd2xlZGdlIGJ5IGd1
ZXN0IDIpIHdoZW4gZ3Vlc3QgYWNrbm93bGVkZ2VkIAo+Pj4+PiBmZWF0dXJlcyBhbmQgZGV2aWNl
IGlzIHlldCB0byBhY2NlcHQgMykgYWZ0ZXIgZ3Vlc3QgZmVhdHVyZSAKPj4+Pj4gbmVnb3RpYXRp
b24gaXMgY29tcGxldGVkIChhZ3JlZWQgdXBvbiBiZXR3ZWVuIGd1ZXN0IGFuZCBkZXZpY2UpLgo+
Pj4+IE9ubHkgdHdvIGZlYXR1cmUgc2V0czogMSkgd2hhdCB0aGUgZGV2aWNlIGhhcy4gKDIpIHdo
YXQgaXMgbmVnb3RpYXRlZAo+Pj4+Pgo+Pj4+PiBUaGFua3MsCj4+Pj4+IC1TaXdlaQo+Pj4+Pj4+
Cj4+Pj4+Pj4gUmVnYXJkcywKPj4+Pj4+PiAtU2l3ZWkKPj4+Pj4+Pgo+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+IEhhdmluZyBzYWlkLCBwbGVhc2UgY29uc2lkZXIgdG8gZHJvcCB0aGUgRml4ZXMgdGFnLCBh
cyBhcHBlYXJzIAo+Pj4+Pj4+Pj4gdG8gbWUgeW91J3JlIHByb3Bvc2luZyBhIG5ldyBmZWF0dXJl
IHJhdGhlciB0aGFuIGZpeGluZyBhIHJlYWwgCj4+Pj4+Pj4+PiBpc3N1ZS4KPj4+Pj4+Pj4gaXQn
cyBhIG5ldyBmZWF0dXJlIHRvIHJlcG9ydCB0aGUgZGV2aWNlIGZlYXR1cmUgYml0cyB0aGFuIG9u
bHkgCj4+Pj4+Pj4+IG5lZ290aWF0ZWQgZmVhdHVyZXMsIGhvd2V2ZXIgdGhpcyBwYXRjaCBpcyBh
IG11c3QsIG9yIGl0IHdpbGwgCj4+Pj4+Pj4+IGJsb2NrIHRoZSBkZXZpY2UgZmVhdHVyZSBiaXRz
IHJlcG9ydGluZy4gYnV0IEkgYWdyZWUsIHRoZSBmaXggCj4+Pj4+Pj4+IHRhZyBpcyBub3QgYSBt
dXN0Lgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IFRoYW5rcywKPj4+Pj4+Pj4+IC1TaXdlaQo+Pj4+Pj4+
Pj4KPj4+Pj4+Pj4+IE9uIDcvMS8yMDIyIDM6MTIgUE0sIFBhcmF2IFBhbmRpdCB2aWEgVmlydHVh
bGl6YXRpb24gd3JvdGU6Cj4+Pj4+Pj4+Pj4+IEZyb206IFpodSBMaW5nc2hhbjxsaW5nc2hhbi56
aHVAaW50ZWwuY29tPgo+Pj4+Pj4+Pj4+PiBTZW50OiBGcmlkYXksIEp1bHkgMSwgMjAyMiA5OjI4
IEFNCj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+IFVzZXJzIG1heSB3YW50IHRvIHF1ZXJ5IHRoZSBj
b25maWcgc3BhY2Ugb2YgYSB2RFBBIGRldmljZSwgCj4+Pj4+Pj4+Pj4+IHRvIGNob29zZSBhCj4+
Pj4+Pj4+Pj4+IGFwcHJvcHJpYXRlIG9uZSBmb3IgYSBjZXJ0YWluIGd1ZXN0LiBUaGlzIG1lYW5z
IHRoZSB1c2VycyAKPj4+Pj4+Pj4+Pj4gbmVlZCB0byByZWFkIHRoZQo+Pj4+Pj4+Pj4+PiBjb25m
aWcgc3BhY2UgYmVmb3JlIEZFQVRVUkVTX09LLCBhbmQgdGhlIGV4aXN0ZW5jZSBvZiBjb25maWcg
Cj4+Pj4+Pj4+Pj4+IHNwYWNlCj4+Pj4+Pj4+Pj4+IGNvbnRlbnRzIGRvZXMgbm90IGRlcGVuZCBv
biBGRUFUVVJFU19PSy4KPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4gVGhlIHNwZWMgc2F5czoKPj4+
Pj4+Pj4+Pj4gVGhlIGRldmljZSBNVVNUIGFsbG93IHJlYWRpbmcgb2YgYW55IGRldmljZS1zcGVj
aWZpYyAKPj4+Pj4+Pj4+Pj4gY29uZmlndXJhdGlvbiBmaWVsZAo+Pj4+Pj4+Pj4+PiBiZWZvcmUg
RkVBVFVSRVNfT0sgaXMgc2V0IGJ5IHRoZSBkcml2ZXIuIFRoaXMgaW5jbHVkZXMgCj4+Pj4+Pj4+
Pj4+IGZpZWxkcyB3aGljaCBhcmUKPj4+Pj4+Pj4+Pj4gY29uZGl0aW9uYWwgb24gZmVhdHVyZSBi
aXRzLCBhcyBsb25nIGFzIHRob3NlIGZlYXR1cmUgYml0cyAKPj4+Pj4+Pj4+Pj4gYXJlIG9mZmVy
ZWQgYnkgdGhlCj4+Pj4+Pj4+Pj4+IGRldmljZS4KPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4gRml4
ZXM6IDMwZWY3YThhYzhhMDcgKHZkcGE6IFJlYWQgZGV2aWNlIGNvbmZpZ3VyYXRpb24gb25seSAK
Pj4+Pj4+Pj4+Pj4gaWYgRkVBVFVSRVNfT0spCj4+Pj4+Pj4+Pj4gRml4IGlzIGZpbmUsIGJ1dCBm
aXhlcyB0YWcgbmVlZHMgY29ycmVjdGlvbiBkZXNjcmliZWQgYmVsb3cuCj4+Pj4+Pj4+Pj4KPj4+
Pj4+Pj4+PiBBYm92ZSBjb21taXQgaWQgaXMgMTMgbGV0dGVycyBzaG91bGQgYmUgMTIuCj4+Pj4+
Pj4+Pj4gQW5kCj4+Pj4+Pj4+Pj4gSXQgc2hvdWxkIGJlIGluIGZvcm1hdAo+Pj4+Pj4+Pj4+IEZp
eGVzOiAzMGVmN2E4YWM4YTAgKCJ2ZHBhOiBSZWFkIGRldmljZSBjb25maWd1cmF0aW9uIG9ubHkg
aWYgCj4+Pj4+Pj4+Pj4gRkVBVFVSRVNfT0siKQo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gUGxlYXNl
IHVzZSBjaGVja3BhdGNoLnBsIHNjcmlwdCBiZWZvcmUgcG9zdGluZyB0aGUgcGF0Y2hlcyB0byAK
Pj4+Pj4+Pj4+PiBjYXRjaCB0aGVzZSBlcnJvcnMuCj4+Pj4+Pj4+Pj4gVGhlcmUgaXMgYSBib3Qg
dGhhdCBsb29rcyBhdCB0aGUgZml4ZXMgdGFnIGFuZCBpZGVudGlmaWVzIHRoZSAKPj4+Pj4+Pj4+
PiByaWdodCBrZXJuZWwgdmVyc2lvbiB0byBhcHBseSB0aGlzIGZpeC4KPj4+Pj4+Pj4+Pgo+Pj4+
Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGluZ3NoYW48bGluZ3NoYW4uemh1QGludGVsLmNv
bT4KPj4+Pj4+Pj4+Pj4gLS0tCj4+Pj4+Pj4+Pj4+IMKgIGRyaXZlcnMvdmRwYS92ZHBhLmMgfCA4
IC0tLS0tLS0tCj4+Pj4+Pj4+Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA4IGRlbGV0aW9ucygtKQo+
Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGEuYyBi
L2RyaXZlcnMvdmRwYS92ZHBhLmMgaW5kZXgKPj4+Pj4+Pj4+Pj4gOWIwZTM5YjJmMDIyLi5kNzZi
MjJiMmY3YWUgMTAwNjQ0Cj4+Pj4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhLmMKPj4+
Pj4+Pj4+Pj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGEuYwo+Pj4+Pj4+Pj4+PiBAQCAtODUxLDE3
ICs4NTEsOSBAQCB2ZHBhX2Rldl9jb25maWdfZmlsbChzdHJ1Y3QgdmRwYV9kZXZpY2UgCj4+Pj4+
Pj4+Pj4+ICp2ZGV2LAo+Pj4+Pj4+Pj4+PiBzdHJ1Y3Qgc2tfYnVmZiAqbXNnLCB1MzIgcG9ydGlk
LMKgIHsKPj4+Pj4+Pj4+Pj4gwqDCoMKgwqDCoCB1MzIgZGV2aWNlX2lkOwo+Pj4+Pj4+Pj4+PiDC
oMKgwqDCoMKgIHZvaWQgKmhkcjsKPj4+Pj4+Pj4+Pj4gLcKgwqDCoCB1OCBzdGF0dXM7Cj4+Pj4+
Pj4+Pj4+IMKgwqDCoMKgwqAgaW50IGVycjsKPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4gwqDCoMKg
wqDCoCBkb3duX3JlYWQoJnZkZXYtPmNmX2xvY2spOwo+Pj4+Pj4+Pj4+PiAtwqDCoMKgIHN0YXR1
cyA9IHZkZXYtPmNvbmZpZy0+Z2V0X3N0YXR1cyh2ZGV2KTsKPj4+Pj4+Pj4+Pj4gLcKgwqDCoCBp
ZiAoIShzdGF0dXMgJiBWSVJUSU9fQ09ORklHX1NfRkVBVFVSRVNfT0spKSB7Cj4+Pj4+Pj4+Pj4+
IC3CoMKgwqDCoMKgwqDCoCBOTF9TRVRfRVJSX01TR19NT0QoZXh0YWNrLCAiRmVhdHVyZXMgbmVn
b3RpYXRpb24gbm90Cj4+Pj4+Pj4+Pj4+IGNvbXBsZXRlZCIpOwo+Pj4+Pj4+Pj4+PiAtwqDCoMKg
wqDCoMKgwqAgZXJyID0gLUVBR0FJTjsKPj4+Pj4+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGdvdG8g
b3V0Owo+Pj4+Pj4+Pj4+PiAtwqDCoMKgIH0KPj4+Pj4+Pj4+Pj4gLQo+Pj4+Pj4+Pj4+PiDCoMKg
wqDCoMKgIGhkciA9IGdlbmxtc2dfcHV0KG1zZywgcG9ydGlkLCBzZXEsICZ2ZHBhX25sX2ZhbWls
eSwgCj4+Pj4+Pj4+Pj4+IGZsYWdzLAo+Pj4+Pj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgVkRQQV9DTURfREVWX0NPTkZJR19HRVQpOwo+Pj4+Pj4+Pj4+PiDCoMKgwqDCoMKg
IGlmICghaGRyKSB7Cj4+Pj4+Pj4+Pj4+IC0tIAo+Pj4+Pj4+Pj4+PiAyLjMxLjEKPj4+Pj4+Pj4+
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4+Pj4+
Pj4+IFZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdAo+Pj4+Pj4+Pj4+IFZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj4+Pj4+Pj4+Pj4gaHR0cHM6Ly91cmxkZWZlbnNl
LmNvbS92My9fX2h0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9uX187ISFBQ1dWNU45TTJSVjk5aFEhTnpPdjVFd19aMkNQLXpIeUQ3
UnNVb1N0TFo1NEtwQjIxUXl1WjhMNjNZVlBMRUdERXd2Y09TRGxJR3hRUEhZLURNa09hOXNLS1pk
QlNhTmtuTVUkIAo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pgo+Pj4+Pj4+
Cj4+Pj4+Pgo+Pj4+Pgo+Pj4+Cj4+Pgo+Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
