Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98DA16F84F
	for <virtualization@lists.linux.dev>; Tue, 28 May 2024 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906122; cv=fail; b=nX2prCkSe5IyQRG+s7jxLZfzRD1div5PWFk7oxxEkOEFp6xGS5Ubhw0EdiFCGm2seEUtwI3iip/wZcknvsIpXXSe6fihkHKNm1onE75K6+1uDU5T1DkQvFmD1M/jtBVlwWUK+Iqvg79DtY2Q3oyTZqcOukj9qlO9lfpzrcEoRhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906122; c=relaxed/simple;
	bh=U53q8zG6q14CWB2P+Lhl43+RKRzuYJ4hln3zKCjC3Xg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TFfW9zoQQh+W5rOQ8AeKZAFc3JSiEyFXuvgbhNmXp3x+hJeX0YZNFgAo40qIbWWmghcirjH9bGKk/OQkCjU+q8J8le6/sJeJhL18sdMGHt4xID4ClGYd5ePo6734pmkyMPFuB7inFNxvKzQH2iTDeY8wa+Kd4LcWjpOHm9gY+I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BY/NsLHr; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BY/NsLHr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzQ4+aZejkhc4vczpcaYKafqb1T5htJpSjV7RvBhMVOcTen+RaHnTrgstw3r7zicTn3cMRyxYyxkp09FONCeImGsoyRym1B/r+1SoUsJzxzA+Wg6WO4tpFhY9ajLNJjVpfLdyF3pqpsg+c62OQPh0YocbFrxwgWZn3RKfQhl2vaWYVgmxCblfwjQSAohHvtVp64sFhJMYsLaVT9ySTMvIrXuHypzxdXQ5ttkzMrWxnapx38cw4h4HK1vhqyBwZ1xfA+bDqcIyhBrOThOuve328cvWUel9bXnNgJH/wW2MtjXsMG7IrlGWEH7pDNnDic9jEQPNkjIXOMWWOrSviXXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U53q8zG6q14CWB2P+Lhl43+RKRzuYJ4hln3zKCjC3Xg=;
 b=hEoh+GIPULo2NkPitsSTUk5YSqVnq6gxWnOxUsI40WRn3HfVOphsaPw38xyb1KDVRYi2aAMnpSGpNkR47B8qcLMiLqz5gFzM5iL68JIBm886wNYTan90D/6Wh9QeL6nZRGhy4RkYXWHdMXkJSQ1KXOANIUYwuPOfbRJGxNWlA6Dub79sw+z85B6hkcU1iP2/DyTIZVyQhkLHCOU+7Y0+U40iHdRLupclztGjhjcMzfELBUOjKiJXmRHs2uUIgS1arO+iO6BsNnQRHsCA5CV5Jy6J3c8zOJWNJNE0j/ZJtWSDPBzwptKP4fsUtFNemD7NZcD9lTXZ/LgoFIVMEND62A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U53q8zG6q14CWB2P+Lhl43+RKRzuYJ4hln3zKCjC3Xg=;
 b=BY/NsLHrpn8lbVpgP7EsLtVPUHCVBIZm5O+IF2idSmAeAVUNZGUyL0WDu4V07zqp9ssBbMSbVk7SjWIajQPJmhvsiLnTzubZCM3rBVr2+JPabpu3XRTxT2zBv33nw4q4YToddAN+wJ52T8a1t0vzfaI0hDo3xeH5fDQk+v/LpxlD4uk+2Wmyc6jpfREyg7gJ7y8ipAWBdqGVaUbA6CwoJdjXa4v0v9sKAiiwvS4R6if2/671bmx/9AWI4mOzK7F6F4i/Ra0LVfhoo1SRolkS4eOLOwq0L6/slHOZ/0FJWDHZX2CRGwdbcs4F8eo16/sj6rlFN4hhiEj82PlVfSKtRA==
Received: from SN7PR12MB7833.namprd12.prod.outlook.com (2603:10b6:806:344::15)
 by DS0PR12MB8368.namprd12.prod.outlook.com (2603:10b6:8:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 14:21:56 +0000
Received: from SN7PR12MB7833.namprd12.prod.outlook.com
 ([fe80::6f09:43ac:d28:b19]) by SN7PR12MB7833.namprd12.prod.outlook.com
 ([fe80::6f09:43ac:d28:b19%6]) with mapi id 15.20.7633.017; Tue, 28 May 2024
 14:21:56 +0000
From: Peter-Jan Gootzen <pgootzen@nvidia.com>
To: "miklos@szeredi.hu" <miklos@szeredi.hu>, "jefflexu@linux.alibaba.com"
	<jefflexu@linux.alibaba.com>
CC: "vgoyal@redhat.com" <vgoyal@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Yoray Zack
	<yorayz@nvidia.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Max
 Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 2/2] virtio-fs: add multi-queue support
