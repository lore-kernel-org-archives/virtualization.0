Return-Path: <SRS0=mL0J=HW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED99EC433E0
	for <virtualization@archiver.kernel.org>; Sat, 20 Feb 2021 02:50:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52AB060234
	for <virtualization@archiver.kernel.org>; Sat, 20 Feb 2021 02:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52AB060234
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1BE66F616
	for <virtualization@archiver.kernel.org>; Sat, 20 Feb 2021 02:50:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ly2EIC8W0kB6 for <virtualization@archiver.kernel.org>;
	Sat, 20 Feb 2021 02:50:55 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 107456F59F; Sat, 20 Feb 2021 02:50:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5CD860707;
	Sat, 20 Feb 2021 02:50:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0AA2C000A;
	Sat, 20 Feb 2021 02:50:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E157AC0001
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 02:50:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C928487520
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 02:50:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qp7-J-jhK+lB
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 02:50:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2015E874CF
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 02:50:50 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11K2on7C149044;
 Sat, 20 Feb 2021 02:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=PxYzvHYSwQlmFcn8B7mICI3ekLOgVQxBEbok7irhp6o=;
 b=n//sO9aUKBptetOvdf5GS9FBKZoECnzylf9SgU76niXoB8GRmDEoa1WQ3vdtSHYc42BV
 o4+mX+hqa7HLPdNP8Y+dpL9tpotW0s814fEVj/yGG8SCx188wpyHFs/36+gqaSQP5RHj
 bum1WIbL3ZZ8RFTPKAgmGYdV13NbPG4rZ/Mvi4O1y0QjMshfaZRq+Qpe37WmHfcABxU+
 sYZcqKJt42ePvCWjjngm/YWNUnfzjtNkMdyF11J28PIzRLIOlADEHcYvJTFeiO/LkmkQ
 VbqR8Kqn8VGgzPnFitWgvPNq/h7boNFRH8eux0OZYwoROsXX+hQxB4XjNnhZmPLgNPeQ gw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 36p7dnu5bx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Feb 2021 02:50:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11K2oLhD154861;
 Sat, 20 Feb 2021 02:50:48 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2051.outbound.protection.outlook.com [104.47.36.51])
 by aserp3020.oracle.com with ESMTP id 36prp3kj8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Feb 2021 02:50:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvEcLRSUfJnCCm8n4a4ZFFq4lMXM2ip9dH/SUUcYVZxuvRUnQbbseBL2AGS57aXlp6aoW/7NvBawT2aRg7+2GJrxuBUsLDSw1W4BezSN91PKGEZIZiF7QANW2rW+U7p+goDksI18X2dhbEWTUrXSxyJpINgw4U0zqDJqQpHor5s3RnictcgQm7sFlYqzKQKedJCVSbyTKWKZxG35yr2u4aCtfkQd7xGrBHjEO5ONy9Ite+X3fUZbG9JBDyFBrpIpmJCDlgPEAmne5GaGY4lzgFhQSyJ72uTSG35WHYJdeYFKWkM7wHDYhJiioJVmY2hFXpJQw6pt9TPDQrfZpEZYsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxYzvHYSwQlmFcn8B7mICI3ekLOgVQxBEbok7irhp6o=;
 b=USIcBjxmU2XQkdF1/uXZJ44/D8aBCFQJN6A4omWWYT4iLzFS+kEZ6TXvCwJ/pO0oBAp4GN8HuOd0pmkNNUa7gQ92Lux2toP4H3etMRcOIVrR9l4hgqXZcyrsT/wFt7Bo9Xt6kd913dHlZQHcR9mPfpgmveXKfYMiGZhfOYk/X22l31pS2QxJkywroHYuZkV3CN5hTua5lsaEzoWjvhNJJH2ZNDRVkLpaA/u0UQppwD9Zfboy1mpkT8naNS8PUP6b+Dtv+2KQRY7X7o9QoPJYixoB3NnmDuwzEBj3CnwSvi5a/wnISHsy3UL+UaVt/GjxPecpMHnSYoImYaQwYAy9Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxYzvHYSwQlmFcn8B7mICI3ekLOgVQxBEbok7irhp6o=;
 b=MBE4dD4AU5Ry2mzNo8fvpgeNNmIZ5bUeeB3Hzas1ox50JalME0/aapm7pzCtse3j4WYQk0LNuzAqWePgPSUCp4sIuVOPTyZgr8O08fH9zh1GiVHhbtkRLDv/jS6LF5P9moe91ymyLY3Bt/wEp58d4sxLB+1FVr7AcCXQeE1X3o0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB3574.namprd10.prod.outlook.com (2603:10b6:a03:119::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Sat, 20 Feb
 2021 02:50:45 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::45b5:49d:d171:5359]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::45b5:49d:d171:5359%5]) with mapi id 15.20.3868.029; Sat, 20 Feb 2021
 02:50:45 +0000
