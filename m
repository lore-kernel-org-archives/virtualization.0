Return-Path: <SRS0=voLO=GK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B3FC433E0
	for <virtualization@archiver.kernel.org>; Thu,  7 Jan 2021 03:48:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC1E22CF8
	for <virtualization@archiver.kernel.org>; Thu,  7 Jan 2021 03:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC1E22CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DD73F20484;
	Thu,  7 Jan 2021 03:48:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P7KeGqwBUoRE; Thu,  7 Jan 2021 03:48:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E2FDE203AA;
	Thu,  7 Jan 2021 03:48:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2FB2C088B;
	Thu,  7 Jan 2021 03:48:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4502BC013A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 03:48:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3ED4C868FB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 03:48:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fCbyT5oxw7vR
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 03:48:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 33DEA867F2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 03:48:20 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5ff684830000>; Wed, 06 Jan 2021 19:48:19 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 7 Jan
 2021 03:48:19 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 7 Jan 2021 03:48:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFB+NHdTn6+8UEXuQB+oYaQOGSmKi4TJxWlIRehCwD/VDWgFhxpsRRaNHN8T62nolaHzeIHn/0iyQeutl0qZyQy62ngjQ39NEWBtzkxPHtIY0wKm2rUtMgiDE1XJ417n+dEh3U8TAprzcbd8VIWPJ8lKoYY58D5+jzB5s+6Y+SEYJW5Xln/vYE7svt39uiDvZSjYCVAxZH5sE0sY9a58yBIqlaQ/QGNEkGTAv0FxOX6IU1dLHDXamzX2KeEji8p+vdjUT4tlaGW0ZusWWubBZjcJe/xA6M22u/BBahswDuZFzD+WgAcDr2nGMXNPB8OydEk8kwyi0qTIpdkA+m5tyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdXy72d7azRByM7/NkVjas5/1o7oilKWRZn3MBFBkTk=;
 b=XowtpTBE7f4ODFO0doPN7YzxySjv3HZrDkr4WeWwP++QCmZ6p4NqsRTv2Wa/OLBwM6cBOEkWg6iOopxRSwLe455HY8NqburbSBFpjCiPPUfLODCWnHmyZF5pdPUkunBS4uTdcrqsoXRTK6fLzzmT4VheFgF/4Va2afOouDtVAMDTcCikSK+JQaLE8J4VXLSh4Po5xN4fLEgt//+hNMglD5EF1ZubAL8ntbY6nitrDuuhx9E2yiR9Y/39UYO2w13NWu/JJZgtbr8dB7FeJtl0nrQ3U6j4io+rVZ7kz/eYBecK5nQ+nxiaJ4LxQtv3sfO32ndXBIpr+vNe+QIZzk9n0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BYAPR12MB4774.namprd12.prod.outlook.com (2603:10b6:a03:10b::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Thu, 7 Jan
 2021 03:48:18 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4%4]) with mapi id 15.20.3742.006; Thu, 7 Jan 2021
 03:48:18 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH linux-next v3 6/6] vdpa_sim_net: Add support for user
 supported devices
Thread-Topic: [PATCH linux-next v3 6/6] vdpa_sim_net: Add support for user
 supported devices
Thread-Index: AQHW404ZeuD1Nrf6EkKQQnhYNrY/9qoY6uQAgAAB4oCAAAVhgIAAAsjwgAAQXACAAoNJoA==
Date: Thu, 7 Jan 2021 03:48:18 +0000
Message-ID: <BY5PR12MB4322EC8D0AD648063C607E17DCAF0@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20201112064005.349268-1-parav@nvidia.com>
 <20210105103203.82508-1-parav@nvidia.com>
 <20210105103203.82508-7-parav@nvidia.com>
 <20210105064707-mutt-send-email-mst@kernel.org>
 <BY5PR12MB4322E5E7CA71CB2EE0577706DCD10@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20210105071101-mutt-send-email-mst@kernel.org>
 <BY5PR12MB432235169D805760EC0CF7CEDCD10@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20210105082243-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210105082243-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.171.231.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc368dc1-9879-4f91-f254-08d8b2bf11fe
