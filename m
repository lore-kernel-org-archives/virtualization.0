Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022126.outbound.protection.outlook.com [52.101.126.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E3B34A790
	for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979563; cv=fail; b=Z6V2vNbDvwiPY8dJHSO25A/PQ1ciOiwsVGVGmH1DvqBBw3kMVK4TqinOZ8XB1Egd5+rL7e+v7NL5IrMHNwEv4F+j1/Wn7ctA2UiBalDYpMwg8FbXyAcypGjkwwRMNZh4hJWFu3891vgR/1mFyoyXhj72eBvLnwLPVdoAd2g5kMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979563; c=relaxed/simple;
	bh=M38L0SLFulz3kt8EL/Jp2cLMFcAbTUlEMIhZ5KTGMOA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=trHSMGOtiFbMoZKgEqX7eh8sQym6RlmA8bZzWPccs5vHObT64EmK/uo5yPBiY3siiuUSZzKpYaNGhd0Z/yeQcFJEo0q99KE2DH807K632b/60WwvKo8qPP0S+0w8MYMZ3ER4P/ybgFVcXKhk1EepyC1Ur4oWoShzKmLhfPq98EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=iqt2oqvb; arc=fail smtp.client-ip=52.101.126.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="iqt2oqvb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/J/TSsgs4zInPhaVTUuzV7NOQjZOm4Dv0VgR2Zidusp/84PeM0W53yJdFAYiYPKdS+nJHf5m6ecM1KUJvviR4uaUuO/nBiQg9VN1aIUdivkiaQRrE7W6eko6PdU6vCRQcypyovls/W/u47fs+Qp1Jc+C5+i7db3mYWy+4MujiBqJCIUw6CyRblrXtsMOk4MjDj4ud86l0GszXP8/Nn7hTiDnLF65zTiZ5sIish2Y9g7UnKaueLwrZiLZUdHCZDQYBD7BdXduDjFZfdxsRSTYDyye9JzVOa14nDPpD5dFAi4ijOd8pu63ysM3ToIhw38YTac1/2icEy1ljze8fRpeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M38L0SLFulz3kt8EL/Jp2cLMFcAbTUlEMIhZ5KTGMOA=;
 b=MzR3t0NpntvW+IjpW7AJxdofz0GgzgByzMArA9jb3KKLxv10ex6Ugvf0ey4ZVPHuXkpXzeC61NPl86LB2XH//RjFeGCPQRG+T5pSuGTexX3QjQuQAywrfJKNViqOc2XLUwcTpKrbQiqBEBILmIY+JwARbsoADy5CYsytJQp5vhnl+1v2ib486jL5XmQADr1UTuMTEh5x2rUjw6HsQek+3ouco6nn4sY1BzqFl/zt3IlMR3HrzjImkDOUb9IE8kVpV5TQWcnbpSXrOYK0+wPumeEo2+fOBw8x5ou+jBIEUbI1tDVfhAjwR03fYshlnSL5mfe4cA0iTa/1ziPIyvFu5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M38L0SLFulz3kt8EL/Jp2cLMFcAbTUlEMIhZ5KTGMOA=;
 b=iqt2oqvb3Ar3n/zvCuAh6enxUz7XjT2Ajg1vqkvM1vZCTTNi+IHWkDsX6ZHfS/9agc1+sn7s9spZ4tyyX2sOE1x37m3YALHq5MwGUEnY0SXJGtESPr0CAZ2YnaYKVfKFUmsw/o7LYaENGg4wx9YYWmm9XV660L8/URa14wM4O3lIqeVziw/EGU3RXcd5JFSNdYhW8omgOE11BqK3o15PyyoFyc4nmUvfmnKAvdpihI6kyNribb0/9XMhdGXiHX86swCVYld6hnwna/c1NZ6MEwFBzKuCidC9JQ3grWGJ4hNZmSL/5CMkVXDznk2Rp+6TShAK4W3LS3hSBJo1FoB7uQ==
Received: from SEZPR06MB4998.apcprd06.prod.outlook.com (2603:1096:101:4b::13)
 by TY1PPF19F8E0514.apcprd06.prod.outlook.com (2603:1096:408::908) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Wed, 17 Dec
 2025 09:18:03 +0000
Received: from SEZPR06MB4998.apcprd06.prod.outlook.com
 ([fe80::43bd:6cbb:28ae:c259]) by SEZPR06MB4998.apcprd06.prod.outlook.com
 ([fe80::43bd:6cbb:28ae:c259%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 09:18:03 +0000
From: Angus Chen <angus.chen@jaguarmicro.com>
To: Jason Wang <jasowang@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: RE: [PATCH] The vdpasim_net_work function handles both transmit TX
 completion and RX processing. A descriptor is taken from the TX VQ at the
 start of the loop, representing a buffer previously used for the TX path's
 initial read from the virtual networ...
Thread-Topic: [PATCH] The vdpasim_net_work function handles both transmit TX
 completion and RX processing. A descriptor is taken from the TX VQ at the
 start of the loop, representing a buffer previously used for the TX path's
 initial read from the virtual networ...
Thread-Index: AQHcbwAl/QPPOjH+r0mn+JriRcE0kbUlK+ww
Date: Wed, 17 Dec 2025 09:18:03 +0000
Message-ID:
 <SEZPR06MB49983E2773ADF9BFA25F9FEF85ABA@SEZPR06MB4998.apcprd06.prod.outlook.com>
References: <20251217022918.225-1-angus.chen@jaguarmicro.com>
 <CACGkMEtc3KdQtyxUnVeBG6FrbULGanmJxBwNhmG4DB1pO7zn=g@mail.gmail.com>
In-Reply-To:
 <CACGkMEtc3KdQtyxUnVeBG6FrbULGanmJxBwNhmG4DB1pO7zn=g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB4998:EE_|TY1PPF19F8E0514:EE_
x-ms-office365-filtering-correlation-id: 2833a2cf-dc3e-4f08-aa51-08de3d4d2e77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?a3gxempZR3Rhd21yTGh6SldJT1B5QWFRTWYzaDJXS2NZaXljeXh4OXh1bnc3?=
 =?utf-8?B?U1RXb0doUTMwYjdKRGtOcC9lYWM1R3M2ekRWcTl2Nkl0MkpxZDdYYlNtSkp1?=
 =?utf-8?B?clk1R1JjQldVSkM0YkNYMVFXeGJ6TlVwOG1wUVFEUkpuUWI0VHVRSGh0N1lm?=
 =?utf-8?B?VnJ3MCs3RERKUFlFVzJsNVVHSkhkWDJ2NVpXVXZXQTVkQ3VEdStNR1YrcGxy?=
 =?utf-8?B?eUZyb0JNVG1ZVk95eU9zbi9RSHhSYTN5cGxsSEExV2FkSCtxMi9jM3owZWhw?=
 =?utf-8?B?VU1sSkpSZVZ1OGl3SE5ReTNCUjVtMnNuNEwzQ1pBZUc2NVNLTXcyV1VXNFdq?=
 =?utf-8?B?UjM3QllsN0plR1pRT3hQSGJidmsyeDVjQVhGT0x4V25ycDU1Z2xoemJESGVj?=
 =?utf-8?B?NjNkNytLeWkwYnhheDM5TU5tMnkwWTVaZ3ptWWVxNEdSeUdGbjBqMTQ5bVBV?=
 =?utf-8?B?Y055QkpzbDdrTnhWSFN5aGVkS0x3RmRpSlAvQXhQdnNQUUhVUUV1MnRoYXRX?=
 =?utf-8?B?WTY1eW5BRGVCOVduWFlWMUh0clJvbG8vTWh2THgrczR2cm1mVFIweERiS2dU?=
 =?utf-8?B?T1N2bUxJcFI5ZVc5WSsweVVRNGxEK2o3TEJZWnFlc0hnM2s4S3dBMHNBdzJZ?=
 =?utf-8?B?VlRMa0lvbU8zemcvWlNvK1hPdnR1UFhkS1RMR3Vyck9lbUdVbHd2UUdBcTdO?=
 =?utf-8?B?eGRyMXJSazIvdXMxNE1PcHpjalRLUVhvWE9OTkh2d0JCaEx4MmVwZkdRZzNn?=
 =?utf-8?B?dUprOW9VYk95WFkvRWk1QmtxbmlaVGl1aG14N2lObndGUGNTejhTQk9QSDYv?=
 =?utf-8?B?K0dWV2FIcVhFYmpFWit3UVBMMm5EQ21xOHpBdFdhQlNBYWtJRTRoWWJYYVFV?=
 =?utf-8?B?YmpEUDVDQm9JS3oxTUdIU1BkNTNuNG5IZFlBTFE5RnlibENEWGpxUjhGNktL?=
 =?utf-8?B?UktueHRlR0tYYUp2ejM2Ty96MTVXOTkzbEFaaVExdVkvZmJ2ZlpvTlJaSFB5?=
 =?utf-8?B?VnRQYXdLeXF0K2o5cnlNWU1FSElkZG5jQ3NYSDdyOFB0dzF5U3hrZnJ3SFNE?=
 =?utf-8?B?RXdMNUFsN0NQeHBoMkFReG04UjVhaHlnNHlUbjlqOTZpVWNxSHVBVGFQNVRz?=
 =?utf-8?B?MVIvc0FGcDBaZlR2cjl1dUJML3JVK3ZQQkxudkFqZWh5L1NNM1RQZFFPV2pa?=
 =?utf-8?B?a0ZJaUVWd0g3OGRad0I3dnZOZmowS1czREw3Vmd5ZFg1N2ZGaDA0VWg4V0h0?=
 =?utf-8?B?bW9xSENLYmh2NUM0UU1KMHNSMmFPTlRlbHlXczRLbnZKNzBZc0N3TDMrTit4?=
 =?utf-8?B?bkhPUDdMOGFWcTBYRGpkdE8yc1lVVm0rb2hPNnMvbTQ2Wmd2ZGJ5YmFTRGxF?=
 =?utf-8?B?c1FRTSs2WG9rdU1lTXNvWDN3bHN6WlRTcW1BUWtHVk51Y0FhaktianV3TFRB?=
 =?utf-8?B?UVRHTFpMUWx2MzduM0FHYVFYa3ljTWJpb3pUOS8vVXRsSG5DZFNHRlJyWURq?=
 =?utf-8?B?VGI0eDZLRVBOYng0Zk9TOHF3bEN5ZFE0TjVQR21ucXZZbGNsVGZLenR1YW9C?=
 =?utf-8?B?S01OL1k0cTdxZUlPTGNmZWk4NjZmNGl5Q2ZDc29RL2hXaUJtejc4VDAzb1RK?=
 =?utf-8?B?NmcrZHNmTzJiUGhsT1VMOW1FNUlKdTRob0dPL3AxWE4rRERXdTVtbXgzRjBk?=
 =?utf-8?B?d0NKZkZ2UmdLRGdjRUxFNnRIZ0dzZ29vMVJuNjFJQnBCVmo0dEI2VWdrVnN3?=
 =?utf-8?B?S2dWMmJ5V2lMUkJpdnp3SG5JNXhsVkxaaU4rV2x2NzIxY3Q1Z2YxREZHRWRh?=
 =?utf-8?B?N0J5Yk5vb29KbG8yZGJBNExWZEl4OE9WVXdKb3UrbDNmNmpyWEVKdEwyQW52?=
 =?utf-8?B?Mk5sSmduWW5RZGkyNlo5OEZ2Q2tMc0lpUkt3bVVjcmYrbDJtQVdoeW9xaWJ2?=
 =?utf-8?B?UUlHVnpDYjZuNjAvRkRjSTBKbTMvTWxrdTRVbk9ucWdPblZDMG91M0oxcHRL?=
 =?utf-8?B?TndRYndhOThucS9PZlRac1NoMHFuU0liNTFoZWRDUkthSklxODcyZmZQQk1N?=
 =?utf-8?Q?be8uBL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB4998.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WnpuMTQyNmtEYVViRjJpQ2tacW9sWGNxbVlxVDFOeUFzeGdyYWFvdmt5amRN?=
 =?utf-8?B?WnFsdGJNMWJxYURXTkVRRG5iY1lVYTNLYUdwalFuS0VzRXcrYStGNi9ZcWIy?=
 =?utf-8?B?RTBNS2ltT2wvcjFic1V1YW8weDdMemYvMkhrTEo4enkycjdrcUR6OHZFT1l4?=
 =?utf-8?B?OUlaRmZuU3BodkJ0czAvQjVBSisxSWs5ZDZCVVBERmhOZExJc1UrOGZyMHow?=
 =?utf-8?B?N09QRkV3TTNlUFNCOVNXeTFpTDkvRVduY09qbWtxOTgxS1V6RThzSjE4OVJJ?=
 =?utf-8?B?Yks1NUhTaTkyamxrUm1Sd0JPbEM1ZnRDV040YjlRUld2cDQzcjBaUzVXWUh5?=
 =?utf-8?B?Q1REMlNiMTdJREJDQlpwOUwvaHhRSzB1N0lEVVZ2YkNqYlV4alZ2b0JTczg0?=
 =?utf-8?B?MUxPZFVGTmJRSHZPNEJHY2xhMEJ1SjUxVW5jYXpObVRUV1dmYWw2LyttS0Ux?=
 =?utf-8?B?VGJ3ckZVcEUxUklSSDQzS0tnc2U5TnBWSjAyd3dyUW5zVC8wTkxFODNyd0lY?=
 =?utf-8?B?K2wyL2dyMmlNVUJHQWpFUGVMUVAyeHdwMnVoSUo2SUcvSC9vdzdKckhKVW5n?=
 =?utf-8?B?MDdWZ0xhdThPRGVjMlZvN0piaU1Vd001QVpqemo5VEEvMWlHbTRQNlFSRUJG?=
 =?utf-8?B?YlJZQUVBZkZsaGhLK2xoMUE1cDI1c0trcHlIMXNlU1NZalc0RE5xc0pMcExt?=
 =?utf-8?B?ellaNE9ucXlEZHJocDA3SlIrNi9DYzhNTGd4cnIxaThJQTdINWErR3kxY1dy?=
 =?utf-8?B?SjNieFZLSFN3Skdyamc3ZWQrWXpsWkI3RXl6aThmTmhjNE1FWVd3RFNKY0w3?=
 =?utf-8?B?d0x2Vld2cWxDeUg4S3JKTFpZV0d4QVJMOERBUDRCVkVWWTIrV1BOQmZLcHJi?=
 =?utf-8?B?TGhIRVBmYklxSEdzS2lmdnhSTTdiNG5VRDV6N0NHM3Y0bXlRRGZpVS9LcUJB?=
 =?utf-8?B?L2N3VzFrQ0kyYzEyWWxYNHFSaHZmaWJkcndkR2xZSG8vRDRhejBzR1kyL0Jz?=
 =?utf-8?B?WmhPaXVMSENOKzY3Mk9aVW10ZGhXVzUxV3JSc0s1SS9HT3NUcCt5ZEJjdWNq?=
 =?utf-8?B?SktSL2FOUWlTZGpTMzV2K3NaYmppR1pQSm5wQytLUHlmWU9pbEVDQ3dwNS8x?=
 =?utf-8?B?SW5YQmFEaHo3a0JCdlZPWThMZGxMa2xvNktMSGJqN0swUHlrak1QSDYxVlkr?=
 =?utf-8?B?SHlBTFBPSms3QnN5VjdvODJIcVBBNFF4RkRmelhua3BmYVFSbkMyaHZnd1pq?=
 =?utf-8?B?UTNJSEk4SytVOVlFaHpTSDJNanhJNTZET1ZjQzZYMlZrMEVkZVdyeUZDZjZu?=
 =?utf-8?B?cnpqQ3JsTVhUbEg1RFNQTUJub0M0MkFDa3Z6Uk5ZRmVoV3J2MmRZQ2oyaE9W?=
 =?utf-8?B?SHBkLzVpRWhoUnZNQ2pLd2lFakJhbUY5TWx2Q1piUWl6TXJXRDJ4azkxVjJV?=
 =?utf-8?B?UXcxSUM2SG5mYW1LcmFmOXpvRHVUaVU5QTg0bEVwYytMaW91ZHNVbjZ4Vjlr?=
 =?utf-8?B?MnVESHg3bVVlZFEwYkRxM3dMMEVMYmdvaWM4QTVPZXdVRk9MQXRsK3lxZG9M?=
 =?utf-8?B?aFBQaExFR1pWUXdCazVaR0xDZmJrZGdIbnk2aktIdHRwVTJkMVJKc0ptRi90?=
 =?utf-8?B?Z0Z5NWtJdm83R1FaZDF4dGlMdDRQeTNha1RUci8rYUtHQjdseWVvTjdhWGZG?=
 =?utf-8?B?VHZJQnpPa1k5VFRLMG53SnRyb0ZlYlFEL3JwZTV0TThpQmRheThOS0dzSzAy?=
 =?utf-8?B?YUZrQlZJb3g4bC9nUHZ5a1laU1B4VFIzS1BCd0xtVThFUWE4cU1PenlGczJa?=
 =?utf-8?B?TVM2SXVGVyt4czBEQWNRQ09xaXE3eHNkdVVHWkQvOElhdy9vWm1nSE91VU5P?=
 =?utf-8?B?bUtVWkNuczdyYTRsQXMxZkxDeVlXd3lEckxOelBwMld3dTZqQnp2UG50NDlL?=
 =?utf-8?B?aCtmdlR5cHhoeU5HYmtOU050UHpJcnRZTCtTYVVFZVNMeFdmdm56dGVJbUdl?=
 =?utf-8?B?MlE4S056YXA0Q216dHV0V3l5YzBHeGZzUzFkUFBENlFaeWdvVzhPclhoKzM1?=
 =?utf-8?B?Zm0yQ0N0UlZtekxVTmtFYnZBaUxBcHdtTSt6VUZWUUVRTzNVWEFpaU9UckRM?=
 =?utf-8?Q?Yc2nZ4DnmagTnE+JglJo+Icgb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB4998.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2833a2cf-dc3e-4f08-aa51-08de3d4d2e77
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 09:18:03.4082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZOk50egc8g0Ec/i7e6/Yj4ATWraHbUUyXUD8Y5FBzseccUHaJzYenhW9B13ufM3F8E23N8WBsYns9cGG2zUIcqiFwyXOC2isKQK2rHXjds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF19F8E0514

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAxNywgMjAyNSAx
MDo1MiBBTQ0KPiBUbzogQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+
IENjOiBtc3RAcmVkaGF0LmNvbTsgeHVhbnpodW9AbGludXguYWxpYmFiYS5jb207IGVwZXJlem1h
QHJlZGhhdC5jb207DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBUaGUgdmRwYXNpbV9u
ZXRfd29yayBmdW5jdGlvbiBoYW5kbGVzIGJvdGggdHJhbnNtaXQgVFgNCj4gY29tcGxldGlvbiBh
bmQgUlggcHJvY2Vzc2luZy4gQSBkZXNjcmlwdG9yIGlzIHRha2VuIGZyb20gdGhlIFRYIFZRIGF0
IHRoZSBzdGFydA0KPiBvZiB0aGUgbG9vcCwgcmVwcmVzZW50aW5nIGEgYnVmZmVyIHByZXZpb3Vz
bHkgdXNlZCBmb3IgdGhlIFRYIHBhdGgncyBpbml0aWFsIHJlYWQNCj4gZnJvbSB0aGUgdmlydHVh
bCBuZXR3b3IuLi4NCj4gDQo+IE9uIFdlZCwgRGVjIDE3LCAyMDI1IGF0IDEwOjMw4oCvQU0gQW5n
dXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+IHdyb3RlOg0KPiA+DQo+IA0K
PiBJdCBsb29rcyBsaWtlIHRoZSB0aXRsZSBpcyB0b28gbG9uZy4NCj4gDQo+ID4gSG93ZXZlciwg
dGhlIGVycm9yIGhhbmRsaW5nIGxvZ2ljIHdhcyBmbGF3ZWQ6DQo+ID4NCj4gPiAxLiBSZWFkIEZh
aWx1cmUgKGVyciA8PSAwKTogVGhlIFRYIFZRIGNvbXBsZXRpb24NCj4gPiAgICAodmRwYXNpbV9u
ZXRfY29tcGxldGUodHhxLCAwKSkgd2FzIHBlcmZvcm1lZCwgYnV0IHRoZSB1bmNvbmRpdGlvbmFs
DQo+ID4gICAgYnJlYWsgdGhhdCBmb2xsb3dlZCBwcmV2ZW50ZWQgdGhlcHJvY2Vzc2luZyBvZiBz
dWJzZXF1ZW50IHBlbmRpbmcgd29yaw0KPiA+ICAgIGl0ZW1zIChvdGhlciBkZXNjcmlwdG9ycykg
aW4gdGhlIHF1ZXVlIGluIHRoZSBzYW1lIHdvcmsgZnVuY3Rpb24gY2FsbC4NCj4gPg0KPiA+IDIu
IFdyaXRlIEZhaWx1cmUgKHdyaXRlIDw9IDApOiBJZiBkYXRhIGNvdWxkIG5vdCBiZSB3cml0dGVu
IHRvIHRoZSBSWCBWUQ0KPiA+ICAgIGRlc2NyaXB0b3IgKGUuZy4sIHZyaW5naF9pb3ZfcHVzaF9p
b3RsYiBmYWlsZWQpLCB0aGUgZmxvdyB3b3VsZCAnYnJlYWsnDQo+ID4gICAgYmVmb3JlIHRoZSBU
WCBWUSBkZXNjcmlwdG9yIHdhcyBjb21wbGV0ZWQuIFRoaXMgbGVkIHRvIGEgbGVhayBvZiBUWCBW
UQ0KPiA+ICAgIGRlc2NyaXB0b3JzLCBhcyB0aGUgd29yayB3YXMgbmV2ZXIgbm90aWZpZWQgdGhh
dCB0aGUgVFggYnVmZmVyIHdhcw0KPiA+ICAgIGZyZWUgdG8gdXNlIGFnYWluLg0KPiA+DQo+ID4g
VGhpcyBjb21taXQgcmVmYWN0b3JzIHRoZSBjb250cm9sIGZsb3cgdG8gZW5zdXJlOg0KPiA+IGEp
IFRoZSBUWCBWUSBkZXNjcmlwdG9yIGlzIGNvbXBsZXRlZCBiYWNrIHRvIHRoZSByeCBpbiBhbGwg
ZXJyb3IgYW5kDQo+ID4gICAgc3VjY2VzcyBwYXRocyByZWxhdGVkIHRvIHRoZSBjdXJyZW50IGRl
c2NyaXB0b3IgcHJvY2Vzc2luZy4NCj4gPiBiKSBUaGUgdW5jb25kaXRpb25hbCBicmVhayBvbiBy
ZWFkIGZhaWx1cmUgaXMgcmVtb3ZlZCwgYWxsb3dpbmcgdGhlDQo+ID4gICAgZnVuY3Rpb24gdG8g
Y29udGludWUgcHJvY2Vzc2luZyByZW1haW5pbmcgd29yayBpdGVtcw0KPiA+ICAgIHVudGlsIHRo
ZSBsb29wIG5hdHVyYWxseSBleGl0cy4NCj4gPg0KPiA+IEZpeGVzOiAwODk5Nzc0Y2IzNjAgKCJ2
ZHBhX3NpbV9uZXQ6IHZlbmRvciBzYXRpc3RpY3MiKQ0KPiANCj4gVGhpcyBpcyBzdXNwaWNpb3Vz
LCB0aGUgbG9naWMgd2FzIHRoZXJlIHNpbmNlIGludHJvZHVjZWQ/IE9yIHdlIGNhbg0KPiBzcGxp
dCB0aGlzIHBhdGNoDQpZZXPvvIx5b3UgYXJlIHJpZ2h0LCBJIGp1c3QgdXNlIHRoZSAwODk5Nzc0
Y2IzNjAgd2hpY2ggYmUgaW5mbHVlbmNlZCBieSB0aGUgZXJyb3IgaGFuZGxlciBsb2dpYy4NCj4g
DQo+IDEpIGZpeCB0aGUgc3RhdHMNCj4gMikgZml4IHRoZSBlcnJvciBoYW5kbGluZw0KPiANCj4g
PiAtLS0NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFn
dWFybWljcm8uY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9z
aW1fbmV0LmMgfCAyOCArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0LmMNCj4gYi9kcml2ZXJz
L3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0LmMNCj4gPiBpbmRleCA2Y2FmMDlhMTkwN2IuLjI5
OGJkNmU4ZTBhMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9z
aW1fbmV0LmMNCj4gPiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0LmMN
Cj4gPiBAQCAtMjQyLDIyICsyNDIsMjIgQEAgc3RhdGljIHZvaWQgdmRwYXNpbV9uZXRfd29yayhz
dHJ1Y3QgdmRwYXNpbQ0KPiAqdmRwYXNpbSkNCj4gPiAgICAgICAgICAgICAgICAgaWYgKGVyciA8
PSAwKSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgKytyeF9vdmVycnVuczsNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICB2ZHBhc2ltX25ldF9jb21wbGV0ZSh0eHEsIDApOw0KPiA+
IC0gICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+IC0gICAgICAgICAgICAgICB9DQo+
ID4gLQ0KPiA+IC0gICAgICAgICAgICAgICB3cml0ZSA9IHZyaW5naF9pb3ZfcHVzaF9pb3RsYigm
cnhxLT52cmluZywgJnJ4cS0+aW5faW92LA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBuZXQtPmJ1ZmZlciwgcmVhZCk7DQo+ID4gLSAgICAgICAgICAg
ICAgIGlmICh3cml0ZSA8PSAwKSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgKytyeF9l
cnJvcnM7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgICAg
ICAgICAgIH0gZWxzZSB7DQo+IA0KPiBUaGlzIGVsc2Ugc2VlbSB1c2VsZXNzPw0KPiANCj4gPiAr
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgd3JpdGUgPSB2cmluZ2hfaW92X3B1c2hfaW90
bGIoJnJ4cS0+dnJpbmcsDQo+ICZyeHEtPmluX2lvdiwNCj4gPiArDQo+IG5ldC0+YnVmZmVyLCBy
ZWFkKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAod3JpdGUgPD0gMCkgew0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKytyeF9lcnJvcnM7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB2ZHBhc2ltX25ldF9jb21wbGV0ZSh0eHEsIDApOw0K
PiANCj4gSSdkIG1vdmUgdGhpcyBhZnRlcjoNCj4gDQo+ICAgICAgICAgICAgICAgICByZWFkID0g
dnJpbmdoX2lvdl9wdWxsX2lvdGxiKCZ0eHEtPnZyaW5nLCAmdHhxLT5vdXRfaW92LA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBuZXQtPmJ1ZmZlciwNCj4g
UEFHRV9TSVpFKTsNCj4gDQo+IFNvIHdlIHdvdWxkIGhhdmUgYSBzaW5nbGUgdmRwYXNpbV9uZXRf
Y29tcGxldGUoKQ0KWWVzLEkgd2lsbCBzZW5kIHYyIHRvIGZpeCB0aGlzLg0KPiANCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgKytyeF9wa3RzOw0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJ4X2J5dGVzICs9IHdyaXRlOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIHZkcGFzaW1fbmV0X2NvbXBsZXRlKHR4cSwgMCk7DQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgdmRwYXNpbV9uZXRfY29tcGxldGUocnhxLCB3cml0ZSk7DQo+
ID4gICAgICAgICAgICAgICAgIH0NCj4gPg0KPiA+IC0gICAgICAgICAgICAgICArK3J4X3BrdHM7
DQo+ID4gLSAgICAgICAgICAgICAgIHJ4X2J5dGVzICs9IHdyaXRlOw0KPiA+IC0NCj4gPiAtICAg
ICAgICAgICAgICAgdmRwYXNpbV9uZXRfY29tcGxldGUodHhxLCAwKTsNCj4gPiAtICAgICAgICAg
ICAgICAgdmRwYXNpbV9uZXRfY29tcGxldGUocnhxLCB3cml0ZSk7DQo+ID4gLQ0KPiA+ICAgICAg
ICAgICAgICAgICBpZiAodHhfcGt0cyA+IDQpIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICB2ZHBhc2ltX3NjaGVkdWxlX3dvcmsodmRwYXNpbSk7DQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgZ290byBvdXQ7DQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0KPiANCj4gVGhhbmtzDQoN
Cg==
