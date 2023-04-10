Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801DCC77B61
	for <virtualization@archiver.kernel.org>; Mon, 10 Apr 2023 07:47:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA30640189;
	Mon, 10 Apr 2023 07:47:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EA30640189
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=rAVTL9jQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hjB0Nuiwbh3x; Mon, 10 Apr 2023 07:47:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 42FA240125;
	Mon, 10 Apr 2023 07:47:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 42FA240125
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EB57C0037;
	Mon, 10 Apr 2023 07:47:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEE14C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 07:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A666A40129
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 07:47:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A666A40129
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=rAVTL9jQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 47l5Vt81frfQ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 07:47:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0CA5C40017
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::612])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0CA5C40017
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 07:47:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCr6XxMZ1aWLBpuZgMN/9ki+MbY7PBe/2s5VTk+c0FZoK72A/bP3q7Bzo2qBI7eEknq/1ZGTlbJ48CJBQNmukLHcp6kBDG962zPFPk1pNWXuG1NZKthhhWo251jLvmol368t+3sFqPnOPvZTR7GPvJFbvZC4lSCNOpaozJ3eFj7CD9Jd1tZhayXIZ/WthHpXCicvRDZVizjxI0QERJprcSidueUqZ9Jiy1F72+5Ky28TV8vax+AP8zqe76vTUfEiAypRJnuWwK1BgpxhHyNhsJyir7nX1jiGn95h8CLH2/6lcnQ8ZIv6fxY+NlbrwefFVjAjXBm+eyaq7gMiXWV26Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpfHsqWwB0UpEzmhrZtkcxx/gvKU44HbBP9d0imfL+8=;
 b=McEmZTgtNDS98uJHmai0qrkaPHKpgQtDiegXkIVI0pSCHHYOQIUNzK1Py/b5lucqk07cyE+98YpnSpS1uqV46+pbIUPs/LwMMpTeDtM9GL1xLzvl6BPHl5gQoPylIsg1vJyBlpXeh+nwjagbg25aDYll+XY6DWja75ody/0AxT+uBbCYnkKGelyXoqSWglZ7ysl0VJ15kuLGeeH7RmAXsQCG6f9tYcJVIt2U0NLnMWmrly0t6Zkm0iHJ/WVwWeS3lbrTFdevxriIJhz94a409HBMOIm4/lLzp8npn5ZFq/jIO3XY61Rf7I87wMDVaRCqZlGtIJ0a/y06i5nyQrDgyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpfHsqWwB0UpEzmhrZtkcxx/gvKU44HbBP9d0imfL+8=;
 b=rAVTL9jQXHbjIxvkDZGQynCECgUVM0zqn/WJ+Xvjvk1Ry/N7CNa+IHHUUGh40qjG76IVA+SAADhsiR6NPNy8bl1lTsiRkQZHpf5GQjlnNiX/Q/dryH4pfCjqVMOJ4tZB2SZ3KFIycnow4GXKeii+QvcofKVSOrb8shs2LzEn7s8=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by DB9PR04MB9940.eurprd04.prod.outlook.com (2603:10a6:10:4c1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Mon, 10 Apr
 2023 07:47:39 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977%5]) with mapi id 15.20.6277.038; Mon, 10 Apr 2023
 07:47:39 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH resend 1/2] vdpa/snet: support getting and setting VQ state
Thread-Topic: [PATCH resend 1/2] vdpa/snet: support getting and setting VQ
 state
Thread-Index: AQHZZWIBe5Qp6TTWaUKs4Mm16+1eFq8ZDo8AgAA8M1GAAU25AIAAK+0pgAkPWYCAAFDk5oAADBQAgAABdY0=
Date: Mon, 10 Apr 2023 07:47:39 +0000
Message-ID: <AM0PR04MB472314F291090F8E04AA3137D4959@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230402125219.1084754-1-alvaro.karsz@solid-run.com>
 <20230402125219.1084754-2-alvaro.karsz@solid-run.com>
 <CACGkMEuQpJyQNuYTs2TwCc8SmvynbVwqtcZnF2EEzPEBQnpo5w@mail.gmail.com>
 <AM0PR04MB47239379BDB27553EB5D1E30D4929@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <CACGkMEvOcaRB4eUOUy=GzuGnfeba3wWHWFDNdOgxXVbqyX+wkA@mail.gmail.com>
 <AM0PR04MB4723EA323FFB308A290725FFD4939@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <CACGkMEsFVidKuqmKghZyQv=YnmcfaUt=ZFwv3Wf=MXs0ypCggA@mail.gmail.com>
 <AM0PR04MB4723CD9EAC42CC7CA2381EBDD4959@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <b2ba29e1-e2cd-45c9-c6c5-85e7ef739dd3@redhat.com>
