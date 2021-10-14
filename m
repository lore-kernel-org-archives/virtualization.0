Return-Path: <SRS0=Buhk=PC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F5AC433EF
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 03:00:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C4661039
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 03:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 19C4661039
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DEAFF825C6;
	Thu, 14 Oct 2021 03:00:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VlSqi2kYNX3F; Thu, 14 Oct 2021 03:00:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8588B81C20;
	Thu, 14 Oct 2021 03:00:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12816C000D;
	Thu, 14 Oct 2021 03:00:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC0A8C000D;
 Thu, 14 Oct 2021 03:00:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8B3FA4063E;
 Thu, 14 Oct 2021 03:00:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aHD9NSQBEcAe; Thu, 14 Oct 2021 03:00:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 70EAA40628;
 Thu, 14 Oct 2021 03:00:46 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="227484670"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; d="scan'208";a="227484670"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2021 20:00:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; d="scan'208";a="481063842"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga007.jf.intel.com with ESMTP; 13 Oct 2021 20:00:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 13 Oct 2021 20:00:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 13 Oct 2021 20:00:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 13 Oct 2021 20:00:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 13 Oct 2021 20:00:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdVD3mQmqabzmHSx+YKz19udPYY6Q6iDrGCNVeVmtheJMFBmHgeMOAJ8s6cgj6MG4V18wZgBT1N6DtCVsRHOF5irLRg6cUyQIgvzMgXjWN7v6CA2RY8+HF6dbfoB1f5RC38TE2ouuuLDRt5F3GiPPLCPKbCA8nYiD0suDjWwbXgYrqcKU9TGu97qvnjsKYfzWfHnIhlRhtY7RE/hlFia7CKl57kfFC0cW3MdAwUOP/0Oyye4yNTa0W2mlFAo93p3ZqUN9AObfP7LwtbIyCe5p/SMcRSofmX9br4NPmUhAZc9dGG3KmzQ5UslpKQ7/BxcdgIXUOXMgwRBF/zdGYMlww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OycyCkG5E+7ku9ho/JQKEYolnlKbEl5ZsOIuwr2e3WI=;
 b=Ir/EJ1o6U06QCoi7m89QQ966FosO9aJlsors2/rBvJS5Bsk2qA3b8yORgkJAgeWhrDY61zKJD4mSAj0POlSb9QPULcvybep0L0MxF4Bw+uUi9lMYrKQg3D2l+K2AjEkDgNxxZkcE+F3/KNOL4wA9KMLvf3yf7nIG0XMlh7YBRVpdNOzEKzZlDmuRL0HUxXjVQCIxUvvb1+1Igw8FCrIqkTgR2y4BY29XM8yY2o1PXCG4hDuacqEakz6XdXViMp/KgIVp0jYTWdTvJyFjbDLBzt2gxripl5xVZ9AYajnrtGh9G1dY/kqvhWPaq7wkVC6CwhDmeH3IG0UYopJ4kcF99w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OycyCkG5E+7ku9ho/JQKEYolnlKbEl5ZsOIuwr2e3WI=;
 b=tV6rDxnVt1kfkyz6QQmjxdPW4vaXE34C02TWmDSpfdJKA3+PuRjMX2UgD0DY65ESRi7Pz3aP/Rm9MSWyhw2rOwWa8lrtQF+czU6JALJShDhUgMGPLPNHNWHczrV+IRC/LiwP7Xn8E/Nj2Ktueb3ePi0CNUxpAYXRi+jM1xt4qLQ=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB3890.namprd11.prod.outlook.com (2603:10b6:405:7a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 14 Oct
 2021 03:00:38 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4608.016; Thu, 14 Oct 2021
 03:00:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH 0/5] iommu/virtio: Add identity domains
