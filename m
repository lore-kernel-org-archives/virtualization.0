Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0BFC433F5
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 21:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5025E40948;
	Thu, 12 May 2022 21:13:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nwGwTIbEa31k; Thu, 12 May 2022 21:13:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9EE3540924;
	Thu, 12 May 2022 21:13:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7099BC0039;
	Thu, 12 May 2022 21:13:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F726C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 21:13:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 76AAC60B73
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 21:13:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="mRMxPjxQ";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="C5ZMmr4X"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XvvrhYF3zBiW
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 21:13:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 733F760E18
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 21:13:10 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CJfFLv023623;
 Thu, 12 May 2022 21:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : from : to : cc : references : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ow222L63fCsOm9599/QtCjVKe2JWlowxdS2pDjrKjtI=;
 b=mRMxPjxQHbduJ8tpAet+T6a7JbF0AfXMgUTDf5zoXCSTJ7dJrJv27qQX8F41Od//Q86x
 DTPJlxfllAGIouoYQHBVThOQXA39mLMngabDHG9YiZWkX3WVNg9mWEnZ53XL7iFbq8Tv
 M2eeRmYx6lKRZWx3Zc8wEFnAPlxdQegFELXQrNPLIKHb1J7SU+WI+9YQTFWF+qktsmUq
 qiEvlohkfEbqdPEzVZYX5n8PT1AC8S+kK2d00HcK/seAq4zwEiSX+y5KniHkFrLLS3Hd
 jTSU8qCAdy3sYv+yLNhpmnunZwyq7ny5zVCa0BEc1dQPZ2CGexO1NuOASbo1Xholfkuy 7w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgcsx2b2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 May 2022 21:13:08 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24CKtkO8017780; Thu, 12 May 2022 21:13:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3fwf761uy3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 May 2022 21:13:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZifLgAFI1uNSGBP0upZvUMywvydthT/D0yOl59CGbqbAW8RAkexic/k9MNpyoVJpSONMen+tC4CSCI8AhCo1LFneM9S8ByMYA6Lrtw6btV2TbyPJsfzrk00OZieq6PdG9/IbjlTtbDkKTgKbnBf1aWYBTSjfcorQigy0U4Lzo44m8mHmo2SsYgTebFtZX+OZiswCZW6M/84Qa5HnN78YnBzkMYIl1FjgYrkYGy0WB9uH2YVe3AXFOp32zK2yojTf/5lUrscDQdyVEucJtAKX8N7lHJ/hSSlZ5JN1yxqf3T3Vn1sBRU0qROUGLXIpAHlD7bg9N7p2h+51/kwMGN0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ow222L63fCsOm9599/QtCjVKe2JWlowxdS2pDjrKjtI=;
 b=grGGOSZriKNhu9sw1omO8BP4K882rg83O1Ty/HRZ+H6v2dRQZCOuLakv6kbxIOD2FopDVnjVWA5KgGePK5AKojhNNs04KzVLUDK3xMHKIrEG/douAFHByRTSjlpbSfx8xDfpzpyUKwVol9nNBdBnAB5xktD9EZxI96X+z/Pukfilbrz2W0YwgQVbiuagN2Bp7u5tc7AfST+3uVbykHJ9dknMXInWG6MnzcRqDNnZpxoCmzb4TTcUBP+fqzhu9Diu0GgPgbwwYOejEzATTNAg2XVKJTB+KLn2JXV9KOZrv7h6sC+VCQiXYAatVH3lWSlRA+yZAU8dfNcOpC5m0rTC0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ow222L63fCsOm9599/QtCjVKe2JWlowxdS2pDjrKjtI=;
 b=C5ZMmr4XUKUDVVX0m03FmB9tvfVfQEADDPoOBJHHTgCnuUOabTX2UTT8lFU0gJx3CQoQLH8pL07B57+ZjcQgOca39pT7qCcsb9lGX9Zce32pROm1wy2QdJwunQn/TDSZE/qj58vHicY3/kqwdGKv6HZrI6iD7p7fKiv4SdjEqnM=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by MW5PR10MB5876.namprd10.prod.outlook.com (2603:10b6:303:190::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 21:13:06 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30%2]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 21:13:05 +0000
