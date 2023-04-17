Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F39EC77B77
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 06:38:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 972F960F79;
	Mon, 17 Apr 2023 06:38:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 972F960F79
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=BVNMqXet
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uCz7frtAN95V; Mon, 17 Apr 2023 06:38:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2368260F58;
	Mon, 17 Apr 2023 06:38:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2368260F58
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0E23C0037;
	Mon, 17 Apr 2023 06:38:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69F6DC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 06:38:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 373F360F44
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 06:38:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 373F360F44
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Da6Wsd3-Ze4T
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 06:38:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3C36C607D6
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::627])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3C36C607D6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 06:38:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVbPon+uNOUAwQvDiUACP/fqNhMZgTc+v6YqncnPkTPiZEYbygP3QCUsH3h6/9eOk2X6Nm4N9QOfx61dnz3TvRMsD7QCRfKQhFSv/+ZSLtg1kleunRCnRjD29fs2eZv103aImxxke1cREoWbQGrm5F01oIucC2N1KX+vFnf1jW1ZwuJ32ssH1jkQqjrXa9BDqyavFuw9NNLd2kzWG2oTz71NO3ygpxY+w/5borItsxhw5TqcgHsaPa3WNxIOTXpTrEyWQJNhtRs/BPEQInptO1lg0BbgtJfcc4zoZ0kdzjCGkzUcJriZ5FbtJnebc/WyUa68jvTkmpVi/pj5Yk6kkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3/gnz54+mOIDq5DbmDRl6DkM6AqS/7ofZWYPQjRT/w=;
 b=G+zEGOt7JxubvniJ+hMXYNVDhKhE8GaO7Tmpn1SfGpwYCxyAbLGVEW+HiByXrQqOVc4+LyllVFbsLNB9bO2O11XncsHCyy9DshFq7oMeq1qwtqnYInarsZ8tNjY12P+rqWUWOvfxWqp0rFeYThTHYjMLC92Tj3EzaXwk33MPhw8mhrpjtetY96yEWXJ0c/IdUCXTayZhGv86XTqoImyo5QUGHWcObZk+K4a5u9dOZ79XgHUdL8Z3UjUIISfc71HjJoC7TOYn0uWMPEuxlenQ2NjfVfKqOOTbJ3XPHX777M8iEAWzpAd9aO+cXiHdQGIii1YDxQh6gyFYKmHH818zdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3/gnz54+mOIDq5DbmDRl6DkM6AqS/7ofZWYPQjRT/w=;
 b=BVNMqXetJ0evEp/9zW4f0SBnwgedkFlKBydTq5KyKDUEy1u8jm4DRXIjVvhn1cPXk71kKYzxpMJerh44BzOI/xuszPkFzxvHQYvh1QB2G+o0MdWaUToSsgTP7JFJVNf89Wybo2pPdwiWrC1jdavSrIj//Onb94ArfXmSZDO1q2Y=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by DBBPR04MB7723.eurprd04.prod.outlook.com (2603:10a6:10:20a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 06:38:43 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977%5]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 06:38:43 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Thread-Topic: [PATCH net] virtio-net: reject small vring sizes
Thread-Index: AQHZcDeGnH5xR2OGlkuo4s6jvhNMC68uIjT9gABGFgCAAG90AIAAMSwAgAABjzA=
Date: Mon, 17 Apr 2023 06:38:43 +0000
Message-ID: <AM0PR04MB4723B8489F8F9AE547393697D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230416074607.292616-1-alvaro.karsz@solid-run.com>
 <AM0PR04MB4723C6E99A217F51973710F5D49F9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230416164453-mutt-send-email-mst@kernel.org>
 <CACGkMEvFhVyWb5+ET_akPvnjUq04+ZbJC8o_GtNBWqSMGNum8A@mail.gmail.com>
 <20230417021725-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230417021725-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|DBBPR04MB7723:EE_
