Return-Path: <SRS0=Buhk=PC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913D3C433EF
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 06:11:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4718B61152
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 06:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4718B61152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0CA9582FBE;
	Thu, 14 Oct 2021 06:11:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CeClIGX1wB8o; Thu, 14 Oct 2021 06:11:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9B20D82F76;
	Thu, 14 Oct 2021 06:11:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C325C0011;
	Thu, 14 Oct 2021 06:11:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 561B4C000D;
 Thu, 14 Oct 2021 06:11:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 37602607E3;
 Thu, 14 Oct 2021 06:11:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=opensynergy.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G24xkGtwGlnA; Thu, 14 Oct 2021 06:11:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80139.outbound.protection.outlook.com [40.107.8.139])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 25FA56077E;
 Thu, 14 Oct 2021 06:11:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVLpCrg/iMBonQOUVkVYpAYGWB/fbGuDLv21wGf5C1H8wlaA/l9TGez4nw05lVGrS00RfojVKaFR8ha39Me563wXpQw4YxsXoa1ejiLhc7RBhk7bPzR0zABMYVVIfDZvHYkBRUfxT6uIflBrSrVViWBXZRGreQj/gF7qJNp0O2bdaK6JMlPZkDvQBklsO9/sFgUHY3zabxiKrty5Yms6Yewq/z+bWa3l8TxFQ/kE+YdNhFtXHRa0ipxNm348wZAJm6UTrh18lXQ45aP08zOBnHkG+Fb4N4MjNB35/iKVw1Yr2tlJ6JzOKhDz4AniGIHJL5BCRrWoNkQFUuJbLkYERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5po46FltMSdOciY6xiDB8yxJJKRjyrEtyokuS09wIY=;
 b=A43aDctrCqMSv5AlvZVNoocmQQDgv577bD3pA+iazXvg6op7vSN5FB0hSGDiz6G+O8kKqltDDkjg6HdGL1uIaarMDhM/iVYn+0aHMOzOfYui/IPA6cVjz+jlJIl2EFGpiTMzihDI+ABt/EUdO1JyUJmU0ToAbCIF96SEDIOhKN7F802Bsq+ovVuUjFnlnA04V21/pCx5LdysTt1ZYkqUfbwQTNWQVW29E4PUlPI2hd4uRFcekutag1CyoqY0IUtbtIyv/hSM4r8jXd97nNXDkXyfR+DJUk88mmXEiZu6XGhVIJWCwR251gVT++o2mdzLY7UhCuaX7z8MYIl+1IX0kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5po46FltMSdOciY6xiDB8yxJJKRjyrEtyokuS09wIY=;
 b=CSJSBBHnW3baLnDRwlg2I8emKcF3J7lABXAaaMzJY2J02UF2fXZ8KIkeUWuahLhTFofrwfSZSjbKvHbSOWTAwNXvpGA2j9pXJ11l9FJ0gEzMsOSLeVQpX+OJWg87fLh5FDqClqepZMYge6xD/JRubCUTLtCYjOl0QRgcUe440/w=
Authentication-Results: alsa-project.org; dkim=none (message not signed)
 header.d=none;alsa-project.org; dmarc=none action=none
 header.from=opensynergy.com;
