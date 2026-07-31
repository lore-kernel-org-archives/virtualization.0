Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D11E34EF11;
	Fri, 31 Jul 2026 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540242; cv=fail; b=RmNHy4+mkmeTOB9zjwkGB541sJTZZXqwpx0jsuOGokWkESNDnkMbyPx2YxBgwhwDtjZtJGWwFO+3u5/BfFULOYpxZql57XqRYXsHpVj9Um7R5TWk9Ih5730jCEiWsqIrD2OvKeDiIEHLIxtma3DMktyWlKrbHfj9WkEwJxd4lEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540242; c=relaxed/simple;
	bh=09tM6nGie53xAoDJblO/miLtmhTqlnh5BgW9pGzGF/k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Geaa5sUnNNNBFGBrxzPUfaVrXqCBymWznTHMRJSJNJPxOtmdY6MHtp84cYPUfAeImWv3YJW76FgIVmwmi3RivZjGY8MQiIIzkeoOxK0IPQnaSv3ogBLRK4pMmQZSsMQXhQaes3wCGwlCOVmfi6IcsRAf91fE//9yVUDkKynVqWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rmFydRgq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a9Slt1Ss; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rmFydRgq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a9Slt1Ss"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VJtV5p1420092;
	Fri, 31 Jul 2026 23:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6egB0ksN0wpiQkcST+/c+/XoHiEyaqvVpOiIt3UQ8DY=; b=
	rmFydRgqHoUV/EF46vuqdy+z32sDNPW1v8L4bVd4E7aY6MZCOfAGkrSHZQqduagr
	1zB52vt8cFHebJj7stnxCzpKgfE1BzWcyIouhCKthzskso+1kq1hnD1WMwvziToI
	pax2cxCBy9SWosyyCUlJ1bYuPNxSvCpeWc8hLxYOlS98N0kdoDlO8UiRe8KJHYeA
	PxgD3HQz3jbSuLYYgOxKlB8I4zuARE/X7m+jCjSfaFap6fm/RPFeqT6svXaKwLWm
	BJEQGmtQAA8pFpINQGemQCU12EOM8eG1evjtTHCpYmJ0oe+ofkC6nWrrHWPwLvMe
	JavBym45HH7+QUaWShm+Tw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmqyymsc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 23:23:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66VNKQmS005579;
	Fri, 31 Jul 2026 23:23:52 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fqjwx1wt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 Jul 2026 23:23:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qL3Ef1JJHjBYKfKW21uVlN1PyqjQ+ucFrR8sAfvBM4VCeyXPnI1ch6P1IcxtLv5oXVaHc8SxyDcn9/aZX45rNf8Xh3moYkYZZB0O1/FQP5GNIDaEBwACCA2/S0uN9JVqUIYVHvTCtEX3M9mh1VL6mHTraOV/g7nZyy8BTg0QHTzIo6epB5+TNxyvFvvbDUnn07QJNe8oLDBYKepLzzjoqilD9RzClLGE0d53rTVIh+q8xABjAfQ4mguUCU5kg9g/UHX7+YUotoDwecJ0epJVnR8eO5Re0NfPIt/24Ba+dk/S1f/1XjfleNcVTW4zFhYg283L7Ma0V71mQu59hkGc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6egB0ksN0wpiQkcST+/c+/XoHiEyaqvVpOiIt3UQ8DY=;
 b=YZT4/F/diXm+NcDtgi7Vv6MSSFZAjWVBQHkzVbU3rvfJHhI/T7cxH0r5UaDJ762komAKmNIah1oPPpeOhlM2TxgxRvO5Z+8/VQsc2dAMZHfROXY1yRN/wsGX3FimrUuwLdHRgpOv48mISjTpZoYFeJVzCyXb6PNhiupCEET7b4VQtUQFLd+UVib6u8Ja+Ye9J4HBAYoqd4XI94V6G3ppmRFiYx6zeGhkn5SH4IcRusURudlvCbPBMwRgOC0RShsinL0576VU1JkG1uR343KcnkIhJKGSTFVa3kREU2PtI8TkVwO3/ifMzw1Sr3pCXjvN5e8R3i2RWOzK/UGFaMEQ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6egB0ksN0wpiQkcST+/c+/XoHiEyaqvVpOiIt3UQ8DY=;
 b=a9Slt1Ss+dQpSKGsmsF2uHBmNpSLYsaRPWvtFxnU80V/1wesH7l3pgMo9Ake2CStEzxSIkXb+kskDUOxFHasHXZeu8fk+3rwBJuvqR3dWj2kwHh4TruciHFO1/o2+wou4vZTbo+7U6UPy9duHpZyBmVIp/70l0PReXaZdMdE2i4=
