Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF9673176
	for <virtualization@lists.linux.dev>; Tue, 17 Sep 2024 05:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726552775; cv=fail; b=ZU6f+eupW1YUYG9xH8CcyMBXce1h8qUlE7hk0jBBwKlthpf/G1C38h88yr8JNKBlwIh25ACUw13sMNRG1u76ikY7Sd/Yn7oSSQAVx7vSjlcqbBt9HvOESWB6PdJ2+i+fq0Sr6198gKNUuA8SfdlX6qhaRgpLIGI4LIxIVQBrsWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726552775; c=relaxed/simple;
	bh=OTkKomWP0cjv7dr4EvAS9T3m0zXxrV/RZxtxU7AaeDY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Q15zhQXa0sTB0CU1Tmw/pKC8Anku0AFoRFmC1Xyh8HQllKGBQQQR6dDLoAdT4Lfc9G2DrMD5rl/+hz/B2iJsIFkxOA6oTQPovuATFZuCdTJbJk+OjqaX1cdayTyUpfTYdDyILuu8vexz/jhhSBak6cynfJTnPsD4kKx5VZ7y6Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=aF4c5LOk reason="signature verification failed"; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="aF4c5LOk"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GNm0FQ023495;
	Mon, 16 Sep 2024 22:59:25 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41n7ujscfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 22:59:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCG4N0N1WkFKLePG1Ddya7ctu4ruAy6h23DXNOt3ARVnfJ/lvn1nqC5jHQ5pWx/QwKBQPTd1WEzhu69sjzdU3tHlIcBLtINl4ZMUsL5aYLgpxQs7HVOcOSU0Cw2Vcae5XP2pr6kfkVE5hakAWmKXzLISUa1hOV6hAoQNttqT84k5IY8QsdTTRlwOlDbCnqe40f2LwFtJ8SIbg51T9Mx4NDgr8HZQkN4OKd8Ymy3rvAY550SrZVT1tWD3UgxWUGndnrBaGBFZEe1S87sEDBMo8c8jw9dj5Xcv6RsjmlAH7bOFpYDpPipBZgRHb+6ZOm4fVZF8O4rMf5hQzgv5JWhwlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udtUv0bm609k+YCoHoYrYgqJIW0aIdsKmA1orjaMmeA=;
 b=p6tkArnnS3q1Xop4TMGh/4/XdqiBOnCw37ZYXjQlqqyMxeALch405VBOtOkuFalve5zyjR7in2foiTrr6EKW/vh3aAKXRUq6y9rsn7yQdJZRKr/In8AH6DL+AA27eFIf+eI/k4mIAR4xc2zIXRcykPX/mkKYkGQmqWWsa//O+fIUr+Qh996wF/p67mV1ba8P5oyTLezx+USYS7tKLMdeNrfhIxWiqDvoplyDmrGXyWurM0dv7sDtv2YK1nSjCVp6qKvM3kn0CMMDiSNyHLrgy3fqIfJkpYjWczIlx3TluuWqpyo+Nmtv3WhfB4Ye41VeEtorHpGInVCE8kdNSp8RAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udtUv0bm609k+YCoHoYrYgqJIW0aIdsKmA1orjaMmeA=;
 b=aF4c5LOkyle2TQP/bq+oIsBy7mNSVL4UBVcO948ban9jsj4ZO8ShoV2+zubJuT+Q9gmsRh/dHF3mvqstpjUlv+UtlX0qXRClCTrDwp5/A/czXL1hAQVnPqTIUvUNVmi6u0t3v1x8E29SIrYpLNgD9RSJrvU6ZuuxwHXp9pUzHU0=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by DM8PR18MB4504.namprd18.prod.outlook.com (2603:10b6:8:33::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 05:59:20 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::ad53:bef2:cc17:13ac]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::ad53:bef2:cc17:13ac%4]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 05:59:20 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>,
        "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
        Vamsi Krishna Attunuru
	<vattunuru@marvell.com>,
        kernel test robot <lkp@intel.com>
Subject: RE: [EXTERNAL] Re: [PATCH] vdpa/octeon_ep: Fix format specifier for
 pointers in debug messages
Thread-Topic: [EXTERNAL] Re: [PATCH] vdpa/octeon_ep: Fix format specifier for
 pointers in debug messages
Thread-Index: AQHbCFS0KAG75dfAdEi6PPVo2f4H3bJarx2AgADLwkA=
Date: Tue, 17 Sep 2024 05:59:20 +0000
Message-ID:
 <DS0PR18MB5368A29EFA2094A2253CD6B2A0612@DS0PR18MB5368.namprd18.prod.outlook.com>
