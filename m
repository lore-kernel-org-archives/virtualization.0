Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D698C6FD18
	for <virtualization@archiver.kernel.org>; Tue, 25 Apr 2023 13:02:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 27F75408DC;
	Tue, 25 Apr 2023 13:02:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 27F75408DC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=Jq/Eggzn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rW-5fVSvawMB; Tue, 25 Apr 2023 13:02:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 70634405C6;
	Tue, 25 Apr 2023 13:02:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 70634405C6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46932C0036;
	Tue, 25 Apr 2023 13:02:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68936C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 13:02:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 34EFD405F0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 13:02:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 34EFD405F0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J3sjexjoq1dk
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 13:02:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B730C405C6
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::604])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B730C405C6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 13:02:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ktt9LIDYHFu3O3UBhN/e9BUjU1znTv3U0OKm7ogMkD8OJ+S0vqQvpH+/hFG6uqwCUWf1IZnxVfivshIAXccofwL9kIR72OIRdXR1CBLEmuEo6p8JPkA7jZfxQ179SDSCAR372wFN8RC0AbBQc2o1kqvvQAoDY7HEKXuXuYuKaZqedbQkEy37EdjK8MDvEdF0ujtOm3Xv4ZflIOj5s7s0ZYOPEIdQpJqiclW3NAiKaE6bfnh5L9+CrYooTEVRcSiTJUM57QYdOXVzKdp9K+8ibJ9CPGfs6rGBQ7gh8GIFgsj6r1GwSetFBwdioYTWyxQ3Wt7QF+9iIzWf1XxAAn7jhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5nXzrKyMN2nQRVA9lKzE1CjyRt9uI3etfyyyRgJXMk=;
 b=BEle8rqbl9Zvn5nYSA1Zdud4jnqp1R1vDx/wI2y51n8Cai6VOMhMbAxQDJlL6g3HYoI5mvScx47rLnEBsG0wqI++C9jhceFW+U57zGGJJIv1BEaZkG8tuN2USj3YWOdH0cicjQgiz6oVNaB8G4WRFBq+FY0oAuCcCJuIVMszN4dEVITa9Ak2ujpIz4UOVpalHOR2MjUwVemYwsiUklqqSeMdskk7nyoPM5Fm3te7mdlNHOEH9l9/YWYl59l0FwwiowKtZKuWOkmYCVghfKNzSj3xic1SVg43rtXT9s2FnMcCOUZu5BDd162GMysXwKp8WrdjDLZP88x4+3/39YQpWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5nXzrKyMN2nQRVA9lKzE1CjyRt9uI3etfyyyRgJXMk=;
 b=Jq/Eggzn2VM7lm0qUXcWcCKDdLcbYEZU2w5WayVDrqz9XbFNIr0GCROLbvvLah/75fAGffKN/XUQgCZhkaWI7aQu18WODAMF5wPejK8dpvqVepRo59uKoG/SWtDS2byVhGISy0Ao7iNJnRtH3+BuXxREHv/pYlFqayUm4BE3tNE=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by AS1PR04MB9431.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 13:02:39 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::d2fd:ad65:a6e0:a30a]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::d2fd:ad65:a6e0:a30a%5]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 13:02:38 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Thread-Topic: [PATCH net] virtio-net: reject small vring sizes
