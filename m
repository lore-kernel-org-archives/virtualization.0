Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98700169AD4
	for <virtualization@lists.linux.dev>; Wed, 29 May 2024 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716974853; cv=fail; b=bmwMphvQekdZ15ilK/YUry5FIdt2QpF/oPrgtcR/1Q3TJSO0ops5MwWFyL99wZI+QEjO3sgQTmgWAjG1GosuUrmK6ArAeQEBGSbBurt+R7nL+9t+5euEnTS9YVfub9kEmrPONUXy+MSW79t3Q3gsH8rnZOdSR07mg0gC/BueSFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716974853; c=relaxed/simple;
	bh=KeS+bA/qP9PbLvRN5Jk9NLB4BCOLpDwIcEcRzDiWk1Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kWsmhYb2PbVUeOfCO8+GYXXCA1Y5MuCjQishYPbeX6z5Evc7MA20prv+J6+Oh3/ajbgAhZ0tyvdbKAHemzvzBm4qoIPe9Db+hnBkXqZVgMK0uEWSokmu+R8Zt+E1PNbdKCC/YSJmbkMwQr6ZHm/4tUjO0eI1/jve+vrMKCD9NfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IttDR/ZX; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IttDR/ZX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3UIqqirw7RH1oXIpRZaZYk9F9e/xJMD/d5zxkul6BWyoB1DffFRw746wjTRkPYGPf8J6FNVIDSx9CyQr2stUQ4g9gI95x95zOMh0WHafMWcDVvK8nXO+nl7aJPmoaIaNsxd9d9ViWKJoC426z/mGF1ZJd0Ge5447feELB9Dq6z6cR4Kpj6tSRylkfAtjiiHWSy297GV6ylNcwhBAxg0s0hngiz270dWu5uAl5hm36KBnF83+Jc0++C6fEsRiO+0L8xHgNjj4s+83ngrfrzhIfEkZ0qj9V2Z1SkBiifg6++5I9iLvHhhn996lJeAk1aPsNGF/bEA/v872lQOicL9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeS+bA/qP9PbLvRN5Jk9NLB4BCOLpDwIcEcRzDiWk1Y=;
 b=QQcW9rboIvQM+24xLLb13//jXqzatoxu0sl3yZVP0QB5ANNZAE/nVL2Sw/tPxOb+3FF+WjyqDk4BvhdaE8zt/LclD0yFU/HrvLXksitbB6QmpuaSKkD3a8I36ymoONAhTaehylLJ/UY9oYyJyGhcoGw+uJUcmhGUEL5+yA2g7BRoYmSdBUNnAx9C650gfu6o5agaWk28RdtXEp9cR3Od5vtwWycrX8JjzRLUfqv8T3A2qRQUUfJ2HkRY+1wFXcHgYkJQyfMurLrE3kIK9A00fCTPM9teTMe2jSt+JSrY2pzKsXa9NH96erPGxRKmsCFuZjqi2hGIayO0NJz76EYIvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeS+bA/qP9PbLvRN5Jk9NLB4BCOLpDwIcEcRzDiWk1Y=;
 b=IttDR/ZXRcz+Scg2vJz21bIQ730IABgEecqcFu0w5D6JITwt4MFm8tuMPoUL2ia+jJ40o3QtNEo4jNTY1nZZ3VT9nuTv3xP591FWr1DKKA7kZrplZ2x7FSa+9lYuqvBBvBfoW0Fqwhxd0uQ6FVSzyml4/vbPPqVGwGY/QAVPueoSKzokZpeOZ9mhzOP52JGnlmsyx1aIJ8h1wI5j3yc5ij5wHcmAgSRKOgY4YEznk/X6BDxYN2m/UsprtXmwqXP7Yx7MGu1jpaZsCZC8KPfcCtYeZxDeMVDtgduKsaCJKBZu+SkCuwnAh4WMKWoGM/Fv/TeFhhfbnLJkXENfv74L1g==
