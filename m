Return-Path: <SRS0=2z8p=FU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87109C4361B
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 16:54:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CDCE225A9
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 16:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDCE225A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BFE8D86822;
	Wed, 16 Dec 2020 16:54:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0d7SrMxsJeMJ; Wed, 16 Dec 2020 16:54:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 451808681D;
	Wed, 16 Dec 2020 16:54:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24BC4C088E;
	Wed, 16 Dec 2020 16:54:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA84EC013B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 16:54:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8EB0986822
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 16:54:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tMDHCgzuDGpZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 16:54:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1EF108681D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 16:54:40 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fda3bcf0002>; Wed, 16 Dec 2020 08:54:39 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 16 Dec
 2020 16:54:39 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 16 Dec 2020 16:54:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3zoT0YqO7PycO2ofg8iUmoWm/Tb0rOHqiv3YRbFJSLvQ9ipzUnqgWKuHb/B7SmA08EBbJsgzU1jC5yAUmKk0FQPddpf4Fk3PfKrhuYJ3JSOMbTMET53QV34Zo+Fi1NFyHZHQqAZSwOB3KkeEsRXfZAbzo6wmNwtVe/32Hh0bgf3AoVgdmDCDMTK9rpVWNPTqS6bWrhD1rUnkjoegpw+rDafSLim7id11s2oMBi4SlT9Lx6SdHVrDE761TORmoZPssylU72g7Qoz8j8DsYUaB930sHpr6Nni/PrKetnAnxYkel3sjOfh3yMFnhA5Fe1iL1SasNwBiySGy4qhKP7qnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaHb0CMKti87yaa7Fwj40EjgIj29/vMVu/7rWLzbX0g=;
 b=VAIXSJ9DYeisGo1OrP0TYu1BkV+Br2TmHry4PDYhyH4KBjstJ51CUHALVubKzRw2EMTwua/0xfe7fYf+WKNAm2i7vXyxKtzhe0KulwcEDRny40qQFFGl3Gj5wVe12t1Guf1SRkWbxgyBzb3TU+x70wpljdy0Q8RRMqhkvRLk4WGbJbqXSa4UhHjMrxXMK3M9LX4nxyOjVXtIyaQygk0tdo5hoSJRYhFPKMUtp9TOUAwnFdBeq0bApr9zYmQ86dgV2HzvjumbUnObY18h4eoDtk/vAN5hNzbYkDoNm3gxjjBMD6pgZGQGhY+T/r9+whtrOH+Mbw+cfTCO1eMCwvnmTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BYAPR12MB2933.namprd12.prod.outlook.com (2603:10b6:a03:138::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 16 Dec
 2020 16:54:38 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::a1d2:bfae:116c:2f24]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::a1d2:bfae:116c:2f24%6]) with mapi id 15.20.3654.026; Wed, 16 Dec 2020
 16:54:37 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH 0/7] Introduce vdpa management tool
Thread-Topic: [PATCH 0/7] Introduce vdpa management tool
Thread-Index: AQHWuL6/zQf/qaV5ZkSpuhr8mZ5CmKnLXKYAgAFlMcCALOQ1gIAAczMAgAANPoA=
Date: Wed, 16 Dec 2020 16:54:37 +0000
Message-ID: <BY5PR12MB43227CBBF9A5CED02D74CA79DCC50@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20201112064005.349268-1-parav@nvidia.com>
 <20201116142312.661786bb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <BY5PR12MB432205C97D1AAEC1E8731FD4DCE20@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20201216041303-mutt-send-email-mst@kernel.org>
 <20201216080610.08541f44@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201216080610.08541f44@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [49.207.199.116]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ab066b3-3e75-4382-7843-08d8a1e345c4
