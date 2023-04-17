Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B44C77B70
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 06:48:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F29EF40355;
	Mon, 17 Apr 2023 06:48:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F29EF40355
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=JChg8NnG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XppG9xl9a0Lt; Mon, 17 Apr 2023 06:48:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 34CD841737;
	Mon, 17 Apr 2023 06:48:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 34CD841737
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0859DC0037;
	Mon, 17 Apr 2023 06:48:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC6E9C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 06:48:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A077060F49
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 06:48:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A077060F49
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=JChg8NnG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6mLMyguZN2vF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 06:48:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DE96360F47
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::615])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DE96360F47
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 06:48:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7UXB2YKZmiVbo8EkqO5uPbjulZBsa/H/104JP09Orx7z3YN4huPpZcZLGp5oPNLs2B8+Nbd4x6mDjTebSAQ6o0U+H5UYyetCdrKU2QTs7P0ZRhXvTu2ghv+nUcOlrGH/HWmgNq5M7yFdZlnVPEe1tw+Rh1cUL2i3oaxAQC5A3oz2BpJvTb9y6D7ZwlIFsrm32kAl73oF3eR0FznP9k88XbYroOvcDgVv6LrzG9x8ztdUz7wpyNsGDmbAvf2n1kFEW0GdCr6n3VvAZJT4LED4wk3qDVa5laTydfzT+yrjU/KWJ8MdqwT5C9UalLZqZWNYptO6BPN6sp2sGi6n6bxdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZxg2z15RIg2trq8gg4QhXrnIfeUrMMIY1mdfZfs9Xk=;
 b=bW6L/LyuvIF9ENujP7IYbEZKlRXVKAE6MB/K/Pw7Aw7TPkLL6ygsaNpO3n2FWXfi7be9uLH+Tp8rHa8PTvjO0CyzBfJrD735zHLNtYbKr+RQnxkUvGAneDhkUWh+T7jFBpTI5NtmN6O/tkFHUhG/jb1jyumniRFssVtJqCdYn2z9ONOt/96jdy6HFQ3HKE0R+ZOqNbdC56q10fjhFcc4J5J34Cj1u7Tv3AS+GEwjiZtBqfAibS40pc9VKzbjSeDUSdnJjoRwNFwarybIQ/lwCd8WHKf8ctFxxOZh6865w1V34om7lgMNQrHGEHRtrxSgcgqPG2K+Ms/Ky1q+tSQHPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZxg2z15RIg2trq8gg4QhXrnIfeUrMMIY1mdfZfs9Xk=;
 b=JChg8NnGLgibFsFdB8tKKNnu8ZSF4Q80UK0yeqZLlU9hglSEB5m21P8/xYO3yUruM2Sr/Z93ou3StNQ63P+dTWVobIj0bAupGpdWtgdWLQuTz1fMRgUNFWf6thod9UisXLUNYnk1+Ogw1QznsYF/3dXg2lp4AtKd4Higd27qStE=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by DU0PR04MB9468.eurprd04.prod.outlook.com (2603:10a6:10:35c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 06:47:59 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977%5]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 06:47:59 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Thread-Topic: [PATCH net] virtio-net: reject small vring sizes
Thread-Index: AQHZcDeGnH5xR2OGlkuo4s6jvhNMC68uvmIAgABRFeY=
Date: Mon, 17 Apr 2023 06:47:58 +0000
Message-ID: <AM0PR04MB47235781555A587B72107038D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230416074607.292616-1-alvaro.karsz@solid-run.com>
 <1681696410.7972026-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1681696410.7972026-1-xuanzhuo@linux.alibaba.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|DU0PR04MB9468:EE_
