Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC62C139D05
	for <virtualization@lists.linux.dev>; Wed, 18 Sep 2024 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726676820; cv=fail; b=aWoH+NhpasAkZnRS9Xs39u/l6f9ml4zMrKdPIZC2p7blGc8++U37BdZMAq+r2uwt5MLD3XcnZ2NmiK+2JFhUwJwUvl3YAD6i2lqAzSJI97nGbiDMO5lo5wooRJsoTYUMvKkVwMbYj8fmn14pw8ae0emt9k1NbrOzFNk+/p1IGVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726676820; c=relaxed/simple;
	bh=9zhSWO6m4zgBnhyQXxV78WEv6JLyqJSon0PLuWn6Zt4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WYcHqtdkSh4xxG28g6SFjf8weiTLLJCux0bNOB/URNGGBHJoYuMredD6KpwLGP5beS0i/9WmNKeIPzycsul6kDCgnz9rYD1mFenbgou/cGF0Lak0k4J5gCmm6E9nAPO5tMG4ckXsbr/ZX9m9ZfRyZJpkM3wsUElGKzGHOsfmlz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=kkyOgxxp; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="kkyOgxxp"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48IBi3hD019044;
	Wed, 18 Sep 2024 09:25:31 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41qdwgd6y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 09:25:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZS7VUli2zHwctF2qZl5t/1TVTRapcsl75auhF3AVP08zq8fPWsxL7qQSxA1qEAcuWjI7kRlt6M/QaFknE1htNjQUdsw+lpQc0Y+F26HsDYAthUNGIHkPdbyBryZeCvwamLLJw9wfNRL+eAxBwkzYGKmitT5SPvUIDzFeA1M0Q9XZkYrV6ZmpxzlahjoLCyUTBAa1oEOvhKeeqsdoo6JVyAIp5tGSDIfdCi1sQNrvDWkuNPkceRe7IFSolSzB1/CRIKDTjDcyUkWIV42NZsoVq3neV2E39BeIPPgr9oCMfgUwfyLkD0oBBeBcc+hlxIIFXhuhQKcX8dY6OwLqXSqhdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zhSWO6m4zgBnhyQXxV78WEv6JLyqJSon0PLuWn6Zt4=;
 b=USj4lKq2v1mAOodZOCkL0VbPwQEC26BE2NX5hGOGLVZeiv1Ray0sSTkC374mamHIV4mcNfPo6BCjV7mpvDLEcHhUhgKZROUBm111uvyW9s/Z9bK6JR/kbkVx71FVqBpwloqq7/uxQqUuJ1S1H/ZXjctclcA6gzZpZrDnuIeEPCtZNt6VltDH41lfvQTkuRpZCfDIvqoE3LCprlXWpcU/oifR6CpVbnmvH+FOCT3rmQTopLT5/gJor0EFLS+Wkfv6SlQC32qCJJd/P5XK/8QWWPkyzAIQK41n001KoaP0Pd+uvI+xtWZqd6ihOidZnYvlz6VKDbhfpVpJ7Mu5aHMgHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zhSWO6m4zgBnhyQXxV78WEv6JLyqJSon0PLuWn6Zt4=;
 b=kkyOgxxpGNKddF8hyFzmaGrutf0NJeCB35wlJrj+wdoMekRDdxLPhCZanu5X5n8tAW6mUDKXp8jQfWqyA+Cp3ySLk2spq/BTfYgxDMhKWpWDxLhFiVezR7SimtzTYW/AY39r86v6RFiuTlu4+hhfNlGvn5rBjBl1ErZvasSH8hI=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by BL1PR18MB4184.namprd18.prod.outlook.com (2603:10b6:208:316::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.26; Wed, 18 Sep
 2024 16:25:26 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::ad53:bef2:cc17:13ac]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::ad53:bef2:cc17:13ac%4]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 16:25:25 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>,
        "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
        Vamsi Krishna Attunuru
	<vattunuru@marvell.com>,
        kernel test robot <lkp@intel.com>
Subject: RE: [EXTERNAL] Re: [PATCH] vdpa/octeon_ep: Fix format specifier for
 pointers in debug messages
Thread-Topic: [EXTERNAL] Re: [PATCH] vdpa/octeon_ep: Fix format specifier for
 pointers in debug messages
