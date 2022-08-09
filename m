Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B5DC19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 21:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D043160E33;
	Tue,  9 Aug 2022 21:26:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D043160E33
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.a=rsa-sha256 header.s=TM-DKIM-20210503141657 header.b=QtRmOivv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SwPy7FpoEpMp; Tue,  9 Aug 2022 21:26:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 40A2D60DFF;
	Tue,  9 Aug 2022 21:26:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 40A2D60DFF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BD15C0032;
	Tue,  9 Aug 2022 21:26:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD539C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:26:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 80C0A60E2C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:26:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 80C0A60E2C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DximRsxaoOYq
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:26:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A18C460DFF
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu
 [18.185.115.25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A18C460DFF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:26:17 +0000 (UTC)
Received: from 104.47.18.109_.trendmicro.com (unknown [172.21.188.236])
 by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 040B410000649
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:26:15 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1660080374.341000
X-TM-MAIL-UUID: c3bafacb-2f95-4ae0-9d21-80c3c37f1ec1
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown
 [104.47.18.109])
 by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id
 5385D1000031D for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:26:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYb2KY94inMzsx8Hg0vrqdZOMt3bEKm2oCx+xH0+0uSG/hN7wlu6bJjWu7qYnD6k7Twaj2bgKyBJrByo/D7ow9vHmdWZYJmSKm2BzW18XBtO7FzILFEG3DkUGPa9ZCmP3p+H+38X25lXCmBGDRkCSFtHG3hHIYQkaJNeaqiL0fBOP1uPPYvKjcsawU8yo3iZ4cU7vWElMYGV5DWqeQzsaPhsrxIxMVEPxSPwfH5RytCNB1BRiZO2aru+EaRHLpuFGgaFSQhll+a1ABoJUfhZ++jes5oHCt5DTO3y0k/9dkf3SxCdV4UNd/rfLqHMAtgxOucuz53Rrri/rsVoDxO2Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBDxlgKocI8tcD/ZHqdfhPXbBqJxHqGODZFb8lzauxQ=;
 b=gupg2iTIBou/rjtvq2c07yxx/vmt9ZMCYrBwkRhlo4K9aWBhKW8QOt+dwe7anSwTE/PvFZ9dlqSW7097VFu4PH9USeumzU8T87uKlmjNV+xwsubyES0b2/E/45W44bc127C1hjC0MNsMMqHIEwpv6uGeclmKNWhUyzlenHhavkEHExzz/qhAtb1lmhCliJvBqYMccaO3xOx6c6hrolRUV3QljLVg7DPj8ODj0YI7h30EzjVsae/NsxveELTyJAU70lH3PAvGAjeThqm2LYIlXCVf1MBdql9OhEgT0Uu8AjfjQTVxxhuQ08cKygmcKPvznaEbF13rohJ+xE2p/uQFCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <21beef2b-9199-0db8-49d4-339da8707b8a@opensynergy.com>
