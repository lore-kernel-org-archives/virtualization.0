Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7559715AAC6
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Apr 2024 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960538; cv=fail; b=WZkd8JmqRBvKO3oMggZT+sLGr0RAnuaVAhJzn8MnhY2ndBp8MnpHJFCmjtlbjflD6OrPvIMdxXX3ixP1ugqgp3TkNKgsEh07Ce1qHUoYivu3JiP0K/FBJ69Dkmj0lcYdkq1hPDTTpZPFxWU0NwCne6k1BfPYHtDR9oYsIjTpb8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960538; c=relaxed/simple;
	bh=/LbQY8T1IqnB28yWxXThEUouDV7cW54hh3moMAUnnZQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=g4NbzzRim/Qm6fOSS5B4GIKiqEQOTNyx/nnWIXOR260YJLSXBi7oawEbPl2k1dblzcl3zn2dx+ILQucd6WhinO1i0rIhK5a45rDpAfelaP/xyGvB0Yry3T1YMSUZLkAY9Ol3Eas3b7havIawFRBt8pEoiRox5tjlYyXmCDzGNB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=phd.unipi.it header.i=@phd.unipi.it header.b=kxhdNv/K; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phd.unipi.it header.i=@phd.unipi.it header.b="kxhdNv/K"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9769607C2
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Apr 2024 12:08:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.002
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F2lMvcndv0Ti for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Apr 2024 12:08:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f400:fe1e::711; helo=eur01-he1-obe.outbound.protection.outlook.com; envelope-from=alberto.ottimo@phd.unipi.it; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9F6D760664
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=phd.unipi.it
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F6D760664
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=phd.unipi.it header.i=@phd.unipi.it header.a=rsa-sha256 header.s=selector1 header.b=kxhdNv/K
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0711.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::711])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9F6D760664
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Apr 2024 12:08:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+b2sOyv2BEm+kUXuqKRjMZiH1MtXPo6L+h2BtBEi2Fb02MDYfv2J+LDxMWjLScUpoGmRCwwFz+kEHegkQWSm1K0u09qGJeZIoFCOSFZWcmfgCw0gQfLhz3X3ZTCRjz6IMHCWe5X5ZDnrlFwjVicdPbhS2POCungcCH0YzvPeysgfJLYZY/zuER8DHTZ6EmObU+IZGDi6Joz8kbo2QxDYkiPrgqEML2Cl18qN08iNar2e90a80FjOZUiJAoE1/afc7DtOXa2TA3yw2jrCkGr3rAVBLPdIc/pOUH72h/NlduBhbm/ER0mZBGid21KF9QuUcmX3PN5/r0qgrmZ82Y8jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LbQY8T1IqnB28yWxXThEUouDV7cW54hh3moMAUnnZQ=;
 b=l38gomHsP2zUvJgbUskP2DHdLSGgiZuwdlWSpm1JZ0D/piT1ytKiV3+jDAnTmYQZ5tsD2Cx1oouSHptQfnCjASDqqUpVJuJmQVt+qiBeKkk7EOu4JhArUM9FXse7lin4XJVxVJ9Kk0HoCPq07EPAUTqN3ImfcGeWKBGbWlCiW6Y428NJfVr7F6aRMzW/vzPetbotC+7ZPbdG4NsCyWVsDwx40lNCYcE/ZsrWdaqM67qKKc10KT6sAn67Tb9RjGED2epfMa2UkyI3IIeVx5pHZ+85clksIoZ05PwoLr8JbsMeU3Z6QMfKFAuATgrEiYp5v0n4lK6vUHK2mCiRUNIlAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phd.unipi.it; dmarc=pass action=none header.from=phd.unipi.it;
 dkim=pass header.d=phd.unipi.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phd.unipi.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LbQY8T1IqnB28yWxXThEUouDV7cW54hh3moMAUnnZQ=;
 b=kxhdNv/KBPrLdswWPa8wX0SUMoSYrdyEGAla9BQEnx/qutCdPc/r4dawnL0LjhJNuFQrT3AkNFz0sIe/QFyqIdGi9wLtJE3Ml4U5Ve9jb6UrdpGU0fOFJj+GbfgDnCT0gVuXfjZqunB2SEFdTHc/qeVk4GZsNKhCb+DNFrV6URI=
