Return-Path: <SRS0=dJY/=FV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63144C4361B
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 12:13:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1011238E8
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 12:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1011238E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7081387A2C;
	Thu, 17 Dec 2020 12:13:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x7utQ+uwEuXA; Thu, 17 Dec 2020 12:13:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C474887A1D;
	Thu, 17 Dec 2020 12:13:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A47A2C0893;
	Thu, 17 Dec 2020 12:13:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA716C013B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 12:13:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C896587863
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 12:13:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id egsntcFV0g+N
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 12:13:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CD92B8785B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 12:13:21 +0000 (UTC)
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.100]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fdb4b5e0001>; Thu, 17 Dec 2020 20:13:18 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Dec
 2020 12:13:18 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 17 Dec 2020 12:13:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDtgY+SIRl0vZsijt+aURfx/J9ZQ3vqqvCp9RNZGQSGKeYqo774BlKSekRoNwcj8KZR0OjrX77ungtEJVnXmYVQx8iJRJTZbWObJisVzO2GM1s58wHU+plkK4aS2OGSMJ+XXSgcnzo5zXrvauqThinScnyknpmbwzK/9Go2g/qkOtIuiuOZt/khf5B/A/A+f1oTYaW995EpXWA7YE6PD0kOImLIeTMiohG4wWQMSZ3ys9pITT1lgLgDNolaUnBNL2YKgx7QSGJOcm90XYqZy8Q3BPEdnnFC4T78FFySDvLk28TcXhNp0RVD0SBO58qs5guCw0601S6c3heWkDVzIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okRWSnXMyxXfkCkJ1EUrNfpTQGFVi/k4E7+yxnvMFkQ=;
 b=FfqJA7FkZa98U0dwWo601emO4aAWiNq29pETsBQtPLZ6r8D3zpEg/ZVhlP3XNgYQ23APfKp247KR44iPHwAuVRbn858ReWvCktPmKSeAjaR3GgveL+qS+drS2/NgCNKjdauwjObg8xIPnaVF0PPlEhyki3LJlAWRsFGH/vc7qQ2plug5ymEz89fxoEJdsRBAhf4tKR4ocG2ZeLDQuUGGyi7pg6rM/yaSv8h3evfGNzxNrWrn2fpXKz+KUsyHx7lal4Lxk1+Ntg604xmBCt2w5yVXd3WzIW0UUhW6Ek+CaXshofQbfaGY4j6tmibi+y231eKwMUmrME5B53zLPlBpfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Thu, 17 Dec
 2020 12:13:10 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::a1d2:bfae:116c:2f24]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::a1d2:bfae:116c:2f24%6]) with mapi id 15.20.3654.026; Thu, 17 Dec 2020
 12:13:10 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH 0/7] Introduce vdpa management tool
Thread-Topic: [PATCH 0/7] Introduce vdpa management tool
Thread-Index: AQHWuL6/zQf/qaV5ZkSpuhr8mZ5CmKnLXKYAgAFlMcCALOQ1gIAAczMAgAANPoCAADNsgIABEHUw
Date: Thu, 17 Dec 2020 12:13:10 +0000
Message-ID: <BY5PR12MB432213E44687CE351B835A66DCC40@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20201112064005.349268-1-parav@nvidia.com>
 <20201116142312.661786bb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <BY5PR12MB432205C97D1AAEC1E8731FD4DCE20@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20201216041303-mutt-send-email-mst@kernel.org>
 <20201216080610.08541f44@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <BY5PR12MB43227CBBF9A5CED02D74CA79DCC50@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20201216145724-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201216145724-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [49.207.199.116]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b96f6829-ac9d-4597-8f42-08d8a2851ea9
