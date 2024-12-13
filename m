Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811611DF261
	for <virtualization@lists.linux.dev>; Fri, 13 Dec 2024 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734099643; cv=fail; b=SoLy8N2enOgNWL9Ggb2GgOVttY8Jat26hrcbnjZ3LdJzbG1XCuRKEJ8WOwGz2+eznKANhq/hMLtjyA1heA7CUw6UN9aDcU3j8TR6rdg+O5mT/tU+0asSmEX4hZrnm8PNPahCoUkKzaw3v5p9MSsD2U1VCI7bANyJtEHvO9yaupM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734099643; c=relaxed/simple;
	bh=YPA8IyYDnDhS6fwm0wtmSvp/OizGhkkYXNGJRtWY6cs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KrFfuMUF/XK7VnEUOferhy+uvdfaVqL+XOqs7M0JIYSUzmq/2hF11ocu80c0mIpReTKpMuIHGSwaP8Yr76fRvz4AfcGHGv81R15Pnb/vXXdbNUKEriXQuTaMI2wqgTubARhBv2XxLXT+Rif4M2nTjgsGgf8Dhar1TAUP/A60hFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=VcltdQQ1; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="VcltdQQ1"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDCNeBR012944;
	Fri, 13 Dec 2024 06:20:28 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43gmvyr6rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 06:20:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d04Z95VRSElLgl+oA+2UJBAbVZZbx1sqKsOednu3NZnD+aeTAmoe8IfkV1OCH4+oNe7am5SxMzPAwLDkM3f5v8qBk0gqTR9yWZeqtwO5dNH8NBKIk/LsA4sJqPuww5hN4wDknnzFBZDPRMCNvxSOjay0x5ndkMuSRDY+ezb+LMyy/j+lsHr5O5c6uV6bFOMVflgNOQk/pX3yrtqOKYuEUy9eV3oMXue5Hw7OGr+ZdCNRzNDB67GcZGEH2lNIGqoj1m7LgSne6qgKdVhTS3gzul4wIcfNN5RdUH7nQ6JBwAy7ryon34Zj9gmTmzyTyo03P3Yz5JG1zFGc9NKkXqOS2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPA8IyYDnDhS6fwm0wtmSvp/OizGhkkYXNGJRtWY6cs=;
 b=jKHXvqIL7pcmJ1KKylLJuykS5mtbr6O6zT7MCqMBLsVjjFZexANEXa9AvgPVqcRDOYWAzgkap9XZs50v6TcYcPySCsmnmqGUwru2PHLXNNHSdKJUZkqzVwiD+f4Ai4UJorKu3SYZnxBNDnzy9P2B6wfJveiighQtLSoGWczjN7AOe2ZsT1wABejjnS2ZzJpq4xMBPfTEQI1i6GUYXcjZmNnr4a41EKDSpatEHUITYdi1/LCE7Z30LJHB3kLWAQtfdSgyQx8hwFB1SYqjYqTNy0KbQNEvxpSJ1Mf/HaLyTqRrAOhQxhgbIXARwzfeOmU2S7gZww6+HdSINvbAo7L1lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPA8IyYDnDhS6fwm0wtmSvp/OizGhkkYXNGJRtWY6cs=;
 b=VcltdQQ1JufJOsLEtio7DXuronC6X+JrGPk1wZtzjNzdGPpxuu5ohGlhiCYQQUByqMNPQxDQZ+guYXZRN2yE6/XknosyEyyog23q4zOED2+x9bw9nX4c4+EfTaUpodWQi1SoF/WJ10TX8qJNdDHAn7ka6UJN3uLpYFBgMc83SzI=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by MN2PR18MB3685.namprd18.prod.outlook.com (2603:10b6:208:26b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 14:20:25 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4%6]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 14:20:24 +0000
