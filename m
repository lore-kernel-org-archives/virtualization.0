Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A383D79E5;
	Tue, 25 Aug 2026 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787644905; cv=fail; b=LcZzfIAegJKHMFCkAxEPN6rS6YQ9T8+bmHQ9fDQ2nWVsWXAq/QSUFhCQxPtD6e3jD6ztQs5CjdxFS4pCJRf+CmpChhfP23pftm/Qk89riN1r3cVAXTSy6Fi8e5snz1k67LclNHva7vYohu5DWEDc6r18xyZagVRPlWI+z1CfnOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787644905; c=relaxed/simple;
	bh=by1Gyo6e488w9yEhTX7kgQxzvdSGh3GfVvmBQ7I7XGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZeTwL/ulU2maailaXKr13XVDRWvjSMWRRi6jFPudsohxXuJWygNAWSD3kM4SxZ+U0v1pXwlww16gsfzQR8CVqh+36N09Evn7ggmgDqRLGfdfJX4zyEotOmN4hi9Hu8GBMd/BOwGZ5T8JszPLgxnal+2g/l3yNjFysycS1ZSuMy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FHygB37N; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=oakX2T+l; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FHygB37N";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="oakX2T+l"
X-UUID: 2d4cb438a05b11f1b1788b6acf885367-20260825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=by1Gyo6e488w9yEhTX7kgQxzvdSGh3GfVvmBQ7I7XGU=;
	b=FHygB37NiNiJHsg1CCbZruzsTuCxIBZWmNzZM0s5TWE0737FbPxzQbqPTT6xG/No1x17Kwc3Ufev71II/Zp7/XJl0kp1ndwapBW3xAXSEWEZmkOdoCJ84IsH1yyv9PbSOgw0T9ZW6Fdlw29/Mlcwxg2+nvqQlvB/44t1QTQF9J0=;
