Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD27C76196
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 22:15:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52F2460D94;
	Tue, 11 Apr 2023 22:15:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 52F2460D94
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=0izklay8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=ETtACcxJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AbuOka1otUqB; Tue, 11 Apr 2023 22:15:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9FC5D60BB2;
	Tue, 11 Apr 2023 22:15:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9FC5D60BB2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 792DBC0036;
	Tue, 11 Apr 2023 22:15:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62CADC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 22:15:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3761181B25
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 22:15:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3761181B25
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=0izklay8; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=ETtACcxJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2bPf_g25x0yD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 22:15:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 18C2481BF4
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 18C2481BF4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 22:15:24 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 33BLlR0m018011; Tue, 11 Apr 2023 22:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7/fp8qeiliLfvobmlbJwTdOEXEsW8DeVoHid7nO9mwk=;
 b=0izklay8F73k1TG8pY5fhAjDeA8snIcPgwDFusdGK+QOK+7xWKAGx+qBKhxdFLYLrVuJ
 YlQF0ULLGp+n24yPUBQRsRRzTl/pIbNIqNl8JkOAgSFxgAFy3rICm3jVJifEyXLfgGml
 jDLEYot5YX0V7rb3GeLbkRsFB/Tk1wJ6txWZ0VenmWSdDwrEHMJozatfptlbxxat6s5h
 bD8dukVPz6qO2HyJLMBsZ2+7HMTP8V1z9BaaIt4s9J+kuhGMl1r26LFcR57r5hPaCJz1
 a7o8GVp2646d0PM85oGPK5slUtvvgDxdRadDcUq2/T84NKvYueuVbWjP7Pw5R0nPDUT5 Bg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0etpn1v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Apr 2023 22:15:23 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 33BLR1rk012882; Tue, 11 Apr 2023 22:15:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3puwdpmaxm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Apr 2023 22:15:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzuemiGMQEP1fdQpokk8yRlRWdr2B+f+HqsCmuTg+ptqBmynw/K5R28Sa/RpHaGZK8paAv6t9RpcUaceV0ghaVQv0YRySGCH1KgYTg7tMiJyLrETKHpdsM1tvaX09wvfdvenF+mctCTjX0q8nQ7mLneJZ/0jWK0d16f30RoXUmuxXdg9bUkmIXn+UrgCBXAFeWvcvJlMbnTc4A15b1wz9VdKHUbZ7a4F2356wrcGodHSaLaMJAYI3/px4NRRtVupoU6qDwnVMeee5u12RjZ1+93dpe7qbu0Zkeqd3q8p9XuEZALWbCAfAcRoyUXgMRKuB0lpFgW9rMwvoFYh19rO5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/fp8qeiliLfvobmlbJwTdOEXEsW8DeVoHid7nO9mwk=;
 b=JJFlQnVq2mp3tJQ9TRibHZsCZh5mIMuDAU4Vfizfhz10Zr44TQ0VnoebIKLSEqYoHorfbWjfK/eYnC3Bxv6q5o+XY0/MaeUE8AOB1pEwA6IuagfdA1R38Q7sgdf3FB1fkWgTsvYT8uW9rh3k5AM0EnU9Y7rrF/Z60Wj/6kPp24Xs+6CsTOdPMKb2TwHq1gyqaQtanMjMQ4dV49n9lyzqUj3xBAn6jOFQ/KXCwCM9AfbM9gDqEbAAsHegMR1PCiFYcamL2NFivEZL8bm1jwTE3kveQc9GaiEQHTU3GU/HqrZPzRSEzGdInK6yYZHYjzUCYtujQo0XQN6VG5OOHUiQ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/fp8qeiliLfvobmlbJwTdOEXEsW8DeVoHid7nO9mwk=;
 b=ETtACcxJu5Dugq/1tZVMS/hjDVtK7hGkuAx3fVkujaPE4d/O0KhjcKzhuCjEumYLStEDbH0AvAusOzAUQqO38XA8t8HNI9g0Ym0+17GO4boDGGVkjI+FaCYXkojPXpyNGcshrQit5ObxIg7S6XA82i1OfGosXDADPSURgsFn/ys=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 IA1PR10MB5996.namprd10.prod.outlook.com (2603:10b6:208:3ec::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Tue, 11 Apr
 2023 22:15:20 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::a870:411d:9426:21b3]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::a870:411d:9426:21b3%10]) with mapi id 15.20.6277.036; Tue, 11 Apr
 2023 22:15:20 +0000
