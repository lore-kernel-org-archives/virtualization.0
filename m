Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770FD43CE55
	for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740641; cv=fail; b=G7pBVeFb/bWaufuP1Gt9HKRKJCpzocwlqs5Vv9jvZu8+5zRCUJSxzqqL3Okm2tAKxbryvmVxxiww+8STwBHpAxLwXopLZDfwzIOPt9e05zSQ9exRyoR6sKG/fyBpYoFlUBH67/ZW7A8cCPZLRlotstrtGpby43vLeTJMEg9ti6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740641; c=relaxed/simple;
	bh=dmuZIHOQ/PZPNSMALYd0aiGfZrocVa/VdgAjG3/wrSU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mw6tZrfVomKS7EVePVwX+fgOHatbraby29JmI9F8HM+8VlaLWmwmM75VLp0wEPF6VcEerZkLkFdQLQCYu09oUB/q3HV0GJ866XYllE4iC/pz2JC+KmZsWPnkH7eViH2iQXKwdMmt2brBLAHjkYgCxoVIgqbt0nmR0MZ2f/1+Mes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WF39bc0u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FYj5Cd6d; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WF39bc0u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FYj5Cd6d"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MCxp3t2753456;
	Wed, 22 Jul 2026 17:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jXz0IZfjJKtj4ktb/qYS6+pK4ERCfwr1OTA2n7NbK3I=; b=
	WF39bc0uqjIAIaLfiI1vvCMVp4x4OA7IdEF/5RXMiU3VGPJW+fwKjAJViwQa0kD1
	ejTGqZ9cmfZiBujnU7LFyF7NKzTsKbxNQ/VckVsGb3qJl++bwg08Zb8Q+NptPekp
	GkZzJ0de+ctlUCdjFHSXRLiMX82ndBdKN+vb/ncdCOhNC2cjfkIB7youonnjdTKO
	/gbdvxfEz8+YdAOR487uCp/tGeLo0Ke9R3I9iUckIRFHdCEQ2j5iC0WNIwTZi6Hj
	eaTZqKzKla60pn2taOzT6q2lMFTeMBdT1Ie7DX1fJbdAu3Jgz5UwfL087qnOm++i
	wpwNJ9hIVhxjZTVFr/bl2Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fg1kpwnuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 17:17:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66MHDAaU028184;
	Wed, 22 Jul 2026 17:17:17 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ffyxcefmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Jul 2026 17:17:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxgD7ZhFu+S+18xJ8IegLb9ME/K+qGEoKTiI1ogD8zMPcYiHfp7QTAAVV9XPfsV4lyU1z37l2rh3wx93Ytl3alSNJv8x++tN6vcYEUvkQWg7vUOjdxICMqBM07/EDMpQfU+5ReC7ko/WEY1XQrJ19Q5hooVj1oumiNAZHJW65Nk+tB6cU911DJopj9pvfbOT0qcbwUEJOyrP5rci66OsaifFEpk9Td/mXdHul+jE1gE8cnqwQAqAXXdHCyyokuMvMHrHOkEglIOEhn8lWWh9ZMTV9BjAnoFiNiag5isa0d0xb/OkhQCQvaRuECKMUsky9AVYJ2w6cpdX/jahZO/Zvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXz0IZfjJKtj4ktb/qYS6+pK4ERCfwr1OTA2n7NbK3I=;
 b=LbJoPru1x3qCnmGpIdcjQQ3sSOSGADqgxHtZcs5Sx5H9URB17kHNJSSII6oYxLufRcdCSfRCI/wWQWhB/QmJPODjxizVjPmDXNyEj2yTF+aCb6PqLVtSicNRTFx72Z4jAo4HbmsCn1qbN5AmJGseQOCOelfx9S79CYfm1wV2z3h7GGvsGq3QtVNIiF/SImDR6CKvUCnXro7k6UlhiXfgs/XmRNeyeYMzHtTmG5uRZLc+b/LLeKphYkpVZHvnhO801nVMpTp2a7wQrCOdaVdXQOqRIjXjajhU1zmXAvf1bXhbAB8PWuxU/xhQn+WnUg/UWaw0lp1um162SzWkfT7ULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXz0IZfjJKtj4ktb/qYS6+pK4ERCfwr1OTA2n7NbK3I=;
 b=FYj5Cd6dHVxRjj4u1JI4SpdSv0qsAmzIzeIUp5oe/5nZr2G1cR40Lso3qSbjeNsN/SLf0JLdRHHC4p6UfbKonHyDrAnMf9cncKyD2j1D7yy9o6V8iu9NCRuslMw1mPfABrrk+XzhPcD+Ly7u7WotNskhMM6cevWRveWH0dVeu0Y=
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c37) by DS7PR10MB4911.namprd10.prod.outlook.com
 (2603:10b6:5:3a8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 17:17:14 +0000
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::4713:6549:d8c2:52b5]) by DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::4713:6549:d8c2:52b5%4]) with mapi id 15.21.0181.016; Wed, 22 Jul 2026
 17:17:12 +0000
