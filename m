Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E1D2B9AB
	for <virtualization@lists.linux-foundation.org>; Wed, 19 Jun 2024 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788489; cv=fail; b=ikPGj2aQFbmW31Ja6UKFzHoLlt5Wvj59gXSDtI+RIfY2o8899zOod7goipbr1Z62EVj27d/W2W7WDcUhWFd7s6c6f0UgdDA/uVrq+UYHXYlCz2M35RF4yf5lXvY3NNI1osPgdiF5Ljq1yB7NdG1QD+dLJ/lP21uIACN+hMAgHBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788489; c=relaxed/simple;
	bh=xI7OkHian5w0PhD9PraS9eWb7gqZfR4rjMLGpiaWQRI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n2YaNdZjPfCKcfJKZbkk0fMJ8mUXYRHBOsM78VqhGvU9yHtiE4oj17NnkzqIzJs4mjGhwd7TZpXSzFf4pkKL/4gQ/OMfas9MDVfM51a4KRo1coZguwalVFnxAcOyoCoqMoyXf3J1A6A859Ob4KNRGR6UJ5ewmocx6veHIQX2YIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qhzPMPHX; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qhzPMPHX"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB7E2409A6
	for <virtualization@lists.linux-foundation.org>; Wed, 19 Jun 2024 09:14:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GEpBdZ07rDY6 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jun 2024 09:14:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2009::600; helo=nam10-bn7-obe.outbound.protection.outlook.com; envelope-from=dtatulea@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 198544060A
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 198544060A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qhzPMPHX
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20600.outbound.protection.outlook.com [IPv6:2a01:111:f403:2009::600])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 198544060A
	for <virtualization@lists.linux-foundation.org>; Wed, 19 Jun 2024 09:14:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvRxkES9OZJduBC7NcPcLMPRu5BVbLCyCW8gbBZbNHO8e2GJxwysvkhJapX0B2vhNmt5PhrkubPJup7iJpG0gx8/6FlA4qb4Rh1ZRh7gUdku2JQDYBrmicxMPCPbkFn1vGJbdqBVCXxK2mwO3U6WRxciSpmVn5rsY35z+H3HVN/rw65aXA7nn/ReIPXaKj+RKeNVdTuthavmrgLP0mTD6OdA8+r09Gy24d2bNOSA58SsWewrfIFqPaSDK3sL3OE7cSL+4S9OrILreQgEKaHGd2QedcStIA7ubvzwoU9GFYalJBNBhuGFsT/rixuQ2QB2DAM7svA8we/c01LYOljHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xI7OkHian5w0PhD9PraS9eWb7gqZfR4rjMLGpiaWQRI=;
 b=nNkjTCxpKvOKT170DR9En7cirvpv4m0NCwHjEWuS3ccwNTaeALrY+dKEyiSRJhpt2ChGipGyx03kxwZTUtwDRvdhvUz4+32Qr37XZo+fktpYUeah7SNs8lQDATJf3RrcUDzqjHfQ1BgjlWzzr2JZ+8LK+mrgRpA5DxsCaH0uA62WaIdoqHnp0gpdhqSLLv+T9/GIXxfZ2KO9rj7edbTtlM35az1KbMaB6WLRlFq4b3I9ba9DvFNwBMG6Gdb5x89QiexdiV9Zgkup3kO98Qrmr+XyprbxTONPHJzR1+OHBjwnNiR3LlLXg+m/picONUuSH1RezMr6vk4FOZwLLNsmZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xI7OkHian5w0PhD9PraS9eWb7gqZfR4rjMLGpiaWQRI=;
 b=qhzPMPHXRKILiTRjtdvoOJzG/mXOHDxSk2ea/4vvgSNCrXcB0X+Dng6Q2CCE8dCvOwkoCIAtJqRyL7kjNQ2z+9TW4uHlCtvu2o8shUsxgpRPFKomdpFp2LLollOpmQFAYybbPkAGh+2TEtt9nWORq7g4y9em34uPbRr8LGNbRt+t1LIAyB/IE21eP01DxOAtLWAvKFdL1TLGUVzmfkmeN01MDqrAI6jmIjtMjV1lIOrWrRtPsk3LJ3DnWBEpfiVrAG127pLVY/WpaApMWy+6KMlryKcpiM0YPklqaS9a5PoZOLw5nA1KdHhuysr+zWTM/o2QhPSzcPPktYTsBfwF3A==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 09:14:42 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1%6]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 09:14:42 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "kevin.tian@intel.com" <kevin.tian@intel.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>
