Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F057C433F5
	for <virtualization@archiver.kernel.org>; Wed, 24 Nov 2021 23:47:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B540D40163;
	Wed, 24 Nov 2021 23:47:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4ZxUtPYpHqcU; Wed, 24 Nov 2021 23:47:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2AD62400BA;
	Wed, 24 Nov 2021 23:47:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02E83C002F;
	Wed, 24 Nov 2021 23:47:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CFDCC000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4CAB140163
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:47:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F_rzCI9x5ovj
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:47:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C076400BA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:47:17 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AONP9qx012791; 
 Wed, 24 Nov 2021 23:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=eeTZn9TdM9UlUSIi9vTCjnMvSH2Xz/gvSmb3P5XHIdo=;
 b=M8REV098KxU552+QZUeGw/2IkB3/pqotLE7qkQkQlBc89Mau0Q4ePXXzIEC3EfPLYxUD
 MFzH4H+hhphcIMdXrScjyqw5pkWg/qswVhiOBVRp7bvgJsI/Y0eX1vi0AFhwgKORXZBm
 hX1qpN0G8JhWKZeavivTgM7TgyD/5wbmVdKhV9IRT5QbZlE6volA30G8KYoeIanjP1WO
 BqNSKOoq6aaUcYeoBe2zuWKdl9WnWFjJgtR5Mxg/X3fYXogQr2MqtbQogMy9TKXppaXy
 vSvI4jxhJH1Sl+4P0jJ8QQdI2A0MGoZ2lqdifi7P72j/xK5FKTBWkzKIACoAxaVgx7DR 8A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3chj7g4aj6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Nov 2021 23:47:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AONb5QK169771;
 Wed, 24 Nov 2021 23:47:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
 by aserp3030.oracle.com with ESMTP id 3ceq2gu41m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Nov 2021 23:47:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+7/SAaZ0Wxxh5lS/1olW0RlIPc9ifKdpHJegaDS6sD5lBG1CD4Rtyo4pnLw/4X5MSbF6UUVIfJ+MAJMxbhcHM95GtPD637hYXfnJgWC0OVukNhwWFaQ/V9Vw4Kd2trgXdqVXsENEX8dfOqnrqnH+cMoFFWuV84ZvPNhv8UG+C7obCpxKongRLn50L7YbRVqDc9sPWx2DXpXoYCZj6hnXPG3bO2nWLLCEuB5TUOcpA6V36MmxzeVfbEpk8UG6dm8CnRGR6Ybp2Rtn1FZ1mcPQ9qFdj9YXtxTXUVHT9eSRMyTO05/eRsdSPyq+KNo3cMO1pffHqQyCYKRIJjx/uttRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeTZn9TdM9UlUSIi9vTCjnMvSH2Xz/gvSmb3P5XHIdo=;
 b=iwB+kdVIOxuHMrII3iH9Fs0E5zeUvgd7e1whE/X4RiqZJITh+ZVahlIcOmt91yJahh60TgqNfa1bmGm8ZKq1M+1u91mpui94JyuisT1gBbwb7DzmpXni7QPCivukM9f3RnuWJrrKdWFp8ccUazD+xquhtOCqF0pzRbheAfIuK+YxrID9saHyRzuc6zVEKJZiOxa/zHo2TwmGkYAyCv0QWKurwjFO2xyXhG5cPvwre6YbFuyhexUCp0n1CqYScqhhI6w5rZFhMpGekRQIqRGhK5fmYlBAaTIT87FsYjicCGFyP5IkEbCKOtsHaA9L4GAgPOnYPAGMNZIOutFHkbMQag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeTZn9TdM9UlUSIi9vTCjnMvSH2Xz/gvSmb3P5XHIdo=;
 b=tnfXc4SYMn20eC0s6m8wHcPnLx6SDPAohkOhgpixpUP28iSSer4WSXscdAjk6j9QYs6TSOqpR3nWwxbtzSeGn/qPHX2Y6EK3PLHxxeUxnEG8+KZW4k7bSGRKZryFT3So9nWAOOOzjocnTbaZz2fhkGfOS0EuOVqtd0kIhBO9jNQ=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BY5PR10MB3889.namprd10.prod.outlook.com (2603:10b6:a03:1b1::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Wed, 24 Nov
 2021 23:47:13 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::89e7:42b2:b226:2182]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::89e7:42b2:b226:2182%7]) with mapi id 15.20.4713.025; Wed, 24 Nov 2021
 23:47:13 +0000
Message-ID: <977661e6-e81b-a0e6-a28e-43364410442f@oracle.com>
Date: Wed, 24 Nov 2021 15:47:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] net/mlx5_vdpa: Offer VIRTIO_NET_F_MTU when setting MTU
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211124170949.51725-1-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211124170949.51725-1-elic@nvidia.com>
X-ClientProxiedBy: SN4PR0201CA0057.namprd02.prod.outlook.com
 (2603:10b6:803:20::19) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
