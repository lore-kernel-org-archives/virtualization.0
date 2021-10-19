Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A778C433F5
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 17:02:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D856610D0
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 17:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D856610D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C028B83AF3;
	Tue, 19 Oct 2021 17:02:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MLkBSt_Tbnb1; Tue, 19 Oct 2021 17:02:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 104A4839DC;
	Tue, 19 Oct 2021 17:02:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB728C000F;
	Tue, 19 Oct 2021 17:02:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FA95C000F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 17:02:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4DD49839E5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 17:02:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c1Dox6UEqqXD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 17:02:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B25C0839DC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 17:02:17 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19JGNfdN017634; 
 Tue, 19 Oct 2021 17:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wPdwFbrxi62EI/DsEGaoFKaTqInDy2tlrXa0tAk9tP8=;
 b=O+WK7Ie3dUwpeNu7ijohHaK80jPuwIUyPyTkUMSuESUHySRTxyyG3zDkJJxwpagamdMh
 t9OyDJrGz3yMFeJ0VVfLy2P75b4D71visGgiFUqoUqro/k2xI0nBFgP/M05VfhPMg53y
 JNy1pPhsTK75JlxwqF9oVpTnjNtg6FTFMgb8MGgAqk4BYyTeeQqq3S9AzOgOuoDRsyNd
 sFgX+Uqy3V42ubqrFgKpuLrvjyiI1eJZ6+71Ai2qwMAWSoFvPGYxlIbE+B6BvzrxuPfZ
 cHlaHo40Er/JpylV8jmNvZ6hClv5t6ghZx6bRUH4EWbUS1jlh8sYKMCrnjWxHfRuCiWa 2A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bsn7km20x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Oct 2021 17:01:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19JGunNw172054;
 Tue, 19 Oct 2021 17:01:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
 by aserp3030.oracle.com with ESMTP id 3bqmsf46nr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Oct 2021 17:01:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRx3qJBj9Hl76eaFohNMUzrB9nKRrNwlRCUtZeykSi+SoBx4y5IUizkM4+GELr5uhEbgjJqfXTq67d+2yGk/GflsBzFEd6eb3nJeTGQTL21K0GbBmQevj0AX7ldPGjR2lccOlzNDeA9pqV5i9CaoItUp9OqMQVAYd1MURmW5QWGlmPfSzWTG+jsPLihaou0EZejH1PUCMyWLU1cHO8UjsOu9e23W8ynyOaviY83fJOPK3qgGfYUsYeEDHMocbtVFJOk1rbqR5UQgp0KjBfBGQj4kx5B+E2lNCNvK2r9+oF0DdoL/AVMtSMAiyorQJutBIm2F6h7ibmHkPzWdxNK7lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPdwFbrxi62EI/DsEGaoFKaTqInDy2tlrXa0tAk9tP8=;
 b=UD8C470KJRAKAsQwAaA8lHAEULrPi/iMmnICCh2ekWpeyL2mQRZKPcBqH2YLe6RrYCeOUwl7ZCMjrxWh3pe/SriouxqLLzSclTUcHZDt0TJxncdMJwpDBuMctkWyUXEgn0vMgaf86h/gp2P/4d5Hk58hLgGPj6MNqLvOnA9ebLbsH2n5dkNGR1rTHurP3HYVJtuuvTrveOpkVEkxqYt6AC6p2zFuUNc1l3ASctBtLsHXEGqOWKbmlfpqsxW3ipiyv17uq3CYpASC5PL6tXEHNQ+dc/TOQaXX/wD0Cx9xZ4jVrPQMLRTS/CDuTF4E8MDOzPQc9QEFM2hflr30YCIscw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPdwFbrxi62EI/DsEGaoFKaTqInDy2tlrXa0tAk9tP8=;
 b=aRECScAawvF6yGSntSoyMxpTBWiRzFTsHdt7qqGZmOs47LEYGwkvNafnRVEW/aTWzXt2VD3cppmQXgHsm/acByG0DXAGWeR24vco4coHIwjJ3Rzwv1ok4ILSgJOWp5OFPhtEVUzeWZOGIgZrtwTA2XuIjos29mM3zK3KOZTneqY=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BY5PR10MB3810.namprd10.prod.outlook.com (2603:10b6:a03:1fb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Tue, 19 Oct
 2021 17:01:49 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::2848:63dc:b87:8021]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::2848:63dc:b87:8021%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 17:01:49 +0000