X-CID-CACHE: Type:Local,Time:202608251601+08,HitQuantity:4
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:5a0e2055-af1b-42ca-a145-2dfa1d6d19b3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:46733d5a-b6df-4ccc-9d42-d55c18672e6e,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
	1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2d4cb438a05b11f1b1788b6acf885367-20260825
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 615949842; Tue, 25 Aug 2026 16:01:28 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Aug 2026 16:01:27 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 25 Aug 2026 16:01:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6N3uvvzH+zZfQTBzq+PxL1NWaOjaFrilhjwBPj5i7xWJxZOeArWHFxY2MuONZrMdwXj974spCcsUy1T57nJhyOQMCqHf/sZJiizqDZ/efGs2dbeR60xDWt7kheCLriyt6QX9kspXXtrj3tvKCcpDE7o2ZpcTrPdkXb+gah7mJnqpkvNTG/Dnz7vHoRIafK4/5yQ/zvT+f3HfrO3NSWcGNeFxaxL3ezIe+f6ab4dFqwSNjEO1fYIfopZw74gq9iT3jrCmPCq4o8tQKT26zhz2joNvuYoYn6/F5fBioJC5YvvgXUYsxDpdfn5cusCpN3z9wEdAsYGdMqtaFMG892bAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=by1Gyo6e488w9yEhTX7kgQxzvdSGh3GfVvmBQ7I7XGU=;
 b=PMtkKfS2j0tt+1lsheqlEaMn3ShlEQwIBsCZkMMdWL1G1ntNoGFHm0IikvYV5wdwk/gfgbmulND2ayGgJvczkBTgeWat21mq3/RYJ42BjHpzDyU206yPlTtJabAMl17SI5yCDL7+DL+M+2Nx+hFUgVKjXcIyGTTU5mMmmaP+Nd+lIRxBIzyfKn/85KUpEajgbxbGFF/RztYFtRQUJ0ZqNGqU1EoTC06QzTMpTg8cRKtHwyLXnM8Tj0L3xyv6ZnJCROkcaqX37Hy/rkXIeyhS67ENTcYtObzstWPcY3LsJOFb8GtfKohkzfYNJQSCOQr9G/hCP56j40LNqdCpAi66jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=by1Gyo6e488w9yEhTX7kgQxzvdSGh3GfVvmBQ7I7XGU=;
 b=oakX2T+lGMB1r9b9AHLa6q6ZqB3i0V6owdnEWzlch0QVgxADXVMT1R3iJ2hfrjFi16MRFOBEqkgq4IJ+eMwiiWTFA9ZK3s1wIu2DzByxk6jAJT1P1sqlYzz6g3pwWXE7P7T0LhInN5+MHOXVRVpsx5OAqnzjZYLIY013Th+Ml5U=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SE2PPFE7689B606.apcprd03.prod.outlook.com (2603:1096:108:1::4ae) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 08:01:11 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 08:01:10 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
	"khilman@baylibre.com" <khilman@baylibre.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "kraxel@redhat.com"
	<kraxel@redhat.com>, "mripard@kernel.org" <mripard@kernel.org>,
	"thierry.reding@kernel.org" <thierry.reding@kernel.org>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"sw0312.kim@samsung.com" <sw0312.kim@samsung.com>, "stefan@agner.ch"
	<stefan@agner.ch>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"airlied@redhat.com" <airlied@redhat.com>, "tomi.valkeinen@ideasonboard.com"
	<tomi.valkeinen@ideasonboard.com>, "peter.griffin@linaro.org"
	<peter.griffin@linaro.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "alim.akhtar@samsung.com"
	<alim.akhtar@samsung.com>, "anitha.chrisanthus@intel.com"
	<anitha.chrisanthus@intel.com>, "mperttunen@nvidia.com"
	<mperttunen@nvidia.com>, "krzk@kernel.org" <krzk@kernel.org>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>,
	"sumit.semwal@linaro.org" <sumit.semwal@linaro.org>, "jstultz@google.com"
	<jstultz@google.com>, "gurchetansingh@chromium.org"
	<gurchetansingh@chromium.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"airlied@gmail.com" <airlied@gmail.com>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "laurent.pinchart@ideasonboard.com"
	<laurent.pinchart@ideasonboard.com>, "kyungmin.park@samsung.com"
	<kyungmin.park@samsung.com>, "alison.wang@nxp.com" <alison.wang@nxp.com>,
	"jbrunet@baylibre.com" <jbrunet@baylibre.com>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "inki.dae@samsung.com" <inki.dae@samsung.com>,
	"xinliang.liu@linaro.org" <xinliang.liu@linaro.org>,
	"diogompaissilva@gmail.com" <diogompaissilva@gmail.com>,
	"michal.simek@amd.com" <michal.simek@amd.com>, "olvaffe@gmail.com"
	<olvaffe@gmail.com>, "jyri.sarha@iki.fi" <jyri.sarha@iki.fi>,
	"festevam@gmail.com" <festevam@gmail.com>, "yongqin.liu@linaro.org"
	<yongqin.liu@linaro.org>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "Frank.Li@nxp.com" <Frank.Li@nxp.com>,
	"liviu.dudau@arm.com" <liviu.dudau@arm.com>, "victor.liu@nxp.com"
	<victor.liu@nxp.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
	"martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>
CC: "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 09/15] drm/mediatek: remove dependency on DRM simple
 helpers
Thread-Topic: [PATCH v2 09/15] drm/mediatek: remove dependency on DRM simple
 helpers
Thread-Index: AQHdGF5JFreZDChBQUm8+HaJgsVP8raunwsA
Date: Tue, 25 Aug 2026 08:01:10 +0000
Message-ID: <072f91fcf9c2ad8e5c4ac86171e5949a429efe56.camel@mediatek.com>
References: <20260720-drm_simple_encoder_init-v2-0-5020b630668a@gmail.com>
	 <20260720-drm_simple_encoder_init-v2-9-5020b630668a@gmail.com>
