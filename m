Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE8B3E49C0
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 00:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785801774; cv=fail; b=Cwf0tv8ZtVH5AFkp/DI50eL+zTr04IiYY81s5Ee1Lrm1fOijwUiYsUJu5mstdfZ6wBlDpEdz4ZFQTxIn7UyPf6PBm0MdUFAWUvfOaMofoG3MXlQMIaFezV1AC8iBj7VizqFP1u/K7wrNv35TTf5YMKaH9s6cVeTKgZWBVxTIkrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785801774; c=relaxed/simple;
	bh=wrv2/NYKCS1yIc50lRxC/ZUdxMNrBfp2QCJ7z8z+ozs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l410uCxDfjD8lrkZgixI5XWI/4gaP2n26SSaNXPRyMawNjsVoPWkRNyUItfUriWCT2q+1tClVNzFIRqWQIE8RnvorGU4WEl2Nhcpi8SJBpHqDfHWrdTznZJlxN+6KMvNZTqDPUXRyWmVz8M/XUuoi0xfIYCHFHTEx5sCuhImFng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bpKfWIlt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ES/zu99I; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bpKfWIlt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ES/zu99I"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673L4Cbw2754123;
	Tue, 4 Aug 2026 00:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wrv2/NYKCS1yIc50lRxC/ZUdxMNrBfp2QCJ7z8z+ozs=; b=
	bpKfWIltQ0JYP7gIFu4FHRLZ0FzKamuB+XkCxDzQE/jBiYcOPJqw0EK4XHFaNvip
	iVJ3RguF+2Y51FninG3uylNrMr0rolLLc/3dmMFM46Uo7zej41SWAZrUrhE5KgwG
	Ejk3RZ6lOr6RvMHjp02sHPoaptDlIfAHzQxjG/BxeReUS2Purt2VrRZD6wOz5/QO
	e1Vv/ptZ+mfsU0kfweZUAUcc3l37OnMEczCtdWk+WHaDMmvi8nsFS80kFleNqpZ4
	l30McK+wZRmnoliL50a/Eo+wi5OH5qY23F0splKZxr1Z6MTCRV9aHqCz2NU2d8Ca
	QckCgkp3S+C/43IQ52Uggw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs7cy537c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Aug 2026 00:02:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67400gX6008472;
	Tue, 4 Aug 2026 00:02:50 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012042.outbound.protection.outlook.com [40.107.209.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78t4nts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 04 Aug 2026 00:02:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1+eZccF1QwRDEtumG/fpiIeS+VS7C5bDJfSG5IuQBLyH201Mp67yGz5CYh1Qakjj5AIIq+SHZtCLh0GY386VgVg77fLHrpAAsXZRDDjz8lvGV6sby4m9OjKx3LmRTpwmjf4K21pf1qQX4CTb/V2PeqLwxIb2umHUmXJ3kII+Ajl6FLyrZ0nb6GYAcy8zeAio6rjxnei6vQdd/wRmnT3mScTdfKsCV9q573jd8WqEQBL20MVM68ycfv4ksR2P6wtIJuYleLPPK7kP9dj5Rl97/DVFLZ7qGmcc9fpgrVve4AiMsF8HAieDOvenrFF4YwVXxVAIjriTo6xqbd+7esVjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrv2/NYKCS1yIc50lRxC/ZUdxMNrBfp2QCJ7z8z+ozs=;
 b=qRjA9ASQnWAUuPVzF8ODw1kbIHaHsH2Cox0PTE1R0bA46Nc2pqewJNzXtqA4IGo7lQ6i1nRhHRA8B13b3aSo93HfrGYkrdjJR8x/ypkJ/h2ZDJa79l/8SsuVz+aNhq+hRZjn3hOh06FHoqZNXDrJ8SiHq1DN8QUWFFgu0Qc1gaEmatB28RHs46GKVF9CS44ZdF3OEdqr6/Mr8j86C4tu35rsKgh8hmk2Ets7ow5iaw7Oo0F44Ltx8J/3VA4HdkLz6lw36NIz0WR70Ay5Ic7LoCex8mDTPtFHsIyJSmbnOSrySIIXUxcRL+R7d/tUqEPbKn6J7bpO76Yj/LGkW+wJLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrv2/NYKCS1yIc50lRxC/ZUdxMNrBfp2QCJ7z8z+ozs=;
 b=ES/zu99I3H28ZMNPBT6EfGxR5vy63oUAZ+utxm+KNyF7/gCN6D1rJ8G+tkB3TY9BRi5Hn1Kxe0WU3a2fRzNzGPcxqKLpxofJQGJ3rAf87ba7/QWi73xvZ2h48bK5CIZrAolwZ/b7wdAD41Nl/DmKNIBnhNPFPUcd5ixD3mK1fJI=
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c37) by MW4PR10MB6607.namprd10.prod.outlook.com
 (2603:10b6:303:226::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 00:02:47 +0000
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::c70e:bb7e:7d68:be8f]) by DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::c70e:bb7e:7d68:be8f%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 00:02:46 +0000
Message-ID: <45a33302-0b28-4d00-8724-c3af6e1783f6@oracle.com>
Date: Mon, 3 Aug 2026 19:02:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-scsi: flush backend after device ioctls
To: Jia Jia <physicalmtea@gmail.com>, mst@redhat.com, jasowangio@gmail.com
Cc: pbonzoni@redhat.com, stefanha@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux.dev, kvm@vger.kernel.org,
        netdev@vger.kernel.org
