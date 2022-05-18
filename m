Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BFFC433EF
	for <virtualization@archiver.kernel.org>; Wed, 18 May 2022 01:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 05AFA417F7;
	Wed, 18 May 2022 01:03:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h9bwLNvr_qJV; Wed, 18 May 2022 01:03:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CE6AA408F2;
	Wed, 18 May 2022 01:03:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97E26C0039;
	Wed, 18 May 2022 01:03:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6ACDDC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 01:03:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 66877403FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 01:03:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="SYLPlURF";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="LwdZ7URV"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DY0I8WB0aOhv
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 01:03:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6652040328
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 01:03:18 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HKcwlK031717;
 Wed, 18 May 2022 01:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RtWoS7oZc8hPDjQEf1s7pNJ+rOBr77UtDR6blA/z+Us=;
 b=SYLPlURFjTYSpyoB+deoA/m+y/rmUAXjB99VV6yq+wBzwe0SrQHdH3GoaSWDBgPKkFap
 //RJCGxn4LSM4tmsH601OvSJGc0r98XWGAOuaPEoUphoKPrL8/Zw7OcyjjLsLhynruxp
 TufiWAFKqKXPsvGtcONmM+TgYtTIe3rUSDnYBmOdYbTHNoAX9hecB8Y84qdtiXVpsyBN
 Jbqgd4D8+SlY0PRzVr3uVHQFB4Q9dDnEu8YrPSGcJyPLpLfGP0CAvGV6KUGVL7nSW30d
 DqaRVLQrCNdI88XMOrNYWVybgHclnKhyCQj9m+Y8zmsK9XQdY1n46TLtlA4FydUpJXHx Qw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24aafrfw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 May 2022 01:03:17 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24I0tWCv022469; Wed, 18 May 2022 01:03:16 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g22v3f4dh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 May 2022 01:03:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9K7feIhN7woGIaR8+A/AWeOnKSGFeQlyvimRrt4WLk2TpTQFRrSqYUPle5gn9kqZnbHr5v+1rT+B/X0eAEF8+zfGjqM9c4NuYoTaxNWira65QbjqGdEH/UfRVk3V4LW1hCESlGpxxZ33/rrK8778uZfObPvna/0567RjTwAsTf0wZIZ0i1gcNyjbIwagVZYGk/bi069at1ff/ipaq8welvWyzv9j9cAMFNhXx4iCsH3EK4FGUowDl3vYGUsSRUK4ikeeWE/4aox3UI+XqkQwIj1ffy4qjRSVockmzeKwSrE4I2bwrDj+VZWAiK0DsJ2IA11oG36oHMdfe7uCKVubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtWoS7oZc8hPDjQEf1s7pNJ+rOBr77UtDR6blA/z+Us=;
 b=FF8ltx03MBb7467eKinw8zCCw1tKjKGL5W8yydmD3998CuGBtVOuEq8HluV0ZqLOmmOQMvL1/iQRpE7hEGgnvkx/qZrrZaBiV/ZAuwPD62zmecGVZpqicrqVPPglXd8521xwzVC+dkS4wTQhm2eGHAz2xM4E8nSUmPkxe9JidLAZOLjAJ1yZP4m8CJR1JLn/ChwN7dcllGUpFVr2skINbf7TtEgFePfMtiQLYGvH1HHGtyH03Z7a1QJipw240Qfsl0rc06RIbnOvgu0tD078rEz55KrV1K8pyAUSDE0qRmXMK4/IA1NWTknXmmkmaulL8VnnqePQf8MvnZwETOPY0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtWoS7oZc8hPDjQEf1s7pNJ+rOBr77UtDR6blA/z+Us=;
 b=LwdZ7URVVvwQutcFeAWiPrWX2SuPJJ9cmUZtjn/y+4v8FD1W8W/HsTJbzsPIth2orUMO8aPz3U4wjUsehcr2v/HXhTLzm0uZGCNAxVNwbqwD3tjcKVovNB05qMEt9WxGzX4yJclKqPyGuXlceefnTctmtIXAPcxnX7vlw76InqU=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BN8PR10MB3284.namprd10.prod.outlook.com (2603:10b6:408:cb::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Wed, 18 May
 2022 01:03:12 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30%2]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 01:03:12 +0000
