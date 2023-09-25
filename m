Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED47CE7A8B
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 01:05:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A80880C83;
	Mon, 25 Sep 2023 01:05:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A80880C83
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.a=rsa-sha256 header.s=TM-DKIM-20210503141657 header.b=oPkkeH2S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UCjbnfegChgQ; Mon, 25 Sep 2023 01:05:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 30A3F80C2F;
	Mon, 25 Sep 2023 01:05:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 30A3F80C2F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDC48C0039;
	Mon, 25 Sep 2023 01:05:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 521D4C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 01:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 24D5C60BD3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 01:05:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 24D5C60BD3
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com
 header.a=rsa-sha256 header.s=TM-DKIM-20210503141657 header.b=oPkkeH2S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S7JvXw1kh_At
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 01:05:09 +0000 (UTC)
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu
 [18.185.115.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5F4E06080A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 01:05:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F4E06080A
Received: from 104.47.11.171_.trendmicro.com (unknown [172.21.196.113])
 by repost01.tmes.trendmicro.eu (Postfix) with SMTP id EA9751000095C;
 Mon, 25 Sep 2023 01:05:06 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1695603892.355000
X-TM-MAIL-UUID: 66b770dd-8cfb-474d-bee3-9b1f77b5fb91
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown
 [104.47.11.171])
 by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id
 56E5010020CF2; Mon, 25 Sep 2023 01:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPf8ZBWx/fbCBlhZ9cdb7Tq630jWaHXbXWzUPRJ8owxDc9Zx/hLMjDJ78+Ru2S/GTZFxeMbMHPkR85G+jCGsVMjpYktH8MBmdz9CbQoLVt4QzAJ7WhgycwEiW7hWoA8WHY9qet4FT5LDW2CU9N1eie0+I8BXwM1kTtB+LVN4kaUwWbGsRW85evHt8QoC5e4Bkvy5WY7nDB+keTKNmktRDToGFGwHx87RW4rReq7GrXWZSuXP/2VuGAz8dYt8UVnBDJZkdgbS5NFMM/gN9esvkYafvN9YWVKN0uBzzJ8EcTrAdd1IvR6Of4CNTMeHVenDjahU7bZdpQiFD+sBs1OyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWFQqcprdP3rcid0qPyeiKuOjbXXyGtoXRgWOePTUPA=;
 b=EevzBcTZibfl6g9ZGog0hsYDdrI1sFkGmc86RPUoOWMyMjpME2ioDsyqIgEfjaHR4KIXCun3SsSiRZHdRaivEjhAq6I7kaVJwNBrhfgdrAY/8Tm+zRQwPXoP7hBLTsiculuC5tr8brMMpwEh+Ik/yUrcSJk5EJ+Fl2yhlpnIPdHd5w2Q/RkjMjrW0FVOFtKgWyDWutYudQbTEC5IhlXtMRkC0O8PXjLRE8Rz0+c+AJBr11KTeqPzZeSdKjSZVv6YS/R178hKW127xfD+RL4+qgAm2/4CUW+SjviHAVHVwaML0yaFIWCF6ESb15SYevrlxHjApbFug8KYbba1+cT3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <0f377606-ac93-4be1-9e5e-80bce31e6bce@opensynergy.com>
Date: Mon, 25 Sep 2023 10:04:33 +0900
Subject: Re: virtio-sound linux driver conformance to spec
Content-Language: en-US
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <ZQHPeD0fds9sYzHO@pc-79.home>
 <20230919054054-mutt-send-email-mst@kernel.org> <ZQmt0Z8lbPMuFzR+@fedora>
 <20230919102250-mutt-send-email-mst@kernel.org> <ZQrxJnzYHSH0OhiR@fedora>
In-Reply-To: <ZQrxJnzYHSH0OhiR@fedora>
X-ClientProxiedBy: OSBPR01CA0094.jpnprd01.prod.outlook.com
 (2603:1096:604:2d::34) To BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:5c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2374:EE_|FR2P281MB0283:EE_
