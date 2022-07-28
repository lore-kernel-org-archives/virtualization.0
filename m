Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF427C04A68
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 22:12:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 62916405CE;
	Thu, 28 Jul 2022 22:12:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 62916405CE
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=NZJo6HDB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=aQSb0nNX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EJSRy9qBz8N7; Thu, 28 Jul 2022 22:12:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 48806400DB;
	Thu, 28 Jul 2022 22:12:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 48806400DB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1615BC0035;
	Thu, 28 Jul 2022 22:12:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD444C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 22:12:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8FFB582F87
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 22:12:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8FFB582F87
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=NZJo6HDB; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=aQSb0nNX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zj_6RooGcY2z
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 22:12:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B283482F76
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B283482F76
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 22:12:17 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SKIxUV009598;
 Thu, 28 Jul 2022 22:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=a0XWmn+c7INafZGtHv80lNY/Smc/DDMauasaH9K+O9A=;
 b=NZJo6HDBqQLjnwWTt6FtRA2UBWk+9Lg74NdODPlBDw1ODzPAHoRDX9bQvcWLujBh1ARP
 B/RYinzllnJqEUlH7y4HfxWydtU0vkzPj9moBZFF7q7OY5tZgxuy27mHxEwxA8dVu3Gr
 WzRw8k3ZR6F44zkFswhZxAnCq+O2yXxsmfe0YgAiHSCNyXGKBKfVF3drDSqD7eOhsayP
 A88lmDMltVlVsiyX7gju/RTbWb6BQdeQbjoGren5Uxa7P14THTMpIDesj/Bf1UG4XcTB
 Rhn5E6j79CqzNtjOcTPCzAtOUQFtBiDE2Vh7+Kcf+PzkK/J1x6+c8i3huMpai52bpAIz eA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg940wgpv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Jul 2022 22:12:13 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 26SLuwui023012; Thu, 28 Jul 2022 22:12:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hh5yy08b9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Jul 2022 22:12:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUPzrfFdaJ/RnX+Xt9Plo2ptqgmoejvFV4n8K6Z3dI2xc2dkZUCDR04tPgyxu9puvnMbWfuyD40nQLvQoMGigzM5AtvToVxIDPkYnpq3+K32VV3X8u02tFIoXKB0Xpy6jMbGrgcYr9dYw9odBgNC5I52zD0TsNLUKYga/RWlRl+gsNgWEQ24W5m/zAXBqIgMXPooczLZ9U4tQi3K5ygWP1IwwjjGRYcRRhWjIJMl392oxZ/7KPEuLyA9leVXkdpsqBsiqtPfolkCv7ufUiOiwF1JN2orsxf6162DXmsHTnSkt17IM1/amASR0YlJ0mRzRucXAsIA3XHtNQxGU49n9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0XWmn+c7INafZGtHv80lNY/Smc/DDMauasaH9K+O9A=;
 b=QfDFvi10fx0o33ThA3seq3lTRAdqRaVr+tLmycujbEl43n96dEeDrBn5iMEN+mbfZnNisYdVpWLBVV+jCGpgTbcUAOe5DbmpJ5XjopQTy9sk4JoQLe7Oq0lwQTBT1ZIRoCgQfTA7/UQMgvB6kzxXQaCnL38iJzg2Ib3VYyRoWsge3iR6fUc5EGYi74Fxb4Zb22rYCTUJPbm2HFpaP8kga1rcR7ii0dH0iGHwMGQmegxVmGm9g+vrGb36ImrPvECeIvRCsIgukSX+xY/HRotiLH5BZ2LzhJN5DzEcNGPHQJ3bapW3VBH30G7CU1cy0mU0O9qK48Awof5GXpTVaCreQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0XWmn+c7INafZGtHv80lNY/Smc/DDMauasaH9K+O9A=;
 b=aQSb0nNXxI5029WLhhRAQwBcIlCylsMY8yWP2zNPBsLQw+Beqq4ZrZPYddUvLge2t/oBdeYly8C/3RJAtGbWR5T74+xtT1S3fZwrEm03oJf6hy5zf26egkWfzKJXi5mqECy2pOx1IcZK77Lpa/IKQBRSxJwWxkXLi0tPfb015zk=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by DM5PR1001MB2347.namprd10.prod.outlook.com (2603:10b6:4:2e::38)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 22:12:10 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c846:d8e4:8631:9803]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c846:d8e4:8631:9803%4]) with mapi id 15.20.5458.026; Thu, 28 Jul 2022
 22:12:10 +0000
