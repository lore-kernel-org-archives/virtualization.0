Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCD9E784AB
	for <virtualization@archiver.kernel.org>; Mon,  2 Oct 2023 04:38:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F3ADB405FA;
	Mon,  2 Oct 2023 04:38:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F3ADB405FA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dMjTgKmY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iEOVa02Y7w6E; Mon,  2 Oct 2023 04:38:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7B746400FE;
	Mon,  2 Oct 2023 04:38:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7B746400FE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B20DC0039;
	Mon,  2 Oct 2023 04:38:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F115C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 04:38:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0D8D0401C2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 04:38:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0D8D0401C2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 55J15PkFsj5W
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 04:38:41 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::62b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 89784400FE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 04:38:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 89784400FE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cb7jUYBvHnP6IL7XuDV4Nt7tZe19yxQPqGueZ2VKNpRqkY886CeuqiDSI6oz/elL92kWN3t6wKivF2OOTtCB4IazYgqJHWenx4vViGev/u9PC34pAE5A9nU0PvV5mIiocik+ReE8ufTZYBja6vT5MdV445NEWISisJZ8gm7JzmwQTInnowhNlVCLCgGVj63oYGRm3sy74LRHXJiGSexV5MjsztwI4x57TbaNRxSmxvbhk8oLAQ3Wf3AAjKuF3obk+Yc646RANO/iuspYB2luOVXl+edkMQJLXsxUfWeFepaDAl3v+49S6BxOajGGsPCOlrlm7XKjKPPJMA0rrP4oUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGMfIryoOxpJMe4pj8DRTQe/R9z8h+QxXnrwWOZ3Ad8=;
 b=HFhineToa5WqzfBNLBucF5LbLJ5hScNp09Ez1iY6CJSHu5aiUJs0JVpV5d/KogPrm0GkPiyRrNZfCHu8Qqflyw0IzTp2AGNDP9YYd6hsQG/2eHRW/EijwJ+z8ysZGfGhgZJ3cTgsW/nDqChMzxVYKaA3fNGF0DH4hYLANKXIloltTD3oTSPR1FlCz8tW/vLr67Kpkt+ImkWXAI+zahLgEXxqkeZbZLYVS/ij4AegzVYUQCv97aZ30exkgVek8/sc/rahhwBH+vFaw1X6hYYPCZLZgOH/KOLYTvlp9XcmiieMYmCDTSf5gn50RuzsxxC8Whuv4Pww0JwAXQO+wMwGrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGMfIryoOxpJMe4pj8DRTQe/R9z8h+QxXnrwWOZ3Ad8=;
 b=dMjTgKmYj4q7yKG2cMCl0TtTF1WgMeFRD3s2D0tT7nYADt5gWKhrCpT2vpsiaDaJvLHQMGk9b2tof+dF9qJVrQ5fmrOPtoExF4qSim4rgyrbOkyIqGZOHcjTnzHVfim/VYVlf4Hm/W+TWmuxvsJAelwbXIgck4ShsNeL2hiSijGMqMqQUQlPRCBw0sPYE9fPLkKjw/XjkuW3nj7kqyWVADEZlIhCJlgbpz6jepjRAhJxxBel54xvZYcebGN6PGPRzl+PeePw08pFm6yhPA69ltdTV9O/5CVSjWpaEs9TnbyJ2Zz4sm47KfbeorGv3mVHYdmeu+2KsobQNOROn0KhpA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Mon, 2 Oct
 2023 04:38:36 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199%7]) with mapi id 15.20.6838.029; Mon, 2 Oct 2023
 04:38:35 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: RE: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Thread-Topic: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Thread-Index: AQHZ7IkPl5ENqOgMC0yEzkOHANq/CLAlsuwAgAeOC4CAABvLgIAInWVA
Date: Mon, 2 Oct 2023 04:38:35 +0000
Message-ID: <PH0PR12MB5481C50663C257C02F617AD4DCC5A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-12-yishaih@nvidia.com>
 <20230921135832.020d102a.alex.williamson@redhat.com>
 <537b6b22-892e-5ecd-cc46-2159f37dd3d7@nvidia.com>
 <20230926121955-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230926121955-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ2PR12MB8875:EE_
