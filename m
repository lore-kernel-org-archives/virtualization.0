Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26961A0BD1
	for <virtualization@lists.linux-foundation.org>; Thu, 31 Oct 2024 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730396523; cv=fail; b=szsLWG5vKgbhvRaWSM6lP4CjEPqc0FrN8q9riWXCxAvdNAib+amW81mYqe3MCPv0U6KGH41wNhzE4HlX+uuRewcb1sv4eVxJrZFuJuMy9OM93Ld2bB5iVusYmZNqqnAN1wSn1JU2zl19OSHbWnNwNfwPfyBOJ9pphmF607Tm2KU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730396523; c=relaxed/simple;
	bh=LZecrbSTYuN1bhHDYmIi6McQCSpSBF5gtCuF5PjDc3U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=beayYIsaPkT7eBiXBofAsYo6vIyWGpXaSNVjfNI54012V5RA4uE/y0OaqllBKdN9nyoO2/1cB1cN1uumNlOBopglwWQqD9FzhNxecR0QJRiKdHd1v7B/bHIp2ldgTmwlsy10gFr06s1YBO87Yjqk3EXHD8TXCnqQEXGoUS4wxr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P/5p+Bm5; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P/5p+Bm5"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADBEF80D69
	for <virtualization@lists.linux-foundation.org>; Thu, 31 Oct 2024 17:42:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.104
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id We4yfVqZbJJz for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Oct 2024 17:42:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2405::623; helo=nam02-dm3-obe.outbound.protection.outlook.com; envelope-from=feliu@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DC1E980F5D
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DC1E980F5D
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=P/5p+Bm5
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20623.outbound.protection.outlook.com [IPv6:2a01:111:f403:2405::623])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DC1E980F5D
	for <virtualization@lists.linux-foundation.org>; Thu, 31 Oct 2024 17:42:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTlf1x+VMc7Ox8OQOFTf2GjvITJyu7hknH613EG5rJm20W+Sq7xCXCpBQz+soFWKy5UpW6TyYbdxsLpbl6xYAfHO49GSRLFjE8Cr3fUZNS+3p+KhOyb3speAGySOzYnOEZTt/f9nA14AeYkTkUXxXMhR0abLTtQUUJH8Tf/815SzITqg8NWwQlJ21H+VPDsuMWuCrOiVAPaS1lcni4kkMBLb+H1k+tK5pbK9kXi12sWN6il1hHfoaG61zR77gq3NvKCrBKMAVHg/gQe3koX7USfdeFzol3l/1unq5NT78O/NpHwWEniA7BUIu08+Yb0Rt1oVU01dU9feU6V3RieKXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhkD6L4yL+o23ClxHRy6QYFGw/06nFWIvy5nBfH6AV8=;
 b=XafAEY5Xk4ohFylZLuFi08xiKm9tEDU7Q2KirRKOh+WE+lXNQIFXBOOnIzsmEkTI/c5jeJpn9oSfvVAVxZ5Jhdi9YXoLijG4aZap69InH81ruJkEKVqDC2J509TEVbG862h4rvP3LH3i5FrknuCL77wbzQw1IhNiJsXVAV0oW8rvIaBUQYZAlOMacmJp3V+GODlKaPjH20PmNKDhI4iWrXxboJLP4uquXjtHL4tVD2LUIaRE0VW2t2gmhEmtlN796HXxIQf9YcJH6AmvOcnE0eLCMeOnJgdjT0d6dL46zfYWBMP5jyAxXyIIZo19zc7xW8RaPonEkSoeM52+ah48MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhkD6L4yL+o23ClxHRy6QYFGw/06nFWIvy5nBfH6AV8=;
 b=P/5p+Bm5ANJPStoXnufrB9WWl7h0aSHPXQDn5oLwqiTG7NgRacbGjCPbMU25OqPaLI2C0bm3unwiEAyn99u4ghhuGjDY7J+ZJ0MJqAj2mJwS1PwsoS0LznE0hO3XuBaC60Hu7q9ZQpq59X/Xgfrrv9SHIM9vr0LzO58id7v5SkfD22NIdHUQZIPRlHAnmKcxQeQADSC0lkgCUB0X9z0M8SdLzgrWJeJxIfg+a7vQMK3fhCDfHWdodPYv/hB5rnxBbYB+dsWAsn1Z/EqeTmkVvNuJTV8zVBu1OYeJxJez/o1iieZTE8mO/VOSvP9Xq8MRbrRjBFUgXa2Qwy8TfJKyHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20)
 by SA1PR12MB6800.namprd12.prod.outlook.com (2603:10b6:806:25c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Thu, 31 Oct
 2024 17:41:56 +0000
Received: from BL1PR12MB5825.namprd12.prod.outlook.com
 ([fe80::547e:4121:7ab1:9065]) by BL1PR12MB5825.namprd12.prod.outlook.com
 ([fe80::547e:4121:7ab1:9065%7]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 17:41:56 +0000
Message-ID: <0c96bb82-c638-aac1-2ee9-cb3c79302b4f@nvidia.com>
Date: Thu, 31 Oct 2024 13:41:53 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] virtio_pci: Fix admin vq cleanup by using correct info
 pointer
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jason Wang
 <jasowang@redhat.com>, Bodong Wang <bodong@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Parav Pandit <parav@nvidia.com>
References: <20241024135406.81388-1-feliu@nvidia.com>
 <39714b40-28d4-91d8-774e-9c8d91461d28@nvidia.com>
 <5045b28d-32e9-349a-fc4d-ae2a995437a9@nvidia.com>
 <20241031125215-mutt-send-email-mst@kernel.org>
From: Feng Liu <feliu@nvidia.com>
In-Reply-To: <20241031125215-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0016.namprd21.prod.outlook.com
 (2603:10b6:805:106::26) To BL1PR12MB5825.namprd12.prod.outlook.com
 (2603:10b6:208:394::20)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5825:EE_|SA1PR12MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c83b53-6fdc-4cf3-8bb2-08dcf9d3504f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFErZk5xZjNoZ1dIOHR5OWo2SjFIUis1L0wra3ZrQ21oVWFpR0IyODFSM1Vo?=
 =?utf-8?B?a1l3Q0pDZFJ4M09sNythOFMycENvTU9XVkZmemNxZXJPcnZleXhJOUdoQXEv?=
 =?utf-8?B?aTIvdlhSLzZFcUhQeFV1dlFVREFyQngzNkNDZjJ6U0dxamNidzhJTlBzK2hv?=
 =?utf-8?B?VE1jMnllWWJ3UTd6UjhHM2RQaFpzTDRrZytDbG9ZY0tmdEQxNEJnQUNzU2l3?=
 =?utf-8?B?R0QrM2dYNk9ySjVvQW05QTNRMUhPNFVuZVBYREgxRjBaUDlmV2pOL09HZTBB?=
 =?utf-8?B?RVdHc1lNbHdyb01QcDdjbm9LNnRhV3BmNTE2VExlZ2NiZ2N5Zmh3ZFF6LzRE?=
 =?utf-8?B?Q3VjRzJSZnFDR2gyMmpORXFqNW1Vb3pIQnJHTFZaUWJPb0kxUldJS0NSYVVy?=
 =?utf-8?B?L0FPK25lSmtHUXNoWkErQnR5Q3UzSm1CeVMvQ1RSV1krYjgyVmVVSE41SVJT?=
 =?utf-8?B?bHlYV1RXY291dTJoN0dZRHVzM1BBQkpZK3doY3I0M0pRNGIxRVgzNWpyNTMr?=
 =?utf-8?B?TEtHeExRQ05STlUxZHZPZXgxSXJWWTRVTVFnKzVxL2xNQmk5RGlSeURPQlpl?=
 =?utf-8?B?NlhFcnVFazIzSDJ4ejNBMFR6RnE4SnNpd1plU3dBVk0zbDZZbUVPL0ptWmlk?=
 =?utf-8?B?NGNXcHJMVHkzZnMzcm01bEk3OWphb1lXSmd0RFFUSmdmLzUzQUN2UmFZNVNG?=
 =?utf-8?B?Z25mc2FvLzVlbUtvR2hHMXdlRjQwblJ2TWV3aWltZk9SQ3ExNU4rSVNJQjN0?=
 =?utf-8?B?V0dvTGl5TTlNWGErUDFtU0hYeFBkTmhEbW1jdnYzTDE0YTlVeElIZUhwWlRm?=
 =?utf-8?B?Z0J5OXR0ZXFaUnBoVXZyM2VmMmhHTVJMTm50VzJDV2xWQWdNV3JpUWpqMkM5?=
 =?utf-8?B?aEJTbVErNloxTzQzVkt5alBVV1lLNUJtOFZYMURKOXVEZTN5S25JbExkbTNh?=
 =?utf-8?B?V2ttOXhiS0xaNVpZYkE3NzljZTk5bnpIekxhSTRHT3hFR290WjJvRzdpTWk0?=
 =?utf-8?B?WDRqZHhlaEdOL1duKzdibG03ZVVPeFM2NitiMUp3VHMrcExhSWw4Tm9vZk85?=
 =?utf-8?B?dVpqa0kwSkRQYVQ4aWZjV2ZQdjBTSVVUS1dxWUpTK0VXcERJeUFUODNUSHNk?=
 =?utf-8?B?ekltYnptV3F5YmVVUEpRWmMxUEFtZlpSQm0ra043TEFMcGZ2ZUV1NWFmSW4r?=
 =?utf-8?B?K2Y4SVFOcGRNMlRFT0RVZVRmZUNrRkhGenEydHRXSGFHWlBhNmwrdTA3VEdy?=
 =?utf-8?B?Qm5ZZzNLZFZFNnVYUnBLWGhtTGRwVTBBdTQ4b0YxZ0I4aHp2amhiVVhRcVJt?=
 =?utf-8?B?WVdsZVRzVzM1dkpESVRGNnpvczBndll1bFZLQ21NZG9qWmZVeXVxNGZhZ20v?=
 =?utf-8?B?bG1SVEk2Y2dsZXczY0VvakIrdWVMeTQ5UWt2VmljMWYzakMxa05FMWQ0S3lw?=
 =?utf-8?B?WmQ0MENURXlmYVRRYnVHZW1yVjNENWVkWSt5eWRjUURleFArRVFrS29DbjRZ?=
 =?utf-8?B?bWZVQlpkQnd5SnpnaExyTXhFUXZ2YTVqVjdBOGFCQnU4a3FQQTQvc1VhVzMy?=
 =?utf-8?B?d01XanJ4T1AvSXRLU3RMVXhXeGFaMlFmcSswRTN3VmoyNnRwVGhrQVdyaGcy?=
 =?utf-8?B?MjQvMHVybkM4S0dvR3lnR1UrblMyVUIxdlN5VWhabmxWMURyTVlkRFBGTDQ2?=
 =?utf-8?B?bzdYM0djVHFaWUUzdFVUYzBSRXd6RXBrMWhVa0kzTVAxU0FWUTUwbXVqSkth?=
 =?utf-8?Q?a75wYzYOOqjWa/7L0VQAt1eUf4YP0Ku6lvYp8jQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5825.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?citFOEYvazdmclJpcjlUOHlWdWFsRklUSjZXWmFSR3ViamNyak5tcFhKUmtT?=
 =?utf-8?B?OWVYbUl3bVJSRXFGMUdZU1ZuM0I3ZG5SMVRjOTN0U2hHbVNzanBhVVV3WHA3?=
 =?utf-8?B?VFhjanNyNXZhL1hXWHNRQTVTVU5qNm4reWE4VFY2YWE3RHhMOCtSdElWQ2NJ?=
 =?utf-8?B?dUNkMDFtVTkxcnJ4eWxWUjZTNjlLUHAwTU94dTZibU9mQm1oWmwrdFJjbnlp?=
 =?utf-8?B?Q0xXc0N2NlpyTkUvZ2lsdkFnVXpjSThQVy9oNEhZVExSaXhUaTI1blhEQW11?=
 =?utf-8?B?RWRWanN6b0x0T2Q2TjQ3NTYzU2lBSmVTMW43SGNrcU1MNktYYkQ2Ty8yWldJ?=
 =?utf-8?B?bDZNTnc2bEY3dHVwenRkOHVIU1RTNDUvekxWcFBTVEVUMnB3Mit1VXUzcEkz?=
 =?utf-8?B?YTRSSmdaUFNEcHFnUEYwNklqOWd5c2hKM2JnTmRaVWNiTlZjNEQ3RTN1eDlI?=
 =?utf-8?B?ZXZ6NERNQU5SeUR3Z1pIQWwvQzhYaUVJZUx1T254WVQzNDVCeHI0UFZIMlky?=
 =?utf-8?B?SGlkZ1AwWjc5SFkvZUFtejFDSXNVUWs5QlZhQk5qbmlDY2VTZlZMZ0hQSUhU?=
 =?utf-8?B?bWgrN3NyMFpsYWlSSkV5ZGwwemRTcFB2WU95dVBhcXJpRVl4UFFIRGcyVkNn?=
 =?utf-8?B?SGFZdFZ0RE1vaEo3bUVhV0FEeDl5RnVHRkJpTS8ycnI1dEdXSUtONnBESDdh?=
 =?utf-8?B?bERaaDU4NnRjOS9mUStPa2ZhR21PUjlCTW84cVlEWnhCSENuNnpsdUQ0MmJW?=
 =?utf-8?B?ZjZRa3c3V25XQlRzNmF3T3pJTXg5eVlPbHJ0a1hoSUdvcFBXcUVkZ3VlMnZa?=
 =?utf-8?B?cGF1cGtNSmJDcGtjSzQxTElMS0pQUEtNY3N0bkRralVKVGpXR2trSmNaMnNJ?=
 =?utf-8?B?REhydG5GM3kzbk1taG1wY0czdXRjSEhXaXdTR3M1ZExkQXlhd0RBNWJKSDZI?=
 =?utf-8?B?TTgxeHRjYkcxRUpjOXY3aFF1YzlkaUxsQWtBK2tLdXFZN0I0a3ZoY0FFT1B5?=
 =?utf-8?B?N2x0emI5YW00b3ZiWGt3aXhNMHEvcHFBNTlQQ3MyaTBFeEMwczdzNVY3NDlR?=
 =?utf-8?B?Z0RscmhGMFpoMFdtemtrcHc3ZzVUK3JoS2RWUlUwRzZFLytLSkR3M0pzdnhY?=
 =?utf-8?B?SkdzRWo0dDQyMWN5dzJHVUcyN2FTQkVUU0xxVEEzQnpZR3hFam9QNjgrSVJY?=
 =?utf-8?B?SEZQZGI1bWRBUWkxbXNzeitILzcyKzRJZlJTOGRIcW5HdXcrdVQ1Z0p2MEZx?=
 =?utf-8?B?Y3d3dDIrRUUwaFZ1cnZ0VGRYdnlzeWx4VVcvVnErbDIwdUErQXhTc0Jhamto?=
 =?utf-8?B?dWFzcGJtTlMwc3U2U0FwNHRhRXRCU3RjZzVmQXNqbzZPdkRZdWRvOFRRcURX?=
 =?utf-8?B?VVhITVFmeEFpWkM2dTBRdEMyaGMwdEQ2Rzk3b0JCbVVJUUFIZGNVdmI0Y1FB?=
 =?utf-8?B?Q01tcWRlWDF6NkZVaHBpSVJEdHhUYmR3T0VQdHZIcVVaSmQwKzk0T1BKbnNW?=
 =?utf-8?B?YThaVUhYK0E4dzVXSFkzY0xvU29hZ1EwLzl4TzlpUWU5a0ZwNk9pQTkwLzlp?=
 =?utf-8?B?Q2tTWmpmaGViQjRCUnBSV1ZmalBmY2U0bnhhK2VESDFjVzBTOUhnY3J4RXpM?=
 =?utf-8?B?aWxISEVsRWV5dG04amQyUUNoKzJWeVNzTm5OL3grWjNROXJXcXpIRGN2bFpP?=
 =?utf-8?B?L1Q4K0Vzb2pDNzJnNnBxOXc4aTBBWVoxcUdqVDBCWWlQQUtlQWVXWHBJV3NL?=
 =?utf-8?B?OFBLYVZGSjNBRXdwbk51RzJOcWN1V2s4RTQvM2Q4bms4VHdhUWxnNDdRUUNB?=
 =?utf-8?B?bnZ0Y21GZFpwZE12eVZhT29ERVQzUC9tMXVneTFtRVZwbXRxOXV2elh2NUVC?=
 =?utf-8?B?Q212c2NLZVhQc2I4a0thSUdFenNjTzQ0UHZMOWNHZU9STTJHN3AwT1hBYmxq?=
 =?utf-8?B?Z1dkTncvbStoNWxPa3Zmck9JeVdTNENUOVpoTXV4T2RRbm00MlRKcWVLa3Ji?=
 =?utf-8?B?TjdMTkRhby83d2dNaXQ4ampnM2FnZlZ6amJaZzFqcVdkc2s4dTdpbUJTbWEx?=
 =?utf-8?B?bVQ0RTFrN0tzdTZBditweU02VXpwa2pWRldCYmMzNnFKaGM1MGpNRG5zSk55?=
 =?utf-8?Q?PAd50GOBLL8UNGVHUxXjDKTZP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c83b53-6fdc-4cf3-8bb2-08dcf9d3504f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5825.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 17:41:56.2545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GphR0HX4B6n0lCCppaNV060KIhpA5MXG3nPBDisccBXBulGg8OQ7IYu6pvL5mwY3Pf9XfqL/J1tx5jQPHHr7wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800



On 2024-10-31 p.m.12:52, Michael S. Tsirkin wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Oct 31, 2024 at 10:17:00AM -0400, Feng Liu wrote:
>> Hi,
>>
>> Excuse me. Have any comments for this patch?
>>
>> Thanks
>> Feng
> 
> it's tagged, will be in the next pull. Thanks!
> 

Thanks Michael.

BR
Feng