Thread-Index: AQHbCFS0KAG75dfAdEi6PPVo2f4H3bJarx2AgADLwkCAAibNgIAAGeuw
Date: Wed, 18 Sep 2024 16:25:25 +0000
Message-ID:
 <DS0PR18MB536821847C90C9EABC82B2F1A0622@DS0PR18MB5368.namprd18.prod.outlook.com>
References: <20240916162255.677774-1-schalla@marvell.com>
 <20240916134226-mutt-send-email-mst@kernel.org>
 <DS0PR18MB5368A29EFA2094A2253CD6B2A0612@DS0PR18MB5368.namprd18.prod.outlook.com>
 <20240918104325-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240918104325-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|BL1PR18MB4184:EE_
x-ms-office365-filtering-correlation-id: e9211304-7dde-4e9b-42aa-08dcd7fe8038
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aDB5Um1MNG56blY2M2tWcFNVeFRvVDdDN012R2dSZjNtbkIraDFHLzk3Q09s?=
 =?utf-8?B?MzJmMVNOWDhsUWNJWFhLRVBPUEVOVi96SzMweXZIK1huWldBTmVRVzlPK3l0?=
 =?utf-8?B?VWhpQkFUczA0bFRoZXN1aGpUMWdndVdqVDJ1L28yc2NRT2VoL1ZYaHoyYlJG?=
 =?utf-8?B?SUZWT0J3Wldjd0JsWHBZOFdNQVlCSjlFR1BhYzRtQ0lJcTFzSE1Ea0ZtUjlK?=
 =?utf-8?B?dUkyandrSm5TUHdKSDJONVNZS0t2cy9JdjY3bjVMbDJBTFhheldkR0xGZGN1?=
 =?utf-8?B?MFU1dW1vVXdyRktpMmdNREc3bG1NODFCbzRncnJjYjZsK0ZLN3Q0Tm8zTHh5?=
 =?utf-8?B?bE9taHh2VmNkeTBBN2c4Ylp5d29ZS2VCNjE2QmN0RE1vOTBvUDlvSUV5MUVs?=
 =?utf-8?B?K0pqMHJRVmpybG5EUDhPaXk0clpEaWxTV1BTV0w2djRxNTNiK0E0ZWprU2E2?=
 =?utf-8?B?R1pDUkFJcmloY05xclNubGk2VWsxbnRSZnAzOUV4MDhpZmdIbVBYK0U2NlI4?=
 =?utf-8?B?N3pmaHFzbkwrT2sxWnJ3cE1Lc2FlT0I0czJ5RTNFZjdIRnZta1ZKMDlQWUJ0?=
 =?utf-8?B?bzhJQkI3WVJwRmtSemR0dkw0L2xVczdHQ2QvaFpvazlvUlNackRVb0RqcU82?=
 =?utf-8?B?TzFqeG9KZGdYWEd2QjRySjgrZStZTjJqdks0MzJNWGNaemtwZjBWUC9MSDV1?=
 =?utf-8?B?aVgzVWdzRGlTMlZEM2hCc3Y4NmZJU1NER0hRK1QyTjg5dG5FTGNDQVRkcDlO?=
 =?utf-8?B?enZYUEZxNVMxYkZJWEpvRmdXWXZuV0xLT3Q3RFgyVHcwTTJ2Q0I4Ykt4bWF4?=
 =?utf-8?B?bzYxTjB5M2dpVk9OL1RqRkxSYWE2dXRNTHJvVWVLUXJTMUZ4TGxxMGFDY1lm?=
 =?utf-8?B?VDNyV3g3cW9rY2dwaFlCOGQ3VjNnZGVZSkZUOVdBZHBnTFF5Z1ZaVktZRHhp?=
 =?utf-8?B?TUJZYTQ4VFZHSXRaaWVzd1ExMTFLS3pCaTRJZzROdFBNdUlrRkx1NGRzNzBR?=
 =?utf-8?B?MnNkNktXSWpHa28vd2ZGLzVQZUlKYWpWM3lmYnFhWERLWWxkZlBtWERvY2pi?=
 =?utf-8?B?U0hmcjZTejZMSzNVZERKS21KVi8zWi8yTmQxdEppQzVPcmxFYXZYN09LSUNP?=
 =?utf-8?B?L3FjSmVZL2krWTBqMjlCUXd1dWhaY2dwK2JHOFJYT0w2NWtvL0FKamZ1UThE?=
 =?utf-8?B?MTlEUVFZT0Q3L3hYYmxUMi9aZXJPRGY4bktkNmFWTTZaZEJhUEhEMFdrUzd0?=
 =?utf-8?B?aE4wckJ3MDU5WU85RWIydEU0Smx6d1RqcEVQUmhHb3h0cUxZSXpnamVmRXZQ?=
 =?utf-8?B?d2FOejMvc1hVWjhTSkU4ZzJweEZQbm1BZ05DNXZNOUw0ekRDUlBrLzJ5dllY?=
 =?utf-8?B?L1o4dlcrY0hEemhWcHlzUVdxOG1NMlN0U3g4M1dyT1U0aWh1d1lLTWNlYXRS?=
 =?utf-8?B?QTBNOGx0bEgzN2MyMGc2ZDNhdFZ6TjVqdWxHVW9DaDZBYkt3ZVVzdnRCNFgv?=
 =?utf-8?B?TzZmeW56ZkxPVThZZTJVRGxEak41UlE3T1JzYmsvVjE1TXg3NXFSVjFOU0Ny?=
 =?utf-8?B?dVpiSjZtSE15azFJRWlPRHdzYm53dTNwT2J1dFZUWXRaWEROMy9JQ2plbzdH?=
 =?utf-8?B?ak5TdTNGdFNQWjQxWmh1NU43L0NzYjNBc01ZZnJ3eHFMeWlRWHhjZ2V3NDZ4?=
 =?utf-8?B?MUg4UWlyVElQSkEwenRQNGRjMVp1Y3NsQURrWEltSm96b093MWFvbG10SGdn?=
 =?utf-8?B?YWRJVGppZzJKUE1zQm4ybThVUVlsUG5SMWZVbjQ5ZzZRL09BMlVEakRvSWND?=
 =?utf-8?B?d3QxWVAyclo4MWpWMFRwQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR18MB5368.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anRvbXc5YjQwMUhML2hLMUMvN2VYbmludCtwWFVNeGRrTEZXRER1UWFjODZ0?=
 =?utf-8?B?V085bXVYZTNhWWRzV3J2dFRDOGNiam1nY3F4U2VYcjY5UFlneUNjck83MzlJ?=
 =?utf-8?B?QXFZUmJCT2FmVGxwRUdicUlXbmh2VmNmeVZaTXNIWXdsb2tCM1RiN0Qydk9M?=
 =?utf-8?B?dlYrNTBtUHFabDJhWWwxcjJIckx2bkNocm5vYy9CRlNjUkx5aytRNEM3OC8v?=
 =?utf-8?B?YXFnL0ZoUzlQeDFmczlibWR6aXg3SHQvVFJNWWRMcVJTNlpSazFqeE90RUI5?=
 =?utf-8?B?MWRTQkdldUFJek9QcG0yaGVnOGJ6bGVNbEZtVmIvQkg1Sk4wcEJPaFpjbnJY?=
 =?utf-8?B?R2hNUDJURDFGZ3RLcjhTTjdBRmlpdDZONDVUYnpNaEhRMTN2WUo2Y3VldFd0?=
 =?utf-8?B?NXZibC9CbG5nZ0M0TEZXSk5oOWhqb2N5andDZHVmMlhkcTRHaTZLWWxSQURn?=
 =?utf-8?B?Yk5wWEU5SE52Zm80S1l1MHJrNFJPTkdpOUt1anZSUS9naWlES3VEMzIwbVNK?=
 =?utf-8?B?NjlYbExEYk9uMWFQZWhTZFBxMWdvYnROV2dFZ3g4UGZRTzk5ZlR5ZjE1cW9Y?=
 =?utf-8?B?MGVZUDV4YUkwVFhMODMrWmg3NW1rZTFmMTBpUGV3SVJkdFg1ZlNHZSt3cExF?=
 =?utf-8?B?Um9yU3hjd1hLTHRxU1BVeHdoVGFsaDg5R1ZJU0U1c2hQQzRVZDJhdm56VHhW?=
 =?utf-8?B?SlFqTnMvR0w5dDMvNGRHV0dDcWl4SlMzWVVNUG8xMEhwM29jT3RZUjU3Z0Vp?=
 =?utf-8?B?M2JTRi9KNCtnU2tvME5NQXArSzNEY2VuUlhJbFlTYWZ6NHY4bWlCMWF1WGkx?=
 =?utf-8?B?T2N2OUZ2enIrck45WVQrZnRpR3EvOVBrL05WYjhzSHExSCtxR3FxZGRzenNQ?=
 =?utf-8?B?Y295V2pXeVUyUDVHcVJsdHhHdGsxZ1pscnVUbEZnVHozZ1ZnY3h5c0VmR3Q4?=
 =?utf-8?B?OU5oMC9oUUsrRGFOdmVmcTJvajdnVE1DSzlTMnRnYVFFM3I1cnZmUTE0SHVU?=
 =?utf-8?B?SXVKSGRnQzlyZ2pCSW54bG40UW1obXlDZ3VjOVM4cUZ6NXV4YVQxcmhLYUxu?=
 =?utf-8?B?a0RydW1jbHJKUEdaeUw2ZTlueUxjQy8wUEUxOTBocmVYdzZiQm4ySlcxbmtm?=
 =?utf-8?B?VUxHTHJXSmo1d0duVVMxejMxS2NhQ0ljTGZSRHRmSjIyQXlDMnlPUDdTd2h2?=
 =?utf-8?B?enRhaFhCN3R0aWxlNlQ4VytyS2pOTjNNRlBwWlZnR1ZDeTQxcjdNaGw4K0ta?=
 =?utf-8?B?MlVwYXh0NVZFYVhWUHJVbGNLRjRHekZ4VDRUdStGZUFuRkRUSCttYitCTzh1?=
 =?utf-8?B?cUpIN0Q3RVVDNE5lQlNtMUgvSUlSZUV0YXBXWUhHbi9uVXUzREg1bHhWaHRU?=
 =?utf-8?B?UXVqOHQ0Y2ZVRGhDYjIzaDlQM2ZVSlVFb1kvL0dONG05ZUZ5dzN4T1l0UHJl?=
 =?utf-8?B?V082Q2hoaXU5dExUd3l0QWdFS1RWeHRybW00aXk0NEU3TlpJVDlJd1ZMeG5r?=
 =?utf-8?B?U2N5UHNycFZJa0xwOEc0YUF1NEl2V1VkR2ZJc1VSZ1l0c1JsUzNCVHNLazNo?=
 =?utf-8?B?eENxUGlMTVZuVElGL2VKUytKTWZRUW40NW8wdG1hbjJRVUNMR2tzaEtBREMz?=
 =?utf-8?B?Y1J0UkZsMVNGZUo5bDJZcUs2emFzU2xVK3NCQ0tMcnphcFJyUUtDT3BVelVR?=
 =?utf-8?B?VnJUcmpPQ2dXN2lYT0FuUTRIMzFsRDlLajBLOTJFLzBXcGwvbDhqcnUrbjlp?=
 =?utf-8?B?YWx2djBDNmQrSDFWUHJJL0M5MVFlb1gzSjE0YjNRL3R1a2l2ZDBFNUxTYW9D?=
 =?utf-8?B?MnhJRnJBRjJlcWhUNlNXaE5LRkhjN2NoeHpTUkNVRjQ2cThKSkJXTXppQ1o4?=
 =?utf-8?B?c3lOT0NRdFdqdDNST3UyanBveXZ6ZFVXS00ySGE5WkJSUlJ1d2k4a0FkdHpr?=
 =?utf-8?B?dkYySnNXNEhQZmZIYlFhM3FRNHJUeThOQWlud1Q4RFhxb1BmQWYxZHpuRUFm?=
 =?utf-8?B?Y0ZOWDJ5MDhnY2tYMUJweDZaWFl2WUZ0RGZ0RTdUYUpqa3R0bnc0cGVVN0VD?=
 =?utf-8?B?cnFKVHhIQklEdWdCUmRXNmozWk9TL3BPeGVLbWFkTm51QTVxdFRaZlN4K1k1?=
 =?utf-8?B?SkxVZVpIbVd5eEJ2OUg0YnBDWlB5R3FSUGNxazNSdHRpdlh6ZFBJdXMzVjY3?=
 =?utf-8?Q?bzIz9ICF1ntwD9ZwNvK77/+upfyiS0MksGBcE/eDm6LE?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5368.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9211304-7dde-4e9b-42aa-08dcd7fe8038
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 16:25:25.2131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wjnSOVhbO0P5lyaM4VJk92j2RpwBfL1czUArugrOdrllESWj+U35mPKB060X9HCLUPcqcN5BUdltZoIn4AAANA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4184
X-Proofpoint-GUID: uclLzr9WQeQRhTNzJkNfQrEnsld0x9mw
X-Proofpoint-ORIG-GUID: uclLzr9WQeQRhTNzJkNfQrEnsld0x9mw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

