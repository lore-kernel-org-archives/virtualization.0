Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE8BCE7A91
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 00:25:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F395540527;
	Mon, 25 Sep 2023 00:25:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F395540527
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.a=rsa-sha256 header.s=TM-DKIM-20210503141657 header.b=Q68xwVJM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QNJb-dXfdAvi; Mon, 25 Sep 2023 00:25:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 42EB74012A;
	Mon, 25 Sep 2023 00:25:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 42EB74012A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25C4BC0039;
	Mon, 25 Sep 2023 00:25:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A375EC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 00:25:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8207240953
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 00:25:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8207240953
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com
 header.a=rsa-sha256 header.s=TM-DKIM-20210503141657 header.b=Q68xwVJM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m4nZXBJ8_-FB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 00:25:12 +0000 (UTC)
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu
 [18.185.115.117])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9E4C94093E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 00:25:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9E4C94093E
Received: from 104.47.11.174_.trendmicro.com (unknown [172.21.196.113])
 by repost01.tmes.trendmicro.eu (Postfix) with SMTP id EAC86100004DE;
 Mon, 25 Sep 2023 00:25:08 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1695601508.367000
X-TM-MAIL-UUID: 650678cc-a111-4603-8a24-128a39dc3230
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown
 [104.47.11.174])
 by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id
 59ABF10000FEE; Mon, 25 Sep 2023 00:25:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfdGdPNQ4FWvSNMGXqJ0AmF8uQh49dOFe7NUgGYsHGOLlV6ocK59u3zpyC2h3sHY3ct9ciA27z9DrYl12FrZccQ6lDIGZXCPvPDtKHV6g79AemgBV/AD93mGQ9LHB3xrGE9CZ1WHKijfNJztwpkbcD4m0Ia5BwSBc8HKCd75D3QD4bOQ8Ff/iRrSHIuVvUZYlR1SW8zHki1rfBGUj44ZN6k/gLPngCQ3p+m1bo6FjFsIWn+ATz1xwmenyn40nIkTlfDBjfQqMzO2yz2wSMbSCCFu7s/IeNcEKHO2B5/Hvm+mrXmCTJGhvTuUqiC1fgTwGbWeSkP++oaOm9gLgqMY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/CLKW8tfMQ6xuuop6oPlO7j97KqejHYruWpolQ0T6k=;
 b=R9+k1XTm1/ELWSLRAgOnvrJZBanSk7dc+QttFaYvmtMw63AkfAS0dTqgu110ysNZk+8cfU8AMiZc+PGlAouAH9X9gX1p2SCNsavtYzSSqhJUmUFjS9dfdU/Er5bwPudcEesiOOkAgTjvm5A6YcpACIitShGV+e/owUPEYe7I3c5SgwJxQC8BTfKUFjLtUPMcZPLaeXg9aAhFXmZagdRylV4rQUBYYSjcBvsY9p7FZqgLnCtHTx26qQAAgfWA5jQmL2YxJCUNVpjJg1K2BubjcDvz9EJwdFow++OnEzcuhw6nlyCljP8a+QyQFB+mAecuavHt8wDg3V97867FyM1dcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <21cc7c6f-354a-4459-9dac-2a22a508e93b@opensynergy.com>
Date: Mon, 25 Sep 2023 09:24:51 +0900
Subject: Re: [virtio-comment] Re: virtio-sound linux driver conformance to spec
To: Paolo Bonzini <pbonzini@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <ZQHPeD0fds9sYzHO@pc-79.home>
 <ed568bcf-0fc0-40f5-9cb3-14c2923f8bf7@opensynergy.com>
 <64adaae1-28a6-b175-9fb0-f4f2c26e696e@redhat.com>
