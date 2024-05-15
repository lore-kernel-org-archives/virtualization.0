Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370E243AD2
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 07:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758100; cv=fail; b=jJY9StX16vKAIAAkbsm5b9pklg4YbB19RKUUSAoJRGN/X8I2LiJJSLUybSvxVH51J0XH29aMRB9nOwdmwWS4ebjIEDHluvR1PoNkx494UmrPSIuthaWSaUBUKBU+/P8wnR0/XlSUYcW53BEopi7vt/p5iXN3s7h/ywtpaCAyDjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758100; c=relaxed/simple;
	bh=Wuid5a87cIrBYTEdBUF83RWnCmffcRghFxtmayqq7qw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Omy61RywdWgoYIHrISqYdf9S+vINSmEyb0EBHngge9inqd9Xru1LtvwiuiANgiKSDbnWk4nGfrJbMYLzlmTKJ6DiQ2KtqcGehePqSoW95ZR/4L88PDtOXfW3Zwykjns3ZttG5MOXGFUHH2ydQZ2mrCfJ6cT0jyHlewMcKkBaXNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aQK/SIuA; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aQK/SIuA"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BBE1440B1F
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 07:28:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VjWzkgKy7RvN for <virtualization@lists.linux-foundation.org>;
 Wed, 15 May 2024 07:28:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3A809405E2
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A809405E2
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aQK/SIuA
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3A809405E2
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 07:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715758097; x=1747294097;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wuid5a87cIrBYTEdBUF83RWnCmffcRghFxtmayqq7qw=;
  b=aQK/SIuAXTFUj/yWBhqNuAJujbfhCueu9yJo1z3EG9NlXgOL2B2e8DU7
   P1aUiX+TGQaV/V5sE9rraOyRXhWWPtUIbFDc6VOU39ArE/Iho+OCnIhlQ
   FiqQywqLBapTGqpXJjQjGmOmreXM67a4+nhpRdRz7LJZTOZiE3rBiAgAF
   4V7cq7H+BrRZvuDq/rNnT9tZjoeGNSrU5qQ0d5QHbd1mo3XQhhwgULbMt
   oETngN8oTjjRUTdCDH8Pcom+DtpfRp7suMJPmZJr1nCasqBkq0bez7YfC
   G74Z9r3/zRCFPZoz2iPf61raQJX4tyQGcAXF+FOi9k9rEPgu5xK3/tQZv
   A==;