x-ms-traffictypediagnostic: BY5PR12MB4902:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB49026BDD2A0B25B3CCF55778DCC40@BY5PR12MB4902.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oi7YEw+sTKOnHaQxhXS2Vb7mNz7IJx78Uyb89hb+jcf1+uCGxEqR8Nm2Gsn1ke4aAlI2yIHgOkqABm3oNR38WT42OsJQ6Kh2T6kWbr7YXoUU2mjEvhGonxlK9j83TNEKwb0HT87vIGE0GZiOUdWOFVLOWaUogkynhHWoNIqNGB0gZruqZYLs8yb1Niiee5Thn0vmVb5xJg8iAp+QSTZA0UbfTAT3sD85VR2FiJGnjYkrd6VlcyG+XatHIP3HLLGiWkYCFMF94icbQXgm49S1QzoK8eipooXTL7zHouWW/ysRxzYcuEY9lIRlN0DSr3KRMv02gMSrMocAT29QGrEVpw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(66476007)(4326008)(6506007)(55236004)(2906002)(86362001)(6916009)(33656002)(64756008)(76116006)(52536014)(8936002)(8676002)(66446008)(54906003)(66946007)(66556008)(316002)(55016002)(26005)(478600001)(7696005)(186003)(71200400001)(9686003)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?KwJvDX4nMJPThHOMYMs6QEYWEAb2MRxMxqS5nIsM3DND2qIfwmJGSbBMRBPa?=
 =?us-ascii?Q?47d2obeQ57bMDIsQ7jORXXWfx3ijiXYVq/KIJLk5kc1w9x3ZLLOilKXR5Rzn?=
 =?us-ascii?Q?W/s89kXhmOFvigoemZpZ/DIFVzqeNW/IN3qepGhphNIUtYonAdDn4qcoFoCv?=
 =?us-ascii?Q?z3P6FyZ27H4g1YAymaUh+iejUYzqn0FyfCmiHOPBJovGQWicDI8BdiBELB/A?=
 =?us-ascii?Q?9wsrL127j9AVvy3m3QZrDWLP5Ltx5amgLAV4vZ9vqq7TJiBgndqmqxPV99AV?=
 =?us-ascii?Q?pyhiIagk9wNEck4UhiBJz7k7E0bJ4jZia81YDIlvAYJxITzIA8reUjJn6yeq?=
 =?us-ascii?Q?XAyERT7zYEoALZLa9dHMfytm9Txou6Nj3XwKdqR2Vuvbj5cnDhhFyxBpD1ix?=
 =?us-ascii?Q?8n4uyMvGptnMNig3o8nAgyb0EMX6/S+K7TpeDN2hoMGzUOfwBII93Rdr9PqH?=
 =?us-ascii?Q?onk/Hrr/ETPAL5BDMrs5qSlafulIEfixBbds+LzyGLNQS6+nfENW0Z+A64Xn?=
 =?us-ascii?Q?3+MvXflJ+vD8ZZBg3yajMVzUA9SG6G61WDojqOzGisKmgHxOXqN1rMjmqKAQ?=
 =?us-ascii?Q?wGcytUE6+YoKAWmxflIDea1WJA15N57hzmFtAPcwoDCcs6x1q3G/qywfgNxf?=
 =?us-ascii?Q?9ukOCwlR9iog1GgkWy+w0oFmtehFvPEN7RzY2yj4iewBl2cfCp272JglSZBP?=
 =?us-ascii?Q?H2GQJBqpsjiERwCcHrr7pqRQdezIAp3PbR4yPVZZDM4Uh6f/TYzmE8/f4qlg?=
 =?us-ascii?Q?BA3Qf8eHgFC6CtPISOW7v4VGBQZFbTjqP080wMZLQBad7ZEmIOEUP4kx5Bhj?=
 =?us-ascii?Q?Xu+AdFuhQjJVE0sjTVfeFr2QVmmLPoRxFmdYuamARxrPM1p8UtbiE8Va52sr?=
 =?us-ascii?Q?I4JgY/StMSw4+1LAHbPdudT+CrcFIHQdpKuI5ZrHAxAJCaD/rtV6e56U1+hO?=
 =?us-ascii?Q?rRu3G8AxNH3q7ogeodhqfIHeNVF4Y+86Yr2pWEfFZjY=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96f6829-ac9d-4597-8f42-08d8a2851ea9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2020 12:13:10.0549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fltABNW4m29kYyz114ILkmCKAxjnfpmGpcs1MD2S5e2iivHV1OT8EsafJgjAinEqMrQ/z4w5RafQCJR0FupVbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4902
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1608207198; bh=okRWSnXMyxXfkCkJ1EUrNfpTQGFVi/k4E7+yxnvMFkQ=;
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
 b=dnYghIlSGd9ik+BifR7KCSzJ/s7SoFDmug1QZEm49L9Hg/IfcumxdyXhaooCzUanN
 fMLGNPZQonxFwGkExlqrUi5dsgpIWGDYUsOfrn0kxc4PMrcyaND+5/BQ0NGMO70j2c
 7X9XR8xF1zNvj3S0tGvqePpkwEUtpSVIQycLhAsP+wwlnnKsUNx/rUhkL2jOCTbZ9f
 RtvRD71cIafKuMBy0AMKXtuadjlqINVrLb32YMeeTQfcNTgA7WIKRhlSgVzUGQBnmm
 mOBKEpD9us8KNf61/B7ZlF4s9roLKK+wxlW/1wGU3SSwUa1RSQkifpc+rY9Q51MsLd
 isRSIQUVBm7MA==
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



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, December 17, 2020 1:28 AM
> 
> On Wed, Dec 16, 2020 at 04:54:37PM +0000, Parav Pandit wrote:
> > > From: Jakub Kicinski <kuba@kernel.org>
> > > Sent: Wednesday, December 16, 2020 9:36 PM
> > >
> > > On Wed, 16 Dec 2020 04:13:51 -0500 Michael S. Tsirkin wrote:
> > > > > > > 3. Why not use ioctl() interface?
> > > > > >
> > > > > > Obviously I'm gonna ask you - why can't you use devlink?
> > > > > >
> > > > > This was considered.
> > > > > However it seems that extending devlink for vdpa specific stats,
> devices,
> > > config sounds overloading devlink beyond its defined scope.
> > > >
> > > > kuba what's your thinking here? Should I merge this as is?
> > >
> > > No objections from me if people familiar with VDPA like it.
> >
> > I was too occupied with the recent work on subfunction series.
> > I wanted to change the "parentdev" to "mgmtdev" to make it little more
> clear for vdpa management tool to see vdpa mgmt device and operate on it.
> > What do you think? Should I revise v2 or its late?
> 
> I need a rebase anyway, so sure.
ok. Thanks.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
