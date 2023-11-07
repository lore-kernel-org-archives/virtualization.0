Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE6FC4332F
	for <virtualization@archiver.kernel.org>; Tue,  7 Nov 2023 08:42:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CA7E61391;
	Tue,  7 Nov 2023 08:42:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4CA7E61391
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rb1G936M
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rj6in4tev-Fi; Tue,  7 Nov 2023 08:42:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9169B61385;
	Tue,  7 Nov 2023 08:42:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9169B61385
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 757A4C0071;
	Tue,  7 Nov 2023 08:42:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2A88C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 08:42:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CC36641B79
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 08:42:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC36641B79
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Rb1G936M
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SGVkYoHv2_Hw
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 08:42:30 +0000 (UTC)
X-Greylist: delayed 428 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 07 Nov 2023 08:42:30 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 09CFF4206C
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 09CFF4206C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 08:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699346550; x=1730882550;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9RPOqD6bUd9PqgplKMEPcmh7JS+OPU3p6nj6C9GruAw=;
 b=Rb1G936M8LTK28Gyn279bOi09edmocLwVV2Pg6R7h4gaqv4urAAuDX7M
 ru6lCyVX8hwzEXeg0nZ+TvthFfuzZE0YZEYNevEfBRp8Zli2niIedjZqv
 jGM5A3WzvMsChY9zgZ1L1nxTZ9dbyF0SIDMy0+pXS5/qvNLYfQ1qwAzrh
 23lA7lGeejOP7mXCJYjAbYgsvcbAtoUGGEptrKewO7mhTCHo33PbBcAgN
 +tkBvuV6eQA0OyFgHmJIYVNDa6ujRjFr1pUJGTioOzW7RXTxV+7PrYGz0
 9jI4cuozp256hqXpg+kXeHV52nIYwcZhJaEv3Q+41qRC6Tl9a0SASMnBS w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="2389289"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="2389289"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2023 00:35:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="1009810001"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; d="scan'208";a="1009810001"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Nov 2023 00:35:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 00:35:20 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 7 Nov 2023 00:35:20 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 7 Nov 2023 00:35:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FowRPCFV5hJdPQT4PciJOUXwdX7qh3Rb/BK5D+6e2Azu7Hw21WpWpy/HlhY2GBXVKlXYef+0T6GkFNiBLSUNqAFTS2WsJyTici0BgHHSWfkdYdilIWNW7ZiJtLJD+7KHlVc/90aYjbVE9DAaol6SUiylH+4EoATBpaidUwi61tTHgge+ActcsISozbg9gC51Ttmf82tO1dmQTmLn90tPiZ2N9qdMdZWVUjHrV9gjhZCtyOQkjr+UMKNmbJNG6FWAzE/BA8B0qJlJBSw2PAU3EViV+w9fINNQW4CwxWvkIxMP4lCnrA5WzWDXtB4XQD54bFFwdl5VHsfZdjIrvJ8giQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RPOqD6bUd9PqgplKMEPcmh7JS+OPU3p6nj6C9GruAw=;
 b=Ulcb8YKtg19eao5sGCkCdoAq62rr3whdf9Tiag0x7wTE5PXyi64hqvsslztBMvw4ac1FyrCZxpCOW+P62ysd9IZtp9ZljhVhkldMc0/L4Qkkb3CKXw8SGEecT4EpSiM60MoMuMPkxvTNx5WZVabjjScQpxtjJ2dF6IYNlZhlCn2QJQdMx/drKUNcKSzMUHfjbagm8otvIAaKFeTuryNG0QY3+91YP++ULjBnn3FBXURrYvuvQu7YWid6T5Nm1BLI1oirN4BRKCL6QBz3Lb2DxUkOdqQoxLP/kdUGEPkai5A0TpiR3lq67sfLsrjJHOXhnPxv4/x2co/2x3hRUStcQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5460.namprd11.prod.outlook.com (2603:10b6:610:d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 08:35:10 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 08:35:10 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Lu Baolu <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Thread-Topic: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Thread-Index: AQHaB7ekIyYD98ruGE6A75OvyWpVCrBnBhoAgAeTvxA=
Date: Tue, 7 Nov 2023 08:35:10 +0000
Message-ID: <BN9PR11MB5276B1582CED568795725C198CA9A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231102124742.GA4634@ziepe.ca>
In-Reply-To: <20231102124742.GA4634@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5460:EE_
x-ms-office365-filtering-correlation-id: c9b46b12-bd66-49f3-6f43-08dbdf6c749d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cS94xQ5HG9rW2kdWo5jGbwdk6gc3+OHTA9a5abs1zyAynjvISS6JQXvX5lLb35eumwoCNZZszPl6/JDBbXmRPunx46CYZJlE0thyFEGarnclroTeQFlIxCsnV5U1x7QXVL4BRwqUPHPrrns2vDbP2bz5oKEeVwG59Brhd00kzNeCA2+RdyPfyZUC/ixHy85QUXxMZo932+Zd34N7fzGDYrNb0nKCFkziMhafmmo7vVYFJzFs71UQD71GQSmFe8f9eEF810A6nI1xssJ+UfPHMr02JyE37Ebtvl688CGT0OLEOz7OPfRmxHE1HpUtOzkjtoil73uKFaYdjngMDaeEHMguWkItuGqKr6ruMDH3QSEcc3H/KEm+avMpkD0kMbuJfuRLqSjhCMDadcCbEx3K8+F4CsIXYCPAbPeBNsQyRVNvXlni+GT6L1DtunpSonmcPYw+gPRXIZLWs8lI7opDEwrfKdGrP3ql1QxORrEFtu1FEQXZXxCycccKByMJ96x4Dy8gtJoEvVPVfz0ykuNqwbvE+UvEyynC6LUmILjhLfxoYdyvRR3Zq1RZGtcDDvlhDGSRe7ghRiNSyVny5N7ojiHD8pJgszg60ocJdVL0WHHAR2mrAoVZKu3uXTVxN3dE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38100700002)(86362001)(7416002)(5660300002)(41300700001)(2906002)(38070700009)(33656002)(82960400001)(122000001)(478600001)(83380400001)(110136005)(9686003)(66946007)(26005)(76116006)(66476007)(316002)(64756008)(66446008)(54906003)(66556008)(7696005)(71200400001)(6506007)(55016003)(8936002)(4326008)(8676002)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4zXvH3Nv2UJS8DYrCScCjgNA7ad30vTdz2YBQJgquNS8TOvCY+lqFHV1Ob7B?=
 =?us-ascii?Q?bklf3a4AX+Fxqj3yqT8T3EBoz0EjFYg5wu893XDNlPakM8xd7tWSLaMw8Z14?=
 =?us-ascii?Q?yQlgW4nv5qbIPXmdV/xDRTYhohrhthOj+Tcb9v6vxJ9FvcRCpjDebV+bUUx3?=
 =?us-ascii?Q?jvPnnlR/FlWVBFKRLzESPzQfb31158aJHkex6sr4aOfsadFUOph7R2miuBu+?=
 =?us-ascii?Q?nJ7sTp5crBBQS4z+w9n2xmpgWyAfGjnRw9lcQj08/bcjKTvI4StCM5+AIhCc?=
 =?us-ascii?Q?rcSsGAd6w//C2V+1FU+cDKtd9s7X4b+bb0Kdbm/xlg66fQhhAyZ1ecw3T8Tk?=
 =?us-ascii?Q?1ZH1DmVMPPDUUhUI6s7NxeP/kIA4qBx5c0M9zON/d7EJ9fBtjBNrHf1SeyAM?=
 =?us-ascii?Q?DQUZkJH7LIMLGfy0JwAX5VSRC5Xa25QGhHGwQaUfXSEU3hfqnPuRmyA7Th1c?=
 =?us-ascii?Q?tmzxAJqQ/7Cn6r/xqD274zh/I14c50yMD+S3Zp2F5bRG54ljIlUJ9XUyDJKO?=
 =?us-ascii?Q?B+tgOGfa5MmPG5oFtqO420GbNvB/kzERmh+3CL2mLrWGXHeoXGkQ+fmMlxJ3?=
 =?us-ascii?Q?vlAWBWOSkvcyfUQJzr5++XMib2n/cRTXiHsqE9XUAkHHhmNMoC2qf0o8vaLn?=
 =?us-ascii?Q?Z6Z6zTES3YV+MM46h2UQmiYwX50TQEFW/+ky1a2hCqH4+GmqxKiHDNXtNQGm?=
 =?us-ascii?Q?TLykcUkFCX1gHWitmGwlMOa7TlPJSrneAgOkDBg+MYr/pCoVNaUL51DI4+d1?=
 =?us-ascii?Q?DMWQXu7wl+sZSVuKqWMHX/VadomHW6HCVJmsjZT2vyZmG2e8UCFy8u/A/W6t?=
 =?us-ascii?Q?aTBck2tu9rLPPP7tmGPIrAIrP8suFuJUEUmJDKB0ZmtPifsmlsLCqJ19ZB6L?=
 =?us-ascii?Q?PDJXMO+KvmnV5fwwVKdZFMpAhBKDdv2v90YoUADQQGRGbhEER7hwwFB2z1or?=
 =?us-ascii?Q?O40ZniIhg9kGT6uQ96k2AqZUzMPwhaMbqifGYhU4zCN3Ar4wggWLN4g8PTVQ?=
 =?us-ascii?Q?9ovMtg9a5Y+NTQzsBoXz0U/9k+jsl9sHP68prQZUst8XZW0/6+xi4VcqsXoS?=
 =?us-ascii?Q?iFhi7slb+mc8HUIIUJOFjbu2EUf0MNQvhs2dAv09GylvdiLgvml8pXBhy4i6?=
 =?us-ascii?Q?wy444vTGVg8PLmdtFPeookKO1ZHERnOhboYdbedMjEg6Od98ww/+uvYjGgt1?=
 =?us-ascii?Q?TbHJiKGS4Y1sAy+zXYCGw3lamuH2HvVYsOEevvB3R2MuMAHW5i8uU2nGgZi+?=
 =?us-ascii?Q?hmm9EVVlYYDnAEXZ9JiAtKMADDYC/9Fb28TUdF3I48uDEtUAAPkxtg8jEONt?=
 =?us-ascii?Q?nfweExSeReMny43kTst31KMurUkssFaAZPRYSRMQQF0BrjOane3h6ORn5cIY?=
 =?us-ascii?Q?mltweNKtdIBXOcWahP76O4RZ/rvBjNdZxpWLHLDQAxQcK93vw4Be2vN5/tm+?=
 =?us-ascii?Q?pqWCXH01cW00EkV7P5oRqKiyzk9l+ZTNvX4uLUffKg9kVAygzw8F+JE38XsD?=
 =?us-ascii?Q?dSXpY62Q50mHPtx6ZWrUqVoULtchFVZ93SfiCxrcelIMA3uqWU1CiBh9hckD?=
 =?us-ascii?Q?SOpEbnjPOagBtQKcZFj5yj/DPRYyIp9f/rdrevD2?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b46b12-bd66-49f3-6f43-08dbdf6c749d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 08:35:10.8906 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3KDPsm7Mbq861Z96PlMmWKNpJJLVhWoAKIjig5p/2LWRJAC1aTCWETcrbD0qG7XIX8uOj37v/jr8h3Ubp/OKxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5460
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Liu,
 Yi L" <yi.l.liu@intel.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Robin
 Murphy <robin.murphy@arm.com>
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

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Thursday, November 2, 2023 8:48 PM
>
> On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
> > Hi folks,
> >
> > This series implements the functionality of delivering IO page faults to
> > user space through the IOMMUFD framework for nested translation.
> Nested
> > translation is a hardware feature that supports two-stage translation
> > tables for IOMMU. The second-stage translation table is managed by the
> > host VMM, while the first-stage translation table is owned by user
> > space. This allows user space to control the IOMMU mappings for its
> > devices.
> 
> Having now looked more closely at the ARM requirements it seems we
> will need generic events, not just page fault events to have a
> complete emulation.

Can you elaborate?

> 
> So I'd like to see this generalized into a channel to carry any
> events..
> 
> > User space indicates its capability of handling IO page faults by
> > setting the IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag when allocating a
> > hardware page table (HWPT). IOMMUFD will then set up its infrastructure
> > for page fault delivery. On a successful return of HWPT allocation, the
> > user can retrieve and respond to page faults by reading and writing to
> > the file descriptor (FD) returned in out_fault_fd.
> 
> This is the right way to approach it, and more broadly this shouldn't
> be an iommufd specific thing. Kernel drivers will also need to create
> fault capable PAGING iommu domains.
> 

Are you suggesting a common interface used by both iommufd and
kernel drivers?

but I didn't get the last piece. If those domains are created by kernel
drivers why would they require a uAPI for userspace to specify fault
capable?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
