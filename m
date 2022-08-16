Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9886C25B0E
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 22:48:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2DBBD40590;
	Tue, 16 Aug 2022 22:48:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2DBBD40590
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=S3PjT50V;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=NZ0NCixY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6cuexBJbWkdo; Tue, 16 Aug 2022 22:48:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 26E444015D;
	Tue, 16 Aug 2022 22:48:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 26E444015D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED7D9C0032;
	Tue, 16 Aug 2022 22:48:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3CE1C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 22:48:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA3F381403
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 22:48:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA3F381403
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=S3PjT50V; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=NZ0NCixY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vqQ2hsRKMBmU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 22:48:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86DE5813F3
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 86DE5813F3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 22:48:45 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GL8fBF024768;
 Tue, 16 Aug 2022 22:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=aOMDFJDdQ29L6KKeim80D9ev/UbsBqlvk0vehgssKJ4=;
 b=S3PjT50Vm6ugkwPUIt0pQhB7bi4P8QtiSCgoKlWwW33T4HN5wkoEgCIiR+ZGeTraA2+T
 hMM5EqGauZzyjaHjGQITvwKvviGkmgTOvf4Sl5VRwfQ+YQVV0Bs/y93unaBdDdYfazkD
 bFgYpG+0RAvRuhbcszZvYkjQkgkt7WVmdwJ7G8SYG9FZFxIAt2gF9WmqvMHbK2co42wa
 nDPS+FgadiPM8mUsEodknErhM/W7svIG/uKbkBQlj/Nk78eCqKV1Is4AaWsxkIVqHaqz
 1Fqi9L6/+si6tvmqmeVXrbFOFxGTaw/cuLm1JC5Wm4jyvdeTWzRq5RnmjuraG8E0A5Nl JQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx2r2fhca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Aug 2022 22:48:41 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 27GK4Akh021324; Tue, 16 Aug 2022 22:48:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3hx2d8ybtc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Aug 2022 22:48:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiziB5AQhTtxekPZ+K2wipE5LDWef2uG2ls3Fcx2NZktqgH/QVJdO9SsXZ8sZbQB+rzcZ3unI+aXz2aVlc3OpiHnM5a2n0ZjB277RGxmGMpl8NWkBrEtLeu1/W7W/JQlFaH8rmyWLRK0yFwJTx7cNIM1Rnp+OQ9g7H3H/DS5HZjWYFycH4j+9p/p57ITk9X8bLQ023UNRGkOrykAfeQOeeNCM2NtY9xz+4jjgaGIJtxWB3BYvUn1M9OXgD+kytXXEKnVkUKVa/D+1PYUViIDmcul4z+M4gdJ+TntOjCczxppTZ3W7PXjNdmtkVXslPLfy0l3SO/qBSQn63t8EYu2cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOMDFJDdQ29L6KKeim80D9ev/UbsBqlvk0vehgssKJ4=;
 b=NDt+EpVNNHsrNMzkIPl518eo5A5zPgOYpAt7Qc/9Erj0rWsNQIob036Bw6XZ+rT3kZGIxPN4rL7EX0jTUBwKKEbOTrx7NC9pAvVJ8rxbOXH8jgUfENxiaYMGt/PbPyTvjQ6E3U5ICdgtZcLiRBF6thcB/ZIp09fQyW2x67K0Cj3FjwoA+CnU7mhiNcLHMa7yOBdQL+7kffKo37EqWtEjK7gMDzezmwTslt9icG2gGqfPSIa8FMPpnGK0ABILAPutgxDmJKNXfxl8/niuOK+bGWAosQO/NPMyvm83pzzeIaPaJJhWSFApZ8Ogr/Mu65tzp6QEIAMbEldE6Swq5I3bBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOMDFJDdQ29L6KKeim80D9ev/UbsBqlvk0vehgssKJ4=;
 b=NZ0NCixYRscv9kV/f3Dq0qJhMz04xVo4clyQW43EaukPAdQ0zzLNfeAecGi8ik4zECjbBF79SJsjjNWS4keHzfGTVUiC49bsvikE+0et9onvx8vrinSmpwVQdlcrWzfwZF5Xvxmc1dyTn4adrDJm8NV1pIoqbJC0kj0BkoZyvRI=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by CY4PR10MB1368.namprd10.prod.outlook.com (2603:10b6:903:22::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 16 Aug
 2022 22:48:37 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5525.010; Tue, 16 Aug 2022
 22:48:37 +0000
Message-ID: <2cbec85b-58f6-626f-df4a-cb1bb418fec1@oracle.com>
Date: Tue, 16 Aug 2022 15:48:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V5 4/6] vDPA: !FEATURES_OK should not block querying
 device config space