Message-ID: <3d2dfa19-42f8-4d1f-a411-c72669f4c4bc@oracle.com>
Date: Wed, 22 Jul 2026 12:17:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-scsi: flush backend after device ioctls
To: Jia Jia <physicalmtea@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>
Cc: Paolo Bonzini <pbonzoni@redhat.com>, Stefan Hajnoci
 <stefanha@redhat.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        virtualization@lists.linux.dev, kvm@vger.kernel.org,
        netdev@vger.kernel.org
References: <20260721073639.1532488-1-physicalmtea@gmail.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20260721073639.1532488-1-physicalmtea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS2PEPF00004563.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::519) To DM3PPF905D77450.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c37)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF905D77450:EE_|DS7PR10MB4911:EE_
X-MS-Office365-Filtering-Correlation-Id: 953a66d9-eead-46ba-5e7f-08dee81511aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|3023799007|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	ZSZd0dpyJal+SkJrLPLPPr9yO5rIPPD+dX+hHDuor8ThgL68HGotQWhd5UJepXkPZLgBcogaxudjsc5aXm8dUJpYsSa5f49Q5fyWZ2gCdGgnsFu46k5kcqBTzHm5JIVLMdNz1h0ocBc8u7xxfNqPh8pjsfBnCAuCOd8fmtQ1qYIUNkffK8P9b3EzGiRyQbTozPsyda2g/MhXna+Fu4XlWIsp8QqG0E+ti7G3oJ7m+AVTZR6KD/SmPr9wsq2l+EXOTMtM9XFYm/XoB6knK/Mnp/4jK1xi53RLoW17KmoIaGxNEUA+Krm+2lXps0symiHYdt69punHT7JZlN2p7yQO4TEZ6FdBPQIGnl7WOEKo9K/YywBxitzKAYWIIKKNiUeyjdPLYofUIyMtQ2XBRrjC9TF8KLhu9UYPaoG6BRKCAJ+nlFtGPk4kCX/cfq23zNlx1VgubZeb1jmRSPJ+l+3tfsl/3NHyI3G20cc5H+G86GyAK+nvX13FdbLeVWcD/rvvqAA47sCgB+Ap+6ZVnWzqxaL/bXgIqB+DeeDbHBJhtC03bf+uRn1kYWt+hTDAMMqkaKBxl2oU1gWjpR7lIos9u2KcX2+C7zE1b3WPinjY0UYIsVNxxSguHgPXJGaWh60G48BU5nCKj+kwTS3zM+avAC1WrKpGeLimc6o7a9tIgqc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF905D77450.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjBKZSsrZGpMaGFxTEtRK2NQQzRqQjZ0TkpEbDJNaDFqU3FtZFluYzJuekMw?=
 =?utf-8?B?S0I1KzRlMUhWdG1uLytFNWdKb1N4YXRWYndlWmpoNms1cVBsRnVSamM4U3Fu?=
 =?utf-8?B?MWEyV1ZOcko1bGRJa1lWS1NXSWVyUEgzWHhuWFZ4UTN0ZjBvZHBOaWN0TWhQ?=
 =?utf-8?B?ZCs5Ympaa1BpTFlwKzZ0VWR4ZGswMkVtTnV0R0o2cm81bWgzdnhGcXpiRVFU?=
 =?utf-8?B?dHpsVXdIWUZFbEVIWHo3SXdIOVJHdzlxTUNic1B6QzR5aml0T3BEaEVzWmMr?=
 =?utf-8?B?UHYrTisyNitWSVJHMTU2RHRHeVRMQjk5ZEJVbk1KMEFEL2tRZkR0OWk4T2E4?=
 =?utf-8?B?OVh4ZHFkU0N1T29PaGhUeTZOQjlLZnJvT0owNlFnVFpjOTlVbGRNSFI1djd5?=
 =?utf-8?B?YjRNWjdCN2wzZXNCSHJKOFFBSk9CTGdzSDk2dEN2ZlRtcGNPY0w0Y1hBMUNi?=
 =?utf-8?B?WkwwdXFwRGQ0cjB2akgwTDBKeFhSaXB3TVZCSFFGYm1DQWhpRFNpd1FLRTR3?=
 =?utf-8?B?MjFqYUU0ZEI3Vm42dkU0WUhRSUJvSjRRdTNTNkplN0tLRjdtMHJLSWlzUUZ1?=
 =?utf-8?B?NkhsTWxCRVZJWEwweHdEanVCRnNnRGhaYWRLRDVQdnIvUmF3Y1Erc25zZ0JB?=
 =?utf-8?B?OFV6cHBwTm9FL0RyZnVKMlZVMUl5b1VzYjhBcmh3bjFTN01RT1RpOVh5VTJm?=
 =?utf-8?B?U05VTDNkcDY2QTdPWFBSWXQyVS9DNmF4ZlNwVzkwc1IwT2N0eWMveEt1L3lx?=
 =?utf-8?B?ZXJ0SEQzWCtkbDZDdkZRQS9JS0FJUGZkOXBGOEhvbzBFdURyd1VocUlSeThh?=
 =?utf-8?B?bE1nUW1OZmdKZ25kUU5zKzdpbzRYc1F6bXRYS3NoN24wSmVnSU1nbEtaRFgr?=
 =?utf-8?B?Uk1jbW4vMnlHQ3RndTFrMTNsY0RCR2I5cDB1UTNZNGFnYVJ4c2x5aFFGVkNB?=
 =?utf-8?B?SDR4TmdqSXF2U0VnTDQ2Rms0MnZpUitUNmVoV0JlK2RRTEE3YmhxUWdWcklr?=
 =?utf-8?B?cTNVS2Z5S2xpSTc3MDVxd0tqMGRteXlrWlRKaHpyYW13MXQwenBiaVJpdkJ1?=
 =?utf-8?B?WjV2TE5DMWpYcm0xWGhwcG9EYzlEcnIwZFpvMUc5cTIrd25UYnhoSHF4aFd6?=
 =?utf-8?B?Lzd1RzEyM2UwQlE2QzhOT1ludW1VNllXKzk3M3lWNGY4akVTQ283S1VmVWpU?=
 =?utf-8?B?SDhYSy93K09wSWFXRmhNZU1ldWNULy9id2pVVWVWckg5T05Sd0x0N1g1TzVV?=
 =?utf-8?B?Y2FpdzYzNzgyRUZqVng2bTRFUGlTaktqWnBub1FQdjZ0RmhvWFlPMGFsMDJi?=
 =?utf-8?B?eXRmZUt5dHRvbEVsdkVJL2dhbXhqTjUvS0hyOVFNUzZNS21iSjlHWUVwOGFN?=
 =?utf-8?B?RmUvWTdOMkk2L3gyeElWb0dIWnNSd3ZzVXplQkFhSFpRZk5vN0ZhY2tDK2Fa?=
 =?utf-8?B?RGpUOFZ5RWFDcUtpVndwZnNlaWVtVFlJWDlUNno0L0FIOHBxYVQzQ3diWXFt?=
 =?utf-8?B?Z0IxbHhjMlNiZWlLeWM1SWVxd242Q0lPZHRxbVM1Q0p2SCthUElEQXlHck05?=
 =?utf-8?B?UVpIS3VhaXp0Z3ZzTHBiMjJkeXN1eVZFY0NWSWFaVU5WUnhDcU90aC95Snd3?=
 =?utf-8?B?S0wxNHFuWlE1U2hMVXBTVHE1UWdPY2E3TnhZUUk2NmZZenVUaWlpNlpERXJT?=
 =?utf-8?B?cGo0Z0lEOVdnL0J0Vi9XTUlwZ3FnT056V3J6Vk9MNXVKSjc1WEZyUzExY1U1?=
 =?utf-8?B?eGVkV0p0bVQ4SGVNK1VqMDZqdStnbEFOenliSWZkdFpCWjZJaVpmVmloVFc1?=
 =?utf-8?B?cFBudHdWd21kZmFVcHRKcWxKWktFZjZvWjBjT0k5bHBkUnlUdkRXVkJBc0p2?=
 =?utf-8?B?YXQydVc4ZzU3ckluV1dsNHlIRS9UNGc4UWtxTi9yTFhZbWgyaFEzVi9CSnMy?=
 =?utf-8?B?dHA4Mmt1d1hYMTA1bmluajJzbWRhNXpHL3BpMHROcHJpYmhacHFlVkFVc3h4?=
 =?utf-8?B?M1BaTG1uQ29TZ081WjhpbldFbUxPT2hiYXFFZ1hDTFFkWnU1RWYxckp4aDZX?=
 =?utf-8?B?UTYzTWt2c2VFbk1TUlU4cThTTVkrZFRSRUJtZTVGWkc5K1F6OXZDdXQ1Y055?=
 =?utf-8?B?WWx0bUVYQ081SHFLWlhwRExsSlY3cEdKYjNzRWFHeW5Ob3NvOHRGSkRVM3hh?=
 =?utf-8?B?UTg3dnJncThNKzBkdlpqTzRZZGhsNVZqUm9zeFdzM1J3N2dTRjA4UmxvSGRB?=
 =?utf-8?B?RDZYT2tEUzFoOERLNUlxYzRWTTdicER4TG40YWplRDlPU01IekRkQU1BZ1M2?=
 =?utf-8?B?MGRkeTFQM0tkL29ia2V5Vm5mczJuZmpFdjh0Q09sbXlsY0RZUlRIejZreW8v?=
 =?utf-8?Q?RO211qshMNJLi70c=3D?=
