Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14673C6FD1D
	for <virtualization@archiver.kernel.org>; Tue,  4 Apr 2023 23:08:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 73E27400BA;
	Tue,  4 Apr 2023 23:08:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 73E27400BA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=pKnsWeMJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=JB3XXVaJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s7Br21Ymn7O3; Tue,  4 Apr 2023 23:08:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9793D4019E;
	Tue,  4 Apr 2023 23:08:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9793D4019E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C6F3C0037;
	Tue,  4 Apr 2023 23:08:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A375FC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 23:08:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 783C180BE9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 23:08:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 783C180BE9
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=pKnsWeMJ; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=JB3XXVaJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 79YVCS_eDOM9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 23:08:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9382E80BD0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9382E80BD0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 23:08:29 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 334Kon4q024512; Tue, 4 Apr 2023 23:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7bma3rNy23dPW1Nn4AZBXUvyNTA8tNr0QNKX6f48Gjs=;
 b=pKnsWeMJo57FyJKEiF+VMvigi9STj+n8vj8BGrtvtMalzCdv0iWQjI43PjJvNg+jNxta
 bPAjJ9zb9LKF0BVHpM1iMDiI9Q53YqiQ0Fi6Hnabf4deOAysRCWHFTTINUGa6xua8up0
 11LZcS+JWlMgesHZfq2IRaHarNWThMH04T3U8ZWLEjXIWY8qLAB5xhC4rcutcqrOdQGH
 WgvL6IwmfT7W6PMYqKBq+M2g7cXoEFUJtM5RRal2HuGl/chdCqEwbaHktLH4sG3ZG+lY
 /Y73pNMw5ebIWYqV4UREflbMYsCdF4Esmew37NsqQlh3GoXQgi0Xkc2zVWVwmzpW/G2l 4Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcgaq2vq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Apr 2023 23:08:28 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 334N5Qk7027847; Tue, 4 Apr 2023 23:08:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3pptuqj1tc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Apr 2023 23:08:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qs5JChiWOpBvdkP1YchfTCwGWfkv5B2vHgwgqfYElPsqWVlvWRFQ8sYbZWrhSkTedNG8OB90TJFZaPnkxHIRZuIN4oHdVZr2gyHCzeA5PzrjPjySn+PAGsFnSDor1IgJhtwVXKGAyPzADgniAt3+rCOTW605YxrPmNwMj/8tWe1YzUnu0mbbOyjHdU//LoprKT97+dx/dVDx/oDSxyuPiA9hEq7k0wI6VPpoUhenlE9RSPdaAsvn9e/3HdV4RsFYs/aQr/+Di/Xeo7pEYeHUZeICNHzcC27qybOUFIWK1xNTR+fxE3j55jaLn2RW2MdvT0l1MPy2toWUhagVaRxWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bma3rNy23dPW1Nn4AZBXUvyNTA8tNr0QNKX6f48Gjs=;
 b=AwDAnJlJC+PSt5d+UMeCcwutX1OBcYHk8hRjzCPjSqqarPxSjAoSe4yN9diG36ZyDIt2sJxJHC22lOk+tVzdVhA61bbklmqQgtoI3BdtcCawgYJ+cOJ/fJqRWfU+uI6p7K9ggC35rRigWuxDGbk3do6hIMVTacfc/gYmNpv/Q7ka1EnUvrYekzTNSSVFLnOFb8HdrNqc7zxI1+kLKJJWq7vsIaBL+cHADH0+JuY7aWgbOqxh0soV5emd9XJRSEw4kKWS7v1Ocvt3ikbrVuo+VXwYhSfbKJbkjnQMUar1yfJPT7TxebYDfziSM45m6bTr1PRwe14x8vzI/RLWnB+brA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bma3rNy23dPW1Nn4AZBXUvyNTA8tNr0QNKX6f48Gjs=;
 b=JB3XXVaJ5wBnhu2Kz+IgPfl1SMIuz2DNg3hJEN5JsyFhut+4prD/iHTpV8nEBnpuz2nOHO156mstYxzhGJTBlwLA9e+ehKA9x/MBGURYpR6rgxSOil4hFaBfRuP6iD5nOmvpU/w4aqnb60HJxGYZ88hN8nmFPkQoPnBl33dRWgg=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SA1PR10MB6664.namprd10.prod.outlook.com (2603:10b6:806:2b3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.35; Tue, 4 Apr 2023 23:08:04 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::a870:411d:9426:21b3]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::a870:411d:9426:21b3%10]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 23:08:04 +0000