Subject: Re: [PATCH RFC] virtio: wrap config->reset calls
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20211013105226.20225-1-mst@redhat.com>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <0b0c22fa-9002-55b9-163b-e735b8370892@opensynergy.com>
Date: Thu, 14 Oct 2021 08:11:32 +0200
In-Reply-To: <20211013105226.20225-1-mst@redhat.com>
Content-Language: en-US
X-ClientProxiedBy: AM6P195CA0068.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:87::45) To AM0PR04MB5891.eurprd04.prod.outlook.com
 (2603:10a6:208:12e::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc1df71c-bda2-459b-332d-08d98ed97a8c
X-MS-TrafficTypeDiagnostic: AM8PR04MB7986:
X-Microsoft-Antispam-PRVS: <AM8PR04MB798610F33A2DA83B1D8AA0338DB89@AM8PR04MB7986.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jbX/pZINSH89MTyMy1D/tvhcyD0fit/sJiKJQkYGZfitVO+hGJnQ0jEux+Lbl7Xqivs6g2iM1R4BYKcXlI9AYFzdJHyresWlrHCIUrcpLdxuEmSVsHLu8+NQpZAp1b9kfUW0Rho8dbWsawT/bND8ZY4dkG3oVOStOujGLwhiRzhLIPsTJrEdKj9uhpoQtBVpmRBdl4qby4ixhYIRSteENggyMOk2ujOQybO2kh+bDbzV4iNvNi446OLMbPIZy7deWIay3zFGa9Wgfv4aSGdC2gSgryYrPWVrw/tH9BSROTTqbPCs7+tJHHZAd92moPkvX8VPRhQAZuPyRpqWc8GrW5kLS+c8HvnRH7O6XOYBe3HKDK4R+aRTDxH9YJ0k2ads2T6hnFDXUntlljgrPG+T1wRFv5cS66QrxTaMkPgIyWzuGsHUA2lbGN+B95TfGiKNTHu41P7G8G9D9JG2MZ4twxSfOlOrJHMwOblLEW25bPPoc/M1Y8x3iKsIcUMKVaiOJL2MRMfClWXM+rZLsgFdWFf80JVaKOWswrTgtlNkk94lYBWDZYtBNggadb7L9qDRQlu6imfIUEe+mgU7ZhzOlIVRCcfe6o95dABXzEDoFyB3e8LQnx46ulxhxfVgAhqk616zkVrG5doXV4UQiXPxfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB5891.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(366004)(346002)(376002)(136003)(39840400004)(4326008)(66476007)(44832011)(66946007)(5660300002)(53546011)(4744005)(66556008)(8936002)(2906002)(86362001)(7416002)(38100700002)(31686004)(8676002)(54906003)(42186006)(316002)(2616005)(36756003)(7366002)(7406005)(508600001)(83380400001)(31696002)(186003)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVhWQUswYmZWbVpidm96MDN1Y2xyWk4vWlFRMTcvUk5MQm9QOVBPV0F5bndL?=
 =?utf-8?B?SHY5KzFDT1U3Wld0dGhqdmdSb3FpbUNkWjQwRXNEZlBhRTR3Zk1jWkZjZnJS?=
 =?utf-8?B?RDd3RTR4TTFDTzlYeGQrMVB2eFlQc3Q2QnEreHlFL09JTmdmck5YZEZIcjZY?=
 =?utf-8?B?UTIwRVNVZEVOM3UvV3NXMGMydmFLOXNzZmxsVzdBWEhEM1JVdzlSL0FHZ2V0?=
 =?utf-8?B?QVE1R054REVsRCtTdHVqMlpnS0JDVloyRElKV2p5dDYwSUZUMFhvVytGQkVu?=
 =?utf-8?B?QXVSYVBpeS84N0dvM2hnWGMwZW1Qa2xYd0svNUtXRUFiMGgzeTZKZGhwZmJa?=
 =?utf-8?B?VHVZQmNrZ3hRT3lRTEZGRU5tcEpvVWNVazhoZFg5d00rSHJ4ckU4REp0dnRh?=
 =?utf-8?B?THh6aUJXZ294UEFTSFNyb1JnME9TV29qTTBzWksxVDVwRDM1SkxSdGpnbUgv?=
 =?utf-8?B?UitMNVE0aFVjTUltTVFKbE54b0hGaEdOa3FPWEpkWk51YUxtK240Z0FaUFNL?=
 =?utf-8?B?TFhZYXdxeklrUVVYd0RPUlUzeFRtakNTRXRnTVM5dTBlQlpVbUZ3Z1U0UUpS?=
 =?utf-8?B?MWlZNXg1TlNtWFJFMWhsaC9Xei9NQndBT2QzUkpOcGZLek1BWFpZMW9tN0c5?=
 =?utf-8?B?cnI0NXVvTWRqMTNoWllPSUQ0RGdLT1Q5cXZvK09HWldjbng1NXMydWFFWFZp?=
 =?utf-8?B?RVl4TFNrd3A2bUVTMmZ3TVlvUHlabkpPQzNFTVhWNUtYeEhlWGk0ZW5DY3Zz?=
 =?utf-8?B?dlR3Z2hzRytIcTFSbjdaRUw1Mk9tVmZheXVLL2ZyaFNXd0R0Uzd2Z3Zxazlj?=
 =?utf-8?B?OFZnZG1xZmR6QUxiMjQ0ODhDYzdQQXdrU1hXTVJCeTdGc1NkZkUwK3JPendZ?=
 =?utf-8?B?a3dadzZWYld4Z09qelQyNktubUhoVnU3K1dpdEdJZDNNUjg3OFBYeTZlSFpL?=
 =?utf-8?B?TDBhNzJXdncrRnNxK1J4NWNLbXFCM0RWd2pxb3lwUFpOcllkd25WeDVWRnVi?=
 =?utf-8?B?MHpZTE1sQWRmK3RJSFowb2NiUzJoM0FPNDRmOUNsbGU1ZDN6KzBpaEN0Zk9Y?=
 =?utf-8?B?N0IwY1BHS2FtalNZQngxM0J0UHgrUEtRd0RUb3Z6SUxTVyt6UUV6QmNXT2VD?=
 =?utf-8?B?L0xMNytDUU9PL0xsS2kxZ3VadXI3RFJ0RkcrKzhLcENVQmVKRG9EYjhpUGNU?=
 =?utf-8?B?TkxmY1dXdnJGZ3lva01oaERlLy84VjJzQm1GSWxPTVFaamREOWxpK3ZFaEJ2?=
 =?utf-8?B?REtPVDE3V0puTTNKQXJpS2VRUFF2Z0pwUC9TRVAzUVozcWxCbEQzVkNJeVk3?=
 =?utf-8?B?c1ZETUdQb0FQNHNBVXRwdC9mYWNqbkk2MWtmM1RWOW1lRU8xZXVYdUVLNW9v?=
 =?utf-8?B?bzBVYnB3SGQvaUZsdHl6d0NDaFdreXhiVnZ0dmFGK3Rvd2sxanpCWHQzNTB0?=
 =?utf-8?B?R0hFUHBxc0REMjRGeU00OStsL09tOXRsdHRGQVc1S3JNYXc4Sk1nTFFFYTlP?=
 =?utf-8?B?QWNvZzJGb1VRWlRtQXQrMlhnWXhPeERUUTFyWHMxWDRjU04vM1FVc0U0R2Rp?=
 =?utf-8?B?STI3Wkl6dTQxMzdtOTQ0MUFVeFJDdGJWeXdJNWlpSDRIS0Z6djZDNHFaQ0dN?=
 =?utf-8?B?QldKSTgrUVZYNmgzVFZJcXV2ZHVYNnJYNU9LeGI2VGVzMHdqUkdsMlZpUVZt?=
 =?utf-8?B?bzV6Ky9Ra3lFTGdZMGMyOW5sWHpPQUJKRjVydXc2OG1vZy8vcW5na1o4ejBn?=
 =?utf-8?Q?xz3mOvFa2ozXf9ONVb1AUXUoupX1M0/tPkdmnc3?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1df71c-bda2-459b-332d-08d98ed97a8c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5891.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 06:11:36.7959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oeNH+rEXARHKuwrt6kflln1JHZ/1aagGfI/NxMnd5ZPaPSygBdpV2N0pR0aS2MooCF9MO6tV8L4jH2f5alI0Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7986
Cc: nvdimm@lists.linux.dev, Stefan Hajnoczi <stefanha@redhat.com>,
 kvm@vger.kernel.org, David Airlie <airlied@linux.ie>,
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 linux-remoteproc@vger.kernel.org, alsa-devel@alsa-project.org,
 dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 netdev@vger.kernel.org, linux-scsi@vger.kernel.org,
 Will Deacon <will@kernel.org>, v9fs-developer@lists.sourceforge.net,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-arm-kernel@lists.infradead.org, Miklos Szeredi <miklos@szeredi.hu>,
 Richard Weinberger <richard@nod.at>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Kalle Valo <kvalo@codeaurora.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, virtualization@lists.linux-foundation.org,
 Marcel Holtmann <marcel@holtmann.org>, Vivek Goyal <vgoyal@redhat.com>,
 Ohad Ben-Cohen <ohad@wizery.com>, Johan Hedberg <johan.hedberg@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>,
 Eric Van Hensbergen <ericvh@gmail.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, linux-block@vger.kernel.org,
 Vishal Verma <vishal.l.verma@intel.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Matt Mackall <mpm@selenic.com>,
 Dan Williams <dan.j.williams@intel.com>, Jaroslav Kysela <perex@perex.cz>,
 Cristian Marussi <cristian.marussi@arm.com>, Jens Axboe <axboe@kernel.dk>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-gpio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 linux-i2c@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, Sudeep Holla <sudeep.holla@arm.com>,
 linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, "David S. Miller" <davem@davemloft.net>,
 Joerg Roedel <joro@8bytes.org>
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

On 13.10.2021 12:55, Michael S. Tsirkin wrote:

> This will enable cleanups down the road.
> The idea is to disable cbs, then add "flush_queued_cbs" callback
> as a parameter, this way drivers can flush any work
> queued after callbacks have been disabled.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   sound/virtio/virtio_card.c                 | 4 ++--
> 

Reviewed-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>

-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
