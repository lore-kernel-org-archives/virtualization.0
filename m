Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C845415ADA6
	for <virtualization@lists.linux.dev>; Fri, 22 Nov 2024 06:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732257594; cv=fail; b=ZqyehvJ3LsoChh1mccxBWRAdCuHZ1eE2N8mJA5kAFR4zPvslg7uaIEMs1dhUGRewVnW8dZNj3eNKGPyQwHLCMmM/qsHKUC56KVKHdrHBCrUGYfRoAUJO2XyKWqPnYqnnvl6cMpbqWYqqPRJ/rHVW+nKSzsF1fhgvh12iPibWCNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732257594; c=relaxed/simple;
	bh=ht3W+hz/2AqAIy8cqGzfyf/k9fbyIjAil+QRq2StQdc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n78FTWb/FvHEc1vFVqJBeIq/aOemxOmJfyqmDC99ND0pzV/cQfnehqKVZLp6XwaHvnTUnSaC3DypxxPx9JX1MlV4R4ZkkYsJjmCeyuCAyM8BaNI1tXAi5+f9R1K14/huz0Q+Nd/XtTt25xAxowzKpfcz/uCHRW3OC+LHYvibyDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tw9hikfl; arc=fail smtp.client-ip=52.101.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tw9hikfl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAaYf5s9ydAP5UcetJHH/1s6PCUMdqjFrV/zgyw9AFdniYKE/bk6fpZA2UDGeOGhEUWi7dVJQ7q56zwxF096szO2ikLPAyklgJjSI45bfpFsOFGx0oKcEZUS8gO4C+pK3rIyH2gvcH9l0LTHcFc8SNyHnPn2WItcHsLCLFdsNAlguHft5VaMqArht9x4mZI9BcydbpsJCWxRWvpvqJNY5ezhboEPAU2xdlhRv1dsWGGX6uYThRBoW0LRUDVAOQrv0lWL63jJK5OM3Pbu/qDdGwICggvzYJmk9eUy7/mzVnI7gjSHMhQ/Mvz8ewJJJTftgFPAorUhSrUtB+o1zXDzFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ht3W+hz/2AqAIy8cqGzfyf/k9fbyIjAil+QRq2StQdc=;
 b=Mqqf2FaMXjECkNwkmZPFA1qJh2REVqAehQsbxgLPNA7mLPdg2IF+v/7XSz0PLmh9YVmXDbE9GkG3BzqT996TBW92NQxlOujof7eth9BArCsgP0OZe3Ubb3WV2mQkLsB+TRb5P8kZRN029YazSH5EEojG+9Zv1zkgLgJvG4h9JeVKqDmXEnYNU0pLbs06aC/uwnNCNagM+P94DOjXUK2AutiVYSk/cYSr2FnhE/CssQvNAEgOck/zr64K+q5j89gHSZVwbU3zwFZ7bc4TjbwrO8q4OyVHmPPyxKPNpNb9d1Kpt24Y47UiRikXLeMoBpOKVCGL2kZdj8kZ3iWvVyX5gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ht3W+hz/2AqAIy8cqGzfyf/k9fbyIjAil+QRq2StQdc=;
 b=Tw9hikflS+tare9QYQYm/mYt2o0s4pfVzMCzua92ExRG41KLqGROu3CfpEnOEG9mHOIrUhSPU5+3oJ2A9VsxjoWZ9v9fzxxoHkiT7mqFk5ZIn+2U9ZgBWwAnHD5fS8Qx8+8OGa1uoAm0VPJJGfaT4WTqSDYkxlJsP6c+zm7U48rWI5HlhXALSoP1pyGxNeywMAq3IfiDnLSJVCPbFAhJYbvBMQWzsvRHyoz/OmEsYX+bTSPDg8fxiM4/+hu3bb55jj4XnS6F553J3Jzh1t4jzhs4LP0Hq84VjaYTmiOnfTla4TycsGjlrtFBjsbk+EzVQqxtaRTwWeVGA5zwkhwBrQ==
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AS1PR04MB9454.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 06:39:49 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87%5]) with mapi id 15.20.8158.019; Fri, 22 Nov 2024
 06:39:49 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Jason Wang <jasowang@redhat.com>, Yongji Xie <xieyongji@bytedance.com>
