Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361ABC54EE9
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 19:55:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C2D082B08;
	Wed,  7 Sep 2022 19:55:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C2D082B08
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=C6aBrfDm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t2XibM6L_UBk; Wed,  7 Sep 2022 19:55:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 55C5382690;
	Wed,  7 Sep 2022 19:55:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 55C5382690
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18771C0032;
	Wed,  7 Sep 2022 19:55:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F04BC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 19:54:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB5E3828F2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 19:54:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CB5E3828F2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 130msuwV7NJn
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 19:54:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0CB9682690
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0CB9682690
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 19:54:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFCJLbhU9/XId8koS7B/z3f4exs1vAGzyUQhpv4TCq+X0L0hkL32gCt8k899s9E9PLxUlOEqm+R0B7S1uaJ8REwKvu50F4ppqDLQA7Jy37cCCTZvcvwZgAqksb8wEbTcveS5YqN41RNZuPFnO1w6aNLZke6EfaewytwF/t/K3yWIiL/gu64kpxP00eTOvW8PpYsDYSeBmm9QsW8J04HK3Zx0Id+EF/MTIzorkphBZ5ug6PReU+EL6JYUn/imfpRdMzB5UipHWNkGgLBz5e8I7h5kGPL5W07drqRrHiq3MTb4KUUxeZRXsJKdX7tlDDk3Q1rgaekgsAKcCrESndoakw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sg7ooydtuuwmh9Z1DvxX4xivEXkREppQgv1tlvXJSKk=;
 b=kjKOj7QQfIKjwLXzBi/8uA/vZMmds0Pe9teoPlw0GdL/EVTUFl19Ovnn+WHx2ay49Wl97qTcvA4E+uyh2IOf2tAtohHGBS5zsypocgZosVVkEsVi38PMZFCrS38Glb6F9rXXB1IuOq4PlVUBznG0iVRrlvnQnMrqeuSCEW3SKuH2Qa2PGlddkuDFGHuPOWnJfvWYVylkQin+eBWVu9WvpSHBP4Lx99KKg29LDdLQXXm9sL3KkDfZJ42+3Nv+Rqij/aDRjyAUEMElJNENhLqcneSFJcqMi32RquzFoBY8I14+T1kxunWB1j7GIuGYF9bit3tVt3F33uzMtAaiBi8Zsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sg7ooydtuuwmh9Z1DvxX4xivEXkREppQgv1tlvXJSKk=;
 b=C6aBrfDmN+9lZQ+iIwljM4jhdvRDVZuGoP6nN0bhT5o4fWsZQG23N6O0E0lrWTpJ4deue9bltaM2RE28KBzVxdxlyDwn1D+yqaciPOzHnEECpb5BjpCtehwdy4sNEDiwyjrH3Vs3WgJSfkP4yU3zrCnry361GYEB6Wu7rvWKeHy3uETc2+Jeq28SXd/FKP5zomhszWfYhqPe+D3kcar1q0YZxef74vxQuxTjyXE7FjdGlWdurxLmVIGNAQLsBWu+R1CYy0gX8lC8AYP1bB/kPTKXXDV/vbohvOoGwApHJ38k1OiZR20mRqQj0+jS0OIcL3gTm9C0FpnNarH63/zoBQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Wed, 7 Sep
 2022 19:54:55 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1429:e3e9:dc54:ba98]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1429:e3e9:dc54:ba98%9]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 19:54:55 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH v5 2/2] virtio-net: use mtu size as buffer length for big
 packets
Thread-Topic: [PATCH v5 2/2] virtio-net: use mtu size as buffer length for big
 packets
Thread-Index: AQHYwpEbqLdY6RByfkyoSMo8wpA6EK3TsrMAgABG8oCAAA3LAIAAADnAgAACroCAABYGQIAAJjCAgAALaACAAAQwAIAAAFDQgAADKICAAACIkIAAAuAAgAAAdACAAAPoMA==
Date: Wed, 7 Sep 2022 19:54:55 +0000
Message-ID: <PH0PR12MB5481E1300D107A08A6493B1ADC419@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <PH0PR12MB5481D19E1E5DA11B2BD067CFDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907103420-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481066A18907753997A6F0CDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907141447-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C6E39AB31AB445C714A1DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907151026-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811F1234CB7822F47DD1B9DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907152156-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481291080EBEC54C82A5641DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907153425-mutt-send-email-mst@kernel.org>
 <20220907153727-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220907153727-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BN9PR12MB5305:EE_
