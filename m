Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72ED2C433EF
	for <virtualization@archiver.kernel.org>; Tue, 24 May 2022 00:01:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 218896115E;
	Tue, 24 May 2022 00:01:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TFzLR8ZGij2f; Tue, 24 May 2022 00:01:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 571E160B19;
	Tue, 24 May 2022 00:01:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D28DC0032;
	Tue, 24 May 2022 00:01:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72B65C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 00:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 605BB419A1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 00:01:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="Uqoh46fm";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="wu1Ut7PO"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SM-FtnjXEXW2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 00:01:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 19389419A0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 00:01:45 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NMhwG0032381;
 Tue, 24 May 2022 00:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qyRq24xBkEq/hXeo8gMtg05VmrgCCG3jrh7vGomdtA0=;
 b=Uqoh46fmICLIcx3Ae44UbpbUX2eT6QidYYs6geM4cyCvbcziSzSiSZmhBOqOCd6kHrFf
 QfxBDLfc42qs6czkOVI2U25WnDlbMk0/Lcka/RkW0PR3Jd2g8xPMZRT5cPFMdWWQ3/IZ
 20Z/4aNL7apKBcKQcoh0HjOzyhuCWDOnRaCt7kWBZQnTNaPlMz8LIbqdo7tceC99Ek7Y
 zfXzFLgWu1UeehTU0jsoQZUyuT2On+6ACXb82CBlzIIXzVD0s0Eq9/l22paxv3FhwB8g
 Edf25rAWfzmPGyXzNoDDm4X8DwKYUmRy1XZIJUbBztjywqAL20cqpXn0GV7GpHdpKW0Q UA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6rmtvtfk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 May 2022 00:01:33 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24NNwJN5025568; Tue, 24 May 2022 00:01:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3g6ph254rx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 May 2022 00:01:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvF07w5Mbo4kPfPCnmDFBkrQ2UHUQsKM4yxEtr/AMxxpFGi5AaK2PhocuMb0G8SpCjmF6f2vmdPhAI7frPz2YSYBc4oyKcSmyTqjdUb8NvAl40+LJ/iKPtWEz0f3IN+mwzPqabHzlZTxFt8twOsPNSw3XouC3McAPPgey+v2/4ogna+7/5T5MGw5dngHtK3hEQjcYmqGdpmUs9oOq/jxuyuHgIwtsniKdsHvn3ygKMBdWf6bc5wq/s8s4oSmeqf+vwuXw8RlxV80EDTDmIyl1bgzB9+PyL0zS4JuW9Z4VOiw1HYtvkHt04cikGS65PheH1YpO3y32V8RYZ6mgI2PrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyRq24xBkEq/hXeo8gMtg05VmrgCCG3jrh7vGomdtA0=;
 b=EHNR6sxEfxNNpy2lhSmi48394Mg+K6WzKjuPSz6gG/AK/an3Su1BatREypQ3Du4HHFEr4K7iMWD7vAdIfaEei/ABQ71t2oDsRpkgsMhYynjFf3e0DSP8jck6++TyZ7E6BK50meEdoZ4DstXknnN7dv6CsjIUHAuedaAB0ePNClIkKgcG0bxDqUN+b65b+y2zOgJdjg050jZo7b8a/O21XjWRFo/qB6JuDdZz1qu44+/N247TQuWzTc+RfTRIdluU396lPgMURSKYD4GPidC1ZGvHs7PCU2N9Y9fWvuZjMk/UVjlyw5QFxac87hjHiFegraRPUeaKIeAk/US0y+K0wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyRq24xBkEq/hXeo8gMtg05VmrgCCG3jrh7vGomdtA0=;
 b=wu1Ut7POhkdGK5u+WD03SN4tuLQSfIVPm4R3ODs70OlzhXy1cOQnhwAPPV/Bf7KAH33NcAlOqlv8KHpgTNf8wgmR6GZEWlUikLEuAsgiYTYtXsJq9A3Uh6RyB+Rnc4UtmhAavxJlic9J4l8i4+EFkLnP2+Mb7BzJeC5xOJHzdoE=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB3173.namprd10.prod.outlook.com (2603:10b6:a03:153::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 00:01:30 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30%2]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 00:01:30 +0000