CC: "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
	"mst@redhat.com" <mst@redhat.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] vduse: relicense under GPL-2.0 OR BSD-3-Clause
Thread-Topic: [PATCH] vduse: relicense under GPL-2.0 OR BSD-3-Clause
Thread-Index: AQHbOlapd3MuNgvMf06RTiQM5NeBTrLCkRaAgABDw+A=
Date: Fri, 22 Nov 2024 06:39:49 +0000
Message-ID:
 <PAXPR04MB9328FECAAF24B6731DCD15DA89232@PAXPR04MB9328.eurprd04.prod.outlook.com>
References: <20241119074238.38299-1-xieyongji@bytedance.com>
 <CACGkMEtzSKiMgEzZg3o4nugqqMt9DDXZKZ_LkfrbqpfVDQy4aQ@mail.gmail.com>
In-Reply-To:
 <CACGkMEtzSKiMgEzZg3o4nugqqMt9DDXZKZ_LkfrbqpfVDQy4aQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9328:EE_|AS1PR04MB9454:EE_
x-ms-office365-filtering-correlation-id: af5897fd-2751-4f01-f079-08dd0ac0765a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dmFFaWZrM2MxYnBPWEJVdFVENlVPVk9haXplWEVmWk5JaFZ3SWRUZWtnZmxB?=
 =?utf-8?B?L3pQTTY2b3lad09QdjhGWDltY2ZmcE8zV3pUZ0VEY3BIUHlBOERkNGZKWkFx?=
 =?utf-8?B?T3hVOUZnTDQyVXN1cWgraFp0VjZLOGJOTXQxdlhsbEtwMkcwblF5WDdqcmVh?=
 =?utf-8?B?dlhJaTRCWkZoSU4wMHQxRGYxbGtXZ3hrLzNpdjJSQ1JmdU14T3lIRThmbFpw?=
 =?utf-8?B?SmI4clR3Q1gvREcydnZhcVBhMnVVQWhKNlhRN0xYTU5RVmVsay9WdjFXVGJG?=
 =?utf-8?B?dThhVWQ0VUhMeEsycTBGS01tMEk3VFpSb2prSkpsbjdid20zRTdkK2xNQmVr?=
 =?utf-8?B?SHV2aTdSODU4UmUzYWNma3ZSa3k1RTlxWjE5T3gvRnErdlVIeWFnbk1UQXZ2?=
 =?utf-8?B?VUpKM0FKSFJRVDIvYkYzVGlwWG96L20yQUo3cDFRV3g5UnRvQ0dMRkFWSGJF?=
 =?utf-8?B?cUdqQ1lpL1JqS3U4QUlpSWV3WlFkMlp6QjRNZFpncjNSWCtpZWhmSHhwbzU0?=
 =?utf-8?B?dWYrdjVLZTMwd0RERXdKRGtnaEg4ekZFNHhLS2p1bGNwVDlsc3ZqMk1lUVpH?=
 =?utf-8?B?SE5HOFZXclAwbXZtWk5hbHZjN3VoK2lVTVpsdit0TlFpQi9qSkl4bDk2bTYw?=
 =?utf-8?B?ZXlNMlovMXpjTzJKVWluaEpkcEJQcnVDRGpSYU1YNk0wQU5hRFA0ZUx3czBW?=
 =?utf-8?B?eWVuS2FRSTdtamsvQ1JIcW1rZjNRdURXNzhMazhzeG5XdTNUUm9mWHlVUlVC?=
 =?utf-8?B?ejR1eVBlN1drZ055dDdXb2VMVWdKVXpoNlgzSUZZUU0vUll4OU9BYkZURzF3?=
 =?utf-8?B?c25vT3luWlFJZVcvYW51VE56NVZYZmVBZXJydWx0Y2ZpbkZuRk95RWRNcGIy?=
 =?utf-8?B?ei9xdGRPNGRZcGxoVEJEZzFVY0pLUklGL2Rvc3QyY1lDQyt0aDM0c3RmSmtk?=
 =?utf-8?B?TFNzK2o2dXJOZVJRcHljUU9DU1AyYUVsWHhSRit4WkNQTTVKeFp2S0dnNHNk?=
 =?utf-8?B?UHRzY3ZCKzFzQWdIZ0lBMDNoUGp6bDc0VmdLc1NqbDdpcGdBakYybzB5Z2h3?=
 =?utf-8?B?TnJoanhNRzhiZjNybE9keVI2WlV1eGl6eDFhVzhicEQveFhUM2UvOGg3aUZ1?=
 =?utf-8?B?KzNBVDlpbWs5STA5L0JtTnNobEFoeU1mSHZGMVpGRFg0UWt4K0lTSXVJbGxE?=
 =?utf-8?B?aTlZYVR3bzFEeFlzZlZ6d0ZNbkFuM1g3RzAwc09XUEdFVjJDdzZEZzhEcU9M?=
 =?utf-8?B?TjJ4ZG0yTzFUdWxDRlZRTlRYWm0zeHVXSEV4dHYyMTR2TXJrRnM2TDdJeXZi?=
 =?utf-8?B?ckJiT1haZExQVEtoSVR1czQxaElKcEhpQ3NaZFhFODgxNHI3Rk9GVFB5OWY5?=
 =?utf-8?B?cnRlQkk1UUV1Qy95bjNLcVlQdnB2TjRQTm5DKy82aFQzTUxuM0tJaVVveUVM?=
 =?utf-8?B?d0NzQ3JsZ1FDWFJkeXU1aWpQMExKZTk3NjJla1VxTDVnaUlEUVRxc3V3Mlh3?=
 =?utf-8?B?NWhXVk1jMlRKdEpoczNHalVydWpJMUhDZ3MxU2NiYWlyUXNKOGI2TzNmQlFx?=
 =?utf-8?B?YlVBa1owVEE2TmFuZHlzeWFnM014YmNwenRzSUhNWWk1WkVSanpWbkFFajZG?=
 =?utf-8?B?aEdYSDMxcXlGSi9XVTFxczJBKzBYZU9nRE85YW44bmpBK0U1eWtENTZtbndh?=
 =?utf-8?B?WUFDemZXNUlEYUp3NXVYdklSUlBicWdpSWM4WklITytUa1pXQ1p4dzNRV3Fs?=
 =?utf-8?B?cUhlbnNyTjB0a3FZZnQ2YldCVTdXaEV2Y3k0VldGNkpFOER3Uk1tUU00Q0FS?=
 =?utf-8?B?VWZTYnRkN3pvRFJIc3l1b0xkbGxkYnBqeEZKVkhSdU0vemhIaHZ3VEhmN1VB?=
 =?utf-8?B?Z1VZMUpKY1YvbmhtVVV2TXM5ZFplS2V4cEhVdFZZVkNLUkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9328.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZjQyL3ZQZ2orRHNBTFFuQVVHNTc1WVd2V2R4NkVKV0FiZ0ZxTXlXMXNJTXpq?=
 =?utf-8?B?SHBpUkx4dFJadE9TTzFyazUySEtua1lYcUdhQzNzNC9ybHVvZUY5WHJpbmFJ?=
 =?utf-8?B?TmtiNzJsVFB4TktiSGNYMWJyMFJSdnlHZnJqME10VG51Mno2REpHZ0liZlp6?=
 =?utf-8?B?UGgrN3I2ZFFMV1UrK2ErRDRvaExFUVN1bEVPU0J6UjRZMlhxTHVldWxyOG5J?=
 =?utf-8?B?cWJxbGd3bS9EUGI0OHJpMGx2Q2VPWkhiUVVlQUlRM2o4SDIyQ0xIaHhpQTV5?=
 =?utf-8?B?cG9vQldQZmtqTnNCY3l5ZHg1dWJkZ0tneHl2MDJSUWdvY2JHSmp2UEpUM3Rw?=
 =?utf-8?B?cjRRdkRnTWlPa3NseXNwKy83NnA2ejB4dDR6MDhVWDErZGh3ZEwrdEJKT2p2?=
 =?utf-8?B?M2J1Wmdtb3NoRU5OTUxkV2Z1YjFnTklqb3diL3R2aUhQYitnb1FWK0tXeFNQ?=
 =?utf-8?B?ZFh4Vm9UZlVNb3lkZWJKN3d5MVNHSWZaZWxMQ2tqenB1RC9PaWRleEVGaWVV?=
 =?utf-8?B?Q1R0ZytmM2UzMzlzaUk3bnVMTGh1TkVHbmZXb1Z0RHlZeVlJMFRtTkxLUndo?=
 =?utf-8?B?Z0VxWDQ4TENINjhlQTlCMXFSU0NLbGFUenZRUU55Zk5YMmFUSzZyZ25yM0hG?=
 =?utf-8?B?TmtXTFlpOUpldm1ZQnJpeFVITWVLYktvT2E0T1ozRjhnUlhJa0RSbmt2L1Js?=
 =?utf-8?B?WEJSUVZlUjlEMW9FdVEwQVZmUFo5VGo2RU1TSWxwWFBFcFdvR2hMaUk4Z0Rl?=
 =?utf-8?B?QjJEM3FhRnZDR2thMjZlbVpXSVMvU0xlc0dyNHpoNXQvQi9laXNjbXpDbTUy?=
 =?utf-8?B?K1l5TmJ6bmNDdXkzd0JoMDBsZ29pSUdkcmxPejNuaHlFRHdBYUhXVUtNMmZ5?=
 =?utf-8?B?T1grdXFSU0xCVlRZT0Zyc2JzWm5vQnZpRENZSUYwbUMyeWZOZDFYTFJMZlZD?=
 =?utf-8?B?Vm5KSlVFR1gySDJnMkNiVmFIZ2xvVWViQW1Qc0RpUTNPaUxsQmpuaXQwRktq?=
 =?utf-8?B?VU1pNjVoNU56T0plTm5LQk1SVDhLalZqOHhWK1JmS0NZY2lhYVhvMHVQcXNE?=
 =?utf-8?B?cmduOGVPbS9Pdk9QWGxIR2F6QVFHVGZ1THBhTk9LOTNCNmRTTis2VFg5UjU4?=
 =?utf-8?B?NGRJUXNnK0xGSGNOV2NmUkJLaU9iMnN0eFBJaC8wQ21mU3RMTWZNZUJ5dFFM?=
 =?utf-8?B?NDdhQ3dBMlduSFcrSTFsSm9DNU9vSXlTaXR4b0FOY01XYktsMTYveVcyekVU?=
 =?utf-8?B?ZUxaeWV1NSt0YUphK2dyZnl5dXc1bzhXUU1ZWFVqZTdIVlR1UWxscHVZMzcw?=
 =?utf-8?B?VnFHUTdONjBNVm11N1l3SFlLU1lpcjhmZlFhb2tZV3ZhMmV0R3VUZ3NIOXZt?=
 =?utf-8?B?cjJXeFFENTgrWkV2bTJPcnJxYlk1MER1ZnA0MUJER05HOXovSGZhaTE5WG1y?=
 =?utf-8?B?Sm5qMGI3OStCQ1oxTVJMMTgvYXo1ZVZEdU5NQkorS2plMDY2WXlWdlJVYW0y?=
 =?utf-8?B?TkdEd00xMXExdXN6VUhuNzBPSzNSRmpFcmU1WUl1M1N5b2MvNS95ekxER0Vw?=
 =?utf-8?B?dXhvb2p0SlpWRHNiT3B0YjdCZjJVOWJ6cHJ4b2NFQldLc3puUVlCbjl4TUJt?=
 =?utf-8?B?OUNvY2MyKzdvWml5RGdYdFJsOXZmU29hbXZaa0JRdDFwNGpYS0JoRE9PZk54?=
 =?utf-8?B?akphQUVwMU14UlhNVDRzVnUvTG1XU0RZemorOUlpWndRQU1nTm1Id1k3Y1dQ?=
 =?utf-8?B?cDBmV250RldlUlRYWWJnN3hqdlM4RDROYkNPRnNJZ0pVOEtWbFJyOENRVnVx?=
 =?utf-8?B?L0F2ZGRMVEp0ZVN4a0F6aGpxeXphTEl5T0RvUFk0cldLNnV3ai9SZEFuVFdt?=
 =?utf-8?B?TGlac0s3MUhCTkxpRDkvZVFMSlowT1ZnRVo3ejZyTVFQY1RiVTJnM3JoTDNF?=
 =?utf-8?B?NmlSSEc5VytMME5mMmdSd2lkYWFlS2doYjk2dTczeEs2a0FGakdlVlpqN2lM?=
 =?utf-8?B?a0Y2NXJVL3h4b2U5TVlnOTEzdnVzRzRjR1hDZjFmRjlDU2tWZGc3WHk5YXRh?=
 =?utf-8?B?aStnWXh3eE9uOVcvYVUxdkRuc1NGd2t2WlhLU01UVGlNZlhiQis1NjdFYUVF?=
 =?utf-8?Q?q9tmp7yogC0sYv3632JQYgwL2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5897fd-2751-4f01-f079-08dd0ac0765a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2024 06:39:49.1886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gOAC55E8BWzp6bUpLh380iO7AJ5Hcpwycnt17nB4hQyHf5nkV5E7zOERWZd43TmyKXPjivE0WcOiIy9pF9nlHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9454

