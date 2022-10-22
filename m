Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B300ECDFA1
	for <virtualization@archiver.kernel.org>; Sat, 22 Oct 2022 00:01:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E8E5140201;
	Sat, 22 Oct 2022 00:01:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E8E5140201
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=i42TpLEG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=s6FfgR7/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rbBEGBQXmCY8; Sat, 22 Oct 2022 00:01:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AFA8A400B8;
	Sat, 22 Oct 2022 00:01:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AFA8A400B8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 781C4C0033;
	Sat, 22 Oct 2022 00:01:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 901F9C002D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Oct 2022 00:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6393F41871
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Oct 2022 00:01:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6393F41871
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=i42TpLEG; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=s6FfgR7/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yI6SkucmjEcO
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Oct 2022 00:01:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 63E0E41859
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 63E0E41859
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Oct 2022 00:01:45 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LLDmIL030309;
 Sat, 22 Oct 2022 00:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=cqXseZQudiSLEGvtIpX77iuiIEuFfEyNdda1p88r5L4=;
 b=i42TpLEGUWffCGvHz8hJMlVNz18sbp1dv/BkiaRV4HjaCiASinbe1IG8YmEXtcrp2KRW
 P13dxSxPMIFr6mKMEBXkAOrD3iXBN7Tb8PzLerqG5LFCmRe07Xw/DY63gd8X6dTkOI/1
 Ww8M+laM4z3e0+ysmlwFmfouxptmLM33V6vswRXopNptGJDYF25BlRxHR344FdDSEyJe
 NqQmGKDAM/mxYhIMakNfDdZfLwABeeFh90RpefLc1mjOEkuJ2cHn13nFujShccPDj+mE
 HLiIgV+IaLqbq6ejYQWgM1hqHi/RTQDK8fl2zmlpAgBDosdcSDextW30UV+whYYA8WzT 5w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3tehc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 22 Oct 2022 00:01:43 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 29LKZ3gJ017042; Sat, 22 Oct 2022 00:01:42 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3k8hub9tt2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 22 Oct 2022 00:01:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cwt29+UObOAi+t0x97gHunQHzprk4C/0fvWYkkrKPwq8hHtWJJwZmQnaI76dBK3gakQNx3SbtYgk3vQ6A7eB/vtNbjk82jBCKd+V6j6c6GxTP87UwKiXoM1XFnX9PrxoRsdEdRaW8862L7KrUxJQ2dZEZnUPNtVrNgrGb9ptg2B+7+OZvNrneN5hPKfA6hLQxwwcSW6XSsBFD79vlMjG2XEXriGZiK8H6hpyOqTNofcQEM/HYC6jy0tlCY3fWf2bW41tdEsI3Gg0D1Jk6MxjPMcL6T1SrJu2w75GEXm1MfTeZ4QhHCxE4NgZ6ko6LzUC9MvKJiFetY4vRHIkJ+cWyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqXseZQudiSLEGvtIpX77iuiIEuFfEyNdda1p88r5L4=;
 b=Ui8UsMO2srIcXp8Ts9PHJe8lyA/elE6C5I/4BjkgCbV6tHprV8tn/JxvdkUduHWRb1J4XJ+vuDhPqD+094gyXv+c8XQeLJYu3aXnsD1LVkUnBQF24ysKBTTAy2dk9ke3TORgSg2Akuiqxux8IlxDIOlq2my2uVk34HFn/T0bsYls0l5hz219BR7c7/CPNXpw0FWSZ1938f3YVoE9wlGlGCUovMVHvValKF+/nWXglrbLEFf4Rs9ZBeZz3X75YcouzE/Gv75plDsy9hUFVtFw1wZUPsRe+Vy2WeomflALk9Kv8jMvSgCf1XpXeC7J/bY5mMOSMlwSOqQ5U5l1TOfKQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqXseZQudiSLEGvtIpX77iuiIEuFfEyNdda1p88r5L4=;
 b=s6FfgR7/ZxhtThZVEnvNNqihN7Rjt3SdffE1DfAFDrl3JFOT1g/zlBN8U6TID5CqEDew/w8bBA3PG6un5wazXIyoeuz5gs6OlM/Fid5LVEYAWTbQD6XKWE6zHt8hb2R5L9MY3fVmqbGesm25O1tt2Bksj/bhrPy/HTcZ4k6+JQo=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DM6PR10MB4346.namprd10.prod.outlook.com (2603:10b6:5:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Sat, 22 Oct
 2022 00:01:40 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a%5]) with mapi id 15.20.5723.032; Sat, 22 Oct 2022
 00:01:40 +0000
