Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24CDC433F5
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 03:43:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 521F96103D
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 03:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 521F96103D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0E68F40133;
	Mon, 25 Oct 2021 03:43:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9txZuV0-fVci; Mon, 25 Oct 2021 03:43:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1359E400D4;
	Mon, 25 Oct 2021 03:43:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DADCDC0019;
	Mon, 25 Oct 2021 03:43:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1FCFC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 03:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B9BB660768
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 03:43:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id beN5lhT4HPrg
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 03:43:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 422D86072A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 03:43:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8jw7VVkWTYiK/vLzWSLJUdNTklCyisJ4++ht8X3zl6+Hs4/lH5+9YvjtaKonJ30brg48zJ0wc1cMKYYmQPE8IvFGEWO8Jcwlo4vgrLpq5hbHpMCTJpkmkYARScSwQWE3TLm7/xM00IJ0VD1S0CVKDOz8wuoGpsNgwzO6yuySkil/dg1Qt3JXUv21LSzIy2q8aNvjjBUD/CIHdlRefLJDl+9Ojh8K+jdS+dFsvT2oe5dqdtans9JShQGl5fA9/GbaKyoqaVAjW5WT6T/pwadWr9zAv4QNLdy0o0cE2STVTqcqvNeNGLcvlmHRM02W2npjOpPhyJnhrV17VdDaQ23Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2hZC34Y6eJ5VEP2rpfrp7wBOnHp8otp5r8WYew0rT8=;
 b=ZUmgKXDmxZWLIG7FiSCqijZqQo3h267DQECzKL/OiMmXs8/JLBFtzkxS4abgHXfPFc92JkyP5SRkHIEo7zWBB/ZOtHTZ4VdZdfU+TmnzF0fLNgtZCkxtmATcLWWqkb1qfrc3UHmgr6We5BoPufNr1h4hWcwbaKn3YrYK8tZIk8RLA9Ltf/iX8Aa3ha/zADLrX1bOcJ91r27Hvif543H1uZYTle/bGaRUIdzncfGaqhmLkStGZUVZhPjjkOULrrbXSuwk3OrCWsx+Xlq2w+4vWK8ylhLJrMhodgmTyRF3IBwaRUFI0SnAGMNP7IFwE9u/UUEEX31Kyx3p1GazMfgWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2hZC34Y6eJ5VEP2rpfrp7wBOnHp8otp5r8WYew0rT8=;
 b=WCc9Mc+CxN8Z//3/a3Det1GTKe1Vb7EP05DTZqN48EAjuSAwEMNPJIQnrKdaOm63xU4gjZFf1oIcK3vhmaYxdRuZuihfSLzTLK8LuV7h2mp0mqnqKXODNsZrVnrYFSAP3xIkmkYEY29aBI/4Sp3Y/b1l7dsr8duHSuvKhjJIdkK5yD/qPw6/fK9Ucg1DKNXZ2OwFV2f5TIWxVt8MRHWerSi5mIdEt5fNZty9dNWm7d1wJqknKnF5lVpSboe08uH1VseGxYjo+1rlzskFif9HiAc696UcdTnpUX0dExLkcPCApSstrLYJzatNpJdC9ez78ZfuvBc8kVJaEXAvBFNHlw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5434.namprd12.prod.outlook.com (2603:10b6:510:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 03:43:38 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633%3]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 03:43:38 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH linux-next v4 0/8] vdpa: enable user to set mac, mtu
Thread-Topic: [PATCH linux-next v4 0/8] vdpa: enable user to set mac, mtu
Thread-Index: AQHXxpmvqggo5IfRl0a+twGjkaCaeave1XCAgABIAUCAAedaAIAAFFIAgAH+VFA=
Date: Mon, 25 Oct 2021 03:43:37 +0000
Message-ID: <PH0PR12MB5481BA03EA9DBB40EAE8122BDC839@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211021163509.6978-1-parav@nvidia.com>
 <20211022064007-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D9037F79F3118AACDB3FDC809@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211023155850-mutt-send-email-mst@kernel.org>
 <20211023171505-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211023171505-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6b0a787-232f-4aec-cecf-08d99769a121
