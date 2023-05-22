Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5042AC7EE26
	for <virtualization@archiver.kernel.org>; Mon, 22 May 2023 17:01:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 95415417CA;
	Mon, 22 May 2023 17:01:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 95415417CA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=T1COJnza;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=LXbL+HBa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bnEhnAT2Gh3S; Mon, 22 May 2023 17:01:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BBFA0400A6;
	Mon, 22 May 2023 17:01:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BBFA0400A6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C371C0036;
	Mon, 22 May 2023 17:01:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45C11C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 17:01:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1684941DD4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 17:01:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1684941DD4
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=T1COJnza; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=LXbL+HBa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sdlcJo-Ujz6K
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 17:01:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2205141DD3
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2205141DD3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 17:01:01 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34MFkBOD012320; Mon, 22 May 2023 17:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=fKxu/KW6A5Ql4NDyutkZ8rAm9NjzR6hmWzWUkB7QZjU=;
 b=T1COJnzaidK1jtGfQOcT3WxYBtJzQlLzQDYZ2rjPsKpIzlRGpXb9szVMQfyVUk9NyGzw
 wXAlW643bZxeed7uyJztMf9FEKIRyaoGCmkPIWn5roytCDapNlBdi39zPKVgbh0Cz9mo
 ZoAObCKa2iPSsRTuEhbr1x3R4xvGo1PHT3/RKwP+YsI3Y3z1X6ExXLrnNihXWmqMzR2p
 KYvugclQt0Lpr0rDqdvhSsodRPt5C87ZiS6wV7VXaZRY7Ce9sMVXDWBEwonFpHmMPuRb
 eoI0JnQtx3Sz2qkWXkDyk8PBlycuxu8/p3aydckLMfkrToyv0jxasKBmFYFLWf4pRQsj rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp8cb9k7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 May 2023 17:00:46 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34MFuPdj029303; Mon, 22 May 2023 17:00:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qqk2py5sd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 May 2023 17:00:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZx8FjgF1r7NxKNpPQ+0f4MjifjQIjmjoh2kMAKcsBin02ELToQbBSd0Jc8bWuYImUGwVjDONwj2YZOGD67UvCldMnbwpeM4DqFaQYCdD1q+iwI9kOb69XQFpMhIBRtaP2fp2zPG6A/+JqeX+fCeFMGYouonIY1pctgZ1u7RFGI1rTJlbAE2XnJ6qwIZQlbHCzj7s5bf6qyVpAK9pLArO4M7nOJHOoJaB0lszykSEv6010FRHK9Rls6iuI7ISykWJZQtuWqKqdeqnPUtbAudLC+L8xEZ5N2FR/GAo4bnQn0G1Dt3oh6qQLFPoYpD3aEJQF6ceTbDugNcC3Z4mZOPCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKxu/KW6A5Ql4NDyutkZ8rAm9NjzR6hmWzWUkB7QZjU=;
 b=LcZK04UBGH8BxQrxCEWI/bLeRgVk1YEzO47cEDCLShXBT7xCKejGEtjxwsmpRG866WxbBpz7DMl2geH/wLw1d322tsRXds8v/g0MWgr7GDAb79jmq8FpDLXImoHVwPssQBmk52zleISQ9bk6176ldzULq3jq+n5E9V5cpkmGJSSPoCXTgM9VSa/DymfVeu1RCzOh3oYn4crWFkED4/nA5bANCibmzkwf/lP6bqkqnqP5dEBIvRs/Nig5v+Gc924dtTeiSe2ly8NSOoIOn3COD3HzuLAbzvIJbccjrfbST7iYEIHemymxTyMuY9gpOlqbGQj+TyGLbbSH9UlJQ5V8Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKxu/KW6A5Ql4NDyutkZ8rAm9NjzR6hmWzWUkB7QZjU=;
 b=LXbL+HBah9CqFkyQrx5Zc/OMCbcxs92cSE55lZYXcI0+R3212B+Sugx5saLIYAazJtq4tmFQGhKy92eRoTj0yuf1BVvuEs5dqFMPZr17gW6rUmxu10oRvXOAi7c8m+OaHb7yMF6mmug06m5Duvq3ikDgyW5zbPBMwc1UW7RTlAY=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SA1PR10MB7588.namprd10.prod.outlook.com (2603:10b6:806:376::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 17:00:42 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 17:00:42 +0000
Message-ID: <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
Date: Mon, 22 May 2023 12:00:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Content-Language: en-US
To: Oleg Nesterov <oleg@redhat.com>
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230522123029.GA22159@redhat.com>
X-ClientProxiedBy: CH2PR18CA0023.namprd18.prod.outlook.com
 (2603:10b6:610:4f::33) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SA1PR10MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 0145aea8-d801-443f-aa8f-08db5ae613bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+fbJJBg9yBSLkh7B2uK9cgy/li4l5qLLJKO6OG/CPnVwNkNUGDZtWnL+YIUXwCiLnEh0EUpOFOpWbKVEECY83HwElCUk8DWdDya/e9iYDZglIC5PrjeyDOu0X55WN+2gSsuXbaxvT+rTdBNUgytkik8yzZVXwoIbafUMTxzoQ71064ENS/JuGsNnbiieAbSnwuwmBvQL3gRp7HkTvIWbj3GSJCqQQPm69QkMAWxfWPaOY/yqHkZa3oUFUXBD3KmlMODwCk+OEULjlaxsUNvlJnV9J85BX3ll32AHS9bK9w7MBG1WLRXsraY+jmL57NFElyXie59VHxkfyBOdTuokkPNhijYjfL/ACM9S62PUD70AAtAmLWVLG7FsRF6SIbbvNnTNfsq8sng71XmoF0X9+b02HOenBLrVoDjPQlc29rTH1YhJxhlZDyNuP8/k2K4LDPpmCYIkO2zYQzt21FId8SSCq3hFesuYiM2zI2N1HruUjrBcSspnr+MCVh5/JhVIdAV0AOmNGNkgQVjAFWZQalnyCmZ9lM7cJRNEL7LuOTsjfTwkftKEx9r0aWmYxRBxrilnLFwXbql5q4s8PBwFd+ZpYSgM09BEffmQ5x5IrSFfcmVsymoWfCLRn5H1hZdP7jEn01iMTsUWn6NjS5FcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199021)(31686004)(5660300002)(66476007)(26005)(41300700001)(6486002)(6666004)(186003)(316002)(4326008)(6916009)(6512007)(6506007)(7416002)(8936002)(8676002)(53546011)(2906002)(2616005)(478600001)(83380400001)(66556008)(66946007)(38100700002)(36756003)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFBMY2ZNVUlWd3RGWndaSEY0RmlSRWVUdEhGTXpiQ2x5ZXRtVDZGSE80NVlK?=
 =?utf-8?B?Y2xRRk03S0VNbmhXTUs4RW1XdlV6ZjE2WnFNalk0RDFFaHZIbi9EUVlxcWxC?=
 =?utf-8?B?RzVrNHp0c3VhakprZU8zT1liMmRzSDY1KzFKZnFpSGZTckI1bDRQbExDcFNO?=
 =?utf-8?B?QXFtdmdmVFEyRDJ4RXFMTFZ5VHkyUWIyT2JQM2ZtMWJCR1ZISk5KS1NiVnNq?=
 =?utf-8?B?ZEtiVGd6MVE4NzlTU0hnWGJVdTNMa1o0eWRubWhDY0x6MFNacVk0YnMxQURs?=
 =?utf-8?B?bHhERE1hVnAwOGVPL2R1dnE0Y2t5dFpRaGNCUjZURVVmTXF3cU9WVEVVVklj?=
 =?utf-8?B?d2hEVW1mbm8xc2JUV3lSMEFoR1ZDZUFGdjAwa1VJYnFHU0tPcXFQejdmc2dX?=
 =?utf-8?B?UUFNUjlJRXVtQU1JY25WTG1QUUxiQXRzVGlmSTZvQjh5emdqcmJZY1F6eFBu?=
 =?utf-8?B?eW5DVjZ0TXdJQWVqeFdNZG5NYlY2eERBRk9mWTBwV3luYjN3VDRYdzRxU2Ro?=
 =?utf-8?B?R0tvRjQ4bldSdnRrSU9NZHg2bFFyWUxweWpuMm12MDNlN2pMM1hsWlNmZ3kz?=
 =?utf-8?B?TkpmNVNMdlpvV1lCVjZkWmt6VUY2M3BsMzJhY3BBdjlkdXBydUU5c2ZlSnkx?=
 =?utf-8?B?dGdGWG50S3hid2w3eXJpTmx5aU9WWHdJNFZOaysvajlDVHJnQjNvcjZ0RHRn?=
 =?utf-8?B?YWlhVHF5b0Y4RXdtVWJ4T1RERGM5SkxZZzFOdXQrVzRuN3ptRERBaXU4bFM1?=
 =?utf-8?B?ekVwSmRjL05INllNMGxXeUN2L0RvcVlTbk1jYSsrdjVRdXREVlNDbGJ0ZDFW?=
 =?utf-8?B?Q29UUU9VOWpNL2Z0VXVVYVpVQUZJYlBENHB6dnJFYUxXT0pUUVhBNjZBK3Fp?=
 =?utf-8?B?c3lkaXhROGJQOVFaTEhyQ25DSmQ1SlkyZ21wZFZvc1pKSVFwUzBHT3VpeUkv?=
 =?utf-8?B?clVjTW5KLzVHSm0yazNST2xMU1hENEZpSnNwR3hISkhxdVNQMDdSaE5NVHM5?=
 =?utf-8?B?eDBmM0ZrNUlGbi9PazR4VXdnU3p3UlgySGhFWndVTzdmQnZtRWlIeVpuc0ZT?=
 =?utf-8?B?Qkd5aUZOTDF5OTlkZ1lNNk4xQlFpSnpZa05VbCs3TXFlYzdueG9NL1lFb3l3?=
 =?utf-8?B?VzhoYU0vUlNKWFQ5VXNQeVdPTXI0Z250NFJXMG5kU3RyR1A3US9Uc2JZQXBE?=
 =?utf-8?B?cVJMTmMwUWFSelp2WGpheDhvWC85MExJMEtoOGpDYkJhNDZtWCttLzNTS0NT?=
 =?utf-8?B?VWZtbDFSL3BUNS9hdXIwb0RGNFIraTZpcWFVM2VsQU0wWGZES1VqY1pHaDE5?=
 =?utf-8?B?THhNM2hoaWRpNWdwTExBQ1Y3WFZBVjd4TDk5SlRZYlJEVSt6ME5HQjg0UkVk?=
 =?utf-8?B?Qi9rampzamZ2cmFtMHM0OW1OKzVBb25NUGUvMG1oK2JWQWQ1Zm9mci8wemtV?=
 =?utf-8?B?N2tudjJtRkVJa1JCbnNGY0xyMHVZeUp2dUJ5NEJJOUV6Q1RVdEUvZURUTnk3?=
 =?utf-8?B?bnJ4SXB5ZVc5UE56SHBTTk9rT1p1OHpDREJpMDFwcFlhRFNIRUpCNkxmMFVS?=
 =?utf-8?B?bzdObFJMNHh0ODVhM2JOeHpwVVdZQXhhYTBUVytBTVdxMGI5UzR2Q2hjQVI2?=
 =?utf-8?B?UTRoL1JIU3VKYklSanFBWkRPREJmRWhDZmVTNGFJV2JENS9vc0Y2TEZXajJV?=
 =?utf-8?B?OFByVytyY2Y0MGNCcTROVEpETTlyeXZjR1BqMzZyTmMwamZNaHhXcWFVazN6?=
 =?utf-8?B?OWJMMkZxQlVZL0xmRlVJSE9zY1NtMEwzdC8zTm42c0tRSWJLZExEdVNmQjdC?=
 =?utf-8?B?ZUFGZzJLREZJVnJDVDFjYytsS2lFaE5PeVlXZ1UvdVoyTCs4dWJPRTVyQ0la?=
 =?utf-8?B?YTQ1S1VjUGdrc0tCRmVCNTlNVWhhKzE5TXBhOUc0UlpaOUtTMHU0ajlxTWJw?=
 =?utf-8?B?ZkVBNHpvOTlzQkR6eUc2WUl3TkN4RW9nVXZ0L0VUcmlORWFJZzJScXlRL0s2?=
 =?utf-8?B?TzlrZlFzK24wcDgvalBWbVBzRU9oZEl2d1BRNkNFODBKSXZFQ3FvWEk2N1hi?=
 =?utf-8?B?aGpVeEpNLzdJVHJPVkVPYXFYSlBWVDRtalVpYWs1S3E3NTRKcVg5VFZ0eitI?=
 =?utf-8?B?VnBYa05obllCemV2MzgrOE1VZlJtRWdiVFg3Q0RrdjdyeTVIb1p3dk9tTldL?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?elNkNFVsdHVTWERBSWNFZmhjazVXWTR1RnF4Nm11bE1NRnBObGV4NjQyQm0y?=
 =?utf-8?B?U1FGNUxHM25wUmdIdEE2VGJ1eGlaMU84aUJwZDJyTXQ1alpwR1ltbW0zV0Z1?=
 =?utf-8?B?NUZ1UTFRQVJQaFFic2dtdllmTEpGWnROZGphZEVQcHIwMEh4RHlIYkpzSmdZ?=
 =?utf-8?B?c01icmJaTFFiTGNuVEN2MkNndlVZZXBDSWdtSU8wVjNjVGc4Vk1wemQzVERX?=
 =?utf-8?B?ZlNZdWJCU2ZvRUZ6dDF1eUlZMHhLTXVpZDBrV3hZbzBjVVBVVzN3NUlYVWhm?=
 =?utf-8?B?dGl1SkNndTFaNG9oMkVVREMvRk5NaWJRa0NCc1NybEVTb3dJOGVuNHBQUTIr?=
 =?utf-8?B?blBEdXpVWnNvLzZXa3RpVTEyQnVHaXJtR01GNy96K2JKWTFGM2wxbDJvNXo5?=
 =?utf-8?B?T3IrRldJa3A1R2xVL3pVejExbDByYkxaTmduZUwzU1c2OEJFSUlFVTlKU1J3?=
 =?utf-8?B?R2x3ck9UTEN1NkVlTWtWWHF2aW1CMWMraXVIYlNMdTQxUHgwRmEzdE5FMVAx?=
 =?utf-8?B?RStDS0ZreWp6M0E2L2tkRlJSWDk5cm52Qnd6cStIaVBKd0tZVFZqV0NQQWZa?=
 =?utf-8?B?TVgwelpNL1pYZDZoeFhiMFgxSWZaY2E2VzN0OVp5WWU2aFQzN2ZXUUpnams1?=
 =?utf-8?B?MUZqUzBNT0h2WTdabFkxMHlvUUpDQm1JY2l0OXM5NFk5bTlQR09FNitSMEFZ?=
 =?utf-8?B?RSs5dnV3MkZTMVJ4TzhCSVVQbUM4YW9sK1AwbmM5TTAxM2l2RGtvVG5kVG15?=
 =?utf-8?B?YlBFV0x1RGY2V2krTUNLdlRVU3QwM21QUW53YWJkd0ZIbEFTM1ZnU1UxTGQv?=
 =?utf-8?B?KzRndm9FVWhBY3Uvck51bk4vb3lwZklGRFRmaUtXRWc2MUY1RzFYK1JoK3Ry?=
 =?utf-8?B?bkFydnozRklMYTJvd2xyT1N1NVhmR3dCMGkxNXdleXc4SGNIVVNJWDNJME1o?=
 =?utf-8?B?Y3VhWExTQnM4OVBiZHZRelgzV1plYk1FWmN2WXE1dTJKaTNWQ0dVRmVOVFlY?=
 =?utf-8?B?aXpTd0Y3YlhBeDJ2REgvejBIcnZ1T085YXM1cVplbHR6eXFobVM2RUIxbVY1?=
 =?utf-8?B?TjJQOEtYWmxhNzlqb2VnaVlCVXhTbDRjM0FScys1ek9pSFNQR3VsMnlIYnBI?=
 =?utf-8?B?cnBZTjEyc1hHb2dLVG9DT1pQQmNNZFpFOW9hZnY3VXVYekNLVEZ1NTVUV1NB?=
 =?utf-8?B?Rm05WTZJNjF1dHoxa1U0QXcwK0ZGTWVETm80OHFDbDR6M0tKTDlIQ2lKUW5j?=
 =?utf-8?B?SEp0WTc5K0E5K05HVG9oSWtnbnFxako2ejRZRWRqTUREOFdtdmtVZC9qcjhJ?=
 =?utf-8?B?aW1QVkkvWkJNSXUzdmQzaG0zZkNKVWxja0w5NkNneVhGQzE2M3RzQWc4dzdB?=
 =?utf-8?B?bXR1YnlTSUVMNm1Lb3V1NVVJcitaamcyMHd4ZG01TVV6TnBvQ1h0R1orVTNM?=
 =?utf-8?Q?vkKmLrhs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0145aea8-d801-443f-aa8f-08db5ae613bb
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 17:00:42.4486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbELgi4bmMQCAA6aU9qG1WnCzL6RKP2cI4k2tdS/21MJfelZMv0Ho0QwXGKofI7bIQUN7MJhIgOUFfbofBQ7k/jfBDcyxSJ3jTUHVM6Cexc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7588
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_12,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=908 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220143
X-Proofpoint-ORIG-GUID: 4AYpBPgjPhn4AMuZv7VaG2pQT8_b15oS
X-Proofpoint-GUID: 4AYpBPgjPhn4AMuZv7VaG2pQT8_b15oS
Cc: axboe@kernel.dk, brauner@kernel.org, mst@redhat.com,
 linux-kernel@vger.kernel.org, linux@leemhuis.info, ebiederm@xmission.com,
 stefanha@redhat.com, nicolas.dichtel@6wind.com,
 virtualization@lists.linux-foundation.org, torvalds@linux-foundation.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 5/22/23 7:30 AM, Oleg Nesterov wrote:
