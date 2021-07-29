Return-Path: <SRS0=atc4=MV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B815C4338F
	for <virtualization@archiver.kernel.org>; Thu, 29 Jul 2021 04:39:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0554604DB
	for <virtualization@archiver.kernel.org>; Thu, 29 Jul 2021 04:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E0554604DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A40BF83AC8;
	Thu, 29 Jul 2021 04:39:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x6i8yYb5HT76; Thu, 29 Jul 2021 04:39:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4F72183AC7;
	Thu, 29 Jul 2021 04:39:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23368C0010;
	Thu, 29 Jul 2021 04:39:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB5CBC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 04:39:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A8CD83AC7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 04:39:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TRc6LcT5s-2U
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 04:39:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2087.outbound.protection.outlook.com [40.107.212.87])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3670F83AC8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 04:39:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5EpFY/E5+YQYqY7pNzId2nOpzuafskbzx1xcaxj+F4AzMZ/4JuffN+Yw/EXZd3zJK+lj8f13zR1+AcewUECJx1/8QDwX7J2XoZJhlwZS6+QzDsMl5jkn6lggxndbEVp9KMNwatDNEq1mIXpeBJGJe5lyloP7z7rYcl7SYiuZw7kMvtrF+wIpoETU0g+dHBlFRy4KauZgaox7iVnqNP8qW4oco5QCzSPamAAVgy9moYv72mnVBWRdWyUmY5CxPqyGYNpjhxYKtM74ucQrPUEQdi9eCbx8Q1DsQBOM7XW0acmx1Y0+OxqWl4EEzXe6qg+3Qxy+6387NQCHCodcYCt3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+XSDuCjdIEqtPnLR+t8VIAGIbtQWKJVZaXOvnJtM4c=;
 b=S4VderTT1zUdqB9HxVGdbrms51jalrKftATVSAiFy/b60LjewcospTKfEns6GB2sNjcM92v2GYXqf1hVK7/eyoxceBTuI8jkrrHe1ouY1XW2wfbRucnvRZCsHYPIOkvdCZh9z6Vf6kdGOUoLGA3zJpyu9hVM2Zh17D3ZDibSEVrbO5ngttSwMEVtW6hGfX5x1CbNvShTVHlA+XH/1KZul73jw9xqeaoElNEPTWVyR3mYUmPovouq0mYR5lmg/GbGoH8gNYK7E5uPD3IYtjJ9xVjH7BArbPWX8puMNaLV/4vXhNaWTOJPjH8Fq38h+41vatSTJHFesFpn34ltIyRp2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+XSDuCjdIEqtPnLR+t8VIAGIbtQWKJVZaXOvnJtM4c=;
 b=sxB1wVD9h3TF3iDptCmCq62CET/BV4s8YYnRpU4+qexYYwAQ8o6L7dj3VU0bf/W/6JQ6BNqlC+tvg8xkhQzPf9MQWpu9IByYLz6+3uFjP+qqP4fJJhS4tidFkGYFL8Rwd3yf6ZHkIb6jjbtEknsPrAFKUFpR7LJ/vuPR9ehYN9cjnoP8ggGJ+GP2F8446mivYhKKwrAwaI2+6bU2r/AHHiZGV5Z3VfSKRcgu9sSuwQkTKW9LQoAjmnOWEBHvQXx0LROj/dIF6NB0UGtMwmklWpFPtSJPbd89HUGL7+z9tGoMLTI2JKo+rfXykhZ6wMzdmMnTXP9XgAC/cpY1pDQlzA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Thu, 29 Jul
 2021 04:39:24 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ace1:9322:ab32:7293]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ace1:9322:ab32:7293%3]) with mapi id 15.20.4373.020; Thu, 29 Jul 2021
 04:39:24 +0000
