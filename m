Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C704E74901
	for <virtualization@archiver.kernel.org>; Mon,  2 Oct 2023 18:12:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CB2A741590;
	Mon,  2 Oct 2023 18:12:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CB2A741590
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ce24og4h
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gHA-s4Yr_Oyd; Mon,  2 Oct 2023 18:12:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 37F3740904;
	Mon,  2 Oct 2023 18:12:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 37F3740904
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E6ECC0071;
	Mon,  2 Oct 2023 18:12:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4249C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 18:12:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6066D81F79
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 18:12:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6066D81F79
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ce24og4h
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id keddrvkp7WcB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 18:12:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7C82D81F70
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 18:12:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7C82D81F70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bo9ZjW4p171Pn1odSXiJqs3EhSNaWxD9ppJ6+fNnxObDklteU23MPBU2gR57lmG3c5CBYARZp2nM82FXYpuxIecZwrqninKtschi483kn3jnA1VnJLhPyeDybPCWgA1eZFdEocASLS9cnrlFlxi5sk2OxSSo8GYoMBbNvklflRpBARypcQtJ0SosQ6i2EZIOajagFHWISinbUDEEwvueqL13AqUOghNasIWMY95KgL6buASrAyby+rTn5IJRqPYSxLb6vSFRcQK7jkuJc7eeN7+iADbBlL+Ar/YBjtRvpSODCzKaNlJmPJD3O/BGP2uWWQHbRUiGoDZwn6bmImnzrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dboc2kaAWdDgZjafVKfXS7ikUFOoB5caDxTGfAB0CRg=;
 b=FO2cxkHHIhXwqPGaZEv3+ZLof66UT8eaFzKJPAmxWRhiEl9MO0ehF+7b7Kpm/RQ1YcYpJxkFy2Poh9uB9WKLD3Fbhw6btB74g6qcDro2S1j5OxN/3ARAxMppa8X5k10RqPFwgB1KArblKbXv9JO9PMYvIMRRc5cjLltGocfu69yeCNDM7IFnxNYTpy5V1DuKSiDww29QmYUWlezsgB8StmQJOiObgHVJoffCT+7Y8/Wv1D+g8xrY+Zml4U7ZSB5ieq4dXG7AvYogU4LBQAEOhsOMkKwMVIR1xNDnUOEKkpLWdr8lu6JFoy5OF6H303eZgbdB4FCYkOpIn7HN92yvxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dboc2kaAWdDgZjafVKfXS7ikUFOoB5caDxTGfAB0CRg=;
 b=ce24og4hJBrP4UMRkdBV9++5CYBL0ORVRxioYcDBFmJ0WoPgzTyVANKIqbT8eNZ7kKvsBSKK94FDanbE2Miss4dVJQfw40cGiAa18nuEG8vOTbs5rZoEJkMVMoe/DB8Broqkz507Wxvqv3pW8DX3E/OzhWQUvfYhSqU1JTwTsvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL1PR12MB5141.namprd12.prod.outlook.com (2603:10b6:208:309::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Mon, 2 Oct
 2023 18:11:57 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d%4]) with mapi id 15.20.6838.027; Mon, 2 Oct 2023
 18:11:57 +0000
Message-ID: <0be2dfa4-b6c1-f62a-66e1-615da7aa3c76@amd.com>
Date: Mon, 2 Oct 2023 20:11:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/9] drm: Annotate structs with __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20230922173110.work.084-kees@kernel.org>
 <169601600138.3014939.8511343741428844249.b4-ty@chromium.org>
 <83cd056c-52ae-01dd-7576-42d41da64c26@gmail.com>
 <CADnq5_Ma2CrLYggJHKFEObsNmUoqJwb2p1xai5DfL=m43U6zEA@mail.gmail.com>
 <202310020952.E7DE0948C0@keescook>
 <10644b5f-b0a7-85ef-0658-2353ee14df0d@gmail.com>
 <202310021107.9BB46FB8E@keescook>
