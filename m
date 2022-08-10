Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBA0C00140
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 16:00:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C6E7610AE;
	Wed, 10 Aug 2022 16:00:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C6E7610AE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ElceyZa2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id akidPp0MmmcY; Wed, 10 Aug 2022 16:00:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0F237610AD;
	Wed, 10 Aug 2022 16:00:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F237610AD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6E3EC0033;
	Wed, 10 Aug 2022 16:00:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C5D8C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 16:00:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 336D581B48
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 16:00:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 336D581B48
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=ElceyZa2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qzc3uerChhXA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 16:00:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0550A81A58
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2057.outbound.protection.outlook.com [40.107.96.57])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0550A81A58
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 16:00:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJzhGEZ/JLjfDbdGJy0ejeiBYyK5FrSWFagExzjXnj7n6E+dlLZVPZKLQO/X0wiintKvPwX0i7d/WykDItQA0EiBFAcF5HYkDyyqdlP4D2P4zb7ECiEyG2xOdBxKJkoUnowR9xgpI0BAgVAORvr1XaG9zKhp8sjdQha4peOGL+iWrDrDzHx6kg1NvpN/qH+aEmqkkYPJ1SpQxWtoQ23W0OhKJWgQ6Hhg62rTMFVaAzUFc1eNXXfGdAHh1pBTBjKQcFVtZVG5jPRMXT58CcIzmT/mWI2UWYqex5TezfU45wFHgfwJMClH366A0lcFvdrUSOs3j5yXHXwPLcRoMUNKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/lyRZ4yXrtY8ypXhjeFJ6AhAH1DeGtr8SyU/hAWVKw=;
 b=Rcya2fhg6vbcGNk0IqJv9aCpOsIM0aDkW0sxwU6QaklFihoOU+S45Cgf/W9UYe/ItJP51nbvJZE7PjtK9kyvRwoDze72tfhSIb03e+o+N0Yi+ZrXJEnMzIQBT9XBulTU2oNqAHkKF8VRDaQgxxgxB+VdKMgBIlLeofQ5/JonpV6GqvGg4r7YtyRibs0hP1KlSPiUmWVjWiOpNOO1czyqCaUh6jbOxS6OvpU/aixHh2KtJjTVVuA8oBVk5OVtPJAOOojnF5+1dM9uPPa0riwc5vm/+1BjY4cdLl0ZMZkjs0YLnnYBMn9ML3ChFGJSg+WVimr+Rn4A34b2bE781lm3ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/lyRZ4yXrtY8ypXhjeFJ6AhAH1DeGtr8SyU/hAWVKw=;
 b=ElceyZa2TXJzG/AHRy+sqzixHMemQEQxtTVD8Bp+0gp02vmK31WBQWddh9DLQEApOKtf8AU2gL+SsVw5FDqGnND2X0M4yuvM7Ub+viDOBqWrKj534oCqCCqQUFkSyJ7HbYytrYZ2DuvS4dBwCfUpYg+zy08BDVWBDJgVCmOTnlNa7T47JUplxNZZVBvYJPBuK5GTc7GBRcjQR2K1QvTNRrCX2ZHelA6zCLKSxMqU+fGRiGUjlyv9XiwSTNyBXEfOkEBt7HwsSYdfpjgGSO0K7mjOeTIs0gcmGBCpN3OTzXmsf0DSyN7ne2dsB3wBCLrh6PxtoX4WKW8y4umQp58l+g==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SN1PR12MB2510.namprd12.prod.outlook.com (2603:10b6:802:28::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 10 Aug
 2022 16:00:08 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::957c:a0c7:9353:411e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::957c:a0c7:9353:411e%5]) with mapi id 15.20.5504.020; Wed, 10 Aug 2022
 16:00:08 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: RE: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Thread-Topic: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Thread-Index: AQHYpirEKDhT8iEHv0Wl5fiZieJEBK2g5FqAgAPA+oCAARNOAIAAeEKAgAAKdACAALbdAIAAAJwQgAAHyoCAAACEUIAAKRiAgAAAt5CAAAyxAIAAA53wgAAMv4CAAHJzgIAAAIGAgAAMUoCAACJqgIAAc24w
