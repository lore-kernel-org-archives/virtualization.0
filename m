Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A64C19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 18:39:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3E3681357;
	Tue,  9 Aug 2022 18:39:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F3E3681357
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=2IH362LK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=MbiRKwdb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RkGRz2Sr1X6M; Tue,  9 Aug 2022 18:39:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 16B1F8133F;
	Tue,  9 Aug 2022 18:39:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 16B1F8133F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC1CFC0033;
	Tue,  9 Aug 2022 18:39:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7D80C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 18:39:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 977394058C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 18:39:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 977394058C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=2IH362LK; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=MbiRKwdb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id By3VA2btRlmW
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 18:39:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5D5D5404B9
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5D5D5404B9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 18:39:11 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279GdUIt022303;
 Tue, 9 Aug 2022 18:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Hk7KKZNA6+WWoQdK4Iithqlpz2BAG8qQAbnD9DPDefE=;
 b=2IH362LK8wLuHjxQEGmJje5BMh/+H3gXyYePr8yeAT69Rq2eVICBYjFEsukN5+vRU5mG
 mhgeHvIA1Vl5aAON7gvhdHHqupm/n4II+odhaYmlKGwu6IdfIVLp34lk5vluXQkNkMQn
 bNVMs86t4TDPc1YmYj6xkzkFtICFqf9A3KObHarA5I1eWDuIOPmFKrETAVWc3msKUJc2
 DyqfFNBtE4QvAg6x16ESabMdEFlxV1GXIaE3ra1wS8azCldBYzEwa2PQ0VeZb9O2vHZ7
 jdF5dVmDfw2tgSOVw/fgSodE1St5ir8DXZ8oI2a1MnyGShyz7nBQSl8x4x7uOdLuWayM 0w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsfwsqbv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Aug 2022 18:39:05 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 279I0meZ013993; Tue, 9 Aug 2022 18:39:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3hser96qcj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Aug 2022 18:39:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSRZ/Th1K/hoN40X4i+635+aNAj4hTb9lwif+8xuoJhGkhDMg3m9Y4GTd+B/hgZ1zWl9+sMLOq8443w7DucKsYlNXTxEZfRQWke2/zAeD75/jiND0vS3P7Eg6yXUgHJ4OOKkfuBzenP+tVzYp23fQ/Hl6Is/5tR2OFsGxjsdedMQ2Qi8LjAXUnJVdBS8Q4itDNXvMoPi5QG3HWZFHakIp0BhtB/ng1AuWke6jknMEz1cUQEXPu9/UvOLlqmwkoZa8qlEp7r1xvQuP4UsSFziYyYHW7NVgaWQiJRMjjHZfHncqOyZf85boj8s6YU9mV+hKnyqwZO9a4bG1m24mcdrpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hk7KKZNA6+WWoQdK4Iithqlpz2BAG8qQAbnD9DPDefE=;
 b=RlHy39fAbTWXftyxT8428lbhDy8P1QslsxsX/j8Ey13bT4B6ycNjGn2nPK4yqRyECSnqokzzHJqp8HEqLRd2VSCubYZEEGgH0+7xxidSq8R517EHTWGv0knFem3oSrqg4UmFvTIRdRdnOqSlctpsbaqlN546a3gh/EyBDS6muLari2672zWGkagEPIgnRsciyg0rE+nHIhFH8W2HpldiMLNbN14yIp542/sieGZl1z4C2vkFW5pYH9IR9xlEX2J8nFSieEN/lKhhhPgZH77GrIuT2Go2ukW0JMGxD6MdDKsvD6j5LsdluccC3xK6mJckmBvGJvr55Yfm1hWzc7+RMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hk7KKZNA6+WWoQdK4Iithqlpz2BAG8qQAbnD9DPDefE=;
 b=MbiRKwdbr3qJoNcSzv8OT88fKLfdLC5IuBubTfZZ1kBNwqbo3h97VakzlT4bePIJ3QIHkLKUEkmQn6G7tIp2bLTgYLLA1IMZlA29CHnzkuTLuWv3uLcLfVNpClgMK35enyoGn0rKyfY8m0OHX01XlgFYbZQi8wXNvYQhqMMO3rY=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by DM5PR10MB1833.namprd10.prod.outlook.com (2603:10b6:3:10e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 18:38:57 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5525.010; Tue, 9 Aug 2022
 18:38:57 +0000
Message-ID: <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
Date: Tue, 9 Aug 2022 11:38:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, Gavin Li <gavinl@nvidia.com>
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
X-ClientProxiedBy: SA0PR12CA0001.namprd12.prod.outlook.com
 (2603:10b6:806:6f::6) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8d434a5-5959-4d3c-dafe-08da7a366b1a
X-MS-TrafficTypeDiagnostic: DM5PR10MB1833:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zndWks1h9n2QP2vSObzNiTXSdLvsNYj4qVhw/oCCkhJrGQKWk9OCG4b6Z96E/VFqL0UBoW5R9AUfa1vS++PpQsyL0kyDIprjfCRk/aN5TmjxQWNxcKc85anP3XaWHM8e3TOlt+paxaafiJNNBiEJQeMC6ex2k3RJyayJtioQQKWPmODgpCvy9lmYSWOJ5GmUQkEGJGYgGAxsrWVPNGqFLbuIIM/5QGEI0nCJLy6LaErIXmLWvh00oPkfnn3zoifVEp6+Pt59bEDke+hYNJmDlqXPZ11LMJcfOVFTKQISmMGE8uAa77XccXiKL8P/mJwZ7jzTJ141+DWBoRaHlixCuXx/VjuU6i1jJDh4kbwru67v3pfQoU6ryUERTI35FG41TlcZicLWmD0ffRtEgLuU3fFHgcAHY0yAqPc9V8L9lyKYHw22tKQC9zAn4ztJNPpXvw/tvIIjXmrQSt/S2erCpU5APrGhcId1fndwEYENxUbnZI0zjeNf6L0HjHalM6B7M85mCjdoUGqDW+36MGAaw+/sBv04z9Yhk2SlH/gQQGwb34eLDVyfFB/0ZZdKJ7EbwAZ+me1h76hGYML8yUvwQmmaQygp+uMDDaZtI2bytTxSdyjBf3zR0tR4pHOu6+oK2VkwYdBM3XnmWWIQk4vEK5ISjVK2cGN1DY4Wn58bF1oAPn5aaOffXdmFdKeaJMeosEwFxZwFrwXGTqc8HhRl/2Ps7gkYYBBQAMbEvrLTGXXVG+fJfNTQ9oQ3oLHu4hOHjyKVQRwrnI17Fsi+kta6F1zI7InHMO0bJZR+DDTkAaF0RaZrCBRpyA7t2t3Uf5GTPKu8w6gFM1enaYoAGdrKHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(136003)(376002)(366004)(39860400002)(396003)(346002)(316002)(6506007)(6486002)(478600001)(41300700001)(54906003)(110136005)(2906002)(66476007)(66556008)(4326008)(8676002)(7416002)(5660300002)(66946007)(8936002)(38100700002)(26005)(31686004)(36756003)(31696002)(86362001)(83380400001)(2616005)(186003)(6666004)(36916002)(53546011)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1BkSVJ0blNhanp2WW1zNFlyZnJILy84TzFWTmg5U2gvR2MyY0htU2pqekNZ?=
 =?utf-8?B?aHY3eWxjTTlhbE83WWE1NWpPRmx4M0dkY2lLQmJYS1NtbFQvM041Vlo0NXBX?=
 =?utf-8?B?c2FmNE9mK0ZOUWpQZU9PUmFvVmUybUxzRWp4KzI2dFJ4VzZaNVlGYUM5UHlG?=
 =?utf-8?B?T2xzRGpTUGVvcGUwR3NIbmFuTTZwci9Ed0RwOFE5R2Z5ODVHdXQyWStsUWUy?=
 =?utf-8?B?R1lDdUdPalp0ejZkN2JVUktwZUZlcTNjUlFvdTR0UiszaHExcDE0SDdXYStj?=
 =?utf-8?B?ZUcvUnRxY0JRbXZKSVpFSXV5bjJPazRMdTd3THA2bm04aVFCVUwzUFo0VU52?=
 =?utf-8?B?OEQ5M0cvdjl3SjFZUEs0YzBPcHYrRm4xWCtScjY3Qmp4VEFPN01sb0xBZTZ3?=
 =?utf-8?B?VUlnRHhpb296VVFiYXZCaENZd0ZUOEg1WEtJTmEyeml6R2IyR2NNNkRTQkdY?=
 =?utf-8?B?VElvV09hN0RCNDJrSzA4alZ2YnJSWHdLVkN0d2pCNTVuZ1JNZVhDVDUxOE02?=
 =?utf-8?B?K3NjM1BvM0ZMVnVXcHdWKzd0R09YLy9Gb0VTNjVKbDF4dEJXU1lGY29COSsv?=
 =?utf-8?B?TS9aeTVWOTB1ZlFjTUlBVlJlVFZZTnBwMnk4NHhaaGNLQnlFQTQ4SUNSbzM2?=
 =?utf-8?B?NjBQZXU0QVEySWpMMTljSStYQ1QwT255U0hCbU1BcEJMTWNWekdVL3RIMW5V?=
 =?utf-8?B?aW9kNEQ0VUpWVXI0TTZURTBFY2lsK3dQYndEVnFJYjFQT1ROVFBiMTRMS2p5?=
 =?utf-8?B?aVFtTG5Fb2FWanpJcU1COC9La2wxTUVQODZ1d0RKQ0F2MHd6K2drUkVRcDFB?=
 =?utf-8?B?R2FuVFhiWmUyZTNuSDFRY2w1dCtRQ1ZuMG9OMXh4cXhZYlRabUdGRFdCTEVP?=
 =?utf-8?B?dHhIenBwK3MrUnkydm8xaS9ESkF1SFZteTcxU21lSGFDZXJkdXVHaEE0ZjhR?=
 =?utf-8?B?d0ZXSm5qSTY1eWRlUFdTMURzVitWYWNJMEFaWkp6U1NjRXo1UE9YUEdqNGFP?=
 =?utf-8?B?UmNmdGZVUFpGcUt4aFNidFNtUVVsWmFYNHo2elhTMFhrY1JLb09pR0tOOEt6?=
 =?utf-8?B?N2RIQzlPTndrbG9WdDNIcis0SnA3cW1WYVA4OWlvM0NpVGxzZVRCK2tyTFNU?=
 =?utf-8?B?WGRQNm15Zy9HL2NCNFZwcXIyMzQ5TG51VEpiVlVMZlJ1V3Z6SlcwRlhZZUg1?=
 =?utf-8?B?OFNjSmhhQXJ0YTZYSFhDR0hGRkFGNUNsZWpyZzFBdlgzS3psZWp2S1FSdVJv?=
 =?utf-8?B?SVB4VW9QcnlxM2g5cEdDTjBsSU1TaWRyL3IwM1dqc0VGTGVLTURSaDk0cEw3?=
 =?utf-8?B?VzJHRTkxd1piQTZjUHUzT1FtVW95Wm84R2o0VkJTczJNenJjejRaQTh3S3Rk?=
 =?utf-8?B?Y3RKeE9vNFg4RysyR3lnTGxUamFKYitVSUxSSnhTbnpCcmdQckpOS1duU2I3?=
 =?utf-8?B?dUR4MGo1bkw5amVFZTNHdVFsMUN3WVhlQ21jZ2x5WDBCMzA1dWtlbUtaN0JU?=
 =?utf-8?B?U2lYaE9RclBmcmgvbWUxdlZaTzdkeE5FTnM0cE0wdEVkYnQ1akpxZHhyR2VG?=
 =?utf-8?B?OTRiVTUzOWRhNEJDOHEvTVVMRlNRUmMzZElESkNneko3Zk5SYmhZdElLcXNC?=
 =?utf-8?B?UFY5YXRqZjdXeVBTdTBiOVVYdlQzVUMvZitZQnIzRjAwazBWc2EvSXJYY1Vp?=
 =?utf-8?B?MlR4VUNGcTdEWTJSbXJpbzF3M2l1OTdtT3UzNDloMnFnVStZV014VDR5dU9E?=
 =?utf-8?B?WjUxV3gzNERZTnBPNEdPNWJGVTRKYStpUjIrWDFZNlZxL1NwZWVoQWVMS3I3?=
 =?utf-8?B?VFFxZGJZZHR3NXh4NlkvZklySEdha0NLK1NRTmhYYTU3M091VVcvQU03dnZh?=
 =?utf-8?B?QzNFU3FzSHZwclV0Z0tPeHdScE1wQlJtay9TM29sYWE0M0NCQkxWZXdTL1Ri?=
 =?utf-8?B?YW45eSttNm52bkFLWGo1ZHE2QkZ3VWlmQk9Ebnh6cHRMcFQxRmx1WjRWL2xp?=
 =?utf-8?B?NmpDWFY1ZFc0dENaWE5KRkZYTDNFY1lWRFhFS2hQQ0JIK05aaEQ1czV1MlpG?=
 =?utf-8?B?OHpob3ZRZkR5bktLOW5rMVFXYzlsUGhhYk1XSGZZN2I4a1UwWENraWg0YTll?=
 =?utf-8?Q?hgoBYsJD/V3eBtAMdFnrhrLZt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d434a5-5959-4d3c-dafe-08da7a366b1a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 18:38:57.1809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZGlwyoMNdBw066DVHV1p0eEb7wzzDv6eNb9bnZgcq5CoXGTUSLwA8+TIIT0mZhY+p0jw2LVq5s1dZeaQUnz6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208090071
X-Proofpoint-ORIG-GUID: Mj9RzhujYofVgDXZ5cOg-yl-2pKUIwPv
X-Proofpoint-GUID: Mj9RzhujYofVgDXZ5cOg-yl-2pKUIwPv
Cc: alexander.h.duyck@intel.com, Virtio-Dev <virtio-dev@lists.oasis-open.org>,
 mst <mst@redhat.com>, kubakici@wp.pl, sridhar.samudrala@intel.com,
 jesse.brandeburg@intel.com, gavi@nvidia.com,
 virtualization <virtualization@lists.linux-foundation.org>, "Hemminger,
 Stephen" <stephen@networkplumber.org>, loseweigh@gmail.com,
 davem <davem@davemloft.net>
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



On 8/9/2022 12:44 AM, Jason Wang wrote:
> On Tue, Aug 9, 2022 at 3:07 PM Gavin Li <gavinl@nvidia.com> wrote:
>>
>> On 8/9/2022 7:56 AM, Si-Wei Liu wrote:
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On 8/8/2022 12:31 AM, Gavin Li wrote:
>>
>>
>> On 8/6/2022 6:11 AM, Si-Wei Liu wrote:
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On 8/1/2022 9:45 PM, Gavin Li wrote:
>>
>> Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
>> packets even when GUEST_* offloads are not present on the device.
>> However, if GSO is not supported,
>>
>> GUEST GSO (virtio term), or GRO HW (netdev core term) it should have
>> been be called.
>>
>> ACK
>>
>>
>>    it would be sufficient to allocate
>> segments to cover just up the MTU size and no further. Allocating the
>> maximum amount of segments results in a large waste of buffer space in
>> the queue, which limits the number of packets that can be buffered and
>> can result in reduced performance.
>>
>> Therefore, if GSO is not supported,
>>
>> Ditto.
>>
>> ACK
>>
>>
>> use the MTU to calculate the
>> optimal amount of segments required.
>>
>> Below is the iperf TCP test results over a Mellanox NIC, using vDPA for
>> 1 VQ, queue size 1024, before and after the change, with the iperf
>> server running over the virtio-net interface.
>>
>> MTU(Bytes)/Bandwidth (Gbit/s)
>>                Before   After
>>     1500        22.5     22.4
>>     9000        12.8     25.9
>>
>> Signed-off-by: Gavin Li <gavinl@nvidia.com>
>> Reviewed-by: Gavi Teitz <gavi@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> ---
>>    drivers/net/virtio_net.c | 20 ++++++++++++++++----
>>    1 file changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index ec8e1b3108c3..d36918c1809d 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -222,6 +222,9 @@ struct virtnet_info {
>>        /* I like... big packets and I cannot lie! */
>>        bool big_packets;
>>
>> +     /* Indicates GSO support */
>> +     bool gso_is_supported;
>> +
>>        /* Host will merge rx buffers for big packets (shake it! shake
>> it!) */
>>        bool mergeable_rx_bufs;
>>
>> @@ -1312,14 +1315,21 @@ static int add_recvbuf_small(struct
>> virtnet_info *vi, struct receive_queue *rq,
>>    static int add_recvbuf_big(struct virtnet_info *vi, struct
>> receive_queue *rq,
>>                           gfp_t gfp)
>>    {
>> +     unsigned int sg_num = MAX_SKB_FRAGS;
>>        struct page *first, *list = NULL;
>>        char *p;
>>        int i, err, offset;
>>
>> -     sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
>> +     if (!vi->gso_is_supported) {
>> +             unsigned int mtu = vi->dev->mtu;
>> +
>> +             sg_num = (mtu % PAGE_SIZE) ? mtu / PAGE_SIZE + 1 : mtu
>> / PAGE_SIZE;
>>
>> DIV_ROUND_UP() can be used?
>>
>> ACK
>>
>>
>> Since this branch slightly adds up cost to the datapath, I wonder if
>> this sg_num can be saved and set only once (generally in virtnet_probe
>> time) in struct virtnet_info?
>>
>> Not sure how to do it and align it with align with new mtu during
>> .ndo_change_mtu()---as you mentioned in the following mail. Any idea?
>> ndo_change_mtu might be in vendor specific code and unmanageable. In
>> my case, the mtu can only be changed in the xml of the guest vm.
>>
>> Nope, for e.g. "ip link dev eth0 set mtu 1500" can be done from guest on
>> a virtio-net device with 9000 MTU (as defined in guest xml). Basically
>> guest user can set MTU to any valid value lower than the original
>> HOST_MTU. In the vendor defined .ndo_change_mtu() op, dev_validate_mtu()
>> should have validated the MTU value before coming down to it. And I
>> suspect you might want to do virtnet_close() and virtnet_open()
>> before/after changing the buffer size on the fly (the netif_running()
>> case), implementing .ndo_change_mtu() will be needed anyway.
>>
>> a guest VM driver changing mtu to smaller one is valid use case. However, current optimization suggested in the patch doesn't degrade any performance. Performing close() and open() sequence is good idea, that I would like to take up next after this patch as its going to be more than one patch to achieve it.
> Right, it could be done on top.
>
> But another note is that, it would still be better to support GUEST GSO feature:
>
> 1) can work for the case for path MTU
> 2) (migration)compatibility with software backends
>
>>
>> +     }
>> +
>> +     sg_init_table(rq->sg, sg_num + 2);
>>
>>        /* page in rq->sg[MAX_SKB_FRAGS + 1] is list tail */
>>
>> Comment doesn't match code.
>>
>> ACK
>>
>> -     for (i = MAX_SKB_FRAGS + 1; i > 1; --i) {
>> +     for (i = sg_num + 1; i > 1; --i) {
>>                first = get_a_page(rq, gfp);
>>                if (!first) {
>>                        if (list)
>> @@ -1350,7 +1360,7 @@ static int add_recvbuf_big(struct virtnet_info
>> *vi, struct receive_queue *rq,
>>
>>        /* chain first in list head */
>>        first->private = (unsigned long)list;
>> -     err = virtqueue_add_inbuf(rq->vq, rq->sg, MAX_SKB_FRAGS + 2,
>> +     err = virtqueue_add_inbuf(rq->vq, rq->sg, sg_num + 2,
>>                                  first, gfp);
>>        if (err < 0)
>>                give_pages(rq, first);
>> @@ -3571,8 +3581,10 @@ static int virtnet_probe(struct virtio_device
>> *vdev)
>>        if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>>            virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
>>            virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
>> -         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
>> +         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO)) {
>>                vi->big_packets = true;
>> +             vi->gso_is_supported = true;
>>
>> Please do the same for virtnet_clear_guest_offloads(), and
>> correspondingly virtnet_restore_guest_offloads() as well. Not sure why
>> virtnet_clear_guest_offloads() or the caller doesn't unset big_packet on
>> successful return, seems like a bug to me.
> It is fine as long as
>
> 1) we don't implement ethtool API for changing guest offloads
Not sure if I missed something, but it looks the current 
virtnet_set_features() already supports toggling on/off GRO HW through 
commit a02e8964eaf9271a8a5fcc0c55bd13f933bafc56 (formerly misnamed as 
LRO). Sorry, I realized I had a typo in email: 
"virtnet_set_guest_offloads() or the caller doesn't unset big_packet ...".

> 2) big mode XDP is not enabled
Currently it is not. Not a single patch nor this patch, but the context 
for the eventual goal is to allow XDP on a MTU=9000 link when guest 
users intentionally lower down MTU to 1500.

Regards,
-Siwei
>
> So that code works only for XDP but we forbid big packets in the case
> of XDP right now.
>
> Thanks
>
>> ACK. The two calls virtnet_set_guest_offloads and
>> virtnet_set_guest_offloads is also called by virtnet_set_features. Do
>> you think if I can do this in virtnet_set_guest_offloads?
>>
>> I think that it should be fine, though you may want to deal with the XDP
>> path not to regress it.
>>
>> -Siwei
>>
>>
>>
>> Thanks,
>> -Siwei
>>
>> +     }
>>
>>        if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
>>                vi->mergeable_rx_bufs = true;
>>
>>
>>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
