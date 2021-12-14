Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E50C433EF
	for <virtualization@archiver.kernel.org>; Tue, 14 Dec 2021 02:00:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94E5281369;
	Tue, 14 Dec 2021 02:00:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c6mmVldx9bcX; Tue, 14 Dec 2021 02:00:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 17F6E81367;
	Tue, 14 Dec 2021 02:00:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7323C001E;
	Tue, 14 Dec 2021 01:59:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44A3FC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 01:59:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1D21781367
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 01:59:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id unkfZ5hv0-EB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 01:59:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 897C681365
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 01:59:57 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BE1sI7D022081; 
 Tue, 14 Dec 2021 01:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+TmTfjlpf0SjCYjtZib430MwZmGaZWyssOSnIw3LGG0=;
 b=vo3SnCIs0ZRHq5xDB7TrKByGWmtNcwwgQDEgDwSSDDFpAp3d1yALuMl33hkgwab0v+sT
 RmrWK08aOSKMUvA1saM2UWs+cvuSUi4nLYGIKAT4NuDVuczaCPR10ZnFWAQ0ajwnzmeI
 bgIP3+x2yS+Unhf1Un26EkvluHk0o2lkfosEpaeZFz9yrHWoZwRLI84ST++ysbfnGDzL
 wfUCGlE9M7pj9IuETTWSPb+rukkLWRRK3pIhQqGpFZM7Mz+TDtNNktSl+fSNvvtzXtqG
 TPH7+SqY0/gM/ACgOxzEA3Vlhj9AfOMGbcRlr8M1aCaRzLA7MQ3pYcDkEPYls46kbzY2 tQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cx2nfahpx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Dec 2021 01:59:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BE1t4ck149910;
 Tue, 14 Dec 2021 01:59:54 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
 by userp3020.oracle.com with ESMTP id 3cvnep3j05-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Dec 2021 01:59:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liU18UPbxUxEFanvgtcUHIaAOrsqIOAdnPZPZCjGaN9pf13HCmKp5sBviR1fWIwr0BTDBQHV1x1lhwg1WTn4kApo1lAfcOaYMptAbSeQspfVHhAVjlmAl/LT4C5qlTBpsYdEG/+U+j08pACKQdKltrnuxvL2h71R+ppsS6A4lv4HlN7hMBER8nLeO3vlCkZVfjEXLX1Wb/+yCZCpYzlpE1nvX0CiZFSOHotd/pq4mwmgmoRzSaXSoQ+7s7AkzUzVohSa5LnI0C7g0szhXDQY//JXiUsfsVYnhpZtN+DDLq0IQRKlHJdOgGlIigGRyusK4qbzIKACPEHkl1Wl4XfR0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TmTfjlpf0SjCYjtZib430MwZmGaZWyssOSnIw3LGG0=;
 b=krbgmF/XoUrgApqH6vHwAo+or5NWG6FtkFeySOheN3+g+Ym6CcVc1rscJXxZIpO634SMXU5rVS8q7YluWKAgB562v6S5cZNIaFldf/gfLMD5zYXYaY+WshgehZ501gQcOd44rC8qhRzR/sZGZA2e/vPbF6WOk11bG0mnTUDwNELbzTxeHb15OW7/3f5g7Hf4Y/8SFDbsues2pJJ+LQnTkOLYBQdtugAjIUtmdNL0W1AMB1nzzNclwVtqw6wAOEZIy746nabbz9s3ALPXtyHtFIxDzbRONA9A/9ndX++/xn6pUFyGZngCyEGRzidydj5XG0prrR77CkxVLFKFtjirFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TmTfjlpf0SjCYjtZib430MwZmGaZWyssOSnIw3LGG0=;
 b=sdXCzLERihYwcubckfuGiJYIBJinhFomPsqSiE/waBlNeYY3SUYL1UPu0VOCa7FPG1NTXL2uM1aZqFpUhBh8Tso8wX/ToXhcxLM2Ofo9lUaeTVkhmuMJSYCQ9X2bUN8+27COYShqMYduWtP05DRDPrryO+FOmtRTQHEqhNpXYBg=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Tue, 14 Dec
 2021 01:59:52 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4778.017; Tue, 14 Dec 2021
 01:59:52 +0000