References: <20260721073639.1532488-1-physicalmtea@gmail.com>
 <3d2dfa19-42f8-4d1f-a411-c72669f4c4bc@oracle.com>
 <20260723105451.1563439-1-physicalmtea@gmail.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20260723105451.1563439-1-physicalmtea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:1ca::15) To DM3PPF905D77450.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c37)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF905D77450:EE_|MW4PR10MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c689e3-077d-4709-e080-08def1bbb62d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	dHcwJjyLrNCxVJdFMAlONDLKkPxahct9L4Ajmyx+4E6E1LLvKuW6gaMjicNjbf5r0UO9/Cgnrkoo6h/irCdtM/t8txmlIZxiIwLaumefTVTZt2YWUwCtZznjDH9K9DDXhrDfyyYM8CSMsimC5mUoIsiNDA53eyq753pmv/RQbmYtsyZ1PluPsu+Cxu8ZziIeKjNbCPEKVmLhaqG54azzDYVrQRiK1AJ8ZHHYE7ESZBj2Mc/EOlzVbS1oLzOWObnyG0s82Cyir7qW8v2CMdAq785ML71QfNQ2T6ZpLAlD7AjqUOxaOKRTGOVzoHTlye6hGOMGtoNdqvUTvSC+bVFL6A49o51YQC4aNBuyQ9qL2YN5uQurY/lve8hO4GMN9z1esn+9Nu+bRxeSGid/0IplAtvtz5u1bL4PyEC26L/HU5cmnaLkaG6hz8Vgh7ZgeJsNXLk3Z7YC7ROYlpfSSXKcIcfXN9xNK3Mrm0gttvdnPRNDx7K1NlrOxUvyfBTWDzazf9EsGzPiY0UQq7aVnlTiYrOK8LG07ThmsklvAAxbaaKVCluyEXF0QmyEvDf6KMG2nZhbD0Oq+IQuH/9aBXB6yZ5XJbvkpQfkKMhbZn07ahhBs9u+Dom68VE/7BfKCKToxXjhkQdN0a04fIcm5iPr2zYuzORjcamGTamv9snkEX4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF905D77450.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QW9xeGsxZWw5VEVZZGlQMnpRc09IS3pMQ3BMN0sxMmp0L3ZFUmVxVkdid2tL?=
 =?utf-8?B?YkcweVFXVjd6Ti9jME5NMUc3eTZ0eThlS2gwRmpXTWlTOEdNOWd3cHU5VE9H?=
 =?utf-8?B?OTVVWkEyL3JMcnE4Q3hYRFloWVlKc0MxcjNxL1Y5U3Y5Nm40NmZMUFNBUmNS?=
 =?utf-8?B?aU1vVDRvaklTWnkrSlRWdU1mUHhjTk1Eb1JkMVFvaHo2L1hKWFowNitaV3My?=
 =?utf-8?B?dWNFZGFYREpUM2NEUHY0aVp4cStsd3UzcVpMYUdKSUZ5MDN5VysxQkJIM2xp?=
 =?utf-8?B?UXhmQzlTakx6UDRpOWJEV0diSjRRenY0Zmp6THNJOW5LeXRETU5lbk50MUQz?=
 =?utf-8?B?eGNTNkVEVHh3cVI0ZVNCeklWSHI0c3VMUEIzUTUyem1EU3ZtdTRsaHV5VW9h?=
 =?utf-8?B?U2ZQZkovWEFSYzZDVk1pVFZ3R3dzVUR4SnRMbitOWVhLVUVTZUxZTUVMTE5V?=
 =?utf-8?B?NVI0U2hNckJoQWgzczJkcjJENnQxVk9Gc0hRUHNtdWRnYTFOV3RyWVNVOEhi?=
 =?utf-8?B?K2ZxNHFBaUdQbHA1SDdOUksrdjdWdEhBRldpOFI5UzM5UlpiVFcxSWVsUVZM?=
 =?utf-8?B?MGtkWVZnbGMyTW44TDVjL3cwTGhWU2tIK0RlUVowcWFxODRmWXArWEhVMWJm?=
 =?utf-8?B?Y1h3MWx0NGZJNTNHejBXa3RiQ2RYcEFpeVgxU1VQUUpGSFNNT2pGVXhiMHZU?=
 =?utf-8?B?RGZkNWR5VlJHSGZOemtjaDQ1WE9IdktLekZTMTU2YmNvaXVjeXE3RWxMRGtT?=
 =?utf-8?B?cldtWWJOK05sSU9XbWlUYnpVdm1FSXpWZ2haK2htNU5Hb2pmS094WnJDWm1V?=
 =?utf-8?B?Sm1rdGlRV2ZJQU5NeEV5QUNoc0FnYnhLNHZvcGE2eVd1UWtYTTlkWTMwRlVZ?=
 =?utf-8?B?TGt4OUhhdERNUHkyN3NrSUJVamNjckdiWm1JZHFGWFFZekx4cFJ1bU5sZGxj?=
 =?utf-8?B?WERpSC9DYmFUUXRxbzIvOEJkSE1IRjhKM0VFUExxUFR6V25lcFpGWWVya3NL?=
 =?utf-8?B?aVdubDQrc1V5OVRSdWpjR24yYmtsUG9nNko0c0hTTGNjUUZoeGZSZ2ZwZ2hr?=
 =?utf-8?B?R3g1SFFabEMvYzhwNGhONzBkVnN1dGFCL01WeTZ2cUQ0clZZRWpIaHoxOWE2?=
 =?utf-8?B?UnlBQW1OYmhmcy9FTzJlWWhjVDdnOVpIL0NVWVlIMnlnLy9EcjI2T3hoQXlY?=
 =?utf-8?B?VHVQbnVSV2lwUGFBWEZibzIwVWFKYUF3dndNOUZ6UXEvNWwzWEVtNmxFU0lx?=
 =?utf-8?B?clVWbnl3aHZpNTZsZHlDd3RXQW54Z2VyNFJNa205a1VtZmdobHpOYUJvOElm?=
 =?utf-8?B?U1VWbjIxVEZPdXJObldYWU44MktOUjVjYzkzSmxZZzZ5TTFEZGFCN1grRkt2?=
 =?utf-8?B?OXlRbm9jcS8xK21tQmZKK1VKTzBhbnFWVmw3aWtWRC9jY1B6VnQ1YWwvdU9w?=
 =?utf-8?B?ajdpZUF1b2g1Zm5aRWllRXlxR05ITzJra2xSd3d6RVEyck9QTU5uS1JnLyt3?=
 =?utf-8?B?aXNBMGR1NnRjRXlwOXpjVE5nOW1sRmxBUjZGM2FUbWdRYzEwaW1UMjduM1gx?=
 =?utf-8?B?NEwrMEorVDF2akEwS0FtdzlMaFVsTUNhOU5CenJxTXhldGJLTXd4TmFEcGI5?=
 =?utf-8?B?MEJKdHlMK2lmUTVMMHg1UzUrZ1B2SnNBMGwySVM5QTRTVzh3UFNDTmgvSkJ0?=
 =?utf-8?B?Qlorb1lQS3FsRFpCdXVDTVhFbXZDMUZFcmRnT1l5azNoWFQyYllxMjZpOE1S?=
 =?utf-8?B?YU1KUjM1cURTU0JKZVcxRzJmYTdQYTNWOVFuQmlTVGp2OU9JQVNoeHJCcXY1?=
 =?utf-8?B?N1krU1FLUVRjWHJRNzJhQWRrb0pJNnZVaGJTUnZhbDcvODgrNlpZRXZWK1lq?=
 =?utf-8?B?ZVhCb25OT2h4SkxJMmt2dFNZejJ5K2VvVmlPeUJLZUowRkx0ZVN5Sk1RZ21l?=
 =?utf-8?B?dkhPdUZTMTV4YmVURlVKdm1hRGI1Uit4c1pFSXlIRG5vUXpGY0pHeGFLb01D?=
 =?utf-8?B?d3FZeDNiT1dTenJnaDV5b3VIc0RnYUMreU5TL0pFc2VGVTZ3clJQUW1sU3kw?=
 =?utf-8?B?VzRzVWhZMUltNmUyTldKYnlOZ1pKaGk0Z3pFcHNmYVp1SDJldXRmTC9TQk5T?=
 =?utf-8?B?Yk1pNDE5VU9jd3lFVkZDcTlsN1RUYnZtMG9lS1hDT0s2NVdrN3VKOXpNc3RF?=
 =?utf-8?B?eEhrYjU2T0p6SDFlMHNQYklBQkRiQVZBbFY0RFl1MUJJNEtrenptWjZMeGp1?=
 =?utf-8?B?cEZ6ejhRVmpKQjFFSjRkeE4wUXJiY2xCekpJeUtYdDhIY0ZuTFpLQSswbWZn?=
 =?utf-8?B?SktOOGVGaVc5RDJaM0pVOWtzTjRUWXkxcEN3alY3QkY5WVRJR0Q2MXhUcTk2?=
 =?utf-8?Q?B2xU3r80jchNL3PM=3D?=