Date: Tue, 9 Aug 2022 23:26:05 +0200
Content-Language: en-US
In-Reply-To: <20211125174200.133230-1-mst@redhat.com>
To: virtualization@lists.linux-foundation.org
From: Igor Skalkin <igor.skalkin@opensynergy.com>
Subject: [PATCH] Bluetooth: virtio_bt: fix device removal
X-ClientProxiedBy: AM0PR02CA0220.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::27) To AS8PR04MB8371.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b2::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc3d76fb-87ff-4374-c7d1-08da7a4dc552
X-MS-TrafficTypeDiagnostic: AM0PR04MB4017:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vbrqiE3xaYmR6kC+3W/nc/25rv7lxD+JGBsCH6hc/UNWOP+IZBFk4FijHHhWmlyewElC8mSCn+gpityz+218lMRf63Jf4MmTnFpZeFujeLgvTJco6weiO3kQADUHxatV/Jlj5nQqiQix/L44hh1lJdBXRE6kD3R7j3v7Wo5SHY2H9PjZ8TCoR07FWm2eSj5vObaBEb7Ry1SsJKqMeZcUlT2VrgTw8BKL2S6pKzDWnRfc7m7pGjJ15IJxtWcjnDy/JxwYK35SZNFLCaY+vgGqHektvbhHvh+yvlg2yixfX26SPVlZZuqOEdH5ZXH43QMrbJ8c9fb7301HqnnhxfjQAjfWG/lj9mL3nBe5W7D7k6mV5jB2xXC3z2NTMcQExQeHx/0+Zy/xYv+4Xg2CNIQLABreqby74fUM9UrO6y6fuvCBrB3wn1MmMybxJlaP9J76ap/eJFoIrAFWvWQuoONXDzxfT+/+I/Yxd3cRhe81R/O+1rPrZj3R2JGCgyiI9+ekRS/x7OyYbX9EuCdZfbJm07VyqIld8BFtzbisY/GOPK9z6E34vi1PLJmkfbZWgd47lpWK1sgyuKyJ/ttDiivmTSe8XEZ8wAB/wEeLjXPnaxPvMfh+v6CjdyjeW3nZHSlVujEAY2zD2uOAwW2/U/12/MywVgQcp+gTbMlCs0XJUKbhuahcHURggIf8ocPVVtI0iLluVvNDGx6Jp5S2FX7HQT4nSuCeoWFpRivzxN4CVq8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8371.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(136003)(396003)(376002)(39840400004)(346002)(478600001)(31696002)(41300700001)(36756003)(86362001)(83380400001)(186003)(31686004)(2616005)(42186006)(8676002)(316002)(6916009)(5660300002)(66556008)(66476007)(66946007)(38100700002)(44832011)(8936002)(4744005)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlNjNjduWU5SZG96RmZoTHlmWGt4cmJxT3hRL0JpdVNvUTdwM2d6L2FKdCtD?=
 =?utf-8?B?ZmlETUtQd2FlMGZFaXNZblVaMGFvYS85dmlZMk9mYnB2QTkzSnMrZnBtL0l5?=
 =?utf-8?B?OTVHaWVCbE94L0ZkYURXc0dYVWJyT21EREVFN2preTJyNDlFVXhUV2ZtM0Fp?=
 =?utf-8?B?ZExicFl1Q2RVUlhKL1V3RlB0Zm9YWlA3N3lQTEQyNW9RWVlpOXA3MktudkRI?=
 =?utf-8?B?ZmYwM1BVQjJ6QjJYNjQyUEJRc1RiT3hHOFBPVldHd3FoWDhocXY5aENobUxZ?=
 =?utf-8?B?QUVZVXJXVkhOaXJ2UTk1eU94VXJDK2tvYzFpcCtBZmJvQVlneVo5aC9EN29G?=
 =?utf-8?B?SlRtUDVnVHMxS1puTWRzNTVSdkMyZ2x0WjRta1paSzd4c1lnOE5tZ3Faanhy?=
 =?utf-8?B?SDJhVjg3UDhWaDBHd0RTRHI5ZTBBWGkyQnYyZGF6Ukh6MWI0UmxROTM0RTUx?=
 =?utf-8?B?R2F6Q3NRRnM2L283ejlZN3pxdXZhdXc0b1kyMUhqVEdOUWJwWGswcDBYcFgy?=
 =?utf-8?B?VzZHdG5zNTZJVkNZYXhtZmZwMnplaUpwY0ZQdzhqRFZZbi9Fa1lWL2FFVEE3?=
 =?utf-8?B?bzhaWkpjUFZKVXFVdEpTbjUrc2xubG85ZDErdVhHQk4xelU5VGlRbXEzeVhw?=
 =?utf-8?B?aThPa0x0Z2lHUzRZSk0wMThwdHRmRitYc0M2dzhPb3dINWN5b2s0MHRFRDJl?=
 =?utf-8?B?a3NEajRlMWllbGorY21kZXEzTXZmdXQ5YktiN2xsdlhMbGk5dlJvMlZ4bzhZ?=
 =?utf-8?B?OFBaWDlGVlcxK1RrUXZhU0RXWFJaTEVHR1d5ZHM5TXAyM05HbVluZzdrWmRO?=
 =?utf-8?B?RktORktlRWJJWllJbThtKzNrZ3FISFN6TXVJK3BXYkJaRHpNT1U2NXRLN1lN?=
 =?utf-8?B?MkRHZ1IvdWFBK0hyMkh3ZnNIWkphdExxT21WbE1wMnYxYVNMUURJY1UwWCs5?=
 =?utf-8?B?MnlMOG5Ub3NPblJtVisvL2RhaHc5TFFodmhBeUhKMlZsUmIrYWoraW5pZmt4?=
 =?utf-8?B?dXVod2xGMExZVFFoeXJNd1dVTG9RQlRaaUIraWdaS245YktuaHVhNnpReXZQ?=
 =?utf-8?B?Nk1MakJYR2ZLWWp1OGdHSFlVZkJVZTZob090akRzdnlYMjZ1ems0L2x2YnRE?=
 =?utf-8?B?NisyV3N4TVZwQmsrMm11ckxhcXBJdDd2Zm1adGwwNXQ4QjBsdHZ4MFU0WUps?=
 =?utf-8?B?d3l4NGxSdGM5OEdJYXM4Ni83VzZ1L0tydzhha1JHT0xpUFJBdDlBckdaVHVa?=
 =?utf-8?B?K0l4YkIyUXMyK1I3YXNhQTRoUFFlVWdTSFhGTlVMVW1oRXJBbTk4bmIrUnFX?=
 =?utf-8?B?VUdqcE9JZlhDb2RJMFN6ZUxGVGlsWWVUc1dGeDRiR1dlcVJObGlINWNCSlU5?=
 =?utf-8?B?WVU1QUt4K2xLWXVwVC8zNkhvZzFpWk9XMXM4ZkYwNFlTVzBnZFd4OUs0dTlG?=
 =?utf-8?B?TmhzbEVlUkY1T0xBdjNkWElUc1h6Q3VmZWV1bFNDSXYvdjg1blJwSk42STQw?=
 =?utf-8?B?QklQc3VYTjBrYVM5SEF6bkNVQ2tEaEVwOHEzSEozQjgxQWJQSUlDRXk2U1Vi?=
 =?utf-8?B?cm5TN1FlTWNTVXEvT1E3alMwNjVOWjhveHFqUEFOUXFCcXZPUFdrU2dEcFRL?=
 =?utf-8?B?U2ZrL1RCMm1nZTk0elc4YWwzRlBKbGVCOEpOTlFaaEpoV0lwR2kxTHJHRUlB?=
 =?utf-8?B?ZVFXcWlZd2lXeVYzbGRMZERVT2J4TGs3c00vS1RpNXVCTXY4aWdFMkhsS0Rr?=
 =?utf-8?B?SUxBcVl3anFieWE4MGpvWkFpQ3VnYm1hTExYemlHZWx2YVpzZk53OGZFSWRo?=
 =?utf-8?B?RzBQQ25SU3dENm5FQWdIZkd1NFlEZjgzQ25oWnVFbC9BUktmdnZWcmFFRXdp?=
 =?utf-8?B?eE5IZDBiUkJuUEtWbFZsOExFNWYxdEZVTFN3UHRTZkdTNytQMkZid0xvWnVq?=
 =?utf-8?B?aHliM000eWh3SXZSN3poS29wY09EYnovL1Q0cE5rUHk0VnlkUlVnd3lPa0d1?=
 =?utf-8?B?WVZlUFF4a1dKVUh3TU9nay9ZZTNGd3lOOWR5R3MvbnBIRXk0eHpuYWtWUnYy?=
 =?utf-8?B?eGIvMVpTMERZZ3Y2ZmpsM0ZhejlCem5mbG1XK2RFaGUwK2pVdllDdWh6MitX?=
 =?utf-8?B?ZlE5eGhXS1A5SDdGVEgxUy9DTWErNWxlQXlHdk1vN2NwMkJqY3dsbEVHTDNF?=
 =?utf-8?Q?Yme27/0coEWNqRKmjx3xxLfncutp/IW+OBSl6sfjEqk/?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3d76fb-87ff-4374-c7d1-08da7a4dc552
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 21:26:06.9672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lqq0smgYuPqOtLLEA8BA995+AQYwED4DmRJOuAnEtx6L1+uQtnpxEbrIrwUbuXP1ZBCmtSvuCZ7Uo60DcQv8GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4017
X-TM-AS-ERS: 104.47.18.109-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.0.1004-27068.002
X-TMASE-Result: 10-2.735700-4.000000
X-TMASE-MatchedRID: VGeBglENKymv1fP3II840hHJWwDGGGOsKTREEsKJaMm5czS2QTwpFoRM
 yN/ppM4nYZWMbNanNqrQgHOzCONYzEwY9Z3dse9+KM98EMvC2W4xA3W5Uz0j+LOWVZ8NxQmraob
 /jf6TUn3oHOpl9ZcDR1+24nCsUSFNExAtD/T72EbdB/CxWTRRu25FeHtsUoHu5ayKPQAudtDYKV
 YCIRsnR5uQMqVdfV6NTWi2mxV9ItO+68HqACCvKA==
