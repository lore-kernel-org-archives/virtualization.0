Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9127EC433E0
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 18:28:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3238664E02
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 18:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3238664E02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E9E0887352;
	Wed, 10 Feb 2021 18:28:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DMao6LicKrU4; Wed, 10 Feb 2021 18:28:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C9F8187310;
	Wed, 10 Feb 2021 18:28:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B66F2C0174;
	Wed, 10 Feb 2021 18:28:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EE00C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 18:28:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8A267860D2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 18:28:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WBCtSX+P5aR1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 18:28:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D88938609C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 18:28:44 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B602425dc0000>; Wed, 10 Feb 2021 10:28:44 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 18:28:43 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server
 (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 10 Feb 2021 18:28:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sf7gvENRr3xbIUhB0IrEtY/bPQGgU9Maevjq2xYIWfp9iD48NAByq2DTedspVawUoH2A9WVTS2VLeDUlYKtDtY4ukps5Sb/QkdbYzq0ef8yxZ0sjbjv8wNgXb83A4/HETgg3KEWsJy+TYiSZ6iFU4sQ42jj/Q/0ofbUPsgSQTLZIIxeP10NL7a18+M3qcxv7wPCRKl3MrH60esgwwb6rUd7tmOUnq77VsdXrbrZMSyA7kVYcNKXGnkbQJuuKp5exnpa4pyskF+pK/fSVWa65WmNFp90X1LUQH8exkZ7zS8Wu3wUFe+lb98vg7fz3a5OVApcxrg6UIbWoC8amV10+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aho6g6lEhdQndje/femwyVscHvfRzWzut0pnEoevmL0=;
 b=Mv6fxxctqtcYPVN/Fvi0FbsDboZGaJw3j2q/QMykPRAGDTatA94l9lv48T65aiNcZUGBpvOegcUZ9TNQxBEFpFWBX734Obw1tgfICHy2jhV2Z1o8HWTqDxtmdc0ApQBU2LgtKAJ0Z7lPuHDj0rd2CDy4S6BiL0IiduJ3SyTssuBHnLa5/v/f0gFvmmPtTbpP+CCbkQ91du39m/4+c/1056NCpU8LeL8j5kSP6qLXk3H21hHkLitqj1EI4q4weHp94iUXTi0nfF/Zms48jPQiBHUX6xV6xTkGaxJ8JOdxivV9/h2iKTIp8kX1rSR2CR16Ksg7lRR77F61fiFFMq4Oqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Wed, 10 Feb
 2021 18:28:43 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4%3]) with mapi id 15.20.3846.027; Wed, 10 Feb 2021
 18:28:42 +0000
From: Parav Pandit <parav@nvidia.com>
To: David Ahern <dsahern@gmail.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: [PATCH iproute2-next v4 1/5] Add kernel headers
Thread-Topic: [PATCH iproute2-next v4 1/5] Add kernel headers
Thread-Index: AQHW++pEfYaBjtsdM0edPyFVKUX9Y6pOa5mAgANRXBA=
Date: Wed, 10 Feb 2021 18:28:42 +0000
Message-ID: <BY5PR12MB4322E42AFCA2DA0F6A39AAECDC8D9@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20210122112654.9593-3-parav@nvidia.com>
 <20210205181029.365461-1-parav@nvidia.com>
 <20210205181029.365461-2-parav@nvidia.com>
 <e3aaccc1-4a73-9438-2b76-e73cefc3383f@gmail.com>
