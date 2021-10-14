Return-Path: <SRS0=Buhk=PC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC26C433EF
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 03:28:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1440F60184
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 03:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1440F60184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D92C0401C5;
	Thu, 14 Oct 2021 03:28:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4OHUGZgDFPnQ; Thu, 14 Oct 2021 03:28:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 41B6C40123;
	Thu, 14 Oct 2021 03:28:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC6BCC0023;
	Thu, 14 Oct 2021 03:28:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17F15C000D;
 Thu, 14 Oct 2021 03:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 053FD40535;
 Thu, 14 Oct 2021 03:28:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FUGCJOZtmKPt; Thu, 14 Oct 2021 03:28:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4CA9340456;
 Thu, 14 Oct 2021 03:28:00 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="225043127"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; d="scan'208";a="225043127"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2021 20:27:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; d="scan'208";a="626661228"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by fmsmga001.fm.intel.com with ESMTP; 13 Oct 2021 20:27:58 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 13 Oct 2021 20:27:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 13 Oct 2021 20:27:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 13 Oct 2021 20:27:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8/J3d3hCNWk25Gu/emsRQejFaxVhie3LURtrJm3Pk4jqgvBuJyeAzoBNSPeOgOLU62f3lRd+lwxrz5arYO2YWVZDaD1ftccBeZMaZwgkop/Ag4nTxKoPZOkc7fcEiZlhgfAWeA2U5jpalz0CEKm3DadDy8NPo5TUOtw/0KG1T7Cd0JO9epivpNkghoK59xWfJ7Ezx5VZb3Ervev9oMwqdZ5X/Fw93mB1rHhri03JuRug0OLY06M5bh/x12AvGrCwLcJdABQR1xf2azgmD5M2gYXCDTaIeCZZ4f4CI5F0HFF3OsOO8B6lWSmV3PkHqg9OJ5fIzXPdeH+wef+Z+R97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCapAWNzwOiSoDQI1LP96gsDiCP0Z3MkmSKyZIkOdYY=;
 b=HlrVanfCRSBuDOmSYoY9pEOVMtgvb7OreXOqBQujTTlSAdhvBbgKDrII31Zvj71Gnr8+ajXxC0ahEN90hsN+KvCzdVBMfy91EoLI+2Vdo1FgQYR9HjiZjZbuz2+mP1ToZYJlWrjh0YAYIqzOAhkSYzsiMcEPOeShYs5V0bUniS8FRW4VmQ15inD0kMjWLQXV3nt/pooLxInPiDiOBLitYFLZR2dae/TRqZ1cbmQBOq5RR/yfQ0Zboj/YC6UTq6jtU2BITRV95VnHefct7rXTmitrfFhj1l3VQRFVw9DKQSYJkiaaEsF75rDMBwFxAYaDR4XrCezUljbomkaltyd7AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCapAWNzwOiSoDQI1LP96gsDiCP0Z3MkmSKyZIkOdYY=;
 b=yhgquKWN45eiq338pnrCpeXiR+weHsv3ljXgTmjFYIpMndbrkDB0OzEu3VDfkb0IiDP7HOGFI51CBSLLIgcnL7z6GNsrvfZ8PdH4Ls1AF8aQYIIbR7Lp/Lnuma3qLL4HTcjDshXoPldpj4q9ZWPWvItg4CvVXlghLCIpZXjQ2C8=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN8PR11MB3601.namprd11.prod.outlook.com (2603:10b6:408:84::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 14 Oct
 2021 03:27:56 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4608.016; Thu, 14 Oct 2021
 03:27:56 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH 2/5] iommu/virtio: Support bypass domains
Thread-Topic: [PATCH 2/5] iommu/virtio: Support bypass domains
Thread-Index: AQHXwCxxolfOCB8Fpk2UjJm46zvieqvR0fcwgAAEVbA=
Date: Thu, 14 Oct 2021 03:27:56 +0000
Message-ID: <BN9PR11MB5433AFB7216A1BABC40201148CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20211013121052.518113-1-jean-philippe@linaro.org>
 <20211013121052.518113-3-jean-philippe@linaro.org> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4551aa15-6aeb-4bed-20ae-08d98ec29d6f