CC: "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "mst@redhat.com"
	<mst@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"peterx@redhat.com" <peterx@redhat.com>
Subject: Re: mmap_assert_write_locked warnings during for vhost_vdpa_fault
Thread-Topic: mmap_assert_write_locked warnings during for vhost_vdpa_fault
Thread-Index: AQHawM4JG3EWc9K+OkqSlWAI6+YdgLHMuROAgAAMyACAAAoKAIACALkA
Date: Wed, 19 Jun 2024 09:14:41 +0000
Message-ID: <8e540d6f7936852543957970797012ddb351d64d.camel@nvidia.com>
References: <11b31b8372331256a66594ebc62fe322098d2b4e.camel@nvidia.com>
	 <CACGkMEvtgChCeyWon87sqpN0cY6TQpb1Y7iVxbDuupgbYiEUpQ@mail.gmail.com>
	 <BN9PR11MB52768C001E84D048B12F8FE88CCE2@BN9PR11MB5276.namprd11.prod.outlook.com>
	 <CACGkMEtQ75NZqoYFTRB5gP81ZHpYAxPPCTiL5+kT_yRiyr138A@mail.gmail.com>
In-Reply-To:
 <CACGkMEtQ75NZqoYFTRB5gP81ZHpYAxPPCTiL5+kT_yRiyr138A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.2 (3.52.2-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|SA1PR12MB6971:EE_
x-ms-office365-filtering-correlation-id: 0cc2ee8d-4e51-4d31-6d8c-08dc904040d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?TGNzNlNpdDlXYzlibVBNemdTTmN6ck8wT25aK0JMbGtPTjFRb08xam1sMk9G?=
 =?utf-8?B?UXMwRzNhTGw1NS9EaElkcEJVSEYxNzVBL3plTjN4UTJoM1d6OE9TY3pxdjE0?=
 =?utf-8?B?Rm9wWmczQkdpcmlvcUxBaDVYNnZONktSVHlNc1NvNHc4cGpUSm9vYTNjejRz?=
 =?utf-8?B?cUlXempuL0VYVFVxc3ZqUWYzVjhCLzRLMVdtbjFLRDRZSlFsejh6TmdyR2M5?=
 =?utf-8?B?UXJ1TE56WVh3bjJnNTlkY0Z5SHZsWkVBQS8wL093MlMzYTA1SFZ5WHVMa214?=
 =?utf-8?B?TDZpM1kwbENPOVZudHhvck1LdHNWQzVGTHVoNHovcUk0NFBCTWNucVVBU1Za?=
 =?utf-8?B?T0xqVlV0U2NLZTRGUGFNN0NTM0pvVzF4dVdVMXFlUkxJRHI4UEVQS1A2QVJp?=
 =?utf-8?B?SFZ5MHZlWHcreVllcTlwRmhjYmVya0N0dXRoZEpGOUsyOXNPZ21yaTdPVlgw?=
 =?utf-8?B?Z2JPa0M4UjRJdWxlU1o2RkNMZUFBYStucXZLaURTUHd1bzg4STNKS01nL1Ra?=
 =?utf-8?B?Z1phdHlhb2VNanZHNVpCdXdOSldjMXhtYURISnNaT2tEWGxBbmRUaE1COUtp?=
 =?utf-8?B?TjBpNEVra2RHL3YyRldsU1d6WTFYUFcvaVBWT2FxVHdnZnNpNTNnaFBpMzA4?=
 =?utf-8?B?RVJ0MzNhYzBFTFNYb0dHRjEreVNJZlZ6Nnc2bHBQc04wTFJXc1phVnVxaEQy?=
 =?utf-8?B?dWYvUEpmTzNQaUlqdndleS9ONGs5UDUrb2tmTTMrVHdnb0drMXZGWUFNalli?=
 =?utf-8?B?T0VPNkFBN2tISG11d1hKUzkyWjRra1YzN2hWWWthbENNL3gremYzUHRvZndj?=
 =?utf-8?B?cy9ObVBJaHhHK1AycU5BRHIrT3FnbDBxMDFaOFNUVmxsSGFsOFdNSm5kS0V4?=
 =?utf-8?B?Ulh5Qm9GWlNLSG1PQ1hKajZHWDF1ZVB0ZDVXd2RLcnFXbU9NTjU2VHpxbWpt?=
 =?utf-8?B?amIyQWdJRGVOWlNUTnM5WVJoT1ViK3VpS1QzMzkza09iVjIvTC9JclR3VGRa?=
 =?utf-8?B?U3d2ZS9mOURtRXQ1Zzd4OWZCN3VQa0N0S3hVSlMxNXdadkhRTmtYZTRRUzhw?=
 =?utf-8?B?RlZ0aEt0Y2xSc1FrUzhkZllqcDZUMkRpTHk5QXRqNjVUTm5ESXpTY29Ja0M1?=
 =?utf-8?B?SzVja2tzbUUreEQ3c1o4aXFTL0xKd0RrSDRZdGtTVUZyOTNUc3oveEVlMzh3?=
 =?utf-8?B?bEJXejRaZmFiNUl0bVlMdjdKbmdVZWh4VzZPNzM2S0FhOUo5bVVicmdYV0cy?=
 =?utf-8?B?d0d1U2VDMU5SYUZDYXVhN04vdERwWFYraDZqK1k1Q05rY1dEakRhcVFFUEdv?=
 =?utf-8?B?WHFCWVAvM3VWNmgxTGcyejA2NFpid1dXQWRNaW5XVmlKNHk0SGQ2QnRUZS93?=
 =?utf-8?B?anZ3dSswUktkN0xOYXRGTEVqRzVsTktjVTE5N01VWiszWS9QejVyQzhPdmJN?=
 =?utf-8?B?M3hvcEN0dHFxM3Q5eS81QzVUTlgxcUhtYlQvOGFLUTJpMmdCSGYvNGQzRFVa?=
 =?utf-8?B?R3UxOXNQaWc4OXIrbng0Z2hVOTYxK2tIZmVUK0lBdmZmT29hR1BUSndhSzZv?=
 =?utf-8?B?cE9pT3NGNVRDVUl3bU43bys0V2phb01ReUlRaUFUczkzaEJoQ3dqMlJOU2wz?=
 =?utf-8?B?NkY3YUFwZE9yOXpmSXhwWC9jdndFTlFkem80SUtjT3pDNGJubDVIUHZDNTh5?=
 =?utf-8?B?SVJ5dVM0KzUwRnJxaWc5azdBQldXUEtZbTFJSWg3TnZxL3Z6L1k1T25xd1pw?=
 =?utf-8?Q?5B4nsa0YNBl1Xi61s2Cv6djPq9zkUZRmE8dRi6S?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2NZVUQ3K3JwMzZXd2tINVh0Z0wrOURsMFJxZE1vck9vdkZaaTN3ZjNxc0dY?=
 =?utf-8?B?UlRuOStGYUlMaHAvZ1VwTGl6T3NJODBOa2pIVU1XWU1TWFJrZFcyc3Z0UGNH?=
 =?utf-8?B?QitEeHB4WG1zNHBjUkI3STJBcnJ6aGhtVGlZZ0U0U3NKejIzU200QWw0RGQ3?=
 =?utf-8?B?MkFwWnBJUUdpY1hYTUwwUDR2em9zSlNIRUpNVnNPZVlrUE5vbnMrakpCTFZV?=
 =?utf-8?B?ZFdoOWZ2TU1GRVRxbURQcDVKZjY5N2JObnpmbml0K0xRWUdBQXQ0bDZZcG14?=
 =?utf-8?B?SXJvanNxSGg5Qk1rU1AyT29mbFNBdFlqbitFUExyYUdQKy9Yd2lPc3N0dEdY?=
 =?utf-8?B?OEx1NEhMc0RUSFp2Rjl4RXk3bG5hckJBeHYyRmZkeXZnZVUrSnBjZElEVkRQ?=
 =?utf-8?B?MUQ5UE1CeHFyUzJTaU4rMGFFTWNjL1R4R3hKR0lTc0w3UmIyMjVOQTBSakhp?=
 =?utf-8?B?a21yM0xmb0FXUDM0RnRPelV4WGxiaU8wZUxERkdGZUlvZExxa3JYNjVHcWFi?=
 =?utf-8?B?c2lRc045a0E1ZFBtUnRRSE14ZEVGcmh5R0xXSm8rUC9mSDR6UDlMYWk4cC9O?=
 =?utf-8?B?TWEwaDNXNCt1WWhJSmlidXVRSEZkZWRJRDFSbmNNb29qbklvRy9VQUNCamk5?=
 =?utf-8?B?UFYyYnBNSlp0eDZvV3RObENOUExwK3NuZnk3cnd6ZXdGR3NoYzFtRXBUVlVw?=
 =?utf-8?B?Y0V4UFR3ZnRBcU1EVFFrL2lpM0lHMnAveXhEWVNIK0ozb1o3UFZpWWNzL1hi?=
 =?utf-8?B?a01qVUxsUVBEaXJUeFFjOXhBMGpRYnMxVGkzNmR1eGRxVHBDVi82ejFEcjNJ?=
 =?utf-8?B?ajJYS0orWGduNWRBQThETDF4bFVRb2RyQmJDeE5QaThic0YyWjNLenB2NCt1?=
 =?utf-8?B?azQ3RVMzM1VReVNLRTB5NXFTalJseEwwdkdnY3plNWxWTmF1QTRvMnZJNGpC?=
 =?utf-8?B?bXBpMEtxOXlxMFBtVHpHdWNPUVVhTlVUaFY2ak9Xb1FSaUx6MFp2cTNETldx?=
 =?utf-8?B?bEpEZDFXbEttdURTNE5NeE5NUENRYWdndUdUYlgxSzdROEI4Z0hibjIvTlVC?=
 =?utf-8?B?MCt5ZUR3RjRiQk4wTVJuVW84dWFFU1o1bTJJUzdUMWRmd1E5VFVnZDBTZ3pM?=
 =?utf-8?B?Mk5YNXVWYzNxZ0RWR0JJL3pSakVLdDdwYWJVOGd0Vld5WFpGQmp6RzZ2UEtm?=
 =?utf-8?B?d3ZDdkx2aGZoSDVSbmlQRUhuUXF2YWgrZXd3WjRjb2NhNlptVGZzeW9qanVP?=
 =?utf-8?B?TGZXRnRJZkUwdzdrRkR2VExSbWRXRzJ2MHZ2TzhDWFlHUXFiQW5VNEV3Lzdk?=
 =?utf-8?B?bzY0UTJiTkJ0TDgxSFV0amd2Ui9ORm9iMTVGeG5hWWlRQjdCMlkvMUF5enV3?=
 =?utf-8?B?dGxDWlQ2WlB5SzJMQjZpd0FZUE1QYkFvM05vUnNxd1dVSFYxMWZEMDQ1dVEw?=
 =?utf-8?B?dEt3YzRyOHhyYm1kak4rWGVCelJDdEFQY1A0ZnhGenByVWlUSUlBakErdThV?=
 =?utf-8?B?TEZMWGhsMmpGcU9INFc2L3ZicEJwT0lSbDBmT21RYitOYlFGelpETjdIWTNO?=
 =?utf-8?B?Ui9zSzhTWXBPamxqSGpFUW00dGpodXMwdHM4S2dDYzNObnBiZlFJUWpnemJ4?=
 =?utf-8?B?OXJXWFVHL1hKZVBHMG5Uay95MDJZSUJVdW42ZSs5ZEZRdGQ0Z01Od2t2MStt?=
 =?utf-8?B?REdmTmp5cHBYR3NvUDljeTVWdWpiZHVITnI5MmkwamJFZVFtM1hoRVJsL1dO?=
 =?utf-8?B?YzBBMnZhd01uQWRqUVY2L0tXNlJxS2c0dEY1Tld1UnRzQ1pHQnRVWE9md0pk?=
 =?utf-8?B?N1pYeC9pQjFlNGpIeXNFWks0YmRnd3VUOE9qM2k1Z2RZT3FqcnVYWEx1cHJ5?=
 =?utf-8?B?REY3WWRLcUgzVU54UHk1UFZGQkdJOUF0WGhOZzlMekdYMUxybVY5TUNud1V1?=
 =?utf-8?B?M01TbE4xVzViVDR0Z3Jud3oycTZKM3dJd1VCMU83dExkaHhVWWp1ZURKZ01s?=
 =?utf-8?B?UmJYK01UTmV3TXBubGtvQnRkZzlZbENCRHY1YmNVY0Rkcm93VWxlL0xkTnJk?=
 =?utf-8?B?VVBLVXQyZmhsSzRRUStUeFpKdXZTbkovRk1uNlVIZXdQb2NYK2NVTUVYVHBt?=
 =?utf-8?B?VGNteVFkZ1VuUDNlM0srUEhmV1JYNk1ianRnazRZQTdaNk1MTTBPa0pxY2xR?=
 =?utf-8?Q?voUHc7nujzEvrxjxV/guJaW+21A0gofxmcwnUOMwQqHk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E784DF2037121A44BC7809CCD4FA28A2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc2ee8d-4e51-4d31-6d8c-08dc904040d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 09:14:41.9492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lFt8VRnbGGF1cm7AajfoXWWLaLqzXfFdKm8p7EiegPFM6A08menf450LpI+E1BE2k2zucd4nMm4+yMM1KWCvQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971

T24gVHVlLCAyMDI0LTA2LTE4IGF0IDEwOjM5ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOg0KPiBP
biBUdWUsIEp1biAxOCwgMjAyNCBhdCAxMDowM+KAr0FNIFRpYW4sIEtldmluIDxrZXZpbi50aWFu
QGludGVsLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gPiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tPg0KPiA+ID4gU2VudDogVHVlc2RheSwgSnVuZSAxOCwgMjAyNCA5OjE4IEFN
DQo+ID4gPiANCj4gPiA+IE9uIE1vbiwgSnVuIDE3LCAyMDI0IGF0IDExOjUx4oCvUE0gRHJhZ29z
IFRhdHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4gDQo+
ID4gPiA+IEhpLA0KPiA+ID4gPiANCj4gPiA+ID4gQWZ0ZXIgY29tbWl0IGJhMTY4YjUyYmY4ZSAi
bW06IHVzZSByd3NlbSBhc3NlcnRpb24gbWFjcm9zIGZvcg0KPiA+ID4gPiBtbWFwX2xvY2siKSB3
YXMgc3VibWl0dGVkLCB3ZSBzdGFydGVkIGdldHRpbmcgYSBsb3Qgb2YgdGhlDQo+ID4gPiA+IGZv
bGxvd2luZyB3YXJuaW5ncyBhYm91dCBhIG1pc3NpbmcgbW1hcCB3cml0ZSBsb2NrIGR1cmluZyBW
TSBib290Og0KPiA+ID4gPiANCj4gPiA+ID4gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0t
LS0tLS0tDQo+ID4gPiA+IFdBUk5JTkc6IENQVTogMSBQSUQ6IDU4NjMzIGF0IGluY2x1ZGUvbGlu
dXgvcndzZW0uaDo4NQ0KPiA+ID4gPiB0cmFja19wZm5fcmVtYXArMHgxMmIvMHgxMzANCj4gPiA+
ID4gTW9kdWxlcyBsaW5rZWQgaW46IGFjdF9taXJyZWQgYWN0X3NrYmVkaXQgdmhvc3RfdmRwYSBj
bHNfbWF0Y2hhbGwNCj4gPiA+ID4gbmZuZXRsaW5rX2N0dGltZW91dCBhY3RfZ2FjdCBjbHNfZmxv
d2VyIHNjaF9pbmdyZXNzIG1seDVfdmRwYSB2cmluZ2ggdmRwYQ0KPiA+ID4gPiBvcGVudnN3aXRj
aCBuc2ggdmhvc3RfbmV0IHZob3N0IHZob3N0X2lvdGxiIHRhcCBpcDZ0YWJsZV9tYW5nbGUNCj4g
PiA+IGlwNnRhYmxlX25hdA0KPiA+ID4gPiBpcHRhYmxlX21hbmdsZSBuZl90YWJsZXMgaXA2dGFi
bGVfZmlsdGVyIGlwNl90YWJsZXMgeHRfY29ubnRyYWNrDQo+ID4gPiB4dF9NQVNRVUVSQURFDQo+
ID4gPiA+IG5mX2Nvbm50cmFja19uZXRsaW5rIG5mbmV0bGluayB4dF9hZGRydHlwZSBpcHRhYmxl
X25hdCBuZl9uYXQgYnJfbmV0ZmlsdGVyDQo+ID4gPiA+IHJwY3NlY19nc3Nfa3JiNSBhdXRoX3Jw
Y2dzcyBvaWRfcmVnaXN0cnkgb3ZlcmxheSBycGNyZG1hIHJkbWFfdWNtDQo+ID4gPiBpYl9pc2Vy
DQo+ID4gPiA+IGxpYmlzY3NpIGliX3VtYWQgc2NzaV90cmFuc3BvcnRfaXNjc2kgaWJfaXBvaWIg
cmRtYV9jbSBpd19jbSBpYl9jbQ0KPiA+ID4gbWx4NV9pYg0KPiA+ID4gPiBpYl91dmVyYnMgaWJf
Y29yZSBmdXNlIG1seDVfY29yZQ0KPiA+ID4gPiBDUFU6IDEgUElEOiA1ODYzMyBDb21tOiBDUFUg
MC9LVk0gVGFpbnRlZDogRyAgICAgICAgVw0KPiA+ID4gPiA2LjEwLjAtcmMxX2Zvcl91cHN0cmVh
bV9taW5fZGVidWdfMjAyNF8wNV8yOV8xN18wNiAjMQ0KPiA+ID4gPiBIYXJkd2FyZSBuYW1lOiBR
RU1VIFN0YW5kYXJkIFBDIChRMzUgKyBJQ0g5LCAyMDA5KSwgQklPUw0KPiA+ID4gPiByZWwtMS4x
My4wLTAtZ2YyMWI1YTRhZWIwMi1wcmVidWlsdC5xZW11Lm9yZyAwNC8wMS8yMDE0DQo+ID4gPiA+
IFJJUDogMDAxMDp0cmFja19wZm5fcmVtYXArMHgxMmIvMHgxMzANCj4gPiA+ID4gQ29kZTogNDgg
ODMgYzQgMDggYjggZWEgZmYgZmYgZmYgNWIgNWQgNDEgNWMgNDEgNWQgYzMgNDggODMgYzQgMDgg
NDggODkgZWYgNDgNCj4gPiA+ID4gODkgZjIgNWIgMzEgYzkgNGMgODkgYzYgNWQgNDEgNWMgNDEg
NWQgZTkgZjUgZmIgZmYgZmYgPDBmPiAwYiBlYiA5YiA5MCAwZiAxZiA0NA0KPiA+ID4gPiAwMCAw
MCA4MCAzZCBhYyA1OSA5NiAwMSAwMCA3NCAwMSBjMyA0OCA4OQ0KPiA+ID4gPiBSU1A6IDAwMTg6
ZmZmZjg4ODM1MGY4YjhlMCBFRkxBR1M6IDAwMDEwMjQ2DQo+ID4gPiA+IFJBWDogMDAwMDAwMDAw
MDAwMDAwMCBSQlg6IDAwMDAwMDAwMDAwMDEwMDAgUkNYOiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4g
PiA+IFJEWDogZmZmZjg4ODEwODBjYTMwMCBSU0k6IDAwMDAwMDAwMDAwMDEwMDAgUkRJOiAwMDAw
MDAwNTQ0MDAzMDAwDQo+ID4gPiA+IFJCUDogMDAwMDAwMDU0NDAwMzAwMCBSMDg6IGZmZmY4ODgx
MDY3MzBhNjAgUjA5OiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4gPiA+IFIxMDogZmZmZjg4ODExNmVl
ZmY2MCBSMTE6IDAwMDAwMDAwMDAwMDAwMDAgUjEyOiBmZmZmODg4MzUwZjhiOTE4DQo+ID4gPiA+
IFIxMzogZmZmZjg4ODE0OWY5OWRhOCBSMTQ6IDAwMDAwMDAwMDAwMDEwMDAgUjE1OiAwMDAwMDAw
MDAwMDAxMDAwDQo+ID4gPiA+IEZTOiAgMDAwMDdmNjc4ZDgwMDcwMCgwMDAwKSBHUzpmZmZmODg4
NTJjODgwMDAwKDAwMDApDQo+ID4gPiBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQo+ID4gPiA+IENT
OiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNCj4gPiA+ID4g
Q1IyOiAwMDAwMDAwMDAwNGU1NGY4IENSMzogMDAwMDAwMDExMjI5MDAwNCBDUjQ6IDAwMDAwMDAw
MDAzNzJlYjANCj4gPiA+ID4gQ2FsbCBUcmFjZToNCj4gPiA+ID4gIDxUQVNLPg0KPiA+ID4gPiAg
PyBfX3dhcm4rMHg3OC8weDExMA0KPiA+ID4gPiAgPyB0cmFja19wZm5fcmVtYXArMHgxMmIvMHgx
MzANCj4gPiA+ID4gID8gcmVwb3J0X2J1ZysweDE2ZC8weDE4MA0KPiA+ID4gPiAgPyBoYW5kbGVf
YnVnKzB4M2MvMHg2MA0KPiA+ID4gPiAgPyBleGNfaW52YWxpZF9vcCsweDE0LzB4NzANCj4gPiA+
ID4gID8gYXNtX2V4Y19pbnZhbGlkX29wKzB4MTYvMHgyMA0KPiA+ID4gPiAgPyB0cmFja19wZm5f
cmVtYXArMHgxMmIvMHgxMzANCj4gPiA+ID4gIHJlbWFwX3Bmbl9yYW5nZSsweDQxLzB4YTANCj4g
PiA+ID4gIHZob3N0X3ZkcGFfZmF1bHQrMHg2Yy8weGEwIFt2aG9zdF92ZHBhXQ0KPiA+ID4gPiAg
X19kb19mYXVsdCsweDJmLzB4YjANCj4gPiA+ID4gIF9faGFuZGxlX21tX2ZhdWx0KzB4MTNkMy8w
eDIyMTANCj4gPiA+ID4gIGhhbmRsZV9tbV9mYXVsdCsweGIwLzB4MjYwDQo+ID4gPiA+ICBmaXh1
cF91c2VyX2ZhdWx0KzB4NzcvMHgxNzANCj4gPiA+ID4gIGh2YV90b19wZm4rMHgyYzUvMHg0YjAN
Cj4gPiA+ID4gIGt2bV9mYXVsdGluX3BmbisweGQ3LzB4NTEwDQo+ID4gPiA+ICBrdm1fdGRwX3Bh
Z2VfZmF1bHQrMHgxMTEvMHgxOTANCj4gPiA+ID4gIGt2bV9tbXVfZG9fcGFnZV9mYXVsdCsweDEw
NS8weDIzMA0KPiA+ID4gPiAga3ZtX21tdV9wYWdlX2ZhdWx0KzB4N2QvMHg2MjANCj4gPiA+ID4g
ID8gdm14X2RlbGl2ZXJfaW50ZXJydXB0KzB4MTEwLzB4MTkwDQo+ID4gPiA+ICA/IF9fYXBpY19h
Y2NlcHRfaXJxKzB4MTZjLzB4MjcwDQo+ID4gPiA+ICA/IHZteF92bWV4aXQrMHg4ZC8weGMwDQo+
ID4gPiA+ICB2bXhfaGFuZGxlX2V4aXQrMHgxMTAvMHg2NDANCj4gPiA+ID4gIGt2bV9hcmNoX3Zj
cHVfaW9jdGxfcnVuKzB4ZGIwLzB4MWMyMA0KPiA+ID4gPiAga3ZtX3ZjcHVfaW9jdGwrMHgyNjMv
MHg2YTANCj4gPiA+ID4gID8gZnV0ZXhfd2FrZSsweDgxLzB4MTgwDQo+ID4gPiA+ICBfX3g2NF9z
eXNfaW9jdGwrMHg0YTcvMHg5ZDANCj4gPiA+ID4gID8gX194NjRfc3lzX2Z1dGV4KzB4NzMvMHgx
YzANCj4gPiA+ID4gID8ga3ZtX29uX3VzZXJfcmV0dXJuKzB4ODYvMHg5MA0KPiA+ID4gPiAgZG9f
c3lzY2FsbF82NCsweDRjLzB4MTAwDQo+ID4gPiA+ICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3
ZnJhbWUrMHg0Yi8weDUzDQo+ID4gPiA+IFJJUDogMDAzMzoweDdmNjc5MTg2YTE3Yg0KPiA+ID4g
PiBDb2RlOiAwZiAxZSBmYSA0OCA4YiAwNSAxZCBhZCAwYyAwMCA2NCBjNyAwMCAyNiAwMCAwMCAw
MCA0OCBjNyBjMCBmZiBmZiBmZiBmZg0KPiA+ID4gPiBjMyA2NiAwZiAxZiA0NCAwMCAwMCBmMyAw
ZiAxZSBmYSBiOCAxMCAwMCAwMCAwMCAwZiAwNSA8NDg+IDNkIDAxIGYwIGZmIGZmIDczIDAxDQo+
ID4gPiA+IGMzIDQ4IDhiIDBkIGVkIGFjIDBjIDAwIGY3IGQ4IDY0IDg5IDAxIDQ4DQo+ID4gPiA+
IFJTUDogMDAyYjowMDAwN2Y2NzhkN2ZmNzg4IEVGTEFHUzogMDAwMDAyNDYgT1JJR19SQVg6DQo+
ID4gPiAwMDAwMDAwMDAwMDAwMDEwDQo+ID4gPiA+IFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6
IDAwMDAwMDAwMDAwMGFlODAgUkNYOiAwMDAwN2Y2NzkxODZhMTdiDQo+ID4gPiA+IFJEWDogMDAw
MDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAwMDAwMGFlODAgUkRJOiAwMDAwMDAwMDAwMDAwMDU5
DQo+ID4gPiA+IFJCUDogMDAwMDU1ZGE1ZWUyMjA1MCBSMDg6IDAwMDA1NWRhNDRiMjgxNjAgUjA5
OiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4gPiA+IFIxMDogMDAwMDAwMDAwMDAwMDAwMSBSMTE6IDAw
MDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4gPiA+IFIxMzogMDAwMDU1
ZGE0NTJiMDVlMCBSMTQ6IDAwMDAwMDAwMDAwMDAwMDEgUjE1OiAwMDAwMDAwMDAwMDAwMDAwDQo+
ID4gPiA+ICA8L1RBU0s+DQo+ID4gPiA+IC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAg
XS0tLQ0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIHdhcm5pbmdzIHNob3cgdXAgb25seSB3aGVuIHRo
ZSB2ZHBhIHBhZ2UtcGVyLXZxIG9wdGlvbiBpcyB1c2VkDQo+ID4gPiAoZG9vcmJlbGwNCj4gPiA+
ID4gbWFwcGluZyB0byBndWVzdCkuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgaXNzdWUgc2VlbXMg
dG8gaGF2ZSBleGlzdGVkIGJlZm9yZSwgYnV0IHdhcyB2aXNpYmxlIG9ubHkgd2l0aA0KPiA+ID4g
Q09ORklHX0xPQ0tERVANCj4gPiA+ID4gZW5hYmxlZC4gSSB0cmllZCBmaW5kaW5nIGlmIHRoaXMg
d2FzIGludHJvZHVjZWQgaW4gbW9yZSByZWNlbnQga2VybmVscywgYnV0DQo+ID4gPiA+IHN0b3Bw
ZWQgYWZ0ZXIgZ29pbmcgYXMgZmFyIGJhY2sgYXMgNi41OiB0aGUgaXNzdWUgd2FzIHN0aWxsIHZp
c2libGUgdGhlcmUuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgd2FybmluZyBpcyB0cmlnZ2VyZWQg
Zm9yIHRoZSBmb2xsb3dpbmcgY2FsbCBjaGFpbjoNCj4gPiA+ID4gdmhvc3RfdmRwYV9mYXVsdCgp
DQo+ID4gPiA+ICAtPiByZW1hcF9wZm5fcmFuZ2UoKQ0KPiA+ID4gPiAgIC0+IHJlbWFwX3Bmbl9y
YW5nZV9ub3RyYWNrKCkNCj4gPiA+ID4gICAgLT4gdm1fZmxhZ3Nfc2V0KCkNCj4gPiA+ID4gICAg
IC0+IHZtYV9zdGFydF93cml0ZSgpDQo+ID4gPiA+ICAgICAgLT4gX19pc192bWFfd3JpdGVfbG9j
a2VkKCkNCj4gPiA+ID4gICAgICAgLT4gbW1hcF9hc3NlcnRfd3JpdGVfbG9ja2VkKCkNCj4gPiA+
ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBJJ3ZlIGJlZW4gdHJ5aW5nIHRvIGZvbGxvdyBob3cgdGhl
IG1tIHdyaXRlIGxvY2sgaXMgZHJvcHBlZCBpbiB0aGUgYWJvdmUNCj4gPiA+IGNhbGwNCj4gPiA+
ID4gY2hhaW4gb3Igbm90IHRha2VuIGF0IGFsbC4gQnV0IEkgY291bGRuJ3QgbWFrZSBtdWNoIHNl
bnNlIG9mIGl0Li4uDQo+ID4gPiANCj4gPiA+IEkndmUgYWxzbyBoYWQgYSBnbGFuY2UgYXQgdmZp
b19wY2lfbW1hcF9mYXVsdCwgaXQgc2VlbXMgdG8gZG8gc29tZXRoaW5nDQo+ID4gPiBzaW1pbGFy
Lg0KPiA+ID4gDQo+ID4gPiA+IEFueSBpZGVhcyBvZiB3aGF0IGNvdWxkIGhhdmUgZ29uZSB3cm9u
ZyBoZXJlPw0KPiA+ID4gDQo+ID4gPiBBZGRpbmcgUGV0ZXIgZm9yIG1vcmUgdGhvdWdodCBoZXJl
Lg0KPiA+ID4gDQo+ID4gDQo+ID4gdmZpby1zaWRlIGZpeCB3YXMganVzdCBxdWV1ZWQgZm9yIHJj
NDoNCj4gPiANCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA2MTQxNTU2MDMu
MzQ1NjdlYjcuYWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20vVC8NCj4gDQo+IEdyZWF0LCB0aGFu
a3MgZm9yIHRoZSBwb2ludGVyLg0KPiANClllcywgdGhhbmtzIQ0KDQo+IERyYWdvcywgZG8geW91
IHdhbnQgdG8gcHJvcG9zZSBhIHNpbWlsYXIgZml4IGZvciB2RFBBPw0KPiANCkhhZCBhIGZpcnN0
IGxvb2s6IHRoZSBmaXhlcyBsb29rIGEgYml0IGRhdW50aW5nLiBJIHdpbGwgdG8gInBvcnQiIHRo
ZW0sIG5vdA0KcHJvbWlzaW5nIGFueXRoaW5nIHRob3VnaC4NCg0KVGhhbmtzLA0KRHJhZ29zDQo=