Thread-Index: AQHZcDeGnH5xR2OGlkuo4s6jvhNMC68uIjT9gABGFgCAAG90AIAAMSwAgAABjzCAAARBAIAABATIgAAENICAAAM4M4AAIQOAgAALfyGAABuqgIAAAQKHgAADxACACRVQMYAACvaAgAAGduWAADkhgIAADWLzgALs2ACAAATeH4AAPVUAgAADdeg=
Date: Tue, 25 Apr 2023 13:02:38 +0000
Message-ID: <AM0PR04MB4723E38859953B6C531D3E5CD4649@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230417073830-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA4F0FFEBD25903E3344D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417075645-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA90465186B5A8A5C001D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230423031308-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47233B680283E892C45430BCD4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230423065132-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237D46ADE7954289025B66D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230425041352-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723CE2A9B8BFA7963A66A98D4649@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230425082150-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230425082150-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|AS1PR04MB9431:EE_
x-ms-office365-filtering-correlation-id: a1919bb3-12a8-4d02-c928-08db458d58f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3mLjFGzj/3NYVyimOdtpEvvFlPEHi3eJTUSC62nW/E1GnGjvwjFFBGeyiCUd4SsyVMZvNOPE0e8Rs4G6aqibJEaeJzoEUtVRQkjPybXxUHp1K8289dD8/hRFVNqy7M27KTF+O/9OW2wSsXgu2dgkqhaX2X/+Eu/sInyD4xrhVW7VRzSepVZhMNiXBgrc3YUpHX4IEHuR2xl9yz8/5orF/K9yyP99yaPE0XCcyaP13nqzpGemYC0leznbNl08+yuifnSUtqEHoXmmr0HczQbqM/pA2BVIjN9gTpMPX5lEcBue8+ACQDNfm2Ald4nWcf1ncnVzN69+yihum8aaqMcQuxXhgxyFsaLJ2yOyOpUd5MKSvLPKbSwm0/1q53ZnKUDXPIvoT7mkh8zdsm0H0A/rXTvgtlk1mDTnqstWqBxsTJwLCnxJCGLNqaqrO4s3GQWGGp3jCLqcIZgsPmdEnTU2AeTUFFLvCeXTrE6MAV5d2jO7ZXP87+sZnqeAIQezCTBsgWUiQFG4ufDVwhFhDO7FKUn9wvP0GyJhZ4geHeLfjI40BcN+CL7633NaanxaaWp3z0rJ0m0WoNUwufGWPx9LeC0VosUzDjzIQrquMP2F5dg96y0I4krti0BRPAjHubzV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(136003)(39840400004)(396003)(366004)(346002)(451199021)(38100700002)(122000001)(6506007)(9686003)(55016003)(186003)(83380400001)(8936002)(44832011)(33656002)(2906002)(8676002)(52536014)(5660300002)(478600001)(54906003)(7696005)(38070700005)(316002)(71200400001)(4326008)(6916009)(66556008)(76116006)(64756008)(41300700001)(66446008)(66946007)(91956017)(86362001)(66476007)(66899021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YQ9xsjZfEKAAssIiBXEsoNBSQAK5Vl/blA9h8qzsTBJdJModdD23WoQsrf?=
 =?iso-8859-1?Q?H28uRS6mAynx97hLuP0PVVfp0k97BuJtGkaxDuOnl2tYTjUmlS2RhKMkK7?=
 =?iso-8859-1?Q?141LBx8+f8MKvc5G/nXO+LFF38brD5AcGgbI0QxAyEZ8AtI/f9XAbpHTek?=
 =?iso-8859-1?Q?ZCAOLddiKP02XW/k1w/5BGZiF8icDHSHKes0BsoIt3ie2uFZR/mPe8WvE4?=
 =?iso-8859-1?Q?vr4F9KLIz6QdFLYNxIwzMsvSIK4RWT0l8nNvVHmgZNnRRBeeY99EMpFEoq?=
 =?iso-8859-1?Q?qN9kumouva0BxKTKjJ4Ki0wHzcAL3z3GCpaQgBYrSd5/alqV/Ljd1D8/HU?=
 =?iso-8859-1?Q?oZKgZvEvzTPEyiL3IxgA0pQnvIk2xBp45JcJt3JxTvkPQEWcXFP7JRWY/a?=
 =?iso-8859-1?Q?rUlyjwQp4DWguHg0ZUw6zEWYynLdtpDyh4bhDvPVOa5GHeCf0raH6KbEYW?=
 =?iso-8859-1?Q?cqwm1R1ihwDjATyk4kOqM3HWXDoGvX4GahpKc90dI6hiGYizgEkg9AR9/v?=
 =?iso-8859-1?Q?jDzkhMW8whifqmjR72mm2kAUA+4dFlxehhRjnLjKtlvToESv9Hhsn1WxyP?=
 =?iso-8859-1?Q?fmhGYdaBLb1l0KLM8BWjBthlYRd4oxLA7EHcAEtonrnwV0ser2X05Wyzty?=
 =?iso-8859-1?Q?0ptGbUT1j9U1xtpZz0xpbOLi6hBm7zedMVk8o7PXSnU+gYj01nu6NGvhCh?=
 =?iso-8859-1?Q?b+YYzw4acEEvQbwp4DwqRDHtpEQZcauq6SnhzoKTmpS+6H2TMXUF2vZWFu?=
 =?iso-8859-1?Q?qwVmaPWK66yiZVyXoUVv/daYpvxQ5UjOYiTJK8uIwdJ/XOnjFpj2NdUKX0?=
 =?iso-8859-1?Q?NclEKRngqMx5bGCbr3HxIcFyjji3nP81tB2jjNf58Ep7QojB+kOBRVGZcw?=
 =?iso-8859-1?Q?kDM+ZREi3CxjZg4Ld8RC2Z05cxZ0lfd2qjeV5361RlOAzm2jRIrd+NtBJ+?=
 =?iso-8859-1?Q?cd0BsJPQPjTPN3Yba22+68n2I0S1eZNTB0IsJzgzeITKXtzghNkIVjckJE?=
 =?iso-8859-1?Q?Rx9iD41I46WgNCrSlBQ3pGomnbu890GYJEifO4T+4G6zpdLKfvd1hBxvej?=
 =?iso-8859-1?Q?nBM950zeOwHO8EO7iardUQfUn/4MJtmzH9yj4GFGVbnoo52WTvD0jA7KBt?=
 =?iso-8859-1?Q?7EddLEc+vE1o7Dfv+WYmIY1i8+vf7Uum0f6nsc69mFj9lkJLc/OkZsWsYJ?=
 =?iso-8859-1?Q?Qd8YAoPONMogd9aY6eT7FJJ2skoo4W67xvk9xcim6k95z62nRxeDI1WiC5?=
 =?iso-8859-1?Q?1HfCM4ae34c4Ojjs8gzzX8Ce8wzKK4NQzK2lwKaIh0ossocbbGpJSMCgTQ?=
 =?iso-8859-1?Q?qVz02kkEAta4JZkx2jDfsq127v0wpZ/ZHpYQE1Xk+c1UYOcZl7q41cTh6m?=
 =?iso-8859-1?Q?IBa+wSXmN6tVbM9RNxm3gNfThMBNRN6bNpKMTkBVoYRTooDYMmpbaApQ3v?=
 =?iso-8859-1?Q?5GIV8id0o2J7s8NWzxZ1QBHjBjaghKjzWk2SHx2gUwvVYBzlJRgdRnifzc?=
 =?iso-8859-1?Q?9b4vZshE2c3wGdP59MA9oZMwz3GChDC82tgpTS8CPyMgphfDQEcY+m2S1y?=
 =?iso-8859-1?Q?ZKM4J9lCLsQuVhNVg+gUTM6sREvdw7bquY3FSYG3YWLOxuaWiIDH6lVRcR?=
 =?iso-8859-1?Q?Tn13Z5KpYeVyvSfil2yRQjUYd3SYGF3apROcKOaNw92jOnSkD441Bz5bhq?=
 =?iso-8859-1?Q?hUemCXAo1P1WEH/5utod+B5BapJxXClVgJ6f5LvAF2L9o1DBjLvjsArQh0?=
 =?iso-8859-1?Q?LjwA=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1919bb3-12a8-4d02-c928-08db458d58f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 13:02:38.7662 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vVbCG61Y4y+YvAhNzXPjzVJTZkmxeEpEZbVlnIR5L5wx8P7H379aLQByiyQYWXnAHNWxqVi5hwPuOtGvCZiWKuwNQFW4rPyDmZXowiJnAvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9431
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

> > In the virtnet case, we'll decide which features to block based on the ring size.
> > 2 < ring < MAX_FRAGS + 2  -> BLOCK GRO + MRG_RXBUF
> > ring < 2  -> BLOCK GRO + MRG_RXBUF + CTRL_VQ
> 
> why MRG_RXBUF? what does it matter?
> 

You're right, it should be blocked only when ring < 2.
Or we should let this pass, and let the device figure out that MRG_RXBUF is meaningless with 1 entry..

> > So we'll need a new virtio callback instead of flags.
> > Furthermore, other virtio drivers may decide which features to block based on parameters different than ring size (I don't have a good example at the moment).
> > So maybe we should leave it to the driver to handle (during probe), and offer a virtio core function to re-negotiate the features?
> >
> > In the solution I'm working on, I expose a new virtio core function that resets the device and renegotiates the received features.
> > + A new virtio_config_ops callback peek_vqs_len to peek at the VQ lengths before calling find_vqs. (The callback must be called after the features negotiation)
> >
> > So, the flow is something like:
> >
> > * Super early in virtnet probe, we peek at the VQ lengths and decide if we are
> >    using small vrings, if so, we reset and renegotiate the features.
> 
> Using which APIs? What does peek_vqs_len do and why does it matter that
> it is super early?
> 

We peek at the lengths using a new virtio_config.h function that calls a transport specific callback.
We renegotiate calling the new, exported virtio core function.

peek_vqs_len fills an array of u16 variables with the max length of every VQ.

The idea here is not to fail probe.
So we start probe, check if the ring is small, renegotiate the features and then continue with the new features.
This needs to be super early because otherwise, some virtio_has_feature calls before re-negotiating may be invalid, meaning a lot of reconfigurations.

> > * We continue normally and create the VQs.
> > * We check if the created rings are small.
> >    If they are and some blocked features were negotiated anyway (may occur if
> >    the re-negotiation fails, or if the transport has no implementation for
> >    peek_vqs_len), we fail probe.
> >    If the ring is small and the features are ok, we mark the virtnet device as
> >    vring_small and fixup some variables.
> >
> >
> > peek_vqs_len is needed because we must know the VQ length before calling init_vqs.
> >
> > During virtnet_find_vqs we check the following:
> > vi->has_cvq
> > vi->big_packets
> > vi->mergeable_rx_bufs
> >
> > But these will change if the ring is small..
> >
> > (Of course, another solution will be to re-negotiate features after init_vqs, but this will make a big mess, tons of things to clean and reconfigure)
> >
> >
> > The 2 < ring < MAX_FRAGS + 2 part is ready, I have tested a few cases and it is working.
> >
> > I'm considering splitting the effort into 2 series.
> > A 2 < ring < MAX_FRAGS + 2  series, and a follow up series with the ring < 2 case.
> >
> > I'm also thinking about sending the first series as an RFC soon, so it will be more broadly tested.
> >
> > What do you think?
> 
> Lots of work spilling over to transports.
> 
> And I especially don't like that it slows down boot on good path.

Yes, but I don't think that this is really significant.
It's just a call to the transport to get the length of the VQs.
If ring is not small, we continue as normal.
If ring is small, we renegotiate and continue, without failing probe.

> 
> I have the following idea:
> - add a blocked features value in virtio_device
> - before calling probe, core saves blocked features
> - if probe fails, checks blocked features.
>   if any were added, reset, negotiate all features
>   except blocked ones and do the validate/probe dance again
> 
> 
> This will mean mostly no changes to drivers: just check condition,
> block feature and fail probe.
> 

I like the idea, will try to implement it.

Thanks,
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