x-ms-traffictypediagnostic: PH0PR12MB5434:
x-microsoft-antispam-prvs: <PH0PR12MB54349507B1E9BD15FD9D7955DC839@PH0PR12MB5434.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bW/CAfCGk/3xYZyqstrwRdGX4F6AaKD481BiZpqUjvzp0juRZziATYKRzdI1tMxcszhcCB4E//7UKNynrbCKmoUXgXvTZAZKs2XW4TP3AqyTlOPIrXbcPxWcMH9KK8LdygLkulnA2f5wRQjeqmRpPE1xmNn09otqbx34U2rHaY9uaraZKVJFsaMIXtDBQKh7cD5Q6xodabDoxGr8mAVSO4TsRoMNQEOogkq1Anu8USCa+bhjvFtcgRNRVyMxrWzGwufdg28koph06uHtcYrNkB/THwcs/zr5p9X982oP8Nwyrb4vyWIKw98TS3Oft1qZ/vYq5bLFEqFr0HT8L/HGq8AGkOi6fvAT+sItvVZ9dG7O1FYhtCFHYyQ//AuhOyB/kl5xqi2CTREeUn0ASklBUwMfjDgUKhNhzNS4gxB/YJOVIKTx2knCzF2aGBX5bOrAMXo6LO27VNHrDfQVwaqP3cFVYNEGtQBi0GuMp96qdzPyPsK+DxutVXULA46iePyZ97AuHZYlbGzal0+/qbhFQZPO86qkxi+sIFIVK6jBYfvKucISHvKseZTn3+t7wC51RuPcanik+Kp6oL8yJu0JNVdfQ4VNbEF8HLClS2T6+K13AGq8uz9/CS50cngcoKeGTtb08XIluDp0JSfpAz1MQeLv81utGhm92PJlGVinJKaUA35HkIe0fZcMp6/tCtcTbopeGnFa6+FHUmyTuxDPMw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(186003)(5660300002)(6916009)(71200400001)(55016002)(8676002)(66476007)(52536014)(508600001)(6506007)(45080400002)(26005)(4326008)(107886003)(2906002)(7696005)(76116006)(54906003)(38070700005)(33656002)(83380400001)(38100700002)(86362001)(122000001)(66446008)(8936002)(9686003)(64756008)(66556008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xxamh8rMik/RiBukTx773pJkc0jX5+OkwGb8N5ylFKYc5wbR4w/64/zcJZz4?=
 =?us-ascii?Q?MjgJcCewCX48TvpnrTP+Lol1/o5nXVOvkCbAMVDME/XoiRnPMNMt58MmPXiy?=
 =?us-ascii?Q?XbmH+tcpznfzofTWghKWMRgSn1HKtop51WWORA3Px6kl8kQ6acpMxifLyCLy?=
 =?us-ascii?Q?1WyQrENtIVqHamrVdY2ggo9uCwRG6ssx8SCMd8BLX4P/4yyXmnNVKtZB2O0N?=
 =?us-ascii?Q?LRjPSiuBoU3RZfN+H2h6KQOJoznXyyNgCBS26eINTrV8BJgTEIJPIQmz9JLU?=
 =?us-ascii?Q?SqRT5ARMQIOiZFMy27tSCXD5ndaeGJo+rksPJaG3pl4Eop423gdz5qA4FUo9?=
 =?us-ascii?Q?1Wn0KAwrI74300orvF67auawgGxprD/6zZ3k31orV3NycZgpBUEDOQhkpfzl?=
 =?us-ascii?Q?omQbvFg6bUHRlYu8rMe5SnfJCnAGixxmVdR3824JJvun8Lts642O2VYeG9f6?=
 =?us-ascii?Q?2njPBu2F/8BIYedSlLWdAMnwqNEZChL7n7KqdxvAQksJP0wKVkDQL4Gd+3Gp?=
 =?us-ascii?Q?Pfpw5GrCvDxBge/FMDG4aHw1h4/Aav9VJbxUZP/PrPLndyVfS66pU1VkcoUF?=
 =?us-ascii?Q?1bmEbsxwnDed5FPPAcQeby85Mw+zUkMRppNXs8AI561jfw6ZY5oihhG0uwgO?=
 =?us-ascii?Q?WKZt39P/tw02yMT6g8nS5Z84XUuyoPoBh0XlDHqvS3E2dNpPSHYQvNAXkr1j?=
 =?us-ascii?Q?eV9223qBEJvzM93ezj/GqUgtQxJfnxiGbN2eulZ+6dqg8q8pY8KYGtB9dRTi?=
 =?us-ascii?Q?lRMY13vMFjdPxtfU3mFBvEh/FnmuISkssSemB9Dyob1Jq1dBoXLwFueHJwXY?=
 =?us-ascii?Q?kdI+tX+Z6iCmNCW1N2+YUlaIgaEJPJPeQXCK8F9CZWoAc9GdxKct13nlCYTM?=
 =?us-ascii?Q?Dk3dch2ScsviIsvpImx9isqTKrDYwSfDjx2Zo10zT/DQQT/qYF/kjEaKiNas?=
 =?us-ascii?Q?stRdenaFFVqOXPTFoWzxpAWY+Exu9B+dg9XwBNU3K9bhwiB5MwPYqaS8IB3y?=
 =?us-ascii?Q?jWHSo/PmtoZIwjSC+2i97dAF84YS1xLHaJsxdsmcLat+5UO+WY5TeMOnfQCm?=
 =?us-ascii?Q?VoDL7Ddi0LrVUP2pIh+XrzB/ctqNYctyLKcR/xM1yIYqrH7NgHz4zRNJC8Zi?=
 =?us-ascii?Q?aM7ekHTldoYTe0u0mjz0imzQSZhZQjXtVHjEKJbXlzUKYPuJN95poiatL3rF?=
 =?us-ascii?Q?ycWaDxIu7c0gWZAmJoLfczVIGyqX06yNPSG4kH8/ApKZgeY6S0jNpcR1Lw+7?=
 =?us-ascii?Q?Bx0SJJBaTh959VCLLo1V39KjoUkdhMIdqOT6tBOhZ1AM5GmikYvaR57i91A2?=
 =?us-ascii?Q?TTxRhcVFrDiuTgyRlumWmFigpgE6BXpHdf1z84POrot2hz27yewTJuo/MKuW?=
 =?us-ascii?Q?CDAhNP0LQ7AFQs0Nok65hqzj6yjCvPqmgynbcQI9OfwesDrgxn1pjgv41Kb7?=
 =?us-ascii?Q?XTMGUt/pZbbN9C/9uA+Eo/Q6bZ6N4O7dnrbIbu4LncWPjeifa+0qI1lQhqUC?=
 =?us-ascii?Q?/73iBlV16X0IqEfUqh8aTFLBOrIKtDHG0j0ZqPYGmfNTo6IwbF0T8Y6Fa1/n?=
 =?us-ascii?Q?f5apDGd6mpYo2fAJrvD3acgu5aBSLRMECtK0x/4Q6CmGdoVM6G3ERIDHseRc?=
 =?us-ascii?Q?kg=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b0a787-232f-4aec-cecf-08d99769a121
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 03:43:37.9467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OVfsFMwHdrxpM1xFa6zrRlECOTgI++5odUmLxGYoxVFR5KGiv/CMAnl15IKXHbQuAKdS6wzv6T+ODq8sw6pw0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5434
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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
> Sent: Sunday, October 24, 2021 2:46 AM
[..]

