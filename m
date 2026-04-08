Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B81B366549
	for <virtualization@lists.linux.dev>; Wed,  8 Apr 2026 07:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775631888; cv=fail; b=Y7iJ05BroWUTwprax+KfmI8XrzfZXKkhSJmItfV8IdnGIu0760gfAn8iD9r93A7rXB/j5CIG2sOhlUyAUsZOy50hAaRp6vJGZ2kRnln9Qhh+Yy4j40FM/R83+JpUnren8LHa5qeAAv6K0fhDZBrYRk8XR6adxxkvE54zxHfv2G4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775631888; c=relaxed/simple;
	bh=C/QIGMiHWzUT8k54IXC2P5Ztr+C2aaFhLSFf+9yZFc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mgU1L9QwxyHKqZkYLEJ4wx0IUItRMU5Jqh0DYE9as8+BLISDG+VG+T1sy/BZ//ll3e3WxS/G506R0kOucThDc0z5LEAFgNJlz6OJ4c7gwGOSrvybo9bwU2PiwBnRWqOpT34amR7WExd/OofUkxKX7l9riAyLK1wcuAu41Y8dxL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ozceKwqV; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ozov7WHh; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ozceKwqV";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ozov7WHh"
X-UUID: 37b52554331911f1ae70033691e9ac7d-20260408
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=C/QIGMiHWzUT8k54IXC2P5Ztr+C2aaFhLSFf+9yZFc4=;
	b=ozceKwqVpZD5tjd7epIRK5QYSv8Qc0/LAFRNvbbQnQ68Kbh7myRfPLKOYNmsKD3HCqAguL1C2g9qnEkNHHdaV6NONJ7cPcBbAcvhln3jf7ywXuX0oabTsbAD7vt1x6RgSW5wmMm2hW57j4wOaCSnIi2WwS1d2wiaopUiWwfaHss=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:b0d4c4f7-b75c-4b77-97cc-1f176585fbd5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:e1f19cd5-060f-4ecc-9ee0-121eeeb4a682,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|80|1,File:130,RT:0,Bulk:nil
	,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
	,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 37b52554331911f1ae70033691e9ac7d-20260408
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <morris.pan@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 477020896; Wed, 08 Apr 2026 15:04:42 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 8 Apr 2026 15:04:41 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 8 Apr 2026 15:04:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NM8Gqx4iCHg9fdsKBP1QpZdxS4WozY1rcabE6PQ2VqXj78NKlqWqXq2CiP8KJz2hboVmgK6F4WVHTk6K5zyfgvX011poh7LlKN5CdglwONEUJzpfflsQbt5vbJFUHaXn6BkjFpzyFkhdV8DVgnkP7MTSVjn5OZjEYSFG5T4nzyxxpRGBwgKvFohSaOPMJYO73IKFUyIvFyLpMGr/W0bfxPHVPTJTaeCmMp94Ewxedsh1/tWDSMMPDIzvpAUyIStIIlKNz20DrwO6MungtmQxGIaWLlHWpunqQvRQPh5v2os7gLejPb30DFaqUezbvK+zG7y+oPbZNmZsHGR+aahQng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/QIGMiHWzUT8k54IXC2P5Ztr+C2aaFhLSFf+9yZFc4=;
 b=GwZeWHDVGmcyS1LbPEcgWQoMcpdmbLDMIE52su4ZfSWZqoBgkJ1Lx3Q3tkyMm5pxaBg7KdDMGxDT5+UXxUtyrUSk1WwvH3TBaov3x0769xctkriZKclMGTsKKyqJs6c/TbPS4qX4dyUBXJNhMRxB87MRVYtXgbVaYfmdgubSrGiTGT1T2MizIYDG/m1kbkvOkuEW/dBhXKgXJfExZVKZjlj19aBXKxo5fTSue3aCA2vOu/SkyYkpywH7GFfwwkdaREsi03ySlrbsu0yzgnuhTYx5FU7paA/7a94kg1kMqNv9GA9NCJDRNpY+j3+VEdnfRbfeIDpVUcB+vPv05F150w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/QIGMiHWzUT8k54IXC2P5Ztr+C2aaFhLSFf+9yZFc4=;
 b=ozov7WHhwM15EqVzMZe/QSVb+6MsXV2+LBL2lVZB+UzQ1W39pNZIBVvhp0T0f3AZdCMASDL/SOwzb5AxthxCfG2dSBle7J+90W9mVh+YhnGkSG218GdTpph2kiTUAIyWisbHmAxDpCNYMZYwR+2aq5C2BEpGj9qsIFSE38LvWMY=