x-ms-office365-filtering-correlation-id: ab7720d9-9a61-495a-82d8-08db3f0fae9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DhbCC9cokk4cgZckyFW/HYXFOdzfmn6Hysz+1scoYLShuPOD5W6QeyFtAsgC2vBCWxMkOzmYbb2CipvdOu67K455pvG7ad5BMqWz3pIjr8iooXyJJBUb06lYpQrrtKSxBvWCm4B+jH/l+/Khe+g8Hcpj40AuzHwJhayVrrqwMSA7FTwrqg7/TKkS9a7TWDvVvghrFttZ5MjXWgMui9mMXvwC2OQPHmbwenDB8n6KHIi0/FQaMKurYkSe8Cw/t3CShUFDsqvwMlasdcbkBAavmnNozNipPix5MgpFXcpgUWbL41xrWxH5ab68fd3hzYNQDnelm1NcdERA9nxmCJ+Se4Ttp5tgJzb1qz9zCnO9LKXJmr9AgKJpDmBxuvvUei9HQpWS+2f65fZ+qfcLZCXSGsaEc3ZTlBC5jMW1MaOnR762lCifKMG5Cu4D7gJJItRP4CfcfTOP9HlgXJSQ+nmqaRe4kfmA/qLzV33p9YAZZjOJe0k28G1C7hGgMxhVVWLcEPzGdgboX7HSuiq3e0SfhVg2B6T87ysdUeUJL0UuXXoul1s9C5Qz8tnul9blOmmMj3LRptHNyzdgi96J00fdQlXI2USXgP06xrD+MQvRNwxZTz+KoQJLAv8njOPzVah4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(376002)(136003)(396003)(39840400004)(346002)(451199021)(8676002)(66446008)(26005)(76116006)(91956017)(71200400001)(33656002)(478600001)(7696005)(186003)(54906003)(6506007)(9686003)(2906002)(44832011)(38100700002)(52536014)(122000001)(4744005)(7416002)(86362001)(64756008)(6916009)(4326008)(38070700005)(66476007)(41300700001)(66556008)(66946007)(8936002)(316002)(55016003)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iFQJBDKiK8BONWSjziljntI3Efp9RBocY1KfsIHBwL3i8pDmpFQVKIp7As?=
 =?iso-8859-1?Q?MV6HONTdldjzucYmGg+gcg9boeh606neXt0xpbTKkNFNt7VCugVrT2bQsD?=
 =?iso-8859-1?Q?ILVI3e+kd+j+q1MtZXXJFyCu6YDQHnnrKcVbTCmvISf/LpAsfhZSMweCt2?=
 =?iso-8859-1?Q?7c4ijpwf4XNQzz0DWSzepGWYrJyV5f728mK1CycuZv17I0mGzs3N0HKKmC?=
 =?iso-8859-1?Q?xmcgIa48Tb9bscVo4MHPUAdaN5+6ZwfrQ9NwT1REifTN/rZmdAMXHURkKy?=
 =?iso-8859-1?Q?sbF5amT7l8gLnORtvYepYu7o2FW7fx8DqHPDdWrtm2WP9ZcL10HJJ7VK/G?=
 =?iso-8859-1?Q?W5tWM5AsET0smXLEWd75KDtFN4nINkqMhYNJc/X+xqIqiVKTFez8lgpN1d?=
 =?iso-8859-1?Q?XgfXLFXvNYMBCLfI4kB7jXxLr4EVsLV9dVibhc5DXB8seEgQtq27feCFW+?=
 =?iso-8859-1?Q?GbryWo+93fjJGT5Mz24oip9VwBAmMm42zeAjcgIYGjyPaCjR6CCRxlKIOi?=
 =?iso-8859-1?Q?pG59sa6HnvZqYdsQIoqaLv6cYQ+fgVK/e21b8U5KsDpJqN0s/AmwY56Kyt?=
 =?iso-8859-1?Q?ylic+y97mXMfsYibX5Hid40f7Qdh8lgTA2qKCWhCARirc00ap21l0pwWwF?=
 =?iso-8859-1?Q?WKZ8VaI1ymMK9pYCtRfoIHJauXHJWfaGtbiJmYdw9wodKkJbljzJ+ItRfr?=
 =?iso-8859-1?Q?wx7X8rRtmJWQU7ioBzR4NsHLG/OzXkEaRQyf7NStVP8elLdJHuU5LK2cwV?=
 =?iso-8859-1?Q?N2dCu2bvp/Y3DafgYpU3OKxyeyscKkJQFVImZJcHTtJ8rQ9AuWPN0MpROe?=
 =?iso-8859-1?Q?EZ7LI4h09AbxC2S075nBEBSsk41uB2W/bEDiNvgKMLsOyuNhgWPDoPpYQS?=
 =?iso-8859-1?Q?5tt5/iOm8uOqbL2vXy2PW+wit+hn9fDuo+guI7Wy2e8aetPwKu5IGV7XKG?=
 =?iso-8859-1?Q?tvPg9ZFwe97/IFRhoY0TIbYAj8FQgQc1o1a+epI/uRWp4yCxNdRSOn93Pq?=
 =?iso-8859-1?Q?wLu33Aifq9txRPv+cl2b1/Owz+SA4KxV5vw0mgD24n+LRh898Tdw5g2Shy?=
 =?iso-8859-1?Q?fXuVihE5r6hLrXKUDUcu4ioC1LZBRjc1ukOJGaDONL3DikbL1sZGQIs4nj?=
 =?iso-8859-1?Q?4U2zG/tGqoMEKXL7cGCrzBMTdDMLM6JQsNR+WqoWlYh8iG+hAadapsjp6/?=
 =?iso-8859-1?Q?Kom1gT+AOy4Rxu29nluZh3uuZiHqsvVbguEeEsiy+J0/SGLrw/cSccKxmx?=
 =?iso-8859-1?Q?nd0l3dfEhGXq9Kyg7KkqNWrbXmg85V/sHaWSPQ0erpl7XCG5uePg673aAG?=
 =?iso-8859-1?Q?lSPKL7h7KWdpuNHh8jXU4hPlNU4ftJz8jG6GWXnz1vd5DHoPuDrqkjQSFu?=
 =?iso-8859-1?Q?h407H4ouhLMQoNJFC8cyzmMDT+rjF2+xonpRMwas2k4RUYMraM5PCMOTMO?=
 =?iso-8859-1?Q?6pdH15JLMOW/LRAc3hmoxGz+QjEVrMlq/T/+n/SCLSUGX5pQd4O7ZlCw9G?=
 =?iso-8859-1?Q?jcFoEQhbAQYn4Be6Iv1BfiZ4vWmY20lwV0fx82Ht4Vr7FOJj56/W+r+ZQI?=
 =?iso-8859-1?Q?lca5DO7RsMThNmkVMHBsqgx2fPN31rsi2tU/X4qRFtO1kogELQjPBO9ap/?=
 =?iso-8859-1?Q?Ac5Nfp1JJrDG9L4dO37vxkVCL1Lsdgr/+K?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7720d9-9a61-495a-82d8-08db3f0fae9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 06:47:58.9516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XQhqBfsnWowJ4ZYFeW0SfflJWo43x2yugvb2jDIBolmeT+hPYQWX6Rg/iqXaQwzhCQiP7Rg03QaNXH5pN0c6KIh3HisqUuBINg0ESbdU2Xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9468
Cc: "mst@redhat.com" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

> > Check vring size and fail probe if a transmit/receive vring size is
> > smaller than MAX_SKB_FRAGS + 2.
> >
> > At the moment, any vring size is accepted. This is problematic because
> > it may result in attempting to transmit a packet with more fragments
> > than there are descriptors in the ring.
> 
> So, why we check the rx ring?
> 

You're right, the rx check should be a little more complicated.
It depends on the negotiated features, like VIRTIO_NET_F_MTU, any guest GSO, VIRTIO_NET_F_MRG_RXBUF.
But MAX_SKB_FRAGS + 2 covers all the rx scenarios.
We may be able to accept smaller rx rings if for example none of the above features are negotiated.

If you think that this is necessary, we can do a more complex rx check.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
