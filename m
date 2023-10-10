Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EE1CD8CAB
	for <virtualization@archiver.kernel.org>; Tue, 10 Oct 2023 16:21:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E673E8175D;
	Tue, 10 Oct 2023 16:21:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E673E8175D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DKtOVbzw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kWPOxM7mErqe; Tue, 10 Oct 2023 16:21:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 540CF81374;
	Tue, 10 Oct 2023 16:21:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 540CF81374
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E6EBC0039;
	Tue, 10 Oct 2023 16:21:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A151CC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 16:21:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6EEC161400
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 16:21:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6EEC161400
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=DKtOVbzw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y08pyinX-Ts4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 16:21:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B967613FC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 16:21:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B967613FC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dp47dtKaWqbgZ5fMCF6q2CSf9LVERCO7heE3Qk+fnSNJWwQde7FNqzQXIHk1ufMYkLtXpiTLRbH/F2VmXMa5aiav+Z2PNmK6XguFYsAYrfV9QmJacasKSKlNHFhgYEaVqvL0fhOaboAgagN/mNE/UPCa23EfdafHCnU9cixrMmh+qm2WRtpp7I1scHbi9UhjYWPYDG+gv+Qy5MFur0p70KYmVxHugpaJnyIEFWPrjB57T0XDlNfAKxSrxvfITyghjbS6/Kp0lgrMaVaRijieN3M3GSJMhUBrXdjaXEHRegX/XJ3+TWUAnQuTsZ3u42T/lQp2pwYhLnbBYqpzhhUi3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrnRLimrexd6ti1zrbIGE+YKX4J3LyluLcC3h2ihY9g=;
 b=VRhSh+SwSVVUv+nkNhRS1HhSHQBnYS8A0RHZ2LnMh6uWMqpg+8LiIP27B8IOpfL6tSygvBH+FlLd1d1rnFp5C5K9dLW8xHccKIPqCQLcqoJOXeSEtnNsijsuL4hvq5qNLmQiIxeylYV9ZIvoszXDTVfxUgwi6Oo2VZaeeZCbIsHWuQQHK2MCj1C6UD986VI61b0IpaxItvQrYRuPL1QhBQHCK/yfGkzJOTc/vngVxwjsy6S3LqLaTUy0HFChdQxAofUzWhQGL9OAJ3M3IN5ADYzFL8vT7jmfgW/LDyJq4P0xIqpIe7AYmZ8wJsPOJ/RFjn3UkWZ+7T4IpAqgsw8+rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrnRLimrexd6ti1zrbIGE+YKX4J3LyluLcC3h2ihY9g=;
 b=DKtOVbzwdP0gGWadIkH5DDPRphHO4f8px1LGptRJIctnsGGfUQuIXyQPvXe105M3O42LDobMPFxBbi9lMWNotjNsYSFwJ5ISXR9QFtnv9JK/tlTONlTXuOoE9kYUuMeq1nNxDJo5d9V8lB68kigpN02DZmfqb6KjQZ3zmUDGl98d3cJqeOQzYu9yhqGfRaQ7xUYDNhMoMvkEHYdwcKkPNT+YkPmB7ZN+Ib7ULqp8zwgxm4/stOpkeT54alfElDFOgddPPpAidpeYN821CJImq1KNY3xB4wXs86wg51Qj+SWo6zuceLLev3wnYkWp8Pjn1TXQkqKtXZXxoCCdYYAQiw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DM4PR12MB5770.namprd12.prod.outlook.com (2603:10b6:8:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 16:21:16 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::23d0:62e3:4a4a:78b5]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::23d0:62e3:4a4a:78b5%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 16:21:15 +0000
To: Jason Gunthorpe <jgg@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over virtio
 device