Date: Wed, 10 Aug 2022 16:00:08 +0000
Message-ID: <PH0PR12MB54819E083F0DEBF30403C380DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809173542-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481101A8414FAAB5FCAC537DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809182306-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816FFF167D3EA3EF5F075FDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <62920bd4-1070-a91a-baf8-659009e9f590@oracle.com>
 <20220810021320-mutt-send-email-mst@kernel.org>
 <20220810021427-mutt-send-email-mst@kernel.org>
 <CACGkMEs3HKU0sPMO=38c471hCNu6a_1TwiYbwg0ZtBiENUBwcA@mail.gmail.com>
 <20220810050219-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220810050219-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29dbb02b-8d4a-4029-0a2b-08da7ae965de
x-ms-traffictypediagnostic: SN1PR12MB2510:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WTh3AZXv29wxxEZF7pkgrNDkqZiyWAzKNzbY2wmYrqfUOzI08Kyi+0IKQqr7YWx6YfmVMRdrbidhFeP1XohJj1U2tnoPn0J1c4Z2CzqEeTJ2yAL928Vxn4l0UY0oQmr5W3bz+SwnmEobSIfsUt+9Qz4Ej62WPtUEpvQZyrMNdtJVDsKbxZBZcOiYuXEWivOi3nAkrpkvq6gEMm3UNUuAG7Z37QaOYOa0PQsF3943N/4YoMziaJ6oTop0YYq3wmcOFM5blNGJQKTIL1k74b6f/4SyY3jcAnLjmEMK7TckNG8Z9hc/feRkdaFP/KlgGaAwhy3rOyF8rlOIB4Cf0DYIci1TFV8m0AQrO/CEeZYIjMfoemuFU2NJA74etxje3uJ91/Mar5igMPApOSDNnX5w+SD4SSR4RtQQu0NqVTZlxv0vM+QbPz4GxHD2dk3R9RMP0Mf9p1M47MgqHI97FesHyYze9FndQaqD3fP7oiC6qb9GbDofwOLVnAL777h2l3vqmtSHkTKgChz7CpGjR1u7nOUbAVtFtqE+1EJb2UTeUHH1Gkkv/rq9nRmcf8G3sZyD7xiUEEDSeXinzQUfSAKlyj407LBnvO4eT7QcieNtinjkS2QCSS+DlU0D7zAIHojfV0FfctzxeCiaXyB4ddRwfYEIMsRuQKtMXDP7OkL9cu8rXIGqCr0RId70JllCGxpM4+GD4OOY/PCXigy5dY+AzL4eSGGi0RqdGNS4ZI25Qwq2kSwdks6hgdALmJsbV3HNsSJJQSH5/AG1J8tOaLFB9dQw4J5RnsrQMiju4eGqvou7VrH5d+iheGHuL9hk8CSK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(110136005)(54906003)(316002)(478600001)(71200400001)(41300700001)(55016003)(5660300002)(66946007)(2906002)(4326008)(8676002)(64756008)(7416002)(8936002)(66446008)(186003)(76116006)(4744005)(38100700002)(66476007)(66556008)(52536014)(122000001)(38070700005)(33656002)(107886003)(9686003)(6506007)(86362001)(7696005)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qb+4/7KNZdHf7Nuc4ZqUDGgXd5HXWgO8F6415OAGHuWgt2hZsDRH0/drOknc?=
 =?us-ascii?Q?A+83nC+py+CFHoUO1Frr1AJr5tGGGyZjexAzkYYjsEr0CJ3HSqM1Onta9CiY?=
 =?us-ascii?Q?iY+qQ7XZ9PdLlzNWSvFfogFKhGlsgUp9cPGjVg/Xxnqqf0SrwxfRtdJRnYU6?=
 =?us-ascii?Q?Mp+FOg2Jt/VRbPWudV/Aoj8S3Kh0XWgfx//E+ZoUxu3YBnxmTJfiDXwGsLgD?=
 =?us-ascii?Q?79/UBWvW8FymM2jKqw1EukyonAc8/yvvyw9Ww1J9YNEsjzVm2xMXaj58Y3cC?=
 =?us-ascii?Q?2I6v4p/RuU77OlpQLwNUaPP/63hoDVM6RIygGQAbM5gy24vPA84790wWMdLL?=
 =?us-ascii?Q?HB91FMxFF5nC4bt3E5Em3t+rY6csa713CF942HCB4nCNBKPVEx0c3CIVG5Wf?=
 =?us-ascii?Q?CVyEO0o5+cupptmoSKxp9mI55gSWNNW1wahmzw3iW4F66i4xwNUp9J4G/gaf?=
 =?us-ascii?Q?NVTtPv5Evl41jlCIQYPGBjfxXTyO3JW5e/3xTc7SSlmR3tqsVEw0Fpi5kldG?=
 =?us-ascii?Q?sez082yRxH8RrFQLfVks6QPZFuXqiL737QYfr6lV5G8djegewDy1xJeVo0ir?=
 =?us-ascii?Q?jX4KTl+A8lJ/J8uTGFnQHpuBZDmXEYJ5itRq2tJvQi1LydA4L8es5sEa+bFm?=
 =?us-ascii?Q?8xLD31T919o+roC9nlZXh04MfJnjp6CvvJbspDC8RLeaA3upND9pE0c1VxMT?=
 =?us-ascii?Q?OYsQqV47OJoQqiPPk4IOwz4r42x2rEL00bFaDuFpdbr4n7PktIC5fH4jAvoY?=
 =?us-ascii?Q?5V+stzMzTSzkitXi6yjw2VU+nKv0TPrq4liBytk75lf5JnzAbhm0OxI+jIUK?=
 =?us-ascii?Q?2iBeWcHaf9BV9jdXlR01AQPrUez7RpmVskD6P7f07f0epaMZxe0VqQlFSLuL?=
 =?us-ascii?Q?T0XV76KYJUsPyMDZ/eXJR8nfKLGRxebojGxbZnP3+HLRJjFlQRdsQ633QENL?=
 =?us-ascii?Q?qymf4h6LkbaVTqxKtkStai9nrhklN/t2M+7ipXIgzr63qT5hYK5uSNz5X6zw?=
 =?us-ascii?Q?0ZHMxzYew8YzQXOp6Q1OqohAGw/0qgk88n9JbR7O1vYYFs63CT4oZqJgPM7C?=
 =?us-ascii?Q?2N5Ii9ecvVEviziPQQpOU5CDHeX62qiyxcxKy0hynZektRGbt2tPI0KaaK2h?=
 =?us-ascii?Q?FzyHW6ERNdHMQgXWMQtLRaS+xWxw3dIzFzgzp7xxfDam8yWMIKqAtaFrafq2?=
 =?us-ascii?Q?A49Jwku3cgRUid43bQZMcrGdshrofRJEA6Yk36UWKmwzJRs4CObI2ngz6bzb?=
 =?us-ascii?Q?RsZwxzZXj859G0RatFpNvKXmtoD1YkzShIACXiwZH8g8gwc3PS+EhLiNhNpl?=
 =?us-ascii?Q?PijY5EEXcBaXXAapVoQvcf3xdgj3hCz3XFuFL0Tcaag7Ux4ybTS06giGGNgg?=
 =?us-ascii?Q?BqFseRG1T/rux9HbMc3md1VVHC+BbTF9bMMsWcsp9ykOQtj2/FADuEUX9ESc?=
 =?us-ascii?Q?fbO4nQQQY6JEayyHK2WbCb0xd66aaL1IZKFbClptFwwJwvuuek3YG85zwtdn?=
 =?us-ascii?Q?H2cjGOHhH+N8y0Ww1P+RyZAFlTpTmO5RIXrLq9KYU2IlL3a6K7pv0BmLmBHI?=
 =?us-ascii?Q?eMtczQb7orOjP/jVEG4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29dbb02b-8d4a-4029-0a2b-08da7ae965de
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 16:00:08.1053 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wQM4BmhIKhMtXRqQfU7Ng8zgJczRGYUJBbAF7b64SgnbX+PU/5UNCzXbkOIsQKioCiSwvp+8u/RzIREp+awzQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2510
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
> Sent: Wednesday, August 10, 2022 5:03 AM
> > >
> > > Should we make this depend on the vq reset ability maybe?
> >
> > The advantage of this is to keep TX working. Or we can use device
> > reset as a fallback if there's no vq reset.
> >
> > Thanks
> 
> Device reset is really annoying in that it loses all the state:
> rx filters etc etc.

The elegant solution is let driver tell the new mtu to the device.
One way to do so is by using existing ctrl vq.
If merged buffer is done, and new mtu is > minimum posting size, no need to undergo vq reset.
If merged buffer is not done, and buffer posted are smaller than new mtu, undergo vq reset optionally.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