Message-ID: <65c78175-50bc-6aa9-154d-c67dcea70421@oracle.com>
Date: Tue, 17 May 2022 18:03:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 2/5] vdpa: Add support for querying vendor statistics
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com
References: <20220517131348.498421-1-elic@nvidia.com>
 <20220517131348.498421-3-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220517131348.498421-3-elic@nvidia.com>
X-ClientProxiedBy: BYAPR02CA0056.namprd02.prod.outlook.com
 (2603:10b6:a03:54::33) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70441ca7-443a-4b62-d619-08da386a2ea3
X-MS-TrafficTypeDiagnostic: BN8PR10MB3284:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB32842905C60A5AF39A8325F1B1D19@BN8PR10MB3284.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Co3siHbanfzgsjP+Cj2ycH0bJJZ5xQt4yOUImgQOkZCqB08JZMwjlymn9heBZcfd9RwCMbNqftEkTZsW4GSnr96yYFigQq9e+hKCQWzun66GeMHvylSSffU5hP5NjanRQgiaW75SIQ5ogGNu9Ce9PFoRxD7KheCC+EAWVcJsRwlo4u7I0nv2/aV01GeAHFBsc03wMeSNnzx2CmIYizjllBvEgBe/ge9/Nqj5FmxnWu3NkGsolC7JUzcrP1/4KssNSxnSeGCPWHLXxH14Gq+1rmk69pWuqjCDPe95Dps72dgHuHHFl/9MRNwsCydYXFv3cZbO8HDzrM9v4YYwxoJ/ADD4oKgnQFgJJr/pZUcGw8NMN+sK8N06LtPFpiQeCOknL79x3y+/KtjU1RVLkvLWTyx8dL/Uvf+eQies1BHwFgS4JfZ2R52it9QNMe2Y8bzipe153cD4WczsoZCJdI8gs++bK379k3w6/fhdAlaz0CrR2F8guyITmPCVamDKLVHgKu4eRDynR6N2QR9W3oa5bDhQp1RJZggjN9taim24KujV9NvFNS9Bwx8Gh3mR6ZLNPHurwz1Gk0gqkUCmahv57Uplzirla9NrEIayHVAvtiKdslPmr9XXJYuwguAfucP9kJAbp8Bkm5zP9l4sfNFLGnCaDPdu1CR9juy4FfiThHEG06C3p1MgS8JeHGaI9D0tAmS8hb8XCc2ZlHop63E75yt4ox+RTT3IV7GZtupP3KYKh97VcLC4EIRVWrnh3PL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(31696002)(36756003)(4326008)(8676002)(8936002)(66476007)(66556008)(66946007)(508600001)(5660300002)(6486002)(86362001)(53546011)(26005)(2616005)(6506007)(6512007)(83380400001)(38100700002)(2906002)(36916002)(31686004)(186003)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckdWY2lGb2NLdFIwKzBYRDYwa25BTjFRd0VRTFowUGlLeDJPMTMwNjdIb0k1?=
 =?utf-8?B?WTdtdTVOMURaWWtmZFVDck83YkM0cHJqVTI1cnFsOEZFUGFrWjJiMFRtcVNn?=
 =?utf-8?B?RUlsQUVWWmxWWmRVTG4yVDNYelJvTmJISFhrbklhYnpmYkZ6ZG9sN3dETFZB?=
 =?utf-8?B?a0p5Sk1HNDMwZkExbE9Ia1pRMEcvcTFUS1MwTmdxcEpmdWJiM08xdE80LzV4?=
 =?utf-8?B?YnZFbzV5QjJoMWJldEUvZk9jMWJkaTN5bEE5SVlnc3BGZkxBQmp2M1Y5N1N5?=
 =?utf-8?B?QUNFcmxtMysxM3hrVWgweFZteVg1cnlEczVGR1lVdzdscGhVY0IrWGl0NGhX?=
 =?utf-8?B?UGNBTHU3bHp3UFdLRTl1WnU1RnV0TStVQnN6Q3I0SUlZZFl4Wlh1QndHODJi?=
 =?utf-8?B?WE83Z05kNWFjWlIwMDRyQmNXMUdCSzBiSk5rRUpLUGRQSG8zUDBjdXNNeitZ?=
 =?utf-8?B?TVRuanhlMkdIWkpscEFJdytNeSt0Mkl1cDRNOXkrMHlNUlc2cWt3N3hPM240?=
 =?utf-8?B?YnRQZzBFUEhnLzlTN1RrRm9RKytWa1d0ZXYxNUdzNzk0WG9HY0NGVXBRVy80?=
 =?utf-8?B?ZHY5aGFvb1U3ZldLeTUvbUxxTnpqTkFJRDJRQkJpNWk2WnJLMkVjYzhQdURh?=
 =?utf-8?B?Z2tJZExzL1VvWElsQ1NwZ2lmYS9pSGpjYVAyRHVzUWNLREltbHVRMGxreDd6?=
 =?utf-8?B?UkpqYnhFSUtCbjdKZUVlSU8zRUtZamxuOWgvUlU1eFZYdnhEMlhCMC8wcTdU?=
 =?utf-8?B?ei80MmFvL0lVNTRSS3dWb0NpVUxXRkJLYy9ITGowMStOcWh0UnlrTFZxQkZL?=
 =?utf-8?B?bG1PYko4YjJibCs4Nks2dTk4eWpuV3UvcDZCMzN4Vm5YM2VxaE93b0U4VzVP?=
 =?utf-8?B?N2Q2TmJRKzQ3N01sWnV2VzFWaFFhU0lwd2QrRTJMNllLc0VtK1haZ3FFMmxV?=
 =?utf-8?B?bDBSRXEvNit3T2I4Um9wRWpidFNTbmJVZmk4ZkdTSjZBUTNIdnk4RWZIOEh3?=
 =?utf-8?B?WDhnK0ppOHpCaEthUWFDbFdsSW9uYnBtb0V3b1VBS1h1MnphaVMwcFBZQUZh?=
 =?utf-8?B?R2pHYUVuR25kckhBQ0g1aktXTFY2bHJsckk0bTBDazhzTTFxSGpwTTVldlRU?=
 =?utf-8?B?NU5FVTRDWGFhVUtXaEcvSUF3SmNrYXV6SkE0YWp4NDF0cWdERzVhRHVwdHln?=
 =?utf-8?B?MmtaRXQwK0FBNDBWanJkanZ2Z3AyQ09RV21pNFh6UEhHSTYxdEN6QTVtaTJm?=
 =?utf-8?B?ZzNyU3JnZ3h0SXJsUDBVcXVyOElLZzQrWEZPdmo3U0MrZXdlOXFRNytOb1RG?=
 =?utf-8?B?dVpETEc1SmZkTnBvRFBNbWxJclgvbHBSWlBEb0x0ZGdIalN2QmpINWZDSlcy?=
 =?utf-8?B?Z2tyRFFNN3VTY0hTNzd3ZHhNNUdHUDQvQ2E3ZXlsWTU0dE9LcG9maFBiSE1v?=
 =?utf-8?B?NURuWXR1VkJBUjhJNVdxZ0tCN2lQTmM4RVJvcU9Jc0NaZ01vNzlTVjg5YVI3?=
 =?utf-8?B?WlhrMEJkaGJWdVR0cnhvTEkzWndaUk42MUc5Unp5T0tTcEEycFUzN1NOSTZQ?=
 =?utf-8?B?bHhuMExzTnNBa1lCc1RhQWE2VFlrb2ZydHQ3emV5YUxXN3Y0bnBxOWpiUjBJ?=
 =?utf-8?B?a2J3UEVmSWJZZUNzMkhCKzBOMmpYWmxqS1g2bFR2TVlJbkxseVhRb0cxaERE?=
 =?utf-8?B?Y1VuckhZR1lWRjJ1UUxReXdWeEZ5TlJUYVpDSi9LcytvSElYRnlXSjhMU2Q1?=
 =?utf-8?B?VDkwTUFyM1Awem5ubVQrUXNyNEx3VUpZdWZ5SE5FNG0zVVlsK1g4ZnZUdmFa?=
 =?utf-8?B?bUZlR0psOXJuYS9MbVBvczViQVBDSCtPeGNrS3Q2SU1xbFJMT1BqVjBSM0dY?=
 =?utf-8?B?QjdEd0ZGd2N0Z2tGUERjMFE3ZVBaOTgrV25ra1BibEd1VUVTd2RzLzJUeFBI?=
 =?utf-8?B?cXBBV1VMSEE4bmlKRGFrbThsbEdiNkQwNXp5ZGcxeDhRR2hBbWNrZXVrbkhj?=
 =?utf-8?B?V3RQSWdGQzgvQjJXdHRrNlFRRVErYUczVzIwNk5XQVlzaEV2U3pqbStyZ1Nr?=
 =?utf-8?B?ODgwTzlnckwweGE2M2VCVHZ6NU9HWjdKU0QvK1VGekRidlVPWTJjYk94Ui9N?=
 =?utf-8?B?M3E2REFnNk1XVWlxd3FxY2x2cEFYN3IvTnMralh6bjZNdVo3S3haYWNUeEUw?=
 =?utf-8?B?NHpzenVHUENyV2p0NjN0VlgrTFFFNE9aTGI0SFU4NzM1dlZmMG1IOUM5L1RT?=
 =?utf-8?B?dTh1RXJEQzQvRWNSWWFqb2R2cVk5WE9WdEIxa3NIa3dyckV3NXhaempyT2Zj?=
 =?utf-8?B?dTQzTTh3cndUWUczWTZFOURSQ1VCNHhlTXFVbnVnWWd4azVLMEY0WklNZk9Z?=
 =?utf-8?Q?TG0H8mDT339AJEng=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70441ca7-443a-4b62-d619-08da386a2ea3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 01:03:12.7930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omV4YRNHMNYnBqRV+R1M/9px4n61XW5jBYibo4rBxQzBp15C22ox2DXJ4DXQB+Qorc70Un8LRu9cN2tvxKMSyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3284
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.874
 definitions=2022-05-17_03:2022-05-17,
 2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205180004