Subject: Re: [PATCH V2 06/12] virtio_pci: harden MSI-X interrupts
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-7-jasowang@redhat.com>
 <c6641b6a-6204-2b41-e775-ad329314711c@oracle.com>
 <20211015132639-mutt-send-email-mst@kernel.org>
 <CACGkMEujcgMTtLiJWx5ZazVgM5qopB0ZVDkvg6cEuyRGAL31AA@mail.gmail.com>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <c51930a2-3f47-407a-2b1a-fdd1d23ca7c2@oracle.com>
Date: Tue, 19 Oct 2021 10:01:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <CACGkMEujcgMTtLiJWx5ZazVgM5qopB0ZVDkvg6cEuyRGAL31AA@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: SN7PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:806:122::32) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
Received: from [IPv6:2606:b400:400:7444:8000::1b5] (2606:b400:8301:1010::16aa)
 by SN7PR04CA0117.namprd04.prod.outlook.com (2603:10b6:806:122::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Tue, 19 Oct 2021 17:01:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 191bb557-4cf0-4567-c862-08d9932223c5
X-MS-TrafficTypeDiagnostic: BY5PR10MB3810:
X-Microsoft-Antispam-PRVS: <BY5PR10MB381099388CB74CFF88BDCF8EF0BD9@BY5PR10MB3810.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHVvPFuZGRZnovV1FalIGMCGbTzuEj3loVAvgfDywsaIfMfFHgKCCvrugZrqey16L1YrjMBhylBZX8qVKp1JyS2lvbNQNiPcISrPDf/BVO6vMMt2Kpj91bjobQzflwwVJeX3CFllosHFAp6kEl+Mh1LiJ8GZjyyDxbYFY/mQCw6gnICv0y0qW7sBtIvLrmsofoMoSgdZ5qfQN/+T72fkt2SXeU8byvSm6EozKiAap6okM7KNXnHDb2xeeNqyCHlfJxbEqHDNCo0IhVzrCgWR7lm6Jxmju2/pImY7Yi/z48srw4XXnilHzejitMSODS9BMgIJ0BxEEr3Ns1kGaRYHNIktpMD4M5lUxKf2dX1gtn15tz7RCoEWOtQOVE0rdn0O25MYwNXnRoaRERvzQnC/t55iU7ofPpDJqUOyjyQZwG/RU3EDf/prWraLvTmUCGMV1LxOD6nTwLLN9YUhAPBGbuRkSSUrlQnVKTRAQWkGD1UFg7w5ghOus0TxnhNGaiTXy6lbWtKv3sEjVp3X4bGKWj8Kn+4HEqA219KIGK79jVsrTtdo0Yjc602IYwNtBcnYaX1ZJDd83ohP5OhOelP7WVkYZ7hdQgmAD3mcBl4OiIDDjmSp5PkFi5Sn1GLRk8nHq/Kj/eNUozrVeB1J5oAxheJrFBtbrX3fC7BmLvB2XpK932uEHm5KGT0xdyMvFQAwoTl1yuNJMvv6nz2d8RtFCP5jGPZ5WuFJyXhrV0IQbTU4ps7dgg5J5exKJFepqLut
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2663.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(38100700002)(110136005)(186003)(44832011)(6486002)(66476007)(54906003)(83380400001)(2616005)(66556008)(66946007)(316002)(508600001)(53546011)(5660300002)(4326008)(2906002)(31696002)(8936002)(8676002)(86362001)(30864003)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVc5clFhNFFvK3NpMWY1dEYrdUpGYk9OQUtLMzcvMHlXMllmNWtabUFFT01u?=
 =?utf-8?B?RVlJY3lIclJJNGtxL3JXQ0tsaUMxbFVvWlFTVWh0L2swNjlIbm1GVkJsSlpw?=
 =?utf-8?B?dkhqNU4yQ2toQ2Rma0pUSzIxdmE4MnRPRmJzSzFLcEpYckU4aUlXNS9tTmV6?=
 =?utf-8?B?RGNtN29nTFZVYkVQbWVjMEgwZS85QUVqUGZKL0VWTU0xbzJHYW1VOWRLY2gw?=
 =?utf-8?B?eWJFcWEyRDFJbnRDS3V4L0EvQ21EbG5rRFhTMUN1Wk1JNzJFd3A0bW40d3R0?=
 =?utf-8?B?R1k4QzBMdjBVOCtySWVqVnlVcWZGRDlrdW9MY1pnRGlxTiswUmNXaVVNa2lB?=
 =?utf-8?B?SjJZTkMxUmFLQzIycTVDOGRaNStJYVBNWkhNZGluSTFWRUQ0MnlDaEdROFpn?=
 =?utf-8?B?UDFIbzRFb0RscnRNb1FxR1p1aDhHVnk3WlNQWFpYcEIrMUpydFFqTGlQenZu?=
 =?utf-8?B?aFpsRkU0VkV4ZFFvT29WNjFlMEUraVkzTUVuSVQ3c3FmODV2RnZ0cVpxTjl1?=
 =?utf-8?B?dHBVd1JQeWZqUFRLMzB5SGF6NThNL0ppbnhkcGhMMzZiT1BGY1F5L0hrTFg1?=
 =?utf-8?B?anRieEpKemxHVkx6MW03RUZMaG5Vai9GcVpFdkhxWWhRUk1oT1FEYnl5cldx?=
 =?utf-8?B?N0syRzRrNVpLQkFKRC9oZUprZTlOMzExOW5yb2pPOGRBUnNNTk01ZEY4eUJn?=
 =?utf-8?B?eFJQVTVCOWl0dEZRaHN4T1VpZnBMRmxDaUFCZWUxT1B5R0ZuS0pJL0pTTmV3?=
 =?utf-8?B?elFhMGJrVG9NY1FJMW1LYjRzRFFwZXI0UHZiUlFmRHBnVzFaZlY5c2JSWGho?=
 =?utf-8?B?WSs2VDlYeDdTL0NYMVFBbHVuNDRqT0lZR1NFMHk1UmVEMzdlT2RHSlk1d05Q?=
 =?utf-8?B?cDlZWUtLK3NQMkIxaHdUL2VTdUowSGNtZ1dKUXZFZ255bHdFcWJJT1VWNUt4?=
 =?utf-8?B?NFZFWkkwdFhSTFZXU3dvK0NpZytCRk0zbmY0K0lxQmEzdGNadjhjUllPNzhp?=
 =?utf-8?B?ckRmY2Rtdk9GRmRzbjU4R2g2UEVQejRSNy9JWDdIcTI1bXFNT29ET0Iyem5j?=
 =?utf-8?B?d3NObWU1TUF2dndOTHdpSW5KS0hmUGh6OEJkcGRlczFBS3Vad01vZGZTeTQy?=
 =?utf-8?B?a2c0U3pLUFg3UmwvVzZWbWJoMWNNVGJzdmI4SUxBVG1lWUhSR3ViMjdIUnR2?=
 =?utf-8?B?WTA5ZzVhTHVBbTRDNVRKUGdvWkw2dEEwcGhjNnBPZXJmYk9GSmNXcno4TU9O?=
 =?utf-8?B?V0FYQlhhT2RuUWZRSmxUQm9wRXYxZWdQeXQ3NmFyTElUaVFoYzNyNkVxM3o0?=
 =?utf-8?B?YVBWR3RXRk5Zczl0TGdmZnpKVXJ2U2JiZ0pYUTBlWjJ4NFlETHhxTExSUURm?=
 =?utf-8?B?ZW9lTHFDcFBNRGo1TlRmQ3M2cEpQY2J2Wkh6MnRkcS84YlU3eUdPSFMramMw?=
 =?utf-8?B?Z0x5dENSMnZlVURyWTM4Ym5tZVdsQXR2TlVFMDYwZktIMytuWFhaeEVSWFoy?=
 =?utf-8?B?eHZOMEF0UXpuS1N3QkVBY1MxYndETC9pbGRUR1VnK2kyZ1BJUy8zUG96QXI1?=
 =?utf-8?B?WjVxU3A5K0pTSmRnRmdVT3U0QXRjLy9POE1ER3VPMVRIdXpOSlRFWGhESEZk?=
 =?utf-8?B?MmpjWm1OUk85OEV3SWIvNXI0dUQ3N1p3S0o5MkxTRlFJYWtEZnRmbldmUHoy?=
 =?utf-8?B?d3hzOWNjSVBVM0czVXI0L0pZeVF1YTJGR0NpOVFiR3hUdEFPME90MUd5Ritj?=
 =?utf-8?B?TEN1OFBmN1hjR3IyVVJRQ2M1bDk1aCt0QXY1cnRiT1AwRUtOZjNZZ3FOeEVF?=
 =?utf-8?B?ck9hWDMydE5HdUFCVUVSaHhHeENlNFFLZEd2WDRsQVRPVFhNaUt2Y0ZCdXpP?=
 =?utf-8?B?WU5mbFZCYXNxV1QvSEttdjNOVkpZajBHMVpxNEFSb0pFK3UxT3ZEMFllcklj?=
 =?utf-8?B?Um1ZSXozWUFLT2FiQ3VYeGdxYjJWYjBOSEdGc0cwa05nSTBCLzFLMU53U041?=
 =?utf-8?B?VWVrUEdPaW9MSTM3dm5lT0dBQlR2NDI5bXJEOFk3L3ZMQzltemVQbmF2bm9u?=
 =?utf-8?B?UTZEQ3dKalZEVUhnM2V0aUlyYTVqTjg1d0MwT2hFNDRYQkdOR1dHaE4ybjBl?=
 =?utf-8?B?bVpOQzNVdjhFdDcrY1lKYzRwUUs4emRxSGp2clhuU2ZKUGFrR2RKc0g3NWdH?=
 =?utf-8?B?ckh0Y3NjQjQyOHJLSzlreUI3QVdYSng5VWN5anM2cStCYVFNb1BmSWw0NDFJ?=
 =?utf-8?B?YktrZlUvdHJCQ01PbndRYVdKS3dRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191bb557-4cf0-4567-c862-08d9932223c5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 17:01:49.0000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3SdhdP1djwfp4z3m/slHd5La+0vrF1sJtxbB1PM6V2tvl6bJofEwshiJmNi5ABnJwBBC95zVldC3VXgLmqtbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3810
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10142
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110190100
X-Proofpoint-ORIG-GUID: VK2FjG6dbocBMXmfpQAAD4fwpl-9Bua_
X-Proofpoint-GUID: VK2FjG6dbocBMXmfpQAAD4fwpl-9Bua_
Cc: "Paul E . McKenney" <paulmck@kernel.org>, "kaplan,
 david" <david.kaplan@amd.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
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



On 10/18/21 6:33 PM, Jason Wang wrote:
> On Sat, Oct 16, 2021 at 1:27 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Fri, Oct 15, 2021 at 05:09:38AM -0700, Dongli Zhang wrote:
>>> Hi Jason,
>>>
>>> On 10/11/21 11:52 PM, Jason Wang wrote:
>>>> We used to synchronize pending MSI-X irq handlers via
>>>> synchronize_irq(), this may not work for the untrusted device which
>>>> may keep sending interrupts after reset which may lead unexpected
>>>> results. Similarly, we should not enable MSI-X interrupt until the
>>>
>>> About "unexpected results", while you mentioned below in v1 ...
>>>
>>> "My understanding is that e.g in the case of SEV/TDX we don't trust the
>>> hypervisor. So the hypervisor can keep sending interrupts even if the
>>> device is reset. The guest can only trust its own software interrupt
>>> management logic to avoid call virtio callback in this case."
>>>
>>> .. and you also mentioned to avoid the panic (due to untrusted device) in as
>>> many scenarios as possible.
>>>
>>>
>>> Here is my understanding.
>>>
>>> The reason we do not trust hypervisor is to protect (1) data/code privacy for
>>> most of times and sometimes (2) program execution integrity.
>>>
>>> The bad thing is: the hypervisor is able to panic/destroy the VM in the worst case.
>>>
>>> It is reasonable to re-configure/recover if we assume there is BUG at
>>> hypervisor/device side. That is, the hypervisor/device is buggy, but not malicious.
>>>
>>> However, how about to just detect and report the hypervisor/device is malicious
>>> and shutdown/panic the VM immediately? If we have detected the malicious
>>> hypervisor, we should avoid running VMs on the malicious hypervisor further. At
>>> least how about to print error message to reminder users that the hypervisor is
>>> malicious?
> 
> I understand your point, but several questions needs to be answered:
> 
> 1) how can we easily differentiate "malicious" from "buggy"?
> 2) If we want to detect malicious hypervisor, virtio is not the only
> place that we want to do this
> 3) Is there a way that "malicious" hypervisor can prevent guest from
> shutting down itself?
> 
>>>
>>>
>>> About "unexpected results", it should not be hang/panic. I suggest ...
>>>
> 
> It's just the phenomenon not the logic behind that. It could be e.g
> OOB which may lead the unexpected kernel codes to be executed in
> unexpected ways (e.g mark the page as shared or go with IOTLB etc).
> Sometimes we can see panic finally but it's not always.

