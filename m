Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B8EC433FE
	for <virtualization@archiver.kernel.org>; Sat, 22 Oct 2022 12:32:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 331A8416B1;
	Sat, 22 Oct 2022 12:32:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 331A8416B1
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ko1SM6F5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hs4AILelRg70; Sat, 22 Oct 2022 12:32:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 70623415E6;
	Sat, 22 Oct 2022 12:31:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 70623415E6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3692FC0033;
	Sat, 22 Oct 2022 12:31:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6085FC002D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Oct 2022 12:31:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 25B828319F
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Oct 2022 12:31:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 25B828319F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Ko1SM6F5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XLvfUQ9_jcCc
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Oct 2022 12:31:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49D3583180
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 49D3583180
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Oct 2022 12:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666441917; x=1697977917;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+vjIbnoMKgyGrNxPpfHtGZFxi0JvcBCo12E4Xx8x//I=;
 b=Ko1SM6F5W1US9i9bpp6k2iDj+aCWb115Ou8ceZP+F5vPTWs2TFF8yTiw
 5h+kMt2NwomH2QAguIY8IABnQDkLAKqMvZFy+PL3rCfyTtwQSXPYmbUe3
 B/u4Ux9l9fAC/YWsvrwHPzX93G0nR0RqWXVsmr5kBJGmn8oqpe5TocARr
 RwbbocpOD8Idre9vdPYhr5rGE8y8zI+OpUMQMksAmCd8qP2WGTZCQqvNS
 OYXhRbZ09YZQUwlK3EG7bGUcp84raTC4XID/HNJq9MfuGTXv+fiq4KvzT
 a3LSpt5TalS2GhtXjXv0iSExFI6W66CtdYJ2cdxiB6qCXWC2jfPV3nmFJ A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="369247112"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; d="scan'208";a="369247112"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2022 05:31:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="664059268"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; d="scan'208";a="664059268"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga001.jf.intel.com with ESMTP; 22 Oct 2022 05:31:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 05:31:55 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 05:31:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 22 Oct 2022 05:31:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 22 Oct 2022 05:31:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpwIBhG+8l5wvvgv1Pf6pgG0CxmKJqOcIpqQLTnCfnY+ipByMKBYPACdb0VblIX1QDk5aK/i8csQ3QTFYYunb4a2zcDxcHQ9to5TS2Ngm8hVNWW2gvv/w1BS8Ld+AwVSXSycBmsNf+HFZR7xoWXbCfXgUPB88wHBq0FLyZ4D1vwk9QrtE+i2J1WNgCKXwbNNeswn6otcabhv1TbjbYgx+pOUJjgQNkPT0JYSWOPi+mnK1VN15x7wtSQ0d2IpCsFAA4pI5x0s2GJ7PIlsAD2AOUAkibtwFwfiNiMWkt0ortQ3NF+gtUD4+/I2785yYPj4pxKAhbAL80KcZwEySSMK1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZkCcLUWnvx+SPCQ7kLqmoiohkutCANAFcE1thZHslY=;
 b=MUUYmZ6UJW6943XtzheMUR2cGvpNHQS6JMGB//4iuGbNofHsLrljJXsOxoMSpEQfFLB1IHeCzUDCpqzK0298E7ia+dWOXcVfAsBWCyeUf6kvWQXkEM8+SpuVIs165ACr/hhajf3XybLOo9WYQK18J+I8rurgyDCoHUBy6Mcn1R8RwQqQQqyrw8rIx7tXDev6uvyduN96CvpA2/5L1HGGFSto8I//sfIBh7RxUUly/feG8SnStc0cBhJLwWU5a6d8M8+bZ3p6KyDU3hwmNHbRiy8wz4zIADqC2ZO9WSBe0dAL/9XBmr3ZqyJh+4zd7oX0O8ZDS3bwSayYIuILrJdiwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by DM4PR11MB6263.namprd11.prod.outlook.com (2603:10b6:8:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Sat, 22 Oct
 2022 12:31:53 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::14f:c677:5f1c:bbc2]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::14f:c677:5f1c:bbc2%7]) with mapi id 15.20.5746.021; Sat, 22 Oct 2022
 12:31:53 +0000