Message-ID: <65f1ae9b-9bc7-8ddc-337c-0ca5fa328131@oracle.com>
Date: Thu, 28 Jul 2022 15:12:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 4/6] vDPA: !FEATURES_OK should not block querying
 device config space
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-5-lingshan.zhu@intel.com>
 <PH0PR12MB548190DE76CC64E56DA2DF13DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <00889067-50ac-d2cd-675f-748f171e5c83@oracle.com>
 <63242254-ba84-6810-dad8-34f900b97f2f@intel.com>
 <8002554a-a77c-7b25-8f99-8d68248a741d@oracle.com>
 <c8bd5396-84f2-e782-79d7-f493aca95781@redhat.com>
 <f3fd203d-a3ad-4c36-ddbc-01f061f4f99e@oracle.com>
 <20220728070409-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220728070409-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SA9P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::30) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9478e3c-d054-48b4-d3e5-08da70e63786
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2347:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MHuDABUoKXkLR5l095E0KbwXeyDeqqaIZCwwkY7zcoqM6WTGGeYmiTT03GDhrXQXUVn6FCKtk2g0q51upNPuJn7tW5Qzrk7vKTbkj5KJ1aEqQNaHiBQ1L+FeLEmVGtUVzJJ6Mtfh4ujRFd7+i7nSo2WvE7yBRUjmXdzlI3Z/g3JWAFZ80j5o58mljrcMhGXWATv9ZIDjuQTuv6f1r9IjUk8N1cP9RwtWNnLQOsvQN7c8+EmGIPocRqGYowkmdGAFkCCOatZ1Of7ea1n6dIR2Q6Ld2U2+MroSWmz5TC0pgnLA3rYtsuXCYNH0NIYoGTGS2c7KSSuztJW25RqGiXXhceBvAimwwRTjTLRMx1wObQCWgL5mzrIvtwjNpbAB8FDDoGw8fKz5Lq4NgGT/6ggHYhbW23rgfn4msAGqR6bK5CsF/0xyYj1Bee6DQztCdThGvF7JW244Qp7HxAF8t435cFX4VXQDYS2L5kYO2pTso1KLb83VRV3CK4eFh3vtCUi991huRdOuEdowbO+ylZRFnyMXvm/SNuFPHPbbnsAXpjJzMXSuiQns5q3mrj8oSzhWQCUk3xuM8EthaBuJZvn7Sc6Orv0/s/b4jjvIl15TEdWBQnFdPxa9OyyT7Gz1mNcdJ34B4autl4M5jWheZfn/X7ll4jg20Lcu4Zx2+Emie3blQXdfK94JKs14fwlEy9N8D9+ixdvgcfmOsa92bwyV9E5RK9gmlG71FiG2Zat/BUi2sx9YQhA+Ng+kZqrkzSlSKmDKvyeabPof1ehpeWjYzxWdJwayTInh2Ajy/D9rOx/YXrn/KF30am1BzyF/VxyoUUsjM40M5VF4GIdibMRcvz7WWnQjkfJF3H8LgQ693Gs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(346002)(376002)(39860400002)(136003)(366004)(396003)(186003)(53546011)(2616005)(36916002)(26005)(6512007)(30864003)(6506007)(38100700002)(5660300002)(2906002)(8936002)(966005)(4326008)(66476007)(54906003)(6666004)(83380400001)(8676002)(41300700001)(36756003)(6486002)(478600001)(6916009)(66946007)(66556008)(31696002)(316002)(31686004)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHFpK2xjS2ZjamtQdFBFRzZ0VlJZYkt0dWxjTlhWek40VldEZWJ2Zkk4YkJP?=
 =?utf-8?B?SEJXSnNObk9ZVUQ5WUdMNXJxY0Ntd1FqYThJblo1cUZqZ0JiM2QwaEF1U0RM?=
 =?utf-8?B?NktPbmM5UUxTbHNraGNLenc5UUhIdVdoOXNucFBINXk3azVQZzVkWnpGRXVM?=
 =?utf-8?B?dzVtdGdMWDRWVTR5OXAxVmIzNGF2ekpnbXNDa0kzWmVWM2NRNEhWbGdzQzZX?=
 =?utf-8?B?eUdNVlNUYlRYSzNsZ2IxdHRBdlYyWHpLNHYyUVE1Y1ZaWFJZUG5YSmF5Q2N6?=
 =?utf-8?B?b2JGSFNJajhXYXREU2x2WVpyY1pQN3lyRnkzZWVmcnhjd2psKzZWeUgxSml1?=
 =?utf-8?B?VlBmTHV1Q3Zjb3VFaXd1OWlCYy91MnYvSHYyY1J3SjJUbEgxZ0grelE4b0do?=
 =?utf-8?B?ZHBHZUNpcGV1VXV0dWtJcU5RcEt1ZitoWk5SMjdJRkIxN2F1Y0JERGpjbi9Z?=
 =?utf-8?B?VHZhMUZOU05RSTBBR0p1b2JDMUdrQVZ3Z1dsNWU1RjhIaklKMTRxb1paUlNw?=
 =?utf-8?B?UUR3cFJyK0NRdFdhaVdRa3dPbW5JdmxkRk9IdjJFb1FWSVdwamJKOUxjN3Vx?=
 =?utf-8?B?czdPK3Y0WjJ3Y2k0SGw3K085Qm9iaUUzS2NvZjRiRzA0RzczY0NVR0pBem1G?=
 =?utf-8?B?WEZZSGxJQnhGNmxBOVA3bDNOSXhUbGhZeTQ0MVlFaFB5c1gvVHlhQlVmMlpW?=
 =?utf-8?B?bzNJdTBlbFNPL2phZ29QYjFSQmRtT2Z4aW9FOUIvcUpPSGRUVmxDSDNCUzZu?=
 =?utf-8?B?dWF5VlhVdk1wU1Q0TWFJc1MxVmVncDhhd0N4TjF5VVczRFpSbHArOEF0b3lz?=
 =?utf-8?B?YnNtZytuc3hOUXIwTUVLMUQwaWdGZ1lCelRWSzhJRHlzQzdreFN0aWNRbFQ4?=
 =?utf-8?B?S29tVUxRRmdYWVo2eW4rNjlVVndsT0FWbUg1eHdMbUZ5VXBxTkc4VzVKYU00?=
 =?utf-8?B?OE42TlVQK1ozaW5LRU5LSGRCZ2pYUXUvT3lYbnhHY2s1NHJ5cTVnRTBwYjlB?=
 =?utf-8?B?cFZvSUtWNWhTRXBHVTA0dC9zWHNRaEVXQmpSYjFnSFNTT2RxTkJMWjNMNDFE?=
 =?utf-8?B?Ny90Z2RhTk92RHNkUGFaRzBMeFBOditoNnRBNjBMYUJybXZvTUg2UW9ZTGdY?=
 =?utf-8?B?NmRpUUJnRHNXWGxMRHdSWC9nZURVeXBSRE1oWk5qSitaVEhOTXlUeTk3ejlY?=
 =?utf-8?B?VnVxZzVTcm9WYm55cFBQSWkyVGR0WU01NmNVODZ2cjBzb1QxUDNEcWhCbFIv?=
 =?utf-8?B?aHB4TUpqeWJsT25adi9FWUxkcEJxUjZJcDRLclU0YmYzMWMzenJvci8vNkZH?=
 =?utf-8?B?bmdyZDgvN05vdE0zNXBaWGFmbUhOWEVxRWo2WTJPMmx2QUJ0RDVwRzAzZkZy?=
 =?utf-8?B?N2FBOTZaWHdYN0RQR3FtWnU0WC9KajRvZHhzY014MUJNTjYwYkdQck5kWnAz?=
 =?utf-8?B?TnY2SnphSnZKYjdWdlo5ZktqREhoaXBVbUJKNHhFTmd2V096UVJzMkNUUDQ2?=
 =?utf-8?B?dWpER3JXWGI4dnMzTXJzd2sycGxDdUhEellSbVEyQkNwTzFDYjEraGUxOWtw?=
 =?utf-8?B?cnVJa0JPbTNKL3RmK01QN01FRUoyelE4UVF2N1lQZGh6eTJqVG5SYXgreTRn?=
 =?utf-8?B?TnBVcm5NU1R2cDJHTWNGOTJGd2hOQXdiRlZ5d2Y3OHBmMnRiejQzdEt6NWds?=
 =?utf-8?B?dWsyZUxVTFJLYklZM3RaNXc5Tm00OFA5c2NFZmpzUERoSm4zaEI2dk5pNHpr?=
 =?utf-8?B?ZXJwemFXdXEyZWdVajNTMjB4VVJIQ3E5eTJqRnNmWnRuZ2pOekJGYXNzYmEv?=
 =?utf-8?B?c3VvVXlmS3RuZVJhMmZnY21KbkZHWnVNUWUxSFo5V1BkcitsbEh4OU50N2I5?=
 =?utf-8?B?OG0yZEdaeXRERFEzTzg3V2ZSSCtObDJTS2JTa0lEaGtsaVhDWTN1cHBxckNk?=
 =?utf-8?B?NE9vbjc3NFlTNmxFOE1WbXUzMlZ5YWJqN3dJUS9OT3V4dDM2QklxQ3VqaFBa?=
 =?utf-8?B?OW9JNUppMzF1Tm13ZGlIaVEvYlR6VUQvckRpY2NLa2pVUHNBajNkUjgvNnBC?=
 =?utf-8?B?RXF1YXdqc0VQRFg4Z01zRVhSdWp5eDNJenpOYVVnQzJ6OXBENk9rcWNMdTlu?=
 =?utf-8?Q?PGqrXzUkPjzt7xr8QR6QqUSsM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9478e3c-d054-48b4-d3e5-08da70e63786
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 22:12:10.4593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aaTeSbKQGfTuPWysO3LYXQgNp7xLvEyQ1ADQxWqwet3ZESX3a+8fouIbs6TOFjLW3U137EBy5sa9WLiQheD4kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280099
X-Proofpoint-GUID: LGopwkBm7DTc0kNXxBdsGXRSAzGieteL
X-Proofpoint-ORIG-GUID: LGopwkBm7DTc0kNXxBdsGXRSAzGieteL
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>, Eli Cohen <elic@nvidia.com>
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

