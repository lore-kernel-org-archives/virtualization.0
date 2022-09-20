Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6DFECAAD8
	for <virtualization@archiver.kernel.org>; Tue, 20 Sep 2022 06:25:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C4A1818D7;
	Tue, 20 Sep 2022 06:25:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C4A1818D7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yp0l1HKV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MflFVkGRC0L0; Tue, 20 Sep 2022 06:25:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 19995818DC;
	Tue, 20 Sep 2022 06:25:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 19995818DC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9525C0033;
	Tue, 20 Sep 2022 06:25:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE1D6C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 06:25:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AB0FD818D7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 06:25:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB0FD818D7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X_iyTiGEGIPW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 06:25:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EA255818D4
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA255818D4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 06:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1663655102; x=1695191102;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FDNstmXoR4VpGnQaBo7v7agbu5IhmUNn9SWFSkCDzoI=;
 b=Yp0l1HKV7wnXFH8jVIT8Cqt6WwzGWo8O78Qp2buXEqGfCi/HjpBzReX+
 Lo7MqfLTAv6UNucLwAqb3W+udnm0deHeunDQSSUqHfSFyVbjUER3p0hg5
 G0Wc99G5WuBVTclnzJU79qamJXAmwQLCvzqHUlf9DbErYHgr1gfb+QNkp
 WLSyLouLKLnGn3DjuDYnXrf/3OHoMcLIZKg6ntD7jh+r1mWs30rxJXri2
 e1vuT7rmvDKmeHcTvXDgb/eaPNyMykmAt0/r9wHv9N07DfDUW88u6tlyj
 w5cvaqNnT8LkWLxNKGFlLclbundhfjYNsziamcnRqcdP6YkjuKcreCUzx g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="297202413"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; d="scan'208";a="297202413"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2022 23:25:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; d="scan'208";a="722611863"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga002.fm.intel.com with ESMTP; 19 Sep 2022 23:25:01 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 23:25:01 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 23:25:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 19 Sep 2022 23:25:00 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 19 Sep 2022 23:25:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLi+NLqHPN564FDYm30T2QgBK1IU0cRWy0ShQyETeBf83dFsku9rkD6VHp4o58sKrJP82HE70U+pGSZhyxbPfT5Win4MRfUJ+l6raBc9h92GtEfneIv0QhPLCdDopuE+fRRG1pqYo2EcxHGXDN+hDzaVycfbr1xJbtau3b4qukmXrQNq9Al6sex4QasblP0qxTDsmHtUI4eqHgf1S/ENdEAUTPFSAJCDsUIvnMshbiNKvWoRCo7rVfgkowvVUIa8MUYCjzD2SLil+9fXig9lYDvuX4QzxjLtegf3CDU7Mel86tFvgDk/rdQX8E0PMvebAjQkqbhgdX+79mpyhCcNGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDNstmXoR4VpGnQaBo7v7agbu5IhmUNn9SWFSkCDzoI=;
 b=YVBGQAjXfSiEuSZit0gqUbOMWY4Y37rsUWzjyqueW5icBbIVREPg2Wqr2ovAK1V3JZdFJ3Z1CMWRMKlx6Gel1WCRPmiEr03Takml6nFgXW23+zQ7BTjgkukepvs6xkwgmTc8ZypPB2Xs2a4ojkTEs6d1YXZt+ilenHF9yos3zxuzM0yaeIoLFJLq8ZWLT8OzMTnL7qHauN45AsidBVtstDyT3blR931w8f1gFpCJRBOQR5WgR4nCs6/LiYfzP1s8lIhhD/G/6vIGLzLXALxzXKMkF/xlWH1fpac8CQk6ciRx8I5UswbRZXUTHEGcmuH8fNPsuKh/ynioKbm0LlonCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB5992.namprd11.prod.outlook.com (2603:10b6:8:73::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 06:24:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%6]) with mapi id 15.20.5632.019; Tue, 20 Sep 2022
 06:24:59 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "robdclark@gmail.com" <robdclark@gmail.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "agross@kernel.org" <agross@kernel.org>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "orsonzhai@gmail.com"
 <orsonzhai@gmail.com>, "baolin.wang@linux.alibaba.com"
 <baolin.wang@linux.alibaba.com>, "zhang.lyra@gmail.com"
 <zhang.lyra@gmail.com>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, "sricharan@codeaurora.org"
 <sricharan@codeaurora.org>
Subject: RE: [PATCH v3 3/6] iommu: Add return value rules to attach_dev op and
 APIs
Thread-Topic: [PATCH v3 3/6] iommu: Add return value rules to attach_dev op
 and APIs