Message-ID: <cbbf86d8-e0f0-d5df-7d98-0dcf4877ee37@oracle.com>
Date: Fri, 21 Oct 2022 17:01:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 3/4] vdpa: show dev config as-is in "vdpa dev show"
 output
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>
References: <1666137032-28192-1-git-send-email-si-wei.liu@oracle.com>
 <1666137032-28192-4-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuDn+Y8OEw6uK+FC0oOOd6+kj0EXS4Fm-+54GjrqY3_Gw@mail.gmail.com>
 <86529a16-6358-ad9e-7ae3-ea1580db015c@oracle.com>
 <PH0PR12MB5481094D34C15C5C442F219DDC2A9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <PH0PR12MB5481094D34C15C5C442F219DDC2A9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-ClientProxiedBy: SN6PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:805:de::18) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DM6PR10MB4346:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f8f5c0f-cdf8-4c27-f892-08dab3c0988a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R1V7a1sg5h+CjJFI2OglvJvmcPcL+jPLot6W9x3+nigeZY3QMwASs3Q7nr54YWGuUdgdeTMt1M6iNL1Y3u1TdLFzlZjj9XTtFoVkRAWM8mVZKQqDJgLWJWRMsNLVYEV4ku1bhm4zUp5GLKuXIVLe27NrFbG7igCiLx7mmBHY8tvxzKKwTe47wbxbIwwBBgzIjf4JQLt7IHFBiN5oU3adZr28bexrrRw+mHWnk09QDm/p/4j8ONuu+MUlGugC/R7PFWdAKarSFHJ6yOxFiylbYenh9Rx5oSP7TWHGNhkbKlwKvQcMbnEgTQPgZ6XmozE26b3oTcljqGtdVFncO0wiLSM8HS8/zDeWcTSEZNcYUyf9MabiHQjiwYhG2k04M2k0By18xB1wgxntjfz2+EUv5LK56ddYM0Cp8L6+LKDJJsr286LJPXNP7caES4uPeJdJWG1SI4zxMT8keRpW4QiEwCRtaFJU0s5wSkORMWxyiutQ6/PFhzflQenoz5iwH95BIe7GGuYHos8jzO8gLQvJeMS2IAwCpeV8NaMIY3BZEc6lOPONaIpWiF4SgZkcjoGwS9ecCjPieK59PBqyjRcS5BqZOBM9GxhZzE+60LkMmX/wwJjNmyGeth5coECk2tM2PaTS2Eq4ggSzvQUIFYB7JTQP23Cv9JS+rquhVuFFZ1r8nbT7Cz3CTFNamnL8frvHEpitMmDPVILl1LNUEzhEDSOjWXkDeIEASRKgnCgZhDSae3oxkh5T9Nris1y2VIlKu6h21tUwwCn6wj3Yzjsj4IAnq2xe8PTeVp3zuQJHdy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199015)(316002)(8676002)(66946007)(31686004)(4326008)(66556008)(66476007)(110136005)(6506007)(33964004)(6666004)(36916002)(478600001)(30864003)(83380400001)(41300700001)(6486002)(53546011)(186003)(38100700002)(6512007)(2616005)(54906003)(8936002)(31696002)(36756003)(86362001)(5660300002)(26005)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVlQeUh1Z0QzeUhjWE5HQW5hZmZXaEJkNUIwVThndmhpWU9sbUNXWW9GMmpq?=
 =?utf-8?B?MVlmM05YZ1QwckxuWkU4YlFZNzdKeXM0TE4vUE4vR0xTK2FPRFdpOEthZTFN?=
 =?utf-8?B?eml6dmNGdDZsYTFBOEE4Zm16T2thenFLbjhwZW42S2JqSnZDU3BSOWxwTGoz?=
 =?utf-8?B?WW11d1FOekV6UStVRFRhWXRabWFuRXY3ZTBqWnFPTFpHWCtGaktQQVh2SFlV?=
 =?utf-8?B?Z2FNRWFUdGk3ODVHa0JFRUoyamNUWUY4bDExamszQUVwS1o0U0M3L3VENTFB?=
 =?utf-8?B?QzYzZFhGdjllMnJFV1VtYmFDbWNiRFZHNUJXNmI2T3BTVlR3YjJsYmFWNWNl?=
 =?utf-8?B?cXYxKzRabjNDYWpFZlZRNVBjeEc1alR1alkwL25zKzFaQkVNc2pYY3dKN3dC?=
 =?utf-8?B?dG1zMWJlZEdGZkVJdWhraGZzMzRKQThRdFFxbDlsOHZueStyUkdvUHNyMjhl?=
 =?utf-8?B?c1NWbDNRVWVPSk56MVAxZk5KeEhjYU1Pem40RXJzUHBVanVueDZiTGtBYmtY?=
 =?utf-8?B?ODRpMGhZN2pkUzFEVzdrK2NmaDJaMDhVUkZvZnhBTlBrUFlWYjBNK0YzeGVJ?=
 =?utf-8?B?QzNUUzYvUFBtMHhSWVBEK0R2cXhBN3JLK3pJblpROFNuN3E5ZG5qUFlvMlhG?=
 =?utf-8?B?SW15TFhjTXBiUnRaU3RjaXJYVmU5NHV1eGxGZGhESUxZMWxHWWVRVTFPa0hU?=
 =?utf-8?B?WjZlUW9MQTRvdnYzNi9ld1RHdEllREY1bUJFQ1ZKS2wxRDRRdzgreVR5aG0v?=
 =?utf-8?B?bXhQekY0U0s1VlFlTEtIVWFuNmI0cy9QMklVNGJBUWZVVkYwQjIvN3RLOXQ1?=
 =?utf-8?B?NjA5U1RRcHF3UVZab3RibW9OeFBFZkk2TTNFem12MXU2ZWtqOGdwWVFWTmlE?=
 =?utf-8?B?dHpxZE5YbWF3cGFTOE5wK2VzYVRjV1NzVm9GMjM1eVZxbXQrZTNlbkxWUlpt?=
 =?utf-8?B?ams3bjR0Tnh3YkJ2SDlEUUZ4bmFaZ0ptdVZndktxTDdOSFN1YU9Qc3A5Vzdv?=
 =?utf-8?B?QVZLUzVzbE8wZ05CZWJzUGtZaUdGdGpRQytSWDJ4dWhLcWU4eFhYdlhvcWRL?=
 =?utf-8?B?c3Ivd1h5MGdsK1lNSFZXTFV4YXBDQmgvQjlOQ1VPL1RHT1BHTUtDTFZHS2o0?=
 =?utf-8?B?YlNlUHRUejg3STRJc1hvRFZNNFpnaHNUaUhqVFdKTld0VXVRaTJOKzBvVkZr?=
 =?utf-8?B?M2FKZEFvckdJbVFyMFlnWXJuOVdqQ1FVY3FkWmdEQldKNHBCTUs0czZvT2g3?=
 =?utf-8?B?bVk5ZklwV2w5bTNoY1VlMjhFUjQzeWZCWkRtMWZZd1lvU0piR3RUc0VHSVM3?=
 =?utf-8?B?VzRpUEZaNEhyckEranJoVGIxNHlLZWFiaXA4RTkrakdsUWVyakNoaldYRDFx?=
 =?utf-8?B?MTNTM3QzT3Mvb0g5QlNER3U3MEtCcE43MStTU014T01zZ3ByYVV4cSsvZS9i?=
 =?utf-8?B?d3RvSVRSQzUvdk5XS1lmZ0xMVytlcGxTSUsvTHY4WHV5c0hSUkpaeS9oMnp4?=
 =?utf-8?B?UlRxdzJ3TlhKbmRNMTlLV002aHB2UXQ1YmFPbmI2RnhTR2tldmZkRWpZbGNR?=
 =?utf-8?B?cmpBWVpabjI4K3JBeTRINDROR3BTY1QyMVFwK2tBNlc1c3h4SGpZeUlkakx0?=
 =?utf-8?B?OW02dWVHQWU3UGZhUHlRamZuSEpwenZPdzNKV0wzNnU0WGQ1TUVNTG1LczJS?=
 =?utf-8?B?dTBoNHZmOUlodm1HbTZaMSs0YXdtdVFrNC9EUGgvS29rcE1nSldjSVpvSDBJ?=
 =?utf-8?B?MFFTSCs0bGI5Q3M4NkFoRGwvWXQ2L3R5a2VkS0EzVFNWOWZPZ1JHZ010UUZy?=
 =?utf-8?B?UDZjRDVBdTFwZWU4NFFHYXVrOW42OXpmUGpDZkd6K2p0c3g2cUR4QTMxd296?=
 =?utf-8?B?b2c5a0pEelIySCt1V0lsTnhWV3V4blVPWUR1Tm9lc3FDMjExdlRVa21RNk8v?=
 =?utf-8?B?bEZrM2VoTUFCcWNoN1ZCcEo3TEZ4blVQSjFrVUlxN25HZUxiNTRtM0hwK3py?=
 =?utf-8?B?bFZidWZBbGE2bENKNkZ1MmYxS1lzWHlOOHNQNnh5YS84SUZNTEZMWUw5ejN4?=
 =?utf-8?B?azhjK3hBSGpkWWk2bGg5WGZUOVR1SEIyQ3Y4dkZoVExTY3RzVmpwZTlrQVdY?=
 =?utf-8?Q?0q+En6OJFFSJMGWwNJqj7ff2m?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8f5c0f-cdf8-4c27-f892-08dab3c0988a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 00:01:40.2402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDt5PNVpka7KkzurOO+4Y8Da4RMXmrNw7nRiU3kcLDcpxHABfVeFEYEfzIyIGD1c2ALucRUsNpPe53a2KZ3Hrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4346
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210210140
X-Proofpoint-ORIG-GUID: NFKpVM2gtAdqj0sA-INPbLMFN3Q-jTPl
X-Proofpoint-GUID: NFKpVM2gtAdqj0sA-INPbLMFN3Q-jTPl
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============8505522164121107632=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============8505522164121107632==
Content-Type: multipart/alternative;
 boundary="------------UioSX3kBjFt1HOdt9yuu582j"