Thread-Topic: [PATCH 2/2] virtio-fs: add multi-queue support
Thread-Index: AQHam9202+2TyynzgE27Na4LWMIzbLGsgNEAgAA0ZoCAABrUAIAADQoA
Date: Tue, 28 May 2024 14:21:56 +0000
Message-ID: <33d6f262b9c5c7c2d23bd0062a88262b597abc84.camel@nvidia.com>
References: <20240501153817.540855-1-pgootzen@nvidia.com>
	 <20240501153817.540855-3-pgootzen@nvidia.com>
	 <08795907-fb19-47d7-a8c9-3db0ecc91889@linux.alibaba.com>
	 <CAJfpegs7Dgn1++gYU5jNmCbiJwDFxWShgH_0fkaSN13nmbiY-g@mail.gmail.com>
	 <1672df38-7b97-41f5-802d-ee50f83a885f@linux.alibaba.com>
In-Reply-To: <1672df38-7b97-41f5-802d-ee50f83a885f@linux.alibaba.com>
Reply-To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7833:EE_|DS0PR12MB8368:EE_
x-ms-office365-filtering-correlation-id: 42e95e6d-1888-4e19-f4f3-08dc7f218790
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?SWt6c3NDY25NQ3RaUFVaN0dsdzVWYlVidmVRWHYzTmY1Q1dlSDMxZDhUU0pv?=
 =?utf-8?B?T3VmNStER1VSb0JjZmM2S3lwdjB3NDhGeWNIRXdsakFHZzJmYzF3ZnNPR015?=
 =?utf-8?B?R0NjcThyRTdrOG5EZi9HYm9FWDQwTjMzUE5VamNCK3JCYXdLZWU1V1lhNGth?=
 =?utf-8?B?cDV4blJzVitwbndRT00rTTJxVFdvYnlvdUo0NzY3L3BQbTNhWU0xcWxWZElD?=
 =?utf-8?B?WVBRT25VY09Ma3d2ZzIvQWIveXNFRDdUcmx5aUE3dDV3enJWbHZPb1owN1Y1?=
 =?utf-8?B?c0E1QkRwdVVqODdkOUx1MHFMNTh6REdzMkFMaWMrR0hpVWlCR08yZjZOQkM2?=
 =?utf-8?B?NWhJOE03elJaNWVBbXhyNk4rYXBMMFU2SUd6bmdZNXJmMVpPRndFUHJoS2pt?=
 =?utf-8?B?RTQ1UlhHeGFCT0tnWGt3dkdwOGxDN3BzUTBvNGNYODBTbU9FNjVpVURLUEVm?=
 =?utf-8?B?WXJ6cm15YTI1RXBmNmxxU3ZGMlQ5QXFPbnUxN1IyTUl4YmJNZE5KQjBwUjJ2?=
 =?utf-8?B?RkRneHA0MmowWUc0TFdqeHFyYkhCOEMrWXJ5WlRaYVlhbHA3aURNOXltZkNT?=
 =?utf-8?B?ZGhINEprUjE4NnF3Vlp3aFcwaUV5eTNrcWVaWFgyMUJELzBOemx1Nk1Nd0VG?=
 =?utf-8?B?dzJmaXJjYlR1TkNrNVBHaW5HVVpueHpmNU1ieWlvY1ZpTTgzdkM4QzNmUzc0?=
 =?utf-8?B?SURVbW9iVldtTjVmS1FSVUxWK0pENGNncE10VVpsWlB0VkhmaWk2R2N1aEQz?=
 =?utf-8?B?bFczeG84SnZZWmE5dTJ0alMxQzZLSTBZSHFEb0tmVEVtWDQvcmVkZDhZUDFC?=
 =?utf-8?B?aFNKam5zMHY0NGczNkQ5WW9ObFV4UmlnNjJKRkZYYXZib2ZBSU1FckdTQWha?=
 =?utf-8?B?VXQxYjFYQWd3dERnTnVBK3ZDZjJwMHFlbTNqMi9xU0hTbUxtdlhlTmF2VHd1?=
 =?utf-8?B?ZUxoejR4bmZPR1hlOUFPV2UyRDlFKys2dWlMMC9aNW1lSi9rTllMTTJZcUl4?=
 =?utf-8?B?dUdGYkZoYjZtTldYTkk3aXVKanNzSmV6R3NOODk2a1Z6dk13cjJZZXN0dU9j?=
 =?utf-8?B?VlFnWVFSdnBOMks2T2xYblBmZnhUcS83R1ZUWUtFMWE4V1BzaE5BUGVuekdL?=
 =?utf-8?B?dGwzeUtLTmhtQlNmcnh3eXJmTkF4dVFXWmx6R0N5bXcvdE1VbDRkeUJaeGJZ?=
 =?utf-8?B?RXhoVnQrTVNGS0R6ZXlSaFBXRXZNeWo2cEphSGdwSU5QalcyOXhvS2ZvSktP?=
 =?utf-8?B?aWUwRjA5MFVIMTZ1dGd6SVNFWkFsQ0RQL2hjZjQ1WG1EeDZFTVpzUWtOUFhL?=
 =?utf-8?B?Z1Z1NVRWRStYN2VUY24wTkVGUnJib3NsdzY3NXQ1LzkrZWhwb0pCa3pEdkl0?=
 =?utf-8?B?elAzYS9HZkUxWW01QzYwZXczQ3hSZFRjMDR2Smp4dTNnamF0VExEdVJMZ1NP?=
 =?utf-8?B?NUpqTjUzUHluQ1ljbkFOK01sSmlsdDZGYUkxU0lUNmc1WVBRSW9aSHZkNWFU?=
 =?utf-8?B?WW1QTFlqME9kVndIK1d4MzRFMDcvWVB5VFRHQnR4eFpnWXdwT0E2andjSUt2?=
 =?utf-8?B?NDdYU2h4NFlsN2VNYlZ5NDVvbHNBMWpTU3R5U1lNVVVJd1hmb2dkSGQwVXhw?=
 =?utf-8?B?UENOcnZTWDczQjE0UGRQV1YvelN4eExLMWF1UkdZTkpFNjFwcUlyRWpMVUZh?=
 =?utf-8?B?bHR2NUxOMFNUZnNCQnUvaGwxeXdNUUUwdFAvYy96bGVkaHYrQ05hT3hYZmY0?=
 =?utf-8?B?cHY5ZXZucG1yN3ZBcWFCOGVaZUMzK0lUVEtRRGwrZ2tpOUtiQm1oSnBieTZF?=
 =?utf-8?B?S084dDZZZGZuNjZ1aGsrZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7833.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OW04U2ZvVFM4YmxkbVh2Q3pmZm5LUG9FVXRST2JNZ2ptTGdFM1N1bm9YN2ZL?=
 =?utf-8?B?UXR1T2crbGRvNXE3SUEvRjJDQVlCdkptVmZwZEFEbFpjT0xNc1E5YTFrSTlY?=
 =?utf-8?B?dU9sMCs4WVZ2VGJrcG5hQzVhZUwrUHEwcHVvRFdTRHFxbHBQYkhpL2VBNERK?=
 =?utf-8?B?TXEzNmI2YytwdjZST1JsV1hQenQ5WWc2NVlmL0crUlIyYk9hZnZkekIrdmJB?=
 =?utf-8?B?bEpMMFFobTJ6MTFOSEJJZ2lNV2NzM3BodHJGTFFCSzFLaVFDM1lDWElCQXM4?=
 =?utf-8?B?VUFTTW9FVTBKaENEaXo4Zlh5emlsdzAxcTZ0RjUxU0JQd0NaUmlpbThPSTJh?=
 =?utf-8?B?RWFMRTFlcVFUeUlSZ2RVZ0hBMEVsd2NJaklLTkpvUXVScVFvcEViMk43eUt3?=
 =?utf-8?B?Y3pWekovMHB2S1dwT2FTTDJkZFFFdEp3U1lYRXZYL2lQQ3dVM0M5a1dQdzZM?=
 =?utf-8?B?b2xWNGMzV2JuZE9IMlhzcW1ETGlMdGFkcUhNMXNKeUIvVndIZUxxTnBvclFr?=
 =?utf-8?B?VzVtN0xTbzVBTmJwOUpYN1B1UmV0c3ErNjJiVVdHVFMrTFNxaEJKRDF1VmZH?=
 =?utf-8?B?SHFxR3N0K2s2WnVVM28wVzh6a2Z0cndQYmxRYTliSENQWng1RUovcUp4TjQw?=
 =?utf-8?B?cWZaQ2tBR3I2RFZBcjdpSGVYRGlyNHo4YzQxWWl5ZEFTUHViYlRqT2p2ZHVs?=
 =?utf-8?B?T2FQeFh6ODBrcDNRd01ySTRJdUZWTEVDaGNOMWM3K3RFRC9MeUNsL0J0QTJ6?=
 =?utf-8?B?QzlPYnZrVlZwM1NuTWZaMnI3YXkrcGp6OEVRZnVxWUJqSUhnOHpRd2ROVkxM?=
 =?utf-8?B?MW5wTWtTbHk5L1BacDZsMXpGU0h3UnRHUVU0dW40b1FUTi9UVXFPZ0h2WVFs?=
 =?utf-8?B?Nm9Wa3FrckRKQ0dYeGUzV1plbU93clpOZzlhZVlvd0xKMjdIM0swLzgvTFUy?=
 =?utf-8?B?NWxyNVJ0cHJ1OHNTWFJtTmk5Tm5ZZVpMZWNaVlY0cVpGNGZCOFpOeDVBOERv?=
 =?utf-8?B?V0tOOVA1Mk9GTmg4Y3grUjByMDBqZ2FhdVY4c0N0ZWFEUzFST2VydHo1YW9a?=
 =?utf-8?B?ZW9vUnpNb1ltZTNpemNFOHNIbTVZRkJSSk1FMEcwSXpDK1JxRmEyS25HcXFI?=
 =?utf-8?B?V0RvQnpmcG45Qm5YeXY5ZXc4L2kwU1NKRXNpUDNXY2hpSWR1QXZzcmFMSEg3?=
 =?utf-8?B?T0FtVFh1MlhWb0ZoYUt4UkJtN2pmTDY4WTZlSHpIMTlxOTM2ZlYzVy9JTEtz?=
 =?utf-8?B?Uyt5UmJWT2pmR2lEQ1BrNEJNekVXMGd5WjIwaUtOc2d2eDNtZEZnT2hDeHBt?=
 =?utf-8?B?VzE1WnIzK3Z6K2d3U2JYOXR6ckh4ZHU4TitDMm1uZUVUYmxYZEE1SXgvSTBO?=
 =?utf-8?B?UjM2QldnU1U3MFhmaWQ3SlNjUkJlQUlqd3BMMU9YM2xQU1FhVEZ6N1JhbDMx?=
 =?utf-8?B?aStWZFIxeXR3RWNTTkcrOGhTUWQ2YU5wWGxLeXQ3aTdWQk1rb0s5YWRjeEtZ?=
 =?utf-8?B?a0tqdDgwakdQQ3Y3dSs3UzlBUWl6aGNXTjFqK1JYYmY0SlRPSU9UTGo1WmZF?=
 =?utf-8?B?WWFXdFcxRTN1NDdkU1JobllRUml5cWFaMWlpNlBWbThhR2xoSGpsNkx4bGsv?=
 =?utf-8?B?WmdZdjZXdFEzTEYyVDFiUDBkSWFScTRPV1pnbGNsS0lJczk5M2FrS0lwWmxM?=
 =?utf-8?B?SFMxNkpFbitITnpJYUxVNSszS3duNXlpRnV1aEcvY203SkRkRlBXUVJRQ3FL?=
 =?utf-8?B?Nk9IVXRqdEdMQmVhL013Sk9LeHovVldDUURFaDJ2RU9KWjNHK3ZLc3p3T2No?=
 =?utf-8?B?Z1l4UEczTHVUSi92QW5lRDJzRzVFRVpGcnVMTFpwTmY4V0xXNjhpajZ6OWxC?=
 =?utf-8?B?VnA4dzYrdnlhRnZjTDljYWQvcXRIdko0WmFFdXNOTWNHUVBjTU52ZVd1MG1m?=
 =?utf-8?B?S2xWY0xxT0VYOXRYWVdINkw0dDBUVVFDT3VvaElTN3kxSmpmVkFxVmFzTWJY?=
 =?utf-8?B?TkF1YkttbVhRQUMvK1RaZVQ3V3RtMEhabVJLMUV4M3JUL3lDNHVwa2hKaUw1?=
 =?utf-8?B?MER6TTMzMFNEKzgzR2R4K2RudWFVOVhMMEJVT0hMM1p4SlBlNmxvMnR6T2sr?=
 =?utf-8?B?OG1CVU0wdVNxOWlEMjRGR0xOZUxITTdmSjZmcWNBTW9TODdrYjN3b1JiQld1?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F448D1D1AC5FAD4696EA8560FAA45804@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7833.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e95e6d-1888-4e19-f4f3-08dc7f218790
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 14:21:56.4711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bfhu1F02IZJEx+P0AnJGVspOiRsF7taBWQt9MVAfA1U61SwYNkbnNNj7XUPGxoWMmg29hQUm2nL4gbmuAP3MKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8368

