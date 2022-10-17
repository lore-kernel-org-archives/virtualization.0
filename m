Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF021C4332F
	for <virtualization@archiver.kernel.org>; Mon, 17 Oct 2022 22:58:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5457940574;
	Mon, 17 Oct 2022 22:58:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5457940574
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=X6xggCi4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=RxBar0Sq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CrCNcbh8E6sZ; Mon, 17 Oct 2022 22:58:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8BE14404D8;
	Mon, 17 Oct 2022 22:58:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8BE14404D8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D49CC0033;
	Mon, 17 Oct 2022 22:58:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44F30C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 22:58:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EFCB482D17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 22:58:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EFCB482D17
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=X6xggCi4; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=RxBar0Sq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fFqPM4RYgrYI
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 22:58:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AC98382E1A
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AC98382E1A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 22:58:18 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HLmwDw027010;
 Mon, 17 Oct 2022 22:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Jn2UPmvtnFXf959zNr+21eFMaHfryYkopTlA/J+5bCA=;
 b=X6xggCi4RDwJykHetEDAeKcWFhF5u4JDZRSwUmLHJ0+Ct1gtrfI/CXhSww4itdZ0wTNl
 9Npr1nSGDt5ImA9r7Zpnd/gdTVQpHjKgHcvGx7KhnX1CCVnXL+uTwtVjGiezhS6dQ3Lk
 J1bTNNE3kIVkvfrj9TBOXkgscmJuICqW6hZ2v5Fr54YYRg1EHkxjHt4Z87yu452Hzb59
 3+s+CH2ItS+qKWar/dI6aDn93Kt2QnblWBZJzp84RPvzwtAJZOTK6O5pq9zCbXCLLqrq
 VanmXGnPwOTGoDQZ59ABNcV8yd5/2GSTEXaVyZ/3QvXw0KIpxXtSINAoytbIS0ANhzdz bA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99nt97v8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Oct 2022 22:58:17 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 29HKwGiC015918; Mon, 17 Oct 2022 22:58:16 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3k8hr9j9b8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Oct 2022 22:58:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6cv5lhJcoIFR71cdwNvmHqhA3yZ83irRGI7ApIiySDMW1I3J8IEwfGnWcMpH5GJUB39m++tpi+o3BX3Lf8oah8eypsh9MdIhkMW14JJ07B3jZtomu1tvGYlWccc/ElatjbBT2SWup9ZZzOJN0xXeJ9bb07VrPFOOd6mzaPSLCd2Q6SyIps1ZEHFkgtYu7qrhEfH/P9pzLJGv/9+JIfcJLCEEJPdCpbMC6w91XIKsSzkkoYWtOeyzd8gHa/eJwVymmGQhh9/S31kejXYnbXEkQPsJZbWeMcj0EJ5VLga4t9NnvEqFZpu0zvIDtHa+Is0QDUb/iS8554VUtVv6p2aFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jn2UPmvtnFXf959zNr+21eFMaHfryYkopTlA/J+5bCA=;
 b=SclhhUX0Rk+ipqPGQZ+TR8LNBjIoEF8Btg8To1kONQDCDP7VjqLdVE1E9pkj88evT/pAZs1s9ScDkaTpCXJZL3yfDID0O22lyJNI4OltqYSqcRr/3b2/B9U3/p3kWWFuYteRPQvt+zHbMg7eK3BSvk5XIOFT4yBtB/SxVEGFSeRpWdNXDYlEPZBPubPjcUC6wDVYES2o0RuFZjBd2gD7Qbg7WxzIHwIAbRn348LFFGjemIj+f5vEKWppFn1z64xCdOuXssBwh75zZP108ZHUDPrpbAw+jPsOSJQYIb4BrGP/DZdqoxQxiUwccW7xbw4/NFULmMP0v7YgZSOaJHHPyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jn2UPmvtnFXf959zNr+21eFMaHfryYkopTlA/J+5bCA=;
 b=RxBar0Sq6cjVUCN+JIB+NsnrCGm1WAA+sBoQ1FJOgec0OW83BCdKcHD7MSwFneL9VP8DTLs6fdVyXZtluVSsoTvy/F/jk1uL3PQpvM8YTLYpKSZ26FXdCXyD8PVVjYai0Bt6jzrSFjqHip2L12lowIA7LMJhDo2CQfmuZzTHHZg=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH2PR10MB4277.namprd10.prod.outlook.com (2603:10b6:610:7b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 17 Oct
 2022 22:58:14 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a%5]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 22:58:14 +0000