Content-Language: en-US

--------------UioSX3kBjFt1HOdt9yuu582j
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/20/2022 2:13 PM, Parav Pandit wrote:
>> From: Si-Wei Liu<si-wei.liu@oracle.com>
>> Sent: Thursday, October 20, 2022 2:12 PM
>>
>>
>> On 10/19/2022 10:25 PM, Jason Wang wrote:
>>> On Wed, Oct 19, 2022 at 8:56 AM Si-Wei Liu<si-wei.liu@oracle.com>
>> wrote:
>>>> Live migration of vdpa would typically require re-instate vdpa device
>>>> with an idential set of configs on the destination node, same way as
>>>> how source node created the device in the first place. In order to
>>>> save orchestration software from memorizing and keeping track of vdpa
>>>> config, it will be helpful if the vdpa tool provides the aids for
>>>> exporting the initial configs from which vdpa device was created
>>>> as-is. The "vdpa dev show" command seems to be the right vehicle for
>>>> that. It is unlike the "vdpa dev config show" command output that
>>>> usually goes with the live value in the device config space, which is
>>>> not quite reliable subject to the dynamics of feature negotiation and
>>>> possible change in device config space.
>>>>
>>>> Examples:
>>>>
>>>> 1) Create vDPA by default without any config attribute
>>>>
>>>> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 $ vdpa dev show
>>>> vdpa0
>>>> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs
>> 9
>>>> max_vq_size 256 $ vdpa dev -jp show vdpa0 {
>>>>       "dev": {
>>>>           "vdpa0": {
>>>>               "type": "network",
>>>>               "mgmtdev": "pci/0000:41:04.2",
>>>>               "vendor_id": 5555,
>>>>               "max_vqs": 9,
>>>>               "max_vq_size": 256,
>>>>           }
>>>>       }
>>>> }
>>>>
>>>> 2) Create vDPA with config attribute(s) specified
>>>>
>>>> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
>>>>       mac e4:11:c6:d3:45:f0 max_vq_pairs 4 $ vdpa dev show
>>>> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs
>> 9 max_vq_size 256
>>>>     virtio_config: mac e4:11:c6:d3:45:f0 max_vq_pairs 4 $ vdpa dev -jp
>>>> show {
>>>>       "dev": {
>>>>           "vdpa0": {
>>>>               "type": "network",
>>>>               "mgmtdev": "pci/0000:41:04.2",
>>>>               "vendor_id": 5555,
>>>>               "max_vqs": 9,
>>>>               "max_vq_size": 256,
>>>>               "virtio_config": {
> Since most config is related to virtio.
> May be better to do
> s/virtio_config/static_config or
> s/virto_config/dev_config
>
> This clearly indicates that this was the device static configuration.
The name was suggested by Jason, and it seems he prefers naming with 
init/initial. How about change it to initial_config?

>
>>>>                   "mac": "e4:11:c6:d3:45:f0",
>>>>                   "max_vq_pairs": 4
>>>>               }
>>>>           }
>>>>       }
>>>> }
>>>>
>>>> Signed-off-by: Si-Wei Liu<si-wei.liu@oracle.com>
>>>> ---
>>>>    drivers/vdpa/vdpa.c | 39 +++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 39 insertions(+)
>>>>
>>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
>>>> 566c1c6..91eca6d 100644
>>>> --- a/drivers/vdpa/vdpa.c
>>>> +++ b/drivers/vdpa/vdpa.c
>>>> @@ -677,6 +677,41 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct
>> sk_buff *skb, struct genl_info *i
>>>>    }
>>>>
>>>>    static int
>>>> +vdpa_dev_cfgattrs_fill(struct vdpa_device *vdev, struct sk_buff
>>>> +*msg, u32 device_id) {
>>>> +       struct vdpa_dev_set_config *cfg = &vdev->vdev_cfg;
>>>> +       int err = -EMSGSIZE;
>>>> +
>>>> +       if (!cfg->mask)
>>>> +               return 0;
>>>> +
>>>> +       switch (device_id) {
>>>> +       case VIRTIO_ID_NET:
>>>> +               if ((cfg->mask &
>> BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) != 0 &&
>>>> +                   nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR,
>>>> +                           sizeof(cfg->net.mac), cfg->net.mac))
>>>> +                       return err;
>>>> +               if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) !=
>> 0 &&
>>>> +                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, cfg-
>>> net.mtu))
>>>> +                       return err;
>>>> +               if ((cfg->mask &
>> BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) != 0 &&
>>>> +                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
>>>> +                               cfg->net.max_vq_pairs))
>>>> +                       return err;
>>>> +               break;
>>> This makes me think if we can reuse the virtio_net_config structure
>>> other than duplicate it slowly with a dedicated nested structure
>>> inside vdpa_dev_set_config then we can reuse the
>>> vdpa_dev_net_config_fill().
>> Adding Parav.
>>
>> I think for now the struct vdpa_dev_set_config has just a few fields, so it's
>> not very obvious. But from what I understand, the vdpa_dev_set_config
>> struct is designed to be built around vdpa configurables, without getting it
>> limited by what's exposed by the virtio device config structure, such as
>> virtio_net_config.
> Sure. Vdpa_dev_set_config can expand for fields outside of virtio_net_config structure space, but it should be close to virtio spec definition like you described below or close to Linux kernel objects.
Yes. The fields in vdpa_dev_set_config should definitely be virtio 
related. Though I feel it may be too early to generalize with virtio 
config space structure like virtio_net_config. There are just 3 fields 
at the moment and network device only. It's hard to predicate how it may 
expand in future. Let the vdpa config struct out grow from virtio config 
struct for now. If it turns out too much duplication between the two, we 
can then consider consolidating at some future point. Any objection?