PiBPbiBUdWUsIE5vdiAxOSwgMjAyNCBhdCAzOjQz4oCvUE0gWW9uZ2ppIFhpZSA8eGlleW9uZ2pp
QGJ5dGVkYW5jZS5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gRHVhbC1saWNlbnNlIHRoZSB2ZHVz
ZSBrZXJuZWwgaGVhZGVyIGZpbGUgdG8gZHVhbA0KPiA+IEdQTC0yLjAgT1IgQlNELTMtQ2xhdXNl
IGxpY2Vuc2UgdG8gbWFrZSBpdCBwb3NzaWJsZSB0byBzaGlwIGl0IHdpdGgNCj4gPiBEUERLICh1
bmRlciBCU0QtMy1DbGF1c2UpIGZvciBvbGRlciBkaXN0cm9zLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogWW9uZ2ppIFhpZSA8eGlleW9uZ2ppQGJ5dGVkYW5jZS5jb20+DQo+ID4gLS0tDQo+ID4g
IGluY2x1ZGUvdWFwaS9saW51eC92ZHVzZS5oIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL3VhcGkvbGludXgvdmR1c2UuaCBiL2luY2x1ZGUvdWFwaS9saW51eC92ZHVzZS5oDQo+ID4g
aW5kZXggMTFiZDQ4YzcyYzZjLi42OGE2MjdkMDRhZmEgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVk
ZS91YXBpL2xpbnV4L3ZkdXNlLmgNCj4gPiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvdmR1c2Uu
aA0KPiA+IEBAIC0xLDQgKzEsNCBAQA0KPiA+IC0vKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMCBXSVRIIExpbnV4LXN5c2NhbGwtbm90ZSAqLw0KPiA+ICsvKiBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogKChHUEwtMi4wIFdJVEggTGludXgtc3lzY2FsbC1ub3RlKSBPUg0KPiA+ICtC
U0QtMy1DbGF1c2UpICovDQo+ID4gICNpZm5kZWYgX1VBUElfVkRVU0VfSF8NCj4gPiAgI2RlZmlu
ZSBfVUFQSV9WRFVTRV9IXw0KPiA+DQo+ID4gLS0NCj4gPiAyLjM5LjMgKEFwcGxlIEdpdC0xNDYp
DQo+ID4NCj4gDQo+IEFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0K
DQpBY2tlZC1ieTogSGVtYW50IEFncmF3YWwgPGhlbWFudC5hZ3Jhd2FsQG54cC5jb20+DQoNClRo
YW5rcw0K