Message-ID: <faeaa023-c1ee-cd81-3397-edecc0579e8a@oracle.com>
Date: Tue, 4 Apr 2023 18:08:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 11/11] vhost: allow userspace to create workers
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20230328021717.42268-1-michael.christie@oracle.com>
 <20230328021717.42268-12-michael.christie@oracle.com>
 <CACGkMEuvAGKHVtg_tdiGJRN4+5utdDVbvnkycN97eb2fE2Ddsg@mail.gmail.com>
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CACGkMEuvAGKHVtg_tdiGJRN4+5utdDVbvnkycN97eb2fE2Ddsg@mail.gmail.com>
X-ClientProxiedBy: DM6PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:5:333::32) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|SA1PR10MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e810993-aab9-418d-0596-08db35617194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Dl7YWtRxbjK86LMsVdGl8BBxK9ta8b6O5gQ5rGEjuvMIpJZwoAzELrc95GAC/nFnolHrVZpnah0pR9PqO0UB9rL8DyGupcHBCOtaZLnX7fjJVsSK+1b95cbdG79TvvWXXvXGl5vDBEn29g0eSN7hje12fO+CCS7j+DkmlXFa6eHXc9ftulQNKSE/Icr2nITNoSOGESxilyxCGwlcpVGWimwyeyO9cOxxk4yIYi3pvkgNi912t6GkeqQ4It0iBsm3rnlGwKWnZ7WVbyCVUMOKfMloQl/t4hZbfvrgMDPSEFyAHqECTX++gw/tC7HlxQrs+yj3oqK1m7gOhmvGF99ZiK+Qi2vIdIXQ2gu6g5LxEwaU/SpyI9f03uvmdbsT98OI6qqVMqJ384Q+kI0VZDxREyUdBG+tspZOSkX2aPIhSffQjyRF42xJJVgLtOtub6ndqBy3KmANnu+T4C+fr8EhAMpx5/dQT0HtiWNnSWdEMZ05KKIKUFGocwbn81rLR3ylMwf9EqEMOE/Q55VTfPbXb3XqOMFXInqNQjSIRUDE8oo7n0bPj+vIbHC83V5fwYY/Ixl56/o3jz5ZakfM3n0IKaEzPQve9T9L8imW32oDHh+9HbmelT0q06Kjh2mYucDtQlGaACSFyxSm5bcweAEiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(6486002)(6506007)(186003)(53546011)(26005)(2616005)(8676002)(66946007)(83380400001)(41300700001)(316002)(4326008)(6916009)(66556008)(38100700002)(66476007)(2906002)(36756003)(478600001)(86362001)(31696002)(6512007)(5660300002)(8936002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2FzVUhyOU1LUi9nN1ZxTFd2QXdab1pYZ0plSW4xZ0ZaMzl2VHlxZW5KWkx2?=
 =?utf-8?B?eU5FUDFLTnRZd0wxNkxHTE1FNXkrV3JqRmFQMEoyYStBeklOMjhTYlFNaXEw?=
 =?utf-8?B?UjhTWjJEbGNXOGxLUFFieFAxSWJYR0VrWGNJcmNXSlRIdmdxa3pZMEZMMHRY?=
 =?utf-8?B?Sy9aVkdtcy9XM0VwRTNuUFY3QklsTDk2dWxuS2hCZDRYa2tKbDVuc3YxUXVP?=
 =?utf-8?B?VHZzUFZMclVwdng2MFJsNFBGbWsxUlU4TFJuREQ0WUlxSVVieTBFejhIR2Zw?=
 =?utf-8?B?T2RSSC9rR0tIN3FXbDhIV2d2ZitVc2JxU09QcDZyYmR5eS9OeVVaeVJhMmt6?=
 =?utf-8?B?R3c1bU1Ja094VWc1R2U2d21NSnVONGtXcTY4aDZtVHlHT2k2ejhuZUsrOHA5?=
 =?utf-8?B?QU11UXVGWmpmVXowWmtEZUUweWNSWkNqYUF2VzhoTE04NzJLZEJzWjR1QUcy?=
 =?utf-8?B?QWZmRXdLQTR1VFBBLzJRUzkrTXlqNHI5eGc5TG1uZE1CekN4MGk5L3pCalNM?=
 =?utf-8?B?a1ZPbUNMdkcwNUk5NkYyV0s2NzRGUXI5UnQ5L1FPOWw0REZ2ZHphSGtEcTQr?=
 =?utf-8?B?QVhKRDBTZkdzbTF0bVlKYWRtaXEvMnZnT1JOT1dUZ2NtTkNmRUZSYTJMM0h6?=
 =?utf-8?B?U1N1R29ZMFlQOGppT3hZOWNia1h3RGFpSjByMG5qYzhLZjc2MG02Tis0UEZZ?=
 =?utf-8?B?RXNOWlR3azIxNDN1T1BvakQ3OVVtZG96NlplTzVPMlpkV3FIQkJEeVpIamZa?=
 =?utf-8?B?V1NGbUxBODFwalVFL3RPYVowQVcwZmltV3VTVUZkSk9IcUcyamRuMHEwcmRn?=
 =?utf-8?B?c3hKakpsL25TUnl5U0ErQ0lKQlpIU3pmY2prVnZOVDd5YjgvQ0laOXFaVCtz?=
 =?utf-8?B?UU1vbzN4NHZSc09wZThiRi9pMFI5SEhDK0hDcnRMSFpNUDBWM0pROW5oZ0xt?=
 =?utf-8?B?UzI3UFpnaG1nQUQzdWNsdW12eVZVbWllTk9tS2U4MzJvQkJuNEM5aFJZdUsw?=
 =?utf-8?B?Q1owa3FPdmU3Q1pkd0w1MTlsNXo5ZnVIa3BQdFVsd3dYMDlqZlRtQVRncnhS?=
 =?utf-8?B?aHBISmRQTmlPejA1QVZvOE5JdHZzVlJLdk5ydGxUaXBaR3M4UG81RlVBeFBS?=
 =?utf-8?B?QzRCZEZ0dDNyY1FCTUd0TTNtaEpQNEdiQWhRYitNaXZ6YzdrNlJoQlNQMnZ4?=
 =?utf-8?B?YWQwTXB0Y3BpTlNneG1rT3ZSelM1azVGNEZYVlpidm1XaDBLMGc0c01sSTF1?=
 =?utf-8?B?ekt1UER3VFE0ZzdDM2ZUTDdIK2hiSnY0Nk9talFhbWIwZXorRW41eFdPT0FZ?=
 =?utf-8?B?QXBpSXIxYktDUTUvSVJHcUgyVCtJQUxsQkZKdnRiaDNwSFIyZUdpYWZKMzBi?=
 =?utf-8?B?OGZ5QkxoT2hYbUU2V2IyVEhzaVRnT3pzRFQ4NUxBcmthVmpzdnZCenA1RWRh?=
 =?utf-8?B?WU5Icjlwa2E5dWc4VldzYTNnd2hDSk12TlAzbEZWM0lZWGtocFpVbGpOQTh2?=
 =?utf-8?B?aml2MUtYc2IwUlZQMDY4ay9rSHBLOW5DZ2FRd0lsQnFYQVorODlmdTBXa09O?=
 =?utf-8?B?cTJ3QWpXcXdmM1B1MmZxdlBxelFtd1pGVGxqaWNLMlVaaGZBeTc3S0tvck1X?=
 =?utf-8?B?SDdZTWlqeWZRVEV1OEUwaGpMLzdSUWtEV1BzSEVnQkdHVXByOGdBNzNCOE8z?=
 =?utf-8?B?empHRGRWZXRZbTZ2SWs5VVBoRzduT1Q4OEM5b1JnQ2VEQS9ZSGR2T2JwYjVF?=
 =?utf-8?B?TFgvdklIeHFweC9ocDl6dmtON3FtdHJkQ2l5SzhtSVVjN1Mxa3N3a3VlSUM5?=
 =?utf-8?B?QzZsUUcwZngwak1uNUJ3WjVOMll3RGlFaitsSGFsVVozQmg0WnNuUllta3R6?=
 =?utf-8?B?dlRwTjkwQ3k2bHo0SC9haTNuNGg1OXZwSGlCazg2ZHJ2czBQZlArbU4zWUJo?=
 =?utf-8?B?MXI1ZVpjN2NldW9ZcTVteDY5elFxb2pwb0tXc2N5eCt4NnpWR1ZFUWpDVFZV?=
 =?utf-8?B?WXlrbTlmRloyNEROZ29qWEdmR3dLaVJtUXQzOEdSUnYySkZMMUFSRk5rVHdx?=
 =?utf-8?B?N21Bajc1cHExZUNwQjJjRU5IaXlyN2JEWVBiQ2JNU1FOR1Vsd2piVkxGcHJV?=
 =?utf-8?B?a1VCbnpSSExFMDR0VnJKOFVsTTdVV3V5anRhWk41V0NvWFBkQlJKSG1LSy95?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wqNXPpDvI5bxjwWnEKsQpfYjgCQfrHEg7hxKrCDRF6bZKlgsWe/ec75rZCJXysMqjshWNFwbpZnH+1y77zyE/3wx1iXOKWfWs2thdOoeqQcv+vxG42v7D99vgsOO896/xglP6uPq50hKlbS23Z3j++EINWL7PXu9z9YkwUfek9zkRUyBAcVJesbO7ZVbQFENw1eG0se5WNyKtyk8NkwxzM0FGk37z12P1YUw5VklkzZ129j6FFHa6KsDH79+zfhcm+hDdC+nxdQ0OmGTUf37QnkXWWtQPvOm3ROKtVT7qXV2D/o8ccxzLd0UwrAtJTq7Qfc9MEeXbOCTwkKqzSEf41vw5evyIPTy0wxhHrxDRrbu1dfARoWzpSXR9GhxPsXEx4Z/gDY7CVywLuA21Vv11jj4C/KYZXDJ747WEMIez4xYhO/OWNdjDuUygrbNiUlRNKY79Ky8sGkVuFe4NSK38U54JkyoKXy/5KZQsIvOGyexQA3PfkAz5b50XMcy+el+0PrMJFcrThCLT3PErG3j1k1V+x4vKGHPaX+pOkBkIws24zbM8myw4QPu+A5No81QDBNZS6NhYaOJJikDLfbp4FHb2bBi9vZYZfeo6p/GX+qBxqYAP3Q0VxN01gtxoT6skbf2XTQ3Fwv552Da3b+AykhkZEM4/MaX27tYGL3BUEctv/T/73dOUQdZvqmQ8+sOax3QZFUX+3ZnsLBtNVgsd3Hj1KKn4VhIgKqRcTP5tpzaGOKhkTUNFeOi63idj1M/YEHLWlfbemBB92wwtxC6zP3oaCJa9OlTWaUcCCckjVQIEO5dAt4qVlKz+/52QiQ6
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e810993-aab9-418d-0596-08db35617194
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 23:08:04.0118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHnni1z31cmvKAZ5LghcQ4Z23m8Jl8WQQ8u4F7BEG3QwBaKPXblE7r8jCFLDbjKSaQx066mtu7Z5Pilv835PT5EORiJU85vZYdTInDD28IA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6664
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_12,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304040211
X-Proofpoint-GUID: Au4UqVl5Aq3oGIoFY7Ka-dQc63vKWVSR
X-Proofpoint-ORIG-GUID: Au4UqVl5Aq3oGIoFY7Ka-dQc63vKWVSR
Cc: virtualization@lists.linux-foundation.org, stefanha@redhat.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 4/4/23 3:00 AM, Jason Wang wrote:
>>
>> -static void vhost_worker_free(struct vhost_dev *dev)
>> +static void vhost_worker_put(struct vhost_dev *dev, struct vhost_worker *worker)
>>  {
>> -       struct vhost_worker *worker = dev->worker;
>> -
>>         if (!worker)
>>                 return;
>>
>> -       dev->worker = NULL;
>> +       if (!refcount_dec_and_test(&worker->refcount))
>> +               return;
>> +
>>         WARN_ON(!llist_empty(&worker->work_list));
>>         vhost_task_stop(worker->vtsk);
>>         kfree(worker);
>>  }
>>
>> +static void vhost_vq_detach_worker(struct vhost_virtqueue *vq)
>> +{
>> +       if (vq->worker)
> 
> What happens to the pending work that queues for the old worker?

I didn't think there would be works queued at this time. I see your comment
below about my assumption about the backend being set being wrong. Will
discuss down there.


>>
>> +/* Caller must have device and virtqueue mutex */
>> +static void __vhost_vq_attach_worker(struct vhost_virtqueue *vq,
>> +                                    struct vhost_worker *worker)
>> +{
>> +       refcount_inc(&worker->refcount);
>> +       vhost_vq_detach_worker(vq);())
>> +       vq->worker = worker;
> 
> What happens if there's a pending flush in a specific device (e.g in
> vhost_scsi_tmf_resp_work())?

We wouldn't hit that specific case where we are running the above code and
vhost_scsi_tmf_resp_work.

Either:

1. The backend is NULL and has never been set, and so we would never have
called vhost_scsi_tmf_resp_work, because it can only be called after the
backend is set.

2. If the backed has been set and vhost_scsi_tmf_resp_work has
run or is running, then we when we would not have called __vhost_vq_attach_worker
from vhost_vq_attach_worker because it would see vhost_vq_get_backend
returning a non-NULL value.

If vhost_scsi later sets the backend to NULL, then vhost_scsi_clear_endpoint
will have made sure the flush has completed when the clear function returns.
It does that with the device mutex so when we run __vhost_vq_attach_worker
It will only see a vq/worker with no flushes in progress.

For the general case of can we be doing a vhost_dev_flush/vhost_work_flush_on
and __vhost_vq_attach_worker, then I thought we are ok as well because I
thought we have to currently have the device mutex when we flush so those can't
race with ioctl calls to vhost_vq_attach_worker since we hold the dev mutex
during that ioctls. Or we call flush from the file_operations release function 
so the device is closed and can't race with ioctls.

> 
> Does this mean we need to hold vq mutex when doing the flush? (which
> seems not the case of vhost_scsi_tmf_resp_work()).
> 
>> +}
>> +
>> +/* Caller must have device and virtqueue mutex */
>> +static int vhost_vq_attach_worker(struct vhost_virtqueue *vq,
>> +                                 struct vhost_vring_worker *info)
>> +{
>> +       unsigned long index = info->worker_id;
>> +       struct vhost_dev *dev = vq->dev;
>> +       struct vhost_worker *worker;
>> +
>> +       if (!dev->use_worker)
>> +               return -EINVAL;
>> +
>> +       /*
>> +        * We don't support setting a worker on an active vq to make flushing
>> +        * and removal simple.
>> +        */
>> +       if (vhost_vq_get_backend(vq))
>> +               return -EBUSY;
> 
> This assumes the worker won't be started until the backend is set
> which is not true.

I can see how we get flushes before setting the backend, but I thought we are
ok because we have the device mutex held.

What are the other possible cases? Is one case we could get a
VHOST_SET_VRING_KICK before setting the backend and so vhost_poll_start starts
to allow vhost_poll_queue before the backend is set? Is there any thing else?

I'll fix this issue.


>> +
>> +/* Caller must have device mutex */
>> +static int vhost_free_worker(struct vhost_dev *dev,
>> +                            struct vhost_worker_state *info)
>> +{
>> +       unsigned long index = info->worker_id;
>> +       struct vhost_worker *worker;
>> +
>> +       if (!dev->use_worker)
>> +               return -EINVAL;
>> +
>> +       worker = xa_find(&dev->worker_xa, &index, UINT_MAX, XA_PRESENT);
> 
> So we use int for worker_id which conflicts with UINT_MAX here?

I switched from idr in the last versions to xa last second and added this mistake.
Will fix.


> 
> struct vhost_worker_state {
>         /*
>          * For VHOST_NEW_WORKER the kernel will return the new vhost_worker id.
>          * For VHOST_FREE_WORKER this must be set to the id of the vhost_worker
>          * to free.
>          */
>         int worker_id;
> };
> 
> A side effect of using xa_index directly is that userspace can guess
> the xa_index of the default worker and free it here, is this intended?
I don't need the functionality. It was only something that I didn't
think mattered much, because you can only free the worker if it's not in
use by any virtqueues, so I didn't add any special code to handle it.
The user would have had to do an ATTACH to the default worker and replace
it then it could free it, so it works like the other workers.

> Should we hide the default worker from xa?

I can change it if you are worried about future problems.


>> -       default:
>> +       case VHOST_ATTACH_VRING_WORKER:
>> +               if (copy_from_user(&w, argp, sizeof(w))) {
>> +                       r = -EFAULT;
>> +                       break;
>> +               }
>> +               r = vhost_vq_attach_worker(vq, &w);
>> +               if (!r && copy_to_user(argp, &w, sizeof(w)))
>> +                       r = -EFAULT;
>> +               break;
> 
> It's a little odd that we have new and attach but only a free.

Do you mean we would also want a detach? I've been debating that.
I'm not sure what the user wanted though.

Would it leave the virtqueue with no worker? Or, does it pick the first
worker it finds? If there is no worker because we did the former or
because userspace detached all of them, then do we just drop work that
gets queued?

It seemed like a user would never want to drop work, so I made it so
you can only tell it to use new workers (attach which I guess is more
like a swap worker) so we always have a worker and I don't have to
worry about dropping work.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