-Siwei

>
> At present it can handle another 62 more fields, which I think is good enough for midterm.
>
>> For instance, there could be possibility for vdpa user to
>> specify the size of MAC unicast or multicast address table, which is not
>> defined anywhere in the virtio_net_config. I think it's important to match
>> such configuration (which may not even be defined in spec) for src&dst vdpa
>> devices involving the live migration.
>>
>> -Siwei
>>> Thanks
>>>
>>>> +       default:
>>>> +               break;
>>>> +       }
>>>> +
>>>> +       if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) != 0 &&
>>>> +           nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES,
>>>> +                             cfg->device_features, VDPA_ATTR_PAD))
>>>> +               return err;
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static int
>>>>    vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
>> u32 seq,
>>>>                 int flags, struct netlink_ext_ack *extack)
>>>>    {
>>>> @@ -715,6 +750,10 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct
>> sk_buff *skb, struct genl_info *i
>>>>           if (nla_put_u16(msg, VDPA_ATTR_DEV_MIN_VQ_SIZE, min_vq_size))
>>>>                   goto msg_err;
>>>>
>>>> +       err = vdpa_dev_cfgattrs_fill(vdev, msg, device_id);
>>>> +       if (err)
>>>> +               goto msg_err;
>>>> +
>>>>           genlmsg_end(msg, hdr);
>>>>           return 0;
>>>>
>>>> --
>>>> 1.8.3.1
>>>>

--------------UioSX3kBjFt1HOdt9yuu582j
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 10/20/2022 2:13 PM, Parav Pandit
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:PH0PR12MB5481094D34C15C5C442F219DDC2A9@PH0PR12MB5481.namprd12.prod.outlook.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">From: Si-Wei Liu <a class="moz-txt-link-rfc2396E" href="mailto:si-wei.liu@oracle.com">&lt;si-wei.liu@oracle.com&gt;</a>
Sent: Thursday, October 20, 2022 2:12 PM


On 10/19/2022 10:25 PM, Jason Wang wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On Wed, Oct 19, 2022 at 8:56 AM Si-Wei Liu <a class="moz-txt-link-rfc2396E" href="mailto:si-wei.liu@oracle.com">&lt;si-wei.liu@oracle.com&gt;</a>
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">wrote:
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Live migration of vdpa would typically require re-instate vdpa device
with an idential set of configs on the destination node, same way as
how source node created the device in the first place. In order to
save orchestration software from memorizing and keeping track of vdpa
config, it will be helpful if the vdpa tool provides the aids for
exporting the initial configs from which vdpa device was created
as-is. The &quot;vdpa dev show&quot; command seems to be the right vehicle for
that. It is unlike the &quot;vdpa dev config show&quot; command output that
usually goes with the live value in the device config space, which is
not quite reliable subject to the dynamics of feature negotiation and
possible change in device config space.

Examples:

1) Create vDPA by default without any config attribute

$ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 $ vdpa dev show
vdpa0
vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs
</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">9
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">max_vq_size 256 $ vdpa dev -jp show vdpa0 {
     &quot;dev&quot;: {
         &quot;vdpa0&quot;: {
             &quot;type&quot;: &quot;network&quot;,
             &quot;mgmtdev&quot;: &quot;pci/0000:41:04.2&quot;,
             &quot;vendor_id&quot;: 5555,
             &quot;max_vqs&quot;: 9,
             &quot;max_vq_size&quot;: 256,
         }
     }
}

2) Create vDPA with config attribute(s) specified

$ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
     mac e4:11:c6:d3:45:f0 max_vq_pairs 4 $ vdpa dev show
vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs
</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">9 max_vq_size 256
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">   virtio_config: mac e4:11:c6:d3:45:f0 max_vq_pairs 4 $ vdpa dev -jp
show {
     &quot;dev&quot;: {
         &quot;vdpa0&quot;: {
             &quot;type&quot;: &quot;network&quot;,
             &quot;mgmtdev&quot;: &quot;pci/0000:41:04.2&quot;,
             &quot;vendor_id&quot;: 5555,
             &quot;max_vqs&quot;: 9,
             &quot;max_vq_size&quot;: 256,
             &quot;virtio_config&quot;: {
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">Since most config is related to virtio.
May be better to do
s/virtio_config/static_config or
s/virto_config/dev_config

This clearly indicates that this was the device static configuration.</pre>
    </blockquote>
    The name was suggested by Jason, and it seems he prefers naming with
    init/initial. How about change it to initial_config?<br>
    <br>
    <blockquote type="cite" cite="mid:PH0PR12MB5481094D34C15C5C442F219DDC2A9@PH0PR12MB5481.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">                 &quot;mac&quot;: &quot;e4:11:c6:d3:45:f0&quot;,
                 &quot;max_vq_pairs&quot;: 4
             }
         }
     }
}

