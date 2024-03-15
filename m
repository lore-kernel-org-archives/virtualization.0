Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6105419474
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Mar 2024 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710498796; cv=fail; b=TdB5NqhR69h4kEFDrfzUf5a3POyVLFz7bCw20LTyNd7ylEGB0+mwg5UtgrxQdUWuIPbH5/5YfR1p0MEZJUFiFuEVZpoPDRToIhoGv/FoBv64En7PIgJ9d+6DAbDT9XA4uEsvktUgoSfRX88sSMz5vrcFyogK9qt7AgGxEVeqBBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710498796; c=relaxed/simple;
	bh=/LbQY8T1IqnB28yWxXThEUouDV7cW54hh3moMAUnnZQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NYGT14Bp80u0hg/uM6tg0854X2HR3fyRgdr9dY8MCPQDzKJSa40nbbdjtENfzuHjufNgp2FwUW4hMhxB7MGlH92KMRVwSSoSupyhBMc7IkSa6oBdG354zL9JHMB//v53hF2wMeCxXt6VrfQaOIai2liTT/mp4Uwf9OIO+9KQqvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=phd.unipi.it header.i=@phd.unipi.it header.b=UIW+rP/M; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phd.unipi.it header.i=@phd.unipi.it header.b="UIW+rP/M"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5E1C60592
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Mar 2024 10:33:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.002
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PHtyNFKNjWag
	for <virtualization@lists.linux-foundation.org>;
	Fri, 15 Mar 2024 10:33:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f400:fe0c::703; helo=eur04-db3-obe.outbound.protection.outlook.com; envelope-from=alberto.ottimo@phd.unipi.it; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7749160E53
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=phd.unipi.it
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7749160E53
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=phd.unipi.it header.i=@phd.unipi.it header.a=rsa-sha256 header.s=selector1 header.b=UIW+rP/M
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on0703.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::703])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7749160E53
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Mar 2024 10:33:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUt6q8gAYSs1LlP78PGprMm/+MZsxkbIEYPuzAcGnYVFP76kAoTJwob+umE2wJcJSMGtiZIUK6MkSdeywSXxQDneuWfAwxP07PmN+zY4qH3axTiW+i3V0F02Nniu6VMw2RQkmBpiwlLuPaZRVBWbnhjhaOp2ofFJHQtRmAQwovZJ0s8P4iomXbV5w9YZBWRf0+PnCKIq0SfHfZEi+Sx1c7/mYJXxA++LhUBB2t/Yr8sKxYBxQ0cqsE80Bl0ffnuMnYDq2x9+xHyOhVOHSiH0GrCl9ulrRayciBt+rTBM2zNpQPQF8ioSC/UgrmRNnxwhoECabq91orsHn4zcl0/HFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LbQY8T1IqnB28yWxXThEUouDV7cW54hh3moMAUnnZQ=;
 b=TRV6um/4ORQwIckyAkV70KbeeDQcGTZRMxtSkQSJwi/F1dWG20eXI3fb6VHo1uAQEwgMts+3F4se6X34qmd/eFIVmJMDOOModbFX0dIc6PjPSRNzPYo/uMO2vRgl4UBIJTVGB/KtfBW9qafXOp5uynXoQSkPCxEzqCSEq+JhqWUCAa+B5h7EMQujjSeKfTOpbgqBtrzChoRC7zHeCJp6ZF8lHpjRnxHrxpxrbzNU/wNu7mUOXV4NdtMevelaX3cSj53OcsBuBWutVnqGQ7QABAPWTPqYp1dvqzdYtgTqB5YddoaKdbjM3uM5TNZC1TgdyAuriFJawlsyCW0/r4JEgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phd.unipi.it; dmarc=pass action=none header.from=phd.unipi.it;
 dkim=pass header.d=phd.unipi.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phd.unipi.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LbQY8T1IqnB28yWxXThEUouDV7cW54hh3moMAUnnZQ=;
 b=UIW+rP/MyLMYngzWwi7v9SYVVcWtUkSTvt3bVEXgN1lyy/7Y6+ohxAB6x4C6pH0C1/2ZsTzfddsaWC/0mBQ6aCwAC9C6dXW5/F104Cwps9qDTkLXBtnaRKjj7VfCg4n/FispM+Y+dRb28bK2uUkY7hw6L5w+e4nzXZeRZkCg00Q=
