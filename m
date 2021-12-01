Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98714C433EF
	for <virtualization@archiver.kernel.org>; Wed,  1 Dec 2021 19:41:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1CF0240545;
	Wed,  1 Dec 2021 19:41:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7kixGsQErCEm; Wed,  1 Dec 2021 19:41:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DFF9C40226;
	Wed,  1 Dec 2021 19:41:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE0A5C0012;
	Wed,  1 Dec 2021 19:41:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1FEEC000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 19:41:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C7A4641CAA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 19:41:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="Mgd6UROH";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="Vath60rR"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oRLjp2QvvkR8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 19:41:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8851441CA9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 19:41:39 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1JQP2k018228; 
 Wed, 1 Dec 2021 19:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VAaDlohKx8zE9dizUZnX4yK2kUGONB0pMwkSt/0R13g=;
 b=Mgd6UROHjN3icSLCYzxTYTZJClLhWiZo5XiucHQ52GmV9LvddleThPEPK4i4ckWbZnk3
 Sh6qy9dk+M7aHI981J4k4zPdBLwe/n5Tu+FHSOd7C6VjGr5rGnmfvnWFy3zAQ9gL6HXo
 gjMbJ7UH5B2c9VKltj/ZS7cfJma4WvZVIf6Z3bWflye2ctCtiCJE9ppWJzMWaJb5L9e8
 Oz6csI4kgqAZM33twRjTuCIbbrcB/xWebrPNYiZ9spNw+EZtzSB6lNF7izswCQ08dV9h
 GwPvckYwMaMGtGdgMRcASVb3tZPXrEocpBTVLAdKAyGaElLVZnP+Uqf+B0dwDhNjjlOl /Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cpasyj0c2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Dec 2021 19:41:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1JawSo188677;
 Wed, 1 Dec 2021 19:41:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
 by userp3030.oracle.com with ESMTP id 3ck9t2e8gd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Dec 2021 19:41:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyRoiM4Z+wh8Q9mze3JHhhQzbZO+/VYzp/Sp//JROMLUp5I6uKDHjvFnVwXDlQ4uUsqnYvLmH9wt6NX+SZ6OwN2b2hC2GEScKnQlhVvoDfJY1qLyrG/DwXa+8OOtS4E4XE9ONzYg9IiFvS+w5RY2pPoQ+kZATywkdhoaLa13MPKZcFD6nIaaY92dGDVyFNO1F0RjXZ/8WifAP7IULB5WA6a7rxhkmqZXU6hQgzfSicP2mCkkzfXZZ6pn2F5TEszZryr7Ll4syafm30y4Gxksf9PVimfe847e98uGhsrMhdXWCMuDLh+KL3AnGNy2Fw57G1sQ4xaYu7dcoLvOpCP3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAaDlohKx8zE9dizUZnX4yK2kUGONB0pMwkSt/0R13g=;
 b=gGzHJT/kUpx2aZerVUcpONLGpudtyPgvWdAh0w5wv+/KsbEPdVq98xOk88xEm/7mao22S7mX+NoG72icMZSLZsw8s8NqJgaQ0ArfS21NwrB6rfI4lCmkP38mCFIoNotHPQhNeidusREpLAu6mVndFqHl5C/ybgJHteHk35CDRkW4C1kfPscKSXqhuNcdlLJ1WfEnmqhf1i4/k24X4jlBTL5dDOlPDV8/rd0rpLhReLSQQel8xmaurqYxAzbinNhtDKjU720qIgLv+D5sE2z70+xb65M67AZlKcsROhirDds2haCagHChibf0jdizTxBQ/Dk5WDPUN6EZMsr/nAOSfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAaDlohKx8zE9dizUZnX4yK2kUGONB0pMwkSt/0R13g=;
 b=Vath60rRvRQzfcgyzh6DZl5IFmzXf9sQWtagIqTft5hoXiirt1D75MlTp6WISJyHI/C/1kAa1KKnfgLVEWJ792ELzu4n3+CZC4L5N5siEK26U/DjAjIfavR+5UUqZXU9OErJgZPQCY97Ynd8qRp4zXQdOrD7m0SnqK6aaZg9t3c=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BY5PR10MB4241.namprd10.prod.outlook.com (2603:10b6:a03:208::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 19:41:01 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::89e7:42b2:b226:2182]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::89e7:42b2:b226:2182%7]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 19:41:01 +0000
