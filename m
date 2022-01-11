Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8939FC433F5
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 06:26:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 141EB40647;
	Tue, 11 Jan 2022 06:26:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7aTiXz-5tQgG; Tue, 11 Jan 2022 06:26:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 525E140374;
	Tue, 11 Jan 2022 06:26:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2ED56C0030;
	Tue, 11 Jan 2022 06:26:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 108F7C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 06:26:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E347F60AB1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 06:26:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5znBrDy52Li2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 06:26:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2074.outbound.protection.outlook.com [40.107.212.74])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6B65260783
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 06:26:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8LbLyUo7Ez30W+01Sj5Ex1Hpy2ADqBDFdb3vuMLWrsmwLjbAuLz+cXodT7Zo7J5EMmYb/IEmJYyzOx0NROIs2KQWfZs6Tq6YYHWa/70VAz/si25SSFJWJPgCPAXWZPYnGNbJysutvGqW2ljkQE/wpssl6xXPL5gkL/GR1yYT2IREW+UjO2ucQFaJP0iZTOFVNo7tmfkS48hMeqFOzazkoT8bfeJM87u7OTubGv+P6hdtqXV3/IpK+UIXXyBm2dG5NjFBrtC2IPqM83Hs2WsrSCe8DmvBJznD6WqngPSjkwNJ/ZDMl8a5U0pLI/SeGPVoIAdzSlLylK0BZWKe3RcMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbFaWGqXpOlJC6XKf0GIzRYNkKPxryFd8Vcec6mdrtQ=;
 b=lzT/s6vsViNsmuUyClqxapqWrYNpJ0SIGNCUb8Y8lngIAxPsSt0KVeSMGi/plJqjFPc4H0kXTvUZtZRcmCucy/ahktv/BYY90xKKGi6aCWgLXkEHjp6G113uSQjmmTqCcA34nEC6oESutSQZqLw3hMpjChKtQUh4UodhOfebNa5wW0TOt1sZWF/NWMpxC1CCQiEXO5II8BBwioXArdcsxifU2HfPGeKtkhCT6P1ieCtH8oVnYaUZdjVqwEO+pdtzvkQfWidsTaFgxUXsMByxMLAjWKlyfSVER8DemErnlaVCGM32BixwxzlG0PlOplidDCRAvQNlsyYqs8Oi/Zhnkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbFaWGqXpOlJC6XKf0GIzRYNkKPxryFd8Vcec6mdrtQ=;
 b=jZjJUVjeMFGIjANbUKuXbipZfGTVa1PuO8GnArNFoOVYbn3brdGbi7FhAcW4nibHEXSSSmMsEyJfTqILFFpXqRtrCvXxXb8TZ4kCf7DfIOiCjYSauV+cz93pbVPbFdh7pmt6gOJOZoCcNyP0psVWuVQFHJJHGpA3JWj1kR//GxF6mdPg6GUEtKUXbzAuBnXOkizoeS5KGnqoygDzCbH2N+MSDBOdg4QFF6xC2yi1HXBE/ej1YklsQzFuaws8rcG4bDpTwDBW8Vk1zBcKVEPHWMv3tJaxemC9k/nAYJDM5iBajjg+d/CRycb/UG/way3bKpsFs4EjjPLrbo6I6Zg5jQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5497.namprd12.prod.outlook.com (2603:10b6:510:eb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 06:26:31 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1112:648e:f77b:9bd5]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1112:648e:f77b:9bd5%3]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 06:26:31 +0000
To: Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
Subject: RE: [PATCH v7 03/14] vdpa: Sync calls set/get config/status with
 cf_mutex
Thread-Topic: [PATCH v7 03/14] vdpa: Sync calls set/get config/status with
 cf_mutex