PiBPbiBUdWUsIFNlcCAxNywgMjAyNCBhdCAwNTo1OToyMEFNICswMDAwLCBTcnVqYW5hIENoYWxs
YSB3cm90ZToNCj4gPiA+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSF0gdmRwYS9vY3Rl
b25fZXA6IEZpeCBmb3JtYXQgc3BlY2lmaWVyDQo+ID4gPiBmb3IgcG9pbnRlcnMgaW4gZGVidWcg
bWVzc2FnZXMNCj4gPiA+DQo+ID4gPiBPbiBNb24sIFNlcCAxNiwgMjAyNCBhdCAwOTrigIo1Mjri
gIo1NVBNICswNTMwLCBTcnVqYW5hIENoYWxsYSB3cm90ZTogPg0KPiA+ID4gVXBkYXRlcyB0aGUg
ZGVidWcgbWVzc2FnZXMgaW4gb2N0ZXBfdmRwYV9ody7igIpjIHRvIHVzZSB0aGUgJXAgZm9ybWF0
DQo+ID4gPiA+IHNwZWNpZmllciBmb3IgcG9pbnRlcnMgaW5zdGVhZCBvZiBjYXN0aW5nIHRoZW0g
dG8gdTY0LiA+ID4gRml4ZXMgc21hdGNoDQo+IHdhcm5pbmc6DQo+ID4gPiA+IG9jdGVwX2h3X2Nh
cHNfcmVhZCgpDQo+ID4gPiBPbiBNb24sIFNlcCAxNiwgMjAyNCBhdCAwOTo1Mjo1NVBNICswNTMw
LCBTcnVqYW5hIENoYWxsYSB3cm90ZToNCj4gPiA+ID4gVXBkYXRlcyB0aGUgZGVidWcgbWVzc2Fn
ZXMgaW4gb2N0ZXBfdmRwYV9ody5jIHRvIHVzZSB0aGUgJXAgZm9ybWF0DQo+ID4gPiA+IHNwZWNp
ZmllciBmb3IgcG9pbnRlcnMgaW5zdGVhZCBvZiBjYXN0aW5nIHRoZW0gdG8gdTY0Lg0KPiA+ID4g
Pg0KPiA+ID4gPiBGaXhlcyBzbWF0Y2ggd2FybmluZzoNCj4gPiA+ID4gb2N0ZXBfaHdfY2Fwc19y
ZWFkKCkgd2FybjogYXJndW1lbnQgMyB0byAlMDE2bGx4IHNwZWNpZmllciBpcyBjYXN0DQo+ID4g
PiA+IGZyb20gcG9pbnRlcg0KPiA+ID4gPg0KPiA+ID4gPiBGaXhlczogOGI2YzcyNGNkYWI4ICgi
dmlydGlvOiB2ZHBhOiB2RFBBIGRyaXZlciBmb3IgTWFydmVsbCBPQ1RFT04NCj4gPiA+ID4gRFBV
DQo+ID4gPiA+IGRldmljZXMiKQ0KPiA+ID4gPg0KPiA+ID4gPiBSZXBvcnRlZC1ieToga2VybmVs
IHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+ID4gPiA+IFJlcG9ydGVkLWJ5OiBEYW4gQ2Fy
cGVudGVyIDxkYW4uY2FycGVudGVyQGxpbmFyby5vcmc+DQo+ID4gPiA+IENsb3NlczpodHRwczov
L3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2xvcmUuaw0KPiA+
ID4gPiBlcm5lDQo+ID4gPGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/
dT1odHRwcy0zQV9fbG9yZS5rZXJuZSAgPj4gPg0KPiA+ID4gbC5vcmdfcl8yMDI0MDkxNjA0MzEu
YlJoWldoaVUtMkRsa3AtDQo+ID4gPiA0MGludGVsLmNvbV8mZD1Ed0lCQWcmYz1uS2pXZWMyYjZS
DQo+ID4gPiA+DQo+ID4gPg0KPiAwbU95UGF6N3h0ZlEmcj1GajRPb0Q1aGNLRnBBTmhUV2R3UXpq
VDFKcGY3dmVDNTI2M1Q0N0pWcG5jJm0NCj4gPiA+ID1xeWhsV2gybEYNCj4gPiA+ID4gRTNTUEZw
Ql9lSjBLMVJGTWE1Zi0NCj4gPiA+IGtjTkNoRkhrQ0FSRENYSWt6TWtfXzNzcXNwUF9LN0tHeGFq
JnM9Zk12UzYyWE1taTVIDQo+ID4gPiA+IEVTSnVMOXY3RlgzYzhSU3pLQ3E3Sk02S2hjb2Y0dk0m
ZT0NCj4gPiA+ID4gPGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1o
dHRwcy0zQV9fbG9yZS5rZXJuZWwuDQo+ID4gPiA+IG9yZ18NCj4gPiA8aHR0cHM6Ly91cmxkZWZl
bnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19sb3JlLmtlcm5lbC5vcmdfDQo+
ID4gPj4gPiA+IHJfMjAyNDA5MTYwNDMxLmJSaFpXaGlVLTJEbGtwLQ0KPiA+ID4gNDBpbnRlbC5j
b21fJmQ9RHdJQkFnJmM9bktqV2VjMmI2UjBtT3lQYQ0KPiA+ID4gPg0KPiA+ID4NCj4gejd4dGZR
JnI9Rmo0T29ENWhjS0ZwQU5oVFdkd1F6alQxSnBmN3ZlQzUyNjNUNDdKVnBuYyZtPXF5aGxXaA0K
PiA+ID4gMmxGRTNTUEZwDQo+ID4gPiA+IEJfZUowSzFSRk1hNWYtDQo+ID4gPiBrY05DaEZIa0NB
UkRDWElrek1rX18zc3FzcFBfSzdLR3hhaiZzPWZNdlM2MlhNbWk1SEVTSnVMOQ0KPiA+ID4gPiB2
N0ZYM2M4UlN6S0NxN0pNNktoY29mNHZNJmU9ICA+PiBTaWduZWQtb2ZmLWJ5OiBTcnVqYW5hIENo
YWxsYQ0KPiA+ID4gPiA8c2NoYWxsYUBtYXJ2ZWxsLmNvbT4NCj4gPiA+DQo+ID4gPg0KPiA+ID4N
Cj4gPiA+IFRoaXMgZG9lcyBub3QgZml4IGl0IGNvbXBsZXRlbHkuDQo+ID4gPiByZXQgaXMgc3Rp
bGwgMCBoZXJlOg0KPiA+ID4NCj4gPiA+IDhiNmM3MjRjZGFiODVkIFNydWphbmEgQ2hhbGxhIDIw
MjQtMDYtMTQgIDE0MCAgCXZhbCA9DQo+ID4gPiBvY3RlcF9yZWFkX3NpZyhtYm94KTsNCj4gPiA+
IDhiNmM3MjRjZGFiODVkIFNydWphbmEgQ2hhbGxhIDIwMjQtMDYtMTQgIDE0MSAgCWlmICgodmFs
ICYgMHhGRkZGKSAhPQ0KPiA+ID4gTUJPWF9SU1BfU0lHKSB7DQo+ID4gPiA4YjZjNzI0Y2RhYjg1
ZCBTcnVqYW5hIENoYWxsYSAyMDI0LTA2LTE0ICAxNDINCj4gPiA+IAlkZXZfd2FybigmcGRldi0+
ZGV2LCAiSW52YWxpZCBTaWduYXR1cmUgZnJvbSBtYm94IDogJWQNCj4gcmVzcG9uc2VcbiIsDQo+
ID4gPiBpZCk7DQo+ID4gPiA4YjZjNzI0Y2RhYjg1ZCBTcnVqYW5hIENoYWxsYSAyMDI0LTA2LTE0
IEAxNDMgIAkJcmV0dXJuIHJldDsNCj4gPiA+IDhiNmM3MjRjZGFiODVkIFNydWphbmEgQ2hhbGxh
IDIwMjQtMDYtMTQgIDE0NCAgCX0NCj4gPiA+DQo+ID4gPg0KPiA+ID4gd2hpY2ggaXMgd3Jvbmcu
DQo+ID4gVGhlIGZpeCBmb3IgdGhlIGVycm9yIGNvZGUgaXMgYWxyZWFkeSBpbmNsdWRlZCBpbiB0
aGUgbGludXgtbmV4dCBhbmQgbWFpbmxpbmUNCj4gTGludXggcmVwb3NpdG9yaWVzLg0KPiANCj4g
SSBndWVzcyBpdCBtaXNzZWQgaXQgLi4uIHdoZXJlIGlzIGl0IGV4YWN0bHk/IHdoaWNoIHRyZWUv
aGFzaD8NClBsZWFzZSBmaW5kIHRoZSB0cmVlIGFuZCBoYXNoIGluZm8gYmVsb3csDQoNCmh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtbmV4
dC5naXQNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Rv
cnZhbGRzL2xpbnV4LmdpdA0KY29tbWl0IGUxNGY0ODBkZjdmYmNiMGM4NGNlOTE0MmM4NjE3MDE0
OTVkOWI2ZTINCkF1dGhvcjogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3Jn
Pg0KRGF0ZTogICBGcmkgSnVsIDEyIDA5OjA2OjEyIDIwMjQgLTA1MDANCg0KICAgIHZkcGEvb2N0
ZW9uX2VwOiBGaXggZXJyb3IgY29kZSBpbiBvY3RlcF9wcm9jZXNzX21ib3goKQ0KDQogICAgUmV0
dXJuIC1FSU5WQUwgZm9yIGludmFsaWQgc2lnbmF0dXJlcy4gIERvbid0IHJldHVybiBzdWNjZXNz
Lg0KDQogICAgRml4ZXM6IDhiNmM3MjRjZGFiOCAoInZpcnRpbzogdmRwYTogdkRQQSBkcml2ZXIg
Zm9yIE1hcnZlbGwgT0NURU9OIERQVSBkZXZpY2VzIikNCiAgICBTaWduZWQtb2ZmLWJ5OiBEYW4g
Q2FycGVudGVyIDxkYW4uY2FycGVudGVyQGxpbmFyby5vcmc+DQogICAgTWVzc2FnZS1JZDogPDYy
M2U4ODViLTFhMDUtNDc5ZS1hYjk3LTAxYmNmMTBiZjViOEBzdGFubGV5Lm1vdW50YWluPg0KICAg
IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IA0K
PiA+IFRoZXJlZm9yZSwgSSBkaWQgbm90IGluY2x1ZGUgdGhhdCBjaGFuZ2UgaW4gdGhpcyBwYXRj
aC4NCj4gPiBUaGFua3MuDQo+ID4gPg0KPiA+ID4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2
ZXJzL3ZkcGEvb2N0ZW9uX2VwL29jdGVwX3ZkcGFfaHcuYyB8IDEyICsrKysrKy0tLS0tLQ0KPiA+
ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4g
PiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9vY3Rlb25fZXAvb2N0ZXBf
dmRwYV9ody5jDQo+ID4gPiA+IGIvZHJpdmVycy92ZHBhL29jdGVvbl9lcC9vY3RlcF92ZHBhX2h3
LmMNCj4gPiA+ID4gaW5kZXggMTFiZDc2YWUxOGNmLi4xZDQ3NjdiMzMzMTUgMTAwNjQ0DQo+ID4g
PiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9vY3Rlb25fZXAvb2N0ZXBfdmRwYV9ody5jDQo+ID4gPiA+
ICsrKyBiL2RyaXZlcnMvdmRwYS9vY3Rlb25fZXAvb2N0ZXBfdmRwYV9ody5jDQo+ID4gPiA+IEBA
IC00NzUsMTEgKzQ3NSwxMSBAQCBpbnQgb2N0ZXBfaHdfY2Fwc19yZWFkKHN0cnVjdCBvY3RlcF9o
dw0KPiA+ID4gKm9jdF9odywgc3RydWN0IHBjaV9kZXYgKnBkZXYpDQo+ID4gPiA+ICAJCWRldl9l
cnIoZGV2LCAiSW5jb21wbGV0ZSBQQ0kgY2FwYWJpbGl0aWVzIik7DQo+ID4gPiA+ICAJCXJldHVy
biAtRUlPOw0KPiA+ID4gPiAgCX0NCj4gPiA+ID4gLQlkZXZfaW5mbyhkZXYsICJjb21tb24gY2Zn
IG1hcHBlZCBhdDogMHglMDE2bGx4XG4iLA0KPiA+ID4gKHU2NCkodWludHB0cl90KW9jdF9ody0+
Y29tbW9uX2NmZyk7DQo+ID4gPiA+IC0JZGV2X2luZm8oZGV2LCAiZGV2aWNlIGNmZyBtYXBwZWQg
YXQ6IDB4JTAxNmxseFxuIiwNCj4gPiA+ICh1NjQpKHVpbnRwdHJfdClvY3RfaHctPmRldl9jZmcp
Ow0KPiA+ID4gPiAtCWRldl9pbmZvKGRldiwgImlzciBjZmcgbWFwcGVkIGF0OiAweCUwMTZsbHhc
biIsDQo+ID4gPiAodTY0KSh1aW50cHRyX3Qpb2N0X2h3LT5pc3IpOw0KPiA+ID4gPiAtCWRldl9p
bmZvKGRldiwgIm5vdGlmeSBiYXNlOiAweCUwMTZsbHgsIG5vdGlmeSBvZmYgbXVsdGlwbGllcjog
JXVcbiIsDQo+ID4gPiA+IC0JCSAodTY0KSh1aW50cHRyX3Qpb2N0X2h3LT5ub3RpZnlfYmFzZSwg
b2N0X2h3LQ0KPiA+ID4gPm5vdGlmeV9vZmZfbXVsdGlwbGllcik7DQo+ID4gPiA+ICsJZGV2X2lu
Zm8oZGV2LCAiY29tbW9uIGNmZyBtYXBwZWQgYXQ6ICVwXG4iLCBvY3RfaHctDQo+ID4gPiA+Y29t
bW9uX2NmZyk7DQo+ID4gPiA+ICsJZGV2X2luZm8oZGV2LCAiZGV2aWNlIGNmZyBtYXBwZWQgYXQ6
ICVwXG4iLCBvY3RfaHctPmRldl9jZmcpOw0KPiA+ID4gPiArCWRldl9pbmZvKGRldiwgImlzciBj
ZmcgbWFwcGVkIGF0OiAlcFxuIiwgb2N0X2h3LT5pc3IpOw0KPiA+ID4gPiArCWRldl9pbmZvKGRl
diwgIm5vdGlmeSBiYXNlOiAlcCwgbm90aWZ5IG9mZiBtdWx0aXBsaWVyOiAldVxuIiwNCj4gPiA+
ID4gKwkJIG9jdF9ody0+bm90aWZ5X2Jhc2UsIG9jdF9ody0+bm90aWZ5X29mZl9tdWx0aXBsaWVy
KTsNCj4gPiA+ID4NCj4gPiA+ID4gIAlvY3RfaHctPmNvbmZpZ19zaXplID0gb2N0ZXBfZ2V0X2Nv
bmZpZ19zaXplKG9jdF9odyk7DQo+ID4gPiA+ICAJb2N0X2h3LT5mZWF0dXJlcyA9IG9jdGVwX2h3
X2dldF9kZXZfZmVhdHVyZXMob2N0X2h3KTsNCj4gPiA+ID4gQEAgLTUxMSw3ICs1MTEsNyBAQCBp
bnQgb2N0ZXBfaHdfY2Fwc19yZWFkKHN0cnVjdCBvY3RlcF9odw0KPiA+ID4gPiAqb2N0X2h3LA0K
PiA+ID4gc3RydWN0IHBjaV9kZXYgKnBkZXYpDQo+ID4gPiA+ICAJfQ0KPiA+ID4gPiAgCW1ib3gg
PSBvY3RlcF9nZXRfbWJveChvY3RfaHcpOw0KPiA+ID4gPiAgCW9jdGVwX21ib3hfaW5pdChtYm94
KTsNCj4gPiA+ID4gLQlkZXZfaW5mbyhkZXYsICJtYm94IG1hcHBlZCBhdDogMHglMDE2bGx4XG4i
LA0KPiA+ID4gKHU2NCkodWludHB0cl90KW1ib3gpOw0KPiA+ID4gPiArCWRldl9pbmZvKGRldiwg
Im1ib3ggbWFwcGVkIGF0OiAlcFxuIiwgbWJveCk7DQo+ID4gPiA+DQo+ID4gPiA+ICAJcmV0dXJu
IDA7DQo+ID4gPiA+ICB9DQo+ID4gPiA+IC0tDQo+ID4gPiA+IDIuMjUuMQ0KDQo=
