Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3DA53368
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 08:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715762641; cv=fail; b=RHDBdCVXBF0SLGLoL3HDOnKLkFPq4PrDhKKAKzSJaGQqvPzeu7S7uhZMim5oyhUoBG3i+fxn1JtAFLChquzkNUGC0ja8acjbW7MkGggUTZstZcS0S0xPH7KMeCf9w3nzfbRr9WUhsQl3Mdp4LDqrMnuhsaEH7ULsC5DRYanlvdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715762641; c=relaxed/simple;
	bh=bMoX1SWJcjKFNF1ypz4cnp0avIzJkMrMBDKpGQrR828=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kBm0aQzu7DzSxcP9GJiAL9zbPT9c4s0g0VpT4oFKy0hls9PK+hy4Fgbp3KRstdGsnvoKdEnt4FPlABgdcGGSZ4YLwb/KzdTsdxGcCv7hA7At6MmPgtvS2kVd4kUKCKNhtgIalpmQvKnNmEjGsiegp+3XK4nqh/jkgB4c8iFUI+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W2l+1Uf5; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2l+1Uf5"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BEEAA40B0F
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 08:43:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CN62bVDxsJc2 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 May 2024 08:43:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.15; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 864B2402E6
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 864B2402E6
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W2l+1Uf5
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 864B2402E6
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 08:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715762637; x=1747298637;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bMoX1SWJcjKFNF1ypz4cnp0avIzJkMrMBDKpGQrR828=;
  b=W2l+1Uf5D4NeknrH043lbfqHCEHTf+UgcgmQ2yUJbHt138GLTkRQiNfO
   5ezkwPgphktdRtRG8Qe61S9Ei/jiGEk1kJLK0GQhvhIdV0Eut+53CRQ1O
   /kO2lyqtyf179sShZZDKDDgJxl3rnQFacx6Vn19tAu+Hd5FuqOl/2E9UM
   mMNrMH3QqldlYOFQqALLSuYa7O9yL5y3R6OO5VjyZ4yx8tuEzFMnziW1C
   V4tqTEpCb2paLlQWsrGdrFd+sH16WUf8lvSc0zLXRUQc7cPHMGi2hSqAn
   7CyFz15/itWy/PIzc7Oz214usCiAABV03zw7N08S2lNh3UJGrpZbo9uxK
   Q==;