Message-ID: <75e06364-c83b-4809-cd71-7f8946ce752e@oracle.com>
Date: Thu, 12 May 2022 14:13:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 3/3] vdpa/mlx5: Add support for reading descriptor
 statistics
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com
References: <20220510112734.205669-1-elic@nvidia.com>
 <20220510112734.205669-4-elic@nvidia.com>
 <eda33c78-fd39-a5bb-9e9e-06b2c37d3fe5@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <eda33c78-fd39-a5bb-9e9e-06b2c37d3fe5@oracle.com>
X-ClientProxiedBy: BY5PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::35) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce394203-f6c2-46b3-115c-08da345c34b4
X-MS-TrafficTypeDiagnostic: MW5PR10MB5876:EE_
X-Microsoft-Antispam-PRVS: <MW5PR10MB5876D7F7B8A3CB7858C0C17FB1CB9@MW5PR10MB5876.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: essUSJcpB0rX3fk38IcmPEz7av7K0aqCwvpLcmI+HdoovLMf+1GCd6/0PLaeQ37uq+aIusg4VPPrCT+eBJZ4s1I4PFsWDaRfBG/fGsSz06uG3h9k2gG7GeYczO6AZWJeGpQOmilEo1qhkhY/LvQ2P/dLhkK3PN6I/ls24Kfm2a4D5+6NMzK+FXJs/yMw6em+orfWZClOCyfTgi96tzVBFNSP3aZRTYWmDQjcRgcBsWfjWatHO5MupB4XQeJjsAKRTShM7TYKs88QXNXNlpKITm8YAt2sW+NmmnDRc/dbkQS72t+5+PlVcznm1CHlpfz1bTIEVS6Acl4EHdmXKPHt425nKqcigPHm0uVJlTTTvfSY23KFJ8Od+/ZzFMitbeuPLbYPp5/hY4h7OiejkWQmfRNk3KeGf+E+ZDZhJrgWeX8fCEO3Uz0wxGaNn4r+SaxDR+FEF7aKYY56vZF4CnVcCYONTpgCCUgoIJQukmkoDYgpOfkE/jsQYVoEgYfp6VA+XtlXshtos7faru10JCMTpOVlX+CYGVU9mEwNvIk/V20pQW8h28gLaYGOO0CYgdeboxi979LX1zUR9Z08XQgB72NOM7NBqjbXR0jeG19rCWMIkTrFPlCsughFUVVxDRrLewOkdc8TvqykoE5v5kZSgX/cZ3f+j/BHkn2NmxfMBSDCiEqE5I+xsiiJpA7UIWFXEUl5PI110u/a55mEZa6JbMkoWx53q+q04/EgJP6uY4LQNQbNjvcTesZjOh2YPJll
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(2616005)(6512007)(26005)(4326008)(6486002)(53546011)(8676002)(6666004)(86362001)(31696002)(33964004)(316002)(508600001)(6506007)(36916002)(38100700002)(83380400001)(186003)(5660300002)(31686004)(8936002)(36756003)(2906002)(66556008)(66946007)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTBCWWFQOWlMZzdCbmJBMHFuMjk2VzF5bWR6c1g3Q0xNSlh2WDdYck1Nc3ds?=
 =?utf-8?B?TWRiaUNBR09RN2hSbi9vZjRqR2xVaFdTb3NvaFRPWEtHR3lDK2xxTkt2Q0dn?=
 =?utf-8?B?TlpIaW9UUkNPLzBreVdwV21qVTl0Z0ZwanNYZnFEWUZwWG5Jd0F0VjV4Vkp3?=
 =?utf-8?B?VktDTGNkK3QzRG9PYzJoODRtMUNSMjhJOGI4ck9XWHpEU01CMTROVXhDL1Ns?=
 =?utf-8?B?cmxFMmVJRW1ab1NZa0c3NUY0dVF3U0p1Y3BaeTZNb3ZrdmxFQ0RKVzRSZzFY?=
 =?utf-8?B?SyszaHN3NDdXWlJUekNUNDZOc294SnVDYS9aT3NWTi9zY21GdWI1Nk90dFFa?=
 =?utf-8?B?UDdqc2I5cFRKaVMyRlBrclo5SjNITEgxT3dBb0p0ZU1IT3hrRHZ5cDZTWkR0?=
 =?utf-8?B?aU5hS0Y4V2ZPenI1WFExa1VwVFI1YnhOZ1UvZXdDRUVNUzYxSjNITzNYWWlp?=
 =?utf-8?B?S3loRHA5WElraHdrS1AzaExvN0dXMWY1QitoRHZFS3VPWkRCMTdYLzhvWlAx?=
 =?utf-8?B?UXBVM3VqT3FZaUxjNDBRcTZyRUt6TWZvWVdJTXo3YVhDYjF0ejNMSmgxa2pM?=
 =?utf-8?B?N3lPNUVwNHlNZTRFVWM3Z2xKRWxoWHpuSUg5U1lHb0pxWnljSlA1NFE0QkN0?=
 =?utf-8?B?bnUyOEZFRENRN2JYVU52NVBIYVJobTB4TmlBc0VDSllnNTA5cnlMbklBOG96?=
 =?utf-8?B?V3Zrc25DTTJaT0pGbG9lTkNWMXRFbGMzQ3YzTE4xcGJ3QjdjTTNaMUs5THBx?=
 =?utf-8?B?U2NjQTJSY1V5Y2tkOTR6THBocG85bFU3NXZhU1JoTVk1aWhUY21HcmxTRkF0?=
 =?utf-8?B?Qmt5R1lqQ1lkUG94QUVnUzVVaXRORkR4djhtYVlCdUo1anA4c2wxMlZ6RUZD?=
 =?utf-8?B?UTg3bncxZmlwZHF1THN2VUR3TkttcWxCM1REOFlhTUdIN2tnZkk1Vkt5TU42?=
 =?utf-8?B?aUdqcjI3OG85OFdXdENJbVZPR3p3R3ppZ3ZLR3kwbXVaWktacGxCRnBtMENk?=
 =?utf-8?B?UTRsSndFbVBVNG14dFYrUjhCSzk5SHBTOG1STHJmZFNWaVRzZDBzclFhY1dL?=
 =?utf-8?B?cjFTWkNNanI0TlZhVkdLYWhLamFFREtvMHZMaEIwcVVpYkw5WTdDZHBCR0J3?=
 =?utf-8?B?VWxNMHYrS2Rwb2RlWWM5Mzhnbjd4M3ZlbXJWZExocXkzeWtZQkdNZnpJTWdq?=
 =?utf-8?B?OFRCb295OFJVZGRGa3l1akhJY3VrajRtZHZUSDc1YWVNcmJpZlR3bmc1YWU3?=
 =?utf-8?B?Q0tLR2xORUx5M0NSV0w0WHY2RWdGNjF2V0llVEZlTHIrdndCYlVIRzcxTFhW?=
 =?utf-8?B?Rk5IZEp1R1VUcmxVSHN3aWppQkFQakdUNENqUk9mOVJIcHFlVFhkT1g4VE9s?=
 =?utf-8?B?ckNVTnNQeFhCTzRrbTdOMUo4ZmM3ZzVVTDE4V3dhVzBITllVODI0WjlsWStQ?=
 =?utf-8?B?c1YvWlQ0dG5EQkFCaGJPZTNDaVQyQUk3YmhBUGtycHNEcU1SRzdjaW93SXQ4?=
 =?utf-8?B?WWp5a3ZndWFPbDVZemZ5c1RjZDBGd2I1WFRsTG9SN0Y1emdFTnVQV1JSQVFI?=
 =?utf-8?B?U3NnZ1BSRzl4Q2tOYkFVWlVTVTNDdklteG9oUEVNY2M5TW43T3k2N1JGS2hi?=
 =?utf-8?B?WnpJM0FxcGV5TjBzRmkzWnVnSXZrOHVnWVNpWVFNeCtwOE5WUDJFZ0cwamNa?=
 =?utf-8?B?ZVBIdCtGZTZoL25ZZ1JVVW5RdXhldEFjNEpDMUdoV2hlUDVaZWJsUFB4MUpX?=
 =?utf-8?B?cVgxL0Vob2Z5WmlObGhyZS8wL2xjQnpxODROQjFYKzRaYk1Za2MwV1dXMGRP?=
 =?utf-8?B?MGJCMDNaa293cFBDbHhPMHMzVFJIZFBSYWp3M0dpcC94QTBrTmFXd0VZbGpa?=
 =?utf-8?B?L2pTWlZIWU1WdE1zOTVGcTdwUXVtT1REbzViemNmTkV2WlVlM3VzbDd6NENB?=
 =?utf-8?B?WGFaWjFmMW1yYkYzcDlxSTJtbiswcmppdTBQa0tNVnlpOGxGUWkzTGo5QjE4?=
 =?utf-8?B?dmpNQjJ2d0hnR2RvekkvdThFVHJJdlNkc2hjUmNRNEpMMWR0N0VXYXF3OUNo?=
 =?utf-8?B?YUROM0lxbVY2a2lGNjAvRklhNHU3Ykh4cWlHUlV5bi9Ydk1KRW9ycy85Vzkw?=
 =?utf-8?B?YUdCZmJacXFZNzg4MTIyb1YwTUZCVDdaamlqS2hMMWZXNjBoQWhWQ09SdS9i?=
 =?utf-8?B?N250SlBzV05MTHhCWlFyK1dnVGNDVTBMdVBKSkZtb2RtL01tSE5qNC9TRGFY?=
 =?utf-8?B?anBJQ1FNQXJSWVA2NjNQTlJXdFhXb0xtS3BYTWM5WjRJMnMvbldvdGdGcWh2?=
 =?utf-8?B?OG5vdnViejNpaGdRZGx0RjV4MHNsSEx0VTlDbWhPek1PT0RRUWNHdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce394203-f6c2-46b3-115c-08da345c34b4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 21:13:05.8916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ol674nh7EtQ7TjjF/FbcjsglNEvj8B7Pvbb/68yrD8IFzepV33rzF/hSTtobVYnjqELYkWlyRyeOfvFhXh2yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5876
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-05-12_13:2022-05-12,
 2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120088