This is what I was trying to explain.

The objective is to protect "data privacy" (or code execution integrity in some
case), but not to prevent DoS attack. That is, the 'malicious' hypervisor should
not be able to derive VM data privacy.

Suppose the hypervisor did something buggy/malicious when SEV/TDX is used by VM,
the "unexpected results" should never reveal secure/private data to the hypervisor.

In my own opinion, the threat model is:

Attacker: 'malicious' hypervisor

Victim: VM with SEV/TDX/SGX

The attacker should not be able to steal secure/private data from VM, when the
hypervisor's action is unexpected. DoS is out of the scope.

My concern is: it is very hard to clearly explain in the patchset how the
hypervisor is able to steal VM's data, by setting queue=0 or injecting unwanted
interrupts to VM.

Thank you very much!

Dongli Zhang

> 
>>> Assuming SEV/TDX is involved, the hypervisor should never be able to derive the
>>> VM privacy (at least secure memory data) by providing malicious configuration,
>>> e.g., num_queues=0.
> 
> Yes.
> 
>>> If we detect hypervisor is malicious, the VM is
>>> panic/shutdown immediately.
> 
> This seems to enforce the policy into the kernel, we need to leave
> this to userspace to decide.
> 
>>> At least how about to print error message to
>>> reminder users.
> 
> This is fine.
> 
>>>
>>>
>>> BTW, while I always do care about the loss of interrupt issue, the malicious
>>> device is able to hang a VM by dropping a single interrupt on purpose for
>>> virtio-scsi :)
>>>
> 
> Right.
> 
>>>
>>> Thank you very much!
>>
>>
>> Can't say I understand what it's about. TDX does not protect against
>> hypervisor DoS attacks.
> 
> Yes, I think what Dongli wants to discuss is how to behave if we
> detect a malicious hypervisor. He suggested a shutdown instead of
> failing the probe.
> 
> Thanks
> 
>>
>>> Dongli Zhang
>>>
>>>> device is ready. So this patch fixes those two issues by:
>>>>
>>>> 1) switching to use disable_irq() to prevent the virtio interrupt
>>>>    handlers to be called after the device is reset.
>>>> 2) using IRQF_NO_AUTOEN and enable the MSI-X irq during .ready()
>>>>
>>>> This can make sure the virtio interrupt handler won't be called before
>>>> virtio_device_ready() and after reset.
>>>>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Cc: Paul E. McKenney <paulmck@kernel.org>
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>> ---
>>>>  drivers/virtio/virtio_pci_common.c | 27 +++++++++++++++++++++------
>>>>  drivers/virtio/virtio_pci_common.h |  6 ++++--
>>>>  drivers/virtio/virtio_pci_legacy.c |  5 +++--
>>>>  drivers/virtio/virtio_pci_modern.c |  6 ++++--
>>>>  4 files changed, 32 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
>>>> index b35bb2d57f62..0b9523e6dd39 100644
>>>> --- a/drivers/virtio/virtio_pci_common.c
>>>> +++ b/drivers/virtio/virtio_pci_common.c
>>>> @@ -24,8 +24,8 @@ MODULE_PARM_DESC(force_legacy,
>>>>              "Force legacy mode for transitional virtio 1 devices");
>>>>  #endif
>>>>
>>>> -/* wait for pending irq handlers */
>>>> -void vp_synchronize_vectors(struct virtio_device *vdev)
>>>> +/* disable irq handlers */
>>>> +void vp_disable_vectors(struct virtio_device *vdev)
>>>>  {
>>>>     struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>>>>     int i;
>>>> @@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
>>>>             synchronize_irq(vp_dev->pci_dev->irq);
>>>>
>>>>     for (i = 0; i < vp_dev->msix_vectors; ++i)
>>>> -           synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
>>>> +           disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
>>>> +}
>>>> +
>>>> +/* enable irq handlers */
>>>> +void vp_enable_vectors(struct virtio_device *vdev)
>>>> +{
>>>> +   struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>>>> +   int i;
>>>> +
>>>> +   if (vp_dev->intx_enabled)
>>>> +           return;
>>>> +
>>>> +   for (i = 0; i < vp_dev->msix_vectors; ++i)
>>>> +           enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
>>>>  }
>>>>
>>>>  /* the notify function used when creating a virt queue */
>>>> @@ -141,7 +154,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
>>>>     snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
>>>>              "%s-config", name);
>>>>     err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
>>>> -                     vp_config_changed, 0, vp_dev->msix_names[v],
>>>> +                     vp_config_changed, IRQF_NO_AUTOEN,
>>>> +                     vp_dev->msix_names[v],
>>>>                       vp_dev);
>>>>     if (err)
>>>>             goto error;
>>>> @@ -160,7 +174,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
>>>>             snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
>>>>                      "%s-virtqueues", name);
>>>>             err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
>>>> -                             vp_vring_interrupt, 0, vp_dev->msix_names[v],
>>>> +                             vp_vring_interrupt, IRQF_NO_AUTOEN,
>>>> +                             vp_dev->msix_names[v],
>>>>                               vp_dev);
>>>>             if (err)
>>>>                     goto error;
>>>> @@ -337,7 +352,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
>>>>                      "%s-%s",
>>>>                      dev_name(&vp_dev->vdev.dev), names[i]);
>>>>             err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
>>>> -                             vring_interrupt, 0,
>>>> +                             vring_interrupt, IRQF_NO_AUTOEN,
>>>>                               vp_dev->msix_names[msix_vec],
>>>>                               vqs[i]);
>>>>             if (err)
>>>> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
>>>> index beec047a8f8d..a235ce9ff6a5 100644
>>>> --- a/drivers/virtio/virtio_pci_common.h
>>>> +++ b/drivers/virtio/virtio_pci_common.h
>>>> @@ -102,8 +102,10 @@ static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
>>>>     return container_of(vdev, struct virtio_pci_device, vdev);
>>>>  }
>>>>
>>>> -/* wait for pending irq handlers */
>>>> -void vp_synchronize_vectors(struct virtio_device *vdev);
>>>> +/* disable irq handlers */
>>>> +void vp_disable_vectors(struct virtio_device *vdev);
>>>> +/* enable irq handlers */
>>>> +void vp_enable_vectors(struct virtio_device *vdev);
>>>>  /* the notify function used when creating a virt queue */
>>>>  bool vp_notify(struct virtqueue *vq);
>>>>  /* the config->del_vqs() implementation */
>>>> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
>>>> index d62e9835aeec..bdf6bc667ab5 100644
>>>> --- a/drivers/virtio/virtio_pci_legacy.c
>>>> +++ b/drivers/virtio/virtio_pci_legacy.c
>>>> @@ -97,8 +97,8 @@ static void vp_reset(struct virtio_device *vdev)
>>>>     /* Flush out the status write, and flush in device writes,
>>>>      * including MSi-X interrupts, if any. */
>>>>     ioread8(vp_dev->ioaddr + VIRTIO_PCI_STATUS);
>>>> -   /* Flush pending VQ/configuration callbacks. */
>>>> -   vp_synchronize_vectors(vdev);
>>>> +   /* Disable VQ/configuration callbacks. */
>>>> +   vp_disable_vectors(vdev);
>>>>  }
>>>>
>>>>  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
>>>> @@ -194,6 +194,7 @@ static void del_vq(struct virtio_pci_vq_info *info)
>>>>  }
>>>>
>>>>  static const struct virtio_config_ops virtio_pci_config_ops = {
>>>> +   .ready          = vp_enable_vectors,
>>>>     .get            = vp_get,
>>>>     .set            = vp_set,
>>>>     .get_status     = vp_get_status,
>>>> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
>>>> index 30654d3a0b41..acf0f6b6381d 100644
>>>> --- a/drivers/virtio/virtio_pci_modern.c
>>>> +++ b/drivers/virtio/virtio_pci_modern.c
>>>> @@ -172,8 +172,8 @@ static void vp_reset(struct virtio_device *vdev)
>>>>      */
>>>>     while (vp_modern_get_status(mdev))
>>>>             msleep(1);
>>>> -   /* Flush pending VQ/configuration callbacks. */
>>>> -   vp_synchronize_vectors(vdev);
>>>> +   /* Disable VQ/configuration callbacks. */
>>>> +   vp_disable_vectors(vdev);
>>>>  }
>>>>
>>>>  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
>>>> @@ -380,6 +380,7 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
>>>>  }
>>>>
>>>>  static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>>>> +   .ready          = vp_enable_vectors,
>>>>     .get            = NULL,
>>>>     .set            = NULL,
>>>>     .generation     = vp_generation,
>>>> @@ -397,6 +398,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>>>>  };
>>>>
>>>>  static const struct virtio_config_ops virtio_pci_config_ops = {
>>>> +   .ready          = vp_enable_vectors,
>>>>     .get            = vp_get,
>>>>     .set            = vp_set,
>>>>     .generation     = vp_generation,
>>>>
>>
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