In-Reply-To: <202310021107.9BB46FB8E@keescook>
X-ClientProxiedBy: FR3P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BL1PR12MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: f72f9241-70ee-45cd-0f82-08dbc37310a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NyIMkowZqJLx2lUCb5LFN2+2JcZEpqP8vpo/LFAYCGF8owQlNHezvm8tqMbLJBbD2CYXDVESU9AK1iMLReITkiPhwWVamefxgM7evNCbRHXj2uf3Noa6fXqu0eIgXM+hiKxJ57b/5uOlFFk0DjKSn9fiojzoGORzt6wXqqQDMu80K6ild4kCSVP0gQlxSzUZyVFSfictrhm7J2EIaOBq40y9IRDK2Pw0d73sEsvmF0pz/CAqF5CXw+4Ef1DooEceBEKfBK68Eu/D2NjpIf7ZTofyx54UKBzYixGHggnS5g1pI4IitgF4GTuqEdU/+weTTPyXNlWH25Gmf/q1fGD1R133O878jpd0HlzI3r6bZi0nKBcWd9SPwpE7J14gI6aBQTxgXdoGw5vm7EaGFslVokJwBRg7wPEHdEeV4vkw+PJo261d5dvtJ64tVtjSAtoDG+4oHKjLEgavg6BgqIxtcIsVnmob55cEoqzGp3p3ZOqKCenf2/pXhPk9+DsorzynKXB65w/mgi2coR6rEDNhaklCGycKVdSuPB+BQfJNZay188PaiIRnw66oNa3a1EzgXq6Ngyg8AjQl9IzJ7b4fMcBPwhhabkVh5EdOsBWPt+YY4pLzOdWjJKejNdZ2V8GDzSJgp1wpbm2XygaGRrh7UA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(2616005)(26005)(66574015)(36756003)(83380400001)(6512007)(6506007)(6486002)(966005)(478600001)(6666004)(53546011)(31686004)(38100700002)(316002)(110136005)(66476007)(66946007)(41300700001)(66556008)(54906003)(8676002)(8936002)(4326008)(5660300002)(7416002)(7406005)(31696002)(86362001)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2tEOW02aGdqQ3FNTzJKZk5CemRkdnZna0c5T0lMMlk1VnAzNmZCZS9GcUNu?=
 =?utf-8?B?M2VjL2VtZ3A2MFdsZUhHV3JFZVAyYVNmM3h1QzFmd2lsc2plZmI1bWNDakNp?=
 =?utf-8?B?dFAyc2tFWkgwdW93TnJSaFZkeG0vemRWYVJ1QXYrNS9QSURmM0o3bzdwY2lX?=
 =?utf-8?B?bTU4ZlM2bzkzQktWa2IrdmdrdHlGaWNJZ1NZeFcrbG9NUzhDVCs2QVZuRFVm?=
 =?utf-8?B?ZDRDamJvdnZBY1VaSEpkVXRFblNCN1RhUk9kUFE3L05rckdyZlVFbWV1bUt4?=
 =?utf-8?B?V1ZDSitaUVVpN3c1V3A3TmJ6UWpTMFdId3V0ZHcvTHE0WVVLOWZuNy9CWUIr?=
 =?utf-8?B?c0tsdVVqcUsrNXdvWitobi9nTkNsNHZ4YWtscjZkRlFaOHErQkNkNkxUTzlZ?=
 =?utf-8?B?NmREZjFxeVdVd1RuZXB6MjFGTktQbXN6aS90aXBzZkFSMFEvRytFenBsQzJj?=
 =?utf-8?B?MUZ3c0xFQXJvOHI4clZUVmpHV3hQaVBYV0VvRFJyZUM1WUY0ZU95WUJSZmFR?=
 =?utf-8?B?REpHdDlXVU5aZzQ2SkhDWjFCNHVjZ0VrZEdpdFFhS2liZndlQm11VVhRTXl6?=
 =?utf-8?B?L2hhT3cybmNTRGs3WTJ0enVHNWx6TlpQMXhSL2RrbmpDeVF5TjU4Z1I0VHBB?=
 =?utf-8?B?Q2htalpNZVVYbkJwaDdEbGYwTEd0UXlPZTN5NFFlRjQ1L1paSlFjak54YU1h?=
 =?utf-8?B?NCtaVExHYWs3RHFjSWJsVXFoNklzcE54blZwT3diNXY3U2xkd1FMTklnSElN?=
 =?utf-8?B?dGw4YkhYWlFDaTZmWXhibGFCNXZNTDdDZCthVU5zaUFRTEJGbk5sQnAxY09P?=
 =?utf-8?B?S3UybUR1cS9rT0RrbGVvb2w3eEFFa2ovaUIwcnpBWENUOFNXT0dZY2dYRW5o?=
 =?utf-8?B?UTF4bUJmbTF2dzlvMnB1Um5NOG9pRWs0K2dRSGJ0cW1HRmxqTUZKYWdGcE1G?=
 =?utf-8?B?dDQzeTI4enVJcjl5c2wwR0pRcDRqek5iY0RscitaOG9MSExFMVhBRGI0bEs2?=
 =?utf-8?B?RHJpN3F0RzFyRmM1SXhmOHlSWE5NY25jVk85elUzV205d2NUeGhQdE85b29P?=
 =?utf-8?B?cDd4UnlYY1g3aU15K0dTWmJUNlR4NnQrak0xelFkM0F4MjdQYjlWUlpwOWlC?=
 =?utf-8?B?Y2NCemdVZzEzRVRHUi9BUGNHcmoySVRYT1JrU2MwWVVpUk9CWEhtRHVsdlA3?=
 =?utf-8?B?UkZGdndpV3NnT0JXbWI2SDBmeG80emdESWpZdDY2dDRTNThQVll1d2FxTUtC?=
 =?utf-8?B?aytSSEpVL2lYeE0yeGxlZzRJcGFBb3ViZlJ6NTdoTkxPNlVURkNWamN6S3cz?=
 =?utf-8?B?RXJsVGNtYk1MNW45c0NWc3JBcHdPNjdBQWRaZWU3ZHZwYXVveWIxQ2FCdjRj?=
 =?utf-8?B?aHlibVNGZlpoNkt0VHhwUG8vY2ZrbFlpSW00bE5lbmR5T0pTSnZQaEdLNmVF?=
 =?utf-8?B?WHRSN0Z4ZVVzYkowTHF1RDV2YlRJUWlCVi9BNkliZ1BzTXJiOW5nQU42TzJM?=
 =?utf-8?B?ZU5kTXVGR3hUK3NSLzdxRmxvU0Z1VUdFdk1EcWwwQWlRL05yWFd0Wnp1eWwr?=
 =?utf-8?B?bkhqejFLeE9mNHM1bmNheGhCeHZ4aUxESlRoSVNObm41Y01nNm1QMG9NQzk3?=
 =?utf-8?B?T0N5SUtpZllScGJ4NlVqMUkwUWVJTHYyWnpGS0ZCVXpEdHNudG5pRmd2Q0Fs?=
 =?utf-8?B?R203RXRSVU9LYTY4dWhZUXdKTEEwMUhKUWJQVWZ6czc0QW56SkovdUdrL0Np?=
 =?utf-8?B?djBGWGh1SDhnb3JsaFhTTERFaGVuckg5d1V5bHg0SjFyNFFSOXh1Q05LeDhm?=
 =?utf-8?B?L2NqSkxyVVJpdzFvd2Zzc2tlTzdkZ1JBNFYzbE53ZTJPZkxGeVFKMWtaOExx?=
 =?utf-8?B?RlRJSHRxelBoZzBTSGRMendycGsrRTJVTFdldks0VHI1NmZTWCtyc2J1L2E3?=
 =?utf-8?B?ejFBUlZJaDByRjdZaXc2czJjd3pNZGJDeDBnVThKdkxXMldEMitabGxVaGRK?=
 =?utf-8?B?WlJuTTdoa0RvTkJLenRuV2hBTlA3aHZ6Q1ZENVFCNG5kbXFqTnRVZlp5RVNN?=
 =?utf-8?B?QVZyeFZ2MzhpNGF0K0tPdUVqa2FRZnVIZ3lXcnl4WDdCdi9QZmdWcXEySGI4?=
 =?utf-8?Q?6tdA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72f9241-70ee-45cd-0f82-08dbc37310a7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 18:11:57.3035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwJHfZXZXoIs9c88dAz50jEfSrfhNl+TrieykBw8uPuZ38pOysWtjZRh7aaOb+oF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5141
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>, Emma Anholt <emma@anholt.net>,
 Tom Rix <trix@redhat.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 llvm@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Chris Wilson <chris@chris-wilson.co.uk>, Prike Liang <Prike.Liang@amd.com>,
 Huang Rui <ray.huang@amd.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 Karol Herbst <kherbst@redhat.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 amd-gfx@lists.freedesktop.org, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 nouveau@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
 virtualization@lists.linux-foundation.org, Chia-I Wu <olvaffe@gmail.com>,
 linux-hardening@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, Kevin Wang <kevin1.wang@amd.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Maxime Ripard <mripard@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Evan Quan <evan.quan@amd.com>, Sean Paul <sean@poorly.run>,
 Yifan Zhang <yifan1.zhang@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>,
 Le Ma <le.ma@amd.com>, freedreno@lists.freedesktop.org,
 Bjorn Andersson <andersson@kernel.org>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Rob Clark <robdclark@gmail.com>, Melissa Wen <mwen@igalia.com>,
 Zack Rusin <zackr@vmware.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexdeucher@gmail.com>, Nirmoy Das <nirmoy.das@intel.com>,
 Lang Yu <Lang.Yu@amd.com>, John Harrison <john.c.harrison@intel.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