> > >  [    1.243559] Call Trace:
> > >  [    1.243559]  virtio_queue_rq+0x1e4/0x5f0
> > >  [    1.243559]  __blk_mq_try_issue_directly+0x138/0x1e0
> > >  [    1.243559]  blk_mq_try_issue_directly+0x47/0xa0
> > >  [    1.243559]  blk_mq_submit_bio+0x5af/0x890
> > >  [    1.243559]  __submit_bio+0x2af/0x2e0
> > >  [    1.243559]  ? create_page_buffers+0x55/0x70
> > >  [    1.243559]  submit_bio_noacct+0x26c/0x2d0
> > >  [    1.243559]  submit_bh_wbc.isra.0+0x122/0x150
> > >  [    1.243559]  block_read_full_page+0x2f7/0x3f0
> > >  [    1.243559]  ? blkdev_direct_IO+0x4b0/0x4b0
> > >  [    1.243559]  ? lru_cache_add+0xcf/0x150
> > >  [    1.243559]  do_read_cache_page+0x4f2/0x6a0
> > >  [    1.243559]  ? lockdep_hardirqs_on_prepare+0xe4/0x190
> > >  [    1.243559]  read_part_sector+0x39/0xd0
> > >  [    1.243559]  read_lba+0xca/0x140
> > >  [    1.243559]  efi_partition+0xe6/0x770
> > >  [    1.243559]  ? snprintf+0x49/0x60
> > >  [    1.243559]  ? is_gpt_valid.part.0+0x420/0x420
> > >  [    1.243559]  bdev_disk_changed+0x21c/0x4a0
> > >  [    1.243559]  blkdev_get_whole+0x76/0x90
> > >  [    1.243559]  blkdev_get_by_dev+0xd4/0x2c0
> > >  [    1.243559]  device_add_disk+0x351/0x390
> > >  [    1.243559]  virtblk_probe+0x804/0xa40
> > >  [    1.243559]  ? ncpus_cmp_func+0x10/0x10
> > >  [    1.243559]  virtio_dev_probe+0x155/0x250
> > >  [    1.243559]  really_probe+0xdb/0x3b0
> > >  [    1.243559]  __driver_probe_device+0x8c/0x180
> > >  [    1.243559]  driver_probe_device+0x1e/0xa0
> > >  [    1.243559]  __driver_attach+0xaa/0x160
> > >  [    1.243559]  ? __device_attach_driver+0x110/0x110
> > >  [    1.243559]  ? __device_attach_driver+0x110/0x110
> > >  [    1.243559]  bus_for_each_dev+0x7a/0xc0
> > >  [    1.243559]  bus_add_driver+0x198/0x200
> > >  [    1.243559]  driver_register+0x6c/0xc0
> > >  [    1.243559]  ? loop_init+0x149/0x149
> > >  [    1.243559]  init+0x52/0x7d
> > >  [    1.243559]  do_one_initcall+0x63/0x300
> > >  [    1.243559]  ? rcu_read_lock_sched_held+0x5d/0x90
> > >  [    1.243559]  kernel_init_freeable+0x26a/0x2b2
> > >  [    1.243559]  ? rest_init+0x2e0/0x2e0
> > >  [    1.243559]  kernel_init+0x17/0x130
> > >  [    1.243559]  ? rest_init+0x2e0/0x2e0
> > >  [    1.243559]  ret_from_fork+0x1f/0x30
> > >  [    1.243559] Modules linked in:
> > >  [    1.243559] CR2: 00000000fffedbeb
> >
> > Thanks for the report. Parav, could you help bisect this please?
> > I also pushed out a new head with some patches dropped.
> > Could you test that maybe?
> >
> > Thanks!
> 
> OK I think it's due to Jason's change to virtio blk. I dropped that patch for now.
> Could you try again with the new head please?

Yes I will try today as soon as I recover my server access and update.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
