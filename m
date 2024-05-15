Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7310253361
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715763064; cv=fail; b=VJpy9TJDAbNeqLXu5Q/oqo7DKA8XMxJzOhjVAnsRmZoKmIVQYjqdFNSEbLIhWFC53/yqxp6Dpw4avQ066Pnr8sl+Yxl6C1uFOYc5LQRyOnmf904pGHMgijDs1aPkl24fpd4UYVlYB79+ejUHMCn36VbSWkzC6YMC7YCp1KSKYBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715763064; c=relaxed/simple;
	bh=puYiOHmXME3DgZoR/ZzWnQK7LcKWnXr5IMZ4bj+rtCk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u32mGAjENMuEWeV1N0ttT5WYqEG2L3pRyHOWqAMwY8UA999c04r/N9cZmejDOhrmPa5rKc/5JvH1ypPdq0lrfSYvy4vBpjO3bDoMnXsEEnNJmC3fRD1+vr2WiVD+ttf1kvvBOm6OMa/YLpYzR9UJieZf9d89xxO/bXbx06gX02g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmy5HJ8z; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmy5HJ8z"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F33384064D
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 08:51:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bdUGSZPPJPre for <virtualization@lists.linux-foundation.org>;
 Wed, 15 May 2024 08:51:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4DA5740647
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4DA5740647
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jmy5HJ8z
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4DA5740647
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 08:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715763061; x=1747299061;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=puYiOHmXME3DgZoR/ZzWnQK7LcKWnXr5IMZ4bj+rtCk=;
  b=jmy5HJ8z1Ji+RA3utBTTppOREiQdJzJ4fUyOoaWkvdLmFc/aCe63sRoQ
   1HU7yTueLNSLTREV/c+O5g+WgX8h+a5yTkBNnJEYGPnc3h+FvsOk3lhPz
   UgRMaue7hd2/GcijFeUlNwZiJUeapYSSyG+FMKJGbIzfn1EIRaFmQtyXq
   KNDlwNK4cQkyJwr+Tv883E0F5xkz8fJKZadwEXZYYchLi/OxVdOIc5iuO
   AqbEKmwtuROn0EBPkY/QQe+SoCkdTBzYgRzKD4tH+Q9LUGiHJ+nBKyF24
   x5vUuPnCL2P/NvHh+A7o32wIfjk7aXrW+XDdt7oqeNsXRKTwVOCF3AReM
   A==;
X-CSE-ConnectionGUID: GXKrE5l/ScKhtEfKtPWHJQ==
X-CSE-MsgGUID: nquRi1ojTSKcB7xVyymTDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11668152"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="11668152"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 01:51:00 -0700
X-CSE-ConnectionGUID: u50xUITlRwKeqCnYIrda5Q==
X-CSE-MsgGUID: kkaCy9GtRzO3338DKyk9EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="35530818"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 May 2024 01:50:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 01:50:59 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 15 May 2024 01:50:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 15 May 2024 01:50:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 01:50:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHmnnzA6u7ESnCrYETQY3K5K4UvYjjshhobj2+3ru5gar1MBONVCvBgv5R2o5xgOUR8HxHk/C1McNCac5hLIoYXZeywyGHXG7D79NyipsjVsZPJSqLSWggf4ioauWXAJSm9LRwqfdb+JJOnh3Ph08EVrWgEx1T6pWEOjqUq2q1IJjoNiIJP83N8EsRzDbTFq//0m3GgJo2vyc+CLPYbRV8HMxWbbhTeZcE9JmbhzPWP63LXZfaRmCtDj9OpdMhmdFnpusfpEUYv16j9IhJvjRq5A/p8ExFYUVjwEZ7UhwFZR3JbwSvBvmxzKMylywMxwnU4eWXfUySstIMVPbB4H7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taZm/MGiw/o+SN3IVMuWJUTqwwrBnHfL4wIjQ5SllII=;
 b=UTX3x1Qfmh1//AYFu768VemnGgeDI3oblCOnNSd4l0qgw6cfnHok58ElwKYgeEplNplca7UfUs4r4L0TbWv3lxwmDGZFo2VO6K9j5pB4+vK/VXM4EHfUf1g8cNI7655eo5PDmAqw5qVtt2OfKvOxpzOCSIDio0Q6iDZsFtu2CjTq4WhYcLGIoUwkouKQHqU5snE47mV+ATWDAtKA1iBehtS0gvIbOoHETddWA1IyVjzd+lXyUG8/vpBPUSaNPsM8Umb6EAUb74bJmLoA/F62s/N3JpUnQqHKirPiOtqujYqErSXXhX7hWyUyvh7fby7e7mR+kSog6Hzxdg8JD40YIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB6918.namprd11.prod.outlook.com (2603:10b6:806:2bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Wed, 15 May
 2024 08:50:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 08:50:56 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Jacob
 Pan" <jacob.jun.pan@linux.intel.com>, Joel Granados <j.granados@samsung.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 7/9] iommufd: Associate fault object with
 iommufd_hw_pgtable