x-ms-traffictypediagnostic: BYAPR12MB2933:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2933B2673A6CCAAEB5E3F9C9DCC50@BYAPR12MB2933.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ReyzveE/E1Hel7HFl3DzC+gFn3J0LOWEKoC+t8oklyY89nidmrSDYt7RGZjZXyqDrkUmBWRl594iX0sfzmUspAMiyEBZ9ioJpPr2E7+PReNxJKOtwVSJv4h4yf4xEZ86VnjyJwFVjIwH9pVCyYJcn7x6C7ppHg0I5GaUTpAF+bNnUUnNejA3Hthqd8d0TKekVWitxrWc2Usa2uMob1A15+bZMbTrj3OEQfXx1rlapTtoEx8PUe0PKmZYZu8s+ZyWr4m8jit6us/J6WxxLaFQI+ha+ScvJORHtWjIswOn1dISQ3yMEc87XTK6s5SuwqIQ2VE69nbl8aub8Kt9ElZBvQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(110136005)(316002)(26005)(66476007)(6506007)(4326008)(54906003)(52536014)(9686003)(55016002)(76116006)(64756008)(71200400001)(55236004)(33656002)(66446008)(2906002)(66946007)(8936002)(4744005)(8676002)(186003)(478600001)(66556008)(5660300002)(86362001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YYVxevsDlx+ka3UakqYsROeFa26+zB1uOX08wyqJFsaa6PCnjcskCFfewRg1?=
 =?us-ascii?Q?1sQmPuvI4d8ehEyxiVClgmMSxrRZqpSmASIV9Glfb7is3JTOf/Tz8g3q4H1q?=
 =?us-ascii?Q?5iuxreKXtfo/fGLKC1LhUyfnSPn1m/BpqGmqlEeTReu3iUOvFcuTlB/HLgoE?=
 =?us-ascii?Q?fk86a2B5RFufjWIzISoOOfInf4njERnezKOg0TZ+MgditVQAgrNU57u8PAxx?=
 =?us-ascii?Q?YNQfhB7IBiWvBDe+K/ZAJY1NNcEI6kfB8/Gdx7cu3WtWSA12mZOPTfTp7esX?=
 =?us-ascii?Q?27w6KDzs2T5LQNDdlJsEI4zd416k1+xNpK91g8WP3HmhyM8l3O6GOtJxzZUG?=
 =?us-ascii?Q?e3KPSqLKNRYa63EHXHT8cNtAbRt1O4Uu64uyyaaC9dOjw3Z59Bqbck+GYkkn?=
 =?us-ascii?Q?pT9/pG/myUY7G99d47pnrSaII9sggQ2uTpwYxrnJ7QGJb8UP0SpIIMki7DHF?=
 =?us-ascii?Q?LAetcLcKetw2Wv4o10UusNGOObIDmVe6GqnrH42G97nDxSDtEVg8WR7jwW3J?=
 =?us-ascii?Q?OmVX40JTG89WqhRyPAtgv1VJAWlffUGtdgHQ90yp3awsSh+cNSLrv9HyEvPD?=
 =?us-ascii?Q?rR7NEwSekBGJq7VJDfZ1hSCHNOO0YFNsJdrSeRoLvMllY07COazhNbfCwgQo?=
 =?us-ascii?Q?In/bKOZcUY366lYsjAqXvQbsUZggQ0SPgtIjmVl2nmlNVBPXa8+DxB3oKpwk?=
 =?us-ascii?Q?BpXdiHCWfQhS8uWrrsY3I0MLigy4GjPrDE60UcLirwaJD3yvXSyflDqYXiS2?=
 =?us-ascii?Q?k3DFRdrRgfMPU3Qca03hJzeX2x01HiP14x1EGYNEVPUyuZQgM8053+2yi8j3?=
 =?us-ascii?Q?PoQBphRg0T6p5PSHdHxX78SNn5skjA5w2FXl5d3oVGrtcQw4N/6ewhFMUcXu?=
 =?us-ascii?Q?vfMiV846FkaA2iu2oeuHxj2/LVA9uuUGCvDH4P/Z6QZZezKLcUHxogKQqIE2?=
 =?us-ascii?Q?1wh/4flvkHeZErosrjayLLsUO/RnbHimqVBNogCk2fU=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab066b3-3e75-4382-7843-08d8a1e345c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 16:54:37.2619 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HB08i5kLXBWf8XZu8SFWEAH7sSk6n+MXQIWPQ4XNW7aDrE5NoCQ8ekGoW6ROHVCnIC1zLR9Bdgy/yPSAW477qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2933
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1608137679; bh=LaHb0CMKti87yaa7Fwj40EjgIj29/vMVu/7rWLzbX0g=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
 CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
 x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
 x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
 x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
 x-ms-exchange-senderadcheck:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=N9kv+0zujHfUBPFDSPQOguNHdDI32dWPWjyUIHcC1jLD+qm+3egN5Y8Qel1Ox3Cfx
 bd4sgkeXaAEkfloa3Ih/CtU9P2OClR9L4zXKXkVwhDcJJJOkeVbVqK0iPAI65gnwtH
 qgWtZ9GEJ55T0tHj4arMGL3iImS/b5ZX5RLEgXi434zxp6zlPbxUgsrCGsrkkhrnbW
 yQYNrzZDAZaskDb0oDUoqHPOhMSrzIgzd5S/JsmIs5hrh4g9Dun4q6EtSac2KyZrKh
 kP2gxGPy5KHscGh+j8TwvALhMyiqbXGv6MBTl927GfK5PdfKcRCsAoX42HmXcRWtbB
 hBQoXVk8O7DyA==
Cc: Jakub Kicinski <kuba@kernel.org>, Eli Cohen <elic@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, December 16, 2020 9:36 PM
> 
> On Wed, 16 Dec 2020 04:13:51 -0500 Michael S. Tsirkin wrote:
> > > > > 3. Why not use ioctl() interface?
> > > >
> > > > Obviously I'm gonna ask you - why can't you use devlink?
> > > >
> > > This was considered.
> > > However it seems that extending devlink for vdpa specific stats, devices,
> config sounds overloading devlink beyond its defined scope.
> >
> > kuba what's your thinking here? Should I merge this as is?
> 
> No objections from me if people familiar with VDPA like it.

I was too occupied with the recent work on subfunction series.
I wanted to change the "parentdev" to "mgmtdev" to make it little more clear for vdpa management tool to see vdpa mgmt device and operate on it.
What do you think? Should I revise v2 or its late?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