Content-Language: en-US
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, mst@redhat.com
References: <20220812104500.163625-1-lingshan.zhu@intel.com>
 <20220812104500.163625-5-lingshan.zhu@intel.com>
 <e99e6d81-d7d5-e1ff-08e0-c22581c1329a@oracle.com>
 <f2864c96-cddd-129e-7dd8-a3743fe7e0d0@intel.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <f2864c96-cddd-129e-7dd8-a3743fe7e0d0@intel.com>
X-ClientProxiedBy: DM6PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:5:bc::19) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb789edf-6e09-42cd-69b8-08da7fd9749f
X-MS-TrafficTypeDiagnostic: CY4PR10MB1368:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: weTfciWznIAC5PHxo/rCe3Jwxu3Gr3PsbyhvtYMgt2DQgdk2IAEi/ZcPiANS7ySNheHa0n+pjnE2dA2RBiqBbeEvR0Ry1VDzZk7KmRsNtlBEnjjdTX18ZRlrU4ao3+FrUnzjbcSioztl5PggoJBGzJ4LuwJM1Tde6u8h37czIh/4OuoM95w332yROaZsFqOeEvuSLaiI8tX8qzIt0n5TGBAZNhXBZ7fjtTrPbHc48E0tjuO9QtEgYr1Vfr+ftHGXXN4wMjH1udtVqenOx01N+vr/JUqqfpeBsKIchfyfTIbEw6vmJckeddCeQ+HhTy0q28c7pYQK/rln3Ir+EAn2A0Huc/k3ZzQJUdEdxyWgI1FI77d3DETVwBC9/zF4k5t3Qkc/+n91dumgGK85e+W0Fraq8ACH9iHAt/O44nVr6a8CfXq4Ga7NWAa5HGJE1C0EJhWt7KnFvyRapVgIAnao1/RJjRPzeOLOEh423CJeg8U8AL9nMq47p33IWu/dhFvd161fXvHUvNxkyHyz9tlc55ZMh1yJ5/c07tVJzVAd9AwGTYTME8ERt118A1XGfFY0/lCI1YXAKxPrwS6piAC8th9zT1J21bLIa2pVSyZMHAOgfLS6MOUUG7LZ7UmYRV3gj2+6nggWtm7yeruf3PS7RbKaFV8DIOXXO/ksFAqgF8rMA3d693Q/bIId7Ez4knLuQeH+N3mU2jLsSjPt2+hy+1jLgCKdvD3KldiJCkYX9/tQEk3Ky2BkEwT8I1MqkXsSINqL/hetJRAPMKRj0dysbDHtUd92WtTNDCbRLKsy5o7HSYENDyzZg19m+PW9j1BYle6/sM56Nhk/TDPNEABaqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(136003)(396003)(376002)(346002)(39860400002)(36756003)(38100700002)(4326008)(66946007)(66556008)(316002)(66476007)(8676002)(186003)(31696002)(86362001)(2616005)(5660300002)(53546011)(6506007)(2906002)(8936002)(30864003)(36916002)(41300700001)(6486002)(83380400001)(33964004)(478600001)(6666004)(6512007)(26005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUR1QUt5Qzg1aW9tMHpTcDdoMDlmeDhxT1kwLzI2NDUvSk1UL3ZXRmplL21T?=
 =?utf-8?B?a0NaMVFzcTY2U09lQmE0dUNzWVJHcFVhOXZpbk5lcHdDTzZGM3BNc0Y0aVZW?=
 =?utf-8?B?bVNlZUs5Z2orelduMmtjS2JOM1REeUJuVUlpWFJGNDZVYkQrUi9pNVAxdXJm?=
 =?utf-8?B?c0Z3YkZtSGc5MFVZQ0R2MUFzZk53VlgzVkd4dGpZVVNIUFliSnR4Y05ZZ0s1?=
 =?utf-8?B?QU85TkpadWRzRWt1ZDV1cmJZY0ZETFA5Ny9vRlhlVXNxeENpSVdqVjBhV2xj?=
 =?utf-8?B?YW5mN1hyM2YwM0ZWakNJbXVtbUlnNjVhaUhmaGk5NTdOdnE1aGdRYm9uOXBI?=
 =?utf-8?B?eEdqNVVLN2tiVll6TnFxVHNxSU96MmZVdVMyUFJ6cXVQMTFVcFg0bVd5eDhr?=
 =?utf-8?B?MHoxSzhVWXFna0Z3R2hKSy9lNGtYU2dPTWhUTmZHRXl0YklwY3Z0aDFiUHkw?=
 =?utf-8?B?VUpDbkdaRWpEZzNPTThpaHNmQ2ZNRkZ4RWNuQzI4VkFDeW5yRExhUzNvQ3dJ?=
 =?utf-8?B?cjRqbjdKalEvbnVOSUI3NnY0WmhNZE94TnZuc0gwZzc4T2I2bmtQQlY4UE5o?=
 =?utf-8?B?SXQxMjhsWVllQTQ2UkhDWDZHWnFLeWxLeG9tOHIwanRwbHF5NEh6MkNFS1hr?=
 =?utf-8?B?VzlhU1R5eDdlWFBaaEdYaklqVitPNkY5VHV4ZlppZ2lSZmt2TE8wNHJveGtN?=
 =?utf-8?B?VWtaZ3JLVVA3TFA2WUp1emR4QnVNbFlLQ0VlZEI3OG14dnY2a3d5clYzRXZJ?=
 =?utf-8?B?WHVVTGlHSW5wM3lJTi9VbUpqN3BUalFydy9pYmZBT1REK3l3QVRmOEg0WXk4?=
 =?utf-8?B?UDdabWpZd0UrMHlOMkx1OC8zMUtIWjAzU3dYSXRNZkFsRm82ZmtOdWJ0OFdF?=
 =?utf-8?B?NG1Jenl0QXFCV25tYlZ4VzlFVldIVnphR09XZllHNnU0dzdRL09ieEpWdmN4?=
 =?utf-8?B?N3pWM3dhUEdnL2dlTUZKWmU1WDBldmZPUkNldUFKemNEMEdiRTJOU2xObEsr?=
 =?utf-8?B?cXhFYVBOZFl1L3BFdnczMk5oeHV2QU5FcHhTMklNdkRHRmowUG80QXU4Uk12?=
 =?utf-8?B?OXAxancwZHppbVZBQXNKT3NJZmJiT1pZcXBxY1FEM1N2MjJIbWFUOEV2dEtx?=
 =?utf-8?B?ZjZzVkZRYk9MNjhDbzYwQ2dDV3NoVHEvMWNwQ3pHa2NOVXV4M01ETFRWWmFo?=
 =?utf-8?B?azV4SFlhakxjdmxzdDUrS2JlWkEyQlFEYXVrOW1RRlZxZkFoVWo3TzY2c1Uy?=
 =?utf-8?B?Q2ZQRE9LOGhSSVhOMjcvQjQ5LzJTT0JRNmpWZlRvb0UrbU9uc1hHZ3RSTzRw?=
 =?utf-8?B?akxHS01qWEg5aXc0Y1N3aFZGY0RkTE1mNzI5YXgvMjdTM2pRaU1Cd0FRdFF2?=
 =?utf-8?B?bGlEaGhleGpCSzVmYjBhV20rdy9xZ3VKN0hPWXo1RFlWZFNGWnBHSDZDUWdQ?=
 =?utf-8?B?dmtwTVppWUEzbno0QUZCZzZJMUNzbExJZ2xza0hVRnFJaCtqeG4yZW1VcStU?=
 =?utf-8?B?aEoxQ1VuRUVQUklmWWhZRHRJWjlvWktxTGVtc3lwVXJpMGtKRXRjY05BSWV4?=
 =?utf-8?B?QjcvU3hZdDZVbGZIclZHUjlqRllyRjB0NHlhWEx3NjhOYUNwZllCWElUMFUz?=
 =?utf-8?B?UzZxaStjQlBZaUtwZFFxWHc4UTU5MHhZSkhKY2p1VExia2RwM1RpbG9LZnVp?=
 =?utf-8?B?YWJUaU1oVnp1ZTg1SVFUM29oaGVGdk16OVNONGt5MGpJdFcxZFFDSFMyNTh0?=
 =?utf-8?B?MjZHVHlXSGRWNmJRbXI0WitKdkZxa1hhVEFZWE9zSDN5a2hxSkwvMzhMeGt6?=
 =?utf-8?B?VndyMHg2WU9xOHY3Sy94WUUrMGhCbzJac0NlcjZkWCtsT25Pa0NGN0J3NDhV?=
 =?utf-8?B?SUJWTkp3MzJmQURIUUJUcllTY1pTSWw1d21KQ1c5N3diOWRvQk9Ic0wwOFlY?=
 =?utf-8?B?aE54dVQwR0xNdmNqVnVIUmlRNWs2dlFVcHhJNjhtZWFaQmNQbUl5bkl2YndH?=
 =?utf-8?B?ZEJQdTdHcVZjNG9IZ0lSMytRRVJCamZHdU5BRkpyMzdLbG5ZTEEwaTRyMEdN?=
 =?utf-8?B?a1VFa1BOSUZ3Y2E1aWttc21EMXArYnJNOTJSTnBBZDd5MXlCRldtc1FubUNK?=
 =?utf-8?Q?JijMa4vry1PAEUyzNdFDn7wMG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dmZKWm5YM3lYK1lya3YvWHYvQTAza0w1S0JEWktaR2JRcVpYcXFTTk9aeDhQ?=
 =?utf-8?B?b1JzVDhILzgrOWtoYjhaZWxYVUo3YzBnc0h1Q1gxWnZmOWcxZmdicmtLODVI?=
 =?utf-8?B?ekRPYS9NOFNDVGF4MVJoNjU3YURHbGpvbW1ROVhzNFllWVJFNDJOalpleTV2?=
 =?utf-8?B?MG0rRUIzVU9ReFphbjJ4U1lNM3BxSGtYUFJNS1hTMEQvWXFvQnh1UjFvWWlD?=
 =?utf-8?B?dVpjU2R1ZUxWYXVpdWgrVTFBVUNyOURYd2NzNXltWlA0Yk5VZWpnaWt1M0pp?=
 =?utf-8?B?V21tdEo5cHhCYlhlK01ybzZvZ0hsUHBpQ2t3MTBuaWRuL3hGOUd6OFhmTXhh?=
 =?utf-8?B?MUFmNk4yU3V4QW5taHoyekEwcGkwZjFzb29EYTJkanh6UFNIVm52SFZkQk1p?=
 =?utf-8?B?L01QZm54SGpVQlNrK3ZXdnd3YWUwZkhyV1R3RE94cFVGTndEZEtWS0hLeHVr?=
 =?utf-8?B?R1RDR3dhazFhUWEvTEpISXlLR2NDUXd3VVlBdXpPWlBkdk5lZUY4d3RaODNS?=
 =?utf-8?B?ZVhIVEtsNStpczNaYjNaNVpnZzZUQ2FWSnk2T01FeTM1dzJxREoxTnI0Zmhq?=
 =?utf-8?B?QldjTktVMFdGMWZET0hXdVk2OUlkQ1JLQmRmQUk2R1Jia1MwQ1orYnlpdHN3?=
 =?utf-8?B?RWg3aXduSldxaFBQWkQxK1FGV25KRjNvaVIycVVxZllLV0oybHJaazBqU3lK?=
 =?utf-8?B?bitDMk1qLzFDdmZZOE5IQWs1NUlFSUNPdktEeFlvMUlJVVJtVktLY3dMazl4?=
 =?utf-8?B?cXMva1FEZ1E1dzA5VXU5UHo2a2w1eVpqQ1Y3cWZNY1FCSTMyeWZCWHV2TVJX?=
 =?utf-8?B?YWNWSVdIL0VDUUljSzVBUEo3dERINGRqek5IU3BaQzhPSjFsWCtuZTNsU0c3?=
 =?utf-8?B?QUFsdWM3YzZFZTIyMmJGQ3d5UWlQVHhmM0wvUFFDTlpyZnprTEFDZFRDQU1a?=
 =?utf-8?B?UTQ0UUdzSXhxVXhka3MyV3I1bFp4eTE5aDY4eW5JT0RmLzVPWW5KeGYxWXVR?=
 =?utf-8?B?OXVLNVRsYW1sTTV3eXN1SVhnZEV2d2ZTR3ZtUm5WOTcvTVNsd1o2NG5PS3NN?=
 =?utf-8?B?anpYK09GTURPa0xtZE5qcCtXSXFGcUloZWVta2hodGpKVGFlSjlzK0hrWG0r?=
 =?utf-8?B?VDludW44Y25kL2lEekpJTEZjb2cvY3VVamNVaTdQNTJZaitRRTAzZXA0YmdP?=
 =?utf-8?B?VkxuVzUzc0hMTHlUeDhyTUpUWitBK0Nod2kyT1p1QnhnSGhEYWNJQWxEdlhR?=
 =?utf-8?B?STZwNUZocWRHV1Fra0J6cklUVGNoT0Z3cmZha1VFWkc2Rm4yVkpPSkhwSEFt?=
 =?utf-8?B?UnpyWm9ISkxkNzhZTmJSYTZzQTM1cGN6eXdMbmNPYTU3RlR2VWpXbGFTUXNY?=
 =?utf-8?B?eWlrckE2d0JKK0cvVW9JcWF3azkwT1FWTTg5Y3RkWHdaUThXV0dWenpNV25y?=
 =?utf-8?B?ZHg3NEp3d2xiSzZpUFZEVENxQ3JBZnpRMHlneVdnZHhzNVlDblozd29OZzFE?=
 =?utf-8?B?ekhkYVdXeFcrYWI1cEUzZzhQU3ZaODM0T1RPRFRGNjloUXlxYzFyWVYzY3p4?=
 =?utf-8?Q?P+4WNqIH69g6Nx6w4v2i1DlLOwonwsmPJYasZXI6d0UeoT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb789edf-6e09-42cd-69b8-08da7fd9749f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 22:48:36.9612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWaIZQJOaGFLs471F7EExAggblffsB4hPK2tNnNrfQU+3X5bmah80UmgJvvSrIrWOaSQWkdBWFES/ItGlUkykA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1368
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160082
X-Proofpoint-GUID: Nz3KrBZ5YPAg_9TZv_HpeymVF8oE6rdU
X-Proofpoint-ORIG-GUID: Nz3KrBZ5YPAg_9TZv_HpeymVF8oE6rdU
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 gautam.dawar@amd.com
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
Content-Type: multipart/mixed; boundary="===============7583481477852579635=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============7583481477852579635==
Content-Type: multipart/alternative;
 boundary="------------0i8BQP9fsrY0bWRxxJuYEMA8"
Content-Language: en-US

--------------0i8BQP9fsrY0bWRxxJuYEMA8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/16/2022 1:29 AM, Zhu, Lingshan wrote:
>
>
> On 8/16/2022 3:41 PM, Si-Wei Liu wrote:
>> Hi Michael,
>>
>> I just noticed this patch got pulled to linux-next prematurely 
>> without getting consensus on code review, am not sure why. Hope it 
>> was just an oversight.
>>
>> Unfortunately this introduced functionality regression to at least 
>> two cases so far as I see:
>>
>> 1. (bogus) VDPA_ATTR_DEV_NEGOTIATED_FEATURES are inadvertently 
>> exposed and displayed in "vdpa dev config show" before feature 
>> negotiation is done. Noted the corresponding features name shown in 
>> vdpa tool is called "negotiated_features" rather than 
>> "driver_features". I see in no way the intended change of the patch 
>> should break this user level expectation regardless of any spec 
>> requirement. Do you agree on this point?
> I will post a patch for iptour2, doing:
> 1) if iprout2 does not get driver_features from the kernel, then don't 
> show negotiated features in the command output
This won't work as the vdpa userspace tool won't know *when* features 
are negotiated. There's no guarantee in the kernel to assume 0 will be 
returned from vendor driver during negotiation. On the other hand, with 
the supposed change, userspace can't tell if there's really none of 
features negotiated, or the feature negotiation is over. Before the 
change the userspace either gets all the attributes when feature 
negotiation is over, or it gets nothing when it's ongoing, so there was 
a distinction.This expectation of what "negotiated_features" represents 
is established from day one, I see no reason the intended kernel change 
to show other attributes should break userspace behavior and user's 
expectation.
> 2) process and decoding the device features.
>>
>> 2. There was also another implicit assumption that is broken by this 
>> patch. There could be a vdpa tool query of config via 
>> vdpa_dev_net_config_fill()->vdpa_get_config_unlocked() that races 
>> with the first vdpa_set_features() call from VMM e.g. QEMU. Since the 
>> S_FEATURES_OK blocking condition is removed, if the vdpa tool query 
>> occurs earlier than the first set_driver_features() call from VMM, 
>> the following code will treat the guest as legacy and then trigger an 
>> erroneous vdpa_set_features_unlocked(... , 0) call to the vdpa driver:
>>
>>  374         /*
>>  375          * Config accesses aren't supposed to trigger before 
>> features are set.
>>  376          * If it does happen we assume a legacy guest.
>>  377          */
>>  378         if (!vdev->features_valid)
>>  379                 vdpa_set_features_unlocked(vdev, 0);
>>  380         ops->get_config(vdev, offset, buf, len);
>>
>> Depending on vendor driver's implementation, L380 may either return 
>> invalid config data (or invalid endianness if on BE) or only config 
>> fields that are valid in legacy layout. What's more severe is that, 
>> vdpa tool query in theory shouldn't affect feature negotiation at all 
>> by making confusing calls to the device, but now it is possible with 
>> the patch. Fixing this would require more delicate work on the other 
>> paths involving the cf_lock reader/write semaphore.
>>
>> Not sure what you plan to do next, post the fixes for both issues and 
>> get the community review? Or simply revert the patch in question? Let 
>> us know.
> The spec says:
> The device MUST allow reading of any device-specific configuration 
> field before FEATURES_OK is set by
> the driver. This includes fields which are conditional on feature 
> bits, as long as those feature bits are offered
> by the device.
>
> so whether FEATURES_OK should not block reading the device config 
> space. vdpa_get_config_unlocked() will read the features, I don't know 
> why it has a comment:
>         /*
>          * Config accesses aren't supposed to trigger before features 
> are set.
>          * If it does happen we assume a legacy guest.
>          */
>
> This conflicts with the spec.
>
> vdpa_get_config_unlocked() checks vdev->features_valid, if not valid, 
> it will set the drivers_features 0, I think this intends to prevent 
> reading random driver_features. This function does not hold any locks, 
> and didn't change anything.
>
> So what is the race?
You'll see the race if you keep 'vdpa dev config show ...' running in a 
tight loop while launching a VM with the vDPA device under query.

