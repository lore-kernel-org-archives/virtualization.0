Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91423CD98FA
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 08:01:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06F9840933;
	Wed, 11 Oct 2023 08:01:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 06F9840933
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LPnrlCcE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZT-2f2kvlbwy; Wed, 11 Oct 2023 08:01:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8EF91402FD;
	Wed, 11 Oct 2023 08:01:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8EF91402FD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65CC7C0039;
	Wed, 11 Oct 2023 08:01:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50943C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 08:01:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 38DAA813C5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 08:01:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 38DAA813C5
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=LPnrlCcE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CkPZGqG3CVGu
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 08:01:01 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::62b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1A594813BC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 08:01:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A594813BC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsqXqs9DZnLEDG8ZouraDQuhIAI2XNo82E2kYxZn7WAWS5HR6CC6/eehjIpylQuYryU4uH5T+6fjesoXSHfvpcXuiNO2048evEcUj70t/XaywxVD4vhfyXhY7OwdHQvTjVHckd1VzsMe3LuFf/Eu8leU3aJ2Kbfx6kICcPMnKMSCLhvnjuJuFE3wnQ37tF3ey3z2IrE0zzm2/1a++RJRWXF4HbJoy78GRJAqsuw9uAJWtftvuL5D2a7LbjOuosNYNsIGwVIvAOF0acFOaIsy7XC7KJ/2V420TKQNy701/WUD/OddohYuFhk96m8/LXY8bxAfwbuOXng65b1nthjGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8L2hYGmH1ZGfsuGswhZoTR7tsIEhjis+pokK/gNZ2k=;
 b=TDYdCjopoXGwQTaBk5dSOxv/v1Adt8tROK/x8HhT47E0SGw/bD1yDyPVzjfR2smY9kKbw2TtYk6bpAkZIlRouP3AhiaiW5KEE826wSw9OhxoyEyTDQvq+ov7Whdogp/mrLezhjO+oGvZCj9kPwBeGSa01K90Dtzbv/7Hzn26BjW+6YLPL+D/jPbX1LlqzFL8bnfqaqgpIo/UMu+FtuIX1poSIb4DJBFDvxz8vdarLqdqqGdd9fOKdH4T3U+jeCrQst9sdC2GFRsTtJfG7GIt5sxYHpgTkoD09NMiuZTvMvjNck+scwYMXEmzxUJaOayW3+dT+uT+biCWmLQIRBMrQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8L2hYGmH1ZGfsuGswhZoTR7tsIEhjis+pokK/gNZ2k=;
 b=LPnrlCcEeYkMmEDgU/dUi8q7D6kbr+k6Dr6SN+AzGDUsY+9o1vp+g/Zvylbc7tJr4IIB58l5JepUdRBgSt8lhndzCdQ8HLTWHQzHJa95JPZXmXXUzGZgG5XUK5dhJ166SZyqNxudajx7J0oY/rkA4MyZUzi8Pxo5zBR4Hd9HgM2BgLH/XUvlKmJtxn/GhZUq3ifZgMqeHHY4X0i+mF5MVEsvV/JaQYts6mJTH/btTpkEho6vOT9izGwSh6WF8G9F3/uPJVwBz+c286cZ+aJk402y6Jw2PdaTasqLUeVR5xUj1pxyITr+sXzkBuOv2K3ugzj9YbMtCljm4eTpj+94Kw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.40; Wed, 11 Oct
 2023 08:00:57 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::23d0:62e3:4a4a:78b5]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::23d0:62e3:4a4a:78b5%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 08:00:57 +0000
To: Christoph Hellwig <hch@infradead.org>, "Michael S. Tsirkin"
 <mst@redhat.com>
Subject: RE: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over virtio
 device
Thread-Topic: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Thread-Index: AQHZ7IkOMX5QOSCSWUux5r7dl0LIwLAmnGSAgAZfpICAAAe+AIAJFnQAgACSqACABEvdAIAAJyoAgAGzmoCABkm1gIAADLUAgAADlYCAAAy8AIAABEkAgAABdACAAAx8gIAA7pMAgAAIaoCAAARrAIAAAPtw
Date: Wed, 11 Oct 2023 08:00:57 +0000
Message-ID: <PH0PR12MB5481336B395F38E875ED11D8DCCCA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <ZSAG9cedvh+B0c0E@infradead.org> <20231010131031.GJ3952@nvidia.com>
 <20231010094756-mutt-send-email-mst@kernel.org>
 <20231010140849.GL3952@nvidia.com>
 <20231010105339-mutt-send-email-mst@kernel.org>
 <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
 <20231010111339-mutt-send-email-mst@kernel.org>
 <20231010155937.GN3952@nvidia.com> <ZSY9Cv5/e3nfA7ux@infradead.org>
 <20231011021454-mutt-send-email-mst@kernel.org>
 <ZSZHzs38Q3oqyn+Q@infradead.org>
