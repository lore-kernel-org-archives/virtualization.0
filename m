Return-Path: <SRS0=C5bb=M4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A1EC43214
	for <virtualization@archiver.kernel.org>; Thu,  5 Aug 2021 10:13:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA0F61132
	for <virtualization@archiver.kernel.org>; Thu,  5 Aug 2021 10:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1EA0F61132
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D5B7640277;
	Thu,  5 Aug 2021 10:13:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V34fpWeQhqYz; Thu,  5 Aug 2021 10:13:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 25D8F40330;
	Thu,  5 Aug 2021 10:13:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F090BC001A;
	Thu,  5 Aug 2021 10:13:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CDC9C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 10:13:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E8C160A59
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 10:13:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qaT0PAE6I1Xs
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 10:13:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4394060A3B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 10:13:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fgy98t1+05G5abQrZRQlJs4NY7ZvCf9I6vldmKYI2TS4wnJeYpdBNiuZyor0BWKq3On05jd8TyTcnLQjpxoyIBXCbqaLwrbjRFoPypwRBh/GqY0aKn4Mnf+hV28vX8hylMFs3oo8r92+8CY65LVXregx+pdZucHopncRoOmhGvG+p2qX/o6pxa6r439LmSYfKIdbZmob6PjKwh26OQhW2nW9CNNUl9eGde8pyoag5ETHVz17iY3sKuMTADpT2GC4cV5ikfjGU1spOL/bOXS6eRbLheKQ9rzJtBAatkfnamYs71wjw3pPvTIsW4wnD/ZIZtkBBybEKh6Bd1AorQHwxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nm1OAl5xijaO4DrRcFZY1NcZYbr4X62+rJmLWoRkGbE=;
 b=N/3KMnSyzbbiuNBj5FQ2zvyaBiRsbTEDtvV1zwtvET2t7/qb7FROVOCnWHt4f6TvaKCFONEUk7t2V/U9gkQ4r1UV9z2ybk+9H68TMGaREI8Il8Yem1ouJ8uX8Guf+fMPVONrTK+fEzr1vgGpkF95LgIYpoBobINOdprLxg7j1esNzE+PAXuQmIyVkEXFLy0PoninSzLHFkBS40UiD3MXqUwk0e2cR1O+XelDa/Bt6FEfSjl5E/GrvXz5iM9tzgCyJYcp7qcpN3pm4BwUXtBF2Yq6QKj6YIOUu8qdGWNGE574RDr+ODjnViqYcz0QzpKnqtbctmbpEiO3vqfgIKGPUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nm1OAl5xijaO4DrRcFZY1NcZYbr4X62+rJmLWoRkGbE=;
 b=f3jvcWoASaNi1TvLykJmHEA65jYNtnv2+c1ahAVsiauca21kCZ+ns5XnzP8cE8UOs7eeA95c1wV5jVFmCNC+WIF5BpLlTvBB93VeSHu60A4g+NtMgDV3x0QOf0rzdQWfrXI+JMVN2j+xZIe9NZL2/fdE9LLtPCVQReXUjO0rqO3OM1KMMUQzKyDKHdTW8qjiajCy0kLNRQFAnlh9fD+rlaVwxg9Ng3CmOBOhlMgrpt/8n76yngyqlIaLW7nDyanT3YAhGWMf97Xb/Pt81sRhpfQjlFDY8HOBvVNG4jicpOGU/2XQDMRvs5tfOvIJseSBIzOurbx5Ak+xd9lZsiYuQQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Thu, 5 Aug
 2021 10:13:11 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ace1:9322:ab32:7293]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ace1:9322:ab32:7293%3]) with mapi id 15.20.4373.026; Thu, 5 Aug 2021
 10:13:11 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Thread-Topic: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Thread-Index: AQHXYuOH3YVTcMY6VEeAGlknhW/FN6tk+uIAgAAD/rA=
