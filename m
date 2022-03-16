Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F2AC433EF
	for <virtualization@archiver.kernel.org>; Wed, 16 Mar 2022 06:52:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46A0660EF8;
	Wed, 16 Mar 2022 06:52:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kzp5a0Ef0iTT; Wed, 16 Mar 2022 06:52:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2B45060EFF;
	Wed, 16 Mar 2022 06:52:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1E78C001A;
	Wed, 16 Mar 2022 06:52:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F7C9C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 06:52:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B37340424
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 06:52:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="snjBEjzL";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="sS9MaiCa"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GX87gsxEeQjM
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 06:52:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B19C040138
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 06:52:26 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22G2foEj018452; 
 Wed, 16 Mar 2022 06:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MkzlgloOmV0eAcyKuk2wKR7wZqwG68astiYPZtELwIc=;
 b=snjBEjzLAyyArLUe7hmCEgtKfEMWXXtPL3jIpUcyyg3iv0g9jTVAcTgWsJhfveHMZHDX
 Qeus1v15CZKBsGgM1jt8OpPmoUfTbE81T1mhmug7+BKid0bhGFgvmgTchiFkGcjR42Lk
 w6L1VEqxZqi5dix+UQJiGqv/7AaFi1oeeDktid0k07y/2Kc3FMOjwgtvrX8iDEkgKjqA
 QV+SfqJ5Y6c8eohmz/xUTbvt40Q3qnUJyQJ59BN6Aik5efFSPClRZ+7GuW0wVT1bNLrX
 Gf+McJcHZY2ghfcVadyhwpUBje3H0hnn1LYlq2UfkB8YchLfSsoEA+kdGid/FU6rRG46 9w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwn1tm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Mar 2022 06:52:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22G6W1VF111947;
 Wed, 16 Mar 2022 06:52:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
 by aserp3020.oracle.com with ESMTP id 3et64kg57r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Mar 2022 06:52:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3jOnE1v69Za5BT5ONx57C9XDkWPkyVMrT8Y3tVr6T/XBuF2VvnUYCftB5U0fUD8QReMdDlzkY0AdH/O58aYfzf6k2fSV0gstKAK7t3wfHm8dgj/fsGp497fbaJQZnm1AlXxFFYJiTv6OMT0Bkdmd/lGZfXpCiOTOThDmKc+/GC+YyfdvxFCHLenDn/DPi47mSKQTw24leYL+L+Px7Ip3KoKEEuamk1csdRV6FAewdtZEvJpCfCGkjuNLZXdwyi58Z1jW/fDcw9PmHGt+tfgp/ppXM6BvR68LJx8YIegXMGqhfcEHl4kmRWgCg7i0uXP8VO6W9wBK0QE32RHKBPAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkzlgloOmV0eAcyKuk2wKR7wZqwG68astiYPZtELwIc=;
 b=aVRUYC0ODBCnCdafTjF4r75qRMAUrRq68I4UPLshxmuIlelZTFseo//53VdEgFd2dIED59rfzo+8dOzelvvw/I2S48Vfuul5cwncvaotxs0Y+Dnua0lOSPqWafN4JOsSbvjBD8hTrk/LFztRoRGtMtDPP56SjLSIfNDP+hcrzdHZKTgODUIFps8cp8932nCwwUAGt8i3HIhAxyBSIqc9I3SBTqcfPjjkY726VojJ9cQKogtPbwAxGpgExpvN+4Sil0Lq6W5zsUV+LVZF41W9BflCLAdsgMzZAnRmn1sEJ+sgo/4BG1OyBfNVFMjiztHanVP90tAs/u0L5QdmbWJVdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkzlgloOmV0eAcyKuk2wKR7wZqwG68astiYPZtELwIc=;
 b=sS9MaiCaXL3tvkSWrgIq1LDu++9bf9bqPJxUjjdYrthJ/bNHJ93ssrBs/dcdbRYrxV0H1w5eXgZg3QamFNihJGqcc6ZpAuWxEJYW+hMVWE67tkEL4aWV0xLW+jrqErKmdzl/+3K72LPPgwQQrR7T6wr9LFD8lVEhGBsCd9xxtFw=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by CY4PR10MB1895.namprd10.prod.outlook.com (2603:10b6:903:123::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Wed, 16 Mar
 2022 06:52:21 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::e478:4b5e:50a8:7f96]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::e478:4b5e:50a8:7f96%6]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 06:52:21 +0000
Message-ID: <53dd5c21-5045-bb66-05fe-1a1157f7abe8@oracle.com>
Date: Tue, 15 Mar 2022 23:52:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v1 1/2] vdpa: Add support for querying vendor statistics
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>
References: <20220216080022.56707-1-elic@nvidia.com>
 <20220216080022.56707-2-elic@nvidia.com>
 <22f77b5c-2003-c963-24c9-fce9cb53160d@oracle.com>
 <20220217064619.GB86497@mtl-vdi-166.wap.labs.mlnx>
 <8e834c04-47d2-1286-117d-28caa3e84606@oracle.com>
 <DM8PR12MB5400E80073521E898056578BAB089@DM8PR12MB5400.namprd12.prod.outlook.com>
 <6175d620-6be3-c249-5482-0a9448499e4a@oracle.com>
 <DM8PR12MB5400E03D7AD7833CEBF8DF9DAB099@DM8PR12MB5400.namprd12.prod.outlook.com>
 <74495f15-8f1c-93db-1277-50198ac3284e@oracle.com>
 <DM8PR12MB540086CCD1F535668D05E546AB0A9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <a30ac3c0-059d-4588-c5ac-599c060f6bbf@oracle.com>
 <DM8PR12MB54000042A48FDFA446EFE792AB0E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <61748d91-153c-ec79-c1f0-e3c44cdbea5d@oracle.com>
 <DM8PR12MB540054565515158F9209723EAB109@DM8PR12MB5400.namprd12.prod.outlook.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <DM8PR12MB540054565515158F9209723EAB109@DM8PR12MB5400.namprd12.prod.outlook.com>
X-ClientProxiedBy: BYAPR08CA0046.namprd08.prod.outlook.com
 (2603:10b6:a03:117::23) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dbcaa14-8e3e-4599-b01c-08da071984c9