In-Reply-To: <b2ba29e1-e2cd-45c9-c6c5-85e7ef739dd3@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|DB9PR04MB9940:EE_
x-ms-office365-filtering-correlation-id: fd6cad44-fff2-4e6b-abc9-08db3997dbc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aEptuhZhysTPNYBWwX1aTHHPAS58hNFjp0rPJ4n+r5tJWpLPng8477DjYOeDSbkCJaDnNPgSVMYwtUanLsDf3kwmYwfV2lJDXbbK+cHgj1v539jzH4+ud8qNGfvj/B1S8eJPCOdRiyXKtSaPFpWGBp/O8xpz8xVwxmdWkZoluuQEV+Tvf91fSwVOuQLkZTXlkV2ZXTXqbMFnk4WezK3Q+QDzomditjbiwJDm7CMHN4iZenujiqfWCay2eFJ/MpwnTTREWj9MbYi+7S7lej6mVfr2MjcoMBquLMmwB3ALEOJ/gqH9yo1pFgzPZeDAMuLbTKB87iQ9aK+Pp3Q+Ib8yJdo1dk4JaC5pkQ8X8qd4xQqvAQTTbEZwXaOEHQTOwFjaGOJnsYo+c0Un8Sy8shkd5WEqqAo7wRr7KOobGHzYqJ4vUg2i8IO77D1+VKjBhZH9hxtM1reKZyAtI6DEYmkNO40Fq6LSKRh7FvWfuoD2L4BoIlH9ZiDcISzcBjT00q+VqTn6xBIXl9eWy6TGWDD6/i4BGxCFcfKeDP9ODyhx/kqzsQR9M9ile98F4U7FcYOy/kLeBXEJPpH5GZuE1QCYlZKv0ryrd4/AsiG4pvQT0TkAP63d4hn1K4G70uhq8dAe
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(396003)(136003)(376002)(366004)(39840400004)(451199021)(86362001)(33656002)(558084003)(91956017)(316002)(41300700001)(66556008)(66476007)(66446008)(64756008)(8676002)(6916009)(66946007)(4326008)(7696005)(76116006)(54906003)(478600001)(71200400001)(55016003)(5660300002)(2906002)(52536014)(8936002)(44832011)(38100700002)(186003)(122000001)(38070700005)(9686003)(6506007)(26005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0nPUIpO4sz5gFGOOK9n0KgY/3fvOiZalnl0yFNd8rDFFuQ+QlQjUYkT3WN?=
 =?iso-8859-1?Q?LeI2akMVgHxPtbbHI6ixYsZFMHBthSi8OZTIgt25WkDo14NNnNld7VTm20?=
 =?iso-8859-1?Q?fqSORW+foGXFPpu57Xj6h3OKSVuB50Xi/fZuHMnd4pcQGua5LXGPp2OcoS?=
 =?iso-8859-1?Q?zEZb4zprcP/pNBVkIhuMvqinLXim3lvAILiWXxK/dBqJ28UUOcknuaZq+W?=
 =?iso-8859-1?Q?k8wc9bVTc18X/0Vl7GAwL42NTYSNIvAzIxbE5LkXLVtMQMl2lUKTTDx8vI?=
 =?iso-8859-1?Q?pWOvqekNPHxz9qjqlY/uXrLEuC0iR0n6xYIGNWIaG5ysukWHeOgALf+6BW?=
 =?iso-8859-1?Q?ZlIulAYpyf3GJNNSJnjD2pP2MgO2rtgYA0GDNQL9mCwWZlrlNixLyE219R?=
 =?iso-8859-1?Q?Id/yCJ5DggzKdw/YucwAv/cdBoYP0/44hVVM1UuLg1Pp5QzbvQenXGtIIA?=
 =?iso-8859-1?Q?mC0NvfoE57UFylZuFGOhucickakmjLX8Ze5JHrlubUI2E3fZGpuUKM2Fjt?=
 =?iso-8859-1?Q?JEtqXOFjWT75iz+Pc5jij0kwsz8ZPfkOSxXSG9vqwt58oFlG1ArTRYpql1?=
 =?iso-8859-1?Q?W2TipnI1IQ6gZPtM1zzhGGfPOscS++iVDPeSB8xJ03yn1qZ3lhv8H+QIF8?=
 =?iso-8859-1?Q?ZIWKNT6kVJ/wqhUV+oH6NhOIAq5c74LaQQpZ2OrggWW7Nut2zd0ZdfKPVT?=
 =?iso-8859-1?Q?Q4RkO5hXmzT2Qhx6xiye/Nm2wGj94A28gupODGIxxWY5SMsd0HP5msw8ul?=
 =?iso-8859-1?Q?FbZblAsLlZZiN3FuBAISgJHiOrZYCTMrnRd1YZlpfgrtuHdvhW/sde++sj?=
 =?iso-8859-1?Q?ZgnjYffFWVrxYqFmH6Pox58GhkFNmNp95/5n7PdHTaWFkzJK+RK4/jAKVs?=
 =?iso-8859-1?Q?I9c67Tvz2HhBjxwirpu6mrPx8TJIwAGDR/q0C8Wx/TmBvXGOYZFaVyjlAB?=
 =?iso-8859-1?Q?0yI77d9BEMI2gdTTmkKGrvPsf0VIxF7IcsaIISNoMrdX2kU1A3O+Cng/le?=
 =?iso-8859-1?Q?TXMXnNTmxQ5dSBItHAgRxfsmO+dcLgeinB8BP80tF4E26xgIXFRkblat6C?=
 =?iso-8859-1?Q?RcGHuPDJ/57Ju7M4t37whWkbHSjrDAh/MpCYs7QI7qRlBwM2rgA1odL5G+?=
 =?iso-8859-1?Q?ZVF/DakGURQzFsXw9LwnZbQUPkpcbRul0tO9oA//wYgmV5VTPELbpnsVCt?=
 =?iso-8859-1?Q?Oc8uJopkiDkvgDKgqTdebmmFmywBy6zk+p0kb9njhyrfZzKmEIumft2bbH?=
 =?iso-8859-1?Q?zCYCn4mPXCxD8v55JIIj2lHkKAvYlEXKZ9iVWasLdJTIaExls/3TgLNVaQ?=
 =?iso-8859-1?Q?/Aq8QvGzzccNpxCtl2K/qu4KGoZrqsADkSseB8ualERucDJR39AU5ZMiJS?=
 =?iso-8859-1?Q?DbsTkuumUrBsYeV8C04tPAwY9WJERy7lq9iKFc2ZBD5bIahJaXThKEQR2e?=
 =?iso-8859-1?Q?BdKcOeyuwKaUGyWYEF+hIGxlB9dPtHziy1CUt1P4I9EJ68SHaHHFaElesT?=
 =?iso-8859-1?Q?wrLUSmkpVxXA/4VhUMxNvJlL2kUmTKZc3rryWdEJ4do4sA+1P4D48cMjwE?=
 =?iso-8859-1?Q?lEukUNDnNqHzoAl6rwx/4TD2iOaoxo2jyGcQ4VG7W6lKTwiqUGKOkYT3N9?=
 =?iso-8859-1?Q?q9J0eYKhG3ZO3HYwJoIXAWP5ukGzFg7jTK?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6cad44-fff2-4e6b-abc9-08db3997dbc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 07:47:39.2785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: urf88RGj6a2yxteSVsijCHCaoKCmXqUVql6pN6+oJvMloz2zliBUZIstpTRD1U2gbUxjSFD4mXq6ilFaavyY2ehpyJI9Y4vDHSU3ckUoHBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9940
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "mst@redhat.com" <mst@redhat.com>
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

> I meant mutex doesn't prevent the preemption so the process could be
> migrated to another cpu.

Ok, I see it now, thanks.
I'll add a spinlock in v3.

Thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