In-Reply-To: <ZSZHzs38Q3oqyn+Q@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|LV8PR12MB9450:EE_
x-ms-office365-filtering-correlation-id: 0b6d1945-2d98-4dc1-ecab-08dbca3033ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2HMMcY2n4D84LNCsMgV17jwCb5iKuruqj74OS/WQp0g32k86eYgRpkZWuvff/xxpMF1sxQzxCq5OZBDmrZG8boBaOrL0rrk2QzkfdqcHC9ZpQ8Hfv4/ltaz+SDwcUDlQ1OxC3vTGblPOsZAsIkXprVKVkEWRz5g7tPuYQrhq3tBf8S0Kv1SeDR782r9oSmBCkJQU4wo0VQ3ZI7XOMLEXmNCH6UY0RuxdTfHeKjdvZa3oZ6zxxLuFQh7fTrR5EpY/SsPRRyG/Jg0Qjr4VFl8UKwPBkAamPHq8FrS+Zs/kvoHBpcOCXCUlomkMltVw2Vw1aGjGdk+v0F5xGh85n2TPCx7hcEl8v1MKgxQHwj384G9e+HFOPDQKkPp5+nn/WDmvPLl4yN/ueX3f6323uvyeTqeEepOVPB0+5aifbr0bzdAzUY0C2y0YcNVfr/S1mwVyxrqg6YWFugPRt7oVfiZq99c943/wy+//VCidP4LuBt4FAt/QO1K3pTXWDX8NG6izII8vVYS1VZVmVhDu6VtxxuMBKyb59UxxsfmvDw0j51iwrExrxJu2XmRPWsF1OV55SQ+fXSFOiNaFiGLJnV9cuO5gzQ5KVCb6TpW68n+gpIPswldV6H9wAis8IXlbbN3M
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(83380400001)(107886003)(26005)(66446008)(76116006)(2906002)(110136005)(66946007)(38070700005)(316002)(66476007)(54906003)(55236004)(5660300002)(64756008)(66556008)(33656002)(38100700002)(41300700001)(8936002)(4326008)(8676002)(122000001)(52536014)(55016003)(71200400001)(9686003)(7696005)(86362001)(6506007)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CbxSz5+UygEV55akElPvqcBRbjA4Wx+NtdaWEVkls+tawlV6Hz0OkqaQItK7?=
 =?us-ascii?Q?9BbO1RHyllVmg1NUyvpDfU1ceDOATEbQnrKOyPfXDq6MVW+b2SyC0XR0X2PR?=
 =?us-ascii?Q?oD9cuw3rbFABXAhLGxULv/RL8u+kf+0ieQM4bh/5S3aHJp7H6bFK2jX+6USN?=
 =?us-ascii?Q?SnPcpnMWYV/ytgTlHtbvexfQI10tqQ/7P+JWZiR1GUrBQoOEf+xElouYoGJs?=
 =?us-ascii?Q?ILgLd4FROpG/0WYSVU9jClXvEMOuOlhhbPd5dfGqq39xnXZuaclcoaiWq0Wv?=
 =?us-ascii?Q?0Ms7kintF3ceKf64CdxsqxArxRw0A/FMcLECveRzJK7PVt781YlFaTI7lH0O?=
 =?us-ascii?Q?6z4RnlITGqS9ywTFmsR+vJzJoz131pBUEUlBw3PRU56SXX9xkIIfmRt/pLHe?=
 =?us-ascii?Q?sk5Ll8s0XrWrPvWEEXH4zbFtZsy/Rae9f+MdlEppihaCTdQLJCDCiLWdD/Rh?=
 =?us-ascii?Q?9y9sk2dZX5WcqLEYxCPEo7lfwn8g2N4b23vjatbLACizx+78NkZhSE0VLdGp?=
 =?us-ascii?Q?+H4hpvb6Ry5YQ1db+BHLuziVYGPtm1zdBO5RdwVhuTd/hg5Sua8egCXRssu8?=
 =?us-ascii?Q?VczsmroBklk43so4kJYHknAd5JJU1NZvoXWf3/buHtW+CNe3ptijScVYZb3y?=
 =?us-ascii?Q?cVtGHk1aC9pO+4nF+3v/iV4/lxjdAiLQuNZ8F2iDYows6GLNCP4RhA4LZURD?=
 =?us-ascii?Q?YW+o+fuu/0IIPNCYCyU+PSS+yu+duYFAJq8Y1WD2cI/ouNNVPw5QthQIoatC?=
 =?us-ascii?Q?66TJIUpa7/ytKkwlP9Rt3kDnzlBBxNAvfd0PaVp0jMfkSCO4HMS4pKFfNrOc?=
 =?us-ascii?Q?xEFUjw2uvPp5cIr5pBMxZCfZjp7BcoSFvzsuy7fk8ViNzNvjjFAT+0FsgIMj?=
 =?us-ascii?Q?uxgDLk0RA+qPamvreIiTHkCc1ls7OZvuEABTmp5kWFxu+9gP2vauMujHinkf?=
 =?us-ascii?Q?mvobPcCofE0vpbXXgSZBmYeC8PKKX7NQVHO+gO5m6s1HzapQ4DgLoOyzXyqu?=
 =?us-ascii?Q?kuALVxBQbrhPbb147prYJ+nUg5sbcD56VwIqk5N7ijopK8O5IOSWgMzh3IMc?=
 =?us-ascii?Q?hRymFFdj8z4XbFlwHEdAz/B1+RbSWWVsxcd1yUeeWYIVUPhDsILWHWcZCWrv?=
 =?us-ascii?Q?eU78QuOWLdspUi/3JMx4nR2C3H0RseMSHWypYlFoOX+axqKKVPRhLFp1yLCo?=
 =?us-ascii?Q?1jA5Cin5XNrpwRPD4YpMwWQCWq+OX0mqpCN30Ruh3MR0Z/lt0fuP4kD9pop+?=
 =?us-ascii?Q?q6Xygsoz/4nhGR1QBztYT2jzLQwoTJ+O9C/nClOWVKCbeMnnJMvlZIvtMjPi?=
 =?us-ascii?Q?0Mg7Eq0vfRCNSxQHAwakqPjyAm1ZlQ18dTCzqrBii9S1HnAuFqP23ZQZsu0W?=
 =?us-ascii?Q?KD8ikuKKf5lVWurBLOly7/u66iavWZGySn7UbYJ3IvnPSAKQUz4rzy8Wuja4?=
 =?us-ascii?Q?gJVfK6Y6OFk+tpG+R5RNaM6H4UWgYNZuMveu+xe2yp+2u+cIUfHnMF358/uD?=
 =?us-ascii?Q?briumWF3K4LnISt52ybUUW3xXzwC23Rb9HtSTDGC400mhG2GUEMbCtqyrLil?=
 =?us-ascii?Q?3fX5rKuvwHHBH+3fwxI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6d1945-2d98-4dc1-ecab-08dbca3033ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 08:00:57.6893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aLU8tskRFYagBLnEdwV1O/X2y7iv2Ua2sRfqlajtQmPhlem5ZOmvcdnSXditPwumPc4g2wUA6/thdNMgGBvF5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
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

