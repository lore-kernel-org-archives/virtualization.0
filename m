Return-Path: <SRS0=tbjA=LX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5E0C11F67
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 07:56:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FEE761DA7
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 07:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEE761DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24B28834DB;
	Tue, 29 Jun 2021 07:56:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id snenvnftuBS9; Tue, 29 Jun 2021 07:56:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 94BDB82BBC;
	Tue, 29 Jun 2021 07:56:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 205E7C000E;
	Tue, 29 Jun 2021 07:56:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77581C000E;
 Tue, 29 Jun 2021 07:56:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4D11482BC4;
 Tue, 29 Jun 2021 07:56:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XKeZWcXmcoeZ; Tue, 29 Jun 2021 07:56:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9056D82BBC;
 Tue, 29 Jun 2021 07:56:24 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="229728665"
X-IronPort-AV: E=Sophos;i="5.83,308,1616482800"; d="scan'208";a="229728665"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2021 00:56:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,308,1616482800"; d="scan'208";a="446942264"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga007.jf.intel.com with ESMTP; 29 Jun 2021 00:56:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 29 Jun 2021 00:56:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 29 Jun 2021 00:56:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 29 Jun 2021 00:56:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 29 Jun 2021 00:56:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lw7By+JOPtTe0xv0M4wLQ+MYX4rB5x/REWPsZMnZa24hX7vS3xrZL6SBxJeblhHWfLVCSpOZv5JB8ZDM/jMae4LSsKdDncGvDrTOdyob9n+fm6kTLR6aEhp2E3L59VVuIoOnUMH1eZ4mKa0JtmophcA8giQB0qIhxbYbtJTQkwzAI771b7ebeuIghFqvqr4ESXpur3WObhdD8BFQtJhGHfh60zXSIuY5xwUsvPcgl+4H1YrH8Ig1+vJkSRCKuiCnCccnOX/kgzBt29kx/Y3omC/YK66qq/ZhY4sik7Wdg6XAVl4tgNTl3I3suHFrmcfYKdcSWOe8+tyJit949nrLGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4zsQQscnt4dgZBdtgup/8KxlRd7oRsxRfgkDsd5y+o=;
 b=Gub3D/u5exJSR3UxPZmGFM08hX7FzbqeheKzbqVx5Q1wFYyWx8OdKk8gLY65WX4x+qvsAL0xHZbPnLRHqQeUrx+Oo2OJZ61ZoK49kGU7j9agCTseGeJkxP+7w9zGl+OPknEteOPCWwmmA9P6j8OAc0iLIjq5WT0Upl1dF/QPMXH+1uDxgFqImm+WTfWJeJ8ecAcYeEk1wNHtPDnmp6JjjKCHGSOB2O3tJOtC0LBZ6Wlu17Cpj4ksyl791t4miCOBBEvrSxIxj9OgCyYg+UbOQVvWy8hMKIvyxVb5EdHRO6uyLghL9bkqJDCGJEiaOKEPWEqZWA4mRxrYrczZ/Dsi/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4zsQQscnt4dgZBdtgup/8KxlRd7oRsxRfgkDsd5y+o=;
 b=NUuOZQi9pVUtDmuSxHMxLMfeS1G/ey8dZehFFTQqsGoljAud7rxs33uv7oRq4aMMt0eLI3OHtTYHN5lHCr+4hjU1NiypCKM7iqDaQ7jtEWwxbvhwELp7K18nq4WoXyL8KxoOtNIN8fLtGlW/YD/jSC3YQ4J08uTo4Fn8sT4IQpc=