Received: from AS1PR07MB8408.eurprd07.prod.outlook.com (2603:10a6:20b:4c4::17)
 by AS4PR07MB8508.eurprd07.prod.outlook.com (2603:10a6:20b:4e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 12:08:47 +0000
Received: from AS1PR07MB8408.eurprd07.prod.outlook.com
 ([fe80::1a84:daa4:7969:dd41]) by AS1PR07MB8408.eurprd07.prod.outlook.com
 ([fe80::1a84:daa4:7969:dd41%5]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 12:08:47 +0000
From: Alberto Ottimo <alberto.ottimo@phd.unipi.it>
To: "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>
Subject: [CFP] WSCC 2024: Euro-Par 2024 International Workshop on Scalable
 Compute Continuum
Thread-Topic: [CFP] WSCC 2024: Euro-Par 2024 International Workshop on
 Scalable Compute Continuum
Thread-Index: AQHalkApqhdQpeekUEeBe493zTgQrA==
Date: Wed, 24 Apr 2024 12:08:47 +0000
Message-ID: <B4D86ED0-84FF-461B-8572-B27EBE762036@studenti.unipi.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phd.unipi.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR07MB8408:EE_|AS4PR07MB8508:EE_
x-ms-office365-filtering-correlation-id: 2f47e950-4c99-46e2-3161-08dc64574bf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVVrMHpyVkVaaTdpWm1nYmllVVlxa2ZxVzRvVzdxZW11eDJhQ2pxejhKdEZO?=
 =?utf-8?B?MTRCdisrcGR0V0xLVTR5UXpsMFJSMStvREYxdkdxblVoRkUvVklQZW5ZbUVV?=
 =?utf-8?B?N25XSm0zWmVRd2hBSEtBcGNLZHVhbFBMTWQ4bHFiRFJJV1puTVlFa0dIWEZ4?=
 =?utf-8?B?Y05nc2xlaEdPVHRxcG9HWEdJVWNPMDZnUXFhclJibnB3dzk0bmtUMTVyU01n?=
 =?utf-8?B?RGFoUmdIa2ZUejd2QkV6Q0NSSGVHbWRQTUlJNndwczZWcUs2UnFmd2V2Z2Jk?=
 =?utf-8?B?MmhrcXZWckQzM3Q0OFNUSDErWjNOWWVKOXFvS3N3RUc0UkRvK0s1MUFVNVdT?=
 =?utf-8?B?elhGYXluay9hTkFSQU1mek55V0VJS05GY1QvVTdpZittVVdzSzBDOTJjVFFa?=
 =?utf-8?B?b0FjT1RwM0JXSWpyTDFaYU95UUhMWk4rSHU4L1ZvaExLNUYySHNnSFBsN0Qv?=
 =?utf-8?B?aTQ0S013ajhGQnNiU25aejl0Y0xTRGRRVjVLZmFnQXN2dHhCa0hMUDNLV3Fz?=
 =?utf-8?B?eGxSMlNNWFlWYkZRekdjcGFOOHRZUWJ1MEtvajI1SnBkSjRlcUE1YVhralpL?=
 =?utf-8?B?WmVENVFhQnY4Qm5mWTZDam54ZGtmdFpSTm9JZWdwUnpjYVJhTXpjUHdOS1dy?=
 =?utf-8?B?T3dGaVF1MUF6OUErSmxpRktnL2MrK1ljZG1HbnJYbk1oQ0xMQ1ZiKzZQNFg1?=
 =?utf-8?B?RUZjRjZNYWVNRTFyNUwySTFiSTNFVFVDd1Q3aHNLMEFYSFp5aXRBQlJaSG8z?=
 =?utf-8?B?UkxzZnRabFpXaVovNGpTTDF6emxOd2tRZ1VsV0pxV29uMWlIekJnMkRaS3J5?=
 =?utf-8?B?bDU5alJaNTNmMTlKU0pFZTQvcWp1S1FmcW5TSXJyMWlrQzExYTR4d0JKRG1w?=
 =?utf-8?B?eGpmVHNCL0ZodDMwRjVkSnU5REw1VDFNQUtnZU9ka0M5d1JjbkxTZjVkRlU2?=
 =?utf-8?B?SHg1eFdhdkl0bEcwbUJLZDNFZVQ3dWF0aTZBbDVXaVRUTGR1OUoybTlEMzRO?=
 =?utf-8?B?dTZGVXNzNVFZR2t5bDE3ZzdFK2tWWlFBdngraTRkc3BmRHlISGduZ254YThl?=
 =?utf-8?B?ZTBrVDB0YURnYlJFT29Kcng4T05GV25SVm1ObFJuRE5MVEFRWFdFdFNYay9P?=
 =?utf-8?B?K3ZoTkFxT21OMmRtZnlyOE0vcnBKZ3pVdisxQUJkWnl0RkRhTjZNOHEyQXRj?=
 =?utf-8?B?TjFLRGlqVXJubWlJMWczcHpLQzFBT0lJRFgzOGZlK0xXUlNJWkJrQURjV3hv?=
 =?utf-8?B?YTBLck93aEN4bkhXS0ZWU0NNS1lMWVljYUJEMlJuTGx6QmVIZUcrdDUvOW51?=
 =?utf-8?B?MmVyK2Z3MlBsK2ZwWVozRHluR1VybTlaR1dWWjZMRlFsOXRrblZIdjJwdHlm?=
 =?utf-8?B?VFhpSzZ3ZFE0MWptTlRQU0JHUVNOQ2pJVkJ0L0ZvSzlUNjNhdDc2MERBZkhT?=
 =?utf-8?B?SktUL3VPN1VsWC8yNzBBbFdxd0lYQ1k4VUppWnNvTi9YVU91blVtR0pZN2xt?=
 =?utf-8?B?VlQvWVZtcEdBNFA4QTF5Y1BjQnc0QU83MG5vTElENFhScFp6RTRqU09jWVdW?=
 =?utf-8?B?d3lJME5DKzZndVd4UEVxakZsL3Zzd1l1ZEtwTWd5dmQ4NVhBVW5NTExSSjRs?=
 =?utf-8?B?cTNDTXNtSGZqclAwcjRJbzUrd0N0T3dYVmRuVU1ObnZacW14R3RvMU9MVHNs?=
 =?utf-8?B?dEl1WFVybk4yMWIrNHJ3cTJ3L2Q4M05hQ3VUY3RXSFF3SDFHWTJEajBnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR07MB8408.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFpBaWExKzBZL3pzMkZ3ajFqSUZ1RmdPT2FNaElxYUR3Mk81Y2NuMjNBS2xN?=
 =?utf-8?B?UHVJSGVpekxWWXNuSkFzMVJwUDBpaFpHeHJPMytYaGpOWlBWclVPK1FNRXlE?=
 =?utf-8?B?V3BBZHZhTnpwMzlJYjhWTWQ4MHo1L3l0UXhxc0hMOGI0QStNa0ZiMnR5R0dh?=
 =?utf-8?B?WGtHNmdHRFJlQXR2OEtSN3psdzRhcjg1TjZ6dmZPY0w4RDhqZ250WUxRb2tY?=
 =?utf-8?B?bmpQZVh6SEhaRW1qNHNMT01KbjhhcW16dkV6WGZQaEJTVzBSNmlCOTVsTXJh?=
 =?utf-8?B?TUZNNW54R1RwanRTSmYwNUs1ajAzWjVpazNGUW0vL2pKOUtTYTZNWEMyNGhv?=
 =?utf-8?B?dkMzajBEUVFQKy9IaE82eDdicVp6NE5ZMTBDQUtZbDZxQ2VnSmRob3phakNT?=
 =?utf-8?B?NEdwTGR5NWFYaldkMTkyQlY4VDdhcE1Ecld5TENPNnpMVXBKNmQ0aE9hQ2g3?=
 =?utf-8?B?SG9MdmRaSXlscXJzR0tFd3pIY0IyMjFJQ0hyUWdvekRkbXhxVVozeXNEWVFT?=
 =?utf-8?B?andQZ01qV253UnFoN2JEZ3RtMzFndFNVOEs1MzdUY3dDcms1VS9nWlU2ZkND?=
 =?utf-8?B?TmZVRHE2Y0pKMGhyY3FpV3AwL1ROVkhqV2RkMWhJMUt5dFBvbGRSR2pORlU1?=
 =?utf-8?B?VkV3Q0V2YTFzQjdqajhtbk5QbDMyTHJlV1RxSUFIb2JqU0o0bXd4d08zdDJK?=
 =?utf-8?B?QWxhK0Z4dkNzWHd6eFNISlA1VDZRQ3pLSWZnM3p6T3VBb0RVRG9PR0hsbCtS?=
 =?utf-8?B?aTdXcklJZURxeVFNZnhDWnFtQjJRdVZRY1dlVGNxdFc5Vi9IUUpKYTZ4bmZ2?=
 =?utf-8?B?clNPNVRUNmpjbm5qbjN0ZWM3QTZNY1g3ZVg2cUJFT3ZFSElObzBuTFVRNWEv?=
 =?utf-8?B?ZlIwWnFrYzZKVzNkSzJrRVorcDliL2o2NWlocXoydDdXazZ0M3h4ZXpYUVZa?=
 =?utf-8?B?Y1k1WTNSS0xuV2E0V3hsYmhpSkNlUFJoZm5zQVFhZzBJU1gzUm9hYXc5OTVT?=
 =?utf-8?B?MVFnRWk3c25UVXBXVXdzTHdsS200OVpPeGxHK0FHSWZXRzJ2QUFCSXBMNmdw?=
 =?utf-8?B?QUtZQjdZOXRDWHJ4LzBkeWtUN1FRbTJRcEdGcTJnb2lsb2tsb21GV1M1eTU1?=
 =?utf-8?B?QlRHVlZ2cTJUYkFvQXloYTJjTFBaTC94QVFZU1ZEVWRZYno4VnRqdTQ5R25y?=
 =?utf-8?B?ZU5oeDBPOTUvNFR1SGFzWTkxdTBVemcrcFhWYS9DMkVscHBaZENYaWpCY0xI?=
 =?utf-8?B?M0kwSFVBd1N0eHd2THBzTXdZbndaSzVLdklUTUFDR3F0cGpydHFKM2EvcW8v?=
 =?utf-8?B?U01FWXV6QnczbXJTdi9QVTJYejQwOEg3Y3EyQ21TSEdhZXVBRXdSa3M1dlJn?=
 =?utf-8?B?ZVZpZ1daR3NLK3VLeEZuaGlnYlpmc3N1b0NmYVk4SzFtRzhka2toMG0xWWtr?=
 =?utf-8?B?cjlndmNsQ081TE5OWnNBSnArek01N2d5MHBRcXhsZDMxeTIyQ1RrMDlHbytV?=
 =?utf-8?B?NXJlUm5xcndMa3VaZzFiQWhLeSt0Wlg4L05MQ0Z1ZDc5bGYxcEtGeG9NTGdp?=
 =?utf-8?B?c0ljaUIzRzY2UXZEekpReDBnTzJHMWc0ZkFzUmlzd3J3ekhlMTBDQnpIbjVP?=
 =?utf-8?B?YUhyb2c1VFZVV1dwaHFvVFlDd2NmSmF1UWtETkpmdlFxL1Nqc3EyU0JnZk10?=
 =?utf-8?B?UmxxaU9nNCt3bG0vTTgzU2FnZnQ0Q3p5dTUyZGpVUHRyQzhWWTFIcEdVRTBk?=
 =?utf-8?B?YlRkditnbmMxaWdWemZmNmx2QjJwK0Y3NXcrWkV0cDdHUStXZHNOSDFqclVB?=
 =?utf-8?B?SVcxOWgyQnRWU0pIeUJQUEVqNVN4SzR5cnUzMkJoblA0RUp0aGNKQ1JhNDhE?=
 =?utf-8?B?dk5ablV4RnU2QzZmK3c2WUhFQjI5ZnBLUFVUK1kyaTVXbksvY2N2Nkg4M0tY?=
 =?utf-8?B?MEExYVN5ZDBKU0gzWVh3Sm16V1dtWmxXaGN4WXlpejRNUWpodUw0Sy9mQm9j?=
 =?utf-8?B?SWxTTVZhZXU1MkcyM0xRbit4N09STHBXSTNvdVJ2alFkR2FPb2t4alJHUnV6?=
 =?utf-8?B?bXg2d2owaXIwRjZsMkdMVGh1SE9MRFIrdlJhb212MXdQZFZSMUJnak5FRmph?=
 =?utf-8?B?T0U0TGZmQjhVL2Q2UlplZ3p3aHhiTlRqSWhCZHNqNEhUT3VGSVNoNHlnOCti?=
 =?utf-8?Q?pZXOmEsZ69791FpkWmHKiCw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA72B97DF5FFAF4DADD1759071E5BB3A@eurprd07.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f47e950-4c99-46e2-3161-08dc64574bf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 12:08:47.8554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c7456b31-a220-47f5-be52-473828670aa1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sWCD7LwUJpxuvDaM2poDGwm+hx1rKFs4kD7nVbr3dXUBAFlWkTCeEzG57W2qVM/1aa8zFgr36JWw8F7TkBGRIKEwuZjWIwvNlcNipcjssvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8508

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
TWF5IDZ0aCwgMjAyNCAgICAgICBQYXBlciBzdWJtaXNzaW9uIGRlYWRsaW5lDQogIEp1bmUgMTd0
aCwgMjAyNCAgICBQYXBlciBhY2NlcHRhbmNlIG5vdGlmaWNhdGlvbnMNCiAgSnVseSAxc3QsIDIw
MjQgICAgICAgQ2FtZXJhLXJlYWR5IGR1ZQ0KDQoqIFdvcmtzaG9wIENvLUNoYWlycw0KLSBWYWxl
cmlhIENhcmRlbGxpbmksIFVuaXZlcnNpdHkgb2YgUm9tZSBUb3IgVmVyZ2F0YSwgSXRhbHkNCi0g
UGF0cml6aW8gRGF6emksICAgICBVbml2ZXJzaXR5IG9mIFBpc2EsIEl0YWx5DQotIEdhYnJpZWxl
IE1lbmNhZ2xpLCAgVW5pdmVyc2l0eSBvZiBQaXNhLCBJdGFseQ0KLSBNYXR0ZW8gTmFyZGVsbGks
ICAgIEJhbmsgb2YgSXRhbHksIEl0YWx5DQotIE1hc3NpbW8gVG9ycXVhdGksICAgVW5pdmVyc2l0
eSBvZiBQaXNhLCBJdGFseQ0KDQpMb29raW5nIGZvcndhcmQgdG8gcmVjZWl2aW5nIHlvdXIgZXhj
ZWxsZW50IHN1Ym1pc3Npb25zIHNvb24uDQoNCkJlc3QgcmVnYXJkcywNCg0KVmFsZXJpYSBDYXJk
ZWxsaW5pLCBQYXRyaXppbyBEYXp6aSwgR2FicmllbGUgTWVuY2FnbGksIE1hdHRlbyBOYXJkZWxs
aSwgYW5kIE1hc3NpbW8gVG9ycXVhdGkNCg0KDQoNCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQ0KQWxiZXJ0byBPdHRpbW8NClBoRCBTdHVkZW50DQpEZXBhcnRtZW50IG9mIENv
bXB1dGVyIFNjaWVuY2UNClVuaXZlcnNpdHkgb2YgUGlzYSwgSXRhbHkNCkUtbWFpbDogYWxiZXJ0
by5vdHRpbW9AcGhkLnVuaXBpLml0DQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0=