X-Exchange-RoutingPolicyChecked:
	cn/P9vPQTqkBQrGaUg+8BRYcnvNJgdlqGTbbfN4IiBabGD2LJkAwUkPLAfkvCUcTzsHQO4cowAXYi07VJvcP7W7/EcI+bYUDk/lN5SPD7N4peCHx2jErGDp9cjiKZ2CjCWgPPr0TYkqsF6WD9AiVVQgoXVgGGEQO0PZ9EjQDm4/yXr8qVO0iGc9V7vApczLMcFnqcuZXEv7OJrmynjB4EpTYOx9mLkjz98dKkSDgdyc59Ob9JiiXv0vXZQ68reFxKgipBT34o/NPXT6grOANxGh+CUse5mvyd8o1K4jNFadTvjCFpJvleDMo15Gfm63D5ZYNr1ZliglGcZj1KnbAhw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C1PbV/vFy1o6PTdBTkg0iO+b0hgQOS7nLkQCP/J2HPneVfbyDZcjEWj1tVkdfhzRYPPU16Cd/E55ifqmM2UUKbPOAsAWdrmxRKDz78NRgA+7orp+843vlyPTKRnVq7elYzG/ucfVmH8gByrpeO3V5VRawYHr+qsONC7+/KSNhGCWbwrtjkhKt15/kkUb+W7ExSD1bfhqg9HAobaVcsoeFXwFcfwMF3nXcoVqcGZh2gak1qB650cQ0iAs6UiwlwximswXqXnignQFSTkZJ3v8yIBygVtvuADruAy6fnHD7MLip8YNM3KhcWV/Ww8b/9L0PYfAXEFmelHJZ5ANvGSamhiXpW0cUss1Vp+qjVxnu90QlAHVm5chepZFXd0bg7VzLSrJjnu3f7J1L/lvgDI2od6ceSTkguVPgk+YDeOJlMKKYj85iSCkHBpywAIEbRJL6U4DE04vrJ4suHqTwaH31941DbQlGvdiSffYK/YrEyqkpxru1XxtUJ6Pnfvc81kELODE78ekttnG5ShitArHel17I5nNthtKLi9SBjCpKuIdqP11C7EDwduGcWMmLnuHaNoIHNitCjiWs3u6SxtMLv6vp6N4Dy7tk0fFetc54S8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 953a66d9-eead-46ba-5e7f-08dee81511aa
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF905D77450.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 17:17:12.3764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KD7aE7s3eaU3WVZBBC5GzF7RnkAZXQCvU95lo+ZWVtwMOSnJop0aE0UK7PHxYhHo0wDeOI3f2eDNY6Fcau+6VxrXIBHRHBb+2fU587lrGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4911
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607220169
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE3MCBTYWx0ZWRfX7WF1lfl0CNJm
 koBhGmIck8swTelvy+F7NYv37Kgf9/SUmV8raOs8Y9JTPZa1jHq0REDn5rwJ+O1TK/jQ1gnE7WL
 H+CCvYmfCJZ+XKdUOerH8T/waw/eQd5GaaBO+RvqTrUAIoOm08cV