-Siwei


>
> Thanks
>
>>
>> Thanks,
>> -Siwei
>>
>>
>> On 8/12/2022 3:44 AM, Zhu Lingshan wrote:
>>> Users may want to query the config space of a vDPA device,
>>> to choose a appropriate one for a certain guest. This means the
>>> users need to read the config space before FEATURES_OK, and
>>> the existence of config space contents does not depend on
>>> FEATURES_OK.
>>>
>>> The spec says:
>>> The device MUST allow reading of any device-specific configuration
>>> field before FEATURES_OK is set by the driver. This includes
>>> fields which are conditional on feature bits, as long as those
>>> feature bits are offered by the device.
>>>
>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>>> ---
>>>   drivers/vdpa/vdpa.c | 8 --------
>>>   1 file changed, 8 deletions(-)
>>>
>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>> index 6eb3d972d802..bf312d9c59ab 100644
>>> --- a/drivers/vdpa/vdpa.c
>>> +++ b/drivers/vdpa/vdpa.c
>>> @@ -855,17 +855,9 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, 
>>> struct sk_buff *msg, u32 portid,
>>>   {
>>>       u32 device_id;
>>>       void *hdr;
>>> -    u8 status;
>>>       int err;
>>>         down_read(&vdev->cf_lock);
>>> -    status = vdev->config->get_status(vdev);
>>> -    if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
>>> -        NL_SET_ERR_MSG_MOD(extack, "Features negotiation not 
>>> completed");
>>> -        err = -EAGAIN;
>>> -        goto out;
>>> -    }
>>> -
>>>       hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
>>>                 VDPA_CMD_DEV_CONFIG_GET);
>>>       if (!hdr) {
>>
>

--------------0i8BQP9fsrY0bWRxxJuYEMA8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 8/16/2022 1:29 AM, Zhu, Lingshan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:f2864c96-cddd-129e-7dd8-a3743fe7e0d0@intel.com">
      
      <font face="monospace"><br>
        <br>
      </font>
      <div class="moz-cite-prefix"><font face="monospace">On 8/16/2022
          3:41 PM, Si-Wei Liu wrote:<br>
        </font></div>
      <blockquote type="cite" cite="mid:e99e6d81-d7d5-e1ff-08e0-c22581c1329a@oracle.com"><font face="monospace">Hi Michael, <br>
        </font> <font face="monospace"><br>
          I just noticed this patch got pulled to linux-next prematurely
          without getting consensus on code review, am not sure why.
          Hope it was just an oversight. <br>
        </font> <font face="monospace"><br>
          Unfortunately this introduced functionality regression to at
          least two cases so far as I see: <br>
        </font> <font face="monospace"><br>
          1. (bogus) VDPA_ATTR_DEV_NEGOTIATED_FEATURES are inadvertently
          exposed and displayed in &quot;vdpa dev config show&quot; before feature
          negotiation is done. Noted the corresponding features name
          shown in vdpa tool is called &quot;negotiated_features&quot; rather than
          &quot;driver_features&quot;. I see in no way the intended change of the
          patch should break this user level expectation regardless of
          any spec requirement. Do you agree on this point? <br>
        </font></blockquote>
      <font face="monospace">I will post a patch for iptour2, doing:<br>
        1) if iprout2 does not get driver_features from the kernel, then
        don't show negotiated features in the command output<br>
      </font></blockquote>
    <font face="monospace">This won't work as the vdpa userspace tool
      won't know *when* features are negotiated. There's no guarantee in
      the kernel to assume 0 will be returned from vendor driver during
      negotiation. On the other hand, with the supposed change,
      userspace can't tell if there's really none of features
      negotiated, or the feature negotiation is over. </font><font face="monospace"><font face="monospace">Before the change the
        userspace either gets all the attributes when feature
        negotiation is over, or it gets nothing when it's ongoing, so
        there was a distinction.This expectation of what </font></font><font face="monospace"><font face="monospace"><font face="monospace">&quot;negotiated_features&quot;
        </font>represents is established from day one, I see no reason
        the intended kernel change to show other attributes should break
        userspace behavior and user's expectation.<br>
      </font></font>
    <blockquote type="cite" cite="mid:f2864c96-cddd-129e-7dd8-a3743fe7e0d0@intel.com"><font face="monospace"> 2) process and decoding the device features.<br>
      </font>
      <blockquote type="cite" cite="mid:e99e6d81-d7d5-e1ff-08e0-c22581c1329a@oracle.com"> <font face="monospace"><br>
          2. There was also another implicit assumption that is broken
          by this patch. There could be a vdpa tool query of config via
          vdpa_dev_net_config_fill()-&gt;vdpa_get_config_unlocked() that
          races with the first vdpa_set_features() call from VMM e.g.
          QEMU. Since the S_FEATURES_OK blocking condition is removed,
          if the vdpa tool query occurs earlier than the first
          set_driver_features() call from VMM, the following code will
          treat the guest as legacy and then trigger an erroneous
          vdpa_set_features_unlocked(... , 0) call to the vdpa driver: <br>
        </font> <font face="monospace"><br>
          &nbsp;374&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* <br>
          &nbsp;375&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Config accesses aren't supposed to trigger
          before features are set. <br>
          &nbsp;376&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If it does happen we assume a legacy guest. <br>
          &nbsp;377&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ <br>
          &nbsp;378&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vdev-&gt;features_valid) <br>
          &nbsp;379&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vdpa_set_features_unlocked(vdev, 0); <br>
          &nbsp;380&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops-&gt;get_config(vdev, offset, buf, len); <br>
        </font> <font face="monospace"><br>
          Depending on vendor driver's implementation, L380 may either
          return invalid config data (or invalid endianness if on BE) or
          only config fields that are valid in legacy layout. What's
          more severe is that, vdpa tool query in theory shouldn't
          affect feature negotiation at all by making confusing calls to
          the device, but now it is possible with the patch. Fixing this
          would require more delicate work on the other paths involving
          the cf_lock reader/write semaphore. <br>
        </font> <font face="monospace"><br>
          Not sure what you plan to do next, post the fixes for both
          issues and get the community review? Or simply revert the
          patch in question? Let us know.<br>
        </font></blockquote>
      <font face="monospace">The spec says:</font><br>
      <font face="monospace"><span class="fontstyle0">The device MUST
          allow reading of any device-specific configuration field
          before FEATURES_OK is set by<br>
          the driver. This includes fields which are conditional on
          feature bits, as long as those feature bits are offered<br>
          by the device.<br>
          <br>
          so whether FEATURES_OK should not block reading the device
          config space. </span></font><font face="monospace"><span class="fontstyle0"><font face="monospace">vdpa_get_config_unlocked()
            will read the features, I don't know why it has a comment:<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Config accesses aren't supposed to trigger before
            features are set.<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If it does happen we assume a legacy guest.<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
            <br>
            This conflicts with the spec.<br>
            <br>
          </font></span></font><font face="monospace"><span class="fontstyle0"><font face="monospace">vdpa_get_config_unlocked()
            checks vdev-&gt;features_valid, if not valid, it will set
            the drivers_features 0, I think this intends to prevent
            reading random driver_features. This function does not hold
            any locks, and didn't change anything.<br>
            <br>
            So what is the race?<br>
          </font></span></font></blockquote>
    <font face="monospace">You'll see the race if you keep 'vdpa dev
      config show ...' running in a tight loop while launching a VM with
      the vDPA device under query.<br>
      <br>
      -Siwei<br>
      <br>
      <br>
    </font>
    <blockquote type="cite" cite="mid:f2864c96-cddd-129e-7dd8-a3743fe7e0d0@intel.com"><font face="monospace"><span class="fontstyle0"><font face="monospace">
            <br>
            Thanks<br>
            <br>
          </font></span></font><font face="monospace"><span class="fontstyle0"></span> </font>
      <blockquote type="cite" cite="mid:e99e6d81-d7d5-e1ff-08e0-c22581c1329a@oracle.com"> <font face="monospace"><br>
          Thanks, <br>
          -Siwei <br>
        </font> <font face="monospace"><br>
        </font> <font face="monospace"><br>
          On 8/12/2022 3:44 AM, Zhu Lingshan wrote: <br>
        </font>
        <blockquote type="cite"><font face="monospace">Users may want to
            query the config space of a vDPA device, <br>
            to choose a appropriate one for a certain guest. This means
            the <br>
            users need to read the config space before FEATURES_OK, and
            <br>
            the existence of config space contents does not depend on <br>
            FEATURES_OK. <br>
          </font> <font face="monospace"><br>
            The spec says: <br>
            The device MUST allow reading of any device-specific
            configuration <br>
            field before FEATURES_OK is set by the driver. This includes
            <br>
            fields which are conditional on feature bits, as long as
            those <br>
            feature bits are offered by the device. <br>
          </font> <font face="monospace"><br>
            Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@intel.com" moz-do-not-send="true">&lt;lingshan.zhu@intel.com&gt;</a>
            <br>
            --- <br>
            &nbsp; drivers/vdpa/vdpa.c | 8 -------- <br>
            &nbsp; 1 file changed, 8 deletions(-) <br>
          </font> <font face="monospace"><br>
            diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c <br>
            index 6eb3d972d802..bf312d9c59ab 100644 <br>
            --- a/drivers/vdpa/vdpa.c <br>
            +++ b/drivers/vdpa/vdpa.c <br>
            @@ -855,17 +855,9 @@ vdpa_dev_config_fill(struct vdpa_device
            *vdev, struct sk_buff *msg, u32 portid, <br>
            &nbsp; { <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 device_id; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *hdr; <br>
            -&nbsp;&nbsp;&nbsp; u8 status; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err; <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; down_read(&amp;vdev-&gt;cf_lock); <br>
            -&nbsp;&nbsp;&nbsp; status = vdev-&gt;config-&gt;get_status(vdev); <br>
            -&nbsp;&nbsp;&nbsp; if (!(status &amp; VIRTIO_CONFIG_S_FEATURES_OK)) { <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NL_SET_ERR_MSG_MOD(extack, &quot;Features negotiation
            not completed&quot;); <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err = -EAGAIN; <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out; <br>
            -&nbsp;&nbsp;&nbsp; } <br>
            - <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdr = genlmsg_put(msg, portid, seq,
            &amp;vdpa_nl_family, flags, <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VDPA_CMD_DEV_CONFIG_GET); <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hdr) { <br>
          </font></blockquote>
        <font face="monospace"><br>
        </font></blockquote>
      <font face="monospace"><br>
      </font> </blockquote>
    <br>
  </body>
</html>

--------------0i8BQP9fsrY0bWRxxJuYEMA8--

--===============7583481477852579635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7583481477852579635==--