Message-ID: <4f76d968-3086-0280-48fc-fcf250f11c67@oracle.com>
Date: Mon, 17 Oct 2022 15:58:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 0/4] vDPA: dev config export via "vdpa dev show" command
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <1665793690-28120-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEvaKnqS-0p7iqyHP_Wbbj1YdmPFA7ABfKK_8FbXMsZEkg@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEvaKnqS-0p7iqyHP_Wbbj1YdmPFA7ABfKK_8FbXMsZEkg@mail.gmail.com>
X-ClientProxiedBy: BY5PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::31) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH2PR10MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: 22092aff-c65e-4fd9-c5fc-08dab0931244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d5Z/mLd7dCGnEeJPzOeH9raZdsijHAW9TKv8qv62Cdq59nYw8jlPlSS42ZigT4vVKSjSsmyWcUd5MzZJFeEj3Ov/GjQcKhEibofs233SKTD/eumlTG1Qxt7qt3TfsFaGVaBKg4Deo++kD3puaLE4N30q1Qktgp3upqeWQeU6JWDlpMgcPnC2cAv9Ai10vTHfFjQ8FKLL7PgcSosIUr8pF/aOzgK4KO2NNdnLp0PyBIRX26ZLNJyvvrdUDPlwLet4cOZXuUpzNtwi8++QA33bz4Qj01Zxn0c7YwbSde+wkY7+YTNXG6VjKbSZDO6OZOiZryCSTdxoomAzyS0uaBoRnjEsYLjtOWfQRYqv0KEjXuqYH8tbF5wQ35icD9atI62s7CFFB6H3RB0WDWgn+E9ZFdKhMEEhguQc4MP3DzE/+gTBEN1uJ0Hiwf9Mr631I6R5mGKC0j96Y+ZPodbKLe9KQkXIyQka+zSp63D+nY3if3UiY3mvpffAc3ZMrDzfkIhbx1k5p3wAKa63RAikXcYRXmKxmlHO4518jVUAlwgRFag6MJOKxjE4qGA93DPG8al4gT/AaWim+A+KywAftT970dufx5838Lbl0PRbKLOBKlG+EZfeDj9udtAKiSUyK0oTcJ3o4w+0/2bk8V1R8zg0b66Wd5MK99gQNsib6rc4sTaSrweinSn8iMTm2GZnoTK3Jg3s2OYwf15VC5wP0UY3wl7AyrBkovky3SYf0zfQI4tTUA1c2QzHC436VH0uF5yf3GrJp7SkQsW05Lk3QhB3s9qS8D4DUlM2g81IG4k1JbU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199015)(2906002)(31686004)(5660300002)(66556008)(4326008)(6916009)(54906003)(8676002)(316002)(36756003)(66946007)(478600001)(6666004)(6506007)(8936002)(41300700001)(6486002)(6512007)(53546011)(83380400001)(26005)(66476007)(38100700002)(36916002)(31696002)(186003)(2616005)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDBLSXVOZGJLY1g5aHdSb0dqQ2NiTDgrK0U1Z2FMSTNycTdEaTFNbTVPSjBC?=
 =?utf-8?B?N3JCRFRNcC9BdDJkUG1KM21UbS9xck00WFYyY1dpMXFDQUN1VFhLVHNhaVEx?=
 =?utf-8?B?K1UzUlkwTXFlbklKSC8zRHJBQ3J5Z29zM3pkTjVXVFVPZ2tpSE9KMzZobDQv?=
 =?utf-8?B?NTlRQXhqMlppcjJ5WVFaSHRwWEkxV1RQdjR0eFFNY0NUQ3Jxa2xjWi92aG9Y?=
 =?utf-8?B?VWh5RFhTamdOVHM0Q3NVNXNjTXNKemFqREZ4dFpuYllNNXB2ODZsM0xDYTBG?=
 =?utf-8?B?NHJBR0xzVndQOVBEUW9Xam96SHhnT2p2Uk0xaGQ1bHZqS3MrMk9PL3QvOGc5?=
 =?utf-8?B?bjJ4aHR1N1IySXRFNWxRbjNpT0U3MGhYZlNmN0FiTld4Z010OHRIQW1QaHpq?=
 =?utf-8?B?a2srT0syUmJSbGhmVUI0ZWlQcSs4K2FiTGdGZEV3MWRpWkN6a1o3M1FUTmNw?=
 =?utf-8?B?MGVocmhOMjh6WVJEckZNWTVSaDNMRGJ6MzBlZm9tT2pSU0xlNEVTOCtMS1dl?=
 =?utf-8?B?dFpuankrOFpiZzNoemR0UWV2WU9zcEpwZmZ6SUlYUEpsZmxNRzgvcTZ5dmlq?=
 =?utf-8?B?eGVvRk9rNk9Jc3F4RzMzNHBvTHZlbC9QUElrblY0cHN6bHdwNGllb3Z3VE1N?=
 =?utf-8?B?NjIwMm14aTBMWENyNFBJSHRKRjZXUTd3QmZFUEIycFJnMDBOM0VmZjBMZ1R6?=
 =?utf-8?B?L0RaZTJEcU9oK3NWMmNob0t2UUxRU1dXQVhpTEVSV2dreTlBQTNqV2xjaE1K?=
 =?utf-8?B?cHFMejdqUGxOZDRnZzVMTTIxdTBVVHpVaDFaZnMxemNtWW1mUTBGNmdqNzZp?=
 =?utf-8?B?dExOTzgvOWVMbWJjYVpkUU04T3ZzRFpCWnBCSVErR0E1YTNKaTNramhZS2Ix?=
 =?utf-8?B?UEZwY3J5NDFhSVFmNVdkcnFUSG93QjJYbzhnN3ZIUWZKOGZFaEVEbHBybTdY?=
 =?utf-8?B?SW14Y05hOWZhMDE2K2NTMVM2OENYL3FVcVdRTWs0UmRwSUVOd1NlOFZ5TUdB?=
 =?utf-8?B?a3ZUSDUxYWVES2paMVVCbkFyaGdURWlwQXFuOUdMTGJ1MkRDcHdkbU1mVk16?=
 =?utf-8?B?WWpLbENtdHNmMkRZQm13NVRqRWJHSnJ6MldodU1PUEhmblJVSE8ySXZISU1X?=
 =?utf-8?B?ckwzSlJwOWprU0Y4a0VncnZxZXVjdEtJck9nVHk0MTh6SE9lNE9UcVpqbUZJ?=
 =?utf-8?B?YnVnWENSWTNrSVN1cWxZRmJhdFcvNGw2SlBLVmExRmNSa3liRnlCTG9wQk1r?=
 =?utf-8?B?LzBrMnJWR2ozSnQxRmI4ZlRyNnN3ckExVjAvN203cHQzZDkzS2pjbXZKY0ly?=
 =?utf-8?B?dGxUNmk5KzVSTEpXTmpqTFVmbnlhemZrRWoveTZxdVZFMStOdkF1eTltRWdz?=
 =?utf-8?B?T2NZTHVoVkFnSGdyNUpmVkNPekkxc2Flb09vN2VZS0ZSclBGQTBoVTBOQWpC?=
 =?utf-8?B?MTdIcmZiSW5VNHZtditMYkNXMGl3T09CZ2ZFQzNpSVJMcEZMdlJzQXZmMFU2?=
 =?utf-8?B?QUtUQlIwMXFka0NzMjJoYUhOUnNpdDh1cHcvSVJGV2REek9rd1RjdlhXd1Ar?=
 =?utf-8?B?Y0hWWnNaWW9nOGFtRXhjbmQxRDh3aUVRUXFIYXI5aGpRMnJQSEFjeWVWUHM1?=
 =?utf-8?B?MU5QcVptbDdIZGtEVSt6K21GYUhqUmZIWUNnTGtSK05vRmZSK0QvcC9Wb3F4?=
 =?utf-8?B?WlcwdDBXK2FNSTU1ZElRZFU0aWcvVjBha3NuZzlUUWNUYk1JNW5vVFUzRHJF?=
 =?utf-8?B?bmhwZGxUUDBxOVNyMGV1eDAxcGZ3V2xLdTgrM01Pd2kzNlRFREJPdzloUmJa?=
 =?utf-8?B?KzNQQ0ZRV1pkTEVuTk5BZTJVSDQ5V2UxTjRhSlprY2c3akcyM1lXQWJiWVlm?=
 =?utf-8?B?UE5qWFR4NlR4U0svSzUrcGxRVDZhcjF5cE4xZVVoN3E2OVpwb0JIOE1lTENR?=
 =?utf-8?B?R1pNLzZ4VEdYbzlXYURXVk9ZcHo0Z1p2VlhmQWx5enVyQlJodWVOQ0tDTTNI?=
 =?utf-8?B?anJuZ3hTZWN2d3dzb1NxOWp3elBpMHFLZ0l5enZPYXo2V0l2NFh1QjNOMzRP?=
 =?utf-8?B?bCtaMzdHWW5LNE1ZbHJwZ3FhTmZ0SEN0dUVRRG1jRXgzNmlVMmphY3lMVzFs?=
 =?utf-8?Q?B+5gACkctDPekSqueQb/caxYw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22092aff-c65e-4fd9-c5fc-08dab0931244
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 22:58:14.1399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yR4P0MMe5JUuZeW9PuCCQLGRSB1hCpJGH1NMGcrgc2nbt2CWggk/c1eyab1JNKmVkEdyMoQvExiSlivm00ISJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170132
X-Proofpoint-ORIG-GUID: V0YBgQnB_5svXJLvAyFo07ZvfZt25--f
X-Proofpoint-GUID: V0YBgQnB_5svXJLvAyFo07ZvfZt25--f
Cc: Sean Mooney <smooney@redhat.com>, virtualization@lists.linux-foundation.org,
 Daniel Berrange <berrange@redhat.com>, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