X-MS-TrafficTypeDiagnostic: CY4PR10MB1895:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB18950AC5E7C5B1A122735668B1119@CY4PR10MB1895.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7AsHOuziXzkYlKSfacaFRZ+WR6DuA2KNwiymvAy6OahtQyfUtVnui5Fek8iIfd4tJ7XW198BxJGx8itt0ZKLkO0pTCNUW2IuH3VJ4kxBEWldX5tEzqf/dHWodbjYDemxfhG7B/ZnKkqtDPKBvkKa5hRmjmwOW1Dc1cHYkaX4Aci38VHHGsa3jtFxdsQkLEzGXmJiMPLF6DJJNkAcCvzcKJcEWCXLrTZlP8verXUYfT3NA9ueYo4/pYkzUJxL3I2YzFuJ+8PqYOGG4HCqFkxhdbmL5ddA5M8eyDYFgppdrj/8xhLPcXypKINFRQgTpLOKUCNOI/N4clJMPGpfcmUyqtJGUtYAvIEuVaBC9YSitsYWzCvnhpb7V23doSiBBx2y7eevcsQEKYCCAVhwXBgu7c9V8FaciElz+Ae3ICXjPl6oJRUVmGQC37WzklKJiwpr9KbxMAVYxpEaQHoOcpmhBX+X8wKxFRZwHlzJ4pxM/BiYnket1cPuHxoAipjAobIxhKQ/uXsAB3DRUFrP8ldD/UVfy2IKHdMaHMEq2c1wCqoHwzerigt0tt0f4eZ82R3P7f/sfnQ1DC+FxCBbRmePvc5IZrtwh/tPw/XegZcQiMQ43Tx5kMlvlVK84tdrMOv1IHRLDELKVRgJZs2CbMH6hNb6MaC96/2JHzCU0aMz7zRgJNlUg3dFgo03nLgukdsPA/3YdRxEidTtdwa0x9qqWbQo5nE6fbeCn9mQPdeUhzvrRwViD4w3i9fmjDmZgVRc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(6486002)(6666004)(508600001)(38100700002)(86362001)(66476007)(66556008)(66946007)(31696002)(316002)(8676002)(6916009)(26005)(186003)(54906003)(4326008)(2616005)(6512007)(36916002)(6506007)(53546011)(83380400001)(30864003)(31686004)(2906002)(36756003)(8936002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGVuQk1iK3lEZzNsSmc5Szg5QW5ETnZ0QkdUTVBybTRuT01TY3JWUlRuVWVE?=
 =?utf-8?B?QUNEUnM4UlJQZTNiL1FpKzJUWktJMXpGU3owY2gyZlBSSTVjQTFZY2JtWVVQ?=
 =?utf-8?B?cWFtaTdZSlArenVVT25UOTNWWXRKNjRxdTYvUE1HTXZCekhrOGIraERSa0Nn?=
 =?utf-8?B?LzBLRXFoTlREN3lyYi9IYk5HTjRtM1RNMFgzSTVjaHIzSktLTElKUHE3dUsr?=
 =?utf-8?B?Z2wzb3dTZlgwVlVaSVNTSEZiQ2ZNWks5NkZ5N3ZvRE5pcm4zcEZ3aEg4WUM1?=
 =?utf-8?B?QlRHVnhOdGNoUUhUVnVPWXV5ZSs1SW5zYU83Tm1lOW91bXByMWRCeDVML1hh?=
 =?utf-8?B?UzlObHdpNXhkempXRnhsR1FpSjhjSFR2RStvNFdKWWo5NFcrMlZhUjA1THZT?=
 =?utf-8?B?T01jL1doNGpQaU5jblZrR3VHSmRJR1FmTFJGM2lBeGwvdTdMOHBreVhrQVVQ?=
 =?utf-8?B?TXRwdWJrSGQvSVl6SVd1T1lZSndBYmNhRFJxQURSM0xvcXl5QkVWanRCa3pK?=
 =?utf-8?B?R04vVm9lcUtkUE9tcG5VRHA2MVhBZkdTUWp6THFNcVBsTDVsQVc3LzRHM3pU?=
 =?utf-8?B?bmx4a0dKZWxlbXdQd2U1cFo2YkxuQzhxby9naFZTZGhvbjBaTFV5MTluUTBR?=
 =?utf-8?B?cDFIcy9BMWY3eVhJTjM1bEhjZUJRdFQ4d0R0SGsxRE9KZkRCMTMzSVNvZEhD?=
 =?utf-8?B?MG80NEJsQlM0aFArVTFyUVVCSlVBLzQxSURVUVBYL21vTnRGWlY1aDBUK2xr?=
 =?utf-8?B?M25FYnlOOUhNdXVyYWltcWN1aVJVbENyN0g5cEE3YmdudGdrZkdoZG5naTNq?=
 =?utf-8?B?TUllVEZRaU1EMTNFenFnV1hRNTRWL0NPQzBLTTJWOS9ubWZlR0tuK0ZVajhY?=
 =?utf-8?B?Z01MM0Q3L3JmUURkUEwvU3NMM05ZWTJCSzJ1d1JRcittSDQwd0NJVm01TGUx?=
 =?utf-8?B?T0tJOUpjL2VOeUo1anlEaG56ZzlsaHcyUE1FZFFqS2xqQ1E0WFpNQXNjcGVB?=
 =?utf-8?B?aUV3S2YrMk5wMTUrSkIvTU0vNGdEQjdsZkx2VHpoTXhlQVc3cE9TZ2ltZVlI?=
 =?utf-8?B?RFZzV3c5M0d5TW93NlR2dGJDUEsxR3orZTZWelNXNzVkUnRmQ1RiZ1hHWEFZ?=
 =?utf-8?B?REh5c1l4MmN3N1hqQUtHS1hzN3dTelBOR3VsMHNYYTN4TDV4NFBYb2cxUkNk?=
 =?utf-8?B?NVRXWkh3Sm1EVHhIbGRETjgzK1FlQnRjTVppRnE5bjhYcHlYMHZBRnd3aGNn?=
 =?utf-8?B?Qlhrd3QwMyt5RFR2dHNFN3lpcEpabFo2M0haZGxZeEtMWnBDT0kwUVd3c3VI?=
 =?utf-8?B?cloyZFhSYUdDU3Z4YXo3bWNzVmlPRjBCR1NubHdRd1pURzE2Nk1QamFsTHcz?=
 =?utf-8?B?eHdzdllBR0M4aWZJbWIzN2ZBWWplTk14NXNPSndyalMvanVOTW9iN0pCVW5r?=
 =?utf-8?B?c0tQZ1cwUHBjNXVkaXJ3amZmSGE3NVE1YXBuaDhGdkVmd2Q0SVlKZ2pkRHN4?=
 =?utf-8?B?S2tXRVF6ZXBCQlZId0pVazkzL3ZrRVAyemlZcEtUWUFuQW13ZVNpK29JTFd5?=
 =?utf-8?B?QmpoUjBwSjh2Mno2RmhsNlZlQ1AyK3VRTmJ5WS9rSVpac3pQZEtIL0tMSjEx?=
 =?utf-8?B?VW9RSHMvMjZHVHExRmtQa0U4aHRmSUp4MGxqQ1hQNVlBM2JFd3cza0diV2tX?=
 =?utf-8?B?Vk95cjcxNDBiMEd4OXZ3Q2ZSNTZQNmJOTmtldkRrczFNWG5tZGEvOW05VW4z?=
 =?utf-8?B?dXdpMUlnOXUvTVlVaU1ZVEZtYVl5MnZ5eXhJN2ZYTlB1c2JBNnhKYzVPT2M5?=
 =?utf-8?B?MGRqODZEbU5YREFhSU1IbDhJRVUvWjdvZ0U2RjZYTEUvOFoyS3EvL1Ixa3B6?=
 =?utf-8?B?TXljYjV3elpIQ1ZJSTdiNWg1dnB2U1ZWWTNvSHBpZk1Wa2VOZ0o1cE1qcXdF?=
 =?utf-8?B?WTlnQzZiOTRrK25jaXhwMHBXM2p5MWJnQVRoZFM2UVB0UGxva3R6OWdIMDVK?=
 =?utf-8?B?VEhrLzdHZVd3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbcaa14-8e3e-4599-b01c-08da071984c9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 06:52:21.4420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1lNiS+6n4fxTuuqsZp7VbARPKVLMXv5AymvRxzhXNb84Si8/2X05q/91g+9dqFJ74IFqNXLBfpOi3MGLe5OjXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1895
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287
 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160041
X-Proofpoint-GUID: i2f1MoNpDyATIEA4IAdHgRRpIOYxFZFt
X-Proofpoint-ORIG-GUID: i2f1MoNpDyATIEA4IAdHgRRpIOYxFZFt
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>
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

CgpPbiAzLzE1LzIwMjIgMjoxMCBBTSwgRWxpIENvaGVuIHdyb3RlOgoKPC4uLnNuaXAuLi4+Cgo+
PiBTYXkgeW91IGdvdCBhIHZkcGEgbmV0IGRldmljZSBjcmVhdGVkIHdpdGggNCBkYXRhIHF1ZXVl
IHBhaXJzIGFuZCBhCj4+IGNvbnRyb2wgdnEuIE9uIGJvb3Qgc29tZSBndWVzdCBmaXJtd2FyZSBt
YXkgc3VwcG9ydCBqdXN0IEZfQ1RSTF9WUSBidXQKPj4gbm90IEZfTVEsIHRoZW4gdGhlIGluZGV4
IGZvciB0aGUgY29udHJvbCB2cSBpbiBndWVzdCBlbmRzIHVwIHdpdGggMiwgYXMKPj4gaW4gdGhp
cyBjYXNlIHRoZXJlJ3Mgb25seSBhIHNpbmdsZSBxdWV1ZSBwYWlyIGVuYWJsZWQgZm9yIHJ4IChp
bmRleCAwKQo+PiBhbmQgdHggKGluZGV4IDEpLiBGcm9tIHRoZSBob3N0IGRyaXZlciAoZS5nLiBt
bHg1X3ZkcGEpIHBlcnNwZWN0aXZlLCB0aGUKPj4gY29udHJvbCB2cSBpcyB0aGUgbGFzdCB2cSBm
b2xsb3dpbmcgOAo+IElmIHRoZSBob3N0IHNlZXMgRl9NUSB3YXMgbm90IG5lZ290aWF0ZWQgYnV0
IEZfQ1RSTF9WUSB3YXMsIHRoZW4gaXQga25vd3MKPiB0aGF0IGNvbnRyb2wgVlEgaW5kZXggaXMg
MgpSaWdodCwgYnV0IEkgZG9uJ3Qgc2VlIHRoaXMgZmVhdHVyZSBuZWdvdGlhdGlvbiBpbmZvIGdl
dHRpbmcgcmV0dXJuZWQgCmZyb20geW91ciB2ZHBhX2Rldl92ZW5kb3Jfc3RhdHNfZmlsbCgpLCBv
ciBkaWQgSSBtaXNzIHNvbWV0aGluZz8gSG93IGRvIAp5b3UgcGxhbiBmb3IgaG9zdCB1c2VyIHRv
IGdldCB0aGlzIGluZm8/IElmIHlvdSBtZWFudCBhbm90aGVyICJ2ZHBhIGRldiAKc2hvdyIgY29t
bWFuZCB0byBxdWVyeSBuZWdvdGlhdGVkIGZlYXR1cmVzIGFoZWFkLCB0aGlzIHdvbid0IGdldCB0
aGUgCnNhbWUgbG9jayBwcm90ZWN0ZWQgYXMgdGhlIHRpbWUgeW91IHJ1biB0aGUgc3RhdCBxdWVy
eS4gSXQncyB2ZXJ5IGVhc3kgCnRvIG1pc3MgdGhhdCBlcGhlbWVyYWwgcXVldWUgaW5kZXguCgo+
PiBkYXRhIHZxcyBvZiBhbGwgNCBwYWlycywgaGVuY2UgZ290Cj4+IHRoZSA4dGggaW5kZXggaW4g
dGhlIHJhbmsuIFNpbmNlIEZfTVEgaXMgbm90IG5lZ290aWF0ZWQgYW5kIG9ubHkgMSBkYXRhCj4+
IHF1ZXVlIHBhaXIgZW5hYmxlZCwgaW4gc3VjaCBldmVudCBvbmx5IGhvc3QgcWluZGV4IDAsMSBh
bmQgOCBoYXZlIHZlbmRvcgo+PiBzdGF0cyBhdmFpbGFibGUsIGFuZCB0aGUgcmVzdCBvZiBxaW5k
ZXggd291bGQgZ2V0IGludmFsaWQvZW1wdHkgc3RhdC4KPj4KPj4gTGF0ZXIgb24gc2F5IGJvb3Qg
Y29udGludWVzIHRvd2FyZHMgbG9hZGluZyB0aGUgTGludXggdmlydGlvIGRyaXZlciwKPj4gdGhl
biBndWVzdCBjb3VsZCBzdWNjZXNzZnVsbHkgbmVnb3RpYXRlIGJvdGggRl9DVFJMX1ZRIGFuZCBG
X01RCj4+IGZlYXR1cmVzLiBJbiB0aGlzIGNhc2UsIGFsbCA4IGRhdGEgdmlydHF1ZXVlcyBhcmUg
ZnVsbHkgZW5hYmxlZCwgdGhlCj4+IGluZGV4IGZvciB0aGUgY29udHJvbCB2cSBlbmRzIHVwIGFz
IDgsIGZvbGxvd2luZyB0aWdodGx5IGFmdGVyIGFsbCB0aGUgNAo+PiBkYXRhIHF1ZXVlIHBhaXJz
LiBPbmx5IHVudGlsIGJvdGggZmVhdHVyZXMgYXJlIG5lZ290aWF0ZWQsIHRoZSBndWVzdCBhbmQK
Pj4gaG9zdCBhcmUgYWJsZSB0byBzZWUgY29uc2lzdGVudCB2aWV3IGluIGlkZW50aWZ5aW5nIHRo
ZSBjb250cm9sIHZxLgo+PiBTaW5jZSBGX01RIGlzIG5lZ290aWF0ZWQsIGFsbCBob3N0IHF1ZXVl
cywgaW5kZXhlZCBmcm9tIDAgdGhyb3VnaCA4LAo+PiBzaG91bGQgaGF2ZSB2ZW5kb3Igc3RhdHMg
YXZhaWxhYmxlLgo+Pgo+PiBUaGF0J3Mgd2h5IEkgc2FpZCB0aGUgZ3Vlc3QgcWluZGV4IGlzIGVw
aGVtZXJhbCBhbmQgaGFyZCB0byBwcmVkaWN0Cj4+IHN1YmplY3RlZCB0byBuZWdvdGlhdGVkIGZl
YXR1cmVzLCBidXQgaG9zdCBxaW5kZXggaXMgcmVsaWFibGUgYW5kIG1vcmUKPj4gZWxpZ2libGUg
Zm9yIGNvbW1hbmQgbGluZSBpZGVudGlmaWNhdGlvbiBwdXJwb3NlLgo+Pgo8Li4uc25pcC4uLj4K
Pj4+IFNvIHdoYXQgYXJlIHlvdSBhY3R1YWxseSBwcm9wb3Npbmc/IERpc3BsYXkgcmVjZWl2ZWQg
YW5kIGNvbXBsZXRlZCBkZXNjcmlwdG9ycwo+Pj4gcGVyIHF1ZXVlIGluZGV4IHdpdGhvdXQgZnVy
dGhlciBpbnRlcnByZXRhdGlvbj8KPj4gSSdkIHN1Z2dlc3QgdXNpbmcgYSBtb3JlIHN0YWJsZSBx
dWV1ZSBpZCBpLmUuIHRoZSBob3N0IHF1ZXVlIGluZGV4IHRvCj4+IHJlcHJlc2VudCB0aGUgcWlk
eCAod2hpY2ggc2VlbXMgdG8gYmUgd2hhdCB5b3UncmUgZG9pbmcgbm93PyksIGFuZAo+PiBkaXNw
bGF5aW5nIGJvdGggdGhlIGhvc3QgcWluZGV4IChxdWV1ZV9pbmRleF9kZXZpY2UgaW4gdGhlIGV4
YW1wbGUKPj4gYmVsb3cpLCBhcyB3ZWxsIGFzIHRoZSBndWVzdCdzIChxdWV1ZV9pbmRleF9kcml2
ZXIgYXMgYmVsb3cpIGluIHRoZSBvdXRwdXQ6Cj4+Cj4gR2l2ZW4gdGhhdCBwZXIgdmRwYSBkZXZp
Y2UgeW91IGNhbiBkaXNwbGF5IHN0YXRpc3RpY3Mgb25seSBhZnRlciBmZWF0dXJlcyBoYXZlCj4g
YmVlbiBuZWdvdGlhdGVkLCB5b3UgY2FuIGFsd2F5cyBrbm93IHRoZSBjb3JyZWN0IHF1ZXVlIGlu
ZGV4IGZvciB0aGUgY29udHJvbAo+IFZRLgpUaGUgc3RhdHMgY2FuIGJlIGRpc3BsYXllZCBvbmx5
IGFmdGVyIGZlYXR1cmVzIGFyZSBuZWdvdGlhdGVkLCBhbmQgb25seSAKd2hlbiB0aGUgY29ycmVz
cG9uZGluZyBxdWV1ZSBpcyBlbmFibGVkLiBJZiB5b3Uga25vdyBpdCBmcm9tICJ2ZHBhIGRldiAK
c2hvdyIgb24gZGF5IDEgdGhhdCB0aGUgY29udHJvbCB2cSBhbmQgbXEgZmVhdHVyZXMgYXJlIG5l
Z290aWF0ZWQsIGJ1dCAKdGhlbiBvbiBkYXkyIHlvdSBnb3Qgbm90aGluZyBmb3IgdGhlIHByZWRp
Y3RlZCBjb250cm9sIHZxIGluZGV4LCB3aGF0IAp3b3VsZCB5b3UgcmVjb21tZW5kIHRoZSBob3N0
IGFkbWluIHRvIGRvIHRvIGdldCB0aGUgcmlnaHQgcWluZGV4IGFnYWluPyAKUmUtcnVuIHRoZSBz
dGF0IHF1ZXJ5IG9uIHRoZSBzYW1lIHF1ZXVlIGluZGV4LCBvciBjaGVjayB0aGUgInZkcGEgZGV2
IApzaG93IiBvdXRwdXQgYWdhaW4gb24gZGF5IDM/IFRoaXMgQ0xJIGRlc2lnbiBtYWtlcyBjbG91
ZCBhZG1pbmlzdHJhdG9yIApyZWFsbHkgY2hhbGxlbmdpbmcgdG8gZm9sbG93IHRoZSBkeW5hbWlj
cyBvZiBndWVzdCBhY3Rpdml0aWVzIHdlcmUgdG8gCm1hbmFnZSBodW5kcmVkcyBvciB0aG91c2Fu
ZHMgb2YgdmlydHVhbCBtYWNoaW5lcy4uLgoKSXQgd291bGQgYmUgZWFzaWVyLCBpbiBteSBvcGlu
aW9uLCB0byBncmFzcCBzb21lIHdlbGwtZGVmaW5lZCBoYW5kbGUgCnRoYXQgaXMgZWFzaWx5IHBy
ZWRpY3RhYmxlIG9yIGZpeGVkIGFjcm9zcyB0aGUgYm9hcmQsIGZvciBsb29raW5nIHVwIHRoZSAK
Y29udHJvbCB2aXJ0cXVldWUuIFRoaXMgY291bGQgYmUgYSBjb25zdGFudCBob3N0IHF1ZXVlIGlu
ZGV4LCBvciBhIApzcGVjaWFsIG1hZ2ljIGtleXdvcmQgbGlrZSAicWlkeCBjdHJsdnEiLiBJZiBj
bG91ZCBhZG1pbiBydW5zIHZzdGF0IApxdWVyeSBvbiB0aGUgY29udHJvbCB2cSB1c2luZyBhIGRl
dGVybWluZWQgaGFuZGxlIGJ1dCBnZXQgbm90aGluZyBiYWNrLCAKdGhlbiBzL2hlIGtub3dzICpm
b3Igc3VyZSogdGhlIGNvbnRyb2wgdnEgd2FzIG5vdCBhdmFpbGFibGUgZm9yIHNvbWUgCnJlYXNv
biBhdCB0aGUgcG9pbnQgd2hlbiB0aGUgc3RhdCB3YXMgYmVpbmcgY29sbGVjdGVkLiBTL2hlIGRv
ZXNuJ3QgZXZlbiAKbmVlZCB0byBjYXJlIG5lZ290aWF0ZWQgc3RhdHVzIHZpYSAidmRwYSBkZXYg
c2hvdyIgYXQgYWxsLiBXaHkgYm90aGVyPwoKPgo+IERvIHlvdSBzdGlsbCBob2xkIHNlZSB5b3Vy
IHByb3Bvc2FsIHJlcXVpcmVkPwpZZXMsIHRoaXMgaXMgZXNzZW50aWFsIHRvIGFueSBjbG91ZCBh
ZG1pbiB0aGF0IHJ1bnMgc3RhdCBxdWVyeSBvbiBhbGwgb2YgCnRoZSBxdWV1ZXMgb24gcGVyaW9k
aWMgYmFzaXMuIFlvdSdkIGdldCBzb21lIGRldGVybWluaXN0aWMgd2l0aG91dCAKYmxpbmRseSBn
dWVzc2luZyBvciBib3RoZXJpbmcgb3RoZXIgaXJyZWxldmFudCBjb21tYW5kLgoKClRoYW5rcywK
LVNpd2VpCj4KPj4gJCB2ZHBhIC1qcCBkZXYgdnN0YXRzIHNob3cgdmRwYS1hIHFpZHggOAo+PiB7
Cj4+ICAgwqDCoMKgICJ2c3RhdHMiOiB7Cj4+ICAgwqDCoMKgwqDCoMKgwqAgInZkcGEtYSI6IHsK
Pj4gICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJxdWV1ZV9zdGF0cyI6IFt7Cj4+ICAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJxdWV1ZV9pbmRleF9kZXZpY2UiOiA4LAo+PiAgIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAicXVldWVfaW5kZXhfZHJpdmVyIjogMiwKPj4g
ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInF1ZXVlX3R5cGUiOiAiY29udHJvbF92
cSIsCj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJzdGF0X25hbWUiOiBbICJy
ZWNlaXZlZF9kZXNjIiwiY29tcGxldGVkX2Rlc2MiIF0sCj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICJzdGF0X3ZhbHVlIjogWyA0MTc3NzYsNDE3Nzc1IF0sCj4+ICAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB9XQo+PiAgIMKgwqDCoMKgwqDCoMKgIH0KPj4gICDCoMKgwqAgfQo+
PiB9Cj4+Cj4+IE9wdGlvbmFsbHksIHVzZXIgbWF5IHVzZSBndWVzdCBxdWV1ZSBpbmRleCBncWlk
eCwgd2hpY2ggaXMga2luZCBvZiBhbgo+PiBlcGhlbWVyYWwgSUQgYW5kIEZfTVEgbmVnb3RpYXRp
b24gZGVwZW5kZWQsIHRvIHF1ZXJ5IHRoZSBzdGF0IG9uIGEKPj4gc3BlY2lmaWMgZ3Vlc3QgcXVl
dWU6Cj4+Cj4+ICQgdmRwYSAtanAgZGV2IHZzdGF0cyBzaG93IHZkcGEtYSBncWlkeCAyCj4+IHsK
Pj4gICDCoMKgwqAgInZzdGF0cyI6IHsKPj4gICDCoMKgwqDCoMKgwqDCoCAidmRwYS1hIjogewo+
PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInF1ZXVlX3N0YXRzIjogW3sKPj4gICDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInF1ZXVlX2luZGV4X2RldmljZSI6IDgsCj4+ICAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJxdWV1ZV9pbmRleF9kcml2ZXIiOiAyLAo+PiAg
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAicXVldWVfdHlwZSI6ICJjb250cm9sX3Zx
IiwKPj4gICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInN0YXRfbmFtZSI6IFsgInJl
Y2VpdmVkX2Rlc2MiLCJjb21wbGV0ZWRfZGVzYyIgXSwKPj4gICDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgInN0YXRfdmFsdWUiOiBbIDQxNzc3Niw0MTc3NzUgXSwKPj4gICDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIH1dCj4+ICAgwqDCoMKgwqDCoMKgwqAgfQo+PiAgIMKgwqDCoCB9Cj4+
IH0KPj4KPj4gVGhhbmtzLAo+PiAtU2l3ZWkKPj4KPj4+PiBUaGFua3MsCj4+Pj4gLVNpd2VpCj4+
Pj4KPj4+Pj4+IFJlZ2FyZHMsCj4+Pj4+PiAtU2l3ZWkKPj4+Pj4+Cj4+Pj4+Pj4+Pj4gTG9va3Mg
dG8gbWUgdGhlcmUgYXJlIHN0aWxsIHNvbWUgbG9vc2UgZW5kIEkgZG9uJ3QgcXVpdGUgeWV0Cj4+
Pj4+Pj4+Pj4gdW5kZXJzdGFuZC4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4g
ICAgICAgICAgICAgICAgICAgICJxdWV1ZV9pbmRleCI6IDAsCj4+Pj4+Pj4+PiBJIHRoaW5rIHRo
aXMgY2FuIGJlIHJlbW92ZWQgc2luY2UgdGhlIGNvbW1hbmQgaXMgZm9yIGEgc3BlY2lmaWMgaW5k
ZXguCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICAibmFtZSI6ICJy
ZWNlaXZlZF9kZXNjIiwKPj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgInZhbHVlIjog
NDE3Nzc2LAo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICAibmFtZSI6ICJjb21wbGV0
ZWRfZGVzYyIsCj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICJ2YWx1ZSI6IDQxNzU0
OAo+Pj4+Pj4+Pj4+Pj4gTm90IGZvciB0aGlzIGtlcm5lbCBwYXRjaCwgYnV0IElNSE8gaXQncyB0
aGUgYmVzdCB0byBwdXQgdGhlIG5hbWUKPj4+Pj4+Pj4+Pj4+ICYgdmFsdWUgcGFpcnMgaW4gYW4g
YXJyYXkgaW5zdGVhZCBvZiBmbGF0IGVudHJpZXMgaW4ganNvbidzCj4+Pj4+Pj4+Pj4+PiBoYXNo
L2RpY3Rpb25hcnkuIFRoZSBoYXNoIGVudHJpZXMgY2FuIGJlIHJlLW9yZGVyZWQgZGVsaWJlcmF0
ZWx5Cj4+Pj4+Pj4+Pj4+PiBieSBleHRlcm5hbCBqc29uIHBhcnNpbmcgdG9vbCwgZW5kaW5nIHVw
IHdpdGggaW5jb25zaXN0ZW50IHN0YXQgdmFsdWVzLgo+Pj4+Pj4+Pj4+IFRoaXMgY29tbWVudCBp
cyBtaXNzZWQgZm9yIHNvbWUgcmVhc29uLiBQbGVhc2UgY2hhbmdlIHRoZSBleGFtcGxlCj4+Pj4+
Pj4+Pj4gaW4gdGhlIGxvZyBpZiB5b3UgYWdyZWUgdG8gYWRkcmVzcyBpdCBpbiB2ZHBhIHRvb2wu
IE9yIGp1c3RpZnkgd2h5Cj4+Pj4+Pj4+Pj4ga2VlcGluZyB0aGUgb3JkZXIgZm9yIGpzb24gaGFz
aC9kaWN0aW9uYXJ5IGlzIGZpbmUuCj4+Pj4+Pj4+PiBTb3JyeSBmb3Igc2tpcHBpbmcgdGhpcyBj
b21tZW50Lgo+Pj4+Pj4+Pj4gRG8geW91IG1lYW4gdG8gcHJlc2VudCB0aGUgaW5mb3JtYXRpb24g
bGlrZToKPj4+Pj4+Pj4+ICJyZWNlaXZlZF9kZXNjIjogNDE3Nzc2LAo+Pj4+Pj4+Pj4gImNvbXBs
ZXRlZF9kZXNjIjogNDE3NTQ4LAo+Pj4+Pj4+PiBJIG1lYW4gdGhlIGZvbGxvd2luZyBwcmVzZW50
YXRpb246Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+ICQgdmRwYSAtanAgZGV2IHZzdGF0cyBzaG93IHZkcGEt
YSBxaWR4IDAgewo+Pj4+Pj4+PiAgICAgICAgICAidnN0YXRzIjogewo+Pj4+Pj4+PiAgICAgICAg
ICAgICAgInZkcGEtYSI6IHsKPj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAicXVldWVfc3RhdHMi
OiBbewo+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAicXVldWVfaW5kZXgiOiAwLAo+Pj4+
Pj4+PiAgICAgICAgICAgICAgICAgICAgICAicXVldWVfdHlwZSI6ICJyeCIsCj4+Pj4+Pj4+ICAg
ICAgICAgICAgICAgICAgICAgICJzdGF0X25hbWUiOiBbICJyZWNlaXZlZF9kZXNjIiwiY29tcGxl
dGVkX2Rlc2MiIF0sCj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICJzdGF0X3ZhbHVlIjog
WyA0MTc3NzYsNDE3NTQ4IF0sCj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgfV0KPj4+Pj4+Pj4g
ICAgICAgICAgICAgIH0KPj4+Pj4+Pj4gICAgICAgICAgfQo+Pj4+Pj4+PiB9Cj4+Pj4+Pj4+Cj4+
Pj4+Pj4+IEkgdGhpbmsgUGFyYXYgaGFkIHNpbWlsYXIgc3VnZ2VzdGlvbiwgdG9vLgo+Pj4+Pj4+
Pgo+Pj4+Pj4+PiBUaGFua3MsCj4+Pj4+Pj4+IC1TaXdlaQo+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IFRo
YW5rcywKPj4+Pj4+Pj4+PiAtU2l3ZWkKPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4gVGhhbmtzLAo+
Pj4+Pj4+Pj4+Pj4gLVNpd2VpCj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgICAgICAgfQo+Pj4+Pj4+
Pj4+Pj4+ICAgICAgICAgICAgfQo+Pj4+Pj4+Pj4+Pj4+IH0KPj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPgo+Pj4+Pj4+
Pj4+Pj4+IC0tLQo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgZHJpdmVycy92ZHBhL3ZkcGEuYyAgICAg
ICB8IDEyOQo+Pj4+Pj4+Pj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Cj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICBpbmNsdWRlL2xpbnV4L3ZkcGEuaCAgICAgIHwgICA1ICsr
Cj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICBpbmNsdWRlL3VhcGkvbGludXgvdmRwYS5oIHwgICA3ICsr
Kwo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgMyBmaWxlcyBjaGFuZ2VkLCAxNDEgaW5zZXJ0aW9ucygr
KQo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92
ZHBhLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYS5jIGluZGV4Cj4+Pj4+Pj4+Pj4+Pj4gOTg0NmM5ZGU0
YmZhLi5kMGZmNjcxYmFmODggMTAwNjQ0Cj4+Pj4+Pj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy92ZHBh
L3ZkcGEuYwo+Pj4+Pj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMKPj4+Pj4+Pj4+
Pj4+PiBAQCAtOTA5LDYgKzkwOSw3NCBAQCB2ZHBhX2Rldl9jb25maWdfZmlsbChzdHJ1Y3QgdmRw
YV9kZXZpY2UKPj4+Pj4+Pj4+Pj4+PiAqdmRldiwKPj4+Pj4+Pj4+PiBzdHJ1Y3Qgc2tfYnVmZiAq
bXNnLCB1MzIgcG9ydGlkLAo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgCXJldHVybiBlcnI7Cj4+Pj4+
Pj4+Pj4+Pj4gICAgICAgICB9Cj4+Pj4+Pj4+Pj4+Pj4gK3N0YXRpYyBpbnQgdmRwYV9maWxsX3N0
YXRzX3JlYyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHN0cnVjdAo+Pj4+Pj4+Pj4+Pj4+ICtz
a19idWZmCj4+Pj4+Pj4+Pj4gKm1zZywKPj4+Pj4+Pj4+Pj4+PiArCQkJICAgICAgIHN0cnVjdCBn
ZW5sX2luZm8gKmluZm8sIHUzMiBpbmRleCkgewo+Pj4+Pj4+Pj4+Pj4+ICsJaW50IGVycjsKPj4+
Pj4+Pj4+Pj4+PiArCj4+Pj4+Pj4+Pj4+Pj4gKwlpZiAobmxhX3B1dF91MzIobXNnLCBWRFBBX0FU
VFJfREVWX1FVRVVFX0lOREVYLCBpbmRleCkpCj4+Pj4+Pj4+Pj4+Pj4gKwkJcmV0dXJuIC1FTVNH
U0laRTsKPj4+Pj4+Pj4+Pj4+PiArCj4+Pj4+Pj4+Pj4+Pj4gKwllcnIgPSB2ZGV2LT5jb25maWct
PmdldF92ZW5kb3JfdnFfc3RhdHModmRldiwgaW5kZXgsIG1zZywKPj4+Pj4+Pj4+Pj4+PiAraW5m
by0KPj4+Pj4+Pj4+Pj4gZXh0YWNrKTsKPj4+Pj4+Pj4+Pj4+PiArCWlmIChlcnIpCj4+Pj4+Pj4+
Pj4+Pj4gKwkJcmV0dXJuIGVycjsKPj4+Pj4+Pj4+Pj4+PiArCj4+Pj4+Pj4+Pj4+Pj4gKwlyZXR1
cm4gMDsKPj4+Pj4+Pj4+Pj4+PiArfQo+Pj4+Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+Pj4+PiArc3Rh
dGljIGludCB2ZW5kb3Jfc3RhdHNfZmlsbChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHN0cnVj
dAo+Pj4+Pj4+Pj4+Pj4+ICtza19idWZmCj4+Pj4+Pj4+ICptc2csCj4+Pj4+Pj4+Pj4+Pj4gKwkJ
CSAgICAgc3RydWN0IGdlbmxfaW5mbyAqaW5mbywgdTMyIGluZGV4KSB7Cj4+Pj4+Pj4+Pj4+Pj4g
KwlpbnQgZXJyOwo+Pj4+Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+Pj4+PiArCWlmICghdmRldi0+Y29u
ZmlnLT5nZXRfdmVuZG9yX3ZxX3N0YXRzKQo+Pj4+Pj4+Pj4+Pj4+ICsJCXJldHVybiAtRU9QTk9U
U1VQUDsKPj4+Pj4+Pj4+Pj4+PiArCj4+Pj4+Pj4+Pj4+Pj4gKwllcnIgPSB2ZHBhX2ZpbGxfc3Rh
dHNfcmVjKHZkZXYsIG1zZywgaW5mbywgaW5kZXgpOwo+Pj4+Pj4+Pj4+Pj4+ICsJaWYgKGVycikK
Pj4+Pj4+Pj4+Pj4+PiArCQlyZXR1cm4gZXJyOwo+Pj4+Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+Pj4+
PiArCXJldHVybiAwOwo+Pj4+Pj4+Pj4+Pj4+ICt9Cj4+Pj4+Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4+
Pj4+ICtzdGF0aWMgaW50IHZkcGFfZGV2X3ZlbmRvcl9zdGF0c19maWxsKHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRldiwKPj4+Pj4+Pj4+Pj4+PiArCQkJCSAgICAgIHN0cnVjdCBza19idWZmICptc2cs
Cj4+Pj4+Pj4+Pj4+Pj4gKwkJCQkgICAgICBzdHJ1Y3QgZ2VubF9pbmZvICppbmZvLCB1MzIgaW5k
ZXgpIHsKPj4+Pj4+Pj4+Pj4+PiArCXUzMiBkZXZpY2VfaWQ7Cj4+Pj4+Pj4+Pj4+Pj4gKwl2b2lk
ICpoZHI7Cj4+Pj4+Pj4+Pj4+Pj4gKwlpbnQgZXJyOwo+Pj4+Pj4+Pj4+Pj4+ICsJdTMyIHBvcnRp
ZCA9IGluZm8tPnNuZF9wb3J0aWQ7Cj4+Pj4+Pj4+Pj4+Pj4gKwl1MzIgc2VxID0gaW5mby0+c25k
X3NlcTsKPj4+Pj4+Pj4+Pj4+PiArCXUzMiBmbGFncyA9IDA7Cj4+Pj4+Pj4+Pj4+Pj4gKwo+Pj4+
Pj4+Pj4+Pj4+ICsJaGRyID0gZ2VubG1zZ19wdXQobXNnLCBwb3J0aWQsIHNlcSwgJnZkcGFfbmxf
ZmFtaWx5LCBmbGFncywKPj4+Pj4+Pj4+Pj4+PiArCQkJICBWRFBBX0NNRF9ERVZfVlNUQVRTX0dF
VCk7Cj4+Pj4+Pj4+Pj4+Pj4gKwlpZiAoIWhkcikKPj4+Pj4+Pj4+Pj4+PiArCQlyZXR1cm4gLUVN
U0dTSVpFOwo+Pj4+Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+Pj4+PiArCWlmIChubGFfcHV0X3N0cmlu
Zyhtc2csIFZEUEFfQVRUUl9ERVZfTkFNRSwKPj4+Pj4+IGRldl9uYW1lKCZ2ZGV2LQo+Pj4+Pj4+
Pj4+PiBkZXYpKSkgewo+Pj4+Pj4+Pj4+Pj4+ICsJCWVyciA9IC1FTVNHU0laRTsKPj4+Pj4+Pj4+
Pj4+PiArCQlnb3RvIHVuZG9fbXNnOwo+Pj4+Pj4+Pj4+Pj4+ICsJfQo+Pj4+Pj4+Pj4+Pj4+ICsK
Pj4+Pj4+Pj4+Pj4+PiArCWRldmljZV9pZCA9IHZkZXYtPmNvbmZpZy0+Z2V0X2RldmljZV9pZCh2
ZGV2KTsKPj4+Pj4+Pj4+Pj4+PiArCWlmIChubGFfcHV0X3UzMihtc2csIFZEUEFfQVRUUl9ERVZf
SUQsIGRldmljZV9pZCkpIHsKPj4+Pj4+Pj4+Pj4+PiArCQllcnIgPSAtRU1TR1NJWkU7Cj4+Pj4+
Pj4+Pj4+Pj4gKwkJZ290byB1bmRvX21zZzsKPj4+Pj4+Pj4+Pj4+PiArCX0KPj4+Pj4+Pj4+Pj4+
PiArCj4+Pj4+Pj4+Pj4+Pj4gKwllcnIgPSB2ZW5kb3Jfc3RhdHNfZmlsbCh2ZGV2LCBtc2csIGlu
Zm8sIGluZGV4KTsKPj4+Pj4+Pj4+Pj4+PiArCj4+Pj4+Pj4+Pj4+Pj4gKwlnZW5sbXNnX2VuZCht
c2csIGhkcik7Cj4+Pj4+Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4+Pj4+ICsJcmV0dXJuIGVycjsKPj4+
Pj4+Pj4+Pj4+PiArCj4+Pj4+Pj4+Pj4+Pj4gK3VuZG9fbXNnOgo+Pj4+Pj4+Pj4+Pj4+ICsJZ2Vu
bG1zZ19jYW5jZWwobXNnLCBoZHIpOwo+Pj4+Pj4+Pj4+Pj4+ICsJcmV0dXJuIGVycjsKPj4+Pj4+
Pj4+Pj4+PiArfQo+Pj4+Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+Pj4+PiAgICAgICAgIHN0YXRpYyBp
bnQgdmRwYV9ubF9jbWRfZGV2X2NvbmZpZ19nZXRfZG9pdChzdHJ1Y3Qgc2tfYnVmZgo+Pj4+Pj4+
Pj4+Pj4+ICpza2IsIHN0cnVjdAo+Pj4+Pj4+Pj4+IGdlbmxfaW5mbyAqaW5mbykKPj4+Pj4+Pj4+
Pj4+PiAgICAgICAgIHsKPj4+Pj4+Pj4+Pj4+PiAgICAgICAgIAlzdHJ1Y3QgdmRwYV9kZXZpY2Ug
KnZkZXY7Cj4+Pj4+Pj4+Pj4+Pj4gQEAgLTk5MCw2ICsxMDU4LDYwIEBACj4+Pj4+PiB2ZHBhX25s
X2NtZF9kZXZfY29uZmlnX2dldF9kdW1waXQoc3RydWN0Cj4+Pj4+Pj4+Pj4gc2tfYnVmZiAqbXNn
LCBzdHJ1Y3QgbmV0bGlua19jYWxsYmFjayAqCj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAJcmV0dXJu
IG1zZy0+bGVuOwo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgfQo+Pj4+Pj4+Pj4+Pj4+ICtzdGF0aWMg
aW50IHZkcGFfbmxfY21kX2Rldl9zdGF0c19nZXRfZG9pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLAo+
Pj4+Pj4+Pj4+Pj4+ICsJCQkJCSAgc3RydWN0IGdlbmxfaW5mbyAqaW5mbykKPj4+Pj4+Pj4+Pj4+
PiArewo+Pj4+Pj4+Pj4+Pj4+ICsJc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2Owo+Pj4+Pj4+Pj4+
Pj4+ICsJc3RydWN0IHNrX2J1ZmYgKm1zZzsKPj4+Pj4+Pj4+Pj4+PiArCWNvbnN0IGNoYXIgKmRl
dm5hbWU7Cj4+Pj4+Pj4+Pj4+Pj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXY7Cj4+Pj4+Pj4+Pj4+Pj4g
Kwl1MzIgaW5kZXg7Cj4+Pj4+Pj4+Pj4+Pj4gKwlpbnQgZXJyOwo+Pj4+Pj4+Pj4+Pj4+ICsKPj4+
Pj4+Pj4+Pj4+PiArCWlmICghaW5mby0+YXR0cnNbVkRQQV9BVFRSX0RFVl9OQU1FXSkKPj4+Pj4+
Pj4+Pj4+PiArCQlyZXR1cm4gLUVJTlZBTDsKPj4+Pj4+Pj4+Pj4+PiArCj4+Pj4+Pj4+Pj4+Pj4g
KwlpZiAoIWluZm8tPmF0dHJzW1ZEUEFfQVRUUl9ERVZfUVVFVUVfSU5ERVhdKQo+Pj4+Pj4+Pj4+
Pj4+ICsJCXJldHVybiAtRUlOVkFMOwo+Pj4+Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+Pj4+PiArCWRl
dm5hbWUgPSBubGFfZGF0YShpbmZvLT5hdHRyc1tWRFBBX0FUVFJfREVWX05BTUVdKTsKPj4+Pj4+
Pj4+Pj4+PiArCW1zZyA9IG5sbXNnX25ldyhOTE1TR19ERUZBVUxUX1NJWkUsIEdGUF9LRVJORUwp
Owo+Pj4+Pj4+Pj4+Pj4+ICsJaWYgKCFtc2cpCj4+Pj4+Pj4+Pj4+Pj4gKwkJcmV0dXJuIC1FTk9N
RU07Cj4+Pj4+Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4+Pj4+ICsJaW5kZXggPSBubGFfZ2V0X3UzMihp
bmZvLQo+Pj4+Pj4+IGF0dHJzW1ZEUEFfQVRUUl9ERVZfUVVFVUVfSU5ERVhdKTsKPj4+Pj4+Pj4+
Pj4+PiArCW11dGV4X2xvY2soJnZkcGFfZGV2X211dGV4KTsKPj4+Pj4+Pj4+Pj4+PiArCWRldiA9
IGJ1c19maW5kX2RldmljZSgmdmRwYV9idXMsIE5VTEwsIGRldm5hbWUsCj4+Pj4+Pj4+Pj4gdmRw
YV9uYW1lX21hdGNoKTsKPj4+Pj4+Pj4+Pj4+PiArCWlmICghZGV2KSB7Cj4+Pj4+Pj4+Pj4+Pj4g
KwkJTkxfU0VUX0VSUl9NU0dfTU9EKGluZm8tPmV4dGFjaywgImRldmljZSBub3QKPj4+Pj4+IGZv
dW5kIik7Cj4+Pj4+Pj4+Pj4+Pj4gKwkJZXJyID0gLUVOT0RFVjsKPj4+Pj4+Pj4+Pj4+PiArCQln
b3RvIGRldl9lcnI7Cj4+Pj4+Pj4+Pj4+Pj4gKwl9Cj4+Pj4+Pj4+Pj4+Pj4gKwl2ZGV2ID0gY29u
dGFpbmVyX29mKGRldiwgc3RydWN0IHZkcGFfZGV2aWNlLCBkZXYpOwo+Pj4+Pj4+Pj4+Pj4+ICsJ
aWYgKCF2ZGV2LT5tZGV2KSB7Cj4+Pj4+Pj4+Pj4+Pj4gKwkJTkxfU0VUX0VSUl9NU0dfTU9EKGlu
Zm8tPmV4dGFjaywgInVubWFuYWdlZAo+Pj4+Pj4gdmRwYQo+Pj4+Pj4+Pj4+IGRldmljZSIpOwo+
Pj4+Pj4+Pj4+Pj4+ICsJCWVyciA9IC1FSU5WQUw7Cj4+Pj4+Pj4+Pj4+Pj4gKwkJZ290byBtZGV2
X2VycjsKPj4+Pj4+Pj4+Pj4+PiArCX0KPj4+Pj4+Pj4+Pj4+PiArCWVyciA9IHZkcGFfZGV2X3Zl
bmRvcl9zdGF0c19maWxsKHZkZXYsIG1zZywgaW5mbywgaW5kZXgpOwo+Pj4+Pj4+Pj4+Pj4+ICsJ
aWYgKCFlcnIpCj4+Pj4+Pj4+Pj4+Pj4gKwkJZXJyID0gZ2VubG1zZ19yZXBseShtc2csIGluZm8p
Owo+Pj4+Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+Pj4+PiArCXB1dF9kZXZpY2UoZGV2KTsKPj4+Pj4+
Pj4+Pj4+PiArCW11dGV4X3VubG9jaygmdmRwYV9kZXZfbXV0ZXgpOwo+Pj4+Pj4+Pj4+Pj4+ICsK
Pj4+Pj4+Pj4+Pj4+PiArCWlmIChlcnIpCj4+Pj4+Pj4+Pj4+Pj4gKwkJbmxtc2dfZnJlZShtc2cp
Owo+Pj4+Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+Pj4+PiArCXJldHVybiBlcnI7Cj4+Pj4+Pj4+Pj4+
Pj4gKwo+Pj4+Pj4+Pj4+Pj4+ICttZGV2X2VycjoKPj4+Pj4+Pj4+Pj4+PiArCXB1dF9kZXZpY2Uo
ZGV2KTsKPj4+Pj4+Pj4+Pj4+PiArZGV2X2VycjoKPj4+Pj4+Pj4+Pj4+PiArCW11dGV4X3VubG9j
aygmdmRwYV9kZXZfbXV0ZXgpOwo+Pj4+Pj4+Pj4+Pj4+ICsJcmV0dXJuIGVycjsKPj4+Pj4+Pj4+
Pj4+PiArfQo+Pj4+Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+Pj4+PiAgICAgICAgIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgbmxhX3BvbGljeSB2ZHBhX25sX3BvbGljeVtWRFBBX0FUVFJfTUFYICsgMV0KPj4+
Pj4+ID0gewo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgCVtWRFBBX0FUVFJfTUdNVERFVl9CVVNfTkFN
RV0gPSB7IC50eXBlID0KPj4+Pj4+Pj4gTkxBX05VTF9TVFJJTkcgfSwKPj4+Pj4+Pj4+Pj4+PiAg
ICAgICAgIAlbVkRQQV9BVFRSX01HTVRERVZfREVWX05BTUVdID0geyAudHlwZSA9IE5MQV9TVFJJ
TkcKPj4+Pj4+Pj4gfSwgQEAgLQo+Pj4+Pj4+Pj4+IDk5Nyw2Cj4+Pj4+Pj4+Pj4+Pj4gKzExMTks
NyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG5sYV9wb2xpY3kKPj4+Pj4+Pj4+PiB2ZHBhX25sX3Bv
bGljeVtWRFBBX0FUVFJfTUFYICsgMV0gPSB7Cj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAJW1ZEUEFf
QVRUUl9ERVZfTkVUX0NGR19NQUNBRERSXSA9Cj4+Pj4+Pj4+IE5MQV9QT0xJQ1lfRVRIX0FERFIs
Cj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAJLyogdmlydGlvIHNwZWMgMS4xIHNlY3Rpb24gNS4xLjQu
MSBmb3IgdmFsaWQgTVRVIHJhbmdlICovCj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAJW1ZEUEFfQVRU
Ul9ERVZfTkVUX0NGR19NVFVdID0KPj4+Pj4+Pj4gTkxBX1BPTElDWV9NSU4oTkxBX1UxNiwgNjgp
LAo+Pj4+Pj4+Pj4+Pj4+ICsJW1ZEUEFfQVRUUl9ERVZfUVVFVUVfSU5ERVhdID0KPj4+Pj4+IE5M
QV9QT0xJQ1lfUkFOR0UoTkxBX1UzMiwgMCwKPj4+Pj4+Pj4+PiA2NTUzNSksCj4+Pj4+Pj4+Pj4+
Pj4gICAgICAgICB9Owo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgc3RhdGljIGNvbnN0IHN0cnVjdCBn
ZW5sX29wcyB2ZHBhX25sX29wc1tdID0geyBAQCAtMTAzMCw2Cj4+Pj4+Pj4+Pj4+Pj4gKzExNTMs
MTIgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBnZW5sX29wcyB2ZHBhX25sX29wc1tdID0gewo+Pj4+
Pj4+Pj4+Pj4+ICAgICAgICAgCQkuZG9pdCA9IHZkcGFfbmxfY21kX2Rldl9jb25maWdfZ2V0X2Rv
aXQsCj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAJCS5kdW1waXQgPSB2ZHBhX25sX2NtZF9kZXZfY29u
ZmlnX2dldF9kdW1waXQsCj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAJfSwKPj4+Pj4+Pj4+Pj4+PiAr
CXsKPj4+Pj4+Pj4+Pj4+PiArCQkuY21kID0gVkRQQV9DTURfREVWX1ZTVEFUU19HRVQsCj4+Pj4+
Pj4+Pj4+Pj4gKwkJLnZhbGlkYXRlID0gR0VOTF9ET05UX1ZBTElEQVRFX1NUUklDVCB8Cj4+Pj4+
Pj4+Pj4gR0VOTF9ET05UX1ZBTElEQVRFX0RVTVAsCj4+Pj4+Pj4+Pj4+Pj4gKwkJLmRvaXQgPSB2
ZHBhX25sX2NtZF9kZXZfc3RhdHNfZ2V0X2RvaXQsCj4+Pj4+Pj4+Pj4+Pj4gKwkJLmZsYWdzID0g
R0VOTF9BRE1JTl9QRVJNLAo+Pj4+Pj4+Pj4+Pj4+ICsJfSwKPj4+Pj4+Pj4+Pj4+PiAgICAgICAg
IH07Cj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICBzdGF0aWMgc3RydWN0IGdlbmxfZmFtaWx5IHZkcGFf
bmxfZmFtaWx5IF9fcm9fYWZ0ZXJfaW5pdCA9Cj4+Pj4+Pj4+Pj4+Pj4geyBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC92ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaCBpbmRleAo+Pj4+Pj4+
Pj4+Pj4+IDJkZTQ0MmVjZWNhZS4uMjc0MjAzODQ1Y2ZjIDEwMDY0NAo+Pj4+Pj4+Pj4+Pj4+IC0t
LSBhL2luY2x1ZGUvbGludXgvdmRwYS5oCj4+Pj4+Pj4+Pj4+Pj4gKysrIGIvaW5jbHVkZS9saW51
eC92ZHBhLmgKPj4+Pj4+Pj4+Pj4+PiBAQCAtMjc1LDYgKzI3NSw5IEBAIHN0cnVjdCB2ZHBhX2Nv
bmZpZ19vcHMgewo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgCQkJICAgIGNvbnN0IHN0cnVjdCB2ZHBh
X3ZxX3N0YXRlICpzdGF0ZSk7Cj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAJaW50ICgqZ2V0X3ZxX3N0
YXRlKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUxNiBpZHgsCj4+Pj4+Pj4+Pj4+Pj4gICAg
ICAgICAJCQkgICAgc3RydWN0IHZkcGFfdnFfc3RhdGUgKnN0YXRlKTsKPj4+Pj4+Pj4+Pj4+PiAr
CWludCAoKmdldF92ZW5kb3JfdnFfc3RhdHMpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2
IGlkeCwKPj4+Pj4+Pj4+Pj4+PiArCQkJCSAgIHN0cnVjdCBza19idWZmICptc2csCj4+Pj4+Pj4+
Pj4+Pj4gKwkJCQkgICBzdHJ1Y3QgbmV0bGlua19leHRfYWNrICpleHRhY2spOwo+Pj4+Pj4+Pj4+
Pj4+ICAgICAgICAgCXN0cnVjdCB2ZHBhX25vdGlmaWNhdGlvbl9hcmVhCj4+Pj4+Pj4+Pj4+Pj4g
ICAgICAgICAJKCpnZXRfdnFfbm90aWZpY2F0aW9uKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYs
IHUxNiBpZHgpOwo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgCS8qIHZxIGlycSBpcyBub3QgZXhwZWN0
ZWQgdG8gYmUgY2hhbmdlZCBvbmNlIERSSVZFUl9PSyBpcwo+Pj4+Pj4+Pj4+Pj4+IHNldCAqLyBA
QCAtNDY2LDQgKzQ2OSw2IEBAIHN0cnVjdCB2ZHBhX21nbXRfZGV2IHsKPj4+Pj4+Pj4+Pj4+PiAg
ICAgICAgIGludCB2ZHBhX21nbXRkZXZfcmVnaXN0ZXIoc3RydWN0IHZkcGFfbWdtdF9kZXYgKm1k
ZXYpOwo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgdm9pZCB2ZHBhX21nbXRkZXZfdW5yZWdpc3Rlcihz
dHJ1Y3QgdmRwYV9tZ210X2RldiAqbWRldik7Cj4+Pj4+Pj4+Pj4+Pj4gKyNkZWZpbmUgVkRQQV9J
TlZBTF9RVUVVRV9JTkRFWCAweGZmZmYKPj4+Pj4+Pj4+Pj4+PiArCj4+Pj4+Pj4+Pj4+Pj4gICAg
ICAgICAjZW5kaWYgLyogX0xJTlVYX1ZEUEFfSCAqLwo+Pj4+Pj4+Pj4+Pj4+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL3VhcGkvbGludXgvdmRwYS5oCj4+Pj4+Pj4+Pj4+Pj4gYi9pbmNsdWRlL3VhcGkv
bGludXgvdmRwYS5oIGluZGV4IDEwNjFkOGQyZDA5ZC4uYzVmMjI5YTQxZGMyCj4+Pj4+Pj4+Pj4+
Pj4gMTAwNjQ0Cj4+Pj4+Pj4+Pj4+Pj4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZkcGEuaAo+
Pj4+Pj4+Pj4+Pj4+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92ZHBhLmgKPj4+Pj4+Pj4+Pj4+
PiBAQCAtMTgsNiArMTgsNyBAQCBlbnVtIHZkcGFfY29tbWFuZCB7Cj4+Pj4+Pj4+Pj4+Pj4gICAg
ICAgICAJVkRQQV9DTURfREVWX0RFTCwKPj4+Pj4+Pj4+Pj4+PiAgICAgICAgIAlWRFBBX0NNRF9E
RVZfR0VULAkJLyogY2FuIGR1bXAgKi8KPj4+Pj4+Pj4+Pj4+PiAgICAgICAgIAlWRFBBX0NNRF9E
RVZfQ09ORklHX0dFVCwJLyogY2FuIGR1bXAgKi8KPj4+Pj4+Pj4+Pj4+PiArCVZEUEFfQ01EX0RF
Vl9WU1RBVFNfR0VULAo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgfTsKPj4+Pj4+Pj4+Pj4+PiAgICAg
ICAgIGVudW0gdmRwYV9hdHRyIHsKPj4+Pj4+Pj4+Pj4+PiBAQCAtNDYsNiArNDcsMTIgQEAgZW51
bSB2ZHBhX2F0dHIgewo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgCVZEUEFfQVRUUl9ERVZfTkVHT1RJ
QVRFRF9GRUFUVVJFUywJLyogdTY0ICovCj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAJVkRQQV9BVFRS
X0RFVl9NR01UREVWX01BWF9WUVMsCQkvKgo+Pj4+Pj4+PiB1MzIgKi8KPj4+Pj4+Pj4+Pj4+PiAg
ICAgICAgIAlWRFBBX0FUVFJfREVWX1NVUFBPUlRFRF9GRUFUVVJFUywJLyogdTY0ICovCj4+Pj4+
Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4+Pj4+ICsJVkRQQV9BVFRSX0RFVl9RVUVVRV9JTkRFWCwgICAg
ICAgICAgICAgIC8qIHUxNiAqLwo+Pj4+Pj4+Pj4+Pj4+ICsJVkRQQV9BVFRSX0RFVl9RVUVVRV9U
WVBFLCAgICAgICAgICAgICAgIC8qIHN0cmluZyAqLwo+Pj4+Pj4+Pj4+Pj4+ICsJVkRQQV9BVFRS
X0RFVl9WRU5ET1JfQVRUUl9OQU1FLAkJLyoKPj4+Pj4+IHN0cmluZyAqLwo+Pj4+Pj4+Pj4+Pj4+
ICsJVkRQQV9BVFRSX0RFVl9WRU5ET1JfQVRUUl9WQUxVRSwgICAgICAgIC8qIHU2NCAqLwo+Pj4+
Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+Pj4+PiAgICAgICAgIAkvKiBuZXcgYXR0cmlidXRlcyBtdXN0
IGJlIGFkZGVkIGFib3ZlIGhlcmUgKi8KPj4+Pj4+Pj4+Pj4+PiAgICAgICAgIAlWRFBBX0FUVFJf
TUFYLAo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgfTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