Subject: Re: [PATCH v1] vdpa/mlx5: Restore the hardware used index after
 change map
To: Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20210204073618.36336-1-elic@nvidia.com>
 <81f5ce4f-cdb0-26cd-0dce-7ada824b1b86@oracle.com>
 <f2206fa2-0ddc-1858-54e7-71614b142e46@redhat.com>
 <20210208063736.GA166546@mtl-vdi-166.wap.labs.mlnx>
 <0d592ed0-3cea-cfb0-9b7b-9d2755da3f12@redhat.com>
 <20210208100445.GA173340@mtl-vdi-166.wap.labs.mlnx>
 <379d79ff-c8b4-9acb-1ee4-16573b601973@redhat.com>
 <20210209061232.GC210455@mtl-vdi-166.wap.labs.mlnx>
 <411ff244-a698-a312-333a-4fdbeb3271d1@redhat.com>
 <a90dd931-43cc-e080-5886-064deb972b11@oracle.com>
 <b749313c-3a44-f6b2-f9b8-3aefa2c2d72c@redhat.com>
 <24d383db-e65c-82ff-9948-58ead3fc502b@oracle.com>
 <740b4f73-c668-5e0e-5af2-ebea7528d7a2@redhat.com>
 <9243c03b-8490-523c-2b78-928d1bcb0ddd@oracle.com>
 <b2d18964-8cd6-6bb1-1995-5b966207046d@redhat.com>
 <5cf5e0ad-efbb-dc37-8054-5c46722b87df@oracle.com>
 <2330af63-02e2-77fe-255b-c55f01292e80@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