Received: from TYUPR03MB7137.apcprd03.prod.outlook.com (2603:1096:400:344::14)
 by KL1PR03MB7365.apcprd03.prod.outlook.com (2603:1096:820:e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 8 Apr
 2026 07:04:15 +0000
Received: from TYUPR03MB7137.apcprd03.prod.outlook.com
 ([fe80::be01:24ff:a95d:a7e]) by TYUPR03MB7137.apcprd03.prod.outlook.com
 ([fe80::be01:24ff:a95d:a7e%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 07:04:36 +0000
From: =?utf-8?B?TW9ycmlzIFBhbiAo5r2Y5rOw54K6KQ==?= <Morris.Pan@mediatek.com>
To: "airlied@redhat.com" <airlied@redhat.com>, "kraxel@redhat.com"
	<kraxel@redhat.com>, "dmitry.osipenko@collabora.com"
	<dmitry.osipenko@collabora.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "olvaffe@gmail.com" <olvaffe@gmail.com>,
	"gurchetansingh@chromium.org" <gurchetansingh@chromium.org>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH] drm/virtgpu: Add PM support for suspend/resume
Thread-Topic: [PATCH] drm/virtgpu: Add PM support for suspend/resume
Thread-Index: AQHcwZ5JG8otlcPAHU6mSWtMIDwtXrXJvSoAgAsLg4A=
Date: Wed, 8 Apr 2026 07:04:36 +0000
Message-ID: <efdb6b9debcb5bb71d6161f70a619d0e11d0c5db.camel@mediatek.com>
References: <20260401061050.1035881-1-morris.pan@mediatek.com>
	 <47e26c77-4efe-414e-a851-67791bde3a8c@suse.de>
In-Reply-To: <47e26c77-4efe-414e-a851-67791bde3a8c@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR03MB7137:EE_|KL1PR03MB7365:EE_
x-ms-office365-filtering-correlation-id: 56615cba-3587-49bd-2687-08de953d1868
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: Z6zBngzPExbxxZ2NYnx4oJkpEL/uR0yUnOosylsJOCegzVCx9fi45MQJlZb173KYSMGUVMiCGml4N41EYZGVzCp/bsoaAvyqdLhlCoSNInqk4UwWADcYbu1ig347aXdGCRTvnbQ5z9ptirNAC0ClACz2gEcbfimv/Vsk2e8yCjM5L5WNLTanl2e80gl8IHlhN8Dr8iai24JesRFORCYcH51KobALJiC/gziQsNizBrDzXf8vyHmoLfET3FAp8eJMOeWzOzGND5vyKku++gr0jwqcgW2Us5uN37C0ajk57jC6Oy30Ugm+9nEHtkokY5gBx35bX4LNRYdZVHYm7l3n2TmVGqznVY/nyx6m2G4mGWm9dYfHc+V/85Pty06HxyKeVR7BruvF4Ru1fL0AY7dTseyh4OueFWZcLNn3TVTE80ZJDTpC0aJ3hLcjK73oD2FrndWeUpO4z88uJ5WuBPDhuSDeUVgsmJp3sPyrMJiuQpHNPR7YKxpRds8rITLSFplmrRuaGUlrtV4vF4XxnYCdEoeeawpYEa12Sc7hJRFT9pq34pl0VBNMg8y01udrBGgV7WgKt5BlPDosXNbMwoNi62THMw3XcVy/51iFlWzxHAvTIEv/U45BVWSILASt/hNhHN330lxaReodEZH+VRMRL2eh47ZE/e5KvopjTCtPeyOylUM8FGmV3i6sqAOSbmHKLuLzzWcyQ8MBJwI1WBYtvTt2Ve/1eoL9+M9NfbbheGte24isDiDgQmAf4br641Sv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR03MB7137.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkNYeVNIa2JpTGpiQ3ZKS3BKbzBsUk9ONjRKeHRUOGRUTmxyNkwvYXlsYlVQ?=
 =?utf-8?B?R2ZuclRxYXl0WXo0QjlqNHZ3UmFUeFZLWlJhLzd0MkI5bXRmNUw2eVRBQmlh?=
 =?utf-8?B?VU5WbTZGV0k3VHVwVjJQOHZxdUdzcE5IaE44UWR4Mk4rendUSG1STFRWWFpl?=
 =?utf-8?B?ZEs4ckhaaHo4eXAwVDg3ZWZxdVFEdmMwd1psTk5WeSs4dDRFN3FYMlVKaGpk?=
 =?utf-8?B?dTNmK3NqM0RIVStKdG5pRWZlVENPSTV6NTNNZzhiN0VTcm1uSjhQY2ZMNXl0?=
 =?utf-8?B?ZGVZakFGRllBNEpWWmhnWUIxYkljeWpyZzZzaGw4dW4rVlRFbzFQZmttM09u?=
 =?utf-8?B?T0ZlK0Y1YmdGWmdrSzlLb0N6RUltZzRTMGZrYitVZVF5MHZ5N282ZHlSUWhj?=
 =?utf-8?B?UU53TDAyS0w3UjljVndBVFh1Y0F3WnArZTAwM2NvbzZqN0tFa1E1bXZtWEow?=
 =?utf-8?B?WHVLMHM2cHNHTm9QSlJwSG5USGRQMGlyYVAvZ3o0bmdiQ2xLNEN5VUhOL2Vm?=
 =?utf-8?B?YnZIQnYyMUpKOG1iTXYvL1ROTTJEdlMyWldjVWNBT01seWo1a3BudUpWcHB3?=
 =?utf-8?B?VFQyWDRRcGJJQlZsclhqenpKNTVOUG1vZ3g1VXdWcENIWHdpQ1FWTXJqQUJ3?=
 =?utf-8?B?S2FaOWpmUGRPTVphZmZMTlFPcGIyVkpjQ3JPdGFIRVYvTHlUWFRKd3B4QmNr?=
 =?utf-8?B?a0Vub1dBTU1ZTzhPM2EvcEdJOXc2RzNZMC9vVlNSVjFNT0UyK2l0VlVhekVQ?=
 =?utf-8?B?VjRYVHRiMDBOakZFWEFuYnRFSytmc2t3S1JqOGlvTG9XeG1JYmNScnhtNnhx?=
 =?utf-8?B?VktHZVBZVWV4eENpL3M2eWErSnp0bFVlL3duMThmNWZSRXNIZ0NGb3hmVVVM?=
 =?utf-8?B?WlZRb2JEV0ZRZnh3TFJXUGhoaGU4U1pjcEMwSWRubkxyYzREUGp5cU5HTSs4?=
 =?utf-8?B?N2NPM1VteUhXa1VpUHVDeiszdGREcU9mUkN6MVZWY1l3TmFvRWkxYTUzcjFy?=
 =?utf-8?B?eXpzZnBxVzBmY2xRTHNwQXh4eUNrLzVtZkVvVFJyTHE0d3RYTU9mRDRLcVRJ?=
 =?utf-8?B?TmMvdWk1b3JTSkdjbkFtRHNvZFNDZ0tQWlJ3aXlWWDgwcFVOWmpIMUM5ZDZm?=
 =?utf-8?B?d0pwOHlxRUtYOEhqVWF6ZjEyTENRTEROR0pqQXlHTWZONVFLWUpWVDhFWTBx?=
 =?utf-8?B?MVBmOVorQkhyN0trb2I3TWFnOFBlY2ZwaForWUllRUhxMEIvWWE0VlVUaEwx?=
 =?utf-8?B?M3IvajNBSEN1cEluZXgzSkN6Tm1aNlU2QTlJSmlrT0U0N0FWUTNKUGNCS0Fx?=
 =?utf-8?B?VUtpQ2orTDVQSXVFb25wWkV0aUZNa09qUFE0Y3JxOWkrSUljckhRQ3pTd3lS?=
 =?utf-8?B?ZzVOYTlzZFdEaE9IMTBYTzF5RWtIVlJlTUc4bW90L0pIK3JkanZGdW9hbjFh?=
 =?utf-8?B?ck9Ma0diNm1yVkluczJ1YlBPampFRFNxeXZlOC9QYlJmMnh4VWhzUkdjQTFZ?=
 =?utf-8?B?Smh6VVppbUl2NnRJNHRldDlPTDZKY0xxWkw0bm5aMXZMNU5kRHRURi84OXRD?=
 =?utf-8?B?dVd1MUhhcFZBTEV3RnhMRkZVL2hkaURUREpIYjFSU0FGblI3cFQ2aFFYdm96?=
 =?utf-8?B?OGlKcFQ0S0R5anY1SVFGZVliQTNwd2J0cThVVlVCRGdlVldrc0Q3bVJRM2xL?=
 =?utf-8?B?cGhvTk1QYkZYdUQ1akxsaERabWVyaExiMHM1VjRCL3dqSjIrMks2cW5iSUFt?=
 =?utf-8?B?eUVYcWlGKzB3NS9lUG1aRjVTcTN5SU41MVBzRE9SUk9JT3B0M3BtRUF6ck5C?=
 =?utf-8?B?eE1IcDFFUS9JdzhyYmhQN2VFaDU3enROeDQvWGR0YlFEdzVZVWdHZnRWcGpM?=
 =?utf-8?B?MDBMWlV5ZlpmTWlHVDlTeFFZK3VrNVphTFhSVGtPeFRDNmw0ZnJjemNlWHZx?=
 =?utf-8?B?KzZzZG05b05Zb0lucjhKVW5iMHdVSlR4ODZHb0ZQcWZySmdRV2xRZXY5Szdz?=
 =?utf-8?B?N3lpQTByNXJ3QWxleDdKNWc3blZKSnptOXRoY1pmbEVickIrYnRKL2p1ME1M?=
 =?utf-8?B?bEl1UTVubFA0V3pjV0grWGVtaXNKUXA5REM0aDhtSGo4c3Z1dnpEWVhjb2Rj?=
 =?utf-8?B?dnlQWGNrMHJhQjZPR2puZjZ4Qlg2QnlRc3E1S2JpTXdJcUxHUGVVeXRRYWhv?=
 =?utf-8?B?c1hzdFRNNHlxVWwrQndROTZDY1dFbFlMb0U3MkNsaFpNdFpIRlR5NTNINUhB?=
 =?utf-8?B?eW1WdHF4S3o2cDBPNVRXRlF6amhuUEswT25wSituZVY4TkhKZXVPUU5Nc2hZ?=
 =?utf-8?B?UUlRTnRuNHNZV3FJcisyMnNLVkZtWHUzM2lpdVcveGM4WTk5MDFuK1FlcTlr?=
 =?utf-8?Q?fZFaH4dcKTKoy28E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49CCD4573C9B6D4F91B8AFFDE354282E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uK0Kdz0SiUI+ruAeQRcJ7s4X2IFRj9IuGTPEYtL9AFhBzEQLQQfYcS0pkwMILjhXU9NNhGEHGBLEjWXhgrXWnli+0CUFHtuU5nfQ2kJZRz7JD0RxtsF9ClWEdM3krmwwGixUtoZIlX1PVy6vjmwoI//eQa+l5j9/OhRPwEy7Ub3O87R6wOo/22l1QT67sUnJuWsO/JRebDq3tYi1NPqIkF+ZxFG2yAocffjrk3m4m2JPCblNamb1peKuG1MLTce9XtxaUiwAJf6n+MvIjYWVXVo+mDc1NkwXmXdcoEeca/BICyI45M95KO5ActKmDvj8NMdHX7O1jwibDlg/uYZa9g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR03MB7137.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56615cba-3587-49bd-2687-08de953d1868
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 07:04:36.7647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1RTVnK0Ooe/lAKiiqz2lRVgDD/60ixEMktpxl//7KqaKE8G+xOluQ3LzJ8nGJRHws1UrMLVsrCzwtyd6dl7Amw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7365
X-MTK: N

T24gV2VkLCAyMDI2LTA0LTAxIGF0IDA4OjI0ICswMjAwLCBUaG9tYXMgWmltbWVybWFubiB3cm90
ZToNCj4gDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+IA0KPiANCj4gSGkNCj4gDQo+IEFtIDAxLjA0LjI2IHVtIDA4OjEwIHNj
aHJpZWIgTW9ycmlzIFBhbjoNCj4gPiBBZGQgZnJlZXplL3Jlc3RvcmUgY2FsbGJhY2tzIHRvIGhh
bmRsZSBzeXN0ZW0gc3VzcGVuZC9yZXN1bWUuDQo+ID4gRHVyaW5nIGZyZWV6ZSwgZGVsZXRlIHZp
cnRxdWV1ZXMgYW5kIHJlc2V0IGRldmljZS4NCj4gPiBEdXJpbmcgcmVzdG9yZSwgcmVpbml0aWFs
aXplIHZpcnRxdWV1ZXMgYW5kIG1hcmsgZGV2aWNlIHJlYWR5Lg0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IE1vcnJpcyBQYW4gPG1vcnJpcy5wYW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+
IMKgIGRyaXZlcnMvZ3B1L2RybS92aXJ0aW8vdmlydGdwdV9kcnYuYyB8IDQwDQo+ID4gKysrKysr
KysrKysrKysrKysrKysrKysrKysrLQ0KPiA+IMKgIDEgZmlsZSBjaGFuZ2VkLCAzOSBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS92aXJ0aW8vdmlydGdwdV9kcnYuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL3ZpcnRpby92
aXJ0Z3B1X2Rydi5jDQo+ID4gaW5kZXggYTVjZTk2ZmI4YTFkLi5mYmNhMGE4Mjk1OGMgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3ZpcnRpby92aXJ0Z3B1X2Rydi5jDQo+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL3ZpcnRpby92aXJ0Z3B1X2Rydi5jDQo+ID4gQEAgLTE0NSw2ICsx
NDUsNDAgQEAgc3RhdGljIHZvaWQgdmlydGlvX2dwdV9jb25maWdfY2hhbmdlZChzdHJ1Y3QNCj4g
PiB2aXJ0aW9fZGV2aWNlICp2ZGV2KQ0KPiA+IMKgwqDCoMKgwqAgc2NoZWR1bGVfd29yaygmdmdk
ZXYtPmNvbmZpZ19jaGFuZ2VkX3dvcmspOw0KPiA+IMKgIH0NCj4gPiANCj4gPiArI2lmZGVmIENP
TkZJR19QTV9TTEVFUA0KPiA+ICtzdGF0aWMgaW50IHZpcnRncHVfZnJlZXplKHN0cnVjdCB2aXJ0
aW9fZGV2aWNlICp2ZGV2KQ0KPiA+ICt7DQo+IA0KPiBJIHRoaW5rIHlvdSBmaXJzdCBuZWVkIHRv
IGNhbGwgZHJtX21vZGVfY29uZmlnX2hlbHBlcl9zdXNwZW5kKCkgWzFdDQo+IHRvDQo+IHN0b3Ag
RFJNIGFuZCBzYXZlIHRoZSBjdXJyZW50IHN0YXRlLg0KPiANCj4gWzFdDQo+IGh0dHBzOi8vdXJs
ZGVmZW5zZS5jb20vdjMvX19odHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4xOS4x
MC9zb3VyY2UvZHJpdmVycy9ncHUvZHJtL2RybV9tb2Rlc2V0X2hlbHBlci5jKkwxNzlfXztJdyEh
Q1RSTktBOXdNZzBBUmJ3IWowZHhrdW9vWVlrVFhxZ1J6THlvNTU4VmVzV29UTDg0Vmdrd2hSY3pW
eFotUFpsQmVMZzB2blk0QjM2cnRZVlJEVnBHbVRxVmpHS0pvRmg3S25WZWxhayQNCj4gDQo+ID4g
K8KgwqDCoMKgIHZkZXYtPmNvbmZpZy0+ZGVsX3Zxcyh2ZGV2KTsNCj4gPiArwqDCoMKgwqAgdmly
dGlvX3Jlc2V0X2RldmljZSh2ZGV2KTsNCj4gPiArDQo+ID4gK8KgwqDCoMKgIHJldHVybiAwOw0K
PiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IHZpcnRncHVfcmVzdG9yZShzdHJ1Y3Qgdmly
dGlvX2RldmljZSAqdmRldikNCj4gPiArew0KPiA+ICvCoMKgwqDCoCBpbnQgcmV0Ow0KPiA+ICvC
oMKgwqDCoCBzdHJ1Y3QgdmlydHF1ZXVlICp2cXNbMl07DQo+ID4gK8KgwqDCoMKgIHN0cnVjdCBk
cm1fZGV2aWNlICpkZXYgPSB2ZGV2LT5wcml2Ow0KPiA+ICvCoMKgwqDCoCBzdHJ1Y3QgdmlydGlv
X2dwdV9kZXZpY2UgKnZnZGV2ID0gZGV2LT5kZXZfcHJpdmF0ZTsNCj4gPiArwqDCoMKgwqAgc3Ry
dWN0IHZpcnRxdWV1ZV9pbmZvIHZxc19pbmZvW10gPSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB7ICJjb250cm9sIiwgdmlydGlvX2dwdV9jdHJsX2FjayB9LA0KPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgeyAiY3Vyc29yIiwgdmlydGlvX2dwdV9jdXJzb3JfYWNrIH0sDQo+
ID4gK8KgwqDCoMKgIH07DQo+ID4gKw0KPiA+ICvCoMKgwqDCoCByZXQgPSB2aXJ0aW9fZmluZF92
cXModmRldiwgMiwgdnFzLCB2cXNfaW5mbywgTlVMTCk7DQo+ID4gK8KgwqDCoMKgIGlmIChyZXQp
IHsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIERSTV9FUlJPUigiZmFpbGVkIHRvIGZp
bmQgdmlydGlvIHF1ZXVlc1xuIik7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gcmV0Ow0KPiA+ICvCoMKgwqDCoCB9DQo+ID4gKw0KPiA+ICvCoMKgwqDCoCB2Z2Rldi0+Y3Ry
bHEudnEgPSB2cXNbMF07DQo+ID4gK8KgwqDCoMKgIHZnZGV2LT5jdXJzb3JxLnZxID0gdnFzWzFd
Ow0KPiA+ICvCoMKgwqDCoCB2aXJ0aW9fZGV2aWNlX3JlYWR5KHZkZXYpOw0KPiANCj4gQW5kIGhl
cmUgeW91IGhhdmUgdG8gY2FsbCBkcm1fbW9kZV9jb25maWdfaGVscGVyX3Jlc3VtZSgpIFsyXSB0
bw0KPiByZXN0b3JlDQo+IHRoZSBEUk0gc3RhdGUgZnJvbSBiZWZvcmUgdGhlIGZyZWV6ZS4NCj4g
DQo+IFsyXQ0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9lbGl4aXIuYm9v
dGxpbi5jb20vbGludXgvdjYuMTkuMTAvc291cmNlL2RyaXZlcnMvZ3B1L2RybS9kcm1fbW9kZXNl
dF9oZWxwZXIuYypMMjI3X187SXchIUNUUk5LQTl3TWcwQVJidyFqMGR4a3Vvb1lZa1RYcWdSekx5
bzU1OFZlc1dvVEw4NFZna3doUmN6VnhaLVBabEJlTGcwdm5ZNEIzNnJ0WVZSRFZwR21UcVZqR0tK
b0ZoN2N2MUVEZ1EkDQo+IA0KPiBCZXN0IHJlZ2FyZHMNCj4gVGhvbWFzDQo+IA0KPiA+ICsNCj4g
PiArwqDCoMKgwqAgcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArI2VuZGlmDQo+ID4gKw0KPiA+IMKg
IHN0YXRpYyBzdHJ1Y3QgdmlydGlvX2RldmljZV9pZCBpZF90YWJsZVtdID0gew0KPiA+IMKgwqDC
oMKgwqAgeyBWSVJUSU9fSURfR1BVLCBWSVJUSU9fREVWX0FOWV9JRCB9LA0KPiA+IMKgwqDCoMKg
wqAgeyAwIH0sDQo+ID4gQEAgLTE3Miw3ICsyMDYsMTEgQEAgc3RhdGljIHN0cnVjdCB2aXJ0aW9f
ZHJpdmVyIHZpcnRpb19ncHVfZHJpdmVyDQo+ID4gPSB7DQo+ID4gwqDCoMKgwqDCoCAucHJvYmUg
PSB2aXJ0aW9fZ3B1X3Byb2JlLA0KPiA+IMKgwqDCoMKgwqAgLnJlbW92ZSA9IHZpcnRpb19ncHVf
cmVtb3ZlLA0KPiA+IMKgwqDCoMKgwqAgLnNodXRkb3duID0gdmlydGlvX2dwdV9zaHV0ZG93biwN
Cj4gPiAtwqDCoMKgwqAgLmNvbmZpZ19jaGFuZ2VkID0gdmlydGlvX2dwdV9jb25maWdfY2hhbmdl
ZA0KPiA+ICvCoMKgwqDCoCAuY29uZmlnX2NoYW5nZWQgPSB2aXJ0aW9fZ3B1X2NvbmZpZ19jaGFu
Z2VkLA0KPiA+ICsjaWZkZWYgQ09ORklHX1BNX1NMRUVQDQo+ID4gK8KgwqDCoMKgIC5mcmVlemUg
PSB2aXJ0Z3B1X2ZyZWV6ZSwNCj4gPiArwqDCoMKgwqAgLnJlc3RvcmUgPSB2aXJ0Z3B1X3Jlc3Rv
cmUNCj4gPiArI2VuZGlmDQo+ID4gwqAgfTsNCj4gPiANCj4gPiDCoCBzdGF0aWMgaW50IF9faW5p
dCB2aXJ0aW9fZ3B1X2RyaXZlcl9pbml0KHZvaWQpDQo+IA0KPiAtLQ0KPiAtLQ0KPiBUaG9tYXMg
WmltbWVybWFubg0KPiBHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQo+IFNVU0UgU29mdHdhcmUg
U29sdXRpb25zIEdlcm1hbnkgR21iSA0KPiBGcmFua2Vuc3RyLiAxNDYsIDkwNDYxIE7DvHJuYmVy
ZywgR2VybWFueSwNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly93d3cuc3Vz
ZS5jb21fXzshIUNUUk5LQTl3TWcwQVJidyFqMGR4a3Vvb1lZa1RYcWdSekx5bzU1OFZlc1dvVEw4
NFZna3doUmN6VnhaLVBabEJlTGcwdm5ZNEIzNnJ0WVZSRFZwR21UcVZqR0tKb0ZoNzRkajN4MU0k
DQo+IEdGOiBKb2NoZW4gSmFzZXIsIEFuZHJldyBNY0RvbmFsZCwgV2VybmVyIEtub2JsaWNoLCAo
SFJCIDM2ODA5LCBBRw0KPiBOw7xybmJlcmcpDQo+IA0KPiANCg0KSGkgVGhvbWFzLA0KDQpUaGFu
ayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIGRldGFpbGVkIHJldmlldyBhbmQgdGhlIGNvbnN0cnVj
dGl2ZQ0KZmVlZGJhY2sgb24gbXkgcGF0Y2guDQoNCkkgYW0gY3VycmVudGx5IHdvcmtpbmcgb24g
dGhlIHJldmlzaW9ucyBiYXNlZCBvbiB5b3VyIGNvbW1lbnRzLg0KDQpUaGFua3MgYWdhaW4gZm9y
IHlvdXIgdGltZSBhbmQgZ3VpZGFuY2UuDQoNCkJlc3QgcmVnYXJkcywNCk1vcnJpcw0KDQo=