x-ms-office365-filtering-correlation-id: a3e9ef7c-57f3-4ebe-a786-08da910ad5fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5GuhxJRz0x8WYKfB4i4LSlwbgTArccy9ZHTixxDt+TddSdIuvTWsuAVLTZQdqVwKkB9mY+n3GUlIiprqZ+D+tvIJ29gxZXFq6GcQSt5fH883+Vc2YZIZeiodEvb4dUanvE2pe9B/ZaHPbudNXXtjBhMxrnVaJrg9cIhEKTMl6m2J+98LVD2q0eMfYj1oPhdZSzIQbf+r4h2Bc9rfYLuNSztwbvjGXRchudsrG6BN4cjALaVfMYbT92+B9DyhqvqdH0nfn8BBUuRP5I1s2NysoGA1tPPUxDMS/73RkNGnrK2oCvJy3tYr00Q1W1SM6PQlUrx5/PuXI6iKZ9j8urBuEcJoh2tKbHtuAOzO6nDkNjFqvNoJTLXVYwCDhYaH3/EEciAdjihqfp8iSXpuzwsE72FRZXaAc3XJfRTi/+zSkNyYq99+6hrKue10Hh3Ahn+qfzmptAOTfNyipCHuEMH6bH5i0WEp26dju+19PbW25PnT7fKUH9MsKD1ROh2ULYhkL7gK3S9/eytLIYwb9q1sRU7gwRgNwgkezExTP1zWaEbNF+NhQajNpFn4i06QxB2a7jgzw3///mh11mZsJ7SwSmL23pM9Fpt4/F/oE5wg948gVfbBM2fwpzata3rS0TJ6AY7hfaJjEJ8rvtQCeBqOeHoQpjhH0AerO6jTBVEEGU13LvC98fIb3qI873+gC86TJhyiG1T3E/po7u8x7MqaI+dXgz52sHfd79vwA1Y2j1twUIrVSYjbaCDLzugAjbwyFe9VfoFhUifgm3P1tff0dQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(6506007)(186003)(41300700001)(55016003)(558084003)(71200400001)(478600001)(9686003)(26005)(38070700005)(38100700002)(7696005)(122000001)(86362001)(5660300002)(54906003)(316002)(33656002)(4326008)(8676002)(2906002)(8936002)(52536014)(66946007)(66476007)(66446008)(64756008)(66556008)(76116006)(6916009)(7416002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UFVc6v1LW6sGW8b4cEgK2Ruf0UJ17A/w3Ua+acW079NWxUOzEjPhZgMk5hYV?=
 =?us-ascii?Q?WUYICDS8LsFX5NB7ovSl0Uj1mYzOrY6IQv5TlLJORr5mKTRazzekVE5boVpa?=
 =?us-ascii?Q?QpbiU9zt6DQJSRMC6HbVQOR/9z3ysxQZXNfcJhPQEjNJbF22w45AFFTrww8/?=
 =?us-ascii?Q?8efObc0BRbL3CmEXTjZYDUMnVnJcXQW23kXBjmFX/rar6NRSO8Cr5bpvFf4c?=
 =?us-ascii?Q?+aOjGKviqQO+JW2Nt0FZ14pYzY4EvQY/5jxGXcnfU1PqsUO5QTEniTTdQT4H?=
 =?us-ascii?Q?5Vxffj3IyDNAAEOkTLRGIWcmAwYUATeMXtd6Yl12q+jGc/bdfp67C3laEcEW?=
 =?us-ascii?Q?fQVs9cQFav5CrMmg+H6OX7rTT2GPNPHVpnessNTpRQZ0xyuOXGjKuaxHAL0i?=
 =?us-ascii?Q?AOENCfnV9iHMsKG3sqW4X+CTaP1I+E5LF5ziUhmelKZ8mmjTQn9mXp3XVm9c?=
 =?us-ascii?Q?4JgplMshWyYzaTU/SIIzB5t4N1GzgCC4U80CTt2lrzxfY9cLN3c96sXmprv6?=
 =?us-ascii?Q?UEc3RdbDerk8lRXjd6LdHznqoDcOZyuMV4OnLKf3tEvuNHPEM9MBhD5R70Sw?=
 =?us-ascii?Q?GPd33rwcdhr2GaUtzgVZNc35MColoT5nLF5Nje/xu4WuaR0XAlSfXbHOTIax?=
 =?us-ascii?Q?kEAED3nJ7kdkSsbMG5cYqanumD970KNnnivRYsuOxUoPEy86TcPKhwXikR6J?=
 =?us-ascii?Q?Jaa4/TRwkEmf87SWl9kkCS0g04MWpP/2eJFrzCWmDCe/j0O5by7pCgB/Rsw8?=
 =?us-ascii?Q?Q9jK67/WNLHYkNh8N8+BNQmqFwDJe/GKRj9+hpJ6mq2pIJq0i/i3IxXqWHN2?=
 =?us-ascii?Q?6wFFFgVSdksNI++SGq7JKqgGQM9yQ1zyMXcMx8oFAUzmLlyuOtpd6urdFOQ4?=
 =?us-ascii?Q?WSIQj0vjyZQHNtzLQvpQ1wqZCFFn1EOnBmgm69YFAerU9lqBmdM6Lxh2/UFq?=
 =?us-ascii?Q?sd+E0Jw63PeUDPE0wtrR0MOUAUBkMeArUrs6XXMHpC6DrmuUlV0Li+QlCuvb?=
 =?us-ascii?Q?ZK4iDKWhwZLOYV0qqHYG+nDvsE6JIMpb1SEfvNegBjU4QEVohrAsJBTvhElk?=
 =?us-ascii?Q?SooEXUCXxYf3hzMenRdDgXmdOg+WB82+za++XS6irUxqBeY9K1KhL2FJnu7W?=
 =?us-ascii?Q?HBssq2zsN3xntK1Xkvcv/tMYx2659t1RJk3s5fhFyHcC+eqTVQCplcv8wL6W?=
 =?us-ascii?Q?SZAm7oC7kttJuVdum9HOpnMM6kSsPh+I5BRb3OiOjaHkEis/tLREeK6/S3d0?=
 =?us-ascii?Q?+MrHa7vv0BcYyKCo/aquUIVTc7iIzV0Uh3a4iYcdxve/2akV46S5iv1QfQFM?=
 =?us-ascii?Q?l1YHQnoL8OSm1LLQmPc1WcVzaFe6FvWCnOFCT2BtmOxVM9kUB4foAUVVP1Au?=
 =?us-ascii?Q?P5y0r+9xvS0NPhyoX+CYJtrEFjPFAP5imTXUKfgwGKDx6FrYCOqPsn5nucIM?=
 =?us-ascii?Q?Y5gDfbWpEFv9ZT26sGift5b0ecnT7Auvha4hGQYm4laUlPhX514/S0yJPcXa?=
 =?us-ascii?Q?gYvIDLMS9gRZNPf/CY/pCgcop3Fw7EMqHhujlunCFeazBtl1Td7/Nh+1C5AN?=
 =?us-ascii?Q?a0OcoaAYmrisP8HLazs=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e9ef7c-57f3-4ebe-a786-08da910ad5fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 19:54:55.1683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lrWrkL7I8dh+PaVOHO8KYUuIrsvzroewQ6zcO68F8JTQcYRqk3tTKEaUhXXsQuhMY3M6EIht7oGC/bD0bkmHow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5305
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, Gavin Li <gavinl@nvidia.com>
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
> Sent: Wednesday, September 7, 2022 3:38 PM
> 
> and if possible a larger ring. 1k?

What do you expect to see here for which test report should be added to commit log?
What is special about 1k vs 512, 128 and 2k? is 1K default for some configuration?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