Hi Christoph,

> From: Christoph Hellwig <hch@infradead.org>
> Sent: Wednesday, October 11, 2023 12:29 PM
> 
> On Wed, Oct 11, 2023 at 02:43:37AM -0400, Michael S. Tsirkin wrote:
> > > Btw, what is that intel thing everyone is talking about?  And why
> > > would the virtio core support vendor specific behavior like that?
> >
> > It's not a thing it's Zhu Lingshan :) intel is just one of the vendors
> > that implemented vdpa support and so Zhu Lingshan from intel is
> > working on vdpa and has also proposed virtio spec extensions for migration.
> > intel's driver is called ifcvf.  vdpa composes all this stuff that is
> > added to vfio in userspace, so it's a different approach.
> 
> Well, so let's call it virtio live migration instead of intel.
> 
> And please work all together in the virtio committee that you have one way of
> communication between controlling and controlled functions.
> If one extension does it one way and the other a different way that's just
> creating a giant mess.

We in virtio committee are working on VF device migration where:
VF = controlled function
PF = controlling function

The second proposal is what Michael mentioned from Intel that somehow combine controlled and controlling function as single entity on VF.

The main reasons I find it weird are:
1. it must always need to do mediation to do fake the device reset, and flr flows
2. dma cannot work as you explained for complex device state
3. it needs constant knowledge of each tiny things for each virtio device type

Such single entity appears a bit very weird to me but maybe it is just me.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