From: Shijith Thotton <sthotton@marvell.com>
To: Jason Wang <jasowang@redhat.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "mst@redhat.com" <mst@redhat.com>,
        "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>,
        Srujana Challa <schalla@marvell.com>,
        Vamsi
 Krishna Attunuru <vattunuru@marvell.com>,
        Nithin Kumar Dabilpuram
	<ndabilpuram@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>,
        =?utf-8?B?RXVnZW5pbyBQw6lyZXo=?=
	<eperezma@redhat.com>,
        Satha Koteswara Rao Kottidi <skoteshwar@marvell.com>,
        open list <linux-kernel@vger.kernel.org>,
        Shijith Thotton
	<sthotton@marvell.com>
Subject: RE: [PATCH v3 4/4] vdpa/octeon_ep: read vendor-specific PCI
 capability
Thread-Topic: [PATCH v3 4/4] vdpa/octeon_ep: read vendor-specific PCI
 capability
Thread-Index: AQHbTUvv2mV3YxnNrUyyI5JMNPrScLLkORlw
Date: Fri, 13 Dec 2024 14:20:24 +0000
Message-ID:
 <PH0PR18MB4425BB6DE30C3805F31D75CED9382@PH0PR18MB4425.namprd18.prod.outlook.com>
References: <20241209151427.3720026-1-sthotton@marvell.com>
 <20241209151427.3720026-4-sthotton@marvell.com>
 <CACGkMEvuObS4RCk2BjQ4sm6r4jaC3fN4ui5EXd6SVzYxYZV7iA@mail.gmail.com>
 <PH0PR18MB442538D91F856F27F3C37A9AD9382@PH0PR18MB4425.namprd18.prod.outlook.com>
In-Reply-To:
 <PH0PR18MB442538D91F856F27F3C37A9AD9382@PH0PR18MB4425.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4425:EE_|MN2PR18MB3685:EE_