T24gVHVlLCAyMDI0LTA1LTI4IGF0IDIxOjM1ICswODAwLCBKaW5nYm8gWHUgd3JvdGU6DQo+IEV4
dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+
IA0KPiANCj4gT24gNS8yOC8yNCA3OjU5IFBNLCBNaWtsb3MgU3plcmVkaSB3cm90ZToNCj4gPiBP
biBUdWUsIDI4IE1heSAyMDI0IGF0IDEwOjUyLCBKaW5nYm8gWHUgPGplZmZsZXh1QGxpbnV4LmFs
aWJhYmEuY29tPg0KPiA+IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBIaSBQZXRlci1KYW4sDQo+ID4g
PiANCj4gPiA+IFRoYW5rcyBmb3IgdGhlIGFtYXppbmcgd29yay4NCj4gPiA+IA0KPiA+ID4gSSdk
IGp1c3QgbGlrZSB0byBrbm93IGlmIHlvdSBoYXZlIGFueSBwbGFuIG9mIG1ha2luZyBmaXEgYW5k
IGZpcS0NCj4gPiA+ID5sb2NrDQo+ID4gPiBtb3JlIHNjYWxhYmxlLCBlLmcuIG1ha2UgZmlxIGEg
cGVyLUNQVSBzb2Z0d2FyZSBxdWV1ZT8NCj4gPiANCj4gPiBEb2luZyBhIHBlci1DUFUgcXVldWUg
aXMgbm90IG5lY2Vzc2FyaWx5IGEgZ29vZCBpZGVhOiBhc3luYyByZXF1ZXN0cw0KPiA+IGNvdWxk
IG92ZXJsb2FkIG9uZSBxdWV1ZSB3aGlsZSBvdGhlcnMgYXJlIGlkbGUuDQo+IA0KPiBJdCBpcyBp
biBGVVNFIHNjZW5hcmlvcyAoaW5zdGVhZCBvZiB2aXJ0aW9mcykuIFRoZXJlJ3Mgbm8gMToxIG1h
cHBpbmcNCj4gYmV0d2VlbiBDUFVzIGFuZCBkYWVtb24gdGhyZWFkcy7CoCBBbGwgcmVxdWVzdHMg
c3VibWl0dGVkIGZyb20gYWxsIENQVXMNCj4gYXJlIGVucXVldWVkIGluIG9uZSBnbG9iYWwgcGVu
ZGluZyBsaXN0LCBhbmQgYWxsIGRhZW1vbiB0aHJlYWRzIGZldGNoDQo+IHJlcXVlc3QgdG8gYmUg
cHJvY2Vzc2VkIGZyb20gdGhpcyBnbG9iYWwgcGVuZGluZyBsaXN0Lg0KVmlydGlvZnNkIGFsc28g
d29ya3MgaW4gdGhpcyB0aHJlYWQgcG9vbCBtYW5uZXIgd2l0aCBhIGdsb2JhbCBwZW5kaW5nDQps
aXN0IGFuZCBtYW55IGRhZW1vbiB0aHJlYWRzIGZldGNoaW5nIGZyb20gc2FpZCBsaXN0Lg0KDQo+
IA0KPiA+IA0KPiA+IE9uZSBpZGVhIGlzIHRvIGFsbG93IHJlcXVlc3QgdG8gZ28gdGhyb3VnaCBh
IHBlci1DUFUgZmFzdCBwYXRoIGlmDQo+ID4gdGhlDQo+ID4gcmVzcGVjdGl2ZSBsaXN0ZW5lciBp
cyBpZGxlLsKgIE90aGVyd2lzZSB0aGUgcmVxdWVzdCB3b3VsZCBlbnRlciB0aGUNCj4gPiBkZWZh
dWx0IHNsb3cgcXVldWUsIHdoZXJlIGlkbGUgbGlzdGVuZXJzIHdvdWxkIHBpY2sgcmVxdWVzdHMg
KGxpa2UNCj4gPiB0aGV5IGRvIG5vdykuDQo+IA0KPiBJIGd1ZXNzICJsaXN0ZW5lciIgcmVmZXJz
IHRvIG9uZSB0aHJlYWQgb2YgZnVzZSBkYWVtb24uDQo+IA0KPiANCj4gV2hlbiBjb21pbmcgdG8g
dmlydGlvZnMgc2NlbmFyaW9zLCB0aGVyZSdzIDE6MSBtYXBwaW5nIGJldHdlZW4gQ1BVcw0KPiBh
bmQNCj4gaGFyZHdhcmUgcXVldWVzLsKgIFRoZSByZXF1ZXN0cyB3aWxsIG9ubHkgYmUgcm91dGVk
IHRvIHRoZSBoYXJkd2FyZQ0KPiBxdWV1ZQ0KPiB0byB3aGljaCB0aGUgc3VibWl0dGVyIENQVSBt
YXBzLCBhbmQgdGh1cyB0aGVyZSdzIG5vIG1lYW5pbmcgc3RpbGwNCj4gbWFuYWdpbmcgcGVuZGlu
ZyByZXF1ZXN0cyBpbiBvbmUgZ2xvYmFsIHBlbmRpbmcgbGlzdC7CoCBJbiB0aGlzIGNhc2UsDQo+
IHRoZQ0KPiBwZXItQ1BVIHBlbmRpbmcgbGlzdCB0aGVvcmV0aWNhbGx5IGNhbiByZWR1Y2UgdGhl
IGxvY2sgY29udGVudGlvbiBvbg0KPiB0aGUNCj4gZ2xvYmFsIHBlbmRpbmcgbGlzdC4NCj4gDQo+
IA0KPiBJIGd1ZXNzIHdlIGhhdmUgYW4gaW50ZXJuYWwgUkZDIG9uIHBlci1DUFUgcGVuZGluZyBs
aXN0IGZvciB2aXJ0aW9mcy4NCj4gTGV0IG1lIHNlZSBpZiB0aGlzIHJlYWxseSBpbXByb3ZlcyB0
aGUgcGVyZm9ybWFuY2UgZnJvbSB0ZXN0Lg0KSSBhbSBhIGJpdCBjb25mdXNlZCBhYm91dCB0aGUg
c29mdHdhcmUgbGF5ZXJzIHdlIGFyZSB0YWxraW5nIGFib3V0IG5vdy4NCldlIGhhdmU6DQotIEZV
U0UgZHJpdmVyIChzbyB0aGUga2VybmVsIEZVU0UgZnMgZHJpdmVyKQ0KLSB2aXJ0aW8tZnMgZHJp
dmVyDQotIHZpcnRpb2ZzZCBhcyBhIHNvZnR3YXJlIHZpcnRpby1mcyBkZXZpY2UNCi0gSGFyZHdh
cmUgdmlydGlvLWZzIGRldmljZSBpbXBsZW1lbnRhdGlvbnMgKGUuZy4gQmx1ZUZpZWxkKQ0KLSBs
aWJmdXNlIChjb25uZWN0aW5nIC9kZXYvZnVzZSBhbmQgYSBGUyBpbXBsZW1lbnRhdGlvbikNCi0g
RmlsZSBzeXN0ZW1zIHRoYXQgYnVpbGQgdXBvbjogbGliZnVzZSwgdmlydGlvZnNkIG9yIHNvbWUg
aGFyZHdhcmUNCnZpcnRpby1mcyBpbXBsZW1lbnRhdGlvbg0KDQpTbyB5b3UgaGF2ZSBhIHBhdGNo
IGF0IGhhbmQgdGhhdCBmaXhlcyB0aGlzIGZpcSBhbmQgZmlxLT5sb2NrIGJvdHRsZW5lY2sNCmlu
IHRoZSBGVVNFIGRyaXZlciwgY29ycmVjdD8gSW4gdGhlIHZpcnRpby1mcyBkcml2ZXIgdGhlcmUg
aXMgbm8gcGVuZGluZw0KbGlzdCwgaXQganVzdCBwb3BzIGZyb20gdGhlIHBlbmRpbmcgbGlzdCBv
ZiB0aGUgRlVTRSBkcml2ZXIuDQoNCj4gDQo+IA0KPiAtLQ0KPiBUaGFua3MsDQo+IEppbmdibw0K
DQotIFBldGVyLUphbg0KDQo=
