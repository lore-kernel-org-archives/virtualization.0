Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE0CD512
	for <virtualization@lists.linux.dev>; Wed, 28 Aug 2024 05:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824501; cv=fail; b=hmzjSYrh9js9mmWUuJifR0LnmASH9Wp04RmrXZLbXCnK/Ga7XEya4DWi+D9LHECXIv1lg1xYuPSTl+TBbnW8E16dvWhMF5sIakFZJQje1XmLtpCdyPUmkGNRUdhp8UicHt2n78n4uc3IZj9jxBqwE0yXcYc9HFB80KApjzVQuJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824501; c=relaxed/simple;
	bh=IAAMY3zhpfnAPu1K4EMogwLEz/5pS5KY3aUp+JplQHw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sKxcEmT4XCduEifZB0k+J8iXVp3kdwv4siI+8/5+T9/6ADMghR69wh7dgWx8vfnAFVqLuCMr2SUEypTCtrMzDU+AdnPScrwyrP27z+u7zE8NpWJ55q86wap0jGDwQH5ke4FTEvKqukfZ7o3VivaDZBE2ex2aor9nGoitUTAERJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jWnQG2IM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EyzzOVsZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jWnQG2IM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EyzzOVsZ"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RLfb96009623;
	Wed, 28 Aug 2024 05:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=4tm5P0CXFYzvzmulItOxfiEOOdPRR2x6JOpAPEWZZd4=; b=
	jWnQG2IM1aDcV49DQX9ZDFTgb/ff9YcT2ZNXEFH0xqvKHLwuL5DWdYwaZXXCLV5B
	oz92Ix8BTQ2F6XulwXUTXNWxEcWEYY6hrora4xPEl7zFm7/sfk7mfInOgpk3GhEH
	h4kPLWgIOcqGafBoEj2qsEeQvs4spirCKJCQ97HZsDry9bvEwaiyRxiudfMVT6U1
	x2Dk97UAmyN0TNaomN4Eltiygt3ccQkuyWG1fF2eIUJ4v6GZnjP/WGIbeWqAonbC
	J27WEhFts46X7xiQ+rMwWBVEHME0wuhZOYuIJj5QcUldj5fax+mWn1SOrrhiZK+J
	AYJhS5491IwWIXIZoeIpbg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pup0g7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 05:54:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47S5XVUT020156;
	Wed, 28 Aug 2024 05:54:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8nkym6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 05:54:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anii/Y828V5SjnsC31vcKPsZ8cRmbA1c9E4iAlfpg+orGHyKt2wOS/IOGe0Cg+6EHzRk5/L1YEL73lE9BEuLQVz0hBOVxZWIbLp2A9Qq/GAsz1Z6mt6wZ5hCHwMdhtqI+0xzWA8tWeKcpMxlR+l6fCAYmVK+y3DYmZXw+2vG+j98Uxe6ogiwrAAhm9o6xY7CQz4ULV1IXoJ6WL7AaDjYNS4aOZVmpu2ndfcCMg/2QtKYe+Nn1XoST/fim/Dcd18WfdDUiUHFykBnDzJJU9Lsr+O2+7jj6oC0gzgI+gzYbpRXeyoE7whCbpWlwJZFIhVse73Z08LlEpkgO7ttemCByw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tm5P0CXFYzvzmulItOxfiEOOdPRR2x6JOpAPEWZZd4=;
 b=BzbxUoMLAfOjQYxDA+U8PWRT7FHnr9G64KMV9isW4R3SLEn5tEVmPqH7714+O5BRqrgtLwnJG47ApHWqaJXKxkpnjJMrqdt7CBNYwgQPB6hvSBHwOgHO9uoosjdpZYt5hXOtHjh1e5n0pvlaZAQbgffNGXSgtTr9TszvZOjovkZZnAWYChN2/VRg9wUjSuyR0+S+tWdCfSdVIXl3RAGtYWjA7yDziuJz+AB48V93YJDIH41qH+MLUmGN07Z13A6ObIJkqzu5OlVEfeazaxi1Uixg+hxyVHoN5bKBMKcUfVBRzEs8vxZcVrZJMZumYCVYbm5xNXtQ5vVgy5pb7jNmIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tm5P0CXFYzvzmulItOxfiEOOdPRR2x6JOpAPEWZZd4=;
 b=EyzzOVsZkgxVdIymgJxmMkZEGwu8rA6yvZa64G0SDw7heycEFWXhbKKNc4FsgkI7N7Ta0SkQ8PWVLvrmtW2iFyp2BvXXyZwa3vIuNj8yDh/WbqXcluPOx8lz7KTYRRZ+4t+DuYYuG6byV5ATBIavPnFONC9Q6ps3fwJmT0Ab70M=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH0PR10MB4969.namprd10.prod.outlook.com (2603:10b6:610:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Wed, 28 Aug
 2024 05:54:36 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86%3]) with mapi id 15.20.7897.014; Wed, 28 Aug 2024
 05:54:36 +0000
