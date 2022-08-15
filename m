Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CEAC00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 23:32:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70B5C60BAE;
	Mon, 15 Aug 2022 23:32:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 70B5C60BAE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=CsJpQHqq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=lT/sdYVW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tkjt3VvNBgcl; Mon, 15 Aug 2022 23:32:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9F69B60B97;
	Mon, 15 Aug 2022 23:32:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F69B60B97
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80113C0033;
	Mon, 15 Aug 2022 23:32:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93A5AC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 23:32:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 705CB40992
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 23:32:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 705CB40992
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=CsJpQHqq; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=lT/sdYVW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PIR0ORU8PGQy
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 23:32:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 861CA4098F
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 861CA4098F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 23:32:13 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FNR9aQ031996;
 Mon, 15 Aug 2022 23:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=LPFkfikKwmmFSNJZ128GbONY7OJfOV+wEbcIpRp+HV8=;
 b=CsJpQHqqIzZ4vC7O72U4o/YenEUZqhTYbPhuH9Mgd3XHuyKCBClEWXnjLfPILh6IdX7S
 UiZtx7L/XcZlpY0mkHtz0Yta2UvK6Z597lXCjw9JJMJjaGmfX+2f84qfG0m1wTgfJcJp
 u5yaFyg+SNCWePHKCAY/BwtzlguEdSOj2rUppf4XeDJZgx39AKs9RioEtIwIG9syYI79
 DGbHyETdQSyvMufViG9eRCQt4LhfcO8Rrgz/b/6H/pM6qNFH/BIW7/NqStytYZ9iHLI9
 9UKutMoe5hqGJMtDfA40EdPjPYTNXpbvD/F4pFgNvvn1vAL2RaoS2wA+LZq0gpn4OWrP Dg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx3ua48uy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Aug 2022 23:32:08 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 27FL52tv023141; Mon, 15 Aug 2022 23:32:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hx2d1v466-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Aug 2022 23:32:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRaotehQ1AKKyAhYbpRuUXinih773WkVQEJZJVINoaNLmwl3+PWHqQI32hCq0qWIEEGqrErjUpuQ/N0jWWsSdg7iUagCAGyhG5M5TXIjUgYrE9dOWRrDOzvY5NK538vHEtaIch9Hjrv1I6by0j2DgadIYjgrtUTto8FfLuzZYjgFqXRVeVu5CXK9sbPLSUQE4OV8hN+gpVEMfLLNXw+/e/87iZK2O5SE5uGoNXaB6pMuSaNkDrpO2keZa0+FxeoFoIjQE2pFfrtMOlPN12gz5MBkLF99Tt7Qi9TfCymLlZOmKAzZJUes9aEYLwSHisgC+E0n1vHUMKTBYdNFo+BJyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPFkfikKwmmFSNJZ128GbONY7OJfOV+wEbcIpRp+HV8=;
 b=eb26ucW1SYaSw5SpOnb4Vc0WAmgH6jeQlnsX4A6gLJm5nmSubGVedr9MrsGPy7sUosp2mqqok/rJO3SyyxXaA89eBanlBhH/jj++VhbminVFAmt0sPgiW+ZltqCSy6jL76fljo9Ed5myNdoiZLL+0slj/aVwP39s+AgSsvMCsxPvTvSTLPfd5Dy+9rQ3uaW+EYE33K2BtjYeH3x4o7wsnAYejzPgiIL5HMGzTqEpvMAX2swcLpP9d/JOEjlpvfNaWIwsUGiYdmTpTaqLeKEY4nANTTYBQqzhY7zeqEabk3BbVvPnUAOdv3MWdUhmZnOj+f5g34xUqoEu7e4dW26d3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPFkfikKwmmFSNJZ128GbONY7OJfOV+wEbcIpRp+HV8=;
 b=lT/sdYVWGjLesBytEyBQ5WCJbz6AtOlFOjnhPfRVp2f5jvb3XLDb/pfKrIhWQnosXzP93qDLgppx80DJ6PGuE0Wi+OqG1NC9lsAJKFC/9ZHaOQx0CqqQcA5TPbRK4VoNRhynkPgGe0zhaORk/6ccX120tvn+4dFSGMfpigTNhD4=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by DM6PR10MB3755.namprd10.prod.outlook.com (2603:10b6:5:1d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Mon, 15 Aug
 2022 23:32:05 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5525.010; Mon, 15 Aug 2022
 23:32:05 +0000
Message-ID: <c5075d3d-9d2c-2716-1cbf-cede49e2d66f@oracle.com>
Date: Mon, 15 Aug 2022 16:32:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] vDPA: conditionally read fields in virtio-net dev
Content-Language: en-US
To: Zhu Lingshan <lingshan.zhu@intel.com>, jasowang@redhat.com, mst@redhat.com
References: <20220815092638.504528-1-lingshan.zhu@intel.com>
 <20220815092638.504528-3-lingshan.zhu@intel.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220815092638.504528-3-lingshan.zhu@intel.com>
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f086930-f7ae-4f90-44af-08da7f165cd9
X-MS-TrafficTypeDiagnostic: DM6PR10MB3755:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QrIdBMxa/oU0IF2W7/njj20aMGR78pXCN5ZcUuflW6/mqPs4aow1FA5BuegVBWxauM9hYxOAx/KTybdvZtg+41Zbv+bPVMde4wYAPA6G6bkqMNTZpB0AIRZA2ePc/Hwo+pgZ3wymWaVpwRA0hf0kiRsnoF9JUhHyHL6rywMw246mE5Y7fXnUK8fBwppPrr2ONc8UvDvyM9qqlBg/PL5Rvdc38OeF6cSX4kaam7sarA906qcX28k1m9V60hSPpJYE+Hwn9Bqld4ab8DIf9FKuS81de11K7vmQUmsRPcDJsWOCsZrWdcAWXDwWUHeiLpU3fVjpInF+vF4nrrEcodwb6DmGe02tSqsYfH1RC7mJCxjk268FP+FM6/d+OoJIIF5xH4RR88ZDthDouRa+9par0c3v0qWjwM+kqai35NOHYP11akkwEWGj9z6TSBP6j3acil4KzG/x7xeBuvlgrsJDhcpn4em2clU1Xs0CAlZ0d+lPEmuLXpAhhttCaFBC+FGcPubJLiYcM0JSvH997N+F12KfZtwBerynm77hVuFICwKyLdjOJJ78DUmlApallS3dqzJbVo3YGIC7IWr7Bpb0cgIUlKc8ScehH7ayuZzXGcs8H63x0Qz1to2CmQv6Wcza4YvyE+95Md5K/hdatpFlwBmetetddjmkyUIuVRf4t2HV0wQlbjlCYTHf5ROefpdUx2Wsr3eVWo3Hp1Y0exPZF9JiPBRP9tRHmJ9MEo23AEklHTrOmvsaC4Bqyq59rewMAXdl7YPayqzx0t7PzoIViYFcXWmggilkZbgkLR62nySpiNizNWdl8ymYsOUFWI6gyl5F7CXD0r294MIfTvOH37qzlLuXIx4MtQIMU8o6wek=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(376002)(39860400002)(136003)(366004)(346002)(396003)(83380400001)(31696002)(38100700002)(66476007)(66946007)(8676002)(66556008)(86362001)(316002)(8936002)(2906002)(5660300002)(53546011)(26005)(36916002)(6506007)(6512007)(2616005)(186003)(4326008)(6666004)(6486002)(478600001)(41300700001)(31686004)(36756003)(21314003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUYwT1FkQkIxeE5RVVBpb29XelhTQ0VkbENOUkdCeGhaOHJJamlUaFllbGJz?=
 =?utf-8?B?ZjNTZEIxWFoyNit0K3FnZXRHNnJSK1FXOG9IZ2E1WnYrMVNYeXZvcGh0Uk1C?=
 =?utf-8?B?UzVDbWZpNzVYYlNYUHFUZzQ0ZFdpR0xTelM1b0dYTjUzenBtTmRCaFAvOVA0?=
 =?utf-8?B?YndIRWRKN3ZZSVAvRkpMNkRuZHZsUlJXRE84bCtUd0VWQis3K3F0bDZ6Vldk?=
 =?utf-8?B?RVViMi9XWFZESyswNkJnR3NEb3A5aFJKMi9uSC9kbWZuck5VZmFSb2dSMzdm?=
 =?utf-8?B?RTNxMFZJSFBRNW1OK3F3S0NDVWRMR1l1c1JNT0NqNTUyYmYzK1lqc1JTTU5F?=
 =?utf-8?B?Vzc4VS83cFJ0b01CekhzeUlIQU5NSWlBbUYyUmtBZ3BtWnhaM2NRaUpsMi9Z?=
 =?utf-8?B?TTJHWHFncUNGOUNFTlIwWTJBcjYxYy92c200aXp3WHdGSVN5QndmWFdZSjFo?=
 =?utf-8?B?THJKODh4eTlWb0tieUVKWWFzUGJQOXErRHVvWG41QmN3cmlqNmxQTnN6eTl4?=
 =?utf-8?B?TTBFbTJsaVpVMmFkUk5UN29LZlBGOGpjanVpSDY5OUxJck5jVW93SklyeWIv?=
 =?utf-8?B?NmRYUTlSTGF5QU5sNU01ZzA4K2xEUTFCVjVsTWNiZHMyZVY5TVNrMGxHTEx5?=
 =?utf-8?B?djZtTWEyMnR3WU9HaDVvampYN0txZXA3WCtNbWN2RFQwUVVRWFVRNDNLZzY3?=
 =?utf-8?B?NFFjRTc3d3AzdTJJNnBDNFAyUDVxbzRLUEQ1N0poOFRuZzk1YWFIYUZGY0ZM?=
 =?utf-8?B?ZmdLZy8zcEZ3aG9OUWxnTS9iWEVlbnZWUVZidEtyeTM0VFJIemRqbFA5UDBG?=
 =?utf-8?B?MmYrNnRVWHo3VVFEcU1KTEJKc1pLd1g5UWJlWWtLQlJZM2JXS21UdGJQaHRq?=
 =?utf-8?B?Ukt6QUhGMHp4dDYyVHAyV3REcnFFUVJKb3dpUStkZFFtS2F3UW9QTTRNUVRw?=
 =?utf-8?B?QXBWNmV6Y3U0NGZUbGN4ZURRa2p2WTR6MnlwQytjMkkvOEF6UG9LZmpIa1B1?=
 =?utf-8?B?OHRlMXRLVllhSTZQdC80TUtCSTlOU0YrakJ1dnZsUjREMllEK1BlN2VzMG00?=
 =?utf-8?B?MHV2cEkzVUxZVkkrcUNVS2hDUEpla0RKYzhXTE9rYnZSNm80blVzZFdFMWdS?=
 =?utf-8?B?ak82MTNPSVIzSzJPdnNmUkJCY3RyeUh1eUo0UUhtckY1b0gvcG1uNlB5N2Q1?=
 =?utf-8?B?ZHVRZFdHbHhxekNaalNRdUN0dHZzcWJiQ1JzdnZQc2V1MkNDdUlFa3dlSW1J?=
 =?utf-8?B?UkpTQWZDL05JT255OEY0a2dFSGJyYzdsSEpRak05VmZBZVJ0Vm5JZ0ZXckhZ?=
 =?utf-8?B?YUM3S1BRUFB4L09YTlZNMHBIOE1XR0cyUVViSTlhbm1zNm1yVTBEL1VFSXBL?=
 =?utf-8?B?QTdEMDJYeG5XYU0rSkNsRC81ZDJiNmQ5MHBvQTFSbG5pdGZzT29odmM3QUFN?=
 =?utf-8?B?YWtXamlBRmxLTWpxK3VSTEwybXJpc1VFN2dmbHdMQzI0NzM4ZkI5MmVnOTRk?=
 =?utf-8?B?a1JGYkxKamR6RDZGdFo5Z0dieStzQVZtRGJsN0s2dkxRVkg3bEJwM05pL2M4?=
 =?utf-8?B?QnQyZENSMkkvTUVHOXhSOTlmOU9nR1ZZWXZwUDBPRE1GeDhYWHVmYWRNUTE1?=
 =?utf-8?B?aFpsSmx6RTc2QnN5TUxuTEVoa2dycU9kVWZPUGJObW5rYXE3a1dYK05NMUQ2?=
 =?utf-8?B?SlptVnZLMUJITW5EM1IvMGk0M2JhV0pWSCt6bmVRTjlWanBqcUpDK2wvZURC?=
 =?utf-8?B?MHRmbGEzNjdQQWxKYlNiWlhsTXJYaUovNE5XMkpyVmFzYTFkcE1yUHJ2Vmw4?=
 =?utf-8?B?THFrc2pOdWdDQnpUdzUxY0FkWlpVNnNhdUxFU3c1QWc1NUVFUWhOTThzYTd2?=
 =?utf-8?B?ZTlOUDdwdE1XaXBhR2FweitVSGJyZWd0S2V6ZGlVdFdlQjZYcThzV0pvbEl1?=
 =?utf-8?B?NVRXT3RKUmxab0c5SlVOQzZ5dWRDUGN3VW1TSWFET3lvV29DVkQ0QVVxTlhn?=
 =?utf-8?B?bkphR3R2MGZHY2FMTkduRUVTUEVwZG8xYlE0L0FXQUROZVBMdzdYM3QzSmtC?=
 =?utf-8?B?T3RkOWdncmdKaGg1UWJ3OTlaMzYrSWNpdi90NXQ3clhTeVRNSmhhazdyVlBC?=
 =?utf-8?Q?EUYxs9fr8Tou7VKaBJ+yvD+ZI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?d3puT0JtZ0RidUZzQ1ZJZXhXb1FKYW9ydlFRd0lremFFOVRVMFg3UUhlTURz?=
 =?utf-8?B?cmFrb3NEZTRsRldWWVRUWFZWYkVYK1V0c2Z0OENaOTV3YzFtYjFIOG5GRmZl?=
 =?utf-8?B?Lys4c0RyT2lwcVRxUExCa05peXJGMmY2anVFZnZIZFRpdjBDek52a1NvNVVs?=
 =?utf-8?B?dHN1UjlNbzEvdG5EeDNMYjFEVHA5QmJNU1FHT0pOQlU2bHlQRnU4SnNRNzI2?=
 =?utf-8?B?MkJ1QjVZQnBoZndaWjhXUE8zQ2RXY0loRkdRaUlkbXBmeC9iR1diaUhaZmRP?=
 =?utf-8?B?VkhsYThScFdacW96TGxXcS9HOTVxOXNtbjlITExGR1pDQmJaaWdObmJCWVRN?=
 =?utf-8?B?OG1La1QyeTZ3RnZaZ2htSzh3b25QS2puc3IxY3d3QVZ5enc5V3pxWkcrVXRB?=
 =?utf-8?B?QWhua2h3bG0zRkZGRlp0em9QWjNsMis1aThWZ0dCeDhmQVJjVVpYSlhyRWNX?=
 =?utf-8?B?SlZ5MjBvd3c5ajZrTm11emIrVXRSMVM4S3A4S2hlVHliOU9oc2s5MVBtQkNV?=
 =?utf-8?B?dE9kT1FiVThlWjJhdmhBZks0SHpVekZLallKejNOR2hQTWxNQjI1M0hhKzhs?=
 =?utf-8?B?UndGQk9Jc0pGQm1pQjJnL0s0SEhOalBMTWZudyswZ0FxWWx1dVk0RFNxeW5P?=
 =?utf-8?B?aDdCNmtDUWwwQXNKc1lrdGllTk1OdllFdUg3RGVSSThvclU5SVBsUkVUcVNt?=
 =?utf-8?B?RFJXYXFIaXl4SWl6NElCOTBOMmdtNXlqMXhFVUhIMUlteFdPTlJzbmRyWk9y?=
 =?utf-8?B?K3NlNGFGSTRCSU85ai9vTVFiNlpPNjZtbnBockR3UFBud0NJZGs0S3hDclR0?=
 =?utf-8?B?ck1SZm1Nc214NXQ1UmMvUUc5SGtJL2ZkRU8vSWpYdnVXREtXRUR3aDRuK2dP?=
 =?utf-8?B?NUxyaUd3TkZJcitaUmpzRGlUdWc1TmV4WlBlWWQwa3Y4U1VhUkE4TVR1SUhH?=
 =?utf-8?B?MUxPclc3TnRqaVpiems2K0pNakNoaHE4d2dVZU40Rk5hUTJ6QjZYZ0tWQUd1?=
 =?utf-8?B?MXp1dFpSRE5CSFVrUXIzNmVncTNlWjE4MjZWdFFKWmU1UmYrcVNoenNTeXRF?=
 =?utf-8?B?aGJoL3dBZnFvT2N6NWROaXFZZmRyMzVleEtNdS9jOUdpT0NISUUwOVdLS045?=
 =?utf-8?B?dWZJcnoyN0tIYWFCUWZ4Um1UVVltaGdYSFMzUzFWeG1WVk1JWXk3Ym92N3hD?=
 =?utf-8?B?am9wVTliNEtTVDgzamVKTUhMd1VYYW1yUmdmS09SV0NtaHdKL2IyejR0MHdM?=
 =?utf-8?B?Z3paYnBoSE9FVi9leFlNN1RzdjRkcEdxSG1Ta0NzZEN4K05maEM4d2xBYTl5?=
 =?utf-8?B?T2NSRElIRENzcnpFenRaNi9Oa20wL0J2Vy9hWThTSDBPc3d6cDBwK0IvbVUz?=
 =?utf-8?B?cE1ZSnZabjJFeVl2OUcwb2JlM1VEazlDV3ViM2MxaHBIS28vY0RTNHRVQVor?=
 =?utf-8?B?cmlmRlkzVEFPc3NrYWJJY0pEU28rVUtlc2ZuYW9JYUNUSjYvWnhvd2FZbmV3?=
 =?utf-8?B?YW0yU0xjQTBselVyeGNEcU9qWTZ6emV6aThpYjdLck1QREVUMHEzcnVLVTFs?=
 =?utf-8?Q?rHxx7P6i5TMwwKmoc/QsgkTJfK6m++Gpyh64HzZtwA+b0L?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f086930-f7ae-4f90-44af-08da7f165cd9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 23:32:05.3690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgxokoCMoSsLOLLIym6wgeD6s/MIsh3wfn1aMJShgPRzt7qhi4uPcGe2pyCKYZWGEgxd7IPS7xBd+y+H9TANdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3755
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150090
X-Proofpoint-ORIG-GUID: zfMyYKDd-_j3MBeNLrtUyQ4geuqGguUm
X-Proofpoint-GUID: zfMyYKDd-_j3MBeNLrtUyQ4geuqGguUm
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 gautam.dawar@amd.com
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

CgpPbiA4LzE1LzIwMjIgMjoyNiBBTSwgWmh1IExpbmdzaGFuIHdyb3RlOgo+IFNvbWUgZmllbGRz
IG9mIHZpcnRpby1uZXQgZGV2aWNlIGNvbmZpZyBzcGFjZSBhcmUKPiBjb25kaXRpb25hbCBvbiB0
aGUgZmVhdHVyZSBiaXRzLCB0aGUgc3BlYyBzYXlzOgo+Cj4gIlRoZSBtYWMgYWRkcmVzcyBmaWVs
ZCBhbHdheXMgZXhpc3RzCj4gKHRob3VnaCBpcyBvbmx5IHZhbGlkIGlmIFZJUlRJT19ORVRfRl9N
QUMgaXMgc2V0KSIKPgo+ICJtYXhfdmlydHF1ZXVlX3BhaXJzIG9ubHkgZXhpc3RzIGlmIFZJUlRJ
T19ORVRfRl9NUQo+IG9yIFZJUlRJT19ORVRfRl9SU1MgaXMgc2V0Igo+Cj4gIm10dSBvbmx5IGV4
aXN0cyBpZiBWSVJUSU9fTkVUX0ZfTVRVIGlzIHNldCIKPgo+IHNvIHdlIHNob3VsZCByZWFkIE1U
VSwgTUFDIGFuZCBNUSBpbiB0aGUgZGV2aWNlIGNvbmZpZwo+IHNwYWNlIG9ubHkgd2hlbiB0aGVz
ZSBmZWF0dXJlIGJpdHMgYXJlIG9mZmVyZWQuCj4KPiBGb3IgTVEsIGlmIGJvdGggVklSVElPX05F
VF9GX01RIGFuZCBWSVJUSU9fTkVUX0ZfUlNTIGFyZQo+IG5vdCBzZXQsIHRoZSB2aXJ0aW8gZGV2
aWNlIHNob3VsZCBoYXZlCj4gb25lIHF1ZXVlIHBhaXIgYXMgZGVmYXVsdCB2YWx1ZSwgc28gd2hl
biB1c2Vyc3BhY2UgcXVlcnlpbmcgcXVldWUgcGFpciBudW1iZXJzLAo+IGl0IHNob3VsZCByZXR1
cm4gbXE9MSB0aGFuIHplcm8uCj4KPiBGb3IgTVRVLCBpZiBWSVJUSU9fTkVUX0ZfTVRVIGlzIG5v
dCBzZXQsIHdlIHNob3VsZCBub3QgcmVhZAo+IE1UVSBmcm9tIHRoZSBkZXZpY2UgY29uZmlnIHNh
cGNlLgo+IFJGQzg5NCA8QSBTdGFuZGFyZCBmb3IgdGhlIFRyYW5zbWlzc2lvbiBvZiBJUCBEYXRh
Z3JhbXMgb3ZlciBFdGhlcm5ldCBOZXR3b3Jrcz4KPiBzYXlzOiJUaGUgbWluaW11bSBsZW5ndGgg
b2YgdGhlIGRhdGEgZmllbGQgb2YgYSBwYWNrZXQgc2VudCBvdmVyIGFuCj4gRXRoZXJuZXQgaXMg
MTUwMCBvY3RldHMsIHRodXMgdGhlIG1heGltdW0gbGVuZ3RoIG9mIGFuIElQIGRhdGFncmFtCj4g
c2VudCBvdmVyIGFuIEV0aGVybmV0IGlzIDE1MDAgb2N0ZXRzLiAgSW1wbGVtZW50YXRpb25zIGFy
ZSBlbmNvdXJhZ2VkCj4gdG8gc3VwcG9ydCBmdWxsLWxlbmd0aCBwYWNrZXRzIgpOb3RlZCB0aGVy
ZSdzIGEgdHlwbyBpbiB0aGUgYWJvdmUgIlRoZSAqbWF4aW11bSogbGVuZ3RoIG9mIHRoZSBkYXRh
IApmaWVsZCBvZiBhIHBhY2tldCBzZW50IG92ZXIgYW4gRXRoZXJuZXQgaXMgMTUwMCBvY3RldHMg
Li4uIiBhbmQgdGhlIFJGQyAKd2FzIHdyaXR0ZW4gMTk4NC4KQXBwYXJlbnRseSB0aGF0IGlzIG5v
IGxvbmdlciB0cnVlIHdpdGggdGhlIGludHJvZHVjdGlvbiBvZiBKdW1ibyBzaXplIApmcmFtZSBs
YXRlciBpbiB0aGUgMjAwMHMuIEknbSBub3Qgc3VyZSB3aGF0IGlzIHRoZSBwb2ludCBvZiBtZW50
aW9uIHRoaXMgCmFuY2llbnQgUkZDLiBJdCBkb2Vzbid0IHNheSBkZWZhdWx0IE1UVSBvZiBhbnkg
RXRoZXJuZXQgTklDL3N3aXRjaCAKc2hvdWxkIGJlIDE1MDAgaW4gZWl0aGVywqAgY2FzZS4KCj4K
PiB2aXJ0aW8gc3BlYyBzYXlzOiJUaGUgdmlydGlvIG5ldHdvcmsgZGV2aWNlIGlzIGEgdmlydHVh
bCBldGhlcm5ldCBjYXJkIiwKUmlnaHQsCj4gc28gdGhlIGRlZmF1bHQgTVRVIHZhbHVlIHNob3Vs
ZCBiZSAxNTAwIGZvciB2aXJ0aW8tbmV0LgouLi4gYnV0IGl0IGRvZXNuJ3Qgc2F5IHRoZSBkZWZh
dWx0IGlzIDE1MDAuIEF0IGxlYXN0LCBub3QgaW4gZXhwbGljaXQgCndheS4gV2h5IGl0IGNhbid0
IGJlIDE0OTIgb3IgZXZlbiBsb3dlcj8gSW4gcHJhY3RpY2UsIGlmIHRoZSBuZXR3b3JrIApiYWNr
ZW5kIGhhcyBhIE1UVSBoaWdoZXIgdGhhbiAxNTAwLCB0aGVyZSdzIG5vdGhpbmcgd3JvbmcgZm9y
IGd1ZXN0IHRvIApjb25maWd1cmUgZGVmYXVsdCBNVFUgbW9yZSB0aGFuIDE1MDAuCgo+Cj4gRm9y
IE1BQywgdGhlIHNwZWMgc2F5czoiSWYgdGhlIFZJUlRJT19ORVRfRl9NQUMgZmVhdHVyZSBiaXQg
aXMgc2V0LAo+IHRoZSBjb25maWd1cmF0aW9uIHNwYWNlIG1hYyBlbnRyeSBpbmRpY2F0ZXMgdGhl
IOKAnHBoeXNpY2Fs4oCdIGFkZHJlc3MKPiBvZiB0aGUgbmV0d29yayBjYXJkLCBvdGhlcndpc2Ug
dGhlIGRyaXZlciB3b3VsZCB0eXBpY2FsbHkKPiBnZW5lcmF0ZSBhIHJhbmRvbSBsb2NhbCBNQUMg
YWRkcmVzcy4iIFNvIHRoZXJlIGlzIG5vCj4gZGVmYXVsdCBNQUMgYWRkcmVzcyBpZiBWSVJUSU9f
TkVUX0ZfTUFDIG5vdCBzZXQuCj4KPiBUaGlzIGNvbW1pdHMgaW50cm9kdWNlcyBmdW5jdGlvbnMg
dmRwYV9kZXZfbmV0X210dV9jb25maWdfZmlsbCgpCj4gYW5kIHZkcGFfZGV2X25ldF9tYWNfY29u
ZmlnX2ZpbGwoKSB0byBmaWxsIE1UVSBhbmQgTUFDLgo+IEl0IGFsc28gZml4ZXMgdmRwYV9kZXZf
bmV0X21xX2NvbmZpZ19maWxsKCkgdG8gcmVwb3J0IGNvcnJlY3QKPiBNUSB3aGVuIF9GX01RIGlz
IG5vdCBwcmVzZW50Lgo+Cj4gVGhlc2UgZnVuY3Rpb25zIHNob3VsZCBjaGVjayBkZXZpY2VzIGZl
YXR1cmVzIHRoYW4gZHJpdmVyCj4gZmVhdHVyZXMsIGFuZCBzdHJ1Y3QgdmRwYV9kZXZpY2UgaXMg
bm90IG5lZWRlZCBhcyBhIHBhcmFtZXRlcgo+Cj4gVGhlIHRlc3QgJiB1c2Vyc3BhY2UgdG9vbCBv
dXRwdXQ6Cj4KPiBGZWF0dXJlIGJpdCBWSVJUSU9fTkVUX0ZfTVRVLCBWSVJUSU9fTkVUX0ZfUlNT
LCBWSVJUSU9fTkVUX0ZfTVEKPiBhbmQgVklSVElPX05FVF9GX01BQyBjYW4gYmUgbWFzayBvdXQg
YnkgaGFyZGNvZGUuCj4KPiBIb3dldmVyLCBpdCBpcyBjaGFsbGVuZ2luZyB0byAiZGlzYWJsZSIg
dGhlIHJlbGF0ZWQgZmllbGRzCj4gaW4gdGhlIEhXIGRldmljZSBjb25maWcgc3BhY2UsIHNvIGxl
dCdzIGp1c3QgYXNzdW1lIHRoZSB2YWx1ZXMKPiBhcmUgbWVhbmluZ2xlc3MgaWYgdGhlIGZlYXR1
cmUgYml0cyBhcmUgbm90IHNldC4KPgo+IEJlZm9yZSB0aGlzIGNoYW5nZSwgd2hlbiBmZWF0dXJl
IGJpdHMgZm9yIFJTUywgTVEsIE1UVSBhbmQgTUFDCj4gYXJlIG5vdCBzZXQsIGlwcm91dGUyIG91
dHB1dDoKPiAkdmRwYSB2ZHBhMDogbWFjIDAwOmU4OmNhOjExOmJlOjA1IGxpbmsgdXAgbGlua19h
bm5vdW5jZSBmYWxzZSBtdHUgMTUwMAo+ICAgIG5lZ290aWF0ZWRfZmVhdHVyZXMKPgo+IHdpdGhv
dXQgdGhpcyBjb21taXQsIGZ1bmN0aW9uIHZkcGFfZGV2X25ldF9jb25maWdfZmlsbCgpCj4gcmVh
ZHMgYWxsIGNvbmZpZyBzcGFjZSBmaWVsZHMgdW5jb25kaXRpb25hbGx5LCBzbyBsZXQncwo+IGFz
c3VtZSB0aGUgTUFDIGFuZCBNVFUgYXJlIG1lYW5pbmdsZXNzLCBhbmQgaXQgY2hlY2tzCj4gTVEg
d2l0aCBkcml2ZXJfZmVhdHVyZXMsIHNvIHdlIGRvbid0IHNlZSBtYXhfdnFfcGFpcnMuCj4KPiBB
ZnRlciBhcHBseWluZyB0aGlzIGNvbW1pdCwgd2hlbiBmZWF0dXJlIGJpdHMgZm9yCj4gTVEsIFJT
UywgTUFDIGFuZCBNVFUgYXJlIG5vdCBzZXQsaXByb3V0ZTIgb3V0cHV0Ogo+ICR2ZHBhIGRldiBj
b25maWcgc2hvdyB2ZHBhMAo+IHZkcGEwOiBsaW5rIHVwIGxpbmtfYW5ub3VuY2UgZmFsc2UgbWF4
X3ZxX3BhaXJzIDEgbXR1IDE1MDAKPiAgICBuZWdvdGlhdGVkX2ZlYXR1cmVzCj4KPiBBcyBleHBs
YWluZWQgYWJvdmU6Cj4gSGVyZSBpcyBubyBNQUMsIGJlY2F1c2UgVklSVElPX05FVF9GX01BQyBp
cyBub3Qgc2V0LAo+IGFuZCB0aGVyZSBpcyBubyBkZWZhdWx0IHZhbHVlIGZvciBNQUMuIEl0IHNo
b3dzCj4gbWF4X3ZxX3BhcmlzID0gMSBiZWNhdXNlIGV2ZW4gd2l0aG91dCBNUSBmZWF0dXJlLAo+
IGEgZnVuY3Rpb25hbCB2aXJ0aW8tbmV0IG11c3QgaGF2ZSBvbmUgcXVldWUgcGFpci4KPiBtdHUg
PSAxNTAwIGlzIHRoZSBkZWZhdWx0IHZhbHVlIGFzIGV0aGVybmV0Cj4gcmVxdWlyZWQuCj4KPiBU
aGlzIGNvbW1pdCBhbHNvIGFkZCBzdXBwbGVtZW50YXJ5IGNvbW1lbnRzIGZvcgo+IF9fdmlydGlv
MTZfdG9fY3B1KHRydWUsIHh4eCkgb3BlcmF0aW9ucyBpbgo+IHZkcGFfZGV2X25ldF9jb25maWdf
ZmlsbCgpIGFuZCB2ZHBhX2ZpbGxfc3RhdHNfcmVjKCkKPgo+IFNpZ25lZC1vZmYtYnk6IFpodSBM
aW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS92
ZHBhLmMgfCA2MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYS5jIGIvZHJpdmVycy92ZHBhL3ZkcGEuYwo+
IGluZGV4IGVmYjU1YTA2ZTk2MS4uYTc0NjYwYjk4OTc5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
dmRwYS92ZHBhLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYS5jCj4gQEAgLTgwMSwxOSArODAx
LDQ0IEBAIHN0YXRpYyBpbnQgdmRwYV9ubF9jbWRfZGV2X2dldF9kdW1waXQoc3RydWN0IHNrX2J1
ZmYgKm1zZywgc3RydWN0IG5ldGxpbmtfY2FsbGJhCj4gICAJcmV0dXJuIG1zZy0+bGVuOwo+ICAg
fQo+ICAgCj4gLXN0YXRpYyBpbnQgdmRwYV9kZXZfbmV0X21xX2NvbmZpZ19maWxsKHN0cnVjdCB2
ZHBhX2RldmljZSAqdmRldiwKPiAtCQkJCSAgICAgICBzdHJ1Y3Qgc2tfYnVmZiAqbXNnLCB1NjQg
ZmVhdHVyZXMsCj4gK3N0YXRpYyBpbnQgdmRwYV9kZXZfbmV0X21xX2NvbmZpZ19maWxsKHN0cnVj
dCBza19idWZmICptc2csIHU2NCBmZWF0dXJlcywKPiAgIAkJCQkgICAgICAgY29uc3Qgc3RydWN0
IHZpcnRpb19uZXRfY29uZmlnICpjb25maWcpCj4gICB7Cj4gICAJdTE2IHZhbF91MTY7Cj4gICAK
PiAtCWlmICgoZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19ORVRfRl9NUSkpID09IDApCj4gLQkJ
cmV0dXJuIDA7Cj4gKwlpZiAoKGZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fTkVUX0ZfTVEpKSA9
PSAwICYmCj4gKwkgICAgKGZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fTkVUX0ZfUlNTKSkgPT0g
MCkKPiArCQl2YWxfdTE2ID0gMTsKPiArCWVsc2UKPiArCQl2YWxfdTE2ID0gX192aXJ0aW8xNl90
b19jcHUodHJ1ZSwgY29uZmlnLT5tYXhfdmlydHF1ZXVlX3BhaXJzKTsKPiAgIAo+IC0JdmFsX3Ux
NiA9IGxlMTZfdG9fY3B1KGNvbmZpZy0+bWF4X3ZpcnRxdWV1ZV9wYWlycyk7Cj4gICAJcmV0dXJu
IG5sYV9wdXRfdTE2KG1zZywgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BWF9WUVAsIHZhbF91MTYp
Owo+ICAgfQo+ICAgCj4gK3N0YXRpYyBpbnQgdmRwYV9kZXZfbmV0X210dV9jb25maWdfZmlsbChz
dHJ1Y3Qgc2tfYnVmZiAqbXNnLCB1NjQgZmVhdHVyZXMsCj4gKwkJCQkJY29uc3Qgc3RydWN0IHZp
cnRpb19uZXRfY29uZmlnICpjb25maWcpCj4gK3sKPiArCXUxNiB2YWxfdTE2Owo+ICsKPiArCWlm
ICgoZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19ORVRfRl9NVFUpKSA9PSAwKQo+ICsJCXZhbF91
MTYgPSAxNTAwOwpBcyBzYWlkLCB0aGVyZSdzIG5vIHZpcnRpbyBzcGVjIGRlZmluZWQgdmFsdWUg
Zm9yIE1UVS4gUGxlYXNlIGxlYXZlIHRoaXMgCmZpZWxkIG91dCBpZiBmZWF0dXJlIFZJUlRJT19O
RVRfRl9NVFUgaXMgbm90IG5lZ290aWF0ZWQuCj4gKwllbHNlCj4gKwkJdmFsX3UxNiA9IF9fdmly
dGlvMTZfdG9fY3B1KHRydWUsIGNvbmZpZy0+bXR1KTsKPiArCj4gKwlyZXR1cm4gbmxhX3B1dF91
MTYobXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTVRVLCB2YWxfdTE2KTsKPiArfQo+ICsKPiAr
c3RhdGljIGludCB2ZHBhX2Rldl9uZXRfbWFjX2NvbmZpZ19maWxsKHN0cnVjdCBza19idWZmICpt
c2csIHU2NCBmZWF0dXJlcywKPiArCQkJCQljb25zdCBzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcg
KmNvbmZpZykKPiArewo+ICsJaWYgKChmZWF0dXJlcyAmIEJJVF9VTEwoVklSVElPX05FVF9GX01B
QykpID09IDApCj4gKwkJcmV0dXJuIDA7Cj4gKwllbHNlCj4gKwkJcmV0dXJuICBubGFfcHV0KG1z
ZywgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BQ0FERFIsCj4gKwkJCQlzaXplb2YoY29uZmlnLT5t
YWMpLCBjb25maWctPm1hYyk7Cj4gK30KPiArCj4gKwo+ICAgc3RhdGljIGludCB2ZHBhX2Rldl9u
ZXRfY29uZmlnX2ZpbGwoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAq
bXNnKQo+ICAgewo+ICAgCXN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyBjb25maWcgPSB7fTsKPiBA
QCAtODIyLDE4ICs4NDcsMTYgQEAgc3RhdGljIGludCB2ZHBhX2Rldl9uZXRfY29uZmlnX2ZpbGwo
c3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqbXMKPiAgIAo+ICAgCXZk
cGFfZ2V0X2NvbmZpZ191bmxvY2tlZCh2ZGV2LCAwLCAmY29uZmlnLCBzaXplb2YoY29uZmlnKSk7
Cj4gICAKPiAtCWlmIChubGFfcHV0KG1zZywgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BQ0FERFIs
IHNpemVvZihjb25maWcubWFjKSwKPiAtCQkgICAgY29uZmlnLm1hYykpCj4gLQkJcmV0dXJuIC1F
TVNHU0laRTsKPiArCS8qCj4gKwkgKiBBc3N1bWUgbGl0dGxlIGVuZGlhbiBmb3Igbm93LCB1c2Vy
c3BhY2UgY2FuIHR3ZWFrIHRoaXMgZm9yCj4gKwkgKiBsZWdhY3kgZ3Vlc3Qgc3VwcG9ydC4KWW91
IGNhbiBsZWF2ZSBpdCBhcyBhIFRPRE8gZm9yIGtlcm5lbCAodmRwYSBjb3JlIGxpbWl0YXRpb24p
LCBidXQgQUZBSUsgCnRoZXJlJ3Mgbm90aGluZyB1c2Vyc3BhY2UgbmVlZHMgdG8gZG8gdG8gaW5m
ZXIgdGhlIGVuZGlhbm5lc3MuIElNSE8gaXQncyAKdGhlIGtlcm5lbCdzIGpvYiB0byBwcm92aWRl
IGFuIGFic3RyYWN0aW9uIHJhdGhlciB0aGFuIHJlbHkgb24gdXNlcnNwYWNlIApndWVzc2luZyBp
dC4KCj4gKwkgKi8KPiArCXZhbF91MTYgPSBfX3ZpcnRpbzE2X3RvX2NwdSh0cnVlLCBjb25maWcu
c3RhdHVzKTsKPiAgIAo+ICAgCXZhbF91MTYgPSBfX3ZpcnRpbzE2X3RvX2NwdSh0cnVlLCBjb25m
aWcuc3RhdHVzKTsKPiAgIAlpZiAobmxhX3B1dF91MTYobXNnLCBWRFBBX0FUVFJfREVWX05FVF9T
VEFUVVMsIHZhbF91MTYpKQo+ICAgCQlyZXR1cm4gLUVNU0dTSVpFOwo+ICAgCj4gLQl2YWxfdTE2
ID0gX192aXJ0aW8xNl90b19jcHUodHJ1ZSwgY29uZmlnLm10dSk7Cj4gLQlpZiAobmxhX3B1dF91
MTYobXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTVRVLCB2YWxfdTE2KSkKPiAtCQlyZXR1cm4g
LUVNU0dTSVpFOwo+IC0KPiAgIAlmZWF0dXJlc19kcml2ZXIgPSB2ZGV2LT5jb25maWctPmdldF9k
cml2ZXJfZmVhdHVyZXModmRldik7Cj4gICAJaWYgKG5sYV9wdXRfdTY0XzY0Yml0KG1zZywgVkRQ
QV9BVFRSX0RFVl9ORUdPVElBVEVEX0ZFQVRVUkVTLCBmZWF0dXJlc19kcml2ZXIsCj4gICAJCQkg
ICAgICBWRFBBX0FUVFJfUEFEKSkKPiBAQCAtODQ2LDcgKzg2OSwxMyBAQCBzdGF0aWMgaW50IHZk
cGFfZGV2X25ldF9jb25maWdfZmlsbChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHN0cnVjdCBz
a19idWZmICptcwo+ICAgCQkJICAgICAgVkRQQV9BVFRSX1BBRCkpCj4gICAJCXJldHVybiAtRU1T
R1NJWkU7Cj4gICAKPiAtCXJldHVybiB2ZHBhX2Rldl9uZXRfbXFfY29uZmlnX2ZpbGwodmRldiwg
bXNnLCBmZWF0dXJlc19kcml2ZXIsICZjb25maWcpOwo+ICsJaWYgKHZkcGFfZGV2X25ldF9tYWNf
Y29uZmlnX2ZpbGwobXNnLCBmZWF0dXJlc19kZXZpY2UsICZjb25maWcpKQo+ICsJCXJldHVybiAt
RU1TR1NJWkU7Cj4gKwo+ICsJaWYgKHZkcGFfZGV2X25ldF9tdHVfY29uZmlnX2ZpbGwobXNnLCBm
ZWF0dXJlc19kZXZpY2UsICZjb25maWcpKQo+ICsJCXJldHVybiAtRU1TR1NJWkU7Cj4gKwo+ICsJ
cmV0dXJuIHZkcGFfZGV2X25ldF9tcV9jb25maWdfZmlsbChtc2csIGZlYXR1cmVzX2RldmljZSwg
JmNvbmZpZyk7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyBpbnQKPiBAQCAtOTE0LDYgKzk0MywxMSBA
QCBzdGF0aWMgaW50IHZkcGFfZmlsbF9zdGF0c19yZWMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2
LCBzdHJ1Y3Qgc2tfYnVmZiAqbXNnLAo+ICAgCX0KPiAgIAl2ZHBhX2dldF9jb25maWdfdW5sb2Nr
ZWQodmRldiwgMCwgJmNvbmZpZywgc2l6ZW9mKGNvbmZpZykpOwo+ICAgCj4gKwkvKgo+ICsJICog
QXNzdW1lIGxpdHRsZSBlbmRpYW4gZm9yIG5vdywgdXNlcnNwYWNlIGNhbiB0d2VhayB0aGlzIGZv
cgo+ICsJICogbGVnYWN5IGd1ZXN0IHN1cHBvcnQuCj4gKwkgKi8KPiArCkRpdHRvLgoKVGhhbmtz
LAotU2l3ZWkKPiAgIAltYXhfdnFwID0gX192aXJ0aW8xNl90b19jcHUodHJ1ZSwgY29uZmlnLm1h
eF92aXJ0cXVldWVfcGFpcnMpOwo+ICAgCWlmIChubGFfcHV0X3UxNihtc2csIFZEUEFfQVRUUl9E
RVZfTkVUX0NGR19NQVhfVlFQLCBtYXhfdnFwKSkKPiAgIAkJcmV0dXJuIC1FTVNHU0laRTsKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