X-MS-Office365-Filtering-Correlation-Id: 860d6296-201b-47a3-9d9e-08dbbd636b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmMwee89XwA4MvwwhXJiRgxaJQHs6qgXrxDvH380VWLTPrppfRE9Nw+UT03b/DpR13vDUTCyagYDCU/fHDyMQaLe/sW3RB6nF/adT2H3W1A7MgJOVzwfOCYZrONTyMlBE8BoSdhUcTAJg7p5qKWT0kufMK3pQVoBoFoU/BWB77MP9g/9tmSocAvs9mUDbV+ac6EhcKSmd7Z2VPBwKFnReJflckWopJSkNnMF7s7Y+YzdP/IEBYWxsmcYQ1plnk8e9opeVOgwH8JSU6cZwQqn9ZynhQjzvjXTO2Q383jNRvvtYgUmL2ybTPSNIbOY0aN34mYrESErFqwH1h8UEAAC7gys/BvbtnhzPWIYYjWY75ULSCZxB1D/fdp7tSqX9TYglJ1tg7liPdsOpimsN/oXflkQi4qCFtZJXNbX4QYeuiHzviiqiIADXntKjU5AhA0Yeeq/svo5JBlLEC31elmZj3Hq04vlUq0NrCFAsJ40RKRYNn3i6CilnQxt+bzh+RdmyWs3nx2eZMQV1SZFl7qFVo0j8mLxF8pxd+jVE7uaQ7FFTvYH5PM4mKdCX8WmthYhPNErzfeng6pxAsJYNUgIAH3nYuXbF5IT1+reVTPSrYTj4Lr9tMcVPNMnBX34v/JSjy9F2+z0QnZPRE/Vug4JEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39830400003)(230922051799003)(186009)(1800799009)(451199024)(53546011)(26005)(2616005)(66946007)(66556008)(66476007)(110136005)(31696002)(86362001)(478600001)(38100700002)(83380400001)(2906002)(8676002)(8936002)(4326008)(36756003)(42186006)(5660300002)(316002)(44832011)(41300700001)(31686004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkcwZ2lPeTB5ZktQeUVhamFkYUliQUJlWTV4MHNJMjdNVlExYXdRQzNxWnQv?=
 =?utf-8?B?aVlPUE0xR1JVQXMvVkQ5bkVSRVRtMTJXOVNGMk5IdmhQNkZucTh1bEdPMjls?=
 =?utf-8?B?T0xORzc2UWdXVDVIbzJ2TWE1N0hzQS80TjdFY0VJNjM3TU5zK0w5OC93U2ta?=
 =?utf-8?B?Slg3OGY3SnFKcXA0YmNtQWgvaXpQb0JoMHBTekpLQitDWWFaVEhBUnRweVVj?=
 =?utf-8?B?NzloOW9iWFdUZEhiUVNJNkN2Z1pEN3NUZy9xQnkyQkxnV04yU3dOeWdtNnV4?=
 =?utf-8?B?c1l3Q0R1R2lYSmdGYjNFSUNVaG5WY2JBbVN4b2Mvd2h5REIwM0tWNStaL2NY?=
 =?utf-8?B?QnFCQVJIcEhsQ21FOENTOWRxYXVwR21hNUE0OWs3VXZwUXJwTDY5OS93RlZm?=
 =?utf-8?B?ZUdFU1BrK1lVOTNqVE9QMTZiOEtqa2hNYzhTeEVYK29QZzA0eCttaFh2azh6?=
 =?utf-8?B?WGpUamw3azZVSklmR3pMRHVaSGNhbUUxd1NFaWY5UEI0OW1acVhLTEJZeTVw?=
 =?utf-8?B?V1N5NUZQWTk1NURHYnkwcXM2SXdTZGl2dlpKSzd0NTNPUnBOYm5sVi9FNGJ1?=
 =?utf-8?B?OGVvWlpVaElGdEY5eit2dHZGcGVwNTJZTnNUVGRrZTU5bWVXSE9sWkdsa2l3?=
 =?utf-8?B?N21WWkVCVE5FWGxvZDF4MFFHTWJpUjI0MFBUc0xKcitSRTVKaE5jcUN4eGg5?=
 =?utf-8?B?aDhOWXdjaDhvdlpKUTc4YUsvTktHY2JpWWU4WDlXZUtWZjFWdVI5TlN5YnhG?=
 =?utf-8?B?Q1VtcThwOVYvM2ZSV2JVOWEwaWozdnBWV0dLMkh3ZUw1K3BKSGZhb2R3MlRW?=
 =?utf-8?B?RXlHUE03M0x5cHRZNVN4cENRTXRCTnZGZVJSU2dTbXlQak93SGRhNkJCVWJ1?=
 =?utf-8?B?TXVNblpsRGNVSUgrcmxDOHVCZFBrb3VEeVpKY29mRncwTU9GZWFxV0l5NDZI?=
 =?utf-8?B?YWxaZzZMdkZtNFRHT1BaTlFzVWJpVzJRa1kvVkVQK0VJV0xPV29QaVVWczZ4?=
 =?utf-8?B?V3VPTElpWDY5ZC9RRkF6QVgxaXBEd2NieWJFa0lKTDNKQysyVzFqczdrQk0v?=
 =?utf-8?B?dlZsWS9MMkoxc0diK0JoYkRzQkNwMnN6bTlBMFZFQTFid3BYcEx6Z2h0d09v?=
 =?utf-8?B?alBsajlLcmtCM2Zwamd5ci9EL3pCU1ZtYVRlV09uaUMvdGVUTFR5b1F4QTl2?=
 =?utf-8?B?bkljS3J0bzlObTJoUFRseDE3cHhadUdQdWtjdEdoWkIxT0hoMTgzODkzb2h4?=
 =?utf-8?B?bWRoWW1MdHIyWFpTdG5NUHV2Qi81bmhNVVk3ZkpHbTBVcGM3NllEZjhkcXVi?=
 =?utf-8?B?Uyt0OWw5dWk2cUw0Z25SRzN5MmliZnljQUV0YlJBbm1lQyt3QnJyb2ltUE83?=
 =?utf-8?B?cGdoYXFFQXNkd3dkZEJjVFV3NUdOeWQzTHg0b0xPcVgycWgrL3pvbmhheUFO?=
 =?utf-8?B?ejRFNSs0Uk5ZUUFPQkhKVFFoV1BIVUlqTkQyNHVpdncxdFVOVlhvekw4WTNI?=
 =?utf-8?B?enhEamlwWUx3Mm5FTHFraW04c3J6NFBJeW9SYWJVL21jYVZ4NHhLMEM1YkE1?=
 =?utf-8?B?OUp0TG91clhTdUk0dEhWYXRHUURNQkhueFZWK21ac24xMk92amExZGJway9D?=
 =?utf-8?B?YUgvaHpOeEZnMlIzeTRpWDdVWkt0dGhkaFQwT0Y3RjlibVJtODBaWkV2dkZt?=
 =?utf-8?B?VWlWVHV3aHhyRW4zU3o5NFR5dWpOV0hPT2J6a3JaM0U0UW02bVJla3pOZDJD?=
 =?utf-8?B?SHBVc3VLRUFTYWVjT2t6YlBObm9WSWMwN1hXMWhqOW1BZUNCSGZBbFpwTVpT?=
 =?utf-8?B?cVpNUko1M1IwREk4NXNuR21OaWJkZ1ZJd0ZIZmRHak5McUY3STk3SEdhally?=
 =?utf-8?B?MERPRTV6RDhCWU1LT3R5enUwRGEvZkl6eEZBU2MzWmlJR20vSDhvdGcrN3p3?=
 =?utf-8?B?L2MvQkFxVndvN3VEUnRYeEtCTzE2MHBra1duOUl3Z09GR2NjUUIvRjAvcmM2?=
 =?utf-8?B?R3pWbmltNXBuMEhXM3IxYlVvQkN6YnArY0V3RnpjQ2xjQVRiSGdYKzZZdXcr?=
 =?utf-8?B?YlN2akI2bUFZb05zTFZkUUJqSVAySXUvNGR0VXRiaW5mQ3ZqUFM3SGg4ZTdx?=
 =?utf-8?Q?NfGdoEss2a0DYG+1a13uIbAET?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860d6296-201b-47a3-9d9e-08dbbd636b54
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 01:04:50.6295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3SKlour9dhI5j2cZo+SLtCFe0fhEmzVLSMaeNlrLMdsP9dMBTf8VNbMAl+FQVlhiOOkwAi6g3g6Wydgc9KDWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0283
X-TM-AS-ERS: 104.47.11.171-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-27896.003
X-TMASE-Result: 10--22.249800-4.000000
X-TMASE-MatchedRID: EMyCvCfVN1FTzAVQ78TKJRhvdi92BBAuMKBMviil9LIrHeGVS/Qy54Jb
 qOf8l3HTPXE7GzZeNWoQjSTsX7NxDl9un4KO0k1IeJchdZcr1K17tzq0SRd7O6EvKeC1YDuQuud
 R5w9ehBNGkY/PHLh2BQ4Sol+Ip7tU0MrvUXTHeZlLviwaHYb1sc5hvaZoPJ3CMmXeT28VArw58p
 R4itKLvyRF+Q8qR9T8R1ssKMDNxzQST566OvwT1twy9mwTudtiOteHVGUMZ+CS/GH8zyFDN3wcv
 ncZ8K8Yd6LuF1eeMId0BGnLssDUquQ7HWHaJhLZVj1dhrWbzEB1cj4F9+ou5G9P1W94aaoPC9LN
 iV6b1+wBy3KU4lfnAHSmKDroh9Bxrddi2w4fb9D24vmE69obUs1nntU6vE00SRTwXIGJhSKMgyD
 zgLecYxfm5B8o/cMhSldd4cHL7vYaZbiuAgTmlCwlGQqAeWsoyiAijCjuVj2hgsXxlmwopu/Gu3
 EgFWnwJjDtvZKbbVzlS3lpuOq4YuyhxB3tZjnIQj0AQ98QP92jg0lrtKMWyg2h/xVLZG6HTvOSX
 KE9MP1gjJAzgl+daXht3q2IwW5dftwZ3X11IV0=
X-TMASE-XGENCLOUD: 1577e94e-e110-9135-91e0-f4d7b87dcda4-0-0-200-0
X-TM-Deliver-Signature: ADCDE1B9ECD4936746BF2E55F40CF0FE
X-TM-Addin-Auth: 5kiflbbJK/DvRTJXPg0uhOljdDKas/z6LPfpnL3ng7p63x3l8TKzCN6pa7M
 P5IE9r0a0+uJ0xD43Nju5H804BQ/peOzwXvMa8L9UEIBBeClzGmoTol1c8GotiSN0ct1YEBK+jG
 Aa4y1A+OaTdZlbeKq33HX9GDizYLgfb9dKTp6CxbLXhAzKU2DrN+otd8+parsqdg6TYkeMNIKsk
 SRzHycdB8qwCiGP1+FJG68Svvg49XSthiPIn3kqa51GHt115l2h2X1mBpjlpAYwWSGHzWdL1+m1
 98fOexb+UY7iVbU=.z2lgZjUa/fipYXhspEJLHnOZWA6iwPxh+8J/QeK2t4/58YWNpbSSZUMO76
 QuW7XN3odJlIPHGhPcKdaQNyG5EXYXRFG4jiodP6hqyatraynHg9FwZg6ippraOXXn/dHQdJXIF
 T+C/awTT58TA1TgBeLH0vDTYZrHax2469cHLZTuM+/FikdsHcDXIavo7bEJKdChDWQMOFQlQs4t
 oP5Pvd7xFWBwdXpW94La4FywLStgsDHX7LGWUoMaOKPuugydwviq0wnG2h5cUc4ku6ywDBi3YEI
 EIyTKQxWqgelWL6MCwXNLp08ja+2luBYNxbsjMXh0+4vszUQrmNw56Yz2Iw==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
 s=TM-DKIM-20210503141657; t=1695603906;
 bh=h62kHN5uzF9eaCvD44oeXWcWGvruCtAs/irOnGCaR2g=; l=4111;
 h=Date:To:From;
 b=oPkkeH2SKl9BBDaB95rxVqXbyKXt5OJ0Fb3ImRWHYmSyOSYgWgizk9d4ue7qxTuzG
 6pVy9yGjeFBDWoWi8Y91x1MZxypwyTm62rgKKf605PfbtJ2UicaHKr7yu1bCuMlP8x
 UoT383ptCPrUWzO8NYhAhFBQr4AuEb1th9twFoA7DdAPPEuXXg9xlvT5niQGu61fbi
 ILpgGV/v8FdM07XFjQtxKySfsNYDtBlUq0SgAFsistjgYfOrDAM16lbX4BL/wVbHwq
 tsQ75tOxwOqmAuwc0Q6jxMrwtaTyZs0A5jLxf25kVlOEo6rOOdmQ11QivKZZ4ZWFLt
 l/qIvw76AwEWw==
Cc: virtio-comment@lists.oasis-open.org, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org
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
From: Anton Yakovlev via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hello Matias,

On 20.09.2023 22:18, Matias Ezequiel Vara Larsen wrote:
> On Tue, Sep 19, 2023 at 11:52:27AM -0400, Michael S. Tsirkin wrote:
>> On Tue, Sep 19, 2023 at 04:18:57PM +0200, Matias Ezequiel Vara Larsen wrote:
>>> On Tue, Sep 19, 2023 at 05:43:56AM -0400, Michael S. Tsirkin wrote:
>>>> On Wed, Sep 13, 2023 at 05:04:24PM +0200, Matias Ezequiel Vara Larsen wrote:
>>>>> Hello,
>>>>>
>>>>> This email is to report a behavior of the Linux virtio-sound driver that
>>>>> looks like it is not conforming to the VirtIO specification. The kernel
>>>>> driver is moving buffers from the used ring to the available ring
>>>>> without knowing if the content has been updated from the user. If the
>>>>> device picks up buffers from the available ring just after it is
>>>>> notified, it happens that the content is old.
>>>>
>>>> Then, what happens, exactly? Do things still work?
>>>
>>> We are currently developing a vhost-user backend for virtio-sound and
>>> what happens is that if the backend implementation decides to copy the
>>> content of a buffer from a request that just arrived to the available
>>> ring, it gets the old content thus reproducing some sections two times.
>>> For example, we observe that when issuing `aplay FrontLeft.wav`, we hear
>>> `Front, front left...`. To fix this issue, our current implementation
>>> delays reading from guest memory just until the audio engine requires.
>>> However, the first implementation shall also work since it is conforming
>>> to the specification.
>>>
>>> Matias
>>
>> Sounds like it. How hard is it to change the behaviour though?
>> Does it involve changing userspace?
> 
> AFAIU, a fix for the driver may be to somehow wait until userspace
> updates the buffer before add it in the available ring.
> So far, when the device notifies the driver that a new buffer is in the
> used ring, the driver calls the virtsnd_pcm_msg_complete() function to
> do:
> ```
> schedule_work(&vss->elapsed_period);
> 
> virtsnd_pcm_msg_send(vss);
> ```
> It first defers the notification to userspace regarding an elapse period
> and then it enqueues the request again in the available
> ring.`schedule_work()` defers the calling to the
> `virtsnd_pcm_period_elapsed()` function that issues
> `snd_pcm_period_elapsed(vss->substream);` to notify userspace.
> My proposal would be that the driver could also defer
> `virtsnd_pcm_msg_send(vss)` to execute just after
> `snd_pcm_period_elapsed(vss->substream)`. Something like this:
> 
> diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
> index c10d91fff2fb..41f1e74c8478 100644
> --- a/sound/virtio/virtio_pcm.c
> +++ b/sound/virtio/virtio_pcm.c
> @@ -309,6 +309,7 @@ static void virtsnd_pcm_period_elapsed(struct work_struct *work)
>                  container_of(work, struct virtio_pcm_substream, elapsed_period);
>   
>          snd_pcm_period_elapsed(vss->substream);
> +       virtsnd_pcm_msg_send(vss);
>   }
>   
>   /**
> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> index aca2dc1989ba..43f0078b1152 100644
> --- a/sound/virtio/virtio_pcm_msg.c
> +++ b/sound/virtio/virtio_pcm_msg.c
> @@ -321,7 +321,6 @@ static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg,
>   
>                  schedule_work(&vss->elapsed_period);
>   
> -               virtsnd_pcm_msg_send(vss);
>          } else if (!vss->msg_count) {
>                  wake_up_all(&vss->msg_empty);
>          }
> 
> 
> I tested it and it looks it fixes the issue. However, I am not sure if
> this is enough since I do not know if when `snd_pcm_period_elapsed()`
> returns, the buffers have been already updated.

It's just a lucky coincidence that this change helped in your case.

Instead, to solve the problem, it's necessary to implement read/write()
operations for the substream, and disable MMAP access mode.

I'll try, but I'm not sure I'll have enough time for this in the near future.


-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