Message-ID: <3d9509c2-f052-be94-db9b-ef501c880415@oracle.com>
Date: Tue, 27 Aug 2024 22:54:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC address when no nic vport MAC
 set
Content-Language: en-US
To: Dragos Tatulea <dtatulea@nvidia.com>,
        "Michael S. Tsirkin"
 <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=c3=a9rez?=
 <eperezma@redhat.com>
Cc: Jiri Pirko <jiri@nvidia.com>, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20240827160256.2446626-2-dtatulea@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240827160256.2446626-2-dtatulea@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0092.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::33) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH0PR10MB4969:EE_
X-MS-Office365-Filtering-Correlation-Id: f78cb86c-0695-41d1-fd32-08dcc725e57f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cElMUU84SUc2Uzlmd05nSlIvZnQ3ajFJcVUrcVJyNDRFa2E2T3FxTVlWa2xl?=
 =?utf-8?B?V0QrSGNTMzl1b2NDZmIycHJpQ054OUxXVzlJV0k3aXZnU0U1Y2xyTVhMay9q?=
 =?utf-8?B?bkIrNTZ5YTQzdzlkbEVPK1I3eVlJQXhvN0dFZC93SldaSVBHQ3RONGRMVzdr?=
 =?utf-8?B?V2pQVE9uZ3BBalhqZm1QUmRobWFlT1lGeE5NSVdXMzI4ZGVuZERhMmVRcXRS?=
 =?utf-8?B?M0NycEx0RS9BQk5uaVRJWXlGWlNxVy9pUFJKTk0zdXowME5lbXprdEppZTJU?=
 =?utf-8?B?aFJ3eVNNRzdNTU5PZ2VnanNsYVpkSUVWWXZKTHlkYVRFUUJiSHd4dlYzbHgw?=
 =?utf-8?B?Z08vTDhnSnBkd1BYMWVhdXNnQXhBS3J3RUFtM0MyYjluVHVJd3VKNUwrL0dD?=
 =?utf-8?B?MFljQTY5aFdNR0Z2aEtRSEYzejc0RTl4QUM0UTJzMjNGMk9xQUk5UEt1cGpi?=
 =?utf-8?B?RFh2djBLYllBRGpna2c2cDBjZG51SlJZeTVmZHlQdDRIUW1VZmlkRnBiaWt3?=
 =?utf-8?B?NWVzTWxyT2RQYjBXanp6VGFQaGk3OWplSWNWUWRhbVdsbnJwZGlmT0ladUZn?=
 =?utf-8?B?bjVKV1psUER1a3ZaelJuelRFRnFnN08zNTJ4aW5kYnNLSnB5UXJ0bWlkUS9v?=
 =?utf-8?B?cm5HazZCYWpVNWNIYXR4eEZTR2ttYW93ejdBTzFsWHNSb2FkbGxsczhUK2Rm?=
 =?utf-8?B?WVBRSGlMVnhnQ0xRT1dOSEVGMTJEM1ZnOEE4ZWlMTEJYVWJjZmJBWUU5Mng3?=
 =?utf-8?B?Y2ZzZTdhWGV1dnZWZ0kzbXQybTFFSythWkxrUDhHVnNzTmlKcEx4TTkxejk0?=
 =?utf-8?B?cVdScnBDTjNsL3BuOHlpMWx6QmttSnVEZ0F4SGNqNXVFNlR2VlhJM09Fekd6?=
 =?utf-8?B?bHN5UnZTN1drUmV1YUtuaFN1K3hmMTNJTWkzbEFCdGZmTlNuMHJGVlYwUmdH?=
 =?utf-8?B?c2JubWZQa0NZS0I3L3F1TU8va0RmNk01N3YzTHZEbHB0Y01VYUxsVCtRYk1s?=
 =?utf-8?B?STgvdVBGR0NEeGtQOWJsQUJScDFFWkVwenlSUUdKUm82L210b3pvazRKOGYx?=
 =?utf-8?B?MVFPUjN4VW5RM05pbzdoQitpS0ZlQ1c3YTBzUytzMlpaVTNraDNKYzFkSzhv?=
 =?utf-8?B?SlZDQURpd0pqM3hzbWljVWYzRHlmQ0FCVkVwU1lqNW5ZT09kNlFGVlFTMnZ5?=
 =?utf-8?B?ZG5BMWovUklIdGpDTkJvT2JxR3M0dTBKK1I0K1Z2d3Q1YXdubFVLYVd5Z3Bs?=
 =?utf-8?B?VllqZFFYWEFUNmZuOTVrNG9CRUFaY1Nud1VWSG5Ua1dNdGl2QTgyeTVRSXZx?=
 =?utf-8?B?RE5IR3RQVUZPdzVZK2QxWE1QeXVpMEZ2cmpwTGdza25SRVZnYld3SDNhcVo3?=
 =?utf-8?B?K2RZVGo3NjJHd1FZbzk4RERvalBhcnVVbFcyOEd3ZVlmejdZUTFVNmlQampC?=
 =?utf-8?B?dGpjOFJnZlZhcGRzN3M2MzVhZ2tRWWozSy9pQnJ4ZmZzQ3IzNDZyS01rbGZZ?=
 =?utf-8?B?VGVTbXF3LzVUWGdyTkdDVWlUZm1XM0E0UDdvbzFQNXJLV2lvbnlKNlQ4L2dZ?=
 =?utf-8?B?N3ZuS1R4OFlmVW11Y2JBNzdEazhuZzFOcWRhNUZILzBkZkk1bFV3dUdxQ1RY?=
 =?utf-8?B?QXRYM3B0Q0t4SjJxQTBIVnFNekw3WTFkbGNPU3ZaQTQyZjFqamZXYURtQ2hB?=
 =?utf-8?B?MHZZV2RGbFNIci9FSUo4bUN6cDBITFIzQ1FIY3ZHaGNSVG9GeEhuSkdORFJH?=
 =?utf-8?B?YlB1TzY0cXdEMHJiYjVjVkFxT0l0eEVhUnlLSGZEMkM1K1MwY0dOc0F5NUNl?=
 =?utf-8?B?eTNFb2RNdVVjTHcxNkVlQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajMxYjVjSGxsaklHWGlOWndmL25qZ3BEeWZXbW53cUpramNyUDNWZm1VNXoy?=
 =?utf-8?B?SjZCNzUremVzTUhxR3NyRCtZQ0hINmQ1QjZ6a0N1c2pWblA5emlTNUJDbGFX?=
 =?utf-8?B?SFQwbW1LcHBFNElxdHhPSW9sNDZIdUhxK0VvcURJYXkxZGRaU2Z2N3daRllO?=
 =?utf-8?B?MDZMMmZncHJ2dXZsYlBFOVFKaGFhWVdFSVR3REh3ZVJ4TzJBbExqamRiY3U3?=
 =?utf-8?B?OWJDVHJqM201SGhiR3RQdCtma2VsTFZNZEMxWkkxdlZrREkrb01tVTJNUC8v?=
 =?utf-8?B?U1ZLaythbFhKbGNMTkY1T2NNb3A1dERXVmxUUDhrY2RKTktLbFFFVFpXdGVM?=
 =?utf-8?B?SG9RYVU3bW5NYi9uZktiOGpUTUF2cmhLUW8rV1B4OWtGTitzUUpuWW1LYUJC?=
 =?utf-8?B?MUREZnJOeHcyQ1BsRytlSnRQUHo1K0NjVVRIUVdwaUt5YkxmaEM3alpRWU1k?=
 =?utf-8?B?alBNVElZYjdYY2N2KzhFQUgwckM0TzN4OFl2VkY5aVJIN3RkdS9vQjRwcUpI?=
 =?utf-8?B?a2VXbi9PTGJhTXB0L0VCZElyYjlUOGxpcGh3VCtWL1lmQjJNSG1LeWRTYWdv?=
 =?utf-8?B?K3B3Y3pSbHpBTFhEalVrWmJFMG5DSExOR1JScDZ6Qk82aGRyMEpZYXNjeEhj?=
 =?utf-8?B?QTBac1ZFNzdLZ29aYWxPN21TQmpaczZQNWY2SlIwN3ZiRDJOL1NTTG93TVJZ?=
 =?utf-8?B?c3VlWjJPUUZvMmVsTTJna2hpZHZYUlRCRm1JUTdLQ3NQM25pMFRLcnRacjdL?=
 =?utf-8?B?azZNSHhQUHhtazRFN090dGlnRTlMMHhqRVFXZHVZT2tLYXZ2WHd3UEtvV0pj?=
 =?utf-8?B?Ni9lbGV1VGZhWUdtRDhNeW9JS0dLMGxDT1ZuWE50L201SVRFdHlyemg3VllK?=
 =?utf-8?B?RFZXd0VpTzl4dUxadk1JRnNiczNmNy9HTzkzTjZ1ai9hNjRtNmxjRFpYWFE5?=
 =?utf-8?B?aFJVWEZGbng0K0dXanM3SzZNMisvbUNMWVUvSnExSDcyYnhhUEJKOUdMVTFH?=
 =?utf-8?B?ZDF6MXdSaE1Ib3VpSDRuRXU5TGFQbVAyVGRRYm1EbHJHV3R3bmZoL3VPQ25S?=
 =?utf-8?B?Q043bitwQVNHcDIwOHVFYVBWWXNITWZZYVc2Q1Z1ODFybjg0UThvcmdieity?=
 =?utf-8?B?aVlOZDd0M1JtL2Q2eGJ1cjA2WXRNU0k0aktraFJnVWZFV0FBejlvS0pnUzJw?=
 =?utf-8?B?OGwycTh1TlRvdzBYYi9vMDVreGMzdVByNDdOOTFmTS82Mk5DS0c3YlNYYTk3?=
 =?utf-8?B?TzNSSldxT0xMS3ozeDNkd3ViZkdNdU01NHBwNFV4bEwwVnpXVURqNFlEbG8x?=
 =?utf-8?B?Mkt4R3NYTFFZVzBzTEIxa3c5ZmJnRkZMQTNFakZDYmQ1Rk1rVndUb2RHM1BZ?=
 =?utf-8?B?dUp5a3dBNEhLRjRHaVh6U3JmZWtEcTJYci8wSjVkWVhGcVJoVVVtYWFDY3JL?=
 =?utf-8?B?d2JFRjlHckZDSXNKS0pOdGtIVHhrdWhpMDhTa1AzZ0RMdVRvQStGSjdqMEYz?=
 =?utf-8?B?bDZUQXFFbUVqM2NibkZKRzhyVjkzMVlrT3dYZ3FUL2xDTkZ3ZWtMWHNTVG02?=
 =?utf-8?B?VmgxMTJqTCtENk5nMGEvdEZ1dXJEMXBoVUFGMVdnblczSWZyaFM4bjRaQ0hh?=
 =?utf-8?B?TkYzTzZqTUplcjAzbnZrQ2o5TzFBS1YranZ2dlRWc1dVU1NTM1h6SzRkVTly?=
 =?utf-8?B?a1hOYmEzVHdCTnphQkRXd1Y5bGpQWnMyTW5BMUY5TExiQ0xZWm9jTS9lWER0?=
 =?utf-8?B?L0M5VkEwc3JYeXFjbHlTRWRpQWVxdGE0V0dlcHBsVXV5RUpGMWgzMVd0Y29y?=
 =?utf-8?B?T2R2djhiQnVpZTZvZy83ZkJUNGtjUVRoT1lUeklRNUpuQXNsMm5TbFVEbEdC?=
 =?utf-8?B?U3Y5dUdKNUI1ajNrYTExbDlUK21VK0NHeFRRN3ZycStMQjhmTUduSDZ3NzF6?=
 =?utf-8?B?Slg3enpRMVN6R1NMR3FQWFU1aXpkZCtGdk9Gc2EyNG9RSU5oL0lhd2JueVVj?=
 =?utf-8?B?TG90RjFuYWN6V2Y5VUpta1I4dEI3OUxHSndzenhvV3p3VUsrOUhpK3Q5RVVa?=
 =?utf-8?B?UVJUWGlRVmRnbU1kWnQwOUt4dXdvZXJUTktYMkNoNWRCeEkwMFlYaGFFR0cw?=
 =?utf-8?Q?Yc1RcpQkqI7rMPRaSJesU/jmR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Les5dt45HfA3G0MKFEhp27HOVQ8Kcios8SBFWiDhF3FY+DIRATzukF1cBIK2bHNeLKI2pC1WxbOr5vEapBPAgdXPgpOZ79CUDa6ZcsVRyEseU5/VtEjPVz2nsDQK5P6fvKoYxigq0mjuQVHQfmaYyQsQgYD+L6OR9jGoiisgAXw6Tj6EMyjw+RKWnVU8EPYNry2mrCCxjTm6ukdF4Jbrua96ZlyRLyl+1mdY1K1CHLrzwEQXtAsgD2mRFjgD6yr1Upw6DfDyHHxhdgOV7oC9DTF/NWXkPj5fj3RAQ4Yxp/CW6jeCLYFByNPC4VGbNL1Op9EEq3rqVgfEBpoyPC+SfrlEybGyTrYRjTWreUVTpQZlNaVgX0xp7+Wu97u+8cRhZrXkvg0sneDMzyqjYjhuaxAdEDi8ZFrGShJNbeKbeFZR/A4Dz38aOQGPuKCFqZm+Mct1XjvEdSmorWFwf+ytUdMMG3sBokml+cXLS8+F2r8Em1cv+sLD+2S9x2ipZT+PrOF8svuFmbsKMV2h9L2jL2HUsC0RdolTKvNJlbVSuam9s2HDYIw/me+1eLqtv/poUE87m/ucITk7iRDfTNrdGnCTYaqhsxpxWVnuOeCZ18U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f78cb86c-0695-41d1-fd32-08dcc725e57f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 05:54:35.9641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25Ehx0Psn3pwvmhH+REe1w2Lq1PjjV04FFgJR8LBr5TmObbDGm2nZ0wM1M13iN0+5JBylFqiAmbhFtsWOxuRhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4969
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_03,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408280040
X-Proofpoint-ORIG-GUID: tFc4s7e9WWeejfAIizK7j9ddZysRuWnG
X-Proofpoint-GUID: tFc4s7e9WWeejfAIizK7j9ddZysRuWnG