Thread-Topic: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Thread-Index: AQHZ7IkOMX5QOSCSWUux5r7dl0LIwLAmnGSAgAZfpICAAAe+AIAJFnQAgACSqACABEvdAIAAJyoAgAGzmoCABkm1gIAADLUAgAADlYCAAAy8AIAABEkAgAABdACAAAx8gIAAARWAgAABCQCAAACMIA==
Date: Tue, 10 Oct 2023 16:21:15 +0000
Message-ID: <PH0PR12MB548172E68035F25C47918D92DCCDA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20231005111004.GK682044@nvidia.com>
 <ZSAG9cedvh+B0c0E@infradead.org> <20231010131031.GJ3952@nvidia.com>
 <20231010094756-mutt-send-email-mst@kernel.org>
 <20231010140849.GL3952@nvidia.com>
 <20231010105339-mutt-send-email-mst@kernel.org>
 <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
 <20231010111339-mutt-send-email-mst@kernel.org>
 <20231010155937.GN3952@nvidia.com>
 <20231010120158-mutt-send-email-mst@kernel.org>
 <20231010160712.GO3952@nvidia.com>
In-Reply-To: <20231010160712.GO3952@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5770:EE_
x-ms-office365-filtering-correlation-id: 9bf9b790-d47b-4df4-24c6-08dbc9aced79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wIHcNCQ1XIK0rZx3t4d5P82sKgTPLgavPUdK2WZHahRzedwA2+pITpJzKQrRRnbcjfXOXzvFPYjHLhlAfW4Ce4HhhocZjDfvDgmfN6tyEC+QFuJlGsDJJ8dQZi2e/seES6412oZu5CBedEjP5a9ZDp4aSutCigoFkHhVZpF26jJkxqFa5CfsXFjVP3UfToKuCweHQ33h2f8D4a8whdyoXTrRvRJjJlFjFY31pxiEZTBwIF5RdCB0VpM4JSPy9zVJO4WY+pmS38Eiu1Q9qSSV491M7Wbrg0nYSk8GMlpYO0KgkB4QivnGGqhf5w5m9EWVpjGBvbiZJPLiJRPSFkDcJRQTbPmU4pEgS8zI+dNyKUudCoCH9YLXF4Jm68aL73MPHXn5RwPD/4gQlpq53kftpggDFkjt7UNZhA7HRz/p+MI+eHiNF5w3uET0MChNBDuWaxconaNdwXGZAqM1JgUxbs3Gb3t+9/g9+pViipggOuwpPv2A7G2WJOlEvRqxHvs8b5L2kRiMt8jRqn+bC1Yxehsviu/c10ibT0RpTql6bgXF42KzkbpsINbuu+2TI4P4Q7me2TweCRBMjKB3IuxwrYV+bm+yF+WtChtYP4XVb2QDGpogGTFXVRErLM4+GwMZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(76116006)(110136005)(8936002)(8676002)(5660300002)(41300700001)(4326008)(316002)(66946007)(54906003)(66556008)(64756008)(66446008)(66476007)(52536014)(4744005)(2906002)(83380400001)(38070700005)(38100700002)(122000001)(55016003)(107886003)(86362001)(9686003)(26005)(71200400001)(33656002)(7696005)(478600001)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6168cArFl/VYepYNJsL69G0WCPrFFfVqh7BTlQRagzADbd6wfEqhx2Mern7t?=
 =?us-ascii?Q?QSsDc26qoXB0FguyZ2E8gK5w6yjgPxzIfzYjWUYBMjRCC0GoMrCGo4N1+ME9?=
 =?us-ascii?Q?k/iuhY19eWbvMsYDTk9w8gMa0g5zxEgUCfO1LabwEUWMoCymaSLp5G5njU1j?=
 =?us-ascii?Q?B3jPeNh1mqtUU1bA/6+5lYyDbmJbtZETb4iOg8TploJJ0ax1x7Q24m69oY8K?=
 =?us-ascii?Q?q2BiAyFWyoaVFY+QUsA8X1TyDWNo/aFsQFaJD2IIiavjj+re5ZzZuUjz1Zai?=
 =?us-ascii?Q?Et+nTwb9tq7ET3hnbFtOCam+ag7fwKvXoEtyOKf9m4i6MxNpJ7cNkGg4Bs7+?=
 =?us-ascii?Q?ySPS7kspWvtfdVRMPFGSgjg0F5LRrve3Oiv81fDkhQqJV3SMGK6396m2unuK?=
 =?us-ascii?Q?xq28aWPQz9grE7fBOO3L7QN3w7uTaR2Hj/fNUM6ye3w3faIak4ZwF8sMaCr9?=
 =?us-ascii?Q?twr6XhjZiYE4FQXgaesHkSFlQxo0Po6yzP/E03e9SerXWlri8GDwVFoYoSIG?=
 =?us-ascii?Q?fZuaMvokFOFWnS//aWpBDjZ/0CJcGl5ebCLAkDBgi9fPdkJQorZLfmcsLlFI?=
 =?us-ascii?Q?xV0OL9C1eyZb4YDy8UYm1dzutPXTmifEE+IQdfejckA9JlQuK5ldQeMzqEC3?=
 =?us-ascii?Q?MUPxOxOmTwaDLRWg/0VocP48i4lLMVdmK2iLpxtpLBHcJYU4P/Ys1qgCQt2t?=
 =?us-ascii?Q?ji6rkGAUZt0WBpYQyfgqbisl423vJ9hsAqHy1WIZgw3B4phrOfv9JNjqQVYE?=
 =?us-ascii?Q?ajt991hL40KLNlrTpgZhIs1ap5AvHrUGr4v7O/3SIUmyesW/J2TMUDtz8CTV?=
 =?us-ascii?Q?8cR/YpfcZyd5p7t/WDxkZdanFUmkw7sZLDxUCMNT5x40lPHAqXQ5CDcrDbK7?=
 =?us-ascii?Q?M8DQxw3NwA5sK6b/WR1apOrofRtABoxVKuHIzNp2qJ+BSBPUjlUyEIFylLjp?=
 =?us-ascii?Q?HVvYlIA8h30EInh8CQnn8mOKfDTVoX+ADrYNqdPE1Mfkhb2JVO8b6h+nSXK5?=
 =?us-ascii?Q?ziS53PvU5uT8hOefBoPI6rtwGiduJi6lsIEbbJoNGZm1sfDeYBEhvNs8NAVe?=
 =?us-ascii?Q?aPjulilbp9jFFY9GyfxF+X7FsQBqYn7iWXsIpjWiT1iD2nKasfOTTpyrMdgl?=
 =?us-ascii?Q?jIJkdH8E8hr7wvxaUmWKJQ2dyRuGgA7FL19RAT3+MAI1czF+QYpKfzn5p56u?=
 =?us-ascii?Q?RICq/hq/hsSkbmSy+BDFznO0dqplD3uhQY0F6XrErfySxQbmzar1eMNwl8ki?=
 =?us-ascii?Q?+6B38U3KgjXErVut7s1vC0n2N4KQ26SleLgsYa2ZvBfNRaIDM6tcdVRzZ7Od?=
 =?us-ascii?Q?hm54Z9JSv876krkcQaFPP4j6j0E7gpr8gaxaIbQe+Sf6Es0kssabYndA1SRB?=
 =?us-ascii?Q?hqT6zPpjR0Ph9nVHkZd6Y118OCmSGwffCVUvki5HYfaB9fEUJxyGrMoHXLS9?=
 =?us-ascii?Q?kGTYrw2I8n3O5ij6DGaKYHOLpPU7rk6O0hC1xWzwILRP+IG8BXMSWN18kDua?=
 =?us-ascii?Q?wnan2Lj3/hQduGlZpFW3Dvobqde10fG+sqKmNdeBo8YY+UM5Bk+FP5QsNo9y?=
 =?us-ascii?Q?X/mhvAKq4CzfBkE/r1I=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf9b790-d47b-4df4-24c6-08dbc9aced79
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 16:21:15.8205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zYeYciEUG8jE9bCnnJ4U8pCBz79mhmR0RDwMUXpD/GAAc4/zqe5miFNaIjlDAY5q8qMH4L2KF6DX+Cgxd7IOGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5770
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>
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


> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, October 10, 2023 9:37 PM
> 
> On Tue, Oct 10, 2023 at 12:03:29PM -0400, Michael S. Tsirkin wrote:
> > On Tue, Oct 10, 2023 at 12:59:37PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Oct 10, 2023 at 11:14:56AM -0400, Michael S. Tsirkin wrote:
> > >
> > > > I suggest 3 but call it on the VF. commands will switch to PF
> > > > internally as needed. For example, intel might be interested in
> > > > exposing admin commands through a memory BAR of VF itself.

If in the future if one does admin command on the VF memory BAR, there is no need of cast either.
vfio-virtio-pci driver can do on the pci vf device directly.

(though per VF memory registers would be anti-scale design for real hw; to discuss in other forum).
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