CgpPbiAxMC8xNy8yMDIyIDEyOjA4IEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+IEFkZGluZyBTZWFu
IGFuZCBEYW5pZWwgZm9yIG1vcmUgdGhvdWdodHMuCj4KPiBPbiBTYXQsIE9jdCAxNSwgMjAyMiBh
dCA5OjMzIEFNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4gd3JvdGU6Cj4+IExp
dmUgbWlncmF0aW9uIG9mIHZkcGEgd291bGQgdHlwaWNhbGx5IHJlcXVpcmUgcmUtaW5zdGF0ZSB2
ZHBhCj4+IGRldmljZSB3aXRoIGFuIGlkZW50aWFsIHNldCBvZiBjb25maWdzIG9uIHRoZSBkZXN0
aW5hdGlvbiBub2RlLAo+PiBzYW1lIHdheSBhcyBob3cgc291cmNlIG5vZGUgY3JlYXRlZCB0aGUg
ZGV2aWNlIGluIHRoZSBmaXJzdCBwbGFjZS4KPj4KPj4gSW4gb3JkZXIgdG8gYWxsb3cgbGl2ZSBt
aWdyYXRpb24gb3JjaGVzdHJhdGlvbiBzb2Z0d2FyZSB0byBleHBvcnQgdGhlCj4+IGluaXRpYWwg
c2V0IG9mIHZkcGEgYXR0cmlidXRlcyB3aXRoIHdoaWNoIHRoZSBkZXZpY2Ugd2FzIGNyZWF0ZWQs
IGl0Cj4+IHdpbGwgYmUgdXNlZnVsIGlmIHRoZSB2ZHBhIHRvb2wgY2FuIHJlcG9ydCB0aGUgY29u
ZmlnIG9uIGRlbWFuZCB3aXRoCj4+IHNpbXBsZSBxdWVyeS4KPiBGb3IgbGl2ZSBtaWdyYXRpb24s
IEkgdGhpbmsgdGhlIG1hbmFnZW1lbnQgbGF5ZXIgc2hvdWxkIGhhdmUgdGhpcwo+IGtub3dsZWRn
ZSBhbmQgdGhleSBjYW4gY29tbXVuaWNhdGUgZGlyZWN0bHkgd2l0aG91dCBib3RoZXJpbmcgdGhl
IHZkcGEKPiB0b29sIG9uIHRoZSBzb3VyY2UuIElmIEkgd2FzIG5vdCB3cm9uZyB0aGlzIGlzIHRo
ZSB3YXkgbGlidmlydCBpcwo+IGRvaW5nIG5vdy4KSSB0aGluayB0aGlzIHNlcmllcyBkb2Vzbid0
IGNvbmZsaWN0IHdpdGggd2hhdCBsaWJ2aXJ0IGlzIGRvaW5nIG5vdy4gRm9yIApleGFtcGxlIGl0
IGNhbiBzdGlsbCByZW1lbWJlciB0aGUgc3VwcG9ydGVkIGZlYXR1cmVzIGZvciB0aGUgcGFyZW50
IAptZ210ZGV2LCBhbmQgbXR1IGFuZCBtYWMgcHJvcGVydGllcyBmb3IgdmRwYSBjcmVhdGlvbiwg
YW5kIHVzZSB0aGVtIHRvIApyZXBsaWNhdGUgdmRwYSBkZXZpY2Ugb27CoCBkZXN0aW5hdGlvbiBu
b2RlLiBUaGUgZXh0cmEgYmVuZWZpdCBpcyAtIHRoZSAKbWFuYWdlbWVudCBzb2Z0d2FyZSAoZm9y
IGxpdmUgbWlncmF0aW9uKSBkb2Vzbid0IG5lZWQgdG8gY2FyZSB0aG9zZSAKbWdtdGRldiBzcGVj
aWZpY3MgLSBzdWNoIGFzIHdoYXQgZmVhdHVyZXMgdGhlIHBhcmVudCBtZ210ZGV2IHN1cHBvcnRz
LCAKd2hldGhlciBzb21lIGZlYXR1cmVzIGFyZSBtYW5kYXRvcnksIGFuZCB3aGF0IGFyZSB0aGUg
ZGVmYXVsdCB2YWx1ZXMgZm9yIAp0aG9zZSwgd2hldGhlciB0aGVyZSdzIGVub3VnaCBzeXN0ZW0g
b3IgaGFyZHdhcmUgcmVzb3VyY2UgYXZhaWxhYmxlIHRvIApjcmVhdGUgdmRwYSB3aXRoIHJlcXVl
c3RlZCBmZWF0dXJlcyBldCBhbC4gVGhpcyBraW5kIG9mIHByb2Nlc3MgY2FuIGJlIApzaW1wbGlm
aWVkIGJ5IGp1c3QgZ2V0dGluZyBhIHZkcGEgY3JlYXRlZCB3aXRoIHRoZSBleGFjdCBzYW1lIGZl
YXR1cmVzIAphbmQgY29uZmlndXMgZXhwb3NlZCB2aWEgdGhlICd2ZHBhIGRldiBzaG93JyBjb21t
YW5kLiBFc3NlbnRpYWxseSB0aGlzIApleHBvcnQgZmFjaWxpdHkganVzdCBwcm92aWRlcyB0aGUg
bGF5ZXIgb2YgYWJzdHJhY3Rpb24gbmVlZGVkIGZvciB2aXJ0aW8gCnJlbGF0ZWQgZGV2aWNlIGNv
bmZpZ3VyYXRpb24gYW5kIGZvciB0aGUgdmVyeSBjb3JlIG5lZWQgb2YgdmRwYSBsaXZlIAptaWdy
YXRpb24uIEZvciBlLmcuIHdoYXQncmUgZXhwb3J0ZWQgY2FuIGV2ZW4gYmUgdXNlZnVsIHRvIGZh
Y2lsaXRhdGUgCmxpdmUgbWlncmF0aW9uIGZyb20gdmRwYSB0byBzb2Z0d2FyZSB2aXJ0aW8uIEJh
c2ljYWxseSwgaXQgZG9lc24ndCAKcHJldmVudCBsaWJ2aXJ0IGZyb20gaW1wbGVtZW50aW5nIGFu
b3RoZXIgbGF5ZXIgb24gdG9wIHRvIG1hbmFnZSB2ZHBhIApiZXR3ZWVuIG1nbXRkZXYgZGV2aWNl
cyBhbmQgdmRwYSBjcmVhdGlvbiwgYW5kIG9uIHRoZSBvdGhlciBoYW5kLCB3b3VsZCAKYmVuZWZp
dCBsaWdodC13ZWlnaHRlZCBtZ210IHNvZnR3YXJlIGltcGxlbWVudGF0aW9uIHdpdGggZGV2aWNl
IAptYW5hZ2VtZW50IGFuZCBsaXZlIG1pZ3JhdGlvbiBvcmNoZXN0cmF0aW9uIGRlY291cGxlZCBp
biB0aGUgdXBwZXIgbGV2ZWwuCgo+PiBUaGlzIHdpbGwgZWFzZSB0aGUgb3JjaGVzdHJhdGlvbiBz
b2Z0d2FyZSBpbXBsZW1lbnRhdGlvbgo+PiBzbyB0aGF0IGl0IGRvZXNuJ3QgaGF2ZSB0byBrZWVw
IHRyYWNrIG9mIHZkcGEgY29uZmlnIGNoYW5nZSwgb3IgaGF2ZQo+PiB0byBwZXJzaXN0IHZkcGEg
YXR0cmlidXRlcyBhY3Jvc3MgZmFpbHVyZSBhbmQgcmVjb3ZlcnksIGluIGZlYXIgb2YKPj4gYmVp
bmcga2lsbGVkIGR1ZSB0byBhY2NpZGVudGFsIHNvZnR3YXJlIGVycm9yLgo+Pgo+PiBJbiB0aGlz
IHNlcmllcywgdGhlIGluaXRpYWwgZGV2aWNlIGNvbmZpZyBmb3IgdmRwYSBjcmVhdGlvbiB3aWxs
IGJlCj4+IGV4cG9ydGVkIHZpYSB0aGUgInZkcGEgZGV2IHNob3ciIGNvbW1hbmQuCj4+IFRoaXMg
aXMgdW5saWtlIHRoZSAidmRwYQo+PiBkZXYgY29uZmlnIHNob3ciIGNvbW1hbmQgdGhhdCB1c3Vh
bGx5IGdvZXMgd2l0aCB0aGUgbGl2ZSB2YWx1ZSBpbgo+PiB0aGUgZGV2aWNlIGNvbmZpZyBzcGFj
ZSwgd2hpY2ggaXMgbm90IHJlbGlhYmxlIHN1YmplY3QgdG8gdGhlIGR5bmFtaWNzCj4+IG9mIGZl
YXR1cmUgbmVnb3RpYXRpb24gYW5kIHBvc3NpYmxlIGNoYW5nZSBpbiBkZXZpY2UgY29uZmlnIHNw
YWNlLgo+Pgo+PiBFeGFtcGxlczoKPj4KPj4gMSkgQ3JlYXRlIHZEUEEgYnkgZGVmYXVsdCB3aXRo
b3V0IGFueSBjb25maWcgYXR0cmlidXRlCj4+Cj4+ICQgdmRwYSBkZXYgYWRkIG1nbXRkZXYgcGNp
LzAwMDA6NDE6MDQuMiBuYW1lIHZkcGEwCj4+ICQgdmRwYSBkZXYgc2hvdyB2ZHBhMAo+PiB2ZHBh
MDogdHlwZSBuZXR3b3JrIG1nbXRkZXYgcGNpLzAwMDA6NDE6MDQuMiB2ZW5kb3JfaWQgNTU1NSBt
YXhfdnFzIDkgbWF4X3ZxX3NpemUgMjU2Cj4+ICQgdmRwYSBkZXYgLWpwIHNob3cgdmRwYTAKPj4g
ewo+PiAgICAgICJkZXYiOiB7Cj4+ICAgICAgICAgICJ2ZHBhMCI6IHsKPj4gICAgICAgICAgICAg
ICJ0eXBlIjogIm5ldHdvcmsiLAo+PiAgICAgICAgICAgICAgIm1nbXRkZXYiOiAicGNpLzAwMDA6
NDE6MDQuMiIsCj4+ICAgICAgICAgICAgICAidmVuZG9yX2lkIjogNTU1NSwKPj4gICAgICAgICAg
ICAgICJtYXhfdnFzIjogOSwKPj4gICAgICAgICAgICAgICJtYXhfdnFfc2l6ZSI6IDI1NiwKPj4g
ICAgICAgICAgfQo+PiAgICAgIH0KPj4gfQo+Pgo+PiAyKSBDcmVhdGUgdkRQQSB3aXRoIGNvbmZp
ZyBhdHRyaWJ1dGUocykgc3BlY2lmaWVkCj4+Cj4+ICQgdmRwYSBkZXYgYWRkIG1nbXRkZXYgcGNp
LzAwMDA6NDE6MDQuMiBuYW1lIHZkcGEwIFwKPj4gICAgICBtYWMgZTQ6MTE6YzY6ZDM6NDU6ZjAg
bWF4X3ZxX3BhaXJzIDQKPj4gJCB2ZHBhIGRldiBzaG93Cj4+IHZkcGEwOiB0eXBlIG5ldHdvcmsg
bWdtdGRldiBwY2kvMDAwMDo0MTowNC4yIHZlbmRvcl9pZCA1NTU1IG1heF92cXMgOSBtYXhfdnFf
c2l6ZSAyNTYKPj4gICAgbWFjIGU0OjExOmM2OmQzOjQ1OmYwIG1heF92cV9wYWlycyA0Cj4+ICQg
dmRwYSBkZXYgLWpwIHNob3cKPj4gewo+PiAgICAgICJkZXYiOiB7Cj4+ICAgICAgICAgICJ2ZHBh
MCI6IHsKPj4gICAgICAgICAgICAgICJ0eXBlIjogIm5ldHdvcmsiLAo+PiAgICAgICAgICAgICAg
Im1nbXRkZXYiOiAicGNpLzAwMDA6NDE6MDQuMiIsCj4gU28gIm1nbXRkZXYiIGxvb2tzIG5vdCBu
ZWNlc3NhcnkgZm9yIGxpdmUgbWlncmF0aW9uLgpSaWdodCwgc28gb25jZSB0aGUgcmVzdWx0aW5n
IGRldmljZV9mZWF0dXJlcyBpcyBleHBvc2VkIHRvIHRoZSAndmRwYSBkZXYgCnNob3cnIG91dHB1
dCwgdGhlIG1nbXQgc29mdHdhcmUgY291bGQgaW5mZXIgdGhlIHNldCBvZiBjb25maWcgb3B0aW9u
cyB0byAKcmVjcmVhdGUgdmRwYSB3aXRoLCBhbmQgZmlsdGVyIG91dCB0aG9zZSB1bndhbnRlZCBh
dHRyaWJ1dGVzIChvciBwaWNrIAp3aGF0IGl0IHJlYWxseSB3YW50cykuCgotU2l3ZWkKCj4KPiBU
aGFua3MKPgo+PiAgICAgICAgICAgICAgInZlbmRvcl9pZCI6IDU1NTUsCj4+ICAgICAgICAgICAg
ICAibWF4X3ZxcyI6IDksCj4+ICAgICAgICAgICAgICAibWF4X3ZxX3NpemUiOiAyNTYsCj4+ICAg
ICAgICAgICAgICAibWFjIjogImU0OjExOmM2OmQzOjQ1OmYwIiwKPj4gICAgICAgICAgICAgICJt
YXhfdnFfcGFpcnMiOiA0Cj4+ICAgICAgICAgIH0KPj4gICAgICB9Cj4+IH0KPj4KPj4gLS0tCj4+
Cj4+IFNpLVdlaSBMaXUgKDQpOgo+PiAgICB2ZHBhOiBzYXZlIHZkcGFfZGV2X3NldF9jb25maWcg
aW4gc3RydWN0IHZkcGFfZGV2aWNlCj4+ICAgIHZkcGE6IHBhc3MgaW5pdGlhbCBjb25maWcgdG8g
X3ZkcGFfcmVnaXN0ZXJfZGV2aWNlKCkKPj4gICAgdmRwYTogc2hvdyBkZXYgY29uZmlnIGFzLWlz
IGluICJ2ZHBhIGRldiBzaG93IiBvdXRwdXQKPj4gICAgdmRwYTogZml4IGltcHJvcGVyIGVycm9y
IG1lc3NhZ2Ugd2hlbiBhZGRpbmcgdmRwYSBkZXYKPj4KPj4gICBkcml2ZXJzL3ZkcGEvaWZjdmYv
aWZjdmZfbWFpbi5jICAgICAgfCAgMiArLQo+PiAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1
X3ZuZXQuYyAgICB8ICAyICstCj4+ICAgZHJpdmVycy92ZHBhL3ZkcGEuYyAgICAgICAgICAgICAg
ICAgIHwgNjMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tCj4+ICAgZHJpdmVy
cy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jIHwgIDIgKy0KPj4gICBkcml2ZXJzL3ZkcGEv
dmRwYV9zaW0vdmRwYV9zaW1fbmV0LmMgfCAgMiArLQo+PiAgIGRyaXZlcnMvdmRwYS92ZHBhX3Vz
ZXIvdmR1c2VfZGV2LmMgICB8ICAyICstCj4+ICAgZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBf
dmRwYS5jICAgIHwgIDMgKy0KPj4gICBpbmNsdWRlL2xpbnV4L3ZkcGEuaCAgICAgICAgICAgICAg
ICAgfCAyNiArKysrKysrKy0tLS0tLS0KPj4gICA4IGZpbGVzIGNoYW5nZWQsIDgwIGluc2VydGlv
bnMoKyksIDIyIGRlbGV0aW9ucygtKQo+Pgo+PiAtLQo+PiAxLjguMy4xCj4+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