CgpPbiA3LzI4LzIwMjIgNDozNSBBTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9uIFRo
dSwgSnVsIDI4LCAyMDIyIGF0IDEyOjA4OjUzQU0gLTA3MDAsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+
Cj4+IE9uIDcvMjcvMjAyMiA3OjA2IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4g5ZyoIDIwMjIv
Ny8yOCAwODo1NiwgU2ktV2VpIExpdSDlhpnpgZM6Cj4+Pj4KPj4+PiBPbiA3LzI3LzIwMjIgNDo0
NyBBTSwgWmh1LCBMaW5nc2hhbiB3cm90ZToKPj4+Pj4KPj4+Pj4gT24gNy8yNy8yMDIyIDU6NDMg
UE0sIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pj4+PiBTb3JyeSB0byBjaGltZSBpbiBsYXRlIGluIHRo
ZSBnYW1lLiBGb3Igc29tZSByZWFzb24gSQo+Pj4+Pj4gY291bGRuJ3QgZ2V0IHRvIG1vc3QgZW1h
aWxzIGZvciB0aGlzIGRpc2N1c3Npb24gKEkgb25seQo+Pj4+Pj4gc3Vic2NyaWJlZCB0byB0aGUg
dmlydHVhbGl6YXRpb24gbGlzdCksIHdoaWxlIEkgd2FzIHRha2luZwo+Pj4+Pj4gb2ZmIGFtb25n
c3QgdGhlIHBhc3QgZmV3IHdlZWtzLgo+Pj4+Pj4KPj4+Pj4+IEl0IGxvb2tzIHRvIG1lIHRoaXMg
cGF0Y2ggaXMgaW5jb21wbGV0ZS4gTm90ZWQgZG93biB0aGUgd2F5Cj4+Pj4+PiBpbiB2ZHBhX2Rl
dl9uZXRfY29uZmlnX2ZpbGwoKSwgd2UgaGF2ZSB0aGUgZm9sbG93aW5nOgo+Pj4+Pj4gIMKgwqDC
oMKgwqDCoMKgwqAgZmVhdHVyZXMgPSB2ZGV2LT5jb25maWctPmdldF9kcml2ZXJfZmVhdHVyZXMo
dmRldik7Cj4+Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoCBpZiAobmxhX3B1dF91NjRfNjRiaXQobXNn
LAo+Pj4+Pj4gVkRQQV9BVFRSX0RFVl9ORUdPVElBVEVEX0ZFQVRVUkVTLCBmZWF0dXJlcywKPj4+
Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgVkRQQV9BVFRSX1BBRCkpCj4+Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIC1FTVNHU0laRTsKPj4+Pj4+Cj4+Pj4+PiBNYWtpbmcgY2FsbCB0byAu
Z2V0X2RyaXZlcl9mZWF0dXJlcygpIGRvZXNuJ3QgbWFrZSBzZW5zZQo+Pj4+Pj4gd2hlbiBmZWF0
dXJlIG5lZ290aWF0aW9uIGlzbid0IGNvbXBsZXRlLiBOZWl0aGVyIHNob3VsZAo+Pj4+Pj4gcHJl
c2VudCBuZWdvdGlhdGVkX2ZlYXR1cmVzIHRvIHVzZXJzcGFjZSBiZWZvcmUgbmVnb3RpYXRpb24K
Pj4+Pj4+IGlzIGRvbmUuCj4+Pj4+Pgo+Pj4+Pj4gU2ltaWxhcmx5LCBtYXhfdnFwIHRocm91Z2gg
dmRwYV9kZXZfbmV0X21xX2NvbmZpZ19maWxsKCkKPj4+Pj4+IHByb2JhYmx5IHNob3VsZCBub3Qg
c2hvdyBiZWZvcmUgbmVnb3RpYXRpb24gaXMgZG9uZSAtIGl0Cj4+Pj4+PiBkZXBlbmRzIG9uIGRy
aXZlciBmZWF0dXJlcyBuZWdvdGlhdGVkLgo+Pj4+PiBJIGhhdmUgYW5vdGhlciBwYXRjaCBpbiB0
aGlzIHNlcmllcyBpbnRyb2R1Y2VzIGRldmljZV9mZWF0dXJlcwo+Pj4+PiBhbmQgd2lsbCByZXBv
cnQgZGV2aWNlX2ZlYXR1cmVzIHRvIHRoZSB1c2Vyc3BhY2UgZXZlbiBmZWF0dXJlcwo+Pj4+PiBu
ZWdvdGlhdGlvbiBub3QgZG9uZS4gQmVjYXVzZSB0aGUgc3BlYyBzYXlzIHdlIHNob3VsZCBhbGxv
dwo+Pj4+PiBkcml2ZXIgYWNjZXNzIHRoZSBjb25maWcgc3BhY2UgYmVmb3JlIEZFQVRVUkVTX09L
Lgo+Pj4+IFRoZSBjb25maWcgc3BhY2UgY2FuIGJlIGFjY2Vzc2VkIGJ5IGd1ZXN0IGJlZm9yZSBm
ZWF0dXJlc19vayBkb2Vzbid0Cj4+Pj4gbmVjZXNzYXJpbHkgbWVhbiB0aGUgdmFsdWUgaXMgdmFs
aWQuCj4+Pgo+Pj4gSXQncyB2YWxpZCBhcyBsb25nIGFzIHRoZSBkZXZpY2Ugb2ZmZXJzIHRoZSBm
ZWF0dXJlOgo+Pj4KPj4+ICJUaGUgZGV2aWNlIE1VU1QgYWxsb3cgcmVhZGluZyBvZiBhbnkgZGV2
aWNlLXNwZWNpZmljIGNvbmZpZ3VyYXRpb24KPj4+IGZpZWxkIGJlZm9yZSBGRUFUVVJFU19PSyBp
cyBzZXQgYnkgdGhlIGRyaXZlci4gVGhpcyBpbmNsdWRlcyBmaWVsZHMKPj4+IHdoaWNoIGFyZSBj
b25kaXRpb25hbCBvbiBmZWF0dXJlIGJpdHMsIGFzIGxvbmcgYXMgdGhvc2UgZmVhdHVyZSBiaXRz
IGFyZQo+Pj4gb2ZmZXJlZCBieSB0aGUgZGV2aWNlLiIKPj4gSSBndWVzcyB0aGlzIHN0YXRlbWVu
dCBvbmx5IGNvbnZleXMgdGhhdCB0aGUgZmllbGQgaW4gY29uZmlnIHNwYWNlIGNhbiBiZQo+PiBy
ZWFkIGJlZm9yZSBGRUFUVVJFU19PSyBpcyBzZXQsIHRob3VnaCBpdCBkb2VzIG5vdCAqZXhwbGlj
aXRseSogc3RhdGVzIHRoZQo+PiB2YWxpZGl0eSBvZiBmaWVsZC4KPj4KPj4gQW5kIGxvb2tpbmcg
YXQ6Cj4+Cj4+ICJUaGUgbWFjIGFkZHJlc3MgZmllbGQgYWx3YXlzIGV4aXN0cyAodGhvdWdoIGlz
IG9ubHkgdmFsaWQgaWYKPj4gVklSVElPX05FVF9GX01BQyBpcyBzZXQpLCBhbmQgc3RhdHVzIG9u
bHkgZXhpc3RzIGlmIFZJUlRJT19ORVRfRl9TVEFUVVMgaXMKPj4gc2V0LiIKPj4KPj4gSXQgYXBw
ZWFycyB0byBtZSB0aGVyZSdzIGEgYm9yZGVyIGxpbmUgc2V0IGJldHdlZW4gImV4aXN0IiBhbmQg
InZhbGlkIi4gSWYgSQo+PiB1bmRlcnN0YW5kIHRoZSBzcGVjIHdvcmRpbmcgY29ycmVjdGx5LCBh
IHNwZWMtY29uZm9ybWluZyBkZXZpY2UKPj4gaW1wbGVtZW50YXRpb24gbWF5IG9yIG1heSBub3Qg
b2ZmZXIgdmFsaWQgc3RhdHVzIHZhbHVlIGluIHRoZSBjb25maWcgc3BhY2UKPj4gd2hlbiBWSVJU
SU9fTkVUX0ZfU1RBVFVTIGlzIG9mZmVyZWQsIGJ1dCBiZWZvcmUgdGhlIGZlYXR1cmUgaXMgbmVn
b3RpYXRlZC4KPj4gT24gdGhlIG90aGVyIGhhbmQsIGNvbmZpZyBzcGFjZSBzaG91bGQgY29udGFp
biB2YWxpZCBtYWMgYWRkcmVzcyB0aGUgbW9tZW50Cj4+IFZJUlRJT19ORVRfRl9NQUMgZmVhdHVy
ZSBpcyBvZmZlcmVkLCByZWdhcmRsZXNzIGJlaW5nIG5lZ290aWF0ZWQgb3Igbm90LiBCeQo+PiB0
aGF0LCB0aGVyZSBzZWVtcyB0byBiZSBsZWV3YXkgZm9yIHRoZSBkZXZpY2UgaW1wbGVtZW50YXRp
b24gdG8gZGVjaWRlIHdoZW4KPj4gY29uZmlnIHNwYWNlIGZpZWxkIG1heSBiZWNvbWUgdmFsaWQs
IHRob3VnaCBmb3IgbW9zdCBvZiBRRU1VJ3Mgc29mdHdhcmUKPj4gdmlydGlvIGRldmljZXMsIHZh
bGlkIHZhbHVlIGlzIHByZXNlbnQgdG8gY29uZmlnIHNwYWNlIHRoZSB2ZXJ5IGZpcnN0IG1vbWVu
dAo+PiB3aGVuIGZlYXR1cmUgaXMgb2ZmZXJlZC4KPj4KPj4gIklmIHRoZSBWSVJUSU9fTkVUX0Zf
TUFDIGZlYXR1cmUgYml0IGlzIHNldCwgdGhlIGNvbmZpZ3VyYXRpb24gc3BhY2UgbWFjCj4+IGVu
dHJ5IGluZGljYXRlcyB0aGUg4oCccGh5c2ljYWzigJ0gYWRkcmVzcyBvZiB0aGUgbmV0d29yayBj
YXJkLCBvdGhlcndpc2UgdGhlCj4+IGRyaXZlciB3b3VsZCB0eXBpY2FsbHkgZ2VuZXJhdGUgYSBy
YW5kb20gbG9jYWwgTUFDIGFkZHJlc3MuIgo+PiAiSWYgdGhlIFZJUlRJT19ORVRfRl9TVEFUVVMg
ZmVhdHVyZSBiaXQgaXMgbmVnb3RpYXRlZCwgdGhlIGxpbmsgc3RhdHVzIGNvbWVzCj4+IGZyb20g
dGhlIGJvdHRvbSBiaXQgb2Ygc3RhdHVzLiBPdGhlcndpc2UsIHRoZSBkcml2ZXIgYXNzdW1lcyBp
dOKAmXMgYWN0aXZlLiIKPj4KPj4gQW5kIGFsc28gdGhlcmUgYXJlIHNwZWNpYWwgY2FzZXMgd2hl
cmUgdGhlIHJlYWQgb2Ygc3BlY2lmaWMgY29uZmlndXJhdGlvbgo+PiBzcGFjZSBmaWVsZCBNVVNU
IGJlIGRlZmVycmVkIHRvIHVudGlsIEZFQVRVUkVTX09LIGlzIHNldDoKPj4KPj4gIklmIHRoZSBW
SVJUSU9fQkxLX0ZfQ09ORklHX1dDRSBmZWF0dXJlIGlzIG5lZ290aWF0ZWQsIHRoZSBjYWNoZSBt
b2RlIGNhbiBiZQo+PiByZWFkIG9yIHNldCB0aHJvdWdoIHRoZSB3cml0ZWJhY2sgZmllbGQuIDAg
Y29ycmVzcG9uZHMgdG8gYSB3cml0ZXRocm91Z2gKPj4gY2FjaGUsIDEgdG8gYSB3cml0ZWJhY2sg
Y2FjaGUxMS4gVGhlIGNhY2hlIG1vZGUgYWZ0ZXIgcmVzZXQgY2FuIGJlIGVpdGhlcgo+PiB3cml0
ZWJhY2sgb3Igd3JpdGV0aHJvdWdoLiBUaGUgYWN0dWFsIG1vZGUgY2FuIGJlIGRldGVybWluZWQg
YnkgcmVhZGluZwo+PiB3cml0ZWJhY2sgYWZ0ZXIgZmVhdHVyZSBuZWdvdGlhdGlvbi4iCj4+ICJU
aGUgZHJpdmVyIE1VU1QgTk9UIHJlYWQgd3JpdGViYWNrIGJlZm9yZSBzZXR0aW5nIHRoZSBGRUFU
VVJFU19PSyBkZXZpY2UKPj4gc3RhdHVzIGJpdC4iCj4+ICJJZiBWSVJUSU9fQkxLX0ZfQ09ORklH
X1dDRSBpcyBuZWdvdGlhdGVkIGJ1dCBWSVJUSU9fQkxLX0ZfRkxVU0ggaXMgbm90LCB0aGUKPj4g
ZGV2aWNlIE1VU1QgaW5pdGlhbGl6ZSB3cml0ZWJhY2sgdG8gMC4iCj4+Cj4+IFNpbmNlIHRoZSBz
cGVjIGRvZXNuJ3QgZXhwbGljaXRseSBtYW5kYXRlIHRoZSB2YWxpZGl0eSBvZiBlYWNoIGNvbmZp
ZyBzcGFjZQo+PiBmaWVsZCB3aGVuIGZlYXR1cmUgb2YgY29uY2VybiBpcyBvZmZlcmVkLCB0byBi
ZSBzYWZlciB3ZSdkIGhhdmUgdG8gbGl2ZSB3aXRoCj4+IG9kZCBkZXZpY2UgaW1wbGVtZW50YXRp
b24uIEkga25vdyBmb3Igc3VyZSBRRU1VIHNvZnR3YXJlIGRldmljZXMgd29uJ3QgZm9yCj4+IDk5
JSBvZiB0aGVzZSBjYXNlcywgYnV0IHRoYXQncyBub3Qgd2hhdCBpcyBjdXJyZW50bHkgZGVmaW5l
ZCBpbiB0aGUgc3BlYy4KPgo+IFRoYW5rcyBmb3IgcmFpc2luZyB0aGlzIHN1YmplY3QuIEkgc3Rh
cnRlZCB3b3JraW5nIG9uIHRoaXMgaW4gQXByaWw6Cj4KPiBodHRwczovL3VybGRlZmVuc2UuY29t
L3YzL19faHR0cHM6Ly9saXN0cy5vYXNpcy1vcGVuLm9yZy9hcmNoaXZlcy92aXJ0aW8tY29tbWVu
dC8yMDIyMDEvbXNnMDAwNjguaHRtbF9fOyEhQUNXVjVOOU0yUlY5OWhRIU9zNlFFX1JKb2t4N1Vz
OXk3LTUtQnlWVkx1eTNvTHVQb2RBZFpXeHdKd19hTmtKWTBvMEg3NjkxRkk5YVlTVFJMVmllQVNV
RF9lT3UkCj4KPiB3b3JraW5nIG5vdyB0byBhZGRyZXNzIHRoZSBjb21tZW50cy4KR3JlYXQsIHRo
YW5rIHlvdSB2ZXJ5IG11Y2ghCgpJcyB0aGVyZSBhIGxpbmsgdG8gdGhlIGxhdGVzdCBkcmFmdCB0
aGF0IHJlZmxlY3RzIHRoZSBjaGFuZ2UgdXB0b2RhdGU/IApUaGUgb25lIGFib3ZlIHdpdGggaXRl
cmF0aXZlIGZlYXR1cmUgbmVnb3RpYXRpb24gc2VlbWVkIGdldHRpbmcgc29tZSAKcmVzaXN0YW5j
ZSBiZWNhdXNlIG9mIGJhY2t3YXJkIGluY29tcGF0aWJpbGl0eSB3aXRoIG9sZGVyIHNwZWM/IFBs
ZWFzZSAKY29weSBtZSBpbiB0aGUgbG9vcCB3aGVuIHlvdSBoYXZlIHRoZSBkcmFmdCByZWFkeS4g
SSBhbSBub3QgaW4gdGhlIAp2aXJ0aW8tY29tbWVudCBsaXN0LgoKVGhhbmtzLAotU2l3ZWkKPgo+
Cj4+Pgo+Pj4+IFlvdSBtYXkgd2FudCB0byBkb3VibGUgY2hlY2sgd2l0aCBNaWNoYWVsIGZvciB3
aGF0IGhlIHF1b3RlZCBlYXJsaWVyOgo+Pj4+PiBOb3BlOgo+Pj4+Pgo+Pj4+PiAyLjUuMcKgIERy
aXZlciBSZXF1aXJlbWVudHM6IERldmljZSBDb25maWd1cmF0aW9uIFNwYWNlCj4+Pj4+Cj4+Pj4+
IC4uLgo+Pj4+Pgo+Pj4+PiBGb3Igb3B0aW9uYWwgY29uZmlndXJhdGlvbiBzcGFjZSBmaWVsZHMs
IHRoZSBkcml2ZXIgTVVTVCBjaGVjawo+Pj4+PiB0aGF0IHRoZSBjb3JyZXNwb25kaW5nIGZlYXR1
cmUgaXMgb2ZmZXJlZAo+Pj4+PiBiZWZvcmUgYWNjZXNzaW5nIHRoYXQgcGFydCBvZiB0aGUgY29u
ZmlndXJhdGlvbiBzcGFjZS4KPj4+PiBhbmQgaG93IG1hbnkgZHJpdmVyIGJ1Z3MgdGFraW5nIHdy
b25nIGFzc3VtcHRpb24gb2YgdGhlIHZhbGlkaXR5IG9mCj4+Pj4gY29uZmlnIHNwYWNlIGZpZWxk
IHdpdGhvdXQgZmVhdHVyZXNfb2suIEkgYW0gbm90IHN1cmUgd2hhdCB1c2UgY2FzZQo+Pj4+IHlv
dSB3YW50IHRvIGV4cG9zZSBjb25maWcgcmVzaXN0ZXIgdmFsdWVzIGZvciBiZWZvcmUgZmVhdHVy
ZXNfb2ssIGlmCj4+Pj4gaXQncyBtb3N0bHkgZm9yIGxpdmUgbWlncmF0aW9uIEkgZ3Vlc3MgaXQn
cyBwcm9iYWJseSBoZWFkaW5nIGEgd3JvbmcKPj4+PiBkaXJlY3Rpb24uCj4+Pgo+Pj4gSSBndWVz
cyBpdCdzIG5vdCBmb3IgbWlncmF0aW9uLgo+PiBUaGVuIHdoYXQncyB0aGUgb3RoZXIgcG9zc2li
bGUgdXNlIGNhc2UgdGhhbiBsaXZlIG1pZ3JhdGlvbiwgd2VyZSB0byBleHBvc2UKPj4gY29uZmln
IHNwYWNlIHZhbHVlcz8gVHJvdWJsZXNob290aW5nIGNvbmZpZyBzcGFjZSBkaXNjcmVwYW5jeSBi
ZXR3ZWVuIHZEUEEKPj4gYW5kIHRoZSBlbXVsYXRlZCB2aXJ0aW8gZGV2aWNlIGluIHVzZXJzcGFj
ZT8gT3IgdHJhY2tpbmcgY2hhbmdlcyBpbiBjb25maWcKPj4gc3BhY2UgYWNyb3NzIGZlYXR1cmUg
bmVnb3RpYXRpb24sIGJ1dCBmb3Igd2hhdD8gSXQnZCBiZSBiZW5lZmljaWFsIHRvIHRoZQo+PiBp
bnRlcmZhY2UgZGVzaWduIGlmIHRoZSBzcGVjaWZpYyB1c2UgY2FzZSBjYW4gYmUgY2xlYXJseSBk
ZXNjcmliZWQuLi4KPj4KPj4KPj4+IEZvciBtaWdyYXRpb24sIGEgcHJvdmlzaW9uIHdpdGggdGhl
IGNvcnJlY3QgZmVhdHVyZXMvY2FwYWJpbGl0eSB3b3VsZCBiZQo+Pj4gc3VmZmljaWVudC4KPj4g
UmlnaHQsIHRoYXQncyB3aGF0IEkgdGhvdWdodCB0b28uIEl0IGRvZXNuJ3QgbmVlZCB0byBleHBv
c2UgY29uZmlnIHNwYWNlCj4+IHZhbHVlcywgc2ltcGx5IGV4cG9ydGluZyBhbGwgYXR0cmlidXRl
cyBmb3IgdmRwYSBkZXZpY2UgY3JlYXRpb24gd2lsbCBkbyB0aGUKPj4gd29yay4KPj4KPj4gLVNp
d2VpCj4+Cj4+PiBUaGFua3MKPj4+Cj4+Pgo+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4gTGFzdCBidXQgbm90
IHRoZSBsZWFzdCwgdGhpcyAidmRwYSBkZXYgY29uZmlnIiBjb21tYW5kIHdhcwo+Pj4+Pj4gbm90
IGRlc2lnbmVkIHRvIGRpc3BsYXkgdGhlIHJlYWwgY29uZmlnIHNwYWNlIHJlZ2lzdGVyCj4+Pj4+
PiB2YWx1ZXMgaW4gdGhlIGZpcnN0IHBsYWNlLiBRdW90aW5nIHRoZSB2ZHBhLWRldig4KSBtYW4g
cGFnZToKPj4+Pj4+Cj4+Pj4+Pj4gdmRwYSBkZXYgY29uZmlnIHNob3cgLSBTaG93IGNvbmZpZ3Vy
YXRpb24gb2Ygc3BlY2lmaWMKPj4+Pj4+PiBkZXZpY2Ugb3IgYWxsIGRldmljZXMuCj4+Pj4+Pj4g
REVWIC0gc3BlY2lmaWVzIHRoZSB2ZHBhIGRldmljZSB0byBzaG93IGl0cwo+Pj4+Pj4+IGNvbmZp
Z3VyYXRpb24uIElmIHRoaXMgYXJndW1lbnQgaXMgb21pdHRlZCBhbGwgZGV2aWNlcwo+Pj4+Pj4+
IGNvbmZpZ3VyYXRpb24gaXMgbGlzdGVkLgo+Pj4+Pj4gSXQgZG9lc24ndCBzYXkgYW55dGhpbmcg
YWJvdXQgY29uZmlndXJhdGlvbiBzcGFjZSBvcgo+Pj4+Pj4gcmVnaXN0ZXIgdmFsdWVzIGluIGNv
bmZpZyBzcGFjZS4gQXMgbG9uZyBhcyBpdCBjYW4gY29udmV5Cj4+Pj4+PiB0aGUgY29uZmlnIGF0
dHJpYnV0ZSB3aGVuIGluc3RhbnRpYXRpbmcgdkRQQSBkZXZpY2UKPj4+Pj4+IGluc3RhbmNlLCBh
bmQgbW9yZSBpbXBvcnRhbnRseSwgdGhlIGNvbmZpZyBjYW4gYmUgZWFzaWx5Cj4+Pj4+PiBpbXBv
cnRlZCBmcm9tIG9yIGV4cG9ydGVkIHRvIHVzZXJzcGFjZSB0b29scyB3aGVuIHRyeWluZyB0bwo+
Pj4+Pj4gcmVjb25zdHJ1Y3QgdmRwYSBpbnN0YW5jZSBpbnRhY3Qgb24gZGVzdGluYXRpb24gaG9z
dCBmb3IKPj4+Pj4+IGxpdmUgbWlncmF0aW9uLCBJTUhPIGluIG15IHBlcnNvbmFsIGludGVycHJl
dGF0aW9uIGl0Cj4+Pj4+PiBkb2Vzbid0IG1hdHRlciB3aGF0IHRoZSBjb25maWcgc3BhY2UgbWF5
IHByZXNlbnQuIEl0IG1heSBiZQo+Pj4+Pj4gd29ydGggd2hpbGUgYWRkaW5nIGEgbmV3IGRlYnVn
IGNvbW1hbmQgdG8gZXhwb3NlIHRoZSByZWFsCj4+Pj4+PiByZWdpc3RlciB2YWx1ZSwgYnV0IHRo
YXQncyBhbm90aGVyIHN0b3J5Lgo+Pj4+PiBJIGFtIG5vdCBzdXJlIGdldHRpbmcgeW91ciBwb2lu
dHMuIHZEUEEgbm93IHJlcG9ydHMgZGV2aWNlCj4+Pj4+IGZlYXR1cmUgYml0cyhkZXZpY2VfZmVh
dHVyZXMpIGFuZCBuZWdvdGlhdGVkIGZlYXR1cmUKPj4+Pj4gYml0cyhkcml2ZXJfZmVhdHVyZXMp
LCBhbmQgeWVzLCB0aGUgZHJpdmVycyBmZWF0dXJlcyBjYW4gYmUgYQo+Pj4+PiBzdWJzZXQgb2Yg
dGhlIGRldmljZSBmZWF0dXJlczsgYW5kIHRoZSB2RFBBIGRldmljZSBmZWF0dXJlcyBjYW4KPj4+
Pj4gYmUgYSBzdWJzZXQgb2YgdGhlIG1hbmFnZW1lbnQgZGV2aWNlIGZlYXR1cmVzLgo+Pj4+IFdo
YXQgSSBzYWlkIGlzIGFmdGVyIHVuYmxvY2tpbmcgdGhlIGNvbmRpdGlvbmFsIGNoZWNrLCB5b3Un
ZCBoYXZlIHRvCj4+Pj4gaGFuZGxlIHRoZSBjYXNlIGZvciBlYWNoIG9mIHRoZSB2ZHBhIGF0dHJp
YnV0ZSB3aGVuIGZlYXR1cmUKPj4+PiBuZWdvdGlhdGlvbiBpcyBub3QgeWV0IGRvbmU6IGJhc2lj
YWxseSB0aGUgcmVnaXN0ZXIgdmFsdWVzIHlvdSBnb3QKPj4+PiBmcm9tIGNvbmZpZyBzcGFjZSB2
aWEgdGhlIHZkcGFfZ2V0X2NvbmZpZ191bmxvY2tlZCgpIGNhbGwgaXMgbm90Cj4+Pj4gY29uc2lk
ZXJlZCB0byBiZSB2YWxpZCBiZWZvcmUgZmVhdHVyZXNfb2sgKHBlci1zcGVjKS4gQWx0aG91Z2gg
aW4KPj4+PiBzb21lIGNhc2UgeW91IG1heSBnZXQgc2FuZSB2YWx1ZSwgc3VjaCBiZWhhdmlvciBp
cyBnZW5lcmFsbHkKPj4+PiB1bmRlZmluZWQuIElmIHlvdSBkZXNpcmUgdG8gc2hvdyBqdXN0IHRo
ZSBkZXZpY2VfZmVhdHVyZXMgYWxvbmUKPj4+PiB3aXRob3V0IGFueSBjb25maWcgc3BhY2UgZmll
bGQsIHdoaWNoIHRoZSBkZXZpY2UgaGFkIGFkdmVydGlzZWQKPj4+PiAqYmVmb3JlIGZlYXR1cmUg
bmVnb3RpYXRpb24gaXMgY29tcGxldGUqLCB0aGF0J2xsIGJlIGZpbmUuIEJ1dCBsb29rcwo+Pj4+
IHRvIG1lIHRoaXMgaXMgbm90IGhvdyBwYXRjaCBoYXMgYmVlbiBpbXBsZW1lbnRlZC4gUHJvYmFi
bHkgbmVlZCBzb21lCj4+Pj4gbW9yZSB3b3JrPwo+Pj4+Cj4+Pj4gUmVnYXJkcywKPj4+PiAtU2l3
ZWkKPj4+Pgo+Pj4+Pj4gSGF2aW5nIHNhaWQsIHBsZWFzZSBjb25zaWRlciB0byBkcm9wIHRoZSBG
aXhlcyB0YWcsIGFzCj4+Pj4+PiBhcHBlYXJzIHRvIG1lIHlvdSdyZSBwcm9wb3NpbmcgYSBuZXcg
ZmVhdHVyZSByYXRoZXIgdGhhbgo+Pj4+Pj4gZml4aW5nIGEgcmVhbCBpc3N1ZS4KPj4+Pj4gaXQn
cyBhIG5ldyBmZWF0dXJlIHRvIHJlcG9ydCB0aGUgZGV2aWNlIGZlYXR1cmUgYml0cyB0aGFuIG9u
bHkKPj4+Pj4gbmVnb3RpYXRlZCBmZWF0dXJlcywgaG93ZXZlciB0aGlzIHBhdGNoIGlzIGEgbXVz
dCwgb3IgaXQgd2lsbAo+Pj4+PiBibG9jayB0aGUgZGV2aWNlIGZlYXR1cmUgYml0cyByZXBvcnRp
bmcuIGJ1dCBJIGFncmVlLCB0aGUgZml4Cj4+Pj4+IHRhZyBpcyBub3QgYSBtdXN0Lgo+Pj4+Pj4g
VGhhbmtzLAo+Pj4+Pj4gLVNpd2VpCj4+Pj4+Pgo+Pj4+Pj4gT24gNy8xLzIwMjIgMzoxMiBQTSwg
UGFyYXYgUGFuZGl0IHZpYSBWaXJ0dWFsaXphdGlvbiB3cm90ZToKPj4+Pj4+Pj4gRnJvbTogWmh1
IExpbmdzaGFuPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4+Pj4+Pj4+IFNlbnQ6IEZyaWRheSwg
SnVseSAxLCAyMDIyIDk6MjggQU0KPj4+Pj4+Pj4KPj4+Pj4+Pj4gVXNlcnMgbWF5IHdhbnQgdG8g
cXVlcnkgdGhlIGNvbmZpZyBzcGFjZSBvZiBhIHZEUEEKPj4+Pj4+Pj4gZGV2aWNlLCB0byBjaG9v
c2UgYQo+Pj4+Pj4+PiBhcHByb3ByaWF0ZSBvbmUgZm9yIGEgY2VydGFpbiBndWVzdC4gVGhpcyBt
ZWFucyB0aGUKPj4+Pj4+Pj4gdXNlcnMgbmVlZCB0byByZWFkIHRoZQo+Pj4+Pj4+PiBjb25maWcg
c3BhY2UgYmVmb3JlIEZFQVRVUkVTX09LLCBhbmQgdGhlIGV4aXN0ZW5jZSBvZiBjb25maWcgc3Bh
Y2UKPj4+Pj4+Pj4gY29udGVudHMgZG9lcyBub3QgZGVwZW5kIG9uIEZFQVRVUkVTX09LLgo+Pj4+
Pj4+Pgo+Pj4+Pj4+PiBUaGUgc3BlYyBzYXlzOgo+Pj4+Pj4+PiBUaGUgZGV2aWNlIE1VU1QgYWxs
b3cgcmVhZGluZyBvZiBhbnkgZGV2aWNlLXNwZWNpZmljCj4+Pj4+Pj4+IGNvbmZpZ3VyYXRpb24g
ZmllbGQKPj4+Pj4+Pj4gYmVmb3JlIEZFQVRVUkVTX09LIGlzIHNldCBieSB0aGUgZHJpdmVyLiBU
aGlzCj4+Pj4+Pj4+IGluY2x1ZGVzIGZpZWxkcyB3aGljaCBhcmUKPj4+Pj4+Pj4gY29uZGl0aW9u
YWwgb24gZmVhdHVyZSBiaXRzLCBhcyBsb25nIGFzIHRob3NlCj4+Pj4+Pj4+IGZlYXR1cmUgYml0
cyBhcmUgb2ZmZXJlZCBieSB0aGUKPj4+Pj4+Pj4gZGV2aWNlLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBG
aXhlczogMzBlZjdhOGFjOGEwNyAodmRwYTogUmVhZCBkZXZpY2UKPj4+Pj4+Pj4gY29uZmlndXJh
dGlvbiBvbmx5IGlmIEZFQVRVUkVTX09LKQo+Pj4+Pj4+IEZpeCBpcyBmaW5lLCBidXQgZml4ZXMg
dGFnIG5lZWRzIGNvcnJlY3Rpb24gZGVzY3JpYmVkIGJlbG93Lgo+Pj4+Pj4+Cj4+Pj4+Pj4gQWJv
dmUgY29tbWl0IGlkIGlzIDEzIGxldHRlcnMgc2hvdWxkIGJlIDEyLgo+Pj4+Pj4+IEFuZAo+Pj4+
Pj4+IEl0IHNob3VsZCBiZSBpbiBmb3JtYXQKPj4+Pj4+PiBGaXhlczogMzBlZjdhOGFjOGEwICgi
dmRwYTogUmVhZCBkZXZpY2UgY29uZmlndXJhdGlvbgo+Pj4+Pj4+IG9ubHkgaWYgRkVBVFVSRVNf
T0siKQo+Pj4+Pj4+Cj4+Pj4+Pj4gUGxlYXNlIHVzZSBjaGVja3BhdGNoLnBsIHNjcmlwdCBiZWZv
cmUgcG9zdGluZyB0aGUKPj4+Pj4+PiBwYXRjaGVzIHRvIGNhdGNoIHRoZXNlIGVycm9ycy4KPj4+
Pj4+PiBUaGVyZSBpcyBhIGJvdCB0aGF0IGxvb2tzIGF0IHRoZSBmaXhlcyB0YWcgYW5kCj4+Pj4+
Pj4gaWRlbnRpZmllcyB0aGUgcmlnaHQga2VybmVsIHZlcnNpb24gdG8gYXBwbHkgdGhpcyBmaXgu
Cj4+Pj4+Pj4KPj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFuPGxpbmdzaGFuLnpo
dUBpbnRlbC5jb20+Cj4+Pj4+Pj4+IC0tLQo+Pj4+Pj4+PiAgwqAgZHJpdmVycy92ZHBhL3ZkcGEu
YyB8IDggLS0tLS0tLS0KPj4+Pj4+Pj4gIMKgIDEgZmlsZSBjaGFuZ2VkLCA4IGRlbGV0aW9ucygt
KQo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGEuYyBiL2Ry
aXZlcnMvdmRwYS92ZHBhLmMgaW5kZXgKPj4+Pj4+Pj4gOWIwZTM5YjJmMDIyLi5kNzZiMjJiMmY3
YWUgMTAwNjQ0Cj4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhLmMKPj4+Pj4+Pj4gKysr
IGIvZHJpdmVycy92ZHBhL3ZkcGEuYwo+Pj4+Pj4+PiBAQCAtODUxLDE3ICs4NTEsOSBAQCB2ZHBh
X2Rldl9jb25maWdfZmlsbChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsCj4+Pj4+Pj4+IHN0cnVj
dCBza19idWZmICptc2csIHUzMiBwb3J0aWQswqAgewo+Pj4+Pj4+PiAgwqDCoMKgwqDCoCB1MzIg
ZGV2aWNlX2lkOwo+Pj4+Pj4+PiAgwqDCoMKgwqDCoCB2b2lkICpoZHI7Cj4+Pj4+Pj4+IC3CoMKg
wqAgdTggc3RhdHVzOwo+Pj4+Pj4+PiAgwqDCoMKgwqDCoCBpbnQgZXJyOwo+Pj4+Pj4+Pgo+Pj4+
Pj4+PiAgwqDCoMKgwqDCoCBkb3duX3JlYWQoJnZkZXYtPmNmX2xvY2spOwo+Pj4+Pj4+PiAtwqDC
oMKgIHN0YXR1cyA9IHZkZXYtPmNvbmZpZy0+Z2V0X3N0YXR1cyh2ZGV2KTsKPj4+Pj4+Pj4gLcKg
wqDCoCBpZiAoIShzdGF0dXMgJiBWSVJUSU9fQ09ORklHX1NfRkVBVFVSRVNfT0spKSB7Cj4+Pj4+
Pj4+IC3CoMKgwqDCoMKgwqDCoCBOTF9TRVRfRVJSX01TR19NT0QoZXh0YWNrLCAiRmVhdHVyZXMg
bmVnb3RpYXRpb24gbm90Cj4+Pj4+Pj4+IGNvbXBsZXRlZCIpOwo+Pj4+Pj4+PiAtwqDCoMKgwqDC
oMKgwqAgZXJyID0gLUVBR0FJTjsKPj4+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Owo+
Pj4+Pj4+PiAtwqDCoMKgIH0KPj4+Pj4+Pj4gLQo+Pj4+Pj4+PiAgwqDCoMKgwqDCoCBoZHIgPSBn
ZW5sbXNnX3B1dChtc2csIHBvcnRpZCwgc2VxLCAmdmRwYV9ubF9mYW1pbHksIGZsYWdzLAo+Pj4+
Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFZEUEFfQ01EX0RFVl9DT05GSUdf
R0VUKTsKPj4+Pj4+Pj4gIMKgwqDCoMKgwqAgaWYgKCFoZHIpIHsKPj4+Pj4+Pj4gLS0gCj4+Pj4+
Pj4+IDIuMzEuMQo+Pj4+Pj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCj4+Pj4+Pj4gVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0Cj4+Pj4+Pj4gVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPj4+Pj4+PiBodHRwczovL3Vy
bGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb25fXzshIUFDV1Y1TjlNMlJWOTloUSFQa3d5bTdPQWpv
RHVjVXFzMmZBd2NoeHFMOC1CR2Q2d09sLTUxeGNnQl95Q053UEpfY3M4QTF5LWNZbXJMVEI0T0JO
c2ltblp1cUpQY3ZRSWwzZyQKPj4+Pj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
