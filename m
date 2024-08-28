Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145E376034
	for <virtualization@lists.linux.dev>; Wed, 28 Aug 2024 06:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724826181; cv=fail; b=oYldztablsRSGSrAfsp1E/Ys2FCE7+FNEOyZhtdmhqyCscGSqXXycYMoBbZBiQEirYY/lhZ3qDbC5ApQc7bNHuTdCOnwk4N2834F4+iLTLsLTUFRyP52T3keZPGY0fg9vec9+/U70gsOtosSTDP/7/P3+S2+9OpOX+tdXEFwQBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724826181; c=relaxed/simple;
	bh=Pj+t90kwzqXZxl/cEpRyhBHuR4IuT8UjZkYou8A+RtY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F8WfhsRw2tHDnhN8JeVY4gYS6oSMLdlyWhAkg0idejub290SuCooV5OjOqcQCeZQwWC9Ia6PhBo0ry4KHtQmkyvMaZDfSW1Q+U94NzHU394ei7TDeK0Gy+dQEyvdwh3a3Uz1L329FdBwcDcI4CUUzxUTFG42rje+PdWNgbI7nMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CcsdCCWT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qAbQ9Aua; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CcsdCCWT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qAbQ9Aua"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RLfV1q016920;
	Wed, 28 Aug 2024 06:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=kkBWp0zZ3c0WthEbqYlMt9xLZoVfy8uwJQ8kE44bjhI=; b=
	CcsdCCWToWi9gYTt6f1bpNkBvQ7o5hqJTaiqw9cnXyu685lvBdPAmkRte/DX+DxY
	7RodmSMq3v7OezlZFQbM5BAChcJldXHpYaqag1EsoU7pEetKNNsUu08Oio8wcVHv
	Tfhu1gVXiVbjq2/g9+0miz5nemuru+OFQL9Nz5jJrLF9FEWR6nYzJ61nlFBbarQp
	YF5sVEyZCRCz31USdSmOxbAXTBjuJnQ8szJKhpR9XRs0pvJH61OF95fTh3K4UEcB
	Y4n4FAGEox4hW+/Zfu6IT99ZgZ1Dlxa8zgYAoYbwVPsabsNo+UmASwnXDBkM6IuB
	RNobMJeMe04f9hHhejIR6w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pukrjdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 06:22:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47S3jaoa020132;
	Wed, 28 Aug 2024 06:22:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8nmu7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 06:22:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5gKQvFoRgkIJRlJiWtj3bVrYs2iNDUQi17UiPDgAKOqMMzxGArUAhsBjzt551oGLJlTxb2oEfZr4Zg0X1IF8Gp83ZOZ6YSztmLPIGGNa2hw8DKXyoRjs9yyyC1cMMvgsEZxSRwj/XCs3fqqSbjg5iPwCw7MKFg3WRaeQWngFOLtuP/OfNm/4ZSB9gpR11qNGG6iWi3t8+dVkZKNqnSTa9WKrh2YRIvHsxpZbFtT3s4MQlikrWAsh0GGnDQNFt677O4Ob9vIaw7wgyiW1MoTrwbzXffk/0B069cXAEbdGFgljCjInrvGKbI020vCa3FWRdJibZaGTh5ZF6VmrvQsZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkBWp0zZ3c0WthEbqYlMt9xLZoVfy8uwJQ8kE44bjhI=;
 b=N8+Kd/yagQpB74PoeTVwvVRiefWy1bcyaOtnBi9zxMlFzvDIR1VpJx7aFXsqGirrdLHtmibURMBLJbYYszxGn61S0bAP29rdGPYoPBm0Ej8wOCXihZWJ57M51RUzBxFwlelOVaPCEk3ubgr9XbZrgCBmGUbFMi5YdPXFCxZcs5nnswY/nPqNUlup2iIsbyt8SYnUC3/x4qWUIUnh1Sd4TbJriyg/Skzg3GnIKUHjcnNmBXWNLs2oJRHjckAq5F2xoWT+ROLsUqq/U0wmg4TI0jYAY6TXSwiPhsaiS6fon7W3CaYhJbY07DZBaWl64lZfr9YmPBpAcygzZN7byCf3vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkBWp0zZ3c0WthEbqYlMt9xLZoVfy8uwJQ8kE44bjhI=;
 b=qAbQ9AuaxL6C1HWqWWZ5CmnWMQSCEJyZvTil/AltGYl4P27B0o6Ad3v1CSRPlgD7xWM+s5MoywPaolvy/NYuDoZr/uPWx2YRVXFx7UpqhBJXMv9QpVEUP4kdtEjbfx58i4TcRKuOUz86DytfOct0nq0PPFef468s8T5N90uLNd0=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SA1PR10MB6542.namprd10.prod.outlook.com (2603:10b6:806:2bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Wed, 28 Aug
 2024 06:22:45 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86%3]) with mapi id 15.20.7897.014; Wed, 28 Aug 2024
 06:22:45 +0000