x-ms-traffictypediagnostic: BN8PR11MB3601:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR11MB3601D5ADA833CA8C6576C8838CB89@BN8PR11MB3601.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e/fGtFT+VHUCg78iAiHI1oFoPBvr9hIWqI6FaOpRdaAuRmzQ80Y43gJPYM0Td2N7gD1tWD7Glq6kPHOwHEkeVWuLiFvzQdaRClANHvnFnK6c5hdxLiCx5U1JI3KkKYnSzWNQIt7xiGOggCVTHQO9fxt9axRPCv0gwWnTkz3f+5GBMl2sbQlfas1RuCKH7L0kIt8MNpD0J8vq1yjouecS840/xnU3fMQMXGs7q1slh19GA+g5nFYnxU+/JlDMwxOWPeYI3k9YwOeQay3mGldzAb0YJ8Xq5ULWGnVzTF4/Fnl2cSICyl8zOMEJacuz/fiNpnmhg4QuB33FUKTflCXisViuvBo2MznM7ZyqzsMvsO9NbjpCwST7S4z6TzhJ2gQy/7CGAPmOT8MwHy8Wk1hZiHv3ws+DSaqqkvwvKC16QRmXeJNbBzg8w/Sn67URhVnuy+P6L/DHBjw5ndUlKGcuEVmKmGLO3M5EUsoyzSfYuTmSD8X3E0EjTOd+i5D08a3xCS29ND+uis9/AqS3F0gomwGo4QRDyHepMc1j9a1Uz/VKKcZSmHZQzmGHlZPT17WaDrxzJDp5U0JZyRPdkrXum3+7PKnKf8z5z4R6mEZJOAIu6Zm0Bzw2C4QyTz76UMFmgTfaQ/qhKN9pEphNmexQxSXerYMnCP+/p2OROZEPOfIQWYcKyfLE/AcbXuezIw2IjQoeVcsTcpQHm21ljmXnAw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(110136005)(5660300002)(8676002)(54906003)(83380400001)(6506007)(33656002)(508600001)(2906002)(7696005)(86362001)(316002)(71200400001)(8936002)(26005)(66946007)(38070700005)(64756008)(52536014)(66556008)(76116006)(66476007)(66446008)(38100700002)(122000001)(186003)(82960400001)(4326008)(55016002)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ANz9bHe7MLwncafOWWdHsZZEMbDYnGDICjIW76DDfG2Y740aCu8dpamffrLe?=
 =?us-ascii?Q?IJbCBfUx/LBZhf2Px3HQIgC9BaYQmBTGgN+DH1vTKZKO5TItrfoXuOpfXM5T?=
 =?us-ascii?Q?VQ4ranbIeAgsEHfYvOa/ZYN6FMZPEysDq4kHKJ+Q6g0JtySYIQji+t/2nANS?=
 =?us-ascii?Q?S5tbRgYc8Iqr022Qy9ytNrmH4sWhTU9ANQx2MBoQLvHTOm2xqijYcmzsEyg2?=
 =?us-ascii?Q?ezE1/PTiHcyjvgoSttB/cWQO18Q/yJjBxcHa2+ZEhbbRwvmcExDcLvbP4sgY?=
 =?us-ascii?Q?rjQ7Te2nHjS9tf08nr430Ns1g2WpCzNzZOOm1A2YnfsP5XvT5YbrZmEvptpv?=
 =?us-ascii?Q?8+WwPXdO/ksgwMgGNgkePyXRCPeUAstyzWdzgcQlmnjb7nL/HsF1H7JBC0Ky?=
 =?us-ascii?Q?kfqyf+Cy2NlfLjHooRQjT8OlJ0W3f3zi2UcWiOzefi87xtfPk7gV9o84dw8l?=
 =?us-ascii?Q?LIqv7/Ai+9ZrsvrCJquOOOnGyINq9Z+9Ag9rROMjKUFfrAH8mgsSngDsQ7iA?=
 =?us-ascii?Q?iXE4xAit2iljPfPIhlOBHTe8ubhgRmYt5meK7lHemdVL74KjuBckwMys1uUf?=
 =?us-ascii?Q?VmU7oRmFdzuac+6djAv+sJYJl1BTV6UQ8iHqqkOVRolNNGJnDZ3jAKXcm2ag?=
 =?us-ascii?Q?75X/bH++tbUI9C0Onkw0QqTZABipIl3KQrFgQCJnEwZsc0IyAaX5e+f2rPC+?=
 =?us-ascii?Q?eDuslX3QR9BSmNopFe6b3fapgYOCo5BW36mGzGlvSyYo+9bHI5/BdnBjCA0x?=
 =?us-ascii?Q?mSr1IZwm+xfuV+x8EYBF2CrmpWV+K/YDNxnkadHqROXrKF4C8RF67jmJMo00?=
 =?us-ascii?Q?UBia0H39CkRBFmcO2+vYaqU7wS+Td8dtWalqcJmyTTnfv0v9jepAM3mQ/onW?=
 =?us-ascii?Q?uQ3HncYYkhh57g5jV0z36wEMknJalN7qcAd+n4mwLZMywD6VYH4NO/fVjuYn?=
 =?us-ascii?Q?5lxCl2JL9mj6I73B4jD1GFLyYT94xI2yI3rG2iQU7Bf5qdHtN5zdtbkDCYM6?=
 =?us-ascii?Q?5QirBB7haVvwIIjOQPFSL2eHgkpKHjsyDyzUXXCGf3wOb5kOLZvqkjF9u1yZ?=
 =?us-ascii?Q?fDkKOFm2n5KKcvJoeCVBuUYWViduB0vhDsVI2MN+cKVB2kZl7W6WfMGOtQXm?=
 =?us-ascii?Q?5Rv7+KBAuCgS9UG+Me+S/PNEeaGhH5TLdM/gLvSaq57dibyLvyA7S2E+cv6+?=
 =?us-ascii?Q?mPDWQEPxj7BmuD4ZP43Ej5SWbW1E4noUML+7I58SI4t20TdEU5TWznGs7g7w?=
 =?us-ascii?Q?eCM71q0TG5wnviNoMWQ5jw3symNECY9QJHiGyTDezkglIdYbB51tnewsqzbY?=
 =?us-ascii?Q?9E83TBSulV367IlDEQ9Z9at/?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4551aa15-6aeb-4bed-20ae-08d98ec29d6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2021 03:27:56.4974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w1eq4QpvyHXeI7AG43mMQJ3dpdEr/qCYQYv1mrgeFQ6UbYJkeyBewwkz/CB/O9AxuMKKycE9wL2mi8g2z9LCMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3601