Thread-Topic: [PATCH v5 7/9] iommufd: Associate fault object with
 iommufd_hw_pgtable
Thread-Index: AQHamw8P/6/4oit4lU2Ra006NwpZoLGYE2jA
Date: Wed, 15 May 2024 08:50:56 +0000
Message-ID: <BN9PR11MB5276A8E898983310B83C399E8CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-8-baolu.lu@linux.intel.com>
In-Reply-To: <20240430145710.68112-8-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB6918:EE_
x-ms-office365-filtering-correlation-id: 87179ae2-d4da-4fbe-2314-08dc74bc2300
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005|38070700009|921011;
x-microsoft-antispam-message-info: =?us-ascii?Q?cpL6Jinsq1w+TRxLcLm2RzG9XyJMQOYA+2zEDASgZIPu4I/GzASDN0yT7IQh?=
 =?us-ascii?Q?ez83UZRAyHISQDEZB+giQn+9Z4U87K4xkV5AaNhtXeabDX6idrzFdDaU5qHx?=
 =?us-ascii?Q?X+UPwVoyNf+oAfHN61UNdHvwf5Sfd8ceqY12NbQiIzTYIDAY9bR6LLmrbrpX?=
 =?us-ascii?Q?QS0/w9aeEQbQFU101aJ/xRSqa7j7iCe3YvQJbM1pH5EHvdIWsWeCUSmCzql4?=
 =?us-ascii?Q?lBzU0FMy0eOFHR0Z6vS7B4UNF+2lOdFm2DXqyeCjTnazKg1r/fdE2iNM/RVf?=
 =?us-ascii?Q?8buZ5MBEmOz+WilGMld4OR9+PNCrpDLKwbYTlxQRmp1lDxtzeX5VvfS0TSgl?=
 =?us-ascii?Q?ZusTc3s3pq+nzAR07+y1RP3UsIcuLPJFAqAip+B/9L30SjZ9Oq73wItGaqNE?=
 =?us-ascii?Q?jDpJHa3eAtKIJQ0wiyg8NG+4zgXDPVENMCJCbSnh45Yb2VDaC13Z3CnLsjlh?=
 =?us-ascii?Q?kwmHZmUBXxp4S4wYBJxzmRMlGvj9pA7slNmKO0cb6LEFxPhzAjN4cxaHxaCY?=
 =?us-ascii?Q?ja+gCjXRCKGnK/EdFCbObw5sfatSpXN76Lv1FRA6peIso2CoY07NgkFXy2VO?=
 =?us-ascii?Q?SvwQoNmGXrKWrIK0QyO98IO9V10fU8cWaBz3k7DplpklikCAmKKs8lfuMoPB?=
 =?us-ascii?Q?Eymo/d/O8JosWxO0yoFOJoQPi8yV3bNGWxYbngRxmYnd20ABmgx8aLusHqTO?=
 =?us-ascii?Q?jhz+yZcucAxRBe2elyAroaN9LMREEiZj8Octaw/B9Z8TZgWIJo8naNgM3ehA?=
 =?us-ascii?Q?eC+1YnvIJJ3j3S+BG1WGURQ/FAOVOQ3l8w8MadqD1Y/g7cq5N9G3NTDH2Tu2?=
 =?us-ascii?Q?O2/SU8dIfM0ET2OXqMz1WDIqk8aweTBpVn+/pzuXDCxBDGHzYHh4SeOFm+YJ?=
 =?us-ascii?Q?TYRtjxnmFaSY8wfWisykTnzZ6FAmhB7Lt2isx6ajHWuYrIzLK85Qg3yxPjRX?=
 =?us-ascii?Q?QtBnTLDiP/QdBWsRW3MYO5cp4XB+Xca1pSX/T3zDpCTGpbR9rXAiU6K0meyY?=
 =?us-ascii?Q?RXjFDnxPuVYkcntwka8UVOtwTk79QlKxyVD4IwxhTIBXRfMPcEVCpucAVWw/?=
 =?us-ascii?Q?ZkhXXQMN3gQEIDwEa8d/jC8rkRswr5/2N0giXbKuA3iK742DiAhwRtcr1NNj?=
 =?us-ascii?Q?eHnCDB2zBnursGnlGkcSgTaegLLPqwnfhU69aRBlMBlr9DhNEsYihOcpYys5?=
 =?us-ascii?Q?Tb2y8BxpjUgDeG2kxy13aWyzjdOyV0b7EB3lY/uicxRYUTJCaj1rPi+L0FbI?=
 =?us-ascii?Q?CfUmmq5vX+2x2A/iVPaKys+GzQanfOs+CK9qVMJc8kxYEvZgYiPkp7bbtaNX?=
 =?us-ascii?Q?q59FGhV73Hg1LD355qprrnbBYCb8TU6wltekRIpnPVzxWlG+l5q8Q84Qk67p?=
 =?us-ascii?Q?CYqpPxU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U/hWFJBFr+aiRc/Ne2eOby2twHY0RmIQn2YVM7I0SPqhXfrlXrEPS5lj1kg9?=
 =?us-ascii?Q?j/hOnRAefhdGUqzq7A8oG4cNb1a+tgx+nx0ndR4UOHOFENoln8qUZwMxGp//?=
 =?us-ascii?Q?PfFiMI77f5UD5B9hHKIwzXtj6XUT/R8I6Wujj0OpYHVEcyte6QEihggwtVSF?=
 =?us-ascii?Q?bvj7n4d+hb26Z1M10qm9CFxcOp1/t3mFlEBjKJoTMCRLFhdw5khxURqTKilL?=
 =?us-ascii?Q?yqVlJ+HVYlSR7QgTKjEBFj17aF3JXTLs8i30kUkdfSoRb0b3Xlia3RX4YFsK?=
 =?us-ascii?Q?eBexVPPm7kOEOuk8r39o2yeCwy7x6ZmYyIN6md/I9Eufk8zZpflZhf80hzL5?=
 =?us-ascii?Q?nJCbUj7p7EaGEmkXO0H2dfdPl20cwU+eiDUaWveg+fmNNt44gQFwVXCUYfhS?=
 =?us-ascii?Q?nEWR0f8TfwP823KZ0p3UqkP5han+MIoC+Gr04I8YruWdRGEqhnYLy5wCb66/?=
 =?us-ascii?Q?wzYcYyIiOJCrar3GJ81XpDCo99vZWN4dk2EgcooLMqqZnJhdfIBkKsm1Wgmg?=
 =?us-ascii?Q?u/7is3HAUXFRZPHF4kb98hG9JjMixHvLCNh+/R6ETdeRhx6/7nGhBzdf7TSE?=
 =?us-ascii?Q?ZUhWbr+z1MLj92BRL1ggrGYMKf3f+Cdwn7SVGeAPE7U0p3GDBGI6yRO5CVRd?=
 =?us-ascii?Q?uUEePqPyn5FnJYgtOqq9iTIfoXU6LkbSKJ3eKoHg7LCBACskwkg6YTIlgXny?=
 =?us-ascii?Q?yoqZkO2HPRN/A8YfEVJNl6mhACTI1Aj6wrTMvUiKFG+oyICNbyZ0xeUvXBn9?=
 =?us-ascii?Q?jpdKYtsmMGtnUQ5F5KmgrTnO0SGawz6adTejX6qS24Ul6EODHCqC/T+jQZ2s?=
 =?us-ascii?Q?rPaKrxBuBxbXCYrzD6lRJQxlR/YCluuFQDswkNfi/ILa398J4N32PxNB7e7B?=
 =?us-ascii?Q?CNIs7M5nRpO90Yl4xqczH8SDU8TBIT+5KjGUOARz6kn5F6S7T6PCJ+t9ALdv?=
 =?us-ascii?Q?hqownZQ1N+pmNMFe3tcJ3ajkVOWVkS2Mm4IkWr0L1w2WN10wXhmAI4QI3FRb?=
 =?us-ascii?Q?IFn1W9+0RUMCEUZNVwhKshvPcyrLFdVONDY1D/n8w+1Rwoa9uMCmUXEuZUiH?=
 =?us-ascii?Q?nf0yReb0bL7Fe8tHT7LwhzOfgThWbRMD52EVNB1ULEZ3ApmuNzcZBg9iNYsu?=
 =?us-ascii?Q?q1LTL7PfXGzEzsA64e6g9oDj2h/iJx1goRxR/MP29FO5YCxv9fwC8te47yBF?=
 =?us-ascii?Q?WlnTqPp3kAu/JzcDXYCyU9sK+IqIGmj1PaYWOz3Cz0TPdPvfp2htIvKennw0?=
 =?us-ascii?Q?JlK0CFx36qgidQJqsrs/NLZDIR7uxqqYkITZcHy5o0ny2W3yIttda/l2ZMHG?=
 =?us-ascii?Q?kQ6wz9Ar8Gk4nkVniF5Ep5zFcgYa1ClBrnKWiRCRw8TDTOE06hldyYP5CYsJ?=
 =?us-ascii?Q?iML+L4xo3SGqYN9bVfsGhtwPJFmjZMOdRtVxVszDxM5YQbG6ATLOANbFIDyY?=
 =?us-ascii?Q?MEUPuJ8JKmTBzsyyyMd3Fd4xLuPV4XEgax7StKXmq5yXfSNFFUpr/2JTDmtn?=
 =?us-ascii?Q?qZRoXu+1Coaw4KApxbH3XJl9svZ6ga3vHgOC74rLzQHxXbKbT7v8BtzHV370?=
 =?us-ascii?Q?EcFUN1ljCK52mrqt0PiqrHOhQHHih5gwZg+xBHtw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87179ae2-d4da-4fbe-2314-08dc74bc2300
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 08:50:56.9554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lxme8ERbAZQgiZN+kIpnF4FyydbaKFx1JgspRrNhAiwTuhWso6dFTk+fIulUCq9yNGxM8uruW9GRWoopl1PE6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6918
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, April 30, 2024 10:57 PM
>
> @@ -227,7 +233,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx
> *ictx,
>  	refcount_inc(&parent->common.obj.users);
>  	hwpt_nested->parent =3D parent;
>=20
> -	hwpt->domain =3D ops->domain_alloc_user(idev->dev, flags,
> +	hwpt->domain =3D ops->domain_alloc_user(idev->dev, 0,
>  					      parent->common.domain,
> user_data);

it reads slightly better to clear the fault bit and still pass in flags.

> @@ -308,6 +314,19 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd
> *ucmd)
>  		goto out_put_pt;
>  	}
>=20
> +	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
> +		struct iommufd_fault *fault;
> +
> +		fault =3D iommufd_get_fault(ucmd, cmd->fault_id);
> +		if (IS_ERR(fault)) {
> +			rc =3D PTR_ERR(fault);
> +			goto out_hwpt;
> +		}
> +		hwpt->fault =3D fault;
> +		hwpt->domain->iopf_handler =3D iommufd_fault_iopf_handler;
> +		hwpt->domain->fault_data =3D hwpt;
> +	}

this is nesting specific. why not moving it to the nested_alloc()?