On 8/27/2024 9:02 AM, Dragos Tatulea wrote:
> When the vdpa device is configured without a specific MAC
> address, the vport MAC address is used. However, this
> address can be 0 which prevents the driver from properly
> configuring the MPFS and breaks steering.
>
> The solution is to simply generate a random MAC address
> when no MAC is set on the nic vport.
>
> Now it's possible to create a vdpa device without a
> MAC address and run qemu with this device without needing
> to configure an explicit MAC address.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index fa78e8288ebb..1c26139d02fe 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3824,6 +3824,9 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   		err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
>   		if (err)
>   			goto err_alloc;
> +
> +		if (is_zero_ether_addr(config->mac))
> +			eth_random_addr(config->mac);
I wonder with this change we no longer honor the historical behaviour to 
retain the zero mac address and clear the _F_MAC bit, should we head to 
remove the below logic? It looks to me below would become dead code 
effectively.

         } else if ((add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) 
== 0) {
                 /*
                  * We used to clear _F_MAC feature bit if seeing
                  * zero mac address when device features are not
                  * specifically provisioned. Keep the behaviour
                  * so old scripts do not break.
                  */
                 device_features &= ~BIT_ULL(VIRTIO_NET_F_MAC);

If we are not going to honor old behaviour any more, looks to me we 
should also block users from creating vdpa device with zero mac address, 
if the mac attribute is specified. There's more sorrow than help the 
zero mac address could buy for users.

         if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
                 memcpy(ndev->config.mac, add_config->net.mac, ETH_ALEN);

Regards,
-Siwei

>   	}
>   
>   	if (!is_zero_ether_addr(config->mac)) {