X-OriginatorOrg: intel.com
Cc: "mst@redhat.com" <mst@redhat.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "Boeuf,
 Sebastien" <sebastien.boeuf@intel.com>, "will@kernel.org" <will@kernel.org>
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

> From: Tian, Kevin
> Sent: Thursday, October 14, 2021 11:25 AM
> 
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Sent: Wednesday, October 13, 2021 8:11 PM
> >
> > The VIRTIO_IOMMU_F_BYPASS_CONFIG feature adds a new flag to the
> > ATTACH
> > request, that creates a bypass domain. Use it to enable identity
> > domains.
> >
> > When VIRTIO_IOMMU_F_BYPASS_CONFIG is not supported by the device,
> > we
> > currently fail attaching to an identity domain. Future patches will
> > instead create identity mappings in this case.
> >
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >  drivers/iommu/virtio-iommu.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > index 80930ce04a16..ee8a7afd667b 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -71,6 +71,7 @@ struct viommu_domain {
> >  	struct rb_root_cached		mappings;
> >
> >  	unsigned long			nr_endpoints;
> > +	bool				bypass;
> >  };
> >
> >  struct viommu_endpoint {
> > @@ -587,7 +588,9 @@ static struct iommu_domain
> > *viommu_domain_alloc(unsigned type)
> >  {
> >  	struct viommu_domain *vdomain;
> >
> > -	if (type != IOMMU_DOMAIN_UNMANAGED && type !=
> > IOMMU_DOMAIN_DMA)
> > +	if (type != IOMMU_DOMAIN_UNMANAGED &&
> > +	    type != IOMMU_DOMAIN_DMA &&
> > +	    type != IOMMU_DOMAIN_IDENTITY)
> >  		return NULL;
> >
> >  	vdomain = kzalloc(sizeof(*vdomain), GFP_KERNEL);
> > @@ -630,6 +633,17 @@ static int viommu_domain_finalise(struct
> > viommu_endpoint *vdev,
> >  	vdomain->map_flags	= viommu->map_flags;
> >  	vdomain->viommu		= viommu;
> >
> > +	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> > +		if (!virtio_has_feature(viommu->vdev,
> > +					VIRTIO_IOMMU_F_BYPASS_CONFIG))
> > {
> > +			ida_free(&viommu->domain_ids, vdomain->id);
> > +			vdomain->viommu = 0;
> > +			return -EOPNOTSUPP;
> > +		}
> > +
> > +		vdomain->bypass = true;
> > +	}
> > +
> 
> move to the start of the function, then no need for above cleanup.
> 

forgot it as I see the reason now when looking at patch05
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
