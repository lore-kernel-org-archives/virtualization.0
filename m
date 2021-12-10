Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D6FC433EF
	for <virtualization@archiver.kernel.org>; Fri, 10 Dec 2021 08:26:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E052A8525C;
	Fri, 10 Dec 2021 08:26:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mBAdH1Nrj82Q; Fri, 10 Dec 2021 08:26:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6DB518521A;
	Fri, 10 Dec 2021 08:26:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AE6DC001E;
	Fri, 10 Dec 2021 08:26:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA386C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 08:26:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 918FD4093E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 08:26:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="nGfwv3j0";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="Uow0xS5L"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4g3EOKQhEbvE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 08:26:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1D4BB40200
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 08:26:31 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BA7axLt025228; 
 Fri, 10 Dec 2021 08:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=N2wq04/pq3y+AwXmUtfVRB1zIz884N+3DnpVGLfLVWw=;
 b=nGfwv3j0WE8qHONLEGSMiE3+8LNg+adNDjzBSksQtWGz2UPGTO3ZfhUtWZucwtavaH0Q
 8eWtpad7ErCB8mE2eYhOSuVK0FBZyr7NFTle1qU9r88ogCaN/wjrjdJkMez37KWdxl9P
 6hWnWLn4QWEPBA09Pq53seB71oFi1+022QccMhzVhl4XLacwPTzPRW3V8yliLl9opvgi
 UqAncoK28c4XFOUxAm9+EWeYHFp93wcApcAvFyt7qvCyrmeb9ZCsIzBT1ppe3N7AiWn0
 UGwS1Gzl1QXB/uKOCX7g2TkHGJlPNRtLick3AW7yGqlGSiygqcgrZCaQcuM4lxbWKtvG tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ctua7n3rf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Dec 2021 08:26:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BA8CEi4130975;
 Fri, 10 Dec 2021 08:26:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
 by aserp3020.oracle.com with ESMTP id 3cr0590v3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Dec 2021 08:26:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5Xz24tIV/IrH3LrnZoiiDs3pV5nacUB6sQxMDBeOTP6IJ8x82cRt/9SXtZ3DcZgrjpVPAconUDYvXvqs95zqf7tZXtkm3z9G7veAYEYhK2fOe/rNymu7ZSxUGCp5vjBZON5xzYGmq/M6zlzQItg/T1mv0S4Bq8kybsLen5Jwj2CICJECtehEwVRApsiaMjURkej3y328QqXlkR2rG4L869f4xPVC5pI1g1X+tDJN1H0hWtTwczZQS4hbyZEXl90CSCBMWa71rDi+xFHtH3ohaW8GkUmknx6UaNJBanjIQFBKCHUk9K6zrIuyG0ihqWRULB8gZv5OkGRWLIrexxi8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2wq04/pq3y+AwXmUtfVRB1zIz884N+3DnpVGLfLVWw=;
 b=bXke6TLE8nRNIio3nUkSkTSPYvMRmtMEJxhpX5M3nKChLwiDdIirlMrTGOqwL5LFeYk6YRbO9eLGvmtmNFqgokCgGEGJ0TP7v8lECfz7AbTepc8CQd1TGC4U0Bz+nXvp2pg8z3uZGxy4rMovU+dbptdqtWPZQePCgbpcIByr1IeM6Swp0FQiOgOGYm/vJK6WJ9YkC+kjmDc8YnzGM62efSpFEZ54XFiLTf8KCYFDqCp9prsZkIozAMx8hAJexw9++Wsokjups8zBFd75LfNPDjh8+PZjs43gz4Ok4epTxSS7wes+PSYiAq6mjtm4+Sx9zwoHPjUdyxRHJgm7KhnbRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2wq04/pq3y+AwXmUtfVRB1zIz884N+3DnpVGLfLVWw=;
 b=Uow0xS5LEKk6/gm721SkDYveFyvw20aysaG3SL6EjGh2ITB9T5JKjge+c+/R+U+qzduNv5AeFhQfLvV/QtkB8Vp8T57rgh3Pn8L4EIbf8YJu/o+O1upji/SrD3sURv6FRNx7jcbmU1a3To1IMjp/F+PGEu2JqYnU99yY98Brxzc=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB3319.namprd10.prod.outlook.com (2603:10b6:a03:150::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Fri, 10 Dec
 2021 08:26:27 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4755.025; Fri, 10 Dec 2021
 08:26:27 +0000
Message-ID: <372503e7-8272-4f37-358d-5a3948fe7786@oracle.com>
Date: Fri, 10 Dec 2021 00:26:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v1 2/7] vdpa/mlx5: Distribute RX virtqueues in RQT object
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>
References: <20211208201430.73720-1-elic@nvidia.com>
 <20211208201430.73720-3-elic@nvidia.com>
 <1ab6faaf-08fd-2a3e-8214-12e2049b9607@oracle.com>
 <20211209065504.GB108239@mtl-vdi-166.wap.labs.mlnx>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211209065504.GB108239@mtl-vdi-166.wap.labs.mlnx>