To: "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH v3 0/4] virtio short improvements
Thread-Topic: [PATCH v3 0/4] virtio short improvements
Thread-Index: AQHXfjyEgkBpWMMsPk+MOQpth6qjnqtZajIg
Date: Thu, 29 Jul 2021 04:39:24 +0000
Message-ID: <PH0PR12MB54815548E4E659AE8A023702DCEB9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210721142648.1525924-1-parav@nvidia.com>
In-Reply-To: <20210721142648.1525924-1-parav@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f460fcfb-2c28-4048-290d-08d9524ad762
x-ms-traffictypediagnostic: PH0PR12MB5404:
x-microsoft-antispam-prvs: <PH0PR12MB54044742B0EEF440C8EF8C47DCEB9@PH0PR12MB5404.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: guRjoVZLvN9d+PX1tGLKNL3dVGhELud75oYdMvVJixWrmBaMHTdt3bhzt2uLUxo7vqBmiaX90l01TfPxLDDru0I5ZfiEWUVmUmFdvZGhYy/zSA5zJXDylyNOJfI3p+Vsr2tnrce2iOMTI2UMPSXmEUqclmxc9Vel5Yx7cViInzq34LKHkxaPqohgK4L4ewAK0cbXAa4HNNqwVYWPXbEsd6E13ubshFdF456dnmzR3W0AQzqRqgsw+K6E1t2TSBjZMWL9B6IK9di7NYJgvHpu+CMAD/g7VDP1hfGr58c5IzmH0+391Jp2buavSsjJNjJQ0x/6cbVlKDISRCMeHUUanPh65BWp6QnIbkQ1s/9yT+i05jy8acqXpl0KjfDTiIGLOzEMtUSeJL42qvYKt4ezhQ+voh+5yO6Qle25KY9fimYesMARIgo5v54poZXvQC0bh6/misoWnDRNqRFZRbtTmrO8owu3PC5pfdiL1fLbHlnRIZ5Xx2lGL1fGchmME2VSiJbgKwguH1Bd+t4lLNDjZINr409DRhCxWIfWNIT+WbqgNL2XD/QLbWa6jx9GTFIL9nwRHSzDDILdB0Bn5ZydeV4/7kY5SOg3NTrKiTKY539XYFKnL1oD+U+6IAFsmM+wmibcPLq/7ASiNESWElk8+ILTqif7L1EpsHYRu7EN1ILqX4AbSuIeSaoev1xFwyFwqdEHtDtSo/p5x3RG5Of0Dg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(8676002)(5660300002)(26005)(66476007)(64756008)(8936002)(38070700005)(83380400001)(66556008)(9686003)(53546011)(6506007)(66946007)(122000001)(38100700002)(55236004)(66446008)(52536014)(76116006)(7696005)(55016002)(508600001)(110136005)(2906002)(71200400001)(33656002)(316002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dzBJQFZRz1eSxjytR4g5JoNlOOOBfjkgsEzFQjUfBtcKobBPSM0WjkHFOAWA?=
 =?us-ascii?Q?lYvP4EmhWEavlO58b8fFz9mWejZzucDJ3ftaLILoGp/8SnJaENG7DiwlmOnl?=
 =?us-ascii?Q?ynMDiaYB4PSLYRl36KqaIUuQv3kr5RYL7VDoWOumXIG1nTvN9OBMJ3TNXXv4?=
 =?us-ascii?Q?be0yMEr0dZmbhI5D/l5ytfen0YH3J2A18y6iJmzT3AUILmPbOv1ri+Kr4tYG?=
 =?us-ascii?Q?vBUnKJ93thGOifbktyw3mOEdVjSOP7hFp8oJLzDI66QOyzbQzFBqOpkBOgsu?=
 =?us-ascii?Q?034jyAUsra+TNu4MD+ptnzid9hrPqSyWvWgfO0/AAJqQgFT43ozKgeDh+Fhm?=
 =?us-ascii?Q?oN4bh0qc+8fkTT6Bv6zRdu5uOQlxjDAksar5e44MD+79KWTgHEMQLeSpYP0l?=
 =?us-ascii?Q?mj+TgOIn1LQwPPQSeeDk9HULmaXVAWoBfkUm986ZPeepFsTGc0DBmzSHJTgv?=
 =?us-ascii?Q?7jdvsW3VwAiaGWVlAC16NYJJy2yw4egDOmgvk9Uh9uzMoVZr81CqgQKeCc02?=
 =?us-ascii?Q?YcE1TzksMwr1pVxkloNv5cp3R58Tf5/0WrezzgkIARR8wUytgMqKcGYVB13S?=
 =?us-ascii?Q?X+g80eIPgjtc3dToRn0EiVbniyoQRdCFQ9ED6WqzjPTN0pYOzfsg8B2G4jiL?=
 =?us-ascii?Q?8YUbUVi6gpaUgDNROjyMEMXFKlz8iZUhgJCycUpubihFKsymNPsjK2fC/IJ8?=
 =?us-ascii?Q?C/WgYepJqbPipVXDcZ9IUgr07lJadIT5ytmoAAdE5uIq+8yZXX2nDakJCDMi?=
 =?us-ascii?Q?n0T/Zr4C+J8BGpHGxWR3eNKnOCic4V9yrONFzhw2i+kXwVMSUZ+3WGCYNqIV?=
 =?us-ascii?Q?NVnX2Q5cDCWMdW3XcCDi4ieGxWmBnS+Rb1qX4VMq4ZNssb2vOXWeni8vnJlr?=
 =?us-ascii?Q?rXJ3j+teZjVaaDnuJ8MgeGBeACfs32G3M4PZmqMxSxYIw4PDv60oPnNx1fvr?=
 =?us-ascii?Q?kpErIDVk1WIpnOnbXsSkXMkzV5JXbO5ChHiuL+ENffHbVSnOug7sXJbSib4Y?=
 =?us-ascii?Q?kHNv0/zbLIOglm2AVKaIBvh42Yel8vfKYRL5l5Njot/T6jTWxls1fsux3HFD?=
 =?us-ascii?Q?x2GqY8+kImf+fXUuS6JyVFKwHHoNE9fH/ZupdkQm7t0cgsL1+ZeQWFlNZsRn?=
 =?us-ascii?Q?qhP44ABJg/7xICmzNQhV2xVbWVDdTvpEnqT9Fw+KxSQcvVKejiHPaiDw4XHG?=
 =?us-ascii?Q?6So9aGZk+4kcuXUkeaj2vPJgAe4/iB6camCr006aIEdK+Vclv4o/725KToiL?=
 =?us-ascii?Q?iVOw/MnUAQQBCEx3IuzeVwx90XawlBxqFNv8uY91HlroFwusWtV3FImjpf/U?=
 =?us-ascii?Q?MVIoSFiEWW0102EeDkNDpq1J?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f460fcfb-2c28-4048-290d-08d9524ad762
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2021 04:39:24.2236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v7/lKImkZ3f2M+3Ojul8xlijNc38bv7UCaJxzyDJdmkK0rabne9p/u+snDMug5+AOPej6M/o8B9LMX0+3lGlJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5404
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

Hi Michael,

> From: Parav Pandit <parav@nvidia.com>
> Sent: Wednesday, July 21, 2021 7:57 PM
> To: mst@redhat.com; virtualization@lists.linux-foundation.org
> Cc: Parav Pandit <parav@nvidia.com>
> Subject: [PATCH v3 0/4] virtio short improvements
> 
> Hi,
> 
> This series contains small improvements for virtio pci driver.
> The main idea is to support surprise removal of virtio pci device when the
> driver is already loaded. Future patches will further improve other areas of
> hotplug.
> 
> Patches 1 to 3 prepare the code to handle surprise removal by marking the
> device as broken in patch-4.
> 
> Patch summary:
> patch-1: ensures that compiler optimization doesn't occur on vq->broken
>          flag
> patch-2: maintains the mirror sequence on VQ delete and VQ create
> patch-3: protects vqs list for simultaneous access from reader and a writer
> patch-4: handles surprise removal of virtio pci device which avoids
>          call trace and system lockup
> 
Any comments to address or will you please take this short series?

I am working on improving other part of the hotplug that you described to take care in near future. (next kernel cycle).
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