Signed-off-by: Si-Wei Liu <a class="moz-txt-link-rfc2396E" href="mailto:si-wei.liu@oracle.com">&lt;si-wei.liu@oracle.com&gt;</a>
---
  drivers/vdpa/vdpa.c | 39 +++++++++++++++++++++++++++++++++++++++
  1 file changed, 39 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
566c1c6..91eca6d 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -677,6 +677,41 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct
</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">sk_buff *skb, struct genl_info *i
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">  }

  static int
+vdpa_dev_cfgattrs_fill(struct vdpa_device *vdev, struct sk_buff
+*msg, u32 device_id) {
+       struct vdpa_dev_set_config *cfg = &amp;vdev-&gt;vdev_cfg;
+       int err = -EMSGSIZE;
+
+       if (!cfg-&gt;mask)
+               return 0;
+
+       switch (device_id) {
+       case VIRTIO_ID_NET:
+               if ((cfg-&gt;mask &amp;
</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) != 0 &amp;&amp;
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">+                   nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR,
+                           sizeof(cfg-&gt;net.mac), cfg-&gt;net.mac))
+                       return err;
+               if ((cfg-&gt;mask &amp; BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) !=
</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">0 &amp;&amp;
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">+                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, cfg-
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">net.mtu))
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">+                       return err;
+               if ((cfg-&gt;mask &amp;
</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) != 0 &amp;&amp;
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">+                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
+                               cfg-&gt;net.max_vq_pairs))
+                       return err;
+               break;
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">This makes me think if we can reuse the virtio_net_config structure
other than duplicate it slowly with a dedicated nested structure
inside vdpa_dev_set_config then we can reuse the
vdpa_dev_net_config_fill().
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Adding Parav.

I think for now the struct vdpa_dev_set_config has just a few fields, so it's
not very obvious. But from what I understand, the vdpa_dev_set_config
struct is designed to be built around vdpa configurables, without getting it
limited by what's exposed by the virtio device config structure, such as
virtio_net_config. 
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">Sure. Vdpa_dev_set_config can expand for fields outside of virtio_net_config structure space, but it should be close to virtio spec definition like you described below or close to Linux kernel objects.</pre>
    </blockquote>
    Yes. The fields in vdpa_dev_set_config should definitely be virtio
    related. Though I feel it may be too early to generalize with virtio
    config space structure like virtio_net_config. There are just 3
    fields at the moment and network device only. It's hard to predicate
    how it may expand in future. Let the vdpa config struct out grow
    from virtio config struct for now. If it turns out too much
    duplication between the two, we can then consider consolidating at
    some future point. Any objection?<br>
    <br>
    -Siwei<br>
    <br>
    <blockquote type="cite" cite="mid:PH0PR12MB5481094D34C15C5C442F219DDC2A9@PH0PR12MB5481.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">

At present it can handle another 62 more fields, which I think is good enough for midterm.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">For instance, there could be possibility for vdpa user to
specify the size of MAC unicast or multicast address table, which is not
defined anywhere in the virtio_net_config. I think it's important to match
such configuration (which may not even be defined in spec) for src&amp;dst vdpa
devices involving the live migration.

-Siwei
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
Thanks

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">+       default:
+               break;
+       }
+
+       if ((cfg-&gt;mask &amp; BIT_ULL(VDPA_ATTR_DEV_FEATURES)) != 0 &amp;&amp;
+           nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES,
+                             cfg-&gt;device_features, VDPA_ATTR_PAD))
+               return err;
+
+       return 0;
+}
+
+static int
  vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">u32 seq,
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">               int flags, struct netlink_ext_ack *extack)
  {
@@ -715,6 +750,10 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct
</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">sk_buff *skb, struct genl_info *i
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">         if (nla_put_u16(msg, VDPA_ATTR_DEV_MIN_VQ_SIZE, min_vq_size))
                 goto msg_err;

+       err = vdpa_dev_cfgattrs_fill(vdev, msg, device_id);
+       if (err)
+               goto msg_err;
+
         genlmsg_end(msg, hdr);
         return 0;

--
1.8.3.1

</pre>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------UioSX3kBjFt1HOdt9yuu582j--

--===============8505522164121107632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8505522164121107632==--