Thread-Index: AQHYAin4OoTmGuxBpEC985y9kY+MEaxWuCWAgABM34CAAVM5AIADc3QAgAFFlwCAADbVgIAAGi0A
Date: Tue, 11 Jan 2022 06:26:30 +0000
Message-ID: <PH0PR12MB5481784AE87D6D563656A0CFDC519@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-4-elic@nvidia.com>
 <e6218f34-a7e6-9bc5-8de7-7690dec9aa01@oracle.com>
 <586d5d2a-e57c-117e-81d9-8b1366236002@redhat.com>
 <cca0ff36-63ca-701c-30ed-f368cb80a813@oracle.com>
 <3af55c17-49ad-bc9f-1b96-0a59b2ba1856@redhat.com>
 <a4fefb05-958b-743c-87da-652420b98e70@oracle.com>
 <CACGkMEvgQ-Qq36Ldgu7aNBaZ85ERQbaFfW4CY0i3so8NzpcAGA@mail.gmail.com>
In-Reply-To: <CACGkMEvgQ-Qq36Ldgu7aNBaZ85ERQbaFfW4CY0i3so8NzpcAGA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfed1559-217c-4d5f-c317-08d9d4cb4e82
x-ms-traffictypediagnostic: PH0PR12MB5497:EE_
x-microsoft-antispam-prvs: <PH0PR12MB5497538268054FE74284B21CDC519@PH0PR12MB5497.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JoXXo78to83qmG7kp72xfQ3STHPqT35aELhDdGpno2qYFxffNlVcJHCdNXW345gY5AoO4/POwnJs+LVTaurZYeKLjOwNGLLxtlrTsVnnj65Qk262xJr86y3thtVuj61Li01CV1EkIxsAfova3anpXlvTUYwsMcTwWd4M1dg1HlpzINzJuYEkapPzTMZA9t48oCkW8XufnBP7sUFT2eW6r7Gv6C+OpwDiH+2U22VtHBagYchwenXsgirxVg2WYcD9qoma0h0s+1UnHX5POwrzMa+rSOa8kr/vuxlMQ+qltE8sY62KI/dv+sDjxYLWoXhlBrHyLzOcK8Ci+ER5fkOV7NW+eyAchhA6M1JrYquhJb0qD1BHg3m49bV0QEQGtvvdyTs60rJ/5ODdM0tAFt9UtWIr4t5Y35e3+W2D1Bb621Yvd90IauiAuJPWM0qgv7YVFz9B88X50Ynp1cDhOC4u9XvLWfbY5h2A1p0x5rCD/auZVLn3YyM1y02bSOqYARUvuOLHOv+a4+KyuzdDylavzG6OAn5IXL56ouk+5Sl0d7B6jtiOEQzfQamodvCX7/wDJjBPbn3ZzSNhX59ql6P0rO3tqWyc1ny2XrKPf6U/trdZwR7adbAtDrvil533BNM6SnLK6bBIqkxc+bFWVIAdG3QtPJEgd9jRBbdnnBRLPSsixdrzMGk9TUXJYxjHZU5/rVO1FmyiYLC8GTbOKr+kjQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(5660300002)(110136005)(86362001)(71200400001)(4326008)(508600001)(64756008)(76116006)(122000001)(38100700002)(66476007)(66556008)(54906003)(9686003)(83380400001)(66946007)(66446008)(8936002)(7696005)(55016003)(6506007)(8676002)(26005)(52536014)(316002)(38070700005)(186003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjVRNmFyY3c5M3RLRExJT2E2NGhCYnBGSW8xSlNxczM5VnZ5c2NVOGFRMXl0?=
 =?utf-8?B?RFZTanNvZlVHMWlldW44K3FOcGpCb3BKWVNYR0h1cEw0TW1WM0hEcE5NZmwv?=
 =?utf-8?B?dytwZjdUQmxRMVhyZlk4VC93dVN0Q3FKZWRRQXlmWXMxZHh6Y0pzWjJ1bFo4?=
 =?utf-8?B?Z1FmdmhORXFzTFZhUHFMbjk2eFI0MTNIZ0FXQnJUdEZpRStPTE8rb295amJp?=
 =?utf-8?B?ZFZ2TVVrZCs0NmR2eTdDZDQ0Q0ZGS2ZreEtpVXJRanBvNWEyVXc5WlRlT2tz?=
 =?utf-8?B?b2I2Z2w1NE1wdjE2eGxYam1UdGdMRVFkU2IxN2ZseU1TQmRiZHhGanBaMU5L?=
 =?utf-8?B?YVVORnBKWU9jMk4ya2ttWkdsb0hPYTg4Wm9lWm4wdS8yZzQvRjZLVE0yd3Jl?=
 =?utf-8?B?K2doU0FTM3pBWkVneHVrNUttYWgyWUlFZ0EzbU8zWEpSSXFvREVrNEo4UCsx?=
 =?utf-8?B?YzYyZVlsZmJYU1NhMWgxcUhrbGdlYWpnRXVzN0xqWFQxRkt3bm9EbVAxZjVq?=
 =?utf-8?B?bVNyblB2eHZUaDJEWi91MzkwTm1KSXY4UndRS29IVTAyRG5Rclh1TVZ5Yy9n?=
 =?utf-8?B?Q1FJQWpqVFduUThqNkF5TUM0Z1dCRmVPQXFLRGdhb2hXRkpEa0dPSnBPaUZI?=
 =?utf-8?B?cEx6bUFkVkdqU1VCN25tSUhxTmVtVlYrQlRIbEZ6Z2ZJOWpJZWVQb0dZbWhD?=
 =?utf-8?B?NUQ4enVJbDUvemxFMmFDdU9Da1kxaFVWR1JPV1AxWmt4ajVKKzhmODE4dzV6?=
 =?utf-8?B?MnNPaE8rQnovZjRzVS9vdEYrMnM5NkY5VDNaL3FLdGdNMVI5UFFlbHU1K1dy?=
 =?utf-8?B?cU1CZGxvZkpLTEdEMWJDR1loUi9SSEpvYmF1LzJJeW43K3hMb25GRFpnSUZB?=
 =?utf-8?B?aTRqMlFKUnVpQVM4Ylowc01hMFRiYm1ZcTRqdW1wQVRGeWRKaUp0ZEFxYzgw?=
 =?utf-8?B?N09QekxDY0Z5S2xHUmxrNlRJSTVJaWxwczFvMmpGYTltQWlwRkYycDZLM2NH?=
 =?utf-8?B?K1pRSUZ5dWhTRG8wdy9hT3UrL1pWb1FNckRFTDBwbjBYZkpqT3ZieldWUDN5?=
 =?utf-8?B?UXBET2JjRXIrempEMDFEVVRYcGlhemVIVmV5alVFR0Z3YXdHS0RoOVdsV1ZG?=
 =?utf-8?B?M0pPU3NDakRaNW5kMHJlbHkrS2dJRk9kRTdoWHlmdVJyVEl4QndId1VFSjl2?=
 =?utf-8?B?R0N0a1RtbDZzQ3FhODhkNEVhK2FJT2F5S1Rvc2ZVYm1WU2d3b016YzNiaGNG?=
 =?utf-8?B?d3VQTzVlU3FoSHNzV1BxTXMwMkxtUWdydUlOM1BsUHhETzZMUkZOZ3V6YjY1?=
 =?utf-8?B?WXplU3M0UDBvTEM2RlZFSGlrZWkyUnJlanJtbTJBSG5nSHVqSVFPTHVMalA4?=
 =?utf-8?B?MVhmMWVFRTJLNnN3cmQ4K1JiQ2cvclMvUlhHYnVIbGFMbFdJVFRVZExTUTBD?=
 =?utf-8?B?UlVPRk10MFREUi9nSFdCRkZLR0ZmcFhjdDNkcFczbG5GZ0tTd1VvcXNwZ2Rs?=
 =?utf-8?B?SHExTkZ4dkxjbTlxZnA3REZsNTVNRk0zMnNEY2podnlCalJ0VWxYNW5kQUNa?=
 =?utf-8?B?ejQ4bGtyOFNIc0crWXIvZDhkZEdGejM2eHBlOElnSG4vNmdraGxqWTdhT2U3?=
 =?utf-8?B?djNRaFNSZWpNOUloQTJkTmZxMHpjdm54VVFUbWlWS1N6UDhpd1VURWNNdEFQ?=
 =?utf-8?B?YVNCTWVneERYS3dYTmwwWmg4U1VCN2s3TmRodERtV0hiQUlnemFBdzB0enJC?=
 =?utf-8?B?TUdXN29ORWdIU0hONFVSNllxTHBQeDNJNk5aYzA5KzBlRGd1aWpkb3g4T0pw?=
 =?utf-8?B?ZVZVMElGOVM5aVVEUktnd0gwNnFNM0czSzFjZW9jakkzTXQ1cEc3MDFJN1Vn?=
 =?utf-8?B?Mk5CV0Z1aDdhbmZPK1htR1FuQURHOC9CUS9ieWhmMFdpSHc4bUhkQ2lEREh1?=
 =?utf-8?B?eHQ0V1dsdWxmNzUwVG9NNnc2bkJ5NGtoL0F5QWlMeFc4RVpvVzlTWUF5Smxv?=
 =?utf-8?B?UlNrT0FNVW1FWWNsTGRCSUVQaU5CTXJHYVpjVG5oK0RVMG80bFBhVGNvTktZ?=
 =?utf-8?B?cWxmbUlXZ2U0T2pGdFR3N0VabUVxVEwwS2dxb2pvUncvR2pxMVV5SUFkVVh6?=
 =?utf-8?B?bjRLRVQrTGxQNGlwTTRJVUVLdW1iQVFsQ0NUR2Y2VGJCVGMxMEsxWXJDM3k2?=
 =?utf-8?Q?fa88kw5d5xrO0skcdIWVAbw=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfed1559-217c-4d5f-c317-08d9d4cb4e82
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 06:26:30.9028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yZS+QDESAFtknq0q2VkJpZJroPjGo5Km0SnkCoTS0v2rREXG+d7eUwfi/FQjtW+ligxYxu0sqXT5r9YDFBq3XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5497
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>
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



> From: Jason Wang <jasowang@redhat.com>
> Sent: Tuesday, January 11, 2022 10:17 AM
> >
> > I guess in this situation it would be better defer to the future patch
> > to add such locking or wrapper, although right now there are just two
> > additional calls taking the lock needlessly when vhost_vdpa_get_status
> > is called. Maybe it's just me but I'm worried some future patch may
> > calls the locked API wrapper thousands of times unintendedly, then the
> > overhead becomes quite obvious.
> 
> I'm fine to remove this if others agree on this.
> 
> >
> > >
> > >
> > >> Ok, but IMHO it might be better to get some comment here, otherwise
> > >> it's quite confusing why the lock needs to be held. vhost_vdpa had
> > >> done its own serialization in vhost_vdpa_unlocked_ioctl() through
> > >> vhost_dev`mutex.
> > >
> > >
> > > Right, but they are done for different levels, one is for vhost_dev
> > > antoher is for vdpa_dev.
> > The cf_mutex is introduced to serialize the command line configure
> > thread (via netlink) and the upstream driver calls from either the
> > vhost_dev or virtio_dev. I don't see a case, even in future, where the
> > netlink thread needs to update the virtio status on the fly. Can you
> > enlighten me why that is at all possible?
> 
Sorry for my late response.

Netlink reads the whole space while it is not getting modified by vhost/virtio driver side.
A better to convert cf_mutex to rw_sem that clarifies the code more and still ensure that netlink doesn't read bytes while it is getting modified.
Given that config bytes can be updated anytime and not on each field boundary, it is anyway not atomic.
It was added where we wanted to modify the fields post creation, but eventually drop that idea.

So yes, cf_mutex removal is fine too.

> After some thought I don't see a case. I can think of NEEDS_RESET but it should
> come with a config interrupt so we're probably fine without the mutex here.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