> Confused, please help...
> 
> On 05/21, Mike Christie wrote:
>>
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -338,6 +338,7 @@ static int vhost_worker(void *data)
>>  	struct vhost_worker *worker = data;
>>  	struct vhost_work *work, *work_next;
>>  	struct llist_node *node;
>> +	bool dead = false;
>>
>>  	for (;;) {
>>  		/* mb paired w/ kthread_stop */
>> @@ -349,8 +350,22 @@ static int vhost_worker(void *data)
>>  		}
>>
>>  		node = llist_del_all(&worker->work_list);
>> -		if (!node)
>> +		if (!node) {
>>  			schedule();
>> +			/*
>> +			 * When we get a SIGKILL our release function will
>> +			 * be called. That will stop new IOs from being queued
>> +			 * and check for outstanding cmd responses. It will then
>> +			 * call vhost_task_stop to tell us to return and exit.
>> +			 */
> 
> But who will call the release function / vhost_task_stop() and when this
> will happen after this thread gets SIGKILL ?

When we get a SIGKILL, the thread that owns the device/vhost_task will
also exit since it's the same thread group and it does:

do_exit -> exit_files -> put_files_struct -> close_files -> fput

which eventually (the actual put is done via the delayed work path
in there) runs the file_operation->release.

So the release function is being called in parallel more or less as the
code above.

> 
>> +			if (!dead && signal_pending(current)) {
>> +				struct ksignal ksig;
>> +
>> +				dead = get_signal(&ksig);
>> +				if (dead)
>> +					clear_thread_flag(TIF_SIGPENDING);
> 
> If you do clear_thread_flag(TIF_SIGPENDING), then why do we need 1/3 ?

You're right. I don't need it. I thought __fatal_signal_pending checked
the shared pending as well but it only checks pending.

> Also. Suppose that vhost_worker() dequeues SIGKILL and clears TIF_SIGPENDING.
> 
> SIGSTOP, PTRACE_INTERRUPT, freezer can come and set TIF_SIGPENDING again.
> In this case the main for (;;) loop will spin without sleeping until
> vhost_task_should_stop() becomes true?

I see. So I either have to be able to call get_signal after SIGKILL or
at this time work like a kthread and ignore signals like a

if (dead && signal_pending())
	flush_signals()
?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