X-Authority-Analysis: v=2.4 cv=IKYyzAvG c=1 sm=1 tr=0 ts=6a60fb1d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=pGLkceISAAAA:8
 a=1Lextj5hxIYosKG6XVEA:9 a=QEXdDO2ut3YA:10 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-ORIG-GUID: LzVn61WFjOvzlG22nSyvvwhUDSqwYPYv
X-Proofpoint-GUID: LzVn61WFjOvzlG22nSyvvwhUDSqwYPYv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE3MCBTYWx0ZWRfX7BPcyqHkO9BA
 nkq2AImPgi3qfwzOyg7TWdfiHCbQyMsME+d75/uIcYH23E347S2oYO5fE4jNNZAkk7oYCfMCBE7
 mcem/JZlIb+cg+CNkP8MI7n5kFx/LEiBLc+Y8EX7A9gaFfb+3srxNZbaqh69iyPlNGejltbhH60
 aHmxYp9/Qe5EHjpTNtB+OU+oM+g0BGFAeKAjgsyiZTo0+j0zByQRpuCNCi38fMZKu4Hj5Qco4oQ
 FAP5MP90mHTb6/xTdy1EeGCpAZq9/0U4iTAJsc8SXZSzDcebRqTBG/3cmst7tlT9I/TTr2+97V/
 GjG650t4lNtAqvDMUKw6Ax2ZC3k4j8F5QiMOqCdWsjD3H2Mkp98OD2+T0eHpkanPTccBRxIdqMe
 Cchos+s2+lJe0i8GxqSwrg7g+2CODC3XSU9A1qOzK9DTNofx02hl3DGeKfssDUAZpxcF4ZszUHC
 rsrsbYYn6V5DjVFPiOQ==