In-Reply-To: <e3aaccc1-4a73-9438-2b76-e73cefc3383f@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.167.131.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab7173ea-4906-43da-48b8-08d8cdf1b1ed
x-ms-traffictypediagnostic: BY5PR12MB4193:
x-microsoft-antispam-prvs: <BY5PR12MB4193D29CFB850BB469EB571EDC8D9@BY5PR12MB4193.namprd12.prod.outlook.com>
x-header: ProcessedBy-CMR-outbound
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IsXz4F954RqYeGJ2UnrYaAd9zUdwpca1ZTzSH2Ao97DO45OsEOSUZsugb1Dno+ZDm37S/Amf8GIw5A6pYQz84bZqDJMuEN6HiCt2R8qlO5QOFGW2ajR2/eL8OvnOZ8emhuSJTRmU61fz5MdoydIVemjatViqN8XiXMr4Sb3zE1BcELrxMmAhfrZBPfBbf8qnzsfNYInTc5yso5O6N7zOTMMJFw/ani/K/DKqoqK53HTOEfPJIdoQ21bRBdXYqRf/Bp12OWWdUFI8p0ufBMCQQJgcnTMembB/azVm33s56xkGYnlZEMxlJOAtXNOjXM3rAb+FhPLVaP6XRpiMhPaE9UjnvhDub7/sbnhnPe+0A04vxFnflrEdmaB3r+slTEIpOROaE03lzxuNeQCTFniwj+WsTn/oA+PWe02kruI4Q9Ta+GydhDGNRYJihvL5IqNAqo8CI6hxssHGj2m9+AJ6DuzXxBMd+uWRBubsPPgnt/q1mjsk/rcDdwRONwjWT0IXm12TJLSOBfEeHhvIuKeKQQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(346002)(136003)(366004)(376002)(396003)(186003)(478600001)(110136005)(26005)(86362001)(2906002)(4744005)(5660300002)(66946007)(33656002)(53546011)(66446008)(66556008)(316002)(64756008)(9686003)(66476007)(71200400001)(76116006)(7696005)(8676002)(8936002)(52536014)(55016002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?Z0NKRUk3bVhpVmtnWDU1bTJCQ2M0Y3dhMXFZMndiWXMrVldpVmhBUm1RYTNO?=
 =?utf-8?B?dmRGdVpiYVc0eTFVaS9NdWp0ZDZZVFpVZkIvU1JodTBnQVB6WUNGU0syZEVM?=
 =?utf-8?B?VVZ0YzRlbFNJZVVselBLM3g4UER1WDFibzFwNWwyL3puRDlwd0pwdnl5V0o1?=
 =?utf-8?B?WnlRMEh2MStXSnFPb2Q5TjRQMWZ4eHZ5c2JPQ3MvQ01NcVVTSnJyMHc0eTVF?=
 =?utf-8?B?OThwekl0SnhxRVJzMC9PaDRpV00vdWYxRlR4RVhWTWlhZ1B6MjgyVEVteUJS?=
 =?utf-8?B?ZXY5aDhvNnZneEliVmk5SEkxQXFYTE5MWjJpZ2pRcjVncDY0V2Y4RDVVNFE3?=
 =?utf-8?B?VTFDdjBLaklYTUVvTmIrKzFObEthazJHOFN5RzJ6eGNMakRRYjZIM0c0Y3lk?=
 =?utf-8?B?cUZaMG85NG9PR2VoOStOenEvWkdwZ2M1OUd0elNXbEpkUGNiUUZFY05YVlZG?=
 =?utf-8?B?aVRXWEZZTlV1d3BOVnhzSzJKdHVkd0hOZktVZ3RGK1hTWFp1cmpHZDJXb3lv?=
 =?utf-8?B?ZDFiUk9Bc3NNRUZ0UTRneTJxdzhOeExRd0QvQkMrNUp1ZTRsVmN5V3d5NFZG?=
 =?utf-8?B?anlUT2d2bW9sWHdVMXBTRWFIZ1l3VXVpUW5uYkhLaTFsaHhXRk5sTXB0WGN3?=
 =?utf-8?B?VEZzZzhWSlZocW1EV01YVlk5cmdoWC9NN1luS2MzSlFFV2w3N2V5QU14ZGFN?=
 =?utf-8?B?NFQvVVZVZHhyWjNTOENidUZkNUtVbWpJQU1ndGx0ald0cmdzL0NweHFGNjBr?=
 =?utf-8?B?bTdaQWEyKzg0ZllBZVBSUmE1aWJkRTFIR2wyUGVKc2dXZ3ZnQ2pRRmtaWi9V?=
 =?utf-8?B?dEhISWNNZkFqK1BxQURwc0xRcEZSQVlob0F0U0syemhIS3ROdnpRM3dYa1No?=
 =?utf-8?B?ZU1ocERpS3V6cHNXWFNGdElzZVR4eTRiWnlreEszN0pYd3AvWGh6YU4vUnNn?=
 =?utf-8?B?MlpweTNoV3J4Y0RVSERVbkMybTlrZER1SWczd3YrM3BMQnhtVzFDTGlKTXp6?=
 =?utf-8?B?UE5FdmFwRGl3c2JuSVMyazlVRnNtSEl1UE4vaHhMZFc1Qk9uNmdpSHdkdnZi?=
 =?utf-8?B?OGFMTzBtbWhBZVplbm9oakNFQmhEVEtzU1VEcW9FbTB2WVZ6SnVkT1p1NHRx?=
 =?utf-8?B?ZkM3ZWpMZTdqcWhJdGVFQng2N09kRWpkYnJETTVDdFdMMTJJdkROS0pxZmFL?=
 =?utf-8?B?amo0VnRJbm1aTUl5MzYwV2duTGwvdmNZazNoVEFaazRMOTA5KzZzOFZwWE5q?=
 =?utf-8?B?VzBPK2xKcW9nZWJ3WktTUW9WNGYvU3hSK1FSUHRTdER3eHJlSUhvNElCK2NB?=
 =?utf-8?B?TzEwUzhXbytMdUJ0VXJHVlI4WWFXSncyNGZUSXQ1UERWYUN3NnlpT3FzaVRj?=
 =?utf-8?B?N041Q3dBWkliK1NBOVQ1cGlsZC9lMEpwZGVJSmNEcTllZ0N1cXlCTS8weTJ4?=
 =?utf-8?B?WnlMVVFpNlYreTdsQXlYWCtaQ1RMVHhMRUdhTk1Fd0Z5MTY3TVNacmZjWjBI?=
 =?utf-8?B?NXJ1bldpZk9hMXQzbkx2Q2lXQmtxUmNmejR5TkUvTEJxZ0IzYjUyd0hraS92?=
 =?utf-8?B?WkZ0THZ3aHV1ZlRGWHB1cTViZVZPMVUxTm1xQXpaeEtZb3pnT3piWXF2SVBj?=
 =?utf-8?B?Q040eFliWmhaYlFXQmF0M1dQdTNCQmh1bWxyN0ZxVTltVFJkbXo5Q1l6SVRo?=
 =?utf-8?B?a3pRSkJKb0hQeEo2Q2xQdXMwUGgzUk1FMEhOd3VTOUlzZ0txMDlDNEdxZG83?=
 =?utf-8?Q?J7ShFiThq5XSpM0LU8UC2o0ZEJtUYrX3z8B+Ji+?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7173ea-4906-43da-48b8-08d8cdf1b1ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 18:28:42.7650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aqza7HIq+k1DBLitMpS3URoEJu7bWDSfpdpqO4kgu6YIznW2xh4EmBhWIwvaGCQskzNtKqW4qDeQqGus4Q4TXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1612981724; bh=aho6g6lEhdQndje/femwyVscHvfRzWzut0pnEoevmL0=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
 x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
 x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:x-header:
 x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
 x-microsoft-antispam:x-microsoft-antispam-message-info:
 x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
 x-ms-exchange-transport-forked:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=q3b01aQ3bfBrR9x8aaHstZnrNo7Z03M+19vRjExiXxkrjNpx+sPaA/3FL37tBoYOt
 U3T6mBa8gzW0XpBVunm2IrEVoxBpUxOj1pR82Vb4Reu6rfCYjYJbBnpRPedaGytB3s
 H9PeK4QXK90Mfou09GNwLaaEX51Rm9ozuO6lw56o/Pl0q+FHjJvuogmbTYI+zigOlz
 S0W0Zem4f5PVmhYLp1Dbhk7zylf4diuWL/+9GKFm/mJBNvTvv4ezlI/iisBvpzS2cb
 xGjzd4t8Ds04GvzztUdoXHOCRGQWbgz8cIcYMwyF2I8bNleRWC3jjpbtcGSTEkZKeV
 H1dBT2f1aJiMA==
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



> From: David Ahern <dsahern@gmail.com>
> Sent: Monday, February 8, 2021 9:18 PM
> 
> On 2/5/21 11:10 AM, Parav Pandit wrote:
> > diff --git a/vdpa/include/uapi/linux/vdpa.h
> > b/vdpa/include/uapi/linux/vdpa.h new file mode 100644 index
> > 00000000..66a41e4e
> > --- /dev/null
> > +++ b/vdpa/include/uapi/linux/vdpa.h
> > @@ -0,0 +1,40 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> > +/*
> > + * vdpa device management interface
> > + * Copyright (c) 2020 Mellanox Technologies Ltd. All rights reserved.
> > + */
> > +
> > +#ifndef _UAPI_LINUX_VDPA_H_
> > +#define _UAPI_LINUX_VDPA_H_
> > +
> 
> you should grab this header after a 'make headers_install' which cleans up
> the _UAPI prefix.
Ah right.
Fixing it now.
Also updating the pointer to linux-next which has this patchset instead of Michaels tree.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
