Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A48C77B70
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 07:04:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B95258214A;
	Mon, 17 Apr 2023 07:04:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B95258214A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=N24Hk6hu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nOFNC-VJjJge; Mon, 17 Apr 2023 07:04:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 110AF82123;
	Mon, 17 Apr 2023 07:03:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 110AF82123
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6C5FC0037;
	Mon, 17 Apr 2023 07:03:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59A35C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 07:03:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E66060E27
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 07:03:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E66060E27
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=N24Hk6hu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lCVUGZLzMFUc
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 07:03:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BA83060DF9
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::621])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BA83060DF9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 07:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8Rg6fM/ZKOqQb2RNP86qx4ywv7po8MLL9cfWOb0QbJ/wI9eQaWGk2R3KzCasLlvosxJhdXbmBK1jrKe4FegWI2xdkA9/aPjjBKnX0L42lKZs1DcVrj9TyHiHWPJFGm6DyuvjRQJCfhkcD3H5OCpVmV8BFSHP9QffM7DUwFtEonRv2v+BN4vbBXv6l/D2MKUCVr6kW1PIk8jFZkUROPpH4XmagOBB/9zgTBGi7+rmdOY04xh0pY3TtxzyT8KN6TMq7UBG5cqgxw42Q4LS623M/8KU320H2NYulIBuxFm5R9P5ba+4YuR8V6+A6fibatYwbgOY9paM/wf8Vnkj1cX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKQyGSsCvFfJKbDIXvkZxWkXgn+4F9DDxOwQId9WFp4=;
 b=QhNkfwVdEhP3RpjGM1yEZhWJeqAPgfv+MVktkxihXBgLyo5QAl9gDQs+WBe+k9Fn5R3NqYhos7Y5tPp3f1buPXu+wbw8opQpFb0AOLyko92kRQ/iLtky3gPdBg7WwKSu5TOa8S+avK+ry9gwrc2rfPnhvTfec3SPRSt2VW9Mw/oUx0vHX7beQ154n1SsN98TJqxmD+WovQJ79CL3B0bPupAjJLzoANrl7qOUF3/Oc1e6qT+4ew4hf73NlG1AKtXYB1Z/mJLeE2AU4g9lDJ7hx/LtEsns/c+LWx2tlSaHtg48VFrzhbPQiSAvdJKOoOCaZQJpH1M5GygjRROYrTWyMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKQyGSsCvFfJKbDIXvkZxWkXgn+4F9DDxOwQId9WFp4=;
 b=N24Hk6hu3uq6RSGyr6OrsA+5dQ1Ecy/IzsCXdGYWVuUGqC94dwUYBcQhvJ9TFr5zQ+W9TYHoqSqNO9UUqcHQUAQ7wpaXxqVmLT47ja4eBfUiyFj/4ysmPXTLHQluuJ2+KFCwHPxGsqkJaHswbhCaBGnMNCr9LAlu4ff1ubAj6CU=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by PA4PR04MB8016.eurprd04.prod.outlook.com (2603:10a6:102:cb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 07:03:52 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977%5]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 07:03:52 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Thread-Topic: [PATCH net] virtio-net: reject small vring sizes
Thread-Index: AQHZcDeGnH5xR2OGlkuo4s6jvhNMC68uIjT9gABGFgCAAG90AIAAMSwAgAABjzCAAARBAIAABATI
Date: Mon, 17 Apr 2023 07:03:52 +0000
Message-ID: <AM0PR04MB47237BFB8BB3A3606CE6A408D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230416074607.292616-1-alvaro.karsz@solid-run.com>
 <AM0PR04MB4723C6E99A217F51973710F5D49F9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230416164453-mutt-send-email-mst@kernel.org>
 <CACGkMEvFhVyWb5+ET_akPvnjUq04+ZbJC8o_GtNBWqSMGNum8A@mail.gmail.com>
 <20230417021725-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723B8489F8F9AE547393697D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417023911-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230417023911-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|PA4PR04MB8016:EE_
