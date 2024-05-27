Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7D01FAA
	for <virtualization@lists.linux-foundation.org>; Mon, 27 May 2024 01:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716773612; cv=fail; b=ajOa0cWOqfZlL/k/WkvQkoUMnICw4xqFOi5uPhqQwHluJIDsQjECAygCBpMBQ33EHYr+aa8m/u9gVDE7vPlRRTQ13zSWvMYGR5DTz3Tp0knlME7F/v1GG46HtD1kwY/OiFHyWZQXZrVBF/dKnzApMB4C8s36hLDjaqK40EFVQmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716773612; c=relaxed/simple;
	bh=DjOcb3Ni5Fn/khH2/LRcI5XrXv4dSU1O90m7MTYzDDA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gb4Ma8I8h4+rXtdw+J3j+EwGh5ZymnoyPh7YlEsXC2Z5lIEPu9vrxwHp06vVvuGJGPO6uO6yfPd5L1qBvcF65zxg70vxOkKvtUcQD2gtUrLLLlpQo+Lh9uNvtYFezEgS/GLrMvt3woU7pTKuR5yg647wfyYCWIGhsEMwnxvBMWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dzt6qqby; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dzt6qqby"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7206281E86
	for <virtualization@lists.linux-foundation.org>; Mon, 27 May 2024 01:33:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FChMJ3V2V2nW for <virtualization@lists.linux-foundation.org>;
 Mon, 27 May 2024 01:33:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 89A7281E85
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 89A7281E85
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dzt6qqby
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 89A7281E85
	for <virtualization@lists.linux-foundation.org>; Mon, 27 May 2024 01:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716773610; x=1748309610;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DjOcb3Ni5Fn/khH2/LRcI5XrXv4dSU1O90m7MTYzDDA=;
  b=dzt6qqbyD4T0bR5QJGpeGKm7elFwCceC4Rba2D3iDG333t23zkorT+Q4
   o5H17FkUP/gH4Hj4elBD6SdLN5x7mrXrW+ijvPDTrPX3s5Udb5D475nAX
   V24aMgDQouJTK86BtJ5gi7gBRMKzi9oCGXO+SsP2OKiDdont5uuyFqUy6
   AKWSzTj87e5GUgzn3N1AZuZZRfaz237L82NZF8r3wS99E3tJ8LXzRXiEC
   /KRL/nQJG2FLPrFWZL817uhUXzXB+c2kb9MndX+IHqULeJaFhZGlI85lS
   AMwjxrFTVIJKf5BsDBOh1VpgqdQmi9y6d2SeQsKQKugkjcnoNHQy1+mAU
   Q==;
X-CSE-ConnectionGUID: CipeS7bZQwC7hS3uHVJ+ug==
X-CSE-MsgGUID: S4pJ6tmESd6IAHCsbKa9DQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="30584147"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="30584147"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 18:33:29 -0700
X-CSE-ConnectionGUID: DOY226fnRRydW3fdhz29aA==
X-CSE-MsgGUID: xr+HZFpHTyiJF38O1FpLUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="35073623"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 May 2024 18:33:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 26 May 2024 18:33:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 26 May 2024 18:33:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 26 May 2024 18:33:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 26 May 2024 18:33:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkMwplWrCwQjFwSB/A6zf+Aj7CfGnMcZqOp7agqTARcCqpq+/GKx8rp/pAxfaU4E6uV8RsUMzQf6rzfWgOhEFah8QneCc6/IocyS5cnNbVxbcNKU2w4Zd98APERp/V2TMcYz6GgH1bZ1n2ulPnmI9r231X0ZT5Czwz+fnPr+GoYjapw5E3Zz6UmDF+0Tk1OqhQt9K7p5t4DYwBqi19J7qRP0mJZ3iGeHb24m/AB4dY9cgo/RlwtelbVq07H8QOV756KXxmfhfevh/ybu86vVLMnWkqkoqvHBmlfDi/KgV5Vnkft9Z9aOHh38Q2Fkz6PbCIMlyJjTskAzS1nUrRPN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/eIBD1f6KLtag0skgg0W+mToTWABaMFhL3ir8yga4Q=;
 b=O8HS8naQb1vnbLHtjuuTSmi3DC2PfRQGeI3nGOmQo+4fKi+obRSG4t4esVIiFZ3i1L+nVlauBltUjQnK038laYKr/ud8AiYmluco0Ep4HD8LS6ASH8AArDKwGWo4VQwfj9reGW28FSeYYf0NjxQ6Xag4HkKwUdegPBUogVTVo5a9RB2WNJZSue8/fjUyGawJ5u5yupbOQi0uyvlPNUWI9NWmYi/u5nDEak+BR1BV2q5fRt2GzU/K/OSRvIJiexaLPzT8Rislvp/mzO9Ki5PA50N46/NYVwgRD7HnMfL92Lee8y5Ktdka8ySvt8Ze8PmciUEnh7FiYoxKAvyBvnfS5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7797.namprd11.prod.outlook.com (2603:10b6:930:76::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 01:33:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 01:33:25 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Jean-Philippe Brucker" <jean-philippe@linaro.org>, Nicolin Chen
	<nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>, "Joel Granados" <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 7/9] iommufd: Associate fault object with
 iommufd_hw_pgtable