In-Reply-To: <20260720-drm_simple_encoder_init-v2-9-5020b630668a@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SE2PPFE7689B606:EE_
x-ms-office365-filtering-correlation-id: a9068845-646b-4cfe-6bb4-08df027f06e0
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|42112799006|376014|7416014|23010399003|18002099003|22082099003|11063799006|56012099006|38070700021|4143699003|10067099003|921020;
x-microsoft-antispam-message-info: jZaYo0j9YA7fF+enasH7yObJCzUtCwwx9P3wNQ++hQiKZSxfyhQnjDKb5hvTTQ/LiHY8G1T2y/7ndMC7VhqGbcDHG+k0eHfDxQ4p58bxNL58D5uI4TVfDVdhZp9/DrDpsC5PPpC7fAVKPhJgoMBMm/Ldy6vPyhJRv1OkYlnc4Li0GXOjqUP4RjPvlI+rsKsZplH8F3Nw7yUg6TW0QeJVBzpeuIyjh3S1D57xs8nqnxT3xwehIJ6lCzS6l1q2OgehbZkq2T+CWeBa4855xm6KF8XfrAopshcptpcPyJJ6y3xDI0BH+RlQcT/20wgpxPNTOIekaaJbbD1ZwND0XhvnFGw9PZeN34BTz9XjtCU2hMe/0FrRkpK8AR0yRd4AoGMSO/8LZQd38A6Q2QvCQS4S54AwUQreao7SQcmAOryTn4YjuLPy8+iL3fvBr/+xiUfPBYuRaG1h8YlTPDPv46cDLWgRZLYTwR5KXK64jCJD742cw33PmJ/drwillZejTH2N3ZEL+is6q4DvSQMt8z1fOhJADU3r9Vyd4kbIl/RKS3I0i3KCxMjVgM06nKz1bN44EFUYwar0cqGlU4SIbPiuK0d5vtKTSTJs0GLLuZYSmwO2bcIAvx+ZeEr7Vw8yQpYC1nlOe59ChfR1OmPOeEykwgxAGOD2CvJAF0AIsoyPbe6Yw2Oxd3zfkDTFrr8OQ/L/Of3QAYm0Z1OrgIM1uQsXNEyHjv/A377CuRofoqRtGk7+6nwjaGrZIyQukC8yQ9M9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(42112799006)(376014)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021)(4143699003)(10067099003)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2NBeHJSLy8yb3lTaTFheFJsSFIvYjVISFBQWHNlVGN6NVJXd1J4VHdxOFUv?=
 =?utf-8?B?cUpENUQxQlk2V2V4cWVOdXFjMWZkdjA0SzBYM2pxZjFGYkRNWm1Fd0k5Rzhq?=
 =?utf-8?B?VWtiT2thWW9SMG1GSXJkMWFzZ3RXUXV5UGplZk54NTVnR0VMU1Zpb1g2L3Zw?=
 =?utf-8?B?VHpmTnBWM3p1b1VmWTloVWM4QUZYSXpCRTVKNWJBdHA5S1FOM0dWNGh3YWZV?=
 =?utf-8?B?bEVHRkVJVklTVE5BS3lPMGM3eHp5eC9wSUFBcGhiWnY3NlhFbi85QmJnVHJC?=
 =?utf-8?B?Z01OQUtEVFpUaS9xS2hYLzdKdWxoNHpEY1VTdGlsTmMvenAvZDU1dDE5T2Fn?=
 =?utf-8?B?bTVYVXVRdUoybG9JWjVOTVFBc2VXdndEUzI1ekY4L1E4Q2tKTkJsYWFTTkdk?=
 =?utf-8?B?eUM3c0lDbGVwRVpJVzJ2L0V2eVBDV1JXa0lzZ0lZWkxiQTlJdEhrbkp3ckZU?=
 =?utf-8?B?c1B0SFdyYVBBVFhQZ3ZsN0MvSlRTT3pEemFjRERBSmg5ZFFjYjMyMnQ3ck90?=
 =?utf-8?B?ZVZhMGdZSDhoa2pCQWZ0aGJQdUZTaWtnNzduVWxpY3F3Zk44cS9rOTlnZ2x2?=
 =?utf-8?B?U3hsRzhrL0c5eUVteHJvUzM2NkN5NnJOaktIRmpIT3h3Si9GQkdpSUkvcGRh?=
 =?utf-8?B?UG8xYTJlVkxJN2RZQUlxRkJRSXkraDkxc04rdHNwOEJDOTcydnBmY3ZxS2Zw?=
 =?utf-8?B?ODZYY0FUMjdSYlVtZjJNc2NoRXh1dHNYMk1pVCtLQ3A3aW9CL0FIRnRtOW5a?=
 =?utf-8?B?NG90aGdqYWI0eDBsSFoyNHF2bzAwQ0w4TVd2ZWQ2K0xwQkFSaEFaUFVqSDFX?=
 =?utf-8?B?alVzeFh6Rm9IOE5XYmZBZEsvL0pEeitxNHR5QVpOSDMvODhYSUk0Y1NBY2t5?=
 =?utf-8?B?Q0tsY3JmeFpWNCtRRVVYRkNpR0VYWmVIbjBhakJlaTRwOHdYaHFSeGZIWjl5?=
 =?utf-8?B?cGFDZGJwVWFvNmdTM0lkUUtDWjQyVE1NZWZ4ZERDUE0xU28xTUFTNkxlSDBR?=
 =?utf-8?B?ejUzcU5Ja1dWRS9JQWlmdFRyR2JOcXgrdENpUFcwS2xpYXB6dmxDR0YxRWVW?=
 =?utf-8?B?QmhVSVBnUkFud0QrYXBTTnZZUzEyS3BZVkJ4anIrQUhsSjErbnlrS1IyZ2dT?=
 =?utf-8?B?MDUwR3BqTXVlWm5WWHBIa1R6SXdORXZRcEZFK2JEVnpwNEFVS0dKTDI1d2ZG?=
 =?utf-8?B?c1pHc1hWMnNpWFgxMVh6S1ZQb0hScXYvZnYxVEhKUFBMY2lCajVDMzJWcDBZ?=
 =?utf-8?B?NzNiMGh4aGNXUlFLVlRwQkpscXBFRGgwNm9JWURpTW5LY0tNS0E3dExzRWtX?=
 =?utf-8?B?SWsrd3QzMjRGL2grRUJBbUF1Qjl1VkdUMkdySFhNR2NoUjduSzFKaTJ4WEZ1?=
 =?utf-8?B?aTRzVWx2Sm14Z1hlQ3pQNnBGcUtpWjd2QzNCNkJBZmc4OUcrbWVNYWNTeEZ3?=
 =?utf-8?B?RHNTMFowY25mZmZXUXdxTkpXcUhCL1VZQXRTM2lRZzAwZCsrMExwUU9BNkFh?=
 =?utf-8?B?WFMyU1d0UWpreXY3Yld2ZHByNDBtTW9XOEhBWFhjYURyK015amQ4K2tOdGpN?=
 =?utf-8?B?UHAza1VnUXFMa2tpci82MS9tQW8xZ0RraEdOK2M4b0wzY0Y1em1pVmh6NzZS?=
 =?utf-8?B?cGx0bEI3akw4dWlVWlV1RE1JTUk0dDhnVDVWejB4cS9tblJMVks1VGRrTEtD?=
 =?utf-8?B?TGI0WnI0S204Y2xzT1pkajJQTUMvQktCdGlMZ3ltRG5janYybGNBYld3ZWpC?=
 =?utf-8?B?OVg3dnRqL0w4SnlsLy85TWlNZEovS1g1bGd6NUF3Mm51eCtad3JaYXQ3OWFq?=
 =?utf-8?B?U293V1hMRFQzRkMvV28yeExnTDdDY3pqc3lENVRnYUpzUVcweXRHMFR5VW5C?=
 =?utf-8?B?OVhHTGEyTjMyaFhVNTlCVkd6VGxUVzRTY2taK25Ld3RueXl0UW1sZnl4QVR5?=
 =?utf-8?B?ckMySWVHVzRPMjNna1l3bitRNWdrb0NRd2M1a2VPNWhtbFVvOFcycE05QUpL?=
 =?utf-8?B?SFg2WG1GQmlka3k1NG0yaUxjcGVBaThjOWFyVWs2MW03UWFTVFdPSVV4cFZN?=
 =?utf-8?B?QkUxYkduRnM1K2NsdXRIOUEwVTBRNFFQTTF1UGVsbGlYYUFxTjdUdGp3cFM0?=
 =?utf-8?B?T3VOSTZXaXoyRXBnNmk2OFovQWlCMmJ3UC9DL25keW4remtYSk5KdEVlNHg5?=
 =?utf-8?B?LzFnaHdRWDFXM1hqOXlyRDdQQTl3ME1QVDA0bjBlL0ZhWTM5b2Z5a284M0NH?=
 =?utf-8?B?c1N0aTdQRkF4TStrUk9tUHNJalZ4T1NJU3hTNTlUdmlubG02MmlqSXpIWnNm?=
 =?utf-8?B?ODB1M2lUK2JBbWtCUWNBb3hUSmF4MHl1enFPak40Kzk5SUp5WHdpUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6B19C64BA4CEB48AD16E56144802F75@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0GjxKc/MO5YSD4c05ofT22LtOFYc35Yve6HCBcyVw+WlJxjzAtt4mprxR10Q47o7P3DNA6lPLIgrz/raUnnIG6MZGULFFtmB4uwCOUv3GBU1bcxJkt7UgbSf2hTZyfvi9w3YMDkJnB17eWO+CqxHtZOgQEg3nOdvAINB6CoiYC0PaXyTXd7rrCgCvrc3c3yBKNz3JN6qb5I2EHDTU8u2ZR1JfzB7YxJzSMtIMH+NuKlCrYj1BIEsUXX9OyFbq+vqgPXKZLl74qXqcdoeTKW3x0ggeHPycxug/zqH09oMJdzMmGSLSiNTE97VQ1bBDNV870lLjmQIYj9zuevWG4ISSw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9068845-646b-4cfe-6bb4-08df027f06e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 08:01:10.9241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2BPsES1aqHdUm9Vfno2E6hqAH712lg+wbaRw0Sek/oapyhGQ9ZAO9cNy+bU9HtskE/qxrbVSFW69zUX60XQ+hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFE7689B606