Message-ID: <33d5a37e-3231-1687-dc89-cebde1de1efe@oracle.com>
Date: Fri, 19 Feb 2021 18:50:41 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <2330af63-02e2-77fe-255b-c55f01292e80@redhat.com>
Content-Language: en-US
X-Originating-IP: [73.189.186.83]
X-ClientProxiedBy: CY4PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:903:33::21) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.19] (73.189.186.83) by
 CY4PR03CA0011.namprd03.prod.outlook.com (2603:10b6:903:33::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27 via Frontend Transport; Sat, 20 Feb 2021 02:50:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 623b1c7a-6018-40fa-03fd-08d8d54a51df
X-MS-TrafficTypeDiagnostic: BYAPR10MB3574:
X-Microsoft-Antispam-PRVS: <BYAPR10MB35742DBFDDA5872C29A8814BB1839@BYAPR10MB3574.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zQUQivcxXCPF07KPOi1whxSBAUtz0QiIvC6+WFTK81IiFmWTiu0q8Lmsptod9g79SIRjcpZQrO83VFZiTbMm16SuXscruP6Qh60HIjg/JTn1d7H2Vf7skrzB8AX/b226jrp3uTKKi/5WgHx4SEKq0rqVKQaVr/dSV/BRsrJuQzQ4ZbHCLhKLibYf3rjrPCowpO1fy47JiRyciu6W1YKC2tSduM/iYTKQXukfMUfVSBQLEA4ugNEWJGJD5Q0Lul7+a/TlD/mthXASFAS0cM6LVJ0+Feeo1ejq1WblavVK365BaV8HEor5QmEj2jUMCUkOy1YNIXWF+60knGEKDcsazyH4vWSLWNX7YAv9jBoc2gFXMnAmYF0EQTxVqZWp93ZQGGFzLbaItVxQSMKoylOqFkHLK917Z+bHrr1i+9CyPLfno84nT25MNIbZviH5dd/5A/C1hByOG2nQdm/jyx2xipC4d9KIXMf+Lm1IzkgSE4siurLnll9nfdISDEJOHoigf7YLUUigjh3nsgV7AbdqqgeCsukfHZG00JD9BQ/mlwX3IdkOg03S5QAztEWYSIWsfaiFoGzf3d0OtCAkUydb9m1XF9zZTNU9QERKfIXo/otw7clQH6Apq/gtQ4X9Ah5MvWKNK/wGbIIFArFNK6cd6f2esXVBaFkinwWsHaMWlcaROmj/KZVNcBU3MJbKFNDI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(366004)(376002)(39860400002)(346002)(136003)(53546011)(166002)(31686004)(966005)(478600001)(8676002)(66946007)(66476007)(66556008)(31696002)(316002)(16526019)(4326008)(16576012)(6486002)(110136005)(36756003)(36916002)(2616005)(186003)(956004)(33964004)(8936002)(2906002)(26005)(86362001)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZVpsTnRibUU4aVNvcHg3NjFtbkR0UDZyR3VnZmxRaE8yV2M5L3ZDTnpzTExT?=
 =?utf-8?B?YTVGejZaNXZZODhGd2w1T081em5aRWNQdUZWSVZLK0dBVE9sRFFLbWs4cUdU?=
 =?utf-8?B?YmFKZFk3VHdUcW9WNE1yVmpXRVJFYW1KVmNOck93N2p2OGxVYjArOVFjdmR0?=
 =?utf-8?B?MGNvck8rYW9wZjB5cUpraFdxUWQxUzdTT2JqTHhDZGZJcUR2ZEFJSTMyazYr?=
 =?utf-8?B?Ujg0YlpMRnVWb0tGQ2tQY2NQNEhYcGRvUDByMTRjV01yaE1obHRrTlNlQ3Ar?=
 =?utf-8?B?bFFUY1AxMmRIbndzMWRVc1gyVmhvdE1mYmVxV1RGalUvTjU5ei81TVBBT1VO?=
 =?utf-8?B?R0M1MnRXbzdUN3dRaStuN2FvUEtZMmtxbHcwVTRvU0ZhYnhOOEhERThtazc5?=
 =?utf-8?B?elQ2K3FXN3pMNFdvbHAxWUJlQXR6cTMrczJXY3FZc1BjSVdVN0I5REw5c3lZ?=
 =?utf-8?B?WEwyc0RPRkZmcDVBQS9PaStzTG1rd0szcGl1VzhJdCtYM05VaUxXcisrMHBU?=
 =?utf-8?B?d01ReHlLSHhTbEI3WEVnVzUzRzFvYXpva3RvaHhsOGVNN1NWSWorYWt6eDND?=
 =?utf-8?B?bTNQNmFBNi9zN1dWQ2pNejZGeGdDUzcwcDMzblptZ2Urd2htREpXSDZUbUZ5?=
 =?utf-8?B?aVZKT2I5bzB0ajg2RVlqajdTZzZNYnVuMTA5aXpGYmZqZGhoWmJjdmJTOFdH?=
 =?utf-8?B?SzVzU1pvK0d0MWRTS2ZERWZ3UExGU2dnZjZYM21NZ3lJWW5NTHNIN3h1SGo4?=
 =?utf-8?B?TDdxUUdRQzBTbER3RmlCNEVOOWhtMWd4b2ZHYUdpWUdhWjZNcEhXQWZUcXQ3?=
 =?utf-8?B?MDY3NkF1alNxVkMzTkx0M3hCUlBsdnI0eWRnc1B0MG5iQnVnTE5HUlB3bXNi?=
 =?utf-8?B?NldCcU11L3VlZmpPU0hRMWpLQW5IQy9IR0R4RXcwblJ2ZnJQYk9IL1JrOWRG?=
 =?utf-8?B?LzV4RzNwcTBZQWNJZys2aWtsZ1hCUDlmRHJQQ0FwMG1GRkFJR2dNQnBudWh3?=
 =?utf-8?B?cGlMMlpoY0NEa0JDQ1BvbmdpeFBaMDZlTFlDYU5HTStkN2prL3VqVllEVU9h?=
 =?utf-8?B?alBTMDVkY29vbmxleXRhRW92MHJsSi9aTEFHby8zdnRoK1F2RkplTWVGMW5J?=
 =?utf-8?B?alU5WFFkNG9kM0p6bFNGOGo1VXY5NjU5VjFJbTQwaHJoWEpETHpoa1MyR21k?=
 =?utf-8?B?N1pJZlBkMG5zU2tid1dNMmFJT1F2YThBNm9NM0xoS0FmRHRsOUUzUFVZYldT?=
 =?utf-8?B?dllia3g2MzhHY3hPQmxEeTMwcEVKRnV2eVA2L2hIVWRWYzE0OGFTZWJvQk80?=
 =?utf-8?B?cEFQOSs0WW9OeTVvSnlaSjg1MTExRnh6NjBqbFpkeDFiYUVHWHNXSWlqckJw?=
 =?utf-8?B?bUhWTHZnNWpjbG5yUnE3MjNiZ1FzQVg2Mk5ycGJLM0JOSUVLVVptcUM5Lyt1?=
 =?utf-8?B?d2dhaDFFbGZWeEQ3NzhrVERuOHc3c3FzZFlkSlpBcDk1czZ3bkJ3dFp0N2pD?=
 =?utf-8?B?UXFzK2E1RHFqQ1V2RXhXQUZjM0twSHgwTlowTllQOTFPek1tVERjbFNpNTZK?=
 =?utf-8?B?Snh6SStGdnRUWkRkYWZyMVZaTGsxZWo1ZmlTakFLdUQyVUxIS1ZTbDhhdHdj?=
 =?utf-8?B?M08yS01nTklEaGFrQnp6SXlHSjU5YW9haTA2WXVva2FCVTA2enRaanhqRldm?=
 =?utf-8?B?NDVHTDl3Z2lMU2lDLzRxWGhvTTREaXA4REtpZ0NrclB0aG8zNUh6T1VndVRz?=
 =?utf-8?Q?vMv/7jnLNsQbthRaxSJvqQojer/WDyqJU5I9l48?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623b1c7a-6018-40fa-03fd-08d8d54a51df
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2021 02:50:45.2940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jNB+iwrL+BJQMXWFyyBqGjfXGbgwv11X88CEASju+AZlX0N9/WEQAdeQz33ApCzwYHg8pDR/qm5ZipZVXFrgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3574
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102200023
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102200023
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, lulu@redhat.com, mst@redhat.com
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
Content-Type: multipart/mixed; boundary="===============5568170063848732847=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============5568170063848732847==
Content-Type: multipart/alternative;
 boundary="------------A396357265A17F0D02F28125"
Content-Language: en-US

--------------A396357265A17F0D02F28125
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/19/2021 6:38 PM, Jason Wang wrote:
>>>
>>>
>>> Right now the value is exposed to userspace via GET_VRING_BASE, so 
>>> only last_avail_idx is synced. If we need sync last_used_idx, we 
>>> should also sync pending indices which requires more thoughts.
>> Technically it doesn't sound right - crossing the boundary a bit even 
>> with simplified form of assumption. But depending on how userspace 
>> could make use of this API, it doesn't seem it breaks existing 
>> functionality for the moment.
>
>
> I don't get here, maybe you can explain a little bit more? 
Please refer to the email I just sent.

https://lore.kernel.org/lkml/033b0806-4037-5755-a1fa-91dbb58bab2e@oracle.com/

-Siwei

--------------A396357265A17F0D02F28125
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 2/19/2021 6:38 PM, Jason Wang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:2330af63-02e2-77fe-255b-c55f01292e80@redhat.com">
      <blockquote type="cite" style="color: #007cff;">
        <blockquote type="cite" style="color: #007cff;"><br>
          <br>
          Right now the value is exposed to userspace via
          GET_VRING_BASE, so only last_avail_idx is synced. If we need
          sync last_used_idx, we should also sync pending indices which
          requires more thoughts.
          <br>
        </blockquote>
        Technically it doesn't sound right - crossing the boundary a bit
        even with simplified form of assumption. But depending on how
        userspace could make use of this API, it doesn't seem it breaks
        existing functionality for the moment.
        <br>
      </blockquote>
      <br>
      <br>
      I don't get here, maybe you can explain a little bit more?
    </blockquote>
    Please refer to the email I just sent.<br>
    <br>
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/lkml/033b0806-4037-5755-a1fa-91dbb58bab2e@oracle.com/">https://lore.kernel.org/lkml/033b0806-4037-5755-a1fa-91dbb58bab2e@oracle.com/</a><br>
    <br>
    -Siwei<br>
  </body>
</html>

--------------A396357265A17F0D02F28125--

--===============5568170063848732847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5568170063848732847==--
