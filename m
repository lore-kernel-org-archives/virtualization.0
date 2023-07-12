Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D545DEB64D9
	for <virtualization@archiver.kernel.org>; Wed, 12 Jul 2023 13:54:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A6B6417D3;
	Wed, 12 Jul 2023 13:54:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A6B6417D3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VsTwGxlo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RsPEDzv_ttNy; Wed, 12 Jul 2023 13:54:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E79FC4174A;
	Wed, 12 Jul 2023 13:54:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E79FC4174A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB731C0071;
	Wed, 12 Jul 2023 13:54:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18112C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 13:54:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 96BC3821D7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 13:54:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 96BC3821D7
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=VsTwGxlo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id quZBJom_AHr8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 13:54:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 176638219F
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::600])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 176638219F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 13:54:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lg/wJHH/ZFJfBXf0dR+HzSa8gUzcCNvgEVvSP267D7MPQK3c5Exm7efzcpBuo/uHQ9WOvoGqGIVxG40Rc82ll6k2VkBtY1yuAaYceR/K//D14Gm0caoArWB3nfjKis14Vskkl0gSEIzUbyz8mqAk0gEsHi+duohyuMOg2sGtjJab7KWtg4+aigLjIevXMT9EMyH4/8k/rcdxC8VEE1KEbQateFBjVetDl1pvJneGzw3czwTtBQciw04ZgfocQhHIfF9cClYcvKS59o75Obf7g7CcFeutjC4KZIDbPZC2MrPgdhHt9VK7C82QtwlM63cm1vipNSn0EqwbJk05JoZkOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgHMqA6NR6xwi31+5UQb02kpONt6s3GFuikZRULOVgI=;
 b=XcpEFbGo4dujwilE05EBLxUAB4zsdSGoZgIAg7JhFWRakc8T6Z5SxWzlFR5OPi0yEBzVwcBJVx21N6zDlJrw88liyEa3Qb3q1tRUxUvgCgu23cpv2gVXUPTy5SdiEVvy/MP/iWQAFMSC9E1HkUKoUWYyz4UCwrODoIGzQR7Stf1uViO9Mo0aFUcTck0fYCVUyXWgjyrJscV3vgmjbnlWa3cUf2F+tLcmQYpMJH+oddSKYKdJNiM/NmBHSoYjjUCDePj/XpsawdOanzetUfInWzoimAoLBVt45F9UDG0yd1mG3gf7G8OwxPWh/RL7pIZwKiGJvxdfLrhBI+roBotxUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgHMqA6NR6xwi31+5UQb02kpONt6s3GFuikZRULOVgI=;
 b=VsTwGxlovAH+46yi04iJt6VNhWVApnJMd0mPZ5sw1AqorHxPRvBJGBkrD52FaJ9tbEji7+v0jusEoLcCNJqN5huTd57Zq9u6F31SQth6QTv2sU53YqkDgGQDd2Lj2tG/LZx4c+pqyQW2Di8ZFFsObxdpo62OpsNeTEiAtUV1kqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN7PR12MB8004.namprd12.prod.outlook.com (2603:10b6:806:341::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 13:54:11 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 13:54:11 +0000
Message-ID: <603f0b69-71d3-ad8f-4b5e-53b63a6fd521@amd.com>
Date: Wed, 12 Jul 2023 15:53:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC v1 00/52] drm/crtc: Rename struct drm_crtc::dev to
 drm_dev
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Maxime Ripard <mripard@kernel.org>
References: <20230712094702.1770121-1-u.kleine-koenig@pengutronix.de>
 <94eb6e4d-9384-152f-351b-ebb217411da9@amd.com>
 <20230712110253.paoyrmcbvlhpfxbf@pengutronix.de>
 <o3dc4q27ap6rajsvpfwfvs3z3afekkwbhnclvswkaietciy2kc@unjf67gz5tur>
 <20230712133803.rf26cbg5wz7wsmgl@pengutronix.de>