Message-ID: <3706c1ce-0a65-6f62-e735-9ee187a8966c@oracle.com>
Date: Tue, 27 Aug 2024 23:22:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] vdpa/mlx5: Fix invalid mr resource destroy
Content-Language: en-US
To: Dragos Tatulea <dtatulea@nvidia.com>,
        "Michael S. Tsirkin"
 <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=c3=a9rez?=
 <eperezma@redhat.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20240827160808.2448017-2-dtatulea@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240827160808.2448017-2-dtatulea@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0505.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::12) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SA1PR10MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: cb296714-66e6-4bc7-5662-08dcc729d482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WThVVlJBWTJIbDkycGdRZDdOb1Vta2doQndCSjNickdqeVQ4K3JiWmU1dmYw?=
 =?utf-8?B?cUZRQVVFeVpBc0tQaHRZL1B5NkE4ckpFR2R4Vk5rT2hRdVR3SHNRYlJyM0dX?=
 =?utf-8?B?Mm9xQ1ZSQTNJRWJlYzJEK0FYOXBlVkhzdGNJT2c3UmNsTjlLWTF3NURDK1F5?=
 =?utf-8?B?OHlMSTd5K0tXRVlqbm1qcVJtYUhzWkFnS2N1TTVvSTEyOTJIMGNXZ3prN0VH?=
 =?utf-8?B?Y0RIemlTSkNOZEpQUGxuUk5paUh6ZXFDVTJteW5icE4zcXR2T0xMVThualVY?=
 =?utf-8?B?QnBybkIwd0E5ZnltYmxoN0NRZ2V3Qk9Gcm5nR2N1TjM5RExVdldkODJDdGRX?=
 =?utf-8?B?a21sajFJVEU1TjJKcVc2aGs1Z2ljcGYzTmE3eDgxcHM1cWp6dFlXK1V4bEFx?=
 =?utf-8?B?a0s0N201REpZR2JEbUxlNFEyVnk2NENaaVBQM3RFNU5OMno1ODV4ZS9QRERU?=
 =?utf-8?B?K3hFQ0VkSENjVGVEZkxXWGlnQnVpNGhZVEFhMFdwTTBqY1pKR3NxdWkvMkFI?=
 =?utf-8?B?SGFiN2VqNlZTcVNNSnhaZ3gwZzVlZ1JjeDZOaWU0UG5YTDA3bmd5a1dEZGh4?=
 =?utf-8?B?TGh2MFhrQmY2UExob0IrdEJ5NnBNNFZCUFR4cktsT0V3aVdNdkx1TXB0M1Zu?=
 =?utf-8?B?WDhXNSsxaUhRRS9ya29BU0FvZTVYS1N2WmU2Mk9WbjFyM2ZLZTdlSzEvNjhH?=
 =?utf-8?B?R3lqeFFNOWliM2VVZ3JFNUk3VTdZTEJQRFAzNGwyc21ia24wa3hid1pEMnBs?=
 =?utf-8?B?TW1GdFNBVlBlUW5vYnhFeHYxRjBhNWgxL2hPQTZ0akh3WFpaN040TGhEYXc4?=
 =?utf-8?B?ZCtXN0JOSElFMXBiSThGbHdrY1dmN0pkQzNUSHVaYWFvUTJaM3ZUT0JFdzlr?=
 =?utf-8?B?a1VxZmliSkN1bG5HUmZ0NFVzTTMxSW9zRG9KNzB1WC85eDk3SkNJR01RaE1k?=
 =?utf-8?B?a0tYVWV1M24xYklOZ3d3OHJaa3FyZGIyNVdNV3g0M3l4allVVVU3WFZRYUFO?=
 =?utf-8?B?OFBvQ05hSy9XNnhIcWJKU2c0YzV2QkN4QUNEaldCUFlIZUJkTzhpVC8yRFNy?=
 =?utf-8?B?K0NwWk1tR24xYUMveFB4K1pIamRna3NHY242aVc5enpuWTlHdVRUVElmMlVk?=
 =?utf-8?B?aUI4QmUyODcyMXIwbW4zVERWc1lyUDFmN3RLbUI2bG9VdEFZdzlqNDg2enZT?=
 =?utf-8?B?aTFFRGpva1ZZbU04WWkzbjFRQTF5cmt0M3QrWW5NSjRWM2lyTyszRVF1aXJy?=
 =?utf-8?B?T3JaWC9SNjNjOVJ3MmU2c3IzQWdjVklyZ01BZjBrK2svdFV0RzlCdzNVL25S?=
 =?utf-8?B?MFRBR2RwTC9LcHpEcHU4VWtaZVlwdjFpVTFjS2NCWEVXY1FoM2FHYzZXMU92?=
 =?utf-8?B?WUFIYU1nUGxCSStmUzlMQU83d3crT2dWRWxhWGtCTklNc0ZOK2VCZGd3dHJH?=
 =?utf-8?B?c0ZFSWR5NTdvcDVScXIxTmVQSUN4WUJicVAzSG15YklkYkFGMGlpZTU0eVlG?=
 =?utf-8?B?Z3ltalUwREtvMDB6T0t2R281SDZPZldyMDJEakw5eHhpU1RnblI0ZTdocjNQ?=
 =?utf-8?B?TVB6YzF3aGRXaHltMjl1clNoY2JLRVE0ZjdQN3pZYllSY1Rudy9vMHBGOEps?=
 =?utf-8?B?ZlMxK1RuTEdLaVY2UFBxR1lBWVNUdVVnZjdtVWxtQkkzSEs1a095UkJodFZ3?=
 =?utf-8?B?SDJsL2FuQTlIVHN2V0pEN2RSckdYZSt5ZDBBMGl0eDl1YU9ueElOeVVNS3E0?=
 =?utf-8?B?K2daTUVXalhUbnNNVjhiVW1JM0ozakg5L05vb05rU3NEZ290aERBWHE2QVNW?=
 =?utf-8?B?dGJBRS9UTTYzdmdXSzdHZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjlLenRseDBNaExXbXNhT0ZyQ1VwRVNaaDZvUnJpS29zMFA1TWNFSTVua3h3?=
 =?utf-8?B?bnliRVk2ZS9WcDFZWUROZUpwL0N4bllYa3dJU0k2Y1RtejdiNURvTVM2RTlr?=
 =?utf-8?B?M3J5My9rakpQSy95dFplRWIyWmlqRE9IOTB6T09yYzF1dXVNUlNHbmMydUNq?=
 =?utf-8?B?RmZ2a2xWeUpWaGY0ZTdpN2kzcUFYZXRjYXE4MHJHOXZIZ2NXTmVZbVd5dUVK?=
 =?utf-8?B?d2ozNlFKT21ZRHVnekdFN2FhUHhFVjJ0dkVTR0VhdmxBVUZVTWpBR291VkND?=
 =?utf-8?B?WXBwcjRYTzBKOG9tNWVlZHNrTWFKUG1abDVVbDJnRGU5L3BUN2Q3WXVDRmth?=
 =?utf-8?B?U0ozMlE4N1ZoUTZiOXFONThqdGFnc1FYSEdKNldEWDcyOWhNZVRMLzJTVTVv?=
 =?utf-8?B?VkZCekdQWnhad29SbUFBRVM2ZGFWTHhJaTYyZG9wNkZBZFJqWGplWGkwZVFu?=
 =?utf-8?B?ckxHVUtzcVlGTzJkMTV2eXNveHB2WUpHVVJKeHN5dHhWcXhYRG9FblRCV0ZE?=
 =?utf-8?B?c3RCT3VDVmFwY291QjVHZXU4YUYweDg2dkVZZFY5bExrMk05bE00ckxURStF?=
 =?utf-8?B?aGZYTkxCMmlWUmJ1SWFhdjR0MFdsODMrRm5BWkgvWXVhM2RJY0FoSE11bis5?=
 =?utf-8?B?bTh6Z1hBcjJteTFXbGpuNmU4dGVGakt3WHE4S3RnanlqSkc3aXlpN3dKZFpp?=
 =?utf-8?B?aXl5MnlpUmYranFvQ29iLy8xZ0Rsa2ZxY240bjFFUjNpL3VHS2ZpUHJYdTJF?=
 =?utf-8?B?ellITFlDbS9jRUZ2alo0ZTk4Tk5iNERaZ0QrSmtQM1RmZDdmZlA1dlBMdW5V?=
 =?utf-8?B?Mk81K3NaUDVUM0ZmVDVodkpmdGRvaktSWmswa3ZFNFdTMThhdzAzM1Job29u?=
 =?utf-8?B?TFhjUWJOR3VWMWt4V3JaaUtMYXY4WE9XOFJIV01MaVlBMUV3ZXR2bTdqc0My?=
 =?utf-8?B?RUFMWXNhbnlUVStKZWtHbzNmTSsxSHc0cUtDSXFuQjF5YjA4ckhZeXdDRHNx?=
 =?utf-8?B?ZXVkUDVyRzhWTGJEeWNpTnNmODhKWlBKSWYwVHdZWnl3c2x4RmdTd1krS3Vo?=
 =?utf-8?B?OVJDNnl1TzYxZW5SU3hkSFhVazdpTS8vRURwSXBpNitBQlZFMG5tcXZ1TXBl?=
 =?utf-8?B?OGxSSExPeS84R0tHRnlUakk2UzdVZXZqMGRsTXlsdjZBUkp3TG5odUkzR3hY?=
 =?utf-8?B?K0UrQXdTWE52MVMrcmtpdm9EblBNQkRGSklRellPTjRSc3k0VGg4b1czcldY?=
 =?utf-8?B?a3g4TWpWR25vR0xZRFN2dUlOZmh4eTBieUtoNU9PTWV0VENmeFpkM1gyYW9m?=
 =?utf-8?B?cnJPRllMYmgvZmY5Q1hmQmorODdaUW1EL3VwVEJiY1NHeEtKdUh2T29KeDRI?=
 =?utf-8?B?TGZTSnhnWnBhSUhKZHQrdVBFSHVrTUdsenVPaU5Ya0pwREZsOXlrS2dWcVZC?=
 =?utf-8?B?eDMzN2tXUERKaCtobEh2dnk5UTZ1Q2FpUy9kYTFJOHpxaitDd01TQWc0dDJs?=
 =?utf-8?B?YkFENjNjQlBnZmE0Z2twWXVNT0ZzUko5VFduc3lWZDNjRFFhN1M4T2F4VEZn?=
 =?utf-8?B?bTFLcldZY1RGUURSY0lLamRvYVRwdDloUW1uSmJqUjVqa3BDSmQ3RW5XWTFl?=
 =?utf-8?B?VDBpTVJ2YTA1NnNCOHFjYXFoM2VmWThLNFE3Qm9lSkdsNjZWMHAvdlV3dGhM?=
 =?utf-8?B?Uk9NNWZCSnFGTW9TZ09FUXh3ZUlCWjRDRUxKRUVNOHJNblRoUGl0SW1Rdml2?=
 =?utf-8?B?NEd4VmpWam55RVZITDVHdlI1SUxXNEl0OTRvYkVSSjZ0NkJRelJUQytNejBZ?=
 =?utf-8?B?UDZ6UVFiVXYzaDFENVpXdzMzSktEcWg4bjZaY0U4MkpsK3BEaTVVU1c4Yi9z?=
 =?utf-8?B?VFQvV0pmaDNHVzYzSW1OUjI5YkFlOUZvdnF4Q09jejVwaEpxM3B2UDZ2UWVE?=
 =?utf-8?B?N1J0dS9hbys4R1hMNFllbzBFTThvazRCb0JuZFJha2tXR00zUmtYUDBISExP?=
 =?utf-8?B?aXNONTNlZW9pT05BdUF0Mnptd0EzcDFraGNGdTgyZVNXWEp3dmJKbDRxMmpk?=
 =?utf-8?B?dDBvWjgzRkQwazdvL1FGdXEvdU0zdHhrZ011OWlOZmIzVDc4YUtuT0dJcGdZ?=
 =?utf-8?Q?2NKfFQ4qa4G15oPehKlbZlEVh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R+xJCSr/raa+WaCgW+mCDwyU8yhmQtjc2jDW+xF8M5/eeCEIQ2ctbuQoQimgSFzlPboKJHGVdLdAGvXqLyL/xs1fMODtWzkVe+DO9b1at7BPeCcuq/9HId02zMHVLVnJdFHr5JVp45IFxJJZzC0gBdwPKYwGpb/k42hHr+sTchvYgtO9pEPbvKgWklAfCPeAjfJ04YL+vpaNdwEw0O2UEVUbH567x2C0m6BPXC29OEGdQMmmEOMDyyPsc6CRlbvHb/dJgrn6ryZjodDM1Omj+dP9MLCzFDRbdLOdImPh9SuQg1m2PzexZkBCsILxENYfR95lijmOe395QVFbmJxw0QMbu4m3KlBK6/C8k10vFLSHr8ILjNUZfaFK8SLonKPP+wfTGloaqWaRELfgZS/pbfvmCMVRIKnkfad6ZgAGRhzwnmMbRTsQJKDZi5qzp3iNmraiWQ3Rj32Qd5S2opSSR6ZHr00pKXafcKO1iBkzmz8Yot8k24yqynrzu8BCYL24C+Ilzdm82NluPkVBh3D0KXANUZZZdikSsUeteqogKsUdnqsMWpouk46WFVKrY1G7sMu0fNuMkqqqvNxyXXRxz2QkAYkFX62WgmCvt5Onec4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb296714-66e6-4bc7-5662-08dcc729d482
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 06:22:45.5192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/TQLgv7ewxlc/e4WCalJ0uDsZCLddYbl5Jg7Sw2B29ItzBDJDHeFmW0dmADdWBnwajhF3uU1S4/RniLalGO5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_03,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408280043
X-Proofpoint-ORIG-GUID: zdw3aQvgC8F78nju8mMulEA3DsOZ03Ta
X-Proofpoint-GUID: zdw3aQvgC8F78nju8mMulEA3DsOZ03Ta



