Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0FD63B9
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 02:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AAcRKXKr"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 74536402F4
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 02:58:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 74536402F4
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AAcRKXKr
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O-00zwcxMpcp
	for <virtualization@lists.linux-foundation.org>;
	Wed, 10 Jan 2024 02:58:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 427F640111
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 02:58:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 427F640111
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704855484; x=1736391484;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DPe3RvUKR+opeEt/lpAg6pTFbErcVkxRwKKLjXGbmwU=;
  b=AAcRKXKrl1fyXCqsFxj8qpgEndMapAOp4vwyXTCHTEC4ikaGzJpaU2kM
   K4SKJLTtd0BpN0rKHZOpZYU60N1cgecfBCMS/UNz+99LFSu4qh28CuAJh
   Uyw6tkhBELRlKsp3b3skTnB6OAYBEOxmOLj/yNEzPJlecowu2tfGrABPl
   lptk2APGslUN3GE1U8TDM29FfdgyyGgA0lkPI8rmBeWJVTEi+zrN3BgWG
   AbicsyKIX33uY3wpta8+m+yhQILpJhao35QLYBTh6hMfEpgCqflvpjBCD
   rQ04kj6dgf2iytor1FtXym8Vh7Mp8LgmNm0tsSKzF1s6WCERCQ7B0rhPp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="395549649"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="395549649"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 18:57:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="955215737"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="955215737"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 18:57:58 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 18:57:57 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 18:57:57 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 18:57:57 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 18:57:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0ZuYhQuDuM/uEkGXKfLonh0bsfWGitOdxj+TgGP+WCp67BlnrkmayqkuWk/6RZrrzlpPMijma+/rgWDH+x2A8viR+HBkdL+a2LcYxqPtWgjFef6MZbkxoEt1f6dcpARx2pPB1m+i4t1yw1TCqlcFsbKeeWvSW5blDm9h2AxmqNg++8DRlS4jSdAtLwOBzqbp8Ilci3oIObiglVvzEQ+QVZjS3mmtHXw9MhUFlCwuhltmXvkQVstJAf8hnz9tyqhP0ObXaRwP7hcJd3yCRQnWN3wwoGDC0W7q4IynzHAXJjSVLU5FwN0VzP6LXRvFOQWrPe6ZqmmYOcBt6yi9TF/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPe3RvUKR+opeEt/lpAg6pTFbErcVkxRwKKLjXGbmwU=;
 b=TdIITEsMPSmfnRq1LHYxuDQ1emmM/Az2nvhP1QrA4+CGZAOLa0PZnI1msDtMZKrw9XHfAudQ3ewdZqfqwfuWoilu92Ow8AJaGIL22y2kfoi9u2xI/vFOLEKCISJ5IRgIbOq1DKVauS25yi9/9gm21DdSoZHxvnBTHqez8rXOV8mkbGfr1308O1+9OqHLsxrjyMId1CmRpRTitFCmb4NCec2xyssbdMuu6fsdbZnr8X1wwvGNK8PfwS0PK/cdBl8wLIpXAvnMwLBTwBY59EfJxNBQU0mmuH2Lmf7gDgxeRcuy+LKEISHKMom01lonoc0Cc07uGKvatAmqYSkjP9AoVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB8262.namprd11.prod.outlook.com (2603:10b6:806:26e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 02:57:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 02:57:55 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Arnd Bergmann <arnd@kernel.org>, Yishai Hadas <yishaih@nvidia.com>, "Alex
 Williamson" <alex.williamson@redhat.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Arnd Bergmann <arnd@arndb.de>, Shameer Kolothum
	<shameerali.kolothum.thodi@huawei.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] vfio: fix virtio-pci dependency
