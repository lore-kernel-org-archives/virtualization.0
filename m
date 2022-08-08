Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C2EC00140
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 12:11:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC1C882437;
	Mon,  8 Aug 2022 12:11:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC1C882437
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.a=rsa-sha256 header.s=TM-DKIM-20210503141657 header.b=gywQv/uN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UHJJ1bYESwVT; Mon,  8 Aug 2022 12:11:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1FBD680B48;
	Mon,  8 Aug 2022 12:11:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1FBD680B48
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E00B9C0033;
	Mon,  8 Aug 2022 12:11:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49462C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:11:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 241FE82560
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:11:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 241FE82560
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GkQnYlfJ7j0v
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:11:20 +0000 (UTC)
X-Greylist: delayed 00:06:30 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AEEC581D47
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu
 [18.185.115.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AEEC581D47
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:11:19 +0000 (UTC)
Received: from 104.47.17.175_.trendmicro.com (unknown [172.21.10.52])
 by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id BCA571008FBF5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:04:51 +0000 (UTC)
Received: from 104.47.17.175_.trendmicro.com (unknown [172.21.183.236])
 by repost01.tmes.trendmicro.eu (Postfix) with SMTP id C8F3D10000441;
 Mon,  8 Aug 2022 12:04:46 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1659960285.693000
X-TM-MAIL-UUID: 6137cc86-c7ed-46cb-9251-09c42ccfb73a
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (unknown
 [104.47.17.175])
 by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id
 A967D10002183; Mon,  8 Aug 2022 12:04:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJTnTXtOH1oY5a13DgXXlRyxgcZIY5bYzRR4Rqr7+fGhG8wzWQakXkNbPf4eCupDD773i+JwDrB9pyW/GUisDwwCbCMyRbniwhHdkuxqUhPp53pfMKzzknygtx2/ZuY1CRxC4DpN0Lu6vICg/ao2DCqYchmnG5TtBrqTiwnqFRuB21Y4/wMqkYxquT9Mnlx8vZSu6GmK1HiUIXG2soij722rj26E7VyBCVpWrs66bfhtriZ+Jqfycvr705qhf9FA7YoUTchM7GN71VMzNAy1pG3OFTEAswXxLrpjH9oMh+xWWmonfV8Z9b4Pn7ZcDZIyUizY3VJfBSIEtai6JiSgeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ut7CNHvAvea8UkzgJbr2mAemmnYZq1wpwmnK3bR5d0=;
 b=fSbcB88LMchbPWac7FN4IHmndhTYIwNFd9u069dnuNnYCTQfUa+dzvn+S305+yF864CUh5uabmyDxdSnwmb2j3NKuN503YHZW2UB1ynqgsHxJhU2SbxoXLvOyFOftN/oFX6lAYvUHcXhWmsCW4Nm7eSSAH2a8KV0flxbtHVp/s4pH0j92f73FQpA4YRaht22T5Ds7zxE7DRCW0X9zEc79UzIjqPEY4g5+D6hzFiklDqXMxujgJz9a8AvNlp4lDJDq7VA3DMblnI1yLw7LlX5cW0PdPDF3tO98jVE3D01gfYVtrxidRT3XNlo/sAhI1IYrCWKDLEOQgmSMmq0+XMnjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <02222fcb-eaba-617a-c51c-f939678e3d74@opensynergy.com>
Date: Mon, 8 Aug 2022 14:04:43 +0200
Subject: Re: [PATCH] virtio_bt: Fix alignment in configuration struct
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220807221152.38948-1-Igor.Skalkin@opensynergy.com>
 <20220807185846-mutt-send-email-mst@kernel.org>
From: Igor Skalkin <igor.skalkin@opensynergy.com>
In-Reply-To: <20220807185846-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: AM0PR04CA0110.eurprd04.prod.outlook.com
 (2603:10a6:208:55::15) To AS8PR04MB8371.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b2::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be186138-6915-4456-14d1-08da79362e80
X-MS-TrafficTypeDiagnostic: DB8PR04MB6892:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3fb0glI8mFXYjySUxRICSN8Dg+WephjNFXUjORG2biFgDb4Yut1qtz6h6PJXckjmNRZwnhM6FjLLnHfDOcuTJz5ccy7s0coLfPrrI1wgk8GtsmWbL6cYw683nigEYnBYVwVuxBYFTpp073UllXSDFBZjLf4exDkW9J4EbBzycDBeSOfLy/Sz6/rYghgSaxEHdFcOtB1l+qEzWPL2POF5q5dz61AAVGjwuxMqUMYz8HrwbfzlQBh6hAzNCoBmoTww0lN3ZyoYRAPlj7mNY+5GecNyswi0Tw5/APg5GAUm8auOMHzaxI0h+RCHhi7Ycwea00peC09kFnh3z5cGE5s82nsPR2ZdoVd5DAXEZX+YZJY0zLp8x12bADnHB2AmQ/ekYSasA6bAbNs53B8Z1qx3kqyxD0E0kzSmKPS6RsvCJX1mGlifKQIcoWZL1MRmIw/u6DOeYEi9B5ZfQNUekA+Bdp8OHjEUO57Soc0V1T//Ur517MPqBWCgHuOnQ2YYMTAHTuUlLvHDFyX/7pNOw+9dxrAwhnl/e9kVTN7bVUgu+9Z6CmMR+9b05+vX77r1weVOYHvk2AfptYdV5rBWmQshLvNFRFIkBAWTsl34Tjr+a/pVm2T4tmkaN6ci3XG3FBMRu2IwAXgKtbMSIAvjbM8vV2PZKgXSE6Vc5D8oKvnJy4gKkTnfoin2xufWmeKpDImhwHui74OgsJ+Mi/6GJqrDkmrdfxm6UbNWvkFzL/sorToeO587c/pMyADq31JviiJ7sO+SH+Z5eXOx2LQsYP2zuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8371.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(376002)(346002)(396003)(136003)(39840400004)(366004)(4326008)(5660300002)(33964004)(44832011)(478600001)(107886003)(2616005)(8936002)(966005)(8676002)(41300700001)(15974865002)(66476007)(66556008)(31696002)(66946007)(86362001)(2906002)(53546011)(6916009)(166002)(38100700002)(36756003)(186003)(31686004)(316002)(54906003)(83380400001)(42186006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWMremJ1YW9wREt5OHh2VXlYMHRsMGREenJCRzZ0NVRORDV1cU9xV0hwQTA4?=
 =?utf-8?B?VnNrMVNVZHBEaFlVaFVKMGVSZHp3UlREOVpVMU52dWgvYVdsSGs2cFBGYXIv?=
 =?utf-8?B?dVM0eDBSdlR4S1ZYUm01TmlBOXpxNG9TeFJkS2l5ZmFXZVdxb0ZSQ0ZaMXVp?=
 =?utf-8?B?TTdZdUJpWGRVSEdOUVVQaUZhODJtOWVqc0tUbFAvMFUrWHNOSi8weGJYV09z?=
 =?utf-8?B?c3IvOEdSSkV3MW92dXlKSE9ZanV5ZmFkTDJqbjFZZ21mK3krbm1IUFBRNC8r?=
 =?utf-8?B?WmxiK3FXeDBBMDUyc1l3UGFWdUtrajVETStBbGdXQW05NFNUV1NUcC9UTlJh?=
 =?utf-8?B?N3R6OXA2QWVVS2dNSEFOczBLYU1iaHVIZk1aZE1RWWxqQlBNMlcxSjJNZVhv?=
 =?utf-8?B?MXZhMUE3Q0Fjd1QyOEpMRlQ2RDlGMEdmdjBwTEhvYXVZVDVEUVJCSGxSOTFF?=
 =?utf-8?B?VlM3QUpzenhmR3YyMkNEZjMyUThQT3g4U0VLb1B5VzNOYVVlVUJuTFMzeDNX?=
 =?utf-8?B?NStaa0xOZmtOTjB2QnBPdGswZm9ReStzWi8rbmErZHR4Wm5EMU4rNUpiaS9K?=
 =?utf-8?B?YTNkOGlsRE1wMWl6bGpld3ZvaDhKUCtDbHZYbElLbjV0bkxPTTZaRjNqT1pN?=
 =?utf-8?B?d09KNGd4ODhFNEY4Z01vQ2crbkhBMXJVTlMzcGp3KzNzN2hFQ21OV3FjVTdM?=
 =?utf-8?B?a0srdEI4dnowdXF0ei9sV2dXYzdqYmtheVFKdU1ueUN3d3RlUko5WTNBekNu?=
 =?utf-8?B?K3kwM3o1cUVEVlNIRjEvSEs5Q3dTV2J4ZG9sQW83SDY4azJiemxYMDVwd2xr?=
 =?utf-8?B?bys2UzFESUpNelhYRWZUeENteWVETmh2SnhIVGhOaG1VdVNMTm0wNVdVcmgz?=
 =?utf-8?B?b1JOWEFuMFJ1TnhLRGZyMHQyMFk1bklMTFovWTVkYXlnRmdaUXExc05xMXVt?=
 =?utf-8?B?VzJLdWo3cFpTTmhuc0lFeTdNSms1R1hOb1hYak9ZSlZTUzBwNEhCZUV2Yzg2?=
 =?utf-8?B?Mm9lUFUvU3FGb0R1RFNsVVdZOXF1akVqbC9mL2p2WXBkK3dHbk5obkkwSHIy?=
 =?utf-8?B?VFJyMDNzc0NmakxpMHRmWnJYam5jM3BjMkY5akU2UHIveFZYMUY2NFo4eHMr?=
 =?utf-8?B?RTlvRnFpdTkrd1FFNWVCaCs1SDR0VTVQdHBwUVAzTVhtY21zc0JRTzBRSFNr?=
 =?utf-8?B?MmFBdkZjeDBzTlZHYUJtNG1VenJzQ09XK0EwWGFNcy9kTEJuN2l4N054c1gy?=
 =?utf-8?B?K0tWZURteXZYMkRmUVNBM2ZYVktmZ1Y0UCtvc2NDUHlEeVhxVGZrYzJOcDlF?=
 =?utf-8?B?dlhPdDR1aU5GYncvUVJ5NndJTDFaL0Y1SHh2Q2xXTzhJcGw0cHZUMSt6WXUx?=
 =?utf-8?B?M1ZRbjBzcFowek1tUEJmaGFZYXVMTlF6dndhMmpRNlNSbndRMkpwdXJ5ZzBv?=
 =?utf-8?B?LzI2MVA3dUlMMmp1RWRHdTBuMkRtbHBxWGZuVFd3RDdybnhoaWlrZjkzcTRh?=
 =?utf-8?B?VWZnL0xuQXAxNUVJNUo0YkRqY3pqaURNV1I0V1hpWWppMVZCOWtEVXJjS3h5?=
 =?utf-8?B?alBEYXIwNE9DaEZxclk1NzBRMnBsOUZWUmVHeFFmcEs1SzczcWZuSkNLYk13?=
 =?utf-8?B?N2kxeWprSDVURGl3djQ4YW1oZm5lTHhpUENoVDVCQklOODhyQ2l1cTNDNGJh?=
 =?utf-8?B?OStQOGl3aU5jZmd3UVdoNjFTYjRIc2J1cFZYYWpPQjcrRHN5eXF2SUtQU2k2?=
 =?utf-8?B?SWpuWnFoREpOWENYM2lKOTd3OXF3NEN5UXhHYWo4UkhUM2dYeUNtcGJaRVJD?=
 =?utf-8?B?SzR2bzgzZ3pMUW9MM05Iei9nL1ZRdnFEWkNOUS8zRXR5aHU4T2F3bytNNzdq?=
 =?utf-8?B?cE5NSGExN3d0ZTR5ZmxKa29OaXA4amozYUtJSVkxR1NzWVQ1QVQwMEdqSDVN?=
 =?utf-8?B?YWJUQWhqOWVHRGxnUFVjK3MrcFd3M2VGV1hoT213Q1ZCNW9UakppYU01QnMv?=
 =?utf-8?B?bkVQQTZMU2psWTNQTEMwMTBwMk5FVWZsMGFuQlVEbm9OUVF4TFhnc29MMVQ3?=
 =?utf-8?B?N2NBYVROTitFcXU3QVMxS3N6VzZnQWlmSXpISTAyd0hUTjRyWEJLOUtMRW8x?=
 =?utf-8?B?Y1FvWU1mNkE2eWFOWG1QOVF3d1MwbnJmbDN6RzFKZGEyeFlndmVBelFFWkZp?=
 =?utf-8?Q?wl2K2WLH2pT2VqKGJ+PUaQKEui1sbM+btgKRh8TSNRbh?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be186138-6915-4456-14d1-08da79362e80
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 12:04:44.2780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+xD9DNMTT65X+3r9IdEBziFJLFLvc5yPyK5YgLJq1ctVuufKySuZ9gw89qKPi5yq6TTNSPMcpbf1lroR+B0dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6892
X-TM-AS-ERS: 104.47.17.175-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.0.1004-27064.007
X-TMASE-Result: 10--27.593000-4.000000
X-TMASE-MatchedRID: RVbttugoFI99dA5a4gy28BP0mYZX9XCiY/TMRvgqVps4vjIDbvA3OMVU
 BXy8OM3/M9EkAUzyluGAI7Mvq/sL597EHAuRAfwUrwK/3FKMkXzmcwRo1T9FBNwt9wauksvZuW7
 7/y896siwQ8dOma+kqvXGsfmQor+uLWxAZyoPtS22Ys8lfSkw0l/L3Q9K7QUiEJ5+KkdAau5Svc
 ZUjrkaFniywgNDw+2ojlXUAIjJm2eWfSG83Erd4oL9wYTv+i5Ar3NKrH+qlfGl1LO5A+/VNhIRh
 9wkXSlFtwpUiv21DA2A+SHJ+g3ONg2V4b0zHULvtOhu6Z0cMoZ5ILz8QQa834IT1E8ZAOo/8Jb8
 81FGn9mlY4F8r0vXP05oN2XumCC9zw5qWkMkRCUi+t+0AiFaYvL3NxFKQpq1msV/pxO5my/kNIw
 8RlACQw7ykmiMbupKD/3PSb/XPqM9QHumHFggvfrvsV1TtS1AQY7/FJpJ6BP7hAs+bLRFikR0oI
 woMPyV2AtQU7c1a/eckOuhl70pQzKF9ObUarRIOsgEj+Ozwd4jgEM8dFuyhzblc6Gei4nlG66tu
 Bin4dCISKNNH1lESVZxVB3B2qbP6XkezPna396pX+r0oWBUyJG0uTkvws0MjnkOkV5xghadOp1T
 jDrlaQqrwTJx4kRhK3BYEZWjGanTSox99vGx2ToSLnkdckL5g9vDTbe8QsjcfstxMAb2qwcbMHj
 YNxGhx1V7Fc1hQKkPa94jf+HCb1r7VJUxrF40ego2wiaj2iG5cURAloITPh8TzIzimOwPgxsfzk
 NRlfJoFT3KzpHqEyIuW4R8am3tf1pTT+KtL53iRhduhvElsvJT+hf62k2YIbZSWXZZ520=
X-TMASE-XGENCLOUD: ac32de91-dab2-4ba0-aa63-671f6b3b8e1e-0-0-200-0
X-TM-Deliver-Signature: 7CC8608BD9259F03FDA57A76F8D66755
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
 s=TM-DKIM-20210503141657; t=1659960286;
 bh=+0jK0oucc9HO9/DqCDWbinFp32RsPeTbWZ0yxb8JVg0=; l=9243;
 h=Date:To:From;
 b=gywQv/uNytEOBT+No/IIFs+xz+2jk8XDEDNUFYav8SawF0b9YpEmcUmswx7PHJQqP
 xnwCyvzLuB8HunkrHvOuJeEuSYP7zDxR2tz1isKLSnewH1rlIGxIpD0y8wm4Gt0zRB
 mkHLFZWvKW4xO4axJQqW9JGreT4NPo1JKwJ3aKTx+5Ac5knpdZp5ibjL8YYKOI/HZ6
 PbTxdN4BRXTc3a6W2rVev2/SFQUkP9AFuuu1RZvJBhtulsbeAApLY8V/psIDpBnZzN
 VH8v1HH8TMQWJFjGVUJqgtGfkwFo4jk4misELxZAPS2jttoI5n5iv19fqmHqmc+EsI
 5QPvLZmleu/6Q==
Cc: Johan Hedberg <johan.hedberg@gmail.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-bluetooth@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, mgo@opensynergy.com,
 Marcel Holtmann <marcel@holtmann.org>
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
Content-Type: multipart/mixed; boundary="===============7718394855791827708=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============7718394855791827708==
Content-Type: multipart/alternative;
 boundary="------------rcpuLc0RboAx4I0ipaJcrfd0"
Content-Language: en-US

--------------rcpuLc0RboAx4I0ipaJcrfd0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 8/8/22 01:00, Michael S. Tsirkin wrote:

On Mon, Aug 08, 2022 at 12:11:52AM +0200, Igor Skalkin wrote:


According to specification [1], "For the device-specific configuration
space, the driver MUST use 8 bit wide accesses for 8 bit wide fields,
16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide
and aligned accesses for 32 and 64 bit wide fields.".

Current version of the configuration structure:

    struct virtio_bt_config {
        __u8  type;
        __u16 vendor;
        __u16 msft_opcode;
    } __attribute__((packed));

has both 16bit fields non-aligned.

This commit fixes it.

[1] https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=3D=
https%3a%2f%2fdocs.oasis%2dopen.org%2fvirtio%2fvirtio%2fv1.1%2fvirtio%2dv1.=
1.pdf&umid=3Dd1786ace-e8ea-40e8-9665-96c0949174e5&auth=3D53c7c7de28b92dfd96=
e93d9dd61a23e634d2fbec-39b15885ceebe9fda9357320aec1ccbac416a470

Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com><mailto:Igor.Skal=
kin@opensynergy.com>



This is all true enough, but the problem is
1. changing uapi like this can't be done, will break userspace
2. the driver has more issues and no one seems to want to
   maintain it.
I posted a patch "Bluetooth: virtio_bt: mark broken" and intend
to merge it for this release.


This is very sad. We already use this driver in our projects.
Our virtio bluetooth device has two backends - HCI_USER socket backend for =
one
platform and uart backend for the other, and works well (after applying you=
r
"[PATCH] Bluetooth: virtio_bt: fix device remove") patch, so this "device
removal" problem can probably be considered solved .
We could help with the rest of the problems you listed that can be solved
(specification, QEMU support).
And the only problem that is difficult to solve (because of the need to cha=
nge
UAPI header files) is just this one with unaligned configuration fields.
At the moment, it does not reproduce, because without VIRTIO_BT_F_VND_HCI
(Indicates vendor command support) feature negotiated, the driver does not
read the non-aligned configuration fields.

So, what would you advise us to do? Continuing to use the "marked broken"
driver, start writing a specification for a new from scratch, better one?
Or is there any way to bring this one back to life?





---
 include/uapi/linux/virtio_bt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_bt.h b/include/uapi/linux/virtio_bt.=
h
index a7bd48daa9a9..adc03709cc4f 100644
--- a/include/uapi/linux/virtio_bt.h
+++ b/include/uapi/linux/virtio_bt.h
@@ -23,9 +23,9 @@ enum virtio_bt_config_vendor {
 };

 struct virtio_bt_config {
-       __u8  type;
        __u16 vendor;
        __u16 msft_opcode;
+       __u8  type;
 } __attribute__((packed));

 #endif /* _UAPI_LINUX_VIRTIO_BT_H */
--
2.34.1


--

Best regards,

Igor Skalkin
Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

igor.skalkin@opensynergy.com<mailto:igor.skalkin@opensynergy.com>
www.opensynergy.com<http://www.opensynergy.com>

registered: Amtsgericht Charlottenburg, HRB 108616B
General Management: Rolf Morich, Stefaan Sonck Thiebaut

Please mind our privacy notice<https://www.opensynergy.com/datenschutzerkla=
erung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-ge=
neral-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere=
 Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.o=
pensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaefts=
partner-gem-art-13-dsgvo/>

--------------rcpuLc0RboAx4I0ipaJcrfd0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
</head>
<body>
<div class=3D"moz-cite-prefix">On 8/8/22 01:00, Michael S. Tsirkin wrote:<b=
r>
</div>
<blockquote type=3D"cite" cite=3D"mid:20220807185846-mutt-send-email-mst@ke=
rnel.org">
<pre class=3D"moz-quote-pre" wrap=3D"">On Mon, Aug 08, 2022 at 12:11:52AM +=
0200, Igor Skalkin wrote:
</pre>
<blockquote type=3D"cite">
<pre class=3D"moz-quote-pre" wrap=3D"">According to specification [1], &quo=
t;For the device-specific configuration
space, the driver MUST use 8 bit wide accesses for 8 bit wide fields,
16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide
and aligned accesses for 32 and 64 bit wide fields.&quot;.

Current version of the configuration structure:

    struct virtio_bt_config {
        __u8  type;
        __u16 vendor;
        __u16 msft_opcode;
    } __attribute__((packed));

has both 16bit fields non-aligned.

This commit fixes it.

[1] <a class=3D"moz-txt-link-freetext" href=3D"https://ddec1-0-en-ctp.trend=
micro.com:443/wis/clicktime/v1/query?url=3Dhttps%3a%2f%2fdocs.oasis%2dopen.=
org%2fvirtio%2fvirtio%2fv1.1%2fvirtio%2dv1.1.pdf&amp;umid=3Dd1786ace-e8ea-4=
0e8-9665-96c0949174e5&amp;auth=3D53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-3=
9b15885ceebe9fda9357320aec1ccbac416a470">https://ddec1-0-en-ctp.trendmicro.=
com:443/wis/clicktime/v1/query?url=3Dhttps%3a%2f%2fdocs.oasis%2dopen.org%2f=
virtio%2fvirtio%2fv1.1%2fvirtio%2dv1.1.pdf&amp;umid=3Dd1786ace-e8ea-40e8-96=
65-96c0949174e5&amp;auth=3D53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-39b1588=
5ceebe9fda9357320aec1ccbac416a470</a>

Signed-off-by: Igor Skalkin <a class=3D"moz-txt-link-rfc2396E" href=3D"mail=
to:Igor.Skalkin@opensynergy.com">&lt;Igor.Skalkin@opensynergy.com&gt;</a>
</pre>
</blockquote>
<pre class=3D"moz-quote-pre" wrap=3D"">
This is all true enough, but the problem is
1. changing uapi like this can't be done, will break userspace
2. the driver has more issues and no one seems to want to
   maintain it.=20
I posted a patch &quot;Bluetooth: virtio_bt: mark broken&quot; and intend
to merge it for this release.
</pre>
</blockquote>
<p>This is very sad. We already use this driver in our projects.<br>
Our virtio bluetooth device has two backends - HCI_USER socket backend for =
one<br>
platform and uart backend for the other, and works well (after applying you=
r<br>
&quot;[PATCH] Bluetooth: virtio_bt: fix device remove&quot;) patch, so this=
 &quot;device<br>
removal&quot; problem can probably be considered solved .<br>
We could help with the rest of the problems you listed that can be solved<b=
r>
(specification, QEMU support).<br>
And the only problem that is difficult to solve (because of the need to cha=
nge<br>
UAPI header files) is just this one with unaligned configuration fields.<br=
>
At the moment, it does not reproduce, because without VIRTIO_BT_F_VND_HCI<b=
r>
(Indicates vendor command support) feature negotiated, the driver does not<=
br>
read the non-aligned configuration fields.<br>
<br>
So, what would you advise us to do? Continuing to use the &quot;marked brok=
en&quot;<br>
driver, start writing a specification for a new from scratch, better one?<b=
r>
Or is there any way to bring this one back to life?<br>
</p>
<blockquote type=3D"cite" cite=3D"mid:20220807185846-mutt-send-email-mst@ke=
rnel.org">
<pre class=3D"moz-quote-pre" wrap=3D"">

</pre>
<blockquote type=3D"cite">
<pre class=3D"moz-quote-pre" wrap=3D"">---
 include/uapi/linux/virtio_bt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_bt.h b/include/uapi/linux/virtio_bt.=
h
index a7bd48daa9a9..adc03709cc4f 100644
--- a/include/uapi/linux/virtio_bt.h
+++ b/include/uapi/linux/virtio_bt.h
@@ -23,9 +23,9 @@ enum virtio_bt_config_vendor {
 };
=20
 struct virtio_bt_config {
-	__u8  type;
 	__u16 vendor;
 	__u16 msft_opcode;
+	__u8  type;
 } __attribute__((packed));
=20
 #endif /* _UAPI_LINUX_VIRTIO_BT_H */
--=20
2.34.1
</pre>
</blockquote>
</blockquote>
<div class=3D"moz-signature">-- <br>
<p>Best regards,</p>
<p>Igor Skalkin<br>
<small>Software Engineer</small></p>
<p><small>OpenSynergy GmbH<br>
Rotherstr. 20, 10245 Berlin</small></p>
<p><small><a class=3D"moz-txt-link-abbreviated" href=3D"mailto:igor.skalkin=
@opensynergy.com">igor.skalkin@opensynergy.com</a><br>
<a class=3D"moz-txt-link-abbreviated" href=3D"http://www.opensynergy.com">w=
ww.opensynergy.com</a></small></p>
<p><small>registered: Amtsgericht Charlottenburg, HRB 108616B<br>
General Management: Rolf Morich, Stefaan Sonck Thiebaut</small></p>
</div>
<br>
<span style=3D"font-family:arial;font-size:12px">Please mind our <a href=3D=
"https://www.opensynergy.com/datenschutzerklaerung/privacy-notice-for-busin=
ess-partners-pursuant-to-article-13-of-the-general-data-protection-regulati=
on-gdpr/">
privacy notice</a> pursuant to Art. 13 GDPR. // Unsere Hinweise zum Datensc=
hutz gem. Art. 13 DSGVO finden Sie
<a href=3D"https://www.opensynergy.com/de/datenschutzerklaerung/datenschutz=
hinweise-fuer-geschaeftspartner-gem-art-13-dsgvo/">
hier.</a> </span><br>
</body>
</html>

--------------rcpuLc0RboAx4I0ipaJcrfd0--


--===============7718394855791827708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7718394855791827708==--