x-ms-office365-filtering-correlation-id: 99292335-f2bf-42ee-0642-08dd1b814924
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T3o2YkFZZWFNa1hpek1OWmhCaUxrbDZWUlYwQ0RFMVNuWW1ESmNwRGRRUWs3?=
 =?utf-8?B?Nk4vb1dOVXdEdVRjNzJ2N2JmdmovaEw3WWFkdzZhSGJGb3ExYnd1RGx0Z2Zz?=
 =?utf-8?B?RUsxcG9DVkZFZGwrWU5RTHNnL2lPWkN0RDZwOTA4aDVUc1hBS0xZMXhTNG5r?=
 =?utf-8?B?VHVlZWlNYlE3K1M3ZlNtTm1Gd3AwSTVxWkVIWGpiNktibUQ1c3VKNmZZbjJx?=
 =?utf-8?B?b3BteWVZQlA4MDFka01MMDZoa1krRkFCL0pIRmR4UURXdkw0S1NQeUh5bVIv?=
 =?utf-8?B?ZG9odXFpNEpDK1VsbjBsekVPQ0tFQWsrUXI2NWQzdHNNSjR4aUgxVzhmN091?=
 =?utf-8?B?eEpTWGh5ZkNZdDZiSm8vTjdGL3VkWjlMYTJla2dEWWU0YUlwY053MlJwSEp1?=
 =?utf-8?B?ZHhBeFZUVDh1ZTRZNDF3WVI0S1FhbkRCRFpmUzBzaXdTdVBDcDhDWlROeFhN?=
 =?utf-8?B?Uk1vOGloUmNMV3NFWnM2RzRaU1laVktpSURhL3VTa2EyZmIrbVB0Vm4wa2lj?=
 =?utf-8?B?NXRzcUo2aEN1ODNjSWhFekR0MkcxeXJ2ZVRWY1VhWU1KdnRneCtLa2NqOXRv?=
 =?utf-8?B?RWtKOFd0aGJwYkttdE9LZ2Z5c2lSeHhxZlQ3OG9jaDVZVXB2YUZtdXU5ejg1?=
 =?utf-8?B?bm93bi9YOVhHQWdRYUlET0tMUHMycHA5T0g5Vy9TblNUOTRHcmo3dllMTjlV?=
 =?utf-8?B?cTB6d1NrYVBaSXNiaE1NaVQ1VmplMFRxUWdKWXNkL0s3cSt3RU1MRDNreFJz?=
 =?utf-8?B?U0EwNnQ3Z0kwZ2E1ZEx6ZGVyaVpwYUFrQzFZbVVibmFqc0cvb1JjZk05Sm51?=
 =?utf-8?B?MmdGREFoQmgyU21RdllQU3ZIc09zRHpZOVRKTzFnYTNFbjlwVUoxR0xtY0Ux?=
 =?utf-8?B?S3ZvVjV3dXdqeWptbU1BYnZ2bm1iR0paQnNXYzlybVJ6OHFWeWM5ejdJK0tx?=
 =?utf-8?B?OUpUdnIvckwyem1kTHozS05JWXhjZUhEdXg1bVk4a1RhZUMzR3lCa09POHJw?=
 =?utf-8?B?N3NJQ0F5eEU4Yml6ZUJYd3J4U05HREtueUwzTVd2Sy9qTXZaQjdsTVJNK1R4?=
 =?utf-8?B?aEtQYUFlMjByVXExU2FYSnhlelhZUU5yVDRDWlBkd0N0MFlQZGF1QkxORC9T?=
 =?utf-8?B?MUJXU1dqdmJWOWlWZlpydzdCSGNtY1RwbDdrVzA1QkhKWHhKMFBvR3VuNGJI?=
 =?utf-8?B?elFkMlBCQ0JZYTNHMjdzVmNXM3NFQjF2VzYxZjRzRGpYbmdiSk9mVURrL3pE?=
 =?utf-8?B?S3FIR1VLVjFOZFFyelpURU5SakhFdVJLZ05OQ1ViVGlaSlZoRjV6U3VRZmNX?=
 =?utf-8?B?Q3pMZjhUWlVFK2hmOU5OZXlIc0FvT2F2KzdjTlVjdG5HL08ybE1VY0VYanRM?=
 =?utf-8?B?dUN0L1JTOFJsZFZGeUt3cklXbWZ2RkZ6Y1NvemxSVVRZaWJMODkxcHlmQjgr?=
 =?utf-8?B?bloxTFR2cHVSeTF2Wnh1bXRnNFBQa29lbVM3Z1B4cVBUTGdrUTZ5SzRvQWk2?=
 =?utf-8?B?Uy9CdEU2bnlCRnJuSjJqRkl5VWs2WGlGLzdwTXJpMEdaamEyditTQW1EaXl5?=
 =?utf-8?B?ZGNSUGxtTS9jRUpLOWdOYVR0UmtJTmpIMnQ2YzFvc2lMWFhXS3ZnVklFcWlB?=
 =?utf-8?B?d1VqWkYyLzB5Smo0Y0t1bjFRcXZJcXkzazJwRHBpbnRoSTlIOGhHMXo4Q2Fy?=
 =?utf-8?B?Tnd0dHBDSmxKR0pnS2ZGZWYxcVYycjVRbmR2RnV0S1JRYzdTMm1lc2dUNHJh?=
 =?utf-8?B?UGtsWWNnUTJvSjZ0VmJYRklXcy9Ud0FLQU1kKzMyQ0toT0hiZ2ZDZENJU2pH?=
 =?utf-8?B?OE05WVlXYU1OZ0N4Rlh3eDRHRVdZR1JYN0VabDhTWXdIbzQ2c29iTHZUUmhT?=
 =?utf-8?B?bkx3QVk3OEdBUThGK3dyN3dETnVIeVY0ZGdYWmdtek5kSkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2FnWmltQ2lCQzV3QVZyUWZKUGF4ekd2UnJYenVXRmpGVmVZZ0JaSlFTVXJt?=
 =?utf-8?B?TUVMeEFwNjBRcDNnT04yTCsyUDR1ZGZ6UWxwK2wrUkxDRzQ4WlRyZXlkV21H?=
 =?utf-8?B?V0xjdzJaN3o0dUZ5VGVJMXUzNXBtSXdtdjFzdDhXSnA3am5vWmc3MENKY3Fu?=
 =?utf-8?B?d2Myem5FSmVCYnhDdkdjZjM4UVJTSXpWelQrZ1h4bk52MEsrV3JNVE5zQlh5?=
 =?utf-8?B?a3hlbi8vT2NZYlUwZ2IxcXRMUEgyNTZ1S0xMTHVxR0NOOGR0V0VQYU1IVDVv?=
 =?utf-8?B?V1k4K3V5SFh0eUVQcmRrZEx5ejM3Kzh1eFo4KzlNc1Y2TWlyZEcxdTNFSGlP?=
 =?utf-8?B?TzV5T3hwcDFEc1M4R0l2NjFqN2EwVnE4STFidzJtTmVuRC9DSkxSTzhBSGgv?=
 =?utf-8?B?OVB4RmU4eWlhRUVTZVpWM0VRVFJXZVg4N24xb2hLUWVtbDJpL1BtemgyeHE3?=
 =?utf-8?B?cmxnekYreE94WWxmMXdoRlJVdVRkN3ZqTndwWVloemZSVE8ySmttZ002OFRa?=
 =?utf-8?B?Z2xqZzNYZU83SXI5RmVyb2xITjR4OG1VSDhkdXByUmFCRGtpdmwrdlNUdjhH?=
 =?utf-8?B?WVRoVGNiVVdZYVZWb1FRWUV1cExnRWsyVmxSYkxzQmZ3aEFEYWp3cGU3RFJF?=
 =?utf-8?B?eHZhS3pSOHJNUEYyN0N5Y2FCZWFURTBmNmdYUkpDMVRMNVRTSkVZOWpnTmJN?=
 =?utf-8?B?QWEwaEFDUndJQk1iZW5seWVyd2FGQzgyekNwZG1ibXBSbUVxZFNTWTB4blZP?=
 =?utf-8?B?VVg4VjVXd1Z2NVI5aEZXbmhXcFFKRnFPdmowbTR1Q0lwVFNEUFhQaGlYNG9o?=
 =?utf-8?B?cmFhdk1hZFdBYVV1cTdqREFmZ3FweUZXOTFvbytEMGR5N2V4bUVrcnliN3M2?=
 =?utf-8?B?ZjJmS3FzZXljSHRuOHMxZ3JrOS96M1NsWlQ0MXRYSXRpTTJ2aWU4ZWNlczM4?=
 =?utf-8?B?S3h5VTVmd2J2NkdYNjdNcEFjU3g3V21EeUVkbjltb3BOZlZidmJoUFBTb3FM?=
 =?utf-8?B?Q1EwcUhIWDVhSEdRRVYwQTZIaWk3ejdsY3M2K1lReU1Jb2VlUTRKSGI0V0tF?=
 =?utf-8?B?WjZ5ZENZTDBPWUlJNjFqWEtrODNWTWIvWXBMRGJQd2ZqWk1wRXpSQmhib0Nk?=
 =?utf-8?B?eWIrbGE4OWZ4bWdQc1dXbjQ1YW5hZFpxMnJOc25LUVhzVmVLWlB6aDQ1UnBk?=
 =?utf-8?B?Um5oRXloZTB4Nks2cm1zZkdkRUZYdEdxUjlTc2dCbVJ0Q25rZ2pmWmZ1TmFu?=
 =?utf-8?B?eXRMY3JIM0VLeFZMUFlXaTYzS3dIYmUxendNQmoyR29QVnpnc2JuUUlVWHd2?=
 =?utf-8?B?WFplU005VXJHcnN1MG15UzdDQ1lOcE5MUG4vUnJyL2hmRFducEppOVRhLzgw?=
 =?utf-8?B?clV3akQ5YjhSSmZqTkJPKzdYdE1oVkVRS1QvWDI1K0Z2MUtiMVQ4dVNkU2pT?=
 =?utf-8?B?RDR2bEdBUnYwVjZmdDJ6WjVFSVBjdTI3Q0RlWGIwUFp3MFlkZXNQVXd6UzlZ?=
 =?utf-8?B?enVIb2g3Tm03OXpuRENiZ3FtRVNQbmtsSWhDYjZsdDdHc01MQXFNZm5HVjhG?=
 =?utf-8?B?RjBDdTZNSWNaZU0xNE9oUENiSGY4d2htM3BMQXlTRTlsSnpDL0l0YitaU0VU?=
 =?utf-8?B?dWcrTXNXRy9nWklvYk1HRVBSYk1jM1YvRExTRkwrbmlYT0l2UTh3ZEhvN2NO?=
 =?utf-8?B?MlkyRitvdlhWQVo0YjYxb3RhcVg2Vkd0MkdnN1habVRYZE1YLzE0S090Qmdt?=
 =?utf-8?B?TUxrUldyNStlQS9BUnN5MDhNckNRVzlVNGFQOThoQmlzUGtEZXZoQ0hXUU9L?=
 =?utf-8?B?cTFnd3BSdE5sVEdXblRaWjcrS3p4NTd1dFllOVJQQXloTURCNmNPYis5OVRY?=
 =?utf-8?B?QTFtb3hLS1NaMnI3YTh6MWJmQlV4R1J6ZFpXUDB4NGpVSEhwOW04c0pNdXlO?=
 =?utf-8?B?bHF0MVFlS1FqaWdUKy9qZ05leEhKbnNZWTVqd1dnN2daR0hjYllnaXVxb2cr?=
 =?utf-8?B?WHlaRXhPbE9udkRNMUhJcStaenZ4OU1GTFJCRDVrYW5JWW85bnVMWTZLTGp4?=
 =?utf-8?B?eW52RFdvVFVpeWhxOFYwbWpRTmpyZU40eU5yaDRobXZjNVEwVUZZM0VPMitD?=
 =?utf-8?B?WVF2ZitCWXgzRDY4MUJvVjRCcDNKTlQwRGFwUHZDSHNmcXl1UVpURnFTZmpk?=
 =?utf-8?Q?aBplKM6FuIMfAchYFZLoyhBWgImYHMdIH5ye/WedvzJH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4425.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99292335-f2bf-42ee-0642-08dd1b814924
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 14:20:24.7784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1HHHqSNE8TGafd3zFDBmVnmYRtvno9DklmFZvQKQthBKc6/LqyyI8eJVuiNAZOtQphwOIRKY7+wNqwY8AC0L2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3685
X-Proofpoint-GUID: slql-fThHvLlYKHlI_x2nZA9Gzz4U3vR
X-Proofpoint-ORIG-GUID: slql-fThHvLlYKHlI_x2nZA9Gzz4U3vR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Pj4+DQo+Pj4gQWRkZWQgc3VwcG9ydCB0byByZWFkIHRoZSB2ZW5kb3Itc3BlY2lmaWMgUENJIGNh
cGFiaWxpdHkgdG8gaWRlbnRpZnkgdGhlDQo+Pj4gdHlwZSBvZiBkZXZpY2UgYmVpbmcgZW11bGF0
ZWQuDQo+Pj4NCj4+PiBSZXZpZXdlZC1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBs
aW5hcm8ub3JnPg0KPj4+IFNpZ25lZC1vZmYtYnk6IFNoaWppdGggVGhvdHRvbiA8c3Rob3R0b25A
bWFydmVsbC5jb20+DQo+Pj4gLS0tDQo+Pj4gIGRyaXZlcnMvdmRwYS9vY3Rlb25fZXAvb2N0ZXBf
dmRwYS5oICAgICAgfCAyMCArKysrKysrKysrKysrKw0KPj4+ICBkcml2ZXJzL3ZkcGEvb2N0ZW9u
X2VwL29jdGVwX3ZkcGFfaHcuYyAgIHwgMzMNCj4+KysrKysrKysrKysrKysrKysrKysrKystDQo+
Pj4gIGRyaXZlcnMvdmRwYS9vY3Rlb25fZXAvb2N0ZXBfdmRwYV9tYWluLmMgfCAgNCArKy0NCj4+
PiAgMyBmaWxlcyBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+
DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9vY3Rlb25fZXAvb2N0ZXBfdmRwYS5oDQo+
PmIvZHJpdmVycy92ZHBhL29jdGVvbl9lcC9vY3RlcF92ZHBhLmgNCj4+PiBpbmRleCAyY2FkYjg3
OGU2NzkuLjUzYjAyMGIwMTlmNyAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvb2N0ZW9u
X2VwL29jdGVwX3ZkcGEuaA0KPj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9vY3Rlb25fZXAvb2N0ZXBf
dmRwYS5oDQo+Pj4gQEAgLTgsNiArOCw3IEBADQo+Pj4gICNpbmNsdWRlIDxsaW51eC9wY2lfcmVn
cy5oPg0KPj4+ICAjaW5jbHVkZSA8bGludXgvdmRwYS5oPg0KPj4+ICAjaW5jbHVkZSA8bGludXgv
dmlydGlvX3BjaV9tb2Rlcm4uaD4NCj4+PiArI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX2Ny
eXB0by5oPg0KPj4+ICAjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9fbmV0Lmg+DQo+Pj4gICNp
bmNsdWRlIDx1YXBpL2xpbnV4L3ZpcnRpb19ibGsuaD4NCj4+PiAgI2luY2x1ZGUgPHVhcGkvbGlu
dXgvdmlydGlvX2NvbmZpZy5oPg0KPj4+IEBAIC01Miw2ICs1MywyNCBAQCBzdHJ1Y3Qgb2N0ZXBf
dnJpbmdfaW5mbyB7DQo+Pj4gICAgICAgICBwaHlzX2FkZHJfdCBub3RpZnlfcGE7DQo+Pj4gIH07
DQo+Pj4NCj4+PiArZW51bSBvY3RlcF9wY2lfdm5kcl9jZmdfdHlwZSB7DQo+Pj4gKyAgICAgICBP
Q1RFUF9QQ0lfVk5EUl9DRkdfVFlQRV9WSVJUSU9fSUQsDQo+Pj4gKyAgICAgICBPQ1RFUF9QQ0lf
Vk5EUl9DRkdfVFlQRV9NQVgsDQo+Pj4gK307DQo+Pj4gKw0KPj4+ICtzdHJ1Y3Qgb2N0ZXBfcGNp
X3ZuZHJfZGF0YSB7DQo+Pj4gKyAgICAgICBzdHJ1Y3QgdmlydGlvX3BjaV92bmRyX2RhdGEgaGRy
Ow0KPj4+ICsgICAgICAgdTggaWQ7DQo+Pj4gKyAgICAgICB1OCBiYXI7DQo+Pj4gKyAgICAgICB1
bmlvbiB7DQo+Pj4gKyAgICAgICAgICAgICAgIHU2NCBkYXRhOw0KPj4+ICsgICAgICAgICAgICAg
ICBzdHJ1Y3Qgew0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHUzMiBvZmZzZXQ7DQo+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgdTMyIGxlbmd0aDsNCj4+PiArICAgICAgICAgICAgICAg
fTsNCj4+PiArICAgICAgIH07DQo+Pj4gK307DQo+Pg0KPj5UaGlzIHNlZW1zIG5vdCB0byBiZSBw
YWRkZWQgdG8gYSBtdWx0aXBsZSBvZiA0IGJ5dGVzPw0KPj4NCj4NCj5Mb29rcyBsaWtlLCB0aGUg
c3RydWN0dXJlIGlzIG5hdHVyYWxseSBhbGlnbmVkLg0KPg0KPnN0cnVjdCB2aXJ0aW9fcGNpX3Zu
ZHJfZGF0YSB7DQo+ICAgICAgICB1aW50OF90ICAgICAgICAgICAgICAgICAgICBjYXBfdm5kcjsg
ICAgICAgICAgICAgLyogICAgIDAgICAgIDEgKi8NCj4gICAgICAgIHVpbnQ4X3QgICAgICAgICAg
ICAgICAgICAgIGNhcF9uZXh0OyAgICAgICAgICAgICAvKiAgICAgMSAgICAgMSAqLw0KPiAgICAg
ICAgdWludDhfdCAgICAgICAgICAgICAgICAgICAgY2FwX2xlbjsgICAgICAgICAgICAgIC8qICAg
ICAyICAgICAxICovDQo+ICAgICAgICB1aW50OF90ICAgICAgICAgICAgICAgICAgICBjZmdfdHlw
ZTsgICAgICAgICAgICAgLyogICAgIDMgICAgIDEgKi8NCj4gICAgICAgIHVpbnQxNl90ICAgICAg
ICAgICAgICAgICAgIHZlbmRvcl9pZDsgICAgICAgICAgICAvKiAgICAgNCAgICAgMiAqLw0KPiAg
ICAgICAgLyogc2l6ZTogNiwgY2FjaGVsaW5lczogMSwgbWVtYmVyczogNSAqLw0KPiAgICAgICAg
LyogbGFzdCBjYWNoZWxpbmU6IDYgYnl0ZXMgKi8NCj59Ow0KPnN0cnVjdCBvY3RlcF9wY2lfdm5k
cl9kYXRhIHsNCj4gICAgICAgIHN0cnVjdCB2aXJ0aW9fcGNpX3ZuZHJfZGF0YSBoZHI7ICAgICAg
ICAgICAgICAgICAvKiAgICAgMCAgICAgNiAqLw0KPiAgICAgICAgdWludDhfdCAgICAgICAgICAg
ICAgICAgICAgaWQ7ICAgICAgICAgICAgICAgICAgIC8qICAgICA2ICAgICAxICovDQo+ICAgICAg
ICB1aW50OF90ICAgICAgICAgICAgICAgICAgICBiYXI7ICAgICAgICAgICAgICAgICAgLyogICAg
IDcgICAgIDEgKi8NCj4gICAgICAgIHVuaW9uIHsNCj4gICAgICAgICAgICAgICAgdWludDY0X3Qg
ICAgICAgICAgIGRhdGE7ICAgICAgICAgICAgICAgICAvKiAgICAgOCAgICAgOCAqLw0KPiAgICAg
ICAgICAgICAgICBzdHJ1Y3Qgew0KPiAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90ICAg
b2Zmc2V0OyAgICAgICAgICAgICAgIC8qICAgICA4ICAgICA0ICovDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgdWludDMyX3QgICBsZW5ndGg7ICAgICAgICAgICAgICAgLyogICAgMTIgICAgIDQg
Ki8NCj4gICAgICAgICAgICAgICAgfTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAvKiAgICAgOCAgICAgOCAqLw0KPiAgICAgICAgfTsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIC8qICAgICA4ICAgICA4ICovDQo+DQo+ICAgICAgICAv
KiBzaXplOiAxNiwgY2FjaGVsaW5lczogMSwgbWVtYmVyczogNCAqLw0KPiAgICAgICAgLyogbGFz
dCBjYWNoZWxpbmU6IDE2IGJ5dGVzICovDQo+fTsNCj4NCj5JIHdpbGwgYWRkIF9fYXR0cmlidXRl
X18oKGFsaWduZWQoNCkpKSB0byBiZSBzYWZlLg0KPg0KDQpTbWFsbCBjb3JyZWN0aW9uLCBJIG1l
YW50ICAgX19hdHRyaWJ1dGVfXygocGFja2VkLCBhbGlnbmVkKDQpKSkuDQoNClRoYW5rcywNClNo
aWppdGgNCg==
