Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6FC2D97A6
	for <virtualization@lists.linux.dev>; Wed,  9 Jul 2025 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066525; cv=fail; b=jBRZ/VdMQAQKFmVOnzTatR/4qROKA3siJ3GOZVhl5jaTvhus3u5m7M6V5R4A2A73eJdTH7O1DHptHkqYBzJ7KYiuPM9hBpGovNFiSiDe60H5SZyt1JjVxbaUIbx2AEk7TyWGBw+v02mFWZk48IkKVadcZ2SF3LoEFsCTgQxqSe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066525; c=relaxed/simple;
	bh=xen5U033J0DjUCveiNIgI/y7RfhZUpy1UcyPuKmiFEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J6g+Fj9PEprsORLkBlpyWDsxkVyZVq7bxLryWvKX2g/ut49me1SPTvKpY2GF+WCKqGhnl27HzNu7GIOQ7/+1YzVNrCgXtnW+Tm+S5NqD+piGy80bHGpC+daLtMkmSzyPCRQZCOcQThEmORQdAj8wOrSE2nohuvKEfYNdgr002r0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J68AStDb; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J68AStDb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmo+aD5/FRovk3PZGyonh3FiBkTNSxZqxEwwU+RDAF0PLQv0L8wm3Ro3OLEH7F0Ydsj75BDoBb3meT9jdT98APFrWxsvBNbAmtDb47p1tohDO71Ho+4JZ/ixBNnd5h22Cxu6/bvXa1bMY4a60GQi76dy53OAARJz79vjPoX2Q8q4E7bPIniL3MTb+7Jc1h6pi6D/SSUZ4hbuK9qtt1+Uh+9OAZ0nxxVB0J7pPTtTsbNMB82IEXtNAyH7JO6LqX5q8bjwUT1dOQ0MXP4oL56g8anyDnaqadvCEU9fNkt+DO2ruedVIhOGNcoQQGEXxmHcahQiLUM6rd3GrUAxkAIrYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSO80Inzv+J8i37ARPPqTlcsdxtyp4IIUGfsHoLTq4Q=;
 b=nHcC/YjwB4E0UkIoxUZ1DghbZtC1jnh5hWstK83KLO2zk4sgyQeZ3yoZL8wX+dITozfb0iZLqqsUCKfZwvZgMjKNAg7QxQ5SFwL/ph1Kim+7EoJlMmsSoIbDlbA7Zvx5kE7vSMNdQDiUtWs5Y7Vg+EOtPKJn2hZp3hZz5JNCpNsVjR7ktI5MsnXc60s+2gR3L5lcHC3OE7C2TRGrLQQBtvXaJ5+dvDTYM5QSeiuKAtB3oMwCoSHO2r5s7lCHi4ClGobATQwxL3BX3S/rNe2LPpQKKkjHQ9ymZKXl2BBkUxl1UJmKBJYZdAFeOiVte15/nW+CFr06F8vIf3AndNR9iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSO80Inzv+J8i37ARPPqTlcsdxtyp4IIUGfsHoLTq4Q=;
 b=J68AStDbBOnuYrMYYbCV56wGnNWKIj5U42G+bsL65i8c0oONgM4YmvJfmQpEiCpo9SCDD8MZVp/fIx9K1WJe0bIUwqvnhfsm06BXbbi2pMCYTeo11waHK+Z7xr5xC69yEdYGfUyIsDVPC4OXWUeTz2/nmVt4Pc35IXCTliaEcyQllKgzSjDcPt/9Hc2JUAdiGOsSf5jEDt7EqiWY2Di9XCJvGEPa88pk8S3/zDQZnTsBkPO0mVeafBMmczcOIQmjakMv5Ttl0BtBo/Xs3jlhLWbVjWgqanvKQvz9dWUr8Q7Gu8XGftnomDVlWs8NerNb0W90yJuLqNoB7RPMfIpv5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 13:08:37 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 13:08:37 +0000
Date: Wed, 9 Jul 2025 13:08:06 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Wenli Quan <wquan@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, virtualization@lists.linux.dev
Subject: Re: Host Crash when re-running vDPA device creation script after
 interruption