Received: from BYAPR11MB2662.namprd11.prod.outlook.com (2603:10b6:a02:c8::24)
 by BYAPR11MB3592.namprd11.prod.outlook.com (2603:10b6:a03:fb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 29 Jun
 2021 07:56:19 +0000
Received: from BYAPR11MB2662.namprd11.prod.outlook.com
 ([fe80::103d:74b9:605e:b05b]) by BYAPR11MB2662.namprd11.prod.outlook.com
 ([fe80::103d:74b9:605e:b05b%6]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 07:56:19 +0000
From: "Liu, Xiaodong" <xiaodong.liu@intel.com>
To: Jason Wang <jasowang@redhat.com>, Xie Yongji <xieyongji@bytedance.com>,
 "mst@redhat.com" <mst@redhat.com>, "stefanha@redhat.com"
 <stefanha@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "parav@nvidia.com" <parav@nvidia.com>, "hch@infradead.org"
 <hch@infradead.org>, "christian.brauner@canonical.com"
 <christian.brauner@canonical.com>, "rdunlap@infradead.org"
 <rdunlap@infradead.org>, "willy@infradead.org" <willy@infradead.org>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "axboe@kernel.dk"
 <axboe@kernel.dk>, "bcrl@kvack.org" <bcrl@kvack.org>, "corbet@lwn.net"
 <corbet@lwn.net>, "mika.penttila@nextfour.com" <mika.penttila@nextfour.com>,
 "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>, "joro@8bytes.org"
 <joro@8bytes.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH v8 00/10] Introduce VDUSE - vDPA Device in Userspace
Thread-Topic: [PATCH v8 00/10] Introduce VDUSE - vDPA Device in Userspace
Thread-Index: AQHXa8kUCtmikoHekUKCGV4xYFF/O6so1l4AgAANryCAAX3fgIAAMcrQ
Date: Tue, 29 Jun 2021 07:56:19 +0000
Message-ID: <BYAPR11MB266276002F42D91FCE6E83CE8C029@BYAPR11MB2662.namprd11.prod.outlook.com>
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210628103309.GA205554@storage2.sh.intel.com>
 <bdbe3a79-e5ce-c3a5-4c68-c11c65857377@redhat.com>
 <BYAPR11MB2662FFF6140A4C634648BB2E8C039@BYAPR11MB2662.namprd11.prod.outlook.com>
 <41cc419e-48b5-6755-0cb0-9033bd1310e4@redhat.com>
In-Reply-To: <41cc419e-48b5-6755-0cb0-9033bd1310e4@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.143.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db28b461-4cfc-4e9b-7ca3-08d93ad36146
x-ms-traffictypediagnostic: BYAPR11MB3592:
x-microsoft-antispam-prvs: <BYAPR11MB3592EB5669DD662752044F358C029@BYAPR11MB3592.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LQYo50OoCRXK+W+qHpMMW+tW6edOL1Gqbrf2VKdLD7lr4zCJ5HXSIsBl24uLW1p1SWZxgCMS3hmODh6hT9wXvXlgLnPuxB+qlLyY4/ZXGvXVSD7/fJpUrnrXyjvLquByyxC4TKsx/e2/PVvsNtWqheU3ozEEIjOEgDpRsUSA2XaxkJJY/MaX2YLw+m79Gj1CMu7eXtnKs8XlZ5IblopJ7GBKNriDQJ8qCY1A9SpsqsYYFgKBhi30u5AoO8ilmFMpXMZqNmAmtM7ANMY2JSJtLvtTN4Vv4Nyw+FG6TiEKOfl7ORx6w7cnvvdZxKvd0OYYurGhMSLFF7D9iLd7lPHdxhh0gZcsoId/DUomfZ4gV2zpFv3uZgYPMGmOx6c6y1S606t1nHvuhHQdcYYLGzl+gtn/giJ8RBfx26UcF2bdhqXAfbN6HDo+v07dWtDgpJC0P5n50ID5YbLL6lIkAqW66S/sSROHf69RfKVTMbgWkzGwQdH/4K0zgQFeyu1kly7w10ENbCGVdwOkOqVCCy3uLTdU2Ty1pb89SD0yVCyLKE22HtEyLl+DnlTHl6HuL8tivyA7m451fk5jI6RxN0lScpBAzkk7bEg8/wDT2lyp5LgCpYIjUts0x5ZdrLD6rw5nciovO5sxONxM4zw4xB1EQ1I/0sjwUVNxhQUoMMVVZ0CYo789lb0cwdL39olcmeCk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2662.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(376002)(136003)(39860400002)(346002)(366004)(76116006)(6506007)(186003)(55016002)(9686003)(921005)(7416002)(54906003)(122000001)(66946007)(52536014)(26005)(316002)(38100700002)(8936002)(86362001)(66446008)(83380400001)(2906002)(110136005)(33656002)(8676002)(7696005)(5660300002)(478600001)(4326008)(71200400001)(66476007)(64756008)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?MXZZQWtVNDlndnBtL0JkT1Y1THczU0JjV3hyUVk0VXhIUHUzbGthSlNU?=
 =?iso-2022-jp?B?VE1RdG9MUVlyc2lOVnJWdTJnaGJKSlp0SG41Y1cvSzBjQVpMTGlCMXRs?=
 =?iso-2022-jp?B?ZU9RWVBzWmtvSXFOVm9HZUltclRPVDliK3JGc1hsT1ZzaG91bGN5L0p2?=
 =?iso-2022-jp?B?SXRWWkFpTkJLV0IwTU01TFBKSUd4MUhrNHBLNkgwSFhKU09Xa3R1MHVC?=
 =?iso-2022-jp?B?cU9RMWpDSFVPMGl5Y1BWRnpuMUhNR2FMenN2d1gwTVpRL0VnWUhXUlBp?=
 =?iso-2022-jp?B?OEJqeE84UXl4QWFwcGp3WXliRjdJWTJBYkM1cHU5b241RFB3ZkhmazV1?=
 =?iso-2022-jp?B?SmVxRHhVa0hMSjU5SXhuZnQ3WnpnTDZENFRFVkpxTmZGNWZNTGNwQTRX?=
 =?iso-2022-jp?B?Qnp6MVoxZUNBUU9DUkRNZ08yRE5sZWpYbE1VQkgrSWpQenlGa1NYaDQ3?=
 =?iso-2022-jp?B?dS9SZUNLTU9INExTMTN6TGxVT3ZvL1JpZElpSFh1U1BvUFdpQ1F1NUl0?=
 =?iso-2022-jp?B?OUQwb3cvQWxMaG9Remc1L0pUdFcrSm5TbUR6SnZuOEhHWGlpYnE0WUxy?=
 =?iso-2022-jp?B?eEthU3FQck1ZbU5nb1FHVzNuUXNkN2k4ZE5HdnRxTytCQWtmYy8wemFJ?=
 =?iso-2022-jp?B?RXpZaWkwWm5Ob0IxWlRaNFV0bzFXbURnbWRJTVNIUWdLL2hNMjRwNlF2?=
 =?iso-2022-jp?B?RDdTNy9aQ3NHVlpLSk5vZ21SQmtiVmc4blF5eVVBeWI3aVQxWlBiWjVX?=
 =?iso-2022-jp?B?WVdnMXhaKzhYTmtFN0c3Z21GZ0xRRXZMV2dlV21ISEpaajdrVjV2RG9O?=
 =?iso-2022-jp?B?Q04rNFVsOHJNL3BuS3hzVHIwMDQzM2RndWNuSmszRU9PcXJCMnZQQ0VZ?=
 =?iso-2022-jp?B?bWU4MUJpVGgzNXh4TjI4OG1FMTFiTDE3MUN0L0FFWmFnYTRlZG5tVlV5?=
 =?iso-2022-jp?B?MEJKZXBhN2plckZRYmxqd0kyVml6K2pkdmdqS2lBb1hpeFBMdGRvaWk1?=
 =?iso-2022-jp?B?WTBUeFVMMWo2S2ZXcHp6QW92RGV1cE04ZDdhalc0UVY3Y0JqdEZMTkt0?=
 =?iso-2022-jp?B?K2VkdjRVM0FqVURDaE41YVA4ampwZ2tBVnRlUTVTbUl2U3llTDdUMCtv?=
 =?iso-2022-jp?B?S2s3TU5FVHJRVWRERHg0TWorS1JRSThxZDUyVjlrTHRRaVdvREdVRU1a?=
 =?iso-2022-jp?B?UVl2T1E5NkhjN1N3d3NEMk5vdjBjK2VwbWwxak9JVlV3RWdPbDhvVERl?=
 =?iso-2022-jp?B?d0ZKaVBMUDhleFQ4ZW53Y25xckExMGVIb2lLWnR2ZDVCRVQwY1hUMEpR?=
 =?iso-2022-jp?B?dzRsd2t3S1dJL1lISlVub0lSazdESjBIRG1zY003MlhidUJ2N0FWd0I5?=
 =?iso-2022-jp?B?S1FHS0V0NTBLajlhRUFQYXAyMC95SGtjUTkxcS9FZ0c3emdJdUdqSlJl?=
 =?iso-2022-jp?B?RUxUV2kyYnBHb1ljUWVVTXg1R0JmWHdmcEVYb3B0V3QrNEwwanhOZU5M?=
 =?iso-2022-jp?B?enRHYitmMUlsVDlMbmU3Mkk0bklCdEtnMGN0cUxqS0Y1SXU5ZVNYNzB4?=
 =?iso-2022-jp?B?b2o3Yjl5bmNjNVdrNmFBMnB6QStWY3pPekFFMDhGc3lzb1lIQlFNNWlB?=
 =?iso-2022-jp?B?UU5YRlB6MWl3a2g3SkZtZm9xcTFIb240S2grcVJ2ME5hMGxqTk5uZVhL?=
 =?iso-2022-jp?B?SVlWOEVzL3NSS1c1aHVvL1A2ZmIrUFRwTHVpek8xckNkYlJoblRPcTNn?=
 =?iso-2022-jp?B?NjFDa254NWw4cWZWblI5UGhVTTEyVGNUL2dpY2J4bUhXMjBVWm53Tkts?=
 =?iso-2022-jp?B?aGVTZHF6OHUwQUFwek5UYmFZU0dHZkJVUnd6TEtiOGVuclFsekJORUtZ?=
 =?iso-2022-jp?B?S0hxUHhDUUo4RkZXbStKRUtER014OVA0RkJQcHI0aTV5S0VzSmdid1Y2?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2662.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db28b461-4cfc-4e9b-7ca3-08d93ad36146
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 07:56:19.2306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vNMzDxVXr/DTa46hyW6s2ZMMYzNVwbmcBHNvyjR13vHuyg74TmN9T4L1J5SuYyJBzs0Zvbck8/sopvZM9AgSOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3592
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
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
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



>-----Original Message-----
>From: Jason Wang <jasowang@redhat.com>
>Sent: Tuesday, June 29, 2021 12:11 PM
>To: Liu, Xiaodong <xiaodong.liu@intel.com>; Xie Yongji
><xieyongji@bytedance.com>; mst@redhat.com; stefanha@redhat.com;
>sgarzare@redhat.com; parav@nvidia.com; hch@infradead.org;
>christian.brauner@canonical.com; rdunlap@infradead.org; willy@infradead.org;
>viro@zeniv.linux.org.uk; axboe@kernel.dk; bcrl@kvack.org; corbet@lwn.net;
>mika.penttila@nextfour.com; dan.carpenter@oracle.com; joro@8bytes.org;
>gregkh@linuxfoundation.org
>Cc: songmuchun@bytedance.com; virtualization@lists.linux-foundation.org;
>netdev@vger.kernel.org; kvm@vger.kernel.org; linux-fsdevel@vger.kernel.org;
>iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH v8 00/10] Introduce VDUSE - vDPA Device in Userspace
>
>
>在 2021/6/28 下午1:54, Liu, Xiaodong 写道:
>>> Several issues:
>>>
>>> - VDUSE needs to limit the total size of the bounce buffers (64M if I was not
>>> wrong). Does it work for SPDK?
>> Yes, Jason. It is enough and works for SPDK.
>> Since it's a kind of bounce buffer mainly for in-flight IO, so limited size like
>> 64MB is enough.
>
>
>Ok.
>
>
>>
>>> - VDUSE can use hugepages but I'm not sure we can mandate hugepages (or
>we
>>> need introduce new flags for supporting this)
>> Same with your worry, I'm afraid too that it is a hard for a kernel module
>> to directly preallocate hugepage internal.
>> What I tried is that:
>> 1. A simple agent daemon (represents for one device)  `preallocates` and maps
>>      dozens of 2MB hugepages (like 64MB) for one device.
>> 2. The daemon passes its mapping addr&len and hugepage fd to kernel
>>      module through created IOCTL.
>> 3. Kernel module remaps the hugepages inside kernel.
>
>
>Such model should work, but the main "issue" is that it introduce
>overheads in the case of vhost-vDPA.
>
>Note that in the case of vhost-vDPA, we don't use bounce buffer, the
>userspace pages were shared directly.
>
>And since DMA is not done per page, it prevents us from using tricks
>like vm_insert_page() in those cases.
>

Yes, really, it's a problem to handle vhost-vDPA case.
But there are already several solutions to get VM served, like vhost-user,
vfio-user, so at least for SPDK, it won't serve VM through VDUSE. If a user
still want to do that, then the user should tolerate Introduced overhead.

In other words, software backend like SPDK, will appreciate the virtio
datapath of VDUSE to serve local host instead of VM. That's why I also drafted
a "virtio-local" to bridge vhost-user target and local host kernel virtio-blk.

>
>> 4. Vhost user target gets and maps hugepage fd from kernel module
>>      in vhost-user msg through Unix Domain Socket cmsg.
>> Then kernel module and target map on the same hugepage based
>> bounce buffer for in-flight IO.
>>
>> If there is one option in VDUSE to map userspace preallocated memory, then
>> VDUSE should be able to mandate it even it is hugepage based.
>>
>
>As above, this requires some kind of re-design since VDUSE depends on
>the model of mmap(MAP_SHARED) instead of umem registering.

Got it, Jason, this may be hard for current version of VDUSE.
Maybe we can consider these options after VDUSE merged later.

Since if VDUSE datapath could be directly leveraged by vhost-user target,
its value will be propagated immediately.

>
>Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