Received: from CH0PR10MB5114.namprd10.prod.outlook.com (2603:10b6:610:dd::13)
 by CO6PR10MB5570.namprd10.prod.outlook.com (2603:10b6:303:145::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 23:23:49 +0000
Received: from CH0PR10MB5114.namprd10.prod.outlook.com
 ([fe80::3fd5:7a43:a13a:9aea]) by CH0PR10MB5114.namprd10.prod.outlook.com
 ([fe80::3fd5:7a43:a13a:9aea%6]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 23:23:49 +0000
Message-ID: <ba095baf-8837-4295-868b-891fa812f4a2@oracle.com>
Date: Fri, 31 Jul 2026 16:23:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vhost-scsi: use kvzalloc for vq array allocation
To: sashiko-reviews@lists.linux.dev, virtualization@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260731221116.236791-1-dongli.zhang@oracle.com>
 <20260731221116.236791-2-dongli.zhang@oracle.com>
 <20260731222400.8AC7D1F00AC4@smtp.kernel.org>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20260731222400.8AC7D1F00AC4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR22CA0015.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::23) To CH0PR10MB5114.namprd10.prod.outlook.com
 (2603:10b6:610:dd::13)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5114:EE_|CO6PR10MB5570:EE_
X-MS-Office365-Filtering-Correlation-Id: a1eccaf8-c63a-4905-99f4-08deef5ac4af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	xhMO2hrUYNHTWobLdM2Ict54azMaVy0q/2aWMXkbgVtOfs/R2m6oDjr3vh0tAsQKrhsoKaooGv+pi/qF8UjNnCmYdM2FiDcwLSHiVXuZ6QpBj7K532OPMg1xzEv71msOPZYiR1He8CCfwZWy4MZVSoPX8AiHJNvykO3Zcc14PLKMeSzx5TVUUBgzLookPWaRCBOUhRVKuDiZxbRduDZNPF9EoeNAPHkvDpGx5Zs5OIZa4yN0h8QMF7NJsrt73zQwzj1RiLp1rj9UsH01ArBUC9tYbVD35A1nkwoPNvnY2oNTjTfNPapBWg1Yj4nW+4DgWvQJqk4XSCoR6QeYl49SBRh8l30mAqvo1uz0H4yoa/uNeWKFSyj+BDbA+bhwVyjQueQEBe8R1mdtvX/246MtfL95861aDcS0L0gURsxSrJbn7eg6CAdoTb0fSpEXLbUlxTDcUKEFON4j2FDEJq9cUsTU/S7hewnAverDoVw5Xgr6mgtVMlFQKKAgZ/5acuEheGFBe5cnajOOSOn17CsQ6ZPD7wVaWBL5urUZum6gzaBI4+FL6CsCP0839a8eSQksgur69HyVT9VzIOBhmRIOyJ9y9uM2mNw0vDTeYtPcpIoCEccHFST/aKF0sT4v4nIYmguPTmhJ2GwEROpMpH4Vq3qZYnQoTweOZjBcp0ZjQ8c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5114.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHYvMWFoTE5ocEZla0VpOUlJaVpxTndTMFBRNldFakFWaEtGUGl0ZEhIZlF2?=
 =?utf-8?B?TnVLVFlVY2FzUXhGRCtWVjAyMzlMRFozczJTSXRRbmR4QWIwWnY5ZUZnYjNW?=
 =?utf-8?B?SytFem0wVHdzVit2U1F5ZnR5Uy8vOTRJQStpYTRGdmFyNGlObjJoYTAyUlpl?=
 =?utf-8?B?Rkc3ZTJHbnpWVUhTWjNlUlZpbXhOdkRHZWZRa3RkdVZiaWtxa3pMMGw4dGFY?=
 =?utf-8?B?cWpZYkpRSnlJZFJHNDRhSUdiNDJtbkREWWxJTWFHTkowZFFIWkRaOEdJVllG?=
 =?utf-8?B?dXpVWU1zVXowRHJ3a2g1R3ljZXZLRTVqS2U3TGhiN0R1b2RCSisyb1VhVEJS?=
 =?utf-8?B?cmJ5YUxRSnVoWm9xRHI5aVRuL3FpcmlPU2pIelRYa1pMRDZZSWQ2aXRtS2Ix?=
 =?utf-8?B?bUkzRXJUcm9vdVAwS1lvVjdmOG9iQmFDN3IyeXAxdUJ2Uk1xOEdlVHhBNmtO?=
 =?utf-8?B?aXFqeEF3ak5Ba1BVMFI2a1RTcW9oRlVsZ3BQeGtmaUFJRXRxUHo4Ym5EM2lW?=
 =?utf-8?B?VWUxK1R1bE1VaWVFSlJYdG4ycW9QYlI2ajMrWHM4QjYrWHJJUGhPbXJUR09C?=
 =?utf-8?B?UVhZR3Z4ZDEraGZYQzk5bFQ0N0dGVCt1QmN2SmtxU2U4a25Xc3VtcytubnY3?=
 =?utf-8?B?T2h3MlVZU2EvYjRBRUlEbWR4VldGTjd0S3NOZkMwY2NFOWxOdldoRHNBUVNm?=
 =?utf-8?B?dGMvL3ZzTE9FcVBSYVpkTWhrK0dLUkFHdVNvQnk1NnlOUmwwVlZHNGF5T3pm?=
 =?utf-8?B?N2kwbGsyd3NHTk82RnZsUTEvdThrUGh3SHlqeWJtZTk3azh4ZTFBVEYvWFB5?=
 =?utf-8?B?RDg1T3RqdTZvQ0lLc1ZYcmR0MWZEa2pla3hBTjdEVTg3NE1wTW43aWFQRXRO?=
 =?utf-8?B?UGR4STJYUklrQmNuSDhmTXI3TkYxWktVdC96aEtDTVUxcVpYTC9IUTVYb3N4?=
 =?utf-8?B?cEs2OTZSNGtGalN1ZmZCRnF1dnlwWWxSNEFsRjkvTmwzTHpIN200OHBCYTVL?=
 =?utf-8?B?TTBHbTlLRUsxRHlkWktISjcxS1lhbzdVUCtPS0szaCtQRGU3SGxsaEJneXgw?=
 =?utf-8?B?L0Y4Z3Nsa2V4THlYR1dnYzNIN1QrTEVwbVZNbUIxRWNtNlZBTmx2UzZ0SERL?=
 =?utf-8?B?dG10MW5mWFhrQStpZjJ1VEFxYzRCTVhOb2w4Z2E3TEhYUE9EY0djTFV3aGxk?=
 =?utf-8?B?RHhlcmlWK1V4MjZ4VDFtdm1sV29iU1l1bVkzUkU2MFVtckEzMWlOR0wzTVh1?=
 =?utf-8?B?VkVEMjNFTkdnZWNYZmRFdC9XME1HbTR2Z3V6TDE1YngrS1ErOStqRURqcmFx?=
 =?utf-8?B?RjhPOVFSaTZwY28xSHpyRVZGSHpHbTBnZEpHQmlGTEkyOWE2dmNidDZpd3pV?=
 =?utf-8?B?RWl4RUFRWEd6VzZCQlg0Q2Y0SWozZlpmZ2c4WStwa2MzbURzWmt1bEQ2RkFv?=
 =?utf-8?B?aXdEZ1JLRWtzTmxnU0pZdE9kWmI2b3BKYm0xYzZaTW51cjJqM2xSZjFDc21F?=
 =?utf-8?B?WHhCSHZwd3ZweGVaV3VqZ0pKdE5NWHVrZ1kxc3BnRy9GRVdIR0ltMXp3RkVi?=
 =?utf-8?B?RGh3MDJjdUdjMWt1MHA2TUJoTjFjbXI1ZXNvT3UzTGkxNmdMVCtBV2EwL0VE?=
 =?utf-8?B?cTNkSnl4V3VKRUlYVjN2YnJ6T2NiT24xYTluSGdVTkltMjlFSEQ4K1loWTV6?=
 =?utf-8?B?K2JpMklZV25WRVZRWm84TWVyZXJ4b0VkTktkY3JnVnV5U1dteDFtZXJ2K2dB?=
 =?utf-8?B?U2ZBb0VqbkpnN3pHN0pJVVlFUzRTRVc0VVh6UjdISFZYOUxZTVZTNFJBM0xh?=
 =?utf-8?B?c2NTZWpNbmRlTXNkTXRZcGsxa3ZwM1FOS3BvTVhRQ2orVUE5MXYvUnp0c08v?=
 =?utf-8?B?eU40U2Irakx0ZEJhc1o3dmFDWWNhMnFpV2lLSmo2cDJKeUIraFhadWVPSnM2?=
 =?utf-8?B?dSszZjZicWkxaS9Sa2VSU0w0anlXNG9reXROajZWZ2dhRTBLVFFSSWxVWnBi?=
 =?utf-8?B?Q0JIYlozaXAzRXlNd21uc1lJNjg1VTdScDd0R1cvUzZJTGdSQzlFcXlEYUJr?=
 =?utf-8?B?MXUrUU5UNVk3N0EycVJKd0c4ZFk2Mng2eUtWdzBzWkxPVDFoK2NkWXRLZUsx?=
 =?utf-8?B?TzF1aU1xQTBLQ1BSTEdiaURoZEMvRm1yOXlBOE1YSGRvdHE0VFo0NDFuZC8x?=
 =?utf-8?B?M1BSZnFOd0NXZkJNbHJzaWRLajBGOCtqTGxYWEdNZlNEUldxU2tLd04zSU43?=
 =?utf-8?B?TVo3NUV4V0J6dmpHblVOSTcxUlQ4OURCTkNtWmE1bG5pMUtWbFRvWEcvdmJs?=
 =?utf-8?B?Y1gvL0ZUV1BtYmtPQVBjV3Z1MnBTVWJLRjJ4b1YwWG4zZU1tRGJMZz09?=
X-Exchange-RoutingPolicyChecked:
	Hzum4tU/b4dlgF6n/QFGtlVlq8ZSFHB9scjNE0zrnHXu5PrpUlueEryrTUeERKZ5epwPK2AAwZ9ZqM5MOrO5nsBO2GaUbHFWvIutmPbPT/CR3U5zJ0byzQhIiJywORXvrRSB8PkQnxv17EmAdVu+YeNepcxVMVYDwKBMzXDAedxGmbfcvqIafe5b0e2xFyV6mqgPmH+TKtzipvoyllFXk2byRimhZMb0mJtDdQk+56k/c8SUQCCphXFGLKKapyhNJJnVRyxbrtlNYcjXWT0DwMHHAPX74kzcyAUerDAAfCogEcspgTva6AnhJAlRpXWGdrWhni8l4RA5L1jDv4yT3Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x+OKuuo70La6j9h5GwjcHdygPC9ht0pj6u1pRAwTdS3WshE4WHZtynedfTBWzhId58f/h/tpaLpDmL3TH5YtBcuHxylZsg/j6nwlO0/YzhsQh9i2bwoo/xLlnU6VZKLlAiA8Kt2fkoiau6bs/bvFrX8HVU0SHj041HOj4DpZpkDrqyRKDLAqKhbQGY0246AYjwoGCiH5NkwQ5qVWGNGoM0ElPRdu/88lgMbSmIDKEIkmL2zogK9rJH6CPEMzBd40cHQNMQpP3WcpJb6gJHG7fAnJju5x4rfUm22y1wW8EmwVhQAXJ6GgtC2P2Xbm+3JdAHOZ1g8tsOT7v0URucppZrfJx3J5K5UshXXY7hO0jwUkIdtMpDoZX7mOTmlyCiRLwRtq9gjSexTPXdZvy4YUWvesR7vf9mpaUSPbT9ZdfzAIZF0iRjNjKmwegR+r3EHYnOQlxxpb7IUP+mJYjuAnn8ciYkfy2gXv1Xpgx8C0blLznj4NYWttroYcbmbQqn4ue47zffYeKHT1G3JB9Fwkthp2MWqb/bVf/r5EEggnDE/YP5uoNs1w3Du6dI+RaucT2gBt6shOfPhiJAnMdOxEas2atBykwBrtNecXPkCIViU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1eccaf8-c63a-4905-99f4-08deef5ac4af
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5114.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 23:23:49.1734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKEGsu9M9Y0fiY+yPqQBL5sF0qYj884rKXbIbLxnYRNRkylyzSFj5WVW0aW+CEHmbSmpSN3MLRDe5vwG/4BOgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5570
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607310174
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE3NCBTYWx0ZWRfX+LRiGvN4VuUh
 p7IcugdXSW6ksDFbxnYkjGY+VFfcO9M6zq/KGgebuGC/t7KRcdyZiDKVNfab1anmEuiQKDtFDGh
 OaGBaJl4LGGha33yRCWyR3b+giycUtNmkA70c/BPYDDK1+GtulR+
X-Proofpoint-GUID: Av0COPkKkMvXM_8io7vBUqgOjuMRTr2U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE3NCBTYWx0ZWRfX08mjbKlQzEwD
 /t5K+bgF1uZadeZPQbbZjaHbTRjm6jXPp3CYj6hKAvAGYfJVOIrAq40ZE3X/pGxwzV1Q4elSYRu
 MQxxGQrWiQMTjKiyUC1NsZTwCouf/WrzKjoWpNMeVVw3igbuuU9Cct6z8malVynI7DnrWCSsXRp
 2cD5IBNI/TsdD/P6Ny87a6IZiBOnclMEZdnXjomNQ5PkxMYPm4FcS20X9rClASHZ+alLLJHkE5L
 0S6Fh7fiNnAY1vIKe6BIY/L6CFmOXC1iainis/THX2zYGybfd7uqPUazjTGMCXFrvd21AvnDRV8
 PFuxBBdzxl2Ls4LgsF088NDC0VuGdXNyEEC4TvO+BmZVU8U9FOe2NqhxsayOgXoMkChybcnb4vR
 UCwbT1JGWaDp0ucpmjbcvDxIiTBwfsstBugfEKa1hb59PQ6FS81zGD8aKx8SaXuCRiPaVY86A8T
 kKGiFX17fBz8jjRbAlw==
X-Authority-Analysis: v=2.4 cv=HNnz0Itv c=1 sm=1 tr=0 ts=6a6d2e89 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=H1cwOaNujXwptSQvFJYA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-ORIG-GUID: Av0COPkKkMvXM_8io7vBUqgOjuMRTr2U

+ virtualization@lists.linux.dev.

On 2026-07-31 3:24 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The `max_io_vqs` module parameter is parsed as an unsigned integer but assigned to a signed `int` in `vhost_scsi_open()`. Setting this parameter to a large unsigned value (e.g., `4294967295`) results in a negative value (e.g., `-1`) that bypasses the maximum bound check. This leads to an undersized allocation followed by statically indexed Out-Of-Bounds (OOB) writes.
> --


I think this pre-existing issue is implicitly fixed by PATCH 2/2, where
max_io_vqs is validated by param_set_uint_minmax(val, kp, 1,
VHOST_SCSI_MAX_IO_VQ) before the value is stored.

Changing the local nvqs variable from int to unsigned int in PATCH 2/2 would
make the type flow clearer, but the issue should no longer be reachable once
both patches are applied.

Dongli Zhang

> 
> --- Patch [1]: [PATCH 1/2] vhost-scsi: use kvzalloc for vq array allocation ---
> commit 3573b684f78f79b1ae3460e4a7625cb917f76044
> Author: Dongli Zhang <dongli.zhang@oracle.com>
> 
> vhost-scsi: use kvzalloc for vq array allocation
> 
> vhost_scsi_open() allocates one struct vhost_scsi_virtqueue for each
> virtqueue. With large max_io_vqs values, this array can require a
> high-order contiguous allocation and trigger a page allocator warning.
> This patch replaces kmalloc_objs with kvzalloc_objs to avoid the
> warning.
> 
>> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
>> index 9a1253b9d8c50..0c0634eea1443 100644
>> --- a/drivers/vhost/scsi.c
>> +++ b/drivers/vhost/scsi.c
>> @@ -2295,7 +2295,7 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
>>  	if (!vs->old_inflight)
>>  		goto err_inflight;
>>  
>> -	vs->vqs = kmalloc_objs(*vs->vqs, nvqs, GFP_KERNEL | __GFP_ZERO);
>> +	vs->vqs = kvzalloc_objs(*vs->vqs, nvqs);
> 
> [Severity: High]
> This is a pre-existing issue, but could this allocation be undersized due to
> an integer overflow in the nvqs calculation?
> 
> If a privileged user sets the max_io_vqs module parameter to a value that
> overflows the signed integer nvqs (e.g., 4294967295), nvqs could become
> negative (e.g., -1). Because it is signed, this bypasses the maximum bounds
> check against VHOST_SCSI_MAX_IO_VQ.
> 
> When VHOST_SCSI_VQ_IO (2) is added, nvqs becomes 1. The allocation is then
> sized for exactly 1 element:
> 
>     vs->vqs = kvzalloc_objs(*vs->vqs, nvqs);
> 
> However, the code later unconditionally writes to index 1 (VHOST_SCSI_VQ_EVT),
> which would cause a heap out-of-bounds write:
> 
>     vqs[VHOST_SCSI_VQ_EVT] = &vs->vqs[VHOST_SCSI_VQ_EVT].vq;
> 
> Would it be safer to use an unsigned type for nvqs and related variables to
> prevent this bounds check bypass?
> 