Message-ID: <427557c1-c653-66f4-dd7d-71402554643f@oracle.com>
Date: Wed, 1 Dec 2021 11:40:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/2] vdpa: Allow to configure max data virtqueues
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>
References: <20211130094838.15489-1-elic@nvidia.com>
 <20211130094838.15489-2-elic@nvidia.com>
 <ab454062-da69-a72e-1953-716257bb464c@oracle.com>
 <20211201100307.GA239524@mtl-vdi-166.wap.labs.mlnx>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211201100307.GA239524@mtl-vdi-166.wap.labs.mlnx>
X-ClientProxiedBy: BY5PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::16) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
Received: from [10.65.140.160] (138.3.200.32) by
 BY5PR04CA0006.namprd04.prod.outlook.com (2603:10b6:a03:1d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Wed, 1 Dec 2021 19:41:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6319a508-9f61-43b0-90ac-08d9b5028154
X-MS-TrafficTypeDiagnostic: BY5PR10MB4241:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4241B3D96A6C3D8340F59EC6B1689@BY5PR10MB4241.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OB/ofhj3teb9qE1czdf6VHZWw6auiFDzJhJzBExmm3DIX7lwKSGy3XvCM6ORInRf5jvCx7ipmJcw5tLo6sQsYeJvgI9AllVxOiQhrzaw6xH7ROM+Lk/yumTZz00MY/mFlXqeoJVL2Wlqum45dYKT0fC28NHL+zE0hL3BXhzG+rCqGHgIoaZeeVhmQnpuWwBgvhsxIm07UK94RUKRoX7YjxspiLwSeRYOBsX7hfjVSBqWInbRC8e9p9SOsx/YZw6XWU4pHm3SWpWWAsYErwlitREcKSIyjJ8isP2HKVnss5ja7gY/Px+IjYBt+nAqVbZfvRJc5mKjMmqQ6Bx7qfJ4XLYqDmlXGCr4oX8fnfCJS/WCmIpg7aqHgqVkRhVaHKzaAqPt4jt3JWANtjIX8LUwdjokeLbT/DxhB0d4XgHnUVlQ6+yxTkRlDkLoNLu4j8KamStMFrL8kXIitfcuQnkzPx5C+zBtMu+UM+DM/ahkpNNyiIuZbyv7gyJdd8a13r+ebSf45Zn1MmO+hp+JKyAS+d8LbNqOutobB5UPeVgw3QO8KaUf/FMmBQrUXhvOFyRJGk97gzNumkCzSABhJIfd73p+URYPeI214TFRGfKJYeAPHdBMp90RYRXoFgOH1uR9kM0LnLw1SgknNp2zeE9qWOL6YummwAQo9fsVe20tKaMoR2tzP783IjqvYeCaCfv9ULxf97bzIik3zm7HW+9Z3+HFjE+zKNrghadUdlrrpJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(86362001)(508600001)(316002)(36916002)(8936002)(6486002)(66556008)(4326008)(8676002)(36756003)(31696002)(66946007)(6666004)(2616005)(2906002)(186003)(66476007)(53546011)(5660300002)(26005)(31686004)(83380400001)(6916009)(956004)(38100700002)(16576012)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjhSYVYrKzNQWmQza1lEQ3U4TEF4MnMwTFpVQ2JpUUYvdnpSU1NRQTM0TGpC?=
 =?utf-8?B?TW5ZUVgxUE5VN3A5cEpGb1ZJampRY0pnVXRhSGFIcGE3QmtHektacVA5czgy?=
 =?utf-8?B?OUZqU2luZmI3QTd5MHI2SHNzZld4dXFDWkRRVWp4VnNCUVMyK25Gc25BNkxO?=
 =?utf-8?B?Y01GT01FemdOeE04MlFLV3dxelRKbkRTdWpKZmhISU02czRhOFZhbDNRd2R3?=
 =?utf-8?B?WUNJaEhrM0FmKzhFVlRLU05CMWhzRUpCM0psWFBrOGJmVzU2ZEpTdjRFQXNV?=
 =?utf-8?B?UWg3YzUwR0pkY09NUDdub3V2QXBjS0ptMitiWU9DLzhHeFpKaUU0VUVkWFlU?=
 =?utf-8?B?NkVHOUY4WDg5VHYyWW5aQVhneTd2MWJNU2J2alZEVEc5dkVUZklNS3UrWXMr?=
 =?utf-8?B?a0dGVEFGM0g5VUNpeEI4WEs5MjhxTHpVdlVPc0RNbW9JUCtQSGtwWVZsZU1D?=
 =?utf-8?B?RzVOV0FPdjVJYmUrU3NnZXJDYlBtVThZRlhqUU5yanJlWmpYTktKODFpUTFT?=
 =?utf-8?B?d1Q4MEh3N1d2ZEhxUGVnYTRwWDcrakdMU2xIMzJ1L0tkU2hQU1NlK1dnbVRU?=
 =?utf-8?B?NWVYZVlqOTQ5MFphMnhWUGpFQXJiWjZjUUkvK2NLbitoeXYxQXFJbktHUzVC?=
 =?utf-8?B?c1p6MFpDTGxweHFRTWZYVS9OQ2wwMmdFSGlGTFdDV3FGQkhvSTcwbkZENDZY?=
 =?utf-8?B?bkJyaVRRaXVoMDRlQW85SWYxbkVNOGRKVjdhaTgwZnE5TmFLc20xb3VIU0Js?=
 =?utf-8?B?Mkw4UDYrSFpCbnhaM1MrbnppM3F2a3VVNmxDNnp5QlQrVDhCWEI0Zlh0VWl0?=
 =?utf-8?B?YTM0cWRsM0sxbkxPZ29hMzh1aVJwV2NTUmNtT1Q2bFJkMjh0cmlQOHhSWDhN?=
 =?utf-8?B?N2hlQ0F4eVdyS3VrSjVWWGxIVi9ROVh5ZUp2cDFPWHpNYzNRWjAyQ0FUc0dZ?=
 =?utf-8?B?N2lvdGMvY1B5bkIySTlqWXY0cFpXaEVCYll1ZmszaUhWaUhlQ3N4bnp1ZWxn?=
 =?utf-8?B?RHJBZGpxUkFrb21kSzBFZlFUaE43NTN4OXRXOFFob01WM0pyUXRKc29ibXd5?=
 =?utf-8?B?SGxZcHRtSUhneXNMeWV5bmxTVUh2RldDeU5tUjFyR21wbnJsb1p5YmR5SmxR?=
 =?utf-8?B?L1loZzV4dVlvdFhpTUVMRUR6NnFKbThSWlREZm4zcitrRi95djU0WFZNZ0tZ?=
 =?utf-8?B?a1R2UnM4TG51ZTAwUXhhVURENEsvMkF6Q0NqbjUzOStwTFdlcVV6STl0dDhG?=
 =?utf-8?B?bzNWdEo2UFVGV2ZLemhaek5LWXYwendxbStEUzd0b2dYb0RIUjNFOXZhVTZM?=
 =?utf-8?B?RzF5T2VZRWFQNUVDZ2RpSEhVNGRKTjhOV1JQZVBNMkhkUGpGQjRYYjRRL2ZM?=
 =?utf-8?B?b0JqaG1oei9JQUpzZngrbkhMSkJNS3c5MTRpWUcweC9BMXZ6V0JLVjBXYi8y?=
 =?utf-8?B?N25aVkVyRXB0VytYNEhOQnZSYTNvZ2ZjWG0xSi9pRHR0M2NGbGs0a011b1RW?=
 =?utf-8?B?LzB0VkNaNEcxRDliY28yd1h5NWduQWI0TmUvMmhkbmhIelhHcG1ZbjY2TWJJ?=
 =?utf-8?B?TTk0L3JRblEwNHVtd3MySllNUjRQZERJUmozMWxubi9VUkl3NFliOXBTS29S?=
 =?utf-8?B?RDR2V2FqNW8raTVMQTZDM3NnRGhWenVTaW1KU0RnemtQR3V3QldWczZkNjE1?=
 =?utf-8?B?bXlRTUhTbm5ISVlHbndsbTNxSnl1bGJnZ2tHd2ZtZSs3bTVXV01xZ3l6Y2Nh?=
 =?utf-8?B?Rmg0SUIyaUZxNVlhNDlnNlVvNHh5RWlqbjdvV3pLQ0Q2Z0VNSW4ycUFKeGls?=
 =?utf-8?B?Tk9MMkc1a0xSQ1c0cTIvZWlhOUZ4dG11cmZDYmF3dU4rUG43UmhxdXFXVllB?=
 =?utf-8?B?VU9wSGdKNEtsbGdZUTZDMm5USktIRDlsVml4bVF3aFdzK1RYeUlGNjN1VjJJ?=
 =?utf-8?B?WW1lbStPWG1oV05PbHdJcHVtSVA0aXp4QUorS1UrSk9nd2VCUE9KaHVPU0xr?=
 =?utf-8?B?UjlNMjdGd0RjMThnL3RsVDUrM3FGNnhkQVByR0wzUFRLQUVIcVQ3bXN3cUx4?=
 =?utf-8?B?bWdKQ0hKRS93c1djQWg2RENFWGpiMGVVTG03TDFqUFdFUUhTdlBxekZ3MTdN?=
 =?utf-8?B?cVJ2NlcxTmFqVVpDMHc4WkRlV1FFZ0hOczlHc1lCUnRnUUlZaWIxUXZvczM5?=
 =?utf-8?Q?nSbRIwfSAMhQS2ox2+PFrZw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6319a508-9f61-43b0-90ac-08d9b5028154
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 19:41:01.5769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHsh42fkhY4Evg1BBWKuBBt8IFp5em5RPUZJnRqXuhRF8SwauFhC3gKd49++Fy1HtvukSOiehFRWkuFj856zpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4241
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10185
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010104
X-Proofpoint-GUID: 6nJa7lr3ozZzIgg0z9-wnRHOOgiRke7R
X-Proofpoint-ORIG-GUID: 6nJa7lr3ozZzIgg0z9-wnRHOOgiRke7R
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



On 12/1/2021 2:03 AM, Eli Cohen wrote:
> On Tue, Nov 30, 2021 at 05:24:03PM -0800, Si-Wei Liu wrote:
>>
>> On 11/30/2021 1:48 AM, Eli Cohen wrote:
>>> Allow to configure the max virtqueues for a device.
>>>
>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>> ---
>>>    drivers/vdpa/vdpa.c  | 16 +++++++++++++++-
>>>    include/linux/vdpa.h |  1 +
>>>    2 files changed, 16 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>> index 7332a74a4b00..e185ec2ee851 100644
>>> --- a/drivers/vdpa/vdpa.c
>>> +++ b/drivers/vdpa/vdpa.c
>>> @@ -480,7 +480,8 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
>>>    }
>>>    #define VDPA_DEV_NET_ATTRS_MASK ((1 << VDPA_ATTR_DEV_NET_CFG_MACADDR) | \
>>> -				 (1 << VDPA_ATTR_DEV_NET_CFG_MTU))
>>> +				 (1 << VDPA_ATTR_DEV_NET_CFG_MTU) | \
>>> +				 (1 << VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
>> It seems VDPA_ATTR_DEV_MAX_VQS (u32) is what you want (# of data virtqueues
>> instead of # of data virtqueue pairs)? Not sure what's possible use of
>> VDPA_ATTR_DEV_NET_CFG_MAX_VQP, was it to dump/display the config space
>> max_virtqueue_pairs value (u16, 1-32768) for virtio-net? Why there's such
>> quasi-duplicate attribute introduced in the first place?
>>
> VDPA_ATTR_DEV_MAX_VQS currently returns vdev->nvqs which equals whatever
> passed to _vdpa_register_device(). The latter depends on the value
> provided by (struct vdpa_dev_set_config).max_virtqueues. It's the only
> way to let the user know if there are other virtqueues besides the data
> virtqueues. For example, if we support control virtqueue and configured
> 2 data QPs, we will return 5.
That's right. Then let VDPA_ATTR_DEV_MAX_VQS continue to be read-only as is.
>
> Maybe we should add attributes to add aditional virtqueues like control
> virtqueue and their index. They could be returned by
> vdpa_dev_net_config_fill().
Probably this info would need to return to QEMU for proper virtq 
modeling via vDPA ioctls rather than just netlink API. Agreed it's 
virtio-net specific config.
> VDPA_ATTR_DEV_NET_CFG_MAX_VQP seems the right choice since it is used to
> provid the requested number of data virtqueues when creating the device.
> Maybe we need to change the name to VDPA_ATTR_DEV_NET_CFG_MAX_VQ and
> then this patch makes more sense.
I would just keep the name for VDPA_ATTR_DEV_NET_CFG_MAX_VQP and have 
user configure the number of data queue pairs instead. Very few virtio 
types come with virtqueue in pairs, so this has to be vdpa net specific 
config.

Thanks,
-Siwei

>
>
> I will post another series to address all these issues.
>
>> Not even sure VDPA_ATTR_DEV_MAX_VQS by definition should include other
>> virtqueues as well: such as control virtqueue or event virtqueue. Hence the
>> name will be more applicable to vdpa devices of other virtio type than just
>> virtio-net. Otherwise I would think this attribute is slightly misnamed
>> (max_data_vqs might be a proper name).
>>
>>>    static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
>>>    {
>>> @@ -506,6 +507,19 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>>>    			nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]);
>>>    		config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MTU);
>>>    	}
>>> +	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP]) {
>>> +		config.max_virtqueues = nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP]);
>>> +		if (config.max_virtqueues < 2) {
>>> +			NL_SET_ERR_MSG_MOD(info->extack, "At least two virtqueues are required");
>>> +			return -EINVAL;
>>> +		}
>>> +		if ((config.max_virtqueues - 1) & config.max_virtqueues) {
>>> +			NL_SET_ERR_MSG_MOD(info->extack,
>>> +					   "Must provide power of two number of virtqueues");
>> Why there's such limitation for the number of vDPA virtqueues? I thought the
>> software virtio doesn't have this limitation (power of two).
> Right, the limitation comes from mlx5_vdpa. I will post a patch later to
> remove that limitation.
>
>> -Siwei
>>
>>> +			return -EINVAL;
>>> +		}
>>> +		config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
>>> +	}
>>>    	/* Skip checking capability if user didn't prefer to configure any
>>>    	 * device networking attributes. It is likely that user might have used
>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>>> index c3011ccda430..2f0b09c6d1ae 100644
>>> --- a/include/linux/vdpa.h
>>> +++ b/include/linux/vdpa.h
>>> @@ -101,6 +101,7 @@ struct vdpa_dev_set_config {
>>>    		u16 mtu;
>>>    	} net;
>>>    	u64 mask;
>>> +	u16 max_virtqueues;
>>>    };
>>>    /**

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
