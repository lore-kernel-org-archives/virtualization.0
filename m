Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3175C00140
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 16:22:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27FBD41758;
	Wed, 10 Aug 2022 16:22:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 27FBD41758
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WAV7qGrZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NtkU3WH_gyyR; Wed, 10 Aug 2022 16:22:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 581A3408D0;
	Wed, 10 Aug 2022 16:22:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 581A3408D0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D86DC0032;
	Wed, 10 Aug 2022 16:22:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1EDDC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 16:22:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8DF606106A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 16:22:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8DF606106A
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=WAV7qGrZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ytdsMsAOmxBT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 16:22:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C0B2760F20
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C0B2760F20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 16:22:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJsOgT7uRArtYMxwpIDy6t5jIYX6ayr5+QsWcOYyKy8hACyISoRoMp1EubEH4hVELUnq4zoLZ5cWH0UZY6lhJ2ADLeZqRhMhLOxmO5l9ygL2WXhGcmiQH2yfr47OGR13tTSvYQNdtxKMyATBNj1zno6CwGV4GwQzp+4V8i4Ld1P7cOLHtZIc0UOZp8unBVasIYAoL4+Db2MIkhHl8YFdTprRy/DH98HGskaUix/mztedJVybkaaKdqcAam9byXi1RbbMcgGqGBR//iKXrGkGGBA2QwUdqtBduaVSJ+JUY4MU5zRbdoCRQQ3CXKq4KzOZ8cE0JblMQza2+ZDLRYq77A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYM5gmbxFRkkPfBb0C4c/YUNoVzxFYDGlKUGvdu1Hyw=;
 b=kXWf37JOdwZhwSkUcow2zXqBlMdza1NIAxgc72QTvJP6AxSrOWi4EQ1WlX7A9nAAJT1hBS6HswhD2Rh+PkgmJydvssGw29DzdQfWXxyr1Nmc1PWLl5Mg/nUGnQZd/8GhNTtlDFawLQ0Mxjz25jjqJY+AwRborAS40lCsdkfCABkwz0362Y27Z73C5KF2FFcuPXtVdYajxy77akrqXgitu4+jSPDkqZK3sEWx3F39b6j+EVArY9Ah+G9LOAeGXwfRT04gv9tIlCVcnAgeYBEOoXHp8kDIghuib4DylDGGuSkcGujvKduwETTqpQK/oUXEFR6pp3kDu9S/1qMlS+wIsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYM5gmbxFRkkPfBb0C4c/YUNoVzxFYDGlKUGvdu1Hyw=;
 b=WAV7qGrZMhhD1bHL0L2djsWO/cdvlFbxLoA7vebI1TnJL0oDnrAeVt2tIWjgLZMUb/ZONBgq+FI5hXCGVThZKQPB11rB/A9uCgFsjuCYd9iIpI2kAwiq8u+ZZqXrLf3q5W7dxh/m6PPw3MMGy0owQtaVfClqmS79+j0IB6plkqQaQ79WHaXtMDejaVh8L/UW32Y5wWsSoMHM7e10dXpewZKe5jhRZRsSLDE2UmAnn4M7CHJDqqeQnFbrwInGkIG5lZLT31WcPOycTnkDvpC2Dvts4PDLCoqbNfKVzYDO+IpRMwjLI6VDyIFm81QERSwk0cXKAo3BNW/9/s6SJpemeA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH8PR12MB6820.namprd12.prod.outlook.com (2603:10b6:510:1cb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Wed, 10 Aug
 2022 16:22:41 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::957c:a0c7:9353:411e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::957c:a0c7:9353:411e%5]) with mapi id 15.20.5504.020; Wed, 10 Aug 2022
 16:22:41 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Thread-Topic: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Thread-Index: AQHYpirEKDhT8iEHv0Wl5fiZieJEBK2g5FqAgAPA+oCAARNOAIAAeEKAgAAKdACAALbdAIAAAJwQgAAHyoCAAACEUIAAKRiAgAAAt5CAAAyxAIAAA53wgAAMv4CAAHJzgIAAAIGAgAAMUoCAACJqgIAAc24wgAACiQCAAAQCwA==
Date: Wed, 10 Aug 2022 16:22:41 +0000
Message-ID: <PH0PR12MB548173DD936EF45B07C157D7DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220809173542-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481101A8414FAAB5FCAC537DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809182306-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816FFF167D3EA3EF5F075FDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <62920bd4-1070-a91a-baf8-659009e9f590@oracle.com>
 <20220810021320-mutt-send-email-mst@kernel.org>
 <20220810021427-mutt-send-email-mst@kernel.org>
 <CACGkMEs3HKU0sPMO=38c471hCNu6a_1TwiYbwg0ZtBiENUBwcA@mail.gmail.com>
 <20220810050219-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819E083F0DEBF30403C380DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220810120440-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220810120440-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 441d5919-6c5f-46d0-9121-08da7aec8c78