References: <20240916162255.677774-1-schalla@marvell.com>
 <20240916134226-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240916134226-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|DM8PR18MB4504:EE_
x-ms-office365-filtering-correlation-id: b758ce54-38d1-402d-cc23-08dcd6dddf56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aGVXZUF2bWNOSTNveWtkTmplcFFRR0ppVUxGOHpaTEJYRVNJQmRPaHF2MGNx?=
 =?utf-8?B?aUFzSlhici9hak01UE14MWdwQWU5Z3E3VGVGeXliTWVCU1VyZlphL0lwSUFG?=
 =?utf-8?B?QkZCTlhreHRUOFFvMFIwUU9iVDcwQU9SZ2lremFLOW14UTNzWEJ4U1RQTjAw?=
 =?utf-8?B?bDJxYlRITVgrZnNZTS81ZE16Nk9LZ05FZkd1bCt6SW9YN2pSd3NmTDlxUjR5?=
 =?utf-8?B?bTcxaStBR3Y5NjJpSU52Ym9JdG9RQmJBMnJFd1lBRjFtQXNZYmdveCtLUE1h?=
 =?utf-8?B?N0RYNnN2Snl3cHp3S0p6ZUVnNHFCclZ2NTVCTDB6bUdJakVSMVhndzl6QWQ2?=
 =?utf-8?B?SUZQOVZyeWVTYkV0L01hYlYvejFybDBrdTl4bmRPOW5hVFU4SnF1M1kyeUJ2?=
 =?utf-8?B?em4wWnZ0dllVR1c3K3lJMDAzNy9SMG8rTnFJMHh5eTM3RFJFclNCdHFFK1Qy?=
 =?utf-8?B?ZzgyQnk5Q25acmQ2UDlJcjBTNzNHL2FuSkp0R0c5V3cwNDJBcWVvTjJ2OEta?=
 =?utf-8?B?ZnQ5MlZGQzA5a0RNZHR5WDdLc0NQalIwRVl0UzdOcm5mVWN3RVltWndueVAr?=
 =?utf-8?B?V1JwOUtHTFlsRUF6VnAzeDJjaFFlL0xrY3VVWlpwbDQyUXhPSzdHcTExc1Z5?=
 =?utf-8?B?amlUQUJzOHFuQ0hhZ2l3VFZoVzBXYkpud0JuV0tVYVV6QlhlR3lWMW5nNjUz?=
 =?utf-8?B?UVFWU08wUTZXYXpSQ0c1OU1NVXRWK0JXaDc0ckdDbUlrSkpIeGVFbTV2UHBB?=
 =?utf-8?B?YnFBOXNEZTRJYVRCM3Z0bThiOTVneTJxTmYrYllOVHE5YkJ0cVZlcklmN0Fx?=
 =?utf-8?B?TXpCT2puL2lNYmZGV0tlWktTK0UyakdSSUdpMTZ0NC9jMmVzcWUwTktXLzc5?=
 =?utf-8?B?R2VRZldGZXpGWkZUd3FJWVBUbXRhbUo4ZkVVNDQ1T2ZvRkVmZklpSWRRMmkw?=
 =?utf-8?B?Y20rUGkrL09XMnRhUTdmbkNieUxYNEdraEZFb0o3YUVwbXNhRlIzWDN5bFpj?=
 =?utf-8?B?WnBLZ3MwRCsrN0lKb00wUElsa1lFL3p5VDZjWkE5blVYMGxORlphK2J6SDdX?=
 =?utf-8?B?aVlSK1hVR2RCaXIyNnBJQW5IczhnM2ZYWUVZWVFhdnJiTllwdWtaczgwV0xv?=
 =?utf-8?B?VWZXTUNzZEwrZjREM3pONDZEcDk3NlNJeGI2R0dOSnVyanprWTArdFdOUlJT?=
 =?utf-8?B?OVI4MFRTTTBWcDZ3K0VFaEpyTlBkRHJTRVlpYU5DcWVNa3J0VEc0TW85SDVS?=
 =?utf-8?B?bXFVSnRqVkZBU2hzaFZQTUV0aDhoMmpDaEZ3d2Z3UlVsdUdKSkdTL2pkT2xW?=
 =?utf-8?B?MjNETGFjeW82dDBiQ3J0dnJhamozL0hvV3IrMVNjVGhHa1BjQnViOUREZkcz?=
 =?utf-8?B?cnJmVHA0clVKVVQ4SFpubU8vNEY2MXdHaHpLcU5yRDYvTkJTVkFJbGFFT3NR?=
 =?utf-8?B?SFlhcVJTZlFzQnhaZFdHSG9qcEN6NVlUdlV1WFk5K2pXeXpZLzhMVmhQc2pj?=
 =?utf-8?B?dUVkN3hTL05aVksra0czSkh5RUVoY1hjVVkwVkJHWEwvVHBrUFRFZ200ektU?=
 =?utf-8?B?T1B1cFlFZ2dvS0kzRjNwbThib2hrS3p3cE04eTVDaVUvK25BMWxobmxnUXk5?=
 =?utf-8?B?SXN1NWRJSmxSRFZQdjZJUURQdmRwVktRckhOZnRHQ1hIV250aHg5OGNydVZw?=
 =?utf-8?B?ODVGRXpFRTl0Mkd6Y1pWdHpobXJ6a0g2VlJoZUgwVUJKclZ6ZzNnTW51WTA2?=
 =?utf-8?B?RkxCK3QrZmF5dnhKM05tTTh2M1JJcDd2Rm9DM2tqdXVURXJvbnhjNTFJbmYr?=
 =?utf-8?Q?khbjIZZAltDGqTE5mWv+azAzX2BpmwO7wiNbM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR18MB5368.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWppajhuckozcy9wUHZSZjFaSzNkaVBsWmg4OW4vOC83S2IxN3dPQytGeVMr?=
 =?utf-8?B?TEZJdHNDWDB3UUNIRjdVMitVRUJMVDYweTVBemFQTTdtTXRobG9kSk53YjR0?=
 =?utf-8?B?NlBQYnV2MGd3cDVnSnIvUTBiSnRCcitzV0I5OGt2RDlqbXRaTVIrbkxGTE1x?=
 =?utf-8?B?MkpvTFBRbjBYYWM2ZFdNS2txS0tVMG1rVEp3ZHdIUWNLcmFYZTEvMys2bFZY?=
 =?utf-8?B?VjNhNWFWKyttbERLcW03dHRYV09RZFBVNDIyMy80RnYzQWN2MDZYcXpRL2Vn?=
 =?utf-8?B?N1lPUFdLOFJaZGJMc3dobjJ0TGQ2Uks3TXFJbXM0ejYrdWdmYi84cmhQdWlh?=
 =?utf-8?B?RFVzcjlXMlMxWUNxQnp5RGxCTUJDdWx2a1JhNW03Wndzck9UeWJIRGdDVkVp?=
 =?utf-8?B?ejUxc20zekgwYVJpTGpzcVNsMHNKcDR0R3VqVWNOc1c3czdiOVlLRy9uL0Vy?=
 =?utf-8?B?ZituSTZGNytIL2NFd1AzNXppS3pLdU1rNWhnT1g0dW9Wc215aUN0VlBlYkdm?=
 =?utf-8?B?Z3NzNDhIaENVSXdYOSt6L2grM01jaFVFSnNyR21iZElraGpjalBNZ2xPZU5K?=
 =?utf-8?B?bmtuUW1HSFlhSGZaeUZRa2NFeXFWdlBGK0FRc3pkaXJrVFZXcE1RWTRZc1Jz?=
 =?utf-8?B?cFFjZ1lJZGoySW1xUWhSSE9OU3BsSnRCNWJpSksrSXBtMEJ5OG1WejZWMWJx?=
 =?utf-8?B?WDlqRFU0YzVsenBXZGMwWU0vN1pUMXd6K25RSlAzdnZURWpwQ0czb1o4NlpE?=
 =?utf-8?B?aGtNN0lDY0NUV05jczRJODdaazg2Rk5DUm1Idi9XWFc0ZnVRMC9ZRDJKWjJu?=
 =?utf-8?B?REVyU2xpRDFJTEppbkpVZ0laS0hCVmUvbEFkckdRdmExcG11ZGJGbWpLVjR5?=
 =?utf-8?B?Ny9zUlFJRGk0bzBpZWY0RnNka2JRdStCSmxILzR1NlJNSTVpVFlGK1haN3o2?=
 =?utf-8?B?b1hiNHVadUQzaWl5YXhjaUZjbWRsUzY2cWFoKzRySE1mby9obDJRTzBleUsv?=
 =?utf-8?B?Z3VxbGk5aC9hYVl1ZlZVdFNhNmZaVXBqOGpITDBpcFpndm1qS1hlMVNYN1Vw?=
 =?utf-8?B?ekYyYys3Z3NKYmhxb0ttNVN2TUsrUkxmRmpGSUpaT3FXcS9NMXlIN3lMcmxH?=
 =?utf-8?B?Rit0U1N6NVFwcVhLM001UWM3N25PT3JVL1EzOXFOQmpyUXVVU1pYYlgvZUsw?=
 =?utf-8?B?QnZQaGs5Q0JNaG8rMFBGditsYmIyRnhaMGlxY3dSZ0Y5ODNXOFZWeURNSzN1?=
 =?utf-8?B?Vjh6N3NCNU4rQ0psZjJneDk3U0FHV1RycXBWQkM0ZCtMUElIYnl0N1huOXZD?=
 =?utf-8?B?bVVkZVB5clZESDhUejdRMit5Q2hjYzAvK2tESnFLSCs3ZitJRUo5Y2w5NFJh?=
 =?utf-8?B?akdEVjZjbkZ0TlkzYkZnaHpZTVV2cVA5MlB2blVMYkU3QjRkbngrU0pjUFE2?=
 =?utf-8?B?UWtGdDZla0hPYUlsSjBSUmRMVGYzUlZYanhXZkVnQVpVcStnVUlPWnFQdUpJ?=
 =?utf-8?B?UXNZeTdFZ3p6b2pVV1p4cGpqdUFweXAzRnZiZjJEOFRrMWdPWmMrZFdFb0Iz?=
 =?utf-8?B?YU1JM2ZmTXpCOGxwM3hSQkRRclJ2WkJZYStkVWJHOCt0alM5QzBsMWNTQmQ2?=
 =?utf-8?B?TXlSZ2R3Z3hIeCtzZ0ZIL2haNUdXYURiNnhOMjk5VXVGbitUUkRWdTBydHVD?=
 =?utf-8?B?cDBSNHdUWUpvUjFWV05sSWQ4OTZZZkg3T3hGK1A4djdJVWp5U0hpZ3NjZUtN?=
 =?utf-8?B?ekRNRmZGdjUyV2Mxb3ZiamlkQjkvVWh6K0pFSFlMVmlXcjVwYUdpMXRTcVps?=
 =?utf-8?B?dDliRk5HMHV0aGkxZVBhMTZpcFdqVEo4emVrWVBRUEE5aW5Cd3ZNMjllY1pV?=
 =?utf-8?B?NGdlSkdxcnNVdEQwU1RzN2hoMGlrN0U1cnluQ2ZsMkJ3QlV4UU1TenJUTC95?=
 =?utf-8?B?aVpYYmw3ZTh4MWdrQkQrTWd4ZUxIRnNyNEM4a1pwRDNTK0NsNGdSK1B1QWZw?=
 =?utf-8?B?bG02cGpzV0c0N2RvSVlTVFVpNEtRQ1M2aWQ2dHFPRWJISGl6aUZJUHQ0bm1k?=
 =?utf-8?B?S3J0NXBTRzFTZys5VEdRbUpaMHp0MThMdU9OYldoNGMrM3d6NkR2ZVRoT3g4?=
 =?utf-8?Q?4zew=3D?=
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5368.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b758ce54-38d1-402d-cc23-08dcd6dddf56
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2024 05:59:20.2802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mng+7KuufTJ+BGOVs0wvd/u/iPYOePvCRSOmCnzz4pPEyIZ/nLXVf76UnqHo/UBHlQ5ZRzixp2XXR7UvcL5AVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4504
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: RLz4Y9DOq24Z_dIDXFPl7MBDb-Svknqu
X-Proofpoint-ORIG-GUID: RLz4Y9DOq24Z_dIDXFPl7MBDb-Svknqu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

