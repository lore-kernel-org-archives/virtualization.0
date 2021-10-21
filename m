Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D77C433FE
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 06:42:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B1160F57
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 06:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 96B1160F57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4978560D6C;
	Thu, 21 Oct 2021 06:42:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pnKqrgIWP2QJ; Thu, 21 Oct 2021 06:42:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F173B606BF;
	Thu, 21 Oct 2021 06:42:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6EE5C0011;
	Thu, 21 Oct 2021 06:42:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E852AC000D;
 Thu, 21 Oct 2021 06:42:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF06B405B9;
 Thu, 21 Oct 2021 06:42:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WZ6uAUEdmjOH; Thu, 21 Oct 2021 06:42:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E7358405AC;
 Thu, 21 Oct 2021 06:42:47 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="289801851"
X-IronPort-AV: E=Sophos;i="5.87,169,1631602800"; d="scan'208";a="289801851"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2021 23:42:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,169,1631602800"; d="scan'208";a="594976784"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga004.jf.intel.com with ESMTP; 20 Oct 2021 23:42:46 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 20 Oct 2021 23:42:46 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 20 Oct 2021 23:42:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 20 Oct 2021 23:42:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 20 Oct 2021 23:42:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxSUH2B/z0JJp5uf+O/8z9bsDP3a/ngnoevjVXG/FxnRjY0gqdjCGhRGpsLN48Eu8vg3I8ll2Q7X2k0qN2eo7OxXjnFU4WjY6hPixwFdNnQyeU0y7BdV2mxwc52uSTzKhpHozYzkLTk1varwrMByS5fMdplketVRW2wWvY6R2KA8hfudW1T6Ui2cbUK72kwB5faeEafKpxFa1xkxcK1+5osuJoDHiReg5PeoMO+3bHcE1SzHESrIxrFV6iEajM2R/Q5ql+tf2Ea+bIgrfK2tiRSvZ4rI/pyFmPem7o8JZiONkpV+Cj9No1q5XjOIDkmoWXvVIQx45eLgmIBay2aegQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6fsSshwTIrTjCGGq7u6/Xmb8H+5NSLmhGW1mrMK49w=;
 b=lEPDTW6tcXW2rM7lLgfMSo6VtRyYoLOZKi2wXhx+wmEpKgFN33wb5ee3ucqU+qouplzZKOU650ny/Zufm98wuZ0yD03SlTM0ReE0zjiex/D0uXOybCBaRyexrc2CTrD2NXBrMn46Xl3CS0IDfGmbnp+QWT8qC3q7DnNUK/kYxjp5+LicoHsX97ZrFFbfMyxiKgiLph/3IUuYVWUAx6QFIaYJ7zr98r9+FfN5RVaebsh24OBq1IjVz2R2gsBImno0wIVJp5YNU/I/10NhzPRbf/VmNWPAk4O6Ir5rc3UQTUXwlsd4xtgu9j5EPj7+GQJdn7BAL6Rqk3uYs4EzTwvSmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6fsSshwTIrTjCGGq7u6/Xmb8H+5NSLmhGW1mrMK49w=;
 b=xYRa1JjR0WCfcjHtrfKqI7oW4B1IniNw2+vkkMkuy7Db0N+GKCqoijCesH52hVKbQl8UOTBeZB3t3uihBKht6DwWOzDxbCRbLrEyeobcvX759Y44iK8DPKLckovC94jojfPmxqmHtdlZLbN/YLd+k283uAWYidJY6uqnDC5ucHE=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB1267.namprd11.prod.outlook.com (2603:10b6:404:3d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 06:42:42 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 06:42:42 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH 0/5] iommu/virtio: Add identity domains