Content-Language: en-US
In-Reply-To: <64adaae1-28a6-b175-9fb0-f4f2c26e696e@redhat.com>
X-ClientProxiedBy: OSAPR01CA0251.jpnprd01.prod.outlook.com
 (2603:1096:604:29::23) To BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:5c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2374:EE_|BE1P281MB3366:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cfdc0b8-e749-4396-ef36-08dbbd5ddea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f7QR7fkJVRONDnPf5ivn1kPeZxO5Ra4wBCM4RtfY5rQ3iHhbT7JMhYIihfKIZCTH7xNKj54dBVtvzRA/tF9x5JzBPbyw119ByX6cqpfaHRBZBpnJj9ygwg0vc5iSr6wxLvWYg7Fs2w00lqv4JtmCNWws9YLzHMhZ1Ml2we4/l7nTbwlD8oH3cn9kzu4DPATUDtk1/0vVa8TKWNlOXDZ6YhXTN2gf/ZX7Amyiff+zL1TVm1XZ0wUqBU2Ho4NkIpN7yyotKsuolhpmLKjS+1bzDwwMsg8Qg0yrGCLlGQ4hyDwVJXUmT6Uf6VtiTkfU8g4sXNztwGQ/zFb9xhIzukJBsSZ2AnFZfiyDa744OBMx8q6ebkkn4nyCLYtZ3+mOLgmKPBa3zb7/kbbGpbic6KGw70rEzAi8v018yHhyNG04ShgI7mh3YV6oaiVW0dawuZyxnCVysqEhxcW9A0WxCymY1Me7Ob1SDK3cJeRBGcrxbsi2pPY7bhd/GmMDo7/gB9ksQ980LRlemm4SB4kjbns1BAYJHXu5SP6X2krRiYb95C6I/oTsiixXEcecyKSwQbZHDfI4EPMdmj2sFQdX7g9fPtG7Hu4mB6lldLeaeCBPJgZfQGKiTJ5Y9nDUx7Ok0sE0EGW09xVXPZSup6ZyTbCZWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(376002)(346002)(39830400003)(396003)(230922051799003)(1800799009)(186009)(451199024)(66899024)(83380400001)(26005)(8936002)(8676002)(4326008)(478600001)(5660300002)(66476007)(41300700001)(42186006)(66556008)(66946007)(110136005)(316002)(53546011)(2616005)(2906002)(44832011)(36756003)(38100700002)(86362001)(31696002)(31686004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2pPbW1VY2lyTzcvRU1JY0Z5MjhkTzN5dmc2NXRGSWNmQ0VpdWNzc01QdWxS?=
 =?utf-8?B?eEJwSmFIZVBIVU9Vb2RaWktwRE55czBrd0c1NEcyREwyUjNXQWNKRjh5dmw0?=
 =?utf-8?B?OTZPSnU5YkJKSHFiOFEzU0Z5VXlwQW5sNEQybUVjd0xxOHpmcXV2bkNpZFpL?=
 =?utf-8?B?eUJhUGNwdEF0QUV5bGFoendlQUc1bnd6YVNJaEdnanpqNE9KWk8yUTUrWVRt?=
 =?utf-8?B?eitWcXZMNVpTeDlFcU94WWttWW5HYVVhdzAvdnZPRXl6TnJlclplU2NOdHpz?=
 =?utf-8?B?cUowMTcvbUNDWXExZDhCS1pZczcyeGtGS25WTGRDTWV4cWE4aWJXRWZ0cmNk?=
 =?utf-8?B?a0pYRU5JanZBdzJhbHFWNjJYMUdXbnpXaVYwM0NlMWdSMXNFcHZYZlBjUlJy?=
 =?utf-8?B?NlZBSWQ4NVBzZ0xKTVRIOUJVSnNzaVNDZkxVMWdqeitTQUlMSG5iNlEzV3JB?=
 =?utf-8?B?QVUxMThJSFV1TlZUZ21SbTBqWUYvTWNkMEljWjFyTUdtUFdSQVZ5Sjd1TTVh?=
 =?utf-8?B?aDRNbmZrTGNkdENBZ2VvQVlIOTJRVThBVUFES29TUUJtWEM1V2VlblEvb1NP?=
 =?utf-8?B?UnYwNXhyODUyQ3ZweE9HSkxTWWkvL0cvcjd5dUdvQ2Jybmk2RGp5NUh0ZHhX?=
 =?utf-8?B?WTNFUnFLa0U2RkZDTFFFSHFjdCtGRlB0TlhOeUU5bTRLMzZjbmx1ekx0U3Qv?=
 =?utf-8?B?bGZsOU9BODVxclk2MjBNb2tXWmpPTFNBQ3lrZ0lOWXZ2MzBUTFpiM21KNnln?=
 =?utf-8?B?Qy9GUk0xN0VHbU1oeHV3VmczS1gwUk9kWlJXNnpLWi9oWENMY2p4dVZpQXgy?=
 =?utf-8?B?ZEd1czZoMTFnS3NXU3g3NkdwTFNUODVwYVJIUWFnN1ROTFRJN1Zsbk5ud0R6?=
 =?utf-8?B?Q3lma1RFbHQ5NWNwRklNZDBIUlNGQkxBVlhIMXpHL1pyZkxoMDRxMXRxdHZW?=
 =?utf-8?B?cEJBOWdxSitXdWJjWnhhMGlQbkp6MXFMaElBTnZJSWtzeGN0OWxQaTdXZEFl?=
 =?utf-8?B?V04vRTBJd04xRW0zVWh2UytTY09VV3RTVWZidC9YM2ZLSkJSNlM4Q3VxRDh0?=
 =?utf-8?B?RzhLbm5sNlVka2taTHRvU3MxZGVSbEV5ZE9LSzdkMGp4NjVqTnF0QVlNR3Bs?=
 =?utf-8?B?WHdId2p6bWxlTFMyUXJsUTEzbnJ5OFBBWWU0RVk1cHBmMW5DRytXTHp0YVgx?=
 =?utf-8?B?TUJoMVlsQStVNWtyQVlMR2ljVlhJRzNmVW44NGUxT25yZGdMSTJkcmE3Y1Nk?=
 =?utf-8?B?RnJUY0RISG56QzV2ZnZLTnRFSElTYUhPTjRyVkVRNG9mRXQ0eW1CRjNZeEpt?=
 =?utf-8?B?aGNiRkFieWVON2kwN3BodnNYd0ZVejVkc2pYNGVsR3U2aEVvTVM0M05oTHBx?=
 =?utf-8?B?aTQ3K2EvdGRaeFc1eTJlTkdyRGxIVWxMRWdMOUYzb290encvOThiNWdwWVJr?=
 =?utf-8?B?d3lLZmk1VHhidjdqV0cvejF4Y21Fczk4NVhFYlI3OTlwRmNaMXVBLytqanhu?=
 =?utf-8?B?RU1sS1JsdkV0bWFDbjQ3TDZJVjV3bStNTDA4aEc2Mmpua2pHK3QrVW1GN0to?=
 =?utf-8?B?cStycjQ1VGlvb0FrMGNwRXdLRTQ0cWlEOTJIeG1JZERoUjVUVVRZRCtSNEhQ?=
 =?utf-8?B?VzlvUmhaa1ErMFMrL1BkY0MxK3FjTVFhdDNrZ25OVXF5MEUra3QzNGNwVis1?=
 =?utf-8?B?TTc5eEd5RFk1WXF6QVlwUXYzWWJleVZNQm9UdmEwekhlMmw2QUIwdzJlSG8x?=
 =?utf-8?B?V3NDQnV0VWp0M1JTTy9GaTEyZkxQV1lGZytvL3Rkd1M5ZndQRkVJRlhabXk2?=
 =?utf-8?B?MnpYYk5oZkh3MjZaZEd1eVczMVp5RHpPMHhGNEhvc1RkeE1GWFJ3TTdycXpI?=
 =?utf-8?B?clpmK2pYRDZHZzRsSFUyR1p2RWtvUFN6QWNvZStBWk5kRVVsRTIzT0U3L1Z0?=
 =?utf-8?B?WTBEUGcyN1JQeVQ1Zy8wNmlZVjQ3dFg0RHFiNEV4THFSZmFWN3JkOGt2cVZk?=
 =?utf-8?B?MkJyWWFXVnNKcWZVdU50bDF6SS9ZN0JKc3dVQ2JlRGV2NVNXQ1cyOGc1Nlhy?=
 =?utf-8?B?cWZhaWl1eU96VThBc0l5cytMVElnei9Md244WnZLcnlTMDNwK0hVNXc4WUJa?=
 =?utf-8?Q?w958pKT4s31H+lQB//KlvYzJX?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfdc0b8-e749-4396-ef36-08dbbd5ddea4
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 00:25:06.9163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MU+Xe6W9hDAhcHSh0FfiMiWjJGQl6szRzcRsyHglkUQ+29DDi4d6sPNABTNDvMtB3cHuwCVPntEwV9mwvb6VtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB3366
X-TM-AS-ERS: 104.47.11.174-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-27896.003
X-TMASE-Result: 10--15.488100-4.000000
X-TMASE-MatchedRID: QW5G6BKkLTpTzAVQ78TKJRhvdi92BBAunsSRXdX/K/upaB8gxaWhLBJN
 p8VqK3DUjoqUMwOP8I//aUWAnMYE99ZSVIh2F3SJsX4aFYAMIYPgOJe9wsMrCyPITZZ5o4jdBd9
 cDOU3ObtHZIkEgyioAyJlmC4fDnDL/n96ZiEWnKEKonRFsndtvVhAFa9hyLt2Rce5V4FdldL5MY
 wc3O3DEzMT9I6+f7kjbHROBy5a/VAIa1AAvOTG7boLCoN4YJzMcnxszfxH2Ckmx8kl1Wnd+q+eC
 SMeOiOkA/lH/MvdoiYmkrgX3CciJmLK5A5md0r9ulxMqwyzVlH6CxJ5baM0J7Q+ZtzqD3t+tOyI
 w102fV+DELOt7v6nZQrQFCLISu/LsBTJSD2iAW0=
X-TMASE-XGENCLOUD: e96cdd72-99bd-4453-8c92-ac689c8eb9b1-0-0-200-0
X-TM-Deliver-Signature: 6CBDABB467CF33E34027CFD0556CD89D
X-TM-Addin-Auth: +Xur9xWvcK9l34WHupSqaCGzbCFGY74zIER9ELXw0FU7HiakInaDhBpmslw
 k50/ejzhkIkxGi5sMsqdPhm3omt8yk9c2eJnKhQhSTCOFCHEZbaSlFGYjwYA6GzMr1x9BVI60s3
 U0xQKLZQQwiQeF3B92tyhaghWbM1fPAEO9d9hdJugm/AmdkDMefVS1/rmbPU9XuRo2+5IEYsleQ
 W/FlZFEVzY/DpA4ggYv1kZ3sCFAOmnT7zdVorSEV44nfwCqU1BCnCOuVU1CdGvYel2OTlulq3/f
 /LtUYzC4J35GCVw=.YoWtC1CqFHf/SFyREggxdTDhd44zD0SVjT8SieAuV949E2dU+q+xTz/jzQ
 Iyzx0BNP1cGwP0JhbIPy8hU6GdUG4RCt2OFGCZdmMiQOEBo/TfFioi+irH0wsRnvj4rbNaJVBnb
 bwqCsC0LSu0AZ5wgnpPuMK+hsSTDI1C79z4dVSv0s/wgkfOpZiNdxFSLBrebI9lj1NNll1CQ8kO
 OlALDJgt+iLbSv+zySA5ws2X5tT3rl9jYLjU+ABRerDG5qr4lixG9ifQAm5Kf9Ikf31t0xT037i
 Xp4f1xpdBrk3HcqPg521JcuzKUrzoBp2ceXnxy9fiKGAU/rloq3Umz5P5oQ==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
 s=TM-DKIM-20210503141657; t=1695601508;
 bh=5bLYJ0YD3qMkpEKJ/70EJZRm6x69TFw20ob7lIebXoo=; l=2356;
 h=Date:To:From;
 b=Q68xwVJM8O3q0cwLWRTU08aspu/vcEt66icV5nSSODxQJeEypfYFoLgbFvmsNDhfe
 F7oWihydCDSFudNtrWKyTC/4STCOpgyxXYbwDbWhRNeWtNRVY8dtdLkjKmA6VHpAc6
 YxaFbRyTWI9pY5f6MZeZjFlrvsOQxerfhfpkgvbxhTkCMkwqXY4XKJRmnm+kCV54p5
 7FSQvYzt3587gEd6v5dMiLBkHsCkDsEJbOc0rPNhjRbpJUABxaGRdtvshLpyVx63Hf
 RBnbtMNjoBDGUJSuUf1sGRQQbiPJltAcLa1NrRsGnV/6Wf1/BAnsiVxeZlNy4TkE1e
 q6DnTKH5TCfIw==
Cc: mst@redhat.com, stefanha@redhat.com, virtio-comment@lists.oasis-open.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SGVsbG8gUGFvbG8sCgpPbiAxOS4wOS4yMDIzIDE1OjU4LCBQYW9sbyBCb256aW5pIHdyb3RlOgo+
IE9uIDkvMTkvMjMgMDI6MzUsIEFudG9uIFlha292bGV2IHdyb3RlOgo+Pgo+PiBJZiB0aGUgTGlu
dXggdmlydGlvIHNvdW5kIGRyaXZlciB2aW9sYXRlcyBhIHNwZWNpZmljYXRpb24sIHRoZW4gdGhl
cmUgbXVzdCBiZQo+PiBhIGNvbmZvcm1hbmNlIHN0YXRlbWVudCB0aGF0IHRoZSBkcml2ZXIgZG9l
cyBub3QgZm9sbG93LiBBcyBmYXIgYXMgSSBrbm93LAo+PiB0aGVyZSBpcyBubyBzdWNoIHRoaW5n
IGF0IHRoZSBtb21lbnQuCj4gCj4gVGhlcmUgaXMgb25lIGluIDIuNy4xMy4zOiAiVGhlIGRldmlj
ZSBNQVkgYWNjZXNzIHRoZSBkZXNjcmlwdG9yIGNoYWlucyB0aGUgCj4gZHJpdmVyIGNyZWF0ZWQg
YW5kIHRoZSBtZW1vcnkgdGhleSByZWZlciB0byBpbW1lZGlhdGVseSIKPiAKPiBBbmQgbGlrZXdp
c2UgZm9yIHBhY2tlZCB2aXJ0cXVldWVzIGluIDIuOC4yMS4xOiAiVGhlIGRldmljZSBNQVkgYWNj
ZXNzIHRoZSAKPiBkZXNjcmlwdG9yIGFuZCBhbnkgZm9sbG93aW5nIGRlc2NyaXB0b3JzIHRoZSBk
cml2ZXIgY3JlYXRlZCBhbmQgdGhlIG1lbW9yeSAKPiB0aGV5IHJlZmVyIHRvIGltbWVkaWF0ZWx5
Igo+IAo+IEkgdGhpbmsgaXQncyBhIG1pc3Rha2UgdG8gdXNlIE1BWSBoZXJlLCBhcyBvcHBvc2Vk
IHRvICJtYXkiLsKgIFRoaXMgaXMgbm90IGFuIAo+IG9wdGlvbmFsIGZlYXR1cmUsIGl0J3MgYSBN
VVNUIE5PVCByZXF1aXJlbWVudCBvbiB0aGUgZHJpdmVyJ3MgcGFydCB0aGF0IHNob3VsZCAKPiBi
ZSBpbiAyLjcuMTMuMy4xIGFuZCAyLjguMjEuMS4xLgo+IAo+IFRoaXMgZG9lcyBub3QgcHJldmVu
dCB0aGUgdmlydGlvLXNuZCBzcGVjIGZyb20gb3ZlcnJpZGluZyB0aGlzLsKgIElmIGFuIAo+IG92
ZXJyaWRlIGlzIGRlc2lyYWJsZSAoZm9yIGV4YW1wbGUgYmVjYXVzZSBvdGhlciBoYXJkd2FyZSBi
ZWhhdmVzIGxpa2UgdGhpcyksIAo+IHRoZXJlIHNob3VsZCBiZSBhIHByb3Zpc2lvbiBpbiAyLjcu
MTMuMy4xIGFuZCAyLjguMjEuMS4xLsKgIEZvciBleGFtcGxlOgo+IAo+IDIuNy4xMy4zLjEgVW5s
ZXNzIHRoZSBkZXZpY2Ugc3BlY2lmaWNhdGlvbiBzcGVjaWZpZXMgb3RoZXJ3aXNlLCB0aGUgZHJp
dmVyIAo+IE1VU1QgTk9UIHdyaXRlIHRvIHRoZSBkZXNjcmlwdG9yIGNoYWlucyBhbmQgdGhlIG1l
bW9yeSB0aGV5IHJlZmVyIHRvLCBiZXR3ZWVuIAo+IHRoZSAvaWR4LyB1cGRhdGUgYW5kIHRoZSB0
aW1lIHRoZSBkZXZpY2UgcGxhY2VzIHRoZSBkcml2ZXIgb24gdGhlIHVzZWQgcmluZy4KPiAKPiAy
LjguMjEuMS4xICJVbmxlc3MgdGhlIGRldmljZSBzcGVjaWZpY2F0aW9uIHNwZWNpZmllcyBvdGhl
cndpc2UsIHRoZSBkcml2ZXIgCj4gTVVTVCBOT1Qgd3JpdGUgdG8gdGhlIGRlc2NyaXB0b3IsIHRv
IGFueSBmb2xsb3dpbmcgZGVzY3JpcHRvcnMgdGhlIGRyaXZlciAKPiBjcmVhdGVkLCBub3IgdG8g
dGhlIG1lbW9yeSB0aGUgcmVmZXIgdG8sIGJldHdlZW4gdGhlIC9mbGFncy8gdXBkYXRlIGFuZCB0
aGUgCj4gdGltZSB0aGUgZGV2aWNlIHBsYWNlcyB0aGUgZHJpdmVyIG9uIHRoZSB1c2VkIHJpbmcu
Cj4gCj4gCj4gSW4gdGhlIHZpcnRpby1zbmQgdGhlcmUgd291bGQgYmUgYSBub3JtYXRpdmUgc3Rh
dGVtZW50IGxpa2UKPiAKPiA1LjE0LjYuOC4xLjHCoCBUaGUgZGV2aWNlIE1VU1QgTk9UIHJlYWQg
ZnJvbSBhdmFpbGFibGUgZGV2aWNlLXJlYWRhYmxlIGJ1ZmZlcnMgCj4gYmV5b25kIHRoZSBmaXJz
dCBidWZmZXJfYnl0ZXMgLyBwZXJpb2RfYnl0ZXMgcGVyaW9kcy4KPiAKPiA1LjE0LjYuOC4xLjLC
oCBUaGUgZHJpdmVyIE1BWSB3cml0ZSB0byBkZXZpY2UtcmVhZGFibGUgYnVmZmVycyBiZXlvbmQg
dGhlIGZpcnN0IAo+IGJ1ZmZlcl9ieXRlcyAvIHBlcmlvZF9ieXRlcyBwZXJpb2RzLCBldmVuIGFm
dGVyIG9mZmVyaW5nIHRoZW0gdG8gdGhlIGRldmljZS4KClRoYW5rcyBmb3IgcG9pbnRpbmcgdGhp
cyBvdXQuCgpZZXMsIGl0IGxvb2tzIGxpa2UgdGhlIGRyaXZlciBkb2VzIG5vdCBzdHJpY3RseSBm
b2xsb3cgdGhlIHNwZWNpZmljYXRpb24uIEJ1dAppbiB0aGlzIGNhc2UgaXQncyBhIG1hdHRlciBv
ZiBkcml2ZXIgaW1wbGVtZW50YXRpb24gaW4gdGhlIExpbnV4IGtlcm5lbCwgc28gSQpkb27igJl0
IHRoaW5rIHRoZXJlIGlzIGEgbmVlZCB0byBjaGFuZ2UgdGhlIHNwZWMuCgoKLS0gCkFudG9uIFlh
a292bGV2ClNlbmlvciBTb2Z0d2FyZSBFbmdpbmVlcgoKT3BlblN5bmVyZ3kgR21iSApSb3RoZXJz
dHIuIDIwLCAxMDI0NSBCZXJsaW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