Received: from SN7PR12MB7833.namprd12.prod.outlook.com (2603:10b6:806:344::15)
 by LV3PR12MB9186.namprd12.prod.outlook.com (2603:10b6:408:197::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 09:27:27 +0000
Received: from SN7PR12MB7833.namprd12.prod.outlook.com
 ([fe80::6f09:43ac:d28:b19]) by SN7PR12MB7833.namprd12.prod.outlook.com
 ([fe80::6f09:43ac:d28:b19%6]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 09:27:27 +0000
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
Thread-Index:
 AQHam9202+2TyynzgE27Na4LWMIzbLGsgNEAgAA0ZoCAABrUAIAADQoAgADAzQCAAH83gA==
Date: Wed, 29 May 2024 09:27:27 +0000
Message-ID: <297090cea0e63357686fdcf2f8d35c807d6f62bc.camel@nvidia.com>
References: <20240501153817.540855-1-pgootzen@nvidia.com>
	 <20240501153817.540855-3-pgootzen@nvidia.com>
	 <08795907-fb19-47d7-a8c9-3db0ecc91889@linux.alibaba.com>
	 <CAJfpegs7Dgn1++gYU5jNmCbiJwDFxWShgH_0fkaSN13nmbiY-g@mail.gmail.com>
	 <1672df38-7b97-41f5-802d-ee50f83a885f@linux.alibaba.com>
	 <33d6f262b9c5c7c2d23bd0062a88262b597abc84.camel@nvidia.com>
	 <2a095e1a-a3f0-40d5-9dc4-68e60a5a3e9c@linux.alibaba.com>
In-Reply-To: <2a095e1a-a3f0-40d5-9dc4-68e60a5a3e9c@linux.alibaba.com>
Reply-To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7833:EE_|LV3PR12MB9186:EE_
x-ms-office365-filtering-correlation-id: 241bf861-d18e-4c45-94e1-08dc7fc18e4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?STBQMHYvUkpsWnkwVkVzYUIxN21iODRSR2xBK0hnRU5VRHVvcVloY0hrSEd3?=
 =?utf-8?B?Y2NaTUpic1AyYVZzV2ErYlJ0RVFINE5Qd2E2b0lTVG1WUU8yVHR0VXpmM1N6?=
 =?utf-8?B?cDdzRkJrWUJGWHowbS9UdVIwNEZROGNhWUNmaHdiSC8zUXp3djVTR1FXL2Iz?=
 =?utf-8?B?OVRWVG1valdRRGpDV0JhcTh4TTdoSWVSQU43bUtTa0ZFeDZNWGR1SVdDeGVu?=
 =?utf-8?B?WEpJVUFGMWtoclBhTG9WZUNsMWJDRDVPc3lsaG9UMWZucVo2eWNad2FuRzEx?=
 =?utf-8?B?SERleEVJL2VBSDZZamZrNmtES1FvMzd6VVRKbWJHMi90R01sOWJoemlZdHRi?=
 =?utf-8?B?c1gzWkVkZ1hjM2FaV2RVdlFDaTZHN3NCckJwN3hsdlUwUlVNQXdwc0xrVjJN?=
 =?utf-8?B?SFlMZVJCc290YzNiMSs2L1FnczNER0swM1Bhd0FsSTJFNW1Zby9wTE9NYlhR?=
 =?utf-8?B?N095OFZES3hrM2JYS1JQdkN2REExOEpVaTZMK3dqMTBSVFB3UGJqeWJpY0VM?=
 =?utf-8?B?ZTFEclRPOWxoRWZkSHJ1dW9hYzBNMVRRYUJ2TnVGNXR5MWJkOVBrYmFTV1NF?=
 =?utf-8?B?bVZaTVJuYzgvRTVUZ3B4V2FhcVlnNmJ6bzRnUVk2dE0rY2NRMkJoMlNnQkdB?=
 =?utf-8?B?T0tQTEl2cUF3dHphZWIyRnM5bGh6Q2hPWUEya0JsZTJhdEYybEVJU0ZFRzBD?=
 =?utf-8?B?RXFIMHJ1NlRlTnlqZzk0UUxBUXpZOU9CQ1llZnFVNGo5RFRUSmJXQmlHQ1Jw?=
 =?utf-8?B?cndnajUxSnFRRitGU1hxVG8zMU14WGxpYnQ0enZXQ2RvMVFuM09WR3VkWHNk?=
 =?utf-8?B?S1N1bEk2Ny9VVU1icTVvcm1ib3ZudStLRy9lVGFTNms1ZnYzZXgreEtJa1R3?=
 =?utf-8?B?eXAxRlNwUkk3TXNVeEtaNUNYdjJoQ1IzUzFCclVHMGZ0MEJxdW45RnFuWTVN?=
 =?utf-8?B?d2hya1VCejVET1lIUks2Mll0TjlBNkpPRXUrWUExZ20yMWVieVk2QSttUHlv?=
 =?utf-8?B?eVFiT2pGM3E1WTBVY3JteHVhQzJoRGF0cFZCa3NCUmF1QS9hUGd1d05tRG5J?=
 =?utf-8?B?WUZtM2ovRm45WGFDYzl0WG9qWUYwUU1LTHZxK25ZZlVJQVE3NG5lT0tkZFlJ?=
 =?utf-8?B?bFFISkNsU3VQSU10dHpyRWxRUll0NGswZEN2blNveEg3QWhjVXg1RXhHSHpJ?=
 =?utf-8?B?bFo4NGtTbVlUbUVoazRHdUt3RkxqKzRWNU5YZmNueDdKMDcrRU5lL1MrTUlo?=
 =?utf-8?B?TWNwWnozcStPN0NEZmx0MkR1NEFSQk52eG9xb21PWmZDYTZ6WTFGd0xOOVhP?=
 =?utf-8?B?V0tmZTh2OE5acllwOEFWRnBwZDZZRXVVa1ZrejIvOURkOExvdllZc1FVaHdr?=
 =?utf-8?B?QUMvbGxYR21ZL0ptbjNEWWR0MmNGQnMxTVo4eUY5UXBaVWZ4RlpDMkIrdTdM?=
 =?utf-8?B?U1JGRVRhZ0g0OHo5NXRJSWpvUXE0UVpUV092RUJwa1JHS2VUZDIyK2JZRFJh?=
 =?utf-8?B?dWpueVY4SFZLb3NKOVdOVVZ6WnV0UC9YRU1pWDJrN09UNXk5N1lvZ3dOdjI3?=
 =?utf-8?B?QjV2T1VWTW1MeFBGV0FuYVVBb3ZUSWJ6d1pzcUxzZlYyb1V6ZUVMNEZuOUMv?=
 =?utf-8?B?UGZxcGNlSDliV3FXOXVsV2s3Smx0SDNQaG4zS0lWZUxRNXdORWgxOENEQi9w?=
 =?utf-8?B?b0lQWDlzRHJiampkaTlYeWFQSkxtaDU2MWZaaWFmeXVjQytaYTlNUDhuMlZO?=
 =?utf-8?B?aEZycXJBVWpLakFweG9SU21yYk5BdUNBNUhGcjdzd2dZdk1EYkYxS21yc3Ix?=
 =?utf-8?B?N0tuTGhPYkYzVUtXWExiUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7833.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VTlKR0xRT2lMT0JzMStpbDZlZjVxOFR6QjVIaUVWb2NBOVduNUJ6Ky9vQzdx?=
 =?utf-8?B?c3dnZm96NmVIbnRrWHRHZ0NGdXBpNDFvWXZxQUM3TGtGQmQyeWpWQzRiU2li?=
 =?utf-8?B?SzV3YVVQb0I2N243UGhaRFBONDgwdUtIcnViU3l0VnQrMUZHZ3dXWlQ1UGRN?=
 =?utf-8?B?d3lYUVU2dHdvRTJlWFIwWUVPV3crY3RQbi9ncEtSaE53aXl3UGlDYnpNSFZ5?=
 =?utf-8?B?YmdMMmlSdERjUW5SQ3pIc2tweERVY2tvby9QbFgwcEU3Y1VGYytRUWkxVjZB?=
 =?utf-8?B?d0UveFIvNHY4bXlwZU9FNVQ2eWFsNUxHb3NBNGZrbFVRMVhZQ0hFeEN1eTJ1?=
 =?utf-8?B?Z2RGd2srT1o5MXJ3cGNDMHdhbmpUZUtvd2JTSEZHakF5ak1qNXV6TE1XcHp0?=
 =?utf-8?B?SFhWVkZpOTAwRXRvZ2lqSmZWVUwyQkY1QzhaeDdmRnlDNW45KzhuMGd3WFdy?=
 =?utf-8?B?VlhKTjFHMTNPNE0rQkF2clVKVjA4Z3hROFNqK04vR2hpR1NGUThpV1FWanVV?=
 =?utf-8?B?ZnV0R0FsQTFJeDBlYkRkQ25tK3pDdUJZNGNuajEwcnpSZGVsaGllM2czd2hp?=
 =?utf-8?B?dVdaQXk0NXVYOWFEaXo4WnB6THlQL2I3VmJ0MExlcmg5dGlENEhIamFrbWU5?=
 =?utf-8?B?SjRLVGFmdUZLQ3IzMXpMeEFnZGl6Ym5xaXVjODdBZktlYnp3SjhaV1NiT0py?=
 =?utf-8?B?dUNhS3p1UWovRVMvWEVTVmR1T1o5OERETUxBL1phb3VqRm4xOHFwUmdJOG50?=
 =?utf-8?B?MllnR2ozSm1RZmtrODRVa1BaSXF0dHh6aXp5UG9wN0VwN0NiZ0EzYW82NUdv?=
 =?utf-8?B?bzN6eVYrSTMrSnd0aURLUDdFL2pYdXBiVTZEOFlCS1NzOFZBemc5MkU0dVdr?=
 =?utf-8?B?Z21vbmFzS1A4Uk13eFFpN2pWR0xpRWo1WW9kQ2FGV2wzL1ZjWUsybDR2eTE2?=
 =?utf-8?B?cnM4MVNXR2pnNm5OVlYySjZZUDlvSUNNRXpISTd4TlYyTU5MaWx5b1F6djhL?=
 =?utf-8?B?VCtLYWRaRDA1SE9sVDFGSTBjVlVrTUVHdXdiaUR1N2IwbHcrNXFnY2JaN3Z5?=
 =?utf-8?B?VU96eVpIM3I4a2RaM01VZWxxaUpsQ1grQk85YncvNTNzaUE1ZFo4QzU4RHhr?=
 =?utf-8?B?VTdzRnFDTldwdmc4Zi94ei95RlRsOVZjMklyNzBob0VpNSt1eWNXb2xzdFVy?=
 =?utf-8?B?eUFmcktYb0s3NkhmRzQ4RnYzblpTcERjWmZBb0ZDU2RFNmhtT1JDb2xwdlhJ?=
 =?utf-8?B?cEhGOEI1eVNOT2dMeWRKQ1dQbnVwVzhmblEvSlpTVmZYck8ydDhsNG5lMnp6?=
 =?utf-8?B?cURRSVo5M3lSdnpLcTZncnJpeG9rV2FCUm5ub0x2cFZXa05VcWRqeEo2azFj?=
 =?utf-8?B?RWJmYnpsUEUrSTVLcXdBZTQwKzd2a3c5akRoaWwyNHdzUW1zeEg4L1VJRTV5?=
 =?utf-8?B?K1ZuZnI2S3drdEVMRHd6MzFqY3R2ZHZiTDA4aHFSUm9PQmg2cmZHYStDSnc0?=
 =?utf-8?B?N3orLzA0M0VsQ0toRS9UNGpCeHdoOFlScFhOUnVJcHQvdkdlbUdsdHFaT1Vz?=
 =?utf-8?B?NFlycnZQbFl2Z1ZlRFVjNk5nSnAyM2FaTFR3TnZaVmQyMHVuQWdJL2dwWThi?=
 =?utf-8?B?LzgxQUFuN3dmTmJqdWlRNHJjRlhrR3hjQ1YvVVM4R1NEOWRSaWJrMkVia0Jr?=
 =?utf-8?B?SmkrOXNlejBzb3BYOUhHK3I5cU52cVJUeFpVc2MxbkR5Sy8wek1uYk5NVWM2?=
 =?utf-8?B?YmNkcVVIT0lydFN5Y09HU0w0bnNCLy9hVDlyQlRsWk5lWFlJOGJDKzJVQXoy?=
 =?utf-8?B?Q254RS8xSmFFWVg1ekxidklUdXlBbGRvTC9vUTVlaDVCTW8vem1UTHRNVUpi?=
 =?utf-8?B?WUFzRngzUXRSaFg4NE00NVVCcUFHUGpGUHdYMWc1bjdldjYvVFZlTVQ4ZDQr?=
 =?utf-8?B?RVp1Q2hEUUhEQy9ibjJWbmNWK04xUktHWGd4UkEvZlpVZ1FlL3lnRDZ6T21F?=
 =?utf-8?B?SWpQTlprc1V5cml3OHlYeTlmTWM2ekpuTUpoTFNDRDBwUUlyNUllTHhwWGJl?=
 =?utf-8?B?NFJKVFA3SFFOcWxqbkdzU0k5VWtoSGw1NERrRytXTmVWTHA0enpleWZXZHht?=
 =?utf-8?B?bXVMZHNVR21QalhaSW45endVUUlWdTJnZnBXait4UVJJeUlKeWJ0N21aZk9p?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05543F117CF9764AA4CBCBB0C0B1E9E4@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 241bf861-d18e-4c45-94e1-08dc7fc18e4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 09:27:27.2169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c2u1pbLbkIb10gjrk7I/pzPSZj0eJ+CqVLjnmeJxnrRp58Tg5f8t4+yJSe2AcQCvjyE40S4agULmJWnDORrLJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9186

T24gV2VkLCAyMDI0LTA1LTI5IGF0IDA5OjUyICswODAwLCBKaW5nYm8gWHUgd3JvdGU6DQo+IEV4
dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+
IA0KPiANCj4gT24gNS8yOC8yNCAxMDoyMSBQTSwgUGV0ZXItSmFuIEdvb3R6ZW4gd3JvdGU6DQo+
ID4gT24gVHVlLCAyMDI0LTA1LTI4IGF0IDIxOjM1ICswODAwLCBKaW5nYm8gWHUgd3JvdGU6DQo+
ID4gPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2ht
ZW50cw0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IE9uIDUvMjgvMjQgNzo1OSBQTSwgTWlrbG9zIFN6
ZXJlZGkgd3JvdGU6DQo+ID4gPiA+IE9uIFR1ZSwgMjggTWF5IDIwMjQgYXQgMTA6NTIsIEppbmdi
byBYdQ0KPiA+ID4gPiA8amVmZmxleHVAbGludXguYWxpYmFiYS5jb20+DQo+ID4gPiA+IHdyb3Rl
Og0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEhpIFBldGVyLUphbiwNCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBUaGFua3MgZm9yIHRoZSBhbWF6aW5nIHdvcmsuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
SSdkIGp1c3QgbGlrZSB0byBrbm93IGlmIHlvdSBoYXZlIGFueSBwbGFuIG9mIG1ha2luZyBmaXEg
YW5kDQo+ID4gPiA+ID4gZmlxLQ0KPiA+ID4gPiA+ID4gbG9jaw0KPiA+ID4gPiA+IG1vcmUgc2Nh
bGFibGUsIGUuZy4gbWFrZSBmaXEgYSBwZXItQ1BVIHNvZnR3YXJlIHF1ZXVlPw0KPiA+ID4gPiAN
Cj4gPiA+ID4gRG9pbmcgYSBwZXItQ1BVIHF1ZXVlIGlzIG5vdCBuZWNlc3NhcmlseSBhIGdvb2Qg
aWRlYTogYXN5bmMNCj4gPiA+ID4gcmVxdWVzdHMNCj4gPiA+ID4gY291bGQgb3ZlcmxvYWQgb25l
IHF1ZXVlIHdoaWxlIG90aGVycyBhcmUgaWRsZS4NCj4gPiA+IA0KPiA+ID4gSXQgaXMgaW4gRlVT
RSBzY2VuYXJpb3MgKGluc3RlYWQgb2YgdmlydGlvZnMpLiBUaGVyZSdzIG5vIDE6MQ0KPiA+ID4g
bWFwcGluZw0KPiA+ID4gYmV0d2VlbiBDUFVzIGFuZCBkYWVtb24gdGhyZWFkcy7CoCBBbGwgcmVx
dWVzdHMgc3VibWl0dGVkIGZyb20gYWxsDQo+ID4gPiBDUFVzDQo+ID4gPiBhcmUgZW5xdWV1ZWQg
aW4gb25lIGdsb2JhbCBwZW5kaW5nIGxpc3QsIGFuZCBhbGwgZGFlbW9uIHRocmVhZHMNCj4gPiA+
IGZldGNoDQo+ID4gPiByZXF1ZXN0IHRvIGJlIHByb2Nlc3NlZCBmcm9tIHRoaXMgZ2xvYmFsIHBl
bmRpbmcgbGlzdC4NCj4gPiBWaXJ0aW9mc2QgYWxzbyB3b3JrcyBpbiB0aGlzIHRocmVhZCBwb29s
IG1hbm5lciB3aXRoIGEgZ2xvYmFsDQo+ID4gcGVuZGluZw0KPiA+IGxpc3QgYW5kIG1hbnkgZGFl
bW9uIHRocmVhZHMgZmV0Y2hpbmcgZnJvbSBzYWlkIGxpc3QuDQo+ID4gDQo+ID4gPiANCj4gPiA+
ID4gDQo+ID4gPiA+IE9uZSBpZGVhIGlzIHRvIGFsbG93IHJlcXVlc3QgdG8gZ28gdGhyb3VnaCBh
IHBlci1DUFUgZmFzdCBwYXRoDQo+ID4gPiA+IGlmDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiByZXNw
ZWN0aXZlIGxpc3RlbmVyIGlzIGlkbGUuwqAgT3RoZXJ3aXNlIHRoZSByZXF1ZXN0IHdvdWxkIGVu
dGVyDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBkZWZhdWx0IHNsb3cgcXVldWUsIHdoZXJlIGlkbGUg
bGlzdGVuZXJzIHdvdWxkIHBpY2sgcmVxdWVzdHMNCj4gPiA+ID4gKGxpa2UNCj4gPiA+ID4gdGhl
eSBkbyBub3cpLg0KPiA+ID4gDQo+ID4gPiBJIGd1ZXNzICJsaXN0ZW5lciIgcmVmZXJzIHRvIG9u
ZSB0aHJlYWQgb2YgZnVzZSBkYWVtb24uDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gV2hlbiBjb21p
bmcgdG8gdmlydGlvZnMgc2NlbmFyaW9zLCB0aGVyZSdzIDE6MSBtYXBwaW5nIGJldHdlZW4NCj4g
PiA+IENQVXMNCj4gPiA+IGFuZA0KPiA+ID4gaGFyZHdhcmUgcXVldWVzLsKgIFRoZSByZXF1ZXN0
cyB3aWxsIG9ubHkgYmUgcm91dGVkIHRvIHRoZSBoYXJkd2FyZQ0KPiA+ID4gcXVldWUNCj4gPiA+
IHRvIHdoaWNoIHRoZSBzdWJtaXR0ZXIgQ1BVIG1hcHMsIGFuZCB0aHVzIHRoZXJlJ3Mgbm8gbWVh
bmluZyBzdGlsbA0KPiA+ID4gbWFuYWdpbmcgcGVuZGluZyByZXF1ZXN0cyBpbiBvbmUgZ2xvYmFs
IHBlbmRpbmcgbGlzdC7CoCBJbiB0aGlzDQo+ID4gPiBjYXNlLA0KPiA+ID4gdGhlDQo+ID4gPiBw
ZXItQ1BVIHBlbmRpbmcgbGlzdCB0aGVvcmV0aWNhbGx5IGNhbiByZWR1Y2UgdGhlIGxvY2sgY29u
dGVudGlvbg0KPiA+ID4gb24NCj4gPiA+IHRoZQ0KPiA+ID4gZ2xvYmFsIHBlbmRpbmcgbGlzdC4N
Cj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBJIGd1ZXNzIHdlIGhhdmUgYW4gaW50ZXJuYWwgUkZDIG9u
IHBlci1DUFUgcGVuZGluZyBsaXN0IGZvcg0KPiA+ID4gdmlydGlvZnMuDQo+ID4gPiBMZXQgbWUg
c2VlIGlmIHRoaXMgcmVhbGx5IGltcHJvdmVzIHRoZSBwZXJmb3JtYW5jZSBmcm9tIHRlc3QuDQo+
ID4gSSBhbSBhIGJpdCBjb25mdXNlZCBhYm91dCB0aGUgc29mdHdhcmUgbGF5ZXJzIHdlIGFyZSB0
YWxraW5nIGFib3V0DQo+ID4gbm93Lg0KPiA+IFdlIGhhdmU6DQo+ID4gLSBGVVNFIGRyaXZlciAo
c28gdGhlIGtlcm5lbCBGVVNFIGZzIGRyaXZlcikNCj4gPiAtIHZpcnRpby1mcyBkcml2ZXINCj4g
PiAtIHZpcnRpb2ZzZCBhcyBhIHNvZnR3YXJlIHZpcnRpby1mcyBkZXZpY2UNCj4gPiAtIEhhcmR3
YXJlIHZpcnRpby1mcyBkZXZpY2UgaW1wbGVtZW50YXRpb25zIChlLmcuIEJsdWVGaWVsZCkNCj4g
PiAtIGxpYmZ1c2UgKGNvbm5lY3RpbmcgL2Rldi9mdXNlIGFuZCBhIEZTIGltcGxlbWVudGF0aW9u
KQ0KPiA+IC0gRmlsZSBzeXN0ZW1zIHRoYXQgYnVpbGQgdXBvbjogbGliZnVzZSwgdmlydGlvZnNk
IG9yIHNvbWUgaGFyZHdhcmUNCj4gPiB2aXJ0aW8tZnMgaW1wbGVtZW50YXRpb24NCj4gPiANCj4g
PiBTbyB5b3UgaGF2ZSBhIHBhdGNoIGF0IGhhbmQgdGhhdCBmaXhlcyB0aGlzIGZpcSBhbmQgZmlx
LT5sb2NrDQo+ID4gYm90dGxlbmVjaw0KPiA+IGluIHRoZSBGVVNFIGRyaXZlciwgY29ycmVjdD8g
SW4gdGhlIHZpcnRpby1mcyBkcml2ZXIgdGhlcmUgaXMgbm8NCj4gPiBwZW5kaW5nDQo+ID4gbGlz
dCwgaXQganVzdCBwb3BzIGZyb20gdGhlIHBlbmRpbmcgbGlzdCBvZiB0aGUgRlVTRSBkcml2ZXIu
DQo+IA0KPiBJIG1lYW4gZmlxLT5wZW5kaW5nIGxpc3QgKHN0cnVjdCBmdXNlX2lxdWV1ZSkgd2hl
biBJIHJlZmVyIHRvIHNvZnR3YXJlDQo+IHBlbmRpbmcgbGlzdC4NCj4gDQo+IF9fZnVzZV9yZXF1
ZXN0X3NlbmQNCj4gwqAgc3Bpbl9sb2NrKCZmaXEtPmxvY2spIDwtLSBsb2NrIGNvbnRlbnRpb24g
aWYgbXVsdGlwbGUgQ1BVcyBzdWJtaXQNCj4gSU9zDQo+IMKgIHF1ZXVlX3JlcXVlc3RfYW5kX3Vu
bG9jaw0KPiDCoMKgwqAgIyBlbnF1ZXVlIHJlcXVlc3QgdG8gZmlxLT5wZW5kaW5nIGxpc3QNCj4g
wqDCoMKgIGZpcS0+b3BzLT53YWtlX3BlbmRpbmdfYW5kX3VubG9jaygpLA0KPiDCoMKgwqAgaS5l
LiB2aXJ0aW9fZnNfd2FrZV9wZW5kaW5nX2FuZF91bmxvY2soKSBmb3IgdmlydGlvZnMNCj4gwqDC
oMKgwqDCoCAjIGZldGNoIG9uZSByZXF1ZXN0IGZyb20gZmlxLT5wZW5kaW5nIGxpc3QNCj4gwqDC
oMKgIHNwaW5fdW5sb2NrKCZmaXEtPmxvY2spDQo+IA0KPiBCb3RoIHRoZSByZWd1bGFyIC9kZXYv
ZnVzZSBpbnRlcmZhY2UgYW5kIHZpcnRpb2ZzIHVzZSAic3RydWN0DQo+IGZ1c2VfaXF1ZXVlIiBh
cyB0aGUgcGVuZGluZyBsaXN0Lg0KT2theSBJIHNlZSBub3cuDQpJIGFtIHZlcnkgZWFnZXIgdG8g
aGVhciB5b3VyIHJlc3VsdCwgdGFrZSBhIGxvb2sgYXQgdGhlIHBhdGNoIGFuZCBzZWUNCmhvdyBp
dCBldmFsdWF0ZXMgb24gb3VyIHN5c3RlbSA6KQ0KDQo+IA0KPiAtLQ0KPiBUaGFua3MsDQo+IEpp
bmdibw0KDQotIFBldGVyLUphbg0KDQo=
