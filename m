Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013066.outbound.protection.outlook.com [52.101.127.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24ED2C2349
	for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512760; cv=fail; b=mLnPAKIdWsr5qEpWs0ZI/YskLFSehSEogCYIiWSwmrB1gQOypZGYDFcrOeoaYAs6V6i+/UGT3DxS8x17rhQFFRcnKS+99qUAN+SqAxkyhsOwCiw/RIbR/cTUFqexj71Svn3aqiAOGBftCLH2Q7TzN69+KOZavf6EwSoPAMk7uik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512760; c=relaxed/simple;
	bh=MWz/hhVpVJ6PUiRmvzYY/6NeSgEowpY9vXA293r40nQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sC/7cW2LJZxhII6WJ4LWADYFVwCiyC146aMRmVto69aVztI1bCLumF0a1+CTl+uVGmm0VVSOTPsskeg1LLHCeAz0mTeuEiz+cvuBciGA2yFx846VHUVrR//1MjgNk3G1yXeOfmKYIRNZ7YLS9xMZ7HOVckT5DCawao/F0FEU5sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=HPdLQlxI; arc=fail smtp.client-ip=52.101.127.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="HPdLQlxI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLtRKquGJd4GL9g/aYFhufDP52UjKx5bCuhqi1lINDQ9AXCSUMaojF3gamXZTLYPNzj9cPa8I51finzyyGw8LfuAjskqemzGcWjPIYK5PtfvHvhydfwXtgSX/0aIzyzHH3j3bW27bzHH3TxvoSkcpBSQdokFM4eePwmfE8qcqSvMB6O0tz78KDjMCLQy44YnM1jRYj2nqo1qZSdh+CEFTIBP1mG1a5w8wdt9ZsvQ0mGorDHHx4uai3+ije600EGg08sNifTuArYmUWKKkcSlZfCPHTfEvw7uY0VHRutFONipYVlZIOnT2C87WAey4L3HxpEvZpNXTdPLCOgbkUe02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWz/hhVpVJ6PUiRmvzYY/6NeSgEowpY9vXA293r40nQ=;
 b=KlWF/khQsm5FFf7IV2gfvyyv5Kcxb9d8dMo5ZfFU5g0LYykPdONI6tyy9Kfi2EWmGZ+sRUHaEgW95x0ugX1V3uoYetr3Cslzr66il7l7x/wiuv9HYkkBK02pvWgnM5M+1O8Q3YXqLPv6kBMR+xRnqAJDz2f75JWAL5TPrOtZt32NJabxd+iyzfscrOu4O0v3Q2jBHJay82q48NYydK9IBFor/81iXd18QF4vOPb9LoLArJ8HXgQBnXa/+eoxYrxTrxTlEjWRWTQewjw4OPh9diCFgUJGyvKy8r1cg2yeZfym/ThNgF+o41nRpnHtAQStIRx7WQ6sy1UsoTA6XmUDgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWz/hhVpVJ6PUiRmvzYY/6NeSgEowpY9vXA293r40nQ=;
 b=HPdLQlxIJ+qXMBd44SFsPx9UB4OEAcw4L6aBl2I4o0HeYd5g/K5nYyVH1ya3wMl/cm8EAzRPa6EW0XyvZw2/9cLFpjH4/wstRz2BRIc7dLqouUmxmRUHbnUK9g61+9PMIviRuPFXndBYBjoeHHRIjY9/Gs6waKdeUkFWpchEu7cVXtO3Rr/SQS44vM6FwbsFlwcCVa4QiIzd+V/YDb1Tkk6MrZQcU1l/skLwbGapvHKwmH03y4spYzshtb+iRB3/dO8Rvi/EkceKIwSr0hOEn9YtjZPcZRqJTT1VnC5iVIRUC3OKxo3qtFJFx+SXkqLbYVbzD4aGmTAMqXPSz8wZGg==
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by KUXPR06MB7997.apcprd06.prod.outlook.com (2603:1096:d10:42::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 10:25:54 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 10:25:53 +0000
From: =?utf-8?B?6LW16KW/6LaF?= <zhao.xichao@vivo.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] virtio-vdpa: Drop redundant conversion to bool
Thread-Topic: [PATCH v2] virtio-vdpa: Drop redundant conversion to bool
Thread-Index: AQHcECcAWvQLBIFfs0K1zGGF22anPbRoMUIAgAADY4A=
Date: Mon, 18 Aug 2025 10:25:53 +0000
Message-ID: <e3d3cf69-e559-47f0-aafb-409b1c776513@vivo.com>
References: <20250818100028.571372-1-zhao.xichao@vivo.com>
 <CAJaqyWd+q6hs3bZxyEz+jtg-v=gNe2b0DtEECTLHeaWeFaF2NQ@mail.gmail.com>
In-Reply-To:
 <CAJaqyWd+q6hs3bZxyEz+jtg-v=gNe2b0DtEECTLHeaWeFaF2NQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR06MB6020:EE_|KUXPR06MB7997:EE_
x-ms-office365-filtering-correlation-id: 48005892-39b8-4631-93d5-08ddde419c5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|42112799006|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RVc1MGhBT3VuNjZZTlU1ME5waWpFVlE1UTZJS2Y4MDhhYTNHUFh3TmJsLzJO?=
 =?utf-8?B?LzNDT21GcFJJeWo4WHYwU2wzamRVbkhSdFg2b0RJNW5ud3BWT05RMzduUTRB?=
 =?utf-8?B?dllZVTIrZFFIRzhyQVlIelZzbzQ0cjdWa2VvOE9kOEROUTFCWkxJSDk2aWYy?=
 =?utf-8?B?SE80VWhINnZkelltbWhuMnYvbEoybUU1LzRrcnpGN1FzRmtnamtIUlZDVFJY?=
 =?utf-8?B?MXBXelFpMGtQKzBDWTY1ZWxrNTNaRlE4UWw4bVZDK09pVjcrYTZ1M2Y2Y2Vv?=
 =?utf-8?B?MGRNVmFQZWRjVGlnRUxPN0tyanAzKzJmeG9NNGp0dlNFOHAyeEZ6bTF1cFQ0?=
 =?utf-8?B?M294ZXh6ZFVwV2RjeGpHWlZpNGYvSnNmc044THQ4SW1QZ3BEL01lMW4zdTJs?=
 =?utf-8?B?a1M0STBueEZDbURDU0NTVTd4ckJtcU10V3Z3R2lRRkZLWXRVeHdoM3RKMXBi?=
 =?utf-8?B?R2hhS0hGRXR3MnNkTVNRUFZOZCtFVUFtOGl3eFQxaE41ZC9PVlpEK2t5bXQ3?=
 =?utf-8?B?SEdiVWNzdWk0ek9sOUtxazIyRUtPQXo4VTlpcHlGbk1nejVhS1FyL0hMdk5X?=
 =?utf-8?B?Z2cyMmpzM2RVTjMwKzQvRk5pWHlXQ3pYTXltUFk4VVROZmdDVHJhb3ZtZFBH?=
 =?utf-8?B?N2tZRE1uVDdsc2M3U3RFckF4L1NOY2Zac1NuMW9kNEpWZ01aYWRuUW15VllJ?=
 =?utf-8?B?VVpZNTJLUFoyeVBXcWVGejRRS09nc1RKOTN3SENwdWhWaVFONE5JRThaR1VX?=
 =?utf-8?B?SFJEdTlNVmZubmpFMXdRWTN0azNCTEJxOUFxM0ZiNzhuWXpUak9YT3pzQytE?=
 =?utf-8?B?Zlh1Uk51WXlTOHV3VnA2bTlrYk1SWlNoQWpJcDdobUJLUWYrb1dDc1NyUG1H?=
 =?utf-8?B?dEdGb3pEemM2aERSMlBCa1FUR0ZrZDVkaEpTNFpjOEUrUzJBMmRlSGJSNlNT?=
 =?utf-8?B?cC9jUDFoN1d1MHI4cFEyRjR6bEVDUSs0MkZxWkJhUlViSmptN1JkMHJWUGw0?=
 =?utf-8?B?QVEwWXQ3akxSSCttckp1eVZTMlhnRTJDRXRzSFIvampsdERqSmIraUtPT3d6?=
 =?utf-8?B?cHVZK0RYNDVsS0JMRXhlSkdYK0F1NXVmV1dnajhSTWNRcnQ4SUp6RmNxMTE4?=
 =?utf-8?B?T3RHOHpqTU9aYUxDaVhvVjVBOFgzcW90clNwTjNiTmdJZlkxbzVVUUVKQ2hP?=
 =?utf-8?B?eFVzc3RaMFVxVUVVSjB1NCtzNnhRa2djQnlWSjdPdWMrWnRjbERvcUxYTDRh?=
 =?utf-8?B?SnhGSXJOWVdWa1loemZ1TlpOL3pxcG16MENrTll3ejhLaHE2NEsrd1FDT1My?=
 =?utf-8?B?Ymtsb2xNY2lHcmkxNTBnV0dKRTdscjZJZlZWdEF4c0pLUkEzUTUxWEVUUy81?=
 =?utf-8?B?clJlVlB2N2pEdm9kWXlpbVBSaEJaNUVrU0h1RXFLT0xtN2lpV2Q4aVhRcngw?=
 =?utf-8?B?R1E5WTR5amd0clBNYUdtT2hlNUYxZ3dLMWxBaEc1d2NqU1VOSXVtUitZL3I2?=
 =?utf-8?B?eFEyczhaTzNkK085S0JsVmEwTjFLSFNUdzNtMlVsUVlQOEJRSE9WQzVOUnFa?=
 =?utf-8?B?L3FNREtjS2w5aWMxQzg5SEtHbHhaSG9pY04wNmRGajAvaXdFTThzOGI3b1lh?=
 =?utf-8?B?RWsveTJMMU1JUW9YbitjN2xQTEtsTG00ajM1eE9UQVgySitVOXZGd0QrdGpG?=
 =?utf-8?B?OHNxTk1JdWFINWJFVzRhNUZMVnN3OVhRTHdibkhIVjVOczdjWlBmTUh6UU5x?=
 =?utf-8?B?TEh6Tm5jY2IrMEx1TXUyZTdUMzdmNmFRaVdVK25PVE1TU2ZRbmdsL1hvZXUy?=
 =?utf-8?B?Z3NmMnJDb1g3V1ZTZ3lOVWFNSmhzQzRtaHAzSFJ4bUk0Mi9yMkk5Sm84N0Uv?=
 =?utf-8?B?VnFhQk1aM3BqSmt6KzUrRDV6Q1dPSEtuajMrT0VMZmJ1dTkxZ0QvQXF4WGt1?=
 =?utf-8?B?WEgvVmoyNnh4YkdQaXdDdnFJdTdSNE1CVVlzSUVEWTg1eGNWMWptdFd1QlZM?=
 =?utf-8?B?SGxxOHlidnJnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(42112799006)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a09nNHJpMmRURDNaMDJ2aFJpam9FRitvT1FNRGQ1eExsNzVHcmU0RENWaml0?=
 =?utf-8?B?eXBtclowQnBaaCtxOEZ0bW1ITVFWNFp6ZitSMENnVlZrZnQ1NnZaOUlLS2U0?=
 =?utf-8?B?Sy96RVUwU2tLMUN0a1hySnlqQWUralZsTWZHVSsrRk5jbHZQVysrbUxKeTRB?=
 =?utf-8?B?eUhRbUFPeVZHMkY1ZmpQVVFDK242SXR2OWJhWUlzWHY5SjFDamZxTU9lV1Jm?=
 =?utf-8?B?UktiZlFaUWN6NG5ORzZzcHp1VGJwTnNQMUFDaVJJS1BDMkcwcWc1ZjdMazVF?=
 =?utf-8?B?SGlOc1M1MlRsNXJJQUFTRU43Mjhra3pYT2s3d0V1MW44V05YUHdRUFROSS9w?=
 =?utf-8?B?S1U0N1UwM3lkR1lGTFByRFJGeithbnRCZVRqQkgrUXFadkxpajQ4bytIWTB4?=
 =?utf-8?B?MTJJYUtSa1dTTzZuaHYrUlhaeWtGU21VWWhqb084bmY1Rkk4eEh1NTRSU2dy?=
 =?utf-8?B?U055OUZ5UEk1aVNtM29VME1BU2FZOWhBRmpMS2t0MDhRTTlRMmVLd3BiZGZq?=
 =?utf-8?B?VUxNeEZaMXZHS1BOVUt1Q3JhUHhNMHVHNXRXMEJRSzFCWnJpZm1EMmprUjk2?=
 =?utf-8?B?V3Q0bTRka01EbnJ2c3JlZEtpT3phZTdSMFp2UWowY3M1akRyQVYxaDdLdGtl?=
 =?utf-8?B?bjZWNkI3Y1BqZmQ1aUE0SDA0Ymlra1h0ZDhuNzBMUUVJd1RVQjRQWnpTMkV4?=
 =?utf-8?B?VkwxYWNkY2N6ckp1cUEvL0dtWlV1Y2grSWx4QnJXVStEekRKTDd6OU92YUlZ?=
 =?utf-8?B?NGhSUUIzbUYwcnlIQzlaQ2lKeDhwbkZlazE0ZEk4SHNNdVllaTJ2eCtYZG9H?=
 =?utf-8?B?OHB1UUpZcTI1dGZSNnRnK1UvcEJhbWcrQmJaODlDK3pnUXdxQlNJRlMxTlU5?=
 =?utf-8?B?WFRhQ0k3T2lpMU9SYXVHVnducW1TeldPVFU1SDRmc0RTYTdXeGJ2VHVJREdw?=
 =?utf-8?B?b1l1TlB1UHpyeTBleDJ0b2FIa1kzVDdpeXNxaFdvVDI1UmZJeGRzNER5emV3?=
 =?utf-8?B?Nk0vdW9lY0NUaTVEMm9JMWxOeG9tNUhZRlJlM2VCUjRIeVpsT0s5RVBnSjht?=
 =?utf-8?B?elAzVHZ0WEhFVWp5MFVvWjJQalo3V3FzZmVsQ1RRTHo2Wk04SGNTYXVkYktD?=
 =?utf-8?B?bFg4aWdMU2QrbkRrV1duTXBxWEFaS3BhOUw0N0RaVlRsbzBwM2libm42VHl0?=
 =?utf-8?B?UUFWdVp6Q1JJc3BoRGt5YlIwcHpSYmdoOUxId09yRkRlVXQrbFRrTUxQTjN4?=
 =?utf-8?B?M1FWQXZLb1FWUm5McmtPaGxLOURGM29RckxJMzFZRGh0ajcvSE8xRVJYZFZu?=
 =?utf-8?B?SmloUy9oTVU4N2V1Rkhlb0pvVXdJOVVCYWVEOHkwNzJieVZXV3VpNmNDWjh3?=
 =?utf-8?B?dWp6VHBGTHhxbklQT2xqakJSS1lJY2ZZbGx1TDNQWFBCRUZUeFJ6STJRaHBJ?=
 =?utf-8?B?M3JNU2dQbjl2eVZqMHRBQTBGeWxGYmE2cko5L0ticGRLclM5WnM5T0xzRU1s?=
 =?utf-8?B?WnRPWE1wa1YzQmRLL1V6bUdwbEp2Wnkvd0tTU0tTak1YRDVoKzBiaEdjVXhn?=
 =?utf-8?B?V1lZNThqVjl3c1diclN6UVJhV2FqR20wc0lLOHNaTEZUWkJDcUdEbEdZci9y?=
 =?utf-8?B?TWdGMUd6bE9HUXoyaHhDOTR1ZUdNVzNBMjg1b2doSFg1ZkQ1eC9nVjNvcmM1?=
 =?utf-8?B?bHlpSzBsc3R5NE9rWlk2d0tDOFFLa1AzaElyTmxmeVlOR3ZKbjRvZlo3N3Jw?=
 =?utf-8?B?aHRRajYwTXVBcldNMlA1amZnTnhEbFdYQndOZzVoUWtaQ2pJUEFNSWt5U1ZQ?=
 =?utf-8?B?bG5GWUYyZnEvMS9mKzVTTUlRM2VwTDN0RGpzWWY1dXlyTEdYVmhERndsN2Rn?=
 =?utf-8?B?S1NHNTFFbmtkRkptWnVZVGpPR295OTdpWThXU0xNT1AwVHZkbXcyRGVIR215?=
 =?utf-8?B?NnFsRndDSlh1dU5kL3pzdlpBVnZ2anE2MS8zUFdmR213SmVOcG5DaGZ3eEVu?=
 =?utf-8?B?bU5Qem5DVG9EamNQa2l6bXd2S1NjMW44Z0xuWGFEZ0ZqendmZUhlUnFOOHg5?=
 =?utf-8?B?SlJuVWxhci9jU0JTckxvU1o4MFB2eEV1a3FTYzlJZ09HMjI5THl1UWV1Z3dZ?=
 =?utf-8?Q?EKic=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F4E222B4D18494AA7107E60909771D5@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48005892-39b8-4631-93d5-08ddde419c5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 10:25:53.3940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1gGdj58lrxO5WqkPCrU8W+lzpWZv7A5SspI1z4JR+zUuvfKCvN9Tty5VXJGr4PISmG667e6/amr+OjY3k0vlUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB7997

DQo+IE9uIE1vbiwgQXVnIDE4LCAyMDI1IGF0IDEyOjAx4oCvUE0gWGljaGFvIFpoYW8gPHpoYW8u
eGljaGFvQHZpdm8uY29tPiB3cm90ZToNCj4+IFRoZSByZXN1bHQgb2YgaW50ZWdlciBjb21wYXJp
c29uIGFscmVhZHkgZXZhbHVhdGVzIHRvIGJvb2wuIE5vIG5lZWQgZm9yDQo+PiBleHBsaWNpdCBj
b252ZXJzaW9uLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFhpY2hhbyBaaGFvIDx6aGFvLnhpY2hh
b0B2aXZvLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jIHwg
MiArLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyBiL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb192ZHBhLmMNCj4+IGluZGV4IDY1N2IwN2E2MDc4OC4uMDllZTgxNDcw
MzIzIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYw0KPj4gKysr
IGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYw0KPj4gQEAgLTE3Niw3ICsxNzYsNyBAQCB2
aXJ0aW9fdmRwYV9zZXR1cF92cShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgdW5zaWduZWQg
aW50IGluZGV4LA0KPj4gICAgICAgICAgaWYgKG9wcy0+Z2V0X3ZxX251bV9taW4pDQo+PiAgICAg
ICAgICAgICAgICAgIG1pbl9udW0gPSBvcHMtPmdldF92cV9udW1fbWluKHZkcGEpOw0KPj4NCj4+
IC0gICAgICAgbWF5X3JlZHVjZV9udW0gPSAobWF4X251bSA9PSBtaW5fbnVtKSA/IGZhbHNlIDog
dHJ1ZTsNCj4+ICsgICAgICAgbWF5X3JlZHVjZV9udW0gPSAhKG1heF9udW0gPT0gbWluX251bSk7
DQo+IFdoYXQgYWJvdXQgbWF4X251bSAhPSBtaW5fbnVtID8NCg0KWWVzLCBJIGFncmVlLiBJIGFt
IHByZXBhcmluZyB0byBtb2RpZnkgaXQgYW5kIHNlbmQgYSB2MyB2ZXJzaW9uLlRoYW5rIHlvdS4N
Cg0KQmVzdCByZWdhcmRzLA0KDQpYaWNoYW8gWmhhbw0KDQo+PiAgICAgICAgICAvKiBDcmVhdGUg
dGhlIHZyaW5nICovDQo+PiAgICAgICAgICBhbGlnbiA9IG9wcy0+Z2V0X3ZxX2FsaWduKHZkcGEp
Ow0KPj4gLS0NCj4+IDIuMzQuMQ0KPj4NCg0K