X-CSE-ConnectionGUID: sg/2oupORpiWke6k1YtiMg==
X-CSE-MsgGUID: lCKB52R7RziAGK5eDro9lw==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11658789"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="11658789"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 00:28:15 -0700
X-CSE-ConnectionGUID: tqGGKUPGS0iR0xgUjxJfnA==
X-CSE-MsgGUID: m9e/Z2QhTN6JpbM8St8jgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="35655938"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 May 2024 00:28:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 00:28:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 00:28:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 15 May 2024 00:28:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 00:28:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pnhixu/f0DDHPhMvOvo7MAf0f1/ki8U2dEFKRLsdbJEWzRYHxz9USEtIXoJQ8PXSPyLJWO2OMs9nU3Z9fYHM2CLrR0xe1ymt9WaGjUnYtGRnctNjULQ2trIKFuJaZlJOCgsKv+Fcj8IQGsGejVS63femECppWNNtDhWdO98CB8qP0hkaXUizudWs8Vu/M2+Xv78essyAoZvdHwaPqTHEl6zhtWd2RR6duFEjnX6gwEI/TkZOgBcSsdVl/KLDVee/BD60hD4y7kGHgVwGiw7L2hZwvXdq7byyBBhGxfp/sQQuGvep2vRgtHtnZvBE5BnOTyM7ekvXxzZMS3IdS1P/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LHhYdwf2SGw7WV+6ICNkNTuoNNI7CDRqK8b9X7A1fo=;
 b=gJyM74RL1WoBWEKsNaGJ5bK7tkRWG1FAU0uojSW+voCya6sEeqYG3D1oybtlVWhhlOSQV6Pk05ODJSLapU5vzBU/tqZxa3MWnZH5btyq7ixgTIMNxnb9J+VBsP2/RrHf22cK8uDqlR4VpwTciSGO5+xifyunZwhy4qZOs8RtIkNrterYqJ0tqM0gzBbpmqFK0VNwBurmaVFVY0bxLKD+l5GrwQjQ/bzyH1hrvLqeg07HQGUubE58fV6vw1hVJWuCsrpWcuN5cM4R7XqYpZhfrfi9tzbCH6UCjF/VK9Hkqkkm0NW9b+qzxePYls8OHLyqHx1ts9I6IbrZPo4uffcWDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB6615.namprd11.prod.outlook.com (2603:10b6:806:256::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 07:28:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 07:28:12 +0000
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
Subject: RE: [PATCH v5 3/9] iommu: Add attachment handle to struct iopf_group
Thread-Topic: [PATCH v5 3/9] iommu: Add attachment handle to struct iopf_group
Thread-Index: AQHamw8FRMPPYVB/4U+b9NV7aZfqhrGMgJcAgANZlwCAAK5cAIAADncAgAAhLQCAB0MjIA==
Date: Wed, 15 May 2024 07:28:12 +0000
Message-ID: <BN9PR11MB5276793FD24A0FA45B527F518CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-4-baolu.lu@linux.intel.com>
 <20240508000454.GM4718@ziepe.ca>
 <21ffbcc7-1103-4481-af14-5ee8856b9625@linux.intel.com>
 <20240510133824.GW4718@ziepe.ca>
 <0de7c71f-571a-4800-8f2b-9eda0c6b75de@linux.intel.com>
 <20240510162854.GY4718@ziepe.ca>
In-Reply-To: <20240510162854.GY4718@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB6615:EE_
x-ms-office365-filtering-correlation-id: 6ba231cb-cd91-4605-e067-08dc74b093b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?r5rBloSbI6l+f+Kh5kcMJHpTmmgV3Acx8J+Jklz3fIUuGZiKsoZ5QfRpsPjf?=
 =?us-ascii?Q?idfj5sOjIEffLEI5X5lc5DzC3mPkIopAh1sZUlHGoe3wwcMRR3iREPz/eME/?=
 =?us-ascii?Q?q1TzzS4xsYYIsRL0bvP+aGRMkXCKyPATwozL1PDRyuccWm5Q8E3PdwVzkXGe?=
 =?us-ascii?Q?SDD183A3UnHKTPVeAKIgwoXA/jne54E6vDmCRcB4lDQDkSInVcjyhU5uPOAP?=
 =?us-ascii?Q?YOcl2KQP9zTA8WVIYhpAoKhtPPwAsNsLDiWxzszAPP9T7t5hwDgxNWt7b+uJ?=
 =?us-ascii?Q?hxddAuN1l5FsjIYhO3/q0S3sl1jMzBJmYn4lOPW30zoyxvcUOxb5G/gEu6Pg?=
 =?us-ascii?Q?W1VhuGjsqykyRXD/VbHUujLlJIAwSpV9mDtmR13TkpvyVtkiKXsBHsQzrIZR?=
 =?us-ascii?Q?PWGvOKTZuhXeY6gvRNvNEP5h5qAC/ogC7ZQ5vy0C6oHLqReozzQfQ3ooSjie?=
 =?us-ascii?Q?xi1zvCxoQ7tgZq3eETnHPN76sOC4+Sdr1x2J0eOTwcJiCwtWNFCR/4w+jzZs?=
 =?us-ascii?Q?ZkuHfbWQGqKjj1Yf4FFhXQbBCtyKr3eZu+ep8jrJnmvbvzCd4qn90ujzL/Gz?=
 =?us-ascii?Q?fG8RKIni0UKGstQBatFlt9WEgJSrQUP9WDXCTjAEbDTdICdTe7gkvnkFqDSP?=
 =?us-ascii?Q?VctnVOcYKi1XFPflCnHnXinC7QXrDV52KpjwWMNgbvqM8o23k9vn8jYbUdrT?=
 =?us-ascii?Q?uSZXugUO0GNAhH3ATaeFnZs5AH60uraQocXX0kHwil3NXFvaEGrLbG3wa2x6?=
 =?us-ascii?Q?aBPohu7ZwAMcqhbCwwgNJvVLIa7FY+As5LaIpE/ED126NGOBUqeBz1eWI2vl?=
 =?us-ascii?Q?o10z23Ogq5fOoTff7N5M+LbxeYU62TlP1exsNMD5J+0PlWa7hgrvBsAyoKFQ?=
 =?us-ascii?Q?DWweIKbbTLpebt2JwirwCsxWhcj3c6kOpJWaFG5yJSbPKU87pMxLTNzFnDQd?=
 =?us-ascii?Q?YPq9/UF3n+k7lOEm/aWhVyhqn7BifS97qy69wuHxYVrTX6/bkKIUVDLnKOVx?=
 =?us-ascii?Q?u60epH0DFPbwvAs0cQpQytJWWzcqFn78bobyQhn0h9WbgmM2c+zQnH8aCUvB?=
 =?us-ascii?Q?+Q94RMjqYnJck0IVFd1yqx1R6RF7l7/4owOach7Ep1ZkFQvFHNRalCtZwcNx?=
 =?us-ascii?Q?WKqCegC8YZaNlwqGPDsXBKZCX8SQnQu+BzhiEHBhDP86RSXsbptzyZdHk+l8?=
 =?us-ascii?Q?byvsCj46zGLKR8adQx5IbKRnQFv6X+vdclC9D+RzJq12VY7uIj1/ohCbJ+7j?=
 =?us-ascii?Q?7V7Sl7SfZERLdqkXUD4rF25N9aOUq3MoNvsQJdMzc5e2Yc9WgqV9jusUdpgj?=
 =?us-ascii?Q?JhpRQEfJTcn4vkxtxjR2hJ65R2+W4wQApzZ5/qLzdDQKkQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OQ0EG6uSIeDhICxdw9v7OpNmOjVYx2dJxXFsVUwKd8Z6BXDtsxgaBeha5fiO?=
 =?us-ascii?Q?yNc/wewWgp1dXpfx+8H5v4nQgJzR5tB0dICKeYrh4D+UxS9Z9XB4whqCmZWu?=
 =?us-ascii?Q?W3iWdaMzVK5oJNWs4WPlsLV+3YGm0IweYlArVylRWN0cD70TtfTopMwPgU18?=
 =?us-ascii?Q?VbPK7C+et4goHKAB8h6ztSBP3+mNmuQI51hxMzaPZ0kMVSjsMoEKpF7zMiq5?=
 =?us-ascii?Q?Ap8S1SHO2bx0ecY63Ea7vAN6mSloZyjKWGX97Hstlbm7Wn4zgS+lSHZYbITA?=
 =?us-ascii?Q?CfDUVFnhX7+vmE0yxuzVpSyV5BpspcYF04TdedNRV1fT04r4q6KzzEsMgN0T?=
 =?us-ascii?Q?k8DTUWr0pmNsStgG1BLPTgc6bdHdpwxS8LZkvsBPPE0S4ctDytIEc6HF3aX3?=
 =?us-ascii?Q?Ra5Uvyo/lBgIevBfiiXIed2j8gdc6Lc4nHmR/RMEVZ6ZKJTlVvry+IIN0apv?=
 =?us-ascii?Q?tC34zPf4NcyNtH4psYzBdWI9VxNxFb1T41YJC0XWRpDo6PY9Di9zW2bQiJxS?=
 =?us-ascii?Q?WOQTfmyjqyiZaR4GUxfKcZty81v3e9kICAtall2XdurR+X1YI1RdYGNZKIIq?=
 =?us-ascii?Q?CBQauKZm3/WgHDkQpu780PJiAJtsyjlOG7FwMxtFsAZPVi3GgxB5pSiH5tMW?=
 =?us-ascii?Q?+w1BYT+DzCmXk5bAcju/iVyvkwKh48o/Qf7HZ3LEK5Evc4xazch1bHDFHAUl?=
 =?us-ascii?Q?zDmePiF9iDmZnzs7QXHqSwfmmxMMbSFNhYxG8x+Pg16zTFIoMW1VqgrwtRH0?=
 =?us-ascii?Q?+Vf3ZpKPFBKpUxfNzuiLLNJVtYorsCe9iuh0wm1g/XA8KukrdyTtAcEuTtnL?=
 =?us-ascii?Q?4b4E4CpXOWzmjf+V4hYs3T97mSDVvmci1Z0Dne+ETCmtZpdj8fapLWHfCP+3?=
 =?us-ascii?Q?2xAY6ox2U6DgetOXcNsgzG/NEDj46nVdm0gHrPBU2pIzVY7/uPcqasWQnLNQ?=
 =?us-ascii?Q?B1yFFADxRtj66s98pnVbUcotMmY7mtszeZuxiKPb+UYYIhBmzCpA5HAybL2B?=
 =?us-ascii?Q?SRpQzG4P3FlbUNWTrEelFhu6QGE9Tmp0xhaYkAg98zpxkZdRzquPZaSl8wIl?=
 =?us-ascii?Q?PgxiZ/QX2iVSPiPBHvLbq9QwJKymo34fJIfPLGMq1UD7XjyqV9w6nqWmzO6b?=
 =?us-ascii?Q?+g+7a69tLIkZaqOPKb6HzcTicbX3qwh9UdNRYEggjwuOqRR4/dr4T7HQb7+z?=
 =?us-ascii?Q?fpJILhOAqcSzOBuMwxEN7ybvVkwK6NYaB4irjjveFjWJ1z0znzzFbBdbDK/8?=
 =?us-ascii?Q?+66cwQzwZRSULc7SSBDt2TjoIqAk3R/qLBgXczBCboTX/ZFCfiueYodcjr3U?=
 =?us-ascii?Q?jQcZXp6HX2CfADi8RqvTRkLNSTdR8Jb5EACzrqQYbq9zucHaXsUE6ICn8ZTx?=
 =?us-ascii?Q?E50U4klIIXFIDVfiDxwMuG7dBUl5F1Q0dwi/j3y/4iws44v6wK90IbavaMxN?=
 =?us-ascii?Q?ogqgUa24SKyHUmHvmvd53Y5dMHvUhlzQKeF711IqBn+qIsYAblo5WgWjtkXr?=
 =?us-ascii?Q?Su+RmRZRXrYzn+60ekAPfQpgCJaTEVM8keV5BchzOSAKQ6wM7IwFDoF7Sq9w?=
 =?us-ascii?Q?37x37+l7c1wGoLMN7nNQRUgcaCXpTYyEzGKDZrua?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba231cb-cd91-4605-e067-08dc74b093b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:28:12.0663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mmz+ivEzzyNqLcdSua3oPHpWjM0Tf7s++6g2OnoMSnSL4yUiOJJPeBJSExubXgfzFWBKqRSygZLocSxuumyUzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6615
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Saturday, May 11, 2024 12:29 AM
>=20
> On Fri, May 10, 2024 at 10:30:10PM +0800, Baolu Lu wrote:
>=20
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 35ae9a6f73d3..09b4e671dcee 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -173,6 +173,8 @@ struct iommu_domain_geometry {
> >
> >  #define __IOMMU_DOMAIN_NESTED  (1U << 6)  /* User-managed address
> space
> > nested
> >                                               on a stage-2 translation
> > */
> > +#define __IOMMU_DOMAIN_PASID   (1U << 7)  /* User-managed domain
> for a
> > +                                             specific PASID*/
> >
> >  #define IOMMU_DOMAIN_ALLOC_FLAGS ~__IOMMU_DOMAIN_DMA_FQ
> >  /*
> > @@ -204,6 +206,9 @@ struct iommu_domain_geometry {
> >  #define IOMMU_DOMAIN_SVA       (__IOMMU_DOMAIN_SVA)
> >  #define IOMMU_DOMAIN_PLATFORM  (__IOMMU_DOMAIN_PLATFORM)
> >  #define IOMMU_DOMAIN_NESTED    (__IOMMU_DOMAIN_NESTED)
> > +#define IOMMU_DOMAIN_NESTED_PASID                              \
> > +                               (__IOMMU_DOMAIN_NESTED |        \
> > +                                __IOMMU_DOMAIN_PASID)
>=20
> Yeah, something like that, I don't know about naming though..
>=20
> How about
>=20
> DOMAIN_NESTED =3D Attachment to RID or PASID
> DOMAIN_NESTED_PASID_TABLE =3D RID and the entire PASID space
>=20

this sounds clearer
