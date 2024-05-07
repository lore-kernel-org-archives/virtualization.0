Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8976A10E3
	for <virtualization@lists.linux-foundation.org>; Tue,  7 May 2024 08:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715069278; cv=fail; b=qKkRqKkzQffxrKptml8j3FGQegEkK/Q0h3Cjz/Qf8vASluPyUk5n+KUm65UHiin5rTXo1gflNlv3F1l/fkdaWXoARPgSghwqhAFT1Gm1fi9JKIgzpOp/sJHW/5QQ5G8VjOSIgdpSOQmxBQEGmDscbsBPo8RMFE4RZL78Ya+6hQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715069278; c=relaxed/simple;
	bh=ELcbdG6PiARCZFQF1vQZ9p+jNh3LrlK2vSemLRXcYQY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=S469h8ex1yBtyq4SCDBifmMfTlO6imwnOgdMURcDB+8SyULs1VZbC82saHIHqtcpx78dfvPxjhfNwIxkR4d9pojhh5YN9yUMExwUzLp0DBU0JUNCXuqVoyc1UE54mfDLWMJ3B/DbV9w/V/5ltD21q+tjEUcp0lmyoSd44dLeOjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=phd.unipi.it header.i=@phd.unipi.it header.b=H3xxx7lI; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phd.unipi.it header.i=@phd.unipi.it header.b="H3xxx7lI"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2DE9582153
	for <virtualization@lists.linux-foundation.org>; Tue,  7 May 2024 08:07:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.002
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M4n6Ie3dtpuP for <virtualization@lists.linux-foundation.org>;
 Tue,  7 May 2024 08:07:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:260f::700; helo=eur04-he1-obe.outbound.protection.outlook.com; envelope-from=alberto.ottimo@phd.unipi.it; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org F179282151
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=phd.unipi.it
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F179282151
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=phd.unipi.it header.i=@phd.unipi.it header.a=rsa-sha256 header.s=selector1 header.b=H3xxx7lI
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on20700.outbound.protection.outlook.com [IPv6:2a01:111:f403:260f::700])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F179282151
	for <virtualization@lists.linux-foundation.org>; Tue,  7 May 2024 08:07:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m89GBG+IvYol/AZIiELolpQhj3e22XYT++ukhC/kyYpT7p51l9Snw+DLus8f2S8vO2euXY2j5P132wBEuMqBAy2Dmo9ElH94tAquYeN9PosJCfM0uvBVMruv+c13+cIB/yRZt+r/i/ikVhjxhkeFlByEmdcDCK4wAZXK+ExvmiVHe07DC6NhtsjUPsfAicxV+5r5LeZR6aTrU32sj6H+nIGLJD4bIl0ElXz66aNM3+3pcQC9O5E7ttk4pf+UBE+sAk+e7Sh/eebS94DVrGNCffYWKDI1TDWsXS+8uHZwuxoO/6nFhJmmedkeEpABFKSV0vSLQArNGOFhoRD2gfK72w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELcbdG6PiARCZFQF1vQZ9p+jNh3LrlK2vSemLRXcYQY=;
 b=gfn8V16wze9XspwP6QYvK7e858V+CKa5AGhSqrNkMz2uIxvr51oZEgd7sPu6wBJKBqCxo+UzyCxcWxzDFcImvKR87J4hz5jt2U4BKJBi3YPFVc8wx9Uug7sJHdVoMRJhuH5MI/wxu15Md8iT6JDxcTfABZtuM+xAr5n8dJNts7L9r5dICX9CoqKMYaZ1ykC2rW/gQwD5HT1l6CtR5HlULOIm/8XClTJAGuoqhy0taCb3PPjOLwo1hiGdIPkTbhU/62qazDKZE5HXBHUtBtaodIHvbJoStKkdPkx2FlVjDDNhpQgfUZVaSI1CIGgbob85mwqvamr3SpcQ8xKSuxvIAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phd.unipi.it; dmarc=pass action=none header.from=phd.unipi.it;
 dkim=pass header.d=phd.unipi.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phd.unipi.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELcbdG6PiARCZFQF1vQZ9p+jNh3LrlK2vSemLRXcYQY=;
 b=H3xxx7lImjRpEc6q+x3P0llEQW6hVb8GVnTJlReOXixFJNrfdQJePRaVUuF42mvLBxCKneWNnsM0zk7og4TQ1nTgq6DheL6JhGGb+HJAe3qFM1QFRbawBeU3GD3fTnCUlHezroFt/i3ZttdmzellIDO6wY4sr7d+nz40e1gRW14=