x-ms-office365-filtering-correlation-id: d5275c5b-21bc-40b1-432b-08db3f0e6354
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hrAkJy195Oz08H7xArNRqXHO/SLMB80C6qnLE4QgP4ATedd/WKzpdvWk1g+mv99si+E/lZ5vS+eW7bOs2blkFLnUhkteWDoLGV/FsFqOaiH5x38jW3EeICE8BtHOBkajI1Yb3ED7tKzlLfaNhc6wuod7kbUwa+ftaUcEU/wZYu7/2z+d0/j2CgmWta1siMmNtVQkGpaOeLstAR5DebkF/B/1Oc/64EiAuqKAhXKXa+gEdI97MZFcFyufLLEZKb5hmS9mYQo2CZspDnexH0n0CjZAbVZBGdb+LtL/uoyKthjAIr7Npb1ECIbcQd1gvRERV+Fx4HDUOf55BM8sMK4mjGzDN2A7qXr+5Q1iwTwZwkYrvU7GKfrY8KHBbuzr/bDTrC9ogSZ1ZGcnKHcWaYuNInQL+47gORM0Qq1HUXkqX2Kgf4aCH+hlW24yjPvnyZxM8ADwbpYqkaUHpf0D77Dqqhml2R1qUq4hTudMGi9SGWfBhVgL9z9R3e55jrZEkFX8+ptBC10Fyj/OfQadedxhLskGCZuPrA4pJjwJqSJ4tJjK+sFzvzegqnU+kYr+Kp9JXaXGY5rQFx9ctLcB8tmSn31vP0wrI4n5111ZK5EVRL4Fahl2ypo05hxJL7PUPlKI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(366004)(396003)(136003)(39840400004)(346002)(451199021)(54906003)(110136005)(55016003)(7696005)(71200400001)(478600001)(41300700001)(316002)(91956017)(4326008)(64756008)(66556008)(186003)(66446008)(26005)(6506007)(9686003)(66946007)(66476007)(76116006)(52536014)(5660300002)(44832011)(4744005)(2906002)(8936002)(8676002)(38100700002)(38070700005)(122000001)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?x6xdGX730HB4XaSHAMn7w3ATapR1RmQz6nDxZXDN6C4GSqLg1UcJV7WJhs?=
 =?iso-8859-1?Q?j+bQfLaHh3DMC/BJY2Tph+wWYILm93knxoo0sxzkbO502WHHDLFvRtBxlh?=
 =?iso-8859-1?Q?CE0jw4Crk87cqTLJ17ajrN+UoieDY4vJjNlIXBeHAkp13HzIQD88nPWMDW?=
 =?iso-8859-1?Q?hR+2AMZ/ExUNNTHq+29zJLAXSrbgs6xxeKlz3XWXGKxpK6WhpeG3eN1IQK?=
 =?iso-8859-1?Q?nxzJTSAYpCxCyfTtTieNCyC9cAVHt2vKGkk07vmzg1nhbHTDhigAJbLrWh?=
 =?iso-8859-1?Q?k+KTRfaYZcSR2ekwteKzcZzO8cIMY3mhce2sHl77NSnla8n95UG6zbnu23?=
 =?iso-8859-1?Q?A9twNj7TG1SXZlG7ElFxZYQMur+GlbwfQ5hWXZVnPxa7xotTlZPu6tjSaE?=
 =?iso-8859-1?Q?rphx+5Px09WniVE2PDa1pulFm3WHkHzWZM3t8mCUz5yADsYwTdkqOx1QJY?=
 =?iso-8859-1?Q?mYA0XjAcLgfd1bcuOSGxUY2PdthIALwo4i9rck0Ql2u2IVItqJ9oPBOI31?=
 =?iso-8859-1?Q?fXXJGnY9k3vRk4tAb3fF0vX6rMeJPzqttZVOWt62ebgmCbV7xJyil10Wee?=
 =?iso-8859-1?Q?06H+siSJUQLFSQOv/xAmnwJv1zN9RRkFU9pFrdp0Icu4JaaHuEjdHCnwGQ?=
 =?iso-8859-1?Q?cTNlIGzFXl6+NKzAKI8fmKAabpVUZrUQjxKGf51cnAVLPe3Yv39wRqdQGN?=
 =?iso-8859-1?Q?86zvo4pm76p7Q176hlcrCHN5jB9wszlHym6UQSCZdKcWsRaRhmcMUy2qmH?=
 =?iso-8859-1?Q?jv/ea/uCPAIy2aMRtN5anhzAg/MSfbic/u4gB6pXsgMhnVWiP5RYTRkpJp?=
 =?iso-8859-1?Q?FkxSAEjrHcPaPLwA5dYCZsDssZmMeUHFdGdTzvALmaR21qfCCKWyfYTa6V?=
 =?iso-8859-1?Q?3Tc3AeGM3Cgckpb4QiFhQDT145iIzjYA9DpTdCEx3pwjl3lh+zspflYK8S?=
 =?iso-8859-1?Q?QRSRSvmHN9r+pcvtiNgvbn0I2n/EtHHfFOjnFsFkvck5l6mopGqdaExolz?=
 =?iso-8859-1?Q?4jtKsP7N3Bm/s21rjCv6cmfSD5uRDzaqifMrNsLpEjxIzJW7L79cZxtWHq?=
 =?iso-8859-1?Q?7ShIyzSoTHzJG45IgatenRvaFFx+Y6RIrrZxNHH7qtsTblR6tFtlK0gR94?=
 =?iso-8859-1?Q?GSUXThmsqOUEC3+PB8WKKyJx1lgtlw/nSPEvfPgKDV1drkw0QW6w1+1hIv?=
 =?iso-8859-1?Q?uLYr9U76pwFf9iLL8sc3cUqxoYCUmC7kAMweboqMi89IUku37KJCZQvCNn?=
 =?iso-8859-1?Q?OBicg/zRVEXnPpLlpe9c4x23gFgn8W5bwxze6z4fZuB0jbb7Cc0gvplgDs?=
 =?iso-8859-1?Q?bwaTTuRjmiyEuOqFpIXUAnVIGS3GmQ9l656+1rWgzC04Wle/3UOzSwdYVP?=
 =?iso-8859-1?Q?/+0j1uW5V4hPNffJOyVL6pQnmnWCZJMF+9pmEBzswGBvv5Pe8LQ0EIvtc4?=
 =?iso-8859-1?Q?LD0qE+kSjH8RxikUtLjRHom1q6zrW2nrClVedi/0xc+KrWM0r5w1gTX3iN?=
 =?iso-8859-1?Q?5OpHq3ASviLORnoK+IkB+T0O4DAB0cBDq3wij0hJUzSVGKwYHXebPKfgqG?=
 =?iso-8859-1?Q?YISucHiKlDgH5fEWG9ajuEDTPnSZL53LqXhj1fB/ZoAQOU3fqMRBY72LTg?=
 =?iso-8859-1?Q?EiRJ6z+X88/+9bCT5pEH5SX5RnNLUMbKEI?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5275c5b-21bc-40b1-432b-08db3f0e6354
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 06:38:43.1595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3QPKjpViZ+4DDuLs8pMIcYSJezriepn+5SQfDNrug5k+xBDOJYW/joEdcl824u4Sn/KNTT8xUHG9/bImqcJR/2QbNnH4TzQdUbhEbrSS+Mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7723
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
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

> Actually, I think that all you need to do is disable NETIF_F_SG,
> and things will work, no?

I think that this is not so simple, if I understand correctly, by disabling NETIF_F_SG we will never receive a chained skbs to transmit, but we still have more functionality to address, for example:
* The TX timeouts.
* Guest GSO/big MTU (without VIRTIO_NET_F_MRG_RXBUF?), we can't chain page size buffers anymore.

> Alvaro, can you try?

It won't matter at the moment, we'll get TX timeout after the first tx packet, we need to address this part as well.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