Message-ID: <w5oshdtp3wdhydjmh6htwtgb6keyml2teft7ihu277tbktzbp6@mweh7pyfwlrl>
References: <CADZSLS0zp9rqP2=vCh8eHVH_U+g+k_8pitV939u9Ls8ZPEMfJQ@mail.gmail.com>
 <zfddiyxykxaoev4wbaxh6ml6czew44k5mt4jsxylpbybnqbs6y@rcfi5dpy5qv4>
 <CADZSLS1KPX6rgCkdDPqqyYC-R3oBWDGb8o26QQXaG5U4R=8zzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADZSLS1KPX6rgCkdDPqqyYC-R3oBWDGb8o26QQXaG5U4R=8zzA@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b8fd7e-e21e-40ea-5df0-08ddbee9b728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1JYa2J5a1NpRFNicGszRXJxeXBTbDQ3RGF6Zm1lUnJWL3lTRE5PNDN0Z0NX?=
 =?utf-8?B?Mm1KM1U4OUlyRGw3NGhlQXJCR0UzMVY5T1d0OG5kODkrYjd5NDNqMkJkR0hT?=
 =?utf-8?B?Q2FsZlhISkw2d2p0eGNPYWl3dVpSU3ZhUFhPbUNhQnBkZWg4NzAwaWRqK0dy?=
 =?utf-8?B?NmliTGtsVUJFM3lpeDc5MHhubXBvK1dYUlRocEJNZjlBUFEvVWxpTHJxdS81?=
 =?utf-8?B?RmQvb1pxaHI5T3J5OVE1YTZwRVR2ZzQ1Y09YS0JyQnZHMGl6NHE2UjMrdHEw?=
 =?utf-8?B?M1Qwekh1MFVBcnM5cXhKdCs5SVhyQTlSbHB4bUdldVkvRzFSanhpZXdObTdE?=
 =?utf-8?B?T2pjYkF1ZG1IMmVCYlJxVE5peUN5THdCeDhOajVTUXIxeEM4OSszZC9CaENn?=
 =?utf-8?B?dExQT0dWcDd4WCszdVUvUFJiVUxLYUxXU0hUOHpPTisvVlJHTzh5aHdMWTdx?=
 =?utf-8?B?MDFmSWVPOGlJUnIxTjNuK1VramhWN2F2L2hYbXpLNTRuNXBuZXBtQ0xtZEV2?=
 =?utf-8?B?WFhyaUg2UmFhR1VENlAxU3FqWERtMUlYTzNHZ2U0TEthTkRhUHpMUk00NGNm?=
 =?utf-8?B?bXRVNTE0N2xodVMzbEFzelQ5SUMrbjVnTjBwUFpTOE41N01uK1pFczZWM0VR?=
 =?utf-8?B?ZVdXK1RtUXV3MnJDdWpMNWhWR3I2Vi9PZzJXUlpwOFNEbGg5VjhVa1lmZDVI?=
 =?utf-8?B?RXk5UkNuSFpld09vb0lZNEpINTIzRGMzRUpCRGZYaXJVUlZmNFdrRHJuMGl6?=
 =?utf-8?B?eTZYWlFXRG9KWFAzRUNPYTFhVTczY0JhZFF6K3V5am93Qmh4bEVjY3FxZVpS?=
 =?utf-8?B?ZnBDYkp3NFJMUVJ5aUdYbnp1clVURlFNN0lrWXBSb3V0RS9udXBUUnVpaFhs?=
 =?utf-8?B?NU12RnFLdENDUkRGeXdlNnQ5eFE2ZWFHSmlCSGFBbFE2c09UdUZuYjJ5S3M0?=
 =?utf-8?B?MFB2QjVoeFFqOUVhVlBUa3ZoOVUvTm81dGRXbTlsajRsZzE4Tk1TckIwQjhu?=
 =?utf-8?B?ckRBcXVaeTlpek45ZXU2R3QzU3JLazRzZjg4ZlgxZjM0VElNbnBIU0NzWmVF?=
 =?utf-8?B?TlB6N1lnSXRReks1KzA1ajVDTkJNTXNwR0d5WThBblRvUXNJcmlJaXo2REhD?=
 =?utf-8?B?ZDZ1VUM1ZFVHdUFFMnNBZzlpTmNKV3JmTXUvT1BJUjBZb1RDNnBMbytZbmI5?=
 =?utf-8?B?MS94czZnWlh3aklCdE5Hd1NLeHNteUY2SEtHaTNQZGplUll2ZGNvN1l0VDZ3?=
 =?utf-8?B?OGZOekRWS1I2MEE3V21xdjVmSzQrSWJNL0RiK1AwclBnaEdSQWFxOU4yR1Y1?=
 =?utf-8?B?VFhRQ2M1Tk83QzJ0VXIyYnJNNUZvOHhtSnVQWndFdUY4QVY1bmJCMFJGMFd5?=
 =?utf-8?B?bXd0d3JMUUhCeEw0MG0xalJsdnRiTVNxck04WS96SXVyMUU1MzZrV1RvNG84?=
 =?utf-8?B?YzY4UDJKcmhicEVJWno0SUY0cTZTNTI1bk10QWkrSi9QNEdQOEtnSlBHek9Q?=
 =?utf-8?B?N2M1NW9pb05EUmJPYUxRb1pZWjVRNWNDYmY1OGxwdm4rQUYyY3lLWmc3MlZz?=
 =?utf-8?B?aTI5dnIvS3RIbW5DWlkzblNqMGc1RnhUc0JhekNYeDVHQlRzYWwxZHJoRUty?=
 =?utf-8?B?S2JyMFRCbWNoQzk5TWRCZEFGbXJ4NVkySEV3c2VMbkpJQWRhQ2RaUlhOU1hs?=
 =?utf-8?B?UkFYaXlMZDJLSi9oZEFhYVhJNWZtMnE5UldpRFkwdmRhckRLOTRWbzlzYnhG?=
 =?utf-8?B?eG1tTk9DcWh5QzE2ajJMNUhqZDRHaHdkemFCdm9KZ0txYlA2M0h2RkN0Ujl0?=
 =?utf-8?B?c0tacEFUNTluUDNSeUdaeExaZnlZRGJYUzhpT0pqL0pPNEZpSWE0Y1g4MFVm?=
 =?utf-8?B?eERJaHU1S0l2S2JJVC9TdGlqQjZlVTN2Rkh6eTB6dEZsaERwSGRkN3hUdWx1?=
 =?utf-8?Q?p5vGwde+f6U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHRVcllnZmJ1cm84VlFVbmxkUStRUmhxbHFKT0JCS0pkNTlMODg0MnFqamRm?=
 =?utf-8?B?RVMxZElvbUU5cjZ5endKaVZtTDkza01YMTlKU0phekw5N25wNDExQjZMekNL?=
 =?utf-8?B?NzRoVktxbFB3ZE5BZjFmWHI2WTcwU0RucWx3ZmlsTkVLS2pINjF1K0pLZUY2?=
 =?utf-8?B?Z2M3anoxR2FYaUZnOXFoVzlrTUptY0dGNWh4NnhHVTJrWDRZalJDS3h6U0w1?=
 =?utf-8?B?dHNlSzU1UHNRYmppUXRETVJldWhFd3dzY0RMdlFkcFEvZ3RoZHRyTzFRZzJZ?=
 =?utf-8?B?TFZBYzlVYjNFcGVDaHk4Wm1aRjFESnB5WnpXUEdMbnVHTXBMa21oLzdXbUt3?=
 =?utf-8?B?OVg5dWVaQVg5S3JsZThobmZZTkViZ0VJRjdkN2Nkc1NiRGg0VWpXelJ4Q0JN?=
 =?utf-8?B?RWdaMndHd2h0Z0N1aUJSSXd1RWlCRWpncHBXZE1aKzV3T0xSZlp1RWtSQnVL?=
 =?utf-8?B?di9GS0JTYnJpWGpjTWtySWNLY2xHQnlTZHdrWktaUFZDZUYvUkNWUllNaGd2?=
 =?utf-8?B?cWVNS2NWU1RhNGJ0SmFOSkhZUmZheWFIamJDSDRMSjBGZHVheXYvQUs4U00x?=
 =?utf-8?B?T0lrM0J5UHR4VDhmVCtiZ3ErVnFuSTIxaWVySVlHa3VKMkM1d1ZWY2k3dS9r?=
 =?utf-8?B?SWlnbHFxU1V4Z0JSMTFIWlVnWjJwaUJUZUhhQkRpT2lBNW53RDJwK2hLSnpu?=
 =?utf-8?B?RmJLalIzT1p3R1RTOGNVdUFocFROZXo1WEkweWovQ1BlVktzMzVncEZoKzFD?=
 =?utf-8?B?Y0JPMUNqbHN1Z2kwckdrQm5IRitWRHd1dTNxeGpHMWxzVFVURFVHUVR5Y1VC?=
 =?utf-8?B?MnErM1NSVEVNRTRHTUNJQndUVVl4OFRFMmhJQjBtSmhoV25yeEErb2sxeFRx?=
 =?utf-8?B?cmN0aEZ4S1UxOHE5V1RqcXBJdXhEN21oejVtUys3YXllak1EKzQxc1ZOZTY1?=
 =?utf-8?B?Q1I2dVE3VDFES2VRV3FRMnFZV1I2U0poR3RCL1B0eFJyUjMyRmdReXdPTStk?=
 =?utf-8?B?WTM3WEp2ZEVUSWE2Z0kyWEVuMFNMeTFrbm0yRmpLUy9oK0lCUmZ0OXpZMHBo?=
 =?utf-8?B?ZFV6UGFmemM0aGJMeUVBdEpiY2cxaTBZZ2ZNSitBSEtSS3JOYWVoRm1kVU1T?=
 =?utf-8?B?d2IyYjdtS0tXUkd1YStoc1B6SzZwSzZLdXFqUk1tTWQ5NmsybVZGbnNNWFFH?=
 =?utf-8?B?THo3eHN0YWFtbnQxU1FQQzBQaStURWNKZmcrUTVZYUI0UjNWaEJQV1gzdHpa?=
 =?utf-8?B?Zk1aS1pBK0RnTDVOVzlWdTUwZS9QZ2hSWmhQNHRkdmthakd6N0lJOW1CVWNW?=
 =?utf-8?B?ajdhSk9HekxuUU4wYkhueldUcURxcThOSU5VSUF1M0kyYUM1aUdMdUl6azNE?=
 =?utf-8?B?YXBPYzZSZ1ZFQ2FycVJsTVhYVzRySkV1U0N5ZFp5ZHAxb3ordHM3bXZFbWEr?=
 =?utf-8?B?YloycHRaUnd0YmF6MkJNZ1loQy9lYzF6ZEJsblErSWl3TTIvT1M2ZDg5aEVB?=
 =?utf-8?B?T0xMV1c4RGdRWUN2T0JvTVdscXFUSGJIb21hdmJtVUVqMllYc2NSL2VrWFpz?=
 =?utf-8?B?eVBpckx6SFFmMXV1clArL3ovYkRzeFRGbStmeFFOMzNYaXI2Qk5zUWROVFlj?=
 =?utf-8?B?RVdPMTByMFZoQ0tQcmhhMkZ4RC9OVk5sTS95MzN5VHRGZjV2bHpkWTVtYkR2?=
 =?utf-8?B?TWhBWXlCNG9BWWhXU3FtelJwQ24vTHVjUnRBdWhBaDRqYVl6ODRGSjJNZXlN?=
 =?utf-8?B?ZTVNVHNXdnMxWHVxTWV2R2x3SGpOL0FrWDd6T05tb090d2NoeFF0aW9aRWpz?=
 =?utf-8?B?V05GQTEweERNM0d0U0hkL2J2ZWVBTFlzdUdHNUt6RnRKY3FGbnF2b2pES3dk?=
 =?utf-8?B?YUJ2REN1NktUeHQ3dVdzOTlINkMvS1o5Q0VROUJvN2E0SlVoZUVVZW10cG0v?=
 =?utf-8?B?QVplQVlDdnEwSjRSQm9rTHMvek5HNFRMRHY5WVh5VnBGRUN2K0k0dFRzWmVG?=
 =?utf-8?B?M2ZCZWpqQmwvY29SNUdNZENIZXB4cWlFdGhPb0xPOHZBUytuVnZIUVcwM3J5?=
 =?utf-8?B?NGhxY2lXUTBBMklKN0M4Y3FON1dTUkFUb1dVa01pZklHbGJzVnk0eXdQZHFJ?=
 =?utf-8?Q?2RWCvIM9Pn8hOQ+EKMb2hyiLr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b8fd7e-e21e-40ea-5df0-08ddbee9b728
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 13:08:36.9444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdmlY1BwjLNAeW362sYq4yjVUXzm+vaSGEc8cAwKw28WcWgVn3pWvAM94d9SYc/AGGdrE9EK7qHQY8PGteWBiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149

On Wed, Jul 09, 2025 at 08:59:13PM +0800, Wenli Quan wrote:
> On Wed, Jul 9, 2025 at 6:38 PM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> >
> > On Wed, Jul 09, 2025 at 05:36:04PM +0800, Wenli Quan wrote:
> > > I am reporting an issue where the host system crashes when re-running
> > > a script that creates a vDPA device after interrupting its previous
> > > execution. I am attaching the script for your analysis, as I am unsure
> > > of the exact step causing the crash.
> > >
> > Thanks for catching this Wenli. We'll look into it.
> >
> > > # uname -r
> > > 6.16.0-rc2
> > > # sh vdpa-setup.sh  0000:b5:00.1 1
> > > interrupted by pressing Ctrl+C
> > Could you specify during which stage of the script do you interrupt it?
> 
> Interrupted after running for a few seconds.
>
I was not yet able to reproduce the issue.

Could you print out the commands of the debug script so that we can see
where it was interrupted? set -x should be enough.

> I encountered the same crash on both the 6.16.0-rc2 kernel and the one
> with the "[PATCH vhost] vdpa/mlx5: Fix release of uninitialized
> resources on error path" applied.
>
Right. This is another issue that is coming from mlx5_core.

Thanks,
Dragos
 