X-Exchange-RoutingPolicyChecked:
	GBgXMoIJLF4AwnQ56ZgSIitUv59cJ3vtB5p3FEHFOStARHHJO+NbmpYnubmLKydIf1DmLiKQO1ZTJjAY5bM2Qq/eO0cgu61gzo5Qo3/UGN2mJtphPq7SgVObXRnOGQodyE7lwVE85EVU6G3M0ffPg+lDm6QFsLDOudkftNHPrerAK9+dMQGZq75G45C+Q+CP4MSX7I65w4l92xJBy0JvqxEdyXVkjEZC7CLnztGByx7bNrXkdgkNTBV8dEYL6lTbpGTd1tbPkzKxy7Ru3aN6Hn/etfvWzfkhIubYtjSZdj6tl/NUPdoJREoHK1r2/dgA0v5CKhcuoQgqTaT2g0lUUg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ozHcxZzmAjuxYty9N92cSkQz4y0jwIAWEcFgBtKQW01hLkdy04XVGkspkclYQzbgv8Y+Zdf3ROGBOAKGSKprs+o1nfNKFFIHTJ9eP27LP8rC8NCeBRf+WhfcpO/HB3i7t6SbcNIwHzquLO2U2hLIpWuYoYhbfO8IkNLAKevf3PjLJPFvbW5MdRtgPIqPmsbsZebc6VXXiqOrfjCmibjdnb6n2tLeR14Jk71GNDRfWznUlUmyNbjqZ6ChYaPySpskFbDUUtmAe15QCtPrSzAqvH3B2aVNBO/lDwJkUvVb5hLH99CcU2wqX1zrwFnyo6VpWUEPDVn4Zcfr3Yga7QJOX3bMFXa9AgVrqyGC7D5CnCprPF8yl2hl+3JgldGXi1mtMbOWgDbpZmTzkB+XSQGAX3ecnkozyAoPV5ef1Ver8K0Qiobc3sAo6Bjpwm8slnWLuVLbydntGYt03vR7XXYAdQOf7wyKG6YHGSqAZ8VxrXL081IZ/40UnURV8LvLk2rEaWruSlThfelJr965YbwkM5GBnlLtjlCBd4iYiOjKqtbXc/uDDmj1u2QRF8rkb4Oi0bEoj9ReBTi3OvX+WhHwq0GzIU4VpoO1nvPpUEAd3Pg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c689e3-077d-4709-e080-08def1bbb62d
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF905D77450.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 00:02:46.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WqFxqCbQLm9rQk4JwqUtyErC+adGUYbyUIIFG6s8FJE0AXSdKtw8gy6xLaw23cCxjd4wEiONO7N0EcgpfQmpKGD0+L8qRGC14aRJMmuYX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6607
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_05,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=974 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608030210
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDIxMCBTYWx0ZWRfXxDEni1EcowsY
 KWF0XwddXOxl7lIcy/yVr9Tr2FUQOrgR7WqFgAavkycvBqXLaE5UmEl7NzUbW+snJ1md/cYPvcP
 pn+TqoeRKFUdBdnuH8YRxpsdIbpDwRJKcSwIE7qR5oE7cr5Q/GAP