Message-ID: <0ad83d0b-7b71-7856-333a-ec64ff5360aa@intel.com>
Date: Sat, 22 Oct 2022 20:31:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.13.1
Subject: Re: [PATCH 2/2] virtio_ring: use helper function is_power_of_2()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 <mst@redhat.com>, <jasowang@redhat.com>
References: <20221021062734.228881-1-shaoqin.huang@intel.com>
 <20221021062734.228881-3-shaoqin.huang@intel.com>
 <bc131c94-fc41-a7f5-c378-12742de677a3@linaro.org>
From: "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <bc131c94-fc41-a7f5-c378-12742de677a3@linaro.org>
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To MN2PR11MB3870.namprd11.prod.outlook.com
 (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3870:EE_|DM4PR11MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: a88ed18c-ce56-4e11-2567-08dab4296663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7pQ6eKXS5ZMeBxwzBMv9hWNINdGExzPdPDTiJQxBP4KEIaraF/dPBOaqEXzPcuMvbAsmol+3xTI+sdhSWeGOOHfeCNTYmK3x+9j/O2u/O0pUy3GAeuK93ahQ62eyJabR/KZjD9ZX20ZEC5MkIemEZcfk/D3UIvgRFLkJlBS3hFiwueC5FpYHfHDqALRIYRBlkiEYY2d0POh6q7JR6yNtv1Z6TUJwBAaBlWNtQC/IKFQWZ9981gZraITa4V4ObyOMaDb4qtleV643kq0U2zQlwi7k6a3uWN/reC4SPYXAcn3MDYUwUEs1/JRfVOehOn+kXXt5lB7ZJs5BELIVtfQG+RvwtNIpR+gSFULw4xV8iPeKat+cjDf4okDD3HC0hTSUnJdNwUfwQE5IttebIMzpXcuB4mgOWnF7UyxnbNUXSVGwW3a8rRRvF0wq8S0DAmO9FKs54dfuipK7xZdZ4thVa6B2EM29UA4NXLLmpffF8cC/BTpit2LyExjN8wZI9K3q2Il59DnKo53GM3/aOP9QcyIedY7wby526j4/W0HqSgmoXURG5/TAx0ZvRN1lVu3Bx1AvVJ0rOXgnkhITH7M1JX5tedwv7R3BDeFzWohHyjhe3tO1qpNs5yn1QQhwe5QD5chwYUlCLEDmSXAaiI7LKORiRXpwI0HzqJ2o+S3n5eXx3ipGhcxb8osg9kXmfSGSShifmq8NHdivp0YhP7V/llx2CxfR82hn3mur+e0kAhCU79juipPXaLfJToo7sCKt+w+BwRjecq0W+7bnuyfNpX7yvqIAkq/XsvtGuj0IsM4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR11MB3870.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(376002)(136003)(346002)(39850400004)(396003)(366004)(451199015)(82960400001)(478600001)(38100700002)(6506007)(4326008)(8676002)(53546011)(66946007)(66476007)(2616005)(316002)(186003)(66556008)(6512007)(6486002)(6666004)(26005)(31686004)(41300700001)(8936002)(36756003)(2906002)(86362001)(83380400001)(5660300002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkZUY0MxcVBIM0xpcTlxd25EZ3IvSlI4TzFlOGFkM0VQdE96TTYwYThkdXFW?=
 =?utf-8?B?a3FsQ0pVTkpjVE81RDNTeEFNTEdkS3dMYVp3UlgxWHhnK1ZyTENTUW8rYk9N?=
 =?utf-8?B?Mzc4Q0JiVisvbkJDNlJ4d3hwVmJQUXJ5QlhsR1k5WFBidE1mRS82bGhKQWU1?=
 =?utf-8?B?ZzQyalFZaDFGNlJUQWZTQTNHeFVjaFlLRGNNRldJOTBSeFZ4Ri9YTGtVQ0hJ?=
 =?utf-8?B?bU1heWRCQ2FlS1VpY3VvQUg4MHRsZ0hUSDBIeFNWWFpEejd5T1hSQjBuMTBp?=
 =?utf-8?B?Uk9kaW9yUXpRbm9vREtaQjZRMWE5US91d29kOWNmZFNleXhtQng2dVl3dnpZ?=
 =?utf-8?B?VzFXSWxFU3NiaGRTUHJHTnlSRlM5OWlMck5uM0NueW92VnVsOVhnZEFwWmt2?=
 =?utf-8?B?bm00SlRFWXJCaHFleFVFNFQ0TTc0MDlFeU1MdkZ6SGxZRzNDYzJnV0JFZElj?=
 =?utf-8?B?WVF3M0cyRmFUc3N2bDlCZ3QzUmJ3a3pZUVJYUmRlWUFFc00xejIxbnlyaS95?=
 =?utf-8?B?LzVHNVlvOUFValdha091UlVteWVrUVpJUUVQWDhCcmZiRXdKbEk4MDd4OHhl?=
 =?utf-8?B?UUg2aGtscm9lTDkxeGxJb2VTN05ITHNnTnlaZGJGbEU5YjRhTmFWWCt2Y1RF?=
 =?utf-8?B?L21SRjBMRkNTaFFjWjZqdUpaRVh6WWVzR1RCcThRSk42Q0FjYXh0c01lWkMy?=
 =?utf-8?B?VnhhTHA5SU9Hbm9KczNaMVRlL3JSWnFDYnNiMFdYcnlCWGNmMHJuZkMxb1F5?=
 =?utf-8?B?MGRWbFJ2a0FucHd3MEYvNVV3dnNFL2dFQlBmc1NQc1MzRlVCOVE3SWtzampn?=
 =?utf-8?B?UEJwYW12NmJIZHd4bytlNmdLM0FlVDVhL3BGZ0RUZ1J6Sk9jMExrcS9WTXlY?=
 =?utf-8?B?TnJHTDRBYTdIL0NJY1g3dENqelV4YkRRNFM1QzNxQnhyUFk4QzllSFRsTjhr?=
 =?utf-8?B?LzdyWCsrVXRwei93elZISytieEl3S0M5YmEwM1lROGVGREE0Q0dDUStpTHdB?=
 =?utf-8?B?OTZ3dGNzTnd2bHo2Rzl4R0JGeGRPbmN2Y0tWcnIzenRuQWV5eFNMSURzYXdi?=
 =?utf-8?B?ZnNwT0tLUVo2dkQ4cFpxMVhjQyt3dzNzdmRPdE9TdlI1M0p0NENabTMvSTE5?=
 =?utf-8?B?MjBjRmZ5d2hjRCtSLzhXU2JsRW4xdHFPbm1sWGVoWDhsWVpHMWJvRmlKUTV0?=
 =?utf-8?B?LzZzb1dJVHRNN3FMcWFJdXJCalh1USs1dERnUnkzdTBiRm8yOHl4MDRSbnJW?=
 =?utf-8?B?bUpGdGR0dU1tQ2h4dGdhWEY3bS92T2tBa2dqMzdqWENvSXNhVi9vNVlRT3BV?=
 =?utf-8?B?N1JFTzM1WDAzN01FenJJMTZZL01DVldpY0NEc25MYnpudk80Q1czZFRnSHVi?=
 =?utf-8?B?NnY2Uy9SQlFkV3hnNDZNY1BucWw3NEFYRDFPbVhIamc3RDU0MWJGMXMvLy9N?=
 =?utf-8?B?RS9WWFpTcnRFUDZMYzFtU1dzY3pSMG92ZndDQXloVGxlQVRnQXBtUnhhRWtZ?=
 =?utf-8?B?RlorVUFpckhvNkhvNWJwZnRlUTgzc1lPSnhWeE9xclgrdnlvdGVvRG44QklK?=
 =?utf-8?B?U05pNWFXMmZzWHE0NjY4QjZvWTA4bGlkQnkvVUNXdTFJTjVHOG9WWTRvQjRi?=
 =?utf-8?B?Qm1kSHBiVG9Yc3hHWitOZU9jaGxHS1k2Wmp6cjNTeHVHQnUxNEd4RjVaSTRh?=
 =?utf-8?B?ZUc1VklaVXJ0MnVCNGNHSGhDRDJCTkhKbzV2WXdJdTNkQTFaMHIzQTg1TkpM?=
 =?utf-8?B?TG8wRTErZnRBNlQwVWd6NERCOTQwTVBrM053dncxUEYzU0Rsbjd4aG9nb3dK?=
 =?utf-8?B?RjhmeEtOWnhmUHZJSnNid1BIYzZoWkcxeXZVY2YxNHNSTUwwSFdCOEFNU3dT?=
 =?utf-8?B?YzFiVDFsenJwZG16WjhDUmE0QnNGemc2V3RKRjFLWmJYOXNlbHNoYjhoaUxF?=
 =?utf-8?B?eTRxQXpSQ0ZQQlE2MEV0ZE9LeW5FTmlYR0l0c3lTOUJXdGt5VWtFektocXJh?=
 =?utf-8?B?Q0xlZldwYUhMdHZvUjFEbHdwMFExVGRkT1J1emo4NjFKTUNWb2t5dEFremJV?=
 =?utf-8?B?bXExVXhzdG5BWUt6dFVEVXNHSnA5QTh4QVpmRml4OVIvS0FsWFdUZDlWbHZy?=
 =?utf-8?B?VHFyTzBERG1LcC9ub1pFN3dYVWY5dHdIbzgxVUltdHYwZlBQYnFaa3NZVEN5?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a88ed18c-ce56-4e11-2567-08dab4296663
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 12:31:53.4841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4dG6uc3Q5BZWvUpr3m1e5Z1j9T1szV8wKwhRzzoPsa3Te4TRqQA3tT6hVDc/LEJi95kfCd6YH3cszlOuNgi3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6263
X-OriginatorOrg: intel.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAxMC8yMS8yMDIyIDQ6NTMgUE0sIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOgo+
IE9uIDIxLzEwLzIyIDA4OjI3LCBzaGFvcWluLmh1YW5nQGludGVsLmNvbSB3cm90ZToKPj4gRnJv
bTogU2hhb3FpbiBIdWFuZyA8c2hhb3Fpbi5odWFuZ0BpbnRlbC5jb20+Cj4+Cj4+IFVzZSBoZWxw
ZXIgZnVuY3Rpb24gaXNfcG93ZXJfb2ZfMigpIHRvIGNoZWNrIGlmIG51bSBpcyBwb3dlciBvZiB0
d28uCj4+IE1pbm9yIHJlYWRhYmlsaXR5IGltcHJvdmVtZW50Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5
OiBTaGFvcWluIEh1YW5nIDxzaGFvcWluLmh1YW5nQGludGVsLmNvbT4KPj4gLS0tCj4+IMKgIGRy
aXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAyICstCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPj4gaW5k
ZXggMmU3Njg5YmI5MzNiLi43MjNjNGUyOWUxZDMgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmMKPj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+
PiBAQCAtMTA1Miw3ICsxMDUyLDcgQEAgc3RhdGljIGludCB2cmluZ19hbGxvY19xdWV1ZV9zcGxp
dChzdHJ1Y3QgCj4+IHZyaW5nX3ZpcnRxdWV1ZV9zcGxpdCAqdnJpbmdfc3BsaXQsCj4+IMKgwqDC
oMKgwqAgZG1hX2FkZHJfdCBkbWFfYWRkcjsKPj4gwqDCoMKgwqDCoCAvKiBXZSBhc3N1bWUgbnVt
IGlzIGEgcG93ZXIgb2YgMi4gKi8KPj4gLcKgwqDCoCBpZiAobnVtICYgKG51bSAtIDEpKSB7Cj4+
ICvCoMKgwqAgaWYgKCFpc19wb3dlcl9vZl8yKG51bSkpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IGRldl93YXJuKCZ2ZGV2LT5kZXYsICJCYWQgdmlydHF1ZXVlIGxlbmd0aCAldVxuIiwgbnVtKTsK
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+PiDCoMKgwqDCoMKgIH0KPiAK
PiBUaGlzIG1ha2VzIHRoZSBmb2xsb3dpbmcgY29kZSB1bnJlYWNoYWJsZToKPiAKPiAgwqDCoMKg
wqBpZiAoIW51bSkKPiAgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9NRU07Cj4gCj4gRG8gd2Ug
d2FudCB0byBtb3ZlIGl0IGVhcmxpZXIgb3IgcmVtb3ZlIGl0Pwo+IAoKSSB0aGluayB0aGUgZm9s
bG93aW5nIGNvZGUgY2FuIHN0aWxsIGJlIGV4ZWN1dGVkIGlmIG51bSA+IDAsIGFuZCBpZiAKdGhl
cmUgaWYgbm8gZW5vdWdoIG1lbW9yeSwgdGhlIGFsbG9jYXRpb24gb2YgdGhlIHZyaW5nIHdpbGwg
ZmFpbGVkIGFuZCAKd2lsbCBkZWNyZWFzZSB0aGUgbnVtIGJ5IGRpdmlkZSAyLCB0aGlzIHdpbGwg
bWFrZXMgbnVtIGVxdWFsIHRvIDAuIEFuZCAKdGhlbiB0cmlnZ2VyIHRoZSBjaGVjayBhbmQgcmV0
dXJuIC1FTk9NRU0uCgo+IFJlZ2FyZHMsCj4gCj4gUGhpbC4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