Message-ID: <c7da1c60-1b89-5fab-942a-1e74214f03d5@oracle.com>
Date: Tue, 11 Apr 2023 17:15:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 11/11] vhost: allow userspace to create workers
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20230328021717.42268-1-michael.christie@oracle.com>
 <20230328021717.42268-12-michael.christie@oracle.com>
 <CACGkMEuvAGKHVtg_tdiGJRN4+5utdDVbvnkycN97eb2fE2Ddsg@mail.gmail.com>
 <faeaa023-c1ee-cd81-3397-edecc0579e8a@oracle.com>
 <CACGkMEvrvpu-xdJTzm5mVq-9JGuXRnsXZHEU7tgwfsz6qqFc4g@mail.gmail.com>
 <0ce314ff-0a1d-223d-0ccf-d2cb876b4306@oracle.com>
 <CACGkMEs5GdXuoMaOiZjWytG=JHqhzdZmCu=dK7GRRvYcx8t2+A@mail.gmail.com>
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CACGkMEs5GdXuoMaOiZjWytG=JHqhzdZmCu=dK7GRRvYcx8t2+A@mail.gmail.com>
X-ClientProxiedBy: DM6PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:5:333::30) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|IA1PR10MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b3ab10-751d-4545-8c50-08db3ada3cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hk4ZfdnDqv1lR0LEITtWfcangBpdMO7uZlCY8TfgC0ZUFLcKLymawyjOxWPow0FL7siC+46oNTKd8PL05QFhORtQ2b+5/Op0dqfknnzlPTFOV3mC+QHiPj7nMQOMbCqIQBDlKWBQMtCBUhgek3dfg6j/+7Nb4+pf6xQ3nLB6Cbn0qsQi9PqzwvKeVOXM50pWZN3fKnXx6l3gfbc9eJAbuEEynm2z+C553KUqhwdUQFBXpeB8UmoqPogYQ/5xkZMKCn38Uem5EjAlxCH0aJ7KHMTCQNU+DknJbKhRnEW/t2/Lw10agNspKoArs/n1/8lIys1C0JHkrVgjqUsEKhb0kcSpKJ5zztAqiayHVbylvsDQUbXw+5Sm05uB87V4ccHA3JoWprstpbeN1Six+wamhIFlsXSFJXtOulUqdZ9CcZqJF3aOVvadDkKm2w3tpgmv4XvhgLidzykqZyrJCw2PH9MxjiwH3Sv1IEvD+KF+NAbgDLoykVD7U+MjRAiGb+BQEPUwIK+l6XJPa/eR2Naeb7+2rzTuySQAk6tKIG0kQ7Tka+Pfc7LHJ7GYvkWESAHsQzKvb0MsgaFQB2yz6hFNoax2p6ZPxhMglNCL/CvY0KT9YS5UxufV3/gKzHy1I3xXeC+xcIWJ6XjvL4dMbKmldfmZtkMChumPuMjzxhwKVtnLS60mA4UseJ3umNmVYQ/L1JZUTgGToOBgTPz0Sc/18A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199021)(316002)(5660300002)(6486002)(31686004)(478600001)(8936002)(41300700001)(4326008)(6916009)(8676002)(66946007)(66556008)(66476007)(83380400001)(26005)(53546011)(6506007)(6512007)(2906002)(186003)(2616005)(86362001)(31696002)(36756003)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzMwMEVlTEF6RjJ0QW55Z0tIcHVxMGpRRHpjM2x0MkZlTE9EZkhTcFpKY1E2?=
 =?utf-8?B?Y1hCUVFDeFdIejJSZXRXYWNlVHJna1F5Y2FVZTBJUkpPV0VieGVESUtkb1V6?=
 =?utf-8?B?L0pyWnM2N1Y2WURwZG15d1pWZC9FQXVOYzNQM2Y2Q25BV3dYRXI2V3dFblBW?=
 =?utf-8?B?UkNoYmhETW0ydE9JemVCZ0k0akg2cmowd3BYb0RoTEYyRkVVRU01YTFRaFpp?=
 =?utf-8?B?Y2V6emRWVHBiNDhvSmtBNC93R0xpRVBSNHlTS0dtak1mWHB1TkpzUTkzb1Rn?=
 =?utf-8?B?ajlqSGpsZEdqZmZkd3ZtdEtqeThYazlCZ3lRUUY0N3RDRDJ4Z2tFM0lMY3JW?=
 =?utf-8?B?eXpUVkdVK3pVOTZqVURWeEswV0RhM2MvRzkzcm50MWorYVZQVndaOURPM2kz?=
 =?utf-8?B?Ti8xQUswaWpET2hHWVRKbFNmbnpIcFo4ckMyMW5oOW9USFlhMERkQ3ZtNzlZ?=
 =?utf-8?B?cjNLczdqUm9VRjFqVmJBNTFlSWo2QVQ1bjNHb1JKWFpNcSswUktEYUZNSWc3?=
 =?utf-8?B?b2lGeXhGTHZCRzRUSk1Sdk15bkF4eW9ON3o0STQrZHJZRTJBSlpTejRKRUQ3?=
 =?utf-8?B?T3N1dk92UVJaa1E4WUY2dEdZSmFTQ3ErMndqRW1GNTllN3dVcHdaM1ZFSGYw?=
 =?utf-8?B?VUFIQTZkM3BxOU1iSEorNjFKaXNqMVVtcEI3NXpnSEJZdEluaUU4N2szaExn?=
 =?utf-8?B?Qjd3eVk4UWovTlpONDRYc3hlU28ySkRxeEJYZ2F1ZTNEbm1xNGxONitMTzVj?=
 =?utf-8?B?SnZiZWp5RWpURlJMV0RENmJEZTVYdHBaS0tydG9xM2NtM0c3ejRyQWk3SU5a?=
 =?utf-8?B?WlA3dWZCVUdmQkorMm9SQm5BbzVrRllrRDVRNUZBZUNiKzdOTGQzMmZwVFdl?=
 =?utf-8?B?dnBYaHdpbUE3R2N3ZHlLbHdjZ2ZRZXlNZ2cwU29nTGl1WEJLcy9iY0o5d01N?=
 =?utf-8?B?eUtzL1BTbWI1VTllMnJBMUptRDlxN3dVKzhpSWtqemNORmRtYXMxS3pNM3dI?=
 =?utf-8?B?amdEZFRrUFJlcEFxOWtVd1BMbDZJd05HQngvUDhUK0trdUsvNmliZzN2M093?=
 =?utf-8?B?Tm1QY1Npblh6dk1aT204cnU1Z2l1TDhWdVlLM29HVHBKRW81VjhjQWFmRHlp?=
 =?utf-8?B?RFZxd3ptRjlyMTJabHNDd0ZOVURzK0wvVWRJcWEwOXlzUjdZSi9EcnB4YUll?=
 =?utf-8?B?dm9zZUE0VG9EeXFVaThrYjBBZWR2MFRMNlNSTE5sVWJVMmIyRS9obWt0aytl?=
 =?utf-8?B?UDg5cHNtQ21hWkhsUXp4eWxWOVFnck9vemhaTUcwSDNONDJrM1hwU004RHFw?=
 =?utf-8?B?clhtY041ZWdNeTZtcUNyZ21GR0VYSjR4dG9RZnVpbE51TjRhR05TQzl3bmM0?=
 =?utf-8?B?NkhBY1lpam9rcks5OWlkc2JnL1puUG4valZHMUM4LzRWUy9SSC9JNVU1cERz?=
 =?utf-8?B?REMwRStTRis0U3owYjlnRE45ZFpwbkdMUGhndG16VnZCOTJtRHJMclNRWGV0?=
 =?utf-8?B?T1laN0hxeWJRemtzN1ZidnRIOUg5UVNyaFQ5TllLMFcraGQvanc2Z0xHNWdJ?=
 =?utf-8?B?c2NZbGc3bkxST2t3NGhuMlZYYUFwV3RYNnVzbUVOWFZiblNaTlQrU1VvMGx6?=
 =?utf-8?B?UGJtb0NuRHo3ZnNaVmJSekxqRUY0U1ZWSmZhMVBSQUtoMWhQZTZrNWRjcEcr?=
 =?utf-8?B?Q2s2SE56dVVyVUJmSFNoTGNNOC9FZ09VeHl4TUFZU3RsVTlLM2xlamtsa1No?=
 =?utf-8?B?Ry9RcEJuSzNwVmRIeGlYajkyVHRPWVNXbzVYYk00UmlNODNJL2xhYmo3am1z?=
 =?utf-8?B?dVNSQ1BvNW0yMFAzVjJ5dWx1VlNZMUM1RzkwQU1seGtZMXFUT2wvK2R4bVh5?=
 =?utf-8?B?dXVtY1BqdWIvTzBod0dZM0g3UkN2eU9pdkhZanZLSzNjR0tybDZVa0Vac0ZT?=
 =?utf-8?B?aFpxdEZ2NEJoT29Ocjl1WTJnYk1MRUZkd2szS2xjQVpMa29CZGhyN0NMTkZH?=
 =?utf-8?B?ZEJwOWJpQXVHVk5oUXF4QTZscHRkNGVxZlA2SWhwaUp3K0ZNTnpocU90aHRF?=
 =?utf-8?B?bndXTEZZbGNabGhIby8vNUp4YzRTS0hhSkt0UlVvZ0hmMFc3d29kYUp5eUlU?=
 =?utf-8?B?VjBXb2ZsY01rSjRlUnRua1hES01jV2pHa0RSUm5abUFvdE9kWGNTRWczSnQx?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Sja6qIbGxpYAetrqHRJEctCbE0uoOcsN80HQ86YSVyxo8jOH+VUtdtzJOgG8UAmt/Yqi1FUq617qKjBjhmO+tLGMG9un/xbVqiruCOH0tecVxNrSym5aOTkZgZRrSnk/qL+pIEuuz8VWJ+MIPLEd41e0VyfrBdR9chH5jkbf6KAj92f6Ih7MXcCGxVFBFVJ/U8ohGx3rTtHG/sUunSvlZhYZL2qdZUGksBCKCgIFUSbhVMoVMUtDwPxj/3rgNTgufAKEUx1dPJY6dwZ2KeLGL8sIihsH9p0VbAvuCQFpniDh1dtRQ2hzLq2XUmUkA/Eb+iRkeXNzyxC1BT/B5Kezuibmiv3sKUZRG7Uzvjh18gUx4leZYyWRmnbaxKLlhIjM+/RVx8HO/9OHQjL/2iyyeAQH1Mek2W4DKVgcUBQ5GFexLoSFycQiHSWKetOy3Svej+5G6krkc2Iux3AT7uMo4txtTZXe16AgAxxiCXL4QafqhRV9b53rLnDOdwL7ugXKu6JRV9lIcrzX2fthqo6VgpS1ieOE3yMTGldlLmvJU8CoUbtaIEjVEST+gNpbpxMyjBAowyhIqnNowHSZCW9QwQjY42khoBHA19pk5j/IxyJlfw7oLwTEdmvkvT9jO8tYydwp5HUKu6Y5i7dDOzq/A9UQt1GEQYH0kNfuLoPEdpKGkkw7evTMloLbh7txExcJYsFM+OlCoTTLdtAAJYZFDp/UDNtrSD+BPiNn7tFYqGfszi2qhx6IJ+agP4l2fhClW4/jT0O04XgFRlnpbHLa3FfT5owBrYa+vZIxvTRVpbXNO/loa21ivmLvHRF3cPoj
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b3ab10-751d-4545-8c50-08db3ada3cbf
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 22:15:20.1680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtlRNIGa/4aHBbZHB+M/MRno7R4PGgvIq6GCAkSV1Py5KgweDH7dlGgmOIQeC+0f0fYsdOsgUngvnU5p155Fr8Bdr3u6T+Y/rQGujlJH1Z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5996
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_15,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304110200
X-Proofpoint-GUID: p3DfReScK82Z4BlvdVFMx7fCJODIzaNH
X-Proofpoint-ORIG-GUID: p3DfReScK82Z4BlvdVFMx7fCJODIzaNH
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

