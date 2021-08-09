Return-Path: <SRS0=ROIW=NA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EEDC432BE
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 09:51:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A536101D
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 09:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 29A536101D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE04682A83;
	Mon,  9 Aug 2021 09:51:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QXE9tJsKlxB9; Mon,  9 Aug 2021 09:51:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7E3FA82A28;
	Mon,  9 Aug 2021 09:51:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62A2CC001A;
	Mon,  9 Aug 2021 09:51:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59448C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 09:51:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 43F32401E7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 09:51:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id negsPqRbR1Wo
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 09:51:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DBAD74014B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 09:51:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5bYYwqdcdS5In3R8eCFhP66Unf6AZrtPoh6APj8R4edGEg4jJQb7/8eify8frV0OPlB/DKPFivqVL88jCd0bzXMAhWX9iVpVBMb59IfLL1eqv2qrupN53wAhHJa1CPi/jEllLXkIjuIPU/pSrjrF88zVhIUfi+9BlWIt/2gsRUOSMwgT4BdRAfCH/rAQNiCUDvrdQaDyHLkLFEkvVO0rUaLwvoHaf6zK9/KCZMYdJfDJrODjHdZil3PZftJID6vE3alXLkT577s3dZAGzJzLtYvKwy+PlNVYSpeLPILeldsMdMm7JuAt1v20k0QEXiGhPC5aooWyh4RVfGL2MqztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BRauA6gEnNjDMyLl6yHTPq/G9tZxWYuY6KuTFCwNW4=;
 b=eiT8J/FTzmJhznKEN6TxWLC9O8CnIZA6kao1dY0212Sy69Hg8yIpXxYBLS7+m7c07h1ry0fR1LFPmcI5py2YmLcki8KpWm/jwDk25ofHpXvONnQ7vGl5n08HuSFseLeoh6JYFRrJFKuBpp9obOjz7sGCCF/AxNeyPO25UOWk7QRgdRcqK2TFEQbxrmrbtC4hI2kMWT1O+f9EpJHteLreUph4ADbBNe7k8E3PvJ1JiGRspCRC+LvUerkT0gx9RGd6CSIdPLD1buT4aNgNuDhgbUvqsy1TwrNWuxAFjzPajt1bxlwV2v06N3KJig8pdockQB7SEOUEHLNlM2D1JXToZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BRauA6gEnNjDMyLl6yHTPq/G9tZxWYuY6KuTFCwNW4=;
 b=KoFxwIK/5zeFAI/2DUtRjF5oHyG1zWjugDAfeJEU0305jTB8u8z312Q3IX5EwKRwwVpTV515nlVJxvKtgABbPAGu3n992H2wNHHVD7lA5wGyvsOnAhUgkFkOtVPHxy3wUhz3MaV8ZpSQUVElbWDxm9/o+YeU3ROwg0t+Nbm30+Tf7RWOrO0zlhwd1O2gh2t0FA8UyQiYEJQDGdufDgeWly6k5xW9yM/BpaKDD/7fTDRiLbWXyqQ3YTVF2h0HfuwK6/ZzyspqSRo0qKHvSLxAnlLdrK03hpzu+lBtbmkEdpliMTSZYOVxGK9TyGOQcE6f88utSOTBbBzFq5TOnRwqqA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Mon, 9 Aug
 2021 09:51:49 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::249d:884d:4c20:ed29]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::249d:884d:4c20:ed29%4]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 09:51:49 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Thread-Topic: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Thread-Index: AQHXYuOH3YVTcMY6VEeAGlknhW/FN6tk+uIAgAEa9oCAAGJZgIAAALAggATGdICAAADAkA==
Date: Mon, 9 Aug 2021 09:51:49 +0000
Message-ID: <PH0PR12MB5481CF2E07B38C45A2829B7BDCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210805055623-mutt-send-email-mst@kernel.org>
 <e3b31032-222a-e1bc-f452-a965b456f48b@redhat.com>
 <20210806034817-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812C49AAA468E1E6A871A9DCF39@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210809053624-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210809053624-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f5e89ef-9f3b-4194-cb85-08d95b1b4ec4