X-Proofpoint-ORIG-GUID: qyLCjly8CWxG_-hlhQFuijybN2kGJwl1
X-Proofpoint-GUID: qyLCjly8CWxG_-hlhQFuijybN2kGJwl1
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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



On 5/17/2022 6:13 AM, Eli Cohen wrote:
> Allows to read vendor statistics of a vdpa device. The specific
> statistics data are received from the upstream driver in the form of an
> (attribute name, attribute value) pairs.
>
> An example of statistics for mlx5_vdpa device are:
>
> received_desc - number of descriptors received by the virtqueue
> completed_desc - number of descriptors completed by the virtqueue
>
> A descriptor using indirect buffers is still counted as 1. In addition,
> N chained descriptors are counted correctly N times as one would expect.
>
> A new callback was added to vdpa_config_ops which provides the means for
> the vdpa driver to return statistics results.
>
> The interface allows for reading all the supported virtqueues, including
> the control virtqueue if it exists.
>
> Below are some examples taken from mlx5_vdpa which are introduced in the
> following patch:
>
> 1. Read statistics for the virtqueue at index 1
>
> $ vdpa dev vstats show vdpa-a qidx 1
> vdpa-a:
> queue_type tx queue_index 1 received_desc 3844836 completed_desc 3844836
>
> 2. Read statistics for the virtqueue at index 32
> $ vdpa dev vstats show vdpa-a qidx 32
> vdpa-a:
> queue_type control_vq queue_index 32 received_desc 62 completed_desc 62
>
> 3. Read statisitics for the virtqueue at index 0 with json output
> $ vdpa -j dev vstats show vdpa-a qidx 0
> {"vstats":{"vdpa-a":{
> "queue_type":"rx","queue_index":0,"name":"received_desc","value":417776,\
>   "name":"completed_desc","value":417548}}}
>
> 4. Read statistics for the virtqueue at index 0 with preety json output
> $ vdpa -jp dev vstats show vdpa-a qidx 0
> {
>      "vstats": {
>          "vdpa-a": {
>
>              "queue_type": "rx",
>              "queue_index": 0,
>              "name": "received_desc",
>              "value": 417776,
>              "name": "completed_desc",
>              "value": 417548
>          }
>      }
> }
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/vdpa.c       | 160 ++++++++++++++++++++++++++++++++++++++
>   include/linux/vdpa.h      |   3 +
>   include/uapi/linux/vdpa.h |   6 ++
>   3 files changed, 169 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index fac89a0d8178..1b810961ccc3 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -914,6 +914,106 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
>   	return err;
>   }
>   
> +static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff *msg,
> +			       struct genl_info *info, u32 index)
> +{
> +	struct virtio_net_config config = {};
> +	u64 features;
> +	u16 max_vqp;
> +	u8 status;
> +	int err;
> +
This entire function should perhaps need to take cf_mutex (worth 
converting to rwsem as well) to guard against concurrent modification 
via .set_status() or .set_config() from the upper stack. Similar to 
vdpa_dev_config_fill().

> +	status = vdev->config->get_status(vdev);
> +	if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
> +		NL_SET_ERR_MSG_MOD(info->extack, "feature negotiation not complete");
> +		return -EAGAIN;
> +	}
> +	vdpa_get_config(vdev, 0, &config, sizeof(config));
This should use vdpa_get_config_unlocked() without lock.

