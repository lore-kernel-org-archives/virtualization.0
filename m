Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A449ECAAD8
	for <virtualization@archiver.kernel.org>; Wed, 21 Sep 2022 08:15:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 248DC81754;
	Wed, 21 Sep 2022 08:15:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 248DC81754
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ie7/Y63O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L-54EEvtDlba; Wed, 21 Sep 2022 08:15:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 992D381750;
	Wed, 21 Sep 2022 08:15:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 992D381750
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68C19C0033;
	Wed, 21 Sep 2022 08:15:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAE5CC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 08:15:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B82B161002
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 08:15:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B82B161002
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ie7/Y63O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oxU3pa0LCqnp
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 08:15:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4504A61001
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4504A61001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 08:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1663748102; x=1695284102;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cFa3atSYGjb9czYL1Z2bgNwKxAXgXB5eTBOOf/WL9Qw=;
 b=ie7/Y63O+dxaF/FivzkHUYy2dKM9YKyJebWkUm3fWUqdA5leB/K7s8of
 NHyBOYpbmwPGz4479gZYSh5JN1Fe3sWbVkTY7nvyCpKLLsWhMs9WWM/f/
 AyQB1W+vFBr3dm5zk92S9LQ0Xi2D82wwiatne3k4w42Uqe0dtKL95lr35
 dpyNx6xDg9qvPQL2lX9nXNiegLrWznpB8akHlNx7wJ7cOs/Q7OL/FzHnC
 d6g2pQgfX63gMoz20cX3C/UsABeT5x87AJ6Va67m64IOGKZvTzSs3/bc4
 8mcl9DMTLOR4cWKn/38QOGI5J7wdzSQJ+x1wcmSJQeHkVHroenqKecwzh w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="301334519"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; d="scan'208";a="301334519"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2022 01:15:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; d="scan'208";a="744864094"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga004.jf.intel.com with ESMTP; 21 Sep 2022 01:15:00 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 01:15:00 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 01:14:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 21 Sep 2022 01:14:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 21 Sep 2022 01:14:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYhhffS8bMOsKtRPHAh/whRxFc82G1hlEEsq2x3R/fw0pw2yMDUha4mQS+j6mGvkCamKj1FnHrDkVYZWibGEo0IjV+cffa3Cklt0wFAKycNZ8c/gHN4i0AeoiU43k7oM7Enwm6dxCpGzoAnyzAXTrWSviZ4+ku8Fwh7DxbQPBEEViI7FZLR/1axK9qIXjo2AXLDN9WCUef7//t33HtHjwXz/ucKpONT4JeAnusWSCcQR0jcGtP1IRedXljhxi1xFVpukKpWQAAkxdmKT+O2+QjP1KyltvnQXRx7ADJK7vGRtPLaWPLqpTRkVqQo+S9Q7MKKOpfjRzTjbX0dEmEyHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T02z+pUrhlEIq3lz+LQuJ/cGbH1QwI18wkidfCW4GMk=;
 b=PEF4AsCY0cj8I94LCtMDlRlFXTj3+VeN+8cN85BLPw5XQCoOZTaj/zA/pC0dzh01gBmTpK/dT0trOVFhf1ciIeSGoTyq3yh5ACbTlz2/1ezo/pkT6MjCQ1Bm+Q0LmZcJAUQLfyKvybUiaM28WP7GPP/Jtudo1reKm3owXq/6yzwgPqCazbatwG8JLv+gcRds1sDpzSHUIBX9mumNYhhiURKPow6HZ6fJhPMTRL0DujJN1j7PEQTQBC9JWcTtKJ3/AfWXoPR4moz4wr6/4E2AjDl6veY2I06LvqKcnSY9Us1xiWWh3zttGmi3nO5ZCM9UiOgrUPnZExQ23ezmoMjG6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB7297.namprd11.prod.outlook.com (2603:10b6:610:140::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 08:14:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%6]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 08:14:52 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v3 5/6] iommu: Use EINVAL for incompatible device/domain
 in ->attach_dev
Thread-Topic: [PATCH v3 5/6] iommu: Use EINVAL for incompatible device/domain
 in ->attach_dev
Thread-Index: AQHYyNhbGOlsL7Jv8k2J8zrFcwHpQ63n4xNwgADCwQCAAOySkA==
Date: Wed, 21 Sep 2022 08:14:52 +0000
Message-ID: <BN9PR11MB5276378232A91ECEAEC4E2A68C4F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1663227492.git.nicolinc@nvidia.com>
 <effc9efd2160ec19500e1f4c59799991f46674c8.1663227492.git.nicolinc@nvidia.com>
 <BN9PR11MB5276595A0BFC49F096C2D3968C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YyoBPAE+POS0KfCR@nvidia.com>