In-Reply-To: <20230712133803.rf26cbg5wz7wsmgl@pengutronix.de>
X-ClientProxiedBy: FR3P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SN7PR12MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 671d3312-9a10-4462-11d9-08db82df77d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+CjsHYjoEoIKYhGUtD4L6IdokqTfF3/rDoqE4aTyfCbPLgsxxuVuGUsuYCA35P4DktoBo4NaYU33T1d8TbAYeptCtWe1B55Dc7oLzVxiycliZfDBnEm8XarwPg0ryzzSJwJvhapixHLvylLlitF0v/N12hzY0tfsoDFfKqumWSnLuk5x9Kn4zL6bJWU91FmrGKdnYdHX5drfEhP8xT5CwqxgEcEcA6YmR3c+YE5hsNLi/9CstC4LyCaAp5+lOrfLNlEjbdWekywxde7dpFY5E5s2/endwHQUHrz1bB9ykbxzYdRfCd0i9JW7/R6RC1xHH6+RRBRUIVRg1hDT66tr9wgyeCj9kKh/5b2fvBgeIJAefMeQ4DQGX2ABfSJY1ODzvBXYMRjaaJvv2MH5lBW1Wdn+4LhArrIoqD0ox+pZbg4DAYjKVelomflcL76YONd3m/Nm+A7Hl4KYkmN3O9uoF8v3kUa4pH8JvdeVkcLPt6rn2HtEznZol9p06p+UQwoRqyFsHPi7xBhaQmHP/1s/M/8/S29cNU3SALPZIHU7nlxbjBCA4vScSL+4SOd+JOPhDgQZTqOQ2+2X3KoAk0XpNvhaWjTc9kOmWYNTsNJP8BQ2Q3Gk9OICAtK/ERCMFrWI2Rxa4J2jJ36saRcsxOVNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199021)(8676002)(8936002)(7336002)(83380400001)(2906002)(66574015)(2616005)(36756003)(38100700002)(31696002)(86362001)(7406005)(7416002)(7366002)(7276002)(5660300002)(6506007)(186003)(31686004)(6666004)(66556008)(66476007)(4326008)(6486002)(110136005)(54906003)(66946007)(41300700001)(6512007)(316002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWZnOXNSRjdOTkRMN2twRmhhNlZKUU04WHhCY2Z0bUFVMmd0ZzMzZldoayts?=
 =?utf-8?B?elhFTXRKeWVNRUpHQ01yaTVaa1Ztakt4R216MWlHODdMUmhQYjdhMWRWUk9K?=
 =?utf-8?B?OFRpNCtPWlhuR003dy83ZXZySTlIcExnU1c0aHFEaWlya2hyRDliSjlkYlg1?=
 =?utf-8?B?bDNlV3I3b3VsWXN6VStIZDhhd1hzcW5OblM5Z0ZwWmp2b0FTMTVpdE5zTC9J?=
 =?utf-8?B?SGFRSm5PVmVhSjJSWnd6V2dYcE9RenYzbEg0UEpZTGRvbFQzUVFWQUZERjRu?=
 =?utf-8?B?bE5ncmc4N0xPZkZEbURQTjIwYlpYSFNzUC91TUxYZVZ2bHgvQmNNak5aNHp2?=
 =?utf-8?B?SG5kdnIvdmliUitLc2lYbnVpdjJOOHJLYkhMK3doOFdIZGtlckJSRmt1WHZ5?=
 =?utf-8?B?VTM4QldNT0JwV29jQXF4SzVaMzhpRmhCcmlJOVJTVFp0VzE0RGtUYmIrb3dJ?=
 =?utf-8?B?MnQvb0tRaFpVWlBjVE5OdE9heDVyYjNkUExTN3BxaWNCOE1WVTFoQkh6R3V6?=
 =?utf-8?B?eHhYS0FMVURYRFp0VXA5ZFBUNmV2QU5tMzVxK2FERFc5aFFObEkzKyt6ekpX?=
 =?utf-8?B?YlM4VElnWStHaVNhY2dsdWdDSGh4TkNEZnpveVk1c3I4RCtIOHJJTTNIbTF2?=
 =?utf-8?B?U3NtaTF5OWZ6Z0FpSFRLcHdBVFlpcEpoTVU1TjJnZ1J4YW9qVmlUSHViNlVL?=
 =?utf-8?B?emNONXFSYzhSM04xc0xkNmFidGw3cWNrbEs1OHVOTENPamFlRzB5SzVWNFlN?=
 =?utf-8?B?T0tIQWc0T0JNT2VxR25wKzFjSE00NVg3cWxMNGxtOC9ubHRlOTN1QXllQkhZ?=
 =?utf-8?B?a2RJVjF1RjhleWdlMzZkcDVMTForNU13UllNVUdBYldTYXJnTXdEVjBIZlVZ?=
 =?utf-8?B?R1lNOUM4VGhGV2NYMDExWU1tNG1VTUlEMzQrQjI3S0JvTjQ3aStLdlUrU2xn?=
 =?utf-8?B?MkdRdFR0eXl3VEtWL2p2WWRNb1pIMFNERHVxdm1tSHVyRkN6elVOcjBDVUw0?=
 =?utf-8?B?cGRVdlpCdVJFb1dHYk03VlVUZzl3NE8vVlN6bksrZGd3SEx0d1QwNmVKeVBT?=
 =?utf-8?B?ZHVkWXRCMjIvem9VOTl1ZnJQVEVCbUtuWElLY0ZTRWxnM3VPVFh6V1MvZnJO?=
 =?utf-8?B?ZG9zQ3VaQnFLUjZ1OXdGNEFMS1JWOS9BSTRYQkxPMHVxckYzaGFxcmtlcXgz?=
 =?utf-8?B?VXhrcE9CT2twUXYwQVYxSHk4UEJsdlVwMnF0YmxkUmh6cUMrdlI3SE9GUDVU?=
 =?utf-8?B?MzVxUUpHQXNOL1Z1REY2dTc0cEQwUGlHZVdqUmlzbHd6Nk1jdExTMjZDMXlQ?=
 =?utf-8?B?elJxMDZOWEhibURhenV4RHNwdUdXWDhxNXMwcVVucHBGOUI0WndLeXRmLzVz?=
 =?utf-8?B?UUxGUVhLaHEwK1NOd0pHYk9Lb2dnSGhqNU9LN3NWTlhxKzBXd3UxOUlWaEtI?=
 =?utf-8?B?UmIxeHUzOXdvNmtOM0hXbVJIYW5tWUFGMi94ck5Yb0VHUitCeFc1SlphVXJZ?=
 =?utf-8?B?cm1xaW1nL1NjQmdLQUd3dXUyQ2wyblJZMWZ0RGxGSXN3T296N1Y3dDk4dUhN?=
 =?utf-8?B?TVpGYWllcmdvYXFhUVdlanB1V3F5RzM2Zm9RSjZpNk5wSWZpWmhiYzNSVS9r?=
 =?utf-8?B?SDY5U1BHQlVrWTgvd1M1Y0tCUkFMK0RHNnBxUjQ5ZnQ5dU8yKzdvSC9JWXRP?=
 =?utf-8?B?V0pLTytkVTlEUkNWOTgyZ3QyL1BnOEpwNzB0YjMvUEVzazhiY2owVGg2RWdq?=
 =?utf-8?B?Mmh4R2JINXdPK3B0QnVxQjNJaTBTeUtzSE5oYlNtQjBvMnZCb2hleEc4RkJm?=
 =?utf-8?B?Q3lzZ3J6MjU4a1pLaDFnalFBT0FvTFZtYkZHckExSFRtU3NHbHY1Sjd0NFB3?=
 =?utf-8?B?WDg2MU1PaC93VE9vYVFZdmZ4dmh1R0RzYlRtcmdTUTh1MjZoR2NVUVErZVRy?=
 =?utf-8?B?aCtjeWp2dk1IWWg2anFrZDQ2WWMzSGtWY0xBT3FPZXJBMXY0U2xGNkY0eFZ3?=
 =?utf-8?B?QnpHWjJ2WXBGdjBBRTUvcXVkeC8yYkdXSWRJMDZIOUNSOHdsR2JhYWVNMkU5?=
 =?utf-8?B?T1FQQk9YVVFTL2RLcllWZXhWdGt0YWxxc2JJYVpwYlRRc3AxZGpLYTdLaXU4?=
 =?utf-8?B?K0hSNmJqS3BVUG04aWhWdlBvM2lBSTZQZU9kaDBwT2tJRkozSjdRZVNZSmkr?=
 =?utf-8?Q?wZiHYk+qO2DJStqXYi3DikavUdxGeplCKcXkmFW5lXc7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671d3312-9a10-4462-11d9-08db82df77d0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 13:54:10.5983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISzr+3rCUPYNUMLw1tOBcCfws4G9gt0O8QB3ANwU8gXg/6JBx2yCDaCKDG7kwoD8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8004
Cc: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Xinliang Liu <xinliang.liu@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Alexey Kodanev <aleksei.kodanev@bell-sw.com>, dri-devel@lists.freedesktop.org,
 Vandita Kulkarni <vandita.kulkarni@intel.com>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Arun R Murthy <arun.r.murthy@intel.com>, Jerome Brunet <jbrunet@baylibre.com>,
 linux-samsung-soc@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
 Matt Roper <matthew.d.roper@intel.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
 Danilo Krummrich <dakr@redhat.com>, NXP Linux Team <linux-imx@nxp.com>,
 spice-devel@lists.freedesktop.org,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-sunxi@lists.linux.dev,
 Matthias Brugger <matthias.bgg@gmail.com>, Stylon Wang <stylon.wang@amd.com>,
 Tim Huang <Tim.Huang@amd.com>, Suraj Kandpal <suraj.kandpal@intel.com>,
 =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
 Mika Kahola <mika.kahola@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Jani Nikula <jani.nikula@intel.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Lucas De Marchi <lucas.demarchi@intel.com>, Inki Dae <inki.dae@samsung.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Dave Airlie <airlied@redhat.com>,
 Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 =?UTF-8?Q?=c5=81ukasz_Bartosik?= <lb@semihalf.com>,
 Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
 Andrew Jeffery <andrew@aj.id.au>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, kernel@pengutronix.de,
 Alex Deucher <alexander.deucher@amd.com>, freedreno@lists.freedesktop.org,
 Claudiu Beznea <claudiu.beznea@microchip.com>, Zack Rusin <zackr@vmware.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-aspeed@lists.ozlabs.org, nouveau@lists.freedesktop.org,
 Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>,
 =?UTF-8?Q?Jos=c3=a9_Roberto_de_Souza?= <jose.souza@intel.com>,
 virtualization@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Yongqin Liu <yongqin.liu@linaro.org>,
 Mario Limonciello <mario.limonciello@amd.com>, Fei Yang <fei.yang@intel.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, David Francis <David.Francis@amd.com>,
 Vinod Govindapillai <vinod.govindapillai@intel.com>,
 Aaron Liu <aaron.liu@amd.com>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Vinod Polimera <quic_vpolimer@quicinc.com>, linux-rockchip@lists.infradead.org,
 Fangzhi Zuo <jerry.zuo@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>,
 =?UTF-8?Q?Jouni_H=c3=b6gander?= <jouni.hogander@intel.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-msm@vger.kernel.org, Animesh Manna <animesh.manna@intel.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Tian Tao <tiantao6@hisilicon.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 linux-amlogic@lists.infradead.org, Evan Quan <evan.quan@amd.com>,
 Michal Simek <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org,
 Sean Paul <sean@poorly.run>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Boris Brezillon <bbrezillon@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Sandy Huang <hjc@rock-chips.com>,
 Swati Sharma <swati2.sharma@intel.com>, linux-renesas-soc@vger.kernel.org,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Kevin Hilman <khilman@baylibre.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Paul Cercueil <paul@crapouillou.net>,
 Anusha Srivatsa <anusha.srivatsa@intel.com>, Dan Carpenter <error27@gmail.com>,
 Karol Herbst <kherbst@redhat.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 linux-hyperv@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
 Luca Coelho <luciano.coelho@intel.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Likun Gao <Likun.Gao@amd.com>,
 "Jiri Slaby \(SUSE\)" <jirislaby@kernel.org>, Emma Anholt <emma@anholt.net>,
 Alain Volmat <alain.volmat@foss.st.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Deepak Rawat <drawat.floss@gmail.com>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>, Joel Stanley <joel@jms.id.au>,
 Orson Zhai <orsonzhai@gmail.com>, Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Chia-I Wu <olvaffe@gmail.com>,
 Alan Liu <haoping.liu@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org,
 Alison Wang <alison.wang@nxp.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Gustavo Sousa <gustavo.sousa@intel.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>, Mikko Perttunen <mperttunen@nvidia.com>,
 Yifan Zhang <yifan1.zhang@amd.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Tomi Valkeinen <tomba@kernel.org>, Deepak R Varma <drv@mailo.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Julia Lawall <Julia.Lawall@inria.fr>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 John Stultz <jstultz@google.com>, Roman Li <roman.li@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Khaled Almahallawy <khaled.almahallawy@intel.com>,
 linux-stm32@st-md-mailman.stormreply.com, Sam Ravnborg <sam@ravnborg.org>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Imre Deak <imre.deak@intel.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Liu Shixin <liushixin2@huawei.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, David Airlie <airlied@gmail.com>,
 Marek Vasut <marex@denx.de>, Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Lang Yu <Lang.Yu@amd.com>, xen-devel@lists.xenproject.org,
 Guchun Chen <guchun.chen@amd.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Russell King <linux@armlinux.org.uk>, Leo Li <sunpeng.li@amd.com>,
 Uma Shankar <uma.shankar@intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Jiasheng Jiang <jiasheng@iscas.ac.cn>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 David Lechner <david@lechnology.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 =?UTF-8?Q?Joaqu=c3=adn_Ignacio_Aramend=c3=ada?= <samsagax@gmail.com>,
 Melissa Wen <mwen@igalia.com>, Hans de Goede <hdegoede@redhat.com>,
 linux-mediatek@lists.infradead.org, Fabio Estevam <festevam@gmail.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-tegra@vger.kernel.org,
 David Tadokoro <davidbtadokoro@usp.br>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Yannick Fertre <yannick.fertre@foss.st.com>, linux-mips@vger.kernel.org,
 Rob Clark <robdclark@gmail.com>, Philippe Cornu <philippe.cornu@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Wayne Lin <Wayne.Lin@amd.com>,
 Drew Davenport <ddavenport@chromium.org>, Nirmoy Das <nirmoy.das@intel.com>,
 Jyri Sarha <jyri.sarha@iki.fi>, Lucas Stach <l.stach@pengutronix.de>
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

QW0gMTIuMDcuMjMgdW0gMTU6Mzggc2NocmllYiBVd2UgS2xlaW5lLUvDtm5pZzoKPiBIZWxsbyBN
YXhpbWUsCj4KPiBPbiBXZWQsIEp1bCAxMiwgMjAyMyBhdCAwMjo1MjozOFBNICswMjAwLCBNYXhp
bWUgUmlwYXJkIHdyb3RlOgo+PiBPbiBXZWQsIEp1bCAxMiwgMjAyMyBhdCAwMTowMjo1M1BNICsw
MjAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToKPj4+PiBCYWNrZ3JvdW5kIGlzIHRoYXQgdGhp
cyBtYWtlcyBtZXJnZSBjb25mbGljdHMgZWFzaWVyIHRvIGhhbmRsZSBhbmQgZGV0ZWN0Lgo+Pj4g
UmVhbGx5Pwo+PiBGV0lXLCBJIGFncmVlIHdpdGggQ2hyaXN0aWFuIGhlcmUuCj4+Cj4+PiBFYWNo
IGZpbGUgKGFwYXJ0IGZyb20gaW5jbHVkZS9kcm0vZHJtX2NydGMuaCkgaXMgb25seSB0b3VjaGVk
IG9uY2UuIFNvCj4+PiB1bmxlc3MgSSdtIG1pc3Npbmcgc29tZXRoaW5nIHlvdSBkb24ndCBnZXQg
bGVzcyBvciBlYXNpZXIgY29uZmxpY3RzIGJ5Cj4+PiBkb2luZyBpdCBhbGwgaW4gYSBzaW5nbGUg
cGF0Y2guIEJ1dCB5b3UgZ2FpbiB0aGUgZnJlZWRvbSB0byBkcm9wIGEKPj4+IHBhdGNoIGZvciBv
bmUgZHJpdmVyIHdpdGhvdXQgaGF2aW5nIHRvIGRyb3AgdGhlIHJlc3Qgd2l0aCBpdC4KPj4gTm90
IHJlYWxseSwgYmVjYXVzZSB0aGUgbGFzdCBwYXRjaCByZW1vdmVkIHRoZSB1bmlvbiBhbnl3YXku
IFNvIHlvdSBoYXZlCj4+IHRvIHJldmVydCBib3RoIHRoZSBsYXN0IHBhdGNoLCBwbHVzIHRoYXQg
ZHJpdmVyIG9uZS4gQW5kIHRoZW4geW91IG5lZWQKPj4gdG8gYWRkIGEgVE9ETyB0byByZW1vdmUg
dGhhdCB1bmlvbiBldmVudHVhbGx5Lgo+IFllcywgd2l0aCBhIHNpbmdsZSBwYXRjaCB5b3UgaGF2
ZSBvbmx5IG9uZSByZXZlcnQgKGJ1dCAxOTQgZmlsZXMgY2hhbmdlZCwKPiAxMjY0IGluc2VydGlv
bnMoKyksIDEyOTYgZGVsZXRpb25zKC0pKSBpbnN0ZWFkIG9mIHR3byAob25lIG9mIHRoZW06IDEK
PiBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKTsgdGhlIG90aGVy
IG1heWJlIGEgYml0Cj4gYmlnZ2VyKS4gKEFuZCBtYXliZSB5b3UgZ2V0IGF3YXkgd2l0aCBqdXN0
IHJldmVydGluZyB0aGUgbGFzdCBwYXRjaC4pCj4KPiBXaXRoIGEgc2luZ2xlIHBhdGNoIHRoZSBU
T0RPIGFmdGVyIGEgcmV2ZXJ0IGlzICJyZWRvIGl0IGFsbCBhZ2FpbiAoYW5kCj4gcHJlcGFyZSBm
b3IgYSBkaWZmZXJlbnQgc2V0IG9mIGNvbmZsaWN0cykiIHdoaWxlIHdpdGggdGhlIHNwbGl0IHNl
cmllcwo+IGl0J3Mgb25seSAiZml4IHRoYXQgb25lIGRyaXZlciB0aGF0IHdhcyBmb3Jnb3R0ZW4v
Ym9ya2VkIiArIHJlYXBwbHkgdGhhdAo+IDEwIGxpbmUgcGF0Y2guCgpZZWFoLCBidXQgZm9yIGEg
bWFpbnRhaW5lciB0aGUgc2l6ZSBvZiB0aGUgcGF0Y2hlcyBkb2Vzbid0IG1hdHRlci4gClRoYXQn
cyBvbmx5IGludGVyZXN0aW5nIGlmIHlvdSBuZWVkIHRvIG1hbnVhbGx5IHJldmlldyB0aGUgcGF0
Y2gsIHdoaWNoIAp5b3UgaG9wZWZ1bGx5IGRvZXNuJ3QgZG8gaW4gY2FzZSBvZiBzb21ldGhpbmcg
YXV0by1nZW5lcmF0ZWQuCgpJbiBvdGhlciB3b3JkcyBpZiB0aGUgcGF0Y2ggaXMgYXV0by1nZW5l
cmF0ZWQgcmUtYXBwbHlpbmcgaXQgY29tcGxldGVseSAKaXMgbGVzcyB3b3JrIHRoYW4gZml4aW5n
IHRoaW5ncyB1cCBpbmRpdmlkdWFsbHkuCgo+ICAgQXMgdGhlIG9uZSB3aG8gZ2V0cyB0aGF0IFRP
RE8sIEkgcHJlZmVyIHRoZSBsYXR0ZXIuCgpZZWFoLCBidXQgeW91ciBwZXJzb25hbCBwcmVmZXJl
bmNlcyBhcmUgbm90IGEgdGVjaG5pY2FsIHJlbGV2YW50IAphcmd1bWVudCB0byBhIG1haW50YWlu
ZXIuCgpBdCB0aGUgZW5kIG9mIHRoZSBkYXkgRGF2ZSBvciBEYW5pZWwgbmVlZCB0byBkZWNpZGUs
IGJlY2F1c2UgdGhleSBuZWVkIAp0byBsaXZlIHdpdGggaXQuCgpSZWdhcmRzLApDaHJpc3RpYW4u
Cgo+Cj4gU28gaW4gc3VtOiBJZiB5b3VyIG1ldHJpYyBpcyAic21hbGwgY291bnQgb2YgcmV2ZXJ0
ZWQgY29tbWl0cyIsIHlvdSdyZQo+IHJpZ2h0LiBJZiBob3dldmVyIHlvdXIgbWV0cmljIGlzOiBC
ZXR0ZXIgZ2V0IDk1JSBvZiB0aGlzIHNlcmllcycgY2hhbmdlCj4gaW4gdGhhbiBtYXliZSAwJSwg
dGhlIHNwbGl0IHNlcmllcyBpcyB0aGUgd2F5IHRvIGRvIGl0Lgo+Cj4gV2l0aCBtZSBoYXZpbmcg
c3BlbmQgfjNoIG9uIHRoaXMgc2VyaWVzJyBjaGFuZ2VzLCBpdCdzIG1heWJlCj4gdW5kZXJzdGFu
ZGFibGUgdGhhdCBJIGRpZCBpdCB0aGUgd2F5IEkgZGlkLgo+Cj4gRlRSOiBUaGlzIHNlcmllcyB3
YXMgY3JlYXRlZCBvbiB0b3Agb2YgdjYuNS1yYzEuIElmIHlvdSBhcHBseSBpdCB0bwo+IGRybS1t
aXNjLW5leHQgeW91IGdldCBhICh0cml2aWFsKSBjb25mbGljdCBpbiBwYXRjaCAjMi4gSWYgSSBj
b25zaWRlciB0bwo+IGJlIHRoZSByZXNwb25zaWJsZSBtYWludGFpbmVyIHdobyBhcHBsaWVzIHRo
aXMgc2VyaWVzLCBJIGxpa2UgYmVpbmcgYWJsZQo+IHRvIGp1c3QgZG8gZ2l0IGFtIC0tc2tpcCB0
aGVuLgo+Cj4gRlRSIzI6IEluIGRybS1taXNjLW5leHQgaXMgYSBuZXcgZHJpdmVyCj4gKGRyaXZl
cnMvZ3B1L2RybS9sb29uZ3Nvbi9sc2RjX2NydGMuYykgc28gc2tpcHBpbmcgdGhlIGxhc3QgcGF0
Y2ggZm9yCj4gbm93IG1pZ2h0IGluZGVlZCBiZSBhIGdvb2QgaWRlYS4KPgo+Pj4gU28gSSBzdGls
bCBsaWtlIHRoZSBzcGxpdCB2ZXJzaW9uIGJldHRlciwgYnV0IEknbSBvcGVuIHRvIGEgbW9yZQo+
Pj4gdmVyYm9zZSByZWFzb25pbmcgZnJvbSB5b3VyIHNpZGUuCj4+IFlvdSdyZSBkb2luZyBvbmx5
IG9uZSB0aGluZyBoZXJlLCByZWFsbHk6IHlvdSBjaGFuZ2UgdGhlIG5hbWUgb2YgYQo+PiBzdHJ1
Y3R1cmUgZmllbGQuIElmIGl0IHdhcyBzaGFyZWQgYmV0d2VlbiBtdWx0aXBsZSBtYWludGFpbmVy
cywgdGhlbgo+PiBzdXJlLCBzcGxpdHRpbmcgdGhhdCB1cCBpcyBlYXNpZXIgZm9yIGV2ZXJ5b25l
LCBidXQgdGhpcyB3aWxsIGdvIHRocm91Z2gKPj4gZHJtLW1pc2MsIHNvIEkgY2FuJ3Qgc2VlIHRo
ZSBiZW5lZml0IGl0IGJyaW5ncy4KPiBJIHNlZSB5b3VyIGFyZ3VtZW50LCBidXQgSSB0aGluayBt
aW5lIHdlaWdodHMgbW9yZS4KPgo+IEJlc3QgcmVnYXJkcwo+IFV3ZQo+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
