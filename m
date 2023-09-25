Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061A5CE7A91
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 00:37:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8852560E5C;
	Mon, 25 Sep 2023 00:37:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8852560E5C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.a=rsa-sha256 header.s=TM-DKIM-20210503141657 header.b=OR9QegKk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SaqR-blN8_TC; Mon, 25 Sep 2023 00:37:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E92A260803;
	Mon, 25 Sep 2023 00:37:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E92A260803
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACB4FC0039;
	Mon, 25 Sep 2023 00:37:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6793EC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 00:37:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3036F81D7D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 00:37:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3036F81D7D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com
 header.a=rsa-sha256 header.s=TM-DKIM-20210503141657 header.b=OR9QegKk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mZvj93UJFBCo
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 00:37:22 +0000 (UTC)
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu
 [18.185.115.29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CB06481D73
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 00:37:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CB06481D73
Received: from 104.47.7.173_.trendmicro.com (unknown [172.21.184.89])
 by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 42F2210000092;
 Mon, 25 Sep 2023 00:37:19 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1695602238.695000
X-TM-MAIL-UUID: 7ad1af67-1243-4df3-8505-19a113775871
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown
 [104.47.7.173])
 by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id
 A9F7C1000040F; Mon, 25 Sep 2023 00:37:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lb51yJ7M/eldTss0H/WXQEnflXg63Ffwg4TH2ilKWElXa8Aj9lagYzseMWe5iXvomnHc+Y9EVqrjzHPDo9mVi7GiaLcCdYaw1Usa66Wen4itg6qArAjyUlvkJUqKxWopcSIBXM5EKhZzuyi81jDDuLEPpQ9UNj4NA//8C2TG0ak/qkmNI7J35aiuBHCLoKlnAuKXQpJ4Evwt8DmJNFO99aIxy+IlRCVUYwOsphMDgh/bCRvyYrVaZV38gWRf0gVJgg0iRpF7NoXLMJgq2Ci8UNS9Y7nWC9ejfoVwMnH2GwDvixWXK+OOGRAMDEAJoRBq3eD3GGnpLuYx5yQUzvhuhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDFo//tzbqck6fTg3XlSo569Ef0OB3bqmAE5RMa2Mc0=;
 b=TOnItC6AEBjAwhjAJWeu7dhST6jq1FA8XJdFflZ/WkaMCRs3zEU7e5hTsHW068SIis7/X8gt/lDqr0Ln/j5IQQp0zemK7ShO/CRtSMvEhnPSzReAOBW60p1rgbyoeStXctx/AeNHR1fiSxqOfAVN1KwbiSdgxaI0XwvUp+qphrCQGqXf5MOvDCJ1iQLyKcO3+Yz+G7McpjjKMI5f2rZ3Veungl7n67lcXGz0P7lC21kNg2U4EkxIqpIS+74UzMvkTTxbazLy/JNGmb2iwYHn+2PZidVfeL+HayfKAQQq4Yx1Wj2iFNjQWSynKjyVHqPVtKfGIrExbv9/NTrX+MROYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <e7e1eb3c-cbc2-4b2c-aecc-dde1a71cbcc4@opensynergy.com>
Date: Mon, 25 Sep 2023 09:37:01 +0900
Subject: Re: [virtio-comment] Re: virtio-sound linux driver conformance to spec
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <ZQHPeD0fds9sYzHO@pc-79.home>
 <ed568bcf-0fc0-40f5-9cb3-14c2923f8bf7@opensynergy.com>
 <64adaae1-28a6-b175-9fb0-f4f2c26e696e@redhat.com>
 <20230919151041.GA1515067@fedora>