Message-ID: <9f68802c-2692-7321-f916-670ee0abfc40@oracle.com>
Date: Mon, 23 May 2022 17:01:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/4] vdpa: Add stop operation
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20220520172325.980884-1-eperezma@redhat.com>
 <20220520172325.980884-2-eperezma@redhat.com>
 <79089dc4-07c4-369b-826c-1c6e12edcaff@oracle.com>
 <CAJaqyWd3BqZfmJv+eBYOGRwNz3OhNKjvHPiFOafSjzAnRMA_tQ@mail.gmail.com>
 <4de97962-cf7e-c334-5874-ba739270c705@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <4de97962-cf7e-c334-5874-ba739270c705@oracle.com>
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 086429e7-4e43-4e75-a04e-08da3d188e5f
X-MS-TrafficTypeDiagnostic: BYAPR10MB3173:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3173C983C73C33F1E7BD3FA9B1D79@BYAPR10MB3173.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cdLY0uyQ/ZElSFiLKqq2pgtq7FdR80ZecnEANIvjOiOlHzN8nKr5eqhI3mgKPAUwQ8uMvXGFWW+Q1HbdrQAWFNrjdj+C/fOHL/YamRpB8qSV7NG51fzusmN1+6Q3YsXr7uxl9iCVGNxjH//M7AZoqicJSvkhWwt8aCMJ/Zhwv8fldiPoGqmz6wp51SwCFjP4atfuGNWKRq7U5NZRn4gpHncDYqNWteHAtka6RQZcx88NIFTQ77Fp8MgmhXTmDmhX9IORLApgPdlD4LuYodstyEg0XBDHLKnAMhCBiqBbrn6lhXRDH6Ka/BjoFJ9pe9kAqD6JWvd6hx9Sr7hDDDGTllq1cudTRPT+uTjVKEWDi4tY54Fj3EyHPUJ+vtZsC2F2q7lzVnqslSAcx1qqiopC042H5qtMQOuvLgJR8ZWSWto/RtehS9CZCBreIcHYdptx7IBCjlDFNO7hn/jXKelNhLKXrBjFmH8cujjOKf+cfPbFzpmldJTVt3c5C/OmMbQk+rnqCcqFXebcMKGZMpyCDNmCYeEuQZqeVOwC9EpS8xf5xwtTTOk2Qda/eyP4wbCBFj9ajClj9sTJ/i0frRoQkZbh17FpHV9q/ryeK1fZqeqdKgcnpy/CFdulWm6Wkye5a4zw3PD6c2ItdebegqjAj5A1qYwexk/3q1kYbG9wulsLaAgDq/MdTXumtX7dqvq6n5DymynCmzvGiZfo+WnCJqhZN3vf1EnZjg1LR9W7eNdrCEsL8BRCHZEQIWkahC7w
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(2616005)(6486002)(31686004)(2906002)(26005)(6512007)(36756003)(6916009)(316002)(54906003)(36916002)(31696002)(186003)(38100700002)(8936002)(4326008)(53546011)(5660300002)(6506007)(508600001)(86362001)(66574015)(83380400001)(7416002)(8676002)(66946007)(6666004)(66476007)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlRJQk5hUFdDRkdrSDVTQ3BZS2R2YWd2bHJqWVdwR3pjMkF1aDBDMUc4WDY2?=
 =?utf-8?B?RUNMcFVvZGtNWjArMzZSd2tsOERmczFOUlQzTmFzWmVKUFdBRkJBZUhnWFZi?=
 =?utf-8?B?c1pHbGNQV1BqMnJLUnB2eEF6N3lUckJML1dYaWtacTFuRDJGbW03WnNmaVQ4?=
 =?utf-8?B?S01KZmFGSDRhN0p2RjI1WE53anhqWWF3OWpBYWEzdHpjTjhmVUc3NWVSWXdn?=
 =?utf-8?B?SDBDZks0SHRjT3JwVjdnMTVlZGpPYUxkN3pVcDRtTmI1eURzME5UUkdHc0FZ?=
 =?utf-8?B?TFYwU2h6SlVNa2M3TnFOTUdnT2JzUlAyWUZuOXZMM3lCZVY3WnBSL2FqbmZ1?=
 =?utf-8?B?WkJyN2owa2JpTWRtRmo2Z2JsTEV3RGdZZm1kQno3b2djdjg4YjEvNEUxRWdp?=
 =?utf-8?B?V1hGRHg3TERVdG9QeGtmNzdNMDV4WmZibmxVV05XbW5xSlZWOGJzOU14bnpT?=
 =?utf-8?B?ZGh0UFMvUVRHMFN1bnllTlE5dUo5QzVDWjBqTkV3a2JZSWFjWlZRemIxWjBB?=
 =?utf-8?B?RnNvL2FDL1g5Q2R4TktNaHhxeC9SL3d6bExLTTVFY1Uxa1lNSGZXY0kyUGlG?=
 =?utf-8?B?YzFlcEMrUFBFejRkZEhyWkhwZHFFSk1mckIra25GWFA4dFhGYS9MSWJZYThj?=
 =?utf-8?B?VmcrU0VtZVcyendIU3BBYk1LL0ZoVkJoQkZKZE5xQWhneDNISitaMW5RZVRR?=
 =?utf-8?B?THNRSUtVWGM3cTFNTGFWM2V5UEFUVk4xekVJd3M3dzRSaGJGUzBYN3dXcDZI?=
 =?utf-8?B?dzJSMU11YjQ2R2VDSDkyWjEyMHAvSXd4UVBWMnBEYjFVeHI2azlWRyszZ2Fm?=
 =?utf-8?B?SHBJN2h3T0xBZ24vZFM0NUZ6UzlXYlh2YnJYWmZUZ29jUnZQNkhQUm55ZUNH?=
 =?utf-8?B?azZycmt0S2orNGVJZlRRVGxnWVFqRnk3Uy85Zjd1MWhqWXgveWhZb2dqbGE2?=
 =?utf-8?B?bGdQUmRCN1V0QjhuQVNNOFV5S2xZNkxsRTlmS0h6MG9UbmxlY1ZIRkJEak16?=
 =?utf-8?B?eWs0ckZmNWdkcnJGQko4V1R1L3lacWJ1QlM5b2hYVmtMNWJLT0RtSEVPQUF1?=
 =?utf-8?B?bEtnQXJNMVNkQTQ3SjZ3dEZRWkZWRWxNeGhweXNYZ3hobkxZdnY3c3FiU2Vx?=
 =?utf-8?B?MlArNndQZUZMME9XNW5mWmlXMlBuMUFwd0orK01Rc216TnNqV1NtVUVyaFVw?=
 =?utf-8?B?dDRNTTZiT1lsakpaZlpUbGEwZWRqM1VwTEVZWTdrZkxFdmpzVzFzTGVoMUFk?=
 =?utf-8?B?Nk9lWWUvU29RSUZIK25XUzZwNENnNW1GcEtJSHBlUHBKR1JCanRiNXFoZk9H?=
 =?utf-8?B?MlNwOFNKVmUyYTVXUEpjbG96QVdLazVPT01uRzBzb1VldGZTNkZZdWhjbDNQ?=
 =?utf-8?B?bzcvS24zTlRyVkY5SlBQVlRuRHJPT1owQzFMdDFGWHFKTnAwNm5KbWkxOGk1?=
 =?utf-8?B?dXR2ck5pem9wV3dnRVc2Qkw1dnkxMFJ0S0ZuUFJJNGhLOHZYOUFzMDJnaDll?=
 =?utf-8?B?ZWMyZCs2aDFjSHRrbzN6R2J1UVdLKzYybXBxTnFqUTE4dnFtc0xuMyt0TFdM?=
 =?utf-8?B?eDVid3Y5emd6ZFczVnhSL1lsdk9wT3l1dEMxT0hMZ29BYUtIOEl3T1hoeCtn?=
 =?utf-8?B?RXlNU3hCeld0dm1YUzgvalFRMXhZK1V0OWVteVZRbG5aMWJZcXVNZForUmtC?=
 =?utf-8?B?Yy9BWi91aENZVTBsTm1iR01MQjl2V2I3c0l5ZGZHcVlYN2FtMjIxMU4yeGZ4?=
 =?utf-8?B?QllmdnR2TDkwVXJhMEtVdGJPM2FVVU8xTWQ1ekZIV3BISSszZ25teVo1aGV2?=
 =?utf-8?B?SGxJMDh1VFhMOStZRTNiMUYvRndPdFVQZ1p3dDBVUW1nQU5VSmFVUXBKaUdL?=
 =?utf-8?B?c1U4bTRrSlRoOUFmcXhwMmo4Ly9aREcwV2h3MzRuNno3QmVNUjJuMUswd2ZU?=
 =?utf-8?B?UGtLQ2thSG5aMFRBWm5zU3lFbGY3UGJsaTdPazVLSklwZ2o3SzZZellYVHRj?=
 =?utf-8?B?T1hmL3JTempDN0Q1b2FiSTlTRGxJZUJidzN3S08xSEdFWTBwK2RUaVBPcEVF?=
 =?utf-8?B?OFdiWUt0eW43aHlPWS9mRzVqVHhkRXVMUUNJNk1EcU9vMHRUSU05YzdYeVBK?=
 =?utf-8?B?WjZrREtRb2NybUNzR0E0a0FvVjVERk42S2ZNK2pUdkkzdmo0bGduY3dtR01E?=
 =?utf-8?B?bUdYYktJMFhsOVZMdlNPRU9lSSt2UFk4bk56eiswWWtTQS83ZWRQby9CWndz?=
 =?utf-8?B?S1Q1WjFvK1ErKzRzRnZrZFhkS013ZC9NNEIzRGlhNDNlT2xJaGh4WFVQYTFk?=
 =?utf-8?B?NVBHZGQ1RDh2OWdMUUVJd2lHK2t5ajVhTTdkODhvOHZ4WVpRbnFTOW1NVUx0?=
 =?utf-8?Q?ZXw1AMwnr18m2Cy0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086429e7-4e43-4e75-a04e-08da3d188e5f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 00:01:30.5362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4X97nxx/xaZyz+y2vEfwjvO4GgtogHTMvjn9yUPyv8VbhBJ4yOSrr5WkHewdJtTWBONo+xuNO5ZtoBTX3SETQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3173
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.874
 definitions=2022-05-23_10:2022-05-23,
 2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205230123