X-TMASE-XGENCLOUD: 9d148aec-d2f1-479a-8e92-54eee6d19b49-5-0-200-0
X-TM-Deliver-Signature: 23810D39BA48C6BA7EB22D40D09D3D50
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
 s=TM-DKIM-20210503141657; t=1660080374;
 bh=dBDxlgKocI8tcD/ZHqdfhPXbBqJxHqGODZFb8lzauxQ=; l=476;
 h=Date:To:From;
 b=QtRmOivvyErQt/C/6jxFtP8Z3VPpO6grMDFxWDel8w8LlhtMC9z9AvP26bImlnIAO
 WbZOuvg6Vw2inEiNXRgHB+89Ov1KorYRg+bB6Yp+8O/cjca3O9rfgv4nWWJaRuW0B5
 E+PsKjaE4+SVT8fsPOsOsiTfNDdghnNKZlvaGukCkGHebw2p799U8Fldx/wtloiOEw
 xAjZfMT8fbau0Mr49Dij3X33El1ohfbafiWJI2fpMcSHeo3LZ2XCCJ/cEuradKrACk
 eF8FOsWfW/kJyY3TvR7zQybhbB8EjEY8Ly1h6vcRd7R6ET/r6JziG6k0vmauMpLGfA
 IrOiPbEBef1qQ==
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

Tested-by: Igor Skalkin <igor.skalkin@opensynergy.com>

Please mind our privacy notice<https://www.opensynergy.com/datenschutzerklaerung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-general-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.opensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaeftspartner-gem-art-13-dsgvo/>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
