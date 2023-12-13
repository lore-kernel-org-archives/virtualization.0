Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACFF1DDD7
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 08:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQuruFJJ"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2793817AC
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 08:25:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C2793817AC
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JQuruFJJ
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EfgCuOw6rFRO
	for <virtualization@lists.linux-foundation.org>;
	Wed, 13 Dec 2023 08:25:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 27BE081757
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 08:25:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 27BE081757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702455905; x=1733991905;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0ppWB4KUf9ItlUkFxKIcx5LJBpcaHf4hW7PG+q5J6mw=;
  b=JQuruFJJ/Cez9kP9G5EM4h+NR6HeOqMVRnpfJA9FA7hBTpGR1m3J01mp
   5J1+Zap5vOc31Gog96BZC1815fYvrMQX1rwM8QVclHvJowj+u1voLodQf
   VFr1A62zeh+wsF54Iewl/zP0Gj3YepNYkiXyfRZAM6pFO4/Q4edaqXICq
   QgvoOH/qpj783oqdNekNExltjM2wLiYbaLLr+C3EZIey2M/wN0OwyOAaV
   PBAVzbXL0l4yoIQjTGeafbXNA3AzpBAE38TmdWOusS9xbSBDEGBS1gAcw
   Fj/mvR5CSRR5YQrm5yoKAuPj3HUIQlFFBUi0NXIcu+tBoBvnFRspSrejb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="8319066"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="8319066"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 00:25:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="839776110"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="839776110"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 00:25:03 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 00:25:03 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 00:25:03 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 00:25:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCaJBwYgp0W33gEVuiEpYrSKuhfwARfWlXLBfLb19XCVy4QX8VI0Rq7UgzCdZFNkaNHePHPBfB5HmPb9WSqsfxkYS5PGwlyaEJfVzsbQlBnA0gbzPS0lk0BRTtHOFmRf4j/vc/cZ32APKOKlLLzVV8gihcYYJLkv1J04Q3e6R9IvbDT1BgwLVAEkvwzGusO7r+7cqiXBeF3+M0DV6mS3ES3kGOu8SMruC6lYfY84bjenem2z20mwiU4jZ0FzsnINcNhF5FN0n82bESIY9pR+SxnZDWMGkrM7URqXuM9/aA0pe7AqC1FciFovbsj85MXuXZQH5svws4qmzi8gIBlgVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ppWB4KUf9ItlUkFxKIcx5LJBpcaHf4hW7PG+q5J6mw=;
 b=oSh4JfLosjLGJ29WPQhYQcM8dXUjw1/gNwQOpYJX2UNVy+eRtIMIjV4lLm+oF5K3v7C6m4oGs1OURPJA399X7pSMXrzvuvnz5Txigg1KGmXC4fRDQhxFh1jqyV5sqthgjHf7wis/EKbt245HIFNVwUekouIt4fSBfdoc306zw/Fyu5cIGnQ79rNInHkRYX4efy9ep5tvRAYBE71G+2aHLUc9KTA9aloDGfkp7NStdozf8fEz3YKDGL6G4bjUemybFvf/ZBxW2jGf1LnYV3qCsvVuku3zU0SFj3ACEn0H4NbGe9YA3U55Rbv74GnBOUEwzRyTl1soMmRubmttxdkr0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4898.namprd11.prod.outlook.com (2603:10b6:303:92::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 08:24:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 08:24:58 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Yishai Hadas <yishaih@nvidia.com>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "parav@nvidia.com"
	<parav@nvidia.com>, "feliu@nvidia.com" <feliu@nvidia.com>, "jiri@nvidia.com"
	<jiri@nvidia.com>, "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"si-wei.liu@oracle.com" <si-wei.liu@oracle.com>, "leonro@nvidia.com"
	<leonro@nvidia.com>, "maorg@nvidia.com" <maorg@nvidia.com>
Subject: RE: [PATCH V7 vfio 8/9] vfio/pci: Expose
 vfio_pci_core_iowrite/read##size()
Thread-Topic: [PATCH V7 vfio 8/9] vfio/pci: Expose
 vfio_pci_core_iowrite/read##size()
Thread-Index: AQHaKPhTopma7TgkSESlM9yvYqC5CbCm6a4g
Date: Wed, 13 Dec 2023 08:24:58 +0000
Message-ID: <BN9PR11MB52768E3E55C1597D23B5C3518C8DA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231207102820.74820-1-yishaih@nvidia.com>
 <20231207102820.74820-9-yishaih@nvidia.com>
In-Reply-To: <20231207102820.74820-9-yishaih@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB4898:EE_
x-ms-office365-filtering-correlation-id: f8e0c1cc-af51-4269-2aed-08dbfbb4febd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D7IC8MlnuXe0noltlHbcaHuBIHc5kaMDlIfRQoPPDMKBDoLoeu1igZV7Q03u2THgE4jwlwTxEM0OHWouuNISe1oJO43edWKMZhQ4gIvh8C1Ro119NDFNAJl9XnnpmikoSOsgGNrqLY9V6Wst866os8XXwaS9j0IO2P5ojk7+dRv4+60icMK7qGXkkUdupQW/VZwbh4aPqMuYK6Xpr0rmXWEXlBXemfYjCYpEK1LKK6ilUZuheDFxLdvoUT6m4O+3vVyKuxDhoLpTLC36mcwDNb+sQcpLpb4nq3ATUY50U3bhtHcJrD2+jUini8PkOPdAxqEXFdPzqvbKI96//tyB+Sq4y77P0Af0ScuZBv9qJ99iUCc+jWIKiKwGptwXtOw5gii0toPfflENqpMgdlPOsYF9k7sg6pqerDhg4FHVnA5yVwjeP8doiXDhAT2adCP5K0cQb3AlTqEyM5xqNi4sV4Y06p47N0YKLJNFgXe17lHNbSbBpGEl30rb3ulgjWpqCka7A0FCaJuyNA6zx3N7+8PSgZAKNZMB7zxOPy4Tsm5AmovCm1+kb1UrnWv7C6Cclx/eusD8Q/2FwetiPwAn9HgSbzXN4KcNk6/kFllthv7JhyS2T9IViOZOIn3AiaVH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(5660300002)(55016003)(2906002)(7416002)(4326008)(4744005)(52536014)(8936002)(316002)(54906003)(64756008)(66446008)(66556008)(66946007)(76116006)(66476007)(110136005)(8676002)(478600001)(9686003)(6506007)(7696005)(71200400001)(41300700001)(26005)(83380400001)(122000001)(38100700002)(38070700009)(33656002)(86362001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lZupxaoEYrLZW86RO3GYzAL+ZTb16aZvLGojt4Q5Qgj+rfB4kJa6svCnzK3W?=
 =?us-ascii?Q?MHbOA1lT+ZU6zDnqbfEji3noyULTlsw908Xba8d73SUwwiHQaVKm2uJDtWQt?=
 =?us-ascii?Q?sscJC+7OyDuYQ67fNqyQagktlNreYHLQmemm1FFu8up7bbdv2UrhgnWIW3hF?=
 =?us-ascii?Q?MfRk3caKAQswRWBVZMyw89dqzL+KJnYciImT6kGLLRFtxCBvWFOjC3+FWmJS?=
 =?us-ascii?Q?VaaDs2jDqXcVY/WtJ6oFd18Olv4rxzIcZyRWT5llIxiCn5E2IqYCw4Use+Ow?=
 =?us-ascii?Q?P8oa742zLUvn3czRMmID8+zRTxp/beQrmhozR/RtYBsZZ6Sxx5wnL6CS83SZ?=
 =?us-ascii?Q?0xyicdPs2Oh/oehr8gBQn+UgveSJcZSC6S2I4I6cT8rxhS9QGqZ3XjCQtvPr?=
 =?us-ascii?Q?vS0MfkMQIL/IDh6AaWe8fCEL80dKgMLWDUWjzjpQs6CitzaByaro5n3OPALH?=
 =?us-ascii?Q?V3mvHJK+4MaJVmysInIKaXxqWeahJdtWb5aKI+wPWG2XmAiA7lGkaZ/+VnYc?=
 =?us-ascii?Q?VpKrNUZxyF7C0j+hNpNq4d2YmDic60X2Bm5zr6G7qp4s4nN6nWZguuFY4rHC?=
 =?us-ascii?Q?ktS4OVVDfYJ5HzzZ92U7jOqnGEJDDwEh/6mOEyBh1344yBGuMyovlHXqorAr?=
 =?us-ascii?Q?Z3GN7VHyyCZgUc5w8I37zomwsjwjhxY+Oi+TSjjc3z01YpUniiAV1OEmLu+B?=
 =?us-ascii?Q?JezSroHj+5Cgp37k/eymQE7NHSJMKPChZ8xGtmsMeS69mJ6IIW/qSp0afbL8?=
 =?us-ascii?Q?MQL6bfvSVyEf6TDobhQhE0BF0x5YqHOcR7pp5jeYrTH4dMd1s7EZoO5brmH2?=
 =?us-ascii?Q?iYdCyAVnxG8M3dztg7mJYMOECURo+yob7rPCh12ap6SM7C0BReu5CGHEf/01?=
 =?us-ascii?Q?+S9vcHjNGv/LzkRJtZXyKpT+VEqo9PtKeriHfl0hWHXyHlLwSllFvbSp9vCt?=
 =?us-ascii?Q?CuCzkF1KxmbP9ZMYpYpA2bMvERJ//HmVhjJAf2vxetHF5By9RMynFq/zbDfB?=
 =?us-ascii?Q?Wmsvk/eHvmoQiIJVRTOKSIPOa57H0oVbbYy/JhvA0fd4VWxbabK3eimGEzA/?=
 =?us-ascii?Q?n/tnadLT/BdywKeRBmPWU8Dzjp/bREHepwtOUX/vb4pbERq0PgM6+rk/iV+N?=
 =?us-ascii?Q?kF8tAyTDHP120JJY9MhRXF6bMKNy97SDGfGZVw+zMZmlhzZE50ZEyUiuDOKq?=
 =?us-ascii?Q?33WU7hMz2iP4SKb6YOVqnkT1+1dGse+ZPwKdMOLFA9iv6MXoxW5FQ8Qc+Z/K?=
 =?us-ascii?Q?6d4DLvX2gTOIBKIqaviV1lBWfs0XPvTkDcaO2nUB1o+wxoiNeqwi40BJqe52?=
 =?us-ascii?Q?gMxUSW9koc2MkESotfn8VKyk+33Nuq3ozYR/1Nq4Cd5Cv5iCgeJjDmsxwXIm?=
 =?us-ascii?Q?o5oY8kO2cyq6vtvbwR5vyHmxOuprl3Th/M6foJMz2rI0isY9SeLsPdZK+yCz?=
 =?us-ascii?Q?Rkr6Eu5D5F6j71AVHwQUBju1TbdL39otLitEi5KvlLV3Sz4PDXoLvS6VvqTG?=
 =?us-ascii?Q?1QIhxvsAvkwXYoJaB+11g7Q4RuHzzSggt8zWpw+41o5dOB5OGJhkLzzaTSBT?=
 =?us-ascii?Q?/aTL9kXmV+1faDwA2D6sRsF7dv5TCCYzocgxKKTx?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e0c1cc-af51-4269-2aed-08dbfbb4febd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 08:24:58.9010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rxm+7WtSzpZCpGJpla4ra2mEAi42ZWybTGZstEprGsiYMk/iZ6bCplsRolEQNswcumuTuFoF6wFcbQ9kS+uitA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4898
X-OriginatorOrg: intel.com

> From: Yishai Hadas <yishaih@nvidia.com>
> Sent: Thursday, December 7, 2023 6:28 PM
>=20
> Expose vfio_pci_core_iowrite/read##size() to let it be used by drivers.
>=20
> This functionality is needed to enable direct access to some physical
> BAR of the device with the proper locks/checks in place.
>=20
> The next patches from this series will use this functionality on a data
> path flow when a direct access to the BAR is needed.
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