X-Proofpoint-GUID: wU9uDH9vpckJbc22F1S2E7ZN4Xt2Mfw8
X-Proofpoint-ORIG-GUID: wU9uDH9vpckJbc22F1S2E7ZN4Xt2Mfw8
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============6941618800081808180=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============6941618800081808180==
Content-Type: multipart/alternative;
 boundary="------------9IfWElqvlUKUBRD2xcdrW7ih"
Content-Language: en-US

--------------9IfWElqvlUKUBRD2xcdrW7ih
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/11/2022 10:25 AM, Si-Wei Liu wrote:
>>
>> +
>> +static int mlx5_vdpa_get_vendor_vq_stats(struct vdpa_device *vdev, 
>> u16 idx,
>> +                     struct sk_buff *msg,
>> +                     struct netlink_ext_ack *extack)
>> +{
>> +    struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>> +    struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>> +    struct mlx5_vdpa_virtqueue *mvq;
>> +    struct mlx5_control_vq *cvq;
>> +    u64 received_desc;
>> +    u64 completed_desc;
>> +    int err = 0;
>> +    u16 max_vqp;
>> +
>> +    mutex_lock(&ndev->reslock);
> I wonder if we can change this lock to r/w semaphore too, otherwise it 
> almost defeats the merit of converting vdpa_dev_mutex to the same. 
> This change would benefit multiple parallel readers. 
It looks like the lately posted v6 series missed this change somehow?

-Siwei
--------------9IfWElqvlUKUBRD2xcdrW7ih
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 5/11/2022 10:25 AM, Si-Wei Liu
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:eda33c78-fd39-a5bb-9e9e-06b2c37d3fe5@oracle.com">
      <blockquote type="cite" style="color: #007cff;"><br>
        +
        <br>
        +static int mlx5_vdpa_get_vendor_vq_stats(struct vdpa_device
        *vdev, u16 idx,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct sk_buff *msg,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct netlink_ext_ack *extack)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
        <br>
        +&nbsp;&nbsp;&nbsp; struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
        <br>
        +&nbsp;&nbsp;&nbsp; struct mlx5_vdpa_virtqueue *mvq;
        <br>
        +&nbsp;&nbsp;&nbsp; struct mlx5_control_vq *cvq;
        <br>
        +&nbsp;&nbsp;&nbsp; u64 received_desc;
        <br>
        +&nbsp;&nbsp;&nbsp; u64 completed_desc;
        <br>
        +&nbsp;&nbsp;&nbsp; int err = 0;
        <br>
        +&nbsp;&nbsp;&nbsp; u16 max_vqp;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; mutex_lock(&amp;ndev-&gt;reslock);
        <br>
      </blockquote>
      I wonder if we can change this lock to r/w semaphore too,
      otherwise it almost defeats the merit of converting vdpa_dev_mutex
      to the same. This change would benefit multiple parallel readers.
    </blockquote>
    It looks like the lately posted v6 series missed this change
    somehow?<br>
    <br>
    -Siwei<br>
  </body>
</html>

--------------9IfWElqvlUKUBRD2xcdrW7ih--

--===============6941618800081808180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6941618800081808180==--