Thread-Topic: [PATCH 0/5] iommu/virtio: Add identity domains
Thread-Index: AQHXwCxydUd3K77AsE6UB+M/DEvsiavRyYfA
Date: Thu, 14 Oct 2021 03:00:38 +0000
Message-ID: <BN9PR11MB5433EFF47E5FABC1D7D95F6F8CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20211013121052.518113-1-jean-philippe@linaro.org>
In-Reply-To: <20211013121052.518113-1-jean-philippe@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e05b557-3950-40ce-52c6-08d98ebecd3e
x-ms-traffictypediagnostic: BN6PR11MB3890:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB3890B2F0A09E03C1A5AB80418CB89@BN6PR11MB3890.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mA6W96TFViiFb6UgJY5jrpJAvA6AnxDmkIwUvcYIQ00T3gtlY1YyEwj4ThGTa8ZACbQCb1datyiLlGBUpH7B/9kUmbuzMJc9rg/3e1blAi+LA16GbUb0osrgMMDwso67ODQ7FGv+M3sX/9j0oKnFODNNCevE7m7oohVFQQYeCZhOM/ZCWNEo7tHZX8fzzjjFVVVlbkzKGHr/4DLzeF0dZkqG5IGwMZqQGCmLHlUKWWLTeC1gTuRnSV3bBVL1tRzucPizSBdG3VvNqaeh/lRiSS7NUhiYwfcN9Dq9YcLyofTavjDxEAwfRk26vzBzM6Wq5tVOC+u142XQun9ucugre034dBXNINahT0/dqNbr7rvTmjG6dkdeerPbquYe4u7UWr6tKkC2uAf14Yy1yer5VnicigMTdtWvnDy7LBg0N9Z1sCoHpkgm1j3RXLRhZYv6EeT/qxgJZJN1/KmKr5e+738sOLyEfZF39rS2XxaGbNvKyN7H/Rp2uGdAzlk6RoRMwAbsFJ5A6ZIkrZQqF+faOEZwlHoEs3FSO5xRrvWBCE7STwogM2soon0glT2qZVVOiR/VX9JrGMX9X0efyGGudpJsANPfE3qrOrestczFHvQKJTX5o/ieqT9MPkvCuLEdc9tQXkq8MaOGx/8OpgQBKEUYO1/PXizWL2dTOdj2b1Tpgkp0raVi+gLrQvV+FYAwKtWqkOfDzqjg/QpEXVmtnTiKZckYAOHV9d3j9i6wJLvhLQ3y6ompKK/EOUQw1KBDABzwmiVZ0qjz14Ztd8tjWIo1Jck0NlgkWAVh/57ut4s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(26005)(5660300002)(52536014)(86362001)(186003)(966005)(6506007)(7696005)(33656002)(55016002)(83380400001)(9686003)(82960400001)(122000001)(66476007)(71200400001)(66556008)(66446008)(64756008)(66946007)(8936002)(508600001)(110136005)(38070700005)(38100700002)(316002)(2906002)(4326008)(54906003)(8676002)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o+IqtJhXnpI68pZV4WE1VVzlhd0Z5A92AFqak2zBor22QmKKRmry2kIWfBe3?=
 =?us-ascii?Q?wFtt4aRLlVaGznVaG+hSYQ0/Z/vjSjlhkxo3B8rMPRojrvr3k1V4ltHGFJUq?=
 =?us-ascii?Q?V+mfXPOhePDJ6Xad5rYTRBNkx828p6go3vDC+DRTdAC4Su+mOCw6gMuisetl?=
 =?us-ascii?Q?tlX9TGhi3cOfayGYWP/Vxfmsa2jS2sIbCGwUjtLhX2RaLAuSn3gthEY6Ljad?=
 =?us-ascii?Q?76hRCHCrmIK1benT8MFX/XNdcVz6yM4x4BjpD8Bp1z3CyM8qJ6GdlN8SMxUR?=
 =?us-ascii?Q?DDbO8PmfUpADVHyw9BnMraQEfpL62EYsGWXKYXeIF/e76ef8HyEdze01r7cp?=
 =?us-ascii?Q?VHZge88zVJwZqmx9LuP0CALVZxAIXuTXsHxDmU6wgizFNWYoaJhkxGA7vxXs?=
 =?us-ascii?Q?imNO+GUs/lkdzcCleRntKxwTUo0dKOURY53ZFLQMJlnt2YzWcvhuVTUZsgwc?=
 =?us-ascii?Q?kVmWMA3cVOO2Y6JmBpv11+uGUxpn9FOV48SATwG8l/eZwYW3FrOw9h+FRE/r?=
 =?us-ascii?Q?FGOyqIlfwDqjfYbIAr3EVNTK9L4/UTU/xPJDERNeXNxnHeRUbvjHEN5zzbVk?=
 =?us-ascii?Q?tGRTZgnw739myE4yUM570ELyRvI1ZlVFq/47QtaxNI0uwkaArGFkabnhKELi?=
 =?us-ascii?Q?zP0yMDHBO2nDBP01Hrw8OR3nTXC2eas2pAMdvscCYg58ZuGwkWXQnN7dU7Gr?=
 =?us-ascii?Q?3A4j3bwZWqicjsB48vDFMWaznLF9AbZfCs4xzQjTazOsySyOBjHjZVV0/+gp?=
 =?us-ascii?Q?m3LFtVDjvGR1h2Ngp5PFNJ0QPjIMTINpJU5A5twiSAqZPJwpPALpaxpuc2IK?=
 =?us-ascii?Q?29cDNRNghzcYvtTUhyHYbDGsdRWffwOJo3qF53rmSJdKD54JBnPezX/FOytk?=
 =?us-ascii?Q?56ObN73dIhOsF+ReINtXpk773K/pHGuBXm8eZ0T5kTfDualiLCAUZE3Arbhu?=
 =?us-ascii?Q?cu5FVJV6DjVSxkN/+eGGvoZ+GrPONegiXAkGNZMqiD+paJMf0NzPG7QFPnD4?=
 =?us-ascii?Q?WG3VDDa9KcdscWAWMHIbIgCzRdRpiVjPxuB+voDYR59MBJpD+7Mclwwdufu+?=
 =?us-ascii?Q?kHP6roKB+WeYLRgrERFWnEY/hKgCdcJXo/lRSXixLUHmt5HmOmCqbm0OP/pu?=
 =?us-ascii?Q?wHZOEvsbusTaViTD4e6orWsQP85nrVp+zPjmFjECi/pnr997ZBH9K5m4asEM?=
 =?us-ascii?Q?P7K3z5deQfH0M8pAt6MUY52rgjcgYcwkMvLc+hrMmOkPy/mQGBHErmuNhSBX?=
 =?us-ascii?Q?b7xAdkP8ryU6cX0D81o5SHtIInk3ylBwtfw2tzYuoclJvTtuWj3xOdY7gZ4w?=
 =?us-ascii?Q?RBY6/otF2i8AgWQgN4ePOiZh?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e05b557-3950-40ce-52c6-08d98ebecd3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2021 03:00:38.6974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qi+nv5MLUSCKHGQm4ZVyTDiWnZFsKNI9L4bJaP1lMQTeOgGuGuk/S7L7XYdzBY7Hkv53PtmUf3DLK5qsNAF8XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3890
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

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Wednesday, October 13, 2021 8:11 PM
> 
> Support identity domains, allowing to only enable IOMMU protection for a
> subset of endpoints (those assigned to userspace, for example). Users
> may enable identity domains at compile time
> (CONFIG_IOMMU_DEFAULT_PASSTHROUGH), boot time
> (iommu.passthrough=1) or
> runtime (/sys/kernel/iommu_groups/*/type = identity).

Do we want to use consistent terms between spec (bypass domain) 
and code (identity domain)? 

> 
> Patches 1-2 support identity domains using the optional
> VIRTIO_IOMMU_F_BYPASS_CONFIG feature. The feature bit is not yet in the
> spec, see [1] for the latest proposal.
> 
> Patches 3-5 add a fallback to identity mappings, when the feature is not
> supported.
> 
> Note that this series doesn't touch the global bypass bit added by
> VIRTIO_IOMMU_F_BYPASS_CONFIG. All endpoints managed by the IOMMU
> should
> be attached to a domain, so global bypass isn't in use after endpoints

I saw a concept of deferred attach in iommu core. See iommu_is_
attach_deferred(). Currently this is vendor specific and I haven't
looked into the exact reason why some vendor sets it now. Just
be curious whether the same reason might be applied to virtio-iommu.

> are probed. Before that, the global bypass policy is decided by the
> hypervisor and firmware. So I don't think Linux needs to touch the

This reminds me one thing. The spec says that the global bypass
bit is sticky and not affected by reset. This implies that in the case
of rebooting the VM into a different OS, the previous OS actually
has the right to override this setting for the next OS. Is it a right
design? Even the firmware itself is unable to identify the original
setting enforced by the hypervisor after reboot. I feel the hypervisor
setting should be recovered after reset since it reflects the 
security measure enforced by the virtual platform?

> global bypass bit, but there are some patches available on my
> virtio-iommu/bypass branch [2] to test it.
> 
> QEMU patches are on my virtio-iommu/bypass branch [3] (and the list)
> 
> [1] https://www.mail-archive.com/virtio-dev@lists.oasis-
> open.org/msg07898.html
> [2] https://jpbrucker.net/git/linux/log/?h=virtio-iommu/bypass
> [3] https://jpbrucker.net/git/qemu/log/?h=virtio-iommu/bypass
> 
> Jean-Philippe Brucker (5):
>   iommu/virtio: Add definitions for VIRTIO_IOMMU_F_BYPASS_CONFIG
>   iommu/virtio: Support bypass domains
>   iommu/virtio: Sort reserved regions
>   iommu/virtio: Pass end address to viommu_add_mapping()
>   iommu/virtio: Support identity-mapped domains
> 
>  include/uapi/linux/virtio_iommu.h |   8 ++-
>  drivers/iommu/virtio-iommu.c      | 113 +++++++++++++++++++++++++-----
>  2 files changed, 101 insertions(+), 20 deletions(-)
> 
> --
> 2.33.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