X-Proofpoint-GUID: ToxyOj29RwLtRaUMfUF91ZIQBQzXURB5
X-Proofpoint-ORIG-GUID: ToxyOj29RwLtRaUMfUF91ZIQBQzXURB5
Cc: tanuj.kamde@amd.com, kvm list <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, pabloc@xilinx.com,
 Eli Cohen <elic@nvidia.com>, Zhang Min <zhang.min9@zte.com.cn>,
 Cindy Lu <lulu@redhat.com>, Martin Petrus Hubertus Habets <martinh@xilinx.com>,
 Xie Yongji <xieyongji@bytedance.com>, dinang@xilinx.com,
 habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, Laurent Vivier <lvivier@redhat.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ecree.xilinx@gmail.com,
 Harpreet Singh Anand <hanand@xilinx.com>, martinpo@xilinx.com, "Dawar,
 Gautam" <gautam.dawar@amd.com>, Zhu Lingshan <lingshan.zhu@intel.com>
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

CgpPbiA1LzIzLzIwMjIgNDo1NCBQTSwgU2ktV2VpIExpdSB3cm90ZToKPgo+Cj4gT24gNS8yMy8y
MDIyIDEyOjIwIFBNLCBFdWdlbmlvIFBlcmV6IE1hcnRpbiB3cm90ZToKPj4gT24gU2F0LCBNYXkg
MjEsIDIwMjIgYXQgMTI6MTMgUE0gU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPiAK
Pj4gd3JvdGU6Cj4+Pgo+Pj4KPj4+IE9uIDUvMjAvMjAyMiAxMDoyMyBBTSwgRXVnZW5pbyBQw6ly
ZXogd3JvdGU6Cj4+Pj4gVGhpcyBvcGVyYXRpb24gaXMgb3B0aW9uYWw6IEl0IGl0J3Mgbm90IGlt
cGxlbWVudGVkLCBiYWNrZW5kIAo+Pj4+IGZlYXR1cmUgYml0Cj4+Pj4gd2lsbCBub3QgYmUgZXhw
b3NlZC4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUBy
ZWRoYXQuY29tPgo+Pj4+IC0tLQo+Pj4+IMKgwqAgaW5jbHVkZS9saW51eC92ZHBhLmggfCA2ICsr
KysrKwo+Pj4+IMKgwqAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQo+Pj4+Cj4+Pj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVkZS9saW51eC92ZHBhLmgK
Pj4+PiBpbmRleCAxNWFmODAyZDQxYzQuLmRkZmViYzRlMWUwMSAxMDA2NDQKPj4+PiAtLS0gYS9p
bmNsdWRlL2xpbnV4L3ZkcGEuaAo+Pj4+ICsrKyBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4+Pj4g
QEAgLTIxNSw2ICsyMTUsMTEgQEAgc3RydWN0IHZkcGFfbWFwX2ZpbGUgewo+Pj4+IMKgwqDCoCAq
IEByZXNldDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJlc2V0IGRldmljZQo+
Pj4+IMKgwqDCoCAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgQHZkZXY6IHZkcGEgZGV2aWNlCj4+Pj4gwqDCoMKgICrCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBSZXR1cm5zIGludGVnZXI6IHN1Y2Nlc3Mg
KDApIG9yIAo+Pj4+IGVycm9yICg8IDApCj4+Pj4gKyAqIEBzdG9wOsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFN0b3Agb3IgcmVzdW1lIHRoZSBkZXZpY2UgKG9wdGlvbmFs
LCAKPj4+PiBidXQgaXQgbXVzdAo+Pj4+ICsgKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmUgaW1wbGVtZW50ZWQgaWYgcmVxdWlyZSBkZXZpY2Ug
c3RvcCkKPj4+PiArICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIEB2ZGV2OiB2ZHBhIGRldmljZQo+Pj4+ICsgKsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQHN0b3A6IHN0b3AgKHRydWUpLCBub3Qg
c3RvcCAoZmFsc2UpCj4+Pj4gKyAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBSZXR1cm5zIGludGVnZXI6IHN1Y2Nlc3MgKDApIG9yIGVycm9yIAo+
Pj4+ICg8IDApCj4+PiBJcyB0aGlzIHVBUEkgbWVhbnQgdG8gYWRkcmVzcyBhbGwgdXNlIGNhc2Vz
IGRlc2NyaWJlZCBpbiB0aGUgZnVsbCBibG93bgo+Pj4gX0ZfU1RPUCB2aXJ0aW8gc3BlYyBwcm9w
b3NhbCwgc3VjaCBhczoKPj4+Cj4+PiAtLS0tLS0tLS0tLS0tLSU8LS0tLS0tLS0tLS0tLS0KPj4+
Cj4+PiAuLi4uLi4gdGhlIGRldmljZSBNVVNUIGZpbmlzaCBhbnkgaW4gZmxpZ2h0Cj4+PiBvcGVy
YXRpb25zIGFmdGVyIHRoZSBkcml2ZXIgd3JpdGVzIFNUT1AuwqAgRGVwZW5kaW5nIG9uIHRoZSBk
ZXZpY2UsIGl0Cj4+PiBjYW4gZG8gaXQKPj4+IGluIG1hbnkgd2F5cyBhcyBsb25nIGFzIHRoZSBk
cml2ZXIgY2FuIHJlY292ZXIgaXRzIG5vcm1hbCBvcGVyYXRpb24gCj4+PiBpZiBpdAo+Pj4gcmVz
dW1lcyB0aGUgZGV2aWNlIHdpdGhvdXQgdGhlIG5lZWQgb2YgcmVzZXR0aW5nIGl0Ogo+Pj4KPj4+
IC0gRHJhaW4gYW5kIHdhaXQgZm9yIHRoZSBjb21wbGV0aW9uIG9mIGFsbCBwZW5kaW5nIHJlcXVl
c3RzIHVudGlsIGEKPj4+IMKgwqDCoCBjb252ZW5pZW50IGF2YWlsIGRlc2NyaXB0b3IuIElnbm9y
ZSBhbnkgb3RoZXIgcG9zdGVyaW9yIGRlc2NyaXB0b3IuCj4+PiAtIFJldHVybiBhIGRldmljZS1z
cGVjaWZpYyBmYWlsdXJlIGZvciB0aGVzZSBkZXNjcmlwdG9ycywgc28gdGhlIGRyaXZlcgo+Pj4g
wqDCoMKgIGNhbiBjaG9vc2UgdG8gcmV0cnkgb3IgdG8gY2FuY2VsIHRoZW0uCj4+PiAtIE1hcmsg
dGhlbSBhcyBkb25lIGV2ZW4gaWYgdGhleSBhcmUgbm90LCBpZiB0aGUga2luZCBvZiBkZXZpY2Ug
Y2FuCj4+PiDCoMKgwqAgYXNzdW1lIHRvIGxvc2UgdGhlbS4KPj4+IC0tLS0tLS0tLS0tLS0tJTwt
LS0tLS0tLS0tLS0tLQo+Pj4KPj4gUmlnaHQsIHRoaXMgaXMgdG90YWxseSB1bmRlcnNwZWNpZmll
ZCBpbiB0aGlzIHNlcmllcy4KPj4KPj4gSSdsbCBleHBhbmQgb24gaXQgaW4gdGhlIG5leHQgdmVy
c2lvbiwgYnV0IHRoYXQgdGV4dCBwcm9wb3NlZCB0bwo+PiB2aXJ0aW8tY29tbWVudCB3YXMgY29t
cGxpY2F0ZWQgYW5kIG1pc2xlYWRpbmcuIEkgZmluZCBiZXR0ZXIgdG8gZ2V0Cj4+IHRoZSBwcmV2
aW91cyB2ZXJzaW9uIGRlc2NyaXB0aW9uLiBXb3VsZCB0aGUgbmV4dCBkZXNjcmlwdGlvbiB3b3Jr
Pwo+Pgo+PiBgYGAKPj4gQWZ0ZXIgdGhlIHJldHVybiBvZiBpb2N0bCwgdGhlIGRldmljZSBNVVNU
IGZpbmlzaCBhbnkgcGVuZGluZyAKPj4gb3BlcmF0aW9ucyBsaWtlCj4+IGluIGZsaWdodCByZXF1
ZXN0cy4gSXQgbXVzdCBhbHNvIHByZXNlcnZlIGFsbCB0aGUgbmVjZXNzYXJ5IHN0YXRlICh0aGUK
Pj4gdmlydHF1ZXVlIHZyaW5nIGJhc2UgcGx1cyB0aGUgcG9zc2libGUgZGV2aWNlIHNwZWNpZmlj
IHN0YXRlcykKPiBIbW1tLCAicG9zc2libGUgZGV2aWNlIHNwZWNpZmljIHN0YXRlcyIgaXMgYSBi
aXQgdmFndWUuIERvZXMgaXQgCj4gcmVxdWlyZSB0aGUgZGV2aWNlIHRvIHNhdmUgYW55IGRldmlj
ZSBpbnRlcm5hbCBzdGF0ZSB0aGF0IGlzIG5vdCAKPiBkZWZpbmVkIGluIHRoZSB2aXJ0aW8gc3Bl
YyAtIHN1Y2ggYXMgYW55IGZhaWxlZCBpbi1mbGlnaHQgcmVxdWVzdHMgdG8gCj4gcmVzdWJtaXQg
dXBvbiByZXN1bWU/IE9yIHlvdSB3b3VsZCBsZWFuIG9uIFNWUSB0byBpbnRlcmNlcHQgaXQgaW4g
Cj4gZGVwdGggYW5kIHNhdmUgaXQgd2l0aCBzb21lIG90aGVyIG1lYW5zPyBJIHRoaW5rIG5ldHdv
cmsgZGV2aWNlIGFsc28gCj4gaGFzIGludGVybmFsIHN0YXRlIHN1Y2ggYXMgZmxvdyBzdGVlcmlu
ZyBzdGF0ZSB0aGF0IG5lZWRzIGJvb2trZWVwaW5nIAo+IGFzIHdlbGwuCk5vdGVkIHRoYXQgSSB1
bmRlcnN0YW5kIHlvdSBtYXkgaW50cm9kdWNlIGFkZGl0aW9uYWwgZmVhdHVyZSBjYWxsIApzaW1p
bGFyIHRvIFZIT1NUX1VTRVJfR0VUX0lORkxJR0hUX0ZEIGZvciAoZmFpbGVkKSBpbi1mbGlnaHQg
cmVxdWVzdCwgCmJ1dCBzaW5jZSB0aGF0J3MgaXMgYSBnZXQgaW50ZXJmYWNlLCBJIGFzc3VtZSB0
aGUgYWN0dWFsIHN0YXRlIApwcmVzZXJ2aW5nIHNob3VsZCBzdGlsbCB0YWtlIHBsYWNlIGluIHRo
aXMgU1RPUCBjYWxsLgoKLVNpd2VpCgo+Cj4gQSBmb2xsb3ctdXAgcXVlc3Rpb24gaXMgd2hhdCBp
cyB0aGUgdXNlIG9mIHRoZSBgc3RvcGAgYXJndW1lbnQgb2YgCj4gZmFsc2UsIGRvZXMgaXQgcmVx
dWlyZSB0aGUgZGV2aWNlIHRvIHN1cHBvcnQgcmVzdW1lPyBJIHNlZW0gdG8gcmVjYWxsIAo+IHRo
aXMgaXMgc29tZXRoaW5nIHRvIGFiYW5kb24gaW4gZmF2b3Igb2YgZGV2aWNlIHJlc2V0IHBsdXMg
c2V0dGluZyAKPiBxdWV1ZSBiYXNlL2FkZHIgYWZ0ZXIuIE9yIGl0J3MganVzdCBhIG9wdGlvbmFs
IGZlYXR1cmUgdGhhdCBtYXkgYmUgCj4gZGV2aWNlIHNwZWNpZmljIChpZiBvbmUgY2FuIGRvIHNv
IGluIHNpbXBsZSB3YXkpLgo+Cj4gLVNpd2VpCj4KPj4gwqAgdGhhdCBpcyByZXF1aXJlZAo+PiBm
b3IgcmVzdG9yaW5nIGluIHRoZSBmdXR1cmUuCj4+Cj4+IEluIHRoZSBmdXR1cmUsIHdlIHdpbGwg
cHJvdmlkZSBmZWF0dXJlcyBzaW1pbGFyIHRvIAo+PiBWSE9TVF9VU0VSX0dFVF9JTkZMSUdIVF9G
RAo+PiBzbyB0aGUgZGV2aWNlIGNhbiBzYXZlIHBlbmRpbmcgb3BlcmF0aW9ucy4KPj4gYGBgCj4+
Cj4+IFRoYW5rcyBmb3IgcG9pbnRpbmcgaXQgb3V0IQo+Pgo+Pgo+Pgo+Pgo+Pgo+Pj4gRS5nLiBk
byBJIGFzc3VtZSBjb3JyZWN0bHkgYWxsIGluIGZsaWdodCByZXF1ZXN0cyBhcmUgZmx1c2hlZCBh
ZnRlcgo+Pj4gcmV0dXJuIGZyb20gdGhpcyB1QVBJIGNhbGw/IE9yIHNvbWUgb2YgcGVuZGluZyBy
ZXF1ZXN0cyBtYXkgYmUgc3ViamVjdAo+Pj4gdG8gbG9zcyBvciBmYWlsdXJlPyBIb3cgZG9lcyB0
aGUgY2FsbGVyL3VzZXIgc3BlY2lmeSB0aGVzZSB2YXJpb3VzCj4+PiBvcHRpb25zIChpZiB0aGVy
ZSBhcmUpIGZvciBkZXZpY2Ugc3RvcD8KPj4+Cj4+PiBCVFcsIGl0IHdvdWxkIGJlIG5pY2UgdG8g
YWRkIHRoZSBjb3JyZXNwb25kaW5nIHN1cHBvcnQgdG8gdmRwYV9zaW1fYmxrCj4+PiBhcyB3ZWxs
IHRvIGRlbW8gdGhlIHN0b3AgaGFuZGxpbmcuIFRvIGp1c3Qgc2hvdyBpdCBvbiB2ZHBhLXNpbS1u
ZXQgSU1ITwo+Pj4gaXMgcGVyaGFwcyBub3Qgc28gY29udmluY2luZy4KPj4+Cj4+PiAtU2l3ZWkK
Pj4+Cj4+Pj4gwqDCoMKgICogQGdldF9jb25maWdfc2l6ZTogR2V0IHRoZSBzaXplIG9mIHRoZSBj
b25maWd1cmF0aW9uIHNwYWNlIAo+Pj4+IGluY2x1ZGVzCj4+Pj4gwqDCoMKgICrCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmaWVsZHMgdGhhdCBhcmUg
Y29uZGl0aW9uYWwgb24gCj4+Pj4gZmVhdHVyZSBiaXRzLgo+Pj4+IMKgwqDCoCAqwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQHZkZXY6IHZkcGEgZGV2
aWNlCj4+Pj4gQEAgLTMxNiw2ICszMjEsNyBAQCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzIHsKPj4+
PiDCoMKgwqDCoMKgwqAgdTggKCpnZXRfc3RhdHVzKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYp
Owo+Pj4+IMKgwqDCoMKgwqDCoCB2b2lkICgqc2V0X3N0YXR1cykoc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZGV2LCB1OCBzdGF0dXMpOwo+Pj4+IMKgwqDCoMKgwqDCoCBpbnQgKCpyZXNldCkoc3RydWN0
IHZkcGFfZGV2aWNlICp2ZGV2KTsKPj4+PiArwqDCoMKgwqAgaW50ICgqc3RvcCkoc3RydWN0IHZk
cGFfZGV2aWNlICp2ZGV2LCBib29sIHN0b3ApOwo+Pj4+IMKgwqDCoMKgwqDCoCBzaXplX3QgKCpn
ZXRfY29uZmlnX3NpemUpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldik7Cj4+Pj4gwqDCoMKgwqDC
oMKgIHZvaWQgKCpnZXRfY29uZmlnKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHVuc2lnbmVk
IGludCAKPj4+PiBvZmZzZXQsCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgdm9pZCAqYnVmLCB1bnNpZ25lZCBpbnQgbGVuKTsKPgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
