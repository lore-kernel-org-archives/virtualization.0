Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED2B274B37
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 22:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761258297; cv=fail; b=MwBKxHgxbf7rW2ui83mWXzrCsPYLiAD8Q8AH3xJPjnTFQ27ArVQostekai/m4/aG8CWPOLnuW4uhX/FZgjsN2H2DVJmdHjcrQeD/jcZwAwfaYVq6ZMXYFoZotMZdQDw8TwmHKpBaLQthuooOSm2ax9Cnr7N32j95ww9vs9svTtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761258297; c=relaxed/simple;
	bh=TAAUrZvdootR+9CRTouKPBhD3iFLytmORDy8j5nKn/g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D4sJH0CQ4BvZUNeGjSWk+vrvDYKFCsL+VOkZPyiM4KrUGbsTUhV/BbhtxKRsWAXi+vQFc7v3fn6NDxdzQu79lVsAK261MRhLxv2HKTE6IGz8/POtX+GYAAnzhGSGRFb3O64OvsuaY/wLj3UgdSg5PLL35BapJNP4usdQXg4yqC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jbGFrLsL; arc=fail smtp.client-ip=52.101.46.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jbGFrLsL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XtajmOLhGMgBnKlSNOySGZ+YbQLkmX5MV7l3zP6ATR86wK3RsrZ0y4RiZUzOdTgU5KLr5dPuqSsFG60WDmNqTOsQ2SmU7dqLOWIqAXTvQMgYtdOr8nngUByDIHGdgoyM3+PzFg9cq1gWPoEGMLto9olJxSsSh1UYHAyURV/y16zldxdwdXaV4e4IVfBeYmjGvwUyBZEfoglHLOvLzw/gMehVstpVnLvTCzgyC22ru/IK63A1jBcG0+JupMgSyInowTL4EBSLey9MVkcYmdmp+kGFdT842KqwJawi5fv2cvVTHlobJ5J2d721DmMLTD7fwCpNpYL3iSPoPGJgKBSGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGQafqB1amfSvtYAPmXkYozykbWoFxVdoF89oR/alP4=;
 b=DDZyBAElQPTvdVtq56mFBSvpPTxA/dC+y6D/Ag2TBBrT0IVTVYTK7heRvZ0Y2XaHwNRCwbf1unrDfvVordF4+6pqglaMJsPKsI5YqwzCyVNwda10tvinZ1glqhLzf0h7fqcEFoVC8F6h6/6mg8GWN6Lf2og7/aZJclAzmrtjconk1NBkCkhGPVJ+muSuCd7gD1Nk6isSxMNskad6FIdpImzxk+Gr+yHj/Iuq2/GnJ4XNgO8qF8jRjxrm7amhnc8YdNgGohUPhth5eES07pffw98fLLnodk6+3xMVr1z4wmHpOMKsIkfSo0Rhw40agjdJm0ESfefxAKHfzTS5cGn81Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGQafqB1amfSvtYAPmXkYozykbWoFxVdoF89oR/alP4=;
 b=jbGFrLsLb8OMjDLgJaBnZLCbvzRJg/Bk6CJpwVTJw7Q07mM1BKtK1goufjHrAORzxEQ2R5fPT4Z6m5eOvoAyE3x23BxJep7gz02RPJJAh7a+rjpozBFbu9ac2GM8eJkNaMQLd+nr9QepNFrIH5P2THZtA0Z1hdWVO/iVj0n/GAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 22:24:52 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 22:24:52 +0000
Message-ID: <53d8d0e0-d7d7-481d-8f86-2a71c6503362@amd.com>
Date: Thu, 23 Oct 2025 15:24:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa/pds: use %pe for ERR_PTR() in event handler
 registration
To: Alok Tiwari <alok.a.tiwari@oracle.com>, shannon.nelson@amd.com,
 brett.creeley@amd.com, eperezma@redhat.com, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev
Cc: alok.a.tiwarilinux@gmail.com, linux-kernel@vger.kernel.org
References: <20251018174705.1511982-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20251018174705.1511982-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:40::14) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|DS7PR12MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ccae65-29ec-48c4-c860-08de1282fc8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2RKT2J6TVRGL0pVbG9Wb1ExOUorbkdkanRGeUFBbnMweHoxQUxrWGdDWnIv?=
 =?utf-8?B?a0ZIbXFmOUx5SWVRSXg4OEpvOU9mNWlkb2NHMDZRM25wOUVZaytKdXR5Zmdv?=
 =?utf-8?B?dDdjRzcvTzRNQ1FCV1B5WEpBVVZuajZta2FRSmsvQ0hPNkJzWjlZL0pDZWZD?=
 =?utf-8?B?alg3bldwdVd5ZjZzWi9HR3VFd1FtM1lidkl0OUowM2NYMWxuOUZxbC8veEhS?=
 =?utf-8?B?cFBJbjRYenNjSWtiQkZZTXFBcXFXQ3RkUEhVUVhwWFkxVFJrQk5RSE5LbXFs?=
 =?utf-8?B?TTNVMTNiSElQSzNmdGtFN1BZaCs4YmpJZFpDT2t3RzdHeWxnRVJDcnJIWFhi?=
 =?utf-8?B?YW52ai8rQTVUSW80ejkzOW11QUlmVnhqSGFqUHFYMHlCNFRzR1dsNXdNbFlV?=
 =?utf-8?B?djJFWTlYK2dxVHZWMHdyVmIzUHR4SVQ3eHExZUYzaVZSalpzQk1lTHI2OE4w?=
 =?utf-8?B?SGdaY2NFS3E3YVlrMXhZcVlFaXNKaEJ5bkFLMFd2UmdQemxwdUQ3YS8rV3Bu?=
 =?utf-8?B?cE5mTlJJRUhhNVAwTzJXbHRtdG9pRlgwT0FRalk1UE5OUE1ubUd0Nk5nTXdC?=
 =?utf-8?B?YmtNYStxWSs1dG1NY214Q3grWVMwdzk2WDkrVkM5Q0dnbFVnR2xWWjBQdHhT?=
 =?utf-8?B?c25Wb2FzUUw2N2w5ZmN4azBPclQxTDlMbHVwbTFZeTNDQWZ6WnM1S0JaaXFC?=
 =?utf-8?B?dldzdDMxMEM0UVdhbjZKUjRRODc3U1YvRVRLWTlIMmY3Z1dvb01WR1FQeEww?=
 =?utf-8?B?YXRaL0RIcWdiblA4b1g2S05Cb01MNy84ZnJGcGhhaUR3d2J1V1BhVTl2dWgv?=
 =?utf-8?B?ZHFBQnJyK2V4bnFVQlRaQTNLQnBsL1BQZ1FGbEROR1NIT2dBNUt0bGFMajRq?=
 =?utf-8?B?eDNEOW9yYzBQTENMVXpjUThrQVIzZGdNSXpGZVUvbFViR2dab1NCaW9rOGFv?=
 =?utf-8?B?ZDRTMHNqbEdJd0paejFxSlBiWkwvZnFucm5yL0c3ZkQ4RVE1ZFh6WjhiajJT?=
 =?utf-8?B?c2FIWXc2WHRBeXZDRit1SXhsVTlGTDEwdzhJOG94aXdXOTBjYzFhQkVCR0tO?=
 =?utf-8?B?Sk4xSVVpUEl4bHZHakVCRzNYb2crU1BHQzRYRlFLSm13dUY4Ym5XNnRsTDVD?=
 =?utf-8?B?SHZTN3pKVkRueFlEYWtIWWkvc2dwQUVsbGx2RzZ4M040SXNPVmx0NndkR3E3?=
 =?utf-8?B?M00xcVJGZkMxMGROeTlHV1UydzZtUllOdFFYbnd1TXJRQnBMWGNuK3ppSkpO?=
 =?utf-8?B?eGxwUzF5dXRFSmt5dVV3VWpsSXVtcE5Eb0htbTVXZ2R3ZDFha3NIRHRFZ0NP?=
 =?utf-8?B?bDczUTJ1cXY3ZnQrbkpMSGhybEd1YjdBM1ZEdEcyZHNVR0NrMnd0dzVsbkU0?=
 =?utf-8?B?NGN5RnNjd3dWbXJvalpYb1Y1dHgrZXhLdTd0elo0aVZzVFdRUWVuaFNvM3dq?=
 =?utf-8?B?S3lEbWh2czlPcHZuN29EVnMrYS9iM2FGWnFmT1FKYmF3ZG9vTEllNzZsT3Jk?=
 =?utf-8?B?eUF5S3hRNVZsaHNvM01WSktESTJzL291SGR5TjBYUnl0UjJGcEJqTkNPVHEw?=
 =?utf-8?B?R1J0WkorRlZ5SHJGcG9qa1d4RlFIcEdGU1BGWEZUV3BVRmJkTjdydnJtVUNr?=
 =?utf-8?B?ays5cXlhWEV0YTJjTjZIZW5odktXaDBCb2h2R0RVbFJ5ZjJWWjRTY040WHlX?=
 =?utf-8?B?b3lzcE8wRUd0clVmYWZCbU9uUWxPTU9LUHpDOWZaMVlEVHU0RDViSlEyNy9u?=
 =?utf-8?B?WmlhN2o2UE5NRndEVVJZVjQxVk5Ca1BMcVViZ2hkUytDMWN6SzlMUHVKdTZO?=
 =?utf-8?B?dXBlbmVWOXZQWEltN0phd2F4QThYM3V1U1h3dUZ5NDVsL1hxb2krZHU5cVhl?=
 =?utf-8?B?eWtFWEFDUlI1RUhTM0lyQ0FTZEdUa2R5NUZOYjdKaGEzOHljUmQwbGJkYWt4?=
 =?utf-8?Q?2m8B+JF1FpDNJyBq/z0lutGJrESH6f94?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEt1emtUaHZUS1phaUlnelhDSFBYcjc0YnBjVjdKR2wzQzZna1MvdUNHZisy?=
 =?utf-8?B?enpESnBZYmVnRTV4Vm95SXRVWEw0V2dVekZrei9CV1MwamZwTk0yNzh6a05R?=
 =?utf-8?B?cTRTSGwwSytWQm11QXZMTk9mVFI0TFYvdEdQSVZFMGRwT0lwajdZN0c1TGFU?=
 =?utf-8?B?VXNzclJVQ2JRWVZDWHA4QU1oR3RZNlJaamhQZlY3V3hWZnJLbTFLTkhsTG9Q?=
 =?utf-8?B?OG1kSVV0R3dOdjQ1YkdTN21rRE5Ma3FITFhJSjU0NHpFdHF5NWxsdStJdVB2?=
 =?utf-8?B?dUhFcDBqWVphczROM0p6VWpFaVFsOTdQZ25XdGVNZTJuNlpEMkE1RlU3YWUr?=
 =?utf-8?B?YkFCVFVDemsrMityNWpMNzhCKyttYnQ3SUovVlJZZXBEd2wwNml6ZmliRk50?=
 =?utf-8?B?U21lZEI1N2lJYzNHUDJvZ3dCU3hrQStzS0F0Qk5hem10Y0EremMzcG5wVWtL?=
 =?utf-8?B?ajJUQ2tKb3RzVmZRbms0TTZmemxjbGp2alJzRFFta2hDbEFha2R6ZmVGTUdK?=
 =?utf-8?B?SjdQc2JnOXRBVUlsZFl1bHIxZmdkSFIyU0laMkZQdHhiVDV0ZGI0cWJrcmJs?=
 =?utf-8?B?TTVNVXZZTVlZckxhaUZCWDFGUmc4VEwzTlRNU2ZRNWlyZTNtOGhqdnhHUlhX?=
 =?utf-8?B?Z01FRG5CZ0tQODZoWlRtNGhweTN0RXcrYmJBdnRBSEEzZWVoYnhZSTRhbi9N?=
 =?utf-8?B?cHhtejFhMXdTSHhaUUR2OWRGMW1qdjJQU1YxVDgwNk5wZ0lRajAwTmhMM2cr?=
 =?utf-8?B?M2o2aXFBUzB5MVc3QzJ0d0x1Yk1oYXltQlFWRXQ1YWFYTlZ6UzFLdHJTSmdV?=
 =?utf-8?B?MVZEcGV4dTl2R3NRaW93V0M4L2F6RE56U2VjYnJYczA4Y3g1VlFKbDFMRk14?=
 =?utf-8?B?UmxLSkJWV0RzYmpLUVNmb2lPdktyR1dpWHB4OE9nemVHTGpjSXFLMEpMa1BU?=
 =?utf-8?B?VCtCUDlReXpYUXVoZU9FVC9CTklndDNKd3VUUHVKdjVyNDQxL0ErL3diQVQ5?=
 =?utf-8?B?QjU0ZmF1aDRKeXZBUnFjMWNUSFg4VGRiSENLcmo3Mkg4K25uUHVuT1EvTnJE?=
 =?utf-8?B?N2hMYms0aFF0MWdTREc5UkwxL2pyZG5FMjhuR2k4dDRDMHRqNHdmM0xFbFlV?=
 =?utf-8?B?YmpuYWo0ZEZWelNlK1d0a09YcFF5amRQMFBVWndNeTJoZk1HY1hZWXlEbmE1?=
 =?utf-8?B?bHRlUXhoUDZiZDFkTXkvcVhFU2hHbHhaTk8rd0ZmMG9QblFIVDVhbUk3a01h?=
 =?utf-8?B?eDUwYWtxcGlTMmpwZThZZmFvS2lWb1VkWVR2cm5IWWVpZnI2Z2pwT3V0bjhQ?=
 =?utf-8?B?VWpmeEVtSStDanU2V3cxMGhmS3hyRGJTMlVYRHJoNDd1SitkaVl2eko3dGEv?=
 =?utf-8?B?d0MvMWM5bHpNUGpCUWNBaE9YQlJHTk1BcFJnSEM1aGNzVFp4bzJIRHltbFlu?=
 =?utf-8?B?MHBhVDFxTlRiN05NNFZaTHk0bG12RzJsdXFRT1pOSGlZSzEydGc1RHA2ZWNs?=
 =?utf-8?B?NHRzQlVTOWFmOWk4RDhnZ2h4R1FLS2lsekpRU0Qwek51dkdjbXdUYnM3Vnkr?=
 =?utf-8?B?cGpRK1pydzVRTGMxVHkzQXVWeXBNNnZCSHRXcEpRbmVCeDZVMlNWVjFnTnZP?=
 =?utf-8?B?bTBVa3ZvR09JUHlZMTdRWWVNK2c5azlyQmZSRGk3Mk9CRTQyNFBXdENhZGox?=
 =?utf-8?B?bEdIckpWelpPeVNXZWJ4Tmo4eGpUcVUvUSt6WkZBR3I3T2s4N2NuZVViZGxB?=
 =?utf-8?B?UFhsaDIxVllRckU2Q3FJb0FtN2gvMlkyOFBibVowcm1RbTUzMTlmMFg1ZWFS?=
 =?utf-8?B?SEY5QnF5dkN5cXMzaTN1UEZxeXczcldIMS9aei9DL1k3SHdEd1VNK1NGeSs1?=
 =?utf-8?B?MnQ3d1A0ZjlJeHRGNDhwSmM0cU5mMGdXRklwaXRTQzArcGdXcnFjQzl2TUxn?=
 =?utf-8?B?UjZTcm5heUxhSU1RejlOZ0M4SldjKzV6QjdNc29oTXBTcVhtV2hTL1h2NXU3?=
 =?utf-8?B?ZXRNT3FDT1AvbU9qK25VUzNUOUJ3ZkhFM3JFaG5Cc3lKenhPcTRZNm1lTVF2?=
 =?utf-8?B?Sm9rd05jSVkyVEhKVVJOaVAzMXhaNFdCMzd3SHdpbU5nL0ZmZEI4aTEzdzgw?=
 =?utf-8?Q?Bc4iBEVe/5N85+Caml0t3QzXd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ccae65-29ec-48c4-c860-08de1282fc8a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 22:24:52.7143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I65tLRMQ7NwuoihjMBlyrNlRyugu2kN3ZP6XdtuEKORh/U3aN4rNByY10uwxjZnXLRHPwRjcJk+P43MjNkfL6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765



On 10/18/2025 10:46 AM, Alok Tiwari wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Use %pe instead of %ps when printing ERR_PTR() values. %ps is intended
> for string pointers, while %pe correctly prints symbolic error names
> for error pointers returned via ERR_PTR().
> This shows the returned error value more clearly.
> 
> Fixes: 67f27b8b3a34 ("pds_vdpa: subscribe to the pds_core events")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>   drivers/vdpa/pds/vdpa_dev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

LGTM. Thanks.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>

> 
> diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
> index 36f61cc96e21..43426bd971ac 100644
> --- a/drivers/vdpa/pds/vdpa_dev.c
> +++ b/drivers/vdpa/pds/vdpa_dev.c
> @@ -51,7 +51,7 @@ static int pds_vdpa_register_event_handler(struct pds_vdpa_device *pdsv)
>                  err = pdsc_register_notify(nb);
>                  if (err) {
>                          nb->notifier_call = NULL;
> -                       dev_err(dev, "failed to register pds event handler: %ps\n",
> +                       dev_err(dev, "failed to register pds event handler: %pe\n" >                                  ERR_PTR(err));
>                          return -EINVAL;
>                  }
> --
> 2.50.1
> 