x-ms-office365-filtering-correlation-id: 21cae1d3-66c7-486c-ab0d-08db3f11e6df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MMumY+qFWipP7xfDkSj04zeV/OXfa2yYMfVdvjSFV+HJhA72OMBp+fPbnNJk9QxgkQ9bnRRtYr6Q9ikfty0KiBROo1S0FZc6gjbOjHVMj1vDAfoFAkm7TArL1TwM5sVhbVx2KyFxU8Bdl0WUL7y50/TZCiCYB2Z999gi2KOySKjqWQgulEbZHVH5AJM6TDvGNmy8Iy2PkVulv9yAnCjzsOSA4uCODXuiqh50HnukJVw7HcKWi9NzJudBav39OGFWGko6j/WGmRBgprV53BUiLaNNXN29jnETZMvYAmiokayCNR3/8GFFbTd8Gv2Z4ZH7WEzgFQvPo53rDWhFP/ZzFE9u4tM5y/bWMvrFIcU5/CZ4pju9IWKZN3CY1WgqeiFNrbzKgxIk/vyZMY5WMrU2BEDGWKEUrDyElMgBojsHj5zgGBHiFy8uu8JhD1b8wn01A8Nyi8pZP98ssovJY3Q+2AtnCi7Lyn6JWfRh4vpmWXJ9FqmFcGLvlStzhNFTBRrW+UN/WAOS4zeAFp9oAA0++qhsQZGDw/nu/YTy6/fxiv6MdAnCQbMh/DYx8RJUG5KHubITRpZikPsqdVPht2OFbZnnvkQWp4Edd7MywbLXtoM4MA8AwH+L6ZoZBlyl4F9f
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(366004)(396003)(136003)(39840400004)(346002)(451199021)(54906003)(55016003)(7696005)(71200400001)(478600001)(41300700001)(316002)(91956017)(6916009)(4326008)(64756008)(66556008)(186003)(66446008)(26005)(6506007)(9686003)(66946007)(66476007)(76116006)(52536014)(5660300002)(44832011)(2906002)(8936002)(8676002)(38100700002)(38070700005)(122000001)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?A8MPFyM1CClUc9wII7XxQ78BkVA3EE+biqOL49hyyB/Q8Knuu6qGiJNzgQ?=
 =?iso-8859-1?Q?QlBD+qmElf8ZwZuhjcGCuQIWSWQo0ewyVsr8XqWCeCv9zOBF1rcaVtziTt?=
 =?iso-8859-1?Q?OQSiN4+0CkShiK0u57S1I+2oQ4vZ4IaGdVW95RoQ35OaAMnjiwnBMTZ2fc?=
 =?iso-8859-1?Q?1l7ZYvwNaj0CakMhmXYDzED3EHT2ygyIAAXG9gAOiGiN5qzLlVBJS9ruf6?=
 =?iso-8859-1?Q?znfM+wGn6auUV9jdNGfO4ZcsbVEjrh8NagjvTKD06CKW7UvTQd5WtDKY77?=
 =?iso-8859-1?Q?HD2FPJBtsgJZ639rLqPZhMeJO4KlimnFzfH8sKe+CTY5vw3C6hcxdAjOJR?=
 =?iso-8859-1?Q?8SkLZLumgVX14roKUVTygAmFYxYhIu0y3Kxun81Qb6V2va+Z1OmcelKz7C?=
 =?iso-8859-1?Q?nCh1Nl/zhvV4E7/isiDZxiPszadKiTCQU2UCQgykw9K6x9naHs5RdShaR3?=
 =?iso-8859-1?Q?rnkhxYWODsKezuxCaYygkTMo+mMpeifz6MCFTx+F3/5D0rnGP8QQUZtHdM?=
 =?iso-8859-1?Q?mb5Z7ucCK9rHhfPpisHh46oRCVugPFmU4OYYjhOjTLUnvuR3a9h3xhsVDv?=
 =?iso-8859-1?Q?zMj12dEyNkIIy+wYbXUr5BNmfx+UrPTvKGn1RgCy0cOMKDOXCJnQQmUA9H?=
 =?iso-8859-1?Q?fvkDbqDF3fi3nYawbbm6GzRhT9ZDhG7HgQ07+xWmGcL5DzjFZ+per+n0g8?=
 =?iso-8859-1?Q?wmWzTd8d7uQUVEbObYOU2FA+b/xk/8AmTNwMGv8M03HrhYRoB3RO0xXjQh?=
 =?iso-8859-1?Q?RDMhpPkHVsg8+6+m6TIGcpY7TZETwgcHV+Xt3O121wPnJb+RtGRd0Q7/rS?=
 =?iso-8859-1?Q?bh/hEIfHtEhtlbTRJLxLs1lsJhVbNAyEa15AwqVxvDJESNFIqaMzrs0PK2?=
 =?iso-8859-1?Q?1SXNZuBr5gNdz1SAyLBhjyUaZgpdWDxzY9+SI9tBGU+RdnsK1ItirlwTs2?=
 =?iso-8859-1?Q?WZNi0W8IKzKkyF2HVQNX1o/6Zlq5cOaNLBHx/amx/zM/XkUWxwtnRsJ7Pt?=
 =?iso-8859-1?Q?cIlrqgtmzDZgiUQYfp/+lI4ztJC93h8SwgOlYgh4goM4fBe1J02pHF4Za4?=
 =?iso-8859-1?Q?uIYEr0XX1ASvNSaSIMdjchwHUbUrWxUsR3O+ybjIvtYsBdajdXUt9OUXLe?=
 =?iso-8859-1?Q?+tliNO/eZMHea5H78IlOx4Jxu5/x66fvfdu4lIBN4uaTPToT3ozE1CWSzk?=
 =?iso-8859-1?Q?3W/K21COiAkwHz3WkxYq+Nhu+nheyg5A1r6GnfTijrkZ47ij6deCya65AJ?=
 =?iso-8859-1?Q?euElsuOxcWqb5EXVh/u/me2nojslPRjtGmjh8gE6Ybig/t4seWUZ9D4R7W?=
 =?iso-8859-1?Q?dqbmWNnCPo56XiiqZulk+KFiKpmguZFrw2zDIFI3nOra/P59XekGSETxVc?=
 =?iso-8859-1?Q?G1o28brN2g0BZLWf+7dj2pOW/zScJQ6u324VMNbL0357wKAK7JCMyKlK4Z?=
 =?iso-8859-1?Q?+pnGB1rGTlLzkPZJPHSKPJN6B+qGLD698QUHTOfnwKNqeLDO1qTDfPypOY?=
 =?iso-8859-1?Q?t58WKWryR9Nw5Q7oiTD2HjixgHlSeCT3xYZfx5xdM/QZoAy/9s/jpac9fg?=
 =?iso-8859-1?Q?2KBdDIJtoAUNYbLTjNzeON5Z4jCcLW8S101Hwu0IXcUaaoxD/f9usYIEnk?=
 =?iso-8859-1?Q?+HRH6D1cdAJ6gllFbowDhl2mw4E2SBCn0F?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cae1d3-66c7-486c-ab0d-08db3f11e6df
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 07:03:52.3451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GjvfI6Jmkpby4n9x2Taggsg7zqKUWzkwg/n2/NIwC6PZAsHN/rwAbIqorfBzja018XUdPcTq0BSgQ82PTID/QhAAYP9Q1j8WTVcG2HMGiiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8016
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

> > > Actually, I think that all you need to do is disable NETIF_F_SG,
> > > and things will work, no?
> >
> > I think that this is not so simple, if I understand correctly, by disabling NETIF_F_SG we will never receive a chained skbs to transmit, but we still have more functionality to address, for example:
> > * The TX timeouts.
> 
> I don't get it. With a linear skb we can transmit it as long as there's
> space for 2 entries in the vq: header and data. What's the source of the
> timeouts?
> 

I'm not saying that this is not possible, I meant that we need more changes to virtio-net.
The source of the timeouts is from the current implementation of virtnet_poll_tx.

if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
	netif_tx_wake_queue(txq);


> > * Guest GSO/big MTU (without VIRTIO_NET_F_MRG_RXBUF?), we can't chain page size buffers anymore.
> 
> I think we can.  mergeable_min_buf_len will just be large.
> 

I meant that we can't just by clearing NETIF_F_SG, we'll need to change virtio-net a little bit more, for example, the virtnet_set_big_packets function.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