x-ms-traffictypediagnostic: BYAPR12MB4774:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB47744DA20BC74D595E50BAE1DCAF0@BYAPR12MB4774.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JBNgdFgWiOddymdDAwXW/7EYzxO4sSoT/x0CREMr22qYPjrRRkg+meKuliq7o3f+LbemcwLT5spO5uuP86fK3XHiEkKcAmMTAODm0Y/clSX4pHz7DM/a6V6aqkXV6sgh+gbiHHFz3ARj1fM1ivd9VqcvUUR6j6hIcmvFtMQQMkcO34SXfl/OJxl6woLpiOY0h9D4rhXs95rzkEilbAnR6xsnzku+NpCOiWIuvyTs1n1YHOmszriH0VN7tV219S6oQPV25OxepZ18MkGXHbr1iXSb6mtfjM9mX+MnspIFl49J9LM/Pa81ayv0mhRMiyR08fKxSsctNfQ5ZI+lfb9tyS/dKaXOmEExr44UFQdC55JMDa0T7FSeUttlbbRuejG0qYACF3c2zijFAaSRzXeo7Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(66946007)(76116006)(316002)(54906003)(4326008)(186003)(71200400001)(478600001)(6506007)(26005)(9686003)(6916009)(64756008)(66476007)(66556008)(66446008)(55016002)(52536014)(33656002)(7696005)(86362001)(8676002)(2906002)(8936002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: iHB0eAl8tnu019/mrF+oc3z58b7YCDeit8VG1iw3KX1iILrc3xfX+NB8x/3PAguy9o3EOxYYblBPsPc/8G9vFwhTkKEhtCko8cZK2WR4oL4rBe/QjYVWXX0Q3TbvyQ4zl2PM2sFAngMsw84SkjhmbuqgeCU+jplwvOXvWDC5GPbXqarH8lNZsKC5ZDuM4KaiU4xuYGY5b7xSnprYZl0w6rZFhPwbWtDWa5QWqaCxszkU3DVoB0XArzG239w7PiU9e7j8nauy0OM58DWfTTY2xW9hPnfwLEU/1yPytlBaN37SyUgEGOvQIsdoTsar0sqMszC846Pl1AvtuatDqyTdVc0Nx2C/jKatfrinNiw+24ufd4g0goIn41i7RGHCh9SVmqwSL7vBxQJmK/ZC1So0qPb5jtL/LcE3ZpfmNfa8wcpwjK977M8A4TVYO0Rew+mhGUYnpHyAbxdHnvZwj01p+hOJCDgSeN0wOUNcShljmWHP/YSl3AQnCPdRdssd4shWeAfFSDd/o+fjBtOOxAS6gvFdmfmrgoHvTQruUQERjs7eNujWWf1kOldGb915rA7yY5gTFPUnFgBLhV8W/U7FXufISXVLl1HjjIuvwh7dCC9+/BhQtsMWoLDqcvwZRb4AK+I7yO1pl4rM0FlbEXyKb+G/AZRcnAyfykDmLn8bnKOHBoX1l3327s0RXxv6gEGL4tvSEChOWZkvf0gRygpBmddwrHIIbHC6vDDSdK90RpzFqMHDLi90D0t49TpojWwD
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc368dc1-9879-4f91-f254-08d8b2bf11fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 03:48:18.2288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ar+bZ8pNCrBq8YYZ8kn8gxpYTEHr4dYjEwQr9aL6In5y5lTt1PNc0ujXQEnaRuo/c/LFfZHy0VvctAC14TAziA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4774
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1609991299; bh=CdXy72d7azRByM7/NkVjas5/1o7oilKWRZn3MBFBkTk=;
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
 b=qXTLjFKjF14JG7WChvAun3LbENRiSHRIeJhqUYfksCdvqMPUO8f4g5HCZXXhgyJdC
 LaomuzWpGpbYdeoi7m5KLPWXObVmqBtBVH0JRxhSSMPMT89VskV8JF0ZLdhC7RRV4p
 pXssVWanonlZDh2/UH9DlAiDMonHLzZUWFuHOM6/Gcup+xgAE4xTIT7Y524Bkb71F0
 LTj3QMDMHSqzRnkK/29x/HJ9a8d9MdYJYIFTRKmv9A0QTVI1BjePZGKS9J8ypLbfuZ
 dY3M86T3H/JcdXpmJNGOd+oqdHMRIZyuLSIcplkwACL5/lhXPO6DYPmuyctZp2OjoB
 FtFZGRSeaEjPg==
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
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
> Sent: Tuesday, January 5, 2021 6:53 PM
> 
> On Tue, Jan 05, 2021 at 12:30:15PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, January 5, 2021 5:45 PM
> > >
> > > On Tue, Jan 05, 2021 at 12:02:33PM +0000, Parav Pandit wrote:
> > > >
> > > >
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Tuesday, January 5, 2021 5:19 PM
> > > > >
> > > > > On Tue, Jan 05, 2021 at 12:32:03PM +0200, Parav Pandit wrote:
> > > > > > Enable user to create vdpasim net simulate devices.
> > > > > >
> > > > > >
> > > >
> > > > > > $ vdpa dev add mgmtdev vdpasim_net name foo2
> > > > > >
> > > > > > Show the newly created vdpa device by its name:
> > > > > > $ vdpa dev show foo2
> > > > > > foo2: type network mgmtdev vdpasim_net vendor_id 0 max_vqs 2
> > > > > > max_vq_size 256
> > > > > >
> > > > > > $ vdpa dev show foo2 -jp
> > > > > > {
> > > > > >     "dev": {
> > > > > >         "foo2": {
> > > > > >             "type": "network",
> > > > > >             "mgmtdev": "vdpasim_net",
> > > > > >             "vendor_id": 0,
> > > > > >             "max_vqs": 2,
> > > > > >             "max_vq_size": 256
> > > > > >         }
> > > > > >     }
> > > > > > }
> > > > >
> > > > >
> > > > > I'd like an example of how do device specific (e.g. net
> > > > > specific) interfaces tie in to this.
> > > > Not sure I follow your question.
> > > > Do you mean how to set mac address or mtu of this vdpa device of
> > > > type
> > > net?
> > > > If so, dev add command will be extended shortly in subsequent
> > > > series to
> > > set this net specific attributes.
> > > > (I did mention in the next steps in cover letter).
> > > >
> > > > > > +static int __init vdpasim_net_init(void) {
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	if (macaddr) {
> > > > > > +		mac_pton(macaddr, macaddr_buf);
> > > > > > +		if (!is_valid_ether_addr(macaddr_buf))
> > > > > > +			return -EADDRNOTAVAIL;
> > > > > > +	} else {
> > > > > > +		eth_random_addr(macaddr_buf);
> > > > > >  	}
> > > > >
> > > > > Hmm so all devices start out with the same MAC until changed?
> > > > > And how is the change effected?
> > > > Post this patchset and post we have iproute2 vdpa in the tree,
> > > > will add the
> > > mac address as the input attribute during "vdpa dev add" command.
> > > > So that each different vdpa device can have user specified
> > > > (different) mac
> > > address.
> > >
> > > For now maybe just avoid VIRTIO_NET_F_MAC then for new devices
> then?
> >
> > That would require book keeping existing net vdpa_sim devices created to
> avoid setting VIRTIO_NET_F_MAC.
> > Such book keeping code will be short lived anyway.
> > Not sure if its worth it.
> > Until now only one device was created. So not sure two vdpa devices with
> same mac address will be a real issue.
> >
> > When we add mac address attribute in add command, at that point also
> remove the module parameter macaddr.
> 
> Will that be mandatory? I'm not to happy with a UAPI we intend to break
> straight away ...
No. Specifying mac address shouldn't be mandatory. UAPI wont' be broken.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
