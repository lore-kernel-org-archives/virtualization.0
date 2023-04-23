Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D18C77B76
	for <virtualization@archiver.kernel.org>; Sun, 23 Apr 2023 12:29:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 055B38209B;
	Sun, 23 Apr 2023 12:29:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 055B38209B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=b8CzsvrE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tzTVJbkIniqz; Sun, 23 Apr 2023 12:28:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E1E9E81656;
	Sun, 23 Apr 2023 12:28:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E1E9E81656
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE843C0036;
	Sun, 23 Apr 2023 12:28:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D081C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 12:28:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E0EC140471
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 12:28:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E0EC140471
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=b8CzsvrE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mmui0JWasImp
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 12:28:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A3FEE4012D
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaf::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A3FEE4012D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 12:28:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWMabei7k9G4pKhrd4xJEib0k0TRPP8HEbB2k3SnZ7TZp2Xw2+hzFCL0Nrs8S6PCxPOCaZM5m2wKa04uwb61i4PgdtLTKKDtBkO/pDxx0P1IMTG6ob7W+Sf88dDkgvs5Ij2k/ndYZOtiGxHOEBgGygTnIdO9lE9JKGCvtErptHlvNdS6w14Y23KNvOGSxCmOQrYSdgrIvTuW/cQEvhjxUIJ5K7UClo5Yin1ENu8uvY85eTwoZhQvXBmOFwPYPtO5AZZ4X9veyJPjLkogXxH+qtUkeAc3Ov06w0DgLymYoJbiaEd1QOw9RJNinD1L9VK+GGfVHF6cTiA4SiYiM/UBSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNmH4Atc66hkm3Wydi96sqAK5nGAzuRgT9yQHbKIvqA=;
 b=Xv0aV1sR0kZqWvRWBZUev/+zYNiie/HOEVmBRDn8YOQRVFd5u8uW2Wdpcp6hAXWqP/Ca49L81Utu8LnsoFLLB3mhXoSIjwcyWKs/U5zvN2HI7oZLLrhq75wfMV/UzWotPRvOsL7g0uA/3dLBH1HfwP5zfar4nHvgF1iG3hgt65xKvoG0SiGvY+pG8MczdrXuaR4/Afah1tiFu2qKD4vkJKW6jn6qPRve+yFb3F8peJRmfawHRj/ee8JCLdrm6psCwtWiKceaWqvbKRNEERNk/LnbCfeWpvf/LKEId6Ua+jI9BYmbrc4id6Xxe+DcnoVFKL4O7hHDyF1MsCT15AJXkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNmH4Atc66hkm3Wydi96sqAK5nGAzuRgT9yQHbKIvqA=;
 b=b8CzsvrEbV9ZRaN9BlbqkFzPuHwju1OiThcI4XU+2NBhgdzNzH8cZoTrlhOecw1toog9YdysH3MqSHIuSOFNRgltwVz0JVKDU0k8SkSk0seaYF96DNGcpIioxm0Vjvg4MBSoP6QPgo8r0goQVQPflcy/+/BZvMDJ8qdfaApnpoM=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by VE1PR04MB7390.eurprd04.prod.outlook.com (2603:10a6:800:1aa::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Sun, 23 Apr
 2023 12:28:50 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::d2fd:ad65:a6e0:a30a]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::d2fd:ad65:a6e0:a30a%5]) with mapi id 15.20.6319.032; Sun, 23 Apr 2023
 12:28:50 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Thread-Topic: [PATCH net] virtio-net: reject small vring sizes