x-ms-traffictypediagnostic: PH0PR12MB5484:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB54845EF9EC5DAE69E06FA5B5DCF69@PH0PR12MB5484.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kwgr+ay04vNp0hV1VmYSnr04WHkXM0e2aRDOY26b6N2HL6H+XWaQfkO/tdUzOow3r/zUFLUKACFTtMW6E+cdt25VmvkiFuKlLhXgU2t01BcbJeNKykNTZHVV6t2XR1gON9+0IwVk3udPpBGeK8Bu8sybAU+uNoGSJV3tzIc2UMh5mttYDsrMUwswerAK1cr525NW530p3ztgBtZcCLCCyUl383y5uAAUEEbBSfNbbA/zQPHL+iQvnPx40Ti7en8lBCxhHAZIKmPH5c/xFJ7Gzr/jLHsw2p82pSDqnh9Cqw5WBu8nP43Hbhh5qBtJ0NBO/syNmaQN6vN50nFv0aTggfSqabw5Hq6JBERzuqLBGh6Pqf7l+lMIde1fAD+WdLhrgWbAblQOtVxrtV5xB30vFgdf4sXoSfqqeC32+zQOgeRP02VEq015ZC2v69XLgR4C+mGh79dXfbCBdFcd4HIqX2OKKabjgrb9ZyBq+ZykWEqHg/JjKcafOMT0icxZdyfRMn0jUlMvKztIGnMfeiOxR4mCLmsn8BxQspfmMg/9T7oPxt7G80jH467CFvPoleofRlI7EeRib5cHs3pURtUe8f7MyghdbmULdtjo/MUkEiaF7PdzvPL9e6j+LqDtK6SoUI2g0u2sc2QbgqCvPesgEFM78gBHADavEBUZ1Wtcv1nJqqb53Iph1xbXRh8o43UTqM6ef90Y4qB1pkJQvKMaoA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(38100700002)(55236004)(38070700005)(122000001)(83380400001)(4326008)(8936002)(9686003)(107886003)(86362001)(6916009)(6506007)(54906003)(316002)(66946007)(33656002)(66476007)(66556008)(64756008)(66446008)(478600001)(52536014)(8676002)(55016002)(7696005)(76116006)(2906002)(71200400001)(26005)(5660300002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VoOYrkBO7cj31CulhRyqLCcZrzfoYbTs+Ml2xhzKUc8zWzQzfk4WEHv0F7qt?=
 =?us-ascii?Q?dFfqHrtCat7B0Kfa1pvYVLWWymYcvIoszkfYp31l7NR+bCknYHYrtJj+08ka?=
 =?us-ascii?Q?zKzjjpTB3trweEhvSXDWXGDpK4HDE8rj8YUD5Xw5ul3cPeN755lGaZqzlODq?=
 =?us-ascii?Q?e3fGdpa1nPIL+H8PLfLugP6CgSV1O+mmJ/HJPkqJtHQ1yu+MRhWm5p8/4ijE?=
 =?us-ascii?Q?XjjSF6HJZDHo3dHz4zGvxF9iEUED2mVSqUHL+jMSd52EZmkIY3J05qKduP3S?=
 =?us-ascii?Q?6RQ5j9s8e7JnGGyn4iSGPZ42YYp6GSEDJt/Fxi10wmzvfUhrWoTiMWZXi5Yn?=
 =?us-ascii?Q?8OVVW29YpYGkP3+65BHUFPjz8c8ShHjxUMR+s5IShUE3fEOR264ieJOcwBBN?=
 =?us-ascii?Q?CT0CcW8u2m7plQ+7qyNV0G7wiKNzme4EfQAe9LlLzC+sjx4HVpBQWkTeVcgR?=
 =?us-ascii?Q?RKiccbYWtCDC4Tczn1NRibV62ACZKVWXdm6RY1+L6hTCOMN3FK6KVgdkV76s?=
 =?us-ascii?Q?hXiez9GdbL2v8+RnU4ADDjNCtHDR1yIZWVaNcpGbgmC1txM3q3zxADC4MMHy?=
 =?us-ascii?Q?69PvCSegbSTHDaUptCrNCgB648wCSGx7f9nZ+/SXyEeKLrKwrBcMWM6GfqMS?=
 =?us-ascii?Q?D6G/m0t6gOFBryCJfgrXhYYioYVsBiXMyDdDZZu+1tmyHkDj+sUhjkvwZnRn?=
 =?us-ascii?Q?k1rzoQoz/sKZpkPjDqNdtfScKlVbUdHwtPrswAClzF/26bRS89Fxavzc5uDe?=
 =?us-ascii?Q?puSOpr13zx5huv0KuLMPoYCZoJ00efcMo0SxFER/un6YFZ0lPmGMhGQ3t/mx?=
 =?us-ascii?Q?nmrjFu/EV1HSQNW0kEJ8XuaKjuYoixKEE6oC9XpUVG0ir3qCWAaKdsEj1gh/?=
 =?us-ascii?Q?XoBIWE9DT09I0Vdc9cz2yz3GiPClwAGGftE8RugzAQC9ViacsE6YNNOlurtJ?=
 =?us-ascii?Q?jP+gfv8C+YOl/Op4g6NUD02m6ZS4HLEK5Zg9nmwUpC42+2tj/H++5nymolnB?=
 =?us-ascii?Q?i0pOB6osO511HB5dhx0RvfFXdbGQMdwovyx6QXOwtNJacHiqxkUhyqOAllSM?=
 =?us-ascii?Q?QyzK1mGoSGcDjvoxUYaDyB+dgxKCifqlsDgjAPEEDj6wEi9zjMyleEytRqOR?=
 =?us-ascii?Q?yV+ciLox2NnNUqAH5BJuLorP42eRb2rpMwZYYRolBucHDuEXEsorxnXBn3lW?=
 =?us-ascii?Q?kXSVnLt98I3/MAQnwhVEBczucg8y2mpmFClUYmc0rBWciyLSUXmsdsV3nAvT?=
 =?us-ascii?Q?R0VlP/HyOJgXxaG2gRc8K67AQoBTIimRILOW0tNehKD7eaMjeWJHokfL5fuI?=
 =?us-ascii?Q?AzyxAEADBQAx1hv2dM6OJMrL?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5e89ef-9f3b-4194-cb85-08d95b1b4ec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 09:51:49.2524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0GpEXjTvr+yhwY4MMIF8YAfjyKn1zNDV4adD95xQeNCeUaS3U+vx/3E+Zmle7XLJhrRHxiM/k1on903F5rZzNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484
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
> Sent: Monday, August 9, 2021 3:10 PM
> 
> On Fri, Aug 06, 2021 at 08:55:56AM +0000, Parav Pandit wrote:
> >
> >
> > >
> > > The point is to try and not reinvent a dedicated vpda interface
> > > where a generic one exits.
> > > E.g. for phy things such as mac speed etc, I think most people are
> > > using ethtool things right?
> >
> > As you know vdpa is the backend device for the front-end netdevice
> accessed by the ethtool.
> > vdpa management tool here is composing the vdpa device.
> >
> > For example creator (hypervisor) of the vdpa devices knows that a
> > guest VM is given 4 vcpus, So hypervisor creates a vdpa devices with
> > config space layout as, max_virtqueue_pairs = 4.
> > And the MAC address chosen by hypervisor in mac[6].
> >
> > Guest VM ethtool can still chose to use less number of channels.
> >
> > Typically,
> > ethtool is for guest VM.
> > vdpa device is in hypevisor.
> >
> > How can hypervisor compose a vdpa device without any tool?
> > How can it tell ethtool, what is supported and what are the defaults?
> >
> > I must be misunderstanding your comment about ethtool.
> > Can you please explain?
> 
> 
> I am basically saying that we probably want to be able to change MAC of a
> VDPA device on the host without desroying and recreating the device as long
> as it's not in use.
Ok. I understood your comment now.
Yes, this was the objective which is why they are present as independent config knob.
Jason was suggesting to have them as creation only knobs, which requires recreate.

I don't have strong opinion for either method.

Passing them at creation time is simpler for user.
If user needs the ability to modify and reuse same device with different config, extending such support in future like this patch should possible.

So there are two questions to close.
1. Can we start with config params at vdpa device creation time?

2. Is it ok to have these config params as individual fields at netlink U->K UAPI level?
This is the method proposed in this patch series.
(Similar to incrementally growing vxlan ip link command).

Or 
They should be packed in a structure between U-> K and deal with typecasting based on size and more?
(Jason's input).
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