Received: from AS1PR07MB8408.eurprd07.prod.outlook.com (2603:10a6:20b:4c4::17)
 by AM8PR07MB8278.eurprd07.prod.outlook.com (2603:10a6:20b:325::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22; Fri, 15 Mar
 2024 10:33:06 +0000
Received: from AS1PR07MB8408.eurprd07.prod.outlook.com
 ([fe80::f49d:54e2:b3e6:f607]) by AS1PR07MB8408.eurprd07.prod.outlook.com
 ([fe80::f49d:54e2:b3e6:f607%2]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 10:33:06 +0000
From: Alberto Ottimo <alberto.ottimo@phd.unipi.it>
To: "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>
Subject: [CFP] WSCC 2024: Euro-Par 2024 International Workshop on Scalable
 Compute Continuum
Thread-Topic: [CFP] WSCC 2024: Euro-Par 2024 International Workshop on
 Scalable Compute Continuum
Thread-Index: AQHadsQqRHgOJJ8wkUyZ3aG24W6Xcw==
Date: Fri, 15 Mar 2024 10:33:06 +0000
Message-ID: <01F64BA6-AB2B-4C7E-9B49-5DAC78FBDD09@studenti.unipi.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR07MB8408:EE_|AM8PR07MB8278:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qTrXbRVJJtlxe8TRlZLb3gPPJTCueygmSL5LDKsNehzxytFRx1c+sDo3iw2uWcngBrIREAJae7KtJ3QwrupkvlR7+PpU+JCPw705/qy3GZtDIzDaCNqE3yO2RVfCGfI67nHIeQOY6bpjU0frg1Y6rT1+oWG2WL1GuPdb+phKFd4cb/99YKQ3aPnvzTs5+F9BaPVHx2czBA5/NnxqpflUHEM1YpaQ5iL/GIbdvQkyD2gRPNtvPOuI2/5k/9ypHBLLVdrA+dy+VHu96tixG6pGreCsIXqw9rOK/UG5yBZlw74l8F51cHUwlAr5pK4zx89ziu7/wMwGrgO9XjaZ7GGZ2yBCjLsA8Wx1A6SWGf8ce3lSYFMbNwlqm9pZyS6HOzr7qf8YMtY5YBRTbXRFr43gceEsadpB3IdQJrAYvf0VbJFLzAdnK8fVbpV1Xz46u+46rY3BDvbrwDCCjYdp5BDuNUcZ1MdEoYMHy1zC+P0jcJjTMAC6WARO8AWjquTiG4ss+wV/xLwwFEVyqHeM/WKhJPC8Aj3vMmqkdWIKHOKYEY/7Ak/XLheg06qiI+8iKuc1U+4YPW97p3v98OoRKzdxCvDYuMNc2CsETqPb1lRDvYo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR07MB8408.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vzcrb0hQbXNzMlRONDJCQ2N4M3pidFhqYVZOZWNFa0ZWaDdNU2Q5L1RWRGpu?=
 =?utf-8?B?eW1WemFNZVpEUDFrU2ZxUG9aVnRjL3V2UXVaYzg2QSttcGdLbWFkSWRoOW52?=
 =?utf-8?B?ZXc1dVZxQkZWa0xybndCdGJzZ1RUR2RrQnNKaFc4ZE1OUU1md0JZdVdkRlQv?=
 =?utf-8?B?S0NOVUw4TUZLMUZnbVd0cllMU0NqS1MvU0MzNW0zMnBDeXdQaHd0SDV4MWNa?=
 =?utf-8?B?d2ptM0NOVmNiUVFIUkYrYmtGNy9meUs0SmFOWjdEZlRTSEEwQk43aTFrVldx?=
 =?utf-8?B?eTFmYm9zTEhINnNhendiMTRzN0ZhNHV2bXFIQXhkS3NXejFEWFpYVTJFek5n?=
 =?utf-8?B?SElPa01RaVFKZFFFajJKclFZRklIZDZlazNYU0ZBTjRaSHNrR3I2U1BRUGNm?=
 =?utf-8?B?VE1hdG9FSmo5VVNOaEQ0TFJSTEZid25qS0VMbXROam92dGFkbHRuaXdoclMw?=
 =?utf-8?B?VGVnRFdvZWR6cjVHMWQzdlptQ2pVK3NKMWtkWnVKcU1ES2RaQklFZlVsOExu?=
 =?utf-8?B?a0ZvbmtoSXQrc0RNb2JpaDZWYUdTWVlMM0Q5aTd3c2pwM0VCK3JjSDVUYUg4?=
 =?utf-8?B?cXRUb2Q1MVYramxTVTJCZEMrbDc5emZNK0tpQWp6TlhwM044dnYvWTdqUDVH?=
 =?utf-8?B?OW9VaGhOSFowa2huanRFMWlDU0o0eEQ0d21xN0ZmZi8wb2RnaXNEbStQZW5s?=
 =?utf-8?B?YTZYTFlvYnR3QlBJQ1RPLzNXRzVpcUNrTHlCVDluVDZQVlBmbFZBMU52Vng2?=
 =?utf-8?B?WmJYYXhmSVFPNENiUTZsZ2lpSVZ4U1pvdnIvRm9YUmQyaElMeDVyNzVkRFFk?=
 =?utf-8?B?WTVaYyt6RTBWYTBsUE1KRXJMNTNHVTRiallvR2JuUU41UmNtSkJSTjdGcFB1?=
 =?utf-8?B?Z2dDUWxMN0F6Wk5UZDQ2dS9ZUUNZT3I1bUZHQnFvaVBMTVltNUY0ZlVEWVlj?=
 =?utf-8?B?VlBhelRQY3VvQXlhQnoxZTEyUXg0YzYwdVV4M3RHaUd5bk1tWXVhWmRDVFlV?=
 =?utf-8?B?eVZjaTFKRG5abTNMTDBTWnVITHZwMnJRU2J1VmxNL3FyMWJYYkE2SnMyMHd2?=
 =?utf-8?B?aDRjVnZKdEp0dS82SWh5dXVCZnNqOVR0QUVkWkRoSndhOHJ3WUFaL0lRSU5K?=
 =?utf-8?B?TktGYndRWFJRZW5HWDNpeHMrRWp2ODNZMCtJc2dZQnptRjdUTTF6eW9YMmsx?=
 =?utf-8?B?Ym1EVE9md2ZYNUxNWU9kd0hiWnc3bE00SVVZclIrNXZxdzV2cENKVlNTa1po?=
 =?utf-8?B?Rnk1L3JYaExnWDFhYy9RbDFqdTB3SEZjTEZZQmJsSW5PaHlwc2tRbzI3MmpI?=
 =?utf-8?B?MENkaUJmbzBCVW03RGNVWDJTVE5ndHpCamZueWcvMUtIU0RRU2dlWTJrUjdu?=
 =?utf-8?B?YzRROWF5Q1pTN2FiUnU2Mzd4MmcwdmJLRVludUhtM05obll6WU96NU4rWS9S?=
 =?utf-8?B?SVMwUWczeGIwelY0Mml1UzNDQzd0QWJWNmFtMUtIZm1rN3doOXkrVm14em1t?=
 =?utf-8?B?dUhHc0hiUkF4UWZVR2pVUHdOaVBKYzd0WnIvT3RUd2ZMWVpUSFpjaTI4Q29k?=
 =?utf-8?B?ZzRuRksxOXlxMGsrd0RZSVRCdnR3cTVwR1UzSUZjSXM0MVpNZ0h3UUl2eDdk?=
 =?utf-8?B?SVJJYmtEMXJabWtDRVovSVVVTTEwUG1yR3MwM0ROcU83UlA0ZzR5NVQzUStp?=
 =?utf-8?B?d21vUUdXcGlTMXI4NUZtbXBFcVZJS0lDUVFxYXJsSE5hdC9aUzJMQS9BOG9t?=
 =?utf-8?B?MHZmNXZrWW5rWlJsWUhBQ282UkFyclRBZnA4eWJsNVBJVkovY1EzOVI4cVZi?=
 =?utf-8?B?NmxUK0dPOFUvUWg5dFhkY2JEZEs3UTgwZUhiQ1pMbGFwZG1tNDNGUXhvbkpE?=
 =?utf-8?B?dTRFbi9JZEd1VTVyc010TW05akVpY2VsaTVNNFEyQWRXSFVHNnRSRUhoQVNN?=
 =?utf-8?B?Y1d6cVFNMGVPQUlQVGl3dVZrSDBmMmRISVZhWUJoN2dZT1VRMUpOb0N5cFRV?=
 =?utf-8?B?RTZYaDJJVHdMNHpuUkxNTlZNbGZURVUzN0NKL1drU1RhRVhEdWljTW16VFB2?=
 =?utf-8?B?bjRidnNBNFV5aTRXR2sxZ2tJaEVwckh1RmFPYW5mck84ZitqUTQrQXk3WmNa?=
 =?utf-8?B?cjcwY2E2eVdFOXdUQ1h5eE9UQUVSeVEwYWo4Slc0S0dZZHlWeE1VeVNOd2xo?=
 =?utf-8?Q?3e0gEccxfjI/EebotJWjabFmasmsN0VOJJghVmbFAaB1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBD0E3449206A344ACB2174C5FB66204@eurprd07.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a660e0-595e-4073-7e4e-08dc44db4d15
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 10:33:06.0968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c7456b31-a220-47f5-be52-473828670aa1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gi/k/ashOYIAU6qpCVFxn60dQmWYY+vave2VJnuKqTlg6KQVx1jo1iH/lIDUnmXDB+kiPMb64oUap+RC39ioKZ3HyT4GVY0FBx57FLyNZFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8278

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