On 4/10/23 10:00 PM, Jason Wang wrote:
>>> vhost_zerocopy_callback(). But since you want to limit the call before
>>> set_backend, another question comes, do we really need the dynamic
>>> attaching/creating in this case? How about a simple one ioctl that is
>>> used to build the queue to workers mapping instead?
>>
>>
>> I didn't think we need the dynamic case. It was from a review comment.
> 
> Right, so we actually don't need three new ioctls but only a single is
> sufficient?
> 
> struct vhost_worker_state {
>       __u16 workers;
>       __u16 queue_to_work_map[];
> };
> 
> And limiting this to be called before datapath can run is sufficient?
> (sorry I missed some of the previous comments).

It's been like 3 years since this was last discussed so no problem :)

Yeah, what you describe is all I need. Originally I just had the one
ioctl:

+#define VHOST_SET_VRING_WORKER _IOWR(VHOST_VIRTIO, 0x15, struct vhost_vring_worker)

The VHOST_SET_VRING_WORKER created a worker on the virtqueue in the
vhost_vring_worker.


>>>>
>>>>>> -       default:
>>>>>> +       case VHOST_ATTACH_VRING_WORKER:
>>>>>> +               if (copy_from_user(&w, argp, sizeof(w))) {
>>>>>> +                       r = -EFAULT;
>>>>>> +                       break;
>>>>>> +               }
>>>>>> +               r = vhost_vq_attach_worker(vq, &w);
>>>>>> +               if (!r && copy_to_user(argp, &w, sizeof(w)))
>>>>>> +                       r = -EFAULT;
>>>>>> +               break;
>>>>>
>>>>> It's a little odd that we have new and attach but only a free.
>>>>
>>>> Do you mean we would also want a detach? I've been debating that.
>>>> I'm not sure what the user wanted though.
>>>>
>>>> Would it leave the virtqueue with no worker? Or, does it pick the first
>>>> worker it finds? If there is no worker because we did the former or
>>>> because userspace detached all of them, then do we just drop work that
>>>> gets queued?
>>>>
>>>> It seemed like a user would never want to drop work, so I made it so
>>>> you can only tell it to use new workers (attach which I guess is more
>>>> like a swap worker)
>>>
>>> swap and free old worker indeed?
>>
>> I didn't understand the question.
> 
> I mean if I understand the code correctly, the code tries to drop
> refcnt and free the old worker during attach.

I see. We actually don't free until VHOST_FREE_WORKER.

When we create the worker from VHOST_NEW_WORKER we set the refcount
to 1. Then each time a virtqueue and worker are attached to each other
we increase the refcount.

When you do vhost_vq_detach_worker then it drops the refcount from the
attach. Then if you detached the worker from all the virtqueues you
still have the refcount=1 from the VHOST_NEW_WORKER call.

The refcount decrement in VHOST_FREE_WORKER via vhost_worker_put would
be the final put. Note that if userspace just closes the dev without
doing a put, then we do the final puts for it.

Note that I originally didn't have the free. I don't need it for any
specific reason. It was just from a review comment. I originally just had
the one create worker type of ioctl. Then it was suggested to do the split
attach/new/free design.

I can spin another patchset with the single ioctl design so we can compare.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