> Subject: [EXTERNAL] Re: [PATCH] vdpa/octeon_ep: Fix format specifier for
> pointers in debug messages
>=20
> On Mon, Sep 16, 2024 at 09:=E2=80=8A52:=E2=80=8A55PM +0530, Srujana Chall=
a wrote: >
> Updates the debug messages in octep_vdpa_hw.=E2=80=8Ac to use the %p form=
at >
> specifier for pointers instead of casting them to u64. > > Fixes smatch w=
arning:
> > octep_hw_caps_read()=20
> On Mon, Sep 16, 2024 at 09:52:55PM +0530, Srujana Challa wrote:
> > Updates the debug messages in octep_vdpa_hw.c to use the %p format
> > specifier for pointers instead of casting them to u64.
> >
> > Fixes smatch warning:
> > octep_hw_caps_read() warn: argument 3 to %016llx specifier is cast
> > from pointer
> >
> > Fixes: 8b6c724cdab8 ("virtio: vdpa: vDPA driver for Marvell OCTEON DPU
> > devices")
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kerne
> > l.org_r_202409160431.bRhZWhiU-2Dlkp-
> 40intel.com_&d=3DDwIBAg&c=3DnKjWec2b6R
> >
> 0mOyPaz7xtfQ&r=3DFj4OoD5hcKFpANhTWdwQzjT1Jpf7veC5263T47JVpnc&m
> =3DqyhlWh2lF
> > E3SPFpB_eJ0K1RFMa5f-
> kcNChFHkCARDCXIkzMk__3sqspP_K7KGxaj&s=3DfMvS62XMmi5H
> > ESJuL9v7FX3c8RSzKCq7JM6Khcof4vM&e=3D
> > <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_
> > r_202409160431.bRhZWhiU-2Dlkp-
> 40intel.com_&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPa
> >
> z7xtfQ&r=3DFj4OoD5hcKFpANhTWdwQzjT1Jpf7veC5263T47JVpnc&m=3DqyhlWh
> 2lFE3SPFp
> > B_eJ0K1RFMa5f-
> kcNChFHkCARDCXIkzMk__3sqspP_K7KGxaj&s=3DfMvS62XMmi5HESJuL9
> > v7FX3c8RSzKCq7JM6Khcof4vM&e=3D  >> Signed-off-by: Srujana Challa
> > <schalla@marvell.com>
>=20
>=20
>=20
> This does not fix it completely.
> ret is still 0 here:
>=20
> 8b6c724cdab85d Srujana Challa 2024-06-14  140  	val =3D
> octep_read_sig(mbox);
> 8b6c724cdab85d Srujana Challa 2024-06-14  141  	if ((val & 0xFFFF) !=3D
> MBOX_RSP_SIG) {
> 8b6c724cdab85d Srujana Challa 2024-06-14  142
> 	dev_warn(&pdev->dev, "Invalid Signature from mbox : %d
> response\n", id);
> 8b6c724cdab85d Srujana Challa 2024-06-14 @143  		return ret;
> 8b6c724cdab85d Srujana Challa 2024-06-14  144  	}
>=20
>=20
> which is wrong.
The fix for the error code is already included in the linux-next and mainli=
ne Linux repositories.
Therefore, I did not include that change in this patch.
Thanks.
>=20
>=20
> > ---
> >  drivers/vdpa/octeon_ep/octep_vdpa_hw.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> > b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> > index 11bd76ae18cf..1d4767b33315 100644
> > --- a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> > +++ b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> > @@ -475,11 +475,11 @@ int octep_hw_caps_read(struct octep_hw
> *oct_hw, struct pci_dev *pdev)
> >  		dev_err(dev, "Incomplete PCI capabilities");
> >  		return -EIO;
> >  	}
> > -	dev_info(dev, "common cfg mapped at: 0x%016llx\n",
> (u64)(uintptr_t)oct_hw->common_cfg);
> > -	dev_info(dev, "device cfg mapped at: 0x%016llx\n",
> (u64)(uintptr_t)oct_hw->dev_cfg);
> > -	dev_info(dev, "isr cfg mapped at: 0x%016llx\n",
> (u64)(uintptr_t)oct_hw->isr);
> > -	dev_info(dev, "notify base: 0x%016llx, notify off multiplier: %u\n",
> > -		 (u64)(uintptr_t)oct_hw->notify_base, oct_hw-
> >notify_off_multiplier);
> > +	dev_info(dev, "common cfg mapped at: %p\n", oct_hw-
> >common_cfg);
> > +	dev_info(dev, "device cfg mapped at: %p\n", oct_hw->dev_cfg);
> > +	dev_info(dev, "isr cfg mapped at: %p\n", oct_hw->isr);
> > +	dev_info(dev, "notify base: %p, notify off multiplier: %u\n",
> > +		 oct_hw->notify_base, oct_hw->notify_off_multiplier);
> >
> >  	oct_hw->config_size =3D octep_get_config_size(oct_hw);
> >  	oct_hw->features =3D octep_hw_get_dev_features(oct_hw);
> > @@ -511,7 +511,7 @@ int octep_hw_caps_read(struct octep_hw *oct_hw,
> struct pci_dev *pdev)
> >  	}
> >  	mbox =3D octep_get_mbox(oct_hw);
> >  	octep_mbox_init(mbox);
> > -	dev_info(dev, "mbox mapped at: 0x%016llx\n",
> (u64)(uintptr_t)mbox);
> > +	dev_info(dev, "mbox mapped at: %p\n", mbox);
> >
> >  	return 0;
> >  }
> > --
> > 2.25.1