Thread-Topic: [PATCH] vfio: fix virtio-pci dependency
Thread-Index: AQHaQtGTD8akChfpEkaQDR2fxszp8bDSW+CA
Date: Wed, 10 Jan 2024 02:57:55 +0000
Message-ID: <BN9PR11MB527624BE8A9A0ACC3E97F1C28C692@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240109075731.2726731-1-arnd@kernel.org>
In-Reply-To: <20240109075731.2726731-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB8262:EE_
x-ms-office365-filtering-correlation-id: 10966890-20c8-4115-46e5-08dc1187f1c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1+WoYuJcXaWFDIk+CtJZfkMzESzc4LrWHv3ANaoltEBQ4hAG5JdimTrRWBoCC2cjueXwo5UOdXZs1tOSy+bqPGlhzYP8XsXj+Mggpny1Xo3UCarHl5pIJ1MgzArZTdOv/ixfupNlX5ubTPy4j5Kjyg4IY18XZ/mbU89Kz64FoIoqPZmamQnA4cNSdUAwBC+eFeXMs0IXRqUZYFlwdJM3f5I3sXwWfogb7w7Eb1qIcKQvCuFczcTcR+i3blqfBCzsiOYNpfJrtRWJ3uTrH7On4dFjsjoWh7Ifk7dPXVLNA8KpD/+cF1n8WDK7KBYZUcsGbgr3RRpDLnIMCqx6fjMQlNMuk2upB+fDnKjG2kxNZhBfAoFuJd8s+d2g20J9Z5SmzjSbrh/k3wkdzlm041NITf4/SahvkvuHKV6RhaSH9zPYnll8n97ZRn23smmi6kg2ImfJyxrixyiS+mV1NeyNsP8zSTs7faN5hjQ7rEU4YW2wT3+A5ZQM87XTG9/GRTeoy4iObCQQLb8ph710h83nNU/063BucNFK4aTkN3KpLcIXIw19E3S6anagJOdaSCIfDFAfpLXZNIF/ukXuBPU8muh9odfPO6U/CLuTf76RpakPbqxkGTboN6oxum0domTg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(9686003)(26005)(71200400001)(7696005)(6506007)(478600001)(38100700002)(122000001)(7416002)(86362001)(33656002)(82960400001)(5660300002)(2906002)(66476007)(41300700001)(83380400001)(38070700009)(8676002)(66446008)(54906003)(66556008)(66946007)(76116006)(64756008)(8936002)(316002)(110136005)(52536014)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i8+vrEyF8ddJWJ4+QxRA491wthrb/N8XkIMmlO1mbtn8mWJQEbbRJBUv2TPo?=
 =?us-ascii?Q?tOCmuIaUAurLjPqU+ecHAIQsmNQBO/ww6UfajxUgdeu02l7o3k2dOFco2uGT?=
 =?us-ascii?Q?cpiaYvBrQXeYLvUar5NQF1os7ZdKpm14XLkKVce4b+uWKHkvpDT0ShLSQg0E?=
 =?us-ascii?Q?keHvLKLFBhAwk3+YFZYbJXbGLJ2/EfW07ESGSdlOvy5xmkcL4MYSHe5Wd4fX?=
 =?us-ascii?Q?V1M/442JO2iFAsWx5BuAg3dsNAQtfSX/vVJsm9rIGB3XiAZMAu5sg3hnpG18?=
 =?us-ascii?Q?EIqSXMo98gdpPMj5IbVgbr7wlogpJtN+M6oIYZBc9+kb0i8EPBJetDL2pZKh?=
 =?us-ascii?Q?9VCnlcgwhWRM6gKAQtQKcQm1yKRO94uEB5fgAtoKf4+NRJRX9XAcWLxWudl1?=
 =?us-ascii?Q?9m1p1XpJFr9JV+lQksgeawbAdB7sk5SywhOa38z1937PSYe+zc1LIciOgWh2?=
 =?us-ascii?Q?MLMD2QgXSPz/3bxZSqysdVj/+VG/dcMMApiZUDm96GysKNPrlJryZMpRqa0r?=
 =?us-ascii?Q?t+udtg4fYI9fk/0eKribZH8eel05P+Lssme4PvOdicjzScmr+BVwU0mhH28F?=
 =?us-ascii?Q?gPGtKCrtOgBNg73bQMuinvkY64TSEmPm/Y2zYrdvy/KQXc5NbasEFrsLy3KX?=
 =?us-ascii?Q?ncKB6u/EuFe5tMZTrLpnfzfp9XTvLyRdTKZ9aKbbWskjmi/SQ+cnLEp2iYKE?=
 =?us-ascii?Q?Wpj2ummUKjeQzMzE6BwCCdjoCqWiBAkxseC7Dqms1aSQEIWxXF9w/3vOiw40?=
 =?us-ascii?Q?YrSFR4vUTStICyLPojm0mrItzt9PYWBvzcFdNeDkUNgAPdjBJP39scgvHAHH?=
 =?us-ascii?Q?L2YOuW0ZJmbwFg6Mz/dZz1ImOJO+n+rSh/Q+RleFLJwkTPEmIK8W0eE7XIoW?=
 =?us-ascii?Q?bOUIqz9Syvs8mNM4gcAOLxXqz5aoTaOSoH91fAJF9JZ0UbNpZQNCLUhSkpIE?=
 =?us-ascii?Q?lfEi6nwGdF6VVglLraQNWD0DhUgdsdppJcMHGB43/rD8xe/ek3u78SW8atHe?=
 =?us-ascii?Q?/8NgYWYt4Nt5IzF+n6UU6iagh6r0DjgPDk1gAPSp9PHi+m0cE3CvQE+TYKAV?=
 =?us-ascii?Q?S21Ywv3jtoFTPXDJnqWtFD79LB4m0tOi8WlNsgw8z/+kAeKhHdVAu9+KDFX8?=
 =?us-ascii?Q?mkugxb1GX9YvUfCNXEgiMgPIi3LeO49s+u7r+OL7IeRKh4xCFehLzVEq0hF3?=
 =?us-ascii?Q?4FiXK4Zy633gnPPGMbWNfaQpg4s+F98m+RaqSUxcxeUlnHO7ndzkLgPlCJBp?=
 =?us-ascii?Q?Buit1WiLe1qEI3bJO9bkHM0hhn0z3365Oq1kjD2J1nEo2c4riGpoXEzYsZES?=
 =?us-ascii?Q?9likR0uHVqERSnAFYmwa40g8hC5FfOtLt/N9o2k+Y55VgHZzeIDT90LZweQn?=
 =?us-ascii?Q?xz0Dg5vK6QRm1jgoWihaz6zm/maWPgjU+O5fiDB6SNmVhPF4aTnzceRwGDW/?=
 =?us-ascii?Q?c4gOiDQfa6ZV8hwKR5dHEeKxNe2S/LcHVAsyUFGZicBtJ9YJ5gvzfEp26eEi?=
 =?us-ascii?Q?23X5goBuYmFWLc8NGKgzSTGOxJsOmbqy+22WctQgMKg68w3tEbUI8c1lu+EH?=
 =?us-ascii?Q?haoi47pOMgwuYciGlQx8qK8lS/hsNrsYAsZ+uId/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 10966890-20c8-4115-46e5-08dc1187f1c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 02:57:55.3732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: roi4SFYlu+6cquDHbTXmMCJgU2H9NCyosPxGzeMv707Vihj4gLSlUHgRRzI2iDLHPQ+MvtH8ZpoORtj0kX2uPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8262