X-CSE-ConnectionGUID: zwl3CmC5QTGVPl9PEDsfLQ==
X-CSE-MsgGUID: RTYXnUNpRR6tKB78XTX9fQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11969724"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="11969724"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 01:43:56 -0700
X-CSE-ConnectionGUID: 0Ffe/0nqQWSOU1gX5QbxnQ==
X-CSE-MsgGUID: SAk8Z4IMT7Cg88+GeIBbEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="54188256"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 May 2024 01:43:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 01:43:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 01:43:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 15 May 2024 01:43:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 01:43:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oI6Ogrhl/gAJi8HkjWGQCBfobiAB9zwaw5YFTXLZo21zWlXSpvRDug1mTxkaa12v4hvbE/v/hPLwM+/3lO4fOe/N4l59P26CBX1/h6gbipqyVbesoE/6i7BaG8t0KLCDdvrm9T/lC5Q/r/4EVekqkzfkCpredJmH75JtHB6up9qS190kl+cgzujgGxfF18j3+Sfd/WHvMv6Kx6lrz5F865T/hmtyShV5ldNO8/GYNLWmute/ASBRKGAFEEHPH12ILcV1Y9Ei/XFra+p+vtsbBDJjM2AmyN0ie8GQq4eQvYtq3AyTP/9BlnU1RBCd+vhnO1bvG82Cshvm7hbAi9tm3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFDfzWYjaEsO8Xs1k6uPtqfh1hdRtO9gShNvgv/9Kwk=;
 b=ZtMsmYStNRxMr+gBetixFXJMAU5ZqfJmO6cmVvxX+zXkwYRaN5WVCakoFUHuMkRdup196fpyu0TbN1EoDpWejZNugJLYlaiQ330rBL6pAQoQb2pk5sKGfcIqLiFN3323xQw0da1Aex2celrs8r5RdxMYkTqhD4RGw5+tTA7NsOdTFWKOpJmA2uZkrIYm0WoCfvWeAq/RJNg3BwMeRDeO2dROXjW0ZSjiE7hcb3n5yWFi5hXLmBpuW7/npNetInACokjHVevWeg8T1K+vKRhPTWasyzXSv0i9i0ye9MMUWoDsH2HwZqKgFcBIzuPLkPruTt0lepwByeiBh0iAifiMkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB6918.namprd11.prod.outlook.com (2603:10b6:806:2bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Wed, 15 May
 2024 08:43:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 08:43:53 +0000
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
Subject: RE: [PATCH v5 6/9] iommufd: Fault-capable hwpt attach/detach/replace
Thread-Topic: [PATCH v5 6/9] iommufd: Fault-capable hwpt attach/detach/replace
Thread-Index: AQHamw8ICEBQlwyqhUGpWVI9yv+BvbGYEXTg
Date: Wed, 15 May 2024 08:43:53 +0000
Message-ID: <BN9PR11MB5276D582749AD8B619B11B688CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-7-baolu.lu@linux.intel.com>
In-Reply-To: <20240430145710.68112-7-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB6918:EE_
x-ms-office365-filtering-correlation-id: ea139bdd-a58a-4e20-10b8-08dc74bb26bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005|38070700009|921011;
x-microsoft-antispam-message-info: =?us-ascii?Q?rZZp+lPaYU6168q5COTvXjD4yqPd8KQ/hvmto9DUsizYUjxeRM0gJcNA1gD2?=
 =?us-ascii?Q?xZqNLDkYIF2NnYKG1xNe9DsYq22/DWR59AELR1e4M3SusuiXwNvlOCarKeR/?=
 =?us-ascii?Q?T3HSkA8GA55VvKuoN7x11wYxY6YCZ5f5sgKjAwthZSNKwiZPXEThimoviEjj?=
 =?us-ascii?Q?pT5yDYBlCdF7y7isNLT3VqkJPmXXMt91li7erpGpdpQghcqcB3r5o0IQjJSJ?=
 =?us-ascii?Q?sFWFNYQ3upDeUzkZyIPh8RJhZWm73EE6h2PtttupL+5hqgtP6+JkoSzIXA6c?=
 =?us-ascii?Q?i/y47cM041fX/s9DIfY+5inGZP5TqzL9dSG/s6R+pdnNnPGPiMIgq8FcPe0J?=
 =?us-ascii?Q?8bP/yUk4P7e3O8QmwUS01nC34C/xaGCZaDJ48AZKFDaLGmb/9PfasQsHuR5G?=
 =?us-ascii?Q?z05Ai8WzwctOmNeK3IxbmQG1qLqYCmpEqZcIuTiwNWs+RKIKcic6Pj3ogMhN?=
 =?us-ascii?Q?5mDuRyr8reTt53bwkcTXOi2f9RWMmnFer5qSKHBy3XaNMt9ZXV/7LRUQwXkg?=
 =?us-ascii?Q?QexfmQAWn8+MEi4LI5PquUQtjlWjz7OMsjT7kiki3piin2BZAmMVMDr/UydP?=
 =?us-ascii?Q?EQtTUTjX8DSYWDLTfSVf+XjMAjNQu6ytC9k2WYrjQ3n6uHDYOsOQYjynyqI3?=
 =?us-ascii?Q?/Cw9VueJx274PYyoYYzY8WrwBsWeRy5hQ9boEvCmt9WCzdkjpjAhz1VdpG2I?=
 =?us-ascii?Q?oawQyEJoeiu0rPKTeXMwkRIUObxyRejQglW3JVzv4IluVOKbFXFMnKpQ49Ui?=
 =?us-ascii?Q?Bnc46bdJhHgDFob/JC64tNeiuS06SSPEFV0dtU0wQlnlHMnHWt+R7QdVHbLB?=
 =?us-ascii?Q?O1C54kWs7ZX8+OTEpVlBWgjyD33TDxXg/rISitHvq2Xh1AgUbnWRlRKZA186?=
 =?us-ascii?Q?Im6YmiF0u+Tkt0WNyDkQ6h7/M/HaApGDUTZtCbplpodj+3GciOk3RMk2EY8s?=
 =?us-ascii?Q?l3GLCOJRqoSQ7Hjtq89G4/ODBe+LJANhtrwlQVA1KYCS/hpI5YRr/OZ5SwBM?=
 =?us-ascii?Q?59Lq4w45guO2MmUVK8ue2NRRawuHE5AqBRYPoqmZNf6KimCcPo3xQ+0xMdl4?=
 =?us-ascii?Q?4xTg7LG4XITqHBpOlUClMwYpmJS7PpXcd8wC7/m75Mkyn6SRNE54/AcyjaGN?=
 =?us-ascii?Q?wJrHgTBk67isXrXsEwafDM/9Z1jCs2/CtWIZWLwPRI95RF+e0+BuSl816dj8?=
 =?us-ascii?Q?RpkKxEJdyp+L3fdScg3Eqik0AH2W+pNFbEWUqw6jganbcK1Xsl6tZF7BC8Dn?=
 =?us-ascii?Q?wnmhcmDwethyNStECi38h6k7e8Psd3filO2ybIDSu0ZHo25OWNZKuX3TZDL7?=
 =?us-ascii?Q?06nMQCP3kmkF2BEASeehhMXkyYE8cS27COpO0m/Bq02bCmUga7btVUWPMbtT?=
 =?us-ascii?Q?eMdBzhE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7qrcR6Jio2my2dRAHlxIy0GIEv7XhnmIN/B3q8C1NlFJJbcFnyVpsSIfeu5T?=
 =?us-ascii?Q?ax8Q8Q3vKnCk1s0h+VdvCdhUbG+5wdIuHQVPlyNIHKPUB5S7F3miT5N6WrNs?=
 =?us-ascii?Q?dXBmNOV2UJLV69gwI8JVuP4Z4NABORF1u4FqopvNAEw8lCuyC1gTKow1mIA5?=
 =?us-ascii?Q?DvuocCki9zzQ02q2Yv3AOehe/+ntv9mIcx5onxRasMNOG3ZCTETP0vwi6DEA?=
 =?us-ascii?Q?cmSzFyigQMhO6YVPQrJ0ydbTvhcNabVEyR0fO38JQOTGFehYjhQJS3wHTQrc?=
 =?us-ascii?Q?Js25EsiIdU4TVVY+14+9E3sOUonmTIdTRvDvcEkXm7gQ+yQDUFZJPlxgCadf?=
 =?us-ascii?Q?Vo7QTj/RKQ6+xi3m+8mQ43YQjcj4y0T1bL+JjgJQzvu+Pzqy5uiqo2JJf9j7?=
 =?us-ascii?Q?asBtCgFAWLm4S0t3g6bGq4FmdiBfftA4oYO4AdQ02TNl6CjAZ5qnrYmuP4UL?=
 =?us-ascii?Q?JmXLwHwd3YbPfEEVzX+KKowByRpaw9OeAXjPMihqB3wXM9Y1jmObahIlvFzm?=
 =?us-ascii?Q?DJ/YAZ43++xbeTq1YY9IXA1K8MhSimCKEXVaeenVBEG07KzzYiJcCGPA3Z6n?=
 =?us-ascii?Q?C5blWGFviGj4zgMxaJ2C/cKWU14pIXCzH/pn0RMeSg8dT5cvmEHfGb7Glv2c?=
 =?us-ascii?Q?oK7A2OoYUYaMC9RAhPeYwkawA/LSQ0LJtK8r1jFcH7XlPEvHKhBFDa8Ad4J+?=
 =?us-ascii?Q?USUuKiEa2c5Vcxrq6LJXFPorlvWjy/3dRJuGdESd2r9VQcTKz/6S0VcpKFgd?=
 =?us-ascii?Q?5tc9391COsyy74SIzTZ8kScYezc7B3ILXqrRgUz51z1NOEKNDFVYdcbkg8JG?=
 =?us-ascii?Q?M8V56nK92jN33uPddJUD7g2TGEr1rYOBEXUEvVRxEcDvWODmMAtFMV24wRzL?=
 =?us-ascii?Q?nbVZD98ZU9amAudzMB+ydvUn1FC+81mlcc0EZSn2kxNFQJa2Jja/rvpp97oC?=
 =?us-ascii?Q?ZkewAb5oVqgQoVJ0q/hf98GsKjfsCy0ZX/5j4Eaxn0iTZ7fpuuxOyVhzlcjR?=
 =?us-ascii?Q?DlvXbDvGR/QWergY0ChXe56E5IyIcKxRWOOHl13UWmXB1oyZ3jnthf8oZ2x8?=
 =?us-ascii?Q?863RjiN63Yoqtt9t2/TVa7T2Ud635dVigNiyApn4PpWoOyNMUm46jTePlaLJ?=
 =?us-ascii?Q?Npach9n5u907v2qWWYK0OmzpigUJeXVa85dq3oUKoWmu4qoAgB+AqPLyVijz?=
 =?us-ascii?Q?vW6hx4X6sFAsNilXZk/ftXHAQ6XgSOxNiE8w5CaWfd4GbVMy3Z6k8Dmt01y+?=
 =?us-ascii?Q?zsPs3V+hp34s3tuXbPf2l+j+fkdwJYW8N4JzVvo7a390M/TIpytMWmxPyrsh?=
 =?us-ascii?Q?T1qDSBj2cjpIdflIqZ25IyXa6Bdbu3mzRwy50paVXEIW+5KJazfsFUiTHXoD?=
 =?us-ascii?Q?NDpiI1e4mhflekiDLaWHOyeyVuaTgPksfhEexU3UPRbz8YI0rCKrZp90GKNM?=
 =?us-ascii?Q?C5cg6mIaGMaw78AKWMWegYDSnhVglBZy3WYNIZvEJEAUgO4qeWN6XEoyhAv1?=
 =?us-ascii?Q?ajlAHEUATG6HM2ikq5mAPAxYYR5Xq1ekmtMFdX6WyfaRAn55OecyaoXupbqz?=
 =?us-ascii?Q?cuHHZ61iAZ0ekCWszFQL0WKkLO6hP56ACZwCuiTz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ea139bdd-a58a-4e20-10b8-08dc74bb26bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 08:43:53.6867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 89dl3FD5L+nWCBQaGWmYwHMoOfW8aYDLyza3+lrlZDXZhSiGK6Vmd9geBUbZzArQWotolmRiH81n+GO0aYwJeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6918
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, April 30, 2024 10:57 PM
> +
> +int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
> +				     struct iommufd_hw_pagetable *hwpt,
> +				     struct iommufd_hw_pagetable *old)
> +{
> +	struct iommu_attach_handle *handle;
> +	int ret;
> +
> +	if (hwpt->fault)
> +		ret =3D iommufd_fault_iopf_enable(idev);
> +	else
> +		iommufd_fault_iopf_disable(idev);
> +
> +	ret =3D iommu_group_replace_domain(idev->igroup->group, hwpt-
> >domain);
> +	if (ret)
> +		goto out_cleanup;
> +
> +	iommufd_auto_response_faults(old, idev);
> +	handle =3D iommu_attach_handle_get(idev->igroup->group,
> IOMMU_NO_PASID, 0);
> +	handle->idev =3D idev;

why is auto response required in replace? new requests can come
after the auto response anyway...

The user should prepare for faults delivered to the old or new hwpt
in the transition window.
