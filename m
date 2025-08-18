Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013045.outbound.protection.outlook.com [52.101.127.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C6C273D77
	for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510977; cv=fail; b=p86MZI1bzRkgjyJvdTLdDAYXKjpdFiibrl3hnUL7NUiGYvaoIj8Y/lWyocBfaY9wzcESGJzQi9LqtoBpEk0YnDdpxZSxy44v7O5PL+BIhPXA0qGl+LNotS5nP0LrClaDWTkt/DcnYEyaxoMP0NbJE6uMmLtkQPYP9kV7DDrCO58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510977; c=relaxed/simple;
	bh=KMf48f1L5o2RVFdn+SvQ2h9D+Z/9mKl310bRhoG8EOg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iIXi+2wfzBcjJyK/tdtZbUSfi6hQz8Y1sM85/pxiGF3hdIj9eIH7PcVhasIwFatpIQjB528ZqsjVd4CVN+gA85qO7/ifJ9Cuc7M6hT/jOFo7e46IgNT2+nrgE8MxBnyA3OGhsiJids8npWB4VG1VpoQtx0yg3ivQifL1k6AhZMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=TQHMMSXh; arc=fail smtp.client-ip=52.101.127.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="TQHMMSXh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mToADz5MfeQkjYEcIkEVaiHRZh0DOviyCMciBli5dv2Ab7hRK0RuwX8kBupOr753s4EwOHnutBuSUqSrt7LHgJiCuyxfBONUM+8xSBQfWBX/lZBFwNyKlWQFQ6i9KOS33gX3nLa5Wn26gUwCPN/UguSpQvcCepu8keHQuZ3VKNs2exwa48haAxeSJGELnm9fMpfVYjBGQ7McM72pOpSV4yhmHdE41On5aw8KECskZJ6V9UAfApKYxLNv2KECGR3q1rwM9PtQAit93DZyCB2Qk5j7CwhwiNG2RQMEH8aYSuHxAyDwL6Fz0Dmn0ZPiZ/uwhY73UNGKQ1GID6myeLHjEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMf48f1L5o2RVFdn+SvQ2h9D+Z/9mKl310bRhoG8EOg=;
 b=lfgv3wCq6Xm1BcVvC5udUOeJ8MXDCPwZWQmHjSod2qqXxBA8M6iOBEi4oSSd+hPzc08EANg8hrgELeTuR2NM377991Fa2WpP7D+AU6rOa3VVxQhYba8QF3vcRai1RDrWx8lyqJmU4eb5eSCvdCoyoquB126YzXOFpkEDYgrKjLmclqKpT9j4sl9zIr9Xd+Nd37/Mg4qd+8yrrcW4ttZf5uJev1xMTTaunav+f5c4brMonWN9wy9KFE11tf7BiHTmcygmsOgsFp+H6HeKtK2AtHNpOO3pWcyhRiovOul3ptOg6VKg/CSRwG0+R10DDbPVeiiyBdND/tDdZ6jRvcNxlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMf48f1L5o2RVFdn+SvQ2h9D+Z/9mKl310bRhoG8EOg=;
 b=TQHMMSXhhiTHZM6x3hM7G2EJ7B1W9vw9xjlfrbT2QQP31fl5kPYPM9v4hg0XNGRzOQmzVqM4r0pO2Thl1Q/flc2ORkmjPT2XSoPM7hSnZXaExeIT/DEV7MOfVIW/fC/xZGMZ2jpewP9atG651DO1hmm916T5da/eH4eO+YHUP/XsxW6yXuM1f6jR0FQCWqdI8kzQBiGPA94rl5uYp4oEkT8y5OweaMcw19ujlb13OuVTaqw4bKGM2g1ngfROQgzKTi8VCqSPayDnCdOhIIS0PaUhFHnBuvO5lBLEb7yBaZRNKwUDDepen8hAqK0g3G56BFMs7gd1W482+zO1n5S+jQ==
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by PUZPR06MB5674.apcprd06.prod.outlook.com (2603:1096:301:fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 09:56:10 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 09:56:10 +0000
From: =?utf-8?B?6LW16KW/6LaF?= <zhao.xichao@vivo.com>
To: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>
CC: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio-vdpa: simplify the code by removing unnecessary
 variables
Thread-Topic: [PATCH] virtio-vdpa: simplify the code by removing unnecessary
 variables
Thread-Index: AQHcECEaF/v6cAT3+k6/MwQgG7f6LbRoKPyAgAADZwA=
Date: Mon, 18 Aug 2025 09:56:10 +0000
Message-ID: <6689b30d-62a9-4c6f-8601-c7b8ccfd4855@vivo.com>
References: <20250818091839.550777-1-zhao.xichao@vivo.com>
 <8ab77680-ac53-49a3-8e0c-d74cd04dacd4@vivo.com>
In-Reply-To: <8ab77680-ac53-49a3-8e0c-d74cd04dacd4@vivo.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR06MB6020:EE_|PUZPR06MB5674:EE_
x-ms-office365-filtering-correlation-id: 735d39e7-3fcc-45b9-27ba-08ddde3d75bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|42112799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WXB1UWR1RXpuMzRIbk1iSDRlOWsxdnFLWkRLRHptM0tMRVl5aU9vT2pVdTFD?=
 =?utf-8?B?b0ErZUdXRE95dlJWSTJ4bUpoZGcwV2xOS3VTWnJFSjQ3OEpLeXFSOWlKSUQx?=
 =?utf-8?B?MEtxOWE4TVQvd2E4ZW1qUDY1dVM0MzJ6anZvcEdUT0QvZDN5d1hTZU8vNEpM?=
 =?utf-8?B?TmkvNXBPU2hTT1NvY1VlQU1janFZaUNCRVNxQ3pEbjNGUk9ROUlRL2xvVGVV?=
 =?utf-8?B?Y0QxUUVRVENBRWU3N0xzT3ptQ1ErTXhOMnlsTmFXR3oxSE1aRVpadVo1eUpT?=
 =?utf-8?B?MkFyMVRWQTJWSjhzbkgvekN5SDhhR09Id0drUVREZ1FrZGRWTzZ1ODBES0Qw?=
 =?utf-8?B?RVAxZFBOSXRQWjNnZWgwOUM3ZWNlclhLYkhkb0RVaGJ5eDNzM2d2U0ptNVZN?=
 =?utf-8?B?S2ZHMHZ6cjdhNmFadEUwQ1JMYkZYK3JINEZJd0gvL2wwaG8rbFptL0FWcHVk?=
 =?utf-8?B?Tlk5aktnbmpZMDZIUnBjMTh5aGpBMlNLeVFpbldnQmJsOW82QW8zaEN0RlBS?=
 =?utf-8?B?NGtUV2hUOVVubVNPR0xRcWk4ZjBWSFlqK2FNaWIrZ3FPMEF2SEtjSGZ4KzlH?=
 =?utf-8?B?S2pFMGRmYkk4S0tTMFkrd1d1YXBqcFRJRzhQWnNqUC9NNzhsR2p5U3grR2wv?=
 =?utf-8?B?bk1uNTBobWZuQkVRQld0OG1RajV5YWVJOWxzSkpqU2FLSHdMWG1RS1BxVnBo?=
 =?utf-8?B?emNrbFk1dHdCemIwVDNHOFFKU1hnYlZUWTY0RzRpbkcrRHo1bC9jb0ZNS0Rz?=
 =?utf-8?B?OU5mUS9FREQ0cWRkeVprdFhhd3hDY1ZYa2pzTTdZRnRMejhOSmt4Vlc2UUxw?=
 =?utf-8?B?eVhJakZ2TGRwaE9LS2dKRkRQQ1BJN1c4YVduQ2FCNDRSUk5kKzI0ckEyb0xK?=
 =?utf-8?B?LzJDYzBkM3dCY3VwQW82eWsvMlNCVUIzZkM4eGhWdTBsdWRUcjc3U0VWVDVN?=
 =?utf-8?B?ZFRHaEJxUklqZkVwSnlpanY0YlhLZEl5bStyeStvV08vcFo0MkVpaThEWXlq?=
 =?utf-8?B?WlI3T3g3NHZJamFqckFzZWUwbklqU09xeFZUUHFRcTNyYUdTWEJZbTdUdEow?=
 =?utf-8?B?VkNKdzlyMEp3N3NrQVZpTEhDazdSTk9zQ2xVV0JNSEZQaUJiZlZqekVoUVZl?=
 =?utf-8?B?clZmT09DbWRNdlY4UHIvT05SMC80ZzJ1eHFtNXMydFRuTjduTzVGM1prV0p0?=
 =?utf-8?B?S3YwOHJWNFk3UzRzc1NDL2diWWExdDdFZkIvOGpPWFVRQVpUWUZ1OXdkb1Vu?=
 =?utf-8?B?WHlNamlNc25qcXhUSTNSb0RzOTBWRVNIUm03YzdWVVhxdkVINFF0b2Z1ZTlz?=
 =?utf-8?B?b3NGQzRDeVF5L0s1KzNEdG1YWDZLQW1rRmpSR2xMVUd5Vi9UZm8vZUxhSFUr?=
 =?utf-8?B?MExWOC82YzA2azFBNnRYcHB4ZzJ1anNnU3VjUnVsWkhXdDdHMlhFWXFoS1dW?=
 =?utf-8?B?aEZUZDRndUVMMEZMMHRic2w3cG9PTTFKV1RBQjk4Um1La0swRVVkTnYzcjdW?=
 =?utf-8?B?dEdUN0hWTm1IdlRxZERrakVHcmZJMFhXdDArS2Foc25SYy9qVFd4S05HU0RK?=
 =?utf-8?B?T0xnbXZNdFBSSzNDL0M1Zk5adG1JcXJoR2dISW1sdnN6Z2hDNk90QmFVNWVx?=
 =?utf-8?B?Nlg0Tit1TXM2aWZDWDdJWktFOGUraHUzTzFBeWZRYTB6MVlvTUJCbWVTZ3A2?=
 =?utf-8?B?eXlHZTNGcWtmK3JYdXBBZXl4YkN4a1YxOFJSa0kveHhtbVBUcGlPYkV1dFR0?=
 =?utf-8?B?Rnl5aDRBc0pXVHFrM1E3SUl5UU1ZZG9KUy9hV0ZYelo1UzRvK3N3K1JJRVRD?=
 =?utf-8?B?UjFsVUtSWEkrS2RpNUowZkg4bWJVNm1GSVJMWUp5aW41eERibnpqalVDMUFo?=
 =?utf-8?B?ZFRPazBvcjNNb21CRlhyT09lOUtPSjQ5dGNIeCtnQlAvcjF0TjBqczZSL3pD?=
 =?utf-8?B?TG5NeC9MNThteHdtd3QrL3Z0TzJPNXZadDQzRGh1MU1lQUdtcEdoT1V5bzZX?=
 =?utf-8?Q?RyL/BubEYCSK1Ft5MC3Efk268T1Fyw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(42112799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SXpIVTFzREtSS1Rub1ljZTYwbXVkbE9NSmVydHo5UzlscDU3dU1aZUZ2UXUr?=
 =?utf-8?B?K3pETDh2L2ZiZ2hTQ1VMdGlIRGQwV0hZaWlJQ3RPeVBhYjJONTVUNUx1YWF5?=
 =?utf-8?B?cUprUy9wU3Y5bTc4N3hmejJpRjZIeGRnRU5aaUhUNFRnVytUWXNMYnRObnpl?=
 =?utf-8?B?WkV5a3gxUkFXRlBzME5JL3hDcjdzVnRSWDl6cXhyRXhROUJMMzJVTzZJZUtu?=
 =?utf-8?B?di93SEp2ZXFxRTBnWTdUbjVEenBJUFVWUWdOSUcyZnhGREJSTEppQm52b3JG?=
 =?utf-8?B?c3ArZFkwSWJTMkUyelpiY05kYXB2dXJIY0p1SllablVET1YvdllVODVEbDFS?=
 =?utf-8?B?ZXpIM2QwSDVHb2ZEWTIwUEZ4VGp0ZVlubDVjeVBqSEdJazc0VVorK2VxSWoz?=
 =?utf-8?B?WU9JdjVNTUZQWWFKajQ0Q2lXT3FHM1FZTEMxdmg3ekFuSG80QktyU3dyWHc3?=
 =?utf-8?B?Z2cwYUxkdFpJMkVWRXhPS0h6UUhCL1JEVjhQWTJTa3phS2RrUW9kamdoVGQ1?=
 =?utf-8?B?WUxvbUQrVFVzMEl0RW1UVlNIYXNSUXgrSXI3L2JWQ0R2QllHc3k0c2tOcEo3?=
 =?utf-8?B?SmFIQkJldnNBUnV5VG80WDAwYkNkZmhNaExIU0F5emdWaWl6SU1sRStMcXNk?=
 =?utf-8?B?bG9QY09Qb0NpTlBIWlcwSUZDcTc5UU9qVjNDMzRrdjd1N3U1dkQxV1FmVlg5?=
 =?utf-8?B?U2NnaFFhbVU4Mm9WNjM1Q0pSSFFkcXB0dnRtU3dxZkhTYUIxdEdvY0JoeGJT?=
 =?utf-8?B?SVJaaGZMcUJ1eDZtT3VXdHBpTWFOOU5scUI3RENKNUI2LytjeWlFRndHZUs3?=
 =?utf-8?B?ZDRhZFp4YTczOHR6WjZrWlF2SmZPcitBZVkzVmVpQU5jZnJMUi9ZQWhOK25T?=
 =?utf-8?B?NUFxQk5yMnZCcmJzVjg2RnZZR0RDZ0xDM0RSZGxUL1pxNUVHODd6MG0rdTZV?=
 =?utf-8?B?U25QWmdIamhEYlN4OUdnNmJ4UThkc0k1WFpTZWgzNEIzcXpnSURPV2lmY0Er?=
 =?utf-8?B?c1dGTHN6NTh6SjRWaDJ3aExOY3hJT0lNdHFNWlJyRlBGeHFrVkpualQwaUda?=
 =?utf-8?B?UHJxZGcrT3J3ZUpuWU03eXdHVmlONy9sNmpTLzJQaWdVSjhSYUtzdzRubTRN?=
 =?utf-8?B?dFBhZnJhVTFIeWRxNUJwY0d3UTFVMnNXb1J6anczSnR6dVJkZ2VQcGtIR3ZE?=
 =?utf-8?B?TUx1R1BUNGNwdTh6T1hYRWwxTnJIc3BNRllDdy9iM2dDYkpkdHpoczZNTmZ0?=
 =?utf-8?B?Q1F1Q0tWbVFLMTZGT0JuVEpJOXNYbUp5NlhiNzdaa21sdzhoS0sxWjRYNEcz?=
 =?utf-8?B?YmJXUkNpcHdORmVVMGc4cUVJTHRhQ0lpTlRJQ0hqYWo4emN0MmszakNmWGo2?=
 =?utf-8?B?UVd5K2Q2WEhra3BFdDJ3QXBiUVFHRW1CSU55a1BSWWI4K2M1SllkRmFtVXhI?=
 =?utf-8?B?WFduYjJGU3dZU3ArS1gydTJ4bmpWbmNnaG9vU2lJMXpJVUVjd2VqZ2NhRTNK?=
 =?utf-8?B?V3NxcUlNWUN2UjRBTEJPMER0Y1BqU1RpU1czemxXaG9lcDk3MTlpSGVoWlBP?=
 =?utf-8?B?czdwZDlYUUVBN3FUVVdqY2V0OHVRbitjYzJMcTlWaGErREtRYytOcGd1RUQ0?=
 =?utf-8?B?cUtUUWVrT3g0Ynl3NlNRQnZJeUlXTGx6MFhxLzhObnB4UmtjVlp0MVU5alNs?=
 =?utf-8?B?Zi8yTlhBbDV3Y0dSTUhlZWk1bmdDUVViN3ZEcEZ2SmZRQXRoSWU4a2pkeGtN?=
 =?utf-8?B?dDJnZmV2VjJ5K3ovc3FFOU9VM2RkS0J5cW5ETUY4YUc1cTNtdkN4eVEwZU1v?=
 =?utf-8?B?S1pZeFhCdUc5eFJ6R3V5OFd0cndjeDhTdWlkU3lxMEdERm9TOXF2V1J4cXBo?=
 =?utf-8?B?b2h5SUQ1R05XWTlrYVJWWWtCdDl2MTZVRzg2d0tHNWlUT0pCY1A4NVQ0SjMz?=
 =?utf-8?B?NFlNdzZrTzQrQVY0VUZ2Qy9uNlRBbkczSjl0RHVINW5jRXJEbHdOSEJ1ZHVs?=
 =?utf-8?B?SWpsTlozUGNyeVgvTW9IMVJ0dzZnUTR1ek9FSnJHK2dMV1FOVGpaVGxQZGdO?=
 =?utf-8?B?QU5hNmgwbXBYZWFDU0s5TlF5WFZ2YjVPTTVGeGIvYU9BTFEzUTZXYTNLU3hG?=
 =?utf-8?Q?cRZ0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F752741653B6D46B183E83FE8B198A4@apcprd06.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 735d39e7-3fcc-45b9-27ba-08ddde3d75bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 09:56:10.5671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pvaIicfHyfY2H+7nf16Lqpqq3/RpCjc2lkWwzkTw+RgEhdO8ka4vg0f/5PbKNqqIRrOIgjFuv0RFJd/oh99hKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5674

PiBIaSBhbGwsDQo+DQo+IEFwb2xvZ2llcyBmb3IgdGhlIG92ZXJzaWdodDsgdGhpcyBwYXRjaCBj
b250YWlucyBpc3N1ZXMuIEkgd2lsbCBzZW5kIGEgDQo+IHYyIHZlcnNpb24gb2YgdGhlIHBhdGNo
IHRvIGNvcnJlY3QgdGhlbS4NCj4NCj4gQmVzdCByZWdhcmRzLA0KPg0KPiBYaWNoYW8gWmhhbw0K
Pg0KPj4gVGhlIG1heV9yZWR1Y2VfbnVtIGlzIHVzZWQgb25seSBvbmNlIGFuZCBoYXMgYSByZWR1
bmRhbnQgY29udmVyc2lvbiB0byBib29sLg0KPj4gVGhlcmVmb3JlLCByZW1vdmUgaXQuDQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogWGljaGFvIFpoYW88emhhby54aWNoYW9Adml2by5jb20+DQo+PiAt
LS0NCj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyB8IDUgKy0tLS0NCj4+ICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jIGIvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3ZkcGEuYw0KPj4gaW5kZXggNjU3YjA3YTYwNzg4Li44Zjc2MmJhZGVjODYgMTAwNjQ0DQo+
PiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jDQo+PiArKysgYi9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fdmRwYS5jDQo+PiBAQCAtMTQyLDcgKzE0Miw2IEBAIHZpcnRpb192ZHBhX3Nl
dHVwX3ZxKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQgaW5kZXgsDQo+
PiAgIAkvKiBBc3N1bWUgc3BsaXQgdmlydHF1ZXVlLCBzd2l0Y2ggdG8gcGFja2VkIGlmIG5lY2Vz
c2FyeSAqLw0KPj4gICAJc3RydWN0IHZkcGFfdnFfc3RhdGUgc3RhdGUgPSB7MH07DQo+PiAgIAl1
MzIgYWxpZ24sIG1heF9udW0sIG1pbl9udW0gPSAxOw0KPj4gLQlib29sIG1heV9yZWR1Y2VfbnVt
ID0gdHJ1ZTsNCj4+ICAgCWludCBlcnI7DQo+PiAgIA0KPj4gICAJaWYgKCFuYW1lKQ0KPj4gQEAg
LTE3Niw4ICsxNzUsNiBAQCB2aXJ0aW9fdmRwYV9zZXR1cF92cShzdHJ1Y3QgdmlydGlvX2Rldmlj
ZSAqdmRldiwgdW5zaWduZWQgaW50IGluZGV4LA0KPj4gICAJaWYgKG9wcy0+Z2V0X3ZxX251bV9t
aW4pDQo+PiAgIAkJbWluX251bSA9IG9wcy0+Z2V0X3ZxX251bV9taW4odmRwYSk7DQo+PiAgIA0K
Pj4gLQltYXlfcmVkdWNlX251bSA9IChtYXhfbnVtID09IG1pbl9udW0pID8gZmFsc2UgOiB0cnVl
Ow0KPj4gLQ0KPj4gICAJLyogQ3JlYXRlIHRoZSB2cmluZyAqLw0KPj4gICAJYWxpZ24gPSBvcHMt
PmdldF92cV9hbGlnbih2ZHBhKTsNCj4+ICAgDQo+PiBAQCAtMTg2LDcgKzE4Myw3IEBAIHZpcnRp
b192ZHBhX3NldHVwX3ZxKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQg
aW5kZXgsDQo+PiAgIAllbHNlDQo+PiAgIAkJZG1hX2RldiA9IHZkcGFfZ2V0X2RtYV9kZXYodmRw
YSk7DQo+PiAgIAl2cSA9IHZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfZG1hKGluZGV4LCBtYXhfbnVt
LCBhbGlnbiwgdmRldiwNCj4+IC0JCQkJCXRydWUsIG1heV9yZWR1Y2VfbnVtLCBjdHgsDQo+PiAr
CQkJCQl0cnVlLCBtYXhfbnVtID09IG1pbl9udW0sIGN0eCwNCj4+ICAgCQkJCQlub3RpZnksIGNh
bGxiYWNrLCBuYW1lLCBkbWFfZGV2KTsNCj4+ICAgCWlmICghdnEpIHsNCj4+ICAgCQllcnIgPSAt
RU5PTUVNOw0KPg0KPg0KDQo=