X-Proofpoint-ORIG-GUID: 447LrF9FpkpRNueu0NaF2XH1MV20M-cE
X-Proofpoint-GUID: 447LrF9FpkpRNueu0NaF2XH1MV20M-cE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDIxMCBTYWx0ZWRfX26rPnVm/oTCl
 oef9mRQRJcosUtc7hqX3iJNgGSI1Xab5c+CTr2Xh7CmAEkB0pnGhyKNvOT5CT0pRDfQ760MvJbZ
 yI1eQw6uVdU4PIeg/KFOHY3a/mz9JYbERQqaY3+DBX9Tk7kPHpbRaIFr0nmen8JlmVefPZlrjNd
 +mWcG6hlRus/ZWbcczI+5bD+/w4lWuOUFG8+AXPTZkFq0/bGMdOii3O/gcKOOtbk3Us78Tv+vCy
 A9vp6Ue69dWcjZrBU4nK861ty2ARhRgO3pMNRPm2wNfyEXvtSPN2zkID/WpKoD/0+TVeOqHTjtk
 4yigbB+2/ECRhjINiKBSlk37PetKZM55r+BAl9YzixmpjKmEDOQR6dNVyoytbNQ9+t4aHSI2NsX
 H3M9VX25FfUo/PC8uQDEzP2HFzaSxK99ACbhwP35SmPLuqSxYSuXn9BPJHIxm0hzYqD7gD0HKFH
 csMW68VTHkZ6haCS4SRvjE75v/BFXJZAgRp3/OW0=
X-Authority-Analysis: v=2.4 cv=TsPWQjXh c=1 sm=1 tr=0 ts=6a712c2b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=TVpBnX68YTnaIPaW9GwA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12100

On 7/23/26 5:54 AM, Jia Jia wrote:
> The owner must keep the old mappings valid until the ioctl returns.
> Remapping or dropping them from another userspace thread before then is
> outside the lifetime assumption of this transition barrier.

Ok I get it now. For some reason I thought that was valid.

For the patch we don't want to flush if vhost_dev_ioctl fails
and there's no reason to flush for operations like
VHOST_GET_FORK_FROM_OWNER or VHOST_SET_OWNER.

Could vhost_dev_ioctl return when a flush is needed?
