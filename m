Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC712C7EE21
	for <virtualization@archiver.kernel.org>; Mon,  1 May 2023 11:41:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4DA6D820DD;
	Mon,  1 May 2023 11:41:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4DA6D820DD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=Sw01ouCl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ms9AszNxInGE; Mon,  1 May 2023 11:41:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9CD46820E6;
	Mon,  1 May 2023 11:41:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9CD46820E6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7790BC0036;
	Mon,  1 May 2023 11:41:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 909B0C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 11:41:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 77E3740A14
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 11:41:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 77E3740A14
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=Sw01ouCl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ddNsVzax3I8B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 11:41:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7D1BE409F1
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::61b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7D1BE409F1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 11:41:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMvxRw6aFt7KVoUPy3in642S6mDxTWALNPQQTtgBHowEGGCO1uOch/PfZB+aOKuTw4zCXmzP4ifbvty5pnBmimBCHiEObbnaRZO7NpVHcHlGbl8ZKMXX36FP6ZGULrnMnDWcvyzbK6bSYFNK0bRE4A3W9GLYFAQ1TJpsyk5bvH4fLTmCR7bkPka1B8EAVfqPW1Sc4Ot7DlpeYq/lM61/z7tI9z2/YdP1VOkuomE/U0/6G2xTE9HOXrALrhhmXkh5ThNqQDUsuxy2aozHphQeOGwF1SXS4t5GZDGq8rnLMMDhDaZ1agizQWZKlALzRE2//jqWA4JL0YTijPxKSM2KRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcAInZbJBJqgfhVKDgOZdkc2KP1MXt0/S7HFcHBWDwU=;
 b=ZuhOFAv9PLbum8MysTmf9JVJF85CJwhhXmgvr9jIKvJUsqGddRgtpHHi0kq9rhQMyNMjvalH+O/RnJdsJZBOoGyhLGM1wcVf8x9rqJD85K1QmzisuYgp8F2+TNzXApzyhyql7iacBl8SbmP5P0yqAOlasaKHgtT78ZGF7h5Z8a5HRyspfZlNeEthkUduNk92y6NhROPr2jcvttq2AyygLzUpBgIrmBhgsyoe/TvoM5lTtDRQmoiUxqoAu6gCTuujd35QPsTX0ndFUt1/YF2mqF/pZPK2Ulb84XlJwrYTk2xKa9pQi5hoAXnN3qJqH6Sf7PHNiHKSFg8/znKFhpAFFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcAInZbJBJqgfhVKDgOZdkc2KP1MXt0/S7HFcHBWDwU=;
 b=Sw01ouClehxyIwV6BlmCW0pKWyhfscxo3EsxBrzzBEKBkz5AV/75bJBVktOrFmTgbamkiUSQUyLtQpo3qJi+LfX+EMrQYlzJRL/WTeoHJHJ6xZ9aGCu00s/q6PvFSijemIdQnmt0SwBtVtTkX4fI9i6jk9PbIMfHCDhwOAtSDmg=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by AS8PR04MB7925.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 11:41:44 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::a5ea:bc1c:6fa6:8106]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::a5ea:bc1c:6fa6:8106%5]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 11:41:44 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH net 0/3] virtio-net: allow usage of small vrings
Thread-Topic: [RFC PATCH net 0/3] virtio-net: allow usage of small vrings
Thread-Index: AQHZe2XUAgTluM5nJU6YPxcdS/aP2K9D4yuAgABAXH+AARTDAIAAB/SV
Date: Mon, 1 May 2023 11:41:44 +0000
Message-ID: <AM0PR04MB4723E9A0AED11B60360D27C2D46E9@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230430131518.2708471-1-alvaro.karsz@solid-run.com>
 <20230430100535-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723C479C388266434DE415ED4699@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230501062107-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230501062107-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|AS8PR04MB7925:EE_