X-ClientProxiedBy: SJ0PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::16) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
Received: from [10.159.153.254] (138.3.200.62) by
 SJ0PR13CA0071.namprd13.prod.outlook.com (2603:10b6:a03:2c4::16) with
 Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Fri, 10 Dec 2021 08:26:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdf2a881-aea3-494e-bf33-08d9bbb6c29b
X-MS-TrafficTypeDiagnostic: BYAPR10MB3319:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3319CDDB47A1C1C42D89E478B1719@BYAPR10MB3319.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gw9ZS2xwcyOFrudgK5c93HQtyrqF82spU5wvqgLSLGZgkSzx7lZ8/+ZhF86qAcmR7aZ8ZIv7UukVHkpe09I9JTuQXCBG/JlLklW5mzppd3ffy2zniQFv08wRYEedOqUPIB452ltEgVT/eY+BL2uYQPSXa3lYJr52R+58oSOyzGSYJluC1oYD5ZcCz0t8x8YciUfP2qrIOBFTAVS3eTzXI8Akr10sYh9GfnhlD9kkudMIJ63zIwpun4wR1/INERFSbuq4psuvoM8Q3yrecWnBV4HxWIsiK0NrjqaJQn1HWd4j/yob6q9TwFjPz/St80Sil8C+CUK1Oqifd+5WbHWA6GmFXp/yxJKAOVXVNrpYOMx3aKa3pJyVarLuODcrQ5ZoUDgWwk+2v5SVVtSqTTWS1dTc/X88IaDHsCORwDLeOvTlZVRaA1MfGNmFvpdZtVwXgf+BkTCdD0Dow2RDJRAUF+oMJayF2btYRg167mKMOdrvU7OZUPnC5jDFCjxsuymjFfhTuOnLcMORu9QwygHQWvtEtz0eSGegqN9dR+UsJ+7IXH+F2XFWxKeuE5XRMG1krMHRkaZQaeC6hmdusAXvifajPL0wmid7P3roffmcRRtzHJggY8akDwqVaCEQzl2+jGYYRWMbFIOqxFWNyBK+26Nt1vjdaDL4M4GYtm/gxXHO3ksWcWsbDpOClcqCInPWXJhIhtg4aFW8vAfMZpUKIOwWcciOw12AP02pvrJi0cY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(31696002)(66946007)(36916002)(4326008)(66476007)(83380400001)(66556008)(86362001)(31686004)(186003)(2906002)(956004)(2616005)(316002)(36756003)(8936002)(8676002)(26005)(508600001)(6666004)(6486002)(16576012)(53546011)(5660300002)(38100700002)(6916009)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWM1STZHUGFSVHBBaHgzTDVMZ2dXTk9rUlBCZE1aTjFpajIyZzF6RFVlY1o3?=
 =?utf-8?B?dDZpTkFpZUpIb0dmTkYxLzNSTENIMGhQS1Z2cUZHNmZhOEJuMjBWMnB0aTl5?=
 =?utf-8?B?Znl2QmtMaG1IQzA5NTVkeXM4RnZrVGRoY0lHMlp4OVp6V2RBcmZyWDZGMzZs?=
 =?utf-8?B?M0F0TWsySkQyaTkxYjBzeitIRzJOTWNVdjI4NFRFVXBveHVYMG1uZkMzTjVy?=
 =?utf-8?B?RWI1cnNSSDJQVEJVUWYweFQ4UnlyaW9XenZSMjRLKzFTZ2ZJaDV3NVVlYmFG?=
 =?utf-8?B?bERHRUdGZ3FTdWhDWnIvNzg1OHdYT3pkeDFtaXdZeGxrL0VvZ3ZnbVNmU3Zw?=
 =?utf-8?B?NVp6b1daRlVZYlllclpXQjJnazBXc0hrUzV3M0M3M05Id1o0RHFLR1lQZjMy?=
 =?utf-8?B?RFNCdi9QcVZvVlg4Z2Q3ZW1LZ3FCNytnNjlXYTl0dWgyN0Fzb3g0OGlJYndm?=
 =?utf-8?B?MTRyZ0RIU0tUR3hUaDNNTzRCeXJPY1A5N25SUkJzdDRxanN2SXVTUW5PaC85?=
 =?utf-8?B?YjNjaFR2YzkvV290RThaNkN0M24yWklzTHJkK0l2L0k2UmlqRXVMV1JVdjJh?=
 =?utf-8?B?aU5MT0haVWlzaDA0cytTNExRSFZFeWVLb1l6eEk2NWtKVXpzc0wxYkhJbm5j?=
 =?utf-8?B?VkQ2bjN4SXcvYVZubWtyMkhuTmJFZkZnN1hRc3puQmJ0V1dVZmxEOVdjRXlq?=
 =?utf-8?B?eXl5RGNNZWdpTVQ5RVByVVhkV09tSXNEUTZhTzFCVmxsYk03ZEtOYkNDNndU?=
 =?utf-8?B?R1h5NUdMQWdZZG01WVIveHZ3WWcyaDlzTmNyV1hVMnY3aGNtazYvWTlaVFNI?=
 =?utf-8?B?cDMzbDY2M0FXQVBnSWg3RHNDekI0UGZrbExnVnNPdE1JSlhwM2hXeGIrakti?=
 =?utf-8?B?bnBKWE9uRmJFdFMvaEFYNEtmTWdRaGZGSU96ek1VNXVzZUJsTGxFYWxsY0Q2?=
 =?utf-8?B?Rnl3NGdyMThsQ1pBYVBMSExYbUJGVUhSN3NUS0dRcmhxRzVKRW14bDZScTUz?=
 =?utf-8?B?K3BPLzRtMjJybklmeGY0Y3FpL3EzOXozWWlKOW8zeU5MYzY2MkwzYzhSeGxm?=
 =?utf-8?B?UkhNNW1ySnpUT3dIVlg1SEt2S3o0ZVVEbjZPY21WUGZKLzdJQVJLalVjTnpy?=
 =?utf-8?B?d1BaZmFvLzQvbjhxRVB0M1Zwckx6WUdRTHlIOGVNYk0xY1VXYUNxYmFBY01l?=
 =?utf-8?B?OFhxa3Nxa1pyQ242T1lERmxmckJDUUNSY0RPbGRqYm1KSGIyVFYzeWtNVXVJ?=
 =?utf-8?B?QXIyM0xUSDJZYytJVjhvWHVadytTcVVuaWMvd1cxcEJLQnUwVnlncG1zREZs?=
 =?utf-8?B?OUlJZUc0dFpYMnRJYU8ybDVrMkw2RDZNYmVtR2FtaTYrZWloVGxxaE9rd3M5?=
 =?utf-8?B?OXJQSFV0RGtweTF4Z20waTVDeXI3ekxzRFBxMXFsY0Q0NHgzTHNPbEkzZ2M1?=
 =?utf-8?B?M0xOeWdWSkVEV1REeHIyTmNwMTIvYlFSNWxHbU0rRldsNUdKSU5UTWpDczJ0?=
 =?utf-8?B?REZwODhISDdCc2MxekdJbDFRMnYwMG9sVkJqbW8yUVcxLzEzbEZTbnc5cXBz?=
 =?utf-8?B?S0QxbzRoa3Jnd2RhRUkva3JubExKNmdSbWtxSTN4WXhjZ20zQy9qWitDc3Uw?=
 =?utf-8?B?dGMyVjJkbXNUSmk5cHdNZjRMbXRYbDl4YTF2bno5aDdXSVo3RlhSSFpEV0w0?=
 =?utf-8?B?VDhVRW1KRmthTno3NWxNWERUQWN5R1p0ZE5QenpZOEhxdGFZemlIVTJKQU0v?=
 =?utf-8?B?SXpsMnp1T3hhWDdNM3lyQUprSDZwRHhYYVMyUGJUbDZRUk05RUt6V0J4RXZY?=
 =?utf-8?B?bFhlUjJxbC9xY2RjNWRGSzNHa3VPRVh2UFhHdlEwc3hLNmdKbUIwWUVDampE?=
 =?utf-8?B?dVVoVVlzMzNzdjBMQTZQWmNSNGxHZktwWXVIVU9SblhjaHRtWFJweFBUSHA5?=
 =?utf-8?B?dW5hWjhEUDZZSTRreUVSV0Qxb1NOZWdVeVFmVWd2ZU1jY1htTElTRS9EbHlE?=
 =?utf-8?B?Y2NMZkE2YlpNdklpRmJMa1lSTnB4aS84ZXFFSW9tcEw0TWFpWEZORzNhUS9j?=
 =?utf-8?B?ZTNDRWU0M3ZHaUZUYWkxSGVXRElvVi80UVRFSFRUZldkWVRORkF4czQ4VkZV?=
 =?utf-8?B?cHdUSkpnaDNreU03d01PcXlnQnVmV1k5dSthelA3WnJndDBSL0w0RUVaNkkv?=
 =?utf-8?Q?vtIx5GciLzsRpv4ZUVUtiQQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf2a881-aea3-494e-bf33-08d9bbb6c29b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 08:26:27.4783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVCRiaEwuLVVSGhVNI+kVO+j/fW9oFHBy4qtRXO4krfyz2uPi+J+Dyjrp8fThKgoEE1+F6QbHN878VACY6NAwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3319
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10193
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112100046
X-Proofpoint-ORIG-GUID: VwwNsZbsuJ9kiOQ7cRhoUM6AFy8yzjpb
X-Proofpoint-GUID: VwwNsZbsuJ9kiOQ7cRhoUM6AFy8yzjpb
Cc: lvivier@redhat.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 12/8/2021 10:55 PM, Eli Cohen wrote:
> On Wed, Dec 08, 2021 at 04:12:33PM -0800, Si-Wei Liu wrote:
>>
>> On 12/8/2021 12:14 PM, Eli Cohen wrote:
>>> Distribute the available rx virtqueues amongst the available RQT
>>> entries.
>>>
>>> RQTs require to have a power of two entries. When creating or modifying
>>> the RQT, use the lowest number of power of two entries that is not less
>>> than the number of rx virtqueues. Distribute them in the available
>>> entries such that some virtqueus may be referenced twice.
>>>
>>> This allows to configure any number of virtqueue pairs when multiqueue
>>> is used.
>>>
>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>> ---
>>>    drivers/vdpa/mlx5/net/mlx5_vnet.c | 30 +++++++-----------------------
>>>    1 file changed, 7 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> index ce2e13135dd8..e1a8a790f213 100644
>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> @@ -1261,17 +1261,10 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>>>    	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
>>>    	MLX5_SET(rqtc, rqtc, rqt_max_size, max_rqt);
>>>    	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
>>> -	for (i = 0, j = 0; j < max_rqt; j++) {
>>> -		if (!ndev->vqs[j].initialized)
>>> -			continue;
>> Why the !initialized check is dropped from the new code?
> We now access the vqs array with j % ndev->mvdev.max_vqs and that keeps
> us in the range of valid indices.
OK. I thought the previous check was more for defensive coding and it 
doesn't bother if keeping it. Anyway,

Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>

>
>>> -
>>> -		if (!vq_is_tx(ndev->vqs[j].index)) {
>>> -			list[i] = cpu_to_be32(ndev->vqs[j].virtq_id);
>>> -			i++;
>>> -		}
>>> -	}
>>> -	MLX5_SET(rqtc, rqtc, rqt_actual_size, i);
>>> +	for (i = 0, j = 0; i < max_rqt; i++, j += 2)
>>> +		list[i] = cpu_to_be32(ndev->vqs[j % ndev->mvdev.max_vqs].virtq_id);
>>> +	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
>>>    	err = mlx5_vdpa_create_rqt(&ndev->mvdev, in, inlen, &ndev->res.rqtn);
>>>    	kfree(in);
>>>    	if (err)
>>> @@ -1292,7 +1285,7 @@ static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
>>>    	int i, j;
>>>    	int err;
>>> -	max_rqt = min_t(int, ndev->cur_num_vqs / 2,
>>> +	max_rqt = min_t(int, roundup_pow_of_two(ndev->cur_num_vqs / 2),
>>>    			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
>>>    	if (max_rqt < 1)
>>>    		return -EOPNOTSUPP;
>>> @@ -1308,16 +1301,10 @@ static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
>>>    	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
>>>    	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
>>> -	for (i = 0, j = 0; j < num; j++) {
>>> -		if (!ndev->vqs[j].initialized)
>>> -			continue;
>> Ditto.
> Same as above.
>
>> -Siwei
>>
>>> +	for (i = 0, j = 0; i < max_rqt; i++, j += 2)
>>> +		list[i] = cpu_to_be32(ndev->vqs[j % num].virtq_id);
>>> -		if (!vq_is_tx(ndev->vqs[j].index)) {
>>> -			list[i] = cpu_to_be32(ndev->vqs[j].virtq_id);
>>> -			i++;
>>> -		}
>>> -	}
>>> -	MLX5_SET(rqtc, rqtc, rqt_actual_size, i);
>>> +	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
>>>    	err = mlx5_vdpa_modify_rqt(&ndev->mvdev, in, inlen, ndev->res.rqtn);
>>>    	kfree(in);
>>>    	if (err)
>>> @@ -1581,9 +1568,6 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
>>>    			break;
>>>    		}
>>> -		if (newqps & (newqps - 1))
>>> -			break;
>>> -
>>>    		if (!change_num_qps(mvdev, newqps))
>>>    			status = VIRTIO_NET_OK;

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