In-Reply-To: <YyoBPAE+POS0KfCR@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB7297:EE_
x-ms-office365-filtering-correlation-id: d4c967fe-8287-4335-c463-08da9ba95c48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hD3cTghn47xXYUToD1uRXC7oR2BRWa8JBTnb2cABrvtI1ABt+k12lnI8IItVJWkksKOSELVA8CsvSXRffY4iN2eiBR5lW8oIur+fAj3tNSqre3bqSWuS+2NhLTK6aHp8+BcU30JojjvKddHjhuL2ACGvWBW3hrB288vSd9mErtdvjyF26TjWAkc1bt5mu1hsGwBaOSDs+bsQEy8XqQF+eIXb/WJk8LSXqWOCxwsRvBytzU8a6YrPyvyrzNRUCqTGfFLAlf3fU/7U7S5/o4sLIhMhlmWZdSsSr9pmYdeIBxS7YfAPGWuMJqlhf8YSQxBNqFSnag1gSmNZv2HV7+oXSBR30c62IC55PXifR2Xf3MHr+ld7/pED40QG4zDb+MV6h+Zuv5LaKF5wEPdOO2pU4qGy928ts9eiCHXGUX9MgRd48ARMQ48f3+NH05LYEMbpkXQWtjRNxaXQNvJoNa72EBc4W8VfCPz7tE1MoMhg4lc6uBTbcgtDbCQLLDeJqu/dzC2Ct+hytnWHwfC6u85HFmsjR/JQtx7DE2vLD1oxKQnoPI9Qor3W/ezOYZzNsRul+MpJ8Ak8kt0BkoB1rQkdT7vBDylkd6yIf2RbvYfaolgnFpzFU2NI+J+ErTocrtGXFNMCx5yhI32AFPpP3O5zfF5mMh6f+fuS9GzbnXHKqXiA6brXr2TEoFh2Qs9aYqH07upox1i3wkxSJvzO8S2F3nLjbpYKw8DzCUL6sRHVWZcS20fsGETCBNgeFQTnUuLO6P/jfCJErBqw/j5aapQcdA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199015)(2906002)(5660300002)(7416002)(52536014)(6506007)(186003)(7696005)(71200400001)(82960400001)(8936002)(7406005)(26005)(41300700001)(9686003)(33656002)(122000001)(478600001)(38100700002)(38070700005)(76116006)(66446008)(64756008)(66556008)(66476007)(4326008)(66946007)(8676002)(55016003)(316002)(54906003)(6916009)(86362001)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/Yl1RXdXtdzIiAnqZlvQ6ehm2+gtLSk9ZqlrCAQWSmXR9mwgnVXmJC36pC24?=
 =?us-ascii?Q?/kzZemrODzNMlz1iQzUGf9Mn/uaf1y/nuqftxskkrJKtH5IjlP6GoQAMR/5v?=
 =?us-ascii?Q?gAprV/VRPdHjoPIXgb335C9X8GeMGjCEPoD2HkDc3PgPKjb5bffW7W6n/4r9?=
 =?us-ascii?Q?hEdM+lGoHLWlOXOmFK2MRrFZyLzjbecFRufCnh2Gg72sa4xMY5owSYtu0AGr?=
 =?us-ascii?Q?i9OLevEdrBasbDepENn9Xdi+GjVxX17XS9VilEgnbmr5F8DEleRjZfZt2Ma8?=
 =?us-ascii?Q?RKRJeuQB9751wlGMEBYwdBa1F5u+PZDI5bgnq7VsVCJlA55aaSmTfdpenbaE?=
 =?us-ascii?Q?dCcdMYn4bF4LufJa6U6yKa+SqgSPygySWtvx8CUUFwHDJkd8Yb+3zNeqYYmS?=
 =?us-ascii?Q?ts955+lsVo3JoQPrB2I4/Ai8Sa9J6FFrxiZFNo5g6jW5YCHJRer59zk6Kirf?=
 =?us-ascii?Q?ejTHKh3J7VFMtzLiaWxaJOdXeTLBkJj5gUz5VJChlNN8mmE37vEZ8qUZir77?=
 =?us-ascii?Q?cf6nEgMjzy4psmC+y2FqVdC0CmgtA2UoLLHoq5TH48kdx57VF6Q58Kp7+xBl?=
 =?us-ascii?Q?Lxjsv95FFB+MUJ8QiDopKpI57AVJQuln6bSXAv8LISX9uNeNFixNjtXBwjKi?=
 =?us-ascii?Q?y6MrGVOAuKkQvNd246/qj/vv4AU/866FhnCc5PBdRX0sH8SiQvraobnNzi9K?=
 =?us-ascii?Q?/BoL6gKCXzitSxBSW7IDvwibP4fkOf1pRyzeS5mh03q3LqSEu1z2HCYb0C3a?=
 =?us-ascii?Q?Xoz43xYD2muJ4H7U4V8NzZpUwBh99tmjte8S9rTQx0yFb0lA3XZJg1WG9iXh?=
 =?us-ascii?Q?Qc7lmt8rc0qqUFG3hte9KxF/N+eCFk/Hl1+iq28qs/5T7rXM+W/BPECzzMfm?=
 =?us-ascii?Q?y6QYjWSxIpcf6W52loJ2wlV+vd0a5p2dwFFtND09EE2+027EONjeHZz9ZYzt?=
 =?us-ascii?Q?TBV1KFTB3Oi39exTPQxgGfUyZ3dmk/cTAe1bE5kXM/pW6viTcIWBnHvboBZv?=
 =?us-ascii?Q?UlWDct+pJPYVGPrbC10f/iho5NU5l/5yqF+UDISpFUabNO30BrLZISla7G5b?=
 =?us-ascii?Q?xyoBzjEXazfDSUdnWQ/cxP9YHPrCnHsfh1oKGNwgyfY0C/P8FtnmlOYEXljH?=
 =?us-ascii?Q?hXgdVxJ6CFjjtfWDCvSAyK6JuVSMOL4meqDuc1wSnIPTY60h4CgH+m2pP8Ys?=
 =?us-ascii?Q?TuZoOygtUic6bqSwD6jGstHQ5psBJjgm8eVN88HwU+NIVB+TuxXtDPlWp+XK?=
 =?us-ascii?Q?Bm3c+2OjvvS0eEhqBIbwDfuDYXiSLt/pjhko4tUXzmmyCrl90prITZ+E84lo?=
 =?us-ascii?Q?H/0r1VGBuyBEob+e19lt4lu3lOArqCVzOHdjJQZK/itOYbsPLVHrIrX0i1t6?=
 =?us-ascii?Q?wHH1XGJqdUhfsdleBzsGARINmcxTIVe/uSisrlxWN7lhERJUvoakosktxcF8?=
 =?us-ascii?Q?A7UDt6q+o1f20JGX2gb7VCnpm0LkyZI4sD5cbi+S5gXuvHtHRKcEu3VltPJ5?=
 =?us-ascii?Q?IvRhUVcCYzFqXPgyoULw0Vqr8NDpXlaloNxrJ3+GoBfoUEz51gxCxaM7kjPx?=
 =?us-ascii?Q?kU2l4DyqOQhgrBHWMY5JudBsTxNqqO0Y/oZfhnrr?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c967fe-8287-4335-c463-08da9ba95c48
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 08:14:52.5758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vfiCZqRV0PnF5//lwvRdGFSjUXvEkEbiUPCEYf8ONKGGyNe4p4C4LNYdxv7bj0ZgEz0+QTVoH2KG7fZxWT4y0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7297
X-OriginatorOrg: intel.com
Cc: "quic_saipraka@quicinc.com" <quic_saipraka@quicinc.com>,
 "konrad.dybcio@somainline.org" <konrad.dybcio@somainline.org>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "will@kernel.org" <will@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "jon@solid-run.com" <jon@solid-run.com>,
 "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "agross@kernel.org" <agross@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
 "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
 "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "yong.wu@mediatek.com" <yong.wu@mediatek.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "sricharan@codeaurora.org" <sricharan@codeaurora.org>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, September 21, 2022 2:07 AM
> 
> On Tue, Sep 20, 2022 at 06:38:18AM +0000, Tian, Kevin wrote:
> 
> > Above lacks of a conversion in intel-iommu:
> >
> > intel_iommu_attach_device()
> > 	if (domain->type == IOMMU_DOMAIN_UNMANAGED &&
> > 	    device_is_rmrr_locked(dev)) {
> > 		dev_warn(dev, "Device is ineligible for IOMMU domain
> attach due to platform RMRR requirement.  Contact your platform
> vendor.\n");
> > 		return -EPERM;
> > 	}
> >
> > since it's based on the domain type, picking a different domain
> > may work in theory though it won't apply to vfio which always
> > creates unmanaged type.
> 
> IMHO this test shouldn't even be here, that is why it is so
> strange..
> 
> VFIO should be checking if somehow the device doesn't support
> unmanaged domains at all. We already have several drivers that can't
> support full featured unamanged domains that vfio needs, this is just
> another case of that.
> 
> But it isn't urgent to fix, I would just ignore this branch for this
> series.
> 

OK, then let's leave it as is. Anyway this is a rare path. In reality
most RMRR devices are gpu/usb which are already exempted
from the above check.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