Thread-Index: AQHYyNhcD9ZFo0m4WUqxul85/3z4VK3n3wvA
Date: Tue, 20 Sep 2022 06:24:58 +0000
Message-ID: <BN9PR11MB527658C31268EB4A8411EDE88C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1663227492.git.nicolinc@nvidia.com>
 <822a983febf7e259aa2aca70dddd382810b96117.1663227492.git.nicolinc@nvidia.com>
In-Reply-To: <822a983febf7e259aa2aca70dddd382810b96117.1663227492.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB5992:EE_
x-ms-office365-filtering-correlation-id: e8ef6ed8-24c9-49a8-3087-08da9ad0d7aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u87wok6pLFZWVIV7vgdD8dqpMiLPBJhMYYQrmPBOh4Zq456fmX5CDFGhZhuVUjXlgQl9CWD/sDfPXmoS1pMDzjRMUS1TKDPqnPYtmtGur5Gl+IkdUEJtVsXmMTlF9H4GivejkouH1Vxm4/jHZeJLr+YEXJSdwi1P5KEfOcDjNpQX+wc7OrlE934JpcmfasFMyd04X8V5Geo0mZhR9awmcuU8H/apOaq8jPx3WGKH0to4ZdL25heZO1xOoZD8CwNDgyo1/lQg2RzYswgzmwEgDx54HfElPUadQJ9k0+/SRWxUBpxHVkhY92DOCTWesTmvm/sxYnKLZ1zKkwOGQLiERUxu/ie94fJWQkYWhHfBwDUzl6Ti7iBo4e4WYop4qoUHDrWnpMgZ45SYZlnGH5+O/JlzCdDlygayDSpH54iUz93+UNSfpYXmvp0X8oEf4si+NLA5qZwIHPJF+2931v7y3PhFFE6H1hotIXWcJN5pLLqH7x3QIXwrf1Zzqm1Yq+dz1mGDjmhFTkTocHLccOjSQlXgnGqPSqww7d5bCPOdoJeJ5dUGHmG0GPrUNJNTHH0F6qO+iTBcrqnq3Zv5NcUh+gBydKxKdRU6gBPB8yCpYdKfmtyFE5bRXIiY5lZn279rpzR+4lHdA7p710yeUlJayGSD5HCkwUE/qXpwhe7V1uE4KgrBeZAcIpFj0JT8RpXzw19DbS/TP7hrIiqHHOZcz0Z+NN2XVaZVtAaCGdrS+jaM2DU9T+oAhTQ92/xUsw/16JUsUfl+OzHj6A5yoSVHmw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199015)(921005)(2906002)(66556008)(5660300002)(7416002)(7406005)(52536014)(33656002)(8936002)(86362001)(66446008)(66946007)(4326008)(76116006)(66476007)(8676002)(122000001)(64756008)(55016003)(110136005)(54906003)(316002)(38100700002)(71200400001)(478600001)(41300700001)(6506007)(7696005)(26005)(9686003)(38070700005)(186003)(83380400001)(82960400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7LCpK6EfT48o/dLwzRCkyyWrdyhJngpDbbElnHfsOLBCSsDTRdiFmLHsTgup?=
 =?us-ascii?Q?OtGSD6ZzneBowM2eoU96kGVjzvjsOO6CK1OIwcGzo1eNSuLIz7xCo2BW4Dpv?=
 =?us-ascii?Q?DJIJ6lTBKm4TTU9WVCFXLEWXTqaa0Pl62Ks/3ytG91A81SevzSytRuSI3uZ9?=
 =?us-ascii?Q?LHg1S+u94a2phpUNwxB0CSlMIEQuYEJCISloxCrq9cj9ZGW86zOpI2aqdlnA?=
 =?us-ascii?Q?k2s2+d49KFUkHhm9U9tDOu8AKtrHAMNusLbnKCvZN1QHQ7DH/3xpjpnOjM9p?=
 =?us-ascii?Q?ZcwrpoIE+PIgW02Wm2yHKHnZwSVNdZgTzNP5DjET8wS2iN/to6kTeI5OsCha?=
 =?us-ascii?Q?17rT5J3g2SZ8TI2k+Kw/04qC9zVa0diqw2pVEmPpqsyX7eb2ZU/qmpaJCv1g?=
 =?us-ascii?Q?Ky1Hji81cPiGj1LZ/KyPoUInS+dAWGoAD/95P1/kUoz/yvOTv72BK3CsNqhy?=
 =?us-ascii?Q?nDXPtDvPKzXPim7wphWvjIWFdu6wogCyoEU+9FdNhZZQWyGWtB7SusL+JDVE?=
 =?us-ascii?Q?Dc+iJfYodT4YSBpcOvqV304m9lTqEXf2mDXrOrPLmaLy3jdYDzScNN+MJxOV?=
 =?us-ascii?Q?OLb+p6QCgoFn7l7rZWGysF7XmlS2cic2Aw0ShlkSrj98Q/nrV8cmeV6wSOWr?=
 =?us-ascii?Q?4Iaex9QQQ79yAvUXbafiIArjff/FvpUQCvhbBR4HKBu9/ZLc7NMfbmSlwEDG?=
 =?us-ascii?Q?wzSz5aGvcGQjTUUulol8rkCkVIGRnc2ZEhSTn3JcMREM7s7FDfl/FtHtDgVH?=
 =?us-ascii?Q?11ulqIWTviuubaYoGpsBz9QKrWKvkurvX5VJzYKuYYrWGZHL/YRvMnd5JyGK?=
 =?us-ascii?Q?ASS143eAsNiIb69BgxUZ+0AT6FSGc5UHcG9t602dt62O+HF+ukAoyMW34hBW?=
 =?us-ascii?Q?gDnypJ/3CVIMvRLjjzFM1Qr1SPKN5k8CBIOnIPqY6M+UXSfhHkSHKQ9IkJlW?=
 =?us-ascii?Q?5EwZOMuD677swvY0fsql+5h79vdAMFGEiYeI1LdiDpXhgEGliMQ+WmlKpvuf?=
 =?us-ascii?Q?PsVNBY9VWfZWiLCZANsCrfD2ASk+Pm9b5qmERZxrVcz5LUl/nnukCuNIHi+M?=
 =?us-ascii?Q?pSSMhKWYhJnheWDvlNLCh04KUUCfT0R/RSAks0dpXQnGyyjPRXQB3jyI9I/t?=
 =?us-ascii?Q?nRlbPuLlKatUdBEVRB9k5E5MkceH+CrSu3cUhxKRKVwS7ug/WVK2KUfs1Tvy?=
 =?us-ascii?Q?J/41zqxTBGlEG35NZEWXaF8d2kBN2bVvZEe3qwGIZgwQfwUJT2sNY6Nq/EhH?=
 =?us-ascii?Q?2ipilFPme+izqNe0Bz1G70ENcNH/zMgm8LbLb1sKGRZfMnAoul7N9Lyk/Qcm?=
 =?us-ascii?Q?ag28SD762PQDIzsn6NMel39qFOjeILq9lYC4VTpfe6jXhypjpzQ9S0D6Lng7?=
 =?us-ascii?Q?Ovw7TpCmQc2a7P9oMcdRJ5E2rF6H4s8HNNVPEvFdK58xbgnJeqBrJYmqdTcp?=
 =?us-ascii?Q?3pK9Xyy1js/hWGOjshx9OfPf10A2f/xOUUlQMfe8hYtb5b1hu7MDpP18Mwe1?=
 =?us-ascii?Q?fjrCgdTv99khvuwrOWBrBxNyfGQ+1m1Vwkb3nbnNipj0SM28wQkMNARNNZev?=
 =?us-ascii?Q?eaAYqB+m43PBHMZABUyjRvC1cja2jbHoofdpoIS9?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ef6ed8-24c9-49a8-3087-08da9ad0d7aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 06:24:58.8320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 566OKA/1Is7VKXR/3PfsfyplSaCTRfXYM5QUudn79yC9zzXwD/5yWeWpklP2IGUPohs/ZjlYUUgzhsLmsT/umw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5992
X-OriginatorOrg: intel.com
Cc: "quic_saipraka@quicinc.com" <quic_saipraka@quicinc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jon@solid-run.com" <jon@solid-run.com>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
 "konrad.dybcio@somainline.org" <konrad.dybcio@somainline.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
 "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
 "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "yong.wu@mediatek.com" <yong.wu@mediatek.com>
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

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, September 15, 2022 3:54 PM
> 
> +/**
> + * iommu_attach_device - Attach a device to an IOMMU domain
> + * @domain: IOMMU domain to attach
> + * @dev: Device that will be attached
> + *
> + * Returns 0 on success and error code on failure
> + *
> + * Note that EINVAL may be returned as a soft failure if the domain and
> device
> + * are incompatible: if the domain has already been used or configured in
> some

I didn't get the meaning of the 'if' part.

> + * way, attaching the same device to a different domain may succeed.
> Otherwise,
> + * it may still represent some fundamental problem.

I'm not sure what the sentence after 'otherwise' actually adds to the
caller. There is no way to differentiate incompatibility vs. fundamental
problem, hence pointless for the caller to know this fact.

IMHO just state that the caller can treat -EINVAL as soft failure indicating
incompatibility issue between domain and device.

Later for @attach_dev you can add that driver may return (but not
recommend) -EINVAL for some fundamental problems.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