Regards,
-Siwei

> +
> +	max_vqp = le16_to_cpu(config.max_virtqueue_pairs);
> +	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, max_vqp))
> +		return -EMSGSIZE;
> +
> +	features = vdev->config->get_driver_features(vdev);
> +	if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES,
> +			      features, VDPA_ATTR_PAD))
> +		return -EMSGSIZE;
> +
> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
> +		return -EMSGSIZE;
> +
> +	err = vdev->config->get_vendor_vq_stats(vdev, index, msg, info->extack);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int vendor_stats_fill(struct vdpa_device *vdev, struct sk_buff *msg,
> +			     struct genl_info *info, u32 index)
> +{
> +	int err;
> +
> +	if (!vdev->config->get_vendor_vq_stats)
> +		return -EOPNOTSUPP;
> +
> +	err = vdpa_fill_stats_rec(vdev, msg, info, index);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int vdpa_dev_vendor_stats_fill(struct vdpa_device *vdev,
> +				      struct sk_buff *msg,
> +				      struct genl_info *info, u32 index)
> +{
> +	u32 device_id;
> +	void *hdr;
> +	int err;
> +	u32 portid = info->snd_portid;
> +	u32 seq = info->snd_seq;
> +	u32 flags = 0;
> +
> +	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
> +			  VDPA_CMD_DEV_VSTATS_GET);
> +	if (!hdr)
> +		return -EMSGSIZE;
> +
> +	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev))) {
> +		err = -EMSGSIZE;
> +		goto undo_msg;
> +	}
> +
> +	device_id = vdev->config->get_device_id(vdev);
> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {
> +		err = -EMSGSIZE;
> +		goto undo_msg;
> +	}
> +
> +	switch (device_id) {
> +	case VIRTIO_ID_NET:
> +		if (index > VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX) {
> +			NL_SET_ERR_MSG_MOD(info->extack, "queue index excceeds max value");
> +			err = -ERANGE;
> +			break;
> +		}
> +
> +		err = vendor_stats_fill(vdev, msg, info, index);
> +		break;
> +	default:
> +		err = -EOPNOTSUPP;
> +		break;
> +	}
> +	genlmsg_end(msg, hdr);
> +
> +	return err;
> +
> +undo_msg:
> +	genlmsg_cancel(msg, hdr);
> +	return err;
> +}
> +
>   static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info *info)
>   {
>   	struct vdpa_device *vdev;
> @@ -995,6 +1095,60 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
>   	return msg->len;
>   }
>   
> +static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
> +					  struct genl_info *info)
> +{
> +	struct vdpa_device *vdev;
> +	struct sk_buff *msg;
> +	const char *devname;
> +	struct device *dev;
> +	u32 index;
> +	int err;
> +
> +	if (!info->attrs[VDPA_ATTR_DEV_NAME])
> +		return -EINVAL;
> +
> +	if (!info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX])
> +		return -EINVAL;
> +
> +	devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> +	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	index = nla_get_u32(info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
> +	mutex_lock(&vdpa_dev_mutex);
> +	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
> +	if (!dev) {
> +		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> +		err = -ENODEV;
> +		goto dev_err;
> +	}
> +	vdev = container_of(dev, struct vdpa_device, dev);
> +	if (!vdev->mdev) {
> +		NL_SET_ERR_MSG_MOD(info->extack, "unmanaged vdpa device");
> +		err = -EINVAL;
> +		goto mdev_err;
> +	}
> +	err = vdpa_dev_vendor_stats_fill(vdev, msg, info, index);
> +	if (err)
> +		goto mdev_err;
> +
> +	err = genlmsg_reply(msg, info);
> +
> +	put_device(dev);
> +	mutex_unlock(&vdpa_dev_mutex);
> +
> +	return err;
> +
> +mdev_err:
> +	put_device(dev);
> +dev_err:
> +	nlmsg_free(msg);
> +	mutex_unlock(&vdpa_dev_mutex);
> +	return err;
> +}
> +
>   static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>   	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
>   	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
> @@ -1035,6 +1189,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
>   		.doit = vdpa_nl_cmd_dev_config_get_doit,
>   		.dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
>   	},
> +	{
> +		.cmd = VDPA_CMD_DEV_VSTATS_GET,
> +		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
> +		.doit = vdpa_nl_cmd_dev_stats_get_doit,
> +		.flags = GENL_ADMIN_PERM,
> +	},
>   };
>   
>   static struct genl_family vdpa_nl_family __ro_after_init = {
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 8943a209202e..2ae8443331e1 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -276,6 +276,9 @@ struct vdpa_config_ops {
>   			    const struct vdpa_vq_state *state);
>   	int (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
>   			    struct vdpa_vq_state *state);
> +	int (*get_vendor_vq_stats)(struct vdpa_device *vdev, u16 idx,
> +				   struct sk_buff *msg,
> +				   struct netlink_ext_ack *extack);
>   	struct vdpa_notification_area
>   	(*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
>   	/* vq irq is not expected to be changed once DRIVER_OK is set */
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 1061d8d2d09d..25c55cab3d7c 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -18,6 +18,7 @@ enum vdpa_command {
>   	VDPA_CMD_DEV_DEL,
>   	VDPA_CMD_DEV_GET,		/* can dump */
>   	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
> +	VDPA_CMD_DEV_VSTATS_GET,
>   };
>   
>   enum vdpa_attr {
> @@ -46,6 +47,11 @@ enum vdpa_attr {
>   	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
>   	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */
>   	VDPA_ATTR_DEV_SUPPORTED_FEATURES,	/* u64 */
> +
> +	VDPA_ATTR_DEV_QUEUE_INDEX,              /* u32 */
> +	VDPA_ATTR_DEV_VENDOR_ATTR_NAME,		/* string */
> +	VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
> +
>   	/* new attributes must be added above here */
>   	VDPA_ATTR_MAX,
>   };

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