Received: from [10.159.239.30] (138.3.200.30) by
 SN4PR0201CA0057.namprd02.prod.outlook.com (2603:10b6:803:20::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19 via Frontend
 Transport; Wed, 24 Nov 2021 23:47:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a22e38af-e96e-4889-15c1-08d9afa4bce3
X-MS-TrafficTypeDiagnostic: BY5PR10MB3889:
X-Microsoft-Antispam-PRVS: <BY5PR10MB388984ACCB00777A90537537B1619@BY5PR10MB3889.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQOr2H+rqMhwytoJjVn4N5pxS+9enJjM4af/7QcJBhvcyxdkHfhVjVGpLlmRfd3WTIgv6bB8jSrE3gSna3YfEFlwKBnzsQ+XOzX/FGgNA1RzR7gfhtxjeFFJYQwZuDitkMonVCQPM8XDea17pBnqAP4OU+jpvOWAFfLCsNaLINHUkB4Hmlqmgg39CpbEgLIQbDcpQsWMaEEoykZjobfuN7snyAqxeN2WE4hm0LGy0XxAJdaGFfOmZ3iTV83FSWLoHizvyvpqG8NJyjy6oLEJqUlWa1Gw0m7nJojfR5GcZKqEE36ujOUcxc2iJXSsC7g7dfJG3mzS5aS31ZdDxoIS9qURhY6eak7JARGc9e1JufeBGlVkCZVSwbDm3wFYsJpOqb2fsPZBBvmzKWX2Ur+XF8SuRH8ZhbNoRq1DWLH0QN2/XTBLaQPYJXc/8wtA5aQ5TDiuUeRY9vf4/R4hAklDt6U2GViRj+BTlIDHzIu6McKcQhPZln+DVkQ5frPfX8hjOnw+abdc2VwPq1DgVwghXE/ODyuVmpfcpJceMLCUZenA5bG9yvC3vZRFcoS0OVRxgB0h08PetQb0lBbqMzkn3MYm/057MaY3KCKiIjwIezWqE2ScMoeviWh4Lm05Y8GHCiBmW2w7tuIWY/+IFN63kQaI1Xz5YDZckfRR4nZBr6HpFeZHTgA6g8+SBYjeN08h5rWP/2CtmwQjAF4NPRXDamMuEqro+53v/931lmDpmx0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(8676002)(956004)(2616005)(2906002)(5660300002)(31696002)(36916002)(6486002)(186003)(31686004)(66946007)(53546011)(508600001)(8936002)(16576012)(66476007)(4326008)(36756003)(86362001)(66556008)(26005)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXU2QlpVOGxRWGsrY3ZCb29LeFdJUUk2ckpRVnFoT0lDZDZhOE90V2Uybk9i?=
 =?utf-8?B?cndxcTVRR3lJUCtSQ3gzMFBtNGllOFBuVUxGM2h6RDhmZWhIQVBpNkZGVEts?=
 =?utf-8?B?OENWbnRIOTNBTDU2UUd5Y0dYVTBJcHQ1RnpsWHlCVlV0MVR3Ump5dUlvYXRM?=
 =?utf-8?B?SlBHZ1RqV0NXQnF0VWJRUW1DTi9Zc04vYmJBZ3ZZZUV0WnB5OWovWmMxbEY5?=
 =?utf-8?B?ZkxneGg0dGlyek9yK2NZQk51UEtHUWpmQWdTVFAzZER3SjZvdlJkNDRUcnN5?=
 =?utf-8?B?UUZxTFo1SEJCV0tUS3V6WjdzYTNKVTNNZmZRbE5PbHhQbzRiaFVGVnA1QUdr?=
 =?utf-8?B?Q3RDWitXV1VDanZHMS9nWG9PKzNLMk45aFB3WUdtaERZOExpRzNpbE5MUWtO?=
 =?utf-8?B?cE9aOHNzdXk5NUdmU2VtSnFTU3lVS2QzM1lRdkhpV0RncEJoNFJvdTNhQ21i?=
 =?utf-8?B?anE0MTVvZ1NMejBaYU81MGh6T1h1S2p4Tld4TElOOGJSeHVtOFlxT1BRYU02?=
 =?utf-8?B?TERqWjdaRXNHbXp5RTdkMkxxMm5kZ3JCcGxKS0U0ODlaMFdJc3plQTQ2Uloz?=
 =?utf-8?B?VXV1dXphdUt0OTlpVEZCTFE4cXFxN2U1eDhjbUxPekRiVGtJQ0loYVFYVjVt?=
 =?utf-8?B?Sm8xV3V3R2xqL3NmYzVtRkZwZ2FZR1R0N0UvZTRrREVQbEFpaVFuQ1JxN3BI?=
 =?utf-8?B?MGN3ZmtoT3l2UEsySUtFUkdsaGZyUG9wZmpNZ1pEemFtZDlFOVNzZzFERDRS?=
 =?utf-8?B?Vi8walFyd2tyUjBwbTN0UkEzcnJEVEpHRHBtcTlWSUJ1VUdYWVJ4cjhuUWtG?=
 =?utf-8?B?ekp5WHNURUZIRU90d3VQWEcyYjI2dmNHQ1FXcHRzVGorTDZ6QlI1MjlKVG9Y?=
 =?utf-8?B?dk1qdHJhaHpsemo0MXJXSHgrak5zdkdWaXZsRGRVdXZaYnRERXA1NkFSbkRU?=
 =?utf-8?B?UmsrUjhpaDhWWHRaNDBnL0FHQUZMSzRjYi9EbHpBaG1wVWg1N1B1SmY2OHdj?=
 =?utf-8?B?QXBPcjRERllKR3EyYkNHbmFjMEYvVVFXNy9lRFhVZHhOSDIzWFdSYmd0bW9u?=
 =?utf-8?B?SVlQekpSeGxNVEJzUndoT3htLzJLMnNQVHFPdGFPQnJUTFdHMFJpZEN2Vzds?=
 =?utf-8?B?cGZIWVBZZjJEdHJIcnZZOHcxdVphNFEvT0NEUHJVUm5XUm5PK3hUQjlpaWc1?=
 =?utf-8?B?SURLalJnN3J6REF6bGVqTy91Y0M0SkhRQ3U5MVRiZEp2ZngvWFFoZzcvdExh?=
 =?utf-8?B?cXBucSsvK0l6YkR2cE01UHVSZHI5OVNsMHdFdkZHTEMzaWZXeWtnTHdzQzhO?=
 =?utf-8?B?OGZ5L0lNem1uQTlQYTh6ZDJoUStSOXd1cG5kQXNwSDg1SlRjZjV4akRQWDNv?=
 =?utf-8?B?N1kyUGlnMzFSWk56a0tNcEh0aG5kaWtaUE9CQkdDYTNhQ3BhN2Q4bEZDRjJk?=
 =?utf-8?B?a2hibjdUQUp5Z2NRWnUrbURxbC9EQnZhNDBYaWhaUmxxS200eGl4S0xQK0p5?=
 =?utf-8?B?dWxwZXpINkc0cTg4V3NzTjRQbzB6TzBMaE92aXFPUnZDYUhoaXhkTVBmVGcv?=
 =?utf-8?B?NlViTklDc0VGOW9aTGtmeW5Cb01BU1loU3hrV2EvbCt3MkFCNDF3OXVQeE1F?=
 =?utf-8?B?QURlNDFvSnZhaDB2czBwSGdWVnVHQjlzRmM4Y3pPUlF2SERCdDNlMEZNUVQx?=
 =?utf-8?B?dXJmUmV3YXpHanJBaUdnWjZ1UzMwK2E4aHpORVhYNmFEbk5YZzRQV2NpM1o5?=
 =?utf-8?B?WWpaQm5aSXlOaFM3TzUxaWZ3TkxsZzV5ejNGb2lhZEJYcjNqOHpaaTNrWjZl?=
 =?utf-8?B?TkxBR2VsMUJlQnVjZ0pKT2NCWHVDWXpYUVRvUGVsZzR5N3lNSG1PNkdBbUYr?=
 =?utf-8?B?VnFRUk9pTitscTBaeHlvWE44WktUQWRkVEcrRWRTaFlCWlpZYjBERU9BTmk5?=
 =?utf-8?B?amlZQnQwVStBenMvODN5S1JyRUlsYkE3L3FvWFVCZlhaZHd6SWUrRG5ab0t0?=
 =?utf-8?B?RUg3QXBUdC9aVnRwOGZjOWNHRFlzMEZWeXJ5bGthVzU2VmlRUWo4RUtheFI4?=
 =?utf-8?B?Qjl6bTAyMndFTkhMU2ZxL2lSRkJyWkg2N2IzdmJKcjVrU1pQU0FKUExCbFlD?=
 =?utf-8?B?c2JqT05zL2dUdEd5U2ovUmx1RVZjQnpJaGhJZjYyS091YlowNUhlWVZPelNL?=
 =?utf-8?Q?lz6b4F+WExmTXaFhqyXS3Lg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a22e38af-e96e-4889-15c1-08d9afa4bce3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 23:47:13.0870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSqgVNuOzjWlX+feANsaveFbhIMSFPygIu55vtDDh+NY8cLglC/g58FY3MtJZ9Z8M3uhoHbbHk+mHjdE1z6DNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3889
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10178
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240115
X-Proofpoint-ORIG-GUID: tcXZX29RBl3-DWo8D84T7mn1PY4FiTUm
X-Proofpoint-GUID: tcXZX29RBl3-DWo8D84T7mn1PY4FiTUm
Cc: lvivier@redhat.com, eperezma@redhat.com
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



On 11/24/2021 9:09 AM, Eli Cohen wrote:
> Make sure to offer VIRTIO_NET_F_MTU since we configure the MTU based on
> what was queried from the device.
>
> This allows the virtio driver to allocate large enough buffers based on
> the reported MTU.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 465e832f2ad1..ed7a63e48335 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1956,6 +1956,7 @@ static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
>   	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR);
>   	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MQ);
>   	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_STATUS);
> +	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MTU);
>   
>   	print_features(mvdev, ndev->mvdev.mlx_features, false);
>   	return ndev->mvdev.mlx_features;

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