Thread-Topic: [PATCH 0/5] iommu/virtio: Add identity domains
Thread-Index: AQHXwCxydUd3K77AsE6UB+M/DEvsiavRyYfAgAbfT4CABGO1sA==
Date: Thu, 21 Oct 2021 06:42:42 +0000
Message-ID: <BN9PR11MB5433A3A9230CE2C196D025268CBF9@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20211013121052.518113-1-jean-philippe@linaro.org>
 <BN9PR11MB5433EFF47E5FABC1D7D95F6F8CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YW1ckwyJAwiKIFaQ@8bytes.org>
In-Reply-To: <YW1ckwyJAwiKIFaQ@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32bafdc2-fd04-48ca-8c95-08d9945dfbca
x-ms-traffictypediagnostic: BN6PR11MB1267:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB12674745CE4B48A4C087B8468CBF9@BN6PR11MB1267.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +lWk/M6pnzas3akGgo4VKcOqvk/N9TI+hci1dX7yuSZYgPol80M82KMpKtEauVUf9osb9AwGns/iTvET6lsu0wNIkod4QcJif+QZDGV/wC57vbW/RQKQIYw5QA6J0arRiAEkoPxFRU4N6H5TxYJt4vqnLRejM9FNk48dDLKRcShf5Km1D5EyvigpqYbI2bDGmmjjnTwOxWiDIYadeXsZChM0M+O+dl15/KW61DCU3Due4iSSoU4m5nCADxrVKpB5NQwkhGj27S0FyjpJOed25g0SS3YbEulhdT/y4POIvpqLgGBQ+iFY71mw6E75KI+WCuyFxyaY/2KegoQNK56gMLPZaRpNSQoF4GbPSWpUFBV1EufEuaP6hegEx6ly6dg4c0WQd3to8tVu5b+MPUvyJPbtM2697kl3yDL6vVDGqDpFGfqqvDpR5NvnSPybi4HjzpA3gf8ftyGunypPWpt4JvfWUTs3JCXQzWcS2ayBbzOM4KYE9vRYSr8URVVNeqls8hPPqdHv8DluZxYFYYJ+bbfI28QnIJAKUztyqhG4Yk97ijYLHUBHfz1t2SlLbzOBJJf3xpmzTQ4Z0ox8BiFgl8no754VxG0ooRkfFYrz1V4Eigv5od/B+zNImgCTxAQGP6kYZDjvL1i4i0l9AbxfxHCH1Wn3LCmdiXZoFJf1bbsTqaIvNQ9+kCNUcHMXvan1a+cTF2vaLUu5qyqJmhd5Dg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(2906002)(7696005)(122000001)(5660300002)(8936002)(4326008)(54906003)(71200400001)(6916009)(8676002)(52536014)(316002)(76116006)(38100700002)(82960400001)(55016002)(4744005)(9686003)(33656002)(6506007)(66946007)(66556008)(38070700005)(66446008)(64756008)(26005)(83380400001)(186003)(66476007)(508600001)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6lXbA8mQbLhk3Qijjui4M3CREd1KAbEhBCsIhqoe1t8/Ph/FOp3knqV+qvaB?=
 =?us-ascii?Q?cTIAVEydN3D+G16YcM8EUohsdiCNWIlE9DcNT1muzerWha8OkZeQ1WS1xBUB?=
 =?us-ascii?Q?b4TSr9LnSWhzkFlMycRDuiTUd+P6TKSoMFJ3bKHVcv8TWjkNznPmtmpcwup7?=
 =?us-ascii?Q?jh145QSqZ5oK4gPF6wZJ5/azp33Ce8n1+YvaN51P0tlRoJCKBhSPAeos789P?=
 =?us-ascii?Q?vlXURLUEurp6POhVgjkp4KYE6iGj/Ezf/J2Zsf5xmnjLbCC+MshcBKnqcWY5?=
 =?us-ascii?Q?F9Kzj4PGisq8iKT5p6WNrw3I/+gFN5gg+nFLS5YrFfsPAZVgaOvZE/LBe1Eh?=
 =?us-ascii?Q?sdJweTPbYdSxxsILM54TJNso8hoCFBenPJ9llnREBARc5npFDxjgEMQNb+6t?=
 =?us-ascii?Q?mfcV85WKDrg5WEMaOudp2Uun0ttke8+g7UYIXo2m0GQFPzJx44jMSU5ALmxA?=
 =?us-ascii?Q?habvKgY5JKqr7XdpEYOoMf+1G/JocGG8vlgV05phZ+XNRU8wa6ZDHAkU4uNC?=
 =?us-ascii?Q?lVLnPqYEQnC1L6m3LBthmjEIbSejVIXOCrlpioeQJNErooM5lw3MXiIF6c37?=
 =?us-ascii?Q?iGZWQMgi79zZb/3gQR72ce9WfdoAh3VhlC9oF+Y3e2FZrULrYFCCDyh+sQn8?=
 =?us-ascii?Q?CLht2na/PIQ0R0LSqaeFtIS5pogngS20ClDmW5cdMnMa3ylCn9umPgWFjZaX?=
 =?us-ascii?Q?WqTgU9RRsjD+Ex+05pKuRCfEgMc7khRLFTe+rdhUm6IfZ094DB97y8HWQ5s0?=
 =?us-ascii?Q?pThE8+QcW5MZI/tt2JQQ0CHHg7+uEaut3vvH5inbhZCQrIJkTtHoW/vp/c/R?=
 =?us-ascii?Q?9TQN37Huyq1xrRh3sGYFnq+GdQQCic05LcgpZDCn0cEo4NiHn7+T1cxgC4wd?=
 =?us-ascii?Q?Q0otWFmpQQIhDUamXdLXmcsGZhFmRvI9BxpxEYOuYoUH0lCE7VHVZlGD3aaj?=
 =?us-ascii?Q?aBChEPZKnAOmIqznbAXB0Itav10lol5lz7HUxKhRxC02a6WjuJwYkxIpnZPZ?=
 =?us-ascii?Q?/ZFtUQ/E4PusuSqnHewEbquRtIOIrjszHWEAVcdczn7nLGSRZf5qtGpQX+T3?=
 =?us-ascii?Q?0BoRUMXcTtscwYfRX3vDeWGfjySb7HPMszvCs0yDIVkAo8dbrvZL1S+Bq4tQ?=
 =?us-ascii?Q?Y+R1U0je4b2oSkGKO8xwzUYysgrYRvJY0g2I31mpwah0wVT3Zwzq+TjJX1Gu?=
 =?us-ascii?Q?OTLmcfatLHdhZHLFCRcKG2LdiwG2YAFmIbe/XY77usA9OYBiDcWLPzvR4HEp?=
 =?us-ascii?Q?1aZAs0XGLsmwjG+YwM9+JSJqce0DNnh8f2BP3EX0yGBRXt3/o8e6JluNQ32N?=
 =?us-ascii?Q?Jli9vLiZtH4GG7AIjkebC/10?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bafdc2-fd04-48ca-8c95-08d9945dfbca
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 06:42:42.5695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kevin.tian@intel.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1267
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Boeuf,
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

> From: joro@8bytes.org <joro@8bytes.org>
> Sent: Monday, October 18, 2021 7:38 PM
> 
> On Thu, Oct 14, 2021 at 03:00:38AM +0000, Tian, Kevin wrote:
> > I saw a concept of deferred attach in iommu core. See iommu_is_
> > attach_deferred(). Currently this is vendor specific and I haven't
> > looked into the exact reason why some vendor sets it now. Just
> > be curious whether the same reason might be applied to virtio-iommu.
> 
> The reason for attach_deferred is kdump support, where the IOMMU driver
> needs to keep the mappings from the old kernel until the device driver
> of the new kernel takes over.
> 

ok. Then there is no problem with the original statement:

    All endpoints managed by the IOMMU should be attached to a 
    domain, so global bypass isn't in use after endpoints are probed.

Thanks
Kevin
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