On 8/27/2024 9:08 AM, Dragos Tatulea wrote:
> Certain error paths from mlx5_vdpa_dev_add() can end up releasing mr
> resources which never got initialized in the first place.
>
> This patch adds the missing check in mlx5_vdpa_destroy_mr_resources()
> to block releasing non-initialized mr resources.
>
> Reference trace:
>
>    mlx5_core 0000:08:00.2: mlx5_vdpa_dev_add:3274:(pid 2700) warning: No mac address provisioned?
>    BUG: kernel NULL pointer dereference, address: 0000000000000000
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    PGD 140216067 P4D 0
>    Oops: 0000 [#1] PREEMPT SMP NOPTI
>    CPU: 8 PID: 2700 Comm: vdpa Kdump: loaded Not tainted 5.14.0-496.el9.x86_64 #1
>    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>    RIP: 0010:vhost_iotlb_del_range+0xf/0xe0 [vhost_iotlb]
>    Code: [...]
>    RSP: 0018:ff1c823ac23077f0 EFLAGS: 00010246
>    RAX: ffffffffc1a21a60 RBX: ffffffff899567a0 RCX: 0000000000000000
>    RDX: ffffffffffffffff RSI: 0000000000000000 RDI: 0000000000000000
>    RBP: ff1bda1f7c21e800 R08: 0000000000000000 R09: ff1c823ac2307670
>    R10: ff1c823ac2307668 R11: ffffffff8a9e7b68 R12: 0000000000000000
>    R13: 0000000000000000 R14: ff1bda1f43e341a0 R15: 00000000ffffffea
>    FS:  00007f56eba7c740(0000) GS:ff1bda269f800000(0000) knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 0000000000000000 CR3: 0000000104d90001 CR4: 0000000000771ef0
>    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>    PKRU: 55555554
>    Call Trace:
>
>     ? show_trace_log_lvl+0x1c4/0x2df
>     ? show_trace_log_lvl+0x1c4/0x2df
>     ? mlx5_vdpa_free+0x3d/0x150 [mlx5_vdpa]
>     ? __die_body.cold+0x8/0xd
>     ? page_fault_oops+0x134/0x170
>     ? __irq_work_queue_local+0x2b/0xc0
>     ? irq_work_queue+0x2c/0x50
>     ? exc_page_fault+0x62/0x150
>     ? asm_exc_page_fault+0x22/0x30
>     ? __pfx_mlx5_vdpa_free+0x10/0x10 [mlx5_vdpa]
>     ? vhost_iotlb_del_range+0xf/0xe0 [vhost_iotlb]
>     mlx5_vdpa_free+0x3d/0x150 [mlx5_vdpa]
>     vdpa_release_dev+0x1e/0x50 [vdpa]
>     device_release+0x31/0x90
>     kobject_cleanup+0x37/0x130
>     mlx5_vdpa_dev_add+0x2d2/0x7a0 [mlx5_vdpa]
>     vdpa_nl_cmd_dev_add_set_doit+0x277/0x4c0 [vdpa]
>     genl_family_rcv_msg_doit+0xd9/0x130
>     genl_family_rcv_msg+0x14d/0x220
>     ? __pfx_vdpa_nl_cmd_dev_add_set_doit+0x10/0x10 [vdpa]
>     ? _copy_to_user+0x1a/0x30
>     ? move_addr_to_user+0x4b/0xe0
>     genl_rcv_msg+0x47/0xa0
>     ? __import_iovec+0x46/0x150
>     ? __pfx_genl_rcv_msg+0x10/0x10
>     netlink_rcv_skb+0x54/0x100
>     genl_rcv+0x24/0x40
>     netlink_unicast+0x245/0x370
>     netlink_sendmsg+0x206/0x440
>     __sys_sendto+0x1dc/0x1f0
>     ? do_read_fault+0x10c/0x1d0
>     ? do_pte_missing+0x10d/0x190
>     __x64_sys_sendto+0x20/0x30
>     do_syscall_64+0x5c/0xf0
>     ? __count_memcg_events+0x4f/0xb0
>     ? mm_account_fault+0x6c/0x100
>     ? handle_mm_fault+0x116/0x270
>     ? do_user_addr_fault+0x1d6/0x6a0
>     ? do_syscall_64+0x6b/0xf0
>     ? clear_bhb_loop+0x25/0x80
>     ? clear_bhb_loop+0x25/0x80
>     ? clear_bhb_loop+0x25/0x80
>     ? clear_bhb_loop+0x25/0x80
>     ? clear_bhb_loop+0x25/0x80
>     entry_SYSCALL_64_after_hwframe+0x78/0x80
>
> Fixes: 512c0cdd80c1 ("vdpa/mlx5: Decouple cvq iotlb handling from hw mapping code")
The fix looks fine to me, but how come this is the commit that 
introduced the problem? Can you help clarify?

Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>

Thanks,
-Siwei

> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>   drivers/vdpa/mlx5/core/mr.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 4758914ccf86..bf56f3d69625 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -581,6 +581,9 @@ static void mlx5_vdpa_show_mr_leaks(struct mlx5_vdpa_dev *mvdev)
>   
>   void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
>   {
> +	if (!mvdev->res.valid)
> +		return;
> +
>   	for (int i = 0; i < MLX5_VDPA_NUM_AS; i++)
>   		mlx5_vdpa_update_mr(mvdev, NULL, i);
>   