Thread-Topic: [PATCH v5 7/9] iommufd: Associate fault object with
 iommufd_hw_pgtable
Thread-Index: AQHamw8P/6/4oit4lU2Ra006NwpZoLGYE2jAgAduk4CAABV6kIAG/q0AgAPevJA=
Date: Mon, 27 May 2024 01:33:25 +0000
Message-ID: <BN9PR11MB527647FF053E249E27F4B43C8CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276A8E898983310B83C399E8CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <b09f96db-8451-4de9-81c5-312cffdfd4fc@linux.intel.com>
 <BN9PR11MB5276F07A130CD617777A3AAD8CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240524142446.GP69273@ziepe.ca>
In-Reply-To: <20240524142446.GP69273@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7797:EE_
x-ms-office365-filtering-correlation-id: 713340d9-bc54-4255-c22e-08dc7ded00a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?IBSRy6f/ZxuBEs3gVHkau+Iq0GK4ZPLFp3IvM9UGaeLRFUFcTzVFfATnEqFh?=
 =?us-ascii?Q?b6Gf7VgEGmKIflbAPdN7B7+oxBCQ9gXfPi4b/oZEXD0eJ9QmAAWXZ5npFfh6?=
 =?us-ascii?Q?l9VXrxaMIdXpYOnJHlAvoqD+bIOJ2Y5Y3fmccnDVajE9tVU9p3iyHpIOKA+2?=
 =?us-ascii?Q?Fbwu8gKLVlfz8++D7bE/WQevJf7L2kRtHigXG1TuUBHM7kp4M/0xqVi6rwkB?=
 =?us-ascii?Q?PUUcW6UR/Lmiwoj6OUvebt3KG5UkXMZ1CJEFB0Jj3CEVZlMSVmvVLV8/DA4J?=
 =?us-ascii?Q?D2NxDkVxr8aEnZSmXulveqiXJYg6qhglY2hP7BanNoaQ3nRKVuX6eZoMHfOh?=
 =?us-ascii?Q?dUKn0r5T46CrKv9QtEL3SYJjSYxBoB/GOfxVj+53NknQ5gS2LrGDdFiHPmJ/?=
 =?us-ascii?Q?GUpfSMfdIklUvKHe8QU7hax+NWUtuOV3euiW/Jo3YGb+LRbsopL9Y1aQ6PNj?=
 =?us-ascii?Q?qRJYLaAytKcPPyy73u93MUc355qacbJoPOdNlbFI9+c1C1t3rZIiYc9jlc0Q?=
 =?us-ascii?Q?nOuqUOYyNy93i5VZHWqNMiKu7SqsZ89MQLVLgpU6b/dC8nQytIHTmkQUDe9Q?=
 =?us-ascii?Q?ZxCbIstO5Ewe+6fvrciVMdT3XP5P23vA37CipIqQAceEl3r5pIv/HmrXShwO?=
 =?us-ascii?Q?FlGFLYZBz9xqMFN2Du7dJ8g6NAJf/smRW0qeNrq5pcF8gzB0F0CmfVockLL7?=
 =?us-ascii?Q?S0PBUOZvIxDYF70e15kCiv2AwGpO4sgs/ujKo/9KNDHJ6eG5QFH1odpxd3S8?=
 =?us-ascii?Q?I6S1+VXlkEvmq5AXLVGaMvLmc/25Yzy2sGvmP8x596tWVH5bnGr07dYCmRqZ?=
 =?us-ascii?Q?pU299kx/0BcZO4rzZMPrORII/Pv4lbl0IYzTZumexcN7VoHPDB8stQAPbuu1?=
 =?us-ascii?Q?hCajPjAq9slWh1jf1uaenBK3jdMpIOfGmLDFk2vtRDpiYysoeTepnnt2HIcp?=
 =?us-ascii?Q?LIaQmZ2PrKxdEPsPPdi8PCj7I5Odw9FvEahFCh0/ly/qSTRTwGrUwBMO0xSc?=
 =?us-ascii?Q?r65e9z2vgUbGtftskc3c8lx1FdXrFzvJbMSKcw8SswDeAMNC1Nj/ocWneRDu?=
 =?us-ascii?Q?bzHpxUGs933/1h+RoKqo8qx9ojweukjz5Hi5Zaks8qX0fiwNgiwNRGW/HDkm?=
 =?us-ascii?Q?haDeyNH+UPimoVIRySe/8nwHjAqr2fg3GcwgVhZ78JL8XLO2jcFERCvfcdu7?=
 =?us-ascii?Q?/TPk/rEOq9wxGC5vEvWuLjXJGxqn1BbZeLcSyFYgk4r2TqGYSll4lpkFxnqe?=
 =?us-ascii?Q?OxKTSCQE2CkyDJ8k+LQ+BmCJZW4etvGYZV2Kb58oRQJdzGCZb++WMtV7Nd39?=
 =?us-ascii?Q?WflVrdSV88mHR45I8rcFXGOzxUqQN+Fvf5xbbUurDNjULA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?trpj9adZJ3qOkBvVbU60QNM3w/967pmqN1B+7CB1fIDT4vLEa0YtLwxodru1?=
 =?us-ascii?Q?M6QFztDcSmQrp8MxYTCB7gvExDbatwL/jCDOAdU76Cza6xAoutWaGZ/UZQQU?=
 =?us-ascii?Q?r9xJNrFqmYHsh8aepOklP0pvlMDFhlQHn5o+1JgqVuYFUpzUgkjjbMC1c3mU?=
 =?us-ascii?Q?GcIGlMvuVQms/0TOCKA/j2FEbHt3fnbg6v9duFtOWaybCNN21DIvOL7oWDp1?=
 =?us-ascii?Q?xSRjRhfuzn0EY1T9eWvT7QD/BRNyWi4lbsEnId/CQU74jbLPYgBMdUGmt/Si?=
 =?us-ascii?Q?aDobTEJc5ilRxAst6rLCA3R6g7NmqusxtkdS+1xFeK9c29rO9eyzd7l8BKms?=
 =?us-ascii?Q?ZJCCquGSiLs6PiFhD2VjVsznYKmwpnsy89QQgtfNQgUYxKjAww6pJA6uB67J?=
 =?us-ascii?Q?t1R/RSgUY/HHCKzsziF2/S9aXAmvTNnaG0nUsVluZAMvsJSXJBbDb6c1qtew?=
 =?us-ascii?Q?iMw7wngqRi6odfE9GyqQqywc1+87hChJdy6UHpv+EXUmw8T7b0judxJFRPft?=
 =?us-ascii?Q?0V29GuJiRaQq3lFCPAIPvXqSpE3mTxPkD3laBYgGc1oM5nrA52TUuJJEDNam?=
 =?us-ascii?Q?WeTrEsDcbU++CoaW+yrlIO3aRp/A1gxkDcISR6kqAoY6UaMlmGAyoLvpNHq2?=
 =?us-ascii?Q?R+FsEYYSerdesdYVTyXSENEdZdGcxZVeKtF89YD2SiAH92bsB9cXz4tNIBRJ?=
 =?us-ascii?Q?KcP1ZNzqgERLOSZPNiOtzqdZo9h7CtNrRUkVWjMu4U3FLBiWUFXAwnZzsFbw?=
 =?us-ascii?Q?Jb/d3XSRvJYQlQq31fzRuD6iink065hzL7s7jSqQWm+fObXH4ab0V/Daivt2?=
 =?us-ascii?Q?Jlz/dknr5Glb18KYwRIbd9hlLn913G9Sz/cvO00BRxympQti0qeQR8RbL/AY?=
 =?us-ascii?Q?RVpPKRIEVIRE3NJKZPeyS5Y45tupvbdLUMILX+i8rAWexGGdLaKJPNLt1fon?=
 =?us-ascii?Q?pvQa7jiWMMvA2rWOMsunv1wGZKneFmlZGSE5zTRf4jkyf+cBveU6nK3eVCU4?=
 =?us-ascii?Q?0A8WDbVuEqOZvk38TNXR87vBUu3mP050K0Up2vOS6i/IzrkZo+gqYVuv2447?=
 =?us-ascii?Q?VhpC6icXYW2mPUOBmihGhRNtnSjRTvuxluTQ4YwYDZ5Bpwnnot2pXLh0QLrE?=
 =?us-ascii?Q?/1PSuqMa9nvIG92QBj+s++p66OQLj5Jmg2guoEvd+vkuTiAp+thZkAjir93T?=
 =?us-ascii?Q?VTjP0lLspevPnuFUdYOLTnUXvK5QV/ExDyRVT6gLcUEYWgfjXm0FPWzp2Ap7?=
 =?us-ascii?Q?YYx4l91TT7Q5cRpE2znwdEyuHQqWi2x+sxvOg7IjFbxHAA4Cfc3rbi6+XCWN?=
 =?us-ascii?Q?wXrqg3q+6Qv7RKB43u27RuhfQbeTiZGmNJan6XB+rYhKh0HB2z3QLTRBQqWw?=
 =?us-ascii?Q?8qvn4G5buTlvPuhTbPOlxd/UZJM1qoV5lW255M8/qyV3FW1FOCYdXjW52/R8?=
 =?us-ascii?Q?PBOluVd3A0L+zUcHlK3PMolKn+KqdYTN/4N5Vg6SzfAguef2eFZZI3aqKrFI?=
 =?us-ascii?Q?6eL8uUuDP693lsDiBPfbxgtRnYXKACU3BjmOPBR6QjAs4KaFj14wl2LZY4N+?=
 =?us-ascii?Q?Aookeg+kDXFNFdYJnqxs5QaGHxM8lnKxtCjJqhUl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 713340d9-bc54-4255-c22e-08dc7ded00a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 01:33:25.1389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gReQcsJeb1mkurM7pxij3u62asW0MpOe6FZ5uRO8ByfxftujLACL6wxpMwj0ShFHoaONlzSSbN3cQBPkM1hs7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7797
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Friday, May 24, 2024 10:25 PM
>=20
> On Mon, May 20, 2024 at 03:39:54AM +0000, Tian, Kevin wrote:
> > > From: Baolu Lu <baolu.lu@linux.intel.com>
> > > Sent: Monday, May 20, 2024 10:19 AM
> > >
> > > On 5/15/24 4:50 PM, Tian, Kevin wrote:
> > > >> From: Lu Baolu <baolu.lu@linux.intel.com>
> > > >> Sent: Tuesday, April 30, 2024 10:57 PM
> > > >>
> > > >> @@ -308,6 +314,19 @@ int iommufd_hwpt_alloc(struct
> iommufd_ucmd
> > > >> *ucmd)
> > > >>   		goto out_put_pt;
> > > >>   	}
> > > >>
> > > >> +	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
> > > >> +		struct iommufd_fault *fault;
> > > >> +
> > > >> +		fault =3D iommufd_get_fault(ucmd, cmd->fault_id);
> > > >> +		if (IS_ERR(fault)) {
> > > >> +			rc =3D PTR_ERR(fault);
> > > >> +			goto out_hwpt;
> > > >> +		}
> > > >> +		hwpt->fault =3D fault;
> > > >> +		hwpt->domain->iopf_handler =3D iommufd_fault_iopf_handler;
> > > >> +		hwpt->domain->fault_data =3D hwpt;
> > > >> +	}
> > > >
> > > > this is nesting specific. why not moving it to the nested_alloc()?
> > >
> > > Nesting is currently a use case for userspace I/O page faults, but th=
is
> > > design should be general enough to support other scenarios as well.
> >
> > Do we allow user page table w/o nesting?
> >
> > What would be a scenario in which the user doesn't manage the
> > page table but still want to handle the I/O page fault? The fault
> > should always be delivered to the owner managing the page table...
>=20
> userspace always manages the page table, either it updates the IOPTE
> directly in a nest or it calls iommufd map operations.
>=20
> Ideally the driver will allow PRI on normal cases, although it will
> probably never be used.
>=20

But now it's done in a half way.

valid_flags in normal cases doesn't accept a fault ID. but we then
handle the fault ID flag generally above.

I'd like to see a consistent message throughout the path.=20