x-ms-office365-filtering-correlation-id: 311a3fac-74d7-4708-715a-08db4a3909e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bFEDHnrjpgP+QHQt0Ny+pol3rLxbXbm5InyWqp4LGBgDXf+MutPur9BhMFhaQ5qyB6JdHf4o9c8+Jap7slrl3mRDi0kTQO1+pW3a/LJ8AUcm9UD0UGQNXURCFJaKql4y6y33VTFXcl9A0w9knHqZ4FdRenZhEGPycHaGEdQAUFjXrSkPzUYUJ4bBN0fY4Qw4slUVjI0NgjEOgNQ5j3iLfD64oNm1We0U0nxxsh8iuRpzkSq5Q5YbblmpMNgKT4B2BWnUR35kQq6BQZ9Wm5KWLxIbURkC2OCf9RH29eRqTAXR6cwnUT8M2usaPU9QzU6664iZG666whvTRO0iqjSTPT7FuYG12x3Wt1Wbtx0xNomvbEIyFn6hhDOszDqlQpGvZ8h/qcRwKmYSiEXGucl+W1Y8i0v2qIfWX33sagtgAuuepbEb3eHu5Mytxd2XpqfXG6TyOU4jpFX/t0VAzcRdMulo3ewExs8X7XaM1bS8ZL4qBPQHvzlRHCLUNrVtFnk0s/W6bUVkbU3o/lDHRZkmJgLsFJtUe58DOCch0ILHc0J+2Aq0+h1KD/u0wnYTASNuiZB9FshrthPW0JmHbZJGaO/YQPoUFw6LUnStqk7R6Ss=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39840400004)(346002)(136003)(396003)(376002)(366004)(451199021)(478600001)(83380400001)(186003)(4326008)(54906003)(91956017)(76116006)(64756008)(66476007)(66446008)(66556008)(66946007)(6916009)(71200400001)(7696005)(9686003)(26005)(6506007)(316002)(8676002)(8936002)(52536014)(7416002)(5660300002)(41300700001)(44832011)(2906002)(55016003)(38100700002)(122000001)(38070700005)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fboXAPH8iTHZG/R2+cleJts3o0oqIKW7ybZBMEhomzjKDqKf20eoZgOk8F?=
 =?iso-8859-1?Q?Uuro715BudtojZgIb4RhmB/J5hbu+NCie/XRkqC0zllIi1As0sY3tHu4Bh?=
 =?iso-8859-1?Q?Gj29RwRm2f3BFMP5ai2f+gIS5cHKt4RQMF4r8Es9S5aTRsMAtrM7FhVPy8?=
 =?iso-8859-1?Q?uxyKKUvdiCNtxqYga/eTnbgnE0H7RcNoz37GMcA8AbCCc/v5j1QbEal2L7?=
 =?iso-8859-1?Q?eDp6dfdN9rWjp8t6ptWEbAtZSKikbnaXUCdnkz15dFqQL+O3BNHvr9VDMg?=
 =?iso-8859-1?Q?mKoWdqMAp2Y6vD0sXroTrZ8Pl8dL2TofhNKC2xbDUxOIvgzMyRr5O7Ie9h?=
 =?iso-8859-1?Q?bPMSEdeIK/BLwo/nb2gDzvy8wWC8NZAjMOrHdKbsSyL++QrBKDwKoIP0xT?=
 =?iso-8859-1?Q?EKdqG0buKykpZJpmAcdcA3yCLJ/3awQXD89SDoRXO/dDhJurPXnSH7AybW?=
 =?iso-8859-1?Q?EhLjyqtjz5LLR1B0a+6FGX23+/gHPOuNiczRmkHERIewuoaw87BOuHDTjs?=
 =?iso-8859-1?Q?e6dalDf7PYsPhUJevr7fk8QMTXaMpcara7VtJynYJSDrzlkaFxqtUl7ced?=
 =?iso-8859-1?Q?eyrocHE8jcbvUslHgknY/WLavtYz7QzxCmAkArMsFYx8ImEgNslkGTgQG9?=
 =?iso-8859-1?Q?F0KfojZwl6wihilYJeKhoqYzZaO4jJ0mc9rq88V9hSci0gof3fus4uBU6K?=
 =?iso-8859-1?Q?5EryPX8sHx52qg79ho/+gupRGt3KHj3EDyn5tCBLc+JO/TZpx+kMHe6S+w?=
 =?iso-8859-1?Q?KIzR3lJb4GZDeoecpm+GF3oC0zkm8TTKKuDEsf2PiEkxU5gkPHA7EKoOAv?=
 =?iso-8859-1?Q?wV939XcPoOWb2+npQSV19Flbsh+7Etu0adIFLQmC4/xDR5SC0QFaHpZr/+?=
 =?iso-8859-1?Q?jgwARTAJfzoOvYD3JbPxL1Sy5QMbNW4XrkeUS4v9ekanzDqKkUdIwZ3t6L?=
 =?iso-8859-1?Q?oe8dcyz3d8ep5rUAg9fJ4Ijq8wkIIk+xjIlLOTpiUWSLW6ombOhmmEJA58?=
 =?iso-8859-1?Q?sooSE8P6fT5xgcgGh+m7vXohJ3hR6sv6Ycqzgq19L8BAKDAt7hgGCo062H?=
 =?iso-8859-1?Q?T5cs935Kmi0hJWtt2xkNxZEEI6PRMZpqEyqx303vvC84qWDm6aeZeI1XoD?=
 =?iso-8859-1?Q?F9gY5SpS4JTSkoiVdYpinBkeiTUJqhAuWdexdR0XxmtuY1JtCADTFaBTGP?=
 =?iso-8859-1?Q?l3Lan/CkCrhTOWyEmuN4O2b/e0xqkqiPTtZ/XXenzGc8FimDzBTdgusxal?=
 =?iso-8859-1?Q?8Am7YtIFkW8hpmH59F0zcnEqAE8icS/uXgSaRNQpRaretuhGaZmiCXMjbA?=
 =?iso-8859-1?Q?HQseF0BMAq0BmfPndNdQ6GPzZSQFq3IrlgGhwCwmcq1ssGse5agjtEGr8y?=
 =?iso-8859-1?Q?G35rqg+L8+OhESYOLymKZsGMSvzE7lhmKvMmp5U7T8VCjmXkbPGQbCv9xI?=
 =?iso-8859-1?Q?/Vr59svxwpOI6kG5AEPnNrC0xqvPNj+OMEV7ayfO8Rf8drx0t2kzzRLrAY?=
 =?iso-8859-1?Q?yYWray81ZVLKDViOuZwsXEG8quUzEUIG8JbJwFYQW5LD7TxCHyhkcbBPEf?=
 =?iso-8859-1?Q?ntsPIrbafO7BHAU/b0CYcx7icAZcqttueBsiRjkyq80z+wzqnPmgvWXvAZ?=
 =?iso-8859-1?Q?tXtXaWfgYpf9Wcw2famGESuThpU1xN6F4e?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311a3fac-74d7-4708-715a-08db4a3909e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2023 11:41:44.2741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4EsOQnlNpJztqsesl10QGPiz7HlOR5IWzOsdSgsIjkN8ms1TnM510RE41a4pp7NHl6jmXSa4wBsxtL3e9MAESfZCLRFHXSS2WYP2OpTqGe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7925
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
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