Thread-Index: AQHZcDeGnH5xR2OGlkuo4s6jvhNMC68uIjT9gABGFgCAAG90AIAAMSwAgAABjzCAAARBAIAABATIgAAENICAAAM4M4AAIQOAgAALfyGAABuqgIAAAQKHgAADxACACRVQMYAACvaAgAAGduWAADkhgIAADWLz
Date: Sun, 23 Apr 2023 12:28:49 +0000
Message-ID: <AM0PR04MB47237D46ADE7954289025B66D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230417030713-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723F3E6AE381AEC36D1AEFED49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417051816-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237705695AFD873DEE4530D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417073830-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA4F0FFEBD25903E3344D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417075645-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA90465186B5A8A5C001D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230423031308-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47233B680283E892C45430BCD4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230423065132-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230423065132-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|VE1PR04MB7390:EE_
x-ms-office365-filtering-correlation-id: 9196a2b9-1dc6-464f-7594-08db43f64ace
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pmM/ImIqs/VjojXHzWfifHbXmBmzm3dtrVgCo1QuTVykA0XoWvoF9qq7YNSN95DKfnPz/XqJAaHCnqMp5a9jZCt37C3iqwVeBPuhcULmJJtRYoHB1XnYw8gSqvniFJQ1iEw+uXc8E90wq9kQSnQeEyL9T3bGU5n8FmOabWZQoCQhfUVkz235pnCNEICGck6b8p7jgQZN7pckdI+Owf0daybv6H0ircHYfzm+1D95M//QkdRPx6aCJymGw+8k7MjoKxw45PLNhLsCIGHDSuXaXjVsC4A0wa3AVU8NluMEN6lcnllECSDpaUZMWw3x0dXGNZ3lezPO5G72qjY9YQvvsAZofYmWksWQVzOZf4BqeOQcN7nAvguZeFrv0kmMerNJD79rzy4DKHmH3zsXDE1MUdyDRwvNou5+K7IJpl2irx/uLdxazjhdZSX78F0cCyq3e52lQzr8JC7BTSw66AtF+44rUujcjku6XdcLdNgB4Aoe9l/jqu7vMPYY7P/nBW0XGhSxVGG9eI6XYB1MRlLAhEy5s5Z1Av5d26DBoUwmSSIPHQSKi+nmL7otbEi0cq2vXi421AIIRfaini/HgR9ojjW1AlpHCYX/dLDi5CV9mdnGwuU6oqUb1/Q9u064kEn/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(396003)(346002)(376002)(39830400003)(136003)(451199021)(186003)(86362001)(9686003)(6506007)(26005)(5660300002)(38100700002)(52536014)(7696005)(33656002)(83380400001)(71200400001)(478600001)(54906003)(38070700005)(44832011)(41300700001)(2906002)(8936002)(8676002)(76116006)(64756008)(66446008)(66476007)(66556008)(55016003)(66946007)(122000001)(316002)(6916009)(91956017)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mnLn2kcqbGiZksE1I+VPW7RTsziE51UWQqZlScN2dJCElfpf6trCGMqjD1?=
 =?iso-8859-1?Q?ahNuxR2EVtqyCZt6wni9qyvp46Ju5Z0Bv/X6amefzBAr64uhKGLMtuByXZ?=
 =?iso-8859-1?Q?WMTMUkcof2mMu/7PeaiMJ+GpJlITWAovgqALN+4/AK3rxno0REUx7MM0P6?=
 =?iso-8859-1?Q?tTAh9jMO6XgVz8T7CM6T0ivXolWmzA+UkzCFUXbo1hIR5BXwaKYcsWnyAH?=
 =?iso-8859-1?Q?rLSsWP5TNla1XIPCF4QzXvoyPGgPgGV6lsLAw2uOY2ASO8nIKgPrVo07GJ?=
 =?iso-8859-1?Q?PhoTsxKLDI9pGtu9SEHOvSS+dsABei5oPqGMjkBVXKa8LLKB/H2QPCNXIf?=
 =?iso-8859-1?Q?i9NGueZ+q5q7n++Hur/xUp52FkE2il2yLAFVwnOfBKa97EUQoeHgBjCMGi?=
 =?iso-8859-1?Q?PKV2GQUKXU++4aDp1jtN51L27+pSYNE+oPhhCaSd3hmCb/54BQhvSd0+qZ?=
 =?iso-8859-1?Q?TaFR7BW5G1ApNbO8hiZi/5ys0P5A6UiHl3biMIcrSQvEudnSsrtjCLL6zv?=
 =?iso-8859-1?Q?d1rPnX1pw8vaQZz/ccCV+mp8omNubzxWCjfHyggJQCaYdcv0GuZJpOrdWY?=
 =?iso-8859-1?Q?EsytSEGLVw9iKB6g62hVhC9UiNeK/N4/ckkr9gczyyTgxxqiXirVwiVuKX?=
 =?iso-8859-1?Q?ltbd9U6Km5oXDmu6lSRZVnlGJMQA7l3G65Czoc0QDFRBQv+dZt067sHcmI?=
 =?iso-8859-1?Q?ppTEOCGkQVqQtHdY+TAtaSgKDkdn+BnfCy7ne5Il6624e/KSUvcgSUAaHk?=
 =?iso-8859-1?Q?uAyGVUTTyEGrxvOBKBssJjS8IdCnAwVQDqHPlruBbbkNaO0+shsm7fhBRa?=
 =?iso-8859-1?Q?c4QQXPOscHNyskF7Pg3PN5Zkgxp5kOqEph77DeNIeUzeHSsHDRdzveXZXa?=
 =?iso-8859-1?Q?6feIypcHSJOCxgY3ug8SxoXepQjM6BPcQG/A9awZnX58tyDhbmMdLinXsU?=
 =?iso-8859-1?Q?f0UtF1JFFvUfK/GfrlKcrUyTLAgH/H0GyWiYmHWSl6dYyvX97rRMrD/eVj?=
 =?iso-8859-1?Q?5Gat2ZHzzlwwDIINjIulkHXm8qEJyrPeIlrmxqZx/KYdPsLVBLFVRBOHZW?=
 =?iso-8859-1?Q?gOv07suNcQrN6MsleL+gDa9NG5T8z//dM5JLsIQb4txidBuRToZj3UETsb?=
 =?iso-8859-1?Q?652yFSaYzkv7d3UYONv6AEjNDqtpKbCTcapWMG1DmT8jM9gSdS38l3pCDB?=
 =?iso-8859-1?Q?DGwRdiHSFMaAazbDr/RybHEycsq+OfHbE7jiEl9YC6kqtuD3jPkOlUq3jw?=
 =?iso-8859-1?Q?q+EcHABcyy9GJf0puanZIWCdxyt1Uau1TYWxlxzuZaanR3b1YzU0mcwRBA?=
 =?iso-8859-1?Q?+ikk6BnAM7uN+vPZO7P9pChGQB4x6UrMybj6mYbF1wCa5ZVnCe0qWEJ4Ya?=
 =?iso-8859-1?Q?ZPlqKp8AF57cIVkGPk1gqidRIElSZ+OBv90Om0Vx4RvRYSfzZJr3E0fVPR?=
 =?iso-8859-1?Q?pHA7sbb8s4l3KAfboieK9iFI/NfumkuIDEpplEhLwY4O29aZXdVpZ94HJB?=
 =?iso-8859-1?Q?YxZxs2v1QuZxQV2TDIVf6z4WW9P03aI6jztaUaMZwqnb+Ve/FkGd5yNAip?=
 =?iso-8859-1?Q?eueVjbMtDziPgpOaAb4GHF3Q++Pf9WBPWvoXdgnZ7hfguffghIzkRzCAbS?=
 =?iso-8859-1?Q?+x1BcDZ1PsXoLhYlMXT2Bg8quf9IqlGYeL?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9196a2b9-1dc6-464f-7594-08db43f64ace
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2023 12:28:49.8643 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZWp4Hgv9TDj22ymad6nAw5E28H4es9fmCM7QRRqzl7zfg6FxJbfCaLzFqn1fBys5Gd9iXOV/8Hy7fu8AopOE2PbV/YfVJWaxrYmpuJWbM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7390
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


> > > The rest of stuff can probably just be moved to after find_vqs without
> > > much pain.
> > >
> > Actually, I think that with a little bit of pain :)
> > If we use small vrings and a GRO feature bit is set, Linux will need to allocate 64KB of continuous memory for every receive descriptor..
> 
> Oh right. Hmm. Well this is same as big packets though, isn't it?
> 

Well, when VIRTIO_NET_F_MRG_RXBUF is not negotiated and one of the GRO features is, the receive buffers are page size buffers chained together to form a 64K buffer.
In this case, do all the chained descriptors actually point to a single block of continuous memory, or is it possible for the descriptors to point to pages spread all over?

> 
> > Instead of failing probe if GRO/CVQ are set, can we just reset the device if we discover small vrings and start over?
> > Can we remember that this device uses small vrings, and then just avoid negotiating the features that we cannot support?
> 
> 
> We technically can of course. I am just not sure supporting CVQ with just 1 s/g entry will
> ever be viable.

Even if we won't support 1 s/g entry, do we want to fail probe in such cases?
We could just disable the CVQ feature (with reset, as suggested before).
I'm not saying that we should, just raising the option.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
