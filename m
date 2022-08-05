Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CA9C00140
	for <virtualization@archiver.kernel.org>; Fri,  5 Aug 2022 23:27:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76B1C60FF0;
	Fri,  5 Aug 2022 23:27:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 76B1C60FF0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=N3G3VFUa;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=QhXb2yLS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xZyYvVQQr0fc; Fri,  5 Aug 2022 23:27:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9EA1160FAE;
	Fri,  5 Aug 2022 23:27:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9EA1160FAE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 577F6C0033;
	Fri,  5 Aug 2022 23:27:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BAE4C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 23:27:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E6EB740BD1
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 23:27:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E6EB740BD1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=N3G3VFUa; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=QhXb2yLS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DH0LfNTEvdGz
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 23:27:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD5164011F
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD5164011F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 23:27:09 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 275MSsj1012684;
 Fri, 5 Aug 2022 23:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=z9UuGkL6fQstCMcjuLuOgrX/fktKl5fSwJOdX2Ny37Y=;
 b=N3G3VFUawR36vMZ77uVA1GfWMBtAGmEJqEWWqMqNlqm+Yje8L/LhN871VvEWbvvYg36A
 p4ZTBSFYqu+9oS/oMi47r8VAMwhS0SLNalc5G62z6Vcr8H2t5VfE54Aly6QjxXPYt5RC
 jjGdNgCEkJ+YnEzweJao4AOM5w3+W8kDPzriRfoXzt9uOKGP1RJGJMm+lN2e5jUFGMBO
 Ey5itOHFkeu4tUdpdlZPB8Ka/adoz0rj1Llh1AnMnjVmAc4zBed87EKXK7vw87xIapNx
 5OEwAvVM4O2SVRoFTuuEfYvpSokQftYNQRAcHc2hTgyPhX2+MsMjOFV55Byy8US1RX3L hg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu818yr9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 05 Aug 2022 23:26:54 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 275JNuWN001154; Fri, 5 Aug 2022 23:26:53 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hp57up8m4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 05 Aug 2022 23:26:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PB1hjm01t/ZYAYm9f0r/3kcy7rBQ2e/hJigc+hIR+jLAVlwuneQr9im9UYKIpt5MvP59VoN2QJDGCjFtXwQNtLCo+XFGWvX5n+HhVWt63ck9wL38auzXEacgmWFnrXx9qVQOoAdZOWgmLT4XnAz7coqDjS+yymgSgLl/DgWg3feWIG2y2zWm6cDkOaNJV4i/tJouZEbmpBaLZLmTSUDfL4oK1DM/Cl4nePLqzXcBtLvSsKiic7aMu/fsvHgEWjcjfhDsfpwBLdnDcdOGzWdaVQcsPMH5UTQmm3hf/b3L/DFXMlDoyYc5eg/KOhF4mXmhzNKvHbv5ismKbyE6Je9Lfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9UuGkL6fQstCMcjuLuOgrX/fktKl5fSwJOdX2Ny37Y=;
 b=OUzhut0RbyPAevJ53HBnNmYL8zejq+G9oUsmXBIGt8+xt1BmFJ27aGzd13DE0E4PdknxEXCHStFRTF8fzd3/JJ+ZiX6lCQOW3vGrJqalf6dTw1QPTWD/nv40RmNQHi9PuH7mTtWcPJ9Futt/UPw8qm46kXbUZuvAKMbFdUocbrlhclUIXJtcC5DatF8zs2wGPVInea1i9gmzpdAZS/HFPF9QsSvK+d6Si2BrQqfa6MXFtAJxs09TvclLE7+Y9uDI+6EY2z8YdXw0HOSjMO8Fz8TDABcqtCOzwOW5ZnC0xu81uY/Sn+FZ2fo0xuhMpXsj6tTbwvWj1enElbjReI5R5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9UuGkL6fQstCMcjuLuOgrX/fktKl5fSwJOdX2Ny37Y=;
 b=QhXb2yLSuuAOB5P2pjXDLSrEestfAKXdsnGuNE5eXmfKIJwUmw/fNHUqaLHQybURtLOvS8l5aGyC+miuyDf1Tg+xONp/nIFGVtoYDAZsNCmWf67RmeS3LLdnP2okIbuxpaas2a+JKxDCLYqci2D0WS27RXsl02eXYVZFIQz/GMA=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BN6PR10MB1348.namprd10.prod.outlook.com (2603:10b6:404:42::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 23:26:51 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 23:26:51 +0000
Message-ID: <62682efb-f5ed-65de-d209-566738479025@oracle.com>
Date: Fri, 5 Aug 2022 16:26:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: Gavin Li <gavinl@nvidia.com>, mst@redhat.com, stephen@networkplumber.org, 
 davem@davemloft.net, virtualization@lists.linux-foundation.org,
 virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com,
 alexander.h.duyck@intel.com, kubakici@wp.pl,
 sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
X-ClientProxiedBy: SA0PR11CA0146.namprd11.prod.outlook.com
 (2603:10b6:806:131::31) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7313fb8-af5e-418b-b065-08da7739f95b
X-MS-TrafficTypeDiagnostic: BN6PR10MB1348:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: STLFl0SZW2w2zK529NYSOWr3EBnQldllVW2cXwU1cN80w8Tq+/zTMs1MiGl82pPSi96vu83RgL+3gtLJ0Y4YCQvOMw2vpz16sNYgiAO3YvGvmUX8dcl+MzPRtEdBi/+Pktb5sPSgfvRyrHjyK1aG0HgDYqP5YgH30Bjbv7XLGMR/AVbKxxiUf+ry7c1p43jRIE73qex/rsgiqhFA6SjHjzsi0X7J4JUNbwGfwwtRUTm0qfxyFbB56ql881Me9V8epAl4s9M2BUwFP7t1WXdZU5dIK+5XTJuyLvy6bICmKGBVHuUyekpUD+I9RmOgCnWWbmPO3xAxB1Jk6KrkBktwFscirfDXlkBIL6zbHAOatOXoqEVMOt2DgRkfRXf+agrpQQ2L5CC6rk99LVi8Sx63LBxzHiq25uTfwajVGhlMv8iqEji9lPYeg6UQFje8/0NC09st9PnLnmUpqcb5aFbWJL0r8HTPrx4ITCvTruTOgYmzBmHJWOerz5pQ78j/Or70Km1BHUznSzEby+bHy+qWkCqDePzTOBmDdg2ao2GzlqDC+Wy4NqJFTQ1NX2EXiM6IfIgVf/OHmU7+XoQy/TneMvBckv4FMFu2D6Nr7Tavs8G3xxqCqazc6/mbWDybNUGYi3csyRb8VYMikFwOBtmrxTYZvNAC6gzo8aNt+/QHKjNrwuiZTAkZ8x5Mw6K4I8rEcZvQR/h4NK8BzaTQbS4jyPn2FpuoZSem8wHhx4jh27U4z+wmaQj0HtHMltIdooHfXQ/7OYIGpMv6Rdux4U1SR14PU2IH+D2nWilvSGl7nvtU4ArKIMo+u/aAxGNMyOwA2bDAwyIbv/5Kdt9SSj0OHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(39860400002)(376002)(396003)(346002)(136003)(6666004)(7416002)(6512007)(41300700001)(26005)(5660300002)(2616005)(2906002)(186003)(6506007)(53546011)(83380400001)(36916002)(36756003)(66556008)(31686004)(31696002)(8676002)(66476007)(316002)(478600001)(86362001)(66946007)(8936002)(38100700002)(6486002)(4326008)(921005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHJoY3hNYkk2ZmswRysrRzVUT2NQa1NDRC8ycUVxdU9tc09vZ3ZCaldTck1w?=
 =?utf-8?B?TlBuWEJSUVNCLysrZ3BjSG1FWHdjNm5LQjVBRG5pNE5QVE56VnRFMTFWa3Ny?=
 =?utf-8?B?Y2NReXRla3ZnYWllUWRBdXQ1bU5QYU9SQ29jUDNEeWZvN3JyMER2N3p5N2wr?=
 =?utf-8?B?dmwyMmRwVUczOXF1MWxWM2NLWUYrbXRIM0NIQTlDV3RqYzRRMEJzWE40Mmdj?=
 =?utf-8?B?bDY0bCtjd3ZCTVFSaE9LVFp4M0dKNVJzU2hoMzVuc2dVYTUrdElaeWR2WHl2?=
 =?utf-8?B?aXFnSmRmZ0hwT0d3M1lCR0VNczNRVTRwUE1qenB3UWpESlMxREZqT3IxbUFH?=
 =?utf-8?B?TzFRVExCRmZPcGg3YW5PMEUwQjJKQStVd3JuTTZRU2crd0FZZGdLUG1TMkFo?=
 =?utf-8?B?eFBUSERMVlh5R2ZEemRlc2Z2UUxFdktQS0FrZGowQ0IvZFkzdWdOTXFiQW1I?=
 =?utf-8?B?aWx4cGExS29NbnBsdWo1WHUwc3JPa1BtUklkL3BWaDRQTXZtTC9HUkNSMCto?=
 =?utf-8?B?Ky9pUEtkRmI4ZFA0YnBnWnpwL3hxWUt3KzREczg5dHVhL3BqZklMaU9TcDI2?=
 =?utf-8?B?UXNENzlnM3Mrc2tpNERXMElUUHFNQklxY3VRUmxGdVRqMm9UdE1vV1g2MFJq?=
 =?utf-8?B?RWJhcHJ1OUwvL2luVkRscFNKNUo0SVhYTmxLdXl0MHJwRjl4cEM3Q09GUjNy?=
 =?utf-8?B?ZFBISkorbVBGNEgwUzhVWTRJZ0gvd0h0K0cwSmFBd28xb0xnWkVTMFlWYzU1?=
 =?utf-8?B?Tk9CK0laUjYwNzFDb21YUkVsNzA3TmR6bWM0YmRMQ3YyYmxOcXZuY3pqZXdh?=
 =?utf-8?B?alpnNE9jUjJuNlBXdDdyVTdiTlBBVnNqUE9mdEo4YVRxcFdvanR0SGpOV3p2?=
 =?utf-8?B?ZUZIbWRqYkRBRExRWThBOWxpR0tRM1RzdGI0MDE2K0J5d25Sc3RjYi9kWTFn?=
 =?utf-8?B?YzhOcnFOWCtKWk03TXBab04wOFlBRTJ1SGlUMFFxb0lxK3VGNlUyRzY5NDI3?=
 =?utf-8?B?N3BKZGN6SC9uUFgrKytISDE0Z2I0M1gzbTRYSWtZbmpQVkF5V0hEd3BuY0hM?=
 =?utf-8?B?VG9vZ2NYZ3MrbTJrSTl4cUIrVnpJU04zNGlCODBJQ0piQi9FeVAyUWN5UEhU?=
 =?utf-8?B?dlBnVE1rSC8rNGNpREFUYlBZc1RTemxHQm5nU1JsSlNRZHRtRVQ3VU9TVnlB?=
 =?utf-8?B?eC93d3N1YzNYYU9yVHA0VUR2Q0kxckM4SU9oLzBWS2JuQ3RwbCtxY0k5OFRL?=
 =?utf-8?B?M25YKzdYS25KeVJjdGlMZ3QvRWRwcG5OalBHcXBaQ2Z4TzBhZ0hEeGlzRUZ2?=
 =?utf-8?B?MHMwUWdzakVNaE44MWhqQXVHTjV1UE45bHNGcW5QTEc3K3NXVEFOZWlQUzZv?=
 =?utf-8?B?V3UzSFNkTmVGR25hSHQxWlUyL1Rva3A0U3E1dzdBSEhvVmx1bEJjSHpiUHlW?=
 =?utf-8?B?NzUzeG5uUUNQN1JXZlBpM29Mc1FwcGFkblNPL1NycnpKU0pSNVpIZm11ZjRT?=
 =?utf-8?B?RnVqUlorWmFiNFdxemFZZDloVWdab3BwaFlPRHRZME15VytJOUd3Nk1NZ3Jv?=
 =?utf-8?B?dzBLZU9BRVVrU1UyL3g5TWljOGhBOUdQeVc0WHlCNVQ2YVZ2RFBhOEVKVWFW?=
 =?utf-8?B?Z3Q4WnhkUWJ1TVB6QnBvSFRpVS90cDN0cXp2bThKVXoyMVNocUVLdHNVQy9l?=
 =?utf-8?B?amtmSEs0WU9KbXYyek55dE9FK3lZbDdhSGtBS2dHV2lnckhicHBrcE4xTEly?=
 =?utf-8?B?cnhjWmFodkVRSjVFRDJHMnJWVnVpdmdEMm84anZjQXZoYVptcEpjenMxUDRU?=
 =?utf-8?B?WUdMbG1HZmsrZ21ZMDAzNm51RW1RU3VJc3IrVVduQ1BqREZubTVCaEhpSWhO?=
 =?utf-8?B?SDY2UUVHWWI3U0hycWQxd2RMVEtrQi9ab2FBTkxMV3Q3NWNPQ2pHbXI2blZz?=
 =?utf-8?B?aGdZR0UwZDFJY0MzQUpPV0lGY0loaUYySkFBZFh0TjV5dkpzNFI1dTNRMHVt?=
 =?utf-8?B?VktIWnBRL3JwSjVtQWhVbWt5THdQNWd0bHkxSWFvZGZFbEZ0czZ6MjJhRmZS?=
 =?utf-8?B?amtMak9vM1JOb2t6cXhEVERnU0xoeC9qdVBsVWgvMWVPcGJWMXZyWkJaSWpG?=
 =?utf-8?Q?9XthNebK9yab39PMaiXenfiHg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7313fb8-af5e-418b-b065-08da7739f95b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 23:26:51.0941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEzFz4xgM1jJ2Tkk3+dYBBj2p7tGjAtvjxuIWvQq7M2oerk3iZRyH5sRpAbknXnTX+SzacYZcSNwyOZLK+6I1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1348
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-05_12,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208050103
X-Proofpoint-ORIG-GUID: 6-4d2MuVjmAKVJsOzBm1sLUNCEBk5aW7
X-Proofpoint-GUID: 6-4d2MuVjmAKVJsOzBm1sLUNCEBk5aW7
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiA4LzUvMjAyMiAzOjExIFBNLCBTaS1XZWkgTGl1IHdyb3RlOgo+Cj4KPiBPbiA4LzEvMjAy
MiA5OjQ1IFBNLCBHYXZpbiBMaSB3cm90ZToKPj4gQ3VycmVudGx5IGFkZF9yZWN2YnVmX2JpZygp
IGFsbG9jYXRlcyBNQVhfU0tCX0ZSQUdTIHNlZ21lbnRzIGZvciBiaWcKPj4gcGFja2V0cyBldmVu
IHdoZW4gR1VFU1RfKiBvZmZsb2FkcyBhcmUgbm90IHByZXNlbnQgb24gdGhlIGRldmljZS4KPj4g
SG93ZXZlciwgaWYgR1NPIGlzIG5vdCBzdXBwb3J0ZWQsCj4gR1VFU1QgR1NPICh2aXJ0aW8gdGVy
bSksIG9yIEdSTyBIVyAobmV0ZGV2IGNvcmUgdGVybSkgaXQgc2hvdWxkIGhhdmUgCj4gYmVlbiBi
ZSBjYWxsZWQuCj4KPj4gwqAgaXQgd291bGQgYmUgc3VmZmljaWVudCB0byBhbGxvY2F0ZQo+PiBz
ZWdtZW50cyB0byBjb3ZlciBqdXN0IHVwIHRoZSBNVFUgc2l6ZSBhbmQgbm8gZnVydGhlci4gQWxs
b2NhdGluZyB0aGUKPj4gbWF4aW11bSBhbW91bnQgb2Ygc2VnbWVudHMgcmVzdWx0cyBpbiBhIGxh
cmdlIHdhc3RlIG9mIGJ1ZmZlciBzcGFjZSBpbgo+PiB0aGUgcXVldWUsIHdoaWNoIGxpbWl0cyB0
aGUgbnVtYmVyIG9mIHBhY2tldHMgdGhhdCBjYW4gYmUgYnVmZmVyZWQgYW5kCj4+IGNhbiByZXN1
bHQgaW4gcmVkdWNlZCBwZXJmb3JtYW5jZS4KPj4KPj4gVGhlcmVmb3JlLCBpZiBHU08gaXMgbm90
IHN1cHBvcnRlZCwKPiBEaXR0by4KPgo+PiB1c2UgdGhlIE1UVSB0byBjYWxjdWxhdGUgdGhlCj4+
IG9wdGltYWwgYW1vdW50IG9mIHNlZ21lbnRzIHJlcXVpcmVkLgo+Pgo+PiBCZWxvdyBpcyB0aGUg
aXBlcmYgVENQIHRlc3QgcmVzdWx0cyBvdmVyIGEgTWVsbGFub3ggTklDLCB1c2luZyB2RFBBIGZv
cgo+PiAxIFZRLCBxdWV1ZSBzaXplIDEwMjQsIGJlZm9yZSBhbmQgYWZ0ZXIgdGhlIGNoYW5nZSwg
d2l0aCB0aGUgaXBlcmYKPj4gc2VydmVyIHJ1bm5pbmcgb3ZlciB0aGUgdmlydGlvLW5ldCBpbnRl
cmZhY2UuCj4+Cj4+IE1UVShCeXRlcykvQmFuZHdpZHRoIChHYml0L3MpCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIEJlZm9yZcKgwqAgQWZ0ZXIKPj4gwqDCoCAxNTAwwqDCoMKgwqDCoMKg
wqAgMjIuNcKgwqDCoMKgIDIyLjQKPj4gwqDCoCA5MDAwwqDCoMKgwqDCoMKgwqAgMTIuOMKgwqDC
oMKgIDI1LjkKPj4KPj4gU2lnbmVkLW9mZi1ieTogR2F2aW4gTGkgPGdhdmlubEBudmlkaWEuY29t
Pgo+PiBSZXZpZXdlZC1ieTogR2F2aSBUZWl0eiA8Z2F2aUBudmlkaWEuY29tPgo+PiBSZXZpZXdl
ZC1ieTogUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jIHwgMjAgKysrKysrKysrKysrKysrKy0tLS0KPj4gwqAgMSBmaWxl
IGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMK
Pj4gaW5kZXggZWM4ZTFiMzEwOGMzLi5kMzY5MThjMTgwOWQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYwo+PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4g
QEAgLTIyMiw2ICsyMjIsOSBAQCBzdHJ1Y3QgdmlydG5ldF9pbmZvIHsKPj4gwqDCoMKgwqDCoCAv
KiBJIGxpa2UuLi4gYmlnIHBhY2tldHMgYW5kIEkgY2Fubm90IGxpZSEgKi8KPj4gwqDCoMKgwqDC
oCBib29sIGJpZ19wYWNrZXRzOwo+PiDCoCArwqDCoMKgIC8qIEluZGljYXRlcyBHU08gc3VwcG9y
dCAqLwo+PiArwqDCoMKgIGJvb2wgZ3NvX2lzX3N1cHBvcnRlZDsKPj4gKwo+PiDCoMKgwqDCoMKg
IC8qIEhvc3Qgd2lsbCBtZXJnZSByeCBidWZmZXJzIGZvciBiaWcgcGFja2V0cyAoc2hha2UgaXQh
IHNoYWtlIAo+PiBpdCEpICovCj4+IMKgwqDCoMKgwqAgYm9vbCBtZXJnZWFibGVfcnhfYnVmczsK
Pj4gwqAgQEAgLTEzMTIsMTQgKzEzMTUsMjEgQEAgc3RhdGljIGludCBhZGRfcmVjdmJ1Zl9zbWFs
bChzdHJ1Y3QgCj4+IHZpcnRuZXRfaW5mbyAqdmksIHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSwK
Pj4gwqAgc3RhdGljIGludCBhZGRfcmVjdmJ1Zl9iaWcoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmks
IHN0cnVjdCAKPj4gcmVjZWl2ZV9xdWV1ZSAqcnEsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGdmcF90IGdmcCkKPj4gwqAgewo+PiArwqDCoMKgIHVuc2lnbmVkIGludCBzZ19u
dW0gPSBNQVhfU0tCX0ZSQUdTOwo+PiDCoMKgwqDCoMKgIHN0cnVjdCBwYWdlICpmaXJzdCwgKmxp
c3QgPSBOVUxMOwo+PiDCoMKgwqDCoMKgIGNoYXIgKnA7Cj4+IMKgwqDCoMKgwqAgaW50IGksIGVy
ciwgb2Zmc2V0Owo+PiDCoCAtwqDCoMKgIHNnX2luaXRfdGFibGUocnEtPnNnLCBNQVhfU0tCX0ZS
QUdTICsgMik7Cj4+ICvCoMKgwqAgaWYgKCF2aS0+Z3NvX2lzX3N1cHBvcnRlZCkgewo+PiArwqDC
oMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IG10dSA9IHZpLT5kZXYtPm10dTsKPj4gKwo+PiArwqDC
oMKgwqDCoMKgwqAgc2dfbnVtID0gKG10dSAlIFBBR0VfU0laRSkgPyBtdHUgLyBQQUdFX1NJWkUg
KyAxIDogbXR1IC8gCj4+IFBBR0VfU0laRTsKPiBESVZfUk9VTkRfVVAoKSBjYW4gYmUgdXNlZD8K
Pgo+IFNpbmNlIHRoaXMgYnJhbmNoIHNsaWdodGx5IGFkZHMgdXAgY29zdCB0byB0aGUgZGF0YXBh
dGgsIEkgd29uZGVyIGlmIAo+IHRoaXMgc2dfbnVtIGNhbiBiZSBzYXZlZCBhbmQgc2V0IG9ubHkg
b25jZSAoZ2VuZXJhbGx5IGluIHZpcnRuZXRfcHJvYmUgCj4gdGltZQouLi4gLCBidXQgY2FuIGFs
aWduIHdpdGggbmV3IG10dSBkdXJpbmcgLm5kb19jaGFuZ2VfbXR1KCksIHRvby4KPiApIGluIHN0
cnVjdCB2aXJ0bmV0X2luZm8/CgpUaGFua3MsCi1TaXdlaQoKPj4gK8KgwqDCoCB9Cj4+ICsKPj4g
K8KgwqDCoCBzZ19pbml0X3RhYmxlKHJxLT5zZywgc2dfbnVtICsgMik7Cj4+IMKgIMKgwqDCoMKg
wqAgLyogcGFnZSBpbiBycS0+c2dbTUFYX1NLQl9GUkFHUyArIDFdIGlzIGxpc3QgdGFpbCAqLwo+
IENvbW1lbnQgZG9lc24ndCBtYXRjaCBjb2RlLgo+PiAtwqDCoMKgIGZvciAoaSA9IE1BWF9TS0Jf
RlJBR1MgKyAxOyBpID4gMTsgLS1pKSB7Cj4+ICvCoMKgwqAgZm9yIChpID0gc2dfbnVtICsgMTsg
aSA+IDE7IC0taSkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZmlyc3QgPSBnZXRfYV9wYWdlKHJx
LCBnZnApOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFmaXJzdCkgewo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiAobGlzdCkKPj4gQEAgLTEzNTAsNyArMTM2MCw3IEBAIHN0YXRp
YyBpbnQgYWRkX3JlY3ZidWZfYmlnKHN0cnVjdCB2aXJ0bmV0X2luZm8gCj4+ICp2aSwgc3RydWN0
IHJlY2VpdmVfcXVldWUgKnJxLAo+PiDCoCDCoMKgwqDCoMKgIC8qIGNoYWluIGZpcnN0IGluIGxp
c3QgaGVhZCAqLwo+PiDCoMKgwqDCoMKgIGZpcnN0LT5wcml2YXRlID0gKHVuc2lnbmVkIGxvbmcp
bGlzdDsKPj4gLcKgwqDCoCBlcnIgPSB2aXJ0cXVldWVfYWRkX2luYnVmKHJxLT52cSwgcnEtPnNn
LCBNQVhfU0tCX0ZSQUdTICsgMiwKPj4gK8KgwqDCoCBlcnIgPSB2aXJ0cXVldWVfYWRkX2luYnVm
KHJxLT52cSwgcnEtPnNnLCBzZ19udW0gKyAyLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBmaXJzdCwgZ2ZwKTsKPj4gwqDCoMKgwqDCoCBpZiAoZXJyIDwgMCkKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgIGdpdmVfcGFnZXMocnEsIGZpcnN0KTsKPj4gQEAgLTM1NzEsOCAr
MzU4MSwxMCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2Ug
Cj4+ICp2ZGV2KQo+PiDCoMKgwqDCoMKgIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklS
VElPX05FVF9GX0dVRVNUX1RTTzQpIHx8Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB2aXJ0aW9faGFz
X2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX0dVRVNUX1RTTzYpIHx8Cj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCB2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX0dVRVNUX0VDTikg
fHwKPj4gLcKgwqDCoMKgwqDCoMKgIHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVU
X0ZfR1VFU1RfVUZPKSkKPj4gK8KgwqDCoMKgwqDCoMKgIHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2
LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVUZPKSkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgdmktPmJp
Z19wYWNrZXRzID0gdHJ1ZTsKPj4gK8KgwqDCoMKgwqDCoMKgIHZpLT5nc29faXNfc3VwcG9ydGVk
ID0gdHJ1ZTsKPiBQbGVhc2UgZG8gdGhlIHNhbWUgZm9yIHZpcnRuZXRfY2xlYXJfZ3Vlc3Rfb2Zm
bG9hZHMoKSwgYW5kIAo+IGNvcnJlc3BvbmRpbmdseSB2aXJ0bmV0X3Jlc3RvcmVfZ3Vlc3Rfb2Zm
bG9hZHMoKSBhcyB3ZWxsLiBOb3Qgc3VyZSB3aHkgCj4gdmlydG5ldF9jbGVhcl9ndWVzdF9vZmZs
b2FkcygpIG9yIHRoZSBjYWxsZXIgZG9lc24ndCB1bnNldCBiaWdfcGFja2V0IAo+IG9uIHN1Y2Nl
c3NmdWwgcmV0dXJuLCBzZWVtcyBsaWtlIGEgYnVnIHRvIG1lLgo+Cj4KPiBUaGFua3MsCj4gLVNp
d2VpCj4+ICvCoMKgwqAgfQo+PiDCoCDCoMKgwqDCoMKgIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUo
dmRldiwgVklSVElPX05FVF9GX01SR19SWEJVRikpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB2aS0+
bWVyZ2VhYmxlX3J4X2J1ZnMgPSB0cnVlOwo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