x-ms-traffictypediagnostic: PH8PR12MB6820:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JiprMG28TPLzG0mI2OM+/Mh8IFG7x7cg10Z7FbGXJcDugmqSaXpMzLL27Hjo15h3MjF+ISGl9Mus8vAq6GAmQYKb+AhQUH0XLNnP5lQWMYEuBHKEDGTWM7uN4PQzR3f5qBLX0+wtynN7122Fx1BC3bw9xWRcsTdpvABDwAZmBZZ2AMU3OTKB7jrwR3eL7H8GIoT+DkiA0KHwohcL2W7OWLCy0JV2A33pzOkTeJiL9zUuKC8lFrHIpuMnbWEHt03RaZfVlxfCtKdn+YvtlEvyBF3gbQYewn8dB6JlZiuzYYJFXQtxz2gx3iefAv2089YEIsU3rnibWMuDzOGl1nceO/itFbPrLq6x3ciD942O/Nb3kDJPJos7afdKPs7hWPB9+5PuA1pBcumsoQaiwBeRotPrFIY/NNBn9c1ig7co8sBYnmeeC+4IGZYGEvU+x3FzzH9NdPBg1xE82s3927MM9T9AaylKq2SCjQD6HY1R/Y9SnUeIWYxQ9e8/CnXFK/ofx0l3DW0aL4C0ulwOl2JVG+bZNZPvcNphoIgdjbYLNBSH9vR6ym/OII/EnRg6+hTOZhm1cv9Iw3/bZeZK/uT/DJtWmYqJ9O3V5zfI8SsvqIqLISIB4ZwNSxGI3xjILiCiu2T8y8YcaDFfhuXdVu53bwjtYTGtym+tT97SV31nepYgNen+qpLQ1fourylpNVuu+MKz6CFYgEIf8Lt7ZE19asFaCaLO0ECxG1SAoH5CTzup4H5I7uEWFsLskJf/NZS8kFr32R7hJOCUyOfAux3z6ZPuycRsN1Y5Q3xxylZLNIVveAkFO1kDLf9/sLdZlYxH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(7696005)(122000001)(6506007)(41300700001)(7416002)(5660300002)(66446008)(86362001)(8936002)(66946007)(38070700005)(55016003)(52536014)(6916009)(54906003)(107886003)(83380400001)(8676002)(71200400001)(186003)(316002)(478600001)(2906002)(9686003)(66476007)(76116006)(33656002)(26005)(38100700002)(64756008)(66556008)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JpqgHBSirIRUD7NAi1aH1OJXe2azGVaPvxvdv8pUNx3Fhs5r3iKK8uVjhlZA?=
 =?us-ascii?Q?7qjZVF56x7I9hyaDFuqRZyEdamS7Ig/O6LYtnNwlUKfywRZ/kMRx/h604ise?=
 =?us-ascii?Q?HjB9hlxarLPW/HE7roYpAA9k6QpyrvqTyyj51vVHmr6tck4MA+v3JBbIJj/+?=
 =?us-ascii?Q?3Sm8qmXKxgYqtzecBHx362x5S1GcAQBjIQFuLnQ4qP+b6fpT2t5Rvdy1jHr0?=
 =?us-ascii?Q?Ra6pQf5zss15pO79r9HsP+DtZYvBZiXoAlMVwFT4MyT4BmrRs7h1i+Ld2LpP?=
 =?us-ascii?Q?WL4gy9pAuCdz16q0hp81dHmsJXE32GGSN+5yEWQ81FLsXHilg9nGDXM+8+rA?=
 =?us-ascii?Q?nl7K7vONiNRZDqWG34HzPdqZh09ka25JygnHXGj8eyRjkHt2hH1aj+sSdoQ/?=
 =?us-ascii?Q?rpBsB3bpmqwtS5913h9e9bIk66aaMwRvLuN3Nw2/q6HJR4cqolYwwx357VHR?=
 =?us-ascii?Q?3sPWw0ma90ywy0r5hWEn4wH5wCbzKDqRvR7U93/8H0hPH8qIKSfSvytmNgPh?=
 =?us-ascii?Q?OSGnVHeNpVud6lJHULP4PVPGAlZiohyIrAQxCci9P7ZuyTk6J1+qEq856kON?=
 =?us-ascii?Q?gwK5P38chwmekgLUaBYTYv/l7hHZNAkILicc1/p8HNuGhILX2lsW55WToF0X?=
 =?us-ascii?Q?ui4wUEzwQYk/k20rMSRlASlFjDTFhmIPwDsFBL7DJSelESdHUJXH8Hiz9RkO?=
 =?us-ascii?Q?UMGUNHa3GY/EKpuEThyq6RgirYKm0H+wVaQyA+02qrhUfzKC+8/Vdtq3ozPk?=
 =?us-ascii?Q?LDKk6A0cqAb4ouZtXXrlwwj0PKxVirUb8N9HlhPhp0UqGWR74B6jr0pL7QSJ?=
 =?us-ascii?Q?LbW5FSzx6Bc5ffThibXOALRmcKmori0ip3ysiFlmaWSs39fvdwEPj+Od+0AK?=
 =?us-ascii?Q?LtFegBLzvyXjckhqf/OzjZglder0uYjddelJIKKb3t8QfQbfNipWPIVlbFNi?=
 =?us-ascii?Q?nbTeoI10dGIaoGN0t2rSdZm3zkv9pfIeHvRD5Q7eg/qCZps5DV2UwENlUu5c?=
 =?us-ascii?Q?/PQu15cEnQo9KBnE+y3pET56X4WI9b0sq53vF7sWs4tvrMxLZUV720yrJMiW?=
 =?us-ascii?Q?wL35vNPA9ycJSnBViZ0qFFhBzVa2WufL8IhI4q3tE+owPzsDFZPSANqNe4y5?=
 =?us-ascii?Q?4597pWaeMdnVdAYHv5oRzNgcKouJPfIhyX9lNex+YsyGHHLwyrWCSxdLaSxi?=
 =?us-ascii?Q?j6AyiSYQplF7I0JwUZAcc6wwsGk6XT2NgLabEtXm5SAo+BhaL4lyqCrpQCXN?=
 =?us-ascii?Q?QXvYmCsIC07E5XHWAL6K4Lxj1dUZLD/xhDzVNN0tDIyZ9NYWmSDAyQUZBAQv?=
 =?us-ascii?Q?96KEBoGNEQHzaA8YJTt62ynmwp5Zq4XkiGRPun9qXGzQgjepLij3+L5x3t9/?=
 =?us-ascii?Q?5yfMdf9lPCGWdXfSTGesnkVqouOvJnO2Z0cyVbf5Ut1LL6gJljxieHG4y5Ji?=
 =?us-ascii?Q?lVc/PC+T1JjuOAAzBjvl+myqulP0ZeblW5UVgLz16tzpgyLBuoUKhtG7M0pC?=
 =?us-ascii?Q?naKgDCgASheQ/5GqPiiXRldC9eWGcIRJ61/aPvWZ4RpGCg2P8X5NESg0v2In?=
 =?us-ascii?Q?i4NmlxEkJKyJTA3usBI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 441d5919-6c5f-46d0-9121-08da7aec8c78
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 16:22:41.3616 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nNrAVNpMHBRSPOtozij+I4id+0GqGl2myW6R1qaFE0KUuxgjH8S8uOnx6MJDmCZA1AoZi2taiaRGmig+OP4Kmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6820
Cc: "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
 Virtio-Dev <virtio-dev@lists.oasis-open.org>,
 "kubakici@wp.pl" <kubakici@wp.pl>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>, "Hemminger,
 Stephen" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>, davem <davem@davemloft.net>,
 Gavin Li <gavinl@nvidia.com>
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, August 10, 2022 12:05 PM
> 
> On Wed, Aug 10, 2022 at 04:00:08PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, August 10, 2022 5:03 AM
> > > > >
> > > > > Should we make this depend on the vq reset ability maybe?
> > > >
> > > > The advantage of this is to keep TX working. Or we can use device
> > > > reset as a fallback if there's no vq reset.
> > > >
> > > > Thanks
> > >
> > > Device reset is really annoying in that it loses all the state:
> > > rx filters etc etc.
> >
> > The elegant solution is let driver tell the new mtu to the device.
> > One way to do so is by using existing ctrl vq.
> 
> That will need a new feature bit.
> 
Yes. ctrl vq can tell what all configuration does it allow. :)
Or you prefer feature bit?

> > If merged buffer is done, and new mtu is > minimum posting size, no need
> to undergo vq reset.
> > If merged buffer is not done, and buffer posted are smaller than new mtu,
> undergo vq reset optionally.
> 
> This can be done with or without sending mtu to device.
Yes, telling mtu to device helps device to optimize and adhere to the spec line " The device MUST NOT pass received packets that exceed mtu" in section 5.1.4.1.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