X-MTK: N

T24gTW9uLCAyMDI2LTA3LTIwIGF0IDE3OjQwICswMjAwLCBEaW9nbyBTaWx2YSB3cm90ZToNCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4N
Cj4gDQo+IA0KPiBUaGUgc2ltcGxlIEtNUyBoZWxwZXJzIGFyZSBkZXByZWNhdGVkIGJlY2F1c2Ug
dGhleSBvbmx5IGFkZCBhbg0KPiBpbnRlcm1lZGlhdGUgbGF5ZXIgYmV0d2VlbiBkcml2ZXJzIGFu
ZCBhdG9taWMgbW9kZXNldHRpbmcuDQo+IA0KPiBPcGVuLWNvZGUgZHJtX3NpbXBsZV9lbmNvZGVy
X2luaXQoKSBieSBjYWxsaW5nIGRybV9lbmNvZGVyX2luaXQoKQ0KPiBkaXJlY3RseSBhbmQgcHJv
dmlkaW5nIGRyaXZlci1sb2NhbCBkcm1fZW5jb2Rlcl9mdW5jcy4NCg0KUmV2aWV3ZWQtYnk6IENL
IEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERpb2dvIFNp
bHZhIDxkaW9nb21wYWlzc2lsdmFAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHNpLmMgfCAxMCArKysrKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
NyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RzaS5jDQo+IGluZGV4IDNmM2Y1NmVlZDNmOS4uN2NkMTM2YmQ5NjA1IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCj4gQEAgLTIxLDEyICsyMSwxMiBAQA0KPiAgI2lu
Y2x1ZGUgPGRybS9kcm1fYXRvbWljX2hlbHBlci5oPg0KPiAgI2luY2x1ZGUgPGRybS9kcm1fYnJp
ZGdlLmg+DQo+ICAjaW5jbHVkZSA8ZHJtL2RybV9icmlkZ2VfY29ubmVjdG9yLmg+DQo+ICsjaW5j
bHVkZSA8ZHJtL2RybV9lbmNvZGVyLmg+DQo+ICAjaW5jbHVkZSA8ZHJtL2RybV9taXBpX2RzaS5o
Pg0KPiAgI2luY2x1ZGUgPGRybS9kcm1fb2YuaD4NCj4gICNpbmNsdWRlIDxkcm0vZHJtX3BhbmVs
Lmg+DQo+ICAjaW5jbHVkZSA8ZHJtL2RybV9wcmludC5oPg0KPiAgI2luY2x1ZGUgPGRybS9kcm1f
cHJvYmVfaGVscGVyLmg+DQo+IC0jaW5jbHVkZSA8ZHJtL2RybV9zaW1wbGVfa21zX2hlbHBlci5o
Pg0KPiANCj4gICNpbmNsdWRlICJtdGtfZGRwX2NvbXAuaCINCj4gICNpbmNsdWRlICJtdGtfZGlz
cF9kcnYuaCINCj4gQEAgLTkxMywxMiArOTEzLDE2IEBAIHZvaWQgbXRrX2RzaV9kZHBfc3RvcChz
dHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAgICAgICAgbXRrX2RzaV9wb3dlcm9mZihkc2kpOw0KPiAg
fQ0KPiANCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2VuY29kZXJfZnVuY3MgbXRrX2RzaV9l
bmNvZGVyX2Z1bmNzID0gew0KPiArICAgICAgIC5kZXN0cm95ID0gZHJtX2VuY29kZXJfY2xlYW51
cCwNCj4gK307DQo+ICsNCj4gIHN0YXRpYyBpbnQgbXRrX2RzaV9lbmNvZGVyX2luaXQoc3RydWN0
IGRybV9kZXZpY2UgKmRybSwgc3RydWN0IG10a19kc2kgKmRzaSkNCj4gIHsNCj4gICAgICAgICBp
bnQgcmV0Ow0KPiANCj4gLSAgICAgICByZXQgPSBkcm1fc2ltcGxlX2VuY29kZXJfaW5pdChkcm0s
ICZkc2ktPmVuY29kZXIsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
RFJNX01PREVfRU5DT0RFUl9EU0kpOw0KPiArICAgICAgIHJldCA9IGRybV9lbmNvZGVyX2luaXQo
ZHJtLCAmZHNpLT5lbmNvZGVyLCAmbXRrX2RzaV9lbmNvZGVyX2Z1bmNzLA0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgRFJNX01PREVfRU5DT0RFUl9EU0ksIE5VTEwpOw0KPiAgICAg
ICAgIGlmIChyZXQpIHsNCj4gICAgICAgICAgICAgICAgIGRybV9lcnIoZHJtLCAiRmFpbGVkIHRv
IGVuY29kZXIgaW5pdCB0byBkcm1cbiIpOw0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsN
Cj4gDQo+IC0tDQo+IDIuNTQuMA0KPiANCj4gDQoNCg==