x-ms-office365-filtering-correlation-id: f7e6b32f-0797-4478-8f74-08dbc3017089
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AWDkJboriAJLWTt8Q3Xuzmjfwk75pmUBEv++JJif3S+IhRo2FMBHlJW2scbGs6BGPLYTe/19Vy7h5qitSbC73xgnGF88cWdtWYBxARYp6yIsIrJSZ2OlI2ZeEs1DIk4VDar8hRioT9LLWjeW8QSlkMw/Zp0W0sY2zYKlIiKs6ytcUZOdXUg386c3AsygShgbXs6hfjGXVl+7r5RIPNF1A5gcF7m/t1yqoZErZiovVXWhKNZQQ9wH2LOm073j1uPeJePn5j+cIoUiU7+vQGPtRDaODziL6YffnLeZeefjQ8IBR6ZnrIg3pIJpaRJMP6Axjf4TXPxtZYX0hBBrBGtC64zshCy7qEb8ob8Gho0eKkdJZyK80tRShxPokANRcxUVagtb6A6SJ+s4sH21rhIiPooH0kjicZFb1hH4nuwF541ZmbHuZAZCXHmVxPg3IGKwEY4Jk2EwW6I3CR8xVU1yVSMzaEd0lpqDDEaoGrdbfX3ulvs2Jfo/l6v0xQAfToRRTV9ZhvK+NfkcLGq1TRl1sIGm/Jp6H57M1lCnQRRe8yZWNvSy+n2betSMmwVkYF32eGBY0a2FVeNpS8yLgwX0iMawclU+tll2zBHfqfkL/or+eaQXs4zYjEsiFwtmzAam
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(38100700002)(2906002)(55016003)(38070700005)(33656002)(26005)(71200400001)(9686003)(7696005)(6506007)(107886003)(83380400001)(86362001)(478600001)(122000001)(54906003)(66446008)(66556008)(76116006)(5660300002)(66476007)(66899024)(110136005)(64756008)(52536014)(8936002)(6636002)(66946007)(8676002)(316002)(4326008)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rLtRKXXintwylKeUuJKBolONG0Cgu51FkRn0J85zVSBKFSdBYv/eJl6/ujog?=
 =?us-ascii?Q?dvY361F1x9ZmtjOgoysPTYJf60QRJ8jrMuHeHIb/NNiiZBJzyiX9LOghk0ys?=
 =?us-ascii?Q?QiggSg5jg9Z8dzHUuRFZ0L+alZrXXRw/rG4bmTx8S4q5ksKjFeYIQ1OZDPnK?=
 =?us-ascii?Q?bOkHu57BOhAO8Q1Y81HcnNqvQ3MXaMKHAaLzVEKDgHIDB+5lSyxT7DlEKMGc?=
 =?us-ascii?Q?xPtfXystFt3fKAkyjHwYK0R0UB31MGgAie5ge1DfbdoRLtR6bzSWF0AwIxQi?=
 =?us-ascii?Q?n7arMX2ORn1zuxGzaHvRD+ef/EEYJjsG8qAZ/g06L5/KwAPqMiUQ5iUEodAr?=
 =?us-ascii?Q?IRTK97L3HYq+4iRUs/pg01P54vst4nqqKmiwdjd/gqN/OwFvT+C++iIzdWoo?=
 =?us-ascii?Q?q/0Nk1KLX356uKm55Mc5Y7oBwhXsdNH2ayyuGmk7wgqXHdnh8mGD+91Ga/T4?=
 =?us-ascii?Q?TJkuOeqX54KHjmP2TExUz4u6FVupL5CTVbEF5k92HGy7a9yizMbKz9GP1Hlt?=
 =?us-ascii?Q?USe5QyAVglTbYay0pJP+Jczd+aW6Yg5UUcEbwtzhZjpzxeShFIAN7ByQnj71?=
 =?us-ascii?Q?7KFwsC/Yg7QtKpFWT5U4YOVJt5BCf/IYaV00Xznb0K5ZIoRAkWlaiR+0Vl+w?=
 =?us-ascii?Q?JT2gW3Soeyiq4PLBKu/4sylohhnFBwuVmv/Vw/bd8ObnBNq7riwR5Yo3d+ep?=
 =?us-ascii?Q?KK2SSnBTCmvjCjFDoqO4z7iU3S/iNb47hQsd8DwQSh7BiCgw7lltPSDWcIBr?=
 =?us-ascii?Q?X/Ewaizd7JnRnZjkeogSyMUQPkrJB9jHWC/uNU4F1BZew/Ji45gfO9qW+xlV?=
 =?us-ascii?Q?aEe+zch+QZWbo0NzWbbHILMV4o9OXKbH1U99XU7DhDcoPPucbwwpfrhNAHB7?=
 =?us-ascii?Q?KQQuBEA/sEtgtpZj5QRseD11/L0w3/MiYuDgdX0XLm+GL/1dyQSB9WIdiRka?=
 =?us-ascii?Q?3UOrVjaKV6QJIPwZIYrk0cYokuiYp1SXoBCJkCNd4MfA6igyas0AYx5kX0sC?=
 =?us-ascii?Q?FHYgRmrZq5eg8O4SFA3MpQ68VL/pnk2/UfmCaFEpP9wEmkF+59Eza28zPE5p?=
 =?us-ascii?Q?agpf4mrRkR4fXTQn7ZcUR6fQKXJTD+vogDb1TiKvyuLYAeELJexHdwTWxz5s?=
 =?us-ascii?Q?WYokn2Lj0/8toE5x3TXEzWGmoZpBk5zUH+1Ep1vDGm6T2sKGL7HW38am/U/f?=
 =?us-ascii?Q?iov660tp3byFEdupTj25CeHSmZ9j+cqVD8utM56/4qvjbej8H9Wmyn/NfyT6?=
 =?us-ascii?Q?mas80hCh8yFImmXNw8odkj1hOVm0Bzn20EoqCjOeRdgQTEnWXdTIikowZa1G?=
 =?us-ascii?Q?h42CAd7Gjy/ydlrLMD2KtZxJQRM2eXM9+9r4BUmIvUK/yOJkHF+3iZiAYLzd?=
 =?us-ascii?Q?6iOE4hIQvT9PUaLcZSoo+x2MDqrASbpANhKuxrJ6dgvjX/9ZKQJ7ISaJ0Uh5?=
 =?us-ascii?Q?xhQGP6mVK7cf79lBibyBwVxC5TmBff1zJ1cbg9+CAgAdtJCEGOn8bqKUw1a6?=
 =?us-ascii?Q?xPFBPnw7/d7roa/PPfNgV7w+z6i9nZtZ2WNt+OHMYeSh+IN0sgbfSEh6WEZC?=
 =?us-ascii?Q?6nfjoWkpr5R/AHg91MwGmaJ2wuLfHozQ3dTJpRqc?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e6b32f-0797-4478-8f74-08dbc3017089
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 04:38:35.2908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F8ML6r6XpjLWketCbIqcgSJjiyIyEioXlAA3a6igVdqCr2H3+i8K2PN55DMqRGxOigW49rE2pkYM0HUnmqvizw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875
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



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, September 26, 2023 10:30 PM

> For example, a transitional device
> must not in theory be safely passed through to guest userspace, because guest
> then might try to use it through the legacy BAR without acknowledging
> ACCESS_PLATFORM.
> Do any guests check this and fail? Hard to say.
>
ACCESS_PLATFORM is not offered on the legacy interface because legacy interface spec 0.9.5 didn't have it.
Whether guest VM maps it to user space and using GIOVA is completely unknown to the device.
And all of this is just fine, because IOMMU through vfio takes care of necessary translation with/without mapping the transitional device to the guest user space.

Hence, it is not a compat problem.
Anyways, only those user will attach a virtio device to vfio-virtio device when user care to expose transitional device in guest.

I can see that in future, when user wants to do this optionally, a devlink/sysfs knob will be added, at that point, one needs to have a disable_transitional flag.
So it may be worth to optionally enable transitional support on user request as Michael suggested.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
