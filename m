Return-Path: <SRS0=m8lA=H4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E82C433DB
	for <virtualization@archiver.kernel.org>; Fri, 26 Feb 2021 00:36:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B1164F1B
	for <virtualization@archiver.kernel.org>; Fri, 26 Feb 2021 00:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B1164F1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79A0A84264;
	Fri, 26 Feb 2021 00:36:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RET6qibZS1Bk; Fri, 26 Feb 2021 00:36:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id E57E28425E;
	Fri, 26 Feb 2021 00:36:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B928DC000A;
	Fri, 26 Feb 2021 00:36:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6800C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 00:35:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F1394335E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 00:35:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="Dsf47uW8";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="v3uII8Oh"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hmxJ0Mg-8IIn
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 00:35:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3FF3243371
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 00:35:57 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11Q0PU3J129342;
 Fri, 26 Feb 2021 00:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=l5cF7J2LVb1Aoz2fpwl1XWQ2LTITEsQwukkm3QM5vTo=;
 b=Dsf47uW8QjgiqmpkmsyL0PxzW3LZm21dUUbbJ9MHE5+CTch49TWh1ULIDk46UdQzCSWz
 UCMXPj8RMG1HnzsfRhpn/IrHGHXwnhsjayQ9a9NW0c2UbmGZaoNBPlo7iZRz7WoRNMb0
 srvIxLVgobCaZ5FagnmjNUWD/gCp8ywjJPVjbFnxlmsggwdNcubPziOo2Pl4bAdEbfNR
 Dboe7OCiGLj6I5LlznhvWBVElrmCjkZZJAVQHQwh1Zy4DvLS4PKnLd4FYBKvqIy1ABSI
 YXGMWSxSnsn09ekVNnP7hf2MbYxoNTADap7vFnyjAkRW6foDOrCbqr5Zf2juDPVkM+vo hA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 36ugq3q8c6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Feb 2021 00:35:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11Q0OhBI014789;
 Fri, 26 Feb 2021 00:35:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
 by aserp3030.oracle.com with ESMTP id 36v9m7yfh5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Feb 2021 00:35:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfJ94P1EUBOFzB3schNpZvSAoS7yu3NrRpFVVRScxroGQyPZFq1D7xUnxc7gdSuB892BS32W5kG5s4djMEUrZJOCPQdNWNIlxCfXXIwJrR5GD9twJbOdk4CmSCRHzHPxEdrk8FQxrRYmo8FjkM5LjFQtgfhUKq+hfHLzmcad1MUlb9a4vQhflwzyUWaN0aItciulZIFGCA3t+UW8lglJivrs0pQqkUu/Zz4TiAZD9gPMXGsmi39ebD2pXEUtdo6JecUM23ZU0UOOGTi4VixJ/HYTk/SaIvMzjtuu5dD2eca3xyQ9fgMp4yXFJK89G18KbzY1y19MSumRTo0+akfcKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5cF7J2LVb1Aoz2fpwl1XWQ2LTITEsQwukkm3QM5vTo=;
 b=WpmLe5hq08iXEcnzBJi9lKz7zNQDKhG09dCU2o+tg7IivhBkPKa1bjuD3hz+FzbpxpdJofyB9GU4D/sG3GSVBaY2EB4M+TtZZ7U1bBHM7ZEy845Tz36Vvxyb70hnovlV4t4WIDu0jVq8VQ3Jp2QL4eMCHdb59NMFnKATd+eHhvdDJNgz3n3y5+xYwcJCdvR9bcaPDXG4WqjCtf2freI2L6e39WXINbpBYeHlIExwj4NXzsjTPRpkPElq7IsYI00b1yJOswg37SfNIR7RsY+cOLE5QhC4emAanCNobQEHtCB2ahfSFJQUMVaLs/j21cUumEmPKLZQNkP9GlBImW/L6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5cF7J2LVb1Aoz2fpwl1XWQ2LTITEsQwukkm3QM5vTo=;
 b=v3uII8Oh1Jj0j7F5/V4KXdspHHHLzbE/gGxBXQ/ouCOwBY1u35dUZ3La4rRwdtLqGGmM/JkH5pFb76FxW3vfzR3wsBFjlCmI7Yp9O/3O+u7AHs02JYm9NoJsTGGhF6Sy5b0kBvIpGrEYm5qAgylLK2wJtg/cNznY5dljaIJF1bw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none; vger.kernel.org; dmarc=none action=none header.from=oracle.com; 
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 00:35:53 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::45b5:49d:d171:5359]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::45b5:49d:d171:5359%5]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 00:35:53 +0000
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
Organization: Oracle Corporation
Message-ID: <c16ea428-027a-bfc1-5c95-9089ace4c112@oracle.com>
Date: Thu, 25 Feb 2021 16:35:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
Content-Language: en-US
X-Originating-IP: [24.6.170.153]
X-ClientProxiedBy: CY1PR03CA0013.namprd03.prod.outlook.com (2603:10b6:600::23)
 To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.19] (24.6.170.153) by
 CY1PR03CA0013.namprd03.prod.outlook.com (2603:10b6:600::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 00:35:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e7fa39e-ba2e-445e-0e85-08d8d9ee791c
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4815:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB48159C74F932B09C2DB3D84CB19D9@SJ0PR10MB4815.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9HxzbSKnmddJN0b6FezxWbN0EasXHUa/r+lpHfrOE85rHgWBGt51SuTC9MHKaW7BJeBBGCZz/yxRSkv5YoKq25rWuU8fTaQyA6/MtMDkLib3nuXQVWm3/bULVtcDxCjWMaCDK/k6BKDzh2EDz7o64udydM4g0AVnYp6tYXjecW+YZG90wgUERPK0evSj2k03QPrTFPaWsVWzgpJzc3xnhR6+wgZvhxdEa7n0LBuXlfsuHh9ice1X+UDnmPkTQWLCANUr9LgKYuvWY9p/FkNr3fX4Mo4D8mvX06T7HlQEH8L/HjPmRicfU8kSIo0punpHjPqn3dagfgFp5tq4GEzp9mkKU4mriBmYIi6qFBkO9g0lLb6QmG57uPAfwhtIEsRN7l/B8dv/4sMxsCMms6I0pgNDvUeZqnFetUakyLApbx58k2lWlCnrkcW742VrJ8Orcn0ANzdthvoue98Dru1mD1vMRSWyfTWNa+3TAEVSa9oTyi35qYRopBfRpkU6Quo41nWUkYv5PoU0M/gehLtlzbPwvp4GyWPyggIcvo7EtioOe35CMX1dEwrO7bJETe86rp1spswn13TsUEo4OOsq1PQCitJvONFiHIJ1dO2GW8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(39860400002)(346002)(136003)(376002)(396003)(31686004)(8676002)(8936002)(2906002)(36756003)(478600001)(316002)(4326008)(6916009)(2616005)(16576012)(6486002)(86362001)(66476007)(186003)(26005)(66946007)(53546011)(36916002)(66556008)(33964004)(956004)(31696002)(5660300002)(83380400001)(6666004)(16526019)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aUlYR005WnZmcTlocjJRcUEyVStuTVJzMlpIdmlhcFpmWEd0RGJXeEI0bG56?=
 =?utf-8?B?YTk0U1pJdzlGS3JPamllL3d4Ky9DR3puRHVVZFlaS0Z4bW55UW0zdk1pTCtX?=
 =?utf-8?B?bE5WVnMwLzZUaEdRTnlLMHVvRW9IK2xETWFtR3BXUnVZZFRqTzdGN1hpMGc3?=
 =?utf-8?B?V1NSaFJrc0VZdmNSOWNuK3VFZlY1U2lXa3FkRHFTbmU2ZkZ2WlcxanVvQ01F?=
 =?utf-8?B?dktrZjliNVExTjhrSlFWaGFhOVVYbDA2dFh5YW9tb2gybVJHcGNBSFpPeHlM?=
 =?utf-8?B?d1JseGRQdFR2RC91Zm9DYXhNdUJORFd6QTAxY05rZW9mTFMzS1cwdmE2NXFI?=
 =?utf-8?B?VndNNWQyT1h4Y1RCakRtc1IwZUxJS01hMjhPMW5uSUN2b3B4UlZEN3NQTy9Y?=
 =?utf-8?B?Wk41QW9qRnc3Z3crMmV0RmpvUWhoaGgyTjdlaDFqZWg2V3h1bzROV1dRUGd0?=
 =?utf-8?B?STdVenRtVUxFVlRkcElPZmFmek9SWXg4NXBzM0FVMUpyaXJoYW0vRHVRVUVh?=
 =?utf-8?B?dEFCZUYxaUFpU3VVT1ppcVhETHk0WGVnRkE4d0lHVGpwbXROdlEzNTFjNWZn?=
 =?utf-8?B?NEpNVU1sZURTQWxXTnBReEZLTUVOVFNDWkpFeVRmQlVQNkR3RXgrUmRnSFBS?=
 =?utf-8?B?SmRzdlhZWkxRM2VFbEM3eUV0akorNWcydjZmb2VhU2tSSWdNeWRIUGcwUnBI?=
 =?utf-8?B?R2xXeGp5VmNuN2s3Z0dKc003MnZyVldBQkVVSlh0NzhFMVVzTk1KQzJBdGlu?=
 =?utf-8?B?NitoajFSMzF2eGQ0TWJwbk1hSnhFK0VJZDRJVFpOaHdtWTBvUitYTnk4bVhL?=
 =?utf-8?B?Nm9MUjd1b3h4aVpSNDlSWHRXS1Fid1pkTitnQVRxNTBBQWtwTERDZ3BqYkZY?=
 =?utf-8?B?MXVqU2ZDb0hhbEFSWWN3SExPYTRCWkQybWI4QVJoVXhzei9tandZWWI5OXpv?=
 =?utf-8?B?RUEyYTNObHQvTHZ4N016M3hxM0NJSVk0V3Fxc1NYTUgvSXRPVmFValBabk9j?=
 =?utf-8?B?Tk04UThOUytqZElXRU5aaWdqcU9tWXlMZDVmcDIvRFhVWlJhNmNrenNqQjRq?=
 =?utf-8?B?NUdxait1aDVJMEtVTTlzblFoOG1oNTN3ZDlsaEkva0xha08rQk1QOHkxS0NP?=
 =?utf-8?B?UTVIM09VYmRUb2xRTDFheUhML1lFRGJhbXNaMmlteDViVWxzbkVMNmNubzBx?=
 =?utf-8?B?SjRUVEZwN1Q4OCtCb2g0TitBRktuSWdwVlc1bng5c1U2KzdiNEZhUHlHcFFG?=
 =?utf-8?B?Q1ZyR29QUjBjZU9NZkdvYTArRnVXeWZSVGQ2QXExVks2SUJhVisvOXVYQVBy?=
 =?utf-8?B?U3lSRVNnREgxdnNveWVPOVBEOHZqRjRHbHBsOFZ0UkpZcDQrdXVIQXBTMS9j?=
 =?utf-8?B?RzdEVkNyNU1nbHYwVnk4aHBXYnN4bTFubFdTMTlZR25MSXBITHlDbHhaYjZq?=
 =?utf-8?B?bnQ5SzU0WUFHdlFJb2xHcFBRek9uQmk5all3Skxaa1dCZTNSb1Y1VzViR3dx?=
 =?utf-8?B?dldBZzNpT2FjSnpIajArUGFBTGlZN1RVV0hxV0pmMzF6U0ZVSDFZY2N5WXlm?=
 =?utf-8?B?NldqTTR2WGljd1lFdFJQL0hJSGVMZEVyZHNpMjYyeGFJRDlrcW5uSjBEcUtm?=
 =?utf-8?B?WFYxa3pnVG52RkM0UTBOdWFyVFRLdWFjTzZFMERZMnlMb1dIRlNHWUN4c0JC?=
 =?utf-8?B?Q0FqZkNXSnVucHQ4NHY4dmF3SnBMRExUVjJpV1prTWF0THVYcXY3T2x3dDFn?=
 =?utf-8?Q?xlm/H9HoaFpRPy4f2blImwefARs0yeh4G0z2C+1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7fa39e-ba2e-445e-0e85-08d8d9ee791c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 00:35:53.2269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZcGmwlLOVVN1MlZ6vtZCayZOErn5lWnmjL2KVHuUD6n3j+9xU+DO6+NH47vIChMrlg7r95O87me4YLoaXmCCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4815
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260000
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260000
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elic@nvidia.com, linux-kernel@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============5419228839431217140=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============5419228839431217140==
Content-Type: multipart/alternative;
 boundary="------------12B82E1247DBA10B2FC380A6"
Content-Language: en-US

--------------12B82E1247DBA10B2FC380A6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

Are you okay to live without this ioctl for now? I think QEMU is the one 
that needs to be fixed and will have to be made legacy guest aware. I 
think the kernel can just honor the feature negotiation result done by 
QEMU and do as what's told to.Will you agree?

If it's fine, I would proceed to reverting commit fe36cbe067 and related 
code in question from the kernel.

Thanks,
-Siwei

On 2/24/2021 10:24 AM, Si-Wei Liu wrote:
>> Detecting it isn't enough though, we will need a new ioctl to notify
>> the kernel that it's a legacy guest. Ugh :(
> Well, although I think adding an ioctl is doable, may I know what the 
> use case there will be for kernel to leverage such info directly? Is 
> there a case QEMU can't do with dedicate ioctls later if there's 
> indeed differentiation (legacy v.s. modern) needed?
>
> One of the reason I asked is if this ioctl becomes a mandate for 
> vhost-vdpa kernel. QEMU would reject initialize vhost-vdpa if doesn't 
> see this ioctl coming?
>
> If it's optional, suppose the kernel may need it only when it becomes 
> necessary?
>
> Thanks,
> -Siwei 


--------------12B82E1247DBA10B2FC380A6
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <font face="monospace">Hi Michael,<br>
      <br>
      Are you okay to live without this ioctl for now? I think QEMU is
      the one that needs to be fixed and will have to be made legacy
      guest aware. I think the kernel can just honor the feature
      negotiation result done by QEMU and do as what's told to.Will you
      agree?<br>
      <br>
      If it's fine, I would proceed to reverting </font><font face="monospace">commit fe36cbe067 and related code in question
      from the kernel.<br>
      <br>
      Thanks,<br>
      -Siwei<br>
      <br>
    </font>
    <div class="moz-cite-prefix">On 2/24/2021 10:24 AM, Si-Wei Liu
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com">
      <blockquote type="cite" style="color: #007cff;">Detecting it isn't
        enough though, we will need a new ioctl to notify
        <br>
        the kernel that it's a legacy guest. Ugh :(
        <br>
      </blockquote>
      Well, although I think adding an ioctl is doable, may I know what
      the use case there will be for kernel to leverage such info
      directly? Is there a case QEMU can't do with dedicate ioctls later
      if there's indeed differentiation (legacy v.s. modern) needed?
      <br>
      <br>
      One of the reason I asked is if this ioctl becomes a mandate for
      vhost-vdpa kernel. QEMU would reject initialize vhost-vdpa if
      doesn't see this ioctl coming?
      <br>
      <br>
      If it's optional, suppose the kernel may need it only when it
      becomes necessary?
      <br>
      <br>
      Thanks,
      <br>
      -Siwei
    </blockquote>
    <br>
  </body>
</html>

--------------12B82E1247DBA10B2FC380A6--

--===============5419228839431217140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5419228839431217140==--
