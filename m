Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611022CA5
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 00:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720571534; cv=fail; b=uftF9xGfC9uC62ST5NQgUadY/AZeNjQrZ0pHtn2GKNivtqk9o9Kdd2d0I/OtegiHYsd9pNxUodeFJ3pRvaGv73S+ZkLLpEdmtMdwqEzm2mNYtFTLlAYdUqZmj36nxBFl13+sMVVTAgqRfUxwF9lIOq9IFcddf6COGKYSQNTyQYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720571534; c=relaxed/simple;
	bh=Umhpm8Mugh5y0ETGTq/8RDjzDX2FcSrUgfCHBGZUx6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T07kg4lwc8F5g3lrUEZQ5PT6KRCe3CT43d8b3RGHE2PZzNHwwRfv50YB1lHEv67jUrlXYeOKhgmEQD01/1OSstx8JABVN44JazwJ4KX5JthHrdCVrV0ehVkW/9SMTSEDjqQWd+wbQbYp8sThIyZ0n2vDa/Ai2x/azM23ELbygFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O02nHhWq; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O02nHhWq"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0776881EFB
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 00:32:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3XU6jET_z6cJ for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Jul 2024 00:32:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.15; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C70C981EF8
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C70C981EF8
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O02nHhWq
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C70C981EF8
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 00:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720571532; x=1752107532;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Umhpm8Mugh5y0ETGTq/8RDjzDX2FcSrUgfCHBGZUx6Y=;
  b=O02nHhWqpcz/TH0EtIvFQ0EXCCsFZgjHmdrYkZNIylEAFnmuRy0ZSIkQ
   AxDYaTVKE5TfB5VIbmpqCI2H9x98oCemmAG7baZHMTGfVMBcvWHkA+D9N
   CxoMrj+JLN20f9BAca5pTDuEAIB01s9hFCciSewlifiP8rJPjSL8HeyCT
   VukmcwcxwsoBwV8MeJxUP1DBAZcDv0q8Sor2EqCdCVZc8fLQXaZ/aDizg
   FOtXSH5M87dFteeddymqZvTvgkbB8CmQPWkHdfgIao0ZxUMK/PkiqwQKR
   av9ZEQAkxZlU96GFOjxKh+og+0U1d69bxsWAUqmXqfE0X/F5ucPWAqd/h
   Q==;