In-Reply-To: <20230919151041.GA1515067@fedora>
X-ClientProxiedBy: OS0PR01CA0143.jpnprd01.prod.outlook.com
 (2603:1096:604:27::18) To BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:5c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2374:EE_|BEZP281MB2136:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a828feb-ed6d-4be0-5855-08dbbd5f919f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +24jUieJg8pMDKddQX7XVffZghSpys5Ig6GDYJevAmtsi2ocBVHu6RG+/ZKpL9+omwBypTrvSGQR8xa7WKSE5Tt0jtUKYLrRWqxefMiqcXUqNq4PEuaTWdbGUllrNY7j2XSjR8H6uRF40c3yH1eYuTYJofrlA6r0jomQmyYPGoySwKMf4LiNox6SjD0vnqo6zq+w6JB2E4nzlwkxYBnIqSdHQ8CPSH4l3Y8E9VEdGmQkeJf+l3edE+qrXFzH+MZaAJvrMT0hhpCEIN0dO2xHPy9XJZLS9KedLFoR1aFIF8Btlx7fHzhs5SHLFxXPz1vNL/DhqwN3kgYuxvPd42noNhd260cp0ov5idppGTP51fE6niXoDMcj33RAVA3YKonU6mG9s8I7zj+aJ/EFrki+NNKF5eRmixs69ueiKvCqA62i4nuZJWUw4Ov7w8wwdxJzZueWcmY3E3E+Avek2jOjPextqhwrHLA4+hrzPjOUWYypWSiarQPsLEd6EzmcPjM2IcOpIzeg9svMnxZZFunrDQ60wNy9XHMuDBJTTLKP61AycQbA/6VGLz4uvf4h3N4XtDRCjLWQY89LUQG+fe/ES+x+2f+XnkiodyuVbF+nwvWM5gswRy7qTRRG4YgA7+YVIkOnqbWrmgIU8Wn9nGXjRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39830400003)(376002)(366004)(136003)(346002)(230922051799003)(451199024)(186009)(1800799009)(31696002)(2616005)(53546011)(26005)(66946007)(66556008)(66476007)(110136005)(966005)(86362001)(478600001)(38100700002)(83380400001)(42186006)(2906002)(4326008)(8936002)(8676002)(36756003)(44832011)(316002)(5660300002)(41300700001)(31686004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0VoRkZ3QlN2eklsMVd6dHdkblQ0TzNMeGg3ZTcrZTFGRWRmb2kwTlJ4c2lh?=
 =?utf-8?B?QkJDelV6M2FhRHI2a1FwbzdFUTFRRlQwOC9MQmV6Ym1ydGQ3cDNjWkZoalo2?=
 =?utf-8?B?WlRLSEhoVkVucmErc1lxRkQ2VkhEbVpRNVIrU0E1WFRIMTRGcFJaTFA5bjlZ?=
 =?utf-8?B?cSs4NzRNRkU5djExUk5rK295UWJLMzQvc2NhWDg1NFcxbllMY2R2dzJUZGsv?=
 =?utf-8?B?RmxaeHlBZklhem5OaGhzL3lVYWRuOWc4bWoyYUdRTjhGSGJzT2hzMjJNYity?=
 =?utf-8?B?VEluWDQ1bVRiYmtaYVV5akoyYmlGUGxlVmcraVZtTFdEOHJUZ2FyWUlrSjFU?=
 =?utf-8?B?ZzFPeXk2a2VScU9RNXRMbUhhbVNib1B3Q3BiM0lKTlpBV3lhbktFR2pVOGpl?=
 =?utf-8?B?alNnS3RxbE9hNUVRKy9NTUx4Qi9RWGpSamZ3dVNIZ3NaNm5ZaHJwSS9takZh?=
 =?utf-8?B?c0dWa2xNcURoMEEwQlJleXNqSENaeU9IR3lSb0tIT3JmL3lVSStJY09xTy9R?=
 =?utf-8?B?bURqQmNlWHFKTlhlcWJFMUg2RFBJVFp3cDhDVWZyVitVZ2F6STVadDYxWnVN?=
 =?utf-8?B?Q281M3g5U3JXM2hGMGhROTZqYjZKK3lJNWtCM0tuSFdPVDJnTEVBYThndEZ1?=
 =?utf-8?B?R0xCa0p3NzA2OStKUjBxcnBwaGxOSUZVWU1mYUh3ZmZCZ2h4Nm5SRStaRFk3?=
 =?utf-8?B?TFIyYzJxMGMwdHdiSmd2OUNOS2x1aXN0Tld4UjNaT3kzZGlIK2EzaXJnVXZz?=
 =?utf-8?B?Z01iRDBsUmlMTExRMHpxajhxTEJjQ2Z3R3ZjTDlFTlowN1FwL2lmRnBRNTlT?=
 =?utf-8?B?NEVaVDBqVVdaeU5kZnZ1RFA4aXJQSUhxTGdwNUdaMnlXc2p1NkN4ZFhjUlZt?=
 =?utf-8?B?N2ZSWmUrUzIvUEtLR2NJbjlnZXBHOFIxck14OEtCK3k0R01kbFd2TkU0VEls?=
 =?utf-8?B?ZzVzbmN2NzZDbDlTWjlaNWI4Wi8zT1FNWTdIMzBPM2czcUIvSm1LZStrLzJC?=
 =?utf-8?B?blo4czdVRFdrQkxzSmJTWG1OQ0VLOGZ0dGJlYlNZUjhxYkdqTlR5cG11bjdR?=
 =?utf-8?B?dWMvaEp2M2tyUUdiTkwzaXl2cVFBTHBMKzYvamhUL3JVZlJmaWFmWGlDc1d0?=
 =?utf-8?B?eHgzVStKZGpJeHErWDRWeE0wd2FSa3ZyVnVWWDJMYjBLVkpqU1lSYzBSSEhL?=
 =?utf-8?B?aXNFbWtLTlM4ZWxIVm5mMnNMWml5bnJsRjNDaTlSaW9aZTFEQXErcWRLV0hE?=
 =?utf-8?B?Rk5SVmMzdVJ4MmluSTQ2OW1Pc1I4NXkxNEVDSk5VZUpPeHhYZVFGcHByWldy?=
 =?utf-8?B?YUdyeG44WmovTllRYVY4MGJGREQ0SEZ2UFoxV3crRUFPbXV1T054UWdFNEdO?=
 =?utf-8?B?di9GV3N1cWhaSVBvdTE3WVFmUEJiQ002L2R6cU5XWEdpY1hkVW55a3FCMHBV?=
 =?utf-8?B?bXRab0pkRGRjR2xIdVVIVUxNZmJBeDY5b0xhcUw4N1FESVkrVmlsWVdZLzls?=
 =?utf-8?B?bjZFeGN1RW5sclRqUjZZVEZ6ZkZQSnpaaVJPejBmSlY3MnZmMndBQ3laWHJU?=
 =?utf-8?B?a2ZrK3RyNGlNV3JFUkpJb20wZG1DWTkyZ042SnZKS0ZEdFJTbjNmUEF1TUtm?=
 =?utf-8?B?TGFBRkYzZWFTMEgvT29IT2M3N1hrK3NreUNWRlc2WFVNWUM5c1FMelRsdDha?=
 =?utf-8?B?SGFUdGliQzU3dENGRnVsT0d1VkdYUzBoN1RVUlNrQU1FcEh5MXVWNDlpeW1n?=
 =?utf-8?B?TmI3OWdHZXQ1aUR4Vk9wSjB4OW92dnY3Y1N6WGY1ak1XRnloY2s2ZFBDMzQ5?=
 =?utf-8?B?azI4dWo1ckdGMGs1eDJzbFlsVVoxRmovTStvQ3BHRVhCWmg4bFN5ZjMwTFBw?=
 =?utf-8?B?RmJpNkhMUFVhZlZSdUdleG41OFJlTVVtMGxsQS9VM25IMHRxYzJBb1lmWS91?=
 =?utf-8?B?eXVRdTdTcGVoM1pPQlc1TmtyYTE5d0RYQmlwRWpHVWJwQjBwVmRxUkM5RFVm?=
 =?utf-8?B?UWNWR1c3amtEeU1FRVVHZ2FDRlNSaW15ZjdwbXo3QzVtOXN0OHk5dlYvenBw?=
 =?utf-8?B?M1ZBaDI5STFCcXg0QXVWdjZWMkdGV2ZMYzU3WTJON08xcE5JRzVpWnpDSkRq?=
 =?utf-8?Q?PJxwh/8m5VOW9PWxqGtlGrRRy?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a828feb-ed6d-4be0-5855-08dbbd5f919f
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 00:37:16.9295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x92NEZnSiTiwTifKVDgqQ+9iu4CU6aRs0UurViAoF5wznEZbDlxnDGB9nsaU27oKYYVAXPNhZ1ZqWEB2SP9qzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2136
X-TM-AS-ERS: 104.47.7.173-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-27896.003
X-TMASE-Result: 10--11.593000-4.000000
X-TMASE-MatchedRID: QW5G6BKkLTpTzAVQ78TKJRhvdi92BBAu8kOnQJj3cxLe8mZKcCNkECNM
 mGp3FK34wQ2EZI5U5bnEXTNCz6552tvUNTm/lfkG1+xHsA1Rr18GeeqwPLUlmz4mDuxB3Odo7PK
 GnCHkqfWjAHMlDa5GPUfvSokBgSLMpMObW2ktjYslQx76zly9o9jZrAgOUOa6oyE9UyehSowR1r
 mjXxpsxtht0XgqhO5YD2X7+UYhxPecnJk04K/aKroLCoN4YJzMcnxszfxH2Cl7wQPQv9Xohb+mY
 ZVOIbiG2HlzhM3zNtnRKDuafjrn+S1i3WRyj1AdOfEmq6feyfNuRXh7bFKB7vRoJtYyAqlon01c
 C0MBSoyjbdsg123qsfmrXFS4xS+oxYVzI3UCCaY=
X-TMASE-XGENCLOUD: 4bfc1d1f-d3d7-448d-95ec-a3ba23ba5750-0-0-200-0
X-TM-Deliver-Signature: 6E5F488B3FC6A24E77B416CB6EE7AFB8
X-TM-Addin-Auth: ozqAe0WaZxrbwy0SdGE4F/VDKTlbN656OgJBqLx3h8a7vLmyAAPDviQb++b
 MN6o6zjD0ikHqvEcDFkoCCZ99FBZ7o5t8rqnjhkFsiCRKhAwPOmC1F6+x4LJzusfrkm1cto7Y9L
 YKoQL4LhoBQ4pUpJQq8wtD7IZ992+cMqmdt+6sYshbj2Oi/63Rt2Qv920gfERN6WrEIU2oWQ/V5
 X3cK2WX6eTCfuxVpW8oNh0SaInQRtwdzCzEEMy9gYNKkSLQkqH0QSDSQFFseNWR1iEXrkY8j3ZW
 TrEu5/mfAHQE5yU=.Q4pnoXc5IhAc0mGvaIssu3Lf28Bgf8aknuoz2vA7/6HeY+SsmaNPCkUtoW
 uAihzcC4OQ4ZhlZv0d40NGPhRSqJhi1yjwBPXLbupE3Tg7sQ7Exkh6UUIPpsstWwQj/3dXonyDU
 tHyLt03v406gBjnjnCYigkySXIjQ62mL4QP5L07aXZq4J6LMEWvQph/4RbiKPh462S+JS72mwYI
 xZ+TWCZHJuE74ItstFCyeCWPV6sNuv2kUIyNxF/flDwXbeycvgfvUa+VrzSufd5MIv2q0S4LbJG
 9wLEnYQSeeEVP0+7zkKitaL3gm9v5Vca1CC3KEd4AH/xO2ymXA+8SPY8CFw==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
 s=TM-DKIM-20210503141657; t=1695602239;
 bh=I/7/irM7WhvRbbokChBMHBMM6LgcuhpjIN72KL8V77s=; l=1488;
 h=Date:To:From;
 b=OR9QegKkCIcJ1ia88rCuZaFtWgiu+QwXdaBNUe/LCQGoeFqGFnPHaaixjxSyDjWjO
 eoIe24OCS1sNz1PmimZ0z5353+7lZNvEb6km3ApRCTOCtCa7v2bwk9qLcB8HONqBjk
 DQjgw6yPSo50Ut4kdAyotHA5TthZgdAnnW3rVSgaDq4HvJUqvRtSoOK7iZaqQbQ50b
 VjYqqBnKg1EyAoJ5cTq7d16ofgn6FtujlEs0tzIVhn7ttHGqgQNZSD2G3KCCJ2FDE3
 3qNugLIBNyjpjXHc77iuxt3CP0wPaPEEHuO4AgVV2ufsfFFz1717xXoj45mFVL91Hq
 KdQAEpPMTr8Zg==
Cc: virtio-comment@lists.oasis-open.org, mst@redhat.com,
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

Hello Stefan,

On 20.09.2023 00:10, Stefan Hajnoczi wrote:

>> As an aside, here are two other statements that have a similar issue:
>>
>> - 2.6.1.1.2 "the driver MAY release any resource associated with that
>> virtqueue" (instead 2.6.1.1.1 should have something like "After a queue has
>> been reset by the driver, the device MUST NOT access any resource associated
>> with a virtqueue").
>>
>> - 2.7.5.1 "[the device] MAY do so for debugging or diagnostic purposes"
>> (this is not normative and can be just "may")
> 
> The spec should not make an exception for virtio-sound because the
> virtqueue model was not intended as a shared memory mechanism. Allowing
> it would prevent message-passing implementations of virtqueues.
> 
> Instead the device should use Shared Memory Regions:
> https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-10200010
> 
> BTW, the virtio-sound spec already has VIRTIO_SND_PCM_F_SHMEM_HOST and
> VIRTIO_SND_PCM_F_SHMEM_GUEST bits reserved but they currently have no
> meaning. I wonder what that was intended for?

In the original version of the design it was proposed to use shared memory for
the buffer. But since not all architectures allow the use of shared memory, it
was decided to make message-passing the basis. For shared memory, stream
features were reserved for further work on the spec.


-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