On 7/21/26 2:36 AM, Jia Jia wrote:
> vhost-scsi translates guest response descriptors into userspace iovecs
> at command submission time and later completes those commands
> asynchronously through target-core. Device-wide control operations such
> as VHOST_SET_MEM_TABLE replace the memory table under the device and
> virtqueue mutexes, but historically returned without waiting for
> outstanding SCSI commands that still hold the pre-update response
> iovecs.
> 
> After such a replacement, completion may write virtio_scsi_cmd_resp
> through the old host virtual addresses. If the owner has already
> remapped those addresses, the write lands on the wrong userspace object.
> The kernel tree has carried a TODO for this since the 2012 split of
> vhost_dev_ioctl() and vhost_vring_ioctl():
> 
>   /* TODO: flush backend after dev ioctl. */
> 
> A userspace test kept a READ(10) pending, replaced the memory table so
> the response GPA mapped to a new HVA, remapped the old response address
> as a victim page, and then let the command complete. The completion
> wrote the victim page (victim_changed=yes) and left the replacement
> page unchanged; a later TUR updated the new mapping instead. So the
> pending command retained the pre-update response address across
> VHOST_SET_MEM_TABLE.
> 
> That same 2012 change deliberately avoided a second backend flush on the
> vring-ioctl path: vring updates already flush where appropriate, and an
> extra heavy flush would hurt when kick or call fds are reconfigured on
> the data path. This fix does not reintroduce that. The default branch
> still routes unknown commands through vhost_dev_ioctl() first; only a
> non-ENOIOCTLCMD result flushes. Vring ops such as SET_VRING_KICK/CALL,
> num, addr, and base return -ENOIOCTLCMD there and fall through to
> vhost_vring_ioctl() without this backend flush.
> 
> What vhost_dev_ioctl() actually handles on this path is small:
> VHOST_SET_OWNER, VHOST_SET_MEM_TABLE, VHOST_SET_LOG_BASE,
> VHOST_SET_LOG_FD, and the optional fork-owner ioctls when enabled.
> Flushing after those is fine: they are rare device-wide control ops,
> and SET_OWNER normally runs before any inflight SCSI work. Call
> vhost_scsi_flush() so pre-update worker work and target-core inflight
> commands finish before the ioctl returns. As with the existing net
> pattern, any non-ENOIOCTLCMD result flushes, including failures that
> may have applied a partial update such as VHOST_SET_LOG_BASE.
> 
> I later noticed vhost-net and vhost-vsock already use the same device
> versus vring split.
> 
> This is a control-plane barrier only. Ordinary submission, completion,
> kick, and call paths are unchanged. The owner is expected to keep
> pre-update mappings valid until the device ioctl returns. Completion
> copies the response and signals from the vhost worker without needing
> further userspace progress, so waiting in this ioctl does not leave the
> owner process stuck on itself.

It's such a long and verbose description. Was it written by AI? Was the
patch also done with AI?

> 
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
>  drivers/vhost/scsi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 9a1253b9d8c5..c3e8f1a0b2d4 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -2424,10 +2424,11 @@ vhost_scsi_ioctl(struct file *f, unsigned int ioctl, unsigned long arg)
>  	default:
>  		mutex_lock(&vs->dev.mutex);
>  		r = vhost_dev_ioctl(&vs->dev, ioctl, argp);
> -		/* TODO: flush backend after dev ioctl. */
>  		if (r == -ENOIOCTLCMD)
>  			r = vhost_vring_ioctl(&vs->dev, ioctl, argp);
> +		else


Is it still possible for userspace to execute the READ/TUR sequence
describe above at this time before the flush?

From the description it sounded like we needed to stop new cmds, flush
running cmds, swap the new mem pointer, then start new commands?




> +			vhost_scsi_flush(vs);
>  		mutex_unlock(&vs->dev.mutex);
>  		return r;
