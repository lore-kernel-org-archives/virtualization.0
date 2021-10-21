Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C87C433FE
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 06:45:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3432760FED
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 06:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3432760FED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D946830AB;
	Thu, 21 Oct 2021 06:45:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ntsPXxQpM98R; Thu, 21 Oct 2021 06:45:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 386B383163;
	Thu, 21 Oct 2021 06:45:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AABFBC0024;
	Thu, 21 Oct 2021 06:45:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72A26C000D;
 Thu, 21 Oct 2021 06:45:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E49D830AB;
 Thu, 21 Oct 2021 06:45:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ne0XIrYo0gjr; Thu, 21 Oct 2021 06:45:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1AF92830C0;
 Thu, 21 Oct 2021 06:45:07 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="209059482"
X-IronPort-AV: E=Sophos;i="5.87,169,1631602800"; d="scan'208";a="209059482"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2021 23:45:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,169,1631602800"; d="scan'208";a="463512528"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by orsmga002.jf.intel.com with ESMTP; 20 Oct 2021 23:45:05 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 20 Oct 2021 23:45:05 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 20 Oct 2021 23:45:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 20 Oct 2021 23:45:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 20 Oct 2021 23:45:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsiV+2gcCbj+qpp1zJ59HOcF2yw9FDrT/vgj2ZQwZ7PS7K/RMsP53mYelrzCfud01NpxnBB9iT+cerZJ9AWPa00TuH9KW5aXTBqYLplKPu0SKdlaH9w0QFy4+1XjLVzX1598QFn9oniinfEY4EeUd2cdAHdrsB3kiJ5v8d1IGyaaYF52nAMUCoMkMGIPVv0rdA5eIB58LB/rLN9k1AU9oh4WioEbP2poC2pO4H11K4TNe2797v5KxPn8wGvUpVNwTdfBETtZnuqOaFrDv26Up/cHAgTMlv/miEtfXFbcsWCnrlhtflKcglXeDDV0PI6w/YB+5NLOYyCn2JbZtCjB1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvO903lqDkdIQ6eSbSFefNs1l+I9+3AgDFPImDqeak4=;
 b=CcOdSNBX+m4VI6OFXZPlMz77C4F0Z+0EVD4aJjR4/iwYdgLyK8CoXbl2CxlruFZJcPORGeb7KyobkDe/NkC25eGZ7T+hA21uW2Rbjcr5pgHWiaLWKcq7cX0VC0uOBbF9z9ty2XNyQ0DzeWZM5s0JQFfO3YuOPtRHTNVCVR121aEKV+gFKyzKee0aWWSnynRj50kFHtgjz9fm1ppbnhOGcGPdO2dKA9r/TtN52OCt6dcxpTuFPLJo66n6KQh89Iwxxq3yqnZh9kjT75oXNPMvBVv4+DmlDWyNCyPZoC7IHlliGEggd5odvMOY/MTArhNGrmRWJCAunJsiOXR9SCSaCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvO903lqDkdIQ6eSbSFefNs1l+I9+3AgDFPImDqeak4=;
 b=XgnukFO9wPOo1VlDh7+ceYPFgcXjmwlBFl8b+FDadglWryc+LFhhxDrnQkyw2X5EPjooy9ePW0rkvtPr4sz6qfAOPygpP/H8mtA7T+kcGsT10FtiHnQDTpSkIlqjm7LoNcNpeSlJc0sqGwk4rSvd2Dka48I/TjiToysubH5juJ0=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR1101MB2340.namprd11.prod.outlook.com (2603:10b6:404:98::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 06:45:04 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 06:45:04 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: RE: [PATCH 0/5] iommu/virtio: Add identity domains
Thread-Topic: [PATCH 0/5] iommu/virtio: Add identity domains
Thread-Index: AQHXwCxydUd3K77AsE6UB+M/DEvsiavRyYfAgAceY4CABCRj0A==
Date: Thu, 21 Oct 2021 06:45:03 +0000
Message-ID: <BN9PR11MB54334498B6B099A7024FDD4A8CBF9@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20211013121052.518113-1-jean-philippe@linaro.org>
 <BN9PR11MB5433EFF47E5FABC1D7D95F6F8CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YW2RfXJwAxFYOYzs@myrica>
In-Reply-To: <YW2RfXJwAxFYOYzs@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d851dfe6-b1bf-4e0a-9267-08d9945e500b
x-ms-traffictypediagnostic: BN6PR1101MB2340:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1101MB23403577038E37E97F71BD178CBF9@BN6PR1101MB2340.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Q3kblyHacpv9bOLIgz7g0Jl7PMF3T1QFtwmNxj4fNDVrcBEIwnLczONenhujWpdCr2zdiS1KHiwuaGHDWoMk2ksANHucqG9IHYGIM2KVX+HI+MfDbgaapWUUxKaPSoBjcWhoDQKXXonbkjLA6CZeQr4Ro11/vws5f9yS5lSzXk1pASpQw/WLax/nBEKtRSP4Qz7H0lpxDKgRZeEBAKExDv2m6a6OK8JmQYmqgXzLXzA+NBJC7VTkmu5n/s0syRnYJcG9C090ZzNhdv4XOk1Vi70YCiP00FVdF/uSYxDvbcI/L55Y7y8Ffaa8Z/FotJR9sgvwGZOSUxOM4qgS6wMoplMSbzEaIJ8Aos4o32wiA2RL8vx8vZ8OJyGydBLusyIFtYoj1IulQNCRO2iXi9ofgJZYCNNl/KKV/NT2MDeR0zPgpZ3bnj9OWkIqHzN57Vv59d3S2Q1YfYlFYGMb2WZ1ANgG2QZ7ncYmQykHprJcQhAU0jbqDhL86Z8yqmLMop/hp76KPQLh7cP0YSzhk2ugE8nwjk/siw4elVIsgmx54dfhyH0G0HLmw9m/eqmDiTzORQ/MZQokL1igtZiCcpEQynvh01bp8pH3dts5Umx23rUSwDH8R/SFfp3Vel8p76QmXE9/QTpSKtgkxJUG9UtJ7qKI8MvrfRKoKMmp2vr9K2gvOqY6vyGsOVhOuKGgbFZq6xynvk4QQnU7JuonB5zlw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(66556008)(8676002)(66446008)(316002)(54906003)(64756008)(76116006)(66946007)(186003)(38070700005)(66476007)(38100700002)(71200400001)(6506007)(6916009)(26005)(5660300002)(52536014)(2906002)(8936002)(83380400001)(82960400001)(33656002)(4326008)(7696005)(508600001)(55016002)(9686003)(122000001)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9Wk9GBUqQ/sXtUlPKA5FhUXrlGa0TyVWOV7g/xPlPLBiHcR7QoQaQibZiz7f?=
 =?us-ascii?Q?V1yGWenDOp4sjINijuBQWCwPS82gXfFLfiKER+pI/tZGH7NPuTgOAzGiS6qE?=
 =?us-ascii?Q?6mAHIKbu7MHaUpp2uO+0hyrrSolHDeqIUX5ofjIiobcxTvc9+hXMt2UhRmKL?=
 =?us-ascii?Q?dnPzCSaYBNKRXZx/0A7Jz63zWYQl+CwI+XRZU/Z3zZjJAPcc/s2S6cDDwTw3?=
 =?us-ascii?Q?ys5LLbaXC4h2XHrz33cxq+8aFYPF0pDql6pgpLE9alOXdpcu0q+Fmbajc8RZ?=
 =?us-ascii?Q?y9d/VKQL/9FTSrglEAbZyb4zNeOAFvlZKO1B3S7Snpssyf/YGUqki4XQbQXJ?=
 =?us-ascii?Q?iVety0sRRRTYAiZRPJsEzWo5Tpw59BEdtJIS/i/vQN13MAT0FyFpMncqGSZx?=
 =?us-ascii?Q?y66H+OuQeXitNv7QUgaYnEkaRpVXSbNVdPi7r83tWEpPMQVMFJ1e7gtgvNGR?=
 =?us-ascii?Q?7Sm7UkqPMpAOCIr7A20YZE1Zyy/qFoopEXW2eZVcLUvHQ3VNQxarvtl64Vk7?=
 =?us-ascii?Q?8EDZxXl8Etypx3Ultbp7U0iPUq7EMxHFDnxTMaXt6mKWyhCELLaqhXbQZRJX?=
 =?us-ascii?Q?x/cOnS5fsoJylDmgeA/yNpjCbDAf22HV+T0C2h0QHfrCm+X+RSi4V3+PDPLi?=
 =?us-ascii?Q?bwBzB6Cm4Qtjo14bfPlUveDScPiK7kHrpuQ7Sl2hOtRSkWnpzNuCxhzF315i?=
 =?us-ascii?Q?7WC/Cpw5hilLX9Z/xFnw7oLiMt2e4W2+088X+VO4idYfe1Ehgn1kzg+gk4tE?=
 =?us-ascii?Q?mFNZtw4CaujJig8OhfztS8DdHhyQ/rFdEZCEiNLzJalr2vyubCOQb1hjgp+x?=
 =?us-ascii?Q?GYbGtS46UmMEeE/WU1pkPYuW4fvyqUptCjB9hpiWuzMwcWd1MUYFax1Miv2o?=
 =?us-ascii?Q?lr5nmbO1wk5yd6qGlmUXi82qc5djsdyDqPtPTeT9nTyiL0gC242U7HZ31lLG?=
 =?us-ascii?Q?YeCe7Ngm92KHupKUYoJiFSFRjLeKd+c+AThOIdoGlX+YOa3X1E8oJGE0Tp9b?=
 =?us-ascii?Q?7Z/ws3cJdFhN1moa+DYPSHS0aVeXJBVI7i1pPskzvxBbKN9K02oNME7adpcx?=
 =?us-ascii?Q?aV73Ryg1jmW6MC+gWiVr1+q+lSb1dCEdCQfyLzYXmbJsakX+iMUbxbN0v/wn?=
 =?us-ascii?Q?uHvIy1ElqVhA5GzeiKJboO57oHttmy83ay7HZz1I/jbESEaHg0Gs+Q8fy+4D?=
 =?us-ascii?Q?ZEFdfQFjfdVphXQuAnjD8+dfBu55L8dAn8QpwkvlchSdP2/CLYRU1EzVm7AW?=
 =?us-ascii?Q?xZa7TuwB+V/i0tFgG7ndnQNXILKjrLujJ5YIHzM0Ybzj139kE1Jq9+z+etza?=
 =?us-ascii?Q?WGWsUmlu97m2bfYQGnRci2bk?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d851dfe6-b1bf-4e0a-9267-08d9945e500b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 06:45:04.0039 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kevin.tian@intel.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2340
X-OriginatorOrg: intel.com
Cc: "mst@redhat.com" <mst@redhat.com>, "joro@8bytes.org" <joro@8bytes.org>,
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

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Monday, October 18, 2021 11:24 PM
> 
> On Thu, Oct 14, 2021 at 03:00:38AM +0000, Tian, Kevin wrote:
> > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > Sent: Wednesday, October 13, 2021 8:11 PM
> > >
> > > Support identity domains, allowing to only enable IOMMU protection for
> a
> > > subset of endpoints (those assigned to userspace, for example). Users
> > > may enable identity domains at compile time
> > > (CONFIG_IOMMU_DEFAULT_PASSTHROUGH), boot time
> > > (iommu.passthrough=1) or
> > > runtime (/sys/kernel/iommu_groups/*/type = identity).
> >
> > Do we want to use consistent terms between spec (bypass domain)
> > and code (identity domain)?
> 
> I don't think we have to. Linux uses "identity" domains and "passthrough"
> IOMMU. The old virtio-iommu feature was "bypass" so we should keep that
> for the new one, to be consistent. And then I've used "bypass" for domains
> as well, in the spec, because it would look strange to use a different
> term for the same concept. I find that it sort of falls into place: Linux'
> identity domains can be implemented either with bypass or identity-mapped
> virtio-iommu domains.

make sense.

> 
> > >
> > > Patches 1-2 support identity domains using the optional
> > > VIRTIO_IOMMU_F_BYPASS_CONFIG feature. The feature bit is not yet in
> the
> > > spec, see [1] for the latest proposal.
> > >
> > > Patches 3-5 add a fallback to identity mappings, when the feature is not
> > > supported.
> > >
> > > Note that this series doesn't touch the global bypass bit added by
> > > VIRTIO_IOMMU_F_BYPASS_CONFIG. All endpoints managed by the
> IOMMU
> > > should
> > > be attached to a domain, so global bypass isn't in use after endpoints
> >
> > I saw a concept of deferred attach in iommu core. See iommu_is_
> > attach_deferred(). Currently this is vendor specific and I haven't
> > looked into the exact reason why some vendor sets it now. Just
> > be curious whether the same reason might be applied to virtio-iommu.
> >
> > > are probed. Before that, the global bypass policy is decided by the
> > > hypervisor and firmware. So I don't think Linux needs to touch the
> >
> > This reminds me one thing. The spec says that the global bypass
> > bit is sticky and not affected by reset.
> 
> The spec talks about *device* reset, triggered by software writing 0 to
> the status register, but it doesn't mention system reset. Would be good to
> clarify that. Something like:
> 
>     If the device offers the VIRTIO_IOMMU_F_BYPASS_CONFIG feature, it MAY
>     initialize the \field{bypass} field to 1. Field \field{bypass} SHOULD
>     NOT change on device reset, but SHOULD be restored to its initial
>     value on system reset.

looks good to me

> 
> > This implies that in the case
> > of rebooting the VM into a different OS, the previous OS actually
> > has the right to override this setting for the next OS. Is it a right
> > design? Even the firmware itself is unable to identify the original
> > setting enforced by the hypervisor after reboot. I feel the hypervisor
> > setting should be recovered after reset since it reflects the
> > security measure enforced by the virtual platform?
> 
> So I think clarifying system reset should address your questions.
> I believe we should leave bypass sticky across device reset, so a FW->OS
> transition, where the OS resets the device, does not open a vulnerability
> (if bypass was enabled at boot and then left disabled by FW.)
> 
> It's still a good idea for the OS to restore on shutdown the bypass value
> it was booted with. So it can kexec into an OS that doesn't support
> virtio-iommu, for example.
> 

Thanks
Kevin
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