Date: Thu, 5 Aug 2021 10:13:11 +0000
Message-ID: <PH0PR12MB548144534E9F3324D64CADCEDCF29@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210805055623-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210805055623-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fecd3ff-72b9-4cfb-7e35-08d957f9a17a
x-ms-traffictypediagnostic: PH0PR12MB5481:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5481F93BA3E3C9544A3D89D1DCF29@PH0PR12MB5481.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KCMtzZB1A7a0gBCsmQrBCC+sq/uuhc6ARdLnuAw8VpKUGp2iWHP5zTKWOE4wx6ZDSTRhu3HXCzHMhXxQpLHq69zqqpSZwsISuUFmeAapJDbWPfqke35Vgv3egkRRsh435oZMuM6ELiEGScU3v1VbJtIgZCGQPzAkjcvjzw6GU1z33NjL5Nj9WIZTslsUuSigfShRpN3GSJ2HeS5C0q19pmFr/WSP72cqZgQ8rWyEK6J0rz+SqmawgsfHfs92AjA+Ds1lPEMPa2q0KARNZBYDIi3+zPgGAmeTvb8GjEhjJRCZzz6qkKIOBBX0z+6mYzCDF+XvPr12jSxmGSSk94oEkt+R+R3pUaljPr18Pm0QtbWwH0d0CNPZ3+QdHcHHpnXApXYnoZID00oxW+nLGthw3tOFBX4E1SIzBXraf7lAWBLq6OH6gunJk5zN+oiAAHtzoCAbl7cWe37DKeYVsPXb59/cK0/RgkVVYh7e9FQ3ddJrAEIoaJwdYVykKKEsxZ58fn2WGoTBGLgD9iw5vbXgX2WMdOJ5Jtx4gxohjwK/vKP9Pngu5qcYgl7Nf3sXvOKjLhJh4fjy+jqjuM8HKjElJxB4AzLQx4aY3olfLrDqA0f9ethfKs/lbQ9wj0HHmHN2Q5G7TUF/dYmRysrNVOB1qwJqP5HDs+Q8/3mNedcAMdPi5i/SxF6X3klssCwW69OJxNAw35m34BZOqYJPXsU9og==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(86362001)(66476007)(38070700005)(186003)(66946007)(8676002)(76116006)(66446008)(66556008)(64756008)(52536014)(33656002)(8936002)(316002)(4744005)(6916009)(7696005)(4326008)(71200400001)(2906002)(107886003)(9686003)(122000001)(55016002)(38100700002)(54906003)(6506007)(26005)(5660300002)(478600001)(55236004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eC/UvFeKch1QoGYlCXB0Orgou4UCUWvgGCSftS3hF3+HtecwXG2iyUZAiH9x?=
 =?us-ascii?Q?tnsgvbpFCkArl2/fW+tgFEJGr/37dAIew0R/dbnq2C60iBq5Kt4VX6M9ldsi?=
 =?us-ascii?Q?u+gNPAJsIfvqLcdOqk3mWYZ3UxAcCCagOwMA00gZfA9OdbqADh+4nZ34pH3k?=
 =?us-ascii?Q?CPScHrOtNgpk+pvh6H8Jl4wg6Pe1oiGzjVWoGSHYNVEEHxfd8i6/NhG44zse?=
 =?us-ascii?Q?pcMKASIMffQoRC4GsCWDeqpUw2cWjbkdD02cRcWx1xO68I3php5b18VWGu0w?=
 =?us-ascii?Q?SU9Mz/jsvZl90VrCQJTgXx0a1inYo5vSxpkODtm1zuSY+Mh2Ub9Ewa+l+fub?=
 =?us-ascii?Q?rPOI2lRTx1KsrCAaZeVo/FME3SA3ynnvQDTT4bnjVuOsz2qXJnnOtktpI5oy?=
 =?us-ascii?Q?ydk528SO6vr6w9xLtepPmoyzgp6Hc2GIXsBbgcUC/Hh1G/mk3/rtBJuJ8kWJ?=
 =?us-ascii?Q?2FnANnIU+WnnLXLyu9Qo0mGiTCQ1oy9BCoRuP0ochbDivb409weqHugc3aYg?=
 =?us-ascii?Q?SFV19ZcS/aYxQMNv0SUn73HdiVgwHv4zNnjUfPn6cU3uwz+NYCLF6fZ/j9B+?=
 =?us-ascii?Q?J2VDcV9Hh1JK/M4s0nLlCy5fEBAZWoGDWZKo+sERby9/OMIqtwQggJzefYyo?=
 =?us-ascii?Q?OF/wHbizgnu3nMr/GXMf9dZ6nwDdOm3Lx6jA+noYr3X6kTKnBMvbTRluwEAb?=
 =?us-ascii?Q?1qm9VgEqYy8El44oV3hKjRXBjIf1F3pcu6bELRCdsSjKtVq6ueYz7BOPFrHq?=
 =?us-ascii?Q?CiNmOUr82NRPnnc58zcGHhYLJAFGw5ryACZBM39who7b2g/xTo2d+qjvsiTr?=
 =?us-ascii?Q?MktqOGiD8eo4a1exAQr2+QFu097dguP9KTKJ1SGUx+yx2d2jHE0J6jJXbRIl?=
 =?us-ascii?Q?rmYbiaG1/Md/FdzKCKW6JJ/5QyYsyCgrdmpYmmfT/tqt5SB7uIecuiC8oSKt?=
 =?us-ascii?Q?dlKl+yapLCF7IKAo8bgjonM/+XQ0TDbo/SYYWss0BGdMsshwfvZa3PeQpLm5?=
 =?us-ascii?Q?F8CSWXDK00Xse9JXjOhkHwXbDr87KC4iOYi971RbT3yAQafN0EwdZzytjEfT?=
 =?us-ascii?Q?F/gXeur+CDngswf5cj8tX3ETNkQlvdqfalw+55m7qDoJRX2tByecvjiHbS4S?=
 =?us-ascii?Q?xVYODCdmanbG1ZJe/urF+XGl2Qx3RXKOUcU46KV5rbfbIQ5Hr3SxwonJHZlo?=
 =?us-ascii?Q?fyBELkdFRPrqvBB+of5/BbSBB60dS0L1xpN0ktvo7m6WDjGcmagwXgETn21u?=
 =?us-ascii?Q?eXZvkNFAHjcHTZZtW2poqn+VTKvRpywW02aBP/EVt29i2HaJ65+WKg0kCFOa?=
 =?us-ascii?Q?hNM05Knpxk411SVGOQG0tvXv?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fecd3ff-72b9-4cfb-7e35-08d957f9a17a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2021 10:13:11.5436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hs6F0AD74gErOmIIcSfkeD1VEyx3bdVHOwUvZl9Yd4jAZombCZ8ukYpSHbmCpB2eqwP4cz+IvaK6kne75OiwgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5481
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
> Sent: Thursday, August 5, 2021 3:28 PM
> 
> On Wed, Jun 16, 2021 at 10:11:49PM +0300, Parav Pandit wrote:
> > Currently user cannot set the mac address and mtu of the vdpa device.
> > This patchset enables users to set the mac address and mtu of the vdpa
> > device once the device is created.
> > If a vendor driver supports such configuration user can set it
> > otherwise user gets unsupported error.
> 
> This makes sense to me overall. People are used to use netlink to set these
> parameters, and virtio does not necessarily have a way to set all device
> parameters - they can be RO in the config space.

Yes. this series enables it to RO when driver doesn't support setting it.
When driver supports it, it is RW.

Do I need to rebase + resend?
Please let me know.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