X-OriginatorOrg: intel.com

> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Tuesday, January 9, 2024 3:57 PM
>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The new vfio-virtio driver already has a dependency on
> VIRTIO_PCI_ADMIN_LEGACY,
> but that is a bool symbol and allows vfio-virtio to be built-in even if
> virtio-pci itself is a loadable module. This leads to a link failure:
>=20
> aarch64-linux-ld: drivers/vfio/pci/virtio/main.o: in function
> `virtiovf_pci_probe':
> main.c:(.text+0xec): undefined reference to `virtio_pci_admin_has_legacy_=
io'
> aarch64-linux-ld: drivers/vfio/pci/virtio/main.o: in function
> `virtiovf_pci_init_device':
> main.c:(.text+0x260): undefined reference to
> `virtio_pci_admin_legacy_io_notify_info'
> aarch64-linux-ld: drivers/vfio/pci/virtio/main.o: in function
> `virtiovf_pci_bar0_rw':
> main.c:(.text+0x6ec): undefined reference to
> `virtio_pci_admin_legacy_common_io_read'
> aarch64-linux-ld: main.c:(.text+0x6f4): undefined reference to
> `virtio_pci_admin_legacy_device_io_read'
> aarch64-linux-ld: main.c:(.text+0x7f0): undefined reference to
> `virtio_pci_admin_legacy_common_io_write'
> aarch64-linux-ld: main.c:(.text+0x7f8): undefined reference to
> `virtio_pci_admin_legacy_device_io_write'
>=20
> Add another explicit dependency on the tristate symbol.
>=20
> Fixes: eb61eca0e8c3 ("vfio/virtio: Introduce a vfio driver over virtio de=
vices")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
