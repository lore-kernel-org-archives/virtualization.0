Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E1EC433FE
	for <virtualization@archiver.kernel.org>; Thu, 16 Dec 2021 02:02:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 41F0240A96;
	Thu, 16 Dec 2021 02:02:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RbZZihIsaJoB; Thu, 16 Dec 2021 02:02:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CCCC840587;
	Thu, 16 Dec 2021 02:02:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73EC5C001E;
	Thu, 16 Dec 2021 02:02:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05D57C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 02:02:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D38A260F55
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 02:02:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="x2GL8D7u";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="iAGaJ/48"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yIdo1INFZQoY
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 02:02:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8C47260F45
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 02:02:08 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFMEBOs002578; 
 Thu, 16 Dec 2021 02:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qwvzKCyu/WkCDgCkrl+wG9kWa5Fsd7peYWaBmQ4ywLU=;
 b=x2GL8D7uXhSBUHuimuVS6LH6sg77j2jgzUapPa/8jUjLXfwtmOCx7R/zTJ3ySFG/URIt
 u5j7KzX1srC8Q7avNgPE4kNxDYK0sv8zVPcS9qDXRH35IXxGr5wt/s6L0dW7Z6rkn0Cf
 3dWCKSGeJ4Fa9Ts7vTyOTPG4OZkMdEX/xWhEzb9h35gqxTU4LRccHhFiEmtN0nqtCG0K
 FcljfFEGMIVexLRXCYZ4OMDls0TCDnsDPMslJ672AEP/g1antbxbAkpiKDo/9bmXLB5/
 cN0R/RTJ+0Lfcto2dQ+mP6m79ZVJzaDBuRL61OuLrugeM5z6W5I9EGmuaXQVVgMpzexF ZQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cykmbhbac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Dec 2021 02:02:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BG20YTk146063;
 Thu, 16 Dec 2021 02:02:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
 by aserp3020.oracle.com with ESMTP id 3cxmrcqna2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Dec 2021 02:02:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oetzqDuv+rYUCtwCbFzuFXgJ9as+4oYKR/o3cmiNKzWO9aPOg9g/Efjo72jCk3Ub72jAtggoSc/1g562Q+TZFOjgM3dk7I+9c1qrCcH7NAtH7a4gCKqhNQxaD4xB75s2tJtD49/OIw6ybjKd+k7iJEbdBuwtyWS/dzvEM6aGZVILk7gZEevVOARw4TNWd7xPLSFERLxVKhZa7Rh/Fvpcdzf7tFnUzQKL3cyrdNpJJ80Mur9p2pNo3PCRwILf+qqpx2jEq2C/J65WXMTCh999CPaQyuoIgRo460uTWMhfZr4JMqQZoZuvzTokgyIy6CieEpnmnOkV9kxrFrchTneqYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwvzKCyu/WkCDgCkrl+wG9kWa5Fsd7peYWaBmQ4ywLU=;
 b=kma18XC+bQFiwkcymUVmODEPpEm75VeBYdIGFKuFjxks1ro9vM0Euo9Kz4671kxMKc3C56REq5p4bbuHWp5mWeKVPDGmM2F0pXEAz1Rz/XpJX4auB7KSrXrfWO6MDrMPf6NqxTttpizU6wO0hvDFiQTDcY4K4ufELYmljJj5/HRoqBDTeCW4AkdOvvq4iH9CAI9g8Auo+ZznZ3wHuUNVS1dPWJvvFqIt5PxcO3Yx1kZf4392UYgwRlhDCyShY4dv7qjbr3wI05KVBZKNCj+hiynFRfbg7LQ6vYR2RTvU7hpBl9mmfdypIN4d6VTJ5jcG+fb3n7sJJntr5tKwWQD3FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwvzKCyu/WkCDgCkrl+wG9kWa5Fsd7peYWaBmQ4ywLU=;
 b=iAGaJ/48kRYpEqZtewh4gyxEB+ThdVY9mpCsQR3rn0U5TDKlHvGR4C1A8FUw1C7MjqTM+9FiRPYoekvRpWA/zshLWVq4UTdVOfOeOpg8DJKN7KMOOCHq34Pm7z/25Ar1f2E0GJ+DZ6m+GCN0/Ol5+0nVn8dg/Ee4dLu8Xwp6YCE=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (20.179.158.139) by
 BYAPR10MB3319.namprd10.prod.outlook.com (20.179.155.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.16; Thu, 16 Dec 2021 02:02:03 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 02:02:02 +0000
Message-ID: <71d2a69c-94a7-76b5-2971-570026760bf0@oracle.com>
Date: Wed, 15 Dec 2021 18:01:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: vdpa legacy guest support (was Re: [PATCH] vdpa/mlx5:
 set_features should allow reset to zero)
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <2cb51a6d-afa0-7cd1-d6f2-6b153186eaca@redhat.com>
 <20210302043419-mutt-send-email-mst@kernel.org>
 <178f8ea7-cebd-0e81-3dc7-10a058d22c07@redhat.com>
 <c9a0932f-a6d7-a9df-38ba-97e50f70c2b2@oracle.com>
 <20211212042311-mutt-send-email-mst@kernel.org>
 <ba9df703-29af-98a9-c554-f303ff045398@oracle.com>
 <20211214000245-mutt-send-email-mst@kernel.org>
 <4fc43d0f-da9e-ce16-1f26-9f0225239b75@oracle.com>
 <CACGkMEsttnFEKGK-aKdCZeXkUnZJg1uaqYzFqpv-g5TobHGSzQ@mail.gmail.com>
 <6eaf672c-cc86-b5bf-5b74-c837affeb6e1@oracle.com>
 <20211215162917-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211215162917-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SN4PR0501CA0125.namprd05.prod.outlook.com
 (2603:10b6:803:42::42) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50bc5913-15d5-411f-466d-08d9c0380d75
X-MS-TrafficTypeDiagnostic: BYAPR10MB3319:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB33191295D62A332F5247BAC9B1779@BYAPR10MB3319.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89hp+IpHHRX2h9Dy+W87Xu3E3GhLgX9owTSKXhwWjMDUAJVbLpxTbbV9ZZN5KP3w5MUobgPgZh4xYfwjkAWOII2uLndaAQjTRvQWQUf24mZARyJRBJeBJbk8ISDHeLbHKxzfXABRQRJ0EY+8m93OfOz3UKrIaOIRghDOUbeHpa2RxrLTipy294EdwhnzxRKSaGi9ixGzrqRQLBgyfCX9AOvGYF/qdtfe3PsHsDQ2KWNklcy1RFBlQ+BMhhteMuk/FlI9+9WDMCxocDc+FSfT1L7VckV2KHXmnppkJeI3wp5GbUAJIihzCULtZGiiFG9trCqGrqACEdCj44r7QLuoQ2Uka4e6enYAMEo9+KHaKPVkJrGnwas/y+88B4h3cvj+pvpYpkEma1LrpaKUZ8YTrwcDQvgJGWMpxI2NZk5W6x0l85E03auSpccTV12jUQt4iz7DlVktGNMnrhRbXeNo0+dqBkSncQWzDdvJ+IEPG3bnHsSfJUHqQYbNl4p2bYzJmFooDZYfFWNsa250GtOLj99e/MtExFgGnW5BviWUXyOHfTXdliW88ZLhcMev+//I85VGeRPOyQS+JfFCKeV/94tyWRHB9fyGw6qL7xBgPGXmB0u3HtsoMBzKWK6F7vAoG9i6ETlcY4XwfOIL/4hSNLeuSCcPXuFmPelMKABU31D2j1HTus9bFyfbu5YlxDmzKv6D2v75RjBGUvedZ2lDDvKedk2manTPPN+xXjY+yu92iSaUje762WlWxCcVKY4FLfArR0ijUMsGb/M/79XyA8LF9ryGYeKKwSbxU9g96uly+UqnltPBhjVzlbnGYv2x
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(53546011)(8676002)(6506007)(6512007)(4326008)(66556008)(2616005)(26005)(66476007)(2906002)(6916009)(66946007)(186003)(83380400001)(6486002)(6666004)(54906003)(38100700002)(36916002)(316002)(36756003)(30864003)(966005)(31686004)(31696002)(8936002)(508600001)(5660300002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW9lYlczWWdQR1Z1SHB0RzN1cE4vVWo3OHhEdFlNWkhXbU1NOFdMS0E4OVEy?=
 =?utf-8?B?cU53VTdmSm5QN3NwVkp0YnVXZCtKc1pXOVgrRFpTSVdadW91UUVzeDJ2TUVE?=
 =?utf-8?B?MW5CMjhJcVJhRm1ndnQxOGFRaWR2Q01OQmoxQkRML1hoRlZUZlNtK01zWWNT?=
 =?utf-8?B?VmN6RXlPS1JhcXR3RXRDV2srMEpTWWNoWlZQbDZzZG9mRWYzeXE4eDBlQ0Rm?=
 =?utf-8?B?VmZSc0swUmpubDcwc1FkYmJzN2RXdjdiTnl3OU05STdWdTBodTQ0d2pZY2E2?=
 =?utf-8?B?bFpkaXU2OGY1ZFMzS2VxZDdaZG9ZTVVJMGc4b0RVaTk1dXBGbFU4eUpJcER3?=
 =?utf-8?B?dENCc1FxRy8yTTFSQ1FTcUJrNURwWkwxS0EvOHRoYWg5UUR5bmFuUUVnck9W?=
 =?utf-8?B?OTBMWjZ3NDFsMThkUVptWC9wN3RreVhhNFluWWxhWUVxQjlJZm9hWlI2NTdv?=
 =?utf-8?B?T2l6OUw5WXlhU1NGR2w4MGxhZ3lnN2M0WDlHSE1laXVrRFRhdnFmY2FaN2ha?=
 =?utf-8?B?YU9SVWFFU0RQOXRwKytuaC9MTjF0ZHNxeXRYV3hsZ2I4VUllS3NxSTJBWEF2?=
 =?utf-8?B?UGxvcDl1ckFaOVBnMTg2MU1CdnBKc0lvSUxZZUVpcHNIbVBIZnlXNzQ2Zjd3?=
 =?utf-8?B?M2dVUllKTnFnQnRuNm0zZkw1QVV5K0tDWTJsakNoZEQ0MTQwQ0RPV2dYWmJQ?=
 =?utf-8?B?RitLSzVUdm5SczFrU0t1cU1mVWFFRzdMM1QwNFRENjdLbkVPQXBxYk9xY3hE?=
 =?utf-8?B?eHRzYUZLUlE2b0V3emlCRWdyTDdQMGlsSXV4aEpaL3hGUXlYOHR6VGxUREZL?=
 =?utf-8?B?Zkk3STI4ZCttTmdoT0RqWGNMOVMxa3lvQ0krYkhUbG5NdE10K0w3R0t2MCs5?=
 =?utf-8?B?b1RTa2YvS1pkNDMwQldXRERXVE5PdFdNVTJuVHhheHlFWTFrd2o5THJaY2g2?=
 =?utf-8?B?OUFyTVdJaUwwWnJSN2tRNkxpVFZjV2hRc0wrMEdpVkVpQ2FDRHhhRU9qMmpa?=
 =?utf-8?B?Y3hQWVBJb1kxTmUwNHBPOXJqWXJuVmxRNndoTjJWOEF1dTd0cS9JQlJ0NXY2?=
 =?utf-8?B?U2lWOUF4VDcxTUlXdjd1QytYcS9RSGh1eTBFVXRQcjVabGZ4QzVDeENaY2RO?=
 =?utf-8?B?cWtlZW9lNTl5Y0ZTeGIrRXYveWI2Qm0zeGRDS29QdkpDQWdVU3BDeXlicmsv?=
 =?utf-8?B?MTNkMmdYRDQ2Y2I1RDNpcldiekk3YXp2ajNWbGpKS2pUR25RY3pLLzF3RzNy?=
 =?utf-8?B?MUovRXpIdEdRaW8vN21HVWV6cTRPcWdIS1U4SE5jcytUNUIvaHlJWHI5RWJ0?=
 =?utf-8?B?cWkwTldabnRuVkdySXZYSmZQd1lCSCtZT1NMRk5GdWkydXdVdVJnYTAzWnpT?=
 =?utf-8?B?OUc1dDI3cHhFb2pNOElnTHJaVExhNXBQWG9xZjdCVFM5Q2hTbWlMWkdGMVc2?=
 =?utf-8?B?ZGsrQldVRE9lOTdxdkdBTTZJL2xLK2tSY2NkTUxrTGRuNTFnNWhEUHZkSnpS?=
 =?utf-8?B?SkZ4eEdyd09WSWZTRnhJbVAzZW9LMEFTdmVnRGxtTVl3NmY3MXdLL1NETHhk?=
 =?utf-8?B?NzkxODEvZEE1eHBZZXBsSVVIcFh2RXN5OTcwSU5sWlI1R2ZCRHBnd2xuZ0R6?=
 =?utf-8?B?cWVMdUZGTDFMNlJuZkUwaHhXYXV4YjY2bUtzcmNXdWV1ZFJTdDAzdWJMWW1F?=
 =?utf-8?B?SnpjSmNwMzRQdlRJVk1nYlRXVjFsbkdFRko5aE1BOG54b2YvQUNVdFM3dE9o?=
 =?utf-8?B?STE3UFhaZmtwOHZ4S1lPOEJPeUxpN0RDNVhmZkR4ZXNYQmNCeUo3eXdMVXJ0?=
 =?utf-8?B?NFBXdmZ3a05UUFE2ZXI5L1pnZFVYS1JjTmxCbHd1MEZSNitYNmtidVR5dlF3?=
 =?utf-8?B?VlVOMkwxOC9CeWhnQ3pQNGhaZXdNTU9UYml3RVRWU2NrUDlPcTQ5SUF0eFZZ?=
 =?utf-8?B?d0hUektEd3YvNXF4UVJMRzcrMTROenFtVFhaQ0xNdXBrNUwxNEdTQ2RHOEc3?=
 =?utf-8?B?b1UvV2h2VmNFWHVpWXpYRTZaVUtydkpydWl1dkVEYmJsNjh3QTU1YXQ4MGFU?=
 =?utf-8?B?QUc2YzJzZldBdS9xeUdGaEVURklFREI4c3ppbGcrM0VWVG5oTElWMHlKeVN6?=
 =?utf-8?B?RCtRYndFQmVUNTgxbmQ1ZUJTK29wL0FsTnFhRkJ6QUtGTy94SENkZXk5NlFs?=
 =?utf-8?Q?UjvFkaoZBTaVf3ZQ8Gkv+tI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bc5913-15d5-411f-466d-08d9c0380d75
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 02:02:02.8626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8yfR47lQwpc0027bkwACPyEtld3nb6AzgZXOfFGXyWvrrQHSrMB3M54Z7TxmgtrdPZEdEVsAeT5w/FGPX+PgQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3319
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10199
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112160010
X-Proofpoint-ORIG-GUID: xv3ymOm2qe7AP3siLTdMVruPFE_ryV8l
X-Proofpoint-GUID: xv3ymOm2qe7AP3siLTdMVruPFE_ryV8l
Cc: netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eli Cohen <elic@nvidia.com>, linux-kernel <linux-kernel@vger.kernel.org>
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

CgpPbiAxMi8xNS8yMDIxIDE6MzMgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBX
ZWQsIERlYyAxNSwgMjAyMSBhdCAxMjo1MjoyMFBNIC0wODAwLCBTaS1XZWkgTGl1IHdyb3RlOgo+
Pgo+PiBPbiAxMi8xNC8yMDIxIDY6MDYgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+PiBPbiBXZWQs
IERlYyAxNSwgMjAyMSBhdCA5OjA1IEFNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNv
bT4gd3JvdGU6Cj4+Pj4KPj4+PiBPbiAxMi8xMy8yMDIxIDk6MDYgUE0sIE1pY2hhZWwgUy4gVHNp
cmtpbiB3cm90ZToKPj4+Pj4gT24gTW9uLCBEZWMgMTMsIDIwMjEgYXQgMDU6NTk6NDVQTSAtMDgw
MCwgU2ktV2VpIExpdSB3cm90ZToKPj4+Pj4+IE9uIDEyLzEyLzIwMjEgMToyNiBBTSwgTWljaGFl
bCBTLiBUc2lya2luIHdyb3RlOgo+Pj4+Pj4+IE9uIEZyaSwgRGVjIDEwLCAyMDIxIGF0IDA1OjQ0
OjE1UE0gLTA4MDAsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pj4+Pj4+IFNvcnJ5IGZvciByZXZpdmlu
ZyB0aGlzIGFuY2llbnQgdGhyZWFkLiBJIHdhcyBraW5kYSBsb3N0IGZvciB0aGUgY29uY2x1c2lv
bgo+Pj4+Pj4+PiBpdCBlbmRlZCB1cCB3aXRoLiBJIGhhdmUgdGhlIGZvbGxvd2luZyBxdWVzdGlv
bnMsCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IDEuIGxlZ2FjeSBndWVzdCBzdXBwb3J0OiBmcm9tIHRoZSBw
YXN0IGNvbnZlcnNhdGlvbnMgaXQgZG9lc24ndCBzZWVtIHRoZQo+Pj4+Pj4+PiBzdXBwb3J0IHdp
bGwgYmUgY29tcGxldGVseSBkcm9wcGVkIGZyb20gdGhlIHRhYmxlLCBpcyBteSB1bmRlcnN0YW5k
aW5nCj4+Pj4+Pj4+IGNvcnJlY3Q/IEFjdHVhbGx5IHdlJ3JlIGludGVyZXN0ZWQgaW4gc3VwcG9y
dGluZyB2aXJ0aW8gdjAuOTUgZ3Vlc3QgZm9yIHg4NiwKPj4+Pj4+Pj4gd2hpY2ggaXMgYmFja2Vk
IGJ5IHRoZSBzcGVjIGF0Cj4+Pj4+Pj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRw
czovL296bGFicy5vcmcvKnJ1c3R5L3ZpcnRpby1zcGVjL3ZpcnRpby0wLjkuNS5wZGZfXztmZyEh
QUNXVjVOOU0yUlY5OWhRIWRUS216Snd3UnNGTTdCdFN1VER1MWNObHk1bjRYQ290SDBXWW1pZHpH
cUhTWHQ0MGk3WlU0M1VjTmc3R1l4WmckIC4gVGhvdWdoIEknbSBub3Qgc3VyZQo+Pj4+Pj4+PiBp
ZiB0aGVyZSdzIHJlcXVlc3QvbmVlZCB0byBzdXBwb3J0IHdpbGRlciBsZWdhY3kgdmlydGlvIHZl
cnNpb25zIGVhcmxpZXIKPj4+Pj4+Pj4gYmV5b25kLgo+Pj4+Pj4+IEkgcGVyc29uYWxseSBmZWVs
IGl0J3MgbGVzcyB3b3JrIHRvIGFkZCBpbiBrZXJuZWwgdGhhbiB0cnkgdG8KPj4+Pj4+PiB3b3Jr
IGFyb3VuZCBpdCBpbiB1c2Vyc3BhY2UuIEphc29uIGZlZWxzIGRpZmZlcmVudGx5Lgo+Pj4+Pj4+
IE1heWJlIHBvc3QgdGhlIHBhdGNoZXMgYW5kIHRoaXMgd2lsbCBwcm92ZSB0byBKYXNvbiBpdCdz
IG5vdAo+Pj4+Pj4+IHRvbyB0ZXJyaWJsZT8KPj4+Pj4+IEkgc3VwcG9zZSBpZiB0aGUgdmRwYSB2
ZW5kb3IgZG9lcyBzdXBwb3J0IDAuOTUgaW4gdGhlIGRhdGFwYXRoIGFuZCByaW5nCj4+Pj4+PiBs
YXlvdXQgbGV2ZWwgYW5kIGlzIGxpbWl0ZWQgdG8geDg2IG9ubHksIHRoZXJlIHNob3VsZCBiZSBl
YXN5IHdheSBvdXQuCj4+Pj4+IE5vdGUgYSBzdWJ0bGUgZGlmZmVyZW5jZTogd2hhdCBtYXR0ZXJz
IGlzIHRoYXQgZ3Vlc3QsIG5vdCBob3N0IGlzIHg4Ni4KPj4+Pj4gTWF0dGVycyBmb3IgZW11bGF0
b3JzIHdoaWNoIG1pZ2h0IHJlb3JkZXIgbWVtb3J5IGFjY2Vzc2VzLgo+Pj4+PiBJIGd1ZXNzIHRo
aXMgZW5mb3JjZW1lbnQgYmVsb25ncyBpbiBRRU1VIHRoZW4/Cj4+Pj4gUmlnaHQsIEkgbWVhbiB0
byBnZXQgc3RhcnRlZCwgdGhlIGluaXRpYWwgZ3Vlc3QgZHJpdmVyIHN1cHBvcnQgYW5kIHRoZQo+
Pj4+IGNvcnJlc3BvbmRpbmcgUUVNVSBzdXBwb3J0IGZvciB0cmFuc2l0aW9uYWwgdmRwYSBiYWNr
ZW5kIGNhbiBiZSBsaW1pdGVkCj4+Pj4gdG8geDg2IGd1ZXN0L2hvc3Qgb25seS4gU2luY2UgdGhl
IGNvbmZpZyBzcGFjZSBpcyBlbXVsYXRlZCBpbiBRRU1VLCBJCj4+Pj4gc3VwcG9zZSBpdCdzIG5v
dCBoYXJkIHRvIGVuZm9yY2UgaW4gUUVNVS4KPj4+IEl0J3MgbW9yZSB0aGFuIGp1c3QgY29uZmln
IHNwYWNlLCBtb3N0IGRldmljZXMgaGF2ZSBoZWFkZXJzIGJlZm9yZSB0aGUgYnVmZmVyLgo+PiBU
aGUgb3JkZXJpbmcgaW4gZGF0YXBhdGggKGRhdGEgVlFzKSB3b3VsZCBoYXZlIHRvIHJlbHkgb24g
dmVuZG9yJ3Mgc3VwcG9ydC4KPj4gU2luY2UgT1JERVJfUExBVEZPUk0gaXMgcHJldHR5IG5ldyAo
djEuMSksIEkgZ3Vlc3MgdmRwYSBoL3cgdmVuZG9yIG5vd2FkYXlzCj4+IGNhbi9zaG91bGQgd2Vs
bCBzdXBwb3J0IHRoZSBjYXNlIHdoZW4gT1JERVJfUExBVEZPUk0gaXMgbm90IGFja2VkIGJ5IHRo
ZQo+PiBkcml2ZXIgKGFjdHVhbGx5IHRoaXMgZmVhdHVyZSBpcyBmaWx0ZXJlZCBvdXQgYnkgdGhl
IFFFTVUgdmhvc3QtdmRwYSBkcml2ZXIKPj4gdG9kYXkpLCBldmVuIHdpdGggdjEuMCBzcGVjIGNv
bmZvcm1pbmcgYW5kIG1vZGVybiBvbmx5IHZEUEEgZGV2aWNlLiBUaGUKPj4gY29udHJvbCBWUSBp
cyBpbXBsZW1lbnRlZCBpbiBzb2Z0d2FyZSBpbiB0aGUga2VybmVsLCB3aGljaCBjYW4gYmUgZWFz
aWx5Cj4+IGFjY29tbW9kYXRlZC9maXhlZCB3aGVuIG5lZWRlZC4KPj4KPj4+PiBRRU1VIGNhbiBk
cml2ZSBHRVRfTEVHQUNZLAo+Pj4+IEdFVF9FTkRJQU4gZXQgYWwgaW9jdGxzIGluIGFkdmFuY2Ug
dG8gZ2V0IHRoZSBjYXBhYmlsaXR5IGZyb20gdGhlCj4+Pj4gaW5kaXZpZHVhbCB2ZW5kb3IgZHJp
dmVyLiBGb3IgdGhhdCwgd2UgbmVlZCBhbm90aGVyIG5lZ290aWF0aW9uIHByb3RvY29sCj4+Pj4g
c2ltaWxhciB0byB2aG9zdF91c2VyJ3MgcHJvdG9jb2xfZmVhdHVyZXMgYmV0d2VlbiB0aGUgdmRw
YSBrZXJuZWwgYW5kCj4+Pj4gUUVNVSwgd2F5IGJlZm9yZSB0aGUgZ3Vlc3QgZHJpdmVyIGlzIGV2
ZXIgcHJvYmVkIGFuZCBpdHMgZmVhdHVyZQo+Pj4+IG5lZ290aWF0aW9uIGtpY2tzIGluLiBOb3Qg
c3VyZSB3ZSBuZWVkIGEgR0VUX01FTU9SWV9PUkRFUiBpb2N0bCBjYWxsCj4+Pj4gZnJvbSB0aGUg
ZGV2aWNlLCBidXQgd2UgY2FuIGFzc3VtZSB3ZWFrIG9yZGVyaW5nIGZvciBsZWdhY3kgYXQgdGhp
cwo+Pj4+IHBvaW50ICh4ODYgb25seSk/Cj4+PiBJJ20gbG9zdCBoZXJlLCB3ZSBoYXZlIGdldF9m
ZWF0dXJlcygpIHNvOgo+PiBJIGFzc3VtZSBoZXJlIHlvdSByZWZlciB0byBnZXRfZGV2aWNlX2Zl
YXR1cmVzKCkgdGhhdCBFbGkganVzdCBjaGFuZ2VkIHRoZQo+PiBuYW1lLgo+Pj4gMSkgVkVSU0lP
Tl8xIG1lYW5zIHRoZSBkZXZpY2UgdXNlcyBMRSBpZiBwcm92aWRlZCwgb3RoZXJ3aXNlIG5hdHZp
ZQo+Pj4gMikgT1JERVJfUExBVEZPUk0gbWVhbnMgZGV2aWNlIHJlcXVpcmVzIHBsYXRmb3JtIG9y
ZGVyaW5nCj4+Pgo+Pj4gQW55IHJlYXNvbiBmb3IgaGF2aW5nIGEgbmV3IEFQSSBmb3IgdGhpcz8K
Pj4gQXJlIHlvdSBnb2luZyB0byBlbmZvcmNlIGFsbCB2RFBBIGhhcmR3YXJlIHZlbmRvcnMgdG8g
c3VwcG9ydCB0aGUKPj4gdHJhbnNpdGlvbmFsIG1vZGVsIGZvciBsZWdhY3kgZ3Vlc3Q/IG1lYW5p
bmcgZ3Vlc3Qgbm90IGFja25vd2xlZGdpbmcKPj4gVkVSU0lPTl8xIHdvdWxkIHVzZSB0aGUgbGVn
YWN5IGludGVyZmFjZXMgY2FwdHVyZWQgaW4gdGhlIHNwZWMgc2VjdGlvbiA3LjQKPj4gKHJlZ2Fy
ZGluZyByaW5nIGxheW91dCwgbmF0aXZlIGVuZGlhbm5lc3MsIG1lc3NhZ2UgZnJhbWluZywgdnEg
YWxpZ25tZW50IG9mCj4+IDQwOTYsIDMyYml0IGZlYXR1cmUsIG5vIGZlYXR1cmVzX29rIGJpdCBp
biBzdGF0dXMsIElPIHBvcnQgaW50ZXJmYWNlIGkuZS4KPj4gYWxsIHRoZSB0aGluZ3MpIGluc3Rl
YWQ/IE5vdGVkIHdlIGRvbid0IHlldCBoYXZlIGEgc2V0X2RldmljZV9mZWF0dXJlcygpCj4+IHRo
YXQgYWxsb3dzIHRoZSB2ZHBhIGRldmljZSB0byB0ZWxsIHdoZXRoZXIgaXQgaXMgb3BlcmF0aW5n
IGluIHRyYW5zaXRpb25hbAo+PiBvciBtb2Rlcm4tb25seSBtb2RlLiBGb3Igc29mdHdhcmUgdmly
dGlvLCBhbGwgc3VwcG9ydCBmb3IgdGhlIGxlZ2FjeSBwYXJ0IGluCj4+IGEgdHJhbnNpdGlvbmFs
IG1vZGVsIGhhcyBiZWVuIGJ1aWx0IHVwIHRoZXJlIGFscmVhZHksIGhvd2V2ZXIsIGl0J3Mgbm90
IGVhc3kKPj4gZm9yIHZEUEEgdmVuZG9ycyB0byBpbXBsZW1lbnQgYWxsIHRoZSByZXF1aXJlbWVu
dHMgZm9yIGFuIGFsbC1vci1ub3RoaW5nCj4+IGxlZ2FjeSBndWVzdCBzdXBwb3J0IChiaWcgZW5k
aWFuIGd1ZXN0IGZvciBleGFtcGxlKS4gVG8gdGhlc2UgdmVuZG9ycywgdGhlCj4+IGxlZ2FjeSBz
dXBwb3J0IHdpdGhpbiBhIHRyYW5zaXRpb25hbCBtb2RlbCBpcyBtb3JlIG9mIGZlYXR1cmUgdG8g
dGhlbSBhbmQKPj4gaXQncyBiZXN0IHRvIGxlYXZlIHNvbWUgZmxleGliaWxpdHkgZm9yIHRoZW0g
dG8gaW1wbGVtZW50IHBhcnRpYWwgc3VwcG9ydAo+PiBmb3IgbGVnYWN5LiBUaGF0IGluIHR1cm4g
Y2FsbHMgb3V0IHRoZSBuZWVkIGZvciBhIHZob3N0LXVzZXIgcHJvdG9jb2wKPj4gZmVhdHVyZSBs
aWtlIG5lZ290aWF0aW9uIEFQSSB0aGF0IGNhbiBwcm9oaWJpdCB0aG9zZSB1bnN1cHBvcnRlZCBn
dWVzdAo+PiBzZXR1cHMgdG8gYXMgZWFybHkgYXMgYmFja2VuZF9pbml0IGJlZm9yZSBsYXVuY2hp
bmcgdGhlIFZNLgo+IFJpZ2h0LiBPZiBub3RlIGlzIHRoZSBmYWN0IHRoYXQgaXQncyBhIHNwZWMg
YnVnIHdoaWNoIEkKPiBob3BlIHlldCB0byBmaXgsIHRob3VnaCBkdWUgdG8gZXhpc3RpbmcgZ3Vl
c3QgY29kZSB0aGUKPiBmaXggd29uJ3QgYmUgY29tcGxldGUuCkkgdGhvdWdodCBhdCBvbmUgcG9p
bnQgeW91IHBvaW50ZWQgb3V0IHRvIG1lIHRoYXQgdGhlIHNwZWMgZG9lcyBhbGxvdyAKY29uZmln
IHNwYWNlIHJlYWQgYmVmb3JlIGNsYWltaW5nIGZlYXR1cmVzX29rLCBhbmQgb25seSBjb25maWcg
d3JpdGUgCmJlZm9yZSBmZWF0dXJlc19vayBpcyBwcm9oaWJpdGVkLiBJIGhhdmVuJ3QgcmVhZCB1
cCB0aGUgZnVsbCB0aHJlYWQgb2YgCkhhbGlsJ3MgVkVSU0lPTl8xIGZvciB0cmFuc2l0aW9uYWwg
YmlnIGVuZGlhbiBkZXZpY2UgeWV0LCBidXQgd2hhdCBpcyAKdGhlIHNwZWMgYnVnIHlvdSBob3Bl
IHRvIGZpeD8KCj4KPiBXUlQgaW9jdGxzLCBPbmUgdGhpbmcgd2UgY2FuIGRvIHRob3VnaCBpcyBh
YnVzZSBzZXRfZmVhdHVyZXMKPiB3aGVyZSBpdCdzIGNhbGxlZCBieSBRRU1VIGVhcmx5IG9uIHdp
dGgganVzdCB0aGUgVkVSU0lPTl8xCj4gYml0IHNldCwgdG8gZGlzdGluZ3Vpc2ggYmV0d2VlbiBs
ZWdhY3kgYW5kIG1vZGVybgo+IGludGVyZmFjZS4gVGhpcyBiZWZvcmUgY29uZmlnIHNwYWNlIGFj
Y2Vzc2VzIGFuZCBGRUFUVVJFU19PSy4KPgo+IEhhbGlsIGhhcyBiZWVuIHdvcmtpbmcgb24gdGhp
cywgcGxzIHRha2UgYSBsb29rIGFuZCBtYXliZSBoZWxwIGhpbSBvdXQuCkludGVyZXN0aW5nIHRo
cmVhZCwgYW0gcmVhZGluZyBub3cgYW5kIHNlZSBob3cgSSBtYXkgbGV2ZXJhZ2Ugb3IgaGVscCB0
aGVyZS4KCj4+Pj4+PiBJCj4+Pj4+PiBjaGVja2VkIHdpdGggRWxpIGFuZCBvdGhlciBNZWxsYW5v
eC9OVkRJQSBmb2xrcyBmb3IgaGFyZHdhcmUvZmlybXdhcmUgbGV2ZWwKPj4+Pj4+IDAuOTUgc3Vw
cG9ydCwgaXQgc2VlbXMgYWxsIHRoZSBpbmdyZWRpZW50IGhhZCBiZWVuIHRoZXJlIGFscmVhZHkg
ZGF0ZWQgYmFjawo+Pj4+Pj4gdG8gdGhlIERQREsgZGF5cy4gVGhlIG9ubHkgbWFqb3IgdGhpbmcg
bGltaXRpbmcgaXMgaW4gdGhlIHZEUEEgc29mdHdhcmUgdGhhdAo+Pj4+Pj4gdGhlIGN1cnJlbnQg
dmRwYSBjb3JlIGhhcyB0aGUgYXNzdW1wdGlvbiBhcm91bmQgVklSVElPX0ZfQUNDRVNTX1BMQVRG
T1JNIGZvcgo+Pj4+Pj4gYSBmZXcgRE1BIHNldHVwIG9wcywgd2hpY2ggaXMgdmlydGlvIDEuMCBv
bmx5Lgo+Pj4+Pj4KPj4+Pj4+Pj4gMi4gc3VwcG9zZSBzb21lIGZvcm0gb2YgbGVnYWN5IGd1ZXN0
IHN1cHBvcnQgbmVlZHMgdG8gYmUgdGhlcmUsIGhvdyBkbyB3ZQo+Pj4+Pj4+PiBkZWFsIHdpdGgg
dGhlIGJvZ3VzIGFzc3VtcHRpb24gYmVsb3cgaW4gdmRwYV9nZXRfY29uZmlnKCkgaW4gdGhlIHNo
b3J0IHRlcm0/Cj4+Pj4+Pj4+IEl0IGxvb2tzIG9uZSBvZiB0aGUgaW50dWl0aXZlIGZpeCBpcyB0
byBtb3ZlIHRoZSB2ZHBhX3NldF9mZWF0dXJlcyBjYWxsIG91dAo+Pj4+Pj4+PiBvZiB2ZHBhX2dl
dF9jb25maWcoKSB0byB2ZHBhX3NldF9jb25maWcoKS4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gICAgICAg
ICAgICAgLyoKPj4+Pj4+Pj4gICAgICAgICAgICAgICogQ29uZmlnIGFjY2Vzc2VzIGFyZW4ndCBz
dXBwb3NlZCB0byB0cmlnZ2VyIGJlZm9yZSBmZWF0dXJlcyBhcmUKPj4+Pj4+Pj4gc2V0Lgo+Pj4+
Pj4+PiAgICAgICAgICAgICAgKiBJZiBpdCBkb2VzIGhhcHBlbiB3ZSBhc3N1bWUgYSBsZWdhY3kg
Z3Vlc3QuCj4+Pj4+Pj4+ICAgICAgICAgICAgICAqLwo+Pj4+Pj4+PiAgICAgICAgICAgICBpZiAo
IXZkZXYtPmZlYXR1cmVzX3ZhbGlkKQo+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgIHZkcGFf
c2V0X2ZlYXR1cmVzKHZkZXYsIDApOwo+Pj4+Pj4+PiAgICAgICAgICAgICBvcHMtPmdldF9jb25m
aWcodmRldiwgb2Zmc2V0LCBidWYsIGxlbik7Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IEkgY2FuIHBvc3Qg
YSBwYXRjaCB0byBmaXggMikgaWYgdGhlcmUncyBjb25zZW5zdXMgYWxyZWFkeSByZWFjaGVkLgo+
Pj4+Pj4+Pgo+Pj4+Pj4+PiBUaGFua3MsCj4+Pj4+Pj4+IC1TaXdlaQo+Pj4+Pj4+IEknbSBub3Qg
c3VyZSBob3cgaW1wb3J0YW50IGl0IGlzIHRvIGNoYW5nZSB0aGF0Lgo+Pj4+Pj4+IEluIGFueSBj
YXNlIGl0IG9ubHkgYWZmZWN0cyB0cmFuc2l0aW9uYWwgZGV2aWNlcywgcmlnaHQ/Cj4+Pj4+Pj4g
TGVnYWN5IG9ubHkgc2hvdWxkIG5vdCBjYXJlIC4uLgo+Pj4+Pj4gWWVzIEknZCBsaWtlIHRvIGRp
c3Rpbmd1aXNoIGxlZ2FjeSBkcml2ZXIgKHN1cHBvc2UgaXQgaXMgMC45NSkgYWdhaW5zdCB0aGUK
Pj4+Pj4+IG1vZGVybiBvbmUgaW4gYSB0cmFuc2l0aW9uYWwgZGV2aWNlIG1vZGVsIHJhdGhlciB0
aGFuIGJlaW5nIGxlZ2FjeSBvbmx5Lgo+Pj4+Pj4gVGhhdCB3YXkgYSB2MC45NSBhbmQgdjEuMCBz
dXBwb3J0aW5nIHZkcGEgcGFyZW50IGNhbiBzdXBwb3J0IGJvdGggdHlwZXMgb2YKPj4+Pj4+IGd1
ZXN0cyB3aXRob3V0IGhhdmluZyB0byByZWNvbmZpZ3VyZS4gT3IgYXJlIHlvdSBzdWdnZXN0aW5n
IGxpbWl0IHRvIGxlZ2FjeQo+Pj4+Pj4gb25seSBhdCB0aGUgdGltZSBvZiB2ZHBhIGNyZWF0aW9u
IHdvdWxkIHNpbXBsaWZ5IHRoZSBpbXBsZW1lbnRhdGlvbiBhIGxvdD8KPj4+Pj4+Cj4+Pj4+PiBU
aGFua3MsCj4+Pj4+PiAtU2l3ZWkKPj4+Pj4gSSBkb24ndCBrbm93IGZvciBzdXJlLiBUYWtlIGEg
bG9vayBhdCB0aGUgd29yayBIYWxpbCB3YXMgZG9pbmcKPj4+Pj4gdG8gdHJ5IGFuZCBzdXBwb3J0
IHRyYW5zaXRpb25hbCBkZXZpY2VzIHdpdGggQkUgZ3Vlc3RzLgo+Pj4+IEhtbW0sIHdlIGNhbiBo
YXZlIHRob3NlIGVuZGlhbm5lc3MgaW9jdGxzIGRlZmluZWQgYnV0IHRoZSBpbml0aWFsIFFFTVUK
Pj4+PiBpbXBsZW1lbnRhdGlvbiBjYW4gYmUgc3RhcnRlZCB0byBzdXBwb3J0IHg4NiBndWVzdC9o
b3N0IHdpdGggbGl0dGxlCj4+Pj4gZW5kaWFuIGFuZCB3ZWFrIG1lbW9yeSBvcmRlcmluZyBmaXJz
dC4gVGhlIHJlYWwgdHJpY2sgaXMgdG8gZGV0ZWN0Cj4+Pj4gbGVnYWN5IGd1ZXN0IC0gSSBhbSBu
b3Qgc3VyZSBpZiBpdCdzIGZlYXNpYmxlIHRvIHNoaWZ0IGFsbCB0aGUgbGVnYWN5Cj4+Pj4gZGV0
ZWN0aW9uIHdvcmsgdG8gUUVNVSwgb3IgdGhlIGtlcm5lbCBoYXMgdG8gYmUgcGFydCBvZiB0aGUg
ZGV0ZWN0aW9uCj4+Pj4gKGUuZy4gdGhlIGtpY2sgYmVmb3JlIERSSVZFUl9PSyB0aGluZyB3ZSBo
YXZlIHRvIGR1cGxpY2F0ZSB0aGUgdHJhY2tpbmcKPj4+PiBlZmZvcnQgaW4gUUVNVSkgYXMgd2Vs
bC4gTGV0IG1lIHRha2UgYSBmdXJ0aGVyIGxvb2sgYW5kIGdldCBiYWNrLgo+Pj4gTWljaGFlbCBt
YXkgdGhpbmsgZGlmZmVyZW50bHkgYnV0IEkgdGhpbmsgZG9pbmcgdGhpcyBpbiBRZW11IGlzIG11
Y2ggZWFzaWVyLgo+PiBJIHRoaW5rIHRoZSBrZXkgaXMgd2hldGhlciB3ZSBwb3NpdGlvbiBlbXVs
YXRpbmcgbGVnYWN5IGludGVyZmFjZXMgaW4gUUVNVQo+PiBkb2luZyB0cmFuc2xhdGlvbiBvbiB0
b3Agb2YgYSB2MS4wIG1vZGVybi1vbmx5IGRldmljZSBpbiB0aGUga2VybmVsLCBvciB3ZQo+PiBh
bGxvdyB2ZHBhIGNvcmUgKG9yIHlvdSBjYW4gc2F5IHZob3N0LXZkcGEpIGFuZCB2ZW5kb3IgZHJp
dmVyIHRvIHN1cHBvcnQgYQo+PiB0cmFuc2l0aW9uYWwgbW9kZWwgaW4gdGhlIGtlcm5lbCB0aGF0
IGlzIGFibGUgdG8gd29yayBmb3IgYm90aCB2MC45NSBhbmQKPj4gdjEuMCBkcml2ZXJzLCB3aXRo
IHNvbWUgc2xpZ2h0IGFpZCBmcm9tIFFFTVUgZm9yCj4+IGRldGVjdGluZy9lbXVsYXRpb24vc2hh
ZG93aW5nIChmb3IgZS5nIENWUSwgSS9PIHBvcnQgcmVsYXkpLiBJIGd1ZXNzIGZvciB0aGUKPj4g
Zm9ybWVyIHdlIHN0aWxsIHJlbHkgb24gdmVuZG9yIGZvciBhIHBlcmZvcm1hbnQgZGF0YSB2cXMg
aW1wbGVtZW50YXRpb24sCj4+IGxlYXZpbmcgdGhlIHF1ZXN0aW9uIHRvIHdoYXQgaXQgbWF5IGVu
ZCB1cCBldmVudHVhbGx5IGluIHRoZSBrZXJuZWwgaXMKPj4gZWZmZWN0aXZlbHkgdGhlIGxhdHRl
cikuCj4+Cj4+IFRoYW5rcywKPj4gLVNpd2VpCj4KPiBNeSBzdWdnZXN0aW9uIGlzIHBvc3QgdGhl
IGtlcm5lbCBwYXRjaGVzLCBhbmQgd2UgY2FuIGV2YWx1YXRlCj4gaG93IG11Y2ggd29yayB0aGV5
IGFyZS4KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suIEkgd2lsbCB0YWtlIHNvbWUgcmVhZCB0aGVu
IGdldCBiYWNrLCBwcm9iYWJseSAKYWZ0ZXIgdGhlIHdpbnRlciBicmVhay4gU3RheSB0dW5lZC4K
ClRoYW5rcywKLVNpd2VpCgo+Cj4+PiBUaGFua3MKPj4+Cj4+Pgo+Pj4KPj4+PiBNZWFud2hpbGUs
IEknbGwgY2hlY2sgaW50ZXJuYWxseSB0byBzZWUgaWYgYSBsZWdhY3kgb25seSBtb2RlbCB3b3Vs
ZAo+Pj4+IHdvcmsuIFRoYW5rcy4KPj4+Pgo+Pj4+IFRoYW5rcywKPj4+PiAtU2l3ZWkKPj4+Pgo+
Pj4+Cj4+Pj4+Pj4+IE9uIDMvMi8yMDIxIDI6NTMgQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4+
Pj4+PiBPbiAyMDIxLzMvMiA1OjQ3IOS4i+WNiCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
Pj4+Pj4+Pj4+IE9uIE1vbiwgTWFyIDAxLCAyMDIxIGF0IDExOjU2OjUwQU0gKzA4MDAsIEphc29u
IFdhbmcgd3JvdGU6Cj4+Pj4+Pj4+Pj4+IE9uIDIwMjEvMy8xIDU6MzQg5LiK5Y2ILCBNaWNoYWVs
IFMuIFRzaXJraW4gd3JvdGU6Cj4+Pj4+Pj4+Pj4+PiBPbiBXZWQsIEZlYiAyNCwgMjAyMSBhdCAx
MDoyNDo0MUFNIC0wODAwLCBTaS1XZWkgTGl1IHdyb3RlOgo+Pj4+Pj4+Pj4+Pj4+PiBEZXRlY3Rp
bmcgaXQgaXNuJ3QgZW5vdWdoIHRob3VnaCwgd2Ugd2lsbCBuZWVkIGEgbmV3IGlvY3RsIHRvIG5v
dGlmeQo+Pj4+Pj4+Pj4+Pj4+PiB0aGUga2VybmVsIHRoYXQgaXQncyBhIGxlZ2FjeSBndWVzdC4g
VWdoIDooCj4+Pj4+Pj4+Pj4+Pj4gV2VsbCwgYWx0aG91Z2ggSSB0aGluayBhZGRpbmcgYW4gaW9j
dGwgaXMgZG9hYmxlLCBtYXkgSQo+Pj4+Pj4+Pj4+Pj4+IGtub3cgd2hhdCB0aGUgdXNlCj4+Pj4+
Pj4+Pj4+Pj4gY2FzZSB0aGVyZSB3aWxsIGJlIGZvciBrZXJuZWwgdG8gbGV2ZXJhZ2Ugc3VjaCBp
bmZvCj4+Pj4+Pj4+Pj4+Pj4gZGlyZWN0bHk/IElzIHRoZXJlIGEKPj4+Pj4+Pj4+Pj4+PiBjYXNl
IFFFTVUgY2FuJ3QgZG8gd2l0aCBkZWRpY2F0ZSBpb2N0bHMgbGF0ZXIgaWYgdGhlcmUncyBpbmRl
ZWQKPj4+Pj4+Pj4+Pj4+PiBkaWZmZXJlbnRpYXRpb24gKGxlZ2FjeSB2LnMuIG1vZGVybikgbmVl
ZGVkPwo+Pj4+Pj4+Pj4+Pj4gQlRXIGEgZ29vZCBBUEkgY291bGQgYmUKPj4+Pj4+Pj4+Pj4+Cj4+
Pj4+Pj4+Pj4+PiAjZGVmaW5lIFZIT1NUX1NFVF9FTkRJQU4gX0lPVyhWSE9TVF9WSVJUSU8sID8s
IGludCkKPj4+Pj4+Pj4+Pj4+ICNkZWZpbmUgVkhPU1RfR0VUX0VORElBTiBfSU9XKFZIT1NUX1ZJ
UlRJTywgPywgaW50KQo+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+IHdlIGRpZCBpdCBwZXIgdnJp
bmcgYnV0IG1heWJlIHRoYXQgd2FzIGEgbWlzdGFrZSAuLi4KPj4+Pj4+Pj4+Pj4gQWN0dWFsbHks
IEkgd29uZGVyIHdoZXRoZXIgaXQncyBnb29kIHRpbWUgdG8ganVzdCBub3Qgc3VwcG9ydAo+Pj4+
Pj4+Pj4+PiBsZWdhY3kgZHJpdmVyCj4+Pj4+Pj4+Pj4+IGZvciB2RFBBLiBDb25zaWRlcjoKPj4+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4gMSkgSXQncyBkZWZpbml0aW9uIGlzIG5vLW5vcm1hdGl2ZQo+
Pj4+Pj4+Pj4+PiAyKSBBIGxvdCBvZiBidWRyZW4gb2YgY29kZXMKPj4+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+Pj4gU28gcWVtdSBjYW4gc3RpbGwgcHJlc2VudCB0aGUgbGVnYWN5IGRldmljZSBzaW5jZSB0
aGUgY29uZmlnCj4+Pj4+Pj4+Pj4+IHNwYWNlIG9yIG90aGVyCj4+Pj4+Pj4+Pj4+IHN0dWZmcyB0
aGF0IGlzIHByZXNlbnRlZCBieSB2aG9zdC12RFBBIGlzIG5vdCBleHBlY3RlZCB0byBiZQo+Pj4+
Pj4+Pj4+PiBhY2Nlc3NlZCBieQo+Pj4+Pj4+Pj4+PiBndWVzdCBkaXJlY3RseS4gUWVtdSBjYW4g
ZG8gdGhlIGVuZGlhbiBjb252ZXJzaW9uIHdoZW4gbmVjZXNzYXJ5Cj4+Pj4+Pj4+Pj4+IGluIHRo
aXMKPj4+Pj4+Pj4+Pj4gY2FzZT8KPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4gVGhhbmtzCj4+Pj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gT3ZlcmFsbCBJIHdvdWxkIGJlIGZpbmUgd2l0aCB0aGlzIGFwcHJv
YWNoIGJ1dCB3ZSBuZWVkIHRvIGF2b2lkIGJyZWFraW5nCj4+Pj4+Pj4+Pj4gd29ya2luZyB1c2Vy
c3BhY2UsIHFlbXUgcmVsZWFzZXMgd2l0aCB2ZHBhIHN1cHBvcnQgYXJlIG91dCB0aGVyZSBhbmQK
Pj4+Pj4+Pj4+PiBzZWVtIHRvIHdvcmsgZm9yIHBlb3BsZS4gQW55IGNoYW5nZXMgbmVlZCB0byB0
YWtlIHRoYXQgaW50byBhY2NvdW50Cj4+Pj4+Pj4+Pj4gYW5kIGRvY3VtZW50IGNvbXBhdGliaWxp
dHkgY29uY2VybnMuCj4+Pj4+Pj4+PiBBZ3JlZSwgbGV0IG1lIGNoZWNrLgo+Pj4+Pj4+Pj4KPj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gICAgICAgSSBub3RlIHRoYXQgYW55IGhhcmR3YXJlCj4+Pj4+Pj4+
Pj4gaW1wbGVtZW50YXRpb24gaXMgYWxyZWFkeSBicm9rZW4gZm9yIGxlZ2FjeSBleGNlcHQgb24g
cGxhdGZvcm1zIHdpdGgKPj4+Pj4+Pj4+PiBzdHJvbmcgb3JkZXJpbmcgd2hpY2ggbWlnaHQgYmUg
aGVscGZ1bCBpbiByZWR1Y2luZyB0aGUgc2NvcGUuCj4+Pj4+Pj4+PiBZZXMuCj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4gVGhhbmtzCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