QW0gMDIuMTAuMjMgdW0gMjA6MDggc2NocmllYiBLZWVzIENvb2s6Cj4gT24gTW9uLCBPY3QgMDIs
IDIwMjMgYXQgMDg6MDE6NTdQTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0g
MDIuMTAuMjMgdW0gMTg6NTMgc2NocmllYiBLZWVzIENvb2s6Cj4+PiBPbiBNb24sIE9jdCAwMiwg
MjAyMyBhdCAxMTowNjoxOUFNIC0wNDAwLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4+Pj4gT24gTW9u
LCBPY3QgMiwgMjAyMyBhdCA1OjIw4oCvQU0gQ2hyaXN0aWFuIEvDtm5pZwo+Pj4+IDxja29lbmln
LmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4+Pj4+IEFtIDI5LjA5LjIzIHVtIDIx
OjMzIHNjaHJpZWIgS2VlcyBDb29rOgo+Pj4+Pj4gT24gRnJpLCAyMiBTZXAgMjAyMyAxMDozMjow
NSAtMDcwMCwgS2VlcyBDb29rIHdyb3RlOgo+Pj4+Pj4+IFRoaXMgaXMgYSBiYXRjaCBvZiBwYXRj
aGVzIHRvdWNoaW5nIGRybSBmb3IgcHJlcGFyaW5nIGZvciB0aGUgY29taW5nCj4+Pj4+Pj4gaW1w
bGVtZW50YXRpb24gYnkgR0NDIGFuZCBDbGFuZyBvZiB0aGUgX19jb3VudGVkX2J5IGF0dHJpYnV0
ZS4gRmxleGlibGUKPj4+Pj4+PiBhcnJheSBtZW1iZXJzIGFubm90YXRlZCB3aXRoIF9fY291bnRl
ZF9ieSBjYW4gaGF2ZSB0aGVpciBhY2Nlc3Nlcwo+Pj4+Pj4+IGJvdW5kcy1jaGVja2VkIGF0IHJ1
bi10aW1lIGNoZWNraW5nIHZpYSBDT05GSUdfVUJTQU5fQk9VTkRTIChmb3IgYXJyYXkKPj4+Pj4+
PiBpbmRleGluZykgYW5kIENPTkZJR19GT1JUSUZZX1NPVVJDRSAoZm9yIHN0cmNweS9tZW1jcHkt
ZmFtaWx5IGZ1bmN0aW9ucykuCj4+Pj4+Pj4KPj4+Pj4+PiBBcyBmb3VuZCB3aXRoIENvY2NpbmVs
bGVbMV0sIGFkZCBfX2NvdW50ZWRfYnkgdG8gc3RydWN0cyB0aGF0IHdvdWxkCj4+Pj4+Pj4gYmVu
ZWZpdCBmcm9tIHRoZSBhbm5vdGF0aW9uLgo+Pj4+Pj4+Cj4+Pj4+Pj4gWy4uLl0KPj4+Pj4+IFNp
bmNlIHRoaXMgZ290IEFja3MsIEkgZmlndXJlIEkgc2hvdWxkIGNhcnJ5IGl0IGluIG15IHRyZWUu
IExldCBtZSBrbm93Cj4+Pj4+PiBpZiB0aGlzIHNob3VsZCBnbyB2aWEgZHJtIGluc3RlYWQuCj4+
Pj4+Pgo+Pj4+Pj4gQXBwbGllZCB0byBmb3ItbmV4dC9oYXJkZW5pbmcsIHRoYW5rcyEKPj4+Pj4+
Cj4+Pj4+PiBbMS85XSBkcm0vYW1kL3BtOiBBbm5vdGF0ZSBzdHJ1Y3Qgc211MTBfdm9sdGFnZV9k
ZXBlbmRlbmN5X3RhYmxlIHdpdGggX19jb3VudGVkX2J5Cj4+Pj4+PiAgICAgICAgICBodHRwczov
L2dpdC5rZXJuZWwub3JnL2tlZXMvYy9hNjA0NmFjNjU5ZDYKPj4+Pj4gU1RPUCEgSW4gYSBmb2xs
b3cgdXAgZGlzY3Vzc2lvbiBBbGV4IGFuZCBJIGZpZ3VyZWQgb3V0IHRoYXQgdGhpcyB3b24ndCB3
b3JrLgo+Pj4gSSdtIHNvIGNvbmZ1c2VkOyBmcm9tIHRoZSBkaXNjdXNzaW9uIEkgc2F3IHRoYXQg
QWxleCBzYWlkIGJvdGggaW5zdGFuY2VzCj4+PiB3ZXJlIGZhbHNlIHBvc2l0aXZlcz8KPj4+Cj4+
Pj4+IFRoZSB2YWx1ZSBpbiB0aGUgc3RydWN0dXJlIGlzIGJ5dGUgc3dhcHBlZCBiYXNlZCBvbiBz
b21lIGZpcm13YXJlCj4+Pj4+IGVuZGlhbm5lc3Mgd2hpY2ggbm90IG5lY2Vzc2FyeSBtYXRjaGVz
IHRoZSBDUFUgZW5kaWFubmVzcy4KPj4+PiBTTVUxMCBpcyBBUFUgb25seSBzbyB0aGUgZW5kaWFu
ZXNzIG9mIHRoZSBTTVUgZmlybXdhcmUgYW5kIHRoZSBDUFUKPj4+PiB3aWxsIGFsd2F5cyBtYXRj
aC4KPj4+IFdoaWNoIEkgdGhpbmsgaXMgd2hhdCBpcyBiZWluZyBzYWlkIGhlcmU/Cj4+Pgo+Pj4+
PiBQbGVhc2UgcmV2ZXJ0IHRoYXQgb25lIGZyb20gZ29pbmcgdXBzdHJlYW0gaWYgaXQncyBhbHJl
YWR5IG9uIGl0J3Mgd2F5Lgo+Pj4+Pgo+Pj4+PiBBbmQgYmVjYXVzZSBvZiB0aG9zZSByZWFzb25z
IEkgc3Ryb25nbHkgdGhpbmsgdGhhdCBwYXRjaGVzIGxpa2UgdGhpcwo+Pj4+PiBzaG91bGQgZ28g
dGhyb3VnaCB0aGUgRFJNIHRyZWUgOikKPj4+IFN1cmUsIHRoYXQncyBmaW5lIC0tIHBsZWFzZSBs
ZXQgbWUga25vdy4gSXQgd2FzIG90aGVycyBBY2tlZC9ldGMuIFdobwo+Pj4gc2hvdWxkIGNhcnJ5
IHRoZXNlIHBhdGNoZXM/Cj4+IFByb2JhYmx5IGJlc3QgaWYgdGhlIHJlbGV2YW50IG1haW50YWlu
ZXIgcGljayB0aGVtIHVwIGluZGl2aWR1YWxseS4KPj4KPj4gU29tZSBvZiB0aG9zZSBzdHJ1Y3R1
cmVzIGFyZSBmaWxsZWQgaW4gYnkgZmlybXdhcmUvaGFyZHdhcmUgYW5kIG9ubHkgdGhlCj4+IG1h
aW50YWluZXJzIGNhbiBqdWRnZSBpZiB0aGF0IHZhbHVlIGFjdHVhbGx5IG1hdGNoZXMgd2hhdCB0
aGUgY29tcGlsZXIKPj4gbmVlZHMuCj4+Cj4+IFdlIGhhdmUgY2FzZXMgd2hlcmUgaW5kaXZpZHVh
bCBiaXRzIGFyZSB1c2VkIGFzIGZsYWdzIG9yIHdoZW4gdGhlIHNpemUgaXMKPj4gYnl0ZSBzd2Fw
cGVkIGV0Yy4uLgo+Pgo+PiBFdmVuIEFsZXggYW5kIEkgZGlkbid0IGltbWVkaWF0ZWx5IHNheSBo
b3cgYW5kIHdoZXJlIHRoYXQgZmllbGQgaXMgYWN0dWFsbHkKPj4gdXNlZCBhbmQgaGFkIHRvIGRp
ZyB0aGF0IHVwLiBUaGF0J3Mgd2hlcmUgdGhlIGNvbmZ1c2lvbiBjYW1lIGZyb20uCj4gT2theSwg
SSd2ZSBkcm9wcGVkIHRoZW0gYWxsIGZyb20gbXkgdHJlZS4gU2V2ZXJhbCBoYWQgQWNrcy9SZXZp
ZXdzLCBzbwo+IGhvcGVmdWxseSB0aG9zZSBjYW4gZ2V0IHBpY2tlZCB1cCBmb3IgdGhlIERSTSB0
cmVlPwoKSSB3aWxsIHBpY2sgdGhvc2UgdXAgdG8gZ28gdGhyb3VnaCBkcm0tbWlzYy1uZXh0LgoK
R29pbmcgdG8gcGluZyBtYWludGFpbmVycyBvbmNlIG1vcmUgd2hlbiBJJ20gbm90IHN1cmUgaWYg
c3R1ZmYgaXMgCmNvcnJlY3Qgb3Igbm90LgoKQ2hyaXN0aWFuLgoKPgo+IFRoYW5rcyEKPgo+IC1L
ZWVzCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