> > > Why the difference?
> > >
> >
> > Because the RING_SIZE < 4 case requires much more adjustments.
> >
> > * We may need to squeeze the virtio header into the headroom.
> > * We may need to squeeze the GSO header into the headroom, or block the features.
> 
> We alread do this though no?
> I think we'll need to tweak hard_header_len to guarantee it's there
> as opposed to needed_headroom ...
> 
> > * At the moment, without NETIF_F_SG, we can receive a skb with 2 segments, we may need to reduce it to 1.
> 
> You are saying clearing NETIF_F_SG does not guarantee a linear skb?
> 

I don't know..
I'm not sure what is the cause, but using this patchset, without any host GSO feature, I can get a chain of 3 descriptors.
Posing an example of a 4 entries ring during iperf3, acting as a client:
(TX descriptors)

len=86       flags 0x1         addr 0xf738d000
len=1448   flags 0x0         addr 0xf738d800
len=86       flags 0x8081   addr 0xf738e000
len=1184,   flags 0x8081  addr 0xf738e800
len=264     flags 0x8080   addr 0xf738f000
len=86       flags 0x8081   addr 0xf738f800
len=1448   flags 0x0         addr 0xf7390000
len=86       flags 0x1         addr 0xf7390800
len=1448   flags 0x0         addr 0xf7391000
len=86       flags 0x1         addr 0xf716a800
len=1448   flags 0x8080   addr 0xf716b000
len=86       flags 0x8081   addr 0xf7391800
len=1448   flags 0x8080   addr 0xf7392000

We got a chain of 3 in here.
This happens often.

Now, when negotiating host GSO features, I can get up to 4:

len=86       flags 0x1         addr 0xf71fc800
len=21328 flags 0x1         addr 0xf6e00800
len=32768 flags 0x8081   addr 0xf6e06000
len=11064 flags 0x8080   addr 0xf6e0e000
len=86       flags 0x8081   addr 0xf738b000
len=1         flags 0x8080   addr 0xf738b800
len=86       flags 0x1         addr 0xf738c000
len=21704 flags 0x1         addr 0xf738c800
len=32768 flags 0x1         addr 0xf7392000
len=10688 flags 0x0         addr 0xf739a000
len=86       flags 0x8081   addr 0xf739d000
len=22080 flags 0x8081   addr 0xf739d800
len=32768 flags 0x8081   addr 0xf73a3000
len=10312 flags 0x8080   addr 0xf73ab000

TBH, I thought that this behaviour was expected until you mentioned it,
This is why virtnet_calc_max_descs returns 3 if no host_gso feature is negotiated, and 4 otherwise.
I was thinking that we may need to use another skb to hold the TSO template (for headers generation)...

Any ideas?

> > * We may need to change all the control commands, so class,  command and command specific data will fit in a single segment.
> > * We may need to disable the control command and all the features depending on it.
> 
> well if we don't commands just fail as we can't add them right?
> no corruption or stalls ...
> 
> > * We may need to disable NAPI?
> 
> hmm why napi?
> 

I'm not sure if it's required to disable it, but I'm not sure what's the point having napi if the ring size is 1..
Will it work?

> > There may be more changes..
> >
> > I was thinking that it may be easier to start with the easier case RING_SIZE >= 4, make sure everything is working fine, then send a follow up patchset with the required adjustments for RING_SIZE < 4.
> 
> 
> it's ok but I'm just trying to figure out where does 4 come from.
> 

I guess this part was not clear, sorry..
In case of split vqs, we have ring size 2 before 4.
And as you saw, we still get chains of 3 when NETIF_F_SG is off (Which I thought was expected).
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