Message-ID: <ba9df703-29af-98a9-c554-f303ff045398@oracle.com>
Date: Mon, 13 Dec 2021 17:59:45 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: vdpa legacy guest support (was Re: [PATCH] vdpa/mlx5:
 set_features should allow reset to zero)
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
 <20210228163031-mutt-send-email-mst@kernel.org>
 <2cb51a6d-afa0-7cd1-d6f2-6b153186eaca@redhat.com>
 <20210302043419-mutt-send-email-mst@kernel.org>
 <178f8ea7-cebd-0e81-3dc7-10a058d22c07@redhat.com>
 <c9a0932f-a6d7-a9df-38ba-97e50f70c2b2@oracle.com>
 <20211212042311-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211212042311-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SN4PR0601CA0010.namprd06.prod.outlook.com
 (2603:10b6:803:2f::20) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 105102f0-ecfc-4755-c343-08d9bea56af1
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5598:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB55980CD3EAC9AE90E8A1D9D9B1759@SJ0PR10MB5598.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XS5vvsSZDa5TdiL549Ykxt+/sFPsb8FnkQaK+ral1lLaDaZHuWtyhntJoIRouqMKRO4YQfsOCJ0HGLd1DYGXPWSjPddJfUyYxcmM75VLO2zppiUhdjFZ2KkAJ5r9W2m3Q5GeXVfPtAh1k1sXfttuS/ZbHoeKirrfZO65bl7hXIEB6mJyqP5i6ZVR+auCVSKBuOu8NABnNdbIFKwjLHuXpgJ0zhHOeiGj5W2odB037HTH0U1/6vsN+F4wnnpP0encEc/VttmwkOmDdK/rGy7WSlFvw24/0Fc7bWX8B0nLUTNMz/qUEr6AoZDjdPcH7LQwtBccsV+K0Y7ZZi6Z6CaPugxHZjZ8NH1hasrgVVvByOhq1T1+/XcMqoWtrmkbyIvkeGApaXtssYJxmiZbYfvIDdQuN0Z6ucCQBKg9GP7luWNuA00PvHgxZ9Dv61r39zX1E/ckpMK74P4FX0SZIHxH+tap6PxocbJvlm+328H4YTriRAmnZgXQO1i8W8mdbeOQloweSnawTYOIDAxlkKzGo6E2vzSunRp7Ses4DioTDstenDiSV90wicyWH3fn0qFe41ce+4rHS1Eg2uRPq1S9fR2KS423wMAfPKQnEtgmNPzRD3PtB0nbqlprTCJhZmHnXiXlQ7KMMjIRBkGAC9KATUmR7F2asD+tqi2HvK7RhIX4hsHpN1inj5CZBCQreQ+pXmNbFjODHr6Gr2Mt99CZ4cbSLCxcMrvBJMAFw+2WKQ1KL/IAktHt2gzfZjWQKEeKvN5iZim9wXYgmWVbFK+kegMHjYgXAsUMjLfF+sG/twrVLbVo5NQIf/k6KjNgq5rd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(2616005)(5660300002)(83380400001)(6666004)(31696002)(6916009)(316002)(8936002)(2906002)(4326008)(86362001)(8676002)(66946007)(36756003)(6512007)(38100700002)(966005)(6506007)(53546011)(186003)(66556008)(66476007)(36916002)(26005)(31686004)(508600001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGJqQ1JkcFltUW1zTFd0YUdLMmc5RU5PU1FCcTF3S210LzhOVzVLV2ZFNEc1?=
 =?utf-8?B?c09NNjIxVFFOM2FERkVrTHVWNHFrU2hnTzQxYTRKNitSVktCNkt0WWRVdG81?=
 =?utf-8?B?SkJxRlFaL0NkOUxVZDhEbTE2RW9FQ3dxekZ5bndTQ2RIdnkxTlpnakNkNll5?=
 =?utf-8?B?UkN6NTZhdk1MeDRqMG9WM05obllIS1YrdG03MXhwVjVxYVBicHE3QUtTWk1p?=
 =?utf-8?B?OExuem9rUmFvS0p6eXpJK1VHMzZVMG4rLzBldzFHYmlxaDJZdVJHZk5nRXFI?=
 =?utf-8?B?S2t4c0lqUkEyTytuQWlSRFAxZXZ1QnZoay9GSlFlRW1UQ3FjbFhMcXlOLytm?=
 =?utf-8?B?aERVbUhQdGlMT0IyY2Z1NERkckNyeDIzaDNTbmlHYWV2QklCWmVWb0dZSGtP?=
 =?utf-8?B?Yk9kVEtaUlp3K3RDVW5DdGV6QktoTEFwcTBWdWJOUi9RamhZVDNtZmcyTXR1?=
 =?utf-8?B?bzhkcXFMWmFOdkxFVzNxdUJJUU9CY3lJV3loa2lQRUQ0aEl3K1BUT2pvVVlu?=
 =?utf-8?B?bWxXUlpJc3FIajFJTEVhcHpNSW5BWmRaZkRjZkRvY2tEL3VaNHRsUmpPSjJw?=
 =?utf-8?B?N3ZpWEhSRXlmc1l2NDN4aitJYmlaZkkwbGYwZnFJNXI5OXhqaDBVcXpORkUv?=
 =?utf-8?B?WmpIQ0xycGZmSHh6NWFSVDd3SEJDYjV3OTNIMk1Pdmw0V2FZdXM2RDZPdlZt?=
 =?utf-8?B?OUFYSFFRcGI2ZlhDUGRhZUtFUTZBVnp1WmhYOWhxYnhaNTREUCtSZlp6aUNy?=
 =?utf-8?B?V2pMZ25YOHg1UGVxWE0rR2J3OXBaYWJBdjNuRkFnWDdQckZENzEvZDR4MzdM?=
 =?utf-8?B?SVJnZXNtazB1TTdMUE5uMGFuL0pIWGJtVENMc3lHZjVjOVUzOWxicVRLTzAx?=
 =?utf-8?B?Z3doWUtUZWJaRzMvdWNtbnhaa0k0WnVBRE1WUXFGQ0lxTU5MaE9PQ3BDTGdR?=
 =?utf-8?B?ZjdITUlJckM4NGwzWjk0MW5TeVcrQ0xJQjV6VWxIdzNSLzFzamxMbEpVbnoy?=
 =?utf-8?B?MWZDclJHeUxBMWZWOGZ3NFB0SU1vVFlESllEc1dnVkFMczhKTGhTcUVwUDVC?=
 =?utf-8?B?bHROUktTYkZNSitZKzluVzdnZnV0bEQyTkRKczZRdnVUYUdwSHk1aUpaVW5o?=
 =?utf-8?B?TGozNlo2aEt4Y01XbGNiWDMrNitlQWVPNzFiMndPUDNqNnRYelJYM2NzZnQz?=
 =?utf-8?B?Nmk0cXE1ZlBKaFVNdjNDY3ZyaUNNWlJFTytQVEpKTHdhU2dYK2lMMURacjNw?=
 =?utf-8?B?VTBtT1o4OE9RTVU0YUM4THRMMVE3RUNJZmxzY3FyeVM2Rm1YSlBscUZTMEVO?=
 =?utf-8?B?V2tDR0pwTjFjajNRR1hYU3h4Q0d1V0pYNUhzNXRKeS9zVnR5YmxIYU1JdTUr?=
 =?utf-8?B?SVhldWpOb0JpYlk5ZytoTm1Yd21TM1haNFR4ZTlxM3ZsaUFuR2IyRUphR2Zz?=
 =?utf-8?B?bVpOQjduUVV6RlpVdGorQnptRDNNNkFGNy95RGVEMDFHUEpXbTlxREZLa2Zk?=
 =?utf-8?B?NS9KQWRuQXhobHNHNjB3bFY3UHhSMUdRNi9VQS8rMlZaOWVESlpZbVJrUlF3?=
 =?utf-8?B?Mk5sSG1tQ2pWUW9kVitST2wyamQ5ZmVpYkYyTG0zMS9zMytVYkR3M2MxdG52?=
 =?utf-8?B?cWo0eGc3eEU3d1RIWHBRQTVEN056Q0dCMmRNemZySm9vMzdqRFpLVE13L05n?=
 =?utf-8?B?UEVvUktWeVpEVGpoWnhBMDJRR1hOM25KaURONlpUYzVXZHI4eDlwMUhpejg5?=
 =?utf-8?B?amhBYUF2VG1GcWNORkJMVXVpNmVpUE1nR0NSMVZLSkQ2Lzltblphai9aQ2FZ?=
 =?utf-8?B?TVFlb2cvQ09TSHdWRFd4RmlzSGlraVhDR2VUdXJXdzhndUc3SG50NjRxcmFz?=
 =?utf-8?B?cGU4aDVtT2FFclFhSEhwWWRyb3drVEJFT2RuSStTUlNVRWY5S3pnMS9IWHFk?=
 =?utf-8?B?Nm55ZUROWUI1MW5BaDM1ME43dCtGdVNSdjVWdEFERHhuZDRwUWJQdkpNb1Yx?=
 =?utf-8?B?VE1TYTlDRGJEZ1dLMEY0Q3ZaRzYvV3N5MUZGTmFWSXZUMXE0cGlTS0ViQ0NN?=
 =?utf-8?B?R2NVVlBRUUhFcTA5RFpGQlVOdzVmenJCRGVyS2Uwam5sL3VjRWFiRmJYZFdI?=
 =?utf-8?B?NzRQRm1BVVBLZHU3TzZOYmwzNHQ2b2dZZ1FSalEwTTRMZ3c1M1JQYXl6Qmo5?=
 =?utf-8?Q?Z0Sh6INQtfE60CSi2GmDmGU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105102f0-ecfc-4755-c343-08d9bea56af1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 01:59:52.4308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bwlAou8UjnJ8nZXv1OdyILRv+1jMPfz6EndnIQBtTdVK+5o7Ult/XZ4XZEZugIGfx7q2s+5aHbvdyUdQZVzOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140007
X-Proofpoint-ORIG-GUID: PumS6uZhRzEVXE36jRR7XQI_tNxL79O4
X-Proofpoint-GUID: PumS6uZhRzEVXE36jRR7XQI_tNxL79O4
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elic@nvidia.com, linux-kernel@vger.kernel.org
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

CgpPbiAxMi8xMi8yMDIxIDE6MjYgQU0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBG
cmksIERlYyAxMCwgMjAyMSBhdCAwNTo0NDoxNVBNIC0wODAwLCBTaS1XZWkgTGl1IHdyb3RlOgo+
PiBTb3JyeSBmb3IgcmV2aXZpbmcgdGhpcyBhbmNpZW50IHRocmVhZC4gSSB3YXMga2luZGEgbG9z
dCBmb3IgdGhlIGNvbmNsdXNpb24KPj4gaXQgZW5kZWQgdXAgd2l0aC4gSSBoYXZlIHRoZSBmb2xs
b3dpbmcgcXVlc3Rpb25zLAo+Pgo+PiAxLiBsZWdhY3kgZ3Vlc3Qgc3VwcG9ydDogZnJvbSB0aGUg
cGFzdCBjb252ZXJzYXRpb25zIGl0IGRvZXNuJ3Qgc2VlbSB0aGUKPj4gc3VwcG9ydCB3aWxsIGJl
IGNvbXBsZXRlbHkgZHJvcHBlZCBmcm9tIHRoZSB0YWJsZSwgaXMgbXkgdW5kZXJzdGFuZGluZwo+
PiBjb3JyZWN0PyBBY3R1YWxseSB3ZSdyZSBpbnRlcmVzdGVkIGluIHN1cHBvcnRpbmcgdmlydGlv
IHYwLjk1IGd1ZXN0IGZvciB4ODYsCj4+IHdoaWNoIGlzIGJhY2tlZCBieSB0aGUgc3BlYyBhdAo+
PiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9vemxhYnMub3JnLypydXN0eS92
aXJ0aW8tc3BlYy92aXJ0aW8tMC45LjUucGRmX187ZmchIUFDV1Y1TjlNMlJWOTloUSFkVEttekp3
d1JzRk03QnRTdVREdTFjTmx5NW40WENvdEgwV1ltaWR6R3FIU1h0NDBpN1pVNDNVY05nN0dZeFpn
JCAuIFRob3VnaCBJJ20gbm90IHN1cmUKPj4gaWYgdGhlcmUncyByZXF1ZXN0L25lZWQgdG8gc3Vw
cG9ydCB3aWxkZXIgbGVnYWN5IHZpcnRpbyB2ZXJzaW9ucyBlYXJsaWVyCj4+IGJleW9uZC4KPiBJ
IHBlcnNvbmFsbHkgZmVlbCBpdCdzIGxlc3Mgd29yayB0byBhZGQgaW4ga2VybmVsIHRoYW4gdHJ5
IHRvCj4gd29yayBhcm91bmQgaXQgaW4gdXNlcnNwYWNlLiBKYXNvbiBmZWVscyBkaWZmZXJlbnRs
eS4KPiBNYXliZSBwb3N0IHRoZSBwYXRjaGVzIGFuZCB0aGlzIHdpbGwgcHJvdmUgdG8gSmFzb24g
aXQncyBub3QKPiB0b28gdGVycmlibGU/Ckkgc3VwcG9zZSBpZiB0aGUgdmRwYSB2ZW5kb3IgZG9l
cyBzdXBwb3J0IDAuOTUgaW4gdGhlIGRhdGFwYXRoIGFuZCByaW5nIApsYXlvdXQgbGV2ZWwgYW5k
IGlzIGxpbWl0ZWQgdG8geDg2IG9ubHksIHRoZXJlIHNob3VsZCBiZSBlYXN5IHdheSBvdXQuIEkg
CmNoZWNrZWQgd2l0aCBFbGkgYW5kIG90aGVyIE1lbGxhbm94L05WRElBIGZvbGtzIGZvciBoYXJk
d2FyZS9maXJtd2FyZSAKbGV2ZWwgMC45NSBzdXBwb3J0LCBpdCBzZWVtcyBhbGwgdGhlIGluZ3Jl
ZGllbnQgaGFkIGJlZW4gdGhlcmUgYWxyZWFkeSAKZGF0ZWQgYmFjayB0byB0aGUgRFBESyBkYXlz
LiBUaGUgb25seSBtYWpvciB0aGluZyBsaW1pdGluZyBpcyBpbiB0aGUgCnZEUEEgc29mdHdhcmUg
dGhhdCB0aGUgY3VycmVudCB2ZHBhIGNvcmUgaGFzIHRoZSBhc3N1bXB0aW9uIGFyb3VuZCAKVklS
VElPX0ZfQUNDRVNTX1BMQVRGT1JNIGZvciBhIGZldyBETUEgc2V0dXAgb3BzLCB3aGljaCBpcyB2
aXJ0aW8gMS4wIG9ubHkuCgo+Cj4+IDIuIHN1cHBvc2Ugc29tZSBmb3JtIG9mIGxlZ2FjeSBndWVz
dCBzdXBwb3J0IG5lZWRzIHRvIGJlIHRoZXJlLCBob3cgZG8gd2UKPj4gZGVhbCB3aXRoIHRoZSBi
b2d1cyBhc3N1bXB0aW9uIGJlbG93IGluIHZkcGFfZ2V0X2NvbmZpZygpIGluIHRoZSBzaG9ydCB0
ZXJtPwo+PiBJdCBsb29rcyBvbmUgb2YgdGhlIGludHVpdGl2ZSBmaXggaXMgdG8gbW92ZSB0aGUg
dmRwYV9zZXRfZmVhdHVyZXMgY2FsbCBvdXQKPj4gb2YgdmRwYV9nZXRfY29uZmlnKCkgdG8gdmRw
YV9zZXRfY29uZmlnKCkuCj4+Cj4+ICDCoMKgwqDCoMKgwqDCoCAvKgo+PiAgwqDCoMKgwqDCoMKg
wqDCoCAqIENvbmZpZyBhY2Nlc3NlcyBhcmVuJ3Qgc3VwcG9zZWQgdG8gdHJpZ2dlciBiZWZvcmUg
ZmVhdHVyZXMgYXJlCj4+IHNldC4KPj4gIMKgwqDCoMKgwqDCoMKgwqAgKiBJZiBpdCBkb2VzIGhh
cHBlbiB3ZSBhc3N1bWUgYSBsZWdhY3kgZ3Vlc3QuCj4+ICDCoMKgwqDCoMKgwqDCoMKgICovCj4+
ICDCoMKgwqDCoMKgwqDCoCBpZiAoIXZkZXYtPmZlYXR1cmVzX3ZhbGlkKQo+PiAgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZkcGFfc2V0X2ZlYXR1cmVzKHZkZXYsIDApOwo+PiAgwqDC
oMKgwqDCoMKgwqAgb3BzLT5nZXRfY29uZmlnKHZkZXYsIG9mZnNldCwgYnVmLCBsZW4pOwo+Pgo+
PiBJIGNhbiBwb3N0IGEgcGF0Y2ggdG8gZml4IDIpIGlmIHRoZXJlJ3MgY29uc2Vuc3VzIGFscmVh
ZHkgcmVhY2hlZC4KPj4KPj4gVGhhbmtzLAo+PiAtU2l3ZWkKPiBJJ20gbm90IHN1cmUgaG93IGlt
cG9ydGFudCBpdCBpcyB0byBjaGFuZ2UgdGhhdC4KPiBJbiBhbnkgY2FzZSBpdCBvbmx5IGFmZmVj
dHMgdHJhbnNpdGlvbmFsIGRldmljZXMsIHJpZ2h0Pwo+IExlZ2FjeSBvbmx5IHNob3VsZCBub3Qg
Y2FyZSAuLi4KWWVzIEknZCBsaWtlIHRvIGRpc3Rpbmd1aXNoIGxlZ2FjeSBkcml2ZXIgKHN1cHBv
c2UgaXQgaXMgMC45NSkgYWdhaW5zdCAKdGhlIG1vZGVybiBvbmUgaW4gYSB0cmFuc2l0aW9uYWwg
ZGV2aWNlIG1vZGVsIHJhdGhlciB0aGFuIGJlaW5nIGxlZ2FjeSAKb25seS4gVGhhdCB3YXkgYSB2
MC45NSBhbmQgdjEuMCBzdXBwb3J0aW5nIHZkcGEgcGFyZW50IGNhbiBzdXBwb3J0IGJvdGggCnR5
cGVzIG9mIGd1ZXN0cyB3aXRob3V0IGhhdmluZyB0byByZWNvbmZpZ3VyZS4gT3IgYXJlIHlvdSBz
dWdnZXN0aW5nIApsaW1pdCB0byBsZWdhY3kgb25seSBhdCB0aGUgdGltZSBvZiB2ZHBhIGNyZWF0
aW9uIHdvdWxkIHNpbXBsaWZ5IHRoZSAKaW1wbGVtZW50YXRpb24gYSBsb3Q/CgpUaGFua3MsCi1T
aXdlaQoKPgo+PiBPbiAzLzIvMjAyMSAyOjUzIEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4gT24g
MjAyMS8zLzIgNTo0NyDkuIvljYgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+PiBPbiBN
b24sIE1hciAwMSwgMjAyMSBhdCAxMTo1Njo1MEFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
Pj4+PiBPbiAyMDIxLzMvMSA1OjM0IOS4iuWNiCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
Pj4+Pj4gT24gV2VkLCBGZWIgMjQsIDIwMjEgYXQgMTA6MjQ6NDFBTSAtMDgwMCwgU2ktV2VpIExp
dSB3cm90ZToKPj4+Pj4+Pj4gRGV0ZWN0aW5nIGl0IGlzbid0IGVub3VnaCB0aG91Z2gsIHdlIHdp
bGwgbmVlZCBhIG5ldyBpb2N0bCB0byBub3RpZnkKPj4+Pj4+Pj4gdGhlIGtlcm5lbCB0aGF0IGl0
J3MgYSBsZWdhY3kgZ3Vlc3QuIFVnaCA6KAo+Pj4+Pj4+IFdlbGwsIGFsdGhvdWdoIEkgdGhpbmsg
YWRkaW5nIGFuIGlvY3RsIGlzIGRvYWJsZSwgbWF5IEkKPj4+Pj4+PiBrbm93IHdoYXQgdGhlIHVz
ZQo+Pj4+Pj4+IGNhc2UgdGhlcmUgd2lsbCBiZSBmb3Iga2VybmVsIHRvIGxldmVyYWdlIHN1Y2gg
aW5mbwo+Pj4+Pj4+IGRpcmVjdGx5PyBJcyB0aGVyZSBhCj4+Pj4+Pj4gY2FzZSBRRU1VIGNhbid0
IGRvIHdpdGggZGVkaWNhdGUgaW9jdGxzIGxhdGVyIGlmIHRoZXJlJ3MgaW5kZWVkCj4+Pj4+Pj4g
ZGlmZmVyZW50aWF0aW9uIChsZWdhY3kgdi5zLiBtb2Rlcm4pIG5lZWRlZD8KPj4+Pj4+IEJUVyBh
IGdvb2QgQVBJIGNvdWxkIGJlCj4+Pj4+Pgo+Pj4+Pj4gI2RlZmluZSBWSE9TVF9TRVRfRU5ESUFO
IF9JT1coVkhPU1RfVklSVElPLCA/LCBpbnQpCj4+Pj4+PiAjZGVmaW5lIFZIT1NUX0dFVF9FTkRJ
QU4gX0lPVyhWSE9TVF9WSVJUSU8sID8sIGludCkKPj4+Pj4+Cj4+Pj4+PiB3ZSBkaWQgaXQgcGVy
IHZyaW5nIGJ1dCBtYXliZSB0aGF0IHdhcyBhIG1pc3Rha2UgLi4uCj4+Pj4+IEFjdHVhbGx5LCBJ
IHdvbmRlciB3aGV0aGVyIGl0J3MgZ29vZCB0aW1lIHRvIGp1c3Qgbm90IHN1cHBvcnQKPj4+Pj4g
bGVnYWN5IGRyaXZlcgo+Pj4+PiBmb3IgdkRQQS4gQ29uc2lkZXI6Cj4+Pj4+Cj4+Pj4+IDEpIEl0
J3MgZGVmaW5pdGlvbiBpcyBuby1ub3JtYXRpdmUKPj4+Pj4gMikgQSBsb3Qgb2YgYnVkcmVuIG9m
IGNvZGVzCj4+Pj4+Cj4+Pj4+IFNvIHFlbXUgY2FuIHN0aWxsIHByZXNlbnQgdGhlIGxlZ2FjeSBk
ZXZpY2Ugc2luY2UgdGhlIGNvbmZpZwo+Pj4+PiBzcGFjZSBvciBvdGhlcgo+Pj4+PiBzdHVmZnMg
dGhhdCBpcyBwcmVzZW50ZWQgYnkgdmhvc3QtdkRQQSBpcyBub3QgZXhwZWN0ZWQgdG8gYmUKPj4+
Pj4gYWNjZXNzZWQgYnkKPj4+Pj4gZ3Vlc3QgZGlyZWN0bHkuIFFlbXUgY2FuIGRvIHRoZSBlbmRp
YW4gY29udmVyc2lvbiB3aGVuIG5lY2Vzc2FyeQo+Pj4+PiBpbiB0aGlzCj4+Pj4+IGNhc2U/Cj4+
Pj4+Cj4+Pj4+IFRoYW5rcwo+Pj4+Pgo+Pj4+IE92ZXJhbGwgSSB3b3VsZCBiZSBmaW5lIHdpdGgg
dGhpcyBhcHByb2FjaCBidXQgd2UgbmVlZCB0byBhdm9pZCBicmVha2luZwo+Pj4+IHdvcmtpbmcg
dXNlcnNwYWNlLCBxZW11IHJlbGVhc2VzIHdpdGggdmRwYSBzdXBwb3J0IGFyZSBvdXQgdGhlcmUg
YW5kCj4+Pj4gc2VlbSB0byB3b3JrIGZvciBwZW9wbGUuIEFueSBjaGFuZ2VzIG5lZWQgdG8gdGFr
ZSB0aGF0IGludG8gYWNjb3VudAo+Pj4+IGFuZCBkb2N1bWVudCBjb21wYXRpYmlsaXR5IGNvbmNl
cm5zLgo+Pj4KPj4+IEFncmVlLCBsZXQgbWUgY2hlY2suCj4+Pgo+Pj4KPj4+PiAgwqAgSSBub3Rl
IHRoYXQgYW55IGhhcmR3YXJlCj4+Pj4gaW1wbGVtZW50YXRpb24gaXMgYWxyZWFkeSBicm9rZW4g
Zm9yIGxlZ2FjeSBleGNlcHQgb24gcGxhdGZvcm1zIHdpdGgKPj4+PiBzdHJvbmcgb3JkZXJpbmcg
d2hpY2ggbWlnaHQgYmUgaGVscGZ1bCBpbiByZWR1Y2luZyB0aGUgc2NvcGUuCj4+Pgo+Pj4gWWVz
Lgo+Pj4KPj4+IFRoYW5rcwo+Pj4KPj4+Cj4+Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