X-CSE-ConnectionGUID: qI0mS+TtQk2X0n950yuewQ==
X-CSE-MsgGUID: 3F439XqvS4eqZHtqv1C65g==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="18008270"
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="18008270"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 17:32:10 -0700
X-CSE-ConnectionGUID: mG4ZGT0ITIqPxna9wggxEg==
X-CSE-MsgGUID: WgN7o8g7Qc2Rgi+UGwOAHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="48116308"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 17:32:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 17:32:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 17:32:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 17:32:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 17:32:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9x8S0J5vz3iBxoM/oPhGp9wBrbF3kel6/PEl1mGtJg9ENtFJiJkjENfVG6EIPWHHxRIcuHY0wvpONY75Wl21Di9NDYQixA6lb1Fn79y5MWOP3Gd6SaXarO0ozPjNFefN5cX75TT/nYiAVlBjKXd6PW8VkUdlplOcGgH4hACjuLyQD6FNeyJGZq/LeN6ZW9faLjyU9wYHHpIEgSvIqtyB3OdLrJToJ7u31VFEPj6H4Act+pb73SDy94waR7xLzDpKBjryOzQGPxpxxgg8v3jf7ufpk/OK1rAlCBqXsn9mokUx/2icagI49vjJNkogqpboolLvjDiYRu0rFB0j9Y6xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2VIzas0ncu+zVsS+yraPevbsw6h+RE6MHT9yQDJlZg=;
 b=XhLphsiMfA/IdtC72pZaJPknYSjNJe4ZogxhVMMFjR3sBYZY52P0Pse2VfL4Gjpjda6veAEiGhcMHjYKi6eTLSuQH8bzOCIhX8oQAbUOotXdX8MzpLRVc/jmC8vkrSlNX2kVWONI36UnJx6LadCVZaHAsNORI9H3Afxsh7PIzcU9HVvwzTEDYqH0U3tHefihh0IPLlPAOvgLnx7H/J7tDBlanHuHY29u1BQ9Oc6yXCmciG4MUMIx0mBmqRbKYTKO+mWzyU+tm4HHNurzMocn5KECfffq49VcAx5/f3GNA0tWIWfoCjTbDc93BI+0GTwByiFgfaT/QjR6BdqQWS/2qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV8PR11MB8535.namprd11.prod.outlook.com (2603:10b6:408:1ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 00:32:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 00:32:06 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Baolu Lu <baolu.lu@linux.intel.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "Joel
 Granados" <j.granados@samsung.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Thread-Topic: [PATCH v7 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Thread-Index: AQHav7SBiEC27YZjOUCt1N8SZ78aRrHdwb6AgAO1UgCADVangIAAcnSA
Date: Wed, 10 Jul 2024 00:32:06 +0000
Message-ID: <BN9PR11MB5276C7E6D55C93D2EB987C1B8CA42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-8-baolu.lu@linux.intel.com>
 <Zn8oZ80p0p1bHgBC@ziepe.ca>
 <7421b923-0bd6-4c9d-81e6-07d954085171@linux.intel.com>
 <20240709173643.GI14050@ziepe.ca>
In-Reply-To: <20240709173643.GI14050@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV8PR11MB8535:EE_
x-ms-office365-filtering-correlation-id: 5c502348-8d16-4454-a95e-08dca077ba3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?uc3YBPHlzWEl2V33B+LvlYVxY/zxxlhECv8nTYbp3q5WbnpN59cZwew489H+?=
 =?us-ascii?Q?7XiUGpmj8KB+3F2sX+iyyGDYtIeBpcZMSaZ5/0fWxpvcXlQ0FwM/TqK497eG?=
 =?us-ascii?Q?THx7vK2JyKvVbJm0vccuXjdUjZsUH2b/ZVEhzOTYJm073pp0hhytSauattP7?=
 =?us-ascii?Q?R914K80wgn33dSBsXm9MdAByXLtoFkckfTnICzX7OLxw84E5pvXCCQSrBsyx?=
 =?us-ascii?Q?dLwRJism0v9KjmeGnqWIpOw23TxnjbdrDjrpowb3jxkpzA8CRIbDYypE/grg?=
 =?us-ascii?Q?IHqN/j9i59Pox3Z6Nrhrd29IgYCh/hR5UfjhTraGvJ4XWMUK+fgzFM6x/qPa?=
 =?us-ascii?Q?vkqpCA4PQaG0HQZUgwwOvJxX39NT6ruYQDsiJTge/k24AuqrTavW+S45l1zI?=
 =?us-ascii?Q?por9h+hgfySWhvN64iey54wLluQrjhlsvZNVa9Jnn7eUXEJ1XEU/micArWey?=
 =?us-ascii?Q?dftH8ponlg3XsKMBgaXowxKVSY/eB4e5oLDvQKtPOKn35a7tcFLsuk89GAa1?=
 =?us-ascii?Q?UvFDIu41jr+jIEpf36Xp24F9h14ZWHAKMs5I0kbjdxJ2HboAqpAU9rknIfvP?=
 =?us-ascii?Q?JBlTEIrZC1LchATkn/s+LOr/yr5g44Y9rc47WC3y/WhLVKJIn7B+/fJQt93o?=
 =?us-ascii?Q?7Uec2m5OqablKyL1E8TlBGfmDnR860i7kSdfYFiveN63foWT8MBQbTQLy9/y?=
 =?us-ascii?Q?swjHt+i8Gq1vX5A+YZgabqJHPPDhTf1X7vvjT5zcIb0GhMyCoE8K92jJLEWW?=
 =?us-ascii?Q?pGXFBSeBmedNyo9VvA27nMTHEhHlekD8uLLC3VeHN7swt5WdJExMf+e0xkGa?=
 =?us-ascii?Q?ZEskaT1UTUWoV6fGAuhLZS5B5yf7gCSxTGwUxdBqBSH+nhcgYfbICq4woy1d?=
 =?us-ascii?Q?qJsMpRXNwUAk3lDKciSGWZzTDggO6wA37jgj63idX+lBUjc71P8BW69ecmPq?=
 =?us-ascii?Q?RNW39rLbZkLddw92E7Nj+dfAmbHIaWqBLenl61o0tc2y2TXwgzKCZX5mdcNY?=
 =?us-ascii?Q?RMZmbdwqwsALiRwCxBiTcuarJ/Yxdy4vo+BKyWIK4oVkx8TwecGoZHuKp8un?=
 =?us-ascii?Q?xDPV244x4SfkVrYdDmhxsDi8wqYeKJFXdrRG8ywOW/Ia0Qn8MiQBM94KXeC0?=
 =?us-ascii?Q?q4zX+ERA7+ZHSOZYcqxFbfDoKRMRHM/BcbvuUX0Qb7kc/uFTUkyRRRFa0NBb?=
 =?us-ascii?Q?XtbpgOBY006RO1MjInviO5wEv5Ro9Chv+syd1+XxspN3NxvivTqNL3q+Kvvn?=
 =?us-ascii?Q?5d2aKpbQ1BteS4bNgzUIydcnNY8DMNsTKZSSCbshjXZvT3TVqW/Sm/H7u+d7?=
 =?us-ascii?Q?8hMOonQp1LhefVpEcus59ka/1M1wl1yHuyQNjVcseEJlFrQ1JKrfCFCT03et?=
 =?us-ascii?Q?0QYq5zHp/9U/4a/49lz6wC7tmHWRMgf1tFMBPh9GEWs5Nfvpaw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9Z9Of+IbgWhjmW6aYVtlp+jMamJit6T1eWlwYue3c7iRzu7KDUZ+8ihrMn3+?=
 =?us-ascii?Q?0MamrBYENESNRNbRCJTqyZw1W/D0KZaJPM4UbXVuWcy5wXbMhF1uH2+FQMTY?=
 =?us-ascii?Q?lI+jvDvyL+sVB4/1whRgqSDDco4bScxRIKN78+uoFUYz4Z+v2FJS+QxBhHov?=
 =?us-ascii?Q?6uFqx0wmfwn8BFzXCr6cRP+Oxla3eSVAtgG5BbJHmHUJBQ2EIYqajUvZKopF?=
 =?us-ascii?Q?6WmS1BOA9KHZEzF1oHq3gFNo1z8mS1aqXLqxtRmSl55zBXratn1VFi7ZVoaX?=
 =?us-ascii?Q?tC4c+3v8liSrC+Wp4aa82QV2Jcf7no+CW9OljQ3za7YpZilJV7mUV2KAGug2?=
 =?us-ascii?Q?e/ZV9lzFrL0bNH4b+uLDc92mbmZDmSFZwZ3vZUJ2iXOUeWMZWSTkZt6Rac78?=
 =?us-ascii?Q?45Zz4MvJvlbg17KQcGovpBpvpiD1y6a7hNOlKUAsaK8W02+4GBCATwqIvjS2?=
 =?us-ascii?Q?hrdq3HilatxZfoyzc8Y59rihtGf4VuBcVAmlP6phzcuU6P+GaQc4ywnoxr+W?=
 =?us-ascii?Q?uj/TenI/jxtdkzFFg5AiJmqT+rUTqcCPAOA/xDfEvFN0uo/yfzefUrSPwK5v?=
 =?us-ascii?Q?ozUmHHmeSjmCoDn1j1FymDW02YqxxFmf0Uy4p8smQi4HKfXiTdtWSoIdYr45?=
 =?us-ascii?Q?7wpwnpGVDJ0A+ce1N9vfmBqse7Md/neyHoYBfzBRH1Lj8dRXn+g3iIKVLMI/?=
 =?us-ascii?Q?VpNEyTpq1fGbBhDLkLAj5BWaC6IDapF4M476Oo8Sis649aXKcUZijeA6ZE56?=
 =?us-ascii?Q?ZzV83504luL/Q7WbLUg1ASuWMnQvRHJxsnVDLCLrCXjSWMQbnqG19U5Xy7/w?=
 =?us-ascii?Q?2AB6X8T7PpA0aIUcOG4eKvVnjlOY6gL12BnZjXbhk9JfhVtcXOqXBfR3FCnW?=
 =?us-ascii?Q?bPHzRe7I53Wi7Jotuc2dpXM4LaNwqynXfYYS95Zv8nxTlh2yECWgenV9zw8z?=
 =?us-ascii?Q?yBGgIHD/r5tZEENY7xUWX1+4ZDOmSycDOOqn5g3IJne0hYVI14Lz6TvhLejH?=
 =?us-ascii?Q?Mtiv62eCp+RKuQDINKEa/3aA7sAl8ghuL+uyljMlzCJNVFRRAj2KSQ9l4p+m?=
 =?us-ascii?Q?8Y2VcHI4UAHsDm+ifXdPlztWJ09jj6rRp8kfghwKk82tSs5X8R1i8mqae5oP?=
 =?us-ascii?Q?GzJlVeKkXnp9+9tfgOByMZbSND+dAYMzq1a2yC8mdn+CssfXpziZ1yHm6SI9?=
 =?us-ascii?Q?MrT/nyKvMmvpJ3AWFB6lSRte/tA+bfv/u1QaBVDZv1zRLZxmyjS92RfpxGVB?=
 =?us-ascii?Q?z6oHW7RG+55LYkt//Q5Y2rpAX/6F8KIJKbl/5tDEDmBcZB9S0BrFeUl+mmR5?=
 =?us-ascii?Q?vvkyRveKmoQ8BUpbbOsvOhz39dcpjC5JGAPXZwNwavGY+9r4XL2C2NziZZWJ?=
 =?us-ascii?Q?+kPE5wcIo9lnD0LTx+rmyJcH5iHmmn1X49+WfYH2D77aj37ldR5Jh+PmnXPT?=
 =?us-ascii?Q?u3oS+LZtV3tnNxVIEPfEBJw6oJwRBh0THHUBnVWkfgFgqlLM3OCxkiofDb5G?=
 =?us-ascii?Q?0QFLMorCsJLKqTxH5yv4h4wXBguiYhLLGIq/NWp8va4uAuIulFonboddShPk?=
 =?us-ascii?Q?4Ls/r6VZOmX3EpifzFAYUKH04297yDeY7c8lpaS/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c502348-8d16-4454-a95e-08dca077ba3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 00:32:06.5658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ak+wom/ff/MTwo2Wfqlf9GRx6nzFwYMs6kwlmWxzeSsoWPOezJExf3BAPHNq2IxvjnB3iwBEeG86OPF+jmVNzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8535
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Wednesday, July 10, 2024 1:37 AM
>=20
> On Mon, Jul 01, 2024 at 01:55:12PM +0800, Baolu Lu wrote:
> > On 2024/6/29 5:17, Jason Gunthorpe wrote:
> > > On Sun, Jun 16, 2024 at 02:11:52PM +0800, Lu Baolu wrote:
> > > > +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> > > > +{
> > > > +	struct device *dev =3D idev->dev;
> > > > +	int ret;
> > > > +
> > > > +	/*
> > > > +	 * Once we turn on PCI/PRI support for VF, the response failure c=
ode
> > > > +	 * should not be forwarded to the hardware due to PRI being a
> shared
> > > > +	 * resource between PF and VFs. There is no coordination for this
> > > > +	 * shared capability. This waits for a vPRI reset to recover.
> > > > +	 */
> > > > +	if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> > > > +		return -EINVAL;
> > > I don't quite get this remark, isn't not supporting PRI on VFs kind o=
f
> > > useless? What is the story here?
> >
> > This remark is trying to explain why attaching an iopf-capable hwpt to =
a
> > VF is not supported for now. The PCI sepc (section 10.4.2.1) states tha=
t
> > a response failure will disable the PRI on the function. But for PF/VF
> > case, the PRI is a shared resource, therefore a response failure on a V=
F
> > might cause iopf on other VFs to malfunction. So, we start from simple
> > by not allowing it.
>=20
> You are talking about IOMMU_PAGE_RESP_FAILURE ?
>=20
> But this is bad already, something like SVA could trigger
> IOMMU_PAGE_RESP_FAILURE on a VF without iommufd today. Due to
> memory
> allocation failure in iommu_report_device_fault()
>=20
> And then we pass in code from userspace and blindly cast it to
> enum iommu_page_response_code ?
>=20
> Probably we should just only support
> IOMMU_PAGE_RESP_SUCCESS/INVALID
> from userspace and block FAILURE entirely. Probably the VMM should
> emulate FAILURE by disabling PRI on by changing to a non PRI domain.
>=20

Agree. The definition of response failure is same as disabling the PRI
interface and requires re-enablement of PRI to recover. Using domain
switch can naturally leverage future fix on coordinating PRI enable/disable
between PF/VF.