Received: from AS1PR07MB8408.eurprd07.prod.outlook.com (2603:10a6:20b:4c4::17)
 by PAXPR07MB7998.eurprd07.prod.outlook.com (2603:10a6:102:15d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 08:07:48 +0000
Received: from AS1PR07MB8408.eurprd07.prod.outlook.com
 ([fe80::926b:2378:b406:aab0]) by AS1PR07MB8408.eurprd07.prod.outlook.com
 ([fe80::926b:2378:b406:aab0%4]) with mapi id 15.20.7544.029; Tue, 7 May 2024
 08:07:48 +0000
From: Alberto Ottimo <alberto.ottimo@phd.unipi.it>
To: "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>
Subject: [CFP] WSCC 2024: Euro-Par 2024 International Workshop on Scalable
 Compute Continuum
Thread-Topic: [CFP] WSCC 2024: Euro-Par 2024 International Workshop on
 Scalable Compute Continuum
Thread-Index: AQHaoFWlhJBQrVl0eE+KVkQpTzGIBQ==
Date: Tue, 7 May 2024 08:07:47 +0000
Message-ID: <3CC43652-C3A2-44B7-8A2B-566EB21414CB@studenti.unipi.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phd.unipi.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR07MB8408:EE_|PAXPR07MB7998:EE_
x-ms-office365-filtering-correlation-id: 9aa0388c-0d72-44e5-de52-08dc6e6cc8ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?cExWQUMvSkR3WHVsS2lSY0VCenVSR2JSaFZndWtaWnZmK29yNUVjTVhldCt6?=
 =?utf-8?B?bUtqakZCaStpdDJieWVTN29qaEE2dEw0RExsNE9uYXFSeEtxNzBDMGFVbWlG?=
 =?utf-8?B?VW41U1E0RmZaYU43OHhtRFNzNFV3UzlGa0dOUm0zZ1FNOGprRk00bndBN01j?=
 =?utf-8?B?bklVb1NxbTNOaTcyc2tkUXR0L2d0bTl3NWJqQS9pYmNkYmF2VWJtcFZ3a1F5?=
 =?utf-8?B?SjYxc0tPTElEOUtFRzhMZm1vM0lqRDF3UTZ0eVhQTVVWM0lUZkJ0bklkaXBC?=
 =?utf-8?B?M0dkanpPejh5WmhnV0x2cTZOZXZqeFdYZUNTMFBaYXRxR2hmSVdvcFAzWVFn?=
 =?utf-8?B?QnFSL2JkRU9VMG1JWXllK2tLajZha3VVc2xWTWNIeHMwS3ljVkhoVUFQTEYv?=
 =?utf-8?B?V0w1YjlKdFdFREVIK3BiS2NrSVBLSHdIMkZUdXFCSmFONDc3dmE1WmdBNjFP?=
 =?utf-8?B?a1kwV0s2Y3QyK1NNQ3krdk50UEF0S3lCR25HWlFuZHRpeStMV0NmbEJDSWto?=
 =?utf-8?B?WlRHY1VDem5rR1lSdTBPa2NuMnNMa2R1LzFJMXlzNHc1ZXBvamZHOGVPNVU2?=
 =?utf-8?B?Qm82dkRvVFY1R29kTDlpSlZzcko4QmNraFlZdm9iRTFKTjJGQjF4THo1TmdO?=
 =?utf-8?B?Y3V1MVlQcUFRZVNsTk85ZmFYbVNMVm5hWWlSSWhyUVBRMmFEb1o3RUc3NkxZ?=
 =?utf-8?B?T0VQbkRJdW1lbVhRaVliWS8zVWhCYm1yMUNzVU9ieUZzQ3ZMUERKSm1iN1Fo?=
 =?utf-8?B?bmt6Zm92VWVzaTlESEhDUkJkb2NwZnhLN1lIV2JCNkFWeG84MTY5R1lCa05B?=
 =?utf-8?B?aUI0UExaUS9JYkhjUlU0THJwb1RMWXZpU2syZXJnY3FoVmU4bUsvTERsdXNt?=
 =?utf-8?B?eWc1QzZka28xRk4rM1BNaWFXbXAwUUxnWkpXOHg1eGVSVVl3V2ZiV2twMW1Z?=
 =?utf-8?B?WVZTWnVZcXVMY3dycUliZnNHUkxnZStpai9YQmFqWGUvUkRGbXJCdXVxdWNM?=
 =?utf-8?B?MXJPUFVpaHJsZ1N6b0wySGdKZzN0N1lVYjVKS25RTHRmM2ZPTVBrd0hUYzdR?=
 =?utf-8?B?c3VpZVVxZGdHU1BZODQxckJWSGFpcEJIaHZXUU53TFZjYi8xZ1paK3pRcmwy?=
 =?utf-8?B?UlQwUDdMVzF1NGFvVEdCK0RYb1VscmdiZGVxMXJuelppY1ZDVFBHWS9WYjFx?=
 =?utf-8?B?ckNIcHBvbklaRFZaSWJnaGdKVTlET0tOSDV5YXkwWVRuTWF6dTlXWnNCektx?=
 =?utf-8?B?RFNmNDVPRGRjL1kzb3hrZDJJekZXTVFWZHlhSk5uVVdCV0xRU2MzTTRJWHZZ?=
 =?utf-8?B?THNOUjlranJNdDlmYlhGVmc3am9jcjhkVEM2Z2s4UHhuMGFuaEYrRXpUSUwx?=
 =?utf-8?B?TEhPNndKbENWYThXQVV5dzZkcWJROVc4YXBJVVdHQzIwS0RORGREdVhOclVT?=
 =?utf-8?B?amxNTW5qcHRUdWhwUmxjdVlNdkRCRTlTYjdhRUVVdHBQejhTc0haWGdqbk1t?=
 =?utf-8?B?WVRmblVDaDNwanZoQkJSVlFkakF0TVY0VkxMblFCSnY0QUp3aXNMWUNqeEFr?=
 =?utf-8?B?R0s2eXlYVG90SE5LSU13SW5rb2RkMjZSRVFOdExIbTRWSlVYNlg3Wkg1WUc2?=
 =?utf-8?B?a0FjVFRjTTRXV3VyN3daUVIyRHFrU3g0N2w4WTdMMmdmd2kwdnpkSG5ROEF0?=
 =?utf-8?B?R2xTTHVtNHNHNUV4WEdLQzNTUC9SeWtROHh1VUVnTkFNbU10RTlVQS93PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR07MB8408.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFJGVXFZbFhRS0UweVdSd3RyV3kvOVNJMmcwQ1FKTjVmOFRrSVVzbHFya1kx?=
 =?utf-8?B?Zy9ocGxmOWZLM2FjM29TRU5JWWRQak9aMnFkbWxENzhaYXFyN2VvV2FEWUFk?=
 =?utf-8?B?Q01SK0hObm9UQnB3azFZUWlVUnROR1RpdDhIQnZtNm9EeFJvdGNJZzk2L3F6?=
 =?utf-8?B?ckFwYlMzaVI4cW1UZVpFdU85YVFMYWQ5V09hTktjN0trQzVCcFlMeHZ6eWxX?=
 =?utf-8?B?QXRpVmJjSDROdUtaVTJkVkJuT1JMcXlzaEF6VGIzbkJlZDFiWmpwcjZNaVVY?=
 =?utf-8?B?SWpRbVBSanJpUzF2dzJlaDJjOC9uc05UV3BGT0gxYU1KdGZrRkJGTU9Ea2lB?=
 =?utf-8?B?U3o3cHRoZldLdDdCcUhiUWNmc3ppakNnQmhXSUxURjVIUDB4NG8zbU5EYmF0?=
 =?utf-8?B?N25Xc0dwcjE2N1NaakFLREVBMVFDUlhYNndRb3lCQ1FuL1MvVjZiM0k2LzFR?=
 =?utf-8?B?VWgrWkd4dEFUM1ovTVNmN0Y2SjZwOUlranMzVXhIckh6NVFLdE42T1JmKzMz?=
 =?utf-8?B?ZnBSdDkzN25VcmdCMm1YVU0xRmdad3NodGZXdlJRbkpCMDQ1MWNmWEFENTZ6?=
 =?utf-8?B?ZDc5ZjdGWWZjOWYxUTFuYmhFUG53eGlsTVZtckFsdngySUtMV2N2OVArVm5i?=
 =?utf-8?B?cU11S3hrenlobmRScmJMd1pGODJHajlaR2d3bURkc05yYW1ZWkpNdzZsQitI?=
 =?utf-8?B?YjlucXNKZ2tYRHNYRFl2bHZnQy9tNTFPbSs4UEEvV0phZXMxZWRZU2tIaFVT?=
 =?utf-8?B?Kzc4aXhSVGlIZGpubTFDNVk3dWM3aE9nNmszcy9nVCtiQmR0clgzMlJucHQr?=
 =?utf-8?B?ZFpBN3hZajBmSitWaXhaTlcvRWlpOEtxMFNWRVZUQWVsWGNHMFB0SFdndW00?=
 =?utf-8?B?bnJJc0Y3Mk5GakJqT2lLdDdKOHNBM1l5QWdveW96T2NDMFA4dnRmZXN6V1dH?=
 =?utf-8?B?N1JSQStEV0lRVXo5SmlhTVlOK1NZYUV5UndpbDd2WUkwbi90UmJGQzhmTGVj?=
 =?utf-8?B?WUxSVnpXL3lwb1R5VG4wSjNyYTBBQUR4ZUZJTW9lQTlCcUw5L2RIZmp4dFA3?=
 =?utf-8?B?RXVtVS9kMEpRWStwZ1c1cnM3K29SbHcrWjhFZjkzUDMydC8ydUlVR1hnZDdS?=
 =?utf-8?B?Z2xHWjN5d3l2Mjh3d3M0aThDY1JnZlN6RUYxRDA0VkJ6MkhZV1h6VnVXM1o1?=
 =?utf-8?B?c0tGb2VMR3JFV0UrUzNjOGxqRUF1RkRJa0xNTGtaa0RLNFN0WFR5YUgzZTh4?=
 =?utf-8?B?VGFTa09sVTlQRjNTd0JpOGl3R0x5MG9wMVhzY1FWMmtjSTZpd0E3TnpEa0Ux?=
 =?utf-8?B?OUxSNlBlQ1h3bkJ1L0xxdHlLTm4xQUlITzk2Q1dRd1dyd1RvUFlsRFhNbjhz?=
 =?utf-8?B?RXQvMVMzNjhQTkt6UHB0ZXBhZ1hWNXdTWDFVUmMyUWVtaGdSOWd1RjZybzVn?=
 =?utf-8?B?ZVU3UjdhQXFXcGdFRngxQkZLaFNtQjRUMm9tZlBTNHRjaDYzc3J6RXd5NW92?=
 =?utf-8?B?bUQ3eUZZRkxOL0hURDEyZFpGZER3K3Y1bmVhYjdVdm51K1dTY2JwTjVSSmZ3?=
 =?utf-8?B?V2hwNHFTQmtIbjJadGJ4NDVubHhQZ25WL2JNVEEzNTBFM3FaQ1hpVjJpaUhy?=
 =?utf-8?B?dzgvV2RQbk81MlVtWUN5Q3IrU0Ftb2p6cXFTTWd5Tk9ySzkrL0liWlFvd0hD?=
 =?utf-8?B?dXR5VERMTXRlZmMreTQxb2pHZXIwN3ZPZ2NZbzJ4VVhWRzYvOGNTc3g5NUEz?=
 =?utf-8?B?S1JIbzJMOUhQTGw3enhvVUxLRWFIQUdQU0cwMktHZVpWaGplUStoTkp0WnNj?=
 =?utf-8?B?bXNLYXdWSHlBa2VJMzh1SlRRelNpemZSZzlBdTQyWTV0aGNDWTk2RGpVNlYy?=
 =?utf-8?B?UGVndDl2MVBJMVBGRE11OXZoRVZWTnZIbWl0MVdVcVZobzA3K3ZCVm9BOWU3?=
 =?utf-8?B?ZksxQm5SdHFmVDh3Ulhjc0dFdXVuOG1NQ25aM0hsNFZCNExqdlJHNVNEb0ZW?=
 =?utf-8?B?VEpxWmQydnNReFFDSVZPTGluSW45Vng4UmtEOEhnd3F1UjQwZndZS3pkR2hk?=
 =?utf-8?B?TThBcnYxNjlhT29sNDVMSXFtSktzMk1wczFIalF6Q0RaOFM3SUlvbGpyTCsr?=
 =?utf-8?B?UGpxbEc1bXh3VHhSRFdib1JubXMwbFdEa0RVdkYzTEtKVVh5UkQwNTBTU1ov?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7BFC519E2A89B429932CD0FF2F0E792@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: phd.unipi.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR07MB8408.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa0388c-0d72-44e5-de52-08dc6e6cc8ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 08:07:47.4382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c7456b31-a220-47f5-be52-473828670aa1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jLa/x+gzzxkFvXSIpYUgJTiPu7EHkVD6U6q02COExgJfwEPhrpHLQaobJDTYR4vVE7QIqL0B01Igm51coqW2qZBiHkdKQHchL+r5cMDVjOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7998

KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioNCldTQ0MgMjAyNDogRXVy
by1QYXIgMjAyNCBJbnRlcm5hdGlvbmFsIFdvcmtzaG9wIG9uIFNjYWxhYmxlIENvbXB1dGUgQ29u
dGludXVtDQpEYXRlOiAyNi0yNyBBdWd1c3QgMjAyNA0KTG9jYXRpb246IE1hZHJpZCwgU3BhaW4N
CldvcmtzaG9wIHdlYiBwYWdlOiBodHRwczovL3dzY2MuZGkudW5pcGkuaXQvDQpFdXJvLVBhciB3
ZWIgcGFnZTogaHR0cHM6Ly8yMDI0LmV1cm8tcGFyLm9yZy8NCioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqDQoNCiogQ2FsbCBmb3IgUGFwZXJzDQpUaGUg4oCcQ29tcHV0
ZSBDb250aW51dW3igJ0gcGFyYWRpZ20gcHJvbWlzZXMgdG8gbWFuYWdlIHRoZSBoZXRlcm9nZW5l
aXR5IGFuZCBkeW5hbWlzbSBvZiB3aWRlc3ByZWFkIGNvbXB1dGluZyByZXNvdXJjZXMsIGFpbWlu
ZyB0byBzaW1wbGlmeSB0aGUgZXhlY3V0aW9uIG9mIGRpc3RyaWJ1dGVkIGFwcGxpY2F0aW9ucyBp
bXByb3ZpbmcgZGF0YSBsb2NhbGl0eSwgcGVyZm9ybWFuY2UsIGF2YWlsYWJpbGl0eSwgYWRhcHRh
YmlsaXR5LCBlbmVyZ3kgbWFuYWdlbWVudCBhcyB3ZWxsIGFzIG90aGVyIG5vbi1mdW5jdGlvbmFs
IGZlYXR1cmVzLiBUaGlzIGlzIG1hZGUgcG9zc2libGUgYnkgb3ZlcmNvbWluZyByZXNvdXJjZSBm
cmFnbWVudGF0aW9uIGFuZCBzZWdyZWdhdGlvbiBpbiB0aWVycywgZW5hYmxpbmcgYXBwbGljYXRp
b25zIHRvIGJlIHNlYW1sZXNzbHkgZXhlY3V0ZWQgYW5kIHJlbG9jYXRlZCBhbG9uZyBhIGNvbnRp
bnV1bSBvZiByZXNvdXJjZXMgc3Bhbm5pbmcgZnJvbSB0aGUgZWRnZSB0byB0aGUgY2xvdWQuIEJl
c2lkZXMgY29uc29saWRhdGVkIHZlcnRpY2FsIGFuZCBob3Jpem9udGFsIHNjYWxpbmcgcGF0dGVy
bnMsIHRoaXMgcGFyYWRpZ20gYWxzbyBvZmZlcnMgbW9yZSBkZXRhaWxlZCBhZGFwdGF0aW9uIGFj
dGlvbnMgdGhhdCBzdHJpY3RseSBkZXBlbmQgb24gdGhlIHNwZWNpZmljIGluZnJhc3RydWN0dXJl
IGNvbXBvbmVudHMgKGUuZy4sIHRvIHJlZHVjZSBlbmVyZ3kgY29uc3VtcHRpb24sIG9yIHRvIGV4
cGxvaXQgc3BlY2lmaWMgaGFyZHdhcmUgc3VjaCBhcyBHUFVzIGFuZCBGUEdBcykuIFRoaXMgZW5h
YmxlcyB0aGUgZW5oYW5jZW1lbnQgb2YgbGF0ZW5jeS1zZW5zaXRpdmUgYXBwbGljYXRpb25zLCB0
aGUgcmVkdWN0aW9uIG9mIG5ldHdvcmsgYmFuZHdpZHRoIGNvbnN1bXB0aW9uLCB0aGUgaW1wcm92
ZW1lbnQgb2YgcHJpdmFjeSBwcm90ZWN0aW9uLCBhbmQgdGhlIGRldmVsb3BtZW50IG9mIG5vdmVs
IHNlcnZpY2VzIGFpbWVkIGF0IGltcHJvdmluZyBsaXZpbmcsIGhlYWx0aCwgc2FmZXR5LCBhbmQg
bW9iaWxpdHkuIEFsbCBvZiB0aGlzIHNob3VsZCBiZSBhY2hpZXZhYmxlIGJ5IGFwcGxpY2F0aW9u
IGRldmVsb3BlcnMgd2l0aG91dCBoYXZpbmcgdG8gd29ycnkgYWJvdXQgaG93IGFuZCB3aGVyZSB0
aGUgZGV2ZWxvcGVkIGNvbXBvbmVudHMgd2lsbCBiZSBleGVjdXRlZC4gVGhlcmVmb3JlLCB0byB1
bmxlYXNoIHRoZSB0cnVlIHBvdGVudGlhbCBvZmZlcmVkIGJ5IHRoZSBDb21wdXRlIENvbnRpbnV1
bSwgcHJvYWN0aXZlLCBhdXRvbm9tb3VzLCBhbmQgaW5mcmFzdHJ1Y3R1cmUtYXdhcmUgbWFuYWdl
bWVudCBpcyBkZXNpcmFibGUsIGlmIG5vdCBtYW5kYXRvcnksIGNhbGxpbmcgZm9yIG5vdmVsIGlu
dGVyZGlzY2lwbGluYXJ5IGFwcHJvYWNoZXMgdGhhdCBleHBsb2l0IG9wdGltaXphdGlvbiB0aGVv
cnksIGNvbnRyb2wgdGhlb3J5LCBtYWNoaW5lIGxlYXJuaW5nLCBhbmQgYXJ0aWZpY2lhbCBpbnRl
bGxpZ2VuY2UgbWV0aG9kcy4NCg0KSW4gdGhpcyBsYW5kc2NhcGUsIHRoZSB3b3Jrc2hvcCBpcyB3
aWxsaW5nIHRvIGF0dHJhY3QgY29udHJpYnV0aW9ucyBpbiB0aGUgYXJlYSBvZiBkaXN0cmlidXRl
ZCBzeXN0ZW1zIHdpdGggcGFydGljdWxhciBlbXBoYXNpcyBvbiBzdXBwb3J0IGZvciBnZW9ncmFw
aGljYWxseSBkaXN0cmlidXRlZCBwbGF0Zm9ybXMgYW5kIGF1dG9ub21pYyBmZWF0dXJlcyB0byBk
ZWFsIHdpdGggdmFyaWFibGUgd29ya2xvYWRzIGFuZCBlbnZpcm9ubWVudGFsIGV2ZW50cywgYW5k
IHRha2UgdGhlIGJlc3Qgb2YgaGV0ZXJvZ2VuZW91cyBhbmQgZGlzdHJpYnV0ZWQgaW5mcmFzdHJ1
Y3R1cmVzLiBBIHBhcnRpYWwgbGlzdCBvZiBpbnRlcmVzdGluZyB0b3BpY3Mgb2YgdGhpcyB3b3Jr
c2hvcCBpcyB0aGUgZm9sbG93aW5nOg0KDQotIFNjYWxhYmxlIGFyY2hpdGVjdHVyZXMgYW5kIHN5
c3RlbXMgZm9yIENvbXB1dGUgQ29udGludXVtDQotIFN5c3RlbSBzb2Z0d2FyZSBmb3IgY2xvdWQt
ZWRnZS1Jb1Qgb3JjaGVzdHJhdGlvbg0KLSBEaXN0cmlidXRlZCBhbmQgZGVjZW50cmFsaXplZCBt
YW5hZ2VtZW50IG9mIHJlc291cmNlcyBhbmQgYXBwbGljYXRpb24gZGVwbG95bWVudCBpbiB0aGUg
Q29tcHV0ZSBDb250aW51dW0NCi0gUHJvZ3JhbW1pbmcgbW9kZWxzLCBsYW5ndWFnZXMgYW5kIHBh
dHRlcm5zIGZvciB0aGUgQ29tcHV0ZSBDb250aW51dW0NCi0gQ29tcHV0ZSBDb250aW51dW0gcGVy
Zm9ybWFuY2UgbW9kZWxpbmcgYW5kIGFuYWx5c2lzDQotIEZ1bmN0aW9uLWFzLWEtU2VydmljZSBh
bmQgQmFja2VuZC1hcy1hLVNlcnZpY2UgaW4gdGhlIENvbXB1dGUgQ29udGludXVtDQotIEVuZXJn
eS1lZmZpY2llbnQgc29sdXRpb25zIGZvciBzdXN0YWluYWJsZSBDb21wdXRlIENvbnRpbnV1bQ0K
LSBBSSBpbiBhbmQgZm9yIHRoZSBDb21wdXRlIENvbnRpbnV1bQ0KLSBTY2FsYWJsZSBhcHBsaWNh
dGlvbnMgZm9yIENvbXB1dGUgQ29udGludXVtIChJb1QsIG1pY3Jvc2VydmljZXMsIHNlcnZlcmxl
c3MpDQotIERhdGEtaW50ZW5zaXZlIGFuZCBzdHJlYW0gcHJvY2Vzc2luZyBzeXN0ZW1zIGFuZCBh
cHBsaWNhdGlvbnMgaW4gdGhlIENvbXB1dGUgQ29udGludXVtDQotIERpZ2l0YWwgVHdpbnMgYW5k
IGluZHVzdHJ5IGFwcGxpY2F0aW9ucyBpbiB0aGUgQ29tcHV0ZSBDb250aW51dW0NCi0gUHJvdG90
eXBlcyBhbmQgcmVhbC1saWZlIGV4cGVyaW1lbnRzIGludm9sdmluZyBDb21wdXRlIENvbnRpbnV1
bQ0KLSBCZW5jaG1hcmtzIGFuZCBleHBlcmltZW50YWwgcGxhdGZvcm1zIGZvciByZXByb2R1Y2li
bGUgZXhwZXJpbWVudHMgaW4gdGhlIENvbXB1dGUgQ29udGludXVtDQoNCiogU3VibWlzc2lvbiBJ
bnN0cnVjdGlvbnMNClRoZSBwYXBlcnMgc2hvdWxkIGJlIGZvcm1hdHRlZCBhY2NvcmRpbmcgdG8g
dGhlIExOQ1MgZ3VpZGVsaW5lcy4gVGhleSBzaG91bGQgYmUgYmV0d2VlbiBhIG1pbmltdW0gb2Yg
MTAgYW5kIG1heGltdW0gb2YgMTIgcGFnZXMuDQoNCiogU3BlY2lhbCBJc3N1ZQ0KU2VsZWN0ZWQg
cGFwZXJzIHdpbGwgYmUgaW52aXRlZCB0byBzdWJtaXQgYW4gZXh0ZW5kZWQgdmVyc2lvbiB0byBh
IEpvdXJuYWwgU3BlY2lhbCBJc3N1ZS4gV2UgYXJlIGluIGNvbnRhY3QgdG8gcHJvcG9zZSBhIFNw
ZWNpYWwgSXNzdWUgaW4gYSBoaWdoLXF1YWxpdHkgam91cm5hbC4gSW5mb3JtYXRpb24gd2lsbCBh
cHBlYXIgc29vbiBvbiB0aGUgV1NDQyB3ZWIgc2l0ZS4NCg0KKiBJbXBvcnRhbnQgRGF0ZXMNCiAg
TWF5IDIwdGgsIDIwMjQgICAgICAgUGFwZXIgc3VibWlzc2lvbiBkZWFkbGluZSAoRXh0ZW5kZWQp
DQogIEp1bmUgMjB0aCwgMjAyNCAgICBQYXBlciBhY2NlcHRhbmNlIG5vdGlmaWNhdGlvbnMNCiAg
SnVseSAxc3QsIDIwMjQgICAgICAgQ2FtZXJhLXJlYWR5IGR1ZQ0KDQoqIFdvcmtzaG9wIENvLUNo
YWlycw0KLSBWYWxlcmlhIENhcmRlbGxpbmksIFVuaXZlcnNpdHkgb2YgUm9tZSBUb3IgVmVyZ2F0
YSwgSXRhbHkNCi0gUGF0cml6aW8gRGF6emksICAgICBVbml2ZXJzaXR5IG9mIFBpc2EsIEl0YWx5
DQotIEdhYnJpZWxlIE1lbmNhZ2xpLCAgVW5pdmVyc2l0eSBvZiBQaXNhLCBJdGFseQ0KLSBNYXR0
ZW8gTmFyZGVsbGksICAgIEJhbmsgb2YgSXRhbHksIEl0YWx5DQotIE1hc3NpbW8gVG9ycXVhdGks
ICAgVW5pdmVyc2l0eSBvZiBQaXNhLCBJdGFseQ0KDQpMb29raW5nIGZvcndhcmQgdG8gcmVjZWl2
aW5nIHlvdXIgZXhjZWxsZW50IHN1Ym1pc3Npb25zIHNvb24uDQoNCkJlc3QgcmVnYXJkcywNCg0K
VmFsZXJpYSBDYXJkZWxsaW5pLCBQYXRyaXppbyBEYXp6aSwgR2FicmllbGUgTWVuY2FnbGksIE1h
dHRlbyBOYXJkZWxsaSwgYW5kIE1hc3NpbW8gVG9ycXVhdGkNCg0KDQoNCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KQWxiZXJ0byBPdHRpbW8NClBoRCBTdHVkZW50DQpEZXBh
cnRtZW50IG9mIENvbXB1dGVyIFNjaWVuY2UNClVuaXZlcnNpdHkgb2YgUGlzYSwgSXRhbHkNCkUt
bWFpbDogYWxiZXJ0by5vdHRpbW9AcGhkLnVuaXBpLml0DQo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0=
